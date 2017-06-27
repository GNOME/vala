/* stubrule.vala
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


public class Valadoc.StubRule : Rule {

	public StubRule () {
	}

	private Rule _rule;

	public Rule set_rule (Rule rule) {
		_rule = rule;
		return this;
	}

	public override bool is_optional () {
		return _rule.is_optional ();
	}

	public override bool starts_with_token (Token token) {
		return _rule.starts_with_token (token);
	}

	public override bool accept_token (Token token, ParserCallback parser, Rule.Forward forward)
									   throws ParserError
	{
		return _rule.accept_token (token, parser, forward);
	}

	public override bool would_accept_token (Token token, Object? state) {
		return _rule.would_accept_token (token, state);
	}

	public override bool would_reduce (Token token, Object? state) {
		return _rule.would_reduce (token, state);
	}

	public override string to_string (Object? state) {
		return _rule.to_string (state);
	}
}
