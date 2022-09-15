Preprocessor
============

The Vala preprocessor is a particular part of Vala that acts at syntax
level only, allowing you to conditionally write pieces of your software
depending upon certain compile-time conditions. Preprocessor directives
will never be generated in the resulting code.

Directives syntax
-----------------

All preprocessor directives start with a hash (**#**), except for the
first line of a file starting with **#!** (used for Vala scripts).

   | vala-code:
   |    [ any vala code ] [ pp-condition ] [ any vala code ]
   |
   | pp-condition:
   |    **#if** pp-expression vala-code [ pp-elif ] [ pp-else ] **#endif**
   |
   | pp-elif:
   |    **#elif** pp-expression vala-code [ pp-elif ]
   |
   | pp-else:
   |    **#else** vala-code
   |
   | pp-expression:
   |    pp-or-expression
   |
   | pp-or-expression:
   |    pp-and-expression [ **\|\|** pp-and-expression ]
   |
   | pp-and-expression:
   |    pp-binary-expression [ **&&** pp-binary-expression ]
   |
   | pp-binary-expression:
   |    pp-equality-expression
   |    pp-inequality-expression
   |
   | pp-equality-expression:
   |    pp-unary-expression [ **==** pp-unary-expression ]
   |
   | pp-inequality-expression:
   |    pp-unary-expression [ **!=** pp-unary-expression ]
   |
   | pp-unary-expression:
   |    pp-negation-expression
   |    pp-primary-expression
   |
   | pp-negation-expression:
   |    **!** pp-unary-expression
   |
   | pp-primary-expression:
   |    pp-symbol
   |    **(** pp-expression **)**
   |    **true**
   |    **false**
   |
   | pp-symbol:
   |    identifier

The semantics of the preprocessor are very simple: if the condition is
true then the Vala code surrounded by the preprocessor will be parsed,
otherwise it will be ignored. A symbol evaluates to **true** if it is
defined at compile-time. If a symbol in a preprocessor directive is not
defined, it evaluates to **false**.

Defining symbols
----------------

It's not possible to define a preprocessor symbol inside the Vala code
(like with C). The only way to define a symbol is to feed it through the
``valac`` option ``-D``.

Built-in defines
----------------

.. list-table::
   :header-rows: 1
   :widths: 25 75

   * - Name
     - Description
   * - ``POSIX``
     - Set if the profile is posix
   * - ``GOBJECT``
     - Set if the profile is gobject
   * - ``VALA_X_Y``
     - Set if Vala API version is equal or higher to version X.Y

Examples
--------

How to conditionally compile code based on a ``valac`` option ``-D``.

Sample code:

vala-test:examples/advanced.vala

.. code:: vala
   :number-lines:

   // Vala preprocessor example
   public class Preprocessor : Object {

       /* public instance method */
       public void run () {
   #if PREPROCESSOR_DEBUG
           // Use "-D PREPROCESSOR_DEBUG" to run this code path
           stdout.printf ("debug version");
   #else
           // Normally, we run this code path
           stdout.printf ("production version");
   #endif
       }
   }

   /* application entry point */
   void main () {
       var sample = new Preprocessor ();
       sample.run ();
   }

Compile and Run
~~~~~~~~~~~~~~~

Normal build/run:

::

   $ valac -o preprocessor Preprocessor.vala
   $ ./preprocessor

Debug build/run:

::

   $ valac -D PREPROCESSOR_DEBUG -o preprocessor-debug Preprocessor.vala
   $ ./preprocessor-debug
