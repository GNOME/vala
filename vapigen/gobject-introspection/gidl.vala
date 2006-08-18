/* gidl.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

[CCode (cprefix = "G", lower_case_cprefix = "g_", cheader_filename = "glib.h")]
namespace GLib {
	[CCode (cheader_filename = "gidlparser.h")]
	public struct Idl {
		public static ref List<IdlModule> parse_file (string! filename, out Error error);
	}
	
	[CCode (cheader_filename = "gidlmodule.h")]
	[ReferenceType (free_function = "g_idl_module_free")]
	public struct IdlModule {
		public string name;
		public List<IdlNode> entries;
	}

	[CCode (cprefix = "G_IDL_NODE_", cheader_filename = "gidlnode.h")]
	public enum IdlNodeTypeId {
		INVALID,
		FUNCTION,
		CALLBACK,
		STRUCT,
		BOXED,
		ENUM,
		FLAGS,
		OBJECT,
		INTERFACE,
		CONSTANT,
		ERROR_DOMAIN,
		UNION,
		PARAM,
		TYPE,
		PROPERTY,
		SIGNAL,
		VALUE,
		VFUNC,
		FIELD,
		XREF
	}
	
	[CCode (cheader_filename = "gidlnode.h")]
	[ReferenceType (free_function = "g_idl_node_free")]
	public struct IdlNode {
		public IdlNodeTypeId type;
		public string name;
	}
	
	[CCode (cheader_filename = "gidlnode.h")]
	[ReferenceType (free_function = "g_idl_node_free")]
	public struct IdlNodeFunction {
		public bool deprecated;
		
		public bool is_method;
		public bool is_setter;
		public bool is_getter;
		public bool is_constructor;
		public bool wraps_vfunc;
		
		public string symbol;
		
		public IdlNodeParam result;
		public List<IdlNodeParam> parameters;
	}
	
	[CCode (cheader_filename = "gidlnode.h")]
	[ReferenceType (free_function = "g_idl_node_free")]
	public struct IdlNodeSignal {
		public bool deprecated;
		
		public bool run_first;
		public bool run_last;
		public bool run_cleanup;
		public bool no_recurse;
		public bool detailed;
		public bool action;
		public bool no_hooks;
		
		public bool has_class_closure;
		public bool true_stops_emit;
		
		public int class_closure;
		
		public List<IdlNodeParam> parameters;
		public IdlNodeParam result;
	}
	
	[CCode (cheader_filename = "gidlnode.h")]
	[ReferenceType (free_function = "g_idl_node_free")]
	public struct IdlNodeBoxed {
		public bool deprecated;
		
		public string gtype_name;
		public string gtype_init;
		
		public List<IdlNode> members;
	}
	
	[CCode (cheader_filename = "gidlnode.h")]
	[ReferenceType (free_function = "g_idl_node_free")]
	public struct IdlNodeEnum {
		public bool deprecated;
		
		public string gtype_name;
		public string gtype_init;
		
		public List<IdlNode> values;
	}
	
	[CCode (cheader_filename = "gidlnode.h")]
	[ReferenceType (free_function = "g_idl_node_free")]
	public struct IdlNodeField {
		public bool readable;
		public bool writable;
		public int bits;
		public int offset;
		
		public IdlNodeType type;
	}
	
	[CCode (cheader_filename = "gidlnode.h")]
	[ReferenceType (free_function = "g_idl_node_free")]
	public struct IdlNodeConstant {
		public bool deprecated;
		
		public IdlNodeType type;
		
		public string value;
	}
	
	[CCode (cheader_filename = "gidlnode.h")]
	[ReferenceType (free_function = "g_idl_node_free")]
	public struct IdlNodeInterface {
		public bool deprecated;
		
		public string gtype_name;
		public string gtype_init;
		
		public string parent;
		
		public List<string> interfaces;
		public List<string> prerequisites;
		
		public List<IdlNode> members;
	}
	
	[CCode (cheader_filename = "gidlnode.h")]
	[ReferenceType (free_function = "g_idl_node_free")]
	public struct IdlNodeParam {
		public bool @in;
		public bool @out;
		public bool dipper;
		public bool optional;
		public bool retval;
		public bool null_ok;
		public bool transfer;
		public bool shallow_transfer;
		
		public IdlNodeType type;
	}
	
	[CCode (cheader_filename = "gidlnode.h")]
	[ReferenceType (free_function = "g_idl_node_free")]
	public struct IdlNodeProperty {
		public bool deprecated;
		
		public string name;
		
		public bool readable;
		public bool writable;
		public bool @construct;
		public bool construct_only;
		
		public IdlNodeType type;
	}
	
	[CCode (cheader_filename = "gidlnode.h")]
	[ReferenceType (free_function = "g_idl_node_free")]
	public struct IdlNodeStruct {
		public bool deprecated;
		
		public List<IdlNode> members;
	}
	
	[CCode (cheader_filename = "gidlnode.h")]
	[ReferenceType (free_function = "g_idl_node_free")]
	public struct IdlNodeType {
		public bool is_pointer;
		public bool is_basic;
		public bool is_array;
		public bool is_glist;
		public bool is_gslist;
		public bool is_ghashtable;
		public bool is_interface;
		public bool is_error;
		public TypeTag tag;
		
		public string unparsed;
		
		public bool zero_terminated;
		public bool has_length;
		public int length;
		
		public IdlNodeType parameter_type1;
		public IdlNodeType parameter_type2;
		
		public string @interface;
		public string[] errors;
	}

	[CCode (cprefix = "TYPE_TAG_", cheader_filename = "gmetadata.h")]
	public enum TypeTag
	{
		VOID,
		BOOLEAN,
		INT8,
		UINT8,
		INT16,
		UINT16,  
		INT32,
		UINT32,
		INT64,
		UINT64,
		INT,
		UINT,
		LONG,
		ULONG,
		SSIZE,
		SIZE,
		FLOAT,
		DOUBLE,
		UTF8,
		FILENAME,
		ARRAY,
		INTERFACE,
		LIST,
		SLIST,
		HASH,
		ERROR
	}
}
