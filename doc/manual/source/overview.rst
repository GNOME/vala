Overview
========

Vala is a programming language that aims to bring modern language
features to GNOME developers without imposing any additional runtime
requirements and without using a different ABI than applications and
libraries written in C. It provides a concise way of using GLib and
GObject features, but does not attempt to expose all possibilities. In
particular, Vala is primarily a statically typed language - this is a
design decision, not an oversight.

The only support that Vala applications require at runtime are the
standard GLib and GObject libraries. It is possible to use any system
library from Vala, provided that a VAPI file is written to describe the
interface - Vala is distributed with VAPI descriptions of most libraries
commonly used by GNOME applications, and many others as well.

Vala provides easy integration with DBus, by automatically writing
boiler plate code where required, for exposing objects, dispatching
methods, etc.

Getting started
---------------

The classic "Hello, world" example in Vala:

.. code:: vala
   :number-lines:

   int main (string[] args) {
       stdout.printf ("hello, world\n");
       return 0;
   }

Store the code in a file whose name ends in ".vala", such as
``hello.vala``, and compile it with the command:

::

   $ valac -o hello hello.vala

This will produce an executable file called ``hello``. "valac" is the
Vala compiler; it will also allow you to take more control of the
compile and link processes when required, but that is outside the scope
of this introductory section.

Documentation conventions
-------------------------

A large amount of this documentation describes the language features
precisely using a simple rule notation. The same notation is used to
describe language syntax and semantics, with the accompanying text
always explaining what is described. The following example shows the
form:

   | rule-name:
   |    **literalstring1**
   |    **literalstring2** [ optional-section ]
   |
   | optional-section:
   |    **literalstring3**

Here, "rule-name" and "optional-section" describe rules, each of which
can be expanded in a particular way. Expanding a rule means substituting
one of the options of the rule into the place the rule is used. In the
example, "optional-section" can be expanded into "literalstring3" or, in
"rule-name", "optional-section" can also be substituted for nothing, as
it is declared optional by the square brackets. Wherever "rule-name" is
required, it can be substituted for either of the options declared in
"rule-name". Anything highlighted, such as all **literalstrings** here
are not rules, and thus cannot be expanded.

Example code is shown as follows. Example code will always be valid Vala
code, but will not necessarily be usable out of context.

.. code:: vala
   :number-lines:

   class MyClass : Object {
       int field = 1;
   }

Some phrases are used in a specific ways in this documentation and it is
often useful to recognise their precise meanings: that is, to create a
method, you write a declaration for it. When the program is running and
the method exists, it is then defined as per your declaration and can be
invoked.

Vala source files
-----------------

There are two types of Vala input files. Vala source files (with a
".vala" extension) contain compilable Vala code. VAPI files (with a
".vapi" extension) describe an interface to a library, which can be
written in either Vala or C. VAPI files are not compilable, and cannot
contain any executable code - they are used when compiling Vala source
files.

There are no requirements for how Vala source files are named, although
there are conventions that can be followed. VAPI files are usually named
to matched the pkg-config name of the library they relate to; they are
described more fully in the documentation about bindings.

All Vala input files should be encoded in UTF-8.

Vala conventions
----------------

The logical structure of a Vala project is entirely based on the program
text, not the file layout or naming. Vala therefore does not force
particular naming schemes or file layouts. There are established
conventions derived from how GNOME related applications are normally
written, which are strongly encouraged. The choice of directory
structure for a project is outside the scope of this documentation.

Vala source files usually contain one main public class, after which the
source file is named. A common choice is to convert this main class'
name to lowercase, and prefix with its namespace, also in lower case, to
form the file name. In a small project the namespace may be redundant
and so excluded. None of this is a requirement, it is just a convention.

It is not encouraged to include declarations in more than one namespace
in a single Vala source file, simply for reasons of clarity. A namespace
may be divided over any number of source files, but will normally not be
used outside of one project. Each library or application will normally
have one main namespace, with potentially others nested within.

In source code, the following naming conventions are normally followed:

-  Namespaces are named in camel case: NameSpaceName

-  Classes are named in camel case: ClassName

-  Method names are all lowercase and use underscores to separate words:
   method_name

-  Constants (and values of enumerated types) are all uppercase, with
   underscores between words: CONSTANT_NAME

Vala supports the notion of a package to conveniently divide program
sections. A package is either a combination of an installed system
library and its Vala binding, or else is a local directory that can be
treated in a similar way. In the latter case it will contain all
functionality related to some topic, the scope of which is up to the
developer. All source files in package are placed within a directory
named for package name. For details on using packages, see the Vala
compiler documentation

Vala syntax
-----------

Vala's syntax is modelled on C#'s, and is therefore similar to all
C-like languages. Curly braces are the basic delimiter, marking the
start and end of a declaration or block of code.

There is no whitespace requirement, though this is a standard format
that is used in Vala itself, and in many Vala projects. This format is a
version of the coding style used for glib and gnome projects, but is not
fully described in this document, other than being used for all
examples.

There is flexibility in the order of declarations in Vala. It is not
required to pre-declare anything in order to use it before its
declaration.

Identifiers all follow the same rules, whether for local variables or
class names. Legal identifiers must begin with one alphabetic character
or underscore, followed by any number (zero or more) of alphanumerics or
underscores (/[:alpha:_]([:alphanum:_])*/). It is also possible to use
language keywords as identifiers, provided they are prefixed with a "@"
when used in this way - the "@" is not considered a part of the
identifier, it simply informs the compiler that the token should be
considered as an identifier.

GType and GObject
-----------------

Vala uses the runtime type system called GType. This system allows every
type in Vala, including the fundamental types, to be identified at
runtime. A Vala developer doesn't need to be aware of GType in most
circumstances, as all interaction with the system is automatic.

GType provides Vala with a powerful object model called GObject. To all
types descended from GLib.Object class, this model provides for features
such as properties and signals.

GType and GObject are entirely runtime type systems, intended to be
usable to dynamically typed languages. Vala is primarily a statically
typed language, and so is designed not to provide access to all of GType
and GObject's features. Instead Vala uses a coherent subset to support
particular programming styles.

Vala is designed to use GType and GObject seamlessly. There are
occasions, mostly when working with existing libraries, when you might
need to circumvent parts of the system. These are all indicated in this
documentation.

.. _memory-management:

Memory management
-----------------

Vala automatically uses the memory management system in GLib, which is a
reference counting system. In order for this to work, the types used
must support reference counting, as is the case with all GObject derived
types and some others.

Memory is allocated and initialised by Vala when needed. The memory
management scheme means it is also freed when possible. There is though
no garbage collector, and currently reference cycles are not
automatically broken. This can lead to memory being leaked. The main way
to avoid this problem is to use weak references - these are not counted
references and so cannot prevent memory being released, at the cost that
they can be left referring to non existent data.

Vala also allows use of pointers in much the same way as C. An instance
of a pointer type refers directly to an address in memory. Pointers are
not references, and therefore the automatic memory management rules do
not apply in the same way. See :ref:`pointer-types`.

There are more details about memory management elsewhere, see :doc:`types`,
see :doc:`concepts`.

Vala compilation
----------------

Vala programs and libraries are translated into C before being compiled
into machine code. This stage is intended to be entirely transparent
unless you request otherwise, as such it is not often required to know
the details.

When performing a more complicated compile or link process than valac's
default, valac can be instructed to simply output its intermediate C
form of the program and exit. Each Vala source file is transformed into
a C header and a C source file, each having the same name as the Vala
source file except for the extension. These C files can be compiled
without any help from any Vala utility or library.

The only times it is definitely required to be aware of the translation
process is when a Vala feature cannot be represented in C, and so the
generated C API will not be the same as the Vala one. For example,
private struct members are meaningless in C. These issues are indicated
in this documentation.

Application entry point
-----------------------

All Vala applications are executed beginning with a method called
"main". This must be a non-instance method, but may exist inside a
namespace or class. If the method takes a string array parameter, it
will be passed the arguments given to the program on execution. If it
returns an int type, this value will be passed to the user on the
program's normal termination. The entry point method may not accept any
other parameters, or return any other types, making the acceptable
definitions:

.. code:: vala
   :number-lines:

   void main () { ... }
   int main () { ... }
   void main (string[] args) { ... }
   int main (string[] args) { ... }

The entry point can be implicit, in the sense that you can write the
main code block directly in the file outside the ``main`` function.
