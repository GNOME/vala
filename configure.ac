AC_INIT([vala], m4_esyscmd([build-aux/git-version-gen .tarball-version]), [j@bitron.ch], [vala])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_HEADERS(config.h)
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([1.11 dist-bzip2])
AM_MAINTAINER_MODE([enable])

PACKAGE_SUFFIX=-0.18

dnl http://people.gnome.org/~walters/docs/build-api.txt
dnl We don't support separate builddir when building from git
echo \#buildapi-variable-no-builddir >/dev/null

AC_SUBST(PACKAGE_SUFFIX)
AC_DEFINE_UNQUOTED(PACKAGE_SUFFIX, "$PACKAGE_SUFFIX", [Define to the suffix of this package])

program_transform_name="s,\$\$,${PACKAGE_SUFFIX},"

AC_SUBST(pkgdatadir, [${datadir}/vala${PACKAGE_SUFFIX}])

# Checks for programs.
AC_PROG_CC
AM_PROG_CC_C_O
AC_DISABLE_STATIC
AC_PROG_LIBTOOL
AC_PROG_LN_S

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

VALAFLAGS="$VALAFLAGS --disable-version-header"

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

AC_ARG_ENABLE(vapigen, AS_HELP_STRING([--disable-vapigen], [Disable VAPI generator]), enable_vapigen=$enableval, enable_vapigen=yes)
AM_CONDITIONAL(ENABLE_VAPIGEN, test x$enable_vapigen = xyes)

if test "$enable_vapigen" = "yes"; then
  vapigen_decl="vapigen=\${bindir}/vapigen${PACKAGE_SUFFIX}"
  gen_introspect_decl="gen_introspect=\${libdir}/vala${PACKAGE_SUFFIX}/gen-introspect${PACKAGE_SUFFIX}"
  vala_gen_introspect_decl="vala_gen_introspect=\${bindir}/vala-gen-introspect${PACKAGE_SUFFIX}"
else
  vapigen_decl=''
  gen_introspect_decl=''
  vala_gen_introspect_decl=''
fi
AC_SUBST(vapigen_decl)
AC_SUBST(gen_introspect_decl)
AC_SUBST(vala_gen_introspect_decl)

GLIB_REQUIRED=2.16.0

PKG_CHECK_MODULES(GLIB, glib-2.0 >= $GLIB_REQUIRED gobject-2.0 >= $GLIB_REQUIRED)

AC_SUBST(GLIB_CFLAGS)
AC_SUBST(GLIB_LIBS)

PKG_CHECK_MODULES(GMODULE, gmodule-2.0 >= $GLIB_REQUIRED)

AC_SUBST(GMODULE_CFLAGS)
AC_SUBST(GMODULE_LIBS)

PKG_CHECK_MODULES(GTHREAD, gthread-2.0 >= $GLIB_REQUIRED)

AC_SUBST(GTHREAD_CFLAGS)
AC_SUBST(GTHREAD_LIBS)

AC_PATH_PROG([XSLTPROC], [xsltproc], :)
AM_CONDITIONAL(HAVE_XSLTPROC, test "$XSLTPROC" != :)

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
           doc/Makefile
           doc/vala/Makefile
           gobject-introspection/Makefile
           vapigen/vapigen.pc
           vapigen/Makefile
           vapigen/vala-gen-introspect/Makefile
           vapigen/vala-gen-introspect/vala-gen-introspect])

AC_OUTPUT
