/* symbol.vala
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

/**
 * Represents a node in the symbol tree.
 */
public abstract class Valadoc.Api.Symbol : Node {
	/**
	 * The underlining vala symbol
	 */
	internal Vala.Symbol symbol { private set; get; }

	/**
	 * {@inheritDoc}
	 */
	public override string? name {
		owned get {
			return symbol.name;
		}
	}

	public Symbol (Vala.Symbol symbol, Node parent) {
		base (parent);
		this.symbol = symbol;
	}

	/**
	 * {@inheritDoc}
	 */
	public override string? get_filename () {
		Vala.SourceReference? sref = symbol.source_reference;
		if (sref == null) {
			return null;
		}

		Vala.SourceFile? file = sref.file;
		if (file == null) {
			return null;
		}

		string path = sref.file.filename;
		return GLib.Path.get_basename (path);
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool is_browsable (Settings settings) {
		if (!settings._private && this.is_private) {
			return false;
		}
		if (!settings._internal && this.is_internal) {
			return false;
		}
		if (!settings._protected && this.is_protected) {
			return false;
		}
		return true;
	}

	/**
	 * Specifies whether this symbol is public.
	 */
	public virtual bool is_public {
		get {
			return symbol.access == Vala.SymbolAccessibility.PUBLIC;
		}
	}

	/**
	 * Specifies whether this symbol is protected.
	 */
	public virtual bool is_protected {
		get {
			return symbol.access == Vala.SymbolAccessibility.PROTECTED;
		}
	}

	/**
	 * Specifies whether this symbol is internal.
	 */
	public virtual bool is_internal {
		get {
			return symbol.access == Vala.SymbolAccessibility.INTERNAL;
		}
	}

	/**
	 * Specifies whether this symbol is private.
	 */
	public virtual bool is_private {
		get {
			return symbol.access == Vala.SymbolAccessibility.PRIVATE;
		}
	}

	/**
	 * Returns the accessibility modifier as string
	 */
	protected string get_accessibility_modifier () {
		if (is_public) {
			return "public";
		} else if (is_protected) {
			return "protected";
		} else if (is_internal) {
			return "internal";
		} else {
			return "private";
		}
	}

	/**
	 * {@inheritDoc}
	 */
	internal override void resolve_type_references (Tree root) {
		base.resolve_type_references (root);

		foreach (Vala.DataType type in symbol.get_error_types ()) {
			var error_type = type as Vala.ErrorType;
			if (error_type.error_domain == null) {
				add_child (glib_error);
			} else {
				add_child (root.search_vala_symbol (error_type.error_domain));
			}
		}
	}
}

