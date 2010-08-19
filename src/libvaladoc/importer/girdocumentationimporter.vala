/* DocumentationBuilderimporter.vala
 *
 * Copyright (C) 2010 Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */

// based on valagirparser.vala

using Gee;

public class Valadoc.Importer.GirDocumentationImporter : DocumentationImporter {
	DocumentationParser docparser;
	Vala.MarkupReader reader;

	Vala.SourceFile current_source_file;
	Vala.SourceLocation begin;
	Vala.SourceLocation end;
	Vala.MarkupTokenType current_token;

	Vala.DataType dummy_type;

	LinkedList<string> type_cname_stack = new LinkedList<string> ();

	int anonymous_param_count = 0;

	public override string file_extension { get { return "gir"; } }

	public GirDocumentationImporter (Api.Tree tree, DocumentationParser docparser, ModuleLoader modules, Settings settings) {
		base (tree, modules, settings);
		this.dummy_type = new Vala.StructValueType (new Vala.Struct ("Dummy"));
		this.docparser = docparser;
	}

	public override void process (string filename) {
		parse_file (filename);
	}

	void parse_file (string gir_file) {
		reader = new Vala.MarkupReader (gir_file);
		this.current_source_file = new Vala.SourceFile (tree.context, GLib.Path. get_basename (gir_file));

		// xml prolog
		next ();
		next ();

		next ();
		parse_repository ();
		this.current_source_file = null;
	}

	Vala.Comment? parse_doc () {
		start_element ("doc");

		Vala.Comment comment = null;
		next ();

		if (current_token == Vala.MarkupTokenType.TEXT) {
			comment = new Vala.Comment (reader.content, get_current_src ());
			next ();
		}

		end_element ("doc");
		return comment;
	}

	void next () {
		current_token = reader.read_token (out begin, out end);
	}

	void start_element (string name) {
		if (current_token != Vala.MarkupTokenType.START_ELEMENT || reader.name != name) {
			// error
			Vala.Report.error (get_current_src (), "expected start element of `%s' instead of `%s'".printf (name, reader.name));
		}
	}

	void end_element (string name) {
		if (current_token != Vala.MarkupTokenType.END_ELEMENT || reader.name != name) {
			// error
			Vala.Report.error (get_current_src (), "expected end element of `%s' instead of `%s'".printf (name, reader.name));
		}
		next ();
	}

	Vala.SourceReference get_current_src () {
		return new Vala.SourceReference (this.current_source_file, begin.line, begin.column, end.line, end.column);
	}

	void parse_repository () {
		start_element ("repository");
		next ();
		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "namespace") {
				parse_namespace ();
			} else if (reader.name == "include") {
				parse_include ();
			} else if (reader.name == "package") {
				parse_package ();
			} else if (reader.name == "c:include") {
				parse_c_include ();
			} else {
				// error
				Vala.Report.error (get_current_src (), "unknown child element `%s' in `repository'".printf (reader.name));
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
		next ();
		end_element ("package");
	}

	void parse_c_include () {
		start_element ("c:include");
		next ();
		end_element ("c:include");
	}

	void skip_element () {
		next ();

		int level = 1;
		while (level > 0) {
			if (current_token == Vala.MarkupTokenType.START_ELEMENT) {
				level++;
			} else if (current_token == Vala.MarkupTokenType.END_ELEMENT) {
				level--;
			} else if (current_token == Vala.MarkupTokenType.EOF) {
				Vala.Report.error (get_current_src (), "unexpected end of file");
				break;
			}
			next ();
		}
	}

	void parse_namespace () {
		start_element ("namespace");
		next ();

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "alias") {
				parse_alias ();
			} else if (reader.name == "enumeration") {
				parse_enumeration ();
			} else if (reader.name == "bitfield") {
				parse_bitfield ();
			} else if (reader.name == "function") {
				parse_method ("function");
			} else if (reader.name == "callback") {
				parse_callback ();
			} else if (reader.name == "record") {
				if (reader.get_attribute ("glib:get-type") != null) {
					parse_boxed ();
				} else {
					parse_record ();
				}
			} else if (reader.name == "class") {
				parse_class ();
			} else if (reader.name == "interface") {
				parse_interface ();
			} else if (reader.name == "glib:boxed") {
				parse_boxed ();
			} else if (reader.name == "union") {
				parse_union ();
			} else if (reader.name == "constant") {
				parse_constant ();
			} else {
				// error
				Vala.Report.error (get_current_src (), "unknown child element `%s' in `namespace'".printf (reader.name));
				break;
			}
		}
		end_element ("namespace");
	}

	void parse_alias () {
		start_element ("alias");
		next ();
		end_element ("alias");
	}

	void parse_enumeration () {
		start_element ("enumeration");
		string cname = reader.get_attribute ("c:type");
		type_cname_stack.add (cname);
		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, new GirDocumentationBuilder (parse_doc ()));
		}

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "member") {
				parse_enumeration_member ();
			} else {
				// error
				break;
			}
		}

		type_cname_stack.poll_head ();
		end_element ("enumeration");
	}

	void parse_bitfield () {
		start_element ("bitfield");
		string cname = reader.get_attribute ("c:type");
		type_cname_stack.add (cname);
		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, new GirDocumentationBuilder (parse_doc ()));
		}

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "member") {
				parse_enumeration_member ();
			} else {
				// error
				break;
			}
		}

		type_cname_stack.poll_head ();
		end_element ("bitfield");
	}

	void parse_enumeration_member () {
		start_element ("member");
		string cname = reader.get_attribute ("c:identifier");
		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, new GirDocumentationBuilder (parse_doc ()));
		}

		end_element ("member");
	}

	void parse_return_value (GirDocumentationBuilder doc) {
		start_element ("return-value");
		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			doc.return_value = parse_doc ();
		}

		parse_type ();

		end_element ("return-value");
	}

	void parse_parameter (GirDocumentationBuilder doc) {
		start_element ("parameter");
		string name = reader.get_attribute ("name");

		if (name == null) {
			name = "param%d".printf (anonymous_param_count);
			anonymous_param_count++;
		}

		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			doc.add_parameter (name, parse_doc ());
		}

		if (reader.name == "varargs") {
			start_element ("varargs");
			next ();
			end_element ("varargs");
		} else {
			parse_type ();
		}

		end_element ("parameter");
	}

	void parse_type () {
		if (reader.name == "array" || reader.name == "callback" || reader.name == "type") {
			skip_element ();
		}
	}

	void parse_record () {
		start_element ("record");
		string glib_is_gtype_struct_for = reader.get_attribute ("glib:is-gtype-struct-for");
		string cname = reader.get_attribute ("c:type");
		type_cname_stack.add (cname);
		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, new GirDocumentationBuilder (parse_doc ()));
		}

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "callback") {
				if (glib_is_gtype_struct_for != null) {
					parse_method ("callback");
				} else {
					parse_callback ();
				}
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				parse_method ("method");
			} else if (reader.name == "union") {
				parse_union ();
			} else {
				// error
				Vala.Report.error (get_current_src (), "unknown child element `%s' in `record'".printf (reader.name));
				break;
			}
		}

		type_cname_stack.poll_head ();
		end_element ("record");
	}

	void parse_class () {
		start_element ("class");
		string cname = reader.get_attribute ("c:type");
		type_cname_stack.add (cname);
		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, new GirDocumentationBuilder (parse_doc ()));
		}

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "implements") {
				start_element ("implements");
				next ();
				end_element ("implements");
			} else if (reader.name == "constant") {
				parse_constant ();
			} else if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "property") {
				parse_property ();
			} else if (reader.name == "constructor") {
				parse_constructor (cname);
			} else if (reader.name == "function") {
				parse_method ("function");
			} else if (reader.name == "method") {
				parse_method ("method");
			} else if (reader.name == "virtual-method") {
				parse_method ("virtual-method");
			} else if (reader.name == "union") {
				parse_union ();
			} else if (reader.name == "glib:signal") {
				parse_signal ();
			} else {
				// error
				Vala.Report.error (get_current_src (), "unknown child element `%s' in `class'".printf (reader.name));
				break;
			}
		}

		type_cname_stack.poll_head ();
		end_element ("class");
	}

	void parse_interface () {
		start_element ("interface");
		string cname = reader.get_attribute ("c:type");
		type_cname_stack.add (cname);
		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, new GirDocumentationBuilder (parse_doc ()));
		}

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "prerequisite") {
				start_element ("prerequisite");
				next ();
				end_element ("prerequisite");
			} else if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "property") {
				parse_property ();
			} else if (reader.name == "virtual-method") {
				parse_method ("virtual-method");
			} else if (reader.name == "function") {
				parse_method ("function");
			} else if (reader.name == "method") {
				parse_method ("method");
			} else if (reader.name == "glib:signal") {
				parse_signal ();
			} else {
				// error
				Vala.Report.error (get_current_src (), "unknown child element `%s' in `interface'".printf (reader.name));
				break;
			}
		}

		type_cname_stack.poll_head ();
		end_element ("interface");
	}

	void parse_field () {
		start_element ("field");
		string cname = reader.get_attribute ("name");
		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc" && cname != null) {
			string real_cname = type_cname_stack.peek();
			real_cname = (real_cname == null)? cname : real_cname+"."+cname;
			process_documentation (real_cname, new GirDocumentationBuilder (parse_doc ()));
		}

		parse_type ();

		end_element ("field");
	}

	void parse_property () {
		start_element ("property");
		string cname = reader.get_attribute ("name");
		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc" && cname != null) {
			process_documentation (type_cname_stack.peek()+":"+cname, new GirDocumentationBuilder (parse_doc ()));
		}

		parse_type ();

		end_element ("property");
	}

	void parse_callback () {
		this.parse_function ("callback");
	}

	void parse_constructor (string? parent_ctype = null) {
		start_element ("constructor");
		string cname = reader.get_attribute ("c:identifier");
		next ();

		GirDocumentationBuilder doc;

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			doc = new GirDocumentationBuilder (parse_doc ());
		} else {
			doc = new GirDocumentationBuilder.empty (get_current_src ());
		}

		parse_return_value (doc);

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();
			while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
				parse_parameter (doc);
			}
			end_element ("parameters");
		}

		if (!doc.is_empty ()) {
			process_documentation (cname, doc);
		}

		end_element ("constructor");
	}

	void parse_function (string element_name) {
		start_element (element_name);
		string cname = reader.get_attribute ("c:identifier");
		next ();

		GirDocumentationBuilder doc;

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			doc = new GirDocumentationBuilder (parse_doc ());
		} else {
			doc = new GirDocumentationBuilder.empty (get_current_src ());
		}

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			parse_return_value (doc);
		}

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();

			while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
				parse_parameter (doc);
			}

			end_element ("parameters");
		}

		if (!doc.is_empty ()) {
			process_documentation (cname, doc);
		}

		end_element (element_name);
	}

	void parse_method (string element_name) {
		this.parse_function (element_name);
	}

	void parse_signal () {
		start_element ("glib:signal");
		string cname = reader.get_attribute ("name");
		next ();

		GirDocumentationBuilder doc;

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			doc = new GirDocumentationBuilder (parse_doc ());
		} else {
			doc = new GirDocumentationBuilder.empty (get_current_src ());
		}

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			parse_return_value (doc);
		}

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();
			while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
				parse_parameter (doc);
			}
			end_element ("parameters");
		}
		if (!doc.is_empty ()) {
			process_documentation (type_cname_stack.peek()+"::"+cname, doc);
		}
		end_element ("glib:signal");
	}

	void parse_boxed () {
		string cname = reader.get_attribute ("c:type");
		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, new GirDocumentationBuilder (parse_doc ()));
		}

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "union") {
				parse_union ();
			} else if (reader.name == "method") {
				parse_method ("method");
			} else {
				// error
				Vala.Report.error (get_current_src (), "unknown child element `%s' in `class'".printf (reader.name));
				break;
			}
		}

		if (current_token != Vala.MarkupTokenType.END_ELEMENT) {
			// error
			Vala.Report.error (get_current_src (), "expected end element");
		}
		next ();
	}

	void parse_union () {
		start_element ("union");
		string cname = reader.get_attribute ("c:type");
		type_cname_stack.add (cname);
		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, new GirDocumentationBuilder (parse_doc ()));
		}

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				parse_method ("method");
			} else if (reader.name == "record") {
				parse_record ();
			}
		}

		type_cname_stack.poll_head ();
		end_element ("union");
	}

	void parse_constant () {
		start_element ("constant");
		string name = reader.get_attribute ("name");
		next ();

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (name, new GirDocumentationBuilder (parse_doc ()));
		}

		parse_type ();

		end_element ("constant");
	}

	void process_documentation (string? cname, GirDocumentationBuilder? doc) {
		if (cname == null || doc == null) {
			return;
		}
	
		var node = tree.search_symbol_cstr (cname);
		
		if (node != null) {
			node.documentation = docparser.parse_gir_comment (node, doc);
		}
	}
}

