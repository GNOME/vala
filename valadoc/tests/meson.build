test_cases = [
	'libvaladoc/errorreporter.vala',
	'libvaladoc/gtkdoc-scanner.vala',
	'libvaladoc/markupreader.vala',
	'libvaladoc/parser-manyrule.vala',
	'libvaladoc/parser-oneofrule.vala',
	'libvaladoc/parser-optionalrule.vala',
	'libvaladoc/parser-sequencerule.vala',
	'libvaladoc/parser-stubrule.vala',
]

vala_flags = [
	'-X', '-DTOP_SRC_DIR="@0@"'.format(meson.source_root()),
	'--vapidir', join_paths(meson.source_root(), 'vapi'),
	'--pkg', 'gio-2.0',
	'--disable-warnings',
	'--main', 'main', '--save-temps',
	'--cc', cc.cmd_array()[-1],
	'-X', '-g',
	'-X', '-O0',
	'-X', '-pipe',
	'-X', '-lm',
	'--pkg', 'libgvc',
	'--vapidir', join_paths(meson.build_root(), 'vala'),
	'--pkg', 'libvala@0@'.format(vala_version_suffix),
	'--vapidir', join_paths(meson.build_root(), 'libvaladoc'),
	'--pkg', 'valadoc@0@'.format(vala_version_suffix),
	'-X', '-L' + join_paths(meson.build_root(), 'vala'),
	'-X', '-lvala@0@'.format(vala_version_suffix),
	'-X', '-L' + join_paths(meson.build_root(), 'libvaladoc'),
	'-X', '-lvaladoc@0@'.format(vala_version_suffix),
	'-X', '-L' + join_paths(meson.build_root(), 'libvaladoc'),
	'-X', '-lvaladoc@0@'.format(vala_version_suffix),
	'-X', '-I' + join_paths(meson.build_root(), 'gee'),
	'-X', '-I' + join_paths(meson.build_root(), 'vala'),
	'-X', '-I' + join_paths(meson.build_root(), 'libvaladoc'),
	join_paths(meson.source_root(), 'valadoc', 'tests', 'libvaladoc', 'parser-generic-scanner.vala'),
]

test_envars = [
	'G_DEBUG=fatal-warnings',
	'LD_LIBRARY_PATH=' + join_paths(meson.build_root(), 'vala') + ':' + join_paths(meson.build_root(), 'codegen') + ':' + join_paths(meson.build_root(), 'libvaladoc'),
]

foreach flag : supported_test_cflags
	vala_flags += ['-X', flag]
endforeach

foreach case : test_cases
	test(case,
		valac_exe,
		workdir: meson.current_build_dir(),
		args: vala_flags + [join_paths(meson.current_source_dir(), case)],
		env: test_envars,
		depends: [valacore_lib, libvaladoc_lib]
	)
endforeach

driver_exe = executable('driver',
	files(
		'drivers/driver-test.vala',
		'drivers/generic-api-test.vala',
		join_paths(meson.source_root(), 'valadoc/girwriter.vala'),
		join_paths(meson.source_root(), 'valadoc/initializerbuilder.vala'),
		join_paths(meson.source_root(), 'valadoc/symbolresolver.vala'),
		join_paths(meson.source_root(), 'valadoc/treebuilder.vala'),
	),
	c_args: '-DTOP_SRC_DIR="@0@"'.format(meson.source_root()),
	dependencies: [gobject_dep, valacodegen_dep, libvaladoc_dep],
	install: false,
)

test('valadoc/driver',
	driver_exe,
	workdir: meson.current_build_dir(),
)
