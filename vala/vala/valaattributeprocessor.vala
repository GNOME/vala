/* valaattributeprocessor.vala
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
 * Code visitor processing attributes associated with code nodes.
 */
public class Vala.AttributeProcessor : CodeVisitor {
	/**
	 * Process all attributes found in specified code context.
	 *
	 * @param context a code context
	 */
	public void process (CodeContext! context) {
		context.accept (this);
	}

	public override void visit_begin_namespace (Namespace! ns) {
		ns.process_attributes ();
	}

	public override void visit_begin_struct (Struct! st) {
		st.process_attributes ();
	}

	public override void visit_begin_class (Class! cl) {
		cl.process_attributes ();
	}

	public override void visit_begin_enum (Enum! en) {
		en.process_attributes ();
	}

	public override void visit_begin_method (Method! m) {
		m.process_attributes ();
	}

	public override void visit_begin_property (Property! prop) {
		prop.process_attributes ();
	}

	public override void visit_field (Field! f) {
		f.process_attributes ();
	}

	public override void visit_begin_signal (Signal! sig) {
		sig.process_attributes ();
	}
}
