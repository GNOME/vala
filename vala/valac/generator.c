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
camel_case_to_lower_case (const char *camel_case)
{
	char *str = g_malloc0 (2 * strlen (camel_case));
	const char *i = camel_case;
	char *p = str;
	
	while (*i != '\0') {
		if (isupper (*i)) {
			/* current character is upper case */
			if (i != camel_case) {
				/* we're not at the beginning */
				const char *t = i - 1;				
				gboolean prev_upper = isupper (*t);
				t = i + 1;
				gboolean next_upper = isupper (*t);
				if (!prev_upper || (*t != '\0' && !next_upper)) {
					/* previous character wasn't upper case */
					*p = '_';
					p++;
				}
			}
		}
			
		*p = tolower (*i);
		i++;
		p++;
	}
	
	return str;
}

static char *
camel_case_to_upper_case (const char *camel_case)
{
	char *str = camel_case_to_lower_case (camel_case);
	
	char *p;
	
	for (p = str; *p != '\0'; p++) {
		*p = toupper (*p);
	}
	
	return str;
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
vala_code_generator_process_class (ValaCodeGenerator *generator, ValaNamespace *namespace, ValaClass *class)
{
	char *camel_case;
	char *ns_lower;
	char *ns_upper;
	
	if (namespace->name == NULL) {
		camel_case = g_strdup (class->name);

		ns_lower = g_strdup ("");
		ns_upper = g_strdup ("");
	} else {
		camel_case = g_strdup_printf ("%s%s", namespace->name, class->name);

		ns_lower = camel_case_to_lower_case (namespace->name);
		/* we know that this is safe */
		ns_lower[strlen (ns_lower)] = '_';

		ns_upper = camel_case_to_upper_case (namespace->name);
		/* we know that this is safe */
		ns_upper[strlen (ns_upper)] = '_';
	}
	
	char *lower_case = camel_case_to_lower_case (class->name);
	char *upper_case = camel_case_to_upper_case (class->name);

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

	fprintf (generator->h_file, "struct _%s {\n", camel_case);
	fprintf (generator->h_file, "\tGObject parent;\n");
	fprintf (generator->h_file, "};\n");
	fprintf (generator->h_file, "\n");

	fprintf (generator->h_file, "struct _%sClass {\n", camel_case);
	fprintf (generator->h_file, "\tGObjectClass parent;\n");
	fprintf (generator->h_file, "};\n");
	fprintf (generator->h_file, "\n");

	/* function declarations */
	fprintf (generator->h_file, "GType %s%s_get_type () G_GNUC_CONST;\n", ns_lower, lower_case);
	fprintf (generator->h_file, "\n");
	
	/* constructors */
	fprintf (generator->c_file, "static void\n");
	fprintf (generator->c_file, "%s%s_init (%s *self)\n", ns_lower, lower_case, camel_case);
	fprintf (generator->c_file, "{\n");
	fprintf (generator->c_file, "}\n");
	fprintf (generator->c_file, "\n");

	fprintf (generator->c_file, "static void\n");
	fprintf (generator->c_file, "%s%s_class_init (%sClass *klass)\n", ns_lower, lower_case, camel_case);
	fprintf (generator->c_file, "{\n");
	fprintf (generator->c_file, "}\n");
	fprintf (generator->c_file, "\n");

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
	fprintf (generator->c_file, "\t\tg_define_type_id = g_type_register_static (%sTYPE_%s, \"%s\", &g_define_type_info, 0);\n", ns_upper, upper_case, camel_case);
	/* FIXME: add interfaces */
	fprintf (generator->c_file, "\t}\n");
	fprintf (generator->c_file, "\treturn g_define_type_id;\n");
	fprintf (generator->c_file, "}\n");
	fprintf (generator->c_file, "\n");
}

static void
vala_code_generator_process_namespace (ValaCodeGenerator *generator, ValaNamespace *namespace)
{
	GList *l;
	for (l = namespace->classes; l != NULL; l = l->next) {
		vala_code_generator_process_class (generator, namespace, l->data);
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
	
	vala_code_generator_process_namespace (generator, source_file->root_namespace);
	GList *l;
	for (l = source_file->namespaces; l != NULL; l = l->next) {
		vala_code_generator_process_namespace (generator, l->data);
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
