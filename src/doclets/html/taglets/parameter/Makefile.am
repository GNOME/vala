# src/Makefile.am



libtagletparameter_VALASOURCES = \
	taglet.vala       \
	$(NULL)


BUILT_SOURCES = libtagletparameter.vala.stamp


libtagletparameter.vala.stamp: $(libtagletparameter_VALASOURCES)
	$(VALAC) -C --vapidir ../../../htmlhelpers --pkg libhtmlhelpers-1.0 --vapidir ../../../../vapi --pkg valadoc-1.0 --vapidir ../../linkhelper --pkg libhtmlhelper-1.0 --basedir . --disable-non-null --save-temps $^
	touch $@


	

tagletparameterdir = $(libdir)/valadoc/plugins/template/taglets/

tagletparameter_LTLIBRARIES = libtagletparameter.la


libtagletparameter_la_SOURCES =                \
	libtagletparameter.vala.stamp              \
	$(libtagletparameter_VALASOURCES:.vala=.c) \
	$(libtagletparameter_VALASOURCES:.vala=.h) \
	$(NULL)



AM_CFLAGS =  -g               \
	-I ../../../../libvaladoc/   \
	-I ../../../htmlhelpers/     \
	-I ../../linkhelper/         \
	-I ../../                    \
	$(GLIB_CFLAGS)            \
	$(LIBVALA_CFLAGS)         \
	$(NULL)


libtagletparameter_la_LDFLAGS = -module -avoid-version


libtagletparameter_la_LIBADD =                 \
	../../../../libvaladoc/libvaladoc.la \
	../../../htmlhelpers/libhtmlhelpers.la \
	../../linkhelper/libhtmlhelper.la    \
	$(GLIB_LIBS)                      \
	$(LIBVALA_LIBS)                   \
	$(NULL)




EXTRA_DIST = $(libtagletparameter_VALASOURCES)  libtagletparameter.vala.stamp 
