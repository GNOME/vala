#pkg-config --variable=vapidir vala-1.0

#  G_DEBUG=fatal_warnings

NULL =

SOURCES =              \
	html/taglet.vala     \
	html/helper.vala     \
	basic/b_taglet.vala  \
	errorreporter.vala   \
	settings.vala        \
	parser.vala          \
	doctree.vala         \
	valadoc.vala         \
	basic/b_langlet.vala \
	html/langlet.vala    \
	html/doclet.vala     \
	drawer.vala          \
	$(NULL)

PACKAGES = \
	--pkg vala-1.0 \
	--pkg cairo    --disable-non-null \
	$(NULL)


prog:
	valac -o valadoc $(SOURCES) $(PACKAGES) 


