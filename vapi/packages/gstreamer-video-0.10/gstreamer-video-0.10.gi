<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
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
		<function name="video_convert_frame" symbol="gst_video_convert_frame">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="buf" type="GstBuffer*"/>
				<parameter name="to_caps" type="GstCaps*"/>
				<parameter name="timeout" type="GstClockTime"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="video_convert_frame_async" symbol="gst_video_convert_frame_async">
			<return-type type="void"/>
			<parameters>
				<parameter name="buf" type="GstBuffer*"/>
				<parameter name="to_caps" type="GstCaps*"/>
				<parameter name="timeout" type="GstClockTime"/>
				<parameter name="callback" type="GstVideoConvertFrameCallback"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="destroy_notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="video_event_new_still_frame" symbol="gst_video_event_new_still_frame">
			<return-type type="GstEvent*"/>
			<parameters>
				<parameter name="in_still" type="gboolean"/>
			</parameters>
		</function>
		<function name="video_event_parse_still_frame" symbol="gst_video_event_parse_still_frame">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="event" type="GstEvent*"/>
				<parameter name="in_still" type="gboolean*"/>
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
		<function name="video_format_get_component_depth" symbol="gst_video_format_get_component_depth">
			<return-type type="int"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
				<parameter name="component" type="int"/>
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
		<function name="video_format_is_gray" symbol="gst_video_format_is_gray">
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
		<function name="video_format_new_template_caps" symbol="gst_video_format_new_template_caps">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="format" type="GstVideoFormat"/>
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
		<function name="video_frame_rate" symbol="gst_video_frame_rate">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
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
		<function name="video_get_size_from_caps" symbol="gst_video_get_size_from_caps">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
				<parameter name="size" type="gint*"/>
			</parameters>
		</function>
		<function name="video_parse_caps_chroma_site" symbol="gst_video_parse_caps_chroma_site">
			<return-type type="char*"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="video_parse_caps_color_matrix" symbol="gst_video_parse_caps_color_matrix">
			<return-type type="char*"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
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
		<function name="video_parse_caps_palette" symbol="gst_video_parse_caps_palette">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
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
		<callback name="GstVideoConvertFrameCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="buf" type="GstBuffer*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GstVideoRectangle">
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
			<field name="w" type="gint"/>
			<field name="h" type="gint"/>
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
			<member name="GST_VIDEO_FORMAT_NV12" value="22"/>
			<member name="GST_VIDEO_FORMAT_NV21" value="23"/>
			<member name="GST_VIDEO_FORMAT_GRAY8" value="24"/>
			<member name="GST_VIDEO_FORMAT_GRAY16_BE" value="25"/>
			<member name="GST_VIDEO_FORMAT_GRAY16_LE" value="26"/>
			<member name="GST_VIDEO_FORMAT_v308" value="27"/>
			<member name="GST_VIDEO_FORMAT_Y800" value="28"/>
			<member name="GST_VIDEO_FORMAT_Y16" value="29"/>
			<member name="GST_VIDEO_FORMAT_RGB16" value="30"/>
			<member name="GST_VIDEO_FORMAT_BGR16" value="31"/>
			<member name="GST_VIDEO_FORMAT_RGB15" value="32"/>
			<member name="GST_VIDEO_FORMAT_BGR15" value="33"/>
			<member name="GST_VIDEO_FORMAT_UYVP" value="34"/>
			<member name="GST_VIDEO_FORMAT_A420" value="35"/>
			<member name="GST_VIDEO_FORMAT_RGB8_PALETTED" value="36"/>
			<member name="GST_VIDEO_FORMAT_YUV9" value="37"/>
			<member name="GST_VIDEO_FORMAT_YVU9" value="38"/>
			<member name="GST_VIDEO_FORMAT_IYU1" value="39"/>
			<member name="GST_VIDEO_FORMAT_ARGB64" value="40"/>
			<member name="GST_VIDEO_FORMAT_AYUV64" value="41"/>
			<member name="GST_VIDEO_FORMAT_r210" value="42"/>
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
			<property name="show-preroll-frame" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<vfunc name="show_frame">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="video_sink" type="GstVideoSink*"/>
					<parameter name="buf" type="GstBuffer*"/>
				</parameters>
			</vfunc>
			<field name="width" type="gint"/>
			<field name="height" type="gint"/>
		</object>
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
		<constant name="GST_VIDEO_CAPS_GRAY8" type="char*" value="video/x-raw-gray, bpp = (int) 8, depth = (int) 8, width = "/>
		<constant name="GST_VIDEO_CAPS_RGB8_PALETTED" type="char*" value="video/x-raw-rgb, bpp = (int)8, depth = (int)8, width = "/>
		<constant name="GST_VIDEO_CAPS_r210" type="char*" value="video/x-raw-rgb, bpp = (int) 32, depth = (int) 30, endianness = (int) BIG_ENDIAN, red_mask = (int) 0x3ff00000, green_mask = (int) 0x000ffc00, blue_mask = (int) 0x000003ff, width = "/>
		<constant name="GST_VIDEO_COMP1_MASK_15" type="char*" value="0x7c00"/>
		<constant name="GST_VIDEO_COMP1_MASK_15_INT" type="int" value="31744"/>
		<constant name="GST_VIDEO_COMP1_MASK_16" type="char*" value="0xf800"/>
		<constant name="GST_VIDEO_COMP1_MASK_16_INT" type="int" value="63488"/>
		<constant name="GST_VIDEO_COMP2_MASK_15" type="char*" value="0x03e0"/>
		<constant name="GST_VIDEO_COMP2_MASK_15_INT" type="int" value="992"/>
		<constant name="GST_VIDEO_COMP2_MASK_16" type="char*" value="0x07e0"/>
		<constant name="GST_VIDEO_COMP2_MASK_16_INT" type="int" value="2016"/>
		<constant name="GST_VIDEO_COMP3_MASK_15" type="char*" value="0x001f"/>
		<constant name="GST_VIDEO_COMP3_MASK_15_INT" type="int" value="31"/>
		<constant name="GST_VIDEO_COMP3_MASK_16" type="char*" value="0x001f"/>
		<constant name="GST_VIDEO_COMP3_MASK_16_INT" type="int" value="31"/>
		<constant name="GST_VIDEO_FPS_RANGE" type="char*" value="(fraction) [ 0, max ]"/>
		<constant name="GST_VIDEO_SIZE_RANGE" type="char*" value="(int) [ 1, max ]"/>
	</namespace>
</api>
