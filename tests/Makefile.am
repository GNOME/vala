include $(top_srcdir)/Makefile.common
include $(top_srcdir)/build-aux/glib-tap.mk

test_programs = valadatetests valactests@PACKAGE_SUFFIX@

# Valadate tests
valadatetests_VALAFLAGS = \
	--vapidir $(top_srcdir)/valadate \
	--vapidir $(top_srcdir)/vapi \
	--pkg valadate \
	--pkg gio-2.0 \
	--pkg config \
	--library valadatetests \
	-g \
	$(NULL)

valadatetests_SOURCES = \
	valadatetests.vala \
	$(NULL)

valadatetests_LDADD = \
	$(GLIB_LIBS) \
	$(GIO_LIBS) \
	$(GMODULE_LIBS) \
	-lm \
	$(top_srcdir)/valadate/libvaladate.la \
	$(NULL)

valadatetests_CPPFLAGS = \
	-I$(top_srcdir)/valadate \
	$(GLIB_CPPFLAGS) \
	$(GIO_CFLAGS) \
	$(GMODULE_CPPFLAGS) \
	-fPIE \
	$(NULL)

valadatetests_CFLAGS = \
	-I$(top_srcdir)/valadate \
	$(GLIB_CFLAGS) \
	$(GIO_CFLAGS) \
	$(GMODULE_CFLAGS) \
	-pie \
	-g \
	$(NULL)

valactests@PACKAGE_SUFFIX@_VALAFLAGS = \
	--vapidir $(top_srcdir)/valadate \
	--vapidir $(top_srcdir)/vapi \
	--pkg valadate \
	--pkg gio-2.0 \
	--pkg config \
	--library valactests@PACKAGE_SUFFIX@ \
	-g \
	$(NULL)

valactests@PACKAGE_SUFFIX@_SOURCES = \
	valatests.vala \
	valatestsfactory.vala \
	$(NULL)

valactests@PACKAGE_SUFFIX@_LDADD = \
	$(GLIB_LIBS) \
	$(GIO_LIBS) \
	$(GMODULE_LIBS) \
	-lm \
	$(top_srcdir)/valadate/libvaladate.la \
	$(NULL)

valactests@PACKAGE_SUFFIX@_CPPFLAGS = \
	-I$(top_srcdir)/valadate \
	$(GLIB_CPPFLAGS) \
	$(GIO_CFLAGS) \
	$(GMODULE_CPPFLAGS) \
	-fPIE \
	$(NULL)

valactests@PACKAGE_SUFFIX@_CFLAGS = \
	-I$(top_srcdir)/valadate \
	$(GLIB_CFLAGS) \
	$(GIO_CFLAGS) \
	$(GMODULE_CFLAGS) \
	-pie \
	-g \
	$(NULL)

CLEANFILES += \
	*.gir \
	*.stamp \
	$(valactests@PACKAGE_SUFFIX@_SOURCES:.vala=.c) \
	*.vapi \
	rm -R .tests \
	$(NULL)
