/* DocumentationBuilderimporter.vala
 *
 * Copyright (C) 2010-2011 Florian Brosch
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
	MarkupReader reader;

	ErrorReporter reporter;

	Api.SourceFile current_source_file;
	MarkupSourceLocation begin;
	MarkupSourceLocation end;
	MarkupTokenType current_token;

	LinkedList<string> type_cname_stack = new LinkedList<string> ();

	int anonymous_param_count = 0;

	public override string file_extension {
		get { return "gir"; }
	}

	private GirComment create_empty_gir_comment () {
		return new GirComment ("", current_source_file, begin.line, begin.column, end.line, end.column);
	}

	private GirComment create_gir_comment (Api.SourceComment sc) {
		return new GirComment (sc.content, sc.file, sc.first_line, sc.first_column, sc.last_line, sc.last_column);
	}

	private void error (string msg_format, ...) {
		va_list args = va_list();
		string msg = msg_format.vprintf (args);

		string code_line = null;

		unowned string start_src_line = ((string) begin.pos).utf8_offset (-begin.column);
		int offset = start_src_line.index_of_char ('\n');
		if (offset == -1) {
			code_line = start_src_line;
		} else {
			code_line = start_src_line.substring (0, offset);
		}

		reporter.error (current_source_file.get_name (), begin.line, begin.column, end.column, code_line, msg);
	}

	public GirDocumentationImporter (Api.Tree tree, DocumentationParser docparser, ModuleLoader modules, Settings settings, ErrorReporter reporter) {
		base (tree, modules, settings);
		this.docparser = docparser;
		this.reporter = reporter;
	}

	public override void process (string filename) {
		parse_file (filename);
	}

	void parse_file (string gir_file) {
		this.current_source_file = new Api.SourceFile (gir_file, null);
		reader = new MarkupReader (gir_file, reporter);

		// xml prolog
		next ();
		next ();

		next ();
		parse_repository ();
		this.current_source_file = null;
	}

	Api.SourceComment? parse_doc () {
		start_element ("doc");

		Api.SourceComment comment = null;
		next ();

		if (current_token == MarkupTokenType.TEXT) {
			comment = new Api.SourceComment (reader.content, current_source_file, begin.line, begin.column, end.line, end.column);
			next ();
		}

		end_element ("doc");
		return comment;
	}

	void next () {
		current_token = reader.read_token (out begin, out end);
	}

	void start_element (string name) {
		if (current_token != MarkupTokenType.START_ELEMENT || reader.name != name) {
			error ("expected start element of `%s' instead of `%s'", name, reader.name);
		}
	}

	void end_element (string name) {
		if (current_token != MarkupTokenType.END_ELEMENT || reader.name != name) {
			error ("expected end element of `%s' instead of `%s'", name, reader.name);
		}
		next ();
	}

	void parse_repository () {
		start_element ("repository");
		next ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "namespace") {
				parse_namespace ();
			} else if (reader.name == "include") {
				parse_include ();
			} else if (reader.name == "package") {
				parse_package ();
			} else if (reader.name == "c:include") {
				parse_c_include ();
			} else {
				error ("unknown child element `%s' in `repository'", reader.name);
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
			if (current_token == MarkupTokenType.START_ELEMENT) {
				level++;
			} else if (current_token == MarkupTokenType.END_ELEMENT) {
				level--;
			} else if (current_token == MarkupTokenType.EOF) {
				error ("unexpected end of file");
				break;
			}
			next ();
		}
	}

	void parse_namespace () {
		start_element ("namespace");
		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
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
				error ("unknown child element `%s' in `namespace'", reader.name);
				break;
			}
		}
		end_element ("namespace");
	}

	void parse_alias () {
		start_element ("alias");
		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name != "alias") {
				skip_element ();
			}
		}

		end_element ("alias");
	}

	void parse_enumeration () {
		start_element ("enumeration");
		string cname = reader.get_attribute ("c:type");
		type_cname_stack.add (cname);
		next ();

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, create_gir_comment (parse_doc ()));
		}

		while (current_token == MarkupTokenType.START_ELEMENT) {
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

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, create_gir_comment (parse_doc ()));
		}

		while (current_token == MarkupTokenType.START_ELEMENT) {
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

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, create_gir_comment (parse_doc ()));
		}

		end_element ("member");
	}

	void parse_return_value (GirComment doc) {
		start_element ("return-value");
		next ();

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			doc.return_value = parse_doc ();
		}

		parse_type ();

		end_element ("return-value");
	}

	void parse_parameter (GirComment doc) {
		start_element ("parameter");
		string name = reader.get_attribute ("name");

		if (name == null) {
			name = "param%d".printf (anonymous_param_count);
			anonymous_param_count++;
		}

		next ();

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
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

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, create_gir_comment (parse_doc ()));
		}

		while (current_token == MarkupTokenType.START_ELEMENT) {
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
				error ("unknown child element `%s' in `record'", reader.name);
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

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, create_gir_comment (parse_doc ()));
		}

		while (current_token == MarkupTokenType.START_ELEMENT) {
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
				error ("unknown child element `%s' in `class'", reader.name);
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

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, create_gir_comment (parse_doc ()));
		}

		while (current_token == MarkupTokenType.START_ELEMENT) {
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
				error ("unknown child element `%s' in `interface'", reader.name);
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

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc" && cname != null) {
			string real_cname = type_cname_stack.peek();
			real_cname = (real_cname == null)? cname : real_cname+"."+cname;
			process_documentation (real_cname, create_gir_comment (parse_doc ()));
		}

		parse_type ();

		end_element ("field");
	}

	void parse_property () {
		start_element ("property");
		string cname = reader.get_attribute ("name");
		next ();

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc" && cname != null) {
			process_documentation (type_cname_stack.peek()+":"+cname, create_gir_comment (parse_doc ()));
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

		GirComment doc;

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			doc = create_gir_comment (parse_doc ());
		} else {
			doc = create_empty_gir_comment ();
		}

		parse_return_value (doc);

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();
			while (current_token == MarkupTokenType.START_ELEMENT) {
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

		GirComment doc;

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			doc = create_gir_comment (parse_doc ());
		} else {
			doc = create_empty_gir_comment ();
		}

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			parse_return_value (doc);
		}

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();

			while (current_token == MarkupTokenType.START_ELEMENT) {
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

		GirComment doc;

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			doc = create_gir_comment (parse_doc ());
		} else {
			doc = create_empty_gir_comment ();
		}

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			parse_return_value (doc);
		}

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();
			while (current_token == MarkupTokenType.START_ELEMENT) {
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

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, create_gir_comment (parse_doc ()));
		}

		while (current_token == MarkupTokenType.START_ELEMENT) {
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
				error ("unknown child element `%s' in `class'", reader.name);
				break;
			}
		}

		if (current_token != MarkupTokenType.END_ELEMENT) {
			error ("expected end element");
		}
		next ();
	}

	void parse_union () {
		start_element ("union");
		string cname = reader.get_attribute ("c:type");
		type_cname_stack.add (cname);
		next ();

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (cname, create_gir_comment (parse_doc ()));
		}

		while (current_token == MarkupTokenType.START_ELEMENT) {
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

		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc") {
			process_documentation (name, create_gir_comment (parse_doc ()));
		}

		parse_type ();

		end_element ("constant");
	}

	void process_documentation (string? cname, GirComment? doc) {
		if (cname == null || doc == null) {
			return;
		}
	
		var node = tree.search_symbol_cstr (cname);
		
		if (node != null) {
			node.documentation = docparser.parse_gir_comment (node, doc);
		}
	}
}

