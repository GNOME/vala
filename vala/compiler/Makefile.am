NULL =

INCLUDES = \
	$(GLIB_CFLAGS) \
	-I../ccode \
	-I../vala \
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
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../ccode --pkg valaccode --vapidir ../vala --pkg vala $^
	touch $@

valac_LDADD = \
	$(GLIB_LIBS) \
	../ccode/libvalaccode.la \
	../vala/libvala.la \
	$(NULL)

EXTRA_DIST = valac.vala.stamp
