NULL =

SUBDIRS = \
	manual \
	$(NULL)

dist_man_MANS = \
	valac.1 \
	vala-gen-introspect.1 \
	vapigen.1 \
	$(NULL)

if ENABLE_VALADOC
dist_man_MANS += \
	valadoc.1 \
	$(NULL)
endif

EXTRA_DIST = \
	valac.h2m \
	valadoc.h2m \
	vala-gen-introspect.h2m \
	vapigen.h2m \
	$(NULL)

if HAVE_HELP2MAN
if ENABLE_VALADOC
manpages: valac.1 valadoc.1 vala-gen-introspect.1 vapigen.1
else
manpages: valac.1 vala-gen-introspect.1 vapigen.1
endif
	@rm $^
	$(MAKE) $(AM_MAKEFLAGS) $^

valac.1:
	$(HELP2MAN) $(top_builddir)/compiler/valac \
		--include $(srcdir)/valac.h2m \
		--libtool --no-info \
		--output=$@
if ENABLE_VALADOC
valadoc.1:
	$(HELP2MAN) $(top_builddir)/valadoc/valadoc \
		--include $(srcdir)/valadoc.h2m \
		--libtool --no-info \
		--output=$@
endif
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
if ENABLE_VALADOC
	cd $(DESTDIR)$(man1dir) && $(LN_S) -f valadoc@PACKAGE_SUFFIX@.1 valadoc.1
endif
	cd $(DESTDIR)$(man1dir) && $(LN_S) -f vala-gen-introspect@PACKAGE_SUFFIX@.1 vala-gen-introspect.1
	cd $(DESTDIR)$(man1dir) && $(LN_S) -f vapigen@PACKAGE_SUFFIX@.1 vapigen.1
endif


if ENABLE_VALADOC
COMMON_VALADOCFLAGS = \
	--force \
	--verbose \
	--private \
	--internal \
	--use-svg-images \
	--vapidir=$(top_builddir)/vapi \
	--pkg config \
	--pkg gmodule-2.0 \
	--directory=internal-apis/ \
	--doclet=$(top_builddir)/valadoc/doclets/html/.libs \
	--doclet-arg "--no-browsable-check" \
	--basedir=internal-apis/ \
	$(NULL)

if HAVE_CGRAPH
COMMON_VALADOCFLAGS += -D WITH_CGRAPH
endif

gee_VALASOURCES = $(top_srcdir)/gee/*.vala
internal-apis/gee: $(gee_VALASOURCES)
	$(AM_V_GEN)$(top_builddir)/valadoc/valadoc \
		$(COMMON_VALADOCFLAGS) \
		--package-name gee \
		--package-version $(PACKAGE_VERSION) \
		--deps \
		$(filter %.vala,$^)
	@touch $@

vala_VALASOURCES = $(top_srcdir)/vala/*.vala
internal-apis/vala: $(vala_VALASOURCES) internal-apis/gee
	$(AM_V_GEN)$(top_builddir)/valadoc/valadoc \
		$(COMMON_VALADOCFLAGS) \
		--package-name vala \
		--package-version $(PACKAGE_VERSION) \
		--vapidir=$(top_builddir)/gee --pkg gee \
		--deps \
		$(filter %.vala,$^)
	@touch $@

ccode_VALASOURCES = $(top_srcdir)/ccode/*.vala
internal-apis/ccode: $(ccode_VALASOURCES) internal-apis/gee
	$(AM_V_GEN)$(top_builddir)/valadoc/valadoc \
		$(COMMON_VALADOCFLAGS) \
		--package-name ccode \
		--package-version $(PACKAGE_VERSION) \
		--vapidir=$(top_builddir)/gee --pkg gee \
		--vapidir=$(top_builddir)/vala --pkg vala \
		--deps \
		$(filter %.vala,$^)
	@touch $@

codegen_VALASOURCES = $(top_srcdir)/codegen/*.vala
internal-apis/codegen: $(codegen_VALASOURCES) internal-apis/vala internal-apis/ccode
	$(AM_V_GEN)$(top_builddir)/valadoc/valadoc\
		$(COMMON_VALADOCFLAGS) \
		--package-name codegen \
		--package-version $(PACKAGE_VERSION) \
		--vapidir=$(top_builddir)/gee --pkg gee \
		--vapidir=$(top_builddir)/vala --pkg vala \
		--vapidir=$(top_builddir)/ccode --pkg ccode \
		--deps \
		$(filter %.vala,$^)
	@touch $@

valadoc_VALASOURCES = $(top_srcdir)/libvaladoc/*.vala $(top_srcdir)/libvaladoc/*/*.vala
internal-apis/valadoc: $(valadoc_VALASOURCES) internal-apis/codegen
	$(AM_V_GEN)$(top_builddir)/valadoc/valadoc\
		$(COMMON_VALADOCFLAGS) \
		--package-name valadoc \
		--package-version $(PACKAGE_VERSION) \
		--vapidir=$(top_srcdir)/vapi --pkg libgvc \
		--vapidir=$(top_builddir)/gee --pkg gee \
		--vapidir=$(top_builddir)/vala --pkg vala \
		--vapidir=$(top_builddir)/ccode --pkg ccode \
		--vapidir=$(top_builddir)/codegen --pkg codegen \
		--deps \
		$(filter %.vala,$^)
	@touch $@

internal-api-docs: internal-apis/gee internal-apis/vala internal-apis/ccode internal-apis/codegen internal-apis/valadoc
endif

clean-local:
	rm -rf $(builddir)/internal-apis
