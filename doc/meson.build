help2man = find_program('help2man', required: false)
if help2man.found() and get_option('manpages')
	# https://github.com/mesonbuild/meson/issues/1550
	man_1_dir = join_paths(get_option('mandir'), 'man1')
	custom_target('vala-gen-introspect.1',
		output: 'vala-gen-introspect.1',
		command: [help2man,
			'--include', join_paths(meson.current_source_dir(), 'vala-gen-introspect.h2m'),
			'--no-info', '--output=@OUTPUT@', vala_gen_introspect_sh
		],
		install: true,
		install_dir: man_1_dir,
	)
	custom_target('valac.1',
		output: 'valac.1',
		command: [help2man,
			'--include', join_paths(meson.current_source_dir(), 'valac.h2m'),
			'--no-info', '--output=@OUTPUT@', valac_exe
		],
		install: true,
		install_dir: man_1_dir,
	)
	custom_target('vapigen.1',
		output: 'vapigen.1',
		command: [help2man,
			'--include', join_paths(meson.current_source_dir(), 'vapigen.h2m'),
			'--no-info', '--output=@OUTPUT@', vapigen_exe
		],
		install: true,
		install_dir: man_1_dir,
	)
	if valadoc_enabled
		custom_target('valadoc.1',
			output: 'valadoc.1',
			command: [help2man,
				'--include', join_paths(meson.current_source_dir(), 'valadoc.h2m'),
				'--no-info', '--output=@OUTPUT@', valadoc_exe
			],
			install: true,
			install_dir: man_1_dir,
		)
	endif
else
	manpages = files(
		'vala-gen-introspect.1',
		'valac.1',
		'vapigen.1',
	)
	if valadoc_enabled
		manpages += files('valadoc.1')
	endif
	install_man(manpages)
endif

# https://github.com/mesonbuild/meson/issues/1602
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative vala-gen-introspect.1 @1@'.format(join_paths(get_option('prefix'), get_option('mandir')), 'vala-gen-introspect@0@.1'.format(vala_version_suffix)))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative valac.1 @1@'.format(join_paths(get_option('prefix'), get_option('mandir')), 'valac@0@.1'.format(vala_version_suffix)))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative vapigen.1 @1@'.format(join_paths(get_option('prefix'), get_option('mandir')), 'vapigen@0@.1'.format(vala_version_suffix)))
if valadoc_enabled
	meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative valadoc.1 @1@'.format(join_paths(get_option('prefix'), get_option('mandir')), 'valadoc@0@.1'.format(vala_version_suffix)))
endif
