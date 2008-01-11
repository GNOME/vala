/* GObject introspection: gen-introspect
 *
 * Copyright (C) 2007  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

#ifndef __GEN_INTROSPECT_H__
#define __GEN_INTROSPECT_H__

#include <glib.h>
#include "gidlmodule.h"

G_BEGIN_DECLS typedef struct _GIGenerator GIGenerator;
typedef struct _CSymbol CSymbol;
typedef struct _CType CType;
typedef struct _CDirective CDirective;

struct _GIGenerator
{
  /* parameters */
  char *namespace;
  char *shared_library;
  char *lower_case_namespace;
  gboolean verbose;

  /* specified files to be parsed */
  GList *filenames;
  /* source reference of current lexer position */
  char *current_filename;
  GList *symbol_list;
  GHashTable *typedef_table;
  GHashTable *struct_or_union_or_enum_table;

  GIdlModule *module;
  GList *get_type_symbols;
  GHashTable *type_map;
  GHashTable *type_by_lower_case_prefix;

  GHashTable *symbols; /* typename -> module.name */

  /* scanner variables */
  gboolean macro_scan;
  GSList *directives; /* list of CDirective for the current symbol */
};

typedef enum
{
  CSYMBOL_TYPE_INVALID,
  CSYMBOL_TYPE_CONST,
  CSYMBOL_TYPE_OBJECT,
  CSYMBOL_TYPE_FUNCTION,
  CSYMBOL_TYPE_STRUCT,
  CSYMBOL_TYPE_UNION,
  CSYMBOL_TYPE_ENUM,
  CSYMBOL_TYPE_TYPEDEF
} CSymbolType;

struct _CSymbol
{
  CSymbolType type;
  int id;
  char *ident;
  CType *base_type;
  gboolean const_int_set;
  int const_int;
  char *const_string;
  GSList *directives; /* list of CDirective */
};

typedef enum
{
  CTYPE_INVALID,
  CTYPE_VOID,
  CTYPE_BASIC_TYPE,
  CTYPE_TYPEDEF,
  CTYPE_STRUCT,
  CTYPE_UNION,
  CTYPE_ENUM,
  CTYPE_POINTER,
  CTYPE_ARRAY,
  CTYPE_FUNCTION
} CTypeType;

typedef enum
{
  STORAGE_CLASS_NONE = 0,
  STORAGE_CLASS_TYPEDEF = 1 << 1,
  STORAGE_CLASS_EXTERN = 1 << 2,
  STORAGE_CLASS_STATIC = 1 << 3,
  STORAGE_CLASS_AUTO = 1 << 4,
  STORAGE_CLASS_REGISTER = 1 << 5
} StorageClassSpecifier;

typedef enum
{
  TYPE_QUALIFIER_NONE = 0,
  TYPE_QUALIFIER_CONST = 1 << 1,
  TYPE_QUALIFIER_RESTRICT = 1 << 2,
  TYPE_QUALIFIER_VOLATILE = 1 << 3
} TypeQualifier;

typedef enum
{
  FUNCTION_NONE = 0,
  FUNCTION_INLINE = 1 << 1
} FunctionSpecifier;

typedef enum
{
  UNARY_ADDRESS_OF,
  UNARY_POINTER_INDIRECTION,
  UNARY_PLUS,
  UNARY_MINUS,
  UNARY_BITWISE_COMPLEMENT,
  UNARY_LOGICAL_NEGATION
} UnaryOperator;

struct _CType
{
  CTypeType type;
  StorageClassSpecifier storage_class_specifier;
  TypeQualifier type_qualifier;
  FunctionSpecifier function_specifier;
  char *name;
  CType *base_type;
  GList *child_list;
};

struct _CDirective {
  char *name;
  char *value;
};

CSymbol *    csymbol_new               (CSymbolType  type);
gboolean     csymbol_get_const_boolean (CSymbol     *symbol);
void         csymbol_free              (CSymbol     *symbol);
CDirective * cdirective_new            (const gchar *name,
					const gchar *value);
void         cdirective_free           (CDirective  *directive);

gboolean g_igenerator_parse_file    (GIGenerator *igenerator,
				     FILE        *file);
void     g_igenerator_set_verbose   (GIGenerator *igenerator,
				     gboolean     verbose);
void     g_igenerator_add_symbol    (GIGenerator *igenerator,
				     CSymbol     *symbol);
gboolean g_igenerator_is_typedef    (GIGenerator *igenerator,
				     const char  *name);
G_END_DECLS
#endif
