AC_PREREQ([2.65])
AC_INIT([vala], m4_esyscmd([build-aux/git-version-gen --prefix '' .tarball-version]),
	[https://gitlab.gnome.org/GNOME/vala/issues],
	[vala],
	[https://wiki.gnome.org/Projects/Vala])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_HEADERS(config.h)
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([1.11 dist-xz no-dist-gzip subdir-objects])
AM_MAINTAINER_MODE([enable])

API_VERSION=0.40
PACKAGE_SUFFIX="-$API_VERSION"

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

AC_PATH_PROG(VALAC, valac, valac)
AC_SUBST(VALAC)

VALAC_BOOTSTRAP_REQUIRED=0.39.5.8

AS_IF([test "$VALAC" != valac], [FOUND_VALAC_VERION=`$VALAC --version | sed 's/Vala  *//'`
	AS_VERSION_COMPARE(["$VALAC_BOOTSTRAP_REQUIRED"], ["$FOUND_VALAC_VERION"],
		[enable_boostrap=yes], [enable_boostrap=yes], [enable_boostrap=no])])

VALAFLAGS="$VALAFLAGS --disable-version-header"
if test x$enable_boostrap = xyes; then
	VALAFLAGS="$VALAFLAGS --hide-internal --abi-stability"
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

GLIB_REQUIRED=2.40.0
LIBGVC_REQUIRED=2.16

PKG_CHECK_MODULES(GLIB, glib-2.0 >= $GLIB_REQUIRED gobject-2.0 >= $GLIB_REQUIRED)

AC_SUBST(GLIB_CFLAGS)
AC_SUBST(GLIB_LIBS)

PKG_CHECK_MODULES(GMODULE, gmodule-2.0 >= $GLIB_REQUIRED)

AC_SUBST(GMODULE_CFLAGS)
AC_SUBST(GMODULE_LIBS)

PKG_CHECK_MODULES(LIBGVC, libgvc >= $LIBGVC_REQUIRED)
AC_MSG_CHECKING([for CGRAPH])
cgraph_tmp_LIBADD="$LIBADD"
cgraph_tmp_CFLAGS="$CFLAGS"
LIBADD="$LIBADD $LIBGVC_LIBS"
CFLAGS="$CFLAGS $LIBGVC_CFLAGS"
AC_RUN_IFELSE(
	[AC_LANG_SOURCE([
		#include <gvc.h>

		int main(void) {
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
	]
)
LIBADD="$cgraph_tmp_LIBADD"
CFLAGS="$cgraph_tmp_CFLAGS"
AM_CONDITIONAL(HAVE_CGRAPH, test "$have_cgraph" = "yes")

AC_PATH_PROG([G_IR_COMPILER], [g-ir-compiler], :)
AM_CONDITIONAL(HAVE_G_IR_COMPILER, test "$G_IR_COMPILER" != :)

AC_PATH_PROG([XSLTPROC], [xsltproc], :)
AM_CONDITIONAL(HAVE_XSLTPROC, test "$XSLTPROC" != :)

AC_CHECK_PROG([WEASYPRINT], [weasyprint], [weasyprint])
AM_CONDITIONAL(HAVE_WEASYPRINT, [test x$WEASYPRINT = xweasyprint])

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
           tests/girwriter/Makefile
           doc/Makefile
           doc/manual/Makefile
           doc/manual/version.xml
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
])

AC_OUTPUT
