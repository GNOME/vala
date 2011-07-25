<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<struct name="GstNetTimePacket">
			<method name="new" symbol="gst_net_time_packet_new">
				<return-type type="GstNetTimePacket*"/>
				<parameters>
					<parameter name="buffer" type="guint8*"/>
				</parameters>
			</method>
			<method name="receive" symbol="gst_net_time_packet_receive">
				<return-type type="GstNetTimePacket*"/>
				<parameters>
					<parameter name="fd" type="gint"/>
					<parameter name="addr" type="struct sockaddr*"/>
					<parameter name="len" type="socklen_t*"/>
				</parameters>
			</method>
			<method name="send" symbol="gst_net_time_packet_send">
				<return-type type="gint"/>
				<parameters>
					<parameter name="packet" type="GstNetTimePacket*"/>
					<parameter name="fd" type="gint"/>
					<parameter name="addr" type="struct sockaddr*"/>
					<parameter name="len" type="socklen_t"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gst_net_time_packet_serialize">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="packet" type="GstNetTimePacket*"/>
				</parameters>
			</method>
			<field name="local_time" type="GstClockTime"/>
			<field name="remote_time" type="GstClockTime"/>
		</struct>
		<object name="GstNetClientClock" parent="GstSystemClock" type-name="GstNetClientClock" get-type="gst_net_client_clock_get_type">
			<constructor name="new" symbol="gst_net_client_clock_new">
				<return-type type="GstClock*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="remote_address" type="gchar*"/>
					<parameter name="remote_port" type="gint"/>
					<parameter name="base_time" type="GstClockTime"/>
				</parameters>
			</constructor>
			<property name="address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="port" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="address" type="gchar*"/>
			<field name="port" type="gint"/>
			<field name="sock" type="int"/>
			<field name="control_sock" type="int[]"/>
			<field name="current_timeout" type="GstClockTime"/>
			<field name="servaddr" type="struct sockaddr_in*"/>
			<field name="thread" type="GThread*"/>
		</object>
		<object name="GstNetTimeProvider" parent="GstObject" type-name="GstNetTimeProvider" get-type="gst_net_time_provider_get_type">
			<constructor name="new" symbol="gst_net_time_provider_new">
				<return-type type="GstNetTimeProvider*"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="address" type="gchar*"/>
					<parameter name="port" type="gint"/>
				</parameters>
			</constructor>
			<property name="active" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="clock" type="GstClock*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="port" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="address" type="gchar*"/>
			<field name="port" type="int"/>
			<field name="sock" type="int"/>
			<field name="control_sock" type="int[]"/>
			<field name="thread" type="GThread*"/>
			<field name="clock" type="GstClock*"/>
			<field name="active" type="gpointer"/>
		</object>
		<constant name="GST_NET_TIME_PACKET_SIZE" type="int" value="16"/>
	</namespace>
</api>
