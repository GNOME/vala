/* valaccodefunction.vala
 *
 * Copyright (C) 2006-2012  Jürg Billeter
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
 * Represents a function declaration in the C code.
 */
public class Vala.CCodeFunction : CCodeNode {
	/**
	 * The name of this function.
	 */
	public string name { get; set; }
	
	/**
	 * The function modifiers.
	 */
	public CCodeModifiers modifiers { get; set; }
	
	/**
	 * The function return type.
	 */
	public string return_type { get; set; }

	public string attributes { get; set; }

	public bool is_declaration { get; set; }

	/**
	 * The function body.
	 */
	public CCodeBlock block { get; set; }

	/**
	 * The current line directive.
	 */
	public CCodeLineDirective current_line { get; set; }

	private List<CCodeParameter> parameters = new ArrayList<CCodeParameter> ();

	CCodeBlock current_block;
	List<CCodeStatement> statement_stack = new ArrayList<CCodeStatement> ();

	public CCodeFunction (string name, string return_type = "void") {
		this.name = name;
		this.return_type = return_type;
		this.block = new CCodeBlock ();
		current_block = block;
	}
	
	/**
	 * Appends the specified parameter to the list of function parameters.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (CCodeParameter param) {
		parameters.add (param);
	}

	public void insert_parameter (int position, CCodeParameter param) {
		parameters.insert (position, param);
	}

	public int get_parameter_count () {
		return parameters.size;
	}

	public CCodeParameter get_parameter (int position) {
		return parameters[position];
	}

	/**
	 * Returns a copy of this function.
	 *
	 * @return copied function
	 */
	public CCodeFunction copy () {
		var func = new CCodeFunction (name, return_type);
		func.modifiers = modifiers;
		func.attributes = attributes;

		/* no deep copy for lists available yet
		 * func.parameters = parameters.copy ();
		 */
		foreach (CCodeParameter param in parameters) {
			func.parameters.add (param);
		}
		
		func.is_declaration = is_declaration;
		func.block = block;
		return func;
	}
	
	public override void write (CCodeWriter writer) {
		writer.write_indent (line);
		if (CCodeModifiers.STATIC in modifiers) {
			writer.write_string ("static ");
		}
		if (CCodeModifiers.INLINE in modifiers) {
			writer.write_string ("inline ");
		}
		writer.write_string (return_type);
		writer.write_string (" ");
		writer.write_string (name);
		writer.write_string (" (");
		
		bool first = true;
		foreach (CCodeParameter param in parameters) {
			if (!first) {
				writer.write_string (", ");
			} else {
				first = false;
			}
			param.write (writer);
		}
		if (first) {
			writer.write_string ("void");
		}
		
		writer.write_string (")");

		if (CCodeModifiers.DEPRECATED in modifiers) {
			writer.write_string (" G_GNUC_DEPRECATED");
		}

		if (is_declaration) {
			if (attributes != null) {
				writer.write_string (" ");
				writer.write_string (attributes);
			}

			writer.write_string (";");
		} else {
			block.write (writer);
			writer.write_newline ();
		}
		writer.write_newline ();
	}

	public void add_statement (CCodeNode stmt) {
		stmt.line = current_line;
		current_block.add_statement (stmt);
	}

	public void open_block () {
		statement_stack.add (current_block);
		var parent_block = current_block;

		current_block = new CCodeBlock ();

		parent_block.add_statement (current_block);
	}

	public void open_if (CCodeExpression condition) {
		statement_stack.add (current_block);
		var parent_block = current_block;

		current_block = new CCodeBlock ();

		var cif = new CCodeIfStatement (condition, current_block);
		cif.line = current_line;
		statement_stack.add (cif);

		parent_block.add_statement (cif);
	}

	public void add_else () {
		current_block = new CCodeBlock ();

		var cif = (CCodeIfStatement) statement_stack[statement_stack.size - 1];
		cif.line = current_line;
		assert (cif.false_statement == null);
		cif.false_statement = current_block;
	}

	public void else_if (CCodeExpression condition) {
		var parent_if = (CCodeIfStatement) statement_stack[statement_stack.size - 1];
		assert (parent_if.false_statement == null);

		statement_stack.remove_at (statement_stack.size - 1);

		current_block = new CCodeBlock ();

		var cif = new CCodeIfStatement (condition, current_block);
		cif.line = current_line;
		parent_if.false_statement = cif;
		statement_stack.add (cif);
	}

	public void open_while (CCodeExpression condition) {
		statement_stack.add (current_block);
		var parent_block = current_block;

		current_block = new CCodeBlock ();

		var cwhile = new CCodeWhileStatement (condition, current_block);
		cwhile.line = current_line;
		parent_block.add_statement (cwhile);
	}

	public void open_for (CCodeExpression? initializer, CCodeExpression condition, CCodeExpression? iterator) {
		statement_stack.add (current_block);
		var parent_block = current_block;

		current_block = new CCodeBlock ();

		var cfor = new CCodeForStatement (condition, current_block);
		cfor.line = current_line;
		if (initializer != null) {
			cfor.add_initializer (initializer);
		}
		if (iterator != null) {
			cfor.add_iterator (iterator);
		}

		parent_block.add_statement (cfor);
	}

	public void open_switch (CCodeExpression expression) {
		statement_stack.add (current_block);
		var parent_block = current_block;

		var cswitch = new CCodeSwitchStatement (expression);
		cswitch.line = current_line;
		current_block = cswitch;

		parent_block.add_statement (cswitch);
	}

	public void add_label (string label) {
		add_statement (new CCodeLabel (label));
	}

	public void add_case (CCodeExpression expression) {
		add_statement (new CCodeCaseStatement (expression));
	}

	public void add_default () {
		add_statement (new CCodeLabel ("default"));
	}

	public void add_goto (string target) {
		add_statement (new CCodeGotoStatement (target));
	}

	public void add_expression (CCodeExpression expression) {
		add_statement (new CCodeExpressionStatement (expression));
	}

	public void add_assignment (CCodeExpression left, CCodeExpression right) {
		add_expression (new CCodeAssignment (left, right));
	}

	public void add_return (CCodeExpression? expression = null) {
		add_statement (new CCodeReturnStatement (expression));
	}

	public void add_break () {
		add_statement (new CCodeBreakStatement ());
	}

	public void add_continue () {
		add_statement (new CCodeContinueStatement ());
	}

	public void add_declaration (string type_name, CCodeDeclarator declarator, CCodeModifiers modifiers = 0) {
		var stmt = new CCodeDeclaration (type_name);
		stmt.add_declarator (declarator);
		stmt.modifiers = modifiers;
		add_statement (stmt);
	}

	public void close () {
		do {
			var top = statement_stack[statement_stack.size - 1];
			statement_stack.remove_at (statement_stack.size - 1);
			current_block = top as CCodeBlock;
		} while (current_block == null);
	}
}
