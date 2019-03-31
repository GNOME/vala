/* documentationparser.vala
 *
 * Copyright (C) 2008-2009 Didier Villevalois
 * Copyright (C) 2008-2012 Florian Brosch
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
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */


using Valadoc.Content;
using Valadoc.Importer;

public class Valadoc.DocumentationParser : Object, ResourceLocator {
	private Vala.HashMap<Api.SourceFile, GirMetaData> metadata;
	private Importer.InternalIdRegistrar id_registrar;


	public DocumentationParser (Settings settings, ErrorReporter reporter,
								Api.Tree tree, ModuleLoader modules)
	{
		_settings = settings;
		_reporter = reporter;
		_tree = tree;
		_modules = modules;

		_factory = new ContentFactory (_settings, this, _modules);

		_wiki_scanner = new WikiScanner (_settings);
		_wiki_parser = new Parser (_settings, _wiki_scanner, _reporter);
		_wiki_scanner.set_parser (_wiki_parser);

		_comment_scanner = new CommentScanner (_settings);
		_comment_parser = new Parser (_settings, _comment_scanner, _reporter);
		_comment_scanner.set_parser (_comment_parser);

		gtkdoc_parser = new Gtkdoc.Parser (settings, reporter, tree, modules);
		gtkdoc_markdown_parser = new Gtkdoc.MarkdownParser (settings, reporter, tree, modules);


		metadata = new Vala.HashMap<Api.SourceFile, GirMetaData> ();
		id_registrar = new Importer.InternalIdRegistrar ();

		init_valadoc_rules ();
	}

	private Gtkdoc.Parser gtkdoc_parser;
	private Gtkdoc.MarkdownParser gtkdoc_markdown_parser;

	private Settings _settings;
	private ErrorReporter _reporter;
	private Api.Tree _tree;
	private ModuleLoader _modules;

	private ContentFactory _factory;
	private WikiScanner _wiki_scanner;
	private CommentScanner _comment_scanner;
	private Parser _wiki_parser;
	private Parser _comment_parser;

	private Parser _parser;
	private Scanner _scanner;

	public Comment? parse (Api.Node element, Api.SourceComment comment) {
		if (comment is Api.GirSourceComment) {
			Api.GirSourceComment gir_comment = (Api.GirSourceComment) comment;
			GirMetaData metadata = get_metadata_for_comment (gir_comment);

			if (metadata.is_docbook) {
				Comment doc_comment = gtkdoc_parser.parse (element, gir_comment, metadata, id_registrar);
				return doc_comment;
			} else {
				Comment doc_comment = gtkdoc_markdown_parser.parse (element, gir_comment, metadata, id_registrar);
				return doc_comment;
			}
		} else {
			return parse_comment_str (element, comment.content, comment.file.get_name (),
									  comment.first_line, comment.first_column);
		}
	}

	public Comment? parse_comment_str (Api.Node element, string content, string filename,
									   int first_line, int first_column)
	{
		try {
			Comment doc_comment = parse_comment (content, filename, first_line, first_column);
			return doc_comment;
		} catch (ParserError error) {
			return null;
		}
	}

	public Page? parse_wikipage (Api.Package pkg, WikiPage page) {
		if (page.documentation != null) {
			return page.documentation;
		}

		if (page.documentation_str == null) {
			return null;
		}

		try {
			Page documentation = parse_wiki (page.documentation_str, page.get_filename ());
			return documentation;
		} catch (ParserError error) {
			return null;
		}
	}

	private Comment parse_comment (string content, string filename, int first_line, int first_column)
								   throws ParserError
	{
		_parser = _comment_parser;
		_scanner = _comment_scanner;
		_stack.clear ();
		_comment_parser.parse (content, filename, first_line, first_column);
		return (Comment) pop ();
	}

	private Page parse_wiki (string content, string filename) throws ParserError {
		_parser = _wiki_parser;
		_scanner = _wiki_scanner;
		_stack.clear ();
		_wiki_parser.parse (content, filename, 0, 0);
		return (Page) pop ();
	}

	public void check (Api.Node element, Comment comment) {
		comment.check (_tree, element, element.get_source_file ().relative_path, _reporter, _settings);
	}

	public void check_wikipage (Api.Package package, WikiPage page) {
		page.documentation.check (_tree, package, page.path, _reporter, _settings);
	}

	public void transform_inheritdoc (Api.Node taglet_owner, Taglets.InheritDoc taglet) {
		if (taglet.inherited == null) {
			return ;
		}


		taglet.inherited.parse_comments (_settings, this);
		if (taglet.inherited.documentation == null) {
			return ;
		}


		taglet.inherited.check_comments (_settings, this);

		taglet.transform (_tree, taglet_owner, taglet_owner.get_source_file ().get_name (), _reporter, _settings);
	}

	private GirMetaData get_metadata_for_comment (Api.GirSourceComment gir_comment) {
		GirMetaData metadata = metadata.get (gir_comment.file);
		if (metadata != null) {
			return metadata;
		}

		metadata = new GirMetaData (gir_comment.file.relative_path, _settings.metadata_directories, _reporter);
		if (metadata.index_sgml != null) {
			id_registrar.read_index_sgml_file (metadata.index_sgml, metadata.index_sgml_online, _reporter);
		}

		this.metadata.set (gir_comment.file, metadata);
		return metadata;
	}

	public string resolve (string path) {
		return path;
	}

	private Vala.ArrayList<Object> _stack = new Vala.ArrayList<Object> ();

	private void push (Object element) {
		_stack.add (element);
	}

	private Object peek (int offset = -1) {
		assert (_stack.size >= - offset);
		return _stack.get (_stack.size + offset);
	}

	private Object pop () {
		Object node = peek ();
		_stack.remove_at (_stack.size - 1);
		return node;
	}

	private Rule multiline_block_run;
	private Rule multiline_run;
	private int current_level = 0;
	private int[] levels = new int[0];

	private void new_list_item (Content.List.Bullet bullet) throws ParserError {
		var new_item = _factory.create_list_item ();

		Content.List list = null;
		if (levels.length >= 1) {
			if (current_level > levels[levels.length - 1]) {
				list = _factory.create_list ();
				list.bullet = bullet;

				var current_item = peek () as ListItem;
				current_item.content.add (list);
				push (list);

				levels += current_level;
			} else {
				bool poped_some_lists = false;
				while (current_level < levels[levels.length - 1]) {
					// Pop current item and list
					pop ();
					pop ();
					levels.resize (levels.length - 1);
					poped_some_lists = true;
				}
				list = peek (-2) as Content.List;

				if (!poped_some_lists && bullet == Content.List.Bullet.NONE) {
					((Paragraph) ((ListItem) peek ()).content[0]).content.add (_factory.create_text (" "));
					return;
				} else if (list.bullet != bullet) {
					_parser.error (null, "Invalid bullet type '%s': expected '%s'"
						.printf (bullet_type_string (bullet), bullet_type_string (list.bullet)));
					return;
				}

				pop ();
			}
		} else {
			list = _factory.create_list ();
			list.bullet = bullet;

			((BlockContent) peek ()).content.add (list);
			push (list);

			levels = new int[0];
			levels += current_level;
		}

		list.items.add (new_item);
		push (new_item);
	}

	private string bullet_type_string (Content.List.Bullet bullet) {
		switch (bullet) {
		case Content.List.Bullet.NONE:
			return ".";
		case Content.List.Bullet.UNORDERED:
			return "*";
		case Content.List.Bullet.ORDERED:
			return "#";
		case Content.List.Bullet.ORDERED_NUMBER:
			return "1.";
		case Content.List.Bullet.ORDERED_LOWER_CASE_ALPHA:
			return "a.";
		case Content.List.Bullet.ORDERED_UPPER_CASE_ALPHA:
			return "A.";
		case Content.List.Bullet.ORDERED_LOWER_CASE_ROMAN:
			return "i.";
		case Content.List.Bullet.ORDERED_UPPER_CASE_ROMAN:
			return "I.";
		}
		return "";
	}

	private void finish_list () {
		while (peek () is ListItem) {
			pop ();
			pop ();
			levels.resize (levels.length - 1);
		}
	}

	private void add_content_string (string str) {
		var text = peek () as Text;
		if (text == null) {
			push (text = _factory.create_text ());
		}
		text.content += str;
	}

	private void add_content_space (Token token) throws ParserError {
		// avoid double spaces
		var head = peek ();
		Text text_node = null;

		if (head is Text) {
			text_node = (Text) head;
		} else if (head is InlineContent && ((InlineContent) head).content.size > 0
			&& ((InlineContent) head).content.last () is Text)
		{
			text_node = (Text) ((InlineContent) head).content.last ();
		} else {
			text_node = _factory.create_text ();
			((InlineContent) peek ()).content.add (text_node);
		}

		if (!text_node.content.has_suffix (" ")) {
			text_node.content += " ";
		}
	}

	private void add_text (Token token) throws ParserError {
		add_content_string (token.to_string ());
	}

	private void init_valadoc_rules () {
		// Inline rules

		StubRule run = new StubRule ();
		run.set_name ("Run");

		TokenType space = TokenType.SPACE.action (add_content_space);
		TokenType word = TokenType.any_word ().action (add_text);

		Rule optional_invisible_spaces =
			Rule.option ({
				Rule.many ({ TokenType.SPACE })
			});

		Rule optional_spaces =
			Rule.option ({
				Rule.many ({
					TokenType.SPACE.action (add_content_space)
				})
			});


		Rule text =
			Rule.many ({
				Rule.one_of ({
					TokenType.BREAK.action ((token) => { add_content_string ("\n"); }),
					TokenType.CLOSED_BRACE.action (add_text),
					TokenType.MINUS.action (add_text),
					TokenType.ALIGN_BOTTOM.action (add_text),
					TokenType.ALIGN_TOP.action (add_text),
					TokenType.GREATER_THAN.action (add_text),
					TokenType.LESS_THAN.action (add_text),
					TokenType.DOUBLE_PIPE.action (add_text),
					TokenType.PIPE.action (add_text),
					TokenType.ALIGN_RIGHT.action (add_text),
					TokenType.ALIGN_CENTER.action (add_text),
					TokenType.EQUAL_1.action (add_text),
					TokenType.EQUAL_2.action (add_text),
					TokenType.EQUAL_3.action (add_text),
					TokenType.EQUAL_4.action (add_text),
					TokenType.EQUAL_5.action (add_text),
					word
				}),
				Rule.option ({ space })
			})
			.set_name ("Text")
			.set_start (() => { push (_factory.create_text ()); });

		Rule run_with_spaces =
			Rule.seq ({
				Rule.many ({
					Rule.one_of ({
						optional_invisible_spaces,
						run
					})
				})
			})
			.set_name ("RunWithSpaces");

		multiline_run = Rule.many ({
				run_with_spaces,
				TokenType.EOL.action (add_content_space)
			})
			.set_name ("MultiLineRun");

		Rule inline_taglet =
			Rule.seq ({
				TokenType.OPEN_BRACE,
				Rule.option ({
					TokenType.AROBASE,
					TokenType.any_word ().action ((token) => {
						var taglet = _factory.create_taglet (token.to_string ());
						if (!(taglet is Inline)) {
							_parser.error (null, "Invalid taglet in this context: %s".printf (token.to_string ()));
						}
						push (taglet);
						Rule? taglet_rule = taglet.get_parser_rule (multiline_run);
						if (taglet_rule != null) {
							_parser.push_rule (
								Rule.seq ({
									Rule.one_of({
										TokenType.SPACE,
										TokenType.EOL
									}),
									taglet_rule
								})
							);
						}
					}),
					TokenType.CLOSED_BRACE
				})
				.set_skip (() => { add_content_string ("{"); })
			})
			.set_name ("InlineTaglet");

		//TODO: Find a nicer way to allow empty tags (''run?'' won't work)
		Rule bold =
			Rule.seq ({
				TokenType.SINGLE_QUOTE_2,
				Rule.one_of ({
					TokenType.SINGLE_QUOTE_2,
					Rule.seq ({ optional_spaces, run, TokenType.SINGLE_QUOTE_2 })
				})
			})
			.set_name ("Bold")
			.set_start (() => { push (_factory.create_run (Run.Style.BOLD)); });

		Rule italic =
			Rule.seq ({
				TokenType.SLASH_2,
				Rule.one_of ({
					TokenType.SLASH_2,
					Rule.seq ({ optional_spaces, run, TokenType.SLASH_2 })
				})
			})
			.set_name ("Italic")
			.set_start (() => { push (_factory.create_run (Run.Style.ITALIC)); });

		Rule underlined =
			Rule.seq ({
				TokenType.UNDERSCORE_2,
				Rule.one_of ({
					TokenType.UNDERSCORE_2,
					Rule.seq ({ optional_spaces, run, TokenType.UNDERSCORE_2 })
				})
			})
			.set_name ("Underlined")
			.set_start (() => { push (_factory.create_run (Run.Style.UNDERLINED)); });

		Rule monospace =
			Rule.seq ({
				TokenType.BACK_QUOTE_2,
				Rule.one_of ({
					TokenType.BACK_QUOTE_2,
					Rule.seq ({ optional_spaces, run, TokenType.BACK_QUOTE_2 })
				})
			})
			.set_name ("Monospace")
			.set_start (() => { push (_factory.create_run (Run.Style.MONOSPACED)); });

		Rule embedded =
			Rule.seq ({
				TokenType.DOUBLE_OPEN_BRACE.action (() => { ((WikiScanner) _scanner).set_url_escape_mode (true); }),
				TokenType.any_word ().action ((token) => { ((Embedded) peek ()).url = token.to_string (); }),
				Rule.option ({
					TokenType.PIPE.action (() => { ((WikiScanner) _scanner).set_url_escape_mode (false); }),
					text
				})
				.set_reduce (() => { var caption = pop () as Text; ((Embedded) peek ()).caption = caption.content; }),
				TokenType.DOUBLE_CLOSED_BRACE.action (() => { ((WikiScanner) _scanner).set_url_escape_mode (false); })
			})
			.set_name ("Embedded")
			.set_start (() => { push (_factory.create_embedded ()); });

		Rule link =
			Rule.seq ({
				TokenType.DOUBLE_OPEN_BRACKET.action (() => { ((WikiScanner) _scanner).set_url_escape_mode (true); }),
				TokenType.any_word ().action ((token) => {
					var url = token.to_string ();
					if (url.has_suffix (".valadoc")) {
						var link = _factory.create_wiki_link ();
						link.name = url;
						push (link);
					} else {
						var link = _factory.create_link ();
						link.url = url;
						push (link);
					}
				}),
				Rule.option ({
					TokenType.PIPE.action (() => { ((WikiScanner) _scanner).set_url_escape_mode (false); }),
					run
				}),
				TokenType.DOUBLE_CLOSED_BRACKET.action (() => { ((WikiScanner) _scanner).set_url_escape_mode (false); })
			})
			.set_name ("Link");
		Rule source_code =
			Rule.seq ({
				TokenType.TRIPLE_OPEN_BRACE.action ((token) => { ((WikiScanner) _scanner).set_code_escape_mode (true); }),
				TokenType.any_word ().action ((token) => { ((SourceCode) peek ()).code = token.to_string (); }),
				TokenType.TRIPLE_CLOSED_BRACE.action ((token) => { ((WikiScanner) _scanner).set_code_escape_mode (false); })
			})
			.set_name ("SourceCode")
			.set_start (() => { push (_factory.create_source_code ()); });

		Rule.Action append_head_to_head2 = () => {
				var head = (Inline) pop ();
				((InlineContent) peek ()).content.add (head);
			};

		Rule run_subrules =
			Rule.one_of ({
				Rule.seq ({
					text
				})
				.set_reduce (append_head_to_head2),
				Rule.seq ({
					Rule.one_of ({
						inline_taglet, bold, italic, underlined, monospace, embedded, link, source_code
					})
					.set_reduce (append_head_to_head2),
					optional_spaces
				})
			});

		Rule run_arobase =
			Rule.seq ({
				TokenType.AROBASE.action (add_text)
			})
			.set_reduce (append_head_to_head2);

		run.set_rule (
			Rule.seq ({
				run_subrules,
				optional_spaces,
				Rule.option ({
					Rule.many ({
						Rule.one_of ({
							run_arobase,
							run_subrules,
							optional_spaces
						})
					})
				})
			})
			.set_name ("Run")
		);


		// Block rules

		Rule.Action reduce_paragraph = () => {
			var head = (Paragraph) pop ();
			((BlockContent) peek ()).content.add (head);

			Text last_element = head.content.last () as Text;
			if (last_element != null) {
				last_element.content._chomp ();
			}
		};

		Rule paragraph =
			Rule.seq ({
				Rule.option ({
					Rule.one_of ({
						TokenType.ALIGN_CENTER.action (() => { ((Paragraph) peek ()).horizontal_align = HorizontalAlign.CENTER; }),
						TokenType.ALIGN_RIGHT.action (() => { ((Paragraph) peek ()).horizontal_align = HorizontalAlign.RIGHT; })
					})
				}),
				Rule.many ({
					run,
					TokenType.EOL.action (add_content_space)
				})
			})
			.set_name ("Paragraph")
			.set_start (() => { push (_factory.create_paragraph ()); })
			.set_reduce (reduce_paragraph);

		Rule warning =
			Rule.seq ({
				TokenType.str ("Warning:"),
				optional_invisible_spaces,
				Rule.many ({
					Rule.seq({optional_invisible_spaces, run}),
					TokenType.EOL.action (add_content_space)
				})
			})
			.set_name ("Warning")
			.set_start (() => { push (_factory.create_paragraph ()); })
			.set_reduce (() => {
				var head = _factory.create_warning ();
				head.content.add ((Paragraph) pop ());
				((BlockContent) peek ()).content.add (head);

				Text last_element = head.content.last () as Text;
				if (last_element != null) {
					last_element.content._chomp ();
				}
			});

		Rule note =
			Rule.seq ({
				TokenType.str ("Note:"),
				optional_invisible_spaces,
				Rule.many ({
					Rule.seq({optional_invisible_spaces, run}),
					TokenType.EOL.action (add_content_space)
				})
			})
			.set_name ("Note")
			.set_start (() => { push (_factory.create_paragraph ()); })
			.set_reduce (() => {
				var head = _factory.create_note ();
				head.content.add ((Paragraph) pop ());
				((BlockContent) peek ()).content.add (head);

				Text last_element = head.content.last () as Text;
				if (last_element != null) {
					last_element.content._chomp ();
				}
			});

		Rule indented_item =
			Rule.seq ({
				Rule.many ({
					TokenType.SPACE.action ((token) => { current_level++; })
				}),
				Rule.option ({
					Rule.one_of ({
						TokenType.str (".").action ((token) => { new_list_item (Content.List.Bullet.NONE); }),
						TokenType.str ("*").action ((token) => { new_list_item (Content.List.Bullet.UNORDERED); }),
						TokenType.str ("#").action ((token) => { new_list_item (Content.List.Bullet.ORDERED); }),
						TokenType.str ("1.").action ((token) => { new_list_item (Content.List.Bullet.ORDERED_NUMBER); }),
						TokenType.str ("a.").action ((token) => { new_list_item (Content.List.Bullet.ORDERED_LOWER_CASE_ALPHA); }),
						TokenType.str ("A.").action ((token) => { new_list_item (Content.List.Bullet.ORDERED_UPPER_CASE_ALPHA); }),
						TokenType.str ("i.").action ((token) => { new_list_item (Content.List.Bullet.ORDERED_LOWER_CASE_ROMAN); }),
						TokenType.str ("I.").action ((token) => { new_list_item (Content.List.Bullet.ORDERED_UPPER_CASE_ROMAN); })
					}),
					optional_invisible_spaces
				}),
				Rule.seq ({ run })
				.set_start (() => {
					var content = _factory.create_paragraph ();
					((BlockContent) peek ()).content.add (content);
					push (content);
				})
				.set_reduce (() => { pop (); }),
				TokenType.EOL
			})
			.set_name ("IndentedItem")
			.set_start (() => { current_level = 0; })
			.set_reduce (() => {
				var content_list = ((BlockContent) peek ()).content;
				if (content_list.size > 0 && content_list.last () is Text) {
					((Text) content_list.last ()).content._chomp ();
				}
			});

		Rule indented_blocks =
			Rule.many ({
				indented_item
			})
			.set_name ("IndentedBlocks")
			.set_reduce (() => { finish_list (); });

		Rule table_cell_attributes =
			Rule.seq ({
				TokenType.LESS_THAN,
				Rule.option ({
					Rule.one_of ({
						Rule.seq ({
							Rule.option ({
								Rule.one_of ({
									TokenType.ALIGN_RIGHT.action ((token) => { ((TableCell) peek ()).horizontal_align = HorizontalAlign.RIGHT; }),
									TokenType.ALIGN_CENTER.action ((token) => { ((TableCell) peek ()).horizontal_align = HorizontalAlign.CENTER; })
								})
							}),
							Rule.option ({
								Rule.one_of ({
									TokenType.ALIGN_TOP.action ((token) => { ((TableCell) peek ()).vertical_align = VerticalAlign.TOP; }),
									TokenType.ALIGN_BOTTOM.action ((token) => { ((TableCell) peek ()).vertical_align = VerticalAlign.BOTTOM; })
								})
							})
						}),
						TokenType.any_word ().action ((token) => { ((TableCell) peek ()).style = token.to_string (); })
					})
				}),
				Rule.option ({
					Rule.one_of ({
						Rule.seq ({
							TokenType.PIPE,
							TokenType.any_number ().action ((token) => { ((TableCell) peek ()).rowspan = token.to_int (); })
						}),
						Rule.seq ({
							TokenType.MINUS,
							TokenType.any_number ().action ((token) => { ((TableCell) peek ()).colspan = token.to_int (); })
						})
					})
				}),
				TokenType.GREATER_THAN
			})
			.set_name ("CellAttributes");
		Rule table_cell =
			Rule.seq ({
				Rule.seq ({
					Rule.option ({
						table_cell_attributes
					}),
					optional_invisible_spaces,
					run
				}),
				TokenType.DOUBLE_PIPE
			})
			.set_name ("Cell")
			.set_start (() => { push (_factory.create_table_cell ()); })
			.set_reduce (() => {
				var head = (TableCell) pop ();
				((TableRow) peek ()).cells.add (head);

				if (head.content.size > 0 && head.content.last () is Text) {
					((Text) head.content.last ()).content._chomp ();
				}
			});
		Rule table_row =
			Rule.seq ({
				TokenType.DOUBLE_PIPE,
				Rule.many ({
					table_cell
				}),
				TokenType.EOL
			})
			.set_name ("Row")
			.set_start (() => { push (_factory.create_table_row ()); })
			.set_reduce (() => {
				var head = (TableRow) pop ();
				((Table) peek ()).rows.add (head);
			});
		Rule table =
			Rule.seq ({
				Rule.many ({
					table_row
				})
			})
			.set_name ("Table")
			.set_start (() => { push (_factory.create_table ()); })
			.set_reduce (() => {
				var head = (Block) pop ();
				((BlockContent) peek ()).content.add (head);
			});

		Rule headline =
			Rule.one_of ({
				Rule.seq ({
					TokenType.EQUAL_1.action ((token) => { ((Headline) peek ()).level = 1; }),
					optional_invisible_spaces,
					run,
					optional_invisible_spaces,
					TokenType.EQUAL_1,
					TokenType.EOL
				}),
				Rule.seq ({
					TokenType.EQUAL_2.action ((token) => { ((Headline) peek ()).level = 2; }),
					optional_invisible_spaces,
					run,
					optional_invisible_spaces,
					TokenType.EQUAL_2,
					TokenType.EOL
				}),
				Rule.seq ({
					TokenType.EQUAL_3.action ((token) => { ((Headline) peek ()).level = 3; }),
					optional_invisible_spaces,
					run,
					optional_invisible_spaces,
					TokenType.EQUAL_3,
					TokenType.EOL
				}),
				Rule.seq ({
					TokenType.EQUAL_4.action ((token) => { ((Headline) peek ()).level = 4; }),
					optional_invisible_spaces,
					run,
					optional_invisible_spaces,
					TokenType.EQUAL_4,
					TokenType.EOL
				}),
				Rule.seq ({
					TokenType.EQUAL_5.action ((token) => { ((Headline) peek ()).level = 5; }),
					optional_invisible_spaces,
					run,
					optional_invisible_spaces,
					TokenType.EQUAL_5,
					TokenType.EOL
				})
			})
			.set_name ("Headline")
			.set_start (() => { push (_factory.create_headline ()); })
			.set_reduce (() => {
				var head = (Block) pop ();
				((BlockContent) peek ()).content.add (head);
			});

		Rule blocks =
			Rule.one_of ({
				indented_blocks,
				table,
				headline,
				warning,
				note,
				paragraph
			})
			.set_name ("Blocks");

		Rule page =
			Rule.seq ({
				blocks,
				Rule.option ({
					Rule.many ({
						TokenType.EOL,
						Rule.option ({ blocks })
					})
				})
			})
			.set_name ("Page")
			.set_start (() => { push (_factory.create_page ()); });

		Rule description =
			Rule.seq ({
				blocks,
				Rule.option ({
					Rule.many ({
						TokenType.EOL,
						Rule.option ({ blocks })
					})
				})
			})
			.set_name ("Description");

		multiline_block_run =
			Rule.seq ({
				multiline_run
			})
			.set_start (() => { push (_factory.create_paragraph ()); })
			.set_reduce (() => {
				Paragraph p = (Paragraph) pop ();
				((BlockContent) peek ()).content.add (p);
			})
			.set_name ("BlockMultilineRun");

		Rule taglet =
			Rule.seq ({
				TokenType.AROBASE,
				TokenType.any_word ().action ((token) => {

					string tag_name = token.to_string ();
					var taglet = _factory.create_taglet (tag_name);
					if (!(taglet is Block)) {
						_parser.error (token, "Invalid taglet in this context");
					}
					push (taglet);

					Rule? taglet_rule;
					if (taglet is BlockContent) {
						taglet_rule = taglet.get_parser_rule (multiline_block_run);
					} else {
						taglet_rule = taglet.get_parser_rule (multiline_run);
					}

					if (taglet_rule != null) {
						_parser.push_rule (Rule.seq ({ TokenType.SPACE, taglet_rule }));
					}
				}),
				Rule.option ({
					Rule.many ({ TokenType.EOL })
				})
			})
			.set_name ("Taglet")
			.set_reduce (() => {
				var head = (Taglet) pop ();
				((Comment) peek ()).taglets.add (head);
			});

		Rule ml_comment =
			Rule.seq ({
				TokenType.EOL,
				Rule.option ({
					description
				}),
				Rule.option ({
					Rule.many ({ taglet })
				})
			})
			.set_name ("MultiLineComment");

		Rule sl_comment =
			Rule.seq ({
				run
			})
			.set_start (() => { push (_factory.create_paragraph ()); })
			.set_reduce (reduce_paragraph)
			.set_name ("SingleLineComment");

		Rule comment =
			Rule.one_of ({
				ml_comment,
				sl_comment
			})
			.set_name ("Comment")
			.set_start (() => { push (_factory.create_comment ()); });

		_comment_parser.set_root_rule (comment);
		_wiki_parser.set_root_rule (page);
	}

#if DEBUG
	private void dump_stack (string title) {
		message ("=== Dumping stack: %s ===", title);
		foreach (Object object in _stack) {
			message ("%s", object.get_type ().name ());
		}
	}
#endif
}
