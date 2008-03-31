/* valaccodegenerator.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;
using Gee;

/**
 * Code visitor generating C Code.
 */
public class Vala.CCodeGenerator : CodeGenerator {
	private CodeContext context;
	
	Symbol root_symbol;
	Symbol current_symbol;
	public Typesymbol current_type_symbol;
	public Class current_class;
	Method current_method;
	DataType current_return_type;
	TryStatement current_try;
	PropertyAccessor current_property_accessor;

	CCodeFragment header_begin;
	CCodeFragment header_type_declaration;
	CCodeFragment header_type_definition;
	CCodeFragment header_type_member_declaration;
	CCodeFragment header_constant_declaration;
	CCodeFragment source_begin;
	CCodeFragment source_include_directives;
	public CCodeFragment source_type_member_declaration;
	CCodeFragment source_constant_declaration;
	CCodeFragment source_signal_marshaller_declaration;
	public CCodeFragment source_type_member_definition;
	CCodeFragment class_init_fragment;
	CCodeFragment instance_init_fragment;
	CCodeFragment instance_dispose_fragment;
	CCodeFragment source_signal_marshaller_definition;
	CCodeFragment module_init_fragment;
	
	CCodeStruct instance_struct;
	CCodeStruct type_struct;
	CCodeStruct instance_priv_struct;
	CCodeEnum prop_enum;
	CCodeEnum cenum;
	CCodeFunction function;
	CCodeBlock block;
	
	/* all temporary variables */
	public ArrayList<VariableDeclarator> temp_vars = new ArrayList<VariableDeclarator> ();
	/* temporary variables that own their content */
	ArrayList<VariableDeclarator> temp_ref_vars = new ArrayList<VariableDeclarator> ();
	/* cache to check whether a certain marshaller has been created yet */
	Gee.Set<string> user_marshal_set;
	/* (constant) hash table with all predefined marshallers */
	Gee.Set<string> predefined_marshal_set;
	/* (constant) hash table with all C keywords */
	Gee.Set<string> c_keywords;
	
	private int next_temp_var_id = 0;
	private int current_try_id = 0;
	private int next_try_id = 0;
	public bool in_creation_method = false;
	private bool in_constructor = false;
	private bool current_method_inner_error = false;

	public DataType bool_type;
	public DataType char_type;
	public DataType unichar_type;
	public DataType short_type;
	public DataType ushort_type;
	public DataType int_type;
	public DataType uint_type;
	public DataType long_type;
	public DataType ulong_type;
	public DataType int64_type;
	public DataType uint64_type;
	public DataType string_type;
	public DataType float_type;
	public DataType double_type;
	public Typesymbol gtype_type;
	public Typesymbol gtypeinstance_type;
	public Typesymbol gobject_type;
	public ErrorType gerror_type;
	public Typesymbol glist_type;
	public Typesymbol gslist_type;
	public Typesymbol gstring_type;
	public Typesymbol gstringbuilder_type;
	public Typesymbol garray_type;
	public DataType gquark_type;
	public DataType mutex_type;
	public Typesymbol type_module_type;
	public Typesymbol iterable_type;
	public Typesymbol iterator_type;
	public Typesymbol list_type;
	public Typesymbol map_type;
	public Typesymbol connection_type;

	Method substring_method;

	private bool in_plugin = false;
	private string module_init_param_name;
	
	private bool string_h_needed;
	private bool requires_free_checked;
	private bool requires_array_free;
	private bool requires_array_move;
	private bool requires_strcmp0;

	private Set<string> wrappers;

	public CCodeGenerator () {
	}
	
	construct {
		predefined_marshal_set = new HashSet<string> (str_hash, str_equal);
		predefined_marshal_set.add ("VOID:VOID");
		predefined_marshal_set.add ("VOID:BOOLEAN");
		predefined_marshal_set.add ("VOID:CHAR");
		predefined_marshal_set.add ("VOID:UCHAR");
		predefined_marshal_set.add ("VOID:INT");
		predefined_marshal_set.add ("VOID:UINT");
		predefined_marshal_set.add ("VOID:LONG");
		predefined_marshal_set.add ("VOID:ULONG");
		predefined_marshal_set.add ("VOID:ENUM");
		predefined_marshal_set.add ("VOID:FLAGS");
		predefined_marshal_set.add ("VOID:FLOAT");
		predefined_marshal_set.add ("VOID:DOUBLE");
		predefined_marshal_set.add ("VOID:STRING");
		predefined_marshal_set.add ("VOID:POINTER");
		predefined_marshal_set.add ("VOID:OBJECT");
		predefined_marshal_set.add ("STRING:OBJECT,POINTER");
		predefined_marshal_set.add ("VOID:UINT,POINTER");
		predefined_marshal_set.add ("BOOLEAN:FLAGS");

		c_keywords = new HashSet<string> (str_hash, str_equal);

		// C99 keywords
		c_keywords.add ("_Bool");
		c_keywords.add ("_Complex");
		c_keywords.add ("_Imaginary");
		c_keywords.add ("auto");
		c_keywords.add ("break");
		c_keywords.add ("case");
		c_keywords.add ("char");
		c_keywords.add ("const");
		c_keywords.add ("continue");
		c_keywords.add ("default");
		c_keywords.add ("do");
		c_keywords.add ("double");
		c_keywords.add ("else");
		c_keywords.add ("enum");
		c_keywords.add ("extern");
		c_keywords.add ("float");
		c_keywords.add ("for");
		c_keywords.add ("goto");
		c_keywords.add ("if");
		c_keywords.add ("inline");
		c_keywords.add ("int");
		c_keywords.add ("long");
		c_keywords.add ("register");
		c_keywords.add ("restrict");
		c_keywords.add ("return");
		c_keywords.add ("short");
		c_keywords.add ("signed");
		c_keywords.add ("sizeof");
		c_keywords.add ("static");
		c_keywords.add ("struct");
		c_keywords.add ("switch");
		c_keywords.add ("typedef");
		c_keywords.add ("union");
		c_keywords.add ("unsigned");
		c_keywords.add ("void");
		c_keywords.add ("volatile");
		c_keywords.add ("while");

		// MSVC keywords
		c_keywords.add ("cdecl");
	}

	public override void emit (CodeContext! context) {
		this.context = context;
	
		context.find_header_cycles ();

		root_symbol = context.root;

		bool_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("bool"));
		char_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("char"));
		unichar_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("unichar"));
		short_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("short"));
		ushort_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("ushort"));
		int_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("int"));
		uint_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("uint"));
		long_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("long"));
		ulong_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("ulong"));
		int64_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("int64"));
		uint64_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("uint64"));
		float_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("float"));
		double_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("double"));
		string_type = new ClassType ((Class) root_symbol.scope.lookup ("string"));
		substring_method = (Method) string_type.data_type.scope.lookup ("substring");

		var glib_ns = root_symbol.scope.lookup ("GLib");

		gtype_type = (Typesymbol) glib_ns.scope.lookup ("Type");
		gtypeinstance_type = (Typesymbol) glib_ns.scope.lookup ("TypeInstance");
		gobject_type = (Typesymbol) glib_ns.scope.lookup ("Object");
		gerror_type = new ErrorType (null);
		glist_type = (Typesymbol) glib_ns.scope.lookup ("List");
		gslist_type = (Typesymbol) glib_ns.scope.lookup ("SList");
		gstring_type = (Typesymbol) glib_ns.scope.lookup ("StringBuilder");
		gstringbuilder_type = (Typesymbol) glib_ns.scope.lookup ("String");
		garray_type = (Typesymbol) glib_ns.scope.lookup ("Array");

		gquark_type = new ValueType ((Typesymbol) glib_ns.scope.lookup ("Quark"));
		mutex_type = new ClassType ((Class) glib_ns.scope.lookup ("Mutex"));
		
		type_module_type = (Typesymbol) glib_ns.scope.lookup ("TypeModule");

		if (context.module_init_method != null) {
			module_init_fragment = new CCodeFragment ();
			foreach (FormalParameter parameter in context.module_init_method.get_parameters ()) {
				if (parameter.type_reference.data_type == type_module_type) {
					in_plugin = true;
					module_init_param_name = parameter.name;
					break;
				}
			}
		}

		var gee_ns = root_symbol.scope.lookup ("Gee");
		if (gee_ns != null) {
			iterable_type = (Typesymbol) gee_ns.scope.lookup ("Iterable");
			iterator_type = (Typesymbol) gee_ns.scope.lookup ("Iterator");
			list_type = (Typesymbol) gee_ns.scope.lookup ("List");
			map_type = (Typesymbol) gee_ns.scope.lookup ("Map");
		}

		var dbus_ns = root_symbol.scope.lookup ("DBus");
		if (dbus_ns != null) {
			connection_type = (Typesymbol) dbus_ns.scope.lookup ("Connection");
		}
	
		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (!file.pkg) {
				file.accept (this);
			}
		}
	}

	public override void visit_enum (Enum! en) {
		cenum = new CCodeEnum (en.get_cname ());

		if (en.source_reference.comment != null) {
			header_type_definition.append (new CCodeComment (en.source_reference.comment));
		}

		CCodeFragment decl_frag;
		CCodeFragment def_frag;
		if (en.access != SymbolAccessibility.PRIVATE) {
			decl_frag = header_type_declaration;
			def_frag = header_type_definition;
		} else {
			decl_frag = source_type_member_declaration;
			def_frag = source_type_member_declaration;
		}

		def_frag.append (cenum);
		def_frag.append (new CCodeNewline ());

		en.accept_children (this);

		if (!en.has_type_id) {
			return;
		}

		decl_frag.append (new CCodeNewline ());

		var macro = "(%s_get_type ())".printf (en.get_lower_case_cname (null));
		decl_frag.append (new CCodeMacroReplacement (en.get_upper_case_cname ("TYPE_"), macro));

		var clist = new CCodeInitializerList (); /* or during visit time? */
		CCodeInitializerList clist_ev = null;
		foreach (EnumValue ev in en.get_values ()) {
			clist_ev = new CCodeInitializerList ();
			clist_ev.append (new CCodeConstant (ev.get_cname ()));
			clist_ev.append (new CCodeIdentifier ("\"%s\"".printf (ev.get_cname ())));
			clist_ev.append (ev.get_canonical_cconstant ());
			clist.append (clist_ev);
		}

		clist_ev = new CCodeInitializerList ();
		clist_ev.append (new CCodeConstant ("0"));
		clist_ev.append (new CCodeConstant ("NULL"));
		clist_ev.append (new CCodeConstant ("NULL"));
		clist.append (clist_ev);

		var enum_decl = new CCodeVariableDeclarator.with_initializer ("values[]", clist);

		CCodeDeclaration cdecl = null;
		if (en.is_flags) {
			cdecl = new CCodeDeclaration ("const GFlagsValue");
		} else {
			cdecl = new CCodeDeclaration ("const GEnumValue");
		}

		cdecl.add_declarator (enum_decl);
		cdecl.modifiers = CCodeModifiers.STATIC;

		var type_init = new CCodeBlock ();

		type_init.add_statement (cdecl);

		var fun_name = "%s_get_type".printf (en.get_lower_case_cname (null));
		var regfun = new CCodeFunction (fun_name, "GType");
		var regblock = new CCodeBlock ();

		cdecl = new CCodeDeclaration ("GType");
		string type_id_name = "%s_type_id".printf (en.get_lower_case_cname (null));
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (type_id_name, new CCodeConstant ("0")));
		cdecl.modifiers = CCodeModifiers.STATIC;
		regblock.add_statement (cdecl);

		CCodeFunctionCall reg_call;
		if (en.is_flags) {
			reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_flags_register_static"));
		} else {
			reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_enum_register_static"));
		}

		reg_call.add_argument (new CCodeConstant ("\"%s\"".printf (en.get_cname())));
		reg_call.add_argument (new CCodeIdentifier ("values"));

		type_init.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier (type_id_name), reg_call)));

		var cond = new CCodeFunctionCall (new CCodeIdentifier ("G_UNLIKELY"));
		cond.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier (type_id_name), new CCodeConstant ("0")));
		var cif = new CCodeIfStatement (cond, type_init);
		regblock.add_statement (cif);

		regblock.add_statement (new CCodeReturnStatement (new CCodeConstant (type_id_name)));

		if (en.access != SymbolAccessibility.PRIVATE) {
			header_type_member_declaration.append (regfun.copy ());
		} else {
			source_type_member_declaration.append (regfun.copy ());
		}
		regfun.block = regblock;

		source_type_member_definition.append (new CCodeNewline ());
		source_type_member_definition.append (regfun);
	}

	public override void visit_enum_value (EnumValue! ev) {
		if (ev.value == null) {
			cenum.add_value (new CCodeEnumValue (ev.get_cname ()));
		} else {
			ev.value.accept (this);
			cenum.add_value (new CCodeEnumValue (ev.get_cname (), (CCodeExpression) ev.value.ccodenode));
		}
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		cenum = new CCodeEnum (edomain.get_cname ());

		if (edomain.source_reference.comment != null) {
			header_type_definition.append (new CCodeComment (edomain.source_reference.comment));
		}
		header_type_definition.append (cenum);

		edomain.accept_children (this);

		string quark_fun_name = edomain.get_lower_case_cprefix () + "quark";

		var error_domain_define = new CCodeMacroReplacement (edomain.get_upper_case_cname (), quark_fun_name + " ()");
		header_type_definition.append (error_domain_define);

		var cquark_fun = new CCodeFunction (quark_fun_name, gquark_type.data_type.get_cname ());
		var cquark_block = new CCodeBlock ();

		var cquark_call = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
		cquark_call.add_argument (new CCodeConstant ("\"" + edomain.get_lower_case_cname () + "-quark\""));

		cquark_block.add_statement (new CCodeReturnStatement (cquark_call));

		header_type_member_declaration.append (cquark_fun.copy ());

		cquark_fun.block = cquark_block;
		source_type_member_definition.append (cquark_fun);
	}

	public override void visit_error_code (ErrorCode ecode) {
		if (ecode.value == null) {
			cenum.add_value (new CCodeEnumValue (ecode.get_cname ()));
		} else {
			ecode.value.accept (this);
			cenum.add_value (new CCodeEnumValue (ecode.get_cname (), (CCodeExpression) ecode.value.ccodenode));
		}
	}

	public override void visit_delegate (Delegate! d) {
		d.accept_children (this);

		var cfundecl = new CCodeFunctionDeclarator (d.get_cname ());
		foreach (FormalParameter param in d.get_parameters ()) {
			cfundecl.add_parameter ((CCodeFormalParameter) param.ccodenode);
		}
		if (d.instance) {
			var cparam = new CCodeFormalParameter ("user_data", "void*");
			cfundecl.add_parameter (cparam);
		}

		var ctypedef = new CCodeTypeDefinition (d.return_type.get_cname (), cfundecl);

		if (!d.is_internal_symbol ()) {
			header_type_declaration.append (ctypedef);
		} else {
			source_type_member_declaration.append (ctypedef);
		}
	}
	
	public override void visit_member (Member! m) {
		/* stuff meant for all lockable members */
		if (m is Lockable && ((Lockable)m).get_lock_used ()) {
			instance_priv_struct.add_field (mutex_type.get_cname (), get_symbol_lock_name (m));
			
			instance_init_fragment.append (
				new CCodeExpressionStatement (
					new CCodeAssignment (
						new CCodeMemberAccess.pointer (
							new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"),
							get_symbol_lock_name (m)),
					new CCodeFunctionCall (new CCodeIdentifier (((Class)mutex_type.data_type).default_construction_method.get_cname ())))));
			
			requires_free_checked = true;
			var fc = new CCodeFunctionCall (new CCodeIdentifier ("VALA_FREE_CHECKED"));
			fc.add_argument (
				new CCodeMemberAccess.pointer (
					new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"),
					get_symbol_lock_name (m)));
			if (mutex_type.data_type.get_free_function () == null) {
				Report.error (mutex_type.data_type.source_reference, "The type `%s` doesn't contain a free function".printf (mutex_type.data_type.get_full_name ()));
				return;
			}
			fc.add_argument (new CCodeIdentifier (mutex_type.data_type.get_free_function ()));
			if (instance_dispose_fragment != null) {
				instance_dispose_fragment.append (new CCodeExpressionStatement (fc));
			}
		}
	}

	public override void visit_constant (Constant! c) {
		c.accept_children (this);

		if (!c.is_internal_symbol () && !(c.type_reference is ArrayType)) {
			var cdefine = new CCodeMacroReplacement.with_expression (c.get_cname (), (CCodeExpression) c.initializer.ccodenode);
			header_type_member_declaration.append (cdefine);
		} else {
			var cdecl = new CCodeDeclaration (c.type_reference.get_const_cname ());
			var arr = "";
			if (c.type_reference is ArrayType) {
				arr = "[]";
			}
			cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("%s%s".printf (c.get_cname (), arr), (CCodeExpression) c.initializer.ccodenode));
			cdecl.modifiers = CCodeModifiers.STATIC;
		
			if (!c.is_internal_symbol ()) {
				header_constant_declaration.append (cdecl);
			} else {
				source_constant_declaration.append (cdecl);
			}
		}
	}

	public override void visit_field (Field! f) {
		f.accept_children (this);

		var cl = f.parent_symbol as Class;
		bool is_gtypeinstance = (cl != null && cl.is_subtype_of (gtypeinstance_type));

		CCodeExpression lhs = null;
		CCodeStruct st = null;
		
		string field_ctype = f.type_reference.get_cname ();
		if (f.is_volatile) {
			field_ctype = "volatile " + field_ctype;
		}

		if (f.access != SymbolAccessibility.PRIVATE) {
			st = instance_struct;
			if (f.instance) {
				lhs = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), f.get_cname ());
			} else {
				var cdecl = new CCodeDeclaration (field_ctype);
				cdecl.add_declarator (new CCodeVariableDeclarator (f.get_cname ()));
				cdecl.modifiers = CCodeModifiers.EXTERN;
				header_type_member_declaration.append (cdecl);

				var var_decl = new CCodeVariableDeclarator (f.get_cname ());
				var_decl.initializer = default_value_for_type (f.type_reference, true);

				if (f.initializer != null) {
					var init = (CCodeExpression) f.initializer.ccodenode;
					if (is_constant_ccode_expression (init)) {
						var_decl.initializer = init;
					}
				}

				var var_def = new CCodeDeclaration (field_ctype);
				var_def.add_declarator (var_decl);
				var_def.modifiers = CCodeModifiers.EXTERN;
				source_type_member_declaration.append (var_def);

				lhs = new CCodeIdentifier (f.get_cname ());
			}
		} else if (f.access == SymbolAccessibility.PRIVATE) {
			if (f.instance) {
				if (is_gtypeinstance) {
					st = instance_priv_struct;
					lhs = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), f.get_cname ());
				} else {
					st = instance_struct;
					lhs = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), f.get_cname ());
				}
			} else {
				var cdecl = new CCodeDeclaration (field_ctype);
				var var_decl = new CCodeVariableDeclarator (f.get_cname ());
				if (f.initializer != null) {
					var init = (CCodeExpression) f.initializer.ccodenode;
					if (is_constant_ccode_expression (init)) {
						var_decl.initializer = init;
					}
				}
				cdecl.add_declarator (var_decl);
				cdecl.modifiers = CCodeModifiers.STATIC;
				source_type_member_declaration.append (cdecl);

				lhs = new CCodeIdentifier (f.get_cname ());
			}
		}

		if (f.instance)  {
			st.add_field (field_ctype, f.get_cname ());
			if (f.type_reference is ArrayType && !f.no_array_length) {
				// create fields to store array dimensions
				var array_type = (ArrayType) f.type_reference;
				
				for (int dim = 1; dim <= array_type.rank; dim++) {
					var len_type = int_type.copy ();

					st.add_field (len_type.get_cname (), get_array_length_cname (f.name, dim));
				}
			} else if (f.type_reference is DelegateType) {
				var delegate_type = (DelegateType) f.type_reference;
				if (delegate_type.delegate_symbol.instance) {
					// create field to store delegate target
					st.add_field ("gpointer", get_delegate_target_cname (f.name));
				}
			}

			if (f.initializer != null) {
				var rhs = (CCodeExpression) f.initializer.ccodenode;
				rhs = get_implicit_cast_expression (rhs, f.initializer.static_type, f.type_reference);

				instance_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (lhs, rhs)));

				if (f.type_reference is ArrayType && !f.no_array_length &&
				    f.initializer is ArrayCreationExpression) {
					var array_type = (ArrayType) f.type_reference;
					var ma = new MemberAccess.simple (f.name);
					ma.symbol_reference = f;
					
					Gee.List<Expression> sizes = ((ArrayCreationExpression) f.initializer).get_sizes ();
					for (int dim = 1; dim <= array_type.rank; dim++) {
						var array_len_lhs = get_array_length_cexpression (ma, dim);
						var size = sizes[dim - 1];
						instance_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (array_len_lhs, (CCodeExpression) size.ccodenode)));
					}
				}
			}
			
			if (f.type_reference.takes_ownership && instance_dispose_fragment != null) {
				var ma = new MemberAccess.simple (f.name);
				ma.symbol_reference = f;
				instance_dispose_fragment.append (new CCodeExpressionStatement (get_unref_expression (lhs, f.type_reference, ma)));
			}
		} else {
			/* add array length fields where necessary */
			if (f.type_reference is ArrayType && !f.no_array_length) {
				var array_type = (ArrayType) f.type_reference;

				for (int dim = 1; dim <= array_type.rank; dim++) {
					var len_type = int_type.copy ();

					var cdecl = new CCodeDeclaration (len_type.get_cname ());
					cdecl.add_declarator (new CCodeVariableDeclarator (get_array_length_cname (f.get_cname (), dim)));
					if (f.access != SymbolAccessibility.PRIVATE) {
						cdecl.modifiers = CCodeModifiers.EXTERN;
						header_type_member_declaration.append (cdecl);
					} else {
						cdecl.modifiers = CCodeModifiers.STATIC;
						source_type_member_declaration.append (cdecl);
					}
				}
			} else if (f.type_reference is DelegateType) {
				var delegate_type = (DelegateType) f.type_reference;
				if (delegate_type.delegate_symbol.instance) {
					// create field to store delegate target
					var cdecl = new CCodeDeclaration ("gpointer");
					cdecl.add_declarator (new CCodeVariableDeclarator (get_delegate_target_cname  (f.get_cname ())));
					if (f.access != SymbolAccessibility.PRIVATE) {
						cdecl.modifiers = CCodeModifiers.EXTERN;
						header_type_member_declaration.append (cdecl);
					} else {
						cdecl.modifiers = CCodeModifiers.STATIC;
						source_type_member_declaration.append (cdecl);
					}
				}
			}

			if (f.initializer != null) {
				var rhs = (CCodeExpression) f.initializer.ccodenode;
				if (!is_constant_ccode_expression (rhs)) {
					if (f.parent_symbol is Class) {
						class_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (lhs, rhs)));
					} else {
						f.error = true;
						Report.error (f.source_reference, "Non-constant field initializers not supported in this context");
						return;
					}
				}
			}
		}
	}

	private bool is_constant_ccode_expression (CCodeExpression! cexpr) {
		if (cexpr is CCodeConstant) {
			return true;
		} else if (cexpr is CCodeBinaryExpression) {
			var cbinary = (CCodeBinaryExpression) cexpr;
			return is_constant_ccode_expression (cbinary.left) && is_constant_ccode_expression (cbinary.right);
		}

		var cparenthesized = (cexpr as CCodeParenthesizedExpression);
		return (null != cparenthesized && is_constant_ccode_expression (cparenthesized.inner));
	}

	/**
	 * Returns whether the passed cexpr is a pure expression, i.e. an
	 * expression without side-effects.
	 */
	public bool is_pure_ccode_expression (CCodeExpression! cexpr) {
		if (cexpr is CCodeConstant || cexpr is CCodeIdentifier) {
			return true;
		} else if (cexpr is CCodeBinaryExpression) {
			var cbinary = (CCodeBinaryExpression) cexpr;
			return is_pure_ccode_expression (cbinary.left) && is_constant_ccode_expression (cbinary.right);
		} else if (cexpr is CCodeMemberAccess) {
			var cma = (CCodeMemberAccess) cexpr;
			return is_pure_ccode_expression (cma.inner);
		}

		var cparenthesized = (cexpr as CCodeParenthesizedExpression);
		return (null != cparenthesized && is_pure_ccode_expression (cparenthesized.inner));
	}

	public override void visit_formal_parameter (FormalParameter! p) {
		p.accept_children (this);

		if (!p.ellipsis) {
			string ctypename = p.type_reference.get_cname (false, !p.type_reference.transfers_ownership);
			string cname = p.name;

			// pass non-simple structs always by reference
			if (p.type_reference.data_type is Struct) {
				var st = (Struct) p.type_reference.data_type;
				if (!st.is_simple_type () && !p.type_reference.is_ref && !p.type_reference.is_out) {
					ctypename += "*";
				}
			}

			p.ccodenode = new CCodeFormalParameter (cname, ctypename);
		} else {
			p.ccodenode = new CCodeFormalParameter.with_ellipsis ();
		}
	}

	public override void visit_property (Property! prop) {
		int old_next_temp_var_id = next_temp_var_id;
		next_temp_var_id = 0;

		prop.accept_children (this);

		next_temp_var_id = old_next_temp_var_id;

		// FIXME: omit real struct types for now since they cannot be expressed as gobject property yet
		// don't register private properties
		if (prop.parent_symbol is Class && !prop.type_reference.is_real_struct_type () && prop.access != SymbolAccessibility.PRIVATE) {
			prop_enum.add_value (new CCodeEnumValue (prop.get_upper_case_cname ()));
		}
	}

	public override void visit_property_accessor (PropertyAccessor! acc) {
		current_property_accessor = acc;
		current_method_inner_error = false;

		var prop = (Property) acc.prop;

		bool returns_real_struct = prop.type_reference.is_real_struct_type ();

		if (acc.readable && !returns_real_struct) {
			current_return_type = prop.type_reference;
		} else {
			current_return_type = new VoidType ();
		}

		acc.accept_children (this);

		current_return_type = null;

		var t = (Typesymbol) prop.parent_symbol;

		ReferenceType this_type;
		if (t is Class) {
			this_type = new ClassType ((Class) t);
		} else {
			this_type = new InterfaceType ((Interface) t);
		}
		var cselfparam = new CCodeFormalParameter ("self", this_type.get_cname ());
		var cvalueparam = new CCodeFormalParameter ("value", prop.type_reference.get_cname (false, true));

		if (prop.is_abstract || prop.is_virtual) {
			if (acc.readable) {
				function = new CCodeFunction ("%s_get_%s".printf (t.get_lower_case_cname (null), prop.name), prop.type_reference.get_cname ());
			} else {
				function = new CCodeFunction ("%s_set_%s".printf (t.get_lower_case_cname (null), prop.name), "void");
			}
			function.add_parameter (cselfparam);
			if (acc.writable || acc.construction) {
				function.add_parameter (cvalueparam);
			}
			
			if (!prop.is_internal_symbol () && (acc.readable || acc.writable) && acc.access != SymbolAccessibility.PRIVATE) {
				// accessor function should be public if the property is a public symbol and it's not a construct-only setter
				header_type_member_declaration.append (function.copy ());
			} else {
				function.modifiers |= CCodeModifiers.STATIC;
				source_type_member_declaration.append (function.copy ());
			}
			
			var block = new CCodeBlock ();
			function.block = block;

			if (acc.readable) {
				// declare temporary variable to save the property value
				var decl = new CCodeDeclaration (prop.type_reference.get_cname ());
				decl.add_declarator (new CCodeVariableDeclarator ("value"));
				block.add_statement (decl);
			
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
			
				var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT"));
				ccast.add_argument (new CCodeIdentifier ("self"));
				ccall.add_argument (ccast);
				
				// property name is second argument of g_object_get
				ccall.add_argument (prop.get_canonical_cconstant ());

				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("value")));

				ccall.add_argument (new CCodeConstant ("NULL"));
				
				block.add_statement (new CCodeExpressionStatement (ccall));

				// HACK: decrement the refcount before returning the value to simulate a weak reference getter function
				if (prop.type_reference.data_type != null && prop.type_reference.data_type.is_reference_counting ()) {
					var unref_cond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("value"), new CCodeConstant ("NULL"));
					var unref_function = new CCodeFunctionCall (get_destroy_func_expression (prop.type_reference));
					unref_function.add_argument (new CCodeIdentifier ("value"));
					var unref_block = new CCodeBlock ();
					unref_block.add_statement (new CCodeExpressionStatement (unref_function));
					block.add_statement (new CCodeIfStatement (unref_cond, unref_block));
				}

				block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("value")));
			} else {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_set"));
			
				var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT"));
				ccast.add_argument (new CCodeIdentifier ("self"));
				ccall.add_argument (ccast);
				
				// property name is second argument of g_object_set
				ccall.add_argument (prop.get_canonical_cconstant ());

				ccall.add_argument (new CCodeIdentifier ("value"));

				ccall.add_argument (new CCodeConstant ("NULL"));
				
				block.add_statement (new CCodeExpressionStatement (ccall));
			}

			source_type_member_definition.append (function);
		}

		if (!prop.is_abstract) {
			bool is_virtual = prop.base_property != null || prop.base_interface_property != null;

			string prefix = t.get_lower_case_cname (null);
			if (is_virtual) {
				prefix += "_real";
			}
			if (acc.readable) {
				if (returns_real_struct) {
					// return non simple structs as out parameter
					function = new CCodeFunction ("%s_get_%s".printf (prefix, prop.name), "void");
				} else {
					function = new CCodeFunction ("%s_get_%s".printf (prefix, prop.name), prop.type_reference.get_cname ());
				}
			} else {
				function = new CCodeFunction ("%s_set_%s".printf (prefix, prop.name), "void");
			}
			if (is_virtual) {
				function.modifiers |= CCodeModifiers.STATIC;
			}
			function.add_parameter (cselfparam);
			if (returns_real_struct) {
				// return non simple structs as out parameter
				var coutparamname = "%s*".printf (prop.type_reference.get_cname (false, true));
				var coutparam = new CCodeFormalParameter ("value", coutparamname);
				function.add_parameter (coutparam);
			} else {
				if (acc.writable || acc.construction) {
					function.add_parameter (cvalueparam);
				}
			}

			if (!is_virtual) {
				if (!prop.is_internal_symbol () && (acc.readable || acc.writable) && acc.access != SymbolAccessibility.PRIVATE) {
					// accessor function should be public if the property is a public symbol and it's not a construct-only setter
					header_type_member_declaration.append (function.copy ());
				} else {
					function.modifiers |= CCodeModifiers.STATIC;
					source_type_member_declaration.append (function.copy ());
				}
			}

			function.block = (CCodeBlock) acc.body.ccodenode;

			if (current_method_inner_error) {
				var cdecl = new CCodeDeclaration ("GError *");
				cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("inner_error", new CCodeConstant ("NULL")));
				function.block.prepend_statement (cdecl);
			}

			if (returns_real_struct) {
				function.block.prepend_statement (create_property_type_check_statement (prop, false, t, true, "self"));
			} else {
				function.block.prepend_statement (create_property_type_check_statement (prop, acc.readable, t, true, "self"));
			}

			// notify on property changes
			if (prop.notify && (acc.writable || acc.construction)) {
				var notify_call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_notify"));
				notify_call.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "GObject *"));
				notify_call.add_argument (prop.get_canonical_cconstant ());
				function.block.add_statement (new CCodeExpressionStatement (notify_call));
			}

			source_type_member_definition.append (function);
		}

		current_property_accessor = null;
	}

	public override void visit_constructor (Constructor! c) {
		current_method_inner_error = false;
		in_constructor = true;

		c.accept_children (this);

		in_constructor = false;

		var cl = (Class) c.parent_symbol;

		if (c.instance) {
			function = new CCodeFunction ("%s_constructor".printf (cl.get_lower_case_cname (null)), "GObject *");
			function.modifiers = CCodeModifiers.STATIC;
		
			function.add_parameter (new CCodeFormalParameter ("type", "GType"));
			function.add_parameter (new CCodeFormalParameter ("n_construct_properties", "guint"));
			function.add_parameter (new CCodeFormalParameter ("construct_properties", "GObjectConstructParam *"));
		
			source_type_member_declaration.append (function.copy ());


			var cblock = new CCodeBlock ();
			var cdecl = new CCodeDeclaration ("GObject *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("obj"));
			cblock.add_statement (cdecl);

			cdecl = new CCodeDeclaration ("%sClass *".printf (cl.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator ("klass"));
			cblock.add_statement (cdecl);

			cdecl = new CCodeDeclaration ("GObjectClass *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("parent_class"));
			cblock.add_statement (cdecl);


			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_peek"));
			ccall.add_argument (new CCodeIdentifier (cl.get_upper_case_cname ("TYPE_")));
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (cl.get_upper_case_cname (null))));
			ccast.add_argument (ccall);
			cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("klass"), ccast)));

			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_peek_parent"));
			ccall.add_argument (new CCodeIdentifier ("klass"));
			ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
			ccast.add_argument (ccall);
			cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("parent_class"), ccast)));

		
			ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (new CCodeIdentifier ("parent_class"), "constructor"));
			ccall.add_argument (new CCodeIdentifier ("type"));
			ccall.add_argument (new CCodeIdentifier ("n_construct_properties"));
			ccall.add_argument (new CCodeIdentifier ("construct_properties"));
			cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("obj"), ccall)));


			ccall = new InstanceCast (new CCodeIdentifier ("obj"), cl);

			cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
		
			cblock.add_statement (cdecl);

			if (current_method_inner_error) {
				/* always separate error parameter and inner_error local variable
				 * as error may be set to NULL but we're always interested in inner errors
				 */
				var cdecl = new CCodeDeclaration ("GError *");
				cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("inner_error", new CCodeConstant ("NULL")));
				cblock.add_statement (cdecl);
			}


			cblock.add_statement (c.body.ccodenode);
		
			cblock.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("obj")));
		
			function.block = cblock;

			if (c.source_reference.comment != null) {
				source_type_member_definition.append (new CCodeComment (c.source_reference.comment));
			}
			source_type_member_definition.append (function);
		} else {
			// static class constructor
			// add to class_init
			class_init_fragment.append (c.body.ccodenode);
		}
	}

	public override void visit_destructor (Destructor! d) {
		d.accept_children (this);
	}

	public override void visit_block (Block! b) {
		current_symbol = b;

		b.accept_children (this);

		var local_vars = b.get_local_variables ();
		foreach (VariableDeclarator decl in local_vars) {
			decl.active = false;
		}
		
		var cblock = new CCodeBlock ();
		
		foreach (CodeNode stmt in b.get_statements ()) {
			var src = stmt.source_reference;
			if (src != null && src.comment != null) {
				cblock.add_statement (new CCodeComment (src.comment));
			}
			
			if (stmt.ccodenode is CCodeFragment) {
				foreach (CCodeNode cstmt in ((CCodeFragment) stmt.ccodenode).get_children ()) {
					cblock.add_statement (cstmt);
				}
			} else {
				cblock.add_statement (stmt.ccodenode);
			}
		}

		foreach (VariableDeclarator decl in local_vars) {
			if (decl.type_reference.takes_ownership) {
				var ma = new MemberAccess.simple (decl.name);
				ma.symbol_reference = decl;
				cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (get_variable_cname (decl.name)), decl.type_reference, ma)));
			}
		}

		if (b.parent_symbol is Method) {
			var m = (Method) b.parent_symbol;
			foreach (FormalParameter param in m.get_parameters ()) {
				if (param.type_reference.data_type != null && param.type_reference.data_type.is_reference_type () && param.type_reference.takes_ownership && !param.type_reference.is_ref && !param.type_reference.is_out) {
					var ma = new MemberAccess.simple (param.name);
					ma.symbol_reference = param;
					cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (get_variable_cname (param.name)), param.type_reference, ma)));
				}
			}
		}

		b.ccodenode = cblock;

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_empty_statement (EmptyStatement! stmt) {
		stmt.ccodenode = new CCodeEmptyStatement ();
	}

	public override void visit_declaration_statement (DeclarationStatement! stmt) {
		/* split declaration statement as var declarators
		 * might have different types */
	
		var cfrag = new CCodeFragment ();
		
		foreach (VariableDeclarator decl in stmt.declaration.get_variable_declarators ()) {
			var cdecl = new CCodeDeclaration (decl.type_reference.get_cname (false, !decl.type_reference.takes_ownership));
		
			cdecl.add_declarator ((CCodeVariableDeclarator) decl.ccodenode);

			cfrag.append (cdecl);

			if (decl.initializer != null && decl.initializer.can_fail) {
				add_simple_check (decl.initializer, cfrag);
			}

			/* try to initialize uninitialized variables */
			if (decl.initializer == null) {
				((CCodeVariableDeclarator) decl.ccodenode).initializer = default_value_for_type (decl.type_reference, true);
			}
		}
		
		stmt.ccodenode = cfrag;

		foreach (VariableDeclarator decl in stmt.declaration.get_variable_declarators ()) {
			if (decl.initializer != null) {
				create_temp_decl (stmt, decl.initializer.temp_vars);
			}
		}

		create_temp_decl (stmt, temp_vars);
		temp_vars.clear ();
	}

	private string! get_variable_cname (string! name) {
		if (c_keywords.contains (name)) {
			return name + "_";
		} else {
			return name;
		}
	}

	public override void visit_variable_declarator (VariableDeclarator! decl) {
		decl.accept_children (this);

		if (decl.type_reference is ArrayType) {
			// create variables to store array dimensions
			var array_type = (ArrayType) decl.type_reference;
			
			for (int dim = 1; dim <= array_type.rank; dim++) {
				var len_decl = new VariableDeclarator (get_array_length_cname (decl.name, dim));
				len_decl.type_reference = int_type.copy ();

				temp_vars.insert (0, len_decl);
			}
		} else if (decl.type_reference is DelegateType) {
			var deleg_type = (DelegateType) decl.type_reference;
			var d = deleg_type.delegate_symbol;
			if (d.instance) {
				// create variable to store delegate target
				var target_decl = new VariableDeclarator (get_delegate_target_cname (decl.name));
				target_decl.type_reference = new PointerType (new VoidType ());

				temp_vars.insert (0, target_decl);
			}
		}
	
		CCodeExpression rhs = null;
		if (decl.initializer != null) {
			rhs = (CCodeExpression) decl.initializer.ccodenode;
			rhs = get_implicit_cast_expression (rhs, decl.initializer.static_type, decl.type_reference);

			if (decl.type_reference is ArrayType) {
				var array_type = (ArrayType) decl.type_reference;

				var ccomma = new CCodeCommaExpression ();

				var temp_decl = get_temp_variable_declarator (decl.type_reference, true, decl);
				temp_vars.insert (0, temp_decl);
				ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_decl.name), rhs));

				for (int dim = 1; dim <= array_type.rank; dim++) {
					var lhs_array_len = new CCodeIdentifier (get_array_length_cname (decl.name, dim));
					var rhs_array_len = get_array_length_cexpression (decl.initializer, dim);
					ccomma.append_expression (new CCodeAssignment (lhs_array_len, rhs_array_len));
				}
				
				ccomma.append_expression (new CCodeIdentifier (temp_decl.name));
				
				rhs = ccomma;
			} else if (decl.type_reference is DelegateType) {
				var deleg_type = (DelegateType) decl.type_reference;
				var d = deleg_type.delegate_symbol;
				if (d.instance) {
					var ccomma = new CCodeCommaExpression ();

					var temp_decl = get_temp_variable_declarator (decl.type_reference, true, decl);
					temp_vars.insert (0, temp_decl);
					ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_decl.name), rhs));

					var lhs_delegate_target = new CCodeIdentifier (get_delegate_target_cname (decl.name));
					var rhs_delegate_target = get_delegate_target_cexpression (decl.initializer);
					ccomma.append_expression (new CCodeAssignment (lhs_delegate_target, rhs_delegate_target));
				
					ccomma.append_expression (new CCodeIdentifier (temp_decl.name));
				
					rhs = ccomma;
				}
			}
		} else if (decl.type_reference.data_type != null && decl.type_reference.data_type.is_reference_type ()) {
			rhs = new CCodeConstant ("NULL");
		}
			
		decl.ccodenode = new CCodeVariableDeclarator.with_initializer (get_variable_cname (decl.name), rhs);

		decl.active = true;
	}

	public override void visit_initializer_list (InitializerList! list) {
		list.accept_children (this);

		if (list.expected_type is ArrayType) {
			/* TODO */
		} else {
			var clist = new CCodeInitializerList ();
			foreach (Expression expr in list.get_initializers ()) {
				clist.append ((CCodeExpression) expr.ccodenode);
			}
			list.ccodenode = clist;
		}
	}

	public VariableDeclarator get_temp_variable_declarator (DataType! type, bool takes_ownership = true, CodeNode node_reference = null) {
		var decl = new VariableDeclarator ("_tmp%d".printf (next_temp_var_id));
		decl.type_reference = type.copy ();
		decl.type_reference.is_ref = false;
		decl.type_reference.is_out = false;
		decl.type_reference.takes_ownership = takes_ownership;

		if (node_reference != null) {
			decl.source_reference = node_reference.source_reference;
		}

		next_temp_var_id++;
		
		return decl;
	}

	private CCodeExpression get_type_id_expression (DataType! type) {
		if (type.data_type != null) {
			return new CCodeIdentifier (type.data_type.get_type_id ());
		} else if (type.type_parameter != null) {
			string var_name = "%s_type".printf (type.type_parameter.name.down ());
			return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), var_name);
		} else {
			return new CCodeIdentifier ("G_TYPE_NONE");
		}
	}

	private CCodeExpression get_dup_func_expression (DataType! type) {
		if (type.data_type != null) {
			string dup_function;
			if (type.data_type.is_reference_counting ()) {
				dup_function = type.data_type.get_ref_function ();
			} else if (type.data_type == string_type.data_type) {
				dup_function = type.data_type.get_dup_function ();
			} else {
				// duplicating non-reference counted structs may cause side-effects (and performance issues)
				Report.error (type.source_reference, "duplicating %s instance, use weak variable or explicitly invoke copy method".printf (type.data_type.name));
				return null;
			}

			return new CCodeIdentifier (dup_function);
		} else if (type.type_parameter != null && current_type_symbol is Class) {
			string func_name = "%s_dup_func".printf (type.type_parameter.name.down ());
			return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
		} else if (type is ArrayType) {
			Report.error (type.source_reference, "internal error: duplicating %s instances not yet supported".printf (type.to_string ()));
			return null;
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	private CCodeExpression get_destroy_func_expression (DataType! type) {
		if (type.data_type != null) {
			string unref_function;
			if (type.data_type.is_reference_counting ()) {
				unref_function = type.data_type.get_unref_function ();
			} else {
				unref_function = type.data_type.get_free_function ();
			}
			if (unref_function == null) {
				Report.error (type.data_type.source_reference, "The type `%s` doesn't contain a free function".printf (type.data_type.get_full_name ()));
				return null;
			}
			return new CCodeIdentifier (unref_function);
		} else if (type.type_parameter != null && current_type_symbol is Class) {
			string func_name = "%s_destroy_func".printf (type.type_parameter.name.down ());
			return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
		} else if (type is ArrayType) {
			return new CCodeIdentifier ("g_free");
		} else if (type is PointerType) {
			return new CCodeIdentifier ("g_free");
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	public CCodeExpression get_unref_expression (CCodeExpression! cvar, DataType! type, Expression expr) {
		/* (foo == NULL ? NULL : foo = (unref (foo), NULL)) */
		
		/* can be simplified to
		 * foo = (unref (foo), NULL)
		 * if foo is of static type non-null
		 */

		var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, cvar, new CCodeConstant ("NULL"));
		if (type.type_parameter != null) {
			if (!(current_type_symbol is Class) || !current_class.is_subtype_of (gobject_type)) {
				return new CCodeConstant ("NULL");
			}

			// unref functions are optional for type parameters
			var cunrefisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, get_destroy_func_expression (type), new CCodeConstant ("NULL"));
			cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cisnull, cunrefisnull);
		}

		var ccall = new CCodeFunctionCall (get_destroy_func_expression (type));
		ccall.add_argument (cvar);
		
		/* set freed references to NULL to prevent further use */
		var ccomma = new CCodeCommaExpression ();

		if (type.data_type == glist_type || type.data_type == gslist_type) {
			bool takes_ownership = false;
			CCodeExpression destroy_func_expression = null;

			foreach (DataType type_arg in type.get_type_arguments ()) {
				takes_ownership = type_arg.takes_ownership;
				if (takes_ownership) {
					destroy_func_expression = get_destroy_func_expression (type_arg);
				}
			}
			
			if (takes_ownership) {
				CCodeFunctionCall cunrefcall;
				if (type.data_type == glist_type) {
					cunrefcall = new CCodeFunctionCall (new CCodeIdentifier ("g_list_foreach"));
				} else {
					cunrefcall = new CCodeFunctionCall (new CCodeIdentifier ("g_slist_foreach"));
				}
				cunrefcall.add_argument (cvar);
				cunrefcall.add_argument (new CCodeCastExpression (destroy_func_expression, "GFunc"));
				cunrefcall.add_argument (new CCodeConstant ("NULL"));
				ccomma.append_expression (cunrefcall);
			}
		} else if (type.data_type == gstring_type || type.data_type == gstringbuilder_type) {
			ccall.add_argument (new CCodeConstant ("TRUE"));
		} else if (type is ArrayType) {
			var array_type = (ArrayType) type;
			if (array_type.element_type.data_type == null || array_type.element_type.data_type.is_reference_type ()) {
				requires_array_free = true;

				bool first = true;
				CCodeExpression csizeexpr = null;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					if (first) {
						csizeexpr = get_array_length_cexpression (expr, dim);
						first = false;
					} else {
						csizeexpr = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, csizeexpr, get_array_length_cexpression (expr, dim));
					}
				}

				ccall.call = new CCodeIdentifier ("_vala_array_free");
				ccall.add_argument (csizeexpr);
				ccall.add_argument (new CCodeCastExpression (get_destroy_func_expression (array_type.element_type), "GDestroyNotify"));
			}
		}
		
		ccomma.append_expression (ccall);
		ccomma.append_expression (new CCodeConstant ("NULL"));
		
		var cassign = new CCodeAssignment (cvar, ccomma);

		// g_free (NULL) is allowed
		bool uses_gfree = (type.data_type != null && !type.data_type.is_reference_counting () && type.data_type.get_free_function () == "g_free");
		uses_gfree = uses_gfree || type is ArrayType;
		if ((context.non_null && !type.requires_null_check) || uses_gfree) {
			return new CCodeParenthesizedExpression (cassign);
		}

		return new CCodeConditionalExpression (cisnull, new CCodeConstant ("NULL"), new CCodeParenthesizedExpression (cassign));
	}
	
	public override void visit_end_full_expression (Expression! expr) {
		/* expr is a full expression, i.e. an initializer, the
		 * expression in an expression statement, the controlling
		 * expression in if, while, for, or foreach statements
		 *
		 * we unref temporary variables at the end of a full
		 * expression
		 */
		
		/* can't automatically deep copy lists yet, so do it
		 * manually for now
		 * replace with
		 * expr.temp_vars = temp_vars;
		 * when deep list copying works
		 */
		expr.temp_vars.clear ();
		foreach (VariableDeclarator decl1 in temp_vars) {
			expr.temp_vars.add (decl1);
		}
		temp_vars.clear ();

		if (((Gee.List<VariableDeclarator>) temp_ref_vars).size == 0) {
			/* nothing to do without temporary variables */
			return;
		}
		
		var full_expr_decl = get_temp_variable_declarator (expr.static_type, true, expr);
		expr.temp_vars.add (full_expr_decl);
		
		var expr_list = new CCodeCommaExpression ();
		expr_list.append_expression (new CCodeAssignment (new CCodeIdentifier (full_expr_decl.name), (CCodeExpression) expr.ccodenode));
		
		foreach (VariableDeclarator decl in temp_ref_vars) {
			var ma = new MemberAccess.simple (decl.name);
			ma.symbol_reference = decl;
			expr_list.append_expression (get_unref_expression (new CCodeIdentifier (decl.name), decl.type_reference, ma));
		}
		
		expr_list.append_expression (new CCodeIdentifier (full_expr_decl.name));
		
		expr.ccodenode = expr_list;
		
		temp_ref_vars.clear ();
	}
	
	private void append_temp_decl (CCodeFragment! cfrag, Collection<VariableDeclarator> temp_vars) {
		foreach (VariableDeclarator decl in temp_vars) {
			var cdecl = new CCodeDeclaration (decl.type_reference.get_cname (true, !decl.type_reference.takes_ownership));
		
			var vardecl = new CCodeVariableDeclarator (decl.name);
			// sets #line
			decl.ccodenode = vardecl;
			cdecl.add_declarator (vardecl);

			var st = decl.type_reference.data_type as Struct;

			if (decl.type_reference.is_reference_type_or_type_parameter ()) {
				vardecl.initializer = new CCodeConstant ("NULL");
			} else if (st != null && !st.is_simple_type ()) {
				// 0-initialize struct with struct initializer { 0 }
				// necessary as they will be passed by reference
				var clist = new CCodeInitializerList ();
				clist.append (new CCodeConstant ("0"));

				vardecl.initializer = clist;
			}
			
			cfrag.append (cdecl);
		}
	}

	private void add_simple_check (CodeNode! node, CCodeFragment! cfrag) {
		current_method_inner_error = true;

		var cprint_frag = new CCodeFragment ();
		var ccritical = new CCodeFunctionCall (new CCodeIdentifier ("g_critical"));
		ccritical.add_argument (new CCodeConstant ("\"file %s: line %d: uncaught error: %s\""));
		ccritical.add_argument (new CCodeConstant ("__FILE__"));
		ccritical.add_argument (new CCodeConstant ("__LINE__"));
		ccritical.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("inner_error"), "message"));
		cprint_frag.append (new CCodeExpressionStatement (ccritical));
		var cclear = new CCodeFunctionCall (new CCodeIdentifier ("g_clear_error"));
		cclear.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("inner_error")));
		cprint_frag.append (new CCodeExpressionStatement (cclear));

		if (current_try != null) {
			// surrounding try found
			// TODO might be the wrong one when using nested try statements

			var cerror_block = new CCodeBlock ();
			foreach (CatchClause clause in current_try.get_catch_clauses ()) {
				// go to catch clause if error domain matches
				var cgoto_stmt = new CCodeGotoStatement ("__catch%d_%s".printf (current_try_id, clause.type_reference.get_lower_case_cname ()));

				if (clause.type_reference.equals (gerror_type)) {
					// general catch clause
					cerror_block.add_statement (cgoto_stmt);
				} else {
					var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeMemberAccess.pointer (new CCodeIdentifier ("inner_error"), "domain"), new CCodeIdentifier (clause.type_reference.data_type.get_upper_case_cname ()));

					var cgoto_block = new CCodeBlock ();
					cgoto_block.add_statement (cgoto_stmt);

					cerror_block.add_statement (new CCodeIfStatement (ccond, cgoto_block));
				}
			}
			// print critical message if no catch clause matches
			cerror_block.add_statement (cprint_frag);

			// check error domain if expression failed
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("inner_error"), new CCodeConstant ("NULL"));

			cfrag.append (new CCodeIfStatement (ccond, cerror_block));
		} else if (current_method != null && current_method.get_error_domains ().size > 0) {
			// current method can fail, propagate error
			// TODO ensure one of the error domains matches

			var cpropagate = new CCodeFunctionCall (new CCodeIdentifier ("g_propagate_error"));
			cpropagate.add_argument (new CCodeIdentifier ("error"));
			cpropagate.add_argument (new CCodeIdentifier ("inner_error"));

			var cerror_block = new CCodeBlock ();
			cerror_block.add_statement (new CCodeExpressionStatement (cpropagate));

			if (current_return_type is VoidType) {
				cerror_block.add_statement (new CCodeReturnStatement ());
			} else {
				cerror_block.add_statement (new CCodeReturnStatement (default_value_for_type (current_return_type, false)));
			}

			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("inner_error"), new CCodeConstant ("NULL"));

			cfrag.append (new CCodeIfStatement (ccond, cerror_block));
		} else {
			// TODO improve check and move to semantic analyzer
			Report.warning (node.source_reference, "unhandled error");

			var cerror_block = new CCodeBlock ();
			// print critical message
			cerror_block.add_statement (cprint_frag);

			// check error domain if expression failed
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("inner_error"), new CCodeConstant ("NULL"));

			cfrag.append (new CCodeIfStatement (ccond, cerror_block));
		}
	}

	public override void visit_expression_statement (ExpressionStatement! stmt) {
		stmt.ccodenode = new CCodeExpressionStatement ((CCodeExpression) stmt.expression.ccodenode);

		if (stmt.tree_can_fail && stmt.expression.can_fail) {
			// simple case, no node breakdown necessary

			var cfrag = new CCodeFragment ();

			cfrag.append (stmt.ccodenode);

			add_simple_check (stmt.expression, cfrag);

			stmt.ccodenode = cfrag;
		}

		/* free temporary objects */

		if (((Gee.List<VariableDeclarator>) temp_vars).size == 0) {
			/* nothing to do without temporary variables */
			return;
		}
		
		var cfrag = new CCodeFragment ();
		append_temp_decl (cfrag, temp_vars);
		
		cfrag.append (stmt.ccodenode);
		
		foreach (VariableDeclarator decl in temp_ref_vars) {
			var ma = new MemberAccess.simple (decl.name);
			ma.symbol_reference = decl;
			cfrag.append (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (decl.name), decl.type_reference, ma)));
		}
		
		stmt.ccodenode = cfrag;
		
		temp_vars.clear ();
		temp_ref_vars.clear ();
	}
	
	private void create_temp_decl (Statement! stmt, Collection<VariableDeclarator> temp_vars) {
		/* declare temporary variables */
		
		if (temp_vars.size == 0) {
			/* nothing to do without temporary variables */
			return;
		}
		
		var cfrag = new CCodeFragment ();
		append_temp_decl (cfrag, temp_vars);
		
		// FIXME cast to CodeNode shouldn't be necessary as Statement requires CodeNode
		cfrag.append (((CodeNode) stmt).ccodenode);
		
		((CodeNode) stmt).ccodenode = cfrag;
	}

	public override void visit_if_statement (IfStatement! stmt) {
		stmt.accept_children (this);

		if (stmt.false_statement != null) {
			stmt.ccodenode = new CCodeIfStatement ((CCodeExpression) stmt.condition.ccodenode, (CCodeStatement) stmt.true_statement.ccodenode, (CCodeStatement) stmt.false_statement.ccodenode);
		} else {
			stmt.ccodenode = new CCodeIfStatement ((CCodeExpression) stmt.condition.ccodenode, (CCodeStatement) stmt.true_statement.ccodenode);
		}
		
		create_temp_decl (stmt, stmt.condition.temp_vars);
	}

	public override void visit_switch_statement (SwitchStatement! stmt) {
		// we need a temporary variable to save the property value
		var temp_decl = get_temp_variable_declarator (stmt.expression.static_type, true, stmt);
		stmt.expression.temp_vars.insert (0, temp_decl);

		var ctemp = new CCodeIdentifier (temp_decl.name);
		var cinit = new CCodeAssignment (ctemp, (CCodeExpression) stmt.expression.ccodenode);
		var czero = new CCodeConstant ("0");

		var cswitchblock = new CCodeFragment ();
		stmt.ccodenode = cswitchblock;

		var is_string_cmp = temp_decl.type_reference.data_type.is_subtype_of (string_type.data_type);

		if (is_string_cmp) {
			var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeConstant ("NULL"), ctemp);
			var cquark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_string"));
			cquark.add_argument (ctemp);

			var ccond = new CCodeConditionalExpression (cisnull, new CCodeConstant ("0"), cquark);

			temp_decl = get_temp_variable_declarator (gquark_type);
			stmt.expression.temp_vars.insert (0, temp_decl);

			var label_count = 0;

			foreach (SwitchSection section in stmt.get_sections ()) {
				if (section.has_default_label ()) {
					continue;
				}

				foreach (SwitchLabel label in section.get_labels ()) {
					var cexpr = (CCodeExpression) label.expression.ccodenode;

					if (is_constant_ccode_expression (cexpr)) {
						var cname = "%s_label%d".printf (temp_decl.name, label_count++);
						var cdecl = new CCodeDeclaration (gquark_type.get_cname ());

						cdecl.modifiers = CCodeModifiers.STATIC;
						cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (cname, czero));

						cswitchblock.append (cdecl);
					}
				}
			}

			cswitchblock.append (new CCodeExpressionStatement (cinit));

			ctemp = new CCodeIdentifier (temp_decl.name);
			cinit = new CCodeAssignment (ctemp, ccond);
		}

		cswitchblock.append (new CCodeExpressionStatement (cinit));
		create_temp_decl (stmt, stmt.expression.temp_vars);

		Collection<Statement> default_statements = null;
		var label_count = 0;

		// generate nested if statements		
		CCodeStatement ctopstmt = null;
		CCodeIfStatement coldif = null;

		foreach (SwitchSection section in stmt.get_sections ()) {
			if (section.has_default_label ()) {
				default_statements = section.get_statements ();
				continue;
			}

			CCodeBinaryExpression cor = null;
			foreach (SwitchLabel label in section.get_labels ()) {
				var cexpr = (CCodeExpression) label.expression.ccodenode;

				if (is_string_cmp) {
					if (is_constant_ccode_expression (cexpr)) {
						var cname = new CCodeIdentifier ("%s_label%d".printf (temp_decl.name, label_count++));
						var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, czero, cname);
						var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
						var cinit = new CCodeParenthesizedExpression (new CCodeAssignment (cname, ccall));

						ccall.add_argument (cexpr);

						cexpr = new CCodeConditionalExpression (ccond, cname, cinit);
					} else {
						var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_string"));
						ccall.add_argument (cexpr);
						cexpr = ccall;
					}
				}

				var ccmp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ctemp, cexpr);

				if (cor == null) {
					cor = ccmp;
				} else {
					cor = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cor, ccmp);
				}
			}

			var cblock = new CCodeBlock ();
			foreach (CodeNode body_stmt in section.get_statements ()) {
				if (body_stmt.ccodenode is CCodeFragment) {
					foreach (CCodeNode cstmt in ((CCodeFragment) body_stmt.ccodenode).get_children ()) {
						cblock.add_statement (cstmt);
					}
				} else {
					cblock.add_statement (body_stmt.ccodenode);
				}
			}

			var cdo = new CCodeDoStatement (cblock, new CCodeConstant ("0"));
			var cif = new CCodeIfStatement (cor, cdo);

			if (coldif != null) {
				coldif.false_statement = cif;
			} else {
				ctopstmt = cif;
			}

			coldif = cif;
		}
		
		if (default_statements != null) {
			var cblock = new CCodeBlock ();
			foreach (CodeNode body_stmt in default_statements) {
				cblock.add_statement (body_stmt.ccodenode);
			}
			
			var cdo = new CCodeDoStatement (cblock, new CCodeConstant ("0"));

			if (coldif == null) {
				// there is only one section and that section
				// contains a default label
				ctopstmt = cdo;
			} else {
				coldif.false_statement = cdo;
			}
		}
		
		cswitchblock.append (ctopstmt);
	}

	public override void visit_switch_section (SwitchSection! section) {
		visit_block (section);
	}

	public override void visit_while_statement (WhileStatement! stmt) {
		stmt.accept_children (this);

		stmt.ccodenode = new CCodeWhileStatement ((CCodeExpression) stmt.condition.ccodenode, (CCodeStatement) stmt.body.ccodenode);
		
		create_temp_decl (stmt, stmt.condition.temp_vars);
	}

	public override void visit_do_statement (DoStatement! stmt) {
		stmt.accept_children (this);

		stmt.ccodenode = new CCodeDoStatement ((CCodeStatement) stmt.body.ccodenode, (CCodeExpression) stmt.condition.ccodenode);
		
		create_temp_decl (stmt, stmt.condition.temp_vars);
	}

	public override void visit_for_statement (ForStatement! stmt) {
		stmt.accept_children (this);

		CCodeExpression ccondition = null;
		if (stmt.condition != null) {
			ccondition = (CCodeExpression) stmt.condition.ccodenode;
		}

		var cfor = new CCodeForStatement (ccondition, (CCodeStatement) stmt.body.ccodenode);
		stmt.ccodenode = cfor;
		
		foreach (Expression init_expr in stmt.get_initializer ()) {
			cfor.add_initializer ((CCodeExpression) init_expr.ccodenode);
			create_temp_decl (stmt, init_expr.temp_vars);
		}
		
		foreach (Expression it_expr in stmt.get_iterator ()) {
			cfor.add_iterator ((CCodeExpression) it_expr.ccodenode);
			create_temp_decl (stmt, it_expr.temp_vars);
		}

		if (stmt.condition != null) {
			create_temp_decl (stmt, stmt.condition.temp_vars);
		}
	}

	public override void visit_foreach_statement (ForeachStatement! stmt) {
		stmt.variable_declarator.active = true;
		stmt.collection_variable_declarator.active = true;
		if (stmt.iterator_variable_declarator != null) {
			stmt.iterator_variable_declarator.active = true;
		}

		visit_block (stmt);

		var cblock = new CCodeBlock ();
		// sets #line
		stmt.ccodenode = cblock;

		var cfrag = new CCodeFragment ();
		append_temp_decl (cfrag, stmt.collection.temp_vars);
		cblock.add_statement (cfrag);
		
		var collection_backup = stmt.collection_variable_declarator;
		var collection_type = collection_backup.type_reference.copy ();
		collection_type.is_ref = false;
		collection_type.is_out = false;
		var ccoldecl = new CCodeDeclaration (collection_type.get_cname ());
		var ccolvardecl = new CCodeVariableDeclarator.with_initializer (collection_backup.name, (CCodeExpression) stmt.collection.ccodenode);
		ccolvardecl.line = cblock.line;
		ccoldecl.add_declarator (ccolvardecl);
		cblock.add_statement (ccoldecl);
		
		if (stmt.tree_can_fail && stmt.collection.can_fail) {
			// exception handling
			var cfrag = new CCodeFragment ();
			add_simple_check (stmt.collection, cfrag);
			cblock.add_statement (cfrag);
		}

		if (stmt.collection.static_type is ArrayType) {
			var array_type = (ArrayType) stmt.collection.static_type;
			
			var array_len = get_array_length_cexpression (stmt.collection);
			
			/* the array has no length parameter i.e. is NULL-terminated array */
			if (array_len is CCodeConstant) {
				var it_name = "%s_it".printf (stmt.variable_name);
			
				var citdecl = new CCodeDeclaration (collection_type.get_cname ());
				citdecl.add_declarator (new CCodeVariableDeclarator (it_name));
				cblock.add_statement (citdecl);
				
				var cbody = new CCodeBlock ();

				CCodeExpression element_expr = new CCodeIdentifier ("*%s".printf (it_name));

				element_expr = get_implicit_cast_expression (element_expr, array_type.element_type, stmt.type_reference);

				if (stmt.type_reference.takes_ownership) {
					var ma = new MemberAccess.simple (stmt.variable_name);
					ma.static_type = stmt.type_reference;
					ma.ccodenode = element_expr;
					element_expr = get_ref_expression (ma);

					var clendecl = new CCodeDeclaration ("int");
					clendecl.add_declarator (new CCodeVariableDeclarator.with_initializer (get_array_length_cname (collection_backup.name, 1), array_len));
					cblock.add_statement (clendecl);

					var cfrag = new CCodeFragment ();
					append_temp_decl (cfrag, temp_vars);
					cbody.add_statement (cfrag);
					temp_vars.clear ();
				}

				var cdecl = new CCodeDeclaration (stmt.type_reference.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (stmt.variable_name, element_expr));
				cbody.add_statement (cdecl);
				
				cbody.add_statement (stmt.body.ccodenode);
				
				var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("*%s".printf (it_name)), new CCodeConstant ("NULL"));
				
				var cfor = new CCodeForStatement (ccond, cbody);

				cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier (it_name), new CCodeIdentifier (collection_backup.name)));
		
				cfor.add_iterator (new CCodeAssignment (new CCodeIdentifier (it_name), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier (it_name), new CCodeConstant ("1"))));
				cblock.add_statement (cfor);
			/* the array has a length parameter */
			} else {
				var it_name = (stmt.variable_name + "_it");
			
				var citdecl = new CCodeDeclaration ("int");
				citdecl.add_declarator (new CCodeVariableDeclarator (it_name));
				cblock.add_statement (citdecl);
				
				var cbody = new CCodeBlock ();

				CCodeExpression element_expr = new CCodeElementAccess (new CCodeIdentifier (collection_backup.name), new CCodeIdentifier (it_name));

				element_expr = get_implicit_cast_expression (element_expr, array_type.element_type, stmt.type_reference);

				if (stmt.type_reference.takes_ownership) {
					var ma = new MemberAccess.simple (stmt.variable_name);
					ma.static_type = stmt.type_reference;
					ma.ccodenode = element_expr;
					element_expr = get_ref_expression (ma);

					var cfrag = new CCodeFragment ();
					append_temp_decl (cfrag, temp_vars);
					cbody.add_statement (cfrag);
					temp_vars.clear ();
				}

				var cdecl = new CCodeDeclaration (stmt.type_reference.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (stmt.variable_name, element_expr));
				cbody.add_statement (cdecl);

				cbody.add_statement (stmt.body.ccodenode);
				
				var ccond_ind1 = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, array_len, new CCodeConstant ("-1"));
				var ccond_ind2 = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier (it_name), array_len);
				var ccond_ind = new CCodeBinaryExpression (CCodeBinaryOperator.AND, ccond_ind1, ccond_ind2);
				
				/* only check for null if the containers elements are of reference-type */
				CCodeBinaryExpression ccond;
				if (array_type.element_type.data_type.is_reference_type ()) {
					var ccond_term1 = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, array_len, new CCodeConstant ("-1"));
					var ccond_term2 = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeElementAccess (new CCodeIdentifier (collection_backup.name), new CCodeIdentifier (it_name)), new CCodeConstant ("NULL"));
					var ccond_term = new CCodeBinaryExpression (CCodeBinaryOperator.AND, ccond_term1, ccond_term2);

					ccond = new CCodeBinaryExpression (CCodeBinaryOperator.OR, new CCodeParenthesizedExpression (ccond_ind), new CCodeParenthesizedExpression (ccond_term));
				} else {
					/* assert when trying to iterate over value-type arrays of unknown length */
					var cassert = new CCodeFunctionCall (new CCodeIdentifier ("g_assert"));
					cassert.add_argument (ccond_ind1);
					cblock.add_statement (new CCodeExpressionStatement (cassert));

					ccond = ccond_ind2;
				}
				
				var cfor = new CCodeForStatement (ccond, cbody);
				cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier (it_name), new CCodeConstant ("0")));
				cfor.add_iterator (new CCodeAssignment (new CCodeIdentifier (it_name), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier (it_name), new CCodeConstant ("1"))));
				cblock.add_statement (cfor);
			}
		} else if (stmt.collection.static_type.data_type == glist_type ||
		           stmt.collection.static_type.data_type == gslist_type) {
			var it_name = "%s_it".printf (stmt.variable_name);
		
			var citdecl = new CCodeDeclaration (collection_type.get_cname ());
			var citvardecl = new CCodeVariableDeclarator (it_name);
			citvardecl.line = cblock.line;
			citdecl.add_declarator (citvardecl);
			cblock.add_statement (citdecl);
			
			var cbody = new CCodeBlock ();

			CCodeExpression element_expr = new CCodeMemberAccess.pointer (new CCodeIdentifier (it_name), "data");

			if (collection_type.get_type_arguments ().size != 1) {
				Report.error (stmt.source_reference, "internal error: missing generic type argument");
				stmt.error = true;
				return;
			}

			var element_data_type = collection_type.get_type_arguments ().get (0);
			element_expr = get_implicit_cast_expression (element_expr, element_data_type, stmt.type_reference);

			element_expr = convert_from_generic_pointer (element_expr, stmt.type_reference);

			if (stmt.type_reference.takes_ownership) {
				var ma = new MemberAccess.simple (stmt.variable_name);
				ma.static_type = stmt.type_reference;
				ma.ccodenode = element_expr;
				element_expr = get_ref_expression (ma);

				var cfrag = new CCodeFragment ();
				append_temp_decl (cfrag, temp_vars);
				cbody.add_statement (cfrag);
				temp_vars.clear ();
			}

			var cdecl = new CCodeDeclaration (stmt.type_reference.get_cname ());
			var cvardecl = new CCodeVariableDeclarator.with_initializer (stmt.variable_name, element_expr);
			cvardecl.line = cblock.line;
			cdecl.add_declarator (cvardecl);
			cbody.add_statement (cdecl);
			
			cbody.add_statement (stmt.body.ccodenode);
			
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier (it_name), new CCodeConstant ("NULL"));
			
			var cfor = new CCodeForStatement (ccond, cbody);
			
			cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier (it_name), new CCodeIdentifier (collection_backup.name)));

			cfor.add_iterator (new CCodeAssignment (new CCodeIdentifier (it_name), new CCodeMemberAccess.pointer (new CCodeIdentifier (it_name), "next")));
			cblock.add_statement (cfor);
		} else if (stmt.collection.static_type.data_type.is_subtype_of (iterable_type)) {
			var it_name = "%s_it".printf (stmt.variable_name);

			var citdecl = new CCodeDeclaration (iterator_type.get_cname () + "*");
			var it_method = (Method) iterable_type.scope.lookup ("iterator");
			var it_ccall = new CCodeFunctionCall (new CCodeIdentifier (it_method.get_cname ()));
			it_ccall.add_argument (new InstanceCast (new CCodeIdentifier (collection_backup.name), iterable_type));
			var citvardecl = new CCodeVariableDeclarator.with_initializer (it_name, it_ccall);
			citvardecl.line = cblock.line;
			citdecl.add_declarator (citvardecl);
			cblock.add_statement (citdecl);
			
			var cbody = new CCodeBlock ();

			var get_method = (Method) iterator_type.scope.lookup ("get");
			var get_ccall = new CCodeFunctionCall (new CCodeIdentifier (get_method.get_cname ()));
			get_ccall.add_argument (new CCodeIdentifier (it_name));
			CCodeExpression element_expr = get_ccall;

			element_expr = convert_from_generic_pointer (element_expr, stmt.type_reference);

			Iterator<DataType> type_arg_it = it_method.return_type.get_type_arguments ().iterator ();
			type_arg_it.next ();
			var it_type = SemanticAnalyzer.get_actual_type (stmt.collection.static_type, it_method, type_arg_it.get (), stmt);

			element_expr = get_implicit_cast_expression (element_expr, it_type, stmt.type_reference);

			if (stmt.type_reference.takes_ownership && !it_type.takes_ownership) {
				var ma = new MemberAccess.simple (stmt.variable_name);
				ma.static_type = stmt.type_reference;
				ma.ccodenode = element_expr;
				element_expr = get_ref_expression (ma);

				var cfrag = new CCodeFragment ();
				append_temp_decl (cfrag, temp_vars);
				cbody.add_statement (cfrag);
				temp_vars.clear ();
			}

			var cdecl = new CCodeDeclaration (stmt.type_reference.get_cname ());
			var cvardecl = new CCodeVariableDeclarator.with_initializer (stmt.variable_name, element_expr);
			cvardecl.line = cblock.line;
			cdecl.add_declarator (cvardecl);
			cbody.add_statement (cdecl);
			
			cbody.add_statement (stmt.body.ccodenode);

			var next_method = (Method) iterator_type.scope.lookup ("next");
			var next_ccall = new CCodeFunctionCall (new CCodeIdentifier (next_method.get_cname ()));
			next_ccall.add_argument (new CCodeIdentifier (it_name));

			var cwhile = new CCodeWhileStatement (next_ccall, cbody);
			cwhile.line = cblock.line;
			cblock.add_statement (cwhile);
		}

		foreach (VariableDeclarator decl in stmt.get_local_variables ()) {
			if (decl.type_reference.takes_ownership) {
				var ma = new MemberAccess.simple (decl.name);
				ma.symbol_reference = decl;
				var cunref = new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (get_variable_cname (decl.name)), decl.type_reference, ma));
				cunref.line = cblock.line;
				cblock.add_statement (cunref);
			}
		}
	}

	public override void visit_break_statement (BreakStatement! stmt) {
		stmt.ccodenode = new CCodeBreakStatement ();

		create_local_free (stmt, true);
	}

	public override void visit_continue_statement (ContinueStatement! stmt) {
		stmt.ccodenode = new CCodeContinueStatement ();

		create_local_free (stmt, true);
	}

	private void append_local_free (Symbol sym, CCodeFragment cfrag, bool stop_at_loop) {
		var b = (Block) sym;

		var local_vars = b.get_local_variables ();
		foreach (VariableDeclarator decl in local_vars) {
			if (decl.active && decl.type_reference.is_reference_type_or_type_parameter () && decl.type_reference.takes_ownership) {
				var ma = new MemberAccess.simple (decl.name);
				ma.symbol_reference = decl;
				cfrag.append (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (get_variable_cname (decl.name)), decl.type_reference, ma)));
			}
		}
		
		if (stop_at_loop) {
			if (b.parent_node is DoStatement || b.parent_node is WhileStatement ||
			    b.parent_node is ForStatement || b.parent_node is ForeachStatement ||
			    b.parent_node is SwitchStatement) {
				return;
			}
		}

		if (sym.parent_symbol is Block) {
			append_local_free (sym.parent_symbol, cfrag, stop_at_loop);
		} else if (sym.parent_symbol is Method) {
			append_param_free ((Method) sym.parent_symbol, cfrag);
		}
	}

	private void append_param_free (Method m, CCodeFragment cfrag) {
		foreach (FormalParameter param in m.get_parameters ()) {
			if (param.type_reference.data_type != null && param.type_reference.data_type.is_reference_type () && param.type_reference.takes_ownership && !param.type_reference.is_ref && !param.type_reference.is_out) {
				var ma = new MemberAccess.simple (param.name);
				ma.symbol_reference = param;
				cfrag.append (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (get_variable_cname (param.name)), param.type_reference, ma)));
			}
		}
	}

	private void create_local_free (CodeNode stmt, bool stop_at_loop = false) {
		var cfrag = new CCodeFragment ();
	
		append_local_free (current_symbol, cfrag, stop_at_loop);

		cfrag.append (stmt.ccodenode);
		stmt.ccodenode = cfrag;
	}

	private bool append_local_free_expr (Symbol sym, CCodeCommaExpression ccomma, bool stop_at_loop) {
		bool found = false;
	
		var b = (Block) sym;

		var local_vars = b.get_local_variables ();
		foreach (VariableDeclarator decl in local_vars) {
			if (decl.active && decl.type_reference.is_reference_type_or_type_parameter () && decl.type_reference.takes_ownership) {
				found = true;
				var ma = new MemberAccess.simple (decl.name);
				ma.symbol_reference = decl;
				ccomma.append_expression (get_unref_expression (new CCodeIdentifier (get_variable_cname (decl.name)), decl.type_reference, ma));
			}
		}
		
		if (sym.parent_symbol is Block) {
			found = append_local_free_expr (sym.parent_symbol, ccomma, stop_at_loop) || found;
		} else if (sym.parent_symbol is Method) {
			found = append_param_free_expr ((Method) sym.parent_symbol, ccomma) || found;
		}
		
		return found;
	}

	private bool append_param_free_expr (Method m, CCodeCommaExpression ccomma) {
		bool found = false;

		foreach (FormalParameter param in m.get_parameters ()) {
			if (param.type_reference.data_type != null && param.type_reference.data_type.is_reference_type () && param.type_reference.takes_ownership && !param.type_reference.is_ref && !param.type_reference.is_out) {
				found = true;
				var ma = new MemberAccess.simple (param.name);
				ma.symbol_reference = param;
				ccomma.append_expression (get_unref_expression (new CCodeIdentifier (get_variable_cname (param.name)), param.type_reference, ma));
			}
		}

		return found;
	}

	private void create_local_free_expr (Expression expr) {
		var return_expr_decl = get_temp_variable_declarator (expr.static_type, true, expr);
		
		var ccomma = new CCodeCommaExpression ();
		ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (return_expr_decl.name), (CCodeExpression) expr.ccodenode));

		if (!append_local_free_expr (current_symbol, ccomma, false)) {
			/* no local variables need to be freed */
			return;
		}

		ccomma.append_expression (new CCodeIdentifier (return_expr_decl.name));
		
		expr.ccodenode = ccomma;
		expr.temp_vars.add (return_expr_decl);
	}

	public override void visit_return_statement (ReturnStatement! stmt) {
		if (stmt.return_expression != null) {
			// avoid unnecessary ref/unref pair
			if (stmt.return_expression.ref_missing &&
			    stmt.return_expression.symbol_reference is VariableDeclarator) {
				var decl = (VariableDeclarator) stmt.return_expression.symbol_reference;
				if (decl.type_reference.takes_ownership) {
					/* return expression is local variable taking ownership and
					 * current method is transferring ownership */
					
					stmt.return_expression.ref_sink = true;

					// don't ref expression
					stmt.return_expression.ref_missing = false;
				}
			}
		}

		stmt.accept_children (this);

		if (stmt.return_expression == null) {
			stmt.ccodenode = new CCodeReturnStatement ();
			
			create_local_free (stmt);
		} else {
			Symbol return_expression_symbol = null;
		
			// avoid unnecessary ref/unref pair
			if (stmt.return_expression.ref_sink &&
			    stmt.return_expression.symbol_reference is VariableDeclarator) {
				var decl = (VariableDeclarator) stmt.return_expression.symbol_reference;
				if (decl.type_reference.takes_ownership) {
					/* return expression is local variable taking ownership and
					 * current method is transferring ownership */
					
					// don't unref expression
					return_expression_symbol = decl;
					return_expression_symbol.active = false;
				}
			}

			// return array length if appropriate
			if (current_method != null && !current_method.no_array_length && current_return_type is ArrayType) {
				var return_expr_decl = get_temp_variable_declarator (stmt.return_expression.static_type, true, stmt);

				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (return_expr_decl.name), (CCodeExpression) stmt.return_expression.ccodenode));

				var array_type = (ArrayType) current_return_type;

				for (int dim = 1; dim <= array_type.rank; dim++) {
					var len_l = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (get_array_length_cname ("result", dim)));
					var len_r = get_array_length_cexpression (stmt.return_expression, dim);
					ccomma.append_expression (new CCodeAssignment (len_l, len_r));
				}

				ccomma.append_expression (new CCodeIdentifier (return_expr_decl.name));
				
				stmt.return_expression.ccodenode = ccomma;
				stmt.return_expression.temp_vars.add (return_expr_decl);
			}

			create_local_free_expr (stmt.return_expression);
			
			stmt.return_expression.ccodenode = get_implicit_cast_expression ((CCodeExpression) stmt.return_expression.ccodenode, stmt.return_expression.static_type, current_return_type);

			// Property getters of non simple structs shall return the struct value as out parameter,
			// therefore replace any return statement with an assignment statement to the out formal
			// paramenter and insert an empty return statement afterwards.
			if (current_property_accessor != null &&
			    current_property_accessor.readable &&
			    current_property_accessor.prop.type_reference.is_real_struct_type()) {
			    	var cfragment = new CCodeFragment ();
				cfragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("*value"), (CCodeExpression) stmt.return_expression.ccodenode)));
				cfragment.append (new CCodeReturnStatement ());
				stmt.ccodenode = cfragment;
			} else {
				stmt.ccodenode = new CCodeReturnStatement ((CCodeExpression) stmt.return_expression.ccodenode);
			}

			create_temp_decl (stmt, stmt.return_expression.temp_vars);

			if (return_expression_symbol != null) {
				return_expression_symbol.active = true;
			}
		}
	}

	public override void visit_throw_statement (ThrowStatement! stmt) {
		stmt.accept_children (this);

		var cfrag = new CCodeFragment ();

		/* declare temporary objects */
		append_temp_decl (cfrag, temp_vars);

		// method will fail
		current_method_inner_error = true;
		var cassign = new CCodeAssignment (new CCodeIdentifier ("inner_error"), (CCodeExpression) stmt.error_expression.ccodenode);
		cfrag.append (new CCodeExpressionStatement (cassign));

		add_simple_check (stmt, cfrag);

		stmt.ccodenode = cfrag;
	}

	public override void visit_try_statement (TryStatement! stmt) {
		var old_try = current_try;
		var old_try_id = current_try_id;
		current_try = stmt;
		current_try_id = next_try_id++;

		stmt.accept_children (this);

		var cfrag = new CCodeFragment ();
		cfrag.append (stmt.body.ccodenode);

		foreach (CatchClause clause in stmt.get_catch_clauses ()) {
			cfrag.append (new CCodeGotoStatement ("__finally%d".printf (current_try_id)));

			cfrag.append (clause.ccodenode);
		}

		cfrag.append (new CCodeLabel ("__finally%d".printf (current_try_id)));
		if (stmt.finally_body != null) {
			cfrag.append (stmt.finally_body.ccodenode);
		} else {
			// avoid gcc error: label at end of compound statement
			cfrag.append (new CCodeEmptyStatement ());
		}

		stmt.ccodenode = cfrag;

		current_try = old_try;
		current_try_id = old_try_id;
	}

	public override void visit_catch_clause (CatchClause! clause) {
		current_method_inner_error = true;

		clause.accept_children (this);

		var cfrag = new CCodeFragment ();
		cfrag.append (new CCodeLabel ("__catch%d_%s".printf (current_try_id, clause.type_reference.get_lower_case_cname ())));

		var cblock = new CCodeBlock ();

		var cdecl = new CCodeDeclaration ("GError *");
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (clause.variable_name, new CCodeIdentifier ("inner_error")));
		cblock.add_statement (cdecl);
		cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("inner_error"), new CCodeConstant ("NULL"))));

		cblock.add_statement (clause.body.ccodenode);

		cfrag.append (cblock);

		clause.ccodenode = cfrag;
	}

	private string get_symbol_lock_name (Symbol! sym) {
		return "__lock_%s".printf (sym.name);
	}

	public override void visit_lock_statement (LockStatement! stmt) {
		var cn = new CCodeFragment ();
		CCodeExpression l = null;
		CCodeFunctionCall fc;
		var inner_node = ((MemberAccess)stmt.resource).inner;
		
		if (inner_node  == null) {
			l = new CCodeIdentifier ("self");
		} else if (stmt.resource.symbol_reference.parent_symbol != current_type_symbol) {
			 l = new InstanceCast ((CCodeExpression) inner_node.ccodenode, (Typesymbol) stmt.resource.symbol_reference.parent_symbol);
		} else {
			l = (CCodeExpression) inner_node.ccodenode;
		}
		l = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (l, "priv"), get_symbol_lock_name (stmt.resource.symbol_reference));
		
		fc = new CCodeFunctionCall (new CCodeIdentifier (((Method) mutex_type.data_type.scope.lookup ("lock")).get_cname ()));
		fc.add_argument (l);
		cn.append (new CCodeExpressionStatement (fc));
		
		cn.append (stmt.body.ccodenode);
		
		fc = new CCodeFunctionCall (new CCodeIdentifier (((Method) mutex_type.data_type.scope.lookup ("unlock")).get_cname ()));
		fc.add_argument (l);
		cn.append (new CCodeExpressionStatement (fc));
		
		stmt.ccodenode = cn;
	}

	public override void visit_delete_statement (DeleteStatement stmt) {
		stmt.accept_children (this);

		var pointer_type = (PointerType) stmt.expression.static_type;
		DataType type = pointer_type;
		if (pointer_type.base_type.data_type != null && pointer_type.base_type.data_type.is_reference_type ()) {
			type = pointer_type.base_type;
		}

		var ccall = new CCodeFunctionCall (get_destroy_func_expression (type));
		ccall.add_argument ((CCodeExpression) stmt.expression.ccodenode);
		stmt.ccodenode = new CCodeExpressionStatement (ccall);
	}

	public override void visit_array_creation_expression (ArrayCreationExpression! expr) {
		expr.code_binding.emit ();
	}

	public override void visit_boolean_literal (BooleanLiteral! expr) {
		expr.ccodenode = new CCodeConstant (expr.value ? "TRUE" : "FALSE");

		visit_expression (expr);
	}

	public override void visit_character_literal (CharacterLiteral! expr) {
		if (expr.get_char () >= 0x20 && expr.get_char () < 0x80) {
			expr.ccodenode = new CCodeConstant (expr.value);
		} else {
			expr.ccodenode = new CCodeConstant ("%uU".printf (expr.get_char ()));
		}

		visit_expression (expr);
	}

	public override void visit_integer_literal (IntegerLiteral! expr) {
		expr.ccodenode = new CCodeConstant (expr.value);

		visit_expression (expr);
	}

	public override void visit_real_literal (RealLiteral! expr) {
		expr.ccodenode = new CCodeConstant (expr.value);

		visit_expression (expr);
	}

	public override void visit_string_literal (StringLiteral! expr) {
		expr.ccodenode = new CCodeConstant (expr.value);

		visit_expression (expr);
	}

	public override void visit_null_literal (NullLiteral! expr) {
		expr.ccodenode = new CCodeConstant ("NULL");

		visit_expression (expr);
	}

	public override void visit_parenthesized_expression (ParenthesizedExpression! expr) {
		expr.accept_children (this);

		expr.ccodenode = new CCodeParenthesizedExpression ((CCodeExpression) expr.inner.ccodenode);

		visit_expression (expr);
	}
	
	private string! get_array_length_cname (string! array_cname, int dim) {
		return "%s_length%d".printf (array_cname, dim);
	}

	public CCodeExpression! get_array_length_cexpression (Expression! array_expr, int dim = -1) {
		// dim == -1 => total size over all dimensions
		if (dim == -1) {
			var array_type = array_expr.static_type as ArrayType;
			if (array_type != null && array_type.rank > 1) {
				CCodeExpression cexpr = get_array_length_cexpression (array_expr, 1);
				for (dim = 2; dim <= array_type.rank; dim++) {
					cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, cexpr, get_array_length_cexpression (array_expr, dim));
				}
				return cexpr;
			} else {
				dim = 1;
			}
		}

		bool is_out = false;

		if (array_expr is UnaryExpression) {
			var unary_expr = (UnaryExpression) array_expr;
			if (unary_expr.operator == UnaryOperator.OUT || unary_expr.operator == UnaryOperator.REF) {
				array_expr = unary_expr.inner;
				is_out = true;
			}
		} else if (array_expr is ReferenceTransferExpression) {
			var reftransfer_expr = (ReferenceTransferExpression) array_expr;
			array_expr = reftransfer_expr.inner;
		}
		
		if (array_expr is ArrayCreationExpression) {
			Gee.List<Expression> size = ((ArrayCreationExpression) array_expr).get_sizes ();
			var length_expr = size[dim - 1];
			return (CCodeExpression) length_expr.ccodenode;
		} else if (array_expr is InvocationExpression) {
			var invocation_expr = (InvocationExpression) array_expr;
			Gee.List<CCodeExpression> size = invocation_expr.get_array_sizes ();
			return size[dim - 1];
		} else if (array_expr.symbol_reference != null) {
			if (array_expr.symbol_reference is FormalParameter) {
				var param = (FormalParameter) array_expr.symbol_reference;
				if (!param.no_array_length) {
					CCodeExpression length_expr = new CCodeIdentifier (get_array_length_cname (param.name, dim));
					if (param.type_reference.is_out || param.type_reference.is_ref) {
						// accessing argument of out/ref param
						length_expr = new CCodeParenthesizedExpression (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, length_expr));
					}
					if (is_out) {
						// passing array as out/ref
						return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, length_expr);
					} else {
						return length_expr;
					}
				}
			} else if (array_expr.symbol_reference is VariableDeclarator) {
				var decl = (VariableDeclarator) array_expr.symbol_reference;
				var length_expr = new CCodeIdentifier (get_array_length_cname (decl.name, dim));
				if (is_out) {
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, length_expr);
				} else {
					return length_expr;
				}
			} else if (array_expr.symbol_reference is Field) {
				var field = (Field) array_expr.symbol_reference;
				if (!field.no_array_length) {
					var ma = (MemberAccess) array_expr;

					CCodeExpression pub_inst = null;
					Typesymbol base_type = null;
					CCodeExpression length_expr = null;
				
					if (ma.inner == null) {
						pub_inst = new CCodeIdentifier ("self");

						if (current_type_symbol != null) {
							/* base type is available if this is a type method */
							base_type = (Typesymbol) current_type_symbol;
						}
					} else {
						pub_inst = (CCodeExpression) ma.inner.ccodenode;

						if (ma.inner.static_type != null) {
							base_type = ma.inner.static_type.data_type;
						}
					}

					if (field.instance) {
						var length_cname = get_array_length_cname (field.name, dim);
						var instance_expression_type = get_data_type_for_symbol (base_type);
						var instance_target_type = get_data_type_for_symbol ((Typesymbol) field.parent_symbol);
						CCodeExpression typed_inst = get_implicit_cast_expression (pub_inst, instance_expression_type, instance_target_type);

						CCodeExpression inst;
						if (field.access == SymbolAccessibility.PRIVATE) {
							inst = new CCodeMemberAccess.pointer (typed_inst, "priv");
						} else {
							inst = typed_inst;
						}
						if (((Typesymbol) field.parent_symbol).is_reference_type ()) {
							length_expr = new CCodeMemberAccess.pointer (inst, length_cname);
						} else {
							length_expr = new CCodeMemberAccess (inst, length_cname);
						}
					} else {
						length_expr = new CCodeIdentifier (get_array_length_cname (field.get_cname (), dim));
					}

					if (is_out) {
						return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, length_expr);
					} else {
						return length_expr;
					}
				}
			} else if (array_expr.symbol_reference is Constant) {
				var constant = (Constant) array_expr.symbol_reference;
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_N_ELEMENTS"));
				ccall.add_argument (new CCodeIdentifier (constant.get_cname ()));
				return ccall;
			}
		} else if (array_expr is NullLiteral) {
			return new CCodeConstant ("0");
		}

		if (!is_out) {
			/* allow arrays with unknown length even for value types
			 * as else it may be impossible to bind some libraries
			 * users of affected libraries should explicitly set
			 * the array length as early as possible
			 * by setting the virtual length field of the array
			 */
			return new CCodeConstant ("-1");
		} else {
			return new CCodeConstant ("NULL");
		}
	}
	
	private string! get_delegate_target_cname (string! delegate_cname) {
		return "%s_target".printf (delegate_cname);
	}

	public CCodeExpression! get_delegate_target_cexpression (Expression! delegate_expr) {
		bool is_out = false;
	
		if (delegate_expr is UnaryExpression) {
			var unary_expr = (UnaryExpression) delegate_expr;
			if (unary_expr.operator == UnaryOperator.OUT || unary_expr.operator == UnaryOperator.REF) {
				delegate_expr = unary_expr.inner;
				is_out = true;
			}
		}
		
		if (delegate_expr is InvocationExpression) {
			var invocation_expr = (InvocationExpression) delegate_expr;
			return invocation_expr.delegate_target;
		} else if (delegate_expr is LambdaExpression) {
			if ((current_method != null && current_method.instance) || in_constructor) {
				return new CCodeIdentifier ("self");
			} else {
				return new CCodeConstant ("NULL");
			}
		} else if (delegate_expr.symbol_reference != null) {
			if (delegate_expr.symbol_reference is FormalParameter) {
				var param = (FormalParameter) delegate_expr.symbol_reference;
				CCodeExpression target_expr = new CCodeIdentifier (get_delegate_target_cname (param.name));
				if (param.type_reference.is_out || param.type_reference.is_ref) {
					// accessing argument of out/ref param
					target_expr = new CCodeParenthesizedExpression (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, target_expr));
				}
				if (is_out) {
					// passing array as out/ref
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, target_expr);
				} else {
					return target_expr;
				}
			} else if (delegate_expr.symbol_reference is VariableDeclarator) {
				var decl = (VariableDeclarator) delegate_expr.symbol_reference;
				var target_expr = new CCodeIdentifier (get_delegate_target_cname (decl.name));
				if (is_out) {
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, target_expr);
				} else {
					return target_expr;
				}
			} else if (delegate_expr.symbol_reference is Field) {
				var field = (Field) delegate_expr.symbol_reference;
				var target_cname = get_delegate_target_cname (field.name);

				var ma = (MemberAccess) delegate_expr;

				CCodeExpression pub_inst = null;
				Typesymbol base_type = null;
				CCodeExpression target_expr = null;
			
				if (ma.inner == null) {
					pub_inst = new CCodeIdentifier ("self");

					if (current_type_symbol != null) {
						/* base type is available if this is a type method */
						base_type = (Typesymbol) current_type_symbol;
					}
				} else {
					pub_inst = (CCodeExpression) ma.inner.ccodenode;

					if (ma.inner.static_type != null) {
						base_type = ma.inner.static_type.data_type;
					}
				}

				if (field.instance) {
					var instance_expression_type = get_data_type_for_symbol (base_type);
					var instance_target_type = get_data_type_for_symbol ((Typesymbol) field.parent_symbol);
					CCodeExpression typed_inst = get_implicit_cast_expression (pub_inst, instance_expression_type, instance_target_type);

					CCodeExpression inst;
					if (field.access == SymbolAccessibility.PRIVATE) {
						inst = new CCodeMemberAccess.pointer (typed_inst, "priv");
					} else {
						inst = typed_inst;
					}
					if (((Typesymbol) field.parent_symbol).is_reference_type ()) {
						target_expr = new CCodeMemberAccess.pointer (inst, target_cname);
					} else {
						target_expr = new CCodeMemberAccess (inst, target_cname);
					}
				} else {
					target_expr = new CCodeIdentifier (target_cname);
				}

				if (is_out) {
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, target_expr);
				} else {
					return target_expr;
				}
			} else if (delegate_expr.symbol_reference is Method) {
				var ma = (MemberAccess) delegate_expr;
				if (ma.inner == null) {
					if ((current_method != null && current_method.instance) || in_constructor) {
						return new CCodeIdentifier ("self");
					} else {
						return new CCodeConstant ("NULL");
					}
				} else {
					return (CCodeExpression) ma.inner.ccodenode;
				}
			}
		}

		return new CCodeConstant ("NULL");
	}

	public override void visit_element_access (ElementAccess! expr) {
		expr.code_binding.emit ();
	}

	public override void visit_base_access (BaseAccess! expr) {
		expr.ccodenode = new InstanceCast (new CCodeIdentifier ("self"), expr.static_type.data_type);
	}

	public override void visit_postfix_expression (PostfixExpression! expr) {
		MemberAccess ma = find_property_access (expr.inner);
		if (ma != null) {
			// property postfix expression
			var prop = (Property) ma.symbol_reference;
			
			var ccomma = new CCodeCommaExpression ();
			
			// assign current value to temp variable
			var temp_decl = get_temp_variable_declarator (prop.type_reference, true, expr);
			temp_vars.insert (0, temp_decl);
			ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_decl.name), (CCodeExpression) expr.inner.ccodenode));
			
			// increment/decrement property
			var op = expr.increment ? CCodeBinaryOperator.PLUS : CCodeBinaryOperator.MINUS;
			var cexpr = new CCodeBinaryExpression (op, new CCodeIdentifier (temp_decl.name), new CCodeConstant ("1"));
			var ccall = get_property_set_call (prop, ma, cexpr);
			ccomma.append_expression (ccall);
			
			// return previous value
			ccomma.append_expression (new CCodeIdentifier (temp_decl.name));
			
			expr.ccodenode = ccomma;
			return;
		}
	
		var op = expr.increment ? CCodeUnaryOperator.POSTFIX_INCREMENT : CCodeUnaryOperator.POSTFIX_DECREMENT;
	
		expr.ccodenode = new CCodeUnaryExpression (op, (CCodeExpression) expr.inner.ccodenode);
		
		visit_expression (expr);
	}
	
	private MemberAccess find_property_access (Expression! expr) {
		if (expr is ParenthesizedExpression) {
			var pe = (ParenthesizedExpression) expr;
			return find_property_access (pe.inner);
		}
	
		if (!(expr is MemberAccess)) {
			return null;
		}
		
		var ma = (MemberAccess) expr;
		if (ma.symbol_reference is Property) {
			return ma;
		}
		
		return null;
	}
	
	private CCodeExpression get_ref_expression (Expression! expr) {
		/* (temp = expr, temp == NULL ? NULL : ref (temp))
		 *
		 * can be simplified to
		 * ref (expr)
		 * if static type of expr is non-null
		 */
		 
		var dupexpr = get_dup_func_expression (expr.static_type);

		if (null == dupexpr) {
			return null;
		}

		var ccall = new CCodeFunctionCall (dupexpr);

		if (((context.non_null && !expr.static_type.requires_null_check) && expr.static_type.type_parameter == null) || expr is StringLiteral) {
			// expression is non-null
			ccall.add_argument ((CCodeExpression) expr.ccodenode);
			
			return ccall;
		} else {
			var decl = get_temp_variable_declarator (expr.static_type, false, expr);
			temp_vars.insert (0, decl);

			var ctemp = new CCodeIdentifier (decl.name);
			
			var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ctemp, new CCodeConstant ("NULL"));
			if (expr.static_type.data_type == null) {
				if (!(current_type_symbol is Class)) {
					return (CCodeExpression) expr.ccodenode;
				}

				// dup functions are optional for type parameters
				var cdupisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, get_dup_func_expression (expr.static_type), new CCodeConstant ("NULL"));
				cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cisnull, cdupisnull);
			}

			if (expr.static_type.data_type != null) {
				ccall.add_argument (ctemp);
			} else {
				// cast from gconstpointer to gpointer as GBoxedCopyFunc expects gpointer
				ccall.add_argument (new CCodeCastExpression (ctemp, "gpointer"));
			}

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (ctemp, (CCodeExpression) expr.ccodenode));

			if (expr.static_type.data_type == glist_type) {
				bool is_ref = false;
				bool is_class = false;
				bool is_interface = false;

				foreach (DataType type_arg in expr.static_type.get_type_arguments ()) {
					is_ref |= type_arg.takes_ownership;
					is_class |= type_arg.data_type is Class;
					is_interface |= type_arg.data_type is Interface;
				}
			
				if (is_ref && (is_class || is_interface)) {
					var crefcall = new CCodeFunctionCall (new CCodeIdentifier ("g_list_foreach"));

					crefcall.add_argument (ctemp);
					crefcall.add_argument (new CCodeIdentifier ("(GFunc) g_object_ref"));
					crefcall.add_argument (new CCodeConstant ("NULL"));

					ccomma.append_expression (crefcall);
				}
			}

			CCodeExpression cifnull;
			if (expr.static_type.data_type != null) {
				cifnull = new CCodeConstant ("NULL");
			} else {
				// the value might be non-null even when the dup function is null,
				// so we may not just use NULL for type parameters

				// cast from gconstpointer to gpointer as methods in
				// generic classes may not return gconstpointer
				cifnull = new CCodeCastExpression (ctemp, "gpointer");
			}
			ccomma.append_expression (new CCodeConditionalExpression (cisnull, cifnull, ccall));

			return ccomma;
		}
	}
	
	public void visit_expression (Expression! expr) {
		if (expr.static_type != null &&
		    expr.static_type.transfers_ownership &&
		    expr.static_type.floating_reference) {
			/* constructor of GInitiallyUnowned subtype
			 * returns floating reference, sink it
			 */
			var csink = new CCodeFunctionCall (new CCodeIdentifier ("g_object_ref_sink"));
			csink.add_argument ((CCodeExpression) expr.ccodenode);
			
			expr.ccodenode = csink;
		}
	
		if (expr.ref_leaked) {
			var decl = get_temp_variable_declarator (expr.static_type, true, expr);
			temp_vars.insert (0, decl);
			temp_ref_vars.insert (0, decl);
			expr.ccodenode = new CCodeParenthesizedExpression (new CCodeAssignment (new CCodeIdentifier (get_variable_cname (decl.name)), (CCodeExpression) expr.ccodenode));
		} else if (expr.ref_missing) {
			expr.ccodenode = get_ref_expression (expr);
		}
	}

	public override void visit_object_creation_expression (ObjectCreationExpression! expr) {
		expr.accept_children (this);

		CCodeExpression instance = null;
		CCodeFunctionCall creation_call = null;

		if (expr.type_reference.data_type is Struct || expr.get_object_initializer ().size > 0) {
			// value-type initialization or object creation expression with object initializer
			var temp_decl = get_temp_variable_declarator (expr.type_reference, false, expr);
			temp_vars.add (temp_decl);

			instance = new CCodeIdentifier (get_variable_cname (temp_decl.name));
		}

		if (expr.symbol_reference == null) {
			// no creation method
			if (expr.type_reference.data_type == glist_type ||
			    expr.type_reference.data_type == gslist_type) {
				// NULL is an empty list
				expr.ccodenode = new CCodeConstant ("NULL");
			} else if (expr.type_reference.data_type is Class && expr.type_reference.data_type.is_subtype_of (gobject_type)) {
				creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_new"));
				creation_call.add_argument (new CCodeConstant (expr.type_reference.data_type.get_type_id ()));
				creation_call.add_argument (new CCodeConstant ("NULL"));
			} else if (expr.type_reference.data_type is Class) {
				creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
				creation_call.add_argument (new CCodeConstant (expr.type_reference.data_type.get_cname ()));
				creation_call.add_argument (new CCodeConstant ("1"));
			} else if (expr.type_reference.data_type is Struct) {
				// memset needs string.h
				string_h_needed = true;
				creation_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
				creation_call.add_argument (new CCodeConstant ("0"));
				creation_call.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (expr.type_reference.get_cname ())));
			}
		} else if (expr.symbol_reference is Method) {
			// use creation method
			var m = (Method) expr.symbol_reference;
			var params = m.get_parameters ();

			creation_call = new CCodeFunctionCall (new CCodeIdentifier (m.get_cname ()));

			if (expr.type_reference.data_type is Struct) {
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
			} else if (expr.type_reference.data_type is Class) {
				var cl = (Class) expr.type_reference.data_type;
				if (cl.base_class == gtypeinstance_type) {
					creation_call.add_argument (new CCodeIdentifier (cl.get_type_id ()));
				}
			}

			if (expr.type_reference.data_type is Class && expr.type_reference.data_type.is_subtype_of (gobject_type)) {
				foreach (DataType type_arg in expr.type_reference.get_type_arguments ()) {
					creation_call.add_argument (get_type_id_expression (type_arg));
					if (type_arg.takes_ownership) {
						var dup_func = get_dup_func_expression (type_arg);
						if (dup_func == null) {
							// type doesn't contain a copy function
							expr.error = true;
							return;
						}
						creation_call.add_argument (new CCodeCastExpression (dup_func, "GBoxedCopyFunc"));
						creation_call.add_argument (get_destroy_func_expression (type_arg));
					} else {
						creation_call.add_argument (new CCodeConstant ("NULL"));
						creation_call.add_argument (new CCodeConstant ("NULL"));
					}
				}
			}

			bool ellipsis = false;

			int i = 1;
			Iterator<FormalParameter> params_it = params.iterator ();
			foreach (Expression arg in expr.get_argument_list ()) {
				CCodeExpression cexpr = (CCodeExpression) arg.ccodenode;
				FormalParameter param = null;
				if (params_it.next ()) {
					param = params_it.get ();
					ellipsis = param.ellipsis;
					if (!param.ellipsis) {
						cexpr = get_implicit_cast_expression (cexpr, arg.static_type, param.type_reference);

						// pass non-simple struct instances always by reference
						if (param.type_reference.data_type is Struct && !((Struct) param.type_reference.data_type).is_simple_type ()) {
							// we already use a reference for arguments of ref and out parameters
							if (!param.type_reference.is_ref && !param.type_reference.is_out) {
								cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr);
							}
						}
					}
				}
			
				creation_call.add_argument (cexpr);

				if (param != null && param.type_reference is DelegateType) {
					var deleg_type = (DelegateType) param.type_reference;
					var d = deleg_type.delegate_symbol;
					if (d.instance) {
						creation_call.add_argument (get_delegate_target_cexpression (arg));
					}
				}

				i++;
			}
			while (params_it.next ()) {
				var param = params_it.get ();
				
				if (param.ellipsis) {
					ellipsis = true;
					break;
				}
				
				if (param.default_expression == null) {
					Report.error (expr.source_reference, "no default expression for argument %d".printf (i));
					return;
				}
				
				/* evaluate default expression here as the code
				 * generator might not have visited the formal
				 * parameter yet */
				param.default_expression.accept (this);
			
				creation_call.add_argument ((CCodeExpression) param.default_expression.ccodenode);
				i++;
			}

			if (expr.can_fail) {
				// method can fail
				current_method_inner_error = true;
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("inner_error")));
			}

			if (ellipsis) {
				// ensure variable argument list ends with NULL
				creation_call.add_argument (new CCodeConstant ("NULL"));
			}
		} else if (expr.symbol_reference is ErrorCode) {
			var ecode = (ErrorCode) expr.symbol_reference;
			var edomain = (ErrorDomain) ecode.parent_symbol;

			creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_error_new"));
			creation_call.add_argument (new CCodeIdentifier (edomain.get_upper_case_cname ()));
			creation_call.add_argument (new CCodeIdentifier (ecode.get_cname ()));

			foreach (Expression arg in expr.get_argument_list ()) {
				creation_call.add_argument ((CCodeExpression) arg.ccodenode);
			}
		} else {
			assert (false);
		}
			
		if (instance != null) {
			var ccomma = new CCodeCommaExpression ();

			if (expr.type_reference.data_type is Struct) {
				ccomma.append_expression (creation_call);
			} else {
				ccomma.append_expression (new CCodeAssignment (instance, creation_call));
			}

			foreach (MemberInitializer init in expr.get_object_initializer ()) {
				if (init.symbol_reference is Field) {
					var f = (Field) init.symbol_reference;
					var instance_target_type = get_data_type_for_symbol ((Typesymbol) f.parent_symbol);
					var typed_inst = get_implicit_cast_expression (instance, expr.type_reference, instance_target_type);
					CCodeExpression lhs;
					if (expr.type_reference.data_type is Struct) {
						lhs = new CCodeMemberAccess (typed_inst, f.get_cname ());
					} else {
						lhs = new CCodeMemberAccess.pointer (typed_inst, f.get_cname ());
					}
					ccomma.append_expression (new CCodeAssignment (lhs, (CCodeExpression) init.initializer.ccodenode));
				} else if (init.symbol_reference is Property) {
					var inst_ma = new MemberAccess.simple ("new");
					inst_ma.static_type = expr.type_reference;
					inst_ma.ccodenode = instance;
					var ma = new MemberAccess (inst_ma, init.name);
					ccomma.append_expression (get_property_set_call ((Property) init.symbol_reference, ma, (CCodeExpression) init.initializer.ccodenode));
				}
			}

			ccomma.append_expression (instance);

			expr.ccodenode = ccomma;
		} else if (creation_call != null) {
			expr.ccodenode = creation_call;
		}

		visit_expression (expr);
	}

	public override void visit_sizeof_expression (SizeofExpression! expr) {
		var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
		csizeof.add_argument (new CCodeIdentifier (expr.type_reference.data_type.get_cname ()));
		expr.ccodenode = csizeof;
	}

	public override void visit_typeof_expression (TypeofExpression! expr) {
		expr.ccodenode = get_type_id_expression (expr.type_reference);
	}

	public override void visit_unary_expression (UnaryExpression! expr) {
		CCodeUnaryOperator op;
		if (expr.operator == UnaryOperator.PLUS) {
			op = CCodeUnaryOperator.PLUS;
		} else if (expr.operator == UnaryOperator.MINUS) {
			op = CCodeUnaryOperator.MINUS;
		} else if (expr.operator == UnaryOperator.LOGICAL_NEGATION) {
			op = CCodeUnaryOperator.LOGICAL_NEGATION;
		} else if (expr.operator == UnaryOperator.BITWISE_COMPLEMENT) {
			op = CCodeUnaryOperator.BITWISE_COMPLEMENT;
		} else if (expr.operator == UnaryOperator.INCREMENT) {
			op = CCodeUnaryOperator.PREFIX_INCREMENT;
		} else if (expr.operator == UnaryOperator.DECREMENT) {
			op = CCodeUnaryOperator.PREFIX_DECREMENT;
		} else if (expr.operator == UnaryOperator.REF) {
			op = CCodeUnaryOperator.ADDRESS_OF;
		} else if (expr.operator == UnaryOperator.OUT) {
			op = CCodeUnaryOperator.ADDRESS_OF;
		}
		expr.ccodenode = new CCodeUnaryExpression (op, (CCodeExpression) expr.inner.ccodenode);

		visit_expression (expr);
	}

	public override void visit_cast_expression (CastExpression! expr) {
		if (expr.type_reference.data_type != null && expr.type_reference.data_type.is_subtype_of (gtypeinstance_type)) {
			// GObject cast
			if (expr.is_silent_cast) {
				var ccomma = new CCodeCommaExpression ();
				var temp_decl = get_temp_variable_declarator (expr.inner.static_type, true, expr);

				temp_vars.add (temp_decl);

				var ctemp = new CCodeIdentifier (temp_decl.name);
				var cinit = new CCodeAssignment (ctemp, (CCodeExpression) expr.inner.ccodenode);
				var ccheck = create_type_check (ctemp, expr.type_reference.data_type);
				var ccast = new CCodeCastExpression (ctemp, expr.type_reference.get_cname ());
				var cnull = new CCodeConstant ("NULL");

				ccomma.append_expression (cinit);
				ccomma.append_expression (new CCodeConditionalExpression (ccheck, ccast, cnull));
	
				expr.ccodenode = ccomma;
			} else {
				expr.ccodenode = new InstanceCast ((CCodeExpression) expr.inner.ccodenode, expr.type_reference.data_type);
			}
		} else {
			if (expr.is_silent_cast) {
				expr.error = true;
				Report.error (expr.source_reference, "Operation not supported for this type");
				return;
			}
			expr.ccodenode = new CCodeCastExpression ((CCodeExpression) expr.inner.ccodenode, expr.type_reference.get_cname ());
		}

		visit_expression (expr);
	}
	
	public override void visit_pointer_indirection (PointerIndirection! expr) {
		expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, (CCodeExpression) expr.inner.ccodenode);
	}

	public override void visit_addressof_expression (AddressofExpression! expr) {
		expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, (CCodeExpression) expr.inner.ccodenode);
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression! expr) {
		/* (tmp = var, var = null, tmp) */
		var ccomma = new CCodeCommaExpression ();
		var temp_decl = get_temp_variable_declarator (expr.static_type, true, expr);
		temp_vars.insert (0, temp_decl);
		var cvar = new CCodeIdentifier (temp_decl.name);

		ccomma.append_expression (new CCodeAssignment (cvar, (CCodeExpression) expr.inner.ccodenode));
		ccomma.append_expression (new CCodeAssignment ((CCodeExpression) expr.inner.ccodenode, new CCodeConstant ("NULL")));
		ccomma.append_expression (cvar);
		expr.ccodenode = ccomma;

		visit_expression (expr);
	}

	public override void visit_binary_expression (BinaryExpression! expr) {
		var cleft = (CCodeExpression) expr.left.ccodenode;
		var cright = (CCodeExpression) expr.right.ccodenode;
		
		CCodeBinaryOperator op;
		if (expr.operator == BinaryOperator.PLUS) {
			op = CCodeBinaryOperator.PLUS;
		} else if (expr.operator == BinaryOperator.MINUS) {
			op = CCodeBinaryOperator.MINUS;
		} else if (expr.operator == BinaryOperator.MUL) {
			op = CCodeBinaryOperator.MUL;
		} else if (expr.operator == BinaryOperator.DIV) {
			op = CCodeBinaryOperator.DIV;
		} else if (expr.operator == BinaryOperator.MOD) {
			op = CCodeBinaryOperator.MOD;
		} else if (expr.operator == BinaryOperator.SHIFT_LEFT) {
			op = CCodeBinaryOperator.SHIFT_LEFT;
		} else if (expr.operator == BinaryOperator.SHIFT_RIGHT) {
			op = CCodeBinaryOperator.SHIFT_RIGHT;
		} else if (expr.operator == BinaryOperator.LESS_THAN) {
			op = CCodeBinaryOperator.LESS_THAN;
		} else if (expr.operator == BinaryOperator.GREATER_THAN) {
			op = CCodeBinaryOperator.GREATER_THAN;
		} else if (expr.operator == BinaryOperator.LESS_THAN_OR_EQUAL) {
			op = CCodeBinaryOperator.LESS_THAN_OR_EQUAL;
		} else if (expr.operator == BinaryOperator.GREATER_THAN_OR_EQUAL) {
			op = CCodeBinaryOperator.GREATER_THAN_OR_EQUAL;
		} else if (expr.operator == BinaryOperator.EQUALITY) {
			op = CCodeBinaryOperator.EQUALITY;
		} else if (expr.operator == BinaryOperator.INEQUALITY) {
			op = CCodeBinaryOperator.INEQUALITY;
		} else if (expr.operator == BinaryOperator.BITWISE_AND) {
			op = CCodeBinaryOperator.BITWISE_AND;
		} else if (expr.operator == BinaryOperator.BITWISE_OR) {
			op = CCodeBinaryOperator.BITWISE_OR;
		} else if (expr.operator == BinaryOperator.BITWISE_XOR) {
			op = CCodeBinaryOperator.BITWISE_XOR;
		} else if (expr.operator == BinaryOperator.AND) {
			op = CCodeBinaryOperator.AND;
		} else if (expr.operator == BinaryOperator.OR) {
			op = CCodeBinaryOperator.OR;
		} else if (expr.operator == BinaryOperator.IN) {
			expr.ccodenode = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeParenthesizedExpression (new CCodeBinaryExpression (CCodeBinaryOperator.BITWISE_AND, new CCodeParenthesizedExpression (cright), new CCodeParenthesizedExpression (cleft))), new CCodeParenthesizedExpression (cleft));

			visit_expression (expr);
			return;
		}
		
		if (expr.operator == BinaryOperator.EQUALITY ||
		    expr.operator == BinaryOperator.INEQUALITY) {
			var left_type_as_struct = expr.left.static_type.data_type as Struct;
			var right_type_as_struct = expr.right.static_type.data_type as Struct;

			if (expr.left.static_type.data_type is Class && ((Class) expr.left.static_type.data_type).is_subtype_of (gobject_type) &&
			    expr.right.static_type.data_type is Class && ((Class) expr.right.static_type.data_type).is_subtype_of (gobject_type)) {
				var left_cl = (Class) expr.left.static_type.data_type;
				var right_cl = (Class) expr.right.static_type.data_type;
				
				if (left_cl != right_cl) {
					if (left_cl.is_subtype_of (right_cl)) {
						cleft = new InstanceCast (cleft, right_cl);
					} else if (right_cl.is_subtype_of (left_cl)) {
						cright = new InstanceCast (cright, left_cl);
					}
				}
			} else if (left_type_as_struct != null && expr.right.static_type is NullType) {
				cleft = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cleft);
			} else if (right_type_as_struct != null && expr.left.static_type is NullType) {
				cright = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cright);
			}
		}

		if (!(expr.left.static_type is NullType)
		    && expr.left.static_type.compatible (string_type)
		    && !(expr.right.static_type is NullType)
		    && expr.right.static_type.compatible (string_type)
		    && (expr.operator == BinaryOperator.EQUALITY
		        || expr.operator == BinaryOperator.INEQUALITY
		        || expr.operator == BinaryOperator.LESS_THAN
		        || expr.operator == BinaryOperator.GREATER_THAN
		        || expr.operator == BinaryOperator.LESS_THAN_OR_EQUAL
		        || expr.operator == BinaryOperator.GREATER_THAN_OR_EQUAL)) {
			requires_strcmp0 = true;
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("_vala_strcmp0"));
			ccall.add_argument (cleft);
			ccall.add_argument (cright);
			cleft = ccall;
			cright = new CCodeConstant ("0");
		}

		expr.ccodenode = new CCodeBinaryExpression (op, cleft, cright);
		
		visit_expression (expr);
	}

	static CCodeFunctionCall create_type_check (CCodeNode! ccodenode, Typesymbol! type) {
		var ccheck = new CCodeFunctionCall (new CCodeIdentifier (type.get_upper_case_cname ("IS_")));
		ccheck.add_argument ((CCodeExpression) ccodenode);
		return ccheck;
	}

	public override void visit_type_check (TypeCheck! expr) {
		expr.ccodenode = create_type_check (expr.expression.ccodenode, expr.type_reference.data_type);
	}

	public override void visit_conditional_expression (ConditionalExpression! expr) {
		expr.ccodenode = new CCodeConditionalExpression ((CCodeExpression) expr.condition.ccodenode, (CCodeExpression) expr.true_expression.ccodenode, (CCodeExpression) expr.false_expression.ccodenode);

		visit_expression (expr);
	}

	public override void visit_lambda_expression (LambdaExpression! l) {
		var old_temp_vars = temp_vars;
		var old_temp_ref_vars = temp_ref_vars;
		temp_vars = new ArrayList<VariableDeclarator> ();
		temp_ref_vars = new ArrayList<VariableDeclarator> ();

		l.accept_children (this);

		temp_vars = old_temp_vars;
		temp_ref_vars = old_temp_ref_vars;

		l.ccodenode = new CCodeIdentifier (l.method.get_cname ());
	}

	public CCodeExpression! convert_from_generic_pointer (CCodeExpression! cexpr, DataType! actual_type) {
		var result = cexpr;
		if (actual_type.data_type is Struct) {
			var st = (Struct) actual_type.data_type;
			if (st == uint_type.data_type) {
				var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GPOINTER_TO_UINT"));
				cconv.add_argument (cexpr);
				result = cconv;
			} else if (st == bool_type.data_type || st.is_integer_type ()) {
				var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GPOINTER_TO_INT"));
				cconv.add_argument (cexpr);
				result = cconv;
			}
		} else if (actual_type.data_type != null && actual_type.data_type.is_reference_type ()) {
			result = new CCodeCastExpression (cexpr, actual_type.get_cname ());
		}
		return result;
	}

	public CCodeExpression! convert_to_generic_pointer (CCodeExpression! cexpr, DataType! actual_type) {
		var result = cexpr;
		if (actual_type.data_type is Struct) {
			var st = (Struct) actual_type.data_type;
			if (st == uint_type.data_type) {
				var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GUINT_TO_POINTER"));
				cconv.add_argument (cexpr);
				result = cconv;
			} else if (st == bool_type.data_type || st.is_integer_type ()) {
				var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GINT_TO_POINTER"));
				cconv.add_argument (cexpr);
				result = cconv;
			}
		}
		return result;
	}

	public CCodeExpression! get_implicit_cast_expression (CCodeExpression! cexpr, DataType expression_type, DataType! target_type) {
		if (null == expression_type) {
			return cexpr;
		}

		if (expression_type.data_type != null && expression_type.data_type == target_type.data_type) {
			// same type, no cast required
			return cexpr;
		}

		if (expression_type.type_parameter != null) {
			return convert_from_generic_pointer (cexpr, target_type);
		} else if (target_type.type_parameter != null) {
			return convert_to_generic_pointer (cexpr, expression_type);
		}

		if (expression_type is NullType) {
			// null literal, no cast required when not converting to generic type pointer
			return cexpr;
		}

		if (context.checking && target_type.data_type != null && target_type.data_type.is_subtype_of (gtypeinstance_type)) {
			return new InstanceCast (cexpr, target_type.data_type);
		} else if (target_type.data_type != null && expression_type.get_cname () != target_type.get_cname ()) {
			var st = target_type.data_type as Struct;
			if (target_type.data_type.is_reference_type () || (st != null && st.is_simple_type ())) {
				// don't cast non-simple structs
				return new CCodeCastExpression (cexpr, target_type.get_cname ());
			} else {
				return cexpr;
			}
		} else if (target_type is DelegateType && expression_type is MethodType) {
			var dt = (DelegateType) target_type;
			var mt = (MethodType) expression_type;

			var method = mt.method_symbol;
			if (method.base_interface_method != null) {
				method = method.base_interface_method;
			} else if (method.base_method != null) {
				method = method.base_method;
			}

			return new CCodeIdentifier (generate_delegate_wrapper (method, dt.delegate_symbol));
		} else {
			return cexpr;
		}
	}

	private string generate_delegate_wrapper (Method m, Delegate d) {
		string wrapper_name = "_%s_%s".printf (m.get_cname (), Symbol.camel_case_to_lower_case (d.get_cname ()));

		if (!add_wrapper (wrapper_name)) {
			// wrapper already defined
			return wrapper_name;
		}

		// declaration

		var function = new CCodeFunction (wrapper_name, m.return_type.get_cname ());
		function.modifiers = CCodeModifiers.STATIC;
		m.ccodenode = function;

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		if (d.instance) {
			var cparam = new CCodeFormalParameter ("self", "gpointer");
			cparam_map.set (get_param_pos (d.cinstance_parameter_position), cparam);
		}

		var d_params = d.get_parameters ();
		foreach (FormalParameter param in d_params) {
			// ensure that C code node has been generated
			param.accept (this);

			cparam_map.set (get_param_pos (param.cparameter_position), (CCodeFormalParameter) param.ccodenode);

			// handle array parameters
			if (!param.no_array_length && param.type_reference is ArrayType) {
				var array_type = (ArrayType) param.type_reference;
				
				var length_ctype = "int";
				if (param.type_reference.is_out || param.type_reference.is_ref) {
					length_ctype = "int*";
				}
				
				for (int dim = 1; dim <= array_type.rank; dim++) {
					var cparam = new CCodeFormalParameter (get_array_length_cname (param.name, dim), length_ctype);
					cparam_map.set (get_param_pos (param.carray_length_parameter_position + 0.01 * dim), cparam);
				}
			}

		}

		if (m.get_error_domains ().size > 0) {
			var cparam = new CCodeFormalParameter ("error", "GError**");
			cparam_map.set (get_param_pos (-1), cparam);
		}

		// append C parameters in the right order
		int last_pos = -1;
		int min_pos;
		while (true) {
			min_pos = -1;
			foreach (int pos in cparam_map.get_keys ()) {
				if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
					min_pos = pos;
				}
			}
			if (min_pos == -1) {
				break;
			}
			function.add_parameter (cparam_map.get (min_pos));
			last_pos = min_pos;
		}


		// definition

		var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

		if (m.instance) {
			carg_map.set (get_param_pos (m.cinstance_parameter_position), new CCodeIdentifier ("self"));
		}

		int i = 0;
		foreach (FormalParameter param in m.get_parameters ()) {
			CCodeExpression arg;
			arg = new CCodeIdentifier ((d_params.get (i).ccodenode as CCodeFormalParameter).name);
			carg_map.set (get_param_pos (param.cparameter_position), arg);

			// handle array arguments
			if (!param.no_array_length && param.type_reference is ArrayType) {
				var array_type = (ArrayType) param.type_reference;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					CCodeExpression clength;
					if (d_params.get (i).no_array_length) {
						clength = new CCodeConstant ("-1");
					} else {
						clength = new CCodeIdentifier (get_array_length_cname (d_params.get (i).name, dim));
					}
					carg_map.set (get_param_pos (param.carray_length_parameter_position + 0.01 * dim), clength);
				}
			}

			i++;
		}

		if (m.get_error_domains ().size > 0) {
			carg_map.set (get_param_pos (-1), new CCodeIdentifier ("error"));
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_cname ()));

		// append C arguments in the right order
		last_pos = -1;
		while (true) {
			min_pos = -1;
			foreach (int pos in carg_map.get_keys ()) {
				if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
					min_pos = pos;
				}
			}
			if (min_pos == -1) {
				break;
			}
			ccall.add_argument (carg_map.get (min_pos));
			last_pos = min_pos;
		}

		var block = new CCodeBlock ();
		if (m.return_type is VoidType) {
			block.add_statement (new CCodeExpressionStatement (ccall));
		} else {
			block.add_statement (new CCodeReturnStatement (ccall));
		}

		// append to file

		source_type_member_declaration.append (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return wrapper_name;
	}

	public override void visit_assignment (Assignment! a) {
		a.code_binding.emit ();
	}

	public CCodeFunctionCall get_property_set_call (Property! prop, MemberAccess! ma, CCodeExpression! cexpr) {
		var set_func = "g_object_set";
		
		var base_property = prop;
		if (!prop.no_accessor_method) {
			if (prop.base_property != null) {
				base_property = prop.base_property;
			} else if (prop.base_interface_property != null) {
				base_property = prop.base_interface_property;
			}
			var base_property_type = (Typesymbol) base_property.parent_symbol;
			set_func = "%s_set_%s".printf (base_property_type.get_lower_case_cname (null), base_property.name);
		}
		
		var ccall = new CCodeFunctionCall (new CCodeIdentifier (set_func));

		/* target instance is first argument */
		CCodeExpression instance;

		DataType instance_expression_type;
		if (ma.inner == null) {
			instance = new CCodeIdentifier ("self");
			instance_expression_type = get_data_type_for_symbol (current_type_symbol);
		} else {
			instance = (CCodeExpression) ma.inner.ccodenode;
			instance_expression_type = ma.inner.static_type;
		}

		var instance_target_type = get_data_type_for_symbol ((Typesymbol) base_property.parent_symbol);
		instance = get_implicit_cast_expression (instance, instance_expression_type, instance_target_type);

		ccall.add_argument (instance);

		if (prop.no_accessor_method) {
			/* property name is second argument of g_object_set */
			ccall.add_argument (prop.get_canonical_cconstant ());
		}
			
		ccall.add_argument (cexpr);
		
		if (prop.no_accessor_method) {
			ccall.add_argument (new CCodeConstant ("NULL"));
		}

		return ccall;
	}

	/* indicates whether a given Expression eligable for an ADDRESS_OF operator
	 * from a vala to C point of view all expressions denoting locals, fields and
	 * parameters are eligable to an ADDRESS_OF operator */
	public bool is_address_of_possible (Expression e) {
		var ma = e as MemberAccess;

		if (ma == null) {
			return false;
		}
		if (ma.symbol_reference == null) {
			return false;
		}
		if (ma.symbol_reference is FormalParameter) {
			return true;
		}
		if (ma.symbol_reference is VariableDeclarator) {
			return true;
		}
		if (ma.symbol_reference is Field) {
			return true;
		}
		return false;
	}

	/* retrieve the correct address_of expression for a give expression, creates temporary variables
	 * where necessary, ce is the corresponding ccode expression for e */
	public CCodeExpression get_address_of_expression (Expression e, CCodeExpression ce) {
		// is address of trivially possible?
		if (is_address_of_possible (e)) {
			return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ce);
		}

		var ccomma = new CCodeCommaExpression ();
		var temp_decl = get_temp_variable_declarator (e.static_type);
		var ctemp = new CCodeIdentifier (temp_decl.name);
		temp_vars.add (temp_decl);
		ccomma.append_expression (new CCodeAssignment (ctemp, ce));
		ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
		return ccomma;
	}

	public bool add_wrapper (string wrapper_name) {
		return wrappers.add (wrapper_name);
	}

	public static DataType get_data_type_for_symbol (Typesymbol sym) {
		DataType type = null;

		if (sym is Class) {
			type = new ClassType ((Class) sym);
		} else if (sym is Interface) {
			type = new InterfaceType ((Interface) sym);
		} else if (sym is Struct) {
			type = new ValueType ((Struct) sym);
		} else if (sym is Enum) {
			type = new ValueType ((Enum) sym);
		} else {
			Report.error (null, "internal error: `%s' is not a supported type".printf (sym.get_full_name ()));
			return new InvalidType ();
		}

		return type;
	}

	public override CodeBinding create_namespace_binding (Namespace! node) {
		return null;
	}

	public override CodeBinding create_class_binding (Class! node) {
		return null;
	}

	public override CodeBinding create_struct_binding (Struct! node) {
		return null;
	}

	public override CodeBinding create_interface_binding (Interface! node) {
		return null;
	}

	public override CodeBinding create_enum_binding (Enum! node) {
		return null;
	}

	public override CodeBinding create_enum_value_binding (EnumValue! node) {
		return null;
	}

	public override CodeBinding create_error_domain_binding (ErrorDomain node) {
		return null;
	}

	public override CodeBinding create_error_code_binding (ErrorCode node) {
		return null;
	}

	public override CodeBinding create_delegate_binding (Delegate! node) {
		return null;
	}

	public override CodeBinding create_constant_binding (Constant! node) {
		return null;
	}

	public override CodeBinding create_field_binding (Field! node) {
		return null;
	}

	public override CodeBinding create_method_binding (Method! node) {
		return new CCodeMethodBinding (this, node);
	}

	public override CodeBinding create_creation_method_binding (CreationMethod! node) {
		return null;
	}

	public override CodeBinding create_formal_parameter_binding (FormalParameter! node) {
		return null;
	}

	public override CodeBinding create_property_binding (Property! node) {
		return null;
	}

	public override CodeBinding create_property_accessor_binding (PropertyAccessor! node) {
		return null;
	}

	public override CodeBinding create_signal_binding (Signal! node) {
		return null;
	}

	public override CodeBinding create_constructor_binding (Constructor! node) {
		return null;
	}

	public override CodeBinding create_destructor_binding (Destructor! node) {
		return null;
	}

	public override CodeBinding create_type_parameter_binding (TypeParameter! node) {
		return null;
	}

	public override CodeBinding create_block_binding (Block! node) {
		return null;
	}

	public override CodeBinding create_empty_statement_binding (EmptyStatement! node) {
		return null;
	}

	public override CodeBinding create_declaration_statement_binding (DeclarationStatement! node) {
		return null;
	}

	public override CodeBinding create_local_variable_declaration_binding (LocalVariableDeclaration! node) {
		return null;
	}

	public override CodeBinding create_variable_declarator_binding (VariableDeclarator! node) {
		return null;
	}

	public override CodeBinding create_initializer_list_binding (InitializerList! node) {
		return null;
	}

	public override CodeBinding create_expression_statement_binding (ExpressionStatement! node) {
		return null;
	}

	public override CodeBinding create_if_statement_binding (IfStatement! node) {
		return null;
	}

	public override CodeBinding create_switch_statement_binding (SwitchStatement! node) {
		return null;
	}

	public override CodeBinding create_switch_section_binding (SwitchSection! node) {
		return null;
	}

	public override CodeBinding create_switch_label_binding (SwitchLabel! node) {
		return null;
	}

	public override CodeBinding create_while_statement_binding (WhileStatement! node) {
		return null;
	}

	public override CodeBinding create_do_statement_binding (DoStatement! node) {
		return null;
	}

	public override CodeBinding create_for_statement_binding (ForStatement! node) {
		return null;
	}

	public override CodeBinding create_foreach_statement_binding (ForeachStatement! node) {
		return null;
	}

	public override CodeBinding create_break_statement_binding (BreakStatement! node) {
		return null;
	}

	public override CodeBinding create_continue_statement_binding (ContinueStatement! node) {
		return null;
	}

	public override CodeBinding create_return_statement_binding (ReturnStatement! node) {
		return null;
	}

	public override CodeBinding create_throw_statement_binding (ThrowStatement! node) {
		return null;
	}

	public override CodeBinding create_try_statement_binding (TryStatement! node) {
		return null;
	}

	public override CodeBinding create_catch_clause_binding (CatchClause! node) {
		return null;
	}

	public override CodeBinding create_lock_statement_binding (LockStatement! node) {
		return null;
	}

	public override CodeBinding create_delete_statement_binding (DeleteStatement node) {
		return null;
	}

	public override CodeBinding create_array_creation_expression_binding (ArrayCreationExpression! node) {
		return new CCodeArrayCreationExpressionBinding (this, node);
	}

	public override CodeBinding create_boolean_literal_binding (BooleanLiteral! node) {
		return null;
	}

	public override CodeBinding create_character_literal_binding (CharacterLiteral! node) {
		return null;
	}

	public override CodeBinding create_integer_literal_binding (IntegerLiteral! node) {
		return null;
	}

	public override CodeBinding create_real_literal_binding (RealLiteral! node) {
		return null;
	}

	public override CodeBinding create_string_literal_binding (StringLiteral! node) {
		return null;
	}

	public override CodeBinding create_null_literal_binding (NullLiteral! node) {
		return null;
	}

	public override CodeBinding create_parenthesized_expression_binding (ParenthesizedExpression! node) {
		return null;
	}

	public override CodeBinding create_member_access_binding (MemberAccess! node) {
		return null;
	}

	public override CodeBinding create_member_access_simple_binding (MemberAccess! node) {
		return null;
	}

	public override CodeBinding create_invocation_expression_binding (InvocationExpression! node) {
		return null;
	}

	public override CodeBinding create_element_access_binding (ElementAccess! node) {
		return new CCodeElementAccessBinding (this, node);
	}

	public override CodeBinding create_base_access_binding (BaseAccess! node) {
		return null;
	}

	public override CodeBinding create_postfix_expression_binding (PostfixExpression! node) {
		return null;
	}

	public override CodeBinding create_object_creation_expression_binding (ObjectCreationExpression! node) {
		return null;
	}

	public override CodeBinding create_sizeof_expression_binding (SizeofExpression! node) {
		return null;
	}

	public override CodeBinding create_typeof_expression_binding (TypeofExpression! node) {
		return null;
	}

	public override CodeBinding create_unary_expression_binding (UnaryExpression! node) {
		return null;
	}

	public override CodeBinding create_cast_expression_binding (CastExpression! node) {
		return null;
	}

	public override CodeBinding create_pointer_indirection_binding (PointerIndirection! node) {
		return null;
	}

	public override CodeBinding create_addressof_expression_binding (AddressofExpression! node) {
		return null;
	}

	public override CodeBinding create_reference_transfer_expression_binding (ReferenceTransferExpression! node) {
		return null;
	}

	public override CodeBinding create_binary_expression_binding (BinaryExpression! node) {
		return null;
	}

	public override CodeBinding create_type_check_binding (TypeCheck! node) {
		return null;
	}

	public override CodeBinding create_conditional_expression_binding (ConditionalExpression! node) {
		return null;
	}

	public override CodeBinding create_lambda_expression_binding (LambdaExpression! node) {
		return null;
	}

	public override CodeBinding create_lambda_expression_with_statement_body_binding (LambdaExpression! node) {
		return null;
	}

	public override CodeBinding create_assignment_binding (Assignment! node) {
		return new CCodeAssignmentBinding (this, node);
	}
}
