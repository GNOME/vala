AC_INIT([vala], [0.1.2], [j@bitron.ch], [vala])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_HEADERS(config.h)
AM_INIT_AUTOMAKE([dist-bzip2])

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

AC_SUBST(CFLAGS)
AC_SUBST(CPPFLAGS)
AC_SUBST(LDFLAGS)

AC_ARG_ENABLE(vapigen, AS_HELP_STRING([--enable-vapigen], [Enable VAPI generator]), enable_vapigen=$enableval, enable_vapigen=no)
AM_CONDITIONAL(ENABLE_VAPIGEN, test x$enable_vapigen = xyes)

GLIB_REQUIRED=2.10.0

PKG_CHECK_MODULES(GLIB, glib-2.0 >= $GLIB_REQUIRED gobject-2.0 >= $GLIB_REQUIRED)
AC_SUBST(GLIB_CFLAGS)
AC_SUBST(GLIB_LIBS)

AC_CONFIG_FILES([Makefile
           vala-1.0.pc
           gee/Makefile
           ccode/Makefile
           vala/Makefile
           gobject/Makefile
           compiler/Makefile
           vapi/Makefile
           tests/Makefile
           doc/Makefile
           gobject-introspection/Makefile
           vapigen/Makefile
           vapigen/gidlgen/Makefile
           vapigen/gidlgen/gidlgen])

AC_OUTPUT
