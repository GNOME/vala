<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="sdp_address_is_multicast" symbol="gst_sdp_address_is_multicast">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="nettype" type="gchar*"/>
				<parameter name="addrtype" type="gchar*"/>
				<parameter name="addr" type="gchar*"/>
			</parameters>
		</function>
		<struct name="GstSDPAttribute">
			<field name="key" type="gchar*"/>
			<field name="value" type="gchar*"/>
		</struct>
		<struct name="GstSDPBandwidth">
			<field name="bwtype" type="gchar*"/>
			<field name="bandwidth" type="guint"/>
		</struct>
		<struct name="GstSDPConnection">
			<field name="nettype" type="gchar*"/>
			<field name="addrtype" type="gchar*"/>
			<field name="address" type="gchar*"/>
			<field name="ttl" type="guint"/>
			<field name="addr_number" type="guint"/>
		</struct>
		<struct name="GstSDPKey">
			<field name="type" type="gchar*"/>
			<field name="data" type="gchar*"/>
		</struct>
		<struct name="GstSDPMedia">
			<method name="add_attribute" symbol="gst_sdp_media_add_attribute">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_bandwidth" symbol="gst_sdp_media_add_bandwidth">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="bwtype" type="gchar*"/>
					<parameter name="bandwidth" type="guint"/>
				</parameters>
			</method>
			<method name="add_connection" symbol="gst_sdp_media_add_connection">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="nettype" type="gchar*"/>
					<parameter name="addrtype" type="gchar*"/>
					<parameter name="address" type="gchar*"/>
					<parameter name="ttl" type="guint"/>
					<parameter name="addr_number" type="guint"/>
				</parameters>
			</method>
			<method name="add_format" symbol="gst_sdp_media_add_format">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="format" type="gchar*"/>
				</parameters>
			</method>
			<method name="as_text" symbol="gst_sdp_media_as_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="attributes_len" symbol="gst_sdp_media_attributes_len">
				<return-type type="guint"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="bandwidths_len" symbol="gst_sdp_media_bandwidths_len">
				<return-type type="guint"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="connections_len" symbol="gst_sdp_media_connections_len">
				<return-type type="guint"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="formats_len" symbol="gst_sdp_media_formats_len">
				<return-type type="guint"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_sdp_media_free">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="get_attribute" symbol="gst_sdp_media_get_attribute">
				<return-type type="GstSDPAttribute*"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="idx" type="guint"/>
				</parameters>
			</method>
			<method name="get_attribute_val" symbol="gst_sdp_media_get_attribute_val">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_attribute_val_n" symbol="gst_sdp_media_get_attribute_val_n">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="nth" type="guint"/>
				</parameters>
			</method>
			<method name="get_bandwidth" symbol="gst_sdp_media_get_bandwidth">
				<return-type type="GstSDPBandwidth*"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="idx" type="guint"/>
				</parameters>
			</method>
			<method name="get_connection" symbol="gst_sdp_media_get_connection">
				<return-type type="GstSDPConnection*"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="idx" type="guint"/>
				</parameters>
			</method>
			<method name="get_format" symbol="gst_sdp_media_get_format">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="idx" type="guint"/>
				</parameters>
			</method>
			<method name="get_information" symbol="gst_sdp_media_get_information">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="get_key" symbol="gst_sdp_media_get_key">
				<return-type type="GstSDPKey*"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="get_media" symbol="gst_sdp_media_get_media">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="get_num_ports" symbol="gst_sdp_media_get_num_ports">
				<return-type type="guint"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="gst_sdp_media_get_port">
				<return-type type="guint"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="get_proto" symbol="gst_sdp_media_get_proto">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="init" symbol="gst_sdp_media_init">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_sdp_media_new">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia**"/>
				</parameters>
			</method>
			<method name="set_information" symbol="gst_sdp_media_set_information">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="information" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_key" symbol="gst_sdp_media_set_key">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="type" type="gchar*"/>
					<parameter name="data" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_media" symbol="gst_sdp_media_set_media">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="med" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_port_info" symbol="gst_sdp_media_set_port_info">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="port" type="guint"/>
					<parameter name="num_ports" type="guint"/>
				</parameters>
			</method>
			<method name="set_proto" symbol="gst_sdp_media_set_proto">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
					<parameter name="proto" type="gchar*"/>
				</parameters>
			</method>
			<method name="uninit" symbol="gst_sdp_media_uninit">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<field name="media" type="gchar*"/>
			<field name="port" type="guint"/>
			<field name="num_ports" type="guint"/>
			<field name="proto" type="gchar*"/>
			<field name="fmts" type="GArray*"/>
			<field name="information" type="gchar*"/>
			<field name="connections" type="GArray*"/>
			<field name="bandwidths" type="GArray*"/>
			<field name="key" type="GstSDPKey"/>
			<field name="attributes" type="GArray*"/>
		</struct>
		<struct name="GstSDPMessage">
			<method name="add_attribute" symbol="gst_sdp_message_add_attribute">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_bandwidth" symbol="gst_sdp_message_add_bandwidth">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="bwtype" type="gchar*"/>
					<parameter name="bandwidth" type="guint"/>
				</parameters>
			</method>
			<method name="add_email" symbol="gst_sdp_message_add_email">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="email" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_media" symbol="gst_sdp_message_add_media">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="add_phone" symbol="gst_sdp_message_add_phone">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="phone" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_time" symbol="gst_sdp_message_add_time">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="start" type="gchar*"/>
					<parameter name="stop" type="gchar*"/>
					<parameter name="repeat" type="gchar**"/>
				</parameters>
			</method>
			<method name="add_zone" symbol="gst_sdp_message_add_zone">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="adj_time" type="gchar*"/>
					<parameter name="typed_time" type="gchar*"/>
				</parameters>
			</method>
			<method name="as_text" symbol="gst_sdp_message_as_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="as_uri" symbol="gst_sdp_message_as_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="scheme" type="gchar*"/>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="attributes_len" symbol="gst_sdp_message_attributes_len">
				<return-type type="guint"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="bandwidths_len" symbol="gst_sdp_message_bandwidths_len">
				<return-type type="guint"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="dump" symbol="gst_sdp_message_dump">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="emails_len" symbol="gst_sdp_message_emails_len">
				<return-type type="guint"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_sdp_message_free">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="get_attribute" symbol="gst_sdp_message_get_attribute">
				<return-type type="GstSDPAttribute*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="idx" type="guint"/>
				</parameters>
			</method>
			<method name="get_attribute_val" symbol="gst_sdp_message_get_attribute_val">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_attribute_val_n" symbol="gst_sdp_message_get_attribute_val_n">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="nth" type="guint"/>
				</parameters>
			</method>
			<method name="get_bandwidth" symbol="gst_sdp_message_get_bandwidth">
				<return-type type="GstSDPBandwidth*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="idx" type="guint"/>
				</parameters>
			</method>
			<method name="get_connection" symbol="gst_sdp_message_get_connection">
				<return-type type="GstSDPConnection*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="get_email" symbol="gst_sdp_message_get_email">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="idx" type="guint"/>
				</parameters>
			</method>
			<method name="get_information" symbol="gst_sdp_message_get_information">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="get_key" symbol="gst_sdp_message_get_key">
				<return-type type="GstSDPKey*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="get_media" symbol="gst_sdp_message_get_media">
				<return-type type="GstSDPMedia*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="idx" type="guint"/>
				</parameters>
			</method>
			<method name="get_origin" symbol="gst_sdp_message_get_origin">
				<return-type type="GstSDPOrigin*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="get_phone" symbol="gst_sdp_message_get_phone">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="idx" type="guint"/>
				</parameters>
			</method>
			<method name="get_session_name" symbol="gst_sdp_message_get_session_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="get_time" symbol="gst_sdp_message_get_time">
				<return-type type="GstSDPTime*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="idx" type="guint"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="gst_sdp_message_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="get_version" symbol="gst_sdp_message_get_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="get_zone" symbol="gst_sdp_message_get_zone">
				<return-type type="GstSDPZone*"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="idx" type="guint"/>
				</parameters>
			</method>
			<method name="init" symbol="gst_sdp_message_init">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="medias_len" symbol="gst_sdp_message_medias_len">
				<return-type type="guint"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_sdp_message_new">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage**"/>
				</parameters>
			</method>
			<method name="parse_buffer" symbol="gst_sdp_message_parse_buffer">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="parse_uri" symbol="gst_sdp_message_parse_uri">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="phones_len" symbol="gst_sdp_message_phones_len">
				<return-type type="guint"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="set_connection" symbol="gst_sdp_message_set_connection">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="nettype" type="gchar*"/>
					<parameter name="addrtype" type="gchar*"/>
					<parameter name="address" type="gchar*"/>
					<parameter name="ttl" type="guint"/>
					<parameter name="addr_number" type="guint"/>
				</parameters>
			</method>
			<method name="set_information" symbol="gst_sdp_message_set_information">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="information" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_key" symbol="gst_sdp_message_set_key">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="type" type="gchar*"/>
					<parameter name="data" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_origin" symbol="gst_sdp_message_set_origin">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="username" type="gchar*"/>
					<parameter name="sess_id" type="gchar*"/>
					<parameter name="sess_version" type="gchar*"/>
					<parameter name="nettype" type="gchar*"/>
					<parameter name="addrtype" type="gchar*"/>
					<parameter name="addr" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_session_name" symbol="gst_sdp_message_set_session_name">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="session_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_uri" symbol="gst_sdp_message_set_uri">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_version" symbol="gst_sdp_message_set_version">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
					<parameter name="version" type="gchar*"/>
				</parameters>
			</method>
			<method name="times_len" symbol="gst_sdp_message_times_len">
				<return-type type="guint"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="uninit" symbol="gst_sdp_message_uninit">
				<return-type type="GstSDPResult"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<method name="zones_len" symbol="gst_sdp_message_zones_len">
				<return-type type="guint"/>
				<parameters>
					<parameter name="msg" type="GstSDPMessage*"/>
				</parameters>
			</method>
			<field name="version" type="gchar*"/>
			<field name="origin" type="GstSDPOrigin"/>
			<field name="session_name" type="gchar*"/>
			<field name="information" type="gchar*"/>
			<field name="uri" type="gchar*"/>
			<field name="emails" type="GArray*"/>
			<field name="phones" type="GArray*"/>
			<field name="connection" type="GstSDPConnection"/>
			<field name="bandwidths" type="GArray*"/>
			<field name="times" type="GArray*"/>
			<field name="zones" type="GArray*"/>
			<field name="key" type="GstSDPKey"/>
			<field name="attributes" type="GArray*"/>
			<field name="medias" type="GArray*"/>
		</struct>
		<struct name="GstSDPOrigin">
			<field name="username" type="gchar*"/>
			<field name="sess_id" type="gchar*"/>
			<field name="sess_version" type="gchar*"/>
			<field name="nettype" type="gchar*"/>
			<field name="addrtype" type="gchar*"/>
			<field name="addr" type="gchar*"/>
		</struct>
		<struct name="GstSDPTime">
			<field name="start" type="gchar*"/>
			<field name="stop" type="gchar*"/>
			<field name="repeat" type="GArray*"/>
		</struct>
		<struct name="GstSDPZone">
			<field name="time" type="gchar*"/>
			<field name="typed_time" type="gchar*"/>
		</struct>
		<enum name="GstSDPResult">
			<member name="GST_SDP_OK" value="0"/>
			<member name="GST_SDP_EINVAL" value="-1"/>
		</enum>
		<constant name="GST_SDP_BWTYPE_AS" type="char*" value="AS"/>
		<constant name="GST_SDP_BWTYPE_CT" type="char*" value="CT"/>
		<constant name="GST_SDP_BWTYPE_EXT_PREFIX" type="char*" value="X-"/>
		<constant name="GST_SDP_BWTYPE_RR" type="char*" value="RR"/>
		<constant name="GST_SDP_BWTYPE_RS" type="char*" value="RS"/>
		<constant name="GST_SDP_BWTYPE_TIAS" type="char*" value="TIAS"/>
	</namespace>
</api>
