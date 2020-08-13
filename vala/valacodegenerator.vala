/* valacodegenerator.vala
 *
 * Copyright (C) 2007-2011  Jürg Billeter
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

/**
 * Abstract code visitor generating code.
 */
public abstract class Vala.CodeGenerator : CodeVisitor {
	/**
	 * Generate and emit C code for the specified code context.
	 *
	 * @param context a code context
	 */
	public virtual void emit (CodeContext context) {
	}

	public abstract TargetValue load_local (LocalVariable local, Expression? expr = null);

	public abstract void store_local (LocalVariable local, TargetValue value, bool initializer, SourceReference? source_reference = null);

	public abstract TargetValue load_parameter (Parameter param, Expression? expr = null);

	public abstract void store_parameter (Parameter param, TargetValue value, bool capturing_parameter = false, SourceReference? source_reference = null);

	public abstract TargetValue load_field (Field field, TargetValue? instance, Expression? expr = null);

	public abstract void store_field (Field field, TargetValue? instance, TargetValue value, SourceReference? source_reference = null);
}
