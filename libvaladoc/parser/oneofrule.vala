/* oneofrule.vala
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


internal class Valadoc.OneOfRule : Rule {

	public OneOfRule (Object[] scheme) {
		_scheme = scheme;
	}

	private Object[] _scheme;

	private class State : Object {
		public int selected = -1;
	}

	public override bool is_optional () {
		return false;
	}

	public override bool starts_with_token (Token token) {
		foreach (Object? scheme_element in _scheme) {
			if (has_start_token (scheme_element, token)) {
				return true;
			}
		}
		return false;
	}

	public override bool accept_token (Token token, ParserCallback parser, Rule.Forward forward)
									   throws ParserError
	{
		var state = parser.get_rule_state () as State;
		if (state == null) {
			state = new State ();
			parser.set_rule_state (state);
		}

		if (state.selected == -1) {
			do_start (parser);

			bool handled;
			for (int i = 0; i < _scheme.length; i++) {
				Object? scheme_element = _scheme[i];
				if (try_to_apply (scheme_element, token, parser, out handled)) {
					state.selected = i;
					return handled;
				}
			}
		} else {
			do_reduce (parser);
			return false;
		}

		parser.error (token, "unexpected token");
		assert_not_reached ();
	}

	public override bool would_accept_token (Token token, Object? state) {
		return false;
	}

	public override bool would_reduce (Token token, Object? rule_state) {
		var state = rule_state as State;
		return state.selected != -1;
	}

	public override string to_string (Object? rule_state) {
		var state = rule_state as State;
		if (state == null) {
			state = new State ();
		}
		return "%-15s%-15s(selected=%d/%d)".printf (name != null ? name : " ",
													"[one-of]",
													state.selected,
													_scheme.length);
	}
}
