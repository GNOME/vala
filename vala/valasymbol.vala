/* valasymbol.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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

/**
 * Represents a node in the symbol tree.
 */
public abstract class Vala.Symbol : CodeNode {
	/**
	 * The parent of this symbol.
	 */
	public weak Symbol? parent_symbol {
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
	public string? name { get; set; }

	/**
	 * Specifies whether this symbol is active.
	 *
	 * Symbols may become inactive when they only apply to a part of a
	 * scope. This is used for local variables not declared at the beginning
	 * of the block to determine which variables need to be freed before
	 * jump statements.
	 */
	public bool active { get; set; default = true; }

	/**
	 * Specifies whether this symbol has been deprecated.
	 */
	public bool deprecated {
		get {
			if (_deprecated == null) {
				_deprecated = get_attribute ("Deprecated") != null;
			}
			return _deprecated;
		}
		set {
			_deprecated = value;
			set_attribute ("Deprecated", _deprecated);
		}
	}

	/**
	 * Specifies what version this symbol has been deprecated since.
	 */
	public string? deprecated_since {
		owned get {
			return get_attribute_string ("Deprecated", "since");
		}
		set {
			set_attribute_string ("Deprecated", "since", value);
		}
	}

	/**
	 * Specifies the replacement if this symbol has been deprecated.
	 */
	public string? replacement {
		owned get {
			return get_attribute_string ("Deprecated", "replacement");
		}
		set {
			set_attribute_string ("Deprecated", "replacement", value);
		}
	}

	/**
	 * Specifies whether this symbol is experimental.
	 */
	public bool experimental {
		get {
			if (_experimental == null) {
				_experimental = get_attribute ("Experimental") != null;
			}
			return _experimental;
		}
		set {
			_experimental = value;
			set_attribute ("Experimental", value);
		}
	}

	/**
	 * Specifies whether this symbol has been accessed.
	 */
	public bool used { get; set; }

	/**
	 * Specifies the accessibility of this symbol. Public accessibility
	 * doesn't limit access. Default accessibility limits access to this
	 * program or library. Private accessibility limits access to instances
	 * of the contained type.
	 */
	public SymbolAccessibility access { get; set; }

	public Comment? comment { get; set; }

	/**
	 * Specifies whether this method explicitly hides a member of a base
	 * type.
	 */
	public bool hides { get; set; }

	/**
	 * Check if this symbol is just internal API (and therefore doesn't need 
	 * to be listed in header files for instance) by traversing parent symbols
	 * and checking their accessibility.
	 */
	public bool is_internal_symbol () {
		if (!external && external_package) {
			// non-external symbols in VAPI files are internal symbols
			return true;
		}

		for (Symbol sym = this; null != sym; sym = sym.parent_symbol) {
			if (sym.access == SymbolAccessibility.PRIVATE
			    || sym.access == SymbolAccessibility.INTERNAL) {
				return true;
			}
		}

		return false;
	}

	public bool is_private_symbol () {
		if (!external && external_package) {
			// non-external symbols in VAPI files are private symbols
			return true;
		}

		for (Symbol sym = this; null != sym; sym = sym.parent_symbol) {
			if (sym.access == SymbolAccessibility.PRIVATE) {
				return true;
			}
		}

		return false;
	}

	public Scope scope {
		get { return _scope; }
	}

	/**
	 * Specifies whether the implementation is external, for example in
	 * a separate C source file or in an external library.
	 */
	public bool external { get; set; }

	/**
	 * Specifies whether the implementation is in an external library.
	 */
	public bool external_package {
		get {
			return source_type == SourceFileType.PACKAGE;
		}
	}

	/**
	 * Specifies whether the implementation came from the commandline.
	 */
	public bool from_commandline {
		get {
			if (source_reference != null) {
				return source_reference.file.from_commandline;
			} else {
				return false;
			}
		}
	}

	/**
	 * Gets the SourceFileType of the source file that this symbol
	 * came from, or SourceFileType.NONE.
	 */
	public SourceFileType source_type {
		get {
			if (source_reference != null) {
				return source_reference.file.file_type;
			} else {
				return SourceFileType.NONE;
			}
		}
	}

	private weak Scope _owner;
	private Scope _scope;
	private bool? _deprecated;
	private bool? _experimental;

	public Symbol (string? name, SourceReference? source_reference, Comment? comment = null) {
		this.name = name;
		this.source_reference = source_reference;
		this.comment = comment;
		_scope = new Scope (this);
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

		if (name.has_prefix (".")) {
			return "%s%s".printf (parent_symbol.get_full_name (), name);
		} else {
			return "%s.%s".printf (parent_symbol.get_full_name (), name);
		}
	}
	
	/**
	 * Converts a string from CamelCase to lower_case.
	 *
	 * @param camel_case a string in camel case
	 * @return           the specified string converted to lower case
	 */
	public static string camel_case_to_lower_case (string camel_case) {
		if ("_" in camel_case) {
			// do not insert additional underscores if input is not real camel case
			return camel_case.down ();
		}

		var result_builder = new StringBuilder ("");

		weak string i = camel_case;

		bool first = true;
		while (i.length > 0) {
			unichar c = i.get_char ();
			if (c.isupper () && !first) {
				/* current character is upper case and
				 * we're not at the beginning */
				weak string t = i.prev_char ();
				bool prev_upper = t.get_char ().isupper ();
				t = i.next_char ();
				bool next_upper = t.get_char ().isupper ();
				if (!prev_upper || (i.length >= 2 && !next_upper)) {
					/* previous character wasn't upper case or
					 * next character isn't upper case*/
					long len = result_builder.str.length;
					if (len != 1 && result_builder.str.get_char (len - 2) != '_') {
						/* we're not creating 1 character words */
						result_builder.append_c ('_');
					}
				}
			}
			
			result_builder.append_unichar (c.tolower ());
			
			first = false;
			i = i.next_char ();
		}
		
		return result_builder.str;
	}

	/**
	 * Converts a string from lower_case to CamelCase.
	 *
	 * @param lower_case a string in lower case
	 * @return           the specified string converted to camel case
	 */
	public static string lower_case_to_camel_case (string lower_case) {
		var result_builder = new StringBuilder ("");

		weak string i = lower_case;

		bool last_underscore = true;
		while (i.length > 0) {
			unichar c = i.get_char ();
			if (c == '_') {
				last_underscore = true;
			} else if (c.isupper ()) {
				// original string is not lower_case, don't apply transformation
				return lower_case;
			} else if (last_underscore) {
				result_builder.append_unichar (c.toupper ());
				last_underscore = false;
			} else {
				result_builder.append_unichar (c);
			}
			
			i = i.next_char ();
		}

		return result_builder.str;
	}

	// get the top scope from where this symbol is still accessible
	public Scope? get_top_accessible_scope (bool is_internal = false) {
		if (access == SymbolAccessibility.PRIVATE) {
			// private symbols are accessible within the scope where the symbol has been declared
			return owner;
		}

		if (access == SymbolAccessibility.INTERNAL) {
			is_internal = true;
		}

		if (parent_symbol == null) {
			// this is the root symbol
			if (is_internal) {
				// only accessible within the same library
				// return root scope
				return scope;
			} else {
				// unlimited access
				return null;
			}
		}

		// if this is a public symbol, it's equally accessible as the parent symbol
		return parent_symbol.get_top_accessible_scope (is_internal);
	}

	public virtual bool is_instance_member () {
		bool instance = true;
		if (this is Field) {
			var f = (Field) this;
			instance = (f.binding == MemberBinding.INSTANCE);
		} else if (this is Method) {
			var m = (Method) this;
			if (!(m is CreationMethod)) {
				instance = (m.binding == MemberBinding.INSTANCE);
			}
		} else if (this is Property) {
			var prop = (Property) this;
			instance = (prop.binding == MemberBinding.INSTANCE);
		} else if (this is EnumValue) {
			instance = false;
		} else if (this is ErrorCode) {
			instance = false;
		}

		return instance;
	}

	public virtual bool is_class_member () {
		bool isclass = true;
		if (this is Field) {
			var f = (Field) this;
			isclass = (f.binding == MemberBinding.CLASS);
		} else if (this is Method) {
			var m = (Method) this;
			if (!(m is CreationMethod)) {
				isclass = (m.binding == MemberBinding.CLASS);
			}
		} else if (this is Property) {
			var prop = (Property) this;
			isclass = (prop.binding == MemberBinding.CLASS);
		} else if (this is EnumValue) {
			isclass = false;
		} else if (this is ErrorCode) {
			isclass = false;
		}

		return isclass;
	}

	/**
	 * Check to see if the symbol has been deprecated, and emit a warning
	 * if it has.
	 */
	public bool check_deprecated (SourceReference? source_ref = null) {
		if (external_package && deprecated) {
			if (!CodeContext.get ().deprecated) {
				Report.deprecated (source_ref, "%s %s%s".printf (get_full_name (), (deprecated_since == null) ? "is deprecated" : "has been deprecated since %s".printf (deprecated_since), (replacement == null) ? "" : ". Use %s".printf (replacement)));
			}
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Check to see if the symbol is experimental, and emit a warning
	 * if it is.
	 */
	public bool check_experimental (SourceReference? source_ref = null) {
		if (external_package && experimental) {
			if (!CodeContext.get ().experimental) {
				Report.experimental (source_ref, "%s is experimental".printf (get_full_name ()));
			}
			return true;
		} else {
			return false;
		}
	}

	public Symbol? get_hidden_member () {
		Symbol sym = null;

		if (parent_symbol is Class) {
			var cl = ((Class) parent_symbol).base_class;
			while (cl != null) {
				sym = cl.scope.lookup (name);
				if (sym != null && sym.access != SymbolAccessibility.PRIVATE) {
					return sym;
				}
				cl = cl.base_class;
			}
		} else if (parent_symbol is Struct) {
			var st = ((Struct) parent_symbol).base_struct;
			while (st != null) {
				sym = st.scope.lookup (name);
				if (sym != null && sym.access != SymbolAccessibility.PRIVATE) {
					return sym;
				}
				st = st.base_struct;
			}
		}

		return null;
	}

	// check whether this symbol is at least as accessible as the specified symbol
	public  bool is_accessible (Symbol sym) {
		Scope sym_scope = sym.get_top_accessible_scope ();
		Scope this_scope = this.get_top_accessible_scope ();
		if ((sym_scope == null && this_scope != null)
		    || (sym_scope != null && !sym_scope.is_subscope_of (this_scope))) {
			return false;
		}

		return true;
	}

	public virtual void add_namespace (Namespace ns) {
		Report.error (ns.source_reference, "unexpected declaration");
	}

	public virtual void add_class (Class cl) {
		Report.error (cl.source_reference, "unexpected declaration");
	}

	public virtual void add_interface (Interface iface) {
		Report.error (iface.source_reference, "unexpected declaration");
	}

	public virtual void add_struct (Struct st) {
		Report.error (st.source_reference, "unexpected declaration");
	}

	public virtual void add_enum (Enum en) {
		Report.error (en.source_reference, "unexpected declaration");
	}

	public virtual void add_error_domain (ErrorDomain edomain) {
		Report.error (edomain.source_reference, "unexpected declaration");
	}

	public virtual void add_delegate (Delegate d) {
		Report.error (d.source_reference, "unexpected declaration");
	}

	public virtual void add_constant (Constant constant) {
		Report.error (constant.source_reference, "unexpected declaration");
	}

	public virtual void add_field (Field f) {
		Report.error (f.source_reference, "unexpected declaration");
	}

	public virtual void add_method (Method m) {
		Report.error (m.source_reference, "unexpected declaration");
	}

	public virtual void add_property (Property prop) {
		Report.error (prop.source_reference, "unexpected declaration");
	}

	public virtual void add_signal (Signal sig) {
		Report.error (sig.source_reference, "unexpected declaration");
	}

	public virtual void add_constructor (Constructor c) {
		Report.error (c.source_reference, "unexpected declaration");
	}

	public virtual void add_destructor (Destructor d) {
		Report.error (d.source_reference, "unexpected declaration");
	}
}

public enum Vala.SymbolAccessibility {
	PRIVATE,
	INTERNAL,
	PROTECTED,
	PUBLIC
}

public enum Vala.MemberBinding {
	INSTANCE,
	CLASS,
	STATIC
}
