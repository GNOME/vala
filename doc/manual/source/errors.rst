Errors
======

Vala Error handling is just for recoverable runtime errors, anything
that can be reasonably foreseen should not be handled with errors, e.g.
passing the wrong args to a method. In that example, a better action is
to state that the method's result is undefined on illegal input, and use
method contracts or assertions to catch potential problems during
development: See :ref:`contract-programming`.
A more suitable use for errors would be reporting missing files, which
of course cannot be detected until the program is running.

A method may declare that it throws methods from any number of error
domains. Error domains are groups of related errors, each of which is
denoted by a unique symbol in much the same way an enumerated type, see
:ref:`enums-error-domain`
for declaration syntax. In Vala it is not allowed to throw arbitrary
data as in C++, and there is no class for errors, as in Java.

No error can be thrown must either be caught or declared as being
thrown.

When a method declares it may thrown an error, the invoker may choose to
either catch the error (should one be thrown), or ignore it, meaning it
will be thrown on to that methods caller. In the latter case, the method
failing to catch the error must also be declared to throw that type of
error. Errors can only be caught when the method throwing it is invoked
within the try block of a try statement. A try statement, with its
associated catch blocks, can potentially catch all errors thrown in its
scope, either with catch blocks for all error domains from which a
thrown error might come, or with a generic catch block to catch any
error.

When an error is first thrown, the "throw" statement is considered the
same as a method which from which an error has been thrown. This means
that it is possible to catch errors locally, but this is not good
practise. The only proper use of this functionality is to use a finally
block to free resources before the error is thrown from the method.

When an error is thrown, the following sequence of events happens:

NB: finally clauses are always run, regardless of if error is thrown
and/or handled.

Error throwing
--------------

Throwing an error is done with the following syntax:

   | throw-statement:
   |    **throw** error-description **;**
   |
   | error-description:
   |    identifier
   |    error-creation-expression
   |
   | error-creation-expression:
   |    **new** qualified-error-type **(** message-expression **)**
   |
   | qualified-error-type:
   |    qualified-error-domain **.** error-type
   |
   | qualified-error-domain:
   |    [ qualified-namespace-name **.** ] error-domain-name

That is, throw an error that has already been created and can be
identified by a name, or a new error created with a textual description.
The message-expression is any expression that evaluates to a instance of
the string type.

.. _error-catching:

Error catching
--------------

The syntax of the try statement:

   | try-statement:
   |    **try** statement-block catch-clauses
   |    **try** statement-block [catch-clauses] finally-clause
   |
   | catch-clauses:
   |    [ specific-catch-clauses ] general-catch-clause
   |
   | specific-catch-clauses:
   |    specific-catch-clause [ specific-catch-clauses ]
   |
   | specific-catch-clause:
   |    **catch** **(** qualified-error-type identifier **)** statement-block
   |
   | general-catch-clause:
   |    **catch** statement-block
   |
   | finally-clause:
   |    **finally** statement-block

In the statement block scope of each catch clause, the error is assigned
to a variable with the identifier given.

Examples
--------

Demonstrating...

.. code:: vala
   :number-lines:

   errordomain ErrorType1 {
       CODE_1A
   }

   errordomain ErrorType2 {
       CODE_2A
   }

   void thrower () throws ErrorType1, ErrorType2 {
       throw new ErrorType2.CODE_1A ("Error");
   }

   void catcher () throws ErrorType2 {
       try {
           thrower ();
       } catch (ErrorType1 ex) {
           // Deal with ErrorType1
       } finally {
           // Tidy up
       }
   }

   void main () {
       try {
           catcher ();
       } catch (ErrorType2 ex) {
           // Deal with ErrorType2
       }
   }
