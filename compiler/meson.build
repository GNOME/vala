valac_sources = files(
	'valacompiler.vala',
)

valac_name = 'valac@0@'.format(vala_version_suffix)

extra_compiler_include_dirs = []
extra_compiler_linker_args = []
extra_compiler_libs = []

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


valac_names = [ 'valac', vala_name, 'vala' ]

foreach name: valac_names
	if cc.get_argument_syntax() == 'msvc'
		meson.add_install_script('cmd', '/c', 'cd /d @0@ & (if exist @2@.exe del @2@.exe) & mklink @2@.exe @1@.exe'.format(join_paths(get_option('prefix'), get_option('bindir')).replace('/','\\'), valac_name, name))
	else
		# https://github.com/mesonbuild/meson/issues/1602
		meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@; ln -fs --relative @1@ @2@'.format(join_paths(get_option('prefix'), get_option('bindir')), valac_name, name))
	endif
endforeach
