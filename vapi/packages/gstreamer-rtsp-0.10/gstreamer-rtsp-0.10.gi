<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="rtsp_base64_decode_ip" symbol="gst_rtsp_base64_decode_ip">
			<return-type type="void"/>
			<parameters>
				<parameter name="data" type="gchar*"/>
				<parameter name="len" type="gsize*"/>
			</parameters>
		</function>
		<function name="rtsp_base64_encode" symbol="gst_rtsp_base64_encode">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="data" type="gchar*"/>
				<parameter name="len" type="gsize"/>
			</parameters>
		</function>
		<function name="rtsp_find_header_field" symbol="gst_rtsp_find_header_field">
			<return-type type="GstRTSPHeaderField"/>
			<parameters>
				<parameter name="header" type="gchar*"/>
			</parameters>
		</function>
		<function name="rtsp_find_method" symbol="gst_rtsp_find_method">
			<return-type type="GstRTSPMethod"/>
			<parameters>
				<parameter name="method" type="gchar*"/>
			</parameters>
		</function>
		<function name="rtsp_header_allow_multiple" symbol="gst_rtsp_header_allow_multiple">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="field" type="GstRTSPHeaderField"/>
			</parameters>
		</function>
		<function name="rtsp_header_as_text" symbol="gst_rtsp_header_as_text">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="field" type="GstRTSPHeaderField"/>
			</parameters>
		</function>
		<function name="rtsp_method_as_text" symbol="gst_rtsp_method_as_text">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="method" type="GstRTSPMethod"/>
			</parameters>
		</function>
		<function name="rtsp_options_as_text" symbol="gst_rtsp_options_as_text">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="options" type="GstRTSPMethod"/>
			</parameters>
		</function>
		<function name="rtsp_status_as_text" symbol="gst_rtsp_status_as_text">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="code" type="GstRTSPStatusCode"/>
			</parameters>
		</function>
		<function name="rtsp_strresult" symbol="gst_rtsp_strresult">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="result" type="GstRTSPResult"/>
			</parameters>
		</function>
		<function name="rtsp_version_as_text" symbol="gst_rtsp_version_as_text">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="version" type="GstRTSPVersion"/>
			</parameters>
		</function>
		<struct name="GstRTSPConnection">
			<method name="accept" symbol="gst_rtsp_connection_accept">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="sock" type="gint"/>
					<parameter name="conn" type="GstRTSPConnection**"/>
				</parameters>
			</method>
			<method name="clear_auth_params" symbol="gst_rtsp_connection_clear_auth_params">
				<return-type type="void"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
				</parameters>
			</method>
			<method name="close" symbol="gst_rtsp_connection_close">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
				</parameters>
			</method>
			<method name="connect" symbol="gst_rtsp_connection_connect">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="timeout" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="create" symbol="gst_rtsp_connection_create">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="url" type="GstRTSPUrl*"/>
					<parameter name="conn" type="GstRTSPConnection**"/>
				</parameters>
			</method>
			<method name="create_from_fd" symbol="gst_rtsp_connection_create_from_fd">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="fd" type="gint"/>
					<parameter name="ip" type="gchar*"/>
					<parameter name="port" type="guint16"/>
					<parameter name="initial_buffer" type="gchar*"/>
					<parameter name="conn" type="GstRTSPConnection**"/>
				</parameters>
			</method>
			<method name="do_tunnel" symbol="gst_rtsp_connection_do_tunnel">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="conn2" type="GstRTSPConnection*"/>
				</parameters>
			</method>
			<method name="flush" symbol="gst_rtsp_connection_flush">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="flush" type="gboolean"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_rtsp_connection_free">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
				</parameters>
			</method>
			<method name="get_ip" symbol="gst_rtsp_connection_get_ip">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
				</parameters>
			</method>
			<method name="get_readfd" symbol="gst_rtsp_connection_get_readfd">
				<return-type type="gint"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
				</parameters>
			</method>
			<method name="get_tunnelid" symbol="gst_rtsp_connection_get_tunnelid">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
				</parameters>
			</method>
			<method name="get_url" symbol="gst_rtsp_connection_get_url">
				<return-type type="GstRTSPUrl*"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
				</parameters>
			</method>
			<method name="get_writefd" symbol="gst_rtsp_connection_get_writefd">
				<return-type type="gint"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
				</parameters>
			</method>
			<method name="is_tunneled" symbol="gst_rtsp_connection_is_tunneled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
				</parameters>
			</method>
			<method name="next_timeout" symbol="gst_rtsp_connection_next_timeout">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="timeout" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="poll" symbol="gst_rtsp_connection_poll">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="events" type="GstRTSPEvent"/>
					<parameter name="revents" type="GstRTSPEvent*"/>
					<parameter name="timeout" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="read" symbol="gst_rtsp_connection_read">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
					<parameter name="timeout" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="receive" symbol="gst_rtsp_connection_receive">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="message" type="GstRTSPMessage*"/>
					<parameter name="timeout" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="reset_timeout" symbol="gst_rtsp_connection_reset_timeout">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
				</parameters>
			</method>
			<method name="send" symbol="gst_rtsp_connection_send">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="message" type="GstRTSPMessage*"/>
					<parameter name="timeout" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_auth" symbol="gst_rtsp_connection_set_auth">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="method" type="GstRTSPAuthMethod"/>
					<parameter name="user" type="gchar*"/>
					<parameter name="pass" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_auth_param" symbol="gst_rtsp_connection_set_auth_param">
				<return-type type="void"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="param" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_http_mode" symbol="gst_rtsp_connection_set_http_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="enable" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_ip" symbol="gst_rtsp_connection_set_ip">
				<return-type type="void"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="ip" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_proxy" symbol="gst_rtsp_connection_set_proxy">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="host" type="gchar*"/>
					<parameter name="port" type="guint"/>
				</parameters>
			</method>
			<method name="set_qos_dscp" symbol="gst_rtsp_connection_set_qos_dscp">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="qos_dscp" type="guint"/>
				</parameters>
			</method>
			<method name="set_tunneled" symbol="gst_rtsp_connection_set_tunneled">
				<return-type type="void"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="tunneled" type="gboolean"/>
				</parameters>
			</method>
			<method name="write" symbol="gst_rtsp_connection_write">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
					<parameter name="timeout" type="GTimeVal*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstRTSPMessage">
			<method name="add_header" symbol="gst_rtsp_message_add_header">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="field" type="GstRTSPHeaderField"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="append_headers" symbol="gst_rtsp_message_append_headers">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="str" type="GString*"/>
				</parameters>
			</method>
			<method name="dump" symbol="gst_rtsp_message_dump">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_rtsp_message_free">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
				</parameters>
			</method>
			<method name="get_body" symbol="gst_rtsp_message_get_body">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="data" type="guint8**"/>
					<parameter name="size" type="guint*"/>
				</parameters>
			</method>
			<method name="get_header" symbol="gst_rtsp_message_get_header">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="field" type="GstRTSPHeaderField"/>
					<parameter name="value" type="gchar**"/>
					<parameter name="indx" type="gint"/>
				</parameters>
			</method>
			<method name="init" symbol="gst_rtsp_message_init">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
				</parameters>
			</method>
			<method name="init_data" symbol="gst_rtsp_message_init_data">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="channel" type="guint8"/>
				</parameters>
			</method>
			<method name="init_request" symbol="gst_rtsp_message_init_request">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="method" type="GstRTSPMethod"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="init_response" symbol="gst_rtsp_message_init_response">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="code" type="GstRTSPStatusCode"/>
					<parameter name="reason" type="gchar*"/>
					<parameter name="request" type="GstRTSPMessage*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_rtsp_message_new">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage**"/>
				</parameters>
			</method>
			<method name="new_data" symbol="gst_rtsp_message_new_data">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage**"/>
					<parameter name="channel" type="guint8"/>
				</parameters>
			</method>
			<method name="new_request" symbol="gst_rtsp_message_new_request">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage**"/>
					<parameter name="method" type="GstRTSPMethod"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="new_response" symbol="gst_rtsp_message_new_response">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage**"/>
					<parameter name="code" type="GstRTSPStatusCode"/>
					<parameter name="reason" type="gchar*"/>
					<parameter name="request" type="GstRTSPMessage*"/>
				</parameters>
			</method>
			<method name="parse_data" symbol="gst_rtsp_message_parse_data">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="channel" type="guint8*"/>
				</parameters>
			</method>
			<method name="parse_request" symbol="gst_rtsp_message_parse_request">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="method" type="GstRTSPMethod*"/>
					<parameter name="uri" type="gchar**"/>
					<parameter name="version" type="GstRTSPVersion*"/>
				</parameters>
			</method>
			<method name="parse_response" symbol="gst_rtsp_message_parse_response">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="code" type="GstRTSPStatusCode*"/>
					<parameter name="reason" type="gchar**"/>
					<parameter name="version" type="GstRTSPVersion*"/>
				</parameters>
			</method>
			<method name="remove_header" symbol="gst_rtsp_message_remove_header">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="field" type="GstRTSPHeaderField"/>
					<parameter name="indx" type="gint"/>
				</parameters>
			</method>
			<method name="set_body" symbol="gst_rtsp_message_set_body">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="steal_body" symbol="gst_rtsp_message_steal_body">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="data" type="guint8**"/>
					<parameter name="size" type="guint*"/>
				</parameters>
			</method>
			<method name="take_body" symbol="gst_rtsp_message_take_body">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="take_header" symbol="gst_rtsp_message_take_header">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
					<parameter name="field" type="GstRTSPHeaderField"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="unset" symbol="gst_rtsp_message_unset">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="msg" type="GstRTSPMessage*"/>
				</parameters>
			</method>
			<field name="type" type="GstRTSPMsgType"/>
			<field name="type_data" type="gpointer"/>
			<field name="hdr_fields" type="GArray*"/>
			<field name="body" type="guint8*"/>
			<field name="body_size" type="guint"/>
		</struct>
		<struct name="GstRTSPRange">
			<method name="free" symbol="gst_rtsp_range_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="range" type="GstRTSPTimeRange*"/>
				</parameters>
			</method>
			<method name="parse" symbol="gst_rtsp_range_parse">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="rangestr" type="gchar*"/>
					<parameter name="range" type="GstRTSPTimeRange**"/>
				</parameters>
			</method>
			<method name="to_string" symbol="gst_rtsp_range_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="range" type="GstRTSPTimeRange*"/>
				</parameters>
			</method>
			<field name="min" type="gint"/>
			<field name="max" type="gint"/>
		</struct>
		<struct name="GstRTSPTime">
			<field name="type" type="GstRTSPTimeType"/>
			<field name="seconds" type="gdouble"/>
		</struct>
		<struct name="GstRTSPTimeRange">
			<field name="unit" type="GstRTSPRangeUnit"/>
			<field name="min" type="GstRTSPTime"/>
			<field name="max" type="GstRTSPTime"/>
		</struct>
		<struct name="GstRTSPTransport">
			<method name="as_text" symbol="gst_rtsp_transport_as_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="transport" type="GstRTSPTransport*"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_rtsp_transport_free">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="transport" type="GstRTSPTransport*"/>
				</parameters>
			</method>
			<method name="get_manager" symbol="gst_rtsp_transport_get_manager">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="trans" type="GstRTSPTransMode"/>
					<parameter name="manager" type="gchar**"/>
					<parameter name="option" type="guint"/>
				</parameters>
			</method>
			<method name="get_mime" symbol="gst_rtsp_transport_get_mime">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="trans" type="GstRTSPTransMode"/>
					<parameter name="mime" type="gchar**"/>
				</parameters>
			</method>
			<method name="init" symbol="gst_rtsp_transport_init">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="transport" type="GstRTSPTransport*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_rtsp_transport_new">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="transport" type="GstRTSPTransport**"/>
				</parameters>
			</method>
			<method name="parse" symbol="gst_rtsp_transport_parse">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="str" type="gchar*"/>
					<parameter name="transport" type="GstRTSPTransport*"/>
				</parameters>
			</method>
			<field name="trans" type="GstRTSPTransMode"/>
			<field name="profile" type="GstRTSPProfile"/>
			<field name="lower_transport" type="GstRTSPLowerTrans"/>
			<field name="destination" type="gchar*"/>
			<field name="source" type="gchar*"/>
			<field name="layers" type="guint"/>
			<field name="mode_play" type="gboolean"/>
			<field name="mode_record" type="gboolean"/>
			<field name="append" type="gboolean"/>
			<field name="interleaved" type="GstRTSPRange"/>
			<field name="ttl" type="guint"/>
			<field name="port" type="GstRTSPRange"/>
			<field name="client_port" type="GstRTSPRange"/>
			<field name="server_port" type="GstRTSPRange"/>
			<field name="ssrc" type="guint"/>
		</struct>
		<struct name="GstRTSPWatch">
			<method name="attach" symbol="gst_rtsp_watch_attach">
				<return-type type="guint"/>
				<parameters>
					<parameter name="watch" type="GstRTSPWatch*"/>
					<parameter name="context" type="GMainContext*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_rtsp_watch_new">
				<return-type type="GstRTSPWatch*"/>
				<parameters>
					<parameter name="conn" type="GstRTSPConnection*"/>
					<parameter name="funcs" type="GstRTSPWatchFuncs*"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="queue_data" symbol="gst_rtsp_watch_queue_data">
				<return-type type="guint"/>
				<parameters>
					<parameter name="watch" type="GstRTSPWatch*"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="queue_message" symbol="gst_rtsp_watch_queue_message">
				<return-type type="guint"/>
				<parameters>
					<parameter name="watch" type="GstRTSPWatch*"/>
					<parameter name="message" type="GstRTSPMessage*"/>
				</parameters>
			</method>
			<method name="reset" symbol="gst_rtsp_watch_reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="watch" type="GstRTSPWatch*"/>
				</parameters>
			</method>
			<method name="send_message" symbol="gst_rtsp_watch_send_message">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="watch" type="GstRTSPWatch*"/>
					<parameter name="message" type="GstRTSPMessage*"/>
					<parameter name="id" type="guint*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gst_rtsp_watch_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="watch" type="GstRTSPWatch*"/>
				</parameters>
			</method>
			<method name="write_data" symbol="gst_rtsp_watch_write_data">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="watch" type="GstRTSPWatch*"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
					<parameter name="id" type="guint*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstRTSPWatchFuncs">
			<field name="message_received" type="GCallback"/>
			<field name="message_sent" type="GCallback"/>
			<field name="closed" type="GCallback"/>
			<field name="error" type="GCallback"/>
			<field name="tunnel_start" type="GCallback"/>
			<field name="tunnel_complete" type="GCallback"/>
			<field name="error_full" type="GCallback"/>
			<field name="tunnel_lost" type="GCallback"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<boxed name="GstRTSPUrl" type-name="GstRTSPUrl" get-type="gst_rtsp_url_get_type">
			<method name="copy" symbol="gst_rtsp_url_copy">
				<return-type type="GstRTSPUrl*"/>
				<parameters>
					<parameter name="url" type="GstRTSPUrl*"/>
				</parameters>
			</method>
			<method name="decode_path_components" symbol="gst_rtsp_url_decode_path_components">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="url" type="GstRTSPUrl*"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_rtsp_url_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="url" type="GstRTSPUrl*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="gst_rtsp_url_get_port">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="url" type="GstRTSPUrl*"/>
					<parameter name="port" type="guint16*"/>
				</parameters>
			</method>
			<method name="get_request_uri" symbol="gst_rtsp_url_get_request_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="url" type="GstRTSPUrl*"/>
				</parameters>
			</method>
			<method name="parse" symbol="gst_rtsp_url_parse">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="urlstr" type="gchar*"/>
					<parameter name="url" type="GstRTSPUrl**"/>
				</parameters>
			</method>
			<method name="set_port" symbol="gst_rtsp_url_set_port">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="url" type="GstRTSPUrl*"/>
					<parameter name="port" type="guint16"/>
				</parameters>
			</method>
			<field name="transports" type="GstRTSPLowerTrans"/>
			<field name="family" type="GstRTSPFamily"/>
			<field name="user" type="gchar*"/>
			<field name="passwd" type="gchar*"/>
			<field name="host" type="gchar*"/>
			<field name="port" type="guint16"/>
			<field name="abspath" type="gchar*"/>
			<field name="query" type="gchar*"/>
		</boxed>
		<enum name="GstRTSPAuthMethod" type-name="GstRTSPAuthMethod" get-type="gst_rtsp_auth_method_get_type">
			<member name="GST_RTSP_AUTH_NONE" value="0"/>
			<member name="GST_RTSP_AUTH_BASIC" value="1"/>
			<member name="GST_RTSP_AUTH_DIGEST" value="2"/>
		</enum>
		<enum name="GstRTSPFamily" type-name="GstRTSPFamily" get-type="gst_rtsp_family_get_type">
			<member name="GST_RTSP_FAM_NONE" value="0"/>
			<member name="GST_RTSP_FAM_INET" value="1"/>
			<member name="GST_RTSP_FAM_INET6" value="2"/>
		</enum>
		<enum name="GstRTSPHeaderField" type-name="GstRTSPHeaderField" get-type="gst_rtsp_header_field_get_type">
			<member name="GST_RTSP_HDR_INVALID" value="0"/>
			<member name="GST_RTSP_HDR_ACCEPT" value="1"/>
			<member name="GST_RTSP_HDR_ACCEPT_ENCODING" value="2"/>
			<member name="GST_RTSP_HDR_ACCEPT_LANGUAGE" value="3"/>
			<member name="GST_RTSP_HDR_ALLOW" value="4"/>
			<member name="GST_RTSP_HDR_AUTHORIZATION" value="5"/>
			<member name="GST_RTSP_HDR_BANDWIDTH" value="6"/>
			<member name="GST_RTSP_HDR_BLOCKSIZE" value="7"/>
			<member name="GST_RTSP_HDR_CACHE_CONTROL" value="8"/>
			<member name="GST_RTSP_HDR_CONFERENCE" value="9"/>
			<member name="GST_RTSP_HDR_CONNECTION" value="10"/>
			<member name="GST_RTSP_HDR_CONTENT_BASE" value="11"/>
			<member name="GST_RTSP_HDR_CONTENT_ENCODING" value="12"/>
			<member name="GST_RTSP_HDR_CONTENT_LANGUAGE" value="13"/>
			<member name="GST_RTSP_HDR_CONTENT_LENGTH" value="14"/>
			<member name="GST_RTSP_HDR_CONTENT_LOCATION" value="15"/>
			<member name="GST_RTSP_HDR_CONTENT_TYPE" value="16"/>
			<member name="GST_RTSP_HDR_CSEQ" value="17"/>
			<member name="GST_RTSP_HDR_DATE" value="18"/>
			<member name="GST_RTSP_HDR_EXPIRES" value="19"/>
			<member name="GST_RTSP_HDR_FROM" value="20"/>
			<member name="GST_RTSP_HDR_IF_MODIFIED_SINCE" value="21"/>
			<member name="GST_RTSP_HDR_LAST_MODIFIED" value="22"/>
			<member name="GST_RTSP_HDR_PROXY_AUTHENTICATE" value="23"/>
			<member name="GST_RTSP_HDR_PROXY_REQUIRE" value="24"/>
			<member name="GST_RTSP_HDR_PUBLIC" value="25"/>
			<member name="GST_RTSP_HDR_RANGE" value="26"/>
			<member name="GST_RTSP_HDR_REFERER" value="27"/>
			<member name="GST_RTSP_HDR_REQUIRE" value="28"/>
			<member name="GST_RTSP_HDR_RETRY_AFTER" value="29"/>
			<member name="GST_RTSP_HDR_RTP_INFO" value="30"/>
			<member name="GST_RTSP_HDR_SCALE" value="31"/>
			<member name="GST_RTSP_HDR_SESSION" value="32"/>
			<member name="GST_RTSP_HDR_SERVER" value="33"/>
			<member name="GST_RTSP_HDR_SPEED" value="34"/>
			<member name="GST_RTSP_HDR_TRANSPORT" value="35"/>
			<member name="GST_RTSP_HDR_UNSUPPORTED" value="36"/>
			<member name="GST_RTSP_HDR_USER_AGENT" value="37"/>
			<member name="GST_RTSP_HDR_VIA" value="38"/>
			<member name="GST_RTSP_HDR_WWW_AUTHENTICATE" value="39"/>
			<member name="GST_RTSP_HDR_CLIENT_CHALLENGE" value="40"/>
			<member name="GST_RTSP_HDR_REAL_CHALLENGE1" value="41"/>
			<member name="GST_RTSP_HDR_REAL_CHALLENGE2" value="42"/>
			<member name="GST_RTSP_HDR_REAL_CHALLENGE3" value="43"/>
			<member name="GST_RTSP_HDR_SUBSCRIBE" value="44"/>
			<member name="GST_RTSP_HDR_ALERT" value="45"/>
			<member name="GST_RTSP_HDR_CLIENT_ID" value="46"/>
			<member name="GST_RTSP_HDR_COMPANY_ID" value="47"/>
			<member name="GST_RTSP_HDR_GUID" value="48"/>
			<member name="GST_RTSP_HDR_REGION_DATA" value="49"/>
			<member name="GST_RTSP_HDR_MAX_ASM_WIDTH" value="50"/>
			<member name="GST_RTSP_HDR_LANGUAGE" value="51"/>
			<member name="GST_RTSP_HDR_PLAYER_START_TIME" value="52"/>
			<member name="GST_RTSP_HDR_LOCATION" value="53"/>
			<member name="GST_RTSP_HDR_ETAG" value="54"/>
			<member name="GST_RTSP_HDR_IF_MATCH" value="55"/>
			<member name="GST_RTSP_HDR_ACCEPT_CHARSET" value="56"/>
			<member name="GST_RTSP_HDR_SUPPORTED" value="57"/>
			<member name="GST_RTSP_HDR_VARY" value="58"/>
			<member name="GST_RTSP_HDR_X_ACCELERATE_STREAMING" value="59"/>
			<member name="GST_RTSP_HDR_X_ACCEPT_AUTHENT" value="60"/>
			<member name="GST_RTSP_HDR_X_ACCEPT_PROXY_AUTHENT" value="61"/>
			<member name="GST_RTSP_HDR_X_BROADCAST_ID" value="62"/>
			<member name="GST_RTSP_HDR_X_BURST_STREAMING" value="63"/>
			<member name="GST_RTSP_HDR_X_NOTICE" value="64"/>
			<member name="GST_RTSP_HDR_X_PLAYER_LAG_TIME" value="65"/>
			<member name="GST_RTSP_HDR_X_PLAYLIST" value="66"/>
			<member name="GST_RTSP_HDR_X_PLAYLIST_CHANGE_NOTICE" value="67"/>
			<member name="GST_RTSP_HDR_X_PLAYLIST_GEN_ID" value="68"/>
			<member name="GST_RTSP_HDR_X_PLAYLIST_SEEK_ID" value="69"/>
			<member name="GST_RTSP_HDR_X_PROXY_CLIENT_AGENT" value="70"/>
			<member name="GST_RTSP_HDR_X_PROXY_CLIENT_VERB" value="71"/>
			<member name="GST_RTSP_HDR_X_RECEDING_PLAYLISTCHANGE" value="72"/>
			<member name="GST_RTSP_HDR_X_RTP_INFO" value="73"/>
			<member name="GST_RTSP_HDR_X_STARTUPPROFILE" value="74"/>
			<member name="GST_RTSP_HDR_TIMESTAMP" value="75"/>
			<member name="GST_RTSP_HDR_AUTHENTICATION_INFO" value="76"/>
			<member name="GST_RTSP_HDR_HOST" value="77"/>
			<member name="GST_RTSP_HDR_PRAGMA" value="78"/>
			<member name="GST_RTSP_HDR_X_SERVER_IP_ADDRESS" value="79"/>
			<member name="GST_RTSP_HDR_X_SESSIONCOOKIE" value="80"/>
			<member name="GST_RTSP_HDR_LAST" value="81"/>
		</enum>
		<enum name="GstRTSPMsgType">
			<member name="GST_RTSP_MESSAGE_INVALID" value="0"/>
			<member name="GST_RTSP_MESSAGE_REQUEST" value="1"/>
			<member name="GST_RTSP_MESSAGE_RESPONSE" value="2"/>
			<member name="GST_RTSP_MESSAGE_HTTP_REQUEST" value="3"/>
			<member name="GST_RTSP_MESSAGE_HTTP_RESPONSE" value="4"/>
			<member name="GST_RTSP_MESSAGE_DATA" value="5"/>
		</enum>
		<enum name="GstRTSPProfile">
			<member name="GST_RTSP_PROFILE_UNKNOWN" value="0"/>
			<member name="GST_RTSP_PROFILE_AVP" value="1"/>
			<member name="GST_RTSP_PROFILE_SAVP" value="2"/>
		</enum>
		<enum name="GstRTSPRangeUnit">
			<member name="GST_RTSP_RANGE_SMPTE" value="0"/>
			<member name="GST_RTSP_RANGE_SMPTE_30_DROP" value="1"/>
			<member name="GST_RTSP_RANGE_SMPTE_25" value="2"/>
			<member name="GST_RTSP_RANGE_NPT" value="3"/>
			<member name="GST_RTSP_RANGE_CLOCK" value="4"/>
		</enum>
		<enum name="GstRTSPResult" type-name="GstRTSPResult" get-type="gst_rtsp_result_get_type">
			<member name="GST_RTSP_OK" value="0"/>
			<member name="GST_RTSP_ERROR" value="-1"/>
			<member name="GST_RTSP_EINVAL" value="-2"/>
			<member name="GST_RTSP_EINTR" value="-3"/>
			<member name="GST_RTSP_ENOMEM" value="-4"/>
			<member name="GST_RTSP_ERESOLV" value="-5"/>
			<member name="GST_RTSP_ENOTIMPL" value="-6"/>
			<member name="GST_RTSP_ESYS" value="-7"/>
			<member name="GST_RTSP_EPARSE" value="-8"/>
			<member name="GST_RTSP_EWSASTART" value="-9"/>
			<member name="GST_RTSP_EWSAVERSION" value="-10"/>
			<member name="GST_RTSP_EEOF" value="-11"/>
			<member name="GST_RTSP_ENET" value="-12"/>
			<member name="GST_RTSP_ENOTIP" value="-13"/>
			<member name="GST_RTSP_ETIMEOUT" value="-14"/>
			<member name="GST_RTSP_ETGET" value="-15"/>
			<member name="GST_RTSP_ETPOST" value="-16"/>
			<member name="GST_RTSP_ELAST" value="-17"/>
		</enum>
		<enum name="GstRTSPState" type-name="GstRTSPState" get-type="gst_rtsp_state_get_type">
			<member name="GST_RTSP_STATE_INVALID" value="0"/>
			<member name="GST_RTSP_STATE_INIT" value="1"/>
			<member name="GST_RTSP_STATE_READY" value="2"/>
			<member name="GST_RTSP_STATE_SEEKING" value="3"/>
			<member name="GST_RTSP_STATE_PLAYING" value="4"/>
			<member name="GST_RTSP_STATE_RECORDING" value="5"/>
		</enum>
		<enum name="GstRTSPStatusCode" type-name="GstRTSPStatusCode" get-type="gst_rtsp_status_code_get_type">
			<member name="GST_RTSP_STS_INVALID" value="0"/>
			<member name="GST_RTSP_STS_CONTINUE" value="100"/>
			<member name="GST_RTSP_STS_OK" value="200"/>
			<member name="GST_RTSP_STS_CREATED" value="201"/>
			<member name="GST_RTSP_STS_LOW_ON_STORAGE" value="250"/>
			<member name="GST_RTSP_STS_MULTIPLE_CHOICES" value="300"/>
			<member name="GST_RTSP_STS_MOVED_PERMANENTLY" value="301"/>
			<member name="GST_RTSP_STS_MOVE_TEMPORARILY" value="302"/>
			<member name="GST_RTSP_STS_SEE_OTHER" value="303"/>
			<member name="GST_RTSP_STS_NOT_MODIFIED" value="304"/>
			<member name="GST_RTSP_STS_USE_PROXY" value="305"/>
			<member name="GST_RTSP_STS_BAD_REQUEST" value="400"/>
			<member name="GST_RTSP_STS_UNAUTHORIZED" value="401"/>
			<member name="GST_RTSP_STS_PAYMENT_REQUIRED" value="402"/>
			<member name="GST_RTSP_STS_FORBIDDEN" value="403"/>
			<member name="GST_RTSP_STS_NOT_FOUND" value="404"/>
			<member name="GST_RTSP_STS_METHOD_NOT_ALLOWED" value="405"/>
			<member name="GST_RTSP_STS_NOT_ACCEPTABLE" value="406"/>
			<member name="GST_RTSP_STS_PROXY_AUTH_REQUIRED" value="407"/>
			<member name="GST_RTSP_STS_REQUEST_TIMEOUT" value="408"/>
			<member name="GST_RTSP_STS_GONE" value="410"/>
			<member name="GST_RTSP_STS_LENGTH_REQUIRED" value="411"/>
			<member name="GST_RTSP_STS_PRECONDITION_FAILED" value="412"/>
			<member name="GST_RTSP_STS_REQUEST_ENTITY_TOO_LARGE" value="413"/>
			<member name="GST_RTSP_STS_REQUEST_URI_TOO_LARGE" value="414"/>
			<member name="GST_RTSP_STS_UNSUPPORTED_MEDIA_TYPE" value="415"/>
			<member name="GST_RTSP_STS_PARAMETER_NOT_UNDERSTOOD" value="451"/>
			<member name="GST_RTSP_STS_CONFERENCE_NOT_FOUND" value="452"/>
			<member name="GST_RTSP_STS_NOT_ENOUGH_BANDWIDTH" value="453"/>
			<member name="GST_RTSP_STS_SESSION_NOT_FOUND" value="454"/>
			<member name="GST_RTSP_STS_METHOD_NOT_VALID_IN_THIS_STATE" value="455"/>
			<member name="GST_RTSP_STS_HEADER_FIELD_NOT_VALID_FOR_RESOURCE" value="456"/>
			<member name="GST_RTSP_STS_INVALID_RANGE" value="457"/>
			<member name="GST_RTSP_STS_PARAMETER_IS_READONLY" value="458"/>
			<member name="GST_RTSP_STS_AGGREGATE_OPERATION_NOT_ALLOWED" value="459"/>
			<member name="GST_RTSP_STS_ONLY_AGGREGATE_OPERATION_ALLOWED" value="460"/>
			<member name="GST_RTSP_STS_UNSUPPORTED_TRANSPORT" value="461"/>
			<member name="GST_RTSP_STS_DESTINATION_UNREACHABLE" value="462"/>
			<member name="GST_RTSP_STS_INTERNAL_SERVER_ERROR" value="500"/>
			<member name="GST_RTSP_STS_NOT_IMPLEMENTED" value="501"/>
			<member name="GST_RTSP_STS_BAD_GATEWAY" value="502"/>
			<member name="GST_RTSP_STS_SERVICE_UNAVAILABLE" value="503"/>
			<member name="GST_RTSP_STS_GATEWAY_TIMEOUT" value="504"/>
			<member name="GST_RTSP_STS_RTSP_VERSION_NOT_SUPPORTED" value="505"/>
			<member name="GST_RTSP_STS_OPTION_NOT_SUPPORTED" value="551"/>
		</enum>
		<enum name="GstRTSPTimeType">
			<member name="GST_RTSP_TIME_SECONDS" value="0"/>
			<member name="GST_RTSP_TIME_NOW" value="1"/>
			<member name="GST_RTSP_TIME_END" value="2"/>
		</enum>
		<enum name="GstRTSPTransMode">
			<member name="GST_RTSP_TRANS_UNKNOWN" value="0"/>
			<member name="GST_RTSP_TRANS_RTP" value="1"/>
			<member name="GST_RTSP_TRANS_RDT" value="2"/>
		</enum>
		<enum name="GstRTSPVersion" type-name="GstRTSPVersion" get-type="gst_rtsp_version_get_type">
			<member name="GST_RTSP_VERSION_INVALID" value="0"/>
			<member name="GST_RTSP_VERSION_1_0" value="16"/>
			<member name="GST_RTSP_VERSION_1_1" value="17"/>
		</enum>
		<flags name="GstRTSPEvent" type-name="GstRTSPEvent" get-type="gst_rtsp_event_get_type">
			<member name="GST_RTSP_EV_READ" value="1"/>
			<member name="GST_RTSP_EV_WRITE" value="2"/>
		</flags>
		<flags name="GstRTSPLowerTrans" type-name="GstRTSPLowerTrans" get-type="gst_rtsp_lower_trans_get_type">
			<member name="GST_RTSP_LOWER_TRANS_UDP" value="1"/>
			<member name="GST_RTSP_LOWER_TRANS_UDP_MCAST" value="2"/>
			<member name="GST_RTSP_LOWER_TRANS_TCP" value="4"/>
			<member name="GST_RTSP_LOWER_TRANS_HTTP" value="16"/>
		</flags>
		<flags name="GstRTSPMethod" type-name="GstRTSPMethod" get-type="gst_rtsp_method_get_type">
			<member name="GST_RTSP_INVALID" value="0"/>
			<member name="GST_RTSP_DESCRIBE" value="1"/>
			<member name="GST_RTSP_ANNOUNCE" value="2"/>
			<member name="GST_RTSP_GET_PARAMETER" value="4"/>
			<member name="GST_RTSP_OPTIONS" value="8"/>
			<member name="GST_RTSP_PAUSE" value="16"/>
			<member name="GST_RTSP_PLAY" value="32"/>
			<member name="GST_RTSP_RECORD" value="64"/>
			<member name="GST_RTSP_REDIRECT" value="128"/>
			<member name="GST_RTSP_SETUP" value="256"/>
			<member name="GST_RTSP_SET_PARAMETER" value="512"/>
			<member name="GST_RTSP_TEARDOWN" value="1024"/>
			<member name="GST_RTSP_GET" value="2048"/>
			<member name="GST_RTSP_POST" value="4096"/>
		</flags>
		<interface name="GstRTSPExtension" type-name="GstRTSPExtension" get-type="gst_rtsp_extension_get_type">
			<method name="after_send" symbol="gst_rtsp_extension_after_send">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="req" type="GstRTSPMessage*"/>
					<parameter name="resp" type="GstRTSPMessage*"/>
				</parameters>
			</method>
			<method name="before_send" symbol="gst_rtsp_extension_before_send">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="req" type="GstRTSPMessage*"/>
				</parameters>
			</method>
			<method name="configure_stream" symbol="gst_rtsp_extension_configure_stream">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="detect_server" symbol="gst_rtsp_extension_detect_server">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="resp" type="GstRTSPMessage*"/>
				</parameters>
			</method>
			<method name="get_transports" symbol="gst_rtsp_extension_get_transports">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="protocols" type="GstRTSPLowerTrans"/>
					<parameter name="transport" type="gchar**"/>
				</parameters>
			</method>
			<method name="parse_sdp" symbol="gst_rtsp_extension_parse_sdp">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="sdp" type="GstSDPMessage*"/>
					<parameter name="s" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="receive_request" symbol="gst_rtsp_extension_receive_request">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="req" type="GstRTSPMessage*"/>
				</parameters>
			</method>
			<method name="send" symbol="gst_rtsp_extension_send">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="req" type="GstRTSPMessage*"/>
					<parameter name="resp" type="GstRTSPMessage*"/>
				</parameters>
			</method>
			<method name="setup_media" symbol="gst_rtsp_extension_setup_media">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</method>
			<method name="stream_select" symbol="gst_rtsp_extension_stream_select">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="url" type="GstRTSPUrl*"/>
				</parameters>
			</method>
			<signal name="send" when="LAST">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="req" type="gpointer"/>
					<parameter name="resp" type="gpointer"/>
				</parameters>
			</signal>
			<vfunc name="after_send">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="req" type="GstRTSPMessage*"/>
					<parameter name="resp" type="GstRTSPMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="before_send">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="req" type="GstRTSPMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="configure_stream">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</vfunc>
			<vfunc name="detect_server">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="resp" type="GstRTSPMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_transports">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="protocols" type="GstRTSPLowerTrans"/>
					<parameter name="transport" type="gchar**"/>
				</parameters>
			</vfunc>
			<vfunc name="parse_sdp">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="sdp" type="GstSDPMessage*"/>
					<parameter name="s" type="GstStructure*"/>
				</parameters>
			</vfunc>
			<vfunc name="receive_request">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="req" type="GstRTSPMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="setup_media">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="media" type="GstSDPMedia*"/>
				</parameters>
			</vfunc>
			<vfunc name="stream_select">
				<return-type type="GstRTSPResult"/>
				<parameters>
					<parameter name="ext" type="GstRTSPExtension*"/>
					<parameter name="url" type="GstRTSPUrl*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="GST_RTSP_DEFAULT_PORT" type="int" value="554"/>
	</namespace>
</api>
