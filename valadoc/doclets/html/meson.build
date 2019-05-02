doclet_html_sources = files(
	'doclet.vala',
)

shared_module(
	'doclet',
	doclet_html_sources,
	dependencies: [
		gobject_dep,
		libvaladoc_dep,
		inc_libvalarooth_dep,
		inc_libvalah_dep,
		inc_libvalacodegenh_dep,
		inc_libvalaccodeh_dep,
		inc_libvalageeh_dep],
	install: true,
	install_dir: join_paths(get_option('libdir'), 'valadoc', 'doclets', 'html'),
	c_args: ['-DPACKAGE_VALADOC_ICONDIR="@0@"'.format(join_paths(get_option('prefix'), get_option('datadir'), 'valadoc', 'icons'))],
	link_with: [libvaladoc_lib, valacore_lib]
)
