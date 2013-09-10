dnl configure.in
AC_PREREQ(2.59)
AC_INIT(Valadoc, 0.3.2, flo.brosch@gmail.com)
AM_INIT_AUTOMAKE
AC_CONFIG_SRCDIR([src/valadoc/valadoc.vala])
AC_CONFIG_HEADER([config.h])
AM_MAINTAINER_MODE

AM_INIT_AUTOMAKE([foreign])
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AC_PROG_CC
AM_DISABLE_STATIC
AC_PROG_LIBTOOL


##
## Settings:
##

VALA_REQUIRED=0.13.2
LIBGEE_REQUIRED=0.8.0
LIBGVC_REQUIRED=2.16
GLIB_REQUIRED=2.12.0
LIBGDKPIXBUF_REQUIRED=2.0



##
## Dependencies:
##

AC_PATH_PROG(VALAC, valac, valac)
AC_SUBST(VALAC)
AC_SUBST(VALAFLAGS)
m4_ifdef([AM_PROG_VALAC], [AM_PROG_VALAC([$VALA_REQUIRED])])

PKG_CHECK_MODULES(LIBGVC, libgvc >= $LIBGVC_REQUIRED)
AC_SUBST(LIBGVC_CFLAGS)
AC_SUBST(LIBGVC_LIBS)

PKG_CHECK_MODULES(GLIB, glib-2.0 >= $GLIB_REQUIRED gobject-2.0 >= $GLIB_REQUIRED)
AC_SUBST(GLIB_CFLAGS)
AC_SUBST(GLIB_LIBS)

PKG_CHECK_MODULES(GMODULE, gmodule-2.0 >= $GLIB_REQUIRED)
AC_SUBST(GMODULE_CFLAGS)
AC_SUBST(GMODULE_LIBS)

PKG_CHECK_MODULES(LIBGEE, gee-0.8 >= $LIBGEE_REQUIRED)
AC_SUBST(LIBGEE_CFLAGS)
AC_SUBST(LIBGEE_LIBS)



AC_MSG_CHECKING([for CGRAPH])
valadoc_tmp_LIBADD="$LIBADD"
valadoc_tmp_CFLAGS="$CFLAGGS"
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
LIBADD="$valadoc_tmp_LIBADD"
CFLAGS="$valadoc_tmp_CFLAGS"
AM_CONDITIONAL(HAVE_CGRAPH, test "$have_cgraph" = "yes")


##
## Drivers:
##

PKG_CHECK_MODULES(LIBVALA_0_22_X, libvala-0.22 >= 0.17.4, have_libvala_0_22_x="yes", have_libvala_0_22_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_22_X, test "$have_libvala_0_22_x" = "yes")
AC_SUBST(LIBVALA_0_22_X_CFLAGS)
AC_SUBST(LIBVALA_0_22_X_LIBS)


PKG_CHECK_MODULES(LIBVALA_0_20_X, libvala-0.20 >= 0.17.4, have_libvala_0_20_x="yes", have_libvala_0_20_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_20_X, test "$have_libvala_0_20_x" = "yes")
AC_SUBST(LIBVALA_0_20_X_CFLAGS)
AC_SUBST(LIBVALA_0_20_X_LIBS)


PKG_CHECK_MODULES(LIBVALA_0_18_X, libvala-0.18 >= 0.17.4, have_libvala_0_18_x="yes", have_libvala_0_18_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_18_X, test "$have_libvala_0_18_x" = "yes")
AC_SUBST(LIBVALA_0_18_X_CFLAGS)
AC_SUBST(LIBVALA_0_18_X_LIBS)


PKG_CHECK_MODULES(LIBVALA_0_17__1_3, libvala-0.18 >= 0.17.1   libvala-0.18 <= 0.17.3, have_libvala_0_17__1_3="yes", have_libvala_0_17__1_3="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_17__1_3, test "$have_libvala_0_17__1_3" = "yes")
AC_SUBST(HAVE_LIBVALA_0_17__1_3_CFLAGS)
AC_SUBST(HAVE_LIBVALA_0_17__1_3_LIBS)


PKG_CHECK_MODULES(LIBVALA_0_17_0, libvala-0.18 = 0.17.0, have_libvala_0_17_0="yes", have_libvala_0_17_0="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_17_0, test "$have_libvala_0_17_0" = "yes")
AC_SUBST(LIBVALA_0_17_0_CFLAGS)
AC_SUBST(LIBVALA_0_17_0_LIBS)


PKG_CHECK_MODULES(LIBVALA_0_16_X, libvala-0.16 >= 0.15.1, have_libvala_0_16_x="yes", have_libvala_0_16_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_16_X, test "$have_libvala_0_16_x" = "yes")
AC_SUBST(LIBVALA_0_16_X_CFLAGS)
AC_SUBST(LIBVALA_0_16_X_LIBS)


PKG_CHECK_MODULES(LIBVALA_0_15_0, libvala-0.16 = 0.15.0, have_libvala_0_15_0="yes", have_libvala_0_15_0="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_15_0, test "$have_libvala_0_15_0" = "yes")
AC_SUBST(LIBVALA_0_15_0_CFLAGS)
AC_SUBST(LIBVALA_0_15_0_LIBS)


PKG_CHECK_MODULES(LIBVALA_0_14_X, libvala-0.14 >= 0.13.2, have_libvala_0_14_x="yes", have_libvala_0_14_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_14_X, test "$have_libvala_0_14_x" = "yes")
AC_SUBST(LIBVALA_0_14_X_CFLAGS)
AC_SUBST(LIBVALA_0_14_X_LIBS)


PKG_CHECK_MODULES(LIBVALA_0_13_1, libvala-0.14 = 0.13.1, have_libvala_0_13_1="yes", have_libvala_0_13_1="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_13_1, test "$have_libvala_0_13_1" = "yes")
AC_SUBST(LIBVALA_0_13_1_CFLAGS)
AC_SUBST(LIBVALA_0_13_1_LIBS)


PKG_CHECK_MODULES(LIBVALA_0_13_0, libvala-0.14 = 0.13.0, have_libvala_0_13_0="yes", have_libvala_0_13_0="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_13_0, test "$have_libvala_0_13_0" = "yes")
AC_SUBST(LIBVALA_0_13_0_CFLAGS)
AC_SUBST(LIBVALA_0_13_0_LIBS)



AC_CONFIG_FILES([Makefile
                 src/libvaladoc/valadoc-1.0.pc
                 src/libvaladoc/valadoc-1.0.deps
                 src/Makefile
                 icons/Makefile
                 doc/Makefile
                 src/libvaladoc/Makefile
                 src/driver/Makefile
				 src/driver/0.14.x/Makefile
				 src/driver/0.16.x/Makefile
				 src/driver/0.18.x/Makefile
				 src/driver/0.20.x/Makefile
				 src/driver/0.22.x/Makefile
                 src/doclets/Makefile
                 src/doclets/htm/Makefile
                 src/doclets/devhelp/Makefile
                 src/doclets/gtkdoc/Makefile
                 src/valadoc/Makefile
                 tests/Makefile
	])


AC_OUTPUT
