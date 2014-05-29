include $(top_srcdir)/Makefile.common

NULL =

AM_CPPFLAGS = \
	$(COVERAGE_CFLAGS) \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = gee.vala.stamp

noinst_LTLIBRARIES = \
	libgee.la
	$(NULL)

libgee_la_VALASOURCES = \
	arraylist.vala \
	collection.vala \
	hashmap.vala \
	hashset.vala \
	iterable.vala \
	mapiterator.vala \
	iterator.vala \
	list.vala \
	map.vala \
	set.vala \
	$(NULL)

libgee_la_SOURCES = \
	gee.vala.stamp \
	$(libgee_la_VALASOURCES:.vala=.c) \
	$(NULL)

geeincludedir = $(includedir)/vala@PACKAGE_SUFFIX@

geeinclude_HEADERS = \
	valagee.h \
	$(NULL)

gee.vapi gee.vala.stamp: $(libgee_la_VALASOURCES)
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		-C \
		--vapidir $(top_srcdir)/vapi --pkg gobject-2.0 \
		-H valagee.h \
		--library gee \
		$^
	@touch $@

libgee_la_LIBADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(NULL)

EXTRA_DIST = $(libgee_la_VALASOURCES) gee.vapi gee.vala.stamp

MAINTAINERCLEANFILES = \
	gee.vapi \
	valagee.h \
	$(libgee_la_VALASOURCES:.vala=.c) \
	$(NULL)
