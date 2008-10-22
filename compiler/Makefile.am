NULL =

AM_CPPFLAGS = \
	-I$(top_srcdir) \
	$(GLIB_CFLAGS) \
	-include config.h \
	-DPACKAGE_DATADIR=\"$(pkgdatadir)\" \
	$(NULL)

BUILT_SOURCES = valac.vala.stamp

bin_PROGRAMS = \
	valac \
	$(NULL)

valac_VALASOURCES = \
	valacompiler.vala \
	$(NULL)

valac_SOURCES = \
	valac.vala.stamp \
	$(valac_VALASOURCES:.vala=.c) \
	$(valac_VALASOURCES:.vala=.h) \
	$(NULL)

valac.vala.stamp: $(valac_VALASOURCES)
	$(VALAC) -C --vapidir $(srcdir)/../vapi --pkg gobject-2.0 --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --vapidir ../gobject --pkg gobject --pkg config --basedir $(top_srcdir) $^
	touch $@

valac_LDADD = \
	$(GLIB_LIBS) \
	../gobject/libvala.la \
	$(NULL)

EXTRA_DIST = $(valac_VALASOURCES) valac.vala.stamp
