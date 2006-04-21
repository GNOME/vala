/* scanner.l
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
#include "parser.h"
%}
 
%option yylineno
%option bison-bridge
%option bison-locations
%option noyywrap

%%

"{"		{ return OPEN_BRACE; }
"}"		{ return CLOSE_BRACE; }

"namespace"	{ return NAMESPACE; }
"class"		{ return CLASS; }

[[:alnum:]_]+	{ yylval->str = strdup (yytext); return IDENTIFIER; }

[ \t\n]+ /* eat up whitespace */
