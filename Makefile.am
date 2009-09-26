ACLOCAL_AMFLAGS = -I m4
NULL =

if ENABLE_VAPIGEN
VAPIGEN_SUBDIRS = \
	gobject-introspection \
	vapigen \
	$(NULL)
endif

SUBDIRS = \
	gee \
	ccode \
	vala \
	codegen \
	compiler \
	vapi \
	tests \
	doc \
	$(VAPIGEN_SUBDIRS) \
	$(NULL)

DIST_SUBDIRS = \
	gee \
	ccode \
	vala \
	codegen \
	compiler \
	vapi \
	tests \
	doc \
	gobject-introspection \
	vapigen \
	$(NULL)

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = vala-1.0.pc

.PHONY: bootstrap
bootstrap: all
	find $(top_srcdir) -name "*.vala.stamp" | xargs rm -f
	$(MAKE) $(AM_MAKEFLAGS) all VALAC=$(abs_top_builddir)/compiler/valac

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
	rm -r $(top_builddir)/coverage
	$(mkdir_p) $(top_builddir)/coverage
	genhtml --title "@PACKAGE_STRING@" --output-directory $(top_builddir)/coverage $(top_builddir)/lcov.info
#endif

dist-hook: gen-ChangeLog

gen_start_date = 2009-02-25
.PHONY: gen-ChangeLog
gen-ChangeLog:
	if test -d .git; then						\
	  $(top_srcdir)/gitlog-to-changelog				\
	    --since=$(gen_start_date) > $(distdir)/cl-t;		\
	  rm -f $(distdir)/ChangeLog;					\
	  mv $(distdir)/cl-t $(distdir)/ChangeLog;			\
	fi

EXTRA_DIST = \
	ChangeLog.pre-0-4 \
	ChangeLog.pre-0-5-7 \
	gitlog-to-changelog \
	MAINTAINERS \
	vala-1.0.pc.in \
	$(NULL)

