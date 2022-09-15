Concepts
========

This pages describes concepts that are widely applicable in Vala.
Specific syntax is not described here, see the linked pages for more
details.

.. _variables:

Variables
---------

Any piece of data in a Vala application is considered an instance of a
data type. There are various different categories of data types, some
being built into Vala, and others being user defined. Details about
types are described elsewhere in this documentation, in particular see
:doc:`types`.

Instances of these types are created in various different ways,
depending on the type. For example, fundamental types are instantiated
with literal expressions, and classed types with the new operator.

In order to access data, the instance must be identifiable in some way,
such as by a name. In Vala, there are broadly three ways that this is
done, with similar but not identical semantics.

(All these subsections refer to ownership, so it may be useful to read
the section on :ref:`references-ownership` in conjunction with this
section)

Local variables
~~~~~~~~~~~~~~~

Within executable code in a method, an instance may be assigned to a
variable. A variable has a name and is declared to refer to an instance
of a particular data type. A typical variable declaration would be:

.. code:: vala
   :number-lines:

   int a;

This declaration defines that "a" should become an expression that
evaluates to an instance of the int type. The actual value of this
expression will depend on which int instance is assigned to the
variable. "a" can be assigned to more than once, with the most recent
assignment being the only one considered when "a" is evaluated.
Assignment to the variable is achieved via an assignment expression.
Generally, the semantics of an assignment expression depends on the type
of the variable.

A variable can take ownership of an instance, the precise meaning of
which depends on the data type. In the context of reference types, it is
possible to declare that a variable should not ever take ownership of an
instance, this is done with the ``unowned`` keyword. See
:ref:`reference-types`.

If a type is directly instantiated in a variable declaration statement,
then the variable will be created owning that new instance, for example:

.. code:: vala
   :number-lines:

   string s = "stringvalue";

A variable ceases to exist when its scope is destroyed, that is when the
code block it is defined in finishes. After this, the name can no longer
be used to access the instance, and no new assignment to the variable is
allowed. What happens to the instance itself is dependent on the type.

For more details of the concepts in this section, see
:ref:`variable-declaration` and :ref:`assignment`.

Fields
~~~~~~

A field is similar to a variable, except for the scope that it is
defined in. Fields can be defined in namespaces, classes and structs. In
the case of classes and structs, they may be either in the scope of the
class or struct, or in the scope of each instance of the class or
struct.

A field is valid as long as its scope still exists - for non-instance
fields, this is the entire life of the application; for instance fields,
this is the lifetime of the instance.

Like variables, fields can take ownership of instances, and it is again
possible to avoid this with the ``unowned`` keyword.

If a type is directly instantiated in the declaration of the field, then
that field will be created owning that new instance.

For more details about fields, see
:doc:`namespaces`, :doc:`classes` and :doc:`structs`.

Parameters
~~~~~~~~~~

Instances passed to methods are accessible within that method with names
given in the method's parameter list.

They act like variables, except that they cannot, by default, take
ownership of the first instance that is assigned to them, i.e. the
instance passed to the method. This behaviour can be changed using
explicit ownership transfer. When reassigning to a parameter, the result
depends on the parameter direction. Assuming the parameter has no
direction modifier, it will subsequently act exactly as a variable.

For more details of methods and parameters, see
:doc:`methods` and :ref:`ownership-transfer-expressions`.

.. _scope-and-naming:

Scope and naming
----------------

A "scope" in Vala refers to any context in which identifiers can be
valid. Identifiers in this case refers to anything named, including
class definitions, fields, variables, etc. Within a particular scope,
identifiers defined in this scope can be used directly:

.. code:: vala
   :number-lines:

   void main () {
       int a = 5;
       int b = a + 1;
   }

Scopes in Vala are introduced in various different ways.

-  Named scopes can be created directly with declarations like
   namespaces. These are always in existence when the program is
   running, and can be referred to by their name.

-  Transient scopes are created automatically as the program executes.
   Every time a new code block is entered, a new scope is created. For
   example, a new scope is created when a method is invoked. There is no
   way to refer to this type of scope from outside.

-  Instance scopes are created when a data type is instantiated, for
   example when a new instance of a classed type is created. These
   scopes can be accessed via identifiers defined in other scopes, e.g.
   a variable to which the new instance is assigned.

To refer to an identifier in another scope, you must generally qualify
the name. For named scopes, the scope name is used; for instance scopes,
any identifier to which the instance is assigned can be used. See
:ref:`member-access` for the syntax of accessing other scopes.

Scopes have parent scopes. If an identifier is not recognised in the
current scope, the parent scope is searched. This continues up to the
global scope. The parent scope of any scope is inferred from its
position in the program - the parent scope can easily be identified as
it is the scope the current declaration is in.

For example, a namespace method creates a transient scope when it is
invoked - the parent of this scope if the namespace which contains the
definition of the method. There are slightly different rules applied
when instances are involved, as are described at :ref:`classes-scope`.

The ultimate parent of all other scopes is the global scope. The scope
contains the fundamental data types, e.g. int, float, string. If a
program has a declaration outside of any other, it is placed in this
scope.

Qualifying names
~~~~~~~~~~~~~~~~

The following rules describe when to qualify names:

-  For names in the same scope as the current definition, just the name
   should be used.

-  For names in scopes of which the current is parent, qualify with just
   the names of scopes that the current definition is not nested within.

-  For names in other scopes entirely, or that are less deeply nested
   than the current, use the fully qualified name (starting from the
   global scope.)

There are some intricacies of scopes described elsewhere in this
documentation. See :doc:`classes` for how scopes are managed for inherited classes.

Vala will lookup names assuming first that they are not fully qualified.
If a fully qualified name can be partially matched locally, or in a
parent scope that is not the global scope, the compilation will fail. To
avoid problems with this, do not reuse names from the global scope in
other scopes.

There is one special scope qualifier that can be used to avoid the
problem described in the previous paragraph. Prefixing an identifier
with ``global::`` will instruct the compiler to only attempt to find the
identifier in the global scope, skipping all earlier searching.

.. _object-oriented:

Object oriented programming
---------------------------

Vala is primarily an object oriented language. This documentation isn't
going to describe object oriented programming in detail, but in order
for other sections to make sense, some things need to be explained.

A class in Vala is a definition of a potentially polymorphic type. A
polymorphic type is one which can be viewed as more than one type. The
basic method for this is inheritance, whereby one type can be defined as
a specialized version of another. An instance of a subtype, descended
from a particular supertype, has all the properties of the supertype,
and can be used wherever an instance of the supertype is expected. This
sort of relationship is described as a "subtype instance is-a supertype
instance." See :doc:`classes`.

Vala provides inheritance functionality to any type of class (see :ref:`classes-types`).
Given the following definition, every SubType instance is-a SuperType
instance:

.. code:: vala
   :number-lines:

   class SuperType {
       public int act () {
           return 1;
       }
   }

   class SubType : SuperType {
   }

Whenever a SuperType instance is required, a SubType instance may be
used. This is the extent of inheritance allowed to compact classes, but
full classes are more featured. All classes that are not of compact
type, can have virtual methods, and can implement interfaces.

To explain virtual functions, it makes sense to look at the alternative
first. In the above example, it is legal for SubType to also define a
method called "act" - this is called overriding. In this case, when a
method called "act" is called on a SubType instance, which method is
invoked depends on what type the invoker believed it was dealing with.
The following example demonstrates this:

.. code:: vala
   :number-lines:

   SubType sub = new SubType ();
   SuperType super = sub;

   sub.act ();
   super.act ();

Here, when sub.act() is called, the method invoked will be SubType's
"act" method. The call super.act() will call SuperType's "act". If the
act method were virtual, the SubType.act method would have been called
on both occasions. See :ref:`class-methods` for how to declare virtual methods.

Interfaces are a variety of non-instantiatable type. This means that it
is not possible to create an instance of the type. Instead, interfaces
are implemented by other types. Instances of these other types may then
be used as though they were instances of the interface in question. See :doc:`interfaces`.

.. _references-ownership:

References and ownership
------------------------

Type instances in Vala are automatically managed to a large degree. This
means that memory is allocated to store the data, and then deallocated
when the data is no longer required. However, Vala does not have a
runtime garbage collector, instead it applies rules at compile time that
will predictably deallocate memory at runtime.

A central concept of Vala's memory management system is ownership. An
instance is considered still in use as long as there is at least one way
of accessing it, i.e. there is some field, variable or parameter that
refers to the instance - one such identifier will be considered the
instance's owner, and therefore the instance's memory will not be
deallocated. When there is no longer any way to access the data
instance, it is considered unowned, and its memory will be deallocated.

Value types
~~~~~~~~~~~

When dealing with instances of value types (see :doc:`types`)
knowledge of ownership is rarely important. This is because the instance
is copied whenever it is assigned to a new identifier. This will cause
each identifier to become owner of a unique instance - that instance
will then be deallocated when the identifier ceases to be valid.

There is one exception to this rule: when a struct type instance is
passed to a method, Vala will, by default, create the method parameter
as a reference to the instance instead of copying the instance. This
reference is a weak reference, as described in the following section. If
the struct should instead be copied, and the parameter created as a
standard value type identifier, the ownership transfer operator should
be used (see :ref:`ownership-transfer-expressions`).

Reference types
~~~~~~~~~~~~~~~

With reference types, it is possible for several identifiers to
reference the same data instance. Not all identifiers that refer to
reference type instance are capable of owning the instance, for reasons
that will be explained. It is therefore often required to think about
instance ownership when writing Vala code.

Most reference types support reference counting. This means that the
instance internally maintains a count of how many references to it
currently exist. This count is used to decide whether the instance is
still in use, or if its memory can be deallocated. Each reference that
is counted in this way is therefore a potential owner of the instance,
as it ensures the instance continues to exist. There are situations when
this is not desired, and so it is possible to define a field or variable
as "weak". In this case the reference is not counted, and so the fact
that the reference exists will not stop the instance being possibly
deallocated, i.e. this sort of reference cannot take ownership of the
instance.

When using reference counted types, the main use for weak references is
to prevent reference cycles. These exist when a data instance contains
internally a reference to another instance, which in turn contains a
reference to the first. In this case it would not be possible to
deallocate the instances, as each would be potentially owning the other.
By ensuring that one of the references is weak, one of the instances can
become unowned and be deallocated, and in the process the other will be
dereferenced, and potentially become unowned and be deallocated also.

It is also possible to have reference types which are not reference
counted; an example of this is the fundamental string type, others are
compact classed types. If Vala were to allow several references to own
such instances, it would not be able to keep track of when they all
ceased to exist, and therefore would not be able to know when to
deallocate the instance. Instead, exactly one or zero identifiers will
own the instance - when it is zero, the instance is deallocated. This
means that all references to an already owned instance must either be
weak references, or ownership must be specifically passed to the new
reference, using the ownership transfer operator (see
:ref:`ownership-transfer-expressions`).

Pointer types
~~~~~~~~~~~~~

Pointer types are of great importance. Pointer types are value types,
whose instances are references to some other data instance. They are
therefore not actual references, and will never own the instance that
they indirectly refer to. See :ref:`pointer-types`.
