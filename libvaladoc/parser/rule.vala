/* rule.vala
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


public abstract class Valadoc.Rule : Object {

	public static Rule seq (Object[] scheme) {
		return new SequenceRule (scheme);
	}

	public static Rule one_of (Object[] scheme) {
		return new OneOfRule (scheme);
	}

	public static Rule many (Object[] scheme) {
		if (scheme.length == 1) {
			return new ManyRule (scheme[0]);
		} else {
			return new ManyRule (new SequenceRule (scheme));
		}
	}

	public static Rule option (Object[] scheme) {
		if (scheme.length == 1) {
			return new OptionalRule (scheme[0]);
		} else {
			return new OptionalRule (new SequenceRule (scheme));
		}
	}

	protected Rule () {
	}

	private string? _name = null;
	private Action _start_action;
	private Action _reduce_action;
	private Action _skip_action;

	public string name { get { return _name; } }

	public Rule set_name (string name) {
		_name = name;
		return this;
	}

	public delegate void Action () throws ParserError;

	public Rule set_start (Action action) {
		//TODO: Ownership Transfer
		_start_action = () => { action (); };
		return this;
	}

	public Rule set_reduce (Action action) {
		//TODO: Ownership Transfer
		_reduce_action = () => { action (); };
		return this;
	}

	public Rule set_skip (Action action) {
		//TODO: Ownership Transfer
		_skip_action = () => { action (); };
		return this;
	}

	public enum Forward {
		NONE,
		PARENT,
		CHILD
	}

	public abstract bool is_optional ();
	public abstract bool starts_with_token (Token token);
	public abstract bool accept_token (Token token, ParserCallback parser, Rule.Forward forward) throws ParserError;
	public abstract bool would_accept_token (Token token, Object? state);
	public abstract bool would_reduce (Token token, Object? state);

	public abstract string to_string (Object? state);

	protected bool is_optional_rule (Object? scheme_element) {
		Rule? scheme_rule = scheme_element as Rule;
		if (scheme_rule != null) {
			return scheme_rule.is_optional ();
		}
		return false;
	}

	protected bool has_start_token (Object? scheme_element, Token token) {
		TokenType? scheme_token_type = scheme_element as TokenType;
		if (scheme_token_type != null) {
			return scheme_token_type.matches (token);
		}
		Rule? scheme_rule = scheme_element as Rule;
		if (scheme_rule != null) {
			return scheme_rule.starts_with_token (token);
		}
		return false;
	}

	protected bool try_to_apply (Object? scheme_element, Token token, ParserCallback parser,
								 out bool handled) throws ParserError
	{
		#if VERY_HARD_DEBUG
			{
				TokenType? scheme_token = scheme_element as TokenType;
				Rule? scheme_rule = scheme_element as Rule;
				if (scheme_token != null) {
					message ("TryToApply: token='%s'; scheme_token='%s'", token.to_string (),
						scheme_token.to_string ());
				} else if (scheme_rule != null) {
					message ("TryToApply: token='%s'; scheme_rule='%s'", token.to_string (),
						scheme_rule.to_string (parser.get_rule_state ()));
				} else {
					assert (scheme_element != null);
				}
			}
		#endif
		TokenType? scheme_token_type = scheme_element as TokenType;
		if (scheme_token_type != null && scheme_token_type.matches (token)) {
			scheme_token_type.do_action (token);
			handled = true;
			return true;
		}
		Rule? scheme_rule = scheme_element as Rule;
		if (scheme_rule != null && scheme_rule.starts_with_token (token)) {
			parser.push_rule (scheme_rule);
			handled = false;
			return true;
		}

		handled = false;
		return false;
	}

	protected void do_start (ParserCallback parser) throws ParserError {
		if (_start_action != null) {
			_start_action ();
		}
	}

	protected void do_reduce (ParserCallback parser) throws ParserError {
		if (_reduce_action != null) {
			_reduce_action ();
		}
		parser.reduce ();
	}

	protected void do_skip (ParserCallback parser) throws ParserError {
		if (_skip_action != null) {
			_skip_action ();
		}
	}
}
