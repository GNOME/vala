GIDL metadata format
====================

This section describes the format of .metadata files as used by
*vapigen* as additional information for .vapi file generation. Some of
the information specified in the metadata can be used to set :doc:`attributes`
as well.

Comments
--------

Comments start with a ``#`` and end at the end of a line. For example:

::

   # this is a comment

Other Lines
-----------

Every non-comment line in the file is made of up two sections: the
specifier, and the parameters.

The specifier is the first text to appear on the line, and it specifies
what the rest of the line will be modifying.

The parameters are a space separated list of a parameter name, followed
by an equals sign and the value enclosed in quotes.

For example, this line sets *parameter1* and *parameter2* on *foo.bar*:

::

   foo.bar parameter1="value" parameter2="value"

Specifiers
----------

Specifiers always use the C name for whatever it is you are modifying.
For example if your namespace is *Foo*, and the Vala name for the type
is *Bar*, then you would use ``FooBar``.

Specifiers may also use wildcards, and all items that partially match
the specifier will be selected. For example:

::

   *.klass hidden="1"

will hide the *klass* field in all types.

Specifying Different Things
---------------------------

To specify a:

==================== ===========================
Function             ``name_of_function``
Type                 ``Type``
Property             ``Type:property_name``
Signal               ``Type::signal_name``
Field                ``Type.field_name``
Parameter (Function) ``name_of_function.param``
Parameter (Delegate) ``DelegateName.param``
Parameter (Signal)   ``Type::signal_name.param``
==================== ===========================

For example, hiding a symbol:

======== ============================
Type     ``Foo hidden="1"``
Function ``some_function hidden="1"``
Field    ``Foo.bar hidden="1"``
======== ============================

Properties Reference
--------------------

The format for the entries will be like so

.. list-table::
   :header-rows: 1

   * - Name
     - Applies To
     - Values
     - Description
   * - ``foobar``
     - Signal, Function, Class, Struct, etc
     - The acceptable values
     - The description goes here.

And in alphabetical order:

.. list-table::
   :header-rows: 1

   * - Name
     - Applies To
     - Values
     - Description
   * - ``abstract``
     - Class, Function
     - 0, 1
     -
   * - ``accessor_method``
     - Property
     - 0, 1
     -
   * - ``array_length_cname``
     - Field
     - C identifier
     -
   * - ``array_length_pos``
     - Parameter (Function)
     - Double (position between two Vala parameters)
     - Sets the position of the length for the parameter, length needs to be hidden separately.
   * - ``array_length_type``
     - Parameter (Function), Function (returning an array), Field
     - C type
     -
   * - ``array_null_terminated``
     - Function (returning an array), Parameter (Function), Field
     - 0, 1
     -
   * - ``async``
     - Function
     - 0, 1
     - Force async function, even if it doesn't end in ``_async``
   * - ``base_class``
     - Class
     - C type
     - Marks the base class for the type
   * - ``base_type``
     - Struct
     - Vala type
     - Marks the struct as inheriting
   * - ``cheader_filename``
     - Anything (except parameters)
     - Header include path
     - Compiler will add the  specified header when thing is used.
   * - ``common_prefix``
     - Enum
     - String
     - Removes a common prefix from enumeration values
   * - ``const_cname``
     - Class (non-GObject)
     - C type
     -
   * - ``copy_function``
     - Class (non-GObject)
     - C function
     -
   * - ``cprefix``
     - Module
     - String
     -
   * - ``ctype``
     - Parameter (Function), Field
     - C type
     -
   * - ``default_value``
     - Parameter (Function)
     - Any Vala value that would be valid for the type
     - Sets the default value for a parameter.
   * - ``delegate_target_pos``
     - Parameter (Function)
     - Double (position between two Vala parameters)
     -
   * - ``deprecated``
     - Anything (except parameters)
     - 0, 1
     - Marks the thing as deprecated
   * - ``deprecated_since``
     - Anything (except parameters)
     - Version
     - Marks the thing as deprecated
   * - ``ellipsis``
     - Function
     - 0, 1
     - Marks that the function has a variable argument list
   * - ``errordomain``
     - Enum
     - 0, 1
     - Marks the enumeration as a GError domain
   * - ``finish_name``
     - Function
     - C function name
     - Sets custom asynchronous finish function
   * - ``free_function``
     - Class (non-GObject)
     - C function name
     - Sets a free function for the struct
   * - ``gir_namespace``
     - Module
     - String
     -
   * - ``gir_version``
     - Module
     - Version
     -
   * - ``has_copy_function``
     - Struct
     - 0, 1
     - marks the struct as having a copy function
   * - ``has_destroy_function``
     - Struct
     - 0, 1
     -
   * - ``has_emitter``
     - Signal
     - 0, 1
     -
   * - ``has_target``
     - Delegate
     - 0, 1
     -
   * - ``has_type_id``
     - Class, Enum, Struct
     - 0, 1
     - Marks whether a GType is registered for this thing
   * - ``hidden``
     - Anything
     - 0, 1
     - Causes the selected thing to not be output in the vapi file.
   * - ``immutable``
     - Struct
     - 0, 1
     - Marks the struct as immutable
   * - ``instance_pos``
     - Delegate (Position between two Vala parameters)
     - Double
     -
   * - ``is_array``
     - Function (returning an array), Parameter, Field
     - 0, 1
     - Marks the thing as an array
   * - ``is_fundamental``
     - Class (non-GObject)
     - 0, 1
     -
   * - ``is_immutable``
     - Class (non-GObject)
     - 0, 1
     -
   * - ``is_out``
     - Parameter
     - 0, 1
     - Marks the parameter as "out"
   * - ``is_ref``
     - Parameter
     - 0, 1
     - Marks the parameter as "ref"
   * - ``is_value_type``
     - Struct, Union
     - 0, 1
     - Marks type as a value type (aka struct)
   * - ``lower_case_cprefix``
     - Module
     - String
     -
   * - ``lower_case_csuffix``
     - Interface
     - String
     -
   * - ``name``
     - Any Type, Function, Signal
     - Vala identifier
     - Changes the name of the thing, does not change namespace
   * - ``namespace``
     - Any Type
     - String
     - Changes the namespace of the thing
   * - ``namespace_name``
     - Signal Parameter
     - String
     - Specify the namespace of the parameter type indicated with type_name
   * - ``no_array_length``
     - Function (returning an array), Parameter (Function, Delegate)
     - 0, 1
     - Does not implicitly pass/return array length to/from function
   * - ``nullable``
     - Function (having a return value), Parameter
     - 0, 1
     - Marks the value as nullable
   * - ``owned_get``
     - Property
     - 0, 1
     -
   * - ``parent``
     - Any module member
     - String (Namespace)
     - Strip namespace prefix from symbol and put it into given sub-namespace
   * - ``printf_format``
     - Function
     - 0, 1
     -
   * - ``rank``
     - Struct
     - Integer
     -
   * - ``ref_function``
     - Class (non-GObject)
     - C function name
     -
   * - ``ref_function_void``
     - Class (non-GObject)
     - 0, 1
     -
   * - ``rename_to``
     - Any Type
     - Vala
     - Renames the identifier type to something else, ie fooFloat to float (not exactly the same as ``name``, AFAIK name changes both the vala name and the cname. rename_to adds the required code so that when the rename_to'ed type is used, the c type is used)
   * - ``replacement``
     - Anything (except parameters)
     - The thing that replaces this
     - Specifies a replacement for a deprecated symbol
   * - ``sentinel``
     - Function (with ellipsis)
     - C value
     - The sentinel value marking the end of the vararg list
   * - ``simple_type``
     - Struct
     - 0, 1
     - Marks the struct as being a simple type, like int |
   * - ``takes_ownership``
     - Parameter (Function, Delegate)
     - 0, 1
     -
   * - ``throws``
     - Function
     - 0, 1
     - Marks that the function should use an out parameter instead of throwing an error
   * - ``to_string``
     - Enum
     - C function name
     -
   * - ``transfer_ownership``
     - Function/Delegate/Signal (having a return value), Parameter Signal)
     - 0, 1
     - Transfers ownership of the value
   * - ``type_arguments``
     - Function/Delegate/Signal (having a return value), Property, Field, Parameter
     - Vala types, comma separated
     - Restricts the generic type of the thing
   * - ``type_check_function``
     - Class (GObject)
     - C function/macro name
     -
   * - ``type_id``
     - Struct, Class (GObject)
     - C macro
     -
   * - ``type_name``
     - Function (having a return value), Property, Parameter, Field
     - Vala type name
     - Changes the type of the selected thing. Overwrites old type, so "type_name" must be before any other type modifying metadata
   * - ``type_parameters``
     - Delegate, Class (non-GObject)
     - Vala generic type parameters, e.g. T, comma separated
     -
   * - ``unref_function``
     - Class (non-GObject)
     - C function name
     -
   * - ``value_owned``
     - Parameter (Function)
     - 0, 1
     -
   * - ``vfunc_name``
     - Function
     - C function pointer name
     -
   * - ``virtual``
     - Function
     - 0, 1
     -
   * - ``weak``
     - Field
     - 0, 1
     - Marks the field as weak

Examples
--------

Demonstrating...

::

   // ...
