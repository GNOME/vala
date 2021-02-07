/* gvc-compat.c
 *
 * Copyright (C) 2017  Rico Tzschichholz
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 *  Rico Tzschichholz <ricotz@ubuntu.com>
 */

#include <gvc.h>

/* Compat-layer for Graphviz with/without cgraph support */

void
valadoc_compat_gvc_init (void);

Agnode_t*
valadoc_compat_gvc_graph_create_node (Agraph_t* graph, const char *name);

Agraph_t*
valadoc_compat_gvc_graph_new (const char *name);

Agedge_t*
valadoc_compat_gvc_graph_create_edge (Agraph_t* graph, Agnode_t* from, Agnode_t* to);

void
valadoc_compat_gvc_init (void)
{
#ifndef WITH_CGRAPH
	aginit ();
#endif
}

Agnode_t*
valadoc_compat_gvc_graph_create_node (Agraph_t* graph, const char *name)
{
#ifdef WITH_CGRAPH
	return agnode (graph, (char*) name, TRUE);
#else
	return agnode (graph, (char*) name);
#endif
}

Agraph_t*
valadoc_compat_gvc_graph_new (const char *name)
{
#ifdef WITH_CGRAPH
	return agopen ((char*) name, Agdirected, NULL);
#else
	return agopen ((char*) name, AGDIGRAPH);
#endif
}

Agedge_t*
valadoc_compat_gvc_graph_create_edge (Agraph_t* graph, Agnode_t* from, Agnode_t* to)
{
#ifdef WITH_CGRAPH
	return agedge (graph, from, to, NULL, TRUE);
#else
	return agedge (graph, from, to);
#endif
}
