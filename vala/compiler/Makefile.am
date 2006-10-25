NULL =

INCLUDES = \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = valac.vala.stamp

bin_PROGRAMS = \
	valac \
	$(NULL)

valac_SOURCES = \
	valac.vala.stamp \
	valacompiler.c \
	valacompiler.h \
	valacompiler.vala \
	$(NULL)

valac.vala.stamp: $(filter %.vala,$(valac_SOURCES))
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../ccode --pkg ccode --vapidir ../vala --pkg vala --pkg config $^
	touch $@

valac_CPPFLAGS = -include config.h

valac_LDADD = \
	$(GLIB_LIBS) \
	../vala/libvala.la \
	$(NULL)

EXTRA_DIST = valac.vala.stamp
