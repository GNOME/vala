NULL =

DEFAULT_DRIVER = "`$(VALAC) --api-version >& /dev/null; if [ $$? = 0 ]; then $(VALAC) --api-version; else $(VALAC) --version; fi`"

AM_CFLAGS = \
	-DPACKAGE_DATADIR=\"$(libdir)/valadoc\" \
	-DPACKAGE_VERSION=\"$(VERSION)\" \
	-DDEFAULT_DRIVER=\"$(DEFAULT_DRIVER)\" \
	-I $(top_builddir)/src/libvaladoc/ \
	$(GLIB_CFLAGS) \
	$(LIBGEE_CFLAGS) \
	$(GMODULE_CFLAGS) \
	$(LIBGVC_CFLAGS) \
	-g \
	-w \
	$(NULL)

AM_VALAFLAGS = \
	$(VALAFLAGS) \
	--vapidir $(top_srcdir)/src/vapi/ \
	--vapidir $(top_builddir)/src/libvaladoc/ \
	--basedir $(srcdir) \
	--directory $(builddir) \
	-C \
	-g \
	$(NULL)

BUILT_SOURCES = valadoc.vala.stamp

bin_PROGRAMS = valadoc

valadoc_VALASOURCES = \
	valadoc.vala \
    $(NULL)

nodist_valadoc_SOURCES = \
	$(valadoc_VALASOURCES:.vala=.c) \
	$(NULL)

valadoc_LDADD = \
	$(top_builddir)/src/libvaladoc/libvaladoc.la \
	$(GLIB_LIBS) \
	$(GMODULE_LIBS) \
	$(LIBGVC_LIBS) \
	$(LIBGEE_LIBS) \
	$(NULL)

valadoc.vala.stamp: $(valadoc_VALASOURCES) Makefile
	$(VALAC) \
		$(AM_VALAFLAGS) \
		--pkg config \
		--pkg gee-0.8 \
		--pkg gmodule-2.0 \
		--pkg valadoc-1.0 \
		$(filter %.vala %.c,$^)
	touch $@

EXTRA_DIST = \
	$(valadoc_VALASOURCES) \
	$(NULL)

CLEANFILES = \
	$(BUILT_SOURCES) \
	$(nodist_valadoc_SOURCES) \
	$(NULL)

