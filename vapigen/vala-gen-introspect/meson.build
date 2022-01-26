vala_gen_introspect_sh = configure_file(
	input: 'vala-gen-introspect.in',
	output: 'vala-gen-introspect@0@'.format(vala_version_suffix),
	configuration: pkgconf,
	install_dir: get_option('bindir'),
)

vala_gen_introspect_names = [ 'vala-gen-introspect' ]

foreach name: vala_gen_introspect_names
	if cc.get_argument_syntax() == 'msvc'
		meson.add_install_script('cmd', '/c', 'cd /d @0@ & (if exist @2@ del @2@) & mklink @2@ @1@'.format(join_paths(get_option('prefix'), get_option('bindir')).replace('/','\\'), '@1@@0@'.format(vala_version_suffix, name), name))
	else
		# https://github.com/mesonbuild/meson/issues/1602
		meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs @1@ @2@'.format(join_paths(get_option('prefix'), get_option('bindir'), name), '@1@@0@'.format(vala_version_suffix, name)))
	endif
endforeach
