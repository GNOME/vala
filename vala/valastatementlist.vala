/* valastatementlist.vala
 *
 * Copyright (C) 2008-2010  Jürg Billeter
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


public class Vala.StatementList : CodeNode, Statement {
	private List<Statement> list = new ArrayList<Statement> ();

	public int length {
		get { return list.size; }
	}

	public StatementList (SourceReference source_reference) {
		this.source_reference = source_reference;
	}

	public Statement get (int index) {
		return list.get (index);
	}

	public void set (int index, Statement stmt) {
		list.set (index, stmt);
	}

	public void add (Statement stmt) {
		list.add (stmt);
	}

	public void insert (int index, Statement stmt) {
		list.insert (index, stmt);
	}

	public override void accept (CodeVisitor visitor) {
		foreach (Statement stmt in list) {
			stmt.accept (visitor);
		}
	}

	public override void emit (CodeGenerator codegen) {
		foreach (Statement stmt in list) {
			stmt.emit (codegen);
		}
	}
}
