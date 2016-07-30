/*
 * ValaTestsFactory
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

internal class Vala.TestsFactory : Object {

	internal static File currdir;
	internal static File testdir;
	internal static File buildir;
	internal static File valac;

	class construct {
		currdir = File.new_for_path(GLib.Environment.get_current_dir());
		testdir = currdir.get_child(".tests");
		buildir = currdir.get_parent();
		valac = buildir.get_child("compiler").get_child("valac");
	}

	private static TestsFactory instance;
	public ValaCompiler compiler;

	private Program[] programs = {};
	private File[] tempfiles = {};
	
	public static TestsFactory get_instance() {
		if (instance == null)
			instance = new TestsFactory();
		return instance;
	}

	private TestsFactory() {
		compiler = new ValaCompiler(valac);
	}

	public void cleanup() {
		foreach (var file in tempfiles)
			if(file.query_exists())
				file.delete();

		foreach (var prog in programs)
			prog.cleanup();
	}

	public Program get_test_program(File testfile) throws Error {
		string testname = testfile.get_basename().substring(
			0,testfile.get_basename().last_index_of("."));
		
		Program program = null;
		
		if(testfile.get_basename().has_suffix(".vala") || testfile.get_basename().has_suffix(".gs")) {
			program = compiler.compile(testdir.get_child(testname), testfile, "--main main");
		}
		
		if(testfile.get_basename().has_suffix(".test")) {
			var stream = new DataInputStream(testfile.read());
			
			string line = stream.read_line(null);
			
			string packages = "";
			
			if (line.has_prefix("Packages:")) {
				packages = line.split(":")[1];
				packages = string.joinv(" --pkg ", packages.split(" "));
				line = stream.read_line(null);
			}
			
			switch (line) {
				case "D-Bus":
					program = new DBusTest(testname, packages, stream);
					break;

				case "Invalid Code":
					program = new InvalidCode(testname, packages, stream);
					break;

				case "GIR":
					program = new GIRTestProgram(testname, packages, stream);
					break;
				
				default:
					program = new TestProgram(testdir.get_child(testname));
					break;
			}

		}
		programs += program;
		return program;
	}
	

	public abstract class Program : Object {

		public delegate void CommandCallback(bool err, string buffer);

		public static SubprocessLauncher launcher;

		class construct {
			launcher = new SubprocessLauncher(GLib.SubprocessFlags.STDOUT_PIPE | GLib.SubprocessFlags.STDERR_MERGE);
			launcher.set_cwd(testdir.get_path());
		}
		
		public File program {get; private set;}
		
		public CommandCallback callback {get;set;}
		
		private File[] files = {};
		
		public Program(File program) {
			this.program = program;
			files += program;
			callback = default_callback;
		}
	
		public void add_file(File file) {
			files += file;
		}
	
		private void default_callback(bool err, string buffer) {
			if (err)
				error(buffer);
			else
				stdout.printf ("%s", buffer);
		}
		
		public virtual void run(string? command = null) throws Error {
			string[] args;
			Shell.parse_argv("%s %s".printf(program.get_path(), command ?? ""), out args);
			string buffer = null;
			var process = launcher.spawnv(args);
			process.communicate_utf8(null, null, out buffer, null);

			try {
				if(process.wait_check())
					callback(false, buffer);
			} catch (Error e) {
				callback(true, buffer);
			}
		}
		
		public virtual void cleanup() {
			foreach(File file in files)
				if(file.query_exists())
					file.delete();
		}
	}
	
	public class TestProgram : Program {
		public TestProgram(File program) {
			base(program);
		}

		public void add_file_from_stream(
			File file,
			DataInputStream stream,
			string? start,
			string? end,
			string? header = null,
			string? footer = null) throws Error {
			
				var newfile = file.create(FileCreateFlags.NONE);
				var outstream = new DataOutputStream (newfile);
				string line;
				
				if(header != null)
					outstream.put_string(header + "\n");
				
				if(start != null)
					do {} while ((line = stream.read_line (null)) != start);

				while ((line = stream.read_line (null)) != end)
					outstream.put_string(line + "\n");

				if(footer != null)
					outstream.put_string(footer);
			
				add_file(file);
		}
	}

	public class DBusTest : TestProgram {
		
		private Program server;
		private Program client;
		
		public DBusTest(string testname, string packages, DataInputStream stream) throws Error {
			base(testdir.get_child(testname + ".server"));
			var clientfile = testdir.get_child(testname + ".client.vala");
			var serverfile = testdir.get_child(testname + ".server.vala");
			add_file_from_stream(clientfile, stream, "Program: client", "Program: server");
			add_file_from_stream(serverfile, stream, null, null);
			client = TestsFactory.get_instance().compiler.compile(testdir.get_child(testname + ".client"), clientfile, packages);
			server = TestsFactory.get_instance().compiler.compile(testdir.get_child(testname + ".server"), serverfile, packages);
		}
		
		public override void run(string? command = null) throws Error {
			Bus.watch_name(
				BusType.SESSION,
				"org.example.Test",
				GLib.BusNameWatcherFlags.NONE,
				null,
				(c,n) => {
					this.server.run(command);
				});
		}
		
		public override void cleanup() {
			server.cleanup();
			client.cleanup();
			base.cleanup();
		}
	}
	
	public class InvalidCode : TestProgram {
		
		private File source;
		private ValaCompiler compiler = new ValaCompiler(valac);
		private string packages;
		private Program testprogam;
		
		public InvalidCode(string testname, string packages, DataInputStream stream) throws Error {
			base(testdir.get_child(testname));
			this.packages = packages;
			source = testdir.get_child(testname + ".vala");
			add_file_from_stream(source, stream, null, null);
			compiler.callback = new_callback;
		}
		
		private void new_callback(bool err, string buffer) {
			if (!err)
				error(buffer);
			else
				stdout.printf ("%s", buffer);
		}
		
		public override void run(string? command = null) throws Error {
			testprogam = compiler.compile(program, source, packages);
		}
		
		public override void cleanup() {
			testprogam.cleanup();
			base.cleanup();
		}
		
	}
	
	public class GIRTestProgram : TestProgram {
		private const string GIRHEADER =
		"""<?xml version="1.0"?>
		<repository version="1.2"
					xmlns="http://www.gtk.org/introspection/core/1.0"
					xmlns:c="http://www.gtk.org/introspection/c/1.0"
					xmlns:glib="http://www.gtk.org/introspection/glib/1.0">
			<include name="GLib" version="2.0"/>
			<include name="GObject" version="2.0"/>
			<c:include name="test.h"/>
			<namespace name="Test"
						 version="1.2"
						 c:identifier-prefixes="Test"
						 c:symbol-prefixes="test">""";

		private const string GIRFOOTER = "\n</namespace>\n</repository>";

		private const string VAPIHEADER = 
		"""/* %s.vapi generated by lt-vapigen, do not modify. */
		[CCode (cprefix = "Test", gir_namespace = "Test", gir_version = "1.2", lower_case_cprefix = "test_")]
		namespace Test {""";

		private string testname;
		
		private File vapifile;
		
		public GIRTestProgram(string testname, string packages, DataInputStream stream) throws Error {
			base(testdir.get_child(testname + ".gir"));
			this.testname = testname;
			add_file_from_stream(program, stream, "Input:", "Output:", GIRHEADER, GIRFOOTER);
			vapifile = testdir.get_child(testname + ".vapi.ref");
			add_file_from_stream(vapifile, stream, null, null, VAPIHEADER.printf(testname), "\n}\n");
		}
		
		public override void run(string? command = null) throws Error {
			var vgen = new VapiGen();
			var vapi = vgen.compile(testname, program);
			add_file(vapi);
			var diff = new Diff();
			diff.run("-Bw %s %s".printf(vapi.get_path(), vapifile.get_path()));
		}
		
	}
	
	public class Diff : Program {

		public Diff() {
			base(File.new_for_path(Environment.find_program_in_path ("diff")));
		}
		
	}
	
	public class VapiGen : Program {

		private string girdirs = "";
		private static File vapidir;
		
		public VapiGen() {
			base(buildir.get_child("vapigen").get_child("vapigen"));
			foreach(string dir in Environment.get_system_data_dirs())
				if(File.new_for_path(dir).get_child("gir-1.0").query_exists())
					girdirs += "--girdir=%s/gir-1.0".printf(File.new_for_path(dir).get_child("gir-1.0").get_path());
			vapidir = buildir.get_child("vapi");
		}
		
		public File compile(string testname, File girfile) throws Error {
			string command = "--vapidir %s %s --library %s %s".printf(
				vapidir.get_path(),
				girdirs,
				testname,
				girfile.get_path());
			run(command);
			return testdir.get_child(testname + ".vapi");
		}
	}
	
	public class ValaCompiler : Program {
		
		private const string VALA_FLAGS =
			"""--save-temps --disable-warnings --pkg gio-2.0 
			  -X -lm -X -g -X -O0 -X -pipe
			  -X -Wno-discarded-qualifiers -X -Wno-incompatible-pointer-types
			  -X -Wno-deprecated-declarations -X -Werror=return-type
			  -X -Werror=init-self -X -Werror=implicit -X -Werror=sequence-point
			  -X -Werror=return-type -X -Werror=uninitialized -X -Werror=pointer-arith
			  -X -Werror=int-to-pointer-cast -X -Werror=pointer-to-int-cast""";

		internal static File vapidir;

		class construct {
			vapidir = buildir.get_child("vapi");
		}

		
		public ValaCompiler(File compiler) {
			base(compiler);
		}
		
		public Program compile(File binary, File sourcefile, string? parameters = null) throws Error {
			string command = "--vapidir %s %s %s -o %s %s".printf(
				vapidir.get_path(), VALA_FLAGS, parameters ?? "", binary.get_path(), sourcefile.get_path());
			run(command);
			var prog = new TestProgram(binary);
			prog.add_file(binary.get_parent().get_child(binary.get_basename() + ".c"));
			return prog;
		}
		
	}
}
