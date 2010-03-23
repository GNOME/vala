<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gda">
		<object name="GdaReportDocbookDocument" parent="GdaReportDocument" type-name="GdaReportDocbookDocument" get-type="gda_report_docbook_document_get_type">
			<constructor name="new" symbol="gda_report_docbook_document_new">
				<return-type type="GdaReportDocument*"/>
				<parameters>
					<parameter name="engine" type="GdaReportEngine*"/>
				</parameters>
			</constructor>
			<property name="fo-stylesheet" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fop-path" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="html-stylesheet" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="java-home" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GdaReportDocument" parent="GObject" type-name="GdaReportDocument" get-type="gda_report_document_get_type">
			<method name="run_as_html" symbol="gda_report_document_run_as_html">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="doc" type="GdaReportDocument*"/>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="run_as_pdf" symbol="gda_report_document_run_as_pdf">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="doc" type="GdaReportDocument*"/>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_template" symbol="gda_report_document_set_template">
				<return-type type="void"/>
				<parameters>
					<parameter name="doc" type="GdaReportDocument*"/>
					<parameter name="file" type="gchar*"/>
				</parameters>
			</method>
			<property name="engine" type="GdaReportEngine*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="template" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<vfunc name="run_as_html">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="doc" type="GdaReportDocument*"/>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="run_as_pdf">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="doc" type="GdaReportDocument*"/>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GdaReportEngine" parent="GObject" type-name="GdaReportEngine" get-type="gda_report_engine_get_type">
			<method name="declare_object" symbol="gda_report_engine_declare_object">
				<return-type type="void"/>
				<parameters>
					<parameter name="engine" type="GdaReportEngine*"/>
					<parameter name="object" type="GObject*"/>
					<parameter name="obj_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="find_declared_object" symbol="gda_report_engine_find_declared_object">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="engine" type="GdaReportEngine*"/>
					<parameter name="obj_type" type="GType"/>
					<parameter name="obj_name" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_report_engine_new">
				<return-type type="GdaReportEngine*"/>
				<parameters>
					<parameter name="spec_node" type="xmlNodePtr"/>
				</parameters>
			</constructor>
			<constructor name="new_from_file" symbol="gda_report_engine_new_from_file">
				<return-type type="GdaReportEngine*"/>
				<parameters>
					<parameter name="spec_file_name" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_string" symbol="gda_report_engine_new_from_string">
				<return-type type="GdaReportEngine*"/>
				<parameters>
					<parameter name="spec_string" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="run_as_doc" symbol="gda_report_engine_run_as_doc">
				<return-type type="xmlDocPtr"/>
				<parameters>
					<parameter name="engine" type="GdaReportEngine*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="run_as_node" symbol="gda_report_engine_run_as_node">
				<return-type type="xmlNodePtr"/>
				<parameters>
					<parameter name="engine" type="GdaReportEngine*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="spec" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="spec-filename" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="spec-string" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GdaReportRmlDocument" parent="GdaReportDocument" type-name="GdaReportRmlDocument" get-type="gda_report_rml_document_get_type">
			<constructor name="new" symbol="gda_report_rml_document_new">
				<return-type type="GdaReportDocument*"/>
				<parameters>
					<parameter name="engine" type="GdaReportEngine*"/>
				</parameters>
			</constructor>
		</object>
	</namespace>
</api>
