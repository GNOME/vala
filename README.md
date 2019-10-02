## What is Vala?
Vala is a programming language that aims to bring modern programming
language features to GNOME developers without imposing any additional
runtime requirements and without using a different ABI compared to
applications and libraries written in C.

`valac`, the Vala compiler, is a self-hosting compiler that translates
Vala source code into C source and header files. It uses the GObject
type system to create classes and interfaces declared in the Vala source
code.

The syntax of Vala is similar to C#, modified to better fit the GObject
type system. Vala supports modern language features as the following:

 * Interfaces
 * Properties
 * Signals
 * Foreach
 * Lambda expressions
 * Type inference for local variables
 * Generics
 * Non-null types
 * Assisted memory management
 * Exception handling

Vala is designed to allow access to existing C libraries, especially
GObject-based libraries, without the need for runtime bindings. All that
is needed to use a library with Vala is an API file, containing the class
and method declarations in Vala syntax. Vala currently comes with
bindings for GLib and GTK+.

Using classes and methods written in Vala from an application written in
C is not difficult. The Vala library only has to install the generated
header files and C applications may then access the GObject-based API of
the Vala library as usual. It should also be easily possible to write a
bindings generator for access to Vala libraries from applications
written in e.g. C# as the Vala parser is written as a library, so that
all compile-time information is available when generating a binding.

More information about Vala is available at [https://wiki.gnome.org/Projects/Vala/](https://wiki.gnome.org/Projects/Vala/)


## Building Vala
Instructions on how to build the latest version of Vala.
These can be modified to build a specific release.

### Step One:
Install the following packages:

 * a C compiler, e.g. GCC
 * a C library, e.g. glibc
 * glib (>= 2.48)
 * flex
 * bison
 * Graphviz (libgvc) (>= 2.16) to build valadoc
 * make
 * autoconf
 * autoconf-archive
 * automake
 * libtool


### Step Two:
Decide where the Vala compiler is to be found.

Vala is self-hosting so it needs another Vala compiler to compile
itself.  `valac` is the name of the executable and can be:

 * installed from an existing package
 * built from a source tarball
 * built from the [Vala bootstrap module](https://gitlab.gnome.org/Archive/vala-bootstrap)

If you have an existing `valac` installed then move on to step three.

If you don't have an existing version of Vala installed (i.e. because you're
bootstrapping or cross-compiling) then a source tarball or the vala-bootstrap
module contain pre-compiled C files from the Vala sources. These can be used
to bootstrap `valac`.

Source tarballs can be downloaded via:

https://wiki.gnome.org/Projects/Vala/Release

or the vala-bootstrap module is available at:

https://gitlab.gnome.org/Archive/vala-bootstrap


Here is an example on how to download and compile from a Vala release tarball.
In this example it is release version 0.42.3:

```sh
curl --silent --show-error --location https://download.gnome.org/sources/vala/0.42/vala-0.42.3.tar.xz --output vala-bootstrap.tar.xz
tar --extract --file vala-bootstrap.tar.xz
cd vala-bootstrap
./configure --prefix=/opt/vala-bootstrap
make && sudo make install
```

The configure script will check if `valac` can be found in PATH. If not then
`valac` is bootstrapped from the C source files in the tarball.
If you do not wish to install the bootstrapped version of `valac` it can be
found in `vala-bootstrap/compiler/valac` This is a libtool wrapper script
that makes the libraries in the build directory work together.


An example of downloading and compiling from the bootstrap module:

```sh
git clone https://gitlab.gnome.org/Archive/vala-bootstrap
cd vala-bootstrap
touch */*.stamp
VALAC=/no-valac ./configure --prefix=/opt/vala-bootstrap
make && sudo make install
```

### Step Three:
Compiling the newest Vala from the repository using a pre-installed `valac`:

```sh
git clone https://gitlab.gnome.org/GNOME/vala
cd vala
./autogen.sh
make && sudo make install
```

To use `valac` from a bootstrapped build detailed in step two use:

```sh
git clone https://gitlab.gnome.org/GNOME/vala
cd vala
VALAC=/opt/vala-bootstrap/bin/vala ./autogen.sh
make && sudo make install
```

### Compiling Different Vala Versions
Maybe you now want to compile Vala with the new version you have just installed.
Then you simply clean the version files and start the build. Be warned that
`git clean -dfx` **will remove all untracked files** from the source tree:

```sh
git clean -dfx
./autogen.sh
make && sudo make install
```

If you wish to build a specific release, for example 0.40.11:

```sh
git checkout 0.40.11
git clean -dfx
./autogen.sh
make && sudo make install
```
