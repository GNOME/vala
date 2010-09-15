/* valadbusservermodule.vala
 *
 * Copyright (C) 2007-2009  Jürg Billeter
*  Copyright (C) 2008  Philip Van Hoof
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
 * 	Philip Van Hoof <pvanhoof@gnome.org>
 */

using GLib;

/**
 * The link between a dynamic method and generated code.
 */
public class Vala.DBusServerModule : DBusClientModule {
	public static bool is_dbus_visible (CodeNode node) {
		var dbus_attribute = node.get_attribute ("DBus");
		if (dbus_attribute != null
		    && dbus_attribute.has_argument ("visible")
		    && !dbus_attribute.get_bool ("visible")) {
			return false;
		}

		return true;
	}

	public static string dbus_result_name (Method m) {
		var dbus_attribute = m.get_attribute ("DBus");
		if (dbus_attribute != null
		    && dbus_attribute.has_argument ("result")) {
			var result_name = dbus_attribute.get_string ("result");
			if (result_name != null && result_name != "") {
				return result_name;
			}
		}

		return "result";
	}

	void send_reply (CCodeBlock block) {
		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_send"));
		ccall.add_argument (new CCodeIdentifier ("connection"));
		ccall.add_argument (new CCodeIdentifier ("reply"));
		ccall.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (ccall));
		ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
		ccall.add_argument (new CCodeIdentifier ("reply"));
		block.add_statement (new CCodeExpressionStatement (ccall));
	}

	void handle_reply (CCodeBlock block) {
		var handled = new CCodeBlock ();
		send_reply (handled);
		handled.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("DBUS_HANDLER_RESULT_HANDLED")));

		var not_handled = new CCodeBlock ();
		not_handled.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("DBUS_HANDLER_RESULT_NOT_YET_HANDLED")));

		block.add_statement (new CCodeIfStatement (new CCodeIdentifier ("reply"), handled, not_handled));
	}

	string generate_dbus_wrapper (Method m, ObjectTypeSymbol sym) {
		string wrapper_name = "_dbus_%s".printf (m.get_cname ());

		// declaration

		CCodeDeclaration cdecl;

		var function = new CCodeFunction (wrapper_name, "DBusHandlerResult");
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeFormalParameter ("self", sym.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("connection", "DBusConnection*"));
		function.add_parameter (new CCodeFormalParameter ("message", "DBusMessage*"));
		var block = new CCodeBlock ();

		CCodeFunction ready_function = null;
		CCodeBlock ready_block = null;
		if (m.coroutine) {
			// GAsyncResult
			source_declarations.add_include ("gio/gio.h");

			ready_function = new CCodeFunction (wrapper_name + "_ready", "void");
			ready_function.modifiers = CCodeModifiers.STATIC;
			ready_function.add_parameter (new CCodeFormalParameter ("source_object", "GObject *"));
			ready_function.add_parameter (new CCodeFormalParameter ("_res_", "GAsyncResult *"));
			ready_function.add_parameter (new CCodeFormalParameter ("_user_data_", "gpointer *"));
			ready_block = new CCodeBlock ();

			cdecl = new CCodeDeclaration ("DBusConnection *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("connection", new CCodeIdentifier ("_user_data_[0]")));
			ready_block.add_statement (cdecl);
			cdecl = new CCodeDeclaration ("DBusMessage *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("message", new CCodeIdentifier ("_user_data_[1]")));
			ready_block.add_statement (cdecl);
		}

		var in_prefragment = new CCodeFragment ();
		var in_postfragment = new CCodeFragment ();
		var out_prefragment = in_prefragment;
		var out_postfragment = in_postfragment;

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator ("iter"));
		block.add_statement (cdecl);
		if (m.coroutine) {
			out_prefragment = new CCodeFragment ();
			out_postfragment = new CCodeFragment ();
			ready_block.add_statement (cdecl);
		}

		cdecl = new CCodeDeclaration ("GError*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("error", new CCodeConstant ("NULL")));
		if (m.coroutine) {
			ready_block.add_statement (cdecl);
		} else {
			block.add_statement (cdecl);
		}

		block.add_statement (in_prefragment);
		if (m.coroutine) {
			ready_block.add_statement (out_prefragment);
		}

		var message_signature = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_get_signature"));
		message_signature.add_argument (new CCodeIdentifier ("message"));
		var signature_check = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
		signature_check.add_argument (message_signature);
		var signature_error_block = new CCodeBlock ();
		signature_error_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("DBUS_HANDLER_RESULT_NOT_YET_HANDLED")));
		in_prefragment.append (new CCodeIfStatement (signature_check, signature_error_block));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init"));
		iter_call.add_argument (new CCodeIdentifier ("message"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("iter")));
		in_prefragment.append (new CCodeExpressionStatement (iter_call));

		cdecl = new CCodeDeclaration ("DBusMessage*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("reply"));
		out_postfragment.append (cdecl);

		var msgcall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_new_method_return"));
		msgcall.add_argument (new CCodeIdentifier ("message"));
		out_postfragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("reply"), msgcall)));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init_append"));
		iter_call.add_argument (new CCodeIdentifier ("reply"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("iter")));
		out_postfragment.append (new CCodeExpressionStatement (iter_call));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_cname ()));

		CCodeFunctionCall finish_ccall = null;
		if (m.coroutine) {
			finish_ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_finish_cname ()));
			finish_ccall.add_argument (new CCodeCastExpression (new CCodeIdentifier ("source_object"), sym.get_cname () + "*"));
			finish_ccall.add_argument (new CCodeIdentifier ("_res_"));
		}

		ccall.add_argument (new CCodeIdentifier ("self"));

		// expected type signature for input parameters
		string type_signature = "";

		foreach (FormalParameter param in m.get_parameters ()) {
			var owned_type = param.variable_type.copy ();
			owned_type.value_owned = true;

			cdecl = new CCodeDeclaration (owned_type.get_cname ());
			cdecl.add_declarator (new CCodeVariableDeclarator.zero (param.name, default_value_for_type (param.variable_type, true)));
			if (param.direction == ParameterDirection.IN) {
				in_prefragment.append (cdecl);
			} else {
				out_prefragment.append (cdecl);
			}
			if (type_signature == ""
			    && param.direction == ParameterDirection.IN
			    && param.variable_type.data_type != null
			    && param.variable_type.data_type.get_full_name () == "DBus.BusName") {
				// first parameter is a string parameter called 'sender'
				// pass bus name of sender
				var get_sender = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_get_sender"));
				get_sender.add_argument (new CCodeIdentifier ("message"));
				ccall.add_argument (get_sender);
				continue;
			}

			if (get_type_signature (param.variable_type) == null) {
				Report.error (param.variable_type.source_reference, "D-Bus serialization of type `%s' is not supported".printf (param.variable_type.to_string ()));
				continue;
			}

			if (!m.coroutine || param.direction == ParameterDirection.IN) {
				var st = param.variable_type.data_type as Struct;
				if (param.direction != ParameterDirection.IN
				    || (st != null && !st.is_simple_type ())) {
					ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
				} else {
					ccall.add_argument (new CCodeIdentifier (param.name));
				}
			} else {
				finish_ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
			}

			if (param.variable_type is ArrayType) {
				var array_type = (ArrayType) param.variable_type;

				for (int dim = 1; dim <= array_type.rank; dim++) {
					string length_cname = get_parameter_array_length_cname (param, dim);

					cdecl = new CCodeDeclaration ("int");
					cdecl.add_declarator (new CCodeVariableDeclarator (length_cname, new CCodeConstant ("0")));
					if (!m.coroutine || param.direction == ParameterDirection.IN) {
						if (param.direction != ParameterDirection.IN) {
							out_prefragment.append (cdecl);
							ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (length_cname)));
						} else {
							in_prefragment.append (cdecl);
							ccall.add_argument (new CCodeIdentifier (length_cname));
						}
					} else {
						out_prefragment.append (cdecl);
						finish_ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (length_cname)));
					}
				}
			}

			if (param.direction == ParameterDirection.IN) {
				type_signature += get_type_signature (param.variable_type);

				var target = new CCodeIdentifier (param.name);
				var expr = read_expression (in_prefragment, param.variable_type, new CCodeIdentifier ("iter"), target);
				in_prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (target, expr)));
			} else {
				write_expression (out_postfragment, param.variable_type, new CCodeIdentifier ("iter"), new CCodeIdentifier (param.name));
			}

			if (requires_destroy (owned_type)) {
				// keep local alive (symbol_reference is weak)
				var local = new LocalVariable (owned_type, param.name);
				var ma = new MemberAccess.simple (param.name);
				ma.symbol_reference = local;
				var stmt = new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (param.name), owned_type, ma));
				if (param.direction == ParameterDirection.IN) {
					in_postfragment.append (stmt);
				} else {
					out_postfragment.append (stmt);
				}
			}
		}

		signature_check.add_argument (new CCodeConstant ("\"%s\"".printf (type_signature)));

		if (!(m.return_type is VoidType)) {
			if (get_type_signature (m.return_type) == null) {
				Report.error (m.return_type.source_reference, "D-Bus serialization of type `%s' is not supported".printf (m.return_type.to_string ()));
			} else if (m.return_type.is_real_non_null_struct_type ()) {
				cdecl = new CCodeDeclaration (m.return_type.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator.zero ("result", default_value_for_type (m.return_type, true)));
				out_prefragment.append (cdecl);

				if (!m.coroutine) {
					ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
				} else {
					finish_ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
				}

				write_expression (out_postfragment, m.return_type, new CCodeIdentifier ("iter"), new CCodeIdentifier ("result"));

				if (requires_destroy (m.return_type)) {
					// keep local alive (symbol_reference is weak)
					// space before `result' is work around to not trigger
					// variable renaming, we really mean C identifier `result' here
					var local = new LocalVariable (m.return_type, " result");
					var ma = new MemberAccess.simple ("result");
					ma.symbol_reference = local;
					out_postfragment.append (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier ("result"), m.return_type, ma)));
				}

				block.add_statement (new CCodeExpressionStatement (ccall));
				if (m.coroutine) {
					ready_block.add_statement (new CCodeExpressionStatement (finish_ccall));
				}
			} else {
				cdecl = new CCodeDeclaration (m.return_type.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
				out_prefragment.append (cdecl);
				if (!m.coroutine) {
					block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("result"), ccall)));
				} else {
					block.add_statement (new CCodeExpressionStatement (ccall));
					ready_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("result"), finish_ccall)));
				}

				if (m.return_type is ArrayType) {
					var array_type = (ArrayType) m.return_type;

					for (int dim = 1; dim <= array_type.rank; dim++) {
						string length_cname = get_array_length_cname ("result", dim);

						cdecl = new CCodeDeclaration ("int");
						cdecl.add_declarator (new CCodeVariableDeclarator (length_cname, new CCodeConstant ("0")));
						out_prefragment.append (cdecl);
						if (!m.coroutine) {
							ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (length_cname)));
						} else {
							finish_ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (length_cname)));
						}
					}
				}

				write_expression (out_postfragment, m.return_type, new CCodeIdentifier ("iter"), new CCodeIdentifier ("result"));

				if (requires_destroy (m.return_type)) {
					// keep local alive (symbol_reference is weak)
					// space before `result' is work around to not trigger
					// variable renaming, we really mean C identifier `result' here
					var local = new LocalVariable (m.return_type, " result");
					var ma = new MemberAccess.simple ("result");
					ma.symbol_reference = local;
					out_postfragment.append (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier ("result"), m.return_type, ma)));
				}
			}
		} else {
			block.add_statement (new CCodeExpressionStatement (ccall));
			if (m.coroutine) {
				ready_block.add_statement (new CCodeExpressionStatement (finish_ccall));
			}
		}

		if (m.coroutine) {
			ccall.add_argument (new CCodeCastExpression (new CCodeIdentifier (wrapper_name + "_ready"), "GAsyncReadyCallback"));

			var new_call = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
			new_call.add_argument (new CCodeIdentifier ("gpointer"));
			new_call.add_argument (new CCodeConstant ("2"));
			cdecl = new CCodeDeclaration ("gpointer *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_user_data_", new_call));
			in_prefragment.append (cdecl);

			var ref_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_ref"));
			ref_call.add_argument (new CCodeIdentifier ("connection"));
			in_prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_user_data_[0]"), ref_call)));
			ref_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_ref"));
			ref_call.add_argument (new CCodeIdentifier ("message"));
			in_prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_user_data_[1]"), ref_call)));

			ccall.add_argument (new CCodeIdentifier ("_user_data_"));
		}

		if (m.get_error_types ().size > 0) {
			if (m.coroutine) {
				finish_ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("error")));
			} else {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("error")));
			}

			var error_block = new CCodeBlock ();

			generate_server_error_cases (error_block, m.get_error_types (), new CCodeIdentifier ("error"), new CCodeIdentifier ("message"), new CCodeIdentifier ("reply"));

			send_reply (error_block);

			if (m.coroutine) {
				error_block.add_statement (new CCodeReturnStatement ());
				ready_block.add_statement (new CCodeIfStatement (new CCodeIdentifier ("error"), error_block));
			} else {
				error_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("DBUS_HANDLER_RESULT_HANDLED")));
				block.add_statement (new CCodeIfStatement (new CCodeIdentifier ("error"), error_block));
			}
		}

		block.add_statement (in_postfragment);

		if (!m.coroutine) {
			handle_reply (block);
		} else {
			block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("DBUS_HANDLER_RESULT_HANDLED")));

			ready_block.add_statement (out_postfragment);

			send_reply (ready_block);

			var unref_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_unref"));
			unref_call.add_argument (new CCodeIdentifier ("connection"));
			ready_block.add_statement (new CCodeExpressionStatement (unref_call));
			unref_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
			unref_call.add_argument (new CCodeIdentifier ("message"));
			ready_block.add_statement (new CCodeExpressionStatement (unref_call));
			var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
			free_call.add_argument (new CCodeIdentifier ("_user_data_"));
			ready_block.add_statement (new CCodeExpressionStatement (free_call));
		}

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		if (m.coroutine) {
			source_declarations.add_type_member_declaration (ready_function.copy ());

			ready_function.block = ready_block;
			source_type_member_definition.append (ready_function);
		}

		return wrapper_name;
	}

	void generate_server_error_cases (CCodeBlock error_block, List<DataType> error_types, CCodeExpression error, CCodeExpression message, CCodeExpression reply) {
		CCodeStatement if_else_if = null;
		CCodeIfStatement last_statement = null;

		foreach (DataType error_type in error_types) {
			var edomain = ((ErrorType) error_type).error_domain;

			if (edomain == null) {
				Report.error (error_type.source_reference, "Generic errors cannot be serialized over DBus");
				continue;
			}

			var edomain_dbus_name = get_dbus_name (edomain);
			if (edomain_dbus_name == null) {
				Report.error (edomain.source_reference, "Errordomain must have a DBus.name annotation to be serialized over DBus");
			}

			var true_block = new CCodeBlock ();
			true_block.suppress_newline = true;

			var cswitch = new CCodeSwitchStatement (new CCodeMemberAccess.pointer (error, "code"));
			foreach (ErrorCode ecode in edomain.get_codes ()) {
				cswitch.add_statement (new CCodeCaseStatement (new CCodeIdentifier (ecode.get_cname ())));

				var ecode_dbus_name = get_dbus_name (ecode);
				if (ecode_dbus_name == null) {
					ecode_dbus_name = Symbol.lower_case_to_camel_case (ecode.name.down ());
				}

				string dbus_name = "%s.%s".printf (edomain_dbus_name, ecode_dbus_name);

				var msgcall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_new_error"));
				msgcall.add_argument (message);
				msgcall.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_name)));
				msgcall.add_argument (new CCodeMemberAccess.pointer (error, "message"));
				cswitch.add_statement (new CCodeExpressionStatement (new CCodeAssignment (reply, msgcall)));

				cswitch.add_statement (new CCodeBreakStatement ());
			}
			true_block.add_statement (cswitch);

			var equal_test = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeMemberAccess.pointer (error, "domain"), new CCodeIdentifier (edomain.get_upper_case_cname ()));
			var stmt = new CCodeIfStatement (equal_test, true_block);

			if (last_statement != null) {
				last_statement.false_statement = stmt;
			} else {
				if_else_if = stmt;
			}
			last_statement = stmt;
		}
		error_block.add_statement (if_else_if);
	}

	string generate_dbus_signal_wrapper (Signal sig, ObjectTypeSymbol sym, string dbus_iface_name) {
		string wrapper_name = "_dbus_%s_%s".printf (sym.get_lower_case_cname (), sig.get_cname ());

		// declaration

		CCodeDeclaration cdecl;

		var function = new CCodeFunction (wrapper_name, "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("_sender", "GObject*"));

		foreach (var param in sig.get_parameters ()) {
			// ensure ccodenode of parameter is set
			generate_parameter (param, source_declarations, new HashMap<int,CCodeFormalParameter> (), null);

			function.add_parameter ((CCodeFormalParameter) get_ccodenode (param));
			if (param.variable_type is ArrayType) {
				var array_type = (ArrayType) param.variable_type;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					function.add_parameter (new CCodeFormalParameter (get_parameter_array_length_cname (param, dim), "int"));
				}
			}
		}

		function.add_parameter (new CCodeFormalParameter ("_connection", "DBusConnection*"));

		var block = new CCodeBlock ();
		var prefragment = new CCodeFragment ();

		var path = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get_data"));
		path.add_argument (new CCodeIdentifier ("_sender"));
		path.add_argument (new CCodeConstant ("\"dbus_object_path\""));

		cdecl = new CCodeDeclaration ("const char *");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_path", path));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessage");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_message"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_iter"));
		block.add_statement (cdecl);

		block.add_statement (prefragment);

		var msgcall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_new_signal"));
		msgcall.add_argument (new CCodeIdentifier ("_path"));
		msgcall.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_iface_name)));
		msgcall.add_argument (new CCodeConstant ("\"%s\"".printf (get_dbus_name_for_member (sig))));
		prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_message"), msgcall)));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init_append"));
		iter_call.add_argument (new CCodeIdentifier ("_message"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_iter")));
		prefragment.append (new CCodeExpressionStatement (iter_call));

		foreach (FormalParameter param in sig.get_parameters ()) {
			CCodeExpression expr = new CCodeIdentifier (param.name);
			if (param.variable_type.is_real_struct_type ()) {
				expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, expr);
			}
			write_expression (prefragment, param.variable_type, new CCodeIdentifier ("_iter"), expr);
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_send"));
		ccall.add_argument (new CCodeIdentifier ("_connection"));
		ccall.add_argument (new CCodeIdentifier ("_message"));
		ccall.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (ccall));

		var message_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
		message_unref.add_argument (new CCodeIdentifier ("_message"));
		block.add_statement (new CCodeExpressionStatement (message_unref));

		source_declarations.add_type_member_declaration (function.copy ());
		function.block = block;
		source_type_member_definition.append (function);

		return wrapper_name;
	}

	void generate_register_function (ObjectType object_type) {
		// strcmp
		source_declarations.add_include ("string.h");

		var sym = object_type.type_symbol;

		var cfunc = new CCodeFunction (sym.get_lower_case_cprefix () + "dbus_register_object", "void");
		cfunc.add_parameter (new CCodeFormalParameter ("connection", "DBusConnection*"));
		cfunc.add_parameter (new CCodeFormalParameter ("path", "const char*"));
		cfunc.add_parameter (new CCodeFormalParameter ("object", "void*"));

		add_dbus_helpers ();

		if (sym.is_private_symbol ()) {
			cfunc.modifiers |= CCodeModifiers.STATIC;
		}

		source_declarations.add_type_member_declaration (cfunc.copy ());

		var block = new CCodeBlock ();
		cfunc.block = block;

		var get_path = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get_data"));
		get_path.add_argument (new CCodeIdentifier ("object"));
		get_path.add_argument (new CCodeConstant ("\"dbus_object_path\""));
		var register_check = new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, get_path);

		var register_block = new CCodeBlock ();

		var path_dup = new CCodeFunctionCall (new CCodeIdentifier ("g_strdup"));
		path_dup.add_argument (new CCodeIdentifier ("path"));

		var set_path = new CCodeFunctionCall (new CCodeIdentifier ("g_object_set_data"));
		set_path.add_argument (new CCodeIdentifier ("object"));
		set_path.add_argument (new CCodeConstant ("\"dbus_object_path\""));
		set_path.add_argument (path_dup);
		register_block.add_statement (new CCodeExpressionStatement (set_path));

		var cregister = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_register_object_path"));
		cregister.add_argument (new CCodeIdentifier ("connection"));
		cregister.add_argument (new CCodeIdentifier ("path"));
		cregister.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_path_vtable (object_type)));
		cregister.add_argument (new CCodeIdentifier ("object"));
		register_block.add_statement (new CCodeExpressionStatement (cregister));

		var weak_unregister = new CCodeFunctionCall (new CCodeIdentifier ("g_object_weak_ref"));
		weak_unregister.add_argument (new CCodeIdentifier ("object"));
		weak_unregister.add_argument (new CCodeIdentifier ("_vala_dbus_unregister_object"));
		weak_unregister.add_argument (new CCodeIdentifier ("connection"));
		register_block.add_statement (new CCodeExpressionStatement (weak_unregister));

		block.add_statement (new CCodeIfStatement (register_check, register_block));

		handle_signals (object_type.type_symbol, block);

		var cl = sym as Class;
		if (cl != null) {
			foreach (DataType base_type in cl.get_base_types ()) {
				var base_obj_type = base_type as ObjectType;
				if (type_implements_dbus_interface (base_obj_type.type_symbol)) {
					var base_register = new CCodeFunctionCall (new CCodeIdentifier (base_obj_type.type_symbol.get_lower_case_cprefix () + "dbus_register_object"));
					base_register.add_argument (new CCodeIdentifier ("connection"));
					base_register.add_argument (new CCodeIdentifier ("path"));
					base_register.add_argument (new CCodeIdentifier ("object"));
					block.add_statement (new CCodeExpressionStatement (base_register));
				}
			}
		}

		source_type_member_definition.append (cfunc);
	}

	void generate_unregister_function (ObjectType object_type) {
		var sym = object_type.type_symbol;

		var cfunc = new CCodeFunction ("_" + sym.get_lower_case_cprefix () + "dbus_unregister", "void");
		cfunc.add_parameter (new CCodeFormalParameter ("connection", "DBusConnection*"));
		cfunc.add_parameter (new CCodeFormalParameter ("_user_data_", "void*"));

		source_declarations.add_type_member_declaration (cfunc.copy ());

		var block = new CCodeBlock ();
		cfunc.block = block;

		source_type_member_definition.append (cfunc);
	}

	void handle_method (string dbus_iface_name, string dbus_method_name, string handler_name, CCodeBlock block, ref CCodeIfStatement clastif) {
		var ccheck = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_is_method_call"));
		ccheck.add_argument (new CCodeIdentifier ("message"));
		ccheck.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_iface_name)));
		ccheck.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_method_name)));

		var callblock = new CCodeBlock ();

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (handler_name));
		ccall.add_argument (new CCodeIdentifier ("object"));
		ccall.add_argument (new CCodeIdentifier ("connection"));
		ccall.add_argument (new CCodeIdentifier ("message"));

		callblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("result"), ccall)));

		var cif = new CCodeIfStatement (ccheck, callblock);
		if (clastif == null) {
			block.add_statement (cif);
		} else {
			clastif.false_statement = cif;
		}

		clastif = cif;
	}

	void handle_methods (ObjectTypeSymbol sym, string dbus_iface_name, CCodeBlock block, ref CCodeIfStatement clastif) {
		foreach (Method m in sym.get_methods ()) {
			if (m is CreationMethod || m.binding != MemberBinding.INSTANCE
			    || m.overrides || m.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (m)) {
				continue;
			}

			handle_method (dbus_iface_name, get_dbus_name_for_member (m), generate_dbus_wrapper (m, sym), block, ref clastif);
		}
	}

	string generate_dbus_property_get_wrapper (ObjectTypeSymbol sym, string dbus_iface_name) {
		string wrapper_name = "_dbus_%s_property_get".printf (sym.get_lower_case_cname ());

		CCodeDeclaration cdecl;

		var function = new CCodeFunction (wrapper_name, "DBusHandlerResult");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("self", sym.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("connection", "DBusConnection*"));
		function.add_parameter (new CCodeFormalParameter ("message", "DBusMessage*"));

		var block = new CCodeBlock ();
		var prefragment = new CCodeFragment ();

		cdecl = new CCodeDeclaration ("DBusMessage*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("reply"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator ("iter"));
		cdecl.add_declarator (new CCodeVariableDeclarator ("reply_iter"));
		cdecl.add_declarator (new CCodeVariableDeclarator ("subiter"));
		block.add_statement (cdecl);

		var message_signature = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_get_signature"));
		message_signature.add_argument (new CCodeIdentifier ("message"));
		var signature_check = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
		signature_check.add_argument (message_signature);
		signature_check.add_argument (new CCodeConstant ("\"ss\""));
		var signature_error_block = new CCodeBlock ();
		signature_error_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("DBUS_HANDLER_RESULT_NOT_YET_HANDLED")));
		block.add_statement (new CCodeIfStatement (signature_check, signature_error_block));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init"));
		iter_call.add_argument (new CCodeIdentifier ("message"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("iter")));
		block.add_statement (new CCodeExpressionStatement (iter_call));

		var msgcall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_new_method_return"));
		msgcall.add_argument (new CCodeIdentifier ("message"));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("reply"), msgcall)));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init_append"));
		iter_call.add_argument (new CCodeIdentifier ("reply"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("reply_iter")));
		block.add_statement (new CCodeExpressionStatement (iter_call));

		block.add_statement (prefragment);

		cdecl = new CCodeDeclaration ("char*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("interface_name"));
		prefragment.append (cdecl);
		var target = new CCodeIdentifier ("interface_name");
		var expr = read_expression (prefragment, string_type, new CCodeIdentifier ("iter"), target);
		prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (target, expr)));

		cdecl = new CCodeDeclaration ("char*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("property_name"));
		prefragment.append (cdecl);
		target = new CCodeIdentifier ("property_name");
		expr = read_expression (prefragment, string_type, new CCodeIdentifier ("iter"), target);
		prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (target, expr)));

		CCodeIfStatement clastif = null;

		foreach (Property prop in sym.get_properties ()) {
			if (prop.binding != MemberBinding.INSTANCE
			    || prop.overrides || prop.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (prop)) {
				continue;
			}
			if (prop.get_accessor == null) {
				continue;
			}

			var prop_block = new CCodeBlock ();
			var postfragment = new CCodeFragment ();
			prop_block.add_statement (postfragment);

			var ccmp = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
			ccmp.add_argument (new CCodeIdentifier ("interface_name"));
			ccmp.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_iface_name)));
			var ccheck1 = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ccmp, new CCodeConstant ("0"));

			ccmp = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
			ccmp.add_argument (new CCodeIdentifier ("property_name"));
			ccmp.add_argument (new CCodeConstant ("\"%s\"".printf (get_dbus_name_for_member (prop))));
			var ccheck2 = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ccmp, new CCodeConstant ("0"));

			var ccheck = new CCodeBinaryExpression (CCodeBinaryOperator.AND, ccheck1, ccheck2);

			iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_open_container"));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("reply_iter")));
			iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_VARIANT"));
			iter_call.add_argument (new CCodeConstant ("\"%s\"".printf (get_type_signature (prop.property_type))));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("subiter")));
			postfragment.append (new CCodeExpressionStatement (iter_call));

			var ccall = new CCodeFunctionCall (new CCodeIdentifier (prop.get_accessor.get_cname ()));
			ccall.add_argument (new CCodeIdentifier ("self"));

			cdecl = new CCodeDeclaration (prop.property_type.get_cname ());
			cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
			postfragment.append (cdecl);

			if (prop.property_type.is_real_non_null_struct_type ()) {
				// structs are returned via out parameter
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));

				postfragment.append (new CCodeExpressionStatement (ccall));
			} else {
				postfragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("result"), ccall)));

				var array_type = prop.property_type as ArrayType;
				if (array_type != null) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						string length_cname = get_array_length_cname ("result", dim);

						cdecl = new CCodeDeclaration ("int");
						cdecl.add_declarator (new CCodeVariableDeclarator (length_cname));
						postfragment.append (cdecl);

						ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (length_cname)));
					}
				}
			}

			write_expression (postfragment, prop.property_type, new CCodeIdentifier ("subiter"), new CCodeIdentifier ("result"));

			if (requires_destroy (prop.get_accessor.value_type)) {
				// keep local alive (symbol_reference is weak)
				// space before `result' is work around to not trigger
				// variable renaming, we really mean C identifier `result' here
				var local = new LocalVariable (prop.get_accessor.value_type, " result");
				var ma = new MemberAccess.simple ("result");
				ma.symbol_reference = local;
				postfragment.append (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier ("result"), prop.get_accessor.value_type, ma)));
			}

			iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_close_container"));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("reply_iter")));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("subiter")));
			postfragment.append (new CCodeExpressionStatement (iter_call));

			var cif = new CCodeIfStatement (ccheck, prop_block);
			if (clastif == null) {
				block.add_statement (cif);
			} else {
				clastif.false_statement = cif;
			}

			clastif = cif;
		}

		// free interface_name and property_name
		var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		free_call.add_argument (new CCodeIdentifier ("interface_name"));
		block.add_statement (new CCodeExpressionStatement (free_call));

		free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		free_call.add_argument (new CCodeIdentifier ("property_name"));
		block.add_statement (new CCodeExpressionStatement (free_call));

		if (clastif == null) {
			block = new CCodeBlock ();
			block.add_statement (new CCodeReturnStatement (new CCodeConstant ("NULL")));
		} else {
			var else_block = new CCodeBlock ();
			var unref_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
			unref_call.add_argument (new CCodeIdentifier ("reply"));
			else_block.add_statement (new CCodeExpressionStatement (unref_call));
			else_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("reply"), new CCodeConstant ("NULL"))));
			clastif.false_statement = else_block;

			handle_reply (block);
		}

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return wrapper_name;
	}

	string generate_dbus_property_get_all_wrapper (ObjectTypeSymbol sym, string dbus_iface_name) {
		string wrapper_name = "_dbus_%s_property_get_all".printf (sym.get_lower_case_cname ());

		bool has_readable_properties = false;
		foreach (Property prop in sym.get_properties ()) {
			if (prop.binding != MemberBinding.INSTANCE
			    || prop.overrides || prop.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (prop)) {
				continue;
			}
			if (prop.get_accessor != null) {
				has_readable_properties = true;
			}
		}

		CCodeDeclaration cdecl;

		var function = new CCodeFunction (wrapper_name, "DBusHandlerResult");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("self", sym.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("connection", "DBusConnection*"));
		function.add_parameter (new CCodeFormalParameter ("message", "DBusMessage*"));

		var block = new CCodeBlock ();
		var prefragment = new CCodeFragment ();

		cdecl = new CCodeDeclaration ("DBusMessage*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("reply"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator ("iter"));
		cdecl.add_declarator (new CCodeVariableDeclarator ("reply_iter"));
		cdecl.add_declarator (new CCodeVariableDeclarator ("subiter"));
		if (has_readable_properties) {
			cdecl.add_declarator (new CCodeVariableDeclarator ("entry_iter"));
			cdecl.add_declarator (new CCodeVariableDeclarator ("value_iter"));
		}
		block.add_statement (cdecl);

		var message_signature = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_get_signature"));
		message_signature.add_argument (new CCodeIdentifier ("message"));
		var signature_check = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
		signature_check.add_argument (message_signature);
		signature_check.add_argument (new CCodeConstant ("\"s\""));
		var signature_error_block = new CCodeBlock ();
		signature_error_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("DBUS_HANDLER_RESULT_NOT_YET_HANDLED")));
		block.add_statement (new CCodeIfStatement (signature_check, signature_error_block));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init"));
		iter_call.add_argument (new CCodeIdentifier ("message"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("iter")));
		block.add_statement (new CCodeExpressionStatement (iter_call));

		var msgcall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_new_method_return"));
		msgcall.add_argument (new CCodeIdentifier ("message"));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("reply"), msgcall)));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init_append"));
		iter_call.add_argument (new CCodeIdentifier ("reply"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("reply_iter")));
		block.add_statement (new CCodeExpressionStatement (iter_call));

		block.add_statement (prefragment);

		cdecl = new CCodeDeclaration ("char*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("interface_name"));
		prefragment.append (cdecl);
		var target = new CCodeIdentifier ("interface_name");
		var expr = read_expression (prefragment, string_type, new CCodeIdentifier ("iter"), target);
		prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (target, expr)));

		if (has_readable_properties) {
			cdecl = new CCodeDeclaration ("const char*");
			cdecl.add_declarator (new CCodeVariableDeclarator ("property_name"));
			prefragment.append (cdecl);
		}

		var prop_block = new CCodeBlock ();

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_open_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("reply_iter")));
		iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_ARRAY"));
		iter_call.add_argument (new CCodeConstant ("\"{sv}\""));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("subiter")));
		prop_block.add_statement (new CCodeExpressionStatement (iter_call));

		foreach (Property prop in sym.get_properties ()) {
			if (prop.binding != MemberBinding.INSTANCE
			    || prop.overrides || prop.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (prop)) {
				continue;
			}
			if (prop.get_accessor == null) {
				continue;
			}

			var inner_block = new CCodeBlock ();
			prop_block.add_statement (inner_block);
			var postfragment = new CCodeFragment ();
			inner_block.add_statement (postfragment);

			iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_open_container"));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("subiter")));
			iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_DICT_ENTRY"));
			iter_call.add_argument (new CCodeConstant ("NULL"));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("entry_iter")));
			postfragment.append (new CCodeExpressionStatement (iter_call));

			postfragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("property_name"), new CCodeConstant ("\"%s\"".printf (get_dbus_name_for_member (prop))))));

			iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_append_basic"));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("entry_iter")));
			iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_STRING"));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("property_name")));
			postfragment.append (new CCodeExpressionStatement (iter_call));

			iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_open_container"));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("entry_iter")));
			iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_VARIANT"));
			iter_call.add_argument (new CCodeConstant ("\"%s\"".printf (get_type_signature (prop.property_type))));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("value_iter")));
			postfragment.append (new CCodeExpressionStatement (iter_call));

			var ccall = new CCodeFunctionCall (new CCodeIdentifier (prop.get_accessor.get_cname ()));
			ccall.add_argument (new CCodeIdentifier ("self"));

			cdecl = new CCodeDeclaration (prop.property_type.get_cname ());
			cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
			postfragment.append (cdecl);

			if (prop.property_type.is_real_non_null_struct_type ()) {
				// structs are returned via out parameter
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));

				postfragment.append (new CCodeExpressionStatement (ccall));
			} else {
				postfragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("result"), ccall)));

				var array_type = prop.property_type as ArrayType;
				if (array_type != null) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						string length_cname = get_array_length_cname ("result", dim);

						cdecl = new CCodeDeclaration ("int");
						cdecl.add_declarator (new CCodeVariableDeclarator (length_cname));
						postfragment.append (cdecl);

						ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (length_cname)));
					}
				}
			}

			write_expression (postfragment, prop.property_type, new CCodeIdentifier ("value_iter"), new CCodeIdentifier ("result"));

			if (requires_destroy (prop.get_accessor.value_type)) {
				// keep local alive (symbol_reference is weak)
				// space before `result' is work around to not trigger
				// variable renaming, we really mean C identifier `result' here
				var local = new LocalVariable (prop.get_accessor.value_type, " result");
				var ma = new MemberAccess.simple ("result");
				ma.symbol_reference = local;
				postfragment.append (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier ("result"), prop.get_accessor.value_type, ma)));
			}

			iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_close_container"));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("entry_iter")));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("value_iter")));
			postfragment.append (new CCodeExpressionStatement (iter_call));

			iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_close_container"));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("subiter")));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("entry_iter")));
			postfragment.append (new CCodeExpressionStatement (iter_call));
		}

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_close_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("reply_iter")));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("subiter")));
		prop_block.add_statement (new CCodeExpressionStatement (iter_call));

		var ccmp = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
		ccmp.add_argument (new CCodeIdentifier ("interface_name"));
		ccmp.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_iface_name)));
		var ccheck = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ccmp, new CCodeConstant ("0"));

		var else_block = new CCodeBlock ();
		var unref_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
		unref_call.add_argument (new CCodeIdentifier ("reply"));
		else_block.add_statement (new CCodeExpressionStatement (unref_call));
		else_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("reply"), new CCodeConstant ("NULL"))));

		block.add_statement (new CCodeIfStatement (ccheck, prop_block, else_block));

		// free interface_name
		var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		free_call.add_argument (new CCodeIdentifier ("interface_name"));
		block.add_statement (new CCodeExpressionStatement (free_call));

		handle_reply (block);

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return wrapper_name;
	}

	string generate_dbus_property_set_wrapper (ObjectTypeSymbol sym, string dbus_iface_name) {
		string wrapper_name = "_dbus_%s_property_set".printf (sym.get_lower_case_cname ());

		var function = new CCodeFunction (wrapper_name, "DBusHandlerResult");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("self", sym.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("connection", "DBusConnection*"));
		function.add_parameter (new CCodeFormalParameter ("message", "DBusMessage*"));

		var block = new CCodeBlock ();
		var prefragment = new CCodeFragment ();

		var cdecl = new CCodeDeclaration ("DBusMessage*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("reply"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator ("iter"));
		cdecl.add_declarator (new CCodeVariableDeclarator ("subiter"));
		block.add_statement (cdecl);

		var message_signature = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_get_signature"));
		message_signature.add_argument (new CCodeIdentifier ("message"));
		var signature_check = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
		signature_check.add_argument (message_signature);
		signature_check.add_argument (new CCodeConstant ("\"ssv\""));
		var signature_error_block = new CCodeBlock ();
		signature_error_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("DBUS_HANDLER_RESULT_NOT_YET_HANDLED")));
		block.add_statement (new CCodeIfStatement (signature_check, signature_error_block));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init"));
		iter_call.add_argument (new CCodeIdentifier ("message"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("iter")));
		block.add_statement (new CCodeExpressionStatement (iter_call));

		var msgcall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_new_method_return"));
		msgcall.add_argument (new CCodeIdentifier ("message"));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("reply"), msgcall)));

		block.add_statement (prefragment);

		cdecl = new CCodeDeclaration ("char*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("interface_name"));
		prefragment.append (cdecl);
		var target = new CCodeIdentifier ("interface_name");
		var expr = read_expression (prefragment, string_type, new CCodeIdentifier ("iter"), target);
		prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (target, expr)));

		cdecl = new CCodeDeclaration ("char*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("property_name"));
		prefragment.append (cdecl);
		target = new CCodeIdentifier ("property_name");
		expr = read_expression (prefragment, string_type, new CCodeIdentifier ("iter"), target);
		prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (target, expr)));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_recurse"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("iter")));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("subiter")));
		prefragment.append (new CCodeExpressionStatement (iter_call));

		CCodeIfStatement clastif = null;

		foreach (Property prop in sym.get_properties ()) {
			if (prop.binding != MemberBinding.INSTANCE
			    || prop.overrides || prop.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (prop)) {
				continue;
			}
			if (prop.set_accessor == null) {
				continue;
			}

			var prop_block = new CCodeBlock ();
			prefragment = new CCodeFragment ();
			prop_block.add_statement (prefragment);

			var ccmp = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
			ccmp.add_argument (new CCodeIdentifier ("interface_name"));
			ccmp.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_iface_name)));
			var ccheck1 = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ccmp, new CCodeConstant ("0"));

			ccmp = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
			ccmp.add_argument (new CCodeIdentifier ("property_name"));
			ccmp.add_argument (new CCodeConstant ("\"%s\"".printf (get_dbus_name_for_member (prop))));
			var ccheck2 = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ccmp, new CCodeConstant ("0"));

			var ccheck = new CCodeBinaryExpression (CCodeBinaryOperator.AND, ccheck1, ccheck2);

			var owned_type = prop.property_type.copy ();
			owned_type.value_owned = true;

			cdecl = new CCodeDeclaration (owned_type.get_cname ());
			cdecl.add_declarator (new CCodeVariableDeclarator ("value"));
			prefragment.append (cdecl);

			target = new CCodeIdentifier ("value");
			expr = read_expression (prefragment, prop.property_type, new CCodeIdentifier ("subiter"), target);
			prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (target, expr)));

			var ccall = new CCodeFunctionCall (new CCodeIdentifier (prop.set_accessor.get_cname ()));
			ccall.add_argument (new CCodeIdentifier ("self"));

			if (prop.property_type.is_real_non_null_struct_type ()) {
				// structs are passed by reference
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("value")));
			} else {
				ccall.add_argument (new CCodeIdentifier ("value"));

				var array_type = prop.property_type as ArrayType;
				if (array_type != null) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						cdecl = new CCodeDeclaration ("int");
						cdecl.add_declarator (new CCodeVariableDeclarator (get_array_length_cname ("value", dim)));
						prefragment.append (cdecl);

						ccall.add_argument (new CCodeIdentifier (get_array_length_cname ("value", dim)));
					}
				}
			}

			prop_block.add_statement (new CCodeExpressionStatement (ccall));

			if (requires_destroy (owned_type)) {
				// keep local alive (symbol_reference is weak)
				var local = new LocalVariable (owned_type, "value");
				var ma = new MemberAccess.simple ("value");
				ma.symbol_reference = local;
				prop_block.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier ("value"), owned_type, ma)));
			}

			var cif = new CCodeIfStatement (ccheck, prop_block);
			if (clastif == null) {
				block.add_statement (cif);
			} else {
				clastif.false_statement = cif;
			}

			clastif = cif;
		}

		// free interface_name and property_name
		var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		free_call.add_argument (new CCodeIdentifier ("interface_name"));
		block.add_statement (new CCodeExpressionStatement (free_call));

		free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		free_call.add_argument (new CCodeIdentifier ("property_name"));
		block.add_statement (new CCodeExpressionStatement (free_call));

		if (clastif == null) {
			block = new CCodeBlock ();
			block.add_statement (new CCodeReturnStatement (new CCodeConstant ("NULL")));
		} else {
			var else_block = new CCodeBlock ();
			var unref_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
			unref_call.add_argument (new CCodeIdentifier ("reply"));
			else_block.add_statement (new CCodeExpressionStatement (unref_call));
			else_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("reply"), new CCodeIdentifier ("NULL"))));
			clastif.false_statement = else_block;

			handle_reply (block);
		}

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return wrapper_name;
	}

	string get_dbus_type_introspection (ObjectTypeSymbol sym) {
		string result = "";

		var cl = sym as Class;
		if (cl != null) {
			foreach (DataType base_type in cl.get_base_types ()) {
				var base_obj_type = base_type as ObjectType;
				result += get_dbus_type_introspection (base_obj_type.type_symbol);
			}
		}

		string dbus_iface_name = get_dbus_name (sym);
		if (dbus_iface_name == null) {
			return result;
		}

		result += "<interface name=\"%s\">\n".printf (dbus_iface_name);

		foreach (var m in sym.get_methods ()) {
			if (m is CreationMethod || m.binding != MemberBinding.INSTANCE
			    || m.overrides || m.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (m)) {
				continue;
			}

			result += "  <method name=\"%s\">\n".printf (get_dbus_name_for_member (m));

			foreach (var param in m.get_parameters ()) {
				if (param.variable_type.data_type != null
				    && param.variable_type.data_type.get_full_name () == "DBus.BusName") {
					// skip sender parameter
					// (implicit in D-Bus)
					continue;
				}

				string direction = param.direction == ParameterDirection.IN ? "in" : "out";
				result += "    <arg name=\"%s\" type=\"%s\" direction=\"%s\"/>\n".printf (param.name, get_type_signature (param.variable_type), direction);
			}
			if (!(m.return_type is VoidType)) {
				result += "    <arg name=\"%s\" type=\"%s\" direction=\"out\"/>\n".printf (dbus_result_name (m), get_type_signature (m.return_type));
			}

			result += "  </method>\n";
		}

		foreach (var prop in sym.get_properties ()) {
			if (prop.binding != MemberBinding.INSTANCE
			    || prop.overrides || prop.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (prop)) {
				continue;
			}

			string access = (prop.get_accessor != null ? "read" : "") + (prop.set_accessor != null ? "write" : "");
			result += "  <property name=\"%s\" type=\"%s\" access=\"%s\"/>\n".printf (get_dbus_name_for_member (prop), get_type_signature (prop.property_type), access);
		}

		foreach (var sig in sym.get_signals ()) {
			if (sig.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (sig)) {
				continue;
			}

			result += "  <signal name=\"%s\">\n".printf (get_dbus_name_for_member (sig));

			foreach (var param in sig.get_parameters ()) {
				result += "    <arg name=\"%s\" type=\"%s\"/>\n".printf (param.name, get_type_signature (param.variable_type));
			}

			result += "  </signal>\n";
		}

		result += "</interface>\n";

		return result;
	}

	string generate_dbus_introspect (ObjectTypeSymbol sym) {
		string wrapper_name = "_dbus_%s_introspect".printf (sym.get_lower_case_cname ());

		var function = new CCodeFunction (wrapper_name, "DBusHandlerResult");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("self", sym.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("connection", "DBusConnection*"));
		function.add_parameter (new CCodeFormalParameter ("message", "DBusMessage*"));

		var block = new CCodeBlock ();

		var cdecl = new CCodeDeclaration ("DBusMessage*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("reply"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator ("iter"));
		block.add_statement (cdecl);

		var msgcall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_new_method_return"));
		msgcall.add_argument (new CCodeIdentifier ("message"));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("reply"), msgcall)));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init_append"));
		iter_call.add_argument (new CCodeIdentifier ("reply"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("iter")));
		block.add_statement (new CCodeExpressionStatement (iter_call));

		cdecl = new CCodeDeclaration ("GString*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("xml_data"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("char**");
		cdecl.add_declarator (new CCodeVariableDeclarator ("children"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("int");
		cdecl.add_declarator (new CCodeVariableDeclarator ("i"));
		block.add_statement (cdecl);

		string xml_data = "<!DOCTYPE node PUBLIC \"-//freedesktop//DTD D-BUS Object Introspection 1.0//EN\" \"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd\">\n";
		var str_call = new CCodeFunctionCall (new CCodeIdentifier ("g_string_new"));
		str_call.add_argument (new CCodeConstant ("\"%s\"".printf (xml_data.escape (""))));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("xml_data"), str_call)));

		xml_data = "<node>\n";
		xml_data +=
"""<interface name="org.freedesktop.DBus.Introspectable">
  <method name="Introspect">
    <arg name="data" direction="out" type="s"/>
  </method>
</interface>
<interface name="org.freedesktop.DBus.Properties">
  <method name="Get">
    <arg name="interface" direction="in" type="s"/>
    <arg name="propname" direction="in" type="s"/>
    <arg name="value" direction="out" type="v"/>
  </method>
  <method name="Set">
    <arg name="interface" direction="in" type="s"/>
    <arg name="propname" direction="in" type="s"/>
    <arg name="value" direction="in" type="v"/>
  </method>
  <method name="GetAll">
    <arg name="interface" direction="in" type="s"/>
    <arg name="props" direction="out" type="a{sv}"/>
  </method>
</interface>
""";
		xml_data += get_dbus_type_introspection (sym);
		str_call = new CCodeFunctionCall (new CCodeIdentifier ("g_string_append"));
		str_call.add_argument (new CCodeIdentifier ("xml_data"));
		str_call.add_argument (new CCodeConstant ("\"%s\"".printf (xml_data.escape (""))));
		block.add_statement (new CCodeExpressionStatement (str_call));

		var get_path = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get_data"));
		get_path.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "GObject *"));
		get_path.add_argument (new CCodeConstant ("\"dbus_object_path\""));

		var list_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_list_registered"));
		list_call.add_argument (new CCodeIdentifier ("connection"));
		list_call.add_argument (get_path);
		list_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("children")));
		block.add_statement (new CCodeExpressionStatement (list_call));

		// add child nodes
		var child_block = new CCodeBlock ();
		str_call = new CCodeFunctionCall (new CCodeIdentifier ("g_string_append_printf"));
		str_call.add_argument (new CCodeIdentifier ("xml_data"));
		str_call.add_argument (new CCodeConstant ("\"%s\"".printf ("<node name=\"%s\"/>\n".escape (""))));
		str_call.add_argument (new CCodeElementAccess (new CCodeIdentifier ("children"), new CCodeIdentifier ("i")));
		child_block.add_statement (new CCodeExpressionStatement (str_call));
		var cfor = new CCodeForStatement (new CCodeElementAccess (new CCodeIdentifier ("children"), new CCodeIdentifier ("i")), child_block);
		cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeConstant ("0")));
		cfor.add_iterator (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("i")));
		block.add_statement (cfor);

		var list_free_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_free_string_array"));
		list_free_call.add_argument (new CCodeIdentifier ("children"));
		block.add_statement (new CCodeExpressionStatement (list_free_call));

		xml_data = "</node>\n";
		str_call = new CCodeFunctionCall (new CCodeIdentifier ("g_string_append"));
		str_call.add_argument (new CCodeIdentifier ("xml_data"));
		str_call.add_argument (new CCodeConstant ("\"%s\"".printf (xml_data.escape (""))));
		block.add_statement (new CCodeExpressionStatement (str_call));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_append_basic"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("iter")));
		iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_STRING"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess.pointer (new CCodeIdentifier ("xml_data"), "str")));
		block.add_statement (new CCodeExpressionStatement (iter_call));

		str_call = new CCodeFunctionCall (new CCodeIdentifier ("g_string_free"));
		str_call.add_argument (new CCodeIdentifier ("xml_data"));
		str_call.add_argument (new CCodeConstant ("TRUE"));
		block.add_statement (new CCodeExpressionStatement (str_call));

		handle_reply (block);

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return wrapper_name;
	}

	void handle_signals (ObjectTypeSymbol sym, CCodeBlock block) {
		string dbus_iface_name = get_dbus_name (sym);
		if (dbus_iface_name == null) {
			return;
		}

		foreach (Signal sig in sym.get_signals ()) {
			if (sig.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (sig)) {
				continue;
			}

			var connect = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_connect"));
			connect.add_argument (new CCodeIdentifier ("object"));
			connect.add_argument (sig.get_canonical_cconstant ());
			connect.add_argument (new CCodeCastExpression (new CCodeIdentifier (generate_dbus_signal_wrapper (sig, sym, dbus_iface_name)), "GCallback"));
			connect.add_argument (new CCodeIdentifier ("connection"));
			block.add_statement (new CCodeExpressionStatement (connect));
		}
	}

	void generate_message_function (ObjectType object_type) {
		var sym = object_type.type_symbol;

		add_dbus_helpers ();

		var cfunc = new CCodeFunction (sym.get_lower_case_cprefix () + "dbus_message", "DBusHandlerResult");
		cfunc.add_parameter (new CCodeFormalParameter ("connection", "DBusConnection*"));
		cfunc.add_parameter (new CCodeFormalParameter ("message", "DBusMessage*"));
		cfunc.add_parameter (new CCodeFormalParameter ("object", "void*"));

		if (sym.is_private_symbol ()) {
			cfunc.modifiers |= CCodeModifiers.STATIC;
		}

		source_declarations.add_type_member_declaration (cfunc.copy ());

		var block = new CCodeBlock ();
		cfunc.block = block;

		var cdecl = new CCodeDeclaration ("DBusHandlerResult");
		cdecl.add_declarator (new CCodeVariableDeclarator ("result", new CCodeConstant ("DBUS_HANDLER_RESULT_NOT_YET_HANDLED")));
		block.add_statement (cdecl);

		CCodeIfStatement clastif = null;

		handle_method ("org.freedesktop.DBus.Introspectable", "Introspect", generate_dbus_introspect (sym), block, ref clastif);

		string dbus_iface_name = get_dbus_name (sym);
		if (dbus_iface_name != null) {
			bool need_property_get = false;
			bool need_property_set = false;
			foreach (Property prop in sym.get_properties ()) {
				if (prop.binding != MemberBinding.INSTANCE
				    || prop.overrides || prop.access != SymbolAccessibility.PUBLIC) {
					continue;
				}
				if (!is_dbus_visible (prop)) {
					continue;
				}
				if (prop.get_accessor != null) {
					need_property_get = true;
				}
				if (prop.set_accessor != null) {
					need_property_set = true;
				}
			}

			if (need_property_get) {
				handle_method ("org.freedesktop.DBus.Properties", "Get", generate_dbus_property_get_wrapper (sym, dbus_iface_name), block, ref clastif);
			}
			if (need_property_set) {
				handle_method ("org.freedesktop.DBus.Properties", "Set", generate_dbus_property_set_wrapper (sym, dbus_iface_name), block, ref clastif);
			}
			handle_method ("org.freedesktop.DBus.Properties", "GetAll", generate_dbus_property_get_all_wrapper (sym, dbus_iface_name), block, ref clastif);

			handle_methods (sym, dbus_iface_name, block, ref clastif);
		}

		var resultblock = new CCodeBlock ();
		resultblock.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));
		var cif = new CCodeIfStatement (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("result"), new CCodeIdentifier ("DBUS_HANDLER_RESULT_HANDLED")), resultblock);
		block.add_statement (cif);
		clastif = cif;

		var cl = sym as Class;
		if (cl != null) {
			foreach (DataType base_type in cl.get_base_types ()) {
				var base_obj_type = base_type as ObjectType;
				if (type_implements_dbus_interface (base_obj_type.type_symbol)) {
					var base_call = new CCodeFunctionCall (new CCodeIdentifier (base_obj_type.type_symbol.get_lower_case_cprefix () + "dbus_message"));
					base_call.add_argument (new CCodeIdentifier ("connection"));
					base_call.add_argument (new CCodeIdentifier ("message"));
					base_call.add_argument (new CCodeIdentifier ("object"));

					var ccheck = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, base_call, new CCodeIdentifier ("DBUS_HANDLER_RESULT_HANDLED"));

					var base_block = new CCodeBlock ();
					base_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("DBUS_HANDLER_RESULT_HANDLED")));

					cif = new CCodeIfStatement (ccheck, base_block);
					clastif.false_statement = cif;

					clastif = cif;
				}
			}
		}

		var retblock = new CCodeBlock ();
		retblock.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("DBUS_HANDLER_RESULT_NOT_YET_HANDLED")));
		clastif.false_statement = retblock;

		source_type_member_definition.append (cfunc);
	}

	CCodeExpression get_vtable (ObjectType object_type) {
		var sym = object_type.type_symbol;

		var vtable = new CCodeInitializerList ();
		vtable.append (new CCodeIdentifier (sym.get_lower_case_cprefix () + "dbus_register_object"));

		generate_register_function (object_type);

		var cdecl = new CCodeDeclaration ("const _DBusObjectVTable");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_" + sym.get_lower_case_cprefix () + "dbus_vtable", vtable));
		cdecl.modifiers = CCodeModifiers.STATIC;
		source_declarations.add_constant_declaration (cdecl);

		return new CCodeIdentifier ("_" + sym.get_lower_case_cprefix () + "dbus_vtable");
	}

	CCodeExpression get_path_vtable (ObjectType object_type) {
		var sym = object_type.type_symbol;

		var vtable = new CCodeInitializerList ();
		vtable.append (new CCodeIdentifier ("_" + sym.get_lower_case_cprefix () + "dbus_unregister"));
		vtable.append (new CCodeIdentifier (sym.get_lower_case_cprefix () + "dbus_message"));

		generate_unregister_function (object_type);
		generate_message_function (object_type);

		var cdecl = new CCodeDeclaration ("const DBusObjectPathVTable");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_" + sym.get_lower_case_cprefix () + "dbus_path_vtable", vtable));
		cdecl.modifiers = CCodeModifiers.STATIC;
		source_declarations.add_constant_declaration (cdecl);

		return new CCodeIdentifier ("_" + sym.get_lower_case_cprefix () + "dbus_path_vtable");
	}

	public override void visit_method_call (MethodCall expr) {
		var mtype = expr.call.value_type as MethodType;
		if (mtype == null || (mtype.method_symbol.get_cname () != "dbus_connection_register_g_object" &&
		                      mtype.method_symbol.get_cname () != "dbus_g_connection_register_g_object")) {
			base.visit_method_call (expr);
			return;
		}

		add_dbus_helpers ();

		var ma = (MemberAccess) expr.call;

		var raw_conn = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_connection_get_connection"));
		raw_conn.add_argument ((CCodeExpression) ma.inner.ccodenode);

		var args_it = expr.get_argument_list ().iterator ();
		args_it.next ();
		var path_arg = args_it.get ();
		args_it.next ();
		var obj_arg = args_it.get ();

		var cregister = new CCodeFunctionCall (new CCodeIdentifier ("_vala_dbus_register_object"));
		if (mtype.method_symbol.get_cname () == "dbus_g_connection_register_g_object") {
			cregister.add_argument (raw_conn);
		} else {
			cregister.add_argument ((CCodeExpression) ma.inner.ccodenode);
		}
		cregister.add_argument ((CCodeExpression) path_arg.ccodenode);
		cregister.add_argument ((CCodeExpression) obj_arg.ccodenode);
		expr.ccodenode = cregister;
	}

	bool type_implements_dbus_interface (ObjectTypeSymbol sym) {
		var dbus = sym.get_attribute ("DBus");
		if (dbus != null) {
			return true;
		}

		var cl = sym as Class;
		if (cl != null) {
			foreach (DataType base_type in cl.get_base_types ()) {
				var base_obj_type = base_type as ObjectType;
				if (type_implements_dbus_interface (base_obj_type.type_symbol)) {
					return true;
				}
			}
		}

		return false;
	}

	public override CCodeFragment register_dbus_info (ObjectTypeSymbol sym) {
		CCodeFragment fragment = new CCodeFragment ();

		if (!type_implements_dbus_interface (sym)) {
			return fragment;
		}

		var quark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
		quark.add_argument (new CCodeConstant ("\"DBusObjectVTable\""));

		var set_qdata = new CCodeFunctionCall (new CCodeIdentifier ("g_type_set_qdata"));
		set_qdata.add_argument (new CCodeIdentifier (sym.get_upper_case_cname ("TYPE_")));
		set_qdata.add_argument (quark);
		set_qdata.add_argument (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_vtable (new ObjectType (sym))), "void*"));

		fragment.append (new CCodeExpressionStatement (set_qdata));

		return fragment;
	}
}
