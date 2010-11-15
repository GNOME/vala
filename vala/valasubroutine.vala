/* valasubroutine.vala
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

public abstract class Vala.Subroutine : Symbol {
	Block _body;

	public BasicBlock entry_block { get; set; }

	public BasicBlock return_block { get; set; }

	public BasicBlock exit_block { get; set; }

	/**
	 * Specifies the generated `result` variable for postconditions.
	 */
	public LocalVariable result_var { get; set; }

	public abstract bool has_result { get; }

	protected Subroutine (string? name, SourceReference? source_reference, Comment? comment = null) {
		base (name, source_reference, comment);
	}

	public Block body {
		get { return _body; }
		set {
			_body = value;
			if (_body != null) {
				_body.owner = scope;
			}
		}
	}
}
