Expressions
===========

Expressions are short pieces of code that define an action that should
be taken when they are reached during a program's execution. Such an
operation can be arithmetical, calling a method, instantiating a type,
and so on. All expressions evaluate to a single value of a particular
type - this value can then be used in another expression, either by
combing the expressions together, or by assigning the value to an
identifier.

When expressions are combined together (e.g. add two numbers, then
multiply the result by another: 5 + 4 \* 3), then the order in which the
sub-expressions are evaluated becomes significant. Parentheses are used
to mark out which expressions should be nested within others, e.g. (5 +
4) \* 3 implies the addition expression is nested inside the
multiplication expression, and so must be evaluated first.

When identifiers are used in expressions they evaluate to their value,
except when used in assignment. The left handed side of an assignment
are a special case of expressions where an identifier is not considered
an expression in itself and is therefore not evaluated. Some operations
combine assignment with another operation (e.g. increment operations,)
in which cases an identifier can be thought of as an expression
initially, and then just an identifier for assignment after the overall
expression has been evaluated.

   | primary-expression:
   |    literal
   |    template
   |    member-access-expression
   |    pointer-member-access-expression
   |    element-access-expression
   |    postfix-expression
   |    class-instantiation-expression
   |    array-instantiation-expression
   |    struct-instantiation-expression
   |    invocation-expression
   |    sizeof-expression
   |    typeof-expression
   |
   | unary-expression:
   |    primary-expression
   |    sign-expression
   |    logical-not-expression
   |    bitwise-not-expression
   |    prefix-expression
   |    ownership-transfer-expression
   |    cast-expression
   |    pointer-expression
   |
   | expression:
   |    conditional-expression
   |    assignment-expression
   |    lambda-expression

.. _literal-expressions:

Literal expressions
-------------------

Each literal expression instantiates its respective type with the value
given.

Integer types... -?[:digit:]+

Floating point types... -?[:digit:]+(.[:digit:]+)?

Strings... "[^"\n]*". """.*"""

Booleans... true|false

A final literal expression is ``null``. This expression evaluates to a
non-typed data instance, which is a legal value for any nullable type
(see :ref:`nullable-types`.)

.. _member-access:

Member access
-------------

To access members of another scope.

   | member-access-expression:
   |    [ primary-expression **.** ] identifier

If no inner expression is supplied, then the identifier will be looked
up starting from the current scope (for example a local variable in a
method). Otherwise, the scope of the inner expression will be used. The
special identifier **this** (without inner expression) inside an
instance method will refer to the instance of the type symbol (class,
struct, enum, etc.).

Element access
--------------

   | element-access-expression:
   |    container **[** indexes **]**
   |
   | container:
   |    expression
   |
   | indexes:
   |    expression [ **,** indexes ]

Element access can be used for:

-  Accessing an element of a container at the given indexes

-  Assigning an element to a container at the given indexes. In this
   case the element access expression is the left handed side of an
   assignment.

Element access can be used on strings, arrays and types that have
**get** and/or **set** methods.

-  On strings you can only access characters, it's not possible to
   assign any value to an element.

-  On arrays, it's possible to both access an element or assign to an
   element. The type of the element access expression is the same as the
   array element type.

Element access can also be used with complex types (such as class,
struct, etc.) as containers:

-  If a **get** method exists accepting at least one argument and
   returning a value, then indexes will be used as arguments and the
   return value as element.

-  If a **set** method exists accepting at least two arguments and
   returns **void**, then indexes will be used as arguments and the
   assigned value as last argument..

Arithmetic operations
---------------------

Binary operators, taking one argument on each side. Each argument is an
expression returning an appropriate type.

Applicable, unless said otherwise, where both operands evaluate to
numeric types (integer or floating point).

Where at least one operand is a of floating point type, the result will
be the same type as the largest floating point type involved. Where both
operands are of integer types, the result will have the same type as the
largest of the integer types involved.

   | additive-expression:
   |    multiplicative-expression
   |    multiplicative-expression **+** multiplicative-expression
   |    multiplicative-expression **-** multiplicative-expression
   |
   | sign-expression:
   |    **+** unary-expression
   |    **-** unary-expression

Adds/Subtracts the second argument to/from the first. Negations is
equivalent to subtraction the operand from 0.

Overflow?

Multiplication/Division:

   | multiplicative-expression:
   |    unary-expression
   |    unary-expression **\*** unary-expression
   |    unary-expression **/** unary-expression
   |    unary-expression **%** unary-expression

Multiplies/divides the first argument by the second.

If both operands are of integer types, then the result will be the
quotient only of the calculation (equivalent to the precise answer
rounded down to an integer value.) If either operand is of a floating
point type, then the result will be as precise as possible within the
boundaries of the result type (which is worked out from the basic
arithmetic type rules.)

Relational operations
---------------------

Result in a value of bool type.

Applicable for comparing two instances of any numeric type, or two
instances of string type. Where numeric with at least one floating point
type instance, operands are both converted to the largest floating point
type involved. Where both operands are of integer type, both are
converted to the largest integer type involved. When both are strings,
they are lexically compared somehow.

   | equality-expression:
   |    relational-expression
   |    relational-expression **==** relational-expression
   |    relational-expression **!=** relational-expression
   |
   | relational-expression:
   |    shift-expression
   |    shift-expression **<** relational-expression
   |    shift-expression **<=** relational-expression
   |    shift-expression **>** relational-expression
   |    shift-expression **>=** relational-expression
   |    is-expression
   |    as-expression

Increment/decrement operations
------------------------------

   | postfix-expression:
   |    primary-expression **++**
   |    primary-expression **--**
   |
   | prefix-expression:
   |    **++** unary-expression
   |    **--** unary-expression

Postfix and prefix expressions:

.. code:: vala
   :number-lines:

   var postfix = i++;
   var prefix = --j;

are equivalent to:

.. code:: vala
   :number-lines:

   var postfix = i;
   i += 1;

   j -= 1;
   var prefix = j;

Logical operations
------------------

Applicable to boolean type operands, return value is of boolean type. No
non boolean type instances are automatically converted.

   | logical-or-expression:
   |    logical-and-expression **\|\|** logical-and-expression

Documentation

   | logical-and-expression:
   |    contained-in-expression **&&** contained-in-expression

Documentation

   | logical-not-expression:
   |    **!** expression

Bitwise operations
------------------

   | bitwise-or-expression:
   |    bitwise-xor-expression **\|** bitwise-xor-expression
   |
   | bitwise-xor-expression:
   |    bitwise-and-expression **^** bitwise-and-expression
   |
   | bitwise-and-expression:
   |    equality-expression **&** equality-expression
   |
   | bitwise-not-expression:
   |    **~** expression

Documentation

   | shift-expression:
   |    additive-expression **<<** additive-expression
   |    additive-expression **>>** additive-expression

Shifts the bits of the left argument left/right by the number
represented by the second argument.

Undefined for shifting further than data size, e.g. with a 32 bit
integer...

Documentation

.. _assignment:

Assignment operations
---------------------

Value assigned to identifier on left. Type must match.

When assignment includes another operation natural result type must
match the declared type of variable which is the left hand side of the
expression. e.g. Let a be an int instance with the value 1, a += 0.5 is
not allowed, as the natural result type of 1 + 0.5 is a float, not an
int.

   | assignment-expression:
   |    simple-assignment-expression
   |    number-assignment-expression
   |
   | simple-assignment-expression:
   |    conditional-expression **=** expression
   |
   | number-assignment-expression:
   |    conditional-expression **+=** expression
   |    conditional-expression **-=** expression
   |    conditional-expression **\*=** expression
   |    conditional-expression **/=** expression
   |    conditional-expression **%=** expression
   |    conditional-expression **\|=** expression
   |    conditional-expression **&=** expression
   |    conditional-expression **^=** expression
   |    conditional-expression **<<=** expression
   |    conditional-expression **>>=** expression

A simple assignment expression assigns the right handed side value to
the left handed side. It is necessary that the left handed side
expression is a valid lvalue. Other assignments:

.. code:: vala
   :number-lines:

   result += value;
   result <<= value;
   ...

Are equivalent to simple assignments:

.. code:: vala
   :number-lines:

   result = result + value;
   result = result << value;
   ...

.. _invocation-expressions:

Invocation expressions
----------------------

   | invocation-expression:
   |    [ **yield** ] primary-expression **(** [ arguments ] **)**
   |
   | arguments:
   |    expression [ **,** arguments]

The expression can refer to any callable: a method, a delegate or a
signal. The type of the expression depends upon the return type of the
callable symbol. Each argument expression type must be compatible
against the respective callable parameter type. If an argument is not
provided for a parameter then:

1. If the parameter has a default value, then that value will be used as
   argument.

2. Otherwise an error occurs.

If the callable has an ellipsis parameter, then any number of arguments
of any type can be provided past the ellipsis.

Delegates... See :doc:`delegates`

Firing a signal is basically the same. See :ref:`class-signals`

Class instantiation
-------------------

To instantiate a class (create an instance of it) use the ``new``
operator. This operator takes a the name of the class, and a list of
zero or more arguments to be passed to the creation method.

   | class-instantiation-expression:
   |    **new** type-name **(** arguments **)**
   |
   | arguments:
   |    expression [ **,** arguments ]

.. _struct-expression:

Struct instantiation
--------------------

   | struct-instantiation-expression:
   |    type-name **(** arguments **)** [ **{** initializer **}** ]
   |
   | initializer:
   |    field-name **=** expression [ **,** initializer ]
   |
   | arguments:
   |    expression [ **,** arguments ]

.. _array-expression:

Array instantiation
-------------------

This expression will create an array of the given size. The second
approach shown below is a shorthand to the first one.

   | array-instantiation-expression:
   |    **new** type-name **[** sizes **]** [ **{** [ initializer ] **}** ] **{** initializer **}**
   |
   | sizes:
   |    expression [ **,** sizes ]
   |
   | initializer:
   |    expression [ **,** initializer ]

Sizes expressions must evaluate either to an integer type or an enum
value. Initializer expressions type must be compatible with the array
element type.

Conditional expressions
-----------------------

Allow a conditional in a single expression.

   | conditional-expression:
   |    boolean-expression [ **?** conditional-true-clause **:** conditional-false-clause ]
   |
   | boolean-expression:
   |    coalescing-expression
   |
   | conditional-true-clause:
   |    expression
   |
   | conditional-false-clause
   |    expression

First boolean-expression is evaluated. If true, then the
conditional-true-clause is evaluated, and its result is the result of
the conditional expression. If the boolean expression evaluates to
false, then the conditional-false-clause is evaluated, and its result
becomes the result of the conditional expression.

Coalescing expressions
----------------------

   | coalescing-expression:
   |    nullable-expression [ **??** coalescing-expression ]
   |
   | nullable-expression:
   |    logical-or-expression

.. _flag-operations:

Flag operations
---------------

Flag types are a variation on enumerated types, in which any number of
flag values can be combined in a single instance of the flag type. There
are therefore operations available to combine several values in an
instance, and to find out which values are represented in an instance.

   | flag-combination-expression:
   |    expression **\|** expression

Where both expressions evaluate to instances of the same flag type, the
result of this expression is a new instance of the flag type in which
all values represented by either operand are represented.

   | flag-recombination-expression:
   |    expression **^** expression

Where both expressions evaluate to instances of the same flag type, the
result of this expression is a new instance of the flag type in which
all values represented by exactly one of the operands are represented.

   | flag-separation-expression:
   |    expression **&** expression

Where both expressions evaluate to instances of the same flag type, the
result of this expression is a new instance of the flag type in which
all values represented by both operands are represented.

   | flag-in-expression:
   |    expression **in** expression

Where both expressions evaluate to instances of the same flag type, the
result of this expression is a boolean. The result will be true if the
left-handed flag is set into the right-handed flags.

.. _type-operations:

Type operations
---------------

   | is-expression:
   |    shift-expression **is** type-name

Performs a runtime type check on the instance resulting from evaluating
the nested expression. If the instance is an instance of the type
described (with, for example, a class or interface name,) the overall
expression evaluates to true.

Casting:

   | cast-expression:
   |    **(!)** unary-expression
   |    **(** type-name **)** unary-expression

A cast expression returns the instance created in the nested expression
as an instance of the type described. If the nested expression evaluates
to an instance of a type that is not also an instance of the given type,
the expression is not valid. If you are not sure whether the cast is
valid, instead use an "as" expression.

   | as-expression:
   |    shift-expression **as** type-name

An "as" expression combines an "is" expression and a cast operation,
with the latter depending on the former. If the nested expression
evaluates to an instance of the given type, then a cast is performed and
the expression evaluates to the result of the nested expression cast as
the given type. Otherwise, the result is null.

   | sizeof-expression:
   |    **sizeof (** type-name **)**
   |
   | typeof-expression:
   |    **typeof (** type-name **)**

.. _ownership-transfer-expressions:

Ownership transfer expressions
------------------------------

   | ownership-transfer-expression:
   |    **(owned)** unary-expression

When an instance of a reference type is assigned to a variable or field,
it is possible to request that the ownership of the instance is passed
to the new field or variable. The precise meaning of this depends on the
reference type, for an explanation of ownership, see
:ref:`references-ownership`. The identifier in this expression must refer to an instance of a
reference type.

Note that similar syntax is used to define that a method parameter
should take ownership of a value assigned to it. For this, see
:doc:`methods`.

Lambda expressions
------------------

   | lambda-expression:
   |    params **=>** body
   |
   | params:
   |    [ direction ] identifier **(** [ param-names ] **)**
   |
   | param-names:
   |    [ direction ] identifier [ **,** param-names ]
   |
   | direction:
   |    **out**
   |    **ref**
   |
   | body:
   |    statement-block
   |    expression

.. _pointer-expressions:

Pointer expressions
-------------------

   | addressof-expression:
   |    **&** unary-expression

The "address of" expression evaluates to a pointer to the inner
expression. Valid inner expressions are:

-  Variables (local variables, fields and parameters)

-  Element access whose container is an array or a pointer



  | pointer-indirection-expression:
  |    **\*** unary-expression

The pointer indirection evaluates to the value pointed to by the inner
expression. The inner expression must be a valid pointer type and it
must not be a pointer to a reference type (for example pointer
indirection to a type ``SomeClass*`` is not possible).

   | pointer-member-access-expression:
   |    primary-expression **->** identifier

This expression evaluates to the value of the member identified by the
identifier. The inner expression must be a valid pointer type and the
member must be in the scope of the base type of the pointer type.
