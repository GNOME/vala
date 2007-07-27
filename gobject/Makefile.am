NULL =

INCLUDES = \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = gobject.vala.stamp

lib_LTLIBRARIES = \
	libvala.la
	$(NULL)

libvala_la_SOURCES = \
	gobject.vala.stamp \
	valaccodecompiler.c \
	valaccodecompiler.h \
	valaccodecompiler.vala \
	valaclassregisterfunction.c \
	valaclassregisterfunction.h \
	valaclassregisterfunction.vala \
	valacodegenerator.c \
	valacodegenerator.h \
	valacodegenerator.vala \
	valacodegeneratorassignment.c \
	valacodegeneratorassignment.h \
	valacodegeneratorassignment.vala \
	valacodegeneratorclass.c \
	valacodegeneratorclass.h \
	valacodegeneratorclass.vala \
	valacodegeneratorinterface.c \
	valacodegeneratorinterface.h \
	valacodegeneratorinterface.vala \
	valacodegeneratorinvocationexpression.c \
	valacodegeneratorinvocationexpression.h \
	valacodegeneratorinvocationexpression.vala \
	valacodegeneratormemberaccess.c \
	valacodegeneratormemberaccess.h \
	valacodegeneratormemberaccess.vala \
	valacodegeneratormethod.c \
	valacodegeneratormethod.h \
	valacodegeneratormethod.vala \
	valacodegeneratorsignal.c \
	valacodegeneratorsignal.h \
	valacodegeneratorsignal.vala \
	valacodegeneratorsourcefile.c \
	valacodegeneratorsourcefile.h \
	valacodegeneratorsourcefile.vala \
	valacodegeneratorstruct.c \
	valacodegeneratorstruct.h \
	valacodegeneratorstruct.vala \
	valainterfaceregisterfunction.c \
	valainterfaceregisterfunction.h \
	valainterfaceregisterfunction.vala \
	valatyperegisterfunction.c \
	valatyperegisterfunction.h \
	valatyperegisterfunction.vala \
	$(NULL)

gobjectincludedir = $(includedir)/vala-1.0/gobject

gobjectinclude_HEADERS = \
	valaccodecompiler.h \
	valaclassregisterfunction.h \
	valacodegenerator.h \
	valacodegeneratorassignment.h \
	valacodegeneratorclass.h \
	valacodegeneratorinterface.h \
	valacodegeneratorinvocationexpression.h \
	valacodegeneratormemberaccess.h \
	valacodegeneratormethod.h \
	valacodegeneratorsignal.h \
	valacodegeneratorsourcefile.h \
	valacodegeneratorstruct.h \
	valainterfaceregisterfunction.h \
	valatyperegisterfunction.h \
	$(NULL)

gobject.vala gobject.vala.stamp: $(filter %.vala,$(libvala_la_SOURCES))
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --library gobject $^
	touch $@

libvala_la_LIBADD = \
	$(GLIB_LIBS) \
	../vala/libvalacore.la \
	$(NULL)

EXTRA_DIST = gobject.vala gobject.vala.stamp
