/* valainterfacewriter.vala
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
 * Code visitor generating Vala API file for the public interface.
 */
public class Vala.InterfaceWriter : CodeVisitor {
	private CodeContext context;
	
	File stream;
	
	int indent;
	/* at begin of line */
	bool bol = true;
	
	bool internal_scope = false;
	
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
	
		stream = File.open (filename, "w");
	
		/* we're only interested in non-pkg source files */
		foreach (SourceFile file in context.get_source_files ()) {
			if (!file.pkg) {
				file.accept (this);
			}
		}
		
		stream = null;
	}

	public override void visit_begin_namespace (Namespace! ns) {
		if (ns.name == null)  {
			return;
		}

		current_cheader_filename = ns.get_cheader_filename ();
		
		write_indent ();
		write_string ("[CCode (cheader_filename = \"%s\")]".printf (current_cheader_filename));
		write_newline ();

		write_indent ();
		write_string ("namespace ");
		write_identifier (ns.name);
		write_begin_block ();
	}

	public override void visit_end_namespace (Namespace! ns) {
		if (ns.name == null)  {
			return;
		}
		
		write_end_block ();
		write_newline ();
	}

	public override void visit_begin_class (Class! cl) {
		if (cl.access != MemberAccessibility.PUBLIC) {
			internal_scope = true;
			return;
		}
		
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
	}

	public override void visit_end_class (Class! cl) {
		if (cl.access != MemberAccessibility.PUBLIC) {
			internal_scope = false;
			return;
		}
		
		write_end_block ();
		write_newline ();
	}

	public override void visit_begin_struct (Struct! st) {
		if (st.access != MemberAccessibility.PUBLIC) {
			internal_scope = true;
			return;
		}
		
		if (st.is_reference_type ()) {
			write_indent ();
			write_string ("[ReferenceType ()]");
		}
		
		write_indent ();
		write_string ("public struct ");
		write_identifier (st.name);
		write_begin_block ();
	}

	public override void visit_end_struct (Struct! st) {
		if (st.access != MemberAccessibility.PUBLIC) {
			internal_scope = false;
			return;
		}
		
		write_end_block ();
		write_newline ();
	}

	public override void visit_begin_interface (Interface! iface) {
		if (iface.access != MemberAccessibility.PUBLIC) {
			internal_scope = true;
			return;
		}
		
		write_indent ();
		write_string ("public ");
		write_string ("interface ");
		write_identifier (iface.name);

		write_begin_block ();
	}

	public override void visit_end_interface (Interface! iface) {
		if (iface.access != MemberAccessibility.PUBLIC) {
			internal_scope = false;
			return;
		}
		
		write_end_block ();
		write_newline ();
	}

	public override void visit_begin_enum (Enum! en) {
		if (en.access != MemberAccessibility.PUBLIC) {
			internal_scope = true;
			return;
		}
		
		write_indent ();
		write_string ("[CCode (cprefix = \"%s\")]".printf (en.get_cprefix ()));
		
		write_indent ();
		write_string ("public enum ");
		write_identifier (en.name);
		write_begin_block ();
	}

	public override void visit_end_enum (Enum! en) {
		if (en.access != MemberAccessibility.PUBLIC) {
			internal_scope = false;
			return;
		}
		
		write_end_block ();
		write_newline ();
	}

	public override void visit_enum_value (EnumValue! ev) {
		if (internal_scope) {
			return;
		}
		
		write_indent ();
		write_identifier (ev.name);
		write_string (",");
		write_newline ();
	}

	public override void visit_constant (Constant! c) {
		if (internal_scope) {
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
		if (internal_scope || f.access != MemberAccessibility.PUBLIC) {
			return;
		}
		
		write_indent ();
		write_string ("public ");
		if (!f.type_reference.takes_ownership) {
			write_string ("weak ");
		}
		write_string (f.type_reference.data_type.symbol.get_full_name ());
			
		var type_args = f.type_reference.get_type_arguments ();
		if (type_args != null) {
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
		if (f.name == "base" || f.name == "callback" ||
		    f.name == "flags" || f.name == "in" ||
		    f.name == "out") {
			write_string ("@");
		}
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
			
			if (param.type_reference.reference_to_value_type ||
			    param.type_reference.takes_ownership) {
				write_string ("ref ");
			} else if (param.type_reference.is_out) {
				write_string ("out ");
			}
			write_string (param.type_reference.data_type.symbol.get_full_name ());
			
			var type_args = param.type_reference.get_type_arguments ();
			if (type_args != null) {
				write_string ("<");
				foreach (TypeReference type_arg in type_args) {
					if (type_arg.takes_ownership) {
						write_string ("ref ");
					}
					write_string (type_arg.data_type.symbol.get_full_name ());
				}
				write_string (">");
			}

			if (param.type_reference.non_null) {
				write_string ("!");
			}
			
			write_string (" ");
			if (param.name == "callback" || param.name == "flags" ||
			    param.name == "out" || param.name == "set") {
				write_string ("@");
			}
			write_identifier (param.name);
			
			if (param.default_expression != null) {
				write_string (" = ");
				write_string (param.default_expression.to_string ());
			}
		}
		
		write_string (")");
	}

	public override void visit_begin_callback (Callback! cb) {
		if (internal_scope || cb.access != MemberAccessibility.PUBLIC) {
			return;
		}
		
		write_indent ();
		write_string ("public callback ");
		
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

	public override void visit_begin_method (Method! m) {
		if (internal_scope || m.access != MemberAccessibility.PUBLIC || m.overrides) {
			return;
		}
		
		write_indent ();
		write_string ("public");
		
		if (m.construction) {
			write_string (" construct");
		} else if (!m.instance) {
			write_string (" static");
		} else if (m.is_abstract) {
			write_string (" abstract");
		} else if (m.is_virtual) {
			write_string (" virtual");
		}
		
		if (!m.construction) {
			write_string (" ");

			var type = m.return_type.data_type;
			if (type == null) {
				write_string ("void");
			} else {
				if (m.return_type.transfers_ownership) {
					write_string ("ref ");
				}
				write_string (m.return_type.data_type.symbol.get_full_name ());
				if (m.return_type.non_null) {
					write_string ("!");
				}
			}
		}
		
		if (m.name != null) {
			write_string (" ");
			if (m.name == "class" || m.name == "construct" ||
			    m.name == "foreach" || m.name == "get" ||
			    m.name == "ref" || m.name == "set") {
				write_string ("@");
			}
			write_identifier (m.name);
		}
		
		write_string (" ");
		
		write_params (m.get_parameters ());

		write_string (";");

		write_newline ();
	}

	public override void visit_begin_property (Property! prop) {
		if (internal_scope) {
			return;
		}
		
		if (prop.no_accessor_method) {
			write_indent ();
			write_string ("[NoAccessorMethod ()]");
		}
		
		write_indent ();
		write_string ("public ");
		if (!prop.type_reference.takes_ownership) {
			write_string ("weak ");
		}
		write_string (prop.type_reference.data_type.symbol.get_full_name ());
			
		var type_args = prop.type_reference.get_type_arguments ();
		if (type_args != null) {
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

	public override void visit_begin_signal (Signal! sig) {
		if (internal_scope || sig.access != MemberAccessibility.PUBLIC) {
			return;
		}
		
		if (sig.has_emitter) {
			write_indent ();
			write_string ("[HasEmitter ()]");
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
		if (s == "namespace") {
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
