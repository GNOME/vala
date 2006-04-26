/* context.h
 *
 * Copyright (C) 2006 Jürg Billeter <j@bitron.ch>
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

#include <glib.h>

typedef enum _ValaSymbolType ValaSymbolType;
typedef enum _ValaMethodFlags ValaMethodFlags;
typedef enum _ValaStatementType ValaStatementType;
typedef enum _ValaExpressionType ValaExpressionType;
typedef enum _ValaOpType ValaOpType;

typedef struct _ValaContext ValaContext;
typedef struct _ValaSymbol ValaSymbol;
typedef struct _ValaSourceFile ValaSourceFile;
typedef struct _ValaLocation ValaLocation;
typedef struct _ValaNamespace ValaNamespace;
typedef struct _ValaClass ValaClass;
typedef struct _ValaStruct ValaStruct;
typedef struct _ValaMethod ValaMethod;
typedef struct _ValaStatement ValaStatement;
typedef struct _ValaVariableDeclaration ValaVariableDeclaration;
typedef struct _ValaVariableDeclarator ValaVariableDeclarator;
typedef struct _ValaExpression ValaExpression;
typedef struct _ValaTypeReference ValaTypeReference;
typedef struct _ValaFormalParameter ValaFormalParameter;
typedef struct _ValaNamedArgument ValaNamedArgument;

enum _ValaSymbolType {
	VALA_SYMBOL_TYPE_ROOT,
	VALA_SYMBOL_TYPE_NAMESPACE,
	VALA_SYMBOL_TYPE_VOID,
	VALA_SYMBOL_TYPE_CLASS,
	VALA_SYMBOL_TYPE_STRUCT,
	VALA_SYMBOL_TYPE_METHOD,
	VALA_SYMBOL_TYPE_BLOCK,
	VALA_SYMBOL_TYPE_LOCAL_VARIABLE,
};

enum _ValaMethodFlags {
	VALA_METHOD_PUBLIC = 0x01,
	VALA_METHOD_STATIC = 0x02,
};

enum _ValaStatementType {
	VALA_STATEMENT_TYPE_BLOCK,
	VALA_STATEMENT_TYPE_EXPRESSION,
	VALA_STATEMENT_TYPE_IF,
	VALA_STATEMENT_TYPE_FOR,
	VALA_STATEMENT_TYPE_RETURN,
	VALA_STATEMENT_TYPE_VARIABLE_DECLARATION,
};

enum _ValaExpressionType {
	VALA_EXPRESSION_TYPE_ASSIGNMENT,
	VALA_EXPRESSION_TYPE_EXPRESSION,
	VALA_EXPRESSION_TYPE_INVOCATION,
	VALA_EXPRESSION_TYPE_LITERAL_INTEGER,
	VALA_EXPRESSION_TYPE_LITERAL_STRING,
	VALA_EXPRESSION_TYPE_MEMBER_ACCESS,
	VALA_EXPRESSION_TYPE_OBJECT_CREATION,
	VALA_EXPRESSION_TYPE_OPERATION,
	VALA_EXPRESSION_TYPE_PARENTHESIZED,
	VALA_EXPRESSION_TYPE_POSTFIX,
	VALA_EXPRESSION_TYPE_RETURN,
	VALA_EXPRESSION_TYPE_SIMPLE_NAME,
};

enum _ValaOpType {
	VALA_OP_TYPE_PLUS,
	VALA_OP_TYPE_MINUS,
	VALA_OP_TYPE_MUL,
	VALA_OP_TYPE_DIV,
	VALA_OP_TYPE_EQ,
	VALA_OP_TYPE_NE,
	VALA_OP_TYPE_LT,
	VALA_OP_TYPE_GT,
	VALA_OP_TYPE_LE,
	VALA_OP_TYPE_GE,
};

struct _ValaContext {
	GList *source_files;
	ValaSymbol *root;
};

struct _ValaSymbol {
	ValaSymbolType type;
	union {
		ValaClass *class;
		ValaStruct *struct_;
		ValaMethod *method;
		ValaStatement *stmt;
		ValaTypeReference *typeref;
	};
	GHashTable *symbol_table;
};

struct _ValaSourceFile {
	const char *filename;
	ValaNamespace *root_namespace;
	GList *namespaces;
};

struct _ValaLocation {
	ValaSourceFile *source_file;
	int lineno;
	int colno;
};

struct _ValaNamespace {
	char *name;
	ValaSymbol *symbol;
	GList *classes;
	GList *structs;
	char *lower_case_cname;
	char *upper_case_cname;
};

struct _ValaClass {
	char *name;
	ValaLocation *location;
	ValaSymbol *symbol;
	ValaNamespace *namespace;
	ValaClass *base_class;
	GList *base_types;
	GList *methods;
	char *cname;
	char *lower_case_cname;
	char *upper_case_cname;
	gboolean has_init;
	gboolean has_class_init;
};

struct _ValaStruct {
	char *name;
	ValaLocation *location;
	ValaSymbol *symbol;
	ValaNamespace *namespace;
	gboolean reference_type;
	char *cname;
};

struct _ValaMethod {
	char *name;
	ValaLocation *location;
	ValaSymbol *symbol;
	ValaClass *class;
	ValaTypeReference *return_type;
	GList *formal_parameters;
	ValaMethodFlags modifiers;
	char *cname;
	char *cdecl1;
	char *cdecl2;
	ValaStatement *body;
};

struct _ValaStatement {
	ValaStatementType type;
	ValaLocation *location;
	union {
		ValaSymbol *method;
	};
	union {
		struct {
			GList *statements;
		} block;
		ValaExpression *expr;
		ValaVariableDeclaration *variable_declaration;
		struct {
			ValaExpression *condition;
			ValaStatement *true_stmt;
			ValaStatement *false_stmt;
		} if_stmt;
		struct {
			GList *initializer;
			ValaExpression *condition;
			GList *iterator;
			ValaStatement *loop;
		} for_stmt;
	};
};

struct _ValaVariableDeclaration {
	ValaTypeReference *type;
	ValaVariableDeclarator *declarator;
};

struct _ValaVariableDeclarator {
	char *name;
	ValaLocation *location;
	ValaExpression *initializer;
};

struct _ValaExpression {
	ValaExpressionType type;
	ValaLocation *location;
	ValaSymbol *static_type_symbol;
	union {
		char *str;
		ValaExpression *inner;
		struct {
			ValaExpression *left;
			ValaOpType type;
			ValaExpression *right;
		} op;
		struct {
			ValaExpression *left;
			char *right;
		} member_access;
		struct {
			ValaExpression *call;
			GList *argument_list;
			ValaExpression *instance;
		} invocation;
		struct {
			ValaExpression *left;
			ValaExpression *right;
		} assignment;
		struct {
			ValaTypeReference *type;
			GList *named_argument_list;
		} object_creation;
		struct {
			ValaExpression *inner;
			const char *cop;
		} postfix;
	};
};

struct _ValaTypeReference {
	char *namespace_name;
	char *type_name;
	ValaLocation *location;
	ValaSymbol *symbol;
	gboolean array_type;
};

struct _ValaFormalParameter {
	char *name;
	ValaTypeReference *type;
	ValaLocation *location;
};

struct _ValaNamedArgument {
	char *name;
	ValaExpression *expression;
	ValaLocation *location;
	ValaSymbol *symbol; /* symbol corresponding to name */
};

ValaContext *vala_context_new ();
void vala_context_free (ValaContext *context);
void vala_context_parse (ValaContext *context);
void vala_context_add_fundamental_symbols (ValaContext *context);
void vala_context_add_symbols_from_source_files (ValaContext *context);
void vala_context_resolve_types (ValaContext *context);

ValaSourceFile *vala_source_file_new (const char *filename);

void vala_parser_parse (ValaSourceFile *source_file);

ValaSymbol *vala_symbol_new (ValaSymbolType type);

void err (ValaLocation *location, const char *format, ...);
