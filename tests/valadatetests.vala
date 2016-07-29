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
 
public class Valadate.Tests.TestFixture : Valadate.TestCase {
	
	public void test_testcase() {
		
		bug_base = "http://bugzilla.gnome.org/";
		
		bug("555666");
		
		stdout.puts("This is a test of the system");
	}

	public void test_testcase_1() {
		message("This is a test of the system");
		//skip("Because it broke");
		//fail("No particular reason");
	}

	public void test_testcase_2() {
		debug("This is a second test of the system");
		message(Valadate.get_current_test_path());
		skip("No reason");
	}

	public void test_testcase_3() {
		
		//stdout.puts("Before");
		//assert(false);
		//fail("after");
		
		void* nullisland = null;
		
		Object nullobj = nullisland as Object;
		
		//nullobj.get_type().name();
		
	}
	
}

public class Valadate.Tests.TestFixtureTwo : Valadate.TestCase {

	public void test_testcase() {
		
		bug_base = "http://bugzilla.gnome.org/";
		
		bug("555999");
		
		stdout.puts("This is a test of the system");
	}

}
