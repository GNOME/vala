NULL =

AM_CPPFLAGS = \
	$(COVERAGE_CFLAGS) \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/ccode \
	-I$(top_srcdir)/vala \
	-I$(top_srcdir)/codegen \
	$(GLIB_CFLAGS) \
	-DPACKAGE_DATADIR=\"$(pkgdatadir)\" \
	$(NULL)

BUILT_SOURCES = valac.vala.stamp

bin_PROGRAMS = \
	valac \
	$(NULL)

valac_VALASOURCES = \
	valacompiler.vala \
	$(NULL)

valac_SOURCES = \
	valac.vala.stamp \
	$(valac_VALASOURCES:.vala=.c) \
	$(NULL)

valac.vala.stamp: $(valac_VALASOURCES)
	$(VALA_V)$(VALAC) $(COVERAGE_VALAFLAGS) $(VALAFLAGS) -C --vapidir $(srcdir)/../vapi --pkg gobject-2.0 --vapidir $(srcdir)/../gee --pkg gee --vapidir $(srcdir)/../ccode --pkg ccode --vapidir $(srcdir)/../vala --pkg vala --vapidir $(srcdir)/../codegen --pkg codegen --pkg config $^
	@touch $@

valac_LDADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	../codegen/libvala@PACKAGE_SUFFIX@.la \
	$(NULL)

EXTRA_DIST = $(valac_VALASOURCES) valac.vala.stamp

install-exec-hook:
	cd $(DESTDIR)$(bindir) && $(LN_S) -f valac@PACKAGE_SUFFIX@$(EXEEXT) vala@PACKAGE_SUFFIX@$(EXEEXT)
if ENABLE_UNVERSIONED
	cd $(DESTDIR)$(bindir) && $(LN_S) -f valac@PACKAGE_SUFFIX@$(EXEEXT) valac$(EXEEXT)
	cd $(DESTDIR)$(bindir) && $(LN_S) -f vala@PACKAGE_SUFFIX@$(EXEEXT) vala$(EXEEXT)
endif

MAINTAINERCLEANFILES = \
	$(valac_VALASOURCES:.vala=.c) \
	$(NULL)

VALA_V = $(VALA_V_$(V))
VALA_V_ = $(VALA_V_$(AM_DEFAULT_VERBOSITY))
VALA_V_0 = @echo "  VALAC " $^;
