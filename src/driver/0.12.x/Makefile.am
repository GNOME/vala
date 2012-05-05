NULL =


VERSIONED_VAPI_DIR=`pkg-config libvala-0.12 --variable vapidir`


if HAVE_LIBVALA_0_12_X
VALARUNTIMEFLAGS = "LIBVALA_0_12_X"
VALA_PACKAGE_NAME = libvala-0.12
else
VALARUNTIMEFLAGS = "LIBVALA_0_11_0"
VALA_PACKAGE_NAME = vala-0.12
endif


AM_CFLAGS =  -g \
	-DPACKAGE_ICONDIR=\"$(datadir)/valadoc/icons/\" \
	-I ../../libvaladoc/ \
	$(GLIB_CFLAGS) \
	$(LIBGEE_CFLAGS) \
	$(LIBVALA_0_12_X_CFLAGS) \
	$(LIBVALA_0_12_0_CFLAGS) \
	$(NULL)


BUILT_SOURCES = libdriver.vala.stamp


driverdir = $(libdir)/valadoc/drivers/0.12.x


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


libdriver.vala.stamp: $(libdriver_la_VALASOURCES)
	$(VALAC) -C --vapidir $(top_srcdir)/src/vapi --vapidir $(top_srcdir)/src/libvaladoc --pkg $(VALA_PACKAGE_NAME) --pkg gee-1.0 --pkg valadoc-1.0 --vapidir $(VERSIONED_VAPI_DIR) --basedir . -D $(VALARUNTIMEFLAGS) $^
	touch $@


libdriver_la_LIBADD = \
	../../libvaladoc/libvaladoc.la \
	$(GLIB_LIBS) \
	$(LIBVALA_0_12_X_LIBS) \
	$(LIBVALA_0_12_0_LIBS) \
	$(LIBGEE_LIBS) \
	$(NULL)


EXTRA_DIST = $(libdriver_la_VALASOURCES)  libdriver.vala.stamp 


MAINTAINERCLEANFILES = \
	$(libdriver_la_VALASOURCES:.vala=.c) \
	$(NULL)


