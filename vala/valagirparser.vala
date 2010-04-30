/* valagirparser.vala
 *
 * Copyright (C) 2008-2009  Jürg Billeter
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
 */

using GLib;

/**
 * Code visitor parsing all Vala source files.
 */
public class Vala.GirParser : CodeVisitor {
	MarkupReader reader;

	CodeContext context;
	Namespace glib_ns;

	SourceFile current_source_file;
	SourceLocation begin;
	SourceLocation end;
	MarkupTokenType current_token;

	string[] cheader_filenames;
	string[] package_names;

	HashMap<string,string> attributes_map = new HashMap<string,string> (str_hash, str_equal);

	HashMap<string,ArrayList<Method>> gtype_callbacks = new HashMap<string,ArrayList<Method>> (str_hash, str_equal);

	/**
	 * Parses all .gir source files in the specified code
	 * context and builds a code tree.
	 *
	 * @param context a code context
	 */
	public void parse (CodeContext context) {
		this.context = context;
		glib_ns = context.root.scope.lookup ("GLib") as Namespace;
		context.accept (this);
	}

	public override void visit_source_file (SourceFile source_file) {
		if (source_file.filename.has_suffix (".gir")) {
			parse_file (source_file);
		}
	}

	public void parse_file (SourceFile source_file) {
		this.current_source_file = source_file;
		reader = new MarkupReader (source_file.filename);

		// xml prolog
		next ();
		next ();

		next ();
		parse_repository ();

		var remove_queue = new ArrayList<CodeNode> ();

		foreach (CodeNode node in source_file.get_nodes ()) {
			if (node is Class) {
				var cl = (Class) node;
				var ns = cl.parent_symbol as Namespace;
				// remove Class records
				var class_struct = ns.scope.lookup (cl.name + "Class") as Struct;
				if (class_struct != null) {
					ns.remove_struct ((Struct) class_struct);
					remove_queue.add (class_struct);
				}
			} else if (node is Interface) {
				var iface = (Interface) node;
				var ns = iface.parent_symbol as Namespace;
				// remove Iface records
				var iface_struct = ns.scope.lookup (iface.name + "Iface") as Struct;
				if (iface_struct != null) {
					ns.remove_struct ((Struct) iface_struct);
					remove_queue.add (iface_struct);
				}
			}
		}

		foreach (CodeNode node in remove_queue) {
			source_file.remove_node (node);
		}

		reader = null;
		this.current_source_file = null;
	}

	void next () {
		current_token = reader.read_token (out begin, out end);
	}

	void start_element (string name) {
		if (current_token != MarkupTokenType.START_ELEMENT || reader.name != name) {
			// error
			Report.error (get_current_src (), "expected start element of `%s'".printf (name));
		}
	}

	void end_element (string name) {
		if (current_token != MarkupTokenType.END_ELEMENT || reader.name != name) {
			// error
			Report.error (get_current_src (), "expected end element of `%s'".printf (name));
		}
		next ();
	}

	SourceReference get_current_src () {
		return new SourceReference (this.current_source_file, begin.line, begin.column, end.line, end.column);
	}

	void parse_repository () {
		start_element ("repository");
		next ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "namespace") {
				var ns = parse_namespace ();
				if (ns != null) {
					context.root.add_namespace (ns);
				}
			} else if (reader.name == "include") {
				parse_include ();
			} else if (reader.name == "package") {
				parse_package ();
			} else if (reader.name == "c:include") {
				parse_c_include ();
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `repository'".printf (reader.name));
				break;
			}
		}
		end_element ("repository");
	}

	void parse_include () {
		start_element ("include");
		next ();
		end_element ("include");
	}

	void parse_package () {
		start_element ("package");
		add_package_name (reader.get_attribute ("name"));
		next ();
		end_element ("package");
	}

	void parse_c_include () {
		start_element ("c:include");
		cheader_filenames += reader.get_attribute ("name");
		next ();
		end_element ("c:include");
	}

	Namespace? parse_namespace () {
		start_element ("namespace");

		bool new_namespace = false;
		string namespace_name = transform_namespace_name (reader.get_attribute ("name"));
		var ns = context.root.scope.lookup (namespace_name) as Namespace;
		if (ns == null) {
			ns = new Namespace (namespace_name);
			new_namespace = true;
		} else {
			if (ns.external_package) {
				ns.attributes = null;
				ns.source_reference = get_current_src ();
			}
		}

		string? cprefix = reader.get_attribute ("c:prefix");
		if (cprefix != null) {
			ns.add_cprefix (cprefix);
			ns.set_lower_case_cprefix (Symbol.camel_case_to_lower_case (cprefix) + "_");
		}

		foreach (string c_header in cheader_filenames) {
			ns.add_cheader_filename (c_header);
		}
		next ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			Symbol sym = null;
			if (reader.name == "alias") {
				sym = parse_alias ();
			} else if (reader.name == "enumeration") {
				sym = parse_enumeration ();
			} else if (reader.name == "bitfield") {
				sym = parse_bitfield ();
			} else if (reader.name == "function") {
				sym = parse_method ("function");
			} else if (reader.name == "callback") {
				sym = parse_callback ();
			} else if (reader.name == "record") {
				sym = parse_record ();
			} else if (reader.name == "class") {
				sym = parse_class ();
			} else if (reader.name == "interface") {
				sym = parse_interface ();
			} else if (reader.name == "glib:boxed") {
				sym = parse_boxed ();
			} else if (reader.name == "union") {
				sym = parse_union ();
			} else if (reader.name == "constant") {
				sym = parse_constant ();
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `namespace'".printf (reader.name));
				break;
			}

			if (sym is Class) {
				ns.add_class ((Class) sym);
			} else if (sym is Interface) {
				ns.add_interface ((Interface) sym);
			} else if (sym is Struct) {
				ns.add_struct ((Struct) sym);
			} else if (sym is Enum) {
				ns.add_enum ((Enum) sym);
			} else if (sym is Delegate) {
				ns.add_delegate ((Delegate) sym);
			} else if (sym is Method) {
				ns.add_method ((Method) sym);
			} else if (sym is Constant) {
				ns.add_constant ((Constant) sym);
			} else if (sym == null) {
				continue;
			}
			current_source_file.add_node (sym);
		}
		end_element ("namespace");

		postprocess_gtype_callbacks (ns);

		if (!new_namespace) {
			ns = null;
		}

		return ns;
	}

	Struct parse_alias () {
		start_element ("alias");
		var st = new Struct (reader.get_attribute ("name"), get_current_src ());
		st.access = SymbolAccessibility.PUBLIC;
		st.base_type = parse_type_from_name (reader.get_attribute ("target"));
		st.external = true;
		next ();
		end_element ("alias");
		return st;
	}

	Enum parse_enumeration () {
		start_element ("enumeration");
		var en = new Enum (reader.get_attribute ("name"), get_current_src ());
		en.access = SymbolAccessibility.PUBLIC;

		string enum_cname = reader.get_attribute ("c:type");
		if (enum_cname != null) {
			en.set_cname (enum_cname);
		}

		next ();

		string common_prefix = null;
		
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "member") {
				var ev = parse_enumeration_member ();
				en.add_value (ev);

				string cname = ev.get_cname ();

				if (common_prefix == null) {
					common_prefix = cname;
					while (common_prefix.len () > 0 && !common_prefix.has_suffix ("_")) {
						// FIXME: could easily be made faster
						common_prefix = common_prefix.ndup (common_prefix.size () - 1);
					}
				} else {
					while (!cname.has_prefix (common_prefix)) {
						common_prefix = common_prefix.ndup (common_prefix.size () - 1);
					}
				}
				while (common_prefix.len () > 0 && (!common_prefix.has_suffix ("_") ||
				       (cname.offset (common_prefix.length).get_char ().isdigit ()) && (cname.len () - common_prefix.len ()) <= 1)) {
					// enum values may not consist solely of digits
					common_prefix = common_prefix.ndup (common_prefix.size () - 1);
				}
			} else {
				// error
				break;
			}
		}

		en.set_cprefix (common_prefix);

		end_element ("enumeration");
		return en;
	}

	Enum parse_bitfield () {
		start_element ("bitfield");
		var en = new Enum (reader.get_attribute ("name"), get_current_src ());
		en.access = SymbolAccessibility.PUBLIC;
		next ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "member") {
				en.add_value (parse_enumeration_member ());
			} else {
				// error
				break;
			}
		}
		end_element ("bitfield");
		return en;
	}

	EnumValue parse_enumeration_member () {
		start_element ("member");
		var ev = new EnumValue (string.joinv ("_", reader.get_attribute ("name").up ().split ("-")));
		ev.set_cname (reader.get_attribute ("c:identifier"));
		next ();
		end_element ("member");
		return ev;
	}

	DataType parse_return_value (out string? ctype = null) {
		start_element ("return-value");
		string transfer = reader.get_attribute ("transfer-ownership");
		string allow_none = reader.get_attribute ("allow-none");
		next ();
		var transfer_elements = transfer == "full";
		var type = &ctype != null ? parse_type(out ctype, null, transfer_elements) : parse_type (null, null, transfer_elements);
		if (transfer == "full" || transfer == "container") {
			type.value_owned = true;
		}
		if (allow_none == "1") {
			type.nullable = true;
		}
		end_element ("return-value");
		return type;
	}

	FormalParameter parse_parameter (out int array_length_idx = null, out int closure_idx = null, out int destroy_idx = null, out string? scope = null) {
		FormalParameter param;

		if (&array_length_idx != null) {
			array_length_idx = -1;
		}
		if (&closure_idx != null) {
			closure_idx = -1;
		}
		if (&destroy_idx != null) {
			destroy_idx = -1;
		}

		start_element ("parameter");
		string name = reader.get_attribute ("name");
		string direction = reader.get_attribute ("direction");
		string transfer = reader.get_attribute ("transfer-ownership");
		string allow_none = reader.get_attribute ("allow-none");

		if (&scope != null) {
			scope = reader.get_attribute ("scope");
		}

		string closure = reader.get_attribute ("closure");
		string destroy = reader.get_attribute ("destroy");
		if (closure != null && &closure_idx != null) {
			closure_idx = closure.to_int ();
		}
		if (destroy != null && &destroy_idx != null) {
			destroy_idx = destroy.to_int ();
		}

		next ();
		if (reader.name == "varargs") {
			start_element ("varargs");
			next ();
			param = new FormalParameter.with_ellipsis (get_current_src ());
			end_element ("varargs");
		} else {
			var type = parse_type (null, out array_length_idx, transfer == "full");
			if (transfer == "full" || transfer == "container") {
				type.value_owned = true;
			}
			if (allow_none == "1") {
				type.nullable = true;
			}
			param = new FormalParameter (name, type, get_current_src ());
			if (direction == "out") {
				param.direction = ParameterDirection.OUT;
			} else if (direction == "inout") {
				param.direction = ParameterDirection.REF;
			}
		}
		end_element ("parameter");
		return param;
	}

	DataType parse_type (out string? ctype = null, out int array_length_index = null, bool transfer_elements = false) {
		bool is_array = false;
		string type_name = reader.get_attribute ("name");

		if (reader.name == "array") {
			is_array = true;
			start_element ("array");

			if (!(type_name == "GLib.Array" || type_name == "GLib.PtrArray")) {
				if (reader.get_attribute ("length") != null
				    && &array_length_index != null) {
					array_length_index = reader.get_attribute ("length").to_int ();
				}
				next ();
				var element_type = parse_type ();
				end_element ("array");
				return new ArrayType (element_type, 1, null);
			}
		} else if (reader.name == "callback"){
			var callback = parse_callback ();
			return new DelegateType (callback);
		} else {
			start_element ("type");
		}

		if (&ctype != null) {
			ctype = reader.get_attribute("c:type");
		}

		next ();

		if (type_name == "GLib.PtrArray"
		    && current_token == MarkupTokenType.START_ELEMENT) {
			type_name = "GLib.GenericArray";
		}

		DataType type = parse_type_from_name (type_name);

		// type arguments / element types
		while (current_token == MarkupTokenType.START_ELEMENT) {
			var element_type = parse_type ();
			element_type.value_owned = transfer_elements;
			type.add_type_argument (element_type);
		}

		end_element (is_array ? "array" : "type");
		return type;
	}

	DataType parse_type_from_name (string type_name) {
		DataType type;
		if (type_name == "none") {
			type = new VoidType ();
		} else if (type_name == "any") {
			type = new PointerType (new VoidType ());
		} else if (type_name == "GObject.Strv") {
			type = new ArrayType (new UnresolvedType.from_symbol (new UnresolvedSymbol (null, "string")), 1, null);
		} else {
			if (type_name == "utf8") {
				type_name = "string";
			} else if (type_name == "boolean") {
				type_name = "bool";
			} else if (type_name == "GLib.offset") {
				type_name = "int64";
			} else if (type_name == "GType") {
				type_name = "GLib.Type";
			} else if (type_name == "GLib.String") {
				type_name = "GLib.StringBuilder";
			} else if (type_name == "GObject.Class") {
				type_name = "GLib.ObjectClass";
			} else if (type_name == "GLib.unichar") {
				type_name = "unichar";
			} else if (type_name == "GLib.Data") {
				type_name = "GLib.Datalist";
			} else if (type_name == "Atk.ImplementorIface") {
				type_name = "Atk.Implementor";
			}
			string[] type_components = type_name.split (".");
			if (type_components[1] != null) {
				// namespaced name
				string namespace_name = transform_namespace_name (type_components[0]);
				string transformed_type_name = type_components[1];
				type = new UnresolvedType.from_symbol (new UnresolvedSymbol (new UnresolvedSymbol (null, namespace_name), transformed_type_name));
			} else {
				type = new UnresolvedType.from_symbol (new UnresolvedSymbol (null, type_name));
			}
		}

		return type;
	}

	string transform_namespace_name (string gir_module_name) {
		if (gir_module_name == "GObject") {
			return "GLib";
		} else if (gir_module_name == "Gio") {
			return "GLib";
		} else if (gir_module_name == "GModule") {
			return "GLib";
		}
		return gir_module_name;
	}

	Struct parse_record () {
		start_element ("record");
		var st = new Struct (reader.get_attribute ("name"), get_current_src ());
		st.external = true;

		string glib_is_gtype_struct_for = reader.get_attribute ("glib:is-gtype-struct-for");

		st.access = SymbolAccessibility.PUBLIC;
		next ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "field") {
				st.add_field (parse_field ());
			} else if (reader.name == "callback") {
				if (glib_is_gtype_struct_for != null) {
					ArrayList<Method> callbacks = gtype_callbacks.get (glib_is_gtype_struct_for);
					if (callbacks == null) {
						callbacks = new ArrayList<Method> ();
						gtype_callbacks.set (glib_is_gtype_struct_for, callbacks);
					}
					callbacks.add (parse_method ("callback"));
				} else {
					parse_callback ();
				}
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				st.add_method (parse_method ("method"));
			} else if (reader.name == "union") {
				Struct s = parse_union ();
				var s_fields = s.get_fields ();
				foreach (var f in s_fields) {
					f.set_cname (s.get_cname () + "." + f.get_cname ());
					f.name = s.name + "_" + f.name;
					st.add_field (f);
				}
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `record'".printf (reader.name));
				break;
			}
		}
		end_element ("record");
		return st;
	}

	void postprocess_gtype_callbacks (Namespace ns) {
		foreach (string gtype_name in gtype_callbacks.get_keys ()) {
			var gtype = ns.scope.lookup (gtype_name) as ObjectTypeSymbol;
			ArrayList<Method> callbacks = gtype_callbacks.get (gtype_name);
			foreach (Method m in callbacks) {
				var symbol = gtype.scope.lookup (m.name);
				if (symbol == null) {
					continue;
				} else if (symbol is Method)  {
					var meth = (Method) symbol;
					if (gtype is Class) {
						meth.is_virtual = true;
					} else if (gtype is Interface) {
						meth.is_abstract = true;
					}
				} else if (symbol is Signal) {
					var sig = (Signal) symbol;
					sig.is_virtual = true;
				} else {
					Report.error (get_current_src (), "unknown member type `%s' in `%s'".printf (m.name, gtype.name));
				}
			}
		}
	}

	Class parse_class () {
		start_element ("class");
		var cl = new Class (reader.get_attribute ("name"), get_current_src ());
		cl.access = SymbolAccessibility.PUBLIC;
		cl.external = true;

		string cname = reader.get_attribute ("c:type");
		if (cname != null) {
			cl.set_cname (cname);
		}

		string parent = reader.get_attribute ("parent");
		if (parent != null) {
			cl.add_base_type (parse_type_from_name (parent));
		}

		next ();
		var signals = new ArrayList<Signal> ();
		var methods = new ArrayList<Method> ();
		var vmethods = new ArrayList<Method> ();
		var fields = new ArrayList<Field> ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "implements") {
				start_element ("implements");
				cl.add_base_type (parse_type_from_name (reader.get_attribute ("name")));
				next ();
				end_element ("implements");
			} else if (reader.name == "constant") {
				cl.add_constant (parse_constant ());
			} else if (reader.name == "field") {
				fields.add (parse_field ());
			} else if (reader.name == "property") {
				cl.add_property (parse_property ());
			} else if (reader.name == "constructor") {
				cl.add_method (parse_constructor (cname));
			} else if (reader.name == "function") {
				methods.add (parse_method ("function"));
			} else if (reader.name == "method") {
				methods.add (parse_method ("method"));
			} else if (reader.name == "virtual-method") {
				vmethods.add (parse_method ("virtual-method"));
			} else if (reader.name == "union") {
				Struct s = parse_union ();
				var s_fields = s.get_fields ();
				foreach (var f in s_fields) {
					f.set_cname (s.get_cname () + "." + f.get_cname ());
					f.name = s.name + "_" + f.name;
					fields.add (f);
				}
			} else if (reader.name == "glib:signal") {
				signals.add (parse_signal ());
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `class'".printf (reader.name));
				break;
			}
		}

		// signal merging
		foreach (Signal sig in signals) {
			var symbol = cl.scope.lookup (sig.name);
			if (symbol == null) {
				cl.add_signal (sig);
			} else if (symbol is Property) {
				// properties take precedence
			} else {
				Report.error (get_current_src (), "duplicate member `%s' in `%s'".printf (sig.name, cl.name));
			}
		}

		// virtual method merging
		foreach (Method m in vmethods) {
			var symbol = cl.scope.lookup (m.name);
			if (symbol == null) {
				cl.add_method (m);
			} else if (symbol is Signal) {
				var sig = (Signal) symbol;
				sig.is_virtual = true;
			} else if (symbol is Property || symbol is Field) {
				// assume method is getter for property/field ignore method
			} else {
				Report.error (get_current_src (), "duplicate member `%s' in `%s'".printf (m.name, cl.name));
			}
		}

		// method merging
		foreach (Method m in methods) {
			var symbol = cl.scope.lookup (m.name);
			if (symbol == null) {
				cl.add_method (m);
			} else if (symbol is Signal) {
				var sig = (Signal) symbol;
				sig.has_emitter = true;
			} else if (symbol is Property || symbol is Field) {
				// assume method is getter for property/field ignore method
			} else if (symbol is Method) {
				// assume method is wrapper for virtual method
			} else {
				Report.error (get_current_src (), "duplicate member `%s' in `%s'".printf (m.name, cl.name));
			}
		}

		// fields have lowest priority
		foreach (Field f in fields) {
			var symbol = cl.scope.lookup (f.name);
			if (symbol == null) {
				cl.add_field (f);
			}
		}

		end_element ("class");
		return cl;
	}

	Interface parse_interface () {
		start_element ("interface");
		var iface = new Interface (reader.get_attribute ("name"), get_current_src ());
		iface.access = SymbolAccessibility.PUBLIC;
		iface.external = true;

		string cname = reader.get_attribute ("c:type");
		if (cname != null) {
			iface.set_cname (cname);
		}

		next ();
		var methods = new ArrayList<Method> ();
		var vmethods = new ArrayList<Method> ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "prerequisite") {
				start_element ("prerequisite");
				iface.add_prerequisite (parse_type_from_name (reader.get_attribute ("name")));
				next ();
				end_element ("prerequisite");
			} else if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "property") {
				iface.add_property (parse_property ());
			} else if (reader.name == "virtual-method") {
				vmethods.add (parse_method ("virtual-method"));
			} else if (reader.name == "function") {
				methods.add (parse_method ("function"));
			} else if (reader.name == "method") {
				methods.add (parse_method ("method"));
			} else if (reader.name == "glib:signal") {
				iface.add_signal (parse_signal ());
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `interface'".printf (reader.name));
				break;
			}
		}

		// virtual method merging
		foreach (Method m in vmethods) {
			var symbol = iface.scope.lookup (m.name);
			if (symbol == null) {
				iface.add_method (m);
			} else if (symbol is Signal) {
				var sig = (Signal) symbol;
				sig.is_virtual = true;
			} else {
				Report.error (get_current_src (), "duplicate member `%s' in `%s'".printf (m.name, iface.name));
			}
		}

		// method merging
		foreach (Method m in methods) {
			var symbol = iface.scope.lookup (m.name);
			if (symbol == null) {
				iface.add_method (m);
			} else if (symbol is Signal) {
				var sig = (Signal) symbol;
				sig.has_emitter = true;
			} else if (symbol is Method) {
				// assume method is wrapper for virtual method
			} else {
				Report.error (get_current_src (), "duplicate member `%s' in `%s'".printf (m.name, iface.name));
			}
		}

		end_element ("interface");
		return iface;
	}

	Field parse_field () {
		start_element ("field");
		string name = reader.get_attribute ("name");
		string allow_none = reader.get_attribute ("allow-none");
		next ();
		var type = parse_type ();
		var field = new Field (name, type, null, get_current_src ());
		field.access = SymbolAccessibility.PUBLIC;
		if (allow_none == "1") {
			type.nullable = true;
		}
		end_element ("field");
		return field;
	}

	Property parse_property () {
		start_element ("property");
		string name = string.joinv ("_", reader.get_attribute ("name").split ("-"));
		string readable = reader.get_attribute ("readable");
		string writable = reader.get_attribute ("writable");
		string construct_ = reader.get_attribute ("construct");
		string construct_only = reader.get_attribute ("construct-only");
		next ();
		var type = parse_type ();
		var prop = new Property (name, type, null, null, get_current_src ());
		prop.access = SymbolAccessibility.PUBLIC;
		if (readable != "0") {
			prop.get_accessor = new PropertyAccessor (true, false, false, prop.property_type.copy (), null, null);
		}
		if (writable == "1" || construct_only == "1") {
			prop.set_accessor = new PropertyAccessor (false, (construct_only != "1") && (writable == "1"), (construct_only == "1") || (construct_ == "1"), prop.property_type.copy (), null, null);
		}
		end_element ("property");
		return prop;
	}

	Delegate parse_callback () {
		start_element ("callback");
		string name = reader.get_attribute ("name");
		next ();
		DataType return_type;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			return_type = parse_return_value ();
		} else {
			return_type = new VoidType ();
		}
		var d = new Delegate (name, return_type, get_current_src ());
		d.access = SymbolAccessibility.PUBLIC;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();
			while (current_token == MarkupTokenType.START_ELEMENT) {
				d.add_parameter (parse_parameter ());
			}
			end_element ("parameters");
		}
		end_element ("callback");
		return d;
	}

	Method parse_constructor (string? parent_ctype = null) {
		start_element ("constructor");
		string name = reader.get_attribute ("name");
		string throws_string = reader.get_attribute ("throws");
		next ();

		string? ctype;
		parse_return_value (out ctype);

		var m = new CreationMethod (null, name, get_current_src ());
		m.access = SymbolAccessibility.PUBLIC;
		m.has_construct_function = false;
		if (ctype != null && (parent_ctype == null || ctype != parent_ctype + "*")) {
			m.custom_return_type_cname = ctype;
		}
		if (m.name == "new") {
			m.name = null;
		} else if (m.name.has_prefix ("new_")) {
			m.name = m.name.offset ("new_".len ());
		}
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();
			while (current_token == MarkupTokenType.START_ELEMENT) {
				m.add_parameter (parse_parameter ());
			}
			end_element ("parameters");
		}

		if (throws_string == "1") {
			m.add_error_type (new ErrorType (null, null));
		}
		end_element ("constructor");
		return m;
	}

	class MethodInfo {
		public MethodInfo (FormalParameter param, int array_length_idx, int closure_idx, int destroy_idx) {
			this.param = param;
			this.array_length_idx = array_length_idx;
			this.closure_idx = closure_idx;
			this.destroy_idx = destroy_idx;
			this.vala_idx = 0.0F;
			this.keep = true;
		}

		public FormalParameter param;
		public float vala_idx;
		public int array_length_idx;
		public int closure_idx;
		public int destroy_idx;
		public bool keep;
	}

	Method parse_method (string element_name) {
		start_element (element_name);
		string name = reader.get_attribute ("name");
		string cname = reader.get_attribute ("c:identifier");
		string throws_string = reader.get_attribute ("throws");
		string invoker = reader.get_attribute ("invoker");
		next ();
		DataType return_type;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			return_type = parse_return_value ();
		} else {
			return_type = new VoidType ();
		}
		var m = new Method (name, return_type, get_current_src ());
		m.access = SymbolAccessibility.PUBLIC;
		if (cname != null) {
			m.set_cname (cname);
		}

		if (element_name == "virtual-method" || element_name == "callback") {
			m.is_virtual = true;
			if (invoker != null){
				m.name = invoker;
			}
		} else if (element_name == "function") {
			m.binding = MemberBinding.STATIC;
		}

		var parameters = new ArrayList<MethodInfo> ();
		var array_length_parameters = new ArrayList<int> ();
		var closure_parameters = new ArrayList<int> ();
		var destroy_parameters = new ArrayList<int> ();
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();

			bool first = true;
			while (current_token == MarkupTokenType.START_ELEMENT) {
				int array_length_idx, closure_idx, destroy_idx;
				string scope;
				var param = parse_parameter (out array_length_idx, out closure_idx, out destroy_idx, out scope);
				if (array_length_idx != -1) {
					array_length_parameters.add (array_length_idx);
				}
				if (closure_idx != -1) {
					closure_parameters.add (closure_idx);
				}
				if (destroy_idx != -1) {
					destroy_parameters.add (destroy_idx);
				}

				// first parameter is instance pointer in virtual methods, ignore
				if (element_name != "callback" || !first) {
					var info = new MethodInfo(param, array_length_idx, closure_idx, destroy_idx);

					if (scope == "async") {
						m.coroutine = true;
						info.keep = false;
					}

					parameters.add (info);
				} else {
					first = false;
				}
			}
			end_element ("parameters");
		}
		int i = 0, j=1, add=0;

		if (element_name == "method" || element_name == "virtual-method" || element_name == "callback") {
			// implicit instance parameter
			add = 1;
		}

		int last = -1;
		foreach (MethodInfo info in parameters) {
			if (info.keep
			    && !array_length_parameters.contains (i+add)
			    && !closure_parameters.contains (i+add)
			    && !destroy_parameters.contains (i+add)) {
				info.vala_idx = (float) j;
				info.keep = true;

				/* interpolate for vala_idx between this and last*/
				float last_idx = 0.0F;
				if (last != -1) {
					last_idx = parameters[last].vala_idx;
				}
				for (int k=last+1; k < i; k++) {
					parameters[k].vala_idx =  last_idx + (((j - last_idx) / (i-last)) * (k-last));
				}
				last = i+1;
				j++;
			} else {
				info.keep = false;
			}
			i++;
		}

		foreach (MethodInfo info in parameters) {
			if (info.keep) {

				/* add_parameter sets carray_length_parameter_position and cdelegate_target_parameter_position
				 so do it first*/
				m.add_parameter (info.param);

				if (info.array_length_idx != -1) {
					if ((info.array_length_idx) - add >= parameters.size) {
						Report.error (get_current_src (), "invalid array_length index");
						continue;
					}
					info.param.carray_length_parameter_position = parameters[info.array_length_idx-add].vala_idx;
				}
				if (info.param.parameter_type is ArrayType && info.array_length_idx == -1) {
					info.param.no_array_length = true;
				}

				if (info.closure_idx != -1) {
					if ((info.closure_idx - add) >= parameters.size) {
						Report.error (get_current_src (), "invalid closure index");
						continue;
					}
					info.param.cdelegate_target_parameter_position = parameters[info.closure_idx - add].vala_idx;
				}
/* Leaving this as a TODO, needs more testing
				if (info.destroy_idx != -1) {
					if (info.destroy_idx - add >= parameters.size) {
						Report.error (get_current_src (), "invalid destroy index");
						continue;
					}
					info.param.cdelegate_target_parameter_position = parameters[info.destroy_idx - add].vala_idx;
				}
*/
			}
		}

		if (throws_string == "1") {
			m.add_error_type (new ErrorType (null, null));
		}
		end_element (element_name);
		return m;
	}

	Signal parse_signal () {
		start_element ("glib:signal");
		string name = string.joinv ("_", reader.get_attribute ("name").split ("-"));
		next ();
		DataType return_type;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			return_type = parse_return_value ();
		} else {
			return_type = new VoidType ();
		}
		var sig = new Signal (name, return_type);
		sig.access = SymbolAccessibility.PUBLIC;
		sig.external = true;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();
			while (current_token == MarkupTokenType.START_ELEMENT) {
				sig.add_parameter (parse_parameter ());
			}
			end_element ("parameters");
		}
		end_element ("glib:signal");
		return sig;
	}

	Struct parse_boxed () {
		start_element ("glib:boxed");
		var st = new Struct (reader.get_attribute ("glib:name"));
		st.access = SymbolAccessibility.PUBLIC;
		st.external = true;

		string cname = reader.get_attribute ("c:type");
		if (cname != null) {
			st.set_cname (cname);
		}

		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "field") {
				st.add_field (parse_field ());
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				st.add_method (parse_method ("method"));
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `class'".printf (reader.name));
				break;
			}
		}

		end_element ("glib:boxed");
		return st;
	}

	Struct parse_union () {
		start_element ("union");
		var st = new Struct (reader.get_attribute ("name"));
		st.access = SymbolAccessibility.PUBLIC;
		st.external = true;
		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "field") {
				st.add_field (parse_field ());
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				st.add_method (parse_method ("method"));
			} else if (reader.name == "record") {
				Struct s = parse_record ();
				var fs = s.get_fields ();
				foreach (var f in fs) {
					f.set_cname (s.get_cname () + "." + f.get_cname ());
					f.name = s.name + "_" + f.name;
					st.add_field (f);
				}
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `union'".printf (reader.name));
				break;
			}
		}

		end_element ("union");
		return st;
	}

	Constant parse_constant () {
		start_element ("constant");
		string name = reader.get_attribute ("name");
		next ();
		var type = parse_type ();
		var c = new Constant (name, type, null, get_current_src ());
		c.access = SymbolAccessibility.PUBLIC;
		c.external = true;
		end_element ("constant");
		return c;
	}

	public void parse_metadata (string metadata_filename) {
		if (FileUtils.test (metadata_filename, FileTest.EXISTS)) {
			try {
				string metadata;
				FileUtils.get_contents (metadata_filename, out metadata, null);
				
				foreach (string line in metadata.split ("\n")) {
					if (line.has_prefix ("#")) {
						// ignore comment lines
						continue;
					}

					string[] tokens = line.split (" ", 2);

					if (null == tokens[0]) {
						continue;
					}

					foreach (string attribute in tokens[1].split (" ")) {
						string[] pair = attribute.split ("=", 2);
						if (pair[0] == null || pair[1] == null) {
							continue;
						}

						string key = "%s/@%s".printf (tokens[0], pair[0]);
						attributes_map.set (key, pair[1].substring (1, pair[1].length - 2));
					}
				}
			} catch (FileError e) {
				Report.error (null, "Unable to read metadata file: %s".printf (e.message));
			}
		} else {
			Report.error (null, "Metadata file `%s' not found".printf (metadata_filename));
		}
	}

	void add_package_name (string name) {
		if (package_names == null) {
			package_names = new string[0];
		}

		foreach (var existing in package_names) {
			if (name == existing) {
				return;
			}
		}

		package_names += name;
	}

	public string[]? get_package_names () {
		return package_names;
	}
}

