/* driver.c
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

#include <glib.h>

#include "context.h"
#include "generator.h"

static int
driver_main (char **sources, char *directory)
{
	/*
	 * Parse source files
	 * Load metadata from specified gidl files into symbol tables
	 * Copy namespace and type names from parse tree into symbol tables
	 * Resolve type references in parse tree
	 * Load metadata from parse tree into symbol tables
	 * Generate code
	 */
	
	ValaContext *context = vala_context_new ();
	
	char **file;
	for (file = sources; *file != NULL; file++) {
		context->source_files = g_list_prepend (context->source_files, vala_source_file_new (g_strdup (*file)));
	}
	context->source_files = g_list_reverse (context->source_files);
	g_strfreev (sources);
	sources = NULL;

	vala_context_parse (context);
	
	ValaCodeGenerator *generator = vala_code_generator_new (context);
	generator->directory = directory;
	vala_code_generator_run (generator);
	vala_code_generator_free (generator);
	
	vala_context_free (context);
	context = NULL;
	
	return 0;
}

int
main (int argc, char **argv)
{
	GError *error = NULL;
	GOptionContext *option_context;

	char *directory = NULL;
	gboolean version = FALSE;
	char **sources = NULL;
	
	const GOptionEntry options[] = {
		{ "directory", 'd', 0, G_OPTION_ARG_FILENAME, &directory, "Output directory", "DIRECTORY" },
		{ "version", 0, 0, G_OPTION_ARG_NONE, &version, "Display version number", NULL },
		{ G_OPTION_REMAINING, 0, 0, G_OPTION_ARG_FILENAME_ARRAY, &sources, NULL, "FILE..." },
		{ NULL }
	};
	
	option_context = g_option_context_new ("- Vala Compiler");
	g_option_context_set_help_enabled (option_context, TRUE);
	g_option_context_add_main_entries (option_context, options, NULL);
	g_option_context_parse (option_context, &argc, &argv, &error);
	
	if (error != NULL) {
		return 1;
	}
	
	if (version) {
		return 0;
	}
	
	if (*sources == NULL) {
		printf ("No source file specified.\n");
		return 1;
	}
	
	char **f;
	for (f = sources; *f != NULL; f++) {
		if (!g_str_has_suffix (*f, ".vala")) {
			printf ("Only .vala source files supported.\n");
			return 1;
		}
	}
	
	directory = g_strdup (directory);
	sources = g_strdupv (sources);
	g_option_context_free (option_context);
	
	return driver_main (sources, directory);
}
