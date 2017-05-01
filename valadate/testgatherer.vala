/*
 * Valadate - Unit testing library for GObject-based libraries.
 * Copyright (C) 2016  Chris Daley <chebizarro@gmail.com>
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
 * Authors:
 * 	Chris Daley <chebizarro@gmail.com>
 */

public class Valadate.TestGatherer : Vala.CodeVisitor {

	public HashTable<Type, Vala.Class> classes =
		new HashTable<Type, Vala.Class> (direct_hash, direct_equal);

	private TestAssembly assembly;

	public TestGatherer (TestAssembly assembly) {
		this.assembly = assembly;
	}

	public override void visit_namespace (Vala.Namespace ns) {
		ns.accept_children (this);
	}

	public override void visit_class (Vala.Class cls) {
		try {
			var classtype = find_type (cls);
			if (classtype.is_a (typeof (TestCase)) || classtype.is_a (typeof (TestSuite)))
				classes.insert (classtype, cls);
		} catch (Error e) {
			warning (e.message);
		}
		cls.accept_children (this);
	}

	private Type find_type (Vala.Class cls) throws Error {
		unowned TestPlan.GetType node_get_type = (TestPlan.GetType)assembly.get_method ("%sget_type".printf (get_ccode_lower_case_prefix (cls)));
		var ctype = node_get_type ();
		return ctype;
	}

	private string get_ccode_lower_case_prefix (Vala.Symbol sym) {
		var ccode = sym.get_attribute ("CCode");
		string _lower_case_prefix = null;

		if (ccode != null) {
			_lower_case_prefix = ccode.get_string ("lower_case_cprefix");
			if (_lower_case_prefix == null && (sym is Vala.ObjectTypeSymbol)) {
				_lower_case_prefix = ccode.get_string ("cprefix");
			}
		}
		if (_lower_case_prefix == null) {
			if (sym is Vala.Namespace) {
				if (sym.name == null) {
					_lower_case_prefix = "";
				} else {
					_lower_case_prefix = "%s%s_".printf (get_ccode_lower_case_prefix (sym.parent_symbol), Vala.Symbol.camel_case_to_lower_case (sym.name));
				}
			} else if (sym is Vala.Method) {
				// for lambda expressions
				_lower_case_prefix = "";
			} else {
				_lower_case_prefix = "%s%s_".printf (get_ccode_lower_case_prefix (sym.parent_symbol), get_ccode_lower_case_suffix (sym));
			}
		}
		return _lower_case_prefix;
	}

	private string get_ccode_lower_case_suffix (Vala.Symbol sym) {
		var ccode = sym.get_attribute ("CCode");
		string _lower_case_suffix = null;

		if (ccode != null) {
			_lower_case_suffix = ccode.get_string ("lower_case_csuffix");
		}
		if (_lower_case_suffix == null) {
			if (sym is Vala.ObjectTypeSymbol) {
				var csuffix = Vala.Symbol.camel_case_to_lower_case (sym.name);
				// remove underscores in some cases to avoid conflicts of type macros
				if (csuffix.has_prefix ("type_")) {
					csuffix = "type" + csuffix.substring ("type_".length);
				} else if (csuffix.has_prefix ("is_")) {
					csuffix = "is" + csuffix.substring ("is_".length);
				}
				if (csuffix.has_suffix ("_class")) {
					csuffix = csuffix.substring (0, csuffix.length - "_class".length) + "class";
				}
				_lower_case_suffix = csuffix;
			} else if (sym.name != null) {
				_lower_case_suffix = Vala.Symbol.camel_case_to_lower_case (sym.name);
			}
		}
		return _lower_case_suffix;
	}
}
