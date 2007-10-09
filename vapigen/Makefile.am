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
	vapicheck \
	$(NULL)

BUILT_SOURCES = vapigen.vala.stamp vapicheck.vala.stamp

vapigen_SOURCES = \
	vapigen.vala.stamp \
	valagidlparser.c \
	valagidlparser.h \
	valagidlparser.vala \
	valavapigen.c \
	valavapigen.h \
	valavapigen.vala \
	$(NULL)

vapicheck_SOURCES = \
	vapicheck.vala.stamp \
	valavapicheck.c \
	valavapicheck.h \
	valavapicheck.vala \
	$(NULL)

vapigen.vala.stamp: $(filter %.vala,$(vapigen_SOURCES))
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --vapidir ../gobject-introspection --pkg gidl --pkg config --basedir $(top_srcdir) $^
	touch $@

vapicheck.vala.stamp: $(filter %.vala,$(vapicheck_SOURCES))
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --vapidir ../gobject-introspection --pkg gidl --pkg config --basedir $(top_srcdir) $^
	touch $@

vapigen_LDADD = \
	$(GLIB_LIBS) \
	../gee/libgee.la \
	../gobject/libvala.la \
	../gobject-introspection/libgidl.la \
	$(NULL)

vapicheck_LDADD = \
	$(GLIB_LIBS) \
	../gee/libgee.la \
	../gobject/libvala.la \
	../gobject-introspection/libgidl.la \
	$(NULL)

EXTRA_DIST = vapigen.vala.stamp vapicheck.vala.stamp
