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
		if (!cname_type_map.contains (t.get_cname ())) {
			cname_type_map[t.get_cname ()] = t;
		}
	}

	public override void visit_source_file (SourceFile source_file) {
		if (source_file.filename.has_suffix (".gi")) {
			parse_file (source_file);
		}
	}
	
	private void parse_file (SourceFile source_file) {
		string metadata_filename = "%s.metadata".printf (source_file.filename.ndup (source_file.filename.length - ".gi".length));

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

					if (null != tokens[0].chr (-1, '*')) {
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
			return type_name.offset (container.name.length);
		} else if (container.name == "GLib" && type_name.has_prefix ("G")) {
			return type_name.offset (1);
		} else  {
			string best_match = null;
			if (container is Namespace) {
				foreach (string cprefix in ((Namespace) container).get_cprefixes ()) {
					if (type_name.has_prefix (cprefix)) {
						if (best_match == null || cprefix.length > best_match.length)
							best_match = cprefix;
					}
				}
               } else {
				best_match = container.get_cprefix ();
               }

			if (best_match != null) {
				return type_name.offset (best_match.length);;
			}
		}

		return type_name;
	}

	private string fix_const_name (string const_name, Symbol container) {
		var pref = container.get_lower_case_cprefix ().up ();
		if (const_name.has_prefix (pref)) {
			return const_name.offset (pref.length);
		}
		return const_name;
	}

	private string[] get_attributes_for_node (IdlNode node) {
		string name;

		if (node.type == IdlNodeTypeId.FUNCTION) {
			name = ((IdlNodeFunction) node).symbol;
		} else if (node.type == IdlNodeTypeId.SIGNAL) {
			name = "%s::%s".printf (current_data_type.get_cname (), node.name);
		} else if (node.type == IdlNodeTypeId.PROPERTY) {
			name = "%s:%s".printf (current_data_type.get_cname (), node.name);
		} else if (node.type == IdlNodeTypeId.FIELD) {
			name = "%s.%s".printf (current_data_type.get_cname (), node.name);
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
					ns.set_cheader_filename (eval (nv[1]));
				} else if (nv[0] == "cprefix") {
					var cprefixes = eval (nv[1]).split (",");
					foreach(string name in cprefixes) {
						ns.add_cprefix (name);
					}
				} else if (nv[0] == "lower_case_cprefix") {
					ns.set_lower_case_cprefix (eval (nv[1]));
				} else if (nv[0] == "gir_namespace") {
					ns.source_reference.file.gir_namespace = eval (nv[1]);
				} else if (nv[0] == "gir_version") {
					ns.source_reference.file.gir_version = eval (nv[1]);
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

			parse_node (node, module, container);
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

		bool check_has_target = true;

		var attributes = get_attributes (node.name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				} else if (nv[0] == "cheader_filename") {
					cb.add_cheader_filename (eval (nv[1]));
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
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						cb.deprecated = true;
					}
				} else if (nv[0] == "replacement") {
					cb.replacement = eval (nv[1]);
				} else if (nv[0] == "deprecated_since") {
					cb.deprecated_since = eval (nv[1]);
				} else if (nv[0] == "type_arguments") {
					var type_args = eval (nv[1]).split (",");
					foreach (string type_arg in type_args) {
						return_type.add_type_argument (get_type_from_string (type_arg));
					}
				} else if (nv[0] == "instance_pos") {
					cb.cinstance_parameter_position = eval (nv[1]).to_double ();
				} else if (nv[0] == "type_parameters") {
					foreach (string type_param_name in eval (nv[1]).split (",")) {
						cb.add_type_parameter (new TypeParameter (type_param_name, current_source_reference));
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
				var p = new FormalParameter (param_name, param_type);
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
							var type_args = eval (nv[1]).split (",");
							foreach (string type_arg in type_args) {
								param_type.add_type_argument (get_type_from_string (type_arg));
							}
						} else if (nv[0] == "no_array_length") {
							if (eval (nv[1]) == "1") {
								p.no_array_length = true;
							}
						} else if (nv[0] == "type_name") {
							var sym = new UnresolvedSymbol (null, eval (nv[1]));
							if (param_type is UnresolvedType) {
								((UnresolvedType) param_type).unresolved_symbol = sym;
							} else {
								// Overwrite old param_type, so "type_name" must be before any
								// other param type modifying metadata
								p.variable_type = param_type = new UnresolvedType.from_symbol (sym, return_type.source_reference);
							}
						}
					}
				}

				if (show_param || !hide_param) {
					cb.add_parameter (p);
				}
			}

			remaining_params--;
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
							st.add_cheader_filename (eval (nv[1]));
						} else if (nv[0] == "hidden") {
							if (eval (nv[1]) == "1") {
								return;
							}
						} else if (nv[0] == "base_type") {
							st.base_type = parse_type_string (eval (nv[1]));
						} else if (nv[0] == "rank") {
							st.set_rank (eval (nv[1]).to_int ());
						} else if (nv[0] == "simple_type") {
							if (eval (nv[1]) == "1") {
								st.set_simple_type (true);
							}
						} else if (nv[0] == "immutable") {
							if (eval (nv[1]) == "1") {
								st.is_immutable = true;
							}
						} else if (nv[0] == "has_type_id") {
							if (eval (nv[1]) == "0") {
								st.has_type_id = false;
							}
						} else if (nv[0] == "type_id") {
							st.set_type_id (eval (nv[1]));
						} else if (nv[0] == "has_copy_function") {
							if (eval (nv[1]) == "0") {
								st.has_copy_function = false;
							}
						} else if (nv[0] == "deprecated") {
							if (eval (nv[1]) == "1") {
								st.deprecated = true;
							}
						} else if (nv[0] == "replacement") {
							st.replacement = eval (nv[1]);
						} else if (nv[0] == "deprecated_since") {
							st.deprecated_since = eval (nv[1]);
						} else if (nv[0] == "has_destroy_function") {
							if (eval (nv[1]) == "0") {
								st.has_destroy_function = false;
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

				cl = new Class (name, current_source_reference);
				cl.access = SymbolAccessibility.PUBLIC;
				cl.is_compact = true;

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
						} else if (nv[0] == "is_immutable") {
							if (eval (nv[1]) == "1") {
								cl.is_immutable = true;
							}
						} else if (nv[0] == "const_cname") {
							cl.const_cname = eval (nv[1]);
						} else if (nv[0] == "is_fundamental") {
							if (eval (nv[1]) == "1") {
								cl.is_compact = false;
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
								cl.deprecated = true;
							}
						} else if (nv[0] == "replacement") {
							cl.replacement = eval (nv[1]);
						} else if (nv[0] == "deprecated_since") {
							cl.deprecated_since = eval (nv[1]);
						} else if (nv[0] == "type_parameters") {
							foreach (string type_param_name in eval (nv[1]).split (",")) {
								cl.add_type_parameter (new TypeParameter (type_param_name, current_source_reference));
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
				cl.set_ref_function (ref_function);
				cl.ref_function_void = ref_function_void;
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
							st.add_cheader_filename (eval (nv[1]));
						} else if (nv[0] == "deprecated") {
							if (eval (nv[1]) == "1") {
								st.deprecated = true;
							}
						} else if (nv[0] == "replacement") {
							st.replacement = eval (nv[1]);
						} else if (nv[0] == "deprecated_since") {
							st.deprecated_since = eval (nv[1]);
						} else if (nv[0] == "hidden") {
							if (eval (nv[1]) == "1") {
								return;
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
							cl.add_cheader_filename (eval (nv[1]));
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
				cl.set_ref_function (ref_function);
				cl.ref_function_void = ref_function_void;
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
							st.add_cheader_filename (eval (nv[1]));
						} else if (nv[0] == "deprecated") {
							if (eval (nv[1]) == "1") {
								st.deprecated = true;
							}
						} else if (nv[0] == "replacement") {
							st.replacement = eval (nv[1]);
						} else if (nv[0] == "deprecated_since") {
							st.deprecated_since = eval (nv[1]);
						} else if (nv[0] == "immutable") {
							if (eval (nv[1]) == "1") {
								st.is_immutable = true;
							}
						} else if (nv[0] == "has_copy_function") {
							if (eval (nv[1]) == "0") {
								st.has_copy_function = false;
							}
						} else if (nv[0] == "has_destroy_function") {
							if (eval (nv[1]) == "0") {
								st.has_destroy_function = false;
							}
						}
					}
				}

				add_symbol_to_container (container, st);
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

				var cl_attributes = get_attributes (node.name);
				if (cl_attributes != null) {
					foreach (string attr in cl_attributes) {
						var nv = attr.split ("=", 2);
						if (nv[0] == "cheader_filename") {
							cl.add_cheader_filename (eval (nv[1]));
						} else if (nv[0] == "base_class") {
							base_class = eval (nv[1]);
						} else if (nv[0] == "is_immutable") {
							if (eval (nv[1]) == "1") {
								cl.is_immutable = true;
							}
						} else if (nv[0] == "deprecated") {
							if (eval (nv[1]) == "1") {
								cl.deprecated = true;
							}
						} else if (nv[0] == "replacement") {
							cl.replacement = eval (nv[1]);
						} else if (nv[0] == "deprecated_since") {
							cl.deprecated_since = eval (nv[1]);
						} else if (nv[0] == "const_cname") {
							cl.const_cname = eval (nv[1]);
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
						}
					}
				}

				add_symbol_to_container (container, cl);
				cl.set_type_id (cl.get_upper_case_cname ("TYPE_"));
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
				cl.set_ref_function (ref_function);
				cl.ref_function_void = ref_function_void;
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

		en.has_type_id = (en_node.gtype_name != null && en_node.gtype_name != "");
		
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
					common_prefix = common_prefix.ndup (common_prefix.length - 1);
				}
			} else {
				while (!value.name.has_prefix (common_prefix)) {
					common_prefix = common_prefix.ndup (common_prefix.length - 1);
				}
			}
			while (common_prefix.length > 0 && (!common_prefix.has_suffix ("_") ||
			       (value.name.offset (common_prefix.length).get_char ().isdigit ()) && (value.name.length - common_prefix.length) <= 1)) {
				// enum values may not consist solely of digits
				common_prefix = common_prefix.ndup (common_prefix.length - 1);
			}
		}

		bool is_errordomain = false;

		var cheader_filenames = new ArrayList<string> ();

		var en_attributes = get_attributes (node.name);
		if (en_attributes != null) {
			foreach (string attr in en_attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "common_prefix") {
					common_prefix = eval (nv[1]);
				} else if (nv[0] == "cheader_filename") {
					cheader_filenames.add (eval (nv[1]));
					en.add_cheader_filename (eval (nv[1]));
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return;
					}
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						en.deprecated = true;
					}
				} else if (nv[0] == "replacement") {
					en.replacement = eval (nv[1]);
				} else if (nv[0] == "deprecated_since") {
					en.deprecated_since = eval (nv[1]);
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
					m.set_cname (eval(nv[1]));
					en.add_method (m);
				}
			}
		}

		en.set_cprefix (common_prefix);
		
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
				var ev = new EnumValue (value2.name.offset (common_prefix.length), null);
				en.add_value (ev);
			}
		}

		if (is_errordomain) {
			var ed = new ErrorDomain (en.name, current_source_reference);
			ed.access = SymbolAccessibility.PUBLIC;
			ed.set_cprefix (common_prefix);

			foreach (string filename in cheader_filenames) {
				ed.add_cheader_filename (filename);
			}

			foreach (EnumValue ev in en.get_values ()) {
				ed.add_code (new ErrorCode (ev.name));
			}

			current_source_file.add_node (ed);
			if (!existing) {
				add_symbol_to_container (container, ed);
			}
		} else {
			en.is_flags = is_flags;
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
						cl.add_cheader_filename (eval (nv[1]));
					} else if (nv[0] == "base_class") {
						base_class = eval (nv[1]);
					} else if (nv[0] == "hidden") {
						if (eval (nv[1]) == "1") {
							return;
						}
					} else if (nv[0] == "type_check_function") {
						cl.type_check_function = eval (nv[1]);
					} else if (nv[0] == "deprecated") {
						if (eval (nv[1]) == "1") {
							cl.deprecated = true;
						}
					} else if (nv[0] == "replacement") {
						cl.replacement = eval (nv[1]);
					} else if (nv[0] == "deprecated_since") {
						cl.deprecated_since = eval (nv[1]);
					} else if (nv[0] == "type_id") {
						cl.set_type_id (eval (nv[1]));
					} else if (nv[0] == "abstract") {
						if (eval (nv[1]) == "1") {
							cl.is_abstract = true;
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
				prop.no_accessor_method = true;
			}
			
			var setter = "set_%s".printf (prop.name);
			
			if (prop.set_accessor != null && prop.set_accessor.writable
			    && !current_type_symbol_set.contains (setter)) {
				prop.no_accessor_method = true;
			}

			if (prop.no_accessor_method && prop.get_accessor != null) {
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
						iface.add_cheader_filename (eval (nv[1]));
					} else if (nv[0] == "lower_case_csuffix") {
						iface.set_lower_case_csuffix (eval (nv[1]));
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
					var method_cname = m.get_finish_cname ();
					foreach (Method method in type_symbol.get_methods ()) {
						if (method.get_cname () == method_cname) {
							finish_method = method;
							break;
						}
					}
				}

				if (finish_method != null) {
					m.return_type = finish_method.return_type.copy ();
					m.no_array_length = finish_method.no_array_length;
					m.array_null_terminated = finish_method.array_null_terminated;
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
		ParameterDirection dir = ParameterDirection.IN;

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
				n = n.offset ("const-".length);
			}

			if (type_node.is_pointer &&
			    (n == "gchar" || n == "char")) {
				type.unresolved_symbol = new UnresolvedSymbol (null, "string");
				if (type_node.unparsed.has_suffix ("**")) {
					dir = ParameterDirection.OUT;
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
						dir = ParameterDirection.OUT;
					}
				} else if (type_node.unparsed.has_suffix ("**")) {
					dir = ParameterDirection.OUT;
				}
			}
		} else {
			stdout.printf ("%d\n", type_node.tag);
		}
		if (&direction != null) {
			direction = dir;
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
					type.unresolved_symbol = new UnresolvedSymbol (null, n.offset (eval (nv[1]).length));
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
			type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, current_namespace.name), n.offset (current_namespace.name.length));
		} else if (n.has_prefix ("G")) {
			type.unresolved_symbol = new UnresolvedSymbol (new UnresolvedSymbol (null, "GLib"), n.offset (1));
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

	public DataType get_type_from_string (string type_arg) {
		bool is_unowned = false;
		UnresolvedSymbol? sym = null;

		if (type_arg == "pointer") {
			return new PointerType (new VoidType ());
		}

		if (type_arg.has_prefix ("unowned ")) {
			type_arg = type_arg.offset ("unowned ".length);
			is_unowned = true;
		}

		foreach (unowned string s in type_arg.split (".")) {
			sym = new UnresolvedSymbol (sym, s);
		}

		var arg_type = new UnresolvedType.from_symbol (sym);
		arg_type.value_owned = !is_unowned;

		return arg_type;
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
				m.name = m.name.offset ("new_".length);
			}
			// For classes, check whether a creation method return type equals to the
			// type of the class created. If the types do not match (e.g. in most
			// gtk widgets) add an attribute to the creation method indicating the used
			// return type.
			if (current_data_type is Class && res != null) {
				if ("%s*".printf (current_data_type.get_cname()) != res.type.unparsed) {
					((CreationMethod)m).custom_return_type_cname = res.type.unparsed;
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
		string? error_types = null;

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
				} else if (nv[0] == "printf_format") {
					if (eval (nv[1]) == "1") {
						m.printf_format = true;
					}
				} else if (nv[0] == "transfer_ownership") {
					if (eval (nv[1]) == "1") {
						return_type.value_owned = true;
					}
				} else if (nv[0] == "nullable") {
					if (eval (nv[1]) == "1") {
						return_type.nullable = true;
					}
				} else if (nv[0] == "sentinel") {
					m.sentinel = eval (nv[1]);
				} else if (nv[0] == "is_array") {
					if (eval (nv[1]) == "1") {
						return_type = new ArrayType (return_type, 1, return_type.source_reference);
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
						m.no_array_length = true;
					}
				} else if (nv[0] == "array_null_terminated") {
					if (eval (nv[1]) == "1") {
						m.no_array_length = true;
						m.array_null_terminated = true;
					}
				} else if (nv[0] == "array_length_type") {
					m.array_length_type = eval (nv[1]);
				} else if (nv[0] == "type_name") {
					var sym = new UnresolvedSymbol (null, eval (nv[1]));
					if (return_type is UnresolvedType) {
						((UnresolvedType) return_type).unresolved_symbol = sym;
					} else {
						// Overwrite old return_type, so "type_name" must be before any
						// other return type modifying metadata
						m.return_type = return_type = new UnresolvedType.from_symbol (sym, return_type.source_reference);
					}
				} else if (nv[0] == "type_arguments") {
					var type_args = eval (nv[1]).split (",");
					foreach (string type_arg in type_args) {
						return_type.add_type_argument (get_type_from_string (type_arg));
					}
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						m.deprecated = true;
					}
				} else if (nv[0] == "replacement") {
					m.replacement = eval (nv[1]);
				} else if (nv[0] == "deprecated_since") {
					m.deprecated_since = eval (nv[1]);
				} else if (nv[0] == "cheader_filename") {
					m.add_cheader_filename (eval (nv[1]));
				} else if (nv[0] == "abstract") {
					if (eval (nv[1]) == "1") {
						m.is_abstract = true;
					}
				} else if (nv[0] == "virtual") {
					if (eval (nv[1]) == "1") {
						m.is_virtual = true;
					}
				} else if (nv[0] == "vfunc_name") {
					m.vfunc_name = eval (nv[1]);
				} else if (nv[0] == "finish_name") {
					m.set_finish_cname (eval (nv[1]));
				} else if (nv[0] == "async") {
					if (eval (nv[1]) == "1") {
						// force async function, even if it doesn't end in _async
						m.coroutine = true;
					}
				}
			}
		}
		
		m.set_cname (symbol);
		
		bool first = true;
		FormalParameter last_param = null;
		DataType last_param_type = null;
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
				} else if (!(m is CreationMethod) &&
				    current_data_type != null &&
				    param.type.is_interface &&
				    (param_node.name == "klass" ||
				     param.type.@interface.has_suffix ("%sClass".printf(current_data_type.get_cname ())))) {
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
			var p = new FormalParameter (param_name, param_type);
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
							p.no_array_length = true;
						}
					} else if (nv[0] == "array_length_type") {
						p.array_length_type = eval (nv[1]);
					} else if (nv[0] == "array_null_terminated") {
						if (eval (nv[1]) == "1") {
							p.no_array_length = true;
							p.array_null_terminated = true;
						}
					} else if (nv[0] == "array_length_pos") {
						set_array_length_pos = true;
						array_length_pos = eval (nv[1]).to_double ();
					} else if (nv[0] == "delegate_target_pos") {
						set_delegate_target_pos = true;
						delegate_target_pos = eval (nv[1]).to_double ();
					} else if (nv[0] == "type_name") {
						var sym = new UnresolvedSymbol (null, eval (nv[1]));
						if (param_type is UnresolvedType) {
							((UnresolvedType) param_type).unresolved_symbol = sym;
						} else {
							// Overwrite old param_type, so "type_name" must be before any
							// other param type modifying metadata
							p.variable_type = param_type = new UnresolvedType.from_symbol (sym, return_type.source_reference);
						}
					} else if (nv[0] == "ctype") {
						p.ctype = eval (nv[1]);
					} else if (nv[0] == "type_arguments") {
						var type_args = eval (nv[1]).split (",");
						foreach (string type_arg in type_args) {
							param_type.add_type_argument (get_type_from_string (type_arg));
						}
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
							unowned string endptr;
							unowned string val_end = val.offset (val.length);

							val.to_long (out endptr);
							if ((long)endptr == (long)val_end) {
								p.initializer = new IntegerLiteral (val, param_type.source_reference);
							} else {
								val.to_double (out endptr);
								if ((long)endptr == (long)val_end) {
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
					p.carray_length_parameter_position = array_length_pos;
				}
				if (set_delegate_target_pos) {
					p.cdelegate_target_parameter_position = delegate_target_pos;
				}
			}

			last_param = p;
			last_param_type = param_type;
		}

		if (suppress_throws == false && error_types != null) {
			var type_args = eval (error_types).split (",");
			foreach (string type_arg in type_args) {
				m.add_error_type (get_type_from_string (type_arg));
			}
		}

		if (first) {
			// no parameters => static method
			m.binding = MemberBinding.STATIC;
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

	private Method? parse_function (IdlNodeFunction f, bool is_interface = false) {
		weak IdlNode node = (IdlNode) f;
		
		if (f.deprecated) {
			return null;
		}
	
		return create_method (node.name, f.symbol, f.result, f.parameters, f.is_constructor, is_interface);
	}

	private Method parse_virtual (IdlNodeVFunc v, IdlNodeFunction? func, bool is_interface = false) {
		weak IdlNode node = (IdlNode) v;
		string symbol = "%s%s".printf (current_data_type.get_lower_case_cprefix(), node.name);

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
						}
					}
				}
			}

			if (func == null) {
				m.attributes.append (new Attribute ("NoWrapper", null));
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
			prop.no_array_length = true;
			prop.array_null_terminated = true;
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

		var attributes = get_attributes ("%s:%s".printf (current_data_type.get_cname (), node.name));
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				} else if (nv[0] == "type_arguments") {
					var type_args = eval (nv[1]).split (",");
					foreach (string type_arg in type_args) {
						prop.property_type.add_type_argument (get_type_from_string (type_arg));
					}
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						prop.deprecated = true;
					}
				} else if (nv[0] == "replacement") {
					prop.replacement = eval (nv[1]);
				} else if (nv[0] == "deprecated_since") {
					prop.deprecated_since = eval (nv[1]);
				} else if (nv[0] == "accessor_method") {
					if (eval (nv[1]) == "0") {
						prop.no_accessor_method = true;
					}
				} else if (nv[0] == "owned_get") {
					if (eval (nv[1]) == "1") {
						prop.get_accessor.value_type.value_owned = true;
					}
				} else if (nv[0] == "type_name") {
					prop.property_type = get_type_from_string (eval (nv[1]));
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
					c.add_cheader_filename (eval (nv[1]));
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						c.deprecated = true;
					}
				} else if (nv[0] == "replacement") {
					c.replacement = eval (nv[1]);
				} else if (nv[0] == "deprecated_since") {
					c.deprecated_since = eval (nv[1]);
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
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

		var attributes = get_attributes ("%s.%s".printf (current_data_type.get_cname (), node.name));
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
				} else if (nv[0] == "type_name") {
					if (eval (nv[1]) == "pointer") {
						type = new PointerType (new VoidType ());
					} else {
						var unresolved_sym = new UnresolvedSymbol (null, eval (nv[1]));
						if (type is ArrayType) {
							((UnresolvedType) ((ArrayType) type).element_type).unresolved_symbol = unresolved_sym;
						} else {
							((UnresolvedType) type).unresolved_symbol = unresolved_sym;
						}
					}
				} else if (nv[0] == "type_arguments") {
					var type_args = eval (nv[1]).split (",");
					foreach (string type_arg in type_args) {
						type.add_type_argument (get_type_from_string (type_arg));
					}
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
			field.set_cname (node.name);
		}

		if (deprecated) {
			field.deprecated = true;

			if (deprecated_since != null) {
				field.deprecated_since = deprecated_since;
			}

			if (replacement != null) {
				field.replacement = replacement;
			}
		}

		if (ctype != null) {
			field.set_ctype (ctype);
		}

		if (cheader_filename != null) {
			field.add_cheader_filename (cheader_filename);
		}

		if (array_null_terminated) {
			field.array_null_terminated = true;
		}

		if (array_length_cname != null || array_length_type != null) {
			if (array_length_cname != null) {
				field.set_array_length_cname (array_length_cname);
			}
			if (array_length_type != null) {
				field.array_length_type = array_length_type;
			}
		} else {
			field.no_array_length = true;
		}

		return field;
	}

	private string[]? get_attributes (string codenode) {
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

			remaining = remaining.offset (1);
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
		return ((s.length >= 2) && s.has_prefix ("\"") && s.has_suffix ("\"")) ? s.offset (1).ndup (s.length - 2) : s;
	}

	private Signal? parse_signal (IdlNodeSignal sig_node) {
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
				} else if (nv[0] == "deprecated") {
					if (eval (nv[1]) == "1") {
						sig.deprecated = true;
					}
				} else if (nv[0] == "replacement") {
					sig.replacement = eval (nv[1]);
				} else if (nv[0] == "deprecated_since") {
					sig.deprecated_since = eval (nv[1]);
				} else if (nv[0] == "transfer_ownership") {
					if (eval (nv[1]) == "1") {
						sig.return_type.value_owned = true;
					}
				} else if (nv[0] == "type_arguments") {
					var type_args = eval (nv[1]).split (",");
					foreach (string type_arg in type_args) {
						sig.return_type.add_type_argument (get_type_from_string (type_arg));
					}
				}
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
			var p = new FormalParameter (param_node.name, param_type);
			p.direction = direction;
			sig.add_parameter (p);

			attributes = get_attributes ("%s::%s.%s".printf (current_data_type.get_cname (), sig.name, param_node.name));
			if (attributes != null) {
				string ns_name = null;
				foreach (string attr in attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "is_array") {
						if (eval (nv[1]) == "1") {
							param_type = new ArrayType (param_type, 1, param_type.source_reference);
							p.variable_type = param_type;
							p.direction = ParameterDirection.IN;
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
						if (!(param_type is UnresolvedType)) {
							param_type = new UnresolvedType ();
							p.variable_type = param_type;
						}
						((UnresolvedType) param_type).unresolved_symbol = new UnresolvedSymbol (null, eval (nv[1]));
					} else if (nv[0] == "type_arguments") {
						var type_args = eval (nv[1]).split (",");
						foreach (string type_arg in type_args) {
							p.variable_type.add_type_argument (get_type_from_string (type_arg));
						}
					} else if (nv[0] == "namespace_name") {
						ns_name = eval (nv[1]);
					}
				}
				if (ns_name != null) {
					((UnresolvedType) param_type).unresolved_symbol.inner = new UnresolvedSymbol (null, ns_name);
				}
			}
		}
		
		return sig;
	}
}

// vim:sw=8 noet
