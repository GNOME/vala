Namespaces
==========

Namespaces are named scopes (see :ref:`scope-and-naming`).
Definitions in different namespaces can use the same names without
causing conflicts. A namespace can be declared across any number of Vala
source files, and there can be multiple namespaces defined in a single
Vala source file. Namespaces can be nested to any depth.

When code needs to access definitions from other namespaces, it must
either refer to them using a fully qualified name, or be written in a
file with an appropriate using statement.

The simplest namespace declaration looks like this:

.. code:: vala
   :number-lines:

   namespace NameSpaceName {
   }

Namespace nesting is achieved either by nesting the declarations, or by
providing multiple names in one declaration:

.. code:: vala
   :number-lines:

   namespace NameSpaceName1 {
           namespace NameSpaceName2 {
           }
   }

   namespace NameSpaceName1.NameSpaceName2 {
   }

The global namespace
--------------------

Everything not declared within a particular namespace declaration is
automatically in the global namespace. All defined namespaces are nested
inside the global namespace at some depth. This is also where the
fundamental types are defined.

If there is ever a need to explicitly refer to an identifier in the
global namespace, the identifier can be prefixed with ``global::``. This
will allow you, for example, to refer to a namespace which has the same
name as a local variable.

Namespace declaration
---------------------

   | namespace-declaration:
   |    **namespace** qualified-namespace-name **{** [ namespace-members ] **}**
   |
   | qualified-namespace-name:
   |    [ qualified-namespace-name **.** ] namespace-name
   |
   | namespace-name:
   |    identifier
   |
   | namespace-members:
   |    namespace-member [ namespace-members ]
   |
   | namespace-member:
   |    class-declaration
   |    abstract-class-declaration
   |    constant-declaration
   |    delegate-declaration
   |    enum-declaration
   |    errordomain-declaration
   |    field-declaration
   |    interface-declaration
   |    method-declaration
   |    namespace-declaration
   |    struct-declaration

Members
-------

Namespaces members exist in the namespace's scope. They fall into two
broad categories: data and definitions. Data members are fields which
contain type instances. Definitions are things that can be invoked or
instantiated. Namespace members can be declared either private or
public. Public data can be accessed from anywhere, whilst private data
can only be accessed from inside the namespace. Public definitions are
visible to code defined in a different namespace, and thus can be
invoked or instantiated from anywhere, private definitions are only
visible to code inside the namespace, and so can only be invoked or
instantiated from there.

   | access-modifier:
   |    **public**
   |    **private**

For the types of namespace members that are not described on this page:
see :doc:`classes`, :doc:`structs`, :doc:`delegates`,
:doc:`enumerated-types-enums`, and :ref:`enums-error-domain`.

Fields
------

Variables that exist directly in a namespace are known as namespace
fields. These exist only once, and within the scope of the namespace
which exists for the application's entire run time. They are therefore
similar to global variables in C but without the risk of naming clashes.

   | field-declaration:
   |    [ access-modifier ] qualified-type-name field-name [ **=** expression ] ;
   |
   | field-name:
   |    identifier

Fields in general are described at :ref:`variables`.

Constants
---------

Constants are similar to variables but can only be assigned to once. It
is therefore required that the expression that initialises the constant
be executable at the time the constant comes into scope. For namespaces
this means that the expressions must be evaluable at the beginning of
the application's execution.

   | constant-declaration:
   |    [ access-modifier ] **const** qualified-type-name constant-name **=** expression ;
   |
   | constant-name:
   |    identifier

The "using" statement
---------------------

``using`` statements can be used to avoid having to qualify names fully
on a file-by-file basis. For all identifiers in the same file as the
using statement, Vala will first try to resolve them following the usual
rules (see :ref:`scope-and-naming`).
If the identifier cannot be resolved in any scope, each namespace that
is referenced in a ``using`` will be searched in turn.

   | using-statement:
   |    **using** namespace-list **;**
   |
   | namespace-list:
   |    qualified-namespace-name [ **,** namespace-list ]

There can be any number of using statements in a Vala source file, but
they must all appear outside any other declarations. Note that ``using``
is not like import statements in other languages - it does not load
anything, it just allows for automatic searching of namespace scopes, in
order to allow frugal code to be written.

Most code depends on members of the GLib namespace, and so many source
files begin with:

.. code:: vala
   :number-lines:

   using GLib;

TODO: Include examples.
