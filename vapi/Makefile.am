NULL =

vapidir = $(pkgdatadir)/vapi

vala-1.0.vapi: ../ccode/ccode.vapi ../vala/vala.vapi ../gobject/gobject.vapi
	cat $^ > $@

gee-1.0.vapi: ../gee/gee.vapi
	cat $^ > $@

dist_vapi_DATA = \
	atk.vapi \
	cairo.vapi \
	curses.vapi \
	dbus-glib-1.vapi \
	enchant.vapi \
	gconf-2.0.vapi \
	glib-2.0.vapi \
	gdk-2.0.deps \
	gdk-2.0.vapi \
	gio-2.0.vapi \
	gnome-desktop-2.0.vapi \
	gnome-vfs-2.0.vapi \
	gstreamer-0.10.vapi \
	gtk+-2.0.deps \
	gtk+-2.0.vapi \
	gtkmozembed.deps \
	gtkmozembed.vapi \
	gtksourceview-2.0.deps \
	gtksourceview-2.0.vapi \
	hal.deps \
	hal.vapi \
	hildon-1.deps \
	hildon-1.vapi \
	libglade-2.0.deps \
	libglade-2.0.vapi \
	libgnome-2.0.vapi \
	libgnomeui-2.0.deps \
	libgnomeui-2.0.vapi \
	libnotify.deps \
	libnotify.vapi \
	libpanelapplet-2.0.deps \
	libpanelapplet-2.0.vapi \
	libwnck-1.0.vapi \
	libsoup-2.2.vapi \
	libxml-2.0.vapi \
	pango.deps \
	pango.vapi \
	poppler-glib.deps \
	poppler-glib.vapi \
	sqlite3.vapi \
	vala-1.0.vapi \
	vte.deps \
	vte.vapi \
	zlib.vapi \
	$(NULL)

dist_noinst_DATA = \
	config.vapi \
	gee-1.0.vapi \
	$(NULL)
