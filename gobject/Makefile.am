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
	valacodegenerator.c \
	valacodegenerator.h \
	valacodegenerator.vala \
	$(NULL)

gobjectincludedir = $(includedir)/vala-1.0/gobject

gobjectinclude_HEADERS = \
	valacodegenerator.h \
	$(NULL)

gobject.vala gobject.vala.stamp: $(filter %.vala,$(libvala_la_SOURCES))
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --library gobject $^
	touch $@

libvala_la_LIBADD = \
	$(GLIB_LIBS) \
	../vala/libvalacore.la \
	$(NULL)

EXTRA_DIST = gobject.vala gobject.vala.stamp
