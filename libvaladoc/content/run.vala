/* run.vala
 *
 * Copyright (C) 2008-2009 Didier Villevalois
 * Copyright (C) 2008-2012 Florian Brosch
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
		LANG_TYPE,
		LANG_PREPROCESSOR,
		LANG_COMMENT,
		LANG_ESCAPE,

		XML_ESCAPE,
		XML_ELEMENT,
		XML_ATTRIBUTE,
		XML_ATTRIBUTE_VALUE,
		XML_COMMENT,
		XML_CDATA;

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

			case "lang-escape":
				return Style.LANG_ESCAPE;

			case "lang-keyword":
				return Style.LANG_KEYWORD;

			case "lang-literal":
				return Style.LANG_LITERAL;

			case "lang-basic-type":
				return Style.LANG_BASIC_TYPE;

			case "lang-type":
				return Style.LANG_TYPE;

			case "lang-preprocessor":
				return Style.LANG_PREPROCESSOR;

			case "lang-comment":
				return Style.LANG_COMMENT;

			case "xml-escape":
				return Style.XML_ESCAPE;

			case "xml-element":
				return Style.XML_ELEMENT;

			case "xml-attribute":
				return Style.XML_ATTRIBUTE;

			case "xml-attribute-value":
				return Style.XML_ATTRIBUTE_VALUE;

			case "xml-comment":
				return Style.XML_COMMENT;

			case "xml-cdata":
				return Style.XML_CDATA;
			}

			return null;
		}

		public unowned string to_string () {
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
				return "monospaced";

			case Style.STROKE:
				return "stroke";

			case Style.LANG_ESCAPE:
				return "lang-escape";

			case Style.LANG_KEYWORD:
				return "lang-keyword";

			case Style.LANG_LITERAL:
				return "lang-literal";

			case Style.LANG_BASIC_TYPE:
				return "lang-basic-type";

			case Style.LANG_TYPE:
				return "lang-type";

			case Style.LANG_PREPROCESSOR:
				return "lang-preprocessor";

			case Style.LANG_COMMENT:
				return "lang-comment";

			case Style.XML_ESCAPE:
				return "xml-escape";

			case Style.XML_ELEMENT:
				return "xml-element";

			case Style.XML_ATTRIBUTE:
				return "xml-attribute";

			case Style.XML_ATTRIBUTE_VALUE:
				return "xml-attribute-value";

			case Style.XML_COMMENT:
				return "xml-comment";

			case Style.XML_CDATA:
				return "xml-cdata";
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

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings)
	{
		// Check inline content
		base.check (api_root, container, file_path, reporter, settings);
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_run (this);
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		Run run = new Run (style);
		run.parent = new_parent;

		foreach (Inline element in content) {
			Inline copy = element.copy (run) as Inline;
			run.content.add (copy);
		}

		return run;
	}
}

