NULL =

VERSIONED_VAPI_DIR=`pkg-config libvala-0.14 --variable vapidir`

if HAVE_LIBVALA_0_13_0
VALA_FLAGS = -D VALA_0_13_0
endif

if HAVE_LIBVALA_0_13_1
VALA_FLAGS = -D VALA_0_13_1
endif


AM_CFLAGS =  -g \
	-DPACKAGE_ICONDIR=\"$(datadir)/valadoc/icons/\" \
	-I $(top_builddir)/src/libvaladoc/ \
	$(GLIB_CFLAGS) \
	$(LIBGEE_CFLAGS) \
	$(LIBGVC_CFLAGS) \
	$(LIBVALA_0_14_X_CFLAGS) \
	$(LIBVALA_0_13_0_CFLAGS) \
	$(LIBVALA_0_13_1_CFLAGS) \
	$(NULL)



BUILT_SOURCES = libdriver.vala.stamp


driverdir = $(libdir)/valadoc/drivers/0.14.x


libdriver_la_LDFLAGS = -module -avoid-version -no-undefined


driver_LTLIBRARIES =  \
	libdriver.la \
	$(NULL)


libdriver_la_VALASOURCES = \
	initializerbuilder.vala \
	symbolresolver.vala \
	treebuilder.vala \
	driver.vala \
	$(NULL)


libdriver_la_SOURCES =      \
	libdriver.vala.stamp                 \
	$(libdriver_la_VALASOURCES:.vala=.c) \
	$(NULL)


libdriver.vala.stamp: $(libdriver_la_VALASOURCES) Makefile
	$(VALAC) $(VALA_FLAGS) -C --vapidir $(top_srcdir)/src/vapi --vapidir $(VERSIONED_VAPI_DIR) --vapidir $(top_srcdir)/src/libvaladoc --pkg libvala-0.14 --pkg gee-0.8 --pkg valadoc-1.0 $(filter %.vala %.c,$^)
	touch $@


libdriver_la_LIBADD = \
	$(top_builddir)/src/libvaladoc/libvaladoc.la \
	$(GLIB_LIBS) \
	$(LIBVALA_0_14_X_LIBS) \
	$(LIBVALA_0_13_0_LIBS) \
	$(LIBVALA_0_13_1_LIBS) \
	$(LIBGEE_LIBS) \
	$(LIBGVC_LIBS) \
	$(NULL)


EXTRA_DIST = $(libdriver_la_VALASOURCES) libdriver.vala.stamp 


MAINTAINERCLEANFILES = \
	$(libdriver_la_VALASOURCES:.vala=.c) \
	$(NULL)


