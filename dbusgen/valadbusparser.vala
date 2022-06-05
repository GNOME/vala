/* valadbusparser.vala
 *
 * Copyright (C) 2017 Chris Daley
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
 * 	Chris Daley <chebizarro@gmail.com>
 */

using GLib;

/**
 * Code visitor parsing all DBus Interface files.
 *
 * https://dbus.freedesktop.org/doc/dbus-specification.html#introspection-format
 * https://dbus.freedesktop.org/doc/dbus-api-design.html#annotations
 */
public class Vala.DBusParser : CodeVisitor {

	private CodeContext context;

	private DBusVariantModule dbus_module;

	private SourceFile current_source_file;

	private CodeNode current_node;
	private Namespace current_ns;
	private Interface current_iface;
	private Callable current_method;
	private Parameter current_param;
	private uint current_param_index;
	private Property current_property;

	private MarkupReader reader;

	private MarkupTokenType current_token;
	private SourceLocation begin;
	private SourceLocation end;

	private HashMap<string, DBusExtension> extensions = new HashMap<string, DBusExtension> ();
	// Used for guarding against duplicate argument names
	private Set<string> argnames = new HashSet<string> (str_hash, str_equal);
	// Used for guarding against duplicate member names (signals, properties and methods)
	private Set<string> member_names = new HashSet<string> (str_hash, str_equal);
	private int duplicate_counter;

	public int dbus_timeout { get; set; }

	public NamespaceStrategy namespace_strategy { get; set; }

	/**
	 * Parse all DBus Interface files in the specified code context and
	 * build a code tree.
	 *
	 * @param context a code context
	 */
	public void parse (CodeContext context) {
		this.context = context;
		current_ns = context.root;

		dbus_module = new DBusVariantModule (context);

		context.accept (this);
	}

	public override void visit_source_file (SourceFile source_file) {
		if (source_file.filename.has_suffix (".xml")) {
			parse_file (source_file);
		}
	}

	private void parse_file (SourceFile source_file) {

		current_source_file = source_file;
		reader = new MarkupReader (source_file.filename);
		current_source_file.add_node (context.root);

		while (current_token != MarkupTokenType.START_ELEMENT && reader.name != "node") {
			next ();
		}

		parse_node ();

		current_source_file = null;
		reader = null;
	}

	private void parse_node () {
		start_element ("node");

		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
			switch (reader.name) {
				case "interface":
					parse_namespace ();
					parse_interface ();
					break;
				case "doc:doc":
					parse_doc ();
					break;
				//case "node":
				//	parse_node ();
					//break;
				default:
					parse_extension ();
					break;
			}
		}

		end_element ("node");
	}

	private void parse_namespace () {
		string? name = reader.get_attribute ("name");
		if (name == null) {
			Report.error (get_current_src (), "Interface declarations require a name attribute");
			return;
		}

		string? ns_name = namespace_strategy.get_namespace (name);
		if (ns_name != null && current_ns.name != ns_name) {
			var ns = new Namespace (ns_name, get_current_src ());
			current_ns.add_namespace (ns);
			current_ns = ns;
		}
	}

	private void parse_interface () {
		start_element ("interface");

		string? name = reader.get_attribute ("name");
		if (name == null) {
			Report.error (get_current_src (), "Interface declarations require a name attribute");
			return;
		}

		string iface_name = namespace_strategy.get_name (name);

		foreach (var iface in current_ns.get_interfaces ()) {
			// The default interfaces can occur duplicated
			if ((iface_name == namespace_strategy.get_name ("org.freedesktop.DBus.Peer")
				 || iface_name == namespace_strategy.get_name ("org.freedesktop.DBus.Introspectable")
				 || iface_name == namespace_strategy.get_name ("org.freedesktop.DBus.Properties")
				 || iface_name == namespace_strategy.get_name ("org.freedesktop.DBus.ObjectManager")) && iface.name == iface_name) {
				next ();
				seek_end ("interface");
				return;
			}
		}
		current_node = current_iface = new Interface (iface_name, get_current_src ());

		current_iface.access = SymbolAccessibility.PUBLIC;
		current_iface.add_prerequisite (new ObjectType ((ObjectTypeSymbol) dbus_module.gobject_type));
		current_iface.set_attribute_string ("DBus", "name", name);
		current_iface.set_attribute_integer ("DBus", "timeout", dbus_timeout);

		current_ns.add_interface (current_iface);

		next ();

		parse_interface_body ();

		end_element ("interface");

	}

	private void parse_interface_body () {
		member_names.clear ();
		duplicate_counter = 0;
		while (current_token == MarkupTokenType.START_ELEMENT) {
			switch (reader.name) {
				case "annotation":
					parse_annotation ();
					break;
				case "method":
					parse_method ();
					break;
				case "signal":
					parse_signal ();
					break;
				case "property":
					parse_property ();
					break;
				case "doc:doc":
					parse_doc ();
					break;
				default:
					parse_extension ();
					break;
			}
		}
	}

	private void parse_annotation () {
		start_element ("annotation");

		string? name = reader.get_attribute ("name");
		if (name == null) {
			Report.error (get_current_src (), "Annotations require a name attribute");
			return;
		}

		string? val = reader.get_attribute ("value");
		if (val == null) {
			Report.warning (get_current_src (), "Annotations require a value attribute");
			return;
		}

		switch (name) {
			case "org.freedesktop.DBus.Deprecated":
				// Can be used on any <interface>, <method>, <signal> and <property> element to specify that the element is deprecated
				// if its value is true. Note that this annotation is defined in the D-Bus specification[1] and can only assume the
				// values true and false. In particular, you cannot specify the version that the element was deprecated in nor any
				// helpful deprecation message. Such information should be added to the element documentation instead.
				if (val != "true") {
					break;
				}
				current_node.set_attribute_bool ("Version", "deprecated", true);
				string? replaced_by = reader.get_attribute ("replaced-by");
				if (replaced_by != null) {
					current_node.set_attribute_string ("Version", "replacement", replaced_by);
				}
				break;
			case "org.freedesktop.DBus.Property.EmitsChangedSignal":
				// val in {true,invalidates,const,false}
				// If set to false, the org.freedesktop.DBus.Properties.PropertiesChanged signal, see the section called
				// “org.freedesktop.DBus.Properties” is not guaranteed to be emitted if the property changes.
				// If set to const the property never changes value during the lifetime of the object it belongs to, and hence the
				// signal is never emitted for it.
				// If set to invalidates the signal is emitted but the value is not included in the signal.
				// If set to true the signal is emitted with the value included.
				// The value for the annotation defaults to true if the enclosing interface element does not specify the annotation.
				// Otherwise it defaults to the value specified in the enclosing interface element.
				// This annotation is intended to be used by code generators to implement client-side caching of property values.
				// For all properties for which the annotation is set to const, invalidates or true the client may unconditionally
				// cache the values as the properties don't change or notifications are generated for them if they do.
				if (val != null && (val == "false" || val == "const")) {
					// const is technically wrong, but if you can't change the value, notify will never be triggered
					current_node.set_attribute_bool ("CCode", "notify", false);
				}
				break;
			case "org.freedesktop.DBus.GLib.Async":
				if (current_node is Method) {
					((Method) current_method).coroutine = true;
				}
				break;
			case "org.freedesktop.DBus.GLib.NoReply":
				if (val != "true") {
					break;
				}
				if (current_node is Method) {
					current_node.set_attribute_bool ("DBus", "no_reply", true);
				}
				break;
			case "org.freedesktop.DBus.GLib.CSymbol":
			case "org.gtk.GDBus.C.Name":
				// Can be used on any <interface>, <method>, <signal> and <property> element to specify the name to use when generating
				// C code. The value is expected to be in CamelCase[4] or Ugly_Case (see above).
				if (val != null) {
					current_node.set_attribute_string ("CCode", "cname", val);
				}
				break;
			case "org.gtk.GDBus.C.ForceGVariant":
				// If set to a non-empty string, a #GVariant instance will be used instead of the natural C type. This annotation can be
				// used on any <arg> and <property> element.
				if (current_node is Parameter) {
					var type = dbus_module.gvariant_type.copy ();
					type.value_owned = false;
					((Parameter) current_node).variable_type = type;
				} else if (current_node is Property) {
					((Property) current_node).property_type = dbus_module.gvariant_type.copy ();
				}
				break;
			case "org.gtk.GDBus.C.UnixFD":
				// If set to a non-empty string, the generated code will include parameters to exchange file descriptors using the
				// #GUnixFDList type. This annotation can be used on <method> elements.
				// TODO: Investigate what is needed!
				break;
			case "org.gtk.GDBus.Since":
				// Can be used on any <interface>, <method>, <signal> and <property> element to specify the version (any free-form
				// string but compared using a version-aware sort function) the element appeared in.
				if (val != null) {
					current_node.set_attribute_string ("Version", "since", val);
				}
				break;
			case "org.gtk.GDBus.DocString":
				// A string with Docbook content for documentation. This annotation can be used on <interface>, <method>, <signal>,
				// <property> and <arg> elements.
				if (val != null && current_node is Symbol) {
					((Symbol) current_node).comment = new Vala.Comment (val, get_current_src ());
				}
				break;
			case "org.gtk.GDBus.DocString.Short":
				// A string with Docbook content for short/brief documentation. This annotation can only be used on <interface>
				// elements.
				// Prefer long comments over short comments
				if (val != null && current_node is Symbol && ((Symbol) current_node).comment == null) {
					((Symbol) current_node).comment = new Vala.Comment (val, get_current_src ());
				}
				break;
			default:
				break;
		}

		next ();

		end_element ("annotation");
	}

	private void parse_method () {
		var duplicate = false;
		start_element ("method");
		string? name = reader.get_attribute ("name");
		if (name == null) {
			Report.error (get_current_src (), "Interface method declarations require a name attribute");
			return;
		}

		var needs_name = false;
		var vala_name = Vala.Symbol.camel_case_to_lower_case (name);
		if (name == Vala.Symbol.lower_case_to_camel_case (vala_name)) {
			name = vala_name;
		} else {
			needs_name = true;
		}
		if (name in member_names) {
			duplicate = true;
			name = "%s%u".printf (name, duplicate_counter++);
		}

		current_node = current_method = new Method (name, dbus_module.void_type.copy (), get_current_src ());
		((Method)current_method).is_abstract = true;
		((Method)current_method).access = SymbolAccessibility.PUBLIC;
		((Method)current_method).add_error_type (dbus_module.gio_error_type);
		((Method)current_method).add_error_type (dbus_module.gdbus_error_type);
		member_names.add (name);
		if (needs_name) {
			current_node.set_attribute_string ("DBus", "name", name);
		}
		if (duplicate) {
			current_node.set_attribute_string ("DBus", "name", reader.get_attribute ("name"));
		}

		next ();

		parse_method_body ();

		current_iface.add_method ((Method) current_method);

		end_element ("method");
	}

	private void parse_method_body () {
		current_param_index = 0U;
		argnames.clear ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			switch (reader.name) {
				case "annotation":
					parse_annotation ();
					break;
				case "arg":
					parse_arg ();
					break;
				case "doc:doc":
					parse_doc ();
					break;
				default:
					parse_extension ();
					break;
			}
		}
	}

	private void parse_property () {
		var duplicate = false;
		start_element ("property");

		string? name = reader.get_attribute ("name");
		if (name == null) {
			Report.error (get_current_src (), "Interface property declarations require a name attribute");
			return;
		}

		string? type = reader.get_attribute ("type");
		if (type == null) {
			Report.error (get_current_src (), "Interface property declarations require a type attribute");
			return;
		}

		string? access = reader.get_attribute ("access");

		var needs_signature = false;
		var data_type = dbus_module.get_dbus_type (type);
		if (data_type == null) {
			data_type = dbus_module.gvariant_type.copy ();
			needs_signature = true;
		}

		var needs_name = false;
		var vala_name = Vala.Symbol.camel_case_to_lower_case (name);
		if (name == Vala.Symbol.lower_case_to_camel_case (vala_name)) {
			name = vala_name;
		} else {
			needs_name = true;
		}
		if (name in member_names) {
			duplicate = true;
			name = "%s%u".printf (name, duplicate_counter++);
		}

		current_node = current_property = new Property (name, data_type, null, null, get_current_src ());
		current_property.is_abstract = true;
		current_property.access = SymbolAccessibility.PUBLIC;
		member_names.add (name);

		if (needs_name) {
			current_node.set_attribute_string ("DBus", "name", name);
		}
		if (duplicate) {
			current_node.set_attribute_string ("DBus", "name", reader.get_attribute ("name"));
		}

		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "annotation") {
				parse_annotation ();
			} else if (reader.name == "doc:doc") {
				parse_doc ();
			}
		}

		if (access == "read" || access == "readwrite") {
			current_property.get_accessor = new PropertyAccessor (true, false, false, current_property.property_type.copy (), null, get_current_src ());
		}
		if (access == "write" || access == "readwrite") {
			var set_type = current_property.property_type.copy ();
			set_type.value_owned = false;
			current_property.set_accessor = new PropertyAccessor (false, true, false, set_type, null, get_current_src ());
		}

		if (needs_signature || !current_property.property_type.equals (data_type)) {
			current_node.set_attribute_string ("DBus", "signature", type);
		}

		current_iface.add_property (current_property);

		end_element ("property");
	}

	private void parse_arg () {
		start_element ("arg");

		string? name = reader.get_attribute ("name");
		if (name == null) {
			name = "arg%u".printf (current_param_index++);
		} else if (argnames.contains (name)) {
			name = "%s%u".printf (name, current_param_index++);
		}
		argnames.add (name);

		string? type = reader.get_attribute ("type");
		if (type == null) {
			Report.error (get_current_src (), "Formal Parameters require a type attribute");
			return;
		}

		string? direction = reader.get_attribute ("direction");

		var needs_signature = false;
		var data_type = dbus_module.get_dbus_type (type);
		if (data_type == null) {
			data_type = dbus_module.gvariant_type.copy ();
			needs_signature = true;
		}
		data_type.value_owned = false;

		current_node = current_param = new Parameter (name, data_type, get_current_src ());

		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "annotation") {
				parse_annotation ();
			} else if (reader.name == "doc:doc") {
				parse_doc ();
			} else {
				parse_extension ();
			}
		}

		if (needs_signature || !current_param.variable_type.equals (data_type)) {
			current_node.set_attribute_string ("DBus", "signature", type);
		}

		if (current_method is Method) {
			if (direction == "out") {
				current_param.direction = ParameterDirection.OUT;
				current_param.variable_type.value_owned = true;
			}
		}

		current_method.add_parameter (current_param);

		end_element ("arg");
	}

	private void parse_extension () {
		string prefix = reader.name.split (":")[0];
		DBusExtension? ext = extensions.get (prefix);

		if (ext != null) {
			ext.parse_node (reader.name, current_node, get_current_src ());
			next ();
		} else {
			Report.warning (get_current_src (), "Element %s is unrecognized".printf (reader.name));
			skip_element ();
		}

		return;
	}

	private void parse_doc () {
		start_element ("doc:doc");

		string comment = "";
		SourceReference start_loc = get_current_src ();

		while (true) {
			next ();

			if (current_token == MarkupTokenType.TEXT) {
				foreach (string line in reader.content.split ("\n")) {
					comment += " * %s\n".printf (line.strip ());
				}
			}

			if (current_token == MarkupTokenType.END_ELEMENT && reader.name == "doc:doc") {
				break;
			}
		}

		if (comment.length > 0) {
			comment = "*\n%s".printf (comment);
			Comment doc = new Comment (comment, start_loc);
			Symbol node = current_node as Symbol;
			if (node != null) {
				node.comment = doc;
			}
		}

		end_element ("doc:doc");
	}

	private void parse_signal () {
		var duplicate = false;
		start_element ("signal");

		string? name = reader.get_attribute ("name");
		if (name == null) {
			Report.error (get_current_src (), "Interface signal declarations require a name attribute");
			return;
		}

		var needs_name = false;
		var vala_name = Vala.Symbol.camel_case_to_lower_case (name);
		if (name == Vala.Symbol.lower_case_to_camel_case (vala_name)) {
			name = vala_name;
		} else {
			needs_name = true;
		}
		if (name in member_names) {
			duplicate = true;
			name = "%s%u".printf (name, duplicate_counter++);
		}

		current_node = current_method = new Signal (name, dbus_module.void_type.copy ());
		((Signal)current_node).access = SymbolAccessibility.PUBLIC;

		member_names.add (name);
		if (needs_name) {
			current_node.set_attribute_string ("DBus", "name", name);
		}
		if (duplicate) {
			current_node.set_attribute_string ("DBus", "name", reader.get_attribute ("name"));
		}

		next ();

		parse_method_body ();

		current_iface.add_signal ((Signal) current_method);

		end_element ("signal");
	}

	private void next () {
		current_token = reader.read_token (out begin, out end);
	}

	private void start_element (string name) {
		if (current_token != MarkupTokenType.START_ELEMENT || reader.name != name) {
			Report.error (get_current_src (), "expected start element of `%s' (Got `%s')".printf (name, reader.name));
		}
	}

	private void end_element (string name) {
		while (current_token != MarkupTokenType.END_ELEMENT || reader.name != name) {
			Report.warning (get_current_src (), "expected end element of `%s' (Got `%s')".printf (name, reader.name));
			skip_element ();
			if (current_token == MarkupTokenType.EOF) {
				return;
			}
		}
		next ();
	}

	private void seek_end (string name) {
		while (current_token != MarkupTokenType.END_ELEMENT || reader.name != name) {
			skip_element ();
			if (current_token == MarkupTokenType.EOF) {
				return;
			}
		}
		next ();
	}

	private SourceReference get_current_src () {
		return new SourceReference (current_source_file, begin, end);
	}

	private void skip_element () {
		next ();

		int level = 1;
		while (level > 0) {
			if (current_token == MarkupTokenType.START_ELEMENT) {
				level++;
			} else if (current_token == MarkupTokenType.END_ELEMENT) {
				level--;
			} else if (current_token == MarkupTokenType.EOF) {
				Report.error (get_current_src (), "unexpected end of file");
				break;
			}
			next ();
		}
	}
}
