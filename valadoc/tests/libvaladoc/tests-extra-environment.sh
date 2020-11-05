VALAFLAGS="\
	-X -D -X TOP_SRC_DIR=\"$abs_top_srcdir\" \
	--pkg libgvc \
	--vapidir $abs_top_srcdir/vala \
	--pkg libvala$PACKAGE_SUFFIX \
	--vapidir $abs_top_srcdir/libvaladoc \
	--pkg valadoc$PACKAGE_SUFFIX \
	--main main \
	-X -L$abs_top_builddir/vala/.libs -X -lvala$PACKAGE_SUFFIX \
	-X -L$abs_top_builddir/libvaladoc/.libs -X -lvaladoc$PACKAGE_SUFFIX \
	-X -I$abs_top_srcdir/gee \
	-X -I$abs_top_srcdir/vala \
	-X -I$abs_top_srcdir/libvaladoc \
	$abs_top_srcdir/valadoc/tests/libvaladoc/parser-generic-scanner.vala \
"
export PKG_CONFIG_PATH=$abs_top_builddir:$abs_top_builddir/libvaladoc
export LD_LIBRARY_PATH=$abs_top_builddir/vala/.libs:$abs_top_builddir/libvaladoc/.libs
