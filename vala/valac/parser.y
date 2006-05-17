/* parser.y
 *
 * Copyright (C) 2006  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
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

static char *
eval_string (const char *cstring)
{
	char *ret = g_strdup (cstring + 1);
	ret[strlen (ret) - 1] = '\0';
	return ret;
}

static ValaSourceFile *current_source_file;
static ValaNamespace *current_namespace;
static ValaClass *current_class;
static ValaStruct *current_struct;
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
	gboolean bool;
	GList *list;
	ValaTypeReference *type_reference;
	ValaFormalParameter *formal_parameter;
	ValaMethod *method;
	ValaStruct *struct_;
	ValaEnum *enum_;
	ValaFlags *flags;
	ValaStatement *statement;
	ValaVariableDeclaration *variable_declaration;
	ValaVariableDeclarator *variable_declarator;
	ValaExpression *expression;
	ValaField *field;
	ValaConstant *constant;
	ValaProperty *property;
	ValaNamedArgument *named_argument;
	ValaEnumValue *enum_value;
	ValaFlagsValue *flags_value;
	ValaAnnotation *annotation;
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

%token OP_INC "++"
%token OP_DEC "--"
%token OP_EQ "=="
%token OP_NE "!="
%token OP_LE "<="
%token OP_GE ">="
%token OP_LT "<"
%token OP_GT ">"
%token OP_NEG "!"
%token OP_OR "||"
%token OP_AND "&&"
%token BITWISE_AND "&"

%token ASSIGN "="
%token PLUS "+"
%token MINUS "-"
%token STAR "*"
%token DIV "/"

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
%token VALA_NULL "null"
%token OUT "out"
%token OVERRIDE "override"
%token PUBLIC "public"
%token PRIVATE "private"
%token REF "ref"
%token SET "set"
%token STATIC "static"
%token STRUCT "struct"
%token READONLY "readonly"
%token RETURN "return"
%token THIS "this"
%token VALA_TRUE "true"
%token USING "using"
%token VAR "var"
%token VIRTUAL "virtual"
%token WHILE "while"

%token <str> IDENTIFIER "identifier"
%token <str> LITERAL_CHARACTER "character"
%token <str> LITERAL_INTEGER "integer"
%token <str> LITERAL_STRING "string"

%type <list> opt_type_parameter_list
%type <list> type_parameter_list
%type <list> type_parameters
%type <list> opt_type_argument_list
%type <list> type_argument_list
%type <list> type_arguments
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
%type <list> opt_named_argument_list
%type <list> named_argument_list
%type <list> opt_statement_expression_list
%type <list> statement_expression_list
%type <list> opt_variable_initializer_list
%type <list> variable_initializer_list
%type <num> opt_modifiers
%type <num> modifiers
%type <num> modifier
%type <num> opt_parameter_modifier
%type <num> parameter_modifier
%type <bool> opt_at
%type <bool> opt_brackets
%type <bool> boolean_literal
%type <type_reference> type_name
%type <expression> variable_initializer
%type <expression> opt_expression
%type <expression> expression
%type <expression> additive_expression
%type <expression> multiplicative_expression
%type <expression> unary_expression
%type <expression> cast_expression
%type <expression> assignment
%type <expression> primary_expression
%type <expression> literal
%type <expression> simple_name
%type <expression> parenthesized_expression
%type <expression> member_access
%type <expression> invocation_expression
%type <expression> element_access
%type <expression> this_access
%type <expression> statement_expression
%type <expression> argument
%type <expression> object_creation_expression
%type <expression> equality_expression
%type <expression> relational_expression
%type <expression> and_expression
%type <expression> conditional_and_expression
%type <expression> conditional_or_expression
%type <expression> post_increment_expression
%type <expression> post_decrement_expression
%type <expression> struct_or_array_initializer
%type <statement> block
%type <statement> statement
%type <statement> declaration_statement
%type <statement> embedded_statement
%type <statement> expression_statement
%type <statement> selection_statement
%type <statement> if_statement
%type <statement> iteration_statement
%type <statement> while_statement
%type <statement> for_statement
%type <statement> foreach_statement
%type <statement> jump_statement
%type <statement> return_statement
%type <formal_parameter> fixed_parameter
%type <variable_declaration> variable_declaration
%type <variable_declarator> variable_declarator
%type <field> field_declaration
%type <property> property_declaration
%type <property> accessor_declarations
%type <statement> get_accessor_declaration
%type <statement> set_accessor_declaration
%type <statement> accessor_body
%type <named_argument> named_argument
%type <constant> constant_declaration
%type <struct_> struct_declaration
%type <method> method_declaration
%type <method> method_header
%type <enum_> enum_declaration
%type <flags> flags_declaration
%type <list> opt_enum_member_declarations
%type <list> enum_member_declarations
%type <list> enum_body
%type <enum_value> enum_member_declaration
%type <list> opt_flags_member_declarations
%type <list> flags_member_declarations
%type <list> flags_body
%type <flags_value> flags_member_declaration
%type <list> opt_attribute_sections
%type <list> attribute_sections
%type <list> attribute_section
%type <list> attribute_list
%type <list> attribute_arguments
%type <annotation> attribute

%%

compilation_unit
	: /* empty */
	| opt_using_directives outer_declarations
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
		current_source_file->using_directives = g_list_append (current_source_file->using_directives, $2);
	  }
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
	: opt_attribute_sections NAMESPACE IDENTIFIER
	  {
	  	current_namespace = g_new0 (ValaNamespace, 1);
	  	current_namespace->name = $3;
	  	current_namespace->cprefix = current_namespace->name;
	  	current_namespace->source_file = current_source_file;
	  	current_namespace->lower_case_cname = camel_case_to_lower_case (current_namespace->name);
		/* we know that this is safe */
		current_namespace->lower_case_cname[strlen (current_namespace->lower_case_cname)] = '_';

	  	current_namespace->upper_case_cname = camel_case_to_upper_case (current_namespace->name);
		/* we know that this is safe */
		current_namespace->upper_case_cname[strlen (current_namespace->upper_case_cname)] = '_';

		current_namespace->annotations = $1;
		
		GList *l, *al;
		for (l = current_namespace->annotations; l != NULL; l = l->next) {
			ValaAnnotation *anno = l->data;
			
			if (strcmp (anno->type->type_name, "CCode") == 0) {
				for (al = anno->argument_list; al != NULL; al = al->next) {
					ValaNamedArgument *arg = al->data;
					
					if (strcmp (arg->name, "cname") == 0) {
						current_namespace->lower_case_cname = g_strdup_printf ("%s_", eval_string (arg->expression->str));
						current_namespace->upper_case_cname = g_ascii_strup (current_namespace->lower_case_cname, -1);
					} else if (strcmp (arg->name, "cprefix") == 0) {
						current_namespace->cprefix = eval_string (arg->expression->str);
					} else if (strcmp (arg->name, "include_filename") == 0) {
						current_namespace->include_filename = eval_string (arg->expression->str);
					}
				}
			} else if (strcmp (anno->type->type_name, "Import") == 0) {
				current_namespace->import = TRUE;
			}
		}

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
	| field_declaration
	  {
	  	current_namespace->fields = g_list_append (current_namespace->fields, $1);
	  	$1->namespace = current_namespace;
	  }
	| method_declaration
	  {
	  	current_namespace->methods = g_list_append (current_namespace->methods, $1);
	  }
	;

type_declaration
	: class_declaration
	| struct_declaration
	| enum_declaration
	  {
	  	$1->namespace = current_namespace;
		current_namespace->enums = g_list_append (current_namespace->enums, $1);
	  }
	| flags_declaration
	  {
	  	$1->namespace = current_namespace;
		current_namespace->flags_list = g_list_append (current_namespace->flags_list, $1);
	  }
	;

class_declaration
	: opt_attribute_sections opt_modifiers CLASS IDENTIFIER opt_type_parameter_list opt_class_base
	  {
		current_class = g_new0 (ValaClass, 1);
		current_class->name = g_strdup ($4);
		current_class->base_types = $6;
		current_class->type_parameters = $5;
		current_class->location = current_location (@3);
		current_class->namespace = current_namespace;
		current_class->cname = g_strdup_printf ("%s%s", current_namespace->cprefix, current_class->name);
	  	current_class->lower_case_cname = camel_case_to_lower_case (current_class->name);
	  	current_class->upper_case_cname = camel_case_to_upper_case (current_class->name);
		current_namespace->classes = g_list_append (current_namespace->classes, current_class);
	  }
	  class_body
	;

opt_type_parameter_list
	: /* empty */
	  {
	  	$$ = NULL;
	  }
	| type_parameter_list
	  {
	  	$$ = $1;
	  }
	;

type_parameter_list
	: OP_LT type_parameters OP_GT
	  {
	  	$$ = $2;
	  }
	;

type_parameters
	: IDENTIFIER
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| type_parameters COMMA IDENTIFIER
	  {
		$$ = g_list_append ($1, $3);
	  }
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
	: IDENTIFIER opt_type_argument_list opt_at opt_brackets
	  {
		ValaTypeReference *type_reference = g_new0 (ValaTypeReference, 1);
		type_reference->type_name = g_strdup ($1);
		type_reference->location = current_location (@1);
		type_reference->own = $3;
		type_reference->array_type = $4;
		type_reference->type_params = $2;
		$$ = type_reference;
	  }
	| IDENTIFIER DOT IDENTIFIER opt_type_argument_list opt_at opt_brackets
	  {
		ValaTypeReference *type_reference = g_new0 (ValaTypeReference, 1);
		type_reference->namespace_name = g_strdup ($1);
		type_reference->type_name = g_strdup ($3);
		type_reference->location = current_location (@1);
		type_reference->own = $5;
		type_reference->array_type = $6;
		type_reference->type_params = $4;
		$$ = type_reference;
	  }
	;

opt_type_argument_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| type_argument_list
	  {
		$$ = $1;
	  }
	;

type_argument_list
	: OP_LT type_arguments OP_GT
	  {
		$$ = $2;
	  }
	;

type_arguments
	: opt_parameter_modifier type_name
	  {
		$$ = g_list_append (NULL, $2);;
	  }
	| type_arguments COMMA opt_parameter_modifier type_name
	  {
		$$ = g_list_append ($1, $4);;
	  }
	;

opt_at
	: /* empty */
	  {
		$$ = FALSE;
	  }
	| HASH
	  {
		$$ = TRUE;
	  }
	;

opt_brackets
	: /* empty */
	  {
		$$ = FALSE;
	  }
	| OPEN_BRACKET CLOSE_BRACKET
	  {
		$$ = TRUE;
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
	  	$1->class = current_class;
	  	current_class->constants = g_list_append (current_class->constants, $1);
	  }
	| method_declaration
	  {
	  	$1->class = current_class;
	  	if ($1->cname == NULL) {
			$1->cname = g_strdup_printf ("%s%s_%s", current_namespace->lower_case_cname, current_class->lower_case_cname, $1->name);
		}
		current_class->methods = g_list_append (current_class->methods, current_method);
	  }
	| field_declaration
	  {
	  	$1->class = current_class;
	  	current_class->fields = g_list_append (current_class->fields, $1);
	  }
	| property_declaration
	  {
	  	$1->class = current_class;
	  	current_class->properties = g_list_append (current_class->properties, $1);
	  }
	;

constant_declaration
	: opt_attribute_sections opt_modifiers CONST declaration_statement
	  {
	  	$$ = g_new0 (ValaConstant, 1);
	  	$$->location = current_location (@3);
	  	/* default constants to private access */
	  	if (($2 & VALA_MODIFIER_PUBLIC) == 0) {
	  		$$->modifiers = $2 | VALA_MODIFIER_PRIVATE;
	  	} else {
	  		$$->modifiers = $2;
	  	}
	  	$$->declaration_statement = $4;
	  }
	;

method_declaration
	: method_header method_body
	  {
		$$ = $1;
	  }
	;

method_header
	: opt_attribute_sections opt_modifiers opt_parameter_modifier type_name IDENTIFIER OPEN_PARENS opt_formal_parameter_list CLOSE_PARENS
	  {
	  	$$ = g_new0 (ValaMethod, 1);
	  	$$->name = g_strdup ($5);
	  	$$->return_type = $4;
	  	$$->formal_parameters = $7;
	  	$$->modifiers = $2;
		$$->location = current_location (@5);

		$$->annotations = $1;
		
		GList *l, *al;
		for (l = $$->annotations; l != NULL; l = l->next) {
			ValaAnnotation *anno = l->data;
			
			if (strcmp (anno->type->type_name, "CCode") == 0) {
				for (al = anno->argument_list; al != NULL; al = al->next) {
					ValaNamedArgument *arg = al->data;
					
					if (strcmp (arg->name, "cname") == 0) {
						$$->cname = eval_string (arg->expression->str);
					}
				}
			} else if (strcmp (anno->type->type_name, "ReturnsModifiedPointer") == 0) {
				$$->returns_modified_pointer = TRUE;
			} else if (strcmp (anno->type->type_name, "InstanceLast") == 0) {
				$$->instance_last = TRUE;
			}
		}

		current_method = $$;
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
	: opt_parameter_modifier type_name IDENTIFIER
	  {
		$$ = g_new0 (ValaFormalParameter, 1);
		$$->type = $2;
		$$->name = $3;
		$$->modifier = $1;
		$$->location = current_location (@1);
	  }
	;

opt_parameter_modifier
	: /* empty */
	  {
		$$ = 0;
	  }
	| parameter_modifier
	  {
		$$ = $1;
	  }
	;

parameter_modifier
	: REF
	  {
		$$ = 1;
	  }
	| OUT
	  {
		$$ = 2;
	  }
	;

method_body
	: block
	  {
		current_method->body = $1;
	  }
	| SEMICOLON
	;

field_declaration
	: opt_attribute_sections opt_modifiers declaration_statement
	  {
	  	$$ = g_new0 (ValaField, 1);
	  	$$->location = current_location (@3);
	  	/* default fields to private access */
	  	if (($2 & VALA_MODIFIER_PUBLIC) == 0) {
	  		$$->modifiers = $2 | VALA_MODIFIER_PRIVATE;
	  	} else {
	  		$$->modifiers = $2;
	  	}
		$$->declaration_statement = $3;

		$$->annotations = $1;
		
		GList *l, *al;
		for (l = $$->annotations; l != NULL; l = l->next) {
			ValaAnnotation *anno = l->data;
			
			if (strcmp (anno->type->type_name, "CCode") == 0) {
				for (al = anno->argument_list; al != NULL; al = al->next) {
					ValaNamedArgument *arg = al->data;
					
					if (strcmp (arg->name, "cname") == 0) {
						$$->cname = eval_string (arg->expression->str);
					}
				}
			}
		}

		/* readonly => create private field and public construct-only property */
	  	if ($2 & VALA_MODIFIER_READONLY) {
			/* error if not in class or not public */
			$$->modifiers = VALA_MODIFIER_PRIVATE;
			char *name = $$->declaration_statement->variable_declaration->declarator->name;
			$$->declaration_statement->variable_declaration->declarator->name = g_strdup_printf ("_%s", name);
			
			ValaProperty *prop = g_new0 (ValaProperty, 1);
;
		  	prop->name = name;
		  	prop->location = current_location (@3);
		  	prop->return_type = $$->declaration_statement->variable_declaration->type;
		  	prop->modifiers = VALA_MODIFIER_PUBLIC;
		  	prop->class = current_class;
		  	
		  	ValaStatement *stmt;

			prop->get_statement = g_new0 (ValaStatement, 1);
			prop->get_statement->type = VALA_STATEMENT_TYPE_BLOCK;
			prop->get_statement->location = current_location (@3);

		  	stmt = g_new0 (ValaStatement, 1);
			stmt->type = VALA_STATEMENT_TYPE_RETURN;
			stmt->location = current_location (@3);
			stmt->expr = g_new0 (ValaExpression, 1);
			stmt->expr->type = VALA_EXPRESSION_TYPE_SIMPLE_NAME;
			stmt->expr->location = current_location (@3);
			stmt->expr->str = g_strdup_printf ("_%s", name);
			prop->get_statement->block.statements = g_list_append (prop->get_statement->block.statements, stmt);

			prop->set_statement = g_new0 (ValaStatement, 1);
			prop->set_statement->type = VALA_STATEMENT_TYPE_BLOCK;
			prop->set_statement->location = current_location (@3);

		  	stmt = g_new0 (ValaStatement, 1);
			stmt->type = VALA_STATEMENT_TYPE_EXPRESSION;
			stmt->location = current_location (@3);
			stmt->expr = g_new0 (ValaExpression, 1);
			stmt->expr->type = VALA_EXPRESSION_TYPE_ASSIGNMENT;
			stmt->expr->location = current_location (@1);
			stmt->expr->assignment.left = g_new0 (ValaExpression, 1);
			stmt->expr->assignment.left->type = VALA_EXPRESSION_TYPE_SIMPLE_NAME;
			stmt->expr->assignment.left->location = current_location (@3);
			stmt->expr->assignment.left->str = g_strdup_printf ("_%s", name);
			stmt->expr->assignment.right = g_new0 (ValaExpression, 1);
			stmt->expr->assignment.right->type = VALA_EXPRESSION_TYPE_SIMPLE_NAME;
			stmt->expr->assignment.right->location = current_location (@3);
			stmt->expr->assignment.right->str = "value";
			prop->set_statement->block.statements = g_list_append (prop->set_statement->block.statements, stmt);

			current_class->properties = g_list_append (current_class->properties, prop);
		}
	  }
	;

opt_modifiers
	: /* emtpty */
	  {
	  	$$ = 0;
	  }
	| modifiers
	  {
	  	$$ = $1;
	  }
	;

modifiers
	: modifier
	  {
	  	$$ = $1;
	  }
	| modifiers modifier
	  {
	  	$$ = $1 | $2;
	  }
	;

modifier
	: PUBLIC
	  {
	  	$$ = VALA_MODIFIER_PUBLIC;
	  }
	| PRIVATE
	  {
	  	$$ = VALA_MODIFIER_PRIVATE;
	  }
	| STATIC
	  {
	  	$$ = VALA_MODIFIER_STATIC;
	  }
	| ABSTRACT
	  {
		$$ = VALA_MODIFIER_ABSTRACT;
	  }
	| VIRTUAL
	  {
		$$ = VALA_MODIFIER_VIRTUAL;
	  }
	| OVERRIDE
	  {
		$$ = VALA_MODIFIER_OVERRIDE;
	  }
	| READONLY
	  {
		$$ = VALA_MODIFIER_READONLY;
	  }
	;
	
property_declaration
	: opt_attribute_sections opt_modifiers opt_parameter_modifier type_name IDENTIFIER OPEN_BRACE accessor_declarations CLOSE_BRACE
	  {
	  	$$ = $7;
	  	$$->name = g_strdup ($5);
	  	$$->location = current_location (@5);
	  	$$->return_type = $4;
	  	/* default fields to private access */
	  	if (($2 & VALA_MODIFIER_PUBLIC) == 0) {
	  		yyerror (&@2, "Properties must have a public modifier.");
	  		YYERROR;
	  	}
	  	$$->modifiers = $2;

		if ($$->get_statement == NULL && $$->set_statement == NULL) {
			// no property bodies provided => create private field and public construct-only property

		  	ValaField *f = g_new0 (ValaField, 1);

		  	f->location = current_location (@5);
	  		f->modifiers = VALA_MODIFIER_PRIVATE;
			f->declaration_statement = g_new0 (ValaStatement, 1);
			f->declaration_statement->type = VALA_STATEMENT_TYPE_VARIABLE_DECLARATION;
			f->declaration_statement->location = current_location (@5);
			f->declaration_statement->variable_declaration = g_new0 (ValaVariableDeclaration, 1);
			f->declaration_statement->variable_declaration->type = $4;
			f->declaration_statement->variable_declaration->declarator = g_new0 (ValaVariableDeclarator, 1);
			f->declaration_statement->variable_declaration->declarator->name = g_strdup_printf ("_%s", $5);
			f->declaration_statement->variable_declaration->declarator->location = current_location (@5);
			f->class = current_class;

		  	ValaStatement *stmt;

			$$->get_statement = g_new0 (ValaStatement, 1);
			$$->get_statement->type = VALA_STATEMENT_TYPE_BLOCK;
			$$->get_statement->location = current_location (@5);

		  	stmt = g_new0 (ValaStatement, 1);
			stmt->type = VALA_STATEMENT_TYPE_RETURN;
			stmt->location = current_location (@5);
			stmt->expr = g_new0 (ValaExpression, 1);
			stmt->expr->type = VALA_EXPRESSION_TYPE_SIMPLE_NAME;
			stmt->expr->location = current_location (@5);
			stmt->expr->str = g_strdup_printf ("_%s", $5);
			$$->get_statement->block.statements = g_list_append ($$->get_statement->block.statements, stmt);

			$$->set_statement = g_new0 (ValaStatement, 1);
			$$->set_statement->type = VALA_STATEMENT_TYPE_BLOCK;
			$$->set_statement->location = current_location (@5);

		  	stmt = g_new0 (ValaStatement, 1);
			stmt->type = VALA_STATEMENT_TYPE_EXPRESSION;
			stmt->location = current_location (@5);
			stmt->expr = g_new0 (ValaExpression, 1);
			stmt->expr->type = VALA_EXPRESSION_TYPE_ASSIGNMENT;
			stmt->expr->location = current_location (@5);
			stmt->expr->assignment.left = g_new0 (ValaExpression, 1);
			stmt->expr->assignment.left->type = VALA_EXPRESSION_TYPE_SIMPLE_NAME;
			stmt->expr->assignment.left->location = current_location (@5);
			stmt->expr->assignment.left->str = g_strdup_printf ("_%s", $5);
			stmt->expr->assignment.right = g_new0 (ValaExpression, 1);
			stmt->expr->assignment.right->type = VALA_EXPRESSION_TYPE_SIMPLE_NAME;
			stmt->expr->assignment.right->location = current_location (@5);
			stmt->expr->assignment.right->str = "value";
			$$->set_statement->block.statements = g_list_append ($$->set_statement->block.statements, stmt);

			current_class->fields = g_list_append (current_class->fields, f);
		}
	  }
	;
	
accessor_declarations
	: get_accessor_declaration
	  {
	  	$$ = g_new0 (ValaProperty, 1);
	  	$$->get_statement = $1;
	  }
	| set_accessor_declaration
	  {
	  	$$ = g_new0 (ValaProperty, 1);
	  	$$->set_statement = $1;
	  }
	| get_accessor_declaration set_accessor_declaration
	  {
	  	$$ = g_new0 (ValaProperty, 1);
	  	$$->get_statement = $1;
	  	$$->set_statement = $2;
	  }
	| set_accessor_declaration get_accessor_declaration	  {
	  	$$ = g_new0 (ValaProperty, 1);
	  	$$->get_statement = $1;
	  	$$->set_statement = $2;
	  }

	;

get_accessor_declaration
	: GET accessor_body
	  {
	  	$$ = $2;
	  }
	;
	
set_accessor_declaration
	: SET accessor_body
	  {
	  	$$ = $2;
	  }
	| CONSTRUCT accessor_body
	  {
	  	$$ = $2;
	  }
	| SET CONSTRUCT accessor_body
	  {
	  	$$ = $3;
	  }
	;

accessor_body
	: block
	| SEMICOLON
	  {
		$$ = NULL;
	  }
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
		$$->variable_declaration = $1;
	  }
	;

variable_declaration
	: opt_parameter_modifier type_name variable_declarator
	  {
		$$ = g_new0 (ValaVariableDeclaration, 1);
		$$->type = $2;
		$$->declarator = $3;
	  }
	|
	  VAR IDENTIFIER ASSIGN variable_initializer
	  {
		$$ = g_new0 (ValaVariableDeclaration, 1);
		$$->type = g_new0 (ValaTypeReference, 1);
		$$->type->location = current_location (@1);
		$$->declarator = g_new0 (ValaVariableDeclarator, 1);
		$$->declarator->name = $2;
		$$->declarator->initializer = $4;
		$$->declarator->location = current_location (@1);
	  }
	;

variable_declarator
	: IDENTIFIER
	  {
		$$ = g_new0 (ValaVariableDeclarator, 1);
		$$->name = $1;
		$$->location = current_location (@1);
	  }
	| IDENTIFIER ASSIGN variable_initializer
	  {
		$$ = g_new0 (ValaVariableDeclarator, 1);
		$$->name = $1;
		$$->initializer = $3;
		$$->location = current_location (@1);
	  }
	;

opt_variable_initializer_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| variable_initializer_list
	  {
		$$ = $1;
	  }
	;

variable_initializer_list
	: variable_initializer
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| variable_initializer_list COMMA variable_initializer
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

variable_initializer
	: argument
	  {
		$$ = $1;
	  }
	| struct_or_array_initializer
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
	;

expression
	: conditional_or_expression
	| assignment
	;

equality_expression
	: relational_expression
	| equality_expression OP_EQ relational_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_EQ;
		$$->op.right = $3;
	  }
	| equality_expression OP_NE relational_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_NE;
		$$->op.right = $3;
	  }
	;

and_expression
	: equality_expression
	| and_expression BITWISE_AND equality_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_BITWISE_AND;
		$$->op.right = $3;
	  }
	;

conditional_and_expression
	: and_expression
	| conditional_and_expression OP_AND and_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_AND;
		$$->op.right = $3;
	  }
	;

conditional_or_expression
	: conditional_and_expression
	| conditional_or_expression OP_OR conditional_and_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_OR;
		$$->op.right = $3;
	  }
	;

relational_expression
	: additive_expression
	  {
		$$ = $1;
	  }
	| relational_expression OP_LT additive_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_LT;
		$$->op.right = $3;
	  }
	| relational_expression OP_GT additive_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_GT;
		$$->op.right = $3;
	  }
	| relational_expression OP_LE additive_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_LE;
		$$->op.right = $3;
	  }
	| relational_expression OP_GE additive_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_GE;
		$$->op.right = $3;
	  }
	| relational_expression IS type_name
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_IS;
		$$->location = current_location (@1);
		$$->is.expr = $1;
		$$->is.type = $3;
	  }
	;

additive_expression
	: multiplicative_expression
	  {
		$$ = $1;
	  }
	| additive_expression PLUS multiplicative_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_PLUS;
		$$->op.right = $3;
	  }
	| additive_expression MINUS multiplicative_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_MINUS;
		$$->op.right = $3;
	  }
	;

multiplicative_expression
	: unary_expression
	  {
		$$ = $1;
	  }
	| multiplicative_expression STAR unary_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_MUL;
		$$->op.right = $3;
	  }
	| multiplicative_expression DIV unary_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.left = $1;
		$$->op.type = VALA_OP_TYPE_DIV;
		$$->op.right = $3;
	  }
	;

unary_expression
	: primary_expression
	  {
		$$ = $1;
	  }
	| MINUS unary_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.type = VALA_OP_TYPE_MINUS;
		$$->op.right = $2;
	  }
	| OP_NEG unary_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OPERATION;
		$$->location = current_location (@1);
		$$->op.type = VALA_OP_TYPE_NEG;
		$$->op.right = $2;
	  }
	| cast_expression
	;

cast_expression
	: OPEN_CAST_PARENS type_name CLOSE_PARENS unary_expression
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_CAST;
		$$->location = current_location (@1);
		$$->cast.type = $2;
		$$->cast.inner = $4;
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
	| element_access
	  {
		$$ = $1;
	  }
	| this_access
	  {
		$$ = $1;
	  }
	| post_increment_expression
	  {
		$$ = $1;
	  }
	| post_decrement_expression
	  {
		$$ = $1;
	  }
	| object_creation_expression
	  {
		$$ = $1;
	  }
	;

literal
	: LITERAL_CHARACTER
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_LITERAL_CHARACTER;
		$$->location = current_location (@1);
		$$->str = $1;
	  }
	| LITERAL_INTEGER
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
	| boolean_literal
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_LITERAL_BOOLEAN;
		$$->location = current_location (@1);
		$$->num = $1;
	  }
	| VALA_NULL
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_LITERAL_NULL;
		$$->location = current_location (@1);
	  }
	;

boolean_literal
	: VALA_TRUE
	  {
		$$ = TRUE;
	  }
	| VALA_FALSE
	  {
		$$ = FALSE;
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
	| REF expression
	  {
		$$ = $2;
		$$->ref_variable = TRUE;
	  }
	| OUT expression
	  {
		$$ = $2;
		$$->out_variable = TRUE;
	  }
	;

element_access
	: primary_expression OPEN_BRACKET primary_expression CLOSE_BRACKET
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_ELEMENT_ACCESS;
		$$->location = current_location (@1);
		$$->element_access.array = $1;
		$$->element_access.index = $3;
	  }
	;

this_access
	: THIS
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_THIS_ACCESS;
		$$->location = current_location (@1);
	  }
	;

post_increment_expression
	: primary_expression OP_INC
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_POSTFIX;
		$$->location = current_location (@1);
		$$->postfix.inner = $1;
		$$->postfix.cop = "++";
	  }
	;

post_decrement_expression
	: primary_expression OP_DEC
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_POSTFIX;
		$$->location = current_location (@1);
		$$->postfix.inner = $1;
		$$->postfix.cop = "--";
	  }
	;

object_creation_expression
	: IDENTIFIER type_name OPEN_PARENS opt_named_argument_list CLOSE_PARENS
	  {
		if (strcmp ($1, "new") != 0) {
			/* raise error */
			fprintf (stderr, "syntax error: object creation expression without new\n");
		}
		
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_OBJECT_CREATION;
		$$->location = current_location (@1);
		$$->object_creation.type = $2;
		$$->object_creation.named_argument_list = $4;
	  }
	;

opt_named_argument_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| named_argument_list
	  {
		$$ = $1;
	  }
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
		$$ = g_new0 (ValaNamedArgument, 1);
		$$->name = $1;
		$$->expression = $3;
		$$->location = current_location (@1);
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
	| selection_statement
	  {
		$$ = $1;
	  }
	| iteration_statement
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
	| object_creation_expression
	  {
		$$ = $1;
	  }
	| assignment
	  {
		$$ = $1;
	  }
	| post_increment_expression
	  {
		$$ = $1;
	  }
	| post_decrement_expression
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

selection_statement
	: if_statement
	  {
		$$ = $1;
	  }
	;

if_statement
	: IF OPEN_PARENS expression CLOSE_PARENS embedded_statement
	  {
		$$ = g_new0 (ValaStatement, 1);
		$$->type = VALA_STATEMENT_TYPE_IF;
		$$->location = current_location (@1);
		$$->if_stmt.condition = $3;
		$$->if_stmt.true_stmt = $5;
	  }
	| IF OPEN_PARENS expression CLOSE_PARENS embedded_statement ELSE embedded_statement
	  {
		$$ = g_new0 (ValaStatement, 1);
		$$->type = VALA_STATEMENT_TYPE_IF;
		$$->location = current_location (@1);
		$$->if_stmt.condition = $3;
		$$->if_stmt.true_stmt = $5;
		$$->if_stmt.false_stmt = $7;
	  }
	;


iteration_statement
	: while_statement
	| for_statement
	  {
		$$ = $1;
	  }
	| foreach_statement
	  {
		$$ = $1;
	  }
	;

while_statement
	: WHILE OPEN_PARENS expression CLOSE_PARENS embedded_statement
	  {
		$$ = g_new0 (ValaStatement, 1);
		$$->type = VALA_STATEMENT_TYPE_WHILE;
		$$->location = current_location (@1);
		$$->while_stmt.condition = $3;
		$$->while_stmt.loop = $5;
	  }
	;

for_statement
	: FOR OPEN_PARENS opt_statement_expression_list SEMICOLON opt_expression SEMICOLON opt_statement_expression_list CLOSE_PARENS embedded_statement
	  {
		$$ = g_new0 (ValaStatement, 1);
		$$->type = VALA_STATEMENT_TYPE_FOR;
		$$->location = current_location (@1);
		$$->for_stmt.initializer = $3;
		$$->for_stmt.condition = $5;
		$$->for_stmt.iterator = $7;
		$$->for_stmt.loop = $9;
	  }
	;

opt_statement_expression_list
	: /* empty */
	  {
		$$ = NULL;
	  }
	| statement_expression_list
	  {
		$$ = $1;
	  }
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
	: FOREACH OPEN_PARENS type_name IDENTIFIER IN expression CLOSE_PARENS embedded_statement
	  {
		$$ = g_new0 (ValaStatement, 1);
		$$->type = VALA_STATEMENT_TYPE_FOREACH;
		$$->location = current_location (@1);
		$$->foreach_stmt.type = $3;
		$$->foreach_stmt.name = $4;
		$$->foreach_stmt.container = $6;
		$$->foreach_stmt.loop = $8;
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

struct_or_array_initializer
	: OPEN_BRACE opt_variable_initializer_list CLOSE_BRACE
	  {
		$$ = g_new0 (ValaExpression, 1);
		$$->type = VALA_EXPRESSION_TYPE_STRUCT_OR_ARRAY_INITIALIZER;
		$$->location = current_location (@1);
		$$->list = $2;
	  }
	;

struct_declaration
	: opt_attribute_sections opt_modifiers STRUCT IDENTIFIER opt_type_parameter_list
	  {
		$$ = g_new0 (ValaStruct, 1);
		$$->name = g_strdup ($4);
		$$->location = current_location (@3);
		$$->type_parameters = $5;
		$$->namespace = current_namespace;
		$$->cname = g_strdup_printf ("%s%s", current_namespace->cprefix, $$->name);
	  	$$->lower_case_cname = camel_case_to_lower_case ($$->name);
	  	$$->upper_case_cname = camel_case_to_upper_case ($$->name);
		current_namespace->structs = g_list_append (current_namespace->structs, $$);
		current_struct = $$;

		$$->annotations = $1;
		
		GList *l, *al;
		for (l = $$->annotations; l != NULL; l = l->next) {
			ValaAnnotation *anno = l->data;
			
			if (strcmp (anno->type->type_name, "CCode") == 0) {
				for (al = anno->argument_list; al != NULL; al = al->next) {
					ValaNamedArgument *arg = al->data;
					
					if (strcmp (arg->name, "cname") == 0) {
						$$->cname = eval_string (arg->expression->str);
					}
				}
			} else if (strcmp (anno->type->type_name, "ReferenceType") == 0) {
				$$->reference_type = TRUE;
			}
		}
	  }
	  struct_body
	  {
		current_struct = NULL;
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
	  	$1->is_struct_field = TRUE;
	  	$1->struct_ = current_struct;
		current_struct->fields = g_list_append (current_struct->fields, $1);
	  }
	| method_declaration
	  {
	  	$1->is_struct_method = TRUE;
	  	$1->struct_ = current_struct;
		current_struct->methods = g_list_append (current_struct->methods, $1);
	  }
	;

enum_declaration
	: opt_attribute_sections opt_modifiers ENUM IDENTIFIER enum_body
	  {
	  	GList *l;
	  	
		$$ = g_new0 (ValaEnum, 1);
		$$->name = $4;
		$$->location = current_location (@3);
		$$->cname = g_strdup_printf ("%s%s", current_namespace->cprefix, $$->name);
		$$->upper_case_cname = camel_case_to_upper_case ($$->name);
		$$->values = $5;
		
		for (l = $$->values; l != NULL; l = l->next) {
			ValaEnumValue *value = l->data;
			value->cname = g_strdup_printf ("%s%s_%s", current_namespace->upper_case_cname, $$->upper_case_cname, value->name);
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
	| enum_member_declarations
	  {
		$$ = $1;
	  }
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
	: IDENTIFIER
	  {
		$$ = g_new0 (ValaEnumValue, 1);
		$$->name = $1;
	  }
	| IDENTIFIER ASSIGN expression
	  {
		$$ = g_new0 (ValaEnumValue, 1);
		$$->name = $1;
	  }
	;

flags_declaration
	: opt_attribute_sections opt_modifiers FLAGS IDENTIFIER flags_body
	  {
		$$ = g_new0 (ValaFlags, 1);
		$$->name = $4;
		$$->location = current_location (@3);
		$$->cname = g_strdup_printf ("%s%s", current_namespace->cprefix, $$->name);
		$$->values = $5;
	  }
	;

flags_body
	: OPEN_BRACE opt_flags_member_declarations CLOSE_BRACE
	  {
		$$ = $2;
	  }
	;

opt_flags_member_declarations
	: /* empty */
	  {
		$$ = NULL;
	  }
	| flags_member_declarations
	  {
		$$ = $1;
	  }
	;

flags_member_declarations
	: flags_member_declaration
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| flags_member_declarations COMMA flags_member_declaration
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

flags_member_declaration
	: IDENTIFIER
	  {
		$$ = g_new0 (ValaFlagsValue, 1);
		$$->name = $1;
	  }
	| IDENTIFIER ASSIGN expression
	  {
		$$ = g_new0 (ValaFlagsValue, 1);
		$$->name = $1;
	  }
	;

opt_attribute_sections
	: /* empty */
	  {
		$$ = NULL;
	  }
	| attribute_sections
	  {
		$$ = $1;
	  }
	;

attribute_sections
	: attribute_section
	  {
		$$ = $1;
	  }
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
	: type_name attribute_arguments
	  {
		$$ = g_new0 (ValaAnnotation, 1);
		$$->type = $1;
		$$->argument_list = $2;
	  }
	;

attribute_arguments
	: OPEN_PARENS opt_named_argument_list CLOSE_PARENS
	  {
		$$ = $2;
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
