/* valagirparser.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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
using Gee;

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

	HashMap<string,string> attributes_map = new HashMap<string,string> (str_hash, str_equal);

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

		foreach (CodeNode node in source_file.get_nodes ()) {
			if (node is Class) {
				var cl = (Class) node;
				var ns = cl.parent_symbol as Namespace;
				// remove Class records
				var class_struct = ns.scope.lookup (cl.name + "Class") as Struct;
				if (class_struct != null) {
					ns.remove_struct ((Struct) class_struct);
					source_file.remove_node (class_struct);
				}
			} else if (node is Interface) {
				var iface = (Interface) node;
				var ns = iface.parent_symbol as Namespace;
				// remove Iface records
				var iface_struct = ns.scope.lookup (iface.name + "Iface") as Struct;
				if (iface_struct != null) {
					ns.remove_struct ((Struct) iface_struct);
					source_file.remove_node (iface_struct);
				}
			}
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

		string cheader = get_attribute (ns.name, "c:header-filename");
		if (cheader != null) {
			ns.set_cheader_filename (cheader);
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
				sym = parse_function ();
			} else if (reader.name == "callback") {
				sym = parse_callback ();
			} else if (reader.name == "record") {
				sym = parse_record ();
			} else if (reader.name == "class") {
				sym = parse_class ();
			} else if (reader.name == "interface") {
				sym = parse_interface ();
			} else if (reader.name == "glib:boxed") {
				parse_boxed ();
			} else if (reader.name == "union") {
				parse_union ();
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

		if (!new_namespace) {
			ns = null;
		}

		return ns;
	}

	Struct parse_alias () {
		start_element ("alias");
		var st = new Struct (reader.get_attribute ("name"), get_current_src ());
		st.access = SymbolAccessibility.PUBLIC;
		st.add_base_type (parse_type_from_name (reader.get_attribute ("target")));
		next ();
		end_element ("alias");
		return st;
	}

	Enum parse_enumeration () {
		start_element ("enumeration");
		var en = new Enum (reader.get_attribute ("name"), get_current_src ());
		en.access = SymbolAccessibility.PUBLIC;
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
				       (cname.offset (common_prefix.size ()).get_char ().isdigit ()) && (cname.len () - common_prefix.len ()) <= 1)) {
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

	Method parse_function () {
		start_element ("function");
		string name = reader.get_attribute ("name");
		next ();
		DataType return_type;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			return_type = parse_return_value ();
		} else {
			return_type = new VoidType ();
		}
		var m = new Method (name, return_type, get_current_src ());
		m.access = SymbolAccessibility.PUBLIC;
		m.binding = MemberBinding.STATIC;
		var parameters = new ArrayList<FormalParameter> ();
		var array_length_parameters = new ArrayList<int> ();
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();
			while (current_token == MarkupTokenType.START_ELEMENT) {
				int array_length_idx = -1;
				var param = parse_parameter (out array_length_idx);
				if (array_length_idx != -1) {
					array_length_parameters.add (array_length_idx);
				}
				parameters.add (param);
			}
			end_element ("parameters");
		}
		int i = 0;
		foreach (FormalParameter param in parameters) {
			if (!array_length_parameters.contains (i)) {
				m.add_parameter (param);
			}
			i++;
		}
		end_element ("function");
		return m;
	}

	DataType parse_return_value () {
		start_element ("return-value");
		string transfer = reader.get_attribute ("transfer-ownership");
		next ();
		var type = parse_type ();
		if (transfer == "full") {
			type.value_owned = true;
		}
		end_element ("return-value");
		return type;
	}

	FormalParameter parse_parameter (out int array_length_idx = null) {
		FormalParameter param = null;

		start_element ("parameter");
		string name = reader.get_attribute ("name");
		string direction = reader.get_attribute ("direction");
		string transfer = reader.get_attribute ("transfer-ownership");
		next ();
		if (reader.name == "varargs") {
			start_element ("varargs");
			next ();
			param = new FormalParameter.with_ellipsis (get_current_src ());
			end_element ("varargs");
		} else {
			var type = parse_type (out array_length_idx);
			if (transfer == "full") {
				type.value_owned = true;
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

	DataType parse_type (out int array_length_index = null) {
		if (reader.name == "array") {
			start_element ("array");
			if (reader.get_attribute ("length") != null
			    && &array_length_index != null) {
				array_length_index = reader.get_attribute ("length").to_int ();
			}
			next ();
			var element_type = parse_type ();
			end_element ("array");
			return new ArrayType (element_type, 1, null);
		} else {
			start_element ("type");
			DataType type = parse_type_from_name (reader.get_attribute ("name"));
			next ();

			// type arguments / element types
			while (current_token == MarkupTokenType.START_ELEMENT) {
				parse_type ();
			}

			end_element ("type");
			return type;
		}
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
			} else if (type_name == "GObject.String") {
				type_name = "GLib.StringBuilder";
			} else if (type_name == "GObject.Class") {
				type_name = "GLib.ObjectClass";
			} else if (type_name == "GLib.unichar") {
				type_name = "unichar";
			} else if (type_name == "GLib.Data") {
				type_name = "GLib.Datalist";
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
		}
		return gir_module_name;
	}

	Struct parse_record () {
		start_element ("record");
		var st = new Struct (reader.get_attribute ("name"), get_current_src ());
		st.access = SymbolAccessibility.PUBLIC;
		next ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "field") {
				st.add_field (parse_field ());
			} else if (reader.name == "callback") {
				parse_callback ();
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				parse_method ();
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `record'".printf (reader.name));
				break;
			}
		}
		end_element ("record");
		return st;
	}

	Class parse_class () {
		start_element ("class");
		var cl = new Class (reader.get_attribute ("name"), get_current_src ());
		cl.access = SymbolAccessibility.PUBLIC;

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
			} else if (reader.name == "field") {
				fields.add (parse_field ());
			} else if (reader.name == "property") {
				cl.add_property (parse_property ());
			} else if (reader.name == "constructor") {
				cl.add_method (parse_constructor ());
			} else if (reader.name == "method") {
				methods.add (parse_method ());
			} else if (reader.name == "callback") {
				vmethods.add (parse_vmethod ());
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
		next ();
		var methods = new ArrayList<Method> ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "property") {
				iface.add_property (parse_property ());
			} else if (reader.name == "callback") {
				parse_callback ();
			} else if (reader.name == "method") {
				methods.add (parse_method ());
			} else if (reader.name == "glib:signal") {
				iface.add_signal (parse_signal ());
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `interface'".printf (reader.name));
				break;
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
		next ();
		var type = parse_type ();
		var field = new Field (name, type, null, get_current_src ());
		field.access = SymbolAccessibility.PUBLIC;
		end_element ("field");
		return field;
	}

	Property parse_property () {
		start_element ("property");
		string name = string.joinv ("_", reader.get_attribute ("name").split ("-"));
		next ();
		var type = parse_type ();
		var prop = new Property (name, type, null, null, get_current_src ());
		prop.access = SymbolAccessibility.PUBLIC;
		prop.get_accessor = new PropertyAccessor (true, false, false, null, null);
		prop.set_accessor = new PropertyAccessor (false, true, false, null, null);
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

	Method parse_constructor () {
		start_element ("constructor");
		string name = reader.get_attribute ("name");
		next ();

		parse_return_value ();

		var m = new CreationMethod (null, name, get_current_src ());
		m.access = SymbolAccessibility.PUBLIC;
		m.has_construct_function = false;
		if (m.name.has_prefix ("new_")) {
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
		end_element ("constructor");
		return m;
	}

	Method parse_method () {
		start_element ("method");
		string name = reader.get_attribute ("name");
		string throws_string = reader.get_attribute ("throws");
		next ();
		DataType return_type;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			return_type = parse_return_value ();
		} else {
			return_type = new VoidType ();
		}
		var m = new Method (name, return_type, get_current_src ());
		m.access = SymbolAccessibility.PUBLIC;
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
		end_element ("method");
		return m;
	}

	Method parse_vmethod () {
		start_element ("callback");
		string name = reader.get_attribute ("name");
		string throws_string = reader.get_attribute ("throws");
		next ();
		DataType return_type;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			return_type = parse_return_value ();
		} else {
			return_type = new VoidType ();
		}
		var m = new Method (name, return_type, get_current_src ());
		m.access = SymbolAccessibility.PUBLIC;
		m.is_virtual = true;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();
			bool first = true;
			while (current_token == MarkupTokenType.START_ELEMENT) {
				var param = parse_parameter ();
				// first parameter is instance pointer, ignore
				if (!first) {
					m.add_parameter (param);
				} else {
					first = false;
				}
			}
			end_element ("parameters");
		}
		if (throws_string == "1") {
			m.add_error_type (new ErrorType (null, null));
		}
		end_element ("callback");
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
		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "field") {
				st.add_field (parse_field ());
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				st.add_method (parse_method ());
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
		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "field") {
				st.add_field (parse_field ());
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				st.add_method (parse_method ());
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
		end_element ("constant");
		return c;
	}

	public void parse_metadata (string metadata_filename) {
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

					string[] tokens = line.split (" ", 2);

					if (null == tokens[0]) {
						continue;
					}

					foreach (string attribute in tokens[1].split (" ")) {
						string[] pair = attribute.split ("=", 2);
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

	string? get_attribute (string node, string key) {
		return attributes_map["%s/@%s".printf (node, key)];
	}
}

