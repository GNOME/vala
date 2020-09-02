/* gtkcommentparser.vala
 *
 * Copyright (C) 2011-2014  Florian Brosch
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


using Valadoc.Content;
using Valadoc.Gtkdoc;

public class Valadoc.Gtkdoc.Parser : Object, ResourceLocator {
	private Scanner scanner = new Scanner ();
	private Token current;

	private Vala.List<string> stack = new Vala.ArrayList<string> (str_equal);
	private Vala.List<Vala.List<Block>> footnotes = new Vala.ArrayList<Vala.ArrayList<Block>> ();

	private ContentFactory factory;
	private ErrorReporter reporter;
	private Settings settings;
	private Api.Tree tree;
	private Api.Node? element;

	private bool show_warnings;
	private Api.SourceComment comment;
	private unowned string instance_param_name;

	private string[]? comment_lines;

	private Regex? is_numeric_regex = null;
	private Regex? normalize_regex = null;
	private Regex regex_source_lang = null;

	private Importer.InternalIdRegistrar id_registrar = null;
	private GirMetaData? current_metadata = null;

	private inline string fix_resource_path (string path) {
		return this.current_metadata.get_resource_path (path);
	}

	private void reset (Api.SourceComment comment) {
		this.scanner.reset (comment.content);
		this.show_warnings = !comment.file.package.is_package;
		this.comment_lines = null;
		this.footnotes.clear ();
		this.comment = comment;
		this.current = null;
		this.stack.clear ();
	}

	private string normalize (string text) {
		try {
			return normalize_regex.replace (text, -1, 0, " ");
		} catch (RegexError e) {
			assert_not_reached ();
		}
	}

	private bool is_numeric (string str) {
		return is_numeric_regex.match (str);
	}

	private void report_unexpected_token (Token got, string expected) {
		report_warning (got, "Unexpected Token: %s (Expected: %s)".printf (got.to_string (), expected));
	}

	private void report_warning (Token got, string message) {
		if (!this.show_warnings) {
			return ;
		}

		int startpos = (got.line == 0)? comment.first_column + got.first_column : got.first_column;
		int endpos = (got.line == 0)? comment.first_column + got.last_column : got.last_column;

		if (this.comment_lines == null) {
			this.comment_lines = this.comment.content.split ("\n");
		}

		this.reporter.warning (this.comment.file.get_name (),
							   comment.first_line + got.line,
							   startpos + 1,
							   endpos + 1,
							   this.comment_lines[got.line],
							   message);
	}

	public Parser (Settings settings, ErrorReporter reporter, Api.Tree tree, ModuleLoader modules) {
		this.factory = new ContentFactory (settings, this, modules);
		this.reporter = reporter;
		this.settings = settings;
		this.tree = tree;

		try {
			is_numeric_regex = new Regex ("^[+-]?([0-9]*\\.?[0-9]+|[0-9]+\\.?[0-9]*)([eE][+-]?[0-9]+)?$",
				RegexCompileFlags.OPTIMIZE);
			normalize_regex = new Regex ("( |\n|\t)+", RegexCompileFlags.OPTIMIZE);
			regex_source_lang = new Regex ("^<!--[ \t]+language=\"([A-Za-z]*)\"[ \t]+-->");
		} catch (RegexError e) {
			assert_not_reached ();
		}
	}

	private Note? _parse_note (Api.SourceComment comment) {
		Comment? cmnt = parse_root_content (comment);
		if (cmnt == null) {
			return null;
		}

		Note note = factory.create_note ();
		note.content.add_all (cmnt.content);

		return note;
	}

	private void add_note (ref Comment? comment, Note? note) {
		if (note == null) {
			return ;
		}

		if (comment == null) {
			comment = factory.create_comment ();
		}

		if (comment.content.size == 0) {
			comment.content.add (factory.create_paragraph ());
		}

		comment.content.insert (1, note);
	}

	private void add_taglet (ref Comment? comment, Taglet? taglet) {
		if (taglet == null) {
			return ;
		}

		if (comment == null) {
			comment = factory.create_comment ();
		}

		comment.taglets.add (taglet);
	}

	public Comment? parse (Api.Node element, Api.GirSourceComment gir_comment, GirMetaData gir_metadata, Importer.InternalIdRegistrar id_registrar) {
		this.instance_param_name = gir_comment.instance_param_name;
		this.current_metadata = gir_metadata;
		this.id_registrar = id_registrar;
		this.element = element;


		Comment? cmnt = parse_root_content (gir_comment);
		if (cmnt != null) {
			ImporterHelper.extract_short_desc (cmnt, factory);
		}


		// deprecated:
		if (gir_comment.deprecated_comment != null) {
			Note? note = _parse_note (gir_comment.deprecated_comment);
			add_note (ref cmnt, note);
		}


		// version:
		if (gir_comment.version_comment != null) {
			Note? note = _parse_note (gir_comment.version_comment);
			add_note (ref cmnt, note);
		}

		// stability:
		if (gir_comment.stability_comment != null) {
			Note? note = _parse_note (gir_comment.stability_comment);
			add_note (ref cmnt, note);
		}


		// return:
		if (gir_comment.return_comment != null) {
			Taglet? taglet = parse_block_taglet (gir_comment.return_comment, "return");
			add_taglet (ref cmnt, taglet);
		}


		// parameters:
		Vala.MapIterator<string, Api.SourceComment> iter = gir_comment.parameter_iterator ();
		for (bool has_next = iter.next (); has_next; has_next = iter.next ()) {
			Taglets.Param? taglet = parse_block_taglet (iter.get_value (), "param") as Taglets.Param;
			string param_name = iter.get_key ();

			taglet.is_c_self_param = (param_name == gir_comment.instance_param_name);
			taglet.parameter_name = param_name;
			add_taglet (ref cmnt, taglet);
		}


		bool first = true;
		foreach (Vala.List<Block> note in this.footnotes) {
			if (first == true && note.size > 0) {
				Paragraph p = note.first () as Paragraph;
				if (p == null) {
					p = factory.create_paragraph ();
					cmnt.content.add (p);
				}

				p.content.insert (0, factory.create_text ("\n"));
			}
			cmnt.content.add_all (note);
			first = false;
		}

		return cmnt;
	}

	private Taglet? parse_block_taglet (Api.SourceComment gir_comment, string taglet_name) {
		this.reset (gir_comment);
		current = null;
		next ();

		parse_docbook_spaces (false);
		var ic = parse_inline_content ();
		parse_docbook_spaces (false);

		BlockContent? taglet = factory.create_taglet (taglet_name) as BlockContent;
		assert (taglet != null);
		Paragraph paragraph = factory.create_paragraph ();

		if (current.type == TokenType.EOF) {
			paragraph.content.add (ic);
		} else {
			this.report_unexpected_token (current, "<EOF>");
		}

		taglet.content.add (paragraph);
		return taglet as Taglet;
	}

	private Comment? parse_root_content (Api.SourceComment gir_comment) {
		this.reset (gir_comment);
		current = null;

		next ();

		Token tmp = null;
		parse_docbook_spaces (false);

		Comment comment = factory.create_comment ();
		while (current.type != TokenType.EOF && tmp != current) {
			tmp = current;
			var ic = parse_inline_content ();
			if (ic != null && ic.content.size > 0) {
				Paragraph p = factory.create_paragraph ();
				p.content.add (ic);
				comment.content.add (p);
			}

			var bc = parse_block_content ();
			if (bc != null && bc.size > 0) {
				comment.content.add_all (bc);
			}
		}

		if (current.type != TokenType.EOF) {
			this.report_unexpected_token (current, "<INLINE|BLOCK>");
			return null;
		}

		ImporterHelper.extract_short_desc (comment, factory);

		return comment;
	}



	//
	// Common:
	//

	private Token next () {
		current = scanner.next ();
		return current;
	}

	private bool ignore_current_xml_close () {
		if (current.type != TokenType.XML_CLOSE) {
			return false;
		}

		string name = current.content;
		if ((name in stack) == false) {
			return true;
		}

		return false;
	}

	private bool check_xml_open_tag (string tagname) {
		if ((current.type == TokenType.XML_OPEN && current.content != tagname)
			|| current.type != TokenType.XML_OPEN)
		{
			return false;
		}

		stack.insert (0, tagname);
		return true;
	}

	private bool check_xml_close_tag (string tagname) {
		if ((current.type == TokenType.XML_CLOSE && current.content != tagname)
			|| current.type != TokenType.XML_CLOSE)
		{
			return false;
		}

		assert (stack.remove_at (0) == tagname);

		return true;
	}


	private void parse_docbook_spaces (bool accept_paragraphs = true) {
		while (true) {
			if (current.type == TokenType.SPACE) {
				next ();
			} else if (current.type == TokenType.NEWLINE) {
				next ();
			} else if (accept_paragraphs && current.type == TokenType.GTKDOC_PARAGRAPH) {
				next ();
			} else {
				break;
			}
		}
	}



	//
	// Rules, Ground:
	//

	private Inline? parse_docbook_link_tempalte (string tagname, bool is_internal) {
		if (!check_xml_open_tag (tagname)) {
			this.report_unexpected_token (current, "<%s>".printf (tagname));
			return null;
		}

		StringBuilder builder = new StringBuilder ();
		string url;
		if (is_internal) {
			url = current.attributes.get ("linkend");
		} else {
			url = current.attributes.get ("url");
		}
		next ();

		// TODO: check xml
		while (!(current.type == TokenType.XML_CLOSE && current.content == tagname)
			&& current.type != TokenType.EOF)
		{
			if (current.type == TokenType.XML_OPEN) {
			} else if (current.type == TokenType.XML_CLOSE) {
			} else if (current.type == TokenType.XML_COMMENT) {
			} else {
				builder.append (current.content);
			}

			next ();
		}

		var link = factory.create_link ();
		if (is_internal) {
			link.id_registrar = id_registrar;
		}
		link.url = url;

		if (builder.len == 0) {
			link.content.add (factory.create_text (url));
		} else {
			link.content.add (factory.create_text (normalize (builder.str)));
		}

		if (!check_xml_close_tag (tagname)) {
			this.report_unexpected_token (current, "</%s>".printf (tagname));
			return link;
		}

		next ();
		return link;
	}

	private InlineTaglet? parse_symbol_link (string tagname) {
		if (!check_xml_open_tag (tagname)) {
			this.report_unexpected_token (current, "<%s>".printf (tagname));
			return null;
		}

		if (next ().type == TokenType.SPACE) {
			next ();
		}

		InlineTaglet? taglet = null;

		if (current.type == TokenType.WORD && current.content == "struct") {
			next ();

			if (next ().type == TokenType.SPACE) {
				next ();
			}
		}


		if (current.type == TokenType.GTKDOC_FUNCTION || current.type == TokenType.GTKDOC_CONST
			|| current.type == TokenType.GTKDOC_TYPE || current.type == TokenType.WORD
			|| current.type == TokenType.GTKDOC_PROPERTY || current.type == TokenType.GTKDOC_SIGNAL)
		{
			taglet = this.create_type_link (current.content) as InlineTaglet;
			assert (taglet != null);
		}

		if (next ().type == TokenType.SPACE) {
			next ();
		}

		if (!check_xml_close_tag (tagname)) {
			this.report_unexpected_token (current, "</%s>".printf (tagname));
			return taglet;
		}

		next ();
		return taglet;
	}

	private void parse_anchor () {
		if (!check_xml_open_tag ("anchor")) {
			this.report_unexpected_token (current, "<anchor>");
			return;
		}

		string id = current.attributes.get ("id");
		if (id != null) {
			id_registrar.register_symbol (id, element);
		}
		next ();

		if (!check_xml_close_tag ("anchor")) {
			this.report_unexpected_token (current, "</anchor>");
			return;
		}

		next ();
	}

	private Link? parse_xref () {
		if (!check_xml_open_tag ("xref")) {
			this.report_unexpected_token (current, "<xref>");
			return null;
		}

		string linkend = current.attributes.get ("linkend");
		next ();

		Link link = factory.create_link ();
		link.content.add (factory.create_text (linkend));
		link.id_registrar = id_registrar;
		link.url = linkend;

		if (!check_xml_close_tag ("xref")) {
			this.report_unexpected_token (current, "</xref>");
			return link;
		}

		next ();
		return link;
	}

	private Run? parse_highlighted_template (string tag_name, Run.Style style) {
		if (!check_xml_open_tag (tag_name)) {
			this.report_unexpected_token (current, "<%s>".printf (tag_name));
			return null;
		}

		next ();
		Run run = parse_inline_content ();
		if (run.style != Run.Style.NONE && run.style != style) {
			Run tmp = factory.create_run (style);
			tmp.content.add (run);
			run = tmp;
		} else {
			run.style = style;
		}

		if (!check_xml_close_tag (tag_name)) {
			this.report_unexpected_token (current, "</%s>".printf (tag_name));
			return run;
		}

		next ();
		return run;
	}

	private ListItem?  parse_docbook_listitem () {
		if (!check_xml_open_tag ("listitem")) {
			this.report_unexpected_token (current, "<listitem>");
			return null;
		}

		next ();

		ListItem item = factory.create_list_item ();

		item.content.add_all (parse_mixed_content ());

		if (!check_xml_close_tag ("listitem")) {
			this.report_unexpected_token (current, "</listitem>");
			return item;
		}

		next ();
		return item;
	}

	private BlockContent? parse_docbook_information_box_template (string tagname, BlockContent container) {
		if (!check_xml_open_tag (tagname)) {
			this.report_unexpected_token (current, "<%s>".printf (tagname));
			return null;
		}

		next ();
		parse_docbook_spaces ();

		Token tmp = null;
		while (current.type != TokenType.XML_CLOSE && current.type != TokenType.EOF) {
			tmp = current;
			var ic = parse_inline_content ();
			if (ic != null && ic.content.size > 0) {
				Paragraph p = factory.create_paragraph ();
				p.content.add (ic);
				container.content.add (p);
			}

			var bc = parse_block_content ();
			if (bc != null && bc.size > 0) {
				container.content.add_all (bc);
			}
		}

		parse_docbook_spaces ();

		if (!check_xml_close_tag (tagname)) {
			this.report_unexpected_token (current, "</%s>".printf (tagname));
			return container;
		}

		next ();
		return container;
	}

	private Note? parse_docbook_important () {
		return (Note?) parse_docbook_information_box_template ("important", factory.create_note ());
	}

	private Note? parse_docbook_note () {
		return (Note?) parse_docbook_information_box_template ("note", factory.create_note ());
	}

	private Warning? parse_docbook_warning () {
		return (Warning?) parse_docbook_information_box_template ("warning", factory.create_warning ());
	}

	private inline Vala.Collection<Block>? parse_docbook_orderedlist () {
		return parse_docbook_itemizedlist ("orderedlist", Content.List.Bullet.ORDERED);
	}

	private Vala.Collection<Block>? parse_docbook_itemizedlist (string tag_name = "itemizedlist",
										   Content.List.Bullet bullet_type = Content.List.Bullet.UNORDERED)
	{
		if (!check_xml_open_tag (tag_name)) {
			this.report_unexpected_token (current, "<%s>".printf (tag_name));
			return null;
		}
		next ();


		Vala.Collection<Block> content = new Vala.ArrayList<Block> ();
		parse_docbook_spaces ();

		if (current.type == TokenType.XML_OPEN && current.content == "title") {
			append_block_content_not_null (content, parse_docbook_title ());
			parse_docbook_spaces ();
		}

		Content.List list = factory.create_list ();
		list.bullet = bullet_type;
		content.add (list);

		while (current.type == TokenType.XML_OPEN) {
			if (current.content == "listitem") {
				list.items.add (parse_docbook_listitem ());
			} else {
				break;
			}

			parse_docbook_spaces ();
		}

		if (!check_xml_close_tag (tag_name)) {
			this.report_unexpected_token (current, "</%s>".printf (tag_name));
			return content;
		}

		next ();
		return content;
	}

	private Paragraph? parse_gtkdoc_paragraph () {
		if (current.type != TokenType.GTKDOC_PARAGRAPH) {
			this.report_unexpected_token (current, "<GTKDOC-PARAGRAPH>");
			return null;
		}

		next ();

		Paragraph p = factory.create_paragraph ();

		Run? run = parse_inline_content ();
		p.content.add (run);
		return p;
	}

	private Vala.Collection<Block> parse_mixed_content () {
		Vala.Collection<Block> content = new Vala.ArrayList<Block> ();
		Token tmp = null;

		while (tmp != current) {
			tmp = current;
			parse_docbook_spaces ();

			Run? run = parse_inline_content ();
			if (run != null && run.content.size > 0) {
				Paragraph p = factory.create_paragraph ();
				p.content.add (run);
				content.add (p);
				continue;
			}

			Vala.Collection<Block> lst = parse_block_content ();
			if (lst != null && lst.size > 0) {
				content.add_all (lst);
				continue;
			}
		}

		return content;
	}

	private inline Vala.Collection<Block>? parse_docbook_simpara () {
		return parse_docbook_para ("simpara");
	}

	private Vala.Collection<Block>? parse_docbook_para (string tag_name = "para") {
		if (!check_xml_open_tag (tag_name)) {
			this.report_unexpected_token (current, "<%s>".printf (tag_name));
			return null;
		}

		next ();

		Vala.Collection<Block> content = parse_mixed_content ();

		// ignore missing </para> to match gtkdocs behaviour
		if (!check_xml_close_tag (tag_name) && current.type != TokenType.EOF) {
			this.report_unexpected_token (current, "</%s>".printf (tag_name));
			return content;
		}

		next ();
		return content;
	}

	private Paragraph? parse_gtkdoc_source () {
		if (current.type != TokenType.GTKDOC_SOURCE_OPEN) {
			this.report_unexpected_token (current, "|[");
			return null;
		}

		StringBuilder builder = new StringBuilder ();
		Token source_token = current;

		for (next (); current.type != TokenType.EOF && current.type != TokenType.GTKDOC_SOURCE_CLOSE; next ()) {
			if (current.type == TokenType.WORD) {
				builder.append (current.content);
			} else if (current.type != TokenType.XML_COMMENT) {
				builder.append_len (current.start, current.length);
			}
		}

		SourceCode code = factory.create_source_code ();
		MatchInfo info;

		unowned string source = builder.str;
		if (regex_source_lang.match (source, 0, out info)) {
			string lang_name = info.fetch (1).ascii_down ();
			SourceCode.Language? lang = SourceCode.Language.from_string (lang_name);
			code.language = lang;

			if (lang == null) {
				report_warning (source_token, "Unknown language `%s' in source code block |[<!-- language=\"\"".printf (lang_name));
			}

			source = source.offset (source.index_of_char ('>') + 1);
		} else {
			code.language = (Highlighter.XmlScanner.is_xml (source))
				? SourceCode.Language.XML
				: SourceCode.Language.C;
		}
		code.code = source;

		Paragraph p = factory.create_paragraph ();
		p.content.add (code);

		if (current.type != TokenType.GTKDOC_SOURCE_CLOSE) {
			this.report_unexpected_token (current, "|]");
			return p;
		}

		next ();
		return p;
	}

	private Paragraph? parse_docbook_title () {
		if (!check_xml_open_tag ("title")) {
			this.report_unexpected_token (current, "<title>");
			return null;
		}

		next ();

		Paragraph p = factory.create_paragraph ();
		Run content = parse_inline_content ();
		content.content.add (factory.create_text (":"));
		content.style = Run.Style.BOLD;
		p.content.add (content);

		if (!check_xml_close_tag ("title")) {
			this.report_unexpected_token (current, "</title>");
			return p;
		}

		next ();
		return p;
	}

	private Paragraph? parse_docbook_graphic () {
		var tmp = parse_docbook_inlinegraphic ("graphic");
		if (tmp == null) {
			return null;
		}

		Paragraph? p = factory.create_paragraph ();
		p.content.add (tmp);
		return p;
	}

	private Embedded? parse_docbook_inlinegraphic (string tag_name = "inlinegraphic") {
		if (!check_xml_open_tag (tag_name)) {
			this.report_unexpected_token (current, "<%s>".printf (tag_name));
			return null;
		}

		Embedded e = factory.create_embedded ();
		e.url = fix_resource_path (current.attributes.get ("fileref"));

		next ();
		parse_docbook_spaces ();

		if (!check_xml_close_tag (tag_name)) {
			this.report_unexpected_token (current, "</%s>".printf (tag_name));
			return e;
		}

		next ();
		return e;
	}

	private Paragraph? parse_docbook_programlisting () {
		if (!check_xml_open_tag ("programlisting")) {
			this.report_unexpected_token (current, "<programlisting>");
			return null;
		}

		StringBuilder builder = new StringBuilder ();

		for (next (); current.type != TokenType.EOF && !(current.type == TokenType.XML_CLOSE
			&& current.content == "programlisting"); next ())
		{
			if (current.type == TokenType.WORD) {
				builder.append (current.content);
			} else if (current.type != TokenType.XML_COMMENT) {
				builder.append_len (current.start, current.length);
			}
		}

		SourceCode src = factory.create_source_code ();
		src.language = SourceCode.Language.C;
		src.code = builder.str;

		Paragraph p = factory.create_paragraph ();
		p.content.add (src);

		if (!check_xml_close_tag ("programlisting")) {
			this.report_unexpected_token (current, "</programlisting>");
			return p;
		}

		next ();
		return p;
	}

/*
	private Vala.Collection<Block>? parse_docbook_informalexample () {
		if (!check_xml_open_tag ("informalexample")) {
			this.report_unexpected_token (current, "<informalexample>");
			return null;
		}

		next ();

		parse_docbook_spaces ();

		Vala.Collection<Block> content = new Vala.ArrayList<Block> ();

		if (current.type == TokenType.XML_OPEN && current.content == "title") {
			append_block_content_not_null (content, parse_docbook_title ());
			parse_docbook_spaces ();
		}

		if (current.type == TokenType.XML_OPEN && current.content == "programlisting") {
			append_block_content_not_null (content, parse_docbook_programlisting ());
		} else if (current.type == TokenType.XML_OPEN && current.content == "inlinegraphic") {
			Embedded? img = parse_docbook_inlinegraphic ();
			Paragraph p = factory.create_paragraph ();
			append_block_content_not_null (content, p);
			p.content.add (img);

		}

		parse_docbook_spaces ();

		if (!check_xml_close_tag ("informalexample")) {
			this.report_unexpected_token (current, "</informalexample>");
			return content;
		}

		next ();
		return content;
	}
*/

	private inline Vala.Collection<Block>? parse_docbook_informalexample () {
		return parse_docbook_example ("informalexample");
	}

	private Vala.Collection<Block>? parse_docbook_example (string tag_name = "example") {
		if (!check_xml_open_tag (tag_name)) {
			this.report_unexpected_token (current, "<%s>".printf (tag_name));
			return null;
		}

		next ();

		parse_docbook_spaces ();

		Vala.Collection<Block> content = new Vala.ArrayList<Block> ();

		content.add_all (parse_mixed_content ());

		/*
		while (current.type == TokenType.XML_OPEN) {
			if (current.type == TokenType.XML_OPEN && current.content == "inlinegraphic") {
				Paragraph p = factory.create_paragraph ();
				while (current.type == TokenType.XML_OPEN && current.content == "inlinegraphic") {
					p.content.add (parse_docbook_inlinegraphic ());
					parse_docbook_spaces ();
				}
			} else if (current.type == TokenType.XML_OPEN && current.content == "programlisting") {
				append_block_content_not_null (content, parse_docbook_programlisting ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "para") {
				this.append_block_content_not_null_all (content, parse_docbook_para ());
			} else {
				break;
			}

			parse_docbook_spaces ();
		} */

		if (!check_xml_close_tag (tag_name)) {
			this.report_unexpected_token (current, "</%s>".printf (tag_name));
			return content;
		}

		next ();
		return content;
	}

	private Vala.List<Block>? parse_docbook_refsect2 (int nr = 2) {
		if (!check_xml_open_tag ("refsect%d".printf (nr))) {
			this.report_unexpected_token (current, "<refsect%d>".printf (nr));
			return null;
		}

		string id = current.attributes.get ("id");
		if (id != null) {
			id_registrar.register_symbol (id, element);
		}
		next ();

		parse_docbook_spaces ();

		Vala.List<Block> content = new Vala.ArrayList<Block> ();

		this.append_block_content_not_null_all (content, parse_mixed_content ());

		if (!check_xml_close_tag ("refsect%d".printf (nr))) {
			this.report_unexpected_token (current, "</refsect%d>".printf (nr));
			return content;
		}

		next ();
		return content;
	}

	private Vala.List<Block>? parse_docbook_figure () {
		if (!check_xml_open_tag ("figure")) {
			this.report_unexpected_token (current, "<figure>");
			return null;
		}
		next ();

		Vala.List<Block> content = new Vala.ArrayList<Block> ();
		parse_docbook_spaces ();

		if (current.type == TokenType.XML_OPEN && current.content == "title") {
			append_block_content_not_null (content, parse_docbook_title ());
			parse_docbook_spaces ();
		}

		while (current.type == TokenType.XML_OPEN) {
			if (current.content == "inlinegraphic") {
				Paragraph p = (content.size > 0)? content[0] as Paragraph : null;
				if (p == null) {
					p = factory.create_paragraph ();
				}

				while (current.type == TokenType.XML_OPEN && current.content == "inlinegraphic") {
					p.content.add (parse_docbook_inlinegraphic ());
					parse_docbook_spaces ();
				}
			} else if (current.content == "graphic") {
				append_block_content_not_null (content, parse_docbook_graphic ());
			} else {
				break;
			}

			parse_docbook_spaces ();
		}

		if (!check_xml_close_tag ("figure")) {
			this.report_unexpected_token (current, "</figure>");
			return content;
		}

		next ();
		return content;
	}

	private Run? parse_docbook_footnote () {
		if (!check_xml_open_tag ("footnote")) {
			this.report_unexpected_token (current, "<footnote>");
			return null;
		}
		next ();

		int counter = this.footnotes.size + 1;
		Run? nr = factory.create_run (Run.Style.ITALIC);
		nr.content.add (factory.create_text ("[%d] ".printf (counter)));
		Vala.List<Block> content = new Vala.ArrayList<Block> ();
		this.footnotes.add (content);

		content.add_all (parse_mixed_content ());

		Paragraph? first = (content.is_empty)? null : content.first () as Paragraph;
		if (first == null) {
			first = factory.create_paragraph ();
			content.insert (0, first);
		}

		Run entry = factory.create_run (Run.Style.ITALIC);
		entry.content.add (factory.create_text (counter.to_string () + ": "));
		first.content.insert (0, entry);

		if (!check_xml_close_tag ("footnote")) {
			this.report_unexpected_token (current, "</footnote>");
			return nr;
		}

		next ();
		return nr;
	}

	private inline void append_block_content_not_null_all (Vala.Collection<Block> run, Vala.Collection<Block>? elements) {
		if (elements != null) {
			run.add_all (elements);
		}
	}

	private inline void append_block_content_not_null (Vala.Collection<Block> run, Block? element) {
		if (element != null) {
			run.add (element);
		}
	}

	private TableRow? parse_docbook_thead () {
		if (!check_xml_open_tag ("thead")) {
			this.report_unexpected_token (current, "<thead>");
			return null;
		}
		next ();

		parse_docbook_spaces ();
		TableRow? row = parse_docbook_row (Run.Style.BOLD);
		parse_docbook_spaces ();

		if (!check_xml_close_tag ("thead")) {
			this.report_unexpected_token (current, "</thead>");
			return row;
		}

		next ();
		return row;
	}

	private TableCell? parse_docbook_entry (Run.Style default_style = Run.Style.NONE) {
		if (!check_xml_open_tag ("entry")) {
			this.report_unexpected_token (current, "<entry>");
			return null;
		}
		next ();

		TableCell cell = factory.create_table_cell ();
		Run run = factory.create_run (default_style);
		run.content.add (parse_inline_content ());
		cell.content.add (run);

		if (!check_xml_close_tag ("entry")) {
			this.report_unexpected_token (current, "</entry>");
			return cell;
		}

		next ();
		return cell;
	}

	private TableRow? parse_docbook_row (Run.Style default_style = Run.Style.NONE) {
		if (!check_xml_open_tag ("row")) {
			this.report_unexpected_token (current, "<row>");
			return null;
		}
		next ();

		TableRow row = factory.create_table_row ();
		parse_docbook_spaces ();

		while (current.type == TokenType.XML_OPEN && current.content == "entry") {
			TableCell? table_cell = parse_docbook_entry (default_style);
			if (table_cell == null) {
				break;
			}

			row.cells.add (table_cell);
			parse_docbook_spaces ();
		}

		if (!check_xml_close_tag ("row")) {
			this.report_unexpected_token (current, "</row>");
			return row;
		}

		next ();
		return row;
	}

	private Vala.Collection<TableRow>? parse_docbook_tbody () {
		if (!check_xml_open_tag ("tbody")) {
			this.report_unexpected_token (current, "<tbody>");
			return null;
		}
		next ();

		parse_docbook_spaces ();

		Vala.Collection<TableRow> rows = new Vala.ArrayList<TableRow> ();
		while (current.type == TokenType.XML_OPEN && current.content == "row") {
			TableRow? row = parse_docbook_row ();
			if (row == null) {
				break;
			}

			parse_docbook_spaces ();
			rows.add (row);
		}


		if (!check_xml_close_tag ("tbody")) {
			this.report_unexpected_token (current, "</tbody>");
			return rows;
		}

		next ();
		return rows;
	}

	private Table? parse_docbook_tgroup () {
		if (!check_xml_open_tag ("tgroup")) {
			this.report_unexpected_token (current, "<tgroup>");
			return null;
		}
		next ();

		Table table = factory.create_table ();
		parse_docbook_spaces ();

		if (current.type == TokenType.XML_OPEN && current.content == "thead") {
			TableRow? row = parse_docbook_thead ();
			if (row != null) {
				parse_docbook_spaces ();
				table.rows.add (row);
			}

			parse_docbook_spaces ();
		}

		if (current.type == TokenType.XML_OPEN && current.content == "tbody") {
			Vala.Collection<TableRow>? rows = parse_docbook_tbody ();
			if (rows != null) {
				table.rows.add_all (rows);
			}

			parse_docbook_spaces ();
		}

		if (!check_xml_close_tag ("tgroup")) {
			this.report_unexpected_token (current, "</tgroup>");
			return table;
		}

		next ();
		return table;
	}

	private Table? parse_docbook_informaltable () {
		if (!check_xml_open_tag ("informaltable")) {
			this.report_unexpected_token (current, "<informaltable>");
			return null;
		}
		next ();

		parse_docbook_spaces ();
		Table? table = this.parse_docbook_tgroup ();
		parse_docbook_spaces ();

		if (!check_xml_close_tag ("informaltable")) {
			this.report_unexpected_token (current, "</informaltable>");
			return table;
		}

		next ();
		return table;
	}

	private Vala.Collection<Block>? parse_docbook_section () {
		if (!check_xml_open_tag ("section")) {
			this.report_unexpected_token (current, "<section>");
			return null;
		}

		string id = current.attributes.get ("id");
		if (id != null) {
			id_registrar.register_symbol (id, element);
		}
		next ();

		Vala.Collection<Block> content = parse_mixed_content ();

		if (!check_xml_close_tag ("section")) {
			this.report_unexpected_token (current, "</section>");
			return content;
		}

		next ();
		return content;
	}

	private ListItem? parse_docbook_member () {
		if (!check_xml_open_tag ("member")) {
			this.report_unexpected_token (current, "<member>");
			return null;
		}
		next ();

		parse_docbook_spaces ();

		ListItem item = factory.create_list_item ();
		Paragraph para = factory.create_paragraph ();
		item.content.add (para);

		para.content.add (parse_inline_content ());

		parse_docbook_spaces ();

		if (!check_xml_close_tag ("member")) {
			this.report_unexpected_token (current, "</member>");
			return item;
		}

		next ();
		return item;
	}

	private Content.List? parse_docbook_simplelist () {
		if (!check_xml_open_tag ("simplelist")) {
			this.report_unexpected_token (current, "<simplelist>");
			return null;
		}
		next ();

		parse_docbook_spaces ();

		Content.List list = factory.create_list ();

		while (current.type == TokenType.XML_OPEN && current.content == "member") {
			ListItem item = parse_docbook_member ();
			if (item == null) {
				break;
			}

			list.items.add (item);
			parse_docbook_spaces ();
		}


		if (!check_xml_close_tag ("simplelist")) {
			this.report_unexpected_token (current, "</simplelist>");
			return list;
		}

		next ();
		return list;
	}

	private Paragraph? parse_docbook_term () {
		if (!check_xml_open_tag ("term")) {
			this.report_unexpected_token (current, "<term>");
			return null;
		}
		next ();

		parse_docbook_spaces ();

		Paragraph? p = factory.create_paragraph ();
		Run run = parse_inline_content ();
		run.style = Run.Style.ITALIC;
		p.content.add (run);

		if (!check_xml_close_tag ("term")) {
			this.report_unexpected_token (current, "</term>");
			return p;
		}

		next ();
		return p;
	}

	private ListItem? parse_docbook_varlistentry () {
		if (!check_xml_open_tag ("varlistentry")) {
			this.report_unexpected_token (current, "<varlistentry>");
			return null;
		}
		next ();

		parse_docbook_spaces ();

		if (current.type != TokenType.XML_OPEN || current.content != "term") {
			return null;
		}

		Paragraph? term = parse_docbook_term ();
		if (term == null) {
			return null;
		}

		parse_docbook_spaces ();
		ListItem? desc = parse_docbook_listitem ();
		if (desc == null) {
			return null;
		}

		parse_docbook_spaces ();

		Content.ListItem listitem = factory.create_list_item ();
		Content.List list = factory.create_list ();

		listitem.content.add (term);
		listitem.content.add (list);
		list.items.add (desc);

		if (!check_xml_close_tag ("varlistentry")) {
			this.report_unexpected_token (current, "</varlistentry>");
			return listitem;
		}

		next ();
		return listitem;
	}

	private Vala.Collection<Block>? parse_docbook_variablelist () {
		if (!check_xml_open_tag ("variablelist")) {
			this.report_unexpected_token (current, "<variablelist>");
			return null;
		}
		next ();

		parse_docbook_spaces ();

		Vala.Collection<Block> content = new Vala.ArrayList<Block> ();

		if (current.type == TokenType.XML_OPEN && current.content == "title") {
			append_block_content_not_null (content, parse_docbook_title ());
			parse_docbook_spaces ();
		}

		Content.List list = factory.create_list ();
		content.add (list);

		while (current.type == TokenType.XML_OPEN && current.content == "varlistentry") {
			ListItem item = parse_docbook_varlistentry ();
			if (item == null) {
				break;
			}

			list.items.add (item);
			parse_docbook_spaces ();
		}

		if (!check_xml_close_tag ("variablelist")) {
			this.report_unexpected_token (current, "</variablelist>");
			return content;
		}

		next ();
		return content;
	}

	private Vala.Collection<Block> parse_block_content () {
		Vala.Collection<Block> content = new Vala.ArrayList<Block> ();

		while (current.type != TokenType.EOF) {
			parse_docbook_spaces (false);

			if (current.type == TokenType.XML_OPEN && current.content == "itemizedlist") {
				this.append_block_content_not_null_all (content, parse_docbook_itemizedlist ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "orderedlist") {
				this.append_block_content_not_null_all (content, parse_docbook_orderedlist ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "variablelist") {
				this.append_block_content_not_null_all (content, parse_docbook_variablelist ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "simplelist") {
				this.append_block_content_not_null (content, parse_docbook_simplelist ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "informaltable") {
				this.append_block_content_not_null (content, parse_docbook_informaltable ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "programlisting") {
				this.append_block_content_not_null (content, parse_docbook_programlisting ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "para") {
				this.append_block_content_not_null_all (content, parse_docbook_para ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "simpara") {
				this.append_block_content_not_null_all (content, parse_docbook_simpara ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "informalexample") {
				this.append_block_content_not_null_all (content, parse_docbook_informalexample ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "example") {
				this.append_block_content_not_null_all (content, parse_docbook_example ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "warning") {
				this.append_block_content_not_null (content, parse_docbook_warning ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "note") {
				this.append_block_content_not_null (content, parse_docbook_note ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "important") {
				this.append_block_content_not_null (content, parse_docbook_important ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "refsect3") {
				this.append_block_content_not_null_all (content, parse_docbook_refsect2 (3));
			} else if (current.type == TokenType.XML_OPEN && current.content == "refsect2") {
				this.append_block_content_not_null_all (content, parse_docbook_refsect2 ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "figure") {
				this.append_block_content_not_null_all (content, parse_docbook_figure ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "title") {
				this.append_block_content_not_null (content, parse_docbook_title ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "section") {
				this.append_block_content_not_null_all (content, parse_docbook_section ());
			} else if (current.type == TokenType.GTKDOC_PARAGRAPH) {
				this.append_block_content_not_null (content, parse_gtkdoc_paragraph ());
			} else if (current.type == TokenType.GTKDOC_SOURCE_OPEN) {
				this.append_block_content_not_null (content, parse_gtkdoc_source ());
			} else {
				break;
			}
		}

		return content;
	}

	private Run? parse_xml_tag () {
		if (!check_xml_open_tag ("tag")) {
			this.report_unexpected_token (current, "<tag>");
			return null;
		}
		string? _class = current.attributes.get ("class");
		next ();

		parse_docbook_spaces (false);

		if (current.type != TokenType.WORD) {
			this.report_unexpected_token (current, "<WORD>");
			return null;
		}

		Run run = factory.create_run (Run.Style.MONOSPACED);
		if (_class == null || _class == "starttag") {
			run.content.add (factory.create_text ("<" + current.content + ">"));
			next ();
		} else if (_class == "endtag") {
			run.content.add (factory.create_text ("</" + current.content + ">"));
			next ();
		} else {
			this.report_unexpected_token (current, "<tag class=\"%s\">".printf (_class));
			return run;
		}

		parse_docbook_spaces (false);


		if (!check_xml_close_tag ("tag")) {
			this.report_unexpected_token (current, "</tag>");
			return run;
		}

		next ();
		return run;
	}

	private void append_inline_content_string (Run run, string current) {
		Text last_as_text = null;

		if (run.content.size > 0) {
			last_as_text = run.content.last () as Text;
		}

		if (last_as_text == null) {
			run.content.add (factory.create_text (current));
		} else if (current.has_prefix (" ") && last_as_text.content.has_suffix (" ")) {
			last_as_text.content += current.chug ();
		} else {
			last_as_text.content += current;
		}
	}

	private Inline create_type_link (string name, bool c_accept_plural = false) {
		if (name == "TRUE" || name == "FALSE" || name == "NULL" || is_numeric (name)) {
			var monospaced = factory.create_run (Run.Style.MONOSPACED);
			monospaced.content.add (factory.create_text (name.ascii_down ()));
			return monospaced;
		} else {
			Taglets.Link? taglet = factory.create_taglet ("link") as Taglets.Link;
			assert (taglet != null);
			taglet.c_accept_plural = c_accept_plural;
			taglet.symbol_name = "c::"+name;
			return taglet;
		}
	}

	private inline void append_inline_content_not_null (Run run, Inline element) {
		if (element != null) {
			run.content.add (element);
		}
	}

	private Run parse_inline_content () {
		Run run = factory.create_run (Run.Style.NONE);

		while (current.type != TokenType.EOF) {
			if (current.type == TokenType.XML_OPEN && current.content == "firstterm") {
				append_inline_content_not_null (run, parse_highlighted_template ("firstterm", Run.Style.ITALIC));
			} else if (current.type == TokenType.XML_OPEN && current.content == "abbrev") {
				append_inline_content_not_null (run, parse_highlighted_template ("abbrev", Run.Style.ITALIC));
			} else if (current.type == TokenType.XML_OPEN && current.content == "term") {
				append_inline_content_not_null (run, parse_highlighted_template ("term", Run.Style.ITALIC));
			} else if (current.type == TokenType.XML_OPEN && current.content == "literal") {
				append_inline_content_not_null (run, parse_highlighted_template ("literal", Run.Style.ITALIC));
			} else if (current.type == TokenType.XML_OPEN && current.content == "literallayout") {
				append_inline_content_not_null (run, parse_highlighted_template ("literallayout", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "application") {
				append_inline_content_not_null (run, parse_highlighted_template ("application", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "varname") {
				append_inline_content_not_null (run, parse_highlighted_template ("varname", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "computeroutput") {
				append_inline_content_not_null (run, parse_highlighted_template ("computeroutput", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "emphasis") {
				append_inline_content_not_null (run, parse_highlighted_template ("emphasis", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "pre") {
				append_inline_content_not_null (run, parse_highlighted_template ("pre", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "code") {
				append_inline_content_not_null (run, parse_highlighted_template ("code", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "guimenuitem") {
				append_inline_content_not_null (run, parse_highlighted_template ("guimenuitem", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "command") {
				append_inline_content_not_null (run, parse_highlighted_template ("command", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "option") {
				append_inline_content_not_null (run, parse_highlighted_template ("option", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "keycap") {
				append_inline_content_not_null (run, parse_highlighted_template ("keycap", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "keycombo") {
				append_inline_content_not_null (run, parse_highlighted_template ("keycombo", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "envar") {
				append_inline_content_not_null (run, parse_highlighted_template ("envar", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "filename") {
				append_inline_content_not_null (run, parse_highlighted_template ("filename", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "parameter") {
				append_inline_content_not_null (run, parse_highlighted_template ("parameter", Run.Style.MONOSPACED));
			} else if (current.type == TokenType.XML_OPEN && current.content == "replaceable") {
				append_inline_content_not_null (run, parse_highlighted_template ("replaceable", Run.Style.ITALIC));
			} else if (current.type == TokenType.XML_OPEN && current.content == "quote") {
				run.content.add (factory.create_text ("“"));
				append_inline_content_not_null (run, parse_highlighted_template ("quote", Run.Style.NONE));
				run.content.add (factory.create_text ("”"));
			} else if (current.type == TokenType.XML_OPEN && current.content == "footnote") {
				append_inline_content_not_null (run, parse_docbook_footnote ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "type") {
				append_inline_content_not_null (run, parse_symbol_link ("type"));
			} else if (current.type == TokenType.XML_OPEN && current.content == "function") {
				append_inline_content_not_null (run, parse_symbol_link ("function"));
			} else if (current.type == TokenType.XML_OPEN && current.content == "classname") {
				append_inline_content_not_null (run, parse_symbol_link ("classname"));
			} else if (current.type == TokenType.XML_OPEN && current.content == "structname") {
				append_inline_content_not_null (run, parse_symbol_link ("structname"));
			} else if (current.type == TokenType.XML_OPEN && current.content == "structfield") {
				append_inline_content_not_null (run, parse_symbol_link ("structfield"));
			} else if (current.type == TokenType.XML_OPEN && current.content == "errorcode") {
				append_inline_content_not_null (run, parse_symbol_link ("errorcode"));
			} else if (current.type == TokenType.XML_OPEN && current.content == "constant") {
				append_inline_content_not_null (run, parse_symbol_link ("constant"));
			} else if (current.type == TokenType.XML_OPEN && current.content == "inlinegraphic") {
				append_inline_content_not_null (run, parse_docbook_inlinegraphic ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "anchor") {
				parse_anchor ();
			} else if (current.type == TokenType.XML_OPEN && current.content == "link") {
				append_inline_content_not_null (run, parse_docbook_link_tempalte ("link", true));
			} else if (current.type == TokenType.XML_OPEN && current.content == "ulink") {
				append_inline_content_not_null (run, parse_docbook_link_tempalte ("ulink", false));
			} else if (current.type == TokenType.XML_OPEN && current.content == "xref") {
				append_inline_content_not_null (run, parse_xref ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "tag") {
				append_inline_content_not_null (run, parse_xml_tag ());
			} else if (current.type == TokenType.GTKDOC_FUNCTION) {
				run.content.add (this.create_type_link (current.content));
				next ();
			} else if (current.type == TokenType.GTKDOC_PARAM) {
				if (current.content == instance_param_name) {
					Content.Run keyword_run = factory.create_run (Content.Run.Style.LANG_KEYWORD);
					Content.Text text = factory.create_text ("this");
					keyword_run.content.add (text);
					run.content.add (keyword_run);
				} else {
					string? param_array_name;
					bool is_return_type_len;
					string? param_name;

					string? cname = ImporterHelper.resolve_parameter_ctype (
						this.tree,
						this.element,
						current.content,
						out param_name,
						out param_array_name,
						out is_return_type_len);

					Run current_run = factory.create_run (Run.Style.MONOSPACED);
					run.content.add (current_run);

					if (is_return_type_len) {
						Run keyword_run = factory.create_run (Run.Style.LANG_KEYWORD);
						keyword_run.content.add (factory.create_text ("return"));
						current_run.content.add (keyword_run);

						current_run.content.add (factory.create_text (".length"));
					} else if (param_array_name != null) {
						current_run.content.add (factory.create_text (param_array_name + ".length"));
					} else {
						current_run.content.add (factory.create_text (param_name));
					}

					if (cname != null) {
						run.content.add (factory.create_text ("."));

						Taglets.Link link = factory.create_taglet ("link") as Taglets.Link;
						link.symbol_name = cname;
						run.content.add (link);
					}
				}
				next ();
			} else if (current.type == TokenType.GTKDOC_SIGNAL) {
				run.content.add (this.create_type_link ("::" + current.content, true));
				next ();
			} else if (current.type == TokenType.GTKDOC_PROPERTY) {
				run.content.add (this.create_type_link (":" + current.content, true));
				next ();
			} else if (current.type == TokenType.GTKDOC_CONST) {
				run.content.add (this.create_type_link (current.content, true));
				next ();
			} else if (current.type == TokenType.GTKDOC_TYPE) {
				run.content.add (this.create_type_link (current.content, true));
				next ();
			} else if (current.type == TokenType.NEWLINE || current.type == TokenType.SPACE) {
				append_inline_content_string (run, " ");
				next ();
			} else if (current.type == TokenType.WORD) {
				append_inline_content_string (run, current.content);
				next ();
			} else if (current.type == TokenType.XML_CLOSE && ignore_current_xml_close ()) {
				next ();
			} else if (current.type == TokenType.XML_COMMENT) {
				next ();
			} else {
				break;
			}
		}

		return run;
	}



	//
	// Resource Locator:
	//

	public string resolve (string path) {
		return path;
	}
}


