valacodegen_sources = files(
	'valaccode.vala',
	'valaccodearraymodule.vala',
	'valaccodeassignmentmodule.vala',
	'valaccodeattribute.vala',
	'valaccodebasemodule.vala',
	'valaccodecompiler.vala',
	'valaccodecontrolflowmodule.vala',
	'valaccodedelegatemodule.vala',
	'valaccodememberaccessmodule.vala',
	'valaccodemethodcallmodule.vala',
	'valaccodemethodmodule.vala',
	'valaccodestructmodule.vala',
	'valaclassregisterfunction.vala',
	'valactype.vala',
	'valaenumregisterfunction.vala',
	'valagasyncmodule.vala',
	'valagdbusclientmodule.vala',
	'valagdbusmodule.vala',
	'valagdbusservermodule.vala',
	'valagerrormodule.vala',
	'valagirwriter.vala',
	'valaglibvalue.vala',
	'valagobjectmodule.vala',
	'valagsignalmodule.vala',
	'valagtkmodule.vala',
	'valagtypemodule.vala',
	'valagvaluemodule.vala',
	'valagvariantmodule.vala',
	'valainterfaceregisterfunction.vala',
	'valastructregisterfunction.vala',
	'valatyperegisterfunction.vala',
)

valacodegen_lib = library(
	'valacodegen',
	valacodegen_sources,
	dependencies: [gobject_dep, valacore_dep, valaccode_dep],
	install_rpath: pkglibdir,
	install_dir: pkglibdir,
	install: [ true, false, false ],
	vala_header: 'valacodegen.h',
	vala_vapi: 'valacodegen.vapi',
)

if cc.get_argument_syntax() == 'msvc' and \
   get_option('default_library') == 'shared'
	meson.add_install_script('cmd', '/c', 'cd /d @0@ & (if exist @2@.dll del @2@.dll) & mklink @2@.dll @1@\@2@.dll'.format(join_paths(get_option('prefix'), get_option('bindir')).replace('/','\\'), pkglibdir.replace('/', '\\'), 'valacodegen'))
endif

valacodegen_dep = declare_dependency(
	link_with: [valacodegen_lib],
	dependencies: [valacore_dep, valaccode_dep],
	include_directories: include_directories('.'),
)
