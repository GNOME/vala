NULL =

INCLUDES = \
	$(GLIB_CFLAGS) \
	$(VALA_CFLAGS) \
	-I ../gobject-introspection \
	$(NULL)

bin_PROGRAMS = \
	vapigen \
	$(NULL)

BUILT_SOURCES = vapigen.vala.stamp

vapigen_SOURCES = \
	vapigen.vala.stamp \
	valagidlparser.c \
	valagidlparser.h \
	valagidlparser.vala \
	valavapigen.c \
	valavapigen.h \
	valavapigen.vala \
	$(NULL)

vapigen.vala.stamp: $(filter %.vala,$(vapigen_SOURCES))
	$(VALAC) --vapidir ../gobject-introspection --pkg gidl --pkg vala-1.0 $^
	touch $@

vapigen_LDADD = \
	$(GLIB_LIBS) \
	$(VALA_LIBS) \
	../gobject-introspection/libgidl.la \
	$(NULL)

EXTRA_DIST = vapigen.vala.stamp
