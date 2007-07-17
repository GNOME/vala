/* valainterfacewriter.vala
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

/**
 * Code visitor generating Vala API file for the public interface.
 */
public class Vala.InterfaceWriter : CodeVisitor {
	private CodeContext context;
	
	FileStream stream;
	
	int indent;
	/* at begin of line */
	bool bol = true;

	string current_cheader_filename;

	/**
	 * Writes the public interface of the specified code context into the
	 * specified file.
	 *
	 * @param context  a code context
	 * @param filename a relative or absolute filename
	 */
	public void write_file (CodeContext! context, string! filename) {
		this.context = context;
	
		stream = FileStream.open (filename, "w");

		context.accept (this);
		
		stream = null;
	}

	public override void visit_namespace (Namespace! ns) {
		if (ns.source_reference != null && ns.source_reference.file.pkg) {
			return;
		}

		if (ns.name == null)  {
			ns.accept_children (this);
			return;
		}

		current_cheader_filename = ns.get_cheader_filename ();
		
		write_indent ();
		write_string ("[CCode (cprefix = \"%s\", lower_case_cprefix = \"%s\", cheader_filename = \"%s\")]".printf (ns.get_cprefix (), ns.get_lower_case_cprefix (), current_cheader_filename));
		write_newline ();

		write_indent ();
		write_string ("namespace ");
		write_identifier (ns.name);
		write_begin_block ();

		ns.accept_children (this);

		write_end_block ();
		write_newline ();
	}

	public override void visit_class (Class! cl) {
		if (cl.source_reference != null && cl.source_reference.file.pkg) {
			return;
		}

		if (cl.access == MemberAccessibility.PRIVATE) {
			return;
		}
		
		write_indent ();
		
		var first = true;
		string cheaders;
		foreach (string cheader in cl.get_cheader_filenames ()) {
			if (first) {
				cheaders = cheader;
				first = false;
			} else {
				cheaders = "%s, %s".printf (cheaders, cheader);
			}
		}
		write_string ("[CCode (cheader_filename = \"%s\")]".printf (cheaders));
		write_newline ();
		
		write_indent ();
		write_string ("public ");
		if (cl.is_abstract) {
			write_string ("abstract ");
		}
		write_string ("class ");
		write_identifier (cl.name);
		
		var base_types = cl.get_base_types ();
		if (base_types != null) {
			write_string (" : ");
		
			bool first = true;
			foreach (TypeReference base_type in base_types) {
				if (!first) {
					write_string (", ");
				} else {
					first = false;
				}
				write_string (base_type.data_type.symbol.get_full_name ());
			}
		}
		write_begin_block ();

		cl.accept_children (this);

		write_end_block ();
		write_newline ();
	}

	public override void visit_struct (Struct! st) {
		if (st.source_reference != null && st.source_reference.file.pkg) {
			return;
		}

		if (st.access == MemberAccessibility.PRIVATE) {
			return;
		}
		
		if (st.is_reference_type ()) {
			write_indent ();
			write_string ("[ReferenceType]");
		}
		
		write_indent ();
		write_string ("public struct ");
		write_identifier (st.name);
		write_begin_block ();

		st.accept_children (this);

		write_end_block ();
		write_newline ();
	}

	public override void visit_interface (Interface! iface) {
		if (iface.source_reference != null && iface.source_reference.file.pkg) {
			return;
		}

		if (iface.access == MemberAccessibility.PRIVATE) {
			return;
		}

		write_indent ();

		var first = true;
		string cheaders;
		foreach (string cheader in iface.get_cheader_filenames ()) {
			if (first) {
				cheaders = cheader;
				first = false;
			} else {
				cheaders = "%s, %s".printf (cheaders, cheader);
			}
		}
		write_string ("[CCode (cheader_filename = \"%s\")]".printf (cheaders));
		write_newline ();

		write_indent ();
		write_string ("public ");
		write_string ("interface ");
		write_identifier (iface.name);

		write_begin_block ();

		iface.accept_children (this);

		write_end_block ();
		write_newline ();
	}

	public override void visit_enum (Enum! en) {
		if (en.source_reference != null && en.source_reference.file.pkg) {
			return;
		}

		if (en.access == MemberAccessibility.PRIVATE) {
			return;
		}

		write_indent ();
		write_string ("[CCode (cprefix = \"%s\")]".printf (en.get_cprefix ()));

		write_indent ();
		write_string ("public enum ");
		write_identifier (en.name);
		write_begin_block ();

		en.accept_children (this);

		write_end_block ();
		write_newline ();
	}

	public override void visit_enum_value (EnumValue! ev) {
		write_indent ();
		write_identifier (ev.name);
		write_string (",");
		write_newline ();
	}

	public override void visit_flags (Flags! fl) {
		if (fl.source_reference != null && fl.source_reference.file.pkg) {
			return;
		}

		if (fl.access == MemberAccessibility.PRIVATE) {
			return;
		}

		write_indent ();
		write_string ("[CCode (cprefix = \"%s\")]".printf (fl.get_cprefix ()));

		write_indent ();
		write_string ("public flags ");
		write_identifier (fl.name);
		write_begin_block ();

		fl.accept_children (this);

		write_end_block ();
		write_newline ();
	}

	public override void visit_flags_value (FlagsValue! fv) {
		write_indent ();
		write_identifier (fv.name);
		write_string (",");
		write_newline ();
	}

	public override void visit_constant (Constant! c) {
		if (c.source_reference != null && c.source_reference.file.pkg) {
			return;
		}

		write_indent ();
		write_string ("public const ");
		write_string (c.type_reference.data_type.symbol.get_full_name ());
			
		write_string (" ");
		write_identifier (c.name);
		write_string (";");
		write_newline ();
	}

	public override void visit_field (Field! f) {
		if (f.source_reference != null && f.source_reference.file.pkg) {
			return;
		}

		if (f.access == MemberAccessibility.PRIVATE) {
			return;
		}
		
		write_indent ();
		write_string ("public ");
		if (f.type_reference.data_type != null &&
		    f.type_reference.data_type.is_reference_type () &&
		    !f.type_reference.takes_ownership) {
			write_string ("weak ");
		}
		write_string (f.type_reference.data_type.symbol.get_full_name ());
			
		var type_args = f.type_reference.get_type_arguments ();
		if (!(f.type_reference.data_type is Array) && type_args != null) {
			write_string ("<");
			foreach (TypeReference type_arg in type_args) {
				if (!type_arg.takes_ownership) {
					write_string ("weak ");
				}
				write_string (type_arg.data_type.symbol.get_full_name ());
			}
			write_string (">");
		}
			
		write_string (" ");
		write_identifier (f.name);
		write_string (";");
		write_newline ();
	}
	
	private void write_params (List<FormalParameter> params) {
		write_string ("(");
		
		bool first = true;
		foreach (FormalParameter param in params) {
			if (!first) {
				write_string (", ");
			} else {
				first = false;
			}
			
			if (param.ellipsis) {
				write_string ("...");
				continue;
			}
			
			if (param.type_reference.is_ref) {
				write_string ("ref ");
			} else if (param.type_reference.is_out) {
				write_string ("out ");
			}
			write_string (param.type_reference.data_type.symbol.get_full_name ());
			
			var type_args = param.type_reference.get_type_arguments ();
			if (!(param.type_reference.data_type is Array) && type_args != null) {
				write_string ("<");
				foreach (TypeReference type_arg in type_args) {
					if (!type_arg.takes_ownership) {
						write_string ("weak ");
					}
					write_string (type_arg.data_type.symbol.get_full_name ());
				}
				write_string (">");
			}

			if (param.type_reference.non_null) {
				write_string ("!");
			}

			if (param.type_reference.takes_ownership) {
				write_string ("#");
			}

			write_string (" ");
			write_identifier (param.name);
			
			if (param.default_expression != null) {
				write_string (" = ");
				write_string (param.default_expression.to_string ());
			}
		}
		
		write_string (")");
	}

	public override void visit_callback (Callback! cb) {
		if (cb.source_reference != null && cb.source_reference.file.pkg) {
			return;
		}

		if (cb.access == MemberAccessibility.PRIVATE) {
			return;
		}
		
		write_indent ();
		write_string ("public static delegate ");
		
		var type = cb.return_type.data_type;
		if (type == null) {
			write_string ("void");
		} else {
			if (cb.return_type.transfers_ownership) {
				write_string ("ref ");
			}
			write_string (cb.return_type.data_type.symbol.get_full_name ());
		}
		
		write_string (" ");
		write_identifier (cb.name);
		
		write_string (" ");
		
		write_params (cb.get_parameters ());

		write_string (";");

		write_newline ();
	}

	public override void visit_method (Method! m) {
		if (m.access == MemberAccessibility.PRIVATE || m.overrides) {
			return;
		}
		
		if (m.no_array_length) {
			bool array_found = (m.return_type != null && m.return_type.data_type is Array);
			foreach (FormalParameter param in m.get_parameters ()) {
				if (param.type_reference != null && param.type_reference.data_type is Array) {
					array_found = true;
					break;
				}
			}
			if (array_found) {
				write_indent ();
				write_string ("[NoArrayLength]");
			}
		}
		if (m.instance_last) {
			write_indent ();
			write_string ("[InstanceLast]");
		}
		if (m.instance_by_reference) {
			write_indent ();
			write_string ("[InstanceByReference]");
		}
		if (m.get_cname () != m.get_default_cname ()) {
			write_indent ();
			write_string ("[CCode (cname = \"%s\")]".printf (m.get_cname ()));
		}
		
		write_indent ();
		write_string ("public");
		
		if (m is CreationMethod) {
			write_string (" ");
			var datatype = (DataType) m.symbol.parent_symbol.node;
			write_identifier (datatype.name);
		
			if (m.name != null) {
				write_string (".");
				write_identifier (m.name);
			}
		} else if (!m.instance) {
			write_string (" static");
		} else if (m.is_abstract) {
			write_string (" abstract");
		} else if (m.is_virtual) {
			write_string (" virtual");
		}
		
		if (!(m is CreationMethod)) {
			write_string (" ");

			var type = m.return_type.data_type;
			if (type == null) {
				write_string ("void");
			} else {
				if (m.return_type.transfers_ownership) {
				} else if ((m.return_type.data_type != null && m.return_type.data_type.is_reference_type ()) || m.return_type.type_parameter != null) {
					write_string ("weak ");
				}
				write_string (m.return_type.data_type.symbol.get_full_name ());
				if (m.return_type.non_null) {
					write_string ("!");
				}
			}

			write_string (" ");
			write_identifier (m.name);
		}
		
		write_string (" ");
		
		write_params (m.get_parameters ());

		write_string (";");

		write_newline ();
	}
	
	public override void visit_creation_method (CreationMethod! m) {
		visit_method (m);
	}

	public override void visit_property (Property! prop) {
		if (prop.no_accessor_method) {
			write_indent ();
			write_string ("[NoAccessorMethod]");
		}
		
		write_indent ();
		write_string ("public ");
		if (!prop.type_reference.takes_ownership) {
			write_string ("weak ");
		}
		write_string (prop.type_reference.data_type.symbol.get_full_name ());
			
		var type_args = prop.type_reference.get_type_arguments ();
		if (!(prop.type_reference.data_type is Array) && type_args != null) {
			write_string ("<");
			foreach (TypeReference type_arg in type_args) {
				if (!type_arg.takes_ownership) {
					write_string ("weak ");
				}
				write_string (type_arg.data_type.symbol.get_full_name ());
			}
			write_string (">");
		}
			
		write_string (" ");
		write_identifier (prop.name);
		write_string (" {");
		if (prop.get_accessor != null) {
			write_string (" get;");
		}
		if (prop.set_accessor != null) {
			if (prop.set_accessor.writable) {
				write_string (" set");
			}
			if (prop.set_accessor.construction) {
				write_string (" construct");
			}
			write_string (";");
		}
		write_string (" }");
		write_newline ();
	}

	public override void visit_signal (Signal! sig) {
		if (sig.access == MemberAccessibility.PRIVATE) {
			return;
		}
		
		if (sig.has_emitter) {
			write_indent ();
			write_string ("[HasEmitter]");
		}
		
		write_indent ();
		write_string ("public signal ");
		
		var type = sig.return_type.data_type;
		if (type == null) {
			write_string ("void");
		} else {
			if (sig.return_type.transfers_ownership) {
				write_string ("ref ");
			}
			write_string (sig.return_type.data_type.symbol.get_full_name ());
			if (sig.return_type.non_null) {
				write_string ("!");
			}
		}
		
		write_string (" ");
		write_identifier (sig.name);
		
		write_string (" ");
		
		write_params (sig.get_parameters ());

		write_string (";");

		write_newline ();
	}

	private void write_indent () {
		int i;
		
		if (!bol) {
			stream.putc ('\n');
		}
		
		for (i = 0; i < indent; i++) {
			stream.putc ('\t');
		}
		
		bol = false;
	}
	
	private void write_identifier (string! s) {
		if (s == "base" || s == "callback" || s == "class" ||
		    s == "construct" || s == "flags" || s == "foreach" ||
		    s == "in" || s == "interface" || s == "lock" ||
		    s == "namespace" || s == "out" || s == "ref") {
			stream.putc ('@');
		}
		write_string (s);
	}
	
	private void write_string (string! s) {
		stream.printf ("%s", s);
		bol = false;
	}
	
	private void write_newline () {
		stream.putc ('\n');
		bol = true;
	}
	
	private void write_begin_block () {
		if (!bol) {
			stream.putc (' ');
		} else {
			write_indent ();
		}
		stream.putc ('{');
		write_newline ();
		indent++;
	}
	
	private void write_end_block () {
		indent--;
		write_indent ();
		stream.printf ("}");
	}
}
