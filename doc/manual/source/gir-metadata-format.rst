GIR metadata format
===================

The ``GIR`` format actually has a lot of information for generating
bindings, but it's a different language than Vala. Therefore, it's
almost impossible to directly map a whole .gir file into a Vala tree,
hence the need of metadata. On the other side we might want to use
directly .gir + .metadata instead of generating a .vapi, but .vapi is
more humanly readable and faster to parse than the GIR, hence the need
of vapigen for generating a .vapi.

Locating metadata
-----------------

The filename of a metadata for a ``SomeLib.gir`` must be
``SomeLib.metadata``. By default Vala looks for .metadata into the same
directory of the .gir file, however it's possible to specify other
directories using the ``--metadatadir`` option.

Comments
--------

Comments in the metadata have the same syntax as in Vala code:

.. code:: vala
   :number-lines:

   // this is a comment
   /*
    * multi-line comment
    */

Syntax
------

Metadata information for each symbol must provided on different lines:

   | rule:
   |    pattern [ arguments ] [ ``newline`` relative-rules ] ``newline``
   |
   | relative-rules:
   |    **.** pattern [ arguments ] [ ``newline`` relative-rules ]
   |
   | pattern:
   |    ``glob-style-pattern`` [ **#** selector ] [ **.** pattern ]
   |
   | arguments:
   |    ``identifier`` [ **=** expression ] [ arguments ]
   |
   | expression:
   |    **null**
   |    **true**
   |    **false**
   |    **-** expression
   |    integer-literal
   |    real-literal
   |    string-literal
   |    symbol
   |
   | symbol:
   |    identifier [ **.** identifier ]

-  Patterns are tied to the GIR tree: if a class ``FooBar`` contains a
   method ``baz_method`` then it can be referenced in the metadata as
   ``FooBar.baz_method``.

-  Selectors are used to specify a particular element name of the GIR
   tree, for example ``FooBar.baz_method#method`` will only select
   method elements whose name is baz_method. Useful to solve name
   collisions.

-  Given a namespace named ``Foo`` a special pattern ``Foo`` is
   available for setting general arguments.

-  If a GIR symbol matches multiple rules then all of them will be
   applied: if there are clashes among arguments, last written rules in
   the file take precedence.

-  If the expression for an argument is not provided, it's treated as
   **true** by default.

-  A *relative rule* is relative to the nearest preceding *absolute
   rule*. Metadata must contain at least one absolute rule. It's not
   possible to make a rule relative to another relative rule.

Valid arguments
---------------

.. list-table::
   :header-rows: 1

   * - Name
     - Applies To
     - Type
     - Description
   * - ``skip``
     - all
     - bool
     - Skip processing the symbol
   * - ``hidden``
     - all
     - bool
     - Process the symbol but hide from output
   * - ``type``
     - method, parameter, property, field, constant, alias
     - string
     - Complete Vala type
   * - ``type_arguments``
     - method, parameter, property, field, constant, alias
     - string
     - Vala type parameters for generics, separated by commas
   * - ``cheader_filename``
     - all including namespace
     - string
     - C headers separated by commas
   * - ``name``
     - all including namespace
     - string
     - Vala symbol name
   * - ``owned``
     - parameter
     - bool
     - Whether the parameter value should be owned
   * - ``unowned``
     - method, property, field, constant
     - bool
     - Whether the symbol is unowned
   * - ``parent``
     - all
     - string
     - Move the symbol to the specified  container symbol. If no container exists, a new  namespace will be created.
   * - ``nullable``
     - method, parameter, property, field, constant, alias
     - bool
     - Whether the type is nullable or not
   * - ``deprecated``
     - all
     - bool
     - Whether the symbol is deprecated or not
   * - ``replacement``
     - all
     - string
     - Deprecation replacement, implies ``deprecated=true``
   * - ``deprecated_since``
     - all
     - string
     - Deprecated since version, implies ``deprecated=true``
   * - ``array``
     - method, parameter, property, field, constant, alias
     - bool
     - Whether the type is an array or not
   * - ``array_length_idx``
     - parameter
     - int
     - The index of the C array length parameter
   * - ``default``
     - parameter
     - any
     - Default expression for the parameter
   * - ``out``
     - parameter
     - bool
     - Whether the parameter direction is out or not
   * - ``ref``
     - parameter
     - bool
     - Whether the parameter direction is ref or not
   * - ``vfunc_name``
     - method
     - string
     - Name of the C virtual function
   * - ``virtual``
     - method, signal, property
     - bool
     - Whether the symbol is virtual or not
   * - ``abstract``
     - method, signal, property
     - bool
     - Whether the symbol is abstract or not
   * - ``scope``
     - parameter (async method)
     - string
     - Scope of the delegate, in GIR terms
   * - ``struct``
     - record (detected as boxed compact class)
     - bool
     - Whether the boxed type must be threaten as struct instead of compact class
   * - ``printf_format``
     - method
     - bool
     - Add the [PrintfFormat] attribute to the method if true
   * - ``array_length_field``
     - field (array)
     - string
     - The name of the length field
   * - ``sentinel``
     - method
     - string
     - C expression of the last argument for varargs
   * - ``closure``
     - parameter
     - int
     - Specifies the index of the parameter representing the user data for this callback
   * - ``errordomain``
     - enumeration
     - bool
     - Whether the enumeration is an errordomain or not
   * - ``destroys_instance``
     - method
     - bool
     - Whether the instance is owned by the method
   * - ``throws``
     - method
     - string
     - Type of exception the method throws

Examples
--------

Demonstrating...

Overriding Types
~~~~~~~~~~~~~~~~

When you have the following expression:

::

   typedef GList MyList;

where ``GList`` will hold integers, use ``type`` metadata as follows:

::

   MyList type="GLib.List<int>"

The above metadata will generate the following code:

.. code:: vala
   :number-lines:

   public class MyList : GLib.List<int> {
       [CCode (has_construct_function = false)]
       protected MyList ();
       public static GLib.Type get_type ();
   }

Then you can use ``GLib.List`` or ``NameSpace.MyList`` as if equal.

Skipping Simbols
~~~~~~~~~~~~~~~~

::

   MySimbol skip

More Examples
~~~~~~~~~~~~~

