/* parser.vala
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


public errordomain Valadoc.ParserError {
	INTERNAL_ERROR,
	UNEXPECTED_TOKEN
}

public class Valadoc.Parser : ParserCallback {

	public Parser (Settings settings, Scanner scanner, ErrorReporter reporter) {
		_settings = settings;
		_scanner = scanner;
		_reporter = reporter;

		TokenType.init_token_types ();
	}

	private Settings _settings;
	private Scanner _scanner;
	private ErrorReporter _reporter;
	private Rule _root_rule;

	private string _filename;
	private int _first_line;
	private int _first_column;
	private Token _current_token;

	private Vala.ArrayList<Rule> rule_stack = new Vala.ArrayList<Rule> ();
	private Vala.ArrayList<Object?> rule_state_stack = new Vala.ArrayList<Object?> ();

	public void set_root_rule (Rule root_rule) {
		_root_rule = root_rule;
	}

	public void parse (string content, string filename, int first_line, int first_column)
					   throws ParserError
	{
		_filename = filename;
		_first_line = first_line;
		_first_column = first_column;

		rule_stack.clear ();
		rule_state_stack.clear ();

		try {
			push_rule (_root_rule);
			_scanner.reset ();
			_scanner.scan (content);
			_scanner.end ();

			if (rule_stack.size != 0) {
				error (null, "Rule stack is not empty!");
			}
		} catch (ParserError e) {
			#if DEBUG
				log_error (e.message);
			#endif
			// Set an in_error boolean, try to recover
			// And only throw the error at the end of parse ?
			throw e;
		}
	}

	public void accept_token (Token token) throws ParserError {
		#if HARD_DEBUG
			debug ("Incoming token: %s", token.to_pretty_string ());
		#endif

		_current_token = token;
		int rule_depth = rule_stack.size;
		Rule.Forward forward = Rule.Forward.NONE;
		Rule? rule = peek_rule ();
		if (rule == null) {
			throw new ParserError.INTERNAL_ERROR ("Rule stack is empty!");
		}
		while (rule != null) {
			if (rule.accept_token (token, this, forward)) {
				break;
			}

			// Check for invalid recursion
			if (rule_depth != rule_stack.size && peek_rule () == rule) {
				error (null, "Parser state error");
				break;
			}
			rule = peek_rule ();

			// Rule stack size have changed
			// Check for propagation
			forward = rule_depth > rule_stack.size ? Rule.Forward.CHILD
			                                       : Rule.Forward.PARENT;
			rule_depth = rule_stack.size;
		}
	}

	private Rule? peek_rule (int offset = -1) {
		assert (offset < 0);
		if (rule_stack.size + offset < 0) {
			return null;
		}
		return rule_stack.get (rule_stack.size + offset);
	}

	private Rule pop_rule () {
		int last_index = rule_stack.size - 1;
		Rule rule = rule_stack.get (last_index);
		rule_stack.remove_at (last_index);
		rule_state_stack.remove_at (last_index);
		return rule;
	}

	public void push_rule (Rule rule) {
		rule_stack.add (rule);
		rule_state_stack.add (null);

		#if HARD_DEBUG
			debug ("Pushed at  %2d: %s", rule_stack.size - 1, rule.to_string (null));
		#endif
	}

	private Object? peek_state (int offset = -1) {
		assert (offset < 0);
		if (rule_state_stack.size + offset < 0) {
			return null;
		}
		return rule_state_stack.get (rule_state_stack.size + offset);
	}

	public Object? get_rule_state () {
		return peek_state ();
	}

	public void set_rule_state (Object state) {
		int last_index = rule_stack.size - 1;
		rule_state_stack.set (last_index, state);
	}

	public void reduce () {
		pop_rule ();

		#if HARD_DEBUG
			Rule? parent_rule = peek_rule ();
			if (parent_rule != null) {
				debug ("Reduced to %2d: %s", rule_stack.size - 1,
					   parent_rule.to_string (peek_state ()));
			}
		#endif
	}

	public bool would_parent_accept_token (Token token) {
		int offset = -2;
		Rule? parent_rule = peek_rule (offset);
		Object? state = peek_state (offset);
		while (parent_rule != null) {
			#if VERY_HARD_DEBUG
				debug ("WouldAccept - Offset %d; Index %d: %s", offset,
					rule_stack.size + offset, parent_rule.to_string (state));
			#endif
			if (parent_rule.would_accept_token (token, state)) {
				#if VERY_HARD_DEBUG
					debug ("WouldAccept - Yes");
				#endif
				return true;
			}
			if (!parent_rule.would_reduce (token, state)) {
				#if VERY_HARD_DEBUG
					debug ("WouldAccept - No");
				#endif
				return false;
			}
			offset--;
			parent_rule = peek_rule (offset);
			state = peek_state (offset);
		}
		#if VERY_HARD_DEBUG
			debug ("WouldAccept - No");
		#endif
		return false;
	}

	public bool would_parent_reduce_to_rule (Token token, Rule rule) {
		int offset = -2;
		Rule? parent_rule = peek_rule (offset);
		Object? state = peek_state (offset);
		while (parent_rule != null) {
			#if VERY_HARD_DEBUG
				debug ("WouldReduce - Offset %d; Index %d: %s", offset,
					rule_stack.size + offset, parent_rule.to_string (state));
			#endif
			if (!parent_rule.would_reduce (token, state)) {
				break;
			}
			offset--;
			parent_rule = peek_rule (offset);
			state = peek_state (offset);
		}
		if ((parent_rule != null && parent_rule.would_accept_token (token, state))
			|| (parent_rule == null && TokenType.EOF.matches (token))) {
			#if VERY_HARD_DEBUG
				debug ("WouldReduce - Yes");
			#endif
			return true;
		}
		#if VERY_HARD_DEBUG
			debug ("WouldReduce - No");
		#endif
		return false;
	}

	public void warning (Token? token, string message) {
		string error_message;

		if (token != null) {
			error_message = message + ": " + token.to_pretty_string ();
		} else {
			error_message = message;
		}

		_reporter.warning (_filename,
		                   get_line (token),
		                   get_start_column (token),
		                   get_end_column (token),
		                   _scanner.get_line_content (),
		                   error_message);
	}

	public void error (Token? token, string message) throws ParserError {
		string error_message;

		if (token != null) {
			error_message = message + ": " + token.to_pretty_string ();
		} else {
			error_message = message;
		}

		_reporter.error (_filename,
						 get_line (token),
		                 get_start_column (token),
		                 get_end_column (token),
		                 _scanner.get_line_content (),
		                 error_message);

		throw new ParserError.UNEXPECTED_TOKEN (error_message);
	}

	private int get_line (Token? token) {
		if (token == null) {
			token = _current_token;
		}
		return token.begin.line + _first_line;
	}

	private int get_start_column (Token? token) {
		if (token == null) {
			token = _current_token;
		}
		if (token.begin.line == 0) {
			return token.begin.column + _first_column + 1;
		} else {
			return token.begin.column + 1;
		}
	}

	private int get_end_column (Token? token) {
		if (token == null) {
			token = _current_token;
		}
		if (token.end.line == 0) {
			return token.end.column + _first_column + 1;
		} else {
			return token.end.column + 1;
		}
	}

#if DEBUG
	private void log_error (string message) {
		stderr.printf ("An error occurred while parsing: %s\n", message);
		stderr.printf ("\nDumping rule stack:\n");
		for (int i = 0; i < rule_stack.size; i++) {
			stderr.printf ("\t%2d: %s\n", i, rule_stack[i].to_string (rule_state_stack[i]));
		}
	}
#endif
}
