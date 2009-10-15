/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *  
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
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
	public bool non_null_experimental;
	public bool disable_dbus_transformation;

	public string? profile;
	public string? basedir;
	public string? directory;

	public string[] defines;
	public string[] vapi_directories;
}

