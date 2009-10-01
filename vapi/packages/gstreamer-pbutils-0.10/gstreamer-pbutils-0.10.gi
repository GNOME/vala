<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="install_plugins_async" symbol="gst_install_plugins_async">
			<return-type type="GstInstallPluginsReturn"/>
			<parameters>
				<parameter name="details" type="gchar**"/>
				<parameter name="ctx" type="GstInstallPluginsContext*"/>
				<parameter name="func" type="GstInstallPluginsResultFunc"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="install_plugins_installation_in_progress" symbol="gst_install_plugins_installation_in_progress">
			<return-type type="gboolean"/>
		</function>
		<function name="install_plugins_return_get_name" symbol="gst_install_plugins_return_get_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="ret" type="GstInstallPluginsReturn"/>
			</parameters>
		</function>
		<function name="install_plugins_supported" symbol="gst_install_plugins_supported">
			<return-type type="gboolean"/>
		</function>
		<function name="install_plugins_sync" symbol="gst_install_plugins_sync">
			<return-type type="GstInstallPluginsReturn"/>
			<parameters>
				<parameter name="details" type="gchar**"/>
				<parameter name="ctx" type="GstInstallPluginsContext*"/>
			</parameters>
		</function>
		<function name="is_missing_plugin_message" symbol="gst_is_missing_plugin_message">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="msg" type="GstMessage*"/>
			</parameters>
		</function>
		<function name="missing_decoder_installer_detail_new" symbol="gst_missing_decoder_installer_detail_new">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="decode_caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="missing_decoder_message_new" symbol="gst_missing_decoder_message_new">
			<return-type type="GstMessage*"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="decode_caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="missing_element_installer_detail_new" symbol="gst_missing_element_installer_detail_new">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="factory_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="missing_element_message_new" symbol="gst_missing_element_message_new">
			<return-type type="GstMessage*"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="factory_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="missing_encoder_installer_detail_new" symbol="gst_missing_encoder_installer_detail_new">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="encode_caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="missing_encoder_message_new" symbol="gst_missing_encoder_message_new">
			<return-type type="GstMessage*"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="encode_caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="missing_plugin_message_get_description" symbol="gst_missing_plugin_message_get_description">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="msg" type="GstMessage*"/>
			</parameters>
		</function>
		<function name="missing_plugin_message_get_installer_detail" symbol="gst_missing_plugin_message_get_installer_detail">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="msg" type="GstMessage*"/>
			</parameters>
		</function>
		<function name="missing_uri_sink_installer_detail_new" symbol="gst_missing_uri_sink_installer_detail_new">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="protocol" type="gchar*"/>
			</parameters>
		</function>
		<function name="missing_uri_sink_message_new" symbol="gst_missing_uri_sink_message_new">
			<return-type type="GstMessage*"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="protocol" type="gchar*"/>
			</parameters>
		</function>
		<function name="missing_uri_source_installer_detail_new" symbol="gst_missing_uri_source_installer_detail_new">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="protocol" type="gchar*"/>
			</parameters>
		</function>
		<function name="missing_uri_source_message_new" symbol="gst_missing_uri_source_message_new">
			<return-type type="GstMessage*"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="protocol" type="gchar*"/>
			</parameters>
		</function>
		<function name="pb_utils_add_codec_description_to_tag_list" symbol="gst_pb_utils_add_codec_description_to_tag_list">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="taglist" type="GstTagList*"/>
				<parameter name="codec_tag" type="gchar*"/>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="pb_utils_get_codec_description" symbol="gst_pb_utils_get_codec_description">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="pb_utils_get_decoder_description" symbol="gst_pb_utils_get_decoder_description">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="pb_utils_get_element_description" symbol="gst_pb_utils_get_element_description">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="factory_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="pb_utils_get_encoder_description" symbol="gst_pb_utils_get_encoder_description">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="pb_utils_get_sink_description" symbol="gst_pb_utils_get_sink_description">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="protocol" type="gchar*"/>
			</parameters>
		</function>
		<function name="pb_utils_get_source_description" symbol="gst_pb_utils_get_source_description">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="protocol" type="gchar*"/>
			</parameters>
		</function>
		<function name="pb_utils_init" symbol="gst_pb_utils_init">
			<return-type type="void"/>
		</function>
		<callback name="GstInstallPluginsResultFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="result" type="GstInstallPluginsReturn"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<boxed name="GstInstallPluginsContext" type-name="GstInstallPluginsContext" get-type="gst_install_plugins_context_get_type">
			<method name="free" symbol="gst_install_plugins_context_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="ctx" type="GstInstallPluginsContext*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_install_plugins_context_new">
				<return-type type="GstInstallPluginsContext*"/>
			</constructor>
			<method name="set_xid" symbol="gst_install_plugins_context_set_xid">
				<return-type type="void"/>
				<parameters>
					<parameter name="ctx" type="GstInstallPluginsContext*"/>
					<parameter name="xid" type="guint"/>
				</parameters>
			</method>
		</boxed>
		<enum name="GstInstallPluginsReturn" type-name="GstInstallPluginsReturn" get-type="gst_install_plugins_return_get_type">
			<member name="GST_INSTALL_PLUGINS_SUCCESS" value="0"/>
			<member name="GST_INSTALL_PLUGINS_NOT_FOUND" value="1"/>
			<member name="GST_INSTALL_PLUGINS_ERROR" value="2"/>
			<member name="GST_INSTALL_PLUGINS_PARTIAL_SUCCESS" value="3"/>
			<member name="GST_INSTALL_PLUGINS_USER_ABORT" value="4"/>
			<member name="GST_INSTALL_PLUGINS_CRASHED" value="100"/>
			<member name="GST_INSTALL_PLUGINS_INVALID" value="101"/>
			<member name="GST_INSTALL_PLUGINS_STARTED_OK" value="200"/>
			<member name="GST_INSTALL_PLUGINS_INTERNAL_FAILURE" value="201"/>
			<member name="GST_INSTALL_PLUGINS_HELPER_MISSING" value="202"/>
			<member name="GST_INSTALL_PLUGINS_INSTALL_IN_PROGRESS" value="203"/>
		</enum>
	</namespace>
</api>
