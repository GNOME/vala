/**
 * Vala.Tests
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

public class Vala.Tests : Valadate.TestSuite {
	
	public Tests() {
		load_tests();
	}

	private void load_tests() {
		try {
			var testdir = File.new_for_path(GLib.Environment.get_current_dir());
			var testpath = Valadate.get_current_test_path();
			
			if (testpath != null) {
				var testpaths = testpath.split("/");
				if (testpaths.length < 4)
					return;
				var runtest = testdir.get_child(testpaths[3]);
				if(runtest.query_exists())
					add_test(new ValaTest(runtest));
			} else {
				var tempdir = testdir.get_child(".tests");
				if(!tempdir.query_exists())
					tempdir.make_directory();

				var enumerator = testdir.enumerate_children (FileAttribute.STANDARD_NAME, 0);
				FileInfo file_info;
				while ((file_info = enumerator.next_file ()) != null)
					if (file_info.get_file_type() == GLib.FileType.DIRECTORY &&
						!file_info.get_name().has_prefix("."))
						add_test(new ValaTest(testdir.get_child(file_info.get_name())));
			}
		} catch (Error e) {
			stderr.printf ("Error: %s\n", e.message);
		}
	}


	private class ValaTest : Valadate.TestCase {

		private delegate void CommandCallback(bool err, string buffer);
		
		private static SubprocessLauncher launcher;
		
		private const string VALA_FLAGS =
			"""--main main --save-temps --disable-warnings --pkg gio-2.0 
			  -X -lm -X -g -X -O0 -X -pipe
			  -X -Wno-discarded-qualifiers -X -Wno-incompatible-pointer-types
			  -X -Wno-deprecated-declarations -X -Werror=return-type
			  -X -Werror=init-self -X -Werror=implicit -X -Werror=sequence-point
			  -X -Werror=return-type -X -Werror=uninitialized -X -Werror=pointer-arith
			  -X -Werror=int-to-pointer-cast -X -Werror=pointer-to-int-cast""";
		
		private const string TESTCASE_FLAGS =
			"--pkg valadate -X -pie -X -fPIE";
		
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
							 c:symbol-prefixes="test">
					%s
				</namespace>
				</repository>""";

		private const string BUGZILLA_URL = "http://bugzilla.gnome.org/";
		
		private static File testdir;
		private static File tempdir;
		private static File buildir;
		private static File vapidir;
		private static File valadatedir;
		private static File valac;
		private static File vapigen;
		private static string vapidirs;

		private File[] testfiles = {};

		class construct {
			testdir = File.new_for_path(GLib.Environment.get_current_dir());
			tempdir = testdir.get_child(".tests");
			buildir = testdir.get_parent();
			vapidir = buildir.get_child("vapi");
			valadatedir = buildir.get_child("valadate");
			valac = buildir.get_child("compiler").get_child("valac");
			vapigen = buildir.get_child("vapigen").get_child("vapigen");
			vapidirs = "--vapidir %s".printf(vapidir.get_path());
			launcher = new SubprocessLauncher(GLib.SubprocessFlags.STDOUT_PIPE | GLib.SubprocessFlags.STDERR_MERGE);
			launcher.set_cwd(tempdir.get_path());
		}

		
		public override void tear_down() {
			foreach(var file in testfiles)
				if(file.query_exists())
					file.delete();
		}
		
		public ValaTest(File directory) throws Error {
			this.name = directory.get_basename();
			this.bug_base = BUGZILLA_URL;
			
			string current_test = Valadate.get_current_test_path();

			if(current_test != null) {
				var basename = Path.get_basename(current_test);
				if (directory.get_child(basename + ".vala").query_exists())
					load_test(directory.get_child(basename + ".vala"));
				else if (directory.get_child(basename + ".gs").query_exists())
					load_test(directory.get_child(basename + ".gs"));
				else if (directory.get_child(basename + ".test").query_exists())
					load_test(directory.get_child(basename + ".test"));
			} else {
				var enumerator = directory.enumerate_children (FileAttribute.STANDARD_NAME, 0);
				FileInfo file_info;
				while ((file_info = enumerator.next_file ()) != null) {
					if (file_info.get_file_type() == GLib.FileType.DIRECTORY)
						continue;

					string fname = file_info.get_name();

					load_test(directory.get_child(fname));
				}
			}
		}

		private void load_test(File testfile) throws Error {
			string testname = testfile.get_basename().substring(
				0,testfile.get_basename().last_index_of("."));

			string fname = testfile.get_basename();

			if(fname.has_suffix(".vala") || fname.has_suffix(".gs")) {
				
				add_test(testname,
				 ()=> {
					string binary = testfile.get_basename().substring(
						0,testfile.get_basename().last_index_of("."));
					string command = "%s %s %s -o %s %s".printf(
						valac.get_path(), vapidirs, VALA_FLAGS,
						binary, testfile.get_path());

					try {
						if(binary.has_prefix("bug")) {
							bug_base = BUGZILLA_URL;						
							bug(binary.substring(3));
						}
						run_command(command);
						
						testfiles += tempdir.get_child(binary);
						testfiles += tempdir.get_child(binary + ".c");
						
						if(tempdir.get_child(binary).query_exists())
							run_command("./%s".printf(binary));
						else
							fail("Binary not generated");
					} catch (Error e) {
						fail(e.message);
						stdout.printf ("%s", e.message);
					}});
			}
			
			if(fname.has_suffix(".test")) {
				add_test(testname,
				 ()=> {
					try {
						if(fname.has_prefix("bug")) {
							bug(fname.substring(3,fname.length-8));
						}
						parse_test(testfile);
					} catch (Error e) {
						fail(e.message);
						stdout.printf ("%s", e.message);
					}});
			}
		}

		private void default_callback(bool err, string buffer) {
			if (err) {
				fail(buffer);
			} else {
				stdout.printf ("%s", buffer);
			}
		}

		private void run_command(string command, CommandCallback callback = default_callback) throws Error {
			string[] args;
			Shell.parse_argv(command, out args);
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

		private void parse_test(File testfile) throws Error {
			
			var stream = new DataInputStream(testfile.read());
			string testname = testfile.get_basename().substring(
				0,testfile.get_basename().last_index_of("."));
			
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
					testfiles += clientfile;
					var serverfile = tempdir.get_child(testname + ".server.vala");
					testfiles += serverfile;
					var client = clientfile.create(FileCreateFlags.REPLACE_DESTINATION);
					var client_stream = new DataOutputStream (client);
					var server = serverfile.create(FileCreateFlags.REPLACE_DESTINATION);
					var server_stream = new DataOutputStream (server);
					
					do {} while ((line = stream.read_line (null)) != "Program: client");
					
					while ((line = stream.read_line (null)) != "Program: server") {
						client_stream.put_string(line + "\n");
					}

					while ((line = stream.read_line (null)) != null) {
						server_stream.put_string(line + "\n");
					}

					string command = "%s %s %s %s %s".printf(
						valac.get_path(), vapidirs, packages, VALA_FLAGS,
						clientfile.get_path());
					
					run_command(command);

					command = "%s %s %s %s %s".printf(
						valac.get_path(), vapidirs, packages, VALA_FLAGS,
						serverfile.get_path());

					run_command(command);

					string binary = serverfile.get_basename().substring(
						0,serverfile.get_basename().last_index_of("."));

					testfiles += tempdir.get_child(binary);
					testfiles += tempdir.get_child(binary + ".c");
					testfiles += tempdir.get_child(testname + ".client");
					testfiles += tempdir.get_child(testname + ".client.c");

					command = "./" + binary;
					
					Bus.watch_name(
						BusType.SESSION,
						"org.example.Test",
						GLib.BusNameWatcherFlags.NONE,
						null,
						(c,n) => {
							run_command(command);
						});

					break;

				case "GIR":

					string gir = "";
					string girdirs = "";
					
					foreach(string dir in GLib.Environment.get_system_data_dirs())
						if(File.new_for_path(dir).get_child("gir-1.0").query_exists())
							girdirs += "--girdir=%s/gir-1.0".printf(File.new_for_path(dir).get_child("gir-1.0").get_path());
					
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
					testfiles += girfile;
					var girstream = girfile.create(FileCreateFlags.REPLACE_DESTINATION);
					girstream.write(GIRHEADER.printf(gir).data);

					string command = "%s %s %s --library %s %s".printf(
						vapigen.get_path(),
						vapidirs,
						girdirs,
						testname,
						girfile.get_path());
				
					run_command(command);

					uint8[] contents;
					File file = tempdir.get_child(testname+".vapi");
					testfiles += file;
					file.load_contents (null, out contents, null);

					if(strcmp(vapi, (string)contents) != 0)
						fail((string)contents);
				
					break;

				case "Invalid Code":
					
					var invalidfile = tempdir.get_child(testname + ".vala");
					testfiles += invalidfile;
					var invalid_stream = new DataOutputStream (invalidfile.create(FileCreateFlags.REPLACE_DESTINATION));

					while ((line = stream.read_line (null)) != null) {
						invalid_stream.put_string(line + "\n");
					}

					string command = "%s %s %s %s %s".printf(
						valac.get_path(),
						vapidirs, packages,
						VALA_FLAGS,
						invalidfile.get_path());

					run_command(command, (e,b) => {
						if (!e)
							fail(b);
					});
					break;

				case "TestCase":
					
					var testcasefile = tempdir.get_child(testname + ".vala");
					var testcase = testcasefile.create(FileCreateFlags.REPLACE_DESTINATION);
					var testcase_stream = new DataOutputStream (testcase);

					testcase_stream.put_string("namespace Vala.Tests {\n");

					while ((line = stream.read_line (null)) != null) {
						testcase_stream.put_string(line + "\n");
					}

					testcase_stream.put_string("\n}");

					string command = "%s %s %s %s %s".printf(
						valac.get_path(),
						vapidirs,
						packages,
						VALA_FLAGS,
						testcasefile.get_path());
					
					run_command(command);

					string binary = testcasefile.get_basename().substring(
						0,testcasefile.get_basename().last_index_of("."));

					command = "./" + binary;

					run_command(command);

					break;

				default :
					break;
			}
		}
	}
}
