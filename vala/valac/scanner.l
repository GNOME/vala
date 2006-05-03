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
"@"		{ uploc; return AT; }

"++"		{ uploc; return OP_INC; }
"--"		{ uploc; return OP_DEC; }
"=="		{ uploc; return OP_EQ; }
"!="		{ uploc; return OP_NE; }
"<="		{ uploc; return OP_LE; }
">="		{ uploc; return OP_GE; }
"<"		{ uploc; return OP_LT; }
">"		{ uploc; return OP_GT; }
"!"		{ uploc; return OP_NEG; }

"="		{ uploc; return ASSIGN; }
"+"		{ uploc; return PLUS; }
"-"		{ uploc; return MINUS; }
"*"		{ uploc; return STAR; }
"/"		{ uploc; return DIV; }

"class"		{ uploc; return CLASS; }
"const"		{ uploc; return CONST; }
"construct"	{ uploc; return CONSTRUCT; }
"else"		{ uploc; return ELSE; }
"enum"		{ uploc; return ENUM; }
"false"		{ uploc; return VALA_FALSE; }
"flags"		{ uploc; return FLAGS; }
"for"		{ uploc; return FOR; }
"foreach"	{ uploc; return FOREACH; }
"get"		{ uploc; return GET; }
"if"		{ uploc; return IF; }
"in"		{ uploc; return IN; }
"namespace"	{ uploc; return NAMESPACE; }
"null"		{ uploc; return VALA_NULL; }
"out"		{ uploc; return OUT; }
"override"	{ uploc; return OVERRIDE; }
"public"	{ uploc; return PUBLIC; }
"private"	{ uploc; return PRIVATE; }
"ref"		{ uploc; return REF; }
"set"		{ uploc; return SET; }
"static"	{ uploc; return STATIC; }
"struct"	{ uploc; return STRUCT; }
"return"	{ uploc; return RETURN; }
"this"		{ uploc; return THIS; }
"true"		{ uploc; return VALA_TRUE; }
"using"		{ uploc; return USING; }
"var"		{ uploc; return VAR; }
"virtual"	{ uploc; return VIRTUAL; }

[[:digit:]]+	{ uploc; yylval->str = strdup (yytext); return LITERAL_INTEGER; }

\'([^\'\\]|\\[\'\"\?\\abfnrtv])*\' { uploc; yylval->str = strdup (yytext); return LITERAL_CHARACTER; }
\"([^\"\\]|\\[\'\"\?\\abfnrtv])*\"	{ uploc; yylval->str = strdup (yytext); return LITERAL_STRING; }

[[:alnum:]_]+	{ uploc; yylval->str = strdup (yytext); return IDENTIFIER; }

[ \t]+		{ uploc; /* eat up whitespace */ }
[\n]+		{ yylloc->first_line = yylloc->last_line = yylineno; yylloc->first_column = 1; yylloc->last_column = 0; }
