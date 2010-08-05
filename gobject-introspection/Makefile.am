NULL =

AM_CPPFLAGS = \
	$(GLIB_CFLAGS) \
	$(NULL)

noinst_LTLIBRARIES = \
	libgidl.la \
	$(NULL)

libgidl_la_SOURCES = \
	gidlmodule.c \
	gidlmodule.h \
	gidlnode.c \
	gidlnode.h \
	gidlparser.c \
	gidlparser.h \
	girepository.h \
	gmetadata.c \
	gmetadata.h \
	$(NULL)

libgidl_la_LIBADD = \
	$(GLIB_LIBS) \
	$(GMODULE_LIBS) \
	$(NULL)

pkglibexecdir = $(libdir)/vala@PACKAGE_SUFFIX@
pkglibexec_PROGRAMS = gen-introspect

BUILT_SOURCES = scannerparser.h
AM_YFLAGS = -d

gen_introspect_SOURCES = \
	grealpath.h \
	gidlwriter.c \
	gidlwriter.h \
	scanner.c \
	scanner.h \
	scannerlexer.l \
	scannerparser.y \
	$(NULL)

gen_introspect_LDADD = \
	$(GLIB_LIBS) \
	$(GMODULE_LIBS) \
	$(GTHREAD_LIBS) \
	libgidl.la \
	$(NULL)

EXTRA_DIST = gidl.vapi
