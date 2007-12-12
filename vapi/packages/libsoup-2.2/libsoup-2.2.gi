<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Soup">
		<function name="add_idle" symbol="soup_add_idle">
			<return-type type="GSource*"/>
			<parameters>
				<parameter name="async_context" type="GMainContext*"/>
				<parameter name="function" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="add_io_watch" symbol="soup_add_io_watch">
			<return-type type="GSource*"/>
			<parameters>
				<parameter name="async_context" type="GMainContext*"/>
				<parameter name="chan" type="GIOChannel*"/>
				<parameter name="condition" type="GIOCondition"/>
				<parameter name="function" type="GIOFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="add_timeout" symbol="soup_add_timeout">
			<return-type type="GSource*"/>
			<parameters>
				<parameter name="async_context" type="GMainContext*"/>
				<parameter name="interval" type="guint"/>
				<parameter name="function" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="base64_decode" symbol="soup_base64_decode">
			<return-type type="char*"/>
			<parameters>
				<parameter name="text" type="gchar*"/>
				<parameter name="out_len" type="int*"/>
			</parameters>
		</function>
		<function name="base64_decode_step" symbol="soup_base64_decode_step">
			<return-type type="int"/>
			<parameters>
				<parameter name="in" type="guchar*"/>
				<parameter name="len" type="int"/>
				<parameter name="out" type="guchar*"/>
				<parameter name="state" type="int*"/>
				<parameter name="save" type="guint*"/>
			</parameters>
		</function>
		<function name="base64_encode" symbol="soup_base64_encode">
			<return-type type="char*"/>
			<parameters>
				<parameter name="text" type="char*"/>
				<parameter name="len" type="int"/>
			</parameters>
		</function>
		<function name="base64_encode_close" symbol="soup_base64_encode_close">
			<return-type type="int"/>
			<parameters>
				<parameter name="in" type="guchar*"/>
				<parameter name="inlen" type="int"/>
				<parameter name="break_lines" type="gboolean"/>
				<parameter name="out" type="guchar*"/>
				<parameter name="state" type="int*"/>
				<parameter name="save" type="int*"/>
			</parameters>
		</function>
		<function name="base64_encode_step" symbol="soup_base64_encode_step">
			<return-type type="int"/>
			<parameters>
				<parameter name="in" type="guchar*"/>
				<parameter name="len" type="int"/>
				<parameter name="break_lines" type="gboolean"/>
				<parameter name="out" type="guchar*"/>
				<parameter name="state" type="int*"/>
				<parameter name="save" type="int*"/>
			</parameters>
		</function>
		<function name="date_generate" symbol="soup_date_generate">
			<return-type type="char*"/>
			<parameters>
				<parameter name="when" type="time_t"/>
			</parameters>
		</function>
		<function name="date_iso8601_parse" symbol="soup_date_iso8601_parse">
			<return-type type="time_t"/>
			<parameters>
				<parameter name="timestamp" type="char*"/>
			</parameters>
		</function>
		<function name="date_parse" symbol="soup_date_parse">
			<return-type type="time_t"/>
			<parameters>
				<parameter name="timestamp" type="char*"/>
			</parameters>
		</function>
		<function name="gmtime" symbol="soup_gmtime">
			<return-type type="void"/>
			<parameters>
				<parameter name="when" type="time_t*"/>
				<parameter name="tm" type="struct tm*"/>
			</parameters>
		</function>
		<function name="header_param_copy_token" symbol="soup_header_param_copy_token">
			<return-type type="char*"/>
			<parameters>
				<parameter name="tokens" type="GHashTable*"/>
				<parameter name="t" type="char*"/>
			</parameters>
		</function>
		<function name="header_param_decode_token" symbol="soup_header_param_decode_token">
			<return-type type="char*"/>
			<parameters>
				<parameter name="in" type="char**"/>
			</parameters>
		</function>
		<function name="header_param_destroy_hash" symbol="soup_header_param_destroy_hash">
			<return-type type="void"/>
			<parameters>
				<parameter name="table" type="GHashTable*"/>
			</parameters>
		</function>
		<function name="header_param_parse_list" symbol="soup_header_param_parse_list">
			<return-type type="GHashTable*"/>
			<parameters>
				<parameter name="header" type="char*"/>
			</parameters>
		</function>
		<function name="headers_parse_request" symbol="soup_headers_parse_request">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="len" type="int"/>
				<parameter name="dest" type="GHashTable*"/>
				<parameter name="req_method" type="char**"/>
				<parameter name="req_path" type="char**"/>
				<parameter name="ver" type="SoupHttpVersion*"/>
			</parameters>
		</function>
		<function name="headers_parse_response" symbol="soup_headers_parse_response">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="len" type="int"/>
				<parameter name="dest" type="GHashTable*"/>
				<parameter name="ver" type="SoupHttpVersion*"/>
				<parameter name="status_code" type="guint*"/>
				<parameter name="reason_phrase" type="char**"/>
			</parameters>
		</function>
		<function name="headers_parse_status_line" symbol="soup_headers_parse_status_line">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="status_line" type="char*"/>
				<parameter name="ver" type="SoupHttpVersion*"/>
				<parameter name="status_code" type="guint*"/>
				<parameter name="reason_phrase" type="char**"/>
			</parameters>
		</function>
		<function name="method_get_id" symbol="soup_method_get_id">
			<return-type type="SoupMethodId"/>
			<parameters>
				<parameter name="method" type="char*"/>
			</parameters>
		</function>
		<function name="mktime_utc" symbol="soup_mktime_utc">
			<return-type type="time_t"/>
			<parameters>
				<parameter name="tm" type="struct tm*"/>
			</parameters>
		</function>
		<function name="signal_connect_once" symbol="soup_signal_connect_once">
			<return-type type="guint"/>
			<parameters>
				<parameter name="instance" type="gpointer"/>
				<parameter name="detailed_signal" type="char*"/>
				<parameter name="c_handler" type="GCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="status_get_phrase" symbol="soup_status_get_phrase">
			<return-type type="char*"/>
			<parameters>
				<parameter name="status_code" type="guint"/>
			</parameters>
		</function>
		<function name="str_case_equal" symbol="soup_str_case_equal">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="v1" type="gconstpointer"/>
				<parameter name="v2" type="gconstpointer"/>
			</parameters>
		</function>
		<function name="str_case_hash" symbol="soup_str_case_hash">
			<return-type type="guint"/>
			<parameters>
				<parameter name="key" type="gconstpointer"/>
			</parameters>
		</function>
		<function name="xml_real_node" symbol="soup_xml_real_node">
			<return-type type="xmlNode*"/>
			<parameters>
				<parameter name="node" type="xmlNode*"/>
			</parameters>
		</function>
		<callback name="SoupAddressCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="addr" type="SoupAddress*"/>
				<parameter name="status" type="guint"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupConnectionCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="conn" type="SoupConnection*"/>
				<parameter name="status" type="guint"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupMessageCallbackFn">
			<return-type type="void"/>
			<parameters>
				<parameter name="req" type="SoupMessage*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupServerAuthCallbackFn">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="auth_ctx" type="SoupServerAuthContext*"/>
				<parameter name="auth" type="SoupServerAuth*"/>
				<parameter name="msg" type="SoupMessage*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupServerCallbackFn">
			<return-type type="void"/>
			<parameters>
				<parameter name="context" type="SoupServerContext*"/>
				<parameter name="msg" type="SoupMessage*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupServerUnregisterFn">
			<return-type type="void"/>
			<parameters>
				<parameter name="server" type="SoupServer*"/>
				<parameter name="handler" type="SoupServerHandler*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupSocketCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="sock" type="SoupSocket*"/>
				<parameter name="status" type="guint"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupSocketListenerCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="listener" type="SoupSocket*"/>
				<parameter name="sock" type="SoupSocket*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="SoupDataBuffer">
			<field name="owner" type="SoupOwnership"/>
			<field name="body" type="char*"/>
			<field name="length" type="guint"/>
		</struct>
		<struct name="SoupMessageQueue">
			<method name="append" symbol="soup_message_queue_append">
				<return-type type="void"/>
				<parameters>
					<parameter name="queue" type="SoupMessageQueue*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="soup_message_queue_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="queue" type="SoupMessageQueue*"/>
				</parameters>
			</method>
			<method name="first" symbol="soup_message_queue_first">
				<return-type type="SoupMessage*"/>
				<parameters>
					<parameter name="queue" type="SoupMessageQueue*"/>
					<parameter name="iter" type="SoupMessageQueueIter*"/>
				</parameters>
			</method>
			<method name="free_iter" symbol="soup_message_queue_free_iter">
				<return-type type="void"/>
				<parameters>
					<parameter name="queue" type="SoupMessageQueue*"/>
					<parameter name="iter" type="SoupMessageQueueIter*"/>
				</parameters>
			</method>
			<method name="new" symbol="soup_message_queue_new">
				<return-type type="SoupMessageQueue*"/>
			</method>
			<method name="next" symbol="soup_message_queue_next">
				<return-type type="SoupMessage*"/>
				<parameters>
					<parameter name="queue" type="SoupMessageQueue*"/>
					<parameter name="iter" type="SoupMessageQueueIter*"/>
				</parameters>
			</method>
			<method name="remove" symbol="soup_message_queue_remove">
				<return-type type="SoupMessage*"/>
				<parameters>
					<parameter name="queue" type="SoupMessageQueue*"/>
					<parameter name="iter" type="SoupMessageQueueIter*"/>
				</parameters>
			</method>
			<method name="remove_message" symbol="soup_message_queue_remove_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="queue" type="SoupMessageQueue*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
		</struct>
		<struct name="SoupMessageQueueIter">
			<field name="cur" type="GList*"/>
			<field name="next" type="GList*"/>
		</struct>
		<struct name="SoupProtocol">
		</struct>
		<struct name="SoupServerAuthBasic">
			<field name="type" type="SoupAuthType"/>
			<field name="user" type="gchar*"/>
			<field name="passwd" type="gchar*"/>
		</struct>
		<struct name="SoupServerAuthContext">
			<method name="challenge" symbol="soup_server_auth_context_challenge">
				<return-type type="void"/>
				<parameters>
					<parameter name="auth_ctx" type="SoupServerAuthContext*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="header_name" type="gchar*"/>
				</parameters>
			</method>
			<field name="types" type="guint"/>
			<field name="callback" type="SoupServerAuthCallbackFn"/>
			<field name="user_data" type="gpointer"/>
			<field name="basic_info" type="gpointer"/>
			<field name="digest_info" type="gpointer"/>
		</struct>
		<struct name="SoupServerAuthDigest">
			<field name="type" type="SoupAuthType"/>
			<field name="algorithm" type="SoupDigestAlgorithm"/>
			<field name="integrity" type="gboolean"/>
			<field name="realm" type="gchar*"/>
			<field name="user" type="gchar*"/>
			<field name="nonce" type="gchar*"/>
			<field name="nonce_count" type="gint"/>
			<field name="cnonce" type="gchar*"/>
			<field name="digest_uri" type="gchar*"/>
			<field name="digest_response" type="gchar*"/>
			<field name="request_method" type="gchar*"/>
		</struct>
		<struct name="SoupServerContext">
			<method name="get_client_address" symbol="soup_server_context_get_client_address">
				<return-type type="SoupAddress*"/>
				<parameters>
					<parameter name="ctx" type="SoupServerContext*"/>
				</parameters>
			</method>
			<method name="get_client_host" symbol="soup_server_context_get_client_host">
				<return-type type="char*"/>
				<parameters>
					<parameter name="ctx" type="SoupServerContext*"/>
				</parameters>
			</method>
			<field name="msg" type="SoupMessage*"/>
			<field name="path" type="char*"/>
			<field name="method_id" type="SoupMethodId"/>
			<field name="auth" type="SoupServerAuth*"/>
			<field name="server" type="SoupServer*"/>
			<field name="handler" type="SoupServerHandler*"/>
			<field name="sock" type="SoupSocket*"/>
		</struct>
		<struct name="SoupServerHandler">
			<field name="path" type="char*"/>
			<field name="auth_ctx" type="SoupServerAuthContext*"/>
			<field name="callback" type="SoupServerCallbackFn"/>
			<field name="unregister" type="SoupServerUnregisterFn"/>
			<field name="user_data" type="gpointer"/>
		</struct>
		<struct name="SoupSoapParameter">
			<method name="get_first_child" symbol="soup_soap_parameter_get_first_child">
				<return-type type="SoupSoapParameter*"/>
				<parameters>
					<parameter name="param" type="SoupSoapParameter*"/>
				</parameters>
			</method>
			<method name="get_first_child_by_name" symbol="soup_soap_parameter_get_first_child_by_name">
				<return-type type="SoupSoapParameter*"/>
				<parameters>
					<parameter name="param" type="SoupSoapParameter*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_int_value" symbol="soup_soap_parameter_get_int_value">
				<return-type type="int"/>
				<parameters>
					<parameter name="param" type="SoupSoapParameter*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="soup_soap_parameter_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="param" type="SoupSoapParameter*"/>
				</parameters>
			</method>
			<method name="get_next_child" symbol="soup_soap_parameter_get_next_child">
				<return-type type="SoupSoapParameter*"/>
				<parameters>
					<parameter name="param" type="SoupSoapParameter*"/>
				</parameters>
			</method>
			<method name="get_next_child_by_name" symbol="soup_soap_parameter_get_next_child_by_name">
				<return-type type="SoupSoapParameter*"/>
				<parameters>
					<parameter name="param" type="SoupSoapParameter*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_property" symbol="soup_soap_parameter_get_property">
				<return-type type="char*"/>
				<parameters>
					<parameter name="param" type="SoupSoapParameter*"/>
					<parameter name="prop_name" type="char*"/>
				</parameters>
			</method>
			<method name="get_string_value" symbol="soup_soap_parameter_get_string_value">
				<return-type type="char*"/>
				<parameters>
					<parameter name="param" type="SoupSoapParameter*"/>
				</parameters>
			</method>
		</struct>
		<struct name="SoupUri">
			<method name="copy" symbol="soup_uri_copy">
				<return-type type="SoupUri*"/>
				<parameters>
					<parameter name="uri" type="SoupUri*"/>
				</parameters>
			</method>
			<method name="copy_root" symbol="soup_uri_copy_root">
				<return-type type="SoupUri*"/>
				<parameters>
					<parameter name="uri" type="SoupUri*"/>
				</parameters>
			</method>
			<method name="decode" symbol="soup_uri_decode">
				<return-type type="void"/>
				<parameters>
					<parameter name="part" type="char*"/>
				</parameters>
			</method>
			<method name="encode" symbol="soup_uri_encode">
				<return-type type="char*"/>
				<parameters>
					<parameter name="part" type="char*"/>
					<parameter name="escape_extra" type="char*"/>
				</parameters>
			</method>
			<method name="equal" symbol="soup_uri_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="uri1" type="SoupUri*"/>
					<parameter name="uri2" type="SoupUri*"/>
				</parameters>
			</method>
			<method name="free" symbol="soup_uri_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="SoupUri*"/>
				</parameters>
			</method>
			<method name="new" symbol="soup_uri_new">
				<return-type type="SoupUri*"/>
				<parameters>
					<parameter name="uri_string" type="char*"/>
				</parameters>
			</method>
			<method name="new_with_base" symbol="soup_uri_new_with_base">
				<return-type type="SoupUri*"/>
				<parameters>
					<parameter name="base" type="SoupUri*"/>
					<parameter name="uri_string" type="char*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="soup_uri_to_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="uri" type="SoupUri*"/>
					<parameter name="just_path" type="gboolean"/>
				</parameters>
			</method>
			<method name="uses_default_port" symbol="soup_uri_uses_default_port">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="uri" type="SoupUri*"/>
				</parameters>
			</method>
			<field name="protocol" type="SoupProtocol"/>
			<field name="user" type="char*"/>
			<field name="passwd" type="char*"/>
			<field name="host" type="char*"/>
			<field name="port" type="guint"/>
			<field name="path" type="char*"/>
			<field name="query" type="char*"/>
			<field name="fragment" type="char*"/>
			<field name="broken_encoding" type="gboolean"/>
		</struct>
		<struct name="SoupXmlrpcValue">
			<method name="array_get_iterator" symbol="soup_xmlrpc_value_array_get_iterator">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="value" type="SoupXmlrpcValue*"/>
					<parameter name="iter" type="SoupXmlrpcValueArrayIterator**"/>
				</parameters>
			</method>
			<method name="dump" symbol="soup_xmlrpc_value_dump">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="SoupXmlrpcValue*"/>
				</parameters>
			</method>
			<method name="get_base64" symbol="soup_xmlrpc_value_get_base64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="value" type="SoupXmlrpcValue*"/>
					<parameter name="data" type="GByteArray**"/>
				</parameters>
			</method>
			<method name="get_boolean" symbol="soup_xmlrpc_value_get_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="value" type="SoupXmlrpcValue*"/>
					<parameter name="b" type="gboolean*"/>
				</parameters>
			</method>
			<method name="get_datetime" symbol="soup_xmlrpc_value_get_datetime">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="value" type="SoupXmlrpcValue*"/>
					<parameter name="timeval" type="time_t*"/>
				</parameters>
			</method>
			<method name="get_double" symbol="soup_xmlrpc_value_get_double">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="value" type="SoupXmlrpcValue*"/>
					<parameter name="b" type="double*"/>
				</parameters>
			</method>
			<method name="get_int" symbol="soup_xmlrpc_value_get_int">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="value" type="SoupXmlrpcValue*"/>
					<parameter name="i" type="long*"/>
				</parameters>
			</method>
			<method name="get_string" symbol="soup_xmlrpc_value_get_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="value" type="SoupXmlrpcValue*"/>
					<parameter name="str" type="char**"/>
				</parameters>
			</method>
			<method name="get_struct" symbol="soup_xmlrpc_value_get_struct">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="value" type="SoupXmlrpcValue*"/>
					<parameter name="table" type="GHashTable**"/>
				</parameters>
			</method>
		</struct>
		<struct name="SoupXmlrpcValueArrayIterator">
			<method name="get_value" symbol="soup_xmlrpc_value_array_iterator_get_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="SoupXmlrpcValueArrayIterator*"/>
					<parameter name="value" type="SoupXmlrpcValue**"/>
				</parameters>
			</method>
			<method name="next" symbol="soup_xmlrpc_value_array_iterator_next">
				<return-type type="SoupXmlrpcValueArrayIterator*"/>
				<parameters>
					<parameter name="iter" type="SoupXmlrpcValueArrayIterator*"/>
				</parameters>
			</method>
			<method name="prev" symbol="soup_xmlrpc_value_array_iterator_prev">
				<return-type type="SoupXmlrpcValueArrayIterator*"/>
				<parameters>
					<parameter name="iter" type="SoupXmlrpcValueArrayIterator*"/>
				</parameters>
			</method>
		</struct>
		<enum name="SoupAddressFamily">
			<member name="SOUP_ADDRESS_FAMILY_IPV4" value="2"/>
			<member name="SOUP_ADDRESS_FAMILY_IPV6" value="10"/>
		</enum>
		<enum name="SoupAuthType">
			<member name="SOUP_AUTH_TYPE_BASIC" value="1"/>
			<member name="SOUP_AUTH_TYPE_DIGEST" value="2"/>
		</enum>
		<enum name="SoupDigestAlgorithm">
			<member name="SOUP_ALGORITHM_MD5" value="1"/>
			<member name="SOUP_ALGORITHM_MD5_SESS" value="2"/>
		</enum>
		<enum name="SoupHandlerPhase">
			<member name="SOUP_HANDLER_POST_REQUEST" value="1"/>
			<member name="SOUP_HANDLER_PRE_BODY" value="2"/>
			<member name="SOUP_HANDLER_BODY_CHUNK" value="3"/>
			<member name="SOUP_HANDLER_POST_BODY" value="4"/>
		</enum>
		<enum name="SoupHttpVersion">
			<member name="SOUP_HTTP_1_0" value="0"/>
			<member name="SOUP_HTTP_1_1" value="1"/>
		</enum>
		<enum name="SoupKnownStatusCode">
			<member name="SOUP_STATUS_NONE" value="0"/>
			<member name="SOUP_STATUS_CANCELLED" value="1"/>
			<member name="SOUP_STATUS_CANT_RESOLVE" value="2"/>
			<member name="SOUP_STATUS_CANT_RESOLVE_PROXY" value="3"/>
			<member name="SOUP_STATUS_CANT_CONNECT" value="4"/>
			<member name="SOUP_STATUS_CANT_CONNECT_PROXY" value="5"/>
			<member name="SOUP_STATUS_SSL_FAILED" value="6"/>
			<member name="SOUP_STATUS_IO_ERROR" value="7"/>
			<member name="SOUP_STATUS_MALFORMED" value="8"/>
			<member name="SOUP_STATUS_TRY_AGAIN" value="9"/>
			<member name="SOUP_STATUS_CONTINUE" value="100"/>
			<member name="SOUP_STATUS_SWITCHING_PROTOCOLS" value="101"/>
			<member name="SOUP_STATUS_PROCESSING" value="102"/>
			<member name="SOUP_STATUS_OK" value="200"/>
			<member name="SOUP_STATUS_CREATED" value="201"/>
			<member name="SOUP_STATUS_ACCEPTED" value="202"/>
			<member name="SOUP_STATUS_NON_AUTHORITATIVE" value="203"/>
			<member name="SOUP_STATUS_NO_CONTENT" value="204"/>
			<member name="SOUP_STATUS_RESET_CONTENT" value="205"/>
			<member name="SOUP_STATUS_PARTIAL_CONTENT" value="206"/>
			<member name="SOUP_STATUS_MULTI_STATUS" value="207"/>
			<member name="SOUP_STATUS_MULTIPLE_CHOICES" value="300"/>
			<member name="SOUP_STATUS_MOVED_PERMANENTLY" value="301"/>
			<member name="SOUP_STATUS_FOUND" value="302"/>
			<member name="SOUP_STATUS_MOVED_TEMPORARILY" value="302"/>
			<member name="SOUP_STATUS_SEE_OTHER" value="303"/>
			<member name="SOUP_STATUS_NOT_MODIFIED" value="304"/>
			<member name="SOUP_STATUS_USE_PROXY" value="305"/>
			<member name="SOUP_STATUS_NOT_APPEARING_IN_THIS_PROTOCOL" value="306"/>
			<member name="SOUP_STATUS_TEMPORARY_REDIRECT" value="307"/>
			<member name="SOUP_STATUS_BAD_REQUEST" value="400"/>
			<member name="SOUP_STATUS_UNAUTHORIZED" value="401"/>
			<member name="SOUP_STATUS_PAYMENT_REQUIRED" value="402"/>
			<member name="SOUP_STATUS_FORBIDDEN" value="403"/>
			<member name="SOUP_STATUS_NOT_FOUND" value="404"/>
			<member name="SOUP_STATUS_METHOD_NOT_ALLOWED" value="405"/>
			<member name="SOUP_STATUS_NOT_ACCEPTABLE" value="406"/>
			<member name="SOUP_STATUS_PROXY_AUTHENTICATION_REQUIRED" value="407"/>
			<member name="SOUP_STATUS_PROXY_UNAUTHORIZED" value="407"/>
			<member name="SOUP_STATUS_REQUEST_TIMEOUT" value="408"/>
			<member name="SOUP_STATUS_CONFLICT" value="409"/>
			<member name="SOUP_STATUS_GONE" value="410"/>
			<member name="SOUP_STATUS_LENGTH_REQUIRED" value="411"/>
			<member name="SOUP_STATUS_PRECONDITION_FAILED" value="412"/>
			<member name="SOUP_STATUS_REQUEST_ENTITY_TOO_LARGE" value="413"/>
			<member name="SOUP_STATUS_REQUEST_URI_TOO_LONG" value="414"/>
			<member name="SOUP_STATUS_UNSUPPORTED_MEDIA_TYPE" value="415"/>
			<member name="SOUP_STATUS_REQUESTED_RANGE_NOT_SATISFIABLE" value="416"/>
			<member name="SOUP_STATUS_INVALID_RANGE" value="416"/>
			<member name="SOUP_STATUS_EXPECTATION_FAILED" value="417"/>
			<member name="SOUP_STATUS_UNPROCESSABLE_ENTITY" value="422"/>
			<member name="SOUP_STATUS_LOCKED" value="423"/>
			<member name="SOUP_STATUS_FAILED_DEPENDENCY" value="424"/>
			<member name="SOUP_STATUS_INTERNAL_SERVER_ERROR" value="500"/>
			<member name="SOUP_STATUS_NOT_IMPLEMENTED" value="501"/>
			<member name="SOUP_STATUS_BAD_GATEWAY" value="502"/>
			<member name="SOUP_STATUS_SERVICE_UNAVAILABLE" value="503"/>
			<member name="SOUP_STATUS_GATEWAY_TIMEOUT" value="504"/>
			<member name="SOUP_STATUS_HTTP_VERSION_NOT_SUPPORTED" value="505"/>
			<member name="SOUP_STATUS_INSUFFICIENT_STORAGE" value="507"/>
			<member name="SOUP_STATUS_NOT_EXTENDED" value="510"/>
		</enum>
		<enum name="SoupMessageFlags">
			<member name="SOUP_MESSAGE_NO_REDIRECT" value="2"/>
			<member name="SOUP_MESSAGE_OVERWRITE_CHUNKS" value="8"/>
			<member name="SOUP_MESSAGE_EXPECT_CONTINUE" value="16"/>
		</enum>
		<enum name="SoupMessageStatus">
			<member name="SOUP_MESSAGE_STATUS_IDLE" value="0"/>
			<member name="SOUP_MESSAGE_STATUS_QUEUED" value="1"/>
			<member name="SOUP_MESSAGE_STATUS_CONNECTING" value="2"/>
			<member name="SOUP_MESSAGE_STATUS_RUNNING" value="3"/>
			<member name="SOUP_MESSAGE_STATUS_FINISHED" value="4"/>
		</enum>
		<enum name="SoupMethodId">
			<member name="SOUP_METHOD_ID_UNKNOWN" value="0"/>
			<member name="SOUP_METHOD_ID_POST" value="1"/>
			<member name="SOUP_METHOD_ID_GET" value="2"/>
			<member name="SOUP_METHOD_ID_HEAD" value="3"/>
			<member name="SOUP_METHOD_ID_OPTIONS" value="4"/>
			<member name="SOUP_METHOD_ID_PUT" value="5"/>
			<member name="SOUP_METHOD_ID_MOVE" value="6"/>
			<member name="SOUP_METHOD_ID_COPY" value="7"/>
			<member name="SOUP_METHOD_ID_DELETE" value="8"/>
			<member name="SOUP_METHOD_ID_TRACE" value="9"/>
			<member name="SOUP_METHOD_ID_CONNECT" value="10"/>
			<member name="SOUP_METHOD_ID_MKCOL" value="11"/>
			<member name="SOUP_METHOD_ID_PROPPATCH" value="12"/>
			<member name="SOUP_METHOD_ID_PROPFIND" value="13"/>
			<member name="SOUP_METHOD_ID_PATCH" value="14"/>
			<member name="SOUP_METHOD_ID_LOCK" value="15"/>
			<member name="SOUP_METHOD_ID_UNLOCK" value="16"/>
		</enum>
		<enum name="SoupOwnership">
			<member name="SOUP_BUFFER_SYSTEM_OWNED" value="0"/>
			<member name="SOUP_BUFFER_USER_OWNED" value="1"/>
			<member name="SOUP_BUFFER_STATIC" value="2"/>
		</enum>
		<enum name="SoupSocketIOStatus">
			<member name="SOUP_SOCKET_OK" value="0"/>
			<member name="SOUP_SOCKET_WOULD_BLOCK" value="1"/>
			<member name="SOUP_SOCKET_EOF" value="2"/>
			<member name="SOUP_SOCKET_ERROR" value="3"/>
		</enum>
		<enum name="SoupStatusClass">
			<member name="SOUP_STATUS_CLASS_TRANSPORT_ERROR" value="0"/>
			<member name="SOUP_STATUS_CLASS_INFORMATIONAL" value="1"/>
			<member name="SOUP_STATUS_CLASS_SUCCESS" value="2"/>
			<member name="SOUP_STATUS_CLASS_REDIRECT" value="3"/>
			<member name="SOUP_STATUS_CLASS_CLIENT_ERROR" value="4"/>
			<member name="SOUP_STATUS_CLASS_SERVER_ERROR" value="5"/>
		</enum>
		<enum name="SoupTransferEncoding">
			<member name="SOUP_TRANSFER_UNKNOWN" value="0"/>
			<member name="SOUP_TRANSFER_CHUNKED" value="1"/>
			<member name="SOUP_TRANSFER_CONTENT_LENGTH" value="2"/>
			<member name="SOUP_TRANSFER_BYTERANGES" value="3"/>
			<member name="SOUP_TRANSFER_NONE" value="4"/>
			<member name="SOUP_TRANSFER_EOF" value="5"/>
		</enum>
		<enum name="SoupXmlrpcValueType">
			<member name="SOUP_XMLRPC_VALUE_TYPE_BAD" value="0"/>
			<member name="SOUP_XMLRPC_VALUE_TYPE_INT" value="1"/>
			<member name="SOUP_XMLRPC_VALUE_TYPE_BOOLEAN" value="2"/>
			<member name="SOUP_XMLRPC_VALUE_TYPE_STRING" value="3"/>
			<member name="SOUP_XMLRPC_VALUE_TYPE_DOUBLE" value="4"/>
			<member name="SOUP_XMLRPC_VALUE_TYPE_DATETIME" value="5"/>
			<member name="SOUP_XMLRPC_VALUE_TYPE_BASE64" value="6"/>
			<member name="SOUP_XMLRPC_VALUE_TYPE_STRUCT" value="7"/>
			<member name="SOUP_XMLRPC_VALUE_TYPE_ARRAY" value="8"/>
		</enum>
		<object name="SoupAddress" parent="GObject" type-name="SoupAddress" get-type="soup_address_get_type">
			<method name="get_name" symbol="soup_address_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="addr" type="SoupAddress*"/>
				</parameters>
			</method>
			<method name="get_physical" symbol="soup_address_get_physical">
				<return-type type="char*"/>
				<parameters>
					<parameter name="addr" type="SoupAddress*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="soup_address_get_port">
				<return-type type="guint"/>
				<parameters>
					<parameter name="addr" type="SoupAddress*"/>
				</parameters>
			</method>
			<method name="get_sockaddr" symbol="soup_address_get_sockaddr">
				<return-type type="struct sockaddr*"/>
				<parameters>
					<parameter name="addr" type="SoupAddress*"/>
					<parameter name="len" type="int*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_address_new">
				<return-type type="SoupAddress*"/>
				<parameters>
					<parameter name="name" type="char*"/>
					<parameter name="port" type="guint"/>
				</parameters>
			</constructor>
			<constructor name="new_any" symbol="soup_address_new_any">
				<return-type type="SoupAddress*"/>
				<parameters>
					<parameter name="family" type="SoupAddressFamily"/>
					<parameter name="port" type="guint"/>
				</parameters>
			</constructor>
			<constructor name="new_from_sockaddr" symbol="soup_address_new_from_sockaddr">
				<return-type type="SoupAddress*"/>
				<parameters>
					<parameter name="sa" type="struct sockaddr*"/>
					<parameter name="len" type="int"/>
				</parameters>
			</constructor>
			<method name="resolve_async" symbol="soup_address_resolve_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="addr" type="SoupAddress*"/>
					<parameter name="callback" type="SoupAddressCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="resolve_async_full" symbol="soup_address_resolve_async_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="addr" type="SoupAddress*"/>
					<parameter name="async_context" type="GMainContext*"/>
					<parameter name="callback" type="SoupAddressCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="resolve_sync" symbol="soup_address_resolve_sync">
				<return-type type="guint"/>
				<parameters>
					<parameter name="addr" type="SoupAddress*"/>
				</parameters>
			</method>
			<signal name="dns-result" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="addr" type="SoupAddress*"/>
					<parameter name="status" type="gint"/>
				</parameters>
			</signal>
		</object>
		<object name="SoupConnection" parent="GObject" type-name="SoupConnection" get-type="soup_connection_get_type">
			<method name="authenticate" symbol="soup_connection_authenticate">
				<return-type type="void"/>
				<parameters>
					<parameter name="conn" type="SoupConnection*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="auth_type" type="char*"/>
					<parameter name="auth_realm" type="char*"/>
					<parameter name="username" type="char**"/>
					<parameter name="password" type="char**"/>
				</parameters>
			</method>
			<method name="connect_async" symbol="soup_connection_connect_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="conn" type="SoupConnection*"/>
					<parameter name="callback" type="SoupConnectionCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="connect_sync" symbol="soup_connection_connect_sync">
				<return-type type="guint"/>
				<parameters>
					<parameter name="conn" type="SoupConnection*"/>
				</parameters>
			</method>
			<method name="disconnect" symbol="soup_connection_disconnect">
				<return-type type="void"/>
				<parameters>
					<parameter name="conn" type="SoupConnection*"/>
				</parameters>
			</method>
			<method name="is_in_use" symbol="soup_connection_is_in_use">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conn" type="SoupConnection*"/>
				</parameters>
			</method>
			<method name="last_used" symbol="soup_connection_last_used">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="conn" type="SoupConnection*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_connection_new">
				<return-type type="SoupConnection*"/>
				<parameters>
					<parameter name="propname1" type="char*"/>
				</parameters>
			</constructor>
			<method name="reauthenticate" symbol="soup_connection_reauthenticate">
				<return-type type="void"/>
				<parameters>
					<parameter name="conn" type="SoupConnection*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="auth_type" type="char*"/>
					<parameter name="auth_realm" type="char*"/>
					<parameter name="username" type="char**"/>
					<parameter name="password" type="char**"/>
				</parameters>
			</method>
			<method name="release" symbol="soup_connection_release">
				<return-type type="void"/>
				<parameters>
					<parameter name="conn" type="SoupConnection*"/>
				</parameters>
			</method>
			<method name="reserve" symbol="soup_connection_reserve">
				<return-type type="void"/>
				<parameters>
					<parameter name="conn" type="SoupConnection*"/>
				</parameters>
			</method>
			<method name="send_request" symbol="soup_connection_send_request">
				<return-type type="void"/>
				<parameters>
					<parameter name="conn" type="SoupConnection*"/>
					<parameter name="req" type="SoupMessage*"/>
				</parameters>
			</method>
			<property name="async-context" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="message-filter" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="origin-uri" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="proxy-uri" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="ssl-creds" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="timeout" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="authenticate" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupConnection*"/>
					<parameter name="p0" type="SoupMessage*"/>
					<parameter name="auth_type" type="char*"/>
					<parameter name="auth_realm" type="char*"/>
					<parameter name="username" type="gpointer"/>
					<parameter name="password" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="connect-result" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupConnection*"/>
					<parameter name="p0" type="gint"/>
				</parameters>
			</signal>
			<signal name="disconnected" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupConnection*"/>
				</parameters>
			</signal>
			<signal name="reauthenticate" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupConnection*"/>
					<parameter name="p0" type="SoupMessage*"/>
					<parameter name="auth_type" type="char*"/>
					<parameter name="auth_realm" type="char*"/>
					<parameter name="username" type="gpointer"/>
					<parameter name="password" type="gpointer"/>
				</parameters>
			</signal>
			<vfunc name="send_request">
				<return-type type="void"/>
				<parameters>
					<parameter name="p1" type="SoupConnection*"/>
					<parameter name="p2" type="SoupMessage*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="SoupMessage" parent="GObject" type-name="SoupMessage" get-type="soup_message_get_type">
			<method name="add_chunk" symbol="soup_message_add_chunk">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="owner" type="SoupOwnership"/>
					<parameter name="body" type="char*"/>
					<parameter name="length" type="guint"/>
				</parameters>
			</method>
			<method name="add_final_chunk" symbol="soup_message_add_final_chunk">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="add_handler" symbol="soup_message_add_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="phase" type="SoupHandlerPhase"/>
					<parameter name="handler_cb" type="SoupMessageCallbackFn"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="add_header" symbol="soup_message_add_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="hash" type="GHashTable*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="add_header_handler" symbol="soup_message_add_header_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="header" type="char*"/>
					<parameter name="phase" type="SoupHandlerPhase"/>
					<parameter name="handler_cb" type="SoupMessageCallbackFn"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="add_status_class_handler" symbol="soup_message_add_status_class_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="status_class" type="SoupStatusClass"/>
					<parameter name="phase" type="SoupHandlerPhase"/>
					<parameter name="handler_cb" type="SoupMessageCallbackFn"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="add_status_code_handler" symbol="soup_message_add_status_code_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="status_code" type="guint"/>
					<parameter name="phase" type="SoupHandlerPhase"/>
					<parameter name="handler_cb" type="SoupMessageCallbackFn"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="clear_headers" symbol="soup_message_clear_headers">
				<return-type type="void"/>
				<parameters>
					<parameter name="hash" type="GHashTable*"/>
				</parameters>
			</method>
			<method name="finished" symbol="soup_message_finished">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="foreach_header" symbol="soup_message_foreach_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="hash" type="GHashTable*"/>
					<parameter name="func" type="GHFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="soup_message_get_flags">
				<return-type type="guint"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="get_header" symbol="soup_message_get_header">
				<return-type type="char*"/>
				<parameters>
					<parameter name="hash" type="GHashTable*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_header_list" symbol="soup_message_get_header_list">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="hash" type="GHashTable*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_http_version" symbol="soup_message_get_http_version">
				<return-type type="SoupHttpVersion"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="get_request_encoding" symbol="soup_message_get_request_encoding">
				<return-type type="SoupTransferEncoding"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="content_length" type="guint*"/>
				</parameters>
			</method>
			<method name="get_response_encoding" symbol="soup_message_get_response_encoding">
				<return-type type="SoupTransferEncoding"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="content_length" type="guint*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="soup_message_get_uri">
				<return-type type="SoupUri*"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="got_body" symbol="soup_message_got_body">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="got_chunk" symbol="soup_message_got_chunk">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="got_headers" symbol="soup_message_got_headers">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="got_informational" symbol="soup_message_got_informational">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="io_in_progress" symbol="soup_message_io_in_progress">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="io_pause" symbol="soup_message_io_pause">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="io_stop" symbol="soup_message_io_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="io_unpause" symbol="soup_message_io_unpause">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="is_keepalive" symbol="soup_message_is_keepalive">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_message_new">
				<return-type type="SoupMessage*"/>
				<parameters>
					<parameter name="method" type="char*"/>
					<parameter name="uri_string" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_uri" symbol="soup_message_new_from_uri">
				<return-type type="SoupMessage*"/>
				<parameters>
					<parameter name="method" type="char*"/>
					<parameter name="uri" type="SoupUri*"/>
				</parameters>
			</constructor>
			<method name="pop_chunk" symbol="soup_message_pop_chunk">
				<return-type type="SoupDataBuffer*"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="read_request" symbol="soup_message_read_request">
				<return-type type="void"/>
				<parameters>
					<parameter name="req" type="SoupMessage*"/>
					<parameter name="sock" type="SoupSocket*"/>
				</parameters>
			</method>
			<method name="remove_handler" symbol="soup_message_remove_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="phase" type="SoupHandlerPhase"/>
					<parameter name="handler_cb" type="SoupMessageCallbackFn"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="remove_header" symbol="soup_message_remove_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="hash" type="GHashTable*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="restarted" symbol="soup_message_restarted">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="send_request" symbol="soup_message_send_request">
				<return-type type="void"/>
				<parameters>
					<parameter name="req" type="SoupMessage*"/>
					<parameter name="sock" type="SoupSocket*"/>
					<parameter name="is_via_proxy" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_flags" symbol="soup_message_set_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="flags" type="guint"/>
				</parameters>
			</method>
			<method name="set_http_version" symbol="soup_message_set_http_version">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="version" type="SoupHttpVersion"/>
				</parameters>
			</method>
			<method name="set_request" symbol="soup_message_set_request">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="req_owner" type="SoupOwnership"/>
					<parameter name="req_body" type="char*"/>
					<parameter name="req_length" type="gulong"/>
				</parameters>
			</method>
			<method name="set_response" symbol="soup_message_set_response">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="resp_owner" type="SoupOwnership"/>
					<parameter name="resp_body" type="char*"/>
					<parameter name="resp_length" type="gulong"/>
				</parameters>
			</method>
			<method name="set_status" symbol="soup_message_set_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="status_code" type="guint"/>
				</parameters>
			</method>
			<method name="set_status_full" symbol="soup_message_set_status_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="status_code" type="guint"/>
					<parameter name="reason_phrase" type="char*"/>
				</parameters>
			</method>
			<method name="set_uri" symbol="soup_message_set_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="uri" type="SoupUri*"/>
				</parameters>
			</method>
			<method name="wrote_body" symbol="soup_message_wrote_body">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="wrote_chunk" symbol="soup_message_wrote_chunk">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="wrote_headers" symbol="soup_message_wrote_headers">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="wrote_informational" symbol="soup_message_wrote_informational">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<signal name="finished" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</signal>
			<signal name="got-body" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</signal>
			<signal name="got-chunk" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</signal>
			<signal name="got-headers" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</signal>
			<signal name="got-informational" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</signal>
			<signal name="restarted" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</signal>
			<signal name="wrote-body" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</signal>
			<signal name="wrote-chunk" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</signal>
			<signal name="wrote-headers" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</signal>
			<signal name="wrote-informational" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</signal>
			<field name="method" type="char*"/>
			<field name="status_code" type="guint"/>
			<field name="reason_phrase" type="char*"/>
			<field name="request" type="SoupDataBuffer"/>
			<field name="request_headers" type="GHashTable*"/>
			<field name="response" type="SoupDataBuffer"/>
			<field name="response_headers" type="GHashTable*"/>
			<field name="status" type="SoupMessageStatus"/>
		</object>
		<object name="SoupServer" parent="GObject" type-name="SoupServer" get-type="soup_server_get_type">
			<method name="add_handler" symbol="soup_server_add_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="serv" type="SoupServer*"/>
					<parameter name="path" type="char*"/>
					<parameter name="auth_ctx" type="SoupServerAuthContext*"/>
					<parameter name="callback" type="SoupServerCallbackFn"/>
					<parameter name="unreg" type="SoupServerUnregisterFn"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_async_context" symbol="soup_server_get_async_context">
				<return-type type="GMainContext*"/>
				<parameters>
					<parameter name="serv" type="SoupServer*"/>
				</parameters>
			</method>
			<method name="get_handler" symbol="soup_server_get_handler">
				<return-type type="SoupServerHandler*"/>
				<parameters>
					<parameter name="serv" type="SoupServer*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="get_listener" symbol="soup_server_get_listener">
				<return-type type="SoupSocket*"/>
				<parameters>
					<parameter name="serv" type="SoupServer*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="soup_server_get_port">
				<return-type type="guint"/>
				<parameters>
					<parameter name="serv" type="SoupServer*"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="soup_server_get_protocol">
				<return-type type="SoupProtocol"/>
				<parameters>
					<parameter name="serv" type="SoupServer*"/>
				</parameters>
			</method>
			<method name="list_handlers" symbol="soup_server_list_handlers">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="serv" type="SoupServer*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_server_new">
				<return-type type="SoupServer*"/>
				<parameters>
					<parameter name="optname1" type="char*"/>
				</parameters>
			</constructor>
			<method name="quit" symbol="soup_server_quit">
				<return-type type="void"/>
				<parameters>
					<parameter name="serv" type="SoupServer*"/>
				</parameters>
			</method>
			<method name="remove_handler" symbol="soup_server_remove_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="serv" type="SoupServer*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="run" symbol="soup_server_run">
				<return-type type="void"/>
				<parameters>
					<parameter name="serv" type="SoupServer*"/>
				</parameters>
			</method>
			<method name="run_async" symbol="soup_server_run_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="serv" type="SoupServer*"/>
				</parameters>
			</method>
			<property name="async-context" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="interface" type="SoupAddress*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="port" type="guint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="ssl-cert-file" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="ssl-key-file" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="SoupServerMessage" parent="SoupMessage" type-name="SoupServerMessage" get-type="soup_server_message_get_type">
			<method name="finish" symbol="soup_server_message_finish">
				<return-type type="void"/>
				<parameters>
					<parameter name="smsg" type="SoupServerMessage*"/>
				</parameters>
			</method>
			<method name="get_encoding" symbol="soup_server_message_get_encoding">
				<return-type type="SoupTransferEncoding"/>
				<parameters>
					<parameter name="smsg" type="SoupServerMessage*"/>
				</parameters>
			</method>
			<method name="get_server" symbol="soup_server_message_get_server">
				<return-type type="SoupServer*"/>
				<parameters>
					<parameter name="smsg" type="SoupServerMessage*"/>
				</parameters>
			</method>
			<method name="is_finished" symbol="soup_server_message_is_finished">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="smsg" type="SoupServerMessage*"/>
				</parameters>
			</method>
			<method name="is_started" symbol="soup_server_message_is_started">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="smsg" type="SoupServerMessage*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_server_message_new">
				<return-type type="SoupServerMessage*"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
				</parameters>
			</constructor>
			<method name="set_encoding" symbol="soup_server_message_set_encoding">
				<return-type type="void"/>
				<parameters>
					<parameter name="smsg" type="SoupServerMessage*"/>
					<parameter name="encoding" type="SoupTransferEncoding"/>
				</parameters>
			</method>
			<method name="start" symbol="soup_server_message_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="smsg" type="SoupServerMessage*"/>
				</parameters>
			</method>
		</object>
		<object name="SoupSession" parent="GObject" type-name="SoupSession" get-type="soup_session_get_type">
			<implements>
				<interface name="SoupMessageFilter"/>
			</implements>
			<method name="abort" symbol="soup_session_abort">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
				</parameters>
			</method>
			<method name="add_filter" symbol="soup_session_add_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="filter" type="SoupMessageFilter*"/>
				</parameters>
			</method>
			<method name="cancel_message" symbol="soup_session_cancel_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="get_async_context" symbol="soup_session_get_async_context">
				<return-type type="GMainContext*"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
				</parameters>
			</method>
			<method name="get_connection" symbol="soup_session_get_connection">
				<return-type type="SoupConnection*"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="try_pruning" type="gboolean*"/>
					<parameter name="is_new" type="gboolean*"/>
				</parameters>
			</method>
			<method name="queue_message" symbol="soup_session_queue_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="callback" type="SoupMessageCallbackFn"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="remove_filter" symbol="soup_session_remove_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="filter" type="SoupMessageFilter*"/>
				</parameters>
			</method>
			<method name="requeue_message" symbol="soup_session_requeue_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="send_message" symbol="soup_session_send_message">
				<return-type type="guint"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="try_prune_connection" symbol="soup_session_try_prune_connection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
				</parameters>
			</method>
			<property name="async-context" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="max-conns" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-conns-per-host" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="proxy-uri" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ssl-ca-file" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="timeout" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-ntlm" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="authenticate" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupSession*"/>
					<parameter name="p0" type="SoupMessage*"/>
					<parameter name="auth_type" type="char*"/>
					<parameter name="auth_realm" type="char*"/>
					<parameter name="username" type="gpointer"/>
					<parameter name="password" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="reauthenticate" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupSession*"/>
					<parameter name="p0" type="SoupMessage*"/>
					<parameter name="auth_type" type="char*"/>
					<parameter name="auth_realm" type="char*"/>
					<parameter name="username" type="gpointer"/>
					<parameter name="password" type="gpointer"/>
				</parameters>
			</signal>
			<vfunc name="cancel_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="queue_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="callback" type="SoupMessageCallbackFn"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="requeue_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="send_message">
				<return-type type="guint"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</vfunc>
			<field name="queue" type="SoupMessageQueue*"/>
		</object>
		<object name="SoupSessionAsync" parent="SoupSession" type-name="SoupSessionAsync" get-type="soup_session_async_get_type">
			<implements>
				<interface name="SoupMessageFilter"/>
			</implements>
			<constructor name="new" symbol="soup_session_async_new">
				<return-type type="SoupSession*"/>
			</constructor>
			<constructor name="new_with_options" symbol="soup_session_async_new_with_options">
				<return-type type="SoupSession*"/>
				<parameters>
					<parameter name="optname1" type="char*"/>
				</parameters>
			</constructor>
		</object>
		<object name="SoupSessionSync" parent="SoupSession" type-name="SoupSessionSync" get-type="soup_session_sync_get_type">
			<implements>
				<interface name="SoupMessageFilter"/>
			</implements>
			<constructor name="new" symbol="soup_session_sync_new">
				<return-type type="SoupSession*"/>
			</constructor>
			<constructor name="new_with_options" symbol="soup_session_sync_new_with_options">
				<return-type type="SoupSession*"/>
				<parameters>
					<parameter name="optname1" type="char*"/>
				</parameters>
			</constructor>
		</object>
		<object name="SoupSoapMessage" parent="SoupMessage" type-name="SoupSoapMessage" get-type="soup_soap_message_get_type">
			<method name="add_attribute" symbol="soup_soap_message_add_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="char*"/>
					<parameter name="prefix" type="char*"/>
					<parameter name="ns_uri" type="char*"/>
				</parameters>
			</method>
			<method name="add_namespace" symbol="soup_soap_message_add_namespace">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="prefix" type="char*"/>
					<parameter name="ns_uri" type="char*"/>
				</parameters>
			</method>
			<method name="end_body" symbol="soup_soap_message_end_body">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="end_element" symbol="soup_soap_message_end_element">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="end_envelope" symbol="soup_soap_message_end_envelope">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="end_fault" symbol="soup_soap_message_end_fault">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="end_fault_detail" symbol="soup_soap_message_end_fault_detail">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="end_header" symbol="soup_soap_message_end_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="end_header_element" symbol="soup_soap_message_end_header_element">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="get_namespace_prefix" symbol="soup_soap_message_get_namespace_prefix">
				<return-type type="char*"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="ns_uri" type="char*"/>
				</parameters>
			</method>
			<method name="get_xml_doc" symbol="soup_soap_message_get_xml_doc">
				<return-type type="xmlDocPtr"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_soap_message_new">
				<return-type type="SoupSoapMessage*"/>
				<parameters>
					<parameter name="method" type="char*"/>
					<parameter name="uri_string" type="char*"/>
					<parameter name="standalone" type="gboolean"/>
					<parameter name="xml_encoding" type="char*"/>
					<parameter name="env_prefix" type="char*"/>
					<parameter name="env_uri" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_uri" symbol="soup_soap_message_new_from_uri">
				<return-type type="SoupSoapMessage*"/>
				<parameters>
					<parameter name="method" type="char*"/>
					<parameter name="uri" type="SoupUri*"/>
					<parameter name="standalone" type="gboolean"/>
					<parameter name="xml_encoding" type="char*"/>
					<parameter name="env_prefix" type="char*"/>
					<parameter name="env_uri" type="char*"/>
				</parameters>
			</constructor>
			<method name="parse_response" symbol="soup_soap_message_parse_response">
				<return-type type="SoupSoapResponse*"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="persist" symbol="soup_soap_message_persist">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="reset" symbol="soup_soap_message_reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="set_default_namespace" symbol="soup_soap_message_set_default_namespace">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="ns_uri" type="char*"/>
				</parameters>
			</method>
			<method name="set_element_type" symbol="soup_soap_message_set_element_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="xsi_type" type="char*"/>
				</parameters>
			</method>
			<method name="set_encoding_style" symbol="soup_soap_message_set_encoding_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="enc_style" type="char*"/>
				</parameters>
			</method>
			<method name="set_null" symbol="soup_soap_message_set_null">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="start_body" symbol="soup_soap_message_start_body">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="start_element" symbol="soup_soap_message_start_element">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="name" type="char*"/>
					<parameter name="prefix" type="char*"/>
					<parameter name="ns_uri" type="char*"/>
				</parameters>
			</method>
			<method name="start_envelope" symbol="soup_soap_message_start_envelope">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="start_fault" symbol="soup_soap_message_start_fault">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="faultcode" type="char*"/>
					<parameter name="faultstring" type="char*"/>
					<parameter name="faultfactor" type="char*"/>
				</parameters>
			</method>
			<method name="start_fault_detail" symbol="soup_soap_message_start_fault_detail">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="start_header" symbol="soup_soap_message_start_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
				</parameters>
			</method>
			<method name="start_header_element" symbol="soup_soap_message_start_header_element">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="name" type="char*"/>
					<parameter name="must_understand" type="gboolean"/>
					<parameter name="actor_uri" type="char*"/>
					<parameter name="prefix" type="char*"/>
					<parameter name="ns_uri" type="char*"/>
				</parameters>
			</method>
			<method name="write_base64" symbol="soup_soap_message_write_base64">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="string" type="char*"/>
					<parameter name="len" type="int"/>
				</parameters>
			</method>
			<method name="write_buffer" symbol="soup_soap_message_write_buffer">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="buffer" type="char*"/>
					<parameter name="len" type="int"/>
				</parameters>
			</method>
			<method name="write_double" symbol="soup_soap_message_write_double">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="d" type="double"/>
				</parameters>
			</method>
			<method name="write_int" symbol="soup_soap_message_write_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="i" type="glong"/>
				</parameters>
			</method>
			<method name="write_string" symbol="soup_soap_message_write_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="string" type="char*"/>
				</parameters>
			</method>
			<method name="write_time" symbol="soup_soap_message_write_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupSoapMessage*"/>
					<parameter name="timeval" type="time_t*"/>
				</parameters>
			</method>
		</object>
		<object name="SoupSoapResponse" parent="GObject" type-name="SoupSoapResponse" get-type="soup_soap_response_get_type">
			<method name="from_string" symbol="soup_soap_response_from_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="response" type="SoupSoapResponse*"/>
					<parameter name="xmlstr" type="char*"/>
				</parameters>
			</method>
			<method name="get_first_parameter" symbol="soup_soap_response_get_first_parameter">
				<return-type type="SoupSoapParameter*"/>
				<parameters>
					<parameter name="response" type="SoupSoapResponse*"/>
				</parameters>
			</method>
			<method name="get_first_parameter_by_name" symbol="soup_soap_response_get_first_parameter_by_name">
				<return-type type="SoupSoapParameter*"/>
				<parameters>
					<parameter name="response" type="SoupSoapResponse*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_method_name" symbol="soup_soap_response_get_method_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="response" type="SoupSoapResponse*"/>
				</parameters>
			</method>
			<method name="get_next_parameter" symbol="soup_soap_response_get_next_parameter">
				<return-type type="SoupSoapParameter*"/>
				<parameters>
					<parameter name="response" type="SoupSoapResponse*"/>
					<parameter name="from" type="SoupSoapParameter*"/>
				</parameters>
			</method>
			<method name="get_next_parameter_by_name" symbol="soup_soap_response_get_next_parameter_by_name">
				<return-type type="SoupSoapParameter*"/>
				<parameters>
					<parameter name="response" type="SoupSoapResponse*"/>
					<parameter name="from" type="SoupSoapParameter*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_parameters" symbol="soup_soap_response_get_parameters">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="response" type="SoupSoapResponse*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_soap_response_new">
				<return-type type="SoupSoapResponse*"/>
			</constructor>
			<constructor name="new_from_string" symbol="soup_soap_response_new_from_string">
				<return-type type="SoupSoapResponse*"/>
				<parameters>
					<parameter name="xmlstr" type="char*"/>
				</parameters>
			</constructor>
			<method name="set_method_name" symbol="soup_soap_response_set_method_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="response" type="SoupSoapResponse*"/>
					<parameter name="method_name" type="char*"/>
				</parameters>
			</method>
		</object>
		<object name="SoupSocket" parent="GObject" type-name="SoupSocket" get-type="soup_socket_get_type">
			<method name="client_new_async" symbol="soup_socket_client_new_async">
				<return-type type="SoupSocket*"/>
				<parameters>
					<parameter name="hostname" type="char*"/>
					<parameter name="port" type="guint"/>
					<parameter name="ssl_creds" type="gpointer"/>
					<parameter name="callback" type="SoupSocketCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="client_new_sync" symbol="soup_socket_client_new_sync">
				<return-type type="SoupSocket*"/>
				<parameters>
					<parameter name="hostname" type="char*"/>
					<parameter name="port" type="guint"/>
					<parameter name="ssl_creds" type="gpointer"/>
					<parameter name="status_ret" type="guint*"/>
				</parameters>
			</method>
			<method name="connect" symbol="soup_socket_connect">
				<return-type type="guint"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
					<parameter name="remote_addr" type="SoupAddress*"/>
				</parameters>
			</method>
			<method name="disconnect" symbol="soup_socket_disconnect">
				<return-type type="void"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
				</parameters>
			</method>
			<method name="get_local_address" symbol="soup_socket_get_local_address">
				<return-type type="SoupAddress*"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
				</parameters>
			</method>
			<method name="get_remote_address" symbol="soup_socket_get_remote_address">
				<return-type type="SoupAddress*"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
				</parameters>
			</method>
			<method name="is_connected" symbol="soup_socket_is_connected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
				</parameters>
			</method>
			<method name="listen" symbol="soup_socket_listen">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
					<parameter name="local_addr" type="SoupAddress*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_socket_new">
				<return-type type="SoupSocket*"/>
				<parameters>
					<parameter name="optname1" type="char*"/>
				</parameters>
			</constructor>
			<method name="read" symbol="soup_socket_read">
				<return-type type="SoupSocketIOStatus"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
					<parameter name="buffer" type="gpointer"/>
					<parameter name="len" type="gsize"/>
					<parameter name="nread" type="gsize*"/>
				</parameters>
			</method>
			<method name="read_until" symbol="soup_socket_read_until">
				<return-type type="SoupSocketIOStatus"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
					<parameter name="buffer" type="gpointer"/>
					<parameter name="len" type="gsize"/>
					<parameter name="boundary" type="gconstpointer"/>
					<parameter name="boundary_len" type="gsize"/>
					<parameter name="nread" type="gsize*"/>
					<parameter name="got_boundary" type="gboolean*"/>
				</parameters>
			</method>
			<method name="server_new" symbol="soup_socket_server_new">
				<return-type type="SoupSocket*"/>
				<parameters>
					<parameter name="local_addr" type="SoupAddress*"/>
					<parameter name="ssl_creds" type="gpointer"/>
					<parameter name="callback" type="SoupSocketListenerCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="start_proxy_ssl" symbol="soup_socket_start_proxy_ssl">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
					<parameter name="ssl_host" type="char*"/>
				</parameters>
			</method>
			<method name="start_ssl" symbol="soup_socket_start_ssl">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
				</parameters>
			</method>
			<method name="write" symbol="soup_socket_write">
				<return-type type="SoupSocketIOStatus"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
					<parameter name="buffer" type="gconstpointer"/>
					<parameter name="len" type="gsize"/>
					<parameter name="nwrote" type="gsize*"/>
				</parameters>
			</method>
			<property name="async-context" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="cloexec" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-server" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="nodelay" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="non-blocking" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="reuseaddr" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ssl-creds" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="timeout" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="connect-result" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupSocket*"/>
					<parameter name="p0" type="gint"/>
				</parameters>
			</signal>
			<signal name="disconnected" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupSocket*"/>
				</parameters>
			</signal>
			<signal name="new-connection" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupSocket*"/>
					<parameter name="p0" type="SoupSocket*"/>
				</parameters>
			</signal>
			<signal name="readable" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupSocket*"/>
				</parameters>
			</signal>
			<signal name="writable" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupSocket*"/>
				</parameters>
			</signal>
		</object>
		<object name="SoupXmlrpcMessage" parent="SoupMessage" type-name="SoupXmlrpcMessage" get-type="soup_xmlrpc_message_get_type">
			<method name="end_array" symbol="soup_xmlrpc_message_end_array">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
				</parameters>
			</method>
			<method name="end_call" symbol="soup_xmlrpc_message_end_call">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
				</parameters>
			</method>
			<method name="end_member" symbol="soup_xmlrpc_message_end_member">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
				</parameters>
			</method>
			<method name="end_param" symbol="soup_xmlrpc_message_end_param">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
				</parameters>
			</method>
			<method name="end_struct" symbol="soup_xmlrpc_message_end_struct">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
				</parameters>
			</method>
			<method name="from_string" symbol="soup_xmlrpc_message_from_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="message" type="SoupXmlrpcMessage*"/>
					<parameter name="xmlstr" type="char*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_xmlrpc_message_new">
				<return-type type="SoupXmlrpcMessage*"/>
				<parameters>
					<parameter name="uri_string" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_uri" symbol="soup_xmlrpc_message_new_from_uri">
				<return-type type="SoupXmlrpcMessage*"/>
				<parameters>
					<parameter name="uri" type="SoupUri*"/>
				</parameters>
			</constructor>
			<method name="parse_response" symbol="soup_xmlrpc_message_parse_response">
				<return-type type="SoupXmlrpcResponse*"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
				</parameters>
			</method>
			<method name="persist" symbol="soup_xmlrpc_message_persist">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
				</parameters>
			</method>
			<method name="start_array" symbol="soup_xmlrpc_message_start_array">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
				</parameters>
			</method>
			<method name="start_call" symbol="soup_xmlrpc_message_start_call">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
					<parameter name="method_name" type="char*"/>
				</parameters>
			</method>
			<method name="start_member" symbol="soup_xmlrpc_message_start_member">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="start_param" symbol="soup_xmlrpc_message_start_param">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
				</parameters>
			</method>
			<method name="start_struct" symbol="soup_xmlrpc_message_start_struct">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="soup_xmlrpc_message_to_string">
				<return-type type="xmlChar*"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
				</parameters>
			</method>
			<method name="write_base64" symbol="soup_xmlrpc_message_write_base64">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
					<parameter name="buf" type="gconstpointer"/>
					<parameter name="len" type="int"/>
				</parameters>
			</method>
			<method name="write_boolean" symbol="soup_xmlrpc_message_write_boolean">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
					<parameter name="b" type="gboolean"/>
				</parameters>
			</method>
			<method name="write_datetime" symbol="soup_xmlrpc_message_write_datetime">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
					<parameter name="timeval" type="time_t"/>
				</parameters>
			</method>
			<method name="write_double" symbol="soup_xmlrpc_message_write_double">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
					<parameter name="d" type="double"/>
				</parameters>
			</method>
			<method name="write_int" symbol="soup_xmlrpc_message_write_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
					<parameter name="i" type="long"/>
				</parameters>
			</method>
			<method name="write_string" symbol="soup_xmlrpc_message_write_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupXmlrpcMessage*"/>
					<parameter name="str" type="char*"/>
				</parameters>
			</method>
		</object>
		<object name="SoupXmlrpcResponse" parent="GObject" type-name="SoupXmlrpcResponse" get-type="soup_xmlrpc_response_get_type">
			<method name="from_string" symbol="soup_xmlrpc_response_from_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="response" type="SoupXmlrpcResponse*"/>
					<parameter name="xmlstr" type="char*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="soup_xmlrpc_response_get_value">
				<return-type type="SoupXmlrpcValue*"/>
				<parameters>
					<parameter name="response" type="SoupXmlrpcResponse*"/>
				</parameters>
			</method>
			<method name="is_fault" symbol="soup_xmlrpc_response_is_fault">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="response" type="SoupXmlrpcResponse*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_xmlrpc_response_new">
				<return-type type="SoupXmlrpcResponse*"/>
			</constructor>
			<constructor name="new_from_string" symbol="soup_xmlrpc_response_new_from_string">
				<return-type type="SoupXmlrpcResponse*"/>
				<parameters>
					<parameter name="xmlstr" type="char*"/>
				</parameters>
			</constructor>
			<method name="to_string" symbol="soup_xmlrpc_response_to_string">
				<return-type type="xmlChar*"/>
				<parameters>
					<parameter name="response" type="SoupXmlrpcResponse*"/>
				</parameters>
			</method>
		</object>
		<interface name="SoupMessageFilter" type-name="SoupMessageFilter" get-type="soup_message_filter_get_type">
			<method name="setup_message" symbol="soup_message_filter_setup_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="filter" type="SoupMessageFilter*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<vfunc name="setup_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="filter" type="SoupMessageFilter*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="SOUP_ADDRESS_ANY_PORT" type="int" value="0"/>
		<constant name="SOUP_CONNECTION_ASYNC_CONTEXT" type="char*" value="async-context"/>
		<constant name="SOUP_CONNECTION_H" type="int" value="1"/>
		<constant name="SOUP_CONNECTION_MESSAGE_FILTER" type="char*" value="message-filter"/>
		<constant name="SOUP_CONNECTION_ORIGIN_URI" type="char*" value="origin-uri"/>
		<constant name="SOUP_CONNECTION_PROXY_URI" type="char*" value="proxy-uri"/>
		<constant name="SOUP_CONNECTION_SSL_CREDENTIALS" type="char*" value="ssl-creds"/>
		<constant name="SOUP_CONNECTION_TIMEOUT" type="char*" value="timeout"/>
		<constant name="SOUP_DATE_H" type="int" value="1"/>
		<constant name="SOUP_H" type="int" value="1"/>
		<constant name="SOUP_HEADERS_H" type="int" value="1"/>
		<constant name="SOUP_MESSAGE_FILTER_H" type="int" value="1"/>
		<constant name="SOUP_MESSAGE_H" type="int" value="1"/>
		<constant name="SOUP_MESSAGE_QUEUE_H" type="int" value="1"/>
		<constant name="SOUP_METHOD_CONNECT" type="char*" value="CONNECT"/>
		<constant name="SOUP_METHOD_COPY" type="char*" value="COPY"/>
		<constant name="SOUP_METHOD_DELETE" type="char*" value="DELETE"/>
		<constant name="SOUP_METHOD_GET" type="char*" value="GET"/>
		<constant name="SOUP_METHOD_H" type="int" value="1"/>
		<constant name="SOUP_METHOD_HEAD" type="char*" value="HEAD"/>
		<constant name="SOUP_METHOD_LOCK" type="char*" value="LOCK"/>
		<constant name="SOUP_METHOD_MKCOL" type="char*" value="MKCOL"/>
		<constant name="SOUP_METHOD_MOVE" type="char*" value="MOVE"/>
		<constant name="SOUP_METHOD_OPTIONS" type="char*" value="OPTIONS"/>
		<constant name="SOUP_METHOD_PATCH" type="char*" value="PATCH"/>
		<constant name="SOUP_METHOD_POST" type="char*" value="POST"/>
		<constant name="SOUP_METHOD_PROPFIND" type="char*" value="PROPFIND"/>
		<constant name="SOUP_METHOD_PROPPATCH" type="char*" value="PROPPATCH"/>
		<constant name="SOUP_METHOD_PUT" type="char*" value="PUT"/>
		<constant name="SOUP_METHOD_TRACE" type="char*" value="TRACE"/>
		<constant name="SOUP_METHOD_UNLOCK" type="char*" value="UNLOCK"/>
		<constant name="SOUP_MISC_H" type="int" value="1"/>
		<constant name="SOUP_SERVER_ASYNC_CONTEXT" type="char*" value="async-context"/>
		<constant name="SOUP_SERVER_AUTH_H" type="int" value="1"/>
		<constant name="SOUP_SERVER_H" type="int" value="1"/>
		<constant name="SOUP_SERVER_INTERFACE" type="char*" value="interface"/>
		<constant name="SOUP_SERVER_MESSAGE_H" type="int" value="1"/>
		<constant name="SOUP_SERVER_PORT" type="char*" value="port"/>
		<constant name="SOUP_SERVER_SSL_CERT_FILE" type="char*" value="ssl-cert-file"/>
		<constant name="SOUP_SERVER_SSL_KEY_FILE" type="char*" value="ssl-key-file"/>
		<constant name="SOUP_SESSION_ASYNC_CONTEXT" type="char*" value="async-context"/>
		<constant name="SOUP_SESSION_ASYNC_H" type="int" value="1"/>
		<constant name="SOUP_SESSION_H" type="int" value="1"/>
		<constant name="SOUP_SESSION_MAX_CONNS" type="char*" value="max-conns"/>
		<constant name="SOUP_SESSION_MAX_CONNS_PER_HOST" type="char*" value="max-conns-per-host"/>
		<constant name="SOUP_SESSION_PROXY_URI" type="char*" value="proxy-uri"/>
		<constant name="SOUP_SESSION_SSL_CA_FILE" type="char*" value="ssl-ca-file"/>
		<constant name="SOUP_SESSION_SYNC_H" type="int" value="1"/>
		<constant name="SOUP_SESSION_TIMEOUT" type="char*" value="timeout"/>
		<constant name="SOUP_SESSION_USE_NTLM" type="char*" value="use-ntlm"/>
		<constant name="SOUP_SOAP_MESSAGE_H" type="int" value="1"/>
		<constant name="SOUP_SOCKET_ASYNC_CONTEXT" type="char*" value="async-context"/>
		<constant name="SOUP_SOCKET_FLAG_CLOEXEC" type="char*" value="cloexec"/>
		<constant name="SOUP_SOCKET_FLAG_NODELAY" type="char*" value="nodelay"/>
		<constant name="SOUP_SOCKET_FLAG_NONBLOCKING" type="char*" value="non-blocking"/>
		<constant name="SOUP_SOCKET_FLAG_REUSEADDR" type="char*" value="reuseaddr"/>
		<constant name="SOUP_SOCKET_H" type="int" value="1"/>
		<constant name="SOUP_SOCKET_IS_SERVER" type="char*" value="is-server"/>
		<constant name="SOUP_SOCKET_SSL_CREDENTIALS" type="char*" value="ssl-creds"/>
		<constant name="SOUP_SOCKET_TIMEOUT" type="char*" value="timeout"/>
		<constant name="SOUP_STATUS_H" type="int" value="1"/>
		<constant name="SOUP_TYPES_H" type="int" value="1"/>
		<constant name="SOUP_URI_H" type="int" value="1"/>
		<union name="SoupServerAuth">
			<method name="check_passwd" symbol="soup_server_auth_check_passwd">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="auth" type="SoupServerAuth*"/>
					<parameter name="passwd" type="gchar*"/>
				</parameters>
			</method>
			<method name="free" symbol="soup_server_auth_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="auth" type="SoupServerAuth*"/>
				</parameters>
			</method>
			<method name="get_user" symbol="soup_server_auth_get_user">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="auth" type="SoupServerAuth*"/>
				</parameters>
			</method>
			<method name="new" symbol="soup_server_auth_new">
				<return-type type="SoupServerAuth*"/>
				<parameters>
					<parameter name="auth_ctx" type="SoupServerAuthContext*"/>
					<parameter name="auth_hdrs" type="GSList*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<field name="type" type="SoupAuthType"/>
			<field name="basic" type="SoupServerAuthBasic"/>
			<field name="digest" type="SoupServerAuthDigest"/>
		</union>
	</namespace>
</api>
