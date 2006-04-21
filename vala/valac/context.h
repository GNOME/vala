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

typedef struct _ValaContext ValaContext;
typedef struct _ValaSourceFile ValaSourceFile;
typedef struct _ValaNamespace ValaNamespace;
typedef struct _ValaClass ValaClass;

struct _ValaContext {
	GList *source_files;
};

struct _ValaSourceFile {
	const char *filename;
	ValaNamespace *root_namespace;
	GList *namespaces;
};

struct _ValaNamespace {
	char *name;
	GList *classes;
};

struct _ValaClass {
	char *name;	
};

ValaContext *vala_context_new ();
void vala_context_free (ValaContext *context);
void vala_context_parse (ValaContext *context);

ValaSourceFile *vala_source_file_new (const char *filename);

void vala_parser_parse (ValaSourceFile *source_file);
