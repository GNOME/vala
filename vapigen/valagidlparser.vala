/* valagidlparser.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;
using Gee;

/**
 * Code visitor parsing all GIDL files.
 */
public class Vala.GIdlParser : CodeVisitor {
	private CodeContext context;

	private SourceFile current_source_file;

	private SourceReference current_source_reference;
	
	private Namespace current_namespace;
	private Typesymbol current_data_type;
	private Map<string,string> codenode_attributes_map;
	private Map<PatternSpec*,string> codenode_attributes_patterns;
	private Gee.Set<string> current_type_symbol_set;

	private Map<string,Typesymbol> cname_type_map;

	/**
	 * Parse all source files in the specified code context and build a
	 * code tree.
	 *
	 * @param context a code context
	 */
	public void parse (CodeContext! context) {
		cname_type_map = new HashMap<string,Typesymbol> (str_hash, str_equal);

		this.context = context;
		context.accept (this);

		cname_type_map = null;
	}

	public override void visit_namespace (Namespace! ns) {
		ns.accept_children (this);
	}

	public override void visit_class (Class! cl) {
		visit_type (cl);
	}

	public override void visit_struct (Struct! st) {
		visit_type (st);
	}

	public override void visit_interface (Interface! iface) {
		visit_type (iface);
	}

	public override void visit_enum (Enum! en) {
		visit_type (en);
	}

	public override void visit_delegate (Delegate! d) {
		visit_type (d);
	}

	private void visit_type (Typesymbol! t) {
		if (!cname_type_map.contains (t.get_cname ())) {
			cname_type_map[t.get_cname ()] = t;
		}
	}

	public override void visit_source_file (SourceFile! source_file) {
		if (source_file.filename.has_suffix (".gi")) {
			parse_file (source_file);
		}
	}
	
	private void parse_file (SourceFile! source_file) {
		string metadata_filename = "%s.metadata".printf (source_file.filename.ndup (source_file.filename.size () - ".gi".size ()));

		current_source_file = source_file;

		codenode_attributes_map = new HashMap<string,string> (str_hash, str_equal);
		codenode_attributes_patterns = new HashMap<pointer,string> (direct_hash, PatternSpec.equal);

		if (FileUtils.test (metadata_filename, FileTest.EXISTS)) {
			try {
				string metadata;
				ulong metadata_len;
				FileUtils.get_contents (metadata_filename, out metadata, out metadata_len);
				
				foreach (string line in metadata.split ("\n")) {
					if (line.has_prefix ("#")) {
						// ignore comment lines
						continue;
					}

					var tokens = line.split (" ", 2);

					if (null == tokens[0]) {
						continue;
					}

					if (null != tokens[0].chr (-1, '*')) {
						PatternSpec pattern = new PatternSpec (tokens[0]);
						codenode_attributes_patterns[#pattern] = tokens[0];
					}
					
					codenode_attributes_map[tokens[0]] = tokens[1];
				}
			} catch (FileError e) {
				Report.error (null, "Unable to read metadata file: %s".printf (e.message));
			}
		}
	
		try {
			var modules = Idl.parse_file (source_file.filename);
			
			current_source_reference = new SourceReference (source_file);
			
			foreach (weak IdlModule module in modules) {
				var ns = parse_module (module);
				if (ns != null) {
					context.root.add_namespace (ns);
				}
			}
		} catch (MarkupError e) {
			stdout.printf ("error parsing GIDL file: %s\n", e.message);
		}
	}

	private string! fix_type_name (string! type_name, Namespace! ns) {
		var attributes = get_attributes (type_name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "name") {
					return eval (nv[1]);
				}
			}
		}

		if (type_name.has_prefix (ns.name)) {
			return type_name.offset (ns.name.len ());
		} else if (ns.name == "GLib" && type_name.has_prefix ("G")) {
			return type_name.offset (1);
		} else  {
			string best_match = null;
			foreach (string cprefix in ns.get_cprefixes ()) {
				if (type_name.has_prefix (cprefix)) {
					if (best_match == null || cprefix.len () > best_match.len ())
						best_match = cprefix;
				}
			}

			if (best_match != null) {
				return type_name.offset (best_match.len ());;
			}
		}

		return type_name;
	}

	private string! fix_const_name (string! const_name, Namespace! ns) {
		if (const_name.has_prefix (ns.name.up () + "_")) {
			return const_name.offset (ns.name.len () + 1);
		} else if (ns.name == "GLib" && const_name.has_prefix ("G_")) {
			return const_name.offset (2);
		}
		return const_name;
	}

	private Namespace parse_module (IdlModule! module) {
		Symbol sym = context.root.scope.lookup (module.name);
		Namespace ns;
		if (sym is Namespace) {
			ns = (Namespace) sym;
			ns.pkg = false;
		} else {
			ns = new Namespace (module.name, current_source_reference);
		}

		current_namespace = ns;

		var attributes = get_attributes (ns.name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "cheader_filename") {
					ns.set_cheader_filename (eval (nv[1]));
				} else if (nv[0] == "cprefix") {
					var cprefixes = eval (nv[1]).split (",");
					foreach(string name in cprefixes) {
						ns.add_cprefix (name);
					}
				} else if (nv[0] == "lower_case_cprefix") {
					ns.set_lower_case_cprefix (eval (nv[1]));
				}
			}
		}
		
		foreach (weak IdlNode node in module.entries) {
			if (node.type == IdlNodeTypeId.CALLBACK) {
				var cb = parse_delegate ((IdlNodeFunction) node);
				if (cb == null) {
					continue;
				}
				cb.name = fix_type_name (cb.name, ns);
				ns.add_delegate (cb);
				current_source_file.add_node (cb);
			} else if (node.type == IdlNodeTypeId.STRUCT) {
				parse_struct ((IdlNodeStruct) node, ns, module);
			} else if (node.type == IdlNodeTypeId.UNION) {
				parse_union ((IdlNodeUnion) node, ns, module);
			} else if (node.type == IdlNodeTypeId.BOXED) {
				parse_boxed ((IdlNodeBoxed) node, ns, module);
			} else if (node.type == IdlNodeTypeId.ENUM) {
				var en = parse_enum ((IdlNodeEnum) node);
				if (en == null) {
					continue;
				}
				en.name = fix_type_name (en.name, ns);
				ns.add_enum (en);
				current_source_file.add_node (en);
			} else if (node.type == IdlNodeTypeId.FLAGS) {
				var en = parse_enum ((IdlNodeEnum) node);
				if (en == null) {
					continue;
				}
				en.name = fix_type_name (en.name, ns);
				en.is_flags = true;
				ns.add_enum (en);
				current_source_file.add_node (en);
			} else if (node.type == IdlNodeTypeId.OBJECT) {
				parse_object ((IdlNodeInterface) node, ns, module);
			} else if (node.type == IdlNodeTypeId.INTERFACE) {
				parse_interface ((IdlNodeInterface) node, ns, module);
			} else if (node.type == IdlNodeTypeId.CONSTANT) {
				var c = parse_constant ((IdlNodeConstant) node);
				c.name = fix_const_name (c.name, ns);
				ns.add_constant (c);
				current_source_file.add_node (c);
			} else if (node.type == IdlNodeTypeId.FUNCTION) {
				var m = parse_function ((IdlNodeFunction) node);
				if (m != null) {
					m.instance = false;
					ns.add_method (m);
					current_source_file.add_node (m);
				}
			}
		}

		current_namespace = null;

		if (sym is Namespace) {
			return null;
		}
		return ns;
	}
	
	private Delegate parse_delegate (IdlNodeFunction! f_node) {
		weak IdlNode node = (IdlNode) f_node;

		var attributes = get_attributes (node.name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				}
			}
		}
	
		var cb = new Delegate (node.name, parse_param (f_node.result), current_source_reference);
		cb.access = SymbolAccessibility.PUBLIC;
		
		foreach (weak IdlNodeParam param in f_node.parameters) {
			weak IdlNode param_node = (IdlNode) param;

			if (param_node.name == "user_data") {
				// hide user_data parameter for instance delegates
				cb.instance = true;
			} else {
				var p = new FormalParameter (param_node.name, parse_param (param));
				cb.add_parameter (p);
			}
		}
		
		return cb;
	}

	private bool is_reference_type (string! cname) {
		var st_attributes = get_attributes (cname);
		if (st_attributes != null) {
			foreach (string attr in st_attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "is_value_type" && eval (nv[1]) == "1") {
					return false;
				}
			}
		}
		return true;
	}

	private void parse_struct (IdlNodeStruct! st_node, Namespace! ns, IdlModule! module) {
		weak IdlNode node = (IdlNode) st_node;
		
		if (st_node.deprecated) {
			return;
		}

		string name = fix_type_name (node.name, ns);

		if (!is_reference_type (node.name)) {
			var st = ns.scope.lookup (name) as Struct;
			if (st == null) {
				st = new Struct (name, current_source_reference);
				st.access = SymbolAccessibility.PUBLIC;

				var st_attributes = get_attributes (node.name);
				if (st_attributes != null) {
					foreach (string attr in st_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							st.add_cheader_filename (eval (nv[1]));
						} else if (nv[0] == "hidden") {
							if (eval (nv[1]) == "1") {
								return;
							}
						} else if (nv[0] == "simple_type") {
							if (eval (nv[1]) == "1") {
								st.set_simple_type (true);
							}
						}
					}
				}

				ns.add_struct (st);
				current_source_file.add_node (st);
			}

			current_data_type = st;

			foreach (weak IdlNode member in st_node.members) {
				if (member.type == IdlNodeTypeId.FUNCTION) {
					var m = parse_function ((IdlNodeFunction) member);
					if (m != null) {
						st.add_method (m);
					}
				} else if (member.type == IdlNodeTypeId.FIELD) {
					var f = parse_field ((IdlNodeField) member);
					if (f != null) {
						st.add_field (f);
					}
				}
			}

			current_data_type = null;
		} else {
			var cl = ns.scope.lookup (name) as Class;
			if (cl == null) {
				string base_class = null;

				cl = new Class (name, current_source_reference);
				cl.access = SymbolAccessibility.PUBLIC;

				var cl_attributes = get_attributes (node.name);
				if (cl_attributes != null) {
					foreach (string attr in cl_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							cl.add_cheader_filename (eval (nv[1]));
						} else if (nv[0] == "base_class") {
							base_class = eval (nv[1]);
						} else if (nv[0] == "hidden") {
							if (eval (nv[1]) == "1") {
								return;
							}
						}
					}
				}

				ns.add_class (cl);
				current_source_file.add_node (cl);

				if (base_class != null) {
					var parent = new UnresolvedType ();
					parse_type_string (parent, base_class);
					cl.add_base_type (parent);
				}
			}

			current_data_type = cl;

			string ref_function = null;
			string unref_function = null;
			string copy_function = null;
			string free_function = null;

			foreach (weak IdlNode member in st_node.members) {
				if (member.type == IdlNodeTypeId.FUNCTION) {
					if (member.name == "ref") {
						ref_function = ((IdlNodeFunction) member).symbol;
					} else if (member.name == "unref") {
						unref_function = ((IdlNodeFunction) member).symbol;
					} else if (member.name == "free" || member.name == "destroy") {
						free_function = ((IdlNodeFunction) member).symbol;
					} else {
						if (member.name == "copy") {
							copy_function = ((IdlNodeFunction) member).symbol;
						}
						var m = parse_function ((IdlNodeFunction) member);
						if (m != null) {
							cl.add_method (m);
						}
					}
				} else if (member.type == IdlNodeTypeId.FIELD) {
					var f = parse_field ((IdlNodeField) member);
					if (f != null) {
						cl.add_field (f);
					}
				}
			}

			if (ref_function != null) {
				cl.set_ref_function (ref_function);
			}
			if (copy_function != null) {
				cl.set_dup_function (copy_function);
			}
			if (unref_function != null) {
				cl.set_unref_function (unref_function);
			} else if (free_function != null) {
				cl.set_free_function (free_function);
			}

			current_data_type = null;
		}
	}

	private void parse_union (IdlNodeUnion! un_node, Namespace! ns, IdlModule! module) {
		weak IdlNode node = (IdlNode) un_node;
		
		if (un_node.deprecated) {
			return;
		}

		string name = fix_type_name (node.name, ns);

		if (!is_reference_type (node.name)) {
			var st = ns.scope.lookup (name) as Struct;
			if (st == null) {
				st = new Struct (name, current_source_reference);
				st.access = SymbolAccessibility.PUBLIC;

				var st_attributes = get_attributes (node.name);
				if (st_attributes != null) {
					foreach (string attr in st_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							st.add_cheader_filename (eval (nv[1]));
						} else if (nv[0] == "hidden") {
							if (eval (nv[1]) == "1") {
								return;
							}
						}
					}
				}

				ns.add_struct (st);
				current_source_file.add_node (st);
			}

			current_data_type = st;

			foreach (weak IdlNode member in un_node.members) {
				if (member.type == IdlNodeTypeId.FUNCTION) {
					var m = parse_function ((IdlNodeFunction) member);
					if (m != null) {
						st.add_method (m);
					}
				} else if (member.type == IdlNodeTypeId.FIELD) {
					var f = parse_field ((IdlNodeField) member);
					if (f != null) {
						st.add_field (f);
					}
				}
			}

			current_data_type = null;
		} else {
			var cl = ns.scope.lookup (name) as Class;
			if (cl == null) {
				cl = new Class (name, current_source_reference);
				cl.access = SymbolAccessibility.PUBLIC;

				var cl_attributes = get_attributes (node.name);
				if (cl_attributes != null) {
					foreach (string attr in cl_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							cl.add_cheader_filename (eval (nv[1]));
						} else if (nv[0] == "hidden") {
							if (eval (nv[1]) == "1") {
								return;
							}
						}
					}
				}

				ns.add_class (cl);
				current_source_file.add_node (cl);
			}

			current_data_type = cl;

			string ref_function = null;
			string unref_function = null;
			string copy_function = null;
			string free_function = null;

			foreach (weak IdlNode member in un_node.members) {
				if (member.type == IdlNodeTypeId.FUNCTION) {
					if (member.name == "ref") {
						ref_function = ((IdlNodeFunction) member).symbol;
					} else if (member.name == "unref") {
						unref_function = ((IdlNodeFunction) member).symbol;
					} else if (member.name == "free" || member.name == "destroy") {
						free_function = ((IdlNodeFunction) member).symbol;
					} else {
						if (member.name == "copy") {
							copy_function = ((IdlNodeFunction) member).symbol;
						}
						var m = parse_function ((IdlNodeFunction) member);
						if (m != null) {
							cl.add_method (m);
						}
					}
				} else if (member.type == IdlNodeTypeId.FIELD) {
					var f = parse_field ((IdlNodeField) member);
					if (f != null) {
						cl.add_field (f);
					}
				}
			}

			if (ref_function != null) {
				cl.set_ref_function (ref_function);
			}
			if (copy_function != null) {
				cl.set_dup_function (copy_function);
			}
			if (unref_function != null) {
				cl.set_unref_function (unref_function);
			} else if (free_function != null) {
				cl.set_free_function (free_function);
			}

			current_data_type = null;
		}
	}
	
	private void parse_boxed (IdlNodeBoxed! boxed_node, Namespace! ns, IdlModule! module) {
		weak IdlNode node = (IdlNode) boxed_node;
	
		string name = fix_type_name (node.name, ns);

		if (!is_reference_type (node.name)) {
			var st = ns.scope.lookup (name) as Struct;
			if (st == null) {
				st = new Struct (name, current_source_reference);
				st.access = SymbolAccessibility.PUBLIC;

				var st_attributes = get_attributes (node.name);
				if (st_attributes != null) {
					foreach (string attr in st_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							st.add_cheader_filename (eval (nv[1]));
						}
					}
				}

				ns.add_struct (st);
				st.set_type_id (st.get_upper_case_cname ("TYPE_"));
				current_source_file.add_node (st);
			}
		
			current_data_type = st;

			foreach (weak IdlNode member in boxed_node.members) {
				if (member.type == IdlNodeTypeId.FUNCTION) {
					var m = parse_function ((IdlNodeFunction) member);
					if (m != null) {
						st.add_method (m);
					}
				} else if (member.type == IdlNodeTypeId.FIELD) {
					var f = parse_field ((IdlNodeField) member);
					if (f != null) {
						st.add_field (f);
					}
				}
			}

			current_data_type = null;
		} else {
			var cl = ns.scope.lookup (name) as Class;
			if (cl == null) {
				cl = new Class (name, current_source_reference);
				cl.access = SymbolAccessibility.PUBLIC;

				var cl_attributes = get_attributes (node.name);
				if (cl_attributes != null) {
					foreach (string attr in cl_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							cl.add_cheader_filename (eval (nv[1]));
						}
					}
				}

				ns.add_class (cl);
				cl.set_type_id (cl.get_upper_case_cname ("TYPE_"));
				current_source_file.add_node (cl);
			}

			var parent = new UnresolvedType ();
			parent.namespace_name = "GLib";
			parent.type_name = "Boxed";
			cl.add_base_type (parent);

			current_data_type = cl;

			string ref_function = null;
			string unref_function = null;
			string copy_function = null;
			string free_function = null;

			foreach (weak IdlNode member in boxed_node.members) {
				if (member.type == IdlNodeTypeId.FUNCTION) {
					if (member.name == "ref") {
						ref_function = ((IdlNodeFunction) member).symbol;
					} else if (member.name == "unref") {
						unref_function = ((IdlNodeFunction) member).symbol;
					} else if (member.name == "free" || member.name == "destroy") {
						free_function = ((IdlNodeFunction) member).symbol;
					} else {
						if (member.name == "copy") {
							copy_function = ((IdlNodeFunction) member).symbol;
						}
						var m = parse_function ((IdlNodeFunction) member);
						if (m != null) {
							cl.add_method (m);
						}
					}
				} else if (member.type == IdlNodeTypeId.FIELD) {
					var f = parse_field ((IdlNodeField) member);
					if (f != null) {
						cl.add_field (f);
					}
				}
			}

			if (ref_function != null) {
				cl.set_ref_function (ref_function);
			}
			if (copy_function != null) {
				cl.set_dup_function (copy_function);
			}
			if (unref_function != null) {
				cl.set_unref_function (unref_function);
			} else if (free_function != null) {
				cl.set_free_function (free_function);
			}

			current_data_type = null;
		}
	}
	
	private Enum parse_enum (IdlNodeEnum! en_node) {
		weak IdlNode node = (IdlNode) en_node;
	
		var en = new Enum (node.name, current_source_reference);
		en.access = SymbolAccessibility.PUBLIC;
		
		string common_prefix = null;
		
		foreach (weak IdlNode value in en_node.values) {
			if (common_prefix == null) {
				common_prefix = value.name;
				while (common_prefix.len () > 0 && !common_prefix.has_suffix ("_")) {
					// FIXME: could easily be made faster
					common_prefix = common_prefix.ndup (common_prefix.size () - 1);
				}
			} else {
				while (!value.name.has_prefix (common_prefix)) {
					common_prefix = common_prefix.ndup (common_prefix.size () - 1);
				}
			}
			while (common_prefix.len () > 0 && (!common_prefix.has_suffix ("_") ||
			       (value.name.offset (common_prefix.size ()).get_char ().isdigit ()) && (value.name.len () - common_prefix.len ()) <= 1)) {
				// enum values may not consist solely of digits
				common_prefix = common_prefix.ndup (common_prefix.size () - 1);
			}
		}

		var en_attributes = get_attributes (node.name);
		if (en_attributes != null) {
			foreach (string attr in en_attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "common_prefix") {
					common_prefix = eval (nv[1]);
				} else if (nv[0] == "cheader_filename") {
					en.add_cheader_filename (eval (nv[1]));
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				} else if (nv[0] == "rename_to") {
					en.name = eval (nv[1]);
				}
			}
		}

		en.set_cprefix (common_prefix);
		
		foreach (weak IdlNode value2 in en_node.values) {
			var ev = new EnumValue (value2.name.offset (common_prefix.len ()));
			en.add_value (ev);
		}
		
		return en;
	}
	
	private void parse_object (IdlNodeInterface! node, Namespace! ns, IdlModule! module) {
		string name = fix_type_name (((IdlNode) node).name, ns);

		string base_class = null;

		var cl = ns.scope.lookup (name) as Class;
		if (cl == null) {
			cl = new Class (name, current_source_reference);
			cl.access = SymbolAccessibility.PUBLIC;
			
			var attributes = get_attributes (node.gtype_name);
			if (attributes != null) {
				foreach (string attr in attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "cheader_filename") {
						cl.add_cheader_filename (eval (nv[1]));
					} else if (nv[0] == "base_class") {
						base_class = eval (nv[1]);
					} else if (nv[0] == "hidden") {
						if (eval (nv[1]) == "1") {
							return;
						}
					}
				}
			}

			ns.add_class (cl);
			current_source_file.add_node (cl);
		}

		if (base_class != null) {
			var parent = new UnresolvedType ();
			parse_type_string (parent, base_class);
			cl.add_base_type (parent);
		} else if (node.parent != null) {
			var parent = new UnresolvedType ();
			parse_type_string (parent, node.parent);
			cl.add_base_type (parent);
		} else {
			var parent = new UnresolvedType ();
			parent.namespace_name = "GLib";
			parent.type_name = "Object";
			cl.add_base_type (parent);
		}
		
		foreach (string iface_name in node.interfaces) {
			var iface = new UnresolvedType ();
			parse_type_string (iface, iface_name);
			cl.add_base_type (iface);
		}
		
		current_data_type = cl;
		
		current_type_symbol_set = new HashSet<string> (str_hash, str_equal);
		var current_type_func_map = new HashMap<string,weak IdlNodeFunction> (str_hash, str_equal);
		var current_type_vfunc_map = new HashMap<string,string> (str_hash, str_equal);
		
		foreach (weak IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.FUNCTION) {
				current_type_func_map.set (member.name, (IdlNodeFunction) member);
			}
			if (member.type == IdlNodeTypeId.VFUNC) {
				current_type_vfunc_map.set (member.name, "1");
			}
		}

		foreach (weak IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.FUNCTION) {
				// Ignore if vfunc (handled below) 
				if (!current_type_vfunc_map.contains (member.name)) {
					var m = parse_function ((IdlNodeFunction) member);
					if (m != null) {
						cl.add_method (m);
					}
				}
			} else if (member.type == IdlNodeTypeId.VFUNC) {
				var m = parse_virtual ((IdlNodeVFunc) member, current_type_func_map.get (member.name));
				if (m != null) {
					cl.add_method (m);
				}
			} else if (member.type == IdlNodeTypeId.PROPERTY) {
				var prop = parse_property ((IdlNodeProperty) member);
				if (prop != null) {
					cl.add_property (prop, true);
				}
			} else if (member.type == IdlNodeTypeId.SIGNAL) {
				var sig = parse_signal ((IdlNodeSignal) member);
				if (sig != null) {
					cl.add_signal (sig);
				}
			}
		}
		
		foreach (weak IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.FIELD) {
				if (!current_type_symbol_set.contains (member.name)) {
					var f = parse_field ((IdlNodeField) member);
					if (f != null) {
						cl.add_field (f);
					}
				}
			}
		}
		
		foreach (Property prop in cl.get_properties ()) {
			var getter = "get_%s".printf (prop.name);
			
			if (prop.get_accessor != null && !current_type_symbol_set.contains (getter)) {
				prop.no_accessor_method = true;
			}
			
			var setter = "set_%s".printf (prop.name);
			
			if (prop.set_accessor != null && !current_type_symbol_set.contains (setter)) {
				prop.no_accessor_method = true;
			}
		}
		
		current_data_type = null;
		current_type_symbol_set = null;
	}

	private void parse_interface (IdlNodeInterface! node, Namespace! ns, IdlModule! module) {
		string name = fix_type_name (node.gtype_name, ns);

		var iface = ns.scope.lookup (name) as Interface;
		if (iface == null) {
			iface = new Interface (name, current_source_reference);
			iface.access = SymbolAccessibility.PUBLIC;
			
			var attributes = get_attributes (node.gtype_name);
			if (attributes != null) {
				foreach (string attr in attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "cheader_filename") {
						iface.add_cheader_filename (eval (nv[1]));
					}
				}
			}
			
			foreach (string prereq_name in node.prerequisites) {
				var prereq = new UnresolvedType ();
				parse_type_string (prereq, prereq_name);
				iface.add_prerequisite (prereq);
			}

			ns.add_interface (iface);
			current_source_file.add_node (iface);
		}

		current_data_type = iface;

		var current_type_func_map = new HashMap<string,weak IdlNodeFunction> (str_hash, str_equal);
		var current_type_vfunc_map = new HashMap<string,string> (str_hash, str_equal);

		foreach (weak IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.FUNCTION) {
				current_type_func_map.set (member.name, (IdlNodeFunction) member);
			}
			if (member.type == IdlNodeTypeId.VFUNC) {
				current_type_vfunc_map.set (member.name, "1");
			}
		}

		foreach (weak IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.FUNCTION) {
				// Ignore if vfunc (handled below) 
				if (!current_type_vfunc_map.contains (member.name)) {
					var m = parse_function ((IdlNodeFunction) member, true);
					if (m != null) {
						iface.add_method (m);
			        	}
				}
			} else if (member.type == IdlNodeTypeId.VFUNC) {
				var m = parse_virtual ((IdlNodeVFunc) member, current_type_func_map.get (member.name), true);
				if (m != null) {
					iface.add_method (m);
				}
			} else if (member.type == IdlNodeTypeId.PROPERTY) {
				var prop = parse_property ((IdlNodeProperty) member);
				if (prop != null) {
					iface.add_property (prop);
				}
			} else if (member.type == IdlNodeTypeId.SIGNAL) {
				var sig = parse_signal ((IdlNodeSignal) member);
				if (sig != null) {
					iface.add_signal (sig);
				}
			}
		}

		current_data_type = null;
	}
	
	private UnresolvedType parse_type (IdlNodeType! type_node) {
		var type = new UnresolvedType ();
		if (type_node.tag == TypeTag.VOID) {
			if (type_node.is_pointer) {
				type.type_name = "pointer";
			} else {
				type.type_name = "void";
			}
		} else if (type_node.tag == TypeTag.BOOLEAN) {
			type.type_name = "bool";
		} else if (type_node.tag == TypeTag.INT8) {
			type.type_name = "char";
		} else if (type_node.tag == TypeTag.UINT8) {
			type.type_name = "uchar";
		} else if (type_node.tag == TypeTag.INT16) {
			type.type_name = "short";
		} else if (type_node.tag == TypeTag.UINT16) {
			type.type_name = "ushort";
		} else if (type_node.tag == TypeTag.INT32) {
			type.type_name = "int";
		} else if (type_node.tag == TypeTag.UINT32) {
			type.type_name = "uint";
		} else if (type_node.tag == TypeTag.INT64) {
			type.type_name = "int64";
		} else if (type_node.tag == TypeTag.UINT64) {
			type.type_name = "uint64";
		} else if (type_node.tag == TypeTag.INT) {
			type.type_name = "int";
		} else if (type_node.tag == TypeTag.UINT) {
			type.type_name = "uint";
		} else if (type_node.tag == TypeTag.LONG) {
			type.type_name = "long";
		} else if (type_node.tag == TypeTag.ULONG) {
			type.type_name = "ulong";
		} else if (type_node.tag == TypeTag.SSIZE) {
			type.type_name = "long";
		} else if (type_node.tag == TypeTag.SIZE) {
			type.type_name = "ulong";
		} else if (type_node.tag == TypeTag.FLOAT) {
			type.type_name = "float";
		} else if (type_node.tag == TypeTag.DOUBLE) {
			type.type_name = "double";
		} else if (type_node.tag == TypeTag.UTF8) {
			type.type_name = "string";
		} else if (type_node.tag == TypeTag.FILENAME) {
			type.type_name = "string";
		} else if (type_node.tag == TypeTag.ARRAY) {
			type = parse_type (type_node.parameter_type1);
			type.array_rank = 1;
		} else if (type_node.tag == TypeTag.LIST) {
			type.namespace_name = "GLib";
			type.type_name = "List";
		} else if (type_node.tag == TypeTag.SLIST) {
			type.namespace_name = "GLib";
			type.type_name = "SList";
		} else if (type_node.tag == TypeTag.HASH) {
			type.namespace_name = "GLib";
			type.type_name = "HashTable";
		} else if (type_node.tag == TypeTag.ERROR) {
			type.namespace_name = "GLib";
			type.type_name = "Error";
		} else if (type_node.is_interface) {
			var n = type_node.@interface;
			
			if (n == "") {
				return null;
			}
			
			if (n.has_prefix ("const-")) {
				n = n.offset ("const-".len ());
			}

			if (type_node.is_pointer &&
			    (n == "gchar" || n == "char")) {
				type.type_name = "string";
				if (type_node.unparsed.has_suffix ("**")) {
					type.is_out = true;
				}
			} else if (n == "gunichar") {
				type.type_name = "unichar";
			} else if (n == "gchar") {
				type.type_name = "char";
			} else if (n == "guchar" || n == "guint8") {
				type.type_name = "uchar";
				if (type_node.is_pointer) {
					type.array_rank = 1;
				}
			} else if (n == "gushort") {
				type.type_name = "ushort";
			} else if (n == "gshort") {
				type.type_name = "short";
			} else if (n == "gconstpointer" || n == "void") {
				type.type_name = "pointer";
			} else if (n == "goffset" || n == "off_t") {
				type.type_name = "int64";
			} else if (n == "value_array") {
				type.namespace_name = "GLib";
				type.type_name = "ValueArray";
			} else if (n == "time_t") {
				type.type_name = "ulong";
			} else if (n == "socklen_t") {
				type.type_name = "uint32";
			} else if (n == "mode_t") {
				type.type_name = "uint";
			} else if (n == "gint" || n == "pid_t") {
				type.type_name = "int";
			} else if (n == "unsigned" || n == "unsigned-int") {
				type.type_name = "uint";
			} else if (n == "FILE") {
				type.namespace_name = "GLib";
				type.type_name = "FileStream";
			} else if (n == "struct") {
				type.type_name = "pointer";
			} else if (n == "iconv_t") {
				type.type_name = "pointer";
			} else if (n == "GType") {
				type.namespace_name = "GLib";
				type.type_name = "Type";
				if (type_node.is_pointer) {
					type.array_rank = 1;
				}
			} else {
				parse_type_string (type, n);
				if (is_simple_type (n)) {
					if (type_node.is_pointer) {
						type.is_out = true;
					}
				} else if (type_node.unparsed.has_suffix ("**")) {
					type.is_out = true;
				}
			}
		} else {
			stdout.printf ("%d\n", type_node.tag);
		}
		return type;
	}
	
	private bool is_simple_type (string! type_name) {
		var st = cname_type_map[type_name] as Struct;
		if (st != null && st.is_simple_type ()) {
			return true;
		}

		return false;
	}
	
	private void parse_type_string (UnresolvedType! type, string! n) {
		var dt = cname_type_map[n];
		if (dt != null) {
			type.namespace_name = dt.parent_symbol.name;
			type.type_name = dt.name;
			return;
		}

		var type_attributes = get_attributes (n);

		if (null != type_attributes) {
			foreach (string attr in type_attributes) {
				var nv = attr.split ("=", 2);

				if (nv[0] == "cprefix") {
					type.type_name = n.offset (eval (nv[1]).len ());
				} else if (nv[0] == "name") {
					type.type_name = eval (nv[1]);
				} else if (nv[0] == "namespace") {
					type.namespace_name = eval (nv[1]);
				} else if (nv[0] == "rename_to") {
					type.type_name = eval (nv[1]);
				}
			}
		}

		if (type.type_name != null) {
			return;
		}

		if (n == "va_list") {
			// unsupported
			type.type_name = "pointer";
		} else if (n.has_prefix (current_namespace.name)) {
			type.namespace_name = current_namespace.name;
			type.type_name = n.offset (current_namespace.name.len ());
		} else if (n.has_prefix ("G")) {
			type.namespace_name = "GLib";
			type.type_name = n.offset (1);
		} else {
			var name_parts = n.split (".", 2);
			if (name_parts[1] == null) {
				type.type_name = name_parts[0];
			} else {
				type.namespace_name = name_parts[0];
				type.type_name = name_parts[1];
			}
		}
	}
	
	private UnresolvedType parse_param (IdlNodeParam! param) {
		var type = parse_type (param.type);

		// disable for now as null_ok not yet correctly set
		// type.non_null = !param.null_ok;
		
		return type;
	}
	
	private Method create_method (string name, string symbol, IdlNodeParam res, GLib.List<IdlNodeParam> parameters, bool is_constructor, bool is_interface) {
		UnresolvedType return_type = null;
		if (res != null) {
			return_type = parse_param (res);
		}
		
		Method m;
		if (!is_interface && (is_constructor || name.has_prefix ("new"))) {
			m = new CreationMethod (null, name, current_source_reference);
			if (m.name == "new") {
				m.name = null;
			} else if (m.name.has_prefix ("new_")) {
				m.name = m.name.offset ("new_".len ());
			}
		} else {
			if (return_type.type_name == "void") {
				m = new Method (name, new VoidType (), current_source_reference);
			} else {
				m = new Method (name, return_type, current_source_reference);
			}
		}
		m.access = SymbolAccessibility.PUBLIC;

		if (current_type_symbol_set != null) {
			current_type_symbol_set.add (name);
		}
		
		if (current_data_type != null) {
			var sig_attributes = get_attributes ("%s::%s".printf (current_data_type.get_cname (), name));
			if (sig_attributes != null) {
				foreach (string attr in sig_attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "has_emitter" && eval (nv[1]) == "1") {
						return null;
					}
				}
			}
		}
		
		bool add_ellipsis = false;
		bool suppress_throws = false;

		var attributes = get_attributes (symbol);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "name") {
					m.set_cname (m.name);
					m.name = eval (nv[1]);
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				} else if (nv[0] == "ellipsis") {
					if (eval (nv[1]) == "1") {
						add_ellipsis = true;
					}
				} else if (nv[0] == "transfer_ownership") {
					if (eval (nv[1]) == "1") {
						return_type.transfers_ownership = true;
					}
				} else if (nv[0] == "sentinel") {
					m.sentinel = eval (nv[1]);
				} else if (nv[0] == "is_array") {
					if (eval (nv[1]) == "1") {
						return_type.array_rank = 1;
						return_type.is_out = false;
					}
				} else if (nv[0] == "throws") {
					if (eval (nv[1]) == "0") {
						suppress_throws = true;
					}
				} else if (nv[0] == "no_array_length") {
					if (eval (nv[1]) == "1") {
						m.no_array_length = true;
					}
				}
			}
		}
		
		m.set_cname (symbol);
		
		bool first = true;
		FormalParameter last_param = null;
		UnresolvedType last_param_type = null;
		foreach (weak IdlNodeParam param in parameters) {
			weak IdlNode param_node = (IdlNode) param;
			
			if (first) {
				first = false;
				if (!(m is CreationMethod) &&
				    current_data_type != null &&
				    param.type.is_interface &&
				    (param_node.name == "self" ||
				     param.type.@interface.has_suffix (current_data_type.get_cname ()))) {
					// instance method
					continue;
				} else {
					// static method
					m.instance = false;
				}
			}

			if (suppress_throws == false && param_is_exception (param)) {
				m.add_error_domain (parse_type (param.type));
				continue;
			}

			string param_name = param_node.name;
			if (param_name == "result") {
				// avoid conflict with generated result variable
				param_name = "_result";
			}
			var param_type = parse_param (param);
			var p = new FormalParameter (param_name, param_type);

			bool hide_param = false;
			var attributes = get_attributes ("%s.%s".printf (symbol, param_node.name));
			if (attributes != null) {
				foreach (string attr in attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "is_array") {
						if (eval (nv[1]) == "1") {
							param_type.array_rank = 1;
							param_type.is_out = false;
						}
					} else if (nv[0] == "is_out") {
						if (eval (nv[1]) == "1") {
							param_type.is_out = true;
						}
					} else if (nv[0] == "is_ref") {
						if (eval (nv[1]) == "1") {
							param_type.is_ref = true;
						}
					} else if (nv[0] == "nullable") {
						if (eval (nv[1]) == "1") {
							param_type.nullable = true;
							param_type.requires_null_check = true;
						}
					} else if (nv[0] == "transfer_ownership") {
						if (eval (nv[1]) == "1") {
							param_type.transfers_ownership = true;
						}
					} else if (nv[0] == "hidden") {
						if (eval (nv[1]) == "1") {
							hide_param = true;
						}
					} else if (nv[0] == "array_length_pos") {
						p.carray_length_parameter_position = eval (nv[1]).to_double ();
					}
				}
			}

			if (last_param != null && p.name == "n_" + last_param.name) {
				// last_param is array, p is array length
				last_param_type.array_rank = 1;
				last_param_type.is_out = false;

				// hide array length param
				hide_param = true;
			} else if (last_param != null && p.name == "user_data") {
				// last_param is delegate

				// hide deleate target param
				hide_param = true;
			}

			if (!hide_param) {
				m.add_parameter (p);
			}

			last_param = p;
			last_param_type = param_type;
		}
		
		if (first) {
			// no parameters => static method
			m.instance = false;
		}

		if (last_param != null && last_param.name.has_prefix ("first_")) {
			last_param.ellipsis = true;
		} else if (add_ellipsis) {
			m.add_parameter (new FormalParameter.with_ellipsis ());
		}
		
		return m;
	}

	private bool param_is_exception (IdlNodeParam param) {
		if (!param.type.is_error) {
			return false;
		}
		var s = param.type.unparsed.chomp ();
		if (s.has_suffix ("**")) {
			return true;
		}
		return false;
	}

	private Method parse_function (IdlNodeFunction! f, bool is_interface = false) {
		weak IdlNode node = (IdlNode) f;
		
		if (f.deprecated) {
			return null;
		}
	
		return create_method (node.name, f.symbol, f.result, f.parameters, f.is_constructor, is_interface);
	}

	private Method parse_virtual (IdlNodeVFunc! v, IdlNodeFunction? func, bool is_interface = false) {
		weak IdlNode node = (IdlNode) v;
		string symbol = "%s%s".printf (current_data_type.get_lower_case_cprefix(), node.name);

		if (func != null) {
			symbol = func.symbol;
		}

		Method m = create_method (node.name, symbol, v.result, func != null ? func.parameters : v.parameters, false, is_interface);
		if (m != null) {
			m.instance = true;
			m.is_virtual = !is_interface;
			m.is_abstract = is_interface;

			if (func == null) {
				m.attributes.append (new Attribute ("NoWrapper", null));
			}
		}

		return m;
	}
	
	private string! fix_prop_name (string name) {
		var str = new String ();
		
		string i = name;
		
		while (i.len () > 0) {
			unichar c = i.get_char ();
			if (c == '-') {
				str.append_c ('_');
			} else {
				str.append_unichar (c);
			}
			
			i = i.next_char ();
		}
		
		return str.str;
	}

	private Property parse_property (IdlNodeProperty! prop_node) {
		weak IdlNode node = (IdlNode) prop_node;
		
		if (prop_node.deprecated) {
			return null;
		}
		
		if (!prop_node.readable && !prop_node.writable) {
			// buggy GIDL definition
			prop_node.readable = true;
			prop_node.writable = true;
		}
		
		PropertyAccessor get_acc = null;
		PropertyAccessor set_acc = null;
		if (prop_node.readable) {
			get_acc = new PropertyAccessor (true, false, false, null, null);
		}
		if (prop_node.writable) {
			set_acc = new PropertyAccessor (false, false, false, null, null);
			if (prop_node.construct_only) {
				set_acc.construction = true;
			} else {
				set_acc.writable = true;
				set_acc.construction = prop_node.@construct;
			}
		}
		
		var prop = new Property (fix_prop_name (node.name), parse_type (prop_node.type), get_acc, set_acc, current_source_reference);
		prop.access = SymbolAccessibility.PUBLIC;
		prop.interface_only = true;

		var attributes = get_attributes ("%s:%s".printf (current_data_type.get_cname (), node.name));
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				}
			}
		}

		if (current_type_symbol_set != null) {
			current_type_symbol_set.add (prop.name);
		}
		
		return prop;
	}

	private Constant parse_constant (IdlNodeConstant! const_node) {
		weak IdlNode node = (IdlNode) const_node;
		
		var type = parse_type (const_node.type);
		if (type == null) {
			return null;
		}
		
		var c = new Constant (node.name, type, null, current_source_reference);
		c.access = SymbolAccessibility.PUBLIC;
		
		return c;
	}

	private Field parse_field (IdlNodeField! field_node) {
		weak IdlNode node = (IdlNode) field_node;
		
		var type = parse_type (field_node.type);
		if (type == null) {
			return null;
		}

		var attributes = get_attributes ("%s.%s".printf (current_data_type.get_cname (), node.name));
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				} else if (nv[0] == "is_array") {
					if (eval (nv[1]) == "1") {
						type.array_rank = 1;
					}
				} else if (nv[0] == "weak") {
					if (eval (nv[1]) == "0") {
						type.takes_ownership = true;
					}
				}
			}
		}
		
		if (current_type_symbol_set != null) {
			current_type_symbol_set.add (node.name);
		}
		
		var field = new Field (node.name, type, null, current_source_reference);
		field.access = SymbolAccessibility.PUBLIC;

		field.no_array_length = true;

		return field;
	}

	[NoArrayLength]
	private string[] get_attributes (string! codenode) {
		var attributes = codenode_attributes_map.get (codenode);

		if (attributes == null) {
			var dot_required = (null != codenode.chr (-1, '.'));
			var colon_required = (null != codenode.chr (-1, ':'));

			var pattern_specs = codenode_attributes_patterns.get_keys ();
			foreach (PatternSpec* pattern in pattern_specs) {
				var pspec = codenode_attributes_patterns[pattern];

				if ((dot_required && null == pspec.chr (-1, '.')) ||
				    (colon_required && null == pspec.chr (-1, ':'))) {
					continue;
				}

				if (pattern->match_string (codenode)) {
					return get_attributes (pspec);
				}
			}
		}

		if (attributes == null) {
			return null;
		}
		
		return attributes.split (" ");
	}
	
	private string eval (string! s) {
		return s.offset (1).ndup (s.size () - 2);
	}

	private Signal parse_signal (IdlNodeSignal! sig_node) {
		weak IdlNode node = (IdlNode) sig_node;
		
		if (sig_node.deprecated || sig_node.result == null) {
			return null;
		}
		
		var sig = new Signal (fix_prop_name (node.name), parse_param (sig_node.result), current_source_reference);
		sig.access = SymbolAccessibility.PUBLIC;
		
		var attributes = get_attributes ("%s::%s".printf (current_data_type.get_cname (), sig.name));
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "name") {
					sig.set_cname (sig.name);
					sig.name = eval (nv[1]);
				} else if (nv[0] == "has_emitter" && eval (nv[1]) == "1") {
					sig.has_emitter = true;
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				}
			}
		}
		
		bool first = true;
		
		foreach (weak IdlNodeParam param in sig_node.parameters) {
			if (first) {
				// ignore implicit first signal parameter (sender)
				first = false;
				continue;
			}
		
			weak IdlNode param_node = (IdlNode) param;
			
			var param_type = parse_param (param);
			var p = new FormalParameter (param_node.name, param_type);
			sig.add_parameter (p);

			var attributes = get_attributes ("%s::%s.%s".printf (current_data_type.get_cname (), sig.name, param_node.name));
			if (attributes != null) {
				foreach (string attr in attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "is_array") {
						if (eval (nv[1]) == "1") {
							param_type.array_rank = 1;
							param_type.is_out = false;
						}
					} else if (nv[0] == "is_out") {
						if (eval (nv[1]) == "1") {
							param_type.is_out = true;
						}
					} else if (nv[0] == "is_ref") {
						if (eval (nv[1]) == "1") {
							param_type.is_ref = true;
						}
					} else if (nv[0] == "nullable") {
						if (eval (nv[1]) == "1") {
							param_type.nullable = true;
							param_type.requires_null_check = true;
						}
					} else if (nv[0] == "type_name") {
						param_type.type_name = eval (nv[1]);
					} else if (nv[0] == "namespace_name") {
						param_type.namespace_name = eval (nv[1]);
					}
				}
			}
		}
		
		return sig;
	}
}
