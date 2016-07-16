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
 
/**
 * The TestResultFactory is a singleton Factory class
 * for registered TestResult classes
 */
public class Valadate.TestResultFactory : Object {

	private static TestResultFactory instance;

	private HashTable<string, Type> result_types =
		new HashTable<string, Type> (str_hash, str_equal);


	private TestResultFactory() {
		result_types.set("tap",typeof(TAPResult));
	}
	
	public static TestResultFactory get_instance() {
		if(instance == null)
			instance = new TestResultFactory();
		return instance;
	}

	public void add_result_type(string type, Type class)
		requires(class.is_a(typeof(TestResult)))
	{
		result_types.set(type, class);
	}

	public TestResult? new_for_type(string type) {
		if(result_types.contains(type)) {
			Type t = result_types.get(type);
			return Object.new(t) as TestResult;
		}
		return null;
	}

}
