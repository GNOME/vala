/* symbol.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
 * Copyright (C) 2011      Florian Brosch
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

	public Symbol (Node parent, SourceFile file, string? name, SymbolAccessibility accessibility, void* data) {
		base (parent, file, name, data);

		this.accessibility = accessibility;
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

	public SymbolAccessibility accessibility {
		private set;
		get;
	}

	/**
	 * Specifies whether this symbol is public.
	 */
	public bool is_public {
		get {
			return accessibility == SymbolAccessibility.PUBLIC;
		}
	}

	/**
	 * Specifies whether this symbol is protected.
	 */
	public bool is_protected {
		get {
			return accessibility == SymbolAccessibility.PROTECTED;
		}
	}

	/**
	 * Specifies whether this symbol is internal.
	 */
	public bool is_internal {
		get {
			return accessibility == SymbolAccessibility.INTERNAL;
		}
	}

	/**
	 * Specifies whether this symbol is private.
	 */
	public bool is_private {
		get {
			return accessibility == SymbolAccessibility.PRIVATE;
		}
	}

	/**
	 * Returns the accessibility modifier as string
	 *
	 * @deprecated
	 */
	//TODO: rm
	protected string get_accessibility_modifier () {
		return accessibility.to_string ();
	}
}

