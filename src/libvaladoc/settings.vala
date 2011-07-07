/* settings.vala
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
 * Contains information about output settings configuration
 */
public class Valadoc.Settings : Object {
	/**
	 * Output directory/file name.
	 */
	public string path = "documentation/";

	/**
	 * Package name
	 */
	public string pkg_name = null;

	/**
	 * Package version
	 */
	public string pkg_version;

	/**
	 * Wiki directory
	 */
	public string wiki_directory;

	/**
	 * Plugin-specific command line arguments
	 */
	public string[] pluginargs;


	/**
	 * Add private elements to documentation
	 */
	public bool _private = false;

	/**
	 * Add protected elements to documentation
	 */
	public bool _protected = false;

	/**
	 * Add internal elements to documentation
	 */
	public bool _internal = false;

	/**
	 * Add dependencies to the documentation
	 */
	public bool with_deps = false;

	public bool add_inherited = false;

	/**
	 * Show all warnings
	 */
	public bool verbose = false;



	/**
	 * Do not warn when using experimental features.
	 */
	public bool experimental;

	/**
	 * Enable experimental enhancements for non-null types.
	 */
	public bool experimental_non_null;

	/**
	 * Use the given profile (dova, gobject, posix, ...) instead of the defaul
	 */
	public string? profile;

	/**
	 * Base source directory.
	 */
	public string? basedir;

	/**
	 * Output directory/file name.
	 */
	public string? directory;


	/**
	 * A list of defined symbols.
	 */
	public string[] defines;

	/**
	 * List of directories where to find .vapi files.
	 */
	public string[] vapi_directories;
}


