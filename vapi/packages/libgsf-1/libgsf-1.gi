<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gsf">
		<function name="base64_decode_simple" symbol="gsf_base64_decode_simple">
			<return-type type="size_t"/>
			<parameters>
				<parameter name="data" type="guint8*"/>
				<parameter name="len" type="size_t"/>
			</parameters>
		</function>
		<function name="base64_decode_step" symbol="gsf_base64_decode_step">
			<return-type type="size_t"/>
			<parameters>
				<parameter name="in" type="guint8*"/>
				<parameter name="len" type="size_t"/>
				<parameter name="out" type="guint8*"/>
				<parameter name="state" type="int*"/>
				<parameter name="save" type="guint*"/>
			</parameters>
		</function>
		<function name="base64_encode_close" symbol="gsf_base64_encode_close">
			<return-type type="size_t"/>
			<parameters>
				<parameter name="in" type="guint8*"/>
				<parameter name="inlen" type="size_t"/>
				<parameter name="break_lines" type="gboolean"/>
				<parameter name="out" type="guint8*"/>
				<parameter name="state" type="int*"/>
				<parameter name="save" type="guint*"/>
			</parameters>
		</function>
		<function name="base64_encode_simple" symbol="gsf_base64_encode_simple">
			<return-type type="guint8*"/>
			<parameters>
				<parameter name="data" type="guint8*"/>
				<parameter name="len" type="size_t"/>
			</parameters>
		</function>
		<function name="base64_encode_step" symbol="gsf_base64_encode_step">
			<return-type type="size_t"/>
			<parameters>
				<parameter name="in" type="guint8*"/>
				<parameter name="len" type="size_t"/>
				<parameter name="break_lines" type="gboolean"/>
				<parameter name="out" type="guint8*"/>
				<parameter name="state" type="int*"/>
				<parameter name="save" type="guint*"/>
			</parameters>
		</function>
		<function name="doc_meta_dump" symbol="gsf_doc_meta_dump">
			<return-type type="void"/>
			<parameters>
				<parameter name="meta" type="GsfDocMetaData*"/>
			</parameters>
		</function>
		<function name="error_quark" symbol="gsf_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="extension_pointer" symbol="gsf_extension_pointer">
			<return-type type="char*"/>
			<parameters>
				<parameter name="path" type="char*"/>
			</parameters>
		</function>
		<function name="filename_to_utf8" symbol="gsf_filename_to_utf8">
			<return-type type="char*"/>
			<parameters>
				<parameter name="filename" type="char*"/>
				<parameter name="quoted" type="gboolean"/>
			</parameters>
		</function>
		<function name="get_gsf_odf_version" symbol="get_gsf_odf_version">
			<return-type type="short"/>
		</function>
		<function name="get_gsf_odf_version_string" symbol="get_gsf_odf_version_string">
			<return-type type="char*"/>
		</function>
		<function name="get_gsf_ooo_ns" symbol="get_gsf_ooo_ns">
			<return-type type="GsfXMLInNS*"/>
		</function>
		<function name="iconv_close" symbol="gsf_iconv_close">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GIConv"/>
			</parameters>
		</function>
		<function name="init" symbol="gsf_init">
			<return-type type="void"/>
		</function>
		<function name="init_dynamic" symbol="gsf_init_dynamic">
			<return-type type="void"/>
			<parameters>
				<parameter name="module" type="GTypeModule*"/>
			</parameters>
		</function>
		<function name="le_get_double" symbol="gsf_le_get_double">
			<return-type type="double"/>
			<parameters>
				<parameter name="p" type="void*"/>
			</parameters>
		</function>
		<function name="le_get_float" symbol="gsf_le_get_float">
			<return-type type="float"/>
			<parameters>
				<parameter name="p" type="void*"/>
			</parameters>
		</function>
		<function name="le_get_guint64" symbol="gsf_le_get_guint64">
			<return-type type="guint64"/>
			<parameters>
				<parameter name="p" type="void*"/>
			</parameters>
		</function>
		<function name="le_set_double" symbol="gsf_le_set_double">
			<return-type type="void"/>
			<parameters>
				<parameter name="p" type="void*"/>
				<parameter name="d" type="double"/>
			</parameters>
		</function>
		<function name="le_set_float" symbol="gsf_le_set_float">
			<return-type type="void"/>
			<parameters>
				<parameter name="p" type="void*"/>
				<parameter name="f" type="float"/>
			</parameters>
		</function>
		<function name="mem_dump" symbol="gsf_mem_dump">
			<return-type type="void"/>
			<parameters>
				<parameter name="ptr" type="guint8*"/>
				<parameter name="len" type="size_t"/>
			</parameters>
		</function>
		<function name="msole_codepage_to_lid" symbol="gsf_msole_codepage_to_lid">
			<return-type type="guint"/>
			<parameters>
				<parameter name="codepage" type="int"/>
			</parameters>
		</function>
		<function name="msole_iconv_open_codepage_for_export" symbol="gsf_msole_iconv_open_codepage_for_export">
			<return-type type="GIConv"/>
			<parameters>
				<parameter name="codepage_to" type="int"/>
			</parameters>
		</function>
		<function name="msole_iconv_open_codepage_for_import" symbol="gsf_msole_iconv_open_codepage_for_import">
			<return-type type="GIConv"/>
			<parameters>
				<parameter name="to" type="char*"/>
				<parameter name="codepage" type="int"/>
			</parameters>
		</function>
		<function name="msole_iconv_open_codepages_for_export" symbol="gsf_msole_iconv_open_codepages_for_export">
			<return-type type="GIConv"/>
			<parameters>
				<parameter name="codepage_to" type="int"/>
				<parameter name="from" type="char*"/>
			</parameters>
		</function>
		<function name="msole_iconv_open_for_export" symbol="gsf_msole_iconv_open_for_export">
			<return-type type="GIConv"/>
		</function>
		<function name="msole_iconv_open_for_import" symbol="gsf_msole_iconv_open_for_import">
			<return-type type="GIConv"/>
			<parameters>
				<parameter name="codepage" type="int"/>
			</parameters>
		</function>
		<function name="msole_iconv_win_codepage" symbol="gsf_msole_iconv_win_codepage">
			<return-type type="int"/>
		</function>
		<function name="msole_inflate" symbol="gsf_msole_inflate">
			<return-type type="GByteArray*"/>
			<parameters>
				<parameter name="input" type="GsfInput*"/>
				<parameter name="offset" type="gsf_off_t"/>
			</parameters>
		</function>
		<function name="msole_language_for_lid" symbol="gsf_msole_language_for_lid">
			<return-type type="char*"/>
			<parameters>
				<parameter name="lid" type="guint"/>
			</parameters>
		</function>
		<function name="msole_lid_for_language" symbol="gsf_msole_lid_for_language">
			<return-type type="guint"/>
			<parameters>
				<parameter name="lang" type="char*"/>
			</parameters>
		</function>
		<function name="msole_lid_to_codepage" symbol="gsf_msole_lid_to_codepage">
			<return-type type="int"/>
			<parameters>
				<parameter name="lid" type="guint"/>
			</parameters>
		</function>
		<function name="msole_lid_to_codepage_str" symbol="gsf_msole_lid_to_codepage_str">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="lid" type="guint"/>
			</parameters>
		</function>
		<function name="msole_metadata_read" symbol="gsf_msole_metadata_read">
			<return-type type="GError*"/>
			<parameters>
				<parameter name="in" type="GsfInput*"/>
				<parameter name="accum" type="GsfDocMetaData*"/>
			</parameters>
		</function>
		<function name="msole_metadata_write" symbol="gsf_msole_metadata_write">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="out" type="GsfOutput*"/>
				<parameter name="meta_data" type="GsfDocMetaData*"/>
				<parameter name="doc_not_component" type="gboolean"/>
			</parameters>
		</function>
		<function name="open_pkg_error_id" symbol="gsf_open_pkg_error_id">
			<return-type type="gint"/>
		</function>
		<function name="open_pkg_foreach_rel" symbol="gsf_open_pkg_foreach_rel">
			<return-type type="void"/>
			<parameters>
				<parameter name="opkg" type="GsfInput*"/>
				<parameter name="func" type="GsfOpenPkgIter"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="open_pkg_get_rel_by_id" symbol="gsf_open_pkg_get_rel_by_id">
			<return-type type="GsfInput*"/>
			<parameters>
				<parameter name="opkg" type="GsfInput*"/>
				<parameter name="id" type="char*"/>
			</parameters>
		</function>
		<function name="open_pkg_get_rel_by_type" symbol="gsf_open_pkg_get_rel_by_type">
			<return-type type="GsfInput*"/>
			<parameters>
				<parameter name="opkg" type="GsfInput*"/>
				<parameter name="type" type="char*"/>
			</parameters>
		</function>
		<function name="open_pkg_lookup_rel_by_id" symbol="gsf_open_pkg_lookup_rel_by_id">
			<return-type type="GsfOpenPkgRel*"/>
			<parameters>
				<parameter name="opkg" type="GsfInput*"/>
				<parameter name="id" type="char*"/>
			</parameters>
		</function>
		<function name="open_pkg_lookup_rel_by_type" symbol="gsf_open_pkg_lookup_rel_by_type">
			<return-type type="GsfOpenPkgRel*"/>
			<parameters>
				<parameter name="opkg" type="GsfInput*"/>
				<parameter name="type" type="char*"/>
			</parameters>
		</function>
		<function name="open_pkg_open_rel" symbol="gsf_open_pkg_open_rel">
			<return-type type="GsfInput*"/>
			<parameters>
				<parameter name="opkg" type="GsfInput*"/>
				<parameter name="rel" type="GsfOpenPkgRel*"/>
				<parameter name="err" type="GError**"/>
			</parameters>
		</function>
		<function name="open_pkg_open_rel_by_id" symbol="gsf_open_pkg_open_rel_by_id">
			<return-type type="GsfInput*"/>
			<parameters>
				<parameter name="opkg" type="GsfInput*"/>
				<parameter name="id" type="char*"/>
				<parameter name="err" type="GError**"/>
			</parameters>
		</function>
		<function name="open_pkg_open_rel_by_type" symbol="gsf_open_pkg_open_rel_by_type">
			<return-type type="GsfInput*"/>
			<parameters>
				<parameter name="opkg" type="GsfInput*"/>
				<parameter name="type" type="char*"/>
				<parameter name="err" type="GError**"/>
			</parameters>
		</function>
		<function name="open_pkg_parse_rel_by_id" symbol="gsf_open_pkg_parse_rel_by_id">
			<return-type type="GError*"/>
			<parameters>
				<parameter name="xin" type="GsfXMLIn*"/>
				<parameter name="id" type="char*"/>
				<parameter name="dtd" type="GsfXMLInNode*"/>
				<parameter name="ns" type="GsfXMLInNS*"/>
			</parameters>
		</function>
		<function name="opendoc_metadata_read" symbol="gsf_opendoc_metadata_read">
			<return-type type="GError*"/>
			<parameters>
				<parameter name="input" type="GsfInput*"/>
				<parameter name="md" type="GsfDocMetaData*"/>
			</parameters>
		</function>
		<function name="opendoc_metadata_subtree" symbol="gsf_opendoc_metadata_subtree">
			<return-type type="void"/>
			<parameters>
				<parameter name="doc" type="GsfXMLIn*"/>
				<parameter name="md" type="GsfDocMetaData*"/>
			</parameters>
		</function>
		<function name="opendoc_metadata_write" symbol="gsf_opendoc_metadata_write">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="output" type="GsfXMLOut*"/>
				<parameter name="md" type="GsfDocMetaData*"/>
			</parameters>
		</function>
		<function name="property_settings_collect" symbol="gsf_property_settings_collect">
			<return-type type="void"/>
			<parameters>
				<parameter name="object_type" type="GType"/>
				<parameter name="p_params" type="GParameter**"/>
				<parameter name="p_n_params" type="size_t*"/>
				<parameter name="first_property_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="property_settings_collect_valist" symbol="gsf_property_settings_collect_valist">
			<return-type type="void"/>
			<parameters>
				<parameter name="object_type" type="GType"/>
				<parameter name="p_params" type="GParameter**"/>
				<parameter name="p_n_params" type="size_t*"/>
				<parameter name="first_property_name" type="gchar*"/>
				<parameter name="var_args" type="va_list"/>
			</parameters>
		</function>
		<function name="property_settings_free" symbol="gsf_property_settings_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="params" type="GParameter*"/>
				<parameter name="n_params" type="size_t"/>
			</parameters>
		</function>
		<function name="shutdown" symbol="gsf_shutdown">
			<return-type type="void"/>
		</function>
		<function name="shutdown_dynamic" symbol="gsf_shutdown_dynamic">
			<return-type type="void"/>
			<parameters>
				<parameter name="module" type="GTypeModule*"/>
			</parameters>
		</function>
		<function name="value_get_docprop_varray" symbol="gsf_value_get_docprop_varray">
			<return-type type="GValueArray*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_docprop_vector" symbol="gsf_value_get_docprop_vector">
			<return-type type="GsfDocPropVector*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_set_timestamp" symbol="gsf_value_set_timestamp">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="stamp" type="GsfTimestamp*"/>
			</parameters>
		</function>
		<function name="xmlDocFormatDump" symbol="gsf_xmlDocFormatDump">
			<return-type type="int"/>
			<parameters>
				<parameter name="output" type="GsfOutput*"/>
				<parameter name="cur" type="xmlDoc*"/>
				<parameter name="encoding" type="char*"/>
				<parameter name="format" type="gboolean"/>
			</parameters>
		</function>
		<function name="xml_gvalue_from_str" symbol="gsf_xml_gvalue_from_str">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="res" type="GValue*"/>
				<parameter name="t" type="GType"/>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="xml_parser_context" symbol="gsf_xml_parser_context">
			<return-type type="xmlParserCtxt*"/>
			<parameters>
				<parameter name="input" type="GsfInput*"/>
			</parameters>
		</function>
		<function name="xml_probe" symbol="gsf_xml_probe">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="input" type="GsfInput*"/>
				<parameter name="startElement" type="GsfXMLProbeFunc"/>
			</parameters>
		</function>
		<callback name="GsfOpenPkgIter">
			<return-type type="void"/>
			<parameters>
				<parameter name="opkg" type="GsfInput*"/>
				<parameter name="rel" type="GsfOpenPkgRel*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GsfXMLInExtDtor">
			<return-type type="void"/>
			<parameters>
				<parameter name="xin" type="GsfXMLIn*"/>
				<parameter name="old_state" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GsfXMLInUnknownFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="xin" type="GsfXMLIn*"/>
				<parameter name="elem" type="xmlChar*"/>
				<parameter name="attrs" type="xmlChar**"/>
			</parameters>
		</callback>
		<callback name="GsfXMLProbeFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="name" type="xmlChar*"/>
				<parameter name="prefix" type="xmlChar*"/>
				<parameter name="URI" type="xmlChar*"/>
				<parameter name="nb_namespaces" type="int"/>
				<parameter name="namespaces" type="xmlChar**"/>
				<parameter name="nb_attributes" type="int"/>
				<parameter name="nb_defaulted" type="int"/>
				<parameter name="attributes" type="xmlChar**"/>
			</parameters>
		</callback>
		<struct name="GsfDocProp">
			<method name="dump" symbol="gsf_doc_prop_dump">
				<return-type type="void"/>
				<parameters>
					<parameter name="prop" type="GsfDocProp*"/>
				</parameters>
			</method>
			<method name="free" symbol="gsf_doc_prop_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="prop" type="GsfDocProp*"/>
				</parameters>
			</method>
			<method name="get_link" symbol="gsf_doc_prop_get_link">
				<return-type type="char*"/>
				<parameters>
					<parameter name="prop" type="GsfDocProp*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gsf_doc_prop_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="prop" type="GsfDocProp*"/>
				</parameters>
			</method>
			<method name="get_val" symbol="gsf_doc_prop_get_val">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="prop" type="GsfDocProp*"/>
				</parameters>
			</method>
			<method name="new" symbol="gsf_doc_prop_new">
				<return-type type="GsfDocProp*"/>
				<parameters>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_link" symbol="gsf_doc_prop_set_link">
				<return-type type="void"/>
				<parameters>
					<parameter name="prop" type="GsfDocProp*"/>
					<parameter name="link" type="char*"/>
				</parameters>
			</method>
			<method name="set_val" symbol="gsf_doc_prop_set_val">
				<return-type type="void"/>
				<parameters>
					<parameter name="prop" type="GsfDocProp*"/>
					<parameter name="val" type="GValue*"/>
				</parameters>
			</method>
			<method name="swap_val" symbol="gsf_doc_prop_swap_val">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="prop" type="GsfDocProp*"/>
					<parameter name="val" type="GValue*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GsfOpenPkgRel">
			<method name="get_target" symbol="gsf_open_pkg_rel_get_target">
				<return-type type="char*"/>
				<parameters>
					<parameter name="rel" type="GsfOpenPkgRel*"/>
				</parameters>
			</method>
			<method name="is_extern" symbol="gsf_open_pkg_rel_is_extern">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="rel" type="GsfOpenPkgRel*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GsfOpenPkgRels">
		</struct>
		<struct name="GsfXMLBlob">
		</struct>
		<struct name="GsfXMLIn">
			<method name="check_ns" symbol="gsf_xml_in_check_ns">
				<return-type type="char*"/>
				<parameters>
					<parameter name="xin" type="GsfXMLIn*"/>
					<parameter name="str" type="char*"/>
					<parameter name="ns_id" type="unsigned"/>
				</parameters>
			</method>
			<method name="get_input" symbol="gsf_xml_in_get_input">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="xin" type="GsfXMLIn*"/>
				</parameters>
			</method>
			<method name="namecmp" symbol="gsf_xml_in_namecmp">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="xin" type="GsfXMLIn*"/>
					<parameter name="str" type="char*"/>
					<parameter name="ns_id" type="unsigned"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="push_state" symbol="gsf_xml_in_push_state">
				<return-type type="void"/>
				<parameters>
					<parameter name="xin" type="GsfXMLIn*"/>
					<parameter name="doc" type="GsfXMLInDoc*"/>
					<parameter name="new_state" type="gpointer"/>
					<parameter name="dtor" type="GsfXMLInExtDtor"/>
					<parameter name="attrs" type="xmlChar**"/>
				</parameters>
			</method>
			<field name="user_state" type="gpointer"/>
			<field name="content" type="GString*"/>
			<field name="doc" type="GsfXMLInDoc*"/>
			<field name="node" type="GsfXMLInNode*"/>
			<field name="node_stack" type="GSList*"/>
		</struct>
		<struct name="GsfXMLInDoc">
			<method name="add_nodes" symbol="gsf_xml_in_doc_add_nodes">
				<return-type type="void"/>
				<parameters>
					<parameter name="doc" type="GsfXMLInDoc*"/>
					<parameter name="nodes" type="GsfXMLInNode*"/>
				</parameters>
			</method>
			<method name="free" symbol="gsf_xml_in_doc_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="doc" type="GsfXMLInDoc*"/>
				</parameters>
			</method>
			<method name="new" symbol="gsf_xml_in_doc_new">
				<return-type type="GsfXMLInDoc*"/>
				<parameters>
					<parameter name="nodes" type="GsfXMLInNode*"/>
					<parameter name="ns" type="GsfXMLInNS*"/>
				</parameters>
			</method>
			<method name="parse" symbol="gsf_xml_in_doc_parse">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="doc" type="GsfXMLInDoc*"/>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="user_state" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_unknown_handler" symbol="gsf_xml_in_doc_set_unknown_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="doc" type="GsfXMLInDoc*"/>
					<parameter name="handler" type="GsfXMLInUnknownFunc"/>
				</parameters>
			</method>
		</struct>
		<struct name="GsfXMLInNS">
			<field name="uri" type="char*"/>
			<field name="ns_id" type="unsigned"/>
		</struct>
		<struct name="GsfXMLInNode">
			<field name="id" type="char*"/>
			<field name="ns_id" type="int"/>
			<field name="name" type="char*"/>
			<field name="parent_id" type="char*"/>
			<field name="start" type="GCallback"/>
			<field name="end" type="GCallback"/>
			<field name="user_data" type="gpointer"/>
			<field name="has_content" type="GsfXMLContent"/>
			<field name="check_children_for_ns" type="unsigned"/>
			<field name="share_children_with_parent" type="unsigned"/>
		</struct>
		<struct name="gsf_off_t">
		</struct>
		<boxed name="GsfTimestamp" type-name="GsfTimestamp" get-type="gsf_timestamp_get_type">
			<method name="as_string" symbol="gsf_timestamp_as_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="stamp" type="GsfTimestamp*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gsf_timestamp_copy">
				<return-type type="GsfTimestamp*"/>
				<parameters>
					<parameter name="stamp" type="GsfTimestamp*"/>
				</parameters>
			</method>
			<method name="equal" symbol="gsf_timestamp_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="a" type="GsfTimestamp*"/>
					<parameter name="b" type="GsfTimestamp*"/>
				</parameters>
			</method>
			<method name="free" symbol="gsf_timestamp_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="stamp" type="GsfTimestamp*"/>
				</parameters>
			</method>
			<method name="from_string" symbol="gsf_timestamp_from_string">
				<return-type type="int"/>
				<parameters>
					<parameter name="spec" type="char*"/>
					<parameter name="stamp" type="GsfTimestamp*"/>
				</parameters>
			</method>
			<method name="hash" symbol="gsf_timestamp_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="stamp" type="GsfTimestamp*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_timestamp_new">
				<return-type type="GsfTimestamp*"/>
			</constructor>
			<method name="parse" symbol="gsf_timestamp_parse">
				<return-type type="int"/>
				<parameters>
					<parameter name="spec" type="char*"/>
					<parameter name="stamp" type="GsfTimestamp*"/>
				</parameters>
			</method>
			<method name="set_time" symbol="gsf_timestamp_set_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="stamp" type="GsfTimestamp*"/>
					<parameter name="t" type="guint64"/>
				</parameters>
			</method>
			<field name="date" type="GDate"/>
			<field name="seconds" type="glong"/>
			<field name="time_zone" type="GString"/>
			<field name="timet" type="guint32"/>
		</boxed>
		<enum name="GsfClipFormat">
			<member name="GSF_CLIP_FORMAT_WINDOWS_CLIPBOARD" value="-1"/>
			<member name="GSF_CLIP_FORMAT_MACINTOSH_CLIPBOARD" value="-2"/>
			<member name="GSF_CLIP_FORMAT_GUID" value="-3"/>
			<member name="GSF_CLIP_FORMAT_NO_DATA" value="0"/>
			<member name="GSF_CLIP_FORMAT_CLIPBOARD_FORMAT_NAME" value="1"/>
			<member name="GSF_CLIP_FORMAT_UNKNOWN" value="2"/>
		</enum>
		<enum name="GsfClipFormatWindows">
			<member name="GSF_CLIP_FORMAT_WINDOWS_ERROR" value="-1"/>
			<member name="GSF_CLIP_FORMAT_WINDOWS_UNKNOWN" value="-2"/>
			<member name="GSF_CLIP_FORMAT_WINDOWS_METAFILE" value="3"/>
			<member name="GSF_CLIP_FORMAT_WINDOWS_DIB" value="8"/>
			<member name="GSF_CLIP_FORMAT_WINDOWS_ENHANCED_METAFILE" value="14"/>
		</enum>
		<enum name="GsfError">
			<member name="GSF_ERROR_OUT_OF_MEMORY" value="0"/>
			<member name="GSF_ERROR_INVALID_DATA" value="1"/>
		</enum>
		<enum name="GsfOutputCsvQuotingMode" type-name="GsfOutputCsvQuotingMode" get-type="gsf_output_csv_quoting_mode_get_type">
			<member name="GSF_OUTPUT_CSV_QUOTING_MODE_NEVER" value="0"/>
			<member name="GSF_OUTPUT_CSV_QUOTING_MODE_AUTO" value="1"/>
			<member name="GSF_OUTPUT_CSV_QUOTING_MODE_ALWAYS" value="2"/>
		</enum>
		<enum name="GsfXMLContent">
			<member name="GSF_XML_NO_CONTENT" value="0"/>
			<member name="GSF_XML_CONTENT" value="1"/>
			<member name="GSF_XML_SHARED_CONTENT" value="2"/>
		</enum>
		<enum name="GsfZipCompressionMethod">
			<member name="GSF_ZIP_STORED" value="0"/>
			<member name="GSF_ZIP_SHRUNK" value="1"/>
			<member name="GSF_ZIP_REDUCEDx1" value="2"/>
			<member name="GSF_ZIP_REDUCEDx2" value="3"/>
			<member name="GSF_ZIP_REDUCEDx3" value="4"/>
			<member name="GSF_ZIP_REDUCEDx4" value="5"/>
			<member name="GSF_ZIP_IMPLODED" value="6"/>
			<member name="GSF_ZIP_TOKENIZED" value="7"/>
			<member name="GSF_ZIP_DEFLATED" value="8"/>
			<member name="GSF_ZIP_DEFLATED_BETTER" value="9"/>
			<member name="GSF_ZIP_IMPLODED_BETTER" value="10"/>
		</enum>
		<object name="GsfBlob" parent="GObject" type-name="GsfBlob" get-type="gsf_blob_get_type">
			<method name="get_size" symbol="gsf_blob_get_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="blob" type="GsfBlob*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_blob_new">
				<return-type type="GsfBlob*"/>
				<parameters>
					<parameter name="size" type="gsize"/>
					<parameter name="data_to_copy" type="gconstpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="peek_data" symbol="gsf_blob_peek_data">
				<return-type type="gconstpointer"/>
				<parameters>
					<parameter name="blob" type="GsfBlob*"/>
				</parameters>
			</method>
		</object>
		<object name="GsfClipData" parent="GObject" type-name="GsfClipData" get-type="gsf_clip_data_get_type">
			<method name="get_data_blob" symbol="gsf_clip_data_get_data_blob">
				<return-type type="GsfBlob*"/>
				<parameters>
					<parameter name="clip_data" type="GsfClipData*"/>
				</parameters>
			</method>
			<method name="get_format" symbol="gsf_clip_data_get_format">
				<return-type type="GsfClipFormat"/>
				<parameters>
					<parameter name="clip_data" type="GsfClipData*"/>
				</parameters>
			</method>
			<method name="get_windows_clipboard_format" symbol="gsf_clip_data_get_windows_clipboard_format">
				<return-type type="GsfClipFormatWindows"/>
				<parameters>
					<parameter name="clip_data" type="GsfClipData*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_clip_data_new">
				<return-type type="GsfClipData*"/>
				<parameters>
					<parameter name="format" type="GsfClipFormat"/>
					<parameter name="data_blob" type="GsfBlob*"/>
				</parameters>
			</constructor>
			<method name="peek_real_data" symbol="gsf_clip_data_peek_real_data">
				<return-type type="gconstpointer"/>
				<parameters>
					<parameter name="clip_data" type="GsfClipData*"/>
					<parameter name="ret_size" type="gsize*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</object>
		<object name="GsfDocMetaData" parent="GObject" type-name="GsfDocMetaData" get-type="gsf_doc_meta_data_get_type">
			<method name="foreach" symbol="gsf_doc_meta_data_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="meta" type="GsfDocMetaData*"/>
					<parameter name="func" type="GHFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="insert" symbol="gsf_doc_meta_data_insert">
				<return-type type="void"/>
				<parameters>
					<parameter name="meta" type="GsfDocMetaData*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="lookup" symbol="gsf_doc_meta_data_lookup">
				<return-type type="GsfDocProp*"/>
				<parameters>
					<parameter name="meta" type="GsfDocMetaData*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_doc_meta_data_new">
				<return-type type="GsfDocMetaData*"/>
			</constructor>
			<method name="remove" symbol="gsf_doc_meta_data_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="meta" type="GsfDocMetaData*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="size" symbol="gsf_doc_meta_data_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="meta" type="GsfDocMetaData*"/>
				</parameters>
			</method>
			<method name="steal" symbol="gsf_doc_meta_data_steal">
				<return-type type="GsfDocProp*"/>
				<parameters>
					<parameter name="meta" type="GsfDocMetaData*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="store" symbol="gsf_doc_meta_data_store">
				<return-type type="void"/>
				<parameters>
					<parameter name="meta" type="GsfDocMetaData*"/>
					<parameter name="prop" type="GsfDocProp*"/>
				</parameters>
			</method>
		</object>
		<object name="GsfDocPropVector" parent="GObject" type-name="GsfDocPropVector" get-type="gsf_docprop_vector_get_type">
			<method name="append" symbol="gsf_docprop_vector_append">
				<return-type type="void"/>
				<parameters>
					<parameter name="vector" type="GsfDocPropVector*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="as_string" symbol="gsf_docprop_vector_as_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="vector" type="GsfDocPropVector*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_docprop_vector_new">
				<return-type type="GsfDocPropVector*"/>
			</constructor>
		</object>
		<object name="GsfInfile" parent="GsfInput" type-name="GsfInfile" get-type="gsf_infile_get_type">
			<method name="child_by_aname" symbol="gsf_infile_child_by_aname">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="infile" type="GsfInfile*"/>
					<parameter name="names" type="char*[]"/>
				</parameters>
			</method>
			<method name="child_by_index" symbol="gsf_infile_child_by_index">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="infile" type="GsfInfile*"/>
					<parameter name="i" type="int"/>
				</parameters>
			</method>
			<method name="child_by_name" symbol="gsf_infile_child_by_name">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="infile" type="GsfInfile*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="child_by_vaname" symbol="gsf_infile_child_by_vaname">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="infile" type="GsfInfile*"/>
					<parameter name="names" type="va_list"/>
				</parameters>
			</method>
			<method name="child_by_vname" symbol="gsf_infile_child_by_vname">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="infile" type="GsfInfile*"/>
				</parameters>
			</method>
			<method name="name_by_index" symbol="gsf_infile_name_by_index">
				<return-type type="char*"/>
				<parameters>
					<parameter name="infile" type="GsfInfile*"/>
					<parameter name="i" type="int"/>
				</parameters>
			</method>
			<method name="num_children" symbol="gsf_infile_num_children">
				<return-type type="int"/>
				<parameters>
					<parameter name="infile" type="GsfInfile*"/>
				</parameters>
			</method>
			<vfunc name="child_by_index">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="infile" type="GsfInfile*"/>
					<parameter name="i" type="int"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="child_by_name">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="infile" type="GsfInfile*"/>
					<parameter name="name" type="char*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="name_by_index">
				<return-type type="char*"/>
				<parameters>
					<parameter name="infile" type="GsfInfile*"/>
					<parameter name="i" type="int"/>
				</parameters>
			</vfunc>
			<vfunc name="num_children">
				<return-type type="int"/>
				<parameters>
					<parameter name="infile" type="GsfInfile*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GsfInfileMSOle" parent="GsfInfile" type-name="GsfInfileMSOle" get-type="gsf_infile_msole_get_type">
			<method name="get_class_id" symbol="gsf_infile_msole_get_class_id">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="ole" type="GsfInfileMSOle*"/>
					<parameter name="res" type="guint8*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_infile_msole_new">
				<return-type type="GsfInfile*"/>
				<parameters>
					<parameter name="source" type="GsfInput*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
		</object>
		<object name="GsfInfileMSVBA" parent="GsfInfile" type-name="GsfInfileMSVBA" get-type="gsf_infile_msvba_get_type">
			<method name="get_modules" symbol="gsf_infile_msvba_get_modules">
				<return-type type="GHashTable*"/>
				<parameters>
					<parameter name="vba_stream" type="GsfInfileMSVBA*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_infile_msvba_new">
				<return-type type="GsfInfile*"/>
				<parameters>
					<parameter name="source" type="GsfInfile*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<method name="steal_modules" symbol="gsf_infile_msvba_steal_modules">
				<return-type type="GHashTable*"/>
				<parameters>
					<parameter name="vba_stream" type="GsfInfileMSVBA*"/>
				</parameters>
			</method>
		</object>
		<object name="GsfInfileStdio" parent="GsfInfile" type-name="GsfInfileStdio" get-type="gsf_infile_stdio_get_type">
			<constructor name="new" symbol="gsf_infile_stdio_new">
				<return-type type="GsfInfile*"/>
				<parameters>
					<parameter name="root" type="char*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
		</object>
		<object name="GsfInfileTar" parent="GsfInfile" type-name="GsfInfileTar" get-type="gsf_infile_tar_get_type">
			<constructor name="new" symbol="gsf_infile_tar_new">
				<return-type type="GsfInfile*"/>
				<parameters>
					<parameter name="source" type="GsfInput*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<property name="source" type="GsfInput*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GsfInfileZip" parent="GsfInfile" type-name="GsfInfileZip" get-type="gsf_infile_zip_get_type">
			<constructor name="new" symbol="gsf_infile_zip_new">
				<return-type type="GsfInfile*"/>
				<parameters>
					<parameter name="source" type="GsfInput*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<property name="compression-level" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="internal-parent" type="GsfInfileZip*" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="source" type="GsfInput*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GsfInput" parent="GObject" type-name="GsfInput" get-type="gsf_input_get_type">
			<method name="container" symbol="gsf_input_container">
				<return-type type="GsfInfile*"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gsf_input_copy">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="output" type="GsfOutput*"/>
				</parameters>
			</method>
			<method name="dump" symbol="gsf_input_dump">
				<return-type type="void"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="dump_as_hex" type="gboolean"/>
				</parameters>
			</method>
			<method name="dup" symbol="gsf_input_dup">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="eof" symbol="gsf_input_eof">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
				</parameters>
			</method>
			<method name="error" symbol="gsf_input_error">
				<return-type type="GQuark"/>
			</method>
			<method name="error_id" symbol="gsf_input_error_id">
				<return-type type="GQuark"/>
			</method>
			<method name="find_vba" symbol="gsf_input_find_vba">
				<return-type type="GsfInfileMSVBA*"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="mmap_new" symbol="gsf_input_mmap_new">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="name" symbol="gsf_input_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
				</parameters>
			</method>
			<method name="read" symbol="gsf_input_read">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="num_bytes" type="size_t"/>
					<parameter name="optional_buffer" type="guint8*"/>
				</parameters>
			</method>
			<method name="remaining" symbol="gsf_input_remaining">
				<return-type type="gsf_off_t"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
				</parameters>
			</method>
			<method name="seek" symbol="gsf_input_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="offset" type="gsf_off_t"/>
					<parameter name="whence" type="GSeekType"/>
				</parameters>
			</method>
			<method name="seek_emulate" symbol="gsf_input_seek_emulate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="pos" type="gsf_off_t"/>
				</parameters>
			</method>
			<method name="set_container" symbol="gsf_input_set_container">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="container" type="GsfInfile*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="gsf_input_set_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_name_from_filename" symbol="gsf_input_set_name_from_filename">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="filename" type="char*"/>
				</parameters>
			</method>
			<method name="set_size" symbol="gsf_input_set_size">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="size" type="gsf_off_t"/>
				</parameters>
			</method>
			<method name="sibling" symbol="gsf_input_sibling">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="name" type="char*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="size" symbol="gsf_input_size">
				<return-type type="gsf_off_t"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
				</parameters>
			</method>
			<method name="tell" symbol="gsf_input_tell">
				<return-type type="gsf_off_t"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
				</parameters>
			</method>
			<method name="uncompress" symbol="gsf_input_uncompress">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="src" type="GsfInput*"/>
				</parameters>
			</method>
			<property name="eof" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="position" type="gint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="remaining" type="gint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="size" type="gint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<vfunc name="Dup">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="OpenSibling">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="path" type="char*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="Read">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="num_bytes" type="size_t"/>
					<parameter name="optional_buffer" type="guint8*"/>
				</parameters>
			</vfunc>
			<vfunc name="Seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
					<parameter name="offset" type="gsf_off_t"/>
					<parameter name="whence" type="GSeekType"/>
				</parameters>
			</vfunc>
			<field name="size" type="gsf_off_t"/>
			<field name="cur_offset" type="gsf_off_t"/>
			<field name="name" type="char*"/>
			<field name="container" type="GsfInfile*"/>
		</object>
		<object name="GsfInputGZip" parent="GsfInput" type-name="GsfInputGZip" get-type="gsf_input_gzip_get_type">
			<constructor name="new" symbol="gsf_input_gzip_new">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="source" type="GsfInput*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<property name="raw" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="source" type="GsfInput*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="uncompressed-size" type="gint64" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GsfInputGio" parent="GsfInput" type-name="GsfInputGio" get-type="gsf_input_gio_get_type">
			<constructor name="new" symbol="gsf_input_gio_new">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_for_path" symbol="gsf_input_gio_new_for_path">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="path" type="char*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_for_uri" symbol="gsf_input_gio_new_for_uri">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="uri" type="char*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
		</object>
		<object name="GsfInputHTTP" parent="GsfInput" type-name="GsfInputHTTP" get-type="gsf_input_http_get_type">
			<method name="get_content_type" symbol="gsf_input_http_get_content_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="input" type="GsfInputHTTP*"/>
				</parameters>
			</method>
			<method name="get_url" symbol="gsf_input_http_get_url">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="input" type="GsfInputHTTP*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_input_http_new">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="url" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<property name="content-type" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="url" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GsfInputMemory" parent="GsfInput" type-name="GsfInputMemory" get-type="gsf_input_memory_get_type">
			<constructor name="new" symbol="gsf_input_memory_new">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="buf" type="guint8*"/>
					<parameter name="length" type="gsf_off_t"/>
					<parameter name="needs_free" type="gboolean"/>
				</parameters>
			</constructor>
			<constructor name="new_clone" symbol="gsf_input_memory_new_clone">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="buf" type="guint8*"/>
					<parameter name="length" type="gsf_off_t"/>
				</parameters>
			</constructor>
			<constructor name="new_from_bzip" symbol="gsf_input_memory_new_from_bzip">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="source" type="GsfInput*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_iochannel" symbol="gsf_input_memory_new_from_iochannel">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="channel" type="GIOChannel*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
		</object>
		<object name="GsfInputProxy" parent="GsfInput" type-name="GsfInputProxy" get-type="gsf_input_proxy_get_type">
			<constructor name="new" symbol="gsf_input_proxy_new">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="source" type="GsfInput*"/>
				</parameters>
			</constructor>
			<constructor name="new_section" symbol="gsf_input_proxy_new_section">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="source" type="GsfInput*"/>
					<parameter name="offset" type="gsf_off_t"/>
					<parameter name="size" type="gsf_off_t"/>
				</parameters>
			</constructor>
		</object>
		<object name="GsfInputStdio" parent="GsfInput" type-name="GsfInputStdio" get-type="gsf_input_stdio_get_type">
			<constructor name="new" symbol="gsf_input_stdio_new">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_FILE" symbol="gsf_input_stdio_new_FILE">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="file" type="FILE*"/>
					<parameter name="keep_open" type="gboolean"/>
				</parameters>
			</constructor>
		</object>
		<object name="GsfInputTextline" parent="GsfInput" type-name="GsfInputTextline" get-type="gsf_input_textline_get_type">
			<method name="ascii_gets" symbol="gsf_input_textline_ascii_gets">
				<return-type type="unsigned*"/>
				<parameters>
					<parameter name="textline" type="GsfInputTextline*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_input_textline_new">
				<return-type type="GsfInput*"/>
				<parameters>
					<parameter name="source" type="GsfInput*"/>
				</parameters>
			</constructor>
			<method name="utf8_gets" symbol="gsf_input_textline_utf8_gets">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="textline" type="GsfInputTextline*"/>
				</parameters>
			</method>
		</object>
		<object name="GsfOutfile" parent="GsfOutput" type-name="GsfOutfile" get-type="gsf_outfile_get_type">
			<constructor name="new_child" symbol="gsf_outfile_new_child">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="outfile" type="GsfOutfile*"/>
					<parameter name="name" type="char*"/>
					<parameter name="is_dir" type="gboolean"/>
				</parameters>
			</constructor>
			<constructor name="new_child_full" symbol="gsf_outfile_new_child_full">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="outfile" type="GsfOutfile*"/>
					<parameter name="name" type="char*"/>
					<parameter name="is_dir" type="gboolean"/>
					<parameter name="first_property_name" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_child_varg" symbol="gsf_outfile_new_child_varg">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="outfile" type="GsfOutfile*"/>
					<parameter name="name" type="char*"/>
					<parameter name="is_dir" type="gboolean"/>
					<parameter name="first_property_name" type="char*"/>
					<parameter name="args" type="va_list"/>
				</parameters>
			</constructor>
			<vfunc name="new_child">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="outfile" type="GsfOutfile*"/>
					<parameter name="name" type="char*"/>
					<parameter name="is_dir" type="gboolean"/>
					<parameter name="first_property_name" type="char*"/>
					<parameter name="args" type="va_list"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GsfOutfileMSOle" parent="GsfOutfile" type-name="GsfOutfileMSOle" get-type="gsf_outfile_msole_get_type">
			<constructor name="new" symbol="gsf_outfile_msole_new">
				<return-type type="GsfOutfile*"/>
				<parameters>
					<parameter name="sink" type="GsfOutput*"/>
				</parameters>
			</constructor>
			<constructor name="new_full" symbol="gsf_outfile_msole_new_full">
				<return-type type="GsfOutfile*"/>
				<parameters>
					<parameter name="sink" type="GsfOutput*"/>
					<parameter name="bb_size" type="guint"/>
					<parameter name="sb_size" type="guint"/>
				</parameters>
			</constructor>
			<method name="set_class_id" symbol="gsf_outfile_msole_set_class_id">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="ole" type="GsfOutfileMSOle*"/>
					<parameter name="clsid" type="guint8*"/>
				</parameters>
			</method>
		</object>
		<object name="GsfOutfileOpenPkg" parent="GsfOutfile" type-name="GsfOutfileOpenPkg" get-type="gsf_outfile_open_pkg_get_type">
			<method name="add_extern_rel" symbol="gsf_outfile_open_pkg_add_extern_rel">
				<return-type type="char*"/>
				<parameters>
					<parameter name="parent" type="GsfOutfileOpenPkg*"/>
					<parameter name="target" type="char*"/>
					<parameter name="content_type" type="char*"/>
				</parameters>
			</method>
			<method name="add_rel" symbol="gsf_outfile_open_pkg_add_rel">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="dir" type="GsfOutfile*"/>
					<parameter name="name" type="char*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="parent" type="GsfOutfile*"/>
					<parameter name="type" type="char*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_outfile_open_pkg_new">
				<return-type type="GsfOutfile*"/>
				<parameters>
					<parameter name="sink" type="GsfOutfile*"/>
				</parameters>
			</constructor>
			<method name="relate" symbol="gsf_outfile_open_pkg_relate">
				<return-type type="char*"/>
				<parameters>
					<parameter name="child" type="GsfOutfileOpenPkg*"/>
					<parameter name="parent" type="GsfOutfileOpenPkg*"/>
					<parameter name="type" type="char*"/>
				</parameters>
			</method>
			<method name="set_content_type" symbol="gsf_outfile_open_pkg_set_content_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="open_pkg" type="GsfOutfileOpenPkg*"/>
					<parameter name="content_type" type="char*"/>
				</parameters>
			</method>
			<method name="set_sink" symbol="gsf_outfile_open_pkg_set_sink">
				<return-type type="void"/>
				<parameters>
					<parameter name="open_pkg" type="GsfOutfileOpenPkg*"/>
					<parameter name="sink" type="GsfOutput*"/>
				</parameters>
			</method>
			<property name="content-type" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="is-dir" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="sink" type="GsfOutfile*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GsfOutfileStdio" parent="GsfOutfile" type-name="GsfOutfileStdio" get-type="gsf_outfile_stdio_get_type">
			<constructor name="new" symbol="gsf_outfile_stdio_new">
				<return-type type="GsfOutfile*"/>
				<parameters>
					<parameter name="root" type="char*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_full" symbol="gsf_outfile_stdio_new_full">
				<return-type type="GsfOutfile*"/>
				<parameters>
					<parameter name="root" type="char*"/>
					<parameter name="err" type="GError**"/>
					<parameter name="first_property_name" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_valist" symbol="gsf_outfile_stdio_new_valist">
				<return-type type="GsfOutfile*"/>
				<parameters>
					<parameter name="root" type="char*"/>
					<parameter name="err" type="GError**"/>
					<parameter name="first_property_name" type="char*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</constructor>
		</object>
		<object name="GsfOutfileZip" parent="GsfOutfile" type-name="GsfOutfileZip" get-type="gsf_outfile_zip_get_type">
			<constructor name="new" symbol="gsf_outfile_zip_new">
				<return-type type="GsfOutfile*"/>
				<parameters>
					<parameter name="sink" type="GsfOutput*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<method name="set_compression_method" symbol="gsf_outfile_zip_set_compression_method">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="zip" type="GsfOutfileZip*"/>
					<parameter name="method" type="GsfZipCompressionMethod"/>
				</parameters>
			</method>
			<property name="compression-level" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="entry-name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="sink" type="GsfOutput*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GsfOutput" parent="GObject" type-name="GsfOutput" get-type="gsf_output_get_type">
			<method name="close" symbol="gsf_output_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
				</parameters>
			</method>
			<method name="container" symbol="gsf_output_container">
				<return-type type="GsfOutfile*"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
				</parameters>
			</method>
			<method name="error" symbol="gsf_output_error">
				<return-type type="GError*"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
				</parameters>
			</method>
			<method name="error_id" symbol="gsf_output_error_id">
				<return-type type="GQuark"/>
			</method>
			<method name="is_closed" symbol="gsf_output_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
				</parameters>
			</method>
			<method name="name" symbol="gsf_output_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
				</parameters>
			</method>
			<method name="printf" symbol="gsf_output_printf">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
					<parameter name="format" type="char*"/>
				</parameters>
			</method>
			<method name="puts" symbol="gsf_output_puts">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
					<parameter name="line" type="char*"/>
				</parameters>
			</method>
			<method name="seek" symbol="gsf_output_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
					<parameter name="offset" type="gsf_off_t"/>
					<parameter name="whence" type="GSeekType"/>
				</parameters>
			</method>
			<method name="set_container" symbol="gsf_output_set_container">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
					<parameter name="container" type="GsfOutfile*"/>
				</parameters>
			</method>
			<method name="set_error" symbol="gsf_output_set_error">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
					<parameter name="code" type="gint"/>
					<parameter name="format" type="char*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="gsf_output_set_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_name_from_filename" symbol="gsf_output_set_name_from_filename">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
					<parameter name="filename" type="char*"/>
				</parameters>
			</method>
			<method name="size" symbol="gsf_output_size">
				<return-type type="gsf_off_t"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
				</parameters>
			</method>
			<method name="tell" symbol="gsf_output_tell">
				<return-type type="gsf_off_t"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
				</parameters>
			</method>
			<method name="unwrap" symbol="gsf_output_unwrap">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="wrapper" type="GObject*"/>
					<parameter name="wrapee" type="GsfOutput*"/>
				</parameters>
			</method>
			<method name="vprintf" symbol="gsf_output_vprintf">
				<return-type type="gsf_off_t"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
					<parameter name="format" type="char*"/>
					<parameter name="args" type="va_list"/>
				</parameters>
			</method>
			<method name="wrap" symbol="gsf_output_wrap">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="wrapper" type="GObject*"/>
					<parameter name="wrapee" type="GsfOutput*"/>
				</parameters>
			</method>
			<method name="write" symbol="gsf_output_write">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
					<parameter name="num_bytes" type="size_t"/>
					<parameter name="data" type="guint8*"/>
				</parameters>
			</method>
			<property name="is-closed" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="position" type="gint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="size" type="gint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<vfunc name="Close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
				</parameters>
			</vfunc>
			<vfunc name="Seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
					<parameter name="offset" type="gsf_off_t"/>
					<parameter name="whence" type="GSeekType"/>
				</parameters>
			</vfunc>
			<vfunc name="Vprintf">
				<return-type type="gsf_off_t"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
					<parameter name="format" type="char*"/>
					<parameter name="args" type="va_list"/>
				</parameters>
			</vfunc>
			<vfunc name="Write">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
					<parameter name="num_bytes" type="size_t"/>
					<parameter name="data" type="guint8*"/>
				</parameters>
			</vfunc>
			<field name="cur_size" type="gsf_off_t"/>
			<field name="cur_offset" type="gsf_off_t"/>
			<field name="name" type="char*"/>
			<field name="wrapped_by" type="GObject*"/>
			<field name="container" type="GsfOutfile*"/>
			<field name="err" type="GError*"/>
			<field name="is_closed" type="gboolean"/>
			<field name="printf_buf" type="char*"/>
			<field name="printf_buf_size" type="int"/>
		</object>
		<object name="GsfOutputBzip" parent="GsfOutput" type-name="GsfOutputBzip" get-type="gsf_output_bzip_get_type">
			<constructor name="new" symbol="gsf_output_bzip_new">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="sink" type="GsfOutput*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
		</object>
		<object name="GsfOutputCsv" parent="GsfOutput" type-name="GsfOutputCsv" get-type="gsf_output_csv_get_type">
			<method name="write_eol" symbol="gsf_output_csv_write_eol">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="csv" type="GsfOutputCsv*"/>
				</parameters>
			</method>
			<method name="write_field" symbol="gsf_output_csv_write_field">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="csv" type="GsfOutputCsv*"/>
					<parameter name="field" type="char*"/>
					<parameter name="len" type="size_t"/>
				</parameters>
			</method>
			<property name="eol" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="quote" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="quoting-mode" type="GsfOutputCsvQuotingMode" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="quoting-on-whitespace" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="quoting-triggers" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="separator" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="sink" type="GsfOutput*" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="sink" type="GsfOutput*"/>
			<field name="quote" type="char*"/>
			<field name="quote_len" type="size_t"/>
			<field name="quoting_mode" type="GsfOutputCsvQuotingMode"/>
			<field name="quoting_triggers" type="char*"/>
			<field name="eol" type="char*"/>
			<field name="eol_len" type="size_t"/>
			<field name="separator" type="char*"/>
			<field name="separator_len" type="size_t"/>
			<field name="fields_on_line" type="gboolean"/>
			<field name="buf" type="GString*"/>
		</object>
		<object name="GsfOutputGZip" parent="GsfOutput" type-name="GsfOutputGZip" get-type="gsf_output_gzip_get_type">
			<constructor name="new" symbol="gsf_output_gzip_new">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="sink" type="GsfOutput*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<property name="raw" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="sink" type="GsfOutput*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GsfOutputGio" parent="GsfOutput" type-name="GsfOutputGio" get-type="gsf_output_gio_get_type">
			<constructor name="new" symbol="gsf_output_gio_new">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</constructor>
			<constructor name="new_for_path" symbol="gsf_output_gio_new_for_path">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="path" type="char*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_for_uri" symbol="gsf_output_gio_new_for_uri">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="uri" type="char*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
		</object>
		<object name="GsfOutputIOChannel" parent="GsfOutput" type-name="GsfOutputIOChannel" get-type="gsf_output_iochannel_get_type">
			<constructor name="new" symbol="gsf_output_iochannel_new">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="channel" type="GIOChannel*"/>
				</parameters>
			</constructor>
		</object>
		<object name="GsfOutputIconv" parent="GsfOutput" type-name="GsfOutputIconv" get-type="gsf_output_iconv_get_type">
			<constructor name="new" symbol="gsf_output_iconv_new">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="sink" type="GsfOutput*"/>
					<parameter name="dst" type="char*"/>
					<parameter name="src" type="char*"/>
				</parameters>
			</constructor>
			<property name="fallback" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="input-charset" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="output-charset" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="sink" type="GsfOutput*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GsfOutputMemory" parent="GsfOutput" type-name="GsfOutputMemory" get-type="gsf_output_memory_get_type">
			<method name="get_bytes" symbol="gsf_output_memory_get_bytes">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="mem" type="GsfOutputMemory*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_output_memory_new">
				<return-type type="GsfOutput*"/>
			</constructor>
		</object>
		<object name="GsfOutputStdio" parent="GsfOutput" type-name="GsfOutputStdio" get-type="gsf_output_stdio_get_type">
			<constructor name="new" symbol="gsf_output_stdio_new">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_FILE" symbol="gsf_output_stdio_new_FILE">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="file" type="FILE*"/>
					<parameter name="keep_open" type="gboolean"/>
				</parameters>
			</constructor>
			<constructor name="new_full" symbol="gsf_output_stdio_new_full">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="err" type="GError**"/>
					<parameter name="first_property_name" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_valist" symbol="gsf_output_stdio_new_valist">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="err" type="GError**"/>
					<parameter name="first_property_name" type="char*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</constructor>
		</object>
		<object name="GsfSharedMemory" parent="GObject" type-name="GsfSharedMemory" get-type="gsf_shared_memory_get_type">
			<method name="mmapped_new" symbol="gsf_shared_memory_mmapped_new">
				<return-type type="GsfSharedMemory*"/>
				<parameters>
					<parameter name="buf" type="void*"/>
					<parameter name="size" type="gsf_off_t"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_shared_memory_new">
				<return-type type="GsfSharedMemory*"/>
				<parameters>
					<parameter name="buf" type="void*"/>
					<parameter name="size" type="gsf_off_t"/>
					<parameter name="needs_free" type="gboolean"/>
				</parameters>
			</constructor>
			<field name="buf" type="void*"/>
			<field name="size" type="gsf_off_t"/>
			<field name="needs_free" type="gboolean"/>
			<field name="needs_unmap" type="gboolean"/>
		</object>
		<object name="GsfStructuredBlob" parent="GsfInfile" type-name="GsfStructuredBlob" get-type="gsf_structured_blob_get_type">
			<method name="read" symbol="gsf_structured_blob_read">
				<return-type type="GsfStructuredBlob*"/>
				<parameters>
					<parameter name="input" type="GsfInput*"/>
				</parameters>
			</method>
			<method name="write" symbol="gsf_structured_blob_write">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="blob" type="GsfStructuredBlob*"/>
					<parameter name="container" type="GsfOutfile*"/>
				</parameters>
			</method>
		</object>
		<object name="GsfXMLOut" parent="GObject" type-name="GsfXMLOut" get-type="gsf_xml_out_get_type">
			<method name="add_base64" symbol="gsf_xml_out_add_base64">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="len" type="unsigned"/>
				</parameters>
			</method>
			<method name="add_bool" symbol="gsf_xml_out_add_bool">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="val" type="gboolean"/>
				</parameters>
			</method>
			<method name="add_color" symbol="gsf_xml_out_add_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="r" type="unsigned"/>
					<parameter name="g" type="unsigned"/>
					<parameter name="b" type="unsigned"/>
				</parameters>
			</method>
			<method name="add_cstr" symbol="gsf_xml_out_add_cstr">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="val_utf8" type="char*"/>
				</parameters>
			</method>
			<method name="add_cstr_unchecked" symbol="gsf_xml_out_add_cstr_unchecked">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="val_utf8" type="char*"/>
				</parameters>
			</method>
			<method name="add_enum" symbol="gsf_xml_out_add_enum">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="etype" type="GType"/>
					<parameter name="val" type="gint"/>
				</parameters>
			</method>
			<method name="add_float" symbol="gsf_xml_out_add_float">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="val" type="double"/>
					<parameter name="precision" type="int"/>
				</parameters>
			</method>
			<method name="add_gvalue" symbol="gsf_xml_out_add_gvalue">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="val" type="GValue*"/>
				</parameters>
			</method>
			<method name="add_int" symbol="gsf_xml_out_add_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="val" type="int"/>
				</parameters>
			</method>
			<method name="add_uint" symbol="gsf_xml_out_add_uint">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="val" type="unsigned"/>
				</parameters>
			</method>
			<method name="end_element" symbol="gsf_xml_out_end_element">
				<return-type type="char*"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
				</parameters>
			</method>
			<method name="get_output" symbol="gsf_xml_out_get_output">
				<return-type type="GsfOutput*"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gsf_xml_out_new">
				<return-type type="GsfXMLOut*"/>
				<parameters>
					<parameter name="output" type="GsfOutput*"/>
				</parameters>
			</constructor>
			<method name="set_doc_type" symbol="gsf_xml_out_set_doc_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="type" type="char*"/>
				</parameters>
			</method>
			<method name="simple_element" symbol="gsf_xml_out_simple_element">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="content" type="char*"/>
				</parameters>
			</method>
			<method name="simple_float_element" symbol="gsf_xml_out_simple_float_element">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="val" type="double"/>
					<parameter name="precision" type="int"/>
				</parameters>
			</method>
			<method name="simple_int_element" symbol="gsf_xml_out_simple_int_element">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
					<parameter name="val" type="int"/>
				</parameters>
			</method>
			<method name="start_element" symbol="gsf_xml_out_start_element">
				<return-type type="void"/>
				<parameters>
					<parameter name="xout" type="GsfXMLOut*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<property name="pretty-print" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<constant name="GSF_META_NAME_BYTE_COUNT" type="char*" value="gsf:byte-count"/>
		<constant name="GSF_META_NAME_CASE_SENSITIVE" type="char*" value="gsf:case-sensitivity"/>
		<constant name="GSF_META_NAME_CATEGORY" type="char*" value="gsf:category"/>
		<constant name="GSF_META_NAME_CELL_COUNT" type="char*" value="gsf:cell-count"/>
		<constant name="GSF_META_NAME_CHARACTER_COUNT" type="char*" value="gsf:character-count"/>
		<constant name="GSF_META_NAME_CODEPAGE" type="char*" value="msole:codepage"/>
		<constant name="GSF_META_NAME_COMPANY" type="char*" value="dc:publisher"/>
		<constant name="GSF_META_NAME_CREATOR" type="char*" value="dc:creator"/>
		<constant name="GSF_META_NAME_DATE_CREATED" type="char*" value="meta:creation-date"/>
		<constant name="GSF_META_NAME_DATE_MODIFIED" type="char*" value="dc:date"/>
		<constant name="GSF_META_NAME_DESCRIPTION" type="char*" value="dc:description"/>
		<constant name="GSF_META_NAME_DICTIONARY" type="char*" value="gsf:dictionary"/>
		<constant name="GSF_META_NAME_DOCUMENT_PARTS" type="char*" value="gsf:document-parts"/>
		<constant name="GSF_META_NAME_EDITING_DURATION" type="char*" value="meta:editing-duration"/>
		<constant name="GSF_META_NAME_GENERATOR" type="char*" value="meta:generator"/>
		<constant name="GSF_META_NAME_HEADING_PAIRS" type="char*" value="gsf:heading-pairs"/>
		<constant name="GSF_META_NAME_HIDDEN_SLIDE_COUNT" type="char*" value="gsf:hidden-slide-count"/>
		<constant name="GSF_META_NAME_IMAGE_COUNT" type="char*" value="gsf:image-count"/>
		<constant name="GSF_META_NAME_INITIAL_CREATOR" type="char*" value="meta:initial-creator"/>
		<constant name="GSF_META_NAME_KEYWORD" type="char*" value="meta:keyword"/>
		<constant name="GSF_META_NAME_KEYWORDS" type="char*" value="dc:keywords"/>
		<constant name="GSF_META_NAME_LANGUAGE" type="char*" value="dc:language"/>
		<constant name="GSF_META_NAME_LAST_PRINTED" type="char*" value="gsf:last-printed"/>
		<constant name="GSF_META_NAME_LAST_SAVED_BY" type="char*" value="gsf:last-saved-by"/>
		<constant name="GSF_META_NAME_LINE_COUNT" type="char*" value="gsf:line-count"/>
		<constant name="GSF_META_NAME_LINKS_DIRTY" type="char*" value="gsf:links-dirty"/>
		<constant name="GSF_META_NAME_LOCALE_SYSTEM_DEFAULT" type="char*" value="gsf:default-locale"/>
		<constant name="GSF_META_NAME_MANAGER" type="char*" value="gsf:manager"/>
		<constant name="GSF_META_NAME_MM_CLIP_COUNT" type="char*" value="gsf:MM-clip-count"/>
		<constant name="GSF_META_NAME_MSOLE_UNKNOWN_17" type="char*" value="msole:unknown-doc-17"/>
		<constant name="GSF_META_NAME_MSOLE_UNKNOWN_18" type="char*" value="msole:unknown-doc-18"/>
		<constant name="GSF_META_NAME_MSOLE_UNKNOWN_19" type="char*" value="msole:unknown-doc-19"/>
		<constant name="GSF_META_NAME_MSOLE_UNKNOWN_20" type="char*" value="msole:unknown-doc-20"/>
		<constant name="GSF_META_NAME_MSOLE_UNKNOWN_21" type="char*" value="msole:unknown-doc-21"/>
		<constant name="GSF_META_NAME_MSOLE_UNKNOWN_22" type="char*" value="msole:unknown-doc-22"/>
		<constant name="GSF_META_NAME_MSOLE_UNKNOWN_23" type="char*" value="msole:unknown-doc-23"/>
		<constant name="GSF_META_NAME_NOTE_COUNT" type="char*" value="gsf:note-count"/>
		<constant name="GSF_META_NAME_OBJECT_COUNT" type="char*" value="gsf:object-count"/>
		<constant name="GSF_META_NAME_PAGE_COUNT" type="char*" value="gsf:page-count"/>
		<constant name="GSF_META_NAME_PARAGRAPH_COUNT" type="char*" value="gsf:paragraph-count"/>
		<constant name="GSF_META_NAME_PRESENTATION_FORMAT" type="char*" value="gsf:presentation-format"/>
		<constant name="GSF_META_NAME_PRINTED_BY" type="char*" value="meta:printed-by"/>
		<constant name="GSF_META_NAME_PRINT_DATE" type="char*" value="meta:print-date"/>
		<constant name="GSF_META_NAME_REVISION_COUNT" type="char*" value="meta:editing-cycles"/>
		<constant name="GSF_META_NAME_SCALE" type="char*" value="gsf:scale"/>
		<constant name="GSF_META_NAME_SECURITY" type="char*" value="gsf:security"/>
		<constant name="GSF_META_NAME_SLIDE_COUNT" type="char*" value="gsf:slide-count"/>
		<constant name="GSF_META_NAME_SPREADSHEET_COUNT" type="char*" value="gsf:spreadsheet-count"/>
		<constant name="GSF_META_NAME_SUBJECT" type="char*" value="dc:subject"/>
		<constant name="GSF_META_NAME_TABLE_COUNT" type="char*" value="gsf:table-count"/>
		<constant name="GSF_META_NAME_TEMPLATE" type="char*" value="meta:template"/>
		<constant name="GSF_META_NAME_THUMBNAIL" type="char*" value="gsf:thumbnail"/>
		<constant name="GSF_META_NAME_TITLE" type="char*" value="dc:title"/>
		<constant name="GSF_META_NAME_WORD_COUNT" type="char*" value="gsf:word-count"/>
		<constant name="OLE_DEFAULT_BB_SHIFT" type="int" value="9"/>
		<constant name="OLE_DEFAULT_SB_SHIFT" type="int" value="6"/>
	</namespace>
</api>
