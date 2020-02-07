valac_sources = files(
	'valacompiler.vala',
)

valac_name = 'valac@0@'.format(vala_version_suffix)

valac_exe = executable(
	valac_name,
	valac_sources,
	dependencies: [glib_dep, valacodegen_dep],
	install: true,
)

vala_name = 'vala@0@'.format(vala_version_suffix)

# https://github.com/mesonbuild/meson/issues/1602
if symlinks_enabled
bindir_path = join_paths(get_option('prefix'), get_option('bindir'))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs @1@ @2@ valac'.format(bindir_path, ln_options, valac_name))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs @1@ @2@ @3@'.format(bindir_path, ln_options, valac_name, vala_name))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs @1@ @2@ vala'.format(bindir_path, ln_options, valac_name))
endif
