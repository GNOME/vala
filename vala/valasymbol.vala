/* valasymbol.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;
using Gee;

/**
 * Represents a node in the symbol tree.
 */
public abstract class Vala.Symbol : CodeNode {
	/**
	 * The parent of this symbol.
	 */
	public weak Symbol parent_symbol {
		get {
			if (owner == null) {
				return null;
			} else {
				return owner.owner;
			}
		}
	}

	/**
	 * The scope this symbol opens.
	 */
	public weak Scope owner {
		get {
			return _owner;
		}
		set {
			_owner = value;
			_scope.parent_scope = value;
		}
	}
	
	/**
	 * The symbol name.
	 */
	public string name { get; set; }

	/**
	 * Specifies whether this symbol is active.
	 *
	 * Symbols may become inactive when they only apply to a part of a
	 * scope. This is used for local variables not declared at the beginning
	 * of the block to determine which variables need to be freed before
	 * jump statements.
	 */
	public bool active { get; set; }

	/**
	 * Specifies the accessibility of this symbol. Public accessibility
	 * doesn't limit access. Default accessibility limits access to this
	 * program or library. Private accessibility limits access to instances
	 * of the contained type.
	 */
	public SymbolAccessibility access { get; set; }

	/**
	 * Check if this symbol is just internal API (and therefore doesn't need 
	 * to be listed in header files for instance) by traversing parent symbols
	 * and checking their accessibility.
	 */
	public bool is_internal_symbol () {
		for (Symbol sym = this; null != sym; sym = sym.parent_symbol) {
			if (SymbolAccessibility.PRIVATE == sym.access) {
				return true;
			}
		}

		return false;
	}

	public Scope scope {
		get { return _scope; }
	}
	
	/**
	 * Specifies whether this is an imported symbol e.g. the Import
	 * attribute has been set.
	 */
	public bool is_imported { get; set; }

	private weak Scope _owner;
	private Scope _scope;

	construct {
		_scope = new Scope (this);
		active = true;
	}
	
	/**
	 * Returns the fully expanded name of this symbol for use in
	 * human-readable messages.
	 *
	 * @return full name
	 */
	public string get_full_name () {
		if (parent_symbol == null) {
			return name;
		}
		
		if (name == null) {
			return parent_symbol.get_full_name ();
		}

		if (parent_symbol.get_full_name () == null) {
			return name;
		}
		
		return "%s.%s".printf (parent_symbol.get_full_name (), name);
	}

	/**
	 * Returns the camel case string to be prepended to the name of members
	 * of this symbol when used in C code.
	 *
	 * @return the camel case prefix to be used in C code
	 */
	public virtual string! get_cprefix () {
		if (name == null) {
			return "";
		} else {
			return name;
		}
	}
	
	/**
	 * Returns the C name of this symbol in lower case. Words are
	 * separated by underscores. The lower case C name of the parent symbol
	 * is prefix of the result, if there is one.
	 *
	 * @param infix a string to be placed between namespace and data type
	 *              name or null
	 * @return      the lower case name to be used in C code
	 */
	public virtual string get_lower_case_cname (string infix = null) {
		return null;
	}

	/**
	 * Returns the string to be prefixed to members of this symbol in
	 * lower case when used in C code.
	 *
	 * @return      the lower case prefix to be used in C code
	 */
	public virtual string! get_lower_case_cprefix () {
		return "";
	}

	/**
	 * Returns a list of C header filenames users of this symbol must
	 * include.
	 *
	 * @return list of C header filenames for this symbol
	 */
	public virtual Collection<string> get_cheader_filenames () {
		return new ReadOnlyCollection<string> ();
	}

	/**
	 * Converts a string from CamelCase to lower_case.
	 *
	 * @param camel_case a string in camel case
	 * @return           the specified string converted to lower case
	 */
	public static string! camel_case_to_lower_case (string! camel_case) {
		String result = new String ("");

		weak string i = camel_case;

		bool first = true;
		while (i.len () > 0) {
			unichar c = i.get_char ();
			if (c.isupper () && !first) {
				/* current character is upper case and
				 * we're not at the beginning */
				weak string t = i.prev_char ();
				bool prev_upper = t.get_char ().isupper ();
				t = i.next_char ();
				bool next_upper = t.get_char ().isupper ();
				if (!prev_upper || (i.len () >= 2 && !next_upper)) {
					/* previous character wasn't upper case or
					 * next character isn't upper case*/
					long len = result.str.len ();
					if (len != 1 && result.str.offset (len - 2).get_char () != '_') {
						/* we're not creating 1 character words */
						result.append_c ('_');
					}
				}
			}
			
			result.append_unichar (c.tolower ());
			
			first = false;
			i = i.next_char ();
		}
		
		return result.str;
	}
}

public enum Vala.SymbolAccessibility {
	PRIVATE,
	INTERNAL,
	PROTECTED,
	PUBLIC
}

