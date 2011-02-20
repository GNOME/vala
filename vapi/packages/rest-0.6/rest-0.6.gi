<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Rest">
		<callback name="OAuthProxyAuthCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="proxy" type="OAuthProxy*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="weak_object" type="GObject*"/>
				<parameter name="userdata" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="RestProxyCallAsyncCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="call" type="RestProxyCall*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="weak_object" type="GObject*"/>
				<parameter name="userdata" type="gpointer"/>
			</parameters>
		</callback>
		<boxed name="RestXmlNode" type-name="RestXmlNode" get-type="rest_xml_node_get_type">
			<method name="find" symbol="rest_xml_node_find">
				<return-type type="RestXmlNode*"/>
				<parameters>
					<parameter name="node" type="RestXmlNode*"/>
					<parameter name="tag" type="gchar*"/>
				</parameters>
			</method>
			<method name="free" symbol="rest_xml_node_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="RestXmlNode*"/>
				</parameters>
			</method>
			<method name="get_attr" symbol="rest_xml_node_get_attr">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="node" type="RestXmlNode*"/>
					<parameter name="attr_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="ref" symbol="rest_xml_node_ref">
				<return-type type="RestXmlNode*"/>
				<parameters>
					<parameter name="node" type="RestXmlNode*"/>
				</parameters>
			</method>
			<method name="unref" symbol="rest_xml_node_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="RestXmlNode*"/>
				</parameters>
			</method>
			<field name="ref_count" type="int"/>
			<field name="name" type="gchar*"/>
			<field name="content" type="gchar*"/>
			<field name="children" type="GHashTable*"/>
			<field name="attrs" type="GHashTable*"/>
			<field name="next" type="RestXmlNode*"/>
		</boxed>
		<enum name="OAuthSignatureMethod">
			<member name="PLAINTEXT" value="0"/>
			<member name="HMAC_SHA1" value="1"/>
		</enum>
		<enum name="RestProxyCallError">
			<member name="REST_PROXY_CALL_FAILED" value="0"/>
		</enum>
		<enum name="RestProxyError">
			<member name="REST_PROXY_ERROR_CANCELLED" value="1"/>
			<member name="REST_PROXY_ERROR_RESOLUTION" value="2"/>
			<member name="REST_PROXY_ERROR_CONNECTION" value="3"/>
			<member name="REST_PROXY_ERROR_SSL" value="4"/>
			<member name="REST_PROXY_ERROR_IO" value="5"/>
			<member name="REST_PROXY_ERROR_FAILED" value="6"/>
			<member name="REST_PROXY_ERROR_HTTP_MULTIPLE_CHOICES" value="300"/>
			<member name="REST_PROXY_ERROR_HTTP_MOVED_PERMANENTLY" value="301"/>
			<member name="REST_PROXY_ERROR_HTTP_FOUND" value="302"/>
			<member name="REST_PROXY_ERROR_HTTP_SEE_OTHER" value="303"/>
			<member name="REST_PROXY_ERROR_HTTP_NOT_MODIFIED" value="304"/>
			<member name="REST_PROXY_ERROR_HTTP_USE_PROXY" value="305"/>
			<member name="REST_PROXY_ERROR_HTTP_THREEOHSIX" value="306"/>
			<member name="REST_PROXY_ERROR_HTTP_TEMPORARY_REDIRECT" value="307"/>
			<member name="REST_PROXY_ERROR_HTTP_BAD_REQUEST" value="400"/>
			<member name="REST_PROXY_ERROR_HTTP_UNAUTHORIZED" value="401"/>
			<member name="REST_PROXY_ERROR_HTTP_FOUROHTWO" value="402"/>
			<member name="REST_PROXY_ERROR_HTTP_FORBIDDEN" value="403"/>
			<member name="REST_PROXY_ERROR_HTTP_NOT_FOUND" value="404"/>
			<member name="REST_PROXY_ERROR_HTTP_METHOD_NOT_ALLOWED" value="405"/>
			<member name="REST_PROXY_ERROR_HTTP_NOT_ACCEPTABLE" value="406"/>
			<member name="REST_PROXY_ERROR_HTTP_PROXY_AUTHENTICATION_REQUIRED" value="407"/>
			<member name="REST_PROXY_ERROR_HTTP_REQUEST_TIMEOUT" value="408"/>
			<member name="REST_PROXY_ERROR_HTTP_CONFLICT" value="409"/>
			<member name="REST_PROXY_ERROR_HTTP_GONE" value="410"/>
			<member name="REST_PROXY_ERROR_HTTP_LENGTH_REQUIRED" value="411"/>
			<member name="REST_PROXY_ERROR_HTTP_PRECONDITION_FAILED" value="412"/>
			<member name="REST_PROXY_ERROR_HTTP_REQUEST_ENTITY_TOO_LARGE" value="413"/>
			<member name="REST_PROXY_ERROR_HTTP_REQUEST_URI_TOO_LONG" value="414"/>
			<member name="REST_PROXY_ERROR_HTTP_UNSUPPORTED_MEDIA_TYPE" value="415"/>
			<member name="REST_PROXY_ERROR_HTTP_REQUESTED_RANGE_NOT_SATISFIABLE" value="416"/>
			<member name="REST_PROXY_ERROR_HTTP_EXPECTATION_FAILED" value="417"/>
			<member name="REST_PROXY_ERROR_HTTP_INTERNAL_SERVER_ERROR" value="500"/>
			<member name="REST_PROXY_ERROR_HTTP_NOT_IMPLEMENTED" value="501"/>
			<member name="REST_PROXY_ERROR_HTTP_BAD_GATEWAY" value="502"/>
			<member name="REST_PROXY_ERROR_HTTP_SERVICE_UNAVAILABLE" value="503"/>
			<member name="REST_PROXY_ERROR_HTTP_GATEWAY_TIMEOUT" value="504"/>
			<member name="REST_PROXY_ERROR_HTTP_HTTP_VERSION_NOT_SUPPORTED" value="505"/>
		</enum>
		<object name="OAuthProxy" parent="RestProxy" type-name="OAuthProxy" get-type="oauth_proxy_get_type">
			<method name="access_token" symbol="oauth_proxy_access_token">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="OAuthProxy*"/>
					<parameter name="function" type="char*"/>
					<parameter name="verifier" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="access_token_async" symbol="oauth_proxy_access_token_async">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="OAuthProxy*"/>
					<parameter name="function" type="char*"/>
					<parameter name="verifier" type="char*"/>
					<parameter name="callback" type="OAuthProxyAuthCallback"/>
					<parameter name="weak_object" type="GObject*"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="auth_step" symbol="oauth_proxy_auth_step">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="OAuthProxy*"/>
					<parameter name="function" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="auth_step_async" symbol="oauth_proxy_auth_step_async">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="OAuthProxy*"/>
					<parameter name="function" type="char*"/>
					<parameter name="callback" type="OAuthProxyAuthCallback"/>
					<parameter name="weak_object" type="GObject*"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="error_out" type="GError**"/>
				</parameters>
			</method>
			<method name="get_token" symbol="oauth_proxy_get_token">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="OAuthProxy*"/>
				</parameters>
			</method>
			<method name="get_token_secret" symbol="oauth_proxy_get_token_secret">
				<return-type type="char*"/>
				<parameters>
					<parameter name="proxy" type="OAuthProxy*"/>
				</parameters>
			</method>
			<method name="is_oauth10a" symbol="oauth_proxy_is_oauth10a">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="OAuthProxy*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="oauth_proxy_new">
				<return-type type="RestProxy*"/>
				<parameters>
					<parameter name="consumer_key" type="char*"/>
					<parameter name="consumer_secret" type="char*"/>
					<parameter name="url_format" type="gchar*"/>
					<parameter name="binding_required" type="gboolean"/>
				</parameters>
			</constructor>
			<constructor name="new_with_token" symbol="oauth_proxy_new_with_token">
				<return-type type="RestProxy*"/>
				<parameters>
					<parameter name="consumer_key" type="char*"/>
					<parameter name="consumer_secret" type="char*"/>
					<parameter name="token" type="char*"/>
					<parameter name="token_secret" type="char*"/>
					<parameter name="url_format" type="gchar*"/>
					<parameter name="binding_required" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="request_token" symbol="oauth_proxy_request_token">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="OAuthProxy*"/>
					<parameter name="function" type="char*"/>
					<parameter name="callback_uri" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="request_token_async" symbol="oauth_proxy_request_token_async">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="OAuthProxy*"/>
					<parameter name="function" type="char*"/>
					<parameter name="callback_uri" type="char*"/>
					<parameter name="callback" type="OAuthProxyAuthCallback"/>
					<parameter name="weak_object" type="GObject*"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_token" symbol="oauth_proxy_set_token">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="OAuthProxy*"/>
					<parameter name="token" type="char*"/>
				</parameters>
			</method>
			<method name="set_token_secret" symbol="oauth_proxy_set_token_secret">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="OAuthProxy*"/>
					<parameter name="token_secret" type="char*"/>
				</parameters>
			</method>
			<property name="consumer-key" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="consumer-secret" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="token" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="token-secret" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="OAuthProxyCall" parent="RestProxyCall" type-name="OAuthProxyCall" get-type="oauth_proxy_call_get_type">
		</object>
		<object name="RestProxy" parent="GObject" type-name="RestProxy" get-type="rest_proxy_get_type">
			<method name="bind" symbol="rest_proxy_bind">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="RestProxy*"/>
				</parameters>
			</method>
			<method name="bind_valist" symbol="rest_proxy_bind_valist">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="RestProxy*"/>
					<parameter name="params" type="va_list"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="rest_proxy_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_user_agent" symbol="rest_proxy_get_user_agent">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proxy" type="RestProxy*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="rest_proxy_new">
				<return-type type="RestProxy*"/>
				<parameters>
					<parameter name="url_format" type="gchar*"/>
					<parameter name="binding_required" type="gboolean"/>
				</parameters>
			</constructor>
			<constructor name="new_call" symbol="rest_proxy_new_call">
				<return-type type="RestProxyCall*"/>
				<parameters>
					<parameter name="proxy" type="RestProxy*"/>
				</parameters>
			</constructor>
			<method name="set_user_agent" symbol="rest_proxy_set_user_agent">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="RestProxy*"/>
					<parameter name="user_agent" type="char*"/>
				</parameters>
			</method>
			<method name="simple_run" symbol="rest_proxy_simple_run">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="RestProxy*"/>
					<parameter name="payload" type="gchar**"/>
					<parameter name="len" type="goffset*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="simple_run_valist" symbol="rest_proxy_simple_run_valist">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="RestProxy*"/>
					<parameter name="payload" type="gchar**"/>
					<parameter name="len" type="goffset*"/>
					<parameter name="error" type="GError**"/>
					<parameter name="params" type="va_list"/>
				</parameters>
			</method>
			<property name="binding-required" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="url-format" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="user-agent" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="bind_valist">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="RestProxy*"/>
					<parameter name="params" type="va_list"/>
				</parameters>
			</vfunc>
			<vfunc name="new_call">
				<return-type type="RestProxyCall*"/>
				<parameters>
					<parameter name="proxy" type="RestProxy*"/>
				</parameters>
			</vfunc>
			<vfunc name="simple_run_valist">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="RestProxy*"/>
					<parameter name="payload" type="gchar**"/>
					<parameter name="len" type="goffset*"/>
					<parameter name="error" type="GError**"/>
					<parameter name="params" type="va_list"/>
				</parameters>
			</vfunc>
		</object>
		<object name="RestProxyCall" parent="GObject" type-name="RestProxyCall" get-type="rest_proxy_call_get_type">
			<method name="add_header" symbol="rest_proxy_call_add_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="header" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_headers" symbol="rest_proxy_call_add_headers">
				<return-type type="void"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
				</parameters>
			</method>
			<method name="add_headers_from_valist" symbol="rest_proxy_call_add_headers_from_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="headers" type="va_list"/>
				</parameters>
			</method>
			<method name="add_param" symbol="rest_proxy_call_add_param">
				<return-type type="void"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="param" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_params" symbol="rest_proxy_call_add_params">
				<return-type type="void"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
				</parameters>
			</method>
			<method name="add_params_from_valist" symbol="rest_proxy_call_add_params_from_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="params" type="va_list"/>
				</parameters>
			</method>
			<method name="async" symbol="rest_proxy_call_async">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="callback" type="RestProxyCallAsyncCallback"/>
					<parameter name="weak_object" type="GObject*"/>
					<parameter name="userdata" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="cancel" symbol="rest_proxy_call_cancel">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="rest_proxy_call_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_method" symbol="rest_proxy_call_get_method">
				<return-type type="char*"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
				</parameters>
			</method>
			<method name="get_params" symbol="rest_proxy_call_get_params">
				<return-type type="GHashTable*"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
				</parameters>
			</method>
			<method name="get_payload" symbol="rest_proxy_call_get_payload">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
				</parameters>
			</method>
			<method name="get_payload_length" symbol="rest_proxy_call_get_payload_length">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
				</parameters>
			</method>
			<method name="get_response_headers" symbol="rest_proxy_call_get_response_headers">
				<return-type type="GHashTable*"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
				</parameters>
			</method>
			<method name="get_status_code" symbol="rest_proxy_call_get_status_code">
				<return-type type="guint"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
				</parameters>
			</method>
			<method name="get_status_message" symbol="rest_proxy_call_get_status_message">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
				</parameters>
			</method>
			<method name="lookup_header" symbol="rest_proxy_call_lookup_header">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="header" type="gchar*"/>
				</parameters>
			</method>
			<method name="lookup_param" symbol="rest_proxy_call_lookup_param">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="param" type="gchar*"/>
				</parameters>
			</method>
			<method name="lookup_response_header" symbol="rest_proxy_call_lookup_response_header">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="header" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove_header" symbol="rest_proxy_call_remove_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="header" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove_param" symbol="rest_proxy_call_remove_param">
				<return-type type="void"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="param" type="gchar*"/>
				</parameters>
			</method>
			<method name="run" symbol="rest_proxy_call_run">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="loop" type="GMainLoop**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_function" symbol="rest_proxy_call_set_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="function" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_method" symbol="rest_proxy_call_set_method">
				<return-type type="void"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="method" type="gchar*"/>
				</parameters>
			</method>
			<method name="sync" symbol="rest_proxy_call_sync">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="error_out" type="GError**"/>
				</parameters>
			</method>
			<property name="proxy" type="RestProxy*" readable="1" writable="1" construct="0" construct-only="1"/>
			<vfunc name="prepare">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="call" type="RestProxyCall*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="RestXmlParser" parent="GObject" type-name="RestXmlParser" get-type="rest_xml_parser_get_type">
			<constructor name="new" symbol="rest_xml_parser_new">
				<return-type type="RestXmlParser*"/>
			</constructor>
			<method name="parse_from_data" symbol="rest_xml_parser_parse_from_data">
				<return-type type="RestXmlNode*"/>
				<parameters>
					<parameter name="parser" type="RestXmlParser*"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="len" type="goffset"/>
				</parameters>
			</method>
		</object>
	</namespace>
</api>
