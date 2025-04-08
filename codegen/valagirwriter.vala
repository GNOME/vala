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
	private TypeSymbol gtypeinterface_type;
	private TypeSymbol gtypeinstance_type;
	private TypeSymbol gtype_type;

	private struct GIRNamespace {
		public GIRNamespace (string ns, string version) {
			this.ns = ns; this.version = version;
		}
		public string ns;
		public string version;
		public bool equal (GIRNamespace g) {
			return ((ns == g.ns) && (version == g.version));
		}

		public static GIRNamespace for_symbol (Symbol sym) {
			while (sym.parent_symbol != null && sym.parent_symbol.name != null) {
				sym = sym.parent_symbol;
			}
			assert (sym is Namespace);
			string gir_namespace = sym.get_attribute_string ("CCode", "gir_namespace");
			string gir_version = sym.get_attribute_string ("CCode", "gir_version");
			return GIRNamespace (gir_namespace, gir_version);
		}
	}

	private ArrayList<GIRNamespace?> externals = new ArrayList<GIRNamespace?> ((EqualFunc<GIRNamespace>) GIRNamespace.equal);

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
		gtypeinterface_type = (TypeSymbol) glib_ns.scope.lookup ("TypeInterface");
		gtypeinstance_type = (TypeSymbol) glib_ns.scope.lookup ("TypeInstance");
		gtype_type = (TypeSymbol) glib_ns.scope.lookup ("Type");

		write_package (package);

		// Make sure to initialize external files with their gir_namespace/version
		foreach (var file in context.get_source_files ()) {
			file.accept (this);
		}

		context.accept (this);

		indent--;
		buffer.append_printf ("</repository>\n");

		string filename = "%s%c%s".printf (directory, Path.DIR_SEPARATOR, gir_filename);
		var file_exists = FileUtils.test (filename, FileTest.EXISTS);
		var temp_filename = "%s.valatmp".printf (filename);

		if (file_exists) {
			stream = FileStream.open (temp_filename, "w");
		} else {
			stream = FileStream.open (filename, "w");
		}

		if (stream == null) {
			Report.error (null, "unable to open `%s' for writing", filename);
			this.context = null;
			return;
		}

		stream.printf ("<?xml version=\"1.0\"?>\n");

		var header = context.version_header ?
			"<!-- %s generated by %s %s, do not modify. -->".printf (Path.get_basename (filename), Environment.get_prgname (), Vala.BUILD_VERSION) :
			"<!-- %s generated by %s, do not modify. -->".printf (Path.get_basename (filename), Environment.get_prgname ());
		stream.printf ("%s\n", header);

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

		if (file_exists) {
			var changed = true;

			try {
				var old_file = new MappedFile (filename, false);
				var new_file = new MappedFile (temp_filename, false);
				var len = old_file.get_length ();
				if (len == new_file.get_length ()) {
					if (Memory.cmp (old_file.get_contents (), new_file.get_contents (), len) == 0) {
						changed = false;
					}
				}
				old_file = null;
				new_file = null;
			} catch (FileError e) {
				// assume changed if mmap comparison doesn't work
			}

			if (changed) {
				FileUtils.rename (temp_filename, filename);
			} else {
				FileUtils.unlink (temp_filename);
			}
		}

		foreach (var ns in unannotated_namespaces) {
			if (!our_namespaces.contains(ns)) {
				Report.warning (ns.source_reference, "Namespace `%s' does not have a GIR namespace and version annotation", ns.name);
			}
		}
		foreach (var ns in our_namespaces) {
			ns.source_reference.file.gir_namespace = gir_namespace;
			ns.source_reference.file.gir_version = gir_version;
		}

		if (our_namespaces.size == 0) {
			Report.error (null, "No suitable namespace found to export for GIR");
		}

		this.context = null;
	}

	private void write_doc (string? comment, Comment? symbol = null) {
		if (comment != null) {
			write_indent ();
			if (symbol != null) {
				var filename = symbol.source_reference.file.get_relative_filename();
				var line = symbol.source_reference.begin.line;
				var column = symbol.source_reference.begin.column;

				buffer.append_printf ("<doc xml:space=\"preserve\" filename=\"%s\" line=\"%d\" column=\"%d\">", filename, line, column);
			} else {
				buffer.append ("<doc xml:space=\"preserve\">");
			}
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
		foreach (unowned string c_header_filename in get_ccode_header_filenames (ns).split (",")) {
			header_filenames.add (c_header_filename);
		}
		foreach (Symbol symbol in ns.scope.get_symbol_table ().get_values ()) {
			if (symbol.external_package) {
				continue;
			}
			foreach (unowned string c_header_filename in get_ccode_header_filenames (symbol).split (",")) {
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

	public override void visit_source_file (SourceFile source_file) {
		if (source_file.file_type != SourceFileType.PACKAGE) {
			return;
		}

		// Populate gir_namespace/version of source-file like in Namespace.check()
		foreach (var node in source_file.get_nodes ()) {
			if (node is Namespace && ((Namespace) node).parent_symbol == context.root) {
				var a = node.get_attribute ("CCode");
				if (a != null && a.has_argument ("gir_namespace")) {
					var new_gir = a.get_string ("gir_namespace");
					var old_gir = source_file.gir_namespace;
					if (old_gir != null && old_gir != new_gir) {
						source_file.gir_ambiguous = true;
					}
					source_file.gir_namespace = new_gir;
				}
				if (a != null && a.has_argument ("gir_version")) {
					source_file.gir_version = a.get_string ("gir_version");
				}
				break;
			}
		}
	}

	public override void visit_namespace (Namespace ns) {
		if (ns.external_package) {
			return;
		}

		if (!is_visibility (ns)) {
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

		if (our_namespaces.size > 0) {
			Report.error (ns.source_reference, "Secondary top-level namespace `%s' is not supported by GIR format", ns.name);
			return;
		}

		// Use given gir_namespace and gir_version for our top-level namespace
		var old_gir_namespace = ns.get_attribute_string ("CCode", "gir_namespace");
		var old_gir_version = ns.get_attribute_string ("CCode", "gir_version");
		if ((old_gir_namespace != null && old_gir_namespace != gir_namespace)
		    || (old_gir_version != null && old_gir_version != gir_version)) {
			Report.warning (ns.source_reference, "Replace conflicting CCode.gir_* attributes for namespace `%s'", ns.name);
		}
		ns.set_attribute_string ("CCode", "gir_namespace", gir_namespace);
		ns.set_attribute_string ("CCode", "gir_version", gir_version);

		write_c_includes (ns);

		write_indent ();
		buffer.append_printf ("<namespace name=\"%s\" version=\"%s\"", gir_namespace, gir_version);
		string? cprefix = get_ccode_prefix (ns);
		if (gir_shared_library != null) {
			buffer.append_printf(" shared-library=\"%s\"", gir_shared_library);
		}
		if (cprefix != null) {
			buffer.append_printf (" c:prefix=\"%s\"", cprefix);
			buffer.append_printf (" c:identifier-prefixes=\"%s\"", cprefix);
		}
		string? csymbol_prefix = get_ccode_lower_case_suffix (ns);
		if (csymbol_prefix != null) {
			buffer.append_printf (" c:symbol-prefixes=\"%s\"", csymbol_prefix);
		}
		buffer.append_printf (">\n");
		indent++;

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
		if (!is_introspectable (symbol)) {
			buffer.append_printf (" introspectable=\"0\"");
		}
		if (symbol.version.deprecated) {
			buffer.append_printf (" deprecated=\"1\"");
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

		if (!has_namespace (cl)) {
			return;
		}

		if (!(hierarchy[0] is Namespace)) {
			deferred.add (cl);
			return;
		}

		if (!cl.is_compact) {
			string gtype_struct_name = get_gir_name (cl) + "Class";

			write_indent ();
			buffer.append_printf ("<class name=\"%s\"", get_gir_name (cl));
			write_gtype_attributes (cl, true);
			buffer.append_printf (" glib:type-struct=\"%s\"", gtype_struct_name);
			if (cl.base_class == null) {
				buffer.append_printf (" glib:fundamental=\"1\"");
				buffer.append_printf (" glib:ref-func=\"%s\"", get_ccode_ref_function (cl));
				buffer.append_printf (" glib:unref-func=\"%s\"", get_ccode_unref_function (cl));
				buffer.append_printf (" glib:set-value-func=\"%s\"", get_ccode_set_value_function (cl));
				buffer.append_printf (" glib:get-value-func=\"%s\"", get_ccode_get_value_function (cl));
			} else {
				buffer.append_printf (" parent=\"%s\"", gi_type_name (cl.base_class));
			}
			if (cl.is_abstract) {
				buffer.append_printf (" abstract=\"1\"");
			}
			if (cl.is_sealed) {
				buffer.append_printf (" final=\"1\"");
			}
			write_symbol_attributes (cl);
			buffer.append_printf (">\n");
			indent++;

			write_doc (get_class_comment (cl), cl.comment);

			// write implemented interfaces
			foreach (DataType base_type in cl.get_base_types ()) {
				var object_type = (ObjectType) base_type;
				if (object_type.type_symbol is Interface) {
					write_indent ();
					buffer.append_printf ("<implements name=\"%s\"/>\n", gi_type_name (object_type.type_symbol));
				}
			}

			write_indent ();
			buffer.append_printf ("<field name=\"parent_instance\" readable=\"0\" private=\"1\">\n");
			indent++;
			write_indent ();
			if (cl.base_class == null) {
				buffer.append_printf ("<type name=\"%s\" c:type=\"%s\"/>\n", gi_type_name (gtypeinstance_type), get_ccode_name (gtypeinstance_type));
			} else {
				buffer.append_printf ("<type name=\"%s\" c:type=\"%s\"/>\n", gi_type_name (cl.base_class), get_ccode_name (cl.base_class));
			}
			indent--;
			write_indent ();
			buffer.append_printf("</field>\n");

			if (cl.base_class == null) {
				write_indent ();
				buffer.append_printf ("<field name=\"ref_count\">\n");
				indent++;
				write_indent ();
				buffer.append_printf ("<type name=\"gint\" c:type=\"volatile int\"/>\n");
				indent--;
				write_indent ();
				buffer.append_printf("</field>\n");
			}

			if (!context.abi_stability) {
				write_indent ();
				buffer.append_printf ("<field name=\"priv\" readable=\"0\" private=\"1\">\n");
				indent++;
				write_indent ();
				buffer.append_printf ("<type name=\"%sPrivate\" c:type=\"%sPrivate*\"/>\n", get_gir_name (cl), get_ccode_name (cl));
				indent--;
				write_indent ();
				buffer.append_printf("</field>\n");
			}

			if (cl.base_class != null && cl.base_class.is_subtype_of (gobject_type)) {
				foreach (var p in cl.get_type_parameters ()) {
					write_type_parameter (p, "property");
				}
			}

			hierarchy.insert (0, cl);
			cl.accept_children (this);
			hierarchy.remove_at (0);

			if (context.abi_stability) {
				write_indent ();
				buffer.append_printf ("<field name=\"priv\" readable=\"0\" private=\"1\">\n");
				indent++;
				write_indent ();
				buffer.append_printf ("<type name=\"%sPrivate\" c:type=\"%sPrivate*\"/>\n", get_gir_name (cl), get_ccode_name (cl));
				indent--;
				write_indent ();
				buffer.append_printf("</field>\n");
			}

			indent--;
			write_indent ();
			buffer.append_printf ("</class>\n");

			write_indent ();
			buffer.append_printf ("<record name=\"%s\"", gtype_struct_name);
			write_ctype_attributes (cl, "Class");
			buffer.append_printf (" glib:is-gtype-struct-for=\"%s\"", get_gir_name (cl));
			buffer.append_printf (">\n");
			indent++;

			write_indent ();
			buffer.append_printf ("<field name=\"parent_class\" readable=\"0\" private=\"1\">\n");
			indent++;
			write_indent ();
			if (cl.base_class == null) {
				//FIXME GObject.TypeClass vs GType
				buffer.append_printf ("<type name=\"%sClass\" c:type=\"%sClass\"/>\n", "GObject.Type", get_ccode_name (gtype_type));
			} else {
				buffer.append_printf ("<type name=\"%sClass\" c:type=\"%sClass\"/>\n", gi_type_name (cl.base_class), get_ccode_name (cl.base_class));
			}
			indent--;
			write_indent ();
			buffer.append_printf ("</field>\n");

			foreach (Method m in cl.get_methods ()) {
				if (m.is_abstract || m.is_virtual) {
					if (m.coroutine) {
						string finish_name = m.name;
						if (finish_name.has_suffix ("_async")) {
							finish_name = finish_name.substring (0, finish_name.length - "_async".length);
						}
						finish_name += "_finish";

						write_indent ();
						buffer.append_printf("<field name=\"%s\"", m.name);
						write_symbol_attributes (m);
						buffer.append_printf (">\n");
						indent++;
						do_write_signature (m, "callback", true, m.name, get_ccode_name (m), m.get_async_begin_parameters (), new VoidType (), false, false, false);
						indent--;
						write_indent ();
						buffer.append_printf ("</field>\n");

						write_indent ();
						buffer.append_printf("<field name=\"%s\"", finish_name);
						write_symbol_attributes (m);
						buffer.append_printf (">\n");
						indent++;
						do_write_signature (m, "callback", true, finish_name, get_ccode_finish_name (m), m.get_async_end_parameters (), m.return_type, m.tree_can_fail, false, false);
						indent--;
						write_indent ();
						buffer.append_printf ("</field>\n");
					} else {
						write_indent ();
						buffer.append_printf("<field name=\"%s\"", m.name);
						write_symbol_attributes (m);
						buffer.append_printf (">\n");
						indent++;
						do_write_signature (m, "callback", true, m.name, get_ccode_name (m), m.get_parameters (), m.return_type, m.tree_can_fail, false, false);
						indent--;
						write_indent ();
						buffer.append_printf ("</field>\n");
					}
				}
			}

			foreach (Signal sig in cl.get_signals ()) {
				if (sig.default_handler != null) {
					write_indent ();
					buffer.append_printf ("<field name=\"%s\"", get_ccode_lower_case_name (sig));
					write_symbol_attributes (sig);
					buffer.append_printf (">\n");
					indent++;
					write_signature (sig.default_handler, "callback", false, true, false);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				}
			}

			indent--;
			write_indent ();
			buffer.append_printf ("</record>\n");

			write_indent ();
			buffer.append_printf ("<record name=\"%sPrivate\" c:type=\"%sPrivate\" disguised=\"1\"/>\n", get_gir_name (cl), get_ccode_name (cl));
		} else {
			write_indent ();
			buffer.append_printf ("<record name=\"%s\"", get_gir_name (cl));
			write_ctype_attributes (cl);
			write_symbol_attributes (cl);
			buffer.append_printf (">\n");
			indent++;

			write_doc (get_class_comment (cl), cl.comment);

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

		if (!has_namespace (st)) {
			return;
		}

		if (!(hierarchy[0] is Namespace)) {
			deferred.add (st);
			return;
		}

		write_indent ();
		buffer.append_printf ("<record name=\"%s\"", get_gir_name (st));
		if (get_ccode_has_type_id (st)) {
			write_gtype_attributes (st, true);
		} else {
			write_ctype_attributes (st, "", true);
		}
		write_symbol_attributes (st);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_struct_comment (st), st.comment);

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

		if (!has_namespace (iface)) {
			return;
		}

		if (!(hierarchy[0] is Namespace)) {
			deferred.add (iface);
			return;
		}

		string gtype_struct_name = get_gir_name (iface) + "Iface";

		write_indent ();
		buffer.append_printf ("<interface name=\"%s\"", get_gir_name (iface));
		write_gtype_attributes (iface, true);
		buffer.append_printf (" glib:type-struct=\"%s\"", gtype_struct_name);
		write_symbol_attributes (iface);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_interface_comment (iface), iface.comment);

		// write prerequisites
		if (iface.get_prerequisites ().size > 0) {
			foreach (DataType base_type in iface.get_prerequisites ()) {
				write_indent ();
				buffer.append_printf ("<prerequisite name=\"%s\"/>\n", gi_type_name (((ObjectType) base_type).type_symbol));
			}
		}

		hierarchy.insert (0, iface);
		iface.accept_children (this);
		hierarchy.remove_at (0);

		indent--;
		write_indent ();
		buffer.append_printf ("</interface>\n");

		write_indent ();
		buffer.append_printf ("<record name=\"%s\"", gtype_struct_name);
		write_ctype_attributes (iface, "Iface");
		buffer.append_printf (" glib:is-gtype-struct-for=\"%s\"", get_gir_name (iface));
		buffer.append_printf (">\n");
		indent++;

		write_indent ();
		buffer.append_printf ("<field name=\"parent_iface\" readable=\"0\" private=\"1\">\n");
		indent++;
		write_indent ();
		buffer.append_printf ("<type name=\"%s\" c:type=\"%s\"/>\n", gi_type_name (gtypeinterface_type), get_ccode_name (gtypeinterface_type));
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
					buffer.append_printf("<field name=\"%s\"", m.name);
					write_symbol_attributes (m);
					buffer.append_printf (">\n");
					indent++;
					do_write_signature (m, "callback", true, m.name, get_ccode_name (m), m.get_async_begin_parameters (), new VoidType (), false, false, false);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");

					write_indent ();
					buffer.append_printf("<field name=\"%s\"", finish_name);
					write_symbol_attributes (m);
					buffer.append_printf (">\n");
					indent++;
					do_write_signature (m, "callback", true, finish_name, get_ccode_finish_name (m), m.get_async_end_parameters (), m.return_type, m.tree_can_fail, false, false);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				} else {
					write_indent ();
					buffer.append_printf("<field name=\"%s\"", m.name);
					write_symbol_attributes (m);
					buffer.append_printf (">\n");
					indent++;
					do_write_signature (m, "callback", true, m.name, get_ccode_name (m), m.get_parameters (), m.return_type, m.tree_can_fail, false, false);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				}
			}
		}

		foreach (var prop in iface.get_properties ()) {
			if (prop.is_abstract || prop.is_virtual) {
				if (prop.get_accessor != null && prop.get_accessor.readable) {
					var m = prop.get_accessor.get_method ();
					write_indent ();
					buffer.append_printf("<field name=\"%s\"", m.name);
					write_symbol_attributes (m);
					buffer.append_printf (">\n");
					indent++;
					do_write_signature (m, "callback", true, m.name, get_ccode_name (m), m.get_parameters (), m.return_type, m.tree_can_fail, false, false);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				}

				if (prop.set_accessor != null && prop.set_accessor.writable) {
					var m = prop.set_accessor.get_method ();
					write_indent ();
					buffer.append_printf("<field name=\"%s\"", m.name);
					write_symbol_attributes (m);
					buffer.append_printf (">\n");
					indent++;
					do_write_signature (m, "callback", true, m.name, get_ccode_name (m), m.get_parameters (), m.return_type, m.tree_can_fail, false, false);
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

		if (!has_namespace (en)) {
			return;
		}

		if (!(hierarchy[0] is Namespace)) {
			deferred.add (en);
			return;
		}

		string element_name = (en.is_flags) ? "bitfield" : "enumeration";

		write_indent ();
		buffer.append_printf ("<%s name=\"%s\"", element_name, get_gir_name (en));
		if (get_ccode_has_type_id (en)) {
			write_gtype_attributes (en);
		} else {
			write_ctype_attributes (en);
		}
		write_symbol_attributes (en);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_enum_comment (en), en.comment);

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
		buffer.append_printf ("<member name=\"%s\" c:identifier=\"%s\"", ev.name.ascii_down (), get_ccode_name (ev));
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

			write_doc (comment, ev.comment);

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

		if (!has_namespace (edomain)) {
			return;
		}

		write_indent ();
		buffer.append_printf ("<enumeration name=\"%s\"", get_gir_name (edomain));
		if (get_ccode_has_type_id (edomain)) {
			write_gtype_attributes (edomain);
		} else {
			write_ctype_attributes (edomain);
		}
		buffer.append_printf (" glib:error-domain=\"%s\"", get_ccode_quark_name (edomain));
		write_symbol_attributes (edomain);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_error_domain_comment (edomain), edomain.comment);

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
		buffer.append_printf ("<member name=\"%s\" c:identifier=\"%s\"", ecode.name.ascii_down (), get_ccode_name (ecode));
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

			write_doc (comment, ecode.comment);

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

		if (!has_namespace (c)) {
			return;
		}

		//TODO Add better constant evaluation
		var initializer = c.value;
		string value = literal_expression_to_value_string (initializer);

		write_indent ();
		buffer.append_printf ("<constant name=\"%s\" c:identifier=\"%s\"", get_gir_name (c), get_ccode_name (c));
		buffer.append_printf (" value=\"%s\"", value);
		write_symbol_attributes (c);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_constant_comment (c), c.comment);

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

		if (!has_namespace (f)) {
			return;
		}

		write_indent ();
		buffer.append_printf ("<field name=\"%s\" writable=\"1\"", get_ccode_name (f));
		if (f.variable_type.nullable) {
			buffer.append_printf (" nullable=\"1\"");
		}
		write_symbol_attributes (f);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_field_comment (f), f.comment);

		write_type (f.variable_type);

		indent--;
		write_indent ();
		buffer.append_printf ("</field>\n");

		if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
			var array_type = (ArrayType) f.variable_type;
			if (!array_type.fixed_length) {
				for (var i = 0; i < array_type.rank; i++) {
					write_indent ();
					buffer.append_printf ("<field name=\"%s_length%i\"", get_ccode_name (f), i + 1);
					write_symbol_attributes (f);
					buffer.append_printf (">\n");
					indent++;
					write_type (array_type.length_type);
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				}
			}
		} else if (f.variable_type is DelegateType) {
			var deleg_type = (DelegateType) f.variable_type;
			if (deleg_type.delegate_symbol.has_target) {
				write_indent ();
				buffer.append_printf ("<field name=\"%s\"", get_ccode_delegate_target_name (f));
				write_symbol_attributes (f);
				buffer.append_printf (">\n");
				indent++;
				write_indent ();
				buffer.append_printf ("<type name=\"gpointer\" c:type=\"gpointer\"/>\n");
				indent--;
				write_indent ();
				buffer.append_printf ("</field>\n");
				if (deleg_type.is_disposable ()) {
					write_indent ();
					buffer.append_printf ("<field name=\"%s\"", get_ccode_delegate_target_destroy_notify_name (f));
					write_symbol_attributes (f);
					buffer.append_printf (">\n");
					indent++;
					write_indent ();
					buffer.append_printf ("<type name=\"GLib.DestroyNotify\" c:type=\"GDestroyNotify\"/>\n");
					indent--;
					write_indent ();
					buffer.append_printf ("</field>\n");
				}
			}
		}
	}

	private void write_implicit_params (DataType? type, ref int index, bool has_array_length, string? name, ParameterDirection direction) {
		if (type is ArrayType && has_array_length) {
			for (var i = 0; i < ((ArrayType) type).rank; i++) {
				write_param_or_return (((ArrayType) type).length_type, "parameter", ref index, has_array_length, "%s_length%i".printf (name, i + 1), null, null, direction);
			}
		} else if (type is DelegateType) {
			var deleg_type = (DelegateType) type;
			if (deleg_type.delegate_symbol.has_target) {
				var data_type = new PointerType (new VoidType ());
				write_param_or_return (data_type, "parameter", ref index, false, "%s_target".printf (name), null, null, direction);
				if (deleg_type.is_disposable ()) {
					var notify_type = new DelegateType (context.root.scope.lookup ("GLib").scope.lookup ("DestroyNotify") as Delegate);
					write_param_or_return (notify_type, "parameter", ref index, false, "%s_target_destroy_notify".printf (name), null, null, direction);
				}
			}
		}
	}

	void skip_implicit_params (DataType? type, ref int index, bool has_array_length) {
		if (type is ArrayType && has_array_length) {
			index += ((ArrayType) type).rank;
		} else if (type is DelegateType) {
			index++;
			var deleg_type = (DelegateType) type;
			if (deleg_type.is_disposable ()) {
				index++;
			}
		}
	}

	private void write_type_parameter (TypeParameter type_parameter, string tag_type) {
		write_indent ();
		if (tag_type == "property") {
			buffer.append_printf ("<%s name=\"%s\" writable=\"1\" construct-only=\"1\">\n", tag_type, get_ccode_type_id (type_parameter).replace ("_", "-"));
		} else {
			buffer.append_printf ("<%s name=\"%s\" transfer-ownership=\"none\">\n", tag_type, get_ccode_type_id (type_parameter));
		}
		indent++;
		write_indent ();
		buffer.append_printf ("<type name=\"GType\" c:type=\"GType\"/>\n");
		indent--;
		write_indent ();
		buffer.append_printf ("</%s>\n", tag_type);
		write_indent ();
		if (tag_type == "property") {
			buffer.append_printf ("<%s name=\"%s\" writable=\"1\" construct-only=\"1\">\n", tag_type, get_ccode_copy_function (type_parameter).replace ("_", "-"));
		} else {
			buffer.append_printf ("<%s name=\"%s\" transfer-ownership=\"none\">\n", tag_type, get_ccode_copy_function (type_parameter));
		}
		indent++;
		write_indent ();
		buffer.append_printf ("<type name=\"GObject.BoxedCopyFunc\" c:type=\"GBoxedCopyFunc\"/>\n");
		indent--;
		write_indent ();
		buffer.append_printf ("</%s>\n", tag_type);
		write_indent ();
		if (tag_type == "property") {
			buffer.append_printf ("<%s name=\"%s\" writable=\"1\" construct-only=\"1\">\n", tag_type, get_ccode_destroy_function (type_parameter).replace ("_", "-"));
		} else {
			buffer.append_printf ("<%s name=\"%s\" transfer-ownership=\"none\">\n", tag_type, get_ccode_destroy_function (type_parameter));
		}
		indent++;
		write_indent ();
		buffer.append_printf ("<type name=\"GLib.DestroyNotify\" c:type=\"GDestroyNotify\"/>\n");
		indent--;
		write_indent ();
		buffer.append_printf ("</%s>\n", tag_type);
	}

	private void write_params_and_return (Callable symbol, string tag_name, List<Parameter> params, List<TypeParameter>? type_params, DataType? return_type, bool return_array_length, string? return_comment = null, bool constructor = false, Parameter? instance_param = null, bool user_data = false) {
		int last_index = 0;
		bool ret_is_struct = return_type != null && return_type.is_real_non_null_struct_type ();

		if (params.size != 0 || (return_type is ArrayType && return_array_length) || (return_type is DelegateType) || ret_is_struct) {
			int index = 0;

			foreach (Parameter param in params) {
				index++;

				skip_implicit_params (param.variable_type, ref index, get_ccode_array_length (param));
			}

			if (ret_is_struct) {
				index++;
			} else {
				skip_implicit_params (return_type, ref index, return_array_length);
				if (return_type is ArrayType && return_array_length) {
					index -= ((ArrayType) return_type).rank - 1;
				}
			}

			last_index = index - 1;
		}

		if (return_type != null && !ret_is_struct) {
			write_param_or_return (return_type, "return-value", ref last_index, return_array_length, null, symbol.comment, return_comment, ParameterDirection.IN, constructor);
		} else if (ret_is_struct) {
			write_param_or_return (new VoidType (), "return-value", ref last_index, false, null, symbol.comment, return_comment, ParameterDirection.IN);
		}

		if (params.size != 0 || (type_params != null && type_params.size > 0) || instance_param != null || (return_type is ArrayType && return_array_length) || (return_type is DelegateType) || ret_is_struct) {
			write_indent ();
			buffer.append_printf ("<parameters>\n");
			indent++;
			int index = 0;

			if (instance_param != null) {
				var type = instance_param.variable_type.copy ();
				unowned Struct? st = type.type_symbol as Struct;
				if (st != null && !st.is_simple_type ()) {
					type.nullable = true;
				}
				int skip = 0;
				if (tag_name == "function" || tag_name == "callback") {
					write_param_or_return (type, "parameter", ref skip, false, "self");
					index++;
				} else {
					write_param_or_return (type, "instance-parameter", ref skip, false, "self");
				}
			}

			if (constructor && ret_is_struct) {
				// struct constructor has a caller-allocates / out-parameter as instance
				write_param_or_return (return_type, "instance-parameter", ref index, false, "self", symbol.comment, return_comment, ParameterDirection.OUT, constructor, true);
			}

			if (type_params != null) {
				foreach (var p in type_params) {
					write_type_parameter (p, "parameter");
					index += 3;
				}
			}

			foreach (Parameter param in params) {
				write_param_or_return (param.variable_type, "parameter", ref index, get_ccode_array_length (param), get_ccode_name (param), param.parent_symbol.comment, get_parameter_comment (param), param.direction, false, false, param.ellipsis || param.params_array);

				write_implicit_params (param.variable_type, ref index, get_ccode_array_length (param), get_ccode_name (param), param.direction);
			}

			if (!constructor && ret_is_struct) {
				// struct returns are converted to parameters
				write_param_or_return (return_type, "parameter", ref index, false, "result", symbol.comment, return_comment, ParameterDirection.OUT, constructor, true);
			} else if (!constructor) {
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

		if (!has_namespace (cb)) {
			return;
		}

		write_indent ();
		buffer.append_printf ("<callback name=\"%s\"", get_gir_name (cb));
		buffer.append_printf (" c:type=\"%s\"", get_ccode_name (cb));
		if (cb.tree_can_fail) {
			buffer.append_printf (" throws=\"1\"");
		}
		write_symbol_attributes (cb);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_delegate_comment (cb), cb.comment);

		write_params_and_return (cb, "callback", cb.get_parameters (), cb.get_type_parameters (), cb.return_type, get_ccode_array_length (cb), get_delegate_return_comment (cb), false, null, cb.has_target);

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

		if (!has_namespace (m)) {
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

		if (!get_ccode_no_wrapper (m) && m.signal_reference == null) {
			write_signature (m, tag_name, true);
		}

		if (m.is_abstract || m.is_virtual) {
			write_signature (m, "virtual-method", true, false);
		}
	}

	bool is_type_introspectable (DataType type) {
		// gobject-introspection does not currently support va_list parameters
		if (get_ccode_name (type) == "va_list") {
			return false;
		}

		return true;
	}

	bool is_method_introspectable (Method m) {
		if (!is_type_introspectable (m.return_type)) {
			return false;
		}
		foreach (var param in m.get_parameters ()) {
			if (param.ellipsis || param.params_array || !is_type_introspectable (param.variable_type)) {
				return false;
			}
		}
		return true;
	}

	bool is_introspectable (Symbol sym) {
		if (sym is Method && !is_method_introspectable ((Method) sym)) {
			return false;
		}

		return is_visibility (sym);
	}

	private void write_signature (Method m, string tag_name, bool write_doc, bool instance = false, bool write_attributes = true) {
		var parent = this.hierarchy.get (0);
		string name;
		if (m.parent_symbol != parent) {
			instance = false;
			name = get_ccode_name (m);
			var parent_prefix = get_ccode_lower_case_prefix (parent);
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
			do_write_signature (m, tag_name, instance, name, get_ccode_name (m), m.get_async_begin_parameters (), new VoidType (), false, true, write_attributes);
			do_write_signature (m, tag_name, instance, finish_name, get_ccode_finish_name (m), m.get_async_end_parameters (), m.return_type, m.tree_can_fail, false, write_attributes);
		} else {
			do_write_signature (m, tag_name, instance, name, get_ccode_name (m), m.get_parameters (), m.return_type, m.tree_can_fail, true, write_attributes);
		}
	}

	private void do_write_signature (Method m, string tag_name, bool instance, string name, string cname, List<Vala.Parameter> params, DataType return_type, bool can_fail, bool write_comment, bool write_attributes = true) {
		write_indent ();
		buffer.append_printf ("<%s name=\"%s\"", tag_name, name);
		if (tag_name == "virtual-method") {
			if (!get_ccode_no_wrapper (m)) {
				buffer.append_printf (" invoker=\"%s\"", name);
			}
		} else if (tag_name == "callback") {
			/* this is only used for vfuncs */
			buffer.append_printf (" c:type=\"%s\"", name);
		} else {
			buffer.append_printf (" c:identifier=\"%s\"", cname);
		}
		if (can_fail) {
			buffer.append_printf (" throws=\"1\"");
		}
		if (write_attributes) {
			write_symbol_attributes (m);
		}
		buffer.append_printf (">\n");
		indent++;

		string? return_comment = null;
		if (write_comment) {
			return_comment = get_method_return_comment (m);
			write_doc (get_method_comment (m), m.comment);
		}

		write_params_and_return (m, tag_name, params, m.get_type_parameters (), return_type, get_ccode_array_length (m), return_comment, false, m.this_parameter);

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
		string tag_name = is_struct ? "method" : "constructor";

		if (m.parent_symbol is Class && m == ((Class)m.parent_symbol).default_construction_method ||
			m.parent_symbol is Struct && m == ((Struct)m.parent_symbol).default_construction_method) {
			string m_name = is_struct ? "init" : "new";
			buffer.append_printf ("<%s name=\"%s\" c:identifier=\"%s\"", tag_name, m_name, get_ccode_name (m));
		} else if (is_struct) {
			buffer.append_printf ("<%s name=\"init_%s\" c:identifier=\"%s\"", tag_name, m.name, get_ccode_name (m));
		} else {
			buffer.append_printf ("<%s name=\"%s\" c:identifier=\"%s\"", tag_name, m.name, get_ccode_name (m));
		}

		if (m.tree_can_fail) {
			buffer.append_printf (" throws=\"1\"");
		}
		write_symbol_attributes (m);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_method_comment (m), m.comment);

		var datatype = SemanticAnalyzer.get_data_type_for_symbol (m.parent_symbol);
		List<TypeParameter>? type_params = null;
		if (m.parent_symbol is Class) {
			type_params = ((Class) m.parent_symbol).get_type_parameters ();
		}
		write_params_and_return (m, tag_name, m.get_parameters (), type_params, datatype, false, get_method_return_comment (m), true);

		indent--;
		write_indent ();
		buffer.append_printf ("</%s>\n", tag_name);
	}

	public override void visit_property (Property prop) {
		if (!check_accessibility (prop) || prop.overrides || (prop.base_interface_property != null && !prop.is_abstract && !prop.is_virtual)) {
			return;
		}

		if (context.analyzer.is_gobject_property (prop)) {
			write_indent ();
			buffer.append_printf ("<property name=\"%s\"", get_ccode_name (prop));
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
			if (prop.initializer != null && prop.initializer is Literal) {
				buffer.append_printf (" default-value=\"%s\"", literal_expression_to_value_string (prop.initializer));
			}
			write_symbol_attributes (prop);
			buffer.append_printf (">\n");
			indent++;

			write_doc (get_property_comment (prop), prop.comment);

			write_type (prop.property_type);

			indent--;
			write_indent ();
			buffer.append_printf ("</property>\n");
		}

		if (prop.get_accessor != null && prop.get_accessor.readable) {
			var m = prop.get_accessor.get_method ();
			if (m != null) {
				visit_method (m);
			}
		}

		if (prop.set_accessor != null && prop.set_accessor.writable) {
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

		if (sig.emitter != null) {
			sig.emitter.accept (this);
		}

		if (sig.default_handler != null) {
			sig.default_handler.accept (this);
		}

		write_indent ();
		buffer.append_printf ("<glib:signal name=\"%s\"", get_ccode_name (sig));
		write_symbol_attributes (sig);
		buffer.append_printf (">\n");
		indent++;

		write_doc (get_signal_comment (sig), sig.comment);

		write_params_and_return (sig, "glib:signal", sig.get_parameters (), null, sig.return_type, false, get_signal_return_comment (sig));

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


	private void write_param_or_return (DataType? type, string tag, ref int index, bool has_array_length, string? name = null, Comment? parent_comment = null, string? comment = null, ParameterDirection direction = ParameterDirection.IN, bool constructor = false, bool caller_allocates = false, bool ellipsis = false) {
		write_indent ();
		buffer.append_printf ("<%s", tag);
		if (ellipsis) {
			name = "...";
		}
		if (name != null) {
			buffer.append_printf (" name=\"%s\"", name);
		}
		if (direction == ParameterDirection.REF) {
			buffer.append_printf (" direction=\"inout\"");
		} else if (direction == ParameterDirection.OUT) {
			buffer.append_printf (" direction=\"out\"");
		}

		unowned DelegateType? delegate_type = type as DelegateType;
		unowned ArrayType? array_type = type as ArrayType;

		if (type != null && ((type.value_owned && delegate_type == null) || (constructor
		    && !(type.type_symbol is Struct || type.type_symbol.is_subtype_of (ginitiallyunowned_type))))) {
			var any_owned = false;
			foreach (var generic_arg in type.get_type_arguments ()) {
				any_owned |= generic_arg.value_owned;
			}
			if (type.has_type_arguments () && !any_owned) {
				buffer.append_printf (" transfer-ownership=\"container\"");
			} else if (array_type != null && !array_type.element_type.value_owned) {
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
		if (type != null && type.nullable) {
			if (tag == "parameter"
			    && (direction == ParameterDirection.OUT || direction == ParameterDirection.REF)) {
				buffer.append_printf (" optional=\"1\"");
			} else {
				buffer.append_printf (" nullable=\"1\"");
			}
		}

		if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
			int closure_index = tag == "parameter" ?
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

		write_doc (comment, parent_comment);

		if (ellipsis) {
			write_indent ();
			buffer.append ("<varargs/>\n");
		} else if (type != null) {
			int length_param_index = -1;
			if (has_array_length) {
				length_param_index = tag == "parameter" ? index + 1 : index;
			}

			bool additional_indirection = direction != ParameterDirection.IN;
			if (!additional_indirection && tag == "parameter" && !type.nullable) {
				// pass non-simple structs always by reference
				unowned Struct? st = type.type_symbol as Struct;
				if (st != null && !st.is_simple_type ()) {
					additional_indirection = true;
				}
			}

			write_type (type, length_param_index, additional_indirection);
		}

		indent--;
		write_indent ();
		buffer.append_printf ("</%s>\n", tag);
		index++;
	}

	private void write_ctype_attributes (TypeSymbol symbol, string suffix = "", bool symbol_prefix = false) {
		buffer.append_printf (" c:type=\"%s%s\"", get_ccode_name (symbol), suffix);
		if (symbol_prefix) {
			buffer.append_printf (" c:symbol-prefix=\"%s\"", get_ccode_lower_case_suffix (symbol));
		}
	}

	private void write_gtype_attributes (TypeSymbol symbol, bool symbol_prefix = false) {
		write_ctype_attributes(symbol, "", symbol_prefix);
		buffer.append_printf (" glib:type-name=\"%s\"", get_ccode_name (symbol));
		buffer.append_printf (" glib:get-type=\"%sget_type\"", get_ccode_lower_case_prefix (symbol));
	}

	private void write_type (DataType type, int index = -1, bool additional_indirection = false) {
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
			buffer.append_printf (" c:type=\"%s%s\"", get_ccode_name (array_type.element_type), !additional_indirection ? "*" : "**");
			buffer.append_printf (">\n");
			indent++;

			write_type (array_type.element_type);

			indent--;
			write_indent ();
			buffer.append_printf ("</array>\n");
		} else if (type is VoidType) {
			write_indent ();
			buffer.append_printf ("<type name=\"none\" c:type=\"void\"/>\n");
		} else if (type is PointerType) {
			write_indent ();
			buffer.append_printf ("<type name=\"gpointer\" c:type=\"%s%s\"/>\n", get_ccode_name (type), !additional_indirection ? "" : "*");
		} else if (type is GenericType) {
			// generic type parameters not supported in GIR
			write_indent ();
			buffer.append ("<type name=\"gpointer\" c:type=\"gpointer\"/>\n");
		} else if (type is DelegateType) {
			var deleg_type = (DelegateType) type;
			write_indent ();
			buffer.append_printf ("<type name=\"%s\" c:type=\"%s%s\"/>\n", gi_type_name (deleg_type.delegate_symbol), get_ccode_name (type), !additional_indirection ? "" : "*");
		} else if (type.type_symbol != null) {
			write_indent ();
			string type_name = gi_type_name (type.type_symbol);
			bool is_array = false;
			if ((type_name == "GLib.Array") || (type_name == "GLib.PtrArray")) {
				is_array = true;
			}
			buffer.append_printf ("<%s name=\"%s\" c:type=\"%s%s\"", is_array ? "array" : "type", gi_type_name (type.type_symbol), get_ccode_name (type), !additional_indirection ? "" : "*");

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
		} else {
			write_indent ();
			buffer.append_printf ("<type name=\"%s\"/>\n", type.to_string ());
		}
	}

	private string? get_full_gir_name (Symbol sym) {
		string? gir_fullname = sym.get_attribute_string ("GIR", "fullname");
		if (gir_fullname != null) {
			return gir_fullname;
		}

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
				unowned SourceFile source_file = type_symbol.source_reference.file;
				if (source_file.gir_namespace != null) {
					GIRNamespace external;
					if (source_file.gir_ambiguous) {
						external = GIRNamespace.for_symbol (type_symbol);
					} else {
						external = GIRNamespace (source_file.gir_namespace, source_file.gir_version);
					}
					if (!externals.contains (external)) {
						externals.add (external);
					}
					string? gir_fullname = type_symbol.get_attribute_string ("GIR", "fullname");
					if (gir_fullname != null) {
						return gir_fullname;
					}
					var type_name = type_symbol.get_attribute_string ("GIR", "name") ?? type_symbol.name;
					return "%s.%s".printf (external.ns, type_name);
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

	private bool check_accessibility (Symbol sym) {
		if (sym.access == SymbolAccessibility.PUBLIC ||
		    sym.access == SymbolAccessibility.PROTECTED) {
			return true;
		}

		// internal fields and function pointers in classes/interfaces are public API
		if (sym.access == SymbolAccessibility.INTERNAL) {
			unowned Symbol? parent = sym.parent_symbol;
			if (parent != null
			    && (parent is Class || parent is Interface)
			    && ((sym is Field && ((Field) sym).binding == MemberBinding.INSTANCE)
			    || (sym is Method && ((Method) sym).binding == MemberBinding.INSTANCE && (((Method) sym).is_abstract || ((Method) sym).is_virtual)))) {
				return true;
			}
		}

		return false;
	}

	private bool is_visibility (Symbol sym) {
		return sym.get_attribute_bool ("GIR", "visible", true);
	}

	bool has_namespace (Symbol sym) {
		if (!(sym.parent_symbol is Namespace) || sym.parent_symbol.name != null) {
			return true;
		}

		Report.warning (sym.source_reference, "`%s' must be part of namespace to be included in GIR", sym.name);
		return false;
	}
}
