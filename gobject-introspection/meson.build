gidl_sources = files(
	'gidlmodule.c',
	'gidlnode.c',
	'gidlparser.c',
	'gmetadata.c',
)

gidl_lib = static_library('gidl',
	gidl_sources,
	dependencies: [gobject_dep, gmodule_dep])

gidl_dep = declare_dependency(
	link_with: [gidl_lib],
	include_directories: include_directories('.'),
)

flex = find_program('flex', 'win_flex')
bison = find_program('bison', 'win_bison')

lgen = generator(flex,
	output: '@PLAINNAME@.c',
	arguments: ['-o', '@OUTPUT@', '@INPUT@'])

lfiles = lgen.process('scannerlexer.l')

pgen = generator(bison,
	output: ['@BASENAME@.c', '@BASENAME@.h'],
	arguments: ['@INPUT@', '--defines=@OUTPUT1@', '--output=@OUTPUT0@'],
)

pfiles = pgen.process('scannerparser.y')

gen_introspect_sources = files(
	'gidlwriter.c',
	'scanner.c',
)

extra_gen_introspect_c_args = []

if cc.get_argument_syntax() == 'msvc'
	extra_gen_introspect_c_args += '-DYY_NO_UNISTD_H'
endif

gen_introspect_name = 'gen-introspect@0@'.format(vala_version_suffix)

gen_introspect_exe = executable(gen_introspect_name,
	[gen_introspect_sources, lfiles, pfiles],
	c_args: extra_gen_introspect_c_args,
	install: true,
	install_dir: pkglibdir,
	dependencies: [gobject_dep, gmodule_dep, gidl_dep],
)
