/* doclet.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch
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
 * 	Brosch Florian <flo.brosch@gmail.com>
 */


/**
 * A plugin register function for doclets
 *
 * @see ModuleLoader
 */
[CCode (has_target = false)]
public delegate Type Valadoc.DocletRegisterFunction (ModuleLoader module_loader);



/**
 * Provides a mechanism to inspect the API & documentation of programs and libraries
 */
public interface Valadoc.Doclet : GLib.Object {

	/**
	 * Allows the doclet to inspect the given {@link Api.Tree}
	 *
	 * @param settings various configurations
	 * @param tree the tree to inspect
	 * @param reporter the reporter to use
	 * @see Content.ContentVisitor
	 * @see Api.Visitor
	 */
	public abstract void process (Settings settings, Api.Tree tree, ErrorReporter reporter);
}


