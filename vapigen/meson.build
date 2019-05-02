vapigen_sources = [
	'valagidlparser.vala',
	'valavapigen.vala',
]


vapigen_sources_c = []

foreach f : vapigen_sources
	if get_option ('bootstrap')
		af = f.split('.vala')
		nf = join_paths (meson.current_source_dir (), af[0] + '.c')
		vapigen_sources_c += nf
	else
		vapigen_sources_c += f
	endif
endforeach

vapigen_name = 'vapigen@0@'.format(vala_version_suffix)

vapigen_exe = executable(
	vapigen_name,
	vapigen_sources_c,
	dependencies: [valacore_lib_deps, gidl_dep,
		inc_libvalarooth_dep,
		inc_libvalah_dep,
		inc_libvalacodegenh_dep,
		inc_libvalaccodeh_dep,
		inc_libvalageeh_dep],
	install: true,
	vala_args: ['--pkg', 'gidl', '--vapidir', join_paths(meson.source_root(), 'gobject-introspection')],
	link_with: valacore_lib
)

# https://github.com/mesonbuild/meson/issues/1602
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs --relative @1@ vapigen'.format(join_paths(get_option('prefix'), get_option('bindir')), vapigen_name))

vapicheck_sources = [
	'valavapicheck.vala',
]

vapicheck_sources_c = []

foreach f : vapicheck_sources
	if get_option ('bootstrap')
		af = f.split('.vala')
		nf = join_paths (meson.current_source_dir (), af[0] + '.c')
		vapicheck_sources_c += nf
	else
		vapicheck_sources_c += f
	endif
endforeach

vapicheck_name = 'vapicheck@0@'.format(vala_version_suffix)

executable(
	vapicheck_name,
	vapicheck_sources_c,
	dependencies: [valacore_lib_deps, gidl_dep,
		inc_libvalarooth_dep,
		inc_libvalah_dep,
		inc_libvalacodegenh_dep,
		inc_libvalaccodeh_dep,
		inc_libvalageeh_dep],
	install: true,
	vala_args: ['--pkg', 'gidl', '--vapidir', join_paths(meson.source_root(), 'gobject-introspection')],
	link_with: valacore_lib
)

# https://github.com/mesonbuild/meson/issues/1602
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs --relative @1@ vapicheck'.format(join_paths(get_option('prefix'), get_option('bindir')), vapicheck_name))

configure_file(
	input: 'vapigen.pc.in',
	output: 'vapigen@0@.pc'.format(vala_version_suffix),
	configuration: pkgconf,
	install_dir: pkg_install_dir,
)

install_data('vapigen.m4', install_dir: join_paths('share', 'aclocal'))
install_data('Makefile.vapigen', install_dir: join_paths('share', 'vala'))

subdir('vala-gen-introspect')
