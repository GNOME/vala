/* girmetadata.vala
 *
 * Copyright (C) 2012-2014 Florian Brosch
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
 * Metadata reader for GIR files
 */
public class Valadoc.GirMetaData : Object {
	private string? metadata_path = null;
	private string? resource_dir = null;


	public bool is_docbook { private set; get; default = false; }
	public string index_sgml { private set; get; default = null; }
	public string index_sgml_online { private set; get; default = null; }

	/**
	 * Used to manipulate paths to resources inside gir-files
	 */
	public string get_resource_path (string resource) {
		if (resource_dir == null || metadata_path == null) {
			return resource;
		}

		if (Path.is_absolute (resource_dir)) {
			return Path.build_filename (resource_dir, resource);
		}

		return Path.build_filename (Path.get_dirname (metadata_path), resource_dir, resource);
	}

	private string? get_metadata_file_name (string gir_file_path) {
		string metadata_file_name = Path.get_basename (gir_file_path);
		int last_dot_pos = metadata_file_name.last_index_of (".");
		if (last_dot_pos < 0) {
			return null;
		}

		metadata_file_name = metadata_file_name.substring (0, last_dot_pos);
		return metadata_file_name + ".valadoc.metadata";
	}

	private string? get_metadata_path (string gir_file_path, string[] metadata_dirs) {
		string? metadata_file_name = get_metadata_file_name (gir_file_path);
		if (metadata_file_name == null) {
			return null;
		}

		// search for metatada at the same location as the gir file
		string metadata_path = Path.build_filename (Path.get_dirname (gir_file_path), metadata_file_name);
		if (FileUtils.test (metadata_path, FileTest.IS_REGULAR)) {
			return metadata_path;
		}

		foreach (string metadata_dir in metadata_dirs) {
			metadata_path = Path.build_filename (metadata_dir, metadata_file_name);
			if (FileUtils.test (metadata_path, FileTest.IS_REGULAR)) {
				return metadata_path;
			}
		}

		return null;
	}

	private void load_general_metadata (KeyFile key_file, ErrorReporter reporter) throws KeyFileError {
		foreach (string key in key_file.get_keys ("General")) {
			switch (key) {
			case "resources":
				this.resource_dir = key_file.get_string ("General", "resources");
				break;

			case "is_docbook":
				this.is_docbook = key_file.get_boolean ("General", "is_docbook");
				break;

			case "index_sgml":
				string tmp = key_file.get_string ("General", "index_sgml");
				this.index_sgml = Path.build_filename (Path.get_dirname (metadata_path), tmp);
				break;

			case "index_sgml_online":
				this.index_sgml_online = key_file.get_string ("General", "index_sgml_online");
				break;

			default:
				reporter.simple_warning (metadata_path, "Unknown key 'General.%s'", key);
				break;
			}
		}
	}

	public GirMetaData (string gir_file_path, string[] metadata_dirs, ErrorReporter reporter) {
		if (!FileUtils.test (gir_file_path, FileTest.IS_REGULAR)) {
			return ;
		}

		metadata_path = get_metadata_path (gir_file_path, metadata_dirs);
		if (metadata_path == null) {
			return ;
		}

		KeyFile key_file;

		try {
			key_file = new KeyFile ();
			key_file.load_from_file (metadata_path, KeyFileFlags.NONE);
		} catch (KeyFileError e) {
			reporter.simple_error (metadata_path, "%s", e.message);
			return ;
		} catch (FileError e) {
			reporter.simple_error (metadata_path, "%s", e.message);
			return ;
		}

		try {
			foreach (string group in key_file.get_groups ()) {
				switch (group) {
				case "General":
					load_general_metadata (key_file, reporter);
					break;

				default:
					reporter.simple_warning (metadata_path, "Unknown group '%s'", group);
					break;
				}
			}
		} catch (KeyFileError e) {
			reporter.simple_error (null, "Unable to read file '%s': %s", metadata_path, e.message);
		}


		// Load internal link lut:
	}
}

