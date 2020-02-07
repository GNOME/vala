vapigen_sources = files(
	'valagidlparser.vala',
	'valavapigen.vala',
)

vapigen_name = 'vapigen@0@'.format(vala_version_suffix)

vapigen_exe = executable(
	vapigen_name,
	vapigen_sources,
	dependencies: [glib_dep, valagee_dep, valacore_dep, gidl_dep],
	install: true,
	vala_args: ['--pkg', 'gidl', '--vapidir', join_paths(meson.source_root(), 'gobject-introspection')],
)

# https://github.com/mesonbuild/meson/issues/1602
if symlinks_enabled
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs @1@ @2@ vapigen'.format(
	join_paths(get_option('prefix'), get_option('bindir')),
	ln_options,
	vapigen_name))
endif

vapicheck_sources = files(
	'valavapicheck.vala',
)

vapicheck_name = 'vapicheck@0@'.format(vala_version_suffix)

executable(
	vapicheck_name,
	vapicheck_sources,
	dependencies: [glib_dep, valagee_dep, valacore_dep, gidl_dep],
	install: true,
	vala_args: ['--pkg', 'gidl', '--vapidir', join_paths(meson.source_root(), 'gobject-introspection')],
)

# https://github.com/mesonbuild/meson/issues/1602
if symlinks_enabled
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs @1@ @2@ vapicheck'.format(
	join_paths(get_option('prefix'), get_option('bindir')),
	ln_options,
	vapicheck_name))
endif

configure_file(
	input: 'vapigen.pc.in',
	output: 'vapigen@0@.pc'.format(vala_version_suffix),
	configuration: pkgconf,
	install_dir: pkg_install_dir,
)

install_data('vapigen.m4', install_dir: join_paths('share', 'aclocal'))
install_data('Makefile.vapigen', install_dir: join_paths('share', 'vala'))

subdir('vala-gen-introspect')
