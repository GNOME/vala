include $(top_srcdir)/Makefile.common

NULL =

AM_CPPFLAGS = \
	-DG_LOG_DOMAIN=\"vala-ccode\" \
	$(COVERAGE_CFLAGS) \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/vala \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = ccode.vala.stamp

noinst_LTLIBRARIES = \
	libvalaccode.la \
	$(NULL)

libvalaccode_la_VALASOURCES = \
	valaccode.vala \
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
	valaccodeconstantidentifier.vala \
	valaccodecontinuestatement.vala \
	valaccodedeclaration.vala \
	valaccodedeclarator.vala \
	valaccodedefine.vala \
	valaccodedostatement.vala \
	valaccodeemptystatement.vala \
	valaccodeenum.vala \
	valaccodeenumvalue.vala \
	valaccodeexpression.vala \
	valaccodeexpressionstatement.vala \
	valaccodefile.vala \
	valaccodeforstatement.vala \
	valaccodefragment.vala \
	valaccodefunction.vala \
	valaccodefunctioncall.vala \
	valaccodefunctiondeclarator.vala \
	valaccodeggnucsection.vala \
	valaccodegotostatement.vala \
	valaccodeidentifier.vala \
	valaccodeifstatement.vala \
	valaccodeincludedirective.vala \
	valaccodeinitializerlist.vala \
	valaccodeinvalidexpression.vala \
	valaccodelabel.vala \
	valaccodelinedirective.vala \
	valaccodeifsection.vala \
	valaccodemacroreplacement.vala \
	valaccodememberaccess.vala \
	valaccodemodifiers.vala \
	valaccodenewline.vala \
	valaccodenode.vala \
	valaccodeoncesection.vala \
	valaccodeparameter.vala \
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

ccode.vapi ccode.vala.stamp: $(libvalaccode_la_VALASOURCES)
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		-C \
		--vapidir $(top_srcdir)/vapi --pkg gobject-2.0 \
		--vapidir $(top_srcdir)/gee --pkg gee \
		--vapidir $(top_srcdir)/vala --pkg vala \
		--pkg config \
		-H valaccode.h \
		--library ccode \
		$^
	touch $@

libvalaccode_la_LIBADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(top_builddir)/vala/libvala@PACKAGE_SUFFIX@.la \
	$(NULL)

EXTRA_DIST = $(libvalaccode_la_VALASOURCES) ccode.vapi ccode.vala.stamp valaccode.h

MAINTAINERCLEANFILES = \
	ccode.vapi \
	valaccode.h \
	$(libvalaccode_la_VALASOURCES:.vala=.c) \
	$(NULL)
