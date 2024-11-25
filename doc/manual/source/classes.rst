Classes
=======

A class is definition of a data type. A class can contain fields,
constants, methods, properties, and signals. Class types support
inheritance, a mechanism whereby a derived class can extend and
specialize a base class.

The simplest class declaration looks like this:

.. code:: vala
   :number-lines:

   class ClassName {
   }

As class types support inheritance, you can specify a base class you
want to derive from. A derived class is-a superclass. It gets access to
some of its methods etc. It can always be used in place of a and so
on....

No classes can have multiple base classes, however GObject subclasses
may implement multiple interfaces. By implementing an interface, a
classed type has an is-a relationship with an interface. Whenever an
instance of that interface is expected, an instance of this class will
do.

.. _classes-types:

Types of class
--------------

Vala supports three different types of class:

-  GObject subclasses are any classes derived directly or indirectly
   from GLib.Object. This is the most powerful type of class, supporting
   all features described in this page. This means signals, managed
   properties, interfaces and complex construction methods, plus all
   features of the simpler class types.

-  Fundamental GType classes are those either without any superclass or
   that don't inherit at any level from GLib.Object. These classes
   support inheritance, interfaces, virtual methods, reference counting,
   unmanaged properties, and private fields. They are instantiated
   faster than GObject subclasses but are less powerful - it isn't
   recommended in general to use this form of class unless there is a
   specific reason to.

-  Compact classes, so called because they use less memory per instance,
   are the least featured of all class types. They are not registered
   with the GType system and do not support reference counting, virtual
   methods, or private fields. They do support unmanaged properties.
   Such classes are very fast to instantiate but not massively useful
   except when dealing with existing libraries. They are declared using
   the Compact attribute on the class, See

Any non-compact class can also be defined as abstract. An abstract class
cannot be instantiated and is used as a base class for derived classes.

.. _types-class-members:

Types of class members
----------------------

There are three fundamentally different types of class members,
instance, class and static.

-  Instance members are held per instance of the class. That is, each
   instance has its own copies of the members in its own instance scope.
   Changes to instance fields will only apply to that instance, calling
   instance methods will cause them to be executed in the scope of that
   instance.

-  Class members are shared between all instances of a class. They can
   be accessed without an instance of the class, and class methods will
   execute in the scope of the class.

-  Static members are shared between all instances of a class and any
   sub-classes of it. They can be accessed without an instance of the
   class, and static methods will execute in the scope of the class.

The distinction between class and static members is not common to other
object models. The essential difference is that a sub-class will receive
a copy of all its base classes' class members. This is opposed to static
members, of which there is only one copy - sub classes access can their
base classes' static members because they are automatically imported
into the class' scope.

.. _classes-scope:

Class scope
-----------

Class scope is more complicated than other scopes, but conceptually the
same. A class has a scope, which consists of its static and class
members, as describe above. When an instance of the class is created, it
is given its own scope, consisting of the defined instance members, with
the class' scope as its parent scope.

Within the code of a class, the instance and class scopes are
automatically searched as appropriate after the local scope, so no
qualification is normally required. When there is a conflict with a name
in the local scope, the ``this`` scope can be used, for example:

.. code:: vala
   :number-lines:

   class ClassName {
           int field_name;
           void function_name (field_name) {
                   this.field_name = field_name;
           }
   }

When a name is defined in a class which conflicts with one in a
subclass, the ``base`` scope can be used, to refer to the scope of the
subclass.

Class member visibility
-----------------------

All class members have a visibility. Visibility is declared using the
following mutually exclusive modifiers:

   | class-member-visibility-modifier:
   |    **private**
   |    **protected**
   |    **internal**
   |    **public**

This defines whether the member is visible to code in different
locations:

-  "private" asserts that the member will only be visible to code that
   is within this class declaration

-  "protected" asserts that the member will be visible to any code
   within this class, and also to any code that is in a subclass of this
   class

-  "internal" asserts that the member should be visible to any code in
   the project, but excludes the member from the public API of a shared
   object

-  "public" asserts that the member should be visible to any code,
   including the public API of a shared object

.. note::

   **C Note**

   A field or method's protected status cannot be enforced in the C
   translation of a Vala library.

Class declaration
-----------------

   | class-declaration:
   |    [ access-modifier ] **class** qualified-class-name [  inheritance-list ] **{** [ class-members ] **}**
   |
   | qualified-class-name:
   |    [ qualified-namespace-name **.** ] class-name
   |
   | class-name:
   |    identifier
   |
   | inheritance-list:
   |    **:** superclasses-and-interfaces
   |
   | superclasses-and-interfaces:
   |    ( qualified-class-name \| qualified-interface-name ) [ **,** superclasses-and-interfaces ]
   |
   | class-members:
   |    class-member [ class-members ]
   |
   | class-member:
   |    class-creation-method-declaration
   |    class-constructor-declaration
   |    class-destructor-declaration
   |    class-constant-declaration
   |    class-delegate-declaration
   |    class-enum-declaration
   |    class-instance-member
   |    class-class-member
   |    class-static-member
   |    inner-class-declaration
   |
   | class-constructor-declaration:
   |    class-instance-constructor-declaration
   |    class-class-constructor-declaration
   |    class-static-constructor-declaration
   |
   | class-instance-member:
   |    class-instance-field-declaration
   |    class-instance-method-declaration
   |    class-instance-property-declaration
   |    class-instance-signal-declaration
   |
   | class-class-member:
   |    class-class-field-declaration
   |    class-class-method-declaration
   |    class-class-property-declaration
   |
   | class-static-member:
   |    class-static-field-declaration
   |    class-static-method-declaration
   |    class-static-property-declaration
   |
   | inner-class-declaration:
   |    [ access-modifier ] **class** class-name [ inheritance-list ] **{** [ class-members ] **}**

In Vala, a class must have either one or zero superclasses, where have
zero superclasses has the result described in :ref:`classes-types`
section. A class must meet all the
prerequisites defined by the interfaces it wishes to implement, by
implementing prerequisite interfaces or inheriting from a particular
class. This latter requirement means it is potentially possible to have
two interfaces that cannot be implemented by a single class.

.. note::

   -  **Note:** Interfaces are only supported for GType classes. Compact
      classes have access only to a limited form of inheritance, whereby
      they may inherit from exactly one or zero other compact classes.

When declaring which class, if any, a new class subclasses, and which
interfaces it implements, the names of those other classes or interfaces
can be qualified relative to the class being declared. This means that,
for example, if the class is declared as "class foo.Bar" (class "Bar" in
namespace "foo") then it may subclass class "Base" in namespace "foo"
simply with "class foo.Bar : Base".

If an access modifier for the class is not given, the default "internal"
is used.

It is possible to declare a class definition to be "abstract." An
abstract class is one they may not be instantiated, instead it first be
subclassed by a non-abstract ("concrete") class. An abstract class
declaration may include abstract class instance members. These act as
templates for methods or properties that must be implemented in all
concrete subclasses of the abstract class. It is thus guaranteed that
any instance of the abstract class (which must be in fact an instance of
a concrete subclass) will have a method or property as described in the
abstract class definition.

   | abstract-class-declaration:
   |    [ access-modifier ] **abstract** **class** qualified-class-name [ inheritance-list ] **{** [ abstract-class-members ] **}**
   |
   | abstract-class-members:
   |    class-members
   |    class-instance-abstract-method-declaration
   |    class-instance-abstract-property-declaration

Controlling instantiation
-------------------------

When a class is instantiated, data might be required from the user to
set initial properties. To define which properties should be or can be
set at this stage, the class declaration should be written as:

.. code:: vala
   :number-lines:

   class ClassName : GLib.Object {

           public ClassName () {
           }

           public ClassName.with_some_quality (Property1Type property1value) {
                   this.property1 = property1value;
           }
   }

This example allows the ``ClassName`` class to be instantiated either
setting no properties, or setting the property. The convention is to
name constructors as "with\_" and then a description of what the extra
properties will be used for, though following this is optional.

   | class-creation-method-declaration:
   |    [ class-member-visibility-modifier ] class-name [ **.** creation-method-name ] **(** param-list **)** **{** construction-assignments **}**
   |
   | class-name:
   |    identifier
   |
   | creation-method-name:
   |    identifier
   |
   | construction-assignments:
   |    this **.** property-name **=** param-name **;**

class-name must be the same as the name of the class. If a creation
method is given an extra name, this name is also used with instantiating
the class, using the same syntax as for declaring the method, e.g.
``var a = new Button.with_label ("text")``.

If the property being set is construct type then assignment is made
before construction, else afterwards.

Any number of these are allowed, but only one with each name (including
null name.)

.. note::

   -  **Note:**

      *For a GObject derived class, only properties may be set at this
      stage in construction, no other processing can be done at this
      time.*

Construction
------------

.. note::

   -  **Note:**

      *Construction only follows this process in GObject derived
      classes.*

During instantiation, after construction properties have been set, a
series of blocks of code are executed. This is the process that prepares
the instance for use. There are three types of ``construct`` blocks that
a class may define:

   | class-instance-constructor-declaration:
   |    **construct** **{** statement-list **}**

Code in this block is executed on every instance of the class that is
instantiated. It is run after construction properties have been set.

   | class-class-constructor-declaration:
   |    **class** **construct** **{** statement-list **}**

This block will be executed once at the first use of its class, and once
at the first use of each subclass of this class.

   | class-static-constructor-declaration:
   |    **static** **construct** **{** statement-list **}**

The first time that a class, or any subclass of it, is instantiated,
this code is run. It is guaranteed that this code will run exactly once
in a program where such a class is used.

The order of execution for constructors:

   | class-instance-destructor-declaration:
   |    **~** class-name **(** **)** **{** statement-list **}**

Destruction here. When does it happen? And when for each type of class?

.. _class-fields:

Class fields
------------

Fields act as variable with a scope of either the class or a particular
instance, and therefore have names and types in the same way. Basic
declarations are as:

   | class-instance-field-declaration:
   |    [ class-member-visibility-modifier ] qualified-type-name field-name [ **=** expression ] ;
   |
   | class-class-field-declaration:
   |    [ class-member-visibility-modifier ] **class** qualified-type-name field-name [ **=** expression ] ;
   |
   | class-static-field-declaration:
   |    [ class-member-visibility-modifier ] **static** qualified-type-name field-name [ **=** expression ] ;

Initial values are optional. FIXME: how much calculation can be done
here? what are the defaults?

.. note::

   -  **Note** Initial values are only allowed in GObject derived
      classes.

Class constants
---------------

Constants defined in a class are basically the same as those defined in
a namespace. The only difference is the scope and the choice of
visibilities available.

   | class-constant-declaration:
   |    [ class-member-visibility-modifier ] **const** qualified-type-name constant-name **=** expression ;

.. _class-methods:

Class methods
-------------

Class methods are methods bound to a particularly class or class
instance, i.e. they are executed within the scope of that class or class
instance. They are declared the same way as other methods, but within
the declaration of a class.

The same visibility modifiers can be used as for fields, although in
this case they refer to what code can call the methods, rather than who
can see or change values.

The ``static`` modifier is applicable to methods also. A static method
is independent of any instance of the class. It is therefore only in the
class scope, and may only access other ``static`` members.

   | class-instance-method-declaration:
   |    [ class-member-visibility-modifier ] [ class-method-type-modifier ] return-type method-name **(** [ params-list ] **)** method-contracts [ **throws** exception-list ] **{** statement-list **}**
   |
   | class-class-method-declaration:
   |    [ class-member-visibility-modifier ] **class** return-type method-name **(** [ params-list ] **)** method-contracts [ **throws** exception-list ] **{** statement-list **}**
   |
   | class-static-method-declaration:
   |    [ class-member-visibility-modifier ] **static** return-type method-name **(** [ params-list ] **)** method-contracts [ **throws** exception-list ] **{** statement-list **}**
   |
   | class-method-type-modifier:
   |    **virtual**
   |    **override**

Methods can be virtual, as described in :ref:`object-oriented`.
Methods in Vala classes are not virtual automatically, instead the
"virtual" modifier must be used when it is needed. Virtual methods will
only chain up if overridden using the override keyword.

Vala classes may also define abstract methods, by writing the
declaration with the "abstract" modifier and replacing the method body
with an empty statement ";". Abstract methods are not true methods, as
they do not have an associated statement block, and so cannot be
invoked. Abstract methods can only exist in abstract classes, and must
be overridden in derived classes. For this reason an abstract method is
always virtual. The purpose of an abstract method is to define methods
that all non-abstract subclasses of the current definition must
implement, it is therefore always allowable to invoke the method on an
instance of the abstract class, because it is required that
instance must in fact be of a non-abstract subclass.

   | class-instance-abstract-method-declaration:
   |    [ class-member-visibility-modifier ] **abstract** return-type method-name **(** [ params-list ] **)** method-contracts [ **throws** exception-list ] **;**

.. note::

   -  **Note**

      *Virtual methods are not available to compact classes.*

.. _classes-properties:

Properties
----------

.. note::

   -  **Development Note:**

      *Class and static properties are not yet supported in current Vala
      releases.*

.. note::

   -  **Note**

      *Fully managed properties are only available to GObject derived
      classes - these are properties that can be set dynamically (by
      providing the property name at runtime) and can have attached
      metadata, as is often used in the GTK+ and GNOME libraries. The
      other class types can have unmanaged properties, which appear
      similar when using Vala, but are actually implemented using simple
      methods.*

Properties are an enhanced version of fields. They allow custom code to
be called whenever the property is retrieved or assigned to, but may be
treated as fields by external Vala code. Properties also function like
methods to some extent, and so can be defined as virtual and overridden
in subclasses. Since they are also allowed in interfaces, they allow
interfaces to declare data members that implementing classes must expose
(see :doc:`interfaces`.)

Declaration
~~~~~~~~~~~

   | class-instance-property-declaration:
   |    [ class-member-visibility-modifier ] [ class-method-type-modifier ] qualified-type-name property-name **{** accessors [ default-value ] **}** **;**
   |
   | class-instance-abstract-property-declaration:
   |    [ class-member-visibility-modifier ] **abstract** qualified-type-name property-name **{** automatic-accessors **}** **;**
   |
   | class-class-property-declaration:
   |    [ class-member-visibility-modifier ] **class** qualified-type-name property-name **{** accessors [ default-value ] **}** **;**
   |
   | class-static-property-declaration:
   |    [ class-member-visibility-modifier ] **static** qualified-type-name property-name **{** accessors [ default-value ] **}** **;**
   |
   | property-name:
   |    identifier
   |
   | accessors:
   |    automatic-accessors
   |    [ getter ] [ setter ] [ property-constructor ]
   |
   | automatic-accessors:
   |    [ automatic-getter ] [ automatic-setter ] [ automatic-property-constructor ]
   |
   | automatic-getter:
   |    [ class-member-visibility-modifier ] **get** **;**
   |
   | automatic-setter:
   |    [ class-member-visibility-modifier ] **set** [ **construct** ] **;**
   |
   | automatic-property-constructor:
   |    [ class-member-visibility-modifier ] **construct** **;**
   |
   | get-accessor:
   |    [ class-member-visibility-modifier ] **get** **{** statement-list **}**
   |
   | set-accessor:
   |    [ class-member-visibility-modifier ] **set** [ **construct** ] **{** statement-list **}**
   |
   | property-constructor:
   |    [ class-member-visibility-modifier ] **construct** **{** statement-list **}**
   |
   | default-value:
   |    **default** **=** expression **;**

Execute Code on Setting/Getting Values
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Properties can either be declared with code that will perform particular
actions on get and set, or can simply declare which actions are allowed
and allow Vala to implement simple get and set methods. This second
pattern (automatic property) will result in fields being added to the
class to store values that the property will get and set. If either get
or set has custom code, then the other must either be also written in
full, or omitted altogether.

When a value is assigned to a property, the **set** block is invoked,
with a parameter called **value** of the same type as the property. When
a value is requested from a property, the **get** block is invoked, and
must return an instance of the same type of the property.

Construct / Set Construct Block
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A property may have zero or one **construct** blocks. This means either
a **set construct** block or a separate **construct** block. If this is
the case that then the property becomes a construct property, meaning
that if it is set in creation method, it will be set (using the
construct block, as opposed to any simple **set** block, where there is
a distinction) before class construct blocks are called.

Notify Changes Signals
~~~~~~~~~~~~~~~~~~~~~~

Managed properties may be annotated with Notify, See :doc:`attributes`.
This will cause the class instance to emit a notify signal when the
property has been assigned to.

Virtual Properties
~~~~~~~~~~~~~~~~~~

Instance properties can be defined virtual with the same semantics as
for virtual methods. If in an abstract class, an instance property can
be defined as abstract. This is done using the "abstract" keyword on a
declaration that is otherwise the same as an automatic property. It is
then the responsibility of derived classes to implement the property by
providing get or set blocks as appropriate. An abstract property is
automatically virtual.

Abstract Properties
~~~~~~~~~~~~~~~~~~~

As with methods, it is possible to declare abstract properties. These
have much the same semantics as abstract methods, i.e. all non-abstract
subclasses will have to implement properties with at least the accessors
defined in the abstract property. Any **set construct** or construct
accessor must be defined too in non-abstract classes and use
**override**.

   | class-instance-abstract-property-declaration:
   |    [ class-member-visibility-modifier ] **abstract** qualified-type-name property-name **{** automatic-accessors **}** **;**

.. _class-signals:

Signals
-------

.. note::

   -  **Note**

      *Signals are only available to GObject derived classes.*

Signals are a system allowing a classed-type instance to emit events
which can be received by arbitrary listeners. Receiving these events is
achieved by connecting the signal to a handler, for which Vala has a
specific syntax. Signals are integrated with the GLib
`MainLoop <https://developer.gnome.org/documentation/tutorials/main-contexts.html>`__
system, which provides a system for queueing events (i.e. signal
emissions,) when needed - though this capability is not needed
non-threaded applications.

   | class-instance-signal-declaration:
   |    [ class-member-visibility-modifier ] [ class-method-type-modifier ] **signal** return-type signal-name **(** [ params-list ] **)** **;**
   |
   | signal-name:
   |    identifier

Signals may also provide an extra piece of information called a signal
detail. This is a single string, which can be used as an initial hint as
to the purpose of the signal emission. In Vala you can register that a
signal handler should only be invoked when the signal detail matches a
given string. A typical use of signal details is in GObject's own
"notify" signal, which says that a property of an object has changed -
GObject uses the detail string to say which property has been changed.

To assign a handler to a signal, (or register to receive this type of
event from the instance), use the following form of expression:

   | signal-connection-expression:
   |    qualified-signal-name [ signal-detail ] **+=** signal-handler
   |
   | qualified-signal-name:
   |    [ qualified-namespace-name **.** ] variable-identifier **.** signal-name
   |
   | signal-detail:
   |    **[** expression **]**
   |
   | signal-handler:
   |    expression
   |    qualified-method-name
   |    lambda-expression

This expression will request that the signal handler given be invoked
whenever the signal is emitted. In order for such a connection
expression to be legal, the handler must have the correct signature. The
handler should be defined to accept as parameters the same types as the
signal, but with an extra parameter before. This parameter should have
the type of the class in which the signal is declared. When a signal is
emitted all handlers are called with this parameter being the object by
which the signal was emitted.

The time that an arbitrary expression is acceptable in this expression
is when that expression evaluates to an instance of a delegate type,
i.e. to a method that is a legal handler for the signal. For details on
delegates, see :doc:`delegates`. For details on lambda expressions see
:ref:`methods-lambdas`.

Note that optional signal detail should be directly appended to the
signal name, with no white space, e.g. ``o.notify["name"] += ...``

It is also possible to disconnect a signal handler using the following
expression form:

   | signal-disconnection-expression:
   |    qualified-signal-name [ signal-detail ] **-=** connected-signal-handler
   |
   | connected-signal-handler:
   |    expression
   |    qualified-method-name

Note that you cannot disconnect a signal handler which was defined
inline as a lambda expression and then immediately connected to the
signal. If this is the effect you really need to achieve, you must
assign the lambda expression to an identifier first, so that the lambda
can be referred to again at a later time.

Class enums
-----------

Enums defined in a class are basically the same as those defined in a
namespace. The only difference is the scope and the choice of
visibilities available. See :doc:`enumerated-types-enums`.

   | class-enum-declaration:
   |    [ class-member-visibility-modifier ] **enum** enum-name **{** [ enum-members ] **}**

Class delegates
---------------

Delegates defined in a class are basically the same as those defined in
a namespace. The only difference is the scope and the choice of
visibilities available. See :doc:`delegates`.

   | class-delegate-declaration:
   |    [ class-member-visibility-modifier ] return-type **delegate** delegate-name **(** method-params-list **)** **;**

Examples
--------

Demonstrating...

.. code:: vala
   :number-lines:

   // ...

Using Properties
~~~~~~~~~~~~~~~~

Virtual Properties
''''''''''''''''''

.. code:: vala
   :number-lines:

   namespace Properties {
       class Base : Object {
           protected int _number;
           public virtual int number {
               get {
                   return this._number;
               }
               set {
                   this._number = value;
               }
           }
       }

       /**
        * This class just use Base class default handle
        * of number property.
        */
       class Subclass : Base {
           public string name { get; set; }
       }

       /**
        * This class override how number is handle internally.
        */
       class ClassOverride : Base {
           public override int number {
               get {
                   return this._number;
               }
               set {
                   this._number = value * 3;
               }
           }
       }

       void main () {
           stdout.printf ("Implementing Virtual Properties...\n");
           var bc = new Base ();
           bc.number = 3;
           stdout.printf ("Class number = '" + bc.number.to_string () + "'\n");
           var sc = new Subclass ();
           sc.number = 3;
           stdout.printf ("Class number = '" + sc.number.to_string () + "'\n");
           var co = new ClassOverride ();
           co.number = 3;
           stdout.printf ("Class number = '" + co.number.to_string () + "'\n");
       }
   }

Abstract Properties
'''''''''''''''''''

.. code:: vala
   :number-lines:

   namespace Properties {
       abstract class Base : Object {
           public abstract string name { get; set construct; }

           construct {
               this.name = "NO_NAME";
           }
       }

       class Subclass : Base {
           private string _name;

           public override string name {
               get {
                   return this._name;
               }
               set construct {
                   this._name = value;
               }
           }

           /* This class have a default constructor that initializes
            * name as the construct block on Base, and a .with_name()
            * constructor where the user can set class derived name
            * property.
           */
           public Subclass.with_name (string name) {
               Object (name:name);
               this._name = name;
           }
       }

       void main () {
           stdout.printf ("Implementing Abstract Properties...\n");
           var sc = new Subclass.with_name ("TEST_CLASS");
           stdout.printf ("Class name = '" + sc.name + "'\n");
           var sc2 = new Subclass ();
           stdout.printf ("Class name = '" + sc2.name + "'\n");
       }
   }

Compile and run using:

::

   $ valac source.vala
   $ ./source

Using signals
~~~~~~~~~~~~~

.. code:: vala
   :number-lines:

   public class Test : Object {
           public signal void test (int data);
   }

   delegate void TestHandler (Test t, int data);

   void main () {
           Test t = new Test ();

           TestHandler h = (t, data) => {
                   stdout.printf ("Data: %d\n", data);
           };

           t.test (1);
           t.test.connect (h);
           t.test (2);
           t.test.disconnect (h);
           t.test (3);
   }
