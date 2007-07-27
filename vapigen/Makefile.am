NULL =

SUBDIRS = \
	gidlgen
	$(NULL)

INCLUDES = \
	$(GLIB_CFLAGS) \
	-I ../gobject-introspection \
	$(NULL)

bin_PROGRAMS = \
	vapigen \
	$(NULL)

BUILT_SOURCES = vapigen.vala.stamp

vapigen_SOURCES = \
	vapigen.vala.stamp \
	valagidlparser.c \
	valagidlparser.h \
	valagidlparser.vala \
	valavapigen.c \
	valavapigen.h \
	valavapigen.vala \
	$(NULL)

vapigen.vala.stamp: $(filter %.vala,$(vapigen_SOURCES))
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --vapidir ../gobject-introspection --pkg gidl $^
	touch $@

vapigen_LDADD = \
	$(GLIB_LIBS) \
	../gobject/libvala.la \
	../gobject-introspection/libgidl.la \
	$(NULL)

EXTRA_DIST = vapigen.vala.stamp
