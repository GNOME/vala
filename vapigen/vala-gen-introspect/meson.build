vala_gen_introspect_sh = configure_file(
	input: 'vala-gen-introspect.in',
	output: 'vala-gen-introspect@0@'.format(vala_version_suffix),
	configuration: pkgconf,
	install_dir: get_option('bindir'),
)

# https://github.com/mesonbuild/meson/issues/1602
if symlinks_enabled
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs @1@ @2@ vala-gen-introspect'.format(
	join_paths(get_option('prefix'), get_option('bindir')),
	ln_options,
	'vala-gen-introspect@0@'.format(vala_version_suffix)))
endif
