valac_sources = files(
	'valacompiler.vala',
)

valac_name = 'valac@0@'.format(vala_version_suffix)

extra_compiler_include_dirs = []

if cc.get_argument_syntax() == 'msvc'
	extra_compiler_include_dirs += include_directories('../msvc')
endif

valac_exe = executable(
	valac_name,
	valac_sources,
	include_directories: extra_compiler_include_dirs,
	dependencies: [glib_dep, valacodegen_dep],
	install: true,
)

vala_name = 'vala@0@'.format(vala_version_suffix)

# https://github.com/mesonbuild/meson/issues/1602
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs --relative @1@ valac'.format(join_paths(get_option('prefix'), get_option('bindir')), valac_name))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs --relative @1@ @2@'.format(join_paths(get_option('prefix'), get_option('bindir')), valac_name, vala_name))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs --relative @1@ vala'.format(join_paths(get_option('prefix'), get_option('bindir')), valac_name))
