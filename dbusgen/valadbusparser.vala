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
	private Property current_property;

	private MarkupReader reader;

	private MarkupTokenType current_token;
	private SourceLocation begin;
	private SourceLocation end;

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
		if (ns_name != null) {
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

		switch (name) {
			case "org.freedesktop.DBus.Deprecated":
				current_node.set_attribute_bool ("Version", "deprecated", true);
				string? replaced_by = reader.get_attribute ("replaced-by");
				if (replaced_by != null) {
					current_node.set_attribute_string ("Version", "replacement", replaced_by);
				}
				break;
			case "org.freedesktop.DBus.GLib.Async":
				if (current_node is Method) {
					((Method) current_method).is_async_callback = true;
				}
				break;
			case "org.freedesktop.DBus.GLib.NoReply":
				if (current_node is Method) {
					current_node.set_attribute_bool ("DBus", "no_reply", true);
				}
				break;
			default:
				break;
		}

		next ();

		end_element ("annotation");
	}

	private void parse_method () {
		start_element ("method");
		string? name = reader.get_attribute ("name");

		if (name == null) {
			Report.error (get_current_src (), "Interface method declarations require a name attribute");
			return;
		}

		name = Vala.Symbol.camel_case_to_lower_case (name);
		current_node = current_method = new Method (name, dbus_module.void_type.copy (), get_current_src ());
		current_iface.add_method ((Method)current_method);
		((Method)current_method).is_abstract = true;
		((Method)current_method).access = SymbolAccessibility.PUBLIC;

		next ();

		parse_method_body ();

		end_element ("method");
	}

	private void parse_method_body () {
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

		var data_type = dbus_module.get_dbus_type (type);

		PropertyAccessor get_access = null;
		PropertyAccessor set_access = null;

		string? access = reader.get_attribute ("access");
		if (access == "read" || access == "readwrite") {
			get_access = new PropertyAccessor (true, false, false, data_type, null, get_current_src ());
		}
		if (access == "write" || access == "readwrite") {
			set_access = new PropertyAccessor (false, true, false, data_type, null, get_current_src ());
		}

		name = Vala.Symbol.camel_case_to_lower_case (name);
		current_node = current_property = new Property (name, data_type, get_access, set_access, get_current_src ());
		current_property.is_abstract = true;
		current_property.access = SymbolAccessibility.PUBLIC;
		current_iface.add_property (current_property);

		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "annotation") {
				parse_annotation ();
			} else if (reader.name == "doc:doc") {
				parse_doc ();
			}
		}

		end_element ("property");
	}

	private void parse_arg () {
		start_element ("arg");

		string? name = reader.get_attribute ("name");
		if (name == null) {
			Report.error (get_current_src () , "Formal Parameters require a name attribute");
			return;
		}

		string? type = reader.get_attribute ("type");
		if (type == null) {
			Report.error (get_current_src (), "Formal Parameters require a type attribute");
			return;
		}

		var data_type = dbus_module.get_dbus_type (type);
		data_type.value_owned = false;

		current_node = current_param = new Parameter (name, data_type, get_current_src ());
		current_method.add_parameter (current_param);

		if (current_method is Method) {
			string? direction = reader.get_attribute ("direction");
			if (direction == "out") {
				current_param.direction = ParameterDirection.OUT;
				data_type.value_owned = true;
			}
		}

		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "annotation") {
				parse_annotation ();
			} else if (reader.name == "doc:doc") {
				parse_doc ();
			}
		}

		end_element ("arg");
	}

	private void parse_extension () {
		next ();
	}

	private void parse_doc () {
		start_element ("doc:doc");

		while (true) {
			next ();
			if (current_token == MarkupTokenType.END_ELEMENT && reader.name == "doc:doc") {
				break;
			}
		}

		end_element ("doc:doc");
	}

	private void parse_signal () {
		start_element ("signal");

		string? name = reader.get_attribute ("name");
		if (name == null) {
			Report.error (get_current_src (), "Interface signal declarations require a name attribute");
			return;
		}

		name = Vala.Symbol.camel_case_to_lower_case (name);
		current_node = current_method = new Signal (name, dbus_module.void_type.copy ());
		current_iface.add_signal ((Signal)current_node);
		((Signal)current_node).access = SymbolAccessibility.PUBLIC;

		next ();

		parse_method_body ();

		end_element ("signal");
	}

	private void next () {
		current_token = reader.read_token (out begin, out end);
	}

	private void start_element (string name) {
		if (current_token != MarkupTokenType.START_ELEMENT || reader.name != name) {
			Report.error (get_current_src (), "expected start element of `%s'".printf (name));
		}
	}

	private void end_element (string name) {
		while (current_token != MarkupTokenType.END_ELEMENT || reader.name != name) {
			Report.warning (get_current_src (), "expected end element of `%s'".printf (name));
			skip_element ();
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
