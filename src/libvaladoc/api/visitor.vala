/* visitor.vala
 *
 * Valadoc.Api.- a documentation tool for vala.
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

public abstract class Valadoc.Api.Visitor : GLib.Object {
	public virtual void visit_tree (Tree item) {
	}

	public virtual void visit_package (Package item) {
	}

	public virtual void visit_namespace (Namespace item) {
	}

	public virtual void visit_interface (Interface item) {
	}

	public virtual void visit_class (Class item) {
	}

	public virtual void visit_struct (Struct item) {
	}

	public virtual void visit_property (Property item) {
	}

	public virtual void visit_field (Field item) {
	}

	public virtual void visit_constant (Constant item) {
	}

	public virtual void visit_delegate (Delegate item) {
	}

	public virtual void visit_signal (Signal item) {
	}

	public virtual void visit_creation_method (Method item) {
	}

	public virtual void visit_method (Method item) {
	}

	public virtual void visit_type_parameter (TypeParameter item) {
	}

	public virtual void visit_formal_parameter (FormalParameter item) {
	}

	public virtual void visit_error_domain (ErrorDomain item) {
	}

	public virtual void visit_error_code (ErrorCode item) {
	}

	public virtual void visit_enum (Enum item) {
	}

	public virtual void visit_enum_value (EnumValue item) {
	}
}
