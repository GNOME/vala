NULL =

INCLUDES = \
	$(GLIB_CFLAGS) \
	-I../ccode \
	-I../vala \
	$(NULL)

bin_PROGRAMS = \
	valac \
	$(NULL)

valac_VALASOURCES = \
	valacompiler.vala \
	$(NULL)

valac_SOURCES = \
	valacompiler.c \
	valacompiler.h \
	$(NULL)

$(subst .vala,.c,$(valac_VALASOURCES)) $(subst .vala,.h,$(valac_VALASOURCES)): $(valac_VALASOURCES)
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../ccode --pkg valaccode --vapidir ../vala --pkg vala $^

valac_LDADD = \
	$(GLIB_LIBS) \
	../ccode/libvalaccode.la \
	../vala/libvala.la \
	$(NULL)

EXTRA_DIST = $(valac_VALASOURCES)
