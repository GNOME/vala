AC_INIT([vala], m4_esyscmd([build-aux/git-version-gen .tarball-version]), [j@bitron.ch], [vala])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_HEADERS(config.h)
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([dist-bzip2])
AM_MAINTAINER_MODE

# Checks for programs.
AC_PROG_CC
AM_PROG_CC_C_O
AC_DISABLE_STATIC
AC_PROG_LIBTOOL

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

AC_SUBST(VALAFLAGS)
AC_SUBST(CFLAGS)
AC_SUBST(CPPFLAGS)
AC_SUBST(LDFLAGS)

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

AC_ARG_ENABLE(vapigen, AS_HELP_STRING([--enable-vapigen], [Enable VAPI generator]), enable_vapigen=$enableval, enable_vapigen=no)
AM_CONDITIONAL(ENABLE_VAPIGEN, test x$enable_vapigen = xyes)

if test "$enable_vapigen" = "yes"; then
  vapigen_decl='vapigen=${bindir}/vapigen'
  gen_introspect_decl='gen_introspect=${libdir}/vala/gen-introspect'
  vala_gen_introspect_decl='vala_gen_introspect=${bindir}/vala-gen-introspect'
else
  vapigen_decl=''
  gen_introspect_decl=''
  vala_gen_introspect_decl=''
fi
AC_SUBST(vapigen_decl)
AC_SUBST(gen_introspect_decl)
AC_SUBST(vala_gen_introspect_decl)

GLIB_REQUIRED=2.12.0

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
           vala-1.0.pc
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
           vapigen/Makefile
           vapigen/vala-gen-introspect/Makefile
           vapigen/vala-gen-introspect/vala-gen-introspect])

AC_OUTPUT
