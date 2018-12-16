NULL =

check-gtktemplate: $(top_builddir)/compiler/valac
	G_DEBUG=fatal-warnings $(top_builddir)/compiler/valac \
		-C \
		--vapidir $(top_srcdir)/vapi \
		--pkg gtk+-3.0 \
		--gresources $(srcdir)/gtktemplate.gresource.xml \
		$(srcdir)/gtktemplate.vala; \
	rm -f gtktemplate.c

check: check-gtktemplate

EXTRA_DIST = \
	gtktemplate.gresource.xml \
	gtktemplate.ui \
	gtktemplate.vala \
	$(NULL)

CLEANFILES = \
	gtktemplate.c \
	$(NULL)
