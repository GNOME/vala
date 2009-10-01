<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<struct name="GstNetAddress">
			<method name="equal" symbol="gst_netaddress_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="naddr1" type="GstNetAddress*"/>
					<parameter name="naddr2" type="GstNetAddress*"/>
				</parameters>
			</method>
			<method name="get_address_bytes" symbol="gst_netaddress_get_address_bytes">
				<return-type type="gint"/>
				<parameters>
					<parameter name="naddr" type="GstNetAddress*"/>
					<parameter name="address" type="guint8[]"/>
					<parameter name="port" type="guint16*"/>
				</parameters>
			</method>
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
			<method name="set_address_bytes" symbol="gst_netaddress_set_address_bytes">
				<return-type type="gint"/>
				<parameters>
					<parameter name="naddr" type="GstNetAddress*"/>
					<parameter name="type" type="GstNetType"/>
					<parameter name="address" type="guint8[]"/>
					<parameter name="port" type="guint16"/>
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
			<method name="to_string" symbol="gst_netaddress_to_string">
				<return-type type="gint"/>
				<parameters>
					<parameter name="naddr" type="GstNetAddress*"/>
					<parameter name="dest" type="gchar*"/>
					<parameter name="len" type="gulong"/>
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
		<constant name="GST_NETADDRESS_MAX_LEN" type="int" value="64"/>
	</namespace>
</api>
