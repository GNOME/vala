AC_PREREQ([2.65])
AC_INIT([vala], m4_esyscmd([build-aux/git-version-gen --prefix '' .tarball-version]),
	[https://gitlab.gnome.org/GNOME/vala/issues],
	[vala],
	[https://vala.dev])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_HEADERS(config.h)
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([1.11 dist-xz no-dist-gzip subdir-objects])
AM_MAINTAINER_MODE([enable])

API_VERSION=0.58
PACKAGE_SUFFIX="-$API_VERSION"

VALA_MAJOR_VERSION=`echo $PACKAGE_VERSION | cut -d. -f1 | sed s/[[a-zA-Z\-]].*//g`
VALA_MINOR_VERSION=`echo $PACKAGE_VERSION | cut -d. -f2 | sed s/[[a-zA-Z\-]].*//g`
VALA_MICRO_VERSION=`echo $PACKAGE_VERSION | cut -d. -f3 | sed s/[[a-zA-Z\-]].*//g`
AC_SUBST(VALA_MAJOR_VERSION)
AC_SUBST(VALA_MINOR_VERSION)
AC_SUBST(VALA_MICRO_VERSION)

dnl http://people.gnome.org/~walters/docs/build-api.txt
dnl We don't support separate builddir when building from git
echo \#buildapi-variable-no-builddir >/dev/null

AC_SUBST(API_VERSION)
AC_DEFINE_UNQUOTED(API_VERSION, "$API_VERSION", [Define to the api-version of this package])
AC_SUBST(PACKAGE_SUFFIX)
AC_DEFINE_UNQUOTED(PACKAGE_SUFFIX, "$PACKAGE_SUFFIX", [Define to the suffix of this package])

program_transform_name="s,\$\$,${PACKAGE_SUFFIX},"

AC_SUBST(pkgdatadir, [${datadir}/vala${PACKAGE_SUFFIX}])
AC_SUBST(pkglibdir, [${libdir}/vala${PACKAGE_SUFFIX}])
AC_SUBST(pkgdocdatadir, [${datadir}/valadoc${PACKAGE_SUFFIX}])
AC_SUBST(pkgdoclibdir, [${libdir}/valadoc${PACKAGE_SUFFIX}])

# Checks for programs.
AC_PROG_CC
AM_PROG_CC_C_O
AC_PROG_LN_S
AC_PROG_INSTALL
AC_PROG_MKDIR_P

AC_CANONICAL_HOST

# Detect the target system
build_linux=no
case "${host_os}" in
    linux*)
        build_linux=yes
        ;;
    *)
        ;;
esac
AM_CONDITIONAL([HAVE_LINUX], [test "$build_linux" = "yes"])

LT_PREREQ([2.2.6])
LT_INIT([disable-static])
PKG_PROG_PKG_CONFIG([0.21])

AC_PROG_LEX
if test "$LEX" = :; then
	AC_MSG_ERROR([flex not found but required])
fi

AC_CHECK_PROGS(YACC, 'bison -y' byacc yacc, :)
if test "$YACC" = :; then
	AC_MSG_ERROR([bison not found but required])
fi

AC_PATH_PROG([VALAC], [valac], :)
AC_SUBST(VALAC)

VALAC_BOOTSTRAP_REQUIRED=0.39.5.8
VALAC_VALADOC_REQUIRED=0.18.1

AS_IF([test "$VALAC" != :], [FOUND_VALAC_VERION=`$VALAC --version | sed 's/Vala  *//'`
	AS_VERSION_COMPARE(["$VALAC_BOOTSTRAP_REQUIRED"], ["$FOUND_VALAC_VERION"],
		[enable_boostrap=yes], [enable_boostrap=yes], [enable_boostrap=no])])

VALAFLAGS="$VALAFLAGS --disable-version-header"
if test x$enable_boostrap = xyes; then
	VALAFLAGS="$VALAFLAGS --hide-internal --abi-stability"
fi

AC_ARG_ENABLE(debug, AS_HELP_STRING([--enable-debug], [Enable debug build]), enable_debug=$enableval, enable_debug=no)
if test "$enable_debug" = "yes"; then
	VALAFLAGS="$VALAFLAGS -g"
	CFLAGS="$CFLAGS -g -O0"
fi

AC_SUBST(VALAFLAGS)
AC_SUBST(CFLAGS)
AC_SUBST(CPPFLAGS)
AC_SUBST(LDFLAGS)

AC_ARG_ENABLE(unversioned, AS_HELP_STRING([--disable-unversioned], [Disable unversioned binaries]), enable_unversioned=$enableval, enable_unversioned=yes)
AM_CONDITIONAL(ENABLE_UNVERSIONED, test x$enable_unversioned = xyes)

AC_ARG_ENABLE(coverage, AS_HELP_STRING([--enable-coverage], [Enable coverage analysis]), enable_coverage=$enableval, enable_coverage=no)
AM_CONDITIONAL(ENABLE_COVERAGE, test x$enable_coverage = xyes)

if test "$enable_coverage" = "yes"; then
	COVERAGE_VALAFLAGS="-g"
	COVERAGE_CFLAGS="-fprofile-arcs -ftest-coverage"
	COVERAGE_LIBS="-lgcov"
else
	COVERAGE_VALAFLAGS=
	COVERAGE_CFLAGS=
	COVERAGE_LIBS=
fi
AC_SUBST(COVERAGE_VALAFLAGS)
AC_SUBST(COVERAGE_CFLAGS)
AC_SUBST(COVERAGE_LIBS)


# Check supported compiler flags used in testrunner.sh
TEST_EXTRA_CFLAGS="-Werror=init-self \
-Werror=implicit \
-Werror=implicit-fallthrough \
-Werror=pointer-arith \
-Werror=pointer-sign \
-Werror=redundant-decls \
-Werror=return-local-addr \
-Werror=return-stack-address \
-Werror=return-type \
-Werror=sequence-point \
-Werror=uninitialized \
-Werror=init-self \
-Werror=int-in-bool-context \
-Werror=int-to-pointer-cast \
-Werror=pointer-to-int-cast \
-Werror=compare-distinct-pointer-types \
-Werror=empty-body \
-Werror=comment \
-Werror=null-dereference \
-Werror=strict-overflow \
-Werror=shift-overflow \
-Wformat=2 \
-Werror=format-security \
-Werror=format-nonliteral \
-Werror=format-overflow=2 \
-Werror=format-truncation=2 \
-Werror=int-conversion \
-Werror=duplicated-branches \
-Werror=duplicated-cond \
-Werror=declaration-after-statement \
-Werror=maybe-uninitialized \
-Werror=missing-braces \
-Werror=missing-declarations \
-Werror=missing-prototypes \
-Werror=strict-prototypes \
-Werror=bool-compare \
-Werror=tautological-pointer-compare \
-Werror=logical-not-parentheses \
-Werror=address \
-Werror=array-bounds \
-Werror=array-parameter \
-Werror=array-parameter=2 \
-Werror=enum-conversion"

TEST_CFLAGS=
for flag in $TEST_EXTRA_CFLAGS; do
	AX_CHECK_COMPILE_FLAG([$flag],[TEST_CFLAGS="$TEST_CFLAGS $flag"])
done

AC_ARG_ENABLE(test-asan, AS_HELP_STRING([--enable-test-asan], [Enable Address Sanitizer analysis for tests]), enable_test_asan=$enableval, enable_test_asan=no)
AM_CONDITIONAL(ENABLE_TEST_ASAN, test x$enable_test_asan = xyes)

if test "$enable_test_asan" = "yes"; then
	TEST_CFLAGS="$TEST_CFLAGS -g3 -fsanitize=address -fno-omit-frame-pointer"
fi

AC_ARG_ENABLE(test-ubsan, AS_HELP_STRING([--enable-test-ubsan], [Enable Undefined Behavior Sanitizer analysis for tests]), enable_test_ubsan=$enableval, enable_test_ubsan=no)
AM_CONDITIONAL(ENABLE_TEST_UBSAN, test x$enable_test_ubsan = xyes)

if test "$enable_test_ubsan" = "yes"; then
	TEST_CFLAGS="$TEST_CFLAGS -g3 -fsanitize=undefined"
fi

AC_SUBST(TEST_CFLAGS)


GLIB_REQUIRED=2.56.0
LIBGVC_REQUIRED=2.16

PKG_CHECK_MODULES(GLIB, glib-2.0 >= $GLIB_REQUIRED gobject-2.0 >= $GLIB_REQUIRED)

AC_SUBST(GLIB_CFLAGS)
AC_SUBST(GLIB_LIBS)

PKG_CHECK_MODULES(GMODULE, gmodule-2.0 >= $GLIB_REQUIRED)

AC_SUBST(GMODULE_CFLAGS)
AC_SUBST(GMODULE_LIBS)

AC_ARG_VAR([GI_GIRDIR],[Set an alternative system location of gir files])
AC_MSG_CHECKING([for GI_GIRDIR])
PKG_CHECK_VAR([GI_GIRDIR], [gobject-introspection-1.0], [girdir], [], [AC_MSG_ERROR([Unable to retrieve girdir from gobject-introspection-1.0.pc])])
AC_MSG_RESULT([$GI_GIRDIR])
AC_DEFINE_UNQUOTED(GI_GIRDIR, "$GI_GIRDIR", [Define to system location of gir files])

AC_ARG_WITH(cgraph, AS_HELP_STRING([--with-cgraph], [Required flag for cross-compilation to define capability of graphviz]), [], with_cgraph=check)
AC_ARG_ENABLE(valadoc, AS_HELP_STRING([--disable-valadoc], [Disable valadoc]), enable_valadoc=$enableval, enable_valadoc=yes)
AS_IF([test "$VALAC" != :], [FOUND_VALAC_VERION=`$VALAC --version | sed 's/Vala  *//'`
	AS_VERSION_COMPARE(["$FOUND_VALAC_VERION"], ["$VALAC_VALADOC_REQUIRED"], [
		AC_MSG_WARN([Force disable build of valadoc, valac >= $VALAC_VALADOC_REQUIRED is required])
		enable_valadoc=no
	])
])
if test x$enable_valadoc = xyes; then
	PKG_CHECK_MODULES(LIBGVC, libgvc >= $LIBGVC_REQUIRED)
	AC_MSG_CHECKING([for CGRAPH])
	cgraph_tmp_LIBADD="$LIBADD"
	cgraph_tmp_CFLAGS="$CFLAGS"
	LIBADD="$LIBADD $LIBGVC_LIBS"
	CFLAGS="$CFLAGS $LIBGVC_CFLAGS"
	AC_RUN_IFELSE(
		[AC_LANG_SOURCE([
			#include <gvc.h>
			int main() {
				#ifdef WITH_CGRAPH
					return 0;
				#else
					return -1;
				#endif
			}
		])], [
			AC_MSG_RESULT([yes])
			VALAFLAGS="$VALAFLAGS -D WITH_CGRAPH"
			have_cgraph=yes
		], [
			AC_MSG_RESULT([no])
			have_cgraph=no
		], [
			if test x$with_cgraph = xcheck; then
				AC_MSG_ERROR([--with-cgraph=yes/no is required for cross-compilation])
			elif test x$with_cgraph = xyes; then
				AC_MSG_RESULT([yes])
				VALAFLAGS="$VALAFLAGS -D WITH_CGRAPH"
				have_cgraph=yes
			else
				AC_MSG_RESULT([no])
				have_cgraph=no
			fi
		]
	)
	LIBADD="$cgraph_tmp_LIBADD"
	CFLAGS="$cgraph_tmp_CFLAGS"
fi
AM_CONDITIONAL(HAVE_CGRAPH, test "$have_cgraph" = "yes")
AM_CONDITIONAL(ENABLE_VALADOC, test x$enable_valadoc = xyes)

AC_PATH_PROG([G_IR_COMPILER], [g-ir-compiler], :)
AM_CONDITIONAL(HAVE_G_IR_COMPILER, test "$G_IR_COMPILER" != :)

AC_PATH_PROG([JING], [jing], :)
AM_CONDITIONAL(HAVE_JING, test "$JING" != :)

AC_CHECK_PROGS([SPHINXBUILD], [sphinx-build sphinx-build3 sphinx-build2], [no])
AM_CONDITIONAL(HAVE_SPHINXBUILD, [test "x$SPHINXBUILD" != xno])

AC_CHECK_PROGS([LATEXMK], [latexmk], [no])
AM_CONDITIONAL(HAVE_LATEXMK, [test "x$LATEXMK" != xno])

AC_CHECK_PROG([HELP2MAN], [help2man], [help2man])
AM_CONDITIONAL([HAVE_HELP2MAN], [test x$HELP2MAN = xhelp2man])

m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])

AC_CONFIG_FILES([Makefile
           libvala.pc
           gee/Makefile
           ccode/Makefile
           vala/Makefile
           codegen/Makefile
           compiler/Makefile
           vapi/Makefile
           tests/Makefile
           tests/fastvapi/Makefile
           tests/girwriter/Makefile
           tests/gtktemplate/Makefile
           doc/Makefile
           doc/manual/Makefile
           gobject-introspection/Makefile
           vapigen/vapigen.pc
           vapigen/Makefile
           vapigen/vala-gen-introspect/Makefile
           vapigen/vala-gen-introspect/vala-gen-introspect
           libvaladoc/valadoc.pc
           libvaladoc/valadoc.deps
           libvaladoc/Makefile
           valadoc/Makefile
           valadoc/doclets/Makefile
           valadoc/doclets/html/Makefile
           valadoc/doclets/devhelp/Makefile
           valadoc/doclets/gtkdoc/Makefile
           valadoc/icons/Makefile
           valadoc/tests/Makefile
           valadoc/tests/girwriter/Makefile
])

AC_OUTPUT
