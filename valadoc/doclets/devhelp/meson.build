doclet_devhelp_sources = [
	'doclet.vala',
]

shared_module(
	'doclet',
	doclet_devhelp_sources,
	dependencies: [gobject_dep, libvaladoc_dep],
	install: true,
	install_dir: join_paths(get_option('libdir'), 'valadoc', 'doclets', 'devhelp'),
)
