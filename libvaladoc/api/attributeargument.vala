/* attributeargument.vala
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

public class Valadoc.Api.AttributeArgument : Item {
	public enum Type {
		BOOLEAN,
		INTEGER,
		DOUBLE,
		STRING
	}

	private SourceFile file;

	public string name {
		private set;
		get;
	}

	public AttributeArgument.Type argument_type {
		private set;
		get;
	}

	public string value {
		private set;
		get;
	}

	public AttributeArgument.boolean (Attribute parent, SourceFile file, string name, bool value, void* data) {
		this (parent, file, name, Type.BOOLEAN, value.to_string (), data);
	}

	public AttributeArgument.integer (Attribute parent, SourceFile file, string name, int value, void* data) {
		this (parent, file, name, Type.INTEGER, value.to_string (), data);
	}

	public AttributeArgument.double (Attribute parent, SourceFile file, string name, double value, void* data) {
		this (parent, file, name, Type.DOUBLE, value.to_string (), data);
	}

	public AttributeArgument.string (Attribute parent, SourceFile file, string name, string value, void* data) {
		this (parent, file, name, Type.STRING, value, data);
	}

	private AttributeArgument (Attribute parent, SourceFile file, string name, Type type, string value, void* data) {
		base (data);

		this.argument_type = type;
		this.parent = parent;
		this.value = value;
		this.file = file;
		this.name = name;
	}

	public SourceFile get_source_file () {
		return file;
	}

	public bool get_value_as_boolean () {
		assert (argument_type == Type.BOOLEAN);

		bool tmp;

		if (bool.try_parse (value, out tmp)) {
			return tmp;
		}

		assert_not_reached ();
	}

	public int get_value_as_integer () {
		assert (argument_type == Type.INTEGER);

		double tmp;

		if (global::double.try_parse (value, out tmp) && tmp >= int.MIN && tmp <= int.MAX) {
			return (int) tmp;
		}

		assert_not_reached ();
	}

	public double get_value_as_double () {
		assert (argument_type == Type.DOUBLE);

		double tmp;

		if (global::double.try_parse (value, out tmp)) {
			return tmp;
		}

		assert_not_reached ();
	}

	public string get_value_as_string () {
		assert (argument_type == Type.STRING);

		return value;
	}

	protected override Inline build_signature () {
		SignatureBuilder builder = new SignatureBuilder ();

		builder.append_attribute (name);
		builder.append_attribute ("=");
		builder.append_literal (value);

		return builder.get ();
	}
}
