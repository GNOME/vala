/* valacodegeneratormemberaccess.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;

public class Vala.CodeGenerator {
	private void process_cmember (MemberAccess! expr, CCodeExpression pub_inst, DataType base_type) {
		if (expr.symbol_reference.node is Method) {
			var m = (Method) expr.symbol_reference.node;
			
			if (expr.inner is BaseAccess) {
				if (m.base_interface_method != null) {
					var base_iface = (Interface) m.base_interface_method.symbol.parent_symbol.node;
					string parent_iface_var = "%s_%s_parent_iface".printf (current_class.get_lower_case_cname (null), base_iface.get_lower_case_cname (null));

					expr.ccodenode = new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), m.name);
					return;
				} else if (m.base_method != null) {
					var base_class = (Class) m.base_method.symbol.parent_symbol.node;
					var vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (base_class.get_upper_case_cname (null))));
					vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (current_class.get_lower_case_cname (null))));
					
					expr.ccodenode = new CCodeMemberAccess.pointer (vcast, m.name);
					return;
				}
			}
			
			if (m.base_interface_method != null) {
				expr.ccodenode = new CCodeIdentifier (m.base_interface_method.get_cname ());
			} else if (m.base_method != null) {
				expr.ccodenode = new CCodeIdentifier (m.base_method.get_cname ());
			} else {
				expr.ccodenode = new CCodeIdentifier (m.get_cname ());
			}
		} else if (expr.symbol_reference.node is ArrayLengthField) {
			expr.ccodenode = get_array_length_cexpression (expr.inner, 1);
		} else if (expr.symbol_reference.node is Field) {
			var f = (Field) expr.symbol_reference.node;
			if (f.instance) {
				ref CCodeExpression typed_inst;
				if (f.symbol.parent_symbol.node != base_type) {
					// FIXME: use C cast if debugging disabled
					typed_inst = new CCodeFunctionCall (new CCodeIdentifier (((DataType) f.symbol.parent_symbol.node).get_upper_case_cname (null)));
					((CCodeFunctionCall) typed_inst).add_argument (pub_inst);
				} else {
					typed_inst = pub_inst;
				}
				ref CCodeExpression inst;
				if (f.access == MemberAccessibility.PRIVATE) {
					inst = new CCodeMemberAccess.pointer (typed_inst, "priv");
				} else {
					inst = typed_inst;
				}
				if (((DataType) f.symbol.parent_symbol.node).is_reference_type ()) {
					expr.ccodenode = new CCodeMemberAccess.pointer (inst, f.get_cname ());
				} else {
					expr.ccodenode = new CCodeMemberAccess (inst, f.get_cname ());
				}
			} else {
				expr.ccodenode = new CCodeIdentifier (f.get_cname ());
			}
		} else if (expr.symbol_reference.node is Constant) {
			var c = (Constant) expr.symbol_reference.node;
			expr.ccodenode = new CCodeIdentifier (c.get_cname ());
		} else if (expr.symbol_reference.node is Property) {
			var prop = (Property) expr.symbol_reference.node;

			if (!prop.no_accessor_method) {
				var base_property = prop;
				if (prop.base_property != null) {
					base_property = prop.base_property;
				} else if (prop.base_interface_property != null) {
					base_property = prop.base_interface_property;
				}
				var base_property_type = (DataType) base_property.symbol.parent_symbol.node;
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_get_%s".printf (base_property_type.get_lower_case_cname (null), base_property.name)));
				
				CCodeExpression typed_pub_inst = pub_inst;

				/* cast if necessary */
				if (base_property_type != base_type) {
					// FIXME: use C cast if debugging disabled
					var ccast = new CCodeFunctionCall (new CCodeIdentifier (base_property_type.get_upper_case_cname (null)));
					ccast.add_argument (pub_inst);
					typed_pub_inst = ccast;
				}

				ccall.add_argument (typed_pub_inst);
				expr.ccodenode = ccall;
			} else {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
			
				var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT"));
				ccast.add_argument (pub_inst);
				ccall.add_argument (ccast);
				
				// property name is second argument of g_object_get
				ccall.add_argument (prop.get_canonical_cconstant ());
				
				
				// we need a temporary variable to save the property value
				var temp_decl = get_temp_variable_declarator (expr.static_type);
				temp_vars.prepend (temp_decl);

				var ctemp = new CCodeIdentifier (temp_decl.name);
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
				
				
				ccall.add_argument (new CCodeConstant ("NULL"));
				
				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (ccall);
				ccomma.append_expression (ctemp);
				expr.ccodenode = ccomma;
			}
		} else if (expr.symbol_reference.node is EnumValue) {
			var ev = (EnumValue) expr.symbol_reference.node;
			expr.ccodenode = new CCodeConstant (ev.get_cname ());
		} else if (expr.symbol_reference.node is VariableDeclarator) {
			var decl = (VariableDeclarator) expr.symbol_reference.node;
			expr.ccodenode = new CCodeIdentifier (get_variable_cname (decl.name));
		} else if (expr.symbol_reference.node is FormalParameter) {
			var p = (FormalParameter) expr.symbol_reference.node;
			if (p.name == "this") {
				expr.ccodenode = pub_inst;
			} else {
				if (p.type_reference.is_out || p.type_reference.reference_to_value_type) {
					expr.ccodenode = new CCodeIdentifier ("(*%s)".printf (p.name));
				} else {
					expr.ccodenode = new CCodeIdentifier (p.name);
				}
			}
		} else if (expr.symbol_reference.node is Signal) {
			var sig = (Signal) expr.symbol_reference.node;
			var cl = (DataType) sig.symbol.parent_symbol.node;
			
			if (sig.has_emitter) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_%s".printf (cl.get_lower_case_cname (null), sig.name)));
				
				/* explicitly use strong reference as ccast
				 * gets unrefed at the end of the inner block
				 */
				ref CCodeExpression typed_pub_inst = pub_inst;

				/* cast if necessary */
				if (cl != base_type) {
					// FIXME: use C cast if debugging disabled
					var ccast = new CCodeFunctionCall (new CCodeIdentifier (cl.get_upper_case_cname (null)));
					ccast.add_argument (pub_inst);
					typed_pub_inst = ccast;
				}

				ccall.add_argument (typed_pub_inst);
				expr.ccodenode = ccall;
			} else {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_emit_by_name"));

				// FIXME: use C cast if debugging disabled
				var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT"));
				ccast.add_argument (pub_inst);
				ccall.add_argument (ccast);

				ccall.add_argument (sig.get_canonical_cconstant ());
				
				expr.ccodenode = ccall;
			}
		}
	}

	public override void visit_member_access (MemberAccess! expr) {
		CCodeExpression pub_inst = null;
		DataType base_type = null;
	
		if (expr.inner == null) {
			pub_inst = new CCodeIdentifier ("self");

			if (current_type_symbol != null) {
				/* base type is available if this is a type method */
				base_type = (DataType) current_type_symbol.node;
				
				if (!base_type.is_reference_type ()) {
					pub_inst = new CCodeIdentifier ("(*self)");
				}
			}
		} else {
			pub_inst = (CCodeExpression) expr.inner.ccodenode;

			if (expr.inner.static_type != null) {
				base_type = expr.inner.static_type.data_type;
			}
		}

		process_cmember (expr, pub_inst, base_type);

		visit_expression (expr);
	}
}

