/* valaccodecompiler.vala
 *
 * Copyright (C) 2007-2009  Jürg Billeter
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

/**
 * Interface to the C compiler.
 */
public class Vala.CCodeCompiler {
	public CCodeCompiler () {
	}

	static bool package_exists(string package_name) {
		string pc = "pkg-config --exists " + package_name;
		int exit_status;

		try {
			Process.spawn_command_line_sync (pc, null, null, out exit_status);
			return (0 == exit_status);
		} catch (SpawnError e) {
			Report.error (null, e.message);
			return false;
		}
	}

	/**
	 * Compile generated C code to object code and optionally link object
	 * files.
	 *
	 * @param context a code context
	 */
	public void compile (CodeContext context, string? cc_command, string[] cc_options) {
		bool use_pkgconfig = false;

		string pc = "pkg-config --cflags";
		if (!context.compile_only) {
			pc += " --libs";
		}
		use_pkgconfig = true;
		pc += " gobject-2.0";
		if (context.thread) {
			pc += " gthread-2.0";
		}
		foreach (string pkg in context.get_packages ()) {
			if (package_exists (pkg)) {
				use_pkgconfig = true;
				pc += " " + pkg;
			}
		}
		string pkgflags = "";
		if (use_pkgconfig) {
			try {
				int exit_status;
				Process.spawn_command_line_sync (pc, out pkgflags, null, out exit_status);
				if (exit_status != 0) {
					Report.error (null, "pkg-config exited with status %d".printf (exit_status));
					return;
				}
			} catch (SpawnError e) {
				Report.error (null, e.message);
				return;
			}
		}

		// TODO compile the C code files in parallel

		if (cc_command == null) {
			cc_command = "cc";
		}
		string cmdline = cc_command;
		if (context.debug) {
			cmdline += " -g";
		}
		if (context.compile_only) {
			cmdline += " -c";
		} else if (context.output != null) {
			string output = context.output;
			if (context.directory != null && context.directory != "" && !Path.is_absolute (context.output)) {
				output = "%s%c%s".printf (context.directory, Path.DIR_SEPARATOR, context.output);
			}
			cmdline += " -o " + Shell.quote (output);
		}

		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (file.file_type == SourceFileType.SOURCE) {
				cmdline += " " + Shell.quote (file.get_csource_filename ());
			}
		}
		var c_source_files = context.get_c_source_files ();
		foreach (string file in c_source_files) {
			cmdline += " " + Shell.quote (file);
		}

		// add libraries after source files to fix linking
		// with --as-needed and on Windows
		cmdline += " " + pkgflags.strip ();
		foreach (string cc_option in cc_options) {
			cmdline += " " + Shell.quote (cc_option);
		}

		if (context.verbose_mode) {
			stdout.printf ("%s\n", cmdline);
		}

		try {
			int exit_status;
			Process.spawn_command_line_sync (cmdline, null, null, out exit_status);
			if (exit_status != 0) {
				Report.error (null, "cc exited with status %d".printf (exit_status));
			}
		} catch (SpawnError e) {
			Report.error (null, e.message);
		}

		/* remove generated C source and header files */
		foreach (SourceFile file in source_files) {
			if (file.file_type == SourceFileType.SOURCE) {
				if (!context.save_csources) {
					FileUtils.unlink (file.get_csource_filename ());
				}
			}
		}
	}
}
