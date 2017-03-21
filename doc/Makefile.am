dist_man_MANS = valadoc.1

EXTRA_DIST = valadoc.h2m

if HAVE_HELP2MAN
manpages: valadoc.1
	@rm $^
	$(MAKE) $(AM_MAKEFLAGS) $^

valadoc.1:
	$(HELP2MAN) $(top_builddir)/src/valadoc/valadoc \
		--include $(srcdir)/valadoc.h2m \
		--libtool --no-info \
		--output=$@
endif

