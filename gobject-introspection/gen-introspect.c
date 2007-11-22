/* GObject introspection: gen-introspect
 *
 * Copyright (C) 2007  Jürg Billeter
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
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <glib.h>
#include <glib/gstdio.h>
#include <glib-object.h>
#include <gmodule.h>
#include "gen-introspect.h"
#include "gidlmodule.h"
#include "gidlnode.h"

typedef GType (*TypeFunction) (void);

static void node_generate (GIGenerator *igenerator, GIdlNode *node);
static void g_igenerator_parse_macros (GIGenerator *igenerator);

static int g_idl_node_cmp (GIdlNode *a, GIdlNode *b)
{
	if (a->type < b->type) {
		return -1;
	} else if (a->type > b->type) {
		return 1;
	} else {
		return strcmp (a->name, b->name);
	}
}

GIGenerator *g_igenerator_new (void)
{
	GIGenerator *igenerator = g_new0 (GIGenerator, 1);
	igenerator->namespace = "";
	igenerator->lower_case_namespace = g_strdup ("");
	igenerator->typedef_table = g_hash_table_new (g_str_hash, g_str_equal);
	igenerator->struct_or_union_or_enum_table = g_hash_table_new (g_str_hash, g_str_equal);

	igenerator->type_map = g_hash_table_new (g_str_hash, g_str_equal);
	igenerator->type_by_lower_case_prefix = g_hash_table_new (g_str_hash, g_str_equal);

	the_igenerator = igenerator;

	return igenerator;
}

static void g_igenerator_write_inline (GIGenerator *igenerator, const char *s)
{
	fprintf (stdout, s);
}

static void g_igenerator_write (GIGenerator *igenerator, const char *s)
{
	int i;
	for (i = 0; i < igenerator->indent; i++) {
		fprintf (stdout, "\t");
	}

	g_igenerator_write_inline (igenerator, s);
}

static void g_igenerator_write_indent (GIGenerator *igenerator, const char *s)
{
	g_igenerator_write (igenerator, s);
	igenerator->indent++;
}

static void g_igenerator_write_unindent (GIGenerator *igenerator, const char *s)
{
	igenerator->indent--;
	g_igenerator_write (igenerator, s);
}

static void field_generate (GIGenerator *igenerator, GIdlNodeField *node)
{
	char *markup = g_markup_printf_escaped ("<field name=\"%s\" type=\"%s\"/>\n", node->node.name, node->type->unparsed);
	g_igenerator_write (igenerator, markup);
	g_free (markup);
}

static void value_generate (GIGenerator *igenerator, GIdlNodeValue *node)
{
	char *markup = g_markup_printf_escaped ("<member name=\"%s\" value=\"%d\"/>\n", node->node.name, node->value);
	g_igenerator_write (igenerator, markup);
	g_free (markup);
}

static void constant_generate (GIGenerator *igenerator, GIdlNodeConstant *node)
{
	char *markup = g_markup_printf_escaped ("<constant name=\"%s\" type=\"%s\" value=\"%s\"/>\n", node->node.name, node->type->unparsed, node->value);
	g_igenerator_write (igenerator, markup);
	g_free (markup);
}

static void property_generate (GIGenerator *igenerator, GIdlNodeProperty *node)
{
	char *markup = g_markup_printf_escaped ("<property name=\"%s\" type=\"%s\" readable=\"%s\" writable=\"%s\" construct=\"%s\" construct-only=\"%s\"/>\n", node->node.name, node->type->unparsed, node->readable ? "1" : "0", node->writable ? "1" : "0", node->construct ? "1" : "0", node->construct_only ? "1" : "0");
	g_igenerator_write (igenerator, markup);
	g_free (markup);
}

static void function_generate (GIGenerator *igenerator, GIdlNodeFunction *node)
{
	char *markup;
	const char *tag_name;
	if (node->node.type == G_IDL_NODE_CALLBACK) {
		tag_name = "callback";
		markup = g_markup_printf_escaped ("<callback name=\"%s\">\n", node->node.name);
	} else if (node->is_constructor) {
		tag_name = "constructor";
		markup = g_markup_printf_escaped ("<constructor name=\"%s\" symbol=\"%s\">\n", node->node.name, node->symbol);
	} else if (node->is_method) {
		tag_name = "method";
		markup = g_markup_printf_escaped ("<method name=\"%s\" symbol=\"%s\">\n", node->node.name, node->symbol);
	} else {
		tag_name = "function";
		markup = g_markup_printf_escaped ("<function name=\"%s\" symbol=\"%s\">\n", node->node.name, node->symbol);
	}

	g_igenerator_write_indent (igenerator, markup);
	g_free (markup);
	markup = g_markup_printf_escaped ("<return-type type=\"%s\"/>\n", node->result->type->unparsed);
	g_igenerator_write (igenerator, markup);
	g_free (markup);
	if (node->parameters != NULL) {
		GList *l;
		g_igenerator_write_indent (igenerator, "<parameters>\n");
		for (l = node->parameters; l != NULL; l = l->next) {
			GIdlNodeParam *param = l->data;
			markup = g_markup_printf_escaped ("<parameter name=\"%s\" type=\"%s\"/>\n", param->node.name, param->type->unparsed);
			g_igenerator_write (igenerator, markup);
			g_free (markup);
		}
		g_igenerator_write_unindent (igenerator, "</parameters>\n");
	}
	markup = g_strdup_printf ("</%s>\n", tag_name);
	g_igenerator_write_unindent (igenerator, markup);
	g_free (markup);
}

static void vfunc_generate (GIGenerator *igenerator, GIdlNodeVFunc *node)
{
	char *markup = g_markup_printf_escaped ("<vfunc name=\"%s\">\n", node->node.name);
	g_igenerator_write_indent (igenerator, markup);
	g_free (markup);
	markup = g_markup_printf_escaped ("<return-type type=\"%s\"/>\n", node->result->type->unparsed);
	g_igenerator_write (igenerator, markup);
	g_free (markup);
	if (node->parameters != NULL) {
		GList *l;
		g_igenerator_write_indent (igenerator, "<parameters>\n");
		for (l = node->parameters; l != NULL; l = l->next) {
			GIdlNodeParam *param = l->data;
			markup = g_markup_printf_escaped ("<parameter name=\"%s\" type=\"%s\"/>\n", param->node.name, param->type->unparsed);
			g_igenerator_write (igenerator, markup);
			g_free (markup);
		}
		g_igenerator_write_unindent (igenerator, "</parameters>\n");
	}
	g_igenerator_write_unindent (igenerator, "</vfunc>\n");
}

static void signal_generate (GIGenerator *igenerator, GIdlNodeSignal *node)
{
	char *markup;
	const char *when = "LAST";
	if (node->run_first) {
		when = "FIRST";
	} else if (node->run_cleanup) {
		when = "CLEANUP";
	}
	markup = g_markup_printf_escaped ("<signal name=\"%s\" when=\"%s\">\n", node->node.name, when);
	g_igenerator_write_indent (igenerator, markup);
	g_free (markup);
	markup = g_markup_printf_escaped ("<return-type type=\"%s\"/>\n", node->result->type->unparsed);
	g_igenerator_write (igenerator, markup);
	g_free (markup);
	if (node->parameters != NULL) {
		GList *l;
		g_igenerator_write_indent (igenerator, "<parameters>\n");
		for (l = node->parameters; l != NULL; l = l->next) {
			GIdlNodeParam *param = l->data;
			markup = g_markup_printf_escaped ("<parameter name=\"%s\" type=\"%s\"/>\n", param->node.name, param->type->unparsed);
			g_igenerator_write (igenerator, markup);
			g_free (markup);
		}
		g_igenerator_write_unindent (igenerator, "</parameters>\n");
	}
	g_igenerator_write_unindent (igenerator, "</signal>\n");
}

static void interface_generate (GIGenerator *igenerator, GIdlNodeInterface *node)
{
	GList *l;
	char *markup;
	if (node->node.type == G_IDL_NODE_OBJECT) {
		markup = g_markup_printf_escaped ("<object name=\"%s\" parent=\"%s\" type-name=\"%s\" get-type=\"%s\">\n", node->node.name, node->parent, node->gtype_name, node->gtype_init);
	} else if (node->node.type == G_IDL_NODE_INTERFACE) {
		markup = g_markup_printf_escaped ("<interface name=\"%s\" type-name=\"%s\" get-type=\"%s\">\n", node->node.name, node->gtype_name, node->gtype_init);
	}

	g_igenerator_write_indent (igenerator, markup);
	g_free (markup);
	if (node->node.type == G_IDL_NODE_OBJECT && node->interfaces != NULL) {
		GList *l;
		g_igenerator_write_indent (igenerator, "<implements>\n");
		for (l = node->interfaces; l != NULL; l = l->next) {
			markup = g_markup_printf_escaped ("<interface name=\"%s\"/>\n", (char *) l->data);
			g_igenerator_write (igenerator, markup);
			g_free (markup);
		}
		g_igenerator_write_unindent (igenerator, "</implements>\n");
	} else if (node->node.type == G_IDL_NODE_INTERFACE && node->prerequisites != NULL) {
		GList *l;
		g_igenerator_write_indent (igenerator, "<requires>\n");
		for (l = node->prerequisites; l != NULL; l = l->next) {
			markup = g_markup_printf_escaped ("<interface name=\"%s\"/>\n", (char *) l->data);
			g_igenerator_write (igenerator, markup);
			g_free (markup);
		}
		g_igenerator_write_unindent (igenerator, "</requires>\n");
	}

	for (l = node->members; l != NULL; l = l->next) {
		node_generate (igenerator, l->data);
	}

	if (node->node.type == G_IDL_NODE_OBJECT) {
		g_igenerator_write_unindent (igenerator, "</object>\n");
	} else if (node->node.type == G_IDL_NODE_INTERFACE) {
		g_igenerator_write_unindent (igenerator, "</interface>\n");
	}
}

static void struct_generate (GIGenerator *igenerator, GIdlNodeStruct *node)
{
	GList *l;
	char *markup = g_markup_printf_escaped ("<struct name=\"%s\">\n", node->node.name);
	g_igenerator_write_indent (igenerator, markup);
	g_free (markup);
	for (l = node->members; l != NULL; l = l->next) {
		node_generate (igenerator, l->data);
	}
	g_igenerator_write_unindent (igenerator, "</struct>\n");
}

static void union_generate (GIGenerator *igenerator, GIdlNodeUnion *node)
{
	GList *l;
	char *markup = g_markup_printf_escaped ("<union name=\"%s\">\n", node->node.name);
	g_igenerator_write_indent (igenerator, markup);
	g_free (markup);
	for (l = node->members; l != NULL; l = l->next) {
		node_generate (igenerator, l->data);
	}
	g_igenerator_write_unindent (igenerator, "</union>\n");
}

static void boxed_generate (GIGenerator *igenerator, GIdlNodeBoxed *node)
{
	GList *l;
	char *markup = g_markup_printf_escaped ("<boxed name=\"%s\" type-name=\"%s\" get-type=\"%s\">\n", node->node.name, node->gtype_name, node->gtype_init);
	g_igenerator_write_indent (igenerator, markup);
	g_free (markup);
	for (l = node->members; l != NULL; l = l->next) {
		node_generate (igenerator, l->data);
	}
	g_igenerator_write_unindent (igenerator, "</boxed>\n");
}

static void enum_generate (GIGenerator *igenerator, GIdlNodeEnum *node)
{
	GList *l;
	char *markup;
	const char *tag_name = NULL;

	if (node->node.type == G_IDL_NODE_ENUM) {
		tag_name = "enum";
	} else if (node->node.type == G_IDL_NODE_FLAGS) {
		tag_name = "flags";
	}
	markup = g_markup_printf_escaped ("<%s name=\"%s\">\n", tag_name, node->node.name);
	g_igenerator_write_indent (igenerator, markup);
	g_free (markup);

	for (l = node->values; l != NULL; l = l->next) {
		node_generate (igenerator, l->data);
	}

	markup = g_strdup_printf ("</%s>\n", tag_name);
	g_igenerator_write_unindent (igenerator, markup);
	g_free (markup);
}

static void node_generate (GIGenerator *igenerator, GIdlNode *node)
{
	switch (node->type) {
	case G_IDL_NODE_FUNCTION:
	case G_IDL_NODE_CALLBACK:
		function_generate (igenerator, (GIdlNodeFunction *) node);
		break;
	case G_IDL_NODE_VFUNC:
		vfunc_generate (igenerator, (GIdlNodeVFunc *) node);
		break;
	case G_IDL_NODE_OBJECT:
	case G_IDL_NODE_INTERFACE:
		interface_generate (igenerator, (GIdlNodeInterface *) node);
		break;
	case G_IDL_NODE_STRUCT:
		struct_generate (igenerator, (GIdlNodeStruct *) node);
		break;
	case G_IDL_NODE_UNION:
		union_generate (igenerator, (GIdlNodeUnion *) node);
		break;
	case G_IDL_NODE_BOXED:
		boxed_generate (igenerator, (GIdlNodeBoxed *) node);
		break;
	case G_IDL_NODE_ENUM:
	case G_IDL_NODE_FLAGS:
		enum_generate (igenerator, (GIdlNodeEnum *) node);
		break;
	case G_IDL_NODE_PROPERTY:
		property_generate (igenerator, (GIdlNodeProperty *) node);
		break;
	case G_IDL_NODE_FIELD:
		field_generate (igenerator, (GIdlNodeField *) node);
		break;
	case G_IDL_NODE_SIGNAL:
		signal_generate (igenerator, (GIdlNodeSignal *) node);
		break;
	case G_IDL_NODE_VALUE:
		value_generate (igenerator, (GIdlNodeValue *) node);
		break;
	case G_IDL_NODE_CONSTANT:
		constant_generate (igenerator, (GIdlNodeConstant *) node);
		break;
	default:
		g_assert_not_reached ();
	}
}

static void module_generate (GIGenerator *igenerator, GIdlModule *module)
{
	GList *l;
	char *markup = g_markup_printf_escaped ("<namespace name=\"%s\">\n", module->name);
	g_igenerator_write_indent (igenerator, markup);
	g_free (markup);
	for (l = module->entries; l != NULL; l = l->next) {
		node_generate (igenerator, l->data);
	}
	g_igenerator_write_unindent (igenerator, "</namespace>\n");
}

static GIdlNodeType *get_type_from_type_id (GType type_id)
{
	GIdlNodeType *gitype = (GIdlNodeType *) g_idl_node_new (G_IDL_NODE_TYPE);

	GType type_fundamental = g_type_fundamental (type_id);

	if (type_fundamental == G_TYPE_STRING) {
		gitype->unparsed = g_strdup ("char*");
	} else if (type_id == G_TYPE_STRV) {
		gitype->unparsed = g_strdup ("char*[]");
	} else if (type_fundamental == G_TYPE_INTERFACE || type_fundamental == G_TYPE_BOXED || type_fundamental == G_TYPE_OBJECT) {
		gitype->unparsed = g_strdup_printf ("%s*", g_type_name (type_id));
	} else if (type_fundamental == G_TYPE_PARAM) {
		gitype->unparsed = g_strdup ("GParamSpec*");
	} else {
		gitype->unparsed = g_strdup (g_type_name (type_id));
	}

	return gitype;
}

static char *str_replace (const char *str, const char *needle, const char *replacement)
{
	char **strings = g_strsplit (str, needle, 0);
	char *result = g_strjoinv (replacement, strings);
	g_strfreev (strings);
	return result;
}

static void g_igenerator_process_properties (GIGenerator *igenerator, GIdlNodeInterface *ginode, GType type_id)
{
	int i;
	guint n_properties;
	GParamSpec **properties;

	if (ginode->node.type == G_IDL_NODE_OBJECT) {
		GObjectClass *type_class = g_type_class_ref (type_id);
		properties = g_object_class_list_properties (type_class, &n_properties);
	} else if (ginode->node.type == G_IDL_NODE_INTERFACE) {
		GTypeInterface *iface = g_type_default_interface_ref (type_id);
		properties = g_object_interface_list_properties (iface, &n_properties);
	} else {
		g_assert_not_reached ();
	}

	for (i = 0; i < n_properties; i++) {
		/* ignore inherited properties */
		if (properties[i]->owner_type != type_id) {
			continue;
		}
		GIdlNodeProperty *giprop = (GIdlNodeProperty *) g_idl_node_new (G_IDL_NODE_PROPERTY);
		giprop->node.name = properties[i]->name;
		ginode->members = g_list_insert_sorted (ginode->members, giprop, (GCompareFunc) g_idl_node_cmp);
		giprop->type = get_type_from_type_id (properties[i]->value_type);
		giprop->readable = (properties[i]->flags & G_PARAM_READABLE) != 0;
		giprop->writable = (properties[i]->flags & G_PARAM_WRITABLE) != 0;
		giprop->construct = (properties[i]->flags & G_PARAM_CONSTRUCT) != 0;
		giprop->construct_only = (properties[i]->flags & G_PARAM_CONSTRUCT_ONLY) != 0;
	}
}

static void g_igenerator_process_signals (GIGenerator *igenerator, GIdlNodeInterface *ginode, GType type_id)
{
	int i, j;
	guint n_signal_ids;
	guint *signal_ids = g_signal_list_ids (type_id, &n_signal_ids);

	for (i = 0; i < n_signal_ids; i++) {
		GSignalQuery signal_query;
		g_signal_query (signal_ids[i], &signal_query);
		GIdlNodeSignal *gisig = (GIdlNodeSignal *) g_idl_node_new (G_IDL_NODE_SIGNAL);
		gisig->node.name = g_strdup (signal_query.signal_name);
		ginode->members = g_list_insert_sorted (ginode->members, gisig, (GCompareFunc) g_idl_node_cmp);

		gisig->run_first = (signal_query.signal_flags & G_SIGNAL_RUN_FIRST) != 0;
		gisig->run_last = (signal_query.signal_flags & G_SIGNAL_RUN_LAST) != 0;
		gisig->run_cleanup = (signal_query.signal_flags & G_SIGNAL_RUN_CLEANUP) != 0;

		/* add sender parameter */
		GIdlNodeParam *giparam = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
		gisig->parameters = g_list_append (gisig->parameters, giparam);
		giparam->node.name = g_strdup ("object");
		giparam->type = get_type_from_type_id (type_id);
		
		for (j = 0; j < signal_query.n_params; j++) {
			giparam = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
			gisig->parameters = g_list_append (gisig->parameters, giparam);
			giparam->node.name = g_strdup_printf ("p%d", j);
			giparam->type = get_type_from_type_id (signal_query.param_types[j]);
		}
		gisig->result = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
		gisig->result->type = get_type_from_type_id (signal_query.return_type);
	}
}

static void g_igenerator_process_types (GIGenerator *igenerator)
{
	int i;
	GList *lib_l;

	/* ensure to initialize GObject */
	g_type_class_ref (G_TYPE_OBJECT);

	for (lib_l = igenerator->libraries; lib_l != NULL; lib_l = lib_l->next) {
		GList *l;
		GModule *module = g_module_open (lib_l->data, G_MODULE_BIND_LAZY | G_MODULE_BIND_LOCAL);
		if (module == NULL) {
			g_critical ("Couldn't open module: %s", (char *) lib_l->data);
			continue;
		}
		for (l = igenerator->get_type_symbols; l != NULL; l = l->next) {
			char *get_type_symbol = l->data;
			TypeFunction type_fun;
			if (!g_module_symbol (module, get_type_symbol, (gpointer*) &type_fun)) {
				continue;
			}
			GType type_id = type_fun ();
			GType type_fundamental = g_type_fundamental (type_id);
			char *lower_case_prefix = str_replace (g_strndup (get_type_symbol, strlen (get_type_symbol) - strlen ("_get_type")), "_", "");
			if (type_fundamental == G_TYPE_OBJECT) {
				char *alt_lower_case_prefix;
				GIdlNodeInterface *ginode = (GIdlNodeInterface *) g_idl_node_new (G_IDL_NODE_OBJECT);
				ginode->node.name = g_strdup (g_type_name (type_id));
				igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, ginode, (GCompareFunc) g_idl_node_cmp);
				g_hash_table_insert (igenerator->type_map, ginode->node.name, ginode);
				g_hash_table_insert (igenerator->type_by_lower_case_prefix, lower_case_prefix, ginode);
				alt_lower_case_prefix = g_ascii_strdown (ginode->node.name, -1);
				if (strcmp (alt_lower_case_prefix, lower_case_prefix) != 0) {
					/* alternative prefix sometimes necessary, for example for GdkWindow  */
					g_hash_table_insert (igenerator->type_by_lower_case_prefix, alt_lower_case_prefix, ginode);
				} else {
					g_free (alt_lower_case_prefix);
				}
				ginode->gtype_name = ginode->node.name;
				ginode->gtype_init = get_type_symbol;
				ginode->parent = g_strdup (g_type_name (g_type_parent (type_id)));
			
				guint n_type_interfaces;
				GType *type_interfaces = g_type_interfaces (type_id, &n_type_interfaces);
				for (i = 0; i < n_type_interfaces; i++) {
					char *iface_name = g_strdup (g_type_name (type_interfaces[i]));
					/* workaround for AtkImplementorIface */
					if (g_str_has_suffix (iface_name, "Iface")) {
						iface_name[strlen (iface_name) - strlen ("Iface")] = '\0';
					}
					ginode->interfaces = g_list_append (ginode->interfaces, iface_name);
				}

				g_igenerator_process_properties (igenerator, ginode, type_id);
				g_igenerator_process_signals (igenerator, ginode, type_id);
			} else if (type_fundamental == G_TYPE_INTERFACE) {
				GIdlNodeInterface *ginode = (GIdlNodeInterface *) g_idl_node_new (G_IDL_NODE_INTERFACE);
				ginode->node.name = g_strdup (g_type_name (type_id));
				/* workaround for AtkImplementorIface */
				if (g_str_has_suffix (ginode->node.name, "Iface")) {
					ginode->node.name[strlen (ginode->node.name) - strlen ("Iface")] = '\0';
				}
				igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, ginode, (GCompareFunc) g_idl_node_cmp);
				g_hash_table_insert (igenerator->type_map, ginode->node.name, ginode);
				g_hash_table_insert (igenerator->type_by_lower_case_prefix, lower_case_prefix, ginode);
				ginode->gtype_name = ginode->node.name;
				ginode->gtype_init = get_type_symbol;
			
				gboolean is_gobject = FALSE;
				guint n_iface_prereqs;
				GType *iface_prereqs = g_type_interface_prerequisites (type_id, &n_iface_prereqs);
				for (i = 0; i < n_iface_prereqs; i++) {
					if (g_type_fundamental (iface_prereqs[i]) == G_TYPE_OBJECT) {
						is_gobject = TRUE;
					}
					ginode->prerequisites = g_list_append (ginode->prerequisites, g_strdup (g_type_name (iface_prereqs[i])));
				}

				if (is_gobject) {
					g_igenerator_process_properties (igenerator, ginode, type_id);
				} else {
					g_type_default_interface_ref (type_id);
				}
				g_igenerator_process_signals (igenerator, ginode, type_id);
			} else if (type_fundamental == G_TYPE_BOXED) {
				GIdlNodeBoxed *ginode = (GIdlNodeBoxed *) g_idl_node_new (G_IDL_NODE_BOXED);
				ginode->node.name = g_strdup (g_type_name (type_id));
				igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, ginode, (GCompareFunc) g_idl_node_cmp);
				g_hash_table_insert (igenerator->type_map, ginode->node.name, ginode);
				g_hash_table_insert (igenerator->type_by_lower_case_prefix, lower_case_prefix, ginode);
				ginode->gtype_name = ginode->node.name;
				ginode->gtype_init = get_type_symbol;
			} else if (type_fundamental == G_TYPE_ENUM) {
				GIdlNodeEnum *ginode = (GIdlNodeEnum *) g_idl_node_new (G_IDL_NODE_ENUM);
				ginode->node.name = g_strdup (g_type_name (type_id));
				igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, ginode, (GCompareFunc) g_idl_node_cmp);
				g_hash_table_insert (igenerator->type_map, ginode->node.name, ginode);
				g_hash_table_insert (igenerator->type_by_lower_case_prefix, lower_case_prefix, ginode);
				ginode->gtype_name = ginode->node.name;
				ginode->gtype_init = get_type_symbol;

				GEnumClass *type_class = g_type_class_ref (type_id);
				for (i = 0; i < type_class->n_values; i++) {
					GIdlNodeValue *gival = (GIdlNodeValue *) g_idl_node_new (G_IDL_NODE_VALUE);
					ginode->values = g_list_append (ginode->values, gival);
					gival->node.name = g_strdup (type_class->values[i].value_name);
					gival->value = type_class->values[i].value;
				}
			} else if (type_fundamental == G_TYPE_FLAGS) {
				GIdlNodeEnum *ginode = (GIdlNodeEnum *) g_idl_node_new (G_IDL_NODE_FLAGS);
				ginode->node.name = g_strdup (g_type_name (type_id));
				igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, ginode, (GCompareFunc) g_idl_node_cmp);
				g_hash_table_insert (igenerator->type_map, ginode->node.name, ginode);
				g_hash_table_insert (igenerator->type_by_lower_case_prefix, lower_case_prefix, ginode);
				ginode->gtype_name = ginode->node.name;
				ginode->gtype_init = get_type_symbol;

				GFlagsClass *type_class = g_type_class_ref (type_id);
				for (i = 0; i < type_class->n_values; i++) {
					GIdlNodeValue *gival = (GIdlNodeValue *) g_idl_node_new (G_IDL_NODE_VALUE);
					ginode->values = g_list_append (ginode->values, gival);
					gival->node.name = g_strdup (type_class->values[i].value_name);
					gival->value = type_class->values[i].value;
				}
			}
		}
	}
}

static GIdlNodeType *get_type_from_ctype (CType *ctype)
{
	GIdlNodeType *gitype = (GIdlNodeType *) g_idl_node_new (G_IDL_NODE_TYPE);
	if (ctype->type == CTYPE_VOID) {
		gitype->unparsed = g_strdup ("void");
	} else if (ctype->type == CTYPE_BASIC_TYPE) {
		gitype->unparsed = g_strdup (ctype->name);
	} else if (ctype->type == CTYPE_TYPEDEF) {
		gitype->unparsed = g_strdup (ctype->name);
	} else if (ctype->type == CTYPE_STRUCT) {
		if (ctype->name == NULL) {
			/* anonymous struct */
			gitype->unparsed = g_strdup ("gpointer");
		} else {
			gitype->unparsed = g_strdup_printf ("struct %s", ctype->name);
		}
	} else if (ctype->type == CTYPE_UNION) {
		if (ctype->name == NULL) {
			/* anonymous union */
			gitype->unparsed = g_strdup ("gpointer");
		} else {
			gitype->unparsed = g_strdup_printf ("union %s", ctype->name);
		}
	} else if (ctype->type == CTYPE_ENUM) {
		if (ctype->name == NULL) {
			/* anonymous enum */
			gitype->unparsed = g_strdup ("gint");
		} else {
			gitype->unparsed = g_strdup_printf ("enum %s", ctype->name);
		}
	} else if (ctype->type == CTYPE_POINTER) {
		if (ctype->base_type->type == CTYPE_FUNCTION) {
			/* anonymous function pointer */
			gitype->unparsed = g_strdup ("GCallback");
		} else {
			GIdlNodeType *gibasetype = get_type_from_ctype (ctype->base_type);
			gitype->unparsed = g_strdup_printf ("%s*", gibasetype->unparsed);
		}
	} else if (ctype->type == CTYPE_ARRAY) {
		GIdlNodeType *gibasetype = get_type_from_ctype (ctype->base_type);
		gitype->unparsed = g_strdup_printf ("%s[]", gibasetype->unparsed);
	} else {
		gitype->unparsed = g_strdup ("unknown");
	}
	return gitype;
}

static void g_igenerator_process_function_symbol (GIGenerator *igenerator, CSymbol *sym)
{
	GIdlNodeFunction *gifunc = (GIdlNodeFunction *) g_idl_node_new (G_IDL_NODE_FUNCTION);
	/* check whether this is a type method */
	char *last_underscore = strrchr (sym->ident, '_');
	while (last_underscore != NULL) {
		char *prefix = str_replace (g_strndup (sym->ident, last_underscore - sym->ident), "_", "");
		GIdlNode *ginode = g_hash_table_lookup (igenerator->type_by_lower_case_prefix, prefix);
		if (ginode != NULL) {
			gifunc->node.name = g_strdup (last_underscore + 1);
			if (strcmp (gifunc->node.name, "get_type") == 0) {
				/* ignore get_type functions in registered types */
				return;
			}
			if ((ginode->type == G_IDL_NODE_OBJECT || ginode->type == G_IDL_NODE_BOXED) && g_str_has_prefix (gifunc->node.name, "new")) {
				gifunc->is_constructor = TRUE;
			} else {
				gifunc->is_method = TRUE;
			}
			if (ginode->type == G_IDL_NODE_OBJECT || ginode->type == G_IDL_NODE_INTERFACE) {
				GIdlNodeInterface *giiface = (GIdlNodeInterface *) ginode;
				giiface->members = g_list_insert_sorted (giiface->members, gifunc, (GCompareFunc) g_idl_node_cmp);
				break;
			} else if (ginode->type == G_IDL_NODE_BOXED) {
				GIdlNodeBoxed *giboxed = (GIdlNodeBoxed *) ginode;
				giboxed->members = g_list_insert_sorted (giboxed->members, gifunc, (GCompareFunc) g_idl_node_cmp);
				break;
			} else if (ginode->type == G_IDL_NODE_STRUCT) {
				GIdlNodeStruct *gistruct = (GIdlNodeStruct *) ginode;
				gistruct->members = g_list_insert_sorted (gistruct->members, gifunc, (GCompareFunc) g_idl_node_cmp);
				break;
			} else if (ginode->type == G_IDL_NODE_UNION) {
				GIdlNodeUnion *giunion = (GIdlNodeUnion *) ginode;
				giunion->members = g_list_insert_sorted (giunion->members, gifunc, (GCompareFunc) g_idl_node_cmp);
				break;
			}
		} else if (strcmp (igenerator->lower_case_namespace, prefix) == 0) {
			gifunc->node.name = g_strdup (last_underscore + 1);
			gifunc->is_constructor = FALSE;
			gifunc->is_method = FALSE;
			igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, gifunc, (GCompareFunc) g_idl_node_cmp);
			break;
		}
		last_underscore = g_utf8_strrchr (sym->ident, last_underscore - sym->ident, '_');
	}
	
	/* create a namespace function if no prefix matches */
	if (gifunc->node.name == NULL) {
		gifunc->node.name = sym->ident;
		gifunc->is_constructor = FALSE;
		gifunc->is_method = FALSE;
		igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, gifunc, (GCompareFunc) g_idl_node_cmp);
	}

	gifunc->symbol = sym->ident;
	gifunc->result = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
	gifunc->result->type = get_type_from_ctype (sym->base_type->base_type);
	GList *param_l;
	for (param_l = sym->base_type->child_list; param_l != NULL; param_l = param_l->next) {
		CSymbol *param_sym = param_l->data;
		GIdlNodeParam *param = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
		param->node.name = param_sym->ident;
		param->type = get_type_from_ctype (param_sym->base_type);
		gifunc->parameters = g_list_append (gifunc->parameters, param);
	}
}

static void g_igenerator_process_unregistered_struct_typedef (GIGenerator *igenerator, CSymbol *sym, CType *struct_type)
{
	GIdlNodeStruct *ginode = (GIdlNodeStruct *) g_idl_node_new (G_IDL_NODE_STRUCT);
	ginode->node.name = sym->ident;
	igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, ginode, (GCompareFunc) g_idl_node_cmp);
	char *lower_case_prefix = g_ascii_strdown (sym->ident, -1);
	g_hash_table_insert (igenerator->type_map, sym->ident, ginode);
	g_hash_table_insert (igenerator->type_by_lower_case_prefix, lower_case_prefix, ginode);

	GList *member_l;
	for (member_l = struct_type->child_list; member_l != NULL; member_l = member_l->next) {
		CSymbol *member = member_l->data;
		GIdlNodeField *gifield = (GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);
		ginode->members = g_list_append (ginode->members, gifield);
		gifield->node.name = member->ident;
		gifield->type = get_type_from_ctype (member->base_type);
	}
}

static void g_igenerator_process_struct_typedef (GIGenerator *igenerator, CSymbol *sym)
{
	CType *struct_type = sym->base_type;
	gboolean opaque_type = FALSE;
	if (struct_type->child_list == NULL) {
		g_assert (struct_type->name != NULL);
		CSymbol *struct_symbol = g_hash_table_lookup (igenerator->struct_or_union_or_enum_table, struct_type->name);
		if (struct_symbol != NULL) {
			struct_type = struct_symbol->base_type;
		}
	}
	if (struct_type->child_list == NULL) {
		opaque_type = TRUE;
	}
	GIdlNode *gitype = g_hash_table_lookup (igenerator->type_map, sym->ident);
	if (gitype != NULL) {
		/* struct of a GTypeInstance */
		if (!opaque_type && (gitype->type == G_IDL_NODE_OBJECT || gitype->type == G_IDL_NODE_INTERFACE)) {
			GIdlNodeInterface *ginode = (GIdlNodeInterface *) gitype;
			GList *member_l;
			/* ignore first field => parent */
			for (member_l = struct_type->child_list->next; member_l != NULL; member_l = member_l->next) {
				CSymbol *member = member_l->data;
				/* ignore private / reserved members */
				if (member->ident[0] == '_' || g_str_has_prefix (member->ident, "priv")) {
					continue;
				}
				GIdlNodeField *gifield = (GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);
				ginode->members = g_list_append (ginode->members, gifield);
				gifield->node.name = member->ident;
				gifield->type = get_type_from_ctype (member->base_type);
			}
		} else if (gitype->type == G_IDL_NODE_BOXED) {
			GIdlNodeBoxed *ginode = (GIdlNodeBoxed *) gitype;
			GList *member_l;
			for (member_l = struct_type->child_list; member_l != NULL; member_l = member_l->next) {
				CSymbol *member = member_l->data;
				GIdlNodeField *gifield = (GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);
				ginode->members = g_list_append (ginode->members, gifield);
				gifield->node.name = member->ident;
				gifield->type = get_type_from_ctype (member->base_type);
			}
		}
	} else if (!opaque_type && (g_str_has_suffix (sym->ident, "Class") || g_str_has_suffix (sym->ident, "Iface"))) {
		char *base_name = g_strndup (sym->ident, strlen (sym->ident) - 5);
		gitype = g_hash_table_lookup (igenerator->type_map, base_name);
		if (gitype == NULL || (gitype->type != G_IDL_NODE_OBJECT && gitype->type != G_IDL_NODE_INTERFACE)) {
			g_igenerator_process_unregistered_struct_typedef (igenerator, sym, struct_type);
			return;
		}
		GIdlNodeInterface *ginode = (GIdlNodeInterface *) gitype;

		/* ignore first field => parent */
		GList *member_l;
		for (member_l = struct_type->child_list->next; member_l != NULL; member_l = member_l->next) {
			CSymbol *member = member_l->data;
			/* ignore private / reserved members */
			if (member->ident[0] == '_') {
				continue;
			}
			if (member->base_type->type == CTYPE_POINTER && member->base_type->base_type->type == CTYPE_FUNCTION) {
				/* ignore default handlers of signals */
				gboolean found_signal = FALSE;
				GList *type_member_l;
				for (type_member_l = ginode->members; type_member_l != NULL; type_member_l = type_member_l->next) {
					GIdlNode *type_member = type_member_l->data;
					char *normalized_name = str_replace (type_member->name, "-", "_");
					if (type_member->type == G_IDL_NODE_SIGNAL && strcmp (normalized_name, member->ident) == 0) {
						GList *vfunc_param_l;
						GList *sig_param_l;
						GIdlNodeSignal *sig = (GIdlNodeSignal *) type_member;
						found_signal = TRUE;
						/* set signal parameter names */
						for (vfunc_param_l = member->base_type->base_type->child_list, sig_param_l = sig->parameters; vfunc_param_l != NULL && sig_param_l != NULL; vfunc_param_l = vfunc_param_l->next, sig_param_l = sig_param_l->next) {
							CSymbol *vfunc_param = vfunc_param_l->data;
							GIdlNodeParam *sig_param = sig_param_l->data;
							g_free (sig_param->node.name);
							sig_param->node.name = g_strdup (vfunc_param->ident);
						}
						break;
					}
				}
				if (found_signal) {
					continue;
				}

				GIdlNodeVFunc *givfunc = (GIdlNodeVFunc *) g_idl_node_new (G_IDL_NODE_VFUNC);
				givfunc->node.name = member->ident;
				ginode->members = g_list_insert_sorted (ginode->members, givfunc, (GCompareFunc) g_idl_node_cmp);
				givfunc->result = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
				givfunc->result->type = get_type_from_ctype (member->base_type->base_type->base_type);
				GList *param_l;
				for (param_l = member->base_type->base_type->child_list; param_l != NULL; param_l = param_l->next) {
					CSymbol *param_sym = param_l->data;
					GIdlNodeParam *param = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
					param->node.name = param_sym->ident;
					param->type = get_type_from_ctype (param_sym->base_type);
					givfunc->parameters = g_list_append (givfunc->parameters, param);
				}
			}
		}
	} else if (g_str_has_suffix (sym->ident, "Private")) {
		/* ignore private structs */
	} else {
		g_igenerator_process_unregistered_struct_typedef (igenerator, sym, struct_type);
	}
}

static void g_igenerator_process_union_typedef (GIGenerator *igenerator, CSymbol *sym)
{
	CType *union_type = sym->base_type;
	gboolean opaque_type = FALSE;
	if (union_type->child_list == NULL) {
		g_assert (union_type->name != NULL);
		CSymbol *union_symbol = g_hash_table_lookup (igenerator->struct_or_union_or_enum_table, union_type->name);
		if (union_symbol != NULL) {
			union_type = union_symbol->base_type;
		}
	}
	if (union_type->child_list == NULL) {
		opaque_type = TRUE;
	}
	GIdlNode *gitype = g_hash_table_lookup (igenerator->type_map, sym->ident);
	if (gitype != NULL) {
		g_assert (gitype->type == G_IDL_NODE_BOXED);
		GIdlNodeBoxed *ginode = (GIdlNodeBoxed *) gitype;
		GList *member_l;
		for (member_l = union_type->child_list; member_l != NULL; member_l = member_l->next) {
			CSymbol *member = member_l->data;
			GIdlNodeField *gifield = (GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);
			ginode->members = g_list_append (ginode->members, gifield);
			gifield->node.name = member->ident;
			gifield->type = get_type_from_ctype (member->base_type);
		}
	} else {
		GIdlNodeUnion *ginode = (GIdlNodeUnion *) g_idl_node_new (G_IDL_NODE_UNION);
		ginode->node.name = sym->ident;
		igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, ginode, (GCompareFunc) g_idl_node_cmp);
		char *lower_case_prefix = g_ascii_strdown (sym->ident, -1);
		g_hash_table_insert (igenerator->type_map, sym->ident, ginode);
		g_hash_table_insert (igenerator->type_by_lower_case_prefix, lower_case_prefix, ginode);

		ginode->node.name = sym->ident;
		GList *member_l;
		for (member_l = union_type->child_list; member_l != NULL; member_l = member_l->next) {
			CSymbol *member = member_l->data;
			GIdlNodeField *gifield = (GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);
			ginode->members = g_list_append (ginode->members, gifield);
			gifield->node.name = member->ident;
			gifield->type = get_type_from_ctype (member->base_type);
		}
	}
}

static void g_igenerator_process_enum_typedef (GIGenerator *igenerator, CSymbol *sym)
{
	CType *enum_type = sym->base_type;
	if (enum_type->child_list == NULL) {
		g_assert (enum_type->name != NULL);
		CSymbol *enum_symbol = g_hash_table_lookup (igenerator->struct_or_union_or_enum_table, enum_type->name);
		if (enum_symbol != NULL) {
			enum_type = enum_symbol->base_type;
		}
	}
	if (enum_type->child_list == NULL) {
		/* opaque type */
		return;
	}
	GIdlNodeEnum *ginode = g_hash_table_lookup (igenerator->type_map, sym->ident);
	if (ginode != NULL) {
		return;
	}

	ginode = (GIdlNodeEnum *) g_idl_node_new (G_IDL_NODE_ENUM);
	ginode->node.name = sym->ident;
	igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, ginode, (GCompareFunc) g_idl_node_cmp);

	GList *member_l;
	for (member_l = enum_type->child_list; member_l != NULL; member_l = member_l->next) {
		CSymbol *member = member_l->data;
		GIdlNodeValue *gival = (GIdlNodeValue *) g_idl_node_new (G_IDL_NODE_VALUE);
		ginode->values = g_list_append (ginode->values, gival);
		gival->node.name = member->ident;
		gival->value = member->const_int;
	}
}

static void g_igenerator_process_function_typedef (GIGenerator *igenerator, CSymbol *sym)
{
	/* handle callback types */
	GIdlNodeFunction *gifunc = (GIdlNodeFunction *) g_idl_node_new (G_IDL_NODE_CALLBACK);

	gifunc->node.name = sym->ident;
	igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, gifunc, (GCompareFunc) g_idl_node_cmp);

	gifunc->symbol = sym->ident;
	gifunc->result = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
	gifunc->result->type = get_type_from_ctype (sym->base_type->base_type->base_type);
	GList *param_l;
	int i;
	for (param_l = sym->base_type->base_type->child_list, i = 1; param_l != NULL; param_l = param_l->next, i++) {
		CSymbol *param_sym = param_l->data;
		GIdlNodeParam *param = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
		if (param_sym->ident == NULL) {
			param->node.name = g_strdup_printf ("p%d", i);
		} else {
			param->node.name = param_sym->ident;
		}
		param->type = get_type_from_ctype (param_sym->base_type);
		gifunc->parameters = g_list_append (gifunc->parameters, param);
	}
}

static void g_igenerator_process_constant (GIGenerator *igenerator, CSymbol *sym)
{
	GIdlNodeConstant *giconst = (GIdlNodeConstant *) g_idl_node_new (G_IDL_NODE_CONSTANT);
	giconst->node.name = sym->ident;
	igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, giconst, (GCompareFunc) g_idl_node_cmp);

	giconst->type = (GIdlNodeType *) g_idl_node_new (G_IDL_NODE_TYPE);
	if (sym->const_int_set) {
		giconst->type->unparsed = g_strdup ("int");
		giconst->value = g_strdup_printf ("%d", sym->const_int);
	} else if (sym->const_string != NULL) {
		giconst->type->unparsed = g_strdup ("char*");
		giconst->value = sym->const_string;
	}
}

static void g_igenerator_process_symbols (GIGenerator *igenerator)
{
	GList *l;
	/* process type symbols first to ensure complete type hashtables */
	/* type symbols */
	for (l = igenerator->symbol_list; l != NULL; l = l->next) {
		CSymbol *sym = l->data;
		if (sym->ident[0] == '_') {
			/* ignore private / reserved symbols */
			continue;
		}
		if (sym->type == CSYMBOL_TYPE_TYPEDEF) {
			if (sym->base_type->type == CTYPE_STRUCT) {
				g_igenerator_process_struct_typedef (igenerator, sym);
			} else if (sym->base_type->type == CTYPE_UNION) {
				g_igenerator_process_union_typedef (igenerator, sym);
			} else if (sym->base_type->type == CTYPE_ENUM) {
				g_igenerator_process_enum_typedef (igenerator, sym);
			} else if (sym->base_type->type == CTYPE_POINTER && sym->base_type->base_type->type == CTYPE_FUNCTION) {
				g_igenerator_process_function_typedef (igenerator, sym);
			} else {
				GIdlNodeStruct *ginode = (GIdlNodeStruct *) g_idl_node_new (G_IDL_NODE_STRUCT);
				ginode->node.name = sym->ident;
				igenerator->module->entries = g_list_insert_sorted (igenerator->module->entries, ginode, (GCompareFunc) g_idl_node_cmp);
				char *lower_case_prefix = g_ascii_strdown (sym->ident, -1);
				g_hash_table_insert (igenerator->type_map, sym->ident, ginode);
				g_hash_table_insert (igenerator->type_by_lower_case_prefix, lower_case_prefix, ginode);
			}
		}
	}
	/* other symbols */
	for (l = igenerator->symbol_list; l != NULL; l = l->next) {
		CSymbol *sym = l->data;
		if (sym->ident[0] == '_') {
			/* ignore private / reserved symbols */
			continue;
		}
		if (sym->type == CSYMBOL_TYPE_FUNCTION) {
			g_igenerator_process_function_symbol (igenerator, sym);
		} else if (sym->type == CSYMBOL_TYPE_CONST) {
			g_igenerator_process_constant (igenerator, sym);
		}
	}
}

void g_igenerator_add_symbol (GIGenerator *igenerator, CSymbol *symbol)
{
	/* only add symbols of main file */
	gboolean found_filename = FALSE;
	GList *l;
	for (l = igenerator->filenames; l != NULL; l = l->next) {
		if (strcmp (g_path_get_basename (l->data), g_path_get_basename (igenerator->current_filename)) == 0) {
			found_filename = TRUE;
			break;
		}
	}
	if (found_filename || igenerator->macro_scan) {
		igenerator->symbol_list = g_list_prepend (igenerator->symbol_list, symbol);
	}

	if (symbol->type == CSYMBOL_TYPE_TYPEDEF) {
		g_hash_table_insert (igenerator->typedef_table, symbol->ident, symbol);
	} else if (symbol->type == CSYMBOL_TYPE_STRUCT || symbol->type == CSYMBOL_TYPE_UNION || symbol->type == CSYMBOL_TYPE_ENUM) {
		g_hash_table_insert (igenerator->struct_or_union_or_enum_table, symbol->ident, symbol);
	}
}

gboolean g_igenerator_is_typedef (GIGenerator *igenerator, const char *name)
{
	gboolean b = g_hash_table_lookup (igenerator->typedef_table, name) != NULL;
	return b;
}

void g_igenerator_generate (GIGenerator *igenerator)
{
	GList *l;
	for (l = igenerator->symbol_list; l != NULL; l = l->next) {
		CSymbol *sym = l->data;
		if (sym->type == CSYMBOL_TYPE_FUNCTION && g_str_has_suffix (sym->ident, "_get_type")) {
			if (sym->base_type->child_list == NULL) {
				// ignore get_type functions with parameters
				igenerator->get_type_symbols = g_list_prepend (igenerator->get_type_symbols, sym->ident);
			}
		}
	}
	g_igenerator_process_types (igenerator);
	g_igenerator_process_symbols (igenerator);

	g_igenerator_write (igenerator, "<?xml version=\"1.0\"?>\n");
	g_igenerator_write_indent (igenerator, "<api version=\"1.0\">\n");
	module_generate (igenerator, igenerator->module);
	g_igenerator_write_unindent (igenerator, "</api>\n");
}

int main (int argc, char **argv)
{
	g_type_init ();

	GIGenerator *igenerator = g_igenerator_new ();

	int cpp_argc = 0;
	char **cpp_argv = g_new0 (char *, argc + 2);
	cpp_argv[cpp_argc++] = "cc";
	cpp_argv[cpp_argc++] = "-E";

	int i;
	for (i = 1; i < argc; i++) {
		if (argv[i][0] == '-') {
			switch (argv[i][1]) {
			case '-':
				if (g_str_has_prefix (argv[i], "--namespace=")) {
					igenerator->namespace = argv[i] + strlen ("--namespace=");
					g_free (igenerator->lower_case_namespace);
					igenerator->lower_case_namespace = g_ascii_strdown (igenerator->namespace, -1);
				}
				break;
			case 'I':
			case 'D':
			case 'U':
				cpp_argv[cpp_argc++] = argv[i];
				break;
			}
		} else if (g_str_has_suffix (argv[i], ".h")) {
			igenerator->filenames = g_list_append (igenerator->filenames, argv[i]);
		} else if (g_str_has_suffix (argv[i], ".la") ||
		           g_str_has_suffix (argv[i], ".so") ||
		           g_str_has_suffix (argv[i], ".dll")) {
			igenerator->libraries = g_list_append (igenerator->libraries, argv[i]);
		}
	}


	GError *error = NULL;

	char *tmp_name = NULL;
	FILE *f= fdopen (g_file_open_tmp ("gen-introspect-XXXXXX.h", &tmp_name, &error), "w");


	GList *l;
	for (l = igenerator->filenames; l != NULL; l = l->next) {
		fprintf (f, "#include <%s>\n", (char *) l->data);
	}


	fclose (f);

	cpp_argv[cpp_argc++] = tmp_name;
	cpp_argv[cpp_argc++] = NULL;

	int cpp_out = -1;
	g_spawn_async_with_pipes (NULL, cpp_argv, NULL, G_SPAWN_SEARCH_PATH, NULL, NULL, NULL, NULL, &cpp_out, NULL, &error);
	if (error != NULL) {
		g_error ("%s", error->message);
	}

	g_igenerator_parse (igenerator, fdopen (cpp_out, "r"));

	g_unlink (tmp_name);

	g_igenerator_parse_macros (igenerator);

	igenerator->module = g_idl_module_new (igenerator->namespace);
	g_igenerator_generate (igenerator);

	return 0;
}

CSymbol *csymbol_new (CSymbolType type) {
	CSymbol *s = g_new0 (CSymbol, 1);
	s->type = type;
	return s;
}

gboolean csymbol_get_const_boolean (CSymbol *symbol) {
	return (symbol->const_int_set && symbol->const_int) || symbol->const_string;
}

CType *ctype_new (CTypeType type) {
	CType *t = g_new0 (CType, 1);
	t->type = type;
	return t;
}

CType *ctype_copy (CType *type) {
	return g_memdup (type, sizeof (CType));
}

CType *cbasic_type_new (const char *name) {
	CType *basic_type = ctype_new (CTYPE_BASIC_TYPE);
	basic_type->name = g_strdup (name);
	return basic_type;
}

CType *ctypedef_new (const char *name) {
	CType *typedef_ = ctype_new (CTYPE_TYPEDEF);
	typedef_->name = g_strdup (name);
	return typedef_;
}

CType *cstruct_new (const char *name) {
	CType *struct_ = ctype_new (CTYPE_STRUCT);
	struct_->name = g_strdup (name);
	return struct_;
}

CType *cunion_new (const char *name) {
	CType *union_ = ctype_new (CTYPE_UNION);
	union_->name = g_strdup (name);
	return union_;
}

CType *cenum_new (const char *name) {
	CType *enum_ = ctype_new (CTYPE_ENUM);
	enum_->name = g_strdup (name);
	return enum_;
}

CType *cpointer_new (CType *base_type) {
	CType *pointer = ctype_new (CTYPE_POINTER);
	pointer->base_type = base_type;
	return pointer;
}

CType *carray_new (void) {
	CType *array = ctype_new (CTYPE_ARRAY);
	return array;
}

CType *cfunction_new (void) {
	CType *func = ctype_new (CTYPE_FUNCTION);
	return func;
}

static int eat_hspace (FILE *f) {
	int c;
	do {
		c = fgetc (f);
	} while (c == ' ' || c == '\t');
	return c;
}

static int eat_line (FILE *f, int c) {
	while (c != EOF && c != '\n') {
		c = fgetc (f);
	}
	if (c == '\n') {
		c = fgetc (f);
		if (c == ' ' || c == '\t') {
			c = eat_hspace (f);
		}
	}
	return c;
}

static int read_identifier (FILE *f, int c, char **identifier) {
	GString *id = g_string_new ("");
	while (isalnum (c) || c == '_') {
		g_string_append_c (id, c);
		c = fgetc (f);
	}
	*identifier = g_string_free (id, FALSE);
	return c;
}

static void g_igenerator_parse_macros (GIGenerator *igenerator) {
	GError *error = NULL;
	char *tmp_name = NULL;
	FILE *fmacros = fdopen (g_file_open_tmp ("gen-introspect-XXXXXX.h", &tmp_name, &error), "w+");
	g_unlink (tmp_name);

	GList *l;
	for (l = igenerator->filenames; l != NULL; l = l->next) {
		FILE *f = fopen (l->data, "r");
		int line = 1;

		GString *define_line;
		char *str;
		gboolean error_line = FALSE;
		int c = eat_hspace (f);
		while (c != EOF) {
			if (c != '#') {
				/* ignore line */
				c = eat_line (f, c);
				line++;
				continue;
			}

			/* print current location */
			str = g_strescape (l->data, "");
			fprintf (fmacros, "# %d \"%s\"\n", line, str);
			g_free (str);

			c = eat_hspace (f);
			c = read_identifier (f, c, &str);
			if (strcmp (str, "define") != 0 || (c != ' ' && c != '\t')) {
				g_free (str);
				/* ignore line */
				c = eat_line (f, c);
				line++;
				continue;
			}
			g_free (str);
			c = eat_hspace (f);
			c = read_identifier (f, c, &str);
			if (strlen (str) == 0 || (c != ' ' && c != '\t' && c != '(')) {
				g_free (str);
				/* ignore line */
				c = eat_line (f, c);
				line++;
				continue;
			}
			define_line = g_string_new ("#define ");
			g_string_append (define_line, str);
			g_free (str);
			if (c == '(') {
				while (c != ')') {
					g_string_append_c (define_line, c);
					c = fgetc (f);
					if (c == EOF || c == '\n') {
						error_line = TRUE;
						break;
					}
				}
				if (error_line) {
					g_string_free (define_line, TRUE);
					/* ignore line */
					c = eat_line (f, c);
					line++;
					continue;
				}

				g_assert (c == ')');
				g_string_append_c (define_line, c);
				c = fgetc (f);

				/* found function-like macro */
				fprintf (fmacros, "%s\n", define_line->str);

				g_string_free (define_line, TRUE);
				/* ignore rest of line */
				c = eat_line (f, c);
				line++;
				continue;
			}
			if (c != ' ' && c != '\t') {
				g_string_free (define_line, TRUE);
				/* ignore line */
				c = eat_line (f, c);
				line++;
				continue;
			}
			while (c != EOF && c != '\n') {
				g_string_append_c (define_line, c);
				c = fgetc (f);
				if (c == '\\') {
					c = fgetc (f);
					if (c == '\n') {
						/* fold lines when seeing backslash new-line sequence */
						c = fgetc (f);
					} else {
						g_string_append_c (define_line, '\\');
					}
				}
			}

			/* found object-like macro */
			fprintf (fmacros, "%s\n", define_line->str);

			c = eat_line (f, c);
			line++;
		}

		fclose (f);
	}

	igenerator->macro_scan = TRUE;
	rewind (fmacros);
	g_igenerator_parse (igenerator, fmacros);
	igenerator->macro_scan = FALSE;
}



