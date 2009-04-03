NULL =

AM_CPPFLAGS = \
	-I$(top_srcdir)/gee \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = ccode.vala.stamp

noinst_LTLIBRARIES = \
	libvalaccode.la
	$(NULL)

libvalaccode_la_VALASOURCES = \
	valaccodeassignment.vala \
	valaccodebinaryexpression.vala \
	valaccodeblock.vala \
	valaccodebreakstatement.vala \
	valaccodecasestatement.vala \
	valaccodecastexpression.vala \
	valaccodecommaexpression.vala \
	valaccodecomment.vala \
	valaccodeconditionalexpression.vala \
	valaccodeconstant.vala \
	valaccodecontinuestatement.vala \
	valaccodedeclaration.vala \
	valaccodedeclarator.vala \
	valaccodedostatement.vala \
	valaccodeemptystatement.vala \
	valaccodeenum.vala \
	valaccodeenumvalue.vala \
	valaccodeexpression.vala \
	valaccodeexpressionstatement.vala \
	valaccodeformalparameter.vala \
	valaccodeforstatement.vala \
	valaccodefragment.vala \
	valaccodefunction.vala \
	valaccodefunctioncall.vala \
	valaccodefunctiondeclarator.vala \
	valaccodegotostatement.vala \
	valaccodeidentifier.vala \
	valaccodeifstatement.vala \
	valaccodeincludedirective.vala \
	valaccodeinitializerlist.vala \
	valaccodelabel.vala \
	valaccodelinedirective.vala \
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
	valaccodeelementaccess.vala \
	$(NULL)

libvalaccode_la_SOURCES = \
	ccode.vala.stamp \
	$(libvalaccode_la_VALASOURCES:.vala=.c) \
	$(NULL)

ccodeincludedir = $(includedir)/vala-1.0

ccodeinclude_HEADERS = \
	valaccode.h \
	$(NULL)

ccode.vapi ccode.vala.stamp: $(libvalaccode_la_VALASOURCES)
	$(VALAC) -C --vapidir $(srcdir)/../vapi --pkg gobject-2.0 --vapidir ../gee --pkg gee -H valaccode.h --library ccode $^
	touch $@

libvalaccode_la_LIBADD = \
	$(GLIB_LIBS) \
	$(NULL)

EXTRA_DIST = $(libvalaccode_la_VALASOURCES) ccode.vapi ccode.vala.stamp
