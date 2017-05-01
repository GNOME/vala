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

public class Valadate.TestAssembly : TestModule {

	public File srcdir { get; private set; }
	public File builddir { get; private set; }

	public TestConfig config { get; private set; }

	public TestAssembly (string[] args) throws Error {
		base (File.new_for_path (args[0]));
		config = new TestConfig (args);
		
		if (config.testpath != null)
			Environment.set_variable ("V_TESTPATH", config.testpath, true);
		if (config.running_test != null)
			Environment.set_variable ("V_RUNNING_TEST", config.running_test, true);
	
		setup_dirs ();
	}

	private TestAssembly.copy (TestAssembly other) throws Error {
		base (other.binary);
		config = other.config;
	}

	private void setup_dirs () throws Error {
		var buildstr = Environment.get_variable ("G_TEST_BUILDDIR");

		if (buildstr == null) {
			builddir = binary.get_parent ();
			if (builddir.get_basename () == ".libs")
				builddir = builddir.get_parent ();
		} else {
			builddir = File.new_for_path (buildstr);
		}

		var srcstr = Environment.get_variable ("G_TEST_SRCDIR");

		if (srcstr == null) {
			// we're running outside the test harness
			// check for buildir!=srcdir
			// this currently on checks for autotools
			if (!builddir.get_child ("Makefile.in").query_exists ()) {
				// check for Makefile in builddir and extract VPATH
				var makefile = builddir.get_child ("Makefile");
				if (makefile.query_exists ()) {
					var reader = new DataInputStream (makefile.read ());
					var line = reader.read_line ();
					while (line!= null) {
						if (line.has_prefix ("VPATH = ")) {
							srcstr = Path.build_path (Path.DIR_SEPARATOR_S, builddir.get_path (), line.split (" = ")[1]);
							break;
						}
						line = reader.read_line ();
					}
				}
			}
		}

		if (srcstr == null)
			srcdir = builddir;
		else
			srcdir = File.new_for_path (srcstr);

		var mesondir = srcdir.get_child (Path.get_basename (binary.get_path ()) + "@exe");

		if (mesondir.query_exists ())
			srcdir = mesondir;

		Environment.set_variable ("G_TEST_BUILDDIR", builddir.get_path (), true);
		Environment.set_variable ("G_TEST_SRCDIR", srcdir.get_path (), true);

	}

	public override Assembly clone () throws Error {
		return new TestAssembly.copy (this);
	}
}
