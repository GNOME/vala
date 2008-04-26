NULL =

AM_CPPFLAGS = \
	-I$(top_srcdir) \
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
	valaattributeprocessor.vala \
	valabaseaccess.vala \
	valabasicblock.vala \
	valabinaryexpression.vala \
	valablock.vala \
	valabooleanliteral.vala \
	valabreakstatement.vala \
	valacastexpression.vala \
	valacatchclause.vala \
	valacfgbuilder.vala \
	valacharacterliteral.vala \
	valaclass.vala \
	valaclassinstancetype.vala \
	valaclasstype.vala \
	valacodebinding.vala \
	valacodecontext.vala \
	valacodegenerator.vala \
	valacodenode.vala \
	valacodevisitor.vala \
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
	valadynamicsignal.vala \
	valaelementaccess.vala \
	valaemptystatement.vala \
	valaenum.vala \
	valaenumvalue.vala \
	valaerrorcode.vala \
	valaerrordomain.vala \
	valaerrortype.vala \
	valaexpression.vala \
	valaexpressionstatement.vala \
	valafield.vala \
	valaforeachstatement.vala \
	valaformalparameter.vala \
	valaforstatement.vala \
	valaifstatement.vala \
	valainitializerlist.vala \
	valainstancecast.vala \
	valaintegerliteral.vala \
	valaintegertype.vala \
	valainterface.vala \
	valainterfaceinstancetype.vala \
	valainterfacetype.vala \
	valainterfacewriter.vala \
	valainvalidtype.vala \
	valainvocationexpression.vala \
	valalambdaexpression.vala \
	valaliteral.vala \
	valalocalvariable.vala \
	valalockable.vala \
	valalockstatement.vala \
	valamember.vala \
	valamemberaccess.vala \
	valamemberinitializer.vala \
	valamemorymanager.vala \
	valamethod.vala \
	valamethodtype.vala \
	valanamedargument.vala \
	valanamespace.vala \
	valanamespacereference.vala \
	valanullchecker.vala \
	valanullliteral.vala \
	valanulltype.vala \
	valaobjectcreationexpression.vala \
	valaparenthesizedexpression.vala \
	valaparser.vala \
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
	valasourcefilecycle.vala \
	valasourcelocation.vala \
	valasourcereference.vala \
	valastatement.vala \
	valastringliteral.vala \
	valastruct.vala \
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
	valatypeparametertype.vala \
	valatypesymbol.vala \
	valaunaryexpression.vala \
	valaunresolvedsymbol.vala \
	valaunresolvedtype.vala \
	valavaluetype.vala \
	valavoidtype.vala \
	valawhilestatement.vala \
	$(NULL)

libvalacore_la_SOURCES = \
	vala.h \
	vala.vala.stamp \
	$(libvalacore_la_VALASOURCES:.vala=.c) \
	$(libvalacore_la_VALASOURCES:.vala=.h) \
	$(NULL)

valaincludedir = $(includedir)/vala-1.0/vala

valainclude_HEADERS = \
	vala.h \
	$(libvalacore_la_VALASOURCES:.vala=.h) \
	$(NULL)

vala.vapi vala.vala.stamp: $(libvalacore_la_VALASOURCES)
	$(VALAC) -C --vapidir $(srcdir)/../vapi --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --pkg config --basedir $(top_srcdir) --library vala $^
	touch $@

libvalacore_la_LIBADD = \
	$(GLIB_LIBS) \
	../gee/libgee.la \
	../ccode/libvalaccode.la \
	$(NULL)

EXTRA_DIST = $(libvalacore_la_VALASOURCES) vala.vapi vala.vala.stamp
