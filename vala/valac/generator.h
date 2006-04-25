/* generator.h
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

typedef struct _ValaCodeGenerator ValaCodeGenerator;

struct _ValaCodeGenerator {
	ValaContext *context;
	const char *directory;
	FILE *c_file;
	FILE *h_file;
	ValaSymbol *sym; /* current block */
};

ValaCodeGenerator *vala_code_generator_new (ValaContext *context);
void vala_code_generator_run (ValaCodeGenerator *generator);
void vala_code_generator_free (ValaCodeGenerator *generator);
