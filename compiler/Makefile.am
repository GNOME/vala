NULL =

AM_CPPFLAGS = \
	$(COVERAGE_CFLAGS) \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/ccode \
	-I$(top_srcdir)/vala \
	-I$(top_srcdir)/codegen \
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
	$(NULL)

valac.vala.stamp: $(valac_VALASOURCES)
	$(VALAC) $(COVERAGE_VALAFLAGS) $(VALAFLAGS) -C --vapidir $(srcdir)/../vapi --pkg gobject-2.0 --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --vapidir ../codegen --pkg codegen --pkg config $^
	touch $@

valac_LDADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	../codegen/libvala.la \
	$(NULL)

EXTRA_DIST = $(valac_VALASOURCES) valac.vala.stamp

MAINTAINERCLEANFILES = \
	$(valac_VALASOURCES:.vala=.c) \
	$(NULL)

