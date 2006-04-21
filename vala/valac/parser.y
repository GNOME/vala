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
}

%token OPEN_BRACE "{"
%token CLOSE_BRACE "}"

%token NAMESPACE "namespace"
%token CLASS "class"
%token <str> IDENTIFIER "identifier"

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
	: CLASS IDENTIFIER
	  {
		ValaClass *class = g_new0 (ValaClass, 1);
		class->name = $2;
		current_namespace->classes = g_list_append (current_namespace->classes, class);
	  }
	  class_body
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
