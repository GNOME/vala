/* valaarraycreationexpression.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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
 * 	Raffaele Sandrini <raffaele@sandrini.ch>
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Represents an array creation expression e.g. {{{ new int[] {1,2,3} }}}.
 */
public class Vala.ArrayCreationExpression : Expression {
	/**
	 * The type of the elements of the array.
	 */
	public DataType element_type {
		get { return _element_type; }
		set {
			_element_type = value;
			_element_type.parent_node = this;
		}
	}
	
	/**
	 * The rank of the array.
	 */
	public int rank { get; set; }
	
	/**
	 * The size for each dimension ascending from left to right.
	 */
	private List<Expression> sizes = new ArrayList<Expression> ();
	
	/**
	 * The root array initializer list.
	 */
	public InitializerList? initializer_list {
		get { return _initializer_list; }
		set {
			_initializer_list = value;
			if (_initializer_list != null) {
				_initializer_list.parent_node = this;
			}
		}
	}

	private DataType _element_type;
	private InitializerList? _initializer_list;

	/**
	 * Add a size expression.
	 */
	public void append_size (Expression size) {
		sizes.add (size);
		if (size != null) {
			size.parent_node = this;
		}
	}
	
	/**
	 * Get the sizes for all dimensions ascending from left to right.
	 */
	public List<Expression> get_sizes () {
		return sizes;
	}
	
	public ArrayCreationExpression (DataType element_type, int rank, InitializerList? initializer_list, SourceReference source_reference) {
		this.element_type = element_type;
		this.rank = rank;
		this.initializer_list = initializer_list;
		this.source_reference = source_reference;
	}

	public override void accept_children (CodeVisitor visitor) {
		if (element_type != null) {
			element_type.accept (visitor);
		}

		foreach (Expression e in sizes) {
			e.accept (visitor);
		}

		if (initializer_list != null) {
			initializer_list.accept (visitor);
		}
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_array_creation_expression (this);

		visitor.visit_expression (this);
	}

	public override bool is_pure () {
		return false;
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		for (int i = 0; i < sizes.size; i++) {
			if (sizes[i] == old_node) {
				sizes[i] = new_node;
				return;
			}
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (element_type == old_type) {
			element_type = new_type;
		}
	}

	private int create_sizes_from_initializer_list (CodeContext context, InitializerList il, int rank, List<Literal> sl) {
		if (sl.size == (this.rank - rank)) {
			// only add size if this is the first initializer list of the current dimension
			var init = new IntegerLiteral (il.size.to_string (), il.source_reference);
			init.check (context);
			sl.add (init);
		}

		int subsize = -1;
		foreach (Expression e in il.get_initializers ()) {
			if (e is InitializerList) {
				if (rank == 1) {
					il.error = true;
					e.error = true;
					Report.error (e.source_reference, "Expected array element, got array initializer list");
					return -1;
				}
				int size = create_sizes_from_initializer_list (context, (InitializerList) e, rank - 1, sl);
				if (size == -1) {
					return -1;
				}
				if (subsize >= 0 && subsize != size) {
					il.error = true;
					Report.error (il.source_reference, "Expected initializer list of size %d, got size %d".printf (subsize, size));
					return -1;
				} else {
					subsize = size;
				}
			} else {
				if (rank != 1) {
					il.error = true;
					e.error = true;
					Report.error (e.source_reference, "Expected array initializer list, got array element");
					return -1;
				}
			}
		}
		return il.size;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		List<Expression> sizes = get_sizes ();
		var initlist = initializer_list;

		if (element_type != null) {
			element_type.check (context);
		}

		foreach (Expression e in sizes) {
			e.check (context);
		}

		var calc_sizes = new ArrayList<Literal> ();
		if (initlist != null) {
			initlist.target_type = new ArrayType (element_type, rank, source_reference);

			if (!initlist.check (context)) {
				error = true;
			}

			var ret = create_sizes_from_initializer_list (context, initlist, rank, calc_sizes);
			if (ret == -1) {
				error = true;
			}
		}

		if (sizes.size > 0) {
			/* check for errors in the size list */
			foreach (Expression e in sizes) {
				if (e.value_type == null) {
					/* return on previous error */
					return false;
				} else if (!(e.value_type is IntegerType || e.value_type is EnumValueType)) {
					error = true;
					Report.error (e.source_reference, "Expression of integer type expected");
				}
			}
		} else {
			if (initlist == null) {
				error = true;
				/* this is an internal error because it is already handeld by the parser */
				Report.error (source_reference, "internal error: initializer list expected");
			} else {
				foreach (Expression size in calc_sizes) {
					append_size (size);
				}
			}
		}

		if (error) {
			return false;
		}

		/* check for wrong elements inside the initializer */
		if (initializer_list != null && initializer_list.value_type == null) {
			return false;
		}

		/* try to construct the type of the array */
		if (element_type == null) {
			error = true;
			Report.error (source_reference, "Cannot determine the element type of the created array");
			return false;
		}

		element_type.value_owned = true;

		value_type = new ArrayType (element_type, rank, source_reference);
		value_type.value_owned = true;

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		foreach (Expression e in sizes) {
			e.emit (codegen);
		}

		if (initializer_list != null) {
			initializer_list.emit (codegen);
		}

		codegen.visit_array_creation_expression (this);

		codegen.visit_expression (this);
	}
}
