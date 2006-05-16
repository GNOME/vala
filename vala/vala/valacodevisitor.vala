/* valacodevisitor.vala
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

namespace Vala {
	public abstract class CodeVisitor {
		public virtual void visit_begin_source_file (SourceFile source_file) {
		}

		public virtual void visit_end_source_file (SourceFile source_file) {
		}

		public virtual void visit_begin_namespace (Namespace ns) {
		}

		public virtual void visit_end_namespace (Namespace ns) {
		}

		public virtual void visit_begin_class (Class cl) {
		}

		public virtual void visit_end_class (Class cl) {
		}

		public virtual void visit_begin_struct (Struct st) {
		}

		public virtual void visit_end_struct (Struct st) {
		}

		public virtual void visit_enum (Enum en) {
		}

		public virtual void visit_constant (Constant c) {
		}

		public virtual void visit_field (Field f) {
		}

		public virtual void visit_method (Method m) {
		}

		public virtual void visit_property (Property prop) {
		}

		public virtual void visit_type_parameter (TypeParameter p) {
		}

		public virtual void visit_namespace_reference (NamespaceReference ns) {
		}

		public virtual void visit_type_reference (TypeReference type) {
		}
	}
}
