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

public class Valadoc.Settings : Object {
	public string path = "documentation/";
	public string pkg_name = null;
	public string pkg_version;
	public string wiki_directory;

	public bool _private = false;
	public bool _protected = false;
	public bool _internal = false;
	public bool with_deps = false;
	public bool add_inherited = false;
	public bool verbose = false;

	public bool enable_checking;
	public bool deprecated;
	public bool experimental;
	public bool experimental_non_null;
	public bool disable_dbus_transformation;

	public string? profile;
	public string? basedir;
	public string? directory;

	public string[] defines;
	public string[] vapi_directories;
	public string[] docu_directories;
}


