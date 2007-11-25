NULL =

if ENABLE_VAPIGEN
VAPIGEN_SUBDIRS = \
	gobject-introspection \
	vapigen \
	$(NULL)
endif

if ENABLE_GEN_PROJECT
GEN_PROJECT_SUBDIRS = \
	gen-project \
	$(NULL)
endif

SUBDIRS = \
	gee \
	ccode \
	vala \
	gobject \
	compiler \
	vapi \
	tests \
	doc \
	$(VAPIGEN_SUBDIRS) \
	$(GEN_PROJECT_SUBDIRS) \
	$(NULL)

DIST_SUBDIRS = \
	gee \
	ccode \
	vala \
	gobject \
	compiler \
	vapi \
	tests \
	doc \
	gobject-introspection \
	vapigen \
	gen-project \
	$(NULL)

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = vala-1.0.pc

EXTRA_DIST = \
	MAINTAINERS \
	vala-1.0.pc.in \
	$(NULL)

