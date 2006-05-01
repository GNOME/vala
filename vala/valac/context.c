/* context.c
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

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <glib.h>

#include "context.h"

ValaContext *
vala_context_new ()
{
	return g_new0 (ValaContext, 1);
}

void
vala_context_free (ValaContext *context)
{
	g_free (context);
}

void	
vala_context_parse (ValaContext *context)
{
	GList *l;
	for (l = context->source_files; l != NULL; l = l->next) {
		vala_parser_parse (l->data);
	}
}

ValaSymbol *
vala_symbol_new (ValaSymbolType type)
{
	ValaSymbol *symbol;
	symbol = g_new0 (ValaSymbol, 1);
	symbol->type = type;
	symbol->symbol_table = g_hash_table_new (g_str_hash, g_str_equal);
	return symbol;
}

void
err (ValaLocation *location, const char *format, ...)
{
	va_list args;
	va_start (args, format);
	if (location != NULL) {
		fprintf (stderr, "%s:%d:%d: ", location->source_file->filename, location->lineno, location->colno);
	}
	vfprintf (stderr, format, args);
	fprintf (stderr, "\n");
	va_end (args);
	exit (1);
}

static void
vala_context_add_symbols_from_constant (ValaContext *context, ValaSymbol *class_symbol, ValaConstant *constant)
{
	ValaSymbol *constant_symbol;
	char *name = constant->declaration_statement->variable_declaration->declarator->name;
	
	constant_symbol = g_hash_table_lookup (class_symbol->symbol_table, name);
	if (constant_symbol != NULL) {
		err (constant->declaration_statement->variable_declaration->declarator->location, "error: class member ´%s.%s.%s´ already defined", class_symbol->class->namespace->name, class_symbol->class->name, name);
	}
	
	constant_symbol = vala_symbol_new (VALA_SYMBOL_TYPE_CONSTANT);
	constant_symbol->constant = constant;
	constant->symbol = constant_symbol;
	g_hash_table_insert (class_symbol->symbol_table, name, constant_symbol);
}

static void
vala_context_add_symbols_from_method (ValaContext *context, ValaSymbol *class_symbol, ValaMethod *method)
{
	method->symbol = g_hash_table_lookup (class_symbol->symbol_table, method->name);
	if (method->symbol != NULL) {
		err (method->location, "error: class member ´%s.%s.%s´ already defined", class_symbol->class->namespace->name, class_symbol->class->name, method->name);
	}

	method->symbol = vala_symbol_new (VALA_SYMBOL_TYPE_METHOD);
	method->symbol->method = method;
	g_hash_table_insert (class_symbol->symbol_table, method->name, method->symbol);
	
	if (method->body != NULL) {
		method->body->method = method->symbol;
	}
}

static void
vala_context_add_symbols_from_field (ValaContext *context, ValaSymbol *class_symbol, ValaField *field)
{
	ValaSymbol *field_symbol;
	char *name = field->declaration_statement->variable_declaration->declarator->name;
	
	field_symbol = g_hash_table_lookup (class_symbol->symbol_table, name);
	if (field_symbol != NULL) {
		err (field->declaration_statement->variable_declaration->declarator->location, "error: class member ´%s.%s.%s´ already defined", class_symbol->class->namespace->name, class_symbol->class->name, name);
	}
	
	field_symbol = vala_symbol_new (VALA_SYMBOL_TYPE_FIELD);
	field_symbol->field = field;
	field->symbol = field_symbol;
	g_hash_table_insert (class_symbol->symbol_table, name, field_symbol);
}

static void
vala_context_add_symbols_from_property (ValaContext *context, ValaSymbol *class_symbol, ValaProperty *property)
{
	ValaSymbol *property_symbol;
	
	property_symbol = g_hash_table_lookup (class_symbol->symbol_table, property->name);
	if (property_symbol != NULL) {
		err (property->location, "error: class member ´%s.%s.%s´ already defined", class_symbol->class->namespace->name, class_symbol->class->name, property->name);
	}
	
	property_symbol = vala_symbol_new (VALA_SYMBOL_TYPE_PROPERTY);
	property_symbol->property = property;
	property->symbol = property_symbol;
	g_hash_table_insert (class_symbol->symbol_table, property->name, property_symbol);
}

static void
vala_context_add_symbols_from_class (ValaContext *context, ValaClass *class)
{
	ValaSymbol *ns_symbol, *class_symbol;
	ns_symbol = class->namespace->symbol;
	GList *l;

	class_symbol = g_hash_table_lookup (ns_symbol->symbol_table, class->name);
	if (class_symbol != NULL) {
		err (class->location, "error: class ´%s.%s´ already defined", class->namespace->name, class->name);
	}

	class_symbol = vala_symbol_new (VALA_SYMBOL_TYPE_CLASS);
	class_symbol->class = class;
	g_hash_table_insert (ns_symbol->symbol_table, class->name, class_symbol);
	
	class->symbol = class_symbol;
	
	for (l = class->constants; l != NULL; l = l->next) {
		vala_context_add_symbols_from_constant (context, class_symbol, l->data);
	}
	
	for (l = class->methods; l != NULL; l = l->next) {
		vala_context_add_symbols_from_method (context, class_symbol, l->data);
	}
	
	for (l = class->fields; l != NULL; l = l->next) {
		vala_context_add_symbols_from_field (context, class_symbol, l->data);
	}
	
	for (l = class->properties; l != NULL; l = l->next) {
		vala_context_add_symbols_from_property (context, class_symbol, l->data);
	}
}

static void
vala_context_add_symbols_from_struct (ValaContext *context, ValaStruct *struct_)
{
	ValaSymbol *ns_symbol, *struct_symbol;
	ns_symbol = struct_->namespace->symbol;
	GList *ml, *l;

	struct_symbol = g_hash_table_lookup (ns_symbol->symbol_table, struct_->name);
	if (struct_symbol != NULL) {
		err (struct_->location, "error: struct ´%s.%s´ already defined", struct_->namespace->name, struct_->name);
	}

	struct_symbol = vala_symbol_new (VALA_SYMBOL_TYPE_STRUCT);
	struct_symbol->struct_ = struct_;
	g_hash_table_insert (ns_symbol->symbol_table, struct_->name, struct_symbol);
	
	struct_->symbol = struct_symbol;
	
	for (l = struct_->methods; l != NULL; l = l->next) {
		vala_context_add_symbols_from_method (context, struct_symbol, l->data);
	}
	
	for (l = struct_->fields; l != NULL; l = l->next) {
		vala_context_add_symbols_from_field (context, struct_symbol, l->data);
	}
}

static void
vala_context_add_symbols_from_enum (ValaContext *context, ValaEnum *enum_)
{
	ValaSymbol *ns_symbol, *enum_symbol;
	ns_symbol = enum_->namespace->symbol;
	GList *l;

	enum_symbol = g_hash_table_lookup (ns_symbol->symbol_table, enum_->name);
	if (enum_symbol != NULL) {
		err (enum_->location, "error: enum ´%s.%s´ already defined", enum_->namespace->name, enum_->name);
	}

	enum_symbol = vala_symbol_new (VALA_SYMBOL_TYPE_ENUM);
	enum_symbol->enum_ = enum_;
	g_hash_table_insert (ns_symbol->symbol_table, enum_->name, enum_symbol);
	
	enum_->symbol = enum_symbol;
	
	for (l = enum_->values; l != NULL; l = l->next) {
		ValaSymbol *value_symbol;
		ValaEnumValue *value = l->data;
		
		value_symbol = g_hash_table_lookup (enum_symbol->symbol_table, value->name);
		if (value_symbol != NULL) {
			err (enum_->location, "error: enum member ´%s.%s.%s´ already defined", enum_->namespace->name, enum_->name, value->name);
		}
		
		value_symbol = vala_symbol_new (VALA_SYMBOL_TYPE_ENUM_VALUE);
		value_symbol->enum_value = value;
		value->symbol = value_symbol;
		g_hash_table_insert (enum_symbol->symbol_table, value->name, value_symbol);
	}
}

static void
vala_context_add_symbols_from_namespace (ValaContext *context, ValaNamespace *namespace)
{
	ValaSymbol *ns_symbol, *class_symbol;
	GList *cl;
	
	if (strlen (namespace->name) == 0) {
		ns_symbol = context->root;
	} else {
		ns_symbol = g_hash_table_lookup (context->root->symbol_table, namespace->name);
		if (ns_symbol == NULL) {
			ns_symbol = vala_symbol_new (VALA_SYMBOL_TYPE_NAMESPACE);
			g_hash_table_insert (context->root->symbol_table, namespace->name, ns_symbol);
		}
	}
	
	namespace->symbol = ns_symbol;
	
	for (cl = namespace->classes; cl != NULL; cl = cl->next) {
		vala_context_add_symbols_from_class (context, cl->data);
	}
	
	for (cl = namespace->structs; cl != NULL; cl = cl->next) {
		vala_context_add_symbols_from_struct (context, cl->data);
	}
	
	for (cl = namespace->enums; cl != NULL; cl = cl->next) {
		vala_context_add_symbols_from_enum (context, cl->data);
	}
}

void
vala_context_add_fundamental_symbols (ValaContext *context)
{
	ValaSymbol *symbol;
	ValaNamespace *namespace;
	ValaClass *class;
	ValaStruct *struct_;
	ValaEnum *enum_;
	ValaMethod *method;
	ValaEnumValue *enum_value;
	
	context->root = vala_symbol_new (VALA_SYMBOL_TYPE_ROOT);

	namespace = g_new0 (ValaNamespace, 1);
	namespace->name = g_strdup ("");
	namespace->lower_case_cname = g_strdup ("");
	namespace->upper_case_cname = g_strdup ("");
	
	/* void */
	symbol = vala_symbol_new (VALA_SYMBOL_TYPE_VOID);
	g_hash_table_insert (context->root->symbol_table, "void", symbol);

	/* bool */
	struct_ = g_new0 (ValaStruct, 1);
	struct_->name = "bool";
	struct_->namespace = namespace;
	struct_->cname = "gboolean";
	namespace->structs = g_list_append (namespace->structs, struct_);

	/* int */
	struct_ = g_new0 (ValaStruct, 1);
	struct_->name = g_strdup ("int");
	struct_->namespace = namespace;
	struct_->cname = g_strdup ("int");
	namespace->structs = g_list_append (namespace->structs, struct_);

	/* uint */
	struct_ = g_new0 (ValaStruct, 1);
	struct_->name = "uint";
	struct_->namespace = namespace;
	struct_->cname = "unsigned int";
	namespace->structs = g_list_append (namespace->structs, struct_);

	/* pointer */
	struct_ = g_new0 (ValaStruct, 1);
	struct_->name = "pointer";
	struct_->namespace = namespace;
	struct_->cname = "gpointer";
	namespace->structs = g_list_append (namespace->structs, struct_);

	/* string */
	struct_ = g_new0 (ValaStruct, 1);
	struct_->name = g_strdup ("string");
	struct_->reference_type = TRUE;
	struct_->namespace = namespace;
	struct_->cname = g_strdup ("char");
	namespace->structs = g_list_append (namespace->structs, struct_);

	vala_context_add_symbols_from_namespace (context, namespace);

	/* namespace GLib */	
	namespace = g_new0 (ValaNamespace, 1);
	namespace->name = "GLib";
	namespace->lower_case_cname = "g_";
	namespace->upper_case_cname = "G_";
	
	class = g_new0 (ValaClass, 1);
	class->name = "Object";
	class->namespace = namespace;
	class->cname = "GObject";
	class->lower_case_cname = "object";
	class->upper_case_cname = "OBJECT";
	namespace->classes = g_list_append (namespace->classes, class);


	context->imported_namespaces = g_list_append (context->imported_namespaces, namespace);

	vala_context_add_symbols_from_namespace (context, namespace);
	
	/* Add alias object = G.Object */
	symbol = g_hash_table_lookup (namespace->symbol->symbol_table, "Object");
	g_hash_table_insert (context->root->symbol_table, "object", symbol);
}

void
vala_context_add_symbols_from_source_files (ValaContext *context)
{
	GList *fl;
	
	for (fl = context->source_files; fl != NULL; fl = fl->next) {
		ValaSourceFile *source_file = fl->data;
		GList *nsl;
		
		vala_context_add_symbols_from_namespace (context, source_file->root_namespace);
		for (nsl = source_file->namespaces; nsl != NULL; nsl = nsl->next) {
			vala_context_add_symbols_from_namespace (context, nsl->data);
		}
	}
}

static void
vala_context_resolve_type_reference (ValaContext *context, ValaNamespace *namespace, GList *type_parameter_list, ValaTypeReference *type_reference)
{
	ValaSymbol *type_symbol = NULL, *ns_symbol;
	GList *l;
	
	type_reference->type_param_index = -1;

	if (type_reference->type_name == NULL) {
		/* var type, resolve on initialization */
		return;
	} else if (type_reference->namespace_name == NULL) {
		/* no namespace specified */
		
		/* check for generic type parameter */
		int i;
		for (i = 0, l = type_parameter_list; l != NULL; i++, l = l->next) {
			if (strcmp (l->data, type_reference->type_name) == 0) {
				type_reference->type_param_index = i;
				type_symbol = g_hash_table_lookup (context->root->symbol_table, "pointer");
				break;
			}
		}

		if (type_symbol == NULL) {
			/* look in current namespace */
			type_symbol = g_hash_table_lookup (namespace->symbol->symbol_table, type_reference->type_name);
			if (type_symbol != NULL) {
				type_reference->namespace_name = namespace->name;
			}
		}
		
		if (type_symbol == NULL) {
			/* look in root namespace */
			type_symbol = g_hash_table_lookup (context->root->symbol_table, type_reference->type_name);
			if (type_symbol != NULL) {
				type_reference->namespace_name = "";
			}
		}
		
		if (type_symbol == NULL) {
			/* look in namespaces specified by using directives */
			for (l = namespace->source_file->using_directives; l != NULL; l = l->next) {
				char *ns = l->data;
				ns_symbol = g_hash_table_lookup (context->root->symbol_table, ns);
				if (ns_symbol == NULL) {
					err (type_reference->location, "error: specified namespace ´%s´ not found", ns);
				}
				type_symbol = g_hash_table_lookup (ns_symbol->symbol_table, type_reference->type_name);
				if (type_symbol != NULL) {
					type_reference->namespace_name = ns;
					break;
				}
			}
		}

		if (type_symbol == NULL) {
			/* specified namespace not found */
			err (type_reference->location, "error: specified type ´%s´ not found", type_reference->type_name);
		}
	} else {
		/* namespace has been explicitly specified */
		ns_symbol = g_hash_table_lookup (context->root->symbol_table, type_reference->namespace_name);
		if (ns_symbol == NULL) {
			/* specified namespace not found */
			err (type_reference->location, "error: specified namespace '%s' not found", type_reference->namespace_name);
		}

		type_symbol = g_hash_table_lookup (ns_symbol->symbol_table, type_reference->type_name);
		if (type_symbol == NULL) {
			/* specified namespace not found */
			err (type_reference->location, "error: specified type ´%s´ not found in namespace ´%s´", type_reference->type_name, type_reference->namespace_name);
		}
	}
	
	if (type_symbol->type == VALA_SYMBOL_TYPE_VOID ||
	    type_symbol->type == VALA_SYMBOL_TYPE_CLASS ||
	    type_symbol->type == VALA_SYMBOL_TYPE_STRUCT) {
		type_reference->symbol = type_symbol;
		if (type_symbol->type != VALA_SYMBOL_TYPE_VOID) {
			namespace->source_file->dep_types = g_list_prepend (namespace->source_file->dep_types, type_symbol);
		}
	} else {
		err (type_reference->location, "error: specified symbol ´%s´ is not a type", type_reference->type_name);
	}
}

static void vala_context_resolve_types_in_block (ValaContext *context, ValaNamespace *namespace, ValaStatement *stmt);

static void
vala_context_resolve_types_in_expression (ValaContext *context, ValaNamespace *namespace, ValaExpression *expr)
{
	switch (expr->type) {
	case VALA_EXPRESSION_TYPE_OBJECT_CREATION:
		vala_context_resolve_type_reference (context, namespace, NULL, expr->object_creation.type);
		break;
	}
}

static void
vala_context_resolve_types_in_statement (ValaContext *context, ValaNamespace *namespace, ValaStatement *stmt)
{
	switch (stmt->type) {
	case VALA_STATEMENT_TYPE_VARIABLE_DECLARATION:
		vala_context_resolve_type_reference (context, namespace, NULL, stmt->variable_declaration->type);
		if (stmt->variable_declaration->declarator->initializer != NULL) {
			vala_context_resolve_types_in_expression (context, namespace, stmt->variable_declaration->declarator->initializer);
		}
		break;
	case VALA_STATEMENT_TYPE_BLOCK:
		vala_context_resolve_types_in_block (context, namespace, stmt);
		break;
	}
}

static void
vala_context_resolve_types_in_block (ValaContext *context, ValaNamespace *namespace, ValaStatement *stmt)
{
	GList *l;
	
	for (l = stmt->block.statements; l != NULL; l = l ->next) {
		vala_context_resolve_types_in_statement (context, namespace, l->data);
	}
}

static void
vala_context_resolve_types_in_constant (ValaContext *context, ValaConstant *constant)
{
	vala_context_resolve_types_in_statement (context, constant->class->namespace, constant->declaration_statement);
}

static void
vala_context_resolve_types_in_method (ValaContext *context, ValaMethod *method)
{
	GList *l;
	ValaNamespace *namespace;
	GList *type_parameters;

	if (!method->is_struct_method) {
		namespace = method->class->namespace;
		type_parameters = method->class->type_parameters;
	} else {
		namespace = method->struct_->namespace;
		type_parameters = method->struct_->type_parameters;
	}

	vala_context_resolve_type_reference (context, namespace, type_parameters, method->return_type);
	
	for (l = method->formal_parameters; l != NULL; l = l->next) {
		ValaFormalParameter *formal_parameter = l->data;
		
		vala_context_resolve_type_reference (context, namespace, type_parameters, formal_parameter->type);
		if (formal_parameter->type->symbol->type == VALA_SYMBOL_TYPE_VOID) {
			err (formal_parameter->location, "error: method parameters cannot be of type `void`");
		}
	}
	
	if (method->body != NULL) {
		vala_context_resolve_types_in_block (context, method->class->namespace, method->body);
	}
}

static void
vala_context_resolve_types_in_field (ValaContext *context, ValaField *field)
{
	vala_context_resolve_types_in_statement (context, field->class->namespace, field->declaration_statement);
}

static void
vala_context_resolve_types_in_property (ValaContext *context, ValaProperty *property)
{
	vala_context_resolve_type_reference (context, property->class->namespace, property->class->type_parameters, property->return_type);
	vala_context_resolve_types_in_statement (context, property->class->namespace, property->get_statement);
	vala_context_resolve_types_in_statement (context, property->class->namespace, property->set_statement);
}

static void
vala_context_resolve_types_in_class (ValaContext *context, ValaClass *class)
{
	GList *l;
	
	for (l = class->base_types; l != NULL; l = l->next) {
		ValaTypeReference *type_reference = l->data;
		
		vala_context_resolve_type_reference (context, class->namespace, NULL, type_reference);
		if (type_reference->symbol->type == VALA_SYMBOL_TYPE_CLASS) {
			if (class->base_class != NULL) {
				err (type_reference->location, "error: more than one base class specified in class ´%s.%s´", class->namespace->name, class->name);
			}
			class->base_class = type_reference->symbol->class;
			if (class->base_class == class) {
				err (type_reference->location, "error: ´%s.%s´ cannot be subtype of ´%s.%s´", class->namespace->name, class->name, class->namespace->name, class->name);
			}
			/* FIXME: check whether base_class is not a subtype of class */
		} else {
			err (type_reference->location, "error: ´%s.%s´ cannot be subtype of ´%s.%s´", class->namespace->name, class->name, type_reference->namespace_name, type_reference->type_name);
		}
	}
	
	if (class->base_class == NULL) {
		ValaSymbol *symbol = g_hash_table_lookup (context->root->symbol_table, "object");
		/* GObject must not have itself as base class */
		if (class != symbol->class) {
			class->base_class = symbol->class;
		}
	}
	
	for (l = class->constants; l != NULL; l = l->next) {
		ValaConstant *constant = l->data;
		vala_context_resolve_types_in_constant (context, constant);
	}
	
	for (l = class->methods; l != NULL; l = l->next) {
		ValaMethod *method = l->data;
		vala_context_resolve_types_in_method (context, method);
	}
	
	for (l = class->fields; l != NULL; l = l->next) {
		ValaField *field = l->data;
		vala_context_resolve_types_in_field (context, field);
	}
	
	for (l = class->properties; l != NULL; l = l->next) {
		ValaField *property = l->data;
		vala_context_resolve_types_in_field (context, property);
	}
		
}

static void
vala_context_resolve_types_in_struct (ValaContext *context, ValaStruct *struct_)
{
	GList *l;
	
	for (l = struct_->methods; l != NULL; l = l->next) {
		ValaMethod *method = l->data;
		vala_context_resolve_types_in_method (context, method);
	}
	
	for (l = struct_->fields; l != NULL; l = l->next) {
		ValaField *field = l->data;
		vala_context_resolve_types_in_field (context, field);
	}
		
}

static void
vala_context_resolve_types_in_namespace (ValaContext *context, ValaNamespace *namespace)
{
	GList *cl;
	
	for (cl = namespace->classes; cl != NULL; cl = cl->next) {
		ValaClass *class = cl->data;
		
		vala_context_resolve_types_in_class (context, class);
	}
	
	for (cl = namespace->structs; cl != NULL; cl = cl->next) {
		ValaStruct *struct_ = cl->data;
		
		vala_context_resolve_types_in_struct (context, struct_);
	}
}

void
vala_context_resolve_types (ValaContext *context)
{
	GList *fl;
	GList *l;

	for (l = context->imported_namespaces; l != NULL; l = l->next) {
		vala_context_resolve_types_in_namespace (context, l->data);
	}	

	for (fl = context->source_files; fl != NULL; fl = fl->next) {
		ValaSourceFile *source_file = fl->data;
		GList *nsl;
		
		vala_context_resolve_types_in_namespace (context, source_file->root_namespace);
		for (nsl = source_file->namespaces; nsl != NULL; nsl = nsl->next) {
			vala_context_resolve_types_in_namespace (context, nsl->data);
		}
	}
}

ValaSourceFile *
vala_source_file_new (const char *filename)
{
	ValaSourceFile *file = g_new0 (ValaSourceFile, 1);
	
	file->filename = filename;
	file->root_namespace = g_new0 (ValaNamespace, 1);
	file->root_namespace->name = g_strdup ("");
	file->root_namespace->lower_case_cname = g_strdup ("");
	file->root_namespace->upper_case_cname = g_strdup ("");
	
	return file;
}
