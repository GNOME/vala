<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="tag_freeform_string_to_utf8" symbol="gst_tag_freeform_string_to_utf8">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="data" type="gchar*"/>
				<parameter name="size" type="gint"/>
				<parameter name="env_vars" type="gchar**"/>
			</parameters>
		</function>
		<function name="tag_from_id3_tag" symbol="gst_tag_from_id3_tag">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="id3_tag" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_from_id3_user_tag" symbol="gst_tag_from_id3_user_tag">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="type" type="gchar*"/>
				<parameter name="id3_user_tag" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_from_vorbis_tag" symbol="gst_tag_from_vorbis_tag">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="vorbis_tag" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_get_language_code_iso_639_1" symbol="gst_tag_get_language_code_iso_639_1">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="lang_code" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_get_language_code_iso_639_2B" symbol="gst_tag_get_language_code_iso_639_2B">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="lang_code" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_get_language_code_iso_639_2T" symbol="gst_tag_get_language_code_iso_639_2T">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="lang_code" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_get_language_codes" symbol="gst_tag_get_language_codes">
			<return-type type="gchar**"/>
		</function>
		<function name="tag_get_language_name" symbol="gst_tag_get_language_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="language_code" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_id3_genre_count" symbol="gst_tag_id3_genre_count">
			<return-type type="guint"/>
		</function>
		<function name="tag_id3_genre_get" symbol="gst_tag_id3_genre_get">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="id" type="guint"/>
			</parameters>
		</function>
		<function name="tag_image_data_to_image_buffer" symbol="gst_tag_image_data_to_image_buffer">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="image_data" type="guint8*"/>
				<parameter name="image_data_len" type="guint"/>
				<parameter name="image_type" type="GstTagImageType"/>
			</parameters>
		</function>
		<function name="tag_list_add_id3_image" symbol="gst_tag_list_add_id3_image">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="tag_list" type="GstTagList*"/>
				<parameter name="image_data" type="guint8*"/>
				<parameter name="image_data_len" type="guint"/>
				<parameter name="id3_picture_type" type="guint"/>
			</parameters>
		</function>
		<function name="tag_list_from_exif_buffer" symbol="gst_tag_list_from_exif_buffer">
			<return-type type="GstTagList*"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="byte_order" type="gint"/>
				<parameter name="base_offset" type="guint32"/>
			</parameters>
		</function>
		<function name="tag_list_from_exif_buffer_with_tiff_header" symbol="gst_tag_list_from_exif_buffer_with_tiff_header">
			<return-type type="GstTagList*"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="tag_list_from_vorbiscomment_buffer" symbol="gst_tag_list_from_vorbiscomment_buffer">
			<return-type type="GstTagList*"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="id_data" type="guint8*"/>
				<parameter name="id_data_length" type="guint"/>
				<parameter name="vendor_string" type="gchar**"/>
			</parameters>
		</function>
		<function name="tag_list_from_xmp_buffer" symbol="gst_tag_list_from_xmp_buffer">
			<return-type type="GstTagList*"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="tag_list_new_from_id3v1" symbol="gst_tag_list_new_from_id3v1">
			<return-type type="GstTagList*"/>
			<parameters>
				<parameter name="data" type="guint8*"/>
			</parameters>
		</function>
		<function name="tag_list_to_exif_buffer" symbol="gst_tag_list_to_exif_buffer">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="taglist" type="GstTagList*"/>
				<parameter name="byte_order" type="gint"/>
				<parameter name="base_offset" type="guint32"/>
			</parameters>
		</function>
		<function name="tag_list_to_exif_buffer_with_tiff_header" symbol="gst_tag_list_to_exif_buffer_with_tiff_header">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="taglist" type="GstTagList*"/>
			</parameters>
		</function>
		<function name="tag_list_to_vorbiscomment_buffer" symbol="gst_tag_list_to_vorbiscomment_buffer">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="list" type="GstTagList*"/>
				<parameter name="id_data" type="guint8*"/>
				<parameter name="id_data_length" type="guint"/>
				<parameter name="vendor_string" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_list_to_xmp_buffer" symbol="gst_tag_list_to_xmp_buffer">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="list" type="GstTagList*"/>
				<parameter name="read_only" type="gboolean"/>
			</parameters>
		</function>
		<function name="tag_list_to_xmp_buffer_full" symbol="gst_tag_list_to_xmp_buffer_full">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="list" type="GstTagList*"/>
				<parameter name="read_only" type="gboolean"/>
				<parameter name="schemas" type="gchar**"/>
			</parameters>
		</function>
		<function name="tag_parse_extended_comment" symbol="gst_tag_parse_extended_comment">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="ext_comment" type="gchar*"/>
				<parameter name="key" type="gchar**"/>
				<parameter name="lang" type="gchar**"/>
				<parameter name="value" type="gchar**"/>
				<parameter name="fail_if_no_key" type="gboolean"/>
			</parameters>
		</function>
		<function name="tag_register_musicbrainz_tags" symbol="gst_tag_register_musicbrainz_tags">
			<return-type type="void"/>
		</function>
		<function name="tag_to_id3_tag" symbol="gst_tag_to_id3_tag">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="gst_tag" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_to_vorbis_comments" symbol="gst_tag_to_vorbis_comments">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="list" type="GstTagList*"/>
				<parameter name="tag" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_to_vorbis_tag" symbol="gst_tag_to_vorbis_tag">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="gst_tag" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_xmp_list_schemas" symbol="gst_tag_xmp_list_schemas">
			<return-type type="gchar**"/>
		</function>
		<function name="vorbis_tag_add" symbol="gst_vorbis_tag_add">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GstTagList*"/>
				<parameter name="tag" type="gchar*"/>
				<parameter name="value" type="gchar*"/>
			</parameters>
		</function>
		<enum name="GstTagDemuxResult" type-name="GstTagDemuxResult" get-type="gst_tag_demux_result_get_type">
			<member name="GST_TAG_DEMUX_RESULT_BROKEN_TAG" value="0"/>
			<member name="GST_TAG_DEMUX_RESULT_AGAIN" value="1"/>
			<member name="GST_TAG_DEMUX_RESULT_OK" value="2"/>
		</enum>
		<enum name="GstTagImageType" type-name="GstTagImageType" get-type="gst_tag_image_type_get_type">
			<member name="GST_TAG_IMAGE_TYPE_NONE" value="-1"/>
			<member name="GST_TAG_IMAGE_TYPE_UNDEFINED" value="0"/>
			<member name="GST_TAG_IMAGE_TYPE_FRONT_COVER" value="1"/>
			<member name="GST_TAG_IMAGE_TYPE_BACK_COVER" value="2"/>
			<member name="GST_TAG_IMAGE_TYPE_LEAFLET_PAGE" value="3"/>
			<member name="GST_TAG_IMAGE_TYPE_MEDIUM" value="4"/>
			<member name="GST_TAG_IMAGE_TYPE_LEAD_ARTIST" value="5"/>
			<member name="GST_TAG_IMAGE_TYPE_ARTIST" value="6"/>
			<member name="GST_TAG_IMAGE_TYPE_CONDUCTOR" value="7"/>
			<member name="GST_TAG_IMAGE_TYPE_BAND_ORCHESTRA" value="8"/>
			<member name="GST_TAG_IMAGE_TYPE_COMPOSER" value="9"/>
			<member name="GST_TAG_IMAGE_TYPE_LYRICIST" value="10"/>
			<member name="GST_TAG_IMAGE_TYPE_RECORDING_LOCATION" value="11"/>
			<member name="GST_TAG_IMAGE_TYPE_DURING_RECORDING" value="12"/>
			<member name="GST_TAG_IMAGE_TYPE_DURING_PERFORMANCE" value="13"/>
			<member name="GST_TAG_IMAGE_TYPE_VIDEO_CAPTURE" value="14"/>
			<member name="GST_TAG_IMAGE_TYPE_FISH" value="15"/>
			<member name="GST_TAG_IMAGE_TYPE_ILLUSTRATION" value="16"/>
			<member name="GST_TAG_IMAGE_TYPE_BAND_ARTIST_LOGO" value="17"/>
			<member name="GST_TAG_IMAGE_TYPE_PUBLISHER_STUDIO_LOGO" value="18"/>
		</enum>
		<object name="GstTagDemux" parent="GstElement" type-name="GstTagDemux" get-type="gst_tag_demux_get_type">
			<vfunc name="identify_tag">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="demux" type="GstTagDemux*"/>
					<parameter name="buffer" type="GstBuffer*"/>
					<parameter name="start_tag" type="gboolean"/>
					<parameter name="tag_size" type="guint*"/>
				</parameters>
			</vfunc>
			<vfunc name="merge_tags">
				<return-type type="GstTagList*"/>
				<parameters>
					<parameter name="demux" type="GstTagDemux*"/>
					<parameter name="start_tags" type="GstTagList*"/>
					<parameter name="end_tags" type="GstTagList*"/>
				</parameters>
			</vfunc>
			<vfunc name="parse_tag">
				<return-type type="GstTagDemuxResult"/>
				<parameters>
					<parameter name="demux" type="GstTagDemux*"/>
					<parameter name="buffer" type="GstBuffer*"/>
					<parameter name="start_tag" type="gboolean"/>
					<parameter name="tag_size" type="guint*"/>
					<parameter name="tags" type="GstTagList**"/>
				</parameters>
			</vfunc>
			<field name="reserved" type="gpointer[]"/>
		</object>
		<interface name="GstTagXmpWriter" type-name="GstTagXmpWriter" get-type="gst_tag_xmp_writer_get_type">
			<requires>
				<interface name="GstElement"/>
			</requires>
			<method name="add_all_schemas" symbol="gst_tag_xmp_writer_add_all_schemas">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="GstTagXmpWriter*"/>
				</parameters>
			</method>
			<method name="add_schema" symbol="gst_tag_xmp_writer_add_schema">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="GstTagXmpWriter*"/>
					<parameter name="schema" type="gchar*"/>
				</parameters>
			</method>
			<method name="has_schema" symbol="gst_tag_xmp_writer_has_schema">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="GstTagXmpWriter*"/>
					<parameter name="schema" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove_all_schemas" symbol="gst_tag_xmp_writer_remove_all_schemas">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="GstTagXmpWriter*"/>
				</parameters>
			</method>
			<method name="remove_schema" symbol="gst_tag_xmp_writer_remove_schema">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="GstTagXmpWriter*"/>
					<parameter name="schema" type="gchar*"/>
				</parameters>
			</method>
			<method name="tag_list_to_xmp_buffer" symbol="gst_tag_xmp_writer_tag_list_to_xmp_buffer">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="config" type="GstTagXmpWriter*"/>
					<parameter name="taglist" type="GstTagList*"/>
					<parameter name="read_only" type="gboolean"/>
				</parameters>
			</method>
		</interface>
		<constant name="GST_TAG_CAPTURING_CONTRAST" type="char*" value="capturing-contrast"/>
		<constant name="GST_TAG_CAPTURING_DIGITAL_ZOOM_RATIO" type="char*" value="capturing-digital-zoom-ratio"/>
		<constant name="GST_TAG_CAPTURING_EXPOSURE_COMPENSATION" type="char*" value="capturing-exposure-compensation"/>
		<constant name="GST_TAG_CAPTURING_EXPOSURE_MODE" type="char*" value="capturing-exposure-mode"/>
		<constant name="GST_TAG_CAPTURING_EXPOSURE_PROGRAM" type="char*" value="capturing-exposure-program"/>
		<constant name="GST_TAG_CAPTURING_FLASH_FIRED" type="char*" value="capturing-flash-fired"/>
		<constant name="GST_TAG_CAPTURING_FLASH_MODE" type="char*" value="capturing-flash-mode"/>
		<constant name="GST_TAG_CAPTURING_FOCAL_LENGTH" type="char*" value="capturing-focal-length"/>
		<constant name="GST_TAG_CAPTURING_FOCAL_RATIO" type="char*" value="capturing-focal-ratio"/>
		<constant name="GST_TAG_CAPTURING_GAIN_ADJUSTMENT" type="char*" value="capturing-gain-adjustment"/>
		<constant name="GST_TAG_CAPTURING_ISO_SPEED" type="char*" value="capturing-iso-speed"/>
		<constant name="GST_TAG_CAPTURING_METERING_MODE" type="char*" value="capturing-metering-mode"/>
		<constant name="GST_TAG_CAPTURING_SATURATION" type="char*" value="capturing-saturation"/>
		<constant name="GST_TAG_CAPTURING_SCENE_CAPTURE_TYPE" type="char*" value="capturing-scene-capture-type"/>
		<constant name="GST_TAG_CAPTURING_SHARPNESS" type="char*" value="capturing-sharpness"/>
		<constant name="GST_TAG_CAPTURING_SHUTTER_SPEED" type="char*" value="capturing-shutter-speed"/>
		<constant name="GST_TAG_CAPTURING_SOURCE" type="char*" value="capturing-source"/>
		<constant name="GST_TAG_CAPTURING_WHITE_BALANCE" type="char*" value="capturing-white-balance"/>
		<constant name="GST_TAG_CDDA_CDDB_DISCID" type="char*" value="discid"/>
		<constant name="GST_TAG_CDDA_CDDB_DISCID_FULL" type="char*" value="discid-full"/>
		<constant name="GST_TAG_CDDA_MUSICBRAINZ_DISCID" type="char*" value="musicbrainz-discid"/>
		<constant name="GST_TAG_CDDA_MUSICBRAINZ_DISCID_FULL" type="char*" value="musicbrainz-discid-full"/>
		<constant name="GST_TAG_CMML_CLIP" type="char*" value="cmml-clip"/>
		<constant name="GST_TAG_CMML_HEAD" type="char*" value="cmml-head"/>
		<constant name="GST_TAG_CMML_STREAM" type="char*" value="cmml-stream"/>
		<constant name="GST_TAG_IMAGE_HORIZONTAL_PPI" type="char*" value="image-horizontal-ppi"/>
		<constant name="GST_TAG_IMAGE_VERTICAL_PPI" type="char*" value="image-vertical-ppi"/>
		<constant name="GST_TAG_MUSICBRAINZ_ALBUMARTISTID" type="char*" value="musicbrainz-albumartistid"/>
		<constant name="GST_TAG_MUSICBRAINZ_ALBUMID" type="char*" value="musicbrainz-albumid"/>
		<constant name="GST_TAG_MUSICBRAINZ_ARTISTID" type="char*" value="musicbrainz-artistid"/>
		<constant name="GST_TAG_MUSICBRAINZ_TRACKID" type="char*" value="musicbrainz-trackid"/>
		<constant name="GST_TAG_MUSICBRAINZ_TRMID" type="char*" value="musicbrainz-trmid"/>
	</namespace>
</api>
