/* valagidlparser.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;
using Gee;

/**
 * Code visitor parsing all GIDL files.
 */
public class Vala.GIdlParser : CodeVisitor {
	private CodeContext context;

	private SourceFile current_source_file;

	private SourceReference current_source_reference;
	
	private Namespace current_namespace;
	private DataType current_data_type;
	private Map<string,string> codenode_attributes_map;
	private Gee.Set<string> current_type_symbol_set;

	private Map<string,DataType> cname_type_map;

	/**
	 * Parse all source files in the specified code context and build a
	 * code tree.
	 *
	 * @param context a code context
	 */
	public void parse (CodeContext! context) {
		cname_type_map = new HashMap<string,DataType> (str_hash, str_equal);

		this.context = context;
		context.accept (this);

		cname_type_map = null;
	}

	public override void visit_namespace (Namespace! ns) {
		ns.accept_children (this);
	}

	public override void visit_class (Class! cl) {
		visit_type (cl);
	}

	public override void visit_struct (Struct! st) {
		visit_type (st);
	}

	public override void visit_interface (Interface! iface) {
		visit_type (iface);
	}

	public override void visit_enum (Enum! en) {
		visit_type (en);
	}

	public override void visit_callback (Callback! cb) {
		visit_type (cb);
	}

	private void visit_type (DataType! t) {
		if (!cname_type_map.contains (t.get_cname ())) {
			cname_type_map[t.get_cname ()] = t;
		}
	}

	public override void visit_source_file (SourceFile! source_file) {
		if (source_file.filename.has_suffix (".gidl")) {
			parse_file (source_file);
		}
	}
	
	private void parse_file (SourceFile! source_file) {
		string metadata_filename = "%s.metadata".printf (source_file.filename.ndup (source_file.filename.size () - ".gidl".size ()));

		current_source_file = source_file;

		codenode_attributes_map = new HashMap<string,string> (str_hash, str_equal);
		
		if (FileUtils.test (metadata_filename, FileTest.EXISTS)) {
			try {
				string metadata;
				ulong metadata_len;
				FileUtils.get_contents (metadata_filename, out metadata, out metadata_len);
				
				foreach (string line in metadata.split ("\n")) {
					var line_parts = line.split (" ", 2);
					if (line_parts[0] == null) {
						continue;
					}
					
					codenode_attributes_map.set (line_parts[0], line_parts[1]);
				}
			} catch (FileError e) {
				Report.error (null, "Unable to read metadata file: %s".printf (e.message));
			}
		}
	
		try {
			var modules = Idl.parse_file (source_file.filename);
			
			current_source_reference = new SourceReference (source_file);
			
			foreach (weak IdlModule module in modules) {
				var ns = parse_module (module);
				if (ns != null) {
					context.root.add_namespace (ns);
				}
			}
		} catch (MarkupError e) {
			stdout.printf ("error parsing GIDL file: %s\n", e.message);
		}
	}

	private string! fix_type_name (string! type_name, IdlModule! module) {
		if (type_name.has_prefix (module.name)) {
			return type_name.offset (module.name.len ());
		} else if (module.name == "GLib" && type_name.has_prefix ("G")) {
			return type_name.offset (1);
		}
		return type_name;
	}

	private string! fix_const_name (string! const_name, IdlModule! module) {
		if (const_name.has_prefix (module.name.up () + "_")) {
			return const_name.offset (module.name.len () + 1);
		} else if (module.name == "GLib" && const_name.has_prefix ("G_")) {
			return const_name.offset (2);
		}
		return const_name;
	}

	private Namespace parse_module (IdlModule! module) {
		Symbol sym = context.root.scope.lookup (module.name);
		Namespace ns;
		if (sym is Namespace) {
			ns = (Namespace) sym;
			ns.pkg = false;
		} else {
			ns = new Namespace (module.name, current_source_reference);
		}

		current_namespace = ns;

		var attributes = get_attributes (ns.name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "cheader_filename") {
					ns.set_cheader_filename (eval (nv[1]));
				} else if (nv[0] == "cprefix") {
					ns.set_cprefix (eval (nv[1]));
				} else if (nv[0] == "lower_case_cprefix") {
					ns.set_lower_case_cprefix (eval (nv[1]));
				}
			}
		}
		
		foreach (weak IdlNode node in module.entries) {
			if (node.type == IdlNodeTypeId.CALLBACK) {
				var cb = parse_callback ((IdlNodeFunction) node);
				if (cb == null) {
					continue;
				}
				cb.name = fix_type_name (cb.name, module);
				ns.add_callback (cb);
				current_source_file.add_node (cb);
			} else if (node.type == IdlNodeTypeId.STRUCT) {
				var st = parse_struct ((IdlNodeStruct) node);
				if (st == null) {
					continue;
				}
				st.name = fix_type_name (st.name, module);
				ns.add_struct (st);
				current_source_file.add_node (st);
			} else if (node.type == IdlNodeTypeId.BOXED) {
				var st = parse_boxed ((IdlNodeBoxed) node);
				st.name = fix_type_name (st.name, module);
				ns.add_struct (st);
				st.set_type_id (st.get_upper_case_cname ("TYPE_"));
				current_source_file.add_node (st);
			} else if (node.type == IdlNodeTypeId.ENUM) {
				var en = parse_enum ((IdlNodeEnum) node);
				en.name = fix_type_name (en.name, module);
				ns.add_enum (en);
				current_source_file.add_node (en);
			} else if (node.type == IdlNodeTypeId.OBJECT) {
				var cl = parse_object ((IdlNodeInterface) node);
				if (cl == null) {
					continue;
				}
				cl.name = fix_type_name (cl.name, module);
				ns.add_class (cl);
				current_source_file.add_node (cl);
			} else if (node.type == IdlNodeTypeId.INTERFACE) {
				var iface = parse_interface ((IdlNodeInterface) node);
				iface.name = fix_type_name (iface.name, module);
				ns.add_interface (iface);
				current_source_file.add_node (iface);
			} else if (node.type == IdlNodeTypeId.CONSTANT) {
				var c = parse_constant ((IdlNodeConstant) node);
				c.name = fix_const_name (c.name, module);
				ns.add_constant (c);
				current_source_file.add_node (c);
			} else if (node.type == IdlNodeTypeId.FUNCTION) {
				var m = parse_function ((IdlNodeFunction) node);
				if (m != null) {
					m.instance = false;
					ns.add_method (m);
					current_source_file.add_node (m);
				}
			}
		}

		current_namespace = null;

		if (sym is Namespace) {
			return null;
		}
		return ns;
	}
	
	private Callback parse_callback (IdlNodeFunction! f_node) {
		weak IdlNode node = (IdlNode) f_node;

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
		
		foreach (weak IdlNodeParam param in f_node.parameters) {
			weak IdlNode param_node = (IdlNode) param;
			
			var p = new FormalParameter (param_node.name, parse_param (param));
			cb.add_parameter (p);
		}
		
		return cb;
	}
	
	private Struct parse_struct (IdlNodeStruct! st_node) {
		weak IdlNode node = (IdlNode) st_node;
		
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
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				}
			}
		}
		
		current_data_type = st;
		
		foreach (weak IdlNode member in st_node.members) {
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
	
	private Struct parse_boxed (IdlNodeBoxed! boxed_node) {
		weak IdlNode node = (IdlNode) boxed_node;
	
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
		
		foreach (weak IdlNode member in boxed_node.members) {
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
	
	private Enum parse_enum (IdlNodeEnum! en_node) {
		weak IdlNode node = (IdlNode) en_node;
	
		var en = new Enum (node.name, current_source_reference);
		en.access = MemberAccessibility.PUBLIC;
		
		string common_prefix = null;
		
		foreach (weak IdlNode value in en_node.values) {
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
		
		foreach (weak IdlNode value2 in en_node.values) {
			var ev = new EnumValue (value2.name.offset (common_prefix.len ()));
			en.add_value (ev);
		}
		
		return en;
	}
	
	private Class parse_object (IdlNodeInterface! node) {
		var cl = new Class (node.gtype_name, current_source_reference);
		cl.access = MemberAccessibility.PUBLIC;
		
		var attributes = get_attributes (cl.name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "cheader_filename") {
					cl.add_cheader_filename (eval (nv[1]));
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				}
			}
		}
		
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
		
		current_type_symbol_set = new HashSet<string> (str_hash, str_equal);
		var current_type_vfunc_map = new HashMap<string,string> (str_hash, str_equal);
		
		foreach (weak IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.VFUNC) {
				current_type_vfunc_map.set (member.name, "1");
			}
		}

		foreach (weak IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.FUNCTION) {
				bool is_virtual = current_type_vfunc_map.get (member.name) != null;
				
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
		
		foreach (weak IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.FIELD) {
				if (!current_type_symbol_set.contains (member.name)) {
					var f = parse_field ((IdlNodeField) member);
					if (f != null) {
						cl.add_field (f);
					}
				}
			}
		}
		
		foreach (Property prop in cl.get_properties ()) {
			var getter = "get_%s".printf (prop.name);
			
			if (prop.get_accessor != null && !current_type_symbol_set.contains (getter)) {
				prop.no_accessor_method = true;
			}
			
			var setter = "set_%s".printf (prop.name);
			
			if (prop.set_accessor != null && !current_type_symbol_set.contains (setter)) {
				prop.no_accessor_method = true;
			}
		}
		
		current_data_type = null;
		current_type_symbol_set = null;
		
		return cl;
	}

	private Interface parse_interface (IdlNodeInterface! node) {
		var iface = new Interface (node.gtype_name, current_source_reference);
		iface.access = MemberAccessibility.PUBLIC;
		
		var attributes = get_attributes (iface.name);
		if (attributes != null) {
			foreach (string attr in attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "cheader_filename") {
					iface.add_cheader_filename (eval (nv[1]));
				}
			}
		}
		
		foreach (string prereq_name in node.prerequisites) {
			var prereq = new TypeReference ();
			parse_type_string (prereq, prereq_name);
			iface.add_prerequisite (prereq);
		}

		current_data_type = iface;

		var current_type_vfunc_map = new HashMap<string,string> (str_hash, str_equal);
		foreach (weak IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.VFUNC) {
				current_type_vfunc_map.set (member.name, "1");
			}
		}

		foreach (weak IdlNode member in node.members) {
			if (member.type == IdlNodeTypeId.FUNCTION) {
				bool is_virtual = current_type_vfunc_map.get (member.name) != null;
				
				var m = parse_function ((IdlNodeFunction) member, is_virtual, true);
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
	
	private TypeReference parse_type (IdlNodeType! type_node) {
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
				if (type_node.is_pointer) {
					type.array_rank = 1;
				}
			} else if (n == "gushort") {
				type.type_name = "ushort";
			} else if (n == "gshort") {
				type.type_name = "short";
			} else if (n == "gconstpointer" || n == "void") {
				type.type_name = "pointer";
			} else if (n == "goffset") {
				type.type_name = "int64";
			} else if (n == "value_array") {
				type.namespace_name = "GLib";
				type.type_name = "ValueArray";
			} else if (n == "time_t") {
				type.type_name = "ulong";
			} else if (n == "gint" || n == "pid_t") {
				type.type_name = "int";
			} else if (n == "FILE") {
				type.namespace_name = "GLib";
				type.type_name = "FileStream";
			} else {
				parse_type_string (type, n);
				if (type_node.is_pointer && is_value_type (n)) {
					type.is_out = true;
				}
			}
		} else {
			stdout.printf ("%d\n", type_node.tag);
		}
		return type;
	}
	
	private bool is_value_type (string! type_name) {
		// FIXME only works if both types are in current package, e.g. doesn't work when Gtk uses GdkRectangle
		var type_attributes = get_attributes (type_name);
		if (type_attributes != null) {
			foreach (string attr in type_attributes) {
				var nv = attr.split ("=", 2);
				if (nv[0] == "is_value_type" && eval (nv[1]) == "1") {
					return true;
				}
			}
		}

		return false;
	}
	
	private void parse_type_string (TypeReference! type, string! n) {
		var dt = cname_type_map[n];
		if (dt != null) {
			type.namespace_name = dt.parent_symbol.name;
			type.type_name = dt.name;
			return;
		}

		if (n == "HFONT" || n == "HGLOBAL" || n == "GStaticRecMutex" || n.has_suffix ("Class") || n == "va_list" || n.has_prefix ("LOGFONT") || n.has_prefix ("xml") || n == "GdkNativeWindow" || n == "GdkXEvent" || n == "GtkTextLayout" || n == "GstClockID" || n.has_prefix ("GstXml")) {
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
		} else if (n == "AtkAttributeSet") {
			type.namespace_name = "GLib";
			type.type_name = "SList";
		} else if (n == "GstClockTime") {
			type.type_name = "uint64";
		} else if (n == "GstClockTimeDiff") {
			type.type_name = "int64";
		} else if (n == "PangoGlyph") {
			type.type_name = "uint";
		} else if (n == "PangoGlyphUnit") {
			type.type_name = "int";
		} else if (n == "ClutterFixed" || n == "ClutterUnit" || n == "ClutterAngle") {
			type.type_name = "int32";
		} else if (n == "SoupProtocol") {
			type.namespace_name = "GLib";
			type.type_name = "Quark";
		} else if (n == "GStrv") {
			type.type_name = "string";
			type.array_rank = 1;
		} else if (n.has_prefix (current_namespace.name)) {
			type.namespace_name = current_namespace.name;
			type.type_name = n.offset (current_namespace.name.len ());
		} else if (n.has_prefix ("G")) {
			type.namespace_name = "GLib";
			type.type_name = n.offset (1);
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
	
	private TypeReference parse_param (IdlNodeParam! param) {
		var type = parse_type (param.type);

		// disable for now as null_ok not yet correctly set
		// type.non_null = !param.null_ok;
		
		return type;
	}
	
	private Method parse_function (IdlNodeFunction! f, bool is_virtual = false, bool is_interface = false) {
		weak IdlNode node = (IdlNode) f;
		
		if (f.deprecated) {
			return null;
		}
	
		TypeReference return_type = null;
		if (f.result != null) {
			return_type = parse_param (f.result);
		}
		
		Method m;
		if (!is_interface && (f.is_constructor || node.name.has_prefix ("new"))) {
			m = new CreationMethod (node.name, current_source_reference);
			if (m.name == "new") {
				m.name = null;
			} else if (m.name.has_prefix ("new_")) {
				m.name = m.name.offset ("new_".len ());
			}
		} else {
			m = new Method (node.name, return_type, current_source_reference);
		}
		m.access = MemberAccessibility.PUBLIC;

		m.is_virtual = is_virtual && !is_interface;
		m.is_abstract = is_virtual && is_interface;
		
		// GIDL generator can't provide array parameter information yet
		m.no_array_length = true;
		
		if (current_type_symbol_set != null) {
			current_type_symbol_set.add (node.name);
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
				if (nv[0] == "name") {
					m.set_cname (m.name);
					m.name = eval (nv[1]);
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				} else if (nv[0] == "ellipsis") {
					if (eval (nv[1]) == "1") {
						add_ellipsis = true;
					}
				} else if (nv[0] == "transfer_ownership") {
					if (eval (nv[1]) == "1") {
						return_type.transfers_ownership = true;
					}
				}
			}
		}
		
		m.set_cname (f.symbol);
		
		bool first = true;
		FormalParameter last_param = null;
		foreach (weak IdlNodeParam param in f.parameters) {
			weak IdlNode param_node = (IdlNode) param;
			
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

			if (last_param != null && p.name == "n_" + last_param.name) {
				// last_param is array, p is array length
				last_param.type_reference.array_rank = 1;
				last_param.type_reference.is_out = false;
			}

			last_param = p;
		}
		
		if (first) {
			// no parameters => static method
			m.instance = false;
		}

		if (last_param != null && last_param.name.has_prefix ("first_")) {
			last_param.ellipsis = true;
		} else if (add_ellipsis) {
			m.add_parameter (new FormalParameter.with_ellipsis ());
		}
		
		return m;
	}
	
	private string! fix_prop_name (string name) {
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

	private Property parse_property (IdlNodeProperty! prop_node) {
		weak IdlNode node = (IdlNode) prop_node;
		
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
		
		if (current_type_symbol_set != null) {
			current_type_symbol_set.add (prop.name);
		}
		
		return prop;
	}

	private Constant parse_constant (IdlNodeConstant! const_node) {
		weak IdlNode node = (IdlNode) const_node;
		
		var type = parse_type (const_node.type);
		if (type == null) {
			return null;
		}
		
		var c = new Constant (node.name, type, null, current_source_reference);
		
		return c;
	}

	private Field parse_field (IdlNodeField! field_node) {
		weak IdlNode node = (IdlNode) field_node;
		
		var type = parse_type (field_node.type);
		if (type == null) {
			return null;
		}
		
		if (!field_node.readable) {
			return null;
		}

		var attributes = get_attributes ("%s.%s".printf (current_data_type.name, node.name));
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
		
		if (current_type_symbol_set != null) {
			current_type_symbol_set.add (node.name);
		}
		
		var field = new Field (node.name, type, null, current_source_reference);
		field.access = MemberAccessibility.PUBLIC;
		
		return field;
	}

	[NoArrayLength]
	private string[] get_attributes (string! codenode) {
		string attributes = codenode_attributes_map.get (codenode);
		if (attributes == null) {
			return null;
		}
		
		return attributes.split (" ");
	}
	
	private string eval (string! s) {
		return s.offset (1).ndup (s.size () - 2);
	}

	private Signal parse_signal (IdlNodeSignal! sig_node) {
		weak IdlNode node = (IdlNode) sig_node;
		
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
				} else if (nv[0] == "hidden") {
					if (eval (nv[1]) == "1") {
						return null;
					}
				}
			}
		}
		
		bool first = true;
		
		foreach (weak IdlNodeParam param in sig_node.parameters) {
			if (first) {
				// ignore implicit first signal parameter (sender)
				first = false;
				continue;
			}
		
			weak IdlNode param_node = (IdlNode) param;
			
			var p = new FormalParameter (param_node.name, parse_param (param));
			sig.add_parameter (p);
		}
		
		return sig;
	}
}
