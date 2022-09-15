Structs
=======

A struct is a data type that can contain fields, constants, and methods.

The simplest struct declaration looks like this:

.. code:: vala
   :number-lines:

   struct StructName {
           int some_field;
   }

A struct must have at least one field, except in either one of the
following cases:

-  It's external

-  It has either one of ``[BooleanType]``, ``[IntegerType]`` or ``[FloatingType]`` attributes

-  It inherits from another struct

Struct declaration
------------------

   | struct-declaration:
   |    [ access-modifier ] **struct** qualified-struct-name [ **:** super-struct ] **{** [ struct-members ] **}**
   |
   | qualified-struct-name:
   |    [ qualified-namespace-name **.** ] struct-name
   |
   | struct-name:
   |    identifier
   |
   | struct-members:
   |    struct-member [ struct-members ]
   |
   | struct-member:
   |    struct-creation-method-declaration:
   |    struct-field-declaration
   |    struct-constant-declaration
   |    struct-method-declaration

If a super-struct is given, the struct-name becomes an alias for that
struct.

Controlling instantiation
-------------------------

   | struct-creation-method-declaration:
   |    [ struct-access-modifier ] struct-name [ **.** creation-method-name ] **(** param-list **)** **{** statement-list **}**
   |
   | struct-name:
   |    identifier

Unlike in a class, any code can go in this method.

Struct fields
-------------

Documentation

   | struct-field-declaration:
   |    [ access-modifier ] [struct-field-type-modifier] qualified-type-name field-name [ **=** expression ] ;
   |
   | struct-field-type-modifier:
   |    **static**

Struct constants
----------------

   | class-constant-declaration:
   |    [ class-access-modifier ] **const** qualified-type-name constant-name **=** expression ;

Struct methods
--------------

See :doc:`methods`, See :ref:`class-methods`

   | struct-method-declaration:
   |    [ access-modifier ] [ struct-method-type-modifier ] return-type method-name **(** [ params-list ] **)** method-contracts [ **throws** exception-list ] **{** statement-list **}**
   |
   | struct-method-type-modifier:
   |    **static**

Examples
--------

Demonstrating...

.. code:: vala
   :number-lines:

   // ...
