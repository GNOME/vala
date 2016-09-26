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
 * If the test is a .test file it will be parsed, the components
 * assembled, compiled and run.  The test is deemed succesful if
 * it compiles and runs without error.
 * 
 * The tests can be run against the system compiler or the one in the
 * source tree. This can be used to verify if a patch or other change
 * to the compiler either fixes a bug or causes a regression (or both)
 */

public class Vala.Tests : Valadate.TestSuite {
	
	private const string BUGZILLA_URL = "http://bugzilla.gnome.org/";

	construct {
		try {
			var testdir = File.new_for_path (GLib.Environment.get_current_dir ());
			var testpath = Valadate.get_current_test_path ();
			
			if (testpath != null) {
				var testpaths = testpath.split ("/");
				if (testpaths.length < 4)
					return;
				var runtest = testdir.get_child (testpaths[3]);
				if (runtest.query_exists ())
					add_test (new ValaTest (runtest));
			} else {
				var tempdir = testdir.get_child (".tests");
				if (!tempdir.query_exists())
					tempdir.make_directory();

				var enumerator = testdir.enumerate_children (FileAttribute.STANDARD_NAME, 0);
				FileInfo file_info;
				while ((file_info = enumerator.next_file ()) != null)
					if (file_info.get_file_type() == GLib.FileType.DIRECTORY &&
						!file_info.get_name().has_prefix("."))
						add_test (new ValaTest (testdir.get_child(file_info.get_name())));
			}
		} catch (Error e) {
			stderr.printf ("Error: %s\n", e.message);
		}
	}

	private class ValaTest : Valadate.TestCase {

		private TestsFactory factory = TestsFactory.get_instance ();
		
		public ValaTest (File directory) throws Error {
			this.name = directory.get_basename ();
			this.bug_base = BUGZILLA_URL;

			string current_test = Valadate.get_current_test_path ();

			if (current_test != null) {
				var basename = Path.get_basename (current_test);
				if (directory.get_child (basename + ".vala").query_exists ())
					load_test (directory.get_child (basename + ".vala"));
				else if (directory.get_child (basename + ".test").query_exists ())
					load_test (directory.get_child (basename + ".test"));
				else if (directory.get_child (basename + ".gs").query_exists ())
					load_test (directory.get_child (basename + ".gs"));
			} else {
				var enumerator = directory.enumerate_children (FileAttribute.STANDARD_NAME, 0);
				FileInfo file_info;
				while ((file_info = enumerator.next_file ()) != null) {
					if (file_info.get_file_type () == GLib.FileType.DIRECTORY)
						continue;
					load_test (directory.get_child (file_info.get_name ()));
				}
			}
		}

		private void load_test (File testfile) throws Error {
			string basename = testfile.get_basename ();
			string testname = basename.substring (0, basename.last_index_of ("."));
			add_test (testname, () => {
				try {
					if (testname.has_prefix ("bug"))
						bug (testname.substring(3));
					var prog = factory.get_test_program (testfile);
					prog.run ();
					factory.cleanup ();
				} catch (Error e) {
					fail (e.message);
				}
			});
		}
	}
}
