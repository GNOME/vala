/* valaparser.vala
 *
 * Copyright (C) 2006-2013  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Code visitor parsing all Vala source files.
 */
public class Vala.Parser : CodeVisitor {
	Scanner scanner;

	CodeContext context;

	// token buffer
	TokenInfo[] tokens;
	// index of current token in buffer
	int index;
	// number of tokens in buffer
	int size;

	Comment comment;

	const int BUFFER_SIZE = 32;

	static List<TypeParameter> _empty_type_parameter_list;
	static int next_local_func_id = 0;

	PartialInfo[] partials;

	struct TokenInfo {
		public TokenType type;
		public SourceLocation begin;
		public SourceLocation end;
	}

	struct PartialInfo {
		public Symbol parent;
		public SourceLocation begin;
		public List<Attribute>? attributes;
	}

	[Flags]
	enum ModifierFlags {
		NONE = 0,
		ABSTRACT,
		CLASS,
		EXTERN,
		INLINE,
		NEW,
		OVERRIDE,
		STATIC,
		VIRTUAL,
		ASYNC,
		SEALED,
		PARTIAL;

		public unowned string to_string () {
			var flags_class = (FlagsClass) typeof(ModifierFlags).class_ref ();
			return flags_class.get_first_value (this).value_nick;
		}
	}

	public Parser () {
		tokens = new TokenInfo[BUFFER_SIZE];
	}

	/**
	 * Parses all .vala and .vapi source files in the specified code
	 * context and builds a code tree.
	 *
	 * @param context a code context
	 */
	public void parse (CodeContext context) {
		this.context = context;
		context.accept (this);
		this.context = null;
	}

	public override void visit_source_file (SourceFile source_file) {
		if ((context != null && context.run_output) || source_file.filename.has_suffix (".vala") || source_file.filename.has_suffix (".vapi")) {
			parse_file (source_file);
		}
	}

	inline bool next () {
		index = (index + 1) % BUFFER_SIZE;
		size--;
		if (size <= 0) {
			SourceLocation begin, end;
			TokenType type = scanner.read_token (out begin, out end);
			tokens[index] = { type, begin, end };
			size = 1;
		}
		return (tokens[index].type != TokenType.EOF);
	}

	inline void prev () {
		index = (index - 1 + BUFFER_SIZE) % BUFFER_SIZE;
		size++;
		assert (size <= BUFFER_SIZE);
	}

	inline void safe_prev () {
		switch (previous ()) {
		case TokenType.DOT:
		case TokenType.DOUBLE_COLON:
			break;
		default:
			prev ();
			break;
		}
	}

	inline TokenType current () {
		return tokens[index].type;
	}

	inline TokenType previous () {
		return tokens[(index - 1 + BUFFER_SIZE) % BUFFER_SIZE].type;
	}

	inline bool accept (TokenType type) {
		if (current () == type) {
			next ();
			return true;
		}
		return false;
	}

	void report_parse_error (ParseError e) {
		var begin = get_location ();
		next ();
		Report.error (get_src (begin), "syntax error, %s", e.message);
	}

	inline bool expect (TokenType type) throws ParseError {
		if (accept (type)) {
			return true;
		}

		switch (type) {
		case TokenType.CLOSE_BRACE:
			safe_prev ();
			report_parse_error (new ParseError.SYNTAX ("following block delimiter %s missing", type.to_string ()));
			return true;
		case TokenType.CLOSE_BRACKET:
		case TokenType.CLOSE_PARENS:
		case TokenType.SEMICOLON:
			safe_prev ();
			report_parse_error (new ParseError.SYNTAX ("following expression/statement delimiter %s missing", type.to_string ()));
			return true;
		default:
			throw new ParseError.SYNTAX ("expected %s", type.to_string ());
		}
	}

	inline SourceLocation get_location () {
		return tokens[index].begin;
	}

	string get_location_string () {
		var begin = get_location ();
		return "__VALA_L%d_C%d__".printf (begin.line, begin.column);
	}

	string get_current_string () {
		var token = tokens[index];
		return ((string) token.begin.pos).substring (0, (int) (token.end.pos - token.begin.pos));
	}

	string get_last_string () {
		int last_index = (index + BUFFER_SIZE - 1) % BUFFER_SIZE;
		var token = tokens[last_index];
		return ((string) token.begin.pos).substring (0, (int) (token.end.pos - token.begin.pos));
	}

	SourceReference get_src (SourceLocation begin) {
		int last_index = (index + BUFFER_SIZE - 1) % BUFFER_SIZE;

		return new SourceReference (scanner.source_file, begin, tokens[last_index].end);
	}

	SourceReference get_current_src () {
		var token = tokens[index];
		return new SourceReference (scanner.source_file, token.begin, token.end);
	}

	SourceReference get_last_src () {
		int last_index = (index + BUFFER_SIZE - 1) % BUFFER_SIZE;
		var token = tokens[last_index];
		return new SourceReference (scanner.source_file, token.begin, token.end);
	}

	void rollback (SourceLocation location) {
		while (tokens[index].begin.pos != location.pos) {
			index = (index - 1 + BUFFER_SIZE) % BUFFER_SIZE;
			size++;
			if (size > BUFFER_SIZE) {
				scanner.seek (location);
				size = 0;
				index = 0;

				next ();
			}
		}
	}

	void jump (SourceLocation location) {
		while (tokens[index].begin.pos != location.pos) {
			index = (index + 1) % BUFFER_SIZE;
			size--;
			if (size <= 0) {
				scanner.seek (location);
				size = 0;
				index = 0;

				next ();
			}
		}
	}

	void skip_identifier () throws ParseError {
		// also accept keywords as identifiers where there is no conflict
		switch (current ()) {
		case TokenType.ABSTRACT:
		case TokenType.AS:
		case TokenType.ASYNC:
		case TokenType.BASE:
		case TokenType.BREAK:
		case TokenType.CASE:
		case TokenType.CATCH:
		case TokenType.CLASS:
		case TokenType.CONST:
		case TokenType.CONSTRUCT:
		case TokenType.CONTINUE:
		case TokenType.DEFAULT:
		case TokenType.DELEGATE:
		case TokenType.DELETE:
		case TokenType.DO:
		case TokenType.DYNAMIC:
		case TokenType.ELSE:
		case TokenType.ENUM:
		case TokenType.ENSURES:
		case TokenType.ERRORDOMAIN:
		case TokenType.EXTERN:
		case TokenType.FALSE:
		case TokenType.FINALLY:
		case TokenType.FOR:
		case TokenType.FOREACH:
		case TokenType.GET:
		case TokenType.IDENTIFIER:
		case TokenType.IF:
		case TokenType.IN:
		case TokenType.INLINE:
		case TokenType.INTERFACE:
		case TokenType.INTERNAL:
		case TokenType.IS:
		case TokenType.LOCK:
		case TokenType.NAMESPACE:
		case TokenType.NEW:
		case TokenType.NULL:
		case TokenType.OUT:
		case TokenType.OVERRIDE:
		case TokenType.OWNED:
		case TokenType.PARAMS:
		case TokenType.PARTIAL:
		case TokenType.PRIVATE:
		case TokenType.PROTECTED:
		case TokenType.PUBLIC:
		case TokenType.REF:
		case TokenType.REQUIRES:
		case TokenType.RETURN:
		case TokenType.SEALED:
		case TokenType.SET:
		case TokenType.SIGNAL:
		case TokenType.SIZEOF:
		case TokenType.STATIC:
		case TokenType.STRUCT:
		case TokenType.SWITCH:
		case TokenType.THIS:
		case TokenType.THROW:
		case TokenType.THROWS:
		case TokenType.TRUE:
		case TokenType.TRY:
		case TokenType.TYPEOF:
		case TokenType.UNLOCK:
		case TokenType.UNOWNED:
		case TokenType.USING:
		case TokenType.VAR:
		case TokenType.VIRTUAL:
		case TokenType.VOID:
		case TokenType.VOLATILE:
		case TokenType.WEAK:
		case TokenType.WHILE:
		case TokenType.WITH:
		case TokenType.YIELD:
			next ();
			return;
		case TokenType.INTEGER_LITERAL:
		case TokenType.REAL_LITERAL:
			// also accept integer and real literals
			// as long as they contain at least one character
			// and no decimal point
			// for example, 2D and 3D
			string id = get_current_string ();
			if (id[id.length - 1].isalpha () && !("." in id)) {
				next ();
				return;
			}
			break;
		default:
			throw new ParseError.SYNTAX ("expected identifier");
		}
	}

	string parse_identifier (bool required = false) throws ParseError {
		try {
			skip_identifier ();
		} catch (ParseError e) {
			if (!required && context.keep_going) {
				report_parse_error (e);
				prev ();
				return get_location_string ();
			} else {
				throw e;
			}
		}
		return get_last_string ();
	}

	Expression parse_literal () throws ParseError {
		var begin = get_location ();

		switch (current ()) {
		case TokenType.TRUE:
			next ();
			return new BooleanLiteral (true, get_src (begin));
		case TokenType.FALSE:
			next ();
			return new BooleanLiteral (false, get_src (begin));
		case TokenType.INTEGER_LITERAL:
			next ();
			return new IntegerLiteral (get_last_string (), get_src (begin));
		case TokenType.REAL_LITERAL:
			next ();
			return new RealLiteral (get_last_string (), get_src (begin));
		case TokenType.CHARACTER_LITERAL:
			next ();
			// FIXME validate and unescape here and just pass unichar to CharacterLiteral
			var lit = new CharacterLiteral (get_last_string (), get_src (begin));
			if (lit.error) {
				Report.error (lit.source_reference, "invalid character literal");
			}
			return lit;
		case TokenType.REGEX_LITERAL:
			next ();
			string match_part = get_last_string ();
			SourceReference src_begin = get_src (begin);
			expect (TokenType.CLOSE_REGEX_LITERAL);
			string close_token = get_last_string ();
			return new RegexLiteral ("%s/%s".printf (close_token, match_part), src_begin);
		case TokenType.STRING_LITERAL:
			next ();
			return new StringLiteral (get_last_string (), get_src (begin));
		case TokenType.TEMPLATE_STRING_LITERAL:
			next ();
			return new StringLiteral ("\"%s\"".printf (get_last_string ()), get_src (begin));
		case TokenType.VERBATIM_STRING_LITERAL:
			next ();
			string raw_string = get_last_string ();
			string escaped_string = raw_string.substring (3, raw_string.length - 6).escape ("");
			return new StringLiteral ("\"%s\"".printf (escaped_string), get_src (begin));
		case TokenType.VERBATIM_TEMPLATE_STRING_LITERAL:
			next ();
			string raw_string = get_last_string ();
			string escaped_string = raw_string.escape ("");
			return new StringLiteral ("\"%s\"".printf (escaped_string), get_src (begin));
		case TokenType.NULL:
			next ();
			return new NullLiteral (get_src (begin));
		default:
			throw new ParseError.SYNTAX ("expected literal");
		}
	}

	public void parse_file (SourceFile source_file) {
		var has_global_context = (context != null);
		if (!has_global_context) {
			context = source_file.context;
		}

		scanner = new Scanner (source_file);
		parse_file_comments ();

		tokens = new TokenInfo[BUFFER_SIZE];
		index = -1;
		size = 0;

		next ();


		try {
			partials = new PartialInfo[] {};
			var begin = get_location ();
			parse_using_directives (context.root);
			parse_declarations (context.root, true);
			if (accept (TokenType.CLOSE_BRACE)) {
				// only report error if it's not a secondary error
				if (context.report.get_errors () == 0) {
					Report.error (get_last_src (), "unexpected `}'");
				}
			}
			if (partials.length > 0) {
				rollback (begin);
				foreach (var info in partials) {
					jump (info.begin);
					parse_class_declaration (info.parent, info.attributes, true);
				}
			}
			partials = null;
		} catch (ParseError e) {
			report_parse_error (e);
		}

		scanner = null;
		if (!has_global_context) {
			context = null;
		}
	}

	void parse_file_comments () {
		scanner.parse_file_comments ();
	}

	void skip_symbol_name () throws ParseError {
		do {
			skip_identifier ();
		} while (accept (TokenType.DOT) || accept (TokenType.DOUBLE_COLON));
	}

	UnresolvedSymbol parse_symbol_name () throws ParseError {
		var begin = get_location ();
		UnresolvedSymbol sym = null;
		do {
			string name = parse_identifier ();
			if (name == "global" && accept (TokenType.DOUBLE_COLON)) {
				// global::Name
				// qualified access to global symbol
				name = parse_identifier ();
				sym = new UnresolvedSymbol (sym, name, get_src (begin));
				sym.qualified = true;
				continue;
			}
			sym = new UnresolvedSymbol (sym, name, get_src (begin));
		} while (accept (TokenType.DOT));
		return sym;
	}

	void skip_type () throws ParseError {
		accept (TokenType.DYNAMIC);
		accept (TokenType.OWNED);
		accept (TokenType.UNOWNED);
		accept (TokenType.WEAK);

		if (is_inner_array_type ()) {
			expect (TokenType.OPEN_PARENS);
			expect (TokenType.UNOWNED);
			skip_type ();
			expect (TokenType.CLOSE_PARENS);
			expect (TokenType.OPEN_BRACKET);
			prev ();
		} else {
			if (accept (TokenType.VOID)) {
			} else {
				skip_symbol_name ();
				skip_type_argument_list ();
			}
			while (accept (TokenType.STAR)) {
			}
			accept (TokenType.INTERR);
		}

		while (accept (TokenType.OPEN_BRACKET)) {
			do {
				// required for decision between expression and declaration statement
				if (current () != TokenType.COMMA && current () != TokenType.CLOSE_BRACKET && current () != TokenType.COLON) {
					parse_expression ();
				}
			} while (accept (TokenType.COMMA));
			if (accept (TokenType.COLON)) {
				skip_symbol_name ();
			}
			expect (TokenType.CLOSE_BRACKET);
			accept (TokenType.INTERR);
		}
		accept (TokenType.OP_NEG);
	}

	bool is_inner_array_type () {
		var begin = get_location ();

		var result = accept (TokenType.OPEN_PARENS) && accept (TokenType.UNOWNED) && current() != TokenType.CLOSE_PARENS;
		rollback (begin);
		return result;
	}

	DataType parse_type (bool owned_by_default, bool can_weak_ref, bool require_unowned = false) throws ParseError {
		var begin = get_location ();

		bool is_dynamic = accept (TokenType.DYNAMIC);

		bool value_owned = owned_by_default;

		if (require_unowned) {
			expect (TokenType.UNOWNED);
		} else {
			if (owned_by_default) {
				if (accept (TokenType.UNOWNED)) {
					value_owned = false;
				} else if (accept (TokenType.WEAK)) {
					if (!can_weak_ref && !context.deprecated) {
						Report.warning (get_last_src (), "deprecated syntax, use `unowned` modifier");
					}
					value_owned = false;
				} else if (accept (TokenType.OWNED)) {
					Report.warning (get_last_src (), "`owned' is default in this context");
				}
			} else {
				if (accept (TokenType.OWNED)) {
					value_owned = true;
				} else {
					value_owned = false;
					if (accept (TokenType.UNOWNED)) {
						Report.warning (get_last_src (), "`unowned' is default in this context");
					}
				}
			}
		}

		DataType type;

		bool inner_type_owned = true;
		if (accept (TokenType.OPEN_PARENS)) {
			type = parse_type (false, false, true);
			expect (TokenType.CLOSE_PARENS);

			inner_type_owned = false;

			expect (TokenType.OPEN_BRACKET);
			prev ();
		} else {
			if (!is_dynamic && value_owned == owned_by_default && accept (TokenType.VOID)) {
				type = new VoidType (get_src (begin));
			} else {
				var sym = parse_symbol_name ();
				List<DataType> type_arg_list = parse_type_argument_list (false);

				type = new UnresolvedType.from_symbol (sym, get_src (begin));
				if (type_arg_list != null) {
					foreach (DataType type_arg in type_arg_list) {
						type.add_type_argument (type_arg);
					}
				}
			}

			while (accept (TokenType.STAR)) {
				type = new PointerType (type, get_src (begin));
			}

			if (!(type is PointerType)) {
				type.nullable = accept (TokenType.INTERR);
				type.source_reference = get_src (begin);
			}
		}

		// array brackets in types are read from right to left,
		// this is more logical, especially when nullable arrays
		// or pointers are involved
		DataType? array_length_type = null;
		while (accept (TokenType.OPEN_BRACKET)) {
			bool invalid_array = false;
			int array_rank = 0;
			do {
				array_rank++;
				// required for decision between expression and declaration statement
				if (current () != TokenType.COMMA && current () != TokenType.CLOSE_BRACKET && current () != TokenType.COLON) {
					parse_expression ();
					// only used for parsing, reject use as real type
					invalid_array = true;
				}
			} while (accept (TokenType.COMMA));
			if (accept (TokenType.COLON)) {
				array_length_type = parse_type (true, false);
			}
			expect (TokenType.CLOSE_BRACKET);

			type.value_owned = inner_type_owned;

			var array_type = new ArrayType (type, array_rank, get_src (begin));
			array_type.nullable = accept (TokenType.INTERR);
			array_type.invalid_syntax = invalid_array;
			if (array_length_type != null) {
				array_type.length_type = array_length_type.copy ();
			}

			type = array_type;
		}

		if (accept (TokenType.OP_NEG)) {
			Report.warning (get_last_src (), "obsolete syntax, types are non-null by default");
		}

		if (type is PointerType) {
			value_owned = false;
		}

		type.is_dynamic = is_dynamic;
		type.value_owned = value_owned;
		return type;
	}

	DataType? parse_inline_array_type (DataType? type) throws ParseError {
		var begin = get_location ();

		// inline-allocated array
		if (type != null && accept (TokenType.OPEN_BRACKET)) {
			Expression array_length = null;
			DataType? array_length_type = null;

			if (current () != TokenType.CLOSE_BRACKET) {
				array_length = parse_expression ();
			}
			if (accept (TokenType.COLON)) {
				array_length_type = parse_type (true, false);
			}
			expect (TokenType.CLOSE_BRACKET);

			var array_type = new ArrayType (type, 1, get_src (begin));
			array_type.inline_allocated = true;
			if (array_length != null) {
				array_type.fixed_length = true;
				array_type.length = array_length;
			}
			if (array_length_type != null) {
				array_type.length_type = array_length_type;
			}
			array_type.value_owned = type.value_owned;

			return array_type;
		}
		return type;
	}

	List<Expression> parse_argument_list () throws ParseError {
		expect (TokenType.OPEN_PARENS);
		var list = new ArrayList<Expression> ();
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				try {
					list.add (parse_argument ());
				} catch (ParseError e) {
					if (current () == TokenType.CLOSE_PARENS) {
						prev ();
						report_parse_error (new ParseError.SYNTAX ("incomplete argument list"));
					} else if (context.keep_going) {
						report_parse_error (e);
					} else {
						throw e;
					}
				}
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_PARENS);
		return list;
	}

	Expression parse_argument () throws ParseError {
		var begin = get_location ();

		if (accept (TokenType.REF)) {
			var inner = parse_expression ();
			return new UnaryExpression (UnaryOperator.REF, inner, get_src (begin));
		} else if (accept (TokenType.OUT)) {
			var inner = parse_expression ();
			return new UnaryExpression (UnaryOperator.OUT, inner, get_src (begin));
		} else {
			var expr = parse_expression ();
			var ma = expr as MemberAccess;
			if (ma != null && ma.inner == null && accept (TokenType.COLON)) {
				// named argument
				expr = parse_expression ();
				return new NamedArgument (ma.member_name, expr, get_src (begin));
			} else {
				return expr;
			}
		}
	}

	Expression parse_primary_expression () throws ParseError {
		var begin = get_location ();

		Expression expr;

		switch (current ()) {
		case TokenType.TRUE:
		case TokenType.FALSE:
		case TokenType.INTEGER_LITERAL:
		case TokenType.REAL_LITERAL:
		case TokenType.CHARACTER_LITERAL:
		case TokenType.STRING_LITERAL:
		case TokenType.REGEX_LITERAL:
		case TokenType.TEMPLATE_STRING_LITERAL:
		case TokenType.VERBATIM_STRING_LITERAL:
		case TokenType.VERBATIM_TEMPLATE_STRING_LITERAL:
		case TokenType.NULL:
			expr = parse_literal ();
			break;
		case TokenType.OPEN_BRACE:
			expr = parse_initializer ();
			break;
		case TokenType.OPEN_BRACKET:
			expr = parse_simple_name ();
			break;
		case TokenType.OPEN_PARENS:
			expr = parse_tuple ();
			break;
		case TokenType.OPEN_TEMPLATE:
			expr = parse_template ();
			break;
		case TokenType.OPEN_REGEX_LITERAL:
			expr = parse_regex_literal ();
			break;
		case TokenType.THIS:
			expr = parse_this_access ();
			break;
		case TokenType.BASE:
			expr = parse_base_access ();
			break;
		case TokenType.NEW:
			expr = parse_object_or_array_creation_expression ();
			break;
		case TokenType.YIELD:
			expr = parse_yield_expression ();
			break;
		case TokenType.SIZEOF:
			expr = parse_sizeof_expression ();
			break;
		case TokenType.TYPEOF:
			expr = parse_typeof_expression ();
			break;
		default:
			expr = parse_simple_name ();
			break;
		}

		// process primary expressions that start with an inner primary expression
		bool found = true;
		while (found) {
			switch (current ()) {
			case TokenType.INTERR:
				// check for null-safe member or element access
				next ();
				switch (current ()) {
				case TokenType.DOT:
					expr = parse_member_access (begin, expr);
					break;
				case TokenType.OPEN_BRACKET:
					expr = parse_element_access (begin, expr);
					break;
				default:
					prev ();
					found = false;
					break;
				}
				break;
			case TokenType.DOT:
				expr = parse_member_access (begin, expr);
				break;
			case TokenType.OP_PTR:
				expr = parse_pointer_member_access (begin, expr);
				break;
			case TokenType.OPEN_PARENS:
				expr = parse_method_call (begin, expr);
				break;
			case TokenType.OPEN_BRACKET:
				expr = parse_element_access (begin, expr);
				break;
			case TokenType.OP_INC:
				expr = parse_post_increment_expression (begin, expr);
				break;
			case TokenType.OP_DEC:
				expr = parse_post_decrement_expression (begin, expr);
				break;
			default:
				found = false;
				break;
			}
		}

		return expr;
	}

	Expression parse_simple_name () throws ParseError {
		var begin = get_location ();
		string id = parse_identifier ();
		bool qualified = false;
		if (id == "global" && accept (TokenType.DOUBLE_COLON)) {
			id = parse_identifier ();
			qualified = true;
		}
		List<DataType> type_arg_list = parse_type_argument_list (true);
		var expr = new MemberAccess (null, id, get_src (begin));
		expr.qualified = qualified;
		if (type_arg_list != null) {
			foreach (DataType type_arg in type_arg_list) {
				expr.add_type_argument (type_arg);
			}
		}
		return expr;
	}

	Expression parse_tuple () throws ParseError {
		var begin = get_location ();

		expect (TokenType.OPEN_PARENS);
		var expr_list = new ArrayList<Expression> ();
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				expr_list.add (parse_expression ());
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_PARENS);
		if (expr_list.size != 1) {
			var tuple = new Tuple (get_src (begin));
			foreach (Expression expr in expr_list) {
				tuple.add_expression (expr);
			}
			return tuple;
		} else {
			var expr = expr_list.get (0);
			expr.source_reference = get_src (begin);
			return expr;
		}
	}

	Expression parse_template () throws ParseError {
		var begin = get_location ();
		var template = new Template ();

		expect (TokenType.OPEN_TEMPLATE);
		while (current () != TokenType.CLOSE_TEMPLATE) {
			template.add_expression (parse_expression ());
			expect (TokenType.COMMA);
		}
		expect (TokenType.CLOSE_TEMPLATE);

		template.source_reference = get_src (begin);
		return template;
	}

	Expression parse_regex_literal () throws ParseError {
		expect (TokenType.OPEN_REGEX_LITERAL);

		var expr = parse_literal ();

		return expr;
	}

	Expression parse_member_access (SourceLocation begin, Expression inner) throws ParseError {
		bool null_safe = previous () == TokenType.INTERR;

		expect (TokenType.DOT);
		string id = parse_identifier ();
		List<DataType> type_arg_list = parse_type_argument_list (true);
		var expr = new MemberAccess (inner, id, get_src (begin));
		expr.null_safe_access = null_safe;
		if (type_arg_list != null) {
			foreach (DataType type_arg in type_arg_list) {
				expr.add_type_argument (type_arg);
			}
		}
		return expr;
	}

	Expression parse_pointer_member_access (SourceLocation begin, Expression inner) throws ParseError {
		expect (TokenType.OP_PTR);
		string id = parse_identifier ();
		List<DataType> type_arg_list = parse_type_argument_list (true);
		var expr = new MemberAccess.pointer (inner, id, get_src (begin));
		if (type_arg_list != null) {
			foreach (DataType type_arg in type_arg_list) {
				expr.add_type_argument (type_arg);
			}
		}
		return expr;
	}

	Expression parse_method_call (SourceLocation begin, Expression inner) throws ParseError {
		var arg_list = parse_argument_list ();
		var src = get_src (begin);

		var init_list = parse_object_initializer ();

		if (init_list.size > 0 && inner is MemberAccess) {
			// struct creation expression
			unowned MemberAccess member = (MemberAccess) inner;

			var expr = new ObjectCreationExpression (member, src);
			expr.struct_creation = true;
			foreach (Expression arg in arg_list) {
				expr.add_argument (arg);
			}
			foreach (MemberInitializer initializer in init_list) {
				expr.add_member_initializer (initializer);
			}
			return expr;
		} else {
			var expr = new MethodCall (inner, src);
			foreach (Expression arg in arg_list) {
				expr.add_argument (arg);
			}
			return expr;
		}
	}

	Expression parse_element_access (SourceLocation begin, Expression inner) throws ParseError {
		Expression? stop = null;
		List<Expression> index_list;
		bool null_safe = previous () == TokenType.INTERR;

		expect (TokenType.OPEN_BRACKET);
		if (current () == TokenType.COLON) {
			// slice expression
			index_list = new ArrayList<Expression> ();
			index_list.add (new IntegerLiteral ("0", get_src (begin)));
		} else {
			index_list = parse_expression_list ();
		}

		if (index_list.size == 1 && accept (TokenType.COLON)) {
			// slice expression
			if (current () == TokenType.CLOSE_BRACKET) {
				stop = new MemberAccess (inner, "length", get_src (begin));
			} else {
				stop = parse_expression ();
			}
		}
		expect (TokenType.CLOSE_BRACKET);

		if (stop == null) {
			var expr = new ElementAccess (inner, get_src (begin));
			expr.null_safe_access = null_safe;
			foreach (Expression index in index_list) {
				expr.append_index (index);
			}
			return expr;
		} else {
			var expr = new SliceExpression (inner, index_list[0], stop, get_src (begin));
			expr.null_safe_access = null_safe;
			return expr;
		}
	}

	List<Expression> parse_expression_list () throws ParseError {
		var list = new ArrayList<Expression> ();
		do {
			list.add (parse_expression ());
		} while (accept (TokenType.COMMA));
		return list;
	}

	Expression parse_this_access () throws ParseError {
		var begin = get_location ();
		expect (TokenType.THIS);
		return new MemberAccess (null, "this", get_src (begin));
	}

	Expression parse_base_access () throws ParseError {
		var begin = get_location ();
		expect (TokenType.BASE);
		return new BaseAccess (get_src (begin));
	}

	Expression parse_post_increment_expression (SourceLocation begin, Expression inner) throws ParseError {
		expect (TokenType.OP_INC);
		return new PostfixExpression (inner, true, get_src (begin));
	}

	Expression parse_post_decrement_expression (SourceLocation begin, Expression inner) throws ParseError {
		expect (TokenType.OP_DEC);
		return new PostfixExpression (inner, false, get_src (begin));
	}

	Expression parse_object_or_array_creation_expression () throws ParseError {
		var begin = get_location ();
		expect (TokenType.NEW);

		if (is_inner_array_type ()) {
			rollback (begin);
			return parse_array_creation_expression ();
		}

		var member = parse_member_name ();
		if (current () == TokenType.OPEN_PARENS) {
			var expr = parse_object_creation_expression (begin, member);
			return expr;
		} else {
			bool is_pointer_type = false;
			while (accept (TokenType.STAR)) {
				is_pointer_type = true;
			}
			if (!is_pointer_type) {
				accept (TokenType.INTERR);
			}
			if (accept (TokenType.OPEN_BRACKET)) {
				rollback (begin);
				var expr = parse_array_creation_expression ();
				return expr;
			} else {
				throw new ParseError.SYNTAX ("expected ( or [");
			}
		}
	}

	Expression parse_object_creation_expression (SourceLocation begin, MemberAccess member) throws ParseError {
		var arg_list = parse_argument_list ();
		var src = get_src (begin);

		var init_list = parse_object_initializer ();

		var expr = new ObjectCreationExpression (member, src);
		foreach (Expression arg in arg_list) {
			expr.add_argument (arg);
		}
		foreach (MemberInitializer initializer in init_list) {
			expr.add_member_initializer (initializer);
		}
		return expr;
	}

	Expression parse_array_creation_expression () throws ParseError {
		var begin = get_location ();
		expect (TokenType.NEW);

		bool inner_array_type = is_inner_array_type ();
		if (inner_array_type) {
			expect (TokenType.OPEN_PARENS);
			expect (TokenType.UNOWNED);
		}

		var member = parse_member_name ();
		DataType element_type = new UnresolvedType.from_expression (member);
		bool is_pointer_type = false;
		while (accept (TokenType.STAR)) {
			element_type = new PointerType (element_type, get_src (begin));
			is_pointer_type = true;
		}
		if (!is_pointer_type) {
			if (accept (TokenType.INTERR)) {
				element_type.nullable = true;
			}
		}

		if (inner_array_type) {
			expect (TokenType.CLOSE_PARENS);
			element_type.value_owned = false;
		} else {
			element_type.value_owned = true;
		}

		expect (TokenType.OPEN_BRACKET);

		bool size_specified = false;
		List<Expression> size_specifier_list = null;
		bool first = true;
		DataType? array_length_type = null;
		do {
			if (!first) {
				// array of arrays: new T[][42]

				if (size_specified) {
					throw new ParseError.SYNTAX ("size of inner arrays must not be specified in array creation expression");
				}

				element_type = new ArrayType (element_type, size_specifier_list.size, element_type.source_reference);
				if (array_length_type != null) {
					((ArrayType) element_type).length_type = array_length_type.copy ();
				}
			} else {
				first = false;
			}

			size_specifier_list = new ArrayList<Expression> ();
			do {
				Expression size = null;
				if (current () != TokenType.CLOSE_BRACKET && current () != TokenType.COMMA && current () != TokenType.COLON) {
					size = parse_expression ();
					size_specified = true;
				}
				size_specifier_list.add (size);
			} while (accept (TokenType.COMMA));
			if (accept (TokenType.COLON)) {
				array_length_type = parse_type (true, false);
			}
			expect (TokenType.CLOSE_BRACKET);
		} while (accept (TokenType.OPEN_BRACKET));

		var src = get_src (begin);

		InitializerList initializer = null;
		if (current () == TokenType.OPEN_BRACE) {
			initializer = parse_initializer ();
		}
		var expr = new ArrayCreationExpression (element_type, size_specifier_list.size, initializer, src);
		if (array_length_type != null) {
			expr.length_type = array_length_type.copy ();
		}
		if (size_specified) {
			foreach (Expression size in size_specifier_list) {
				expr.append_size (size);
			}
		} else if (initializer == null) {
			Report.warning (src, "possibly missing array size");
			throw new ParseError.SYNTAX ("expected array initializer list");
		}
		return expr;
	}

	List<MemberInitializer> parse_object_initializer () throws ParseError {
		var list = new ArrayList<MemberInitializer> ();
		if (accept (TokenType.OPEN_BRACE)) {
			while (current () != TokenType.CLOSE_BRACE) {
				list.add (parse_member_initializer ());

				if (!accept (TokenType.COMMA)) {
					break;
				}
			}
			expect (TokenType.CLOSE_BRACE);
		}
		return list;
	}

	MemberInitializer parse_member_initializer (bool chained = false) throws ParseError {
		var begin = get_location ();
		string id = parse_identifier (chained);
		expect (TokenType.ASSIGN);

		var inner = get_location ();
		Expression expr;
		try {
			// chained member initializer
			expr = parse_member_initializer (true);
		} catch {
			rollback (inner);
			expr = parse_expression ();
		}
		return new MemberInitializer (id, expr, get_src (begin));
	}

	Expression parse_yield_expression () throws ParseError {
		expect (TokenType.YIELD);

		var expr = parse_expression ();

		unowned MethodCall? call = expr as MethodCall;
		unowned ObjectCreationExpression? object_creation = expr as ObjectCreationExpression;
		if (call == null && object_creation == null) {
			Report.error (expr.source_reference, "syntax error, expected method call");
			expr.error = true;
		}

		if (call != null) {
			call.is_yield_expression = true;
		} else if (object_creation != null) {
			object_creation.is_yield_expression = true;
		}

		return expr;
	}

	Expression parse_sizeof_expression () throws ParseError {
		var begin = get_location ();
		expect (TokenType.SIZEOF);
		expect (TokenType.OPEN_PARENS);
		var type = parse_type (true, false);
		expect (TokenType.CLOSE_PARENS);

		return new SizeofExpression (type, get_src (begin));
	}

	Expression parse_typeof_expression () throws ParseError {
		var begin = get_location ();
		expect (TokenType.TYPEOF);
		expect (TokenType.OPEN_PARENS);
		var type = parse_type (true, false);
		expect (TokenType.CLOSE_PARENS);

		return new TypeofExpression (type, get_src (begin));
	}

	UnaryOperator get_unary_operator (TokenType token_type) {
		switch (token_type) {
		case TokenType.PLUS:   return UnaryOperator.PLUS;
		case TokenType.MINUS:  return UnaryOperator.MINUS;
		case TokenType.OP_NEG: return UnaryOperator.LOGICAL_NEGATION;
		case TokenType.TILDE:  return UnaryOperator.BITWISE_COMPLEMENT;
		case TokenType.OP_INC: return UnaryOperator.INCREMENT;
		case TokenType.OP_DEC: return UnaryOperator.DECREMENT;
		default:               return UnaryOperator.NONE;
		}
	}

	Expression parse_unary_expression () throws ParseError {
		var begin = get_location ();
		var operator = get_unary_operator (current ());
		if (operator != UnaryOperator.NONE) {
			next ();
			var op = parse_unary_expression ();
			unowned IntegerLiteral? lit = op as IntegerLiteral;
			if (lit != null) {
				if (operator == UnaryOperator.PLUS) {
					return lit;
				} else if (operator == UnaryOperator.MINUS) {
					return new IntegerLiteral ("-"+lit.value, get_src (begin));
				}
			}
			return new UnaryExpression (operator, op, get_src (begin));
		}
		switch (current ()) {
		case TokenType.OPEN_PARENS:
			next ();
			switch (current ()) {
			case TokenType.UNOWNED:
				// inner array type
				break;
			case TokenType.OWNED:
				// (owned) foo
				next ();
				if (accept (TokenType.CLOSE_PARENS)) {
					var op = parse_unary_expression ();
					return new ReferenceTransferExpression (op, get_src (begin));
				}
				break;
			case TokenType.VOID:
			case TokenType.DYNAMIC:
			case TokenType.OPEN_PARENS:
			case TokenType.IDENTIFIER:
				if (current () != TokenType.OPEN_PARENS || is_inner_array_type ()) {
					var type = parse_type (true, false);
					if (accept (TokenType.CLOSE_PARENS)) {
						// check follower to decide whether to create cast expression
						switch (current ()) {
						case TokenType.OP_NEG:
						case TokenType.TILDE:
						case TokenType.OPEN_PARENS:
						case TokenType.TRUE:
						case TokenType.FALSE:
						case TokenType.INTEGER_LITERAL:
						case TokenType.REAL_LITERAL:
						case TokenType.CHARACTER_LITERAL:
						case TokenType.STRING_LITERAL:
						case TokenType.TEMPLATE_STRING_LITERAL:
						case TokenType.VERBATIM_STRING_LITERAL:
						case TokenType.VERBATIM_TEMPLATE_STRING_LITERAL:
						case TokenType.REGEX_LITERAL:
						case TokenType.NULL:
						case TokenType.THIS:
						case TokenType.BASE:
						case TokenType.NEW:
						case TokenType.YIELD:
						case TokenType.SIZEOF:
						case TokenType.TYPEOF:
						case TokenType.IDENTIFIER:
						case TokenType.PARAMS:
							var inner = parse_unary_expression ();
							return new CastExpression (inner, type, get_src (begin));
						case TokenType.STAR:
							next ();
							var op = parse_unary_expression ();
							var inner = new PointerIndirection (op, get_src (begin));
							return new CastExpression (inner, type, get_src (begin));
						case TokenType.BITWISE_AND:
							next ();
							var op = parse_unary_expression ();
							var inner = new AddressofExpression (op, get_src (begin));
							return new CastExpression (inner, type, get_src (begin));
						default:
							break;
						}
					}
				}
				break;
			case TokenType.OP_NEG:
				next ();
				if (accept (TokenType.CLOSE_PARENS)) {
					// (!) non-null cast
					var inner = parse_unary_expression ();
					return new CastExpression.non_null (inner, get_src (begin));
				}
				break;
			default:
				break;
			}
			// no cast expression
			rollback (begin);
			break;
		case TokenType.STAR:
			next ();
			var op = parse_unary_expression ();
			return new PointerIndirection (op, get_src (begin));
		case TokenType.BITWISE_AND:
			next ();
			var op = parse_unary_expression ();
			return new AddressofExpression (op, get_src (begin));
		default:
			break;
		}

		var expr = parse_primary_expression ();
		return expr;
	}

	BinaryOperator get_binary_operator (TokenType token_type) {
		switch (token_type) {
		case TokenType.STAR:    return BinaryOperator.MUL;
		case TokenType.DIV:     return BinaryOperator.DIV;
		case TokenType.PERCENT: return BinaryOperator.MOD;
		case TokenType.PLUS:    return BinaryOperator.PLUS;
		case TokenType.MINUS:   return BinaryOperator.MINUS;
		case TokenType.OP_LT:   return BinaryOperator.LESS_THAN;
		case TokenType.OP_GT:   return BinaryOperator.GREATER_THAN;
		case TokenType.OP_LE:   return BinaryOperator.LESS_THAN_OR_EQUAL;
		case TokenType.OP_GE:   return BinaryOperator.GREATER_THAN_OR_EQUAL;
		case TokenType.OP_EQ:   return BinaryOperator.EQUALITY;
		case TokenType.OP_NE:   return BinaryOperator.INEQUALITY;
		default:                return BinaryOperator.NONE;
		}
	}

	Expression parse_multiplicative_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_unary_expression ();
		bool found = true;
		while (found) {
			var operator = get_binary_operator (current ());
			switch (operator) {
			case BinaryOperator.MUL:
			case BinaryOperator.DIV:
			case BinaryOperator.MOD:
				next ();
				var right = parse_unary_expression ();
				left = new BinaryExpression (operator, left, right, get_src (begin));
				break;
			default:
				found = false;
				break;
			}
		}
		return left;
	}

	Expression parse_additive_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_multiplicative_expression ();
		bool found = true;
		while (found) {
			var operator = get_binary_operator (current ());
			switch (operator) {
			case BinaryOperator.PLUS:
			case BinaryOperator.MINUS:
				next ();
				var right = parse_multiplicative_expression ();
				left = new BinaryExpression (operator, left, right, get_src (begin));
				break;
			default:
				found = false;
				break;
			}
		}
		return left;
	}

	Expression parse_shift_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_additive_expression ();
		bool found = true;
		while (found) {
			switch (current ()) {
			case TokenType.OP_SHIFT_LEFT:
				next ();
				var right = parse_additive_expression ();
				left = new BinaryExpression (BinaryOperator.SHIFT_LEFT, left, right, get_src (begin));
				break;
			// don't use OP_SHIFT_RIGHT to support >> for nested generics
			case TokenType.OP_GT:
				char* first_gt_pos = tokens[index].begin.pos;
				next ();
				// only accept >> when there is no space between the two > signs
				if (current () == TokenType.OP_GT && tokens[index].begin.pos == first_gt_pos + 1) {
					next ();
					var right = parse_additive_expression ();
					left = new BinaryExpression (BinaryOperator.SHIFT_RIGHT, left, right, get_src (begin));
				} else {
					prev ();
					found = false;
				}
				break;
			default:
				found = false;
				break;
			}
		}
		return left;
	}

	Expression parse_type_check_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_shift_expression ();
		if (accept (TokenType.IS)) {
			var type = parse_type (true, false);
			left = new TypeCheck (left, type, get_src (begin));
		} else if (accept (TokenType.AS)) {
			var type = parse_type (true, false);
			left = new CastExpression.silent (left, type, get_src (begin));
		}
		return left;
	}

	Expression parse_relational_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_type_check_expression ();

		bool first = true;
		bool found = true;
		while (found) {
			var operator = get_binary_operator (current ());
			switch (operator) {
			case BinaryOperator.LESS_THAN:
			case BinaryOperator.LESS_THAN_OR_EQUAL:
			case BinaryOperator.GREATER_THAN_OR_EQUAL:
			case BinaryOperator.EQUALITY:
			case BinaryOperator.INEQUALITY:
				next ();
				var right = parse_type_check_expression ();
				if (first) {
					left = new BinaryExpression (operator, left, right, get_src (begin));
				} else {
					left = new BinaryExpression.chained (operator, left, right, get_src (begin));
				}
				first = false;
				break;
			case BinaryOperator.GREATER_THAN:
				next ();
				// ignore >> and >>= (two tokens due to generics)
				if (current () != TokenType.OP_GT && current () != TokenType.OP_GE) {
					var right = parse_type_check_expression ();
					if (first) {
						left = new BinaryExpression (operator, left, right, get_src (begin));
					} else {
						left = new BinaryExpression.chained (operator, left, right, get_src (begin));
					}
					first = false;
				} else {
					prev ();
					found = false;
				}
				break;
			default:
				found = false;
				break;
			}
		}
		return left;
	}

	Expression parse_and_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_relational_expression ();
		while (accept (TokenType.BITWISE_AND)) {
			var right = parse_relational_expression ();
			left = new BinaryExpression (BinaryOperator.BITWISE_AND, left, right, get_src (begin));
		}
		return left;
	}

	Expression parse_exclusive_or_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_and_expression ();
		while (accept (TokenType.CARRET)) {
			var right = parse_and_expression ();
			left = new BinaryExpression (BinaryOperator.BITWISE_XOR, left, right, get_src (begin));
		}
		return left;
	}

	Expression parse_inclusive_or_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_exclusive_or_expression ();
		while (accept (TokenType.BITWISE_OR)) {
			var right = parse_exclusive_or_expression ();
			left = new BinaryExpression (BinaryOperator.BITWISE_OR, left, right, get_src (begin));
		}
		return left;
	}

	Expression parse_in_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_inclusive_or_expression ();
		while (accept (TokenType.IN)) {
			var right = parse_inclusive_or_expression ();
			left = new BinaryExpression (BinaryOperator.IN, left, right, get_src (begin));
		}
		return left;
	}

	Expression parse_conditional_and_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_in_expression ();
		while (accept (TokenType.OP_AND)) {
			var right = parse_in_expression ();
			left = new BinaryExpression (BinaryOperator.AND, left, right, get_src (begin));
		}
		return left;
	}

	Expression parse_conditional_or_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_conditional_and_expression ();
		while (accept (TokenType.OP_OR)) {
			var right = parse_conditional_and_expression ();
			left = new BinaryExpression (BinaryOperator.OR, left, right, get_src (begin));
		}
		return left;
	}

	Expression parse_coalescing_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_conditional_or_expression ();
		if (accept (TokenType.OP_COALESCING)) {
			var right = parse_coalescing_expression ();
			return new BinaryExpression (BinaryOperator.COALESCE, left, right, get_src (begin));
		} else {
			return left;
		}
	}

	Expression parse_conditional_expression () throws ParseError {
		var begin = get_location ();
		var condition = parse_coalescing_expression ();
		if (accept (TokenType.INTERR)) {
			var true_expr = parse_expression ();
			expect (TokenType.COLON);
			var false_expr = parse_expression ();
			return new ConditionalExpression (condition, true_expr, false_expr, get_src (begin));
		} else {
			return condition;
		}
	}

	Parameter parse_lambda_parameter () throws ParseError {
		var begin = get_location ();
		var direction = ParameterDirection.IN;
		if (accept (TokenType.OUT)) {
			direction = ParameterDirection.OUT;
		} else if (accept (TokenType.REF)) {
			direction = ParameterDirection.REF;
		}

		string id = parse_identifier ();

		var param = new Parameter (id, null, get_src (begin));
		param.direction = direction;
		return param;
	}

	Expression parse_lambda_expression () throws ParseError {
		var begin = get_location ();
		List<Parameter> params = new ArrayList<Parameter> ();
		if (accept (TokenType.OPEN_PARENS)) {
			if (current () != TokenType.CLOSE_PARENS) {
				do {
					params.add (parse_lambda_parameter ());
				} while (accept (TokenType.COMMA));
			}
			expect (TokenType.CLOSE_PARENS);
		} else {
			params.add (parse_lambda_parameter ());
		}
		expect (TokenType.LAMBDA);

		LambdaExpression lambda;
		if (current () == TokenType.OPEN_BRACE) {
			var block = parse_block ();
			lambda = new LambdaExpression.with_statement_body (block, get_src (begin));
		} else {
			var expr = parse_expression ();
			lambda = new LambdaExpression (expr, get_src (begin));
		}
		foreach (var param in params) {
			lambda.add_parameter (param);
		}
		return lambda;
	}

	AssignmentOperator get_assignment_operator (TokenType token_type) {
		switch (token_type) {
		case TokenType.ASSIGN:             return AssignmentOperator.SIMPLE;
		case TokenType.ASSIGN_ADD:         return AssignmentOperator.ADD;
		case TokenType.ASSIGN_SUB:         return AssignmentOperator.SUB;
		case TokenType.ASSIGN_BITWISE_OR:  return AssignmentOperator.BITWISE_OR;
		case TokenType.ASSIGN_BITWISE_AND: return AssignmentOperator.BITWISE_AND;
		case TokenType.ASSIGN_BITWISE_XOR: return AssignmentOperator.BITWISE_XOR;
		case TokenType.ASSIGN_DIV:         return AssignmentOperator.DIV;
		case TokenType.ASSIGN_MUL:         return AssignmentOperator.MUL;
		case TokenType.ASSIGN_PERCENT:     return AssignmentOperator.PERCENT;
		case TokenType.ASSIGN_SHIFT_LEFT:  return AssignmentOperator.SHIFT_LEFT;
		default:                           return AssignmentOperator.NONE;
		}
	}

	Expression parse_expression () throws ParseError {
		if (is_lambda_expression ()) {
			return parse_lambda_expression ();
		}

		var begin = get_location ();

		Expression expr = parse_conditional_expression ();

		while (true) {
			var operator = get_assignment_operator (current ());
			if (operator != AssignmentOperator.NONE) {
				next ();
				var rhs = parse_expression ();
				expr = new Assignment (expr, rhs, operator, get_src (begin));
			} else if (current () == TokenType.OP_GT) { // >>=
				char* first_gt_pos = tokens[index].begin.pos;
				next ();
				// only accept >>= when there is no space between the two > signs
				if (current () == TokenType.OP_GE && tokens[index].begin.pos == first_gt_pos + 1) {
					next ();
					var rhs = parse_expression ();
					expr = new Assignment (expr, rhs, AssignmentOperator.SHIFT_RIGHT, get_src (begin));
				} else {
					prev ();
					break;
				}
			} else {
				break;
			}
		}

		return expr;
	}

	Statement? parse_statement (TokenType type) throws ParseError {
		Statement? stmt = null;
		var begin = get_location ();
		try {
			switch (type) {
			case TokenType.IF:
				stmt = parse_if_statement ();
				break;
			case TokenType.SWITCH:
				stmt = parse_switch_statement ();
				break;
			case TokenType.CASE:
			case TokenType.DEFAULT:
				stmt = parse_switch_section_statement ();
				break;
			case TokenType.WHILE:
				stmt = parse_while_statement ();
				break;
			case TokenType.DO:
				stmt = parse_do_statement ();
				break;
			case TokenType.FOR:
				stmt = parse_for_statement ();
				break;
			case TokenType.FOREACH:
				stmt = parse_foreach_statement ();
				break;
			case TokenType.BREAK:
				stmt = parse_break_statement ();
				break;
			case TokenType.CONTINUE:
				stmt = parse_continue_statement ();
				break;
			case TokenType.RETURN:
				stmt = parse_return_statement ();
				break;
			case TokenType.YIELD:
				stmt = parse_yield_statement ();
				break;
			case TokenType.THROW:
				stmt = parse_throw_statement ();
				break;
			case TokenType.TRY:
				stmt = parse_try_statement ();
				break;
			case TokenType.LOCK:
				stmt = parse_lock_statement ();
				break;
			case TokenType.UNLOCK:
				stmt = parse_unlock_statement ();
				break;
			case TokenType.DELETE:
				stmt = parse_delete_statement ();
				break;
			case TokenType.WITH:
				stmt = parse_with_statement ();
				break;
			default:
				assert_not_reached ();
			}
		} catch (ParseError e) {
			var e_begin = get_location ();
			string token = ((EnumClass) typeof (TokenType).class_ref ()).get_value (type).value_nick;
			rollback (begin);
			if (!is_expression ()) {
				jump (e_begin);
				throw e;
			}
			try {
				stmt = parse_expression_statement ();
				Report.warning (get_src (begin), "`%s' is a syntax keyword, replace with `@%s'", token, token);
			} catch (ParseError e2) {
				var e2_begin = get_location ();
				jump (e_begin);
				next ();
				Report.error (get_src (e_begin), "Possible `%s-statement' syntax error, %s", token, e.message);
				rollback (begin);
				jump (e2_begin);
				throw e2;
			}
		}
		return stmt;
	}

	void parse_statements (Block block) throws ParseError {
		while (current () != TokenType.CLOSE_BRACE
		       && current () != TokenType.EOF) {
			try {
				Statement stmt = null;
				bool is_decl = false;

				comment = scanner.pop_comment ();
				switch (current ()) {
				case TokenType.OPEN_BRACE:
					stmt = parse_block ();
					break;
				case TokenType.SEMICOLON:
					stmt = parse_empty_statement ();
					break;
				case TokenType.IF:
				case TokenType.SWITCH:
				case TokenType.WHILE:
				case TokenType.DO:
				case TokenType.FOR:
				case TokenType.FOREACH:
				case TokenType.BREAK:
				case TokenType.CONTINUE:
				case TokenType.RETURN:
				case TokenType.YIELD:
				case TokenType.THROW:
				case TokenType.TRY:
				case TokenType.LOCK:
				case TokenType.UNLOCK:
				case TokenType.DELETE:
				case TokenType.WITH:
					stmt = parse_statement (current ());
					break;
				case TokenType.CASE:
				case TokenType.DEFAULT:
					if (block is SwitchSection) {
						// begin a new switch case
						return;
					} else {
						stmt = parse_statement (current ());
					}
					break;
				case TokenType.VAR:
					is_decl = true;
					parse_local_variable_declarations (block);
					break;
				case TokenType.CONST:
					is_decl = true;
					parse_local_constant_declarations (block);
					break;
				case TokenType.OP_INC:
				case TokenType.OP_DEC:
				case TokenType.BASE:
				case TokenType.THIS:
				case TokenType.STAR:
				case TokenType.NEW:
					stmt = parse_expression_statement ();
					break;
				default:
					bool is_expr = is_expression ();
					if (is_expr) {
						stmt = parse_expression_statement ();
					} else {
						is_decl = true;
						bool is_local_func = is_local_function ();
						if (is_local_func) {
							parse_local_function_declaration (block);
						} else {
							parse_local_variable_declarations (block);
						}
					}
					break;
				}

				if (!is_decl) {
					block.add_statement (stmt);
				}
			} catch (ParseError e) {
				report_parse_error (e);
				if (recover () != RecoveryState.STATEMENT_BEGIN) {
					// beginning of next declaration or end of file reached
					// return what we have so far
					break;
				}
			}
		}
	}

	bool is_expression () throws ParseError {
		if (current () == TokenType.OPEN_PARENS) {
			return !is_inner_array_type ();
		}

		var begin = get_location ();

		// decide between declaration and expression statement
		try {
			skip_type ();
		} catch (ParseError e) {
			var token = previous ();
			if (token == TokenType.DOT || token == TokenType.DOUBLE_COLON) {
				rollback (begin);
				return true;
			} else {
				throw e;
			}
		}
		switch (current ()) {
		// invocation expression
		case TokenType.OPEN_PARENS:
		// postfix increment
		case TokenType.OP_INC:
		// postfix decrement
		case TokenType.OP_DEC:
		// assignments
		case TokenType.ASSIGN:
		case TokenType.ASSIGN_ADD:
		case TokenType.ASSIGN_BITWISE_AND:
		case TokenType.ASSIGN_BITWISE_OR:
		case TokenType.ASSIGN_BITWISE_XOR:
		case TokenType.ASSIGN_DIV:
		case TokenType.ASSIGN_MUL:
		case TokenType.ASSIGN_PERCENT:
		case TokenType.ASSIGN_SHIFT_LEFT:
		case TokenType.ASSIGN_SUB:
		case TokenType.OP_GT: // >>=
		// member access
		case TokenType.DOT:
		// pointer member access
		case TokenType.OP_PTR:
		// literal expression
		case TokenType.INTEGER_LITERAL:
		case TokenType.REAL_LITERAL:
			rollback (begin);
			return true;
		default:
			rollback (begin);
			return false;
		}
	}

	bool is_lambda_expression () {
		var begin = get_location ();

		switch (current ()) {
		case TokenType.OUT:
		case TokenType.REF:
			next ();
			if (accept (TokenType.IDENTIFIER) && accept (TokenType.LAMBDA)) {
				rollback (begin);
				return true;
			}
			break;
		case TokenType.IDENTIFIER:
			next ();
			if (accept (TokenType.LAMBDA)) {
				rollback (begin);
				return true;
			}
			break;
		case TokenType.OPEN_PARENS:
			next ();
			if (current () != TokenType.CLOSE_PARENS) {
				do {
					if (current () == TokenType.OUT || current () == TokenType.REF) {
						next ();
					}
					if (!accept (TokenType.IDENTIFIER)) {
						rollback (begin);
						return false;
					}
				} while (accept (TokenType.COMMA));
			}
			if (accept (TokenType.CLOSE_PARENS) && accept (TokenType.LAMBDA)) {
				rollback (begin);
				return true;
			}
			break;
		default:
			break;
		}

		rollback (begin);
		return false;
	}

	bool is_local_function () {
		var begin = get_location ();

		try {
			skip_modifier_keyword ();
			skip_type ();
			if (accept (TokenType.IDENTIFIER) && accept (TokenType.OPEN_PARENS)) {
				rollback (begin);
				return true;
			}
		} catch {
		}

		rollback (begin);
		return false;
	}

	Block parse_embedded_statement (string statement_name, bool accept_empty_body = true) throws ParseError {
		if (current () == TokenType.OPEN_BRACE) {
			var block = parse_block ();
			return block;
		}

		comment = scanner.pop_comment ();

		var block = new Block (get_src (get_location ()));

		try {
			var stmt = parse_embedded_statement_without_block (statement_name, accept_empty_body);
			block.add_statement (stmt);
		} catch (ParseError e) {
			if (context.keep_going) {
				report_parse_error (e);
			} else {
				throw e;
			}
		}
		block.source_reference.end = get_last_src ().end;

		return block;

	}

	Statement parse_embedded_statement_without_block (string statement_name, bool accept_empty_body) throws ParseError {
		switch (current ()) {
		case TokenType.SEMICOLON:
			if (!accept_empty_body) {
				Report.warning (get_current_src (), "%s-statement without body", statement_name);
			}
			return parse_empty_statement ();
		case TokenType.IF:
		case TokenType.SWITCH:
		case TokenType.WHILE:
		case TokenType.DO:
		case TokenType.FOR:
		case TokenType.FOREACH:
		case TokenType.BREAK:
		case TokenType.CONTINUE:
		case TokenType.RETURN:
		case TokenType.YIELD:
		case TokenType.THROW:
		case TokenType.TRY:
		case TokenType.LOCK:
		case TokenType.UNLOCK:
		case TokenType.DELETE:
		case TokenType.WITH:
			return parse_statement (current ());
		case TokenType.VAR:
		case TokenType.CONST:
			throw new ParseError.SYNTAX ("embedded statement cannot be declaration ");
		case TokenType.OP_INC:
		case TokenType.OP_DEC:
		case TokenType.BASE:
		case TokenType.THIS:
		case TokenType.OPEN_PARENS:
		case TokenType.STAR:
		case TokenType.NEW:
			return parse_expression_statement ();
		default:
			if (is_expression ()) {
				return parse_expression_statement ();
			} else {
				throw new ParseError.SYNTAX ("embedded statement cannot be declaration");
			}
		}
	}

	Block parse_block () throws ParseError {
		var begin = get_location ();
		expect (TokenType.OPEN_BRACE);
		var block = new Block (get_src (begin));
		parse_statements (block);
		if (!accept (TokenType.CLOSE_BRACE)) {
			// only report error if it's not a secondary error
			if (context.report.get_errors () == 0) {
				Report.error (get_current_src (), "expected `}'");
			}
		}

		block.source_reference.end = get_last_src ().end;

		return block;
	}

	Statement parse_empty_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.SEMICOLON);
		return new EmptyStatement (get_src (begin));
	}

	void parse_local_variable_declarations (Block block) throws ParseError {
		var begin = get_location ();
		DataType variable_type;
		bool is_dynamic = accept (TokenType.DYNAMIC);
		if (accept (TokenType.UNOWNED) && accept (TokenType.VAR)) {
			variable_type = new VarType (false);
			variable_type.nullable = accept (TokenType.INTERR);
			variable_type.is_dynamic = is_dynamic;
		} else {
			rollback (begin);
			is_dynamic = accept (TokenType.DYNAMIC);
			if (accept (TokenType.VAR)) {
				variable_type = new VarType ();
				variable_type.nullable = accept (TokenType.INTERR);
				variable_type.is_dynamic = is_dynamic;
			} else {
				rollback (begin);
				variable_type = parse_type (true, true);
			}
		}
		bool is_first = true;
		do {
			if (variable_type is VarType && variable_type.value_owned && accept (TokenType.OPEN_PARENS)) {
				// tuple
				begin = get_location ();

				string[] identifiers = {};
				do {
					identifiers += parse_identifier ();
				} while (accept (TokenType.COMMA));
				expect (TokenType.CLOSE_PARENS);

				expect (TokenType.ASSIGN);
				var tuple = parse_expression ();
				var tuple_local = new LocalVariable (null, CodeNode.get_temp_name (), tuple, get_src (begin));
				block.add_statement (new DeclarationStatement (tuple_local, tuple_local.source_reference));

				for (int i = 0; i < identifiers.length; i++) {
					var temp_access = new MemberAccess.simple (tuple_local.name, tuple_local.source_reference);
					var ea = new ElementAccess (temp_access, tuple_local.source_reference);
					ea.append_index (new IntegerLiteral (i.to_string ()));
					var local = new LocalVariable (null, identifiers[i], ea, tuple_local.source_reference);
					block.add_statement (new DeclarationStatement (local, local.source_reference));
				}

				continue;
			}

			if (!is_first) {
				begin = get_location ();
			} else {
				is_first = false;
			}

			DataType type_copy = null;
			if (variable_type != null) {
				type_copy = variable_type.copy ();
			}
			var local = parse_local_variable (type_copy);
			block.add_statement (new DeclarationStatement (local, get_src (begin)));
		} while (accept (TokenType.COMMA));
		expect (TokenType.SEMICOLON);
	}

	LocalVariable parse_local_variable (DataType? variable_type, bool expect_initializer = false) throws ParseError {
		var begin = get_location ();
		string id = parse_identifier ();
		var type = parse_inline_array_type (variable_type);
		var src = get_src (begin);

		Expression initializer = null;
		if (accept (TokenType.ASSIGN)) {
			initializer = parse_expression ();
		} else if (expect_initializer) {
			report_parse_error (new ParseError.SYNTAX ("expected initializer"));
			prev ();
			initializer = new InvalidExpression ();
		}
		return new LocalVariable (type, id, initializer, src);
	}

	void parse_local_constant_declarations (Block block) throws ParseError {
		var begin = get_location ();
		expect (TokenType.CONST);
		var constant_type = parse_type (false, false);

		// constant arrays don't own their element
		unowned ArrayType? array_type = constant_type as ArrayType;
		if (array_type != null) {
			array_type.element_type.value_owned = false;
		}

		bool is_first = true;
		do {
			if (!is_first) {
				begin = get_location ();
			} else {
				is_first = false;
			}

			DataType type_copy = constant_type.copy ();
			var local = parse_local_constant (type_copy);
			block.add_statement (new DeclarationStatement (local, get_src (begin)));
			block.add_local_constant (local);
			local.active = false;
		} while (accept (TokenType.COMMA));
		expect (TokenType.SEMICOLON);
	}

	Constant parse_local_constant (DataType constant_type) throws ParseError {
		var begin = get_location ();
		string id = parse_identifier ();
		var type = parse_inline_array_type (constant_type);
		var src = get_src (begin);

		expect (TokenType.ASSIGN);
		var initializer = parse_expression ();

		if (type.value_owned) {
			Report.error (src, "`owned' is not allowed on constants");
		}

		return new Constant (id, type, initializer, src);
	}

	void parse_local_function_declaration (Block block) throws ParseError {
		var begin = get_location ();
		var flags = parse_member_declaration_modifiers ("local functions", ModifierFlags.STATIC);
		var type = parse_type (true, false);
		var sym = parse_symbol_name ();

		expect (TokenType.OPEN_PARENS);
		List<Parameter> params = new ArrayList<Parameter> ();
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				params.add (parse_parameter ());
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_PARENS);

		var src = get_src (begin);

		var d = new Delegate ("_LocalFunc%i_".printf (next_local_func_id++), type, src);
		d.has_target = !(ModifierFlags.STATIC in flags);
		foreach (var param in params) {
			d.add_parameter (param);
		}
		context.root.add_delegate (d);

		var lambda = new LambdaExpression.with_statement_body (parse_block (), src);
		foreach (var p in params) {
			var param = new Parameter (p.name, null, p.source_reference);
			param.direction = p.direction;
			lambda.add_parameter (param);
		}

		if (!context.experimental) {
			Report.warning (src, "local functions are experimental");
		}

		var local = new LocalVariable (new DelegateType (d), sym.name, lambda, src);
		block.add_statement (new DeclarationStatement (local, src));
	}

	Statement parse_expression_statement () throws ParseError {
		var begin = get_location ();
		var expr = parse_statement_expression ();
		var src = get_src (begin);
		expect (TokenType.SEMICOLON);
		return new ExpressionStatement (expr, src);
	}

	Expression parse_statement_expression () throws ParseError {
		// invocation expression, assignment,
		// or pre/post increment/decrement expression
		var expr = parse_expression ();
		return expr;
	}

	Statement parse_if_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.IF);
		expect (TokenType.OPEN_PARENS);
		var condition = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		var src = get_src (begin);
		var true_stmt = parse_embedded_statement ("if", false);
		Block false_stmt = null;
		if (accept (TokenType.ELSE)) {
			false_stmt = parse_embedded_statement ("else", false);
		}
		return new IfStatement (condition, true_stmt, false_stmt, src);
	}

	Statement parse_switch_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.SWITCH);
		expect (TokenType.OPEN_PARENS);
		var condition = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		var stmt = new SwitchStatement (condition, get_src (begin));
		expect (TokenType.OPEN_BRACE);
		while (current () != TokenType.CLOSE_BRACE) {
			stmt.add_section ((SwitchSection) parse_switch_section_statement ());
		}
		expect (TokenType.CLOSE_BRACE);
		return stmt;
	}

	Statement parse_switch_section_statement () throws ParseError {
		var begin = get_location ();
		var section = new SwitchSection (get_src (begin));
		do {
			if (accept (TokenType.CASE)) {
				section.add_label (new SwitchLabel (parse_expression (), get_src (begin)));
				while (current () == TokenType.COMMA) {
					expect (TokenType.COMMA);
					section.add_label (new SwitchLabel (parse_expression (), get_src (begin)));
				}
				expect (TokenType.COLON);
			} else if (accept (TokenType.DEFAULT)) {
				section.add_label (new SwitchLabel.with_default (get_src (begin)));
				expect (TokenType.COLON);
			} else {
				throw new ParseError.SYNTAX ("expected `case' or `default' switch label");
			}
		} while (current () == TokenType.CASE || current () == TokenType.DEFAULT);
		parse_statements (section);
		return section;
	}

	Statement parse_while_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.WHILE);
		expect (TokenType.OPEN_PARENS);
		var condition = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		var body = parse_embedded_statement ("while");
		return new WhileStatement (condition, body, get_src (begin));
	}

	Statement parse_do_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.DO);
		var body = parse_embedded_statement ("do");
		expect (TokenType.WHILE);
		expect (TokenType.OPEN_PARENS);
		var condition = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		expect (TokenType.SEMICOLON);
		return new DoStatement (condition, body, get_src (begin));
	}

	Statement parse_for_statement () throws ParseError {
		var begin = get_location ();
		Block block = null;
		expect (TokenType.FOR);
		expect (TokenType.OPEN_PARENS);
		var initializer_list = new ArrayList<Expression> ();
		if (!accept (TokenType.SEMICOLON)) {
			bool is_expr;
			switch (current ()) {
			case TokenType.VAR:
				is_expr = false;
				break;
			case TokenType.OP_INC:
			case TokenType.OP_DEC:
				is_expr = true;
				break;
			default:
				is_expr = is_expression ();
				break;
			}

			if (is_expr) {
				do {
					initializer_list.add (parse_statement_expression ());
				} while (accept (TokenType.COMMA));
				expect (TokenType.SEMICOLON);
			} else {
				// variable declaration in initializer
				var decl_begin = get_location ();
				block = new Block (get_src (decl_begin));
				parse_local_variable_declarations (block);
				block.source_reference.end = get_last_src ().end;
			}
		}
		Expression condition = null;
		if (current () != TokenType.SEMICOLON) {
			condition = parse_expression ();
		}
		expect (TokenType.SEMICOLON);
		var iterator_list = new ArrayList<Expression> ();
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				iterator_list.add (parse_statement_expression ());
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_PARENS);
		var src = get_src (begin);
		var body = parse_embedded_statement ("for");
		var stmt = new ForStatement (condition, body, src);
		foreach (Expression init in initializer_list) {
			stmt.add_initializer (init);
		}
		foreach (Expression iter in iterator_list) {
			stmt.add_iterator (iter);
		}
		if (block != null) {
			block.add_statement (stmt);
			return block;
		} else {
			return stmt;
		}
	}

	Statement parse_foreach_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.FOREACH);
		expect (TokenType.OPEN_PARENS);
		var var_or_type = get_location ();
		DataType type;
		bool is_dynamic = accept (TokenType.DYNAMIC);
		if (accept (TokenType.UNOWNED) && accept (TokenType.VAR)) {
			type = new VarType (false);
			type.nullable = accept (TokenType.INTERR);
			type.is_dynamic = is_dynamic;
		} else {
			rollback (var_or_type);
			is_dynamic = accept (TokenType.DYNAMIC);
			if (accept (TokenType.VAR)) {
				type = new VarType ();
				type.nullable = accept (TokenType.INTERR);
				type.is_dynamic = is_dynamic;
			} else {
				rollback (var_or_type);
				type = parse_type (true, true);
				if (accept (TokenType.IN)) {
					Report.error (type.source_reference, "syntax error, expected `unowned var', `var' or type");
					throw new ParseError.SYNTAX ("expected `unowned var', `var' or type");
				}
			}
		}
		string id = parse_identifier ();
		expect (TokenType.IN);
		var collection = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		var src = get_src (begin);
		var body = parse_embedded_statement ("foreach");
		return new ForeachStatement (type, id, collection, body, src);
	}

	Statement parse_break_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.BREAK);
		var src = get_src (begin);
		expect (TokenType.SEMICOLON);
		return new BreakStatement (src);
	}

	Statement parse_continue_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.CONTINUE);
		var src = get_src (begin);
		expect (TokenType.SEMICOLON);
		return new ContinueStatement (src);
	}

	Statement parse_return_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.RETURN);
		Expression expr = null;
		if (current () != TokenType.SEMICOLON) {
			expr = parse_expression ();
		}
		var src = get_src (begin);
		expect (TokenType.SEMICOLON);
		return new ReturnStatement (expr, src);
	}

	Statement parse_yield_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.YIELD);
		var token = current ();
		if (token != TokenType.SEMICOLON) {
			// yield expression
			prev ();
			if (token == TokenType.RETURN) {
				throw new ParseError.SYNTAX ("expected `return yield'");
			}
			return parse_expression_statement ();
		}
		var src = get_src (begin);
		expect (TokenType.SEMICOLON);
		return new YieldStatement (src);
	}

	Statement parse_throw_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.THROW);
		var expr = parse_expression ();
		var src = get_src (begin);
		expect (TokenType.SEMICOLON);
		return new ThrowStatement (expr, src);
	}

	Statement parse_try_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.TRY);
		var try_block = parse_block ();
		Block finally_clause = null;
		var catch_clauses = new ArrayList<CatchClause> ();
		if (current () == TokenType.CATCH) {
			parse_catch_clauses (catch_clauses);
			if (current () == TokenType.FINALLY) {
				finally_clause = parse_finally_clause ();
			}
		} else if (current () == TokenType.FINALLY) {
			finally_clause = parse_finally_clause ();
		} else {
			report_parse_error (new ParseError.SYNTAX ("expected `catch' or `finally'"));
		}
		var stmt = new TryStatement (try_block, finally_clause, get_src (begin));
		foreach (CatchClause clause in catch_clauses) {
			stmt.add_catch_clause (clause);
		}
		return stmt;
	}

	void parse_catch_clauses (List<CatchClause> catch_clauses) throws ParseError {
		while (current () == TokenType.CATCH) {
			var begin = get_location ();
			expect (TokenType.CATCH);
			DataType type = null;
			string id = null;
			if (accept (TokenType.OPEN_PARENS)) {
				type = parse_type (true, true);
				id = parse_identifier ();
				expect (TokenType.CLOSE_PARENS);
			}
			var src = get_src (begin);
			var block = parse_block ();
			catch_clauses.add (new CatchClause (type, id, block, src));
		}
	}

	Block parse_finally_clause () throws ParseError {
		expect (TokenType.FINALLY);
		var block = parse_block ();
		return block;
	}

	Statement parse_lock_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.LOCK);
		expect (TokenType.OPEN_PARENS);
		var expr = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		var src = get_src (begin);
		Block? stmt = null;
		if (current () != TokenType.SEMICOLON) {
			stmt = parse_embedded_statement ("lock", false);
		}
		return new LockStatement (expr, stmt, src);
	}

	Statement parse_unlock_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.UNLOCK);
		expect (TokenType.OPEN_PARENS);
		var expr = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		var src = get_src (begin);
		expect (TokenType.SEMICOLON);
		return new UnlockStatement (expr, src);
	}

	Statement parse_delete_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.DELETE);
		var expr = parse_expression ();
		var src = get_src (begin);
		expect (TokenType.SEMICOLON);
		return new DeleteStatement (expr, src);
	}

	Statement? parse_with_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.WITH);
		expect (TokenType.OPEN_PARENS);
		var expr_or_decl = get_location ();

		LocalVariable? local = null;

		// Try "with (expr)"
		Expression expr;
		try {
			expr = parse_expression ();
		} catch {
			expr = null;
		}
		if (expr == null || !accept (TokenType.CLOSE_PARENS)) {
			// Try "with (var identifier = expr)"
			rollback (expr_or_decl);
			DataType variable_type;
			bool is_dynamic = accept (TokenType.DYNAMIC);
			if (accept (TokenType.UNOWNED) && accept (TokenType.VAR)) {
				variable_type = new VarType (false);
				variable_type.nullable = accept (TokenType.INTERR);
				variable_type.is_dynamic = is_dynamic;
			} else {
				rollback (expr_or_decl);
				is_dynamic = accept (TokenType.DYNAMIC);
				if (accept (TokenType.VAR)) {
					variable_type = new VarType ();
					variable_type.nullable = accept (TokenType.INTERR);
					variable_type.is_dynamic = is_dynamic;
				} else {
					variable_type = parse_type (true, true);
				}
			}
			local = parse_local_variable (variable_type, true);
			expr = local.initializer;
			expect (TokenType.CLOSE_PARENS);
		}

		var src = get_src (begin);
		if (!context.experimental) {
			Report.warning (src, "`with' statements are experimental");
		}
		var body = parse_embedded_statement ("with", false);
		return new WithStatement (local, expr, body, src);
	}

	string parse_attribute_value () throws ParseError {
		switch (current ()) {
		case TokenType.NULL:
		case TokenType.TRUE:
		case TokenType.FALSE:
		case TokenType.INTEGER_LITERAL:
		case TokenType.REAL_LITERAL:
		case TokenType.STRING_LITERAL:
			next ();
			return get_last_string ();
		case TokenType.MINUS:
			next ();
			switch (current ()) {
			case TokenType.INTEGER_LITERAL:
			case TokenType.REAL_LITERAL:
				next ();
				return "-" + get_last_string ();
			default:
				throw new ParseError.SYNTAX ("expected number");
			}
		default:
			throw new ParseError.SYNTAX ("expected literal");
		}
	}

	List<Attribute>? parse_attributes () throws ParseError {
		if (current () != TokenType.OPEN_BRACKET) {
			return null;
		}
		var attrs = new ArrayList<Attribute> ();
		while (accept (TokenType.OPEN_BRACKET)) {
			do {
				var begin = get_location ();
				string id = parse_identifier ();
				var attr = new Attribute (id, get_src (begin));
				if (accept (TokenType.OPEN_PARENS)) {
					if (current () != TokenType.CLOSE_PARENS) {
						do {
							id = parse_identifier ();
							expect (TokenType.ASSIGN);
							attr.add_argument (id, parse_attribute_value ());
						} while (accept (TokenType.COMMA));
					}
					expect (TokenType.CLOSE_PARENS);
				}
				attrs.add (attr);
			} while (accept (TokenType.COMMA));
			expect (TokenType.CLOSE_BRACKET);
		}
		return attrs;
	}

	void set_attributes (CodeNode node, List<Attribute>? attributes) {
		if (attributes != null) {
			foreach (Attribute attr in (List<Attribute>) attributes) {
				if (node.has_attribute (attr.name)) {
					Report.error (attr.source_reference, "duplicate attribute `%s'", attr.name);
				}
				node.attributes.append (attr);
			}
		}
	}

	void parse_main_block (Symbol parent) throws ParseError {
		var begin = get_location ();

		var method = new Method.main_block (new SourceReference (scanner.source_file, begin, begin));
		method.access = SymbolAccessibility.PUBLIC;
		method.binding = MemberBinding.STATIC;
		method.body = new Block (get_src (begin));
		parse_statements (method.body);
		if (current () != TokenType.EOF) {
			Report.error (get_current_src (), "expected end of file");
		}

		method.body.source_reference.end = get_current_src ().end;

		if (!context.experimental) {
			Report.warning (method.source_reference, "main blocks are experimental");
		}

		parent.add_method (method);
	}

	void parse_declaration (Symbol parent, bool root = false) throws ParseError {
		comment = scanner.pop_comment ();
		var attrs = parse_attributes ();

		var begin = get_location ();

		TokenType last_keyword = current ();

		while (is_declaration_keyword (current ())) {
			last_keyword = current ();
			next ();
		}

		switch (current ()) {
		case TokenType.CONSTRUCT:
			if (context.profile == Profile.GOBJECT) {
				rollback (begin);
				if (!(parent is TypeSymbol)) {
					throw new ParseError.SYNTAX ("unexpected `construct' declaration");
				}
				parse_constructor_declaration (parent, attrs);
				return;
			}
			break;
		case TokenType.TILDE:
			rollback (begin);
			if (!(parent is TypeSymbol)) {
				throw new ParseError.SYNTAX ("unexpected `destructor' declaration");
			}
			parse_destructor_declaration (parent, attrs);
			return;
		case TokenType.OPEN_BRACE:
		case TokenType.SEMICOLON:
		case TokenType.IF:
		case TokenType.SWITCH:
		case TokenType.WHILE:
		case TokenType.DO:
		case TokenType.FOR:
		case TokenType.FOREACH:
		case TokenType.BREAK:
		case TokenType.CONTINUE:
		case TokenType.RETURN:
		case TokenType.YIELD:
		case TokenType.THROW:
		case TokenType.TRY:
		case TokenType.LOCK:
		case TokenType.UNLOCK:
		case TokenType.DELETE:
		case TokenType.VAR:
		case TokenType.OP_INC:
		case TokenType.OP_DEC:
		case TokenType.BASE:
		case TokenType.THIS:
		case TokenType.STAR:
		case TokenType.NEW:
			// statement
			if (attrs != null) {
				// no attributes allowed before statements
				throw new ParseError.SYNTAX ("expected statement");
			}
			if (!root) {
				throw new ParseError.SYNTAX ("statements outside blocks allowed only in root namespace");
			}
			rollback (begin);
			parse_main_block (parent);
			return;
		default:
			if (root) {
				bool is_expr = is_expression ();
				if (is_expr) {
					rollback (begin);
					parse_main_block (parent);
					return;
				}
			}

			skip_type ();
			switch (current ()) {
			case TokenType.OPEN_BRACE:
			case TokenType.SEMICOLON:
			case TokenType.COLON:
				rollback (begin);
				switch (last_keyword) {
				case TokenType.CLASS:
					parse_class_declaration (parent, attrs);
					return;
				case TokenType.ENUM:
					parse_enum_declaration (parent, attrs);
					return;
				case TokenType.ERRORDOMAIN:
					parse_errordomain_declaration (parent, attrs);
					return;
				case TokenType.INTERFACE:
					parse_interface_declaration (parent, attrs);
					return;
				case TokenType.NAMESPACE:
					parse_namespace_declaration (parent, attrs);
					return;
				case TokenType.STRUCT:
					parse_struct_declaration (parent, attrs);
					return;
				default:
					break;
				}
				break;
			case TokenType.OPEN_PARENS:
				rollback (begin);
				if (!(parent is TypeSymbol)) {
					throw new ParseError.SYNTAX ("unexpected `constructor' declaration");
				}
				parse_creation_method_declaration (parent, attrs);
				return;
			default:
				skip_type (); // might contain type parameter list
				switch (current ()) {
				case TokenType.OPEN_PARENS:
					rollback (begin);
					switch (last_keyword) {
					case TokenType.DELEGATE:
						parse_delegate_declaration (parent, attrs);
						return;
					case TokenType.SIGNAL:
						if (!(parent is ObjectTypeSymbol)) {
							throw new ParseError.SYNTAX ("unexpected `signal' declaration");
						}
						parse_signal_declaration (parent, attrs);
						return;
					default:
						parse_method_declaration (parent, attrs);
						return;
					}
				case TokenType.ASSIGN:
				case TokenType.COMMA:
				case TokenType.SEMICOLON:
					rollback (begin);
					switch (last_keyword) {
					case TokenType.CONST:
						parse_constant_declaration (parent, attrs);
						return;
					default:
						parse_field_declaration (parent, attrs);
						return;
					}
				case TokenType.OPEN_BRACE:
				case TokenType.THROWS:
					rollback (begin);
					if (!(parent is TypeSymbol)) {
						throw new ParseError.SYNTAX ("unexpected `property' declaration");
					}
					parse_property_declaration (parent, attrs);
					return;
				default:
					break;
				}
				break;
			}
			break;
		}

		rollback (begin);

		throw new ParseError.SYNTAX ("expected declaration");
	}

	void parse_declarations (Symbol parent, bool root = false) throws ParseError {
		if (!root) {
			expect (TokenType.OPEN_BRACE);
		}
		while (current () != TokenType.CLOSE_BRACE && current () != TokenType.EOF) {
			try {
				parse_declaration (parent, (parent == context.root));
			} catch (ParseError e) {
				report_parse_error (e);
				int r;
				do {
					r = recover ();
					if (r == RecoveryState.STATEMENT_BEGIN) {
						next ();
					} else {
						break;
					}
				} while (true);
				if (r == RecoveryState.EOF) {
					return;
				}
			}
		}
		if (!root) {
			if (!accept (TokenType.CLOSE_BRACE)) {
				// only report error if it's not a secondary error
				if (context.report.get_errors () == 0) {
					Report.error (get_current_src (), "expected `}'");
				}
			}
		}
	}

	enum RecoveryState {
		EOF,
		DECLARATION_BEGIN,
		STATEMENT_BEGIN
	}

	RecoveryState recover () {
		while (current () != TokenType.EOF) {
			switch (current ()) {
			case TokenType.ABSTRACT:
			case TokenType.CLASS:
			case TokenType.CONST:
			case TokenType.CONSTRUCT:
			case TokenType.DELEGATE:
			case TokenType.ENUM:
			case TokenType.ERRORDOMAIN:
			case TokenType.EXTERN:
			case TokenType.INLINE:
			case TokenType.INTERFACE:
			case TokenType.INTERNAL:
			case TokenType.NAMESPACE:
			case TokenType.NEW:
			case TokenType.OVERRIDE:
			case TokenType.PARTIAL:
			case TokenType.PRIVATE:
			case TokenType.PROTECTED:
			case TokenType.PUBLIC:
			case TokenType.SEALED:
			case TokenType.SIGNAL:
			case TokenType.STATIC:
			case TokenType.STRUCT:
			case TokenType.VIRTUAL:
			case TokenType.VOLATILE:
				return RecoveryState.DECLARATION_BEGIN;
			case TokenType.BREAK:
			case TokenType.CONTINUE:
			case TokenType.DELETE:
			case TokenType.DO:
			case TokenType.FOR:
			case TokenType.FOREACH:
			case TokenType.IF:
			case TokenType.LOCK:
			case TokenType.RETURN:
			case TokenType.SWITCH:
			case TokenType.THROW:
			case TokenType.TRY:
			case TokenType.UNLOCK:
			case TokenType.VAR:
			case TokenType.WHILE:
			case TokenType.WITH:
			case TokenType.YIELD:
				return RecoveryState.STATEMENT_BEGIN;
			default:
				next ();
				break;
			}
		}
		return RecoveryState.EOF;
	}

	void parse_namespace_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		expect (TokenType.NAMESPACE);
		var sym = parse_symbol_name ();
		var ns = new Namespace (sym.name, get_src (begin));
		if (comment != null) {
			ns.add_comment (comment);
			comment = null;
		}

		set_attributes (ns, attrs);

		expect (TokenType.OPEN_BRACE);

		var old_using_directives = scanner.source_file.current_using_directives;
		parse_using_directives (ns);

		parse_declarations (ns, true);

		scanner.source_file.current_using_directives = old_using_directives;

		if (!accept (TokenType.CLOSE_BRACE)) {
			// only report error if it's not a secondary error
			if (context.report.get_errors () == 0) {
				Report.error (get_current_src (), "expected `}'");
			}
		}

		Symbol result = ns;
		while (sym != null) {
			sym = sym.inner;

			Symbol next = (sym != null ? new Namespace (sym.name, ns.source_reference) : parent);
			next.add_namespace ((Namespace) result);
			result = next;
		}
	}

	void parse_using_directives (Namespace ns) throws ParseError {
		while (accept (TokenType.USING)) {
			do {
				var begin = get_location ();
				var sym = parse_symbol_name ();
				var ns_ref = new UsingDirective (sym, get_src (begin));
				scanner.source_file.add_using_directive (ns_ref);
				ns.add_using_directive (ns_ref);
			} while (accept (TokenType.COMMA));
			expect (TokenType.SEMICOLON);
		}
	}

	void parse_class_declaration (Symbol parent, List<Attribute>? attrs, bool partial_reparse = false) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_type_declaration_modifiers ("classes", ModifierFlags.ABSTRACT | ModifierFlags.EXTERN | ModifierFlags.PARTIAL | ModifierFlags.SEALED);
		expect (TokenType.CLASS);
		var sym = parse_symbol_name ();
		var type_param_list = parse_type_parameter_list ();
		var base_types = new ArrayList<DataType> ();
		if (accept (TokenType.COLON)) {
			do {
				base_types.add (parse_type (true, false));
			} while (accept (TokenType.COMMA));
		}

		var cl = new Class (sym.name, get_src (begin), comment);
		cl.access = access;
		if (ModifierFlags.ABSTRACT in flags) {
			cl.is_abstract = true;
		}
		if (ModifierFlags.SEALED in flags) {
			cl.is_sealed = true;
		}
		if (ModifierFlags.PARTIAL in flags) {
			if (!context.experimental) {
				Report.warning (cl.source_reference, "`partial' classes are experimental");
			}
			cl.is_partial = true;
		}
		if (ModifierFlags.EXTERN in flags) {
			cl.is_extern = true;
		}

		Class? old_cl = null;
		if (partial_reparse) {
			var names = new ArrayList<string> ();
			while (sym.inner != null) {
				sym = sym.inner;
				names.insert (0, sym.name);
			}
			Symbol p = parent;
			while (p != null && p != context.root) {
				names.insert (0, p.name);
				p = p.parent_symbol;
			}
			p = context.root;
			foreach (var name in names) {
				p = p.scope.lookup (name);
				if (p == null) {
					break;
				}
			}
			if (p != null) {
				old_cl = p.scope.lookup (cl.name) as Class;
				parent = p;
			}
		}
		if (old_cl != null && old_cl.is_partial) {
			if (cl.is_partial != old_cl.is_partial) {
				Report.error (cl.source_reference, "conflicting partial and not partial declarations of `%s'", cl.name);
				cl.error = true;
			}
			if (cl.access != old_cl.access) {
				Report.error (cl.source_reference, "partial declarations of `%s' have conflicting accessiblity modifiers", cl.name);
				cl.error = true;
			}
			if (cl.is_abstract != old_cl.is_abstract) {
				Report.error (cl.source_reference, "partial declarations of `%s' have conflicting abstract modifiers", cl.name);
				cl.error = true;
			}
			if (cl.is_sealed != old_cl.is_sealed) {
				Report.error (cl.source_reference, "partial declarations of `%s' have conflicting sealed modifiers", cl.name);
				cl.error = true;
			}
			if (cl.error) {
				Report.notice (old_cl.source_reference, "previous declaration of `%s' was here", old_cl.name);
				return;
			}

			cl = old_cl;
		}

		set_attributes (cl, attrs);
		foreach (TypeParameter type_param in type_param_list) {
			cl.add_type_parameter (type_param);
		}
		foreach (DataType base_type in base_types) {
			cl.add_base_type (base_type);
		}

		parse_declarations (cl);

		if (old_cl != null && old_cl.is_partial) {
			return;
		}

		// ensure there is always a default construction method
		if (scanner.source_file.file_type == SourceFileType.SOURCE
		    && cl.default_construction_method == null) {
			var m = new CreationMethod (cl.name, null, cl.source_reference);
			m.access = (cl.is_abstract ? SymbolAccessibility.PROTECTED : SymbolAccessibility.PUBLIC);
			m.body = new Block (cl.source_reference);
			cl.add_method (m);
		}

		if (partial_reparse) {
			parent.add_class (cl);
			return;
		}

		Symbol result = cl;
		while (sym != null) {
			sym = sym.inner;

			Symbol next = (sym != null ? new Namespace (sym.name, cl.source_reference) : parent);
			if (result is Namespace) {
				next.add_namespace ((Namespace) result);
			} else if (!partial_reparse && cl.is_partial) {
				PartialInfo info = { parent, begin, attrs };
				partials += info;
			} else if (!cl.is_partial) {
				next.add_class ((Class) result);
			}
			result = next;
		}
	}

	void parse_constant_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_member_declaration_modifiers ("constants", ModifierFlags.EXTERN | ModifierFlags.NEW);
		expect (TokenType.CONST);
		var type = parse_type (false, false);
		string id = parse_identifier ();

		type = parse_inline_array_type (type);
		var src = get_src (begin);

		// constant arrays don't own their element
		unowned ArrayType? array_type = type as ArrayType;
		if (array_type != null) {
			array_type.element_type.value_owned = false;
		}

		Expression? initializer = null;
		if (accept (TokenType.ASSIGN)) {
			initializer = parse_expression ();
		}
		expect (TokenType.SEMICOLON);

		var c = new Constant (id, type, initializer, src, comment);
		c.access = access;
		if (ModifierFlags.EXTERN in flags) {
			c.is_extern = true;
		}
		if (ModifierFlags.NEW in flags) {
			c.hides = true;
		}
		set_attributes (c, attrs);

		if (type.value_owned) {
			Report.error (c.source_reference, "`owned' is not allowed on constants");
		}

		parent.add_constant (c);
	}

	void parse_field_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ((parent is Struct) ? SymbolAccessibility.PUBLIC : SymbolAccessibility.PRIVATE);
		var flags = parse_member_declaration_modifiers ("fields", ModifierFlags.CLASS | ModifierFlags.EXTERN | ModifierFlags.NEW | ModifierFlags.STATIC );
		var type = parse_type (true, true);
		do {
			string id = parse_identifier ();
			var ftype = parse_inline_array_type (type.copy ());

			var f = new Field (id, ftype, null, get_src (begin), comment);
			f.access = access;

			set_attributes (f, attrs);
			if (ModifierFlags.STATIC in flags && ModifierFlags.CLASS in flags) {
				Report.error (f.source_reference, "only one of `static' or `class' may be specified");
			} else if (ModifierFlags.STATIC in flags) {
				f.binding = MemberBinding.STATIC;
			} else if (ModifierFlags.CLASS in flags) {
				f.binding = MemberBinding.CLASS;
			} else if (parent is Namespace) {
				// default to static member binding in namespace
				f.binding = MemberBinding.STATIC;
			}

			if (!parent.external_package && parent is Struct
				&& f.access != SymbolAccessibility.PUBLIC && f.binding == MemberBinding.INSTANCE) {
				Report.warning (f.source_reference, "accessibility of struct fields can only be `public`");
			}

			if (ModifierFlags.EXTERN in flags) {
				f.is_extern = true;
			}
			if (ModifierFlags.NEW in flags) {
				f.hides = true;
			}
			if (accept (TokenType.ASSIGN)) {
				f.initializer = parse_expression ();
			}

			parent.add_field (f);
		} while (accept (TokenType.COMMA));
		expect (TokenType.SEMICOLON);
	}

	InitializerList parse_initializer () throws ParseError {
		var begin = get_location ();
		expect (TokenType.OPEN_BRACE);
		var initializer = new InitializerList (get_src (begin));
		while (current () != TokenType.CLOSE_BRACE) {
			try {
				initializer.append (parse_argument ());
			} catch (ParseError e) {
				if (current () == TokenType.CLOSE_BRACE) {
					prev ();
					report_parse_error (new ParseError.SYNTAX ("incomplete initializer"));
				} else if (context.keep_going) {
					report_parse_error (e);
				} else {
					throw e;
				}
			}

			if (!accept (TokenType.COMMA)) {
				break;
			}
		}
		expect (TokenType.CLOSE_BRACE);
		initializer.source_reference = get_src (begin);
		return initializer;
	}

	void parse_method_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_member_declaration_modifiers ("methods", ModifierFlags.ABSTRACT | ModifierFlags.ASYNC | ModifierFlags.CLASS | ModifierFlags.EXTERN | ModifierFlags.NEW | ModifierFlags.INLINE | ModifierFlags.OVERRIDE | ModifierFlags.STATIC | ModifierFlags.VIRTUAL);
		var type = parse_type (true, false);
		var sym = parse_symbol_name ();
		var type_param_list = parse_type_parameter_list ();
		var method = new Method (sym.name, type, get_src (begin), comment);
		if (sym.inner != null) {
			method.base_interface_type = new UnresolvedType.from_symbol (sym.inner, sym.inner.source_reference);
		}
		method.access = access;
		set_attributes (method, attrs);
		foreach (TypeParameter type_param in type_param_list) {
			method.add_type_parameter (type_param);
		}
		if (ModifierFlags.STATIC in flags && ModifierFlags.CLASS in flags) {
			Report.error (method.source_reference, "only one of `static' or `class' may be specified");
		} else if (ModifierFlags.STATIC in flags) {
			method.binding = MemberBinding.STATIC;
		} else if (ModifierFlags.CLASS in flags) {
			method.binding = MemberBinding.CLASS;
		} else if (parent is Namespace) {
			// default to static member binding in namespace
			method.binding = MemberBinding.STATIC;
		}
		if (ModifierFlags.ASYNC in flags) {
			method.coroutine = true;
		}
		if (ModifierFlags.NEW in flags) {
			method.hides = true;
		}

		if (method.binding == MemberBinding.INSTANCE) {
			if (ModifierFlags.ABSTRACT in flags) {
				method.is_abstract = true;
			}
			if (ModifierFlags.VIRTUAL in flags) {
				method.is_virtual = true;
			}
			if (ModifierFlags.OVERRIDE in flags) {
				method.overrides = true;
			}
			if ((method.is_abstract && method.is_virtual)
			    || (method.is_abstract && method.overrides)
			    || (method.is_virtual && method.overrides)) {
				throw new ParseError.SYNTAX ("only one of `abstract', `virtual', or `override' may be specified");
			}
		} else {
			if (ModifierFlags.ABSTRACT in flags
			    || ModifierFlags.VIRTUAL in flags
			    || ModifierFlags.OVERRIDE in flags) {
				throw new ParseError.SYNTAX ("the modifiers `abstract', `virtual', and `override' are not valid for %s methods", (ModifierFlags.CLASS in flags) ? "class" : "static");
			}
		}

		if (ModifierFlags.INLINE in flags) {
			method.is_inline = true;
		}
		if (ModifierFlags.EXTERN in flags) {
			method.is_extern = true;
		}
		expect (TokenType.OPEN_PARENS);
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				var param = parse_parameter ();
				method.add_parameter (param);
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_PARENS);
		if (accept (TokenType.THROWS)) {
			do {
				method.add_error_type (parse_type (true, false));
			} while (accept (TokenType.COMMA));
		}
		while (accept (TokenType.REQUIRES)) {
			expect (TokenType.OPEN_PARENS);
			method.add_precondition (parse_expression ());
			expect (TokenType.CLOSE_PARENS);
		}
		while (accept (TokenType.ENSURES)) {
			expect (TokenType.OPEN_PARENS);
			method.add_postcondition (parse_expression ());
			expect (TokenType.CLOSE_PARENS);
		}
		if (!accept (TokenType.SEMICOLON)) {
			method.body = parse_block ();
			method.external = false;
		}

		parent.add_method (method);
	}

	void parse_property_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_member_declaration_modifiers ("properties", ModifierFlags.ABSTRACT | ModifierFlags.CLASS | ModifierFlags.EXTERN | ModifierFlags.NEW | ModifierFlags.OVERRIDE | ModifierFlags.STATIC | ModifierFlags.VIRTUAL);
		var type = parse_type (true, true);
		string id = parse_identifier ();
		var prop = new Property (id, type, null, null, get_src (begin), comment);
		prop.access = access;
		set_attributes (prop, attrs);
		if (ModifierFlags.STATIC in flags && ModifierFlags.CLASS in flags) {
			Report.error (prop.source_reference, "only one of `static' or `class' may be specified");
		} else if (ModifierFlags.STATIC in flags) {
			prop.binding = MemberBinding.STATIC;
		} else if (ModifierFlags.CLASS in flags) {
			prop.binding = MemberBinding.CLASS;
		}
		if (ModifierFlags.ABSTRACT in flags) {
			prop.is_abstract = true;
		}
		if (ModifierFlags.VIRTUAL in flags) {
			prop.is_virtual = true;
		}
		if (ModifierFlags.OVERRIDE in flags) {
			prop.overrides = true;
		}
		if (ModifierFlags.NEW in flags) {
			prop.hides = true;
		}
		if (ModifierFlags.EXTERN in flags) {
			prop.is_extern = true;
		}
		if ((prop.is_abstract && prop.is_virtual)
			|| (prop.is_abstract && prop.overrides)
			|| (prop.is_virtual && prop.overrides)) {
			throw new ParseError.SYNTAX ("only one of `abstract', `virtual', or `override' may be specified");
		}

		if (accept (TokenType.THROWS)) {
			do {
				parse_type (true, false);
			} while (accept (TokenType.COMMA));
			Report.error (prop.source_reference, "properties throwing errors are not supported yet");
		}
		expect (TokenType.OPEN_BRACE);
		while (current () != TokenType.CLOSE_BRACE) {
			if (accept (TokenType.DEFAULT)) {
				if (prop.initializer != null) {
					throw new ParseError.SYNTAX ("property default value already defined");
				}
				expect (TokenType.ASSIGN);
				prop.initializer = parse_expression ();
				expect (TokenType.SEMICOLON);
			} else {
				comment = scanner.pop_comment ();

				var accessor_begin = get_location ();
				var accessor_attrs = parse_attributes ();
				var accessor_access = parse_access_modifier (SymbolAccessibility.PUBLIC);

				var value_type = type.copy ();
				if (accept (TokenType.OWNED)) {
					value_type.value_owned = true;
				} else {
					value_type.value_owned = false;
					if (accept (TokenType.UNOWNED)) {
						Report.warning (get_last_src (), "property getters are `unowned' by default");
					}
				}

				if (accept (TokenType.GET)) {
					if (prop.get_accessor != null) {
						throw new ParseError.SYNTAX ("property get accessor already defined");
					}

					Block block = null;
					if (!accept (TokenType.SEMICOLON)) {
						block = parse_block ();
						prop.external = false;
					}
					prop.get_accessor = new PropertyAccessor (true, false, false, value_type, block, get_src (accessor_begin), comment);
					set_attributes (prop.get_accessor, accessor_attrs);
					prop.get_accessor.access = accessor_access;
				} else {
					bool writable, _construct;
					if (accept (TokenType.SET)) {
						writable = true;
						_construct = (context.profile == Profile.GOBJECT) && accept (TokenType.CONSTRUCT);
					} else if (context.profile == Profile.GOBJECT && accept (TokenType.CONSTRUCT)) {
						_construct = true;
						writable = accept (TokenType.SET);
					} else {
						throw new ParseError.SYNTAX ("expected get, set, or construct");
					}
					if (prop.set_accessor != null) {
						throw new ParseError.SYNTAX ("property set accessor already defined");
					}
					Block block = null;
					if (!accept (TokenType.SEMICOLON)) {
						block = parse_block ();
						prop.external = false;
					}
					prop.set_accessor = new PropertyAccessor (false, writable, _construct, value_type, block, get_src (accessor_begin), comment);
					set_attributes (prop.set_accessor, accessor_attrs);
					prop.set_accessor.access = accessor_access;
				}
			}
		}
		expect (TokenType.CLOSE_BRACE);

		parent.add_property (prop);
	}

	void parse_signal_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_member_declaration_modifiers ("signals", ModifierFlags.NEW | ModifierFlags.VIRTUAL);
		expect (TokenType.SIGNAL);
		var type = parse_type (true, false);
		string id = parse_identifier ();
		var sig = new Signal (id, type, get_src (begin), comment);
		sig.access = access;
		set_attributes (sig, attrs);
		if (ModifierFlags.VIRTUAL in flags) {
			sig.is_virtual = true;
		}
		if (ModifierFlags.NEW in flags) {
			sig.hides = true;
		}
		expect (TokenType.OPEN_PARENS);
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				var param = parse_parameter ();
				sig.add_parameter (param);
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_PARENS);
		if (!accept (TokenType.SEMICOLON)) {
			sig.body = parse_block ();
		}

		parent.add_signal (sig);
	}

	void parse_constructor_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var flags = parse_member_declaration_modifiers ("constructors", ModifierFlags.CLASS | ModifierFlags.STATIC);
		expect (TokenType.CONSTRUCT);
		var c = new Constructor (get_src (begin));
		if (ModifierFlags.STATIC in flags && ModifierFlags.CLASS in flags) {
			Report.error (c.source_reference, "only one of `static' or `class' may be specified");
		} else if (ModifierFlags.STATIC in flags) {
			c.binding = MemberBinding.STATIC;
		} else if (ModifierFlags.CLASS in flags) {
			c.binding = MemberBinding.CLASS;
		}
		c.body = parse_block ();

		parent.add_constructor (c);
	}

	void parse_destructor_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var flags = parse_member_declaration_modifiers ("destructors", ModifierFlags.CLASS | ModifierFlags.STATIC);
		expect (TokenType.TILDE);
		string identifier = parse_identifier ();
		expect (TokenType.OPEN_PARENS);
		expect (TokenType.CLOSE_PARENS);
		var d = new Destructor (get_src (begin));
		if (identifier != parent.name) {
			Report.error (d.source_reference, "destructor and parent symbol name do not match");
		}
		if (ModifierFlags.STATIC in flags && ModifierFlags.CLASS in flags) {
			Report.error (d.source_reference, "only one of `static' or `class' may be specified");
		} else if (ModifierFlags.STATIC in flags) {
			d.binding = MemberBinding.STATIC;
		} else if (ModifierFlags.CLASS in flags) {
			d.binding = MemberBinding.CLASS;
		}
		d.body = parse_block ();

		parent.add_destructor (d);
	}

	void parse_struct_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_type_declaration_modifiers ("structs", ModifierFlags.EXTERN);
		expect (TokenType.STRUCT);
		var sym = parse_symbol_name ();
		var type_param_list = parse_type_parameter_list ();
		DataType base_type = null;
		if (accept (TokenType.COLON)) {
			base_type = parse_type (true, false);
		}
		var st = new Struct (sym.name, get_src (begin), comment);
		st.access = access;
		if (ModifierFlags.EXTERN in flags) {
			st.is_extern = true;
		}
		set_attributes (st, attrs);
		foreach (TypeParameter type_param in type_param_list) {
			st.add_type_parameter (type_param);
		}
		if (base_type != null) {
			st.base_type = base_type;
		}

		parse_declarations (st);

		Symbol result = st;
		while (sym != null) {
			sym = sym.inner;

			Symbol next = (sym != null ? new Namespace (sym.name, st.source_reference) : parent);
			if (result is Namespace) {
				next.add_namespace ((Namespace) result);
			} else {
				next.add_struct ((Struct) result);
			}
			result = next;
		}
	}

	void parse_interface_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_type_declaration_modifiers ("interfaces", ModifierFlags.EXTERN);
		expect (TokenType.INTERFACE);
		var sym = parse_symbol_name ();
		var type_param_list = parse_type_parameter_list ();
		var base_types = new ArrayList<DataType> ();
		if (accept (TokenType.COLON)) {
			do {
				var type = parse_type (true, false);
				base_types.add (type);
			} while (accept (TokenType.COMMA));
		}
		var iface = new Interface (sym.name, get_src (begin), comment);
		iface.access = access;
		if (ModifierFlags.EXTERN in flags) {
			iface.is_extern = true;
		}
		set_attributes (iface, attrs);
		foreach (TypeParameter type_param in type_param_list) {
			iface.add_type_parameter (type_param);
		}
		foreach (DataType base_type in base_types) {
			iface.add_prerequisite (base_type);
		}

		parse_declarations (iface);

		Symbol result = iface;
		while (sym != null) {
			sym = sym.inner;

			Symbol next = (sym != null ? new Namespace (sym.name, iface.source_reference) : parent);
			if (result is Namespace) {
				next.add_namespace ((Namespace) result);
			} else {
				next.add_interface ((Interface) result);
			}
			result = next;
		}
	}

	void parse_enum_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_type_declaration_modifiers ("enums", ModifierFlags.EXTERN);
		expect (TokenType.ENUM);
		var sym = parse_symbol_name ();
		var en = new Enum (sym.name, get_src (begin), comment);
		en.access = access;
		if (ModifierFlags.EXTERN in flags) {
			en.is_extern = true;
		}
		set_attributes (en, attrs);

		expect (TokenType.OPEN_BRACE);
		var inner_begin = get_location ();
		try {
			// enum methods
			while (current () != TokenType.CLOSE_BRACE) {
				parse_declaration (en);
			}
		} catch (ParseError e) {
			rollback (inner_begin);
		}
		do {
			if (current () == TokenType.CLOSE_BRACE) {
				break;
			}
			var value_attrs = parse_attributes ();
			var value_begin = get_location ();
			string id = parse_identifier ();
			if (comment == null) {
				comment = scanner.pop_comment ();
			}

			Expression value = null;
			if (accept (TokenType.ASSIGN)) {
				value = parse_expression ();
			}

			var ev = new EnumValue (id, value, get_src (value_begin), comment);
			ev.access = SymbolAccessibility.PUBLIC;
			set_attributes (ev, value_attrs);
			en.add_value (ev);
			comment = null;
		} while (accept (TokenType.COMMA));
		if (accept (TokenType.SEMICOLON)) {
			// enum methods
			while (current () != TokenType.CLOSE_BRACE) {
				parse_declaration (en);
			}
		}
		expect (TokenType.CLOSE_BRACE);

		Symbol result = en;
		while (sym != null) {
			sym = sym.inner;

			Symbol next = (sym != null ? new Namespace (sym.name, en.source_reference) : parent);
			if (result is Namespace) {
				next.add_namespace ((Namespace) result);
			} else {
				next.add_enum ((Enum) result);
			}
			result = next;
		}
	}

	void parse_errordomain_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_type_declaration_modifiers ("errordomains", ModifierFlags.EXTERN);
		expect (TokenType.ERRORDOMAIN);
		var sym = parse_symbol_name ();
		var ed = new ErrorDomain (sym.name, get_src (begin), comment);
		ed.access = access;
		if (ModifierFlags.EXTERN in flags) {
			ed.is_extern = true;
		}
		set_attributes (ed, attrs);

		expect (TokenType.OPEN_BRACE);
		var inner_begin = get_location ();
		try {
			// errordomain methods
			while (current () != TokenType.CLOSE_BRACE) {
				parse_declaration (ed);
			}
		} catch (ParseError e) {
			rollback (inner_begin);
		}
		do {
			if (current () == TokenType.CLOSE_BRACE) {
				break;
			}
			var code_attrs = parse_attributes ();
			var code_begin = get_location ();
			string id = parse_identifier ();
			if (comment == null) {
				comment = scanner.pop_comment ();
			}

			var ec = new ErrorCode (id, get_src (code_begin), comment);
			ec.access = SymbolAccessibility.PUBLIC;
			set_attributes (ec, code_attrs);
			if (accept (TokenType.ASSIGN)) {
				ec.value = parse_expression ();
			}
			ed.add_code (ec);
			comment = null;
		} while (accept (TokenType.COMMA));
		if (accept (TokenType.SEMICOLON)) {
			// errordomain methods
			while (current () != TokenType.CLOSE_BRACE) {
				parse_declaration (ed);
			}
		}
		expect (TokenType.CLOSE_BRACE);

		Symbol result = ed;
		while (sym != null) {
			sym = sym.inner;

			Symbol next = (sym != null ? new Namespace (sym.name, ed.source_reference) : parent);
			if (result is Namespace) {
				next.add_namespace ((Namespace) result);
			} else {
				next.add_error_domain ((ErrorDomain) result);
			}
			result = next;
		}
	}

	SymbolAccessibility parse_access_modifier (SymbolAccessibility default_access = SymbolAccessibility.PRIVATE) {
		switch (current ()) {
		case TokenType.PRIVATE:
			next ();
			return SymbolAccessibility.PRIVATE;
		case TokenType.PROTECTED:
			next ();
			return SymbolAccessibility.PROTECTED;
		case TokenType.INTERNAL:
			next ();
			return SymbolAccessibility.INTERNAL;
		case TokenType.PUBLIC:
			next ();
			return SymbolAccessibility.PUBLIC;
		default:
			return default_access;
		}
	}

	ModifierFlags parse_type_declaration_modifiers (string symbol_type, ModifierFlags supported) {
		ModifierFlags flags = 0;
		while (true) {
			var begin = get_location ();
			switch (current ()) {
			case TokenType.ABSTRACT:
				next ();
				flags |= ModifierFlags.ABSTRACT;
				break;
			case TokenType.EXTERN:
				next ();
				flags |= ModifierFlags.EXTERN;
				break;
			case TokenType.PARTIAL:
				next ();
				flags |= ModifierFlags.PARTIAL;
				break;
			case TokenType.SEALED:
				next ();
				flags |= ModifierFlags.SEALED;
				break;
			default:
				return flags;
			}
			if (supported > 0) {
				ModifierFlags unsupported = (flags | supported) ^ supported;
				if (unsupported > 0) {
					Report.error (get_src (begin), "`%s' modifier not applicable on %s", unsupported.to_string (), symbol_type);
				}
			}
		}
	}

	ModifierFlags parse_member_declaration_modifiers (string symbol_type, ModifierFlags supported) {
		ModifierFlags flags = 0;
		while (true) {
			var begin = get_location ();
			switch (current ()) {
			case TokenType.ABSTRACT:
				next ();
				flags |= ModifierFlags.ABSTRACT;
				break;
			case TokenType.ASYNC:
				next ();
				flags |= ModifierFlags.ASYNC;
				break;
			case TokenType.CLASS:
				next ();
				flags |= ModifierFlags.CLASS;
				break;
			case TokenType.EXTERN:
				next ();
				flags |= ModifierFlags.EXTERN;
				break;
			case TokenType.INLINE:
				next ();
				flags |= ModifierFlags.INLINE;
				break;
			case TokenType.NEW:
				next ();
				flags |= ModifierFlags.NEW;
				break;
			case TokenType.OVERRIDE:
				next ();
				flags |= ModifierFlags.OVERRIDE;
				break;
			case TokenType.SEALED:
				next ();
				flags |= ModifierFlags.SEALED;
				break;
			case TokenType.STATIC:
				next ();
				flags |= ModifierFlags.STATIC;
				break;
			case TokenType.VIRTUAL:
				next ();
				flags |= ModifierFlags.VIRTUAL;
				break;
			default:
				return flags;
			}
			if (supported > 0) {
				ModifierFlags unsupported = (flags | supported) ^ supported;
				if (unsupported > 0) {
					Report.error (get_src (begin), "`%s' modifier not applicable on %s", unsupported.to_string (), symbol_type);
				}
			}
		}
	}

	Parameter parse_parameter () throws ParseError {
		var attrs = parse_attributes ();
		var begin = get_location ();
		if (accept (TokenType.ELLIPSIS)) {
			// varargs
			return new Parameter.with_ellipsis (get_src (begin));
		}
		bool params_array = accept (TokenType.PARAMS);
		var direction = ParameterDirection.IN;
		if (accept (TokenType.OUT)) {
			direction = ParameterDirection.OUT;
		} else if (accept (TokenType.REF)) {
			direction = ParameterDirection.REF;
		}

		DataType type;
		if (direction == ParameterDirection.IN) {
			// in parameters are unowned by default
			type = parse_type (false, false);
		} else if (direction == ParameterDirection.REF) {
			// ref parameters own the value by default
			type = parse_type (true, true);
		} else {
			// out parameters own the value by default
			type = parse_type (true, false);
		}
		string id = parse_identifier ();

		type = parse_inline_array_type (type);

		var param = new Parameter (id, type, get_src (begin));
		set_attributes (param, attrs);
		param.direction = direction;
		param.params_array = params_array;
		if (accept (TokenType.ASSIGN)) {
			param.initializer = parse_expression ();
		}
		return param;
	}

	void parse_creation_method_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_member_declaration_modifiers ("creation methods", ModifierFlags.ASYNC | ModifierFlags.EXTERN);
		var sym = parse_symbol_name ();
		if (ModifierFlags.NEW in flags) {
			throw new ParseError.SYNTAX ("`new' modifier not allowed on creation method");
		}
		CreationMethod method;
		if (sym.inner == null) {
			method = new CreationMethod (sym.name, null, get_src (begin), comment);
		} else {
			method = new CreationMethod (sym.inner.name, sym.name, get_src (begin), comment);
		}
		if (ModifierFlags.EXTERN in flags) {
			method.is_extern = true;
		}
		if (ModifierFlags.ABSTRACT in flags
		    || ModifierFlags.VIRTUAL in flags
		    || ModifierFlags.OVERRIDE in flags) {
			Report.error (method.source_reference, "abstract, virtual, and override modifiers are not applicable to creation methods");
		}
		if (ModifierFlags.ASYNC in flags) {
			method.coroutine = true;
		}
		expect (TokenType.OPEN_PARENS);
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				var param = parse_parameter ();
				method.add_parameter (param);
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_PARENS);
		if (accept (TokenType.THROWS)) {
			do {
				method.add_error_type (parse_type (true, false));
			} while (accept (TokenType.COMMA));
		}
		while (accept (TokenType.REQUIRES)) {
			expect (TokenType.OPEN_PARENS);
			method.add_precondition (parse_expression ());
			expect (TokenType.CLOSE_PARENS);
		}
		while (accept (TokenType.ENSURES)) {
			expect (TokenType.OPEN_PARENS);
			method.add_postcondition (parse_expression ());
			expect (TokenType.CLOSE_PARENS);
		}
		method.access = access;
		set_attributes (method, attrs);
		if (!accept (TokenType.SEMICOLON)) {
			method.body = parse_block ();
			method.external = false;
		}

		parent.add_method (method);
	}

	void parse_delegate_declaration (Symbol parent, List<Attribute>? attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_member_declaration_modifiers ("delegates", ModifierFlags.EXTERN | ModifierFlags.STATIC);
		expect (TokenType.DELEGATE);
		var type = parse_type (true, false);
		var sym = parse_symbol_name ();
		var type_param_list = parse_type_parameter_list ();
		var d = new Delegate (sym.name, type, get_src (begin), comment);
		d.access = access;
		set_attributes (d, attrs);
		if (ModifierFlags.STATIC in flags) {
			if (!context.deprecated) {
				// TODO enable warning in future releases
				Report.warning (get_last_src (), "deprecated syntax, use [CCode (has_target = false)]");
			}
			d.has_target = false;
		}
		if (ModifierFlags.EXTERN in flags) {
			d.is_extern = true;
		}
		if (!d.get_attribute_bool ("CCode", "has_typedef", true)) {
			if (!d.external) {
				Report.error (get_last_src (), "Delegates without definition must be external");
			}
			d.anonymous = true;
		}
		foreach (TypeParameter type_param in type_param_list) {
			d.add_type_parameter (type_param);
		}
		expect (TokenType.OPEN_PARENS);
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				var param = parse_parameter ();
				d.add_parameter (param);
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_PARENS);
		if (accept (TokenType.THROWS)) {
			do {
				d.add_error_type (parse_type (true, false));
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.SEMICOLON);

		Symbol result = d;
		while (sym != null) {
			sym = sym.inner;

			Symbol next = (sym != null ? new Namespace (sym.name, d.source_reference) : parent);
			if (result is Namespace) {
				next.add_namespace ((Namespace) result);
			} else {
				next.add_delegate ((Delegate) result);
			}
			result = next;
		}
	}

	List<TypeParameter> parse_type_parameter_list () throws ParseError {
		if (accept (TokenType.OP_LT)) {
			var list = new ArrayList<TypeParameter> ();
			do {
				var begin = get_location ();
				string id = parse_identifier ();
				list.add (new TypeParameter (id, get_src (begin)));
			} while (accept (TokenType.COMMA));
			expect (TokenType.OP_GT);
			return list;
		} else {
			if (_empty_type_parameter_list == null) {
				_empty_type_parameter_list = new ArrayList<TypeParameter> ();
			}
			return _empty_type_parameter_list;
		}
	}

	void skip_type_argument_list () throws ParseError {
		if (accept (TokenType.OP_LT)) {
			do {
				skip_type ();
			} while (accept (TokenType.COMMA));
			expect (TokenType.OP_GT);
		}
	}

	// try to parse type argument list
	List<DataType>? parse_type_argument_list (bool maybe_expression) throws ParseError {
		var begin = get_location ();
		if (accept (TokenType.OP_LT)) {
			var list = new ArrayList<DataType> ();
			do {
				switch (current ()) {
				case TokenType.VOID:
				case TokenType.DYNAMIC:
				case TokenType.UNOWNED:
				case TokenType.WEAK:
				case TokenType.IDENTIFIER:
					var type = parse_type (true, true);
					list.add (type);
					break;
				default:
					rollback (begin);
					return null;
				}
			} while (accept (TokenType.COMMA));
			if (!accept (TokenType.OP_GT)) {
				rollback (begin);
				return null;
			}
			if (maybe_expression) {
				// check follower to decide whether to keep type argument list
				switch (current ()) {
				case TokenType.OPEN_PARENS:
				case TokenType.CLOSE_PARENS:
				case TokenType.CLOSE_BRACKET:
				case TokenType.OPEN_BRACE:
				case TokenType.COLON:
				case TokenType.SEMICOLON:
				case TokenType.COMMA:
				case TokenType.DOT:
				case TokenType.INTERR:
				case TokenType.OP_EQ:
				case TokenType.OP_NE:
					// keep type argument list
					break;
				default:
					// interpret tokens as expression
					rollback (begin);
					return null;
				}
			}
			return list;
		}
		return null;
	}

	MemberAccess parse_member_name (Expression? base_expr = null) throws ParseError {
		var begin = get_location ();
		MemberAccess expr = null;
		bool first = true;
		do {
			string id = parse_identifier ();

			// The first member access can be global:: qualified
			bool qualified = false;
			if (first && id == "global" && accept (TokenType.DOUBLE_COLON)) {
				id = parse_identifier ();
				qualified = true;
			}

			List<DataType> type_arg_list = parse_type_argument_list (false);
			expr = new MemberAccess (expr != null ? expr : base_expr, id, get_src (begin));
			expr.qualified = qualified;
			if (type_arg_list != null) {
				foreach (DataType type_arg in type_arg_list) {
					expr.add_type_argument (type_arg);
				}
			}

			first = false;
		} while (accept (TokenType.DOT));
		return expr;
	}

	bool is_declaration_keyword (TokenType type) {
		switch (type) {
		case TokenType.ABSTRACT:
		case TokenType.ASYNC:
		case TokenType.CLASS:
		case TokenType.CONST:
		case TokenType.DELEGATE:
		case TokenType.ENUM:
		case TokenType.ERRORDOMAIN:
		case TokenType.EXTERN:
		case TokenType.INLINE:
		case TokenType.INTERFACE:
		case TokenType.INTERNAL:
		case TokenType.NAMESPACE:
		case TokenType.NEW:
		case TokenType.OVERRIDE:
		case TokenType.PARTIAL:
		case TokenType.PRIVATE:
		case TokenType.PROTECTED:
		case TokenType.PUBLIC:
		case TokenType.SEALED:
		case TokenType.SIGNAL:
		case TokenType.STATIC:
		case TokenType.STRUCT:
		case TokenType.VIRTUAL:
		case TokenType.VOLATILE:
			return true;
		default:
			return false;
		}
	}

	void skip_modifier_keyword () {
		while (true) {
			switch (current ()) {
			case TokenType.ABSTRACT:
			case TokenType.ASYNC:
			case TokenType.CLASS:
			case TokenType.EXTERN:
			case TokenType.INLINE:
			case TokenType.NEW:
			case TokenType.OVERRIDE:
			case TokenType.STATIC:
			case TokenType.VIRTUAL:
				next ();
				break;
			default:
				return;
			}
		}
	}
}

public errordomain Vala.ParseError {
	FAILED,
	SYNTAX
}

