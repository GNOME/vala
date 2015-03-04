/* -*- Mode: C -*-
 * GObject introspection: C lexer
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
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>

#include "scanner.h"
#include "scannerparser.h"
#include "grealpath.h"

int lineno;
char linebuf[2000];

#undef YY_BUF_SIZE
#define YY_BUF_SIZE 1048576

extern int yylex (GIGenerator *igenerator);
#define YY_DECL int yylex (GIGenerator *igenerator)
static int yywrap (void);
static void parse_comment (GIGenerator *igenerator);
static void process_linemarks (GIGenerator *igenerator, gboolean has_line);
static int check_identifier (GIGenerator *igenerator, const char *);
static int parse_ignored_macro (void);
static void print_error (GIGenerator *igenerator);
%}

%option nounput

intsuffix				([uU][lL]?[lL]?)|([lL][lL]?[uU]?)
fracconst				([0-9]*\.[0-9]+)|([0-9]+\.)
exppart					[eE][-+]?[0-9]+
floatsuffix				[fFlL]
chartext				([^\\\'])|(\\.)
stringtext				([^\\\"])|(\\.)

%%

\n.*					{ strncpy(linebuf, yytext+1, sizeof(linebuf)); /* save the next line */
						linebuf[sizeof(linebuf)-1]='\0';
						/* printf("%4d:%s\n",lineno,linebuf); */
						yyless(1);      /* give back all but the \n to rescan */
						++lineno;
					}
"\\\n"					{ ++lineno; }

[\t\f\v\r ]+				{ /* Ignore whitespace. */ }

"/*"					{ parse_comment(igenerator); }
"//".*					{ /* Ignore C++ style comments. */ }

"#define "[a-zA-Z_][a-zA-Z_0-9]*"("	{ yyless (yyleng - 1); return FUNCTION_MACRO; }
"#define "[a-zA-Z_][a-zA-Z_0-9]*	{ return OBJECT_MACRO; }

"# "[0-9]+" ".*"\n"			{ process_linemarks(igenerator, FALSE); }
"#line "[0-9]+" ".*"\n"			{ process_linemarks(igenerator, TRUE); }
"#"			                { }
"{"					{ return '{'; }
"<%"					{ return '{'; }
"}"					{ return '}'; }
"%>"					{ return '}'; }
"["					{ return '['; }
"<:"					{ return '['; }
"]"					{ return ']'; }
":>"					{ return ']'; }
"("					{ return '('; }
")"					{ return ')'; }
";"					{ return ';'; }
":"					{ return ':'; }
"..."					{ return ELLIPSIS; }
"?"					{ return '?'; }
"."					{ return '.'; }
"+"					{ return '+'; }
"-"					{ return '-'; }
"*"					{ return '*'; }
"/"					{ return '/'; }
"%"					{ return '%'; }
"^"					{ return '^'; }
"&"					{ return '&'; }
"|"					{ return '|'; }
"~"					{ return '~'; }
"!"					{ return '!'; }
"="					{ return '='; }
"<"					{ return '<'; }
">"					{ return '>'; }
"+="					{ return ADDEQ; }
"-="					{ return SUBEQ; }
"*="					{ return MULEQ; }
"/="					{ return DIVEQ; }
"%="					{ return MODEQ; }
"^="					{ return XOREQ; }
"&="					{ return ANDEQ; }
"|="					{ return OREQ; }
"<<"					{ return SL; }
">>"					{ return SR; }
"<<="					{ return SLEQ; }
">>="					{ return SREQ; }
"=="					{ return EQ; }
"!="					{ return NOTEQ; }
"<="					{ return LTEQ; }
">="					{ return GTEQ; }
"&&"					{ return ANDAND; }
"||"					{ return OROR; }
"++"					{ return PLUSPLUS; }
"--"					{ return MINUSMINUS; }
","					{ return ','; }
"->"					{ return ARROW; }

"__asm"[\t\f\v\r ]+"volatile"  	        { if (!parse_ignored_macro()) REJECT; }
"__asm__"[\t\f\v\r ]+"volatile"	        { if (!parse_ignored_macro()) REJECT; }
"__asm__"[\t\f\v\r ]+"__volatile__"	{ if (!parse_ignored_macro()) REJECT; }
"__asm" 	        	        { if (!parse_ignored_macro()) REJECT; }
"__asm__" 	        	        { if (!parse_ignored_macro()) REJECT; }
"__attribute__" 		        { if (!parse_ignored_macro()) REJECT; }
"__attribute" 		                { if (!parse_ignored_macro()) REJECT; }
"__const"                               { return CONST; }
"__extension__"                         { /* Ignore */ }
"__inline__"                            { return INLINE; }
"__inline"				{ return INLINE; }
"__nonnull" 			        { if (!parse_ignored_macro()) REJECT; }
"_Noreturn" 			        { /* Ignore */ }
"__signed__"				{ return SIGNED; }
"__restrict"				{ return RESTRICT; }
"__restrict__"				{ return RESTRICT; }
"__typeof"				{ if (!parse_ignored_macro()) REJECT; }
"__volatile"	        	        { return VOLATILE; }
"__volatile__"	        	        { return VOLATILE; }
"_Bool"					{ return BOOL; }
"typedef char __static_assert_t".*"\n"	{ /* Ignore */ }
"__cdecl" 	        	        { /* Ignore */ }
"__declspec(deprecated(".*"))"		{ /* Ignore */ }
"__declspec"[\t ]*"("[a-z\t ]+")"	{ /* Ignore */ }
"__stdcall" 			        { /* ignore */ }
"__w64"					{ /* ignore */ }
"__int64"				{ return INT; }


[a-zA-Z_][a-zA-Z_0-9]*			{ if (igenerator->macro_scan) return check_identifier(igenerator, yytext); else REJECT; }

"asm"           		        { if (!parse_ignored_macro()) REJECT; }

"auto"					{ return AUTO; }
"bool"					{ return BOOL; }
"break"					{ return BREAK; }
"case"					{ return CASE; }
"char"					{ return CHAR; }
"const"					{ return CONST; }
"continue"				{ return CONTINUE; }
"default"				{ return DEFAULT; }
"do"					{ return DO; }
"double"				{ return DOUBLE; }
"else"					{ return ELSE; }
"enum"					{ return ENUM; }
"extern"				{ return EXTERN; }
"float"					{ return FLOAT; }
"for"					{ return FOR; }
"goto"					{ return GOTO; }
"if"					{ return IF; }
"inline"				{ return INLINE; }
"int"					{ return INT; }
"__uint128_t"				{ return INT; }
"__int128_t"				{ return INT; }
"__uint128"				{ return INT; }
"__int128"				{ return INT; }
"long"					{ return LONG; }
"register"				{ return REGISTER; }
"restrict"				{ return RESTRICT; }
"return"				{ return RETURN; }
"short"					{ return SHORT; }
"signed"				{ return SIGNED; }
"sizeof"				{ return SIZEOF; }
"static"				{ return STATIC; }
"struct"				{ return STRUCT; }
"switch"				{ return SWITCH; }
"typedef"				{ return TYPEDEF; }
"union"					{ return UNION; }
"unsigned"				{ return UNSIGNED; }
"void"					{ return VOID; }
"volatile"				{ return VOLATILE; }
"while"					{ return WHILE; }

[a-zA-Z_][a-zA-Z_0-9]*			{ return check_identifier(igenerator, yytext); }

"0"[xX][0-9a-fA-F]+{intsuffix}?		{ return INTEGER; }
"0"[0-7]+{intsuffix}?			{ return INTEGER; }
[0-9]+{intsuffix}?			{ return INTEGER; }

{fracconst}{exppart}?{floatsuffix}?	{ return FLOATING; }
[0-9]+{exppart}{floatsuffix}?		{ return FLOATING; }

"'"{chartext}*"'"			{ return CHARACTER; }
"L'"{chartext}*"'"			{ return CHARACTER; }

"\""{stringtext}*"\""			{ return STRING; }
"L\""{stringtext}*"\""			{ return STRING; }

.					{ print_error(igenerator); }

%%

static int
yywrap (void)
{
  return 1;
}

static void parse_gtkdoc (GIGenerator *igenerator, int *c1, int *c2)
{
  gboolean isline = FALSE;
  gchar line[256];
  int i;
  gchar **parts;
  CDirective *directive;
  char *name, *value;

  i = 0;
  do {
      *c1 = *c2;
      if (*c1 == '\n')
	{
	  isline = TRUE;
	  break;
	}
      if (i >= 256)
	break;
      line[i++] = *c1;
      *c2 = input();

  } while (*c2 != EOF && !(*c1 == '*' && *c2 == '/'));
  
  if (!isline)
    return;

  line[i] = '\0';

  parts = g_strsplit (line, ": ", 2);

  if (g_strv_length (parts) == 2)
    {
      name = parts[0];
      value = parts[1];
    }
  else /* parts == 1 */
    {
      name = parts[0];
      value = NULL;
    }
  
  directive = cdirective_new (name, value);
  igenerator->directives = g_slist_prepend (igenerator->directives,
					    directive);

  g_strfreev (parts);
}

static void parse_comment (GIGenerator *igenerator)
{
  int c1, c2;
  
  c1 = input();
  c2 = input();

  while (c2 != EOF && !(c1 == '*' && c2 == '/'))
    {
      if (c1 == '\n')
	++lineno;
      c1 = c2;
      c2 = input();

      if (c1 == ' ' && c2 == '@')
	{
	  c1 = c2;
	  c2 = input();
	  parse_gtkdoc (igenerator, &c1, &c2);
	}
    }
}

static int
check_identifier (GIGenerator *igenerator,
		  const char *s)
{
	/*
	 * This function checks if `s' is a type name or an
	 * identifier.
	 */

	if (g_igenerator_is_typedef (igenerator, s)) {
		return TYPEDEF_NAME;
	} else if (strcmp (s, "__builtin_va_list") == 0) {
		return TYPEDEF_NAME;
	}

	return IDENTIFIER;
}

/*
 * # linenum "filename" flags
 *  See http://gcc.gnu.org/onlinedocs/cpp/Preprocessor-Output.html
 **/

static void
process_linemarks (GIGenerator *igenerator, gboolean has_line)
{
	char escaped_filename[1025];
	char *filename;
	char *real;

	if (has_line)
		sscanf(yytext, "#line %d \"%1024[^\"]\"", &lineno, escaped_filename);
	else
		sscanf(yytext, "# %d \"%1024[^\"]\"", &lineno, escaped_filename);

	filename = g_strcompress (escaped_filename);

        real = g_realpath (filename);
        if (real)
          {
            g_free (filename);
            filename = real;
          }

        if (igenerator->current_filename)
          g_free (igenerator->current_filename);
	igenerator->current_filename = filename;
}

/*
 * This parses a macro which is ignored, such as
 * __attribute__((x)) or __asm__ (x)
 */
static int
parse_ignored_macro (void)
{
	int c;
	int nest;

	while ((c = input ()) != EOF && isspace (c))
		;
	if (c != '(')
		return FALSE;

	nest = 0;
	while ((c = input ()) != EOF && (nest > 0 || c != ')')) {
		if (c == '(')
			nest++;
		else if (c == ')')
			nest--;
		else if (c == '"') {
			while ((c = input ()) != EOF && c != '"') {
				if (c == '\\')
					c = input ();
			}
		} else if (c == '\'') {
			c = input ();
			if (c == '\\')
				c = input ();
			else if (c == '\'')
				return FALSE;
			c = input ();
			if (c != '\'')
				return FALSE;
		} else if (c == '\n')
			lineno++;
	}

	return TRUE;
}

static void
print_error (GIGenerator *igenerator)
{
  if (yytext[0]) {
    fprintf(stderr, "%s:%d: unexpected character `%c'\n", igenerator->current_filename, lineno, yytext[0]);
  }
}
