NULL =

vapidir = $(pkgdatadir)/vapi

vala-1.0.vala: ../ccode/ccode.vala ../vala/vala.vala ../gobject/gobject.vala
	cat $^ > $@

gee-1.0.vala: ../gee/gee.vala
	cat $^ > $@

dist_vapi_DATA = \
	atk.vala \
	cairo.vala \
	clutter-0.3.vala \
	clutter-0.3.deps \
	curses.vala \
	dbus-glib-1.vala \
	enchant.vala \
	glib-2.0.vala \
	gdk-2.0.deps \
	gdk-2.0.vala \
	gio-standalone.vala \
	gnome-desktop-2.0.vala \
	gstreamer-0.10.vala \
	gtk+-2.0.deps \
	gtk+-2.0.vala \
	gtkmozembed.deps \
	gtkmozembed.vala \
	gtksourceview-2.0.deps \
	gtksourceview-2.0.vala \
	hal.deps \
	hal.vala \
	hildon-1.deps \
	hildon-1.vala \
	libglade-2.0.deps \
	libglade-2.0.vala \
	libwnck-1.0.vala \
	libsoup-2.2.vala \
	libxml-2.0.vala \
	math.vala \
	pango.deps \
	pango.vala \
	sqlite3.vala \
	vala-1.0.vala \
	vte.deps \
	vte.vala \
	zlib.vala \
	$(NULL)

dist_noinst_DATA = \
	config.vala \
	gee-1.0.vala \
	$(NULL)
