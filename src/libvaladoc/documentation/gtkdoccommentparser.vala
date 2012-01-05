/* gtkcommentparser.vala
 *
 * Copyright (C) 2011  Florian Brosch
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
using Gee;



public class Valadoc.Gtkdoc.Parser : Object, ResourceLocator {
	private Scanner scanner = new Scanner ();
	private Token current;

	private LinkedList<string> stack = new LinkedList<string> ();
	private LinkedList<LinkedList<Block>> footnotes = new LinkedList<LinkedList<Block>> ();

	private ContentFactory factory;
	private ErrorReporter reporter;
	private Settings settings;
	private Api.Tree tree;

	private bool show_warnings;
	private Api.SourceComment comment;

	private string[]? comment_lines;

	private void reset (Api.SourceComment comment) {
		this.scanner.reset (comment.content);
		this.show_warnings = !comment.file.package.is_package || settings.verbose;
		this.comment_lines = null;
		this.footnotes.clear ();
		this.comment = comment;
		this.current = null;
		this.stack.clear ();
	}

	private inline Text? split_text (Text text) {
		int offset = 0;
		while ((offset = text.content.index_of_char ('.', offset)) >= 0) {
			if (offset >= 2) {
				// ignore "e.g."
				unowned string cmp4 = ((string) (((char*) text.content) + offset - 2));
				if (cmp4.has_prefix (" e.g.") || cmp4.has_prefix ("(e.g.")) {
					offset = offset + 3;
					continue;
				}

				// ignore "i.e."
				if (cmp4.has_prefix (" i.e.") || cmp4.has_prefix ("(i.e.")) {
					offset = offset + 3;
					continue;
				}
			}

			unowned string cmp0 = ((string) (((char*) text.content) + offset));

			// ignore ... (varargs)
			if (cmp0.has_prefix ("...")) {
				offset = offset + 3;
				continue;
			}

			Text sec = factory.create_text (text.content.substring (offset+1, -1));
			text.content = text.content.substring (0, offset+1);
			return sec;
		}

		return null;
	}

	private inline Run? split_run (Run run) {
		Run? sec = null;

		Iterator<Inline> iter = run.content.iterator ();
		for (bool has_next = iter.first (); has_next; has_next = iter.next ()) {
			Inline item = iter.get ();
			if (sec == null) {
				Inline? tmp = split_inline (item);
				if (tmp != null) {
					sec = factory.create_run (run.style);
					sec.content.add (tmp);
				}
			} else {
				sec.content.add (item);
				iter.remove ();
			}
		}

		return sec;
	}

	private inline Inline? split_inline (Inline item) {
		if (item is Text) {
			return split_text ((Text) item);
		} else if (item is Run) {
			return split_run ((Run) item);
		}

		return null;
	}

	private inline Paragraph? split_paragraph (Paragraph p) {
		Paragraph? sec = null;

		Iterator<Inline> iter = p.content.iterator ();
		for (bool has_next = iter.first (); has_next; has_next = iter.next ()) {
			Inline item = iter.get ();
			if (sec == null) {
				Inline? tmp = split_inline (item);
				if (tmp != null) {
					sec = factory.create_paragraph ();
					sec.horizontal_align = p.horizontal_align;
					sec.vertical_align = p.vertical_align;
					sec.style = p.style;
					sec.content.add (tmp);
				}
			} else {
				sec.content.add (item);
				iter.remove ();
			}
		}

		return sec;
	}

	private void extract_short_desc (Comment comment) {
		if (comment.content.size == 0) {
			return ;
		}

		Paragraph? first_paragraph = comment.content[0] as Paragraph;
		if (first_paragraph == null) {
			// add empty paragraph to avoid non-text as short descriptions
			comment.content.insert (1, factory.create_paragraph ());
			return ;
		}


		// avoid fancy stuff in short descriptions:
		first_paragraph.horizontal_align = null;
		first_paragraph.vertical_align = null;
		first_paragraph.style = null;


		Paragraph? second_paragraph = split_paragraph (first_paragraph);
		if (second_paragraph == null) {
			return ;
		}

		if (second_paragraph.is_empty () == false) {
			comment.content.insert (1, second_paragraph);
		}
	}

	private void report_unexpected_token (Token got, string expected) {
		if (this.show_warnings) {
			return ;
		}

		int startpos = (got.line == 0)? comment.first_column + got.first_column : got.first_column;
		int endpos = (got.line == 0)? comment.first_column + got.last_column : got.last_column;

		if (this.comment_lines == null) {
			this.comment_lines = this.comment.content.split ("\n");
		}

		this.reporter.warning (this.comment.file.get_name (), comment.first_line + got.line, startpos + 1, endpos + 1, this.comment_lines[got.line], "Unexpected Token: %s (Expected: %s)", got.to_string (), expected);
	}

	public Parser (Settings settings, ErrorReporter reporter, Api.Tree tree, ModuleLoader modules) {
		this.factory = new ContentFactory (settings, this, modules);
		this.reporter = reporter;
		this.settings = settings;
		this.tree = tree;
	}

	public Comment? parse (Api.Node element, Api.GirSourceComment gir_comment) {
		Comment? comment = this.parse_main_content (gir_comment);
		if (comment == null) {
			return null;
		}

		if (gir_comment.return_comment != null) {
			Taglet? taglet = this.parse_block_taglet (gir_comment.return_comment, "return");
			if (taglet == null) {
				return null;
			}

			comment.taglets.add (taglet);
		}

		MapIterator<string, Api.SourceComment> iter = gir_comment.parameter_iterator ();
		for (bool has_next = iter.first (); has_next; has_next = iter.next ()) {
			Taglets.Param? taglet = this.parse_block_taglet (iter.get_value (), "param") as Taglets.Param;
			if (taglet == null) {
				return null;
			}

			taglet.parameter_name = iter.get_key ();
			comment.taglets.add (taglet);
		}

		bool first = true;
		foreach (LinkedList<Block> note in this.footnotes) {
			if (first == true && note.size > 0) {
				Paragraph p = note.first () as Paragraph;
				if (p == null) {
					p = factory.create_paragraph ();
					comment.content.add (p);
				}

				p.content.insert (0, factory.create_text ("\n"));
			}
			comment.content.add_all (note);
			first = false;
		}

		comment.check (tree, element, reporter, settings);
		return comment;
	}

	private Taglet? parse_block_taglet (Api.SourceComment gir_comment, string taglet_name) {
		this.reset (gir_comment);
		current = null;
		next ();

		parse_docbook_spaces (false);
		var ic = parse_inline_content ();
		parse_docbook_spaces (false);

		if (current.type != TokenType.EOF) {
			this.report_unexpected_token (current, "<EOF>");
			return null;
		}

		InlineContent? taglet = factory.create_taglet (taglet_name) as InlineContent;
		assert (taglet != null);
		taglet.content.add (ic);
		return taglet as Taglet;
	}

	private Comment? parse_main_content (Api.GirSourceComment gir_comment) {
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

		extract_short_desc (comment);

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
		if (current.type == TokenType.XML_OPEN && current.content != tagname) {
			return false;
		}

		stack.offer_head (tagname);
		return true;
	}

	private bool check_xml_close_tag (string tagname) {
		if (current.type == TokenType.XML_CLOSE && current.content != tagname) {
			return false;
		}

		if (stack.poll_head () == tagname) {
			stack.peek_head ();
		}

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

	private Inline? parse_docbook_link_tempalte (string tagname) {
		if (!check_xml_open_tag (tagname)) {
			this.report_unexpected_token (current, "<%s>".printf (tagname));
			return null;
		}

		StringBuilder builder = new StringBuilder ();
		string url = current.attributes.get ("linkend");
		next ();

		// TODO: check xml
		while (!(current.type == TokenType.XML_CLOSE && current.content == tagname) && current.type != TokenType.EOF) {
			if (current.type == TokenType.XML_OPEN) {
			} else if (current.type == TokenType.XML_CLOSE) {
			} else if (current.type == TokenType.XML_COMMENT) {
			} else {
				builder.append (current.content);
			}

			next ();
		}

		var link = factory.create_link ();
		link.url = url;

		if (builder.len == 0) {
			link.content.add (factory.create_text (url));
		} else {
			link.content.add (factory.create_text (builder.str));
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

		if (current.type == TokenType.GTKDOC_FUNCTION || current.type == TokenType.GTKDOC_CONST || current.type == TokenType.GTKDOC_TYPE || current.type == TokenType.WORD || current.type == TokenType.GTKDOC_PROPERTY || current.type == TokenType.GTKDOC_SIGNAL) {
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
		next ();
		// TODO register xref

		if (!check_xml_close_tag ("anchor")) {
			this.report_unexpected_token (current, "</anchor>");
			return;
		}

		next ();
	}

	private Run? parse_xref () {
		if (!check_xml_open_tag ("xref")) {
			this.report_unexpected_token (current, "<xref>");
			return null;
		}

		string linkend = current.attributes.get ("linkend");
		next ();
		// TODO register xref

		Run run = factory.create_run (Run.Style.ITALIC);
		run.content.add (factory.create_text (linkend));

		if (!check_xml_close_tag ("xref")) {
			this.report_unexpected_token (current, "</xref>");
			return run;
		}

		next ();
		return run;
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
	
		while (current.type != TokenType.XML_CLOSE && current.type != TokenType.EOF) {
			if (current.type == TokenType.XML_OPEN && current.content == "para") {
				foreach (Block block in parse_docbook_para ()) {
					if (block is Paragraph) {
						if (item.content.size > 0) {
							item.content.add (factory.create_text ("\n"));
						}

						item.content.add_all (((Paragraph) block).content);
					} else {
						// TODO: extend me
						this.report_unexpected_token (current, "<para>|</listitem>");
						return null;
					}
				}
			} else {
				Token tmp_t = current;
				parse_inline_content ();
				if (tmp_t == current) {
					break;
				}
			}
		}

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

	private Note? parse_docbook_note () {
		return (Note?) parse_docbook_information_box_template ("note", factory.create_note ());
	}

	private Warning? parse_docbook_warning () {
		return (Warning?) parse_docbook_information_box_template ("warning", factory.create_warning ());
	}

	private Content.List? parse_docbook_itemizedlist () {
		if (!check_xml_open_tag ("itemizedlist")) {
			this.report_unexpected_token (current, "<itemizedlist>");
			return null;
		}

		next ();

		parse_docbook_spaces ();

		Content.List list = factory.create_list ();
		list.bullet = Content.List.Bullet.UNORDERED;

		while (current.type == TokenType.XML_OPEN) {
			if (current.content == "listitem") {
				list.items.add (parse_docbook_listitem ());
			} else {
				break;
			}

			parse_docbook_spaces ();
		}

		if (!check_xml_close_tag ("itemizedlist")) {
			this.report_unexpected_token (current, "</itemizedlist>");
			return list;
		}

		next ();
		return list;
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

	private LinkedList<Paragraph>? parse_docbook_para () {
		if (!check_xml_open_tag ("para")) {
			this.report_unexpected_token (current, "<para>");
			return null;
		}

		next ();

		LinkedList<Paragraph> content = new LinkedList<Paragraph> ();

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

			LinkedList<Block> lst = parse_block_content ();
			if (lst != null && run.content.size > 0) {
				content.add_all (lst);
				continue;
			}
		}

		if (!check_xml_close_tag ("para")) {
			this.report_unexpected_token (current, "</para>");
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

		for (next (); current.type != TokenType.EOF && current.type != TokenType.GTKDOC_SOURCE_CLOSE; next ()) {
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

	private Embedded? parse_docbook_inlinegraphic () {
		if (!check_xml_open_tag ("inlinegraphic")) {
			this.report_unexpected_token (current, "<inlinegraphic>");
			return null;
		}

		Embedded e = factory.create_embedded ();
		e.url = current.attributes.get ("fileref");

		next ();
		parse_docbook_spaces ();

		if (!check_xml_close_tag ("inlinegraphic")) {
			this.report_unexpected_token (current, "</inlinegrapic>");
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

		for (next (); current.type != TokenType.EOF && !(current.type == TokenType.XML_CLOSE && current.content == "programlisting"); next ()) {
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

	private LinkedList<Block>? parse_docbook_informalexample () {
		if (!check_xml_open_tag ("informalexample")) {
			this.report_unexpected_token (current, "<informalexample>");
			return null;
		}

		next ();

		parse_docbook_spaces ();

		LinkedList<Block> content = new LinkedList<Block> ();

		if (current.type == TokenType.XML_OPEN && current.content == "title") {
			append_block_content_not_null (content, parse_docbook_title ());
			parse_docbook_spaces ();
		}

		if (current.type == TokenType.XML_OPEN && current.content == "programlisting") {
			append_block_content_not_null (content, parse_docbook_programlisting ());
		} else if (current.type == TokenType.XML_OPEN && current.content == "programlisting") {
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

	private LinkedList<Block>? parse_docbook_example () {
		if (!check_xml_open_tag ("example")) {
			this.report_unexpected_token (current, "<example>");
			return null;
		}

		next ();

		parse_docbook_spaces ();

		LinkedList<Block> content = new LinkedList<Block> ();

		if (current.type == TokenType.XML_OPEN && current.content == "title") {
			append_block_content_not_null (content, parse_docbook_title ());
			parse_docbook_spaces ();
		}

		while (current.type == TokenType.XML_OPEN) {
			if (current.content == "inlinegraphic") {
				Paragraph p = factory.create_paragraph ();
				while (current.type == TokenType.XML_OPEN && current.content == "inlinegraphic") {
					p.content.add (parse_docbook_inlinegraphic ());
					next ();
					parse_docbook_spaces ();
				}
			} else if (current.content == "programlisting") {
				append_block_content_not_null (content, parse_docbook_programlisting ());
				next ();
			} else {
				break;
			}

			parse_docbook_spaces ();
		}

		if (!check_xml_close_tag ("example")) {
			this.report_unexpected_token (current, "</example>");
			return content;
		}

		next ();
		return content;
	}

	private LinkedList<Block>? parse_docbook_refsect2 () {
		if (!check_xml_open_tag ("refsect2")) {
			this.report_unexpected_token (current, "<refsect2>");
			return null;
		}

		// TODO: register id
		string id = current.attributes.get ("id");
		next ();

		parse_docbook_spaces ();

		LinkedList<Block> content = new LinkedList<Block> ();

		if (current.type == TokenType.XML_OPEN && current.content == "title") {
			append_block_content_not_null (content, parse_docbook_title ());
			parse_docbook_spaces ();
		}

		this.append_block_content_not_null_all (content, parse_block_content ());

		if (!check_xml_close_tag ("refsect2")) {
			this.report_unexpected_token (current, "</refsect2>");
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
		LinkedList<Block> content = new LinkedList<Block> ();
		this.footnotes.add (content);

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

			LinkedList<Block> lst = parse_block_content ();
			if (lst != null && run.content.size > 0) {
				content.add_all (lst);
				continue;
			}
		}

		Paragraph first = content.first () as Paragraph;
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

	private inline void append_block_content_not_null_all (LinkedList<Block> run, LinkedList<Block>? elements) {
		if (elements != null) {
			run.add_all (elements);
		}
	}

	private inline void append_block_content_not_null (LinkedList<Block> run, Block? element) {
		if (element != null) {
			run.add (element);
		}
	}

	private LinkedList<Block> parse_block_content () {
		LinkedList<Block> content = new LinkedList<Block> ();

		while (current.type != TokenType.EOF) {
			parse_docbook_spaces (false);

			if (current.type == TokenType.XML_OPEN && current.content == "itemizedlist") {
				this.append_block_content_not_null (content, parse_docbook_itemizedlist ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "programlisting") {
				this.append_block_content_not_null (content, parse_docbook_programlisting ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "para") {
				this.append_block_content_not_null_all (content, parse_docbook_para ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "informalexample") {
				this.append_block_content_not_null_all (content, parse_docbook_informalexample ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "example") {
				this.append_block_content_not_null_all (content, parse_docbook_example ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "warning") {
				this.append_block_content_not_null (content, parse_docbook_warning ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "note") {
				this.append_block_content_not_null (content, parse_docbook_note ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "refsect2") {
				this.append_block_content_not_null_all (content, parse_docbook_refsect2 ());
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

	private Inline create_type_link (string name) {
		if (name == "TRUE" || name == "FALSE" || name == "NULL") {
			var monospaced = factory.create_run (Run.Style.MONOSPACED);
			monospaced.content.add (factory.create_text (name.down ()));
			return monospaced;
		} else {
			Taglets.Link? taglet = factory.create_taglet ("link") as Taglets.Link;
			assert (taglet != null);
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
			} else if (current.type == TokenType.XML_OPEN && current.content == "term") {
				append_inline_content_not_null (run, parse_highlighted_template ("term", Run.Style.ITALIC));
			} else if (current.type == TokenType.XML_OPEN && current.content == "literal") {
				append_inline_content_not_null (run, parse_highlighted_template ("literal", Run.Style.ITALIC));
			} else if (current.type == TokenType.XML_OPEN && current.content == "application") {
				append_inline_content_not_null (run, parse_highlighted_template ("application", Run.Style.MONOSPACED));
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
			} else if (current.type == TokenType.XML_OPEN && current.content == "anchor") {
				parse_anchor ();
			} else if (current.type == TokenType.XML_OPEN && current.content == "link") {
				append_inline_content_not_null (run, parse_docbook_link_tempalte ("link"));
			} else if (current.type == TokenType.XML_OPEN && current.content == "ulink") {
				append_inline_content_not_null (run, parse_docbook_link_tempalte ("ulink"));
			} else if (current.type == TokenType.XML_OPEN && current.content == "xref") {
				append_inline_content_not_null (run, parse_xref ());
			} else if (current.type == TokenType.XML_OPEN && current.content == "tag") {
				append_inline_content_not_null (run, parse_xml_tag ());
			} else if (current.type == TokenType.GTKDOC_FUNCTION) {
				run.content.add (this.create_type_link (current.content));
				next ();
			} else if (current.type == TokenType.GTKDOC_PARAM) {
				Run current_run = factory.create_run (Run.Style.MONOSPACED);
				current_run.content.add (factory.create_text (current.content));
				run.content.add (current_run);
				next ();
			} else if (current.type == TokenType.GTKDOC_SIGNAL) {
				run.content.add (this.create_type_link ("::"+current.content));
				next ();
			} else if (current.type == TokenType.GTKDOC_PROPERTY) {
				run.content.add (this.create_type_link (":"+current.content));
				next ();
			} else if (current.type == TokenType.GTKDOC_CONST) {
				run.content.add (this.create_type_link (current.content));
				next ();
			} else if (current.type == TokenType.GTKDOC_TYPE) {
				run.content.add (this.create_type_link (current.content));
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


