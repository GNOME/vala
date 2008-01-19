/* GObject introspection: scanner
 *
 * Copyright (C) 2007-2008  Jürg Billeter
 * Copyright (C) 2007  Johan Dahlin
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

#include <string.h>
#include <ctype.h>
#include <errno.h>
#include <glib.h>
#include <glib/gstdio.h>
#include <glib-object.h>
#include <sys/wait.h> /* waitpid */
#include <gmodule.h>
#include "scanner.h"
#include "gidlparser.h"
#include "gidlmodule.h"
#include "gidlnode.h"
#include "gidlwriter.h"

typedef GType (*TypeFunction) (void);

static void g_igenerator_parse_macros (GIGenerator * igenerator);

static int
g_idl_node_cmp (GIdlNode * a, GIdlNode * b)
{
  if (a->type < b->type)
    {
      return -1;
    }
  else if (a->type > b->type)
    {
      return 1;
    }
  else
    {
      return strcmp (a->name, b->name);
    }
}

static GIGenerator *
g_igenerator_new (const gchar *namespace,
		  const gchar *shared_library)
{
  GIGenerator *igenerator = g_new0 (GIGenerator, 1);
  igenerator->namespace = g_strdup (namespace); 
  igenerator->shared_library = g_strdup (shared_library);
  igenerator->lower_case_namespace =
    g_ascii_strdown (igenerator->namespace, -1);
  igenerator->module = g_idl_module_new (namespace, shared_library);

  igenerator->typedef_table = g_hash_table_new (g_str_hash, g_str_equal);
  igenerator->struct_or_union_or_enum_table =
    g_hash_table_new (g_str_hash, g_str_equal);

  igenerator->type_map = g_hash_table_new (g_str_hash, g_str_equal);
  igenerator->type_by_lower_case_prefix =
    g_hash_table_new (g_str_hash, g_str_equal);
  igenerator->symbols = g_hash_table_new (g_str_hash, g_str_equal);

  return igenerator;
}

static void
g_igenerator_free (GIGenerator *generator)
{
  g_free (generator->namespace);
  g_free (generator->shared_library);
  g_free (generator->lower_case_namespace);
#if 0
  g_idl_module_free (generator->module);
#endif  
  g_hash_table_destroy (generator->typedef_table);
  g_hash_table_destroy (generator->struct_or_union_or_enum_table);
  g_hash_table_destroy (generator->type_map);
  g_hash_table_destroy (generator->type_by_lower_case_prefix);
  g_hash_table_destroy (generator->symbols);
  g_list_foreach (generator->filenames, (GFunc)g_free, NULL);
  g_list_free (generator->filenames);
#if 0
  g_list_foreach (generator->symbol_list, (GFunc)csymbol_free, NULL);
  g_list_free (generator->symbol_list);
#endif
  g_free (generator);
}

static GIdlNodeType *
get_type_from_type_id (GType type_id)
{
  GIdlNodeType *gitype = (GIdlNodeType *) g_idl_node_new (G_IDL_NODE_TYPE);

  GType type_fundamental = g_type_fundamental (type_id);

  if (type_fundamental == G_TYPE_STRING)
    {
      gitype->unparsed = g_strdup ("char*");
    }
  else if (type_id == G_TYPE_STRV)
    {
      gitype->unparsed = g_strdup ("char*[]");
    }
  else if (type_fundamental == G_TYPE_INTERFACE
	   || type_fundamental == G_TYPE_BOXED
	   || type_fundamental == G_TYPE_OBJECT)
    {
      gitype->unparsed = g_strdup_printf ("%s*", g_type_name (type_id));
    }
  else if (type_fundamental == G_TYPE_PARAM)
    {
      gitype->unparsed = g_strdup ("GParamSpec*");
    }
  else
    {
      gitype->unparsed = g_strdup (g_type_name (type_id));
    }

  return gitype;
}

static char *
str_replace (const char *str, const char *needle, const char *replacement)
{
  char **strings = g_strsplit (str, needle, 0);
  char *result = g_strjoinv (replacement, strings);
  g_strfreev (strings);
  return result;
}

static void
g_igenerator_process_properties (GIGenerator * igenerator,
				 GIdlNodeInterface * ginode, GType type_id)
{
  int i;
  guint n_properties;
  GParamSpec **properties;

  if (ginode->node.type == G_IDL_NODE_OBJECT)
    {
      GObjectClass *type_class = g_type_class_ref (type_id);
      properties = g_object_class_list_properties (type_class, &n_properties);
    }
  else if (ginode->node.type == G_IDL_NODE_INTERFACE)
    {
      GTypeInterface *iface = g_type_default_interface_ref (type_id);
      properties = g_object_interface_list_properties (iface, &n_properties);
    }
  else
    {
      g_assert_not_reached ();
    }

  for (i = 0; i < n_properties; i++)
    {
      GIdlNodeProperty *giprop;

      /* ignore inherited properties */
      if (properties[i]->owner_type != type_id)
	{
	  continue;
	}
      giprop = (GIdlNodeProperty *) g_idl_node_new (G_IDL_NODE_PROPERTY);
      giprop->node.name = properties[i]->name;
      ginode->members =
	g_list_insert_sorted (ginode->members, giprop,
			      (GCompareFunc) g_idl_node_cmp);
      giprop->type = get_type_from_type_id (properties[i]->value_type);
      giprop->readable = (properties[i]->flags & G_PARAM_READABLE) != 0;
      giprop->writable = (properties[i]->flags & G_PARAM_WRITABLE) != 0;
      giprop->construct = (properties[i]->flags & G_PARAM_CONSTRUCT) != 0;
      giprop->construct_only =
	(properties[i]->flags & G_PARAM_CONSTRUCT_ONLY) != 0;
    }
}

static void
g_igenerator_process_signals (GIGenerator * igenerator,
			      GIdlNodeInterface * ginode, GType type_id)
{
  int i, j;
  guint n_signal_ids;
  guint *signal_ids = g_signal_list_ids (type_id, &n_signal_ids);

  for (i = 0; i < n_signal_ids; i++)
    {
      GSignalQuery signal_query;
      GIdlNodeSignal *gisig;
      GIdlNodeParam *giparam;
      
      g_signal_query (signal_ids[i], &signal_query);
      gisig = (GIdlNodeSignal *) g_idl_node_new (G_IDL_NODE_SIGNAL);
      gisig->node.name = g_strdup (signal_query.signal_name);
      ginode->members =
	g_list_insert_sorted (ginode->members, gisig,
			      (GCompareFunc) g_idl_node_cmp);

      gisig->run_first =
	(signal_query.signal_flags & G_SIGNAL_RUN_FIRST) != 0;
      gisig->run_last = (signal_query.signal_flags & G_SIGNAL_RUN_LAST) != 0;
      gisig->run_cleanup =
	(signal_query.signal_flags & G_SIGNAL_RUN_CLEANUP) != 0;

      /* add sender parameter */
      giparam = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
      gisig->parameters = g_list_append (gisig->parameters, giparam);
      giparam->node.name = g_strdup ("object");
      giparam->type = get_type_from_type_id (type_id);

      for (j = 0; j < signal_query.n_params; j++)
	{
	  giparam = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
	  gisig->parameters = g_list_append (gisig->parameters, giparam);
	  giparam->node.name = g_strdup_printf ("p%d", j);
	  giparam->type = get_type_from_type_id (signal_query.param_types[j]);
	}
      gisig->result = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
      gisig->result->type = get_type_from_type_id (signal_query.return_type);
    }
}

static const gchar *
lookup_symbol (GIGenerator *igenerator, const gchar *typename)
{
  const gchar *name =
    g_hash_table_lookup (igenerator->symbols, typename);

  if (!name)
    {
      g_printerr ("Unknown symbol: %s\n", typename);
      return typename;
    }

  return name;
}

static void
g_igenerator_create_object (GIGenerator *igenerator,
			    const char *symbol_name,
			    GType type_id,
			    char *lower_case_prefix)

{
  char *alt_lower_case_prefix;
  GIdlNodeInterface *ginode;
  guint n_type_interfaces;
  GType *type_interfaces;
  int i;

  ginode = (GIdlNodeInterface *) g_idl_node_new (G_IDL_NODE_OBJECT);
  ginode->node.name = g_strdup (g_type_name (type_id));
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, ginode,
			  (GCompareFunc) g_idl_node_cmp);
  g_hash_table_insert (igenerator->type_map, ginode->node.name,
		       ginode);
  g_hash_table_insert (igenerator->type_by_lower_case_prefix,
		       lower_case_prefix, ginode);
  alt_lower_case_prefix = g_ascii_strdown (ginode->node.name, -1);
  
  if (strcmp (alt_lower_case_prefix, lower_case_prefix) != 0)
    {
      /* alternative prefix sometimes necessary, for example
       * for GdkWindow
       */
      g_hash_table_insert (igenerator->type_by_lower_case_prefix,
			   alt_lower_case_prefix, ginode);
    }
  else
    {
      g_free (alt_lower_case_prefix);
    }

  ginode->gtype_name = ginode->node.name;
  ginode->gtype_init = g_strdup (symbol_name);
  ginode->parent = g_strdup (lookup_symbol (igenerator,
					    g_type_name (g_type_parent (type_id))));
  
  type_interfaces = g_type_interfaces (type_id, &n_type_interfaces);
  for (i = 0; i < n_type_interfaces; i++)
    {
      char *iface_name =
	g_strdup (g_type_name (type_interfaces[i]));
      /* workaround for AtkImplementorIface */
      if (g_str_has_suffix (iface_name, "Iface"))
	{
	  iface_name[strlen (iface_name) - strlen ("Iface")] =
	    '\0';
	}
      ginode->interfaces =
	g_list_append (ginode->interfaces, iface_name);
    }
  
  g_hash_table_insert (igenerator->symbols,
		       g_strdup (ginode->gtype_name),
		       /* FIXME: Strip igenerator->namespace */
		       g_strdup (ginode->node.name));
  
  g_igenerator_process_properties (igenerator, ginode, type_id);
  g_igenerator_process_signals (igenerator, ginode, type_id);
}

static void
g_igenerator_create_interface (GIGenerator *igenerator,
			       const char *symbol_name,
			       GType type_id,
			       char *lower_case_prefix)

{
  GIdlNodeInterface *ginode;
  gboolean is_gobject = FALSE;
  guint n_iface_prereqs;
  GType *iface_prereqs;
  int i;

  ginode = (GIdlNodeInterface *) g_idl_node_new (G_IDL_NODE_INTERFACE);
  ginode->node.name = g_strdup (g_type_name (type_id));
  
  /* workaround for AtkImplementorIface */
  if (g_str_has_suffix (ginode->node.name, "Iface"))
    {
      ginode->node.name[strlen (ginode->node.name) -
			strlen ("Iface")] = '\0';
    }
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, ginode,
			  (GCompareFunc) g_idl_node_cmp);
  g_hash_table_insert (igenerator->type_map, ginode->node.name,
		       ginode);
  g_hash_table_insert (igenerator->type_by_lower_case_prefix,
		       lower_case_prefix, ginode);
  ginode->gtype_name = ginode->node.name;
  ginode->gtype_init = g_strdup (symbol_name);
  
  iface_prereqs =
    g_type_interface_prerequisites (type_id, &n_iface_prereqs);

  for (i = 0; i < n_iface_prereqs; i++)
    {
      if (g_type_fundamental (iface_prereqs[i]) == G_TYPE_OBJECT)
	{
	  is_gobject = TRUE;
	}
      ginode->prerequisites =
	g_list_append (ginode->prerequisites,
		       g_strdup (g_type_name (iface_prereqs[i])));
    }
  
  if (is_gobject)
    g_igenerator_process_properties (igenerator, ginode, type_id);
  else
    g_type_default_interface_ref (type_id);

  g_igenerator_process_signals (igenerator, ginode, type_id);
}

static void
g_igenerator_create_boxed (GIGenerator *igenerator,
			   const char *symbol_name,
			   GType type_id,
			   char *lower_case_prefix)
{
  GIdlNodeBoxed *ginode =
    (GIdlNodeBoxed *) g_idl_node_new (G_IDL_NODE_BOXED);
  ginode->node.name = g_strdup (g_type_name (type_id));
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, ginode,
			  (GCompareFunc) g_idl_node_cmp);
  g_hash_table_insert (igenerator->type_map, ginode->node.name,
		       ginode);
  g_hash_table_insert (igenerator->type_by_lower_case_prefix,
		       lower_case_prefix, ginode);
  ginode->gtype_name = ginode->node.name;
  ginode->gtype_init = g_strdup (symbol_name);
}

static void
g_igenerator_create_enum (GIGenerator *igenerator,
			  const char *symbol_name,
			  GType type_id,
			  char *lower_case_prefix)
{
  GIdlNodeEnum *ginode;
  int i;
  GEnumClass *type_class;
  
  ginode = (GIdlNodeEnum *) g_idl_node_new (G_IDL_NODE_ENUM);
  ginode->node.name = g_strdup (g_type_name (type_id));
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, ginode,
			  (GCompareFunc) g_idl_node_cmp);
  g_hash_table_insert (igenerator->type_map, ginode->node.name,
		       ginode);
  g_hash_table_insert (igenerator->type_by_lower_case_prefix,
		       lower_case_prefix, ginode);
  ginode->gtype_name = ginode->node.name;
  ginode->gtype_init = g_strdup (symbol_name);
  
  type_class = g_type_class_ref (type_id);

  for (i = 0; i < type_class->n_values; i++)
    {
      GIdlNodeValue *gival =
	(GIdlNodeValue *) g_idl_node_new (G_IDL_NODE_VALUE);
      ginode->values = g_list_append (ginode->values, gival);
      gival->node.name =
	g_strdup (type_class->values[i].value_name);
      gival->value = type_class->values[i].value;
    }
}

static void
g_igenerator_create_flags (GIGenerator *igenerator,
			   const char *symbol_name,
			   GType type_id,
			   char *lower_case_prefix)
{
  GIdlNodeEnum *ginode;
  GFlagsClass *type_class;
  int i;
  
  ginode = (GIdlNodeEnum *) g_idl_node_new (G_IDL_NODE_FLAGS);
  ginode->node.name = g_strdup (g_type_name (type_id));
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, ginode,
			  (GCompareFunc) g_idl_node_cmp);
  g_hash_table_insert (igenerator->type_map, ginode->node.name,
		       ginode);
  g_hash_table_insert (igenerator->type_by_lower_case_prefix,
		       lower_case_prefix, ginode);
  ginode->gtype_name = ginode->node.name;
  ginode->gtype_init = g_strdup (symbol_name);
  
  type_class = g_type_class_ref (type_id);
  
  for (i = 0; i < type_class->n_values; i++)
    {
      GIdlNodeValue *gival =
	(GIdlNodeValue *) g_idl_node_new (G_IDL_NODE_VALUE);
      ginode->values = g_list_append (ginode->values, gival);
      gival->node.name =
	g_strdup (type_class->values[i].value_name);
      gival->value = type_class->values[i].value;
    }
}

static gboolean
g_igenerator_process_module_symbol (GIGenerator *igenerator,
				    GModule *module,
				    const gchar *symbol_name)
{
  TypeFunction type_fun;
  GType type_id;
  GType type_fundamental;
  char *lower_case_prefix;
      
  /* ignore already processed functions */
  if (symbol_name == NULL)
    return FALSE;
      
  if (!g_module_symbol (module,
			symbol_name,
			(gpointer *) & type_fun))
    return FALSE;
      
  type_id = type_fun ();
  type_fundamental = g_type_fundamental (type_id);
  lower_case_prefix =
    str_replace (g_strndup
		 (symbol_name,
		  strlen (symbol_name) - strlen ("_get_type")),
		 "_", "");

  switch (type_fundamental)
    {
    case G_TYPE_OBJECT:
      g_igenerator_create_object (igenerator, symbol_name, type_id,
				  lower_case_prefix);
      break;
    case G_TYPE_INTERFACE:
      g_igenerator_create_interface (igenerator, symbol_name, type_id,
				     lower_case_prefix);
      break;
    case G_TYPE_BOXED:
      g_igenerator_create_boxed (igenerator, symbol_name, type_id,
				 lower_case_prefix);
      break;
    case G_TYPE_ENUM:
      g_igenerator_create_enum (igenerator, symbol_name, type_id,
				lower_case_prefix);
      break;
    case G_TYPE_FLAGS:
      g_igenerator_create_flags (igenerator, symbol_name, type_id,
				 lower_case_prefix);
      break;
    default:
      break;
    }
  return TRUE;
}

static void
g_igenerator_process_module (GIGenerator * igenerator,
			     const gchar *filename)
{
  GModule *module;
  GList *l;
  
  module = g_module_open (filename,
			  G_MODULE_BIND_LAZY | G_MODULE_BIND_LOCAL);
  
  if (module == NULL)
    {
      g_critical ("Couldn't open module: %s", filename);
      return;
    }

  for (l = igenerator->get_type_symbols; l != NULL; l = l->next)
    {
      if (g_igenerator_process_module_symbol (igenerator,
					      module, (const char *)l->data))
	/* symbol found, ignore in future iterations */
	l->data = NULL;
    }
}

static GIdlNodeType *
get_type_from_ctype (CType * ctype)
{
  GIdlNodeType *gitype = (GIdlNodeType *) g_idl_node_new (G_IDL_NODE_TYPE);
  if (ctype->type == CTYPE_VOID)
    {
      gitype->unparsed = g_strdup ("void");
    }
  else if (ctype->type == CTYPE_BASIC_TYPE)
    {
      gitype->unparsed = g_strdup (ctype->name);
    }
  else if (ctype->type == CTYPE_TYPEDEF)
    {
      gitype->unparsed = g_strdup (ctype->name);
    }
  else if (ctype->type == CTYPE_STRUCT)
    {
      if (ctype->name == NULL)
	{
	  /* anonymous struct */
	  gitype->unparsed = g_strdup ("gpointer");
	}
      else
	{
	  gitype->unparsed = g_strdup_printf ("struct %s", ctype->name);
	}
    }
  else if (ctype->type == CTYPE_UNION)
    {
      if (ctype->name == NULL)
	{
	  /* anonymous union */
	  gitype->unparsed = g_strdup ("gpointer");
	}
      else
	{
	  gitype->unparsed = g_strdup_printf ("union %s", ctype->name);
	}
    }
  else if (ctype->type == CTYPE_ENUM)
    {
      if (ctype->name == NULL)
	{
	  /* anonymous enum */
	  gitype->unparsed = g_strdup ("gint");
	}
      else
	{
	  gitype->unparsed = g_strdup_printf ("enum %s", ctype->name);
	}
    }
  else if (ctype->type == CTYPE_POINTER)
    {
      if (ctype->base_type->type == CTYPE_FUNCTION)
	{
	  /* anonymous function pointer */
	  gitype->unparsed = g_strdup ("GCallback");
	}
      else
	{
	  GIdlNodeType *gibasetype = get_type_from_ctype (ctype->base_type);
	  gitype->unparsed = g_strdup_printf ("%s*", gibasetype->unparsed);
	}
    }
  else if (ctype->type == CTYPE_ARRAY)
    {
      GIdlNodeType *gibasetype = get_type_from_ctype (ctype->base_type);
      gitype->unparsed = g_strdup_printf ("%s[]", gibasetype->unparsed);
    }
  else
    {
      gitype->unparsed = g_strdup ("unknown");
    }
  return gitype;
}

static void
g_igenerator_process_function_symbol (GIGenerator * igenerator, CSymbol * sym)
{
  GIdlNodeFunction *gifunc =
    (GIdlNodeFunction *) g_idl_node_new (G_IDL_NODE_FUNCTION);
  /* check whether this is a type method */
  char *last_underscore = strrchr (sym->ident, '_');
  GList *param_l;
  int i;
  GSList *l;

  while (last_underscore != NULL)
    {
      char *prefix =
	str_replace (g_strndup (sym->ident, last_underscore - sym->ident),
		     "_", "");
      GIdlNode *ginode =
	g_hash_table_lookup (igenerator->type_by_lower_case_prefix, prefix);
      if (ginode != NULL)
	{
	  gifunc->node.name = g_strdup (last_underscore + 1);
	  if (strcmp (gifunc->node.name, "get_type") == 0)
	    {
	      /* ignore get_type functions in registered types */
	      return;
	    }
	  if ((ginode->type == G_IDL_NODE_OBJECT
	       || ginode->type == G_IDL_NODE_BOXED)
	      && g_str_has_prefix (gifunc->node.name, "new"))
	    {
	      gifunc->is_constructor = TRUE;
	    }
	  else
	    {
	      gifunc->is_method = TRUE;
	    }
	  if (ginode->type == G_IDL_NODE_OBJECT
	      || ginode->type == G_IDL_NODE_INTERFACE)
	    {
	      GIdlNodeInterface *giiface = (GIdlNodeInterface *) ginode;
	      giiface->members =
		g_list_insert_sorted (giiface->members, gifunc,
				      (GCompareFunc) g_idl_node_cmp);
	      break;
	    }
	  else if (ginode->type == G_IDL_NODE_BOXED)
	    {
	      GIdlNodeBoxed *giboxed = (GIdlNodeBoxed *) ginode;
	      giboxed->members =
		g_list_insert_sorted (giboxed->members, gifunc,
				      (GCompareFunc) g_idl_node_cmp);
	      break;
	    }
	  else if (ginode->type == G_IDL_NODE_STRUCT)
	    {
	      GIdlNodeStruct *gistruct = (GIdlNodeStruct *) ginode;
	      gistruct->members =
		g_list_insert_sorted (gistruct->members, gifunc,
				      (GCompareFunc) g_idl_node_cmp);
	      break;
	    }
	  else if (ginode->type == G_IDL_NODE_UNION)
	    {
	      GIdlNodeUnion *giunion = (GIdlNodeUnion *) ginode;
	      giunion->members =
		g_list_insert_sorted (giunion->members, gifunc,
				      (GCompareFunc) g_idl_node_cmp);
	      break;
	    }
	}
      else if (strcmp (igenerator->lower_case_namespace, prefix) == 0)
	{
	  gifunc->node.name = g_strdup (last_underscore + 1);
	  gifunc->is_constructor = FALSE;
	  gifunc->is_method = FALSE;
	  igenerator->module->entries =
	    g_list_insert_sorted (igenerator->module->entries, gifunc,
				  (GCompareFunc) g_idl_node_cmp);
	  break;
	}
      last_underscore =
	g_utf8_strrchr (sym->ident, last_underscore - sym->ident, '_');
    }

  /* create a namespace function if no prefix matches */
  if (gifunc->node.name == NULL)
    {
      gifunc->node.name = sym->ident;
      gifunc->is_constructor = FALSE;
      gifunc->is_method = FALSE;
      igenerator->module->entries =
	g_list_insert_sorted (igenerator->module->entries, gifunc,
			      (GCompareFunc) g_idl_node_cmp);
    }

  gifunc->symbol = sym->ident;
  gifunc->result = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
  gifunc->result->type = get_type_from_ctype (sym->base_type->base_type);

  for (param_l = sym->base_type->child_list, i = 1; param_l != NULL;
       param_l = param_l->next, i++)
    {
      CSymbol *param_sym = param_l->data;
      GIdlNodeParam *param =
	(GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
      if (param_sym->ident == NULL)
	{
	  param->node.name = g_strdup_printf ("p%d", i);
	}
      else
	{
	  param->node.name = param_sym->ident;
	}
      param->type = get_type_from_ctype (param_sym->base_type);
      gifunc->parameters = g_list_append (gifunc->parameters, param);
    }

  for (l = sym->directives; l; l = l->next)
    {
      CDirective *directive = (CDirective*)l->data;

      if (!strcmp (directive->name, "deprecated"))
	gifunc->deprecated = strcmp (directive->value, "1") == 0;
      else
	g_printerr ("Unknown function directive: %s\n",
		    directive->name);
    }
}

static void
g_igenerator_process_unregistered_struct_typedef (GIGenerator * igenerator,
						  CSymbol * sym,
						  CType * struct_type)
{
  GIdlNodeStruct *ginode =
    (GIdlNodeStruct *) g_idl_node_new (G_IDL_NODE_STRUCT);
  GList *member_l;
  char *lower_case_prefix;

  ginode->node.name = sym->ident;
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, ginode,
			  (GCompareFunc) g_idl_node_cmp);
  lower_case_prefix = g_ascii_strdown (sym->ident, -1);

  /* support type_t naming convention */
  if (g_str_has_suffix (lower_case_prefix, "_t"))
    {
      char *tmp = lower_case_prefix;
      tmp[strlen (tmp) - strlen ("_t")] = '\0';
      lower_case_prefix = str_replace (tmp, "_", "");
      g_free (tmp);
    }

  g_hash_table_insert (igenerator->type_map, sym->ident, ginode);
  g_hash_table_insert (igenerator->type_by_lower_case_prefix,
		       lower_case_prefix, ginode);

  for (member_l = struct_type->child_list; member_l != NULL;
       member_l = member_l->next)
    {
      CSymbol *member = member_l->data;
      GIdlNodeField *gifield =
	(GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);

      ginode->members = g_list_append (ginode->members, gifield);
      gifield->node.name = member->ident;
      gifield->type = get_type_from_ctype (member->base_type);
    }
}

static void
g_igenerator_process_struct_typedef (GIGenerator * igenerator, CSymbol * sym)
{
  CType *struct_type = sym->base_type;
  gboolean opaque_type = FALSE;
  GIdlNode *gitype;
  
  if (struct_type->child_list == NULL)
    {
      CSymbol *struct_symbol;
      g_assert (struct_type->name != NULL);
      struct_symbol =
	g_hash_table_lookup (igenerator->struct_or_union_or_enum_table,
			     struct_type->name);
      if (struct_symbol != NULL)
	{
	  struct_type = struct_symbol->base_type;
	}
    }

  if (struct_type->child_list == NULL)
    {
      opaque_type = TRUE;
    }
  
  gitype = g_hash_table_lookup (igenerator->type_map, sym->ident);
  if (gitype != NULL)
    {
      /* struct of a GTypeInstance */
      if (!opaque_type
	  && (gitype->type == G_IDL_NODE_OBJECT
	      || gitype->type == G_IDL_NODE_INTERFACE))
	{
	  GIdlNodeInterface *ginode = (GIdlNodeInterface *) gitype;
	  GList *member_l;
	  /* ignore first field => parent */
	  for (member_l = struct_type->child_list->next; member_l != NULL;
	       member_l = member_l->next)
	    {
	      CSymbol *member = member_l->data;
	      /* ignore private / reserved members */
	      if (member->ident[0] == '_'
		  || g_str_has_prefix (member->ident, "priv"))
		{
		  continue;
		}
	      GIdlNodeField *gifield =
		(GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);
	      ginode->members = g_list_append (ginode->members, gifield);
	      gifield->node.name = member->ident;
	      gifield->type = get_type_from_ctype (member->base_type);
	    }
	}
      else if (gitype->type == G_IDL_NODE_BOXED)
	{
	  GIdlNodeBoxed *ginode = (GIdlNodeBoxed *) gitype;
	  GList *member_l;
	  for (member_l = struct_type->child_list; member_l != NULL;
	       member_l = member_l->next)
	    {
	      CSymbol *member = member_l->data;
	      GIdlNodeField *gifield =
		(GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);
	      ginode->members = g_list_append (ginode->members, gifield);
	      gifield->node.name = member->ident;
	      gifield->type = get_type_from_ctype (member->base_type);
	    }
	}
    }
  else if (!opaque_type
	   && (g_str_has_suffix (sym->ident, "Class")
	       || g_str_has_suffix (sym->ident, "Iface")
	       || g_str_has_suffix (sym->ident, "Interface")))
    {
      char *base_name;
      GList *member_l;
      GIdlNodeInterface *ginode;

      if (g_str_has_suffix (sym->ident, "Interface"))
	{
	  base_name =
	    g_strndup (sym->ident,
		       strlen (sym->ident) - strlen ("Interface"));
	}
      else
	{
	  base_name =
	    g_strndup (sym->ident, strlen (sym->ident) - strlen ("Class"));
	}
      gitype = g_hash_table_lookup (igenerator->type_map, base_name);
      if (gitype == NULL
	  || (gitype->type != G_IDL_NODE_OBJECT
	      && gitype->type != G_IDL_NODE_INTERFACE))
	{
	  g_igenerator_process_unregistered_struct_typedef (igenerator, sym,
							    struct_type);
	  return;
	}
      ginode = (GIdlNodeInterface *) gitype;

      /* ignore first field => parent */
      for (member_l = struct_type->child_list->next; member_l != NULL;
	   member_l = member_l->next)
	{
	  CSymbol *member = member_l->data;
	  /* ignore private / reserved members */
	  if (member->ident[0] == '_')
	    {
	      continue;
	    }
	  if (member->base_type->type == CTYPE_POINTER
	      && member->base_type->base_type->type == CTYPE_FUNCTION)
	    {
	      /* ignore default handlers of signals */
	      gboolean found_signal = FALSE;
	      GList *type_member_l;
	      GList *param_l;
	      int i;
	      GIdlNodeVFunc *givfunc;
	      
	      for (type_member_l = ginode->members; type_member_l != NULL;
		   type_member_l = type_member_l->next)
		{
		  GIdlNode *type_member = type_member_l->data;
		  char *normalized_name =
		    str_replace (type_member->name, "-", "_");
		  if (type_member->type == G_IDL_NODE_SIGNAL
		      && strcmp (normalized_name, member->ident) == 0)
		    {
		      GList *vfunc_param_l;
		      GList *sig_param_l;
		      GIdlNodeSignal *sig = (GIdlNodeSignal *) type_member;
		      found_signal = TRUE;
		      /* set signal parameter names */
		      for (vfunc_param_l =
			   member->base_type->base_type->child_list,
			   sig_param_l = sig->parameters;
			   vfunc_param_l != NULL && sig_param_l != NULL;
			   vfunc_param_l = vfunc_param_l->next, sig_param_l =
			   sig_param_l->next)
			{
			  CSymbol *vfunc_param = vfunc_param_l->data;
			  GIdlNodeParam *sig_param = sig_param_l->data;
			  if (vfunc_param->ident != NULL)
			    {
			      g_free (sig_param->node.name);
			      sig_param->node.name =
				g_strdup (vfunc_param->ident);
			    }
			}
		      break;
		    }
		}
	      if (found_signal)
		{
		  continue;
		}

	      givfunc = (GIdlNodeVFunc *) g_idl_node_new (G_IDL_NODE_VFUNC);
	      givfunc->node.name = member->ident;
	      ginode->members =
		g_list_insert_sorted (ginode->members, givfunc,
				      (GCompareFunc) g_idl_node_cmp);
	      givfunc->result =
		(GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
	      givfunc->result->type =
		get_type_from_ctype (member->base_type->base_type->base_type);
	      for (param_l = member->base_type->base_type->child_list, i = 1;
		   param_l != NULL; param_l = param_l->next, i++)
		{
		  CSymbol *param_sym = param_l->data;
		  GIdlNodeParam *param =
		    (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
		  if (param_sym->ident == NULL)
		    {
		      param->node.name = g_strdup_printf ("p%d", i);
		    }
		  else
		    {
		      param->node.name = param_sym->ident;
		    }
		  param->type = get_type_from_ctype (param_sym->base_type);
		  givfunc->parameters =
		    g_list_append (givfunc->parameters, param);
		}
	    }
	}
    }
  else if (g_str_has_suffix (sym->ident, "Private"))
    {
      /* ignore private structs */
    }
  else
    {
      g_igenerator_process_unregistered_struct_typedef (igenerator, sym,
							struct_type);
    }
}

static void
g_igenerator_process_union_typedef (GIGenerator * igenerator, CSymbol * sym)
{
  CType *union_type = sym->base_type;
  gboolean opaque_type = FALSE;
  GIdlNode *gitype;
  
  if (union_type->child_list == NULL)
    {
      g_assert (union_type->name != NULL);
      CSymbol *union_symbol =
	g_hash_table_lookup (igenerator->struct_or_union_or_enum_table,
			     union_type->name);
      if (union_symbol != NULL)
	{
	  union_type = union_symbol->base_type;
	}
    }
  if (union_type->child_list == NULL)
    {
      opaque_type = TRUE;
    }

  gitype = g_hash_table_lookup (igenerator->type_map, sym->ident);
  if (gitype != NULL)
    {
      g_assert (gitype->type == G_IDL_NODE_BOXED);
      GIdlNodeBoxed *ginode = (GIdlNodeBoxed *) gitype;
      GList *member_l;
      for (member_l = union_type->child_list; member_l != NULL;
	   member_l = member_l->next)
	{
	  CSymbol *member = member_l->data;
	  GIdlNodeField *gifield =
	    (GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);
	  ginode->members = g_list_append (ginode->members, gifield);
	  gifield->node.name = member->ident;
	  gifield->type = get_type_from_ctype (member->base_type);
	}
    }
  else
    {
      GIdlNodeUnion *ginode =
	(GIdlNodeUnion *) g_idl_node_new (G_IDL_NODE_UNION);
      char *lower_case_prefix;
      GList *member_l;
      
      ginode->node.name = sym->ident;
      igenerator->module->entries =
	g_list_insert_sorted (igenerator->module->entries, ginode,
			      (GCompareFunc) g_idl_node_cmp);
      lower_case_prefix = g_ascii_strdown (sym->ident, -1);
      g_hash_table_insert (igenerator->type_map, sym->ident, ginode);
      g_hash_table_insert (igenerator->type_by_lower_case_prefix,
			   lower_case_prefix, ginode);

      ginode->node.name = sym->ident;
      for (member_l = union_type->child_list; member_l != NULL;
	   member_l = member_l->next)
	{
	  CSymbol *member = member_l->data;
	  GIdlNodeField *gifield =
	    (GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);
	  ginode->members = g_list_append (ginode->members, gifield);
	  gifield->node.name = member->ident;
	  gifield->type = get_type_from_ctype (member->base_type);
	}
    }
}

static void
g_igenerator_process_enum_typedef (GIGenerator * igenerator, CSymbol * sym)
{
  CType *enum_type;
  GList *member_l;
  GIdlNodeEnum *ginode;
  CSymbol *enum_symbol;

  enum_type = sym->base_type;
  if (enum_type->child_list == NULL)
    {
      g_assert (enum_type->name != NULL);
      enum_symbol =
	g_hash_table_lookup (igenerator->struct_or_union_or_enum_table,
			     enum_type->name);
      if (enum_symbol != NULL)
	{
	  enum_type = enum_symbol->base_type;
	}
    }
  if (enum_type->child_list == NULL)
    {
      /* opaque type */
      return;
    }
  
  ginode = g_hash_table_lookup (igenerator->type_map, sym->ident);
  if (ginode != NULL)
    {
      return;
    }

  ginode = (GIdlNodeEnum *) g_idl_node_new (G_IDL_NODE_ENUM);
  ginode->node.name = sym->ident;
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, ginode,
			  (GCompareFunc) g_idl_node_cmp);

  for (member_l = enum_type->child_list; member_l != NULL;
       member_l = member_l->next)
    {
      CSymbol *member = member_l->data;
      GIdlNodeValue *gival =
	(GIdlNodeValue *) g_idl_node_new (G_IDL_NODE_VALUE);
      ginode->values = g_list_append (ginode->values, gival);
      gival->node.name = member->ident;
      gival->value = member->const_int;
    }
}

static void
g_igenerator_process_function_typedef (GIGenerator * igenerator,
				       CSymbol * sym)
{
  GList *param_l;
  int i;

  /* handle callback types */
  GIdlNodeFunction *gifunc =
    (GIdlNodeFunction *) g_idl_node_new (G_IDL_NODE_CALLBACK);

  gifunc->node.name = sym->ident;
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, gifunc,
			  (GCompareFunc) g_idl_node_cmp);

  gifunc->symbol = sym->ident;
  gifunc->result = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
  gifunc->result->type =
    get_type_from_ctype (sym->base_type->base_type->base_type);

  for (param_l = sym->base_type->base_type->child_list, i = 1;
       param_l != NULL; param_l = param_l->next, i++)
    {
      CSymbol *param_sym = param_l->data;
      GIdlNodeParam *param =
	(GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
      if (param_sym->ident == NULL)
	{
	  param->node.name = g_strdup_printf ("p%d", i);
	}
      else
	{
	  param->node.name = param_sym->ident;
	}
      param->type = get_type_from_ctype (param_sym->base_type);
      gifunc->parameters = g_list_append (gifunc->parameters, param);
    }
}

static void
g_igenerator_process_constant (GIGenerator * igenerator, CSymbol * sym)
{
  GIdlNodeConstant *giconst =
    (GIdlNodeConstant *) g_idl_node_new (G_IDL_NODE_CONSTANT);
  giconst->node.name = sym->ident;
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, giconst,
			  (GCompareFunc) g_idl_node_cmp);

  giconst->type = (GIdlNodeType *) g_idl_node_new (G_IDL_NODE_TYPE);
  if (sym->const_int_set)
    {
      giconst->type->unparsed = g_strdup ("int");
      giconst->value = g_strdup_printf ("%d", sym->const_int);
    }
  else if (sym->const_string != NULL)
    {
      giconst->type->unparsed = g_strdup ("char*");
      giconst->value = sym->const_string;
    }
}

static void
g_igenerator_process_symbols (GIGenerator * igenerator)
{
  GList *l;
  /* process type symbols first to ensure complete type hashtables */
  /* type symbols */
  for (l = igenerator->symbol_list; l != NULL; l = l->next)
    {
      CSymbol *sym = l->data;
      if (sym->ident[0] == '_')
	{
	  /* ignore private / reserved symbols */
	  continue;
	}
      if (sym->type == CSYMBOL_TYPE_TYPEDEF)
	{
	  if (sym->base_type->type == CTYPE_STRUCT)
	    {
	      g_igenerator_process_struct_typedef (igenerator, sym);
	    }
	  else if (sym->base_type->type == CTYPE_UNION)
	    {
	      g_igenerator_process_union_typedef (igenerator, sym);
	    }
	  else if (sym->base_type->type == CTYPE_ENUM)
	    {
	      g_igenerator_process_enum_typedef (igenerator, sym);
	    }
	  else if (sym->base_type->type == CTYPE_POINTER
		   && sym->base_type->base_type->type == CTYPE_FUNCTION)
	    {
	      g_igenerator_process_function_typedef (igenerator, sym);
	    }
	  else
	    {
	      GIdlNodeStruct *ginode =
		(GIdlNodeStruct *) g_idl_node_new (G_IDL_NODE_STRUCT);
	      char *lower_case_prefix;
	      
	      ginode->node.name = sym->ident;
	      igenerator->module->entries =
		g_list_insert_sorted (igenerator->module->entries, ginode,
				      (GCompareFunc) g_idl_node_cmp);
	      lower_case_prefix = g_ascii_strdown (sym->ident, -1);
	      g_hash_table_insert (igenerator->type_map, sym->ident, ginode);
	      g_hash_table_insert (igenerator->type_by_lower_case_prefix,
				   lower_case_prefix, ginode);
	    }
	}
    }
  /* other symbols */
  for (l = igenerator->symbol_list; l != NULL; l = l->next)
    {
      CSymbol *sym = l->data;
      if (sym->ident[0] == '_')
	{
	  /* ignore private / reserved symbols */
	  continue;
	}
      if (sym->type == CSYMBOL_TYPE_FUNCTION)
	{
	  g_igenerator_process_function_symbol (igenerator, sym);
	}
      else if (sym->type == CSYMBOL_TYPE_CONST)
	{
	  g_igenerator_process_constant (igenerator, sym);
	}
    }
}

void
g_igenerator_add_symbol (GIGenerator * igenerator, CSymbol * symbol)
{
  /* only add symbols of main file */
  gboolean found_filename = FALSE;
  GList *l;
  for (l = igenerator->filenames; l != NULL; l = l->next)
    {
      if (strcmp (l->data, igenerator->current_filename) == 0)
	{
	  found_filename = TRUE;
	  break;
	}
    }

  symbol->directives = g_slist_reverse (igenerator->directives);
  igenerator->directives = NULL;

  if (found_filename || igenerator->macro_scan)
    {
      igenerator->symbol_list =
	g_list_prepend (igenerator->symbol_list, symbol);
    }

  if (symbol->type == CSYMBOL_TYPE_TYPEDEF)

    {
      g_hash_table_insert (igenerator->typedef_table, symbol->ident, symbol);
    }
  else if (symbol->type == CSYMBOL_TYPE_STRUCT
	   || symbol->type == CSYMBOL_TYPE_UNION
	   || symbol->type == CSYMBOL_TYPE_ENUM)
    {
      g_hash_table_insert (igenerator->struct_or_union_or_enum_table,
			   symbol->ident, symbol);
    }
}

gboolean
g_igenerator_is_typedef (GIGenerator * igenerator, const char *name)
{
  gboolean b = g_hash_table_lookup (igenerator->typedef_table, name) != NULL;
  return b;
}

void
g_igenerator_generate (GIGenerator * igenerator,
		       const gchar * filename,
		       GList *libraries)
{
  GList *l;
  
  for (l = igenerator->symbol_list; l != NULL; l = l->next)
    {
      CSymbol *sym = l->data;
      if (sym->type == CSYMBOL_TYPE_FUNCTION
	  && g_str_has_suffix (sym->ident, "_get_type"))
	{
	  if (sym->base_type->child_list == NULL)
	    {
	      // ignore get_type functions with parameters
	      igenerator->get_type_symbols =
		g_list_prepend (igenerator->get_type_symbols, sym->ident);
	    }
	}
    }

  /* ensure to initialize GObject */
  g_type_class_ref (G_TYPE_OBJECT);

  for (l = libraries; l; l = l->next)
      g_igenerator_process_module (igenerator, (const gchar*)l->data);

  g_igenerator_process_symbols (igenerator);

  g_idl_writer_save_file (igenerator->module, filename);
}

static int
eat_hspace (FILE * f)
{
  int c;
  do
    {
      c = fgetc (f);
    }
  while (c == ' ' || c == '\t');
  return c;
}

static int
eat_line (FILE * f, int c)
{
  while (c != EOF && c != '\n')
    {
      c = fgetc (f);
    }
  if (c == '\n')
    {
      c = fgetc (f);
      if (c == ' ' || c == '\t')
	{
	  c = eat_hspace (f);
	}
    }
  return c;
}

static int
read_identifier (FILE * f, int c, char **identifier)
{
  GString *id = g_string_new ("");
  while (isalnum (c) || c == '_')
    {
      g_string_append_c (id, c);
      c = fgetc (f);
    }
  *identifier = g_string_free (id, FALSE);
  return c;
}

static void
g_igenerator_parse_macros (GIGenerator * igenerator)
{
  GError *error = NULL;
  char *tmp_name = NULL;
  FILE *fmacros =
    fdopen (g_file_open_tmp ("gen-introspect-XXXXXX.h", &tmp_name, &error),
	    "w+");
  g_unlink (tmp_name);

  GList *l;
  for (l = igenerator->filenames; l != NULL; l = l->next)
    {
      FILE *f = fopen (l->data, "r");
      int line = 1;

      GString *define_line;
      char *str;
      gboolean error_line = FALSE;
      int c = eat_hspace (f);
      while (c != EOF)
	{
	  if (c != '#')
	    {
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
	  if (strcmp (str, "define") != 0 || (c != ' ' && c != '\t'))
	    {
	      g_free (str);
	      /* ignore line */
	      c = eat_line (f, c);
	      line++;
	      continue;
	    }
	  g_free (str);
	  c = eat_hspace (f);
	  c = read_identifier (f, c, &str);
	  if (strlen (str) == 0 || (c != ' ' && c != '\t' && c != '('))
	    {
	      g_free (str);
	      /* ignore line */
	      c = eat_line (f, c);
	      line++;
	      continue;
	    }
	  define_line = g_string_new ("#define ");
	  g_string_append (define_line, str);
	  g_free (str);
	  if (c == '(')
	    {
	      while (c != ')')
		{
		  g_string_append_c (define_line, c);
		  c = fgetc (f);
		  if (c == EOF || c == '\n')
		    {
		      error_line = TRUE;
		      break;
		    }
		}
	      if (error_line)
		{
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
	  if (c != ' ' && c != '\t')
	    {
	      g_string_free (define_line, TRUE);
	      /* ignore line */
	      c = eat_line (f, c);
	      line++;
	      continue;
	    }
	  while (c != EOF && c != '\n')
	    {
	      g_string_append_c (define_line, c);
	      c = fgetc (f);
	      if (c == '\\')
		{
		  c = fgetc (f);
		  if (c == '\n')
		    {
		      /* fold lines when seeing backslash new-line sequence */
		      c = fgetc (f);
		    }
		  else
		    {
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

  g_igenerator_parse_file (igenerator, fmacros);
  fclose (fmacros);

  igenerator->macro_scan = FALSE;
}

static void
g_igenerator_add_module (GIGenerator *igenerator,
			 GIdlModule *module)
{
  GList *l;

  for (l = module->entries; l; l = l->next)
    {
      GIdlNode *node = (GIdlNode*)l->data;
      
      if (node->type == G_IDL_NODE_OBJECT)
	{
	  GIdlNodeInterface *object = (GIdlNodeInterface*)node;
	  gchar *name;
	  if (strcmp(module->name, igenerator->namespace) == 0)
	    name = g_strdup (node->name);
	  else
	    name = g_strdup_printf ("%s.%s", module->name, node->name);
	  g_hash_table_insert (igenerator->symbols,
			       g_strdup (object->gtype_name),
			       name);
	}
    }
}

static void
g_igenerator_add_include_idl (GIGenerator *igenerator,
			      const gchar *filename)
{
  GList *l;
  GList *modules;
  
  GError *error = NULL;

  modules = g_idl_parse_file (filename, &error);
  if (error)
    {
      g_printerr ("An error occured while parsing %s: %s\n",
		  filename, error->message);
      return;
    }
  
  for (l = modules; l; l = l->next)
    {
      GIdlModule *module = (GIdlModule*)l->data;
      g_igenerator_add_module (igenerator, module);
    }
}		     

static FILE *
g_igenerator_start_preprocessor (GIGenerator *igenerator,
				 GList       *cpp_options)
{
  int cpp_out = -1, cpp_in = -1;
  int cpp_argc = 0;
  char **cpp_argv;
  GList *l;
  GError *error = NULL;
  FILE *f, *out;
  GPid pid;
  int status = 0;
  int read_bytes;
  int i;
  char **buffer;
  int tmp;
  char *tmpname;

  cpp_argv = g_new0 (char *, g_list_length (cpp_options) + 4);
  cpp_argv[cpp_argc++] = "cpp";
  cpp_argv[cpp_argc++] = "-C";

  /* Disable GCC extensions as we cannot parse them yet */
  cpp_argv[cpp_argc++] = "-U__GNUC__";

  for (l = cpp_options; l; l = l->next)
    cpp_argv[cpp_argc++] = (char*)l->data;

  cpp_argv[cpp_argc++] = NULL;

  if (igenerator->verbose)
    {
      GString *args = g_string_new ("");
      
      for (i = 0; i < cpp_argc - 1; i++)
	{
	  g_string_append (args, cpp_argv[i]);
	  if (i < cpp_argc - 2)
	    g_string_append_c (args, ' ');
	}

      g_printf ("Executing '%s'\n", args->str);
      g_string_free (args, FALSE);
    }
  g_spawn_async_with_pipes (NULL, cpp_argv, NULL,
			    G_SPAWN_SEARCH_PATH | G_SPAWN_DO_NOT_REAP_CHILD,
			    NULL, NULL, &pid, &cpp_in, &cpp_out, NULL, &error);

  g_free (cpp_argv);
  if (error != NULL)
    {
      g_error ("%s", error->message);
      return NULL;
    }

  f = fdopen (cpp_in, "w");

  for (l = igenerator->filenames; l != NULL; l = l->next)
    {
      if (igenerator->verbose)
	g_printf ("Pre-processing %s\n", (char*)l->data);

      fprintf (f, "#include <%s>\n", (char *) l->data);

    }

  fclose (f);
  close (cpp_in);

  tmp = g_file_open_tmp (NULL, &tmpname, &error);
  if (error != NULL)
    {
      g_error (error->message);
      return NULL;
    }

  buffer = g_malloc0 (4096 * sizeof (char));

  while (1)
    {
      read_bytes = read (cpp_out, buffer, 4096);
      if (read_bytes == 0)
	break;
      write (tmp, buffer, read_bytes);
    }

  g_free (buffer);

  close (cpp_out);

  if (waitpid (pid, &status, 0) > 0)
    {
      if (status != 0)
	{
	  g_spawn_close_pid (pid);
	  kill (pid, SIGKILL);

	  g_error ("cpp returned error code: %d\n", status);
	  unlink (tmpname);
	  g_free (tmpname);
	  return NULL;
	}
    }

  f = fdopen (tmp, "r");
  if (!f)
    {
      g_error (strerror (errno));
      unlink (tmpname);
      g_free (tmpname);
      return NULL;
    }
  rewind (f);
  unlink (tmpname);
  g_free (tmpname);

  return f;
}


void
g_igenerator_set_verbose (GIGenerator *igenerator,
			  gboolean     verbose)
{
  igenerator->verbose = verbose;
}

int
main (int argc, char **argv)
{
  GOptionContext *ctx;
  gchar *namespace = NULL;
  gchar *shared_library = NULL;
  gchar **include_idls = NULL;
  gchar *output = NULL;
  gboolean verbose = FALSE;

  GIGenerator *igenerator;
  int gopt_argc, i;
  char **gopt_argv;
  GList *filenames = NULL;
  GError *error = NULL;
  GList *l, *libraries = NULL;
  GList *cpp_options = NULL;
  char *buffer;
  size_t size;
  FILE *tmp;
  GOptionEntry entries[] = 
    {
      { "verbose", 'v', 0, G_OPTION_ARG_NONE, &verbose,
	"Be verbose" },
      { "output", 'o', 0, G_OPTION_ARG_STRING, &output,
	"write output here instead of stdout", "FILE" },
      { "namespace", 'n', 0, G_OPTION_ARG_STRING, &namespace,
	"Namespace of the module, like 'Gtk'", "NAMESPACE" },
      { "shared-library", 0, 0, G_OPTION_ARG_FILENAME, &shared_library,
	"Shared library which contains the symbols", "FILE" }, 
      { "include-idl", 0, 0, G_OPTION_ARG_STRING_ARRAY, &include_idls,
	"Other gidls to include", "IDL" },
      { NULL }
    };

  gopt_argc = 1;
  gopt_argv = (char**)g_malloc (argc * sizeof (char*));
  gopt_argv[0] = argv[0];

  for (i = 1; i < argc; i++)
    {
      if (argv[i][0] == '-')
	{
	  switch (argv[i][1])
	    {
	    case 'I':
	    case 'D':
	    case 'U':
	      cpp_options = g_list_prepend (cpp_options, g_strdup (argv[i]));
	      break;
	    default:
	      gopt_argv[gopt_argc++] = argv[i];
	      break;
	    }
	}
      else if (g_str_has_suffix (argv[i], ".h"))
	{
	  gchar* filename;

	  if (!g_path_is_absolute (argv[i]))
	    {
	      gchar *dir = g_get_current_dir ();
	      filename = g_strdup_printf ("%s/%s", dir,
					    argv[i]);
	      g_free (dir);
	    }
	  else
	    filename = g_strdup (argv[i]);
		
	  filenames = g_list_append (filenames, filename);
	}
      else if (g_str_has_suffix (argv[i], ".la") ||
	       g_str_has_suffix (argv[i], ".so") ||
	       g_str_has_suffix (argv[i], ".dll"))
	{
	  libraries = g_list_prepend (libraries, g_strdup (argv[i]));
	}
      else
	{
	  gopt_argv[gopt_argc++] = argv[i];
	}
    }

  ctx = g_option_context_new ("");
  g_option_context_add_main_entries (ctx, entries, NULL);

  if (!g_option_context_parse (ctx, &gopt_argc, &gopt_argv, &error))
    {
      g_printerr ("Parsing error: %s\n", error->message);
      g_option_context_free (ctx);
      return 1;
    }

  g_free (gopt_argv);
  g_option_context_free (ctx);
  
  if (!namespace)
    {
      g_printerr ("ERROR: namespace must be specified\n");
      return 1;
    }

  igenerator = g_igenerator_new (namespace, shared_library);

  if (verbose)
    g_igenerator_set_verbose (igenerator, TRUE);

  if (!filenames)
    {
      g_printerr ("ERROR: Need at least one header file.\n");
      g_igenerator_free (igenerator);  
      return 0;
    }
  igenerator->filenames = filenames;
  cpp_options = g_list_reverse (cpp_options);
  libraries = g_list_reverse (libraries);

  g_type_init ();

  /* initialize threading as this may be required by libraries that we'll use
   * libsoup-2.2 is an example of that.
   */
  g_thread_init (NULL);

  if (include_idls)
    {
      for (i = 0; i < g_strv_length (include_idls); i++)
	g_igenerator_add_include_idl (igenerator, include_idls[i]);
    }

  tmp = g_igenerator_start_preprocessor (igenerator, cpp_options);
  if (!tmp)
    {
      g_error ("ERROR in pre-processor.\n");
      g_igenerator_free (igenerator);  
      return 1;
    }

  if (!g_igenerator_parse_file (igenerator, tmp))
    {
      fclose (tmp);
      g_igenerator_free (igenerator);  
      return 1;
    }

  g_igenerator_parse_macros (igenerator);

  g_igenerator_generate (igenerator, output, libraries);

  fclose (tmp);
  g_igenerator_free (igenerator);
  
  return 0;
}

