/* valagirwriter.vala
 *
 * Copyright (C) 2008-2012  Jürg Billeter
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
	private string gir_shared_library;

	protected virtual string? get_interface_comment (Interface iface) {
		return null;
	}

	protected virtual string? get_struct_comment (Struct st) {
		return null;
	}

	protected virtual string? get_enum_comment (Enum en) {
		return null;
	}

	protected virtual string? get_class_comment (Class c) {
		return null;
	}

	protected virtual string? get_error_code_comment (ErrorCode ecode) {
		return null;
	}

	protected virtual string? get_enum_value_comment (EnumValue ev) {
		return null;
	}

	protected virtual string? get_constant_comment (Constant c) {
		return null;
	}

	protected virtual string? get_error_domain_comment (ErrorDomain edomain) {
		return null;
	}

	protected virtual string? get_field_comment (Field f) {
		return null;
	}

	protected virtual string? get_delegate_comment (Delegate cb) {
		return null;
	}

	protected virtual string? get_method_comment (Method m) {
		return null;
	}

	protected virtual string? get_property_comment (Property prop) {
		return null;
	}

	protected virtual string? get_delegate_return_comment (Delegate cb) {
		return null;
	}

	protected virtual string? get_signal_return_comment (Signal sig) {
		return null;
	}

	protected virtual string? get_method_return_comment (Method m) {
		return null;
	}

	protected virtual string? get_signal_comment (Signal sig) {
		return null;
	}

	protected virtual string? get_parameter_comment (Parameter param) {
		return null;
	}

	StringBuilder buffer = new StringBuilder();
	FileStream stream;
	Vala.HashSet<Namespace> unannotated_namespaces = new Vala.HashSet<Namespace>();
	Vala.HashSet<Namespace> our_namespaces = new Vala.HashSet<Namespace>();
	Vala.ArrayList<Vala.Symbol> hierarchy = new Vala.ArrayList<Vala.Symbol>();
	Vala.ArrayList<Vala.CodeNode> deferred = new Vala.ArrayList<Vala.CodeNode>();

	int indent;

	private TypeSymbol gobject_type;
	private TypeSymbol ginitiallyunowned_type;

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
			if (i.ns != this.gir_namespace) {
				write_indent_stream ();
				stream.printf ("<include name=\"%s\" version=\"%s\"/>\n", i.ns, i.version);
			}
		}
	}


	/**
	 * Writes the public interface of the specified code context into the
	 * specified file.
	 *
	 * @param context      a code context
	 * @param gir_filename a relative or absolute filename
	 */
	public void write_file (CodeContext context, string directory, string gir_filename, string gir_namespace, string gir_version, string package, string? gir_shared_library = null) {
		this.context = context;
		this.directory = directory;
		this.gir_namespace = gir_namespace;
		this.gir_version = gir_version;
		this.gir_shared_library = gir_shared_library;

		var root_symbol = context.root;
		var glib_ns = root_symbol.scope.lookup ("GLib");
		gobject_type = (TypeSymbol) glib_ns.scope.lookup ("Object");
		ginitiallyunowned_type = (TypeSymbol) glib_ns.scope.lookup ("InitiallyUnowned");

		write_package (package);

		context.accept (this);

		indent--;
		buffer.append_printf ("</repository>\n");

		string filename = "%s%c%s".printf (directory, Path.DIR_SEPARATOR, gir_filename);
		stream = FileStream.open (filename, "w");
		if (stream == null) {
			Report.error (null, "unable to open `%s' for writing".printf (filename));
			return;
		}

		stream.printf ("<?xml version=\"1.0\"?>\n");

		stream.printf ("<repository version=\"1.2\"");
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

		if (our_namespaces.size == 0) {
			Report.error (null, "No suitable namespace found to export for GIR");
		}
	}

	private void write_doc (string? comment) {
		if (comment != null) {
			write_indent ();
			buffer.append ("<doc xml:whitespace=\"preserve\">");
			buffer.append (comment);
			buffer.append ("</doc>\n");
		}
	}

	private void write_package (string package) {
		write_indent ();
		buffer.append_printf ("<package name=\"%s\"/>\n", package);
	}

	private void write_c_includes (Namespace ns) {
		// Collect C header filenames
		Set<string> header_filenames = new HashSet<string> (str_hash, str_equal);
		foreach (string c_header_filename in CCodeBaseModule.get_ccode_header_filenames (ns).split (",")) {
			header_filenames.add (c_header_filename);
		}
		foreach (Symbol symbol in ns.scope.get_symbol_table ().get_values ()) {
			foreach (string c_header_filename in CCodeBaseModule.get_ccode_header_filenames (symbol).split (",")) {
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
			hierarchy.insert (0, ns);
			ns.accept_children (this);
			hierarchy.remove_at (0);
			return;
		}

		if (ns.parent_symbol.name != null) {
			ns.accept_children (this);
			return;
		}

		write_c_includes (ns);

		write_indent ();
		buffer.append_printf ("<namespace name=\"%s\" version=\"%s\"", gir_namespace, gir_version);
		string? cprefix = CCodeBaseModule.get_ccode_prefix (ns);
		if (gir_shared_library != null) {
			buffer.append_printf(" shared-library=\"%s\"", gir_shared_library);
		}
		if (cprefix != null) {
			buffer.append_printf (" c:prefix=\"%s\"", cprefix);
		}
		buffer.append_printf (">\n");
		indent++;

		write_annotations (ns);

		hierarchy.insert (0, ns);
		ns.accept_children (this);
		hierarchy.remove_at (0);

		indent--;
		write_indent ();
		buffer.append_printf ("</namespace>\n");
		our_namespaces.add(ns);

		visit_deferred ();
	}

	private void write_symbol_attributes (Symbol symbol) {
		if (symbol.version.deprecated) {
			buffer.append_printf (" deprecated=\"%s\"", (symbol.version.replacement == null) ? "" : "Use %s".printf (symbol.version.replacement));
			if (symbol.version.deprecated_since != null) {
				buffer.append_printf (" deprecated-version=\"%s\"", symbol.version.deprecated_since);
			}
		}
		if (symbol.version.since != null) {
			buffer.append_printf (" version=\"%s\"", symbol.version.since);
		}
	}

	public override void visit_class (Class cl) {
		if (cl.external_package) {
			return;
		}

		if (!check_accessibility (cl)) {
			return;
		}

		if (!(hierarchy[0] is Namespace)) {
			deferred.add (cl);
			return;
		}

		if (cl.is_subtype_of (gobject_type)) {
			string gtype_struct_name = get_gir_name (cl) + "Class";

			write_indent ();
			buffer.append_printf ("<class name=\"%s\"", get_gir_name (cl));
			write_gtype_attributes (cl);
			buffer.append_printf (" glib:type-struct=\"%s\"", gtype_struct_name);
			buffer.append_printf (" parent=\"%s\"", gi_type_name (cl.base_class));
			if (cl.is_abstract) {
				buffer.append_printf (" abstract=\"1\"");
			}
			write_symbol_attributes (cl);
			buffer.append_printf (">\n");
			indent++;

			write_doc (get_class_comment (cl));

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
			buffer.append_printf ("<type name=\"%s\" c:type=\"%s\"/>\n", gi_type_name (cl.base_class), CCodeBaseModule.get_ccode_name (cl.base_class));
			indent--;
			write_indent ();
			buffer.append_printf("</field>\n");

			write_indent ();
			buffer.append_printf ("<field name=\"priv\">\n");
			indent++;
			write_indent ();
			buffer.append_printf ("<type name=\"%sPrivate\" c:type=\"%sPrivate*\"/>\n", get_gir_name (cl), CCodeBaseModule.get_ccode_name (cl));
			indent--;
			write_indent ();
			buffer.append_printf("</field>\n");

			hierarchy.insert (0, cl);
			cl.accept_children (this);
			hierarchy.remove_at (0);

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
			buffer.append_printf ("<type name=\"%sClass\" c:type=\"%sClass\"/>\n", gi_type_name (cl.base_class), CCodeBaseModule.get_ccode_name (cl.base_class));
			indent--;
			write_indent ();
			buffer.append_printf ("</field>\n");

			foreach (Method m in cl.get_methods ()) {
				if (m.is_abstract || m.is_virtual) {
					write_indent ();
					if (m.coroutine) {
						string finish_name = m.name;
						if (finish_name.has_suffix ("_async")) {
							finish_name = finish_name.substring (0, finish_name.length - "_async".length);
						}
						finish_name += "_finish";

						write_indent ();
						buffer.append_printf("<field name=\"%s\">\n", m.name);
						indent++;
						do_write_signature (m, "callback", true, m.name, CCodeBaseModule.get_ccode_name (m), m.get_async_begin_parameters (), new VoidType (), false, false);
						indent--;
						write_indent ();
						buffer.append_printf ("</field>\n");

						write_indent ();
						buffer.append_printf("<field name=\"%s\">\n", finish_name);
						indent++;
						do_write_signature (m, "callback", true, finish_name, CCodeBaseModule.get_ccode_finish_name (m), m.get_async_end_parameters (), m.return_type, m.tree_can_fail, false);
						indent--;
						write_indent ();
						buffer.append_printf ("</field>\n");
					} else {
						write_indent ();
						buffer.append_printf("<field name=\"%s\">\n", m.name);
						indent++;
						do_write_signature (m, "callback", true, m.name, CCodeBaseModule.get_ccode_name (m), m.get_parameters (), m.return_type, m.tree_can_fail, false);
						indent--;
						write_indent ();
						buffer.append_printf ("</field>\n");
					}
				}
			}

			foreach (Signal sig in cl.get_signals ()) {
				if (sig.default_handler != null) {
					write_indent ();
					buffer.append_printf ("<field name=\"%s\">\n", sig.name);
					indent++;
					write_signature (sig.default_handler, "callback", false, true);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				}
			}

			indent--;
			write_indent ();
			buffer.append_printf ("</record>\n");

			write_indent ();
			buffer.append_printf ("<record name=\"%sPrivate\" c:type=\"%sPrivate\" disguised=\"1\"/>\n", get_gir_name (cl), CCodeBaseModule.get_ccode_name (cl));
		} else {
			write_indent ();
			buffer.append_printf ("<record name=\"%s\"", get_gir_name (cl));
			write_symbol_attributes (cl);
			buffer.append_printf (">\n");
			indent++;

			write_doc (get_class_comment (cl));

			write_annotations (cl);

			hierarchy.insert (0, cl);
			cl.accept_children (this);
			hierarchy.remove_at (0);

			indent--;
			write_indent ();
			buffer.append_printf ("</record>\n");
		}

		visit_deferred ();
	}

	public override void visit_struct (Struct st) {
		if (st.external_package) {
			return;
		}

		if (!check_accessibility (st)) {
			return;
		}

		if (!(hierarchy[0] is Namespace)) {
			deferred.add (st);
			return;
		}

		write_indent ();
		buffer.append_printf ("<record name=\"%s\"", get_gir_name (st));
		write_symbol_attributes (st);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_struct_comment (st));

		write_annotations (st);

		hierarchy.insert (0, st);
		st.accept_children (this);
		hierarchy.remove_at (0);

		indent--;
		write_indent ();
		buffer.append_printf ("</record>\n");

		visit_deferred ();
	}

	public override void visit_interface (Interface iface) {
		if (iface.external_package) {
			return;
		}

		if (!check_accessibility (iface)) {
			return;
		}

		if (!(hierarchy[0] is Namespace)) {
			deferred.add (iface);
			return;
		}

		string gtype_struct_name = iface.name + "Iface";

		write_indent ();
		buffer.append_printf ("<interface name=\"%s\"", get_gir_name (iface));
		write_gtype_attributes (iface);
		buffer.append_printf (" glib:type-struct=\"%s\"", gtype_struct_name);
		write_symbol_attributes (iface);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_interface_comment (iface));

		// write prerequisites
		if (iface.get_prerequisites ().size > 0) {
			foreach (DataType base_type in iface.get_prerequisites ()) {
				write_indent ();
				buffer.append_printf ("<prerequisite name=\"%s\"/>\n", gi_type_name (((ObjectType) base_type).type_symbol));
			}
		}

		write_annotations (iface);

		hierarchy.insert (0, iface);
		iface.accept_children (this);
		hierarchy.remove_at (0);

		indent--;
		write_indent ();
		buffer.append_printf ("</interface>\n");

		write_indent ();
		buffer.append_printf ("<record name=\"%s\"", gtype_struct_name);
		write_ctype_attributes (iface, "Iface");
		buffer.append_printf (" glib:is-gtype-struct-for=\"%s\"", iface.name);
		buffer.append_printf (">\n");
		indent++;

		write_indent ();
		buffer.append_printf ("<field name=\"parent_iface\">\n");
		indent++;
		write_indent ();
		buffer.append_printf ("<type name=\"GObject.TypeInterface\" c:type=\"GTypeInterface\"/>\n");
		indent--;
		write_indent ();
		buffer.append_printf ("</field>\n");

		foreach (Method m in iface.get_methods ()) {
			if (m.is_abstract || m.is_virtual) {
				if (m.coroutine) {
					string finish_name = m.name;
					if (finish_name.has_suffix ("_async")) {
						finish_name = finish_name.substring (0, finish_name.length - "_async".length);
					}
					finish_name += "_finish";

					write_indent ();
					buffer.append_printf("<field name=\"%s\">\n", m.name);
					indent++;
					do_write_signature (m, "callback", true, m.name, CCodeBaseModule.get_ccode_name (m), m.get_async_begin_parameters (), new VoidType (), false, false);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");

					write_indent ();
					buffer.append_printf("<field name=\"%s\">\n", finish_name);
					indent++;
					do_write_signature (m, "callback", true, finish_name, CCodeBaseModule.get_ccode_finish_name (m), m.get_async_end_parameters (), m.return_type, m.tree_can_fail, false);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				} else {
					write_indent ();
					buffer.append_printf("<field name=\"%s\">\n", m.name);
					indent++;
					do_write_signature (m, "callback", true, m.name, CCodeBaseModule.get_ccode_name (m), m.get_parameters (), m.return_type, m.tree_can_fail, false);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				}
			}
		}

		foreach (var prop in iface.get_properties ()) {
			if (prop.is_abstract || prop.is_virtual) {
				if (prop.get_accessor != null) {
					var m = prop.get_accessor.get_method ();
					write_indent ();
					buffer.append_printf("<field name=\"%s\">\n", m.name);
					indent++;
					do_write_signature (m, "callback", true, m.name, CCodeBaseModule.get_ccode_name (m), m.get_parameters (), m.return_type, m.tree_can_fail, false);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				}

				if (prop.set_accessor != null) {
					var m = prop.set_accessor.get_method ();
					write_indent ();
					buffer.append_printf("<field name=\"%s\">\n", m.name);
					indent++;
					do_write_signature (m, "callback", true, m.name, CCodeBaseModule.get_ccode_name (m), m.get_parameters (), m.return_type, m.tree_can_fail, false);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				}
			}
		}

		indent--;
		write_indent ();
		buffer.append_printf ("</record>\n");

		visit_deferred ();
	}

	private void visit_deferred () {
		var nodes = this.deferred;
		this.deferred = new Vala.ArrayList<Vala.CodeNode>();

		foreach (var node in nodes) {
			node.accept (this);
		}
	}

	private string? get_gir_name (Symbol symbol) {
		string? gir_name = null;
		var h0 = hierarchy[0];

		for (Symbol? cur_sym = symbol ; cur_sym != null ; cur_sym = cur_sym.parent_symbol) {
			if (cur_sym == h0) {
				break;
			}

			var cur_name = cur_sym.get_attribute_string ("GIR", "name");
			if (cur_name == null) {
				cur_name = cur_sym.name;
			}
			gir_name = cur_name.concat (gir_name);
		}

		return gir_name;
	}

	public override void visit_enum (Enum en) {
		if (en.external_package) {
			return;
		}

		if (!check_accessibility (en)) {
			return;
		}

		if (!(hierarchy[0] is Namespace)) {
			deferred.add (en);
			return;
		}

		string element_name = (en.is_flags) ? "bitfield" : "enumeration";

		write_indent ();
		buffer.append_printf ("<%s name=\"%s\"", element_name, get_gir_name (en));
		write_gtype_attributes (en);
		write_symbol_attributes (en);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_enum_comment (en));

		write_annotations (en);

		enum_value = 0;
		hierarchy.insert (0, en);
		en.accept_children (this);
		hierarchy.remove_at (0);

		indent--;
		write_indent ();
		buffer.append_printf ("</%s>\n", element_name);

		visit_deferred ();
	}

	private int enum_value;

	public override void visit_enum_value (EnumValue ev) {
		write_indent ();
		var en = (Enum) hierarchy[0];
		buffer.append_printf ("<member name=\"%s\" c:identifier=\"%s\"", ev.name.down (), CCodeBaseModule.get_ccode_name (ev));
		if (ev.value != null) {
			string value = literal_expression_to_value_string (ev.value);
			buffer.append_printf (" value=\"%s\"", value);
		} else {
			if (en.is_flags) {
				buffer.append_printf (" value=\"%d\"", 1 << enum_value++);
			} else {
				buffer.append_printf (" value=\"%d\"", enum_value++);
			}
		}
		write_symbol_attributes (ev);

		string? comment = get_enum_value_comment (ev);
		if (comment == null) {
			buffer.append_printf ("/>\n");
		} else {
			buffer.append_printf (">\n");
			indent++;

			write_doc (comment);

			indent--;
			write_indent ();
			buffer.append_printf ("</member>\n");
		}
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		if (edomain.external_package) {
			return;
		}

		if (!check_accessibility (edomain)) {
			return;
		}

		write_indent ();
		buffer.append_printf ("<enumeration name=\"%s\"", edomain.name);
		write_ctype_attributes (edomain);
		buffer.append_printf (" glib:error-domain=\"%s\"", CCodeBaseModule.get_quark_name (edomain));
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_error_domain_comment (edomain));

		enum_value = 0;
		hierarchy.insert (0, edomain);
		edomain.accept_children (this);
		hierarchy.remove_at (0);

		indent--;
		write_indent ();
		buffer.append_printf ("</enumeration>\n");

		visit_deferred ();
	}

	public override void visit_error_code (ErrorCode ecode) {
		write_indent ();
		buffer.append_printf ("<member name=\"%s\" c:identifier=\"%s\"", ecode.name.down (), CCodeBaseModule.get_ccode_name (ecode));
		if (ecode.value != null) {
			string value = literal_expression_to_value_string (ecode.value);
			buffer.append_printf (" value=\"%s\"", value);
		} else {
			buffer.append_printf (" value=\"%d\"", enum_value++);
		}
		write_symbol_attributes (ecode);

		string? comment = get_error_code_comment (ecode);
		if (comment == null) {
			buffer.append_printf ("/>\n");
		} else {
			buffer.append_printf (">\n");
			indent++;

			write_doc (comment);

			indent--;
			write_indent ();
			buffer.append_printf ("</member>\n");
		}
	}

	public override void visit_constant (Constant c) {
		if (c.external_package) {
			return;
		}

		if (!check_accessibility (c)) {
			return;
		}

		//TODO Add better constant evaluation
		var initializer = c.value;
		string value = literal_expression_to_value_string (initializer);

		write_indent ();
		buffer.append_printf ("<constant name=\"%s\" c:identifier=\"%s\"", c.name, CCodeBaseModule.get_ccode_name (c));
		buffer.append_printf (" value=\"%s\"", value);
		write_symbol_attributes (c);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_constant_comment (c));

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
		buffer.append_printf ("<field name=\"%s\"", CCodeBaseModule.get_ccode_name (f));
		if (f.variable_type.nullable) {
			buffer.append_printf (" allow-none=\"1\"");
		}
		write_symbol_attributes (f);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_field_comment (f));

		write_annotations (f);

		write_type (f.variable_type);

		indent--;
		write_indent ();
		buffer.append_printf ("</field>\n");
	}

	private void write_implicit_params (DataType type, ref int index, bool has_array_length, string name, ParameterDirection direction) {
		if (type is ArrayType && has_array_length) {
			var int_type = new IntegerType (CodeContext.get ().root.scope.lookup ("int") as Struct);
			write_param_or_return (int_type, true, ref index, has_array_length, "%s_length1".printf (name), null, direction);
		} else if (type is DelegateType) {
			var deleg_type = (DelegateType) type;
			if (deleg_type.delegate_symbol.has_target) {
				var data_type = new PointerType (new VoidType ());
				write_param_or_return (data_type, true, ref index, false, "%s_target".printf (name), null, direction);
				if (deleg_type.is_disposable ()) {
					var notify_type = new DelegateType (CodeContext.get ().root.scope.lookup ("GLib").scope.lookup ("DestroyNotify") as Delegate);
					write_param_or_return (notify_type, true, ref index, false, "%s_target_destroy_notify".printf (name), null, direction);
				}
			}
		}
	}

	void skip_implicit_params (DataType type, ref int index, bool has_array_length) {
		if (type is ArrayType && has_array_length) {
			index++;
		} else if (type is DelegateType) {
			index++;
			var deleg_type = (DelegateType) type;
			if (deleg_type.is_disposable ()) {
				index++;
			}
		}
	}

	private void write_params_and_return (List<Parameter> params, DataType? return_type, bool return_array_length, string? return_comment = null, bool constructor = false, DataType? instance_type = null, bool user_data = false) {
		int last_index = 0;
		bool ret_is_struct = return_type != null && return_type.is_real_non_null_struct_type ();

		if (params.size != 0 || instance_type != null || (return_type is ArrayType && return_array_length) || (return_type is DelegateType) || ret_is_struct) {
			int index = 0;

			if (instance_type != null) {
				index++;
			}

			foreach (Parameter param in params) {
				index++;

				skip_implicit_params (param.variable_type, ref index, CCodeBaseModule.get_ccode_array_length (param));
			}

			if (ret_is_struct) {
				index++;
			} else {
				skip_implicit_params (return_type, ref index, return_array_length);
			}

			last_index = index - 1;
		}

		if (return_type != null && !ret_is_struct) {
			write_param_or_return (return_type, false, ref last_index, return_array_length, null, return_comment, ParameterDirection.IN, constructor);
		} else if (ret_is_struct) {
			write_param_or_return (new VoidType (), false, ref last_index, false, null, return_comment, ParameterDirection.IN);
		}

		if (params.size != 0 || instance_type != null || (return_type is ArrayType && return_array_length) || (return_type is DelegateType) || ret_is_struct) {
			write_indent ();
			buffer.append_printf ("<parameters>\n");
			indent++;
			int index = 0;

			if (instance_type != null) {
				write_param_or_return (instance_type, true, ref index, false, "self");
			}

			foreach (Parameter param in params) {
				write_param_or_return (param.variable_type, true, ref index, CCodeBaseModule.get_ccode_array_length (param), param.name, get_parameter_comment (param), param.direction);

				write_implicit_params (param.variable_type, ref index, CCodeBaseModule.get_ccode_array_length (param), param.name, param.direction);
			}

			if (ret_is_struct) {
				// struct returns are converted to parameters
				write_param_or_return (return_type, true, ref index, false, "result", return_comment, ParameterDirection.OUT, constructor, true);
			} else {
				write_implicit_params (return_type, ref index, return_array_length, "result", ParameterDirection.OUT);
			}

			if (user_data) {
				write_indent ();
				buffer.append_printf ("<parameter name=\"user_data\" transfer-ownership=\"none\" closure=\"%d\">\n", index);
				indent++;
				write_indent ();
				buffer.append_printf ("<type name=\"gpointer\" c:type=\"void*\"/>\n");
				indent--;
				write_indent ();
				buffer.append_printf ("</parameter>\n");
			}

			indent--;
			write_indent ();
			buffer.append_printf ("</parameters>\n");
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
		buffer.append_printf (" c:type=\"%s\"", CCodeBaseModule.get_ccode_name (cb));
		if (cb.tree_can_fail) {
			buffer.append_printf (" throws=\"1\"");
		}
		write_symbol_attributes (cb);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_delegate_comment (cb));

		write_annotations (cb);

		write_params_and_return (cb.get_parameters (), cb.return_type, CCodeBaseModule.get_ccode_array_length (cb), get_delegate_return_comment (cb), false, null, cb.has_target);

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

		// check for unsupported types
		if (!check_signature (m)) {
			return;
		}

		string tag_name = "method";
		var parent = this.hierarchy.get (0);
		if (parent is Enum) {
			deferred.add (m);
			return;
		}

		if (parent is Namespace || m.binding == MemberBinding.STATIC || parent != m.parent_symbol) {
			tag_name = "function";
		}

		write_signature (m, tag_name, true);

		if (m.is_abstract || m.is_virtual) {
			write_signature (m, "virtual-method", true, false);
		}
	}

	bool check_type (DataType type) {
		// gobject-introspection does not currently support va_list parameters
		if (CCodeBaseModule.get_ccode_name (type) == "va_list") {
			return false;
		}

		return true;
	}

	bool check_signature (Method m) {
		if (!check_type (m.return_type)) {
			return false;
		}
		foreach (var param in m.get_parameters ()) {
			if (param.variable_type == null || !check_type (param.variable_type)) {
				return false;
			}
		}
		return true;
	}

	private void write_signature (Method m, string tag_name, bool write_doc, bool instance = false) {
		var parent = this.hierarchy.get (0);
		string name;
		if (m.parent_symbol != parent) {
			instance = false;
			name = CCodeBaseModule.get_ccode_name (m);
			var parent_prefix = CCodeBaseModule.get_ccode_lower_case_prefix (parent);
			if (name.has_prefix (parent_prefix)) {
				name = name.substring (parent_prefix.length);
			}
		} else {
			name = m.name;
		}

		if (m.coroutine) {
			string finish_name = name;
			if (finish_name.has_suffix ("_async")) {
				finish_name = finish_name.substring (0, finish_name.length - "_async".length);
			}
			finish_name += "_finish";
			do_write_signature (m, tag_name, instance, name, CCodeBaseModule.get_ccode_name (m), m.get_async_begin_parameters (), new VoidType (), false, true);
			do_write_signature (m, tag_name, instance, finish_name, CCodeBaseModule.get_ccode_finish_name (m), m.get_async_end_parameters (), m.return_type, m.tree_can_fail, false);
		} else {
			do_write_signature (m, tag_name, instance, name, CCodeBaseModule.get_ccode_name (m), m.get_parameters (), m.return_type, m.tree_can_fail, true);
		}
	}

	private void do_write_signature (Method m, string tag_name, bool instance, string name, string cname, List<Vala.Parameter> params, DataType return_type, bool can_fail, bool write_comment) {
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
		write_symbol_attributes (m);
		buffer.append_printf (">\n");
		indent++;

		string? return_comment = null;
		if (write_comment) {
			return_comment = get_method_return_comment (m);
			write_doc (get_method_comment (m));
		}

		write_annotations (m);

		DataType instance_type = null;
		if (instance) {
			instance_type = CCodeBaseModule.get_data_type_for_symbol ((TypeSymbol) m.parent_symbol);
		}

		write_params_and_return (params, return_type, CCodeBaseModule.get_ccode_array_length (m), return_comment, false, instance_type);

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

		if (m.parent_symbol is Class && ((Class) m.parent_symbol).is_abstract) {
			return;
		}

		write_indent ();

		bool is_struct = m.parent_symbol is Struct;
		// GI doesn't like constructors that return void type
		string tag_name = is_struct ? "function" : "constructor";

		if (m.parent_symbol is Class && m == ((Class)m.parent_symbol).default_construction_method ||
			m.parent_symbol is Struct && m == ((Struct)m.parent_symbol).default_construction_method) {
			string m_name = is_struct ? "init" : "new";
			buffer.append_printf ("<%s name=\"%s\" c:identifier=\"%s\"", tag_name, m_name, CCodeBaseModule.get_ccode_name (m));
		} else {
			buffer.append_printf ("<%s name=\"%s\" c:identifier=\"%s\"", tag_name, m.name, CCodeBaseModule.get_ccode_name (m));
		}

		if (m.tree_can_fail) {
			buffer.append_printf (" throws=\"1\"");
		}
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_method_comment (m));

		write_annotations (m);


		var datatype = CCodeBaseModule.get_data_type_for_symbol ((TypeSymbol) m.parent_symbol);
		write_params_and_return (m.get_parameters (), datatype, false, get_method_return_comment (m), true);

		indent--;
		write_indent ();
		buffer.append_printf ("</%s>\n", tag_name);
	}

	public override void visit_property (Property prop) {
		if (!check_accessibility (prop) || prop.overrides || (prop.base_interface_property != null && !prop.is_abstract && !prop.is_virtual)) {
			return;
		}

		write_indent ();
		buffer.append_printf ("<property name=\"%s\"", prop.name.replace ("_", "-"));
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
		write_symbol_attributes (prop);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_property_comment (prop));

		write_annotations (prop);

		write_type (prop.property_type);

		indent--;
		write_indent ();
		buffer.append_printf ("</property>\n");

		if (prop.get_accessor != null) {
			var m = prop.get_accessor.get_method ();
			if (m != null) {
				visit_method (m);
			}
		}

		if (prop.set_accessor != null) {
			var m = prop.set_accessor.get_method ();
			if (m != null) {
				visit_method (m);
			}
		}
	}

	public override void visit_signal (Signal sig) {
		if (!check_accessibility (sig)) {
			return;
		}
		
		write_indent ();
		buffer.append_printf ("<glib:signal name=\"%s\"", CCodeBaseModule.get_ccode_name (sig));
		write_symbol_attributes (sig);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_signal_comment (sig));

		write_annotations (sig);

		write_params_and_return (sig.get_parameters (), sig.return_type, false, get_signal_return_comment (sig));

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


	private void write_param_or_return (DataType type, bool is_parameter, ref int index, bool has_array_length, string? name = null, string? comment = null, ParameterDirection direction = ParameterDirection.IN, bool constructor = false, bool caller_allocates = false) {
		write_indent ();
		string tag = is_parameter ? "parameter" : "return-value";
		buffer.append_printf ("<%s", tag);
		if (name != null) {
			buffer.append_printf (" name=\"%s\"", name);
		}
		if (direction == ParameterDirection.REF) {
			buffer.append_printf (" direction=\"inout\"");
		} else if (direction == ParameterDirection.OUT) {
			buffer.append_printf (" direction=\"out\"");
		}

		DelegateType delegate_type = type as DelegateType;

		if ((type.value_owned && delegate_type == null) || (constructor && !type.data_type.is_subtype_of (ginitiallyunowned_type))) {
			var any_owned = false;
			foreach (var generic_arg in type.get_type_arguments ()) {
				any_owned |= generic_arg.value_owned;
			}
			if (type.has_type_arguments () && !any_owned) {
				buffer.append_printf (" transfer-ownership=\"container\"");
			} else {
				buffer.append_printf (" transfer-ownership=\"full\"");
			}
		} else {
			buffer.append_printf (" transfer-ownership=\"none\"");
		}
		if (caller_allocates) {
			buffer.append_printf (" caller-allocates=\"1\"");
		}
		if (type.nullable) {
			buffer.append_printf (" allow-none=\"1\"");
		}

		if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
			int closure_index = is_parameter ?
				index + 1 : (type.value_owned ? index - 1 : index);
			buffer.append_printf (" closure=\"%i\"", closure_index);
			if (delegate_type.is_called_once) {
				buffer.append (" scope=\"async\"");
			} else if (type.value_owned) {
				buffer.append_printf (" scope=\"notified\" destroy=\"%i\"", closure_index + 1);
			} else {
				buffer.append (" scope=\"call\"");
			}
		} else if (delegate_type != null) {
			buffer.append (" scope=\"call\"");
		}

		buffer.append_printf (">\n");
		indent++;

		write_doc (comment);

		int length_param_index = -1;
		if (has_array_length) {
			length_param_index = is_parameter ? index + 1 : index;
		}
		write_type (type, length_param_index, direction);

		indent--;
		write_indent ();
		buffer.append_printf ("</%s>\n", tag);
		index++;
	}

	private void write_ctype_attributes (TypeSymbol symbol, string suffix = "") {
		buffer.append_printf (" c:type=\"%s%s\"", CCodeBaseModule.get_ccode_name (symbol), suffix);
	}

	private void write_gtype_attributes (TypeSymbol symbol) {
		write_ctype_attributes(symbol);
		buffer.append_printf (" glib:type-name=\"%s\"", CCodeBaseModule.get_ccode_name (symbol));
		buffer.append_printf (" glib:get-type=\"%sget_type\"", CCodeBaseModule.get_ccode_lower_case_prefix (symbol));
	}

	private void write_type (DataType type, int index = -1, ParameterDirection direction = ParameterDirection.IN) {
		if (type is ArrayType) {
			var array_type = (ArrayType) type;

			write_indent ();
			buffer.append_printf ("<array");
			if (array_type.fixed_length && array_type.length is IntegerLiteral) {
				var lit = (IntegerLiteral) array_type.length;
				buffer.append_printf (" fixed-size=\"%i\"", int.parse (lit.value));
			} else if (index != -1) {
				buffer.append_printf (" length=\"%i\"", index);
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
			buffer.append_printf ("<type name=\"gpointer\" c:type=\"%s\"/>\n", CCodeBaseModule.get_ccode_name (type));
		} else if (type.data_type != null) {
			write_indent ();
			string type_name = gi_type_name (type.data_type);
			bool is_array = false;
			if ((type_name == "GLib.Array") || (type_name == "GLib.PtrArray")) {
				is_array = true;
			}
			buffer.append_printf ("<%s name=\"%s\" c:type=\"%s%s\"", is_array ? "array" : "type", gi_type_name (type.data_type), CCodeBaseModule.get_ccode_name (type), direction == ParameterDirection.IN ? "" : "*");

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
				buffer.append_printf ("</%s>\n", is_array ? "array" : "type");
			}
		} else if (type is DelegateType) {
			var deleg_type = (DelegateType) type;
			write_indent ();
			buffer.append_printf ("<type name=\"%s\" c:type=\"%s\"/>\n", gi_type_name (deleg_type.delegate_symbol), CCodeBaseModule.get_ccode_name (type));
		} else if (type is GenericType) {
			// generic type parameters not supported in GIR
			write_indent ();
			buffer.append ("<type name=\"gpointer\" c:type=\"gpointer\"/>\n");
		} else {
			write_indent ();
			buffer.append_printf ("<type name=\"%s\"/>\n", type.to_string ());
		}
	}

	private void write_annotations (CodeNode node) {
		foreach (Attribute attr in node.attributes) {
			string name = camel_case_to_canonical (attr.name);
			foreach (string arg_name in attr.args.get_keys ()) {
				string value = attr.args.get (arg_name);
				if (value.has_prefix ("\"")) {
					// eval string
					value = attr.get_string (arg_name);
				}

				write_indent ();
				buffer.append_printf ("<annotation key=\"%s.%s\" value=\"%s\"/>\n",
					name, camel_case_to_canonical (arg_name), value);
			}
		}
	}

	private string? get_full_gir_name (Symbol sym) {
		string? gir_name = sym.get_attribute_string ("GIR", "name");

		if (gir_name == null && sym is Namespace) {
			gir_name = sym.get_attribute_string ("CCode", "gir_namespace");
		}
		if (gir_name == null) {
			gir_name = sym.name;
		}

		if (sym.parent_symbol == null) {
			return gir_name;
		}

		if (sym.name == null) {
			return get_full_gir_name (sym.parent_symbol);
		}

		string parent_gir_name = get_full_gir_name (sym.parent_symbol);
		if (parent_gir_name == null) {
			return gir_name;
		}

		string self_gir_name = gir_name.has_prefix (".") ? gir_name.substring (1) : gir_name;
		if ("." in parent_gir_name) {
			return "%s%s".printf (parent_gir_name, self_gir_name);
		} else {
			return "%s.%s".printf (parent_gir_name, self_gir_name);
		}
	}

	private string gi_type_name (TypeSymbol type_symbol) {
		Symbol parent = type_symbol.parent_symbol;
		if (parent is Namespace) {
			Namespace ns = parent as Namespace;
			var ns_gir_name = ns.get_attribute_string ("GIR", "name") ?? ns.name;
			if (ns_gir_name != null) {
				if (type_symbol.source_reference.file.gir_namespace != null) {
					GIRNamespace external = GIRNamespace (type_symbol.source_reference.file.gir_namespace, type_symbol.source_reference.file.gir_version);
					if (!externals.contains (external)) {
						externals.add (external);
					}
					var type_name = type_symbol.get_attribute_string ("GIR", "name") ?? type_symbol.name;
					return "%s.%s".printf (type_symbol.source_reference.file.gir_namespace, type_name);
				} else {
					unannotated_namespaces.add(ns);
				}
			}
		}

		return get_full_gir_name (type_symbol);
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
