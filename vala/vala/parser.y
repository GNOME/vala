/* parser.y
 *
 * Copyright (C) 2006  Jürg Billeter, Raffaele Sandrini
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <glib.h>

#include "vala.h"
#include "parser.h"

#define src(l) (vala_source_reference_new (current_source_file, l.first_line, l.first_column, l.last_line, l.last_column))

#define src_com(l,c) (vala_source_reference_new_with_comment (current_source_file, l.first_line, l.first_column, l.last_line, l.last_column, c))

static ValaSourceFile *current_source_file;
static ValaNamespace *current_namespace;
static gboolean current_namespace_implicit;
static ValaClass *current_class;
static ValaStruct *current_struct;
static ValaInterface *current_interface;

typedef enum {
	VALA_MODIFIER_NONE,
	VALA_MODIFIER_ABSTRACT = 1 << 0,
	VALA_MODIFIER_OVERRIDE = 1 << 1,
	VALA_MODIFIER_STATIC = 1 << 2,
	VALA_MODIFIER_VIRTUAL = 1 << 3,
} ValaModifier;

int yylex (YYSTYPE *yylval_param, YYLTYPE *yylloc_param, ValaParser *parser);
static void yyerror (YYLTYPE *locp, ValaParser *parser, const char *msg);
%}

%defines
%locations
%pure-parser
%parse-param {ValaParser *parser}
%lex-param {ValaParser *parser}
%error-verbose
%union {
	int num;
	char *str;
	GList *list;
	ValaLiteral *literal;
	ValaTypeReference *type_reference;
	ValaExpression *expression;
	ValaStatement *statement;
	ValaNamespace *namespace;
	ValaClass *class;
	ValaStruct *struct_;
	ValaInterface *interface;
	ValaEnum *enum_;
	ValaEnumValue *enum_value;
	ValaFlags *flags;
	ValaFlagsValue *flags_value;
	ValaCallback *callback;
	ValaConstant *constant;
	ValaField *field;
	ValaMethod *method;
	ValaFormalParameter *formal_parameter;
	ValaProperty *property;
	ValaPropertyAccessor *property_accessor;
	ValaSignal *signal;
	ValaConstructor *constructor;
	ValaDestructor *destructor;
	ValaLocalVariableDeclaration *local_variable_declaration;
	ValaVariableDeclarator *variable_declarator;
	ValaTypeParameter *type_parameter;
	ValaAttribute *attribute;
	ValaNamedArgument *named_argument;
}

%token OPEN_BRACE "{"
%token CLOSE_BRACE "}"
%token OPEN_PARENS "("
%token OPEN_CAST_PARENS "cast ("
%token CLOSE_PARENS ")"
%token OPEN_BRACKET "["
%token CLOSE_BRACKET "]"
%token ELLIPSIS "..."
%token DOT "."
%token COLON ":"
%token COMMA ","
%token SEMICOLON ";"
%token HASH "#"
%token INTERR "?"

%token ASSIGN_BITWISE_OR "|="
%token ASSIGN_BITWISE_AND "&="
%token ASSIGN_BITWISE_XOR "^="
%token ASSIGN_ADD "+="
%token ASSIGN_SUB "-="
%token ASSIGN_MUL "*="
%token ASSIGN_DIV "/="
%token ASSIGN_PERCENT "%="
%token ASSIGN_SHIFT_LEFT "<<="
%token ASSIGN_SHIFT_RIGHT ">>="

%token OP_INC "++"
%token OP_DEC "--"
%token OP_EQ "=="
%token OP_NE "!="
%token OP_SHIFT_LEFT "<<"
%token OP_SHIFT_RIGHT ">>"
%token OP_LE "<="
%token OP_GE ">="
%token LAMBDA "=>"
%token GENERIC_LT "generic <"
%token OP_LT "<"
%token OP_GT ">"
%token OP_NEG "!"
%token CARRET "^"
%token BITWISE_OR "|"
%token BITWISE_AND "&"
%token OP_OR "||"
%token OP_AND "&&"
%token TILDE "~"

%token ASSIGN "="
%token PLUS "+"
%token MINUS "-"
%token STAR "*"
%token DIV "/"
%token PERCENT "%"

%token ABSTRACT "abstract"
%token BREAK "break"
%token CALLBACK "callback"
%token CLASS "class"
%token CONST "const"
%token CONSTRUCT "construct"
%token CONTINUE "continue"
%token ELSE "else"
%token ENUM "enum"
%token VALA_FALSE "false"
%token FLAGS "flags"
%token FOR "for"
%token FOREACH "foreach"
%token GET "get"
%token IF "if"
%token IN "in"
%token INTERFACE "interface"
%token IS "is"
%token NAMESPACE "namespace"
%token NEW "new"
%token VALA_NULL "null"
%token OUT "out"
%token OVERRIDE "override"
%token PUBLIC "public"
%token PRIVATE "private"
%token REF "ref"
%token SET "set"
%token SIGNAL "signal"
%token STATIC "static"
%token STRUCT "struct"
%token RETURN "return"
%token VALA_TRUE "true"
%token TYPEOF "typeof"
%token USING "using"
%token VAR "var"
%token VIRTUAL "virtual"
%token WEAK "weak"
%token WHILE "while"

%token <str> IDENTIFIER "identifier"
%token <str> INTEGER_LITERAL "integer"
%token <str> REAL_LITERAL "real"
%token <str> CHARACTER_LITERAL "character"
%token <str> STRING_LITERAL "string"

%type <str> comment
%type <literal> literal
%type <literal> boolean_literal
%type <type_reference> type_name
%type <type_reference> type
%type <list> opt_argument_list
%type <list> argument_list
%type <expression> argument
%type <expression> primary_expression
%type <expression> simple_name
%type <expression> parenthesized_expression
%type <expression> member_access
%type <str> identifier_or_new
%type <expression> invocation_expression
%type <expression> post_increment_expression
%type <expression> post_decrement_expression
%type <expression> object_creation_expression
%type <expression> typeof_expression
%type <expression> unary_expression
%type <expression> cast_expression
%type <expression> multiplicative_expression
%type <expression> additive_expression
%type <expression> shift_expression
%type <expression> relational_expression
%type <expression> equality_expression
%type <expression> and_expression
%type <expression> exclusive_or_expression
%type <expression> inclusive_or_expression
%type <expression> conditional_and_expression
%type <expression> conditional_or_expression
%type <expression> conditional_expression
%type <expression> lambda_expression
%type <list> opt_lambda_parameter_list
%type <list> lambda_parameter_list
%type <expression> assignment
%type <num> assignment_operator
%type <expression> opt_expression
%type <expression> expression
%type <statement> statement
%type <statement> embedded_statement
%type <statement> block
%type <list> opt_statement_list
%type <list> statement_list
%type <statement> empty_statement
%type <statement> declaration_statement
%type <local_variable_declaration> local_variable_declaration
%type <type_reference> local_variable_type
%type <num> opt_op_neg
%type <statement> expression_statement
%type <expression> statement_expression
%type <statement> selection_statement
%type <statement> if_statement
%type <statement> iteration_statement
%type <statement> while_statement
%type <statement> for_statement
%type <list> opt_statement_expression_list
%type <list> statement_expression_list
%type <statement> foreach_statement
%type <statement> jump_statement
%type <statement> break_statement
%type <statement> continue_statement
%type <statement> return_statement
%type <namespace> namespace_declaration
%type <str> opt_name_specifier
%type <str> name_specifier
%type <class> class_declaration
%type <num> opt_access_modifier
%type <num> access_modifier
%type <num> opt_modifiers
%type <num> modifiers
%type <num> modifier
%type <list> opt_class_base
%type <list> class_base
%type <list> type_list
%type <property> property_declaration
%type <property_accessor> get_accessor_declaration
%type <property_accessor> opt_set_accessor_declaration
%type <property_accessor> set_accessor_declaration
%type <struct_> struct_declaration
%type <struct_> struct_header
%type <interface> interface_declaration
%type <enum_> enum_declaration
%type <list> enum_body
%type <list> opt_enum_member_declarations
%type <list> enum_member_declarations
%type <enum_value> enum_member_declaration
%type <flags> flags_declaration
%type <callback> callback_declaration
%type <constant> constant_declaration
%type <variable_declarator> constant_declarator
%type <field> field_declaration
%type <list> variable_declarators
%type <variable_declarator> variable_declarator
%type <list> initializer_list
%type <expression> initializer
%type <method> method_declaration
%type <method> method_header
%type <statement> method_body
%type <list> opt_formal_parameter_list
%type <list> formal_parameter_list
%type <list> fixed_parameters
%type <formal_parameter> fixed_parameter
%type <signal> signal_declaration
%type <constructor> constructor_declaration
%type <destructor> destructor_declaration
%type <list> opt_attributes
%type <list> attributes
%type <list> attribute_sections
%type <list> attribute_section
%type <list> attribute_list
%type <attribute> attribute
%type <str> attribute_name
%type <list> opt_named_argument_list
%type <list> named_argument_list
%type <named_argument> named_argument
%type <list> opt_type_parameter_list
%type <list> type_parameter_list
%type <list> type_parameters
%type <type_parameter> type_parameter
%type <list> opt_type_argument_list
%type <list> type_argument_list
%type <list> type_arguments
%type <type_reference> type_argument

/* expect shift/reduce conflict on if/else */
%expect 1

%start compilation_unit

%%

opt_comma
	: /* empty */
	| COMMA
	;

literal
	: boolean_literal
	| INTEGER_LITERAL
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_LITERAL (vala_integer_literal_new ($1, src));
		g_object_unref (src);
		g_free ($1);
	  }
	| REAL_LITERAL
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_LITERAL (vala_real_literal_new ($1, src));
		g_free ($1);
		g_object_unref (src);
	  }
	| CHARACTER_LITERAL
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_LITERAL (vala_character_literal_new ($1, src));
		g_object_unref (src);
		g_free ($1);
	  }
	| STRING_LITERAL
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_LITERAL (vala_string_literal_new ($1, src));
		g_object_unref (src);
		g_free ($1);
	  }
	| VALA_NULL
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_LITERAL (vala_null_literal_new (src));
		g_object_unref (src);
	  }
	;

boolean_literal
	: VALA_TRUE
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_LITERAL (vala_boolean_literal_new (TRUE, src));
		g_object_unref (src);
	  }
	| VALA_FALSE
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_LITERAL (vala_boolean_literal_new (FALSE, src));
		g_object_unref (src);
	  }
	;

compilation_unit
	: opt_using_directives opt_outer_declarations
	;

type_name
	: IDENTIFIER opt_type_argument_list
	  {
	  	GList *l;
		ValaSourceReference *src = src(@1);
		$$ = vala_type_reference_new (NULL, $1, src);
		g_free ($1);
		g_object_unref (src);
		for (l = $2; l != NULL; l = l->next) {
			vala_type_reference_add_type_argument ($$, l->data);
			g_object_unref (l->data);
		}
		g_list_free ($2);
	  }
	| IDENTIFIER DOT IDENTIFIER opt_type_argument_list
	  {
	  	GList *l;
		ValaSourceReference *src = src(@1);
		$$ = vala_type_reference_new ($1, $3, src);
		g_free ($1);
		g_free ($3);
		g_object_unref (src);
		for (l = $4; l != NULL; l = l->next) {
			vala_type_reference_add_type_argument ($$, l->data);
			g_object_unref (l->data);
		}
		g_list_free ($4);
	  }
	;

type
	: type_name opt_op_neg
	  {
		$$ = $1;
		if ($2) {
			vala_type_reference_set_non_null ($$, TRUE);
		}
	  }
	| REF type_name opt_op_neg
	  {
		$$ = $2;
		vala_type_reference_set_is_ref ($$, TRUE);
		if ($3) {
			vala_type_reference_set_non_null ($$, TRUE);
		}
	  }
	| WEAK type_name opt_op_neg
	  {
		$$ = $2;
		vala_type_reference_set_is_weak ($$, TRUE);
		if ($3) {
			vala_type_reference_set_non_null ($$, TRUE);
		}
	  }
	| OUT type_name opt_op_neg
	  {
		$$ = $2;
		vala_type_reference_set_is_out ($$, TRUE);
		if ($3) {
			vala_type_reference_set_non_null ($$, TRUE);
		}
	  }
	| OUT REF type_name opt_op_neg
	  {
		$$ = $3;
		vala_type_reference_set_is_ref ($$, TRUE);
		vala_type_reference_set_is_out ($$, TRUE);
		if ($4) {
			vala_type_reference_set_non_null ($$, TRUE);
		}
	  }
	| type array_qualifier
	  {
		$$ = $1;
		vala_type_reference_set_array ($$, TRUE);
	  }
	;

array_qualifier
	: OPEN_BRACKET CLOSE_BRACKET
	;

opt_argument_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| argument_list
	;

argument_list
	: argument
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| argument_list COMMA argument
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

argument
	: expression
	;

primary_expression
	: literal
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_literal_expression_new ($1, src));
		g_object_unref (src);
		g_object_unref ($1);
	  }
	| simple_name
	| parenthesized_expression
	| member_access
	| invocation_expression
	| post_increment_expression
	| post_decrement_expression
	| object_creation_expression
	| typeof_expression
	;

simple_name
	: IDENTIFIER
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_simple_name_new ($1, src));
		g_free ($1);
		g_object_unref (src);
	  }
	;

parenthesized_expression
	: OPEN_PARENS expression CLOSE_PARENS
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_parenthesized_expression_new ($2, src));
		g_object_unref (src);
		g_object_unref ($2);
	  }
	;

member_access
	: primary_expression DOT identifier_or_new
	  {
		ValaSourceReference *src = src(@3);
		$$ = VALA_EXPRESSION (vala_member_access_new ($1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_free ($3);
	  }
	;

identifier_or_new
	: IDENTIFIER
	| NEW
	  {
		$$ = g_strdup ("new");
	  }
	;

invocation_expression
	: primary_expression OPEN_PARENS opt_argument_list CLOSE_PARENS
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_invocation_expression_new ($1, $3, src));
		g_object_unref ($1);
		if ($3 != NULL) {
			g_list_free ($3);
		}
		g_object_unref (src);
	  }
	;

post_increment_expression
	: primary_expression OP_INC
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_postfix_expression_new ($1, TRUE, src));
		g_object_unref (src);
		g_object_unref ($1);
	  }
	;

post_decrement_expression
	: primary_expression OP_DEC
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_postfix_expression_new ($1, FALSE, src));
		g_object_unref (src);
		g_object_unref ($1);
	  }
	;

object_creation_expression
	: NEW type OPEN_PARENS opt_named_argument_list CLOSE_PARENS
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_object_creation_expression_new ($2, $4, src));
		g_object_unref ($2);
		if ($4 != NULL) {
			g_list_free ($4);
		}
		g_object_unref (src);
	  }
	;

typeof_expression
	: TYPEOF OPEN_PARENS type_name CLOSE_PARENS
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_typeof_expression_new ($3, src));
		g_object_unref ($3);
		g_object_unref (src);
	  }

unary_expression
	: primary_expression
	| PLUS unary_expression
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_unary_expression_new (VALA_UNARY_OPERATOR_PLUS, $2, src));
		g_object_unref (src);
		g_object_unref ($2);
	  }
	| MINUS unary_expression
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_unary_expression_new (VALA_UNARY_OPERATOR_MINUS, $2, src));
		g_object_unref (src);
		g_object_unref ($2);
	  }
	| OP_NEG unary_expression
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_unary_expression_new (VALA_UNARY_OPERATOR_LOGICAL_NEGATION, $2, src));
		g_object_unref (src);
		g_object_unref ($2);
	  }
	| REF unary_expression
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_unary_expression_new (VALA_UNARY_OPERATOR_REF, $2, src));
		g_object_unref (src);
		g_object_unref ($2);
	  }
	| OUT unary_expression
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_unary_expression_new (VALA_UNARY_OPERATOR_OUT, $2, src));
		g_object_unref (src);
		g_object_unref ($2);
	  }
	| cast_expression
	;

cast_expression
	: OPEN_CAST_PARENS type CLOSE_PARENS unary_expression
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_cast_expression_new ($4, $2, src));
		g_object_unref (src);
		g_object_unref ($2);
		g_object_unref ($4);
	  }
	;

multiplicative_expression
	: unary_expression
	| multiplicative_expression STAR unary_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_MUL, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	| multiplicative_expression DIV unary_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_DIV, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	| multiplicative_expression PERCENT unary_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_MOD, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	;

additive_expression
	: multiplicative_expression
	| additive_expression PLUS multiplicative_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_PLUS, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	| additive_expression MINUS multiplicative_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_MINUS, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	;

shift_expression
	: additive_expression
	| shift_expression OP_SHIFT_LEFT additive_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_SHIFT_LEFT, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	/* don't use two OP_GT due to resolve parse conflicts
	 * stacked generics won't be that common in vala */
	| shift_expression OP_SHIFT_RIGHT additive_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_SHIFT_RIGHT, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	;

relational_expression
	: shift_expression
	| relational_expression OP_LT shift_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_LESS_THAN, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	| relational_expression OP_GT shift_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_GREATER_THAN, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	| relational_expression OP_LE shift_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_LESS_THAN_OR_EQUAL, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	| relational_expression OP_GE shift_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_GREATER_THAN_OR_EQUAL, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	| relational_expression IS type
	  {
		ValaSourceReference *src = src(@2);
	  	$$ = VALA_EXPRESSION (vala_type_check_new ($1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	;

equality_expression
	: relational_expression
	| equality_expression OP_EQ relational_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_EQUALITY, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	| equality_expression OP_NE relational_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_INEQUALITY, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	;

and_expression
	: equality_expression
	| and_expression BITWISE_AND equality_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_BITWISE_AND, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression CARRET and_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_BITWISE_XOR, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression BITWISE_OR exclusive_or_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_BITWISE_OR, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	;

conditional_and_expression
	: inclusive_or_expression
	| conditional_and_expression OP_AND inclusive_or_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_AND, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	;

conditional_or_expression
	: conditional_and_expression
	| conditional_or_expression OP_OR conditional_and_expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_OR, $1, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	;

conditional_expression
	: conditional_or_expression
	| conditional_or_expression INTERR expression COLON expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_conditional_expression_new ($1, $3, $5, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
		g_object_unref ($5);
	  }
	;

lambda_expression
	: OPEN_PARENS opt_lambda_parameter_list CLOSE_PARENS LAMBDA expression
	  {
		ValaSourceReference *src = src(@4);
		$$ = VALA_EXPRESSION (vala_lambda_expression_new ($2, $5, src));
		if ($2 != NULL) {
			g_list_free ($2);
		}
		g_object_unref ($5);
		g_object_unref (src);
	  }
	| IDENTIFIER LAMBDA expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_lambda_expression_new (NULL, $3, src));
		g_object_unref ($3);
		g_object_unref (src);
		vala_lambda_expression_add_parameter (VALA_LAMBDA_EXPRESSION ($$), $1);
		g_free ($1);
	  }
	;

opt_lambda_parameter_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| lambda_parameter_list
	;

lambda_parameter_list
	: IDENTIFIER COMMA IDENTIFIER
	  {
		$$ = g_list_append (NULL, $1);
		$$ = g_list_append ($$, $3);
	  }
	| lambda_parameter_list COMMA IDENTIFIER
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

assignment
	: unary_expression assignment_operator expression
	  {
		ValaSourceReference *src = src(@2);
		$$ = VALA_EXPRESSION (vala_assignment_new ($1, $2, $3, src));
		g_object_unref (src);
		g_object_unref ($1);
		g_object_unref ($3);
	  }
	;

assignment_operator
	: ASSIGN
	  {
		$$ = VALA_ASSIGNMENT_OPERATOR_SIMPLE;
	  }
	| ASSIGN_BITWISE_OR
	  {
		$$ = VALA_ASSIGNMENT_OPERATOR_BITWISE_OR;
	  }
	| ASSIGN_BITWISE_AND
	  {
		$$ = VALA_ASSIGNMENT_OPERATOR_BITWISE_AND;
	  }
	| ASSIGN_BITWISE_XOR
	  {
		$$ = VALA_ASSIGNMENT_OPERATOR_BITWISE_XOR;
	  }
	| ASSIGN_ADD
	  {
		$$ = VALA_ASSIGNMENT_OPERATOR_ADD;
	  }
	| ASSIGN_SUB
	  {
		$$ = VALA_ASSIGNMENT_OPERATOR_SUB;
	  }
	| ASSIGN_MUL
	  {
		$$ = VALA_ASSIGNMENT_OPERATOR_MUL;
	  }
	| ASSIGN_DIV
	  {
		$$ = VALA_ASSIGNMENT_OPERATOR_DIV;
	  }
	| ASSIGN_PERCENT
	  {
		$$ = VALA_ASSIGNMENT_OPERATOR_PERCENT;
	  }
	| ASSIGN_SHIFT_LEFT
	  {
		$$ = VALA_ASSIGNMENT_OPERATOR_SHIFT_LEFT;
	  }
	| ASSIGN_SHIFT_RIGHT
	  {
		$$ = VALA_ASSIGNMENT_OPERATOR_SHIFT_RIGHT;
	  }
	;

opt_expression
	: /* empty */
	  {
		$$ = NULL;
	  }
	| expression
	;

expression
	: conditional_expression
	| lambda_expression
	| assignment
	| error
	  {
		$$ = NULL;
	  }
	;

statement
	: declaration_statement
	| embedded_statement
	;

embedded_statement
	: block
	| empty_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	;

block
	: OPEN_BRACE opt_statement_list CLOSE_BRACE
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_STATEMENT (vala_block_new (src));
		if ($2 != NULL) {
			GList *l;
			for (l = $2; l != NULL; l = l->next) {
				vala_block_add_statement (VALA_BLOCK ($$), l->data);
				g_object_unref (l->data);
			}
			g_list_free ($2);
		}
		g_object_unref (src);
	  }
	;

opt_statement_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| statement_list
	;

statement_list
	: statement
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| statement_list statement
	  {
		$$ = g_list_append ($1, $2);
	  }
	;

empty_statement
	: SEMICOLON
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_STATEMENT (vala_empty_statement_new (src));
		g_object_unref (src);
	  }
	;

declaration_statement
	: comment local_variable_declaration
	  {
		ValaSourceReference *src = src_com(@2, $1);
		$$ = VALA_STATEMENT (vala_declaration_statement_new ($2, src));
		g_object_unref (src);
		g_object_unref ($2);
	  }
	;

local_variable_declaration
	: local_variable_type variable_declarators SEMICOLON
	  {
	  	GList *l;
		ValaSourceReference *src = src(@2);
		$$ = vala_local_variable_declaration_new ($1, $2, src);
		g_object_unref (src);
		for (l = $2; l != NULL; l = l->next) {
			ValaVariableDeclarator *decl = l->data;
			decl->type_reference = g_object_ref ($1);
		}
		g_list_free ($2);
		g_object_unref ($1);
	  }
	| VAR variable_declarators SEMICOLON
	  {
		ValaSourceReference *src = src(@2);
		$$ = vala_local_variable_declaration_new_var ($2, src);
		g_list_free ($2);
		g_object_unref (src);
	  }
	;

/* don't use type to prevent reduce/reduce conflict */
local_variable_type
	: primary_expression opt_type_argument_list opt_op_neg
	  {
		ValaSourceReference *src = src(@1);
		$$ = vala_type_reference_new_from_expression ($1, src);
		g_object_unref (src);
		if ($3) {
			vala_type_reference_set_non_null ($$, TRUE);
		}
		GList *l;
		for (l = $2; l != NULL; l = l->next) {
			vala_type_reference_add_type_argument ($$, l->data);
			g_object_unref (l->data);
		}
		g_list_free ($2);
		g_object_unref ($1);
	  }
	| REF primary_expression opt_type_argument_list opt_op_neg
	  {
		ValaSourceReference *src = src(@2);
		$$ = vala_type_reference_new_from_expression ($2, src);
		g_object_unref (src);
		vala_type_reference_set_is_lvalue_ref ($$, TRUE);
		if ($4) {
			vala_type_reference_set_non_null ($$, TRUE);
		}
		GList *l;
		for (l = $3; l != NULL; l = l->next) {
			vala_type_reference_add_type_argument ($$, l->data);
			g_object_unref (l->data);
		}
		g_list_free ($3);
		g_object_unref ($2);
	  }
	| local_variable_type array_qualifier
	  {
		$$ = $1;
		vala_type_reference_set_array ($$, TRUE);
		g_object_unref ($1);
	  }
	;

opt_op_neg
	: /* empty */
	  {
		$$ = FALSE;
	  }
	| OP_NEG
	  {
		$$ = TRUE;
	  }
	;

expression_statement
	: comment statement_expression SEMICOLON
	  {
		ValaSourceReference *src = src_com(@2, $1);
		$$ = VALA_STATEMENT (vala_expression_statement_new ($2, src));
		g_object_unref (src);
		g_object_unref ($2);
	  }
	;

statement_expression
	: invocation_expression
	| object_creation_expression
	| assignment
	| post_increment_expression
	| post_decrement_expression
	;

selection_statement
	: if_statement
	;

if_statement
	: comment IF OPEN_PARENS expression CLOSE_PARENS embedded_statement
	  {
		ValaSourceReference *src = src_com(@4, $1);
		$$ = VALA_STATEMENT (vala_if_statement_new ($4, $6, NULL, src));
		g_object_unref (src);
		g_object_unref ($4);
		g_object_unref ($6);
	  }
	| comment IF OPEN_PARENS expression CLOSE_PARENS embedded_statement ELSE embedded_statement
	  {
		ValaSourceReference *src = src_com(@4, $1);
		$$ = VALA_STATEMENT (vala_if_statement_new ($4, $6, $8, src));
		g_object_unref (src);
		g_object_unref ($4);
		g_object_unref ($6);
		g_object_unref ($8);
	  }
	;

iteration_statement
	: while_statement
	| for_statement
	| foreach_statement
	;

while_statement
	: WHILE OPEN_PARENS expression CLOSE_PARENS embedded_statement
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_STATEMENT (vala_while_statement_new ($3, $5, src));
		g_object_unref (src);
		g_object_unref ($3);
		g_object_unref ($5);
	  }
	;

for_statement
	: FOR OPEN_PARENS opt_statement_expression_list SEMICOLON opt_expression SEMICOLON opt_statement_expression_list CLOSE_PARENS embedded_statement
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_STATEMENT (vala_for_statement_new ($3, $5, $7, $9, src));
		g_object_unref (src);
		if ($5 != NULL) {
			g_object_unref ($5);
		}
		g_object_unref ($9);
	  }
	;

opt_statement_expression_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| statement_expression_list
	;

statement_expression_list
	: statement_expression
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| statement_expression_list COMMA statement_expression
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

foreach_statement
	: FOREACH OPEN_PARENS type IDENTIFIER IN expression CLOSE_PARENS embedded_statement
	  {
		ValaSourceReference *src = src(@3);
		$$ = VALA_STATEMENT (vala_foreach_statement_new ($3, $4, $6, $8, src));
		g_object_unref (src);
		g_object_unref ($3);
		g_object_unref ($6);
		g_object_unref ($8);
	  }
	;

jump_statement
	: break_statement
	| continue_statement
	| return_statement
	;

break_statement
	: BREAK SEMICOLON
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_STATEMENT (vala_break_statement_new (src));
		g_object_unref (src);
	  }
	;

continue_statement
	: CONTINUE SEMICOLON
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_STATEMENT (vala_continue_statement_new (src));
		g_object_unref (src);
	  }
	;

return_statement
	: RETURN opt_expression SEMICOLON
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_STATEMENT (vala_return_statement_new ($2, src));
		g_object_unref (src);
		if ($2 != NULL) {
			g_object_unref ($2);
		}
	  }
	;

namespace_declaration
	: comment opt_attributes NAMESPACE IDENTIFIER
	  {
		ValaSourceReference *src = src_com(@4, $1);
		current_namespace = vala_namespace_new ($4, src);
		g_object_unref (src);
		VALA_CODE_NODE(current_namespace)->attributes = $2;
		g_free ($4);
	  }
	  namespace_body
	  {
	  	$$ = current_namespace;
	  	current_namespace = vala_source_file_get_global_namespace (current_source_file);
	  }
	;

namespace_body
	: OPEN_BRACE opt_namespace_member_declarations CLOSE_BRACE
	| OPEN_BRACE error CLOSE_BRACE
	;

opt_name_specifier
	: /* empty */
	  {
		$$ = NULL;
	  }
	| name_specifier
	;

name_specifier
	: DOT IDENTIFIER
	  {
		$$ = $2;
	  }
	;

opt_using_directives
	: /* empty */
	| using_directives
	;

using_directives
	: using_directive
	| using_directives using_directive
	;

using_directive
	: USING IDENTIFIER SEMICOLON
	  {
		ValaSourceReference *src = src(@2);
	  	ValaNamespaceReference *ns_ref = vala_namespace_reference_new ($2, src);
		g_object_unref (src);
		g_free ($2);
		vala_source_file_add_using_directive (current_source_file, ns_ref);
		g_object_unref (ns_ref);
	  }
	;

opt_outer_declarations
	: /* empty */
	| outer_declarations
	;

outer_declarations
	: outer_declaration
	| outer_declarations outer_declaration
	;

outer_declaration
	: namespace_declaration
	  {
		vala_source_file_add_namespace (current_source_file, $1);
		g_object_unref ($1);
	  }
	| namespace_member_declaration
	;

opt_namespace_member_declarations
	: /* empty */
	| namespace_member_declarations
	;

namespace_member_declarations
	: namespace_member_declaration
	| namespace_member_declarations namespace_member_declaration
	;

namespace_member_declaration
	: class_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_namespace_add_class (current_namespace, $1);
			g_object_unref ($1);
		}

		if (current_namespace_implicit) {
			/* current namespace has been declared implicitly */
			current_namespace = vala_source_file_get_global_namespace (current_source_file);
			current_namespace_implicit = FALSE;
		}
	  }
	| struct_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_namespace_add_struct (current_namespace, $1);
			g_object_unref ($1);
		}

		if (current_namespace_implicit) {
			/* current namespace has been declared implicitly */
			current_namespace = vala_source_file_get_global_namespace (current_source_file);
			current_namespace_implicit = FALSE;
		}
	  }
	| interface_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_namespace_add_interface (current_namespace, $1);
			g_object_unref ($1);
		}

		if (current_namespace_implicit) {
			/* current namespace has been declared implicitly */
			current_namespace = vala_source_file_get_global_namespace (current_source_file);
			current_namespace_implicit = FALSE;
		}
	  }
	| enum_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_namespace_add_enum (current_namespace, $1);
			g_object_unref ($1);
		}

		if (current_namespace_implicit) {
			/* current namespace has been declared implicitly */
			current_namespace = vala_source_file_get_global_namespace (current_source_file);
			current_namespace_implicit = FALSE;
		}
	  }
	| flags_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_namespace_add_flags (current_namespace, $1);
			g_object_unref ($1);
		}

		if (current_namespace_implicit) {
			/* current namespace has been declared implicitly */
			current_namespace = vala_source_file_get_global_namespace (current_source_file);
			current_namespace_implicit = FALSE;
		}
	  }
	| callback_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_namespace_add_callback (current_namespace, $1);
			g_object_unref ($1);
		}
	  }
	| field_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_namespace_add_field (current_namespace, $1);
			g_object_unref ($1);
		}
	  }
	| method_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_namespace_add_method (current_namespace, $1);
			g_object_unref ($1);
		}
	  }
	;

class_declaration
	: comment opt_attributes opt_access_modifier opt_modifiers CLASS IDENTIFIER opt_name_specifier opt_type_parameter_list opt_class_base
	  {
	  	char *name = $6;
	  
		if ($7 != NULL) {
			ValaSourceReference *ns_src = src(@6);
			current_namespace = vala_namespace_new ($6, ns_src);
			g_free ($6);
			g_object_unref (ns_src);
			current_namespace_implicit = TRUE;

			vala_source_file_add_namespace (current_source_file, current_namespace);
			g_object_unref (current_namespace);
			
			name = $7;
		}
	  	
	  	GList *l;
		ValaSourceReference *src = src_com(@6, $1);
		current_class = vala_class_new (name, src);
		g_free (name);
		g_object_unref (src);
		
		VALA_CODE_NODE(current_class)->attributes = $2;
		if ($3 != 0) {
			VALA_DATA_TYPE(current_class)->access = $3;
		}
		for (l = $8; l != NULL; l = l->next) {
			vala_class_add_type_parameter (current_class, l->data);
			g_object_unref (l->data);
		}
		for (l = $9; l != NULL; l = l->next) {
			vala_class_add_base_type (current_class, l->data);
			g_object_unref (l->data);
		}
	  }
	  class_body
	  {
		$$ = current_class;
	  	current_class = NULL;
	  }
	;

opt_access_modifier
	: /* empty */
	  {
		$$ = 0;
	  }
	| access_modifier
	;

access_modifier
	: PUBLIC
	  {
		$$ = VALA_MEMBER_ACCESSIBILITY_PUBLIC;
	  }
	| PRIVATE
	  {
		$$ = VALA_MEMBER_ACCESSIBILITY_PRIVATE;
	  }
	;

opt_modifiers
	: /* empty */
	  {
		$$ = VALA_MODIFIER_NONE;
	  }
	| modifiers
	;

modifiers
	: modifier
	| modifiers modifier
	  {
		if (($1 & $2) == $2) {
			/* modifier specified twice, signal error */
		}
		$$ = $1 | $2;
	  }
	;

modifier
	: ABSTRACT
	  {
		$$ = VALA_MODIFIER_ABSTRACT;
	  }
	| OVERRIDE
	  {
		$$ = VALA_MODIFIER_OVERRIDE;
	  }
	| STATIC
	  {
		$$ = VALA_MODIFIER_STATIC;
	  }
	| VIRTUAL
	  {
		$$ = VALA_MODIFIER_VIRTUAL;
	  }
	;

opt_class_base
	: /* empty */
	  {
		$$ = NULL;
	  }
	| class_base
	;

class_base
	: COLON type_list
	  {
		$$ = $2;
	  }
	;

type_list
	: type_name
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| type_list COMMA type_name
	  {
		$$ = g_list_append ($1, $3);
	  }
	;
	
class_body
	: OPEN_BRACE opt_class_member_declarations CLOSE_BRACE
	;

opt_class_member_declarations
	: /* empty */
	| class_member_declarations
	;

class_member_declarations
	: class_member_declaration
	| class_member_declarations class_member_declaration
	;

class_member_declaration
	: constant_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_class_add_constant (current_class, $1);
			g_object_unref ($1);
		}
	  }
	| field_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_class_add_field (current_class, $1);
			g_object_unref ($1);
		}
	  }
	| method_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_class_add_method (current_class, $1);
			g_object_unref ($1);
		}
	  }
	| property_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_class_add_property (current_class, $1);
			g_object_unref ($1);
		}
	  }
	| signal_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_class_add_signal (current_class, $1);
			g_object_unref ($1);
		}
	  }
	| constructor_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_class_set_constructor (current_class, $1);
			g_object_unref ($1);
		}
	  }
	| destructor_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_class_set_destructor (current_class, $1);
			g_object_unref ($1);
		}
	  }
	;

constant_declaration
	: comment opt_attributes opt_access_modifier CONST type constant_declarator SEMICOLON
	  {
		ValaSourceReference *src = src_com(@5, $1);
		$$ = vala_constant_new (vala_variable_declarator_get_name ($6), $5, vala_variable_declarator_get_initializer ($6), src);
		g_object_unref (src);
		g_object_unref ($5);
		g_object_unref ($6);
	  }
	;

constant_declarator
	: IDENTIFIER ASSIGN initializer
	  {
		ValaSourceReference *src = src(@1);
		$$ = vala_variable_declarator_new ($1, $3, src);
		g_object_unref (src);
		g_free ($1);
		g_object_unref ($3);
	  }
	;

field_declaration
	: comment opt_attributes opt_access_modifier opt_modifiers type variable_declarator SEMICOLON
	  {
	  	if (!vala_type_reference_get_is_weak ($5)) {
	  		vala_type_reference_set_is_lvalue_ref ($5, TRUE);
	  	}
  		vala_type_reference_set_is_ref ($5, FALSE);
  		
  		GList *l;
  		for (l = vala_type_reference_get_type_arguments ($5); l != NULL; l = l->next) {
  			ValaTypeReference *type_arg = VALA_TYPE_REFERENCE (l->data);
		  	if (!vala_type_reference_get_is_weak (type_arg)) {
		  		vala_type_reference_set_is_ref (type_arg, TRUE);
		  	}
  		}
	  	
		ValaSourceReference *src = src_com(@5, $1);
		$$ = vala_field_new (vala_variable_declarator_get_name ($6), $5, vala_variable_declarator_get_initializer ($6), src);
		g_object_unref (src);
		if ($3 != 0) {
			$$->access = $3;
		}
		if (($4 & VALA_MODIFIER_STATIC) == VALA_MODIFIER_STATIC) {
			$$->instance = FALSE;
		}
		VALA_CODE_NODE($$)->attributes = $2;
		g_object_unref ($5);
		g_object_unref ($6);
	  }
	;

comment
	:
	  {
		$$ = vala_parser_pop_comment (parser);
	  }
	;

variable_declarators
	: variable_declarator
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| variable_declarators COMMA variable_declarator
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

variable_declarator
	: IDENTIFIER
	  {
		ValaSourceReference *src = src(@1);
		$$ = vala_variable_declarator_new ($1, NULL, src);
		g_object_unref (src);
		g_free ($1);
	  }
	| IDENTIFIER ASSIGN initializer
	  {
		ValaSourceReference *src = src(@1);
		$$ = vala_variable_declarator_new ($1, $3, src);
		g_object_unref (src);
		g_free ($1);
		g_object_unref ($3);
	  }
	;

initializer_list
	: initializer
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| initializer_list COMMA initializer
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

initializer
	: expression
	| OPEN_BRACE initializer_list CLOSE_BRACE
	  {
		ValaSourceReference *src = src(@1);
		$$ = VALA_EXPRESSION (vala_initializer_list_new ($2, src));
		g_object_unref (src);
	  }
	;

method_declaration
	: method_header method_body
	  {
	  	$$ = $1;
		vala_method_set_body ($$, $2);
		if ($2 != NULL) {
			g_object_unref ($2);
		}
	  }
	| error method_body
	  {
		$$ = NULL;
	  }
	;

method_header
	: comment opt_attributes opt_access_modifier opt_modifiers type identifier_or_new OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS
	  {
	  	GList *l;
	  	
		ValaSourceReference *src = src_com(@6, $1);
		$$ = vala_method_new ($6, $5, src);
		g_object_unref (src);
		if ($3 != 0) {
			$$->access = $3;
		}
		if (($4 & VALA_MODIFIER_STATIC) == VALA_MODIFIER_STATIC) {
			$$->instance = FALSE;
		}
		if (($4 & VALA_MODIFIER_ABSTRACT) == VALA_MODIFIER_ABSTRACT) {
			$$->is_abstract = TRUE;
		}
		if (($4 & VALA_MODIFIER_VIRTUAL) == VALA_MODIFIER_VIRTUAL) {
			$$->is_virtual = TRUE;
		}
		if (($4 & VALA_MODIFIER_OVERRIDE) == VALA_MODIFIER_OVERRIDE) {
			$$->is_override = TRUE;
		}
		VALA_CODE_NODE($$)->attributes = $2;
		
		for (l = $8; l != NULL; l = l->next) {
			vala_method_add_parameter ($$, l->data);
			g_object_unref (l->data);
		}
		if ($8 != NULL) {
			g_list_free ($8);
		}

		g_object_unref ($5);
		g_free ($6);
	  }
	;

method_body
	: block
	| SEMICOLON
	  {
		$$ = NULL;
	  }
	;

opt_formal_parameter_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| formal_parameter_list
	;

formal_parameter_list
	: fixed_parameters
	| fixed_parameters COMMA ELLIPSIS
	  {
		ValaSourceReference *src = src(@3);
		$$ = g_list_append ($1, vala_formal_parameter_new_ellipsis (src));
		g_object_unref (src);
	  }
	| ELLIPSIS
	  {
		ValaSourceReference *src = src(@1);
		$$ = g_list_append (NULL, vala_formal_parameter_new_ellipsis (src));
		g_object_unref (src);
	  }
	;

fixed_parameters
	: fixed_parameter
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| fixed_parameters COMMA fixed_parameter
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

fixed_parameter
	: opt_attributes type IDENTIFIER
	  {
		if (vala_type_reference_get_is_ref ($2) && vala_type_reference_get_is_out ($2)) {
			vala_type_reference_set_is_lvalue_ref ($2, TRUE);
			vala_type_reference_set_is_ref ($2, FALSE);
		}

		ValaSourceReference *src = src(@2);
		$$ = vala_formal_parameter_new ($3, $2, src);
		g_object_unref (src);
		g_object_unref ($2);
		g_free ($3);
	  }
	| opt_attributes type IDENTIFIER ASSIGN expression
	  {
		if (vala_type_reference_get_is_ref ($2) && vala_type_reference_get_is_out ($2)) {
			vala_type_reference_set_is_lvalue_ref ($2, TRUE);
			vala_type_reference_set_is_ref ($2, FALSE);
		}

		ValaSourceReference *src = src(@2);
		$$ = vala_formal_parameter_new ($3, $2, src);
		g_object_unref (src);
		vala_formal_parameter_set_default_expression ($$, $5);
		g_object_unref ($2);
		g_free ($3);
		g_object_unref ($5);
	  }
	;

property_declaration
	: comment opt_attributes opt_access_modifier opt_modifiers type IDENTIFIER OPEN_BRACE get_accessor_declaration opt_set_accessor_declaration CLOSE_BRACE
	  {
	  	if (!vala_type_reference_get_is_weak ($5)) {
	  		vala_type_reference_set_is_lvalue_ref ($5, TRUE);
	  	}
  		
  		GList *l;
  		for (l = vala_type_reference_get_type_arguments ($5); l != NULL; l = l->next) {
  			ValaTypeReference *type_arg = VALA_TYPE_REFERENCE (l->data);
		  	if (!vala_type_reference_get_is_weak (type_arg)) {
		  		vala_type_reference_set_is_ref (type_arg, TRUE);
		  	}
  		}
	  	
		ValaSourceReference *src = src_com(@5, $1);
		$$ = vala_property_new ($6, $5, $8, $9, src);
		g_object_unref (src);

		VALA_CODE_NODE($$)->attributes = $2;

		g_object_unref ($5);
		g_free ($6);
		g_object_unref ($8);
		if ($9 != NULL) {
			g_object_unref ($9);
		}
	  }
	| comment opt_attributes opt_access_modifier opt_modifiers type IDENTIFIER OPEN_BRACE set_accessor_declaration CLOSE_BRACE
	  {
	  	if (!vala_type_reference_get_is_weak ($5)) {
	  		vala_type_reference_set_is_lvalue_ref ($5, TRUE);
	  	}
	  	
		ValaSourceReference *src = src_com(@5, $1);
		$$ = vala_property_new ($6, $5, NULL, $8, src);
		g_object_unref (src);

		g_object_unref ($5);
		g_free ($6);
		g_object_unref ($8);
	  }
	;

get_accessor_declaration
	: opt_attributes GET method_body
	  {
		ValaSourceReference *src = src(@2);
		$$ = vala_property_accessor_new (TRUE, FALSE, FALSE, $3, src);
		g_object_unref (src);

		if ($3 != NULL) {
			g_object_unref ($3);
		}
	  }
	;

opt_set_accessor_declaration
	: /* empty */
	  {
		$$ = NULL;
	  }
	| set_accessor_declaration
	;

set_accessor_declaration
	: opt_attributes SET method_body
	  {
		ValaSourceReference *src = src(@2);
		$$ = vala_property_accessor_new (FALSE, TRUE, FALSE, $3, src);
		g_object_unref (src);
		if ($3 != NULL) {
			g_object_unref ($3);
		}
	  }
	| opt_attributes SET CONSTRUCT method_body
	  {
		ValaSourceReference *src = src(@2);
		$$ = vala_property_accessor_new (FALSE, TRUE, TRUE, $4, src);
		g_object_unref (src);
		if ($4 != NULL) {
			g_object_unref ($4);
		}
	  }
	| opt_attributes CONSTRUCT method_body
	  {
		ValaSourceReference *src = src(@2);
		$$ = vala_property_accessor_new (FALSE, FALSE, TRUE, $3, src);
		g_object_unref (src);
		if ($3 != NULL) {
			g_object_unref ($3);
		}
	  }
	;

signal_declaration
	: comment opt_attributes opt_access_modifier SIGNAL type identifier_or_new OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS SEMICOLON
	  {
	  	GList *l;
	  	
		ValaSourceReference *src = src_com(@6, $1);
		$$ = vala_signal_new ($6, $5, src);
		g_object_unref (src);
		if ($3 != 0) {
			$$->access = $3;
		}
		VALA_CODE_NODE($$)->attributes = $2;
		
		for (l = $8; l != NULL; l = l->next) {
			vala_signal_add_parameter ($$, l->data);
			g_object_unref (l->data);
		}
		if ($8 != NULL) {
			g_list_free ($8);
		}

		g_object_unref ($5);
		g_free ($6);
	  }
	;

constructor_declaration
	: comment opt_attributes opt_access_modifier opt_modifiers IDENTIFIER OPEN_PARENS CLOSE_PARENS block
	  {
		ValaSourceReference *src = src_com(@5, $1);
		$$ = vala_constructor_new (src);
		g_object_unref (src);
		vala_constructor_set_body ($$, $8);

		g_free ($5);
		g_object_unref ($8);
	  }
	;

destructor_declaration
	: comment opt_attributes opt_access_modifier opt_modifiers TILDE IDENTIFIER OPEN_PARENS CLOSE_PARENS block
	  {
		ValaSourceReference *src = src_com(@6, $1);
		$$ = vala_destructor_new (src);
		g_object_unref (src);
		vala_destructor_set_body ($$, $9);
		
		g_free ($6);
		g_object_unref ($9);
	  }
	;

struct_declaration
	: struct_header
	  {
		current_struct = $1;
	  }
	  struct_body
	  {
		$$ = current_struct;
	  	current_struct = NULL;
	  }
	;

struct_header
	: comment opt_attributes opt_access_modifier STRUCT IDENTIFIER opt_name_specifier opt_type_parameter_list
	  {
	  	char *name = $5;
	  
		if ($6 != NULL) {
			ValaSourceReference *ns_src = src(@5);
			current_namespace = vala_namespace_new ($5, ns_src);
			g_free ($5);
			g_object_unref (ns_src);
			current_namespace_implicit = TRUE;

			vala_source_file_add_namespace (current_source_file, current_namespace);
			g_object_unref (current_namespace);
			
			name = $6;
		}
	  	
	  	GList *l;
		ValaSourceReference *src = src_com(@5, $1);
		$$ = vala_struct_new (name, src);
		g_free (name);
		g_object_unref (src);
		for (l = $7; l != NULL; l = l->next) {
			vala_struct_add_type_parameter ($$, l->data);
		}
		VALA_CODE_NODE($$)->attributes = $2;
		if ($3 != 0) {
			VALA_DATA_TYPE($$)->access = $3;
		}
	  }
	;

struct_body
	: OPEN_BRACE opt_struct_member_declarations CLOSE_BRACE
	;

opt_struct_member_declarations
	: /* empty */
	| struct_member_declarations
	;

struct_member_declarations
	: struct_member_declaration
	| struct_member_declarations struct_member_declaration
	;

struct_member_declaration
	: field_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_struct_add_field (current_struct, $1);
			g_object_unref ($1);
		}
	  }
	| method_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_struct_add_method (current_struct, $1);
			g_object_unref ($1);
		}
	  }
	;

interface_declaration
	: comment opt_attributes opt_access_modifier INTERFACE IDENTIFIER opt_name_specifier
	  {
	  	char *name = $5;
	  
		if ($6 != NULL) {
			ValaSourceReference *ns_src = src(@5);
			current_namespace = vala_namespace_new ($5, ns_src);
			g_free ($5);
			g_object_unref (ns_src);
			current_namespace_implicit = TRUE;

			vala_source_file_add_namespace (current_source_file, current_namespace);
			g_object_unref (current_namespace);
			
			name = $6;
		}
	  	
		ValaSourceReference *src = src_com(@5, $1);
		current_interface = vala_interface_new (name, src);
		g_free (name);
		g_object_unref (src);
	  }
	  interface_body
	  {
		$$ = current_interface;
	  }
	;

interface_body
	: OPEN_BRACE opt_interface_member_declarations CLOSE_BRACE
	;

opt_interface_member_declarations
	: /* empty */
	| interface_member_declarations
	;

interface_member_declarations
	: interface_member_declaration
	| interface_member_declarations interface_member_declaration
	;

interface_member_declaration
	: method_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_interface_add_method (current_interface, $1);
			g_object_unref ($1);
		}
	  }
	| property_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_interface_add_property (current_interface, $1);
			g_object_unref ($1);
		}
	  }
	| signal_declaration
	  {
	  	/* skip declarations with errors */
	  	if ($1 != NULL) {
			vala_interface_add_signal (current_interface, $1);
			g_object_unref ($1);
		}
	  }
	;

enum_declaration
	: comment opt_attributes opt_access_modifier ENUM IDENTIFIER opt_name_specifier enum_body
	  {
	  	char *name = $5;
	  
		if ($6 != NULL) {
			ValaSourceReference *ns_src = src(@5);
			current_namespace = vala_namespace_new ($5, ns_src);
			g_free ($5);
			g_object_unref (ns_src);
			current_namespace_implicit = TRUE;

			vala_source_file_add_namespace (current_source_file, current_namespace);
			g_object_unref (current_namespace);
			
			name = $6;
		}
	  	
	  	GList *l;
		ValaSourceReference *src = src_com(@5, $1);
		$$ = vala_enum_new (name, src);
		g_free (name);
		g_object_unref (src);

		VALA_CODE_NODE($$)->attributes = $2;

		if ($3 != 0) {
			VALA_DATA_TYPE($$)->access = $3;
		}
		for (l = $7; l != NULL; l = l->next) {
			vala_enum_add_value ($$, l->data);
			g_object_unref (l->data);
		}
	  }
	;

enum_body
	: OPEN_BRACE opt_enum_member_declarations CLOSE_BRACE
	  {
		$$ = $2;
	  }
	;

opt_enum_member_declarations
	: /* empty */
	  {
		$$ = NULL;
	  }
	| enum_member_declarations opt_comma
	;

enum_member_declarations
	: enum_member_declaration
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| enum_member_declarations COMMA enum_member_declaration
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

enum_member_declaration
	: opt_attributes IDENTIFIER
	  {
		$$ = vala_enum_value_new ($2);
		g_free ($2);
	  }
	;

flags_declaration
	: comment opt_attributes opt_access_modifier FLAGS IDENTIFIER opt_name_specifier flags_body
	  {
	  	char *name = $5;
	  
		if ($6 != NULL) {
			ValaSourceReference *ns_src = src(@5);
			current_namespace = vala_namespace_new ($5, ns_src);
			g_free ($5);
			g_object_unref (ns_src);
			current_namespace_implicit = TRUE;

			vala_source_file_add_namespace (current_source_file, current_namespace);
			g_object_unref (current_namespace);
			
			name = $6;
		}
	  	
		ValaSourceReference *src = src_com(@5, $1);
		$$ = vala_flags_new (name, src);
		g_free (name);
		g_object_unref (src);
	  }
	;

flags_body
	: OPEN_BRACE opt_flags_member_declarations CLOSE_BRACE
	;

opt_flags_member_declarations
	: /* empty */
	| flags_member_declarations
	;

flags_member_declarations
	: flags_member_declaration
	| flags_member_declarations COMMA flags_member_declaration
	;

flags_member_declaration
	: opt_attributes IDENTIFIER
	;

callback_declaration
	: comment opt_attributes opt_access_modifier CALLBACK type identifier_or_new OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS SEMICOLON
	  {
	  	GList *l;
	  	
		ValaSourceReference *src = src_com(@6, $1);
		$$ = vala_callback_new ($6, $5, src);
		g_object_unref (src);
		if ($3 != 0) {
			VALA_DATA_TYPE($$)->access = $3;
		}
		VALA_CODE_NODE($$)->attributes = $2;
		
		for (l = $8; l != NULL; l = l->next) {
			vala_callback_add_parameter ($$, l->data);
			g_object_unref (l->data);
		}
		if ($8 != NULL) {
			g_list_free ($8);
		}

		g_object_unref ($5);
		g_free ($6);
	  }
	;

opt_attributes
	: /* empty */
	  {
		$$ = NULL;
	  }
	| attributes
	;

attributes
	: attribute_sections
	;

attribute_sections
	: attribute_section
	| attribute_sections attribute_section
	  {
		$$ = g_list_concat ($1, $2);
	  }
	;

attribute_section
	: OPEN_BRACKET attribute_list CLOSE_BRACKET
	  {
		$$ = $2;
	  }
	| OPEN_BRACKET error CLOSE_BRACKET
	  {
		$$ = NULL;
	  }
	;

attribute_list
	: attribute
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| attribute_list COMMA attribute
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

attribute
	: attribute_name OPEN_PARENS opt_named_argument_list CLOSE_PARENS
	  {
		GList *l;
		
		ValaSourceReference *src = src(@1);
		$$ = vala_attribute_new ($1, src);
		g_object_unref (src);
		
		for (l = $3; l != NULL; l = l->next) {
			vala_attribute_add_argument ($$, l->data);
			g_object_unref (l->data);
		}
		if ($3 != NULL) {
			g_list_free ($3);
		}
		
		g_free ($1);
	  }
	;

attribute_name
	: IDENTIFIER
	;

opt_named_argument_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| named_argument_list
	;

named_argument_list
	: named_argument
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| named_argument_list COMMA named_argument
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

named_argument
	: IDENTIFIER ASSIGN expression
	  {
		ValaSourceReference *src = src(@1);
		$$ = vala_named_argument_new ($1, $3, src);
		g_object_unref (src);
		
		g_free ($1);
		g_object_unref ($3);
	  }
	;

opt_type_parameter_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| type_parameter_list
	;

type_parameter_list
	: GENERIC_LT type_parameters OP_GT
	  {
		$$ = $2;
	  }
	;

type_parameters
	: type_parameter
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| type_parameters COMMA type_parameter
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

type_parameter
	: IDENTIFIER
	  {
		ValaSourceReference *src = src(@1);
		$$ = vala_type_parameter_new ($1, src);
		g_object_unref (src);
		g_free ($1);
	  }
	;

opt_type_argument_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| type_argument_list
	;

type_argument_list
	: GENERIC_LT type_arguments OP_GT
	  {
		$$ = $2;
	  }
	;

type_arguments
	: type_argument
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| type_arguments COMMA type_argument
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

type_argument
	: type
	;

%%

extern FILE *yyin;
extern int yylineno;

static void
yyerror (YYLTYPE *locp, ValaParser *parser, const char *msg)
{
	ValaSourceReference *source_reference = vala_source_reference_new (current_source_file, locp->first_line, locp->first_column, locp->last_line, locp->last_column);
	vala_report_error (source_reference, msg);
}

void
vala_parser_parse_file (ValaParser *parser, ValaSourceFile *source_file)
{
	current_source_file = source_file;
	current_namespace = vala_source_file_get_global_namespace (source_file);
	yyin = fopen (vala_source_file_get_filename (current_source_file), "r");
	if (yyin == NULL) {
		printf ("Couldn't open source file: %s.\n", vala_source_file_get_filename (current_source_file));
		return;
	}

	/* restart line counter on each file */
	yylineno = 1;
	
	yyparse (parser);
	fclose (yyin);
	yyin = NULL;
}
