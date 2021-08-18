include $(top_srcdir)/Makefile.common

NULL =

SUBDIRS = \
	tests \
	$(NULL)

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
	valadbusgenextension.vala \
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

EXTRA_DIST = \
	$(valadbusgen_VALASOURCES) \
	valadbusgen.vala.stamp \
	$(NULL)

MAINTAINERCLEANFILES = \
	$(valadbusgen_VALASOURCES:.vala=.c) \
	$(NULL)
