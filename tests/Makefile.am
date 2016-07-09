include $(top_srcdir)/Makefile.common
include $(top_srcdir)/build-aux/glib-tap.mk

test_programs = valactests-0

valactests_0_VALAFLAGS = \
	--vapidir $(top_srcdir)/valadate \
	--vapidir $(top_srcdir)/vapi \
	--pkg valadate \
	--pkg gio-2.0 \
	--pkg config \
	--library valactests-0 \
	-g \
	$(NULL)

valactests_0_SOURCES = \
	valatests.vala

valactests_0_LDADD = \
	$(GLIB_LIBS) \
	$(GMODULE_LIBS) \
	-lgio-2.0 \
	-lm \
	$(top_srcdir)/valadate/libvaladate.la \
	$(NULL)

valactests_0_CPPFLAGS = \
	-I$(top_srcdir)/valadate \
	$(GLIB_CPPFLAGS) \
	$(GMODULE_CPPFLAGS) \
	-fPIE \
	$(NULL)

valactests_0_CFLAGS = \
	-I$(top_srcdir)/valadate \
	$(GLIB_CFLAGS) \
	$(GMODULE_CFLAGS) \
	-pie \
	-g \
	$(NULL)

CLEANFILES += \
	*.gir \
	*.stamp \
	$(valactests_0_SOURCES:.vala=.c) \
	*.vapi \
	rm -R .tests \
	$(NULL)
