ACLOCAL_AMFLAGS = --install -I m4 ${ACLOCAL_FLAGS}

NULL =

SUBDIRS = \
	gee \
	vala \
	ccode \
	codegen \
	compiler \
	vapi \
	tests \
	doc \
	gobject-introspection \
	vapigen \
	$(NULL)

if ENABLE_VALADOC
SUBDIRS += \
	libvaladoc \
	valadoc \
	$(NULL)
endif

DISTCHECK_CONFIGURE_FLAGS = \
	--enable-valadoc \
	--enable-unversioned \
	$(NULL)

if ENABLE_UNVERSIONED
aclocaldir = $(datadir)/aclocal
aclocal_DATA = vala.m4
endif

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = libvala@PACKAGE_SUFFIX@.pc

libvala@PACKAGE_SUFFIX@.pc: libvala.pc
	cp $< $@

.PHONY: bootstrap
bootstrap: all
	find $(top_srcdir) -name "*.vala.stamp" | xargs rm -f
	$(MAKE) $(AM_MAKEFLAGS) all VALAC=$(abs_top_builddir)/compiler/valac$(EXEEXT) V=$V \
		VALAFLAGS="$(VALAFLAGS) --hide-internal --abi-stability"

.PHONY: test
test:
	cd tests && $(MAKE) $(AM_MAKEFLAGS) check

#if ENABLE_COVERAGE
.PHONY: coverage coverage-report
coverage:
	find $(top_srcdir) -name "*.gcda" | xargs rm -f
	$(MAKE) $(AM_MAKEFLAGS) bootstrap
	$(MAKE) $(AM_MAKEFLAGS) test

coverage-report: coverage
	lcov --directory $(top_srcdir) --capture --output-file $(top_builddir)/lcov.info
	lcov --directory $(top_srcdir) --output-file $(top_builddir)/lcov.info --remove $(top_builddir)/lcov.info "*.c" "*.h" "*.vapi"
	rm -rf $(top_builddir)/coverage
	$(mkdir_p) $(top_builddir)/coverage
	genhtml --title "@PACKAGE_STRING@" --output-directory $(top_builddir)/coverage $(top_builddir)/lcov.info
#endif

BUILT_SOURCES = $(top_srcdir)/.version
$(top_srcdir)/.version: gen-version
	@true
.PHONY: gen-version
gen-version:
	@V=`$(top_srcdir)/build-aux/git-version-gen --prefix '' $(top_srcdir)/.tarball-version` &&	\
	if [ -e $(top_srcdir)/.version ] && [ "x`cat $(top_srcdir)/.version`" = "x$$V" ]; then		\
	  true;												\
	else												\
	  echo "$$V" > $(top_srcdir)/.version;								\
	fi
dist-hook: gen-ChangeLog
	echo $(VERSION) > $(distdir)/.tarball-version

gen_start_date = 2009-02-25
.PHONY: gen-ChangeLog
gen-ChangeLog:
	if test -d .git; then						\
	  $(top_srcdir)/build-aux/gitlog-to-changelog			\
	    --since=$(gen_start_date) > $(distdir)/cl-t;		\
	  rm -f $(distdir)/ChangeLog;					\
	  mv $(distdir)/cl-t $(distdir)/ChangeLog;			\
	fi

CLEANFILES = \
	libvala@PACKAGE_SUFFIX@.pc \
	$(NULL)

EXTRA_DIST = \
	ChangeLog.pre-0-4 \
	ChangeLog.pre-0-5-7 \
	README.md \
	libvala.pc.in \
	vala.m4 \
	.version \
	build-aux/git-version-gen \
	build-aux/gitlog-to-changelog \
	build-aux/testrunner.sh \
	$(NULL)
