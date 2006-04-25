/* parser.y
 *
 * Copyright (C) 2006  Jürg Billeter <j@bitron.ch>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <glib.h>

#include "context.h"

static char *
camel_case_to_lower_case (const char *camel_case)
{
	char *str = g_malloc0 (2 * strlen (camel_case));
	const char *i = camel_case;
	char *p = str;
	
	/*
	 * This function tries to find word boundaries in camel case with the
	 * following constraints
	 * - words always begin with an upper case character
	 * - the remaining characters are either all upper case or all lower case
	 * - words have at least two characters
	 */
	
	while (*i != '\0') {
		if (isupper (*i)) {
			/* current character is upper case */
			if (i != camel_case) {
				/* we're not at the beginning */
				const char *t = i - 1;				
				gboolean prev_upper = isupper (*t);
				t = i + 1;
				gboolean next_upper = isupper (*t);
				if (!prev_upper || (*t != '\0' && !next_upper)) {
					/* previous character wasn't upper case */
					t = p - 2;
					if (p - str != 1 && *t != '_') {
						/* we're not creating 1 character words */
						*p = '_';
						p++;
					}
				}
			}
		}
			
		*p = tolower (*i);
		i++;
		p++;
	}
	
	return str;
}

static char *
camel_case_to_upper_case (const char *camel_case)
{
	char *str = camel_case_to_lower_case (camel_case);
	
	char *p;
	
	for (p = str; *p != '\0'; p++) {
		*p = toupper (*p);
	}
	
	return str;
}

static ValaSourceFile *current_source_file;
static ValaNamespace *current_namespace;
static ValaClass *current_class;
static ValaMethod *current_method;

ValaLocation *get_location (int lineno, int colno)
{
	ValaLocation *loc = g_new0 (ValaLocation, 1);
	loc->source_file = current_source_file;
	loc->lineno = lineno;
	loc->colno = colno;
	return loc;
}

#define current_location(token) get_location (token.first_line, token.first_column)
%}

%defines
%locations
%error-verbose
%pure_parser
%glr-parser
%union {
	int num;
	char *str;
	GList *list;
	ValaTypeReference *type_reference;
	ValaFormalParameter *formal_parameter;
	ValaStatement *statement;
	ValaVariableDeclaration *variable_declaration;
	ValaVariableDeclarator *variable_declarator;
	ValaExpression *expression;
}

%token OPEN_BRACE "{"
%token CLOSE_BRACE "}"
%token OPEN_PARENS "("
%token CLOSE_PARENS ")"
%token DOT "."
%token COLON ":"
%token COMMA ","
%token SEMICOLON ";"
%token ASSIGN "="
%token PLUS "+"

%token CLASS "class"
%token NAMESPACE "namespace"
%token PUBLIC "public"
%token RETURN "return"
%token STATIC "static"

%token <str> IDENTIFIER "identifier"
%token <str> LITERAL_INTEGER "integer"
%token <str> LITERAL_STRING "string"

%type <list> opt_class_base
%type <list> class_base
%type <list> type_list
%type <list> opt_formal_parameter_list
%type <list> formal_parameter_list
%type <list> fixed_parameters
%type <list> opt_statement_list
%type <list> statement_list
%type <list> opt_argument_list
%type <list> argument_list
%type <num> opt_method_modifiers
%type <num> method_modifiers
%type <num> method_modifier
%type <type_reference> type_name
%type <expression> variable_initializer
%type <expression> opt_expression
%type <expression> expression
%type <expression> additive_expression
%type <expression> assignment
%type <expression> primary_expression
%type <expression> literal
%type <expression> simple_name
%type <expression> parenthesized_expression
%type <expression> member_access
%type <expression> invocation_expression
%type <expression> statement_expression
%type <expression> argument
%type <statement> block
%type <statement> statement
%type <statement> declaration_statement
%type <statement> embedded_statement
%type <statement> expression_statement
%type <statement> jump_statement
%type <statement> return_statement
%type <formal_parameter> fixed_parameter
%type <variable_declaration> variable_declaration
%type <variable_declarator> variable_declarator

%%

compilation_unit
	: /* empty */
	| outer_declarations
	;

outer_declarations
	: outer_declaration
	| outer_declarations outer_declaration
	;

outer_declaration
	: namespace_declaration
	| type_declaration
	;

namespace_declaration
	: NAMESPACE IDENTIFIER
	  {
	  	current_namespace = g_new0 (ValaNamespace, 1);
	  	current_namespace->name = $2;
	  	current_namespace->lower_case_cname = camel_case_to_lower_case (current_namespace->name);
		/* we know that this is safe */
		current_namespace->lower_case_cname[strlen (current_namespace->lower_case_cname)] = '_';

	  	current_namespace->upper_case_cname = camel_case_to_upper_case (current_namespace->name);
		/* we know that this is safe */
		current_namespace->upper_case_cname[strlen (current_namespace->upper_case_cname)] = '_';

		current_source_file->namespaces = g_list_append (current_source_file->namespaces, current_namespace);
	  }
	  namespace_body
	  {
		current_namespace = current_source_file->root_namespace;
	  }
	;

namespace_body
	: OPEN_BRACE opt_namespace_member_declarations CLOSE_BRACE
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
	: type_declaration
	;

type_declaration
	: class_declaration
	;

class_declaration
	: CLASS IDENTIFIER opt_class_base
	  {
		current_class = g_new0 (ValaClass, 1);
		current_class->name = g_strdup ($2);
		current_class->base_types = $3;
		current_class->location = current_location (@2);
		current_class->namespace = current_namespace;
		current_class->cname = g_strdup_printf ("%s%s", current_namespace->name, current_class->name);
	  	current_class->lower_case_cname = camel_case_to_lower_case (current_class->name);
	  	current_class->upper_case_cname = camel_case_to_upper_case (current_class->name);
		current_namespace->classes = g_list_append (current_namespace->classes, current_class);
	  }
	  class_body
	;

opt_class_base
	: /* empty */
	  {
	  	$$ = NULL;
	  }
	| class_base
	  {
	  	$$ = $1;
	  }
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

type_name
	: IDENTIFIER
	  {
		ValaTypeReference *type_reference = g_new0 (ValaTypeReference, 1);
		type_reference->type_name = g_strdup ($1);
		type_reference->location = current_location (@1);
		$$ = type_reference;
	  }
	| IDENTIFIER DOT IDENTIFIER
	  {
		ValaTypeReference *type_reference = g_new0 (ValaTypeReference, 1);
		type_reference->namespace_name = g_strdup ($1);
		type_reference->type_name = g_strdup ($3);
		type_reference->location = current_location (@1);
		$$ = type_reference;
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
	: method_declaration
	;

method_declaration
	: method_header method_body
	;

method_header
	: opt_method_modifiers type_name IDENTIFIER OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS
	  {
	  	current_method = g_new0 (ValaMethod, 1);
	  	current_method->name = g_strdup ($3);
	  	current_method->class = current_class;
	  	current_method->return_type = $2;
	  	current_method->formal_parameters = $5;
	  	current_method->modifiers = $1;
		current_method->location = current_location (@3);
		
		current_class->methods = g_list_append (current_class->methods, current_method);
	  }
	;

opt_method_modifiers
	: /* empty */
	  {
		$$ = 0;
	  }
	| method_modifiers
	  {
		$$ = $1;
	  }
	;

method_modifiers
	: method_modifier
	  {
		$$ = $1;
	  }
	| method_modifiers method_modifier
	  {
		$$ = $1 | $2;
	  }
	;

method_modifier
	: PUBLIC
	  {
		$$ = VALA_METHOD_PUBLIC;
	  }
	| STATIC
	  {
		$$ = VALA_METHOD_STATIC;
	  }
	;

opt_formal_parameter_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| formal_parameter_list
	  {
		$$ = $1;
	  }
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
	: type_name IDENTIFIER
	  {
		$$ = g_new0 (ValaFormalParameter, 1);
		$$->type = $1;
		$$->name = $2;
		$$->location = current_location (@2);
	  }
	;

method_body
	: block
	  {
		current_method->body = $1;
	  }
	| SEMICOLON
	;

block
	: OPEN_BRACE opt_statement_list CLOSE_BRACE
	  {
		$$ = g_new0 (ValaStatement, 1);
		$$->type = VALA_STATEMENT_TYPE_BLOCK;
		$$->location = current_location (@1);
		$$->block.statements = $2;
	  }
	;

opt_statement_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| statement_list
	  {
		$$ = $1;
	  }
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

statement
	: declaration_statement
	  {
		$$ = $1;
	  }
	| embedded_statement
	  {
		$$ = $1;
	  }
	;

declaration_statement
	: variable_declaration SEMICOLON
	  {
	  	$$ = g_new0 (ValaStatement, 1);
	  	$$->type = VALA_STATEMENT_TYPE_VARIABLE_DECLARATION;
		$$->location = current_location (@1);
		$$->variable_declaration = $1;;
	  }
	;

variable_declaration
	: type_name variable_declarator
	  {
		$$ = g_new0 (ValaVariableDeclaration, 1);
		$$->type = $1;
		$$->declarator = $2;
	  }
	;

variable_declarator
	: IDENTIFIER
	  {
		$$ = g_new0 (ValaVariableDeclarator, 1);
		$$->name = $1;
	  }
	| IDENTIFIER ASSIGN variable_initializer
	  {
		$$ = g_new0 (ValaVariableDeclarator, 1);
		$$->name = $1;
		$$->initializer = $3;
	  }
	;

variable_initializer
	: expression
	  {
		$$ = $1;
	  }
	;

opt_expression
	: /* empty */
	  {
		$$ = NULL;
	  }
	| expression
	  {
		$$ = $1;
	  }
	;

expression
	: additive_expression
	  {
		$$ = $1;
	  }
	| assignment
	  {
		$$ = $1;
	  }
	;

additive_expression
	: primary_expression
	  {
		$$ = $1;
	  }
	| additive_expression PLUS primary_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_ADDITIVE;
		$$->location = current_location (@1);
		$$->additive.left = $1;
		$$->additive.op = VALA_OP_TYPE_PLUS;
		$$->additive.right = $3;
	  }
	;

primary_expression
	: literal
	  {
	  	$$ = $1;
	  }
	| simple_name
	  {
	  	$$ = $1;
	  }
	| parenthesized_expression
	  {
	  	$$ = $1;
	  }
	| member_access
	  {
		$$ = $1;
	  }
	| invocation_expression
	  {
		$$ = $1;
	  }
	;

literal
	: LITERAL_INTEGER
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_LITERAL_INTEGER;
		$$->location = current_location (@1);
		$$->str = $1;
	  }
	| LITERAL_STRING
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_LITERAL_STRING;
		$$->location = current_location (@1);
		$$->str = $1;
	  }
	;

simple_name
	: IDENTIFIER
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_SIMPLE_NAME;
		$$->location = current_location (@1);
		$$->str = $1;
	  }
	;

parenthesized_expression
	: OPEN_PARENS expression CLOSE_PARENS
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_PARENTHESIZED;
		$$->location = current_location (@1);
		$$->inner = $2;
	  }
	;
	
member_access
	: primary_expression DOT IDENTIFIER
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_MEMBER_ACCESS;
		$$->location = current_location (@1);
		$$->member_access.left = $1;
		$$->member_access.right = $3;
	  }
	;

invocation_expression
	: primary_expression OPEN_PARENS opt_argument_list CLOSE_PARENS
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_INVOCATION;
		$$->location = current_location (@1);
		$$->invocation.call = $1;
		$$->invocation.argument_list = $3;
	  }
	;

opt_argument_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| argument_list
	  {
		$$ = $1;
	  }
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
	  {
		$$ = $1;
	  }
	;

embedded_statement
	: block
	  {
		$$ = $1;
	  }
	| empty_statement
	  {
		$$ = NULL;
	  }
	| expression_statement
	  {
		$$ = $1;
	  }
	| jump_statement
	  {
		$$ = $1;
	  }
	;

empty_statement
	: SEMICOLON
	;

expression_statement
	: statement_expression SEMICOLON
	  {
		$$ = g_new0 (ValaStatement, 1);
		$$->type = VALA_STATEMENT_TYPE_EXPRESSION;
		$$->location = current_location (@1);
		$$->expr = $1;
	  }
	;

statement_expression
	: invocation_expression
	  {
		$$ = $1;
	  }
	| assignment
	  {
		$$ = $1;
	  }
	;

assignment
	: primary_expression ASSIGN expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_ASSIGNMENT;
		$$->location = current_location (@1);
		$$->assignment.left = $1;
		$$->assignment.right = $3;
	  }
	;

jump_statement
	: return_statement
	  {
		$$ = $1;
	  }
	;

return_statement
	: RETURN opt_expression SEMICOLON
	  {
		$$ = g_new0 (ValaStatement, 1);
		$$->type = VALA_STATEMENT_TYPE_RETURN;
		$$->location = current_location (@1);
		$$->expr = $2;
	  }
	;

%%

extern FILE *yyin;
extern int yylineno;

void yyerror (YYLTYPE *locp, const char *s)
{
	printf ("%s:%d:%d-%d: %s\n", current_source_file->filename, locp->first_line, locp->first_column, locp->last_column, s);
}

void vala_parser_parse (ValaSourceFile *source_file)
{
	current_source_file = source_file;
	current_namespace = source_file->root_namespace;
	yyin = fopen (source_file->filename, "r");
	if (yyin == NULL) {
		printf ("Couldn't open source file: %s.\n", source_file->filename);
		return;
	}

	/* restart line counter on each file */
	yylineno = 1;
	
	yyparse ();
	fclose (yyin);
	yyin = NULL;
}
