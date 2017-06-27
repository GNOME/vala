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
	private Vala.ArrayList<AttributeArgument> args = new Vala.ArrayList<AttributeArgument> ();
	private SourceFile file;

	public string name {
		private set;
		get;
	}

	public Attribute (Node parent, SourceFile file, string name, void* data) {
		base (data);

		this.parent = parent;
		this.name = name;
		this.file = file;
	}

	public AttributeArgument? get_argument (string name) {
		if (args != null) {
			foreach (AttributeArgument arg in args) {
				if (arg.name == name) {
					return arg;
				}
			}
		}

		return null;
	}

	public AttributeArgument add_boolean (string name, bool value, void* data = null) {
		AttributeArgument arg = new AttributeArgument.boolean (this, file, name, value, data);
		args.add (arg);
		return arg;
	}

	public AttributeArgument add_integer (string name, int value, void* data = null) {
		AttributeArgument arg = new AttributeArgument.integer (this, file, name, value, data);
		args.add (arg);
		return arg;
	}

	public AttributeArgument add_double (string name, double value, void* data = null) {
		AttributeArgument arg = new AttributeArgument.double (this, file, name, value, data);
		args.add (arg);
		return arg;
	}

	public AttributeArgument add_string (string name, string value, void* data = null) {
		AttributeArgument arg = new AttributeArgument.string (this, file, name, value, data);
		args.add (arg);
		return arg;
	}

	public SourceFile get_source_file () {
		return file;
	}

	protected override Inline build_signature () {
		SignatureBuilder builder = new SignatureBuilder ();

		builder.append_attribute ("[");
		builder.append_type_name (name);

		if (args.size > 0) {
			builder.append_attribute ("(");
			bool first = true;

			foreach (AttributeArgument arg in args) {
				if (first == false) {
					builder.append_attribute (", ");
				}
				builder.append_content (arg.signature);
				first = false;
			}
			builder.append_attribute (")");
		}

		builder.append_attribute ("]");
	
		return builder.get ();
	}
}

