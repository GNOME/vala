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

valadoc_names = [ 'valadoc' ]

foreach name: valadoc_names
	if cc.get_argument_syntax() == 'msvc'
		meson.add_install_script('cmd', '/c', 'cd /d @0@ & (if exist @2@.exe del @2@.exe) & mklink @2@.exe @1@.exe'.format(join_paths(get_option('prefix'), get_option('bindir')).replace('/','\\'), valadoc_name, name))
	else
		# https://github.com/mesonbuild/meson/issues/1602
		meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs --relative @1@ @2@'.format(join_paths(get_option('prefix'), get_option('bindir')), valadoc_name, name))
	endif
endforeach

subdir('doclets')
subdir('icons')
subdir('tests')
