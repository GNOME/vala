inc_libvalaccodeh = include_directories ('.')
inc_libvalaccodeh_dep = declare_dependency (include_directories : inc_libvalaccodeh)

valaccode_sources = [
	'valaccodeassignment.vala',
	'valaccodebinaryexpression.vala',
	'valaccodeblock.vala',
	'valaccodebreakstatement.vala',
	'valaccodecasestatement.vala',
	'valaccodecastexpression.vala',
	'valaccodecommaexpression.vala',
	'valaccodecomment.vala',
	'valaccodeconditionalexpression.vala',
	'valaccodeconstant.vala',
	'valaccodecontinuestatement.vala',
	'valaccodedeclaration.vala',
	'valaccodedeclarator.vala',
	'valaccodedefine.vala',
	'valaccodedostatement.vala',
	'valaccodeelementaccess.vala',
	'valaccodeemptystatement.vala',
	'valaccodeenum.vala',
	'valaccodeenumvalue.vala',
	'valaccodeexpressionstatement.vala',
	'valaccodeexpression.vala',
	'valaccodefile.vala',
	'valaccodeforstatement.vala',
	'valaccodefragment.vala',
	'valaccodefunctioncall.vala',
	'valaccodefunctiondeclarator.vala',
	'valaccodefunction.vala',
	'valaccodeggnucsection.vala',
	'valaccodegotostatement.vala',
	'valaccodeidentifier.vala',
	'valaccodeifsection.vala',
	'valaccodeifstatement.vala',
	'valaccodeincludedirective.vala',
	'valaccodeinitializerlist.vala',
	'valaccodeinvalidexpression.vala',
	'valaccodelabel.vala',
	'valaccodelinedirective.vala',
	'valaccodemacroreplacement.vala',
	'valaccodememberaccess.vala',
	'valaccodemodifiers.vala',
	'valaccodenewline.vala',
	'valaccodenode.vala',
	'valaccodeoncesection.vala',
	'valaccodeparameter.vala',
	'valaccodeparenthesizedexpression.vala',
	'valaccodereturnstatement.vala',
	'valaccodestatement.vala',
	'valaccodestruct.vala',
	'valaccodeswitchstatement.vala',
	'valaccodetypedefinition.vala',
	'valaccodeunaryexpression.vala',
	'valaccodevariabledeclarator.vala',
	'valaccodewhilestatement.vala',
	'valaccodewriter.vala'
]

valaccode_sources_c = []

foreach f : valaccode_sources
	if get_option ('bootstrap')
		af = f.split('.vala')
		nf = join_paths (meson.current_source_dir (), af[0] + '.c')
		valaccode_sources_c += nf
	endif
endforeach

