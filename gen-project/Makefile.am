NULL =

VALAC = $(top_builddir)/compiler/valac

AM_CPPFLAGS = \
	-I$(top_srcdir) \
	$(GLIB_CFLAGS) \
	$(GTK_CFLAGS) \
	-include config.h \
	-DPACKAGE_DATADIR=\"$(pkgdatadir)\" \
	$(NULL)

BUILT_SOURCES = vala-gen-project.vala.stamp

bin_PROGRAMS = \
	vala-gen-project \
	$(NULL)

vala_gen_project_VALASOURCES = \
	valaprojectgenerator.vala \
	$(NULL)

vala_gen_project_SOURCES = \
	vala-gen-project.vala.stamp \
	$(vala_gen_project_VALASOURCES:.vala=.c) \
	$(vala_gen_project_VALASOURCES:.vala=.h) \
	$(NULL)

vala-gen-project.vala.stamp: $(vala_gen_project_VALASOURCES)
	$(VALAC) --vapidir $(srcdir)/../vapi --pkg config --pkg gtk+-2.0 --basedir $(top_srcdir) $^
	touch $@

vala_gen_project_LDADD = \
	$(GLIB_LIBS) \
	$(GTK_LIBS) \
	$(NULL)

EXTRA_DIST = $(vala_gen_project_VALASOURCES) vala-gen-project.vala.stamp
