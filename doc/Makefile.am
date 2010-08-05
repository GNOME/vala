NULL =

SUBDIRS = \
	vala \
	$(NULL)

if ENABLE_VAPIGEN
VAPIGEN_MANS = \
	vala-gen-introspect.1 \
	vapigen.1 \
	$(NULL)
endif

man_MANS = \
	valac.1 \
	$(VAPIGEN_MANS) \
	$(NULL)

EXTRA_DIST = \
	valac.1 \
	vala-gen-introspect.1 \
	vapigen.1 \
	$(NULL)

if ENABLE_UNVERSIONED
install-data-hook:
	cd $(DESTDIR)$(man1dir) && $(LN_S) -f valac@PACKAGE_SUFFIX@.1 valac.1
if ENABLE_VAPIGEN
	cd $(DESTDIR)$(man1dir) && $(LN_S) -f vala-gen-introspect@PACKAGE_SUFFIX@.1 vala-gen-introspect.1
	cd $(DESTDIR)$(man1dir) && $(LN_S) -f vapigen@PACKAGE_SUFFIX@.1 vapigen.1
endif
endif
