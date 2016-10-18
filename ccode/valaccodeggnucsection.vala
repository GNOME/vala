/* valaccodeggnucsection.vala
 *
 * Copyright (C) 2016  Rico Tzschichholz
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
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */

using GLib;

/**
 * Represents a section that should be processed on condition.
 */
public class Vala.CCodeGGnucSection : CCodeFragment {
	/**
	 * The expression
	 */
	public GGnucSectionType section_type { get; set; }

	public CCodeGGnucSection (GGnucSectionType t) {
		section_type = t;
	}

	public override void write (CCodeWriter writer) {
		writer.write_string ("G_GNUC_BEGIN_");
		writer.write_string (section_type.to_string ());
		writer.write_newline ();
		foreach (CCodeNode node in get_children ()) {
			node.write_combined (writer);
		}
		writer.write_string ("G_GNUC_END_");
		writer.write_string (section_type.to_string ());
		writer.write_newline ();
	}

	public override void write_declaration (CCodeWriter writer) {
	}
}

public enum Vala.GGnucSectionType {
	IGNORE_DEPRECATIONS;

	public unowned string to_string () {
		switch (this) {
			case IGNORE_DEPRECATIONS:
				return "IGNORE_DEPRECATIONS";
			default:
				assert_not_reached ();
		}
	}
}
