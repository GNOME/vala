/* valagirwriter.vala
 *
 * Copyright (C) 2008-2009  Jürg Billeter
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
using Gee;

/**
 * Code visitor generating .gir file for the public interface.
 */
public class Vala.GIRWriter : CodeVisitor {
	private CodeContext context;
	
	FileStream stream;
	
	int indent;

	private TypeSymbol gobject_type;

	/**
	 * Writes the public interface of the specified code context into the
	 * specified file.
	 *
	 * @param context  a code context
	 * @param filename a relative or absolute filename
	 */
	public void write_file (CodeContext context, string filename) {
		this.context = context;

		var root_symbol = context.root;
		var glib_ns = root_symbol.scope.lookup ("GLib");
		gobject_type = (TypeSymbol) glib_ns.scope.lookup ("Object");

		stream = FileStream.open (filename, "w");

		stream.printf ("<?xml version=\"1.0\"?>\n");

		stream.printf ("<repository version=\"1.0\"");
		stream.printf (" xmlns=\"http://www.gtk.org/introspection/core/1.0\"");
		stream.printf (" xmlns:c=\"http://www.gtk.org/introspection/c/1.0\"");
		stream.printf (" xmlns:glib=\"http://www.gtk.org/introspection/glib/1.0\"");
		stream.printf (">\n");
		indent++;

		context.accept (this);

		indent--;
		stream.printf ("</repository>\n");

		stream = null;
	}

	private void write_c_includes (Namespace ns) {
		// Collect C header filenames
		Gee.Set<string> header_filenames = new Gee.HashSet<string> (str_hash, str_equal);
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
		stream.printf ("<c:include name=\"%s\"/>\n", name);
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
		stream.printf ("<namespace name=\"%s\" version=\"1.0\">\n", ns.name);
		indent++;

		write_annotations (ns);

		ns.accept_children (this);

		indent--;
		write_indent ();
		stream.printf ("</namespace>\n");
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
			stream.printf ("<class name=\"%s\"", cl.name);
			write_gtype_attributes (cl);
			stream.printf (" glib:type-struct=\"%s\"", gtype_struct_name);
			stream.printf (" parent=\"%s\"", cl.base_class.get_full_name ());
			if (cl.is_abstract) {
				stream.printf (" abstract=\"1\"");
			}
			stream.printf (">\n");
			indent++;

			// write implemented interfaces
			bool first = true;
			foreach (DataType base_type in cl.get_base_types ()) {
				var object_type = (ObjectType) base_type;
				if (object_type.type_symbol is Interface) {
					if (first) {
						write_indent ();
						stream.printf ("<implements>\n");
						indent++;
						first = false;
					}
					write_indent ();
					stream.printf ("<interface name=\"%s\"/>\n", object_type.type_symbol.get_full_name ());
				}
			}
			if (!first) {
				indent--;
				write_indent ();
				stream.printf ("</implements>\n");
			}

			write_annotations (cl);

			cl.accept_children (this);

			indent--;
			write_indent ();
			stream.printf ("</class>\n");

			write_indent ();
			stream.printf ("<record name=\"%s\"", gtype_struct_name);
			write_ctype_attributes (cl, "Class");
			stream.printf (" glib:is-gtype-struct-for=\"%s\"", cl.name);
			stream.printf (">\n");
			indent++;

			foreach (Method m in cl.get_methods ()) {
				if (m.is_abstract || m.is_virtual) {
					write_signature(m, "callback", true);
				}
			}

			indent--;
			write_indent ();
			stream.printf ("</record>\n");
		} else {
			write_indent ();
			stream.printf ("<record name=\"%s\"", cl.name);
			stream.printf (">\n");
			indent++;

			write_annotations (cl);

			cl.accept_children (this);

			indent--;
			write_indent ();
			stream.printf ("</record>\n");
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
		stream.printf ("<record name=\"%s\"", st.name);
		stream.printf (">\n");
		indent++;

		write_annotations (st);

		st.accept_children (this);

		indent--;
		write_indent ();
		stream.printf ("</record>\n");
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
		stream.printf ("<interface name=\"%s\"", iface.name);
		write_gtype_attributes (iface);
		stream.printf (" glib:type-struct=\"%s\"", gtype_struct_name);
		stream.printf (">\n");
		indent++;

		// write prerequisites
		if (iface.get_prerequisites ().size > 0) {
			write_indent ();
			stream.printf ("<requires>\n");
			indent++;

			foreach (DataType base_type in iface.get_prerequisites ()) {
				var object_type = (ObjectType) base_type;
				if (object_type.type_symbol is Class) {
					write_indent ();
					stream.printf ("<object name=\"%s\"/>\n", object_type.type_symbol.get_full_name ());
				} else if (object_type.type_symbol is Interface) {
					write_indent ();
					stream.printf ("<interface name=\"%s\"/>\n", object_type.type_symbol.get_full_name ());
				} else {
					assert_not_reached ();
				}
			}

			indent--;
			write_indent ();
			stream.printf ("</requires>\n");
		}

		write_annotations (iface);

		iface.accept_children (this);

		indent--;
		write_indent ();
		stream.printf ("</interface>\n");

		write_indent ();
		stream.printf ("<record name=\"%s\"", gtype_struct_name);
		write_ctype_attributes (iface, "Iface");
		stream.printf (" glib:is-gtype-struct-for=\"%s\"", iface.name);
		stream.printf (">\n");
		indent++;

		foreach (Method m in iface.get_methods ()) {
			if (m.is_abstract || m.is_virtual) {
				write_signature(m, "callback", true);
			}
		}

		indent--;
		write_indent ();
		stream.printf ("</record>\n");
	}

	public override void visit_enum (Enum en) {
		if (en.external_package) {
			return;
		}

		if (!check_accessibility (en)) {
			return;
		}

		write_indent ();
		stream.printf ("<enumeration name=\"%s\"", en.name);
		write_gtype_attributes (en);
		stream.printf (">\n");
		indent++;

		write_annotations (en);

		enum_value = 0;
		en.accept_children (this);

		indent--;
		write_indent ();
		stream.printf ("</enumeration>\n");
	}

	private int enum_value;

	public override void visit_enum_value (EnumValue ev) {
		write_indent ();
		stream.printf ("<member name=\"%s\" c:identifier=\"%s\"", ev.name.down (), ev.get_cname ());
		if (ev.value != null) {
			string value = literal_expression_to_value_string (ev.value);
			stream.printf (" value=\"%s\"", value);
		} else {
			stream.printf (" value=\"%d\"", enum_value++);
		}
		stream.printf ("/>\n");
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		if (edomain.external_package) {
			return;
		}

		if (!check_accessibility (edomain)) {
			return;
		}

		write_indent ();
		stream.printf ("<errordomain name=\"%s\"", edomain.name);
		stream.printf (" get-quark=\"%squark\"", edomain.get_lower_case_cprefix ());
		stream.printf (" codes=\"%s\"", edomain.name);
		stream.printf (">\n");

		write_annotations (edomain);

		stream.printf ("</errordomain>\n");

		write_indent ();
		stream.printf ("<enumeration name=\"%s\"", edomain.name);
		write_ctype_attributes (edomain);
		stream.printf (">\n");
		indent++;

		enum_value = 0;
		edomain.accept_children (this);

		indent--;
		write_indent ();
		stream.printf ("</enumeration>\n");
	}

	public override void visit_error_code (ErrorCode ecode) {
		write_indent ();
		stream.printf ("<member name=\"%s\" c:identifier=\"%s\"", ecode.name.down (), ecode.get_cname ());
		if (ecode.value != null) {
			string value = literal_expression_to_value_string (ecode.value);
			stream.printf (" value=\"%s\"", value);
		} else {
			stream.printf (" value=\"%d\"", enum_value++);
		}
		stream.printf ("/>\n");
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
		stream.printf ("<constant name=\"%s\" c:identifier=\"%s\"", c.name, c.get_cname ());
		stream.printf (" value=\"%s\"", value);
		stream.printf (">\n");
		indent++;

		write_type (initializer.value_type);

		indent--;
		write_indent ();
		stream.printf ("</constant>\n");
	}

	public override void visit_field (Field f) {
		if (f.external_package) {
			return;
		}

		if (!check_accessibility (f)) {
			return;
		}

		write_indent ();
		stream.printf ("<field name=\"%s\"", f.get_cname ());
		if (f.field_type.nullable) {
			stream.printf (" allow-none=\"1\"");
		}
		stream.printf (">\n");
		indent++;

		write_annotations (f);

		write_type (f.field_type);

		indent--;
		write_indent ();
		stream.printf ("</field>\n");
	}

	private void write_params (Gee.List<FormalParameter> params, DataType? instance_type = null) {
		if (params.size == 0 && instance_type == null) {
			return;
		}

		write_indent ();
		stream.printf ("<parameters>\n");
		indent++;

		if (instance_type != null) {
			write_indent ();
			stream.printf ("<parameter name=\"self\" transfer-ownership=\"none\">\n");
			indent++;

			write_type (instance_type);

			indent--;
			write_indent ();
			stream.printf ("</parameter>\n");
		}

		foreach (FormalParameter param in params) {
			write_indent ();
			stream.printf ("<parameter name=\"%s\"", param.name);
			if (param.direction == ParameterDirection.REF) {
				stream.printf (" direction=\"inout\"");
				// in/out paramter
				if (param.parameter_type.value_owned) {
					stream.printf (" transfer-ownership=\"full\"");
				} else {
					stream.printf (" transfer-ownership=\"none\"");
				}
			} else if (param.direction == ParameterDirection.OUT) {
				// out paramter
				stream.printf (" direction=\"out\"");
				if (param.parameter_type.value_owned) {
					stream.printf (" transfer-ownership=\"full\"");
				} else {
					stream.printf (" transfer-ownership=\"none\"");
				}
			} else {
				// normal in paramter
				if (param.parameter_type.value_owned) {
					stream.printf (" transfer-ownership=\"full\"");
				} else {
					stream.printf (" transfer-ownership=\"none\"");
				}
			}
			if (param.parameter_type.nullable) {
				stream.printf (" allow-none=\"1\"");
			}
			stream.printf (">\n");
			indent++;

			write_annotations (param);

			write_type (param.parameter_type);

			indent--;
			write_indent ();
			stream.printf ("</parameter>\n");
		}

		indent--;
		write_indent ();
		stream.printf ("</parameters>\n");
	}

	public override void visit_delegate (Delegate cb) {
		if (cb.external_package) {
			return;
		}

		if (!check_accessibility (cb)) {
			return;
		}

		write_indent ();
		stream.printf ("<callback name=\"%s\"", cb.name);
		stream.printf (" c:type=\"%s\"", cb.get_cname ());
		if (cb.tree_can_fail) {
			stream.printf (" throws=\"1\"");
		}
		stream.printf (">\n");
		indent++;

		write_annotations (cb);

		write_params (cb.get_parameters ());

		write_return_type (cb.return_type);

		indent--;
		write_indent ();
		stream.printf ("</callback>\n");
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
		write_indent ();
		stream.printf ("<%s name=\"%s\"", tag_name, m.name);
		if (tag_name == "virtual-method") {
			stream.printf (" invoker=\"%s\"", m.name);
		} else if (tag_name == "callback") {
			stream.printf (" c:type=\"%s\"", m.get_cname ());
		} else {
			stream.printf (" c:identifier=\"%s\"", m.get_cname ());
		}
		if (m.tree_can_fail) {
			stream.printf (" throws=\"1\"");
		}
		stream.printf (">\n");
		indent++;

		write_annotations (m);

		DataType instance_type = null;
		if (instance) {
			instance_type = CCodeBaseModule.get_data_type_for_symbol ((TypeSymbol) m.parent_symbol);
		}

		write_params (m.get_parameters (), instance_type);

		write_return_type (m.return_type);

		indent--;
		write_indent ();
		stream.printf ("</%s>\n", tag_name);
	}
	
	public override void visit_creation_method (CreationMethod m) {
		if (m.external_package) {
			return;
		}

		if (!check_accessibility (m)) {
			return;
		}

		write_indent ();
		stream.printf ("<constructor name=\"%s\" c:identifier=\"%s\"", m.name, m.get_cname ());
		if (m.tree_can_fail) {
			stream.printf (" throws=\"1\"");
		}
		stream.printf (">\n");
		indent++;

		write_annotations (m);

		write_params (m.get_parameters ());

		var datatype = CCodeBaseModule.get_data_type_for_symbol ((TypeSymbol) m.parent_symbol);
		write_return_type (datatype, true);

		indent--;
		write_indent ();
		stream.printf ("</constructor>\n");
	}

	public override void visit_property (Property prop) {
		if (!check_accessibility (prop) || prop.overrides || (prop.base_interface_property != null && !prop.is_abstract && !prop.is_virtual)) {
			return;
		}

		write_indent ();
		stream.printf ("<property name=\"%s\"", prop.get_canonical_name ());
		if (prop.get_accessor == null) {
			stream.printf (" readable=\"0\"");
		}
		if (prop.set_accessor != null) {
			stream.printf (" writable=\"1\"");
			if (prop.set_accessor.construction) {
				if (!prop.set_accessor.writable) {
					stream.printf (" construct-only=\"1\"");
				} else {
					stream.printf (" construct=\"1\"");
				}
			}
		}
		stream.printf (">\n");
		indent++;

		write_annotations (prop);

		write_type (prop.property_type);

		indent--;
		write_indent ();
		stream.printf ("</property>\n");
	}

	public override void visit_signal (Signal sig) {
		if (!check_accessibility (sig)) {
			return;
		}
		
		write_indent ();
		stream.printf ("<glib:signal name=\"%s\"", sig.get_cname ());
		stream.printf (">\n");
		indent++;

		write_annotations (sig);

		write_params (sig.get_parameters ());

		write_return_type (sig.return_type);

		indent--;
		write_indent ();
		stream.printf ("</glib:signal>\n");
	}

	private void write_indent () {
		int i;
		
		for (i = 0; i < indent; i++) {
			stream.putc ('\t');
		}
	}

	private void write_return_type (DataType type, bool constructor = false) {
		write_indent ();
		stream.printf ("<return-value");
		if (type.value_owned || constructor) {
			stream.printf (" transfer-ownership=\"full\"");
		} else {
			stream.printf (" transfer-ownership=\"none\"");
		}
		if (type.nullable) {
			stream.printf (" allow-none=\"1\"");
		}
		stream.printf (">\n");
		indent++;

		write_type (type);

		indent--;
		write_indent ();
		stream.printf ("</return-value>\n");
	}

	private void write_ctype_attributes (TypeSymbol symbol, string suffix = "") {
		stream.printf (" c:type=\"%s%s\"", symbol.get_cname (), suffix);
	}

	private void write_gtype_attributes (TypeSymbol symbol) {
		write_ctype_attributes(symbol);
		stream.printf (" glib:type-name=\"%s\"", symbol.get_cname ());
		stream.printf (" glib:get-type=\"%sget_type\"", symbol.get_lower_case_cprefix ());
	}

	private void write_type (DataType type) {
		if (type is ArrayType) {
			var array_type = (ArrayType) type;

			write_indent ();
			stream.printf ("<array>\n");
			indent++;

			write_type (array_type.element_type);

			indent--;
			write_indent ();
			stream.printf ("</array>\n");
		} else if (type is VoidType) {
			write_indent ();
			stream.printf ("<type name=\"none\"/>\n");
		} else if (type is PointerType) {
			write_indent ();
			stream.printf ("<type name=\"any\" c:type=\"%s\"/>\n", type.get_cname ());
		} else if (type.data_type != null) {
			write_indent ();
			stream.printf ("<type name=\"%s\" c:type=\"%s\"", gi_type_name (type.data_type), type.get_cname ());

			Gee.List<DataType> type_arguments = type.get_type_arguments ();
			if (type_arguments.size == 0) {
				stream.printf ("/>\n");
			} else {
				stream.printf (">\n");
				indent++;

				foreach (DataType type_argument in type_arguments) {
					write_type (type_argument);
				}

				indent--;
				write_indent ();
				stream.printf ("</type>\n");
			}
		} else {
			write_indent ();
			stream.printf ("<type name=\"%s\"/>\n", type.to_string ());
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
					stream.printf ("<annotation key=\"%s.%s\" value=\"%s\"/>\n",
						name, camel_case_to_canonical (arg_name), value);
				}
			}
		}
	}

	private string gi_type_name (TypeSymbol type_symbol) {
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

			if (type_name.str == "GLib.Object") {
				return "GObject.Object";
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
			return "%lc".printf (((CharacterLiteral) literal).get_char ());
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
		return Symbol.camel_case_to_lower_case (name).replace ("_", "-");
	}

	private bool check_accessibility (Symbol sym) {
		if (sym.access == SymbolAccessibility.PUBLIC ||
		    sym.access == SymbolAccessibility.PROTECTED) {
			return true;
		}

		return false;
	}
}
