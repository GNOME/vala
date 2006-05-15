/* context.h
 *
 * Copyright (C) 2006 Jürg Billeter, Raffaele Sandrini
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

#include <glib.h>

typedef enum _ValaSymbolType ValaSymbolType;
typedef enum _ValaModifierFlags ValaModifierFlags;
typedef enum _ValaFormalParameterFlags ValaFormalParameterFlags;
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
typedef struct _ValaEnum ValaEnum;
typedef struct _ValaFlags ValaFlags;
typedef struct _ValaConstant ValaConstant;
typedef struct _ValaMethod ValaMethod;
typedef struct _ValaField ValaField;
typedef struct _ValaProperty ValaProperty;
typedef struct _ValaEnumValue ValaEnumValue;
typedef struct _ValaFlagsValue ValaFlagsValue;
typedef struct _ValaStatement ValaStatement;
typedef struct _ValaVariableDeclaration ValaVariableDeclaration;
typedef struct _ValaVariableDeclarator ValaVariableDeclarator;
typedef struct _ValaExpression ValaExpression;
typedef struct _ValaTypeReference ValaTypeReference;
typedef struct _ValaFormalParameter ValaFormalParameter;
typedef struct _ValaNamedArgument ValaNamedArgument;
typedef struct _ValaAnnotation ValaAnnotation;

enum _ValaSymbolType {
	VALA_SYMBOL_TYPE_ROOT,
	VALA_SYMBOL_TYPE_NAMESPACE,
	VALA_SYMBOL_TYPE_VOID,
	VALA_SYMBOL_TYPE_CLASS,
	VALA_SYMBOL_TYPE_CONSTANT,
	VALA_SYMBOL_TYPE_FIELD,
	VALA_SYMBOL_TYPE_PROPERTY,
	VALA_SYMBOL_TYPE_STRUCT,
	VALA_SYMBOL_TYPE_METHOD,
	VALA_SYMBOL_TYPE_ENUM,
	VALA_SYMBOL_TYPE_ENUM_VALUE,
	VALA_SYMBOL_TYPE_BLOCK,
	VALA_SYMBOL_TYPE_LOCAL_VARIABLE,
};

enum _ValaModifierFlags {
	VALA_MODIFIER_PUBLIC = 1 << 0,
	VALA_MODIFIER_PRIVATE = 1 << 1,
	VALA_MODIFIER_STATIC = 1 << 2,
	VALA_MODIFIER_ABSTRACT = 1 << 3,
	VALA_MODIFIER_VIRTUAL = 1 << 4,
	VALA_MODIFIER_OVERRIDE = 1 << 5,
	VALA_MODIFIER_READONLY = 1 << 6,
};

enum _ValaFormalParameterFlags {
	VALA_FORMAL_PARAMETER_REF = 1 << 0,
	VALA_FORMAL_PARAMETER_OUT = 1 << 1,
};

enum _ValaStatementType {
	VALA_STATEMENT_TYPE_BLOCK,
	VALA_STATEMENT_TYPE_EXPRESSION,
	VALA_STATEMENT_TYPE_IF,
	VALA_STATEMENT_TYPE_WHILE,
	VALA_STATEMENT_TYPE_FOR,
	VALA_STATEMENT_TYPE_FOREACH,
	VALA_STATEMENT_TYPE_RETURN,
	VALA_STATEMENT_TYPE_VARIABLE_DECLARATION,
};

enum _ValaExpressionType {
	VALA_EXPRESSION_TYPE_ASSIGNMENT,
	VALA_EXPRESSION_TYPE_CAST,
	VALA_EXPRESSION_TYPE_ELEMENT_ACCESS,
	VALA_EXPRESSION_TYPE_EXPRESSION,
	VALA_EXPRESSION_TYPE_INVOCATION,
	VALA_EXPRESSION_TYPE_IS,
	VALA_EXPRESSION_TYPE_LITERAL_BOOLEAN,
	VALA_EXPRESSION_TYPE_LITERAL_CHARACTER,
	VALA_EXPRESSION_TYPE_LITERAL_INTEGER,
	VALA_EXPRESSION_TYPE_LITERAL_NULL,
	VALA_EXPRESSION_TYPE_LITERAL_STRING,
	VALA_EXPRESSION_TYPE_MEMBER_ACCESS,
	VALA_EXPRESSION_TYPE_OBJECT_CREATION,
	VALA_EXPRESSION_TYPE_OPERATION,
	VALA_EXPRESSION_TYPE_PARENTHESIZED,
	VALA_EXPRESSION_TYPE_POSTFIX,
	VALA_EXPRESSION_TYPE_RETURN,
	VALA_EXPRESSION_TYPE_SIMPLE_NAME,
	VALA_EXPRESSION_TYPE_STRUCT_OR_ARRAY_INITIALIZER,
	VALA_EXPRESSION_TYPE_THIS_ACCESS,
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
	VALA_OP_TYPE_NEG,
	VALA_OP_TYPE_AND,
	VALA_OP_TYPE_BITWISE_AND,
	VALA_OP_TYPE_OR,
};

struct _ValaContext {
	GList *source_files;
	GList *imported_namespaces;
	ValaSymbol *root;
};

struct _ValaSymbol {
	ValaSymbolType type;
	union {
		ValaClass *class;
		ValaStruct *struct_;
		ValaEnum *enum_;
		ValaConstant *constant;
		ValaMethod *method;
		ValaStatement *stmt;
		ValaTypeReference *typeref;
		ValaField *field;
		ValaProperty *property;
		ValaEnumValue *enum_value;
	};
	GHashTable *symbol_table;
};

struct _ValaSourceFile {
	const char *filename;
	ValaNamespace *root_namespace;
	GList *namespaces;
	GList *using_directives;
	GList *dep_types;
};

struct _ValaLocation {
	ValaSourceFile *source_file;
	int lineno;
	int colno;
};

struct _ValaNamespace {
	char *name;
	ValaSymbol *symbol;
	ValaSourceFile *source_file;
	GList *classes;
	GList *structs;
	GList *enums;
	GList *flags_list;
	GList *methods;
	GList *fields;
	char *cprefix;
	char *lower_case_cname;
	char *upper_case_cname;
	char *include_filename;
	GList *annotations;
	gboolean import;
};

struct _ValaClass {
	char *name;
	ValaLocation *location;
	ValaSymbol *symbol;
	ValaNamespace *namespace;
	ValaClass *base_class;
	GList *base_types;
	GList *methods;
	GList *fields;
	GList *constants;
	GList *properties;
	GList *type_parameters;
	char *cname;
	char *lower_case_cname;
	char *upper_case_cname;
	ValaMethod *init_method;
	ValaMethod *class_init_method;
	GList *annotations;
	gboolean has_private_fields;
};

struct _ValaStruct {
	char *name;
	ValaLocation *location;
	ValaSymbol *symbol;
	ValaNamespace *namespace;
	gboolean reference_type;
	GList *methods;
	GList *fields;
	GList *type_parameters;
	char *cname;
	char *lower_case_cname;
	char *upper_case_cname;
	GList *annotations;
};

struct _ValaEnum {
	char *name;
	ValaLocation *location;
	ValaSymbol *symbol;
	ValaNamespace *namespace;
	GList *values;
	char *cname;
	char *upper_case_cname;
	GList *annotations;
};

struct _ValaFlags {
	char *name;
	ValaLocation *location;
	ValaSymbol *symbol;
	ValaNamespace *namespace;
	GList *values;
	char *cname;
	char *upper_case_cname;
	GList *annotations;
};

struct _ValaMethod {
	char *name;
	ValaLocation *location;
	ValaSymbol *symbol;
	gboolean is_struct_method;
	union {
		ValaClass *class;
		ValaStruct *struct_;
	};
	ValaNamespace *namespace; /* only defined for methods outside a class */
	ValaTypeReference *return_type;
	GList *formal_parameters;
	ValaModifierFlags modifiers;
	char *cname;
	char *cdecl1;
	char *cparameters;
	ValaStatement *body;
	gboolean returns_modified_pointer;
	gboolean instance_last;
	GList *annotations;
	ValaClass *virtual_super_class;
};

struct _ValaField {
	ValaLocation *location;
	ValaSymbol *symbol;
	gboolean is_struct_field;
	union {
		ValaClass *class;
		ValaStruct *struct_;
	};
	ValaNamespace *namespace; /* only defined for methods outside a class */
	ValaModifierFlags modifiers;
	char *cname;
	ValaStatement *declaration_statement;
	GList *annotations;
};

struct _ValaConstant {
	ValaLocation *location;
	ValaSymbol *symbol;
	ValaClass *class;
	ValaModifierFlags modifiers;
	ValaStatement *declaration_statement;
};

struct _ValaProperty {
	char *name;
	ValaLocation *location;
	ValaSymbol *symbol;
	ValaClass *class;
	ValaTypeReference *return_type;
	ValaModifierFlags modifiers;
	ValaStatement *get_statement;
	ValaStatement *set_statement;
};

struct _ValaEnumValue {
	char *name;
	char *value;
	ValaSymbol *symbol;
	char *cname;
};

struct _ValaFlagsValue {
	char *name;
	char *value;
	ValaSymbol *symbol;
	char *cname;
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
			ValaExpression *condition;
			ValaStatement *loop;
		} while_stmt;
		struct {
			GList *initializer;
			ValaExpression *condition;
			GList *iterator;
			ValaStatement *loop;
		} for_stmt;
		struct {
			ValaTypeReference *type;
			char *name;
			ValaExpression *container;
			ValaStatement *loop;
		} foreach_stmt;
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
	ValaSymbol *static_symbol;
	ValaField *field;
	ValaProperty *property;
	gboolean array_type;
	gboolean ref_variable;
	gboolean out_variable;
	union {
		char *str;
		int num;
		GList *list;
		ValaExpression *inner;
		struct {
			ValaExpression *left;
			ValaOpType type;
			ValaExpression *right;
		} op;
		struct {
			ValaExpression *inner;
			ValaTypeReference *type;
		} cast;
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
		struct {
			ValaExpression *array;
			ValaExpression *index;
		} element_access;
		struct {
			ValaExpression *expr;
			ValaTypeReference *type;
		} is;
	};
};

struct _ValaTypeReference {
	char *namespace_name;
	char *type_name;
	ValaLocation *location;
	ValaSymbol *symbol;
	gboolean own;
	gboolean array_type;
	int type_param_index; /* for type references within generic types */
	GList *type_params; /* for type references referring to generic types */
};

struct _ValaFormalParameter {
	char *name;
	ValaTypeReference *type;
	ValaLocation *location;
	ValaFormalParameterFlags modifier;
};

struct _ValaNamedArgument {
	char *name;
	ValaExpression *expression;
	ValaLocation *location;
	ValaSymbol *symbol; /* symbol corresponding to name */
};

struct _ValaAnnotation {
	ValaTypeReference *type;
	GList *argument_list;
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
