/* valadoc.vala
 *
 * Copyright (C) 2008-2014 Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */

using Valadoc.Importer;
using Valadoc;

public class ValaDoc : Object {
	private const string DEFAULT_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";

	private static string wikidirectory = null;
	private static string pkg_version = null;
	private static string docletpath = null;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] pluginargs;
	private static string directory = null;
	private static string pkg_name = null;
	private static string gir_name = null;
	private static string gir_namespace = null;
	private static string gir_version = null;

	private static bool add_inherited = false;
	private static bool _protected = true;
	private static bool _internal = false;
	private static bool with_deps = false;
	private static bool _private = false;
	private static bool version = false;
	private static bool use_svg_images = false;

	private static bool disable_diagnostic_colors = false;
	private static bool verbose = false;
	private static bool force = false;
	private static bool fatal_warnings = false;

	private static string basedir = null;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] defines;
	private static bool experimental;
	private static bool experimental_non_null = false;
	private static string profile;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] import_packages;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] import_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] vapi_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] metadata_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] gir_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] tsources;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] packages;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] alternative_resource_dirs;
	static string target_glib;

	private const GLib.OptionEntry[] options = {
		{ "directory", 'o', 0, OptionArg.FILENAME, ref directory, "Output directory", "DIRECTORY" },

		{ "basedir", 'b', 0, OptionArg.FILENAME, ref basedir, "Base source directory", "DIRECTORY" },
		{ "define", 'D', 0, OptionArg.STRING_ARRAY, ref defines, "Define SYMBOL", "SYMBOL..." },
		{ "profile", 0, 0, OptionArg.STRING, ref profile, "Use the given profile instead of the default", "PROFILE" },

		{ "enable-experimental", 0, 0, OptionArg.NONE, ref experimental, "Enable experimental features", null },
		{ "enable-experimental-non-null", 0, 0, OptionArg.NONE, ref experimental_non_null, "Enable experimental enhancements for non-null types", null },

		{ "metadatadir", 0, 0, OptionArg.FILENAME_ARRAY, ref metadata_directories, "Look for GIR .metadata files in DIRECTORY", "DIRECTORY..." },
		{ "girdir", 0, 0, OptionArg.FILENAME_ARRAY, ref gir_directories, "Look for .gir files in DIRECTORY", "DIRECTORY..." },
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, ref vapi_directories, "Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, ref packages, "Include binding for PACKAGE", "PACKAGE..." },

		{ "driver", 0, OptionFlags.OPTIONAL_ARG, OptionArg.CALLBACK, (void*) option_deprecated, "Name of an driver or path to a custom driver (DEPRECATED AND IGNORED)", null },

		{ "importdir", 0, 0, OptionArg.FILENAME_ARRAY, ref import_directories, "Look for external documentation in DIRECTORY", "DIRECTORY..." },
		{ "import", 0, 0, OptionArg.STRING_ARRAY, ref import_packages, "Include binding for PACKAGE", "PACKAGE..." },
		{ "alternative-resource-dir", 0, 0, OptionArg.STRING_ARRAY, ref alternative_resource_dirs, "Alternative resource directories", "DIRECTORY..." },

		{ "wiki", 0, 0, OptionArg.FILENAME, ref wikidirectory, "Wiki directory", "DIRECTORY" },

		{ "deps", 0, 0, OptionArg.NONE, ref with_deps, "Adds packages to the documentation", null },

		{ "doclet", 0, 0, OptionArg.STRING, ref docletpath, "Name of an included doclet or path to custom doclet", "PLUGIN"},
		{ "doclet-arg", 'X', 0, OptionArg.STRING_ARRAY, ref pluginargs, "Pass arguments to the doclet", "ARG" },

		{ "no-protected", 0, OptionFlags.REVERSE, OptionArg.NONE, ref _protected, "Removes protected elements from documentation", null },
		{ "internal", 0, 0, OptionArg.NONE, ref _internal, "Adds internal elements to documentation", null },
		{ "private", 0, 0, OptionArg.NONE, ref _private, "Adds private elements to documentation", null },
		{ "use-svg-images", 0, 0, OptionArg.NONE, ref use_svg_images, "Generate SVG image charts instead of PNG", null },

		{ "package-name", 0, 0, OptionArg.STRING, ref pkg_name, "package name", "NAME" },
		{ "package-version", 0, 0, OptionArg.STRING, ref pkg_version, "package version", "VERSION" },
		{ "gir", 0, 0, OptionArg.STRING, ref gir_name, "GObject-Introspection repository file name", "NAME-VERSION.gir" },

		{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },

		{ "force", 0, 0, OptionArg.NONE, ref force, "force", null },
		{ "fatal-warnings", 0, 0, OptionArg.NONE, ref fatal_warnings, "Treat warnings as fatal", null },
		{ "verbose", 0, 0, OptionArg.NONE, ref verbose, "Show all warnings", null },
		{ "no-color", 0, 0, OptionArg.NONE, ref disable_diagnostic_colors, "Disable colored output", null },
		{ "target-glib", 0, 0, OptionArg.STRING, ref target_glib, "Target version of glib for code generation", "'MAJOR.MINOR', or 'auto'" },
		{ OPTION_REMAINING, 0, 0, OptionArg.FILENAME_ARRAY, ref tsources, null, "FILE..." },

		{ null }
	};

	static bool option_deprecated (string option_name, string? val, void* data) throws OptionError {
		stdout.printf ("Command-line option `%s` is deprecated and will be ignored\n", option_name);
		return true;
	}

	private static int quit (ErrorReporter reporter, bool pop_context = false) {
		if (reporter.errors == 0 && (!fatal_warnings || reporter.warnings == 0)) {
			stdout.printf ("Succeeded - %d warning(s)\n", reporter.warnings);
			if (pop_context) {
				Vala.CodeContext.pop ();
			}
			return 0;
		} else {
			stdout.printf ("Failed: %d error(s), %d warning(s)\n", reporter.errors, reporter.warnings);
			if (pop_context) {
				Vala.CodeContext.pop ();
			}
			return 1;
		}
	}

	private static bool check_pkg_name () {
		if (pkg_name == null) {
			return true;
		}

		if (pkg_name == "glib-2.0" || pkg_name == "gobject-2.0") {
			return false;
		}

		foreach (string package in tsources) {
			if (pkg_name == package) {
				return false;
			}
		}
		return true;
	}

	private string get_pkg_name () {
		if (ValaDoc.pkg_name == null) {
			if (ValaDoc.directory.has_suffix ("/")) {
				ValaDoc.pkg_name = GLib.Path.get_dirname (ValaDoc.directory);
			} else {
				ValaDoc.pkg_name = GLib.Path.get_basename (ValaDoc.directory);
			}
		}

		return ValaDoc.pkg_name;
	}

	private ModuleLoader? create_module_loader (ErrorReporter reporter, out Doclet? doclet) {
		ModuleLoader modules = ModuleLoader.get_instance ();

		doclet = null;

		// doclet:
		string? pluginpath = ModuleLoader.get_doclet_path (docletpath, reporter);
		if (pluginpath == null) {
			return null;
		}

		doclet = modules.create_doclet (pluginpath);
		if (doclet == null) {
			reporter.simple_error (null, "failed to load doclet");
			return null;
		}

		return modules;
	}

	private int run (ErrorReporter reporter) {
		// settings:
		var settings = new Valadoc.Settings ();
		reporter.settings = settings;

		settings.pkg_name = this.get_pkg_name ();
		settings.gir_namespace = ValaDoc.gir_namespace;
		settings.gir_version = ValaDoc.gir_version;
		if (ValaDoc.gir_name != null) {
			settings.gir_name = GLib.Path.get_basename (ValaDoc.gir_name);
			settings.gir_directory = GLib.Path.get_dirname (ValaDoc.gir_name);
			if (settings.gir_directory == "") {
				settings.gir_directory = GLib.Path.get_dirname (ValaDoc.directory);
			}
		}
		settings.pkg_version = ValaDoc.pkg_version;
		settings.add_inherited = ValaDoc.add_inherited;
		settings._protected = ValaDoc._protected;
		settings._internal = ValaDoc._internal;
		settings.with_deps = ValaDoc.with_deps;
		settings._private = ValaDoc._private;
		settings.path = Vala.CodeContext.realpath (ValaDoc.directory);
		settings.verbose = ValaDoc.verbose;
		settings.wiki_directory = ValaDoc.wikidirectory;
		settings.pluginargs = ValaDoc.pluginargs;

		settings.experimental = experimental;
		settings.experimental_non_null = experimental_non_null;
		settings.basedir = basedir;
		settings.directory = directory;
		settings.vapi_directories = vapi_directories;
		settings.metadata_directories = metadata_directories;
		settings.gir_directories = gir_directories;
		settings.target_glib = target_glib;
		settings.use_svg_images = use_svg_images;

		settings.source_files = tsources;
		settings.packages = packages;

		settings.profile = profile;
		settings.defines = defines;

		settings.alternative_resource_dirs = alternative_resource_dirs;

		var context = new Vala.CodeContext ();
		Vala.CodeContext.push (context);

		// load plugins:
		Doclet? doclet = null;
		ModuleLoader? modules = create_module_loader (reporter, out doclet);
		if (reporter.errors > 0 || modules == null) {
			return quit (reporter, true);
		}

		// Create tree:
		TreeBuilder builder = new TreeBuilder ();
		Valadoc.Api.Tree doctree = builder.build (settings, reporter);
		if (reporter.errors > 0) {
			doclet = null;
			return quit (reporter, true);
		}
		SymbolResolver resolver = new SymbolResolver (builder);
		doctree.accept (resolver);

		// register child symbols:
		Valadoc.Api.ChildSymbolRegistrar registrar = new Valadoc.Api.ChildSymbolRegistrar ();
		doctree.accept (registrar);

		// process documentation
		Valadoc.DocumentationParser docparser = new Valadoc.DocumentationParser (settings, reporter, doctree, modules);
		if (!doctree.create_tree()) {
			return quit (reporter, true);
		}

		DocumentationImporter[] importers = {
			new ValadocDocumentationImporter (doctree, docparser, modules, settings, reporter),
			new GirDocumentationImporter (doctree, docparser, modules, settings, reporter)
		};

		doctree.parse_comments (docparser);
		if (reporter.errors > 0) {
			return quit (reporter, true);
		}

		doctree.import_comments (importers, import_packages, import_directories);
		if (reporter.errors > 0) {
			return quit (reporter, true);
		}

		doctree.check_comments (docparser);
		if (reporter.errors > 0) {
			return quit (reporter, true);
		}

		if (ValaDoc.gir_name != null) {
			var gir_writer = new GirWriter (resolver);
			gir_writer.write_file (doctree.context,
				settings.gir_directory,
				"%s-%s.gir".printf (settings.gir_namespace, settings.gir_version),
				settings.gir_namespace,
				settings.gir_version,
				settings.pkg_name);
			if (reporter.errors > 0) {
				return quit (reporter, true);
			}
		}

		doclet.process (settings, doctree, reporter);
		return quit (reporter, true);
	}

	static int main (string[] args) {
		Intl.setlocale (LocaleCategory.ALL, "");
		ErrorReporter reporter = new ErrorReporter();

		try {
			var opt_context = new OptionContext ("- Vala Documentation Tool");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);
		} catch (OptionError e) {
			reporter.simple_error (null, "%s", e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return quit (reporter);
		}

		if (disable_diagnostic_colors == false) {
			unowned string env_colors = Environment.get_variable ("VALA_COLORS");
			if (env_colors != null) {
				reporter.set_colors (env_colors);
			} else {
				reporter.set_colors (DEFAULT_COLORS);
			}
		}

		if (version) {
			stdout.printf ("Valadoc %s\n", Vala.BUILD_VERSION);
			return 0;
		}

		if (directory == null) {
			reporter.simple_error (null, "No output directory specified.");
			return quit (reporter);
		}

		if (!check_pkg_name ()) {
			reporter.simple_error (null, "File already exists");
			return quit (reporter);
		}

		if (FileUtils.test (directory, FileTest.EXISTS)) {
			if (force == true) {
				bool tmp = remove_directory (directory);
				if (tmp == false) {
					reporter.simple_error (null, "Can't remove directory.");
					return quit (reporter);
				}
			} else {
				reporter.simple_error (null, "File already exists");
				return quit (reporter);
			}
		}

		if (wikidirectory != null) {
			if (!FileUtils.test(wikidirectory, FileTest.IS_DIR)) {
				reporter.simple_error (null, "Wiki-directory does not exist.");
				return quit (reporter);
			}
		}

		foreach (unowned string dir in alternative_resource_dirs) {
			if (!FileUtils.test(dir, FileTest.IS_DIR)) {
				reporter.simple_error (null, "alternative resource directory '%s' does not exist.".printf (dir));
				return quit (reporter);
			}
		}
		if (reporter.errors > 0) {
			return quit (reporter);
		}

		if (gir_name != null) {
			long gir_len = gir_name.length;
			int last_hyphen = gir_name.last_index_of_char ('-');

			if (last_hyphen == -1 || !gir_name.has_suffix (".gir")) {
				reporter.simple_error (null, "GIR file name '%s' is not well-formed, expected NAME-VERSION.gir", gir_name);
				return quit (reporter);
			}

			gir_namespace = gir_name.substring (0, last_hyphen);
			gir_version = gir_name.substring (last_hyphen + 1, gir_len - last_hyphen - 5);
			gir_version.canon ("0123456789.", '?');

			if (gir_namespace == "" || gir_version == "" || !gir_version[0].isdigit () || gir_version.contains ("?")) {
				reporter.simple_error (null, "GIR file name '%s' is not well-formed, expected NAME-VERSION.gir", gir_name);
				return quit (reporter);
			}


			bool report_warning = true;
			foreach (string source in tsources) {
				if (source.has_suffix (".vala") || source.has_suffix (".gs")) {
					report_warning = false;
					break;
				}
			}

			if (report_warning == true) {
				reporter.simple_error (null, "No source file specified to be compiled to gir.");
				return quit (reporter);
			}
		}


		var valadoc = new ValaDoc( );
		return valadoc.run (reporter);
	}
}


