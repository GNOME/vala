/* valafield.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 * Represents a type or namespace field.
 */
public class Vala.Field : CodeNode {
	/**
	 * The symbol name of this field.
	 */
	public string! name { get; set construct; }

	/**
	 * The data type of this field.
	 */
	public TypeReference! type_reference { get; set construct; }

	/**
	 * Specifies the expression to be used to initialize this field.
	 */
	public Expression initializer { get; set; }
	
	/**
	 * Specifies the accessibility of this field. Public accessibility
	 * doesn't limit access. Default accessibility limits access to this
	 * program or library. Private accessibility limits access to instances
	 * of the contained type.
	 */
	public MemberAccessibility access;

	/**
	 * Specifies whether this field may only be accessed with an instance of
	 * the contained type.
	 */
	public bool instance {
		get {
			return _instance;
		}
		set {
			_instance = value;
		}
	}

	private string cname;
	private bool _instance = true;
	
	/**
	 * Creates a new field.
	 *
	 * @param name   field name
	 * @param type   field type
	 * @param init   initializer expression
	 * @param source reference to source code
	 * @return       newly created field
	 */
	public static ref Field! new (string! name, TypeReference! type, Expression init, SourceReference source) {
		return (new Field (name = name, type_reference = type, initializer = init, source_reference = source));
	}
	
	public override void accept (CodeVisitor! visitor) {
		type_reference.accept (visitor);
		
		if (initializer != null) {
			initializer.accept (visitor);
		}

		visitor.visit_field (this);
	}

	/**
	 * Returns the name of this field as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public string! get_cname () {
		if (cname == null) {
			cname = name;
		}
		return cname;
	}
	
	private void set_cname (string! cname) {
		this.cname = cname;
	}
	
	private void process_ccode_attribute (Attribute! a) {
		foreach (NamedArgument arg in a.args) {
			if (arg.name == "cname") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						set_cname (((StringLiteral) lit).eval ());
					}
				}
			}
		}
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			}
		}
	}
}
