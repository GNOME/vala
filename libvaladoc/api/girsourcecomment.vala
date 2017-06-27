/* sourcecomment.vala
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


/**
 * A documentation comment used by valadoc
 */
public class Valadoc.Api.GirSourceComment : SourceComment {
	private Vala.Map<string, SourceComment> parameters = new Vala.HashMap<string, SourceComment> (str_hash, str_equal);

	public string? instance_param_name { set; get; }
	public SourceComment? return_comment { set; get; }
	public SourceComment? deprecated_comment { set; get; }
	public SourceComment? version_comment { get; set; }
	public SourceComment? stability_comment { get; set; }


	public Vala.MapIterator<string, SourceComment> parameter_iterator () {
		return parameters.map_iterator ();
	}

	public void add_parameter_content (string param_name, SourceComment comment) {
		this.parameters.set (param_name, comment);
	}

	public SourceComment? get_parameter_comment (string param_name) {
		if (parameters == null) {
			return null;
		}

		return parameters.get (param_name);
	}

	public GirSourceComment (string content, SourceFile file, int first_line, int first_column, int last_line, int last_column) {
		base (content, file, first_line, first_column, last_line, last_column);
	}
}

