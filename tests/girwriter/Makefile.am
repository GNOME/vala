NULL =

check-girwriter: $(top_builddir)/compiler/valac
	G_DEBUG=fatal-warnings $(top_builddir)/compiler/valac \
		-C \
		--disable-version-header \
		--vapidir $(top_srcdir)/vapi \
		--pkg gio-2.0 \
		--gir GirTest-1.0.gir \
		--library girtest \
		--shared-library girtest \
		$(srcdir)/girtest.vala; \
	tail -n +3 girtest.vapi | diff -wu $(srcdir)/girtest.vapi-expected - || exit 1; \
	tail -n +3 GirTest-1.0.gir | diff -wu $(srcdir)/GirTest-1.0.gir-expected - || exit 1;
if HAVE_G_IR_COMPILER
	$(G_IR_COMPILER) -o GirTest-1.0.typelib GirTest-1.0.gir;
endif
	rm -f GirTest-1.0.gir GirTest-1.0.typelib girtest.vapi girtest.c

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
	GirTest-1.0.typelib \
	$(NULL)
