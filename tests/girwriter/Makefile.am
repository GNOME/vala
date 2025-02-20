NULL =
GIRDIR = $$($(PKG_CONFIG) gobject-introspection-1.0 --variable=girdir)

check-girwriter: $(top_builddir)/compiler/valac
	G_DEBUG=fatal-warnings $(top_builddir)/compiler/valac \
		-C \
		--disable-version-header \
		--vapidir $(top_srcdir)/vapi \
		--pkg gio-2.0 \
		--gir $(builddir)/GirTest-1.0.gir \
		--library girtest \
		--shared-library girtest \
		$(srcdir)/girtest.vala; \
	tail -n +3 girtest.vapi | diff -wu $(srcdir)/girtest.vapi-expected - || exit 1; \
	tail -n +3 GirTest-1.0.gir | diff -wu $(srcdir)/GirTest-1.0.gir-expected - || exit 1;
if HAVE_G_IR_COMPILER
	$(G_IR_COMPILER) -o GirTest-1.0.typelib GirTest-1.0.gir;
endif
if HAVE_JING
	$(JING) -c -e UTF-8 $(GIRDIR)/gir-1.2.rnc GirTest-1.0.gir || echo "Ignoring above error(s)";
endif
	rm -f girtest.vapi girtest.c;
	G_DEBUG=fatal-warnings $(top_builddir)/vapigen/vapigen \
		--vapidir $(top_srcdir)/vapi \
		--pkg gio-2.0 \
		--library girtest \
		--metadatadir $(srcdir) \
		GirTest-1.0.gir; \
	tail -n +3 girtest.vapi | diff -wu $(srcdir)/girtest.vapigen-expected - || exit 1;
	rm -f GirTest-1.0.gir GirTest-1.0.typelib girtest.vapi;

check: check-girwriter

EXTRA_DIST = \
	girtest.vala \
	girtest.vapi-expected \
	girtest.vapigen-expected \
	GirTest-1.0.gir-expected \
	GirTest-1.0.metadata \
	$(NULL)

CLEANFILES = \
	girtest.c \
	girtest.vapi \
	GirTest-1.0.gir \
	GirTest-1.0.typelib \
	$(NULL)
