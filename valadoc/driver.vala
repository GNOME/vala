/* driver.vala
 *
 * Copyright (C) 2011  Florian Brosch
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


using Valadoc.Api;

/**
 * Creates an simpler, minimized, more abstract AST for valacs AST.
 */
public class Valadoc.Drivers.Driver : Object, Valadoc.Driver {
	private SymbolResolver resolver;
	private Api.Tree? tree;

	public void write_gir (Settings settings, ErrorReporter reporter) {
		var gir_writer = new Drivers.GirWriter (resolver);

		// put .gir file in current directory unless -d has been explicitly specified
		string gir_directory = ".";
		if (settings.gir_directory != null) {
			gir_directory = settings.gir_directory;
		}

		gir_writer.write_file ((Vala.CodeContext) tree.data,
							   gir_directory,
							   "%s-%s.gir".printf (settings.gir_namespace, settings.gir_version),
							   settings.gir_namespace,
							   settings.gir_version,
							   settings.pkg_name);
	}

	public Api.Tree? build (Settings settings, ErrorReporter reporter) {
		TreeBuilder builder = new TreeBuilder ();
		tree = builder.build (settings, reporter);
		if (reporter.errors > 0) {
			return null;
		}

		resolver = new SymbolResolver (builder);
		tree.accept (resolver);

		return tree;
	}
}


public Type register_plugin (Valadoc.ModuleLoader module_loader) {
	return typeof (Valadoc.Drivers.Driver);
}

