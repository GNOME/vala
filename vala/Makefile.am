include $(top_srcdir)/Makefile.common

NULL =

AM_CPPFLAGS = \
	-DG_LOG_DOMAIN=\"vala\" \
	$(COVERAGE_CFLAGS) \
	-I$(top_srcdir)/gee \
	$(GLIB_CFLAGS) \
	$(GMODULE_CFLAGS) \
	-DPACKAGE_DATADIR=\"$(pkgdatadir)\" \
	$(NULL)

BUILT_SOURCES = vala.vala.stamp $(srcdir)/valaversion.vala

$(srcdir)/valaversion.vala:
	sed -e "s#\@VALA_MAJOR_VERSION\@#$(VALA_MAJOR_VERSION)#g" \
		-e "s#\@VALA_MINOR_VERSION\@#$(VALA_MINOR_VERSION)#g" \
		-e "s#\@VALA_MICRO_VERSION\@#$(VALA_MICRO_VERSION)#g" \
		-e "s#\@API_VERSION\@#$(API_VERSION)#g" \
		-e "s#\@PACKAGE_VERSION\@#$(PACKAGE_VERSION)#g" \
		< $@.in > $@

lib_LTLIBRARIES = \
	libvala@PACKAGE_SUFFIX@.la \
	$(NULL)

libvala_la_VALASOURCES = \
	valaaddressofexpression.vala \
	valaarraycopymethod.vala \
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
	valacallable.vala \
	valacallableexpression.vala \
	valacallabletype.vala \
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
	valadelegatedestroyfield.vala \
	valadelegatetargetfield.vala \
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
	valagenericdestroyfield.vala \
	valagenericdupfield.vala \
	valagenericsymbol.vala \
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
	valainvalidexpression.vala \
	valainvalidtype.vala \
	valalambdaexpression.vala \
	valaliteral.vala \
	valalocalvariable.vala \
	valalockable.vala \
	valalockstatement.vala \
	valaloop.vala \
	valaloopstatement.vala \
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
	valapropertyprototype.vala \
	valarealliteral.vala \
	valareferencetransferexpression.vala \
	valareferencetype.vala \
	valaregexliteral.vala \
	valareport.vala \
	valareturnstatement.vala \
	valascanner.vala \
	valascope.vala \
	valasemanticanalyzer.vala \
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
	valatraversevisitor.vala \
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
	valausedattr.vala \
	valausingdirective.vala \
	valavaluetype.vala \
	valavariable.vala \
	valavartype.vala \
	valaversion.vala \
	valaversionattribute.vala \
	valavoidtype.vala \
	valawhilestatement.vala \
	valawithstatement.vala \
	valayieldstatement.vala \
	$(NULL)

libvala@PACKAGE_SUFFIX@_la_SOURCES = \
	vala.vala.stamp \
	$(libvala_la_VALASOURCES:.vala=.c) \
	$(NULL)

valaincludedir = $(includedir)/vala@PACKAGE_SUFFIX@

valainclude_HEADERS = \
	vala.h \
	$(NULL)

vala.vapi vala.vala.stamp: $(libvala_la_VALASOURCES)
	$(VALA_V)$(VALAC) \
		$(COVERAGE_VALAFLAGS) \
		$(VALAFLAGS) \
		-C \
		--vapidir $(top_srcdir)/vapi --pkg gmodule-2.0 --pkg gobject-2.0 \
		--vapidir $(top_srcdir)/gee --pkg gee \
		--pkg config \
		-H vala.h \
		--library vala \
		$^
	@touch $@

libvala@PACKAGE_SUFFIX@_la_LDFLAGS = \
	-no-undefined \
	$(NULL)

libvala@PACKAGE_SUFFIX@_la_LIBADD = \
	$(COVERAGE_LIBS) \
	$(GLIB_LIBS) \
	$(GMODULE_LIBS) \
	$(top_builddir)/gee/libgee.la \
	$(NULL)

vapidir = $(datadir)/vala/vapi
dist_vapi_DATA = libvala@PACKAGE_SUFFIX@.vapi

libvala@PACKAGE_SUFFIX@.vapi: $(top_srcdir)/gee/gee.vapi $(top_srcdir)/vala/vala.vapi
	cat $^ > $@

EXTRA_DIST = $(libvala_la_VALASOURCES) vala.vapi vala.vala.stamp vala.h valaversion.vala.in

MAINTAINERCLEANFILES = \
	vala.vapi \
	vala.h \
	$(libvala_la_VALASOURCES:.vala=.c) \
	$(NULL)
