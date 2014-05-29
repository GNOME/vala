NULL =

SUBDIRS = \
	vala \
	$(NULL)

dist_man_MANS = \
	valac.1 \
	vala-gen-introspect.1 \
	vapigen.1 \
	$(NULL)

if ENABLE_UNVERSIONED
install-data-hook:
	cd $(DESTDIR)$(man1dir) && $(LN_S) -f valac@PACKAGE_SUFFIX@.1 valac.1
	cd $(DESTDIR)$(man1dir) && $(LN_S) -f vala-gen-introspect@PACKAGE_SUFFIX@.1 vala-gen-introspect.1
	cd $(DESTDIR)$(man1dir) && $(LN_S) -f vapigen@PACKAGE_SUFFIX@.1 vapigen.1
endif
