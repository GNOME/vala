/* valaphifunction.vala
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


public class Vala.PhiFunction {
	public Variable original_variable { get; private set; }

	public List<Variable?> operands { get; private set; }

	public PhiFunction (Variable variable, int num_of_ops) {
		this.original_variable = variable;
		this.operands = new ArrayList<Variable?> ();
		for (int i = 0; i < num_of_ops; i++) {
			this.operands.add ((Variable) null);
		}
	}
}
