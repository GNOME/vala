/* scanner.l
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
#include "context.h"
#include "parser.h"

#define uploc	{ yylloc->first_column = yylloc->last_column + 1; yylloc->last_column += strlen (yytext); }
%}
 
%option yylineno
%option bison-bridge
%option bison-locations
%option noyywrap

%%

"//".*		{ uploc; }

"{"		{ uploc; return OPEN_BRACE; }
"}"		{ uploc; return CLOSE_BRACE; }
"("		{ uploc; return OPEN_PARENS; }
")"		{ uploc; return CLOSE_PARENS; }
"["		{ uploc; return OPEN_BRACKET; }
"]"		{ uploc; return CLOSE_BRACKET; }
"."		{ uploc; return DOT; }
":"		{ uploc; return COLON; }
","		{ uploc; return COMMA; }
";"		{ uploc; return SEMICOLON; }

"++"		{ uploc; return OP_INC; }
"--"		{ uploc; return OP_DEC; }
"=="		{ uploc; return OP_EQ; }
"!="		{ uploc; return OP_NE; }
"<="		{ uploc; return OP_LE; }
">="		{ uploc; return OP_GE; }
"<"		{ uploc; return OP_LT; }
">"		{ uploc; return OP_GT; }

"="		{ uploc; return ASSIGN; }
"+"		{ uploc; return PLUS; }
"-"		{ uploc; return MINUS; }
"*"		{ uploc; return STAR; }
"/"		{ uploc; return DIV; }

"class"		{ uploc; return CLASS; }
"else"		{ uploc; return ELSE; }
"for"		{ uploc; return FOR; }
"if"		{ uploc; return IF; }
"namespace"	{ uploc; return NAMESPACE; }
"override"	{ uploc; return OVERRIDE; }
"public"	{ uploc; return PUBLIC; }
"private"	{ uploc; return PRIVATE; }
"static"	{ uploc; return STATIC; }
"get"		{ uploc; return GET; }
"set"		{ uploc; return SET; }
"return"	{ uploc; return RETURN; }
"virtual"	{ uploc; return VIRTUAL; }

[[:digit:]]+	{ uploc; yylval->str = strdup (yytext); return LITERAL_INTEGER; }

\"([^\"\\]|\\[\'\"\?\\abfnrtv])*\"	{ uploc; yylval->str = strdup (yytext); return LITERAL_STRING; }

[[:alnum:]_]+	{ uploc; yylval->str = strdup (yytext); return IDENTIFIER; }

[ \t]+		{ uploc; /* eat up whitespace */ }
[\n]+		{ yylloc->first_line = yylloc->last_line = yylineno; yylloc->first_column = 1; yylloc->last_column = 0; }
