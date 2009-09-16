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


public interface Valadoc.SymbolAccessibility : Basic {
	public bool is_public {
		get {
			Vala.SymbolAccessibility access = vsymbol.access;
			return ( access == Vala.SymbolAccessibility.PUBLIC );
		}
	}

	public bool is_protected {
		get {
			Vala.SymbolAccessibility access = vsymbol.access;
			return (access == Vala.SymbolAccessibility.PROTECTED);
		}
	}

	public bool is_internal {
		get {
			Vala.SymbolAccessibility access = vsymbol.access;
			return (access == Vala.SymbolAccessibility.INTERNAL);
		}
	}

	public bool is_private {
		get {
			Vala.SymbolAccessibility access = vsymbol.access;
			return (access == Vala.SymbolAccessibility.PRIVATE);
		}
	}
}

