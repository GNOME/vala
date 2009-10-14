/* apisymbolnode.vala
 * 
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using Vala;
using Gee;

public abstract class Valadoc.Api.SymbolNode : Api.Node, SymbolAccessibility {

	protected Vala.Symbol symbol { private set; get; }
	// TODO Drop DocumentedElement
	/* protected Vala.Comment vcomment { private set; get; } */

	public override string? name {
		owned get {
			return symbol.name;
		}
	}

	public SymbolNode (Settings settings, Vala.Symbol symbol, Api.Node parent, Tree root) {
		base (settings, parent, root);
		this.symbol = symbol;
	}

	public override string? get_filename () {
		SourceReference? sref = symbol.source_reference;
		if ( sref == null )
			return null;

		Vala.SourceFile? file = sref.file;
		if ( file == null )
			return null;

		string path = sref.file.filename;
		return GLib.Path.get_basename ( path );
	}

	protected override bool is_type_visitor_accessible (Valadoc.Basic element) {
		if (!this.settings._private && is_private)
			return false;

		if (!this.settings._internal && is_internal)
			return false;

		if (!this.settings._protected && is_protected)
			return false;

		if (this.parent != element && !this.settings.add_inherited)
				return false;

		return true;
	}

	public override bool is_visitor_accessible () {
		if (!this.settings._private && this.is_private)
			return false;

		if (!this.settings._internal && this.is_internal)
			return false;

		if (!this.settings._protected && this.is_protected)
			return false;

		return true;
	}

	public bool is_public {
		get {
			return symbol.access == Vala.SymbolAccessibility.PUBLIC;
		}
	}

	public bool is_protected {
		get {
			return symbol.access == Vala.SymbolAccessibility.PROTECTED;
		}
	}

	public bool is_internal {
		get {
			return symbol.access == Vala.SymbolAccessibility.INTERNAL;
		}
	}

	public bool is_private {
		get {
			return symbol.access == Vala.SymbolAccessibility.PRIVATE;
		}
	}
}
