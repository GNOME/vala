Statements
==========

Statements define the path of execution within methods and similar
constructions. They combine expressions together with structures for
choosing between different code paths, repeating code sections, etc.

   | statement:
   |    empty-statement
   |    simple-statement
   |    statement-block
   |    variable-declaration-statement
   |    if-statement
   |    switch-statement
   |    while-statement
   |    do-statement
   |    for-statement
   |    foreach-statement
   |    return-statement
   |    throw-statement
   |    try-statement
   |    lock-statement
   |    unlock-statement
   |    with-statement
   |
   | embedded-statement:
   |    statement

.. _simple-statements:

Simple statements
-----------------

The Empty Statement does nothing, but is a valid statement nonetheless,
and so can be used wherever a statement is required.

   | empty-statement:
   |    **;**

A Simple Statement consists of one a subset of expressions that are
considered free-standing. Not all expressions are allowed, only those
that potentially have a useful side effect - for example, arithmetic
expressions cannot form simple statements on their own, but are allowed
as part of an assignment expressions, which has a useful side effect.

   | simple-statement:
   |    statement-expression **;**
   |
   | statement-expression:
   |    assignment-expression
   |    class-instantiation-expression
   |    struct instantiation-expression
   |    invocation-expression

A Statement Block allows several statements to be used in a context that
would otherwise only allow one.

   | statement-block:
   |    **{** [ statement-list ] **}**
   |
   | statement-list:
   |    statement [ statement-list ]

Blocks create anonymous, transient scopes. For more details about
scopes, see :ref:`scope-and-naming`.

.. _variable-declaration:

Variable declaration
--------------------

Variable Declaration Statements define a local variable in current
scope. The declaration includes a type, which signifies the variable
will represent an instance of that type. Where the type can be inferred
by the compiler, the type-name can be replaced with the literal "var"

   | variable-declaration-statement:
   |    variable-declaration-with-explicit-type
   |    variable-declaration-with-explicit-type-and-initialiser
   |    variable-declaration-with-type-inference
   |
   | variable-declaration-with-explicit-type:
   |    type-name identifier **;**
   |
   | variable-declaration-with-explicit-type-and-initialiser:
   |    type-name identifier **=** expression **;**
   |
   | variable-declaration-with-type-inference:
   |    var identifier **=** expression **;**

Type inference is possible in any case where the variable is immediately
assigned to. The type chosen will always be the type of the assigned
expression, as decided by the rules described at :doc:`expressions`.
It is important to realise that the type of the variable will be fixed
after the first assignment, and will not change on assigning another
value to the variable. If the variable should be created with a type
other than that of the assigned expression, the expression should be
wrapped with a cast expression, provided that the cast is valid.

Selection statements
--------------------

The If Statement decides whether to execute a given statement based on
the value of a boolean expression. There are two possible extensions to
this model:

An else clause declares that a given statement should be run
if-and-only-if the condition in the if statement fails.

Any number of "else if" clauses may appear between the "if" statement
and its "else" clause (if there is one.) These are equivalent to:

FIXME: This doesn't work.

In simple terms, the program will test the conditions of the if
statement and its "else if" clauses in turn, executing the statement
belonging to the first that succeeds, or running the else clause if
every condition fails.

   | if-statement:
   |    **if** **(** boolean-expression **)** embedded-statement [ elseif-clauses ] [ **else** embedded-statement ]
   |
   | elseif-clauses:
   |    elseif-clause
   |    [ elseif-clauses ]
   |
   | elseif-clause:
   |    **else if** **(** boolean-expression **)** embedded-statement

The switch statement decides which of a set of statements to execute
based on the value of an expression. A switch statement will lead to the
execution of one or zero statements. The choice is made by:

   | switch-statement:
   |    **switch** **(** expression **)** **{** [ case-clauses ] [ default-clause ] **}**
   |
   | case-clauses:
   |    case-clause
   |    [ case-clauses ]
   |
   | case-clause:
   |    **case** literal-expression **:** embedded-statement
   |    break-statement
   |
   | default-clause:
   |    **default** **:** embedded-statement
   |    break-statement

Iteration statements
--------------------

Iteration statements are used to execute statements multiple times based
on certain conditions. Iteration Statements contain loop embedded
statements - a superset of embedded statements which adds statements for
manipulating the iteration.

   | loop-embedded-statement:
   |    loop-embedded-statement-block
   |    embedded-statement
   |    break-statement
   |    continue-statement
   |
   | loop-embedded-statement-block:
   |    **{** [ loop-embedded-statement-list ] **}**
   |
   | loop-embedded-statement-list:
   |    loop-embedded-statement [ loop-embedded-statement-list ]

Both break and continue statement are types of jump statement, described
in :ref:`jump-statement`.

While Statement
~~~~~~~~~~~~~~~

The ``while`` statement conditionally executes an embedded statement
zero or more times. When the while statement is reached, the boolean
expression is executed. If the boolean value is true, the embedded
statement is executed and execution returns to the ``while`` statement.
If the boolean value is false, execution continues after the ``while``
statement.

   | while-statement:
   |    **while** **(** boolean-expression **)** loop-embedded-statement

The ``do`` statement conditionally executes an embedded statement one or
more times. First the embedded statement is executed, and then the
boolean expression is evaluated. If the boolean value is true, execution
returns to the ``do`` statement. If the boolean value is false,
execution continues after the ``do`` statement.

   | do-statement:
   |    **do** loop-embedded-statement **while** **(** boolean-expression **)** **;**

For Statement
~~~~~~~~~~~~~

The ``for`` statement first evaluates a sequence of initialization
expressions and then repeatedly executes an embedded statement. At the
start of each iteration a boolean expression is evaluated, with a true
value leading to the execution of the embedded statement, a false value
leading to execution passing to the first statement following the
``for`` statement. After each iteration a sequence of iteration
expressions are evaluated. Executing this type of statement creates a
new transient scope, in which any variables declared in the initializer
are created.

   | for-statement:
   |    **for** **(** [ for-initializer ] **;** [ for-condition ] **;** [ for-iterator ] **)** loop-embedded-statement
   |
   | for-initializer:
   |    variable-declaration [ **,** expression-list ]
   |
   | for-condition:
   |    boolean-expression
   |
   | for-iterator:
   |    expression-list

Foreach Statement
~~~~~~~~~~~~~~~~~

The ``foreach`` statement enumerates the elements of a collection,
executing an embedded statement for each element of the collection. Each
element in turn is assigned to a variable with the given identifier and
the embedded statement is executed. Executing this type of statement
creates a new transient scope in which the variable representing the
collection element exists.

   | foreach-statement:
   |     **foreach** **(** type identifier **in** expression **)** loop-embedded-statement

Foreach Statements are able to iterate over arrays and any class that
implements the ``Gee.Iterable`` interface. This may change in future if
an Iterable interface is incorporated into GLib.

.. _jump-statement:

Jump Statements
---------------

Jump statements move execution to an arbitrary point, dependent on the
type of statement and its location. In any of these cases any transient
scopes are ended appropriately: :ref:`scope-and-naming` and :ref:`simple-statements`.

A ``break`` statement moves execution to the first statement after the
nearest enclosing ``while``, ``do``, ``for``, or ``foreach`` statement.

   | break-statement:
   |    **break** **;**

A ``continue`` statement immediately moves execution the nearest
enclosing ``while``, ``do``, ``for``, or ``foreach`` statement.

   | continue-statement:
   |    **continue** **;**

The ``return`` statement ends the execution of a method, and therefore
completes the invocation of the method. The invocation expression has
then been fully evaluated, and takes on the value of the expression in
the ``return`` statement if there is one.

   | return-statement:
   |    **return** [ expression ] **;**

The throw statement throws an exception.

   | throw-statement:
   |    **throw** expression **;**

Try Statement
-------------

The ``try`` statement provides a mechanism for catching exceptions that
occur during execution of a block. Furthermore, the ``try`` statement
provides the ability to specify a block of code that is always executed
when control leaves the ``try`` statement.

For the syntax of the try statement, See :ref:`error-catching`.

Lock Statement
--------------

``lock`` statements are the main part of Vala's resource control
mechanism.

FIXME: Haven't actually written anything here about resource control.

   | lock-statement:
   |    **lock** **(** identifier **)** [ embedded-statement ] **;**

Unlock Statement
----------------

``unlock`` statements are the main part of Vala's resource control
mechanism.

FIXME: Haven't actually written anything here about resource control.

   | unlock-statement:
   |    **unlock** **(** identifier **)** **;**

With Statement
--------------

The ``with`` statement creates data type scoped blocks which allow
implicit member access to the given expression or declaration statement.

   | with_statement:
   |    **with** **(** [ var \| unowned var \| type-name) identifier **=** ] expression **)** embedded_statement
