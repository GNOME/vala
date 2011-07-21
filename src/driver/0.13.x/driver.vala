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
using Gee;



/**
 * Creates an simpler, minimized, more abstract AST for valacs AST.
 */
public class Valadoc.Drivers.Driver : Object, Valadoc.Driver {

	public Api.Tree? build (Settings settings, ErrorReporter reporter) {
		TreeBuilder builder = new TreeBuilder ();
		Api.Tree? tree = builder.build (settings, reporter);
		if (reporter.errors > 0) {
			return null;
		}

		SymbolResolver resolver = new SymbolResolver (builder);
		tree.accept (resolver);

		return tree;
	}
}


[ModuleInit]
public Type register_plugin (GLib.TypeModule module) {
	return typeof (Valadoc.Drivers.Driver);
}

