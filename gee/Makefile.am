NULL =

INCLUDES = \
	-I$(top_srcdir) \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = gee.vala.stamp

noinst_LTLIBRARIES = \
	libgee.la
	$(NULL)

libgee_la_SOURCES = \
	gee.vala.stamp \
	arraylist.c \
	arraylist.h \
	arraylist.vala \
	collection.c \
	collection.h \
	collection.vala \
	hashmap.c \
	hashmap.h \
	hashmap.vala \
	hashset.c \
	hashset.h \
	hashset.vala \
	iterable.c \
	iterable.h \
	iterable.vala \
	iterator.c \
	iterator.h \
	iterator.vala \
	list.c \
	list.h \
	list.vala \
	map.c \
	map.h \
	map.vala \
	readonlycollection.c \
	readonlycollection.h \
	readonlycollection.vala \
	readonlylist.c \
	readonlylist.h \
	readonlylist.vala \
	readonlymap.c \
	readonlymap.h \
	readonlymap.vala \
	readonlyset.c \
	readonlyset.h \
	readonlyset.vala \
	set.c \
	set.h \
	set.vala \
	$(NULL)

geeincludedir = $(includedir)/vala-1.0/gee

geeinclude_HEADERS = \
	arraylist.h \
	collection.h \
	hashmap.h \
	hashset.h \
	iterable.h \
	iterator.h \
	list.h \
	map.h \
	readonlycollection.h \
	readonlylist.h \
	readonlymap.h \
	readonlyset.h \
	set.h \
	$(NULL)

gee.vala gee.vala.stamp: $(filter %.vala,$(libgee_la_SOURCES))
	$(VALAC) --vapidir $(srcdir)/../vapi --library gee $^
	touch $@

libgee_la_LIBADD = \
	$(GLIB_LIBS) \
	$(NULL)

EXTRA_DIST = gee.vala gee.vala.stamp
