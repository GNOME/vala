<?xml version="1.0"?>
<api version="1.0">
	<namespace name="GNet">
		<function name="base64_decode" symbol="gnet_base64_decode">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="src" type="gchar*"/>
				<parameter name="srclen" type="gint"/>
				<parameter name="dstlenp" type="gint*"/>
			</parameters>
		</function>
		<function name="base64_encode" symbol="gnet_base64_encode">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="src" type="gchar*"/>
				<parameter name="srclen" type="gint"/>
				<parameter name="dstlenp" type="gint*"/>
				<parameter name="strict" type="gboolean"/>
			</parameters>
		</function>
		<function name="calcsize" symbol="gnet_calcsize">
			<return-type type="gint"/>
			<parameters>
				<parameter name="format" type="gchar*"/>
			</parameters>
		</function>
		<function name="conn_connect" symbol="gnet_conn_connect">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
			</parameters>
		</function>
		<function name="conn_delete" symbol="gnet_conn_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
			</parameters>
		</function>
		<function name="conn_disconnect" symbol="gnet_conn_disconnect">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
			</parameters>
		</function>
		<function name="conn_http_cancel" symbol="gnet_conn_http_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
			</parameters>
		</function>
		<function name="conn_http_delete" symbol="gnet_conn_http_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
			</parameters>
		</function>
		<function name="conn_http_new" symbol="gnet_conn_http_new">
			<return-type type="GConnHttp*"/>
		</function>
		<function name="conn_http_run" symbol="gnet_conn_http_run">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
				<parameter name="func" type="GConnHttpFunc"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="conn_http_run_async" symbol="gnet_conn_http_run_async">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
				<parameter name="func" type="GConnHttpFunc"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="conn_http_set_escaped_uri" symbol="gnet_conn_http_set_escaped_uri">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
				<parameter name="uri" type="gchar*"/>
			</parameters>
		</function>
		<function name="conn_http_set_header" symbol="gnet_conn_http_set_header">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
				<parameter name="field" type="gchar*"/>
				<parameter name="value" type="gchar*"/>
				<parameter name="flags" type="GConnHttpHeaderFlags"/>
			</parameters>
		</function>
		<function name="conn_http_set_main_context" symbol="gnet_conn_http_set_main_context">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
				<parameter name="context" type="GMainContext*"/>
			</parameters>
		</function>
		<function name="conn_http_set_max_redirects" symbol="gnet_conn_http_set_max_redirects">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
				<parameter name="num" type="guint"/>
			</parameters>
		</function>
		<function name="conn_http_set_method" symbol="gnet_conn_http_set_method">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
				<parameter name="method" type="GConnHttpMethod"/>
				<parameter name="post_data" type="gchar*"/>
				<parameter name="post_data_len" type="gsize"/>
			</parameters>
		</function>
		<function name="conn_http_set_timeout" symbol="gnet_conn_http_set_timeout">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
				<parameter name="timeout" type="guint"/>
			</parameters>
		</function>
		<function name="conn_http_set_uri" symbol="gnet_conn_http_set_uri">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
				<parameter name="uri" type="gchar*"/>
			</parameters>
		</function>
		<function name="conn_http_set_user_agent" symbol="gnet_conn_http_set_user_agent">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
				<parameter name="agent" type="gchar*"/>
			</parameters>
		</function>
		<function name="conn_http_steal_buffer" symbol="gnet_conn_http_steal_buffer">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
				<parameter name="buffer" type="gchar**"/>
				<parameter name="length" type="gsize*"/>
			</parameters>
		</function>
		<function name="conn_is_connected" symbol="gnet_conn_is_connected">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
			</parameters>
		</function>
		<function name="conn_new" symbol="gnet_conn_new">
			<return-type type="GConn*"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
				<parameter name="func" type="GConnFunc"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="conn_new_inetaddr" symbol="gnet_conn_new_inetaddr">
			<return-type type="GConn*"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
				<parameter name="func" type="GConnFunc"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="conn_new_socket" symbol="gnet_conn_new_socket">
			<return-type type="GConn*"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
				<parameter name="func" type="GConnFunc"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="conn_read" symbol="gnet_conn_read">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
			</parameters>
		</function>
		<function name="conn_readline" symbol="gnet_conn_readline">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
			</parameters>
		</function>
		<function name="conn_readn" symbol="gnet_conn_readn">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
				<parameter name="length" type="gint"/>
			</parameters>
		</function>
		<function name="conn_ref" symbol="gnet_conn_ref">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
			</parameters>
		</function>
		<function name="conn_set_callback" symbol="gnet_conn_set_callback">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
				<parameter name="func" type="GConnFunc"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="conn_set_main_context" symbol="gnet_conn_set_main_context">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
				<parameter name="context" type="GMainContext*"/>
			</parameters>
		</function>
		<function name="conn_set_watch_error" symbol="gnet_conn_set_watch_error">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
				<parameter name="enable" type="gboolean"/>
			</parameters>
		</function>
		<function name="conn_set_watch_readable" symbol="gnet_conn_set_watch_readable">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
				<parameter name="enable" type="gboolean"/>
			</parameters>
		</function>
		<function name="conn_set_watch_writable" symbol="gnet_conn_set_watch_writable">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
				<parameter name="enable" type="gboolean"/>
			</parameters>
		</function>
		<function name="conn_timeout" symbol="gnet_conn_timeout">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
				<parameter name="timeout" type="guint"/>
			</parameters>
		</function>
		<function name="conn_unref" symbol="gnet_conn_unref">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
			</parameters>
		</function>
		<function name="conn_write" symbol="gnet_conn_write">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="gint"/>
			</parameters>
		</function>
		<function name="conn_write_direct" symbol="gnet_conn_write_direct">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="gint"/>
				<parameter name="buffer_destroy_cb" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="http_get" symbol="gnet_http_get">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="url" type="gchar*"/>
				<parameter name="buffer" type="gchar**"/>
				<parameter name="length" type="gsize*"/>
				<parameter name="response" type="guint*"/>
			</parameters>
		</function>
		<function name="inetaddr_autodetect_internet_interface" symbol="gnet_inetaddr_autodetect_internet_interface">
			<return-type type="GInetAddr*"/>
		</function>
		<function name="inetaddr_clone" symbol="gnet_inetaddr_clone">
			<return-type type="GInetAddr*"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_delete" symbol="gnet_inetaddr_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_delete_list" symbol="gnet_inetaddr_delete_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GList*"/>
			</parameters>
		</function>
		<function name="inetaddr_equal" symbol="gnet_inetaddr_equal">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="p1" type="gconstpointer"/>
				<parameter name="p2" type="gconstpointer"/>
			</parameters>
		</function>
		<function name="inetaddr_get_bytes" symbol="gnet_inetaddr_get_bytes">
			<return-type type="void"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
				<parameter name="buffer" type="gchar*"/>
			</parameters>
		</function>
		<function name="inetaddr_get_canonical_name" symbol="gnet_inetaddr_get_canonical_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_get_host_addr" symbol="gnet_inetaddr_get_host_addr">
			<return-type type="GInetAddr*"/>
		</function>
		<function name="inetaddr_get_host_name" symbol="gnet_inetaddr_get_host_name">
			<return-type type="gchar*"/>
		</function>
		<function name="inetaddr_get_interface_to" symbol="gnet_inetaddr_get_interface_to">
			<return-type type="GInetAddr*"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_get_internet_interface" symbol="gnet_inetaddr_get_internet_interface">
			<return-type type="GInetAddr*"/>
		</function>
		<function name="inetaddr_get_length" symbol="gnet_inetaddr_get_length">
			<return-type type="gint"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_get_name" symbol="gnet_inetaddr_get_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_get_name_async" symbol="gnet_inetaddr_get_name_async">
			<return-type type="GInetAddrGetNameAsyncID"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
				<parameter name="func" type="GInetAddrGetNameAsyncFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="inetaddr_get_name_async_cancel" symbol="gnet_inetaddr_get_name_async_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="id" type="GInetAddrGetNameAsyncID"/>
			</parameters>
		</function>
		<function name="inetaddr_get_name_async_full" symbol="gnet_inetaddr_get_name_async_full">
			<return-type type="GInetAddrGetNameAsyncID"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
				<parameter name="func" type="GInetAddrGetNameAsyncFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
				<parameter name="context" type="GMainContext*"/>
				<parameter name="priority" type="gint"/>
			</parameters>
		</function>
		<function name="inetaddr_get_name_nonblock" symbol="gnet_inetaddr_get_name_nonblock">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_get_port" symbol="gnet_inetaddr_get_port">
			<return-type type="gint"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_hash" symbol="gnet_inetaddr_hash">
			<return-type type="guint"/>
			<parameters>
				<parameter name="p" type="gconstpointer"/>
			</parameters>
		</function>
		<function name="inetaddr_is_broadcast" symbol="gnet_inetaddr_is_broadcast">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_is_canonical" symbol="gnet_inetaddr_is_canonical">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
			</parameters>
		</function>
		<function name="inetaddr_is_internet" symbol="gnet_inetaddr_is_internet">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_is_internet_domainname" symbol="gnet_inetaddr_is_internet_domainname">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="inetaddr_is_ipv4" symbol="gnet_inetaddr_is_ipv4">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_is_ipv6" symbol="gnet_inetaddr_is_ipv6">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_is_loopback" symbol="gnet_inetaddr_is_loopback">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_is_multicast" symbol="gnet_inetaddr_is_multicast">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_is_private" symbol="gnet_inetaddr_is_private">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_is_reserved" symbol="gnet_inetaddr_is_reserved">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_list_interfaces" symbol="gnet_inetaddr_list_interfaces">
			<return-type type="GList*"/>
		</function>
		<function name="inetaddr_new" symbol="gnet_inetaddr_new">
			<return-type type="GInetAddr*"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
			</parameters>
		</function>
		<function name="inetaddr_new_async" symbol="gnet_inetaddr_new_async">
			<return-type type="GInetAddrNewAsyncID"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
				<parameter name="func" type="GInetAddrNewAsyncFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="inetaddr_new_async_cancel" symbol="gnet_inetaddr_new_async_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="id" type="GInetAddrNewAsyncID"/>
			</parameters>
		</function>
		<function name="inetaddr_new_async_full" symbol="gnet_inetaddr_new_async_full">
			<return-type type="GInetAddrNewAsyncID"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
				<parameter name="func" type="GInetAddrNewAsyncFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
				<parameter name="context" type="GMainContext*"/>
				<parameter name="priority" type="gint"/>
			</parameters>
		</function>
		<function name="inetaddr_new_bytes" symbol="gnet_inetaddr_new_bytes">
			<return-type type="GInetAddr*"/>
			<parameters>
				<parameter name="bytes" type="gchar*"/>
				<parameter name="length" type="guint"/>
			</parameters>
		</function>
		<function name="inetaddr_new_list" symbol="gnet_inetaddr_new_list">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
			</parameters>
		</function>
		<function name="inetaddr_new_list_async" symbol="gnet_inetaddr_new_list_async">
			<return-type type="GInetAddrNewListAsyncID"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
				<parameter name="func" type="GInetAddrNewListAsyncFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="inetaddr_new_list_async_cancel" symbol="gnet_inetaddr_new_list_async_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="id" type="GInetAddrNewListAsyncID"/>
			</parameters>
		</function>
		<function name="inetaddr_new_list_async_full" symbol="gnet_inetaddr_new_list_async_full">
			<return-type type="GInetAddrNewListAsyncID"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
				<parameter name="func" type="GInetAddrNewListAsyncFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
				<parameter name="context" type="GMainContext*"/>
				<parameter name="priority" type="gint"/>
			</parameters>
		</function>
		<function name="inetaddr_new_nonblock" symbol="gnet_inetaddr_new_nonblock">
			<return-type type="GInetAddr*"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
			</parameters>
		</function>
		<function name="inetaddr_noport_equal" symbol="gnet_inetaddr_noport_equal">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="p1" type="gconstpointer"/>
				<parameter name="p2" type="gconstpointer"/>
			</parameters>
		</function>
		<function name="inetaddr_ref" symbol="gnet_inetaddr_ref">
			<return-type type="void"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="inetaddr_set_bytes" symbol="gnet_inetaddr_set_bytes">
			<return-type type="void"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
				<parameter name="bytes" type="gchar*"/>
				<parameter name="length" type="gint"/>
			</parameters>
		</function>
		<function name="inetaddr_set_port" symbol="gnet_inetaddr_set_port">
			<return-type type="void"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
				<parameter name="port" type="gint"/>
			</parameters>
		</function>
		<function name="inetaddr_unref" symbol="gnet_inetaddr_unref">
			<return-type type="void"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="init" symbol="gnet_init">
			<return-type type="void"/>
		</function>
		<function name="io_channel_readline" symbol="gnet_io_channel_readline">
			<return-type type="GIOError"/>
			<parameters>
				<parameter name="channel" type="GIOChannel*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="gsize"/>
				<parameter name="bytes_readp" type="gsize*"/>
			</parameters>
		</function>
		<function name="io_channel_readline_strdup" symbol="gnet_io_channel_readline_strdup">
			<return-type type="GIOError"/>
			<parameters>
				<parameter name="channel" type="GIOChannel*"/>
				<parameter name="bufferp" type="gchar**"/>
				<parameter name="bytes_readp" type="gsize*"/>
			</parameters>
		</function>
		<function name="io_channel_readn" symbol="gnet_io_channel_readn">
			<return-type type="GIOError"/>
			<parameters>
				<parameter name="channel" type="GIOChannel*"/>
				<parameter name="buffer" type="gpointer"/>
				<parameter name="length" type="gsize"/>
				<parameter name="bytes_readp" type="gsize*"/>
			</parameters>
		</function>
		<function name="io_channel_writen" symbol="gnet_io_channel_writen">
			<return-type type="GIOError"/>
			<parameters>
				<parameter name="channel" type="GIOChannel*"/>
				<parameter name="buffer" type="gpointer"/>
				<parameter name="length" type="gsize"/>
				<parameter name="bytes_writtenp" type="gsize*"/>
			</parameters>
		</function>
		<function name="ipv6_get_policy" symbol="gnet_ipv6_get_policy">
			<return-type type="GIPv6Policy"/>
		</function>
		<function name="ipv6_set_policy" symbol="gnet_ipv6_set_policy">
			<return-type type="void"/>
			<parameters>
				<parameter name="policy" type="GIPv6Policy"/>
			</parameters>
		</function>
		<function name="mcast_socket_delete" symbol="gnet_mcast_socket_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
			</parameters>
		</function>
		<function name="mcast_socket_get_io_channel" symbol="gnet_mcast_socket_get_io_channel">
			<return-type type="GIOChannel*"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
			</parameters>
		</function>
		<function name="mcast_socket_get_local_inetaddr" symbol="gnet_mcast_socket_get_local_inetaddr">
			<return-type type="GInetAddr*"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
			</parameters>
		</function>
		<function name="mcast_socket_get_ttl" symbol="gnet_mcast_socket_get_ttl">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
			</parameters>
		</function>
		<function name="mcast_socket_has_packet" symbol="gnet_mcast_socket_has_packet">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
			</parameters>
		</function>
		<function name="mcast_socket_is_loopback" symbol="gnet_mcast_socket_is_loopback">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
			</parameters>
		</function>
		<function name="mcast_socket_join_group" symbol="gnet_mcast_socket_join_group">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="mcast_socket_leave_group" symbol="gnet_mcast_socket_leave_group">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
				<parameter name="inetaddr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="mcast_socket_new" symbol="gnet_mcast_socket_new">
			<return-type type="GMcastSocket*"/>
		</function>
		<function name="mcast_socket_new_full" symbol="gnet_mcast_socket_new_full">
			<return-type type="GMcastSocket*"/>
			<parameters>
				<parameter name="iface" type="GInetAddr*"/>
				<parameter name="port" type="gint"/>
			</parameters>
		</function>
		<function name="mcast_socket_new_with_port" symbol="gnet_mcast_socket_new_with_port">
			<return-type type="GMcastSocket*"/>
			<parameters>
				<parameter name="port" type="gint"/>
			</parameters>
		</function>
		<function name="mcast_socket_receive" symbol="gnet_mcast_socket_receive">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="gint"/>
				<parameter name="src" type="GInetAddr**"/>
			</parameters>
		</function>
		<function name="mcast_socket_ref" symbol="gnet_mcast_socket_ref">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
			</parameters>
		</function>
		<function name="mcast_socket_send" symbol="gnet_mcast_socket_send">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="gint"/>
				<parameter name="dst" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="mcast_socket_set_loopback" symbol="gnet_mcast_socket_set_loopback">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
				<parameter name="enable" type="gboolean"/>
			</parameters>
		</function>
		<function name="mcast_socket_set_ttl" symbol="gnet_mcast_socket_set_ttl">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
				<parameter name="ttl" type="gint"/>
			</parameters>
		</function>
		<function name="mcast_socket_unref" symbol="gnet_mcast_socket_unref">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GMcastSocket*"/>
			</parameters>
		</function>
		<function name="md5_clone" symbol="gnet_md5_clone">
			<return-type type="GMD5*"/>
			<parameters>
				<parameter name="md5" type="GMD5*"/>
			</parameters>
		</function>
		<function name="md5_copy_string" symbol="gnet_md5_copy_string">
			<return-type type="void"/>
			<parameters>
				<parameter name="md5" type="GMD5*"/>
				<parameter name="buffer" type="gchar*"/>
			</parameters>
		</function>
		<function name="md5_delete" symbol="gnet_md5_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="md5" type="GMD5*"/>
			</parameters>
		</function>
		<function name="md5_equal" symbol="gnet_md5_equal">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="p1" type="gconstpointer"/>
				<parameter name="p2" type="gconstpointer"/>
			</parameters>
		</function>
		<function name="md5_final" symbol="gnet_md5_final">
			<return-type type="void"/>
			<parameters>
				<parameter name="md5" type="GMD5*"/>
			</parameters>
		</function>
		<function name="md5_get_digest" symbol="gnet_md5_get_digest">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="md5" type="GMD5*"/>
			</parameters>
		</function>
		<function name="md5_get_string" symbol="gnet_md5_get_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="md5" type="GMD5*"/>
			</parameters>
		</function>
		<function name="md5_hash" symbol="gnet_md5_hash">
			<return-type type="guint"/>
			<parameters>
				<parameter name="p" type="gconstpointer"/>
			</parameters>
		</function>
		<function name="md5_new" symbol="gnet_md5_new">
			<return-type type="GMD5*"/>
			<parameters>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="guint"/>
			</parameters>
		</function>
		<function name="md5_new_incremental" symbol="gnet_md5_new_incremental">
			<return-type type="GMD5*"/>
		</function>
		<function name="md5_new_string" symbol="gnet_md5_new_string">
			<return-type type="GMD5*"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="md5_update" symbol="gnet_md5_update">
			<return-type type="void"/>
			<parameters>
				<parameter name="md5" type="GMD5*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="guint"/>
			</parameters>
		</function>
		<function name="pack" symbol="gnet_pack">
			<return-type type="gint"/>
			<parameters>
				<parameter name="format" type="gchar*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="gint"/>
			</parameters>
		</function>
		<function name="pack_strdup" symbol="gnet_pack_strdup">
			<return-type type="gint"/>
			<parameters>
				<parameter name="format" type="gchar*"/>
				<parameter name="bufferp" type="gchar**"/>
			</parameters>
		</function>
		<function name="server_delete" symbol="gnet_server_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="server" type="GServer*"/>
			</parameters>
		</function>
		<function name="server_new" symbol="gnet_server_new">
			<return-type type="GServer*"/>
			<parameters>
				<parameter name="iface" type="GInetAddr*"/>
				<parameter name="port" type="gint"/>
				<parameter name="func" type="GServerFunc"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="server_ref" symbol="gnet_server_ref">
			<return-type type="void"/>
			<parameters>
				<parameter name="server" type="GServer*"/>
			</parameters>
		</function>
		<function name="server_unref" symbol="gnet_server_unref">
			<return-type type="void"/>
			<parameters>
				<parameter name="server" type="GServer*"/>
			</parameters>
		</function>
		<function name="sha_clone" symbol="gnet_sha_clone">
			<return-type type="GSHA*"/>
			<parameters>
				<parameter name="sha" type="GSHA*"/>
			</parameters>
		</function>
		<function name="sha_copy_string" symbol="gnet_sha_copy_string">
			<return-type type="void"/>
			<parameters>
				<parameter name="sha" type="GSHA*"/>
				<parameter name="buffer" type="gchar*"/>
			</parameters>
		</function>
		<function name="sha_delete" symbol="gnet_sha_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="sha" type="GSHA*"/>
			</parameters>
		</function>
		<function name="sha_equal" symbol="gnet_sha_equal">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="p1" type="gconstpointer"/>
				<parameter name="p2" type="gconstpointer"/>
			</parameters>
		</function>
		<function name="sha_final" symbol="gnet_sha_final">
			<return-type type="void"/>
			<parameters>
				<parameter name="sha" type="GSHA*"/>
			</parameters>
		</function>
		<function name="sha_get_digest" symbol="gnet_sha_get_digest">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="sha" type="GSHA*"/>
			</parameters>
		</function>
		<function name="sha_get_string" symbol="gnet_sha_get_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="sha" type="GSHA*"/>
			</parameters>
		</function>
		<function name="sha_hash" symbol="gnet_sha_hash">
			<return-type type="guint"/>
			<parameters>
				<parameter name="p" type="gconstpointer"/>
			</parameters>
		</function>
		<function name="sha_new" symbol="gnet_sha_new">
			<return-type type="GSHA*"/>
			<parameters>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="guint"/>
			</parameters>
		</function>
		<function name="sha_new_incremental" symbol="gnet_sha_new_incremental">
			<return-type type="GSHA*"/>
		</function>
		<function name="sha_new_string" symbol="gnet_sha_new_string">
			<return-type type="GSHA*"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="sha_update" symbol="gnet_sha_update">
			<return-type type="void"/>
			<parameters>
				<parameter name="sha" type="GSHA*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="guint"/>
			</parameters>
		</function>
		<function name="tcp_socket_connect" symbol="gnet_tcp_socket_connect">
			<return-type type="GTcpSocket*"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
			</parameters>
		</function>
		<function name="tcp_socket_connect_async" symbol="gnet_tcp_socket_connect_async">
			<return-type type="GTcpSocketConnectAsyncID"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
				<parameter name="func" type="GTcpSocketConnectAsyncFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="tcp_socket_connect_async_cancel" symbol="gnet_tcp_socket_connect_async_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="id" type="GTcpSocketConnectAsyncID"/>
			</parameters>
		</function>
		<function name="tcp_socket_connect_async_full" symbol="gnet_tcp_socket_connect_async_full">
			<return-type type="GTcpSocketConnectAsyncID"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
				<parameter name="func" type="GTcpSocketConnectAsyncFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
				<parameter name="context" type="GMainContext*"/>
				<parameter name="priority" type="gint"/>
			</parameters>
		</function>
		<function name="tcp_socket_delete" symbol="gnet_tcp_socket_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
			</parameters>
		</function>
		<function name="tcp_socket_get_io_channel" symbol="gnet_tcp_socket_get_io_channel">
			<return-type type="GIOChannel*"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
			</parameters>
		</function>
		<function name="tcp_socket_get_local_inetaddr" symbol="gnet_tcp_socket_get_local_inetaddr">
			<return-type type="GInetAddr*"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
			</parameters>
		</function>
		<function name="tcp_socket_get_port" symbol="gnet_tcp_socket_get_port">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
			</parameters>
		</function>
		<function name="tcp_socket_get_remote_inetaddr" symbol="gnet_tcp_socket_get_remote_inetaddr">
			<return-type type="GInetAddr*"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
			</parameters>
		</function>
		<function name="tcp_socket_new" symbol="gnet_tcp_socket_new">
			<return-type type="GTcpSocket*"/>
			<parameters>
				<parameter name="addr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="tcp_socket_new_async" symbol="gnet_tcp_socket_new_async">
			<return-type type="GTcpSocketNewAsyncID"/>
			<parameters>
				<parameter name="addr" type="GInetAddr*"/>
				<parameter name="func" type="GTcpSocketNewAsyncFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="tcp_socket_new_async_cancel" symbol="gnet_tcp_socket_new_async_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="id" type="GTcpSocketNewAsyncID"/>
			</parameters>
		</function>
		<function name="tcp_socket_new_async_direct" symbol="gnet_tcp_socket_new_async_direct">
			<return-type type="GTcpSocketNewAsyncID"/>
			<parameters>
				<parameter name="addr" type="GInetAddr*"/>
				<parameter name="func" type="GTcpSocketNewAsyncFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="tcp_socket_new_async_direct_full" symbol="gnet_tcp_socket_new_async_direct_full">
			<return-type type="GTcpSocketNewAsyncID"/>
			<parameters>
				<parameter name="addr" type="GInetAddr*"/>
				<parameter name="func" type="GTcpSocketNewAsyncFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
				<parameter name="context" type="GMainContext*"/>
				<parameter name="priority" type="gint"/>
			</parameters>
		</function>
		<function name="tcp_socket_new_async_full" symbol="gnet_tcp_socket_new_async_full">
			<return-type type="GTcpSocketNewAsyncID"/>
			<parameters>
				<parameter name="addr" type="GInetAddr*"/>
				<parameter name="func" type="GTcpSocketNewAsyncFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
				<parameter name="context" type="GMainContext*"/>
				<parameter name="priority" type="gint"/>
			</parameters>
		</function>
		<function name="tcp_socket_new_direct" symbol="gnet_tcp_socket_new_direct">
			<return-type type="GTcpSocket*"/>
			<parameters>
				<parameter name="addr" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="tcp_socket_ref" symbol="gnet_tcp_socket_ref">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
			</parameters>
		</function>
		<function name="tcp_socket_server_accept" symbol="gnet_tcp_socket_server_accept">
			<return-type type="GTcpSocket*"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
			</parameters>
		</function>
		<function name="tcp_socket_server_accept_async" symbol="gnet_tcp_socket_server_accept_async">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
				<parameter name="accept_func" type="GTcpSocketAcceptFunc"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="tcp_socket_server_accept_async_cancel" symbol="gnet_tcp_socket_server_accept_async_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
			</parameters>
		</function>
		<function name="tcp_socket_server_accept_nonblock" symbol="gnet_tcp_socket_server_accept_nonblock">
			<return-type type="GTcpSocket*"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
			</parameters>
		</function>
		<function name="tcp_socket_server_new" symbol="gnet_tcp_socket_server_new">
			<return-type type="GTcpSocket*"/>
		</function>
		<function name="tcp_socket_server_new_full" symbol="gnet_tcp_socket_server_new_full">
			<return-type type="GTcpSocket*"/>
			<parameters>
				<parameter name="iface" type="GInetAddr*"/>
				<parameter name="port" type="gint"/>
			</parameters>
		</function>
		<function name="tcp_socket_server_new_with_port" symbol="gnet_tcp_socket_server_new_with_port">
			<return-type type="GTcpSocket*"/>
			<parameters>
				<parameter name="port" type="gint"/>
			</parameters>
		</function>
		<function name="tcp_socket_set_tos" symbol="gnet_tcp_socket_set_tos">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
				<parameter name="tos" type="GNetTOS"/>
			</parameters>
		</function>
		<function name="tcp_socket_unref" symbol="gnet_tcp_socket_unref">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
			</parameters>
		</function>
		<function name="udp_socket_delete" symbol="gnet_udp_socket_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GUdpSocket*"/>
			</parameters>
		</function>
		<function name="udp_socket_get_io_channel" symbol="gnet_udp_socket_get_io_channel">
			<return-type type="GIOChannel*"/>
			<parameters>
				<parameter name="socket" type="GUdpSocket*"/>
			</parameters>
		</function>
		<function name="udp_socket_get_local_inetaddr" symbol="gnet_udp_socket_get_local_inetaddr">
			<return-type type="GInetAddr*"/>
			<parameters>
				<parameter name="socket" type="GUdpSocket*"/>
			</parameters>
		</function>
		<function name="udp_socket_get_ttl" symbol="gnet_udp_socket_get_ttl">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GUdpSocket*"/>
			</parameters>
		</function>
		<function name="udp_socket_has_packet" symbol="gnet_udp_socket_has_packet">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="socket" type="GUdpSocket*"/>
			</parameters>
		</function>
		<function name="udp_socket_new" symbol="gnet_udp_socket_new">
			<return-type type="GUdpSocket*"/>
		</function>
		<function name="udp_socket_new_full" symbol="gnet_udp_socket_new_full">
			<return-type type="GUdpSocket*"/>
			<parameters>
				<parameter name="iface" type="GInetAddr*"/>
				<parameter name="port" type="gint"/>
			</parameters>
		</function>
		<function name="udp_socket_new_with_port" symbol="gnet_udp_socket_new_with_port">
			<return-type type="GUdpSocket*"/>
			<parameters>
				<parameter name="port" type="gint"/>
			</parameters>
		</function>
		<function name="udp_socket_receive" symbol="gnet_udp_socket_receive">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GUdpSocket*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="gint"/>
				<parameter name="src" type="GInetAddr**"/>
			</parameters>
		</function>
		<function name="udp_socket_ref" symbol="gnet_udp_socket_ref">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GUdpSocket*"/>
			</parameters>
		</function>
		<function name="udp_socket_send" symbol="gnet_udp_socket_send">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GUdpSocket*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="gint"/>
				<parameter name="dst" type="GInetAddr*"/>
			</parameters>
		</function>
		<function name="udp_socket_set_ttl" symbol="gnet_udp_socket_set_ttl">
			<return-type type="gint"/>
			<parameters>
				<parameter name="socket" type="GUdpSocket*"/>
				<parameter name="ttl" type="gint"/>
			</parameters>
		</function>
		<function name="udp_socket_unref" symbol="gnet_udp_socket_unref">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GUdpSocket*"/>
			</parameters>
		</function>
		<function name="unix_socket_delete" symbol="gnet_unix_socket_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GUnixSocket*"/>
			</parameters>
		</function>
		<function name="unix_socket_get_io_channel" symbol="gnet_unix_socket_get_io_channel">
			<return-type type="GIOChannel*"/>
			<parameters>
				<parameter name="socket" type="GUnixSocket*"/>
			</parameters>
		</function>
		<function name="unix_socket_get_path" symbol="gnet_unix_socket_get_path">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="socket" type="GUnixSocket*"/>
			</parameters>
		</function>
		<function name="unix_socket_new" symbol="gnet_unix_socket_new">
			<return-type type="GUnixSocket*"/>
			<parameters>
				<parameter name="path" type="gchar*"/>
			</parameters>
		</function>
		<function name="unix_socket_new_abstract" symbol="gnet_unix_socket_new_abstract">
			<return-type type="GUnixSocket*"/>
			<parameters>
				<parameter name="path" type="gchar*"/>
			</parameters>
		</function>
		<function name="unix_socket_ref" symbol="gnet_unix_socket_ref">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GUnixSocket*"/>
			</parameters>
		</function>
		<function name="unix_socket_server_accept" symbol="gnet_unix_socket_server_accept">
			<return-type type="GUnixSocket*"/>
			<parameters>
				<parameter name="socket" type="GUnixSocket*"/>
			</parameters>
		</function>
		<function name="unix_socket_server_accept_nonblock" symbol="gnet_unix_socket_server_accept_nonblock">
			<return-type type="GUnixSocket*"/>
			<parameters>
				<parameter name="socket" type="GUnixSocket*"/>
			</parameters>
		</function>
		<function name="unix_socket_server_new" symbol="gnet_unix_socket_server_new">
			<return-type type="GUnixSocket*"/>
			<parameters>
				<parameter name="path" type="gchar*"/>
			</parameters>
		</function>
		<function name="unix_socket_server_new_abstract" symbol="gnet_unix_socket_server_new_abstract">
			<return-type type="GUnixSocket*"/>
			<parameters>
				<parameter name="path" type="gchar*"/>
			</parameters>
		</function>
		<function name="unix_socket_unref" symbol="gnet_unix_socket_unref">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GUnixSocket*"/>
			</parameters>
		</function>
		<function name="unpack" symbol="gnet_unpack">
			<return-type type="gint"/>
			<parameters>
				<parameter name="format" type="gchar*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="gint"/>
			</parameters>
		</function>
		<function name="uri_clone" symbol="gnet_uri_clone">
			<return-type type="GURI*"/>
			<parameters>
				<parameter name="uri" type="GURI*"/>
			</parameters>
		</function>
		<function name="uri_delete" symbol="gnet_uri_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="GURI*"/>
			</parameters>
		</function>
		<function name="uri_equal" symbol="gnet_uri_equal">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="p1" type="gconstpointer"/>
				<parameter name="p2" type="gconstpointer"/>
			</parameters>
		</function>
		<function name="uri_escape" symbol="gnet_uri_escape">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="GURI*"/>
			</parameters>
		</function>
		<function name="uri_get_string" symbol="gnet_uri_get_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="uri" type="GURI*"/>
			</parameters>
		</function>
		<function name="uri_hash" symbol="gnet_uri_hash">
			<return-type type="guint"/>
			<parameters>
				<parameter name="p" type="gconstpointer"/>
			</parameters>
		</function>
		<function name="uri_new" symbol="gnet_uri_new">
			<return-type type="GURI*"/>
			<parameters>
				<parameter name="uri" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_new_fields" symbol="gnet_uri_new_fields">
			<return-type type="GURI*"/>
			<parameters>
				<parameter name="scheme" type="gchar*"/>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
				<parameter name="path" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_new_fields_all" symbol="gnet_uri_new_fields_all">
			<return-type type="GURI*"/>
			<parameters>
				<parameter name="scheme" type="gchar*"/>
				<parameter name="userinfo" type="gchar*"/>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="gint"/>
				<parameter name="path" type="gchar*"/>
				<parameter name="query" type="gchar*"/>
				<parameter name="fragment" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_parse_inplace" symbol="gnet_uri_parse_inplace">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="guri" type="GURI*"/>
				<parameter name="uri" type="gchar*"/>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="len" type="gsize"/>
			</parameters>
		</function>
		<function name="uri_set_fragment" symbol="gnet_uri_set_fragment">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="GURI*"/>
				<parameter name="fragment" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_set_hostname" symbol="gnet_uri_set_hostname">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="GURI*"/>
				<parameter name="hostname" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_set_path" symbol="gnet_uri_set_path">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="GURI*"/>
				<parameter name="path" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_set_port" symbol="gnet_uri_set_port">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="GURI*"/>
				<parameter name="port" type="gint"/>
			</parameters>
		</function>
		<function name="uri_set_query" symbol="gnet_uri_set_query">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="GURI*"/>
				<parameter name="query" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_set_scheme" symbol="gnet_uri_set_scheme">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="GURI*"/>
				<parameter name="scheme" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_set_userinfo" symbol="gnet_uri_set_userinfo">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="GURI*"/>
				<parameter name="userinfo" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_unescape" symbol="gnet_uri_unescape">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="GURI*"/>
			</parameters>
		</function>
		<function name="vcalcsize" symbol="gnet_vcalcsize">
			<return-type type="gint"/>
			<parameters>
				<parameter name="format" type="gchar*"/>
				<parameter name="args" type="va_list"/>
			</parameters>
		</function>
		<function name="vpack" symbol="gnet_vpack">
			<return-type type="gint"/>
			<parameters>
				<parameter name="format" type="gchar*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="gint"/>
				<parameter name="args" type="va_list"/>
			</parameters>
		</function>
		<function name="vunpack" symbol="gnet_vunpack">
			<return-type type="gint"/>
			<parameters>
				<parameter name="format" type="gchar*"/>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="length" type="gint"/>
				<parameter name="args" type="va_list"/>
			</parameters>
		</function>
		<callback name="GConnFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConn*"/>
				<parameter name="event" type="GConnEvent*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GConnHttpFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="GConnHttp*"/>
				<parameter name="event" type="GConnHttpEvent*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GInetAddrGetNameAsyncFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GInetAddrNewAsyncFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="inetaddr" type="GInetAddr*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GInetAddrNewListAsyncFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GList*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GServerFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="server" type="GServer*"/>
				<parameter name="conn" type="GConn*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GTcpSocketAcceptFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="server" type="GTcpSocket*"/>
				<parameter name="client" type="GTcpSocket*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GTcpSocketConnectAsyncFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
				<parameter name="status" type="GTcpSocketConnectAsyncStatus"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GTcpSocketNewAsyncFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="socket" type="GTcpSocket*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GConn">
			<field name="hostname" type="gchar*"/>
			<field name="port" type="gint"/>
			<field name="iochannel" type="GIOChannel*"/>
			<field name="socket" type="GTcpSocket*"/>
			<field name="inetaddr" type="GInetAddr*"/>
			<field name="ref_count" type="guint"/>
			<field name="ref_count_internal" type="guint"/>
			<field name="connect_id" type="GTcpSocketConnectAsyncID"/>
			<field name="new_id" type="GTcpSocketNewAsyncID"/>
			<field name="write_queue" type="GList*"/>
			<field name="bytes_written" type="guint"/>
			<field name="buffer" type="gchar*"/>
			<field name="length" type="guint"/>
			<field name="bytes_read" type="guint"/>
			<field name="read_eof" type="gboolean"/>
			<field name="read_queue" type="GList*"/>
			<field name="process_buffer_timeout" type="guint"/>
			<field name="watch_readable" type="gboolean"/>
			<field name="watch_writable" type="gboolean"/>
			<field name="watch_flags" type="guint"/>
			<field name="watch" type="guint"/>
			<field name="timer" type="guint"/>
			<field name="func" type="GConnFunc"/>
			<field name="user_data" type="gpointer"/>
			<field name="context" type="GMainContext*"/>
			<field name="priority" type="gint"/>
		</struct>
		<struct name="GConnEvent">
			<field name="type" type="GConnEventType"/>
			<field name="buffer" type="gchar*"/>
			<field name="length" type="gint"/>
		</struct>
		<struct name="GConnHttp">
		</struct>
		<struct name="GConnHttpEvent">
			<field name="type" type="GConnHttpEventType"/>
			<field name="stsize" type="gsize"/>
			<field name="padding" type="gpointer[]"/>
		</struct>
		<struct name="GConnHttpEventData">
			<field name="parent" type="GConnHttpEvent"/>
			<field name="content_length" type="guint64"/>
			<field name="data_received" type="guint64"/>
			<field name="buffer" type="gchar*"/>
			<field name="buffer_length" type="gsize"/>
			<field name="padding" type="gpointer[]"/>
		</struct>
		<struct name="GConnHttpEventError">
			<field name="parent" type="GConnHttpEvent"/>
			<field name="code" type="GConnHttpError"/>
			<field name="message" type="gchar*"/>
			<field name="padding" type="gpointer[]"/>
		</struct>
		<struct name="GConnHttpEventRedirect">
			<field name="parent" type="GConnHttpEvent"/>
			<field name="num_redirects" type="guint"/>
			<field name="max_redirects" type="guint"/>
			<field name="new_location" type="gchar*"/>
			<field name="auto_redirect" type="gboolean"/>
			<field name="padding" type="gpointer[]"/>
		</struct>
		<struct name="GConnHttpEventResolved">
			<field name="parent" type="GConnHttpEvent"/>
			<field name="ia" type="GInetAddr*"/>
			<field name="padding" type="gpointer[]"/>
		</struct>
		<struct name="GConnHttpEventResponse">
			<field name="parent" type="GConnHttpEvent"/>
			<field name="response_code" type="guint"/>
			<field name="header_fields" type="gchar**"/>
			<field name="header_values" type="gchar**"/>
			<field name="padding" type="gpointer[]"/>
		</struct>
		<struct name="GInetAddr">
		</struct>
		<struct name="GInetAddrGetNameAsyncID">
		</struct>
		<struct name="GInetAddrNewAsyncID">
		</struct>
		<struct name="GInetAddrNewListAsyncID">
		</struct>
		<struct name="GMD5">
		</struct>
		<struct name="GMcastSocket">
		</struct>
		<struct name="GSHA">
		</struct>
		<struct name="GServer">
			<field name="iface" type="GInetAddr*"/>
			<field name="port" type="gint"/>
			<field name="socket" type="GTcpSocket*"/>
			<field name="ref_count" type="guint"/>
			<field name="func" type="GServerFunc"/>
			<field name="user_data" type="gpointer"/>
		</struct>
		<struct name="GTcpSocket">
		</struct>
		<struct name="GTcpSocketConnectAsyncID">
		</struct>
		<struct name="GTcpSocketNewAsyncID">
		</struct>
		<struct name="GURI">
			<field name="scheme" type="gchar*"/>
			<field name="userinfo" type="gchar*"/>
			<field name="hostname" type="gchar*"/>
			<field name="port" type="gint"/>
			<field name="path" type="gchar*"/>
			<field name="query" type="gchar*"/>
			<field name="fragment" type="gchar*"/>
		</struct>
		<struct name="GUdpSocket">
		</struct>
		<struct name="GUnixSocket">
		</struct>
		<enum name="GConnEventType">
			<member name="GNET_CONN_ERROR" value="0"/>
			<member name="GNET_CONN_CONNECT" value="1"/>
			<member name="GNET_CONN_CLOSE" value="2"/>
			<member name="GNET_CONN_TIMEOUT" value="3"/>
			<member name="GNET_CONN_READ" value="4"/>
			<member name="GNET_CONN_WRITE" value="5"/>
			<member name="GNET_CONN_READABLE" value="6"/>
			<member name="GNET_CONN_WRITABLE" value="7"/>
		</enum>
		<enum name="GConnHttpError">
			<member name="GNET_CONN_HTTP_ERROR_UNSPECIFIED" value="0"/>
			<member name="GNET_CONN_HTTP_ERROR_PROTOCOL_UNSUPPORTED" value="1"/>
			<member name="GNET_CONN_HTTP_ERROR_HOSTNAME_RESOLUTION" value="2"/>
		</enum>
		<enum name="GConnHttpEventType">
			<member name="GNET_CONN_HTTP_RESOLVED" value="0"/>
			<member name="GNET_CONN_HTTP_CONNECTED" value="1"/>
			<member name="GNET_CONN_HTTP_RESPONSE" value="2"/>
			<member name="GNET_CONN_HTTP_REDIRECT" value="3"/>
			<member name="GNET_CONN_HTTP_DATA_PARTIAL" value="4"/>
			<member name="GNET_CONN_HTTP_DATA_COMPLETE" value="5"/>
			<member name="GNET_CONN_HTTP_TIMEOUT" value="6"/>
			<member name="GNET_CONN_HTTP_ERROR" value="7"/>
		</enum>
		<enum name="GConnHttpHeaderFlags">
			<member name="GNET_CONN_HTTP_FLAG_SKIP_HEADER_CHECK" value="1"/>
		</enum>
		<enum name="GConnHttpMethod">
			<member name="GNET_CONN_HTTP_METHOD_GET" value="0"/>
			<member name="GNET_CONN_HTTP_METHOD_POST" value="1"/>
		</enum>
		<enum name="GIPv6Policy">
			<member name="GIPV6_POLICY_IPV4_THEN_IPV6" value="0"/>
			<member name="GIPV6_POLICY_IPV6_THEN_IPV4" value="1"/>
			<member name="GIPV6_POLICY_IPV4_ONLY" value="2"/>
			<member name="GIPV6_POLICY_IPV6_ONLY" value="3"/>
		</enum>
		<enum name="GNetTOS">
			<member name="GNET_TOS_NONE" value="0"/>
			<member name="GNET_TOS_LOWDELAY" value="1"/>
			<member name="GNET_TOS_THROUGHPUT" value="2"/>
			<member name="GNET_TOS_RELIABILITY" value="3"/>
			<member name="GNET_TOS_LOWCOST" value="4"/>
		</enum>
		<enum name="GTcpSocketConnectAsyncStatus">
			<member name="GTCP_SOCKET_CONNECT_ASYNC_STATUS_OK" value="0"/>
			<member name="GTCP_SOCKET_CONNECT_ASYNC_STATUS_INETADDR_ERROR" value="1"/>
			<member name="GTCP_SOCKET_CONNECT_ASYNC_STATUS_TCP_ERROR" value="2"/>
		</enum>
		<constant name="GNET_INETADDR_MAX_LEN" type="int" value="16"/>
		<constant name="GNET_MD5_HASH_LENGTH" type="int" value="16"/>
		<constant name="GNET_SHA_HASH_LENGTH" type="int" value="20"/>
		<constant name="GNET_SOCKS_PORT" type="int" value="1080"/>
		<constant name="GNET_SOCKS_VERSION" type="int" value="5"/>
	</namespace>
</api>
