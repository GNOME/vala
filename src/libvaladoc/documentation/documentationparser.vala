/* documentationparser.vala
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
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using Valadoc.Content;
using Gee;


public class Valadoc.DocumentationParser : Object, ResourceLocator {

	public DocumentationParser (Settings settings, ErrorReporter reporter, Api.Tree tree, ModuleLoader modules) {
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

		init_rules ();
	}

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
	private WikiScanner _scanner;

	public Comment? parse (Api.Node element, Vala.Comment source_comment) {
		weak string content = source_comment.content;
		var source_ref = source_comment.source_reference;
		try {
			Comment doc_comment = parse_comment (content, source_ref.file.filename, source_ref.first_line, source_ref.first_column);
			doc_comment.check (_tree, element, _reporter);
			return doc_comment;
		} catch (ParserError error) {
			return null;
		}
	}

	public Page? parse_wikipage (WikiPage page) {
		if (page.documentation != null) {
			return page.documentation;
		}

		if (page.documentation_str == null) {
			return null;
		}

		try {
			Page documentation = parse_wiki (page.documentation_str, page.get_filename ());
			documentation.check (_tree, null, _reporter);
			return documentation;
		} catch (ParserError error) {
			return null;
		}
	}

	private Comment parse_comment (string content, string filename, int first_line, int first_column) throws ParserError {
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

	public string resolve (string path) {
		return path;
	}

	private ArrayList<Object> _stack = new ArrayList<Object> ();

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
				current_item.sub_list = list;
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
					((InlineContent) peek ()).content.add (_factory.create_text (" "));
					return;
				} else if (list.bullet != bullet) {
					_parser.error ("Invalid bullet type '%s': expected '%s'".printf (bullet_type_string (bullet), bullet_type_string (list.bullet)));
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

	private void init_rules () {
		// Inline rules

		StubRule run = new StubRule ();
		run.set_name ("Run");

		TokenType.Action add_text = (token) => {
			add_content_string (token.to_string ());
		};

		TokenType word = TokenType.any_word ().action (add_text);
		TokenType space = TokenType.SPACE.action (add_text);

		Rule text =
			Rule.seq ({
				word,
				Rule.option ({ space }),
				Rule.option ({
					Rule.many ({
						Rule.one_of ({
							word,
							TokenType.BREAK.action ((token) => { add_content_string ("\n"); }),
							TokenType.MINUS.action (add_text),
							TokenType.EQUAL_1.action (add_text),
							TokenType.EQUAL_2.action (add_text),
							TokenType.PIPE.action (add_text),
							TokenType.DOUBLE_PIPE.action (add_text),
							TokenType.ALIGN_TOP.action (add_text),
							TokenType.LESS_THAN.action (add_text),
							TokenType.GREATER_THAN.action (add_text),
							TokenType.ALIGN_RIGHT.action (add_text),
							TokenType.ALIGN_CENTER.action (add_text)
						}),
						Rule.option ({ space })
					})
				})
			})
			.set_name ("Text")
			.set_start (() => { push (_factory.create_text ()); });

		Rule run_with_spaces =
			Rule.seq ({
				Rule.many ({
					Rule.option ({
						Rule.many ({ TokenType.SPACE })
					}),
					run
				})
			})
			.set_name ("RunWithSpaces");

		multiline_run = Rule.many ({
				run_with_spaces,
				TokenType.EOL.action (() => { ((InlineContent) peek ()).content.add (_factory.create_text (" ")); })
			})
			.set_name ("MultiLineRun");

		Rule inline_taglet =
			Rule.seq ({
				TokenType.OPEN_BRACE,
				TokenType.AROBASE,
				TokenType.any_word ().action ((token) => {
					var taglet = _factory.create_taglet (token.to_string ());
					if (!(taglet is Inline)) {
						_parser.error ("Invalid taglet in this context: %s".printf (token.to_string ()));
					}
					push (taglet);
					Rule? taglet_rule = taglet.get_parser_rule (multiline_run);
					if (taglet_rule != null) {
						_parser.push_rule (Rule.seq ({ TokenType.SPACE, taglet_rule }));
					}
				}),
				TokenType.CLOSED_BRACE
			})
			.set_name ("InlineTaglet");

		Rule bold =
			Rule.seq ({ TokenType.SINGLE_QUOTE_2, run, TokenType.SINGLE_QUOTE_2 })
				.set_name ("Bold")
				.set_start (() => { push (_factory.create_run (Run.Style.BOLD)); });
		Rule italic =
			Rule.seq ({ TokenType.SLASH_2, run, TokenType.SLASH_2 })
				.set_name ("Italic")
				.set_start (() => { push (_factory.create_run (Run.Style.ITALIC)); });
		Rule underlined =
			Rule.seq ({ TokenType.UNDERSCORE_2, run, TokenType.UNDERSCORE_2 })
				.set_name ("Underlined")
				.set_start (() => { push (_factory.create_run (Run.Style.UNDERLINED)); });
		Rule monospace =
			Rule.seq ({ TokenType.BACK_QUOTE, run, TokenType.BACK_QUOTE })
				.set_name ("Monospace")
				.set_start (() => { push (_factory.create_run (Run.Style.MONOSPACED)); });

		Rule embedded =
			Rule.seq ({
				TokenType.DOUBLE_OPEN_BRACE.action (() => { _scanner.set_url_escape_mode (true); }),
				TokenType.any_word ().action ((token) => { ((Embedded) peek ()).url = token.to_string (); }),
				Rule.option ({
					TokenType.PIPE.action (() => { _scanner.set_url_escape_mode (false); }),
					text
				})
				.set_reduce (() => { var caption = pop () as Text; ((Embedded) peek ()).caption = caption.content; }),
				TokenType.DOUBLE_CLOSED_BRACE.action (() => { _scanner.set_url_escape_mode (false); })
			})
			.set_name ("Embedded")
			.set_start (() => { push (_factory.create_embedded ()); });
		Rule link =
			Rule.seq ({
				TokenType.DOUBLE_OPEN_BRACKET.action (() => { _scanner.set_url_escape_mode (true); }),
				TokenType.any_word ().action ((token) => { ((Link) peek ()).url = token.to_string (); }),
				Rule.option ({
					TokenType.PIPE.action (() => { _scanner.set_url_escape_mode (false); }),
					run
				}),
				TokenType.DOUBLE_CLOSED_BRACKET.action (() => { _scanner.set_url_escape_mode (false); })
			})
			.set_name ("Link")
			.set_start (() => { push (_factory.create_link ()); });

		Rule source_code =
			Rule.seq ({
				TokenType.TRIPLE_OPEN_BRACE.action ((token) => { _scanner.set_code_escape_mode (true); }),
				TokenType.any_word ().action ((token) => { ((SourceCode) peek ()).code = token.to_string (); }),
				TokenType.TRIPLE_CLOSED_BRACE.action ((token) => { _scanner.set_code_escape_mode (false); })
			})
			.set_name ("SourceCode")
			.set_start (() => { push (_factory.create_source_code ()); });

		run.set_rule (
			Rule.many ({
				Rule.one_of ({
					text, inline_taglet, bold, italic, underlined, monospace, embedded, link, source_code
				})
				.set_reduce (() => { ((InlineContent) peek ()).content.add ((Inline) pop ()); }),
				Rule.option ({ space })
				.set_reduce (() => { ((InlineContent) peek ()).content.add ((Inline) pop ()); })
			})
			.set_name ("Run")
		);

		// Block rules

		Rule paragraph =
			Rule.seq ({
				Rule.option ({
					Rule.one_of ({
						TokenType.ALIGN_CENTER.action (() => { ((Paragraph) peek ()).horizontal_align = HorizontalAlign.RIGHT; }),
						TokenType.ALIGN_RIGHT.action (() => { ((Paragraph) peek ()).horizontal_align = HorizontalAlign.RIGHT; })
					})
				}),
				Rule.many ({
					run,
					TokenType.EOL.action (() => { ((Paragraph) peek ()).content.add (_factory.create_text (" ")); })
				})
			})
			.set_name ("Paragraph")
			.set_start (() => { push (_factory.create_paragraph ()); })
			.set_reduce (() => { ((BlockContent) peek ()).content.add ((Block) pop ()); });

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
					TokenType.SPACE
				})
				.set_skip (() => { new_list_item (Content.List.Bullet.NONE); }),
				run,
				TokenType.EOL
			})
			.set_name ("IndentedItem")
			.set_start (() => { current_level = 0; });

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
							TokenType.any_number ().action ((token) => { ((TableCell) peek ()).colspan = token.to_int (); })
						}),
						Rule.seq ({
							TokenType.MINUS,
							TokenType.any_number ().action ((token) => { ((TableCell) peek ()).rowspan = token.to_int (); })
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
					run_with_spaces,
					Rule.option ({
						Rule.many ({ TokenType.SPACE })
					})
				}),
				TokenType.DOUBLE_PIPE
			})
			.set_name ("Cell")
			.set_start (() => { push (_factory.create_table_cell ()); })
			.set_reduce (() => { ((TableRow) peek ()).cells.add ((TableCell) pop ()); });
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
			.set_reduce (() => { ((Table) peek ()).rows.add ((TableRow) pop ()); });
		Rule table =
			Rule.seq ({
				Rule.many ({
					table_row
				})
			})
			.set_name ("Table")
			.set_start (() => { push (_factory.create_table ()); })
			.set_reduce (() => { ((BlockContent) peek ()).content.add ((Block) pop ()); });

		Rule headline =
			Rule.one_of ({
				Rule.seq ({
					TokenType.EQUAL_1.action ((token) => { ((Headline) peek ()).level = 1; }),
					run,
					TokenType.EQUAL_1,
					TokenType.EOL
				}),
				Rule.seq ({
					TokenType.EQUAL_2.action ((token) => { ((Headline) peek ()).level = 2; }),
					run,
					TokenType.EQUAL_2,
					TokenType.EOL
				}),
				Rule.seq ({
					TokenType.EQUAL_3.action ((token) => { ((Headline) peek ()).level = 3; }),
					run,
					TokenType.EQUAL_3,
					TokenType.EOL
				}),
				Rule.seq ({
					TokenType.EQUAL_4.action ((token) => { ((Headline) peek ()).level = 4; }),
					run,
					TokenType.EQUAL_4,
					TokenType.EOL
				}),
				Rule.seq ({
					TokenType.EQUAL_5.action ((token) => { ((Headline) peek ()).level = 5; }),
					run,
					TokenType.EQUAL_5,
					TokenType.EOL
				})
			})
			.set_name ("Headline")
			.set_start (() => { push (_factory.create_headline ()); })
			.set_reduce (() => { ((BlockContent) peek ()).content.add ((Block) pop ()); });

		Rule blocks =
			Rule.one_of ({
				indented_blocks,
				table,
				headline,
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

		Rule taglet =
			Rule.seq ({
				TokenType.AROBASE,
				TokenType.any_word ().action ((token) => {
					var taglet = _factory.create_taglet (token.to_string ());
					if (!(taglet is Block)) {
						_parser.error ("Invalid taglet in this context", token);
					}
					push (taglet);
					Rule? taglet_rule = taglet.get_parser_rule (multiline_run);
					if (taglet_rule != null) {
						_parser.push_rule (Rule.seq ({ TokenType.SPACE, taglet_rule }));
					}
				}),
				Rule.option ({
					Rule.many ({ TokenType.EOL })
				})
			})
			.set_name ("Taglet")
			.set_reduce (() => { ((Comment) peek ()).taglets.add ((Taglet) pop ()); });

		Rule comment =
			Rule.seq ({
				TokenType.EOL,
				description,
				Rule.option ({
					Rule.many ({ taglet })
				})
			})
			.set_name ("Comment")
			.set_start (() => { push (_factory.create_comment ()); });

		_comment_parser.set_root_rule (comment);
		_wiki_parser.set_root_rule (page);
	}

	private void dump_stack () {
		message ("Dumping stack");
		foreach (Object object in _stack) {
			message ("%s", object.get_type ().name ());
		}
	}
}
