NULL =

VERSIONED_VAPI_DIR = $(shell pkg-config libvala-0.24 --variable vapidir)

AM_CFLAGS = \
	-DPACKAGE_ICONDIR=\"$(datadir)/valadoc/icons/\" \
	-I $(top_builddir)/src/libvaladoc/ \
	$(GLIB_CFLAGS) \
	$(LIBGEE_CFLAGS) \
	$(LIBGVC_CFLAGS) \
	$(LIBVALA_0_24_X_CFLAGS) \
	-g \
	-w \
	$(NULL)

AM_VALAFLAGS = \
	$(VALAFLAGS) \
	--vapidir $(VERSIONED_VAPI_DIR) \
	--vapidir $(top_srcdir)/src/vapi \
	--vapidir $(top_srcdir)/src/libvaladoc \
	--basedir $(srcdir) \
	--directory $(builddir) \
	-C \
	-g \
	$(NULL)

BUILT_SOURCES = libdriver.vala.stamp

driver_LTLIBRARIES = libdriver.la

driverdir = $(libdir)/valadoc/drivers/0.24.x

libdriver_la_LDFLAGS = -module -avoid-version -no-undefined

libdriver_la_VALASOURCES = \
	initializerbuilder.vala \
	symbolresolver.vala \
	treebuilder.vala \
	girwriter.vala \
	driver.vala \
	$(NULL)

nodist_libdriver_la_SOURCES = \
	$(libdriver_la_VALASOURCES:.vala=.c) \
	$(NULL)

libdriver.vala.stamp: $(libdriver_la_VALASOURCES) Makefile
	$(VALAC) \
		$(AM_VALAFLAGS) \
		--pkg libvala-0.24 \
		--pkg gee-0.8 \
		--pkg valadoc-1.0 \
		$(filter %.vala %.c,$^)
	touch $@

libdriver_la_LIBADD = \
	$(top_builddir)/src/libvaladoc/libvaladoc.la \
	$(GLIB_LIBS) \
	$(LIBVALA_0_24_X_LIBS) \
	$(LIBGEE_LIBS) \
	$(LIBGVC_LIBS) \
	$(NULL)

EXTRA_DIST = \
	$(libdriver_la_VALASOURCES) \
	$(NULL)

CLEANFILES = \
	$(BUILT_SOURCES) \
	$(nodist_libdriver_la_SOURCES) \
	$(NULL)

