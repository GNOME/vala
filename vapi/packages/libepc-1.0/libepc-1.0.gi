<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Epc">
		<function name="address_family_get_class" symbol="epc_address_family_get_class">
			<return-type type="GEnumClass*"/>
		</function>
		<function name="address_family_to_string" symbol="epc_address_family_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="value" type="EpcAddressFamily"/>
			</parameters>
		</function>
		<function name="auth_flags_get_class" symbol="epc_auth_flags_get_class">
			<return-type type="GFlagsClass*"/>
		</function>
		<function name="auth_flags_to_string" symbol="epc_auth_flags_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="value" type="EpcAuthFlags"/>
			</parameters>
		</function>
		<function name="collision_handling_get_class" symbol="epc_collision_handling_get_class">
			<return-type type="GEnumClass*"/>
		</function>
		<function name="collision_handling_to_string" symbol="epc_collision_handling_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="value" type="EpcCollisionHandling"/>
			</parameters>
		</function>
		<function name="http_error_quark" symbol="epc_http_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="protocol_build_uri" symbol="epc_protocol_build_uri">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="protocol" type="EpcProtocol"/>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="port" type="guint16"/>
				<parameter name="path" type="gchar*"/>
			</parameters>
		</function>
		<function name="protocol_from_name" symbol="epc_protocol_from_name">
			<return-type type="EpcProtocol"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
				<parameter name="fallback" type="EpcProtocol"/>
			</parameters>
		</function>
		<function name="protocol_get_class" symbol="epc_protocol_get_class">
			<return-type type="GEnumClass*"/>
		</function>
		<function name="protocol_get_service_type" symbol="epc_protocol_get_service_type">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="protocol" type="EpcProtocol"/>
			</parameters>
		</function>
		<function name="protocol_get_uri_scheme" symbol="epc_protocol_get_uri_scheme">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="protocol" type="EpcProtocol"/>
			</parameters>
		</function>
		<function name="protocol_to_string" symbol="epc_protocol_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="value" type="EpcProtocol"/>
			</parameters>
		</function>
		<function name="service_type_get_base" symbol="epc_service_type_get_base">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="type" type="gchar*"/>
			</parameters>
		</function>
		<function name="service_type_get_protocol" symbol="epc_service_type_get_protocol">
			<return-type type="EpcProtocol"/>
			<parameters>
				<parameter name="service_type" type="gchar*"/>
			</parameters>
		</function>
		<function name="service_type_list_supported" symbol="epc_service_type_list_supported">
			<return-type type="gchar**"/>
			<parameters>
				<parameter name="application" type="gchar*"/>
			</parameters>
		</function>
		<function name="service_type_new" symbol="epc_service_type_new">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="protocol" type="EpcProtocol"/>
				<parameter name="application" type="gchar*"/>
			</parameters>
		</function>
		<callback name="EpcAuthHandler">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="context" type="EpcAuthContext*"/>
				<parameter name="username" type="gchar*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="EpcContentsHandler">
			<return-type type="EpcContents*"/>
			<parameters>
				<parameter name="publisher" type="EpcPublisher*"/>
				<parameter name="key" type="gchar*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="EpcContentsReadFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="contents" type="EpcContents*"/>
				<parameter name="buffer" type="gpointer"/>
				<parameter name="length" type="gsize*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="EpcAuthContext">
			<method name="check_password" symbol="epc_auth_context_check_password">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="context" type="EpcAuthContext*"/>
					<parameter name="password" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_key" symbol="epc_auth_context_get_key">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="context" type="EpcAuthContext*"/>
				</parameters>
			</method>
			<method name="get_password" symbol="epc_auth_context_get_password">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="context" type="EpcAuthContext*"/>
				</parameters>
			</method>
			<method name="get_publisher" symbol="epc_auth_context_get_publisher">
				<return-type type="EpcPublisher*"/>
				<parameters>
					<parameter name="context" type="EpcAuthContext*"/>
				</parameters>
			</method>
		</struct>
		<struct name="EpcContents">
			<method name="get_data" symbol="epc_contents_get_data">
				<return-type type="gconstpointer"/>
				<parameters>
					<parameter name="contents" type="EpcContents*"/>
					<parameter name="length" type="gsize*"/>
				</parameters>
			</method>
			<method name="get_mime_type" symbol="epc_contents_get_mime_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="contents" type="EpcContents*"/>
				</parameters>
			</method>
			<method name="is_stream" symbol="epc_contents_is_stream">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="contents" type="EpcContents*"/>
				</parameters>
			</method>
			<method name="new" symbol="epc_contents_new">
				<return-type type="EpcContents*"/>
				<parameters>
					<parameter name="type" type="gchar*"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="length" type="gssize"/>
					<parameter name="destroy_data" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="new_dup" symbol="epc_contents_new_dup">
				<return-type type="EpcContents*"/>
				<parameters>
					<parameter name="type" type="gchar*"/>
					<parameter name="data" type="gconstpointer"/>
					<parameter name="length" type="gssize"/>
				</parameters>
			</method>
			<method name="ref" symbol="epc_contents_ref">
				<return-type type="EpcContents*"/>
				<parameters>
					<parameter name="contents" type="EpcContents*"/>
				</parameters>
			</method>
			<method name="stream_new" symbol="epc_contents_stream_new">
				<return-type type="EpcContents*"/>
				<parameters>
					<parameter name="type" type="gchar*"/>
					<parameter name="callback" type="EpcContentsReadFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="destroy_data" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="stream_read" symbol="epc_contents_stream_read">
				<return-type type="gconstpointer"/>
				<parameters>
					<parameter name="contents" type="EpcContents*"/>
					<parameter name="length" type="gsize*"/>
				</parameters>
			</method>
			<method name="unref" symbol="epc_contents_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="contents" type="EpcContents*"/>
				</parameters>
			</method>
		</struct>
		<boxed name="EpcServiceInfo" type-name="EpcServiceInfo" get-type="epc_service_info_get_type">
			<method name="get_address" symbol="epc_service_info_get_address">
				<return-type type="AvahiAddress*"/>
				<parameters>
					<parameter name="info" type="EpcServiceInfo*"/>
				</parameters>
			</method>
			<method name="get_address_family" symbol="epc_service_info_get_address_family">
				<return-type type="EpcAddressFamily"/>
				<parameters>
					<parameter name="info" type="EpcServiceInfo*"/>
				</parameters>
			</method>
			<method name="get_detail" symbol="epc_service_info_get_detail">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="info" type="EpcServiceInfo*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_host" symbol="epc_service_info_get_host">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="info" type="EpcServiceInfo*"/>
				</parameters>
			</method>
			<method name="get_interface" symbol="epc_service_info_get_interface">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="info" type="EpcServiceInfo*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="epc_service_info_get_port">
				<return-type type="guint"/>
				<parameters>
					<parameter name="info" type="EpcServiceInfo*"/>
				</parameters>
			</method>
			<method name="get_service_type" symbol="epc_service_info_get_service_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="info" type="EpcServiceInfo*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="epc_service_info_new">
				<return-type type="EpcServiceInfo*"/>
				<parameters>
					<parameter name="type" type="gchar*"/>
					<parameter name="host" type="gchar*"/>
					<parameter name="port" type="guint"/>
					<parameter name="details" type="AvahiStringList*"/>
				</parameters>
			</constructor>
			<constructor name="new_full" symbol="epc_service_info_new_full">
				<return-type type="EpcServiceInfo*"/>
				<parameters>
					<parameter name="type" type="gchar*"/>
					<parameter name="host" type="gchar*"/>
					<parameter name="port" type="guint"/>
					<parameter name="details" type="AvahiStringList*"/>
					<parameter name="address" type="AvahiAddress*"/>
					<parameter name="ifname" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="ref" symbol="epc_service_info_ref">
				<return-type type="EpcServiceInfo*"/>
				<parameters>
					<parameter name="info" type="EpcServiceInfo*"/>
				</parameters>
			</method>
			<method name="unref" symbol="epc_service_info_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="EpcServiceInfo*"/>
				</parameters>
			</method>
		</boxed>
		<enum name="EpcAddressFamily" type-name="EpcAddressFamily" get-type="epc_address_family_get_type">
			<member name="EPC_ADDRESS_UNSPEC" value="0"/>
			<member name="EPC_ADDRESS_IPV4" value="2"/>
			<member name="EPC_ADDRESS_IPV6" value="10"/>
		</enum>
		<enum name="EpcCollisionHandling" type-name="EpcCollisionHandling" get-type="epc_collision_handling_get_type">
			<member name="EPC_COLLISIONS_IGNORE" value="0"/>
			<member name="EPC_COLLISIONS_CHANGE_NAME" value="1"/>
			<member name="EPC_COLLISIONS_UNIQUE_SERVICE" value="2"/>
		</enum>
		<enum name="EpcProtocol" type-name="EpcProtocol" get-type="epc_protocol_get_type">
			<member name="EPC_PROTOCOL_UNKNOWN" value="0"/>
			<member name="EPC_PROTOCOL_HTTP" value="1"/>
			<member name="EPC_PROTOCOL_HTTPS" value="2"/>
		</enum>
		<flags name="EpcAuthFlags" type-name="EpcAuthFlags" get-type="epc_auth_flags_get_type">
			<member name="EPC_AUTH_DEFAULT" value="0"/>
			<member name="EPC_AUTH_PASSWORD_TEXT_NEEDED" value="1"/>
		</flags>
		<object name="EpcConsumer" parent="GObject" type-name="EpcConsumer" get-type="epc_consumer_get_type">
			<method name="get_password" symbol="epc_consumer_get_password">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="consumer" type="EpcConsumer*"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="epc_consumer_get_protocol">
				<return-type type="EpcProtocol"/>
				<parameters>
					<parameter name="consumer" type="EpcConsumer*"/>
				</parameters>
			</method>
			<method name="get_username" symbol="epc_consumer_get_username">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="consumer" type="EpcConsumer*"/>
				</parameters>
			</method>
			<method name="is_publisher_resolved" symbol="epc_consumer_is_publisher_resolved">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="consumer" type="EpcConsumer*"/>
				</parameters>
			</method>
			<method name="list" symbol="epc_consumer_list">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="consumer" type="EpcConsumer*"/>
					<parameter name="pattern" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="lookup" symbol="epc_consumer_lookup">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="consumer" type="EpcConsumer*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="epc_consumer_new">
				<return-type type="EpcConsumer*"/>
				<parameters>
					<parameter name="service" type="EpcServiceInfo*"/>
				</parameters>
			</constructor>
			<constructor name="new_for_name" symbol="epc_consumer_new_for_name">
				<return-type type="EpcConsumer*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_for_name_full" symbol="epc_consumer_new_for_name_full">
				<return-type type="EpcConsumer*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="application" type="gchar*"/>
					<parameter name="domain" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="resolve_publisher" symbol="epc_consumer_resolve_publisher">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="consumer" type="EpcConsumer*"/>
					<parameter name="timeout" type="guint"/>
				</parameters>
			</method>
			<method name="set_password" symbol="epc_consumer_set_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="consumer" type="EpcConsumer*"/>
					<parameter name="password" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_protocol" symbol="epc_consumer_set_protocol">
				<return-type type="void"/>
				<parameters>
					<parameter name="consumer" type="EpcConsumer*"/>
					<parameter name="protocol" type="EpcProtocol"/>
				</parameters>
			</method>
			<method name="set_username" symbol="epc_consumer_set_username">
				<return-type type="void"/>
				<parameters>
					<parameter name="consumer" type="EpcConsumer*"/>
					<parameter name="username" type="gchar*"/>
				</parameters>
			</method>
			<property name="application" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="domain" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="hostname" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="password" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="path" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="port" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="protocol" type="EpcProtocol" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="username" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="authenticate" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="consumer" type="EpcConsumer*"/>
					<parameter name="realm" type="char*"/>
				</parameters>
			</signal>
			<signal name="publisher-resolved" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="consumer" type="EpcConsumer*"/>
					<parameter name="protocol" type="EpcProtocol"/>
					<parameter name="hostname" type="char*"/>
					<parameter name="port" type="guint"/>
				</parameters>
			</signal>
		</object>
		<object name="EpcDispatcher" parent="GObject" type-name="EpcDispatcher" get-type="epc_dispatcher_get_type">
			<method name="add_service" symbol="epc_dispatcher_add_service">
				<return-type type="void"/>
				<parameters>
					<parameter name="dispatcher" type="EpcDispatcher*"/>
					<parameter name="protocol" type="EpcAddressFamily"/>
					<parameter name="type" type="gchar*"/>
					<parameter name="domain" type="gchar*"/>
					<parameter name="host" type="gchar*"/>
					<parameter name="port" type="guint16"/>
				</parameters>
			</method>
			<method name="add_service_subtype" symbol="epc_dispatcher_add_service_subtype">
				<return-type type="void"/>
				<parameters>
					<parameter name="dispatcher" type="EpcDispatcher*"/>
					<parameter name="type" type="gchar*"/>
					<parameter name="subtype" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_collision_handling" symbol="epc_dispatcher_get_collision_handling">
				<return-type type="EpcCollisionHandling"/>
				<parameters>
					<parameter name="dispatcher" type="EpcDispatcher*"/>
				</parameters>
			</method>
			<method name="get_cookie" symbol="epc_dispatcher_get_cookie">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dispatcher" type="EpcDispatcher*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="epc_dispatcher_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dispatcher" type="EpcDispatcher*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="epc_dispatcher_new">
				<return-type type="EpcDispatcher*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="reset" symbol="epc_dispatcher_reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="dispatcher" type="EpcDispatcher*"/>
				</parameters>
			</method>
			<method name="run" symbol="epc_dispatcher_run">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dispatcher" type="EpcDispatcher*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_collision_handling" symbol="epc_dispatcher_set_collision_handling">
				<return-type type="void"/>
				<parameters>
					<parameter name="dispatcher" type="EpcDispatcher*"/>
					<parameter name="method" type="EpcCollisionHandling"/>
				</parameters>
			</method>
			<method name="set_cookie" symbol="epc_dispatcher_set_cookie">
				<return-type type="void"/>
				<parameters>
					<parameter name="dispatcher" type="EpcDispatcher*"/>
					<parameter name="cookie" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="epc_dispatcher_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="dispatcher" type="EpcDispatcher*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_service_details" symbol="epc_dispatcher_set_service_details">
				<return-type type="void"/>
				<parameters>
					<parameter name="dispatcher" type="EpcDispatcher*"/>
					<parameter name="type" type="gchar*"/>
				</parameters>
			</method>
			<property name="collision-handling" type="EpcCollisionHandling" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="cookie" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="EpcPublisher" parent="GObject" type-name="EpcPublisher" get-type="epc_publisher_get_type">
			<method name="add" symbol="epc_publisher_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="data" type="gconstpointer"/>
					<parameter name="length" type="gssize"/>
				</parameters>
			</method>
			<method name="add_bookmark" symbol="epc_publisher_add_bookmark">
				<return-type type="void"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_file" symbol="epc_publisher_add_file">
				<return-type type="void"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_handler" symbol="epc_publisher_add_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="handler" type="EpcContentsHandler"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="destroy_data" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="expand_name" symbol="epc_publisher_expand_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_auth_flags" symbol="epc_publisher_get_auth_flags">
				<return-type type="EpcAuthFlags"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
				</parameters>
			</method>
			<method name="get_certificate_file" symbol="epc_publisher_get_certificate_file">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
				</parameters>
			</method>
			<method name="get_collision_handling" symbol="epc_publisher_get_collision_handling">
				<return-type type="EpcCollisionHandling"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
				</parameters>
			</method>
			<method name="get_contents_path" symbol="epc_publisher_get_contents_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
				</parameters>
			</method>
			<method name="get_path" symbol="epc_publisher_get_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_private_key_file" symbol="epc_publisher_get_private_key_file">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="epc_publisher_get_protocol">
				<return-type type="EpcProtocol"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
				</parameters>
			</method>
			<method name="get_service_cookie" symbol="epc_publisher_get_service_cookie">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
				</parameters>
			</method>
			<method name="get_service_domain" symbol="epc_publisher_get_service_domain">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
				</parameters>
			</method>
			<method name="get_service_name" symbol="epc_publisher_get_service_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="epc_publisher_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="has_key" symbol="epc_publisher_has_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="list" symbol="epc_publisher_list">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="pattern" type="gchar*"/>
				</parameters>
			</method>
			<method name="lookup" symbol="epc_publisher_lookup">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="epc_publisher_new">
				<return-type type="EpcPublisher*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="application" type="gchar*"/>
					<parameter name="domain" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="quit" symbol="epc_publisher_quit">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
				</parameters>
			</method>
			<method name="remove" symbol="epc_publisher_remove">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="run" symbol="epc_publisher_run">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="run_async" symbol="epc_publisher_run_async">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_auth_flags" symbol="epc_publisher_set_auth_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="flags" type="EpcAuthFlags"/>
				</parameters>
			</method>
			<method name="set_auth_handler" symbol="epc_publisher_set_auth_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="handler" type="EpcAuthHandler"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="destroy_data" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_collision_handling" symbol="epc_publisher_set_collision_handling">
				<return-type type="void"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="method" type="EpcCollisionHandling"/>
				</parameters>
			</method>
			<method name="set_contents_path" symbol="epc_publisher_set_contents_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_credentials" symbol="epc_publisher_set_credentials">
				<return-type type="void"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="certfile" type="gchar*"/>
					<parameter name="keyfile" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_protocol" symbol="epc_publisher_set_protocol">
				<return-type type="void"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="protocol" type="EpcProtocol"/>
				</parameters>
			</method>
			<method name="set_service_cookie" symbol="epc_publisher_set_service_cookie">
				<return-type type="void"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="cookie" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_service_name" symbol="epc_publisher_set_service_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="publisher" type="EpcPublisher*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<property name="application" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="auth-flags" type="EpcAuthFlags" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="certificate-file" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="collision-handling" type="EpcCollisionHandling" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="contents-path" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="private-key-file" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="protocol" type="EpcProtocol" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="service-cookie" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="service-domain" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="service-name" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="EpcServiceMonitor" parent="GObject" type-name="EpcServiceMonitor" get-type="epc_service_monitor_get_type">
			<method name="get_skip_our_own" symbol="epc_service_monitor_get_skip_our_own">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="monitor" type="EpcServiceMonitor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="epc_service_monitor_new">
				<return-type type="EpcServiceMonitor*"/>
				<parameters>
					<parameter name="application" type="gchar*"/>
					<parameter name="domain" type="gchar*"/>
					<parameter name="first_protocol" type="EpcProtocol"/>
				</parameters>
			</constructor>
			<constructor name="new_for_types" symbol="epc_service_monitor_new_for_types">
				<return-type type="EpcServiceMonitor*"/>
				<parameters>
					<parameter name="domain" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_for_types_strv" symbol="epc_service_monitor_new_for_types_strv">
				<return-type type="EpcServiceMonitor*"/>
				<parameters>
					<parameter name="domain" type="gchar*"/>
					<parameter name="types" type="gchar**"/>
				</parameters>
			</constructor>
			<method name="set_skip_our_own" symbol="epc_service_monitor_set_skip_our_own">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="EpcServiceMonitor*"/>
					<parameter name="setting" type="gboolean"/>
				</parameters>
			</method>
			<property name="application" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="domain" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="service-types" type="GStrv*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="skip-our-own" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="scanning-done" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="EpcServiceMonitor*"/>
					<parameter name="type" type="char*"/>
				</parameters>
			</signal>
			<signal name="service-found" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="EpcServiceMonitor*"/>
					<parameter name="name" type="char*"/>
					<parameter name="info" type="EpcServiceInfo*"/>
				</parameters>
			</signal>
			<signal name="service-removed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="EpcServiceMonitor*"/>
					<parameter name="name" type="char*"/>
					<parameter name="type" type="char*"/>
				</parameters>
			</signal>
		</object>
		<constant name="EPC_SERVICE_TYPE_HTTP" type="char*" value="_easy-publish-http._tcp"/>
		<constant name="EPC_SERVICE_TYPE_HTTPS" type="char*" value="_easy-publish-https._tcp"/>
	</namespace>
</api>
