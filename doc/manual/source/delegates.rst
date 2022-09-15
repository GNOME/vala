Delegates
=========

A delegate declaration defines a method type: a type that can be
invoked, accepting a set of values of certain types, and returning a
value of a set type. In Vala, methods are not first-class objects, and
as such cannot be created dynamically; however, any method can be
considered to be an instance of a delegate's type, provided that the
method signature matches that of the delegate.

Methods are considered to have an immutable reference type.
Any method can be referred to by name as an expression returning
a reference to that method - this can be assigned to a field
(or variable, or parameter), or else invoked directly as
a standard method invocation (see :ref:`invocation-expressions`).

Types of delegate
-----------------

All delegate types in Vala are defined to be either static or instance
delegates. This refers to whether the methods that may be considered
instances of the delegate type are instance members of classes or
structs, or not.

To assign an instance of an instance delegate, you must give the method
name qualified with an identifier that refers to a class or struct
instance. When an instance of an instance delegate is invoked, the
method will act as though the method had been invoked directly: the
"this" keyword will be usable, instance data will be accessible, etc.

Instance and static delegate instances are not interchangeable.

Delegate declaration
--------------------

The syntax for declaring a delegate changes slightly based on what sort
of delegate is being declared. This section shows the form for a
namespace delegate. Many of the parts of the declaration are common to
all types, so sections from here are referenced from class delegates,
interface delegates, etc.

   | delegate-declaration:
   |    [ access-modifier ] **delegate** return-type qualified-delegate-name **(** method-params-list **)** [ **throws** error-list ] **;**
   |
   | qualified-delegate-name:
   |    [ qualified-namespace-name **.** ] delegate-name
   |
   | delegate-name:
   |    identifier

Parts of this syntax are based on the respective sections of the method
declaration syntax (see :doc:`methods` for details).

By default, delegates are instance delegates.
To declare a static delegate, add the annotation ```[CCode (has_target = false)]```; see the examples below.
(Static delegates used to be declared by adding the keyword ```static``` before ```delegate``` instead of using the annotation.
This syntax is still accepted by the compiler, but will cause a warning to be given.)

Using delegates
---------------

A delegate declaration defines a type. Instances of this type can then
be assigned to variables (or fields, or parameters) of this type. Vala
does not allow creating methods at runtime, and so the values of
delegate-type instances will be references to methods known at compile
time. To simplify the process, inlined methods may be written (see
:ref:`methods-lambdas`).

To call the method referenced by a delegate-type instance, use the same
notation as for calling a method; instead of giving the method's name,
give the identifier of the variable, as described in
:ref:`invocation-expressions`.

Examples
--------

Defining delegates:

.. code:: vala
   :number-lines:

   // Static delegate taking two ints, returning void:
   [CCode (has_target = false)]
   void DelegateName (int a, int b);

   // Instance delegate with the same signature:
   void DelegateName (int a, int b);

   // Static delegate which may throw an error:
   [CCode (has_target = false)]
   void DelegateName () throws GLib.Error;

Invoking delegates, and passing as parameters.

.. code:: vala
   :number-lines:

   void f1 (int a) { stdout.printf ("%d\n", a); }
   ...
   void f2 (DelegateType d, int a) {
           d (a);
   }
   ...
   f2 (f1, 5);

Instance delegates:

.. code:: vala
   :number-lines:

   class Test : Object {
           private int data = 5;
           public void method (int a) {
                   stdout.printf ("%d %d\n", a, this.data);
           }
   }

   delegate void DelegateType (int a);

   void main () {
           var t = new Test ();
           DelegateType d = t.method;

           d (1);
   }

With Lambda:

.. code:: vala
   :number-lines:

   f2 (a => { stdout.printf ("%d\n", a); }, 5);
