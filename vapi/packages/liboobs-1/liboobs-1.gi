<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Oobs">
		<function name="error_quark" symbol="oobs_error_quark">
			<return-type type="GQuark"/>
		</function>
		<callback name="OobsObjectAsyncFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="object" type="OobsObject*"/>
				<parameter name="result" type="OobsResult"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="OobsPlatform">
			<field name="id" type="gchar*"/>
			<field name="name" type="gchar*"/>
			<field name="version" type="gchar*"/>
			<field name="codename" type="gchar*"/>
		</struct>
		<struct name="OobsServicesRunlevel">
			<field name="name" type="gchar*"/>
			<field name="role" type="guint"/>
		</struct>
		<struct name="OobsShareAclElement">
			<field name="element" type="gchar*"/>
			<field name="read_only" type="gboolean"/>
		</struct>
		<boxed name="OobsListIter" type-name="OobsListIter" get-type="oobs_list_iter_get_type">
			<method name="copy" symbol="oobs_list_iter_copy">
				<return-type type="OobsListIter*"/>
				<parameters>
					<parameter name="iter" type="OobsListIter*"/>
				</parameters>
			</method>
			<method name="free" symbol="oobs_list_iter_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="OobsListIter*"/>
				</parameters>
			</method>
			<method name="next" symbol="oobs_list_iter_next">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="OobsList*"/>
					<parameter name="iter" type="OobsListIter*"/>
				</parameters>
			</method>
			<field name="stamp" type="guint"/>
			<field name="data" type="gpointer"/>
		</boxed>
		<enum name="OobsDialType" type-name="OobsDialType" get-type="oobs_dial_type_get_type">
			<member name="OOBS_DIAL_TYPE_TONES" value="0"/>
			<member name="OOBS_DIAL_TYPE_PULSES" value="1"/>
		</enum>
		<enum name="OobsError" type-name="OobsError" get-type="oobs_error_get_type">
			<member name="OOBS_ERROR_AUTHENTICATION_FAILED" value="0"/>
			<member name="OOBS_ERROR_AUTHENTICATION_CANCELLED" value="1"/>
		</enum>
		<enum name="OobsIfaceType" type-name="OobsIfaceType" get-type="oobs_iface_type_get_type">
			<member name="OOBS_IFACE_TYPE_ETHERNET" value="0"/>
			<member name="OOBS_IFACE_TYPE_WIRELESS" value="1"/>
			<member name="OOBS_IFACE_TYPE_IRLAN" value="2"/>
			<member name="OOBS_IFACE_TYPE_PLIP" value="3"/>
			<member name="OOBS_IFACE_TYPE_PPP" value="4"/>
		</enum>
		<enum name="OobsModemVolume" type-name="OobsModemVolume" get-type="oobs_modem_volume_get_type">
			<member name="OOBS_MODEM_VOLUME_SILENT" value="0"/>
			<member name="OOBS_MODEM_VOLUME_LOW" value="1"/>
			<member name="OOBS_MODEM_VOLUME_MEDIUM" value="2"/>
			<member name="OOBS_MODEM_VOLUME_LOUD" value="3"/>
		</enum>
		<enum name="OobsResult" type-name="OobsResult" get-type="oobs_result_get_type">
			<member name="OOBS_RESULT_OK" value="0"/>
			<member name="OOBS_RESULT_ACCESS_DENIED" value="1"/>
			<member name="OOBS_RESULT_NO_PLATFORM" value="2"/>
			<member name="OOBS_RESULT_MALFORMED_DATA" value="3"/>
			<member name="OOBS_RESULT_ERROR" value="4"/>
		</enum>
		<enum name="OobsRunlevelRole" type-name="OobsRunlevelRole" get-type="oobs_runlevel_role_get_type">
			<member name="OOBS_RUNLEVEL_HALT" value="0"/>
			<member name="OOBS_RUNLEVEL_REBOOT" value="1"/>
			<member name="OOBS_RUNLEVEL_MONOUSER" value="2"/>
			<member name="OOBS_RUNLEVEL_MULTIUSER" value="3"/>
		</enum>
		<enum name="OobsServiceStatus" type-name="OobsServiceStatus" get-type="oobs_service_status_get_type">
			<member name="OOBS_SERVICE_START" value="0"/>
			<member name="OOBS_SERVICE_STOP" value="1"/>
			<member name="OOBS_SERVICE_IGNORE" value="2"/>
		</enum>
		<flags name="OobsShareSMBFlags" type-name="OobsShareSMBFlags" get-type="oobs_share_smb_flags_get_type">
			<member name="OOBS_SHARE_SMB_ENABLED" value="1"/>
			<member name="OOBS_SHARE_SMB_BROWSABLE" value="2"/>
			<member name="OOBS_SHARE_SMB_PUBLIC" value="4"/>
			<member name="OOBS_SHARE_SMB_WRITABLE" value="8"/>
		</flags>
		<flags name="OobsUserHomeFlags" type-name="OobsUserHomeFlags" get-type="oobs_user_home_flags_get_type">
			<member name="OOBS_USER_REMOVE_HOME" value="1"/>
			<member name="OOBS_USER_CHOWN_HOME" value="2"/>
		</flags>
		<object name="OobsGroup" parent="OobsObject" type-name="OobsGroup" get-type="oobs_group_get_type">
			<method name="add_user" symbol="oobs_group_add_user">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="OobsGroup*"/>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="clear_users" symbol="oobs_group_clear_users">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="OobsGroup*"/>
				</parameters>
			</method>
			<method name="get_gid" symbol="oobs_group_get_gid">
				<return-type type="gid_t"/>
				<parameters>
					<parameter name="group" type="OobsGroup*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="oobs_group_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="group" type="OobsGroup*"/>
				</parameters>
			</method>
			<method name="get_users" symbol="oobs_group_get_users">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="group" type="OobsGroup*"/>
				</parameters>
			</method>
			<method name="is_root" symbol="oobs_group_is_root">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="group" type="OobsGroup*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="oobs_group_new">
				<return-type type="OobsGroup*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="remove_user" symbol="oobs_group_remove_user">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="OobsGroup*"/>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="set_gid" symbol="oobs_group_set_gid">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="OobsGroup*"/>
					<parameter name="gid" type="gid_t"/>
				</parameters>
			</method>
			<method name="set_password" symbol="oobs_group_set_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="OobsGroup*"/>
					<parameter name="password" type="gchar*"/>
				</parameters>
			</method>
			<property name="gid" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="password" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsGroupsConfig" parent="OobsObject" type-name="OobsGroupsConfig" get-type="oobs_groups_config_get_type">
			<method name="add_group" symbol="oobs_groups_config_add_group">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="config" type="OobsGroupsConfig*"/>
					<parameter name="group" type="OobsGroup*"/>
				</parameters>
			</method>
			<method name="delete_group" symbol="oobs_groups_config_delete_group">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="config" type="OobsGroupsConfig*"/>
					<parameter name="group" type="OobsGroup*"/>
				</parameters>
			</method>
			<method name="find_free_gid" symbol="oobs_groups_config_find_free_gid">
				<return-type type="gid_t"/>
				<parameters>
					<parameter name="config" type="OobsGroupsConfig*"/>
					<parameter name="gid_min" type="gid_t"/>
					<parameter name="gid_max" type="gid_t"/>
				</parameters>
			</method>
			<method name="get" symbol="oobs_groups_config_get">
				<return-type type="OobsObject*"/>
			</method>
			<method name="get_from_gid" symbol="oobs_groups_config_get_from_gid">
				<return-type type="OobsGroup*"/>
				<parameters>
					<parameter name="config" type="OobsGroupsConfig*"/>
					<parameter name="gid" type="gid_t"/>
				</parameters>
			</method>
			<method name="get_from_name" symbol="oobs_groups_config_get_from_name">
				<return-type type="OobsGroup*"/>
				<parameters>
					<parameter name="config" type="OobsGroupsConfig*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_groups" symbol="oobs_groups_config_get_groups">
				<return-type type="OobsList*"/>
				<parameters>
					<parameter name="config" type="OobsGroupsConfig*"/>
				</parameters>
			</method>
			<method name="is_gid_used" symbol="oobs_groups_config_is_gid_used">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="OobsGroupsConfig*"/>
					<parameter name="gid" type="gid_t"/>
				</parameters>
			</method>
			<method name="is_name_used" symbol="oobs_groups_config_is_name_used">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="OobsGroupsConfig*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<property name="maximum-gid" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="minimum-gid" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsHostsConfig" parent="OobsObject" type-name="OobsHostsConfig" get-type="oobs_hosts_config_get_type">
			<method name="get" symbol="oobs_hosts_config_get">
				<return-type type="OobsObject*"/>
			</method>
			<method name="get_dns_servers" symbol="oobs_hosts_config_get_dns_servers">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="config" type="OobsHostsConfig*"/>
				</parameters>
			</method>
			<method name="get_domainname" symbol="oobs_hosts_config_get_domainname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="config" type="OobsHostsConfig*"/>
				</parameters>
			</method>
			<method name="get_hostname" symbol="oobs_hosts_config_get_hostname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="config" type="OobsHostsConfig*"/>
				</parameters>
			</method>
			<method name="get_search_domains" symbol="oobs_hosts_config_get_search_domains">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="config" type="OobsHostsConfig*"/>
				</parameters>
			</method>
			<method name="get_static_hosts" symbol="oobs_hosts_config_get_static_hosts">
				<return-type type="OobsList*"/>
				<parameters>
					<parameter name="config" type="OobsHostsConfig*"/>
				</parameters>
			</method>
			<method name="set_dns_servers" symbol="oobs_hosts_config_set_dns_servers">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsHostsConfig*"/>
					<parameter name="dns_list" type="GList*"/>
				</parameters>
			</method>
			<method name="set_domainname" symbol="oobs_hosts_config_set_domainname">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsHostsConfig*"/>
					<parameter name="domainname" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_hostname" symbol="oobs_hosts_config_set_hostname">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsHostsConfig*"/>
					<parameter name="hostname" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_search_domains" symbol="oobs_hosts_config_set_search_domains">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsHostsConfig*"/>
					<parameter name="search_domains_list" type="GList*"/>
				</parameters>
			</method>
		</object>
		<object name="OobsIface" parent="GObject" type-name="OobsIface" get-type="oobs_iface_get_type">
			<method name="get_active" symbol="oobs_iface_get_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iface" type="OobsIface*"/>
				</parameters>
			</method>
			<method name="get_auto" symbol="oobs_iface_get_auto">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iface" type="OobsIface*"/>
				</parameters>
			</method>
			<method name="get_configured" symbol="oobs_iface_get_configured">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iface" type="OobsIface*"/>
				</parameters>
			</method>
			<method name="get_device_name" symbol="oobs_iface_get_device_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIface*"/>
				</parameters>
			</method>
			<method name="has_gateway" symbol="oobs_iface_has_gateway">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iface" type="OobsIface*"/>
				</parameters>
			</method>
			<method name="set_active" symbol="oobs_iface_set_active">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIface*"/>
					<parameter name="is_active" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_auto" symbol="oobs_iface_set_auto">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIface*"/>
					<parameter name="is_auto" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_configured" symbol="oobs_iface_set_configured">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIface*"/>
					<parameter name="is_configured" type="gboolean"/>
				</parameters>
			</method>
			<property name="active" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="auto" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="configured" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="device" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="state-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIface*"/>
				</parameters>
			</signal>
			<vfunc name="has_gateway">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="p1" type="OobsIface*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_configured">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="p1" type="OobsIface*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="OobsIfaceEthernet" parent="OobsIface" type-name="OobsIfaceEthernet" get-type="oobs_iface_ethernet_get_type">
			<method name="get_broadcast_address" symbol="oobs_iface_ethernet_get_broadcast_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceEthernet*"/>
				</parameters>
			</method>
			<method name="get_configuration_method" symbol="oobs_iface_ethernet_get_configuration_method">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceEthernet*"/>
				</parameters>
			</method>
			<method name="get_gateway_address" symbol="oobs_iface_ethernet_get_gateway_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceEthernet*"/>
				</parameters>
			</method>
			<method name="get_ip_address" symbol="oobs_iface_ethernet_get_ip_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceEthernet*"/>
				</parameters>
			</method>
			<method name="get_network_address" symbol="oobs_iface_ethernet_get_network_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceEthernet*"/>
				</parameters>
			</method>
			<method name="get_network_mask" symbol="oobs_iface_ethernet_get_network_mask">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceEthernet*"/>
				</parameters>
			</method>
			<method name="set_broadcast_address" symbol="oobs_iface_ethernet_set_broadcast_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceEthernet*"/>
					<parameter name="address" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_configuration_method" symbol="oobs_iface_ethernet_set_configuration_method">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceEthernet*"/>
					<parameter name="method" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_gateway_address" symbol="oobs_iface_ethernet_set_gateway_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceEthernet*"/>
					<parameter name="address" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_ip_address" symbol="oobs_iface_ethernet_set_ip_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceEthernet*"/>
					<parameter name="address" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_network_address" symbol="oobs_iface_ethernet_set_network_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceEthernet*"/>
					<parameter name="address" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_network_mask" symbol="oobs_iface_ethernet_set_network_mask">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceEthernet*"/>
					<parameter name="mask" type="gchar*"/>
				</parameters>
			</method>
			<property name="broadcast-address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="config-method" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="gateway-address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ip-address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ip-mask" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="network-address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsIfaceIRLan" parent="OobsIfaceEthernet" type-name="OobsIfaceIRLan" get-type="oobs_iface_irlan_get_type">
		</object>
		<object name="OobsIfacePPP" parent="OobsIface" type-name="OobsIfacePPP" get-type="oobs_iface_ppp_get_type">
			<method name="get_apn" symbol="oobs_iface_ppp_get_apn">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="get_connection_type" symbol="oobs_iface_ppp_get_connection_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="get_default_gateway" symbol="oobs_iface_ppp_get_default_gateway">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="get_dial_type" symbol="oobs_iface_ppp_get_dial_type">
				<return-type type="OobsDialType"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="get_ethernet" symbol="oobs_iface_ppp_get_ethernet">
				<return-type type="OobsIfaceEthernet*"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="get_login" symbol="oobs_iface_ppp_get_login">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="get_peer_noauth" symbol="oobs_iface_ppp_get_peer_noauth">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="get_persistent" symbol="oobs_iface_ppp_get_persistent">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="get_phone_number" symbol="oobs_iface_ppp_get_phone_number">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="get_phone_prefix" symbol="oobs_iface_ppp_get_phone_prefix">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="get_serial_port" symbol="oobs_iface_ppp_get_serial_port">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="get_use_peer_dns" symbol="oobs_iface_ppp_get_use_peer_dns">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="get_volume" symbol="oobs_iface_ppp_get_volume">
				<return-type type="OobsModemVolume"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
				</parameters>
			</method>
			<method name="set_apn" symbol="oobs_iface_ppp_set_apn">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="apn" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_connection_type" symbol="oobs_iface_ppp_set_connection_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="type" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_default_gateway" symbol="oobs_iface_ppp_set_default_gateway">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="default_gw" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_dial_type" symbol="oobs_iface_ppp_set_dial_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="dial_type" type="OobsDialType"/>
				</parameters>
			</method>
			<method name="set_ethernet" symbol="oobs_iface_ppp_set_ethernet">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="ethernet" type="OobsIfaceEthernet*"/>
				</parameters>
			</method>
			<method name="set_login" symbol="oobs_iface_ppp_set_login">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="login" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_password" symbol="oobs_iface_ppp_set_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="password" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_peer_noauth" symbol="oobs_iface_ppp_set_peer_noauth">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="use_peer_dns" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_persistent" symbol="oobs_iface_ppp_set_persistent">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="persistent" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_phone_number" symbol="oobs_iface_ppp_set_phone_number">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="phone_number" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_phone_prefix" symbol="oobs_iface_ppp_set_phone_prefix">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="phone_prefix" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_serial_port" symbol="oobs_iface_ppp_set_serial_port">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="serial_port" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_use_peer_dns" symbol="oobs_iface_ppp_set_use_peer_dns">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="use_peer_dns" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_volume" symbol="oobs_iface_ppp_set_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePPP*"/>
					<parameter name="volume" type="OobsModemVolume"/>
				</parameters>
			</method>
			<property name="apn" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="connection-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="default-gateway" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="dial-type" type="OobsDialType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ethernet" type="OobsIfaceEthernet*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="iface-section" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="login" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="password" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="peer-noauth" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="persistent" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="phone-number" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="phone-prefix" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="serial-port" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-peer-dns" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="volume" type="OobsModemVolume" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsIfacePlip" parent="OobsIface" type-name="OobsIfacePlip" get-type="oobs_iface_plip_get_type">
			<method name="get_address" symbol="oobs_iface_plip_get_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePlip*"/>
				</parameters>
			</method>
			<method name="get_remote_address" symbol="oobs_iface_plip_get_remote_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePlip*"/>
				</parameters>
			</method>
			<method name="set_address" symbol="oobs_iface_plip_set_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePlip*"/>
					<parameter name="address" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_remote_address" symbol="oobs_iface_plip_set_remote_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfacePlip*"/>
					<parameter name="address" type="gchar*"/>
				</parameters>
			</method>
			<property name="address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="remote-address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsIfaceWireless" parent="OobsIfaceEthernet" type-name="OobsIfaceWireless" get-type="oobs_iface_wireless_get_type">
			<method name="get_essid" symbol="oobs_iface_wireless_get_essid">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceWireless*"/>
				</parameters>
			</method>
			<method name="get_key" symbol="oobs_iface_wireless_get_key">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceWireless*"/>
				</parameters>
			</method>
			<method name="get_key_type" symbol="oobs_iface_wireless_get_key_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceWireless*"/>
				</parameters>
			</method>
			<method name="set_essid" symbol="oobs_iface_wireless_set_essid">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceWireless*"/>
					<parameter name="essid" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_key" symbol="oobs_iface_wireless_set_key">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceWireless*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_key_type" symbol="oobs_iface_wireless_set_key_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="OobsIfaceWireless*"/>
					<parameter name="key_type" type="gchar*"/>
				</parameters>
			</method>
			<property name="essid" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="key" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="key-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsIfacesConfig" parent="OobsObject" type-name="OobsIfacesConfig" get-type="oobs_ifaces_config_get_type">
			<method name="get" symbol="oobs_ifaces_config_get">
				<return-type type="OobsObject*"/>
			</method>
			<method name="get_available_configuration_methods" symbol="oobs_ifaces_config_get_available_configuration_methods">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="config" type="OobsIfacesConfig*"/>
				</parameters>
			</method>
			<method name="get_available_key_types" symbol="oobs_ifaces_config_get_available_key_types">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="config" type="OobsIfacesConfig*"/>
				</parameters>
			</method>
			<method name="get_available_ppp_types" symbol="oobs_ifaces_config_get_available_ppp_types">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="config" type="OobsIfacesConfig*"/>
				</parameters>
			</method>
			<method name="get_ifaces" symbol="oobs_ifaces_config_get_ifaces">
				<return-type type="OobsList*"/>
				<parameters>
					<parameter name="config" type="OobsIfacesConfig*"/>
					<parameter name="type" type="OobsIfaceType"/>
				</parameters>
			</method>
		</object>
		<object name="OobsList" parent="GObject" type-name="OobsList" get-type="oobs_list_get_type">
			<method name="append" symbol="oobs_list_append">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="OobsList*"/>
					<parameter name="iter" type="OobsListIter*"/>
				</parameters>
			</method>
			<method name="clear" symbol="oobs_list_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="OobsList*"/>
				</parameters>
			</method>
			<method name="get" symbol="oobs_list_get">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="list" type="OobsList*"/>
					<parameter name="iter" type="OobsListIter*"/>
				</parameters>
			</method>
			<method name="get_iter_first" symbol="oobs_list_get_iter_first">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="OobsList*"/>
					<parameter name="iter" type="OobsListIter*"/>
				</parameters>
			</method>
			<method name="get_n_items" symbol="oobs_list_get_n_items">
				<return-type type="gint"/>
				<parameters>
					<parameter name="list" type="OobsList*"/>
				</parameters>
			</method>
			<method name="insert_after" symbol="oobs_list_insert_after">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="OobsList*"/>
					<parameter name="anchor" type="OobsListIter*"/>
					<parameter name="iter" type="OobsListIter*"/>
				</parameters>
			</method>
			<method name="insert_before" symbol="oobs_list_insert_before">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="OobsList*"/>
					<parameter name="anchor" type="OobsListIter*"/>
					<parameter name="iter" type="OobsListIter*"/>
				</parameters>
			</method>
			<method name="prepend" symbol="oobs_list_prepend">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="OobsList*"/>
					<parameter name="iter" type="OobsListIter*"/>
				</parameters>
			</method>
			<method name="remove" symbol="oobs_list_remove">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="OobsList*"/>
					<parameter name="iter" type="OobsListIter*"/>
				</parameters>
			</method>
			<method name="set" symbol="oobs_list_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="OobsList*"/>
					<parameter name="iter" type="OobsListIter*"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<property name="contained-type" type="gpointer" readable="0" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="OobsNFSConfig" parent="OobsObject" type-name="OobsNFSConfig" get-type="oobs_nfs_config_get_type">
			<method name="get" symbol="oobs_nfs_config_get">
				<return-type type="OobsObject*"/>
			</method>
			<method name="get_shares" symbol="oobs_nfs_config_get_shares">
				<return-type type="OobsList*"/>
				<parameters>
					<parameter name="config" type="OobsNFSConfig*"/>
				</parameters>
			</method>
		</object>
		<object name="OobsNTPConfig" parent="OobsObject" type-name="OobsNTPConfig" get-type="oobs_ntp_config_get_type">
			<method name="get" symbol="oobs_ntp_config_get">
				<return-type type="OobsObject*"/>
			</method>
			<method name="get_servers" symbol="oobs_ntp_config_get_servers">
				<return-type type="OobsList*"/>
				<parameters>
					<parameter name="config" type="OobsNTPConfig*"/>
				</parameters>
			</method>
		</object>
		<object name="OobsNTPServer" parent="GObject" type-name="OobsNTPServer" get-type="oobs_ntp_server_get_type">
			<method name="get_hostname" symbol="oobs_ntp_server_get_hostname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="ntp_server" type="OobsNTPServer*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="oobs_ntp_server_new">
				<return-type type="OobsNTPServer*"/>
				<parameters>
					<parameter name="hostname" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_hostname" symbol="oobs_ntp_server_set_hostname">
				<return-type type="void"/>
				<parameters>
					<parameter name="ntp_server" type="OobsNTPServer*"/>
					<parameter name="hostname" type="gchar*"/>
				</parameters>
			</method>
			<property name="hostname" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsObject" parent="GObject" type-name="OobsObject" get-type="oobs_object_get_type">
			<method name="add" symbol="oobs_object_add">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</method>
			<method name="add_async" symbol="oobs_object_add_async">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
					<parameter name="func" type="OobsObjectAsyncFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="authenticate" symbol="oobs_object_authenticate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="commit" symbol="oobs_object_commit">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</method>
			<method name="commit_async" symbol="oobs_object_commit_async">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
					<parameter name="func" type="OobsObjectAsyncFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="delete" symbol="oobs_object_delete">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</method>
			<method name="delete_async" symbol="oobs_object_delete_async">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
					<parameter name="func" type="OobsObjectAsyncFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="ensure_update" symbol="oobs_object_ensure_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</method>
			<method name="has_updated" symbol="oobs_object_has_updated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</method>
			<method name="process_requests" symbol="oobs_object_process_requests">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</method>
			<method name="update" symbol="oobs_object_update">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</method>
			<method name="update_async" symbol="oobs_object_update_async">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
					<parameter name="func" type="OobsObjectAsyncFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<property name="remote-object" type="char*" readable="0" writable="1" construct="0" construct-only="1"/>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</signal>
			<signal name="committed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</signal>
			<signal name="updated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</signal>
			<vfunc name="commit">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_update_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="update">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="OobsObject*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="OobsSMBConfig" parent="OobsObject" type-name="OobsSMBConfig" get-type="oobs_smb_config_get_type">
			<method name="delete_user_password" symbol="oobs_smb_config_delete_user_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsSMBConfig*"/>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get" symbol="oobs_smb_config_get">
				<return-type type="OobsObject*"/>
			</method>
			<method name="get_description" symbol="oobs_smb_config_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="config" type="OobsSMBConfig*"/>
				</parameters>
			</method>
			<method name="get_is_wins_server" symbol="oobs_smb_config_get_is_wins_server">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="OobsSMBConfig*"/>
				</parameters>
			</method>
			<method name="get_shares" symbol="oobs_smb_config_get_shares">
				<return-type type="OobsList*"/>
				<parameters>
					<parameter name="config" type="OobsSMBConfig*"/>
				</parameters>
			</method>
			<method name="get_wins_server" symbol="oobs_smb_config_get_wins_server">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="config" type="OobsSMBConfig*"/>
				</parameters>
			</method>
			<method name="get_workgroup" symbol="oobs_smb_config_get_workgroup">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="config" type="OobsSMBConfig*"/>
				</parameters>
			</method>
			<method name="set_description" symbol="oobs_smb_config_set_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsSMBConfig*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_is_wins_server" symbol="oobs_smb_config_set_is_wins_server">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsSMBConfig*"/>
					<parameter name="is_wins_server" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_user_password" symbol="oobs_smb_config_set_user_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsSMBConfig*"/>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="password" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_wins_server" symbol="oobs_smb_config_set_wins_server">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsSMBConfig*"/>
					<parameter name="wins_server" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_workgroup" symbol="oobs_smb_config_set_workgroup">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsSMBConfig*"/>
					<parameter name="workgroup" type="gchar*"/>
				</parameters>
			</method>
			<method name="user_has_password" symbol="oobs_smb_config_user_has_password">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="OobsSMBConfig*"/>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<property name="description" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-wins-server" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="wins-server" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="workgroup" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsSelfConfig" parent="OobsObject" type-name="OobsSelfConfig" get-type="oobs_self_config_get_type">
			<method name="get" symbol="oobs_self_config_get">
				<return-type type="OobsObject*"/>
			</method>
			<method name="get_user" symbol="oobs_self_config_get_user">
				<return-type type="OobsUser*"/>
				<parameters>
					<parameter name="config" type="OobsSelfConfig*"/>
				</parameters>
			</method>
			<method name="is_user_self" symbol="oobs_self_config_is_user_self">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="OobsSelfConfig*"/>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
		</object>
		<object name="OobsService" parent="OobsObject" type-name="OobsService" get-type="oobs_service_get_type">
			<method name="get_name" symbol="oobs_service_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="service" type="OobsService*"/>
				</parameters>
			</method>
			<method name="get_runlevel_configuration" symbol="oobs_service_get_runlevel_configuration">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="OobsService*"/>
					<parameter name="runlevel" type="OobsServicesRunlevel*"/>
					<parameter name="status" type="OobsServiceStatus*"/>
					<parameter name="priority" type="gint*"/>
				</parameters>
			</method>
			<method name="set_runlevel_configuration" symbol="oobs_service_set_runlevel_configuration">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="OobsService*"/>
					<parameter name="runlevel" type="OobsServicesRunlevel*"/>
					<parameter name="status" type="OobsServiceStatus"/>
					<parameter name="priority" type="gint"/>
				</parameters>
			</method>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="OobsServicesConfig" parent="OobsObject" type-name="OobsServicesConfig" get-type="oobs_services_config_get_type">
			<method name="get" symbol="oobs_services_config_get">
				<return-type type="OobsObject*"/>
			</method>
			<method name="get_default_runlevel" symbol="oobs_services_config_get_default_runlevel">
				<return-type type="OobsServicesRunlevel*"/>
				<parameters>
					<parameter name="config" type="OobsServicesConfig*"/>
				</parameters>
			</method>
			<method name="get_runlevels" symbol="oobs_services_config_get_runlevels">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="config" type="OobsServicesConfig*"/>
				</parameters>
			</method>
			<method name="get_services" symbol="oobs_services_config_get_services">
				<return-type type="OobsList*"/>
				<parameters>
					<parameter name="config" type="OobsServicesConfig*"/>
				</parameters>
			</method>
		</object>
		<object name="OobsSession" parent="GObject" type-name="OobsSession" get-type="oobs_session_get_type">
			<method name="commit" symbol="oobs_session_commit">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="session" type="OobsSession*"/>
				</parameters>
			</method>
			<method name="get" symbol="oobs_session_get">
				<return-type type="OobsSession*"/>
			</method>
			<method name="get_authentication_action" symbol="oobs_session_get_authentication_action">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="session" type="OobsSession*"/>
				</parameters>
			</method>
			<method name="get_connected" symbol="oobs_session_get_connected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="session" type="OobsSession*"/>
				</parameters>
			</method>
			<method name="get_platform" symbol="oobs_session_get_platform">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="session" type="OobsSession*"/>
					<parameter name="platform" type="gchar**"/>
				</parameters>
			</method>
			<method name="get_supported_platforms" symbol="oobs_session_get_supported_platforms">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="session" type="OobsSession*"/>
					<parameter name="platforms" type="GList**"/>
				</parameters>
			</method>
			<method name="process_requests" symbol="oobs_session_process_requests">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="OobsSession*"/>
				</parameters>
			</method>
			<method name="set_platform" symbol="oobs_session_set_platform">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="session" type="OobsSession*"/>
					<parameter name="platform" type="gchar*"/>
				</parameters>
			</method>
			<property name="platform" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsShare" parent="GObject" type-name="OobsShare" get-type="oobs_share_get_type">
			<method name="get_path" symbol="oobs_share_get_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="share" type="OobsShare*"/>
				</parameters>
			</method>
			<method name="set_path" symbol="oobs_share_set_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="share" type="OobsShare*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<property name="path" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsShareNFS" parent="OobsShare" type-name="OobsShareNFS" get-type="oobs_share_nfs_get_type">
			<method name="add_acl_element" symbol="oobs_share_nfs_add_acl_element">
				<return-type type="void"/>
				<parameters>
					<parameter name="share" type="OobsShareNFS*"/>
					<parameter name="element" type="gchar*"/>
					<parameter name="read_only" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_acl" symbol="oobs_share_nfs_get_acl">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="share" type="OobsShareNFS*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="oobs_share_nfs_new">
				<return-type type="OobsShare*"/>
				<parameters>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_acl" symbol="oobs_share_nfs_set_acl">
				<return-type type="void"/>
				<parameters>
					<parameter name="share" type="OobsShareNFS*"/>
					<parameter name="acl" type="GSList*"/>
				</parameters>
			</method>
		</object>
		<object name="OobsShareSMB" parent="OobsShare" type-name="OobsShareSMB" get-type="oobs_share_smb_get_type">
			<method name="get_comment" symbol="oobs_share_smb_get_comment">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="share" type="OobsShareSMB*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="oobs_share_smb_get_flags">
				<return-type type="OobsShareSMBFlags"/>
				<parameters>
					<parameter name="share" type="OobsShareSMB*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="oobs_share_smb_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="share" type="OobsShareSMB*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="oobs_share_smb_new">
				<return-type type="OobsShare*"/>
				<parameters>
					<parameter name="path" type="gchar*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="comment" type="gchar*"/>
					<parameter name="flags" type="OobsShareSMBFlags"/>
				</parameters>
			</constructor>
			<method name="set_comment" symbol="oobs_share_smb_set_comment">
				<return-type type="void"/>
				<parameters>
					<parameter name="share" type="OobsShareSMB*"/>
					<parameter name="comment" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_flags" symbol="oobs_share_smb_set_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="share" type="OobsShareSMB*"/>
					<parameter name="flags" type="OobsShareSMBFlags"/>
				</parameters>
			</method>
			<method name="set_name" symbol="oobs_share_smb_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="share" type="OobsShareSMB*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<property name="comment" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="flags" type="OobsShareSMBFlags" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="OobsStaticHost" parent="GObject" type-name="OobsStaticHost" get-type="oobs_static_host_get_type">
			<method name="get_aliases" symbol="oobs_static_host_get_aliases">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="static_host" type="OobsStaticHost*"/>
				</parameters>
			</method>
			<method name="get_ip_address" symbol="oobs_static_host_get_ip_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="static_host" type="OobsStaticHost*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="oobs_static_host_new">
				<return-type type="OobsStaticHost*"/>
				<parameters>
					<parameter name="ip_address" type="gchar*"/>
					<parameter name="aliases" type="GList*"/>
				</parameters>
			</constructor>
			<method name="set_aliases" symbol="oobs_static_host_set_aliases">
				<return-type type="void"/>
				<parameters>
					<parameter name="static_host" type="OobsStaticHost*"/>
					<parameter name="aliases" type="GList*"/>
				</parameters>
			</method>
			<method name="set_ip_address" symbol="oobs_static_host_set_ip_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="static_host" type="OobsStaticHost*"/>
					<parameter name="ip_address" type="gchar*"/>
				</parameters>
			</method>
			<property name="ip-address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsTimeConfig" parent="OobsObject" type-name="OobsTimeConfig" get-type="oobs_time_config_get_type">
			<method name="get" symbol="oobs_time_config_get">
				<return-type type="OobsObject*"/>
			</method>
			<method name="get_time" symbol="oobs_time_config_get_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsTimeConfig*"/>
					<parameter name="year" type="gint*"/>
					<parameter name="month" type="gint*"/>
					<parameter name="day" type="gint*"/>
					<parameter name="hour" type="gint*"/>
					<parameter name="minute" type="gint*"/>
					<parameter name="second" type="gint*"/>
				</parameters>
			</method>
			<method name="get_timezone" symbol="oobs_time_config_get_timezone">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="config" type="OobsTimeConfig*"/>
				</parameters>
			</method>
			<method name="get_unix_time" symbol="oobs_time_config_get_unix_time">
				<return-type type="glong"/>
				<parameters>
					<parameter name="config" type="OobsTimeConfig*"/>
				</parameters>
			</method>
			<method name="get_utc_time" symbol="oobs_time_config_get_utc_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsTimeConfig*"/>
					<parameter name="year" type="gint*"/>
					<parameter name="month" type="gint*"/>
					<parameter name="day" type="gint*"/>
					<parameter name="hour" type="gint*"/>
					<parameter name="minute" type="gint*"/>
					<parameter name="second" type="gint*"/>
				</parameters>
			</method>
			<method name="set_time" symbol="oobs_time_config_set_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsTimeConfig*"/>
					<parameter name="year" type="gint"/>
					<parameter name="month" type="gint"/>
					<parameter name="day" type="gint"/>
					<parameter name="hour" type="gint"/>
					<parameter name="minute" type="gint"/>
					<parameter name="second" type="gint"/>
				</parameters>
			</method>
			<method name="set_timezone" symbol="oobs_time_config_set_timezone">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsTimeConfig*"/>
					<parameter name="timezone" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_unix_time" symbol="oobs_time_config_set_unix_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsTimeConfig*"/>
					<parameter name="unix_time" type="glong"/>
				</parameters>
			</method>
			<method name="set_utc_time" symbol="oobs_time_config_set_utc_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsTimeConfig*"/>
					<parameter name="year" type="gint"/>
					<parameter name="month" type="gint"/>
					<parameter name="day" type="gint"/>
					<parameter name="hour" type="gint"/>
					<parameter name="minute" type="gint"/>
					<parameter name="second" type="gint"/>
				</parameters>
			</method>
			<property name="timezone" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="unix-time" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsUser" parent="OobsObject" type-name="OobsUser" get-type="oobs_user_get_type">
			<method name="get_active" symbol="oobs_user_get_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_encrypted_home" symbol="oobs_user_get_encrypted_home">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_full_name" symbol="oobs_user_get_full_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_home_directory" symbol="oobs_user_get_home_directory">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_home_phone_number" symbol="oobs_user_get_home_phone_number">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_locale" symbol="oobs_user_get_locale">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_login_name" symbol="oobs_user_get_login_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_main_group" symbol="oobs_user_get_main_group">
				<return-type type="OobsGroup*"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_other_data" symbol="oobs_user_get_other_data">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_password_disabled" symbol="oobs_user_get_password_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_password_empty" symbol="oobs_user_get_password_empty">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_room_number" symbol="oobs_user_get_room_number">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_shell" symbol="oobs_user_get_shell">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_uid" symbol="oobs_user_get_uid">
				<return-type type="uid_t"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="get_work_phone_number" symbol="oobs_user_get_work_phone_number">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="is_in_group" symbol="oobs_user_is_in_group">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="group" type="OobsGroup*"/>
				</parameters>
			</method>
			<method name="is_root" symbol="oobs_user_is_root">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="oobs_user_new">
				<return-type type="OobsUser*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_encrypted_home" symbol="oobs_user_set_encrypted_home">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="encrypted_home" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_full_name" symbol="oobs_user_set_full_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="full_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_home_directory" symbol="oobs_user_set_home_directory">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="home_directory" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_home_flags" symbol="oobs_user_set_home_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="home_flags" type="OobsUserHomeFlags"/>
				</parameters>
			</method>
			<method name="set_home_phone_number" symbol="oobs_user_set_home_phone_number">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="phone_number" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_locale" symbol="oobs_user_set_locale">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="locale" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_main_group" symbol="oobs_user_set_main_group">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="main_group" type="OobsGroup*"/>
				</parameters>
			</method>
			<method name="set_other_data" symbol="oobs_user_set_other_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="data" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_password" symbol="oobs_user_set_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="password" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_password_disabled" symbol="oobs_user_set_password_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="disabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_password_empty" symbol="oobs_user_set_password_empty">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="empty" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_room_number" symbol="oobs_user_set_room_number">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="room_number" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_shell" symbol="oobs_user_set_shell">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="shell" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_uid" symbol="oobs_user_set_uid">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="uid" type="uid_t"/>
				</parameters>
			</method>
			<method name="set_work_phone_number" symbol="oobs_user_set_work_phone_number">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="OobsUser*"/>
					<parameter name="phone_number" type="gchar*"/>
				</parameters>
			</method>
			<property name="active" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="encrypted-home" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="full-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="home-directory" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="home-flags" type="OobsUserHomeFlags" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="home-phone" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="locale" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="other-data" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="password" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="password-disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="password-empty" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="room-number" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="shell" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="uid" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="work-phone" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OobsUsersConfig" parent="OobsObject" type-name="OobsUsersConfig" get-type="oobs_users_config_get_type">
			<method name="add_user" symbol="oobs_users_config_add_user">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="delete_user" symbol="oobs_users_config_delete_user">
				<return-type type="OobsResult"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
					<parameter name="user" type="OobsUser*"/>
				</parameters>
			</method>
			<method name="find_free_uid" symbol="oobs_users_config_find_free_uid">
				<return-type type="uid_t"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
					<parameter name="uid_min" type="uid_t"/>
					<parameter name="uid_max" type="uid_t"/>
				</parameters>
			</method>
			<method name="get" symbol="oobs_users_config_get">
				<return-type type="OobsObject*"/>
			</method>
			<method name="get_available_locales" symbol="oobs_users_config_get_available_locales">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
				</parameters>
			</method>
			<method name="get_available_shells" symbol="oobs_users_config_get_available_shells">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
				</parameters>
			</method>
			<method name="get_default_group" symbol="oobs_users_config_get_default_group">
				<return-type type="OobsGroup*"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
				</parameters>
			</method>
			<method name="get_default_home_dir" symbol="oobs_users_config_get_default_home_dir">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
				</parameters>
			</method>
			<method name="get_default_shell" symbol="oobs_users_config_get_default_shell">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
				</parameters>
			</method>
			<method name="get_encrypted_home_support" symbol="oobs_users_config_get_encrypted_home_support">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
				</parameters>
			</method>
			<method name="get_from_login" symbol="oobs_users_config_get_from_login">
				<return-type type="OobsUser*"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
					<parameter name="login" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_from_uid" symbol="oobs_users_config_get_from_uid">
				<return-type type="OobsUser*"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
					<parameter name="uid" type="uid_t"/>
				</parameters>
			</method>
			<method name="get_maximum_users_uid" symbol="oobs_users_config_get_maximum_users_uid">
				<return-type type="uid_t"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
				</parameters>
			</method>
			<method name="get_minimum_users_uid" symbol="oobs_users_config_get_minimum_users_uid">
				<return-type type="uid_t"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
				</parameters>
			</method>
			<method name="get_users" symbol="oobs_users_config_get_users">
				<return-type type="OobsList*"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
				</parameters>
			</method>
			<method name="is_login_used" symbol="oobs_users_config_is_login_used">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
					<parameter name="login" type="gchar*"/>
				</parameters>
			</method>
			<method name="is_uid_used" symbol="oobs_users_config_is_uid_used">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
					<parameter name="uid" type="uid_t"/>
				</parameters>
			</method>
			<method name="set_default_home_dir" symbol="oobs_users_config_set_default_home_dir">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
					<parameter name="home_dir" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_default_shell" symbol="oobs_users_config_set_default_shell">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
					<parameter name="shell" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_maximum_users_uid" symbol="oobs_users_config_set_maximum_users_uid">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
					<parameter name="uid" type="uid_t"/>
				</parameters>
			</method>
			<method name="set_minimum_users_uid" symbol="oobs_users_config_set_minimum_users_uid">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="OobsUsersConfig*"/>
					<parameter name="uid" type="uid_t"/>
				</parameters>
			</method>
			<property name="default-group" type="OobsGroup*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="default-home" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="default-shell" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="encrypted-home" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="maximum-uid" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="minimum-uid" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
	</namespace>
</api>
