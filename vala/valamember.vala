/* valamember.vala
 *
 * Copyright (C) 2006-2008  Raffaele Sandrini, Jürg Billeter
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
 * 	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;
using Gee;

/**
 * Represents a general class member.
 */
public class Vala.Member : Symbol {
	private Gee.List<string> cheader_filenames = new ArrayList<string> ();
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_member (this);
	}

	public override Gee.List<string> get_cheader_filenames () {
		if (cheader_filenames.size == 0 && parent_symbol != null) {
			/* default to header filenames of the namespace */
			foreach (string filename in parent_symbol.get_cheader_filenames ()) {
				add_cheader_filename (filename);
			}

			if (cheader_filenames.size == 0 && source_reference != null && !external_package) {
				// don't add default include directives for VAPI files
				cheader_filenames.add (source_reference.file.get_cinclude_filename ());
			}
		}
		return new ReadOnlyList<string> (cheader_filenames);
	}

	
	/**
	 * Adds a filename to the list of C header filenames users of this data
	 * type must include.
	 *
	 * @param filename a C header filename
	 */
	public void add_cheader_filename (string filename) {
		cheader_filenames.add (filename);
	}
}

public enum MemberBinding {
	INSTANCE,
	CLASS,
	STATIC
}

