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
		static int version;
		static string[] sources;
		CodeContext context;
	
		const OptionEntry[] options = {
			{ "directory", 'd', 0, OptionArg.FILENAME, out directory, "Output directory", "DIRECTORY" },
			{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
			{ "", 0, 0, OptionArg.FILENAME_ARRAY, out sources, null, "FILE..." },
			{ null }
		};
		
		void run () {
			context = new CodeContext ();
			
			foreach (string source in sources) {
				context.add_source_file (new SourceFile (filename = source));
			}
			
			var parser = new Parser ();
			parser.parse (context);
			
			var builder = new SymbolBuilder ();
			builder.build (context);
			
			var resolver = new SymbolResolver ();
			resolver.resolve (context);
			
			var attributeprocessor = new AttributeProcessor ();
			attributeprocessor.process (context);
			
			var code_generator = new CodeGenerator ();
			code_generator.emit (context);
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
			compiler.run ();
		
			return 0;
		}
	}
}
