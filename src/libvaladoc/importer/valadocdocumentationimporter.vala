/* resourcelocator.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
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


using Gee;



public class Valadoc.Xml.DocumentationImporter : Valadoc.DocumentationImporter {
	public Valadoc.MarkupReader reader { get; private set; }
	private Vala.MarkupTokenType current_token;
	private Vala.SourceLocation begin;
	private Vala.SourceLocation end;
	private string filename;

	public DocumentationImporter (Api.Tree tree, ModuleLoader modules, Settings settings, ErrorReporter errorreporter) {
		base (tree, modules, settings, errorreporter);
	}

	public override bool process (string filename, Settings settings, Api.Package package) {
		this.filename = filename;

		reader = new Valadoc.MarkupReader (filename);
		skip_xml_header ();

		flush_and_init (package);
		process_package ();
		return true;
	}


	// error:
	public void error (string msg) {
		string line = reader.get_line_str ();
		errorreporter.error (reader.filename, reader.line, 0, line.len ()+1, line, msg);
	}

	public bool node_types_contains (Api.NodeType[] node_types, Api.NodeType node_type) {
		foreach (var entry in node_types) {
			if (node_type == entry) {
				return true;
			}
		}
		return false;
	}


	// Api-Tree helpers:
	private ArrayList<Object> docstack = new ArrayList<Object> ();

	public void push (Object element) {
		docstack.add (element);
	}

	public Object peek (int offset = -1) {
		assert (docstack.size >= - offset);
		return docstack.get (docstack.size + offset);
	}

	public Object pop () {
		Object node = peek ();
		docstack.remove_at (docstack.size - 1);
		return node;
	}

	private string serialize_api_stack () {
		var stack = new StringBuilder ();
		bool first = true;

		foreach (Object obj in docstack) {
			if (first == false) {
				stack.append_c ('.');
			}
			var name = ((Api.Node)obj).name;
			stack.append ((name == null)? "(null)" : name);
			first = false;
		}

		return stack.str;
	}

	public bool push_node (string? name, Api.NodeType[] node_types) {
		if (name == null) {
			name = "";
		}

		Api.Node last_node = (Api.Node) peek ();

		var node = last_node.find_by_name (name);
		if (node == null) {
			error ("The referenced node  `%s.%s' does not exist".printf (serialize_api_stack (), name));
			return false;
		}

		if (!node_types_contains (node_types, node.node_type)) {
			error ("The referenced node has the wrong type");
			return false;
		}

		push (node);
		return true;
	}

	public void flush_and_init (Valadoc.Api.Package pkg) {
		docstack.clear ();
		push (pkg);
	}



	// XML-Helpers:
	public inline void skip_xml_header () {
		next ();
		next ();
		next ();
	}

	public string get_text () {
		if (current_token == Vala.MarkupTokenType.TEXT) {
			string? text = reader.text;
			next ();
			return text;
		}

		return "";
	}

	public void next () {
		current_token = reader.read_token (out begin, out end);
	}

	public void start_element (string name) {
		if (current_token != Vala.MarkupTokenType.START_ELEMENT || reader.name != name) {
			error ("expected start element of `%s'\n".printf (name));
		}
	}

	public void end_element (string name) {
		if (current_token != Vala.MarkupTokenType.END_ELEMENT || reader.name != name) {
			error ("expected end element of `%s'\n".printf (name));
		}
		next ();
	}

	public void process_unknown_element () {
		error ("unknown element `%s'\n".printf (reader.name));
		next ();
	}



	// parse api:
	public void process_node (string name, Valadoc.Api.NodeType[] node_types) {
		start_element (name);

		var tmp = push_node (reader.get_attribute ("name"), node_types);
		next ();

		if (!tmp) {
			return ;
		}


		int documentation = 0;

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "documentation" && documentation == 0) {
				process_documentation ();
				documentation++;
			} else if (reader.name == "method") {
				process_method ();
			} else if (reader.name == "class") {
				process_class ();
			} else if (reader.name == "field") {
				process_field ();
			} else if (reader.name == "constant") {
				process_constant ();
			} else if (reader.name == "signal") {
				process_signal ();
			} else if (reader.name == "delegate") {
				process_delegate ();
			} else if (reader.name == "struct") {
				process_struct ();
			} else if (reader.name == "interface") {
				process_interface ();
			} else if (reader.name == "error-domain") {
				process_error_domain ();
			} else if (reader.name == "enum") {
				process_enum ();
			} else if (reader.name == "namespace") {
				process_namespace ();
			} else if (reader.name == "property") {
				process_property ();
			} else if (reader.name == "enum-value") {
				process_enum_value ();
			} else if (reader.name == "error-code") {
				process_error_code ();
			} else {
				process_unknown_element ();
				break;
			}
		}

		end_element (name);
		pop ();
	}

	public void process_package () {
		start_element ("package");
		next ();

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "namespace") {
				process_namespace ();
			} else {
				process_unknown_element ();
				break;
			}
		}

		end_element ("package");
	}

	public void process_namespace () {
		process_node ("namespace", {Api.NodeType.NAMESPACE});
	}

	public void process_interface () {
		process_node ("interface", {Api.NodeType.INTERFACE});
	}

	public void process_class () {
		process_node ("class", {Api.NodeType.CLASS});
	}

	public void process_struct () {
		process_node ("struct", {Api.NodeType.STRUCT});
	}

	public void process_property () {
		process_node ("property", {Api.NodeType.PROPERTY});
	}

	public void process_field () {
		process_node ("field", {Api.NodeType.FIELD});
	}

	public void process_constant () {
		process_node ("constant", {Api.NodeType.CONSTANT});
	}

	public void process_delegate () {
		process_node ("delegate", {Api.NodeType.DELEGATE});
	}

	public void process_signal () {
		process_node ("signal", {Api.NodeType.SIGNAL});
	}

	public void process_method () {
		process_node ("method", {Api.NodeType.METHOD, Api.NodeType.STATIC_METHOD, Api.NodeType.CREATION_METHOD});
	}

	public void process_error_domain () {
		process_node ("error-domain", {Api.NodeType.ERROR_DOMAIN});
	}

	public void process_error_code () {
		process_node ("error-code", {Api.NodeType.ERROR_CODE});
	}

	public void process_enum () {
		process_node ("enum", {Api.NodeType.ENUM});
	}

	public void process_enum_value () {
		process_node ("enum-value", {Api.NodeType.ENUM_VALUE});
	}


	// parse documentation:
	public void process_text () {
		while (current_token == Vala.MarkupTokenType.START_ELEMENT || current_token == Vala.MarkupTokenType.TEXT) {
			if (current_token == Vala.MarkupTokenType.TEXT) {
				((Content.InlineContent) peek ()).content.add (factory.create_text (get_text ()));
				continue;
			}

			if (reader.name == "inline-taglet") {
				process_inline_taglet ();
			} else if (reader.name == "source-code") {
				process_source_code ();
			} else if (reader.name == "embedded") {
				process_embedded ();
			} else if (reader.name == "link") {
				process_link ();
			} else if (reader.name == "run") {
				process_run ();
			} else if (reader.name == "br") {
				((Content.InlineContent) peek ()).content.add (factory.create_text (get_text ()));
				((Content.InlineContent) peek ()).content.add (factory.create_text ("\n"));
				next ();
			} else {
				process_unknown_element ();
				break;
			}
		}
	}


	public void process_source_code () {
		start_element ("source-code");

		var src = factory.create_source_code ();
		((Content.InlineContent) peek ()).content.add (src);

		string? langstr = reader.get_attribute ("language");
		if (langstr != null) {
			var lang = Content.SourceCode.Language.from_string (langstr);
			if (lang != null) {
				src.language = lang;
			} else {
				error ("missing language-attribute in `source-code'");
			}
		}

		next ();

		if (current_token == Vala.MarkupTokenType.TEXT) {
			src.code = get_text ();
		} else {
			src.code = "\n";
		}

		end_element ("source-code");
	}

	public void process_embedded () {
		start_element ("embedded");
		string? caption = reader.get_attribute ("caption");
		string? url = reader.get_attribute ("url");
		if (url != null) {
			var embedded = factory.create_embedded ();
			embedded.url = Path.build_filename (Path.get_dirname (this.filename), url);
			embedded.caption = caption;

			((Content.InlineContent) peek ()).content.add (embedded);
		} else {
			error ("missing url-attribute in `embedded'");
		}

		next ();
		end_element ("embedded");
	}


	public void process_link () {
		start_element ("link");

		string? url = reader.get_attribute ("url");
		if (url == null) {
			error ("missing url-attribute in `link'");
		}

		next ();

		var link = factory.create_link ();
		((Content.InlineContent) peek ()).content.add (link);
		link.url = url;
		push (link);

		process_text ();

		pop ();
		end_element ("link");
	}


	public void process_run () {
		start_element ("run");


		Content.Run.Style? style = null;

		var stylestr = reader.get_attribute ("style");
		if (stylestr == null || (style = Content.Run.Style.from_string (stylestr)) == null) {
			error ("invalid style attribute 'style' in `run'");
		}

		var run = factory.create_run (style);
		((Content.InlineContent) peek ()).content.add (run);
		push (run);

		next ();

		process_text ();

		pop ();
		end_element ("run");
	}


	public void process_paragraph () {
		start_element ("paragraph");
		next ();

		var paragraph = factory.create_paragraph ();
		((Content.BlockContent) peek ()).content.add (paragraph);
		push (paragraph);

		process_text ();

		pop ();
		end_element ("paragraph");
	}


	public void process_headline () {
		start_element ("headline");

		string levelstr = reader.get_attribute ("level");
		int level = (levelstr != null)? levelstr.to_int () : 1;
		next ();

		string text = get_text ();


		end_element ("headline");

		if (level > 1 && text != null && text != "") {
			var headline = factory.create_headline ();
			headline.content.add (factory.create_text (text));
			headline.level = level;

			((Content.BlockContent) peek ()).content.add (headline);
		}
	}

	public void process_inline_taglet () {
		start_element ("inline-taglet");
		var tagname = reader.get_attribute ("name");
		var tag = factory.create_taglet (tagname);
		if (tag != null && tag is Content.InlineTaglet) {
			((Content.InlineContent) peek ()).content.add ((Content.InlineTaglet) tag);
			tag.xml_importer_parer_rule (this);
		} else {
			error ("Inline-Taglet not found: %s".printf (tagname));
			next ();
		}
	}

	public void process_taglet () {
		start_element ("taglet");
		var tagname = reader.get_attribute ("name");
		var tag = factory.create_taglet (tagname);

		if (tag != null) {
			((Content.Comment) peek ()).taglets.add (tag);
			tag.xml_importer_parer_rule (this);
		} else {
			error ("Taglet not found: %s\n".printf (tagname));
			next ();
		}
	}

	public void process_taglets () {
		start_element ("taglets");
		next ();

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "taglet") {
				process_taglet ();
			} else {
				process_unknown_element ();
				break;
			}
		}

		end_element ("taglets");
	}


	public void process_table_cell () {
		start_element ("table-cell");

		var cell = factory.create_table_cell ();
		((Content.TableRow) peek ()).cells.add (cell);
		push (cell);

		string tmpstr = reader.get_attribute ("colspan");
		int colspan = (tmpstr == null) ? 1 : tmpstr.to_int ();
		if (colspan >= 1) {
			cell.colspan = colspan;
		} else {
			colspan = 1;
		}

		tmpstr = reader.get_attribute ("rowspan");
		int rowspan = (tmpstr == null) ? 1 : tmpstr.to_int ();
		if (rowspan >= 1) {
			cell.rowspan = rowspan;
		} else {
			cell.rowspan = 1;
		}

		tmpstr = reader.get_attribute ("horizontal-align");
		if (tmpstr != null) {
			var horizontal_align = Content.HorizontalAlign.from_string (tmpstr);
			if (horizontal_align != null) {
				cell.horizontal_align = horizontal_align;
			} else {
				error ("missing attribute horizontal-align in `table-cell'");
			}
		}

		tmpstr = reader.get_attribute ("vertical-align");
		if (tmpstr != null) {
			var vertical_align = Content.VerticalAlign.from_string (tmpstr);
			if (vertical_align != null) {
				cell.vertical_align = vertical_align;
			} else {
				error ("missing attribute vertical-align in `table-cell'");
			}
		}

		next ();

		process_text ();

		pop ();
		end_element ("table-cell");
	}


	public void process_table_row () {
		start_element ("table-row");
		next ();

		var row = factory.create_table_row ();
		((Content.Table) peek ()).rows.add (row);
		push (row);

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "table-cell") {
				process_table_cell ();
			} else {
				process_unknown_element ();
				break;
			}
		}

		pop ();
		end_element ("table-row");
	}


	public void process_table () {
		start_element ("table");
		next ();

		var table = factory.create_table ();
		((Content.BlockContent) peek ()).content.add (table);
		push (table);

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "table-row") {
				process_table_row ();
			} else {
				process_unknown_element ();
				break;
			}
		}

		pop ();
		end_element ("table");
	}


	public void process_list_item () {
		start_element ("list-item");
		next ();

		var item = factory.create_list_item ();
		((Content.List) peek ()).items.add (item);
		push (item);

		process_text ();

		pop ();
		end_element ("list-item");
	}


	public void process_list () {
		start_element ("list");

		var list = factory.create_list ();
		((Content.BlockContent) peek ()).content.add (list);
		push (list);

		var att = reader.get_attribute ("bullet-type");
		if (att != null) {
			var bullet = Content.List.Bullet.from_string (att);
			if (bullet != null) {
				list.bullet = bullet;
			}
		}

		next ();

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "list-item") {
				process_list_item ();
			} else {
				process_unknown_element ();
				break;
			}
		}

		pop ();
		end_element ("list");
	}

	public void process_documentation () {
		start_element ("documentation");
		next ();

		var comment = factory.create_comment ();
		((Api.Node) peek ()).documentation = comment;
		push (comment);

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "paragraph") {
				process_paragraph ();
			} else if (reader.name == "headline") {
				process_headline ();
			} else if (reader.name == "taglets") {
				process_taglets ();
			} else if (reader.name == "table") {
				process_table ();
			} else if (reader.name == "list") {
				process_list ();
			} else {
				process_unknown_element ();
				break;
			}
		}

		pop ();
		comment.check (tree, (Api.Node) peek (), errorreporter, settings);
		end_element ("documentation");
	}
}


