doclet_html_sources = [
	'doclet.vala',
]

shared_module(
	'doclet',
	doclet_html_sources,
	dependencies: [gobject_dep, libvaladoc_dep],
	install: true,
	install_dir: join_paths (get_option('libdir'), 'valadoc', 'doclets', 'html'),
	c_args: ['-DPACKAGE_VALADOC_ICONDIR="@0@"'.format(join_paths(get_option('prefix'), get_option('datadir'), 'valadoc', 'icons'))],
)
