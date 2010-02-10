/* sourcecode.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using Gee;

public class Valadoc.Content.SourceCode : ContentElement, Inline{
	public enum Language {
		GENIE,
		VALA,
		C;

		public static Language? from_string (string str) {
			switch (str) {
			case "Genie":
				return Language.GENIE;
			case "Vala":
				return Language.VALA;
			case "C":
				return Language.C;
			}

			return null;
		}

		public weak string to_string () {
			switch (this) {
			case Language.GENIE:
				return "Genie";
			case Language.VALA:
				return "Vala";
			case Language.C:
				return "C";
			}

			assert (true);
			return "";
		}
	}

	public string code { get; set; }
	public Language language { get; set; }

	internal SourceCode () {
		base ();
		_language = Language.VALA;
	}

	public override void check (Api.Tree api_root, Api.Node container, ErrorReporter reporter, Settings settings) {
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_source_code (this);
	}
}
