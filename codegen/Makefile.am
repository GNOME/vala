NULL =

AM_CPPFLAGS = \
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
	$(VALAC) $(VALAFLAGS) -C --vapidir $(srcdir)/../vapi --pkg gobject-2.0 --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala -H valacodegen.h --library codegen $^
	touch $@

libvala_la_LDFLAGS = -no-undefined

libvala_la_LIBADD = \
	$(GLIB_LIBS) \
	../vala/libvalacore.la \
	$(NULL)

EXTRA_DIST = $(libvala_la_VALASOURCES) codegen.vapi codegen.vala.stamp

MAINTAINERCLEANFILES = \
	codegen.vapi \
	valacodegen.h \
	$(libvala_la_VALASOURCES:.vala=.c) \
	$(NULL)

