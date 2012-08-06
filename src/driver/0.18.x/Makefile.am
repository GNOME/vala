NULL =



VERSIONED_VAPI_DIR=`pkg-config libvala-0.18 --variable vapidir`


if HAVE_LIBVALA_0_17_0
VALA_FLAGS = -D VALA_0_17_0
endif

if HAVE_LIBVALA_0_17__1_3
VALA_FLAGS = -D VALA_0_17__1_3
endif


AM_CFLAGS =  -g \
	-DPACKAGE_ICONDIR=\"$(datadir)/valadoc/icons/\" \
	-I ../../libvaladoc/ \
	$(GLIB_CFLAGS) \
	$(LIBGEE_CFLAGS) \
	$(LIBVALA_0_18_X_CFLAGS) \
	$(LIBVALA_0_17__1_3_CFLAGS) \
	$(LIBVALA_0_17_1_CFLAGS) \
	$(LIBVALA_0_17_0_CFLAGS) \
	$(NULL)



BUILT_SOURCES = libdriver.vala.stamp


driverdir = $(libdir)/valadoc/drivers/0.18.x


libdriver_la_LDFLAGS = -module -avoid-version -no-undefined


driver_LTLIBRARIES =  \
	libdriver.la \
	$(NULL)


libdriver_la_VALASOURCES = \
	initializerbuilder.vala \
	symbolresolver.vala \
	treebuilder.vala \
	girwriter.vala \
	driver.vala \
	$(NULL)


libdriver_la_SOURCES =      \
	libdriver.vala.stamp                 \
	$(libdriver_la_VALASOURCES:.vala=.c) \
	$(NULL)


libdriver.vala.stamp: $(libdriver_la_VALASOURCES)
	$(VALAC) $(VALA_FLAGS) -C --vapidir $(VERSIONED_VAPI_DIR) --vapidir $(top_srcdir)/src/vapi --vapidir $(top_srcdir)/src/libvaladoc --pkg libvala-0.18 --pkg gee-1.0 --pkg valadoc-1.0 --basedir . $^
	touch $@


libdriver_la_LIBADD = \
	../../libvaladoc/libvaladoc.la \
	$(GLIB_LIBS) \
	$(LIBVALA_0_18_X_LIBS) \
	$(LIBVALA_0_17__1_3_LIBS) \
	$(LIBVALA_0_17_1_LIBS) \
	$(LIBVALA_0_17_0_LIBS) \
	$(LIBGEE_LIBS) \
	$(NULL)


EXTRA_DIST = $(libdriver_la_VALASOURCES)  libdriver.vala.stamp 


MAINTAINERCLEANFILES = \
	$(libdriver_la_VALASOURCES:.vala=.c) \
	$(NULL)


