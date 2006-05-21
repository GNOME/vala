/* valacodegenerator.vala
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

namespace Vala {
	public class CodeGenerator : CodeVisitor {
		CCodeFragment header_begin;
		CCodeFragment header_type_declaration;
		CCodeFragment header_type_definition;
		CCodeFragment header_type_member_declaration;
		CCodeFragment source_begin;
		CCodeFragment source_include_directives;
		CCodeFragment source_type_member_declaration;
		CCodeFragment source_type_member_definition;
		
		CCodeStruct instance_struct;
		CCodeStruct class_struct;
		CCodeEnum cenum;
		CCodeFunction function;
		CCodeBlock block;
		
		TypeReference reference; // dummy for dependency resolution
		Symbol dummy_symbol; // dummy for dependency resolution
		SourceFileCycle dummy_cycle; // dummy for dependency resolution

		public void emit (CodeContext context) {
			context.find_header_cycles ();
		
			/* we're only interested in non-pkg source files */
			foreach (SourceFile file in context.get_source_files ()) {
				if (!file.pkg) {
					file.accept (this);
				}
			}
		}
	
		public override void visit_begin_source_file (SourceFile source_file) {
			header_begin = new CCodeFragment ();
			header_type_declaration = new CCodeFragment ();
			header_type_definition = new CCodeFragment ();
			header_type_member_declaration = new CCodeFragment ();
			source_begin = new CCodeFragment ();
			source_include_directives = new CCodeFragment ();
			source_type_member_declaration = new CCodeFragment ();
			source_type_member_definition = new CCodeFragment ();
			
			source_include_directives.append (new CCodeIncludeDirective (filename = source_file.get_cheader_filename ()));
			
			List<string> used_includes = null;
			used_includes.append (source_file.get_cheader_filename ());
			
			foreach (string filename1 in source_file.header_external_includes) {
				if (used_includes.find_custom (filename1, strcmp) == null) {
					header_begin.append (new CCodeIncludeDirective (filename = filename1));
					used_includes.append (filename1);
				}
			}
			foreach (string filename2 in source_file.header_internal_includes) {
				if (used_includes.find_custom (filename2, strcmp) == null) {
					header_begin.append (new CCodeIncludeDirective (filename = filename2));
					used_includes.append (filename2);
				}
			}
			foreach (string filename3 in source_file.source_includes) {
				if (used_includes.find_custom (filename3, strcmp) == null) {
					source_include_directives.append (new CCodeIncludeDirective (filename = filename3));
					used_includes.append (filename3);
				}
			}
			if (source_file.is_cycle_head) {
				foreach (SourceFile cycle_file in source_file.cycle.files) {
					foreach (Namespace ns in cycle_file.get_namespaces ()) {
						foreach (Struct st in ns.get_structs ()) {
							header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct _%s".printf (st.get_cname ()), typedef_name = st.get_cname ()));
						}
						foreach (Class cl in ns.get_classes ()) {
							header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct _%s".printf (cl.get_cname ()), typedef_name = cl.get_cname ()));
							header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct _%sClass".printf (cl.get_cname ()), typedef_name = "%sClass".printf (cl.get_cname ())));
						}
					}
				}
			}
		}
		
		private static ref string get_define_for_filename (string filename) {
			var define = String.new ("__");
			
			var i = filename;
			while (i.len (-1) > 0) {
				var c = i.get_char ();
				if (c.isalnum  () && c < 128) {
					define.append_unichar (c.toupper ());
				} else {
					define.append_c ('_');
				}
			
				i = i.next_char ();
			}
			
			define.append ("__");
			
			return define.str;
		}
		
		public override void visit_end_source_file (SourceFile source_file) {
			var header_define = get_define_for_filename (source_file.get_cheader_filename ());
			
			CCodeComment comment = null;
			if (source_file.comment != null) {
				comment = new CCodeComment (text = source_file.comment);
			}

			var writer = new CCodeWriter (stream = File.open (source_file.get_cheader_filename (), "w"));
			if (comment != null) {
				comment.write (writer);
			}
			writer.write_newline ();
			var once = new CCodeOnceSection (define = header_define);
			once.append (new CCodeNewline ());
			once.append (header_begin);
			once.append (new CCodeNewline ());
			once.append (new CCodeIdentifier (name = "G_BEGIN_DECLS"));
			once.append (new CCodeNewline ());
			once.append (new CCodeNewline ());
			once.append (header_type_declaration);
			once.append (new CCodeNewline ());
			once.append (header_type_definition);
			once.append (new CCodeNewline ());
			once.append (header_type_member_declaration);
			once.append (new CCodeNewline ());
			once.append (new CCodeIdentifier (name = "G_END_DECLS"));
			once.append (new CCodeNewline ());
			once.append (new CCodeNewline ());
			once.write (writer);
			writer.close ();
			
			writer = new CCodeWriter (stream = File.open (source_file.get_csource_filename (), "w"));
			if (comment != null) {
				comment.write (writer);
			}
			source_begin.write (writer);
			writer.write_newline ();
			source_include_directives.write (writer);
			writer.write_newline ();
			source_type_member_declaration.write (writer);
			writer.write_newline ();
			source_type_member_definition.write (writer);
			writer.write_newline ();
			writer.close ();

			header_begin = null;
			header_type_declaration = null;
			header_type_definition = null;
			header_type_member_declaration = null;
			source_begin = null;
			source_include_directives = null;
			source_type_member_declaration = null;
			source_type_member_definition = null;
		}
		
		public override void visit_begin_class (Class cl) {
			instance_struct = new CCodeStruct (name = "_%s".printf (cl.get_cname ()));
			class_struct = new CCodeStruct (name = "_%sClass".printf (cl.get_cname ()));
			
			
			header_type_declaration.append (new CCodeNewline ());
			var macro = "(%s_get_type ())".printf (cl.get_lower_case_cname (null));
			header_type_declaration.append (new CCodeMacroReplacement (name = cl.get_upper_case_cname ("TYPE_"), replacement = macro));

			macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (cl.get_upper_case_cname ("TYPE_"), cl.get_cname ());
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s(obj)".printf (cl.get_upper_case_cname (null)), replacement = macro));

			macro = "(G_TYPE_CHECK_CLASS_CAST ((klass), %s, %sClass))".printf (cl.get_upper_case_cname ("TYPE_"), cl.get_cname ());
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s_CLASS(klass)".printf (cl.get_upper_case_cname (null)), replacement = macro));

			macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (cl.get_upper_case_cname ("TYPE_"));
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s(obj)".printf (cl.get_upper_case_cname ("IS_")), replacement = macro));

			macro = "(G_TYPE_CHECK_CLASS_TYPE ((klass), %s))".printf (cl.get_upper_case_cname ("TYPE_"));
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s_CLASS(klass)".printf (cl.get_upper_case_cname ("IS_")), replacement = macro));

			macro = "(G_TYPE_INSTANCE_GET_CLASS ((obj), %s, %sClass))".printf (cl.get_upper_case_cname ("TYPE_"), cl.get_cname ());
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s_GET_CLASS(obj)".printf (cl.get_upper_case_cname (null)), replacement = macro));
			header_type_declaration.append (new CCodeNewline ());


			if (cl.source_reference.file.cycle == null) {
				header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct %s".printf (instance_struct.name), typedef_name = cl.get_cname ()));
				header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct %s".printf (class_struct.name), typedef_name = "%sClass".printf (cl.get_cname ())));
			}
			
			instance_struct.add_field (cl.base_class.get_cname (), "parent");
			class_struct.add_field ("%sClass".printf (cl.base_class.get_cname ()), "parent");

			if (cl.source_reference.comment != null) {
				header_type_definition.append (new CCodeComment (text = cl.source_reference.comment));
			}
			header_type_definition.append (instance_struct);
			header_type_definition.append (class_struct);
		}
		
		public override void visit_begin_struct (Struct st) {
			instance_struct = new CCodeStruct (name = "_%s".printf (st.name));

			if (st.source_reference.comment != null) {
				header_type_definition.append (new CCodeComment (text = st.source_reference.comment));
			}
			header_type_definition.append (instance_struct);
		}
		
		public override void visit_begin_enum (Enum en) {
			cenum = new CCodeEnum (name = en.get_cname ());

			if (en.source_reference.comment != null) {
				header_type_definition.append (new CCodeComment (text = en.source_reference.comment));
			}
			header_type_definition.append (cenum);
		}

		public override void visit_enum_value (EnumValue ev) {
			cenum.add_value (ev.get_cname (), null);
		}
		
		public override void visit_field (Field f) {
			if (f.access == MemberAccessibility.PUBLIC) {
				instance_struct.add_field (f.type_reference.get_cname (), f.name);
			}
		}
		
		public override void visit_end_method (Method m) {
			function = new CCodeFunction (name = m.get_cname (), return_type = m.return_type.get_cname ());
			
			if (m.instance) {
				var st = (Struct) m.symbol.parent_symbol.node;
				var this_type = new TypeReference ();
				this_type.type = st;
				var cparam = new CCodeFormalParameter (type_name = this_type.get_cname (), name = "self");
				function.add_parameter (cparam);
			}
			
			foreach (FormalParameter param in m.get_parameters ()) {
				function.add_parameter ((CCodeFormalParameter) param.ccodenode);
			}
			
			if (m.access == MemberAccessibility.PUBLIC) {
				header_type_member_declaration.append (function.copy ());
			} else {
				function.modifiers |= CCodeModifiers.STATIC;
				source_type_member_declaration.append (function.copy ());
			}

			if (m.body != null) {
				function.block = m.body.ccodenode;
			}

			if (m.source_reference.comment != null) {
				source_type_member_definition.append (new CCodeComment (text = m.source_reference.comment));
			}
			source_type_member_definition.append (function);
		}
		
		public override void visit_formal_parameter (FormalParameter p) {
			p.ccodenode = new CCodeFormalParameter (type_name = p.type_reference.get_cname (), name = p.name);
		}

		public override void visit_end_block (Block b) {
			var cblock = new CCodeBlock ();
			
			foreach (Statement stmt in b.statement_list) {
				var src = stmt.source_reference;
				if (src != null && src.comment != null) {
					cblock.add_statement (new CCodeComment (text = src.comment));
				}
				
				if (stmt.ccodenode is CCodeFragment) {
					foreach (CCodeStatement cstmt in ((CCodeFragment) stmt.ccodenode).children) {
						cblock.add_statement (cstmt);
					}
				} else {
					cblock.add_statement ((CCodeStatement) stmt.ccodenode);
				}
			}
			
			b.ccodenode = cblock;
		}

		public override void visit_empty_statement (EmptyStatement stmt) {
			stmt.ccodenode = new CCodeEmptyStatement ();
		}

		public override void visit_declaration_statement (DeclarationStatement stmt) {
			/* split declaration statement as var declarators might have different types */
		
			var cfrag = new CCodeFragment ();
			
			foreach (VariableDeclarator decl in stmt.declaration.variable_declarators) {
				var cdecl = new CCodeDeclarationStatement (type_name = decl.type_reference.get_cname ());
			
				cdecl.add_declarator ((CCodeVariableDeclarator) decl.ccodenode);

				cfrag.append (cdecl);
			}
			
			stmt.ccodenode = cfrag;
		}

		public override void visit_variable_declarator (VariableDeclarator decl) {
			if (decl.initializer != null) {
				decl.ccodenode = new CCodeVariableDeclarator (name = decl.name, initializer = decl.initializer.ccodenode);
			} else {
				decl.ccodenode = new CCodeVariableDeclarator (name = decl.name);
			}
		}

		public override void visit_expression_statement (ExpressionStatement stmt) {
			stmt.ccodenode = new CCodeExpressionStatement (expression = (CCodeExpression) stmt.expression.ccodenode);
		}

		public override void visit_if_statement (IfStatement stmt) {
			if (stmt.false_statement != null) {
				stmt.ccodenode = new CCodeIfStatement (condition = (CCodeExpression) stmt.condition.ccodenode, true_statement = (CCodeStatement) stmt.true_statement.ccodenode, false_statement = (CCodeStatement) stmt.false_statement.ccodenode);
			} else {
				stmt.ccodenode = new CCodeIfStatement (condition = (CCodeExpression) stmt.condition.ccodenode, true_statement = (CCodeStatement) stmt.true_statement.ccodenode);
			}
		}

		public override void visit_for_statement (ForStatement stmt) {
			var cfor = new CCodeForStatement (condition = (CCodeExpression) stmt.condition.ccodenode, body = (CCodeStatement) stmt.body.ccodenode);
			
			foreach (Expression init_expr in stmt.initializer) {
				cfor.add_initializer ((CCodeExpression) init_expr.ccodenode);
			}
			
			foreach (Expression it_expr in stmt.iterator) {
				cfor.add_iterator ((CCodeExpression) it_expr.ccodenode);
			}
			
			stmt.ccodenode = cfor;
		}

		public override void visit_return_statement (ReturnStatement stmt) {
			if (stmt.return_expression == null) {
				stmt.ccodenode = new CCodeReturnStatement ();
			} else {
				stmt.ccodenode = new CCodeReturnStatement (return_expression = (CCodeExpression) stmt.return_expression.ccodenode);
			}
		}

		public override void visit_boolean_literal (BooleanLiteral expr) {
			if (expr.value) {
				expr.ccodenode = new CCodeConstant (name = "TRUE");
			} else {
				expr.ccodenode = new CCodeConstant (name = "FALSE");
			}
		}

		public override void visit_character_literal (CharacterLiteral expr) {
			expr.ccodenode = new CCodeConstant (name = expr.value);
		}

		public override void visit_integer_literal (IntegerLiteral expr) {
			expr.ccodenode = new CCodeConstant (name = expr.value);
		}

		public override void visit_string_literal (StringLiteral expr) {
			expr.ccodenode = new CCodeConstant (name = expr.value);
		}

		public override void visit_null_literal (NullLiteral expr) {
			expr.ccodenode = new CCodeConstant (name = "NULL");
		}

		public override void visit_literal_expression (LiteralExpression expr) {
			expr.ccodenode = expr.literal.ccodenode;
		}
		
		public override void visit_simple_name (SimpleName expr) {
			if (expr.symbol_reference.node is Method) {
				var m = (Method) expr.symbol_reference.node;
				expr.ccodenode = new CCodeIdentifier (name = m.get_cname ());
			} else if (expr.symbol_reference.node is Field) {
				var f = (Field) expr.symbol_reference.node;
				expr.ccodenode = new CCodeMemberAccess (inner = new CCodeIdentifier (name = "self"), member_name = f.name, is_pointer = true);
			} else {
				expr.ccodenode = new CCodeIdentifier (name = expr.name);
			}
		}

		public override void visit_parenthesized_expression (ParenthesizedExpression expr) {
			expr.ccodenode = new CCodeParenthesizedExpression (inner = (CCodeExpression) expr.inner.ccodenode);
		}

		public override void visit_member_access (MemberAccess expr) {
			if (expr.symbol_reference.node is Method) {
				var m = (Method) expr.symbol_reference.node;
				expr.ccodenode = new CCodeIdentifier (name = m.get_cname ());
			} else {
				expr.ccodenode = new CCodeIdentifier (name = expr.member_name);
			}
		}

		public override void visit_invocation_expression (InvocationExpression expr) {
			var ccall = new CCodeFunctionCall (call = (CCodeExpression) expr.call.ccodenode);
			
			var m = (Method) expr.call.symbol_reference.node;
			if (m.instance) {
				CCodeExpression instance;
				if (expr.call is SimpleName) {
					instance = new CCodeIdentifier (name = "self");
				} else if (expr.call is MemberAccess) {
					instance = ((MemberAccess) expr.call).inner.ccodenode;
				} else {
					stderr.printf ("internal error: unsupported method invocation\n");
				}
				ccall.add_argument (instance);
			}
			
			foreach (Expression arg in expr.argument_list) {
				ccall.add_argument ((CCodeExpression) arg.ccodenode);
			}
			
			expr.ccodenode = ccall;
		}

		public override void visit_object_creation_expression (ObjectCreationExpression expr) {
			var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_object_new"));
			
			ccall.add_argument (new CCodeConstant (name = expr.type_reference.get_upper_case_cname ("TYPE_")));

			foreach (NamedArgument arg in expr.named_argument_list) {
				ccall.add_argument (new CCodeConstant (name = "\"%s\"".printf (arg.name)));
				ccall.add_argument ((CCodeExpression) arg.argument.ccodenode);
			}
			ccall.add_argument (new CCodeConstant (name = "NULL"));
			
			expr.ccodenode = ccall;
		}

		public override void visit_unary_expression (UnaryExpression expr) {
			CCodeUnaryOperator op;
			if (expr.operator == UnaryOperator.PLUS) {
				op = CCodeUnaryOperator.PLUS;
			} else if (expr.operator == UnaryOperator.MINUS) {
				op = CCodeUnaryOperator.MINUS;
			} else if (expr.operator == UnaryOperator.LOGICAL_NEGATION) {
				op = CCodeUnaryOperator.LOGICAL_NEGATION;
			} else if (expr.operator == UnaryOperator.BITWISE_COMPLEMENT) {
				op = CCodeUnaryOperator.BITWISE_COMPLEMENT;
			} else if (expr.operator == UnaryOperator.REF) {
				op = CCodeUnaryOperator.ADDRESS_OF;
			} else if (expr.operator == UnaryOperator.OUT) {
				op = CCodeUnaryOperator.ADDRESS_OF;
			}
			expr.ccodenode = new CCodeUnaryExpression (operator = op, inner = expr.inner.ccodenode);
		}

		public override void visit_cast_expression (CastExpression expr) {
			expr.ccodenode = expr.inner.ccodenode;
		}

		public override void visit_binary_expression (BinaryExpression expr) {
			expr.ccodenode = new CCodeBinaryExpression (operator = expr.operator, left = expr.left.ccodenode, right = expr.right.ccodenode);
		}

		public override void visit_assignment (Assignment a) {
			a.ccodenode = new CCodeAssignment (left = (CCodeExpression) a.left.ccodenode, right = (CCodeExpression) a.right.ccodenode);
		}
	}
}
