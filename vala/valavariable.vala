/* valavariable.vala
 *
 * Copyright (C) 2010  Jürg Billeter
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

public class Vala.Variable : Symbol {
	/**
	 * The optional initializer expression.
	 */
	public Expression? initializer {
		get {
			return _initializer;
		}
		set {
			_initializer = value;
			if (_initializer != null) {
				_initializer.parent_node = this;
			}
		}
	}
	
	/**
	 * The variable type.
	 */
	public DataType? variable_type {
		get { return _variable_type; }
		set {
			_variable_type = value;
			if (_variable_type != null) {
				_variable_type.parent_node = this;
			}
		}
	}

	public bool single_assignment { get; set; }

	Expression? _initializer;
	DataType? _variable_type;

	public Variable (DataType? variable_type, string? name, Expression? initializer = null, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
		this.variable_type = variable_type;
		this.initializer = initializer;
	}
}
