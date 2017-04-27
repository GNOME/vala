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
		new HashTable<Type, Vala.Class>(direct_hash, direct_equal);
	
	private TestAssembly assembly;

	public TestGatherer(TestAssembly assembly) {
		this.assembly = assembly;
	}

	public override void visit_namespace(Vala.Namespace ns) {
		ns.accept_children(this);
	}
	
	public override void visit_class(Vala.Class cls) {
		try {
			var classtype = find_type(cls);
			if (classtype.is_a(typeof(TestCase)) || classtype.is_a(typeof(TestSuite)))
				classes.insert(classtype, cls);
		} catch (Error e) {
			warning(e.message);
		}
		cls.accept_children(this);
	}
	
	private Type find_type(Vala.Class cls) throws Error {
		var attr = new Vala.CCodeAttribute (cls);
		unowned TestPlan.GetType node_get_type =
			(TestPlan.GetType)assembly.get_method(
				"%sget_type".printf(attr.lower_case_prefix));
		var ctype = node_get_type();
		return ctype;
	}
}
