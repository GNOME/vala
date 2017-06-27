/* optionalrule.vala
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


internal class Valadoc.OptionalRule : Rule {

	public OptionalRule (Object scheme) {
		_scheme = scheme;
	}

	private Object _scheme;

	private class State : Object {
		public bool started = false;
	}

	public override bool is_optional () {
		return true;
	}

	public override bool starts_with_token (Token token) {
		return has_start_token (_scheme, token);
	}

	public override bool accept_token (Token token, ParserCallback parser, Rule.Forward forward)
									   throws ParserError
	{
		var state = parser.get_rule_state () as State;
		if (state == null) {
			state = new State ();
			parser.set_rule_state (state);
		}

		if (!state.started) {
			do_start (parser);
			state.started = true;

			bool handled;
			if (try_to_apply (_scheme, token, parser, out handled)) {
				return handled;
			} else {
				do_skip (parser);
				return false;
			}
		} else {
			do_reduce (parser);
			return false;
		}
	}

	public override bool would_accept_token (Token token, Object? state) {
		return false;
	}

	public override bool would_reduce (Token token, Object? state) {
		return true;
	}

	public override string to_string (Object? rule_state) {
		var state = rule_state as State;
		if (state == null) {
			state = new State ();
		}
		return "%-15s%-15s(started=%s)".printf (name != null ? name : " ",
												"[option]",
												state.started.to_string ());
	}
}
