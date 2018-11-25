/* struct.vala
 *
 * Copyright (C) 2011  Florian Brosch
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

/**
 * Represents a struct declaration.
 */
public class Valadoc.Api.Struct : TypeSymbol {
	private string? dup_function_cname;
	private string? copy_function_cname;
	private string? free_function_cname;
	private string? destroy_function_cname;
	private string? type_id;
	private string? cname;

	public Struct (Node parent, SourceFile file, string name, Vala.SymbolAccessibility accessibility,
				   SourceComment? comment,
				   Vala.Struct data)
	{
		bool is_basic_type = data.base_type == null
			&& (data.is_boolean_type ()
			|| data.is_floating_type ()
			|| data.is_integer_type ());

		base (parent, file, name, accessibility, comment, is_basic_type, data);

		this.dup_function_cname = Vala.get_ccode_dup_function (data);
		this.copy_function_cname = Vala.get_ccode_copy_function (data);
		this.free_function_cname = Vala.get_ccode_free_function (data);
		this.destroy_function_cname = Vala.get_ccode_destroy_function (data);

		this.cname = Vala.get_ccode_name (data);
		this.type_id = Vala.get_ccode_type_id (data);
	}

	/**
	 * Specifies the base struct.
	 */
	public TypeReference? base_type {
		set;
		get;
	}


	/**
	 * Returns the name of this struct as it is used in C.
	 */
	public string? get_cname () {
		return cname;
	}

	/**
	 * Returns the C symbol representing the runtime type id for this data type.
	 */
	public string? get_type_id () {
		return type_id;
	}

	/**
	 * Returns the C function name that duplicates instances of this data
	 * type.
	 */
	public string? get_dup_function_cname () {
		return dup_function_cname;
	}

	/**
	 * Returns the C function name that copies instances of this data
	 * type.
	 */
	public string? get_copy_function_cname () {
		return copy_function_cname;
	}

	/**
	 * Returns the C function name that frees instances of this data type.
	 */
	public string? get_free_function_cname () {
		return free_function_cname;
	}

	/**
	 * Returns the C function name that destroys instances of this data type.
	 */
	public string? get_destroy_function_cname () {
		return destroy_function_cname;
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get { return NodeType.STRUCT; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_struct (this);
	}


	private Vala.Set<Struct> _known_child_structs = new Vala.HashSet<Struct> ();

	/**
	 * Returns a list of all known structs based on this struct
	 */
	public Vala.Collection<Struct> get_known_child_structs () {
		return _known_child_structs;
	}

	public void register_child_struct (Struct stru) {
		if (this.base_type != null) {
			((Struct) this.base_type.data_type).register_child_struct (stru);
		}

		_known_child_structs.add (stru);
	}


	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (accessibility.to_string ());
		signature.append_keyword ("struct");
		signature.append_symbol (this);

		var type_parameters = get_children_by_type (NodeType.TYPE_PARAMETER, false);
		if (type_parameters.size > 0) {
			signature.append ("<", false);
			bool first = true;
			foreach (Item param in type_parameters) {
				if (!first) {
					signature.append (",", false);
				}
				signature.append_content (param.signature, false);
				first = false;
			}
			signature.append (">", false);
		}

		if (base_type != null) {
			signature.append (":");

			signature.append_content (base_type.signature);
		}

		return signature.get ();
	}
}

