NULL =

INCLUDES = \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = valaccode.vala.stamp

noinst_LTLIBRARIES = \
	libvalaccode.la
	$(NULL)

libvalaccode_la_VALASOURCES = \
	$(NULL)

libvalaccode_la_SOURCES = \
	valaccode.vala.stamp \
	valaccodeassignment.c \
	valaccodeassignment.h \
	valaccodeassignment.vala \
	valaccodebinaryexpression.c \
	valaccodebinaryexpression.h \
	valaccodebinaryexpression.vala \
	valaccodeblock.c \
	valaccodeblock.h \
	valaccodeblock.vala \
	valaccodebreakstatement.c \
	valaccodebreakstatement.h \
	valaccodebreakstatement.vala \
	valaccodecasestatement.c \
	valaccodecasestatement.h \
	valaccodecasestatement.vala \
	valaccodecomment.c \
	valaccodecomment.h \
	valaccodecomment.vala \
	valaccodeconstant.c \
	valaccodeconstant.h \
	valaccodeconstant.vala \
	valaccodecontinuestatement.c \
	valaccodecontinuestatement.h \
	valaccodecontinuestatement.vala \
	valaccodedeclaration.c \
	valaccodedeclaration.h \
	valaccodedeclaration.vala \
	valaccodedeclarator.c \
	valaccodedeclarator.h \
	valaccodedeclarator.vala \
	valaccodeemptystatement.c \
	valaccodeemptystatement.h \
	valaccodeemptystatement.vala \
	valaccodeenum.c \
	valaccodeenum.h \
	valaccodeenum.vala \
	valaccodeexpression.c \
	valaccodeexpression.h \
	valaccodeexpression.vala \
	valaccodeexpressionstatement.c \
	valaccodeexpressionstatement.h \
	valaccodeexpressionstatement.vala \
	valaccodeformalparameter.c \
	valaccodeformalparameter.h \
	valaccodeformalparameter.vala \
	valaccodeforstatement.c \
	valaccodeforstatement.h \
	valaccodeforstatement.vala \
	valaccodefragment.c \
	valaccodefragment.h \
	valaccodefragment.vala \
	valaccodefunction.c \
	valaccodefunction.h \
	valaccodefunction.vala \
	valaccodefunctioncall.c \
	valaccodefunctioncall.h \
	valaccodefunctioncall.vala \
	valaccodefunctiondeclarator.c \
	valaccodefunctiondeclarator.h \
	valaccodefunctiondeclarator.vala \
	valaccodeidentifier.c \
	valaccodeidentifier.h \
	valaccodeidentifier.vala \
	valaccodeifstatement.c \
	valaccodeifstatement.h \
	valaccodeifstatement.vala \
	valaccodeincludedirective.c \
	valaccodeincludedirective.h \
	valaccodeincludedirective.vala \
	valaccodeinitializerlist.c \
	valaccodeinitializerlist.h \
	valaccodeinitializerlist.vala \
	valaccodemacroreplacement.c \
	valaccodemacroreplacement.h \
	valaccodemacroreplacement.vala \
	valaccodememberaccess.c \
	valaccodememberaccess.h \
	valaccodememberaccess.vala \
	valaccodemodifiers.c \
	valaccodemodifiers.h \
	valaccodemodifiers.vala \
	valaccodenewline.c \
	valaccodenewline.h \
	valaccodenewline.vala \
	valaccodenode.c \
	valaccodenode.h \
	valaccodenode.vala \
	valaccodeoncesection.c \
	valaccodeoncesection.h \
	valaccodeoncesection.vala \
	valaccodeparenthesizedexpression.c \
	valaccodeparenthesizedexpression.h \
	valaccodeparenthesizedexpression.vala \
	valaccodereturnstatement.c \
	valaccodereturnstatement.h \
	valaccodereturnstatement.vala \
	valaccodestatement.c \
	valaccodestatement.h \
	valaccodestatement.vala \
	valaccodestruct.c \
	valaccodestruct.h \
	valaccodestruct.vala \
	valaccodeswitchstatement.c \
	valaccodeswitchstatement.h \
	valaccodeswitchstatement.vala \
	valaccodetypedefinition.c \
	valaccodetypedefinition.h \
	valaccodetypedefinition.vala \
	valaccodeunaryexpression.c \
	valaccodeunaryexpression.h \
	valaccodeunaryexpression.vala \
	valaccodevariabledeclarator.c \
	valaccodevariabledeclarator.h \
	valaccodevariabledeclarator.vala \
	valaccodewhilestatement.c \
	valaccodewhilestatement.h \
	valaccodewhilestatement.vala \
	valaccodewriter.c \
	valaccodewriter.h \
	valaccodewriter.vala \
	$(NULL)

valaccode.vala valaccode.vala.stamp: $(filter %.vala,$(libvalaccode_la_SOURCES))
	$(VALAC) --vapidir $(srcdir)/../vapi --library valaccode $^
	touch $@

libvalaccode_la_LIBADD = \
	$(GLIB_LIBS) \
	$(NULL)

EXTRA_DIST = valaccode.vala valaccode.vala.stamp
