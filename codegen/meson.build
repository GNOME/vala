inc_libvalacodegenh = include_directories ('.')
inc_libvalacodegenh_dep = declare_dependency (include_directories : inc_libvalacodegenh)

valacodegen_sources = [
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
	'valagobjectmodule.vala',
	'valagsignalmodule.vala',
	'valagtkmodule.vala',
	'valagtypemodule.vala',
	'valagvariantmodule.vala',
	'valainterfaceregisterfunction.vala',
	'valastructregisterfunction.vala',
	'valatyperegisterfunction.vala',
]

valacodegen_sources_c = []

foreach f : valacodegen_sources
	if get_option ('bootstrap')
		af = f.split('.vala')
		nf = join_paths (meson.current_source_dir (), af[0] + '.c')
		valacodegen_sources_c += nf
	endif
endforeach

