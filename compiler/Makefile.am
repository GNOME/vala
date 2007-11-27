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

valac_SOURCES = \
	valac.vala.stamp \
	valacompiler.c \
	valacompiler.h \
	valacompiler.vala \
	$(NULL)

valac.vala.stamp: $(filter %.vala,$(valac_SOURCES))
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --vapidir ../gobject --pkg gobject --pkg config --basedir $(top_srcdir) $^
	touch $@

valac_LDADD = \
	$(GLIB_LIBS) \
	../gobject/libvala.la \
	$(NULL)

EXTRA_DIST = valac.vala.stamp
