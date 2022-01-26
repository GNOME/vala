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
		env: 'LD_LIBRARY_PATH=' + join_paths(meson.build_root(), 'vala') + ':' + join_paths(meson.build_root(), 'codegen'),
		install: true,
		install_dir: man_1_dir,
	)
	custom_target('vapigen.1',
		output: 'vapigen.1',
		command: [help2man,
			'--include', join_paths(meson.current_source_dir(), 'vapigen.h2m'),
			'--no-info', '--output=@OUTPUT@', vapigen_exe
		],
		env: 'LD_LIBRARY_PATH=' + join_paths(meson.build_root(), 'vala') + ':' + join_paths(meson.build_root(), 'codegen'),
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
			env: 'LD_LIBRARY_PATH=' + join_paths(meson.build_root(), 'vala') + ':' + join_paths(meson.build_root(), 'codegen') + ':' + join_paths(meson.build_root(), 'libvaladoc'),
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

man_names = [ 'vala-gen-introspect', 'valac', 'vapigen' ]
if valadoc_enabled
	man_names += 'valadoc'
endif

foreach name: man_names
	if cc.get_argument_syntax() == 'msvc'
		meson.add_install_script('cmd', '/c', 'cd /d @0@\man1 & (if exist @1@.1 del @1@.1) & mklink @1@.1 @2@.1'.format(join_paths(get_option('prefix'), get_option('mandir')).replace('/','\\'), '@1@@0@'.format(vala_version_suffix, name), name))
	else
		# https://github.com/mesonbuild/meson/issues/1602
		meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative @2@.1 @1@'.format(join_paths(get_option('prefix'), get_option('mandir'), name), '@1@@0@.1'.format(vala_version_suffix, name)))
	endif
endforeach

if valadoc_enabled

valadoc_flags = [
	'--force',
	'--verbose',
	'--private',
	'--internal',
	'--deps',
	'--use-svg-images',
	'--vapidir', join_paths(meson.source_root(), 'vapi'),
	'--pkg', 'config',
	'--pkg', 'gmodule-2.0',
	'--directory', join_paths(meson.current_build_dir(), 'internal-apis'),
	'--doclet', join_paths(meson.build_root(), 'valadoc', 'doclets', 'html'),
	'--doclet-arg', '"--no-browsable-check"',
	'--basedir', join_paths(meson.current_build_dir(), 'internal-apis')
]

gee_doc = custom_target('gee_doc',
	command: [
		valadoc_exe,
		valadoc_flags + [
			'--package-name', 'gee', '--package-version', meson.project_version(),
		],
		'@INPUT@'
	],
	build_by_default: false,
	input: valagee_sources,
	output: 'gee-apis',
)

vala_doc = custom_target('vala_doc',
	command: [
		valadoc_exe,
		valadoc_flags + [
			'--package-name', 'vala', '--package-version', meson.project_version(),
			'--vapidir', join_paths(meson.build_root(), 'gee'), '--pkg', 'gee',
		],
		'@INPUT@'
	],
	build_by_default: false,
	depends: gee_doc,
	input: [valacore_sources, valaversion_source],
	output: 'vala-apis',
)

ccode_doc = custom_target('ccode_doc',
	command: [
		valadoc_exe,
		valadoc_flags + [
			'--package-name', 'ccode', '--package-version', meson.project_version(),
			'--vapidir', join_paths(meson.build_root(), 'gee'), '--pkg', 'gee',
			'--vapidir', join_paths(meson.build_root(), 'vala'), '--pkg', 'vala',
		],
		'@INPUT@'
	],
	build_by_default: false,
	depends: [gee_doc, vala_doc],
	input: valaccode_sources,
	output: 'ccode-apis',
)

codegen_doc = custom_target('codegen_doc',
	command: [
		valadoc_exe,
		valadoc_flags + [
			'--package-name', 'codegen', '--package-version', meson.project_version(),
			'--vapidir', join_paths(meson.build_root(), 'gee'), '--pkg', 'gee',
			'--vapidir', join_paths(meson.build_root(), 'vala'), '--pkg', 'vala',
			'--vapidir', join_paths(meson.build_root(), 'ccode'), '--pkg', 'valaccode',
		],
		'@INPUT@'
	],
	build_by_default: false,
	depends: [gee_doc, vala_doc, ccode_doc],
	input: valacodegen_sources,
	output: 'codegen-apis',
)

valadoc_doc = custom_target('valadoc_doc',
	command: [
		valadoc_exe,
		valadoc_flags + [
			'--package-name', 'codegen', '--package-version', meson.project_version(),
			'--pkg', 'libgvc',
			'--vapidir', join_paths(meson.build_root(), 'gee'), '--pkg', 'gee',
			'--vapidir', join_paths(meson.build_root(), 'vala'), '--pkg', 'vala',
			'--vapidir', join_paths(meson.build_root(), 'ccode'), '--pkg', 'valaccode',
			'--vapidir', join_paths(meson.build_root(), 'codegen'), '--pkg', 'valacodegen',
		],
		'@INPUT@'
	],
	build_by_default: false,
	depends: [gee_doc, vala_doc, ccode_doc, codegen_doc],
	input: libvaladoc_sources,
	output: 'valadoc-apis',
)

internal_api_docs = valadoc_doc
endif
