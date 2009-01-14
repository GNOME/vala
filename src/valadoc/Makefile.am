# src/Makefile.am

NULL =


AM_CFLAGS =                             \
	-DPACKAGE_DATADIR=\"$(libdir)/valadoc/plugins/\" \
	-DPACKAGE_VERSION=\"$(VERSION)\"    \
	-I ../libvaladoc/                   \
	$(GLIB_CFLAGS)                      \
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
	$(NULL)


valadoc.vala.stamp: $(libvaladoc_VALASOURCES)
	$(VALAC) -C --pkg gmodule-2.0 --pkg config --vapidir ../vapi --pkg valadoc-1.0 --basedir $(top_srcdir)/src/valadoc/ valadoc.vala --save-temps $^
	touch $@

EXTRA_DIST = $(valadoc_VALASOURCES)  valadoc.vala.stamp 

