/* attribute.vala
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
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc.Content;

public class Valadoc.Api.Attribute : Item {
	private SourceFile file;

	public string name {
		private set;
		get;
	}

	public Attribute (Node parent, SourceFile file, string name, Vala.Attribute data) {
		base (data);

		this.parent = parent;
		this.name = name;
		this.file = file;
	}

	public SourceFile get_source_file () {
		return file;
	}

	protected override Inline build_signature () {
		SignatureBuilder builder = new SignatureBuilder ();

		unowned Vala.Attribute attr = (Vala.Attribute) data;

		var keys = new GLib.Sequence<string> ();
		foreach (var key in attr.args.get_keys ()) {
			if (key == "cheader_filename") {
				continue;
			}
			keys.insert_sorted (key, (CompareDataFunc<string>) strcmp);
		}

		if (attr.name == "CCode" && keys.get_length () == 0) {
			// only cheader_filename on namespace
			return builder.get ();
		}

		builder.append_attribute ("[");
		builder.append_type_name (attr.name);

		if (keys.get_length () > 0) {
			builder.append_attribute ("(");

			unowned string separator = "";
			var arg_iter = keys.get_begin_iter ();
			while (!arg_iter.is_end ()) {
				unowned string arg_name = arg_iter.get ();
				arg_iter = arg_iter.next ();
				if (separator != "") {
					builder.append_attribute (", ");
				}
				if (arg_name != "cheader_filename") {
					builder.append_attribute (arg_name);
					builder.append_attribute ("=");
					builder.append_literal (attr.args.get (arg_name));
				}
				separator = ", ";
			}

			builder.append_attribute (")");
		}
		builder.append_attribute ("]");

		return builder.get ();
	}
}

