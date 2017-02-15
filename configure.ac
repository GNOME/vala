dnl configure.in
AC_PREREQ([2.65])
AC_INIT([valadoc],[0.35.0],
	[https://bugzilla.gnome.org/browse.cgi?product=valadoc],
	[valadoc],
	[https://wiki.gnome.org/Projects/Valadoc])

m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_HEADERS(config.h)
AC_CONFIG_SRCDIR([configure.ac])
AM_INIT_AUTOMAKE([1.11 foreign tar-ustar dist-xz no-dist-gzip subdir-objects])

AM_MAINTAINER_MODE([enable])

AC_PROG_CC
AC_PROG_INSTALL
LT_INIT([disable-static])
PKG_PROG_PKG_CONFIG([0.21])

##
## Settings:
##

VALA_REQUIRED=0.19.0
LIBGEE_REQUIRED=0.8.0
LIBGVC_REQUIRED=2.16
GLIB_REQUIRED=2.24.0
LIBGDKPIXBUF_REQUIRED=2.0



##
## Dependencies:
##

AC_SUBST(VALAFLAGS)
AM_PROG_VALAC([$VALA_REQUIRED])

PKG_CHECK_MODULES(LIBGVC, libgvc >= $LIBGVC_REQUIRED)

PKG_CHECK_MODULES(GLIB, glib-2.0 >= $GLIB_REQUIRED gobject-2.0 >= $GLIB_REQUIRED)

PKG_CHECK_MODULES(GMODULE, gmodule-2.0 >= $GLIB_REQUIRED)

PKG_CHECK_MODULES(LIBGEE, gee-0.8 >= $LIBGEE_REQUIRED)


AC_MSG_CHECKING([for CGRAPH])
valadoc_tmp_LIBADD="$LIBADD"
valadoc_tmp_CFLAGS="$CFLAGS"
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

PKG_CHECK_MODULES(LIBVALA_0_36_X, libvala-0.36 > 0.35.0, have_libvala_0_36_x="yes", have_libvala_0_36_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_36_X, test "$have_libvala_0_36_x" = "yes")

PKG_CHECK_MODULES(LIBVALA_0_34_X, libvala-0.34 > 0.33.0, have_libvala_0_34_x="yes", have_libvala_0_34_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_34_X, test "$have_libvala_0_34_x" = "yes")

PKG_CHECK_MODULES(LIBVALA_0_32_X, libvala-0.32 > 0.31.0, have_libvala_0_32_x="yes", have_libvala_0_32_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_32_X, test "$have_libvala_0_32_x" = "yes")

PKG_CHECK_MODULES(LIBVALA_0_30_X, libvala-0.30 > 0.29.0, have_libvala_0_30_x="yes", have_libvala_0_30_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_30_X, test "$have_libvala_0_30_x" = "yes")

PKG_CHECK_MODULES(LIBVALA_0_28_X, libvala-0.28 > 0.27.0, have_libvala_0_28_x="yes", have_libvala_0_28_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_28_X, test "$have_libvala_0_28_x" = "yes")

PKG_CHECK_MODULES(LIBVALA_0_26_X, libvala-0.26 > 0.25.2, have_libvala_0_26_x="yes", have_libvala_0_26_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_26_X, test "$have_libvala_0_26_x" = "yes")

PKG_CHECK_MODULES(LIBVALA_0_24_X, libvala-0.24 > 0.23.1, have_libvala_0_24_x="yes", have_libvala_0_24_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_24_X, test "$have_libvala_0_24_x" = "yes")

PKG_CHECK_MODULES(LIBVALA_0_22_X, libvala-0.22 >= 0.21.0, have_libvala_0_22_x="yes", have_libvala_0_22_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_22_X, test "$have_libvala_0_22_x" = "yes")

PKG_CHECK_MODULES(LIBVALA_0_20_X, libvala-0.20 >= 0.19.0, have_libvala_0_20_x="yes", have_libvala_0_20_x="no")
AM_CONDITIONAL(HAVE_LIBVALA_0_20_X, test "$have_libvala_0_20_x" = "yes")


AC_CONFIG_FILES([
Makefile
src/libvaladoc/valadoc-1.0.pc
src/libvaladoc/valadoc-1.0.deps
src/Makefile
icons/Makefile
doc/Makefile
src/libvaladoc/Makefile
src/driver/Makefile
src/driver/0.20.x/Makefile
src/driver/0.22.x/Makefile
src/driver/0.24.x/Makefile
src/driver/0.26.x/Makefile
src/driver/0.28.x/Makefile
src/driver/0.30.x/Makefile
src/driver/0.32.x/Makefile
src/driver/0.34.x/Makefile
src/driver/0.36.x/Makefile
src/doclets/Makefile
src/doclets/html/Makefile
src/doclets/devhelp/Makefile
src/doclets/gtkdoc/Makefile
src/valadoc/Makefile
tests/Makefile
])

AC_OUTPUT
