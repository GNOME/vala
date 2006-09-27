/* valagidlparser.vala
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

using GLib;

/**
 * Code visitor parsing all GIDL files.
 */
public class Vala.GIdlParser : CodeVisitor {
	private SourceReference current_source_reference;
	
	private DataType current_data_type;
	private HashTable<string,string> codenode_attributes_map;
	private HashTable<string,string> current_type_symbol_map;

	/**
	 * Parse all source files in the specified code context and build a
	 * code tree.
	 *
	 * @param context a code context
	 */
	public void parse (CodeContext! context) {
		context.accept (this);
	}

	public override void visit_begin_source_file (SourceFile! source_file) {
		if (source_file.filename.has_suffix (".gidl")) {
			parse_file (source_file);
		}
	}
	
	private void parse_file (SourceFile! source_file) {
		Error error = null;
		
		string metadata_filename = "%s.metadata".printf (source_file.filename.ndup (source_file.filename.size () - ".gidl".size ()));
		
		codenode_attributes_map = new HashTable.full (str_hash, str_equal, g_free, g_free);
		
		if (File.test (metadata_filename, FileTest.EXISTS)) {
			string metadata;
			File.get_contents (metadata_filename, out metadata, null, out error);
			
			foreach (string line in metadata.split ("\n")) {
				var line_parts = line.split (" ", 2);
				if (line_parts[0] == null) {
					continue;
				}
				
				codenode_attributes_map.insert (line_parts[0], line_parts[1]);
			}
		}
	
		var modules = Idl.parse_file (source_file.filename, out error);
		
		if (error != null) {
			stdout.printf ("error parsing GIDL file: %s\n", error.message);
		}
		
		current_source_reference = new SourceReference (source_file);
		
		foreach (IdlModule module in modules) {
			var ns = parse_module (module);
			source_file.add_namespace (ns);
		}
	}
	
	private ref Namespace parse_module (IdlModule! module) {
		var ns = new Namespace (module.name, current_source_reference);
		
		var attributes = get_attributes (ns.name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "cheader_filename") {
					ns.set_cheader_filename (eval (nv[1]));
				}
			}
		}
		
		foreach (IdlNode node in module.entries) {
			if (node.type == IdlNodeTypeId.CALLBACK) {
				var cb = parse_callback ((IdlNodeFunction) node);
				if (cb == null) {
					continue;
				}
				if (cb.name.has_prefix (module.name)) {
					cb.name = cb.name.offset (module.name.len ());
				}
				ns.add_callback (cb);
			} else if (node.type == IdlNodeTypeId.STRUCT) {
				var st = parse_struct ((IdlNodeStruct) node);
				if (st == null) {
					continue;
				}
				if (st.name.has_prefix (module.name)) {
					st.name = st.name.offset (module.name.len ());
				}
				ns.add_struct (st);
			} else if (node.type == IdlNodeTypeId.BOXED) {
				var st = parse_boxed ((IdlNodeBoxed) node);
				if (st.name.has_prefix (module.name)) {
					st.name = st.name.offset (module.name.len ());
				}
				ns.add_struct (st);
			} else if (node.type == IdlNodeTypeId.ENUM) {
				var en = parse_enum ((IdlNodeEnum) node);
				if (en.name.has_prefix (module.name)) {
					en.name = en.name.offset (module.name.len ());
				}
				ns.add_enum (en);
			} else if (node.type == IdlNodeTypeId.OBJECT) {
				var cl = parse_object ((IdlNodeInterface) node);
				if (cl.name.has_prefix (module.name)) {
					cl.name = cl.name.offset (module.name.len ());
				}
				ns.add_class (cl);
			} else if (node.type == IdlNodeTypeId.INTERFACE) {
				var iface = parse_interface ((IdlNodeInterface) node);
				if (iface.name.has_prefix (module.name)) {
					iface.name = iface.name.offset (module.name.len ());
				}
				ns.add_interface (iface);
			} else if (node.type == IdlNodeTypeId.CONSTANT) {
				var c = parse_constant ((IdlNodeConstant) node);
				if (c.name.has_prefix (module.name.up ())) {
					c.name = c.name.offset (module.name.len () + 1);
				}
				ns.add_constant (c);
			} else if (node.type == IdlNodeTypeId.FUNCTION) {
				var m = parse_function ((IdlNodeFunction) node);
				if (m != null) {
					m.instance = false;
					ns.add_method (m);
				}
			}
		}
		
		return ns;
	}
	
	private ref Callback parse_callback (IdlNodeFunction! f_node) {
		var node = (IdlNode) f_node;

		var attributes = get_attributes (node.name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				}
			}
		}
	
		var cb = new Callback (node.name, parse_param (f_node.result), current_source_reference);
		cb.access = MemberAccessibility.PUBLIC;
		
		foreach (IdlNodeParam param in f_node.parameters) {
			var param_node = (IdlNode) param;
			
			var p = new FormalParameter (param_node.name, parse_param (param));
			cb.add_parameter (p);
		}
		
		return cb;
	}
	
	private ref Struct parse_struct (IdlNodeStruct! st_node) {
		var node = (IdlNode) st_node;
		
		if (st_node.deprecated) {
			return null;
		}
	
		var st = new Struct (node.name, current_source_reference);
		st.access = MemberAccessibility.PUBLIC;

		st.set_is_reference_type (true);
		
		var st_attributes = get_attributes (node.name);
		if (st_attributes != null) {
			foreach (string attr in st_attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "is_value_type" && eval (nv[1]) == "1") {
					st.set_is_reference_type (false);
				}
			}
		}
		
		current_data_type = st;
		
		foreach (IdlNode member in st_node.members) {
			if (member.type == IdlNodeTypeId.FUNCTION) {
				var m = parse_function ((IdlNodeFunction) member);
				if (m != null) {
					st.add_method (m);
				}
			} else if (member.type == IdlNodeTypeId.FIELD) {
				var f = parse_field ((IdlNodeField) member);
				if (f != null) {
					st.add_field (f);
				}
			}
		}

		current_data_type = null;
		
		return st;
	}
	
	private ref Struct parse_boxed (IdlNodeBoxed! boxed_node) {
		var node = (IdlNode) boxed_node;
	
		var st = new Struct (node.name, current_source_reference);
		st.access = MemberAccessibility.PUBLIC;
		
		current_data_type = st;
		
		foreach (IdlNode member in boxed_node.members) {
			if (member.type == IdlNodeTypeId.FUNCTION) {
				var m = parse_function ((IdlNodeFunction) member);
				if (m != null) {
					st.add_method (m);
				}
			}
		}

		current_data_type = null;
		
		return st;
	}
	
	private ref Enum parse_enum (IdlNodeEnum! en_node) {
		var node = (IdlNode) en_node;
	
		var en = new Enum (node.name, current_source_reference);
		en.access = MemberAccessibility.PUBLIC;
		
		string common_prefix = null;
		
		foreach (IdlNode value in en_node.values) {
			if (common_prefix == null) {
				common_prefix = value.name;
				while (common_prefix.len () > 0 && !common_prefix.has_suffix ("_")) {
					// FIXME: could easily be made faster
					common_prefix = common_prefix.ndup (common_prefix.size () - 1);
				}
			} else {
				while (!value.name.has_prefix (common_prefix)) {
					common_prefix = common_prefix.ndup (common_prefix.size () - 1);
				}
			}
		}
		
		en.set_cprefix (common_prefix);
		
		foreach (IdlNode value2 in en_node.values) {
			var ev = new EnumValue (value2.name.offset (common_prefix.len ()));
			en.add_value (ev);
		}
		
		return en;
	}
	
	private ref Class parse_object (IdlNodeInterface! node) {
		var cl = new Class (node.gtype_name, current_source_reference);
		cl.access = MemberAccessibility.PUBLIC;
		
		if (node.parent != null) {
			var parent = new TypeReference ();
			parse_type_string (parent, node.parent);
			cl.add_base_type (parent);
		}
		
		foreach (string iface_name in node.interfaces) {
			var iface = new TypeReference ();
			parse_type_string (iface, iface_name);
			cl.add_base_type (iface);
		}
		
		current_data_type = cl;
		
		current_type_symbol_map = new HashTable<string,string>.full (str_hash, str_equal, g_free, g_free);
		var current_type_vfunc_map = new HashTable<string,string>.full (str_hash, str_equal, g_free, g_free);
		
		foreach (IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.VFUNC) {
				current_type_vfunc_map.insert (member.name, "1");
			}
		}

		foreach (IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.FUNCTION) {
				bool is_virtual = current_type_vfunc_map.lookup (member.name) != null;
				
				var m = parse_function ((IdlNodeFunction) member, is_virtual);
				if (m != null) {
					cl.add_method (m);
				}
			} else if (member.type == IdlNodeTypeId.PROPERTY) {
				var prop = parse_property ((IdlNodeProperty) member);
				if (prop != null) {
					cl.add_property (prop);
				}
			} else if (member.type == IdlNodeTypeId.SIGNAL) {
				var sig = parse_signal ((IdlNodeSignal) member);
				if (sig != null) {
					cl.add_signal (sig);
				}
			}
		}
		
		foreach (IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.FIELD) {
				if (current_type_symbol_map.lookup (member.name) == null) {
					var f = parse_field ((IdlNodeField) member);
					if (f != null) {
						cl.add_field (f);
					}
				}
			}
		}
		
		foreach (Property prop in cl.get_properties ()) {
			var getter = "get_%s".printf (prop.name);
			
			if (prop.get_accessor != null && current_type_symbol_map.lookup (getter) == null) {
				prop.no_accessor_method = true;
			}
			
			var setter = "set_%s".printf (prop.name);
			
			if (prop.set_accessor != null && current_type_symbol_map.lookup (setter) == null) {
				prop.no_accessor_method = true;
			}
		}
		
		current_data_type = null;
		current_type_symbol_map = null;
		
		return cl;
	}
	
	private ref Interface parse_interface (IdlNodeInterface! node) {
		var iface = new Interface (node.gtype_name, current_source_reference);
		iface.access = MemberAccessibility.PUBLIC;
		
		foreach (string prereq_name in node.prerequisites) {
			var prereq = new TypeReference ();
			parse_type_string (prereq, prereq_name);
			iface.add_base_type (prereq);
		}

		current_data_type = iface;

		var current_type_vfunc_map = new HashTable<string,string>.full (str_hash, str_equal, g_free, g_free);
		foreach (IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.VFUNC) {
				current_type_vfunc_map.insert (member.name, "1");
			}
		}

		foreach (IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.FUNCTION) {
				bool is_virtual = current_type_vfunc_map.lookup (member.name) != null;
				
				var m = parse_function ((IdlNodeFunction) member, is_virtual);
				if (m != null) {
					iface.add_method (m);
				}
			} else if (member.type == IdlNodeTypeId.SIGNAL) {
				var sig = parse_signal ((IdlNodeSignal) member);
				if (sig != null) {
					iface.add_signal (sig);
				}
			}
		}

		current_data_type = null;
		
		return iface;
	}
	
	private ref TypeReference parse_type (IdlNodeType! type_node) {
		var type = new TypeReference ();
		if (type_node.tag == TypeTag.VOID) {
			if (type_node.is_pointer) {
				type.type_name = "pointer";
			} else {
				type.type_name = "void";
			}
		} else if (type_node.tag == TypeTag.BOOLEAN) {
			type.type_name = "bool";
		} else if (type_node.tag == TypeTag.INT8) {
			type.type_name = "char";
		} else if (type_node.tag == TypeTag.UINT8) {
			type.type_name = "uchar";
		} else if (type_node.tag == TypeTag.INT16) {
			type.type_name = "short";
		} else if (type_node.tag == TypeTag.UINT16) {
			type.type_name = "ushort";
		} else if (type_node.tag == TypeTag.INT32) {
			type.type_name = "int";
		} else if (type_node.tag == TypeTag.UINT32) {
			type.type_name = "uint";
		} else if (type_node.tag == TypeTag.INT64) {
			type.type_name = "int64";
		} else if (type_node.tag == TypeTag.UINT64) {
			type.type_name = "uint64";
		} else if (type_node.tag == TypeTag.INT) {
			type.type_name = "int";
		} else if (type_node.tag == TypeTag.UINT) {
			type.type_name = "uint";
		} else if (type_node.tag == TypeTag.LONG) {
			type.type_name = "long";
		} else if (type_node.tag == TypeTag.ULONG) {
			type.type_name = "ulong";
		} else if (type_node.tag == TypeTag.SSIZE) {
			type.type_name = "long";
		} else if (type_node.tag == TypeTag.SIZE) {
			type.type_name = "ulong";
		} else if (type_node.tag == TypeTag.FLOAT) {
			type.type_name = "float";
		} else if (type_node.tag == TypeTag.DOUBLE) {
			type.type_name = "double";
		} else if (type_node.tag == TypeTag.UTF8) {
			type.type_name = "string";
		} else if (type_node.tag == TypeTag.FILENAME) {
			type.type_name = "string";
		} else if (type_node.tag == TypeTag.ARRAY) {
			type = parse_type (type_node.parameter_type1);
			type.array_rank = 1;
		} else if (type_node.tag == TypeTag.LIST) {
			type.namespace_name = "GLib";
			type.type_name = "List";
		} else if (type_node.tag == TypeTag.SLIST) {
			type.namespace_name = "GLib";
			type.type_name = "SList";
		} else if (type_node.tag == TypeTag.HASH) {
			type.namespace_name = "GLib";
			type.type_name = "HashTable";
		} else if (type_node.tag == TypeTag.ERROR) {
			type.namespace_name = "GLib";
			type.type_name = "Error";
		} else if (type_node.is_interface) {
			var n = type_node.@interface;
			
			if (n == "") {
				return null;
			}
			
			if (n.has_prefix ("const-")) {
				n = n.offset ("const-".len ());
			}

			if (type_node.is_pointer &&
			    (n == "gchar" || n == "char")) {
				type.type_name = "string";
			} else if (n == "gunichar") {
				type.type_name = "unichar";
			} else if (n == "gchar") {
				type.type_name = "char";
			} else if (n == "guchar" || n == "guint8") {
				type.type_name = "uchar";
			} else if (n == "gushort") {
				type.type_name = "ushort";
			} else if (n == "gshort") {
				type.type_name = "short";
			} else if (n == "gconstpointer") {
				type.type_name = "pointer";
			} else if (n == "value_array") {
				type.namespace_name = "GLib";
				type.type_name = "ValueArray";
			} else if (n == "time_t") {
				type.type_name = "ulong";
			} else if (n == "FILE") {
				type.namespace_name = "GLib";
				type.type_name = "File";
			} else {
				parse_type_string (type, n);
			}
		} else {
			stdout.printf ("%d\n", type_node.tag);
		}
		return type;
	}
	
	private void parse_type_string (TypeReference! type, string! n) {
		// Generated GIDL misses explicit namespace specifier,
		// so try to guess namespace
		if (n.has_prefix ("H") || n.has_suffix ("Class") || n == "va_list" || n == "LOGFONT") {
			// unsupported
			type.type_name = "pointer";
		} else if (n.has_prefix ("cairo")) {
			type.namespace_name = "Cairo";
			if (n == "cairo_t") {
				type.type_name = "Context";
			} else if (n == "cairo_surface_t") {
				type.type_name = "Surface";
			} else {
				type.namespace_name = null;
				type.type_name = "pointer";
			}
		} else if (n.has_prefix ("Atk")) {
			type.namespace_name = "Atk";
			type.type_name = n.offset ("Atk".len ());
			if (type.type_name == "AttributeSet") {
				type.namespace_name = "GLib";
				type.type_name = "SList";
			}
		} else if (n.has_prefix ("Gtk")) {
			type.namespace_name = "Gtk";
			type.type_name = n.offset ("Gtk".len ());
			if (type.type_name == "Allocation" || type.type_name == "TextLayout") {
				type.namespace_name = null;
				type.type_name = "pointer";
			}
		} else if (n.has_prefix ("Gdk")) {
			type.namespace_name = "Gdk";
			type.type_name = n.offset ("Gdk".len ());
			if (type.type_name == "NativeWindow" || type.type_name == "XEvent") {
				type.namespace_name = null;
				type.type_name = "pointer";
			}
		} else if (n.has_prefix ("Pango")) {
			type.namespace_name = "Pango";
			type.type_name = n.offset ("Pango".len ());
			if (type.type_name == "Glyph") {
				type.namespace_name = null;
				type.type_name = "uint";
			} else if (type.type_name == "GlyphUnit") {
				type.namespace_name = null;
				type.type_name = "int";
			}
		} else if (n.has_prefix ("G")) {
			type.namespace_name = "GLib";
			type.type_name = n.offset ("G".len ());
			if (type.type_name == "Strv") {
				type.namespace_name = null;
				type.type_name = "string";
				type.array_rank = 1;
			}
		} else {
			var name_parts = n.split (".", 2);
			if (name_parts[1] == null) {
				type.type_name = name_parts[0];
			} else {
				type.namespace_name = name_parts[0];
				type.type_name = name_parts[1];
			}
		}
	}
	
	private ref TypeReference parse_param (IdlNodeParam! param) {
		var type = parse_type (param.type);

		// disable for now as null_ok not yet correctly set
		// type.non_null = !param.null_ok;
		
		return type;
	}
	
	private ref Method parse_function (IdlNodeFunction! f, bool is_virtual = false) {
		var node = (IdlNode) f;
		
		if (f.deprecated) {
			return null;
		}
	
		TypeReference return_type = null;
		if (f.result != null) {
			return_type = parse_param (f.result);
		}
		
		var m = new Method (node.name, return_type, current_source_reference);
		m.access = MemberAccessibility.PUBLIC;
		
		m.is_virtual = is_virtual;
		
		// GIDL generator can't provide array parameter information yet
		m.no_array_length = true;
		
		if (current_type_symbol_map != null) {
			current_type_symbol_map.insert (node.name, "1");
		}
		
		if (current_data_type != null) {
			var sig_attributes = get_attributes ("%s::%s".printf (current_data_type.name, node.name));
			if (sig_attributes != null) {
				foreach (string attr in sig_attributes) {
					var nv = attr.split ("=", 2);
					if (nv[0] == "has_emitter" && eval (nv[1]) == "1") {
						return null;
					}
				}
			}
		}
		
		bool add_ellipsis = false;

		var attributes = get_attributes (f.symbol);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				} else if (nv[0] == "ellipsis") {
					if (eval (nv[1]) == "1") {
						add_ellipsis = true;
					}
				}
			}
		}
		
		if (f.is_constructor || m.name.has_prefix ("new")) {
			m.construction = true;
			if (m.name == "new") {
				m.name = null;
			} else if (m.name.has_prefix ("new_")) {
				m.name = m.name.offset ("new_".len ());
			}
		}
		
		bool first = true;
		foreach (IdlNodeParam param in f.parameters) {
			var param_node = (IdlNode) param;
			
			if (first) {
				first = false;
				if (current_data_type != null &&
				    param.type.is_interface &&
				    (param_node.name == "self" ||
				     param.type.@interface.has_suffix (current_data_type.name))) {
					// instance method
					
					if (!current_data_type.is_reference_type () &&
					    param.type.is_pointer) {
						m.instance_by_reference = true;
					}
					
					continue;
				} else {
					// static method
					m.instance = false;
				}
			}
			
			var p = new FormalParameter (param_node.name, parse_param (param));
			m.add_parameter (p);
		}
		
		if (add_ellipsis) {
			m.add_parameter (new FormalParameter.with_ellipsis ());
		}
		
		return m;
	}
	
	private ref string! fix_prop_name (string name) {
		var str = new String ();
		
		string i = name;
		
		while (i.len () > 0) {
			unichar c = i.get_char ();
			if (c == '-') {
				str.append_c ('_');
			} else {
				str.append_unichar (c);
			}
			
			i = i.next_char ();
		}
		
		return str.str;
	}

	private ref Property parse_property (IdlNodeProperty! prop_node) {
		var node = (IdlNode) prop_node;
		
		if (prop_node.deprecated) {
			return null;
		}
		
		if (!prop_node.readable && !prop_node.writable) {
			// buggy GIDL definition
			prop_node.readable = true;
			prop_node.writable = true;
		}
		
		PropertyAccessor get_acc = null;
		PropertyAccessor set_acc = null;
		if (prop_node.readable) {
			get_acc = new PropertyAccessor (true, false, false, null, null);
		}
		if (prop_node.writable) {
			set_acc = new PropertyAccessor (false, false, false, null, null);
			if (prop_node.construct_only) {
				set_acc.construction = true;
			} else {
				set_acc.writable = true;
				set_acc.construction = prop_node.@construct;
			}
		}
		
		var prop = new Property (fix_prop_name (node.name), parse_type (prop_node.type), get_acc, set_acc, current_source_reference);
		prop.access = MemberAccessibility.PUBLIC;
		prop.interface_only = true;
		
		if (current_type_symbol_map != null) {
			current_type_symbol_map.insert (prop.name, "1");
		}
		
		return prop;
	}

	private ref Constant parse_constant (IdlNodeConstant! const_node) {
		var node = (IdlNode) const_node;
		
		var type = parse_type (const_node.type);
		if (type == null) {
			return null;
		}
		
		var c = new Constant (node.name, type, null, current_source_reference);
		
		return c;
	}

	private ref Field parse_field (IdlNodeField! field_node) {
		var node = (IdlNode) field_node;
		
		var type = parse_type (field_node.type);
		if (type == null) {
			return null;
		}
		
		if (!field_node.readable) {
			return null;
		}
		
		if (current_type_symbol_map != null) {
			current_type_symbol_map.insert (node.name, "1");
		}
		
		var field = new Field (node.name, type, null, current_source_reference);
		field.access = MemberAccessibility.PUBLIC;
		
		return field;
	}
	
	private ref string[] get_attributes (string! codenode) {
		string attributes = codenode_attributes_map.lookup (codenode);
		if (attributes == null) {
			return null;
		}
		
		return attributes.split (" ");
	}
	
	private ref string eval (string! s) {
		return s.offset (1).ndup (s.size () - 2);
	}

	private ref Signal parse_signal (IdlNodeSignal! sig_node) {
		var node = (IdlNode) sig_node;
		
		if (sig_node.deprecated || sig_node.result == null) {
			return null;
		}
		
		var sig = new Signal (fix_prop_name (node.name), parse_param (sig_node.result), current_source_reference);
		sig.access = MemberAccessibility.PUBLIC;
		
		var attributes = get_attributes ("%s::%s".printf (current_data_type.name, sig.name));
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "name") {
					sig.set_cname (sig.name);
					sig.name = eval (nv[1]);
				} else if (nv[0] == "has_emitter" && eval (nv[1]) == "1") {
					sig.has_emitter = true;
				}
			}
		}
		
		bool first = true;
		
		foreach (IdlNodeParam param in sig_node.parameters) {
			if (first) {
				// ignore implicit first signal parameter (sender)
				first = false;
				continue;
			}
		
			var param_node = (IdlNode) param;
			
			var p = new FormalParameter (param_node.name, parse_param (param));
			sig.add_parameter (p);
		}
		
		return sig;
	}
}
