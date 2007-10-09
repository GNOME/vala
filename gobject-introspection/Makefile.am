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

EXTRA_DIST = gidl.vapi
