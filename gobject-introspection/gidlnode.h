/* GObject introspection: Parsed IDL
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

#ifndef __G_IDL_NODE_H__
#define __G_IDL_NODE_H__

#include <glib.h>

G_BEGIN_DECLS

typedef struct _GIdlNode GIdlNode; 
typedef struct _GIdlNodeFunction GIdlNodeFunction;
typedef struct _GIdlNodeParam GIdlNodeParam;
typedef struct _GIdlNodeType GIdlNodeType;
typedef struct _GIdlNodeInterface GIdlNodeInterface;
typedef struct _GIdlNodeSignal GIdlNodeSignal;
typedef struct _GIdlNodeProperty GIdlNodeProperty;
typedef struct _GIdlNodeVFunc GIdlNodeVFunc;
typedef struct _GIdlNodeField GIdlNodeField;
typedef struct _GIdlNodeValue GIdlNodeValue;
typedef struct _GIdlNodeEnum GIdlNodeEnum;
typedef struct _GIdlNodeBoxed GIdlNodeBoxed;
typedef struct _GIdlNodeStruct GIdlNodeStruct;
typedef struct _GIdlNodeConstant GIdlNodeConstant;
typedef struct _GIdlNodeErrorDomain GIdlNodeErrorDomain;
typedef struct _GIdlNodeXRef GIdlNodeXRef;
typedef struct _GIdlNodeUnion GIdlNodeUnion;

typedef enum 
{
  G_IDL_NODE_INVALID,
  G_IDL_NODE_FUNCTION,
  G_IDL_NODE_CALLBACK,
  G_IDL_NODE_STRUCT,
  G_IDL_NODE_BOXED,
  G_IDL_NODE_ENUM,
  G_IDL_NODE_FLAGS,
  G_IDL_NODE_OBJECT,
  G_IDL_NODE_INTERFACE,
  G_IDL_NODE_CONSTANT,
  G_IDL_NODE_ERROR_DOMAIN,
  G_IDL_NODE_UNION,
  G_IDL_NODE_PARAM,
  G_IDL_NODE_TYPE,
  G_IDL_NODE_PROPERTY,
  G_IDL_NODE_SIGNAL,
  G_IDL_NODE_VALUE,
  G_IDL_NODE_VFUNC,
  G_IDL_NODE_FIELD,
  G_IDL_NODE_XREF
} GIdlNodeTypeId;

struct _GIdlNode
{
  GIdlNodeTypeId type;
  gchar *name;
};

struct _GIdlNodeXRef
{
  GIdlNode node;

  gchar *namespace;
};

struct _GIdlNodeFunction
{
  GIdlNode node;

  gboolean deprecated;

  gboolean is_method;
  gboolean is_setter;
  gboolean is_getter;
  gboolean is_constructor;
  gboolean wraps_vfunc;

  gchar *symbol;

  GIdlNodeParam *result;
  GList *parameters;
};

struct _GIdlNodeType 
{
  GIdlNode node;

  gboolean is_pointer;
  gboolean is_basic;
  gboolean is_array;
  gboolean is_glist;
  gboolean is_gslist;
  gboolean is_ghashtable;
  gboolean is_interface;
  gboolean is_error;
  gint tag;

  gchar *unparsed;

  gboolean zero_terminated;
  gboolean has_length;
  gint length;
  
  GIdlNodeType *parameter_type1;
  GIdlNodeType *parameter_type2;  

  gchar *interface;
  gchar **errors;
};

struct _GIdlNodeParam 
{
  GIdlNode node;

  gboolean in;
  gboolean out;
  gboolean dipper;
  gboolean optional;
  gboolean retval;
  gboolean null_ok;
  gboolean transfer;
  gboolean shallow_transfer;
  
  GIdlNodeType *type;
};

struct _GIdlNodeProperty
{
  GIdlNode node;

  gboolean deprecated;

  gchar *name;
  gboolean readable;
  gboolean writable;
  gboolean construct;
  gboolean construct_only;
  
  GIdlNodeType *type;
};

struct _GIdlNodeSignal 
{
  GIdlNode node;

  gboolean deprecated;

  gboolean run_first;
  gboolean run_last;
  gboolean run_cleanup;
  gboolean no_recurse;
  gboolean detailed;
  gboolean action;
  gboolean no_hooks;
  
  gboolean has_class_closure;
  gboolean true_stops_emit;
  
  gint class_closure;
  
  GList *parameters;
  GIdlNodeParam *result;    
};

struct _GIdlNodeVFunc 
{
  GIdlNode node;

  gboolean must_chain_up;
  gboolean must_be_implemented;
  gboolean must_not_be_implemented;
  gboolean is_class_closure;
  
  GList *parameters;
  GIdlNodeParam *result;      

  gint offset;
};

struct _GIdlNodeField
{
  GIdlNode node;

  gboolean readable;
  gboolean writable;
  gint bits;
  gint offset;
  
  GIdlNodeType *type;
};

struct _GIdlNodeInterface
{
  GIdlNode node;

  gboolean deprecated;

  gchar *gtype_name;
  gchar *gtype_init;

  gchar *parent;
  
  GList *interfaces;
  GList *prerequisites;

  GList *members;
};

struct _GIdlNodeValue
{
  GIdlNode node;

  gboolean deprecated;

  guint32 value;
};

struct _GIdlNodeConstant
{
  GIdlNode node;

  gboolean deprecated;

  GIdlNodeType *type;
  
  gchar *value;
};

struct _GIdlNodeEnum
{
  GIdlNode node;

  gboolean deprecated;

  gchar *gtype_name;
  gchar *gtype_init;

  GList *values;
};

struct _GIdlNodeBoxed
{ 
  GIdlNode node;

  gboolean deprecated;

  gchar *gtype_name;
  gchar *gtype_init;
  
  GList *members;
};

struct _GIdlNodeStruct
{
  GIdlNode node;

  gboolean deprecated;
  
  GList *members;
};

struct _GIdlNodeUnion
{
  GIdlNode node;

  gboolean deprecated;
  
  GList *members;
  GList *discriminators;

  gchar *gtype_name;
  gchar *gtype_init;

  gint discriminator_offset;
  GIdlNodeType *discriminator_type;
};


struct _GIdlNodeErrorDomain
{
  GIdlNode node;

  gboolean deprecated;
  
  gchar *name;
  gchar *getquark;
  gchar *codes;
};


GIdlNode *g_idl_node_new             (GIdlNodeTypeId type);
void      g_idl_node_free            (GIdlNode    *node);
guint32   g_idl_node_get_size        (GIdlNode    *node);
guint32   g_idl_node_get_full_size   (GIdlNode    *node);
void      g_idl_node_build_metadata  (GIdlNode    *node,
				      GIdlModule  *module,
				      GList       *modules,
                                      GHashTable  *strings,
                                      GHashTable  *types,
				      guchar      *data,
				      guint32     *offset,
                                      guint32     *offset2);
int       g_idl_node_cmp             (GIdlNode    *node,
				      GIdlNode    *other);
gboolean  g_idl_node_can_have_member (GIdlNode    *node);
void      g_idl_node_add_member      (GIdlNode         *node,
				      GIdlNodeFunction *member);
guint32   write_string               (const gchar *str,
				      GHashTable  *strings, 
				      guchar      *data,
				      guint32     *offset);

void      init_stats                 (void);
void      dump_stats                 (void);

G_END_DECLS

#endif  /* __G_IDL_NODE_H__ */
