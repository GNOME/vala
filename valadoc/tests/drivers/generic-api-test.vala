/* api-test.vala
 *
 * Copyright (C) 2013  Florian Brosch
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


using Valadoc;

[CCode (cname = "TOP_SRC_DIR")]
extern const string TOP_SRC_DIR;


public static void test_enum_global (Api.Enum? en, Api.Package pkg, Api.Namespace global_ns) {
	assert (en != null);

	// (.Enum check)
	assert (en.get_cname () == "TestEnumGlobal");
	// (.TypeSymbol check)
	assert (en.is_basic_type == false);
	// (.Symbol check)
	assert (en.is_deprecated == false);
	assert (en.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (en.get_full_name () == "TestEnumGlobal");
	assert (en.get_filename () == "api-test.data.vapi");
	assert (en.name == "TestEnumGlobal");
	assert (en.nspace == global_ns);
	assert (en.package == pkg);


	Vala.List<Api.Node> enumvalues = en.get_children_by_type (Api.NodeType.ENUM_VALUE, false);
	assert (enumvalues.size == 2);


	bool enval1 = false;
	bool enval2 = false;

	foreach (Api.Node node in enumvalues) {
		Api.EnumValue enval = node as Api.EnumValue;
		assert (enval != null);

		switch (enval.name) {
		case "ENVAL1":
			// (.EnumValue)
			assert (enval.default_value != null);
			assert (enval.has_default_value == true);
			assert (enval.get_cname () == "TEST_ENUM_GLOBAL_ENVAL1");
			// (.Symbol check)
			assert (enval.is_deprecated == false);
			assert (enval.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (enval.get_full_name () == "TestEnumGlobal.ENVAL1");
			assert (enval.get_filename () == "api-test.data.vapi");
			assert (enval.nspace == global_ns);
			assert (enval.package == pkg);

			enval1 = true;
			break;

		case "ENVAL2":
			// (.EnumValue)
			assert (enval.default_value == null);
			assert (enval.has_default_value == false);
			assert (enval.get_cname () == "TEST_ENUM_GLOBAL_ENVAL2");
			// (.Symbol check)
			assert (enval.is_deprecated == false);
			assert (enval.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (enval.get_full_name () == "TestEnumGlobal.ENVAL2");
			assert (enval.get_filename () == "api-test.data.vapi");
			assert (enval.nspace == global_ns);
			assert (enval.package == pkg);

			enval2 = true;
			break;

		default:
			assert_not_reached ();
		}
	}

	assert (enval1 == true);
	assert (enval2 == true);



	Vala.List<Api.Node> methods = en.get_children_by_type (Api.NodeType.METHOD, false);
	assert (methods.size == 1);

	Api.Method method = methods.get (0) as Api.Method;
	assert (method != null);

	// (.Method check)
	assert (method.get_cname () == "test_enum_global_method");
	//assert (method.get_dbus_name () == null);
	//assert (method.get_dbus_result_name () == null);
	//assert (method.is_dbus_visible == false);
	assert (method.base_method == null);
	assert (method.is_yields == false);
	assert (method.is_abstract == false);
	assert (method.is_virtual == false);
	assert (method.is_override == false);
	assert (method.is_static == false);
	assert (method.is_constructor == false);
	assert (method.is_inline == false);
	// (.Symbol check)
	assert (method.is_deprecated == false);
	assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (method.get_full_name () == "TestEnumGlobal.method");
	assert (method.get_filename () == "api-test.data.vapi");
	assert (method.name == "method");
	assert (method.nspace == global_ns);
	assert (method.package == pkg);



	methods = en.get_children_by_type (Api.NodeType.STATIC_METHOD, false);
	assert (methods.size == 1);

	method = methods.get (0) as Api.Method;
	assert (method != null);

	// (.Method check)
	assert (method.get_cname () == "test_enum_global_static_method");
	//assert (method.get_dbus_name () == null);
	//assert (method.get_dbus_result_name () == null);
	//assert (method.is_dbus_visible == false);
	assert (method.base_method == null);
	assert (method.is_yields == false);
	assert (method.is_abstract == false);
	assert (method.is_virtual == false);
	assert (method.is_override == false);
	assert (method.is_static == true);
	assert (method.is_constructor == false);
	assert (method.is_inline == false);
	// (.Symbol check)
	assert (method.is_deprecated == false);
	assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (method.get_full_name () == "TestEnumGlobal.static_method");
	assert (method.get_filename () == "api-test.data.vapi");
	assert (method.name == "static_method");
	assert (method.nspace == global_ns);
	assert (method.package == pkg);


	Api.NodeType[] forbidden = {
			Api.NodeType.CLASS,
			Api.NodeType.CONSTANT,
			Api.NodeType.CREATION_METHOD,
			Api.NodeType.DELEGATE,
			Api.NodeType.ENUM,
			Api.NodeType.ERROR_CODE,
			Api.NodeType.ERROR_DOMAIN,
			Api.NodeType.FIELD,
			Api.NodeType.FORMAL_PARAMETER,
			Api.NodeType.INTERFACE,
			Api.NodeType.NAMESPACE,
			Api.NodeType.PACKAGE,
			Api.NodeType.PROPERTY,
			Api.NodeType.PROPERTY_ACCESSOR,
			Api.NodeType.SIGNAL,
			Api.NodeType.STRUCT,
			Api.NodeType.TYPE_PARAMETER
		};

	Vala.List<Api.Node> nodes = en.get_children_by_types (forbidden, false);
	assert (nodes.size == 0);
}


public static void test_erroromain_global (Api.ErrorDomain? err, Api.Package pkg, Api.Namespace global_ns) {
	assert (err != null);

	// (.ErrorDomain check)
	assert (err.get_cname () == "TestErrDomGlobal");
	//assert (err.get_dbus_name () == "");
	// (.TypeSymbol check)
	assert (err.is_basic_type == false);
	// (.Symbol check)
	assert (err.is_deprecated == false);
	assert (err.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (err.get_full_name () == "TestErrDomGlobal");
	assert (err.get_filename () == "api-test.data.vapi");
	assert (err.name == "TestErrDomGlobal");
	assert (err.nspace == global_ns);
	assert (err.package == pkg);


	Vala.List<Api.Node> errcodes = err.get_children_by_type (Api.NodeType.ERROR_CODE, false);
	assert (errcodes.size == 2);


	bool errc1 = false;
	bool errc2 = false;

	foreach (Api.Node node in errcodes) {
		Api.ErrorCode errc = node as Api.ErrorCode;
		assert (errc != null);

		switch (errc.name) {
		case "ERROR1":
			// (.EnumValue)
			assert (errc.get_cname () == "TEST_ERR_DOM_GLOBAL_ERROR1");
			// (.Symbol check)
			assert (errc.is_deprecated == false);
			assert (errc.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (errc.get_full_name () == "TestErrDomGlobal.ERROR1");
			assert (errc.get_filename () == "api-test.data.vapi");
			assert (errc.nspace == global_ns);
			assert (errc.package == pkg);

			errc1 = true;
			break;

		case "ERROR2":
			// (.EnumValue)
			assert (errc.get_cname () == "TEST_ERR_DOM_GLOBAL_ERROR2");
			// (.Symbol check)
			assert (errc.is_deprecated == false);
			assert (errc.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (errc.get_full_name () == "TestErrDomGlobal.ERROR2");
			assert (errc.get_filename () == "api-test.data.vapi");
			assert (errc.nspace == global_ns);
			assert (errc.package == pkg);

			errc2 = true;
			break;

		default:
			assert_not_reached ();
		}
	}

	assert (errc1 == true);
	assert (errc2 == true);


	Vala.List<Api.Node> methods = err.get_children_by_type (Api.NodeType.STATIC_METHOD, false);
	assert (methods.size == 2);

	Api.Method method = methods.get (0) as Api.Method;
	assert (method != null);

	// (.Method check)
	assert (method.get_cname () == "test_err_dom_global_static_method");
	//assert (method.get_dbus_name () == null);
	//assert (method.get_dbus_result_name () == null);
	//assert (method.is_dbus_visible == false);
	assert (method.base_method == null);
	assert (method.is_yields == false);
	assert (method.is_abstract == false);
	assert (method.is_virtual == false);
	assert (method.is_override == false);
	assert (method.is_static == true);
	assert (method.is_constructor == false);
	assert (method.is_inline == false);
	// (.Symbol check)
	assert (method.is_deprecated == false);
	assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (method.get_full_name () == "TestErrDomGlobal.static_method");
	assert (method.get_filename () == "api-test.data.vapi");
	assert (method.name == "static_method");
	assert (method.nspace == global_ns);
	assert (method.package == pkg);


	Api.NodeType[] forbidden = {
			Api.NodeType.CLASS,
			Api.NodeType.CONSTANT,
			Api.NodeType.CREATION_METHOD,
			Api.NodeType.DELEGATE,
			Api.NodeType.ENUM,
			Api.NodeType.ENUM_VALUE,
			Api.NodeType.ERROR_DOMAIN,
			Api.NodeType.FIELD,
			Api.NodeType.FORMAL_PARAMETER,
			Api.NodeType.INTERFACE,
			Api.NodeType.NAMESPACE,
			Api.NodeType.PACKAGE,
			Api.NodeType.PROPERTY,
			Api.NodeType.PROPERTY_ACCESSOR,
			Api.NodeType.SIGNAL,
			Api.NodeType.STRUCT,
			Api.NodeType.TYPE_PARAMETER
		};

	Vala.List<Api.Node> nodes = err.get_children_by_types (forbidden, false);
	assert (nodes.size == 0);
}


public static void test_class_global (Api.Class? cl, Api.Package pkg, Api.Namespace global_ns) {
	assert (cl != null);

	// (.Class check)
	assert (cl.base_type == null);
	assert (cl.get_cname () == "TestClassGlobal");
	assert (cl.get_type_id () == "TYPE_TEST_CLASS_GLOBAL");
	assert (cl.get_ref_function_cname () == "test_class_global_ref");
	assert (cl.get_unref_function_cname () == "test_class_global_unref");
	assert (cl.get_param_spec_function_cname () == "param_spec_test_class_global");
	assert (cl.get_set_value_function_cname () == "value_set_test_class_global");
	assert (cl.get_get_value_function_cname () == "value_get_test_class_global");
	assert (cl.get_take_value_function_cname () == "value_take_test_class_global");
	assert (cl.get_dbus_name () == null);
	assert (cl.get_implemented_interface_list ().size == 0);
	assert (cl.get_full_implemented_interface_list ().size == 0);
	assert (cl.is_abstract == false);
	assert (cl.is_fundamental == true);
	// (.Symbol check)
	assert (cl.is_deprecated == false);
	assert (cl.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	//assert (property.getter.get_full_name () == "TestClassGlobal.property_3");
	assert (cl.get_full_name () == "TestClassGlobal");
	assert (cl.get_filename () == "api-test.data.vapi");
	assert (cl.name == "TestClassGlobal");
	assert (cl.nspace == global_ns);
	assert (cl.package == pkg);


	Vala.List<Api.Node> methods = cl.get_children_by_type (Api.NodeType.METHOD, false);
	assert (methods.size == 1);

	Api.Method method = methods.get (0) as Api.Method;
	assert (method != null);

	// (.Method check)
	assert (method.get_cname () == "test_class_global_method");
	//assert (method.get_dbus_name () == null);
	//assert (method.get_dbus_result_name () == null);
	//assert (method.is_dbus_visible == false);
	assert (method.base_method == null);
	assert (method.is_yields == false);
	assert (method.is_abstract == false);
	assert (method.is_virtual == false);
	assert (method.is_override == false);
	assert (method.is_static == false);
	assert (method.is_constructor == false);
	assert (method.is_inline == false);
	// (.Symbol check)
	assert (method.is_deprecated == false);
	assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (method.get_full_name () == "TestClassGlobal.method");
	assert (method.get_filename () == "api-test.data.vapi");
	assert (method.name == "method");
	assert (method.nspace == global_ns);
	assert (method.package == pkg);



	methods = cl.get_children_by_type (Api.NodeType.STATIC_METHOD, false);
	assert (methods.size == 1);

	method = methods.get (0) as Api.Method;
	assert (method != null);

	// (.Method check)
	assert (method.get_cname () == "test_class_global_static_method");
	//assert (method.get_dbus_name () == null);
	//assert (method.get_dbus_result_name () == null);
	//assert (method.is_dbus_visible == false);
	assert (method.base_method == null);
	assert (method.is_yields == false);
	assert (method.is_abstract == false);
	assert (method.is_virtual == false);
	assert (method.is_override == false);
	assert (method.is_static == true);
	assert (method.is_constructor == false);
	assert (method.is_inline == false);
	// (.Symbol check)
	assert (method.is_deprecated == false);
	assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (method.get_full_name () == "TestClassGlobal.static_method");
	assert (method.get_filename () == "api-test.data.vapi");
	assert (method.name == "static_method");
	assert (method.nspace == global_ns);
	assert (method.package == pkg);



	methods = cl.get_children_by_type (Api.NodeType.CREATION_METHOD, false);
	bool default_constr = false;
	bool named_constr = false;

	foreach (Api.Node node in methods) {
		method = node as Api.Method;
		assert (method != null);

		switch (method.name) {
			case "TestClassGlobal":
				// (.Method check)
				assert (method.get_cname () == "test_class_global_new");
				//assert (method.get_dbus_name () == null);
				//assert (method.get_dbus_result_name () == null);
				//assert (method.is_dbus_visible == false);
				assert (method.base_method == null);
				assert (method.is_yields == false);
				assert (method.is_abstract == false);
				assert (method.is_virtual == false);
				assert (method.is_override == false);
				assert (method.is_static == false);
				assert (method.is_constructor == true);
				assert (method.is_inline == false);
				// (.Symbol check)
				assert (method.is_deprecated == false);
				assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
				// (.Node)
				assert (method.get_full_name () == "TestClassGlobal.TestClassGlobal");
				assert (method.get_filename () == "api-test.data.vapi");
				assert (method.nspace == global_ns);
				assert (method.package == pkg);

				default_constr = true;
				break;

			case "TestClassGlobal.named":
				// (.Method check)
				assert (method.get_cname () == "test_class_global_new_named");
				//assert (method.get_dbus_name () == null);
				//assert (method.get_dbus_result_name () == null);
				//assert (method.is_dbus_visible == false);
				assert (method.base_method == null);
				assert (method.is_yields == false);
				assert (method.is_abstract == false);
				assert (method.is_virtual == false);
				assert (method.is_override == false);
				assert (method.is_static == false);
				assert (method.is_constructor == true);
				assert (method.is_inline == false);
				// (.Symbol check)
				assert (method.is_deprecated == false);
				assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
				// (.Node)
				assert (method.get_full_name () == "TestClassGlobal.TestClassGlobal.named");
				assert (method.get_filename () == "api-test.data.vapi");
				assert (method.nspace == global_ns);
				assert (method.package == pkg);

				named_constr = true;
				break;

			default:
				assert_not_reached ();
		}
	}

	assert (default_constr == true);
	assert (named_constr == true);



	Vala.List<Api.Node> properties = cl.get_children_by_type (Api.NodeType.PROPERTY, false);
	bool prop1 = false;
	bool prop2 = false;
	bool prop3 = false;

	foreach (Api.Node node in properties) {
		Api.Property property = node as Api.Property;
		assert (property != null);

		switch (property.name) {
		case "property_1":
			assert (property.get_cname () == "property-1");
			assert (property.property_type != null);
			assert (property.is_virtual == false);
			assert (property.is_abstract == false);
			assert (property.is_override == false);
			assert (property.is_dbus_visible == true);
			assert (property.setter != null);
			assert (property.getter != null);
			assert (property.base_property == null);
			// (.Symbol check)
			assert (property.is_deprecated == false);
			assert (property.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (property.get_full_name () == "TestClassGlobal.property_1");
			assert (property.get_filename () == "api-test.data.vapi");
			assert (property.nspace == global_ns);
			assert (property.package == pkg);


			assert (property.getter.get_cname () == "test_class_global_get_property_1");
			assert (property.getter.is_construct == false);
			assert (property.getter.is_set == false);
			assert (property.getter.is_get == true);
			assert (property.getter.is_owned == false);
			// (.Symbol check)
			assert (property.getter.is_deprecated == false);
			assert (property.getter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestClassGlobal.property_2");
			assert (property.getter.get_filename () == "api-test.data.vapi");
			assert (property.getter.nspace == global_ns);
			assert (property.getter.package == pkg);


			assert (property.setter.get_cname () == "test_class_global_set_property_1");
			assert (property.setter.is_construct == false);
			assert (property.setter.is_get == false);
			assert (property.setter.is_set == true);
			assert (property.setter.is_owned == false);
			// (.Symbol check)
			assert (property.setter.is_deprecated == false);
			assert (property.setter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestClassGlobal.property_2");
			assert (property.setter.get_filename () == "api-test.data.vapi");
			assert (property.setter.nspace == global_ns);
			assert (property.setter.package == pkg);

			prop1 = true;
			break;

		case "property_2":
			assert (property.get_cname () == "property-2");
			assert (property.property_type != null);
			assert (property.is_virtual == false);
			assert (property.is_abstract == false);
			assert (property.is_override == false);
			assert (property.is_dbus_visible == true);
			assert (property.setter == null);
			assert (property.getter != null);
			assert (property.base_property == null);
			// (.Symbol check)
			assert (property.is_deprecated == false);
			assert (property.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (property.get_full_name () == "TestClassGlobal.property_2");
			assert (property.get_filename () == "api-test.data.vapi");
			assert (property.nspace == global_ns);
			assert (property.package == pkg);

			assert (property.getter.get_cname () == "test_class_global_get_property_2");
			assert (property.getter.is_construct == false);
			assert (property.getter.is_set == false);
			assert (property.getter.is_get == true);
			assert (property.getter.is_owned == false);
			// (.Symbol check)
			assert (property.getter.is_deprecated == false);
			assert (property.getter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestClassGlobal.property_2");
			assert (property.getter.get_filename () == "api-test.data.vapi");
			assert (property.getter.nspace == global_ns);
			assert (property.getter.package == pkg);

			prop2 = true;
			break;


		case "property_3":
			assert (property.get_cname () == "property-3");
			assert (property.property_type != null);
			assert (property.is_virtual == false);
			assert (property.is_abstract == false);
			assert (property.is_override == false);
			assert (property.is_dbus_visible == true);
			assert (property.setter != null);
			assert (property.getter != null);
			assert (property.base_property == null);
			// (.Symbol check)
			assert (property.is_deprecated == false);
			assert (property.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (property.get_full_name () == "TestClassGlobal.property_3");
			assert (property.get_filename () == "api-test.data.vapi");
			assert (property.nspace == global_ns);
			assert (property.package == pkg);

			assert (property.getter.get_cname () == "test_class_global_get_property_3");
			assert (property.getter.is_construct == false);
			assert (property.getter.is_set == false);
			assert (property.getter.is_get == true);
			assert (property.getter.is_owned == true);
			// (.Symbol check)
			assert (property.getter.is_deprecated == false);
			assert (property.getter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestClassGlobal.property_3");
			assert (property.getter.get_filename () == "api-test.data.vapi");
			assert (property.getter.nspace == global_ns);
			assert (property.getter.package == pkg);


			assert (property.setter.get_cname () == "test_class_global_set_property_3");
			assert (property.setter.is_construct == false);
			assert (property.setter.is_get == false);
			assert (property.setter.is_set == true);
			assert (property.setter.is_owned == false);
			// (.Symbol check)
			assert (property.setter.is_deprecated == false);
			assert (property.setter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestClassGlobal.property_3");
			assert (property.setter.get_filename () == "api-test.data.vapi");
			assert (property.setter.nspace == global_ns);
			assert (property.setter.package == pkg);


			prop3 = true;
			break;

		default:
			assert_not_reached ();
		}
	}
	assert (prop1);
	assert (prop2);
	assert (prop3);


	Vala.List<Api.Node> delegates = cl.get_children_by_type (Api.NodeType.DELEGATE, false);
	assert (delegates.size == 1);

	Api.Delegate del = delegates.get (0) as Api.Delegate;
	assert (del != null);

	// (.Delegate check)
	assert (del.get_cname () == "TestClassGlobalFoo");
	assert (del.return_type != null);
	assert (del.is_static == false);
	// (.Symbol check)
	assert (del.is_deprecated == false);
	assert (del.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	//assert (property.getter.get_full_name () == "TestClassGlobal.property_3");
	assert (del.get_filename () == "api-test.data.vapi");
	assert (del.nspace == global_ns);
	assert (del.package == pkg);



	Vala.List<Api.Node> signals = cl.get_children_by_type (Api.NodeType.SIGNAL, false);
	assert (signals.size == 1);

	Api.Signal sig = signals.get (0) as Api.Signal;
	assert (sig != null);

	// (.Signal check)
	assert (sig.get_cname () == "sig-1");
	assert (sig.is_virtual == false);
	assert (sig.return_type != null);
	//assert (sig.is_static == false);
	// (.Symbol check)
	assert (sig.is_deprecated == false);
	assert (sig.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	//assert (sig.get_full_name () == "TestClassGlobal.property_3");
	assert (sig.get_filename () == "api-test.data.vapi");
	assert (sig.nspace == global_ns);
	assert (sig.package == pkg);



	Vala.List<Api.Node> constants = cl.get_children_by_type (Api.NodeType.CONSTANT, false);
	assert (constants.size == 1);

	Api.Constant constant = constants.get (0) as Api.Constant;
	assert (constant != null);
	// (.Constant check)
	assert (constant.get_cname () == "TEST_CLASS_GLOBAL_constant");
	// (.Symbol check)
	assert (constant.is_deprecated == false);
	assert (constant.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (constant.get_full_name () == "TestClassGlobal.constant");
	assert (constant.get_filename () == "api-test.data.vapi");
	assert (constant.name == "constant");
	assert (constant.nspace == global_ns);
	assert (constant.package == pkg);


	Vala.List<Api.Node> fields = cl.get_children_by_type (Api.NodeType.FIELD, false);

	bool field1 = false;
	bool field2 = false;
	foreach (Api.Node node in fields) {
		Api.Field field = node as Api.Field;
		assert (field != null);

		switch (field.name) {
		case "field1":
			// (.Field check)
			assert (field.get_cname () == "test_class_global_field1");
			assert (field.is_static == true);
			assert (field.is_volatile == false);
			// (.Symbol check)
			assert (field.is_deprecated == false);
			assert (field.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (field.get_full_name () == "TestClassGlobal.field1");
			assert (field.get_filename () == "api-test.data.vapi");
			assert (field.nspace == global_ns);
			assert (field.package == pkg);

			field1 = true;
			break;

		case "field2":
			// (.Field check)
			assert (field.get_cname () == "field2");
			assert (field.is_static == false);
			assert (field.is_volatile == false);
			// (.Symbol check)
			assert (field.is_deprecated == false);
			assert (field.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (field.get_full_name () == "TestClassGlobal.field2");
			assert (field.get_filename () == "api-test.data.vapi");
			assert (field.nspace == global_ns);
			assert (field.package == pkg);

			field2 = true;
			break;

		default:
			assert_not_reached ();
		}
	}

	assert (field1 == true);
	assert (field2 == true);



	Vala.List<Api.Node> classes = cl.get_children_by_type (Api.NodeType.CLASS, false);
	assert (classes.size == 1);

	Api.Class? subcl = classes.get (0) as Api.Class;
	assert (subcl != null);
	assert (subcl.base_type == null);
	// (.Symbol check)
	assert (subcl.is_deprecated == false);
	assert (subcl.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (subcl.get_full_name () == "TestClassGlobal.InnerClass");
	assert (subcl.get_filename () == "api-test.data.vapi");
	assert (subcl.nspace == global_ns);
	assert (subcl.package == pkg);



	Vala.List<Api.Node> structs = cl.get_children_by_type (Api.NodeType.STRUCT, false);
	assert (structs.size == 1);

	Api.Struct? substru = structs.get (0) as Api.Struct;
	assert (substru != null);
	// (.Struct check)
	assert (substru.base_type == null);
	assert (substru.get_cname () == "TestClassGlobalInnerStruct");
	assert (substru.get_free_function_cname () == null);
	assert (substru.get_dup_function_cname () == null);
	assert (substru.get_type_id () == "TEST_CLASS_GLOBAL_TYPE_INNER_STRUCT");
	// (.Symbol check)
	assert (substru.is_deprecated == false);
	assert (substru.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (substru.get_full_name () == "TestClassGlobal.InnerStruct");
	assert (substru.get_filename () == "api-test.data.vapi");
	assert (substru.name == "InnerStruct");
	assert (substru.nspace == global_ns);
	assert (substru.package == pkg);


	Api.NodeType[] forbidden = {
			Api.NodeType.ENUM,
			Api.NodeType.ENUM_VALUE,
			Api.NodeType.ERROR_CODE,
			Api.NodeType.ERROR_DOMAIN,
			Api.NodeType.FORMAL_PARAMETER,
			Api.NodeType.INTERFACE,
			Api.NodeType.NAMESPACE,
			Api.NodeType.PACKAGE,
			Api.NodeType.PROPERTY_ACCESSOR,
			Api.NodeType.TYPE_PARAMETER
		};

	Vala.List<Api.Node> nodes = cl.get_children_by_types (forbidden, false);
	assert (nodes.size == 0);
}


public static void test_interface_global (Api.Interface? iface, Api.Package pkg, Api.Namespace global_ns) {
	assert (iface != null);

	// (.Interface check)
	assert (iface.base_type == null);
	assert (iface.get_implemented_interface_list ().size == 0);
	assert (iface.get_full_implemented_interface_list ().size == 0);
	assert (iface.get_cname () == "TestInterfaceGlobal");
	assert (iface.get_dbus_name () == null);
	// (.Symbol check)
	assert (iface.is_deprecated == false);
	assert (iface.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (iface.get_full_name () == "TestInterfaceGlobal");
	assert (iface.get_filename () == "api-test.data.vapi");
	assert (iface.name == "TestInterfaceGlobal");
	assert (iface.nspace == global_ns);
	assert (iface.package == pkg);


	Vala.List<Api.Node> methods = iface.get_children_by_type (Api.NodeType.METHOD, false);
	assert (methods.size == 1);

	Api.Method method = methods.get (0) as Api.Method;
	assert (method != null);

	// (.Method check)
	assert (method.get_cname () == "test_interface_global_method");
	//assert (method.get_dbus_name () == null);
	//assert (method.get_dbus_result_name () == null);
	//assert (method.is_dbus_visible == false);
	assert (method.base_method == null);
	assert (method.is_yields == false);
	assert (method.is_abstract == false);
	assert (method.is_virtual == false);
	assert (method.is_override == false);
	assert (method.is_static == false);
	assert (method.is_constructor == false);
	assert (method.is_inline == false);
	// (.Symbol check)
	assert (method.is_deprecated == false);
	assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (method.get_full_name () == "TestInterfaceGlobal.method");
	assert (method.get_filename () == "api-test.data.vapi");
	assert (method.name == "method");
	assert (method.nspace == global_ns);
	assert (method.package == pkg);



	methods = iface.get_children_by_type (Api.NodeType.STATIC_METHOD, false);
	assert (methods.size == 1);

	method = methods.get (0) as Api.Method;
	assert (method != null);

	// (.Method check)
	assert (method.get_cname () == "test_interface_global_static_method");
	//assert (method.get_dbus_name () == null);
	//assert (method.get_dbus_result_name () == null);
	//assert (method.is_dbus_visible == false);
	assert (method.base_method == null);
	assert (method.is_yields == false);
	assert (method.is_abstract == false);
	assert (method.is_virtual == false);
	assert (method.is_override == false);
	assert (method.is_static == true);
	assert (method.is_constructor == false);
	assert (method.is_inline == false);
	// (.Symbol check)
	assert (method.is_deprecated == false);
	assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (method.get_full_name () == "TestInterfaceGlobal.static_method");
	assert (method.get_filename () == "api-test.data.vapi");
	assert (method.name == "static_method");
	assert (method.nspace == global_ns);
	assert (method.package == pkg);


	Vala.List<Api.Node> properties = iface.get_children_by_type (Api.NodeType.PROPERTY, false);
	bool prop1 = false;
	bool prop2 = false;
	bool prop3 = false;

	foreach (Api.Node node in properties) {
		Api.Property property = node as Api.Property;
		assert (property != null);

		switch (property.name) {
		case "property_1":
			assert (property.get_cname () == "property-1");
			assert (property.property_type != null);
			assert (property.is_virtual == false);
			assert (property.is_abstract == false);
			assert (property.is_override == false);
			assert (property.is_dbus_visible == true);
			assert (property.setter != null);
			assert (property.getter != null);
			assert (property.base_property == null);
			// (.Symbol check)
			assert (property.is_deprecated == false);
			assert (property.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (property.get_full_name () == "TestInterfaceGlobal.property_1");
			assert (property.get_filename () == "api-test.data.vapi");
			assert (property.nspace == global_ns);
			assert (property.package == pkg);


			assert (property.getter.get_cname () == "test_interface_global_get_property_1");
			assert (property.getter.is_construct == false);
			assert (property.getter.is_set == false);
			assert (property.getter.is_get == true);
			assert (property.getter.is_owned == false);
			// (.Symbol check)
			assert (property.getter.is_deprecated == false);
			assert (property.getter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestInterfaceGlobal.property_2");
			assert (property.getter.get_filename () == "api-test.data.vapi");
			assert (property.getter.nspace == global_ns);
			assert (property.getter.package == pkg);


			assert (property.setter.get_cname () == "test_interface_global_set_property_1");
			assert (property.setter.is_construct == false);
			assert (property.setter.is_get == false);
			assert (property.setter.is_set == true);
			assert (property.setter.is_owned == false);
			// (.Symbol check)
			assert (property.setter.is_deprecated == false);
			assert (property.setter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestInterfaceGlobal.property_2");
			assert (property.setter.get_filename () == "api-test.data.vapi");
			assert (property.setter.nspace == global_ns);
			assert (property.setter.package == pkg);

			prop1 = true;
			break;

		case "property_2":
			assert (property.get_cname () == "property-2");
			assert (property.property_type != null);
			assert (property.is_virtual == false);
			assert (property.is_abstract == false);
			assert (property.is_override == false);
			assert (property.is_dbus_visible == true);
			assert (property.setter == null);
			assert (property.getter != null);
			assert (property.base_property == null);
			// (.Symbol check)
			assert (property.is_deprecated == false);
			assert (property.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (property.get_full_name () == "TestInterfaceGlobal.property_2");
			assert (property.get_filename () == "api-test.data.vapi");
			assert (property.nspace == global_ns);
			assert (property.package == pkg);

			assert (property.getter.get_cname () == "test_interface_global_get_property_2");
			assert (property.getter.is_construct == false);
			assert (property.getter.is_set == false);
			assert (property.getter.is_get == true);
			assert (property.getter.is_owned == false);
			// (.Symbol check)
			assert (property.getter.is_deprecated == false);
			assert (property.getter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestInterfaceGlobal.property_2");
			assert (property.getter.get_filename () == "api-test.data.vapi");
			assert (property.getter.nspace == global_ns);
			assert (property.getter.package == pkg);

			prop2 = true;
			break;


		case "property_3":
			assert (property.get_cname () == "property-3");
			assert (property.property_type != null);
			assert (property.is_virtual == false);
			assert (property.is_abstract == false);
			assert (property.is_override == false);
			assert (property.is_dbus_visible == true);
			assert (property.setter != null);
			assert (property.getter != null);
			assert (property.base_property == null);
			// (.Symbol check)
			assert (property.is_deprecated == false);
			assert (property.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (property.get_full_name () == "TestInterfaceGlobal.property_3");
			assert (property.get_filename () == "api-test.data.vapi");
			assert (property.nspace == global_ns);
			assert (property.package == pkg);

			assert (property.getter.get_cname () == "test_interface_global_get_property_3");
			assert (property.getter.is_construct == false);
			assert (property.getter.is_set == false);
			assert (property.getter.is_get == true);
			assert (property.getter.is_owned == true);
			// (.Symbol check)
			assert (property.getter.is_deprecated == false);
			assert (property.getter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestInterfaceGlobal.property_3");
			assert (property.getter.get_filename () == "api-test.data.vapi");
			assert (property.getter.nspace == global_ns);
			assert (property.getter.package == pkg);


			assert (property.setter.get_cname () == "test_interface_global_set_property_3");
			assert (property.setter.is_construct == false);
			assert (property.setter.is_get == false);
			assert (property.setter.is_set == true);
			assert (property.setter.is_owned == false);
			// (.Symbol check)
			assert (property.setter.is_deprecated == false);
			assert (property.setter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestInterfaceGlobal.property_3");
			assert (property.setter.get_filename () == "api-test.data.vapi");
			assert (property.setter.nspace == global_ns);
			assert (property.setter.package == pkg);


			prop3 = true;
			break;

		default:
			assert_not_reached ();
		}
	}
	assert (prop1);
	assert (prop2);
	assert (prop3);



	Vala.List<Api.Node> delegates = iface.get_children_by_type (Api.NodeType.DELEGATE, false);
	assert (delegates.size == 1);

	Api.Delegate del = delegates.get (0) as Api.Delegate;
	assert (del != null);

	// (.Delegate check)
	assert (del.get_cname () == "TestInterfaceGlobalFoo");
	assert (del.return_type != null);
	assert (del.is_static == false);
	// (.Symbol check)
	assert (del.is_deprecated == false);
	assert (del.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	//assert (del.get_full_name () == "TestClassGlobal.property_3");
	assert (del.get_filename () == "api-test.data.vapi");
	assert (del.nspace == global_ns);
	assert (del.package == pkg);



	Vala.List<Api.Node> signals = iface.get_children_by_type (Api.NodeType.SIGNAL, false);
	assert (signals.size == 1);

	Api.Signal sig = signals.get (0) as Api.Signal;
	assert (sig != null);

	// (.Signal check)
	assert (sig.get_cname () == "sig-1");
	assert (sig.is_virtual == false);
	assert (sig.return_type != null);
	//assert (sig.is_static == false);
	// (.Symbol check)
	assert (sig.is_deprecated == false);
	assert (sig.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	//assert (sig.get_full_name () == "TestClassGlobal.property_3");
	assert (sig.get_filename () == "api-test.data.vapi");
	assert (sig.nspace == global_ns);
	assert (sig.package == pkg);



	Vala.List<Api.Node> constants = iface.get_children_by_type (Api.NodeType.CONSTANT, false);
	assert (constants.size == 1);

	Api.Constant constant = constants.get (0) as Api.Constant;
	assert (constant != null);
	// (.Constant check)
	assert (constant.get_cname () == "TEST_INTERFACE_GLOBAL_constant");
	// (.Symbol check)
	assert (constant.is_deprecated == false);
	assert (constant.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (constant.get_full_name () == "TestInterfaceGlobal.constant");
	assert (constant.get_filename () == "api-test.data.vapi");
	assert (constant.name == "constant");
	assert (constant.nspace == global_ns);
	assert (constant.package == pkg);


	Api.NodeType[] forbidden = {
			Api.NodeType.CREATION_METHOD,
			Api.NodeType.ENUM,
			Api.NodeType.ENUM_VALUE,
			Api.NodeType.ERROR_CODE,
			Api.NodeType.ERROR_DOMAIN,
			Api.NodeType.FIELD,
			Api.NodeType.FORMAL_PARAMETER,
			Api.NodeType.INTERFACE,
			Api.NodeType.NAMESPACE,
			Api.NodeType.PACKAGE,
			Api.NodeType.PROPERTY_ACCESSOR,
			Api.NodeType.STRUCT,
			Api.NodeType.TYPE_PARAMETER
		};

	Vala.List<Api.Node> nodes = iface.get_children_by_types (forbidden, false);
	assert (nodes.size == 0);
}


public static void test_struct_global (Api.Struct? stru, Api.Package pkg, Api.Namespace global_ns) {
	assert (stru != null);
	// (.Struct check)
	assert (stru.base_type == null);
	assert (stru.get_cname () == "TestStructGlobal");
	assert (stru.get_free_function_cname () == null);
	assert (stru.get_dup_function_cname () == null);
	assert (stru.get_type_id () == "TYPE_TEST_STRUCT_GLOBAL");
	// (.Symbol check)
	assert (stru.is_deprecated == false);
	assert (stru.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	//assert (property.getter.get_full_name () == "TestClassGlobal.property_3");
	assert (stru.get_full_name () == "TestStructGlobal");
	assert (stru.get_filename () == "api-test.data.vapi");
	assert (stru.name == "TestStructGlobal");
	assert (stru.nspace == global_ns);
	assert (stru.package == pkg);


	Vala.List<Api.Node> methods = stru.get_children_by_type (Api.NodeType.METHOD, false);
	assert (methods.size == 1);

	Api.Method method = methods.get (0) as Api.Method;
	assert (method != null);

	// (.Method check)
	assert (method.get_cname () == "test_struct_global_method");
	//assert (method.get_dbus_name () == null);
	//assert (method.get_dbus_result_name () == null);
	//assert (method.is_dbus_visible == false);
	assert (method.base_method == null);
	assert (method.is_yields == false);
	assert (method.is_abstract == false);
	assert (method.is_virtual == false);
	assert (method.is_override == false);
	assert (method.is_static == false);
	assert (method.is_constructor == false);
	assert (method.is_inline == false);
	// (.Symbol check)
	assert (method.is_deprecated == false);
	assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (method.get_full_name () == "TestStructGlobal.method");
	assert (method.get_filename () == "api-test.data.vapi");
	assert (method.name == "method");
	assert (method.nspace == global_ns);
	assert (method.package == pkg);



	methods = stru.get_children_by_type (Api.NodeType.STATIC_METHOD, false);
	assert (methods.size == 1);

	method = methods.get (0) as Api.Method;
	assert (method != null);

	// (.Method check)
	assert (method.get_cname () == "test_struct_global_static_method");
	//assert (method.get_dbus_name () == null);
	//assert (method.get_dbus_result_name () == null);
	//assert (method.is_dbus_visible == false);
	assert (method.base_method == null);
	assert (method.is_yields == false);
	assert (method.is_abstract == false);
	assert (method.is_virtual == false);
	assert (method.is_override == false);
	assert (method.is_static == true);
	assert (method.is_constructor == false);
	assert (method.is_inline == false);
	// (.Symbol check)
	assert (method.is_deprecated == false);
	assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (method.get_full_name () == "TestStructGlobal.static_method");
	assert (method.get_filename () == "api-test.data.vapi");
	assert (method.name == "static_method");
	assert (method.nspace == global_ns);
	assert (method.package == pkg);



	methods = stru.get_children_by_type (Api.NodeType.CREATION_METHOD, false);
	bool default_constr = false;
	bool named_constr = false;

	foreach (Api.Node node in methods) {
		method = node as Api.Method;
		assert (method != null);

		switch (method.name) {
			case "TestStructGlobal":
				// (.Method check)
				assert (method.get_cname () == "test_struct_global_init");
				//assert (method.get_dbus_name () == null);
				//assert (method.get_dbus_result_name () == null);
				//assert (method.is_dbus_visible == false);
				assert (method.base_method == null);
				assert (method.is_yields == false);
				assert (method.is_abstract == false);
				assert (method.is_virtual == false);
				assert (method.is_override == false);
				assert (method.is_static == false);
				assert (method.is_constructor == true);
				assert (method.is_inline == false);
				// (.Symbol check)
				assert (method.is_deprecated == false);
				assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
				// (.Node)
				assert (method.get_full_name () == "TestStructGlobal.TestStructGlobal");
				assert (method.get_filename () == "api-test.data.vapi");
				assert (method.nspace == global_ns);
				assert (method.package == pkg);

				default_constr = true;
				break;

			case "TestStructGlobal.named":
				// (.Method check)
				assert (method.get_cname () == "test_struct_global_init_named");
				//assert (method.get_dbus_name () == null);
				//assert (method.get_dbus_result_name () == null);
				//assert (method.is_dbus_visible == false);
				assert (method.base_method == null);
				assert (method.is_yields == false);
				assert (method.is_abstract == false);
				assert (method.is_virtual == false);
				assert (method.is_override == false);
				assert (method.is_static == false);
				assert (method.is_constructor == true);
				assert (method.is_inline == false);
				// (.Symbol check)
				assert (method.is_deprecated == false);
				assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
				// (.Node)
				assert (method.get_full_name () == "TestStructGlobal.TestStructGlobal.named");
				assert (method.get_filename () == "api-test.data.vapi");
				assert (method.nspace == global_ns);
				assert (method.package == pkg);

				named_constr = true;
				break;

			default:
				assert_not_reached ();
		}
	}

	assert (default_constr == true);
	assert (named_constr == true);



	Vala.List<Api.Node> constants = stru.get_children_by_type (Api.NodeType.CONSTANT, false);
	assert (constants.size == 1);

	Api.Constant constant = constants.get (0) as Api.Constant;
	assert (constant != null);
	// (.Constant check)
	assert (constant.get_cname () == "TEST_STRUCT_GLOBAL_constant");
	// (.Symbol check)
	assert (constant.is_deprecated == false);
	assert (constant.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (constant.get_full_name () == "TestStructGlobal.constant");
	assert (constant.get_filename () == "api-test.data.vapi");
	assert (constant.name == "constant");
	assert (constant.nspace == global_ns);
	assert (constant.package == pkg);



	Vala.List<Api.Node> fields = stru.get_children_by_type (Api.NodeType.FIELD, false);

	bool field1 = false;
	bool field2 = false;
	foreach (Api.Node node in fields) {
		Api.Field field = node as Api.Field;
		assert (field != null);

		switch (field.name) {
		case "field1":
			// (.Field check)
			assert (field.get_cname () == "test_struct_global_field1");
			assert (field.is_static == true);
			assert (field.is_volatile == false);
			// (.Symbol check)
			assert (field.is_deprecated == false);
			assert (field.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (field.get_full_name () == "TestStructGlobal.field1");
			assert (field.get_filename () == "api-test.data.vapi");
			assert (field.nspace == global_ns);
			assert (field.package == pkg);

			field1 = true;
			break;

		case "field2":
			// (.Field check)
			assert (field.get_cname () == "field2");
			assert (field.is_static == false);
			assert (field.is_volatile == false);
			// (.Symbol check)
			assert (field.is_deprecated == false);
			assert (field.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (field.get_full_name () == "TestStructGlobal.field2");
			assert (field.get_filename () == "api-test.data.vapi");
			assert (field.nspace == global_ns);
			assert (field.package == pkg);

			field2 = true;
			break;

		default:
			assert_not_reached ();
		}
	}

	assert (field1 == true);
	assert (field2 == true);


	Vala.List<Api.Node> properties = stru.get_children_by_type (Api.NodeType.PROPERTY, false);
	bool prop1 = false;
	bool prop2 = false;
	bool prop3 = false;

	foreach (Api.Node node in properties) {
		Api.Property property = node as Api.Property;
		assert (property != null);

		switch (property.name) {
		case "property_1":
			assert (property.get_cname () == "property-1");
			assert (property.property_type != null);
			assert (property.is_virtual == false);
			assert (property.is_abstract == false);
			assert (property.is_override == false);
			assert (property.is_dbus_visible == true);
			assert (property.setter != null);
			assert (property.getter != null);
			assert (property.base_property == null);
			// (.Symbol check)
			assert (property.is_deprecated == false);
			assert (property.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (property.get_full_name () == "TestStructGlobal.property_1");
			assert (property.get_filename () == "api-test.data.vapi");
			assert (property.nspace == global_ns);
			assert (property.package == pkg);


			assert (property.getter.get_cname () == "test_struct_global_get_property_1");
			assert (property.getter.is_construct == false);
			assert (property.getter.is_set == false);
			assert (property.getter.is_get == true);
			assert (property.getter.is_owned == false);
			// (.Symbol check)
			assert (property.getter.is_deprecated == false);
			assert (property.getter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestInterfaceGlobal.property_2");
			assert (property.getter.get_filename () == "api-test.data.vapi");
			assert (property.getter.nspace == global_ns);
			assert (property.getter.package == pkg);


			assert (property.setter.get_cname () == "test_struct_global_set_property_1");
			assert (property.setter.is_construct == false);
			assert (property.setter.is_get == false);
			assert (property.setter.is_set == true);
			assert (property.setter.is_owned == false);
			// (.Symbol check)
			assert (property.setter.is_deprecated == false);
			assert (property.setter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestInterfaceGlobal.property_2");
			assert (property.setter.get_filename () == "api-test.data.vapi");
			assert (property.setter.nspace == global_ns);
			assert (property.setter.package == pkg);

			prop1 = true;
			break;

		case "property_2":
			assert (property.get_cname () == "property-2");
			assert (property.property_type != null);
			assert (property.is_virtual == false);
			assert (property.is_abstract == false);
			assert (property.is_override == false);
			assert (property.is_dbus_visible == true);
			assert (property.setter == null);
			assert (property.getter != null);
			assert (property.base_property == null);
			// (.Symbol check)
			assert (property.is_deprecated == false);
			assert (property.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (property.get_full_name () == "TestStructGlobal.property_2");
			assert (property.get_filename () == "api-test.data.vapi");
			assert (property.nspace == global_ns);
			assert (property.package == pkg);

			assert (property.getter.get_cname () == "test_struct_global_get_property_2");
			assert (property.getter.is_construct == false);
			assert (property.getter.is_set == false);
			assert (property.getter.is_get == true);
			assert (property.getter.is_owned == false);
			// (.Symbol check)
			assert (property.getter.is_deprecated == false);
			assert (property.getter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestInterfaceGlobal.property_2");
			assert (property.getter.get_filename () == "api-test.data.vapi");
			assert (property.getter.nspace == global_ns);
			assert (property.getter.package == pkg);

			prop2 = true;
			break;

		case "property_3":
			assert (property.get_cname () == "property-3");
			assert (property.property_type != null);
			assert (property.is_virtual == false);
			assert (property.is_abstract == false);
			assert (property.is_override == false);
			assert (property.is_dbus_visible == true);
			assert (property.setter != null);
			assert (property.getter != null);
			assert (property.base_property == null);
			// (.Symbol check)
			assert (property.is_deprecated == false);
			assert (property.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (property.get_full_name () == "TestStructGlobal.property_3");
			assert (property.get_filename () == "api-test.data.vapi");
			assert (property.nspace == global_ns);
			assert (property.package == pkg);

			assert (property.getter.get_cname () == "test_struct_global_get_property_3");
			assert (property.getter.is_construct == false);
			assert (property.getter.is_set == false);
			assert (property.getter.is_get == true);
			assert (property.getter.is_owned == true);
			// (.Symbol check)
			assert (property.getter.is_deprecated == false);
			assert (property.getter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestInterfaceGlobal.property_3");
			assert (property.getter.get_filename () == "api-test.data.vapi");
			assert (property.getter.nspace == global_ns);
			assert (property.getter.package == pkg);


			assert (property.setter.get_cname () == "test_struct_global_set_property_3");
			assert (property.setter.is_construct == false);
			assert (property.setter.is_get == false);
			assert (property.setter.is_set == true);
			assert (property.setter.is_owned == false);
			// (.Symbol check)
			assert (property.setter.is_deprecated == false);
			assert (property.setter.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			//assert (property.getter.get_full_name () == "TestInterfaceGlobal.property_3");
			assert (property.setter.get_filename () == "api-test.data.vapi");
			assert (property.setter.nspace == global_ns);
			assert (property.setter.package == pkg);


			prop3 = true;
			break;

		default:
			assert_not_reached ();
		}
	}
	assert (prop1);
	assert (prop2);
	assert (prop3);


	Api.NodeType[] forbidden = {
			Api.NodeType.CLASS,
			Api.NodeType.DELEGATE,
			Api.NodeType.ENUM,
			Api.NodeType.ENUM_VALUE,
			Api.NodeType.ERROR_CODE,
			Api.NodeType.ERROR_DOMAIN,
			Api.NodeType.FORMAL_PARAMETER,
			Api.NodeType.INTERFACE,
			Api.NodeType.NAMESPACE,
			Api.NodeType.PACKAGE,
			Api.NodeType.PROPERTY_ACCESSOR,
			Api.NodeType.SIGNAL,
			Api.NodeType.STRUCT,
			Api.NodeType.TYPE_PARAMETER
		};

	Vala.List<Api.Node> nodes = stru.get_children_by_types (forbidden, false);
	assert (nodes.size == 0);
}


public static void param_test (Api.Namespace ns, Api.Package pkg) {
	Vala.List<Api.Node> methods = ns.get_children_by_type (Api.NodeType.METHOD, false);

	bool func1 = false;
	bool func2 = false;
	bool func3 = false;
	bool func3a = false;
	bool func4 = false;
	bool func4a = false;
	bool func5 = false;
	bool func6 = false;
	bool func7 = false;
	bool func8 = false;
	bool func9 = false;
	bool func10 = false;
	bool func11 = false;
	bool func12 = false;
	bool func13 = false;
	bool func14 = false;

	foreach (Api.Node node in methods) {
		Api.Method m = node as Api.Method;
		assert (m != null);

		Api.NodeType[] forbidden = {
				Api.NodeType.CLASS,
				Api.NodeType.CONSTANT,
				Api.NodeType.CREATION_METHOD,
				Api.NodeType.DELEGATE,
				Api.NodeType.ENUM,
				Api.NodeType.ENUM_VALUE,
				Api.NodeType.ERROR_CODE,
				Api.NodeType.ERROR_DOMAIN,
				Api.NodeType.FIELD,
				Api.NodeType.INTERFACE,
				Api.NodeType.METHOD,
				Api.NodeType.NAMESPACE,
				Api.NodeType.PACKAGE,
				Api.NodeType.PROPERTY,
				Api.NodeType.PROPERTY_ACCESSOR,
				Api.NodeType.SIGNAL,
				Api.NodeType.STATIC_METHOD,
				Api.NodeType.STRUCT,
				Api.NodeType.TYPE_PARAMETER
			};

		Vala.List<Api.Node> nodes = m.get_children_by_types (forbidden, false);
		assert (nodes.size == 0);

		Vala.List<Api.Node> params = m.get_children_by_type (Api.NodeType.FORMAL_PARAMETER, false);

		switch (m.name) {
		case "test_function_param_1":
			assert (params.size == 0);

			func1 = true;
			break;

		case "test_function_param_2":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_2.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Struct);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);

			func2 = true;
			break;

		case "test_function_param_3":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == true);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_3.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Struct);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);

			func3 = true;
			break;

		case "test_function_param_3a":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == true);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_3a.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Class);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "string");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == true);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == true);

			func3a = true;
			break;

		case "test_function_param_4":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == true);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_4.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Struct);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);

			func4 = true;
			break;

		case "test_function_param_4a":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == true);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_4a.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Class);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "string");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == true);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == true);

			func4a = true;
			break;

		case "test_function_param_5":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_5.o");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "o");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Class);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "GLib.Object");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == true);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);

			func5 = true;
			break;

		case "test_function_param_6":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_6.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Struct);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == true);

			func6 = true;
			break;

		case "test_function_param_7":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == true);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == null);
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == null);
			// param type:
			assert (param.parameter_type.data_type == null);

			func7 = true;
			break;

		case "test_function_param_8":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value != null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == true);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_8.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Struct);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);

			func8 = true;
			break;

		case "test_function_param_9":
			assert (params.size == 7);

			Api.Parameter? param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_9.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Struct);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);



			param = params.get (1) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == true);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_9.b");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "b");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Struct);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);



			param = params.get (2) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == true);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_9.c");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "c");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Struct);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);



			param = params.get (3) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_9.d");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "d");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Class);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "GLib.Object");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == true);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);



			param = params.get (4) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_9.e");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "e");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Struct);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == true);



			param = params.get (5) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value != null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == true);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_9.f");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "f");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Struct);
			assert (((Api.Symbol) param.parameter_type.data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);



			param = params.get (6) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == true);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == null);
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == null);
			// param type:
			assert (param.parameter_type.data_type == null);

			func9 = true;
			break;

		case "test_function_param_10":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_10.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Pointer);
			assert (((Api.Pointer) param.parameter_type.data_type).data_type is Api.TypeReference);
			assert (((Api.TypeReference) ((Api.Pointer) param.parameter_type.data_type).data_type).data_type is Api.Struct);
			assert (((Api.Struct) ((Api.TypeReference) ((Api.Pointer) param.parameter_type.data_type).data_type).data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);

			func10 = true;
			break;

		case "test_function_param_11":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_11.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Pointer);
			assert (((Api.Pointer) param.parameter_type.data_type).data_type is Api.Pointer);
			assert (((Api.Pointer) ((Api.Pointer) param.parameter_type.data_type).data_type).data_type is Api.TypeReference);
			assert (((Api.TypeReference) ((Api.Pointer) ((Api.Pointer) param.parameter_type.data_type).data_type).data_type).data_type is Api.Struct);
			assert (((Api.Struct) ((Api.TypeReference) ((Api.Pointer) ((Api.Pointer) param.parameter_type.data_type).data_type).data_type).data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);

			func11 = true;
			break;

		case "test_function_param_12":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_12.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Array);
			//assert (((Api.Array) param.parameter_type.data_type).dimension == 1);
			assert (((Api.Array) param.parameter_type.data_type).data_type is Api.TypeReference);
			assert (((Api.TypeReference) ((Api.Array) param.parameter_type.data_type).data_type).data_type is Api.Struct);
			assert (((Api.Struct) ((Api.TypeReference) ((Api.Array) param.parameter_type.data_type).data_type).data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);

			func12 = true;
			break;

		case "test_function_param_13":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_13.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Array);
			//assert (((Api.Array) param.parameter_type.data_type).dimension == 2);
			assert (((Api.Array) param.parameter_type.data_type).data_type is Api.TypeReference);
			assert (((Api.TypeReference) ((Api.Array) param.parameter_type.data_type).data_type).data_type is Api.Struct);
			assert (((Api.Struct) ((Api.TypeReference) ((Api.Array) param.parameter_type.data_type).data_type).data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);

			func13 = true;
			break;

		case "test_function_param_14":
			assert (params.size == 1);

			Api.Parameter param = params.get (0) as Api.Parameter;
			assert (param != null);
			// (.Parameter)
			assert (param.default_value == null);
			assert (param.is_out == false);
			assert (param.is_ref == false);
			assert (param.has_default_value == false);
			assert (param.parameter_type != null);
			assert (param.ellipsis == false);
			// (.Symbol check)
			assert (param.is_deprecated == false);
			assert (param.accessibility == Vala.SymbolAccessibility.PUBLIC);
			// (.Node)
			assert (param.get_full_name () == "ParamTest.test_function_param_14.a");
			assert (param.get_filename () == "api-test.data.vapi");
			assert (param.nspace == ns);
			assert (param.package == pkg);
			assert (param.name == "a");
			// param type:
			assert (param.parameter_type.data_type != null);
			assert (param.parameter_type.data_type is Api.Array);
			//assert (((Api.Array) param.parameter_type.data_type).dimension == 1);
			assert (((Api.Array) param.parameter_type.data_type).data_type is Api.Array);
			//assert (((Api.Array) ((Api.Array) param.parameter_type.data_type).data_type).dimension == 1);
			assert (((Api.Array) ((Api.Array) param.parameter_type.data_type).data_type).data_type is Api.TypeReference);
			assert (((Api.TypeReference) ((Api.Array) ((Api.Array) param.parameter_type.data_type).data_type).data_type).data_type is Api.Struct);
			assert (((Api.Struct) ((Api.TypeReference) ((Api.Array) ((Api.Array) param.parameter_type.data_type).data_type).data_type).data_type).get_full_name () == "int");
			assert (param.parameter_type.get_type_arguments ().size == 0);
			assert (param.parameter_type.is_owned == false);
			assert (param.parameter_type.is_unowned == false);
			assert (param.parameter_type.is_weak == false);
			assert (param.parameter_type.is_dynamic == false);
			assert (param.parameter_type.is_nullable == false);

			func14 = true;
			break;

		default:
			assert_not_reached ();
		}
	}

	assert (func1 == true);
	assert (func2 == true);
	assert (func3 == true);
	assert (func3a == true);
	assert (func4 == true);
	assert (func4a == true);
	assert (func5 == true);
	assert (func6 == true);
	assert (func7 == true);
	assert (func8 == true);
	assert (func9 == true);
	assert (func10 == true);
	assert (func11 == true);
	assert (func12 == true);
	assert (func13 == true);
	//assert (func14 == true);


	Api.NodeType[] forbidden = {
			Api.NodeType.CLASS,
			Api.NodeType.CONSTANT,
			Api.NodeType.CREATION_METHOD,
			Api.NodeType.DELEGATE,
			Api.NodeType.ENUM,
			Api.NodeType.ENUM_VALUE,
			Api.NodeType.ERROR_CODE,
			Api.NodeType.ERROR_DOMAIN,
			Api.NodeType.FIELD,
			Api.NodeType.FORMAL_PARAMETER,
			Api.NodeType.INTERFACE,
			Api.NodeType.NAMESPACE,
			Api.NodeType.PACKAGE,
			Api.NodeType.PROPERTY,
			Api.NodeType.PROPERTY_ACCESSOR,
			Api.NodeType.SIGNAL,
			Api.NodeType.STATIC_METHOD,
			Api.NodeType.STRUCT,
			Api.NodeType.TYPE_PARAMETER
		};

	Vala.List<Api.Node> nodes = ns.get_children_by_types (forbidden, false);
	assert (nodes.size == 0);
}


public static void return_test (Api.Namespace ns, Api.Package pkg) {
	Vala.List<Api.Node> methods = ns.get_children_by_type (Api.NodeType.METHOD, false);

	bool func1 = false;
	bool func2 = false;
	bool func3 = false;
	bool func4 = false;
	bool func5 = false;
	bool func6 = false;
	bool func7 = false;
	bool func8 = false;
	bool func9 = false;

	foreach (Api.Node node in methods) {
		Api.Method m = node as Api.Method;
		assert (m != null);

		Api.NodeType[] forbidden = {
				Api.NodeType.CLASS,
				Api.NodeType.CONSTANT,
				Api.NodeType.CREATION_METHOD,
				Api.NodeType.DELEGATE,
				Api.NodeType.ENUM,
				Api.NodeType.ENUM_VALUE,
				Api.NodeType.ERROR_CODE,
				Api.NodeType.ERROR_DOMAIN,
				Api.NodeType.FIELD,
				Api.NodeType.INTERFACE,
				Api.NodeType.METHOD,
				Api.NodeType.NAMESPACE,
				Api.NodeType.PACKAGE,
				Api.NodeType.PROPERTY,
				Api.NodeType.PROPERTY_ACCESSOR,
				Api.NodeType.SIGNAL,
				Api.NodeType.STATIC_METHOD,
				Api.NodeType.STRUCT,
				Api.NodeType.FORMAL_PARAMETER,
				Api.NodeType.TYPE_PARAMETER
			};

		Vala.List<Api.Node> nodes = m.get_children_by_types (forbidden, false);
		assert (nodes.size == 0);

		Api.TypeReference? ret = m.return_type;
		assert (ret != null);

		switch (m.name) {
		case "test_function_1":
			assert (ret.data_type == null);
			assert (ret.get_type_arguments ().size == 0);
			assert (ret.is_owned == false);
			assert (ret.is_unowned == false);
			assert (ret.is_weak == false);
			assert (ret.is_dynamic == false);
			assert (ret.is_nullable == false);

			func1 = true;
			break;

		case "test_function_2":
			assert (ret.data_type is Api.Struct);
			assert (((Api.Struct) ret.data_type).get_full_name () == "int");
			assert (ret.get_type_arguments ().size == 0);
			assert (ret.is_owned == false);
			assert (ret.is_unowned == false);
			assert (ret.is_weak == false);
			assert (ret.is_dynamic == false);
			assert (ret.is_nullable == false);

			func2 = true;
			break;

		case "test_function_3":
			assert (ret.data_type is Api.Struct);
			assert (((Api.Struct) ret.data_type).get_full_name () == "int");
			assert (ret.get_type_arguments ().size == 0);
			assert (ret.is_owned == false);
			assert (ret.is_unowned == false);
			assert (ret.is_weak == false);
			assert (ret.is_dynamic == false);
			assert (ret.is_nullable == true);

			func3 = true;
			break;

		case "test_function_4":
			assert (ret.data_type is Api.Class);
			assert (((Api.Class) ret.data_type).get_full_name () == "string");
			assert (ret.get_type_arguments ().size == 0);
			assert (ret.is_owned == false);
			assert (ret.is_unowned == true);
			assert (ret.is_weak == false);
			assert (ret.is_dynamic == false);
			assert (ret.is_nullable == false);

			func4 = true;
			break;

		case "test_function_5":
			assert (ret.data_type is Api.Pointer);
			assert (((Api.Pointer) ret.data_type).data_type is Api.TypeReference);
			assert (((Api.TypeReference) ((Api.Pointer) ret.data_type).data_type).data_type is Api.Struct);
			assert (((Api.Struct) ((Api.TypeReference) ((Api.Pointer) ret.data_type).data_type).data_type).get_full_name () == "int");
			assert (ret.get_type_arguments ().size == 0);
			assert (ret.is_owned == false);
			assert (ret.is_unowned == false);
			assert (ret.is_weak == false);
			assert (ret.is_dynamic == false);
			assert (ret.is_nullable == false);

			func5 = true;
			break;

		case "test_function_6":
			assert (ret.data_type is Api.Pointer);
			assert (((Api.Pointer) ret.data_type).data_type is Api.Pointer);
			assert (((Api.Pointer) ((Api.Pointer) ret.data_type).data_type).data_type is Api.TypeReference);
			assert (((Api.TypeReference) ((Api.Pointer) ((Api.Pointer) ret.data_type).data_type).data_type).data_type is Api.Struct);
			assert (((Api.Struct) ((Api.TypeReference) ((Api.Pointer) ((Api.Pointer) ret.data_type).data_type).data_type).data_type).get_full_name () == "int");
			assert (ret.get_type_arguments ().size == 0);
			assert (ret.is_owned == false);
			assert (ret.is_unowned == false);
			assert (ret.is_weak == false);
			assert (ret.is_dynamic == false);
			assert (ret.is_nullable == false);

			func6 = true;
			break;

		case "test_function_7":
			assert (ret.data_type is Api.Array);
			assert (((Api.Array) ret.data_type).data_type is Api.TypeReference);
			assert (((Api.TypeReference) ((Api.Array) ret.data_type).data_type).data_type is Api.Struct);
			assert (((Api.Struct) ((Api.TypeReference) ((Api.Array) ret.data_type).data_type).data_type).get_full_name () == "int");
			assert (ret.get_type_arguments ().size == 0);
			assert (ret.is_owned == false);
			assert (ret.is_unowned == false);
			assert (ret.is_weak == false);
			assert (ret.is_dynamic == false);
			assert (ret.is_nullable == false);

			func7 = true;
			break;

		case "test_function_8":
			assert (ret.data_type is Api.Array);
			//assert (((Api.Array) ret.data_type).dimension == 1);
			assert (((Api.Array) ret.data_type).data_type is Api.TypeReference);
			assert (((Api.TypeReference) ((Api.Array) ret.data_type).data_type).data_type is Api.Struct);
			assert (((Api.Struct) ((Api.TypeReference) ((Api.Array) ret.data_type).data_type).data_type).get_full_name () == "int");
			assert (ret.get_type_arguments ().size == 0);
			assert (ret.is_owned == false);
			assert (ret.is_unowned == false);
			assert (ret.is_weak == false);
			assert (ret.is_dynamic == false);
			assert (ret.is_nullable == false);

			func8 = true;
			break;

		case "test_function_9":
			assert (ret.data_type is Api.Array);
			//assert (((Api.Array) ret.data_type).dimension == 1);
			assert (((Api.Array) ret.data_type).data_type is Api.Array);
			//assert (((Api.Array) ((Api.Array) ret.data_type).data_type).dimension == 1);
			assert (((Api.Array) ((Api.Array) ret.data_type).data_type).data_type is Api.TypeReference);
			assert (((Api.TypeReference) ((Api.Array) ((Api.Array) ret.data_type).data_type).data_type).data_type is Api.Struct);
			assert (((Api.Struct) ((Api.TypeReference) ((Api.Array) ((Api.Array) ret.data_type).data_type).data_type).data_type).get_full_name () == "int");
			assert (ret.get_type_arguments ().size == 0);
			assert (ret.is_owned == false);
			assert (ret.is_unowned == false);
			assert (ret.is_weak == false);
			assert (ret.is_dynamic == false);
			assert (ret.is_nullable == false);

			func9 = true;
			break;

		default:
			assert_not_reached ();
		}
	}

	assert (func1 == true);
	assert (func2 == true);
	assert (func3 == true);
	assert (func4 == true);
	assert (func5 == true);
	assert (func6 == true);
	assert (func7 == true);
	assert (func8 == true);
	//assert (func9 == true);
}


public static void version_test (Api.Namespace ns, Api.Package pkg) {
	Vala.List<Api.Node> methods = ns.get_children_by_type (Api.NodeType.METHOD, false);

	bool func1 = false;
	bool func2 = false;
	bool func3 = false;
	bool func4 = false;
	bool func5 = false;
	bool func6 = false;
	bool func7 = false;
	bool func8 = false;
	bool func9 = false;

	foreach (Api.Node node in methods) {
		Api.Method m = node as Api.Method;
		assert (m != null);

		Api.NodeType[] forbidden = {
				Api.NodeType.CLASS,
				Api.NodeType.CONSTANT,
				Api.NodeType.CREATION_METHOD,
				Api.NodeType.DELEGATE,
				Api.NodeType.ENUM,
				Api.NodeType.ENUM_VALUE,
				Api.NodeType.ERROR_CODE,
				Api.NodeType.ERROR_DOMAIN,
				Api.NodeType.FIELD,
				Api.NodeType.INTERFACE,
				Api.NodeType.METHOD,
				Api.NodeType.NAMESPACE,
				Api.NodeType.PACKAGE,
				Api.NodeType.PROPERTY,
				Api.NodeType.PROPERTY_ACCESSOR,
				Api.NodeType.SIGNAL,
				Api.NodeType.STATIC_METHOD,
				Api.NodeType.STRUCT,
				Api.NodeType.FORMAL_PARAMETER,
				Api.NodeType.TYPE_PARAMETER
			};

		Vala.List<Api.Node> nodes = m.get_children_by_types (forbidden, false);
		assert (nodes.size == 0);

		Api.TypeReference? ret = m.return_type;
		assert (ret != null);

		Api.Attribute? dattr = m.get_attribute ("Deprecated");
		Api.Attribute? vattr = m.get_attribute ("Version");
		Vala.Attribute? attr_deprecated = (dattr != null ? dattr.data as Vala.Attribute : null);
		Vala.Attribute? attr_version = (vattr != null ? vattr.data as Vala.Attribute : null);

		switch (m.name) {
		case "test_function_1":
			assert (m.get_attribute ("Deprecated") != null);
			assert (m.is_deprecated == true);

			func1 = true;
			break;

		case "test_function_2":
			assert (attr_deprecated.get_string ("since") == "1.0");
			assert (attr_deprecated.get_string ("replacement") == "test_function_4");
			assert (m.is_deprecated == true);

			func2 = true;
			break;

		case "test_function_3":
			//assert (m.get_attribute ("Experimental") != null);

			func3 = true;
			break;

		case "test_function_4":
			assert (attr_version.get_string ("since") == "2.0");
			assert (m.is_deprecated == false);

			func4 = true;
			break;

		case "test_function_5":
			assert (attr_version.get_bool ("deprecated") == true);
			assert (m.is_deprecated == true);

			func5 = true;
			break;

		case "test_function_6":
			assert (attr_version.get_bool ("deprecated") == true);
			assert (attr_version.get_string ("deprecated_since") == "2.0");
			assert (attr_version.get_string ("replacement") == "test_function_4");
			assert (attr_version.get_string ("since") == "1.0");
			assert (m.is_deprecated == true);

			func6 = true;
			break;

		case "test_function_7":
			assert (attr_version.get_string ("deprecated_since") == "2.0");
			assert (m.is_deprecated == true);

			func7 = true;
			break;

		case "test_function_8":
			assert (attr_version.get_bool ("deprecated") == false);
			assert (m.is_deprecated == false);

			func8 = true;
			break;

		case "test_function_9":
			//assert (attr_version.get_bool ("experimental") == true);

			func9 = true;
			break;

		default:
			assert_not_reached ();
		}
	}

	assert (func1 == true);
	assert (func2 == true);
	assert (func3 == true);
	assert (func4 == true);
	assert (func5 == true);
	assert (func6 == true);
	assert (func7 == true);
	assert (func8 == true);
	assert (func9 == true);
}


public static void test_global_ns (Api.Namespace global_ns, Api.Package pkg) {
	Vala.List<Api.Node> methods = global_ns.get_children_by_type (Api.NodeType.METHOD, false);
	assert (methods.size == 1);

	Api.Method method = methods.get (0) as Api.Method;
	assert (method != null);
	// (.Method check)
	assert (method.get_cname () == "test_function_global");
	//assert (method.get_dbus_name () == null);
	//assert (method.get_dbus_result_name () == null);
	//assert (method.is_dbus_visible == false);
	assert (method.base_method == null);
	assert (method.is_yields == false);
	assert (method.is_abstract == false);
	assert (method.is_virtual == false);
	assert (method.is_override == false);
	assert (method.is_static == false);
	assert (method.is_constructor == false);
	assert (method.is_inline == false);
	// (.Symbol check)
	assert (method.is_deprecated == false);
	assert (method.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (method.get_full_name () == "test_function_global");
	assert (method.get_filename () == "api-test.data.vapi");
	assert (method.name == "test_function_global");
	assert (method.nspace == global_ns);
	assert (method.package == pkg);



	Vala.List<Api.Node> delegates = global_ns.get_children_by_type (Api.NodeType.DELEGATE, false);
	assert (delegates.size == 1);

	Api.Delegate del = delegates.get (0) as Api.Delegate;
	assert (del != null);
	// (.Delegate check)
	assert (del.get_cname () == "test_delegate_global");
	assert (del.is_static == false);
	// (.TypeSymbol check)
	assert (del.is_basic_type == false);
	// (.Symbol check)
	assert (del.is_deprecated == false);
	assert (del.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (del.get_full_name () == "test_delegate_global");
	assert (del.get_filename () == "api-test.data.vapi");
	assert (del.name == "test_delegate_global");
	assert (del.nspace == global_ns);
	assert (del.package == pkg);



	Vala.List<Api.Node> fields = global_ns.get_children_by_type (Api.NodeType.FIELD, false);
	assert (fields.size == 1);

	Api.Field field = fields.get (0) as Api.Field;
	assert (field != null);
	// (.Field check)
	assert (field.get_cname () == "test_field_global");
	assert (field.is_static == false);
	assert (field.is_volatile == false);
	// (.Symbol check)
	assert (field.is_deprecated == false);
	assert (field.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (field.get_full_name () == "test_field_global");
	assert (field.get_filename () == "api-test.data.vapi");
	assert (field.name == "test_field_global");
	assert (field.nspace == global_ns);
	assert (field.package == pkg);



	Vala.List<Api.Node> constants = global_ns.get_children_by_type (Api.NodeType.CONSTANT, false);
	assert (constants.size == 1);

	Api.Constant constant = constants.get (0) as Api.Constant;
	assert (constant != null);
	// (.Constant check)
	assert (constant.get_cname () == "test_const_global");
	// (.Symbol check)
	assert (constant.is_deprecated == false);
	assert (constant.accessibility == Vala.SymbolAccessibility.PUBLIC);
	// (.Node)
	assert (constant.get_full_name () == "test_const_global");
	assert (constant.get_filename () == "api-test.data.vapi");
	assert (constant.name == "test_const_global");
	assert (constant.nspace == global_ns);
	assert (constant.package == pkg);



	Vala.List<Api.Node> enums = global_ns.get_children_by_type (Api.NodeType.ENUM, false);
	assert (enums.size == 1);

	Api.Enum en = enums.get (0) as Api.Enum;
	test_enum_global (en, pkg, global_ns);



	Vala.List<Api.Node> errordomains = global_ns.get_children_by_type (Api.NodeType.ERROR_DOMAIN, false);
	assert (errordomains.size == 1);

	Api.ErrorDomain err = errordomains.get (0) as Api.ErrorDomain;
	test_erroromain_global (err, pkg, global_ns);



	Vala.List<Api.Node> classes = global_ns.get_children_by_type (Api.NodeType.CLASS, false);
	assert (classes.size == 1);

	Api.Class cl = classes.get (0) as Api.Class;
	test_class_global (cl, pkg, global_ns);



	Vala.List<Api.Node> interfaces = global_ns.get_children_by_type (Api.NodeType.INTERFACE, false);
	assert (interfaces.size == 1);

	Api.Interface iface = interfaces.get (0) as Api.Interface;
	test_interface_global (iface, pkg, global_ns);



	Vala.List<Api.Node> structs = global_ns.get_children_by_type (Api.NodeType.STRUCT, false);
	assert (structs.size == 1);

	Api.Struct stru = structs.get (0) as Api.Struct;
	test_struct_global (stru, pkg, global_ns);



	Vala.List<Api.Node> namespaces = global_ns.get_children_by_type (Api.NodeType.NAMESPACE, false);


	bool returntest = false;
	bool paramtest = false;
	bool versiontest = false;

	foreach (Api.Node node in namespaces) {
		Api.Namespace ns = node as Api.Namespace;
		assert (ns != null);

		switch (ns.name) {
		case "ParamTest":
			param_test (ns, pkg);
			paramtest = true;
			break;

		case "ReturnTest":
			return_test (ns, pkg);
			returntest = true;
			break;

		case "VersionTest":
			version_test (ns, pkg);
			versiontest = true;
			break;

		default:
			assert_not_reached ();
		}
	}

	assert (returntest == true);
	assert (paramtest == true);
	assert (versiontest == true);

}


public static void test_package_out (Api.Package pkg) {
	assert (pkg.is_package == false);
	assert (pkg.nspace == null);
	assert (pkg.package == pkg);
	//assert (pkg.get_full_name () == null);

	// TODO: check .get_source_file ()


	Vala.List<Api.Node> namespaces = pkg.get_children_by_type (Api.NodeType.NAMESPACE, false);
	assert (namespaces != null);
	assert (namespaces.size == 1);

	Api.Namespace global_ns = namespaces.get (0) as Api.Namespace;
	assert (global_ns != null);
	assert (global_ns.name == null);
	assert (global_ns.get_full_name () == null);
	assert (global_ns.is_deprecated == false);
	assert (global_ns.get_attributes ().size == 0);
	assert (global_ns.accessibility == Vala.SymbolAccessibility.PUBLIC);
	assert (global_ns.package == pkg);
	//assert (global_ns.nspace == null);

	test_global_ns (global_ns, pkg);
}


public static void test_driver () {
	var settings = new Valadoc.Settings ();
	var reporter = new ErrorReporter ();

	settings.source_files = {
			TOP_SRC_DIR + "/valadoc/tests/drivers/api-test.data.vapi"
		};

	settings._protected = false;
	settings._internal = false;
	settings._private = true;
	settings.with_deps = false;
	settings.verbose = false;
	settings.wiki_directory = null;
	settings.vapi_directories = { Path.build_filename (TOP_SRC_DIR, "vapi") };
	settings.pkg_name = "out";
	settings.path = "out";

	var context = new Vala.CodeContext ();
	Vala.CodeContext.push (context);

	TreeBuilder builder = new TreeBuilder ();
	Api.Tree? doctree = builder.build (settings, reporter);
	assert (reporter.errors == 0);
	assert (doctree != null);
	SymbolResolver resolver = new SymbolResolver (builder);
	doctree.accept (resolver);


	bool tmp = doctree.create_tree ();
	assert (tmp);


	Vala.Collection<Api.Package> packages = doctree.get_package_list ();
	assert (packages != null);

	bool glib = false;
	bool gobj = false;
	bool test = false;

	foreach (Api.Package pkg in packages) {
		switch (pkg.name) {
		case "glib-2.0":
			assert (pkg.is_package);
			glib = true;
			break;

		case "gobject-2.0":
			assert (pkg.is_package);
			gobj = true;
			break;

		case "@out":
			test_package_out (pkg);
			test = true;
			break;

		default:
			assert_not_reached ();
		}
	}

	assert (glib == true);
	assert (gobj == true);
	assert (test == true);

	Vala.CodeContext.pop ();
}


