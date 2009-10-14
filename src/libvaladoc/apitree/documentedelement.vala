/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
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
 */


using Vala;
using GLib;
using Gee;


public abstract class Valadoc.DocumentedElement : Basic, Documentation {
	private Namespace? _nspace = null;
	private Package? _package = null;
	private string _full_name = null;
	private int _line = -1;

	public abstract string? name { owned get; }

	public Namespace? nspace {
		get {
			if (this._nspace == null) {
				Valadoc.Basic ast = this;
				while (ast is Valadoc.Namespace == false) {
					ast = ast.parent;
					if (ast == null)
						return null;
				}
				this._nspace = (Valadoc.Namespace)ast;
			}
			return this._nspace;
		}
	}


	public Package? package {
		get {
			if (this._package == null) {
				Valadoc.Basic ast = this;
				while (ast is Valadoc.Package == false) {
					ast = ast.parent;
					if (ast == null)
						return null;
				}
				this._package = (Valadoc.Package)ast;
			}
			return this._package;
		}
	}
/*
	public int line {
		get {
			if (this._line == -1) {
				Vala.SourceReference vsref = this.vsymbol.source_reference;
				this._line = (vsref == null)? 0 : vsref.first_line;
			}
			return this._line;
		}
	}
*/

	public Content.Comment? documentation {
		protected set;
		get;
	}

	// rename to get_full_name
	public string? full_name () {
		if (this._full_name == null) {
			if (this.name == null)
				return null;

			GLib.StringBuilder full_name = new GLib.StringBuilder (this.name);

			if (this.parent != null) {
				for (Basic pos = this.parent; pos is Package == false ; pos = pos.parent) {
					string name = ((DocumentedElement)pos).name;
					if (name != null) {
						full_name.prepend_unichar ('.');
						full_name.prepend (name);
					}
				}
			}
			this._full_name = full_name.str;
		}
		return this._full_name;
	}

	public abstract string? get_filename ();
}

