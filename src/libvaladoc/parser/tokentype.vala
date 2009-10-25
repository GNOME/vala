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

	public static TokenType ANY;
	public static TokenType ANY_WORD;
	public static TokenType ANY_NUMBER;
	public static TokenType EOF;
	public static TokenType EOL;
 	public static TokenType AROBASE;
	public static TokenType SPACE;
	public static TokenType TAB;
	public static TokenType EQUAL_1;
	public static TokenType EQUAL_2;
	public static TokenType EQUAL_3;
	public static TokenType EQUAL_4;
	public static TokenType EQUAL_5;
	public static TokenType MINUS;
	public static TokenType STAR;
	public static TokenType SHARP;
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

	private static bool initialized = false;

	internal static void init_token_types () {
		if (!initialized) {
			ANY = new TokenType.basic ("<any>");
			ANY_WORD = new TokenType.basic ("<any-word>");
			ANY_NUMBER = new TokenType.basic ("<any-number>");
			EOF = new TokenType.basic ("\0", "<end-of-file>");
			EOL = new TokenType.basic ("\n", "<end-of-line>");
			AROBASE = new TokenType.basic ("@");
			SPACE = new TokenType.basic (" ", "<space>");
			TAB = new TokenType.basic ("\t", "<tab>");
			EQUAL_1 = new TokenType.basic ("=");
			EQUAL_2 = new TokenType.basic ("==");
			EQUAL_3 = new TokenType.basic ("====");
			EQUAL_4 = new TokenType.basic ("=====");
			EQUAL_5 = new TokenType.basic ("======");
			MINUS = new TokenType.basic ("-");
			STAR = new TokenType.basic ("*");
			SHARP = new TokenType.basic ("#");
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
