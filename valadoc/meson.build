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
if symlinks_enabled
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs @1@ @2@ valadoc'.format(
	join_paths(get_option('prefix'), get_option('bindir')),
	ln_options,
	valadoc_name))
endif

subdir('doclets')
subdir('icons')
subdir('tests')
