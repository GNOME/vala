/* valagirwriter.vala
 *
 * Copyright (C) 2008-2010  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

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
 * Code visitor generating .gir file for the public interface.
 */
public class Vala.GIRWriter : CodeVisitor {
	private CodeContext context;
	private string directory;
	private string gir_namespace;
	private string gir_version;

	StringBuilder buffer = new StringBuilder();
	FileStream stream;
	Vala.HashSet<Namespace> unannotated_namespaces = new Vala.HashSet<Namespace>();
	Vala.HashSet<Namespace> our_namespaces = new Vala.HashSet<Namespace>();

	int indent;

	private TypeSymbol gobject_type;

	private struct GIRNamespace {
		public GIRNamespace (string ns, string version) {
			this.ns = ns; this.version = version;
		}
		public string ns;
		public string version;
		public bool equal (GIRNamespace g) {
			return ((ns == g.ns) && (version == g.version));
		}
	}

	private ArrayList<GIRNamespace?> externals = new ArrayList<GIRNamespace?> ((EqualFunc) GIRNamespace.equal);

	public void write_includes() {
		foreach (var i in externals) {
			write_indent_stream ();
			stream.printf ("<include name=\"%s\" version=\"%s\"/>\n", i.ns, i.version);
		}
	}


	/**
	 * Writes the public interface of the specified code context into the
	 * specified file.
	 *
	 * @param context  a code context
	 * @param filename a relative or absolute filename
	 */
	public void write_file (CodeContext context, string directory, string gir_namespace, string gir_version, string package) {
		this.context = context;
		this.directory = directory;
		this.gir_namespace = gir_namespace;
		this.gir_version = gir_version;

		var root_symbol = context.root;
		var glib_ns = root_symbol.scope.lookup ("GLib");
		gobject_type = (TypeSymbol) glib_ns.scope.lookup ("Object");

		write_package (package);

		context.accept (this);

		indent--;
		buffer.append_printf ("</repository>\n");

		string filename = "%s%c%s-%s.gir".printf (directory, Path.DIR_SEPARATOR, gir_namespace, gir_version);
		stream = FileStream.open (filename, "w");
		if (stream == null) {
			Report.error (null, "unable to open `%s' for writing".printf (filename));
			return;
		}

		stream.printf ("<?xml version=\"1.0\"?>\n");

		stream.printf ("<repository version=\"1.0\"");
		stream.printf (" xmlns=\"http://www.gtk.org/introspection/core/1.0\"");
		stream.printf (" xmlns:c=\"http://www.gtk.org/introspection/c/1.0\"");
		stream.printf (" xmlns:glib=\"http://www.gtk.org/introspection/glib/1.0\"");
		stream.printf (">\n");
		indent++;

		write_includes();
		indent--;

		stream.puts (buffer.str);
		stream = null;

		foreach (var ns in unannotated_namespaces) {
			if (!our_namespaces.contains(ns)) {
				Report.warning (ns.source_reference, "Namespace %s does not have a GIR namespace and version annotation".printf (ns.name));
			}
		}
		foreach (var ns in our_namespaces) {
			ns.source_reference.file.gir_namespace = gir_namespace;
			ns.source_reference.file.gir_version = gir_version;
		}
	}

	private void write_package (string package) {
		write_indent ();
		buffer.append_printf ("<package name=\"%s\"/>\n", package);
	}

	private void write_c_includes (Namespace ns) {
		// Collect C header filenames
		Set<string> header_filenames = new HashSet<string> (str_hash, str_equal);
		foreach (string c_header_filename in ns.get_cheader_filenames ()) {
			header_filenames.add (c_header_filename);
		}
		foreach (Symbol symbol in ns.scope.get_symbol_table ().get_values ()) {
			foreach (string c_header_filename in symbol.get_cheader_filenames ()) {
				header_filenames.add (c_header_filename);
			}
		}

		// Generate c:include tags
		foreach (string c_header_filename in header_filenames) {
			write_c_include (c_header_filename);
		}
	}

	private void write_c_include (string name) {
		write_indent ();
		buffer.append_printf ("<c:include name=\"%s\"/>\n", name);
	}

	public override void visit_namespace (Namespace ns) {
		if (ns.external_package) {
			return;
		}

		if (ns.name == null)  {
			// global namespace
			ns.accept_children (this);
			return;
		}

		if (ns.parent_symbol.name != null) {
			// nested namespace
			// not supported in GIR at the moment
			return;
		}

		write_c_includes (ns);

		write_indent ();
		buffer.append_printf ("<namespace name=\"%s\" version=\"%s\"", gir_namespace, gir_version);
		string? cprefix = ns.get_cprefix ();
		if (cprefix != null) {
			buffer.append_printf (" c:prefix=\"%s\"", cprefix);
		}
		buffer.append_printf (">\n");
		indent++;

		write_annotations (ns);

		ns.accept_children (this);

		indent--;
		write_indent ();
		buffer.append_printf ("</namespace>\n");
		our_namespaces.add(ns);
	}

	public override void visit_class (Class cl) {
		if (cl.external_package) {
			return;
		}

		if (!check_accessibility (cl)) {
			return;
		}

		if (cl.is_subtype_of (gobject_type)) {
			string gtype_struct_name = cl.name + "Class";

			write_indent ();
			buffer.append_printf ("<class name=\"%s\"", cl.name);
			write_gtype_attributes (cl);
			buffer.append_printf (" glib:type-struct=\"%s\"", gtype_struct_name);
			buffer.append_printf (" parent=\"%s\"", gi_type_name (cl.base_class));
			if (cl.is_abstract) {
				buffer.append_printf (" abstract=\"1\"");
			}
			buffer.append_printf (">\n");
			indent++;

			// write implemented interfaces
			foreach (DataType base_type in cl.get_base_types ()) {
				var object_type = (ObjectType) base_type;
				if (object_type.type_symbol is Interface) {
					write_indent ();
					buffer.append_printf ("<implements name=\"%s\"/>\n", gi_type_name (object_type.type_symbol));
				}
			}

			write_annotations (cl);

			write_indent ();
			buffer.append_printf ("<field name=\"parent_instance\">\n");
			indent++;
			write_indent ();
			buffer.append_printf ("<type name=\"%s\" c:type=\"%s\"/>\n", gi_type_name (cl.base_class), cl.base_class.get_cname ());
			indent--;
			write_indent ();
			buffer.append_printf("</field>\n");

			write_indent ();
			buffer.append_printf ("<field name=\"priv\">\n");
			indent++;
			write_indent ();
			buffer.append_printf ("<type name=\"any\" c:type=\"%sPrivate*\"/>\n", cl.get_cname ());
			indent--;
			write_indent ();
			buffer.append_printf("</field>\n");

			cl.accept_children (this);

			indent--;
			write_indent ();
			buffer.append_printf ("</class>\n");

			write_indent ();
			buffer.append_printf ("<record name=\"%s\"", gtype_struct_name);
			write_ctype_attributes (cl, "Class");
			buffer.append_printf (" glib:is-gtype-struct-for=\"%s\"", cl.name);
			buffer.append_printf (">\n");
			indent++;

			write_indent ();
			buffer.append_printf ("<field name=\"parent_class\">\n");
			indent++;
			write_indent ();
			buffer.append_printf ("<type name=\"%sClass\" c:type=\"%sClass\"/>\n", gi_type_name (cl.base_class), cl.base_class.get_cname ());
			indent--;
			write_indent ();
			buffer.append_printf ("</field>\n");

			foreach (Method m in cl.get_methods ()) {
				if (m.is_abstract || m.is_virtual) {
					write_indent ();
					buffer.append_printf("<field name=\"%s\">\n", m.name);
					indent++;
					write_signature(m, "callback", true);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				}
			}

			foreach (Signal sig in cl.get_signals ()) {
				if (sig.default_handler != null) {
					write_indent ();
					buffer.append_printf ("<field name=\"%s\">\n", sig.name);
					indent++;
					write_signature (sig.default_handler, "callback", true);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				}
			}


			indent--;
			write_indent ();
			buffer.append_printf ("</record>\n");
		} else {
			write_indent ();
			buffer.append_printf ("<record name=\"%s\"", cl.name);
			buffer.append_printf (">\n");
			indent++;

			write_annotations (cl);

			cl.accept_children (this);

			indent--;
			write_indent ();
			buffer.append_printf ("</record>\n");
		}
	}

	public override void visit_struct (Struct st) {
		if (st.external_package) {
			return;
		}

		if (!check_accessibility (st)) {
			return;
		}

		write_indent ();
		buffer.append_printf ("<record name=\"%s\"", st.name);
		buffer.append_printf (">\n");
		indent++;

		write_annotations (st);

		st.accept_children (this);

		indent--;
		write_indent ();
		buffer.append_printf ("</record>\n");
	}

	public override void visit_interface (Interface iface) {
		if (iface.external_package) {
			return;
		}

		if (!check_accessibility (iface)) {
			return;
		}

		string gtype_struct_name = iface.name + "Iface";

		write_indent ();
		buffer.append_printf ("<interface name=\"%s\"", iface.name);
		write_gtype_attributes (iface);
		buffer.append_printf (" glib:type-struct=\"%s\"", gtype_struct_name);
		buffer.append_printf (">\n");
		indent++;

		// write prerequisites
		if (iface.get_prerequisites ().size > 0) {
			write_indent ();
			buffer.append_printf ("<requires>\n");
			indent++;

			foreach (DataType base_type in iface.get_prerequisites ()) {
				var object_type = (ObjectType) base_type;
				if (object_type.type_symbol is Class) {
					write_indent ();
					buffer.append_printf ("<object name=\"%s\"/>\n", gi_type_name (object_type.type_symbol));
				} else if (object_type.type_symbol is Interface) {
					write_indent ();
					buffer.append_printf ("<interface name=\"%s\"/>\n", gi_type_name (object_type.type_symbol));
				} else {
					assert_not_reached ();
				}
			}

			indent--;
			write_indent ();
			buffer.append_printf ("</requires>\n");
		}

		write_annotations (iface);

		iface.accept_children (this);

		indent--;
		write_indent ();
		buffer.append_printf ("</interface>\n");

		write_indent ();
		buffer.append_printf ("<record name=\"%s\"", gtype_struct_name);
		write_ctype_attributes (iface, "Iface");
		buffer.append_printf (" glib:is-gtype-struct-for=\"%s\"", iface.name);
		buffer.append_printf (">\n");
		indent++;

		foreach (Method m in iface.get_methods ()) {
			if (m.is_abstract || m.is_virtual) {
				write_signature(m, "callback", true);
			}
		}

		indent--;
		write_indent ();
		buffer.append_printf ("</record>\n");
	}

	public override void visit_enum (Enum en) {
		if (en.external_package) {
			return;
		}

		if (!check_accessibility (en)) {
			return;
		}

		write_indent ();
		buffer.append_printf ("<enumeration name=\"%s\"", en.name);
		write_gtype_attributes (en);
		buffer.append_printf (">\n");
		indent++;

		write_annotations (en);

		enum_value = 0;
		en.accept_children (this);

		indent--;
		write_indent ();
		buffer.append_printf ("</enumeration>\n");
	}

	private int enum_value;

	public override void visit_enum_value (EnumValue ev) {
		write_indent ();
		buffer.append_printf ("<member name=\"%s\" c:identifier=\"%s\"", ev.name.down (), ev.get_cname ());
		if (ev.value != null) {
			string value = literal_expression_to_value_string (ev.value);
			buffer.append_printf (" value=\"%s\"", value);
		} else {
			buffer.append_printf (" value=\"%d\"", enum_value++);
		}
		buffer.append_printf ("/>\n");
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		if (edomain.external_package) {
			return;
		}

		if (!check_accessibility (edomain)) {
			return;
		}

		write_indent ();
		buffer.append_printf ("<errordomain name=\"%s\"", edomain.name);
		buffer.append_printf (" get-quark=\"%squark\"", edomain.get_lower_case_cprefix ());
		buffer.append_printf (" codes=\"%s\"", edomain.name);
		buffer.append_printf (">\n");

		write_annotations (edomain);

		buffer.append_printf ("</errordomain>\n");

		write_indent ();
		buffer.append_printf ("<enumeration name=\"%s\"", edomain.name);
		write_ctype_attributes (edomain);
		buffer.append_printf (">\n");
		indent++;

		enum_value = 0;
		edomain.accept_children (this);

		indent--;
		write_indent ();
		buffer.append_printf ("</enumeration>\n");
	}

	public override void visit_error_code (ErrorCode ecode) {
		write_indent ();
		buffer.append_printf ("<member name=\"%s\" c:identifier=\"%s\"", ecode.name.down (), ecode.get_cname ());
		if (ecode.value != null) {
			string value = literal_expression_to_value_string (ecode.value);
			buffer.append_printf (" value=\"%s\"", value);
		} else {
			buffer.append_printf (" value=\"%d\"", enum_value++);
		}
		buffer.append_printf ("/>\n");
	}

	public override void visit_constant (Constant c) {
		if (c.external_package) {
			return;
		}

		if (!check_accessibility (c)) {
			return;
		}

		//TODO Add better constant evaluation
		var initializer = c.initializer;
		string value = literal_expression_to_value_string (initializer);

		write_indent ();
		buffer.append_printf ("<constant name=\"%s\" c:identifier=\"%s\"", c.name, c.get_cname ());
		buffer.append_printf (" value=\"%s\"", value);
		buffer.append_printf (">\n");
		indent++;

		write_type (initializer.value_type);

		indent--;
		write_indent ();
		buffer.append_printf ("</constant>\n");
	}

	public override void visit_field (Field f) {
		if (f.external_package) {
			return;
		}

		if (!check_accessibility (f)) {
			return;
		}

		write_indent ();
		buffer.append_printf ("<field name=\"%s\"", f.get_cname ());
		if (f.field_type.nullable) {
			buffer.append_printf (" allow-none=\"1\"");
		}
		buffer.append_printf (">\n");
		indent++;

		write_annotations (f);

		write_type (f.field_type);

		indent--;
		write_indent ();
		buffer.append_printf ("</field>\n");
	}

	private void write_implicit_params (DataType type, ref int index, bool has_array_length, string name, ParameterDirection direction) {
		if (type is ArrayType && has_array_length) {
			var int_type = new IntegerType (CodeContext.get ().root.scope.lookup ("int") as Struct);
			write_param_or_return (int_type, "parameter", ref index, has_array_length, "%s_length1".printf (name), direction);
		} else if (type is DelegateType) {
			var data_type = new PointerType (new VoidType ());
			write_param_or_return (data_type, "parameter", ref index, false, "%s_target".printf (name), direction);
			if (type.value_owned) {
				var notify_type = new DelegateType (CodeContext.get ().root.scope.lookup ("GLib").scope.lookup ("DestroyNotify") as Delegate);
				write_param_or_return (notify_type, "parameter", ref index, false, "%s_target_destroy_notify".printf (name), direction);
			}
		}
	}

	private void write_params_and_return (List<FormalParameter> params, DataType? return_type, bool return_array_length, bool constructor = false, DataType? instance_type = null, bool user_data = false) {
		int last_index = 0;
		if (params.size != 0 || instance_type != null || (return_type is ArrayType && return_array_length) || (return_type is DelegateType)) {
			write_indent ();
			buffer.append_printf ("<parameters>\n");
			indent++;
			int index = 1;

			if (instance_type != null) {
				write_param_or_return (instance_type, "parameter", ref index, false, "self");
			}

			foreach (FormalParameter param in params) {
				write_param_or_return (param.parameter_type, "parameter", ref index, !param.no_array_length, param.name, param.direction);

				write_implicit_params (param.parameter_type, ref index, !param.no_array_length, param.name, param.direction);
			}

			last_index = index - 1;
			write_implicit_params (return_type, ref index, return_array_length, "result", ParameterDirection.OUT);

			if (user_data) {
				write_indent ();
				buffer.append_printf ("<parameter name=\"user_data\" transfer-ownership=\"none\" closure=\"%d\">\n", index);
				indent++;
				write_indent ();
				buffer.append_printf ("<type name=\"any\" c:type=\"void*\"/>\n");
				indent--;
				write_indent ();
				buffer.append_printf ("</parameter>\n");
			}

			indent--;
			write_indent ();
			buffer.append_printf ("</parameters>\n");
		}

		if (return_type != null) {
			write_param_or_return (return_type, "return-value", ref last_index, return_array_length, null, ParameterDirection.IN, constructor);
		}
	}

	public override void visit_delegate (Delegate cb) {
		if (cb.external_package) {
			return;
		}

		if (!check_accessibility (cb)) {
			return;
		}

		write_indent ();
		buffer.append_printf ("<callback name=\"%s\"", cb.name);
		buffer.append_printf (" c:type=\"%s\"", cb.get_cname ());
		if (cb.tree_can_fail) {
			buffer.append_printf (" throws=\"1\"");
		}
		buffer.append_printf (">\n");
		indent++;

		write_annotations (cb);

		write_params_and_return (cb.get_parameters (), cb.return_type, !cb.no_array_length, false, null, cb.has_target);

		indent--;
		write_indent ();
		buffer.append_printf ("</callback>\n");
	}

	public override void visit_method (Method m) {
		if (m.external_package) {
			return;
		}

		// don't write interface implementation unless it's an abstract or virtual method
		if (!check_accessibility (m) || m.overrides || (m.base_interface_method != null && !m.is_abstract && !m.is_virtual)) {
			return;
		}

		string tag_name = "method";
		var parent = m.parent_symbol;
		if (parent is Namespace || m.binding == MemberBinding.STATIC) {
			tag_name = "function";
		}

		write_signature (m, tag_name);

		if (m.is_abstract || m.is_virtual) {
			write_signature (m, "virtual-method", false);
		}
	}

	private void write_signature (Method m, string tag_name, bool instance = false) {
		if (m.coroutine) {
			string finish_name = m.name;
			if (finish_name.has_suffix ("_async")) {
				finish_name = finish_name.substring (0, finish_name.length - "_async".length);
			}
			finish_name += "_finish";
			do_write_signature (m, tag_name, instance, m.name, m.get_cname (), m.get_async_begin_parameters (), new VoidType (), false);
			do_write_signature (m, tag_name, instance, finish_name, m.get_finish_cname (), m.get_async_end_parameters (), m.return_type, m.tree_can_fail);
		} else {
			do_write_signature (m, tag_name, instance, m.name, m.get_cname (), m.get_parameters (), m.return_type, m.tree_can_fail);
		}
	}

	private void do_write_signature (Method m, string tag_name, bool instance, string name, string cname, List<Vala.FormalParameter> params, DataType return_type, bool can_fail) {
		write_indent ();
		buffer.append_printf ("<%s name=\"%s\"", tag_name, name);
		if (tag_name == "virtual-method") {
			buffer.append_printf (" invoker=\"%s\"", name);
		} else if (tag_name == "callback") {
			/* this is only used for vfuncs */
			buffer.append_printf (" c:type=\"%s\"", name);
		} else {
			buffer.append_printf (" c:identifier=\"%s\"", cname);
		}
		if (can_fail) {
			buffer.append_printf (" throws=\"1\"");
		}
		buffer.append_printf (">\n");
		indent++;

		write_annotations (m);

		DataType instance_type = null;
		if (instance) {
			instance_type = CCodeBaseModule.get_data_type_for_symbol ((TypeSymbol) m.parent_symbol);
		}

		write_params_and_return (params, return_type, !m.no_array_length, false, instance_type);

		indent--;
		write_indent ();
		buffer.append_printf ("</%s>\n", tag_name);
	}
	
	public override void visit_creation_method (CreationMethod m) {
		if (m.external_package) {
			return;
		}

		if (!check_accessibility (m)) {
			return;
		}

		write_indent ();

		if (m == ((Class)m.parent_symbol).default_construction_method) {
			buffer.append_printf ("<constructor name=\"new\" c:identifier=\"%s\"", m.get_cname ());
		} else {
			buffer.append_printf ("<constructor name=\"%s\" c:identifier=\"%s\"", m.name, m.get_cname ());
		}

		if (m.tree_can_fail) {
			buffer.append_printf (" throws=\"1\"");
		}
		buffer.append_printf (">\n");
		indent++;

		write_annotations (m);


		var datatype = CCodeBaseModule.get_data_type_for_symbol ((TypeSymbol) m.parent_symbol);
		write_params_and_return (m.get_parameters (), datatype, false, true);

		indent--;
		write_indent ();
		buffer.append_printf ("</constructor>\n");
	}

	public override void visit_property (Property prop) {
		if (!check_accessibility (prop) || prop.overrides || (prop.base_interface_property != null && !prop.is_abstract && !prop.is_virtual)) {
			return;
		}

		write_indent ();
		buffer.append_printf ("<property name=\"%s\"", prop.get_canonical_name ());
		if (prop.get_accessor == null) {
			buffer.append_printf (" readable=\"0\"");
		}
		if (prop.set_accessor != null) {
			buffer.append_printf (" writable=\"1\"");
			if (prop.set_accessor.construction) {
				if (!prop.set_accessor.writable) {
					buffer.append_printf (" construct-only=\"1\"");
				} else {
					buffer.append_printf (" construct=\"1\"");
				}
			}
		}
		buffer.append_printf (">\n");
		indent++;

		write_annotations (prop);

		write_type (prop.property_type);

		indent--;
		write_indent ();
		buffer.append_printf ("</property>\n");
	}

	public override void visit_signal (Signal sig) {
		if (!check_accessibility (sig)) {
			return;
		}
		
		write_indent ();
		buffer.append_printf ("<glib:signal name=\"%s\"", sig.get_cname ());
		buffer.append_printf (">\n");
		indent++;

		write_annotations (sig);

		write_params_and_return (sig.get_parameters (), sig.return_type, false);

		indent--;
		write_indent ();
		buffer.append_printf ("</glib:signal>\n");
	}

	private void write_indent () {
		int i;
		
		for (i = 0; i < indent; i++) {
			buffer.append_c ('\t');
		}
	}

	private void write_indent_stream () {
		int i;

		for (i = 0; i < indent; i++) {
			stream.putc ('\t');
		}
	}


	private void write_param_or_return (DataType type, string tag, ref int index, bool has_array_length, string? name = null, ParameterDirection direction = ParameterDirection.IN, bool constructor = false) {
		write_indent ();
		buffer.append_printf ("<%s", tag);
		if (name != null) {
			buffer.append_printf (" name=\"%s\"", name);
		}
		if (direction == ParameterDirection.REF) {
			buffer.append_printf (" direction=\"inout\"");
		} else if (direction == ParameterDirection.OUT) {
			buffer.append_printf (" direction=\"out\"");
		}

		Delegate delegate_type = type.data_type as Delegate;

		if ((type.value_owned && delegate_type == null) || constructor) {
			buffer.append_printf (" transfer-ownership=\"full\"");
		} else {
			buffer.append_printf (" transfer-ownership=\"none\"");
		}
		if (type.nullable) {
			buffer.append_printf (" allow-none=\"1\"");
		}

		if (delegate_type != null && delegate_type.has_target) {
			buffer.append_printf (" closure=\"%i\"", index + 1);
			if (type.value_owned) {
				buffer.append_printf (" destroy=\"%i\"", index + 2);
			}
		}

		buffer.append_printf (">\n");
		indent++;

		write_type (type, has_array_length ? index : -1);

		indent--;
		write_indent ();
		buffer.append_printf ("</%s>\n", tag);
		index++;
	}

	private void write_ctype_attributes (TypeSymbol symbol, string suffix = "") {
		buffer.append_printf (" c:type=\"%s%s\"", symbol.get_cname (), suffix);
	}

	private void write_gtype_attributes (TypeSymbol symbol) {
		write_ctype_attributes(symbol);
		buffer.append_printf (" glib:type-name=\"%s\"", symbol.get_cname ());
		buffer.append_printf (" glib:get-type=\"%sget_type\"", symbol.get_lower_case_cprefix ());
	}

	private void write_type (DataType type, int index = -1) {
		if (type is ArrayType) {
			var array_type = (ArrayType) type;

			write_indent ();
			buffer.append_printf ("<array");
			if (array_type.fixed_length) {
				buffer.append_printf (" fixed-length\"%i\"", array_type.length);
			} else if (index != -1) {
				buffer.append_printf (" length=\"%i\"", index + 1);
			}
			buffer.append_printf (">\n");
			indent++;

			write_type (array_type.element_type);

			indent--;
			write_indent ();
			buffer.append_printf ("</array>\n");
		} else if (type is VoidType) {
			write_indent ();
			buffer.append_printf ("<type name=\"none\"/>\n");
		} else if (type is PointerType) {
			write_indent ();
			buffer.append_printf ("<type name=\"any\" c:type=\"%s\"/>\n", type.get_cname ());
		} else if (type.data_type != null) {
			write_indent ();
			buffer.append_printf ("<type name=\"%s\" c:type=\"%s\"", gi_type_name (type.data_type), type.get_cname ());

			List<DataType> type_arguments = type.get_type_arguments ();
			if (type_arguments.size == 0) {
				buffer.append_printf ("/>\n");
			} else {
				buffer.append_printf (">\n");
				indent++;

				foreach (DataType type_argument in type_arguments) {
					write_type (type_argument);
				}

				indent--;
				write_indent ();
				buffer.append_printf ("</type>\n");
			}
		} else if (type is DelegateType) {
			var deleg_type = (DelegateType) type;
			write_indent ();
			buffer.append_printf ("<type name=\"%s\" c:type=\"%s\"/>\n", gi_type_name (deleg_type.delegate_symbol), type.get_cname ());
		} else {
			write_indent ();
			buffer.append_printf ("<type name=\"%s\"/>\n", type.to_string ());
		}
	}

	private void write_annotations (CodeNode node) {
		foreach (Attribute attr in node.attributes) {
			string name = camel_case_to_canonical (attr.name);
			foreach (string arg_name in attr.args.get_keys ()) {
				var arg = attr.args.get (arg_name);

				string value = literal_expression_to_value_string ((Literal) arg);

				if (value != null) {
					write_indent ();
					buffer.append_printf ("<annotation key=\"%s.%s\" value=\"%s\"/>\n",
						name, camel_case_to_canonical (arg_name), value);
				}
			}
		}
	}

	private string gi_type_name (TypeSymbol type_symbol) {
		Symbol parent = type_symbol.parent_symbol;
		if (parent is Namespace) {
			Namespace ns = parent as Namespace;
			if (ns.name != null) {
				if (type_symbol.source_reference.file.gir_namespace != null) {
					GIRNamespace external = GIRNamespace (type_symbol.source_reference.file.gir_namespace, type_symbol.source_reference.file.gir_version);
					if (!externals.contains (external)) {
						externals.add (external);
					}
					return "%s.%s".printf (type_symbol.source_reference.file.gir_namespace, type_symbol.name);
				} else {
					unannotated_namespaces.add(ns);
				}
			}
		}

		return vala_to_gi_type_name (type_symbol.get_full_name());
	}

	private string vala_to_gi_type_name (string name) {
		if (name == "bool") {
			return "boolean";
		} else if (name == "string") {
			return "utf8";
		} else if (!name.contains (".")) {
			return name;
		} else {
			string[] split_name = name.split (".");

			StringBuilder type_name = new StringBuilder ();
			type_name.append (split_name[0]);
			type_name.append_unichar ('.');
			for (int i = 1; i < split_name.length; i++) {
				type_name.append (split_name[i]);
			}
			return type_name.str;
		}
	}

	private string? literal_expression_to_value_string (Expression literal) {
		if (literal is StringLiteral) {
			var lit = literal as StringLiteral;
			if (lit != null) {
				return Markup.escape_text (lit.eval ());
			}
		} else if (literal is CharacterLiteral) {
			return "%c".printf ((char) ((CharacterLiteral) literal).get_char ());
		} else if (literal is BooleanLiteral) {
			return ((BooleanLiteral) literal).value ? "true" : "false";
		} else if (literal is RealLiteral) {
			return ((RealLiteral) literal).value;
		} else if (literal is IntegerLiteral) {
			return ((IntegerLiteral) literal).value;
		} else if (literal is UnaryExpression) {
			var unary = (UnaryExpression) literal;
			if (unary.operator == UnaryOperator.MINUS) {
				if (unary.inner is RealLiteral) {
					return "-" + ((RealLiteral) unary.inner).value;
				} else if (unary.inner is IntegerLiteral) {
					return "-" + ((IntegerLiteral) unary.inner).value;
				}
			}
		}
		return null;
	}

	private string camel_case_to_canonical (string name) {
		string[] parts = Symbol.camel_case_to_lower_case (name).split ("_");
		return string.joinv ("-", parts);
	}

	private bool check_accessibility (Symbol sym) {
		if (sym.access == SymbolAccessibility.PUBLIC ||
		    sym.access == SymbolAccessibility.PROTECTED) {
			return true;
		}

		return false;
	}
}
