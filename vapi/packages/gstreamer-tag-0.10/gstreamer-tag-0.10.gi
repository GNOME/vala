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
		<function name="tag_id3_genre_count" symbol="gst_tag_id3_genre_count">
			<return-type type="guint"/>
		</function>
		<function name="tag_id3_genre_get" symbol="gst_tag_id3_genre_get">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="id" type="guint"/>
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
		<function name="tag_list_new_from_id3v1" symbol="gst_tag_list_new_from_id3v1">
			<return-type type="GstTagList*"/>
			<parameters>
				<parameter name="data" type="guint8*"/>
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
		<function name="vorbis_tag_add" symbol="gst_vorbis_tag_add">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GstTagList*"/>
				<parameter name="tag" type="gchar*"/>
				<parameter name="value" type="gchar*"/>
			</parameters>
		</function>
		<enum name="GstTagDemuxResult">
			<member name="GST_TAG_DEMUX_RESULT_BROKEN_TAG" value="0"/>
			<member name="GST_TAG_DEMUX_RESULT_AGAIN" value="1"/>
			<member name="GST_TAG_DEMUX_RESULT_OK" value="2"/>
		</enum>
		<enum name="GstTagImageType">
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
		<constant name="GST_TAG_CDDA_CDDB_DISCID" type="char*" value="discid"/>
		<constant name="GST_TAG_CDDA_CDDB_DISCID_FULL" type="char*" value="discid-full"/>
		<constant name="GST_TAG_CDDA_MUSICBRAINZ_DISCID" type="char*" value="musicbrainz-discid"/>
		<constant name="GST_TAG_CDDA_MUSICBRAINZ_DISCID_FULL" type="char*" value="musicbrainz-discid-full"/>
		<constant name="GST_TAG_CMML_CLIP" type="char*" value="cmml-clip"/>
		<constant name="GST_TAG_CMML_HEAD" type="char*" value="cmml-head"/>
		<constant name="GST_TAG_CMML_STREAM" type="char*" value="cmml-stream"/>
		<constant name="GST_TAG_MUSICBRAINZ_ALBUMARTISTID" type="char*" value="musicbrainz-albumartistid"/>
		<constant name="GST_TAG_MUSICBRAINZ_ALBUMID" type="char*" value="musicbrainz-albumid"/>
		<constant name="GST_TAG_MUSICBRAINZ_ARTISTID" type="char*" value="musicbrainz-artistid"/>
		<constant name="GST_TAG_MUSICBRAINZ_TRACKID" type="char*" value="musicbrainz-trackid"/>
		<constant name="GST_TAG_MUSICBRAINZ_TRMID" type="char*" value="musicbrainz-trmid"/>
	</namespace>
</api>
