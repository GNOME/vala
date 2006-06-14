/* valatype.vala
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
	public abstract class Type_ : CodeNode {
		public string name { get; construct; }
		public SourceReference source_reference { get; construct; }
		public Namespace @namespace;
		public MemberAccessibility access;

		public abstract string get_cname ();
		public abstract bool is_reference_type ();
		public abstract bool is_reference_counting ();
		public abstract string get_ref_function ();
		public abstract string get_free_function ();
		
		public abstract ref string get_upper_case_cname (string infix);
		public abstract string get_lower_case_cname (string infix);
		
		public List<string> cheader_filenames;
		public ref List<string> get_cheader_filenames () {
			if (cheader_filenames == null) {
				cheader_filenames = @namespace.get_cheader_filenames ();
			}
			return cheader_filenames.copy ();
		}
	}
}
