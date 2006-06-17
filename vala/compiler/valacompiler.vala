/* valacompiler.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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

namespace Vala {
	class Compiler {
		static string directory;
		static bool version;
		static string[] sources;
		static string[] vapi_directories;
		static string library;
		static string[] packages;
		static bool disable_memory_management;
		CodeContext context;
	
		const OptionEntry[] options = {
			{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, out vapi_directories, "Look for package bindings in DIRECTORY", "DIRECTORY..." },
			{ "pkg", 0, 0, OptionArg.STRING_ARRAY, out packages, "Include binding for PACKAGE", "PACKAGE..." },
			{ "library", 0, 0, OptionArg.STRING, out library, "Library name", "NAME" },
			{ "directory", 'd', 0, OptionArg.FILENAME, out directory, "Output directory", "DIRECTORY" },
			{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
			{ "disable-memory-management", 0, 0, OptionArg.NONE, ref disable_memory_management, "Disable memory management", null },
			{ "", 0, 0, OptionArg.FILENAME_ARRAY, out sources, null, "FILE..." },
			{ null }
		};
		
		private int quit () {
			if (Report.get_errors () == 0) {
				stdout.printf ("Compilation succeeded - %d warning(s)\n", Report.get_warnings ());
				return 0;
			} else {
				stdout.printf ("Compilation failed: %d error(s), %d warning(s)\n", Report.get_errors (), Report.get_warnings ());
				return 1;
			}
		}
		
		private ref string get_package_path (string! pkg) {
			var basename = "%s.vala".printf (pkg);
		
			if (vapi_directories != null) {
				foreach (string vapidir in vapi_directories) {
					var filename = Path.build_filename (vapidir, basename, null);
					if (File.test (filename, FileTest.EXISTS)) {
						return filename;
					}
				}
				vapi_directories = null;
			}
			
			var filename = Path.build_filename ("/usr/share/vala/vapi", basename, null);
			if (File.test (filename, FileTest.EXISTS)) {
				return filename;
			}
			
			return null;
		}
		
		private bool add_package (string! pkg) {
			var package_path = get_package_path (pkg);
			
			if (package_path == null) {
				return false;
			}
			
			context.add_source_file (new SourceFile (filename = package_path, pkg = true));
			
			return true;
		}
		
		private int run () {
			context = new CodeContext ();
			
			/* default package */
			if (!add_package ("glib-2.0")) {
				Report.error (null, "glib-2.0 not found in specified Vala API directories");
			}
			
			if (packages != null) {
				foreach (string package in packages) {
					if (!add_package (package)) {
						Report.error (null, "%s not found in specified Vala API directories".printf (package));
					}
				}
				packages = null;
			}
			
			if (Report.get_errors () > 0) {
				return quit ();
			}
			
			foreach (string source in sources) {
				if (File.test (source, FileTest.EXISTS)) {
					context.add_source_file (new SourceFile (filename = source));
				} else {
					Report.error (null, "%s not found".printf (source));
				}
			}
			sources = null;
			
			if (Report.get_errors () > 0) {
				return quit ();
			}
			
			var parser = new Parser ();
			parser.parse (context);
			
			if (Report.get_errors () > 0) {
				return quit ();
			}
			
			var builder = new SymbolBuilder ();
			builder.build (context);
			
			if (Report.get_errors () > 0) {
				return quit ();
			}
			
			var attributeprocessor = new AttributeProcessor ();
			attributeprocessor.process (context);
			
			if (Report.get_errors () > 0) {
				return quit ();
			}
			
			var resolver = new SymbolResolver ();
			resolver.resolve (context);
			
			if (Report.get_errors () > 0) {
				return quit ();
			}
			
			var analyzer = new SemanticAnalyzer (memory_management = !disable_memory_management);
			analyzer.analyze (context);
			
			if (Report.get_errors () > 0) {
				return quit ();
			}
			
			if (!disable_memory_management) {
				var memory_manager = new MemoryManager ();
				memory_manager.analyze (context);
				
				if (Report.get_errors () > 0) {
					return quit ();
				}
			}
			
			var code_generator = new CodeGenerator (memory_management = !disable_memory_management);
			code_generator.emit (context);
			
			if (Report.get_errors () > 0) {
				return quit ();
			}
			
			if (library != null) {
				var interface_writer = new InterfaceWriter ();
				interface_writer.write_file (context, "%s.vala".printf (library));
				
				library = null;
			}
			
			return quit ();
		}
		
		static int main (int argc, string[] argv) {
			Error err = null;
		
			var opt_context = OptionContext.@new ("- Vala Compiler");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref argc, out argv, out err);
			
			if (err != null) {
				return 1;
			}
			
			if (sources == null) {
				stderr.printf ("No source file specified.\n");
				return 1;
			}
			
			foreach (string source in sources) {
				if (!source.has_suffix (".vala")) {
					stderr.printf ("Only .vala source files supported.\n");
					return 1;
				}
			}
			
			var compiler = new Compiler ();
			return compiler.run ();
		}
	}
}
