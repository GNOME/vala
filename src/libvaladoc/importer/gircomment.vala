/* DocumentationBuilderimporter.vala
 *
 * Copyright (C) 2010-2011 Florian Brosch
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


using Valadoc;
using Gee;


/**
 * A documentation comment used by valadoc
 */
public class Valadoc.Importer.GirComment : Valadoc.Api.SourceComment {
	private HashMap<string, Api.SourceComment> _parameters = new HashMap<string, Api.SourceComment> ();

	public Map<string, Api.SourceComment> parameters {
		owned get { return _parameters.read_only_view; }
	}

	public Api.SourceComment? return_value {
		internal set;
		get;
	}

	public GirComment (string content, Api.SourceFile file, int first_line, int first_column, int last_line, int last_column) {
		base (content, file, first_line, first_column, last_line, last_column);
		return_value = null;
	}

	internal void add_parameter (string name, Api.SourceComment comment) {
		_parameters.set (name, comment);
	}

	public bool is_empty () {
		return return_value == null && (content == null || content == "") && parameters.is_empty;
	}
}

