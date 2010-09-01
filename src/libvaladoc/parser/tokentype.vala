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

using Gee;

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
	public static TokenType BACK_QUOTE;
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

	// Gir, doc-nodes:
	public static TokenType GTKDOC_FUNCTION_BRACKETS;
	public static TokenType GTKDOC_XML_COMMENT_START;
	public static TokenType GTKDOC_XML_COMMENT_END;
	public static TokenType GTKDOC_PARAM;
	public static TokenType GTKDOC_SYMBOL;
	public static TokenType GTKDOC_ANY_WORD;
	public static TokenType GTKDOC_SPACE;
	public static TokenType GTKDOC_EOF;
	public static TokenType GTKDOC_EOL;
	public static TokenType GTKDOC_STRUCTNAME_ELEMENT_CLOSE;
	public static TokenType GTKDOC_STRUCTNAME_ELEMENT_OPEN;
	public static TokenType GTKDOC_LINK_ELEMENT_CLOSE;
	public static TokenType GTKDOC_LINK_ELEMENT_OPEN;
	public static TokenType GTKDOC_ITEMIZED_LIST_ELEMENT_CLOSE;
	public static TokenType GTKDOC_ITEMIZED_LIST_ELEMENT_OPEN;
	public static TokenType GTKDOC_LIST_ITEM_ELEMENT_CLOSE;
	public static TokenType GTKDOC_LIST_ITEM_ELEMENT_OPEN;
	public static TokenType GTKDOC_NOTE_ELEMENT_CLOSE;
	public static TokenType GTKDOC_NOTE_ELEMENT_OPEN;
	public static TokenType GTKDOC_PARA_ELEMENT_CLOSE;
	public static TokenType GTKDOC_PARA_ELEMENT_OPEN;
	public static TokenType GTKDOC_LITERAL_ELEMENT_CLOSE;
	public static TokenType GTKDOC_LITERAL_ELEMENT_OPEN;
	public static TokenType GTKDOC_GUI_MENU_ITEM_ELEMENT_CLOSE;
	public static TokenType GTKDOC_GUI_MENU_ITEM_ELEMENT_OPEN;
	public static TokenType GTKDOC_REPLACEABLE_ELEMENT_CLOSE;
	public static TokenType GTKDOC_REPLACEABLE_ELEMENT_OPEN;
	public static TokenType GTKDOC_WARNING_ELEMENT_CLOSE;
	public static TokenType GTKDOC_WARNING_ELEMENT_OPEN;
	public static TokenType GTKDOC_SOURCE_CLOSE;
	public static TokenType GTKDOC_SOURCE_OPEN;
	public static TokenType GTKDOC_EXAMPLE_ELEMENT_CLOSE;
	public static TokenType GTKDOC_EXAMPLE_ELEMENT_OPEN;
	public static TokenType GTKDOC_TITLE_ELEMENT_CLOSE;
	public static TokenType GTKDOC_TITLE_ELEMENT_OPEN;
	public static TokenType GTKDOC_PROGRAMLISTING_ELEMENT_CLOSE;
	public static TokenType GTKDOC_PROGRAMLISTING_ELEMENT_OPEN;
	public static TokenType GTKDOC_VARIABLE_LIST_ELEMENT_CLOSE;
	public static TokenType GTKDOC_VARIABLE_LIST_ELEMENT_OPEN;
	public static TokenType GTKDOC_VARIABLE_LIST_ENTRY_ELEMENT_CLOSE;
	public static TokenType GTKDOC_VARIABLE_LIST_ENTRY_ELEMENT_OPEN;
	public static TokenType GTKDOC_TERM_ELEMENT_CLOSE;
	public static TokenType GTKDOC_TERM_ELEMENT_OPEN;
	public static TokenType GTKDOC_ENVAR_ELEMENT_CLOSE;
	public static TokenType GTKDOC_ENVAR_ELEMENT_OPEN;
	public static TokenType GTKDOC_OPTION_ELEMENT_CLOSE;
	public static TokenType GTKDOC_OPTION_ELEMENT_OPEN;
	public static TokenType GTKDOC_EMPHASIS_ELEMENT_CLOSE;
	public static TokenType GTKDOC_EMPHASIS_ELEMENT_OPEN;
	public static TokenType GTKDOC_FILENAME_ELEMENT_CLOSE;
	public static TokenType GTKDOC_FILENAME_ELEMENT_OPEN;
	public static TokenType GTKDOC_SIMPLELIST_ELEMENT_CLOSE;
	public static TokenType GTKDOC_SIMPLELIST_ELEMENT_OPEN;
	public static TokenType GTKDOC_MEMBER_ELEMENT_CLOSE;
	public static TokenType GTKDOC_MEMBER_ELEMENT_OPEN;
	public static TokenType GTKDOC_DOT;

	// .valadoc
	public static TokenType VALADOC_COMMENT_START;
	public static TokenType VALADOC_COMMENT_END;
	public static TokenType VALADOC_ANY_WORD;
	public static TokenType VALADOC_SPACE;
	public static TokenType VALADOC_TAB;
	public static TokenType VALADOC_EOL;

	private static bool initialized = false;

	internal static void init_token_types () {
		if (!initialized) {
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
			SLASH_2 = new TokenType.basic ("//");
			UNDERSCORE_2 = new TokenType.basic ("__");
			BACK_QUOTE = new TokenType.basic ("`");
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

			GTKDOC_FUNCTION_BRACKETS = new TokenType.basic ("()");
			GTKDOC_XML_COMMENT_START = new TokenType.basic ("<!--");
			GTKDOC_XML_COMMENT_END = new TokenType.basic ("-->");
			GTKDOC_PARAM = new TokenType.basic ("<c-parameter>");
			GTKDOC_SYMBOL = new TokenType.basic ("<symbol>");
			GTKDOC_STRUCTNAME_ELEMENT_CLOSE = new TokenType.basic ("</structname>");
			GTKDOC_STRUCTNAME_ELEMENT_OPEN = new TokenType.basic ("<structname>");
			GTKDOC_LINK_ELEMENT_CLOSE = new TokenType.basic ("</link>");
			GTKDOC_LINK_ELEMENT_OPEN = new TokenType.basic ("<link>");
			GTKDOC_ITEMIZED_LIST_ELEMENT_CLOSE = new TokenType.basic ("</itemizedlist>");
			GTKDOC_ITEMIZED_LIST_ELEMENT_OPEN = new TokenType.basic ("<itemizedlist>");
			GTKDOC_LIST_ITEM_ELEMENT_CLOSE = new TokenType.basic ("</listitem>");
			GTKDOC_LIST_ITEM_ELEMENT_OPEN = new TokenType.basic ("<listitem>");
			GTKDOC_NOTE_ELEMENT_CLOSE = new TokenType.basic ("</note>");
			GTKDOC_NOTE_ELEMENT_OPEN = new TokenType.basic ("<note>");
			GTKDOC_PARA_ELEMENT_CLOSE = new TokenType.basic ("</para>");
			GTKDOC_PARA_ELEMENT_OPEN = new TokenType.basic ("<para>");
			GTKDOC_LITERAL_ELEMENT_CLOSE = new TokenType.basic ("</literal>");
			GTKDOC_LITERAL_ELEMENT_OPEN = new TokenType.basic ("<literal>");
			GTKDOC_GUI_MENU_ITEM_ELEMENT_CLOSE = new TokenType.basic ("</guimenuitem>");
			GTKDOC_GUI_MENU_ITEM_ELEMENT_OPEN = new TokenType.basic ("<guimenuitem>");
			GTKDOC_REPLACEABLE_ELEMENT_CLOSE = new TokenType.basic ("</replaceable>");
			GTKDOC_REPLACEABLE_ELEMENT_OPEN = new TokenType.basic ("<replaceable>");
			GTKDOC_WARNING_ELEMENT_CLOSE = new TokenType.basic ("</warning>");
			GTKDOC_WARNING_ELEMENT_OPEN = new TokenType.basic ("<warning>");
			GTKDOC_SOURCE_CLOSE = new TokenType.basic ("|]");
			GTKDOC_SOURCE_OPEN = new TokenType.basic ("[|");
			GTKDOC_EXAMPLE_ELEMENT_CLOSE = new TokenType.basic ("</example>");
			GTKDOC_EXAMPLE_ELEMENT_OPEN = new TokenType.basic ("<example>");
			GTKDOC_TITLE_ELEMENT_CLOSE = new TokenType.basic ("</title>");
			GTKDOC_TITLE_ELEMENT_OPEN = new TokenType.basic ("<title>");
			GTKDOC_PROGRAMLISTING_ELEMENT_CLOSE = new TokenType.basic ("</programlisting>");
			GTKDOC_PROGRAMLISTING_ELEMENT_OPEN = new TokenType.basic ("<programlisting>");
			GTKDOC_VARIABLE_LIST_ELEMENT_CLOSE = new TokenType.basic ("</variablelist>");
			GTKDOC_VARIABLE_LIST_ELEMENT_OPEN = new TokenType.basic ("<variablelist>");
			GTKDOC_VARIABLE_LIST_ENTRY_ELEMENT_CLOSE = new TokenType.basic ("</varlistentry>");
			GTKDOC_VARIABLE_LIST_ENTRY_ELEMENT_OPEN = new TokenType.basic ("<varlistentry>");
			GTKDOC_TERM_ELEMENT_CLOSE = new TokenType.basic ("</term>");
			GTKDOC_TERM_ELEMENT_OPEN = new TokenType.basic ("<term>");
			GTKDOC_ENVAR_ELEMENT_CLOSE = new TokenType.basic ("</envar>");
			GTKDOC_ENVAR_ELEMENT_OPEN = new TokenType.basic ("<envar>");
			GTKDOC_OPTION_ELEMENT_CLOSE = new TokenType.basic ("</option>");
			GTKDOC_OPTION_ELEMENT_OPEN = new TokenType.basic ("<option>");
			GTKDOC_EMPHASIS_ELEMENT_CLOSE = new TokenType.basic ("</emphasis>");
			GTKDOC_EMPHASIS_ELEMENT_OPEN = new TokenType.basic ("<emphasis>");
			GTKDOC_FILENAME_ELEMENT_CLOSE = new TokenType.basic ("</filename>");
			GTKDOC_FILENAME_ELEMENT_OPEN = new TokenType.basic ("<filename>");
			GTKDOC_SIMPLELIST_ELEMENT_CLOSE = new TokenType.basic ("</simplelist>");
			GTKDOC_SIMPLELIST_ELEMENT_OPEN = new TokenType.basic ("<simplelist>");
			GTKDOC_MEMBER_ELEMENT_CLOSE = new TokenType.basic ("</member>");
			GTKDOC_MEMBER_ELEMENT_OPEN = new TokenType.basic ("<member>");
			GTKDOC_DOT = new TokenType.basic (".");
			GTKDOC_ANY_WORD = ANY_WORD;
			GTKDOC_EOL = TokenType.EOL;
			GTKDOC_SPACE = SPACE;
			GTKDOC_EOF = EOF;

			VALADOC_COMMENT_START = new TokenType.basic ("/*");
			VALADOC_COMMENT_END = new TokenType.basic ("*/");
			VALADOC_ANY_WORD = ANY_WORD;
			VALADOC_SPACE = SPACE;
			VALADOC_TAB = TAB;
			VALADOC_EOL = EOL;


			initialized = true;
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

	private TokenType (string string_value, int basic_value, Action? action) {
		_string_value = string_value;
		_basic_value = basic_value;
		_action = action;
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

	public string to_string () {
		return _string_value;
	}

	public string to_pretty_string () {
		if (_pretty_string != null) {
			return _pretty_string;
		}
		return _string_value;
	}
}
