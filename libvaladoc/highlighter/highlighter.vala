/* codehighlighter.vala
 *
 * Copyright (C) 2015       Florian Brosch
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
 * 	Florian Brosch <flo.brosch@gmail.com>
 */

using GLib;
using Valadoc.Content;


public class Valadoc.Highlighter.Highlighter : Object {
	private Vala.HashMap<string, CodeTokenType?> vala_keywords;
	private Vala.HashMap<string, CodeTokenType?> c_keywords;


	/**
	 * Used to highlight vala source code.
	 */
	public Run highlight_vala (string source_code) {
		if (vala_keywords == null) {
			vala_keywords = new Vala.HashMap<string, CodeTokenType?> (str_hash, str_equal);

			// ** Types: **
			vala_keywords.set ("string", CodeTokenType.TYPE);
			vala_keywords.set ("bool", CodeTokenType.TYPE);
			vala_keywords.set ("void", CodeTokenType.TYPE);

			vala_keywords.set ("double", CodeTokenType.TYPE);
			vala_keywords.set ("float", CodeTokenType.TYPE);

			vala_keywords.set ("char", CodeTokenType.TYPE);
			vala_keywords.set ("uchar", CodeTokenType.TYPE);
			vala_keywords.set ("unichar", CodeTokenType.TYPE);

			vala_keywords.set ("short", CodeTokenType.TYPE);
			vala_keywords.set ("ushort", CodeTokenType.TYPE);

			vala_keywords.set ("long", CodeTokenType.TYPE);
			vala_keywords.set ("ulong", CodeTokenType.TYPE);

			vala_keywords.set ("size_t", CodeTokenType.TYPE);
			vala_keywords.set ("ssize_t", CodeTokenType.TYPE);

			vala_keywords.set ("int", CodeTokenType.TYPE);
			vala_keywords.set ("int8", CodeTokenType.TYPE);
			vala_keywords.set ("int16", CodeTokenType.TYPE);
			vala_keywords.set ("int32", CodeTokenType.TYPE);
			vala_keywords.set ("int64", CodeTokenType.TYPE);

			vala_keywords.set ("uint", CodeTokenType.TYPE);
			vala_keywords.set ("uint8", CodeTokenType.TYPE);
			vala_keywords.set ("uint16", CodeTokenType.TYPE);
			vala_keywords.set ("uint32", CodeTokenType.TYPE);
			vala_keywords.set ("uint64", CodeTokenType.TYPE);


			// ** Literals: **
			vala_keywords.set ("null", CodeTokenType.LITERAL);
			vala_keywords.set ("true", CodeTokenType.LITERAL);
			vala_keywords.set ("false", CodeTokenType.LITERAL);


			// ** Keywords: **
			vala_keywords.set ("return", CodeTokenType.KEYWORD);
			vala_keywords.set ("lock", CodeTokenType.KEYWORD);
			vala_keywords.set ("unlock", CodeTokenType.KEYWORD);
			vala_keywords.set ("var", CodeTokenType.KEYWORD);
			vala_keywords.set ("yield", CodeTokenType.KEYWORD);
			vala_keywords.set ("global", CodeTokenType.KEYWORD);
			vala_keywords.set ("construct", CodeTokenType.KEYWORD);

			vala_keywords.set ("value", CodeTokenType.KEYWORD);
			vala_keywords.set ("get", CodeTokenType.KEYWORD);
			vala_keywords.set ("set", CodeTokenType.KEYWORD);

			vala_keywords.set ("owned", CodeTokenType.KEYWORD);
			vala_keywords.set ("unowned", CodeTokenType.KEYWORD);
			vala_keywords.set ("const", CodeTokenType.KEYWORD);
			vala_keywords.set ("weak", CodeTokenType.KEYWORD);
			vala_keywords.set ("dynamic", CodeTokenType.KEYWORD);

			vala_keywords.set ("out", CodeTokenType.KEYWORD);
			vala_keywords.set ("ref", CodeTokenType.KEYWORD);

			vala_keywords.set ("break", CodeTokenType.KEYWORD);
			vala_keywords.set ("continue", CodeTokenType.KEYWORD);
			vala_keywords.set ("return", CodeTokenType.KEYWORD);

			vala_keywords.set ("if", CodeTokenType.KEYWORD);
			vala_keywords.set ("else", CodeTokenType.KEYWORD);
			vala_keywords.set ("switch", CodeTokenType.KEYWORD);
			vala_keywords.set ("case", CodeTokenType.KEYWORD);
			vala_keywords.set ("default", CodeTokenType.KEYWORD);

			vala_keywords.set ("do", CodeTokenType.KEYWORD);
			vala_keywords.set ("while", CodeTokenType.KEYWORD);
			vala_keywords.set ("for", CodeTokenType.KEYWORD);
			vala_keywords.set ("foreach", CodeTokenType.KEYWORD);
			vala_keywords.set ("in", CodeTokenType.KEYWORD);

			vala_keywords.set ("try", CodeTokenType.KEYWORD);
			vala_keywords.set ("catch", CodeTokenType.KEYWORD);
			vala_keywords.set ("finally", CodeTokenType.KEYWORD);
			vala_keywords.set ("throw", CodeTokenType.KEYWORD);

			vala_keywords.set ("class", CodeTokenType.KEYWORD);
			vala_keywords.set ("interface", CodeTokenType.KEYWORD);
			vala_keywords.set ("struct", CodeTokenType.KEYWORD);
			vala_keywords.set ("enum", CodeTokenType.KEYWORD);
			vala_keywords.set ("delegate", CodeTokenType.KEYWORD);
			vala_keywords.set ("errordomain", CodeTokenType.KEYWORD);

			vala_keywords.set ("abstract", CodeTokenType.KEYWORD);
			vala_keywords.set ("virtual", CodeTokenType.KEYWORD);
			vala_keywords.set ("override", CodeTokenType.KEYWORD);
			vala_keywords.set ("signal", CodeTokenType.KEYWORD);
			vala_keywords.set ("extern", CodeTokenType.KEYWORD);
			vala_keywords.set ("static", CodeTokenType.KEYWORD);
			vala_keywords.set ("async", CodeTokenType.KEYWORD);
			vala_keywords.set ("inline", CodeTokenType.KEYWORD);
			vala_keywords.set ("new", CodeTokenType.KEYWORD);

			vala_keywords.set ("public", CodeTokenType.KEYWORD);
			vala_keywords.set ("private", CodeTokenType.KEYWORD);
			vala_keywords.set ("protected", CodeTokenType.KEYWORD);
			vala_keywords.set ("internal", CodeTokenType.KEYWORD);

			vala_keywords.set ("throws", CodeTokenType.KEYWORD);
			vala_keywords.set ("requires", CodeTokenType.KEYWORD);
			vala_keywords.set ("ensures", CodeTokenType.KEYWORD);
			vala_keywords.set ("assert", CodeTokenType.KEYWORD);

			vala_keywords.set ("namespace", CodeTokenType.KEYWORD);
			vala_keywords.set ("using", CodeTokenType.KEYWORD);

			vala_keywords.set ("as", CodeTokenType.KEYWORD);
			vala_keywords.set ("is", CodeTokenType.KEYWORD);
			vala_keywords.set ("in", CodeTokenType.KEYWORD);
			vala_keywords.set ("new", CodeTokenType.KEYWORD);
			vala_keywords.set ("delete", CodeTokenType.KEYWORD);
			vala_keywords.set ("sizeof", CodeTokenType.KEYWORD);
			vala_keywords.set ("typeof", CodeTokenType.KEYWORD);

			vala_keywords.set ("this", CodeTokenType.KEYWORD);
			vala_keywords.set ("base", CodeTokenType.KEYWORD);
		}

		bool enable_string_templates = true;
		bool enable_preprocessor_define = false;
		bool enable_preprocessor_include = false;
		bool enable_keyword_escape = true;
		bool enabel_verbatim_string = true;

		CodeScanner scanner = new CodeScanner (source_code, enable_string_templates, enabel_verbatim_string,
			enable_preprocessor_define, enable_preprocessor_include, enable_keyword_escape,
			vala_keywords);

		return highlight_code (scanner);
	}

	/**
	 * Used to highlight C source code.
	 */
	public Run highlight_c (string source_code) {
		if (c_keywords == null) {
			c_keywords = new Vala.HashMap<string, CodeTokenType?> (str_hash, str_equal);

			// ** Types: **
			c_keywords.set ("auto", CodeTokenType.TYPE);
			c_keywords.set ("char", CodeTokenType.TYPE);
			c_keywords.set ("const", CodeTokenType.TYPE);
			c_keywords.set ("double", CodeTokenType.TYPE);
			c_keywords.set ("extern", CodeTokenType.TYPE);
			c_keywords.set ("int", CodeTokenType.TYPE);
			c_keywords.set ("float", CodeTokenType.TYPE);
			c_keywords.set ("long", CodeTokenType.TYPE);
			c_keywords.set ("register", CodeTokenType.TYPE);
			c_keywords.set ("short", CodeTokenType.TYPE);
			c_keywords.set ("signed", CodeTokenType.TYPE);
			c_keywords.set ("static", CodeTokenType.TYPE);
			c_keywords.set ("unsigned", CodeTokenType.TYPE);
			c_keywords.set ("void", CodeTokenType.TYPE);
			c_keywords.set ("volatile", CodeTokenType.TYPE);

			c_keywords.set ("gboolean", CodeTokenType.TYPE);
			c_keywords.set ("gpointer", CodeTokenType.TYPE);
			c_keywords.set ("gconstpointer", CodeTokenType.TYPE);
			c_keywords.set ("gchar", CodeTokenType.TYPE);
			c_keywords.set ("guchar", CodeTokenType.TYPE);
			c_keywords.set ("gint", CodeTokenType.TYPE);
			c_keywords.set ("guint", CodeTokenType.TYPE);
			c_keywords.set ("gshort", CodeTokenType.TYPE);
			c_keywords.set ("gushort", CodeTokenType.TYPE);
			c_keywords.set ("glong", CodeTokenType.TYPE);
			c_keywords.set ("gulong", CodeTokenType.TYPE);
			c_keywords.set ("gint8", CodeTokenType.TYPE);
			c_keywords.set ("guint8", CodeTokenType.TYPE);
			c_keywords.set ("gint16", CodeTokenType.TYPE);
			c_keywords.set ("guint16", CodeTokenType.TYPE);
			c_keywords.set ("gint32", CodeTokenType.TYPE);
			c_keywords.set ("guint32", CodeTokenType.TYPE);
			c_keywords.set ("gint64", CodeTokenType.TYPE);
			c_keywords.set ("guint64", CodeTokenType.TYPE);
			c_keywords.set ("gfloat", CodeTokenType.TYPE);
			c_keywords.set ("gdouble", CodeTokenType.TYPE);
			c_keywords.set ("gsize", CodeTokenType.TYPE);
			c_keywords.set ("gssize", CodeTokenType.TYPE);
			c_keywords.set ("goffset", CodeTokenType.TYPE);
			c_keywords.set ("gintptr", CodeTokenType.TYPE);
			c_keywords.set ("guintptr", CodeTokenType.TYPE);


			// ** Literals: **
			c_keywords.set ("NULL", CodeTokenType.LITERAL);
			c_keywords.set ("TRUE", CodeTokenType.LITERAL);
			c_keywords.set ("FALSE", CodeTokenType.LITERAL);


			// ** Keywords: **
			c_keywords.set ("break", CodeTokenType.KEYWORD);
			c_keywords.set ("case", CodeTokenType.KEYWORD);
			c_keywords.set ("continue", CodeTokenType.KEYWORD);
			c_keywords.set ("default", CodeTokenType.KEYWORD);
			c_keywords.set ("do", CodeTokenType.KEYWORD);
			c_keywords.set ("else", CodeTokenType.KEYWORD);
			c_keywords.set ("enum", CodeTokenType.KEYWORD);
			c_keywords.set ("for", CodeTokenType.KEYWORD);
			c_keywords.set ("goto", CodeTokenType.KEYWORD);
			c_keywords.set ("if", CodeTokenType.KEYWORD);
			c_keywords.set ("return", CodeTokenType.KEYWORD);
			c_keywords.set ("sizeof", CodeTokenType.KEYWORD);
			c_keywords.set ("struct", CodeTokenType.KEYWORD);
			c_keywords.set ("switch", CodeTokenType.KEYWORD);
			c_keywords.set ("typedef", CodeTokenType.KEYWORD);
			c_keywords.set ("union", CodeTokenType.KEYWORD);
			c_keywords.set ("while", CodeTokenType.KEYWORD);
			c_keywords.set ("assert", CodeTokenType.KEYWORD);
		}

		bool enable_string_templates = false;
		bool enable_preprocessor_define = true;
		bool enable_preprocessor_include = true;
		bool enable_keyword_escape = false;
		bool enabel_verbatim_string = false;

		CodeScanner scanner = new CodeScanner (source_code, enable_string_templates, enabel_verbatim_string,
			enable_preprocessor_define, enable_preprocessor_include, enable_keyword_escape,
			c_keywords);

		return highlight_code (scanner);
	}

	/**
	 * Used to highlight C source code.
	 */
	public Run highlight_xml (string source_code) {
		XmlScanner scanner = new XmlScanner (source_code);
		return highlight_code (scanner);
	}

	/**
	 * Used to highlight source code.
	 */
	private Run highlight_code (Scanner scanner) {
		Run code = new Run (Run.Style.MONOSPACED);

		for (CodeToken token = scanner.next (); token.token_type != CodeTokenType.EOF; token = scanner.next ()) {
			switch (token.token_type) {
			case CodeTokenType.PREPROCESSOR:
				Run run = new Run (Run.Style.LANG_PREPROCESSOR);
				run.content.add (new Text (token.content));
				code.content.add (run);
				break;

			case CodeTokenType.COMMENT:
				Run run = new Run (Run.Style.LANG_COMMENT);
				run.content.add (new Text (token.content));
				code.content.add (run);
				break;

			case CodeTokenType.KEYWORD:
				Run run = new Run (Run.Style.LANG_KEYWORD);
				run.content.add (new Text (token.content));
				code.content.add (run);
				break;

			case CodeTokenType.LITERAL:
				Run run = new Run (Run.Style.LANG_LITERAL);
				run.content.add (new Text (token.content));
				code.content.add (run);
				break;

			case CodeTokenType.TYPE:
				Run run = new Run (Run.Style.LANG_BASIC_TYPE);
				run.content.add (new Text (token.content));
				code.content.add (run);
				break;

			case CodeTokenType.ESCAPE:
				Run run = new Run (Run.Style.LANG_ESCAPE);
				run.content.add (new Text (token.content));
				code.content.add (run);
				break;

			case CodeTokenType.XML_ESCAPE:
				Run run = new Run (Run.Style.XML_ESCAPE);
				run.content.add (new Text (token.content));
				code.content.add (run);
				break;

			case CodeTokenType.XML_ELEMENT:
				Run run = new Run (Run.Style.XML_ELEMENT);
				run.content.add (new Text (token.content));
				code.content.add (run);
				break;

			case CodeTokenType.XML_ATTRIBUTE:
				Run run = new Run (Run.Style.XML_ATTRIBUTE);
				run.content.add (new Text (token.content));
				code.content.add (run);
				break;

			case CodeTokenType.XML_ATTRIBUTE_VALUE:
				Run run = new Run (Run.Style.XML_ATTRIBUTE_VALUE);
				run.content.add (new Text (token.content));
				code.content.add (run);
				break;

			case CodeTokenType.XML_COMMENT:
				Run run = new Run (Run.Style.XML_COMMENT);
				run.content.add (new Text (token.content));
				code.content.add (run);
				break;

			case CodeTokenType.XML_CDATA:
				Run run = new Run (Run.Style.XML_CDATA);
				run.content.add (new Text (token.content));
				code.content.add (run);
				break;

			default:
				code.content.add (new Text (token.content));
				break;
			}
		}

		return code;
	}
}


