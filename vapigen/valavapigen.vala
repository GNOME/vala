/* valavapigen.vala
 *
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
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

class Vala.VAPIGen : Object {
	static string directory;
	static bool version;
	static bool quiet_mode;
	static bool disable_warnings;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] sources;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] vapi_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] gir_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] metadata_directories;
	static string library;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] packages;
	CodeContext context;

	const OptionEntry[] options = {
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, ref vapi_directories, "Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "girdir", 0, 0, OptionArg.FILENAME_ARRAY, ref gir_directories, "Look for GIR bindings in DIRECTORY", "DIRECTORY..." },
		{ "metadatadir", 0, 0, OptionArg.FILENAME_ARRAY, ref metadata_directories, "Look for GIR .metadata files in DIRECTORY", "DIRECTORY..." },
		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, ref packages, "Include binding for PACKAGE", "PACKAGE..." },
		{ "library", 0, 0, OptionArg.STRING, ref library, "Library name", "NAME" },
		{ "directory", 'd', 0, OptionArg.FILENAME, ref directory, "Output directory", "DIRECTORY" },
		{ "disable-warnings", 0, 0, OptionArg.NONE, ref disable_warnings, "Disable warnings", null },
		{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
		{ "quiet", 'q', 0, OptionArg.NONE, ref quiet_mode, "Do not print messages to the console", null },
		{ "", 0, 0, OptionArg.FILENAME_ARRAY, ref sources, null, "FILE..." },
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
		context.profile = Profile.GOBJECT;
		context.vapi_directories = vapi_directories;
		context.gir_directories = gir_directories;
		context.metadata_directories = metadata_directories;
		context.report.enable_warnings = !disable_warnings;
		context.report.set_verbose_errors (!quiet_mode);
		CodeContext.push (context);
		
		/* default package */
		context.add_external_package ("glib-2.0");
		context.add_external_package ("gobject-2.0");

		if (context.report.get_errors () > 0) {
			return quit ();
		}

		/* load packages from .deps file */
		foreach (string source in sources) {
			if (!source.has_suffix (".gi")) {
				continue;
			}

			var depsfile = source.substring (0, source.length - "gi".length) + "deps";
			context.add_packages_from_file (depsfile);
		}

		if (context.report.get_errors () > 0) {
			return quit ();
		}

		// depsfile for gir case
		if (library != null) {
			var depsfile = library + ".deps";
			context.add_packages_from_file (depsfile);
		} else {
			Report.error (null, "--library option must be specified");
		}

		if (context.report.get_errors () > 0) {
			return quit ();
		}

		if (packages != null) {
			foreach (string package in packages) {
				context.add_external_package (package);
			}
			packages = null;
		}
		
		if (context.report.get_errors () > 0) {
			return quit ();
		}

		foreach (string source in sources) {
			if (FileUtils.test (source, FileTest.EXISTS)) {
				context.add_source_file (new SourceFile (context, SourceFileType.PACKAGE, source));
			} else {
				Report.error (null, "%s not found".printf (source));
			}
		}
		
		if (context.report.get_errors () > 0) {
			return quit ();
		}
		
		var parser = new Parser ();
		parser.parse (context);
		
		if (context.report.get_errors () > 0) {
			return quit ();
		}
		
		var girparser = new GirParser ();
		girparser.parse (context);
		
		if (context.report.get_errors () > 0) {
			return quit ();
		}
		
		var gidlparser = new GIdlParser ();
		gidlparser.parse (context);
		
		if (context.report.get_errors () > 0) {
			return quit ();
		}

		context.check ();

		if (context.report.get_errors () > 0) {
			return quit ();
		}

		// interface writer ignores external packages
		foreach (SourceFile file in context.get_source_files ()) {
			if (file.filename.has_suffix (".vapi")) {
				continue;
			}
			if (file.filename in sources) {
				file.file_type = SourceFileType.SOURCE;
				if (file.filename.has_suffix (".gir")) {
					// mark relative metadata as source
					string? metadata_filename = context.get_metadata_path (file.filename);
					if (metadata_filename != null) {
						foreach (SourceFile metadata_file in context.get_source_files ()) {
							if (metadata_file.filename == metadata_filename) {
								metadata_file.file_type = SourceFileType.SOURCE;
							}
						}
					}
				}
			}
		}

		var interface_writer = new CodeWriter ();
		var vapi_filename = "%s.vapi".printf (library);
		if (directory != null) {
			vapi_filename = Path.build_path ("/", directory, vapi_filename);
		}

		interface_writer.write_file (context, vapi_filename);
			
		library = null;
		
		return quit ();
	}
	
	static int main (string[] args) {
		try {
			var opt_context = new OptionContext ("- Vala API Generator");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);
		} catch (OptionError e) {
			stdout.printf ("%s\n", e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return 1;
		}

		if (version) {
			stdout.printf ("Vala API Generator %s\n", Config.BUILD_VERSION);
			return 0;
		}

		if (sources == null) {
			stderr.printf ("No source file specified.\n");
			return 1;
		}
		
		var vapigen = new VAPIGen ();
		return vapigen.run ();
	}
}
