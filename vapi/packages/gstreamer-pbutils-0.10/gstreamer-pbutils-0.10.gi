<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="codec_utils_aac_caps_set_level_and_profile" symbol="gst_codec_utils_aac_caps_set_level_and_profile">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
				<parameter name="audio_config" type="guint8*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="codec_utils_aac_get_level" symbol="gst_codec_utils_aac_get_level">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="audio_config" type="guint8*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="codec_utils_aac_get_profile" symbol="gst_codec_utils_aac_get_profile">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="audio_config" type="guint8*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="codec_utils_aac_get_sample_rate_from_index" symbol="gst_codec_utils_aac_get_sample_rate_from_index">
			<return-type type="guint"/>
			<parameters>
				<parameter name="sr_idx" type="guint"/>
			</parameters>
		</function>
		<function name="codec_utils_h264_caps_set_level_and_profile" symbol="gst_codec_utils_h264_caps_set_level_and_profile">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
				<parameter name="sps" type="guint8*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="codec_utils_h264_get_level" symbol="gst_codec_utils_h264_get_level">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="sps" type="guint8*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="codec_utils_h264_get_level_idc" symbol="gst_codec_utils_h264_get_level_idc">
			<return-type type="guint8"/>
			<parameters>
				<parameter name="level" type="gchar*"/>
			</parameters>
		</function>
		<function name="codec_utils_h264_get_profile" symbol="gst_codec_utils_h264_get_profile">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="sps" type="guint8*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="codec_utils_mpeg4video_caps_set_level_and_profile" symbol="gst_codec_utils_mpeg4video_caps_set_level_and_profile">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
				<parameter name="vis_obj_seq" type="guint8*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="codec_utils_mpeg4video_get_level" symbol="gst_codec_utils_mpeg4video_get_level">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="vis_obj_seq" type="guint8*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="codec_utils_mpeg4video_get_profile" symbol="gst_codec_utils_mpeg4video_get_profile">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="vis_obj_seq" type="guint8*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="encoding_list_all_targets" symbol="gst_encoding_list_all_targets">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="categoryname" type="gchar*"/>
			</parameters>
		</function>
		<function name="encoding_list_available_categories" symbol="gst_encoding_list_available_categories">
			<return-type type="GList*"/>
		</function>
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
		<function name="plugins_base_version" symbol="gst_plugins_base_version">
			<return-type type="void"/>
			<parameters>
				<parameter name="major" type="guint*"/>
				<parameter name="minor" type="guint*"/>
				<parameter name="micro" type="guint*"/>
				<parameter name="nano" type="guint*"/>
			</parameters>
		</function>
		<function name="plugins_base_version_string" symbol="gst_plugins_base_version_string">
			<return-type type="gchar*"/>
		</function>
		<callback name="GstInstallPluginsResultFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="result" type="GstInstallPluginsReturn"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GstDiscovererAudioInfo">
			<method name="get_bitrate" symbol="gst_discoverer_audio_info_get_bitrate">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererAudioInfo*"/>
				</parameters>
			</method>
			<method name="get_channels" symbol="gst_discoverer_audio_info_get_channels">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererAudioInfo*"/>
				</parameters>
			</method>
			<method name="get_depth" symbol="gst_discoverer_audio_info_get_depth">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererAudioInfo*"/>
				</parameters>
			</method>
			<method name="get_max_bitrate" symbol="gst_discoverer_audio_info_get_max_bitrate">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererAudioInfo*"/>
				</parameters>
			</method>
			<method name="get_sample_rate" symbol="gst_discoverer_audio_info_get_sample_rate">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererAudioInfo*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstDiscovererAudioInfoClass">
		</struct>
		<struct name="GstDiscovererContainerInfo">
			<method name="get_streams" symbol="gst_discoverer_container_info_get_streams">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererContainerInfo*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstDiscovererContainerInfoClass">
		</struct>
		<struct name="GstDiscovererInfo">
			<method name="copy" symbol="gst_discoverer_info_copy">
				<return-type type="GstDiscovererInfo*"/>
				<parameters>
					<parameter name="ptr" type="GstDiscovererInfo*"/>
				</parameters>
			</method>
			<method name="get_audio_streams" symbol="gst_discoverer_info_get_audio_streams">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererInfo*"/>
				</parameters>
			</method>
			<method name="get_container_streams" symbol="gst_discoverer_info_get_container_streams">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererInfo*"/>
				</parameters>
			</method>
			<method name="get_duration" symbol="gst_discoverer_info_get_duration">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="info" type="GstDiscovererInfo*"/>
				</parameters>
			</method>
			<method name="get_misc" symbol="gst_discoverer_info_get_misc">
				<return-type type="GstStructure*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererInfo*"/>
				</parameters>
			</method>
			<method name="get_result" symbol="gst_discoverer_info_get_result">
				<return-type type="GstDiscovererResult"/>
				<parameters>
					<parameter name="info" type="GstDiscovererInfo*"/>
				</parameters>
			</method>
			<method name="get_seekable" symbol="gst_discoverer_info_get_seekable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GstDiscovererInfo*"/>
				</parameters>
			</method>
			<method name="get_stream_info" symbol="gst_discoverer_info_get_stream_info">
				<return-type type="GstDiscovererStreamInfo*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererInfo*"/>
				</parameters>
			</method>
			<method name="get_stream_list" symbol="gst_discoverer_info_get_stream_list">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererInfo*"/>
				</parameters>
			</method>
			<method name="get_streams" symbol="gst_discoverer_info_get_streams">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererInfo*"/>
					<parameter name="streamtype" type="GType"/>
				</parameters>
			</method>
			<method name="get_tags" symbol="gst_discoverer_info_get_tags">
				<return-type type="GstTagList*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererInfo*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="gst_discoverer_info_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererInfo*"/>
				</parameters>
			</method>
			<method name="get_video_streams" symbol="gst_discoverer_info_get_video_streams">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererInfo*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstDiscovererInfoClass">
		</struct>
		<struct name="GstDiscovererStreamInfo">
			<method name="get_caps" symbol="gst_discoverer_stream_info_get_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererStreamInfo*"/>
				</parameters>
			</method>
			<method name="get_misc" symbol="gst_discoverer_stream_info_get_misc">
				<return-type type="GstStructure*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererStreamInfo*"/>
				</parameters>
			</method>
			<method name="get_next" symbol="gst_discoverer_stream_info_get_next">
				<return-type type="GstDiscovererStreamInfo*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererStreamInfo*"/>
				</parameters>
			</method>
			<method name="get_previous" symbol="gst_discoverer_stream_info_get_previous">
				<return-type type="GstDiscovererStreamInfo*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererStreamInfo*"/>
				</parameters>
			</method>
			<method name="get_stream_type_nick" symbol="gst_discoverer_stream_info_get_stream_type_nick">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererStreamInfo*"/>
				</parameters>
			</method>
			<method name="get_tags" symbol="gst_discoverer_stream_info_get_tags">
				<return-type type="GstTagList*"/>
				<parameters>
					<parameter name="info" type="GstDiscovererStreamInfo*"/>
				</parameters>
			</method>
			<method name="list_free" symbol="gst_discoverer_stream_info_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="infos" type="GList*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstDiscovererStreamInfoClass">
		</struct>
		<struct name="GstDiscovererVideoInfo">
			<method name="get_bitrate" symbol="gst_discoverer_video_info_get_bitrate">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererVideoInfo*"/>
				</parameters>
			</method>
			<method name="get_depth" symbol="gst_discoverer_video_info_get_depth">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererVideoInfo*"/>
				</parameters>
			</method>
			<method name="get_framerate_denom" symbol="gst_discoverer_video_info_get_framerate_denom">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererVideoInfo*"/>
				</parameters>
			</method>
			<method name="get_framerate_num" symbol="gst_discoverer_video_info_get_framerate_num">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererVideoInfo*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="gst_discoverer_video_info_get_height">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererVideoInfo*"/>
				</parameters>
			</method>
			<method name="get_max_bitrate" symbol="gst_discoverer_video_info_get_max_bitrate">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererVideoInfo*"/>
				</parameters>
			</method>
			<method name="get_par_denom" symbol="gst_discoverer_video_info_get_par_denom">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererVideoInfo*"/>
				</parameters>
			</method>
			<method name="get_par_num" symbol="gst_discoverer_video_info_get_par_num">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererVideoInfo*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="gst_discoverer_video_info_get_width">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="GstDiscovererVideoInfo*"/>
				</parameters>
			</method>
			<method name="is_image" symbol="gst_discoverer_video_info_is_image">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GstDiscovererVideoInfo*"/>
				</parameters>
			</method>
			<method name="is_interlaced" symbol="gst_discoverer_video_info_is_interlaced">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GstDiscovererVideoInfo*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstDiscovererVideoInfoClass">
		</struct>
		<struct name="GstEncodingAudioProfile">
			<method name="new" symbol="gst_encoding_audio_profile_new">
				<return-type type="GstEncodingAudioProfile*"/>
				<parameters>
					<parameter name="format" type="GstCaps*"/>
					<parameter name="preset" type="gchar*"/>
					<parameter name="restriction" type="GstCaps*"/>
					<parameter name="presence" type="guint"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstEncodingAudioProfileClass">
		</struct>
		<struct name="GstEncodingContainerProfile">
			<method name="add_profile" symbol="gst_encoding_container_profile_add_profile">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="container" type="GstEncodingContainerProfile*"/>
					<parameter name="profile" type="GstEncodingProfile*"/>
				</parameters>
			</method>
			<method name="contains_profile" symbol="gst_encoding_container_profile_contains_profile">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="container" type="GstEncodingContainerProfile*"/>
					<parameter name="profile" type="GstEncodingProfile*"/>
				</parameters>
			</method>
			<method name="get_profiles" symbol="gst_encoding_container_profile_get_profiles">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="profile" type="GstEncodingContainerProfile*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_encoding_container_profile_new">
				<return-type type="GstEncodingContainerProfile*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="description" type="gchar*"/>
					<parameter name="format" type="GstCaps*"/>
					<parameter name="preset" type="gchar*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstEncodingContainerProfileClass">
		</struct>
		<struct name="GstEncodingProfile">
			<method name="find" symbol="gst_encoding_profile_find">
				<return-type type="GstEncodingProfile*"/>
				<parameters>
					<parameter name="targetname" type="gchar*"/>
					<parameter name="profilename" type="gchar*"/>
					<parameter name="category" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="gst_encoding_profile_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
				</parameters>
			</method>
			<method name="get_format" symbol="gst_encoding_profile_get_format">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
				</parameters>
			</method>
			<method name="get_input_caps" symbol="gst_encoding_profile_get_input_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gst_encoding_profile_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
				</parameters>
			</method>
			<method name="get_presence" symbol="gst_encoding_profile_get_presence">
				<return-type type="guint"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
				</parameters>
			</method>
			<method name="get_preset" symbol="gst_encoding_profile_get_preset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
				</parameters>
			</method>
			<method name="get_restriction" symbol="gst_encoding_profile_get_restriction">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
				</parameters>
			</method>
			<method name="get_type_nick" symbol="gst_encoding_profile_get_type_nick">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
				</parameters>
			</method>
			<method name="is_equal" symbol="gst_encoding_profile_is_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="a" type="GstEncodingProfile*"/>
					<parameter name="b" type="GstEncodingProfile*"/>
				</parameters>
			</method>
			<method name="set_description" symbol="gst_encoding_profile_set_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_format" symbol="gst_encoding_profile_set_format">
				<return-type type="void"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
					<parameter name="format" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="gst_encoding_profile_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_presence" symbol="gst_encoding_profile_set_presence">
				<return-type type="void"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
					<parameter name="presence" type="guint"/>
				</parameters>
			</method>
			<method name="set_preset" symbol="gst_encoding_profile_set_preset">
				<return-type type="void"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
					<parameter name="preset" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_restriction" symbol="gst_encoding_profile_set_restriction">
				<return-type type="void"/>
				<parameters>
					<parameter name="profile" type="GstEncodingProfile*"/>
					<parameter name="restriction" type="GstCaps*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstEncodingProfileClass">
		</struct>
		<struct name="GstEncodingTarget">
			<method name="add_profile" symbol="gst_encoding_target_add_profile">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="target" type="GstEncodingTarget*"/>
					<parameter name="profile" type="GstEncodingProfile*"/>
				</parameters>
			</method>
			<method name="get_category" symbol="gst_encoding_target_get_category">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="target" type="GstEncodingTarget*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="gst_encoding_target_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="target" type="GstEncodingTarget*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gst_encoding_target_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="target" type="GstEncodingTarget*"/>
				</parameters>
			</method>
			<method name="get_profile" symbol="gst_encoding_target_get_profile">
				<return-type type="GstEncodingProfile*"/>
				<parameters>
					<parameter name="target" type="GstEncodingTarget*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_profiles" symbol="gst_encoding_target_get_profiles">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="target" type="GstEncodingTarget*"/>
				</parameters>
			</method>
			<method name="load" symbol="gst_encoding_target_load">
				<return-type type="GstEncodingTarget*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="category" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="load_from_file" symbol="gst_encoding_target_load_from_file">
				<return-type type="GstEncodingTarget*"/>
				<parameters>
					<parameter name="filepath" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_encoding_target_new">
				<return-type type="GstEncodingTarget*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="category" type="gchar*"/>
					<parameter name="description" type="gchar*"/>
					<parameter name="profiles" type="GList*"/>
				</parameters>
			</method>
			<method name="save" symbol="gst_encoding_target_save">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="target" type="GstEncodingTarget*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="save_to_file" symbol="gst_encoding_target_save_to_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="target" type="GstEncodingTarget*"/>
					<parameter name="filepath" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstEncodingTargetClass">
		</struct>
		<struct name="GstEncodingVideoProfile">
			<method name="get_pass" symbol="gst_encoding_video_profile_get_pass">
				<return-type type="guint"/>
				<parameters>
					<parameter name="prof" type="GstEncodingVideoProfile*"/>
				</parameters>
			</method>
			<method name="get_variableframerate" symbol="gst_encoding_video_profile_get_variableframerate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="prof" type="GstEncodingVideoProfile*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_encoding_video_profile_new">
				<return-type type="GstEncodingVideoProfile*"/>
				<parameters>
					<parameter name="format" type="GstCaps*"/>
					<parameter name="preset" type="gchar*"/>
					<parameter name="restriction" type="GstCaps*"/>
					<parameter name="presence" type="guint"/>
				</parameters>
			</method>
			<method name="set_pass" symbol="gst_encoding_video_profile_set_pass">
				<return-type type="void"/>
				<parameters>
					<parameter name="prof" type="GstEncodingVideoProfile*"/>
					<parameter name="pass" type="guint"/>
				</parameters>
			</method>
			<method name="set_variableframerate" symbol="gst_encoding_video_profile_set_variableframerate">
				<return-type type="void"/>
				<parameters>
					<parameter name="prof" type="GstEncodingVideoProfile*"/>
					<parameter name="variableframerate" type="gboolean"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstEncodingVideoProfileClass">
		</struct>
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
		<enum name="GstDiscovererResult" type-name="GstDiscovererResult" get-type="gst_discoverer_result_get_type">
			<member name="GST_DISCOVERER_OK" value="0"/>
			<member name="GST_DISCOVERER_URI_INVALID" value="1"/>
			<member name="GST_DISCOVERER_ERROR" value="2"/>
			<member name="GST_DISCOVERER_TIMEOUT" value="3"/>
			<member name="GST_DISCOVERER_BUSY" value="4"/>
			<member name="GST_DISCOVERER_MISSING_PLUGINS" value="5"/>
		</enum>
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
		<object name="GstDiscoverer" parent="GObject" type-name="GstDiscoverer" get-type="gst_discoverer_get_type">
			<method name="discover_uri" symbol="gst_discoverer_discover_uri">
				<return-type type="GstDiscovererInfo*"/>
				<parameters>
					<parameter name="discoverer" type="GstDiscoverer*"/>
					<parameter name="uri" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="discover_uri_async" symbol="gst_discoverer_discover_uri_async">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="discoverer" type="GstDiscoverer*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_discoverer_new">
				<return-type type="GstDiscoverer*"/>
				<parameters>
					<parameter name="timeout" type="GstClockTime"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</constructor>
			<method name="start" symbol="gst_discoverer_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="discoverer" type="GstDiscoverer*"/>
				</parameters>
			</method>
			<method name="stop" symbol="gst_discoverer_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="discoverer" type="GstDiscoverer*"/>
				</parameters>
			</method>
			<property name="timeout" type="guint64" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="discovered" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="discoverer" type="GstDiscoverer*"/>
					<parameter name="info" type="GstDiscovererInfo"/>
					<parameter name="err" type="GError*"/>
				</parameters>
			</signal>
			<signal name="finished" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="discoverer" type="GstDiscoverer*"/>
				</parameters>
			</signal>
			<signal name="starting" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="discoverer" type="GstDiscoverer*"/>
				</parameters>
			</signal>
		</object>
		<constant name="GST_ENCODING_CATEGORY_CAPTURE" type="char*" value="capture"/>
		<constant name="GST_ENCODING_CATEGORY_DEVICE" type="char*" value="device"/>
		<constant name="GST_ENCODING_CATEGORY_ONLINE_SERVICE" type="char*" value="online-service"/>
		<constant name="GST_ENCODING_CATEGORY_STORAGE_EDITING" type="char*" value="storage-editing"/>
		<constant name="GST_PLUGINS_BASE_VERSION_MAJOR" type="int" value="0"/>
		<constant name="GST_PLUGINS_BASE_VERSION_MICRO" type="int" value="35"/>
		<constant name="GST_PLUGINS_BASE_VERSION_MINOR" type="int" value="10"/>
		<constant name="GST_PLUGINS_BASE_VERSION_NANO" type="int" value="1"/>
	</namespace>
</api>
