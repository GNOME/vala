NULL =
GIRDIR = $$($(PKG_CONFIG) gobject-introspection-1.0 --variable=girdir)

check-girwriter: $(top_builddir)/valadoc/valadoc
	rm -rf $(builddir)/girtest;
	G_DEBUG=fatal-warnings $(top_builddir)/valadoc/valadoc \
		--vapidir $(top_srcdir)/vapi \
		--directory $(builddir)/girtest \
		--doclet=$(top_builddir)/valadoc/doclets/html/.libs \
		--pkg gio-2.0 \
		--gir $(builddir)/GirTest-1.0.gir \
		$(srcdir)/girtest.vala; \
	tail -n +3 GirTest-1.0.gir | diff -wu $(srcdir)/GirTest-1.0.gir-expected - || exit 1;
if HAVE_G_IR_COMPILER
	$(G_IR_COMPILER) -o GirTest-1.0.typelib GirTest-1.0.gir;
endif
if HAVE_JING
	$(JING) -c -e UTF-8 $(GIRDIR)/gir-1.2.rnc GirTest-1.0.gir || echo "Ignoring above error(s)";
endif
	rm -f GirTest-1.0.gir GirTest-1.0.typelib girtest.vapi girtest.c;
	rm -rf $(builddir)/girtest;

check: check-girwriter

EXTRA_DIST = \
	girtest.vala \
	GirTest-1.0.gir-expected \
	$(NULL)

CLEANFILES = \
	girtest.c \
	girtest.vapi \
	GirTest-1.0.gir \
	GirTest-1.0.typelib \
	$(NULL)
