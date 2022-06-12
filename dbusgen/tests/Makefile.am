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
	rm -f test-codegen.xml.vala test-codegen.xml.c; \
	$(top_builddir)/dbusgen/valadbusgen \
		--vapidir $(top_srcdir)/vapi \
		runtime-test-dbus.xml; \
	$(top_builddir)/compiler/valac \
		--vapidir $(top_srcdir)/vapi \
		--pkg gio-2.0 \
		runtime-test-server.vala \
		-X -O3 -X -g3 \
		runtime-test-dbus.xml.vala 2>/dev/null; \
	$(top_builddir)/compiler/valac \
		--vapidir $(top_srcdir)/vapi \
		--pkg gio-2.0 \
		runtime-test.vala \
		runtime-test-dbus.xml.vala 2>/dev/null; \
	./runtime-test-server & \
	./runtime-test; \
	rm -f runtime-test runtime-test-dbus.xml.vala runtime-test-server


check: check-dbusgen

EXTRA_DIST = \
	test-codegen.xml \
	test-codegen.xml.vala-expected \
	runtime-test.vala \
	runtime-test-dbus.xml \
	runtime-test-server.vala \
	$(NULL)

CLEANFILES = \
	test-codegen.xml.c \
	test-codegen.xml.vala \
	runtime-test \
	runtime-test-server \
	runtime-test-dbus.xml.vala \
	$(NULL)
