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
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>
#include <errno.h>
#include <glib.h>
#include <glib/gstdio.h>
#include <glib-object.h>
#include <signal.h>
#include <gmodule.h>
#include "scanner.h"
#include "gidlparser.h"
#include "gidlmodule.h"
#include "gidlnode.h"
#include "gidlwriter.h"
#include "grealpath.h"

#ifndef _WIN32
#include <sys/wait.h> /* waitpid */
#endif


typedef GType (*TypeFunction) (void);

static void g_igenerator_parse_macros (GIGenerator * igenerator);

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
create_node_from_gtype (GType type_id)
{
  GIdlNodeType *node;
  GType fundamental;

  node = (GIdlNodeType *) g_idl_node_new (G_IDL_NODE_TYPE);

  fundamental = g_type_fundamental (type_id);
  switch (fundamental)
    {
    case G_TYPE_STRING:
      node->unparsed = g_strdup ("char*");
      break;
    case G_TYPE_INTERFACE:
    case G_TYPE_BOXED:
    case G_TYPE_OBJECT:
      node->unparsed = g_strdup_printf ("%s*", g_type_name (type_id));
      break;
    case G_TYPE_PARAM:
      node->unparsed = g_strdup ("GParamSpec*");
      break;
    default:
      if (fundamental == G_TYPE_STRV)
	node->unparsed = g_strdup ("char*[]");
      else
	node->unparsed = g_strdup (g_type_name (type_id));
      break;
    }

  return node;
}

static GIdlNodeType *
create_node_from_ctype (CType * ctype)
{
  GIdlNodeType *node;

  node = (GIdlNodeType *) g_idl_node_new (G_IDL_NODE_TYPE);

  switch (ctype->type)
    {
    case CTYPE_VOID:
      node->unparsed = g_strdup ("void");
      break;
    case CTYPE_BASIC_TYPE:
      node->unparsed = g_strdup (ctype->name);
      break;
    case CTYPE_TYPEDEF:
      node->unparsed = g_strdup (ctype->name);
      break;
    case CTYPE_STRUCT:
      if (ctype->name == NULL)
	/* anonymous struct */
	node->unparsed = g_strdup ("gpointer");
      else
	node->unparsed = g_strdup_printf ("struct %s", ctype->name);
      break;
    case CTYPE_UNION:
      if (ctype->name == NULL)
	/* anonymous union */
	node->unparsed = g_strdup ("gpointer");
      else
	node->unparsed = g_strdup_printf ("union %s", ctype->name);
      break;
    case CTYPE_ENUM:
      if (ctype->name == NULL)
	/* anonymous enum */
	node->unparsed = g_strdup ("gint");
      else
	node->unparsed = g_strdup_printf ("enum %s", ctype->name);
      break;
    case CTYPE_POINTER:
      if (ctype->base_type->type == CTYPE_FUNCTION)
	/* anonymous function pointer */
	node->unparsed = g_strdup ("GCallback");
      else
	{
	  GIdlNodeType *gibasetype = create_node_from_ctype (ctype->base_type);
	  node->unparsed = g_strdup_printf ("%s*", gibasetype->unparsed);
	}
      break;
    case CTYPE_ARRAY:
      {
	GIdlNodeType *gibasetype = create_node_from_ctype (ctype->base_type);
	node->unparsed = g_strdup_printf ("%s[]", gibasetype->unparsed);
	break;
      }
    default:
      node->unparsed = g_strdup ("unknown");
      break;
    }

  return node;
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
				 GIdlNodeInterface * node, GType type_id)
{
  int i;
  guint n_properties;
  GParamSpec **properties;

  if (node->node.type == G_IDL_NODE_OBJECT)
    {
      GObjectClass *type_class = g_type_class_ref (type_id);
      properties = g_object_class_list_properties (type_class, &n_properties);
    }
  else if (node->node.type == G_IDL_NODE_INTERFACE)
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
      node->members =
	g_list_insert_sorted (node->members, giprop,
			      (GCompareFunc) g_idl_node_cmp);
      giprop->type = create_node_from_gtype (properties[i]->value_type);
      giprop->readable = (properties[i]->flags & G_PARAM_READABLE) != 0;
      giprop->writable = (properties[i]->flags & G_PARAM_WRITABLE) != 0;
      giprop->construct = (properties[i]->flags & G_PARAM_CONSTRUCT) != 0;
      giprop->construct_only =
	(properties[i]->flags & G_PARAM_CONSTRUCT_ONLY) != 0;
    }
}

static void
g_igenerator_process_signals (GIGenerator * igenerator,
			      GIdlNodeInterface * node, GType type_id)
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
      node->members =
	g_list_insert_sorted (node->members, gisig,
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
      giparam->type = create_node_from_gtype (type_id);

      for (j = 0; j < signal_query.n_params; j++)
	{
	  giparam = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
	  gisig->parameters = g_list_append (gisig->parameters, giparam);
	  giparam->node.name = g_strdup_printf ("p%d", j);
	  giparam->type = create_node_from_gtype (signal_query.param_types[j]);
	}
      gisig->result = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
      gisig->result->type = create_node_from_gtype (signal_query.return_type);
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
  GIdlNodeInterface *node;
  guint n_type_interfaces;
  GType *type_interfaces;
  int i;

  node = (GIdlNodeInterface *) g_idl_node_new (G_IDL_NODE_OBJECT);
  node->node.name = g_strdup (g_type_name (type_id));
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, node,
			  (GCompareFunc) g_idl_node_cmp);
  g_hash_table_insert (igenerator->type_map, node->node.name,
		       node);
  g_hash_table_insert (igenerator->type_by_lower_case_prefix,
		       lower_case_prefix, node);
  alt_lower_case_prefix = g_ascii_strdown (node->node.name, -1);
  
  if (strcmp (alt_lower_case_prefix, lower_case_prefix) != 0)
    {
      /* alternative prefix sometimes necessary, for example
       * for GdkWindow
       */
      g_hash_table_insert (igenerator->type_by_lower_case_prefix,
			   alt_lower_case_prefix, node);
    }
  else
    {
      g_free (alt_lower_case_prefix);
    }

  node->gtype_name = node->node.name;
  node->gtype_init = g_strdup (symbol_name);
  node->parent = g_strdup (lookup_symbol (igenerator,
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
      node->interfaces =
	g_list_append (node->interfaces, iface_name);
    }
  
  g_hash_table_insert (igenerator->symbols,
		       g_strdup (node->gtype_name),
		       /* FIXME: Strip igenerator->namespace */
		       g_strdup (node->node.name));
  
  g_igenerator_process_properties (igenerator, node, type_id);
  g_igenerator_process_signals (igenerator, node, type_id);
}

static void
g_igenerator_create_interface (GIGenerator *igenerator,
			       const char *symbol_name,
			       GType type_id,
			       char *lower_case_prefix)

{
  GIdlNodeInterface *node;
  gboolean is_gobject = FALSE;
  guint n_iface_prereqs;
  GType *iface_prereqs;
  int i;

  node = (GIdlNodeInterface *) g_idl_node_new (G_IDL_NODE_INTERFACE);
  node->node.name = g_strdup (g_type_name (type_id));
  
  /* workaround for AtkImplementorIface */
  if (g_str_has_suffix (node->node.name, "Iface"))
    {
      node->node.name[strlen (node->node.name) -
			strlen ("Iface")] = '\0';
    }
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, node,
			  (GCompareFunc) g_idl_node_cmp);
  g_hash_table_insert (igenerator->type_map, node->node.name,
		       node);
  g_hash_table_insert (igenerator->type_by_lower_case_prefix,
		       lower_case_prefix, node);
  node->gtype_name = node->node.name;
  node->gtype_init = g_strdup (symbol_name);
  
  iface_prereqs =
    g_type_interface_prerequisites (type_id, &n_iface_prereqs);

  for (i = 0; i < n_iface_prereqs; i++)
    {
      if (g_type_fundamental (iface_prereqs[i]) == G_TYPE_OBJECT)
	{
	  is_gobject = TRUE;
	}
      node->prerequisites =
	g_list_append (node->prerequisites,
		       g_strdup (g_type_name (iface_prereqs[i])));
    }
  
  if (is_gobject)
    g_igenerator_process_properties (igenerator, node, type_id);
  else
    g_type_default_interface_ref (type_id);

  g_igenerator_process_signals (igenerator, node, type_id);
}

static void
g_igenerator_create_boxed (GIGenerator *igenerator,
			   const char *symbol_name,
			   GType type_id,
			   char *lower_case_prefix)
{
  GIdlNodeBoxed *node =
    (GIdlNodeBoxed *) g_idl_node_new (G_IDL_NODE_BOXED);
  node->node.name = g_strdup (g_type_name (type_id));
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, node,
			  (GCompareFunc) g_idl_node_cmp);
  g_hash_table_insert (igenerator->type_map, node->node.name,
		       node);
  g_hash_table_insert (igenerator->type_by_lower_case_prefix,
		       lower_case_prefix, node);
  node->gtype_name = node->node.name;
  node->gtype_init = g_strdup (symbol_name);
}

static void
g_igenerator_create_enum (GIGenerator *igenerator,
			  const char *symbol_name,
			  GType type_id,
			  char *lower_case_prefix)
{
  GIdlNodeEnum *node;
  int i;
  GEnumClass *type_class;
  
  node = (GIdlNodeEnum *) g_idl_node_new (G_IDL_NODE_ENUM);
  node->node.name = g_strdup (g_type_name (type_id));
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, node,
			  (GCompareFunc) g_idl_node_cmp);
  g_hash_table_insert (igenerator->type_map, node->node.name,
		       node);
  g_hash_table_insert (igenerator->type_by_lower_case_prefix,
		       lower_case_prefix, node);
  node->gtype_name = node->node.name;
  node->gtype_init = g_strdup (symbol_name);
  
  type_class = g_type_class_ref (type_id);

  for (i = 0; i < type_class->n_values; i++)
    {
      GIdlNodeValue *gival =
	(GIdlNodeValue *) g_idl_node_new (G_IDL_NODE_VALUE);
      node->values = g_list_append (node->values, gival);
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
  GIdlNodeEnum *node;
  GFlagsClass *type_class;
  int i;
  
  node = (GIdlNodeEnum *) g_idl_node_new (G_IDL_NODE_FLAGS);
  node->node.name = g_strdup (g_type_name (type_id));
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, node,
			  (GCompareFunc) g_idl_node_cmp);
  g_hash_table_insert (igenerator->type_map, node->node.name,
		       node);
  g_hash_table_insert (igenerator->type_by_lower_case_prefix,
		       lower_case_prefix, node);
  node->gtype_name = node->node.name;
  node->gtype_init = g_strdup (symbol_name);
  
  type_class = g_type_class_ref (type_id);
  
  for (i = 0; i < type_class->n_values; i++)
    {
      GIdlNodeValue *gival =
	(GIdlNodeValue *) g_idl_node_new (G_IDL_NODE_VALUE);
      node->values = g_list_append (node->values, gival);
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

static void
g_igenerator_process_function_symbol (GIGenerator * igenerator, CSymbol * sym)
{
  GIdlNodeFunction *func;
  char *last_underscore;
  GList *param_l;
  int i;
  GSList *l;

  func = (GIdlNodeFunction *) g_idl_node_new (G_IDL_NODE_FUNCTION);
  
  /* check whether this is a type method */
  last_underscore = strrchr (sym->ident, '_');

  while (last_underscore != NULL)
    {
      char *prefix;
      GIdlNode *node;

      prefix = g_strndup (sym->ident, last_underscore - sym->ident);
      prefix = str_replace (prefix, "_", "");

      node = g_hash_table_lookup (igenerator->type_by_lower_case_prefix,
				  prefix);
      if (node != NULL )
	{
	  func->node.name = g_strdup (last_underscore + 1);

	  /* ignore get_type functions in registered types */
	  if (strcmp (func->node.name, "get_type") == 0)
	    return;

	  if ((node->type == G_IDL_NODE_OBJECT ||
	       node->type == G_IDL_NODE_BOXED) &&
	      g_str_has_prefix (func->node.name, "new"))
	    func->is_constructor = TRUE;
	  else
	    func->is_method = TRUE;
	  if (g_idl_node_can_have_member (node))
	    {
	      g_idl_node_add_member (node, func);
	      break;
	    }
	  else
	    {
	      /* reset function attributes */
	      g_free (func->node.name);
	      func->node.name = NULL;
	      func->is_constructor = FALSE;
	      func->is_method = FALSE;
	    }
	}
      else if (strcmp (igenerator->lower_case_namespace, prefix) == 0)
	{
	  func->node.name = g_strdup (last_underscore + 1);
	  igenerator->module->entries =
	    g_list_insert_sorted (igenerator->module->entries, func,
				  (GCompareFunc) g_idl_node_cmp);
	  break;
	}
      last_underscore =
	g_utf8_strrchr (sym->ident, last_underscore - sym->ident, '_');
    }

  /* create a namespace function if no prefix matches */
  if (func->node.name == NULL)
    {
      func->node.name = sym->ident;
      func->is_constructor = FALSE;
      func->is_method = FALSE;
      igenerator->module->entries =
	g_list_insert_sorted (igenerator->module->entries, func,
			      (GCompareFunc) g_idl_node_cmp);
    }

  func->symbol = sym->ident;
  func->result = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
  func->result->type = create_node_from_ctype (sym->base_type->base_type);

  for (param_l = sym->base_type->child_list, i = 1; param_l != NULL;
       param_l = param_l->next, i++)
    {
      CSymbol *param_sym = param_l->data;
      GIdlNodeParam *param;

      param = (GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
      param->type = create_node_from_ctype (param_sym->base_type);

      if (param_sym->ident == NULL)
	param->node.name = g_strdup_printf ("p%d", i);
      else
	param->node.name = param_sym->ident;

      func->parameters = g_list_append (func->parameters, param);
    }

  for (l = sym->directives; l; l = l->next)
    {
      CDirective *directive = (CDirective*)l->data;

      if (!strcmp (directive->name, "deprecated"))
	func->deprecated = TRUE;
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
  GIdlNodeStruct *node =
    (GIdlNodeStruct *) g_idl_node_new (G_IDL_NODE_STRUCT);
  GList *member_l;
  char *lower_case_prefix;

  node->node.name = sym->ident;
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, node,
			  (GCompareFunc) g_idl_node_cmp);
  lower_case_prefix = g_ascii_strdown (sym->ident, -1);
  g_hash_table_insert (igenerator->type_map, sym->ident, node);
  g_hash_table_insert (igenerator->type_by_lower_case_prefix,
		       lower_case_prefix, node);

  for (member_l = struct_type->child_list; member_l != NULL;
       member_l = member_l->next)
    {
      CSymbol *member = member_l->data;
      GIdlNodeField *gifield =
	(GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);

      node->members = g_list_append (node->members, gifield);
      gifield->node.name = member->ident;
      gifield->type = create_node_from_ctype (member->base_type);
    }
}

static void
g_igenerator_process_struct_typedef (GIGenerator * igenerator, CSymbol * sym)
{
  CType *struct_type = sym->base_type;
  gboolean opaque_type = FALSE;
  GIdlNode *type;
  
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
  
  type = g_hash_table_lookup (igenerator->type_map, sym->ident);
  if (type != NULL)
    {
      /* struct of a GTypeInstance */
      if (!opaque_type
	  && (type->type == G_IDL_NODE_OBJECT
	      || type->type == G_IDL_NODE_INTERFACE))
	{
	  GIdlNodeInterface *node = (GIdlNodeInterface *) type;
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
	      node->members = g_list_append (node->members, gifield);
	      gifield->node.name = member->ident;
	      gifield->type = create_node_from_ctype (member->base_type);
	    }
	}
      else if (type->type == G_IDL_NODE_BOXED)
	{
	  GIdlNodeBoxed *node = (GIdlNodeBoxed *) type;
	  GList *member_l;
	  for (member_l = struct_type->child_list; member_l != NULL;
	       member_l = member_l->next)
	    {
	      CSymbol *member = member_l->data;
	      GIdlNodeField *gifield =
		(GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);
	      node->members = g_list_append (node->members, gifield);
	      gifield->node.name = member->ident;
	      gifield->type = create_node_from_ctype (member->base_type);
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
      GIdlNodeInterface *node;

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
      type = g_hash_table_lookup (igenerator->type_map, base_name);
      if (type == NULL
	  || (type->type != G_IDL_NODE_OBJECT
	      && type->type != G_IDL_NODE_INTERFACE))
	{
	  g_igenerator_process_unregistered_struct_typedef (igenerator, sym,
							    struct_type);
	  return;
	}
      node = (GIdlNodeInterface *) type;

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
	      
	      for (type_member_l = node->members; type_member_l != NULL;
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
	      node->members =
		g_list_insert_sorted (node->members, givfunc,
				      (GCompareFunc) g_idl_node_cmp);
	      givfunc->result =
		(GIdlNodeParam *) g_idl_node_new (G_IDL_NODE_PARAM);
	      givfunc->result->type =
		create_node_from_ctype (member->base_type->base_type->base_type);
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
		  param->type = create_node_from_ctype (param_sym->base_type);
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
  GIdlNode *type;
  
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

  type = g_hash_table_lookup (igenerator->type_map, sym->ident);
  if (type != NULL)
    {
      g_assert (type->type == G_IDL_NODE_BOXED);
      GIdlNodeBoxed *node = (GIdlNodeBoxed *) type;
      GList *member_l;
      for (member_l = union_type->child_list; member_l != NULL;
	   member_l = member_l->next)
	{
	  CSymbol *member = member_l->data;
	  GIdlNodeField *gifield =
	    (GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);
	  node->members = g_list_append (node->members, gifield);
	  gifield->node.name = member->ident;
	  gifield->type = create_node_from_ctype (member->base_type);
	}
    }
  else
    {
      GIdlNodeUnion *node =
	(GIdlNodeUnion *) g_idl_node_new (G_IDL_NODE_UNION);
      char *lower_case_prefix;
      GList *member_l;
      
      node->node.name = sym->ident;
      igenerator->module->entries =
	g_list_insert_sorted (igenerator->module->entries, node,
			      (GCompareFunc) g_idl_node_cmp);
      lower_case_prefix = g_ascii_strdown (sym->ident, -1);
      g_hash_table_insert (igenerator->type_map, sym->ident, node);
      g_hash_table_insert (igenerator->type_by_lower_case_prefix,
			   lower_case_prefix, node);

      node->node.name = sym->ident;
      for (member_l = union_type->child_list; member_l != NULL;
	   member_l = member_l->next)
	{
	  CSymbol *member = member_l->data;
	  GIdlNodeField *gifield =
	    (GIdlNodeField *) g_idl_node_new (G_IDL_NODE_FIELD);
	  node->members = g_list_append (node->members, gifield);
	  gifield->node.name = member->ident;
	  gifield->type = create_node_from_ctype (member->base_type);
	}
    }
}

static void
g_igenerator_process_enum_typedef (GIGenerator * igenerator, CSymbol * sym)
{
  CType *enum_type;
  GList *member_l;
  GIdlNodeEnum *node;
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
  
  node = g_hash_table_lookup (igenerator->type_map, sym->ident);
  if (node != NULL)
    {
      return;
    }

  node = (GIdlNodeEnum *) g_idl_node_new (G_IDL_NODE_ENUM);
  node->node.name = sym->ident;
  igenerator->module->entries =
    g_list_insert_sorted (igenerator->module->entries, node,
			  (GCompareFunc) g_idl_node_cmp);

  for (member_l = enum_type->child_list; member_l != NULL;
       member_l = member_l->next)
    {
      CSymbol *member = member_l->data;
      GIdlNodeValue *gival =
	(GIdlNodeValue *) g_idl_node_new (G_IDL_NODE_VALUE);
      node->values = g_list_append (node->values, gival);
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
    create_node_from_ctype (sym->base_type->base_type->base_type);

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
      param->type = create_node_from_ctype (param_sym->base_type);
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
	      GIdlNodeStruct *node =
		(GIdlNodeStruct *) g_idl_node_new (G_IDL_NODE_STRUCT);
	      char *lower_case_prefix;
	      
	      node->node.name = sym->ident;
	      igenerator->module->entries =
		g_list_insert_sorted (igenerator->module->entries, node,
				      (GCompareFunc) g_idl_node_cmp);
	      lower_case_prefix = g_ascii_strdown (sym->ident, -1);
	      g_hash_table_insert (igenerator->type_map, sym->ident, node);
	      g_hash_table_insert (igenerator->type_by_lower_case_prefix,
				   lower_case_prefix, node);
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
  GList *l;

  /* only add symbols of main file */
  gboolean found_filename = FALSE;

  if (igenerator->current_filename)
    {
      for (l = igenerator->filenames; l != NULL; l = l->next)
        {
          if (strcmp (l->data, igenerator->current_filename) == 0)
            {
	      found_filename = TRUE;
              break;
            }
        }
    }

  symbol->directives = g_slist_reverse (igenerator->directives);
  igenerator->directives = NULL;

  /* that's not very optimized ! */
  for (l = igenerator->symbol_list; l != NULL; l = l->next)
    {
      CSymbol *other_symbol = (CSymbol *)l->data;
      if (g_str_equal (other_symbol->ident, symbol->ident)
          && other_symbol->type == symbol->type)
        {
          g_printerr ("Dropping %s duplicate\n", symbol->ident);
          return;
        }
  }

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
      g_printerr ("An error occurred while parsing %s: %s\n",
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

  cpp_argv = g_new0 (char *, g_list_length (cpp_options) + 5);
  cpp_argv[cpp_argc++] = "cpp";
  cpp_argv[cpp_argc++] = "-C";

  /* Disable GCC extensions as we cannot parse them yet */
  cpp_argv[cpp_argc++] = "-U__GNUC__";

  /* Help system headers cope with the lack of __GNUC__ by pretending to be lint */
  cpp_argv[cpp_argc++] = "-Dlint";

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
      g_error ("%s", error->message);
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

#ifndef _WIN32
  if (waitpid (pid, &status, 0) > 0)
#else
  /* We don't want to include <windows.h> as it clashes horribly
   * with token names from scannerparser.h. So just declare
   * WaitForSingleObject, GetExitCodeProcess and INFINITE here.
   */
  extern unsigned long __stdcall WaitForSingleObject(void*, int);
  extern int __stdcall GetExitCodeProcess(void*, int*);
#define INFINITE 0xffffffff

  WaitForSingleObject (pid, INFINITE);

  if (GetExitCodeProcess (pid, &status))
#endif
    {
      if (status != 0)
	{
	  g_spawn_close_pid (pid);
#ifndef _WIN32
	  kill (pid, SIGKILL);
#endif

	  g_error ("cpp returned error code: %d\n", status);
	  unlink (tmpname);
	  g_free (tmpname);
	  return NULL;
	}
    }

  f = fdopen (tmp, "r");
  if (!f)
    {
      g_error ("%s", strerror (errno));
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
	    case 'p':
	      /*ignore -pthread*/
	      if (0==strcmp("-pthread", argv[i]))
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
		
	  filenames = g_list_append (filenames, g_realpath(filename));
	  g_free(filename);
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
      return 1;
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

