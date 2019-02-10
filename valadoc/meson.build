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
	dependencies: [gobject_dep, valacodegen_dep, libvaladoc_dep],
	install: true,
)

# https://github.com/mesonbuild/meson/issues/1602
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs --relative @1@ valadoc'.format(join_paths(get_option('prefix'), get_option('bindir')), valadoc_name))

subdir('doclets')
subdir('icons')
