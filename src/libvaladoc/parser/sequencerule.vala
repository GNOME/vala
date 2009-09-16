/* parser.vala
 *
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008-2009  Florian Brosch, Didier Villevalois
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using Gee;

internal class Valadoc.SequenceRule : Rule {

	public SequenceRule (Object[] scheme) {
		_scheme = scheme;
	}

	private Object[] _scheme;

	private class State : Object {
		public int index = 0;
	}

	public override bool is_optional () {
		return false;
	}

	public override bool starts_with_token (Token token) {
		return test_token (0, token);
	}

	private bool test_token (int from_index, Token token) {
		int i = from_index;
		while (i < _scheme.length) {
			if (has_start_token (_scheme[i], token)) {
				return true;
			}
			if (!is_optional_rule (_scheme[i])) {
				break;
			}
			i++;
		}
		return false;
	}

	private bool test_reduce (int from_index, Token token) {
		int i = from_index;
		while (i < _scheme.length) {
			if (!is_optional_rule (_scheme[i])) {
				return false;
			}
			i++;
		}
		return true;
	}

	public override bool accept_token (Token token, ParserCallback parser, Rule.Forward forward) throws ParserError {
		var state = parser.get_rule_state () as State;
		if (state == null) {
			state = new State ();
			parser.set_rule_state (state);
		}

		if (state.index == 0) {
			do_start (parser);
		} else if (state.index == _scheme.length) {
			do_reduce (parser);
			return false;
		}

		Object? scheme_element = null;
		bool handled;
		do {
			scheme_element = _scheme[state.index];
			if (try_to_apply (scheme_element, token, parser, out handled)) {
				state.index++;
				return handled;
			}
			if (!is_optional_rule (scheme_element)) {
				break;
			}
			state.index++;
		} while (state.index < _scheme.length);

		if (state.index == _scheme.length) {
			do_reduce (parser);
			return false;
		}

		if (scheme_element is TokenType) {
			parser.error ("expected %s".printf (((TokenType) scheme_element).to_pretty_string ()), token);
		} else {
			parser.error ("unexpected token", token);
		}
		assert_not_reached ();
	}

	public override bool would_accept_token (Token token, Object? rule_state) {
		var state = rule_state as State;
		return test_token (state.index, token);
	}

	public override bool would_reduce (Token token, Object? rule_state) {
		var state = rule_state as State;
		return state.index == _scheme.length || test_reduce (state.index, token);
	}

	public override string to_string (Object? rule_state) {
		var state = rule_state as State;
		if (state == null) {
			state = new State ();
		}
		return "%-15s%-15s(index=%d/%d)".printf (name != null ? name : " ", "[seq]", state.index, _scheme.length);
	}
}
