NULL =

INCLUDES = \
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
	gmetadata.h \
	$(NULL)

libgidl_la_LIBADD = \
	$(GLIB_LIBS) \
	$(NULL)

pkglibexecdir = $(libdir)/vala
pkglibexec_PROGRAMS = gen-introspect

BUILT_SOURCES = cparser.h
AM_YFLAGS = -d

gen_introspect_SOURCES = \
	clexer.l \
	cparser.y \
	gen-introspect.c \
	gen-introspect.h \
	$(NULL)

gen_introspect_LDADD = \
	$(GLIB_LIBS) \
	$(GMODULE_LIBS) \
	libgidl.la \
	$(NULL)

EXTRA_DIST = gidl.vapi
