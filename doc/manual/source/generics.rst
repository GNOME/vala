Generics
========

Generic programming is a way of defining that something is applicable to
a variety of potential types, without having to know these types before
hand. The classic example would be a collection such as a list, which
can be trivially customised to contain any type of data elements.
Generics allow a Vala programmer to have these customisations done
automatically.

Some of these are possible, which?

-  class Wrapper<T> : Object { ... }

-  new Wrapper<Object> ();

-  BUG: class StringWrapper : Wrapper<string> () { ... }

-  FAIL: class WrapperWrapper<Wrapper<T>> : Object { ... }

-  FAIL: new WrapperWrapper<Wrapper<Object>> () ;

-  interface IWrapper<T> { ... }

-  class ImpWrapper1<T> : Object, IWrapper<T> { ... }

-  BUG: class ImpWrapper2 : Object, IWrapper<string> { ... }

Generics declaration
--------------------

Some of the syntax could be best placed in the class/interface/struct
pages, but that might overcomplicate them...

In class declaration - In struct declaration - In interface declaration
- In base class declaration - In implemented interfaces declaration - In
prerequesite class/interface declaration.

Declaration with type parameters introduces new types into that scope,
identified by names given in declaration, e.g. T.

   | qualified-type-name-with-generic:
   |    qualified-class-name-with-generic
   |    qualified-interface-name-with-generic
   |    qualified-struct-name-with-generic
   |
   | qualified-class-name-with-generic:
   |    [ qualified-namespace-name **.** ] class-name type-parameters
   |
   | qualified-interface-name-with-generic:
   |    [ qualified-namespace-name **.** ] interface-name type-parameters
   |
   | qualified-struct-name-with-generic:
   |    [ qualified-namespace-name **.** ] struct-name type-parameters
   |
   | type-parameters:
   |    **<** generic-clause **>**
   |
   | generic-clause:
   |    type-identifier [ **,** generic-clause ]
   |    qualified-type-name [ **,** generic-clause ]
   |
   | type-identifier:
   |    identifier

type-identifier will be the type-name for the parameterised type.

Deal is: in the class/interface/struct sections, replace
qualified-*-name with qualified-*-name-with-generic.

Instantiation
-------------

Only explanation here? Syntax should go with variable declaration
statement?

When using generic for a type-name, only type-names can be used as
type-parameters, not identifiers. NB. in scope of generic class, T etc.
is a real type-name.

Examples
--------

Demonstrating...

.. code:: vala
   :number-lines:

   public interface With<T> {
       public abstract void sett (T t);
       public abstract T gett ();
   }

   public class One : Object, With<int> {
       public int t;

       public void sett (int t) {
           this.t = t;
       }
       public int gett () {
           return t;
       }
   }

   public class Two<T,U> : Object, With<T> {
       public T t;

       public void sett (T t) {
           this.t = t;
       }
       public T gett () {
           return t;
       }

       public U u;
   }

   void main () {
       var o = new One ();
       o.sett (5);
       stdout.printf ("%d\n", o.t);

       var t = new Two<int,double?> ();
       t.sett (5);
       stdout.printf ("%d\n", t.t);

       t.u = 5.0f;
       stdout.printf ("%f\n", t.u);
   }
