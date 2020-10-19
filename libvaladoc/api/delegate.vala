/* delegate.vala
 *
 * Copyright (C) 2008-2011  Florian Brosch
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
 * Represents a Delegate.
 */
public class Valadoc.Api.Delegate : TypeSymbol, Callable {
	private string? cname;

	/**
	 * {@inheritDoc}
	 */
	internal string? implicit_array_length_cparameter_name {
		get;
		set;
	}


	public Delegate (Node parent, SourceFile file, string name, Vala.SymbolAccessibility accessibility,
					 SourceComment? comment, Vala.Delegate data)
	{
		base (parent, file, name, accessibility, comment, false, data);

		this.is_static = !data.has_target;
		this.cname = Vala.get_ccode_name (data);
	}

	/**
	 * Returns the name of this delegate as it is used in C.
	 */
	public string? get_cname () {
		return cname;
	}

	/**
	 * {@inheritDoc}
	 */
	public TypeReference? return_type {
		set;
		get;
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get { return NodeType.DELEGATE; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_delegate (this);
	}

	/**
	 * Specifies whether this delegate is static
	 */
	public bool is_static {
		private set;
		get;
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (accessibility.to_string ());
		signature.append_keyword ("delegate");
		signature.append_content (return_type.signature);
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

		signature.append ("(");

		bool first = true;
		foreach (Node param in get_children_by_type (NodeType.FORMAL_PARAMETER, false)) {
			if (!first) {
				signature.append (",", false);
			}
			signature.append_content (param.signature, !first);
			first = false;
		}

		signature.append (")", false);

		var exceptions = get_children_by_types ({NodeType.ERROR_DOMAIN, NodeType.CLASS});
		if (exceptions.size > 0) {
			signature.append_keyword ("throws");
			first = true;
			foreach (Node param in exceptions) {
				if (!first) {
					signature.append (",", false);
				}
				signature.append_type (param);
				first = false;
			}
		}

		return signature.get ();
	}
}

