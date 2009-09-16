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


public class Valadoc.PropertyAccessor : Object {
	private Vala.PropertyAccessor vpropacc;

	public PropertyAccessor ( Valadoc.Settings settings, Vala.PropertyAccessor vpropacc, Property parent, Tree head ) {
		this.settings = settings;
		this.vpropacc = vpropacc;
		this.parent = parent;
		this.head = head;
	}

	public Tree head {
		set;
		get;
	}

	public Settings settings {
		set;
		get;
	}

	public Property parent {
		private set;
		get;
	}

	public Tree tree {
		set;
		get;
	}

	public bool is_construct {
		get {
			return this.vpropacc.construction;
		}
	}

	public bool is_protected {
		get {
			return this.vpropacc.access == Vala.SymbolAccessibility.PROTECTED;
		}
	}

	public bool is_public {
		get {
			return this.vpropacc.access == Vala.SymbolAccessibility.PUBLIC;
		}
	}

	public bool is_private {
		get {
			return this.vpropacc.access == Vala.SymbolAccessibility.PRIVATE;
		}
	}

	public bool is_internal {
		get {
			return this.vpropacc.access == Vala.SymbolAccessibility.INTERNAL;
		}
	}

	public bool is_set {
		get {
			return this.vpropacc.writable;
		}
	}

	public bool is_get {
		get {
			return this.vpropacc.readable;
		}
	}

	public bool is_owned {
		get {
			return this.vpropacc.value_type.value_owned;
		}
	}

	public void write (Langlet langlet, void* ptr) {
		langlet.write_property_accessor (this, ptr);
	}
}
