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
	dependencies: [
		gobject_dep,
		libvaladoc_dep,
		inc_libvalarooth_dep,
		inc_libvalah_dep,
		inc_libvalacodegenh_dep,
		inc_libvalaccodeh_dep,
		inc_libvalageeh_dep],
	install: true,
	install_dir: join_paths(get_option('libdir'), 'valadoc', 'doclets', 'gtkdoc'),
	link_with: [libvaladoc_lib, valacore_lib]
)
