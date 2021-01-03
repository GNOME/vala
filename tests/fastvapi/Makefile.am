NULL =

check-fastvapi: $(top_builddir)/compiler/valac
	G_DEBUG=fatal-warnings $(top_builddir)/compiler/valac \
		-C \
		--disable-version-header \
		--vapidir $(top_srcdir)/vapi \
		--fast-vapi fastvapitest.vapi \
		--basedir $(srcdir) \
		$(srcdir)/fastvapitest.vala; \
	tail -n +3 fastvapitest.vapi | diff -wu $(srcdir)/fastvapitest.vapi-expected - || exit 1; \
	G_DEBUG=fatal-warnings $(top_builddir)/compiler/valac \
		-C \
		--disable-version-header \
		--vapidir $(top_srcdir)/vapi \
		--use-fast-vapi fastvapitest.vapi \
		--basedir $(builddir) \
		$(srcdir)/usefastvapitest.vala || exit 1; \
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
