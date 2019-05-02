valac_sources = [
	'valacompiler.vala',
]


valac_sources_c = []

foreach f : valac_sources
	if get_option ('bootstrap')
		af = f.split('.vala')
		nf = join_paths (meson.current_source_dir (), af[0] + '.c')
		valac_sources_c += nf
	else
		valac_sources_c += join_paths (meson.current_source_dir (), f)
	endif
endforeach

valac_name = 'valac@0@'.format(vala_version_suffix)

valac_exe = executable(
	valac_name,
	valac_sources_c,
	dependencies: [
		valacore_lib_deps,
		gio_dep,
		inc_libvalarooth_dep,
		inc_libvalah_dep,
		inc_libvalacodegenh_dep,
		inc_libvalaccodeh_dep,
		inc_libvalageeh_dep],
	install: true,
	link_with: valacore_lib
)

vala_name = 'vala@0@'.format(vala_version_suffix)

# https://github.com/mesonbuild/meson/issues/1602
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs --relative @1@ valac'.format(join_paths(get_option('prefix'), get_option('bindir')), valac_name))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs --relative @1@ @2@'.format(join_paths(get_option('prefix'), get_option('bindir')), valac_name, vala_name))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs --relative @1@ vala'.format(join_paths(get_option('prefix'), get_option('bindir')), valac_name))
