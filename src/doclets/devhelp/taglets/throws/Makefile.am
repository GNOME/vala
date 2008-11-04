# src/Makefile.am



libexceptionparameter_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libexceptionparameter.vala.stamp


libexceptionparameter.vala.stamp: $(libexceptionparameter_VALASOURCES)
	$(VALAC) -C --vapidir ../../../htmlhelpers --pkg libhtmlhelpers-1.0 --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

exceptionparameterdir = $(libdir)/valadoc/plugins/devhelp/taglets/

exceptionparameter_LTLIBRARIES = libexceptionparameter.la


libexceptionparameter_la_SOURCES =                \
	libexceptionparameter.vala.stamp              \
	$(libexceptionparameter_VALASOURCES:.vala=.c) \
	$(libexceptionparameter_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g               \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)            \
	$(LIBVALA_CFLAGS)         \
	$(NULL)


libexceptionparameter_la_LDFLAGS = -module -avoid-version


libexceptionparameter_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la    \
	$(GLIB_LIBS)                      \
	$(LIBVALA_LIBS)                   \
	$(NULL)




EXTRA_DIST = $(libexceptionparameter_VALASOURCES)  libexceptionparameter.vala.stamp 
