/* valaparser.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
using Gee;

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

	string comment;

	const int BUFFER_SIZE = 32;

	struct TokenInfo {
		public TokenType type;
		public SourceLocation begin;
		public SourceLocation end;
	}

	enum ModifierFlags {
		NONE,
		ABSTRACT = 1 << 0,
		CLASS = 1 << 1,
		INLINE = 1 << 2,
		OVERRIDE = 1 << 3,
		STATIC = 1 << 4,
		VIRTUAL = 1 << 5
	}

	construct {
		tokens = new TokenInfo[BUFFER_SIZE];
	}

	/**
	 * Parse all source files in the specified code context and build a
	 * code tree.
	 *
	 * @param context a code context
	 */
	public void parse (CodeContext! context) {
		this.context = context;
		context.accept (this);
	}

	public override void visit_source_file (SourceFile! source_file) {
		if (source_file.filename.has_suffix (".vala") || source_file.filename.has_suffix (".vapi")) {
			parse_file (source_file);
		}
	}

	inline bool next () {
		index = (index + 1) % BUFFER_SIZE;
		size--;
		if (size <= 0) {
			SourceLocation begin, end;
			TokenType type = scanner.read_token (out begin, out end);
			tokens[index].type = type;
			tokens[index].begin = begin;
			tokens[index].end = end;
			size = 1;
		}
		return (tokens[index].type != TokenType.EOF);
	}

	inline void prev () {
		index = (index - 1 + BUFFER_SIZE) % BUFFER_SIZE;
		size++;
		assert (size <= BUFFER_SIZE);
	}

	inline TokenType current () {
		return tokens[index].type;
	}

	inline bool accept (TokenType type) {
		if (current () == type) {
			next ();
			return true;
		}
		return false;
	}

	string get_error (string msg) {
		var begin = get_location ();
		next ();
		Report.error (get_src (begin), "syntax error, " + msg);
		return msg;
	}

	inline bool expect (TokenType type) throws ParseError {
		if (accept (type)) {
			return true;
		}

		throw new ParseError.SYNTAX (get_error ("expected %s".printf (type.to_string ())));
	}

	inline SourceLocation get_location () {
		return tokens[index].begin;
	}

	string get_last_string () {
		int last_index = (index + BUFFER_SIZE - 1) % BUFFER_SIZE;
		return ((string) tokens[last_index].begin.pos).ndup ((tokens[last_index].end.pos - tokens[last_index].begin.pos));
	}

	SourceReference get_src (SourceLocation begin) {
		int last_index = (index + BUFFER_SIZE - 1) % BUFFER_SIZE;

		return new SourceReference (scanner.source_file, begin.line, begin.column, tokens[last_index].end.line, tokens[last_index].end.column);
	}

	SourceReference get_src_com (SourceLocation begin) {
		int last_index = (index + BUFFER_SIZE - 1) % BUFFER_SIZE;

		var src = new SourceReference.with_comment (scanner.source_file, begin.line, begin.column, tokens[last_index].end.line, tokens[last_index].end.column, comment);
		comment = null;
		return src;
	}

	void rollback (SourceLocation location) {
		while (tokens[index].begin.pos != location.pos) {
			prev ();
		}
	}

	void skip_identifier () throws ParseError {
		// also accept keywords as identifiers where there is no conflict
		switch (current ()) {
		case TokenType.ABSTRACT:
		case TokenType.AS:
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
		case TokenType.ELSE:
		case TokenType.ENUM:
		case TokenType.ENSURES:
		case TokenType.ERRORDOMAIN:
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
		case TokenType.IS:
		case TokenType.LOCK:
		case TokenType.NAMESPACE:
		case TokenType.NEW:
		case TokenType.NULL:
		case TokenType.OUT:
		case TokenType.OVERRIDE:
		case TokenType.PRIVATE:
		case TokenType.PROTECTED:
		case TokenType.PUBLIC:
		case TokenType.REF:
		case TokenType.REQUIRES:
		case TokenType.RETURN:
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
		case TokenType.USING:
		case TokenType.VAR:
		case TokenType.VIRTUAL:
		case TokenType.VOID:
		case TokenType.VOLATILE:
		case TokenType.WEAK:
		case TokenType.WHILE:
			next ();
			return;
		}

		throw new ParseError.SYNTAX (get_error ("expected identifier"));
	}

	string parse_identifier () throws ParseError {
		skip_identifier ();
		return get_last_string ();
	}

	Expression parse_literal () throws ParseError {
		var begin = get_location ();

		switch (current ()) {
		case TokenType.TRUE:
			next ();
			return context.create_boolean_literal (true, get_src (begin));
		case TokenType.FALSE:
			next ();
			return context.create_boolean_literal (false, get_src (begin));
		case TokenType.INTEGER_LITERAL:
			next ();
			return context.create_integer_literal (get_last_string (), get_src (begin));
		case TokenType.REAL_LITERAL:
			next ();
			return context.create_real_literal (get_last_string (), get_src (begin));
		case TokenType.CHARACTER_LITERAL:
			next ();
			return context.create_character_literal (get_last_string (), get_src (begin));
		case TokenType.STRING_LITERAL:
			next ();
			return context.create_string_literal (get_last_string (), get_src (begin));
		case TokenType.NULL:
			next ();
			return context.create_null_literal (get_src (begin));
		}

		throw new ParseError.SYNTAX (get_error ("expected literal"));
	}

	public void parse_file (SourceFile source_file) {
		scanner = new Scanner (source_file);

		index = -1;
		size = 0;
		
		next ();

		try {
			parse_using_directives ();
			parse_declarations (context.root, true);
		} catch (ParseError e) {
			// already reported
		}
		
		scanner = null;
	}

	void skip_symbol_name () throws ParseError {
		do {
			skip_identifier ();
		} while (accept (TokenType.DOT));
	}

	UnresolvedSymbol parse_symbol_name () throws ParseError {
		var begin = get_location ();
		UnresolvedSymbol sym = null;
		do {
			string name = parse_identifier ();
			sym = new UnresolvedSymbol (sym, name, get_src (begin));
		} while (accept (TokenType.DOT));
		return sym;
	}

	void skip_type () throws ParseError {
		if (accept (TokenType.VOID)) {
			while (accept (TokenType.STAR)) {
			}
			return;
		}
		accept (TokenType.REF);
		accept (TokenType.OUT);
		accept (TokenType.WEAK);
		skip_symbol_name ();
		skip_type_argument_list ();
		while (accept (TokenType.STAR)) {
		}
		if (accept (TokenType.OPEN_BRACKET)) {
			do {
				if (current () != TokenType.COMMA && current () != TokenType.CLOSE_BRACKET) {
					parse_expression ();
				}
			} while (accept (TokenType.COMMA));
			expect (TokenType.CLOSE_BRACKET);
		}
		accept (TokenType.OP_NEG);
		accept (TokenType.INTERR);
		accept (TokenType.HASH);
	}

	DataType parse_type () throws ParseError {
		var begin = get_location ();

		if (accept (TokenType.VOID)) {
			DataType type = new VoidType ();
			while (accept (TokenType.STAR)) {
				type = new PointerType (type);
			}
			return type;
		}

		bool is_ref = accept (TokenType.REF);
		bool is_out = !is_ref && accept (TokenType.OUT);

		bool is_weak = accept (TokenType.WEAK);

		var sym = parse_symbol_name ();
		var type_arg_list = parse_type_argument_list (false);

		int stars = 0;
		while (accept (TokenType.STAR)) {
			stars++;
		}

		int array_rank = 0;
		if (accept (TokenType.OPEN_BRACKET)) {
			do {
				array_rank++;
				// support for stack-allocated arrays
				// also required for decision between expression and declaration statement
				if (current () != TokenType.COMMA && current () != TokenType.CLOSE_BRACKET) {
					parse_expression ();
				}
			}
			while (accept (TokenType.COMMA));
			expect (TokenType.CLOSE_BRACKET);
		}

		// deprecated
		accept (TokenType.OP_NEG);

		bool nullable = accept (TokenType.INTERR);

		bool transfers_ownership = accept (TokenType.HASH);

		var type = new UnresolvedType.from_symbol (sym, get_src (begin));
		if (type_arg_list != null) {
			foreach (DataType type_arg in type_arg_list) {
				type.add_type_argument (type_arg);
			}
		}
		type.is_ref = is_ref;
		type.is_out = is_out;
		type.is_weak = is_weak;
		type.pointer_level = stars;
		type.array_rank = array_rank;
		type.nullable = nullable;
		type.requires_null_check = nullable;
		type.transfers_ownership = transfers_ownership;
		return type;
	}

	Gee.List<Expression> parse_argument_list () throws ParseError {
		var list = new ArrayList<Expression> ();
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				list.add (parse_expression ());
			} while (accept (TokenType.COMMA));
		}
		return list;
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
		case TokenType.NULL:
			expr = parse_literal ();
			break;
		case TokenType.OPEN_PARENS:
			expr = parse_tuple ();
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
			case TokenType.DOT:
				expr = parse_member_access (begin, expr);
				break;
			case TokenType.OP_PTR:
				expr = parse_pointer_member_access (begin, expr);
				break;
			case TokenType.OPEN_PARENS:
				expr = parse_invocation_expression (begin, expr);
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
		var type_arg_list = parse_type_argument_list (true);
		var expr = context.create_member_access (null, id, get_src (begin));
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
			var tuple = new Tuple ();
			foreach (Expression expr in expr_list) {
				tuple.add_expression (expr);
			}
			return tuple;
		}
		return context.create_parenthesized_expression (expr_list.get (0), get_src (begin));
	}

	Expression parse_member_access (SourceLocation begin, Expression inner) throws ParseError {
		expect (TokenType.DOT);
		string id = parse_identifier ();
		var type_arg_list = parse_type_argument_list (true);
		var expr = context.create_member_access (inner, id, get_src (begin));
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
		var type_arg_list = parse_type_argument_list (true);
		var expr = context.create_member_access_pointer (inner, id, get_src (begin));
		if (type_arg_list != null) {
			foreach (DataType type_arg in type_arg_list) {
				expr.add_type_argument (type_arg);
			}
		}
		return expr;
	}

	Expression parse_invocation_expression (SourceLocation begin, Expression inner) throws ParseError {
		expect (TokenType.OPEN_PARENS);
		var arg_list = parse_argument_list ();
		expect (TokenType.CLOSE_PARENS);

		var expr = context.create_invocation_expression (inner, get_src (begin));
		foreach (Expression arg in arg_list) {
			expr.add_argument (arg);
		}
		return expr;
	}

	Expression parse_element_access (SourceLocation begin, Expression inner) throws ParseError {
		expect (TokenType.OPEN_BRACKET);
		var index_list = parse_expression_list ();
		expect (TokenType.CLOSE_BRACKET);

		var expr = context.create_element_access (inner, get_src (begin));
		foreach (Expression index in index_list) {
			expr.append_index (index);
		}
		return expr;
	}

	Gee.List<Expression> parse_expression_list () throws ParseError {
		var list = new ArrayList<Expression> ();
		do {
			list.add (parse_expression ());
		} while (accept (TokenType.COMMA));
		return list;
	}

	Expression parse_this_access () throws ParseError {
		var begin = get_location ();
		expect (TokenType.THIS);
		return context.create_member_access (null, "this", get_src (begin));
	}

	Expression parse_base_access () throws ParseError {
		var begin = get_location ();
		expect (TokenType.BASE);
		return context.create_base_access (get_src (begin));
	}

	Expression parse_post_increment_expression (SourceLocation begin, Expression inner) throws ParseError {
		expect (TokenType.OP_INC);
		return context.create_postfix_expression (inner, true, get_src (begin));
	}

	Expression parse_post_decrement_expression (SourceLocation begin, Expression inner) throws ParseError {
		expect (TokenType.OP_DEC);
		return context.create_postfix_expression (inner, false, get_src (begin));
	}

	Expression parse_object_or_array_creation_expression () throws ParseError {
		var begin = get_location ();
		expect (TokenType.NEW);
		var member = parse_member_name ();
		if (accept (TokenType.OPEN_PARENS)) {
			return parse_object_creation_expression (begin, member);
		} else if (accept (TokenType.OPEN_BRACKET)) {
			return parse_array_creation_expression (begin, member);
		} else {
			throw new ParseError.SYNTAX (get_error ("expected ( or ["));
		}
	}

	Expression parse_object_creation_expression (SourceLocation begin, MemberAccess member) throws ParseError {
		member.creation_member = true;
		var arg_list = parse_argument_list ();
		expect (TokenType.CLOSE_PARENS);
		var init_list = parse_object_initializer ();

		var expr = context.create_object_creation_expression (member, get_src (begin));
		foreach (Expression arg in arg_list) {
			expr.add_argument (arg);
		}
		foreach (MemberInitializer initializer in init_list) {
			expr.add_member_initializer (initializer);
		}
		return expr;
	}

	Expression parse_array_creation_expression (SourceLocation begin, MemberAccess member) throws ParseError {
		bool size_specified = false;
		var size_specifier_list = new ArrayList<Expression> ();
		do {
			Expression size = null;
			if (current () != TokenType.CLOSE_BRACKET && current () != TokenType.COMMA) {
				size = parse_expression ();
				size_specified = true;
			}
			size_specifier_list.add (size);
		} while (accept (TokenType.COMMA));
		expect (TokenType.CLOSE_BRACKET);
		InitializerList initializer = null;
		if (current () == TokenType.OPEN_BRACE) {
			initializer = parse_initializer ();
		}
		var expr = context.create_array_creation_expression (UnresolvedType.new_from_expression (member), size_specifier_list.size, initializer, get_src (begin));
		if (size_specified) {
			foreach (Expression size in size_specifier_list) {
				expr.append_size (size);
			}
		}
		return expr;
	}

	Gee.List<MemberInitializer> parse_object_initializer () throws ParseError {
		var list = new ArrayList<MemberInitializer> ();
		if (accept (TokenType.OPEN_BRACE)) {
			do {
				list.add (parse_member_initializer ());
			} while (accept (TokenType.COMMA));
			expect (TokenType.CLOSE_BRACE);
		}
		return list;
	}

	MemberInitializer parse_member_initializer () throws ParseError {
		var begin = get_location ();
		string id = parse_identifier ();
		expect (TokenType.ASSIGN);
		var expr = parse_expression ();

		return new MemberInitializer (id, expr, get_src (begin));
	}

	Expression parse_sizeof_expression () throws ParseError {
		var begin = get_location ();
		expect (TokenType.SIZEOF);
		expect (TokenType.OPEN_PARENS);
		var type = parse_type ();
		expect (TokenType.CLOSE_PARENS);

		return context.create_sizeof_expression (type, get_src (begin));
	}

	Expression parse_typeof_expression () throws ParseError {
		var begin = get_location ();
		expect (TokenType.TYPEOF);
		expect (TokenType.OPEN_PARENS);
		var type = parse_type ();
		expect (TokenType.CLOSE_PARENS);

		return context.create_typeof_expression (type, get_src (begin));
	}

	UnaryOperator get_unary_operator (TokenType token_type) {
		switch (token_type) {
		case TokenType.PLUS:   return UnaryOperator.PLUS;
		case TokenType.MINUS:  return UnaryOperator.MINUS;
		case TokenType.OP_NEG: return UnaryOperator.LOGICAL_NEGATION;
		case TokenType.TILDE:  return UnaryOperator.BITWISE_COMPLEMENT;
		case TokenType.OP_INC: return UnaryOperator.INCREMENT;
		case TokenType.OP_DEC: return UnaryOperator.DECREMENT;
		case TokenType.REF:    return UnaryOperator.REF;
		case TokenType.OUT:    return UnaryOperator.OUT;
		default:               return UnaryOperator.NONE;
		}
	}

	Expression parse_unary_expression () throws ParseError {
		var begin = get_location ();
		var operator = get_unary_operator (current ());
		if (operator != UnaryOperator.NONE) {
			next ();
			var op = parse_unary_expression ();
			return context.create_unary_expression (operator, op, get_src (begin));
		}
		switch (current ()) {
		case TokenType.HASH:
			next ();
			var op = parse_unary_expression ();
			return context.create_reference_transfer_expression (op, get_src (begin));
		case TokenType.OPEN_PARENS:
			next ();
			switch (current ()) {
			case TokenType.VOID:
			case TokenType.IDENTIFIER:
				var type = parse_type ();
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
					case TokenType.NULL:
					case TokenType.THIS:
					case TokenType.BASE:
					case TokenType.NEW:
					case TokenType.SIZEOF:
					case TokenType.TYPEOF:
					case TokenType.IDENTIFIER:
						var inner = parse_unary_expression ();
						return context.create_cast_expression (inner, type, get_src (begin), false);
					}
				}
				break;
			}
			// no cast expression
			rollback (begin);
			break;
		case TokenType.STAR:
			next ();
			var op = parse_unary_expression ();
			return context.create_pointer_indirection (op, get_src (begin));
		case TokenType.BITWISE_AND:
			next ();
			var op = parse_unary_expression ();
			return context.create_addressof_expression (op, get_src (begin));
		}

		return parse_primary_expression ();
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
				left = context.create_binary_expression (operator, left, right, get_src (begin));
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
				left = context.create_binary_expression (operator, left, right, get_src (begin));
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
				left = context.create_binary_expression (BinaryOperator.SHIFT_LEFT, left, right, get_src (begin));
				break;
			// don't use OP_SHIFT_RIGHT to support >> for nested generics
			case TokenType.OP_GT:
				char* first_gt_pos = tokens[index].begin.pos;
				next ();
				// only accept >> when there is no space between the two > signs
				if (current () == TokenType.OP_GT && tokens[index].begin.pos == first_gt_pos + 1) {
					next ();
					var right = parse_additive_expression ();
					left = context.create_binary_expression (BinaryOperator.SHIFT_RIGHT, left, right, get_src (begin));
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

	Expression parse_relational_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_shift_expression ();
		bool found = true;
		while (found) {
			var operator = get_binary_operator (current ());
			switch (operator) {
			case BinaryOperator.LESS_THAN:
			case BinaryOperator.LESS_THAN_OR_EQUAL:
			case BinaryOperator.GREATER_THAN_OR_EQUAL:
				next ();
				var right = parse_shift_expression ();
				left = context.create_binary_expression (operator, left, right, get_src (begin));
				break;
			case BinaryOperator.GREATER_THAN:
				next ();
				// ignore >> and >>= (two tokens due to generics)
				if (current () != TokenType.OP_GT && current () != TokenType.OP_GE) {
					var right = parse_shift_expression ();
					left = context.create_binary_expression (operator, left, right, get_src (begin));
				} else {
					prev ();
					found = false;
				}
				break;
			default:
				switch (current ()) {
				case TokenType.IS:
					next ();
					var type = parse_type ();
					left = context.create_type_check (left, type, get_src (begin));
					break;
				case TokenType.AS:
					next ();
					var type = parse_type ();
					left = context.create_cast_expression (left, type, get_src (begin), true);
					break;
				default:
					found = false;
					break;
				}
				break;
			}
		}
		return left;
	}

	Expression parse_equality_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_relational_expression ();
		bool found = true;
		while (found) {
			var operator = get_binary_operator (current ());
			switch (operator) {
			case BinaryOperator.EQUALITY:
			case BinaryOperator.INEQUALITY:
				next ();
				var right = parse_relational_expression ();
				left = context.create_binary_expression (operator, left, right, get_src (begin));
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
		var left = parse_equality_expression ();
		while (accept (TokenType.BITWISE_AND)) {
			var right = parse_equality_expression ();
			left = context.create_binary_expression (BinaryOperator.BITWISE_AND, left, right, get_src (begin));
		}
		return left;
	}

	Expression parse_exclusive_or_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_and_expression ();
		while (accept (TokenType.CARRET)) {
			var right = parse_and_expression ();
			left = context.create_binary_expression (BinaryOperator.BITWISE_XOR, left, right, get_src (begin));
		}
		return left;
	}

	Expression parse_inclusive_or_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_exclusive_or_expression ();
		while (accept (TokenType.BITWISE_OR)) {
			var right = parse_exclusive_or_expression ();
			left = context.create_binary_expression (BinaryOperator.BITWISE_OR, left, right, get_src (begin));
		}
		return left;
	}

	Expression parse_in_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_inclusive_or_expression ();
		while (accept (TokenType.IN)) {
			var right = parse_inclusive_or_expression ();
			left = context.create_binary_expression (BinaryOperator.IN, left, right, get_src (begin));
		}
		return left;
	}

	Expression parse_conditional_and_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_in_expression ();
		while (accept (TokenType.OP_AND)) {
			var right = parse_in_expression ();
			left = context.create_binary_expression (BinaryOperator.AND, left, right, get_src (begin));
		}
		return left;
	}

	Expression parse_conditional_or_expression () throws ParseError {
		var begin = get_location ();
		var left = parse_conditional_and_expression ();
		while (accept (TokenType.OP_OR)) {
			var right = parse_conditional_and_expression ();
			left = context.create_binary_expression (BinaryOperator.OR, left, right, get_src (begin));
		}
		return left;
	}

	Expression parse_conditional_expression () throws ParseError {
		var begin = get_location ();
		var condition = parse_conditional_or_expression ();
		if (accept (TokenType.INTERR)) {
			var true_expr = parse_expression ();
			expect (TokenType.COLON);
			var false_expr = parse_expression ();
			return context.create_conditional_expression (condition, true_expr, false_expr, get_src (begin));
		} else {
			return condition;
		}
	}

	Expression parse_lambda_expression () throws ParseError {
		var begin = get_location ();
		Gee.List<string> params = new ArrayList<string> ();
		if (accept (TokenType.OPEN_PARENS)) {
			if (current () != TokenType.CLOSE_PARENS) {
				do {
					params.add (parse_identifier ());
				} while (accept (TokenType.COMMA));
			}
			expect (TokenType.CLOSE_PARENS);
		} else {
			params.add (parse_identifier ());
		}
		expect (TokenType.LAMBDA);

		LambdaExpression lambda;
		if (current () == TokenType.OPEN_BRACE) {
			var block = parse_block ();
			lambda = context.create_lambda_expression_with_statement_body (block, get_src (begin));
		} else {
			var expr = parse_expression ();
			lambda = context.create_lambda_expression (expr, get_src (begin));
		}
		foreach (string param in params) {
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
		var begin = get_location ();
		Expression expr = parse_conditional_expression ();

		if (current () == TokenType.LAMBDA) {
			rollback (begin);
			return parse_lambda_expression ();
		}

		while (true) {
			var operator = get_assignment_operator (current ());
			if (operator != AssignmentOperator.NONE) {
				next ();
				var rhs = parse_expression ();
				expr = context.create_assignment (expr, rhs, operator);
			} else if (current () == TokenType.OP_GT) { // >>=
				char* first_gt_pos = tokens[index].begin.pos;
				next ();
				// only accept >>= when there is no space between the two > signs
				if (current () == TokenType.OP_GE && tokens[index].begin.pos == first_gt_pos + 1) {
					next ();
					var rhs = parse_expression ();
					expr = context.create_assignment (expr, rhs, AssignmentOperator.SHIFT_RIGHT);
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

	Statement parse_statement () throws ParseError {
		comment = scanner.pop_comment ();
		switch (current ()) {
		case TokenType.OPEN_BRACE:
			return parse_block ();
		case TokenType.SEMICOLON:
			return parse_empty_statement ();
		case TokenType.IF:
			return parse_if_statement ();
		case TokenType.SWITCH:
			return parse_switch_statement ();
		case TokenType.WHILE:
			return parse_while_statement ();
		case TokenType.DO:
			return parse_do_statement ();
		case TokenType.FOR:
			return parse_for_statement ();
		case TokenType.FOREACH:
			return parse_foreach_statement ();
		case TokenType.BREAK:
			return parse_break_statement ();
		case TokenType.CONTINUE:
			return parse_continue_statement ();
		case TokenType.RETURN:
			return parse_return_statement ();
		case TokenType.THROW:
			return parse_throw_statement ();
		case TokenType.TRY:
			return parse_try_statement ();
		case TokenType.LOCK:
			return parse_lock_statement ();
		case TokenType.DELETE:
			return parse_delete_statement ();
		case TokenType.VAR:
			return parse_declaration_statement ();
		case TokenType.OP_INC:
		case TokenType.OP_DEC:
		case TokenType.BASE:
		case TokenType.THIS:
		case TokenType.OPEN_PARENS:
		case TokenType.STAR:
		case TokenType.NEW:
			return parse_expression_statement ();
		}

		if (is_expression ()) {
			return parse_expression_statement ();
		} else {
			return parse_declaration_statement ();
		}
	}

	bool is_expression () throws ParseError {
		var begin = get_location ();

		// decide between declaration and expression statement
		skip_type ();
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
			rollback (begin);
			return true;
		}

		rollback (begin);
		return false;
	}

	Block parse_embedded_statement () throws ParseError {
		if (current () == TokenType.OPEN_BRACE) {
			return parse_block ();
		}

		comment = scanner.pop_comment ();

		var block = context.create_block ();
		block.add_statement (parse_embedded_statement_without_block ());
		return block;

	}

	Statement parse_embedded_statement_without_block () throws ParseError {
		switch (current ()) {
		case TokenType.SEMICOLON: return parse_empty_statement ();
		case TokenType.IF:        return parse_if_statement ();
		case TokenType.SWITCH:    return parse_switch_statement ();
		case TokenType.WHILE:     return parse_while_statement ();
		case TokenType.DO:        return parse_do_statement ();
		case TokenType.FOR:       return parse_for_statement ();
		case TokenType.FOREACH:   return parse_foreach_statement ();
		case TokenType.BREAK:     return parse_break_statement ();
		case TokenType.CONTINUE:  return parse_continue_statement ();
		case TokenType.RETURN:    return parse_return_statement ();
		case TokenType.THROW:     return parse_throw_statement ();
		case TokenType.TRY:       return parse_try_statement ();
		case TokenType.LOCK:      return parse_lock_statement ();
		case TokenType.DELETE:    return parse_delete_statement ();
		default:                  return parse_expression_statement ();
		}
	}

	Block parse_block () throws ParseError {
		var begin = get_location ();
		Gee.List<Statement> list = new ArrayList<Statement> ();
		expect (TokenType.OPEN_BRACE);
		var block = context.create_block (get_src_com (begin));
		while (current () != TokenType.CLOSE_BRACE) {
			try {
				var stmt = parse_statement ();
				if (stmt == null) {
					// workaround for current limitation of exception handling
					throw new ParseError.SYNTAX ("syntax error in statement");
				}
				block.add_statement (stmt);
			} catch (ParseError e) {
				if (recover () != RecoveryState.STATEMENT_BEGIN) {
					// beginning of next declaration or end of file reached
					// return what we have so far
					return block;
				}
			}
		}
		if (!accept (TokenType.CLOSE_BRACE)) {
			Report.error (new SourceReference (scanner.source_file, tokens[index].begin.line, tokens[index].begin.column, tokens[index].end.line, tokens[index].end.column), "expected `}'");
		}

		return block;
	}

	Statement parse_empty_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.SEMICOLON);
		return context.create_empty_statement (get_src_com (begin));
	}

	Statement parse_declaration_statement () throws ParseError {
		var begin = get_location ();
		var decl = parse_local_variable_declaration ();
		expect (TokenType.SEMICOLON);
		return context.create_declaration_statement (decl, get_src_com (begin));
	}

	LocalVariableDeclaration parse_local_variable_declaration () throws ParseError {
		var begin = get_location ();
		LocalVariableDeclaration decl;
		if (accept (TokenType.VAR)) {
			var declarators = parse_variable_declarators ();
			decl = context.create_local_variable_declaration_var_type (get_src (begin));
			foreach (VariableDeclarator var_decl in declarators) {
				decl.add_declarator (var_decl);
			}
		} else {
			var type = parse_type ();
			var declarators = parse_variable_declarators ();
			if (!((UnresolvedType) type).is_weak) {
				type.takes_ownership = true;
			}
			type.requires_null_check = false;
			type.nullable = true;
			decl = context.create_local_variable_declaration (type, get_src (begin));
			foreach (VariableDeclarator var_decl in declarators) {
				var_decl.type_reference = type.copy ();
				decl.add_declarator (var_decl);
			}
		}
		return decl;
	}

	Statement parse_expression_statement () throws ParseError {
		var begin = get_location ();
		var expr = parse_statement_expression ();
		expect (TokenType.SEMICOLON);
		return context.create_expression_statement (expr, get_src_com (begin));
	}

	Expression parse_statement_expression () throws ParseError {
		// invocation expression, assignment,
		// or pre/post increment/decrement expression
		return parse_expression ();
	}

	Statement parse_if_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.IF);
		expect (TokenType.OPEN_PARENS);
		var condition = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		var src = get_src_com (begin);
		var true_stmt = parse_embedded_statement ();
		Block false_stmt = null;
		if (accept (TokenType.ELSE)) {
			false_stmt = parse_embedded_statement ();
		}
		return context.create_if_statement (condition, true_stmt, false_stmt, src);
	}

	Statement parse_switch_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.SWITCH);
		expect (TokenType.OPEN_PARENS);
		var condition = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		var stmt = context.create_switch_statement (condition, get_src_com (begin));
		expect (TokenType.OPEN_BRACE);
		while (current () != TokenType.CLOSE_BRACE) {
			var section = context.create_switch_section (get_src_com (begin));
			do {
				if (accept (TokenType.CASE)) {
					section.add_label (context.create_switch_label (parse_expression (), get_src_com (begin)));
				} else {
					expect (TokenType.DEFAULT);
					section.add_label (context.create_switch_label_with_default (get_src_com (begin)));
				}
				expect (TokenType.COLON);
			} while (current () == TokenType.CASE || current () == TokenType.DEFAULT);
			while (current () != TokenType.CLOSE_BRACE
			       && current () != TokenType.CASE
			       && current () != TokenType.DEFAULT) {
				section.add_statement (parse_statement ());
			}
			stmt.add_section (section);
		}
		expect (TokenType.CLOSE_BRACE);
		return stmt;
	}

	Statement parse_while_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.WHILE);
		expect (TokenType.OPEN_PARENS);
		var condition = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		var body = parse_embedded_statement ();
		return context.create_while_statement (condition, body, get_src_com (begin));
	}

	Statement parse_do_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.DO);
		var body = parse_embedded_statement ();
		expect (TokenType.WHILE);
		expect (TokenType.OPEN_PARENS);
		var condition = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		expect (TokenType.SEMICOLON);
		return context.create_do_statement (body, condition, get_src_com (begin));
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
				block = context.create_block (get_src (begin));
				block.add_statement (parse_declaration_statement ());
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
		var src = get_src_com (begin);
		var body = parse_embedded_statement ();
		var stmt = context.create_for_statement (condition, body, src);
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
		var type = parse_type ();
		var unresolved_type = type as UnresolvedType;
		if (unresolved_type != null && !unresolved_type.is_weak) {
			unresolved_type.takes_ownership = true;
		}
		string id = parse_identifier ();
		expect (TokenType.IN);
		var collection = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		var src = get_src_com (begin);
		var body = parse_embedded_statement ();
		return context.create_foreach_statement (type, id, collection, body, src);
	}

	Statement parse_break_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.BREAK);
		expect (TokenType.SEMICOLON);
		return context.create_break_statement (get_src_com (begin));
	}

	Statement parse_continue_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.CONTINUE);
		expect (TokenType.SEMICOLON);
		return context.create_continue_statement (get_src_com (begin));
	}

	Statement parse_return_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.RETURN);
		Expression expr = null;
		if (current () != TokenType.SEMICOLON) {
			expr = parse_expression ();
		}
		expect (TokenType.SEMICOLON);
		return context.create_return_statement (expr, get_src_com (begin));
	}

	Statement parse_throw_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.THROW);
		var expr = parse_expression ();
		expect (TokenType.SEMICOLON);
		return context.create_throw_statement (expr, get_src_com (begin));
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
		} else {
			finally_clause = parse_finally_clause ();
		}
		var stmt = context.create_try_statement (try_block, finally_clause, get_src_com (begin));
		foreach (CatchClause clause in catch_clauses) {
			stmt.add_catch_clause (clause);
		}
		return stmt;
	}

	void parse_catch_clauses (Gee.List<CatchClause> catch_clauses) throws ParseError {
		while (accept (TokenType.CATCH)) {
			var begin = get_location ();
			DataType type = null;
			string id = null;
			if (accept (TokenType.OPEN_PARENS)) {
				type = parse_type ();
				id = parse_identifier ();
				expect (TokenType.CLOSE_PARENS);
			}
			var block = parse_block ();
			catch_clauses.add (context.create_catch_clause (type, id, block, get_src (begin)));
		}
	}

	Block parse_finally_clause () throws ParseError {
		expect (TokenType.FINALLY);
		return parse_block ();
	}

	Statement parse_lock_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.LOCK);
		expect (TokenType.OPEN_PARENS);
		var expr = parse_expression ();
		expect (TokenType.CLOSE_PARENS);
		var stmt = parse_embedded_statement ();
		return context.create_lock_statement (expr, stmt, get_src_com (begin));
	}

	Statement parse_delete_statement () throws ParseError {
		var begin = get_location ();
		expect (TokenType.DELETE);
		var expr = parse_expression ();
		expect (TokenType.SEMICOLON);
		return context.create_delete_statement (expr, get_src_com (begin));
	}

	Gee.List<Attribute> parse_attributes () throws ParseError {
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
							begin = get_location ();
							string id = parse_identifier ();
							expect (TokenType.ASSIGN);
							var expr = parse_expression ();
							attr.add_argument (new NamedArgument (id, expr, get_src (begin)));
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

	void set_attributes (CodeNode node, Gee.List<Attribute> attributes) {
		if (attributes != null) {
			foreach (Attribute attr in attributes) {
				node.attributes.append (attr);
			}
		}
	}

	Symbol parse_declaration () throws ParseError {
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
			rollback (begin);
			return parse_constructor_declaration (attrs);
		case TokenType.TILDE:
			rollback (begin);
			return parse_destructor_declaration (attrs);
		default:
			skip_type ();
			switch (current ()) {
			case TokenType.OPEN_BRACE:
			case TokenType.SEMICOLON:
			case TokenType.COLON:
				rollback (begin);
				switch (last_keyword) {
				case TokenType.CLASS:       return parse_class_declaration (attrs);
				case TokenType.ENUM:        return parse_enum_declaration (attrs);
				case TokenType.ERRORDOMAIN: return parse_errordomain_declaration (attrs);
				case TokenType.INTERFACE:   return parse_interface_declaration (attrs);
				case TokenType.NAMESPACE:   return parse_namespace_declaration (attrs);
				case TokenType.STRUCT:      return parse_struct_declaration (attrs);
				}
				break;
			case TokenType.OPEN_PARENS:
				rollback (begin);
				return parse_creation_method_declaration (attrs);
			default:
				skip_type (); // might contain type parameter list
				switch (current ()) {
				case TokenType.OPEN_PARENS:
					rollback (begin);
					switch (last_keyword) {
					case TokenType.DELEGATE: return parse_delegate_declaration (attrs);
					case TokenType.SIGNAL:   return parse_signal_declaration (attrs);
					default:                 return parse_method_declaration (attrs);
					}
				case TokenType.ASSIGN:
				case TokenType.SEMICOLON:
					rollback (begin);
					switch (last_keyword) {
					case TokenType.CONST: return parse_constant_declaration (attrs);
					default:              return parse_field_declaration (attrs);
					}
				case TokenType.OPEN_BRACE:
					rollback (begin);
					return parse_property_declaration (attrs);
				}
				break;
			}
			break;
		}

		throw new ParseError.SYNTAX (get_error ("expected declaration"));
	}

	void parse_declarations (Symbol parent, bool root = false) throws ParseError {
		if (!root) {
			expect (TokenType.OPEN_BRACE);
		}
		while (current () != TokenType.CLOSE_BRACE && current () != TokenType.EOF) {
			try {
				if (parent is Namespace) {
					parse_namespace_member ((Namespace) parent);
				} else if (parent is Class) {
					parse_class_member ((Class) parent);
				} else if (parent is Struct) {
					parse_struct_member ((Struct) parent);
				} else if (parent is Interface) {
					parse_interface_member ((Interface) parent);
				}
			} catch (ParseError e) {
				int r;
				do {
					r = recover ();
				} while (r == RecoveryState.STATEMENT_BEGIN);
				if (r == RecoveryState.EOF) {
					return;
				}
			}
		}
		if (!root) {
			if (!accept (TokenType.CLOSE_BRACE)) {
				Report.error (new SourceReference (scanner.source_file, tokens[index].begin.line, tokens[index].begin.column, tokens[index].end.line, tokens[index].end.column), "expected `}'");
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
			case TokenType.INLINE:
			case TokenType.INTERFACE:
			case TokenType.NAMESPACE:
			case TokenType.OVERRIDE:
			case TokenType.PRIVATE:
			case TokenType.PROTECTED:
			case TokenType.PUBLIC:
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
			case TokenType.VAR:
			case TokenType.WHILE:
				return RecoveryState.STATEMENT_BEGIN;
			default:
				next ();
				break;
			}
		}
		return RecoveryState.EOF;
	}

	Namespace parse_namespace_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		expect (TokenType.NAMESPACE);
		var sym = parse_symbol_name ();
		var ns = context.create_namespace (sym.name, get_src_com (begin));
		ns.pkg = scanner.source_file.pkg;
		set_attributes (ns, attrs);
		parse_declarations (ns);
		return ns;
	}

	void parse_namespace_member (Namespace ns) throws ParseError {
		var sym = parse_declaration ();
		if (sym is Namespace) {
			if (ns.scope.lookup (sym.name) is Namespace) {
				// merge if namespace already exists
				var old_ns = (Namespace) ns.scope.lookup (sym.name);
				var new_ns = (Namespace) sym;
				if (!new_ns.pkg) {
					old_ns.pkg = false;
				}
				foreach (Class cl in new_ns.get_classes ()) {
					if (old_ns.scope.lookup (cl.name) is Class) {
						// merge
						var old_class = (Class) old_ns.scope.lookup (cl.name);
						foreach (DataType base_type in cl.get_base_types ()) {
							old_class.add_base_type (base_type);
						}
						foreach (Field f in cl.get_fields ()) {
							old_class.add_field (f);
						}
						foreach (Method m in cl.get_methods ()) {
							if (m == cl.default_construction_method && old_class.default_construction_method != null) {
								// ignore secondary default creation method
								continue;
							}
							old_class.add_method (m);
						}
						if (cl.constructor != null) {
							old_class.constructor = cl.constructor;
						}
						scanner.source_file.remove_node (cl);
					} else {
						old_ns.add_class (cl);
					}
				}
				foreach (Struct st in new_ns.get_structs ()) {
					old_ns.add_struct (st);
				}
				foreach (Interface iface in new_ns.get_interfaces ()) {
					old_ns.add_interface (iface);
				}
				foreach (Delegate d in new_ns.get_delegates ()) {
					old_ns.add_delegate (d);
				}
				foreach (Enum en in new_ns.get_enums ()) {
					old_ns.add_enum (en);
				}
				foreach (ErrorDomain ed in new_ns.get_error_domains ()) {
					old_ns.add_error_domain (ed);
				}
				foreach (Constant c in new_ns.get_constants ()) {
					old_ns.add_constant (c);
				}
				foreach (Field f in new_ns.get_fields ()) {
					old_ns.add_field (f);
				}
				foreach (Method m in new_ns.get_methods ()) {
					old_ns.add_method (m);
				}
			} else {
				context.root.add_namespace ((Namespace) sym);
			}
		} else if (sym is Class) {
			ns.add_class ((Class) sym);
		} else if (sym is Interface) {
			ns.add_interface ((Interface) sym);
		} else if (sym is Struct) {
			ns.add_struct ((Struct) sym);
		} else if (sym is Enum) {
			ns.add_enum ((Enum) sym);
		} else if (sym is ErrorDomain) {
			ns.add_error_domain ((ErrorDomain) sym);
		} else if (sym is Delegate) {
			ns.add_delegate ((Delegate) sym);
		} else if (sym is Method) {
			var method = (Method) sym;
			method.instance = false;
			ns.add_method (method);
		} else if (sym is Field) {
			var field = (Field) sym;
			field.instance = false;
			ns.add_field (field);
		} else if (sym is Constant) {
			ns.add_constant ((Constant) sym);
		} else if (sym == null) {
			// workaround for current limitation of exception handling
			throw new ParseError.SYNTAX ("syntax error in declaration");
		} else {
			Report.error (sym.source_reference, "unexpected declaration in namespace");
		}
		scanner.source_file.add_node (sym);
	}

	void parse_using_directives () throws ParseError {
		while (accept (TokenType.USING)) {
			var begin = get_location ();

			do {
				var begin = get_location ();
				var sym = parse_symbol_name ();
				var ns_ref = new NamespaceReference (sym.name, get_src (begin));
				scanner.source_file.add_using_directive (ns_ref);
			} while (accept (TokenType.COMMA));
			expect (TokenType.SEMICOLON);
		}
	}

	Symbol parse_class_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_type_declaration_modifiers ();
		expect (TokenType.CLASS);
		var sym = parse_symbol_name ();
		var type_param_list = parse_type_parameter_list ();
		var base_types = new ArrayList<DataType> ();
		if (accept (TokenType.COLON)) {
			do {
				base_types.add (parse_type ());
			} while (accept (TokenType.COMMA));
		}

		var cl = context.create_class (sym.name, get_src_com (begin));
		cl.access = access;
		if (ModifierFlags.ABSTRACT in flags) {
			cl.is_abstract = true;
		}
		if (ModifierFlags.STATIC in flags) {
			cl.is_static = true;
		}
		set_attributes (cl, attrs);
		foreach (TypeParameter type_param in type_param_list) {
			cl.add_type_parameter (type_param);
		}
		foreach (DataType base_type in base_types) {
			cl.add_base_type (base_type);
		}

		parse_declarations (cl);

		// ensure there is always a default construction method
		if (!scanner.source_file.pkg
		    && !cl.is_abstract
		    && !cl.is_static
		    && cl.default_construction_method == null) {
			var m = context.create_creation_method (cl.name, null, cl.source_reference);
			m.instance = false;
			m.access = SymbolAccessibility.PUBLIC;
			m.body = context.create_block (cl.source_reference);
			cl.add_method (m);
		}

		Symbol result = cl;
		while (sym.inner != null) {
			sym = sym.inner;
			var ns = context.create_namespace (sym.name, cl.source_reference);
			ns.pkg = scanner.source_file.pkg;
			if (result is Namespace) {
				ns.add_namespace ((Namespace) result);
			} else {
				ns.add_class ((Class) result);
				scanner.source_file.add_node (result);
			}
			result = ns;
		}
		return result;
	}

	void parse_class_member (Class cl) throws ParseError {
		var sym = parse_declaration ();
		if (sym is Class) {
			cl.add_class ((Class) sym);
		} else if (sym is Struct) {
			cl.add_struct ((Struct) sym);
		} else if (sym is Enum) {
			cl.add_enum ((Enum) sym);
		} else if (sym is Delegate) {
			cl.add_delegate ((Delegate) sym);
		} else if (sym is Method) {
			cl.add_method ((Method) sym);
		} else if (sym is Signal) {
			cl.add_signal ((Signal) sym);
		} else if (sym is Field) {
			cl.add_field ((Field) sym);
		} else if (sym is Constant) {
			cl.add_constant ((Constant) sym);
		} else if (sym is Property) {
			cl.add_property ((Property) sym);
		} else if (sym is Constructor) {
			var c = (Constructor) sym;
			if (c.instance) {
				cl.constructor = c;
			} else {
				cl.static_constructor = c;
			}
		} else if (sym is Destructor) {
			cl.destructor = (Destructor) sym;
		} else if (sym == null) {
			// workaround for current limitation of exception handling
			throw new ParseError.SYNTAX ("syntax error in declaration");
		} else {
			Report.error (sym.source_reference, "unexpected declaration in class");
		}
	}

	Constant parse_constant_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		parse_member_declaration_modifiers ();
		expect (TokenType.CONST);
		var type = parse_type ();
		string id = parse_identifier ();
		Expression initializer = null;
		if (accept (TokenType.ASSIGN)) {
			initializer = parse_variable_initializer ();
		}
		expect (TokenType.SEMICOLON);
		var c = context.create_constant (id, type, initializer, get_src_com (begin));
		c.access = access;
		set_attributes (c, attrs);
		return c;
	}

	Field parse_field_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_member_declaration_modifiers ();
		var type = parse_type ();
		var unresolved_type = type as UnresolvedType;
		if (unresolved_type != null && !unresolved_type.is_weak) {
			unresolved_type.takes_ownership = true;
		}
		string id = parse_identifier ();
		var f = context.create_field (id, type, null, get_src_com (begin));
		f.access = access;
		set_attributes (f, attrs);
		if (ModifierFlags.STATIC in flags) {
			f.instance = false;
		}
		if (accept (TokenType.ASSIGN)) {
			f.initializer = parse_expression ();
		}
		expect (TokenType.SEMICOLON);
		return f;
	}

	Gee.List<VariableDeclarator> parse_variable_declarators () throws ParseError {
		var list = new ArrayList<VariableDeclarator> ();
		do {
			var var_decl = parse_variable_declarator ();
			list.add (var_decl);
		} while (accept (TokenType.COMMA));
		return list;
	}

	VariableDeclarator parse_variable_declarator () throws ParseError {
		var begin = get_location ();
		string id = parse_identifier ();
		Expression initializer = null;
		if (accept (TokenType.ASSIGN)) {
			initializer = parse_variable_initializer ();
		}
		return context.create_variable_declarator (id, initializer, get_src (begin));
	}

	InitializerList parse_initializer () throws ParseError {
		var begin = get_location ();
		expect (TokenType.OPEN_BRACE);
		var initializer = context.create_initializer_list (get_src (begin));
		if (current () != TokenType.CLOSE_BRACE) {
			do {
				initializer.append (parse_variable_initializer ());
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_BRACE);
		return initializer;
	}

	Expression parse_variable_initializer () throws ParseError {
		if (current () == TokenType.OPEN_BRACE) {
			return parse_initializer ();
		} else {
			return parse_expression ();
		}
	}

	Method parse_method_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_member_declaration_modifiers ();
		var type = parse_type ();
		var unresolved_type = type as UnresolvedType;
		if (unresolved_type != null && !unresolved_type.is_weak) {
			unresolved_type.transfers_ownership = true;
		}
		string id = parse_identifier ();
		parse_type_parameter_list ();
		var method = context.create_method (id, type, get_src_com (begin));
		method.access = access;
		set_attributes (method, attrs);
		if (ModifierFlags.STATIC in flags) {
			method.instance = false;
		}
		if (ModifierFlags.ABSTRACT in flags) {
			method.is_abstract = true;
		}
		if (ModifierFlags.VIRTUAL in flags) {
			method.is_virtual = true;
		}
		if (ModifierFlags.OVERRIDE in flags) {
			method.overrides = true;
		}
		if (ModifierFlags.INLINE in flags) {
			method.is_inline = true;
		}
		expect (TokenType.OPEN_PARENS);
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				method.add_parameter (parse_parameter ());
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_PARENS);
		if (accept (TokenType.THROWS)) {
			do {
				method.add_error_domain (parse_type ());
			} while (accept (TokenType.COMMA));
		}
		if (!accept (TokenType.SEMICOLON)) {
			method.body = parse_block ();
		}
		return method;
	}

	Property parse_property_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_member_declaration_modifiers ();
		var type = parse_type ();
		if (!((UnresolvedType) type).is_weak) {
			type.takes_ownership = true;
		}
		string id = parse_identifier ();
		var prop = context.create_property (id, type, null, null, get_src_com (begin));
		prop.access = access;
		set_attributes (prop, attrs);
		if (ModifierFlags.ABSTRACT in flags) {
			prop.is_abstract = true;
		}
		if (ModifierFlags.VIRTUAL in flags) {
			prop.is_virtual = true;
		}
		if (ModifierFlags.OVERRIDE in flags) {
			prop.overrides = true;
		}
		expect (TokenType.OPEN_BRACE);
		while (current () != TokenType.CLOSE_BRACE) {
			if (accept (TokenType.DEFAULT)) {
				if (prop.default_expression != null) {
					throw new ParseError.SYNTAX (get_error ("property default value already defined"));
				}
				if (accept (TokenType.OPEN_PARENS)) {
					// deprecated
					prop.default_expression = parse_expression ();
					expect (TokenType.CLOSE_PARENS);
				} else {
					expect (TokenType.ASSIGN);
					prop.default_expression = parse_expression ();
				}
				expect (TokenType.SEMICOLON);
			} else {
				parse_attributes ();
				var accessor_access = parse_access_modifier (SymbolAccessibility.PUBLIC);
				if (accept (TokenType.GET)) {
					if (prop.get_accessor != null) {
						throw new ParseError.SYNTAX (get_error ("property get accessor already defined"));
					}
					Block block = null;
					if (!accept (TokenType.SEMICOLON)) {
						block = parse_block ();
					}
					prop.get_accessor = context.create_property_accessor (true, false, false, block, get_src (begin));
					prop.get_accessor.access = accessor_access;
				} else {
					bool writable, _construct;
					if (accept (TokenType.SET)) {
						writable = true;
						_construct = accept (TokenType.CONSTRUCT);
					} else if (accept (TokenType.CONSTRUCT)) {
						_construct = true;
						writable = accept (TokenType.SET);
					} else {
						throw new ParseError.SYNTAX (get_error ("expected get, set, or construct"));
					}
					if (prop.set_accessor != null) {
						throw new ParseError.SYNTAX (get_error ("property set accessor already defined"));
					}
					Block block = null;
					if (!accept (TokenType.SEMICOLON)) {
						block = parse_block ();
					}
					prop.set_accessor = context.create_property_accessor (false, writable, _construct, block, get_src (begin));
					prop.set_accessor.access = accessor_access;
				}
			}
		}
		expect (TokenType.CLOSE_BRACE);
		return prop;
	}

	Signal parse_signal_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		parse_member_declaration_modifiers ();
		expect (TokenType.SIGNAL);
		var type = parse_type ();
		string id = parse_identifier ();
		var sig = context.create_signal (id, type, get_src_com (begin));
		sig.access = access;
		set_attributes (sig, attrs);
		expect (TokenType.OPEN_PARENS);
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				var param = parse_parameter ();
				sig.add_parameter (param);
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_PARENS);
		expect (TokenType.SEMICOLON);
		return sig;
	}

	Constructor parse_constructor_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var flags = parse_member_declaration_modifiers ();
		expect (TokenType.CONSTRUCT);
		var c = context.create_constructor (get_src_com (begin));
		if (ModifierFlags.STATIC in flags) {
			c.instance = false;
		}
		c.body = parse_block ();
		return c;
	}

	Destructor parse_destructor_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		expect (TokenType.TILDE);
		parse_identifier ();
		expect (TokenType.OPEN_PARENS);
		expect (TokenType.CLOSE_PARENS);
		var d = context.create_destructor (get_src_com (begin));
		d.body = parse_block ();
		return d;
	}

	Symbol parse_struct_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		parse_type_declaration_modifiers ();
		expect (TokenType.STRUCT);
		var sym = parse_symbol_name ();
		var base_types = new ArrayList<DataType> ();
		if (accept (TokenType.COLON)) {
			do {
				base_types.add (parse_type ());
			} while (accept (TokenType.COMMA));
		}
		var st = context.create_struct (sym.name, get_src_com (begin));
		st.access = access;
		set_attributes (st, attrs);
		foreach (DataType base_type in base_types) {
			st.add_base_type (base_type);
		}

		parse_declarations (st);

		Symbol result = st;
		while (sym.inner != null) {
			sym = sym.inner;
			var ns = context.create_namespace (sym.name, st.source_reference);
			ns.pkg = scanner.source_file.pkg;
			if (result is Namespace) {
				ns.add_namespace ((Namespace) result);
			} else {
				ns.add_struct ((Struct) result);
				scanner.source_file.add_node (result);
			}
			result = ns;
		}
		return result;
	}

	void parse_struct_member (Struct st) throws ParseError {
		var sym = parse_declaration ();
		if (sym is Method) {
			st.add_method ((Method) sym);
		} else if (sym is Field) {
			st.add_field ((Field) sym);
		} else if (sym is Constant) {
			st.add_constant ((Constant) sym);
		} else if (sym == null) {
			// workaround for current limitation of exception handling
			throw new ParseError.SYNTAX ("syntax error in declaration");
		} else {
			Report.error (sym.source_reference, "unexpected declaration in struct");
		}
	}

	Symbol parse_interface_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		parse_type_declaration_modifiers ();
		expect (TokenType.INTERFACE);
		var sym = parse_symbol_name ();
		var type_param_list = parse_type_parameter_list ();
		var base_types = new ArrayList<DataType> ();
		if (accept (TokenType.COLON)) {
			do {
				base_types.add (parse_type ());
			} while (accept (TokenType.COMMA));
		}
		var iface = context.create_interface (sym.name, get_src_com (begin));
		iface.access = access;
		set_attributes (iface, attrs);
		foreach (TypeParameter type_param in type_param_list) {
			iface.add_type_parameter (type_param);
		}
		foreach (DataType base_type in base_types) {
			iface.add_prerequisite (base_type);
		}

		if (accept (TokenType.SEMICOLON)) {
			iface.is_imported = true;
			iface.declaration_only = true;
		} else {
			parse_declarations (iface);
		}

		Symbol result = iface;
		while (sym.inner != null) {
			sym = sym.inner;
			var ns = context.create_namespace (sym.name, iface.source_reference);
			ns.pkg = scanner.source_file.pkg;
			if (result is Namespace) {
				ns.add_namespace ((Namespace) result);
			} else {
				ns.add_interface ((Interface) result);
				scanner.source_file.add_node (result);
			}
			result = ns;
		}
		return result;
	}

	void parse_interface_member (Interface iface) throws ParseError {
		var sym = parse_declaration ();
		if (sym is Class) {
			iface.add_class ((Class) sym);
		} else if (sym is Struct) {
			iface.add_struct ((Struct) sym);
		} else if (sym is Enum) {
			iface.add_enum ((Enum) sym);
		} else if (sym is Delegate) {
			iface.add_delegate ((Delegate) sym);
		} else if (sym is Method) {
			iface.add_method ((Method) sym);
		} else if (sym is Signal) {
			iface.add_signal ((Signal) sym);
		} else if (sym is Field) {
			iface.add_field ((Field) sym);
		} else if (sym is Property) {
			iface.add_property ((Property) sym);
		} else if (sym == null) {
			// workaround for current limitation of exception handling
			throw new ParseError.SYNTAX ("syntax error in declaration");
		} else {
			Report.error (sym.source_reference, "unexpected declaration in interface");
		}
	}

	Symbol parse_enum_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		parse_type_declaration_modifiers ();
		expect (TokenType.ENUM);
		var sym = parse_symbol_name ();
		var en = context.create_enum (sym.name, get_src_com (begin));
		en.access = access;
		set_attributes (en, attrs);

		expect (TokenType.OPEN_BRACE);
		do {
			if (current () == TokenType.CLOSE_BRACE) {
				// allow trailing comma
				break;
			}
			string id = parse_identifier ();
			var ev = context.create_enum_value (id, get_src (begin));
			if (accept (TokenType.ASSIGN)) {
				ev.value = parse_expression ();
			}
			en.add_value (ev);
		} while (accept (TokenType.COMMA));
		if (accept (TokenType.SEMICOLON)) {
			// enum methods
			while (current () != TokenType.CLOSE_BRACE) {
				var sym = parse_declaration ();
				if (sym is Method) {
					en.add_method ((Method) sym);
				} else if (sym == null) {
					// workaround for current limitation of exception handling
					throw new ParseError.SYNTAX ("syntax error in declaration");
				} else {
					Report.error (sym.source_reference, "unexpected declaration in enum");
				}
			}
		}
		expect (TokenType.CLOSE_BRACE);

		Symbol result = en;
		while (sym.inner != null) {
			sym = sym.inner;
			var ns = context.create_namespace (sym.name, en.source_reference);
			ns.pkg = scanner.source_file.pkg;
			if (result is Namespace) {
				ns.add_namespace ((Namespace) result);
			} else {
				ns.add_enum ((Enum) result);
				scanner.source_file.add_node (result);
			}
			result = ns;
		}
		return result;
	}

	Symbol parse_errordomain_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		parse_type_declaration_modifiers ();
		expect (TokenType.ERRORDOMAIN);
		var sym = parse_symbol_name ();
		var ed = context.create_error_domain (sym.name, get_src_com (begin));
		ed.access = access;
		set_attributes (ed, attrs);

		expect (TokenType.OPEN_BRACE);
		do {
			if (current () == TokenType.CLOSE_BRACE) {
				// allow trailing comma
				break;
			}
			string id = parse_identifier ();
			var ec = context.create_error_code (id);
			if (accept (TokenType.ASSIGN)) {
				ec.value = parse_expression ();
			}
			ed.add_code (ec);
		} while (accept (TokenType.COMMA));
		if (accept (TokenType.SEMICOLON)) {
			// errordomain methods
			while (current () != TokenType.CLOSE_BRACE) {
				var sym = parse_declaration ();
				if (sym is Method) {
					ed.add_method ((Method) sym);
				} else if (sym == null) {
					// workaround for current limitation of exception handling
					throw new ParseError.SYNTAX ("syntax error in declaration");
				} else {
					Report.error (sym.source_reference, "unexpected declaration in errordomain");
				}
			}
		}
		expect (TokenType.CLOSE_BRACE);

		Symbol result = ed;
		while (sym.inner != null) {
			sym = sym.inner;
			var ns = context.create_namespace (sym.name, ed.source_reference);
			ns.pkg = scanner.source_file.pkg;
			if (result is Namespace) {
				ns.add_namespace ((Namespace) result);
			} else {
				ns.add_error_domain ((ErrorDomain) result);
				scanner.source_file.add_node (result);
			}
			result = ns;
		}
		return result;
	}

	SymbolAccessibility parse_access_modifier (SymbolAccessibility default_access = SymbolAccessibility.PRIVATE) {
		switch (current ()) {
		case TokenType.PRIVATE:
			next ();
			return SymbolAccessibility.PRIVATE;
		case TokenType.PROTECTED:
			next ();
			return SymbolAccessibility.PROTECTED;
		case TokenType.PUBLIC:
			next ();
			return SymbolAccessibility.PUBLIC;
		default:
			return default_access;
		}
	}

	ModifierFlags parse_type_declaration_modifiers () {
		ModifierFlags flags = 0;
		while (true) {
			switch (current ()) {
			case TokenType.ABSTRACT:
				next ();
				flags |= ModifierFlags.ABSTRACT;
				break;
			case TokenType.STATIC:
				next ();
				flags |= ModifierFlags.STATIC;
				break;
			default:
				return flags;
			}
		}
		return flags;
	}

	ModifierFlags parse_member_declaration_modifiers () {
		ModifierFlags flags = 0;
		while (true) {
			switch (current ()) {
			case TokenType.ABSTRACT:
				next ();
				flags |= ModifierFlags.ABSTRACT;
				break;
			case TokenType.CLASS:
				next ();
				flags |= ModifierFlags.CLASS;
				break;
			case TokenType.INLINE:
				next ();
				flags |= ModifierFlags.INLINE;
				break;
			case TokenType.OVERRIDE:
				next ();
				flags |= ModifierFlags.OVERRIDE;
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
		}
		return flags;
	}

	FormalParameter parse_parameter () throws ParseError {
		var attrs = parse_attributes ();
		var begin = get_location ();
		if (accept (TokenType.ELLIPSIS)) {
			// varargs
			return context.create_formal_parameter_with_ellipsis (get_src (begin));
		}
		bool construct_param = accept (TokenType.CONSTRUCT);
		var type = parse_type ();
		var ut = type as UnresolvedType;
		if (ut != null) {
			if (!ut.is_weak) {
				ut.takes_ownership = true;
			}
			if (!ut.is_ref && !ut.is_out && !ut.transfers_ownership) {
				//  take_ownership for in parameters that don't transfer ownership is not supported
				ut.takes_ownership = false;
			}
		}
		string id = parse_identifier ();
		var param = context.create_formal_parameter (id, type, get_src (begin));
		set_attributes (param, attrs);
		param.construct_parameter = construct_param;
		if (accept (TokenType.ASSIGN)) {
			param.default_expression = parse_expression ();
		}
		return param;
	}

	CreationMethod parse_creation_method_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		parse_member_declaration_modifiers ();
		var sym = parse_symbol_name ();
		CreationMethod method;
		if (sym.inner == null) {
			method = context.create_creation_method (sym.name, null, get_src_com (begin));
		} else {
			method = context.create_creation_method (sym.inner.name, sym.name, get_src_com (begin));
		}
		expect (TokenType.OPEN_PARENS);
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				method.add_parameter (parse_parameter ());
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_PARENS);
		if (accept (TokenType.THROWS)) {
			do {
				method.add_error_domain (parse_type ());
			} while (accept (TokenType.COMMA));
		}
		method.access = access;
		set_attributes (method, attrs);
		method.instance = false;
		if (!accept (TokenType.SEMICOLON)) {
			method.body = parse_block ();
		}
		return method;
	}

	Symbol parse_delegate_declaration (Gee.List<Attribute> attrs) throws ParseError {
		var begin = get_location ();
		var access = parse_access_modifier ();
		var flags = parse_member_declaration_modifiers ();
		expect (TokenType.DELEGATE);
		var type = parse_type ();
		var sym = parse_symbol_name ();
		var type_param_list = parse_type_parameter_list ();
		var d = context.create_delegate (sym.name, type, get_src_com (begin));
		d.access = access;
		set_attributes (d, attrs);
		if (!(ModifierFlags.STATIC in flags)) {
			d.instance = true;
		}
		foreach (TypeParameter type_param in type_param_list) {
			d.add_type_parameter (type_param);
		}
		expect (TokenType.OPEN_PARENS);
		if (current () != TokenType.CLOSE_PARENS) {
			do {
				d.add_parameter (parse_parameter ());
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.CLOSE_PARENS);
		if (accept (TokenType.THROWS)) {
			do {
				parse_type ();
			} while (accept (TokenType.COMMA));
		}
		expect (TokenType.SEMICOLON);

		Symbol result = d;
		while (sym.inner != null) {
			sym = sym.inner;
			var ns = context.create_namespace (sym.name, d.source_reference);
			ns.pkg = scanner.source_file.pkg;
			if (result is Namespace) {
				ns.add_namespace ((Namespace) result);
			} else {
				ns.add_delegate ((Delegate) result);
				scanner.source_file.add_node (result);
			}
			result = ns;
		}
		return result;
	}

	Gee.List<TypeParameter> parse_type_parameter_list () throws ParseError {
		var list = new ArrayList<TypeParameter> ();
		if (accept (TokenType.OP_LT)) {
			do {
				var begin = get_location ();
				string id = parse_identifier ();
				list.add (context.create_type_parameter (id, get_src (begin)));
			} while (accept (TokenType.COMMA));
			expect (TokenType.OP_GT);
		}
		return list;
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
	Gee.List<DataType> parse_type_argument_list (bool maybe_expression) throws ParseError {
		var begin = get_location ();
		if (accept (TokenType.OP_LT)) {
			var list = new ArrayList<DataType> ();
			do {
				switch (current ()) {
				case TokenType.VOID:
				case TokenType.WEAK:
				case TokenType.IDENTIFIER:
					var type = parse_type ();
					if (!((UnresolvedType) type).is_weak) {
						type.takes_ownership = true;
					}
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

	MemberAccess parse_member_name () throws ParseError {
		var begin = get_location ();
		MemberAccess expr = null;
		do {
			string id = parse_identifier ();
			var type_arg_list = parse_type_argument_list (false);
			expr = context.create_member_access (expr, id, get_src (begin));
			if (type_arg_list != null) {
				foreach (DataType type_arg in type_arg_list) {
					expr.add_type_argument (type_arg);
				}
			}
		} while (accept (TokenType.DOT));
		return expr;
	}

	bool is_declaration_keyword (TokenType type) {
		switch (type) {
		case TokenType.ABSTRACT:
		case TokenType.CLASS:
		case TokenType.CONST:
		case TokenType.DELEGATE:
		case TokenType.ENUM:
		case TokenType.ERRORDOMAIN:
		case TokenType.INLINE:
		case TokenType.INTERFACE:
		case TokenType.NAMESPACE:
		case TokenType.OVERRIDE:
		case TokenType.PRIVATE:
		case TokenType.PROTECTED:
		case TokenType.PUBLIC:
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
}

public errordomain Vala.ParseError {
	FAILED,
	SYNTAX
}

