NULL =

vapidir = $(pkgdatadir)/vapi

vala-1.0.vala: ../ccode/ccode.vala ../vala/vala.vala
	cat $^ > $@

dist_vapi_DATA = \
	glib-2.0.vala \
	libxml-2.0.vala \
	gtk+-2.0.vala \
	pango.vala \
	vala-1.0.vala \
	$(NULL)
