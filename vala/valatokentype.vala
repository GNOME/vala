/* valatokentype.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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

public enum Vala.TokenType {
	NONE,
	ABSTRACT,
	AS,
	ASSIGN,
	ASSIGN_ADD,
	ASSIGN_BITWISE_AND,
	ASSIGN_BITWISE_OR,
	ASSIGN_BITWISE_XOR,
	ASSIGN_DIV,
	ASSIGN_MUL,
	ASSIGN_PERCENT,
	ASSIGN_SHIFT_LEFT,
	ASSIGN_SUB,
	BASE,
	BITWISE_AND,
	BITWISE_OR,
	BREAK,
	CARRET,
	CASE,
	CATCH,
	CHARACTER_LITERAL,
	CLASS,
	CLOSE_BRACE,
	CLOSE_BRACKET,
	CLOSE_PARENS,
	COLON,
	COMMA,
	CONST,
	CONSTRUCT,
	CONTINUE,
	DEFAULT,
	DELEGATE,
	DELETE,
	DIV,
	DO,
	DOUBLE_COLON,
	DOT,
	DYNAMIC,
	ELLIPSIS,
	ELSE,
	ENUM,
	ENSURES,
	ERRORDOMAIN,
	EOF,
	EXTERN,
	FALSE,
	FINALLY,
	FOR,
	FOREACH,
	GET,
	HASH,
	IDENTIFIER,
	IF,
	IN,
	INLINE,
	INTEGER_LITERAL,
	INTERFACE,
	INTERR,
	IS,
	LAMBDA,
	LOCK,
	MINUS,
	NAMESPACE,
	NEW,
	NULL,
	OUT,
	OP_AND,
	OP_DEC,
	OP_EQ,
	OP_GE,
	OP_GT,
	OP_INC,
	OP_LE,
	OP_LT,
	OP_NE,
	OP_NEG,
	OP_OR,
	OP_PTR,
	OP_SHIFT_LEFT,
	OPEN_BRACE,
	OPEN_BRACKET,
	OPEN_PARENS,
	OVERRIDE,
	PERCENT,
	PLUS,
	PRIVATE,
	PROTECTED,
	PUBLIC,
	REAL_LITERAL,
	REF,
	REQUIRES,
	RETURN,
	SEMICOLON,
	SET,
	SIGNAL,
	SIZEOF,
	STAR,
	STATIC,
	STRING_LITERAL,
	STRUCT,
	SWITCH,
	THIS,
	THROW,
	THROWS,
	TILDE,
	TRUE,
	TRY,
	TYPEOF,
	USING,
	VAR,
	VERBATIM_STRING_LITERAL,
	VIRTUAL,
	VOID,
	VOLATILE,
	WEAK,
	WHILE;

	public weak string to_string () {
		switch (this) {
		case ABSTRACT: return "`abstract'";
		case AS: return "`as'";
		case ASSIGN: return "`='";
		case ASSIGN_ADD: return "`+='";
		case ASSIGN_BITWISE_AND: return "`&='";
		case ASSIGN_BITWISE_OR: return "`|='";
		case ASSIGN_BITWISE_XOR: return "`^='";
		case ASSIGN_DIV: return "`/='";
		case ASSIGN_MUL: return "`*='";
		case ASSIGN_PERCENT: return "`%='";
		case ASSIGN_SHIFT_LEFT: return "`<<='";
		case ASSIGN_SUB: return "`-='";
		case BASE: return "`base'";
		case BITWISE_AND: return "`&'";
		case BITWISE_OR: return "`|'";
		case BREAK: return "`break'";
		case CARRET: return "`^'";
		case CASE: return "`case'";
		case CATCH: return "`catch'";
		case CHARACTER_LITERAL: return "character literal";
		case CLASS: return "`class'";
		case CLOSE_BRACE: return "`}'";
		case CLOSE_BRACKET: return "`]'";
		case CLOSE_PARENS: return "`)'";
		case COLON: return "`:'";
		case COMMA: return "`,'";
		case CONST: return "`const'";
		case CONSTRUCT: return "`construct'";
		case CONTINUE: return "`continue'";
		case DEFAULT: return "`default'";
		case DELEGATE: return "`delegate'";
		case DELETE: return "`delete'";
		case DIV: return "`/'";
		case DO: return "`do'";
		case DOT: return "`.'";
		case ELLIPSIS: return "`...'";
		case ELSE: return "`else'";
		case ENUM: return "`enum'";
		case ENSURES: return "`ensures'";
		case ERRORDOMAIN: return "`errordomain'";
		case EOF: return "end of file";
		case FALSE: return "`false'";
		case FINALLY: return "`finally'";
		case FOR: return "`for'";
		case FOREACH: return "`foreach'";
		case GET: return "`get'";
		case HASH: return "`hash'";
		case IDENTIFIER: return "identifier";
		case IF: return "`if'";
		case IN: return "`in'";
		case INLINE: return "`inline'";
		case INTEGER_LITERAL: return "integer literal";
		case INTERFACE: return "`interface'";
		case INTERR: return "`?'";
		case IS: return "`is'";
		case LAMBDA: return "`=>'";
		case LOCK: return "`lock'";
		case MINUS: return "`-'";
		case NAMESPACE: return "`namespace'";
		case NEW: return "`new'";
		case NULL: return "`null'";
		case OUT: return "`out'";
		case OP_AND: return "`&&'";
		case OP_DEC: return "`--'";
		case OP_EQ: return "`=='";
		case OP_GE: return "`>='";
		case OP_GT: return "`>'";
		case OP_INC: return "`++'";
		case OP_LE: return "`<='";
		case OP_LT: return "`<'";
		case OP_NE: return "`!='";
		case OP_NEG: return "`!'";
		case OP_OR: return "`||'";
		case OP_PTR: return "`->'";
		case OP_SHIFT_LEFT: return "`<<'";
		case OPEN_BRACE: return "`{'";
		case OPEN_BRACKET: return "`['";
		case OPEN_PARENS: return "`('";
		case OVERRIDE: return "`override'";
		case PERCENT: return "`%'";
		case PLUS: return "`+'";
		case PRIVATE: return "`private'";
		case PROTECTED: return "`protected'";
		case PUBLIC: return "`public'";
		case REAL_LITERAL: return "real literal";
		case REF: return "`ref'";
		case REQUIRES: return "`requires'";
		case RETURN: return "`return'";
		case SEMICOLON: return "`;'";
		case SET: return "`set'";
		case SIGNAL: return "`signal'";
		case SIZEOF: return "`sizeof'";
		case STAR: return "`*'";
		case STATIC: return "`static'";
		case STRING_LITERAL: return "string literal";
		case STRUCT: return "`struct'";
		case SWITCH: return "`switch'";
		case THIS: return "`this'";
		case THROW: return "`throw'";
		case THROWS: return "`throws'";
		case TILDE: return "`~'";
		case TRUE: return "`true'";
		case TRY: return "`try'";
		case TYPEOF: return "`typeof'";
		case USING: return "`using'";
		case VAR: return "`var'";
		case VIRTUAL: return "`virtual'";
		case VOID: return "`void'";
		case VOLATILE: return "`volatile'";
		case WEAK: return "`weak'";
		case WHILE: return "`while'";
		default: return "unknown token";
		}
	}
}

