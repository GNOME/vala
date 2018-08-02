NULL =

check-girwriter: $(top_builddir)/compiler/valac
	$(top_builddir)/compiler/valac \
		-C \
		--disable-version-header \
		--vapidir $(top_srcdir)/vapi \
		--gir GirTest-1.0.gir \
		--library girtest \
		$(srcdir)/girtest.vala; \
	tail -n +3 girtest.vapi | diff -wu $(srcdir)/girtest.vapi-expected - || exit 1; \
	diff -wu $(srcdir)/GirTest-1.0.gir-expected GirTest-1.0.gir || exit 1; \
	rm -f GirTest-1.0.gir girtest.vapi girtest.c

check: check-girwriter

EXTRA_DIST = \
	girtest.vala \
	girtest.vapi-expected \
	GirTest-1.0.gir-expected \
	$(NULL)

CLEANFILES = \
	girtest.c \
	girtest.vapi \
	GirTest-1.0.gir \
	$(NULL)
