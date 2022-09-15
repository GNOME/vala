Interfaces
==========

An interface in Vala is a non-instantiable type. A class may implement
any number of interfaces, thereby declaring that an instance of that
class should also be considered an instance of those interfaces.
Interfaces are part of the GType system, and so compact classes may not
implement interfaces (see :ref:`classes-types`.)

The simplest interface declaration looks like this:

.. code:: vala
   :number-lines:

   interface InterfaceName {
   }

Unlike C# or Java, Vala's interfaces may include implemented methods,
and so provide premade functionality to an implementing class, similar
to mixins in other languages. All methods defined in a Vala interface
are automatically considered to be virtual. Interfaces in Vala may also
have prerequisites - classes or other interfaces that implementing
classes must inherit from or implement. This is a more general form of
the interface inheritance found in other languages. It should be noted
that if you want to guarantee that all implementors of an interface are
GObject type classes, you should give that class as a prerequisite for
the interface.

Interfaces in Vala have a static scope, identified by the name of the
interface. This is the only scope associated with them (i.e. there is no
class or instance scope created for them at any time.) Non-instance
members of the interface (static members and other declarations,) can be
identified using this scope.

For an overview of object oriented programming, see :ref:`object-oriented`.

Interface declaration
---------------------

	   | interface-declaration:
	   |    [ access-modifier ] **interface** qualified-interface-name [ inheritance-list ] **{** [ interface-members ] **}**
	   |
	   | qualified-interface-name:
	   |    [ qualified-namespace-name **.** ] interface-name
	   |
	   | interface-name:
	   |    identifier
	   |
	   | inheritance-list:
	   |    **:** prerequisite-classes-and-interfaces
	   |
	   | prerequisite-classes-and-interfaces:
	   |    qualified-class-name [ **,** prerequisite-classes-and-interfaces ]
	   |    qualified-interface-name [ **,** prerequisite-classes-and-interfaces ]
	   |
	   | interface-members:
	   |    interface-member [ interface-members ]
	   |
	   | interface-member:
	   |    interface-constant-declaration
	   |    interface-delegate-declaration
	   |    interface-enum-declaration
	   |    interface-instance-member
	   |    interface-static-member
	   |    interface-inner-class-declaration
	   |    abstract-method-declaration
	   |
	   | interface-instance-member:
	   |    interface-instance-method-declaration
	   |    interface-instance-abstract-method-declaration
	   |    interface-instance-property-declaration
	   |    interface-instance-signal-declaration
	   |
	   | interface-static-member:
	   |    interface-static-field-declaration
	   |    interface-static-method-declaration

Interface fields
----------------

As an interface is not instantiable, it may not contain data on a per
instance basis. It is though allowable to define static fields in an
interface. These are equivalent to static fields in a class: they exist
exactly once regardless of how many instances there are of classes that
implement the interface.

The syntax for static interface fields is the same as the static class
fields: See :ref:`class-fields`.
For more explanation of static vs instance members, see :ref:`types-class-members`.

Interface methods
-----------------

Interfaces can contain abstract and non abstract methods. A non-abstract
class that implements the interface must provide implementations of all
abstract methods in the interface. All methods defined in an interface
are automatically virtual.

Vala interfaces may also define static methods. These are equivalent to
static methods in classes.

   | interface-instance-method-declaration:
   |    [ class-member-visibility-modifier ] return-type method-name **(** [ params-list ] **)** method-contracts [ **throws** exception-list ] **{** statement-list **}**
   |
   | interface-instance-abstract-method-declaration:
   |    [ class-member-visibility-modifier ] **abstract** return-type method-name **(** [ params-list ] **)** method-contracts [ **throws** exception-list ] **;**
   |
   | interface-static-method-declaration:
   |    [ class-member-visibility-modifier ] **static** return-type method-name **(** [ params-list ] **)** method-contracts [ **throws** exception-list ] **{** statement-list **}**

For discussion of methods in classes, see: :ref:`class-methods`.
For information about methods in general, see :doc:`methods`.
Of particular note is that an abstract method of an interface defines a
method that can always be called in an instance of an interface, because
that instance is guaranteed to be of a non-abstract class that
implements the interface's abstract methods.

Interface properties
--------------------

Interfaces can contain properties in a similar way to classes. As
interfaces can not contain per instance data, interface properties
cannot be created automatically. This means that all properties must
either be declared abstract (and implemented by implementing classes,)
or have explicit get and set clauses as appropriate. Vala does not allow
an abstract property to be partially implemented, instead it should just
define which actions (get, set or both) should be implemented.

Interfaces are not constructed so there is no concept of an interface
construction property.

   | interface-instance-property-declaration:
   |    [ class-member-visibility-modifier ] [ class-method-type-modifier ] qualified-type-name property-name **{** accessors [ default-value ] **}** **;**
   |    [ class-member-visibility-modifier ] **abstract** qualified-type-name property-name **{** automatic-accessors **}** **;**

For properties in classes see :ref:`classes-properties`.

Interface signals
-----------------

Signals can be defined in interfaces. They have exactly the same
semantics as when directly defined in the implementing class.

   | interface-instance-signal-declaration:
   |    class-instance-signal-declaration

Other interface members
-----------------------

Constants, Enums, Delegates and Inner Classes all function the same as
when they are declared in a class. See :doc:`classes`.
When declared in an interface, all these members can be accessed either
using the name of the interface (that is, of the static interface
scope), or through and instance of an implementing class.

Examples
--------

Here is an example implementing (and overriding) an *abstract* interface
method,

.. code:: vala
   :number-lines:

   /*
      This example gives you a simple interface, Speaker, with
      - one abstract method, speak

      It shows you three classes to demonstrate how these and overriding them behaves:
      - Fox, implementing Speaker
      - ArcticFox, extending Fox AND implementing Speaker
        (ArcticFox.speak () replaces superclasses' .speak ())
      - RedFox, extending Fox BUT NOT implementing speaker
        (RedFox.speak () does not replace superclasses' .speak ())

      Important notes:
      - generally an object uses the most specific class's implementation
      - ArcticFox extends Fox (which implements Speaker) and implements Speaker itself,
        - ArcticFox defines speak () with new, so even casting to Fox or Speaker still
          gives you ArcticFox.speak ()
      - RedFox extends from Fox, but DOES NOT implement Speaker
        - RedFox speak () gives you RedFox.speak ()
        - casting RedFox to Speaker or Fox gives you Fox.speak ()
   */

   /* Speaker: extends from GObject */
   interface Speaker : Object {
     /* speak: abstract without a body */
     public abstract void speak ();
   }

   /* Fox: implements Speaker, implements speak () */
   class Fox : Object, Speaker {
     public void speak () {
       stdout.printf ("  Fox says Ow-wow-wow-wow\n");
     }
   }

   /* ArcticFox: extends Fox; must also implement Speaker to re-define
    *            inherited methods and use them as Speaker */
   class ArcticFox : Fox, Speaker {
     /* speak: uses 'new' to replace speak () from Fox */
     public new void speak () {
       stdout.printf ("  ArcticFox says Hatee-hatee-hatee-ho!\n");
     }
   }

   /* RedFox: extends Fox, does not implement Speaker */
   class RedFox : Fox {
     public new void speak () {
       stdout.printf ("  RedFox says Wa-pa-pa-pa-pa-pa-pow!\n");
     }
   }

   void main () {
     Speaker f = new Fox ();
     Speaker a = new ArcticFox ();
     Speaker r = new RedFox ();

     stdout.printf ("\n\n// Fox implements Speaker, speak ()\n");
     stdout.printf ("Fox as Speaker:\n");
     (f as Speaker).speak ();   /* Fox.speak () */
     stdout.printf ("\nFox as Fox:\n");
     (f as Fox).speak ();       /* Fox.speak () */

     stdout.printf ("\n\n// ArcticFox extends Fox, re-implements Speaker and " +
                    "replaces speak ()\n");
     stdout.printf ("ArcticFox as Speaker:\n");
     (a as Speaker).speak ();   /* ArcticFox.speak () */
     stdout.printf ("ArcticFox as Fox:\n");
     (a as Fox).speak ();       /* ArcticFox.speak () */
     stdout.printf ("\nArcticFox as ArcticFox:\n");
     (a as ArcticFox).speak (); /* ArcticFox.speak () */

     stdout.printf ("\n\n// RedFox extends Fox, DOES NOT re-implement Speaker but" +
                    " does replace speak () for itself\n");
     stdout.printf ("RedFox as Speaker:\n");
     (r as Speaker).speak ();   /* Fox.speak () */
     stdout.printf ("\nRedFox as Fox:\n");
     (r as Fox).speak ();       /* Fox.speak () */
     stdout.printf ("\nRedFox as RedFox:\ņ");
     (r as RedFox).speak ();    /* RedFox.speak () */
   }

Here is an example of implementing (and inheriting) a *virtual*
interface method. Note that the same rules for subclasses
re-implementing methods that apply to the *abstract* interface method
above apply here.

.. code:: vala
   :number-lines:

   /*
      This example gives you a simple interface, Yelper, with
      - one virtual default method, yelp

      It shows you two classes to demonstrate how these and overriding them behaves:
      - Cat, implementing Yelper (inheriting yelp)
      - Fox, implementing Yelper (overriding yelp)

      Important notes:
      - generally an object uses the most specific class's implementation
      - Yelper provides a default yelp (), but Fox overrides it
        - Fox overriding yelp () means that even casting Fox to Yelper still gives
          you Fox.yelp ()
      - as with the Speaker/speak () example, if a subclass wants to override an
        implementation (e.g. Fox.yelp ()) of a virtual interface method
        (e.g. Yelper.yelp ()), it must use 'new'
      - 'override' is used when overriding regular class virtual methods,
        but not when implementing interface virtual methods.
   */

   interface Yelper : Object {
     /* yelp: virtual, if we want to be able to override it */
     public virtual void yelp () {
       stdout.printf ("  Yelper yelps Yelp!\n");
     }
   }

   /* Cat: implements Yelper, inherits virtual yelp () */
   class Cat : Object, Yelper {
   }

   /* Fox: implements Yelper, overrides virtual yelp () */
   class Fox : Object, Yelper {
     public void yelp () {
       stdout.printf ("  Fox yelps Ring-ding-ding-ding-dingeringeding!\n");
     }
   }

   void main () {
     Yelper f = new Fox ();
     Yelper c = new Cat ();

     stdout.printf ("// Cat implements Yelper, inherits yelp\n");
     stdout.printf ("Cat as Yelper:\n");
     (c as Yelper).yelp ();  /* Yelper.yelp () */
     stdout.printf ("\nCat as Cat:\n");
     (c as Cat).yelp ();     /* Yelper.yelp () */

     stdout.printf ("\n\n// Fox implements Yelper, overrides yelp ()\n");
     stdout.printf ("Fox as Yelper:\n");
     (f as Yelper).yelp ();  /* Fox.yelp () */
     stdout.printf ("\nFox as Fox:\n");
     (f as Fox).yelp ();     /* Fox.yelp () */
   }
