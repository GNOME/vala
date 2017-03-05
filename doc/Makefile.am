NULL =

SUBDIRS = \
	manual \
	$(NULL)

dist_man_MANS = \
	valac.1 \
	vala-gen-introspect.1 \
	vapigen.1 \
	$(NULL)

EXTRA_DIST = \
	valac.h2m \
	vala-gen-introspect.h2m \
	vapigen.h2m \
	$(NULL)

if HAVE_HELP2MAN
manpages: valac.1 vala-gen-introspect.1 vapigen.1
	@rm $^
	$(MAKE) $(AM_MAKEFLAGS) $^

valac.1:
	$(HELP2MAN) $(top_builddir)/compiler/valac \
		--include $(srcdir)/valac.h2m \
		--libtool --no-info \
		--output=$@
vala-gen-introspect.1:
	$(HELP2MAN) $(top_builddir)/gobject-introspection/gen-introspect \
		--include $(srcdir)/vala-gen-introspect.h2m \
		--version-string=$(PACKAGE_VERSION) \
		--libtool --no-info \
		--output=$@
vapigen.1:
	$(HELP2MAN) $(top_builddir)/vapigen/vapigen \
		--include $(srcdir)/vapigen.h2m \
		--libtool --no-info \
		--output=$@
endif

if ENABLE_UNVERSIONED
install-data-hook:
	cd $(DESTDIR)$(man1dir) && $(LN_S) -f valac@PACKAGE_SUFFIX@.1 valac.1
	cd $(DESTDIR)$(man1dir) && $(LN_S) -f vala-gen-introspect@PACKAGE_SUFFIX@.1 vala-gen-introspect.1
	cd $(DESTDIR)$(man1dir) && $(LN_S) -f vapigen@PACKAGE_SUFFIX@.1 vapigen.1
endif
