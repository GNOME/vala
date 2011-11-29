NULL =

AM_CPPFLAGS = \
	$(COVERAGE_CFLAGS) \
	-I$(top_srcdir)/gee \
	$(GLIB_CFLAGS) \
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
	valacomment.vala \
	valagircomment.vala \
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
	valaforstatement.vala \
	valagirparser.vala \
	valagenerictype.vala \
	valagenieparser.vala \
	valageniescanner.vala \
	valagenietokentype.vala \
	valaifstatement.vala \
	valainitializerlist.vala \
	valaintegerliteral.vala \
	valaintegertype.vala \
	valainterface.vala \
	valainterfacetype.vala \
	valainvalidtype.vala \
	valalambdaexpression.vala \
	valalistliteral.vala \
	valaliteral.vala \
	valalocalvariable.vala \
	valalockable.vala \
	valalockstatement.vala \
	valaloop.vala \
	valamapliteral.vala \
	valamarkupreader.vala \
	valamemberaccess.vala \
	valamemberinitializer.vala \
	valamethod.vala \
	valamethodcall.vala \
	valamethodtype.vala \
	valanamedargument.vala \
	valanamespace.vala \
	valanullliteral.vala \
	valanulltype.vala \
	valaobjectcreationexpression.vala \
	valaobjecttype.vala \
	valaobjecttypesymbol.vala \
	valaparameter.vala \
	valaparser.vala \
	valaphifunction.vala \
	valapointerindirection.vala \
	valapointertype.vala \
	valapostfixexpression.vala \
	valaprofile.vala \
	valapropertyaccessor.vala \
	valaproperty.vala \
	valarealliteral.vala \
	valareferencetransferexpression.vala \
	valareferencetype.vala \
	valaregexliteral.vala \
	valareport.vala \
	valareturnstatement.vala \
	valascanner.vala \
	valascope.vala \
	valasemanticanalyzer.vala \
	valasetliteral.vala \
	valasignal.vala \
	valasignaltype.vala \
	valasizeofexpression.vala \
	valasliceexpression.vala \
	valasourcefile.vala \
	valasourcelocation.vala \
	valasourcereference.vala \
	valastatement.vala \
	valastatementlist.vala \
	valastringliteral.vala \
	valastruct.vala \
	valastructvaluetype.vala \
	valasubroutine.vala \
	valaswitchlabel.vala \
	valaswitchsection.vala \
	valaswitchstatement.vala \
	valasymbol.vala \
	valasymbolresolver.vala \
	valatargetvalue.vala \
	valatemplate.vala \
	valathrowstatement.vala \
	valatokentype.vala \
	valatrystatement.vala \
	valatuple.vala \
	valatypecheck.vala \
	valatypeofexpression.vala \
	valatypeparameter.vala \
	valatypesymbol.vala \
	valaunaryexpression.vala \
	valaunlockstatement.vala \
	valaunresolvedsymbol.vala \
	valaunresolvedtype.vala \
	valausingdirective.vala \
	valavaluetype.vala \
	valavariable.vala \
	valavoidtype.vala \
	valawhilestatement.vala \
	valayieldstatement.vala \
	$(NULL)

libvalacore_la_SOURCES = \
	vala.vala.stamp \
	$(libvalacore_la_VALASOURCES:.vala=.c) \
	$(NULL)

valaincludedir = $(includedir)/vala@PACKAGE_SUFFIX@

valainclude_HEADERS = \
	vala.h \
	$(NULL)

vala.vapi vala.vala.stamp: $(libvalacore_la_VALASOURCES)
	$(VALA_V)$(VALAC) $(COVERAGE_VALAFLAGS) $(VALAFLAGS) -C --vapidir $(srcdir)/../vapi --pkg gobject-2.0 --vapidir $(srcdir)/../gee --pkg gee --pkg config -H vala.h --library vala $^
	@touch $@

libvalacore_la_LIBADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	../gee/libgee.la \
	$(NULL)

EXTRA_DIST = $(libvalacore_la_VALASOURCES) vala.vapi vala.vala.stamp

MAINTAINERCLEANFILES = \
	vala.vapi \
	vala.h \
	$(libvalacore_la_VALASOURCES:.vala=.c) \
	$(NULL)

VALA_V = $(VALA_V_$(V))
VALA_V_ = $(VALA_V_$(AM_DEFAULT_VERBOSITY))
VALA_V_0 = @echo "  VALAC " $^;
