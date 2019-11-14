NULL =

check-fastvapi: $(top_builddir)/compiler/valac
	G_DEBUG=fatal-warnings $(top_builddir)/compiler/valac \
		-C \
		--disable-version-header \
		--fast-vapi fastvapitest.vapi \
		--basedir $(srcdir) \
		$(srcdir)/fastvapitest.vala; \
	tail -n +3 fastvapitest.vapi | diff -wu $(srcdir)/fastvapitest.vapi-expected - || exit 1; \
	G_DEBUG=fatal-warnings $(top_builddir)/compiler/valac \
		-C \
		--disable-version-header \
		--use-fast-vapi fastvapitest.vapi \
		--basedir $(srcdir) \
		$(srcdir)/usefastvapitest.vala; \
	rm -f fastvapitest.vapi fastvapitest.c usefastvapitest.c

check: check-fastvapi

EXTRA_DIST = \
	fastvapitest.vala \
	fastvapitest.vapi-expected \
	usefastvapitest.vala \
	$(NULL)

CLEANFILES = \
	fastvapitest.c \
	fastvapitest.vapi \
	usefastvapitest.c \
	$(NULL)
