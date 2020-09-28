/* GObject introspection: C parser
 *
 * Copyright (c) 1997 Sandro Sigala  <ssigala@globalnet.it>
 * Copyright (c) 2007-2008 Jürg Billeter  <j@bitron.ch>
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include "scanner.h"

extern FILE *yyin;
extern int lineno;
extern char *yytext;

extern int yylex (GIGenerator *igenerator);
static void yyerror(GIGenerator *igenerator, const char *s);
 
static int last_enum_value = -1;
static GHashTable *const_table = NULL;

CSymbol *
csymbol_new (CSymbolType type)
{
  CSymbol *s = g_new0 (CSymbol, 1);
  s->type = type;
  return s;
}

static void
ctype_free (CType * type)
{
  g_free (type->name);
  g_list_foreach (type->child_list, (GFunc)ctype_free, NULL);
  g_list_free (type->child_list);
  g_free (type);
}

void
csymbol_free (CSymbol * symbol)
{
  g_free (symbol->ident);
  ctype_free (symbol->base_type);
  g_free (symbol->const_string);
  g_slist_foreach (symbol->directives, (GFunc)cdirective_free, NULL);
  g_slist_free (symbol->directives);
  g_free (symbol);
}
 
gboolean
csymbol_get_const_boolean (CSymbol * symbol)
{
  return (symbol->const_int_set && symbol->const_int) || symbol->const_string;
}

static CType *
ctype_new (CTypeType type)
{
  CType *t = g_new0 (CType, 1);
  t->type = type;
  return t;
}

static CType *
ctype_copy (CType * type)
{
  return g_memdup (type, sizeof (CType));
}

static CType *
cbasic_type_new (const char *name)
{
  CType *basic_type = ctype_new (CTYPE_BASIC_TYPE);
  basic_type->name = g_strdup (name);
  return basic_type;
}

static CType *
ctypedef_new (const char *name)
{
  CType *typedef_ = ctype_new (CTYPE_TYPEDEF);
  typedef_->name = g_strdup (name);
  return typedef_;
}

static CType *
cstruct_new (const char *name)
{
  CType *struct_ = ctype_new (CTYPE_STRUCT);
  struct_->name = g_strdup (name);
  return struct_;
}

static CType *
cunion_new (const char *name)
{
  CType *union_ = ctype_new (CTYPE_UNION);
  union_->name = g_strdup (name);
  return union_;
}

static CType *
cenum_new (const char *name)
{
  CType *enum_ = ctype_new (CTYPE_ENUM);
  enum_->name = g_strdup (name);
  return enum_;
}

static CType *
cpointer_new (CType * base_type)
{
  CType *pointer = ctype_new (CTYPE_POINTER);
  pointer->base_type = ctype_copy (base_type);
  return pointer;
}

static CType *
carray_new (void)
{
  CType *array = ctype_new (CTYPE_ARRAY);
  return array;
}

static CType *
cfunction_new (void)
{
  CType *func = ctype_new (CTYPE_FUNCTION);
  return func;
}

/* use specified type as base type of symbol */
static void
csymbol_merge_type (CSymbol *symbol, CType *type)
{
  CType **foundation_type = &(symbol->base_type);
  while (*foundation_type != NULL) {
    foundation_type = &((*foundation_type)->base_type);
  }
  *foundation_type = ctype_copy (type);
}

CDirective *
cdirective_new (const gchar *name,
		const gchar *value)
{
  CDirective *directive;
    
  directive = g_slice_new (CDirective);
  directive->name = g_strdup (name);
  directive->value = g_strdup (value);
  return directive;
}

void
cdirective_free (CDirective *directive)
{
  g_free (directive->name);
  g_free (directive->value);
  g_slice_free (CDirective, directive);
}

%}

%error-verbose
%union {
  char *str;
  GList *list;
  CSymbol *symbol;
  CType *ctype;
  StorageClassSpecifier storage_class_specifier;
  TypeQualifier type_qualifier;
  FunctionSpecifier function_specifier;
  UnaryOperator unary_operator;
}

%parse-param { GIGenerator* igenerator }
%lex-param { GIGenerator* igenerator }

%token <str> IDENTIFIER "identifier"
%token <str> TYPEDEF_NAME "typedef-name"

%token INTEGER FLOATING CHARACTER STRING

%token ELLIPSIS ADDEQ SUBEQ MULEQ DIVEQ MODEQ XOREQ ANDEQ OREQ SL SR
%token SLEQ SREQ EQ NOTEQ LTEQ GTEQ ANDAND OROR PLUSPLUS MINUSMINUS ARROW

%token AUTO BOOL BREAK CASE CHAR CONST CONTINUE DEFAULT DO DOUBLE ELSE ENUM
%token EXTERN FLOAT FOR GOTO IF INLINE INT LONG REGISTER RESTRICT RETURN SHORT
%token SIGNED SIZEOF STATIC STRUCT SWITCH TYPEDEF UNION UNSIGNED VOID VOLATILE
%token WHILE

%token FUNCTION_MACRO OBJECT_MACRO

%start translation_unit

%type <ctype> declaration_specifiers
%type <ctype> enum_specifier
%type <ctype> pointer
%type <ctype> specifier_qualifier_list
%type <ctype> struct_or_union
%type <ctype> struct_or_union_specifier
%type <ctype> type_specifier
%type <str> identifier
%type <str> typedef_name
%type <str> identifier_or_typedef_name
%type <symbol> abstract_declarator
%type <symbol> init_declarator
%type <symbol> declarator
%type <symbol> enumerator
%type <symbol> direct_abstract_declarator
%type <symbol> direct_declarator
%type <symbol> parameter_declaration
%type <symbol> struct_declarator
%type <list> enumerator_list
%type <list> identifier_list
%type <list> init_declarator_list
%type <list> parameter_type_list
%type <list> parameter_list
%type <list> struct_declaration
%type <list> struct_declaration_list
%type <list> struct_declarator_list
%type <storage_class_specifier> storage_class_specifier
%type <type_qualifier> type_qualifier
%type <type_qualifier> type_qualifier_list
%type <function_specifier> function_specifier
%type <symbol> expression
%type <symbol> constant_expression
%type <symbol> conditional_expression
%type <symbol> logical_and_expression
%type <symbol> logical_or_expression
%type <symbol> inclusive_or_expression
%type <symbol> exclusive_or_expression
%type <symbol> multiplicative_expression
%type <symbol> additive_expression
%type <symbol> shift_expression
%type <symbol> relational_expression
%type <symbol> equality_expression
%type <symbol> and_expression
%type <symbol> cast_expression
%type <symbol> assignment_expression
%type <symbol> unary_expression
%type <symbol> postfix_expression
%type <symbol> primary_expression
%type <unary_operator> unary_operator
%type <str> function_macro
%type <str> object_macro
%type <symbol> strings

%%

/* A.2.1 Expressions. */

primary_expression
	: identifier
	  {
		$$ = g_hash_table_lookup (const_table, $1);
		if ($$ == NULL) {
			$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
		}
	  }
	| INTEGER
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		if (g_str_has_prefix (yytext, "0x") && strlen (yytext) > 2) {
			$$->const_int = strtol (yytext + 2, NULL, 16);
		} else if (g_str_has_prefix (yytext, "0") && strlen (yytext) > 1) {
			$$->const_int = strtol (yytext + 1, NULL, 8);
		} else {
			$$->const_int = atoi (yytext);
		}
	  }
	| CHARACTER
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| FLOATING
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| strings
	| '(' expression ')'
	  {
		$$ = $2;
	  }
	;

/* concatenate adjacent string literal tokens */
strings
	: STRING
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		yytext[strlen (yytext) - 1] = '\0';
		$$->const_string = g_strcompress (yytext + 1);
	  }
	| strings STRING
	  {
		char *strings, *string2;
		$$ = $1;
		yytext[strlen (yytext) - 1] = '\0';
		string2 = g_strcompress (yytext + 1);
		strings = g_strconcat ($$->const_string, string2, NULL);
		g_free ($$->const_string);
		g_free (string2);
		$$->const_string = strings;
	  }
	;

identifier
	: IDENTIFIER
	  {
		$$ = g_strdup (yytext);
	  }
	;

identifier_or_typedef_name
	: identifier
	| typedef_name
	;

postfix_expression
	: primary_expression
	| postfix_expression '[' expression ']'
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| postfix_expression '(' argument_expression_list ')'
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| postfix_expression '(' ')'
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| postfix_expression '.' identifier_or_typedef_name
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| postfix_expression ARROW identifier_or_typedef_name
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| postfix_expression PLUSPLUS
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| postfix_expression MINUSMINUS
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

unary_expression
	: postfix_expression
	| PLUSPLUS unary_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| MINUSMINUS unary_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| unary_operator cast_expression
	  {
		switch ($1) {
		case UNARY_PLUS:
			$$ = $2;
			break;
		case UNARY_MINUS:
			$$ = $2;
			$$->const_int = -$2->const_int;
			break;
		case UNARY_BITWISE_COMPLEMENT:
			$$ = $2;
			$$->const_int = ~$2->const_int;
			break;
		case UNARY_LOGICAL_NEGATION:
			$$ = $2;
			$$->const_int = !csymbol_get_const_boolean ($2);
			break;
		default:
			$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
			break;
		}
	  }
	| SIZEOF unary_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| SIZEOF '(' type_name ')'
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	;

unary_operator
	: '&'
	  {
		$$ = UNARY_ADDRESS_OF;
	  }
	| '*'
	  {
		$$ = UNARY_POINTER_INDIRECTION;
	  }
	| '+'
	  {
		$$ = UNARY_PLUS;
	  }
	| '-'
	  {
		$$ = UNARY_MINUS;
	  }
	| '~'
	  {
		$$ = UNARY_BITWISE_COMPLEMENT;
	  }
	| '!'
	  {
		$$ = UNARY_LOGICAL_NEGATION;
	  }
	;

cast_expression
	: unary_expression
	| '(' type_name ')' cast_expression
	  {
		$$ = $4;
	  }
	;

multiplicative_expression
	: cast_expression
	| multiplicative_expression '*' cast_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int * $3->const_int;
	  }
	| multiplicative_expression '/' cast_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		if ($3->const_int != 0) {
			$$->const_int = $1->const_int / $3->const_int;
		}
	  }
	| multiplicative_expression '%' cast_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int % $3->const_int;
	  }
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int + $3->const_int;
	  }
	| additive_expression '-' multiplicative_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int - $3->const_int;
	  }
	;

shift_expression
	: additive_expression
	| shift_expression SL additive_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int << $3->const_int;
	  }
	| shift_expression SR additive_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int >> $3->const_int;
	  }
	;

relational_expression
	: shift_expression
	| relational_expression '<' shift_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int < $3->const_int;
	  }
	| relational_expression '>' shift_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int > $3->const_int;
	  }
	| relational_expression LTEQ shift_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int <= $3->const_int;
	  }
	| relational_expression GTEQ shift_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int >= $3->const_int;
	  }
	;

equality_expression
	: relational_expression
	| equality_expression EQ relational_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int == $3->const_int;
	  }
	| equality_expression NOTEQ relational_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int != $3->const_int;
	  }
	;

and_expression
	: equality_expression
	| and_expression '&' equality_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int & $3->const_int;
	  }
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int ^ $3->const_int;
	  }
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = $1->const_int | $3->const_int;
	  }
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression ANDAND inclusive_or_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = csymbol_get_const_boolean ($1) && csymbol_get_const_boolean ($3);
	  }
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OROR logical_and_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_CONST);
		$$->const_int_set = TRUE;
		$$->const_int = csymbol_get_const_boolean ($1) || csymbol_get_const_boolean ($3);
	  }
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression
	  {
		$$ = csymbol_get_const_boolean ($1) ? $3 : $5;
	  }
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	;

assignment_operator
	: '='
	| MULEQ
	| DIVEQ
	| MODEQ
	| ADDEQ
	| SUBEQ
	| SLEQ
	| SREQ
	| ANDEQ
	| XOREQ
	| OREQ
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	;

constant_expression
	: conditional_expression
	;

/* A.2.2 Declarations. */

declaration
	: declaration_specifiers init_declarator_list ';'
	  {
		GList *l;
		for (l = $2; l != NULL; l = l->next) {
			CSymbol *sym = l->data;
			csymbol_merge_type (sym, $1);
			if ($1->storage_class_specifier & STORAGE_CLASS_TYPEDEF) {
				sym->type = CSYMBOL_TYPE_TYPEDEF;
			} else if (sym->base_type->type == CTYPE_FUNCTION) {
				sym->type = CSYMBOL_TYPE_FUNCTION;
			} else {
				sym->type = CSYMBOL_TYPE_OBJECT;
			}
			g_igenerator_add_symbol (igenerator, sym);
		}
	  }
	| declaration_specifiers ';'
	;

declaration_specifiers
	: storage_class_specifier declaration_specifiers
	  {
		$$ = $2;
		$$->storage_class_specifier |= $1;
	  }
	| storage_class_specifier
	  {
		$$ = ctype_new (CTYPE_INVALID);
		$$->storage_class_specifier |= $1;
	  }
	| type_specifier declaration_specifiers
	  {
		$$ = $1;
		$$->base_type = $2;
	  }
	| type_specifier
	| type_qualifier declaration_specifiers
	  {
		$$ = $2;
		$$->type_qualifier |= $1;
	  }
	| type_qualifier
	  {
		$$ = ctype_new (CTYPE_INVALID);
		$$->type_qualifier |= $1;
	  }
	| function_specifier declaration_specifiers
	  {
		$$ = $2;
		$$->function_specifier |= $1;
	  }
	| function_specifier
	  {
		$$ = ctype_new (CTYPE_INVALID);
		$$->function_specifier |= $1;
	  }
	;

init_declarator_list
	: init_declarator
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| init_declarator_list ',' init_declarator
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

init_declarator
	: declarator
	| declarator '=' initializer
	;

storage_class_specifier
	: TYPEDEF
	  {
		$$ = STORAGE_CLASS_TYPEDEF;
	  }
	| EXTERN
	  {
		$$ = STORAGE_CLASS_EXTERN;
	  }
	| STATIC
	  {
		$$ = STORAGE_CLASS_STATIC;
	  }
	| AUTO
	  {
		$$ = STORAGE_CLASS_AUTO;
	  }
	| REGISTER
	  {
		$$ = STORAGE_CLASS_REGISTER;
	  }
	;

type_specifier
	: VOID
	  {
		$$ = ctype_new (CTYPE_VOID);
	  }
	| CHAR
	  {
		$$ = cbasic_type_new ("char");
	  }
	| SHORT
	  {
		$$ = cbasic_type_new ("short");
	  }
	| INT
	  {
		$$ = cbasic_type_new ("int");
	  }
	| LONG
	  {
		$$ = cbasic_type_new ("long");
	  }
	| FLOAT
	  {
		$$ = cbasic_type_new ("float");
	  }
	| DOUBLE
	  {
		$$ = cbasic_type_new ("double");
	  }
	| SIGNED
	  {
		$$ = cbasic_type_new ("signed");
	  }
	| UNSIGNED
	  {
		$$ = cbasic_type_new ("unsigned");
	  }
	| BOOL
	  {
		$$ = cbasic_type_new ("bool");
	  }
	| struct_or_union_specifier
	| enum_specifier
	| typedef_name
	  {
		$$ = ctypedef_new ($1);
	  }
	;

struct_or_union_specifier
	: struct_or_union identifier_or_typedef_name '{' struct_declaration_list '}'
	  {
		CSymbol *sym;

		$$ = $1;
		$$->name = $2;
		$$->child_list = $4;

		sym = csymbol_new (CSYMBOL_TYPE_INVALID);
		if ($$->type == CTYPE_STRUCT) {
			sym->type = CSYMBOL_TYPE_STRUCT;
		} else if ($$->type == CTYPE_UNION) {
			sym->type = CSYMBOL_TYPE_UNION;
		} else {
			g_assert_not_reached ();
		}
		sym->ident = g_strdup ($$->name);
		sym->base_type = ctype_copy ($$);
		g_igenerator_add_symbol (igenerator, sym);
	  }
	| struct_or_union '{' struct_declaration_list '}'
	  {
		$$ = $1;
		$$->child_list = $3;
	  }
	| struct_or_union identifier_or_typedef_name
	  {
		$$ = $1;
		$$->name = $2;
	  }
	;

struct_or_union
	: STRUCT
	  {
		$$ = cstruct_new (NULL);
	  }
	| UNION
	  {
		$$ = cunion_new (NULL);
	  }
	;

struct_declaration_list
	: struct_declaration
	| struct_declaration_list struct_declaration
	  {
		$$ = g_list_concat ($1, $2);
	  }
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';'
	  {
		GList *l;
		$$ = NULL;
		for (l = $2; l != NULL; l = l->next) {
			CSymbol *sym = l->data;
			if ($1->storage_class_specifier & STORAGE_CLASS_TYPEDEF) {
				sym->type = CSYMBOL_TYPE_TYPEDEF;
			}
			csymbol_merge_type (sym, $1);
			$$ = g_list_append ($$, sym);
		}
	  }
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	  {
		$$ = $1;
		$$->base_type = $2;
	  }
	| type_specifier
	| type_qualifier specifier_qualifier_list
	  {
		$$ = $2;
		$$->type_qualifier |= $1;
	  }
	| type_qualifier
	  {
		$$ = ctype_new (CTYPE_INVALID);
		$$->type_qualifier |= $1;
	  }
	;

struct_declarator_list
	: struct_declarator
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| struct_declarator_list ',' struct_declarator
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

struct_declarator
	: /* empty, support for anonymous structs and unions */
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| declarator
	| ':' constant_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
	  }
	| declarator ':' constant_expression
	;

enum_specifier
	: ENUM identifier_or_typedef_name '{' enumerator_list '}'
	  {
		$$ = cenum_new ($2);
		$$->child_list = $4;
		last_enum_value = -1;
	  }
	| ENUM '{' enumerator_list '}'
	  {
		$$ = cenum_new (NULL);
		$$->child_list = $3;
		last_enum_value = -1;
	  }
	| ENUM identifier_or_typedef_name '{' enumerator_list ',' '}'
	  {
		$$ = cenum_new ($2);
		$$->child_list = $4;
		last_enum_value = -1;
	  }
	| ENUM '{' enumerator_list ',' '}'
	  {
		$$ = cenum_new (NULL);
		$$->child_list = $3;
		last_enum_value = -1;
	  }
	| ENUM identifier_or_typedef_name
	  {
		$$ = cenum_new ($2);
	  }
	;

enumerator_list
	: enumerator
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| enumerator_list ',' enumerator
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

enumerator
	: identifier
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_OBJECT);
		$$->ident = $1;
		$$->const_int_set = TRUE;
		$$->const_int = ++last_enum_value;
		g_hash_table_insert (const_table, g_strdup ($$->ident), $$);
	  }
	| identifier '=' constant_expression
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_OBJECT);
		$$->ident = $1;
		$$->const_int_set = TRUE;
		$$->const_int = $3->const_int;
		last_enum_value = $$->const_int;
		g_hash_table_insert (const_table, g_strdup ($$->ident), $$);
	  }
	;

type_qualifier
	: CONST
	  {
		$$ = TYPE_QUALIFIER_CONST;
	  }
	| RESTRICT
	  {
		$$ = TYPE_QUALIFIER_RESTRICT;
	  }
	| VOLATILE
	  {
		$$ = TYPE_QUALIFIER_VOLATILE;
	  }
	;

function_specifier
	: INLINE
	  {
		$$ = FUNCTION_INLINE;
	  }
	;

declarator
	: pointer direct_declarator
	  {
		$$ = $2;
		csymbol_merge_type ($$, $1);
	  }
	| direct_declarator
	;

direct_declarator
	: identifier
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
		$$->ident = $1;
	  }
	| '(' declarator ')'
	  {
		$$ = $2;
	  }
	| direct_declarator '[' assignment_expression ']'
	  {
		$$ = $1;
		csymbol_merge_type ($$, carray_new ());
	  }
	| direct_declarator '[' ']'
	  {
		$$ = $1;
		csymbol_merge_type ($$, carray_new ());
	  }
	| direct_declarator '(' parameter_type_list ')'
	  {
		CType *func = cfunction_new ();
		// ignore (void) parameter list
		if ($3 != NULL && ($3->next != NULL || ((CSymbol *) $3->data)->base_type->type != CTYPE_VOID)) {
			func->child_list = $3;
		}
		$$ = $1;
		csymbol_merge_type ($$, func);
	  }
	| direct_declarator '(' identifier_list ')'
	  {
		CType *func = cfunction_new ();
		func->child_list = $3;
		$$ = $1;
		csymbol_merge_type ($$, func);
	  }
	| direct_declarator '(' ')'
	  {
		CType *func = cfunction_new ();
		$$ = $1;
		csymbol_merge_type ($$, func);
	  }
	;

pointer
	: '*' type_qualifier_list
	  {
		$$ = cpointer_new (NULL);
		$$->type_qualifier = $2;
	  }
	| '*'
	  {
		$$ = cpointer_new (NULL);
	  }
	| '*' type_qualifier_list pointer
	  {
		$$ = cpointer_new ($3);
		$$->type_qualifier = $2;
	  }
	| '*' pointer
	  {
		$$ = cpointer_new ($2);
	  }
	;

type_qualifier_list
	: type_qualifier
	| type_qualifier_list type_qualifier
	  {
		$$ = $1 | $2;
	  }
	;

parameter_type_list
	: parameter_list
	| parameter_list ',' ELLIPSIS
	;

parameter_list
	: parameter_declaration
	  {
		$$ = g_list_append (NULL, $1);
	  }
	| parameter_list ',' parameter_declaration
	  {
		$$ = g_list_append ($1, $3);
	  }
	;

parameter_declaration
	: declaration_specifiers declarator
	  {
		$$ = $2;
		csymbol_merge_type ($$, $1);
	  }
	| declaration_specifiers abstract_declarator
	  {
		$$ = $2;
		csymbol_merge_type ($$, $1);
	  }
	| declaration_specifiers
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
		$$->base_type = $1;
	  }
	;

identifier_list
	: identifier
	  {
		CSymbol *sym = csymbol_new (CSYMBOL_TYPE_INVALID);
		sym->ident = $1;
		$$ = g_list_append (NULL, sym);
	  }
	| identifier_list ',' identifier
	  {
		CSymbol *sym = csymbol_new (CSYMBOL_TYPE_INVALID);
		sym->ident = $3;
		$$ = g_list_append ($1, sym);
	  }
	;

type_name
	: specifier_qualifier_list
	| specifier_qualifier_list abstract_declarator
	;

abstract_declarator
	: pointer
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
		csymbol_merge_type ($$, $1);
	  }
	| direct_abstract_declarator
	| pointer direct_abstract_declarator
	  {
		$$ = $2;
		csymbol_merge_type ($$, $1);
	  }
	;

direct_abstract_declarator
	: '(' abstract_declarator ')'
	  {
		$$ = $2;
	  }
	| '[' ']'
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
		csymbol_merge_type ($$, carray_new ());
	  }
	| '[' assignment_expression ']'
	  {
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
		csymbol_merge_type ($$, carray_new ());
	  }
	| direct_abstract_declarator '[' ']'
	  {
		$$ = $1;
		csymbol_merge_type ($$, carray_new ());
	  }
	| direct_abstract_declarator '[' assignment_expression ']'
	  {
		$$ = $1;
		csymbol_merge_type ($$, carray_new ());
	  }
	| '(' ')'
	  {
		CType *func = cfunction_new ();
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
		csymbol_merge_type ($$, func);
	  }
	| '(' parameter_type_list ')'
	  {
		CType *func = cfunction_new ();
		// ignore (void) parameter list
		if ($2 != NULL && ($2->next != NULL || ((CSymbol *) $2->data)->base_type->type != CTYPE_VOID)) {
			func->child_list = $2;
		}
		$$ = csymbol_new (CSYMBOL_TYPE_INVALID);
		csymbol_merge_type ($$, func);
	  }
	| direct_abstract_declarator '(' ')'
	  {
		CType *func = cfunction_new ();
		$$ = $1;
		csymbol_merge_type ($$, func);
	  }
	| direct_abstract_declarator '(' parameter_type_list ')'
	  {
		CType *func = cfunction_new ();
		// ignore (void) parameter list
		if ($3 != NULL && ($3->next != NULL || ((CSymbol *) $3->data)->base_type->type != CTYPE_VOID)) {
			func->child_list = $3;
		}
		$$ = $1;
		csymbol_merge_type ($$, func);
	  }
	;

typedef_name
	: TYPEDEF_NAME
	  {
		$$ = g_strdup (yytext);
	  }
	;

initializer
	: assignment_expression
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	;

initializer_list
	: initializer
	| initializer_list ',' initializer
	;

/* A.2.3 Statements. */

statement
	: labeled_statement
	| compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	;

labeled_statement
	: identifier_or_typedef_name ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	;

compound_statement
	: '{' '}'
	| '{' block_item_list '}'
	;

block_item_list
	: block_item
	| block_item_list block_item
	;

block_item
	: declaration
	| statement
	;

expression_statement
	: ';'
	| expression ';'
	;

selection_statement
	: IF '(' expression ')' statement
	| IF '(' expression ')' statement ELSE statement
	| SWITCH '(' expression ')' statement
	;

iteration_statement
	: WHILE '(' expression ')' statement
	| DO statement WHILE '(' expression ')' ';'
	| FOR '(' ';' ';' ')' statement
	| FOR '(' expression ';' ';' ')' statement
	| FOR '(' ';' expression ';' ')' statement
	| FOR '(' expression ';' expression ';' ')' statement
	| FOR '(' ';' ';' expression ')' statement
	| FOR '(' expression ';' ';' expression ')' statement
	| FOR '(' ';' expression ';' expression ')' statement
	| FOR '(' expression ';' expression ';' expression ')' statement
	;

jump_statement
	: GOTO identifier_or_typedef_name ';'
	| CONTINUE ';'
	| BREAK ';'
	| RETURN ';'
	| RETURN expression ';'
	;

/* A.2.4 External definitions. */

translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
	: function_definition
	| declaration
	| macro
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement
	| declaration_specifiers declarator compound_statement
	;

declaration_list
	: declaration
	| declaration_list declaration
	;

/* Macros */

function_macro
	: FUNCTION_MACRO
	  {
		$$ = g_strdup (yytext + strlen ("#define "));
	  }
	;

object_macro
	: OBJECT_MACRO
	  {
		$$ = g_strdup (yytext + strlen ("#define "));
	  }
	;

function_macro_define
	: function_macro '(' identifier_list ')'
	;

object_macro_define
	: object_macro constant_expression
	  {
		if ($2->const_int_set || $2->const_string != NULL) {
			$2->ident = $1;
			g_igenerator_add_symbol (igenerator, $2);
		}
	  }
	;

macro
	: function_macro_define
	| object_macro_define
	| error
	;

%%

static void
yyerror (GIGenerator *igenerator, const char *s)
{
  /* ignore errors while doing a macro scan as not all object macros
   * have valid expressions */
  if (!igenerator->macro_scan)
    {
      fprintf(stderr, "%s:%d: %s\n",
	      igenerator->current_filename, lineno, s);
    }
}

gboolean
g_igenerator_parse_file (GIGenerator *igenerator, FILE *file)
{
  g_return_val_if_fail (file != NULL, FALSE);
  
  const_table = g_hash_table_new_full (g_str_hash, g_str_equal,
				       g_free, NULL);
  
  lineno = 1;
  yyin = file;
  yyparse (igenerator);
  
  g_hash_table_destroy (const_table);
  const_table = NULL;
  
  yyin = NULL;

  return TRUE;
}


