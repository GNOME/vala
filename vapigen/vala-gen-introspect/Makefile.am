NULL =

bin_SCRIPTS = \
	vala-gen-introspect \
	$(NULL)

EXTRA_DIST = \
	vala-gen-introspect.in
	$(NULL)

if ENABLE_UNVERSIONED
install-exec-hook:
	cd $(DESTDIR)$(bindir) && $(LN_S) -f vala-gen-introspect@PACKAGE_SUFFIX@$(EXEEXT) vala-gen-introspect$(EXEEXT)
endif
