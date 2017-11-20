include $(top_srcdir)/Makefile.common

NULL =

AM_CPPFLAGS = \
	$(GLIB_CFLAGS) \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/vala \
	$(NULL)

noinst_PROGRAMS = \
	valadbusgen \
	$(NULL)

BUILT_SOURCES = valadbusgen.vala.stamp

valadbusgen_VALASOURCES = \
	valadbusgen.vala \
	valadbusparser.vala \
	valadbusvariantmodule.vala \
	valadbusnamespacestrategy.vala \
	$(NULL)

valadbusgen_SOURCES = \
	valadbusgen.vala.stamp \
	$(valadbusgen_VALASOURCES:.vala=.c) \
	$(NULL)


valadbusgen.vala.stamp: $(valadbusgen_VALASOURCES)
	$(VALA_V)$(VALAC) \
		$(VALAFLAGS) \
		-C \
		--vapidir $(top_srcdir)/vapi \
		--vapidir $(top_srcdir)/gee --pkg gee \
		--vapidir $(top_srcdir)/vala --pkg vala \
		--pkg config \
		$^
	@touch $@


valadbusgen_LDADD = \
	$(GLIB_LIBS) \
	$(top_builddir)/vala/libvala@PACKAGE_SUFFIX@.la \
	$(NULL)

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = valadbusgen@PACKAGE_SUFFIX@.pc

valadbusgen@PACKAGE_SUFFIX@.pc: valadbusgen.pc
	cp $< $@

EXTRA_DIST = \
	$(valadbusgen_VALASOURCES) \
	valadbusgen.vala.stamp \
	$(NULL)

CLEANFILES = \
	valadbusgen@PACKAGE_SUFFIX@.pc
	$(NULL)

if ENABLE_UNVERSIONED
install-exec-hook:
	cd $(DESTDIR)$(bindir) && $(LN_S) -f valadbusgen@PACKAGE_SUFFIX@$(EXEEXT) valadbusgen$(EXEEXT)

install-data-hook:
	cd $(DESTDIR)$(pkgconfigdir) && $(LN_S) -f valadbusgen@PACKAGE_SUFFIX@.pc valadbusgen.pc
endif

MAINTAINERCLEANFILES = \
	$(valadbusgen_VALASOURCES:.vala=.c) \
	$(NULL)
