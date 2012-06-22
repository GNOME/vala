/* valagidlparser.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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

/**
 * Code visitor parsing all GIDL files.
 */
public class Vala.GIdlParser : CodeVisitor {
	private CodeContext context;

	private SourceFile current_source_file;

	private SourceReference current_source_reference;
	
	private Namespace current_namespace;
	private TypeSymbol current_data_type;
	private Map<string,string> codenode_attributes_map;
	private Map<PatternSpec*,string> codenode_attributes_patterns;
	private Set<string> current_type_symbol_set;

	private Map<string,TypeSymbol> cname_type_map;

	static GLib.Regex type_from_string_regex;

	/**
	 * Parse all source files in the specified code context and build a
	 * code tree.
	 *
	 * @param context a code context
	 */
	public void parse (CodeContext context) {
		cname_type_map = new HashMap<string,TypeSymbol> (str_hash, str_equal);

		this.context = context;
		context.accept (this);

		cname_type_map = null;
	}

	public override void visit_namespace (Namespace ns) {
		ns.accept_children (this);
	}

	public override void visit_class (Class cl) {
		visit_type (cl);
	}

	public override void visit_struct (Struct st) {
		visit_type (st);
	}

	public override void visit_interface (Interface iface) {
		visit_type (iface);
	}

	public override void visit_enum (Enum en) {
		visit_type (en);
	}

	public override void visit_error_domain (ErrorDomain ed) {
		visit_type (ed);
	}

	public override void visit_delegate (Delegate d) {
		visit_type (d);
	}

	private void visit_type (TypeSymbol t) {
		if (!cname_type_map.contains (get_cname (t))) {
			cname_type_map[get_cname (t)] = t;
		}
	}

	public override void visit_source_file (SourceFile source_file) {
		if (source_file.filename.has_suffix (".gi")) {
			parse_file (source_file);
		}
	}
	
	private void parse_file (SourceFile source_file) {
		string metadata_filename = "%s.metadata".printf (source_file.filename.substring (0, source_file.filename.length - ".gi".length));

		current_source_file = source_file;

		codenode_attributes_map = new HashMap<string,string> (str_hash, str_equal);
		codenode_attributes_patterns = new HashMap<PatternSpec*,string> (direct_hash, (EqualFunc) PatternSpec.equal);

		if (FileUtils.test (metadata_filename, FileTest.EXISTS)) {
			try {
				string metadata;
				FileUtils.get_contents (metadata_filename, out metadata, null);
				
				foreach (string line in metadata.split ("\n")) {
					if (line.has_prefix ("#")) {
						// ignore comment lines
						continue;
					}

					var tokens = line.split (" ", 2);

					if (null == tokens[0]) {
						continue;
					}

					if (-1 != tokens[0].index_of_char ('*')) {
						PatternSpec* pattern = new PatternSpec (tokens[0]);
						codenode_attributes_patterns[pattern] = tokens[0];
					}
					
					codenode_attributes_map[tokens[0]] = tokens[1];
				}
			} catch (FileError e) {
				Report.error (null, "Unable to read metadata file: %s".printf (e.message));
			}
		}
	
		try {
			var modules = Idl.parse_file (source_file.filename);
			
			current_source_reference = new SourceReference (source_file, SourceLocation (null, 0, 0), SourceLocation (null, 0, 0));
			
			foreach (weak IdlModule module in modules) {
				var ns = parse_module (module);
				if (ns != null) {
					context.root.add_namespace (ns);
				}
			}
		} catch (MarkupError e) {
			Report.error (null, "Unable to parse GIDL file: %s".printf (e.message));
		}
	}

	private string fix_type_name (string type_name, Symbol container) {
		var attributes = get_attributes (type_name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "name") {
					return eval (nv[1]);
				}
			}
		}

		if (type_name.has_prefix (container.name)) {
			return type_name.substring (container.name.length);
		} else {
			var cprefix = get_cprefix (container);
			if (type_name.has_prefix (cprefix)) {
				return type_name.substring (cprefix.length);;
			}
		}

		return type_name;
	}

	private string fix_const_name (string const_name, Symbol container) {
		var pref = get_lower_case_cprefix (container).up ();
		if (const_name.has_prefix (pref)) {
			return const_name.substring (pref.length);
		}
		return const_name;
	}

	private string get_cheader_filename (Symbol sym) {
		var cheader_filename = sym.get_attribute_string ("CCode", "cheader_filename");
		if (cheader_filename != null) {
			return cheader_filename;
		}
		if (sym.parent_symbol != null) {
			return get_cheader_filename (sym.parent_symbol);
		} else if (sym.source_reference != null) {
			return sym.source_reference.file.get_cinclude_filename ();
		}
		return "";
	}

	private string get_cname (Symbol sym, Symbol? container = null) {
		if (container == null) {
			container = sym.parent_symbol;
		}
		var cname = sym.get_attribute_string ("CCode", "cname");
		if (cname != null) {
			return cname;
		}
		if (sym is Method) {
			var name = sym.name;
			if (sym is CreationMethod) {
				if (name == null || name == ".new") {
					name = "new";
				} else {
					name = "new_"+name;
				}
			}
			if (container != null) {
				return "%s%s".printf (get_lower_case_cprefix (container), name);
			} else {
				return name;
			}
		} else {
			if (container != null) {
				return "%s%s".printf (get_cprefix (container), sym.name);
			} else {
				return sym.name;
			}
		}
	}

	private string get_finish_cname (Method m) {
		var finish_cname = m.get_attribute_string ("CCode", "finish_name");
		if (finish_cname != null) {
			return finish_cname;
		}
		var result = get_cname (m);
		if (result.has_suffix ("_async")) {
			result = result.substring (0, result.length - "_async".length);
		}
		return result + "_finish";
	}

	private string get_lower_case_cname (Symbol sym) {
		var lower_case_csuffix = Symbol.camel_case_to_lower_case (sym.name);
		if (sym is ObjectTypeSymbol) {
			// remove underscores in some cases to avoid conflicts of type macros
			if (lower_case_csuffix.has_prefix ("type_")) {
				lower_case_csuffix = "type" + lower_case_csuffix.substring ("type_".length);
			} else if (lower_case_csuffix.has_prefix ("is_")) {
				lower_case_csuffix = "is" + lower_case_csuffix.substring ("is_".length);
			}
			if (lower_case_csuffix.has_suffix ("_class")) {
				lower_case_csuffix = lower_case_csuffix.substring (0, lower_case_csuffix.length - "_class".length) + "class";
			}
		}
		if (sym.parent_symbol != null) {
			return "%s%s".printf (get_lower_case_cprefix (sym.parent_symbol), lower_case_csuffix);
		} else {
			return lower_case_csuffix;
		}
	}

	private string get_lower_case_cprefix (Symbol sym) {
		if (sym.name == null) {
			return "";
		}
		string cprefix;
		cprefix = sym.get_attribute_string ("CCode", "lower_case_cprefix");
		if (cprefix == null && (sym is ObjectTypeSymbol || sym is Struct)) {
			cprefix = sym.get_attribute_string ("CCode", "cprefix");
		}
		if (cprefix != null) {
			return cprefix;
		}
		return get_lower_case_cname (sym) + "_";
	}

	public string get_cprefix (Symbol sym) {
		if (sym is ObjectTypeSymbol) {
			return get_cname (sym);
		} else if (sym is Enum || sym is ErrorDomain) {
			return "%s_".printf (get_lower_case_cname (sym).up ());
		} else if (sym is Namespace) {
			if (sym.name != null) {
				var cprefix = sym.get_attribute_string ("CCode", "cprefix");
				if (cprefix != null) {
					return cprefix;
				}
				if (sym.parent_symbol != null) {
					return "%s%s".printf (get_cprefix (sym.parent_symbol), sym.name);
				} else {
					return sym.name;
				}
			} else {
				return "";
			}
		} else if (sym.name != null) {
			return sym.name;
		}
		return "";
	}

	private string[] get_attributes_for_node (IdlNode node) {
		string name;

		if (node.type == IdlNodeTypeId.FUNCTION) {
			name = ((IdlNodeFunction) node).symbol;
		} else if (node.type == IdlNodeTypeId.SIGNAL) {
			name = "%s::%s".printf (get_cname (current_data_type), node.name);
		} else if (node.type == IdlNodeTypeId.PROPERTY) {
			name = "%s:%s".printf (get_cname (current_data_type), node.name);
		} else if (node.type == IdlNodeTypeId.FIELD) {
			name = "%s.%s".printf (get_cname (current_data_type), node.name);
		} else {
			name = node.name;
		}

		return get_attributes (name);
	}

	private void add_symbol_to_container (Symbol container, Symbol sym) {
		if (container is Class) {
			unowned Class cl = (Class) container;

			if (sym is Class) {
				cl.add_class ((Class) sym);
			} else if (sym is Constant) {
				cl.add_constant ((Constant) sym);
			} else if (sym is Enum) {
				cl.add_enum ((Enum) sym);
			} else if (sym is Field) {
				cl.add_field ((Field) sym);
			} else if (sym is Method) {
				cl.add_method ((Method) sym);
			} else if (sym is Property) {
				cl.add_property ((Property) sym);
			} else if (sym is Signal) {
				cl.add_signal ((Signal) sym);
			} else if (sym is Struct) {
				cl.add_struct ((Struct) sym);
			}
		} else if (container is Enum) {
			unowned Enum en = (Enum) container;

			if (sym is EnumValue) {
				en.add_value ((EnumValue) sym);
			} else if (sym is Constant) {
				en.add_constant ((Constant) sym);
			} else if (sym is Method) {
				en.add_method ((Method) sym);
			}
		} else if (container is Interface) {
			unowned Interface iface = (Interface) container;

			if (sym is Class) {
				iface.add_class ((Class) sym);
			} else if (sym is Constant) {
				iface.add_constant ((Constant) sym);
			} else if (sym is Enum) {
				iface.add_enum ((Enum) sym);
			} else if (sym is Field) {
				iface.add_field ((Field) sym);
			} else if (sym is Method) {
				iface.add_method ((Method) sym);
			} else if (sym is Property) {
				iface.add_property ((Property) sym);
			} else if (sym is Signal) {
				iface.add_signal ((Signal) sym);
			} else if (sym is Struct) {
				iface.add_struct ((Struct) sym);
			}
		} else if (container is Namespace) {
			unowned Namespace ns = (Namespace) container;

			if (sym is Namespace) {
				ns.add_namespace ((Namespace) sym);
			} else if (sym is Class) {
				ns.add_class ((Class) sym);
			} else if (sym is Constant) {
				ns.add_constant ((Constant) sym);
			} else if (sym is Delegate) {
				ns.add_delegate ((Delegate) sym);
			} else if (sym is Enum) {
				ns.add_enum ((Enum) sym);
			} else if (sym is ErrorDomain) {
				ns.add_error_domain ((ErrorDomain) sym);
			} else if (sym is Field) {
				ns.add_field ((Field) sym);
			} else if (sym is Interface) {
				ns.add_interface ((Interface) sym);
			} else if (sym is Method) {
				ns.add_method ((Method) sym);
			} else if (sym is Namespace) {
				ns.add_namespace ((Namespace) sym);
			} else if (sym is Struct) {
				ns.add_struct ((Struct) sym);
			}
		} else if (container is Struct) {
			unowned Struct st = (Struct) container;

			if (sym is Constant) {
				st.add_constant ((Constant) sym);
			} else if (sym is Field) {
				st.add_field ((Field) sym);
			} else if (sym is Method) {
				st.add_method ((Method) sym);
			} else if (sym is Property) {
				st.add_property ((Property) sym);
			}
		}

		if (!(sym is Namespace) && container is Namespace) {
			// set C headers
			sym.set_attribute_string ("CCode", "cheader_filename", get_cheader_filename (sym));
		}
	}

	private void parse_node (IdlNode node, IdlModule module, Symbol container) {
		if (node.type == IdlNodeTypeId.CALLBACK) {
			var cb = parse_delegate ((IdlNodeFunction) node);
			if (cb == null) {
				return;
			}
			cb.name = fix_type_name (cb.name, container);
			add_symbol_to_container (container, cb);
			current_source_file.add_node (cb);
		} else if (node.type == IdlNodeTypeId.STRUCT) {
			parse_struct ((IdlNodeStruct) node, container, module);
		} else if (node.type == IdlNodeTypeId.UNION) {
			parse_union ((IdlNodeUnion) node, container, module);
		} else if (node.type == IdlNodeTypeId.BOXED) {
			parse_boxed ((IdlNodeBoxed) node, container, module);
		} else if (node.type == IdlNodeTypeId.ENUM) {
			parse_enum ((IdlNodeEnum) node, container, module, false);
		} else if (node.type == IdlNodeTypeId.FLAGS) {
			parse_enum ((IdlNodeEnum) node, container, module, true);
		} else if (node.type == IdlNodeTypeId.OBJECT) {
			parse_object ((IdlNodeInterface) node, container, module);
		} else if (node.type == IdlNodeTypeId.INTERFACE) {
			parse_interface ((IdlNodeInterface) node, container, module);
		} else if (node.type == IdlNodeTypeId.CONSTANT) {
			var c = parse_constant ((IdlNodeConstant) node);
			if (c != null) {
				c.name = fix_const_name (c.name, container);
				add_symbol_to_container (container, c);
				current_source_file.add_node (c);
			}
		} else if (node.type == IdlNodeTypeId.FUNCTION) {
			var m = parse_function ((IdlNodeFunction) node);
			if (m != null) {
				m.binding = MemberBinding.STATIC;
				add_symbol_to_container (container, m);
				current_source_file.add_node (m);
			}
		}
	}

	private Symbol? get_container_from_name (string name) {
		var path = name.split (".");
		Symbol? cp = current_namespace;
		if (cp.parent_symbol != context.root) {
			cp = cp.parent_symbol;
		}
		Symbol? cc = null;

		foreach ( unowned string tok in path ) {
			cc = cp.scope.lookup (tok) as Symbol;
			if ( cc == null ) {
				cc = new Namespace (tok, current_source_reference);
				add_symbol_to_container (cp, cc);
			}
			cp = cc;
		}

		return cc;
	}

	private Namespace? parse_module (IdlModule module) {
		Symbol sym = context.root.scope.lookup (module.name);
		Namespace ns;
		if (sym is Namespace) {
			ns = (Namespace) sym;
			if (ns.external_package) {
				ns.attributes = null;
				ns.source_reference = current_source_reference;
			}
		} else {
			ns = new Namespace (module.name, current_source_reference);
		}

		current_namespace = ns;

		var attributes = get_attributes (ns.name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "cheader_filename") {
					ns.set_attribute_string ("CCode", "cheader_filename", eval (nv[1]));
				} else if (nv[0] == "cprefix") {
					ns.set_attribute_string ("CCode", "cprefix", eval (nv[1]));
				} else if (nv[0] == "lower_case_cprefix") {
					ns.set_attribute_string ("CCode", "lower_case_cprefix",  eval (nv[1]));
				} else if (nv[0] == "gir_namespace") {
					ns.source_reference.file.gir_namespace = eval (nv[1]);
					ns.set_attribute_string ("CCode", "gir_namespace", eval (nv[1]));
				} else if (nv[0] == "gir_version") {
					ns.source_reference.file.gir_version = eval (nv[1]);
					ns.set_attribute_string ("CCode", "gir_version", eval (nv[1]));
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						ns.set_attribute ("Deprecated", true);
					}
				} else if (nv[0] == "replacement") {
					ns.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
				} else if (nv[0] == "deprecated_since") {
					ns.set_attribute_string ("Deprecated", "since", eval (nv[1]));
				}
			}
		}

		var deferred = new ArrayList<unowned IdlNode> ();

		foreach (weak IdlNode node in module.entries) {
			bool is_deferred = false;
			var child_attributes = get_attributes_for_node (node);
			if (child_attributes != null) {
				foreach (unowned string attr in child_attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "parent") {
						deferred.add (node);
						is_deferred = true;
					}
				}
			}

			if (!is_deferred) {
				parse_node (node, module, ns);
			}
		}

		foreach (unowned IdlNode node in deferred) {
			Symbol container = ns;
			var child_attributes = get_attributes_for_node (node);
			if (child_attributes != null) {
				foreach (unowned string attr in child_attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "parent") {
						container = get_container_from_name (eval (nv[1]));
					}
				}
			}

			if (container is Namespace) {
				current_namespace = (Namespace) container;
			} else {
				current_data_type = (TypeSymbol) container;
			}
			parse_node (node, module, container);
			current_namespace = ns;
			current_data_type = null;
		}

		current_namespace = null;

		if (sym is Namespace) {
			return null;
		}
		return ns;
	}
	
	private Delegate? parse_delegate (IdlNodeFunction f_node) {
		weak IdlNode node = (IdlNode) f_node;

		var return_type = parse_param (f_node.result);

		var cb = new Delegate (node.name, return_type, current_source_reference);
		cb.access = SymbolAccessibility.PUBLIC;
		cb.has_target = false;

		bool check_has_target = true;
		bool suppress_throws = false;
		string? error_types = null;

		var attributes = get_attributes (node.name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				} else if (nv[0] == "cheader_filename") {
					cb.set_attribute_string ("CCode", "cheader_filename", eval (nv[1]));
				} else if (nv[0] == "has_target") {
					if (eval (nv[1]) == "0") {
						check_has_target = false;
					} else if (eval (nv[1]) == "1") {
						cb.has_target = true;
					}
				} else if (nv[0] == "transfer_ownership") {
					if (eval (nv[1]) == "1") {
						return_type.value_owned = true;
					}
				} else if (nv[0] == "is_array") {
					if (eval (nv[1]) == "1") {
						return_type = new ArrayType (return_type, 1, return_type.source_reference);
						cb.return_type = return_type;
					}
				} else if (nv[0] == "throws") {
					if (eval (nv[1]) == "0") {
						suppress_throws = true;
					}
				} else if (nv[0] == "error_types") {
					error_types = eval (nv[1]);
				} else if (nv[0] == "array_length_type") {
					cb.set_attribute_string ("CCode", "array_length_type", eval (nv[1]));
				} else if (nv[0] == "type_name") {
					cb.return_type = return_type = parse_type_from_string (eval (nv[1]), return_type.value_owned);
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						cb.set_attribute ("Deprecated", true);
					}
				} else if (nv[0] == "replacement") {
					cb.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
				} else if (nv[0] == "deprecated_since") {
					cb.set_attribute_string ("Deprecated", "since", eval (nv[1]));
				} else if (nv[0] == "type_arguments") {
					parse_type_arguments_from_string (return_type, eval (nv[1]));
				} else if (nv[0] == "instance_pos") {
					cb.set_attribute_double ("CCode", "instance_pos", double.parse (eval (nv[1])));
				} else if (nv[0] == "type_parameters") {
					foreach (string type_param_name in eval (nv[1]).split (",")) {
						cb.add_type_parameter (new TypeParameter (type_param_name, current_source_reference));
					}
				} else if (nv[0] == "experimental") {
					if (eval (nv[1]) == "1") {
						cb.set_attribute ("Experimental", true);
					}
				}
			}
		}

		uint remaining_params = f_node.parameters.length ();
		foreach (weak IdlNodeParam param in f_node.parameters) {
			weak IdlNode param_node = (IdlNode) param;

			if (check_has_target && remaining_params == 1 && (param_node.name == "user_data" || param_node.name == "data")) {
				// hide user_data parameter for instance delegates
				cb.has_target = true;
			} else {
				// check for GError parameter
				if (suppress_throws == false && param_is_exception (param)) {
					if (error_types == null)
						cb.add_error_type (parse_type (param.type));
					remaining_params--;
					continue;
				}

				string param_name = param_node.name;
				if (param_name == "string") {
					// avoid conflict with string type
					param_name = "str";
				} else if (param_name == "self") {
					// avoid conflict with delegate target
					param_name = "_self";
				}

				ParameterDirection direction;
				var param_type = parse_param (param, out direction);
				var p = new Parameter (param_name, param_type);
				p.direction = direction;

				bool hide_param = false;
				bool show_param = false;
				bool array_requested = false;
				bool out_requested = false;
				attributes = get_attributes ("%s.%s".printf (node.name, param_node.name));
				if (attributes != null) {
					foreach (string attr in attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "hidden") {
							if (eval (nv[1]) == "1") {
								hide_param = true;
							} else if (eval (nv[1]) == "0") {
								show_param = true;
							}
						} else if (nv[0] == "is_array") {
							if (eval (nv[1]) == "1") {
								param_type = new ArrayType (param_type, 1, param_type.source_reference);
								p.variable_type = param_type;
								if (!out_requested) {
									p.direction = ParameterDirection.IN;
								}
								array_requested = true;
							}
						} else if (nv[0] == "is_out") {
							if (eval (nv[1]) == "1") {
								p.direction = ParameterDirection.OUT;
								out_requested = true;
								if (!array_requested && param_type is ArrayType) {
									var array_type = (ArrayType) param_type;
									param_type = array_type.element_type;
									p.variable_type = param_type;
								}
							}
						} else if (nv[0] == "is_ref") {
							if (eval (nv[1]) == "1") {
								p.direction = ParameterDirection.REF;
								if (!array_requested && param_type is ArrayType) {
									var array_type = (ArrayType) param_type;
									param_type = array_type.element_type;
									p.variable_type = param_type;
								}
							}
						} else if (nv[0] == "takes_ownership") {
							if (eval (nv[1]) == "1") {
								param_type.value_owned = true;
							}
						} else if (nv[0] == "nullable") {
							if (eval (nv[1]) == "1") {
								param_type.nullable = true;
							}
						} else if (nv[0] == "type_arguments") {
							parse_type_arguments_from_string (param_type, eval (nv[1]));
						} else if (nv[0] == "no_array_length") {
							if (eval (nv[1]) == "1") {
								p.set_attribute_bool ("CCode", "array_length", false);
							}
						} else if (nv[0] == "array_length_type") {
							p.set_attribute_string ("CCode", "array_length_type", eval (nv[1]));
						} else if (nv[0] == "array_null_terminated") {
							if (eval (nv[1]) == "1") {
								p.set_attribute_bool ("CCode", "array_length", false);
								p.set_attribute_bool ("CCode", "array_null_terminated", true);
							}
						} else if (nv[0] == "type_name") {
							p.variable_type = param_type = parse_type_from_string (eval (nv[1]), false);
						}
					}
				}

				if (show_param || !hide_param) {
					cb.add_parameter (p);
				}
			}

			remaining_params--;
		}

		if (suppress_throws == false && error_types != null) {
			var type_args = eval (error_types).split (",");
			foreach (string type_arg in type_args) {
				cb.add_error_type (parse_type_from_string (type_arg, true));
			}
		}

		return cb;
	}

	private bool is_reference_type (string cname) {
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

	private void parse_struct (IdlNodeStruct st_node, Symbol container, IdlModule module) {
		weak IdlNode node = (IdlNode) st_node;
		
		if (st_node.deprecated) {
			return;
		}

		string name = fix_type_name (node.name, container);

		if (!is_reference_type (node.name)) {
			var st = container.scope.lookup (name) as Struct;
			if (st == null) {
				st = new Struct (name, current_source_reference);
				st.access = SymbolAccessibility.PUBLIC;

				var st_attributes = get_attributes (node.name);
				if (st_attributes != null) {
					foreach (string attr in st_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							st.set_attribute_string ("CCode", "cheader_filename", eval (nv[1]));
						} else if (nv[0] == "hidden") {
							if (eval (nv[1]) == "1") {
								return;
							}
						} else if (nv[0] == "base_type") {
							st.base_type = parse_type_string (eval (nv[1]));
						} else if (nv[0] == "rank") {
							st.set_rank (int.parse (eval (nv[1])));
						} else if (nv[0] == "simple_type") {
							if (eval (nv[1]) == "1") {
								st.set_simple_type (true);
							}
						} else if (nv[0] == "immutable") {
							if (eval (nv[1]) == "1") {
								st.set_attribute ("Immutable", true);
							}
						} else if (nv[0] == "has_type_id") {
							if (eval (nv[1]) == "0") {
								st.set_attribute_bool ("CCode", "has_type_id", false);
							}
						} else if (nv[0] == "type_id") {
							st.set_attribute_string ("CCode", "type_id", eval (nv[1]));
						} else if (nv[0] == "has_copy_function") {
							if (eval (nv[1]) == "0") {
								st.set_attribute_bool ("CCode", "has_copy_function", false);
							}
						} else if (nv[0] == "deprecated") {
							if (eval (nv[1]) == "1") {
								st.set_attribute ("Deprecated", true);
							}
						} else if (nv[0] == "replacement") {
							st.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
						} else if (nv[0] == "deprecated_since") {
							st.set_attribute_string ("Deprecated", "since", eval (nv[1]));
						} else if (nv[0] == "has_destroy_function") {
							if (eval (nv[1]) == "0") {
								st.set_attribute_bool ("CCode", "has_destroy_function", false);
							}
						} else if (nv[0] == "experimental") {
							if (eval (nv[1]) == "1") {
								st.set_attribute ("Experimental", true);
							}
						}
					}
				}

				add_symbol_to_container (container, st);
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
			bool ref_function_void = false;
			string ref_function = null;
			string unref_function = null;
			string copy_function = null;
			string free_function = null;

			var cl = container.scope.lookup (name) as Class;
			if (cl == null) {
				string base_class = null;
				bool is_fundamental = false;

				cl = new Class (name, current_source_reference);
				cl.access = SymbolAccessibility.PUBLIC;

				var cl_attributes = get_attributes (node.name);
				if (cl_attributes != null) {
					foreach (string attr in cl_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							cl.set_attribute_string ("CCode", "cheader_filename", eval (nv[1]));
						} else if (nv[0] == "base_class") {
							base_class = eval (nv[1]);
						} else if (nv[0] == "hidden") {
							if (eval (nv[1]) == "1") {
								return;
							}
						} else if (nv[0] == "is_immutable") {
							if (eval (nv[1]) == "1") {
								cl.is_immutable = true;
							}
						} else if (nv[0] == "const_cname") {
							cl.set_attribute_string ("CCode", "const_cname", eval (nv[1]));
						} else if (nv[0] == "is_fundamental") {
							if (eval (nv[1]) == "1") {
								is_fundamental = true;
							}
						} else if (nv[0] == "abstract" && base_class != null) {
							if (eval (nv[1]) == "1") {
								cl.is_abstract = true;
							}
						} else if (nv[0] == "free_function") {
							free_function = eval (nv[1]);
						} else if (nv[0] == "ref_function") {
							ref_function = eval (nv[1]);
						} else if (nv[0] == "unref_function") {
							unref_function = eval (nv[1]);
						} else if (nv[0] == "copy_function") {
							copy_function = eval (nv[1]);
						} else if (nv[0] == "ref_function_void") {
							if (eval (nv[1]) == "1") {
								ref_function_void = true;
							}
						} else if (nv[0] == "deprecated") {
							if (eval (nv[1]) == "1") {
								cl.set_attribute ("Deprecated", true);
							}
						} else if (nv[0] == "replacement") {
							cl.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
						} else if (nv[0] == "deprecated_since") {
							cl.set_attribute_string ("Deprecated", "since", eval (nv[1]));
						} else if (nv[0] == "type_parameters") {
							foreach (string type_param_name in eval (nv[1]).split (",")) {
								cl.add_type_parameter (new TypeParameter (type_param_name, current_source_reference));
							}
						} else if (nv[0] == "experimental") {
							if (eval (nv[1]) == "1") {
								cl.set_attribute ("Experimental", true);
							}
						}
					}
				}

				add_symbol_to_container (container, cl);
				current_source_file.add_node (cl);

				if (base_class != null) {
					var parent = parse_type_string (base_class);
					cl.add_base_type (parent);
				}
				if (base_class == null && !is_fundamental) {
					cl.is_compact = true;
				}
			}

			current_data_type = cl;

			foreach (weak IdlNode member in st_node.members) {
				if (member.type == IdlNodeTypeId.FUNCTION) {
					if ((ref_function == null) && (member.name == "ref")) {
						ref_function = ((IdlNodeFunction) member).symbol;
						ref_function_void = (parse_type (((IdlNodeFunction) member).result.type) is VoidType);
					} else if ((unref_function == null) && (member.name == "unref")) {
						unref_function = ((IdlNodeFunction) member).symbol;
					} else if ((free_function == null) && (member.name == "free" || member.name == "destroy")) {
						free_function = ((IdlNodeFunction) member).symbol;
					} else {
						if ((copy_function == null) && (member.name == "copy")) {
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
				cl.set_attribute_string ("CCode", "ref_function", ref_function);
				if (ref_function_void) {
					cl.set_attribute_bool ("CCode", "ref_function_void", ref_function_void);
				}
			} else if (copy_function != null) {
				cl.set_attribute_string ("CCode", "copy_function", copy_function);
			}
			if (unref_function != null) {
				cl.set_attribute_string ("CCode", "unref_function", unref_function);
			} else if (free_function != null && free_function != "%sfree".printf (get_lower_case_cprefix (cl))) {
				cl.set_attribute_string ("CCode", "free_function", free_function);
			}

			current_data_type = null;
		}
	}

	private void parse_union (IdlNodeUnion un_node, Symbol container, IdlModule module) {
		weak IdlNode node = (IdlNode) un_node;
		
		if (un_node.deprecated) {
			return;
		}

		string name = fix_type_name (node.name, container);

		if (!is_reference_type (node.name)) {
			var st = container.scope.lookup (name) as Struct;
			if (st == null) {
				st = new Struct (name, current_source_reference);
				st.access = SymbolAccessibility.PUBLIC;

				var st_attributes = get_attributes (node.name);
				if (st_attributes != null) {
					foreach (string attr in st_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							st.set_attribute_string ("CCode", "cheader_filename", eval (nv[1]));
						} else if (nv[0] == "deprecated") {
							if (eval (nv[1]) == "1") {
								st.set_attribute ("Deprecated", true);
							}
						} else if (nv[0] == "replacement") {
							st.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
						} else if (nv[0] == "deprecated_since") {
							st.set_attribute_string ("Deprecated", "since", eval (nv[1]));
						} else if (nv[0] == "hidden") {
							if (eval (nv[1]) == "1") {
								return;
							}
						} else if (nv[0] == "experimental") {
							if (eval (nv[1]) == "1") {
								st.set_attribute ("Experimental", true);
							}
						}
					}
				}

				add_symbol_to_container (container, st);
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
			var cl = container.scope.lookup (name) as Class;
			if (cl == null) {
				cl = new Class (name, current_source_reference);
				cl.access = SymbolAccessibility.PUBLIC;
				cl.is_compact = true;

				var cl_attributes = get_attributes (node.name);
				if (cl_attributes != null) {
					foreach (string attr in cl_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							cl.set_attribute_string ("CCode", "cheader_filename", eval (nv[1]));
						} else if (nv[0] == "hidden") {
							if (eval (nv[1]) == "1") {
								return;
							}
						}
					}
				}

				add_symbol_to_container (container, cl);
				current_source_file.add_node (cl);
			}

			current_data_type = cl;

			bool ref_function_void = false;
			string ref_function = null;
			string unref_function = null;
			string copy_function = null;
			string free_function = null;

			foreach (weak IdlNode member in un_node.members) {
				if (member.type == IdlNodeTypeId.FUNCTION) {
					if (member.name == "ref") {
						ref_function = ((IdlNodeFunction) member).symbol;
						ref_function_void = (parse_type (((IdlNodeFunction) member).result.type) is VoidType);
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
				cl.set_attribute_string ("CCode", "ref_function", ref_function);
				if (ref_function_void) {
					cl.set_attribute_bool ("CCode", "ref_function_void", ref_function_void);
				}
			} else if (copy_function != null) {
				cl.set_attribute_string ("CCode", "copy_function", copy_function);
			}
			if (unref_function != null) {
				cl.set_attribute_string ("CCode", "unref_function", unref_function);
			} else if (free_function != null && free_function != "%sfree".printf (get_lower_case_cprefix (cl))) {
				cl.set_attribute_string ("CCode", "free_function", free_function);
			}

			current_data_type = null;
		}
	}

	private void parse_boxed (IdlNodeBoxed boxed_node, Symbol container, IdlModule module) {
		weak IdlNode node = (IdlNode) boxed_node;

		string name = fix_type_name (node.name, container);

		var node_attributes = get_attributes (node.name);
		if (node_attributes != null) {
			foreach (string attr in node_attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "hidden") {
					return;
				}
			}
		}

		if (!is_reference_type (node.name)) {
			var st = container.scope.lookup (name) as Struct;
			if (st == null) {
				st = new Struct (name, current_source_reference);
				st.access = SymbolAccessibility.PUBLIC;

				var st_attributes = get_attributes (node.name);
				if (st_attributes != null) {
					foreach (string attr in st_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							st.set_attribute_string ("CCode", "cheader_filename", eval (nv[1]));
						} else if (nv[0] == "deprecated") {
							if (eval (nv[1]) == "1") {
								st.set_attribute ("Deprecated", true);
							}
						} else if (nv[0] == "replacement") {
							st.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
						} else if (nv[0] == "deprecated_since") {
							st.set_attribute_string ("Deprecated", "since", eval (nv[1]));
						} else if (nv[0] == "immutable") {
							if (eval (nv[1]) == "1") {
								st.set_attribute ("Immutable", true);
							}
						} else if (nv[0] == "has_copy_function") {
							if (eval (nv[1]) == "0") {
								st.set_attribute_bool ("CCode", "has_copy_function", false);
							}
						} else if (nv[0] == "has_destroy_function") {
							if (eval (nv[1]) == "0") {
								st.set_attribute_bool ("CCode", "has_destroy_function", false);
							}
						} else if (nv[0] == "experimental") {
							if (eval (nv[1]) == "1") {
								st.set_attribute ("Experimental", true);
							}
						}
					}
				}

				add_symbol_to_container (container, st);
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
			bool ref_function_void = false;
			string ref_function = null;
			string unref_function = null;
			string copy_function = null;
			string free_function = null;

			var cl = container.scope.lookup (name) as Class;
			if (cl == null) {
				string base_class = null;

				cl = new Class (name, current_source_reference);
				cl.access = SymbolAccessibility.PUBLIC;
				cl.is_compact = true;
				if (boxed_node.gtype_init != null) {
					cl.set_attribute_string ("CCode", "type_id", "%s ()".printf (boxed_node.gtype_init));
				}

				var cl_attributes = get_attributes (node.name);
				if (cl_attributes != null) {
					foreach (string attr in cl_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							cl.set_attribute_string ("CCode", "cheader_filename", eval (nv[1]));
						} else if (nv[0] == "base_class") {
							base_class = eval (nv[1]);
						} else if (nv[0] == "is_immutable") {
							if (eval (nv[1]) == "1") {
								cl.is_immutable = true;
							}
						} else if (nv[0] == "deprecated") {
							if (eval (nv[1]) == "1") {
								cl.set_attribute ("Deprecated", true);
							}
						} else if (nv[0] == "replacement") {
							cl.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
						} else if (nv[0] == "deprecated_since") {
							cl.set_attribute_string ("Deprecated", "since", eval (nv[1]));
						} else if (nv[0] == "const_cname") {
							cl.set_attribute_string ("CCode", "const_cname", eval (nv[1]));
						} else if (nv[0] == "free_function") {
							free_function = eval (nv[1]);
						} else if (nv[0] == "ref_function") {
							ref_function = eval (nv[1]);
						} else if (nv[0] == "unref_function") {
							unref_function = eval (nv[1]);
						} else if (nv[0] == "copy_function") {
							copy_function = eval (nv[1]);
						} else if (nv[0] == "ref_function_void") {
							if (eval (nv[1]) == "1") {
								ref_function_void = true;
							}
						} else if (nv[0] == "experimental") {
							if (eval (nv[1]) == "1") {
								cl.set_attribute ("Experimental", true);
							}
						}
					}
				}

				add_symbol_to_container (container, cl);
				current_source_file.add_node (cl);

				if (base_class != null) {
					var parent = parse_type_string (base_class);
					cl.add_base_type (parent);
				}
			}

			current_data_type = cl;

			foreach (weak IdlNode member in boxed_node.members) {
				if (member.type == IdlNodeTypeId.FUNCTION) {
					if (member.name == "ref") {
						ref_function = ((IdlNodeFunction) member).symbol;
						ref_function_void = (parse_type (((IdlNodeFunction) member).result.type) is VoidType);
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
				cl.set_attribute_string ("CCode", "ref_function", ref_function);
				if (ref_function_void) {
					cl.set_attribute_bool ("CCode", "ref_function_void", ref_function_void);
				}
			} else if (copy_function != null) {
				cl.set_attribute_string ("CCode", "copy_function", copy_function);
			}
			if (unref_function != null) {
				cl.set_attribute_string ("CCode", "unref_function", unref_function);
			} else if (free_function != null && free_function != "%sfree".printf (get_lower_case_cprefix (cl))) {
				cl.set_attribute_string ("CCode", "free_function", free_function);
			}

			current_data_type = null;
		}
	}
	
	private void parse_enum (IdlNodeEnum en_node, Symbol container, IdlModule module, bool is_flags) {
		weak IdlNode node = (IdlNode) en_node;
		string name = fix_type_name (node.name, container);
		bool existing = true;

		var en = container.scope.lookup (name) as Enum;
		if (en == null) {
			en = new Enum (name, current_source_reference);
			en.access = SymbolAccessibility.PUBLIC;
			existing = false;
		} else {
			// ignore dummy enum values in -custom.vala files
			// they exist for syntactical reasons
			var dummy = (EnumValue) en.scope.lookup ("__DUMMY__");
			if (dummy != null) {
				en.get_values ().remove (dummy);
				en.scope.remove ("__DUMMY__");
			}
		}

		if (en_node.gtype_name == null || en_node.gtype_name == "") {
			en.set_attribute_bool ("CCode", "has_type_id", false);
		}
		
		string common_prefix = null;
		
		foreach (weak IdlNode value in en_node.values) {
			var val_attributes = get_attributes (value.name);
			bool is_hidden = false;
			if (val_attributes != null) {
				foreach (string attr in val_attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "hidden" && eval(nv[1]) == "1") {
						is_hidden = true;
					}
				}
			}

			if (is_hidden) {
				continue;
			}

			if (common_prefix == null) {
				common_prefix = value.name;
				while (common_prefix.length > 0 && !common_prefix.has_suffix ("_")) {
					// FIXME: could easily be made faster
					common_prefix = common_prefix.substring (0, common_prefix.length - 1);
				}
			} else {
				while (!value.name.has_prefix (common_prefix)) {
					common_prefix = common_prefix.substring (0, common_prefix.length - 1);
				}
			}
			while (common_prefix.length > 0 && (!common_prefix.has_suffix ("_") ||
			       (value.name.get_char (common_prefix.length).isdigit ()) && (value.name.length - common_prefix.length) <= 1)) {
				// enum values may not consist solely of digits
				common_prefix = common_prefix.substring (0, common_prefix.length - 1);
			}
		}

		bool is_errordomain = false;

		string cheader_filename = null;

		var en_attributes = get_attributes (node.name);
		if (en_attributes != null) {
			foreach (string attr in en_attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "common_prefix") {
					common_prefix = eval (nv[1]);
				} else if (nv[0] == "cheader_filename") {
					cheader_filename = eval (nv[1]);
					en.set_attribute_string ("CCode", "cheader_filename", cheader_filename);
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return;
					}
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						en.set_attribute ("Deprecated", true);
					}
				} else if (nv[0] == "default_value") {
					en.set_attribute_string ("CCode", "default_value", eval (nv[1]));
				} else if (nv[0] == "replacement") {
					en.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
				} else if (nv[0] == "deprecated_since") {
					en.set_attribute_string ("Deprecated", "since", eval (nv[1]));
				} else if (nv[0] == "rename_to") {
					en.name = eval (nv[1]);
				} else if (nv[0] == "errordomain") {
					if (eval (nv[1]) == "1") {
						is_errordomain = true;
					}
				} else if (nv[0] == "to_string") {
					var return_type = new UnresolvedType ();
					return_type.unresolved_symbol = new UnresolvedSymbol (null, "string");
					return_type.value_owned = false;
					var m = new Method ("to_string", return_type, current_source_reference);
					m.access = SymbolAccessibility.PUBLIC;
					m.set_attribute_string ("CCode", "cname", eval(nv[1]));
					en.add_method (m);
				} else if (nv[0] == "experimental") {
					if (eval (nv[1]) == "1") {
						en.set_attribute ("Experimental", true);
					}
				}
			}
		}

		en.set_attribute_string ("CCode", "cprefix", common_prefix);
		
		foreach (weak IdlNode value2 in en_node.values) {
			var val_attributes = get_attributes (value2.name);
			bool is_hidden = false;
			if (val_attributes != null) {
				foreach (string attr in val_attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "hidden" && eval(nv[1]) == "1") {
						is_hidden = true;
					}
				}
			}

			if (!is_hidden) {
				var ev = new EnumValue (value2.name.substring (common_prefix.length), null);
				en.add_value (ev);
			}
		}

		if (is_errordomain) {
			var ed = new ErrorDomain (en.name, current_source_reference);
			ed.access = SymbolAccessibility.PUBLIC;
			ed.set_attribute_string ("CCode", "cprefix", common_prefix);

			if (cheader_filename != null) {
				ed.set_attribute_string ("CCode", "cheader_filename", cheader_filename);
			}

			foreach (EnumValue ev in en.get_values ()) {
				ed.add_code (new ErrorCode (ev.name));
			}

			current_source_file.add_node (ed);
			if (!existing) {
				add_symbol_to_container (container, ed);
			}
		} else {
			en.set_attribute ("Flags", is_flags);
			current_source_file.add_node (en);
			if (!existing) {
				add_symbol_to_container (container, en);
			}
		}
	}
	
	private void parse_object (IdlNodeInterface node, Symbol container, IdlModule module) {
		string name = fix_type_name (((IdlNode) node).name, container);

		string base_class = null;

		var cl = container.scope.lookup (name) as Class;
		if (cl == null) {
			cl = new Class (name, current_source_reference);
			cl.access = SymbolAccessibility.PUBLIC;
			
			var attributes = get_attributes (node.gtype_name);
			if (attributes != null) {
				foreach (string attr in attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "cheader_filename") {
						cl.set_attribute_string ("CCode", "cheader_filename", eval (nv[1]));
					} else if (nv[0] == "base_class") {
						base_class = eval (nv[1]);
					} else if (nv[0] == "hidden") {
						if (eval (nv[1]) == "1") {
							return;
						}
					} else if (nv[0] == "type_check_function") {
						cl.set_attribute_string ("CCode", "type_check_function", eval (nv[1]));
					} else if (nv[0] == "deprecated") {
						if (eval (nv[1]) == "1") {
							cl.set_attribute ("Deprecated", true);
						}
					} else if (nv[0] == "replacement") {
						cl.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
					} else if (nv[0] == "deprecated_since") {
						cl.set_attribute_string ("Deprecated", "since", eval (nv[1]));
					} else if (nv[0] == "type_id") {
						cl.set_attribute_string ("CCode", "type_id", eval (nv[1]));
					} else if (nv[0] == "abstract") {
						if (eval (nv[1]) == "1") {
							cl.is_abstract = true;
						}
					} else if (nv[0] == "experimental") {
						if (eval (nv[1]) == "1") {
							cl.set_attribute ("Experimental", true);
						}
					}
				}
			}

			add_symbol_to_container (container, cl);
			current_source_file.add_node (cl);
		}

		if (base_class != null) {
			var parent = parse_type_string (base_class);
			cl.add_base_type (parent);
		} else if (node.parent != null) {
			var parent = parse_type_string (node.parent);
			cl.add_base_type (parent);
		} else {
			var gobject_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, "GLib"), "Object");
			cl.add_base_type (new UnresolvedType.from_symbol (gobject_symbol));
		}
		
		foreach (string iface_name in node.interfaces) {
			bool skip_iface = false;

			var attributes = get_attributes (iface_name);
			if (attributes != null) {
				foreach (string attr in attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "hidden") {
						if (eval (nv[1]) == "1") {
							skip_iface = true;
						}
					}
				}
			}

			if (skip_iface) {
				continue;
			}

			var iface = parse_type_string (iface_name);
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
					cl.add_property (prop);
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
				prop.set_attribute ("NoAccessorMethod", true);
			}
			
			var setter = "set_%s".printf (prop.name);
			
			if (prop.set_accessor != null && prop.set_accessor.writable
			    && !current_type_symbol_set.contains (setter)) {
				prop.set_attribute ("NoAccessorMethod", true);
			}

			if (prop.get_attribute ("NoAccessorMethod") != null && prop.get_accessor != null) {
				prop.get_accessor.value_type.value_owned = true;
			}
		}

		handle_async_methods (cl);

		if (cl.default_construction_method == null) {
			// always provide constructor in generated bindings
			// to indicate that implicit Object () chainup is allowed
			var cm = new CreationMethod (null, null, cl.source_reference);
			cm.has_construct_function = false;
			cm.access = SymbolAccessibility.PROTECTED;
			cl.add_method (cm);
		}

		current_data_type = null;
		current_type_symbol_set = null;
	}

	private void parse_interface (IdlNodeInterface node, Symbol container, IdlModule module) {
		string name = fix_type_name (node.gtype_name, container);

		var iface = container.scope.lookup (name) as Interface;
		if (iface == null) {
			iface = new Interface (name, current_source_reference);
			iface.access = SymbolAccessibility.PUBLIC;
			
			var attributes = get_attributes (node.gtype_name);
			if (attributes != null) {
				foreach (string attr in attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "cheader_filename") {
						iface.set_attribute_string ("CCode", "cheader_filename", eval (nv[1]));
					} else if (nv[0] == "hidden") {
						if (eval (nv[1]) == "1") {
							return;
						}
					} else if (nv[0] == "type_cname") {
						iface.set_attribute_string ("CCode", "type_cname", eval (nv[1]));
					} else if (nv[0] == "lower_case_csuffix") {
						iface.set_attribute_string ("CCode", "lower_case_csuffix", eval (nv[1]));
					}
				}
			}
			
			foreach (string prereq_name in node.prerequisites) {
				var prereq = parse_type_string (prereq_name);
				iface.add_prerequisite (prereq);
			}

			add_symbol_to_container (container, iface);
			current_source_file.add_node (iface);
		}

		current_data_type = iface;

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
					sig.is_virtual = false;
				}
			}
		}

		foreach (Property prop in iface.get_properties ()) {
			var getter = "get_%s".printf (prop.name);

			if (prop.get_accessor != null && !current_type_symbol_set.contains (getter)) {
				prop.set_attribute ("NoAccessorMethod", true);
			}

			var setter = "set_%s".printf (prop.name);

			if (prop.set_accessor != null && prop.set_accessor.writable
			    && !current_type_symbol_set.contains (setter)) {
				prop.set_attribute ("NoAccessorMethod", true);
			}

			if (prop.get_attribute ("NoAccessorMethod") != null && prop.get_accessor != null) {
				prop.get_accessor.value_type.value_owned = true;
			}
		}

		handle_async_methods (iface);

		current_data_type = null;
	}

	void handle_async_methods (ObjectTypeSymbol type_symbol) {
		Set<Method> finish_methods = new HashSet<Method> ();
		var methods = type_symbol.get_methods ();

		foreach (Method m in methods) {
			if (m.coroutine) {
				string finish_method_base;
				if (m.name.has_suffix ("_async")) {
					finish_method_base = m.name.substring (0, m.name.length - "_async".length);
				} else {
					finish_method_base = m.name;
				}
				var finish_method = type_symbol.scope.lookup (finish_method_base + "_finish") as Method;

				// check if the method is using non-standard finish method name
				if (finish_method == null) {
					var method_cname = get_finish_cname (m);
					foreach (Method method in type_symbol.get_methods ()) {
						if (get_cname (method) == method_cname) {
							finish_method = method;
							break;
						}
					}
				}

				if (finish_method != null) {
					m.return_type = finish_method.return_type.copy ();
					var a = finish_method.get_attribute ("CCode");
					if (a != null && a.has_argument ("array_length")) {
						m.set_attribute_bool ("CCode", "array_length", a.get_bool ("array_length"));
					}
					if (a != null && a.has_argument ("array_null_terminated")) {
						m.set_attribute_bool ("CCode", "array_null_terminated", a.get_bool ("array_null_terminated"));
					}
					foreach (var param in finish_method.get_parameters ()) {
						if (param.direction == ParameterDirection.OUT) {
							var async_param = param.copy ();
							if (m.scope.lookup (param.name) != null) {
								// parameter name conflict
								async_param.name += "_out";
							}
							m.add_parameter (async_param);
						}
					}
					foreach (DataType error_type in finish_method.get_error_types ()) {
						m.add_error_type (error_type.copy ());
					}
					finish_methods.add (finish_method);
				}
			}
		}

		foreach (Method m in finish_methods)
		{
			type_symbol.scope.remove (m.name);
			methods.remove (m);
		}
	}
	
	private DataType? parse_type (IdlNodeType type_node, out ParameterDirection direction = null) {
		direction = ParameterDirection.IN;

		var type = new UnresolvedType ();
		if (type_node.tag == TypeTag.VOID) {
			if (type_node.is_pointer) {
				return new PointerType (new VoidType ());
			} else {
				return new VoidType ();
			}
		} else if (type_node.tag == TypeTag.BOOLEAN) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "bool");
		} else if (type_node.tag == TypeTag.INT8) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "char");
		} else if (type_node.tag == TypeTag.UINT8) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "uchar");
		} else if (type_node.tag == TypeTag.INT16) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "int16");
		} else if (type_node.tag == TypeTag.UINT16) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "uint16");
		} else if (type_node.tag == TypeTag.INT32) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "int32");
		} else if (type_node.tag == TypeTag.UINT32) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "uint32");
		} else if (type_node.tag == TypeTag.INT64) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "int64");
		} else if (type_node.tag == TypeTag.UINT64) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "uint64");
		} else if (type_node.tag == TypeTag.INT) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "int");
		} else if (type_node.tag == TypeTag.UINT) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "uint");
		} else if (type_node.tag == TypeTag.LONG) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "long");
		} else if (type_node.tag == TypeTag.ULONG) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "ulong");
		} else if (type_node.tag == TypeTag.SSIZE) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "ssize_t");
		} else if (type_node.tag == TypeTag.SIZE) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "size_t");
		} else if (type_node.tag == TypeTag.FLOAT) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "float");
		} else if (type_node.tag == TypeTag.DOUBLE) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "double");
		} else if (type_node.tag == TypeTag.UTF8) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "string");
		} else if (type_node.tag == TypeTag.FILENAME) {
			type.unresolved_symbol = new UnresolvedSymbol (null, "string");
		} else if (type_node.tag == TypeTag.ARRAY) {
			var element_type = parse_type (type_node.parameter_type1);
			type = element_type as UnresolvedType;
			if (type == null) {
				return element_type;
			}
			return new ArrayType (element_type, 1, element_type.source_reference);
		} else if (type_node.tag == TypeTag.LIST) {
			type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, "GLib"), "List");
		} else if (type_node.tag == TypeTag.SLIST) {
			type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, "GLib"), "SList");
		} else if (type_node.tag == TypeTag.HASH) {
			type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, "GLib"), "HashTable");
		} else if (type_node.tag == TypeTag.ERROR) {
			type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, "GLib"), "Error");
		} else if (type_node.is_interface) {
			var n = type_node.@interface;
			
			if (n == "") {
				return null;
			}
			
			if (n.has_prefix ("const-")) {
				n = n.substring ("const-".length);
			}

			if (type_node.is_pointer &&
			    (n == "gchar" || n == "char")) {
				type.unresolved_symbol = new UnresolvedSymbol (null, "string");
				if (type_node.unparsed.has_suffix ("**")) {
					direction = ParameterDirection.OUT;
				}
			} else if (n == "gunichar") {
				type.unresolved_symbol = new UnresolvedSymbol (null, "unichar");
			} else if (n == "gchar") {
				type.unresolved_symbol = new UnresolvedSymbol (null, "char");
			} else if (n == "guchar" || n == "guint8") {
				type.unresolved_symbol = new UnresolvedSymbol (null, "uchar");
				if (type_node.is_pointer) {
					return new ArrayType (type, 1, type.source_reference);
				}
			} else if (n == "gushort") {
				type.unresolved_symbol = new UnresolvedSymbol (null, "ushort");
			} else if (n == "gshort") {
				type.unresolved_symbol = new UnresolvedSymbol (null, "short");
			} else if (n == "gconstpointer" || n == "void") {
				return new PointerType (new VoidType ());
			} else if (n == "goffset" || n == "off_t") {
				type.unresolved_symbol = new UnresolvedSymbol (null, "int64");
			} else if (n == "value_array") {
				type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, "GLib"), "ValueArray");
			} else if (n == "time_t") {
				type.unresolved_symbol = new UnresolvedSymbol (null, "ulong");
			} else if (n == "socklen_t") {
				type.unresolved_symbol = new UnresolvedSymbol (null, "uint32");
			} else if (n == "mode_t") {
				type.unresolved_symbol = new UnresolvedSymbol (null, "uint");
			} else if (n == "gint" || n == "pid_t") {
				type.unresolved_symbol = new UnresolvedSymbol (null, "int");
			} else if (n == "unsigned" || n == "unsigned-int") {
				type.unresolved_symbol = new UnresolvedSymbol (null, "uint");
			} else if (n == "FILE") {
				type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, "GLib"), "FileStream");
			} else if (n == "struct") {
				return new PointerType (new VoidType ());
			} else if (n == "iconv_t") {
				return new PointerType (new VoidType ());
			} else if (n == "GType") {
				type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, "GLib"), "Type");
				if (type_node.is_pointer) {
					return new ArrayType (type, 1, type.source_reference);
				}
			} else if (n == "GStrv") {
				type.unresolved_symbol = new UnresolvedSymbol (null, "string");
				return new ArrayType (type, 1, type.source_reference);
			} else {
				var named_type = parse_type_string (n);
				type = named_type as UnresolvedType;
				if (type == null) {
					return named_type;
				}
				if (is_simple_type (n)) {
					if (type_node.is_pointer) {
						direction = ParameterDirection.OUT;
					}
				} else if (type_node.unparsed.has_suffix ("**")) {
					direction = ParameterDirection.OUT;
				}
			}
		} else {
			stdout.printf ("%d\n", type_node.tag);
		}
		return type;
	}
	
	private bool is_simple_type (string type_name) {
		var st = cname_type_map[type_name] as Struct;
		if (st != null && st.is_simple_type ()) {
			return true;
		}

		return false;
	}

	private DataType parse_type_string (string n) {
		if (n == "va_list") {
			// unsupported
			return new PointerType (new VoidType ());
		}

		var type = new UnresolvedType ();

		var dt = cname_type_map[n];
		if (dt != null) {
			UnresolvedSymbol parent_symbol = null;
			if (dt.parent_symbol.name != null) {
				parent_symbol = new UnresolvedSymbol (null, dt.parent_symbol.name);
			}
			type.unresolved_symbol = new UnresolvedSymbol (parent_symbol, dt.name);
			return type;
		}

		var type_attributes = get_attributes (n);

		string ns_name = null;

		if (null != type_attributes) {
			foreach (string attr in type_attributes) {
				var nv = attr.split ("=", 2);

				if (nv[0] == "cprefix") {
					type.unresolved_symbol = new UnresolvedSymbol (null, n.substring (eval (nv[1]).length));
				} else if (nv[0] == "name") {
					type.unresolved_symbol = new UnresolvedSymbol (null, eval (nv[1]));
				} else if (nv[0] == "namespace") {
					ns_name = eval (nv[1]);
				} else if (nv[0] == "rename_to") {
					type.unresolved_symbol = new UnresolvedSymbol (null, eval (nv[1]));
				}
			}
		}

		if (type.unresolved_symbol != null) {
			if (type.unresolved_symbol.name == "pointer") {
				return new PointerType (new VoidType ());
			}
			if (ns_name != null) {
				type.unresolved_symbol.inner = new UnresolvedSymbol (null, ns_name);
			}
			return type;
		}

		if (n.has_prefix (current_namespace.name)) {
			type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, current_namespace.name), n.substring (current_namespace.name.length));
		} else if (current_namespace.parent_symbol != null && current_namespace.parent_symbol.name != null && n.has_prefix (current_namespace.parent_symbol.name)) {
			type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, current_namespace.parent_symbol.name), n.substring (current_namespace.parent_symbol.name.length));
		} else if (n.has_prefix ("G")) {
			type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, "GLib"), n.substring (1));
		} else {
			var name_parts = n.split (".", 2);
			if (name_parts[1] == null) {
				type.unresolved_symbol = new UnresolvedSymbol (null, name_parts[0]);
			} else {
				type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, name_parts[0]), name_parts[1]);
			}
		}

		return type;
	}
	
	private DataType? parse_param (IdlNodeParam param, out ParameterDirection direction = null) {
		var type = parse_type (param.type, out direction);

		// disable for now as null_ok not yet correctly set
		// type.non_null = !param.null_ok;
		
		return type;
	}

	private UnresolvedSymbol? parse_symbol_from_string (string symbol_string, SourceReference? source_reference = null) {
		UnresolvedSymbol? sym = null;
		foreach (unowned string s in symbol_string.split (".")) {
			sym = new UnresolvedSymbol (sym, s, source_reference);
		}
		if (sym == null) {
			Report.error (source_reference, "a symbol must be specified");
		}
		return sym;
	}

	private bool parse_type_arguments_from_string (DataType parent_type, string type_arguments, SourceReference? source_reference = null) {
		int type_arguments_length = (int) type_arguments.length;
		GLib.StringBuilder current = new GLib.StringBuilder.sized (type_arguments_length);

		int depth = 0;
		for (var c = 0 ; c < type_arguments_length ; c++) {
			if (type_arguments[c] == '<' || type_arguments[c] == '[') {
				depth++;
				current.append_unichar (type_arguments[c]);
			} else if (type_arguments[c] == '>' || type_arguments[c] == ']') {
				depth--;
				current.append_unichar (type_arguments[c]);
			} else if (type_arguments[c] == ',') {
				if (depth == 0) {
					var dt = parse_type_from_string (current.str, true, source_reference);
					if (dt == null) {
						return false;
					}
					parent_type.add_type_argument (dt);
					current.truncate ();
				} else {
					current.append_unichar (type_arguments[c]);
				}
			} else {
				current.append_unichar (type_arguments[c]);
			}
		}

		var dt = parse_type_from_string (current.str, true, source_reference);
		if (dt == null) {
			return false;
		}
		parent_type.add_type_argument (dt);

		return true;
	}

	private DataType? parse_type_from_string (string type_string, bool owned_by_default, SourceReference? source_reference = null) {
		if (type_from_string_regex == null) {
			try {
				type_from_string_regex = new GLib.Regex ("^(?:(owned|unowned|weak) +)?([0-9a-zA-Z_\\.]+)(?:<(.+)>)?(\\*+)?(\\[(,*)?\\])?(\\?)?$", GLib.RegexCompileFlags.ANCHORED | GLib.RegexCompileFlags.DOLLAR_ENDONLY | GLib.RegexCompileFlags.OPTIMIZE);
			} catch (GLib.RegexError e) {
				GLib.error ("Unable to compile regex: %s", e.message);
			}
		}

		GLib.MatchInfo match;
		if (!type_from_string_regex.match (type_string, 0, out match)) {
			Report.error (source_reference, "unable to parse type");
			return null;
		}

		DataType? type = null;

		var ownership_data = match.fetch (1);
		var type_name = match.fetch (2);
		var type_arguments_data = match.fetch (3);
		var pointers_data = match.fetch (4);
		var array_data = match.fetch (5);
		var array_dimension_data = match.fetch (6);
		var nullable_data = match.fetch (7);

		var nullable = nullable_data != null && nullable_data.length > 0;

		if (ownership_data == null && type_name == "void") {
			if (array_data == null && !nullable) {
				type = new VoidType (source_reference);
				if (pointers_data != null) {
					for (int i=0; i < pointers_data.length; i++) {
						type = new PointerType (type);
					}
				}
				return type;
			} else {
				Report.error (source_reference, "invalid void type");
				return null;
			}
		}

		bool value_owned = owned_by_default;

		if (ownership_data == "owned") {
			value_owned = true;
		} else if (ownership_data == "unowned") {
			value_owned = false;
		}

		var sym = parse_symbol_from_string (type_name, source_reference);
		if (sym == null) {
			return null;
		}
		type = new UnresolvedType.from_symbol (sym, source_reference);

		if (type_arguments_data != null && type_arguments_data.length > 0) {
			if (!parse_type_arguments_from_string (type, type_arguments_data, source_reference)) {
				return null;
			}
		}

		if (pointers_data != null) {
			for (int i=0; i < pointers_data.length; i++) {
				type = new PointerType (type);
			}
		}

		if (array_data != null && array_data.length > 0) {
			type = new ArrayType (type, array_dimension_data.length + 1, source_reference);
		}

		type.nullable = nullable;
		type.value_owned = value_owned;
		return type;
	}

	private Method? create_method (string name, string symbol, IdlNodeParam? res, GLib.List<IdlNodeParam>? parameters, bool is_constructor, bool is_interface) {
		DataType return_type = null;
		if (res != null) {
			return_type = parse_param (res);
		}
		
		Method m;
		if (!is_interface && (is_constructor || name.has_prefix ("new"))) {
			m = new CreationMethod (null, name, current_source_reference);
			m.has_construct_function = false;
			if (m.name == "new") {
				m.name = null;
			} else if (m.name.has_prefix ("new_")) {
				m.name = m.name.substring ("new_".length);
			}
			// For classes, check whether a creation method return type equals to the
			// type of the class created. If the types do not match (e.g. in most
			// gtk widgets) add an attribute to the creation method indicating the used
			// return type.
			if (current_data_type is Class && res != null) {
				if ("%s*".printf (get_cname (current_data_type)) != res.type.unparsed) {
					m.set_attribute_string ("CCode", "type", res.type.unparsed);
				}
			}
		} else {
			m = new Method (name, return_type, current_source_reference);
		}
		m.access = SymbolAccessibility.PUBLIC;

		if (current_type_symbol_set != null) {
			current_type_symbol_set.add (name);
		}
		
		if (current_data_type != null) {
			var sig_attributes = get_attributes ("%s::%s".printf (get_cname (current_data_type), name));
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
		string? error_types = null;
		Symbol? container = null;

		var attributes = get_attributes (symbol);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "name") {
					m.name = eval (nv[1]);
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				} else if (nv[0] == "ellipsis") {
					if (eval (nv[1]) == "1") {
						add_ellipsis = true;
					}
				} else if (nv[0] == "printf_format") {
					if (eval (nv[1]) == "1") {
						m.set_attribute ("PrintfFormat", true);
					}
				} else if (nv[0] == "transfer_ownership") {
					if (eval (nv[1]) == "1") {
						return_type.value_owned = true;
					}
				} else if (nv[0] == "destroys_instance") {
					if (eval (nv[1]) == "1") {
						m.set_attribute ("DestroysInstance", true, m.source_reference);
					}
				} else if (nv[0] == "nullable") {
					if (eval (nv[1]) == "1") {
						return_type.nullable = true;
					}
				} else if (nv[0] == "sentinel") {
					m.set_attribute_string ("CCode", "sentinel", eval (nv[1]));
				} else if (nv[0] == "is_array") {
					if (eval (nv[1]) == "1") {
						return_type = new ArrayType (return_type, 1, return_type.source_reference);
						m.return_type = return_type;
					}
				} else if (nv[0] == "is_pointer") {
					if (eval (nv[1]) == "1") {
						return_type = new PointerType (return_type, return_type.source_reference);
						m.return_type = return_type;
					}
				} else if (nv[0] == "throws") {
					if (eval (nv[1]) == "0") {
						suppress_throws = true;
					}
				} else if (nv[0] == "error_types") {
					error_types = eval (nv[1]);
				} else if (nv[0] == "no_array_length") {
					if (eval (nv[1]) == "1") {
						m.set_attribute_bool ("CCode", "array_length", false);
					}
				} else if (nv[0] == "array_null_terminated") {
					if (eval (nv[1]) == "1") {
						m.set_attribute_bool ("CCode", "array_length", false);
						m.set_attribute_bool ("CCode", "array_null_terminated", true);;
					}
				} else if (nv[0] == "array_length_type") {
					m.set_attribute_string ("CCode", "array_length_type", eval (nv[1]));
				} else if (nv[0] == "type_name") {
					m.return_type = return_type = parse_type_from_string (eval (nv[1]), return_type.value_owned);
				} else if (nv[0] == "ctype") {
					m.set_attribute_string ("CCode", "type", eval (nv[1]));
				} else if (nv[0] == "type_arguments") {
					parse_type_arguments_from_string (return_type, eval (nv[1]));
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						m.set_attribute ("Deprecated", true);
					}
				} else if (nv[0] == "replacement") {
					m.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
				} else if (nv[0] == "deprecated_since") {
					m.set_attribute_string ("Deprecated", "since", eval (nv[1]));
				} else if (nv[0] == "cheader_filename") {
					m.set_attribute_string ("CCode", "cheader_filename", eval (nv[1]));
				} else if (nv[0] == "abstract") {
					if (eval (nv[1]) == "1") {
						m.is_abstract = true;
					}
				} else if (nv[0] == "virtual") {
					if (eval (nv[1]) == "1") {
						m.is_virtual = true;
					}
				} else if (nv[0] == "vfunc_name") {
					m.set_attribute_string ("CCode", "vfunc_name", eval (nv[1]));
				} else if (nv[0] == "finish_name") {
					m.set_attribute_string ("CCode", "finish_name", eval (nv[1]));
				} else if (nv[0] == "async") {
					if (eval (nv[1]) == "1") {
						// force async function, even if it doesn't end in _async
						m.coroutine = true;
					}
				} else if (nv[0] == "parent") {
					container = get_container_from_name (eval (nv[1]));
					var prefix = get_lower_case_cprefix (container);
					if (symbol.has_prefix (prefix)) {
						m.name = symbol.substring (prefix.length);
					}
				} else if (nv[0] == "experimental") {
					if (eval (nv[1]) == "1") {
						m.set_attribute ("Experimental", true);
					}
				} else if (nv[0] == "simple_generics") {
					if (eval (nv[1]) == "1") {
						m.set_attribute_bool ("CCode", "simple_generics", true);
					}
				}
			}
		}
	
		bool first = true;
		Parameter last_param = null;
		DataType last_param_type = null;
		foreach (weak IdlNodeParam param in parameters) {
			weak IdlNode param_node = (IdlNode) param;
			
			if (first) {
				first = false;
				if (!(m is CreationMethod) &&
				    current_data_type != null &&
				    param.type.is_interface &&
				    (param_node.name == "self" ||
				     param.type.@interface.has_suffix (get_cname (current_data_type)))) {
					// instance method
					continue;
				} else if (!(m is CreationMethod) &&
				    current_data_type != null &&
				    param.type.is_interface &&
				    (param_node.name == "klass" ||
				     param.type.@interface.has_suffix ("%sClass".printf(get_cname (current_data_type))))) {
					// class method
					m.binding = MemberBinding.CLASS;
					if (m.name.has_prefix ("class_")) {
						m.name = m.name.substring ("class_".length, m.name.length - "class_".length);
					}
					continue;
				} else {
					// static method
					m.binding = MemberBinding.STATIC;
				}
			}

			if (param.type.@interface == "GAsyncReadyCallback" && (symbol.has_suffix ("_async") || m.coroutine)) {
				// async method
				m.coroutine = true;
				continue;
			}

			// check for GError parameter
			if (suppress_throws == false && param_is_exception (param)) {
				if (error_types == null)
					m.add_error_type (parse_type (param.type));
				continue;
			}

			string param_name = param_node.name;
			if (param_name == "result") {
				// avoid conflict with generated result variable
				param_name = "_result";
			} else if (param_name == "string") {
				// avoid conflict with string type
				param_name = "str";
			}
			ParameterDirection direction;
			var param_type = parse_param (param, out direction);
			var p = new Parameter (param_name, param_type);
			p.direction = direction;

			bool hide_param = false;
			bool show_param = false;
			bool set_array_length_pos = false;
			double array_length_pos = 0;
			bool set_delegate_target_pos = false;
			double delegate_target_pos = 0;
			bool array_requested = false;
			bool out_requested = false;
			attributes = get_attributes ("%s.%s".printf (symbol, param_node.name));
			if (attributes != null) {
				foreach (string attr in attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "is_array") {
						if (eval (nv[1]) == "1") {
							param_type = new ArrayType (param_type, 1, param_type.source_reference);
							p.variable_type = param_type;
							if (!out_requested) {
								p.direction = ParameterDirection.IN;
							}
							array_requested = true;
						}
					} else if (nv[0] == "is_pointer") {
						if (eval (nv[1]) == "1") {
							param_type = new PointerType (param_type, return_type.source_reference);
							p.variable_type = param_type;
							if (!out_requested) {
								p.direction = ParameterDirection.IN;
							}
						}
					} else if (nv[0] == "is_out") {
						if (eval (nv[1]) == "1") {
							p.direction = ParameterDirection.OUT;
							out_requested = true;
							if (!array_requested && param_type is ArrayType) {
								var array_type = (ArrayType) param_type;
								param_type = array_type.element_type;
								p.variable_type = param_type;
							}
						}
					} else if (nv[0] == "is_ref") {
						if (eval (nv[1]) == "1") {
							p.direction = ParameterDirection.REF;
							if (!array_requested && param_type is ArrayType) {
								var array_type = (ArrayType) param_type;
								param_type = array_type.element_type;
								p.variable_type = param_type;
							}
						}
					} else if (nv[0] == "nullable") {
						if (eval (nv[1]) == "1") {
							param_type.nullable = true;
						}
					} else if (nv[0] == "transfer_ownership") {
						if (eval (nv[1]) == "1") {
							param_type.value_owned = true;
						}
					} else if (nv[0] == "takes_ownership") {
						if (eval (nv[1]) == "1") {
							param_type.value_owned = true;
						}
					} else if (nv[0] == "value_owned") {
						if (eval (nv[1]) == "0") {
							param_type.value_owned = false;
						} else if (eval (nv[1]) == "1") {
							param_type.value_owned = true;
						}
					} else if (nv[0] == "hidden") {
						if (eval (nv[1]) == "1") {
							hide_param = true;
						} else if (eval (nv[1]) == "0") {
							show_param = true;
						}
					} else if (nv[0] == "no_array_length") {
						if (eval (nv[1]) == "1") {
							p.set_attribute_bool ("CCode", "array_length", false);
						}
					} else if (nv[0] == "array_length_type") {
						p.set_attribute_string ("CCode", "array_length_type", eval (nv[1]));
					} else if (nv[0] == "array_null_terminated") {
						if (eval (nv[1]) == "1") {
							p.set_attribute_bool ("CCode", "array_length", false);
							p.set_attribute_bool ("CCode", "array_null_terminated", true);
						}
					} else if (nv[0] == "array_length_pos") {
						set_array_length_pos = true;
						array_length_pos = double.parse (eval (nv[1]));
					} else if (nv[0] == "delegate_target_pos") {
						set_delegate_target_pos = true;
						delegate_target_pos = double.parse (eval (nv[1]));
					} else if (nv[0] == "type_name") {
						p.variable_type = param_type = parse_type_from_string (eval (nv[1]), false);
					} else if (nv[0] == "ctype") {
						p.set_attribute_string ("CCode", "type", eval (nv[1]));
					} else if (nv[0] == "type_arguments") {
						parse_type_arguments_from_string (param_type, eval (nv[1]));
					} else if (nv[0] == "default_value") {
						var val = eval (nv[1]);
						if (val == "null") {
							p.initializer = new NullLiteral (param_type.source_reference);
						} else if (val == "true") {
							p.initializer = new BooleanLiteral (true, param_type.source_reference);
						} else if (val == "false") {
							p.initializer = new BooleanLiteral (false, param_type.source_reference);
						} else if (val == "") {
							p.initializer = new StringLiteral ("\"\"", param_type.source_reference);
						} else {
							if (int64.try_parse (val)) {
								p.initializer = new IntegerLiteral (val, param_type.source_reference);
							} else {
								if (double.try_parse (val)) {
									p.initializer = new RealLiteral (val, param_type.source_reference);
								} else {
									if (val.has_prefix ("\"") && val.has_suffix ("\"")) {
										p.initializer = new StringLiteral (val, param_type.source_reference);
									} else {
										foreach (var member in val.split (".")) {
											p.initializer = new MemberAccess (p.initializer, member, param_type.source_reference);
										}
									}
								}
							}
						}
					}
				}
			}

			if (last_param != null && p.name == "n_" + last_param.name) {
				if (!(last_param_type is ArrayType)) {
					// last_param is array, p is array length
					last_param_type = new ArrayType (last_param_type, 1, last_param_type.source_reference);
					last_param.variable_type = last_param_type;
					last_param.direction = ParameterDirection.IN;
				}

				// hide array length param
				hide_param = true;
			} else if (last_param != null && p.name == "user_data") {
				// last_param is delegate

				// hide deleate target param
				hide_param = true;
			}

			if (show_param || !hide_param) {
				m.add_parameter (p);
				if (set_array_length_pos) {
					p.set_attribute_double ("CCode", "array_length_pos", array_length_pos);
				}
				if (set_delegate_target_pos) {
					p.set_attribute_double ("CCode", "delegate_target_pos", delegate_target_pos);
				}
			}

			last_param = p;
			last_param_type = param_type;
		}

		if (suppress_throws == false && error_types != null) {
			var type_args = eval (error_types).split (",");
			foreach (string type_arg in type_args) {
				m.add_error_type (parse_type_from_string (type_arg, true));
			}
		}

		if (first) {
			// no parameters => static method
			m.binding = MemberBinding.STATIC;
		}

		if (last_param != null && last_param.name.has_prefix ("first_")) {
			last_param.ellipsis = true;
		} else if (add_ellipsis) {
			m.add_parameter (new Parameter.with_ellipsis ());
		}

		if (container == null) {
			container = current_data_type;
			if (container == null) {
				container = current_namespace;
			}
		}
		if (symbol != get_cname (m, container)) {
			m.set_attribute_string ("CCode", "cname", symbol);
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

	private Method? parse_function (IdlNodeFunction f, bool is_interface = false) {
		weak IdlNode node = (IdlNode) f;
		
		if (f.deprecated) {
			return null;
		}
	
		return create_method (node.name, f.symbol, f.result, f.parameters, f.is_constructor, is_interface);
	}

	private Method parse_virtual (IdlNodeVFunc v, IdlNodeFunction? func, bool is_interface = false) {
		weak IdlNode node = (IdlNode) v;
		string symbol = "%s%s".printf (get_lower_case_cprefix (current_data_type), node.name);

		if (func != null) {
			symbol = func.symbol;
		}

		Method m = create_method (node.name, symbol, v.result, func != null ? func.parameters : v.parameters, false, is_interface);
		if (m != null) {
			m.binding = MemberBinding.INSTANCE;
			m.is_virtual = !(m.is_abstract || is_interface);
			m.is_abstract = m.is_abstract || is_interface;

			var attributes = get_attributes (symbol);
			if (attributes != null) {
				foreach (string attr in attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "virtual") {
						if (eval (nv[1]) == "0") {
							m.is_virtual = false;
							m.is_abstract = false;
						} else {
							m.is_virtual = true;
							m.is_abstract = false;
						}
					}
				}
			}

			if (func == null) {
				m.set_attribute ("NoWrapper", true);
			}
		}

		return m;
	}
	
	private string fix_prop_name (string name) {
		var str = new StringBuilder ();
		
		string i = name;
		
		while (i.length > 0) {
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

	private Property? parse_property (IdlNodeProperty prop_node) {
		weak IdlNode node = (IdlNode) prop_node;
		
		if (prop_node.deprecated) {
			return null;
		}
		
		if (!prop_node.readable && !prop_node.writable) {
			// buggy GIDL definition
			prop_node.readable = true;
			prop_node.writable = true;
		}
		
		var prop = new Property (fix_prop_name (node.name), parse_type (prop_node.type), null, null, current_source_reference);
		prop.access = SymbolAccessibility.PUBLIC;
		prop.interface_only = true;

		if (prop_node.type.is_interface && prop_node.type.interface == "GStrv") {
			prop.set_attribute_bool ("CCode", "array_length", false);
			prop.set_attribute_bool ("CCode", "array_null_terminated", true);
		}

		if (prop_node.readable) {
			prop.get_accessor = new PropertyAccessor (true, false, false, prop.property_type.copy (), null, null);
		}
		if (prop_node.writable) {
			prop.set_accessor = new PropertyAccessor (false, false, false, prop.property_type.copy (), null, null);
			if (prop_node.construct_only) {
				prop.set_accessor.construction = true;
			} else {
				prop.set_accessor.writable = true;
				prop.set_accessor.construction = prop_node.@construct;
			}
		}

		var attributes = get_attributes ("%s:%s".printf (get_cname (current_data_type), node.name));
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				} else if (nv[0] == "type_arguments") {
					parse_type_arguments_from_string (prop.property_type, eval (nv[1]));
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						prop.set_attribute ("Deprecated", true);
					}
				} else if (nv[0] == "replacement") {
					prop.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
				} else if (nv[0] == "deprecated_since") {
					prop.set_attribute_string ("Deprecated", "since", eval (nv[1]));
				} else if (nv[0] == "accessor_method") {
					if (eval (nv[1]) == "0") {
						prop.set_attribute ("NoAccessorMethod", true);
					}
				} else if (nv[0] == "owned_get") {
					if (eval (nv[1]) == "1") {
						prop.get_accessor.value_type.value_owned = true;
					}
				} else if (nv[0] == "type_name") {
					prop.property_type = parse_type_from_string (eval (nv[1]), false);
				} else if (nv[0] == "experimental") {
					if (eval (nv[1]) == "1") {
						prop.set_attribute ("Experimental", true);
					}
				} else if (nv[0] == "nullable") {
					if (eval (nv[1]) == "1") {
						prop.property_type.nullable = true;
					}
				} else if (nv[0] == "abstract") {
					if (eval (nv[1]) == "1") {
						prop.is_abstract = true;
					}
				}
			}
		}

		if (current_type_symbol_set != null) {
			current_type_symbol_set.add (prop.name);
		}
		
		return prop;
	}

	private Constant? parse_constant (IdlNodeConstant const_node) {
		weak IdlNode node = (IdlNode) const_node;
		
		var type = parse_type (const_node.type);
		if (type == null) {
			return null;
		}

		var c = new Constant (node.name, type, null, current_source_reference);
		c.external = true;
		
		string[] attributes = get_attributes (node.name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "cheader_filename") {
					c.set_attribute_string ("CCode", "cheader_filename", eval (nv[1]));
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						c.set_attribute ("Deprecated", true);
					}
				} else if (nv[0] == "replacement") {
					c.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
				} else if (nv[0] == "deprecated_since") {
					c.set_attribute_string ("Deprecated", "since", eval (nv[1]));
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				} else if (nv[0] == "experimental") {
					if (eval (nv[1]) == "1") {
						c.set_attribute ("Experimental", true);
					}
				}
			}
		}

		c.access = SymbolAccessibility.PUBLIC;
		
		return c;
	}

	private Field? parse_field (IdlNodeField field_node) {
		weak IdlNode node = (IdlNode) field_node;
		bool unhidden = false;

		var type = parse_type (field_node.type);
		if (type == null) {
			return null;
		}

		string cheader_filename = null;
		string ctype = null;
		string array_length_cname = null;
		string array_length_type = null;
		bool array_null_terminated = false;
		bool deprecated = false;
		string deprecated_since = null;
		string replacement = null;
		bool experimental = false;
		bool no_delegate_target = false;

		var attributes = get_attributes ("%s.%s".printf (get_cname (current_data_type), node.name));
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					} else {
						unhidden = true;
					}
				} else if (nv[0] == "is_array") {
					if (eval (nv[1]) == "1") {
						type = new ArrayType (type, 1, type.source_reference);
					}
				} else if (nv[0] == "weak") {
					if (eval (nv[1]) == "0") {
						type.value_owned = true;
					}
				} else if (nv[0] == "value_owned") {
					if (eval (nv[1]) == "0") {
						type.value_owned = false;
					} else if (eval (nv[1]) == "1") {
						type.value_owned = true;
					}
				} else if (nv[0] == "type_name") {
					type = parse_type_from_string (eval (nv[1]), true);
				} else if (nv[0] == "type_arguments") {
					parse_type_arguments_from_string (type, eval (nv[1]));
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						deprecated = true;
					}
				} else if (nv[0] == "replacement") {
					replacement = eval (nv[1]);
				} else if (nv[0] == "deprecated_since") {
					deprecated_since = eval (nv[1]);
				} else if (nv[0] == "cheader_filename") {
					cheader_filename = eval (nv[1]);
				} else if (nv[0] == "ctype") {
					ctype = eval (nv[1]);
				} else if (nv[0] == "array_null_terminated") {
					if (eval (nv[1]) == "1") {
						array_null_terminated = true;
					}
				} else if (nv[0] == "array_length_cname") {
					array_length_cname = eval (nv[1]);
				} else if (nv[0] == "array_length_type") {
					array_length_type = eval (nv[1]);
				} else if (nv[0] == "no_delegate_target") {
					if (eval (nv[1]) == "1") {
						no_delegate_target = true;
					}
				} else if (nv[0] == "experimental") {
					if (eval (nv[1]) == "1") {
						experimental = true;
					}
				}
			}
		}

		if (node.name.has_prefix("_") && !unhidden) {
			return null;
		}

		if (current_type_symbol_set != null) {
			current_type_symbol_set.add (node.name);
		}

		string field_name = node.name;
		if (field_name == "string") {
			// avoid conflict with string type
			field_name = "str";
		}

		var field = new Field (field_name, type, null, current_source_reference);
		field.access = SymbolAccessibility.PUBLIC;

		if (field_name != node.name) {
			field.set_attribute_string ("CCode", "cname", node.name);
		}

		if (deprecated) {
			field.set_attribute ("Deprecated", true);

			if (deprecated_since != null) {
				field.set_attribute_string ("Deprecated", "since", deprecated_since);
			}

			if (replacement != null) {
				field.set_attribute_string ("Deprecated", "replacement", replacement);
			}
		}

		if (experimental) {
			field.set_attribute ("Experimental", true);
		}

		if (ctype != null) {
			field.set_attribute_string ("CCode", "type", ctype);
		}

		if (cheader_filename != null) {
			field.set_attribute_string ("CCode", "cheader_filename", cheader_filename);
		}

		if (array_null_terminated) {
			field.set_attribute_bool ("CCode", "array_null_terminated", true);
		}

		if (array_length_cname != null || array_length_type != null) {
			if (array_length_cname != null) {
				field.set_attribute_string ("CCode", "array_length_cname", array_length_cname);
			}
			if (array_length_type != null) {
				field.set_attribute_string ("CCode", "array_length_type", array_length_type);
			}
		} else if (field.variable_type is ArrayType) {
			field.set_attribute_bool ("CCode", "array_length", false);
		}

		if (no_delegate_target) {
			field.set_attribute_bool ("CCode", "delegate_target", false);
		}

		return field;
	}

	private string[]? get_attributes (string codenode) {
		var attributes = codenode_attributes_map.get (codenode);

		if (attributes == null) {
			var dot_required = (-1 != codenode.index_of_char ('.'));
			var colon_required = (-1 != codenode.index_of_char (':'));

			var pattern_specs = codenode_attributes_patterns.get_keys ();
			foreach (PatternSpec* pattern in pattern_specs) {
				var pspec = codenode_attributes_patterns[pattern];

				if ((dot_required && -1 == pspec.index_of_char ('.')) ||
				    (colon_required && -1 == pspec.index_of_char (':'))) {
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

		GLib.SList<string> attr_list = new GLib.SList<string> ();
		var attr = new GLib.StringBuilder.sized (attributes.length);
		var attributes_len = attributes.length;
		unowned string remaining = attributes;
		bool quoted = false, escaped = false;
		for (int b = 0 ; b < attributes_len ; b++) {
			unichar c = remaining.get_char ();

			if (escaped) {
				escaped = false;
				attr.append_unichar (c);
			} else {
				if (c == '"') {
					attr.append_unichar (c);
					quoted = !quoted;
				} else if (c == '\\') {
					escaped = true;
				} else if (!quoted && (c == ' ')) {
					attr_list.prepend (attr.str);
					attr.truncate (0);
				} else {
					attr.append_unichar (c);
				}
			}

			remaining = (string) ((char*) remaining + remaining.index_of_nth_char (1));
		}

		if (attr.len > 0) {
			attr_list.prepend (attr.str);
		}

		var attrs = new string[attr_list.length ()];
		unowned GLib.SList<string>? attr_i = attr_list;
		for (int a = 0 ; a < attrs.length ; a++, attr_i = attr_i.next) {
			attrs[(attrs.length - 1) - a] = attr_i.data;
		}

		return attrs;
	}
	
	private string eval (string s) {
		return ((s.length >= 2) && s.has_prefix ("\"") && s.has_suffix ("\"")) ? s.substring (1, s.length - 2) : s;
	}

	private Signal? parse_signal (IdlNodeSignal sig_node) {
		weak IdlNode node = (IdlNode) sig_node;
		
		if (sig_node.deprecated || sig_node.result == null) {
			return null;
		}
		
		var sig = new Signal (fix_prop_name (node.name), parse_param (sig_node.result), current_source_reference);
		sig.access = SymbolAccessibility.PUBLIC;
		
		var attributes = get_attributes ("%s::%s".printf (get_cname (current_data_type), sig.name));
		if (attributes != null) {
			string ns_name = null;
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "name") {
					sig.set_attribute_string ("CCode", "cname", sig.name);
					sig.name = eval (nv[1]);
				} else if (nv[0] == "has_emitter" && eval (nv[1]) == "1") {
					sig.set_attribute ("HasEmitter", true);
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						sig.set_attribute ("Deprecated", true);
					}
				} else if (nv[0] == "replacement") {
					sig.set_attribute_string ("Deprecated", "replacement", eval (nv[1]));
				} else if (nv[0] == "deprecated_since") {
					sig.set_attribute_string ("Deprecated", "since", eval (nv[1]));
				} else if (nv[0] == "transfer_ownership") {
					if (eval (nv[1]) == "1") {
						sig.return_type.value_owned = true;
					}
				} else if (nv[0] == "namespace_name") {
					ns_name = eval (nv[1]);
				} else if (nv[0] == "type_name") {
					sig.return_type = parse_type_from_string (eval (nv[1]), false);
				} else if (nv[0] == "type_arguments") {
					parse_type_arguments_from_string (sig.return_type, eval (nv[1]));
				} else if (nv[0] == "experimental") {
					if (eval (nv[1]) == "1") {
						sig.set_attribute ("Experimental", true);
					}
				}
			}
			if (ns_name != null) {
				((UnresolvedType) sig.return_type).unresolved_symbol.inner = new UnresolvedSymbol (null, ns_name);
			}
		}

		sig.is_virtual = true;

		bool first = true;
		
		foreach (weak IdlNodeParam param in sig_node.parameters) {
			if (first) {
				// ignore implicit first signal parameter (sender)
				first = false;
				continue;
			}
		
			weak IdlNode param_node = (IdlNode) param;
			
			ParameterDirection direction;
			var param_type = parse_param (param, out direction);
			var p = new Parameter (param_node.name, param_type);
			p.direction = direction;

			bool hide_param = false;
			bool show_param = false;
			attributes = get_attributes ("%s::%s.%s".printf (get_cname (current_data_type), sig.name, param_node.name));
			if (attributes != null) {
				string ns_name = null;
				foreach (string attr in attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "hidden") {
						if (eval (nv[1]) == "1") {
							hide_param = true;
						} else if (eval (nv[1]) == "0") {
							show_param = true;
						}
					} else if (nv[0] == "is_array") {
						if (eval (nv[1]) == "1") {
							param_type = new ArrayType (param_type, 1, param_type.source_reference);
							p.variable_type = param_type;
							p.direction = ParameterDirection.IN;
						}
					} else if (nv[0] == "no_array_length") {
						if (eval (nv[1]) == "1") {
							p.set_attribute_bool ("CCode", "array_length", false);
						}
					} else if (nv[0] == "array_length_type") {
						p.set_attribute_string ("CCode", "array_length_type", nv[1]);
					} else if (nv[0] == "array_null_terminated") {
						if (eval (nv[1]) == "1") {
							p.set_attribute_bool ("CCode", "array_length", false);
							p.set_attribute_bool ("CCode", "array_null_terminated", true);
						}
					} else if (nv[0] == "is_out") {
						if (eval (nv[1]) == "1") {
							p.direction = ParameterDirection.OUT;
						}
					} else if (nv[0] == "is_ref") {
						if (eval (nv[1]) == "1") {
							p.direction = ParameterDirection.REF;
						}
					} else if (nv[0] == "nullable") {
						if (eval (nv[1]) == "1") {
							param_type.nullable = true;
						}
					} else if (nv[0] == "transfer_ownership") {
						if (eval (nv[1]) == "1") {
							param_type.value_owned = true;
						}
					} else if (nv[0] == "type_name") {
						p.variable_type = param_type = parse_type_from_string (eval (nv[1]), false);
					} else if (nv[0] == "type_arguments") {
						parse_type_arguments_from_string (p.variable_type, eval (nv[1]));
					} else if (nv[0] == "namespace_name") {
						ns_name = eval (nv[1]);
					}
				}
				if (ns_name != null) {
					((UnresolvedType) param_type).unresolved_symbol.inner = new UnresolvedSymbol (null, ns_name);
				}
			}

			if (show_param || !hide_param) {
				sig.add_parameter (p);
			}
		}
		
		return sig;
	}
}

// vim:sw=8 noet
