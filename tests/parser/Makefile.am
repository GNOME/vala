NULL =

check-keep-going: $(top_builddir)/compiler/valac
	G_DEBUG=fatal-warnings $(top_builddir)/compiler/valac \
		--vapidir $(top_srcdir)/vapi \
		--pkg libvala-0.50 \
		$(srcdir)/keep-going.vala \
		-o $(top_builddir)/tests/parser/keep-going-checker; \
	G_DEBUG=fatal-warnings $(top_builddir)/tests/parser/keep-going-checker \
		-l "7:6" \
		-t "ValaMemberAccess" \
		$(srcdir)/incomplete-member-access-end-of-scope.vala || exit 1; \
	G_DEBUG=fatal-warnings $(top_builddir)/tests/parser/keep-going-checker \
		-l "7:14" \
		-t "ValaMemberAccess" \
		$(srcdir)/incomplete-member-access-end-of-try-block.vala || exit 1;



check: check-keep-going


EXTRA_DIST = \
	incomplete-member-access-end-of-scope.vala \
	incomplete-member-access-end-of-try-block.vala \
	$(NULL)

CLEANFILES = \
	$(top_builddir)/tests/parser/keep-going-checker \
	$(NULL)
