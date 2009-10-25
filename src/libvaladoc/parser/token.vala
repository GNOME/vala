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

using Gee;

public class Valadoc.Token : Object {

	public Token.from_type (TokenType type, SourceLocation begin, SourceLocation end) {
		_type = type;
		_begin = begin;
		_end = end;
	}

	public Token.from_word (string word, SourceLocation begin, SourceLocation end) {
		_word = word;
		_begin = begin;
		_end = end;
	}

	private TokenType? _type = null;
	private string? _word = null;
	private SourceLocation _begin;
	private SourceLocation _end;

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

	public TokenType? token_type {
		get {
			return _type;
		}
	}

	public SourceLocation begin {
		get {
			return _begin;
		}
	}

	public SourceLocation end {
		get {
			return _end;
		}
	}

	public string to_string () {
		return _word == null ? _type.to_string () : _word;
	}

	public string to_pretty_string () {
		return _word == null ? _type.to_pretty_string () : _word;
	}

	public int to_int () {
		assert (is_number);
		return _word.to_int ();
	}
}
