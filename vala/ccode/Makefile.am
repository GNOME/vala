NULL =

INCLUDES = \
	$(GLIB_CFLAGS) \
	$(NULL)

noinst_LTLIBRARIES = \
	libvalaccode.la
	$(NULL)

libvalaccode_la_VALASOURCES = \
	valaccodeassignment.vala \
	valaccodebinaryexpression.vala \
	valaccodeblock.vala \
	valaccodebreakstatement.vala \
	valaccodecasestatement.vala \
	valaccodecomment.vala \
	valaccodeconstant.vala \
	valaccodecontinuestatement.vala \
	valaccodedeclaration.vala \
	valaccodedeclarator.vala \
	valaccodeemptystatement.vala \
	valaccodeenum.vala \
	valaccodeexpressionstatement.vala \
	valaccodeexpression.vala \
	valaccodeformalparameter.vala \
	valaccodeforstatement.vala \
	valaccodefragment.vala \
	valaccodefunctioncall.vala \
	valaccodefunctiondeclarator.vala \
	valaccodefunction.vala \
	valaccodeidentifier.vala \
	valaccodeifstatement.vala \
	valaccodeincludedirective.vala \
	valaccodeinitializerlist.vala \
	valaccodemacroreplacement.vala \
	valaccodememberaccess.vala \
	valaccodemodifiers.vala \
	valaccodenewline.vala \
	valaccodenode.vala \
	valaccodeoncesection.vala \
	valaccodeparenthesizedexpression.vala \
	valaccodereturnstatement.vala \
	valaccodestatement.vala \
	valaccodestruct.vala \
	valaccodeswitchstatement.vala \
	valaccodetypedefinition.vala \
	valaccodeunaryexpression.vala \
	valaccodevariabledeclarator.vala \
	valaccodewhilestatement.vala \
	valaccodewriter.vala \
	$(NULL)

libvalaccode_la_SOURCES = \
	valaccodeassignment.c \
	valaccodeassignment.h \
	valaccodebinaryexpression.c \
	valaccodebinaryexpression.h \
	valaccodeblock.c \
	valaccodeblock.h \
	valaccodebreakstatement.c \
	valaccodebreakstatement.h \
	valaccodecasestatement.c \
	valaccodecasestatement.h \
	valaccodecomment.c \
	valaccodecomment.h \
	valaccodeconstant.c \
	valaccodeconstant.h \
	valaccodecontinuestatement.c \
	valaccodecontinuestatement.h \
	valaccodedeclaration.c \
	valaccodedeclaration.h \
	valaccodedeclarator.c \
	valaccodedeclarator.h \
	valaccodeemptystatement.c \
	valaccodeemptystatement.h \
	valaccodeenum.c \
	valaccodeenum.h \
	valaccodeexpression.c \
	valaccodeexpression.h \
	valaccodeexpressionstatement.c \
	valaccodeexpressionstatement.h \
	valaccodeformalparameter.c \
	valaccodeformalparameter.h \
	valaccodeforstatement.c \
	valaccodeforstatement.h \
	valaccodefragment.c \
	valaccodefragment.h \
	valaccodefunction.c \
	valaccodefunctioncall.c \
	valaccodefunctioncall.h \
	valaccodefunctiondeclarator.c \
	valaccodefunctiondeclarator.h \
	valaccodefunction.h \
	valaccodeidentifier.c \
	valaccodeidentifier.h \
	valaccodeifstatement.c \
	valaccodeifstatement.h \
	valaccodeincludedirective.c \
	valaccodeincludedirective.h \
	valaccodeinitializerlist.c \
	valaccodeinitializerlist.h \
	valaccodemacroreplacement.c \
	valaccodemacroreplacement.h \
	valaccodememberaccess.c \
	valaccodememberaccess.h \
	valaccodemodifiers.c \
	valaccodemodifiers.h \
	valaccodenewline.c \
	valaccodenewline.h \
	valaccodenode.c \
	valaccodenode.h \
	valaccodeoncesection.c \
	valaccodeoncesection.h \
	valaccodeparenthesizedexpression.c \
	valaccodeparenthesizedexpression.h \
	valaccodereturnstatement.c \
	valaccodereturnstatement.h \
	valaccodestatement.c \
	valaccodestatement.h \
	valaccodestruct.c \
	valaccodestruct.h \
	valaccodeswitchstatement.c \
	valaccodeswitchstatement.h \
	valaccodetypedefinition.c \
	valaccodetypedefinition.h \
	valaccodeunaryexpression.c \
	valaccodeunaryexpression.h \
	valaccodevariabledeclarator.c \
	valaccodevariabledeclarator.h \
	valaccodewhilestatement.c \
	valaccodewhilestatement.h \
	valaccodewriter.c \
	valaccodewriter.h \
	$(NULL)

$(subst .vala,.c,$(libvalaccode_la_VALASOURCES)) $(subst .vala,.h,$(libvalaccode_la_VALASOURCES)) valaccode.vala: $(libvalaccode_la_VALASOURCES)
	$(VALAC) --vapidir $(srcdir)/../vapi --library valaccode $^

libvalaccode_la_LIBADD = \
	$(GLIB_LIBS) \
	$(NULL)

EXTRA_DIST = $(libvalaccode_la_VALASOURCES) valaccode.vala
