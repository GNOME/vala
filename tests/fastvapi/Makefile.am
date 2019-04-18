NULL =

check-fastvapi: $(top_builddir)/compiler/valac
	G_DEBUG=fatal-warnings $(top_builddir)/compiler/valac \
		-C \
		--disable-version-header \
		--fast-vapi fastvapitest.vapi \
		$(srcdir)/fastvapitest.vala; \
	tail -n +3 fastvapitest.vapi | diff -wu $(srcdir)/fastvapitest.vapi-expected - || exit 1; \
	rm -f fastvapitest.vapi fastvapitest.c

check: check-fastvapi

EXTRA_DIST = \
	fastvapitest.vala \
	fastvapitest.vapi-expected \
	$(NULL)

CLEANFILES = \
	fastvapitest.c \
	fastvapitest.vapi \
	$(NULL)
