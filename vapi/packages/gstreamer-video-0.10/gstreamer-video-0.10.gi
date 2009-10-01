<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="base_video_encoded_video_convert" symbol="gst_base_video_encoded_video_convert">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="state" type="GstVideoState*"/>
				<parameter name="src_format" type="GstFormat"/>
				<parameter name="src_value" type="gint64"/>
				<parameter name="dest_format" type="GstFormat*"/>
				<parameter name="dest_value" type="gint64*"/>
			</parameters>
		</function>
		<function name="base_video_rawvideo_convert" symbol="gst_base_video_rawvideo_convert">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="state" type="GstVideoState*"/>
				<parameter name="src_format" type="GstFormat"/>
				<parameter name="src_value" type="gint64"/>
				<parameter name="dest_format" type="GstFormat*"/>
				<parameter name="dest_value" type="gint64*"/>
			</parameters>
		</function>
		<function name="base_video_state_from_caps" symbol="gst_base_video_state_from_caps">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="state" type="GstVideoState*"/>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="video_calculate_display_ratio" symbol="gst_video_calculate_display_ratio">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="dar_n" type="guint*"/>
				<parameter name="dar_d" type="guint*"/>
				<parameter name="video_width" type="guint"/>
				<parameter name="video_height" type="guint"/>
				<parameter name="video_par_n" type="guint"/>
				<parameter name="video_par_d" type="guint"/>
				<parameter name="display_par_n" type="guint"/>
				<parameter name="display_par_d" type="guint"/>
			</parameters>
		</function>
		<function name="video_format_convert" symbol="gst_video_format_convert">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
				<parameter name="fps_n" type="int"/>
				<parameter name="fps_d" type="int"/>
				<parameter name="src_format" type="GstFormat"/>
				<parameter name="src_value" type="gint64"/>
				<parameter name="dest_format" type="GstFormat"/>
				<parameter name="dest_value" type="gint64*"/>
			</parameters>
		</function>
		<function name="video_format_from_fourcc" symbol="gst_video_format_from_fourcc">
			<return-type type="GstVideoFormat"/>
			<parameters>
				<parameter name="fourcc" type="guint32"/>
			</parameters>
		</function>
		<function name="video_format_get_component_height" symbol="gst_video_format_get_component_height">
			<return-type type="int"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
				<parameter name="component" type="int"/>
				<parameter name="height" type="int"/>
			</parameters>
		</function>
		<function name="video_format_get_component_offset" symbol="gst_video_format_get_component_offset">
			<return-type type="int"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
				<parameter name="component" type="int"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
			</parameters>
		</function>
		<function name="video_format_get_component_width" symbol="gst_video_format_get_component_width">
			<return-type type="int"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
				<parameter name="component" type="int"/>
				<parameter name="width" type="int"/>
			</parameters>
		</function>
		<function name="video_format_get_pixel_stride" symbol="gst_video_format_get_pixel_stride">
			<return-type type="int"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
				<parameter name="component" type="int"/>
			</parameters>
		</function>
		<function name="video_format_get_row_stride" symbol="gst_video_format_get_row_stride">
			<return-type type="int"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
				<parameter name="component" type="int"/>
				<parameter name="width" type="int"/>
			</parameters>
		</function>
		<function name="video_format_get_size" symbol="gst_video_format_get_size">
			<return-type type="int"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
			</parameters>
		</function>
		<function name="video_format_has_alpha" symbol="gst_video_format_has_alpha">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
			</parameters>
		</function>
		<function name="video_format_is_rgb" symbol="gst_video_format_is_rgb">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
			</parameters>
		</function>
		<function name="video_format_is_yuv" symbol="gst_video_format_is_yuv">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
			</parameters>
		</function>
		<function name="video_format_new_caps" symbol="gst_video_format_new_caps">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
				<parameter name="framerate_n" type="int"/>
				<parameter name="framerate_d" type="int"/>
				<parameter name="par_n" type="int"/>
				<parameter name="par_d" type="int"/>
			</parameters>
		</function>
		<function name="video_format_new_caps_interlaced" symbol="gst_video_format_new_caps_interlaced">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
				<parameter name="framerate_n" type="int"/>
				<parameter name="framerate_d" type="int"/>
				<parameter name="par_n" type="int"/>
				<parameter name="par_d" type="int"/>
				<parameter name="interlaced" type="gboolean"/>
			</parameters>
		</function>
		<function name="video_format_parse_caps" symbol="gst_video_format_parse_caps">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
				<parameter name="format" type="GstVideoFormat*"/>
				<parameter name="width" type="int*"/>
				<parameter name="height" type="int*"/>
			</parameters>
		</function>
		<function name="video_format_parse_caps_interlaced" symbol="gst_video_format_parse_caps_interlaced">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
				<parameter name="interlaced" type="gboolean*"/>
			</parameters>
		</function>
		<function name="video_format_to_fourcc" symbol="gst_video_format_to_fourcc">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
			</parameters>
		</function>
		<function name="video_get_size" symbol="gst_video_get_size">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="width" type="gint*"/>
				<parameter name="height" type="gint*"/>
			</parameters>
		</function>
		<function name="video_parse_caps_framerate" symbol="gst_video_parse_caps_framerate">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
				<parameter name="fps_n" type="int*"/>
				<parameter name="fps_d" type="int*"/>
			</parameters>
		</function>
		<function name="video_parse_caps_pixel_aspect_ratio" symbol="gst_video_parse_caps_pixel_aspect_ratio">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
				<parameter name="par_n" type="int*"/>
				<parameter name="par_d" type="int*"/>
			</parameters>
		</function>
		<struct name="GstBaseVideoCodec">
			<method name="free_frame" symbol="gst_base_video_codec_free_frame">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="GstVideoFrame*"/>
				</parameters>
			</method>
			<method name="new_frame" symbol="gst_base_video_codec_new_frame">
				<return-type type="GstVideoFrame*"/>
				<parameters>
					<parameter name="base_video_codec" type="GstBaseVideoCodec*"/>
				</parameters>
			</method>
			<field name="element" type="GstElement"/>
			<field name="sinkpad" type="GstPad*"/>
			<field name="srcpad" type="GstPad*"/>
			<field name="input_adapter" type="GstAdapter*"/>
			<field name="output_adapter" type="GstAdapter*"/>
			<field name="system_frame_number" type="guint64"/>
			<field name="timestamp_offset" type="GstClockTime"/>
		</struct>
		<struct name="GstBaseVideoCodecClass">
			<field name="element_class" type="GstElementClass"/>
			<field name="start" type="GCallback"/>
			<field name="stop" type="GCallback"/>
			<field name="reset" type="GCallback"/>
			<field name="parse_data" type="GCallback"/>
			<field name="scan_for_sync" type="GCallback"/>
			<field name="shape_output" type="GCallback"/>
			<field name="get_caps" type="GCallback"/>
		</struct>
		<struct name="GstBaseVideoDecoder">
			<method name="add_to_frame" symbol="gst_base_video_decoder_add_to_frame">
				<return-type type="void"/>
				<parameters>
					<parameter name="base_video_decoder" type="GstBaseVideoDecoder*"/>
					<parameter name="n_bytes" type="int"/>
				</parameters>
			</method>
			<method name="end_of_stream" symbol="gst_base_video_decoder_end_of_stream">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="base_video_decoder" type="GstBaseVideoDecoder*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="finish_frame" symbol="gst_base_video_decoder_finish_frame">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="base_video_decoder" type="GstBaseVideoDecoder*"/>
					<parameter name="frame" type="GstVideoFrame*"/>
				</parameters>
			</method>
			<method name="get_frame" symbol="gst_base_video_decoder_get_frame">
				<return-type type="GstVideoFrame*"/>
				<parameters>
					<parameter name="coder" type="GstBaseVideoDecoder*"/>
					<parameter name="frame_number" type="int"/>
				</parameters>
			</method>
			<method name="get_height" symbol="gst_base_video_decoder_get_height">
				<return-type type="int"/>
				<parameters>
					<parameter name="coder" type="GstBaseVideoDecoder*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="gst_base_video_decoder_get_state">
				<return-type type="GstVideoState*"/>
				<parameters>
					<parameter name="base_video_decoder" type="GstBaseVideoDecoder*"/>
				</parameters>
			</method>
			<method name="get_timestamp_offset" symbol="gst_base_video_decoder_get_timestamp_offset">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="coder" type="GstBaseVideoDecoder*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="gst_base_video_decoder_get_width">
				<return-type type="int"/>
				<parameters>
					<parameter name="coder" type="GstBaseVideoDecoder*"/>
				</parameters>
			</method>
			<method name="have_frame" symbol="gst_base_video_decoder_have_frame">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="base_video_decoder" type="GstBaseVideoDecoder*"/>
				</parameters>
			</method>
			<method name="lost_sync" symbol="gst_base_video_decoder_lost_sync">
				<return-type type="void"/>
				<parameters>
					<parameter name="base_video_decoder" type="GstBaseVideoDecoder*"/>
				</parameters>
			</method>
			<method name="set_src_caps" symbol="gst_base_video_decoder_set_src_caps">
				<return-type type="void"/>
				<parameters>
					<parameter name="base_video_decoder" type="GstBaseVideoDecoder*"/>
				</parameters>
			</method>
			<method name="set_state" symbol="gst_base_video_decoder_set_state">
				<return-type type="void"/>
				<parameters>
					<parameter name="base_video_decoder" type="GstBaseVideoDecoder*"/>
					<parameter name="state" type="GstVideoState*"/>
				</parameters>
			</method>
			<method name="set_sync_point" symbol="gst_base_video_decoder_set_sync_point">
				<return-type type="void"/>
				<parameters>
					<parameter name="base_video_decoder" type="GstBaseVideoDecoder*"/>
				</parameters>
			</method>
			<field name="base_video_codec" type="GstBaseVideoCodec"/>
			<field name="input_adapter" type="GstAdapter*"/>
			<field name="output_adapter" type="GstAdapter*"/>
			<field name="frames" type="GList*"/>
			<field name="have_sync" type="gboolean"/>
			<field name="discont" type="gboolean"/>
			<field name="started" type="gboolean"/>
			<field name="state" type="GstVideoState"/>
			<field name="sink_clipping" type="gboolean"/>
			<field name="presentation_frame_number" type="guint64"/>
			<field name="system_frame_number" type="guint64"/>
			<field name="caps" type="GstCaps*"/>
			<field name="have_src_caps" type="gboolean"/>
			<field name="current_frame" type="GstVideoFrame*"/>
			<field name="distance_from_sync" type="int"/>
			<field name="reorder_depth" type="int"/>
			<field name="buffer_timestamp" type="GstClockTime"/>
			<field name="timestamp_offset" type="GstClockTime"/>
			<field name="proportion" type="gdouble"/>
			<field name="earliest_time" type="GstClockTime"/>
			<field name="codec_data" type="GstBuffer*"/>
			<field name="offset" type="guint64"/>
			<field name="last_timestamp" type="GstClockTime"/>
			<field name="last_sink_timestamp" type="GstClockTime"/>
			<field name="last_sink_offset_end" type="GstClockTime"/>
			<field name="base_picture_number" type="guint64"/>
			<field name="field_index" type="int"/>
		</struct>
		<struct name="GstBaseVideoDecoderClass">
			<field name="base_video_codec_class" type="GstBaseVideoCodecClass"/>
			<field name="set_format" type="GCallback"/>
			<field name="start" type="GCallback"/>
			<field name="stop" type="GCallback"/>
			<field name="reset" type="GCallback"/>
			<field name="scan_for_sync" type="GCallback"/>
			<field name="parse_data" type="GCallback"/>
			<field name="finish" type="GCallback"/>
			<field name="handle_frame" type="GCallback"/>
			<field name="shape_output" type="GCallback"/>
			<field name="get_caps" type="GCallback"/>
		</struct>
		<struct name="GstBaseVideoEncoder">
			<method name="end_of_stream" symbol="gst_base_video_encoder_end_of_stream">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="base_video_encoder" type="GstBaseVideoEncoder*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="finish_frame" symbol="gst_base_video_encoder_finish_frame">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="base_video_encoder" type="GstBaseVideoEncoder*"/>
					<parameter name="frame" type="GstVideoFrame*"/>
				</parameters>
			</method>
			<method name="get_frame" symbol="gst_base_video_encoder_get_frame">
				<return-type type="GstVideoFrame*"/>
				<parameters>
					<parameter name="coder" type="GstBaseVideoEncoder*"/>
					<parameter name="frame_number" type="int"/>
				</parameters>
			</method>
			<method name="get_height" symbol="gst_base_video_encoder_get_height">
				<return-type type="int"/>
				<parameters>
					<parameter name="coder" type="GstBaseVideoEncoder*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="gst_base_video_encoder_get_state">
				<return-type type="GstVideoState*"/>
				<parameters>
					<parameter name="coder" type="GstBaseVideoEncoder*"/>
				</parameters>
			</method>
			<method name="get_timestamp_offset" symbol="gst_base_video_encoder_get_timestamp_offset">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="coder" type="GstBaseVideoEncoder*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="gst_base_video_encoder_get_width">
				<return-type type="int"/>
				<parameters>
					<parameter name="coder" type="GstBaseVideoEncoder*"/>
				</parameters>
			</method>
			<method name="set_latency" symbol="gst_base_video_encoder_set_latency">
				<return-type type="void"/>
				<parameters>
					<parameter name="base_video_encoder" type="GstBaseVideoEncoder*"/>
					<parameter name="min_latency" type="GstClockTime"/>
					<parameter name="max_latency" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="set_latency_fields" symbol="gst_base_video_encoder_set_latency_fields">
				<return-type type="void"/>
				<parameters>
					<parameter name="base_video_encoder" type="GstBaseVideoEncoder*"/>
					<parameter name="n_fields" type="int"/>
				</parameters>
			</method>
			<field name="base_video_codec" type="GstBaseVideoCodec"/>
			<field name="frames" type="GList*"/>
			<field name="state" type="GstVideoState"/>
			<field name="sink_clipping" type="gboolean"/>
			<field name="presentation_frame_number" type="guint64"/>
			<field name="system_frame_number" type="guint64"/>
			<field name="distance_from_sync" type="int"/>
			<field name="caps" type="GstCaps*"/>
			<field name="set_output_caps" type="gboolean"/>
			<field name="min_latency" type="gint64"/>
			<field name="max_latency" type="gint64"/>
		</struct>
		<struct name="GstBaseVideoEncoderClass">
			<field name="base_video_codec_class" type="GstBaseVideoCodecClass"/>
			<field name="set_format" type="GCallback"/>
			<field name="start" type="GCallback"/>
			<field name="stop" type="GCallback"/>
			<field name="finish" type="GCallback"/>
			<field name="handle_frame" type="GCallback"/>
			<field name="shape_output" type="GCallback"/>
			<field name="get_caps" type="GCallback"/>
		</struct>
		<struct name="GstBaseVideoParse">
			<method name="add_to_frame" symbol="gst_base_video_parse_add_to_frame">
				<return-type type="void"/>
				<parameters>
					<parameter name="base_video_parse" type="GstBaseVideoParse*"/>
					<parameter name="n_bytes" type="int"/>
				</parameters>
			</method>
			<method name="end_of_stream" symbol="gst_base_video_parse_end_of_stream">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="base_video_parse" type="GstBaseVideoParse*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="finish_frame" symbol="gst_base_video_parse_finish_frame">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="base_video_parse" type="GstBaseVideoParse*"/>
				</parameters>
			</method>
			<method name="get_frame" symbol="gst_base_video_parse_get_frame">
				<return-type type="GstVideoFrame*"/>
				<parameters>
					<parameter name="base_video_parse" type="GstBaseVideoParse*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="gst_base_video_parse_get_height">
				<return-type type="int"/>
				<parameters>
					<parameter name="parse" type="GstBaseVideoParse*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="gst_base_video_parse_get_state">
				<return-type type="GstVideoState*"/>
				<parameters>
					<parameter name="parse" type="GstBaseVideoParse*"/>
				</parameters>
			</method>
			<method name="get_timestamp_offset" symbol="gst_base_video_parse_get_timestamp_offset">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="parse" type="GstBaseVideoParse*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="gst_base_video_parse_get_width">
				<return-type type="int"/>
				<parameters>
					<parameter name="parse" type="GstBaseVideoParse*"/>
				</parameters>
			</method>
			<method name="lost_sync" symbol="gst_base_video_parse_lost_sync">
				<return-type type="void"/>
				<parameters>
					<parameter name="base_video_parse" type="GstBaseVideoParse*"/>
				</parameters>
			</method>
			<method name="push" symbol="gst_base_video_parse_push">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="base_video_parse" type="GstBaseVideoParse*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="set_src_caps" symbol="gst_base_video_parse_set_src_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="base_video_parse" type="GstBaseVideoParse*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="set_state" symbol="gst_base_video_parse_set_state">
				<return-type type="void"/>
				<parameters>
					<parameter name="parse" type="GstBaseVideoParse*"/>
					<parameter name="state" type="GstVideoState*"/>
				</parameters>
			</method>
			<method name="set_sync_point" symbol="gst_base_video_parse_set_sync_point">
				<return-type type="void"/>
				<parameters>
					<parameter name="base_video_parse" type="GstBaseVideoParse*"/>
				</parameters>
			</method>
			<field name="base_video_codec" type="GstBaseVideoCodec"/>
			<field name="input_adapter" type="GstAdapter*"/>
			<field name="output_adapter" type="GstAdapter*"/>
			<field name="reorder_depth" type="int"/>
			<field name="have_sync" type="gboolean"/>
			<field name="discont" type="gboolean"/>
			<field name="started" type="gboolean"/>
			<field name="current_frame" type="GstVideoFrame*"/>
			<field name="state" type="GstVideoState"/>
			<field name="distance_from_sync" type="int"/>
			<field name="sink_clipping" type="gboolean"/>
			<field name="presentation_frame_number" type="guint64"/>
			<field name="system_frame_number" type="guint64"/>
			<field name="caps" type="GstCaps*"/>
			<field name="set_output_caps" type="gboolean"/>
			<field name="last_timestamp" type="GstClockTime"/>
			<field name="timestamp_offset" type="gint64"/>
		</struct>
		<struct name="GstBaseVideoParseClass">
			<field name="base_video_codec_class" type="GstBaseVideoCodecClass"/>
			<field name="start" type="GCallback"/>
			<field name="stop" type="GCallback"/>
			<field name="reset" type="GCallback"/>
			<field name="parse_data" type="GCallback"/>
			<field name="scan_for_sync" type="GCallback"/>
			<field name="shape_output" type="GCallback"/>
			<field name="get_caps" type="GCallback"/>
		</struct>
		<struct name="GstVideoFrame">
			<method name="rate" symbol="gst_video_frame_rate">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<field name="decode_timestamp" type="guint64"/>
			<field name="presentation_timestamp" type="guint64"/>
			<field name="presentation_duration" type="guint64"/>
			<field name="system_frame_number" type="gint"/>
			<field name="decode_frame_number" type="gint"/>
			<field name="presentation_frame_number" type="gint"/>
			<field name="distance_from_sync" type="int"/>
			<field name="is_sync_point" type="gboolean"/>
			<field name="is_eos" type="gboolean"/>
			<field name="sink_buffer" type="GstBuffer*"/>
			<field name="src_buffer" type="GstBuffer*"/>
			<field name="field_index" type="int"/>
			<field name="n_fields" type="int"/>
			<field name="coder_hook" type="void*"/>
		</struct>
		<struct name="GstVideoRectangle">
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
			<field name="w" type="gint"/>
			<field name="h" type="gint"/>
		</struct>
		<struct name="GstVideoState">
			<method name="get_timestamp" symbol="gst_video_state_get_timestamp">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="state" type="GstVideoState*"/>
					<parameter name="frame_number" type="int"/>
				</parameters>
			</method>
			<field name="format" type="GstVideoFormat"/>
			<field name="width" type="int"/>
			<field name="height" type="int"/>
			<field name="fps_n" type="int"/>
			<field name="fps_d" type="int"/>
			<field name="par_n" type="int"/>
			<field name="par_d" type="int"/>
			<field name="interlaced" type="gboolean"/>
			<field name="top_field_first" type="gboolean"/>
			<field name="clean_width" type="int"/>
			<field name="clean_height" type="int"/>
			<field name="clean_offset_left" type="int"/>
			<field name="clean_offset_top" type="int"/>
			<field name="bytes_per_picture" type="int"/>
			<field name="segment" type="GstSegment"/>
			<field name="picture_number" type="int"/>
		</struct>
		<enum name="GstVideoFormat" type-name="GstVideoFormat" get-type="gst_video_format_get_type">
			<member name="GST_VIDEO_FORMAT_UNKNOWN" value="0"/>
			<member name="GST_VIDEO_FORMAT_I420" value="1"/>
			<member name="GST_VIDEO_FORMAT_YV12" value="2"/>
			<member name="GST_VIDEO_FORMAT_YUY2" value="3"/>
			<member name="GST_VIDEO_FORMAT_UYVY" value="4"/>
			<member name="GST_VIDEO_FORMAT_AYUV" value="5"/>
			<member name="GST_VIDEO_FORMAT_RGBx" value="6"/>
			<member name="GST_VIDEO_FORMAT_BGRx" value="7"/>
			<member name="GST_VIDEO_FORMAT_xRGB" value="8"/>
			<member name="GST_VIDEO_FORMAT_xBGR" value="9"/>
			<member name="GST_VIDEO_FORMAT_RGBA" value="10"/>
			<member name="GST_VIDEO_FORMAT_BGRA" value="11"/>
			<member name="GST_VIDEO_FORMAT_ARGB" value="12"/>
			<member name="GST_VIDEO_FORMAT_ABGR" value="13"/>
			<member name="GST_VIDEO_FORMAT_RGB" value="14"/>
			<member name="GST_VIDEO_FORMAT_BGR" value="15"/>
			<member name="GST_VIDEO_FORMAT_Y41B" value="16"/>
			<member name="GST_VIDEO_FORMAT_Y42B" value="17"/>
			<member name="GST_VIDEO_FORMAT_YVYU" value="18"/>
			<member name="GST_VIDEO_FORMAT_Y444" value="19"/>
			<member name="GST_VIDEO_FORMAT_v210" value="20"/>
			<member name="GST_VIDEO_FORMAT_v216" value="21"/>
		</enum>
		<object name="GstVideoFilter" parent="GstBaseTransform" type-name="GstVideoFilter" get-type="gst_video_filter_get_type">
			<field name="inited" type="gboolean"/>
		</object>
		<object name="GstVideoSink" parent="GstBaseSink" type-name="GstVideoSink" get-type="gst_video_sink_get_type">
			<method name="center_rect" symbol="gst_video_sink_center_rect">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstVideoRectangle"/>
					<parameter name="dst" type="GstVideoRectangle"/>
					<parameter name="result" type="GstVideoRectangle*"/>
					<parameter name="scaling" type="gboolean"/>
				</parameters>
			</method>
			<field name="width" type="gint"/>
			<field name="height" type="gint"/>
		</object>
		<constant name="GST_BASE_VIDEO_CODEC_SINK_NAME" type="char*" value="sink"/>
		<constant name="GST_BASE_VIDEO_CODEC_SRC_NAME" type="char*" value="src"/>
		<constant name="GST_BASE_VIDEO_DECODER_SINK_NAME" type="char*" value="sink"/>
		<constant name="GST_BASE_VIDEO_DECODER_SRC_NAME" type="char*" value="src"/>
		<constant name="GST_BASE_VIDEO_ENCODER_SINK_NAME" type="char*" value="sink"/>
		<constant name="GST_BASE_VIDEO_ENCODER_SRC_NAME" type="char*" value="src"/>
		<constant name="GST_BASE_VIDEO_PARSE_SINK_NAME" type="char*" value="sink"/>
		<constant name="GST_BASE_VIDEO_PARSE_SRC_NAME" type="char*" value="src"/>
		<constant name="GST_VIDEO_BLUE_MASK_15" type="char*" value="0x001f"/>
		<constant name="GST_VIDEO_BLUE_MASK_15_INT" type="int" value="31"/>
		<constant name="GST_VIDEO_BLUE_MASK_16" type="char*" value="0x001f"/>
		<constant name="GST_VIDEO_BLUE_MASK_16_INT" type="int" value="31"/>
		<constant name="GST_VIDEO_BYTE1_MASK_24" type="char*" value="0x00FF0000"/>
		<constant name="GST_VIDEO_BYTE1_MASK_24_INT" type="int" value="16711680"/>
		<constant name="GST_VIDEO_BYTE1_MASK_32" type="char*" value="0xFF000000"/>
		<constant name="GST_VIDEO_BYTE1_MASK_32_INT" type="int" value="-16777216"/>
		<constant name="GST_VIDEO_BYTE2_MASK_24" type="char*" value="0x0000FF00"/>
		<constant name="GST_VIDEO_BYTE2_MASK_24_INT" type="int" value="65280"/>
		<constant name="GST_VIDEO_BYTE2_MASK_32" type="char*" value="0x00FF0000"/>
		<constant name="GST_VIDEO_BYTE2_MASK_32_INT" type="int" value="16711680"/>
		<constant name="GST_VIDEO_BYTE3_MASK_24" type="char*" value="0x000000FF"/>
		<constant name="GST_VIDEO_BYTE3_MASK_24_INT" type="int" value="255"/>
		<constant name="GST_VIDEO_BYTE3_MASK_32" type="char*" value="0x0000FF00"/>
		<constant name="GST_VIDEO_BYTE3_MASK_32_INT" type="int" value="65280"/>
		<constant name="GST_VIDEO_BYTE4_MASK_32" type="char*" value="0x000000FF"/>
		<constant name="GST_VIDEO_BYTE4_MASK_32_INT" type="int" value="255"/>
		<constant name="GST_VIDEO_CAPS_RGB_15" type="char*" value="video/x-raw-rgb, bpp = (int) 16, depth = (int) 15, endianness = (int) BYTE_ORDER, red_mask = (int) "/>
		<constant name="GST_VIDEO_CAPS_RGB_16" type="char*" value="video/x-raw-rgb, bpp = (int) 16, depth = (int) 16, endianness = (int) BYTE_ORDER, red_mask = (int) "/>
		<constant name="GST_VIDEO_FPS_RANGE" type="char*" value="(fraction) [ 0, max ]"/>
		<constant name="GST_VIDEO_GREEN_MASK_15" type="char*" value="0x03e0"/>
		<constant name="GST_VIDEO_GREEN_MASK_15_INT" type="int" value="992"/>
		<constant name="GST_VIDEO_GREEN_MASK_16" type="char*" value="0x07e0"/>
		<constant name="GST_VIDEO_GREEN_MASK_16_INT" type="int" value="2016"/>
		<constant name="GST_VIDEO_RED_MASK_15" type="char*" value="0x7c00"/>
		<constant name="GST_VIDEO_RED_MASK_15_INT" type="int" value="31744"/>
		<constant name="GST_VIDEO_RED_MASK_16" type="char*" value="0xf800"/>
		<constant name="GST_VIDEO_RED_MASK_16_INT" type="int" value="63488"/>
		<constant name="GST_VIDEO_SIZE_RANGE" type="char*" value="(int) [ 1, max ]"/>
	</namespace>
</api>
