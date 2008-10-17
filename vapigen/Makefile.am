NULL =

VALAC = $(top_builddir)/compiler/valac

SUBDIRS = \
	vala-gen-introspect \
	$(NULL)

AM_CPPFLAGS = \
	$(GLIB_CFLAGS) \
	-I$(top_srcdir) \
	-I$(top_srcdir)/gobject-introspection \
	$(NULL)

bin_PROGRAMS = \
	vapigen \
	vapicheck \
	$(NULL)

BUILT_SOURCES = vapigen.vala.stamp vapicheck.vala.stamp

vapigen_VALASOURCES = \
	valagidlparser.vala \
	valagirparser.vala \
	valamarkupreader.vala \
	valavapigen.vala \
	$(NULL)

vapigen_SOURCES = \
	vapigen.vala.stamp \
	$(vapigen_VALASOURCES:.vala=.c) \
	$(vapigen_VALASOURCES:.vala=.h) \
	$(NULL)

vapicheck_VALASOURCES = \
	valavapicheck.vala \
	$(NULL)

vapicheck_SOURCES = \
	vapicheck.vala.stamp \
	$(vapicheck_VALASOURCES:.vala=.c) \
	$(vapicheck_VALASOURCES:.vala=.h) \
	$(NULL)

vapigen.vala.stamp: $(vapigen_VALASOURCES)
	$(VALAC) -C --vapidir $(srcdir)/../vapi --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --vapidir ../gobject-introspection --pkg gidl --pkg config --basedir $(top_srcdir) $^
	touch $@

vapicheck.vala.stamp: $(vapicheck_VALASOURCES)
	$(VALAC) -C --vapidir $(srcdir)/../vapi --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --vapidir ../gobject-introspection --pkg gidl --pkg config --basedir $(top_srcdir) $^
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

EXTRA_DIST = $(vapigen_VALASOURCES) $(vapicheck_VALASOURCES) vapigen.vala.stamp vapicheck.vala.stamp
