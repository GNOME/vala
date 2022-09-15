Types
=====

A "type", loosely described, is just an abstract set of 0 or more data
fields. A type may be instantiated by creating an entity that contains
values that map to the fields of the type. In Vala, a type generally
consists of:

-  A type name, which is used in various contexts in Vala code to
   signify an instance of the type.

-  A data structure that defines how to represent an instance of the
   type in memory.

-  A set of methods that can be called on an instance of the type.

These elements are combined as the definition of the type. The
definition is given to Vala in the form of a declaration, for example a
class declaration.

Vala supports three kinds of data types: value types, reference types,
and meta types. Value types include simple types (e.g. char, int, and
float), enum types, and struct types. Reference types include object
types, array types, delegate types, and error types. Type parameters are
parameters used in generic types.

Value types differ from reference types in that there is only ever one
variable or field that refers to each instance, whereas variables or
fields of the reference types store references to data which can also be
referred to by other variable or fields. When two variables or fields of
a reference type reference the same data, changes made using one
identifier are visible when using the other. This is not possible with
value types.

Meta types are created automatically from other types, and so may have
either reference or value type semantics.

   | type:
   |    value-type
   |    reference-type
   |    meta-type
   |
   | meta-type:
   |    parameterised-type
   |    nullable-type
   |    pointer-type

.. _value-types:

Value types
-----------

Instances of value types are stored directly in variables or fields that
represent them. Whenever a value type instance is assigned to another
variable or field, the default action is to duplicate the value, such
that each identifier refers to a unique copy of the data, over which it
has ownership. When a value type is instantiated in a method, the
instance is created on the stack.

   | value-type:
   |    fundamental-struct-type
   |    user-defined-struct-type
   |    enumerated-type
   |
   | fundamental-struct-type:
   |    integral-type
   |    floating-point-type
   |    **bool**
   |
   | integral-type:
   |    **char**
   |    **uchar**
   |    **short**
   |    **ushort**
   |    **int**
   |    **uint**
   |    **long**
   |    **ulong**
   |    **size_t**
   |    **ssize_t**
   |    **int8**
   |    **uint8**
   |    **int16**
   |    **uint16**
   |    **int32**
   |    **uint32**
   |    **int64**
   |    **uint64**
   |    **unichar**
   |
   | floating-point-type:
   |    **float**
   |    **double**

Where a literal is indicated, this means the actual type name of a built
in struct type is given. The definition of these types is included in
Vala, so these types are always available.

Struct types
~~~~~~~~~~~~

A struct type is one that provides just a data structure and some
methods that act upon it. Structs are not polymorphic, and cannot have
advanced features such as signals or properties. See :doc:`structs`
for documentation on how to define structs and more details about them.
See :ref:`struct-expression` for how to instantiate structs.

Each variable or field to which a struct stype instance is assigned
gains a copy of the data, over which it has ownership. However, when a
struct type instance is passed to a method, a copy is not made. Instead
a reference to the instance is passed. This behaviour can be changed by
declaring the struct to be a simple type.

Fundamental types
~~~~~~~~~~~~~~~~~

In Vala, the fundamental types are defined as struct types whose data
structure is known internally to Vala. They have one anonymous field,
which is automatically accessed when required. All fundamental value
types are defined as simple types, and so whenever the instance is
assigned to a variable or field or passed as a function parameter, a
copy of the data is made.

The fundamental value types fall into one of three categories: the
boolean type, integral types, and floating point types.

Integral types
~~~~~~~~~~~~~~

Integral types can contain only integers. They are either signed or
unsigned, each of which is considered a different type, though it is
possible to cast between them when needed.

Some types define exactly how many bits of storage are used to represent
the integer, others depend of the environment. long, int short map to C
data types and therefore depend on the machine architecture. char is 1
byte. unichar is 4 bytes, i.e. large enough to store any UTF-8
character.

All these types can be instantiated using a literal expression, see
:ref:`literal-expressions`.

Floating point types
~~~~~~~~~~~~~~~~~~~~

Floating point types contain real floating point numbers in a fixed
number of bits (see IEEE 754).

All these types can be instantiated using a literal expression, see
:ref:`literal-expressions`.

The bool type
~~~~~~~~~~~~~

Can have values of true of false. Although there are only two values
that a bool instance can take, this is not an enumerated type. Each
instance is unique and will be copied when required, the same as for the
other fundamental value types.

This type can be instantiated using literal expressions, see
:ref:`literal-expressions`.

Enumerated types
~~~~~~~~~~~~~~~~

An enumerated type is one in which all possible values that instances of
the type can hold are declared with the type. In Vala enumerated types
are real types, and will not be implicitly converted. It is possible to
explicitly cast between enumerated types, but this is not generally
advisable. When writing new code in Vala, don't rely on being able to
cast in this way.

A variation on an enumerated type is a flag type. This represents a set
of flags, any number of which can be combined in one instance of the
flag type, in the same fashion as a bitfield in C.

See :doc:`enumerated-types-enums` for documentation on defining and using enumerated types.

.. _reference-types:

Reference types
---------------

Instances of reference types are always stored on the heap. Variables of
reference types contain references to the instances, rather than the
instances themselves. Assigning an instance of a reference type to a
variable or field will not make a copy of the data, instead only the
reference to the data is copied. This means that both variables will
refer to the same data, and so changes made to that data using one of
the references will be visible when using the other.

Instances of any reference type can be assigned a variable that is
declared "weak". This implies that the variable must not be known to the
type instance. A reference counted type does not increase its reference
count after being assigned to a weak variable: a weak variable cannot
take ownership of an instance.

   | reference-type:
   |    classed-type
   |    array-type
   |    delegate-type
   |    error-type
   |    **string**
   |
   |  classed-type:
   |    simple-classed-type
   |    type-instance-classed-type
   |    object-classed-type
   |
   |  simple-classed-type:
   |    user-defined-simple-classed-type
   |
   |  type-instance-classed-type:
   |    user-defined-type-instance-classed-type
   |
   |  object-classed-type:
   |    user-defined-object-classed-type
   |
   |  array-type:
   |    non-array-type **[]**
   |    non-array-type **[** dimension-separators **]**
   |
   |  non-array-type:
   |    value-type
   |    classed-type
   |    delegate-type
   |    error-type
   |
   |  dimension-separators:
   |    **,**
   |    dimension-separators **,**
   |
   |  delegate-type:
   |    user-defined-delegate-type
   |
   |  error-type:
   |    user-defined-error-type

Classed types
~~~~~~~~~~~~~

A class definition introduces a new reference type - this is the most
common way of creating a new type in Vala. Classes are a very powerful
mechanism, as they have features such as polymorphism and inheritance.
Full discussion of classes is found at :doc:`classes`.

Most classed types in Vala are reference counted. This means that every
time a classed type instance is assigned to a variable or field, not
only is the reference copied, but the instance also records that another
reference to it has been created. When a field or variable goes out of
scope, the fact that a reference to the instance has been removed is
also recorded. This means that a classed type instance can be
automatically removed from memory when it is no longer needed. The only
classed types that are not reference counted are compact classes..
Memory management is discussed at :ref:`memory-management`.
If the instance is not of a reference counted type, then the ownership
must be explicitly transferred using the # operator - this will cause
the original variable to become invalid. When a classed-type instance is
passed to a method, the same rules apply. The types of classes available
are discussed at :ref:`classes-types`.

Array types
~~~~~~~~~~~

TODO: Check correctness.

An array is a data structure that can contains zero or more elements of
the same type, up to a limit defined by the type. An array may have
multiple dimensions; for each possible set of dimensions a new type is
implied, but there is a meta type available that describes an array of
any size with the same number of dimensions, i.e. int[1] is not the same
type as int[2], while int[] is the same type as either.

A size can be retrieved from an array using the ``length`` member, this
returns an int if the array has one dimension or an int[] if the array
contains several dimensions.

You can also move or copy and array using respectively the ``move`` and
``copy`` members.

For single-dimension arrays, a ``resize`` member is also available to
change the length of the array.

See :ref:`array-expression` for how to instantiate an array type.

Delegate types
~~~~~~~~~~~~~~

A delegate is a data structure that refers to a method. A method
executes in a given scope which is also stored, meaning that for
instance methods a delegate will contain also a reference to the
instance.

Delegates are technically a referenced type, but since methods are
immutable, this distinction is less important than for other types.
Assigning a delegate to a variable or field cannot copy the method
indicated, and no delegate is able to change the method in any way.

See :doc:`delegates` for full documentation.

Error Types
~~~~~~~~~~~

Instances of error types represent recoverable runtime errors. All
errors are described using error domains, a type of enumerated value,
but errors themselves are not enumerated types. Errors are discussed in
detail in several sections of this documentation, see:
:doc:`errors`, :ref:`enums-error-domain` and :doc:`methods`.

Strings
~~~~~~~

Vala has built in support for Unicode strings, via the fundamental
string type. This is the only fundamental type that is a reference type.
Like other fundamental types, it can be instantiated with a literal
expression (:ref:`literal-expressions`.)
Strings are UTF-8 encoded, the same as Vala source files, which means
that they cannot be accessed like character arrays in C - each Unicode
character is not guaranteed to be stored in just one byte. Instead the
string fundamental struct type (which all strings are instances of)
provides access methods along with other tools.

While strings are technically a reference type, they have the same
default copy semantics as structs - the data is copied whenever a string
value is assigned to a variable or field, but only a reference is passed
as a parameter to a method. This is required because strings are not
reference counted, and so the only way for a variable or field to be
able to take ownership of a string is by being assigned a copy of the
string. To avoid this behaviour, string values can be assigned to weak
references (in such a case no copy is made).

The concept of ownership is very important in understanding string
semantics. For more details see :ref:`references-ownership`.

Parameterised types
-------------------

TODO: Casting.

Vala allows definitions of types that can be customised at runtime with
type parameters. For example, a list can be defined so that it can be
instantiated as a list of ints, a list of Objects, etc. This is achieved
using generic declarations. See :doc:`generics`.

.. _nullable-types:

Nullable types
--------------

The name of a type can be used to implicitly create a nullable type
related to that type. An instance of a nullable type ``T?`` can either
be a value of type ``T`` or ``null``.

A nullable type will have either value or reference type semantics,
depending on the type it is based on.

.. _pointer-types:

Pointer types
-------------

The name of a type can be used to implicitly create a pointer type
related to that type. The value of a variable declared as being of type
T\* represents the memory address of an instance of type T. The instance
is never made aware that its address has been recorded, and so cannot
record the fact that it is referred to in this way.

Instances of any type can be assigned to a variable that is declared to
be a pointer to an instance of that type. For referenced types, direct
assignment is allowed in either direction. For value types the
pointer-to operator "&" is required to assign to a pointer, and the
pointer-indirection operator "\*" is used to access the instance pointed
to. See :ref:`pointer-expressions`.

The ``void*`` type represents a pointer to an unknown type. As the
referent type is unknown, the indirection operator cannot be applied to
a pointer of type ``void*``, nor can any arithmetic be performed on such
a pointer. However, a pointer of type ``void*`` can be cast to any other
pointer type (and vice-versa) and compared to values of other pointer
types. See :ref:`type-operations`.

A pointer type itself has value type semantics.

Type conversions
----------------

There are two types if type conversions possible in Vala, implicit
conversions and explicit casts. In expressions, Vala will often convert
fundamental types in order to make calculations possible. When the
default conversion is not what you require, you can cast explicitly so
that all operands are of compatible types. See
:doc:`expressions` for details of automatic conversions.

Vala will also automatically perform conversions related to polymorphism
where the required cast is unambiguous and can be inferred from the
context. This allows you to use a classed-type instance when an instance
of any of its superclasses or implemented interfaces is required. Vala
will never automatically cast to a subtype, as this must be done
explicitly. See :ref:`object-oriented`, see :doc:`classes`.

For explicit casting expressions, see :ref:`type-operations`.
