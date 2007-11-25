NULL =

INCLUDES = \
	-I$(top_srcdir) \
	$(GLIB_CFLAGS) \
	$(GTK_CFLAGS) \
	$(NULL)

BUILT_SOURCES = vala-gen-project.vala.stamp

bin_PROGRAMS = \
	vala-gen-project \
	$(NULL)

vala_gen_project_SOURCES = \
	vala-gen-project.vala.stamp \
	valaprojectgenerator.c \
	valaprojectgenerator.h \
	valaprojectgenerator.vala \
	$(NULL)

vala-gen-project.vala.stamp: $(filter %.vala,$(vala_gen_project_SOURCES))
	$(VALAC) --vapidir $(srcdir)/../vapi --pkg config --pkg gtk+-2.0 --basedir $(top_srcdir) $^
	touch $@

vala_gen_project_CPPFLAGS = \
	-include config.h \
	-DPACKAGE_DATADIR=\"$(pkgdatadir)\"

vala_gen_project_LDADD = \
	$(GLIB_LIBS) \
	$(GTK_LIBS) \
	$(NULL)

EXTRA_DIST = vala-gen-project.vala.stamp
