/* token.vala
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


public class Valadoc.Token : Object {

	public Token.from_type (TokenType type, Vala.SourceLocation begin, Vala.SourceLocation end, string? val = null) {
		_type = type;
		_begin = begin;
		_end = end;
		_value = val;
	}

	public Token.from_word (string word, Vala.SourceLocation begin, Vala.SourceLocation end) {
		_word = word;
		_begin = begin;
		_end = end;
	}

	private TokenType? _type = null;
	private string? _word = null;
	private Vala.SourceLocation _begin;
	private Vala.SourceLocation _end;
	private string? _value;

	public bool is_word {
		get {
			return _word != null;
		}
	}

	public bool is_number {
		get {
			if (_word == null || _word.length == 0) {
				return false;
			} else if (_word[0] == '0' && _word.length > 1) {
				return false;
			}
			for (int i = 0; i < _word.length; i++) {
				if (_word[i] < '0' || _word[i] > '9') {
					return false;
				}
			}
			return true;
		}
	}

	public string? word {
		get {
			return _word;
		}
	}

	public string? value {
		get {
			return _value;
		}
	}

	public TokenType? token_type {
		get {
			return _type;
		}
	}

	public Vala.SourceLocation begin {
		get {
			return _begin;
		}
	}

	public Vala.SourceLocation end {
		get {
			return _end;
		}
	}

	public unowned string to_string () {
		return _word == null ? _type.to_string () : _word;
	}

	public unowned string to_pretty_string () {
		return _word == null ? _type.to_pretty_string () : _word;
	}

	public int to_int () {
		assert (is_number);
		return int.parse (_word);
	}
}
