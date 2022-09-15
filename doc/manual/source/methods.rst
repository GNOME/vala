Methods
=======

TODO: Do we really need this discussion? Are we introducing Vala, or
general programming?

A method is an executable statement block that can be identified in one
or more ways (i.e. by a name, or any number of delegate instances). A
method can be invoked with an optional number of parameters, and may
return a value. When invoked, the method's body will be executed with
the parameters set to the values given by the invoker. The body is run
in sequence until the end is reached, or a return statement is
encountered, resulting in a return of control (and possibly some value,
in the case of a return) to the invoker.

There are various contexts that may contain method declarations (see
:doc:`namespaces`, :doc:`classes`, :doc:`interfaces`, :doc:`structs`).
A method is always declared inside one of these other declarations, and
that declaration will mark the parent scope that the method will be
executed within. See :ref:`scope-and-naming`.

The :doc:`classes`
section of this documentation talks about both methods and abstract
methods. It should be noted that the latter are not truly methods, as
they cannot be invoked. Instead, they provide a mechanism for declaring
how other methods should be defined. See :doc:`classes`
for a description of abstract methods and how they are used.

The syntax for invoking a method is described on the expressions page
(see :ref:`invocation-expressions`).

Parameter directions
--------------------

The basics of method parameter semantics are described on the concepts
page (see :ref:`variables`).
This basic form of parameter is technically an "in" parameter, which is
used to pass data needed for the method to operate. If the parameter is
of a reference type, the method may change the fields of the type
instance it receives, but assignments to the parameter itself will not
be visible to the invoking code. If the parameter is of a value type,
which is not a fundamental type, the same rules apply as for a reference
type. If the parameter is of a fundamental type, then the parameter will
contain a copy of the value, and no changes made to it will be visible
to the invoking code.

If the method wishes to return more than one value to the invoker, it
should use "out" parameters. Out parameters do not pass any data to the
method - instead the method may assign a value to the parameter that
will be visible to the invoking code after the method has executed,
stored in the variable passed to the method. If a method is invoked
passing a variable which has already been assigned to as an out
parameter, then the value of that variable will be dereferenced or freed
as appropriate. If the method does not assign a value to the parameter,
then the invoker's variable will end with a value of "null".

The third parameter type is a "ref" argument (equivalent to "inout" in
some other languages.) This allows the method to receive data from the
invoker, and also to assign another value to the parameter in a way that
will be visible to the invoker. This functions similarly to "out"
parameters, except that if the method does not assign to the parameter,
the same value is left in the invoker's variable.

Method declaration
------------------

The syntax for declaring a method changes slightly based on what sort of
method is being declared. This section shows the form for a namespace
method, Vala's closest equivalent to a global method in C. Many of the
parts of the declaration are common to all types, so sections from here
are referenced from class methods, interface methods, etc.

   | method-declaration:
   |    [ access-modifier ] return-type qualified-method-name ( [ params-list ] ) [ **throws** error-list ] method-contracts **{** statement-list **}**
   |
   | return-type:
   |    type
   |    **void**
   |
   | qualified-method-name:
   |    [ qualified-namespace-name **.** ] method-name
   |
   | method-name:
   |    identifier
   |
   | params-list:
   |    parameter [ **,** params-list ]
   |
   | parameter:
   |    [ parameter-direction ] type identifier
   |
   | parameter-direction:
   |    **ref**
   |    **out**
   |
   | error-list:
   |    qualified-error-domain [ **,** error-list ]
   |
   | method-contracts:
   |    [ **requires** **(** expression **)** ] [ **ensures** **(** expression **)** ]

For more details see :ref:`contract-programming`.

Invocation
----------

See :ref:`invocation-expressions`.

Scope
-----

The execution of a method happens in a scope created for each
invocation, which ceases to exist after execution is complete. The
parent scope of this transient scope is always the scope the method was
declared in, regardless of where it is invoked from.

Parameters and local variables exist in the invocation's transient
scope. For more on scoping see :ref:`scope-and-naming`.

.. _methods-lambdas:

Lambdas
-------

As Vala supports delegates, it is possible to have a method that is
identified by a variable (or field, or parameter.) This section
discusses a Vala syntax for defining inline methods and directly
assigning them to an identifier. This syntax does not add any new
features to Vala, but it is a lot more succinct than the alternative
(defining all methods normally, in order to assign them to variables at
runtime). See :doc:`delegates`.

Declaring an inline method must be done with relation to a delegate or
signal, so that the method signature is already defined. Parameter and
return types are then learned from the signature. A lambda definition is
an expression that returns an instance of a particular delegate type,
and so can be assigned to a variable declared for the same type. Each
time that the lambda expression is evaluated it will return a reference
to exactly the same method, even though this is never an issue as
methods are immutable in Vala.

   | lambda-declaration:
   |    **(** [ lambda-params-list ] **)** **=>** **{** statement-list **}**
   |
   | lambda-params-list:
   |    identifier [ **,** lambda-params-list ]

An example of lambda use:

.. code:: vala
   :number-lines:

   delegate int DelegateType (int a, string b);

   int use_delegate (DelegateType d, int a, string b) {
           return d (a, b);
   }

   int make_delegate () {
           DelegateType d = (a, b) => {
                   return a;
           };
           use_delegate (d, 5, "test");
   }

.. _contract-programming:

Contract programming
--------------------

Vala supports basic `contract
programming <http://en.wikipedia.org/wiki/Contract_programming>`__
features. A method may have preconditions (``requires``) and
postconditions (``ensures``) that must be fulfilled at the beginning or
the end of a method respectively:

.. code:: vala
   :number-lines:

   double method_name (int x, double d)
                   requires (x > 0 && x < 10)
                   requires (d >= 0.0 && d <= 1.0)
                   ensures (result >= 0.0 && result <= 10.0) {
           return d * x;
   }

``result`` is a special variable representing the return value.

For example, if you call ``method_name`` with arguments ``5`` and
``3.0``, it will output a CRITICAL message and return 0.

.. code:: vala
   :number-lines:

   void main () {
           stdout.printf ("%i\n", method_name (5, 3.0));
   }

Output:

::

   CRITICAL **: 03:29:00.588: method_name: assertion 'd >= 0.0 && d <= 1.0' failed
   0

Vala allows you to manage the safety of issued messages at 6 levels:
ERROR, CRITICAL, INFO, DEBUG, WARNING, MESSAGE. For example, the
following code will cause a runtime error.

.. code:: vala
   :number-lines:

   Log.set_always_fatal (LogLevelFlags.LEVEL_CRITICAL | LogLevelFlags.LEVEL_WARNING);
   stdout.printf ("%i\n", method_name (5, 3.0));
