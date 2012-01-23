NULL =

VALAC = $(top_builddir)/compiler/valac

SUBDIRS = \
	vala-gen-introspect \
	$(NULL)

AM_CPPFLAGS = \
	$(GLIB_CFLAGS) \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/ccode \
	-I$(top_srcdir)/vala \
	-I$(top_srcdir)/gobject-introspection \
	$(NULL)

bin_PROGRAMS = \
	vapigen \
	vapicheck \
	$(NULL)

BUILT_SOURCES = vapigen.vala.stamp vapicheck.vala.stamp

vapigen_VALASOURCES = \
	valagidlparser.vala \
	valavapigen.vala \
	$(NULL)

vapigen_SOURCES = \
	vapigen.vala.stamp \
	$(vapigen_VALASOURCES:.vala=.c) \
	$(NULL)

vapicheck_VALASOURCES = \
	valavapicheck.vala \
	$(NULL)

vapicheck_SOURCES = \
	vapicheck.vala.stamp \
	$(vapicheck_VALASOURCES:.vala=.c) \
	$(NULL)

vapigen.vala.stamp: $(vapigen_VALASOURCES)
	$(VALA_V)$(VALAC) $(VALAFLAGS) -C --vapidir $(srcdir)/../vapi --vapidir $(srcdir)/../gee --pkg gee --vapidir $(srcdir)/../ccode --pkg ccode --vapidir $(srcdir)/../vala --pkg vala --vapidir $(srcdir)/../gobject-introspection --pkg gidl --pkg config $^
	@touch $@

vapicheck.vala.stamp: $(vapicheck_VALASOURCES)
	$(VALA_V)$(VALAC) $(VALAFLAGS) -C --vapidir $(srcdir)/../vapi --vapidir $(srcdir)/../gee --pkg gee --vapidir $(srcdir)/../ccode --pkg ccode --vapidir $(srcdir)/../vala --pkg vala --vapidir $(srcdir)/../gobject-introspection --pkg gidl --pkg config $^
	@touch $@

vapigen_LDADD = \
	$(GLIB_LIBS) \
	../codegen/libvala@PACKAGE_SUFFIX@.la \
	../gobject-introspection/libgidl.la \
	$(NULL)

vapicheck_LDADD = \
	$(GLIB_LIBS) \
	../codegen/libvala@PACKAGE_SUFFIX@.la \
	../gobject-introspection/libgidl.la \
	$(NULL)

if ENABLE_UNVERSIONED
makedir = $(datadir)/vala
make_DATA = Makefile.vapigen

aclocaldir = $(datadir)/aclocal
aclocal_DATA = vapigen.m4
endif

pkgconfigdir = $(datadir)/pkgconfig
pkgconfig_DATA = vapigen@PACKAGE_SUFFIX@.pc

vapigen@PACKAGE_SUFFIX@.pc: vapigen.pc
	cp $< $@

EXTRA_DIST = \
	$(vapigen_VALASOURCES) \
	$(vapicheck_VALASOURCES) \
	Makefile.vapigen \
	vapigen.m4 \
	vapigen.vala.stamp \
	vapicheck.vala.stamp \
	$(NULL)

CLEANFILES = \
	vapigen@PACKAGE_SUFFIX@.pc
	$(NULL)

if ENABLE_UNVERSIONED
install-exec-hook:
	cd $(DESTDIR)$(bindir) && $(LN_S) -f vapigen@PACKAGE_SUFFIX@$(EXEEXT) vapigen$(EXEEXT)
	cd $(DESTDIR)$(bindir) && $(LN_S) -f vapicheck@PACKAGE_SUFFIX@$(EXEEXT) vapicheck$(EXEEXT)

install-data-hook:
	cd $(DESTDIR)$(pkgconfigdir) && $(LN_S) -f vapigen@PACKAGE_SUFFIX@.pc vapigen.pc
endif

MAINTAINERCLEANFILES = \
	$(vapigen_VALASOURCES:.vala=.c) \
	$(vapicheck_VALASOURCES:.vala=.c) \
	$(NULL)

VALA_V = $(VALA_V_$(V))
VALA_V_ = $(VALA_V_$(AM_DEFAULT_VERBOSITY))
VALA_V_0 = @echo "  VALAC " $^;
