/* valaattribute.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Represents an attribute specified in the source code.
 */
public class Vala.Attribute : CodeNode {
	/**
	 * The name of the attribute type.
	 */
	public string name { get; private set; }

	/**
	 * Contains all specified attribute arguments.
	 */
	public Vala.Map<string,Expression> args { get; private set; }

	/**
	 * Creates a new attribute.
	 *
	 * @param name             attribute type name
	 * @param source_reference reference to source code
	 * @return                 newly created attribute
	 */
	public Attribute (string name, SourceReference? source_reference = null) {
		this.name = name;
		this.source_reference = source_reference;
		this.args = new HashMap<string,Expression> (str_hash, str_equal);

		if (!CodeContext.get ().deprecated) {
			if (name == "Deprecated") {
				Report.deprecated (source_reference, "[Deprecated] is deprecated. Use [Version (deprecated = true, deprecated_since = \"\", replacement = \"\")]");
			} else if (name == "Experimental") {
				Report.deprecated (source_reference, "[Experimental] is deprecated. Use [Version (experimental = true, experimental_until = \"\")]");
			}
		}
	}

	/**
	 * Adds an attribute argument.
	 *
	 * @param key    argument name
	 * @param value  argument value
	 */
	public void add_argument (string key, Expression value) {
		args.set (key, value);
	}

	/**
	 * Returns whether this attribute has the specified named argument.
	 *
	 * @param name argument name
	 * @return     true if the argument has been found, false otherwise
	 */
	public bool has_argument (string name) {
		return args.contains (name);
	}

	/**
	 * Returns the expression of the specified named argument.
	 *
	 * @param name argument name
	 * @return     expression value
	 */
	public Expression? get_expression (string name, Expression? default_value = null) {
		Expression? value = args.get (name);

		if (value == null) {
			return default_value;
		}

		return value;
	}

	/**
	 * Returns the string value of the specified named argument.
	 *
	 * @param name argument name
	 * @return     string value
	 */
	public string? get_string (string name, string? default_value = null) {
		Expression? value = args.get (name);

		if (value == null) {
			return default_value;
		}

		assert (value is StringLiteral);

		return ((StringLiteral) value).eval ();
	}

	/**
	 * Returns the integer value of the specified named argument.
	 *
	 * @param name argument name
	 * @return     integer value
	 */
	public int get_integer (string name, int default_value = 0) {
		Expression? value = args.get (name);

		if (value == null) {
			return default_value;
		}

		assert (value is IntegerLiteral);

		return int.parse (((IntegerLiteral) value).value);
	}

	/**
	 * Returns the double value of the specified named argument.
	 *
	 * @param name argument name
	 * @return     double value
	 */
	public double get_double (string name, double default_value = 0) {
		Expression? value = args.get (name);

		if (value == null) {
			return default_value;
		}

		assert (value is RealLiteral || value is IntegerLiteral);

		if (value is IntegerLiteral) {
			return int.parse (((IntegerLiteral) value).value);
		} else {
			return double.parse (((RealLiteral) value).value);
		}
	}

	/**
	 * Returns the boolean value of the specified named argument.
	 *
	 * @param name argument name
	 * @return     boolean value
	 */
	public bool get_bool (string name, bool default_value = false) {
		Expression? value = args.get (name);

		if (value == null) {
			return default_value;
		}

		assert (value is BooleanLiteral);

		return ((BooleanLiteral) value).value;
	}

	public override bool check (CodeContext context) {
		foreach (var attr in args.get_values ()) {
			if (!attr.check (context)) {
				return false;
			}
			if (!attr.is_constant ()) {
				Report.error (attr.source_reference, "attribute values must be constant");
				return false;
			}
		}

		return true;
	}
}
