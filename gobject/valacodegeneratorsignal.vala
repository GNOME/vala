/* valacodegeneratorsignal.vala
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
	private string get_marshaller_type_name (TypeReference t) {
		if (t.type_parameter != null) {
			return ("POINTER");
		} else if (t.data_type == null) {
			return ("VOID");
		} else {
			return t.data_type.get_marshaller_type_name ();
		}
	}
	
	private string get_signal_marshaller_function (Signal! sig, string prefix = null) {
		var signature = get_signal_signature (sig);
		string ret;
		var params = sig.get_parameters ();
		
		if (prefix == null) {
			// FIXME remove equality check with cast in next revision
			if (predefined_marshal_list.lookup (signature) != (bool) null) {
				prefix = "g_cclosure_marshal";
			} else {
				prefix = "g_cclosure_user_marshal";
			}
		}
		
		ret = "%s_%s_".printf (prefix, get_marshaller_type_name (sig.return_type));
		
		if (params == null) {
			ret = ret + "_VOID";
		} else {
			foreach (FormalParameter p in params) {
				ret = "%s_%s".printf (ret, get_marshaller_type_name (p.type_reference));
			}
		}
		
		return ret;
	}
	
	private string get_value_type_name_from_type_reference (TypeReference! t) {
		if (t.type_parameter != null) {
			return "gpointer";
		} else if (t.data_type == null) {
			return "void";
		} else if (t.data_type is Class || t.data_type is Interface) {
			return "GObject *";
		} else if (t.data_type is Struct) {
			if (((Struct) t.data_type).is_reference_type ()) {
				return "gpointer";
			} else {
				return t.data_type.get_cname ();
			}
		} else if (t.data_type is Enum) {
			return "gint";
		} else if (t.data_type is Flags) {
			return "guint";
		} else if (t.data_type is Array) {
			return "gpointer";
		}
		
		return null;
	}
	
	private string get_signal_signature (Signal! sig) {
		string signature;
		var params = sig.get_parameters ();
		
		signature = "%s:".printf (get_marshaller_type_name (sig.return_type));
		if (params == null) {
			signature = signature + "VOID";
		} else {
			bool first = true;
			foreach (FormalParameter p in params) {
				if (first) {
					signature = signature + get_marshaller_type_name (p.type_reference);
					first = false;
				} else {
					signature = "%s,%s".printf (signature, get_marshaller_type_name (p.type_reference));
				}
			}
		}
		
		return signature;
	}
	
	public override void visit_signal (Signal! sig) {
		sig.accept_children (this);

		string signature;
		var params = sig.get_parameters ();
		int n_params, i;
		
		/* check whether a signal with the same signature already exists for this source file (or predefined) */
		signature = get_signal_signature (sig);
		// FIXME remove equality checks with cast in next revision
		if (predefined_marshal_list.lookup (signature) != (bool) null || user_marshal_list.lookup (signature) != (bool) null) {
			return;
		}
		
		var signal_marshaller = new CCodeFunction (get_signal_marshaller_function (sig), "void");
		signal_marshaller.modifiers = CCodeModifiers.STATIC;
		
		signal_marshaller.add_parameter (new CCodeFormalParameter ("closure", "GClosure *"));
		signal_marshaller.add_parameter (new CCodeFormalParameter ("return_value", "GValue *"));
		signal_marshaller.add_parameter (new CCodeFormalParameter ("n_param_values", "guint"));
		signal_marshaller.add_parameter (new CCodeFormalParameter ("param_values", "const GValue *"));
		signal_marshaller.add_parameter (new CCodeFormalParameter ("invocation_hint", "gpointer"));
		signal_marshaller.add_parameter (new CCodeFormalParameter ("marshal_data", "gpointer"));
		
		source_signal_marshaller_declaration.append (signal_marshaller.copy ());
		
		var marshaller_body = new CCodeBlock ();
		
		var callback_decl = new CCodeFunctionDeclarator (get_signal_marshaller_function (sig, "GMarshalFunc"));
		callback_decl.add_parameter (new CCodeFormalParameter ("data1", "gpointer"));
		n_params = 1;
		foreach (FormalParameter p in params) {
			callback_decl.add_parameter (new CCodeFormalParameter ("arg_%d".printf (n_params), get_value_type_name_from_type_reference (p.type_reference)));
			n_params++;
		}
		callback_decl.add_parameter (new CCodeFormalParameter ("data2", "gpointer"));
		marshaller_body.add_statement (new CCodeTypeDefinition (get_value_type_name_from_type_reference (sig.return_type), callback_decl));
		
		var var_decl = new CCodeDeclaration (get_signal_marshaller_function (sig, "GMarshalFunc"));
		var_decl.modifiers = CCodeModifiers.REGISTER;
		var_decl.add_declarator (new CCodeVariableDeclarator ("callback"));
		marshaller_body.add_statement (var_decl);
		
		var_decl = new CCodeDeclaration ("GCClosure *");
		var_decl.modifiers = CCodeModifiers.REGISTER;
		var_decl.add_declarator (new CCodeVariableDeclarator.with_initializer ("cc", new CCodeCastExpression (new CCodeIdentifier ("closure"), "GCClosure *")));
		marshaller_body.add_statement (var_decl);
		
		var_decl = new CCodeDeclaration ("gpointer");
		var_decl.modifiers = CCodeModifiers.REGISTER;
		var_decl.add_declarator (new CCodeVariableDeclarator ("data1"));
		var_decl.add_declarator (new CCodeVariableDeclarator ("data2"));
		marshaller_body.add_statement (var_decl);
		
		CCodeFunctionCall fc;
		
		if (sig.return_type.data_type != null) {
			var_decl = new CCodeDeclaration (get_value_type_name_from_type_reference (sig.return_type));
			var_decl.add_declarator (new CCodeVariableDeclarator ("v_return"));
			marshaller_body.add_statement (var_decl);
			
			fc = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
			fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("return_value"), new CCodeConstant ("NULL")));
			marshaller_body.add_statement (new CCodeExpressionStatement (fc));
		}
		
		fc = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
		fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("n_param_values"), new CCodeConstant (n_params.to_string())));
		marshaller_body.add_statement (new CCodeExpressionStatement (fc));
		
		var data = new CCodeMemberAccess (new CCodeIdentifier ("closure"), "data", true);
		var param = new CCodeMemberAccess (new CCodeMemberAccess (new CCodeIdentifier ("param_values"), "data[0]", true), "v_pointer");
		var cond = new CCodeFunctionCall (new CCodeConstant ("G_CCLOSURE_SWAP_DATA"));
		cond.add_argument (new CCodeIdentifier ("closure"));
		var true_block = new CCodeBlock ();
		true_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data1"), data)));
		true_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data2"), param)));
		var false_block = new CCodeBlock ();
		false_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data1"), param)));
		false_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data2"), data)));
		marshaller_body.add_statement (new CCodeIfStatement (cond, true_block, false_block));
		
		var c_assign = new CCodeAssignment (new CCodeIdentifier ("callback"), new CCodeCastExpression (new CCodeConditionalExpression (new CCodeIdentifier ("marshal_data"), new CCodeIdentifier ("marshal_data"), new CCodeMemberAccess (new CCodeIdentifier ("cc"), "callback", true)), get_signal_marshaller_function (sig, "GMarshalFunc")));
		marshaller_body.add_statement (new CCodeExpressionStatement (c_assign));
		
		fc = new CCodeFunctionCall (new CCodeIdentifier ("callback"));
		fc.add_argument (new CCodeIdentifier ("data1"));
		i = 1;
		foreach (FormalParameter p in params) {
			string get_value_function;
			if (p.type_reference.type_parameter != null) {
				get_value_function = "g_value_get_pointer";
			} else {
				get_value_function = p.type_reference.data_type.get_get_value_function ();
			}
			var inner_fc = new CCodeFunctionCall (new CCodeIdentifier (get_value_function));
			inner_fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("param_values"), new CCodeIdentifier (i.to_string ())));
			fc.add_argument (inner_fc);
			i++;
		}
		fc.add_argument (new CCodeIdentifier ("data2"));
		
		if (sig.return_type.data_type != null) {
			marshaller_body.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("v_return"), fc)));
			
			CCodeFunctionCall set_fc;
			if (sig.return_type.type_parameter != null) {
				set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_set_pointer"));
			} else if (sig.return_type.data_type is Class || sig.return_type.data_type is Interface) {
				set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_take_object"));
			} else if (sig.return_type.data_type == string_type.data_type) {
				set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_take_string"));
			} else {
				set_fc = new CCodeFunctionCall (new CCodeIdentifier (sig.return_type.data_type.get_set_value_function ()));
			}
			set_fc.add_argument (new CCodeIdentifier ("return_value"));
			set_fc.add_argument (new CCodeIdentifier ("v_return"));
			
			marshaller_body.add_statement (new CCodeExpressionStatement (set_fc));
		} else {
			marshaller_body.add_statement (new CCodeExpressionStatement (fc));
		}
		
		signal_marshaller.block = marshaller_body;
		
		source_signal_marshaller_definition.append (signal_marshaller);
		user_marshal_list.insert (signature, true);
	}
}

