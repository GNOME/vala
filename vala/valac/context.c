/* context.c
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
	fprintf (stderr, "%s:%d:%d: ", location->source_file->filename, location->lineno, location->colno);
	vfprintf (stderr, format, args);
	fprintf (stderr, "\n");
	va_end (args);
	exit (1);
}

static void
vala_context_add_symbols_from_method (ValaContext *context, ValaSymbol *class_symbol, ValaMethod *method)
{
	ValaSymbol *method_symbol;
	
	method_symbol = g_hash_table_lookup (class_symbol->symbol_table, method->name);
	if (method_symbol != NULL) {
		err (method->location, "error: class member ´%s.%s.%s´ already defined", class_symbol->class->namespace->name, class_symbol->class->name, method->name);
	}

	method_symbol = vala_symbol_new (VALA_SYMBOL_TYPE_METHOD);
	method_symbol->method = method;
	g_hash_table_insert (class_symbol->symbol_table, method->name, method_symbol);
	
	if (method->body != NULL) {
		method->body->method = method_symbol;
	}
}

static void
vala_context_add_symbols_from_class (ValaContext *context, ValaClass *class)
{
	ValaSymbol *ns_symbol, *class_symbol;
	ns_symbol = class->namespace->symbol;
	GList *ml;

	class_symbol = g_hash_table_lookup (ns_symbol->symbol_table, class->name);
	if (class_symbol != NULL) {
		err (class->location, "error: class ´%s.%s´ already defined", class->namespace->name, class->name);
	}

	class_symbol = vala_symbol_new (VALA_SYMBOL_TYPE_CLASS);
	class_symbol->class = class;
	g_hash_table_insert (ns_symbol->symbol_table, class->name, class_symbol);
	
	class->symbol = class_symbol;
	
	for (ml = class->methods; ml != NULL; ml = ml->next) {
		vala_context_add_symbols_from_method (context, class_symbol, ml->data);
	}
}

static void
vala_context_add_symbols_from_struct (ValaContext *context, ValaStruct *struct_)
{
	ValaSymbol *ns_symbol, *struct_symbol;
	ns_symbol = struct_->namespace->symbol;
	GList *ml;

	struct_symbol = g_hash_table_lookup (ns_symbol->symbol_table, struct_->name);
	if (struct_symbol != NULL) {
		err (struct_->location, "error: struct ´%s.%s´ already defined", struct_->namespace->name, struct_->name);
	}

	struct_symbol = vala_symbol_new (VALA_SYMBOL_TYPE_STRUCT);
	struct_symbol->struct_ = struct_;
	g_hash_table_insert (ns_symbol->symbol_table, struct_->name, struct_symbol);
	
	struct_->symbol = struct_symbol;
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
}

void
vala_context_add_fundamental_symbols (ValaContext *context)
{
	ValaSymbol *symbol;
	ValaNamespace *namespace;
	ValaClass *class;
	ValaStruct *struct_;
	
	context->root = vala_symbol_new (VALA_SYMBOL_TYPE_ROOT);

	namespace = g_new0 (ValaNamespace, 1);
	namespace->name = g_strdup ("");
	namespace->lower_case_cname = g_strdup ("");
	namespace->upper_case_cname = g_strdup ("");
	
	/* void */
	symbol = vala_symbol_new (VALA_SYMBOL_TYPE_VOID);
	g_hash_table_insert (context->root->symbol_table, "void", symbol);

	/* int */
	struct_ = g_new0 (ValaStruct, 1);
	struct_->name = g_strdup ("int");
	struct_->namespace = namespace;
	struct_->cname = g_strdup ("int");
	namespace->structs = g_list_append (namespace->structs, struct_);

	/* string */
	struct_ = g_new0 (ValaStruct, 1);
	struct_->name = g_strdup ("string");
	struct_->reference_type = TRUE;
	struct_->namespace = namespace;
	struct_->cname = g_strdup ("char");
	namespace->structs = g_list_append (namespace->structs, struct_);

	vala_context_add_symbols_from_namespace (context, namespace);

	/* namespace G */	
	namespace = g_new0 (ValaNamespace, 1);
	namespace->name = g_strdup ("G");
	namespace->lower_case_cname = g_strdup ("g_");
	namespace->upper_case_cname = g_strdup ("G_");
	
	class = g_new0 (ValaClass, 1);
	class->name = g_strdup ("Object");
	class->namespace = namespace;
	class->lower_case_cname = g_strdup ("object");
	class->upper_case_cname = g_strdup ("OBJECT");
	namespace->classes = g_list_append (namespace->classes, class);

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
vala_context_resolve_type_reference (ValaContext *context, ValaNamespace *namespace, ValaTypeReference *type_reference)
{
	ValaSymbol *type_symbol, *ns_symbol;
	
	if (type_reference->namespace_name == NULL) {
		/* no namespace specified */

		/* look in current namespace */
		type_symbol = g_hash_table_lookup (namespace->symbol->symbol_table, type_reference->type_name);
		if (type_symbol != NULL) {
			type_reference->namespace_name = namespace->name;
		} else {
			/* look in root namespace */
			type_symbol = g_hash_table_lookup (context->root->symbol_table, type_reference->type_name);
		}
		
		/* FIXME: look in namespaces specified by using directives */

		if (type_symbol != NULL) {
			type_reference->namespace_name = "";
		} else {
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
	} else {
		err (type_reference->location, "error: specified symbol ´%s´ is not a type", type_reference->type_name);
	}
}

static void
vala_context_resolve_types_in_expression (ValaContext *context, ValaNamespace *namespace, ValaExpression *expr)
{
	switch (expr->type) {
	case VALA_EXPRESSION_TYPE_OBJECT_CREATION:
		vala_context_resolve_type_reference (context, namespace, expr->object_creation.type);
		break;
	}
}

static void
vala_context_resolve_types_in_statement (ValaContext *context, ValaNamespace *namespace, ValaStatement *stmt)
{
	switch (stmt->type) {
	case VALA_STATEMENT_TYPE_VARIABLE_DECLARATION:
		vala_context_resolve_type_reference (context, namespace, stmt->variable_declaration->type);
		if (stmt->variable_declaration->declarator->initializer != NULL) {
			vala_context_resolve_types_in_expression (context, namespace, stmt->variable_declaration->declarator->initializer);
		}
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
vala_context_resolve_types_in_method (ValaContext *context, ValaMethod *method)
{
	GList *l;
	
	vala_context_resolve_type_reference (context, method->class->namespace, method->return_type);
	
	for (l = method->formal_parameters; l != NULL; l = l->next) {
		ValaFormalParameter *formal_parameter = l->data;
		
		vala_context_resolve_type_reference (context, method->class->namespace, formal_parameter->type);
		if (formal_parameter->type->symbol->type == VALA_SYMBOL_TYPE_VOID) {
			err (formal_parameter->location, "error: method parameters cannot be of type `void`");
		}
	}
	
	if (method->body != NULL) {
		vala_context_resolve_types_in_block (context, method->class->namespace, method->body);
	}
}

static void
vala_context_resolve_types_in_class (ValaContext *context, ValaClass *class)
{
	GList *l;
	
	for (l = class->base_types; l != NULL; l = l->next) {
		ValaTypeReference *type_reference = l->data;
		
		vala_context_resolve_type_reference (context, class->namespace, type_reference);
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
		class->base_class = symbol->class;
	}
	
	for (l = class->methods; l != NULL; l = l->next) {
		ValaMethod *method = l->data;
		vala_context_resolve_types_in_method (context, method);
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
}

void
vala_context_resolve_types (ValaContext *context)
{
	GList *fl;
	
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
