/* signaturebuilder.vala
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


using Valadoc.Content;

/**
 * Builds up a signature from the given items.
 */
public class Valadoc.Api.SignatureBuilder {
	private Run run;
	private Inline last_appended;

	/**
	 * Creates a new SignatureBuilder
	 */
	public SignatureBuilder () {
		run = new Run (Run.Style.NONE);
	}

	private void append_text (string text) {
		if (last_appended is Text) {
			((Text) last_appended).content += text;
		} else {
			run.content.add (last_appended = new Text (text));
		}
	}

	/**
	 * Adds text onto the end of the builder.
	 *
	 * @param text a string
	 * @param spaced add a space at the front of the string if necessary
	 * @return this
	 */
	public unowned SignatureBuilder append (string text, bool spaced = true) {
		string content = (last_appended != null && spaced ? " " : "") + text;
		append_text (content);
		return this;
	}

	/**
	 * Adds text onto the end of the builder.
	 *
	 * @param text a string
	 * @param spaced add a space at the front of the string if necessary
	 * @return this
	 */
	public unowned SignatureBuilder append_attribute (string text, bool spaced = true) {
		string content = (last_appended != null && spaced ? " " : "") + text;
		append_text (content);
		return this;
	}

	/**
	 * Adds highlighted text onto the end of the builder.
	 *
	 * @param text a string
	 * @param spaced add a space at the front of the string if necessary
	 * @return this
	 */
	public unowned SignatureBuilder append_highlighted (string text, bool spaced = true) {
		string content = (last_appended != null && spaced ? " " : "") + text;
		Run inner = new Run (Run.Style.ITALIC);
		inner.content.add (new Text (content));
		return append_content (inner, spaced);
	}

	/**
	 * Adds a Inline onto the end of the builder.
	 *
	 * @param content a content
	 * @param spaced add a space at the front of the inline if necessary
	 * @return this
	 */
	public unowned SignatureBuilder append_content (Inline content, bool spaced = true) {
		if (last_appended != null && spaced) {
			append_text (" ");
		}
		run.content.add (last_appended = content);
		return this;
	}

	/**
	 * Adds a keyword onto the end of the builder.
	 *
	 * @param keyword a keyword
	 * @param spaced add a space at the front of the keyword if necessary
	 * @return this
	 */
	public unowned SignatureBuilder append_keyword (string keyword, bool spaced = true) {
		Run inner = new Run (Run.Style.LANG_KEYWORD);
		inner.content.add (new Text (keyword));
		return append_content (inner, spaced);
	}

	/**
	 * Adds a symbol onto the end of the builder.
	 *
	 * @param node a node
	 * @param spaced add a space at the front of the node if necessary
	 * @return this
	 */
	public unowned SignatureBuilder append_symbol (Node node, bool spaced = true) {
		Run inner = new Run (Run.Style.BOLD);
		inner.content.add (new SymbolLink (node, node.name));
		return append_content (inner, spaced);
	}

	/**
	 * Adds a type onto the end of the builder.
	 *
	 * @param node a node
	 * @param spaced add a space at the front of the node if necessary
	 * @return this
	 */
	public unowned SignatureBuilder append_type (Node node, bool spaced = true) {
		Run.Style style = Run.Style.LANG_TYPE;
		if (node is TypeSymbol && ((TypeSymbol)node).is_basic_type) {
			style = Run.Style.LANG_BASIC_TYPE;
		}

		Run inner = new Run (style);
		inner.content.add (new SymbolLink (node, node.name));
		return append_content (inner, spaced);
	}

	/**
	 * Adds a type name onto the end of the builder.
	 *
	 * @param name a type name
	 * @param spaced add a space at the front of the type name if necessary
	 * @return this
	 */
	public unowned SignatureBuilder append_type_name (string name, bool spaced = true) {
		Run inner = new Run (Run.Style.LANG_TYPE);
		inner.content.add (new Text (name));
		return append_content (inner, spaced);
	}

	/**
	 * Adds a literal onto the end of the builder.
	 *
	 * @param literal a literal
	 * @param spaced add a space at the front of the literal if necessary
	 * @return this
	 */
	public unowned SignatureBuilder append_literal (string literal, bool spaced = true) {
		Run inner = new Run (Run.Style.LANG_LITERAL);
		inner.content.add (new Text (literal));
		return append_content (inner, spaced);
	}

	/**
	 * The content
	 */
	public new Run get () {
		return run;
	}
}

