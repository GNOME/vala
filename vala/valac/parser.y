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

ValaSourceFile *current_source_file;
ValaNamespace *current_namespace;
%}

%defines
%locations
%error-verbose
%pure_parser
%glr-parser
%union {
	char *str;
	GList *list;
	ValaTypeReference *type_reference;
}

%token OPEN_BRACE "{"
%token CLOSE_BRACE "}"
%token DOT "."
%token COLON ":"
%token COMMA ","

%token NAMESPACE "namespace"
%token CLASS "class"
%token <str> IDENTIFIER "identifier"

%type <list> opt_class_base
%type <list> class_base
%type <list> type_list
%type <type_reference> type_name

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
		ValaClass *class = g_new0 (ValaClass, 1);
		class->name = g_strdup ($2);
		class->base_types = $3;
		class->namespace = current_namespace;
	  	class->lower_case_cname = camel_case_to_lower_case (class->name);
	  	class->upper_case_cname = camel_case_to_upper_case (class->name);
		current_namespace->classes = g_list_append (current_namespace->classes, class);
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
		$$ = type_reference;
	  }
	| IDENTIFIER DOT IDENTIFIER
	  {
		ValaTypeReference *type_reference = g_new0 (ValaTypeReference, 1);
		type_reference->namespace_name = g_strdup ($1);
		type_reference->type_name = g_strdup ($3);
		$$ = type_reference;
	  }
	;

class_body
	: OPEN_BRACE CLOSE_BRACE
	;

%%

extern FILE *yyin;

void yyerror (YYLTYPE *locp, const char *s)
{
	printf ("%d: %s\n", locp->first_line, s);
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
	yyparse ();
	fclose (yyin);
	yyin = NULL;
}
