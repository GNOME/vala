NULL =

AM_CPPFLAGS = \
	-I$(top_srcdir) \
	$(GLIB_CFLAGS) \
	$(NULL)

BUILT_SOURCES = parser.h vala.vala.stamp
AM_YFLAGS = -d

noinst_LTLIBRARIES = \
	libvalacore.la
	$(NULL)

libvalacore_la_VALASOURCES = \
	valaaddressofexpression.vala \
	valaarray.vala \
	valaarraycreationexpression.vala \
	valaarraylengthfield.vala \
	valaarraymovemethod.vala \
	valaarrayresizemethod.vala \
	valaassignment.vala \
	valaattribute.vala \
	valaattributeprocessor.vala \
	valabaseaccess.vala \
	valabinaryexpression.vala \
	valabindingprovider.vala \
	valablock.vala \
	valabooleanliteral.vala \
	valabreakstatement.vala \
	valacallback.vala \
	valacastexpression.vala \
	valacatchclause.vala \
	valacharacterliteral.vala \
	valaclass.vala \
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
	valadeclarationstatement.vala \
	valadestructor.vala \
	valadostatement.vala \
	valaelementaccess.vala \
	valaemptystatement.vala \
	valaenum.vala \
	valaenumvalue.vala \
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
	valainterface.vala \
	valainterfacewriter.vala \
	valainvocationexpression.vala \
	valainvokable.vala \
	valalambdaexpression.vala \
	valaliteral.vala \
	valaliteralexpression.vala \
	valalocalvariabledeclaration.vala \
	valalockable.vala \
	valalockstatement.vala \
	valamember.vala \
	valamemberaccess.vala \
	valamemberinitializer.vala \
	valamemorymanager.vala \
	valamethod.vala \
	valanamedargument.vala \
	valanamespace.vala \
	valanamespacereference.vala \
	valanullliteral.vala \
	valaobjectcreationexpression.vala \
	valaparenthesizedexpression.vala \
	valaparser.vala \
	valapointer.vala \
	valapointerindirection.vala \
	valapostfixexpression.vala \
	valapropertyaccessor.vala \
	valaproperty.vala \
	valarealliteral.vala \
	valareferencetransferexpression.vala \
	valareport.vala \
	valareturnstatement.vala \
	valascope.vala \
	valasemanticanalyzer.vala \
	valasignal.vala \
	valasizeofexpression.vala \
	valasourcefile.vala \
	valasourcefilecycle.vala \
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
	valatrystatement.vala \
	valatypecheck.vala \
	valatypeofexpression.vala \
	valatypeparameter.vala \
	valatypereference.vala \
	valatypesymbol.vala \
	valaunaryexpression.vala \
	valavariabledeclarator.vala \
	valawhilestatement.vala \
	$(NULL)

libvalacore_la_SOURCES = \
	parser.y \
	scanner.l \
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
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../gee --pkg gee --vapidir ../ccode --pkg ccode --basedir $(top_srcdir) --library vala $^
	touch $@

libvalacore_la_LIBADD = \
	$(GLIB_LIBS) \
	../gee/libgee.la \
	../ccode/libvalaccode.la \
	$(NULL)

EXTRA_DIST = $(libvalacore_la_VALASOURCES) vala.vapi vala.vala.stamp
