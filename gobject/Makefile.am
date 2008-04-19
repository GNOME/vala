NULL =

AM_CPPFLAGS = \
	-I$(top_srcdir) \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = gobject.vala.stamp

lib_LTLIBRARIES = \
	libvala.la
	$(NULL)

libvala_la_VALASOURCES = \
	valaccodearraycreationexpressionbinding.vala \
	valaccodeassignmentbinding.vala \
	valaccodebinding.vala \
	valaccodeclassbinding.vala \
	valaccodecompiler.vala \
	valaccodecreationmethodbinding.vala \
	valaccodeelementaccessbinding.vala \
	valaccodeexpressionbinding.vala \
	valaccodegenerator.vala \
	valaccodegeneratorinvocationexpression.vala \
	valaccodegeneratormemberaccess.vala \
	valaccodegeneratorsignal.vala \
	valaccodegeneratorsourcefile.vala \
	valaccodegeneratorstruct.vala \
	valaccodeinterfacebinding.vala \
	valaccodemethodbinding.vala \
	valaccodetypesymbolbinding.vala \
	valaclassregisterfunction.vala \
	valadbusbindingprovider.vala \
	valadbusmethod.vala \
	valadbussignal.vala \
	valagidlwriter.vala \
	valainterfaceregisterfunction.vala \
	valatyperegisterfunction.vala \
	$(NULL)

libvala_la_SOURCES = \
	gobject.vala.stamp \
	$(libvala_la_VALASOURCES:.vala=.c) \
	$(libvala_la_VALASOURCES:.vala=.h) \
	$(NULL)

gobjectincludedir = $(includedir)/vala-1.0/gobject

gobjectinclude_HEADERS = \
	$(libvala_la_VALASOURCES:.vala=.h) \
	$(NULL)

gobject.vapi gobject.vala.stamp: $(libvala_la_VALASOURCES)
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --basedir $(top_srcdir) --library gobject $^
	touch $@

libvala_la_LDFLAGS = -no-undefined

libvala_la_LIBADD = \
	$(GLIB_LIBS) \
	../vala/libvalacore.la \
	$(NULL)

EXTRA_DIST = $(libvala_la_VALASOURCES) gobject.vapi gobject.vala.stamp
