include $(top_srcdir)/Makefile.common

NULL =

SUBDIRS = \
	doclets \
	icons \
	tests \
	$(NULL)

AM_CFLAGS = \
	-DG_LOG_DOMAIN=\"valadoc\" \
	-DPACKAGE_VALADOC_LIBDIR=\"$(pkgdoclibdir)\" \
	-DPACKAGE_VERSION=\"$(VERSION)\" \
	-I$(top_srcdir)/libvaladoc/ \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/ccode \
	-I$(top_srcdir)/vala \
	-I$(top_srcdir)/codegen \
	$(COVERAGE_CFLAGS) \
	$(GLIB_CFLAGS) \
	$(GMODULE_CFLAGS) \
	$(LIBGVC_CFLAGS) \
	$(NULL)

BUILT_SOURCES = valadoc.vala.stamp

bin_PROGRAMS = valadoc

valadoc_VALASOURCES = \
	girwriter.vala \
	initializerbuilder.vala \
	symbolresolver.vala \
	treebuilder.vala \
	valadoc.vala \
    $(NULL)

valadoc_SOURCES = \
	valadoc.vala.stamp \
	$(valadoc_VALASOURCES:.vala=.c) \
	$(NULL)

valadoc_LDADD = \
	$(top_builddir)/libvaladoc/libvaladoc@PACKAGE_SUFFIX@.la \
	$(top_builddir)/vala/libvala@PACKAGE_SUFFIX@.la \
	$(top_builddir)/ccode/libvalaccode.la \
	$(top_builddir)/codegen/libvalaccodegen.la \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(GMODULE_LIBS) \
	$(LIBGVC_LIBS) \
	$(NULL)

valadoc.vala.stamp: $(valadoc_VALASOURCES) $(top_srcdir)/vala/libvala@PACKAGE_SUFFIX@.vapi $(top_srcdir)/libvaladoc/valadoc@PACKAGE_SUFFIX@.vapi
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		-C \
		--vapidir $(top_srcdir)/vapi \
		--pkg gmodule-2.0 \
		--pkg gobject-2.0 \
		--pkg libgvc \
		--vapidir $(top_srcdir)/vala --pkg libvala@PACKAGE_SUFFIX@ \
		--vapidir $(top_srcdir)/ccode --pkg ccode \
		--vapidir $(top_srcdir)/codegen --pkg codegen \
		--vapidir $(top_srcdir)/libvaladoc --pkg valadoc@PACKAGE_SUFFIX@ \
		--pkg config \
		$(filter %.vala %.c,$^)
	touch $@

EXTRA_DIST = \
	$(valadoc_VALASOURCES) \
	valadoc.vala.stamp \
	$(NULL)

if ENABLE_UNVERSIONED
install-exec-hook:
	cd $(DESTDIR)$(bindir) && $(LN_S) -f valadoc@PACKAGE_SUFFIX@$(EXEEXT) valadoc$(EXEEXT)
endif

MAINTAINERCLEANFILES = \
	$(valadoc_VALASOURCES:.vala=.c) \
	$(NULL)
