/* sourcefile.vala
 *
 * Copyright (C) 2011 Florian Brosch
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
 * Represents a source file
 */
public class Valadoc.Api.SourceFile : Object {

	public Package package {
		private set;
		get;
	}

	public string relative_path {
		private set;
		get;
	}

	public string? relative_c_path {
		private set;
		get;
	}

	public string get_name () {
		return Path.get_basename (relative_path);
	}

	public Vala.SourceFile? data {
		private set;
		get;
	}

	public SourceFile (Package package, string relative_path, string? relative_c_path, Vala.SourceFile? data) {
		this.relative_c_path = relative_c_path;
		this.relative_path = relative_path;
		this.package = package;
		this.data = data;
	}
}


