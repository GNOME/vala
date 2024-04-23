NULL =

check: $(top_builddir)/compiler/valac
	echo "void main () {}" > test.vala; \
	for vapi in `ls *.vapi | sed -e "s/\.vapi//g"`; do \
		echo "Checking $$vapi..."; \
		$(top_builddir)/compiler/valac -C --enable-deprecated --pkg=$$vapi --vapidir=. test.vala || exit 1; \
	done; \
	rm -f test.vala test.c

vapidir = $(pkgdatadir)/vapi

dist_vapi_DATA = \
	alsa.vapi \
	alsa.deps \
	atk.deps \
	atk.vapi \
	atspi-2.vapi \
	atspi-2.deps \
	avahi-client.vapi \
	avahi-gobject.deps \
	avahi-gobject.vapi \
	bzlib.vapi \
	cairo.vapi \
	cairo-gobject.deps \
	cairo-gobject.vapi \
	cairo-xcb.deps \
	cairo-xcb.vapi \
	ccss-1.vapi \
	clutter-1.0.deps \
	clutter-1.0.vapi \
	clutter-gdk-1.0.deps \
	clutter-gdk-1.0.vapi \
	clutter-gst-2.0.deps \
	clutter-gst-2.0.vapi \
	clutter-gst-3.0.deps \
	clutter-gst-3.0.vapi \
	clutter-gtk-0.10.deps \
	clutter-gtk-0.10.vapi \
	clutter-gtk-1.0.deps \
	clutter-gtk-1.0.vapi \
	clutter-x11-1.0.deps \
	clutter-x11-1.0.vapi \
	cogl-1.0.vapi \
	cogl-1.0.deps \
	cogl-pango-1.0.vapi \
	cogl-pango-1.0.deps \
	curses.vapi \
	dbus-glib-1.vapi \
	enchant.vapi \
	enchant-2.vapi \
	freetype2.vapi \
	fuse.deps \
	fuse.vapi \
	gconf-2.0.vapi \
	geocode-glib-1.0.deps \
	geocode-glib-1.0.vapi \
	geocode-glib-2.0.deps \
	geocode-glib-2.0.vapi \
	glib-2.0.vapi \
	gdesktopenums-3.0.vapi \
	gdk-2.0.deps \
	gdk-2.0.vapi \
	gdk-3.0.deps \
	gdk-3.0.vapi \
	gdk-pixbuf-2.0.deps \
	gdk-pixbuf-2.0.vapi \
	gdk-x11-2.0.deps \
	gdk-x11-2.0.vapi \
	gdk-x11-3.0.deps \
	gdk-x11-3.0.vapi \
	gdl-1.0.deps \
	gdl-1.0.vapi \
	gdl-3.0.deps \
	gdl-3.0.vapi \
	gio-2.0.deps \
	gio-2.0.vapi \
	gio-unix-2.0.deps \
	gio-unix-2.0.vapi \
	gio-windows-2.0.deps \
	gio-windows-2.0.vapi \
	gmodule-2.0.deps \
	gmodule-2.0.vapi \
	gnet-2.0.deps \
	gnet-2.0.vapi \
	gnome-bg-4.deps \
	gnome-bg-4.vapi \
	gnome-desktop-2.0.deps \
	gnome-desktop-2.0.vapi \
	gnome-desktop-3.0.deps \
	gnome-desktop-3.0.vapi \
	gnome-desktop-4.deps \
	gnome-desktop-4.vapi \
	gnome-rr-4.deps \
	gnome-rr-4.vapi \
	gnome-vfs-2.0.vapi \
	gnu.deps \
	gnu.vapi \
	gnutls.vapi \
	gobject-2.0.deps \
	gobject-2.0.vapi \
	gobject-introspection-1.0.deps \
	gobject-introspection-1.0.vapi \
	goocanvas.deps \
	goocanvas.vapi \
	goocanvas-2.0.deps \
	goocanvas-2.0.vapi \
	graphene-1.0.deps \
	graphene-1.0.vapi \
	graphene-gobject-1.0.deps \
	graphene-gobject-1.0.vapi \
	gsl.vapi \
	gstreamer-1.0.deps \
	gstreamer-1.0.vapi \
	gstreamer-allocators-1.0.vapi \
	gstreamer-allocators-1.0.deps \
	gstreamer-app-1.0.vapi \
	gstreamer-app-1.0.deps \
	gstreamer-audio-1.0.vapi \
	gstreamer-audio-1.0.deps \
	gstreamer-bad-allocators-1.0.deps \
	gstreamer-bad-allocators-1.0.vapi \
	gstreamer-base-1.0.vapi \
	gstreamer-base-1.0.deps \
	gstreamer-check-1.0.vapi \
	gstreamer-check-1.0.deps \
	gstreamer-controller-1.0.vapi \
	gstreamer-controller-1.0.deps \
	gstreamer-fft-1.0.vapi \
	gstreamer-fft-1.0.deps \
	gstreamer-net-1.0.vapi \
	gstreamer-net-1.0.deps \
	gstreamer-pbutils-1.0.vapi \
	gstreamer-pbutils-1.0.deps \
	gstreamer-play-1.0.vapi \
	gstreamer-play-1.0.deps \
	gstreamer-player-1.0.vapi \
	gstreamer-player-1.0.deps \
	gstreamer-riff-1.0.deps \
	gstreamer-riff-1.0.vapi \
	gstreamer-rtp-1.0.vapi \
	gstreamer-rtp-1.0.deps \
	gstreamer-rtsp-1.0.vapi \
	gstreamer-rtsp-1.0.deps \
	gstreamer-rtsp-server-1.0.vapi \
	gstreamer-rtsp-server-1.0.deps \
	gstreamer-sdp-1.0.vapi \
	gstreamer-sdp-1.0.deps \
	gstreamer-tag-1.0.vapi \
	gstreamer-tag-1.0.deps \
	gstreamer-video-1.0.vapi \
	gstreamer-video-1.0.deps \
	gstreamer-webrtc-1.0.vapi \
	gstreamer-webrtc-1.0.deps \
	gst-editing-services-1.0.vapi \
	gst-editing-services-1.0.deps \
	gtk+-2.0.deps \
	gtk+-2.0.vapi \
	gtk+-3.0.deps \
	gtk+-3.0.vapi \
	gtk+-unix-print-2.0.deps \
	gtk+-unix-print-2.0.vapi \
	gtk+-unix-print-3.0.deps \
	gtk+-unix-print-3.0.vapi \
	gtk4.deps \
	gtk4.vapi \
	gtk4-unix-print.deps \
	gtk4-unix-print.vapi \
	gtk4-wayland.deps \
	gtk4-wayland.vapi \
	gtk4-x11.deps \
	gtk4-x11.vapi \
	gtkmozembed.deps \
	gtkmozembed.vapi \
	gtksourceview-2.0.deps \
	gtksourceview-2.0.vapi \
	gudev-1.0.deps \
	gudev-1.0.vapi \
	hal.deps \
	hal.vapi \
	harfbuzz-gobject.deps \
	harfbuzz-gobject.vapi \
	javascriptcoregtk-4.0.vapi \
	javascriptcoregtk-4.1.vapi \
	javascriptcoregtk-6.0.vapi \
	json-glib-1.0.deps \
	json-glib-1.0.vapi \
	libarchive.deps \
	libarchive.vapi \
	libbonoboui-2.0.vapi \
	libdaemon.vapi \
	libepc-1.0.vapi \
	libesmtp.vapi \
	libftdi.deps \
	libftdi.vapi \
	libgeoclue-2.0.vapi \
	libgeoclue-2.0.deps \
	libglade-2.0.deps \
	libglade-2.0.vapi \
	libgnome-2.0.vapi \
	libgnome-menu.vapi \
	libgnome-menu-3.0.deps \
	libgnome-menu-3.0.vapi \
	libgnomeui-2.0.deps \
	libgnomeui-2.0.vapi \
	libgrss.deps \
	libgrss.vapi \
	libgsf-1.deps \
	libgsf-1.vapi \
	libgvc.vapi \
	libmagic.vapi \
	libnl-1.vapi \
	libnl-2.0.deps \
	libnl-2.0.vapi \
	libnl-3.0.deps \
	libnl-3.0.vapi \
	libnotify.deps \
	libnotify.vapi \
	liboobs-1.vapi \
	libosso.vapi \
	libpanelapplet-2.0.deps \
	libpanelapplet-2.0.vapi \
	libpeas-1.0.deps \
	libpeas-1.0.vapi \
	libpeas-gtk-1.0.deps \
	libpeas-gtk-1.0.vapi \
	libpq.vapi \
	libsexy.deps \
	libsexy.vapi \
	libsoup-2.4.deps \
	libsoup-2.4.vapi \
	libsoup-3.0.deps \
	libsoup-3.0.vapi \
	libunwind-generic.vapi \
	libusb.vapi \
	libusb-1.0.deps \
	libusb-1.0.vapi \
	libwnck-1.0.deps \
	libwnck-1.0.vapi \
	libwnck-3.0.deps \
	libwnck-3.0.vapi \
	libxml-2.0.vapi \
	linux.deps \
	linux.vapi \
	loudmouth-1.0.vapi \
	lua.vapi \
	mysql.vapi \
	orc-0.4.vapi \
	packagekit-glib2.deps \
	packagekit-glib2.vapi \
	pango.deps \
	pango.vapi \
	pangocairo.deps \
	pangocairo.vapi \
	pixman-1.vapi \
	polkit-agent-1.deps \
	polkit-agent-1.vapi \
	polkit-gobject-1.deps \
	polkit-gobject-1.vapi \
	poppler-glib.deps \
	poppler-glib.vapi \
	posix.vapi \
	purple.deps \
	purple.vapi \
	raptor.vapi \
	rasqal.vapi \
	rasqal.deps \
	readline.vapi \
	rest-0.7.deps \
	rest-0.7.vapi \
	rest-extras-0.7.deps \
	rest-extras-0.7.vapi \
	rest-1.0.deps \
	rest-1.0.vapi \
	rest-extras-1.0.deps \
	rest-extras-1.0.vapi \
	sdl2-android.deps \
	sdl2-android.vapi \
	SDL2_gfx.deps \
	SDL2_gfx.vapi \
	SDL2_image.deps \
	SDL2_image.vapi \
	sdl2-ios.deps \
	sdl2-ios.vapi \
	SDL2_mixer.deps \
	SDL2_mixer.vapi \
	SDL2_net.deps \
	SDL2_net.vapi \
	SDL2_ttf.deps \
	SDL2_ttf.vapi \
	sdl2.vapi \
	sdl2-windows.deps \
	sdl2-windows.vapi \
	sdl2-winrt.deps \
	sdl2-winrt.vapi \
	sqlite3.vapi \
	taglib_c.vapi \
	tiff.vapi \
	tokyocabinet.vapi \
	udisks2.deps \
	udisks2.vapi \
	unique-1.0.deps \
	unique-1.0.vapi \
	v4l2.vapi \
	wayland-client.vapi \
	webkit2gtk-4.0.vapi \
	webkit2gtk-4.0.deps \
	webkit2gtk-4.1.vapi \
	webkit2gtk-4.1.deps \
	webkit2gtk-web-extension-4.0.vapi \
	webkit2gtk-web-extension-4.0.deps \
	webkit2gtk-web-extension-4.1.vapi \
	webkit2gtk-web-extension-4.1.deps \
	webkitgtk-6.0.vapi \
	webkitgtk-6.0.deps \
	webkitgtk-web-extension-6.0.vapi \
	webkitgtk-web-extension-6.0.deps \
	webkitgtk-web-process-extension-6.0.vapi \
	webkitgtk-web-process-extension-6.0.deps \
	x11.vapi \
	xcb.vapi \
	xcb-icccm.vapi \
	xcb-icccm.deps \
	xtst.vapi \
	xtst.deps \
	zlib.vapi \
	$(NULL)

dist_noinst_DATA = \
	config.vapi \
	$(NULL)

GIDL_BINDINGS = \
	clutter-gtk-0.10 \
	cogl-1.0 \
	gconf-2.0 \
	gdk-2.0 \
	gdk-x11-2.0 \
	gdl-1.0 \
	gio-unix-2.0 \
	gnome-desktop-2.0 \
	gnome-vfs-2.0 \
	goocanvas \
	gtk+-2.0 \
	gtk+-unix-print-2.0 \
	gtk+-unix-print-3.0 \
	gtksourceview-2.0 \
	libepc-1.0 \
	libglade-2.0 \
	libgnome-2.0 \
	libgnome-menu \
	libgnomeui-2.0 \
	liboobs-1 \
	libsexy \
	libwnck-1.0 \
	loudmouth-1.0 \
	purple \
	unique-1.0 \
	$(NULL)

GSTREAMER_1_0_BINDINGS = \
	gstreamer-1.0 \
	gstreamer-bad-allocators-1.0 \
	gstreamer-base-1.0 \
	gstreamer-check-1.0 \
	gstreamer-controller-1.0 \
	gstreamer-net-1.0 \
	gstreamer-allocators-1.0 \
	gstreamer-app-1.0 \
	gstreamer-audio-1.0 \
	gstreamer-fft-1.0 \
	gstreamer-pbutils-1.0 \
	gstreamer-play-1.0 \
	gstreamer-player-1.0 \
	gstreamer-riff-1.0 \
	gstreamer-rtp-1.0 \
	gstreamer-sdp-1.0 \
	gstreamer-rtsp-1.0 \
	gstreamer-rtsp-server-1.0 \
	gstreamer-tag-1.0 \
	gstreamer-video-1.0 \
	gstreamer-webrtc-1.0 \
	gst-editing-services-1.0 \
	$(NULL)

GIR_BINDINGS = \
	atk \
	atspi-2 \
	clutter-1.0 \
	clutter-gdk-1.0 \
	clutter-gtk-1.0 \
	clutter-gst-2.0 \
	clutter-gst-3.0 \
	clutter-x11-1.0 \
	cogl-pango-1.0 \
	gdesktopenums-3.0 \
	gdk-3.0 \
	gdk-x11-3.0 \
	gdk-pixbuf-2.0 \
	gdl-3.0 \
	geocode-glib-1.0 \
	geocode-glib-2.0 \
	gio-2.0 \
	gmodule-2.0 \
	gnome-bg-4 \
	gnome-desktop-3.0 \
	gnome-desktop-4 \
	gnome-rr-4 \
	gobject-introspection-1.0 \
	goocanvas-2.0 \
	graphene-gobject-1.0 \
	gtk+-3.0 \
	gtk4 \
	gtk4-unix-print \
	gtk4-wayland \
	gtk4-x11 \
	gudev-1.0 \
	harfbuzz-gobject \
	javascriptcoregtk-4.0 \
	javascriptcoregtk-4.1 \
	javascriptcoregtk-6.0 \
	json-glib-1.0 \
	libgeoclue-2.0 \
	libgnome-menu-3.0 \
	libgrss \
	libgsf-1 \
	libnotify \
	libpeas-1.0 \
	libpeas-gtk-1.0 \
	libsoup-2.4 \
	libsoup-3.0 \
	libwnck-3.0 \
	packagekit-glib2 \
	pango \
	pangocairo \
	polkit-agent-1 \
	polkit-gobject-1 \
	poppler-glib \
	rest-0.7 \
	rest-extras-0.7 \
	rest-1.0 \
	rest-extras-1.0 \
	udisks2 \
	webkit2gtk-4.0 \
	webkit2gtk-4.1 \
	webkit2gtk-web-extension-4.0 \
	webkit2gtk-web-extension-4.1 \
	webkitgtk-6.0 \
	webkitgtk-web-extension-6.0 \
	webkitgtk-web-process-extension-6.0 \
	$(GSTREAMER_1_0_BINDINGS) \
	$(NULL)

BINDINGS = $(GIR_BINDINGS) $(GIDL_BINDINGS)

VAPIGEN = $(top_builddir)/vapigen/vapigen$(EXEEXT)
VAPIGENFLAGS = --vapidir $(srcdir) --girdir $(GIRDIR)
GENVAPI = $(VAPIGEN) $(VAPIGENFLAGS)
METADATADIR = $(srcdir)/metadata
PACKAGESDIR = $(srcdir)/packages
GIRDIR = $$($(PKG_CONFIG) gobject-introspection-1.0 --variable=girdir)

.PHONY: all-bindings $(BINDINGS)

gir-bindings: $(GIR_BINDINGS)

gidl-bindings: $(GIDL_BINDINGS)

gstreamer-1.0-bindings: $(GSTREAMER_1_0_BINDINGS)

all-bindings: gir-bindings gidl-bindings

atk:
	$(GENVAPI) --library $(srcdir)/atk --metadatadir $(METADATADIR) $(METADATADIR)/Atk-1.0-custom.vala $(GIRDIR)/Atk-1.0.gir

atspi-2:
	$(GENVAPI) --library $(srcdir)/atspi-2 --metadatadir $(METADATADIR) $(GIRDIR)/Atspi-2.0.gir

clutter-1.0:
	$(GENVAPI) --library $(srcdir)/clutter-1.0 --metadatadir $(METADATADIR) $(METADATADIR)/Clutter-1.0-custom.vala --pkg atk --pkg cairo --pkg pango --pkg cogl-1.0 --pkg cogl-pango-1.0 --pkg json-glib-1.0 $(GIRDIR)/Clutter-1.0.gir

clutter-gdk-1.0:
	$(GENVAPI) --library $(srcdir)/clutter-gdk-1.0 --metadatadir $(METADATADIR) --pkg clutter-1.0 --pkg gdk-3.0 $(GIRDIR)/ClutterGdk-1.0.gir

clutter-gtk-0.10:
	$(GENVAPI) --library $(srcdir)/clutter-gtk-0.10 $(PACKAGESDIR)/clutter-gtk-0.10/clutter-gtk-0.10.gi

clutter-gtk-1.0:
	$(GENVAPI) --library $(srcdir)/clutter-gtk-1.0 --metadatadir $(METADATADIR) $(METADATADIR)/GtkClutter-1.0-custom.vala --pkg clutter-1.0 --pkg gtk+-3.0 --pkg cogl-pango-1.0 $(GIRDIR)/GtkClutter-1.0.gir

clutter-gst-2.0:
	$(GENVAPI) --library $(srcdir)/clutter-gst-2.0 --metadatadir $(METADATADIR) $(METADATADIR)/ClutterGst-2.0-custom.vala --pkg cogl-1.0 --pkg clutter-1.0 --pkg gstreamer-base-1.0 --pkg gstreamer-video-1.0 $(GIRDIR)/ClutterGst-2.0.gir

clutter-gst-3.0:
	$(GENVAPI) --library $(srcdir)/clutter-gst-3.0 --metadatadir $(METADATADIR) $(METADATADIR)/ClutterGst-3.0-custom.vala --pkg cogl-1.0 --pkg clutter-1.0 --pkg gdk-pixbuf-2.0 --pkg gstreamer-1.0 --pkg gstreamer-audio-1.0 --pkg gstreamer-base-1.0 --pkg gstreamer-pbutils-1.0 --pkg gstreamer-video-1.0 $(GIRDIR)/ClutterGst-3.0.gir

clutter-x11-1.0:
	$(GENVAPI) --library $(srcdir)/clutter-x11-1.0 --metadatadir $(METADATADIR) --pkg clutter-1.0 --pkg x11 $(GIRDIR)/ClutterX11-1.0.gir

cogl-1.0:
	$(GENVAPI) --library $(srcdir)/cogl-1.0 $(PACKAGESDIR)/cogl-1.0/cogl-1.0-custom.vala $(PACKAGESDIR)/cogl-1.0/cogl-1.0.gi

cogl-pango-1.0:
	$(GENVAPI) --library $(srcdir)/cogl-pango-1.0 --metadatadir $(METADATADIR) --pkg cogl-1.0 --pkg pango $(GIRDIR)/CoglPango-1.0.gir

gconf-2.0:
	$(GENVAPI) --library $(srcdir)/gconf-2.0 $(PACKAGESDIR)/gconf-2.0/gconf-2.0.gi

geocode-glib-1.0:
	$(GENVAPI) --library $(srcdir)/geocode-glib-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GeocodeGlib-1.0.gir

geocode-glib-2.0:
	$(GENVAPI) --library $(srcdir)/geocode-glib-2.0 --pkg gio-2.0 --pkg json-glib-1.0 --pkg libsoup-3.0 --metadatadir $(METADATADIR) $(GIRDIR)/GeocodeGlib-2.0.gir

gdesktopenums-3.0:
	$(GENVAPI) --library $(srcdir)/gdesktopenums-3.0 --metadatadir $(METADATADIR) $(GIRDIR)/GDesktopEnums-3.0.gir

gdk-2.0:
	$(GENVAPI) --library $(srcdir)/gdk-2.0 $(PACKAGESDIR)/gdk-2.0/gdk-2.0-custom.vala $(PACKAGESDIR)/gdk-2.0/gdk-2.0.gi

gdk-3.0:
	$(GENVAPI) --library $(srcdir)/gdk-3.0 --pkg gio-2.0 --metadatadir $(METADATADIR) $(METADATADIR)/Gdk-3.0-custom.vala $(GIRDIR)/Gdk-3.0.gir

gdk-pixbuf-2.0:
	$(GENVAPI) --library $(srcdir)/gdk-pixbuf-2.0 --pkg gio-2.0 --metadatadir $(METADATADIR) $(METADATADIR)/GdkPixbuf-2.0-custom.vala $(GIRDIR)/GdkPixdata-2.0.gir $(GIRDIR)/GdkPixbuf-2.0.gir

gdk-x11-2.0:
	$(GENVAPI) --library $(srcdir)/gdk-x11-2.0 $(PACKAGESDIR)/gdk-x11-2.0/gdk-x11-2.0-custom.vala $(PACKAGESDIR)/gdk-x11-2.0/gdk-x11-2.0.gi

gdk-x11-3.0:
	$(GENVAPI) --library $(srcdir)/gdk-x11-3.0 --pkg gio-2.0 --pkg gdk-3.0 --pkg x11 --metadatadir $(METADATADIR) $(METADATADIR)/GdkX11-3.0-custom.vala $(GIRDIR)/GdkX11-3.0.gir

gdl-1.0:
	$(GENVAPI) --library $(srcdir)/gdl-1.0 $(PACKAGESDIR)/gdl-1.0/gdl-1.0-custom.vala $(PACKAGESDIR)/gdl-1.0/gdl-1.0.gi

gdl-3.0:
	$(GENVAPI) --library $(srcdir)/gdl-3.0 --pkg gio-2.0 --pkg gtk+-3.0 --metadatadir $(METADATADIR) $(GIRDIR)/Gdl-3.gir

gio-2.0:
	$(GENVAPI) --library $(srcdir)/gio-2.0 --metadatadir $(METADATADIR) $(METADATADIR)/Gio-2.0-custom.vala $(GIRDIR)/Gio-2.0.gir

gio-unix-2.0:
	$(GENVAPI) --library $(srcdir)/gio-unix-2.0 $(PACKAGESDIR)/gio-unix-2.0/gio-unix-2.0-custom.vala $(PACKAGESDIR)/gio-unix-2.0/gio-unix-2.0.gi

gmodule-2.0:
	$(GENVAPI) --library $(srcdir)/gmodule-2.0 --metadatadir $(METADATADIR) $(METADATADIR)/GModule-2.0-custom.vala $(GIRDIR)/GModule-2.0.gir

gnome-bg-4:
	$(GENVAPI) --library $(srcdir)/gnome-bg-4 --pkg cairo --pkg gdk-pixbuf-2.0 --pkg gnome-desktop-4 --pkg gtk4 --metadatadir $(METADATADIR) $(METADATADIR)/GnomeBG-4.0-custom.vala $(GIRDIR)/GnomeBG-4.0.gir

gnome-desktop-2.0:
	$(GENVAPI) --library $(srcdir)/gnome-desktop-2.0 $(PACKAGESDIR)/gnome-desktop-2.0/gnome-desktop-2.0.gi

gnome-desktop-3.0:
	$(GENVAPI) --library $(srcdir)/gnome-desktop-3.0 --pkg gtk+-3.0 --metadatadir $(METADATADIR) $(METADATADIR)/GnomeDesktop-3.0-custom.vala $(GIRDIR)/GnomeDesktop-3.0.gir

gnome-desktop-4:
	$(GENVAPI) --library $(srcdir)/gnome-desktop-4 --pkg gio-2.0 --pkg gdesktopenums-3.0 --pkg gdk-pixbuf-2.0 --metadatadir $(METADATADIR) $(GIRDIR)/GnomeDesktop-4.0.gir

gnome-rr-4:
	$(GENVAPI) --library $(srcdir)/gnome-rr-4 --pkg gnome-desktop-4 --pkg gtk4 --metadatadir $(METADATADIR) $(GIRDIR)/GnomeRR-4.0.gir

gnome-vfs-2.0:
	$(GENVAPI) --library $(srcdir)/gnome-vfs-2.0 $(PACKAGESDIR)/gnome-vfs-2.0/gnome-vfs-2.0-custom.vala $(PACKAGESDIR)/gnome-vfs-2.0/gnome-vfs-2.0.gi

gobject-introspection-1.0:
	$(GENVAPI) --library $(srcdir)/gobject-introspection-1.0 --metadatadir $(METADATADIR) $(METADATADIR)/GIRepository-2.0-custom.vala $(GIRDIR)/GIRepository-2.0.gir

goocanvas:
	$(GENVAPI) --library $(srcdir)/goocanvas $(PACKAGESDIR)/goocanvas/goocanvas-custom.vala $(PACKAGESDIR)/goocanvas/goocanvas.gi

goocanvas-2.0:
	$(GENVAPI) --library $(srcdir)/goocanvas-2.0 --pkg cairo --pkg gtk+-3.0 --metadatadir $(METADATADIR) $(GIRDIR)/GooCanvas-2.0.gir

graphene-gobject-1.0:
	$(GENVAPI) --library $(srcdir)/graphene-gobject-1.0 --pkg gobject-2.0 --metadatadir $(METADATADIR) $(GIRDIR)/Graphene-1.0.gir

gstreamer-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-1.0 --metadatadir $(METADATADIR) $(METADATADIR)/Gst-1.0-custom.vala $(GIRDIR)/Gst-1.0.gir

gstreamer-allocators-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-allocators-1.0 --pkg gstreamer-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstAllocators-1.0.gir

gstreamer-app-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-app-1.0 --pkg gstreamer-base-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstApp-1.0.gir

gstreamer-audio-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-audio-1.0 --pkg gstreamer-base-1.0 --metadatadir $(METADATADIR) $(METADATADIR)/GstAudio-1.0-custom.vala $(GIRDIR)/GstAudio-1.0.gir

gstreamer-bad-allocators-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-bad-allocators-1.0 --pkg gstreamer-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstBadAllocators-1.0.gir

gstreamer-base-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-base-1.0 --pkg gstreamer-1.0 --metadatadir $(METADATADIR) $(METADATADIR)/GstBase-1.0-custom.vala $(GIRDIR)/GstBase-1.0.gir

gstreamer-check-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-check-1.0 --pkg gstreamer-1.0 --metadatadir $(METADATADIR) $(METADATADIR)/GstCheck-1.0-custom.vala $(GIRDIR)/GstCheck-1.0.gir

gstreamer-fft-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-fft-1.0 --pkg gstreamer-1.0 --metadatadir $(METADATADIR) $(METADATADIR)/GstFft-1.0-custom.vala $(GIRDIR)/GstFft-1.0.gir

gstreamer-controller-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-controller-1.0 --pkg gstreamer-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstController-1.0.gir

gstreamer-net-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-net-1.0 --pkg gstreamer-1.0 --pkg gio-2.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstNet-1.0.gir

gstreamer-pbutils-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-pbutils-1.0 --pkg gstreamer-base-1.0 --pkg gstreamer-audio-1.0 --pkg gstreamer-video-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstPbutils-1.0.gir

gstreamer-play-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-play-1.0 --pkg gstreamer-1.0 --pkg gstreamer-pbutils-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstPlay-1.0.gir

gstreamer-player-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-player-1.0 --pkg gstreamer-1.0 --pkg gstreamer-pbutils-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstPlayer-1.0.gir

gstreamer-riff-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-riff-1.0 --pkg gstreamer-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstRiff-1.0.gir

gstreamer-rtp-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-rtp-1.0 --pkg gstreamer-base-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstRtp-1.0.gir

gstreamer-rtsp-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-rtsp-1.0 --pkg gstreamer-base-1.0 --pkg gstreamer-sdp-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstRtsp-1.0.gir

gstreamer-rtsp-server-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-rtsp-server-1.0 --pkg gstreamer-rtsp-1.0 --pkg gstreamer-net-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstRtspServer-1.0.gir

gstreamer-sdp-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-sdp-1.0 --pkg gstreamer-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstSdp-1.0.gir

gstreamer-tag-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-tag-1.0 --pkg gstreamer-base-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstTag-1.0.gir

gstreamer-video-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-video-1.0 --pkg gstreamer-base-1.0 --metadatadir $(METADATADIR) $(METADATADIR)/GstVideo-1.0-custom.vala $(GIRDIR)/GstVideo-1.0.gir

gstreamer-webrtc-1.0:
	$(GENVAPI) --library $(srcdir)/gstreamer-webrtc-1.0 --pkg gstreamer-base-1.0 --pkg gstreamer-sdp-1.0 --metadatadir $(METADATADIR) $(GIRDIR)/GstWebRTC-1.0.gir

gst-editing-services-1.0:
	$(GENVAPI) --library $(srcdir)/gst-editing-services-1.0 --pkg gstreamer-pbutils-1.0 --pkg gstreamer-video-1.0 --metadatadir $(METADATADIR) $(METADATADIR)/GES-1.0-custom.vala $(GIRDIR)/GES-1.0.gir

gtk+-2.0:
	$(GENVAPI) --library $(srcdir)/gtk+-2.0 $(PACKAGESDIR)/gtk+-2.0/gtk+-2.0-custom.vala $(PACKAGESDIR)/gtk+-2.0/gtk+-2.0.gi

gtk+-3.0:
	$(GENVAPI) --library $(srcdir)/gtk+-3.0 --pkg atk --pkg gdk-3.0 --pkg gdk-pixbuf-2.0 --pkg gio-2.0 --pkg pango --pkg cairo --metadatadir $(METADATADIR) $(METADATADIR)/Gtk-3.0-custom.vala $(GIRDIR)/Gtk-3.0.gir

gtk4:
	$(GENVAPI) --library $(srcdir)/gtk4 --pkg cairo --pkg gdk-pixbuf-2.0 --pkg gio-2.0 --pkg graphene-gobject-1.0 --pkg pango --pkg pangocairo \
		--metadatadir $(METADATADIR) \
		$(METADATADIR)/Gdk-4.0-custom.vala $(GIRDIR)/Gdk-4.0.gir \
		$(METADATADIR)/Gsk-4.0-custom.vala $(GIRDIR)/Gsk-4.0.gir \
		$(METADATADIR)/Gtk-4.0-custom.vala $(GIRDIR)/Gtk-4.0.gir

gtk4-wayland:
	$(GENVAPI) --library $(srcdir)/gtk4-wayland --pkg cairo --pkg gdk-pixbuf-2.0 --pkg gio-2.0 --pkg graphene-gobject-1.0 --pkg pango --pkg pangocairo --pkg gtk4 --pkg wayland-client --metadatadir $(METADATADIR) $(METADATADIR)/GdkWayland-4.0-custom.vala $(GIRDIR)/GdkWayland-4.0.gir

gtk4-x11:
	$(GENVAPI) --library $(srcdir)/gtk4-x11 --pkg cairo --pkg gdk-pixbuf-2.0 --pkg gio-2.0 --pkg graphene-gobject-1.0 --pkg pango --pkg pangocairo --pkg gtk4 --pkg x11 --metadatadir $(METADATADIR) $(METADATADIR)/GdkX11-4.0-custom.vala $(GIRDIR)/GdkX11-4.0.gir

gtk+-unix-print-2.0:
	$(GENVAPI) --library $(srcdir)/gtk+-unix-print-2.0 $(PACKAGESDIR)/gtk+-unix-print-2.0/gtk+-unix-print-2.0-custom.vala $(PACKAGESDIR)/gtk+-unix-print-2.0/gtk+-unix-print-2.0.gi

gtk+-unix-print-3.0:
	$(GENVAPI) --library $(srcdir)/gtk+-unix-print-3.0 $(PACKAGESDIR)/gtk+-unix-print-3.0/gtk+-unix-print-3.0-custom.vala $(PACKAGESDIR)/gtk+-unix-print-3.0/gtk+-unix-print-3.0.gi

gtk4-unix-print:
	ln -s $(GIRDIR)/Gtk-4.0.gir GtkUnixPrint-4.0.gir; \
	$(GENVAPI) --library $(srcdir)/gtk4-unix-print --pkg gtk4 --pkg pangocairo --metadatadir $(METADATADIR) $(METADATADIR)/GtkUnixPrint-4.0-custom.vala GtkUnixPrint-4.0.gir; \
	rm -f GtkUnixPrint-4.0.gir

gtksourceview-2.0:
	$(GENVAPI) --library $(srcdir)/gtksourceview-2.0 $(PACKAGESDIR)/gtksourceview-2.0/gtksourceview-2.0.gi

gudev-1.0:
	$(GENVAPI) --library $(srcdir)/gudev-1.0 --metadatadir $(METADATADIR) $(METADATADIR)/GUdev-1.0-custom.vala $(GIRDIR)/GUdev-1.0.gir

harfbuzz-gobject:
	$(GENVAPI) --library $(srcdir)/harfbuzz-gobject --pkg freetype2 --metadatadir $(METADATADIR) $(GIRDIR)/HarfBuzz-0.0.gir

javascriptcoregtk-4.0:
	$(GENVAPI) --library $(srcdir)/javascriptcoregtk-4.0 --metadatadir $(METADATADIR) $(METADATADIR)/JavaScriptCore-4.0-custom.vala $(GIRDIR)/JavaScriptCore-4.0.gir

javascriptcoregtk-4.1:
	$(GENVAPI) --library $(srcdir)/javascriptcoregtk-4.1 --metadatadir $(METADATADIR) $(METADATADIR)/JavaScriptCore-4.1-custom.vala $(GIRDIR)/JavaScriptCore-4.1.gir

javascriptcoregtk-6.0:
	$(GENVAPI) --library $(srcdir)/javascriptcoregtk-6.0 --metadatadir $(METADATADIR) $(METADATADIR)/JavaScriptCore-6.0-custom.vala $(GIRDIR)/JavaScriptCore-6.0.gir

json-glib-1.0:
	$(GENVAPI) --library $(srcdir)/json-glib-1.0 --metadatadir $(METADATADIR) --pkg gio-2.0 $(METADATADIR)/Json-1.0-custom.vala $(GIRDIR)/Json-1.0.gir

libepc-1.0:
	$(GENVAPI) --library $(srcdir)/libepc-1.0 $(PACKAGESDIR)/libepc-1.0/libepc-1.0.gi

libgeoclue-2.0:
	$(GENVAPI) --library $(srcdir)/libgeoclue-2.0 --pkg gio-2.0 --metadatadir $(METADATADIR) $(GIRDIR)/Geoclue-2.0.gir

libglade-2.0:
	$(GENVAPI) --library $(srcdir)/libglade-2.0 $(PACKAGESDIR)/libglade-2.0/libglade-2.0.gi

libgnome-2.0:
	$(GENVAPI) --library $(srcdir)/libgnome-2.0 $(PACKAGESDIR)/libgnome-2.0/libgnome-2.0.gi

libgnome-menu:
	$(GENVAPI) --library $(srcdir)/libgnome-menu $(PACKAGESDIR)/libgnome-menu/libgnome-menu-custom.vala $(PACKAGESDIR)/libgnome-menu/libgnome-menu.gi

libgnome-menu-3.0:
	$(GENVAPI) --library $(srcdir)/libgnome-menu-3.0 --metadatadir $(METADATADIR) --pkg gio-unix-2.0 $(GIRDIR)/GMenu-3.0.gir

libgnomeui-2.0:
	$(GENVAPI) --library $(srcdir)/libgnomeui-2.0 $(PACKAGESDIR)/libgnomeui-2.0/libgnomeui-2.0-custom.vala $(PACKAGESDIR)/libgnomeui-2.0/libgnomeui-2.0.gi

libgrss:
	$(GENVAPI) --library $(srcdir)/libgrss --metadatadir $(METADATADIR) --pkg gio-2.0 --pkg libsoup-2.4 --pkg libxml-2.0 $(GIRDIR)/Grss-0.7.gir

libgsf-1:
	$(GENVAPI) --library $(srcdir)/libgsf-1 --pkg gio-2.0 --pkg libxml-2.0 --metadatadir $(METADATADIR) $(METADATADIR)/Gsf-1-custom.vala $(GIRDIR)/Gsf-1.gir

libnotify:
	$(GENVAPI) --library $(srcdir)/libnotify --pkg gdk-pixbuf-2.0 --pkg gio-2.0 --metadatadir $(METADATADIR) $(GIRDIR)/Notify-0.7.gir

liboobs-1:
	$(GENVAPI) --library $(srcdir)/liboobs-1 $(PACKAGESDIR)/liboobs-1/liboobs-1.gi

libpeas-1.0:
	$(GENVAPI) --library $(srcdir)/libpeas-1.0 --pkg gio-2.0 --metadatadir $(METADATADIR) $(GIRDIR)/Peas-1.0.gir

libpeas-gtk-1.0:
	$(GENVAPI) --library $(srcdir)/libpeas-gtk-1.0 --pkg libpeas-1.0 --pkg gtk+-3.0 --metadatadir $(METADATADIR) $(GIRDIR)/PeasGtk-1.0.gir

libsexy:
	$(GENVAPI) --library $(srcdir)/libsexy $(PACKAGESDIR)/libsexy/libsexy.gi

libsoup-2.4:
	$(GENVAPI) --library $(srcdir)/libsoup-2.4 --metadatadir $(METADATADIR) $(METADATADIR)/Soup-2.4-custom.vala --pkg gio-2.0 $(GIRDIR)/Soup-2.4.gir

libsoup-3.0:
	$(GENVAPI) --library $(srcdir)/libsoup-3.0 --metadatadir $(METADATADIR) $(METADATADIR)/Soup-3.0-custom.vala --pkg gio-2.0 $(GIRDIR)/Soup-3.0.gir

libwnck-1.0:
	$(GENVAPI) --library $(srcdir)/libwnck-1.0 $(PACKAGESDIR)/libwnck-1.0/libwnck-1.0.gi

libwnck-3.0:
	$(GENVAPI) --library $(srcdir)/libwnck-3.0 --metadatadir $(METADATADIR) --pkg gio-2.0 --pkg gtk+-3.0 $(GIRDIR)/Wnck-3.0.gir

loudmouth-1.0:
	$(GENVAPI) --library $(srcdir)/loudmouth-1.0 $(PACKAGESDIR)/loudmouth-1.0/loudmouth-1.0-custom.vala $(PACKAGESDIR)/loudmouth-1.0/loudmouth-1.0.gi

packagekit-glib2:
	$(GENVAPI) --library $(srcdir)/packagekit-glib2 --metadatadir $(METADATADIR) --pkg gio-2.0 $(GIRDIR)/PackageKitGlib-1.0.gir

pango:
	$(GENVAPI) --library $(srcdir)/pango --pkg cairo --pkg harfbuzz-gobject --metadatadir $(METADATADIR) $(METADATADIR)/Pango-1.0-custom.vala $(GIRDIR)/Pango-1.0.gir

pangocairo:
	$(GENVAPI) --library $(srcdir)/pangocairo --metadatadir $(METADATADIR) $(GIRDIR)/PangoCairo-1.0.gir

polkit-agent-1:
	$(GENVAPI) --library $(srcdir)/polkit-agent-1 --pkg gio-2.0 --pkg polkit-gobject-1 --metadatadir $(METADATADIR) $(GIRDIR)/PolkitAgent-1.0.gir

polkit-gobject-1:
	$(GENVAPI) --library $(srcdir)/polkit-gobject-1 --pkg gio-2.0 --metadatadir $(METADATADIR) $(GIRDIR)/Polkit-1.0.gir

poppler-glib:
	$(GENVAPI) --library $(srcdir)/poppler-glib --pkg cairo --pkg gio-2.0 --metadatadir $(METADATADIR) $(GIRDIR)/Poppler-0.18.gir

purple:
	$(GENVAPI) --library $(srcdir)/purple $(PACKAGESDIR)/purple/purple-custom.vala $(PACKAGESDIR)/purple/purple.gi

rest-0.7:
	$(GENVAPI) --library $(srcdir)/rest-0.7 --metadatadir $(METADATADIR) --pkg gio-2.0 $(GIRDIR)/Rest-0.7.gir

rest-extras-0.7:
	$(GENVAPI) --library $(srcdir)/rest-extras-0.7 --metadatadir $(METADATADIR) --pkg rest-0.7 $(GIRDIR)/RestExtras-0.7.gir

rest-1.0:
	$(GENVAPI) --library $(srcdir)/rest-1.0 --metadatadir $(METADATADIR) --pkg gio-2.0 --pkg libsoup-3.0 $(GIRDIR)/Rest-1.0.gir

rest-extras-1.0:
	$(GENVAPI) --library $(srcdir)/rest-extras-1.0 --metadatadir $(METADATADIR) --pkg rest-1.0 $(GIRDIR)/RestExtras-1.0.gir

udisks2:
	$(GENVAPI) --library $(srcdir)/udisks2 --metadatadir $(METADATADIR) --pkg gio-2.0 $(GIRDIR)/UDisks-2.0.gir

unique-1.0:
	$(GENVAPI) --library $(srcdir)/unique-1.0 $(PACKAGESDIR)/unique-1.0/unique-1.0.gi

webkit2gtk-4.0:
	$(GENVAPI) --library $(srcdir)/webkit2gtk-4.0 --metadatadir $(METADATADIR) --pkg gtk+-3.0 --pkg libsoup-2.4 $(METADATADIR)/WebKit2-4.0-custom.vala $(GIRDIR)/WebKit2-4.0.gir

webkit2gtk-4.1:
	$(GENVAPI) --library $(srcdir)/webkit2gtk-4.1 --metadatadir $(METADATADIR) --pkg gtk+-3.0 --pkg libsoup-3.0 $(METADATADIR)/WebKit2-4.1-custom.vala $(GIRDIR)/WebKit2-4.1.gir

webkit2gtk-web-extension-4.0:
	$(GENVAPI) --library $(srcdir)/webkit2gtk-web-extension-4.0 --metadatadir $(METADATADIR) --pkg gtk+-3.0 $(METADATADIR)/WebKit2WebExtension-4.0-custom.vala $(GIRDIR)/WebKit2WebExtension-4.0.gir

webkit2gtk-web-extension-4.1:
	$(GENVAPI) --library $(srcdir)/webkit2gtk-web-extension-4.1 --metadatadir $(METADATADIR) --pkg gtk+-3.0 $(METADATADIR)/WebKit2WebExtension-4.1-custom.vala $(GIRDIR)/WebKit2WebExtension-4.1.gir

webkitgtk-6.0:
	$(GENVAPI) --library $(srcdir)/webkitgtk-6.0 --metadatadir $(METADATADIR) --pkg javascriptcoregtk-6.0 --pkg gtk4 --pkg libsoup-3.0 $(GIRDIR)/WebKit-6.0.gir

webkitgtk-web-extension-6.0:
	$(GENVAPI) --library $(srcdir)/webkitgtk-web-extension-6.0 --metadatadir $(METADATADIR) --pkg javascriptcoregtk-6.0 --pkg gtk4 --pkg libsoup-3.0 $(METADATADIR)/WebKitWebExtension-6.0-custom.vala $(GIRDIR)/WebKitWebExtension-6.0.gir

webkitgtk-web-process-extension-6.0:
	$(GENVAPI) --library $(srcdir)/webkitgtk-web-process-extension-6.0 --metadatadir $(METADATADIR) --pkg javascriptcoregtk-6.0 --pkg gtk4 --pkg libsoup-3.0 $(GIRDIR)/WebKitWebProcessExtension-6.0.gir
