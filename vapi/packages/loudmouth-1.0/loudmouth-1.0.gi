<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Lm">
		<function name="error_quark" symbol="lm_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="utils_get_localtime" symbol="lm_utils_get_localtime">
			<return-type type="struct tm*"/>
			<parameters>
				<parameter name="stamp" type="gchar*"/>
			</parameters>
		</function>
		<callback name="LmDisconnectFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="connection" type="LmConnection*"/>
				<parameter name="reason" type="LmDisconnectReason"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="LmHandleMessageFunction">
			<return-type type="LmHandlerResult"/>
			<parameters>
				<parameter name="handler" type="LmMessageHandler*"/>
				<parameter name="connection" type="LmConnection*"/>
				<parameter name="message" type="LmMessage*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="LmResultFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="connection" type="LmConnection*"/>
				<parameter name="success" type="gboolean"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="LmSSLFunction">
			<return-type type="LmSSLResponse"/>
			<parameters>
				<parameter name="ssl" type="LmSSL*"/>
				<parameter name="status" type="LmSSLStatus"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="LmConnection">
			<method name="authenticate" symbol="lm_connection_authenticate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="username" type="gchar*"/>
					<parameter name="password" type="gchar*"/>
					<parameter name="resource" type="gchar*"/>
					<parameter name="function" type="LmResultFunction"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="authenticate_and_block" symbol="lm_connection_authenticate_and_block">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="username" type="gchar*"/>
					<parameter name="password" type="gchar*"/>
					<parameter name="resource" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="cancel_open" symbol="lm_connection_cancel_open">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="close" symbol="lm_connection_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_full_jid" symbol="lm_connection_get_full_jid">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="get_jid" symbol="lm_connection_get_jid">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="get_keep_alive_rate" symbol="lm_connection_get_keep_alive_rate">
				<return-type type="guint"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="get_local_host" symbol="lm_connection_get_local_host">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="lm_connection_get_port">
				<return-type type="guint"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="get_proxy" symbol="lm_connection_get_proxy">
				<return-type type="LmProxy*"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="get_server" symbol="lm_connection_get_server">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="get_ssl" symbol="lm_connection_get_ssl">
				<return-type type="LmSSL*"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="lm_connection_get_state">
				<return-type type="LmConnectionState"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="is_authenticated" symbol="lm_connection_is_authenticated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="is_open" symbol="lm_connection_is_open">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="new" symbol="lm_connection_new">
				<return-type type="LmConnection*"/>
				<parameters>
					<parameter name="server" type="gchar*"/>
				</parameters>
			</method>
			<method name="new_with_context" symbol="lm_connection_new_with_context">
				<return-type type="LmConnection*"/>
				<parameters>
					<parameter name="server" type="gchar*"/>
					<parameter name="context" type="GMainContext*"/>
				</parameters>
			</method>
			<method name="open" symbol="lm_connection_open">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="function" type="LmResultFunction"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="open_and_block" symbol="lm_connection_open_and_block">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="ref" symbol="lm_connection_ref">
				<return-type type="LmConnection*"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="register_message_handler" symbol="lm_connection_register_message_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="handler" type="LmMessageHandler*"/>
					<parameter name="type" type="LmMessageType"/>
					<parameter name="priority" type="LmHandlerPriority"/>
				</parameters>
			</method>
			<method name="send" symbol="lm_connection_send">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="message" type="LmMessage*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="send_raw" symbol="lm_connection_send_raw">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="str" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="send_with_reply" symbol="lm_connection_send_with_reply">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="message" type="LmMessage*"/>
					<parameter name="handler" type="LmMessageHandler*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="send_with_reply_and_block" symbol="lm_connection_send_with_reply_and_block">
				<return-type type="LmMessage*"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="message" type="LmMessage*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_disconnect_function" symbol="lm_connection_set_disconnect_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="function" type="LmDisconnectFunction"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_jid" symbol="lm_connection_set_jid">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="jid" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_keep_alive_rate" symbol="lm_connection_set_keep_alive_rate">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="rate" type="guint"/>
				</parameters>
			</method>
			<method name="set_port" symbol="lm_connection_set_port">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="port" type="guint"/>
				</parameters>
			</method>
			<method name="set_proxy" symbol="lm_connection_set_proxy">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="proxy" type="LmProxy*"/>
				</parameters>
			</method>
			<method name="set_server" symbol="lm_connection_set_server">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="server" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_ssl" symbol="lm_connection_set_ssl">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="ssl" type="LmSSL*"/>
				</parameters>
			</method>
			<method name="unref" symbol="lm_connection_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
				</parameters>
			</method>
			<method name="unregister_message_handler" symbol="lm_connection_unregister_message_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="LmConnection*"/>
					<parameter name="handler" type="LmMessageHandler*"/>
					<parameter name="type" type="LmMessageType"/>
				</parameters>
			</method>
		</struct>
		<struct name="LmMessage">
			<method name="get_node" symbol="lm_message_get_node">
				<return-type type="LmMessageNode*"/>
				<parameters>
					<parameter name="message" type="LmMessage*"/>
				</parameters>
			</method>
			<method name="get_sub_type" symbol="lm_message_get_sub_type">
				<return-type type="LmMessageSubType"/>
				<parameters>
					<parameter name="message" type="LmMessage*"/>
				</parameters>
			</method>
			<method name="new" symbol="lm_message_new">
				<return-type type="LmMessage*"/>
				<parameters>
					<parameter name="to" type="gchar*"/>
					<parameter name="type" type="LmMessageType"/>
				</parameters>
			</method>
			<method name="new_with_sub_type" symbol="lm_message_new_with_sub_type">
				<return-type type="LmMessage*"/>
				<parameters>
					<parameter name="to" type="gchar*"/>
					<parameter name="type" type="LmMessageType"/>
					<parameter name="sub_type" type="LmMessageSubType"/>
				</parameters>
			</method>
			<method name="ref" symbol="lm_message_ref">
				<return-type type="LmMessage*"/>
				<parameters>
					<parameter name="message" type="LmMessage*"/>
				</parameters>
			</method>
			<method name="unref" symbol="lm_message_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="LmMessage*"/>
				</parameters>
			</method>
			<field name="node" type="LmMessageNode*"/>
			<field name="priv" type="LmMessagePriv*"/>
		</struct>
		<struct name="LmMessageHandler">
			<method name="invalidate" symbol="lm_message_handler_invalidate">
				<return-type type="void"/>
				<parameters>
					<parameter name="handler" type="LmMessageHandler*"/>
				</parameters>
			</method>
			<method name="is_valid" symbol="lm_message_handler_is_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="handler" type="LmMessageHandler*"/>
				</parameters>
			</method>
			<method name="new" symbol="lm_message_handler_new">
				<return-type type="LmMessageHandler*"/>
				<parameters>
					<parameter name="function" type="LmHandleMessageFunction"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="ref" symbol="lm_message_handler_ref">
				<return-type type="LmMessageHandler*"/>
				<parameters>
					<parameter name="handler" type="LmMessageHandler*"/>
				</parameters>
			</method>
			<method name="unref" symbol="lm_message_handler_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="handler" type="LmMessageHandler*"/>
				</parameters>
			</method>
		</struct>
		<struct name="LmMessageNode">
			<method name="add_child" symbol="lm_message_node_add_child">
				<return-type type="LmMessageNode*"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="find_child" symbol="lm_message_node_find_child">
				<return-type type="LmMessageNode*"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
					<parameter name="child_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_attribute" symbol="lm_message_node_get_attribute">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_child" symbol="lm_message_node_get_child">
				<return-type type="LmMessageNode*"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
					<parameter name="child_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_raw_mode" symbol="lm_message_node_get_raw_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="lm_message_node_get_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
				</parameters>
			</method>
			<method name="ref" symbol="lm_message_node_ref">
				<return-type type="LmMessageNode*"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
				</parameters>
			</method>
			<method name="set_attribute" symbol="lm_message_node_set_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_attributes" symbol="lm_message_node_set_attributes">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_raw_mode" symbol="lm_message_node_set_raw_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
					<parameter name="raw_mode" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_value" symbol="lm_message_node_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="lm_message_node_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
				</parameters>
			</method>
			<method name="unref" symbol="lm_message_node_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="LmMessageNode*"/>
				</parameters>
			</method>
			<field name="name" type="gchar*"/>
			<field name="value" type="gchar*"/>
			<field name="raw_mode" type="gboolean"/>
			<field name="next" type="LmMessageNode*"/>
			<field name="prev" type="LmMessageNode*"/>
			<field name="parent" type="LmMessageNode*"/>
			<field name="children" type="LmMessageNode*"/>
			<field name="attributes" type="GSList*"/>
			<field name="ref_count" type="gint"/>
		</struct>
		<struct name="LmMessagePriv">
		</struct>
		<struct name="LmProxy">
			<method name="get_password" symbol="lm_proxy_get_password">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proxy" type="LmProxy*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="lm_proxy_get_port">
				<return-type type="guint"/>
				<parameters>
					<parameter name="proxy" type="LmProxy*"/>
				</parameters>
			</method>
			<method name="get_server" symbol="lm_proxy_get_server">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proxy" type="LmProxy*"/>
				</parameters>
			</method>
			<method name="get_username" symbol="lm_proxy_get_username">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proxy" type="LmProxy*"/>
				</parameters>
			</method>
			<method name="new" symbol="lm_proxy_new">
				<return-type type="LmProxy*"/>
				<parameters>
					<parameter name="type" type="LmProxyType"/>
				</parameters>
			</method>
			<method name="new_with_server" symbol="lm_proxy_new_with_server">
				<return-type type="LmProxy*"/>
				<parameters>
					<parameter name="type" type="LmProxyType"/>
					<parameter name="server" type="gchar*"/>
					<parameter name="port" type="guint"/>
				</parameters>
			</method>
			<method name="ref" symbol="lm_proxy_ref">
				<return-type type="LmProxy*"/>
				<parameters>
					<parameter name="proxy" type="LmProxy*"/>
				</parameters>
			</method>
			<method name="set_password" symbol="lm_proxy_set_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="LmProxy*"/>
					<parameter name="password" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_port" symbol="lm_proxy_set_port">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="LmProxy*"/>
					<parameter name="port" type="guint"/>
				</parameters>
			</method>
			<method name="set_server" symbol="lm_proxy_set_server">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="LmProxy*"/>
					<parameter name="server" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_type" symbol="lm_proxy_set_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="LmProxy*"/>
					<parameter name="type" type="LmProxyType"/>
				</parameters>
			</method>
			<method name="set_username" symbol="lm_proxy_set_username">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="LmProxy*"/>
					<parameter name="username" type="gchar*"/>
				</parameters>
			</method>
			<method name="unref" symbol="lm_proxy_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="LmProxy*"/>
				</parameters>
			</method>
		</struct>
		<struct name="LmSSL">
			<method name="get_fingerprint" symbol="lm_ssl_get_fingerprint">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="ssl" type="LmSSL*"/>
				</parameters>
			</method>
			<method name="get_require_starttls" symbol="lm_ssl_get_require_starttls">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="ssl" type="LmSSL*"/>
				</parameters>
			</method>
			<method name="get_use_starttls" symbol="lm_ssl_get_use_starttls">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="ssl" type="LmSSL*"/>
				</parameters>
			</method>
			<method name="is_supported" symbol="lm_ssl_is_supported">
				<return-type type="gboolean"/>
			</method>
			<method name="new" symbol="lm_ssl_new">
				<return-type type="LmSSL*"/>
				<parameters>
					<parameter name="expected_fingerprint" type="gchar*"/>
					<parameter name="ssl_function" type="LmSSLFunction"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="ref" symbol="lm_ssl_ref">
				<return-type type="LmSSL*"/>
				<parameters>
					<parameter name="ssl" type="LmSSL*"/>
				</parameters>
			</method>
			<method name="unref" symbol="lm_ssl_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="ssl" type="LmSSL*"/>
				</parameters>
			</method>
			<method name="use_starttls" symbol="lm_ssl_use_starttls">
				<return-type type="void"/>
				<parameters>
					<parameter name="ssl" type="LmSSL*"/>
					<parameter name="use_starttls" type="gboolean"/>
					<parameter name="require" type="gboolean"/>
				</parameters>
			</method>
		</struct>
		<enum name="LmCertificateStatus">
			<member name="LM_CERT_INVALID" value="0"/>
			<member name="LM_CERT_ISSUER_NOT_FOUND" value="1"/>
			<member name="LM_CERT_REVOKED" value="2"/>
		</enum>
		<enum name="LmConnectionState">
			<member name="LM_CONNECTION_STATE_CLOSED" value="0"/>
			<member name="LM_CONNECTION_STATE_OPENING" value="1"/>
			<member name="LM_CONNECTION_STATE_OPEN" value="2"/>
			<member name="LM_CONNECTION_STATE_AUTHENTICATING" value="3"/>
			<member name="LM_CONNECTION_STATE_AUTHENTICATED" value="4"/>
		</enum>
		<enum name="LmDisconnectReason">
			<member name="LM_DISCONNECT_REASON_OK" value="0"/>
			<member name="LM_DISCONNECT_REASON_PING_TIME_OUT" value="1"/>
			<member name="LM_DISCONNECT_REASON_HUP" value="2"/>
			<member name="LM_DISCONNECT_REASON_ERROR" value="3"/>
			<member name="LM_DISCONNECT_REASON_RESOURCE_CONFLICT" value="4"/>
			<member name="LM_DISCONNECT_REASON_INVALID_XML" value="5"/>
			<member name="LM_DISCONNECT_REASON_UNKNOWN" value="6"/>
		</enum>
		<enum name="LmError">
			<member name="LM_ERROR_CONNECTION_NOT_OPEN" value="0"/>
			<member name="LM_ERROR_CONNECTION_OPEN" value="1"/>
			<member name="LM_ERROR_AUTH_FAILED" value="2"/>
			<member name="LM_ERROR_CONNECTION_FAILED" value="3"/>
		</enum>
		<enum name="LmHandlerPriority">
			<member name="LM_HANDLER_PRIORITY_LAST" value="1"/>
			<member name="LM_HANDLER_PRIORITY_NORMAL" value="2"/>
			<member name="LM_HANDLER_PRIORITY_FIRST" value="3"/>
		</enum>
		<enum name="LmHandlerResult">
			<member name="LM_HANDLER_RESULT_REMOVE_MESSAGE" value="0"/>
			<member name="LM_HANDLER_RESULT_ALLOW_MORE_HANDLERS" value="1"/>
		</enum>
		<enum name="LmMessageSubType">
			<member name="LM_MESSAGE_SUB_TYPE_NOT_SET" value="-10"/>
			<member name="LM_MESSAGE_SUB_TYPE_AVAILABLE" value="-1"/>
			<member name="LM_MESSAGE_SUB_TYPE_NORMAL" value="0"/>
			<member name="LM_MESSAGE_SUB_TYPE_CHAT" value="1"/>
			<member name="LM_MESSAGE_SUB_TYPE_GROUPCHAT" value="2"/>
			<member name="LM_MESSAGE_SUB_TYPE_HEADLINE" value="3"/>
			<member name="LM_MESSAGE_SUB_TYPE_UNAVAILABLE" value="4"/>
			<member name="LM_MESSAGE_SUB_TYPE_PROBE" value="5"/>
			<member name="LM_MESSAGE_SUB_TYPE_SUBSCRIBE" value="6"/>
			<member name="LM_MESSAGE_SUB_TYPE_UNSUBSCRIBE" value="7"/>
			<member name="LM_MESSAGE_SUB_TYPE_SUBSCRIBED" value="8"/>
			<member name="LM_MESSAGE_SUB_TYPE_UNSUBSCRIBED" value="9"/>
			<member name="LM_MESSAGE_SUB_TYPE_GET" value="10"/>
			<member name="LM_MESSAGE_SUB_TYPE_SET" value="11"/>
			<member name="LM_MESSAGE_SUB_TYPE_RESULT" value="12"/>
			<member name="LM_MESSAGE_SUB_TYPE_ERROR" value="13"/>
		</enum>
		<enum name="LmMessageType">
			<member name="LM_MESSAGE_TYPE_MESSAGE" value="0"/>
			<member name="LM_MESSAGE_TYPE_PRESENCE" value="1"/>
			<member name="LM_MESSAGE_TYPE_IQ" value="2"/>
			<member name="LM_MESSAGE_TYPE_STREAM" value="3"/>
			<member name="LM_MESSAGE_TYPE_STREAM_ERROR" value="4"/>
			<member name="LM_MESSAGE_TYPE_STREAM_FEATURES" value="5"/>
			<member name="LM_MESSAGE_TYPE_AUTH" value="6"/>
			<member name="LM_MESSAGE_TYPE_CHALLENGE" value="7"/>
			<member name="LM_MESSAGE_TYPE_RESPONSE" value="8"/>
			<member name="LM_MESSAGE_TYPE_SUCCESS" value="9"/>
			<member name="LM_MESSAGE_TYPE_FAILURE" value="10"/>
			<member name="LM_MESSAGE_TYPE_PROCEED" value="11"/>
			<member name="LM_MESSAGE_TYPE_STARTTLS" value="12"/>
			<member name="LM_MESSAGE_TYPE_UNKNOWN" value="13"/>
		</enum>
		<enum name="LmProxyType">
			<member name="LM_PROXY_TYPE_NONE" value="0"/>
			<member name="LM_PROXY_TYPE_HTTP" value="1"/>
		</enum>
		<enum name="LmSSLResponse">
			<member name="LM_SSL_RESPONSE_CONTINUE" value="0"/>
			<member name="LM_SSL_RESPONSE_STOP" value="1"/>
		</enum>
		<enum name="LmSSLStatus">
			<member name="LM_SSL_STATUS_NO_CERT_FOUND" value="0"/>
			<member name="LM_SSL_STATUS_UNTRUSTED_CERT" value="1"/>
			<member name="LM_SSL_STATUS_CERT_EXPIRED" value="2"/>
			<member name="LM_SSL_STATUS_CERT_NOT_ACTIVATED" value="3"/>
			<member name="LM_SSL_STATUS_CERT_HOSTNAME_MISMATCH" value="4"/>
			<member name="LM_SSL_STATUS_CERT_FINGERPRINT_MISMATCH" value="5"/>
			<member name="LM_SSL_STATUS_GENERIC_ERROR" value="6"/>
		</enum>
		<constant name="LM_CONNECTION_DEFAULT_PORT" type="int" value="5222"/>
		<constant name="LM_CONNECTION_DEFAULT_PORT_SSL" type="int" value="5223"/>
		<constant name="LM_INSIDE_LOUDMOUTH_H" type="int" value="1"/>
	</namespace>
</api>
