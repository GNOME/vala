NULL =

AM_CPPFLAGS = \
	$(COVERAGE_CFLAGS) \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/ccode \
	-I$(top_srcdir)/vala \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = codegen.vala.stamp

lib_LTLIBRARIES = \
	libvala@PACKAGE_SUFFIX@.la
	$(NULL)

libvala_la_VALASOURCES = \
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
	valagasyncmodule.vala \
	valagdbusclientmodule.vala \
	valagdbusmodule.vala \
	valagdbusservermodule.vala \
	valagerrormodule.vala \
	valagirwriter.vala \
	valagobjectmodule.vala \
	valagtkmodule.vala \
	valagsignalmodule.vala \
	valagtypemodule.vala \
	valagvariantmodule.vala \
	valainterfaceregisterfunction.vala \
	valastructregisterfunction.vala \
	valatyperegisterfunction.vala \
	$(NULL)

libvala@PACKAGE_SUFFIX@_la_SOURCES = \
	codegen.vala.stamp \
	$(libvala_la_VALASOURCES:.vala=.c) \
	$(NULL)

codegenincludedir = $(includedir)/vala@PACKAGE_SUFFIX@

codegeninclude_HEADERS = \
	valacodegen.h \
	$(NULL)

codegen.vapi codegen.vala.stamp: $(libvala_la_VALASOURCES)
	$(VALA_V)$(VALAC) $(COVERAGE_VALAFLAGS) $(VALAFLAGS) -C --vapidir $(srcdir)/../vapi --pkg gobject-2.0 --vapidir $(srcdir)/../gee --pkg gee --vapidir $(srcdir)/../ccode --pkg ccode --vapidir $(srcdir)/../vala --pkg vala -H valacodegen.h --library codegen $^
	@touch $@

libvala@PACKAGE_SUFFIX@_la_LDFLAGS = -no-undefined

libvala@PACKAGE_SUFFIX@_la_LIBADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	../vala/libvalacore.la \
	../ccode/libvalaccode.la \
	$(NULL)

EXTRA_DIST = $(libvala_la_VALASOURCES) codegen.vapi codegen.vala.stamp

MAINTAINERCLEANFILES = \
	codegen.vapi \
	valacodegen.h \
	$(libvala_la_VALASOURCES:.vala=.c) \
	$(NULL)

VALA_V = $(VALA_V_$(V))
VALA_V_ = $(VALA_V_$(AM_DEFAULT_VERBOSITY))
VALA_V_0 = @echo "  VALAC " $^;

