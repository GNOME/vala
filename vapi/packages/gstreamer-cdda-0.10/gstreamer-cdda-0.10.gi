<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<struct name="GstCddaBaseSrcTrack">
			<field name="is_audio" type="gboolean"/>
			<field name="num" type="guint"/>
			<field name="start" type="guint"/>
			<field name="end" type="guint"/>
			<field name="tags" type="GstTagList*"/>
			<field name="_gst_reserved1" type="guint[]"/>
			<field name="_gst_reserved2" type="gpointer[]"/>
		</struct>
		<enum name="GstCddaBaseSrcMode" type-name="GstCddaBaseSrcMode" get-type="gst_cdda_base_src_mode_get_type">
			<member name="Stream consists of a single track" value="0"/>
			<member name="Stream consists of the whole disc" value="1"/>
		</enum>
		<object name="GstCddaBaseSrc" parent="GstPushSrc" type-name="GstCddaBaseSrc" get-type="gst_cdda_base_src_get_type">
			<implements>
				<interface name="GstURIHandler"/>
			</implements>
			<method name="add_track" symbol="gst_cdda_base_src_add_track">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstCddaBaseSrc*"/>
					<parameter name="track" type="GstCddaBaseSrcTrack*"/>
				</parameters>
			</method>
			<property name="device" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="mode" type="GstCddaBaseSrcMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="track" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="close">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstCddaBaseSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_default_device">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="src" type="GstCddaBaseSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="open">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstCddaBaseSrc*"/>
					<parameter name="device" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="probe_devices">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="src" type="GstCddaBaseSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="read_sector">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="src" type="GstCddaBaseSrc*"/>
					<parameter name="sector" type="gint"/>
				</parameters>
			</vfunc>
			<field name="tags" type="GstTagList*"/>
			<field name="mode" type="GstCddaBaseSrcMode"/>
			<field name="device" type="gchar*"/>
			<field name="num_tracks" type="guint"/>
			<field name="num_all_tracks" type="guint"/>
			<field name="tracks" type="GstCddaBaseSrcTrack*"/>
			<field name="cur_track" type="gint"/>
			<field name="prev_track" type="gint"/>
			<field name="cur_sector" type="gint"/>
			<field name="seek_sector" type="gint"/>
			<field name="uri_track" type="gint"/>
			<field name="uri" type="gchar*"/>
			<field name="discid" type="guint32"/>
			<field name="mb_discid" type="gchar[]"/>
			<field name="index" type="GstIndex*"/>
			<field name="index_id" type="gint"/>
			<field name="toc_offset" type="gint"/>
			<field name="toc_bias" type="gboolean"/>
		</object>
		<constant name="GST_TAG_CDDA_TRACK_TAGS" type="char*" value="track-tags"/>
	</namespace>
</api>

