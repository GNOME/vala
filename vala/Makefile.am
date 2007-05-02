NULL =

if ENABLE_VAPIGEN
VAPIGEN_SUBDIRS = \
	gobject-introspection \
	vapigen \
	$(NULL)
endif

SUBDIRS = \
	ccode \
	vala \
	compiler \
	vapi \
	tests \
	doc \
	$(VAPIGEN_SUBDIRS)
	$(NULL)

DIST_SUBDIRS = \
	ccode \
	vala \
	compiler \
	vapi \
	tests \
	doc \
	gobject-introspection \
	vapigen \
	$(NULL)

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = vala-1.0.pc

EXTRA_DIST = \
	MAINTAINERS \
	vala-1.0.pc.in \
	$(NULL)

