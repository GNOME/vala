namespace Vala.Tests {
	
	/**
	 * Vala.TestFixture
	 * 
	 * Searchs all of the sub directories in the current directory for
	 * *.vala or *.test files, compiles and runs them.
	 * 
	 * If the test is a self contained application (has its own main entry
	 * point), it will compile and run it. The test is deemed succesful if
	 * it compiles and runs without error.
	 * 
	 * If the test is a collection of {@ref Valadate.TestCase}s then it
	 * compiles the test and runs it. The test results will be appeneded to
	 * the TestFixture's. Not yet implemented.
	 * 
	 * If the test is a .test file it will be parsed, the components
	 * assembled, compiled and run.  The test is deemed succesful if
	 * it compiles and runs without error.
	 * 
	 * The tests can be run against the system compiler or the one in the
	 * source tree. This can be used to verify if a patch or other change
	 * to the compiler either fixes a bug or causes a regression (or both)
	 */
	
	public class Fixture : Valadate.TestCase {
		
		private delegate void CommandCallback(Subprocess process, size_t err, string buffer);
		
		private SubprocessLauncher launcher =
			new SubprocessLauncher(GLib.SubprocessFlags.STDOUT_PIPE | GLib.SubprocessFlags.STDERR_PIPE);
		
		private const string VALAFLAGS = """--pkg gio-2.0 --pkg valadate
			 --main main --save-temps --disable-warnings 
			  -X -pie -X -fPIE -X -g -X -O0 -X -pipe -X -lm 
			  -X -Wno-discarded-qualifiers -X -Wno-incompatible-pointer-types
			  -X -Wno-deprecated-declarations -X -Werror=return-type
			  -X -Werror=init-self -X -Werror=implicit -X -Werror=sequence-point
			  -X -Werror=return-type -X -Werror=uninitialized -X -Werror=pointer-arith
			  -X -Werror=int-to-pointer-cast -X -Werror=pointer-to-int-cast""";
		
		private const string GIRHEADER ="""
			<?xml version="1.0"?>
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
							 c:symbol-prefixes="test">
					%s
				</namespace>
				</repository>
		""";

		private File testdir;
		private File buildir;
		private File vapidir;
		private File valadatedir;
		private File valac;
		private File vapigen;
		private File tempdir;

		private string vapidirs;


		public Fixture() {
			load_tests();
		}

		~Fixture() {
			delete_tempdir();
		}

		private void load_tests() {
			try {
				testdir = File.new_for_path(GLib.Environment.get_current_dir());
				buildir = testdir.get_parent();
				vapidir = buildir.get_child("vapi");
				valadatedir = buildir.get_child("valadate");
				valac = buildir.get_child("compiler").get_child("valac");
				vapigen = buildir.get_child("vapigen").get_child("vapigen");
				tempdir = testdir.get_child(".tests");
				delete_tempdir();
				tempdir.make_directory();

				vapidirs = "--vapidir %s --vapidir %s".printf(vapidir.get_path(), valadatedir.get_path());

				launcher.set_cwd(tempdir.get_path());

				var enumerator = testdir.enumerate_children (FileAttribute.STANDARD_NAME, 0);
				FileInfo file_info;
				while ((file_info = enumerator.next_file ()) != null) {
					if (file_info.get_file_type() == GLib.FileType.DIRECTORY) {
						var subdir = testdir.get_child(file_info.get_name());
						load_tests_from_dir(subdir);
					}
				}
			} catch (Error e) {
				stderr.printf ("Error: %s\n", e.message);
			}
		}

		private void delete_tempdir() throws Error {
			if (tempdir == null || !tempdir.query_exists())
				return;
				
			var enumerator = tempdir.enumerate_children (FileAttribute.STANDARD_NAME, 0);
			FileInfo file_info;
			while ((file_info = enumerator.next_file ()) != null) {
				if (file_info.get_file_type() == GLib.FileType.REGULAR) {
					var file = tempdir.get_child(file_info.get_name());
					file.delete();
				}
			}
			tempdir.delete();
		}

		private void load_tests_from_dir(File directory) throws Error {
			var enumerator = directory.enumerate_children (FileAttribute.STANDARD_NAME, 0);
			FileInfo file_info;
			while ((file_info = enumerator.next_file ()) != null) {
				string fname = file_info.get_name();

				if (file_info.get_file_type() == GLib.FileType.DIRECTORY) {
					load_tests_from_dir(directory.get_child(fname));
					continue;
				}

				File testfile = directory.get_child(fname);
				string testname = testfile.get_basename().substring(0,testfile.get_basename().last_index_of("."));

				if(fname.has_suffix(".vala")) {
					string command = "%s %s %s %s".printf(valac.get_path(), vapidirs, VALAFLAGS, testfile.get_path());
					string binary = testfile.get_basename().substring(0,testfile.get_basename().last_index_of("."));

					add_test(testname,
					 ()=> {
						try {
							run_command(command);
							if(tempdir.get_child(binary).query_exists())
								run_command("./%s".printf(binary));
							else
								Test.fail();
						} catch (Error e) {
							Test.fail();
							stdout.printf ("%s", e.message);
						}});
					continue;
				}
				
				if(fname.has_suffix(".test")) {
					add_test(testname,
					 ()=> {
						try {
							parse_test(testfile);
						} catch (Error e) {
							Test.fail();
							stdout.printf ("%s", e.message);
						}});
				}
			}
		}

		private void default_callback(Subprocess process, size_t err, string buffer) {
			if (err > 0) {
				Test.fail();
				stdout.printf ("%s", buffer);
				process.force_exit();
			}
		}

		private void run_command(string command, CommandCallback callback = default_callback) throws Error {
			string[] args;
			Shell.parse_argv(command, out args);

			var process = launcher.spawnv(args);
			var stderr_pipe = process.get_stderr_pipe();

			uint8 buffer[1028];
			var err = stderr_pipe.read(buffer);
			
			callback(process, err, (string)buffer);

		}

		private void parse_test(File testfile) throws Error {
			
			var stream = new DataInputStream(testfile.read());
			string testname = testfile.get_basename().substring(0,testfile.get_basename().last_index_of("."));
			
			string line = stream.read_line(null);
			
			string packages = "";
			
			if (line.has_prefix("Packages:")) {
				packages = line.split(":")[1];
				packages = string.joinv(" --pkg ", packages.split(" "));
				line = stream.read_line(null);
			}
			switch (line) {
				
				case "D-Bus":
					var clientfile = tempdir.get_child(testname + ".client.vala");
					var serverfile = tempdir.get_child(testname + ".server.vala");
					var client = clientfile.create(FileCreateFlags.NONE);
					var client_stream = new DataOutputStream (client);
					var server = serverfile.create(FileCreateFlags.NONE);
					var server_stream = new DataOutputStream (server);
					
					while ((line = stream.read_line (null)) != "Program: client") { }
					
					while ((line = stream.read_line (null)) != "Program: server") {
						client_stream.put_string(line + "\n");
					}

					while ((line = stream.read_line (null)) != null) {
						server_stream.put_string(line + "\n");
					}

					string command = "%s %s %s %s %s".printf(valac.get_path(), vapidirs, packages, VALAFLAGS, clientfile.get_path());
					
					run_command(command);

					command = "%s %s %s %s %s".printf(valac.get_path(), vapidirs, packages, VALAFLAGS, serverfile.get_path());

					run_command(command);

					string binary = serverfile.get_basename().substring(0,serverfile.get_basename().last_index_of("."));

					command = "./" + binary;

					run_command(command);

					break;

				case "GIR":

					string gir = "";
					string vapi = "/* %s.vapi generated by lt-vapigen, do not modify. */\n\n".printf(testname);
					vapi += "[CCode (cprefix = \"Test\", gir_namespace = \"Test\", gir_version = \"1.2\", lower_case_cprefix = \"test_\")]";
					vapi += "\nnamespace Test {";

					while ((line = stream.read_line (null)) != "Input:") { }

					while ((line = stream.read_line (null)) != "Output:") {
						gir += line + "\n";
					}

					stream.read_line (null);

					while ((line = stream.read_line (null)) != null) {
						if(line.length > 0)
							vapi += "\n\t" + line;
					}

					vapi += "\n}\n";

					var girfile = tempdir.get_child(testname + ".gir");
					var girstream = girfile.create(FileCreateFlags.NONE);
					girstream.write(GIRHEADER.printf(gir).data);

					string command = "%s %s --library %s %s".printf(vapigen.get_path(), vapidirs, testname, girfile.get_path());
				
					run_command(command);

					uint8[] contents;
					File file = tempdir.get_child(testname+".vapi");
					file.load_contents (null, out contents, null);

					if(strcmp(vapi, (string)contents) != 0)
						Test.fail();
				
					break;

				case "Invalid Code":
					
					var invalidfile = tempdir.get_child(testname + ".vala");
					var invalid_stream = new DataOutputStream (invalidfile.create(FileCreateFlags.NONE));

					while ((line = stream.read_line (null)) != null) {
						invalid_stream.put_string(line + "\n");
					}

					string command = "%s %s %s %s %s".printf(valac.get_path(), vapidirs, packages, VALAFLAGS, invalidfile.get_path());

					run_command(command, (p,e,b) => {
						if (e <= 0)
							Test.fail();
					});
					break;

				default :
					break;
			}
		}
	}
}
