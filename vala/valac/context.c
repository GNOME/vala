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

#include <stdio.h>

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

ValaSourceFile *
vala_source_file_new (const char *filename)
{
	ValaSourceFile *file = g_new0 (ValaSourceFile, 1);
	
	file->filename = filename;
	file->root_namespace = g_new0 (ValaNamespace, 1);
	
	return file;
}
