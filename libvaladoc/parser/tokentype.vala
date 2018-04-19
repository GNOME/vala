/* tokentype.vala
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


public class Valadoc.TokenType : Object {
	// valadoc-comments:
	public static TokenType ANY;
	public static TokenType ANY_WORD;
	public static TokenType ANY_NUMBER;
	public static TokenType EOF;
	public static TokenType EOL;
	public static TokenType BREAK;
 	public static TokenType AROBASE;
	public static TokenType SPACE;
	public static TokenType TAB;
	public static TokenType EQUAL_1;
	public static TokenType EQUAL_2;
	public static TokenType EQUAL_3;
	public static TokenType EQUAL_4;
	public static TokenType EQUAL_5;
	public static TokenType MINUS;
	public static TokenType LESS_THAN;
	public static TokenType GREATER_THAN;
	public static TokenType ALIGN_TOP;
	public static TokenType ALIGN_BOTTOM;
	public static TokenType SINGLE_QUOTE_2;
	public static TokenType SLASH_2;
	public static TokenType UNDERSCORE_2;
	public static TokenType BACK_QUOTE_2;
	public static TokenType OPEN_BRACE;
	public static TokenType CLOSED_BRACE;
	public static TokenType DOUBLE_OPEN_BRACE;
	public static TokenType DOUBLE_CLOSED_BRACE;
	public static TokenType TRIPLE_OPEN_BRACE;
	public static TokenType TRIPLE_CLOSED_BRACE;
	public static TokenType DOUBLE_OPEN_BRACKET;
	public static TokenType DOUBLE_CLOSED_BRACKET;
	public static TokenType PIPE;
	public static TokenType DOUBLE_PIPE;
	public static TokenType ALIGN_RIGHT;
	public static TokenType ALIGN_CENTER;


	// .valadoc (importer)
	public static TokenType VALADOC_COMMENT_START;
	public static TokenType VALADOC_COMMENT_END;
	public static TokenType VALADOC_ANY_WORD;
	public static TokenType VALADOC_SPACE;
	public static TokenType VALADOC_TAB;
	public static TokenType VALADOC_EOL;


	// markdown:
	public static TokenType MARKDOWN_PARAGRAPH;
	public static TokenType MARKDOWN_ANY_WORD;
	public static TokenType MARKDOWN_SPACE;
	public static TokenType MARKDOWN_SOURCE;
	public static TokenType MARKDOWN_PARAMETER;
	public static TokenType MARKDOWN_CONSTANT;
	public static TokenType MARKDOWN_SYMBOL;
	public static TokenType MARKDOWN_LOCAL_GMEMBER;
	public static TokenType MARKDOWN_FUNCTION;
	public static TokenType MARKDOWN_MAIL;
	public static TokenType MARKDOWN_LINK;
	public static TokenType MARKDOWN_GREATER_THAN;
	public static TokenType MARKDOWN_LESS_THAN;
	public static TokenType MARKDOWN_OPEN_BRACKET;
	public static TokenType MARKDOWN_CLOSE_BRACKET;
	public static TokenType MARKDOWN_OPEN_PARENS;
	public static TokenType MARKDOWN_CLOSE_PARENS;
	public static TokenType MARKDOWN_EXCLAMATION_MARK;
	public static TokenType MARKDOWN_HEADLINE_1;
	public static TokenType MARKDOWN_HEADLINE_2;
	public static TokenType MARKDOWN_HEADLINE_HASH;
	public static TokenType MARKDOWN_HEADLINE_END;
	public static TokenType MARKDOWN_UNORDERED_LIST_ITEM_START;
	public static TokenType MARKDOWN_UNORDERED_LIST_ITEM_END;
	public static TokenType MARKDOWN_ORDERED_LIST_ITEM_START;
	public static TokenType MARKDOWN_ORDERED_LIST_ITEM_END;
	public static TokenType MARKDOWN_BLOCK_START;
	public static TokenType MARKDOWN_BLOCK_END;
	public static TokenType MARKDOWN_EOC;


	private static bool initialized = false;

	internal static void init_token_types () {
		if (!initialized) {
			// valadoc-comments:
			ANY = new TokenType.basic ("<any>");
			ANY_WORD = new TokenType.basic ("<any-word>");
			ANY_NUMBER = new TokenType.basic ("<any-number>");
			EOF = new TokenType.basic ("\0", "<end-of-file>");
			EOL = new TokenType.basic ("\n", "<end-of-line>");
			BREAK = new TokenType.basic ("<<BR>>");
			AROBASE = new TokenType.basic ("@");
			SPACE = new TokenType.basic (" ", "<space>");
			TAB = new TokenType.basic ("\t", "<tab>");
			EQUAL_1 = new TokenType.basic ("=");
			EQUAL_2 = new TokenType.basic ("==");
			EQUAL_3 = new TokenType.basic ("====");
			EQUAL_4 = new TokenType.basic ("=====");
			EQUAL_5 = new TokenType.basic ("======");
			MINUS = new TokenType.basic ("-");
			LESS_THAN = new TokenType.basic ("<");
			GREATER_THAN = new TokenType.basic (">");
			ALIGN_TOP = new TokenType.basic ("^");
			ALIGN_BOTTOM = new TokenType.basic ("v");
			SINGLE_QUOTE_2 = new TokenType.basic ("''");
			SLASH_2 = new TokenType.basic ("""//""");
			UNDERSCORE_2 = new TokenType.basic ("__");
			BACK_QUOTE_2 = new TokenType.basic ("``");
			OPEN_BRACE = new TokenType.basic ("{");
			CLOSED_BRACE = new TokenType.basic ("}");
			DOUBLE_OPEN_BRACE = new TokenType.basic ("{{");
			DOUBLE_CLOSED_BRACE = new TokenType.basic ("}}");
			TRIPLE_OPEN_BRACE = new TokenType.basic ("{{{");
			TRIPLE_CLOSED_BRACE = new TokenType.basic ("}}}");
			DOUBLE_OPEN_BRACKET = new TokenType.basic ("[[");
			DOUBLE_CLOSED_BRACKET = new TokenType.basic ("]]");
			PIPE = new TokenType.basic ("|");
			DOUBLE_PIPE = new TokenType.basic ("||");
			ALIGN_RIGHT = new TokenType.basic ("))");
			ALIGN_CENTER = new TokenType.basic (")(");

			// .valadoc (importer)
			VALADOC_COMMENT_START = new TokenType.basic ("/*");
			VALADOC_COMMENT_END = new TokenType.basic ("*/");
			VALADOC_ANY_WORD = ANY_WORD;
			VALADOC_SPACE = SPACE;
			VALADOC_TAB = TAB;
			VALADOC_EOL = EOL;

			initialized = true;


			// Markdown: (importer)
			MARKDOWN_PARAGRAPH = new TokenType.basic ("<paragraph>");
			MARKDOWN_BLOCK_START = new TokenType.basic ("<block>");
			MARKDOWN_BLOCK_END = new TokenType.basic ("</block>");
			MARKDOWN_UNORDERED_LIST_ITEM_START = new TokenType.basic ("<unordered-list>");
			MARKDOWN_UNORDERED_LIST_ITEM_END = new TokenType.basic ("</unordered-list>");
			MARKDOWN_ORDERED_LIST_ITEM_START = new TokenType.basic ("<ordered-list>");
			MARKDOWN_ORDERED_LIST_ITEM_END  = new TokenType.basic ("</ordered-list>");

			MARKDOWN_HEADLINE_1 = new TokenType.basic ("<headline-1>");
			MARKDOWN_HEADLINE_2 = new TokenType.basic ("<headline-2>");
			MARKDOWN_HEADLINE_HASH = new TokenType.basic ("<hash>");
			MARKDOWN_HEADLINE_END = new TokenType.basic ("</headline>");
			MARKDOWN_SOURCE = new TokenType.basic ("<source>");
			MARKDOWN_PARAMETER = new TokenType.basic ("<parameter>");
			MARKDOWN_CONSTANT = new TokenType.basic ("<constant>");
			MARKDOWN_FUNCTION = new TokenType.basic ("<function>");
			MARKDOWN_SYMBOL = new TokenType.basic ("<symbol>");
			MARKDOWN_LOCAL_GMEMBER = new TokenType.basic ("<local-gmember>");
			MARKDOWN_MAIL = new TokenType.basic ("<mail>");
			MARKDOWN_LINK = new TokenType.basic ("<link>");

			MARKDOWN_OPEN_BRACKET = new TokenType.basic ("[");
			MARKDOWN_CLOSE_BRACKET = new TokenType.basic ("]");
			MARKDOWN_OPEN_PARENS = new TokenType.basic ("(");
			MARKDOWN_CLOSE_PARENS = new TokenType.basic (")");
			MARKDOWN_EXCLAMATION_MARK = new TokenType.basic ("!");
			MARKDOWN_GREATER_THAN = GREATER_THAN;
			MARKDOWN_LESS_THAN = LESS_THAN;

			MARKDOWN_ANY_WORD = ANY_WORD;
			MARKDOWN_SPACE = SPACE;
			MARKDOWN_EOC = EOL;
		}
	}

	private static int EXACT_WORD = -1;

	public static TokenType str (string str) {
		return new TokenType (str, EXACT_WORD, null);
	}

	public static TokenType any () {
		return ANY;
	}

	public static TokenType any_word () {
		return ANY_WORD;
	}

	public static TokenType any_number () {
		return ANY_NUMBER;
	}

	private TokenType (string string_value, int basic_value, Action? __action) {
		_string_value = string_value;
		_basic_value = basic_value;
		if (__action != null) {
			_action = (token) => { __action (token); };
		} else {
			_action = null;
		}
	}

	private TokenType.basic (string string_value, string? pretty_string = null) {
		_string_value = string_value;
		_pretty_string = pretty_string;
		_basic_value = ++_last_basic_value;
	}

	private static int _last_basic_value = -1;

	private string _string_value;
	private string? _pretty_string;
	private int _basic_value = -1;
	private Action? _action = null;

	public delegate void Action (Token token) throws ParserError;

	public TokenType action (Action action) {
		return new TokenType (_string_value, _basic_value, action);
	}

	public void do_action (Token matched_token) throws ParserError {
		if (_action != null) {
			_action (matched_token);
		}
	}

	public bool matches (Token token) {
		if (_basic_value == ANY._basic_value) {
			return true;
		} else if (_basic_value == ANY_WORD._basic_value && token.is_word) {
			return true;
		} else if (_basic_value == ANY_NUMBER._basic_value && token.is_number) {
			return true;
		} else if (_basic_value == EXACT_WORD && token.is_word && token.word == _string_value) {
			return true;
		} else if (token.token_type != null && token.token_type._basic_value == _basic_value) {
			return true;
		}
		return false;
	}

	public unowned string to_string () {
		return _string_value;
	}

	public unowned string to_pretty_string () {
		if (_pretty_string != null) {
			return _pretty_string;
		}
		return _string_value;
	}
}
