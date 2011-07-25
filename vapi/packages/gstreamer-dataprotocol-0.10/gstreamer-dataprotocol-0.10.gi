<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="dp_buffer_from_header" symbol="gst_dp_buffer_from_header">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="header_length" type="guint"/>
				<parameter name="header" type="guint8*"/>
			</parameters>
		</function>
		<function name="dp_caps_from_packet" symbol="gst_dp_caps_from_packet">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="header_length" type="guint"/>
				<parameter name="header" type="guint8*"/>
				<parameter name="payload" type="guint8*"/>
			</parameters>
		</function>
		<function name="dp_crc" symbol="gst_dp_crc">
			<return-type type="guint16"/>
			<parameters>
				<parameter name="buffer" type="guint8*"/>
				<parameter name="length" type="guint"/>
			</parameters>
		</function>
		<function name="dp_event_from_packet" symbol="gst_dp_event_from_packet">
			<return-type type="GstEvent*"/>
			<parameters>
				<parameter name="header_length" type="guint"/>
				<parameter name="header" type="guint8*"/>
				<parameter name="payload" type="guint8*"/>
			</parameters>
		</function>
		<function name="dp_header_from_buffer" symbol="gst_dp_header_from_buffer">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="flags" type="GstDPHeaderFlag"/>
				<parameter name="length" type="guint*"/>
				<parameter name="header" type="guint8**"/>
			</parameters>
		</function>
		<function name="dp_header_payload_length" symbol="gst_dp_header_payload_length">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="header" type="guint8*"/>
			</parameters>
		</function>
		<function name="dp_header_payload_type" symbol="gst_dp_header_payload_type">
			<return-type type="GstDPPayloadType"/>
			<parameters>
				<parameter name="header" type="guint8*"/>
			</parameters>
		</function>
		<function name="dp_init" symbol="gst_dp_init">
			<return-type type="void"/>
		</function>
		<function name="dp_packet_from_caps" symbol="gst_dp_packet_from_caps">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
				<parameter name="flags" type="GstDPHeaderFlag"/>
				<parameter name="length" type="guint*"/>
				<parameter name="header" type="guint8**"/>
				<parameter name="payload" type="guint8**"/>
			</parameters>
		</function>
		<function name="dp_packet_from_event" symbol="gst_dp_packet_from_event">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="event" type="GstEvent*"/>
				<parameter name="flags" type="GstDPHeaderFlag"/>
				<parameter name="length" type="guint*"/>
				<parameter name="header" type="guint8**"/>
				<parameter name="payload" type="guint8**"/>
			</parameters>
		</function>
		<function name="dp_validate_header" symbol="gst_dp_validate_header">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="header_length" type="guint"/>
				<parameter name="header" type="guint8*"/>
			</parameters>
		</function>
		<function name="dp_validate_packet" symbol="gst_dp_validate_packet">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="header_length" type="guint"/>
				<parameter name="header" type="guint8*"/>
				<parameter name="payload" type="guint8*"/>
			</parameters>
		</function>
		<function name="dp_validate_payload" symbol="gst_dp_validate_payload">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="header_length" type="guint"/>
				<parameter name="header" type="guint8*"/>
				<parameter name="payload" type="guint8*"/>
			</parameters>
		</function>
		<callback name="GstDPHeaderFromBufferFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="flags" type="GstDPHeaderFlag"/>
				<parameter name="length" type="guint*"/>
				<parameter name="header" type="guint8**"/>
			</parameters>
		</callback>
		<callback name="GstDPPacketFromCapsFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
				<parameter name="flags" type="GstDPHeaderFlag"/>
				<parameter name="length" type="guint*"/>
				<parameter name="header" type="guint8**"/>
				<parameter name="payload" type="guint8**"/>
			</parameters>
		</callback>
		<callback name="GstDPPacketFromEventFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="event" type="GstEvent*"/>
				<parameter name="flags" type="GstDPHeaderFlag"/>
				<parameter name="length" type="guint*"/>
				<parameter name="header" type="guint8**"/>
				<parameter name="payload" type="guint8**"/>
			</parameters>
		</callback>
		<struct name="GstDPPacketizer">
			<method name="free" symbol="gst_dp_packetizer_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="packetizer" type="GstDPPacketizer*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_dp_packetizer_new">
				<return-type type="GstDPPacketizer*"/>
				<parameters>
					<parameter name="version" type="GstDPVersion"/>
				</parameters>
			</method>
			<field name="version" type="GstDPVersion"/>
			<field name="header_from_buffer" type="GstDPHeaderFromBufferFunction"/>
			<field name="packet_from_caps" type="GstDPPacketFromCapsFunction"/>
			<field name="packet_from_event" type="GstDPPacketFromEventFunction"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<enum name="GstDPHeaderFlag">
			<member name="GST_DP_HEADER_FLAG_NONE" value="0"/>
			<member name="GST_DP_HEADER_FLAG_CRC_HEADER" value="1"/>
			<member name="GST_DP_HEADER_FLAG_CRC_PAYLOAD" value="2"/>
			<member name="GST_DP_HEADER_FLAG_CRC" value="3"/>
		</enum>
		<enum name="GstDPPayloadType">
			<member name="GST_DP_PAYLOAD_NONE" value="0"/>
			<member name="GST_DP_PAYLOAD_BUFFER" value="1"/>
			<member name="GST_DP_PAYLOAD_CAPS" value="2"/>
			<member name="GST_DP_PAYLOAD_EVENT_NONE" value="64"/>
		</enum>
		<enum name="GstDPVersion" type-name="GstDPVersion" get-type="gst_dp_version_get_type">
			<member name="GST_DP_VERSION_0_2" value="1"/>
			<member name="GST_DP_VERSION_1_0" value="2"/>
		</enum>
		<constant name="GST_DP_HEADER_LENGTH" type="int" value="62"/>
		<constant name="GST_DP_VERSION_MAJOR" type="int" value="0"/>
		<constant name="GST_DP_VERSION_MINOR" type="int" value="2"/>
	</namespace>
</api>
