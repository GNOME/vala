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
	libvala.la
	$(NULL)

libvala_la_VALASOURCES = \
	valaccodearraymodule.vala \
	valaccodeassignmentmodule.vala \
	valaccodebasemodule.vala \
	valaccodecompiler.vala \
	valaccodecontrolflowmodule.vala \
	valaccodedeclarationspace.vala \
	valaccodedelegatemodule.vala \
	valaccodegenerator.vala \
	valaccodememberaccessmodule.vala \
	valaccodemethodcallmodule.vala \
	valaccodemethodmodule.vala \
	valaccodemodule.vala \
	valaccodestructmodule.vala \
	valaclassregisterfunction.vala \
	valactype.vala \
	valadbusclientmodule.vala \
	valadbusinterfaceregisterfunction.vala \
	valadbusmodule.vala \
	valadbusservermodule.vala \
	valaenumregisterfunction.vala \
	valagerrormodule.vala \
	valagirwriter.vala \
	valagobjectmodule.vala \
	valagsignalmodule.vala \
	valagtypemodule.vala \
	valagasyncmodule.vala \
	valainterfaceregisterfunction.vala \
	valastructregisterfunction.vala \
	valatyperegisterfunction.vala \
	$(NULL)

libvala_la_SOURCES = \
	codegen.vala.stamp \
	$(libvala_la_VALASOURCES:.vala=.c) \
	$(NULL)

codegenincludedir = $(includedir)/vala-1.0

codegeninclude_HEADERS = \
	valacodegen.h \
	$(NULL)

codegen.vapi codegen.vala.stamp: $(libvala_la_VALASOURCES)
	$(VALA_V)$(VALAC) $(COVERAGE_VALAFLAGS) $(VALAFLAGS) -C --vapidir $(srcdir)/../vapi --pkg gobject-2.0 --vapidir $(srcdir)/../gee --pkg gee --vapidir $(srcdir)/../ccode --pkg ccode --vapidir $(srcdir)/../vala --pkg vala -H valacodegen.h --library codegen $^
	@touch $@

libvala_la_LDFLAGS = -no-undefined

libvala_la_LIBADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	../vala/libvalacore.la \
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

