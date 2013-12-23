NULL =

DEFAULT_DRIVER = "`$(VALAC) --version`"


AM_CFLAGS =                                 \
	-DPACKAGE_DATADIR=\"$(libdir)/valadoc\" \
	-DPACKAGE_VERSION=\"$(VERSION)\"        \
	-DDEFAULT_DRIVER=\"$(DEFAULT_DRIVER)\"         \
	-I $(top_builddir)/src/libvaladoc/                       \
	$(GLIB_CFLAGS)                          \
	$(LIBGEE_CFLAGS)                        \
	$(GMODULE_CFLAGS)                       \
	$(LIBGVC_CFLAGS)                        \
	$(NULL)


bin_PROGRAMS = valadoc


BUILT_SOURCES = valadoc.vala.stamp


valadoc_VALASOURCES = \
	valadoc.vala      \
    $(NULL)


valadoc_SOURCES = \
	$(valadoc_VALASOURCES:.vala=.c) \
	$(NULL)


valadoc_LDADD =                 \
	$(top_builddir)/src/libvaladoc/libvaladoc.la \
	$(GLIB_LIBS)                \
	$(GMODULE_LIBS)             \
	$(LIBGVC_LIBS)              \
	$(LIBGEE_LIBS)              \
	$(NULL)


valadoc.vala.stamp: $(valadoc_VALASOURCES) Makefile
	$(VALAC) -C --pkg config --pkg gee-0.8 --pkg gmodule-2.0 --vapidir $(top_srcdir)/src/vapi/ --vapidir $(top_builddir)/src/libvaladoc/ --pkg valadoc-1.0 $(filter %.vala %.c,$^)
	touch $@


EXTRA_DIST = $(valadoc_VALASOURCES)  valadoc.vala.stamp 


MAINTAINERCLEANFILES =              \
	$(valadoc_VALASOURCES:.vala=.c) \
	$(valadoc_VALASOURCES:.vala=.h) \
	$(NULL)

