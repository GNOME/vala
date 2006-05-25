NULL =

INCLUDES = \
	$(GLIB_CFLAGS) \
	-I ../ccode \
	$(NULL)

BUILT_SOURCES = parser.h
AM_YFLAGS = -d

noinst_LTLIBRARIES = \
	libvala.la
	$(NULL)

libvala_la_VALASOURCES = \
	valaassignment.vala \
	valaattributeprocessor.vala \
	valaattribute.vala \
	valabinaryexpression.vala \
	valablock.vala \
	valabooleanliteral.vala \
	valabreakstatement.vala \
	valacastexpression.vala \
	valacharacterliteral.vala \
	valaclass.vala \
	valacodecontext.vala \
	valacodegenerator.vala \
	valacodenode.vala \
	valacodevisitor.vala \
	valaconditionalexpression.vala \
	valaconstant.vala \
	valacontinuestatement.vala \
	valadeclarationstatement.vala \
	valaemptystatement.vala \
	valaenum.vala \
	valaenumvalue.vala \
	valaexpressionstatement.vala \
	valaexpression.vala \
	valafield.vala \
	valaforeachstatement.vala \
	valaformalparameter.vala \
	valaforstatement.vala \
	valaifstatement.vala \
	valainitializerlist.vala \
	valaintegerliteral.vala \
	valainterfacewriter.vala \
	valainvocationexpression.vala \
	valaliteralexpression.vala \
	valaliteral.vala \
	valalocalvariabledeclaration.vala \
	valamemberaccessibility.vala \
	valamemberaccess.vala \
	valamethod.vala \
	valanamedargument.vala \
	valanamespacereference.vala \
	valanamespace.vala \
	valanullliteral.vala \
	valaobjectcreationexpression.vala \
	valaparenthesizedexpression.vala \
	valaparser.vala \
	valapostfixexpression.vala \
	valapropertyaccessor.vala \
	valaproperty.vala \
	valareport.vala \
	valareturnstatement.vala \
	valasemanticanalyzer.vala \
	valasimplename.vala \
	valasourcefilecycle.vala \
	valasourcefile.vala \
	valasourcereference.vala \
	valastatement.vala \
	valastringliteral.vala \
	valastruct.vala \
	valasymbolbuilder.vala \
	valasymbolresolver.vala \
	valasymbol.vala \
	valatypecheck.vala \
	valatypeparameter.vala \
	valatypereference.vala \
	valatype.vala \
	valaunaryexpression.vala \
	valavariabledeclarator.vala \
	valawhilestatement.vala \
	$(NULL)

libvala_la_SOURCES = \
	parser.y \
	scanner.l \
	vala.h \
	valaassignment.c \
	valaassignment.h \
	valaattribute.c \
	valaattribute.h \
	valaattributeprocessor.c \
	valaattributeprocessor.h \
	valabinaryexpression.c \
	valabinaryexpression.h \
	valablock.c \
	valablock.h \
	valabooleanliteral.c \
	valabooleanliteral.h \
	valabreakstatement.c \
	valabreakstatement.h \
	valacastexpression.c \
	valacastexpression.h \
	valacharacterliteral.c \
	valacharacterliteral.h \
	valaclass.c \
	valaclass.h \
	valacodecontext.c \
	valacodecontext.h \
	valacodegenerator.c \
	valacodegenerator.h \
	valacodenode.c \
	valacodenode.h \
	valacodevisitor.c \
	valacodevisitor.h \
	valaconditionalexpression.c \
	valaconditionalexpression.h \
	valaconstant.c \
	valaconstant.h \
	valacontinuestatement.c \
	valacontinuestatement.h \
	valadeclarationstatement.c \
	valadeclarationstatement.h \
	valaemptystatement.c \
	valaemptystatement.h \
	valaenum.c \
	valaenum.h \
	valaenumvalue.c \
	valaenumvalue.h \
	valaexpression.c \
	valaexpression.h \
	valaexpressionstatement.c \
	valaexpressionstatement.h \
	valafield.c \
	valafield.h \
	valaforeachstatement.c \
	valaforeachstatement.h \
	valaformalparameter.c \
	valaformalparameter.h \
	valaforstatement.c \
	valaforstatement.h \
	valaifstatement.c \
	valaifstatement.h \
	valainitializerlist.c \
	valainitializerlist.h \
	valaintegerliteral.c \
	valaintegerliteral.h \
	valainterfacewriter.c \
	valainterfacewriter.h \
	valainvocationexpression.c \
	valainvocationexpression.h \
	valaliteral.c \
	valaliteralexpression.c \
	valaliteralexpression.h \
	valaliteral.h \
	valalocalvariabledeclaration.c \
	valalocalvariabledeclaration.h \
	valamemberaccess.c \
	valamemberaccess.h \
	valamemberaccessibility.c \
	valamemberaccessibility.h \
	valamethod.c \
	valamethod.h \
	valanamedargument.c \
	valanamedargument.h \
	valanamespace.c \
	valanamespace.h \
	valanamespacereference.c \
	valanamespacereference.h \
	valanullliteral.c \
	valanullliteral.h \
	valaobjectcreationexpression.c \
	valaobjectcreationexpression.h \
	valaparenthesizedexpression.c \
	valaparenthesizedexpression.h \
	valaparser.c \
	valaparser.h \
	valapostfixexpression.c \
	valapostfixexpression.h \
	valapropertyaccessor.c \
	valapropertyaccessor.h \
	valaproperty.c \
	valaproperty.h \
	valareport.c \
	valareport.h \
	valareturnstatement.c \
	valareturnstatement.h \
	valasemanticanalyzer.c \
	valasemanticanalyzer.h \
	valasimplename.c \
	valasimplename.h \
	valasourcefile.c \
	valasourcefilecycle.c \
	valasourcefilecycle.h \
	valasourcefile.h \
	valasourcereference.c \
	valasourcereference.h \
	valastatement.c \
	valastatement.h \
	valastringliteral.c \
	valastringliteral.h \
	valastruct.c \
	valastruct.h \
	valasymbolbuilder.c \
	valasymbolbuilder.h \
	valasymbol.c \
	valasymbol.h \
	valasymbolresolver.c \
	valasymbolresolver.h \
	valatype.c \
	valatypecheck.c \
	valatypecheck.h \
	valatype.h \
	valatypeparameter.c \
	valatypeparameter.h \
	valatypereference.c \
	valatypereference.h \
	valaunaryexpression.c \
	valaunaryexpression.h \
	valavariabledeclarator.c \
	valavariabledeclarator.h \
	valawhilestatement.c \
	valawhilestatement.h \
	$(NULL)

vala.h: vala.vala

$(subst .vala,.c,$(libvala_la_VALASOURCES)) $(subst .vala,.h,$(libvala_la_VALASOURCES)) vala.vala: $(libvala_la_VALASOURCES)
	$(VALAC) --vapidir $(srcdir)/../vapi --vapidir ../ccode --pkg valaccode --library vala $^

libvala_la_LIBADD = \
	$(GLIB_LIBS) \
	../ccode/libvalaccode.la \
	$(NULL)

EXTRA_DIST = $(libvala_la_VALASOURCES) vala.vala
