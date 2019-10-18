/* parameter.vala
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
 * Represents a parameter in method, signal and delegate signatures.
 */
public class Valadoc.Api.Parameter : Symbol {
	public Content.Run default_value {
		get;
		set;
	}

	/**
	 * Used to translate imported C-documentation
	 */
	internal string? implicit_array_length_cparameter_name {
		get;
		set;
	}

	/**
	 * Used to translate imported C-documentation
	 */
	internal string? implicit_closure_cparameter_name {
		get;
		set;
	}

	/**
	 * Used to translate imported C-documentation
	 */
	internal string? implicit_destroy_cparameter_name {
		get;
		set;
	}

	private Vala.ParameterDirection type;

	public Parameter (Node parent, SourceFile file, string? name, Vala.SymbolAccessibility accessibility, Vala.ParameterDirection type, bool ellipsis, Vala.Parameter data) {
		base (parent, file, name, accessibility, null, data);
		assert ((name == null && ellipsis) || (name != null && !ellipsis));

		this.ellipsis = ellipsis;
		this.type = type;
	}

	/**
	 * Specifies whether the parameter direction is out
	 */
	public bool is_out {
		get {
			return type == Vala.ParameterDirection.OUT;
		}
	}

	/**
	 * Specifies whether the parameter direction is ref
	 */
	public bool is_ref {
		get {
			return type == Vala.ParameterDirection.REF;
		}
	}

	/**
	 * Specifies whether the parameter has a default value
	 */
	public bool has_default_value {
		get {
			return default_value != null;
		}
	}

	/**
	 * The parameter type.
	 */
	public TypeReference? parameter_type {
		set;
		get;
	}

	/**
	 * Specifies whether the methods accepts a variable number of arguments
	 */
	public bool ellipsis {
		private set;
		get;
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get { return NodeType.FORMAL_PARAMETER; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_formal_parameter (this);
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		if (ellipsis) {
			signature.append ("...");
		} else {
			if (is_out) {
				signature.append_keyword ("out");
			} else if (is_ref) {
				signature.append_keyword ("ref");
			}

			signature.append_content (parameter_type.signature);
			signature.append (name);

			if (has_default_value) {
				signature.append ("=");
				signature.append_content (default_value);
			}
		}

		return signature.get ();
	}
}

