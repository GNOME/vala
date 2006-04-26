/* generator.c
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

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <glib.h>

#include "context.h"
#include "generator.h"

ValaCodeGenerator *
vala_code_generator_new (ValaContext *context)
{
	ValaCodeGenerator *generator = g_new0 (ValaCodeGenerator, 1);

	generator->context = context;
	
	return generator;
}

static char *
filename_to_define (const char *filename)
{
	char *define = g_path_get_basename (filename);
	char *p;
	for (p = define; *p != '\0'; p++) {
		if (g_ascii_isalnum (*p)) {
			*p = toupper (*p);
		} else {
			*p = '_';
		}
	}
	
	return define;
}

static char *
get_cname_for_type_reference (ValaTypeReference *type, ValaLocation *location)
{
	switch (type->symbol->type) {
	case VALA_SYMBOL_TYPE_CLASS:
		return g_strdup_printf ("%s *%s", type->symbol->class->cname, type->array_type ? "*" : "");
	case VALA_SYMBOL_TYPE_STRUCT:
		return g_strdup_printf ("%s %s%s", type->symbol->struct_->cname, (type->symbol->struct_->reference_type ? "*" : ""), type->array_type ? "*" : "");
	case VALA_SYMBOL_TYPE_VOID:
		return g_strdup ("void");
	default:
		err (location, "internal error: unhandled symbol type %d", type->symbol->type);
		return NULL;
	}
}

static void
vala_code_generator_process_methods1 (ValaCodeGenerator *generator, ValaClass *class)
{
	GList *l;

	char *camel_case;
	char *ns_lower;
	char *ns_upper;

	ValaNamespace *namespace = class->namespace;

	ns_lower = namespace->lower_case_cname;
	ns_upper = namespace->upper_case_cname;
	
	char *lower_case = class->lower_case_cname;
	char *upper_case = class->upper_case_cname;

	for (l = class->methods; l != NULL; l = l->next) {
		ValaMethod *method = l->data;
		
		char *method_return_type_cname = get_cname_for_type_reference (method->return_type, method->location);
		method->cname = g_strdup_printf ("%s%s_%s", ns_lower, lower_case, method->name);

		char *parameters;
		GList *parameter_list = NULL;
		if ((method->modifiers & VALA_METHOD_STATIC) == 0) {
			parameter_list = g_list_append (parameter_list, g_strdup_printf ("%s *self", class->cname));
		}
		
		GList *pl;
		for (pl = method->formal_parameters; pl != NULL; pl = pl->next) {
			ValaFormalParameter *param = pl->data;
			char *param_string = g_strdup_printf ("%s%s", get_cname_for_type_reference (param->type, param->location), param->name);
			parameter_list = g_list_append (parameter_list, param_string);
		}
		
		if (parameter_list == NULL) {
			method->cparameters = g_strdup ("");
		} else {
			method->cparameters = parameter_list->data;
			GList *sl;
			for (sl = parameter_list->next; sl != NULL; sl = sl->next) {
				method->cparameters = g_strdup_printf ("%s, %s", method->cparameters, sl->data);
				g_free (sl->data);
			}
			g_list_free (parameter_list);
		}
		
		if (method->modifiers & VALA_METHOD_PUBLIC) {
			method->cdecl1 = g_strdup (method_return_type_cname);
		} else {
			method->cdecl1 = g_strdup_printf ("static %s", method_return_type_cname);
			fprintf (generator->c_file, "%s %s (%s);\n", method->cdecl1, method->cname, method->cparameters);
		}

		if (strcmp (method->name, "init") == 0) {
			if (method->modifiers & VALA_METHOD_STATIC) {
				err (method->location, "error: instance initializer must not be static");
			}
			if (method->formal_parameters != NULL) {
				err (method->location, "error: instance initializer must not have any arguments");
			}
			class->init_method = method;
		} else if (strcmp (method->name, "class_init") == 0) {
			if ((method->modifiers & VALA_METHOD_STATIC) == 0) {
				err (method->location, "error: class initializer must be static");
			}
			if (method->formal_parameters != NULL) {
				err (method->location, "error: class initializer must not have any arguments");
			}
			class->class_init_method = method;
		}
	}
	fprintf (generator->c_file, "\n");
}

static void vala_code_generator_process_expression (ValaCodeGenerator *generator, ValaExpression *expr);

static void
vala_code_generator_process_operation_expression (ValaCodeGenerator *generator, ValaExpression *expr)
{
	char *cop = "";
	vala_code_generator_process_expression (generator, expr->op.left);
	switch (expr->op.type) {
	case VALA_OP_TYPE_PLUS:
		cop = "+";
		break;
	case VALA_OP_TYPE_MINUS:
		cop = "-";
		break;
	case VALA_OP_TYPE_MUL:
		cop = "*";
		break;
	case VALA_OP_TYPE_DIV:
		cop = "/";
		break;
	case VALA_OP_TYPE_EQ:
		cop = "==";
		break;
	case VALA_OP_TYPE_NE:
		cop = "!=";
		break;
	case VALA_OP_TYPE_LT:
		cop = "<";
		break;
	case VALA_OP_TYPE_GT:
		cop = ">";
		break;
	case VALA_OP_TYPE_LE:
		cop = "<=";
		break;
	case VALA_OP_TYPE_GE:
		cop = ">=";
		break;
	}
	fprintf (generator->c_file, " %s ", cop);
	vala_code_generator_process_expression (generator, expr->op.right);
}

static void
vala_code_generator_process_assignment (ValaCodeGenerator *generator, ValaExpression *expr)
{
	vala_code_generator_process_expression (generator, expr->assignment.left);
	fprintf (generator->c_file, " = ");
	vala_code_generator_process_expression (generator, expr->assignment.right);
}

static void
vala_code_generator_process_invocation (ValaCodeGenerator *generator, ValaExpression *expr)
{
	GList *l;
	ValaMethod *method = NULL;
	gboolean first = TRUE;
	
	vala_code_generator_process_expression (generator, expr->invocation.call);
	method = expr->invocation.call->static_type_symbol->method;
	switch (expr->invocation.call->type) {
	case VALA_EXPRESSION_TYPE_MEMBER_ACCESS:
		expr->invocation.instance = expr->invocation.call->member_access.left;
		break;
	}
	fprintf (generator->c_file, " (");
	if ((method->modifiers & VALA_METHOD_STATIC) == 0) {
		if (expr->invocation.instance != NULL) {
			vala_code_generator_process_expression (generator, expr->invocation.instance);
		} else {
			fprintf (generator->c_file, "self");
		}
		first = FALSE;
	}
	for (l = expr->invocation.argument_list; l != NULL; l = l->next) {
		if (!first) {
			fprintf (generator->c_file, ", ");
		} else {
			first = FALSE;
		}
		vala_code_generator_process_expression (generator, l->data);
	}
	fprintf (generator->c_file, ")");
}

static void
vala_code_generator_process_literal (ValaCodeGenerator *generator, ValaExpression *expr)
{
	fprintf (generator->c_file, "%s", expr->str);
}

static ValaSymbol *
get_inherited_member (ValaSymbol *type, const char *name, ValaLocation *location, gboolean break_on_failure)
{
	ValaSymbol *sym;
	sym = g_hash_table_lookup (type->symbol_table, name);
	if (sym != NULL) {
		return sym;
	}
	
	if (type->class->base_class == NULL) {
		if (break_on_failure) {
			err (location, "error: type member ´%s´ not found", name);
		}
		
		return NULL;
	}
	
	return get_inherited_member (type->class->base_class->symbol, name, location, break_on_failure);
}

static void
vala_code_generator_find_static_type_of_expression (ValaCodeGenerator *generator, ValaExpression *expr)
{
	ValaSymbol *sym = NULL, *sym2 = NULL;
	
	if (expr->static_type_symbol != NULL)
		return;
		
	switch (expr->type) {
	case VALA_EXPRESSION_TYPE_ASSIGNMENT:
		break;
	case VALA_EXPRESSION_TYPE_INVOCATION:
		vala_code_generator_find_static_type_of_expression (generator, expr->invocation.call);
		expr->static_type_symbol = expr->invocation.call->static_type_symbol->method->return_type->symbol;
		break;
	case VALA_EXPRESSION_TYPE_MEMBER_ACCESS:
		vala_code_generator_find_static_type_of_expression (generator, expr->member_access.left);
		sym = expr->member_access.left->static_type_symbol;
		if (sym != NULL && sym->type == VALA_SYMBOL_TYPE_CLASS) {
			expr->static_type_symbol = get_inherited_member (sym, expr->member_access.right, expr->member_access.left->location, TRUE);
		} else if (sym != NULL && sym->type == VALA_SYMBOL_TYPE_LOCAL_VARIABLE) {
		} else {
			err (expr->member_access.left->location, "error: specified expression type %d can't be used for member access", sym->type);
		}
		break;
	case VALA_EXPRESSION_TYPE_OBJECT_CREATION:
		expr->static_type_symbol = expr->object_creation.type->symbol;
		break;
	case VALA_EXPRESSION_TYPE_OPERATION:
		break;
	case VALA_EXPRESSION_TYPE_PARENTHESIZED:
		vala_code_generator_find_static_type_of_expression (generator, expr->inner);
		expr->static_type_symbol = expr->inner->static_type_symbol;
		break;
	case VALA_EXPRESSION_TYPE_LITERAL_INTEGER:
	case VALA_EXPRESSION_TYPE_LITERAL_STRING:
		break;
	case VALA_EXPRESSION_TYPE_SIMPLE_NAME:
		if (strcmp (expr->str, "this") == 0) {
			expr->static_type_symbol = generator->sym->stmt->method->method->class->symbol;
		}
	
		if (expr->static_type_symbol == NULL) {
			/* local variable */
			sym = g_hash_table_lookup (generator->sym->symbol_table, expr->str);
			if (sym != NULL) {
				expr->static_type_symbol = sym->typeref->symbol;
			}
		}
		
		if (expr->static_type_symbol == NULL) {
			/* member of this */
			expr->static_type_symbol = get_inherited_member (generator->sym->stmt->method->method->class->symbol, expr->str, expr->location, FALSE);
		}

		if (expr->static_type_symbol == NULL) {
			/* member of this */
			expr->static_type_symbol = g_hash_table_lookup (generator->context->root->symbol_table, expr->str);
		}

		if (expr->static_type_symbol == NULL) {
			err (expr->location, "error: symbol ´%s´ not found", expr->str);
		}
		break;
	}
}

static void
vala_code_generator_process_member_access (ValaCodeGenerator *generator, ValaExpression *expr)
{
	ValaSymbol *sym = expr->static_type_symbol;
	if (sym->type == VALA_SYMBOL_TYPE_METHOD) {
		ValaMethod *method = sym->method;
		fprintf (generator->c_file, "%s", method->cname);
	} else {
		vala_code_generator_process_expression (generator, expr->member_access.left);
		fprintf (generator->c_file, "->%s", expr->member_access.right);
	}
}

static void
vala_code_generator_process_object_creation_expression (ValaCodeGenerator *generator, ValaExpression *expr)
{
	fprintf (generator->c_file, "g_object_new (%sTYPE_%s", expr->object_creation.type->symbol->class->namespace->upper_case_cname, expr->object_creation.type->symbol->class->upper_case_cname);
	/* FIXME: add property arguments */
	fprintf (generator->c_file, ", NULL)");
}

static void
vala_code_generator_process_parenthesized_expression (ValaCodeGenerator *generator, ValaExpression *expr)
{
	fprintf (generator->c_file, "(");
	vala_code_generator_process_expression (generator, expr->inner);
	fprintf (generator->c_file, ")");
}

static void
vala_code_generator_process_postfix_expression (ValaCodeGenerator *generator, ValaExpression *expr)
{
	vala_code_generator_process_expression (generator, expr->postfix.inner);
	fprintf (generator->c_file, "%s", expr->postfix.cop);
}

static void
vala_code_generator_process_simple_name (ValaCodeGenerator *generator, ValaExpression *expr)
{
	switch (expr->static_type_symbol->type) {
	case VALA_SYMBOL_TYPE_METHOD:
		fprintf (generator->c_file, "%s", expr->static_type_symbol->method->cname);
		break;
	default:
		fprintf (generator->c_file, "%s", expr->str);
		break;
	}
}

static void
vala_code_generator_process_expression (ValaCodeGenerator *generator, ValaExpression *expr)
{
	vala_code_generator_find_static_type_of_expression (generator, expr);

	switch (expr->type) {
	case VALA_EXPRESSION_TYPE_ASSIGNMENT:
		vala_code_generator_process_assignment (generator, expr);
		break;
	case VALA_EXPRESSION_TYPE_INVOCATION:
		vala_code_generator_process_invocation (generator, expr);
		break;
	case VALA_EXPRESSION_TYPE_MEMBER_ACCESS:
		vala_code_generator_process_member_access (generator, expr);
		break;
	case VALA_EXPRESSION_TYPE_OBJECT_CREATION:
		vala_code_generator_process_object_creation_expression (generator, expr);
		break;
	case VALA_EXPRESSION_TYPE_OPERATION:
		vala_code_generator_process_operation_expression (generator, expr);
		break;
	case VALA_EXPRESSION_TYPE_PARENTHESIZED:
		vala_code_generator_process_parenthesized_expression (generator, expr);
		break;
	case VALA_EXPRESSION_TYPE_POSTFIX:
		vala_code_generator_process_postfix_expression (generator, expr);
		break;
	case VALA_EXPRESSION_TYPE_LITERAL_INTEGER:
	case VALA_EXPRESSION_TYPE_LITERAL_STRING:
		vala_code_generator_process_literal (generator, expr);
		break;
	case VALA_EXPRESSION_TYPE_SIMPLE_NAME:
		vala_code_generator_process_simple_name (generator, expr);
		break;
	}
}

static void
vala_code_generator_process_variable_declaration (ValaCodeGenerator *generator, ValaStatement *stmt)
{
	ValaTypeReference *type = stmt->variable_declaration->type;

	char *decl_string = get_cname_for_type_reference (type, stmt->location);

	fprintf (generator->c_file, "\t%s%s", decl_string, stmt->variable_declaration->declarator->name);
	
	ValaExpression *expr = stmt->variable_declaration->declarator->initializer;
	if (expr != NULL) {
		fprintf (generator->c_file, " = ");
		vala_code_generator_process_expression (generator, expr);
	}

	fprintf (generator->c_file, ";\n");

	ValaSymbol *sym = vala_symbol_new (VALA_SYMBOL_TYPE_LOCAL_VARIABLE);
	g_hash_table_insert (generator->sym->symbol_table, stmt->variable_declaration->declarator->name, sym);
	sym->typeref = stmt->variable_declaration->type;
}

static void vala_code_generator_process_statement (ValaCodeGenerator *generator, ValaStatement *stmt);

static void
vala_code_generator_process_block (ValaCodeGenerator *generator, ValaStatement *stmt)
{
	GList *l;
	
	fprintf (generator->c_file, "{\n");
	
	for (l = stmt->block.statements; l != NULL; l = l->next) {
		vala_code_generator_process_statement (generator, l->data);
	}
	
	fprintf (generator->c_file, "}\n");
}

static void
vala_code_generator_process_statement_expression_list (ValaCodeGenerator *generator, GList *list)
{
	GList *l;
	gboolean first = TRUE;
	
	for (l = list; l != NULL; l = l->next) {
		if (!first) {
			fprintf (generator->c_file, ", ");
		} else {
			first = FALSE;
		}
		vala_code_generator_process_expression (generator, l->data);
	}
}

static void
vala_code_generator_process_for_statement (ValaCodeGenerator *generator, ValaStatement *stmt)
{
	GList *l;
	
	fprintf (generator->c_file, "\tfor (");
	vala_code_generator_process_statement_expression_list (generator, stmt->for_stmt.initializer);
	fprintf (generator->c_file, "; ");
	vala_code_generator_process_expression (generator, stmt->for_stmt.condition);
	fprintf (generator->c_file, "; ");
	vala_code_generator_process_statement_expression_list (generator, stmt->for_stmt.iterator);
	fprintf (generator->c_file, ")\n");
	vala_code_generator_process_statement (generator, stmt->for_stmt.loop);
}

static void
vala_code_generator_process_if_statement (ValaCodeGenerator *generator, ValaStatement *stmt)
{
	GList *l;
	
	fprintf (generator->c_file, "\tif (");
	vala_code_generator_process_expression (generator, stmt->if_stmt.condition);
	fprintf (generator->c_file, ")\n");
	vala_code_generator_process_statement (generator, stmt->if_stmt.true_stmt);
	if (stmt->if_stmt.false_stmt != NULL) {
		fprintf (generator->c_file, "\telse ");
		vala_code_generator_process_statement (generator, stmt->if_stmt.false_stmt);
	}
}

static void
vala_code_generator_process_return_statement (ValaCodeGenerator *generator, ValaStatement *stmt)
{
	GList *l;
	
	fprintf (generator->c_file, "\treturn ");
	vala_code_generator_process_expression (generator, stmt->expr);
	fprintf (generator->c_file, ";\n");
}

static void
vala_code_generator_process_statement (ValaCodeGenerator *generator, ValaStatement *stmt)
{
	switch (stmt->type) {
	case VALA_STATEMENT_TYPE_BLOCK:
		vala_code_generator_process_block (generator, stmt);
		break;
	case VALA_STATEMENT_TYPE_EXPRESSION:
		fprintf (generator->c_file, "\t");
		vala_code_generator_process_expression (generator, stmt->expr);
		fprintf (generator->c_file, ";\n");
		break;
	case VALA_STATEMENT_TYPE_FOR:
		vala_code_generator_process_for_statement (generator, stmt);
		break;
	case VALA_STATEMENT_TYPE_IF:
		vala_code_generator_process_if_statement (generator, stmt);
		break;
	case VALA_STATEMENT_TYPE_RETURN:
		vala_code_generator_process_return_statement (generator, stmt);
		break;
	case VALA_STATEMENT_TYPE_VARIABLE_DECLARATION:
		vala_code_generator_process_variable_declaration (generator, stmt);
		break;
	default:
		fprintf (generator->c_file, "\t;\n");
	}
}

static void
vala_code_generator_process_methods2 (ValaCodeGenerator *generator, ValaClass *class)
{
	GList *l;

	char *camel_case;
	char *ns_lower;
	char *ns_upper;

	ValaNamespace *namespace = class->namespace;

	ns_lower = namespace->lower_case_cname;
	ns_upper = namespace->upper_case_cname;
	
	char *lower_case = class->lower_case_cname;
	char *upper_case = class->upper_case_cname;

	for (l = class->methods; l != NULL; l = l->next) {
		ValaMethod *method = l->data;
		
		if (strcmp (method->name, "init") == 0 || strcmp (method->name, "class_init") == 0) {
			continue;
		}

		if ((method->modifiers & VALA_METHOD_PUBLIC) && (method->modifiers & VALA_METHOD_OVERRIDE) == 0) {
			fprintf (generator->h_file, "%s %s (%s);\n", method->cdecl1, method->cname, method->cparameters);
		}

		if ((method->modifiers & (VALA_METHOD_VIRTUAL | VALA_METHOD_OVERRIDE)) == 0) {
			fprintf (generator->c_file, "%s\n", method->cdecl1);
			fprintf (generator->c_file, "%s (%s)\n", method->cname, method->cparameters);
		} else {
			fprintf (generator->c_file, "static %s\n", method->cdecl1);
			fprintf (generator->c_file, "%s%s_real_%s (%s)\n", ns_lower, lower_case, method->name, method->cparameters);
		}
		
		if (method->body != NULL) {
			generator->sym = vala_symbol_new (VALA_SYMBOL_TYPE_BLOCK);
			generator->sym->stmt = method->body;

			ValaSymbol *sym;
			GList *pl;

			for (pl = method->formal_parameters; pl != NULL; pl = pl->next) {
				ValaFormalParameter *param = pl->data;
				
				sym = vala_symbol_new (VALA_SYMBOL_TYPE_LOCAL_VARIABLE);
				g_hash_table_insert (generator->sym->symbol_table, param->name, sym);
				sym->typeref = param->type;
			}

			vala_code_generator_process_block (generator, method->body);
		}
		
		fprintf (generator->c_file, "\n");

		if (method->modifiers & VALA_METHOD_VIRTUAL) {
			fprintf (generator->c_file, "%s\n", method->cdecl1);
			fprintf (generator->c_file, "%s (%s)\n", method->cname, method->cparameters);
			fprintf (generator->c_file, "{\n");
			fprintf (generator->c_file, "\t");
			if (method->return_type->symbol->type != VALA_SYMBOL_TYPE_VOID) {
				fprintf (generator->c_file, "return ");
			}
			fprintf (generator->c_file, "%s%s_GET_CLASS (self)->%s (self", ns_upper, upper_case, method->name);
			
			GList *pl;
			
			for (pl = method->formal_parameters; pl != NULL; pl = pl->next) {
				ValaFormalParameter *param = pl->data;
				
				fprintf (generator->c_file, ", %s", param->name);
			}
			
			fprintf (generator->c_file, ");\n");
			fprintf (generator->c_file, "}\n");
			fprintf (generator->c_file, "\n");
		}

		if ((method->modifiers & VALA_METHOD_STATIC) && strcmp (method->name, "main") == 0 && strcmp (method->return_type->type_name, "int") == 0) {
			if (g_list_length (method->formal_parameters) == 2) {
				/* main method */
				
				fprintf (generator->c_file, "int\n");
				fprintf (generator->c_file, "main (int argc, char **argv)\n");
				fprintf (generator->c_file, "{\n");
				fprintf (generator->c_file, "\tg_type_init ();\n");
				fprintf (generator->c_file, "\treturn %s (argc, argv);\n", method->cname);
				fprintf (generator->c_file, "}\n");
				fprintf (generator->c_file, "\n");
			}
		}
	}
	fprintf (generator->h_file, "\n");

	/* constructors */
	fprintf (generator->c_file, "static void\n");
	fprintf (generator->c_file, "%s%s_init (%s%s *self)\n", ns_lower, lower_case, namespace->name, class->name);
	fprintf (generator->c_file, "{\n");

	if (class->init_method != NULL) {
		generator->sym = vala_symbol_new (VALA_SYMBOL_TYPE_BLOCK);
		generator->sym->stmt = class->init_method->body;

		vala_code_generator_process_block (generator, class->init_method->body);
	}

	fprintf (generator->c_file, "}\n");
	fprintf (generator->c_file, "\n");

	fprintf (generator->c_file, "static void\n");
	fprintf (generator->c_file, "%s%s_class_init (%s%sClass *klass)\n", ns_lower, lower_case, namespace->name, class->name);
	fprintf (generator->c_file, "{\n");

	/* chain virtual functions */
	for (l = class->methods; l != NULL; l = l->next) {
		ValaMethod *method = l->data;
		
		if (method->modifiers & (VALA_METHOD_VIRTUAL | VALA_METHOD_OVERRIDE)) {
			fprintf (generator->c_file, "\t");
			if (method->modifiers & VALA_METHOD_OVERRIDE) {
				ValaClass *super_class = class->base_class;
				while (super_class != NULL) {
					GList *vml;
					for (vml = super_class->methods; vml != NULL; vml = vml->next) {
						ValaMethod *vmethod = vml->data;
						if (strcmp (vmethod->name, method->name) == 0 && (vmethod->modifiers & VALA_METHOD_VIRTUAL)) {
							break;
						}
					}
					if (vml != NULL) {
						break;
					}
					super_class = super_class->base_class;
				}
				if (super_class == NULL) {
					err (method->location, "error: no overridable method ´%s´ found", method->name);
				}
				fprintf (generator->c_file, "%s%s_CLASS (klass)", super_class->namespace->upper_case_cname, super_class->upper_case_cname);
			} else {
				fprintf (generator->c_file, "klass");
			}
			fprintf (generator->c_file, "->%s = %s%s_real_%s;\n", method->name, ns_lower, lower_case, method->name);
		}
	}

	if (class->class_init_method != NULL) {
		generator->sym = vala_symbol_new (VALA_SYMBOL_TYPE_BLOCK);
		generator->sym->stmt = class->class_init_method->body;

		vala_code_generator_process_block (generator, class->class_init_method->body);
	}

	fprintf (generator->c_file, "}\n");
	fprintf (generator->c_file, "\n");
}

static void
vala_code_generator_process_virtual_method_pointers (ValaCodeGenerator *generator, ValaClass *class)
{
	GList *l;
	gboolean first = TRUE;

	char *ns_lower;
	char *ns_upper;

	ValaNamespace *namespace = class->namespace;

	ns_lower = namespace->lower_case_cname;
	ns_upper = namespace->upper_case_cname;
	
	char *lower_case = class->lower_case_cname;
	char *upper_case = class->upper_case_cname;

	for (l = class->methods; l != NULL; l = l->next) {
		ValaMethod *method = l->data;

		if ((method->modifiers & VALA_METHOD_VIRTUAL) == 0) {
			continue;
		}
		
		if (first) {
			fprintf (generator->h_file, "\n");
			fprintf (generator->h_file, "\t/* virtual methods */\n");
		} else {
			first = FALSE;
		}

		fprintf (generator->h_file, "\t%s(*%s) (%s);\n", get_cname_for_type_reference (method->return_type, method->location), method->name, method->cparameters);
	}
}

static void
vala_code_generator_process_class1 (ValaCodeGenerator *generator, ValaClass *class)
{
	ValaNamespace *namespace = class->namespace;

	char *camel_case;
	char *ns_lower;
	char *ns_upper;

	camel_case = g_strdup_printf ("%s%s", namespace->name, class->name);
	ns_lower = namespace->lower_case_cname;
	ns_upper = namespace->upper_case_cname;
	
	char *lower_case = class->lower_case_cname;
	char *upper_case = class->upper_case_cname;

	/* type macros */
	fprintf (generator->h_file, "#define %sTYPE_%s\t(%s%s_get_type ())\n", ns_upper, upper_case, ns_lower, lower_case);
	fprintf (generator->h_file, "#define %s%s(obj)\t(G_TYPE_CHECK_INSTANCE_CAST ((obj), %sTYPE_%s, %s))\n", ns_upper, upper_case, ns_upper, upper_case, camel_case);
	fprintf (generator->h_file, "#define %s%s_CLASS(klass)\t(G_TYPE_CHECK_CLASS_CAST ((klass), %sTYPE_%s, %sClass))\n", ns_upper, upper_case, ns_upper, upper_case, camel_case);
	fprintf (generator->h_file, "#define %sIS_%s(obj)\t(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %sTYPE_%s))\n", ns_upper, upper_case, ns_upper, upper_case);
	fprintf (generator->h_file, "#define %sIS_%s_CLASS(klass)\t(G_TYPE_CHECK_CLASS_TYPE ((klass), %sTYPE_%s))\n", ns_upper, upper_case, ns_upper, upper_case);
	fprintf (generator->h_file, "#define %s%s_GET_CLASS(obj)\t(G_TYPE_INSTANCE_GET_CLASS ((obj), %sTYPE_%s, %sClass))\n", ns_upper, upper_case, ns_upper, upper_case, camel_case);
	fprintf (generator->h_file, "\n");

	/* structs */
	fprintf (generator->h_file, "typedef struct _%s %s;\n", camel_case, camel_case);
	fprintf (generator->h_file, "typedef struct _%sClass %sClass;\n", camel_case, camel_case);
	fprintf (generator->h_file, "\n");
	
	vala_code_generator_process_methods1 (generator, class);
}

static void
vala_code_generator_process_class2 (ValaCodeGenerator *generator, ValaClass *class)
{
	ValaNamespace *namespace = class->namespace;

	char *camel_case;
	char *ns_lower;
	char *ns_upper;

	camel_case = g_strdup_printf ("%s%s", namespace->name, class->name);
	ns_lower = namespace->lower_case_cname;
	ns_upper = namespace->upper_case_cname;
	
	char *lower_case = class->lower_case_cname;
	char *upper_case = class->upper_case_cname;

	/* structs */
	fprintf (generator->h_file, "struct _%s {\n", camel_case);
	fprintf (generator->h_file, "\t%s%s parent;\n", class->base_class->namespace->name, class->base_class->name);
	fprintf (generator->h_file, "};\n");
	fprintf (generator->h_file, "\n");

	fprintf (generator->h_file, "struct _%sClass {\n", camel_case);
	fprintf (generator->h_file, "\t%s%sClass parent;\n", class->base_class->namespace->name, class->base_class->name);
	
	vala_code_generator_process_virtual_method_pointers (generator, class);
	
	fprintf (generator->h_file, "};\n");
	fprintf (generator->h_file, "\n");

	/* function declarations */
	fprintf (generator->h_file, "GType %s%s_get_type () G_GNUC_CONST;\n", ns_lower, lower_case);
	fprintf (generator->h_file, "\n");
	
	vala_code_generator_process_methods2 (generator, class);
	
	/* type initialization function */
	fprintf (generator->c_file, "GType\n");
	fprintf (generator->c_file, "%s%s_get_type ()\n", ns_lower, lower_case);
	fprintf (generator->c_file, "{\n");
	fprintf (generator->c_file, "\tstatic GType g_define_type_id = 0;\n");
	fprintf (generator->c_file, "\tif (G_UNLIKELY (g_define_type_id == 0)) {\n");
	fprintf (generator->c_file, "\t\tstatic const GTypeInfo g_define_type_info = {\n");
	fprintf (generator->c_file, "\t\t\tsizeof (%sClass),\n", camel_case);
	fprintf (generator->c_file, "\t\t\t(GBaseInitFunc) NULL,\n");
	fprintf (generator->c_file, "\t\t\t(GBaseFinalizeFunc) NULL,\n");
	fprintf (generator->c_file, "\t\t\t(GClassInitFunc) %s%s_class_init,\n", ns_lower, lower_case);
	fprintf (generator->c_file, "\t\t\t(GClassFinalizeFunc) NULL,\n");
	fprintf (generator->c_file, "\t\t\tNULL, /* class_data */\n");
	fprintf (generator->c_file, "\t\t\tsizeof (%s),\n", camel_case);
	fprintf (generator->c_file, "\t\t\t0, /* n_preallocs */\n");
	fprintf (generator->c_file, "\t\t\t(GInstanceInitFunc) %s%s_init,\n", ns_lower, lower_case);
	fprintf (generator->c_file, "\t\t};\n");
	
	fprintf (generator->c_file, "\t\tg_define_type_id = g_type_register_static (%sTYPE_%s, \"%s\", &g_define_type_info, 0);\n", class->base_class->namespace->upper_case_cname, class->base_class->upper_case_cname, camel_case);

	/* FIXME: add interfaces */
	fprintf (generator->c_file, "\t}\n");
	fprintf (generator->c_file, "\treturn g_define_type_id;\n");
	fprintf (generator->c_file, "}\n");
	fprintf (generator->c_file, "\n");
}

static void
vala_code_generator_process_namespace1 (ValaCodeGenerator *generator, ValaNamespace *namespace)
{
	GList *l;
	for (l = namespace->classes; l != NULL; l = l->next) {
		vala_code_generator_process_class1 (generator, l->data);
	}
}

static void
vala_code_generator_process_namespace2 (ValaCodeGenerator *generator, ValaNamespace *namespace)
{
	GList *l;
	for (l = namespace->classes; l != NULL; l = l->next) {
		vala_code_generator_process_class2 (generator, l->data);
	}
}

static void
vala_code_generator_process_source_file (ValaCodeGenerator *generator, ValaSourceFile *source_file)
{
	char *basename = g_strdup (source_file->filename);
	basename[strlen (basename) - strlen (".vala")] = '\0';
	
	/* FIXME: use output directory */
	
	char *c_filename = g_strdup_printf ("%s.c", basename);
	char *h_filename = g_strdup_printf ("%s.h", basename);
	
	char *header_define = filename_to_define (h_filename);
	
	/*
	 * FIXME: (optionally) skip source file if c_file and h_file already
	 * exist and their mtime is >= mtime of source_file
	 * => reduces unnecessary rebuilds
	 *
	 * to be really safe, ensure that output would be identical
	 */
	
	generator->c_file = fopen (c_filename, "w");
	generator->h_file = fopen (h_filename, "w");
	
	fprintf (generator->h_file, "#ifndef __%s__\n", header_define);
	fprintf (generator->h_file, "#define __%s__\n", header_define);
	fprintf (generator->h_file, "\n");

	fprintf (generator->h_file, "#include <glib-object.h>\n");
	/* FIXME: add include file for base class */
	fprintf (generator->h_file, "\n");
	
	fprintf (generator->h_file, "G_BEGIN_DECLS\n");
	fprintf (generator->h_file, "\n");

	/* FIXME: fix leak */
	fprintf (generator->c_file, "#include \"%s\"\n", g_path_get_basename (h_filename));
	fprintf (generator->c_file, "\n");
	
	vala_code_generator_process_namespace1 (generator, source_file->root_namespace);
	GList *l;

	for (l = source_file->namespaces; l != NULL; l = l->next) {
		vala_code_generator_process_namespace1 (generator, l->data);
	}

	vala_code_generator_process_namespace1 (generator, source_file->root_namespace);

	for (l = source_file->namespaces; l != NULL; l = l->next) {
		vala_code_generator_process_namespace2 (generator, l->data);
	}

	fprintf (generator->h_file, "G_END_DECLS\n");
	fprintf (generator->h_file, "\n");

	fprintf (generator->h_file, "#endif /* __%s__ */\n", header_define);
	
	fclose (generator->c_file);
	fclose (generator->h_file);
	
	generator->c_file = NULL;
	generator->h_file = NULL;
}

void
vala_code_generator_run (ValaCodeGenerator *generator)
{
	ValaSourceFile *source_file;
	
	GList *l;
	for (l = generator->context->source_files; l != NULL; l = l->next) {
		vala_code_generator_process_source_file (generator, l->data);
	}
}

void
vala_code_generator_free (ValaCodeGenerator *generator)
{
	g_free (generator);
}
