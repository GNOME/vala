<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<struct name="GstNetAddress">
			<method name="get_ip4_address" symbol="gst_netaddress_get_ip4_address">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="naddr" type="GstNetAddress*"/>
					<parameter name="address" type="guint32*"/>
					<parameter name="port" type="guint16*"/>
				</parameters>
			</method>
			<method name="get_ip6_address" symbol="gst_netaddress_get_ip6_address">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="naddr" type="GstNetAddress*"/>
					<parameter name="address" type="guint8[]"/>
					<parameter name="port" type="guint16*"/>
				</parameters>
			</method>
			<method name="get_net_type" symbol="gst_netaddress_get_net_type">
				<return-type type="GstNetType"/>
				<parameters>
					<parameter name="naddr" type="GstNetAddress*"/>
				</parameters>
			</method>
			<method name="set_ip4_address" symbol="gst_netaddress_set_ip4_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="naddr" type="GstNetAddress*"/>
					<parameter name="address" type="guint32"/>
					<parameter name="port" type="guint16"/>
				</parameters>
			</method>
			<method name="set_ip6_address" symbol="gst_netaddress_set_ip6_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="naddr" type="GstNetAddress*"/>
					<parameter name="address" type="guint8[]"/>
					<parameter name="port" type="guint16"/>
				</parameters>
			</method>
			<field name="type" type="GstNetType"/>
			<field name="address" type="gpointer"/>
			<field name="port" type="guint16"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstNetBuffer">
			<method name="new" symbol="gst_netbuffer_new">
				<return-type type="GstNetBuffer*"/>
			</method>
			<field name="buffer" type="GstBuffer"/>
			<field name="from" type="GstNetAddress"/>
			<field name="to" type="GstNetAddress"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstNetBufferClass">
			<field name="buffer_class" type="GstBufferClass"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<enum name="GstNetType">
			<member name="GST_NET_TYPE_UNKNOWN" value="0"/>
			<member name="GST_NET_TYPE_IP4" value="1"/>
			<member name="GST_NET_TYPE_IP6" value="2"/>
		</enum>
	</namespace>
</api>
