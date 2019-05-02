valadoc_sources = files(
	'girwriter.vala',
	'initializerbuilder.vala',
	'symbolresolver.vala',
	'treebuilder.vala',
	'valadoc.vala',
)

valadoc_name = 'valadoc@0@'.format(vala_version_suffix)

valadoc_exe = executable(
	valadoc_name,
	valadoc_sources,
	dependencies: [gobject_dep, valacore_lib_deps, libvaladoc_dep,
		inc_libvalarooth_dep,
		inc_libvalah_dep,
		inc_libvalacodegenh_dep,
		inc_libvalaccodeh_dep,
		inc_libvalageeh_dep],
	install: true,
	link_with: [ valacore_lib, libvaladoc_lib]
)

# https://github.com/mesonbuild/meson/issues/1602
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs --relative @1@ valadoc'.format(join_paths(get_option('prefix'), get_option('bindir')), valadoc_name))

subdir('doclets')
subdir('icons')
subdir('tests')
