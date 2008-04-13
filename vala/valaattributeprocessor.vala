/* valaattributeprocessor.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

/**
 * Code visitor processing attributes associated with code nodes.
 */
public class Vala.AttributeProcessor : CodeVisitor {
	/**
	 * Process all attributes found in specified code context.
	 *
	 * @param context a code context
	 */
	public void process (CodeContext context) {
		context.accept (this);
	}

	public override void visit_source_file (SourceFile source_file) {
		source_file.accept_children (this);
	}

	public override void visit_namespace (Namespace ns) {
		ns.process_attributes ();

		foreach (Namespace ns in ns.get_namespaces ()) {
			ns.accept (this);
		}
	}

	public override void visit_class (Class cl) {
		cl.process_attributes ();

		cl.accept_children (this);
	}

	public override void visit_struct (Struct st) {
		st.process_attributes ();

		st.accept_children (this);
	}

	public override void visit_interface (Interface iface) {
		iface.process_attributes ();

		iface.accept_children (this);
	}

	public override void visit_enum (Enum en) {
		en.process_attributes ();
	}

	public override void visit_method (Method m) {
		m.process_attributes ();

		m.accept_children (this);
	}
	
	public override void visit_creation_method (CreationMethod m) {
		m.process_attributes ();

		m.accept_children (this);
	}

	public override void visit_formal_parameter (FormalParameter p) {
		p.process_attributes ();
	}

	public override void visit_property (Property prop) {
		prop.process_attributes ();
	}

	public override void visit_delegate (Delegate d) {
		d.process_attributes ();

		d.accept_children (this);
	}

	public override void visit_constant (Constant c) {
		c.process_attributes ();
	}

	public override void visit_field (Field f) {
		f.process_attributes ();
	}

	public override void visit_signal (Signal sig) {
		sig.process_attributes ();

		sig.accept_children (this);
	}
}
