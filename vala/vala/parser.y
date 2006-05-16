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

/* necessary for bootstrapping with vala compiler without memory management */
#define g_object_unref(obj) (obj)

#define src(l) (vala_source_reference_new (current_source_file, l.first_line, l.first_column, l.last_line, l.last_column))

#define src_com(l,c) (vala_source_reference_new_with_comment (current_source_file, l.first_line, l.first_column, l.last_line, l.last_column, c))

static ValaSourceFile *current_source_file;
static ValaNamespace *current_namespace;
static ValaStruct *current_struct;

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
	ValaEnum *enum_;
	ValaConstant *constant;
	ValaField *field;
	ValaMethod *method;
	ValaFormalParameter *formal_parameter;
	ValaProperty *property;
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
%token GENERIC_LT "generic <"
%token OP_LT "<"
%token OP_GT ">"
%token OP_NEG "!"
%token CARRET "^"
%token BITWISE_OR "|"
%token BITWISE_AND "&"
%token OP_OR "||"
%token OP_AND "&&"

%token ASSIGN "="
%token PLUS "+"
%token MINUS "-"
%token STAR "*"
%token DIV "/"
%token PERCENT "%"

%token ABSTRACT "abstract"
%token CLASS "class"
%token CONST "const"
%token CONSTRUCT "construct"
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
%token READONLY "readonly"
%token REF "ref"
%token SET "set"
%token STATIC "static"
%token STRUCT "struct"
%token RETURN "return"
%token VALA_TRUE "true"
%token USING "using"
%token VAR "var"
%token VIRTUAL "virtual"
%token WHILE "while"

%token <str> IDENTIFIER "identifier"
%token <str> INTEGER_LITERAL "integer"
%token <str> CHARACTER_LITERAL "character"
%token <str> STRING_LITERAL "string"

%type <str> comment
%type <literal> literal
%type <literal> boolean_literal
%type <type_reference> type_name
%type <type_reference> type
%type <num> opt_ref
%type <num> opt_own_qualifier
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
%type <expression> assignment
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
%type <statement> return_statement
%type <namespace> namespace_declaration
%type <class> class_declaration
%type <property> property_declaration
%type <struct_> struct_declaration
%type <struct_> struct_header
%type <enum_> enum_declaration
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

literal
	: boolean_literal
	| INTEGER_LITERAL
	  {
		$$ = VALA_LITERAL (vala_integer_literal_new ($1, src(@1)));
	  }
	| CHARACTER_LITERAL
	  {
		$$ = VALA_LITERAL (vala_character_literal_new ($1, src(@1)));
	  }
	| STRING_LITERAL
	  {
		$$ = VALA_LITERAL (vala_string_literal_new ($1, src(@1)));
	  }
	| VALA_NULL
	  {
		$$ = VALA_LITERAL (vala_null_literal_new (src(@1)));
	  }
	;

boolean_literal
	: VALA_TRUE
	  {
		$$ = VALA_LITERAL (vala_boolean_literal_new (TRUE, src(@1)));
	  }
	| VALA_FALSE
	  {
		$$ = VALA_LITERAL (vala_boolean_literal_new (FALSE, src(@1)));
	  }
	;

compilation_unit
	: comment opt_using_directives opt_outer_declarations
	  {
		current_source_file->comment = $1;
	  }
	;

type_name
	: IDENTIFIER opt_type_argument_list
	  {
	  	GList *l;
		$$ = vala_type_reference_new (NULL, $1, src(@1));
		for (l = $2; l != NULL; l = l->next) {
			vala_type_reference_add_type_argument ($$, l->data);
		}
	  }
	| IDENTIFIER DOT IDENTIFIER opt_type_argument_list
	  {
	  	GList *l;
		$$ = vala_type_reference_new ($1, $3, src(@1));
		for (l = $4; l != NULL; l = l->next) {
			vala_type_reference_add_type_argument ($$, l->data);
		}
	  }
	;

type
	: type_name opt_own_qualifier
	  {
		$$ = $1;
		vala_type_reference_set_own ($$, $2);
	  }
	| type array_qualifier opt_own_qualifier
	  {
		$$ = $1;
		vala_type_reference_set_array ($$, TRUE);
		vala_type_reference_set_array_own ($$, $3);
	  }
	;

opt_ref
	: /* empty */
	  {
		$$ = FALSE;
	  }
	| REF
	  {
		$$ = TRUE;
	  }
	;

opt_own_qualifier
	: /* empty */
	  {
		$$ = FALSE;
	  }
	| HASH
	  {
		$$ = TRUE;
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
		$$ = VALA_EXPRESSION (vala_literal_expression_new ($1, src(@1)));
	  }
	| simple_name
	| parenthesized_expression
	| member_access
	| invocation_expression
	| post_increment_expression
	| post_decrement_expression
	| object_creation_expression
	;

simple_name
	: IDENTIFIER opt_type_argument_list
	  {
		$$ = VALA_EXPRESSION (vala_simple_name_new ($1, $2, src(@1)));
	  }
	;

parenthesized_expression
	: OPEN_PARENS expression CLOSE_PARENS
	  {
		$$ = VALA_EXPRESSION (vala_parenthesized_expression_new ($2, src(@2)));
	  }
	;

member_access
	: primary_expression DOT identifier_or_new opt_type_argument_list
	  {
		$$ = VALA_EXPRESSION (vala_member_access_new ($1, $3, src (@3)));
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
		$$ = VALA_EXPRESSION (vala_invocation_expression_new ($1, $3, src(@1)));
	  }
	;

post_increment_expression
	: primary_expression OP_INC
	  {
		$$ = VALA_EXPRESSION (vala_postfix_expression_new ($1, TRUE, src(@1)));
	  }
	;

post_decrement_expression
	: primary_expression OP_DEC
	  {
		$$ = VALA_EXPRESSION (vala_postfix_expression_new ($1, FALSE, src(@1)));
	  }
	;

object_creation_expression
	: NEW type OPEN_PARENS opt_named_argument_list CLOSE_PARENS
	  {
		$$ = VALA_EXPRESSION (vala_object_creation_expression_new ($2, $4, src(@2)));
	  }
	;

unary_expression
	: primary_expression
	| PLUS unary_expression
	  {
		$$ = VALA_EXPRESSION (vala_unary_expression_new (VALA_UNARY_OPERATOR_PLUS, src(@1)));
	  }
	| MINUS unary_expression
	  {
		$$ = VALA_EXPRESSION (vala_unary_expression_new (VALA_UNARY_OPERATOR_MINUS, src(@1)));
	  }
	| OP_NEG unary_expression
	  {
		$$ = VALA_EXPRESSION (vala_unary_expression_new (VALA_UNARY_OPERATOR_LOGICAL_NEGATION, src(@1)));
	  }
	| REF unary_expression
	  {
		$$ = VALA_EXPRESSION (vala_unary_expression_new (VALA_UNARY_OPERATOR_REF, src(@1)));
	  }
	| OUT unary_expression
	  {
		$$ = VALA_EXPRESSION (vala_unary_expression_new (VALA_UNARY_OPERATOR_OUT, src(@1)));
	  }
	| cast_expression
	;

cast_expression
	: OPEN_CAST_PARENS type CLOSE_PARENS unary_expression
	  {
		$$ = VALA_EXPRESSION (vala_cast_expression_new ($4, $2, src (@1)));
	  }
	;

multiplicative_expression
	: unary_expression
	| multiplicative_expression STAR unary_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_MUL, $1, $3, src (@2)));
	  }
	| multiplicative_expression DIV unary_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_DIV, $1, $3, src (@2)));
	  }
	| multiplicative_expression PERCENT unary_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_MOD, $1, $3, src (@2)));
	  }
	;

additive_expression
	: multiplicative_expression
	| additive_expression PLUS multiplicative_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_PLUS, $1, $3, src (@2)));
	  }
	| additive_expression MINUS multiplicative_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_MINUS, $1, $3, src (@2)));
	  }
	;

shift_expression
	: additive_expression
	| shift_expression OP_SHIFT_LEFT additive_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_SHIFT_LEFT, $1, $3, src (@2)));
	  }
	/* don't use two OP_GT due to resolve parse conflicts
	 * stacked generics won't be that common in vala */
	| shift_expression OP_SHIFT_RIGHT additive_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_SHIFT_RIGHT, $1, $3, src (@2)));
	  }
	;

relational_expression
	: shift_expression
	| relational_expression OP_LT shift_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_LESS_THAN, $1, $3, src (@2)));
	  }
	| relational_expression OP_GT shift_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_GREATER_THAN, $1, $3, src (@2)));
	  }
	| relational_expression OP_LE shift_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_LESS, $1, $3, src (@2)));
	  }
	| relational_expression OP_GE shift_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_GREATER, $1, $3, src (@2)));
	  }
	| relational_expression IS type
	;

equality_expression
	: relational_expression
	| equality_expression OP_EQ relational_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_EQUALITY, $1, $3, src (@2)));
	  }
	| equality_expression OP_NE relational_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_INEQUALITY, $1, $3, src (@2)));
	  }
	;

and_expression
	: equality_expression
	| and_expression BITWISE_AND equality_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_BITWISE_AND, $1, $3, src (@2)));
	  }
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression CARRET and_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_BITWISE_XOR, $1, $3, src (@2)));
	  }
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression BITWISE_OR exclusive_or_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_BITWISE_OR, $1, $3, src (@2)));
	  }
	;

conditional_and_expression
	: inclusive_or_expression
	| conditional_and_expression OP_AND inclusive_or_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_AND, $1, $3, src (@2)));
	  }
	;

conditional_or_expression
	: conditional_and_expression
	| conditional_or_expression OP_OR conditional_and_expression
	  {
		$$ = VALA_EXPRESSION (vala_binary_expression_new (VALA_BINARY_OPERATOR_OR, $1, $3, src (@2)));
	  }
	;

conditional_expression
	: conditional_or_expression
	| conditional_or_expression INTERR expression COLON expression
	  {
		$$ = VALA_EXPRESSION (vala_conditional_expression_new ($1, $3, $5, src (@2)));
	  }
	;

assignment
	: unary_expression assignment_operator expression
	  {
		$$ = VALA_EXPRESSION (vala_assignment_new ($1, $3, src (@2)));
	  }
	;

assignment_operator
	: ASSIGN
	| ASSIGN_BITWISE_OR
	| ASSIGN_BITWISE_AND
	| ASSIGN_BITWISE_XOR
	| ASSIGN_ADD
	| ASSIGN_SUB
	| ASSIGN_MUL
	| ASSIGN_DIV
	| ASSIGN_PERCENT
	| ASSIGN_SHIFT_LEFT
	| ASSIGN_SHIFT_RIGHT
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
		$$ = VALA_STATEMENT (vala_block_new ($2, src(@1)));
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
		$$ = VALA_STATEMENT (vala_empty_statement_new (src(@1)));
	  }
	;

declaration_statement
	: local_variable_declaration
	  {
		$$ = VALA_STATEMENT (vala_declaration_statement_new ($1, src(@1)));
	  }
	;

local_variable_declaration
	: local_variable_type variable_declarators SEMICOLON
	  {
		$$ = vala_local_variable_declaration_new ($1, $2, src(@2));
	  }
	| VAR variable_declarators SEMICOLON
	  {
		$$ = vala_local_variable_declaration_new_var ($2, src(@2));
	  }
	;

/* don't use type to prevent reduce/reduce conflict */
local_variable_type
	: primary_expression opt_own_qualifier
	  {
		$$ = vala_type_reference_new_from_expression ($1, src(@1));
		vala_type_reference_set_own ($$, $2);
	  }
	| local_variable_type array_qualifier opt_own_qualifier
	  {
		$$ = $1;
		vala_type_reference_set_array ($$, TRUE);
		vala_type_reference_set_array_own ($$, $3);
	  }
	;

expression_statement
	: statement_expression SEMICOLON
	  {
		$$ = VALA_STATEMENT (vala_expression_statement_new ($1, src(@1)));
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
	: IF OPEN_PARENS expression CLOSE_PARENS embedded_statement
	  {
		$$ = VALA_STATEMENT (vala_if_statement_new ($3, $5, NULL, src(@3)));
	  }
	| IF OPEN_PARENS expression CLOSE_PARENS embedded_statement ELSE embedded_statement
	  {
		$$ = VALA_STATEMENT (vala_if_statement_new ($3, $5, $7, src(@3)));
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
		$$ = VALA_STATEMENT (vala_while_statement_new ($3, $5, src (@1)));
	  }
	;

for_statement
	: FOR OPEN_PARENS opt_statement_expression_list SEMICOLON opt_expression SEMICOLON opt_statement_expression_list CLOSE_PARENS embedded_statement
	  {
		$$ = VALA_STATEMENT (vala_for_statement_new ($3, $5, $7, $9, src(@1)));
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
		$$ = VALA_STATEMENT (vala_foreach_statement_new ($3, $4, $6, $8, src(@3)));
	  }
	;

jump_statement
	: return_statement
	;

return_statement
	: RETURN opt_expression SEMICOLON
	  {
		$$ = VALA_STATEMENT (vala_return_statement_new ($2, src(@1)));
	  }
	;

namespace_declaration
	: comment opt_attributes NAMESPACE IDENTIFIER
	  {
		current_namespace = vala_namespace_new ($4, src_com (@4, $1));
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
		vala_source_file_add_using_directive (current_source_file, vala_namespace_reference_new ($2, src (@2)));
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
		vala_namespace_add_class (current_namespace, $1);
	  }
	| struct_declaration
	  {
		vala_namespace_add_struct (current_namespace, $1);
	  }
	| interface_declaration
	| enum_declaration
	  {
		vala_namespace_add_enum (current_namespace, $1);
	  }
	| flags_declaration
	| field_declaration
	  {
		vala_namespace_add_field (current_namespace, $1);
	  }
	| method_declaration
	;

class_declaration
	: comment opt_attributes opt_access_modifier opt_modifiers CLASS IDENTIFIER opt_type_parameter_list opt_class_base
	  {
	  	GList *l;
		current_struct = VALA_STRUCT (vala_class_new ($6, src_com (@6, $1)));
		for (l = $7; l != NULL; l = l->next) {
			vala_struct_add_type_parameter (current_struct, l->data);
		}
	  }
	  class_body
	  {
		$$ = current_struct;
	  	current_struct = NULL;
	  }
	;

opt_access_modifier
	: /* empty */
	| access_modifier
	;

access_modifier
	: PUBLIC
	| PRIVATE
	;

opt_modifiers
	: /* empty */
	| modifiers
	;

modifiers
	: modifier
	| modifiers modifier
	;

modifier
	: ABSTRACT
	| OVERRIDE
	| READONLY
	| STATIC
	| VIRTUAL
	;

opt_class_base
	: /* empty */
	| class_base
	;

class_base
	: COLON type_list
	;

type_list
	: type_name
	| type_list COMMA type_name
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
	| field_declaration
	  {
		vala_struct_add_field (current_struct, $1);
	  }
	| method_declaration
	  {
		vala_struct_add_method (current_struct, $1);
	  }
	| property_declaration
	;

constant_declaration
	: comment opt_attributes opt_access_modifier CONST type constant_declarator SEMICOLON
	  {
		$$ = vala_constant_new (vala_variable_declarator_get_name ($6), $5, vala_variable_declarator_get_initializer ($6), src_com (@5, $1));
	  }
	;

constant_declarator
	: IDENTIFIER ASSIGN initializer
	  {
		$$ = vala_variable_declarator_new ($1, $3, src(@1));
	  }
	;

field_declaration
	: comment opt_attributes opt_access_modifier opt_modifiers opt_ref type variable_declarator SEMICOLON
	  {
		$$ = vala_field_new (vala_variable_declarator_get_name ($7), $6, vala_variable_declarator_get_initializer ($7), src_com (@6, $1));
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
		$$ = vala_variable_declarator_new ($1, NULL, src(@1));
	  }
	| IDENTIFIER ASSIGN initializer
	  {
		$$ = vala_variable_declarator_new ($1, $3, src(@1));
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
		$$ = VALA_EXPRESSION (vala_initializer_list_new ($2, src (@1)));
	  }
	;

method_declaration
	: method_header method_body
	  {
	  	$$ = $1;
		vala_method_set_body ($$, $2);
	  }
	| error method_body
	  {
		$$ = NULL;
	  }
	;

method_header
	: comment opt_attributes opt_access_modifier opt_modifiers opt_ref type identifier_or_new OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS
	  {
	  	GList *l;
	  	
		$$ = vala_method_new ($7, src_com (@7, $1));
		VALA_CODE_NODE($$)->attributes = $2;
		
		for (l = $9; l != NULL; l = l->next) {
			vala_method_add_parameter ($$, l->data);
		}	
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
	: opt_attributes opt_parameter_modifier type IDENTIFIER
	  {
		$$ = vala_formal_parameter_new ($4, $3, src (@3));
	  }
	;

opt_parameter_modifier
	: /* empty */
	| parameter_modifier
	;

parameter_modifier
	: REF
	| OUT
	;

property_declaration
	: comment opt_attributes opt_access_modifier opt_modifiers opt_ref type IDENTIFIER OPEN_BRACE accessor_declarations CLOSE_BRACE
	  {
		$$ = vala_property_new ($7, $6, src_com (@6, $1));
	  }
	;

accessor_declarations
	: get_accessor_declaration opt_set_accessor_declaration
	| set_accessor_declaration opt_get_accessor_declaration
	;

opt_get_accessor_declaration
	: /* empty */
	| get_accessor_declaration
	;

get_accessor_declaration
	: opt_attributes GET method_body
	;

opt_set_accessor_declaration
	: /* empty */
	| set_accessor_declaration
	;

set_accessor_declaration
	: opt_attributes SET method_body
	| opt_attributes CONSTRUCT method_body
	| opt_attributes CONSTRUCT SET method_body
	| opt_attributes SET CONSTRUCT method_body
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
	: comment opt_attributes opt_access_modifier STRUCT IDENTIFIER opt_type_parameter_list
	  {
	  	GList *l;
		$$ = vala_struct_new ($5, src_com (@5, $1));
		for (l = $6; l != NULL; l = l->next) {
			vala_struct_add_type_parameter ($$, l->data);
		}
		VALA_CODE_NODE($$)->attributes = $2;
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
		vala_struct_add_field (current_struct, $1);
	  }
	| method_declaration
	  {
		vala_struct_add_method (current_struct, $1);
	  }
	;

interface_declaration
	: comment opt_attributes opt_access_modifier INTERFACE IDENTIFIER interface_body
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
	;

enum_declaration
	: comment opt_attributes opt_access_modifier ENUM IDENTIFIER enum_body
	  {
		$$ = vala_enum_new ($5, src_com (@5, $1));
	  }
	;

enum_body
	: OPEN_BRACE opt_enum_member_declarations CLOSE_BRACE
	;

opt_enum_member_declarations
	: /* empty */
	| enum_member_declarations
	;

enum_member_declarations
	: enum_member_declaration
	| enum_member_declarations COMMA enum_member_declaration
	;

enum_member_declaration
	: opt_attributes IDENTIFIER
	;

flags_declaration
	: comment opt_attributes opt_access_modifier FLAGS IDENTIFIER flags_body
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
		
		$$ = vala_attribute_new ($1, src (@1));
		
		for (l = $3; l != NULL; l = l->next) {
			vala_attribute_add_argument ($$, l->data);
		}
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
		$$ = vala_named_argument_new ($1, $3, src(@1));
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
		$$ = vala_type_parameter_new ($1, src (@1));
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
	: opt_ref type
	  {
		$$ = $2;
	  }
	;

%%

extern FILE *yyin;
extern int yylineno;

static void
yyerror (YYLTYPE *locp, ValaParser *parser, const char *msg)
{
	printf ("%s:%d.%d-%d.%d: %s\n", vala_source_file_get_filename (current_source_file), locp->first_line, locp->first_column, locp->last_line, locp->last_column, msg);
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
