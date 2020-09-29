/* gtkdocmarkdownparser.vala
 *
 * Copyright (C) 2014 Florian Brosch
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
 *  Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc.Content;
using Valadoc;

public class Valadoc.Gtkdoc.MarkdownParser : Object, ResourceLocator {
	private Valadoc.Parser parser;
	private Content.ContentFactory _factory;

	private Settings _settings;
	private ErrorReporter _reporter;
	private Api.Tree _tree;

	private Vala.ArrayList<Object> _stack = new Vala.ArrayList<Object> ();

	private Valadoc.Token preserved_token = null;
	private Regex regex_source_lang;

	private Importer.InternalIdRegistrar id_registrar;
	private GirMetaData metadata;
	private Api.GirSourceComment gir_comment;
	private Api.Node element;


	public MarkdownParser (Settings settings, ErrorReporter reporter, Api.Tree? tree, ModuleLoader _modules) {
		MarkdownScanner scanner = new MarkdownScanner (settings);
		parser = new Valadoc.Parser (settings, scanner, reporter);
		scanner.set_parser (parser);


		_factory = new Content.ContentFactory (settings, this, _modules);
		_settings = settings;
		_reporter = reporter;
		_tree = tree;

		init_rules ();

		try {
			regex_source_lang = new Regex ("^<!--[ \t]+language=\"([A-Za-z]*)\"[ \t]+-->");
		} catch (Error e) {
			assert_not_reached ();
		}
	}

	public void init_rules () {
		Valadoc.TokenType word = Valadoc.TokenType.any_word ().action (add_text);

		StubRule content = new StubRule ();
		content.set_name ("Content");

		StubRule run = new StubRule ();
		run.set_name ("Run");


		Rule param = Rule.seq ({
			Valadoc.TokenType.MARKDOWN_PARAMETER.action ((token) => {
				Run _run = null;

				if (token.value == gir_comment.instance_param_name) {
					_run = _factory.create_run (Run.Style.LANG_KEYWORD);
					_run.content.add (_factory.create_text ("this"));
				} else if (is_error_parameter (token.value)) {
					_run = _factory.create_run (Run.Style.LANG_KEYWORD);
					_run.content.add (_factory.create_text ("throws"));
				} else {
					string? param_name;
					string? param_array_name;
					bool is_return_type_len;

					ImporterHelper.resolve_parameter_ctype (
						this._tree,
						this.element,
						token.value,
						out param_name,
						out param_array_name,
						out is_return_type_len);

					_run = _factory.create_run (Run.Style.MONOSPACED);

					if (is_return_type_len) {
						Run keyword_run = _factory.create_run (Run.Style.LANG_KEYWORD);
						keyword_run.content.add (_factory.create_text ("return"));
						_run.content.add (keyword_run);

						_run.content.add (_factory.create_text (".length"));
					} else if (param_array_name != null) {
						_run.content.add (_factory.create_text (param_array_name + ".length"));
					} else {
						_run.content.add (_factory.create_text (param_name));
					}


				}

				push (_run);
			})
		})
		.set_name ("Parameter");


		Rule constant = Rule.seq ({
			Valadoc.TokenType.MARKDOWN_CONSTANT.action ((token) => {
				if (is_literal (token.value)) {
					var _run = _factory.create_run (Run.Style.LANG_LITERAL);
					_run.content.add (_factory.create_text (token.value.ascii_down ()));
					push (_run);
				} else {
					add_symbol_link ("c::" + token.value, true);
				}
			})
		})
		.set_name ("Constant");


		Rule gmember = Rule.seq ({
			Valadoc.TokenType.MARKDOWN_LOCAL_GMEMBER.action ((token) => {
				Api.Item gtype = element;
				while (gtype is Api.Class == false && gtype is Api.Interface == false && gtype != null) {
					gtype = gtype.parent;
				}

				string parent_cname;
				if (gtype is Api.Class) {
					parent_cname = ((Api.Class) gtype).get_cname ();
				} else if (gtype is Api.Interface) {
					parent_cname = ((Api.Interface) gtype).get_cname ();
				} else {
					parent_cname = "";
				}

				add_symbol_link ("c::" + parent_cname + token.value, true);
			})
		})
		.set_name ("GLocalMember");


		Rule symbol = Rule.seq ({
			Valadoc.TokenType.MARKDOWN_SYMBOL.action ((token) => {
				add_symbol_link ("c::" + token.value, true);
			})
		})
		.set_name ("Symbol");


		Rule function = Rule.seq ({
			Valadoc.TokenType.MARKDOWN_FUNCTION.action ((token) => {
				add_symbol_link ("c::" + token.value, false);
			})
		})
		.set_name ("Function");


		Rule link_short = Rule.seq ({
			Valadoc.TokenType.MARKDOWN_LESS_THAN,
			Rule.option ({
				Rule.one_of ({
					Valadoc.TokenType.MARKDOWN_MAIL.action (preserve_token),
					Valadoc.TokenType.MARKDOWN_LINK.action (preserve_token)
				}),
				Rule.option ({
					Valadoc.TokenType.MARKDOWN_GREATER_THAN
				})
				.set_reduce (() => {
					Link url = _factory.create_link ();
					url.url = pop_preserved_link ();
					push (url);
				})
				.set_skip (() => {
					add_content_string ("<");
					add_value (preserved_token);
					preserved_token = null;
				})
			})
			.set_skip (() => {
				add_content_string ("<");
			})
		})
		.set_name ("Link");


		Rule link = Rule.seq ({
			Valadoc.TokenType.MARKDOWN_OPEN_BRACKET,
			Rule.option ({
				Rule.option ({
					run
				}),
				Valadoc.TokenType.MARKDOWN_CLOSE_BRACKET,
				Rule.option ({
					Rule.one_of ({
						// External link:
						Rule.seq ({
							Valadoc.TokenType.MARKDOWN_OPEN_PARENS,
							Rule.option ({
								Rule.one_of ({
									Valadoc.TokenType.MARKDOWN_LINK.action (preserve_token),
									Valadoc.TokenType.MARKDOWN_MAIL.action (preserve_token)
								}),
								Rule.option ({
									Valadoc.TokenType.MARKDOWN_CLOSE_PARENS
								})
								.set_reduce (() => {
									Link url = _factory.create_link ();
									url.url = pop_preserved_link ();

									Run label = (Run) peek ();
									url.content.add_all (label.content);
									label.content.clear ();
									label.content.add (url);
								})
								.set_skip (() => {
									Run _run = (Run) peek ();
									_run.content.insert (0, _factory.create_text ("["));
									_run.content.add (_factory.create_text ("](" + pop_preserved_link ()));
								})
							})
							.set_skip (() => {
								Run _run = (Run) peek ();
								_run.content.insert (0, _factory.create_text ("["));
								_run.content.add (_factory.create_text ("]("));
							})
						}),
						// Internal link:
						Rule.seq ({
							Valadoc.TokenType.MARKDOWN_OPEN_BRACKET,
							Rule.option ({
								Valadoc.TokenType.any_word ().action (preserve_token),
								Rule.option ({
									Valadoc.TokenType.MARKDOWN_CLOSE_BRACKET
								})
								.set_reduce (() => {
									Link url = _factory.create_link ();
									url.url = pop_preserved_link ();
									url.id_registrar = id_registrar;

									Run label = (Run) peek ();
									url.content.add_all (label.content);
									label.content.clear ();
									label.content.add (url);
								})
								.set_skip (() => {
									Run _run = (Run) peek ();
									_run.content.insert (0, _factory.create_text ("["));

									_run.content.add (_factory.create_text ("][" + pop_preserved_link ()));
								})
							})
							.set_skip (() => {
								Run _run = (Run) peek ();
								_run.content.insert (0, _factory.create_text ("["));
								_run.content.add (_factory.create_text ("]["));
							})
						})
					})
				})
				.set_skip (() => {
					Run _run = (Run) peek ();
					_run.content.insert (0, _factory.create_text ("["));
					_run.content.add (_factory.create_text ("]"));
				})
			})
			.set_skip (() => {
				Run _run = (Run) peek ();
				_run.content.insert (0, _factory.create_text ("["));
			})
		})
		.set_start (() => { push (_factory.create_run (Run.Style.NONE)); })
		.set_name ("Link");


		Rule image = Rule.seq ({
			Valadoc.TokenType.MARKDOWN_EXCLAMATION_MARK,
			Rule.option ({
				Valadoc.TokenType.MARKDOWN_OPEN_BRACKET,
				Rule.option ({
					run
				}),
				Valadoc.TokenType.MARKDOWN_CLOSE_BRACKET,
				Rule.option ({
					Valadoc.TokenType.MARKDOWN_OPEN_BRACKET,
					Rule.option ({
						Rule.one_of ({
							Valadoc.TokenType.any_word ().action (preserve_token),
							Valadoc.TokenType.MARKDOWN_LINK.action (preserve_token),
							Valadoc.TokenType.MARKDOWN_MAIL.action (preserve_token)
						}),
						Rule.option ({
							Valadoc.TokenType.MARKDOWN_CLOSE_BRACKET
						})
						.set_reduce (() => {
							Run label = (Run) peek ();

							string label_str;
							try {
								label_str = run_to_string (label, "<image>");
							} catch (Error e) {
								parser.warning (preserved_token, e.message);
								label_str = null;
							}

							Embedded embedded = _factory.create_embedded ();
							embedded.url = fix_resource_path (pop_preserved_path ());
							embedded.caption = label_str;

							label.content.clear ();
							label.content.add (embedded);
						})
						.set_skip (() => {
							Run _run = (Run) peek ();
							_run.content.insert (0, _factory.create_text ("!["));
							_run.content.add (_factory.create_text ("][" + pop_preserved_link ()));
						})
					})
					.set_skip (() => {
						Run _run = (Run) peek ();
						_run.content.insert (0, _factory.create_text ("!["));
						_run.content.add (_factory.create_text ("]["));
					})
				})
				.set_skip (() => {
					Run _run = (Run) peek ();
					_run.content.insert (0, _factory.create_text ("!["));
					_run.content.add (_factory.create_text ("]"));
				})
			})
			.set_skip (() => {
				Run _run = (Run) peek ();
				_run.content.insert (0, _factory.create_text ("!"));
			})
		})
		.set_start (() => { push (_factory.create_run (Run.Style.NONE)); })
		.set_name ("Image");


		Rule source = Rule.seq ({
			Valadoc.TokenType.MARKDOWN_SOURCE.action ((token) => {
				SourceCode code = _factory.create_source_code ();
				MatchInfo info;

				unowned string source = token.value;
				if (regex_source_lang.match (source, 0, out info)) {
					string lang_name = info.fetch (1).ascii_down ();
					SourceCode.Language? lang = SourceCode.Language.from_string (lang_name);
					code.language = lang;

					if (lang == null) {
						parser.warning (token, "Unknown language `%s' in source code block |[<!-- language=\"\"".printf (lang_name));
					}

					source = source.offset (source.index_of_char ('>') + 1);
				} else {
					code.language = (Highlighter.XmlScanner.is_xml (source))
						? SourceCode.Language.XML
						: SourceCode.Language.C;
				}

				code.code = source;
				push (code);
			})
		})
		.set_name ("Source");


		Rule text = Rule.many ({
			Rule.one_of ({
				word,
				Valadoc.TokenType.MARKDOWN_SPACE.action (add_text),
				Valadoc.TokenType.MARKDOWN_MAIL.action (add_value),
				Valadoc.TokenType.MARKDOWN_LINK.action (add_value),
				Valadoc.TokenType.MARKDOWN_OPEN_PARENS.action (add_text),
				Valadoc.TokenType.MARKDOWN_CLOSE_PARENS.action (add_text),
				Valadoc.TokenType.MARKDOWN_CLOSE_BRACKET.action (add_text),
				Valadoc.TokenType.MARKDOWN_GREATER_THAN.action (add_text)
			})
		})
		.set_start (() => { push (_factory.create_text ()); })
		.set_name ("Text");


		run.set_rule (
			Rule.many ({
				Rule.one_of ({
					text,
					link,
					link_short,
					image,
					function,
					constant,
					param,
					symbol,
					gmember,
					source
				})
				.set_reduce (() => {
					var head = (Inline) pop ();
					((InlineContent) peek ()).content.add (head);
				})
			})
		);


		Rule unordered_list = Rule.seq ({
			Rule.seq ({
				Valadoc.TokenType.MARKDOWN_UNORDERED_LIST_ITEM_START,
				content,
				Valadoc.TokenType.MARKDOWN_UNORDERED_LIST_ITEM_END
			})
			.set_start (() => { push (_factory.create_list_item ()); })
			.set_reduce (() => {
				var head = (ListItem) pop ();
				((Content.List) peek ()).items.add (head);
			})
		})
		.set_start (() => {
			var siblings = ((BlockContent) peek ()).content;
			if (siblings.size > 0 && siblings.last () is Content.List) {
				push (siblings.last ());
			} else {
				Content.List list = _factory.create_list ();
				list.bullet = Content.List.Bullet.UNORDERED;
				siblings.add (list);
				push (list);
			}
		})
		.set_reduce (() => {
			pop ();
		})
		.set_name ("UnorderedList");


		Rule ordered_list = Rule.seq ({
			Rule.seq ({
				Valadoc.TokenType.MARKDOWN_ORDERED_LIST_ITEM_START,
				content,
				Valadoc.TokenType.MARKDOWN_ORDERED_LIST_ITEM_END
			})
			.set_start (() => { push (_factory.create_list_item ()); })
			.set_reduce (() => {
				var head = (ListItem) pop ();
				((Content.List) peek ()).items.add (head);
			})
		})
		.set_start (() => {
			var siblings = ((BlockContent) peek ()).content;
			if (siblings.size > 0 && siblings.last () is Content.List) {
				push (siblings.last ());
			} else {
				Content.List list = _factory.create_list ();
				list.bullet = Content.List.Bullet.ORDERED_NUMBER;
				siblings.add (list);
				push (list);
			}
		})
		.set_reduce (() => {
			pop ();
		})
		.set_name ("OrderedList");


		Rule paragraph = Rule.seq ({
			Valadoc.TokenType.MARKDOWN_PARAGRAPH,
			Rule.option ({
				Valadoc.TokenType.MARKDOWN_SPACE
			}),
			Rule.option ({
				run
			})
		})
		.set_start (() => { push (_factory.create_paragraph ()); })
		.set_reduce (() => {
			var head = (Paragraph) pop ();
			((BlockContent) peek ()).content.add (head);
		})
		.set_name ("Paragraph");


		Rule block = Rule.seq ({
			Valadoc.TokenType.MARKDOWN_BLOCK_START,
			content,
			Valadoc.TokenType.MARKDOWN_BLOCK_END
		})
		.set_start (() => { push (_factory.create_note ()); })
		.set_reduce (() => {
			var head = (Note) pop ();
			((BlockContent) peek ()).content.add (head);
		})
		.set_name ("Block");


		Rule headline = Rule.seq ({
			Rule.one_of ({
				Valadoc.TokenType.MARKDOWN_HEADLINE_1.action ((token) => {
					Headline h = (Headline) peek ();
					h.level = 1;
				}),
				Valadoc.TokenType.MARKDOWN_HEADLINE_2.action ((token) => {
					Headline h = (Headline) peek ();
					h.level = 2;
				})
			}),
			run,
			Rule.option ({
				Valadoc.TokenType.MARKDOWN_HEADLINE_HASH.action ((token) => {
					id_registrar.register_symbol (token.value, element);
				})
			}),
			Valadoc.TokenType.MARKDOWN_HEADLINE_END
		})
		.set_start (() => { push (_factory.create_headline ()); })
		.set_reduce (() => {
			Headline h = (Headline) pop ();
			((BlockContent) peek ()).content.add (h);
		})
		.set_name ("Headline");

		content.set_rule (
			Rule.many ({
				Rule.one_of ({
					paragraph,
					unordered_list,
					ordered_list,
					headline,
					block
				})
			})
		);


		Rule comment = Rule.seq ({
			content,
			Valadoc.TokenType.MARKDOWN_EOC
		})
		.set_start (() => { push (_factory.create_comment ()); })
		.set_name ("Comment");

		parser.set_root_rule (comment);
	}

	private Comment? _parse (Api.SourceComment comment) {
		try {
			_stack.clear ();
			parser.parse (comment.content, comment.file.get_name (), comment.first_line, comment.first_column);
			return (Comment) pop ();
		} catch (ParserError e) {
			return null;
		}
	}

	private Taglet? _parse_block_taglet (Api.SourceComment comment, string taglet_name) {
		Comment? cmnt = _parse (comment);
		if (cmnt == null) {
			return null;
		}

		Taglet? taglet = _factory.create_taglet (taglet_name);
		BlockContent block = (BlockContent) taglet;
		assert (taglet != null && block != null);

		block.content.add_all (cmnt.content);

		return taglet;
	}

	private Note? _parse_note (Api.SourceComment comment) {
		Comment? cmnt = _parse (comment);
		if (cmnt == null) {
			return null;
		}

		Note note = _factory.create_note ();
		note.content.add_all (cmnt.content);

		return note;
	}

	private void add_taglet (ref Comment? comment, Taglet? taglet) {
		if (taglet == null) {
			return ;
		}

		if (comment == null) {
			comment = _factory.create_comment ();
		}

		comment.taglets.add (taglet);
	}

	private void add_note (ref Comment? comment, Note? note) {
		if (note == null) {
			return ;
		}

		if (comment == null) {
			comment = _factory.create_comment ();
		}

		if (comment.content.size == 0) {
			comment.content.add (_factory.create_paragraph ());
		}

		comment.content.insert (1, note);
	}

	public Comment? parse (Api.Node element, Api.GirSourceComment gir_comment, GirMetaData metadata, Importer.InternalIdRegistrar id_registrar, string? this_name = null) {
		this.metadata = metadata;
		this.id_registrar = id_registrar;
		this.gir_comment = gir_comment;
		this.element = element;

		// main:
		Comment? cmnt = _parse (gir_comment);
		if (cmnt != null) {
			ImporterHelper.extract_short_desc (cmnt, _factory);
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
			Taglet? taglet = _parse_block_taglet (gir_comment.return_comment, "return");
			add_taglet (ref cmnt, taglet);
		}


		// parameters:
		Vala.MapIterator<string, Api.SourceComment> iter = gir_comment.parameter_iterator ();
		for (bool has_next = iter.next (); has_next; has_next = iter.next ()) {
			Taglets.Param? taglet = _parse_block_taglet (iter.get_value (), "param") as Taglets.Param;
			string param_name = iter.get_key ();

			taglet.is_c_self_param = (param_name == gir_comment.instance_param_name);
			taglet.parameter_name = param_name;
			add_taglet (ref cmnt, taglet);
		}


		this.metadata = null;
		this.gir_comment = null;
		this.id_registrar = null;
		this.element = null;

		return cmnt;
	}


	private void add_text (Valadoc.Token token) throws ParserError {
		add_content_string (token.to_string ());
	}

	private void add_value (Valadoc.Token token) throws ParserError {
		assert (token.value != null);

		add_content_string (token.value);
	}

	private void add_content_string (string str) {
		var text = peek () as Text;
		if (text == null) {
			push (text = _factory.create_text ());
		}

		text.content += str;
	}

	private void add_symbol_link (string symbol, bool accept_plural) {
		var taglet = new Taglets.Link ();
		taglet.c_accept_plural = accept_plural;
		taglet.symbol_name = symbol;

		var run = _factory.create_run (Run.Style.NONE);
		run.content.add (taglet);

		push (run);
	}

	private void preserve_token (Valadoc.Token token) throws ParserError {
		assert (preserved_token == null);
		preserved_token = token;
	}

	private string pop_preserved_link () {
		assert (preserved_token != null);

		Valadoc.Token _link_token = (owned) preserved_token;

		// email:
		if (_link_token.token_type == Valadoc.TokenType.MARKDOWN_MAIL) {
			return "mailto:" + _link_token.value;
		}

		// http or https link:
		if (_link_token.value != null) {
			return _link_token.value;
		}

		// GTKDOC-ID:
		return _link_token.word;
	}

	private string pop_preserved_path () {
		assert (preserved_token != null);

		Valadoc.Token _path_token = (owned) preserved_token;
		return _path_token.word ?? _path_token.value;
	}

	private inline string run_to_string (Run run, string rule_name) throws Error {
		StringBuilder builder = new StringBuilder ();
		inline_to_string (run, rule_name, builder);
		return (owned) builder.str;
	}

	private void inline_to_string (Inline element, string rule_name, StringBuilder? builder) throws Error {
		if (element is Run) {
			Run run = (Run) element;

			foreach (Inline item in run.content) {
				inline_to_string (item, rule_name, builder);
			}
		} else if (element is Text) {
			Text text = (Text) element;
			builder.append (text.content);
		} else if (element is Embedded) {
			throw new ContentToStringError.UNEXPECTED_ELEMENT ("Unexpected tag: <image> in `%s'", rule_name);
		} else if (element is Link) {
			throw new ContentToStringError.UNEXPECTED_ELEMENT ("Unexpected tag: <link> in `%s'", rule_name);
		} else if (element is SourceCode) {
			throw new ContentToStringError.UNEXPECTED_ELEMENT ("Unexpected tag: `|[' in `%s'", rule_name);
		} else {
			throw new ContentToStringError.UNEXPECTED_ELEMENT ("Unexpected tag in `%s''", rule_name);
		}
	}

	private bool is_literal (string str) {
		if (str == "TRUE") {
			return true;
		}

		if (str == "FALSE") {
			return true;
		}

		if (str == "NULL") {
			return true;
		}

		if (str[0].isdigit ()) {
			return true;
		}

		return true;
	}

	private bool is_error_parameter (string name) {
		if (element == null || name != "error") {
			return false;
		}

		if (!(element is Api.Method || element is Api.Delegate)) {
			return false;
		}

		return element.get_children_by_types ({
			Api.NodeType.ERROR_DOMAIN,
			Api.NodeType.CLASS}).size > 0;
	}


	public string resolve (string path) {
		return path;
	}

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

	private inline string fix_resource_path (string path) {
		return metadata.get_resource_path (path);
	}
}


private errordomain Valadoc.Gtkdoc.ContentToStringError {
	UNEXPECTED_ELEMENT
}

