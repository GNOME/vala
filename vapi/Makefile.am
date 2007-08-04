NULL =

vapidir = $(pkgdatadir)/vapi

vala-1.0.vala: ../ccode/ccode.vala ../vala/vala.vala ../gobject/gobject.vala
	cat $^ > $@

dist_vapi_DATA = \
	atk.vala \
	cairo.vala \
	dbus-glib-1.vala \
	glib-2.0.vala \
	gdk-2.0.deps \
	gdk-2.0.vala \
	gio-standalone.vala \
	gtk+-2.0.deps \
	gtk+-2.0.vala \
	gtkmozembed.vala \
	hal.deps \
	hal.vala \
	libxml-2.0.vala \
	math.vala \
	pango.deps \
	pango.vala \
	vala-1.0.vala \
	vte.deps \
	vte.vala \
	zlib.vala \
	$(NULL)

dist_noinst_DATA = \
	config.vala \
	$(NULL)
