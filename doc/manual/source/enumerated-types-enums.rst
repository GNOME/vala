Enumerated types (Enums)
========================

Enumerated types declare all possible values that instances of the type
may take. They may also define methods of the type, but an enumerated
type has no data other than its value. Enumerated types are value types,
and so each instantiation of the type is unique, even when they
represent the same value. This distinction is not significant in
practice because when instances are compared, it is always by value not
identity.

Enumerated types are usually known as simply "enums".

Enum declaration
----------------

   | enum-declaration:
   |    [ access-modifier ] **enum** qualified-enum-name **{** [ enum-members ] **}**
   |
   | qualified-enum-name:
   |    [ qualified-namespace-name **.** ] enum-name
   |
   | enum-name:
   |    identifier
   |
   | enum-members:
   |    [ enum-values ] [ **;** enum-methods ]
   |
   | enum-values:
   |    enum-value [ **,** enum-values ]
   |
   | enum-value:
   |    enum-value-name [ **=** expression ]
   |
   | enum-value-name:
   |    identifier
   |
   | enum-methods:
   |    enum-method [ enum-methods ]
   |
   | enum-method:
   |    method-declaration

Enum members
------------

Equivalent to constants, all have an integer value, either explicit or
automatically assigned.

Methods
-------

Are similar to static methods of classes, i.e. are not related to any
particular instance, but can be invoked on either an instance or the
enum itself.

Flag types
----------

An enumerated type declaration can be converted into a flag type
declaration by annotating the declaration with "Flags". A flag type
represents a set of flags, any number of which can be combined in one
instance of the flag type, in the same fashion as a bitfield in C. For
an explanation of the operations that can be performed on flag types,
see :ref:`flag-operations`.
For how to use attributes, see :doc:`attributes`.

For example, say we want to draw the borders of a table cell:

.. code:: vala
   :number-lines:

   [Flags]
   enum Borders {
       LEFT,
       RIGHT,
       TOP,
       BOTTOM
   }

   void draw_borders (Borders selected_borders) {
       // equivalent to: if ((Borders.LEFT & selected_borders) > 0)
       if (Borders.LEFT in selected_borders) {
           // draw left border
       }
       if (Borders.RIGHT in selected_borders) {
           // draw right border
       }
       ...
   }

.. _enums-error-domain:

Error domains
-------------

Error domains are Vala's method for describing errors. An error domain
is declared using a similar syntax to enumerated types, but this does
not define a type - instead it defines a class of errors, which is used
to implicitly create a new error type for the error domain. The error
domain declaration syntax is effectively the same as for enumerated
types, but the keyword ``errordomain`` is used instead of ``enum``.

For more information about handling errors in Vala, see :doc:`errors`.

Examples
--------

Demonstrating...

.. code:: vala
   :number-lines:

   // ...
