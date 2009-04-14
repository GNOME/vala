NULL =

AM_CPPFLAGS = \
	-I$(top_srcdir)/gee \
	-I$(top_srcdir)/ccode \
	$(GLIB_CFLAGS) \
	-include config.h \
	-DPACKAGE_DATADIR=\"$(pkgdatadir)\" \
	$(NULL)

BUILT_SOURCES = vala.vala.stamp

noinst_LTLIBRARIES = \
	libvalacore.la
	$(NULL)

libvalacore_la_VALASOURCES = \
	valaaddressofexpression.vala \
	valaarraycreationexpression.vala \
	valaarraylengthfield.vala \
	valaarraymovemethod.vala \
	valaarrayresizemethod.vala \
	valaarraytype.vala \
	valaassignment.vala \
	valaattribute.vala \
	valabaseaccess.vala \
	valabasicblock.vala \
	valabinaryexpression.vala \
	valablock.vala \
	valabooleanliteral.vala \
	valabooleantype.vala \
	valabreakstatement.vala \
	valacastexpression.vala \
	valacatchclause.vala \
	valacharacterliteral.vala \
	valaclass.vala \
	valaclasstype.vala \
	valacodecontext.vala \
	valacodegenerator.vala \
	valacodenode.vala \
	valacodevisitor.vala \
	valacodewriter.vala \
	valaconditionalexpression.vala \
	valaconstant.vala \
	valaconstructor.vala \
	valacontinuestatement.vala \
	valacreationmethod.vala \
	valadatatype.vala \
	valadeclarationstatement.vala \
	valadelegate.vala \
	valadelegatetype.vala \
	valadeletestatement.vala \
	valadestructor.vala \
	valadostatement.vala \
	valadynamicmethod.vala \
	valadynamicproperty.vala \
	valadynamicsignal.vala \
	valaelementaccess.vala \
	valaemptystatement.vala \
	valaenum.vala \
	valaenumvalue.vala \
	valaenumvaluetype.vala \
	valaerrorcode.vala \
	valaerrordomain.vala \
	valaerrortype.vala \
	valaexpression.vala \
	valaexpressionstatement.vala \
	valafield.vala \
	valafieldprototype.vala \
	valafloatingtype.vala \
	valaflowanalyzer.vala \
	valaforeachstatement.vala \
	valaformalparameter.vala \
	valaforstatement.vala \
	valagenerictype.vala \
	valagenieparser.vala \
	valageniescanner.vala \
	valagenietokentype.vala \
	valaifstatement.vala \
	valainitializerlist.vala \
	valainstancecast.vala \
	valaintegerliteral.vala \
	valaintegertype.vala \
	valainterface.vala \
	valainterfacetype.vala \
	valainvalidtype.vala \
	valalambdaexpression.vala \
	valaliteral.vala \
	valalocalvariable.vala \
	valalockable.vala \
	valalockstatement.vala \
	valamember.vala \
	valamemberaccess.vala \
	valamemberinitializer.vala \
	valamethod.vala \
	valamethodcall.vala \
	valamethodtype.vala \
	valanamespace.vala \
	valanullchecker.vala \
	valanullliteral.vala \
	valanulltype.vala \
	valaobjectcreationexpression.vala \
	valaobjecttype.vala \
	valaobjecttypesymbol.vala \
	valaparser.vala \
	valaphifunction.vala \
	valapointerindirection.vala \
	valapointertype.vala \
	valapostfixexpression.vala \
	valapropertyaccessor.vala \
	valaproperty.vala \
	valarealliteral.vala \
	valareferencetransferexpression.vala \
	valareferencetype.vala \
	valareport.vala \
	valareturnstatement.vala \
	valascanner.vala \
	valascope.vala \
	valasemanticanalyzer.vala \
	valasignal.vala \
	valasignaltype.vala \
	valasizeofexpression.vala \
	valasourcefile.vala \
	valasourcelocation.vala \
	valasourcereference.vala \
	valastatement.vala \
	valastatementlist.vala \
	valastringliteral.vala \
	valastruct.vala \
	valastructvaluetype.vala \
	valaswitchlabel.vala \
	valaswitchsection.vala \
	valaswitchstatement.vala \
	valasymbol.vala \
	valasymbolresolver.vala \
	valathrowstatement.vala \
	valatokentype.vala \
	valatrystatement.vala \
	valatuple.vala \
	valatypecheck.vala \
	valatypeofexpression.vala \
	valatypeparameter.vala \
	valatypesymbol.vala \
	valaunaryexpression.vala \
	valaunresolvedsymbol.vala \
	valaunresolvedtype.vala \
	valausingdirective.vala \
	valavaluetype.vala \
	valavoidtype.vala \
	valawhilestatement.vala \
	valayieldstatement.vala \
	$(NULL)

libvalacore_la_SOURCES = \
	vala.vala.stamp \
	$(libvalacore_la_VALASOURCES:.vala=.c) \
	$(NULL)

valaincludedir = $(includedir)/vala-1.0

valainclude_HEADERS = \
	vala.h \
	$(NULL)

vala.vapi vala.vala.stamp: $(libvalacore_la_VALASOURCES)
	$(VALAC) -C --vapidir $(srcdir)/../vapi --pkg gobject-2.0 --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --pkg config -H vala.h --library vala $^
	touch $@

libvalacore_la_LIBADD = \
	$(GLIB_LIBS) \
	../gee/libgee.la \
	../ccode/libvalaccode.la \
	$(NULL)

EXTRA_DIST = $(libvalacore_la_VALASOURCES) vala.vapi vala.vala.stamp

MAINTAINERCLEANFILES = \
	vala.vapi \
	vala.h \
	$(libvalacore_la_VALASOURCES:.vala=.c) \
	$(NULL)

