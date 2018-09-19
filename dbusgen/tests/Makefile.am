NULL =

check-dbusgen: $(top_builddir)/dbusgen/valadbusgen
	$(top_builddir)/dbusgen/valadbusgen \
		--vapidir $(top_srcdir)/vapi \
		test-codegen.xml; \
	$(top_builddir)/compiler/valac \
		-C \
		--vapidir $(top_srcdir)/vapi \
		--pkg gio-2.0 \
		test-codegen.xml.vala; \
	tail -n +3 test-codegen.xml.vala | diff -wu $(srcdir)/test-codegen.xml.vala-expected - || exit 1; \
	rm -f test-codegen.xml.vala test-codegen.xml.c

check: check-dbusgen

EXTRA_DIST = \
	test-codegen.xml \
	test-codegen.xml.vala-expected \
	$(NULL)

CLEANFILES = \
	test-codegen.xml.c \
	test-codegen.xml.vala \
	$(NULL)
