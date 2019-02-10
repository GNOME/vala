doclet_gtkdoc_sources = files(
	'commentconverter.vala',
	'dbus.vala',
	'doclet.vala',
	'gcomment.vala',
	'generator.vala',
	'utils.vala',
)

shared_module(
	'doclet',
	doclet_gtkdoc_sources,
	dependencies: [gobject_dep, libvaladoc_dep],
	install: true,
	install_dir: join_paths(get_option('libdir'), 'valadoc@0@'.format (vala_version_suffix), 'doclets', 'gtkdoc'),
)
