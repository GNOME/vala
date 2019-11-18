/* valadbusgen.vala
 *
 * Copyright (C) 2017 Chris Daley
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
 * 	Chris Daley <chebizarro@gmail.com>
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

public class Vala.DBusGen {

	public class ConcatenationStrategy : NamespaceStrategy {

		public override string? get_namespace (string ns) {
			return root_name;
		}

		public override string get_name (string ns) {

			string[] parts = ns.split(".");
			StringBuilder capitalized_name = new StringBuilder();
			foreach (string part in parts) {
				if (part != "") {
					capitalized_name.append(part.substring(0, 1).up());
					capitalized_name.append(part.substring(1, part.length - 1));
				}
			}
			return capitalized_name.str;
		}

	}

	static string directory;
	static bool version;
	static bool quiet_mode = false;
	static bool disable_warnings;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] sources;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] vapi_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] packages;
	static bool nostdpkg;
	static int dbus_timeout = 120000;
	static string root_namespace;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] rename_namespaces;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] strip_namespaces;

	CodeContext context;

	const OptionEntry[] options = {
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, ref vapi_directories, "Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "nostdpkg", 0, 0, OptionArg.NONE, ref nostdpkg, "Do not include standard packages", null },
		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, ref packages, "Include binding for PACKAGE", "PACKAGE..." },
		{ "directory", 'd', 0, OptionArg.FILENAME, ref directory, "Output directory", "DIRECTORY" },
		{ "disable-warnings", 0, 0, OptionArg.NONE, ref disable_warnings, "Disable warnings", null },
		{ "namespace", 'n', 0, OptionArg.STRING, ref root_namespace, "Name of the parent namespace", null },
		{ "rename-namespace", 0, 0, OptionArg.STRING_ARRAY, ref rename_namespaces, "Namespace to rename to", "SOURCE_NS:TARGET_NS..." },
		{ "strip-namespace", 0, 0, OptionArg.STRING_ARRAY, ref strip_namespaces, "Namespace to strip", "NAMESPACE..." },
		{ "dbus-timeout", 0, 0, OptionArg.INT, ref dbus_timeout, "DBus timeout", null },
		{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
		{ "quiet", 'q', 0, OptionArg.NONE, ref quiet_mode, "Do not print messages to the console", null },
		{ OPTION_REMAINING, 0, 0, OptionArg.FILENAME_ARRAY, ref sources, null, "FILE..." },
		{ null }
	};

	private int quit () {
		if (context.report.get_errors () == 0) {
			if (!quiet_mode) {
				stdout.printf ("Generation succeeded - %d warning(s)\n", context.report.get_warnings ());
			}
			return 0;
		} else {
			if (!quiet_mode) {
				stdout.printf ("Generation failed: %d error(s), %d warning(s)\n", context.report.get_errors (), context.report.get_warnings ());
			}
			return 1;
		}
	}

	private int run () {
		context = new CodeContext ();

		context.report.enable_warnings = !disable_warnings;
		context.vapi_directories = vapi_directories;
		context.report.set_verbose_errors (!quiet_mode);
		CodeContext.push (context);

		context.profile = Profile.GOBJECT;
		context.add_define ("GOBJECT");
		context.vapi_comments = true;

		context.add_external_package ("glib-2.0");
		context.add_external_package ("gobject-2.0");
		context.add_external_package ("gio-2.0");

		if (packages != null) {
			foreach (string package in packages) {
				context.add_external_package (package);
			}
			packages = null;
		}

		if (context.report.get_errors () > 0) {
			return quit ();
		}

		var valaparser = new Parser ();
		valaparser.parse (context);

		if (context.report.get_errors () > 0) {
			return quit ();
		}

		foreach (string source in sources) {
			if (FileUtils.test (source, FileTest.EXISTS)) {
				if (source.has_suffix (".xml")) {
					var source_file = new SourceFile (context, SourceFileType.SOURCE, source);
					source_file.from_commandline = true;
					context.add_source_file (source_file);
				} else if (FileUtils.test (source, FileTest.IS_DIR)) {
					try {
						GLib.Dir dir = GLib.Dir.open(source);
						string name;
						while ((name = dir.read_name()) != null) {
							if (name.has_suffix(".xml")) {
								var source_file = new SourceFile (context, SourceFileType.SOURCE, Path.build_filename(source, name));
								source_file.from_commandline = true;
								context.add_source_file (source_file);
							}
						}
					} catch (FileError e) {
						Report.error (null, e.message);
					}
				}
			} else {
				Report.error (null, "%s not found".printf (source));
			}
		}

		if (context.report.get_errors () > 0) {
			return quit ();
		}

		var parser = new DBusParser ();
		parser.dbus_timeout = dbus_timeout;
		parser.namespace_strategy = new ConcatenationStrategy () {
			root_name = root_namespace
		};
		parser.parse (context);

		if (context.report.get_errors () > 0) {
			return quit ();
		}

		context.check ();

		if (context.report.get_errors () > 0) {
			return quit ();
		}

		var interface_writer = new CodeWriter (CodeWriterType.FAST);

		foreach (SourceFile source in context.get_source_files ()) {
			string filename = Path.get_basename (source.filename);

			if (filename.has_suffix (".xml")) {
				if (directory != null) {
					filename = Path.build_path ("/", directory, filename + ".vala");
				}
				interface_writer.write_file (context, filename + ".vala");
			}
		}

		return quit ();
	}

	static int main (string[] args) {
		Intl.setlocale (LocaleCategory.ALL, "");
		try {
			var opt_context = new OptionContext ("- Vala DBus Interface Generator");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);
		} catch (OptionError e) {
			stdout.printf ("%s\n", e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return 1;
		}

		if (version) {
			stdout.printf ("Vala DBus Interface Generator %s\n", Vala.BUILD_VERSION);
			return 0;
		}

		if (sources == null) {
			stderr.printf ("No source file specified.\n");
			return 1;
		}

		var dbusgen = new DBusGen ();
		return dbusgen.run ();
	}
}
