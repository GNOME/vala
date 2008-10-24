/* valaccodemodule.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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

using Gee;

/**
 * Code visitor generating C Code.
 */
public abstract class Vala.CCodeModule {
	public weak CCodeGenerator codegen { get; private set; }

	public CCodeModule head {
		get { return _head; }
		private set {
			_head = value;
			// propagate head property to all modules
			if (next != null) {
				next.head = value;
			}
		}
	}

	weak CCodeModule _head;
	CCodeModule? next;

	public CCodeModule (CCodeGenerator codegen, CCodeModule? next) {
		this.codegen = codegen;
		this.next = next;
		this.head = this;
	}

	public virtual void emit (CodeContext context) {
		if (next != null) {
			next.emit (context);
		}
	}
}
