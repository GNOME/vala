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

.PHONY: test
test:
	cd tests && $(MAKE) $(AM_MAKEFLAGS) check

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

