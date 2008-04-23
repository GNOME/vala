/* valagidlwriter.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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
 * Code visitor generating .gidl file for the public interface.
 */
public class Vala.GIdlWriter : CodeVisitor {
	private CodeContext context;
	
	FileStream stream;
	
	int indent;

	private Typesymbol gobject_type;

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
		gobject_type = (Typesymbol) glib_ns.scope.lookup ("Object");

		stream = FileStream.open (filename, "w");

		stream.printf ("<?xml version=\"1.0\"?>\n");

		stream.printf ("<api version=\"1.0\">\n");

		context.accept (this);

		stream.printf ("</api>\n");

		stream = null;
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

		write_indent ();
		stream.printf ("<namespace name=\"%s\">\n", ns.name);
		indent++;

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
			write_indent ();
			stream.printf ("<object name=\"%s\"", cl.name);
			stream.printf (" parent=\"%s\"", cl.base_class.get_full_name ());
			stream.printf (" type-name=\"%s\"", cl.get_cname ());
			stream.printf (" get-type=\"%sget_type\"", cl.get_lower_case_cprefix ());
			stream.printf (">\n");
			indent++;

			// write implemented interfaces
			bool first = true;
			foreach (DataType base_type in cl.get_base_types ()) {
				var iface_type = base_type as InterfaceInstanceType;
				if (iface_type != null) {
					if (first) {
						write_indent ();
						stream.printf ("<implements>\n");
						indent++;
						first = false;
					}
					write_indent ();
					stream.printf ("<interface name=\"%s\"/>\n", iface_type.interface_symbol.get_full_name ());
				}
			}
			if (!first) {
				indent--;
				write_indent ();
				stream.printf ("</implements>\n");
			}

			cl.accept_children (this);

			indent--;
			write_indent ();
			stream.printf ("</object>\n");
		} else {
			write_indent ();
			stream.printf ("<struct name=\"%s\"", cl.name);
			stream.printf (">\n");
			indent++;

			cl.accept_children (this);

			indent--;
			write_indent ();
			stream.printf ("</struct>\n");
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
		stream.printf ("<struct name=\"%s\"", st.get_cname ());
		stream.printf (">\n");
		indent++;

		st.accept_children (this);

		indent--;
		write_indent ();
		stream.printf ("</struct>\n");
	}

	public override void visit_interface (Interface iface) {
		if (iface.external_package) {
			return;
		}

		if (!check_accessibility (iface)) {
			return;
		}

		write_indent ();
		stream.printf ("<interface name=\"%s\"", iface.get_cname ());
		stream.printf (" get-type=\"%sget_type\"", iface.get_lower_case_cprefix ());
		stream.printf (">\n");
		indent++;

		// write prerequisites
		if (iface.get_prerequisites ().size > 0) {
			write_indent ();
			stream.printf ("<requires>\n");
			indent++;

			foreach (DataType base_type in iface.get_prerequisites ()) {
				var class_type = base_type as ClassInstanceType;
				var iface_type = base_type as InterfaceInstanceType;
				if (class_type != null) {
					write_indent ();
					stream.printf ("<object name=\"%s\"/>\n", class_type.class_symbol.get_full_name ());
				} else if (iface_type != null) {
					write_indent ();
					stream.printf ("<interface name=\"%s\"/>\n", iface_type.interface_symbol.get_full_name ());
				} else {
					assert_not_reached ();
				}
			}

			indent--;
			write_indent ();
			stream.printf ("</requires>\n");
		}

		iface.accept_children (this);

		indent--;
		write_indent ();
		stream.printf ("</interface>\n");
	}

	public override void visit_enum (Enum en) {
		if (en.external_package) {
			return;
		}

		if (!check_accessibility (en)) {
			return;
		}

		write_indent ();
		stream.printf ("<enum name=\"%s\"", en.get_cname ());
		stream.printf (" get-type=\"%sget_type\"", en.get_lower_case_cprefix ());
		stream.printf (">\n");
		indent++;

		en.accept_children (this);

		indent--;
		write_indent ();
		stream.printf ("</enum>\n");
	}

	public override void visit_enum_value (EnumValue ev) {
		write_indent ();
		stream.printf ("<member name=\"%s\"/>\n", ev.get_cname ());
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		if (edomain.external_package) {
			return;
		}

		if (!check_accessibility (edomain)) {
			return;
		}

		write_indent ();
		stream.printf ("<errordomain name=\"%s\"", edomain.get_cname ());
		stream.printf (">\n");
		indent++;

		edomain.accept_children (this);

		indent--;
		write_indent ();
		stream.printf ("</errordomain>\n");
	}

	public override void visit_error_code (ErrorCode ecode) {
		write_indent ();
		stream.printf ("<member name=\"%s\"/>\n", ecode.get_cname ());
	}

	public override void visit_constant (Constant c) {
		if (c.external_package) {
			return;
		}

		if (!check_accessibility (c)) {
			return;
		}

		write_indent ();
		stream.printf ("<constant name=\"%s\"/>\n", c.get_cname ());
	}

	public override void visit_field (Field f) {
		if (f.external_package) {
			return;
		}

		if (!check_accessibility (f)) {
			return;
		}

		write_indent ();
		stream.printf ("<field name=\"%s\"/>\n", f.get_cname ());
	}

	private string get_gidl_type_name (DataType type) {
		// workaround to get GIDL-specific type name
		string gidl_type = type.get_cname ();
		if (type.data_type != null) {
			string cname = type.data_type.get_cname ();
			if (gidl_type.has_prefix (cname)) {
				gidl_type = type.data_type.get_full_name () + gidl_type.substring (cname.len (), gidl_type.len () - cname.len ());
			}
		} else if (type is DelegateType) {
			var dt = (DelegateType) type;
			string cname = dt.get_cname ();
			if (gidl_type.has_prefix (cname)) {
				gidl_type = dt.delegate_symbol.get_full_name () + gidl_type.substring (cname.len (), gidl_type.len () - cname.len ());
			}
		}
		return gidl_type;
	}

	private void write_params (Collection<FormalParameter> params, DataType? instance_type = null) {
		write_indent ();
		stream.printf ("<parameters>\n");
		indent++;

		if (instance_type != null) {
			write_indent ();
			stream.printf ("<parameter name=\"self\" type=\"%s\"/>\n", get_gidl_type_name (instance_type));
		}

		foreach (FormalParameter param in params) {
			write_indent ();
			stream.printf ("<parameter name=\"%s\" type=\"%s\"", param.name, get_gidl_type_name (param.type_reference));
			if (param.direction == ParameterDirection.REF) {
				stream.printf (" direction=\"inout\"");
				// in/out paramter
				if (param.type_reference.takes_ownership) {
					stream.printf (" transfer=\"full\"");
				}
			} else if (param.direction == ParameterDirection.OUT) {
				// out paramter
				stream.printf (" direction=\"out\"");
				if (param.type_reference.takes_ownership) {
					stream.printf (" transfer=\"full\"");
				}
			} else {
				// normal in paramter
				if (param.type_reference.transfers_ownership) {
					stream.printf (" transfer=\"full\"");
				}
			}
			stream.printf ("/>\n");
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
		stream.printf ("<callback name=\"%s\"", cb.get_cname ());
		stream.printf (">\n");
		indent++;

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

		write_indent ();
		stream.printf ("<method name=\"%s\" symbol=\"%s\"", m.name, m.get_cname ());
		stream.printf (">\n");
		indent++;

		DataType instance_type = null;
		if (m.binding == MemberBinding.INSTANCE) {
			instance_type = CCodeGenerator.get_data_type_for_symbol ((Typesymbol) m.parent_symbol);
		}

		write_params (m.get_parameters (), instance_type);

		write_return_type (m.return_type);

		indent--;
		write_indent ();
		stream.printf ("</method>\n");
	}
	
	public override void visit_creation_method (CreationMethod m) {
		if (m.external_package) {
			return;
		}

		if (!check_accessibility (m)) {
			return;
		}

		string name = "new";
		if (m.name.has_prefix (".new.")) {
			name = m.name.substring (5, m.name.len () - 5);
		}

		write_indent ();
		stream.printf ("<constructor name=\"%s\" symbol=\"%s\"", name, m.get_cname ());
		stream.printf (">\n");
		indent++;

		write_params (m.get_parameters ());

		write_return_type (CCodeGenerator.get_data_type_for_symbol ((Typesymbol) m.parent_symbol));

		indent--;
		write_indent ();
		stream.printf ("</constructor>\n");
	}

	public override void visit_property (Property prop) {
		if (!check_accessibility (prop) || prop.overrides || prop.base_interface_property != null) {
			return;
		}

		write_indent ();
		stream.printf ("<property name=\"%s\" type=\"%s\"", prop.name, get_gidl_type_name (prop.type_reference));
		if (prop.get_accessor != null) {
			stream.printf (" readable=\"1\"");
		}
		if (prop.set_accessor != null) {
			stream.printf (" writable=\"1\"");
		}
		stream.printf ("/>\n");
	}

	public override void visit_signal (Signal sig) {
		if (!check_accessibility (sig)) {
			return;
		}
		
		write_indent ();
		stream.printf ("<signal name=\"%s\"", sig.get_cname ());
		stream.printf (">\n");
		indent++;

		write_params (sig.get_parameters ());

		write_return_type (sig.return_type);

		indent--;
		write_indent ();
		stream.printf ("</signal>\n");
	}

	private void write_indent () {
		int i;
		
		for (i = 0; i < indent; i++) {
			stream.putc ('\t');
		}
	}

	private void write_return_type (DataType type) {
		write_indent ();
		stream.printf ("<return-type type=\"%s\"", get_gidl_type_name (type));
		if (type.transfers_ownership) {
			stream.printf (" transfer=\"full\"");
		}
		stream.printf ("/>\n");
	}

	private bool check_accessibility (Symbol sym) {
		if (sym.access == SymbolAccessibility.PUBLIC ||
		    sym.access == SymbolAccessibility.PROTECTED) {
			return true;
		}

		return false;
	}
}
