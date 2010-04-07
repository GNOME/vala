<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Soup">
		<function name="add_completion" symbol="soup_add_completion">
			<return-type type="GSource*"/>
			<parameters>
				<parameter name="async_context" type="GMainContext*"/>
				<parameter name="function" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
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
		<function name="cookies_free" symbol="soup_cookies_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="cookies" type="GSList*"/>
			</parameters>
		</function>
		<function name="cookies_from_request" symbol="soup_cookies_from_request">
			<return-type type="GSList*"/>
			<parameters>
				<parameter name="msg" type="SoupMessage*"/>
			</parameters>
		</function>
		<function name="cookies_from_response" symbol="soup_cookies_from_response">
			<return-type type="GSList*"/>
			<parameters>
				<parameter name="msg" type="SoupMessage*"/>
			</parameters>
		</function>
		<function name="cookies_to_cookie_header" symbol="soup_cookies_to_cookie_header">
			<return-type type="char*"/>
			<parameters>
				<parameter name="cookies" type="GSList*"/>
			</parameters>
		</function>
		<function name="cookies_to_request" symbol="soup_cookies_to_request">
			<return-type type="void"/>
			<parameters>
				<parameter name="cookies" type="GSList*"/>
				<parameter name="msg" type="SoupMessage*"/>
			</parameters>
		</function>
		<function name="cookies_to_response" symbol="soup_cookies_to_response">
			<return-type type="void"/>
			<parameters>
				<parameter name="cookies" type="GSList*"/>
				<parameter name="msg" type="SoupMessage*"/>
			</parameters>
		</function>
		<function name="form_decode" symbol="soup_form_decode">
			<return-type type="GHashTable*"/>
			<parameters>
				<parameter name="encoded_form" type="char*"/>
			</parameters>
		</function>
		<function name="form_decode_multipart" symbol="soup_form_decode_multipart">
			<return-type type="GHashTable*"/>
			<parameters>
				<parameter name="msg" type="SoupMessage*"/>
				<parameter name="file_control_name" type="char*"/>
				<parameter name="filename" type="char**"/>
				<parameter name="content_type" type="char**"/>
				<parameter name="file" type="SoupBuffer**"/>
			</parameters>
		</function>
		<function name="form_encode" symbol="soup_form_encode">
			<return-type type="char*"/>
			<parameters>
				<parameter name="first_field" type="char*"/>
			</parameters>
		</function>
		<function name="form_encode_datalist" symbol="soup_form_encode_datalist">
			<return-type type="char*"/>
			<parameters>
				<parameter name="form_data_set" type="GData**"/>
			</parameters>
		</function>
		<function name="form_encode_hash" symbol="soup_form_encode_hash">
			<return-type type="char*"/>
			<parameters>
				<parameter name="form_data_set" type="GHashTable*"/>
			</parameters>
		</function>
		<function name="form_encode_valist" symbol="soup_form_encode_valist">
			<return-type type="char*"/>
			<parameters>
				<parameter name="first_field" type="char*"/>
				<parameter name="args" type="va_list"/>
			</parameters>
		</function>
		<function name="form_request_new" symbol="soup_form_request_new">
			<return-type type="SoupMessage*"/>
			<parameters>
				<parameter name="method" type="char*"/>
				<parameter name="uri" type="char*"/>
				<parameter name="first_field" type="char*"/>
			</parameters>
		</function>
		<function name="form_request_new_from_datalist" symbol="soup_form_request_new_from_datalist">
			<return-type type="SoupMessage*"/>
			<parameters>
				<parameter name="method" type="char*"/>
				<parameter name="uri" type="char*"/>
				<parameter name="form_data_set" type="GData**"/>
			</parameters>
		</function>
		<function name="form_request_new_from_hash" symbol="soup_form_request_new_from_hash">
			<return-type type="SoupMessage*"/>
			<parameters>
				<parameter name="method" type="char*"/>
				<parameter name="uri" type="char*"/>
				<parameter name="form_data_set" type="GHashTable*"/>
			</parameters>
		</function>
		<function name="form_request_new_from_multipart" symbol="soup_form_request_new_from_multipart">
			<return-type type="SoupMessage*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
				<parameter name="multipart" type="SoupMultipart*"/>
			</parameters>
		</function>
		<function name="header_contains" symbol="soup_header_contains">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="header" type="char*"/>
				<parameter name="token" type="char*"/>
			</parameters>
		</function>
		<function name="header_free_list" symbol="soup_header_free_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GSList*"/>
			</parameters>
		</function>
		<function name="header_free_param_list" symbol="soup_header_free_param_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="param_list" type="GHashTable*"/>
			</parameters>
		</function>
		<function name="header_g_string_append_param" symbol="soup_header_g_string_append_param">
			<return-type type="void"/>
			<parameters>
				<parameter name="string" type="GString*"/>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="char*"/>
			</parameters>
		</function>
		<function name="header_parse_list" symbol="soup_header_parse_list">
			<return-type type="GSList*"/>
			<parameters>
				<parameter name="header" type="char*"/>
			</parameters>
		</function>
		<function name="header_parse_param_list" symbol="soup_header_parse_param_list">
			<return-type type="GHashTable*"/>
			<parameters>
				<parameter name="header" type="char*"/>
			</parameters>
		</function>
		<function name="header_parse_quality_list" symbol="soup_header_parse_quality_list">
			<return-type type="GSList*"/>
			<parameters>
				<parameter name="header" type="char*"/>
				<parameter name="unacceptable" type="GSList**"/>
			</parameters>
		</function>
		<function name="header_parse_semi_param_list" symbol="soup_header_parse_semi_param_list">
			<return-type type="GHashTable*"/>
			<parameters>
				<parameter name="header" type="char*"/>
			</parameters>
		</function>
		<function name="headers_parse" symbol="soup_headers_parse">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="len" type="int"/>
				<parameter name="dest" type="SoupMessageHeaders*"/>
			</parameters>
		</function>
		<function name="headers_parse_request" symbol="soup_headers_parse_request">
			<return-type type="guint"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="len" type="int"/>
				<parameter name="req_headers" type="SoupMessageHeaders*"/>
				<parameter name="req_method" type="char**"/>
				<parameter name="req_path" type="char**"/>
				<parameter name="ver" type="SoupHTTPVersion*"/>
			</parameters>
		</function>
		<function name="headers_parse_response" symbol="soup_headers_parse_response">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="len" type="int"/>
				<parameter name="headers" type="SoupMessageHeaders*"/>
				<parameter name="ver" type="SoupHTTPVersion*"/>
				<parameter name="status_code" type="guint*"/>
				<parameter name="reason_phrase" type="char**"/>
			</parameters>
		</function>
		<function name="headers_parse_status_line" symbol="soup_headers_parse_status_line">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="status_line" type="char*"/>
				<parameter name="ver" type="SoupHTTPVersion*"/>
				<parameter name="status_code" type="guint*"/>
				<parameter name="reason_phrase" type="char**"/>
			</parameters>
		</function>
		<function name="http_error_quark" symbol="soup_http_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="ssl_error_quark" symbol="soup_ssl_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="status_get_phrase" symbol="soup_status_get_phrase">
			<return-type type="char*"/>
			<parameters>
				<parameter name="status_code" type="guint"/>
			</parameters>
		</function>
		<function name="status_proxify" symbol="soup_status_proxify">
			<return-type type="guint"/>
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
		<function name="value_array_append" symbol="soup_value_array_append">
			<return-type type="void"/>
			<parameters>
				<parameter name="array" type="GValueArray*"/>
				<parameter name="type" type="GType"/>
			</parameters>
		</function>
		<function name="value_array_append_vals" symbol="soup_value_array_append_vals">
			<return-type type="void"/>
			<parameters>
				<parameter name="array" type="GValueArray*"/>
				<parameter name="first_type" type="GType"/>
			</parameters>
		</function>
		<function name="value_array_from_args" symbol="soup_value_array_from_args">
			<return-type type="GValueArray*"/>
			<parameters>
				<parameter name="args" type="va_list"/>
			</parameters>
		</function>
		<function name="value_array_get_nth" symbol="soup_value_array_get_nth">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="array" type="GValueArray*"/>
				<parameter name="index_" type="guint"/>
				<parameter name="type" type="GType"/>
			</parameters>
		</function>
		<function name="value_array_insert" symbol="soup_value_array_insert">
			<return-type type="void"/>
			<parameters>
				<parameter name="array" type="GValueArray*"/>
				<parameter name="index_" type="guint"/>
				<parameter name="type" type="GType"/>
			</parameters>
		</function>
		<function name="value_array_new" symbol="soup_value_array_new">
			<return-type type="GValueArray*"/>
		</function>
		<function name="value_array_new_with_vals" symbol="soup_value_array_new_with_vals">
			<return-type type="GValueArray*"/>
			<parameters>
				<parameter name="first_type" type="GType"/>
			</parameters>
		</function>
		<function name="value_array_to_args" symbol="soup_value_array_to_args">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="array" type="GValueArray*"/>
				<parameter name="args" type="va_list"/>
			</parameters>
		</function>
		<function name="value_hash_insert" symbol="soup_value_hash_insert">
			<return-type type="void"/>
			<parameters>
				<parameter name="hash" type="GHashTable*"/>
				<parameter name="key" type="char*"/>
				<parameter name="type" type="GType"/>
			</parameters>
		</function>
		<function name="value_hash_insert_vals" symbol="soup_value_hash_insert_vals">
			<return-type type="void"/>
			<parameters>
				<parameter name="hash" type="GHashTable*"/>
				<parameter name="first_key" type="char*"/>
			</parameters>
		</function>
		<function name="value_hash_insert_value" symbol="soup_value_hash_insert_value">
			<return-type type="void"/>
			<parameters>
				<parameter name="hash" type="GHashTable*"/>
				<parameter name="key" type="char*"/>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_hash_lookup" symbol="soup_value_hash_lookup">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="hash" type="GHashTable*"/>
				<parameter name="key" type="char*"/>
				<parameter name="type" type="GType"/>
			</parameters>
		</function>
		<function name="value_hash_lookup_vals" symbol="soup_value_hash_lookup_vals">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="hash" type="GHashTable*"/>
				<parameter name="first_key" type="char*"/>
			</parameters>
		</function>
		<function name="value_hash_new" symbol="soup_value_hash_new">
			<return-type type="GHashTable*"/>
		</function>
		<function name="value_hash_new_with_vals" symbol="soup_value_hash_new_with_vals">
			<return-type type="GHashTable*"/>
			<parameters>
				<parameter name="first_key" type="char*"/>
			</parameters>
		</function>
		<function name="xmlrpc_build_fault" symbol="soup_xmlrpc_build_fault">
			<return-type type="char*"/>
			<parameters>
				<parameter name="fault_code" type="int"/>
				<parameter name="fault_format" type="char*"/>
			</parameters>
		</function>
		<function name="xmlrpc_build_method_call" symbol="soup_xmlrpc_build_method_call">
			<return-type type="char*"/>
			<parameters>
				<parameter name="method_name" type="char*"/>
				<parameter name="params" type="GValue*"/>
				<parameter name="n_params" type="int"/>
			</parameters>
		</function>
		<function name="xmlrpc_build_method_response" symbol="soup_xmlrpc_build_method_response">
			<return-type type="char*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="xmlrpc_error_quark" symbol="soup_xmlrpc_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="xmlrpc_extract_method_call" symbol="soup_xmlrpc_extract_method_call">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="method_call" type="char*"/>
				<parameter name="length" type="int"/>
				<parameter name="method_name" type="char**"/>
			</parameters>
		</function>
		<function name="xmlrpc_extract_method_response" symbol="soup_xmlrpc_extract_method_response">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="method_response" type="char*"/>
				<parameter name="length" type="int"/>
				<parameter name="error" type="GError**"/>
				<parameter name="type" type="GType"/>
			</parameters>
		</function>
		<function name="xmlrpc_fault_quark" symbol="soup_xmlrpc_fault_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="xmlrpc_parse_method_call" symbol="soup_xmlrpc_parse_method_call">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="method_call" type="char*"/>
				<parameter name="length" type="int"/>
				<parameter name="method_name" type="char**"/>
				<parameter name="params" type="GValueArray**"/>
			</parameters>
		</function>
		<function name="xmlrpc_parse_method_response" symbol="soup_xmlrpc_parse_method_response">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="method_response" type="char*"/>
				<parameter name="length" type="int"/>
				<parameter name="value" type="GValue*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="xmlrpc_request_new" symbol="soup_xmlrpc_request_new">
			<return-type type="SoupMessage*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
				<parameter name="method_name" type="char*"/>
			</parameters>
		</function>
		<function name="xmlrpc_set_fault" symbol="soup_xmlrpc_set_fault">
			<return-type type="void"/>
			<parameters>
				<parameter name="msg" type="SoupMessage*"/>
				<parameter name="fault_code" type="int"/>
				<parameter name="fault_format" type="char*"/>
			</parameters>
		</function>
		<function name="xmlrpc_set_response" symbol="soup_xmlrpc_set_response">
			<return-type type="void"/>
			<parameters>
				<parameter name="msg" type="SoupMessage*"/>
				<parameter name="type" type="GType"/>
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
		<callback name="SoupAuthDomainBasicAuthCallback">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="domain" type="SoupAuthDomain*"/>
				<parameter name="msg" type="SoupMessage*"/>
				<parameter name="username" type="char*"/>
				<parameter name="password" type="char*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupAuthDomainDigestAuthCallback">
			<return-type type="char*"/>
			<parameters>
				<parameter name="domain" type="SoupAuthDomain*"/>
				<parameter name="msg" type="SoupMessage*"/>
				<parameter name="username" type="char*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupAuthDomainFilter">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="domain" type="SoupAuthDomain*"/>
				<parameter name="msg" type="SoupMessage*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupAuthDomainGenericAuthCallback">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="domain" type="SoupAuthDomain*"/>
				<parameter name="msg" type="SoupMessage*"/>
				<parameter name="username" type="char*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupChunkAllocator">
			<return-type type="SoupBuffer*"/>
			<parameters>
				<parameter name="msg" type="SoupMessage*"/>
				<parameter name="max_len" type="gsize"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupLoggerFilter">
			<return-type type="SoupLoggerLogLevel"/>
			<parameters>
				<parameter name="logger" type="SoupLogger*"/>
				<parameter name="msg" type="SoupMessage*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupLoggerPrinter">
			<return-type type="void"/>
			<parameters>
				<parameter name="logger" type="SoupLogger*"/>
				<parameter name="level" type="SoupLoggerLogLevel"/>
				<parameter name="direction" type="char"/>
				<parameter name="data" type="char*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupMessageHeadersForeachFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="char*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupProxyResolverCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="SoupProxyResolver*"/>
				<parameter name="p2" type="SoupMessage*"/>
				<parameter name="p3" type="guint"/>
				<parameter name="p4" type="SoupAddress*"/>
				<parameter name="p5" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupProxyURIResolverCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="resolver" type="SoupProxyURIResolver*"/>
				<parameter name="status" type="guint"/>
				<parameter name="proxy_uri" type="SoupURI*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupServerCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="server" type="SoupServer*"/>
				<parameter name="msg" type="SoupMessage*"/>
				<parameter name="path" type="char*"/>
				<parameter name="query" type="GHashTable*"/>
				<parameter name="client" type="SoupClientContext*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="SoupSessionCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="session" type="SoupSession*"/>
				<parameter name="msg" type="SoupMessage*"/>
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
		<struct name="SoupMessageHeadersIter">
			<method name="init" symbol="soup_message_headers_iter_init">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="SoupMessageHeadersIter*"/>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
				</parameters>
			</method>
			<method name="next" symbol="soup_message_headers_iter_next">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="SoupMessageHeadersIter*"/>
					<parameter name="name" type="char**"/>
					<parameter name="value" type="char**"/>
				</parameters>
			</method>
			<field name="dummy" type="gpointer[]"/>
		</struct>
		<struct name="SoupRange">
			<field name="start" type="goffset"/>
			<field name="end" type="goffset"/>
		</struct>
		<boxed name="SoupBuffer" type-name="SoupBuffer" get-type="soup_buffer_get_type">
			<method name="copy" symbol="soup_buffer_copy">
				<return-type type="SoupBuffer*"/>
				<parameters>
					<parameter name="buffer" type="SoupBuffer*"/>
				</parameters>
			</method>
			<method name="free" symbol="soup_buffer_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="SoupBuffer*"/>
				</parameters>
			</method>
			<method name="get_owner" symbol="soup_buffer_get_owner">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="buffer" type="SoupBuffer*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_buffer_new">
				<return-type type="SoupBuffer*"/>
				<parameters>
					<parameter name="use" type="SoupMemoryUse"/>
					<parameter name="data" type="gconstpointer"/>
					<parameter name="length" type="gsize"/>
				</parameters>
			</constructor>
			<constructor name="new_subbuffer" symbol="soup_buffer_new_subbuffer">
				<return-type type="SoupBuffer*"/>
				<parameters>
					<parameter name="parent" type="SoupBuffer*"/>
					<parameter name="offset" type="gsize"/>
					<parameter name="length" type="gsize"/>
				</parameters>
			</constructor>
			<constructor name="new_with_owner" symbol="soup_buffer_new_with_owner">
				<return-type type="SoupBuffer*"/>
				<parameters>
					<parameter name="data" type="gconstpointer"/>
					<parameter name="length" type="gsize"/>
					<parameter name="owner" type="gpointer"/>
					<parameter name="owner_dnotify" type="GDestroyNotify"/>
				</parameters>
			</constructor>
			<field name="data" type="char*"/>
			<field name="length" type="gsize"/>
		</boxed>
		<boxed name="SoupByteArray" type-name="SoupByteArray" get-type="soup_byte_array_get_type">
		</boxed>
		<boxed name="SoupClientContext" type-name="SoupClientContext" get-type="soup_client_context_get_type">
			<method name="get_address" symbol="soup_client_context_get_address">
				<return-type type="SoupAddress*"/>
				<parameters>
					<parameter name="client" type="SoupClientContext*"/>
				</parameters>
			</method>
			<method name="get_auth_domain" symbol="soup_client_context_get_auth_domain">
				<return-type type="SoupAuthDomain*"/>
				<parameters>
					<parameter name="client" type="SoupClientContext*"/>
				</parameters>
			</method>
			<method name="get_auth_user" symbol="soup_client_context_get_auth_user">
				<return-type type="char*"/>
				<parameters>
					<parameter name="client" type="SoupClientContext*"/>
				</parameters>
			</method>
			<method name="get_host" symbol="soup_client_context_get_host">
				<return-type type="char*"/>
				<parameters>
					<parameter name="client" type="SoupClientContext*"/>
				</parameters>
			</method>
			<method name="get_socket" symbol="soup_client_context_get_socket">
				<return-type type="SoupSocket*"/>
				<parameters>
					<parameter name="client" type="SoupClientContext*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="SoupCookie" type-name="SoupCookie" get-type="soup_cookie_get_type">
			<method name="applies_to_uri" symbol="soup_cookie_applies_to_uri">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
					<parameter name="uri" type="SoupURI*"/>
				</parameters>
			</method>
			<method name="copy" symbol="soup_cookie_copy">
				<return-type type="SoupCookie*"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
				</parameters>
			</method>
			<method name="domain_matches" symbol="soup_cookie_domain_matches">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
					<parameter name="host" type="char*"/>
				</parameters>
			</method>
			<method name="equal" symbol="soup_cookie_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cookie1" type="SoupCookie*"/>
					<parameter name="cookie2" type="SoupCookie*"/>
				</parameters>
			</method>
			<method name="free" symbol="soup_cookie_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_cookie_new">
				<return-type type="SoupCookie*"/>
				<parameters>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="char*"/>
					<parameter name="domain" type="char*"/>
					<parameter name="path" type="char*"/>
					<parameter name="max_age" type="int"/>
				</parameters>
			</constructor>
			<method name="parse" symbol="soup_cookie_parse">
				<return-type type="SoupCookie*"/>
				<parameters>
					<parameter name="header" type="char*"/>
					<parameter name="origin" type="SoupURI*"/>
				</parameters>
			</method>
			<method name="set_domain" symbol="soup_cookie_set_domain">
				<return-type type="void"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
					<parameter name="domain" type="char*"/>
				</parameters>
			</method>
			<method name="set_expires" symbol="soup_cookie_set_expires">
				<return-type type="void"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
					<parameter name="expires" type="SoupDate*"/>
				</parameters>
			</method>
			<method name="set_http_only" symbol="soup_cookie_set_http_only">
				<return-type type="void"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
					<parameter name="http_only" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_max_age" symbol="soup_cookie_set_max_age">
				<return-type type="void"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
					<parameter name="max_age" type="int"/>
				</parameters>
			</method>
			<method name="set_name" symbol="soup_cookie_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_path" symbol="soup_cookie_set_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="set_secure" symbol="soup_cookie_set_secure">
				<return-type type="void"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
					<parameter name="secure" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_value" symbol="soup_cookie_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="to_cookie_header" symbol="soup_cookie_to_cookie_header">
				<return-type type="char*"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
				</parameters>
			</method>
			<method name="to_set_cookie_header" symbol="soup_cookie_to_set_cookie_header">
				<return-type type="char*"/>
				<parameters>
					<parameter name="cookie" type="SoupCookie*"/>
				</parameters>
			</method>
			<field name="name" type="char*"/>
			<field name="value" type="char*"/>
			<field name="domain" type="char*"/>
			<field name="path" type="char*"/>
			<field name="expires" type="SoupDate*"/>
			<field name="secure" type="gboolean"/>
			<field name="http_only" type="gboolean"/>
		</boxed>
		<boxed name="SoupDate" type-name="SoupDate" get-type="soup_date_get_type">
			<method name="copy" symbol="soup_date_copy">
				<return-type type="SoupDate*"/>
				<parameters>
					<parameter name="date" type="SoupDate*"/>
				</parameters>
			</method>
			<method name="free" symbol="soup_date_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="date" type="SoupDate*"/>
				</parameters>
			</method>
			<method name="is_past" symbol="soup_date_is_past">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="date" type="SoupDate*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_date_new">
				<return-type type="SoupDate*"/>
				<parameters>
					<parameter name="year" type="int"/>
					<parameter name="month" type="int"/>
					<parameter name="day" type="int"/>
					<parameter name="hour" type="int"/>
					<parameter name="minute" type="int"/>
					<parameter name="second" type="int"/>
				</parameters>
			</constructor>
			<constructor name="new_from_now" symbol="soup_date_new_from_now">
				<return-type type="SoupDate*"/>
				<parameters>
					<parameter name="offset_seconds" type="int"/>
				</parameters>
			</constructor>
			<constructor name="new_from_string" symbol="soup_date_new_from_string">
				<return-type type="SoupDate*"/>
				<parameters>
					<parameter name="date_string" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_time_t" symbol="soup_date_new_from_time_t">
				<return-type type="SoupDate*"/>
				<parameters>
					<parameter name="when" type="time_t"/>
				</parameters>
			</constructor>
			<method name="to_string" symbol="soup_date_to_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="date" type="SoupDate*"/>
					<parameter name="format" type="SoupDateFormat"/>
				</parameters>
			</method>
			<method name="to_time_t" symbol="soup_date_to_time_t">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="date" type="SoupDate*"/>
				</parameters>
			</method>
			<method name="to_timeval" symbol="soup_date_to_timeval">
				<return-type type="void"/>
				<parameters>
					<parameter name="date" type="SoupDate*"/>
					<parameter name="time" type="GTimeVal*"/>
				</parameters>
			</method>
			<field name="year" type="int"/>
			<field name="month" type="int"/>
			<field name="day" type="int"/>
			<field name="hour" type="int"/>
			<field name="minute" type="int"/>
			<field name="second" type="int"/>
			<field name="utc" type="gboolean"/>
			<field name="offset" type="int"/>
		</boxed>
		<boxed name="SoupMessageBody" type-name="SoupMessageBody" get-type="soup_message_body_get_type">
			<method name="append" symbol="soup_message_body_append">
				<return-type type="void"/>
				<parameters>
					<parameter name="body" type="SoupMessageBody*"/>
					<parameter name="use" type="SoupMemoryUse"/>
					<parameter name="data" type="gconstpointer"/>
					<parameter name="length" type="gsize"/>
				</parameters>
			</method>
			<method name="append_buffer" symbol="soup_message_body_append_buffer">
				<return-type type="void"/>
				<parameters>
					<parameter name="body" type="SoupMessageBody*"/>
					<parameter name="buffer" type="SoupBuffer*"/>
				</parameters>
			</method>
			<method name="complete" symbol="soup_message_body_complete">
				<return-type type="void"/>
				<parameters>
					<parameter name="body" type="SoupMessageBody*"/>
				</parameters>
			</method>
			<method name="flatten" symbol="soup_message_body_flatten">
				<return-type type="SoupBuffer*"/>
				<parameters>
					<parameter name="body" type="SoupMessageBody*"/>
				</parameters>
			</method>
			<method name="free" symbol="soup_message_body_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="body" type="SoupMessageBody*"/>
				</parameters>
			</method>
			<method name="get_accumulate" symbol="soup_message_body_get_accumulate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="body" type="SoupMessageBody*"/>
				</parameters>
			</method>
			<method name="get_chunk" symbol="soup_message_body_get_chunk">
				<return-type type="SoupBuffer*"/>
				<parameters>
					<parameter name="body" type="SoupMessageBody*"/>
					<parameter name="offset" type="goffset"/>
				</parameters>
			</method>
			<method name="got_chunk" symbol="soup_message_body_got_chunk">
				<return-type type="void"/>
				<parameters>
					<parameter name="body" type="SoupMessageBody*"/>
					<parameter name="chunk" type="SoupBuffer*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_message_body_new">
				<return-type type="SoupMessageBody*"/>
			</constructor>
			<method name="set_accumulate" symbol="soup_message_body_set_accumulate">
				<return-type type="void"/>
				<parameters>
					<parameter name="body" type="SoupMessageBody*"/>
					<parameter name="accumulate" type="gboolean"/>
				</parameters>
			</method>
			<method name="truncate" symbol="soup_message_body_truncate">
				<return-type type="void"/>
				<parameters>
					<parameter name="body" type="SoupMessageBody*"/>
				</parameters>
			</method>
			<method name="wrote_chunk" symbol="soup_message_body_wrote_chunk">
				<return-type type="void"/>
				<parameters>
					<parameter name="body" type="SoupMessageBody*"/>
					<parameter name="chunk" type="SoupBuffer*"/>
				</parameters>
			</method>
			<field name="data" type="char*"/>
			<field name="length" type="goffset"/>
		</boxed>
		<boxed name="SoupMessageHeaders" type-name="SoupMessageHeaders" get-type="soup_message_headers_get_type">
			<method name="append" symbol="soup_message_headers_append">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="clear" symbol="soup_message_headers_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
				</parameters>
			</method>
			<method name="foreach" symbol="soup_message_headers_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="func" type="SoupMessageHeadersForeachFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="soup_message_headers_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
				</parameters>
			</method>
			<method name="free_ranges" symbol="soup_message_headers_free_ranges">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="ranges" type="SoupRange*"/>
				</parameters>
			</method>
			<method name="get" symbol="soup_message_headers_get">
				<return-type type="char*"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_content_disposition" symbol="soup_message_headers_get_content_disposition">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="disposition" type="char**"/>
					<parameter name="params" type="GHashTable**"/>
				</parameters>
			</method>
			<method name="get_content_length" symbol="soup_message_headers_get_content_length">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
				</parameters>
			</method>
			<method name="get_content_range" symbol="soup_message_headers_get_content_range">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="start" type="goffset*"/>
					<parameter name="end" type="goffset*"/>
					<parameter name="total_length" type="goffset*"/>
				</parameters>
			</method>
			<method name="get_content_type" symbol="soup_message_headers_get_content_type">
				<return-type type="char*"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="params" type="GHashTable**"/>
				</parameters>
			</method>
			<method name="get_encoding" symbol="soup_message_headers_get_encoding">
				<return-type type="SoupEncoding"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
				</parameters>
			</method>
			<method name="get_expectations" symbol="soup_message_headers_get_expectations">
				<return-type type="SoupExpectation"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
				</parameters>
			</method>
			<method name="get_list" symbol="soup_message_headers_get_list">
				<return-type type="char*"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_one" symbol="soup_message_headers_get_one">
				<return-type type="char*"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_ranges" symbol="soup_message_headers_get_ranges">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="total_length" type="goffset"/>
					<parameter name="ranges" type="SoupRange**"/>
					<parameter name="length" type="int*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_message_headers_new">
				<return-type type="SoupMessageHeaders*"/>
				<parameters>
					<parameter name="type" type="SoupMessageHeadersType"/>
				</parameters>
			</constructor>
			<method name="remove" symbol="soup_message_headers_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="replace" symbol="soup_message_headers_replace">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_content_disposition" symbol="soup_message_headers_set_content_disposition">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="disposition" type="char*"/>
					<parameter name="params" type="GHashTable*"/>
				</parameters>
			</method>
			<method name="set_content_length" symbol="soup_message_headers_set_content_length">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="content_length" type="goffset"/>
				</parameters>
			</method>
			<method name="set_content_range" symbol="soup_message_headers_set_content_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="start" type="goffset"/>
					<parameter name="end" type="goffset"/>
					<parameter name="total_length" type="goffset"/>
				</parameters>
			</method>
			<method name="set_content_type" symbol="soup_message_headers_set_content_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="params" type="GHashTable*"/>
				</parameters>
			</method>
			<method name="set_encoding" symbol="soup_message_headers_set_encoding">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="encoding" type="SoupEncoding"/>
				</parameters>
			</method>
			<method name="set_expectations" symbol="soup_message_headers_set_expectations">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="expectations" type="SoupExpectation"/>
				</parameters>
			</method>
			<method name="set_range" symbol="soup_message_headers_set_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="start" type="goffset"/>
					<parameter name="end" type="goffset"/>
				</parameters>
			</method>
			<method name="set_ranges" symbol="soup_message_headers_set_ranges">
				<return-type type="void"/>
				<parameters>
					<parameter name="hdrs" type="SoupMessageHeaders*"/>
					<parameter name="ranges" type="SoupRange*"/>
					<parameter name="length" type="int"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="SoupMultipart" type-name="SoupMultipart" get-type="soup_multipart_get_type">
			<method name="append_form_file" symbol="soup_multipart_append_form_file">
				<return-type type="void"/>
				<parameters>
					<parameter name="multipart" type="SoupMultipart*"/>
					<parameter name="control_name" type="char*"/>
					<parameter name="filename" type="char*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="body" type="SoupBuffer*"/>
				</parameters>
			</method>
			<method name="append_form_string" symbol="soup_multipart_append_form_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="multipart" type="SoupMultipart*"/>
					<parameter name="control_name" type="char*"/>
					<parameter name="data" type="char*"/>
				</parameters>
			</method>
			<method name="append_part" symbol="soup_multipart_append_part">
				<return-type type="void"/>
				<parameters>
					<parameter name="multipart" type="SoupMultipart*"/>
					<parameter name="headers" type="SoupMessageHeaders*"/>
					<parameter name="body" type="SoupBuffer*"/>
				</parameters>
			</method>
			<method name="free" symbol="soup_multipart_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="multipart" type="SoupMultipart*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="soup_multipart_get_length">
				<return-type type="int"/>
				<parameters>
					<parameter name="multipart" type="SoupMultipart*"/>
				</parameters>
			</method>
			<method name="get_part" symbol="soup_multipart_get_part">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="multipart" type="SoupMultipart*"/>
					<parameter name="part" type="int"/>
					<parameter name="headers" type="SoupMessageHeaders**"/>
					<parameter name="body" type="SoupBuffer**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_multipart_new">
				<return-type type="SoupMultipart*"/>
				<parameters>
					<parameter name="mime_type" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_message" symbol="soup_multipart_new_from_message">
				<return-type type="SoupMultipart*"/>
				<parameters>
					<parameter name="headers" type="SoupMessageHeaders*"/>
					<parameter name="body" type="SoupMessageBody*"/>
				</parameters>
			</constructor>
			<method name="to_message" symbol="soup_multipart_to_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="multipart" type="SoupMultipart*"/>
					<parameter name="dest_headers" type="SoupMessageHeaders*"/>
					<parameter name="dest_body" type="SoupMessageBody*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="SoupURI" type-name="SoupURI" get-type="soup_uri_get_type">
			<method name="copy" symbol="soup_uri_copy">
				<return-type type="SoupURI*"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
				</parameters>
			</method>
			<method name="copy_host" symbol="soup_uri_copy_host">
				<return-type type="SoupURI*"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
				</parameters>
			</method>
			<method name="decode" symbol="soup_uri_decode">
				<return-type type="char*"/>
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
					<parameter name="uri1" type="SoupURI*"/>
					<parameter name="uri2" type="SoupURI*"/>
				</parameters>
			</method>
			<method name="free" symbol="soup_uri_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
				</parameters>
			</method>
			<method name="host_equal" symbol="soup_uri_host_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="v1" type="gconstpointer"/>
					<parameter name="v2" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="host_hash" symbol="soup_uri_host_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="key" type="gconstpointer"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_uri_new">
				<return-type type="SoupURI*"/>
				<parameters>
					<parameter name="uri_string" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_base" symbol="soup_uri_new_with_base">
				<return-type type="SoupURI*"/>
				<parameters>
					<parameter name="base" type="SoupURI*"/>
					<parameter name="uri_string" type="char*"/>
				</parameters>
			</constructor>
			<method name="normalize" symbol="soup_uri_normalize">
				<return-type type="char*"/>
				<parameters>
					<parameter name="part" type="char*"/>
					<parameter name="unescape_extra" type="char*"/>
				</parameters>
			</method>
			<method name="set_fragment" symbol="soup_uri_set_fragment">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="fragment" type="char*"/>
				</parameters>
			</method>
			<method name="set_host" symbol="soup_uri_set_host">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="host" type="char*"/>
				</parameters>
			</method>
			<method name="set_password" symbol="soup_uri_set_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</method>
			<method name="set_path" symbol="soup_uri_set_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="set_port" symbol="soup_uri_set_port">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="port" type="guint"/>
				</parameters>
			</method>
			<method name="set_query" symbol="soup_uri_set_query">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="query" type="char*"/>
				</parameters>
			</method>
			<method name="set_query_from_fields" symbol="soup_uri_set_query_from_fields">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="first_field" type="char*"/>
				</parameters>
			</method>
			<method name="set_query_from_form" symbol="soup_uri_set_query_from_form">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="form" type="GHashTable*"/>
				</parameters>
			</method>
			<method name="set_scheme" symbol="soup_uri_set_scheme">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="scheme" type="char*"/>
				</parameters>
			</method>
			<method name="set_user" symbol="soup_uri_set_user">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="user" type="char*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="soup_uri_to_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="just_path_and_query" type="gboolean"/>
				</parameters>
			</method>
			<method name="uses_default_port" symbol="soup_uri_uses_default_port">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="uri" type="SoupURI*"/>
				</parameters>
			</method>
			<field name="scheme" type="char*"/>
			<field name="user" type="char*"/>
			<field name="password" type="char*"/>
			<field name="host" type="char*"/>
			<field name="port" type="guint"/>
			<field name="path" type="char*"/>
			<field name="query" type="char*"/>
			<field name="fragment" type="char*"/>
		</boxed>
		<enum name="SoupAddressFamily" type-name="SoupAddressFamily" get-type="soup_address_family_get_type">
			<member name="SOUP_ADDRESS_FAMILY_INVALID" value="-1"/>
			<member name="SOUP_ADDRESS_FAMILY_IPV4" value="2"/>
			<member name="SOUP_ADDRESS_FAMILY_IPV6" value="10"/>
		</enum>
		<enum name="SoupConnectionState" type-name="SoupConnectionState" get-type="soup_connection_state_get_type">
			<member name="SOUP_CONNECTION_NEW" value="0"/>
			<member name="SOUP_CONNECTION_CONNECTING" value="1"/>
			<member name="SOUP_CONNECTION_IDLE" value="2"/>
			<member name="SOUP_CONNECTION_IN_USE" value="3"/>
			<member name="SOUP_CONNECTION_REMOTE_DISCONNECTED" value="4"/>
			<member name="SOUP_CONNECTION_DISCONNECTED" value="5"/>
		</enum>
		<enum name="SoupCookieJarAcceptPolicy" type-name="SoupCookieJarAcceptPolicy" get-type="soup_cookie_jar_accept_policy_get_type">
			<member name="SOUP_COOKIE_JAR_ACCEPT_ALWAYS" value="0"/>
			<member name="SOUP_COOKIE_JAR_ACCEPT_NEVER" value="1"/>
			<member name="SOUP_COOKIE_JAR_ACCEPT_NO_THIRD_PARTY" value="2"/>
		</enum>
		<enum name="SoupDateFormat" type-name="SoupDateFormat" get-type="soup_date_format_get_type">
			<member name="SOUP_DATE_HTTP" value="1"/>
			<member name="SOUP_DATE_COOKIE" value="2"/>
			<member name="SOUP_DATE_RFC2822" value="3"/>
			<member name="SOUP_DATE_ISO8601_COMPACT" value="4"/>
			<member name="SOUP_DATE_ISO8601_FULL" value="5"/>
			<member name="SOUP_DATE_ISO8601" value="5"/>
			<member name="SOUP_DATE_ISO8601_XMLRPC" value="6"/>
		</enum>
		<enum name="SoupEncoding" type-name="SoupEncoding" get-type="soup_encoding_get_type">
			<member name="SOUP_ENCODING_UNRECOGNIZED" value="0"/>
			<member name="SOUP_ENCODING_NONE" value="1"/>
			<member name="SOUP_ENCODING_CONTENT_LENGTH" value="2"/>
			<member name="SOUP_ENCODING_EOF" value="3"/>
			<member name="SOUP_ENCODING_CHUNKED" value="4"/>
			<member name="SOUP_ENCODING_BYTERANGES" value="5"/>
		</enum>
		<enum name="SoupHTTPVersion" type-name="SoupHTTPVersion" get-type="soup_http_version_get_type">
			<member name="SOUP_HTTP_1_0" value="0"/>
			<member name="SOUP_HTTP_1_1" value="1"/>
		</enum>
		<enum name="SoupKnownStatusCode" type-name="SoupKnownStatusCode" get-type="soup_known_status_code_get_type">
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
		<enum name="SoupLoggerLogLevel" type-name="SoupLoggerLogLevel" get-type="soup_logger_log_level_get_type">
			<member name="SOUP_LOGGER_LOG_NONE" value="0"/>
			<member name="SOUP_LOGGER_LOG_MINIMAL" value="1"/>
			<member name="SOUP_LOGGER_LOG_HEADERS" value="2"/>
			<member name="SOUP_LOGGER_LOG_BODY" value="3"/>
		</enum>
		<enum name="SoupMemoryUse" type-name="SoupMemoryUse" get-type="soup_memory_use_get_type">
			<member name="SOUP_MEMORY_STATIC" value="0"/>
			<member name="SOUP_MEMORY_TAKE" value="1"/>
			<member name="SOUP_MEMORY_COPY" value="2"/>
			<member name="SOUP_MEMORY_TEMPORARY" value="3"/>
		</enum>
		<enum name="SoupMessageHeadersType" type-name="SoupMessageHeadersType" get-type="soup_message_headers_type_get_type">
			<member name="SOUP_MESSAGE_HEADERS_REQUEST" value="0"/>
			<member name="SOUP_MESSAGE_HEADERS_RESPONSE" value="1"/>
			<member name="SOUP_MESSAGE_HEADERS_MULTIPART" value="2"/>
		</enum>
		<enum name="SoupSSLError" type-name="SoupSSLError" get-type="soup_ssl_error_get_type">
			<member name="SOUP_SSL_ERROR_HANDSHAKE_NEEDS_READ" value="0"/>
			<member name="SOUP_SSL_ERROR_HANDSHAKE_NEEDS_WRITE" value="1"/>
			<member name="SOUP_SSL_ERROR_CERTIFICATE" value="2"/>
		</enum>
		<enum name="SoupSocketIOStatus" type-name="SoupSocketIOStatus" get-type="soup_socket_io_status_get_type">
			<member name="SOUP_SOCKET_OK" value="0"/>
			<member name="SOUP_SOCKET_WOULD_BLOCK" value="1"/>
			<member name="SOUP_SOCKET_EOF" value="2"/>
			<member name="SOUP_SOCKET_ERROR" value="3"/>
		</enum>
		<enum name="SoupXMLRPCError" type-name="SoupXMLRPCError" get-type="soup_xmlrpc_error_get_type">
			<member name="SOUP_XMLRPC_ERROR_ARGUMENTS" value="0"/>
			<member name="SOUP_XMLRPC_ERROR_RETVAL" value="1"/>
		</enum>
		<enum name="SoupXMLRPCFault" type-name="SoupXMLRPCFault" get-type="soup_xmlrpc_fault_get_type">
			<member name="SOUP_XMLRPC_FAULT_PARSE_ERROR_NOT_WELL_FORMED" value="-32700"/>
			<member name="SOUP_XMLRPC_FAULT_PARSE_ERROR_UNSUPPORTED_ENCODING" value="-32701"/>
			<member name="SOUP_XMLRPC_FAULT_PARSE_ERROR_INVALID_CHARACTER_FOR_ENCODING" value="-32702"/>
			<member name="SOUP_XMLRPC_FAULT_SERVER_ERROR_INVALID_XML_RPC" value="-32600"/>
			<member name="SOUP_XMLRPC_FAULT_SERVER_ERROR_REQUESTED_METHOD_NOT_FOUND" value="-32601"/>
			<member name="SOUP_XMLRPC_FAULT_SERVER_ERROR_INVALID_METHOD_PARAMETERS" value="-32602"/>
			<member name="SOUP_XMLRPC_FAULT_SERVER_ERROR_INTERNAL_XML_RPC_ERROR" value="-32603"/>
			<member name="SOUP_XMLRPC_FAULT_APPLICATION_ERROR" value="-32500"/>
			<member name="SOUP_XMLRPC_FAULT_SYSTEM_ERROR" value="-32400"/>
			<member name="SOUP_XMLRPC_FAULT_TRANSPORT_ERROR" value="-32300"/>
		</enum>
		<flags name="SoupExpectation" type-name="SoupExpectation" get-type="soup_expectation_get_type">
			<member name="SOUP_EXPECTATION_UNRECOGNIZED" value="1"/>
			<member name="SOUP_EXPECTATION_CONTINUE" value="2"/>
		</flags>
		<flags name="SoupMessageFlags" type-name="SoupMessageFlags" get-type="soup_message_flags_get_type">
			<member name="SOUP_MESSAGE_NO_REDIRECT" value="2"/>
			<member name="SOUP_MESSAGE_OVERWRITE_CHUNKS" value="8"/>
			<member name="SOUP_MESSAGE_CONTENT_DECODED" value="16"/>
			<member name="SOUP_MESSAGE_CERTIFICATE_TRUSTED" value="32"/>
		</flags>
		<object name="SoupAddress" parent="GObject" type-name="SoupAddress" get-type="soup_address_get_type">
			<method name="equal_by_ip" symbol="soup_address_equal_by_ip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="addr1" type="gconstpointer"/>
					<parameter name="addr2" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="equal_by_name" symbol="soup_address_equal_by_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="addr1" type="gconstpointer"/>
					<parameter name="addr2" type="gconstpointer"/>
				</parameters>
			</method>
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
			<method name="hash_by_ip" symbol="soup_address_hash_by_ip">
				<return-type type="guint"/>
				<parameters>
					<parameter name="addr" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="hash_by_name" symbol="soup_address_hash_by_name">
				<return-type type="guint"/>
				<parameters>
					<parameter name="addr" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="is_resolved" symbol="soup_address_is_resolved">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="addr" type="SoupAddress*"/>
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
					<parameter name="async_context" type="GMainContext*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="SoupAddressCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="resolve_sync" symbol="soup_address_resolve_sync">
				<return-type type="guint"/>
				<parameters>
					<parameter name="addr" type="SoupAddress*"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<property name="family" type="SoupAddressFamily" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="physical" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="port" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="sockaddr" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="SoupAuth" parent="GObject" type-name="SoupAuth" get-type="soup_auth_get_type">
			<method name="authenticate" symbol="soup_auth_authenticate">
				<return-type type="void"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
					<parameter name="username" type="char*"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</method>
			<method name="free_protection_space" symbol="soup_auth_free_protection_space">
				<return-type type="void"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
					<parameter name="space" type="GSList*"/>
				</parameters>
			</method>
			<method name="get_authorization" symbol="soup_auth_get_authorization">
				<return-type type="char*"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="get_host" symbol="soup_auth_get_host">
				<return-type type="char*"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
				</parameters>
			</method>
			<method name="get_info" symbol="soup_auth_get_info">
				<return-type type="char*"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
				</parameters>
			</method>
			<method name="get_protection_space" symbol="soup_auth_get_protection_space">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
					<parameter name="source_uri" type="SoupURI*"/>
				</parameters>
			</method>
			<method name="get_realm" symbol="soup_auth_get_realm">
				<return-type type="char*"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
				</parameters>
			</method>
			<method name="get_scheme_name" symbol="soup_auth_get_scheme_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
				</parameters>
			</method>
			<method name="is_authenticated" symbol="soup_auth_is_authenticated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
				</parameters>
			</method>
			<method name="is_for_proxy" symbol="soup_auth_is_for_proxy">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_auth_new">
				<return-type type="SoupAuth*"/>
				<parameters>
					<parameter name="type" type="GType"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="auth_header" type="char*"/>
				</parameters>
			</constructor>
			<method name="update" symbol="soup_auth_update">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="auth_header" type="char*"/>
				</parameters>
			</method>
			<property name="host" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="is-authenticated" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-for-proxy" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="realm" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="scheme-name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="save-password" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupAuth*"/>
					<parameter name="p0" type="char*"/>
					<parameter name="p1" type="char*"/>
				</parameters>
			</signal>
			<vfunc name="authenticate">
				<return-type type="void"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
					<parameter name="username" type="char*"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_authorization">
				<return-type type="char*"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_protection_space">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
					<parameter name="source_uri" type="SoupURI*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_authenticated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
				</parameters>
			</vfunc>
			<vfunc name="update">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="auth" type="SoupAuth*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="auth_params" type="GHashTable*"/>
				</parameters>
			</vfunc>
			<field name="realm" type="char*"/>
		</object>
		<object name="SoupAuthDomain" parent="GObject" type-name="SoupAuthDomain" get-type="soup_auth_domain_get_type">
			<method name="accepts" symbol="soup_auth_domain_accepts">
				<return-type type="char*"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="add_path" symbol="soup_auth_domain_add_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="challenge" symbol="soup_auth_domain_challenge">
				<return-type type="void"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="check_password" symbol="soup_auth_domain_check_password">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="username" type="char*"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</method>
			<method name="covers" symbol="soup_auth_domain_covers">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="get_realm" symbol="soup_auth_domain_get_realm">
				<return-type type="char*"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
				</parameters>
			</method>
			<method name="remove_path" symbol="soup_auth_domain_remove_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="set_filter" symbol="soup_auth_domain_set_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="filter" type="SoupAuthDomainFilter"/>
					<parameter name="filter_data" type="gpointer"/>
					<parameter name="dnotify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_generic_auth_callback" symbol="soup_auth_domain_set_generic_auth_callback">
				<return-type type="void"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="auth_callback" type="SoupAuthDomainGenericAuthCallback"/>
					<parameter name="auth_data" type="gpointer"/>
					<parameter name="dnotify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="try_generic_auth_callback" symbol="soup_auth_domain_try_generic_auth_callback">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="username" type="char*"/>
				</parameters>
			</method>
			<property name="add-path" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="filter" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="filter-data" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="generic-auth-callback" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="generic-auth-data" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="proxy" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="realm" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="remove-path" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<vfunc name="accepts">
				<return-type type="char*"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="header" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="challenge">
				<return-type type="char*"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="check_password">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="username" type="char*"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="SoupAuthDomainBasic" parent="SoupAuthDomain" type-name="SoupAuthDomainBasic" get-type="soup_auth_domain_basic_get_type">
			<constructor name="new" symbol="soup_auth_domain_basic_new">
				<return-type type="SoupAuthDomain*"/>
				<parameters>
					<parameter name="optname1" type="char*"/>
				</parameters>
			</constructor>
			<method name="set_auth_callback" symbol="soup_auth_domain_basic_set_auth_callback">
				<return-type type="void"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="callback" type="SoupAuthDomainBasicAuthCallback"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="dnotify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<property name="auth-callback" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="auth-data" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="SoupAuthDomainDigest" parent="SoupAuthDomain" type-name="SoupAuthDomainDigest" get-type="soup_auth_domain_digest_get_type">
			<method name="encode_password" symbol="soup_auth_domain_digest_encode_password">
				<return-type type="char*"/>
				<parameters>
					<parameter name="username" type="char*"/>
					<parameter name="realm" type="char*"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_auth_domain_digest_new">
				<return-type type="SoupAuthDomain*"/>
				<parameters>
					<parameter name="optname1" type="char*"/>
				</parameters>
			</constructor>
			<method name="set_auth_callback" symbol="soup_auth_domain_digest_set_auth_callback">
				<return-type type="void"/>
				<parameters>
					<parameter name="domain" type="SoupAuthDomain*"/>
					<parameter name="callback" type="SoupAuthDomainDigestAuthCallback"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="dnotify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<property name="auth-callback" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="auth-data" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="SoupContentDecoder" parent="GObject" type-name="SoupContentDecoder" get-type="soup_content_decoder_get_type">
			<implements>
				<interface name="SoupSessionFeature"/>
			</implements>
		</object>
		<object name="SoupContentSniffer" parent="GObject" type-name="SoupContentSniffer" get-type="soup_content_sniffer_get_type">
			<implements>
				<interface name="SoupSessionFeature"/>
			</implements>
			<constructor name="new" symbol="soup_content_sniffer_new">
				<return-type type="SoupContentSniffer*"/>
			</constructor>
			<method name="sniff" symbol="soup_content_sniffer_sniff">
				<return-type type="char*"/>
				<parameters>
					<parameter name="sniffer" type="SoupContentSniffer*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="buffer" type="SoupBuffer*"/>
					<parameter name="params" type="GHashTable**"/>
				</parameters>
			</method>
			<vfunc name="get_buffer_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="sniffer" type="SoupContentSniffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="sniff">
				<return-type type="char*"/>
				<parameters>
					<parameter name="sniffer" type="SoupContentSniffer*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="buffer" type="SoupBuffer*"/>
					<parameter name="params" type="GHashTable**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="SoupCookieJar" parent="GObject" type-name="SoupCookieJar" get-type="soup_cookie_jar_get_type">
			<implements>
				<interface name="SoupSessionFeature"/>
			</implements>
			<method name="add_cookie" symbol="soup_cookie_jar_add_cookie">
				<return-type type="void"/>
				<parameters>
					<parameter name="jar" type="SoupCookieJar*"/>
					<parameter name="cookie" type="SoupCookie*"/>
				</parameters>
			</method>
			<method name="all_cookies" symbol="soup_cookie_jar_all_cookies">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="jar" type="SoupCookieJar*"/>
				</parameters>
			</method>
			<method name="delete_cookie" symbol="soup_cookie_jar_delete_cookie">
				<return-type type="void"/>
				<parameters>
					<parameter name="jar" type="SoupCookieJar*"/>
					<parameter name="cookie" type="SoupCookie*"/>
				</parameters>
			</method>
			<method name="get_accept_policy" symbol="soup_cookie_jar_get_accept_policy">
				<return-type type="SoupCookieJarAcceptPolicy"/>
				<parameters>
					<parameter name="jar" type="SoupCookieJar*"/>
				</parameters>
			</method>
			<method name="get_cookies" symbol="soup_cookie_jar_get_cookies">
				<return-type type="char*"/>
				<parameters>
					<parameter name="jar" type="SoupCookieJar*"/>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="for_http" type="gboolean"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_cookie_jar_new">
				<return-type type="SoupCookieJar*"/>
			</constructor>
			<method name="save" symbol="soup_cookie_jar_save">
				<return-type type="void"/>
				<parameters>
					<parameter name="jar" type="SoupCookieJar*"/>
				</parameters>
			</method>
			<method name="set_accept_policy" symbol="soup_cookie_jar_set_accept_policy">
				<return-type type="void"/>
				<parameters>
					<parameter name="jar" type="SoupCookieJar*"/>
					<parameter name="policy" type="SoupCookieJarAcceptPolicy"/>
				</parameters>
			</method>
			<method name="set_cookie" symbol="soup_cookie_jar_set_cookie">
				<return-type type="void"/>
				<parameters>
					<parameter name="jar" type="SoupCookieJar*"/>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="cookie" type="char*"/>
				</parameters>
			</method>
			<method name="set_cookie_with_first_party" symbol="soup_cookie_jar_set_cookie_with_first_party">
				<return-type type="void"/>
				<parameters>
					<parameter name="jar" type="SoupCookieJar*"/>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="first_party" type="SoupURI*"/>
					<parameter name="cookie" type="char*"/>
				</parameters>
			</method>
			<property name="accept-policy" type="SoupCookieJarAcceptPolicy" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="read-only" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="jar" type="SoupCookieJar*"/>
					<parameter name="old_cookie" type="SoupCookie*"/>
					<parameter name="new_cookie" type="SoupCookie*"/>
				</parameters>
			</signal>
			<vfunc name="save">
				<return-type type="void"/>
				<parameters>
					<parameter name="jar" type="SoupCookieJar*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="SoupCookieJarText" parent="SoupCookieJar" type-name="SoupCookieJarText" get-type="soup_cookie_jar_text_get_type">
			<implements>
				<interface name="SoupSessionFeature"/>
			</implements>
			<constructor name="new" symbol="soup_cookie_jar_text_new">
				<return-type type="SoupCookieJar*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="read_only" type="gboolean"/>
				</parameters>
			</constructor>
			<property name="filename" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="SoupLogger" parent="GObject" type-name="SoupLogger" get-type="soup_logger_get_type">
			<implements>
				<interface name="SoupSessionFeature"/>
			</implements>
			<method name="attach" symbol="soup_logger_attach">
				<return-type type="void"/>
				<parameters>
					<parameter name="logger" type="SoupLogger*"/>
					<parameter name="session" type="SoupSession*"/>
				</parameters>
			</method>
			<method name="detach" symbol="soup_logger_detach">
				<return-type type="void"/>
				<parameters>
					<parameter name="logger" type="SoupLogger*"/>
					<parameter name="session" type="SoupSession*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_logger_new">
				<return-type type="SoupLogger*"/>
				<parameters>
					<parameter name="level" type="SoupLoggerLogLevel"/>
					<parameter name="max_body_size" type="int"/>
				</parameters>
			</constructor>
			<method name="set_printer" symbol="soup_logger_set_printer">
				<return-type type="void"/>
				<parameters>
					<parameter name="logger" type="SoupLogger*"/>
					<parameter name="printer" type="SoupLoggerPrinter"/>
					<parameter name="printer_data" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_request_filter" symbol="soup_logger_set_request_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="logger" type="SoupLogger*"/>
					<parameter name="request_filter" type="SoupLoggerFilter"/>
					<parameter name="filter_data" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_response_filter" symbol="soup_logger_set_response_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="logger" type="SoupLogger*"/>
					<parameter name="response_filter" type="SoupLoggerFilter"/>
					<parameter name="filter_data" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
		</object>
		<object name="SoupMessage" parent="GObject" type-name="SoupMessage" get-type="soup_message_get_type">
			<method name="add_header_handler" symbol="soup_message_add_header_handler">
				<return-type type="guint"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="signal" type="char*"/>
					<parameter name="header" type="char*"/>
					<parameter name="callback" type="GCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="add_status_code_handler" symbol="soup_message_add_status_code_handler">
				<return-type type="guint"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="signal" type="char*"/>
					<parameter name="status_code" type="guint"/>
					<parameter name="callback" type="GCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="content_sniffed" symbol="soup_message_content_sniffed">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="params" type="GHashTable*"/>
				</parameters>
			</method>
			<method name="disable_feature" symbol="soup_message_disable_feature">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="feature_type" type="GType"/>
				</parameters>
			</method>
			<method name="finished" symbol="soup_message_finished">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="get_address" symbol="soup_message_get_address">
				<return-type type="SoupAddress*"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="get_first_party" symbol="soup_message_get_first_party">
				<return-type type="SoupURI*"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="soup_message_get_flags">
				<return-type type="SoupMessageFlags"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="get_http_version" symbol="soup_message_get_http_version">
				<return-type type="SoupHTTPVersion"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="soup_message_get_uri">
				<return-type type="SoupURI*"/>
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
					<parameter name="chunk" type="SoupBuffer*"/>
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
					<parameter name="uri" type="SoupURI*"/>
				</parameters>
			</constructor>
			<method name="restarted" symbol="soup_message_restarted">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="set_chunk_allocator" symbol="soup_message_set_chunk_allocator">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="allocator" type="SoupChunkAllocator"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="destroy_notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_first_party" symbol="soup_message_set_first_party">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="first_party" type="SoupURI*"/>
				</parameters>
			</method>
			<method name="set_flags" symbol="soup_message_set_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="flags" type="SoupMessageFlags"/>
				</parameters>
			</method>
			<method name="set_http_version" symbol="soup_message_set_http_version">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="version" type="SoupHTTPVersion"/>
				</parameters>
			</method>
			<method name="set_request" symbol="soup_message_set_request">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="req_use" type="SoupMemoryUse"/>
					<parameter name="req_body" type="char*"/>
					<parameter name="req_length" type="gsize"/>
				</parameters>
			</method>
			<method name="set_response" symbol="soup_message_set_response">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="resp_use" type="SoupMemoryUse"/>
					<parameter name="resp_body" type="char*"/>
					<parameter name="resp_length" type="gsize"/>
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
					<parameter name="uri" type="SoupURI*"/>
				</parameters>
			</method>
			<method name="wrote_body" symbol="soup_message_wrote_body">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="wrote_body_data" symbol="soup_message_wrote_body_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="chunk" type="SoupBuffer*"/>
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
			<property name="first-party" type="SoupURI*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="flags" type="SoupMessageFlags" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="http-version" type="SoupHTTPVersion" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="method" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="reason-phrase" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="server-side" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="status-code" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="uri" type="SoupURI*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="content-sniffed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupMessage*"/>
					<parameter name="p0" type="char*"/>
					<parameter name="p1" type="GHashTable*"/>
				</parameters>
			</signal>
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
					<parameter name="chunk" type="SoupBuffer*"/>
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
			<signal name="wrote-body-data" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupMessage*"/>
					<parameter name="p0" type="SoupBuffer*"/>
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
			<field name="request_body" type="SoupMessageBody*"/>
			<field name="request_headers" type="SoupMessageHeaders*"/>
			<field name="response_body" type="SoupMessageBody*"/>
			<field name="response_headers" type="SoupMessageHeaders*"/>
		</object>
		<object name="SoupServer" parent="GObject" type-name="SoupServer" get-type="soup_server_get_type">
			<method name="add_auth_domain" symbol="soup_server_add_auth_domain">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
					<parameter name="auth_domain" type="SoupAuthDomain*"/>
				</parameters>
			</method>
			<method name="add_handler" symbol="soup_server_add_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
					<parameter name="path" type="char*"/>
					<parameter name="callback" type="SoupServerCallback"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="get_async_context" symbol="soup_server_get_async_context">
				<return-type type="GMainContext*"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
				</parameters>
			</method>
			<method name="get_listener" symbol="soup_server_get_listener">
				<return-type type="SoupSocket*"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="soup_server_get_port">
				<return-type type="guint"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
				</parameters>
			</method>
			<method name="is_https" symbol="soup_server_is_https">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="soup_server_new">
				<return-type type="SoupServer*"/>
				<parameters>
					<parameter name="optname1" type="char*"/>
				</parameters>
			</constructor>
			<method name="pause_message" symbol="soup_server_pause_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="quit" symbol="soup_server_quit">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
				</parameters>
			</method>
			<method name="remove_auth_domain" symbol="soup_server_remove_auth_domain">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
					<parameter name="auth_domain" type="SoupAuthDomain*"/>
				</parameters>
			</method>
			<method name="remove_handler" symbol="soup_server_remove_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="run" symbol="soup_server_run">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
				</parameters>
			</method>
			<method name="run_async" symbol="soup_server_run_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
				</parameters>
			</method>
			<method name="unpause_message" symbol="soup_server_unpause_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<property name="async-context" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="interface" type="SoupAddress*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="port" type="guint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="raw-paths" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="server-header" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="ssl-cert-file" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="ssl-key-file" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="request-aborted" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="client" type="SoupClientContext*"/>
				</parameters>
			</signal>
			<signal name="request-finished" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="client" type="SoupClientContext*"/>
				</parameters>
			</signal>
			<signal name="request-read" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="client" type="SoupClientContext*"/>
				</parameters>
			</signal>
			<signal name="request-started" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="SoupServer*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="client" type="SoupClientContext*"/>
				</parameters>
			</signal>
		</object>
		<object name="SoupSession" parent="GObject" type-name="SoupSession" get-type="soup_session_get_type">
			<method name="abort" symbol="soup_session_abort">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
				</parameters>
			</method>
			<method name="add_feature" symbol="soup_session_add_feature">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="feature" type="SoupSessionFeature*"/>
				</parameters>
			</method>
			<method name="add_feature_by_type" symbol="soup_session_add_feature_by_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="feature_type" type="GType"/>
				</parameters>
			</method>
			<method name="cancel_message" symbol="soup_session_cancel_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="status_code" type="guint"/>
				</parameters>
			</method>
			<method name="get_async_context" symbol="soup_session_get_async_context">
				<return-type type="GMainContext*"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
				</parameters>
			</method>
			<method name="get_feature" symbol="soup_session_get_feature">
				<return-type type="SoupSessionFeature*"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="feature_type" type="GType"/>
				</parameters>
			</method>
			<method name="get_feature_for_message" symbol="soup_session_get_feature_for_message">
				<return-type type="SoupSessionFeature*"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="feature_type" type="GType"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="get_features" symbol="soup_session_get_features">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="feature_type" type="GType"/>
				</parameters>
			</method>
			<method name="pause_message" symbol="soup_session_pause_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<method name="prepare_for_uri" symbol="soup_session_prepare_for_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="uri" type="SoupURI*"/>
				</parameters>
			</method>
			<method name="queue_message" symbol="soup_session_queue_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="callback" type="SoupSessionCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="remove_feature" symbol="soup_session_remove_feature">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="feature" type="SoupSessionFeature*"/>
				</parameters>
			</method>
			<method name="remove_feature_by_type" symbol="soup_session_remove_feature_by_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="feature_type" type="GType"/>
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
			<method name="unpause_message" symbol="soup_session_unpause_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</method>
			<property name="accept-language" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="accept-language-auto" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="add-feature" type="SoupSessionFeature*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="add-feature-by-type" type="GType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="async-context" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="idle-timeout" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-conns" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-conns-per-host" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="proxy-uri" type="SoupURI*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="remove-feature-by-type" type="GType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ssl-ca-file" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ssl-strict" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="timeout" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-ntlm" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="user-agent" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="authenticate" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="auth" type="SoupAuth*"/>
					<parameter name="retrying" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="connection-created" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupSession*"/>
					<parameter name="p0" type="GObject*"/>
				</parameters>
			</signal>
			<signal name="request-queued" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupSession*"/>
					<parameter name="p0" type="SoupMessage*"/>
				</parameters>
			</signal>
			<signal name="request-started" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="socket" type="SoupSocket*"/>
				</parameters>
			</signal>
			<signal name="request-unqueued" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupSession*"/>
					<parameter name="p0" type="SoupMessage*"/>
				</parameters>
			</signal>
			<signal name="tunneling" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="SoupSession*"/>
					<parameter name="p0" type="GObject*"/>
				</parameters>
			</signal>
			<vfunc name="auth_required">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="auth" type="SoupAuth*"/>
					<parameter name="retrying" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="cancel_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="status_code" type="guint"/>
				</parameters>
			</vfunc>
			<vfunc name="queue_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="callback" type="SoupSessionCallback"/>
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
		</object>
		<object name="SoupSessionAsync" parent="SoupSession" type-name="SoupSessionAsync" get-type="soup_session_async_get_type">
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
		<object name="SoupSocket" parent="GObject" type-name="SoupSocket" get-type="soup_socket_get_type">
			<method name="connect_async" symbol="soup_socket_connect_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="SoupSocketCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="connect_sync" symbol="soup_socket_connect_sync">
				<return-type type="guint"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="disconnect" symbol="soup_socket_disconnect">
				<return-type type="void"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
				</parameters>
			</method>
			<method name="get_fd" symbol="soup_socket_get_fd">
				<return-type type="int"/>
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
			<method name="is_ssl" symbol="soup_socket_is_ssl">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
				</parameters>
			</method>
			<method name="listen" symbol="soup_socket_listen">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
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
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
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
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="start_proxy_ssl" symbol="soup_socket_start_proxy_ssl">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
					<parameter name="ssl_host" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="start_ssl" symbol="soup_socket_start_ssl">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="write" symbol="soup_socket_write">
				<return-type type="SoupSocketIOStatus"/>
				<parameters>
					<parameter name="sock" type="SoupSocket*"/>
					<parameter name="buffer" type="gconstpointer"/>
					<parameter name="len" type="gsize"/>
					<parameter name="nwrote" type="gsize*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="async-context" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="is-server" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="local-address" type="SoupAddress*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="non-blocking" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="remote-address" type="SoupAddress*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="ssl-creds" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ssl-strict" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="timeout" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="trusted-certificate" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
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
		<interface name="SoupProxyResolver" type-name="SoupProxyResolver" get-type="soup_proxy_resolver_get_type">
			<requires>
				<interface name="SoupSessionFeature"/>
				<interface name="GObject"/>
			</requires>
			<method name="get_proxy_async" symbol="soup_proxy_resolver_get_proxy_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy_resolver" type="SoupProxyResolver*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="async_context" type="GMainContext*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="SoupProxyResolverCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_proxy_sync" symbol="soup_proxy_resolver_get_proxy_sync">
				<return-type type="guint"/>
				<parameters>
					<parameter name="proxy_resolver" type="SoupProxyResolver*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="addr" type="SoupAddress**"/>
				</parameters>
			</method>
			<vfunc name="get_proxy_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="p1" type="SoupProxyResolver*"/>
					<parameter name="p2" type="SoupMessage*"/>
					<parameter name="p3" type="GMainContext*"/>
					<parameter name="p4" type="GCancellable*"/>
					<parameter name="p5" type="SoupProxyResolverCallback"/>
					<parameter name="p6" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="get_proxy_sync">
				<return-type type="guint"/>
				<parameters>
					<parameter name="p1" type="SoupProxyResolver*"/>
					<parameter name="p2" type="SoupMessage*"/>
					<parameter name="p3" type="GCancellable*"/>
					<parameter name="p4" type="SoupAddress**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="SoupProxyURIResolver" type-name="SoupProxyURIResolver" get-type="soup_proxy_uri_resolver_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="get_proxy_uri_async" symbol="soup_proxy_uri_resolver_get_proxy_uri_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy_uri_resolver" type="SoupProxyURIResolver*"/>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="async_context" type="GMainContext*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="SoupProxyURIResolverCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_proxy_uri_sync" symbol="soup_proxy_uri_resolver_get_proxy_uri_sync">
				<return-type type="guint"/>
				<parameters>
					<parameter name="proxy_uri_resolver" type="SoupProxyURIResolver*"/>
					<parameter name="uri" type="SoupURI*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="proxy_uri" type="SoupURI**"/>
				</parameters>
			</method>
			<vfunc name="get_proxy_uri_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="p1" type="SoupProxyURIResolver*"/>
					<parameter name="p2" type="SoupURI*"/>
					<parameter name="p3" type="GMainContext*"/>
					<parameter name="p4" type="GCancellable*"/>
					<parameter name="p5" type="SoupProxyURIResolverCallback"/>
					<parameter name="p6" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="get_proxy_uri_sync">
				<return-type type="guint"/>
				<parameters>
					<parameter name="p1" type="SoupProxyURIResolver*"/>
					<parameter name="p2" type="SoupURI*"/>
					<parameter name="p3" type="GCancellable*"/>
					<parameter name="p4" type="SoupURI**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="SoupSessionFeature" type-name="SoupSessionFeature" get-type="soup_session_feature_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="attach" symbol="soup_session_feature_attach">
				<return-type type="void"/>
				<parameters>
					<parameter name="feature" type="SoupSessionFeature*"/>
					<parameter name="session" type="SoupSession*"/>
				</parameters>
			</method>
			<method name="detach" symbol="soup_session_feature_detach">
				<return-type type="void"/>
				<parameters>
					<parameter name="feature" type="SoupSessionFeature*"/>
					<parameter name="session" type="SoupSession*"/>
				</parameters>
			</method>
			<vfunc name="attach">
				<return-type type="void"/>
				<parameters>
					<parameter name="feature" type="SoupSessionFeature*"/>
					<parameter name="session" type="SoupSession*"/>
				</parameters>
			</vfunc>
			<vfunc name="detach">
				<return-type type="void"/>
				<parameters>
					<parameter name="feature" type="SoupSessionFeature*"/>
					<parameter name="session" type="SoupSession*"/>
				</parameters>
			</vfunc>
			<vfunc name="request_queued">
				<return-type type="void"/>
				<parameters>
					<parameter name="feature" type="SoupSessionFeature*"/>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="request_started">
				<return-type type="void"/>
				<parameters>
					<parameter name="feature" type="SoupSessionFeature*"/>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
					<parameter name="socket" type="SoupSocket*"/>
				</parameters>
			</vfunc>
			<vfunc name="request_unqueued">
				<return-type type="void"/>
				<parameters>
					<parameter name="feature" type="SoupSessionFeature*"/>
					<parameter name="session" type="SoupSession*"/>
					<parameter name="msg" type="SoupMessage*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="SOUP_ADDRESS_ANY_PORT" type="int" value="0"/>
		<constant name="SOUP_ADDRESS_FAMILY" type="char*" value="family"/>
		<constant name="SOUP_ADDRESS_NAME" type="char*" value="name"/>
		<constant name="SOUP_ADDRESS_PHYSICAL" type="char*" value="physical"/>
		<constant name="SOUP_ADDRESS_PORT" type="char*" value="port"/>
		<constant name="SOUP_ADDRESS_SOCKADDR" type="char*" value="sockaddr"/>
		<constant name="SOUP_AUTH_DOMAIN_ADD_PATH" type="char*" value="add-path"/>
		<constant name="SOUP_AUTH_DOMAIN_BASIC_AUTH_CALLBACK" type="char*" value="auth-callback"/>
		<constant name="SOUP_AUTH_DOMAIN_BASIC_AUTH_DATA" type="char*" value="auth-data"/>
		<constant name="SOUP_AUTH_DOMAIN_BASIC_H" type="int" value="1"/>
		<constant name="SOUP_AUTH_DOMAIN_DIGEST_AUTH_CALLBACK" type="char*" value="auth-callback"/>
		<constant name="SOUP_AUTH_DOMAIN_DIGEST_AUTH_DATA" type="char*" value="auth-data"/>
		<constant name="SOUP_AUTH_DOMAIN_DIGEST_H" type="int" value="1"/>
		<constant name="SOUP_AUTH_DOMAIN_FILTER" type="char*" value="filter"/>
		<constant name="SOUP_AUTH_DOMAIN_FILTER_DATA" type="char*" value="filter-data"/>
		<constant name="SOUP_AUTH_DOMAIN_GENERIC_AUTH_CALLBACK" type="char*" value="generic-auth-callback"/>
		<constant name="SOUP_AUTH_DOMAIN_GENERIC_AUTH_DATA" type="char*" value="generic-auth-data"/>
		<constant name="SOUP_AUTH_DOMAIN_H" type="int" value="1"/>
		<constant name="SOUP_AUTH_DOMAIN_PROXY" type="char*" value="proxy"/>
		<constant name="SOUP_AUTH_DOMAIN_REALM" type="char*" value="realm"/>
		<constant name="SOUP_AUTH_DOMAIN_REMOVE_PATH" type="char*" value="remove-path"/>
		<constant name="SOUP_AUTH_H" type="int" value="1"/>
		<constant name="SOUP_AUTH_HOST" type="char*" value="host"/>
		<constant name="SOUP_AUTH_IS_AUTHENTICATED" type="char*" value="is-authenticated"/>
		<constant name="SOUP_AUTH_IS_FOR_PROXY" type="char*" value="is-for-proxy"/>
		<constant name="SOUP_AUTH_REALM" type="char*" value="realm"/>
		<constant name="SOUP_AUTH_SCHEME_NAME" type="char*" value="scheme-name"/>
		<constant name="SOUP_CONTENT_DECODER_H" type="int" value="1"/>
		<constant name="SOUP_CONTENT_SNIFFER_H" type="int" value="1"/>
		<constant name="SOUP_COOKIE_H" type="int" value="1"/>
		<constant name="SOUP_COOKIE_JAR_ACCEPT_POLICY" type="char*" value="accept-policy"/>
		<constant name="SOUP_COOKIE_JAR_H" type="int" value="1"/>
		<constant name="SOUP_COOKIE_JAR_READ_ONLY" type="char*" value="read-only"/>
		<constant name="SOUP_COOKIE_JAR_TEXT_FILENAME" type="char*" value="filename"/>
		<constant name="SOUP_COOKIE_JAR_TEXT_H" type="int" value="1"/>
		<constant name="SOUP_COOKIE_MAX_AGE_ONE_DAY" type="int" value="0"/>
		<constant name="SOUP_COOKIE_MAX_AGE_ONE_HOUR" type="int" value="3600"/>
		<constant name="SOUP_COOKIE_MAX_AGE_ONE_WEEK" type="int" value="0"/>
		<constant name="SOUP_COOKIE_MAX_AGE_ONE_YEAR" type="int" value="0"/>
		<constant name="SOUP_DATE_H" type="int" value="1"/>
		<constant name="SOUP_FORM_H" type="int" value="1"/>
		<constant name="SOUP_FORM_MIME_TYPE_MULTIPART" type="char*" value="multipart/form-data"/>
		<constant name="SOUP_FORM_MIME_TYPE_URLENCODED" type="char*" value="application/x-www-form-urlencoded"/>
		<constant name="SOUP_H" type="int" value="1"/>
		<constant name="SOUP_HEADERS_H" type="int" value="1"/>
		<constant name="SOUP_LOGGER_H" type="int" value="1"/>
		<constant name="SOUP_MESSAGE_BODY_H" type="int" value="1"/>
		<constant name="SOUP_MESSAGE_FIRST_PARTY" type="char*" value="first-party"/>
		<constant name="SOUP_MESSAGE_FLAGS" type="char*" value="flags"/>
		<constant name="SOUP_MESSAGE_H" type="int" value="1"/>
		<constant name="SOUP_MESSAGE_HEADERS_H" type="int" value="1"/>
		<constant name="SOUP_MESSAGE_HTTP_VERSION" type="char*" value="http-version"/>
		<constant name="SOUP_MESSAGE_METHOD" type="char*" value="method"/>
		<constant name="SOUP_MESSAGE_REASON_PHRASE" type="char*" value="reason-phrase"/>
		<constant name="SOUP_MESSAGE_SERVER_SIDE" type="char*" value="server-side"/>
		<constant name="SOUP_MESSAGE_STATUS_CODE" type="char*" value="status-code"/>
		<constant name="SOUP_MESSAGE_URI" type="char*" value="uri"/>
		<constant name="SOUP_METHOD_H" type="int" value="1"/>
		<constant name="SOUP_MISC_H" type="int" value="1"/>
		<constant name="SOUP_MULTIPART_H" type="int" value="1"/>
		<constant name="SOUP_PASSWORD_MANAGER_H" type="int" value="1"/>
		<constant name="SOUP_PROXY_RESOLVER_H" type="int" value="1"/>
		<constant name="SOUP_PROXY_URI_RESOLVER_H" type="int" value="1"/>
		<constant name="SOUP_SERVER_ASYNC_CONTEXT" type="char*" value="async-context"/>
		<constant name="SOUP_SERVER_H" type="int" value="1"/>
		<constant name="SOUP_SERVER_INTERFACE" type="char*" value="interface"/>
		<constant name="SOUP_SERVER_PORT" type="char*" value="port"/>
		<constant name="SOUP_SERVER_RAW_PATHS" type="char*" value="raw-paths"/>
		<constant name="SOUP_SERVER_SERVER_HEADER" type="char*" value="server-header"/>
		<constant name="SOUP_SERVER_SSL_CERT_FILE" type="char*" value="ssl-cert-file"/>
		<constant name="SOUP_SERVER_SSL_KEY_FILE" type="char*" value="ssl-key-file"/>
		<constant name="SOUP_SESSION_ACCEPT_LANGUAGE" type="char*" value="accept-language"/>
		<constant name="SOUP_SESSION_ACCEPT_LANGUAGE_AUTO" type="char*" value="accept-language-auto"/>
		<constant name="SOUP_SESSION_ADD_FEATURE" type="char*" value="add-feature"/>
		<constant name="SOUP_SESSION_ADD_FEATURE_BY_TYPE" type="char*" value="add-feature-by-type"/>
		<constant name="SOUP_SESSION_ASYNC_CONTEXT" type="char*" value="async-context"/>
		<constant name="SOUP_SESSION_ASYNC_H" type="int" value="1"/>
		<constant name="SOUP_SESSION_FEATURE_H" type="int" value="1"/>
		<constant name="SOUP_SESSION_H" type="int" value="1"/>
		<constant name="SOUP_SESSION_IDLE_TIMEOUT" type="char*" value="idle-timeout"/>
		<constant name="SOUP_SESSION_MAX_CONNS" type="char*" value="max-conns"/>
		<constant name="SOUP_SESSION_MAX_CONNS_PER_HOST" type="char*" value="max-conns-per-host"/>
		<constant name="SOUP_SESSION_PROXY_URI" type="char*" value="proxy-uri"/>
		<constant name="SOUP_SESSION_REMOVE_FEATURE_BY_TYPE" type="char*" value="remove-feature-by-type"/>
		<constant name="SOUP_SESSION_SSL_CA_FILE" type="char*" value="ssl-ca-file"/>
		<constant name="SOUP_SESSION_SSL_STRICT" type="char*" value="ssl-strict"/>
		<constant name="SOUP_SESSION_SYNC_H" type="int" value="1"/>
		<constant name="SOUP_SESSION_TIMEOUT" type="char*" value="timeout"/>
		<constant name="SOUP_SESSION_USER_AGENT" type="char*" value="user-agent"/>
		<constant name="SOUP_SESSION_USE_NTLM" type="char*" value="use-ntlm"/>
		<constant name="SOUP_SOCKET_ASYNC_CONTEXT" type="char*" value="async-context"/>
		<constant name="SOUP_SOCKET_FLAG_NONBLOCKING" type="char*" value="non-blocking"/>
		<constant name="SOUP_SOCKET_H" type="int" value="1"/>
		<constant name="SOUP_SOCKET_IS_SERVER" type="char*" value="is-server"/>
		<constant name="SOUP_SOCKET_LOCAL_ADDRESS" type="char*" value="local-address"/>
		<constant name="SOUP_SOCKET_REMOTE_ADDRESS" type="char*" value="remote-address"/>
		<constant name="SOUP_SOCKET_SSL_CREDENTIALS" type="char*" value="ssl-creds"/>
		<constant name="SOUP_SOCKET_SSL_STRICT" type="char*" value="ssl-strict"/>
		<constant name="SOUP_SOCKET_TIMEOUT" type="char*" value="timeout"/>
		<constant name="SOUP_SOCKET_TRUSTED_CERTIFICATE" type="char*" value="trusted-certificate"/>
		<constant name="SOUP_STATUS_H" type="int" value="1"/>
		<constant name="SOUP_TYPES_H" type="int" value="1"/>
		<constant name="SOUP_URI_H" type="int" value="1"/>
		<constant name="SOUP_VALUE_UTILS_H" type="int" value="1"/>
		<constant name="SOUP_XMLRPC_H" type="int" value="1"/>
	</namespace>
</api>
