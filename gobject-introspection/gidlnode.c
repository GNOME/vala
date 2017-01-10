/* GObject introspection: Metadata creation
 *
 * Copyright (C) 2005 Matthias Clasen
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
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
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "gidlmodule.h"
#include "gidlnode.h"
#include "gmetadata.h"

static gulong string_count = 0;
static gulong unique_string_count = 0;
static gulong string_size = 0;
static gulong unique_string_size = 0;
static gulong types_count = 0;
static gulong unique_types_count = 0;

void
init_stats (void)
{
  string_count = 0;
  unique_string_count = 0;
  string_size = 0;
  unique_string_size = 0;
  types_count = 0;
  unique_types_count = 0;
}

void
dump_stats (void)
{
  g_message ("%lu strings (%lu before sharing), %lu bytes (%lu before sharing)",
	     unique_string_count, string_count, unique_string_size, string_size);
  g_message ("%lu types (%lu before sharing)", unique_types_count, types_count);
}

#define ALIGN_VALUE(this, boundary) \
  (( ((unsigned long)(this)) + (((unsigned long)(boundary)) -1)) & (~(((unsigned long)(boundary))-1)))


GIdlNode *
g_idl_node_new (GIdlNodeTypeId type)
{
  GIdlNode *node = NULL;

  switch (type)
    {
   case G_IDL_NODE_FUNCTION:
   case G_IDL_NODE_CALLBACK:
      node = g_malloc0 (sizeof (GIdlNodeFunction));
      break;

   case G_IDL_NODE_PARAM:
      node = g_malloc0 (sizeof (GIdlNodeParam));
      break;

   case G_IDL_NODE_TYPE:
      node = g_malloc0 (sizeof (GIdlNodeType));
      break;

    case G_IDL_NODE_OBJECT:
    case G_IDL_NODE_INTERFACE:
      node = g_malloc0 (sizeof (GIdlNodeInterface));
      break;

    case G_IDL_NODE_SIGNAL:
      node = g_malloc0 (sizeof (GIdlNodeSignal));
      break;

    case G_IDL_NODE_PROPERTY:
      node = g_malloc0 (sizeof (GIdlNodeProperty));
      break;

    case G_IDL_NODE_VFUNC:
      node = g_malloc0 (sizeof (GIdlNodeFunction));
      break;

    case G_IDL_NODE_FIELD:
      node = g_malloc0 (sizeof (GIdlNodeField));
      break;

    case G_IDL_NODE_ENUM:
    case G_IDL_NODE_FLAGS:
      node = g_malloc0 (sizeof (GIdlNodeEnum));
      break;

    case G_IDL_NODE_BOXED:
      node = g_malloc0 (sizeof (GIdlNodeBoxed));
      break;

    case G_IDL_NODE_STRUCT:
      node = g_malloc0 (sizeof (GIdlNodeStruct));
      break;

    case G_IDL_NODE_VALUE:
      node = g_malloc0 (sizeof (GIdlNodeValue));
      break;

    case G_IDL_NODE_CONSTANT:
      node = g_malloc0 (sizeof (GIdlNodeConstant));
      break;

    case G_IDL_NODE_ERROR_DOMAIN:
      node = g_malloc0 (sizeof (GIdlNodeErrorDomain));
      break;

    case G_IDL_NODE_XREF:
      node = g_malloc0 (sizeof (GIdlNodeXRef));
      break;

    case G_IDL_NODE_UNION:
      node = g_malloc0 (sizeof (GIdlNodeUnion));
      break;

    default:
      g_error ("Unhandled node type %d\n", type);
      break;
    }

  node->type = type;

  return node;
}

void
g_idl_node_free (GIdlNode *node)
{
  GList *l;

  if (node == NULL)
    return;

  switch (node->type)
    {
    case G_IDL_NODE_FUNCTION:
    case G_IDL_NODE_CALLBACK:
      {
	GIdlNodeFunction *function = (GIdlNodeFunction *)node;
	
	g_free (node->name);
	g_free (function->symbol);
	g_idl_node_free ((GIdlNode *)function->result);
	for (l = function->parameters; l; l = l->next)
	  g_idl_node_free ((GIdlNode *)l->data);
	g_list_free (function->parameters);
      }
      break;

    case G_IDL_NODE_TYPE:
      {
	GIdlNodeType *type = (GIdlNodeType *)node;
	
	g_free (node->name);
	g_idl_node_free ((GIdlNode *)type->parameter_type1);
	g_idl_node_free ((GIdlNode *)type->parameter_type2);

	g_free (type->interface);
	g_strfreev (type->errors);

      }
      break;

    case G_IDL_NODE_PARAM:
      {
	GIdlNodeParam *param = (GIdlNodeParam *)node;
	
	g_free (node->name);
	g_idl_node_free ((GIdlNode *)param->type);
      }
      break;

    case G_IDL_NODE_PROPERTY:
      {
	GIdlNodeProperty *property = (GIdlNodeProperty *)node;
	
	g_free (node->name);
	g_idl_node_free ((GIdlNode *)property->type);
      }
      break;

    case G_IDL_NODE_SIGNAL:
      {
	GIdlNodeSignal *signal = (GIdlNodeSignal *)node;
	
	g_free (node->name);
	for (l = signal->parameters; l; l = l->next)
	  g_idl_node_free ((GIdlNode *)l->data);
	g_list_free (signal->parameters);
	g_idl_node_free ((GIdlNode *)signal->result);
      }
      break;

    case G_IDL_NODE_VFUNC:
      {
	GIdlNodeVFunc *vfunc = (GIdlNodeVFunc *)node;
	
	g_free (node->name);
	for (l = vfunc->parameters; l; l = l->next)
	  g_idl_node_free ((GIdlNode *)l->data);
	g_list_free (vfunc->parameters);
	g_idl_node_free ((GIdlNode *)vfunc->result);
      }
      break;

    case G_IDL_NODE_FIELD:
      {
	GIdlNodeField *field = (GIdlNodeField *)node;
	
	g_free (node->name);
	g_idl_node_free ((GIdlNode *)field->type);
      }
      break;

    case G_IDL_NODE_OBJECT:
    case G_IDL_NODE_INTERFACE:
      {
	GIdlNodeInterface *iface = (GIdlNodeInterface *)node;
	
	g_free (node->name);
	g_free (iface->gtype_name);
	g_free (iface->gtype_init);
	
	g_free (iface->parent);

	for (l = iface->interfaces; l; l = l->next)
	  g_free ((GIdlNode *)l->data);
	g_list_free (iface->interfaces);

	for (l = iface->members; l; l = l->next)
	  g_idl_node_free ((GIdlNode *)l->data);
	g_list_free (iface->members);

      }
      break;
 
    case G_IDL_NODE_VALUE:
      {
	g_free (node->name);
      }
      break;

    case G_IDL_NODE_ENUM:
    case G_IDL_NODE_FLAGS:
      {
	GIdlNodeEnum *enum_ = (GIdlNodeEnum *)node;
	
	g_free (node->name);
	g_free (enum_->gtype_name);
	g_free (enum_->gtype_init);

	for (l = enum_->values; l; l = l->next)
	  g_idl_node_free ((GIdlNode *)l->data);
	g_list_free (enum_->values);
      }
      break;

    case G_IDL_NODE_BOXED:
      {
	GIdlNodeBoxed *boxed = (GIdlNodeBoxed *)node;
	
	g_free (node->name);
	g_free (boxed->gtype_name);
	g_free (boxed->gtype_init);

	for (l = boxed->members; l; l = l->next)
	  g_idl_node_free ((GIdlNode *)l->data);
	g_list_free (boxed->members);
      }
      break;

    case G_IDL_NODE_STRUCT:
      {
	GIdlNodeStruct *struct_ = (GIdlNodeStruct *)node;

	g_free (node->name);
	for (l = struct_->members; l; l = l->next)
	  g_idl_node_free ((GIdlNode *)l->data);
	g_list_free (struct_->members);
      }
      break;

    case G_IDL_NODE_CONSTANT:
      {
	GIdlNodeConstant *constant = (GIdlNodeConstant *)node;
	
	g_free (node->name);
	g_free (constant->value);
	g_idl_node_free ((GIdlNode *)constant->type);
      }
      break;

    case G_IDL_NODE_ERROR_DOMAIN:
      {
	GIdlNodeErrorDomain *domain = (GIdlNodeErrorDomain *)node;
	
	g_free (node->name);
	g_free (domain->getquark);
	g_free (domain->codes);
      }
      break;

    case G_IDL_NODE_XREF:
      {
	GIdlNodeXRef *xref = (GIdlNodeXRef *)node;
	
	g_free (node->name);
	g_free (xref->namespace);
      }
      break;

    case G_IDL_NODE_UNION:
      {
	GIdlNodeUnion *union_ = (GIdlNodeUnion *)node;
	
	g_free (node->name);
	g_free (union_->gtype_name);
	g_free (union_->gtype_init);

	g_idl_node_free ((GIdlNode *)union_->discriminator_type);
	for (l = union_->members; l; l = l->next)
	  g_idl_node_free ((GIdlNode *)l->data);
	for (l = union_->discriminators; l; l = l->next)
	  g_idl_node_free ((GIdlNode *)l->data);
      }
      break;

    default:
      g_error ("Unhandled node type %d\n", node->type);
      break;
    } 

  g_free (node);
}

/* returns the fixed size of the blob */
guint32
g_idl_node_get_size (GIdlNode *node)
{
  GList *l;
  gint size, n;

  switch (node->type)
    {
    case G_IDL_NODE_CALLBACK:
      size = 12; 
      break;

    case G_IDL_NODE_FUNCTION:
      size = 16; 
      break;

    case G_IDL_NODE_PARAM:
      size = 12;
      break;

    case G_IDL_NODE_TYPE:
      size = 4;
      break;

    case G_IDL_NODE_OBJECT:
      {
	GIdlNodeInterface *iface = (GIdlNodeInterface *)node;

	n = g_list_length (iface->interfaces);
	size = 32 + 2 * (n + (n % 2));

	for (l = iface->members; l; l = l->next)
	  size += g_idl_node_get_size ((GIdlNode *)l->data);
      }
      break;

    case G_IDL_NODE_INTERFACE:
      {
	GIdlNodeInterface *iface = (GIdlNodeInterface *)node;

	n = g_list_length (iface->prerequisites);
	size = 28 + 2 * (n + (n % 2));

	for (l = iface->members; l; l = l->next)
	  size += g_idl_node_get_size ((GIdlNode *)l->data);
      }
      break;

    case G_IDL_NODE_ENUM:
    case G_IDL_NODE_FLAGS:
      {
	GIdlNodeEnum *enum_ = (GIdlNodeEnum *)node;
	
	size = 20;
	for (l = enum_->values; l; l = l->next)
	  size += g_idl_node_get_size ((GIdlNode *)l->data);
      }
      break;

    case G_IDL_NODE_VALUE:
      size = 12;
      break;

    case G_IDL_NODE_STRUCT:
      {
	GIdlNodeStruct *struct_ = (GIdlNodeStruct *)node;

	size = 20;
	for (l = struct_->members; l; l = l->next)
	  size += g_idl_node_get_size ((GIdlNode *)l->data);
      }
      break;

    case G_IDL_NODE_BOXED:
      {
	GIdlNodeBoxed *boxed = (GIdlNodeBoxed *)node;

	size = 20;
	for (l = boxed->members; l; l = l->next)
	  size += g_idl_node_get_size ((GIdlNode *)l->data);
      }
      break;

    case G_IDL_NODE_PROPERTY:
      size = 12;
      break;

    case G_IDL_NODE_SIGNAL:
      size = 12;
      break;

    case G_IDL_NODE_VFUNC:
      size = 16;
      break;

    case G_IDL_NODE_FIELD:
      size = 12;
      break;

    case G_IDL_NODE_CONSTANT:
      size = 20;
      break;

    case G_IDL_NODE_ERROR_DOMAIN:
      size = 16;
      break;

    case G_IDL_NODE_XREF:
      size = 0;
      break;

    case G_IDL_NODE_UNION:
      {
	GIdlNodeUnion *union_ = (GIdlNodeUnion *)node;

	size = 28;
	for (l = union_->members; l; l = l->next)
	  size += g_idl_node_get_size ((GIdlNode *)l->data);
	for (l = union_->discriminators; l; l = l->next)
	  size += g_idl_node_get_size ((GIdlNode *)l->data);
      }
      break;

    default: 
      g_error ("Unhandled node type %d\n", node->type);
      size = 0;
    }

  g_debug ("node %p type %d size %d", node, node->type, size);

  return size;
}

/* returns the full size of the blob including variable-size parts */
guint32
g_idl_node_get_full_size (GIdlNode *node)
{
  GList *l;
  gint size, n;

  g_assert (node != NULL);

  switch (node->type)
    {
    case G_IDL_NODE_CALLBACK:
      {
	GIdlNodeFunction *function = (GIdlNodeFunction *)node;
	size = 12; 
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	for (l = function->parameters; l; l = l->next)
	  size += g_idl_node_get_full_size ((GIdlNode *)l->data);
	size += g_idl_node_get_full_size ((GIdlNode *)function->result);
      }
      break;

    case G_IDL_NODE_FUNCTION:
      {
	GIdlNodeFunction *function = (GIdlNodeFunction *)node;
	size = 24;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	size += ALIGN_VALUE (strlen (function->symbol) + 1, 4);
	for (l = function->parameters; l; l = l->next)
	  size += g_idl_node_get_full_size ((GIdlNode *)l->data);
	size += g_idl_node_get_full_size ((GIdlNode *)function->result);
      }
      break;

    case G_IDL_NODE_PARAM:
      {
	GIdlNodeParam *param = (GIdlNodeParam *)node;
	
	size = 12;
	if (node->name)
	  size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	size += g_idl_node_get_full_size ((GIdlNode *)param->type);	
      }
      break;

    case G_IDL_NODE_TYPE:
      {
	GIdlNodeType *type = (GIdlNodeType *)node;
	if (type->tag < TYPE_TAG_ARRAY) 
	  size = 4;
	else
	  {
	    switch (type->tag)
	      {
	      case TYPE_TAG_ARRAY:
		size = 4 + 4;
		if (type->parameter_type1)
		  size += g_idl_node_get_full_size ((GIdlNode *)type->parameter_type1);
		break;
	      case TYPE_TAG_INTERFACE:
		size = 4 + 4;
		break;
	      case TYPE_TAG_LIST:
	      case TYPE_TAG_SLIST:
		size = 4 + 4;
		if (type->parameter_type1)
		  size += g_idl_node_get_full_size ((GIdlNode *)type->parameter_type1);
		break;
	      case TYPE_TAG_HASH:
		size = 4 + 4 + 4;
		if (type->parameter_type1)
		  size += g_idl_node_get_full_size ((GIdlNode *)type->parameter_type1);
		if (type->parameter_type2)
		  size += g_idl_node_get_full_size ((GIdlNode *)type->parameter_type2);
		break;
	      case TYPE_TAG_ERROR:
		{
		  gint n;
		  
		  if (type->errors)
		    n = g_strv_length (type->errors);
		  else
		    n = 0;

		  size = 4 + 4 + 2 * (n + n % 2);
		}
		break;
	      default:
		g_error ("Unknown type tag %d\n", type->tag);
		break;
	      }
	  }
      }
      break;

    case G_IDL_NODE_OBJECT:
      {
	GIdlNodeInterface *iface = (GIdlNodeInterface *)node;

	n = g_list_length (iface->interfaces);
	size = 32;
	if (iface->parent)
	  size += ALIGN_VALUE (strlen (iface->parent) + 1, 4);
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	size += ALIGN_VALUE (strlen (iface->gtype_name) + 1, 4);
	size += ALIGN_VALUE (strlen (iface->gtype_init) + 1, 4);
	size += 2 * (n + (n % 2));

	for (l = iface->members; l; l = l->next)
	  size += g_idl_node_get_full_size ((GIdlNode *)l->data);
      }
      break;

    case G_IDL_NODE_INTERFACE:
      {
	GIdlNodeInterface *iface = (GIdlNodeInterface *)node;

	n = g_list_length (iface->prerequisites);
	size = 28;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	size += ALIGN_VALUE (strlen (iface->gtype_name) + 1, 4);
	size += ALIGN_VALUE (strlen (iface->gtype_init) + 1, 4);
	size += 2 * (n + (n % 2));

	for (l = iface->members; l; l = l->next)
	  size += g_idl_node_get_full_size ((GIdlNode *)l->data);
      }
      break;

    case G_IDL_NODE_ENUM:
    case G_IDL_NODE_FLAGS:
      {
	GIdlNodeEnum *enum_ = (GIdlNodeEnum *)node;
	
	size = 20;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	if (enum_->gtype_name)
	  {
	    size += ALIGN_VALUE (strlen (enum_->gtype_name) + 1, 4);
	    size += ALIGN_VALUE (strlen (enum_->gtype_init) + 1, 4);
	  }

	for (l = enum_->values; l; l = l->next)
	  size += g_idl_node_get_full_size ((GIdlNode *)l->data);	
      }
      break;

    case G_IDL_NODE_VALUE:
      {
	size = 12;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
      }
      break;

    case G_IDL_NODE_STRUCT:
      {
	GIdlNodeStruct *struct_ = (GIdlNodeStruct *)node;

	size = 20;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	for (l = struct_->members; l; l = l->next)
	  size += g_idl_node_get_full_size ((GIdlNode *)l->data);
      }
      break;

    case G_IDL_NODE_BOXED:
      {
	GIdlNodeBoxed *boxed = (GIdlNodeBoxed *)node;

	size = 20;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	if (boxed->gtype_name)
	  {
	    size += ALIGN_VALUE (strlen (boxed->gtype_name) + 1, 4);
	    size += ALIGN_VALUE (strlen (boxed->gtype_init) + 1, 4);
	  }
	for (l = boxed->members; l; l = l->next)
	  size += g_idl_node_get_full_size ((GIdlNode *)l->data);
      }
      break;

    case G_IDL_NODE_PROPERTY:
      {
	GIdlNodeProperty *prop = (GIdlNodeProperty *)node;
	
	size = 12;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	size += g_idl_node_get_full_size ((GIdlNode *)prop->type);	
      }
      break;

    case G_IDL_NODE_SIGNAL:
      {
	GIdlNodeSignal *signal = (GIdlNodeSignal *)node;

	size = 12;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	for (l = signal->parameters; l; l = l->next)
	  size += g_idl_node_get_full_size ((GIdlNode *)l->data);
	size += g_idl_node_get_full_size ((GIdlNode *)signal->result);
      }
      break;

    case G_IDL_NODE_VFUNC:
      {
	GIdlNodeVFunc *vfunc = (GIdlNodeVFunc *)node;

	size = 16;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	for (l = vfunc->parameters; l; l = l->next)
	  size += g_idl_node_get_full_size ((GIdlNode *)l->data);
	size += g_idl_node_get_full_size ((GIdlNode *)vfunc->result);
      }
      break;

    case G_IDL_NODE_FIELD:
      {
	GIdlNodeField *field = (GIdlNodeField *)node;

	size = 12;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	size += g_idl_node_get_full_size ((GIdlNode *)field->type);	
      }
      break;

    case G_IDL_NODE_CONSTANT:
      {
	GIdlNodeConstant *constant = (GIdlNodeConstant *)node;

	size = 20;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	/* FIXME non-string values */
	size += ALIGN_VALUE (strlen (constant->value) + 1, 4);
	size += g_idl_node_get_full_size ((GIdlNode *)constant->type);	
      }
      break;

    case G_IDL_NODE_ERROR_DOMAIN:
      {
	GIdlNodeErrorDomain *domain = (GIdlNodeErrorDomain *)node;

	size = 16;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	size += ALIGN_VALUE (strlen (domain->getquark) + 1, 4);
      }
      break;

    case G_IDL_NODE_XREF:
      {
	GIdlNodeXRef *xref = (GIdlNodeXRef *)node;
	
	size = 0;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	size += ALIGN_VALUE (strlen (xref->namespace) + 1, 4);
      }
      break;

    case G_IDL_NODE_UNION:
      {
	GIdlNodeUnion *union_ = (GIdlNodeUnion *)node;

	size = 28;
	size += ALIGN_VALUE (strlen (node->name) + 1, 4);
	for (l = union_->members; l; l = l->next)
	  size += g_idl_node_get_full_size ((GIdlNode *)l->data);
	for (l = union_->discriminators; l; l = l->next)
	  size += g_idl_node_get_full_size ((GIdlNode *)l->data);
      }
      break;

    default: 
      g_error ("Unknown type tag %d\n", node->type);
      size = 0;
    }

  g_debug ("node %p type %d full size %d", node, node->type, size);

  return size;
}

int
g_idl_node_cmp (GIdlNode *node,
		GIdlNode *other)
{
  if (node->type < other->type)
    return -1;
  else if (node->type > other->type)
    return 1;
  else
    return strcmp (node->name, other->name);
}

gboolean
g_idl_node_can_have_member (GIdlNode    *node)
{
  switch (node->type)
    {
    case G_IDL_NODE_OBJECT:
    case G_IDL_NODE_INTERFACE:
    case G_IDL_NODE_BOXED:
    case G_IDL_NODE_STRUCT:
    case G_IDL_NODE_UNION:
      return TRUE;
    default:
      break;
    };
  return FALSE;
}

void
g_idl_node_add_member (GIdlNode         *node,
		       GIdlNodeFunction *member)
{
  g_return_if_fail (node != NULL);
  g_return_if_fail (member != NULL);
		    
  switch (node->type)
    {
    case G_IDL_NODE_OBJECT:
    case G_IDL_NODE_INTERFACE:
      {
	GIdlNodeInterface *iface = (GIdlNodeInterface *)node;
	iface->members =
	  g_list_insert_sorted (iface->members, member,
				(GCompareFunc) g_idl_node_cmp);
	break;
      }
    case G_IDL_NODE_BOXED:
      {
	GIdlNodeBoxed *boxed = (GIdlNodeBoxed *)node;
	boxed->members =
	  g_list_insert_sorted (boxed->members, member,
				(GCompareFunc) g_idl_node_cmp);
	break;
      }
    case G_IDL_NODE_STRUCT:
      {
	GIdlNodeStruct *struct_ = (GIdlNodeStruct *)node;
	struct_->members =
	  g_list_insert_sorted (struct_->members, member,
				(GCompareFunc) g_idl_node_cmp);
	break;
      }
    case G_IDL_NODE_UNION:
      {
	GIdlNodeUnion *union_ = (GIdlNodeUnion *)node;
	union_->members =
	  g_list_insert_sorted (union_->members, member,
				(GCompareFunc) g_idl_node_cmp);
	break;
      }
    default:
      g_error ("Cannot add a member to unknown type tag type %d\n",
	       node->type);
      break;
    }
}

static gint64
parse_int_value (const gchar *str)
{
  return strtoll (str, NULL, 0);
}

static guint64
parse_uint_value (const gchar *str)
{
  return strtoull (str, NULL, 0);
}

static gdouble
parse_float_value (const gchar *str)
{
  return strtod (str, NULL);
}

static gboolean
parse_boolean_value (const gchar *str)
{
  if (strcmp (str, "TRUE") == 0)
    return TRUE;
  
  if (strcmp (str, "FALSE") == 0)
    return FALSE;

  return parse_int_value (str) ? TRUE : FALSE;
}

static GIdlNode *
find_entry_node (GIdlModule  *module,
		 GList       *modules,
		 const gchar *name,
		 guint16     *idx)

{
  GList *l;
  gint i;
  gchar **names;
  gint n_names;
  GIdlNode *result = NULL;

  names = g_strsplit (name, ".", 0);
  n_names = g_strv_length (names);
  if (n_names > 2)
    g_error ("Too many name parts");
  
  for (l = module->entries, i = 1; l; l = l->next, i++)
    {
      GIdlNode *node = (GIdlNode *)l->data;
      
      if (n_names > 1)
	{
	  if (node->type != G_IDL_NODE_XREF)
	    continue;
	  
	  if (((GIdlNodeXRef *)node)->namespace == NULL ||
	      strcmp (((GIdlNodeXRef *)node)->namespace, names[0]) != 0)
	    continue;
	}
	 
      if (strcmp (node->name, names[n_names - 1]) == 0)
	{
	  if (idx)
	    *idx = i;
	  
	  result = node;
	  goto out;
	}
    }

  if (n_names > 1)
    {
      GIdlNode *node = g_idl_node_new (G_IDL_NODE_XREF);

      ((GIdlNodeXRef *)node)->namespace = g_strdup (names[0]);
      node->name = g_strdup (names[1]);
  
      module->entries = g_list_append (module->entries, node);
  
      if (idx)
	*idx = g_list_length (module->entries);

      result = node;

      goto out;
    }

  g_warning ("Entry %s not found", name);

 out:

  g_strfreev (names);

  return result;
}

static guint16
find_entry (GIdlModule  *module,
	    GList       *modules,
	    const gchar *name)
{
  guint16 idx = 0;

  find_entry_node (module, modules, name, &idx);

  return idx;
}

static void
serialize_type (GIdlModule   *module, 
		GList        *modules,
		GIdlNodeType *node, 
		GString      *str)
{
  gint i;
  const gchar* basic[] = {
    "void", 
    "gboolean", 
    "gint8", 
    "guint8", 
    "gint16", 
    "guint16", 
    "gint32", 
    "guint32", 
    "gint64", 
    "guint64", 
    "gint",
    "guint",
    "glong",
    "gulong",
    "gssize",
    "gsize",
    "gfloat", 
    "gdouble", 
    "utf8", 
    "filename"
  };
  
  if (node->tag < 20)
    {
      g_string_append_printf (str, "%s%s", 
			      basic[node->tag], node->is_pointer ? "*" : "");
    }
  else if (node->tag == 20)
    {
      serialize_type (module, modules, node->parameter_type1, str);
      g_string_append (str, "[");

      if (node->has_length)
	g_string_append_printf (str, "length=%d", node->length);
      
      if (node->zero_terminated)
	g_string_append_printf (str, "%szero-terminated=1", 
				node->has_length ? "," : "");
      
      g_string_append (str, "]");
    }
  else if (node->tag == 21)
    {
      GIdlNode *iface;
      gchar *name;

      iface = find_entry_node (module, modules, node->interface, NULL);
      if (iface)
	name = iface->name;
      else
	{
	  g_warning ("Interface for type reference %s not found", node->interface);
	  name = node->interface;
	}

      g_string_append_printf (str, "%s%s", name, node->is_pointer ? "*" : "");
    }
  else if (node->tag == 22)
    {
      g_string_append (str, "GList");
      if (node->parameter_type1)
	{
	  g_string_append (str, "<"); 
	  serialize_type (module, modules, node->parameter_type1, str);
	  g_string_append (str, ">"); 
	}
    }
  else if (node->tag == 23)
    {
      g_string_append (str, "GSList");
      if (node->parameter_type1)
	{
	  g_string_append (str, "<"); 
	  serialize_type (module, modules, node->parameter_type1, str);
	  g_string_append (str, ">"); 
	}
    }
  else if (node->tag == 24)
    {
      g_string_append (str, "GHashTable<");
      if (node->parameter_type1)
	{
	  g_string_append (str, "<"); 
	  serialize_type (module, modules, node->parameter_type1, str);
	  g_string_append (str, ","); 
	  serialize_type (module, modules, node->parameter_type2, str);
	  g_string_append (str, ">"); 
	}
    }
  else if (node->tag == 25) 
    {
      g_string_append (str, "GError");
      if (node->errors)
	{
	  g_string_append (str, "<"); 
	  for (i = 0; node->errors[i]; i++)
	    {
	      if (i > 0)
		g_string_append (str, ",");
	      g_string_append (str, node->errors[i]);
	    }
	  g_string_append (str, ">"); 
	}
    }
}

void
g_idl_node_build_metadata (GIdlNode   *node,
			   GIdlModule *module,
			   GList      *modules,
			   GHashTable *strings,
			   GHashTable *types,
			   guchar     *data,
			   guint32    *offset,
                           guint32    *offset2)
{
  GList *l;
  guint32 old_offset = *offset;
  guint32 old_offset2 = *offset2;

  switch (node->type)
    {
    case G_IDL_NODE_TYPE:
      {
	GIdlNodeType *type = (GIdlNodeType *)node;
	SimpleTypeBlob *blob = (SimpleTypeBlob *)&data[*offset];

	*offset += 4;
	
	if (type->tag < TYPE_TAG_ARRAY)
	  {
	    blob->reserved = 0;
	    blob->reserved2 = 0;
	    blob->pointer = type->is_pointer;
	    blob->reserved3 = 0;
	    blob->tag = type->tag;
	  }
	else 
	  {
	    GString *str;
	    gchar *s;
	    gpointer value;
	    
	    str = g_string_new (0);
	    serialize_type (module, modules, type, str);
	    s = g_string_free (str, FALSE);
	    
	    types_count += 1;
	    value = g_hash_table_lookup (types, s);
	    if (value)
	      {
		blob->offset = GPOINTER_TO_INT (value);
		g_free (s);
	      }
	    else
	      {
		unique_types_count += 1;
		g_hash_table_insert (types, s, GINT_TO_POINTER(*offset2));
				     
		blob->offset = *offset2;
		switch (type->tag)
		  {
		  case TYPE_TAG_ARRAY:
		    {
		      ArrayTypeBlob *array = (ArrayTypeBlob *)&data[*offset2];
		      guint32 pos;
		      
		      array->pointer = 1;
		      array->reserved = 0;
		      array->tag = type->tag;
		      array->zero_terminated = type->zero_terminated;
		      array->has_length = type->has_length;
		      array->reserved2 = 0;
		      array->length = type->length;
		      
		      pos = *offset2 + 4;
		      *offset2 += 8;
		      
		      g_idl_node_build_metadata ((GIdlNode *)type->parameter_type1, 
						 module, modules, strings, types, 
						 data, &pos, offset2);
		    }
		    break;
		    
		  case TYPE_TAG_INTERFACE:
		    {
		      InterfaceTypeBlob *iface = (InterfaceTypeBlob *)&data[*offset2];
		      *offset2 += 4;

		      iface->pointer = type->is_pointer;
		      iface->reserved = 0;
		      iface->tag = type->tag;
		      iface->reserved2 = 0;
		      iface->interface = find_entry (module, modules, type->interface);

		    }
		    break;
		    
		  case TYPE_TAG_LIST:
		  case TYPE_TAG_SLIST:
		    {
		      ParamTypeBlob *param = (ParamTypeBlob *)&data[*offset2];
		      guint32 pos;
		      
		      param->pointer = 1;
		      param->reserved = 0;
		      param->tag = type->tag;
		      param->reserved2 = 0;
		      param->n_types = 1;
		      
		      pos = *offset2 + 4;
		      *offset2 += 8;
		      
		      g_idl_node_build_metadata ((GIdlNode *)type->parameter_type1, 
						 module, modules, strings, types,
						 data, &pos, offset2);
		    }
		    break;
		    
		  case TYPE_TAG_HASH:
		    {
		      ParamTypeBlob *param = (ParamTypeBlob *)&data[*offset2];
		      guint32 pos;
		      
		      param->pointer = 1;
		      param->reserved = 0;
		      param->tag = type->tag;
		      param->reserved2 = 0;
		      param->n_types = 2;
		      
		      pos = *offset2 + 4;
		      *offset2 += 12;
		      
		      g_idl_node_build_metadata ((GIdlNode *)type->parameter_type1, 
						 module, modules, strings, types, 
						 data, &pos, offset2);
		      g_idl_node_build_metadata ((GIdlNode *)type->parameter_type2, 
						 module, modules, strings, types, 
						 data, &pos, offset2);
		    }
		    break;
		    
		  case TYPE_TAG_ERROR:
		    {
		      ErrorTypeBlob *blob = (ErrorTypeBlob *)&data[*offset2];
		      gint i;
		      
		      blob->pointer = 1;
		      blob->reserved = 0;
		      blob->tag = type->tag;
		      blob->reserved2 = 0;
		      if (type->errors) 
			blob->n_domains = g_strv_length (type->errors);
		      else
			blob->n_domains = 0;
		      
		      *offset2 = ALIGN_VALUE (*offset2 + 4 + 2 * blob->n_domains, 4);
		      for (i = 0; i < blob->n_domains; i++)
			blob->domains[i] = find_entry (module, modules, type->errors[i]);
		    }
		    break;
		    
		  default:
		    g_error ("Unknown type tag %d\n", type->tag);
		    break;
		  }
	      }
	  }
      }
      break;

    case G_IDL_NODE_FIELD:
      {
	GIdlNodeField *field = (GIdlNodeField *)node;
	FieldBlob *blob;

	blob = (FieldBlob *)&data[*offset];
	*offset += 8;

	blob->name = write_string (node->name, strings, data, offset2);
	blob->readable = field->readable;
	blob->writable = field->writable;
	blob->reserved = 0;
	blob->bits = 0;
	blob->struct_offset = field->offset;

        g_idl_node_build_metadata ((GIdlNode *)field->type, 
				   module, modules, strings, types,
				   data, offset, offset2);
      }
      break;

    case G_IDL_NODE_PROPERTY:
      {
	GIdlNodeProperty *prop = (GIdlNodeProperty *)node;
	PropertyBlob *blob = (PropertyBlob *)&data[*offset];
	*offset += 8;

	blob->name = write_string (node->name, strings, data, offset2);
	blob->deprecated = prop->deprecated;
	blob->readable = prop->readable;
 	blob->writable = prop->writable;
 	blob->construct = prop->construct;
 	blob->construct_only = prop->construct_only;
	blob->reserved = 0;

        g_idl_node_build_metadata ((GIdlNode *)prop->type, 
				   module, modules, strings, types,
				   data, offset, offset2);
      }
      break;

    case G_IDL_NODE_FUNCTION:
      {
	FunctionBlob *blob = (FunctionBlob *)&data[*offset];
	SignatureBlob *blob2 = (SignatureBlob *)&data[*offset2];
	GIdlNodeFunction *function = (GIdlNodeFunction *)node;
	guint32 signature;
	gint n;

	signature = *offset2;
	n = g_list_length (function->parameters);

	*offset += 16;
	*offset2 += 8 + n * 12;

	blob->blob_type = BLOB_TYPE_FUNCTION;
	blob->deprecated = function->deprecated;
	blob->setter = function->is_setter;
	blob->getter = function->is_getter;
	blob->constructor = function->is_constructor;
	blob->wraps_vfunc = function->wraps_vfunc;
	blob->reserved = 0;
	blob->index = 0;
	blob->name = write_string (node->name, strings, data, offset2);
	blob->symbol = write_string (function->symbol, strings, data, offset2);
	blob->signature = signature;
	
        g_idl_node_build_metadata ((GIdlNode *)function->result->type, 
				   module, modules, strings, types,
				   data, &signature, offset2);

	blob2->may_return_null = function->result->null_ok;
	blob2->caller_owns_return_value = function->result->transfer;
	blob2->caller_owns_return_container = function->result->shallow_transfer;
	blob2->reserved = 0;
	blob2->n_arguments = n;

	signature += 4;
	
	for (l = function->parameters; l; l = l->next)
	  {
	    GIdlNode *param = (GIdlNode *)l->data;

	    g_idl_node_build_metadata (param, 
				       module, modules, strings, types,
				       data, &signature, offset2);
	  }
      }
      break;

    case G_IDL_NODE_CALLBACK:
      {
	CallbackBlob *blob = (CallbackBlob *)&data[*offset];
	SignatureBlob *blob2 = (SignatureBlob *)&data[*offset2];
	GIdlNodeFunction *function = (GIdlNodeFunction *)node;
	guint32 signature;
	gint n;

	signature = *offset2;
	n = g_list_length (function->parameters);

	*offset += 12;
	*offset2 += 8 + n * 12;

	blob->blob_type = BLOB_TYPE_CALLBACK;
	blob->deprecated = function->deprecated;
	blob->reserved = 0;
	blob->name = write_string (node->name, strings, data, offset2);
	blob->signature = signature;
	
        g_idl_node_build_metadata ((GIdlNode *)function->result->type, 
				   module, modules, strings, types,
				   data, &signature, offset2);

	blob2->may_return_null = function->result->null_ok;
	blob2->caller_owns_return_value = function->result->transfer;
	blob2->caller_owns_return_container = function->result->shallow_transfer;
	blob2->reserved = 0;
	blob2->n_arguments = n;

	signature += 4;
	
	for (l = function->parameters; l; l = l->next)
	  {
	    GIdlNode *param = (GIdlNode *)l->data;

	    g_idl_node_build_metadata (param, 
				       module, modules, strings, types,
				       data, &signature, offset2);
	  }
      }
      break;

    case G_IDL_NODE_SIGNAL:
      {
	SignalBlob *blob = (SignalBlob *)&data[*offset];
	SignatureBlob *blob2 = (SignatureBlob *)&data[*offset2];
	GIdlNodeSignal *signal = (GIdlNodeSignal *)node;
	guint32 signature;
	gint n;

	signature = *offset2;
	n = g_list_length (signal->parameters);

	*offset += 12;
	*offset2 += 8 + n * 12;

	blob->deprecated = signal->deprecated;
	blob->run_first = signal->run_first;
	blob->run_last = signal->run_last;
	blob->run_cleanup = signal->run_cleanup;
	blob->no_recurse = signal->no_recurse;
	blob->detailed = signal->detailed;
	blob->action = signal->action;
	blob->no_hooks = signal->no_hooks;
	blob->has_class_closure = 0; /* FIXME */
	blob->true_stops_emit = 0; /* FIXME */
	blob->reserved = 0;
	blob->class_closure = 0; /* FIXME */
	blob->name = write_string (node->name, strings, data, offset2);
	blob->signature = signature;
	
        g_idl_node_build_metadata ((GIdlNode *)signal->result->type, 
				   module, modules, strings, types,
				   data, &signature, offset2);

	blob2->may_return_null = signal->result->null_ok;
	blob2->caller_owns_return_value = signal->result->transfer;
	blob2->caller_owns_return_container = signal->result->shallow_transfer;
	blob2->reserved = 0;
	blob2->n_arguments = n;

	signature += 4;
	
	for (l = signal->parameters; l; l = l->next)
	  {
	    GIdlNode *param = (GIdlNode *)l->data;

	    g_idl_node_build_metadata (param, module, modules, strings, types,
				       data, &signature, offset2);
	  }
      }
      break;

    case G_IDL_NODE_VFUNC:
      {
	VFuncBlob *blob = (VFuncBlob *)&data[*offset];
	SignatureBlob *blob2 = (SignatureBlob *)&data[*offset2];
	GIdlNodeVFunc *vfunc = (GIdlNodeVFunc *)node;
	guint32 signature;
	gint n;

	signature = *offset2;
	n = g_list_length (vfunc->parameters);

	*offset += 16;
	*offset2 += 8 + n * 12;

	blob->name = write_string (node->name, strings, data, offset2);
	blob->must_chain_up = 0; /* FIXME */
	blob->must_be_implemented = 0; /* FIXME */
	blob->must_not_be_implemented = 0; /* FIXME */
	blob->class_closure = 0; /* FIXME */
	blob->reserved = 0;

	blob->struct_offset = vfunc->offset;
	blob->reserved2 = 0;
	blob->signature = signature;
	
        g_idl_node_build_metadata ((GIdlNode *)vfunc->result->type, 
				   module, modules, strings, types,
				   data, &signature, offset2);

	blob2->may_return_null = vfunc->result->null_ok;
	blob2->caller_owns_return_value = vfunc->result->transfer;
	blob2->caller_owns_return_container = vfunc->result->shallow_transfer;
	blob2->reserved = 0;
	blob2->n_arguments = n;

	signature += 4;
	
	for (l = vfunc->parameters; l; l = l->next)
	  {
	    GIdlNode *param = (GIdlNode *)l->data;

	    g_idl_node_build_metadata (param, module, modules, strings, 
				       types, data, &signature, offset2);
	  }
      }
      break;

    case G_IDL_NODE_PARAM:
      {
	ArgBlob *blob = (ArgBlob *)&data[*offset];
	GIdlNodeParam *param = (GIdlNodeParam *)node;

	*offset += 8;

 	blob->name = write_string (node->name, strings, data, offset2);
 	blob->in = param->in;
 	blob->out = param->out;
 	blob->dipper = param->dipper;
	blob->null_ok = param->null_ok;
	blob->optional = param->optional;
	blob->transfer_ownership = param->transfer;
	blob->transfer_container_ownership = param->shallow_transfer;
	blob->return_value = param->retval;
	blob->reserved = 0;

        g_idl_node_build_metadata ((GIdlNode *)param->type, module, modules, 
				   strings, types, data, offset, offset2);
      }
      break;

    case G_IDL_NODE_STRUCT:
      {
	StructBlob *blob = (StructBlob *)&data[*offset];
	GIdlNodeStruct *struct_ = (GIdlNodeStruct *)node;
	
	blob->blob_type = BLOB_TYPE_STRUCT;
	blob->deprecated = struct_->deprecated;
	blob->unregistered = TRUE;
	blob->reserved = 0;
	blob->name = write_string (node->name, strings, data, offset2);
	blob->gtype_name = 0;
	blob->gtype_init = 0;

	blob->n_fields = 0;
	blob->n_methods = 0;

	*offset += 20; 
	for (l = struct_->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_FIELD)
	      {
		blob->n_fields++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	for (l = struct_->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;
	    
	    if (member->type == G_IDL_NODE_FUNCTION)
	      {
		blob->n_methods++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }
      }
      break;

    case G_IDL_NODE_BOXED:
      {
	StructBlob *blob = (StructBlob *)&data[*offset];
	GIdlNodeBoxed *boxed = (GIdlNodeBoxed *)node;

	blob->blob_type = BLOB_TYPE_BOXED;
	blob->deprecated = boxed->deprecated;
	blob->unregistered = FALSE;
	blob->reserved = 0;
	blob->name = write_string (node->name, strings, data, offset2);
	blob->gtype_name = write_string (boxed->gtype_name, strings, data, offset2);
	blob->gtype_init = write_string (boxed->gtype_init, strings, data, offset2);

	blob->n_fields = 0;
	blob->n_methods = 0;

	*offset += 20; 
	for (l = boxed->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_FIELD)
	      {
		blob->n_fields++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	for (l = boxed->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_FUNCTION)
	      {
		blob->n_methods++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }
      }
      break;

    case G_IDL_NODE_UNION:
      {
	UnionBlob *blob = (UnionBlob *)&data[*offset];
	GIdlNodeUnion *union_ = (GIdlNodeUnion *)node;

	blob->blob_type = BLOB_TYPE_UNION;
	blob->deprecated = union_->deprecated;
 	blob->reserved = 0;
	blob->name = write_string (node->name, strings, data, offset2);
	if (union_->gtype_name)
	  {
	    blob->unregistered = FALSE;
	    blob->gtype_name = write_string (union_->gtype_name, strings, data, offset2);
	    blob->gtype_init = write_string (union_->gtype_init, strings, data, offset2);
	  }
	else
	  {
	    blob->unregistered = TRUE;
	    blob->gtype_name = 0;
	    blob->gtype_init = 0;
	  }

	blob->n_fields = 0;
	blob->n_functions = 0;

	blob->discriminator_offset = union_->discriminator_offset;

	if (union_->discriminator_type)
	  {
	    *offset += 24;
	    blob->discriminated = TRUE;
	    g_idl_node_build_metadata ((GIdlNode *)union_->discriminator_type, 
				       module, modules, strings, types,
				       data, offset, offset2);
	  }
	else 
	  {
	    *offset += 28;
	    blob->discriminated = FALSE;
	    blob->discriminator_type.offset = 0;
	  }
	
	
	for (l = union_->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_FIELD)
	      {
		blob->n_fields++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	for (l = union_->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_FUNCTION)
	      {
		blob->n_functions++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	if (union_->discriminator_type)
	  {
	    for (l = union_->discriminators; l; l = l->next)
	      {
		GIdlNode *member = (GIdlNode *)l->data;
		
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }
      }
      break;

    case G_IDL_NODE_ENUM:
    case G_IDL_NODE_FLAGS:
      {
	EnumBlob *blob = (EnumBlob *)&data[*offset];
	GIdlNodeEnum *enum_ = (GIdlNodeEnum *)node;

	*offset += 20; 
	
	if (node->type == G_IDL_NODE_ENUM)
	  blob->blob_type = BLOB_TYPE_ENUM;
	else
	  blob->blob_type = BLOB_TYPE_FLAGS;
	  
	blob->deprecated = enum_->deprecated;
	blob->reserved = 0;
	blob->name = write_string (node->name, strings, data, offset2);
	if (enum_->gtype_name)
	  {
	    blob->unregistered = FALSE;
	    blob->gtype_name = write_string (enum_->gtype_name, strings, data, offset2);
	    blob->gtype_init = write_string (enum_->gtype_init, strings, data, offset2);
	  }
	else
	  {
	    blob->unregistered = TRUE;
	    blob->gtype_name = 0;
	    blob->gtype_init = 0;
	  }

	blob->n_values = 0;
	blob->reserved2 = 0;

	for (l = enum_->values; l; l = l->next)
	  {
	    GIdlNode *value = (GIdlNode *)l->data;

	    blob->n_values++;
	    g_idl_node_build_metadata (value, module, modules, strings, types,
				       data, offset, offset2);
	  }
      }
      break;
      
    case G_IDL_NODE_OBJECT:
      {
	ObjectBlob *blob = (ObjectBlob *)&data[*offset];
	GIdlNodeInterface *object = (GIdlNodeInterface *)node;

	blob->blob_type = BLOB_TYPE_OBJECT;
	blob->deprecated = object->deprecated;
	blob->reserved = 0;
	blob->name = write_string (node->name, strings, data, offset2);
	blob->gtype_name = write_string (object->gtype_name, strings, data, offset2);
	blob->gtype_init = write_string (object->gtype_init, strings, data, offset2);
	if (object->parent)
	  blob->parent = find_entry (module, modules, object->parent);
	else
	  blob->parent = 0;

	blob->n_interfaces = 0;
	blob->n_fields = 0;
	blob->n_properties = 0;
	blob->n_methods = 0;
	blob->n_signals = 0;
	blob->n_vfuncs = 0;
	blob->n_constants = 0;
	
	*offset += 32;
	for (l = object->interfaces; l; l = l->next)
	  {
	    blob->n_interfaces++;
	    *(guint16*)&data[*offset] = find_entry (module, modules, (gchar *)l->data);
	    *offset += 2;
	  }
	
	*offset = ALIGN_VALUE (*offset, 4);
	for (l = object->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_FIELD)
	      {
		blob->n_fields++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	*offset = ALIGN_VALUE (*offset, 4);
	for (l = object->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_PROPERTY)
	      {
		blob->n_properties++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	*offset = ALIGN_VALUE (*offset, 4);
	for (l = object->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_FUNCTION)
	      {
		blob->n_methods++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	*offset = ALIGN_VALUE (*offset, 4);
	for (l = object->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_SIGNAL)
	      {
		blob->n_signals++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	*offset = ALIGN_VALUE (*offset, 4);
	for (l = object->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_VFUNC)
	      {
		blob->n_vfuncs++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	*offset = ALIGN_VALUE (*offset, 4);
	for (l = object->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_CONSTANT)
	      {
		blob->n_constants++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }
      }
      break;

    case G_IDL_NODE_INTERFACE:
      {
	InterfaceBlob *blob = (InterfaceBlob *)&data[*offset];
	GIdlNodeInterface *iface = (GIdlNodeInterface *)node;

	blob->blob_type = BLOB_TYPE_INTERFACE;
	blob->deprecated = iface->deprecated;
	blob->reserved = 0;
	blob->name = write_string (node->name, strings, data, offset2);
	blob->gtype_name = write_string (iface->gtype_name, strings, data, offset2);
	blob->gtype_init = write_string (iface->gtype_init, strings, data, offset2);
	blob->n_prerequisites = 0;
	blob->n_properties = 0;
	blob->n_methods = 0;
	blob->n_signals = 0;
	blob->n_vfuncs = 0;
	blob->n_constants = 0;
	
	*offset += 28;
	for (l = iface->prerequisites; l; l = l->next)
	  {
	    blob->n_prerequisites++;
	    *(guint16*)&data[*offset] = find_entry (module, modules, (gchar *)l->data);
	    *offset += 2;
	  }
	
	*offset = ALIGN_VALUE (*offset, 4);
	for (l = iface->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_PROPERTY)
	      {
		blob->n_properties++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	*offset = ALIGN_VALUE (*offset, 4);
	for (l = iface->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_FUNCTION)
	      {
		blob->n_methods++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	*offset = ALIGN_VALUE (*offset, 4);
	for (l = iface->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_SIGNAL)
	      {
		blob->n_signals++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	*offset = ALIGN_VALUE (*offset, 4);
	for (l = iface->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_VFUNC)
	      {
		blob->n_vfuncs++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }

	*offset = ALIGN_VALUE (*offset, 4);
	for (l = iface->members; l; l = l->next)
	  {
	    GIdlNode *member = (GIdlNode *)l->data;

	    if (member->type == G_IDL_NODE_CONSTANT)
	      {
		blob->n_constants++;
		g_idl_node_build_metadata (member, module, modules, strings, 
					   types, data, offset, offset2);
	      }
	  }
      }
      break;


    case G_IDL_NODE_VALUE:
      {
	GIdlNodeValue *value = (GIdlNodeValue *)node;
	ValueBlob *blob = (ValueBlob *)&data[*offset];
	*offset += 12;

	blob->deprecated = value->deprecated;
	blob->reserved = 0;
	blob->name = write_string (node->name, strings, data, offset2);
	blob->value = value->value;
      }
      break;

    case G_IDL_NODE_ERROR_DOMAIN:
      {
	GIdlNodeErrorDomain *domain = (GIdlNodeErrorDomain *)node;
	ErrorDomainBlob *blob = (ErrorDomainBlob *)&data[*offset];
	*offset += 16;

	blob->blob_type = BLOB_TYPE_ERROR_DOMAIN;
	blob->deprecated = domain->deprecated;
	blob->reserved = 0;
	blob->name = write_string (node->name, strings, data, offset2);
	blob->get_quark = write_string (domain->getquark, strings, data, offset2);
	blob->error_codes = find_entry (module, modules, domain->codes);
	blob->reserved2 = 0;
      }
      break;

    case G_IDL_NODE_CONSTANT:
      {
	GIdlNodeConstant *constant = (GIdlNodeConstant *)node;
	ConstantBlob *blob = (ConstantBlob *)&data[*offset];
	guint32 pos;

	pos = *offset + 8;
	*offset += 20;

	blob->blob_type = BLOB_TYPE_CONSTANT;
	blob->deprecated = constant->deprecated;
	blob->reserved = 0;
	blob->name = write_string (node->name, strings, data, offset2);

	blob->offset = *offset2;
	switch (constant->type->tag)
	  {
	  case TYPE_TAG_BOOLEAN:
	    blob->size = 4;
	    *(gboolean*)&data[blob->offset] = parse_boolean_value (constant->value);
	    break;
	    case TYPE_TAG_INT8:
	    blob->size = 1;
	      *(gint8*)&data[blob->offset] = (gint8) parse_int_value (constant->value);
	    break;
	  case TYPE_TAG_UINT8:
	    blob->size = 1;
	    *(guint8*)&data[blob->offset] = (guint8) parse_uint_value (constant->value);
	    break;
	  case TYPE_TAG_INT16:
	    blob->size = 2;
	    *(gint16*)&data[blob->offset] = (gint16) parse_int_value (constant->value);
	    break;
	  case TYPE_TAG_UINT16:
	    blob->size = 2;
	    *(guint16*)&data[blob->offset] = (guint16) parse_uint_value (constant->value);
	    break;
	  case TYPE_TAG_INT32:
	    blob->size = 4;
	    *(gint32*)&data[blob->offset] = (gint32) parse_int_value (constant->value);
	    break;
	  case TYPE_TAG_UINT32:
	    blob->size = 4;
	    *(guint32*)&data[blob->offset] = (guint32) parse_uint_value (constant->value);
	    break;
	  case TYPE_TAG_INT64:
	    blob->size = 8;
	    *(gint64*)&data[blob->offset] = (gint64) parse_int_value (constant->value);
	    break;
	  case TYPE_TAG_UINT64:
	    blob->size = 8;
	    *(guint64*)&data[blob->offset] = (guint64) parse_uint_value (constant->value);
	    break;
	  case TYPE_TAG_INT:
	    blob->size = sizeof (gint);
	    *(gint*)&data[blob->offset] = (gint) parse_int_value (constant->value);
	    break;
	  case TYPE_TAG_UINT:
	    blob->size = sizeof (guint);
	    *(gint*)&data[blob->offset] = (guint) parse_uint_value (constant->value);
	    break;
	  case TYPE_TAG_SSIZE: /* FIXME */
	  case TYPE_TAG_LONG:
	    blob->size = sizeof (glong);
	    *(glong*)&data[blob->offset] = (glong) parse_int_value (constant->value);
	    break;
	  case TYPE_TAG_SIZE: /* FIXME */
	  case TYPE_TAG_ULONG:
	    blob->size = sizeof (gulong);
	    *(gulong*)&data[blob->offset] = (gulong) parse_uint_value (constant->value);
	    break;
	  case TYPE_TAG_FLOAT:
	    blob->size = sizeof (gfloat);
	    *(gfloat*)&data[blob->offset] = (gfloat) parse_float_value (constant->value);
	    break;
	  case TYPE_TAG_DOUBLE:
	    blob->size = sizeof (gdouble);
	    *(gdouble*)&data[blob->offset] = (gdouble) parse_float_value (constant->value);
	    break;
	  case TYPE_TAG_UTF8:
	  case TYPE_TAG_FILENAME:
	    blob->size = strlen (constant->value) + 1;
	    memcpy (&data[blob->offset], constant->value, blob->size);
	    break;
	  }
	*offset2 += ALIGN_VALUE (blob->size, 4);
	
	g_idl_node_build_metadata ((GIdlNode *)constant->type, module, modules, 
				   strings, types, data, &pos, offset2);
      }
      break;
    default:
      g_assert_not_reached ();
    }
  
  g_debug ("node %p type %d, offset %d -> %d, offset2 %d -> %d",
	   node, node->type, old_offset, *offset, old_offset2, *offset2);

  if (*offset2 - old_offset2 + *offset - old_offset > g_idl_node_get_full_size (node))
    g_error ("exceeding space reservation !!");
}

/* if str is already in the pool, return previous location, otherwise write str
 * to the metadata at offset, put it in the pool and update offset. If the 
 * metadata is not large enough to hold the string, reallocate it.
 */
guint32 
write_string (const gchar *str,
	      GHashTable  *strings, 
	      guchar      *data,
	      guint32     *offset)
{
  gpointer value;
  guint32 start;

  string_count += 1;
  string_size += strlen (str);

  value = g_hash_table_lookup (strings, str);
  
  if (value)
    return GPOINTER_TO_INT (value);

  unique_string_count += 1;
  unique_string_size += strlen (str);

  g_hash_table_insert (strings, (gpointer)str, GINT_TO_POINTER (*offset));

  start = *offset;
  *offset = ALIGN_VALUE (start + strlen (str) + 1, 4);

  strcpy ((gchar*)&data[start], str);
  
  return start;
}

