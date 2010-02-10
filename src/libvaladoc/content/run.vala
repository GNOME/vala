/* run.vala
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


public class Valadoc.Content.Run : InlineContent, Inline {
	public enum Style {
		NONE,
		BOLD,
		ITALIC,
		UNDERLINED,
		MONOSPACED,
		STROKE,
		LANG_KEYWORD,
		LANG_LITERAL,
		LANG_BASIC_TYPE,
		LANG_TYPE;

		public static Style? from_string (string str) {
			switch (str) {
			case "none":
				return Style.NONE;

			case "bold":
				return Style.BOLD;

			case "italic":
				return Style.ITALIC;

			case "underlined":
				return Style.UNDERLINED;

			case "monospaced":
				return Style.MONOSPACED;	

			case "stroke":
				return Style.STROKE;

			case "lang-keyword":
				return Style.LANG_KEYWORD;

			case "lang-literal":
				return Style.LANG_LITERAL;

			case "lang-basic-type":
				return Style.LANG_BASIC_TYPE;

			case "lang-type":
				return Style.LANG_TYPE;
			}

			return null;
		}

		public weak string to_string () {
			switch (this) {
			case Style.NONE:
				return "none";

			case Style.BOLD:
				return "bold";

			case Style.ITALIC:
				return "italic";

			case Style.UNDERLINED:
				return "underlined";

			case Style.MONOSPACED:
				return "monopace";

			case Style.STROKE:
				return "stroke";

			case Style.LANG_KEYWORD:
				return "lang-keyword";

			case Style.LANG_LITERAL:
				return "lang-literal";

			case Style.LANG_BASIC_TYPE:
				return "lang-basic-type";

			case Style.LANG_TYPE:
				return "lang-type";
			}

			assert (true);
			return "";
		}
	}

	public Style style { get; set; }

	internal Run (Style style) {
		base ();
		_style = style;
	}

	public override void check (Api.Tree api_root, Api.Node container, ErrorReporter reporter, Settings settings) {
		// Check inline content
		base.check (api_root, container, reporter, settings);
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_run (this);
	}
}

