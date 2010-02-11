NULL =


AM_CFLAGS =                             \
	-DPACKAGE_DATADIR=\"$(libdir)/valadoc/plugins\" \
	-DPACKAGE_VERSION=\"$(VERSION)\"    \
	-I ../libvaladoc/                   \
	$(GLIB_CFLAGS)                      \
	$(LIBGEE_CFLAGS)                    \
	$(LIBVALA_CFLAGS)                   \
	$(GMODULE_CFLAGS)                   \
	$(LIBGVC_CFLAGS)                    \
	$(NULL)


bin_PROGRAMS = valadoc


BUILT_SOURCES = valadoc.vala.stamp


valadoc_VALASOURCES = \
	valadoc.vala      \
    $(NULL)


valadoc_SOURCES = \
	$(valadoc_VALASOURCES:.vala=.c) \
	$(valadoc_VALASOURCES:.vala=.h) \
	$(NULL)


valadoc_LDADD =                 \
	../libvaladoc/libvaladoc.la \
	$(GLIB_LIBS)                \
	$(LIBVALA_LIBS)             \
	$(GMODULE_LIBS)             \
	$(LIBGVC_LIBS)              \
	$(LIBGEE_LIBS)              \
	$(NULL)


valadoc.vala.stamp: $(valadoc_VALASOURCES)
	$(VALAC) -C --pkg config --pkg vala-1.0 --pkg gee-1.0 --pkg gmodule-2.0 --vapidir $(top_srcdir)/src/vapi/ --vapidir ../libvaladoc/ --pkg valadoc-1.0 $^
	touch $@


EXTRA_DIST = $(valadoc_VALASOURCES)  valadoc.vala.stamp 


MAINTAINERCLEANFILES =              \
	$(valadoc_VALASOURCES:.vala=.c) \
	$(valadoc_VALASOURCES:.vala=.h) \
	$(NULL)

