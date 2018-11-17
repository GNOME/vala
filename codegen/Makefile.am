include $(top_srcdir)/Makefile.common

NULL =

AM_CPPFLAGS = \
	-DG_LOG_DOMAIN=\"vala-ccodegen\" \
	$(COVERAGE_CFLAGS) \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/ccode \
	-I$(top_srcdir)/vala \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = codegen.vala.stamp

libvalaccodegen_la_LTLIBRARIES = \
	libvalaccodegen.la \
	$(NULL)

libvalaccodegen_ladir = $(pkglibdir)

libvalaccodegen_la_LDFLAGS = \
	-no-undefined \
	-avoid-version \
	$(NULL)

libvalaccodegen_la_VALASOURCES = \
	valaccode.vala \
	valaccodearraymodule.vala \
	valaccodeassignmentmodule.vala \
	valaccodeattribute.vala \
	valaccodebasemodule.vala \
	valaccodecompiler.vala \
	valaccodecontrolflowmodule.vala \
	valaccodedelegatemodule.vala \
	valaccodememberaccessmodule.vala \
	valaccodemethodcallmodule.vala \
	valaccodemethodmodule.vala \
	valaccodestructmodule.vala \
	valaclassregisterfunction.vala \
	valactype.vala \
	valaenumregisterfunction.vala \
	valaerrordomainregisterfunction.vala \
	valagasyncmodule.vala \
	valagdbusclientmodule.vala \
	valagdbusmodule.vala \
	valagdbusservermodule.vala \
	valagerrormodule.vala \
	valagirwriter.vala \
	valaglibvalue.vala \
	valagobjectmodule.vala \
	valagtkmodule.vala \
	valagsignalmodule.vala \
	valagtypemodule.vala \
	valagvaluemodule.vala \
	valagvariantmodule.vala \
	valainterfaceregisterfunction.vala \
	valastructregisterfunction.vala \
	valatyperegisterfunction.vala \
	$(NULL)

libvalaccodegen_la_SOURCES = \
	codegen.vala.stamp \
	$(libvalaccodegen_la_VALASOURCES:.vala=.c) \
	$(NULL)

codegen.vapi codegen.vala.stamp: $(libvalaccodegen_la_VALASOURCES)
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		-C \
		--vapidir $(top_srcdir)/vapi --pkg gobject-2.0 \
		--vapidir $(top_srcdir)/gee --pkg gee \
		--vapidir $(top_srcdir)/ccode --pkg ccode \
		--vapidir $(top_srcdir)/vala --pkg vala \
		-H valacodegen.h \
		--library codegen \
		$^
	@touch $@

libvalaccodegen_la_LIBADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(top_builddir)/vala/libvala@PACKAGE_SUFFIX@.la \
	$(top_builddir)/ccode/libvalaccode.la \
	$(NULL)

EXTRA_DIST = $(libvalaccodegen_la_VALASOURCES) codegen.vapi codegen.vala.stamp valacodegen.h

MAINTAINERCLEANFILES = \
	codegen.vapi \
	valacodegen.h \
	$(libvalaccodegen_la_VALASOURCES:.vala=.c) \
	$(NULL)
