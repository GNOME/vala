NULL =


AM_CFLAGS =  -g \
	-DPACKAGE_ICONDIR=\"$(datadir)/valadoc/icons/\" \
	-I ../../libvaladoc/ \
	$(LIBGVC_CFLAGS) \
	$(GLIB_CFLAGS) \
	$(LIBGEE_CFLAGS) \
	$(NULL)

# Without the LIBGVC_CFLAGS, we get 
# make[5]: Entering directory `/home/richard/.local/src/valadoc/src/doclets/devhelp'
#  CC       doclet.lo
# In file included from /usr/include/graphviz/gvc.h:17:0,
#                  from ../../libvaladoc/valadoc-1.0.h:15,
#                  from doclet.c:28:
# /usr/include/graphviz/types.h:49:20: fatal error: cgraph.h: No such file or directory
#  #include <cgraph.h>
#                     ^
# compilation terminated.


BUILT_SOURCES = libdoclet.vala.stamp


docletdir = $(libdir)/valadoc/doclets/html


libdoclet_la_LDFLAGS = -module -avoid-version -no-undefined


doclet_LTLIBRARIES =  \
	libdoclet.la      \
	$(NULL)


libdoclet_la_VALASOURCES = \
	doclet.vala            \
	$(NULL)


libdoclet_la_SOURCES =  \
	libdoclet.vala.stamp \
	$(libdoclet_la_VALASOURCES:.vala=.c) \
	$(NULL)


libdoclet.vala.stamp: $(libdoclet_la_VALASOURCES)
	$(VALAC) -C --vapidir $(top_srcdir)/src/vapi --vapidir $(top_srcdir)/src/libvaladoc --pkg gee-0.8 --pkg valadoc-1.0 --basedir . $^
	touch $@


libdoclet_la_LIBADD = \
	../../libvaladoc/libvaladoc.la \
	$(GLIB_LIBS) \
	$(LIBGEE_LIBS) \
	$(NULL)


EXTRA_DIST = $(libdoclet_la_VALASOURCES)  libdoclet.vala.stamp 


MAINTAINERCLEANFILES = \
	$(libdoclet_la_VALASOURCES:.vala=.c) \
	$(NULL)


