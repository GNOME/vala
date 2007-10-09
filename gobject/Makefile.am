NULL =

INCLUDES = \
	-I$(top_srcdir) \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = gobject.vala.stamp

lib_LTLIBRARIES = \
	libvala.la
	$(NULL)

libvala_la_SOURCES = \
	gobject.vala.stamp \
	valaccodearraycreationexpressionbinding.c \
	valaccodearraycreationexpressionbinding.h \
	valaccodearraycreationexpressionbinding.vala \
	valaccodeassignmentbinding.c \
	valaccodeassignmentbinding.h \
	valaccodeassignmentbinding.vala \
	valaccodebinding.c \
	valaccodebinding.h \
	valaccodebinding.vala \
	valaccodecompiler.c \
	valaccodecompiler.h \
	valaccodecompiler.vala \
	valaccodeelementaccessbinding.c \
	valaccodeelementaccessbinding.h \
	valaccodeelementaccessbinding.vala \
	valaccodeexpressionbinding.c \
	valaccodeexpressionbinding.h \
	valaccodeexpressionbinding.vala \
	valaccodegenerator.c \
	valaccodegenerator.h \
	valaccodegenerator.vala \
	valaccodegeneratorclass.c \
	valaccodegeneratorclass.h \
	valaccodegeneratorclass.vala \
	valaccodegeneratorinterface.c \
	valaccodegeneratorinterface.h \
	valaccodegeneratorinterface.vala \
	valaccodegeneratorinvocationexpression.c \
	valaccodegeneratorinvocationexpression.h \
	valaccodegeneratorinvocationexpression.vala \
	valaccodegeneratormemberaccess.c \
	valaccodegeneratormemberaccess.h \
	valaccodegeneratormemberaccess.vala \
	valaccodegeneratormethod.c \
	valaccodegeneratormethod.h \
	valaccodegeneratormethod.vala \
	valaccodegeneratorsignal.c \
	valaccodegeneratorsignal.h \
	valaccodegeneratorsignal.vala \
	valaccodegeneratorsourcefile.c \
	valaccodegeneratorsourcefile.h \
	valaccodegeneratorsourcefile.vala \
	valaccodegeneratorstruct.c \
	valaccodegeneratorstruct.h \
	valaccodegeneratorstruct.vala \
	valaclassregisterfunction.c \
	valaclassregisterfunction.h \
	valaclassregisterfunction.vala \
	valadbusbindingprovider.c \
	valadbusbindingprovider.h \
	valadbusbindingprovider.vala \
	valadbusmethod.c \
	valadbusmethod.h \
	valadbusmethod.vala \
	valadbussignal.c \
	valadbussignal.h \
	valadbussignal.vala \
	valainterfaceregisterfunction.c \
	valainterfaceregisterfunction.h \
	valainterfaceregisterfunction.vala \
	valatyperegisterfunction.c \
	valatyperegisterfunction.h \
	valatyperegisterfunction.vala \
	$(NULL)

gobjectincludedir = $(includedir)/vala-1.0/gobject

gobjectinclude_HEADERS = \
	valaccodearraycreationexpressionbinding.h \
	valaccodeassignmentbinding.h \
	valaccodebinding.h \
	valaccodecompiler.h \
	valaccodeelementaccessbinding.h \
	valaccodeexpressionbinding.h \
	valaccodegenerator.h \
	valaccodegeneratorclass.h \
	valaccodegeneratorinterface.h \
	valaccodegeneratorinvocationexpression.h \
	valaccodegeneratormemberaccess.h \
	valaccodegeneratormethod.h \
	valaccodegeneratorsignal.h \
	valaccodegeneratorsourcefile.h \
	valaccodegeneratorstruct.h \
	valaclassregisterfunction.h \
	valadbusbindingprovider.h \
	valadbusmethod.h \
	valadbussignal.h \
	valainterfaceregisterfunction.h \
	valatyperegisterfunction.h \
	$(NULL)

gobject.vapi gobject.vala.stamp: $(filter %.vala,$(libvala_la_SOURCES))
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --basedir $(top_srcdir) --library gobject $^
	touch $@

libvala_la_LIBADD = \
	$(GLIB_LIBS) \
	../vala/libvalacore.la \
	$(NULL)

EXTRA_DIST = gobject.vapi gobject.vala.stamp
