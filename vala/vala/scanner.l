/* scanner.l
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
#include "vala.h"
#include "parser.h"

#define YY_DECL int yylex (YYSTYPE *yylval_param, YYLTYPE *yylloc_param, ValaParser *parser)

#define uploc	{ yylloc->first_column = yylloc->last_column + 1; yylloc->last_column += strlen (yytext); }

static gboolean file_comment = FALSE;
%}
 
%option yylineno
%option bison-bridge
%option bison-locations
%option noyywrap
%option nounput

%x IN_COMMENT

space			[ \t\n]*
ident			[[:alnum:]_]+
literal_integer		[[:digit:]]+
literal_real		[[:digit:]]+"."[[:digit:]]*
literal_character	\'([^\'\\]|\\[\'\"\?\\abfnrtv])*\'
literal_string		\"([^\"\\]|\\[\'\"\?\\abfnrtv])*\"
literal			({literal_integer}|{literal_real}|{literal_character}|{literal_string})

%%

"/*"				{ uploc; file_comment = (yylineno == 1); BEGIN (IN_COMMENT); }
<IN_COMMENT>"*/"		{ uploc; BEGIN (INITIAL); yytext[strlen (yytext) - 2] = '\0'; vala_parser_push_comment (parser, yytext, file_comment); }
<IN_COMMENT>[^*\n]+		{ uploc; yymore (); }
<IN_COMMENT>"*"			{ uploc; yymore (); }
<IN_COMMENT>\n			{ yylloc->first_line = yylloc->last_line = yylineno; yylloc->first_column = 1; yylloc->last_column = 0; yymore (); }

"//".*				{ uploc; vala_parser_push_comment (parser, g_strdup (yytext + 2), FALSE); }

"{"		{ uploc; return OPEN_BRACE; }
"}"		{ uploc; return CLOSE_BRACE; }
"("{space}{ident}("."{ident})?("["{space}"]")*{space}")"{space}("("|{ident}|{literal})	{ yyless (1); uploc; return OPEN_CAST_PARENS; }
"("		{ uploc; return OPEN_PARENS; }
")"		{ uploc; return CLOSE_PARENS; }
"["{space}"]"	{ uploc; return ARRAY_QUALIFIER; }
"["		{ uploc; return OPEN_BRACKET; }
"]"		{ uploc; return CLOSE_BRACKET; }
"..."		{ uploc; return ELLIPSIS; }
"."		{ uploc; return DOT; }
":"		{ uploc; return COLON; }
","		{ uploc; return COMMA; }
";"		{ uploc; return SEMICOLON; }
"#"		{ uploc; return HASH; }
"?"		{ uploc; return INTERR; }

"|="		{ uploc; return ASSIGN_BITWISE_OR; }
"&="		{ uploc; return ASSIGN_BITWISE_AND; }
"^="		{ uploc; return ASSIGN_BITWISE_XOR; }
"+="		{ uploc; return ASSIGN_ADD; }
"-="		{ uploc; return ASSIGN_SUB; }
"*="		{ uploc; return ASSIGN_MUL; }
"/="		{ uploc; return ASSIGN_DIV; }
"%="		{ uploc; return ASSIGN_PERCENT; }
"<<="		{ uploc; return ASSIGN_SHIFT_LEFT; }
">>="		{ uploc; return ASSIGN_SHIFT_RIGHT; }

"++"		{ uploc; return OP_INC; }
"--"		{ uploc; return OP_DEC; }
"=="		{ uploc; return OP_EQ; }
"!="		{ uploc; return OP_NE; }
"<<"		{ uploc; return OP_SHIFT_LEFT; }
">>"		{ uploc; return OP_SHIFT_RIGHT; }
"<="		{ uploc; return OP_LE; }
">="		{ uploc; return OP_GE; }
"=>"		{ uploc; return LAMBDA; }
"<"(("ref"|"weak")" "+)?({ident}".")?{ident}"#"?("[]""#"?)?(","" "*({ident}".")?{ident}"#"?("[]""#"?)?)*">"	{ yyless (1); uploc; return GENERIC_LT; }
"<"		{ uploc; return OP_LT; }
">"		{ uploc; return OP_GT; }
"!"		{ uploc; return OP_NEG; }
"||"		{ uploc; return OP_OR; }
"|"		{ uploc; return BITWISE_OR; }
"&&"		{ uploc; return OP_AND; }
"&"		{ uploc; return BITWISE_AND; }
"^"		{ uploc; return CARRET; }
"~"		{ uploc; return TILDE; }

"="		{ uploc; return ASSIGN; }
"+"		{ uploc; return PLUS; }
"-"		{ uploc; return MINUS; }
"*"		{ uploc; return STAR; }
"/"		{ uploc; return DIV; }
"%"		{ uploc; return PERCENT; }

"@"[[:alnum:]_]+	{ uploc; yylval->str = g_strdup (yytext + 1); return IDENTIFIER; }

"abstract"	{ uploc; return ABSTRACT; }
"break"		{ uploc; return BREAK; }
"callback"	{ uploc; return CALLBACK; }
"case"		{ uploc; return CASE; }
"class"		{ uploc; return CLASS; }
"const"		{ uploc; return CONST; }
"construct"	{ uploc; return CONSTRUCT; }
"continue"	{ uploc; return CONTINUE; }
"default"	{ uploc; return DEFAULT; }
"do"		{ uploc; return DO; }
"else"		{ uploc; return ELSE; }
"enum"		{ uploc; return ENUM; }
"false"		{ uploc; return VALA_FALSE; }
"flags"		{ uploc; return FLAGS; }
"for"		{ uploc; return FOR; }
"foreach"	{ uploc; return FOREACH; }
"get"		{ uploc; return GET; }
"if"		{ uploc; return IF; }
"in"		{ uploc; return IN; }
"interface"	{ uploc; return INTERFACE; }
"is"		{ uploc; return IS; }
"namespace"	{ uploc; return NAMESPACE; }
"new"		{ uploc; return NEW; }
"null"		{ uploc; return VALA_NULL; }
"out"		{ uploc; return OUT; }
"override"	{ uploc; return OVERRIDE; }
"public"	{ uploc; return PUBLIC; }
"private"	{ uploc; return PRIVATE; }
"ref"		{ uploc; return REF; }
"set"		{ uploc; return SET; }
"signal"	{ uploc; return SIGNAL; }
"static"	{ uploc; return STATIC; }
"struct"	{ uploc; return STRUCT; }
"switch"	{ uploc; return SWITCH; }
"return"	{ uploc; return RETURN; }
"true"		{ uploc; return VALA_TRUE; }
"typeof"	{ uploc; return TYPEOF; }
"using"		{ uploc; return USING; }
"var"		{ uploc; return VAR; }
"virtual"	{ uploc; return VIRTUAL; }
"weak"		{ uploc; return WEAK; }
"while"		{ uploc; return WHILE; }

{literal_real}		{ uploc; yylval->str = g_strdup (yytext); return REAL_LITERAL; }
{literal_integer}	{ uploc; yylval->str = g_strdup (yytext); return INTEGER_LITERAL; }

{literal_character}	{ uploc; yylval->str = g_strdup (yytext); return CHARACTER_LITERAL; }
{literal_string}	{ uploc; yylval->str = g_strdup (yytext); return STRING_LITERAL; }

{ident}			{ uploc; yylval->str = g_strdup (yytext); return IDENTIFIER; }

[ \t]+		{ uploc; /* eat up whitespace */ }
[\n]+		{ yylloc->first_line = yylloc->last_line = yylineno; yylloc->first_column = 1; yylloc->last_column = 0; }

.	{ uploc; fprintf (stderr, "%d: syntax error: unexpected character ´%s´\n", yylloc->first_line, yytext); }
