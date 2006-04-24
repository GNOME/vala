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
		
		char *method_return_type_cname = g_strdup_printf ("%s%s", method->return_type->namespace_name, method->return_type->type_name);
		char *method_cname = g_strdup_printf ("%s%s_%s", ns_lower, lower_case, method->name);
		char *parameters;
		GList *parameter_list = NULL;
		if ((method->modifiers & VALA_METHOD_STATIC) == 0) {
			parameter_list = g_list_append (parameter_list, g_strdup_printf ("%s%s *self", namespace->name, class->name));
		}
		
		GList *pl;
		for (pl = method->formal_parameters; pl != NULL; pl = pl->next) {
			ValaFormalParameter *param = pl->data;
			parameter_list = g_list_append (parameter_list, g_strdup_printf ("%s%s *%s", param->type->symbol->class->namespace->name, param->type->symbol->class->name, param->name));
		}
		
		if (parameter_list == NULL) {
			parameters = g_strdup ("");
		} else {
			parameters = parameter_list->data;
			GList *sl;
			for (sl = parameter_list->next; sl != NULL; sl = sl->next) {
				parameters = g_strdup_printf ("%s, %s", parameters, sl->data);
				g_free (sl->data);
			}
			g_list_free (parameter_list);
		}
		
		method->cdecl2 = g_strdup_printf ("%s (%s)", method_cname, parameters);

		if (method->modifiers & VALA_METHOD_PUBLIC) {
			method->cdecl1 = g_strdup (method_return_type_cname);
		} else {
			method->cdecl1 = g_strdup_printf ("static %s", method_return_type_cname);
			fprintf (generator->c_file, "%s %s;\n", method->cdecl1, method->cdecl2);
		}

	}
	fprintf (generator->c_file, "\n");
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

		if (method->modifiers & VALA_METHOD_PUBLIC) {
			fprintf (generator->h_file, "%s %s;\n", method->cdecl1, method->cdecl2);
		}

		fprintf (generator->c_file, "%s\n", method->cdecl1);
		fprintf (generator->c_file, "%s\n", method->cdecl2);
		fprintf (generator->c_file, "{\n");
		fprintf (generator->c_file, "}\n");
		fprintf (generator->c_file, "\n");
	}
	fprintf (generator->h_file, "\n");

	/* constructors */
	fprintf (generator->c_file, "static void\n");
	fprintf (generator->c_file, "%s%s_init (%s%s *self)\n", ns_lower, lower_case, namespace->name, class->name);
	fprintf (generator->c_file, "{\n");
	fprintf (generator->c_file, "}\n");
	fprintf (generator->c_file, "\n");

	fprintf (generator->c_file, "static void\n");
	fprintf (generator->c_file, "%s%s_class_init (%s%sClass *klass)\n", ns_lower, lower_case, namespace->name, class->name);
	fprintf (generator->c_file, "{\n");
	fprintf (generator->c_file, "}\n");
	fprintf (generator->c_file, "\n");
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
