AC_INIT([vala], [0.1.6], [j@bitron.ch], [vala])
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

AC_ARG_ENABLE(gen-project, AS_HELP_STRING([--enable-gen-project], [Enable project generator]), enable_gen_project=$enableval, enable_gen_project=no)
AM_CONDITIONAL(ENABLE_GEN_PROJECT, test x$enable_gen_project = xyes)

GLIB_REQUIRED=2.12.0
GTK_REQUIRED=2.10.0
ENCHANT_REQUIRED=1.3.0

PKG_CHECK_MODULES(GLIB, glib-2.0 >= $GLIB_REQUIRED gobject-2.0 >= $GLIB_REQUIRED)

AC_SUBST(GLIB_CFLAGS)
AC_SUBST(GLIB_LIBS)

PKG_CHECK_MODULES(GMODULE, gmodule-2.0 >= $GLIB_REQUIRED)

AC_SUBST(GMODULE_CFLAGS)
AC_SUBST(GMODULE_LIBS)

PKG_CHECK_MODULES(GTHREAD, gthread-2.0 >= $GLIB_REQUIRED)

AC_SUBST(GTHREAD_CFLAGS)
AC_SUBST(GTHREAD_LIBS)

if test x$enable_gen_project = xyes; then
	PKG_CHECK_MODULES(GTK, gtk+-2.0 >= $GTK_REQUIRED)
fi

AC_SUBST(GTK_CFLAGS)
AC_SUBST(GTK_LIBS)

AC_PATH_PROG([XSLTPROC], [xsltproc], :)
AM_CONDITIONAL(HAVE_XSLTPROC, test "$XSLTPROC" != :)

PKG_CHECK_MODULES(ENCHANT, enchant >= $ENCHANT_REQUIRED, have_enchant=yes, have_enchant=no)
AM_CONDITIONAL(HAVE_ENCHANT, test x$have_enchant = xyes)

AC_SUBST(ENCHANT_CFLAGS)
AC_SUBST(ENCHANT_LIBS)

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
           doc/vala/Makefile
           gobject-introspection/Makefile
           vapigen/Makefile
           vapigen/vala-gen-introspect/Makefile
           vapigen/vala-gen-introspect/vala-gen-introspect
           gen-project/Makefile])

AC_OUTPUT
