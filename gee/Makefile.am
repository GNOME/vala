NULL =

AM_CPPFLAGS = \
	-I$(top_srcdir) \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = gee.vala.stamp

noinst_LTLIBRARIES = \
	libgee.la
	$(NULL)

libgee_la_VALASOURCES = \
	arraylist.vala \
	collection.vala \
	collectionobject.vala \
	hashmap.vala \
	hashset.vala \
	iterable.vala \
	iterator.vala \
	list.vala \
	map.vala \
	readonlycollection.vala \
	readonlylist.vala \
	readonlymap.vala \
	readonlyset.vala \
	set.vala \
	$(NULL)

libgee_la_SOURCES = \
	gee.vala.stamp \
	$(libgee_la_VALASOURCES:.vala=.c) \
	$(libgee_la_VALASOURCES:.vala=.h) \
	$(NULL)

geeincludedir = $(includedir)/vala-1.0/gee

geeinclude_HEADERS = \
	$(libgee_la_VALASOURCES:.vala=.h) \
	$(NULL)

gee.vapi gee.vala.stamp: $(libgee_la_VALASOURCES)
	$(VALAC) -C --vapidir $(srcdir)/../vapi --basedir $(top_srcdir) --library gee $^
	touch $@

libgee_la_LIBADD = \
	$(GLIB_LIBS) \
	$(NULL)

EXTRA_DIST = $(libgee_la_VALASOURCES) gee.vapi gee.vala.stamp
