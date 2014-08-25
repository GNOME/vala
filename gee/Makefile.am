include $(top_srcdir)/Makefile.common

NULL =

AM_CPPFLAGS = \
	$(COVERAGE_CFLAGS) \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = gee.vala.stamp

noinst_LTLIBRARIES = \
	libgee.la \
	$(NULL)

libgee_la_VALASOURCES = \
	abstractbidirlist.vala \
	abstractbidirsortedmap.vala \
	abstractbidirsortedset.vala \
	abstractcollection.vala \
	abstractlist.vala \
	abstractmap.vala \
	abstractmultimap.vala \
	abstractmultiset.vala \
	abstractqueue.vala \
	abstractset.vala \
	abstractsortedmap.vala \
	abstractsortedset.vala \
	arraylist.vala \
	arrayqueue.vala \
	bidiriterator.vala \
	bidirlistiterator.vala \
	bidirlist.vala \
	bidirmapiterator.vala \
	bidirsortedmap.vala \
	bidirsortedset.vala \
	collection.vala \
	comparable.vala \
	concurrentlist.vala \
	deque.vala \
	functions.vala \
	hashable.vala \
	hashmap.vala \
	hashmultimap.vala \
	hashmultiset.vala \
	hashset.vala \
	hazardpointer.vala \
	iterable.vala \
	iterator.vala \
	lazy.vala \
	linkedlist.vala \
	listiterator.vala \
	list.vala \
	mapiterator.vala \
	map.vala \
	multimap.vala \
	multiset.vala \
	priorityqueue.vala \
	queue.vala \
	readonlybidirlist.vala \
	readonlybidirsortedmap.vala \
	readonlybidirsortedset.vala \
	readonlycollection.vala \
	readonlylist.vala \
	readonlymap.vala \
	readonlyset.vala \
	readonlysortedmap.vala \
	readonlysortedset.vala \
	set.vala \
	sortedmap.vala \
	sortedset.vala \
	timsort.vala \
	traversable.vala \
	treemap.vala \
	treemultimap.vala \
	treemultiset.vala \
	treeset.vala \
	unfolditerator.vala \
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
		--use-header \
		-H valagee.h \
		--library gee \
		$^
	@touch $@

libgee_la_LIBADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(NULL)

EXTRA_DIST = $(libgee_la_VALASOURCES) gee.vapi gee.vala.stamp valagee.h

MAINTAINERCLEANFILES = \
	gee.vapi \
	valagee.h \
	$(libgee_la_VALASOURCES:.vala=.c) \
	$(NULL)
