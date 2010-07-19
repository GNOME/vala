<?xml version="1.0"?>
<api version="1.0">
	<namespace name="GLib">
		<function name="g_bus_get" symbol="g_bus_get">
			<return-type type="void"/>
			<parameters>
				<parameter name="bus_type" type="GBusType"/>
				<parameter name="cancellable" type="GCancellable*"/>
				<parameter name="callback" type="GAsyncReadyCallback"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="g_bus_get_finish" symbol="g_bus_get_finish">
			<return-type type="GDBusConnection*"/>
			<parameters>
				<parameter name="res" type="GAsyncResult*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="g_bus_get_sync" symbol="g_bus_get_sync">
			<return-type type="GDBusConnection*"/>
			<parameters>
				<parameter name="bus_type" type="GBusType"/>
				<parameter name="cancellable" type="GCancellable*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="g_bus_own_name" symbol="g_bus_own_name">
			<return-type type="guint"/>
			<parameters>
				<parameter name="bus_type" type="GBusType"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="flags" type="GBusNameOwnerFlags"/>
				<parameter name="bus_acquired_handler" type="GBusAcquiredCallback"/>
				<parameter name="name_acquired_handler" type="GBusNameAcquiredCallback"/>
				<parameter name="name_lost_handler" type="GBusNameLostCallback"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="user_data_free_func" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="g_bus_own_name_on_connection" symbol="g_bus_own_name_on_connection">
			<return-type type="guint"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="flags" type="GBusNameOwnerFlags"/>
				<parameter name="name_acquired_handler" type="GBusNameAcquiredCallback"/>
				<parameter name="name_lost_handler" type="GBusNameLostCallback"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="user_data_free_func" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="g_bus_own_name_on_connection_with_closures" symbol="g_bus_own_name_on_connection_with_closures">
			<return-type type="guint"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="flags" type="GBusNameOwnerFlags"/>
				<parameter name="name_acquired_closure" type="GClosure*"/>
				<parameter name="name_lost_closure" type="GClosure*"/>
			</parameters>
		</function>
		<function name="g_bus_own_name_with_closures" symbol="g_bus_own_name_with_closures">
			<return-type type="guint"/>
			<parameters>
				<parameter name="bus_type" type="GBusType"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="flags" type="GBusNameOwnerFlags"/>
				<parameter name="bus_acquired_closure" type="GClosure*"/>
				<parameter name="name_acquired_closure" type="GClosure*"/>
				<parameter name="name_lost_closure" type="GClosure*"/>
			</parameters>
		</function>
		<function name="g_bus_unown_name" symbol="g_bus_unown_name">
			<return-type type="void"/>
			<parameters>
				<parameter name="owner_id" type="guint"/>
			</parameters>
		</function>
		<function name="g_bus_unwatch_name" symbol="g_bus_unwatch_name">
			<return-type type="void"/>
			<parameters>
				<parameter name="watcher_id" type="guint"/>
			</parameters>
		</function>
		<function name="g_bus_watch_name" symbol="g_bus_watch_name">
			<return-type type="guint"/>
			<parameters>
				<parameter name="bus_type" type="GBusType"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="flags" type="GBusNameWatcherFlags"/>
				<parameter name="name_appeared_handler" type="GBusNameAppearedCallback"/>
				<parameter name="name_vanished_handler" type="GBusNameVanishedCallback"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="user_data_free_func" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="g_bus_watch_name_on_connection" symbol="g_bus_watch_name_on_connection">
			<return-type type="guint"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="flags" type="GBusNameWatcherFlags"/>
				<parameter name="name_appeared_handler" type="GBusNameAppearedCallback"/>
				<parameter name="name_vanished_handler" type="GBusNameVanishedCallback"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="user_data_free_func" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="g_bus_watch_name_on_connection_with_closures" symbol="g_bus_watch_name_on_connection_with_closures">
			<return-type type="guint"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="flags" type="GBusNameWatcherFlags"/>
				<parameter name="name_appeared_closure" type="GClosure*"/>
				<parameter name="name_vanished_closure" type="GClosure*"/>
			</parameters>
		</function>
		<function name="g_bus_watch_name_with_closures" symbol="g_bus_watch_name_with_closures">
			<return-type type="guint"/>
			<parameters>
				<parameter name="bus_type" type="GBusType"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="flags" type="GBusNameWatcherFlags"/>
				<parameter name="name_appeared_closure" type="GClosure*"/>
				<parameter name="name_vanished_closure" type="GClosure*"/>
			</parameters>
		</function>
		<function name="g_content_type_can_be_executable" symbol="g_content_type_can_be_executable">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="type" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_content_type_equals" symbol="g_content_type_equals">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="type1" type="gchar*"/>
				<parameter name="type2" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_content_type_from_mime_type" symbol="g_content_type_from_mime_type">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="mime_type" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_content_type_get_description" symbol="g_content_type_get_description">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="type" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_content_type_get_icon" symbol="g_content_type_get_icon">
			<return-type type="GIcon*"/>
			<parameters>
				<parameter name="type" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_content_type_get_mime_type" symbol="g_content_type_get_mime_type">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="type" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_content_type_guess" symbol="g_content_type_guess">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="filename" type="gchar*"/>
				<parameter name="data" type="guchar*"/>
				<parameter name="data_size" type="gsize"/>
				<parameter name="result_uncertain" type="gboolean*"/>
			</parameters>
		</function>
		<function name="g_content_type_guess_for_tree" symbol="g_content_type_guess_for_tree">
			<return-type type="gchar**"/>
			<parameters>
				<parameter name="root" type="GFile*"/>
			</parameters>
		</function>
		<function name="g_content_type_is_a" symbol="g_content_type_is_a">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="type" type="gchar*"/>
				<parameter name="supertype" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_content_type_is_unknown" symbol="g_content_type_is_unknown">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="type" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_content_types_get_registered" symbol="g_content_types_get_registered">
			<return-type type="GList*"/>
		</function>
		<function name="g_dbus_address_get_for_bus_sync" symbol="g_dbus_address_get_for_bus_sync">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="bus_type" type="GBusType"/>
				<parameter name="cancellable" type="GCancellable*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="g_dbus_address_get_stream" symbol="g_dbus_address_get_stream">
			<return-type type="void"/>
			<parameters>
				<parameter name="address" type="gchar*"/>
				<parameter name="cancellable" type="GCancellable*"/>
				<parameter name="callback" type="GAsyncReadyCallback"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="g_dbus_address_get_stream_finish" symbol="g_dbus_address_get_stream_finish">
			<return-type type="GIOStream*"/>
			<parameters>
				<parameter name="res" type="GAsyncResult*"/>
				<parameter name="out_guid" type="gchar**"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="g_dbus_address_get_stream_sync" symbol="g_dbus_address_get_stream_sync">
			<return-type type="GIOStream*"/>
			<parameters>
				<parameter name="address" type="gchar*"/>
				<parameter name="out_guid" type="gchar**"/>
				<parameter name="cancellable" type="GCancellable*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="g_dbus_error_encode_gerror" symbol="g_dbus_error_encode_gerror">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="error" type="GError*"/>
			</parameters>
		</function>
		<function name="g_dbus_error_get_remote_error" symbol="g_dbus_error_get_remote_error">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="error" type="GError*"/>
			</parameters>
		</function>
		<function name="g_dbus_error_is_remote_error" symbol="g_dbus_error_is_remote_error">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="error" type="GError*"/>
			</parameters>
		</function>
		<function name="g_dbus_error_new_for_dbus_error" symbol="g_dbus_error_new_for_dbus_error">
			<return-type type="GError*"/>
			<parameters>
				<parameter name="dbus_error_name" type="gchar*"/>
				<parameter name="dbus_error_message" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_dbus_error_quark" symbol="g_dbus_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="g_dbus_error_register_error" symbol="g_dbus_error_register_error">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="error_domain" type="GQuark"/>
				<parameter name="error_code" type="gint"/>
				<parameter name="dbus_error_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_dbus_error_register_error_domain" symbol="g_dbus_error_register_error_domain">
			<return-type type="void"/>
			<parameters>
				<parameter name="error_domain_quark_name" type="gchar*"/>
				<parameter name="quark_volatile" type="gsize*"/>
				<parameter name="entries" type="GDBusErrorEntry*"/>
				<parameter name="num_entries" type="guint"/>
			</parameters>
		</function>
		<function name="g_dbus_error_set_dbus_error" symbol="g_dbus_error_set_dbus_error">
			<return-type type="void"/>
			<parameters>
				<parameter name="error" type="GError**"/>
				<parameter name="dbus_error_name" type="gchar*"/>
				<parameter name="dbus_error_message" type="gchar*"/>
				<parameter name="format" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_dbus_error_set_dbus_error_valist" symbol="g_dbus_error_set_dbus_error_valist">
			<return-type type="void"/>
			<parameters>
				<parameter name="error" type="GError**"/>
				<parameter name="dbus_error_name" type="gchar*"/>
				<parameter name="dbus_error_message" type="gchar*"/>
				<parameter name="format" type="gchar*"/>
				<parameter name="var_args" type="va_list"/>
			</parameters>
		</function>
		<function name="g_dbus_error_strip_remote_error" symbol="g_dbus_error_strip_remote_error">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="error" type="GError*"/>
			</parameters>
		</function>
		<function name="g_dbus_error_unregister_error" symbol="g_dbus_error_unregister_error">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="error_domain" type="GQuark"/>
				<parameter name="error_code" type="gint"/>
				<parameter name="dbus_error_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_dbus_generate_guid" symbol="g_dbus_generate_guid">
			<return-type type="gchar*"/>
		</function>
		<function name="g_dbus_is_address" symbol="g_dbus_is_address">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_dbus_is_guid" symbol="g_dbus_is_guid">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_dbus_is_interface_name" symbol="g_dbus_is_interface_name">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_dbus_is_member_name" symbol="g_dbus_is_member_name">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_dbus_is_name" symbol="g_dbus_is_name">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_dbus_is_supported_address" symbol="g_dbus_is_supported_address">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="g_dbus_is_unique_name" symbol="g_dbus_is_unique_name">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_io_error_from_errno" symbol="g_io_error_from_errno">
			<return-type type="GIOErrorEnum"/>
			<parameters>
				<parameter name="err_no" type="gint"/>
			</parameters>
		</function>
		<function name="g_io_error_quark" symbol="g_io_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="g_io_modules_load_all_in_directory" symbol="g_io_modules_load_all_in_directory">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="dirname" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_io_modules_scan_all_in_directory" symbol="g_io_modules_scan_all_in_directory">
			<return-type type="void"/>
			<parameters>
				<parameter name="dirname" type="char*"/>
			</parameters>
		</function>
		<function name="g_io_scheduler_cancel_all_jobs" symbol="g_io_scheduler_cancel_all_jobs">
			<return-type type="void"/>
		</function>
		<function name="g_io_scheduler_push_job" symbol="g_io_scheduler_push_job">
			<return-type type="void"/>
			<parameters>
				<parameter name="job_func" type="GIOSchedulerJobFunc"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
				<parameter name="io_priority" type="gint"/>
				<parameter name="cancellable" type="GCancellable*"/>
			</parameters>
		</function>
		<function name="g_simple_async_report_error_in_idle" symbol="g_simple_async_report_error_in_idle">
			<return-type type="void"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
				<parameter name="callback" type="GAsyncReadyCallback"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="domain" type="GQuark"/>
				<parameter name="code" type="gint"/>
				<parameter name="format" type="char*"/>
			</parameters>
		</function>
		<function name="g_simple_async_report_gerror_in_idle" symbol="g_simple_async_report_gerror_in_idle">
			<return-type type="void"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
				<parameter name="callback" type="GAsyncReadyCallback"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="error" type="GError*"/>
			</parameters>
		</function>
		<callback name="GAsyncReadyCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="source_object" type="GObject*"/>
				<parameter name="res" type="GAsyncResult*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GBusAcquiredCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GBusNameAcquiredCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GBusNameAppearedCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="name_owner" type="gchar*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GBusNameLostCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GBusNameVanishedCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GDBusInterfaceGetPropertyFunc">
			<return-type type="GVariant*"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="sender" type="gchar*"/>
				<parameter name="object_path" type="gchar*"/>
				<parameter name="interface_name" type="gchar*"/>
				<parameter name="property_name" type="gchar*"/>
				<parameter name="error" type="GError**"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GDBusInterfaceMethodCallFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="sender" type="gchar*"/>
				<parameter name="object_path" type="gchar*"/>
				<parameter name="interface_name" type="gchar*"/>
				<parameter name="method_name" type="gchar*"/>
				<parameter name="parameters" type="GVariant*"/>
				<parameter name="invocation" type="GDBusMethodInvocation*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GDBusInterfaceSetPropertyFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="sender" type="gchar*"/>
				<parameter name="object_path" type="gchar*"/>
				<parameter name="interface_name" type="gchar*"/>
				<parameter name="property_name" type="gchar*"/>
				<parameter name="value" type="GVariant*"/>
				<parameter name="error" type="GError**"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GDBusMessageFilterFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="message" type="GDBusMessage*"/>
				<parameter name="incoming" type="gboolean"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GDBusSignalCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="sender_name" type="gchar*"/>
				<parameter name="object_path" type="gchar*"/>
				<parameter name="interface_name" type="gchar*"/>
				<parameter name="signal_name" type="gchar*"/>
				<parameter name="parameters" type="GVariant*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GDBusSubtreeDispatchFunc">
			<return-type type="GDBusInterfaceVTable*"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="sender" type="gchar*"/>
				<parameter name="object_path" type="gchar*"/>
				<parameter name="interface_name" type="gchar*"/>
				<parameter name="node" type="gchar*"/>
				<parameter name="out_user_data" type="gpointer*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GDBusSubtreeEnumerateFunc">
			<return-type type="gchar**"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="sender" type="gchar*"/>
				<parameter name="object_path" type="gchar*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GDBusSubtreeIntrospectFunc">
			<return-type type="GPtrArray*"/>
			<parameters>
				<parameter name="connection" type="GDBusConnection*"/>
				<parameter name="sender" type="gchar*"/>
				<parameter name="object_path" type="gchar*"/>
				<parameter name="node" type="gchar*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GFileProgressCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="current_num_bytes" type="goffset"/>
				<parameter name="total_num_bytes" type="goffset"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GFileReadMoreCallback">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="file_contents" type="char*"/>
				<parameter name="file_size" type="goffset"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GIOSchedulerJobFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="job" type="GIOSchedulerJob*"/>
				<parameter name="cancellable" type="GCancellable*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GReallocFunc">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
				<parameter name="size" type="gsize"/>
			</parameters>
		</callback>
		<callback name="GSettingsBindGetMapping">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="variant" type="GVariant*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GSettingsBindSetMapping">
			<return-type type="GVariant*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="expected_type" type="GVariantType*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GSettingsGetMapping">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="value" type="GVariant*"/>
				<parameter name="result" type="gpointer*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GSimpleAsyncThreadFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="res" type="GSimpleAsyncResult*"/>
				<parameter name="object" type="GObject*"/>
				<parameter name="cancellable" type="GCancellable*"/>
			</parameters>
		</callback>
		<callback name="GSocketSourceFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="socket" type="GSocket*"/>
				<parameter name="condition" type="GIOCondition"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GDBusErrorEntry">
			<field name="error_code" type="gint"/>
			<field name="dbus_error_name" type="gchar*"/>
		</struct>
		<struct name="GDBusInterfaceVTable">
			<field name="method_call" type="GDBusInterfaceMethodCallFunc"/>
			<field name="get_property" type="GDBusInterfaceGetPropertyFunc"/>
			<field name="set_property" type="GDBusInterfaceSetPropertyFunc"/>
			<field name="padding" type="gpointer[]"/>
		</struct>
		<struct name="GDBusSubtreeVTable">
			<field name="enumerate" type="GDBusSubtreeEnumerateFunc"/>
			<field name="introspect" type="GDBusSubtreeIntrospectFunc"/>
			<field name="dispatch" type="GDBusSubtreeDispatchFunc"/>
			<field name="_g_reserved1" type="GCallback"/>
			<field name="_g_reserved2" type="GCallback"/>
			<field name="_g_reserved3" type="GCallback"/>
			<field name="_g_reserved4" type="GCallback"/>
			<field name="_g_reserved5" type="GCallback"/>
			<field name="_g_reserved6" type="GCallback"/>
			<field name="_g_reserved7" type="GCallback"/>
			<field name="_g_reserved8" type="GCallback"/>
		</struct>
		<struct name="GEmblemClass">
		</struct>
		<struct name="GEmblemedIconClass">
		</struct>
		<struct name="GFileAttributeInfo">
			<field name="name" type="char*"/>
			<field name="type" type="GFileAttributeType"/>
			<field name="flags" type="GFileAttributeInfoFlags"/>
		</struct>
		<struct name="GFileDescriptorBased">
		</struct>
		<struct name="GFileIconClass">
		</struct>
		<struct name="GFileInfoClass">
		</struct>
		<struct name="GIOExtension">
			<method name="get_name" symbol="g_io_extension_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="extension" type="GIOExtension*"/>
				</parameters>
			</method>
			<method name="get_priority" symbol="g_io_extension_get_priority">
				<return-type type="gint"/>
				<parameters>
					<parameter name="extension" type="GIOExtension*"/>
				</parameters>
			</method>
			<method name="ref_class" symbol="g_io_extension_ref_class">
				<return-type type="GTypeClass*"/>
				<parameters>
					<parameter name="extension" type="GIOExtension*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GIOExtensionPoint">
			<method name="get_extension_by_name" symbol="g_io_extension_point_get_extension_by_name">
				<return-type type="GIOExtension*"/>
				<parameters>
					<parameter name="extension_point" type="GIOExtensionPoint*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_extensions" symbol="g_io_extension_point_get_extensions">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="extension_point" type="GIOExtensionPoint*"/>
				</parameters>
			</method>
			<method name="get_required_type" symbol="g_io_extension_point_get_required_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="extension_point" type="GIOExtensionPoint*"/>
				</parameters>
			</method>
			<method name="implement" symbol="g_io_extension_point_implement">
				<return-type type="GIOExtension*"/>
				<parameters>
					<parameter name="extension_point_name" type="char*"/>
					<parameter name="type" type="GType"/>
					<parameter name="extension_name" type="char*"/>
					<parameter name="priority" type="gint"/>
				</parameters>
			</method>
			<method name="lookup" symbol="g_io_extension_point_lookup">
				<return-type type="GIOExtensionPoint*"/>
				<parameters>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="register" symbol="g_io_extension_point_register">
				<return-type type="GIOExtensionPoint*"/>
				<parameters>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_required_type" symbol="g_io_extension_point_set_required_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="extension_point" type="GIOExtensionPoint*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
		</struct>
		<struct name="GIOModuleClass">
		</struct>
		<struct name="GIOSchedulerJob">
			<method name="send_to_mainloop" symbol="g_io_scheduler_job_send_to_mainloop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="job" type="GIOSchedulerJob*"/>
					<parameter name="func" type="GSourceFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="send_to_mainloop_async" symbol="g_io_scheduler_job_send_to_mainloop_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="job" type="GIOSchedulerJob*"/>
					<parameter name="func" type="GSourceFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
		</struct>
		<struct name="GInputVector">
			<field name="buffer" type="gpointer"/>
			<field name="size" type="gsize"/>
		</struct>
		<struct name="GOutputVector">
			<field name="buffer" type="gconstpointer"/>
			<field name="size" type="gsize"/>
		</struct>
		<struct name="GSettingsBackend">
		</struct>
		<struct name="GSimpleAsyncResultClass">
		</struct>
		<struct name="GThemedIconClass">
		</struct>
		<struct name="GUnixCredentialsMessage">
		</struct>
		<struct name="GUnixFDList">
		</struct>
		<boxed name="GDBusAnnotationInfo" type-name="GDBusAnnotationInfo" get-type="g_dbus_annotation_info_get_type">
			<method name="lookup" symbol="g_dbus_annotation_info_lookup">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="annotations" type="GDBusAnnotationInfo**"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="ref" symbol="g_dbus_annotation_info_ref">
				<return-type type="GDBusAnnotationInfo*"/>
				<parameters>
					<parameter name="info" type="GDBusAnnotationInfo*"/>
				</parameters>
			</method>
			<method name="unref" symbol="g_dbus_annotation_info_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GDBusAnnotationInfo*"/>
				</parameters>
			</method>
			<field name="ref_count" type="gint"/>
			<field name="key" type="gchar*"/>
			<field name="value" type="gchar*"/>
			<field name="annotations" type="GDBusAnnotationInfo**"/>
		</boxed>
		<boxed name="GDBusArgInfo" type-name="GDBusArgInfo" get-type="g_dbus_arg_info_get_type">
			<method name="ref" symbol="g_dbus_arg_info_ref">
				<return-type type="GDBusArgInfo*"/>
				<parameters>
					<parameter name="info" type="GDBusArgInfo*"/>
				</parameters>
			</method>
			<method name="unref" symbol="g_dbus_arg_info_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GDBusArgInfo*"/>
				</parameters>
			</method>
			<field name="ref_count" type="gint"/>
			<field name="name" type="gchar*"/>
			<field name="signature" type="gchar*"/>
			<field name="annotations" type="GDBusAnnotationInfo**"/>
		</boxed>
		<boxed name="GDBusInterfaceInfo" type-name="GDBusInterfaceInfo" get-type="g_dbus_interface_info_get_type">
			<method name="generate_xml" symbol="g_dbus_interface_info_generate_xml">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GDBusInterfaceInfo*"/>
					<parameter name="indent" type="guint"/>
					<parameter name="string_builder" type="GString*"/>
				</parameters>
			</method>
			<method name="lookup_method" symbol="g_dbus_interface_info_lookup_method">
				<return-type type="GDBusMethodInfo*"/>
				<parameters>
					<parameter name="info" type="GDBusInterfaceInfo*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="lookup_property" symbol="g_dbus_interface_info_lookup_property">
				<return-type type="GDBusPropertyInfo*"/>
				<parameters>
					<parameter name="info" type="GDBusInterfaceInfo*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="lookup_signal" symbol="g_dbus_interface_info_lookup_signal">
				<return-type type="GDBusSignalInfo*"/>
				<parameters>
					<parameter name="info" type="GDBusInterfaceInfo*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="ref" symbol="g_dbus_interface_info_ref">
				<return-type type="GDBusInterfaceInfo*"/>
				<parameters>
					<parameter name="info" type="GDBusInterfaceInfo*"/>
				</parameters>
			</method>
			<method name="unref" symbol="g_dbus_interface_info_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GDBusInterfaceInfo*"/>
				</parameters>
			</method>
			<field name="ref_count" type="gint"/>
			<field name="name" type="gchar*"/>
			<field name="methods" type="GDBusMethodInfo**"/>
			<field name="signals" type="GDBusSignalInfo**"/>
			<field name="properties" type="GDBusPropertyInfo**"/>
			<field name="annotations" type="GDBusAnnotationInfo**"/>
		</boxed>
		<boxed name="GDBusMethodInfo" type-name="GDBusMethodInfo" get-type="g_dbus_method_info_get_type">
			<method name="ref" symbol="g_dbus_method_info_ref">
				<return-type type="GDBusMethodInfo*"/>
				<parameters>
					<parameter name="info" type="GDBusMethodInfo*"/>
				</parameters>
			</method>
			<method name="unref" symbol="g_dbus_method_info_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GDBusMethodInfo*"/>
				</parameters>
			</method>
			<field name="ref_count" type="gint"/>
			<field name="name" type="gchar*"/>
			<field name="in_args" type="GDBusArgInfo**"/>
			<field name="out_args" type="GDBusArgInfo**"/>
			<field name="annotations" type="GDBusAnnotationInfo**"/>
		</boxed>
		<boxed name="GDBusNodeInfo" type-name="GDBusNodeInfo" get-type="g_dbus_node_info_get_type">
			<method name="generate_xml" symbol="g_dbus_node_info_generate_xml">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GDBusNodeInfo*"/>
					<parameter name="indent" type="guint"/>
					<parameter name="string_builder" type="GString*"/>
				</parameters>
			</method>
			<method name="lookup_interface" symbol="g_dbus_node_info_lookup_interface">
				<return-type type="GDBusInterfaceInfo*"/>
				<parameters>
					<parameter name="info" type="GDBusNodeInfo*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new_for_xml" symbol="g_dbus_node_info_new_for_xml">
				<return-type type="GDBusNodeInfo*"/>
				<parameters>
					<parameter name="xml_data" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="ref" symbol="g_dbus_node_info_ref">
				<return-type type="GDBusNodeInfo*"/>
				<parameters>
					<parameter name="info" type="GDBusNodeInfo*"/>
				</parameters>
			</method>
			<method name="unref" symbol="g_dbus_node_info_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GDBusNodeInfo*"/>
				</parameters>
			</method>
			<field name="ref_count" type="gint"/>
			<field name="path" type="gchar*"/>
			<field name="interfaces" type="GDBusInterfaceInfo**"/>
			<field name="nodes" type="GDBusNodeInfo**"/>
			<field name="annotations" type="GDBusAnnotationInfo**"/>
		</boxed>
		<boxed name="GDBusPropertyInfo" type-name="GDBusPropertyInfo" get-type="g_dbus_property_info_get_type">
			<method name="ref" symbol="g_dbus_property_info_ref">
				<return-type type="GDBusPropertyInfo*"/>
				<parameters>
					<parameter name="info" type="GDBusPropertyInfo*"/>
				</parameters>
			</method>
			<method name="unref" symbol="g_dbus_property_info_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GDBusPropertyInfo*"/>
				</parameters>
			</method>
			<field name="ref_count" type="gint"/>
			<field name="name" type="gchar*"/>
			<field name="signature" type="gchar*"/>
			<field name="flags" type="GDBusPropertyInfoFlags"/>
			<field name="annotations" type="GDBusAnnotationInfo**"/>
		</boxed>
		<boxed name="GDBusSignalInfo" type-name="GDBusSignalInfo" get-type="g_dbus_signal_info_get_type">
			<method name="ref" symbol="g_dbus_signal_info_ref">
				<return-type type="GDBusSignalInfo*"/>
				<parameters>
					<parameter name="info" type="GDBusSignalInfo*"/>
				</parameters>
			</method>
			<method name="unref" symbol="g_dbus_signal_info_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GDBusSignalInfo*"/>
				</parameters>
			</method>
			<field name="ref_count" type="gint"/>
			<field name="name" type="gchar*"/>
			<field name="args" type="GDBusArgInfo**"/>
			<field name="annotations" type="GDBusAnnotationInfo**"/>
		</boxed>
		<boxed name="GFileAttributeInfoList" type-name="GFileAttributeInfoList" get-type="g_file_attribute_info_list_get_type">
			<method name="add" symbol="g_file_attribute_info_list_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GFileAttributeInfoList*"/>
					<parameter name="name" type="char*"/>
					<parameter name="type" type="GFileAttributeType"/>
					<parameter name="flags" type="GFileAttributeInfoFlags"/>
				</parameters>
			</method>
			<method name="dup" symbol="g_file_attribute_info_list_dup">
				<return-type type="GFileAttributeInfoList*"/>
				<parameters>
					<parameter name="list" type="GFileAttributeInfoList*"/>
				</parameters>
			</method>
			<method name="lookup" symbol="g_file_attribute_info_list_lookup">
				<return-type type="GFileAttributeInfo*"/>
				<parameters>
					<parameter name="list" type="GFileAttributeInfoList*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_file_attribute_info_list_new">
				<return-type type="GFileAttributeInfoList*"/>
			</constructor>
			<method name="ref" symbol="g_file_attribute_info_list_ref">
				<return-type type="GFileAttributeInfoList*"/>
				<parameters>
					<parameter name="list" type="GFileAttributeInfoList*"/>
				</parameters>
			</method>
			<method name="unref" symbol="g_file_attribute_info_list_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GFileAttributeInfoList*"/>
				</parameters>
			</method>
			<field name="infos" type="GFileAttributeInfo*"/>
			<field name="n_infos" type="int"/>
		</boxed>
		<boxed name="GFileAttributeMatcher" type-name="GFileAttributeMatcher" get-type="g_file_attribute_matcher_get_type">
			<method name="enumerate_namespace" symbol="g_file_attribute_matcher_enumerate_namespace">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="matcher" type="GFileAttributeMatcher*"/>
					<parameter name="ns" type="char*"/>
				</parameters>
			</method>
			<method name="enumerate_next" symbol="g_file_attribute_matcher_enumerate_next">
				<return-type type="char*"/>
				<parameters>
					<parameter name="matcher" type="GFileAttributeMatcher*"/>
				</parameters>
			</method>
			<method name="matches" symbol="g_file_attribute_matcher_matches">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="matcher" type="GFileAttributeMatcher*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="matches_only" symbol="g_file_attribute_matcher_matches_only">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="matcher" type="GFileAttributeMatcher*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_file_attribute_matcher_new">
				<return-type type="GFileAttributeMatcher*"/>
				<parameters>
					<parameter name="attributes" type="char*"/>
				</parameters>
			</constructor>
			<method name="ref" symbol="g_file_attribute_matcher_ref">
				<return-type type="GFileAttributeMatcher*"/>
				<parameters>
					<parameter name="matcher" type="GFileAttributeMatcher*"/>
				</parameters>
			</method>
			<method name="unref" symbol="g_file_attribute_matcher_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="matcher" type="GFileAttributeMatcher*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="GSrvTarget" type-name="GSrvTarget" get-type="g_srv_target_get_type">
			<method name="copy" symbol="g_srv_target_copy">
				<return-type type="GSrvTarget*"/>
				<parameters>
					<parameter name="target" type="GSrvTarget*"/>
				</parameters>
			</method>
			<method name="free" symbol="g_srv_target_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="target" type="GSrvTarget*"/>
				</parameters>
			</method>
			<method name="get_hostname" symbol="g_srv_target_get_hostname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="target" type="GSrvTarget*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="g_srv_target_get_port">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="target" type="GSrvTarget*"/>
				</parameters>
			</method>
			<method name="get_priority" symbol="g_srv_target_get_priority">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="target" type="GSrvTarget*"/>
				</parameters>
			</method>
			<method name="get_weight" symbol="g_srv_target_get_weight">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="target" type="GSrvTarget*"/>
				</parameters>
			</method>
			<method name="list_sort" symbol="g_srv_target_list_sort">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="targets" type="GList*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_srv_target_new">
				<return-type type="GSrvTarget*"/>
				<parameters>
					<parameter name="hostname" type="gchar*"/>
					<parameter name="port" type="guint16"/>
					<parameter name="priority" type="guint16"/>
					<parameter name="weight" type="guint16"/>
				</parameters>
			</constructor>
		</boxed>
		<enum name="GBusType" type-name="GBusType" get-type="g_bus_type_get_type">
			<member name="G_BUS_TYPE_STARTER" value="-1"/>
			<member name="G_BUS_TYPE_NONE" value="0"/>
			<member name="G_BUS_TYPE_SYSTEM" value="1"/>
			<member name="G_BUS_TYPE_SESSION" value="2"/>
		</enum>
		<enum name="GConverterResult" type-name="GConverterResult" get-type="g_converter_result_get_type">
			<member name="G_CONVERTER_ERROR" value="0"/>
			<member name="G_CONVERTER_CONVERTED" value="1"/>
			<member name="G_CONVERTER_FINISHED" value="2"/>
			<member name="G_CONVERTER_FLUSHED" value="3"/>
		</enum>
		<enum name="GDBusError" type-name="GDBusError" get-type="g_dbus_error_get_type">
			<member name="G_DBUS_ERROR_FAILED" value="0"/>
			<member name="G_DBUS_ERROR_NO_MEMORY" value="1"/>
			<member name="G_DBUS_ERROR_SERVICE_UNKNOWN" value="2"/>
			<member name="G_DBUS_ERROR_NAME_HAS_NO_OWNER" value="3"/>
			<member name="G_DBUS_ERROR_NO_REPLY" value="4"/>
			<member name="G_DBUS_ERROR_IO_ERROR" value="5"/>
			<member name="G_DBUS_ERROR_BAD_ADDRESS" value="6"/>
			<member name="G_DBUS_ERROR_NOT_SUPPORTED" value="7"/>
			<member name="G_DBUS_ERROR_LIMITS_EXCEEDED" value="8"/>
			<member name="G_DBUS_ERROR_ACCESS_DENIED" value="9"/>
			<member name="G_DBUS_ERROR_AUTH_FAILED" value="10"/>
			<member name="G_DBUS_ERROR_NO_SERVER" value="11"/>
			<member name="G_DBUS_ERROR_TIMEOUT" value="12"/>
			<member name="G_DBUS_ERROR_NO_NETWORK" value="13"/>
			<member name="G_DBUS_ERROR_ADDRESS_IN_USE" value="14"/>
			<member name="G_DBUS_ERROR_DISCONNECTED" value="15"/>
			<member name="G_DBUS_ERROR_INVALID_ARGS" value="16"/>
			<member name="G_DBUS_ERROR_FILE_NOT_FOUND" value="17"/>
			<member name="G_DBUS_ERROR_FILE_EXISTS" value="18"/>
			<member name="G_DBUS_ERROR_UNKNOWN_METHOD" value="19"/>
			<member name="G_DBUS_ERROR_TIMED_OUT" value="20"/>
			<member name="G_DBUS_ERROR_MATCH_RULE_NOT_FOUND" value="21"/>
			<member name="G_DBUS_ERROR_MATCH_RULE_INVALID" value="22"/>
			<member name="G_DBUS_ERROR_SPAWN_EXEC_FAILED" value="23"/>
			<member name="G_DBUS_ERROR_SPAWN_FORK_FAILED" value="24"/>
			<member name="G_DBUS_ERROR_SPAWN_CHILD_EXITED" value="25"/>
			<member name="G_DBUS_ERROR_SPAWN_CHILD_SIGNALED" value="26"/>
			<member name="G_DBUS_ERROR_SPAWN_FAILED" value="27"/>
			<member name="G_DBUS_ERROR_SPAWN_SETUP_FAILED" value="28"/>
			<member name="G_DBUS_ERROR_SPAWN_CONFIG_INVALID" value="29"/>
			<member name="G_DBUS_ERROR_SPAWN_SERVICE_INVALID" value="30"/>
			<member name="G_DBUS_ERROR_SPAWN_SERVICE_NOT_FOUND" value="31"/>
			<member name="G_DBUS_ERROR_SPAWN_PERMISSIONS_INVALID" value="32"/>
			<member name="G_DBUS_ERROR_SPAWN_FILE_INVALID" value="33"/>
			<member name="G_DBUS_ERROR_SPAWN_NO_MEMORY" value="34"/>
			<member name="G_DBUS_ERROR_UNIX_PROCESS_ID_UNKNOWN" value="35"/>
			<member name="G_DBUS_ERROR_INVALID_SIGNATURE" value="36"/>
			<member name="G_DBUS_ERROR_INVALID_FILE_CONTENT" value="37"/>
			<member name="G_DBUS_ERROR_SELINUX_SECURITY_CONTEXT_UNKNOWN" value="38"/>
			<member name="G_DBUS_ERROR_ADT_AUDIT_DATA_UNKNOWN" value="39"/>
			<member name="G_DBUS_ERROR_OBJECT_PATH_IN_USE" value="40"/>
		</enum>
		<enum name="GDBusMessageHeaderField" type-name="GDBusMessageHeaderField" get-type="g_dbus_message_header_field_get_type">
			<member name="G_DBUS_MESSAGE_HEADER_FIELD_INVALID" value="0"/>
			<member name="G_DBUS_MESSAGE_HEADER_FIELD_PATH" value="1"/>
			<member name="G_DBUS_MESSAGE_HEADER_FIELD_INTERFACE" value="2"/>
			<member name="G_DBUS_MESSAGE_HEADER_FIELD_MEMBER" value="3"/>
			<member name="G_DBUS_MESSAGE_HEADER_FIELD_ERROR_NAME" value="4"/>
			<member name="G_DBUS_MESSAGE_HEADER_FIELD_REPLY_SERIAL" value="5"/>
			<member name="G_DBUS_MESSAGE_HEADER_FIELD_DESTINATION" value="6"/>
			<member name="G_DBUS_MESSAGE_HEADER_FIELD_SENDER" value="7"/>
			<member name="G_DBUS_MESSAGE_HEADER_FIELD_SIGNATURE" value="8"/>
			<member name="G_DBUS_MESSAGE_HEADER_FIELD_NUM_UNIX_FDS" value="9"/>
		</enum>
		<enum name="GDBusMessageType" type-name="GDBusMessageType" get-type="g_dbus_message_type_get_type">
			<member name="G_DBUS_MESSAGE_TYPE_INVALID" value="0"/>
			<member name="G_DBUS_MESSAGE_TYPE_METHOD_CALL" value="1"/>
			<member name="G_DBUS_MESSAGE_TYPE_METHOD_RETURN" value="2"/>
			<member name="G_DBUS_MESSAGE_TYPE_ERROR" value="3"/>
			<member name="G_DBUS_MESSAGE_TYPE_SIGNAL" value="4"/>
		</enum>
		<enum name="GDataStreamByteOrder" type-name="GDataStreamByteOrder" get-type="g_data_stream_byte_order_get_type">
			<member name="G_DATA_STREAM_BYTE_ORDER_BIG_ENDIAN" value="0"/>
			<member name="G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN" value="1"/>
			<member name="G_DATA_STREAM_BYTE_ORDER_HOST_ENDIAN" value="2"/>
		</enum>
		<enum name="GDataStreamNewlineType" type-name="GDataStreamNewlineType" get-type="g_data_stream_newline_type_get_type">
			<member name="G_DATA_STREAM_NEWLINE_TYPE_LF" value="0"/>
			<member name="G_DATA_STREAM_NEWLINE_TYPE_CR" value="1"/>
			<member name="G_DATA_STREAM_NEWLINE_TYPE_CR_LF" value="2"/>
			<member name="G_DATA_STREAM_NEWLINE_TYPE_ANY" value="3"/>
		</enum>
		<enum name="GDriveStartFlags" type-name="GDriveStartFlags" get-type="g_drive_start_flags_get_type">
			<member name="G_DRIVE_START_NONE" value="0"/>
		</enum>
		<enum name="GDriveStartStopType" type-name="GDriveStartStopType" get-type="g_drive_start_stop_type_get_type">
			<member name="G_DRIVE_START_STOP_TYPE_UNKNOWN" value="0"/>
			<member name="G_DRIVE_START_STOP_TYPE_SHUTDOWN" value="1"/>
			<member name="G_DRIVE_START_STOP_TYPE_NETWORK" value="2"/>
			<member name="G_DRIVE_START_STOP_TYPE_MULTIDISK" value="3"/>
			<member name="G_DRIVE_START_STOP_TYPE_PASSWORD" value="4"/>
		</enum>
		<enum name="GEmblemOrigin" type-name="GEmblemOrigin" get-type="g_emblem_origin_get_type">
			<member name="G_EMBLEM_ORIGIN_UNKNOWN" value="0"/>
			<member name="G_EMBLEM_ORIGIN_DEVICE" value="1"/>
			<member name="G_EMBLEM_ORIGIN_LIVEMETADATA" value="2"/>
			<member name="G_EMBLEM_ORIGIN_TAG" value="3"/>
		</enum>
		<enum name="GFileAttributeStatus" type-name="GFileAttributeStatus" get-type="g_file_attribute_status_get_type">
			<member name="G_FILE_ATTRIBUTE_STATUS_UNSET" value="0"/>
			<member name="G_FILE_ATTRIBUTE_STATUS_SET" value="1"/>
			<member name="G_FILE_ATTRIBUTE_STATUS_ERROR_SETTING" value="2"/>
		</enum>
		<enum name="GFileAttributeType" type-name="GFileAttributeType" get-type="g_file_attribute_type_get_type">
			<member name="G_FILE_ATTRIBUTE_TYPE_INVALID" value="0"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_STRING" value="1"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_BYTE_STRING" value="2"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_BOOLEAN" value="3"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_UINT32" value="4"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_INT32" value="5"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_UINT64" value="6"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_INT64" value="7"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_OBJECT" value="8"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_STRINGV" value="9"/>
		</enum>
		<enum name="GFileMonitorEvent" type-name="GFileMonitorEvent" get-type="g_file_monitor_event_get_type">
			<member name="G_FILE_MONITOR_EVENT_CHANGED" value="0"/>
			<member name="G_FILE_MONITOR_EVENT_CHANGES_DONE_HINT" value="1"/>
			<member name="G_FILE_MONITOR_EVENT_DELETED" value="2"/>
			<member name="G_FILE_MONITOR_EVENT_CREATED" value="3"/>
			<member name="G_FILE_MONITOR_EVENT_ATTRIBUTE_CHANGED" value="4"/>
			<member name="G_FILE_MONITOR_EVENT_PRE_UNMOUNT" value="5"/>
			<member name="G_FILE_MONITOR_EVENT_UNMOUNTED" value="6"/>
			<member name="G_FILE_MONITOR_EVENT_MOVED" value="7"/>
		</enum>
		<enum name="GFileType" type-name="GFileType" get-type="g_file_type_get_type">
			<member name="G_FILE_TYPE_UNKNOWN" value="0"/>
			<member name="G_FILE_TYPE_REGULAR" value="1"/>
			<member name="G_FILE_TYPE_DIRECTORY" value="2"/>
			<member name="G_FILE_TYPE_SYMBOLIC_LINK" value="3"/>
			<member name="G_FILE_TYPE_SPECIAL" value="4"/>
			<member name="G_FILE_TYPE_SHORTCUT" value="5"/>
			<member name="G_FILE_TYPE_MOUNTABLE" value="6"/>
		</enum>
		<enum name="GFilesystemPreviewType" type-name="GFilesystemPreviewType" get-type="g_filesystem_preview_type_get_type">
			<member name="G_FILESYSTEM_PREVIEW_TYPE_IF_ALWAYS" value="0"/>
			<member name="G_FILESYSTEM_PREVIEW_TYPE_IF_LOCAL" value="1"/>
			<member name="G_FILESYSTEM_PREVIEW_TYPE_NEVER" value="2"/>
		</enum>
		<enum name="GIOErrorEnum" type-name="GIOErrorEnum" get-type="g_io_error_enum_get_type">
			<member name="G_IO_ERROR_FAILED" value="0"/>
			<member name="G_IO_ERROR_NOT_FOUND" value="1"/>
			<member name="G_IO_ERROR_EXISTS" value="2"/>
			<member name="G_IO_ERROR_IS_DIRECTORY" value="3"/>
			<member name="G_IO_ERROR_NOT_DIRECTORY" value="4"/>
			<member name="G_IO_ERROR_NOT_EMPTY" value="5"/>
			<member name="G_IO_ERROR_NOT_REGULAR_FILE" value="6"/>
			<member name="G_IO_ERROR_NOT_SYMBOLIC_LINK" value="7"/>
			<member name="G_IO_ERROR_NOT_MOUNTABLE_FILE" value="8"/>
			<member name="G_IO_ERROR_FILENAME_TOO_LONG" value="9"/>
			<member name="G_IO_ERROR_INVALID_FILENAME" value="10"/>
			<member name="G_IO_ERROR_TOO_MANY_LINKS" value="11"/>
			<member name="G_IO_ERROR_NO_SPACE" value="12"/>
			<member name="G_IO_ERROR_INVALID_ARGUMENT" value="13"/>
			<member name="G_IO_ERROR_PERMISSION_DENIED" value="14"/>
			<member name="G_IO_ERROR_NOT_SUPPORTED" value="15"/>
			<member name="G_IO_ERROR_NOT_MOUNTED" value="16"/>
			<member name="G_IO_ERROR_ALREADY_MOUNTED" value="17"/>
			<member name="G_IO_ERROR_CLOSED" value="18"/>
			<member name="G_IO_ERROR_CANCELLED" value="19"/>
			<member name="G_IO_ERROR_PENDING" value="20"/>
			<member name="G_IO_ERROR_READ_ONLY" value="21"/>
			<member name="G_IO_ERROR_CANT_CREATE_BACKUP" value="22"/>
			<member name="G_IO_ERROR_WRONG_ETAG" value="23"/>
			<member name="G_IO_ERROR_TIMED_OUT" value="24"/>
			<member name="G_IO_ERROR_WOULD_RECURSE" value="25"/>
			<member name="G_IO_ERROR_BUSY" value="26"/>
			<member name="G_IO_ERROR_WOULD_BLOCK" value="27"/>
			<member name="G_IO_ERROR_HOST_NOT_FOUND" value="28"/>
			<member name="G_IO_ERROR_WOULD_MERGE" value="29"/>
			<member name="G_IO_ERROR_FAILED_HANDLED" value="30"/>
			<member name="G_IO_ERROR_TOO_MANY_OPEN_FILES" value="31"/>
			<member name="G_IO_ERROR_NOT_INITIALIZED" value="32"/>
			<member name="G_IO_ERROR_ADDRESS_IN_USE" value="33"/>
			<member name="G_IO_ERROR_PARTIAL_INPUT" value="34"/>
			<member name="G_IO_ERROR_INVALID_DATA" value="35"/>
			<member name="G_IO_ERROR_DBUS_ERROR" value="36"/>
		</enum>
		<enum name="GMountMountFlags" type-name="GMountMountFlags" get-type="g_mount_mount_flags_get_type">
			<member name="G_MOUNT_MOUNT_NONE" value="0"/>
		</enum>
		<enum name="GMountOperationResult" type-name="GMountOperationResult" get-type="g_mount_operation_result_get_type">
			<member name="G_MOUNT_OPERATION_HANDLED" value="0"/>
			<member name="G_MOUNT_OPERATION_ABORTED" value="1"/>
			<member name="G_MOUNT_OPERATION_UNHANDLED" value="2"/>
		</enum>
		<enum name="GPasswordSave" type-name="GPasswordSave" get-type="g_password_save_get_type">
			<member name="G_PASSWORD_SAVE_NEVER" value="0"/>
			<member name="G_PASSWORD_SAVE_FOR_SESSION" value="1"/>
			<member name="G_PASSWORD_SAVE_PERMANENTLY" value="2"/>
		</enum>
		<enum name="GResolverError" type-name="GResolverError" get-type="g_resolver_error_get_type">
			<member name="G_RESOLVER_ERROR_NOT_FOUND" value="0"/>
			<member name="G_RESOLVER_ERROR_TEMPORARY_FAILURE" value="1"/>
			<member name="G_RESOLVER_ERROR_INTERNAL" value="2"/>
		</enum>
		<enum name="GSocketFamily" type-name="GSocketFamily" get-type="g_socket_family_get_type">
			<member name="G_SOCKET_FAMILY_INVALID" value="0"/>
			<member name="G_SOCKET_FAMILY_UNIX" value="1"/>
			<member name="G_SOCKET_FAMILY_IPV4" value="2"/>
			<member name="G_SOCKET_FAMILY_IPV6" value="10"/>
		</enum>
		<enum name="GSocketMsgFlags" type-name="GSocketMsgFlags" get-type="g_socket_msg_flags_get_type">
			<member name="G_SOCKET_MSG_NONE" value="0"/>
			<member name="G_SOCKET_MSG_OOB" value="1"/>
			<member name="G_SOCKET_MSG_PEEK" value="2"/>
			<member name="G_SOCKET_MSG_DONTROUTE" value="4"/>
		</enum>
		<enum name="GSocketProtocol" type-name="GSocketProtocol" get-type="g_socket_protocol_get_type">
			<member name="G_SOCKET_PROTOCOL_UNKNOWN" value="-1"/>
			<member name="G_SOCKET_PROTOCOL_DEFAULT" value="0"/>
			<member name="G_SOCKET_PROTOCOL_TCP" value="6"/>
			<member name="G_SOCKET_PROTOCOL_UDP" value="17"/>
			<member name="G_SOCKET_PROTOCOL_SCTP" value="132"/>
		</enum>
		<enum name="GSocketType" type-name="GSocketType" get-type="g_socket_type_get_type">
			<member name="G_SOCKET_TYPE_INVALID" value="0"/>
			<member name="G_SOCKET_TYPE_STREAM" value="1"/>
			<member name="G_SOCKET_TYPE_DATAGRAM" value="2"/>
			<member name="G_SOCKET_TYPE_SEQPACKET" value="3"/>
		</enum>
		<enum name="GUnixSocketAddressType" type-name="GUnixSocketAddressType" get-type="g_unix_socket_address_type_get_type">
			<member name="G_UNIX_SOCKET_ADDRESS_INVALID" value="0"/>
			<member name="G_UNIX_SOCKET_ADDRESS_ANONYMOUS" value="1"/>
			<member name="G_UNIX_SOCKET_ADDRESS_PATH" value="2"/>
			<member name="G_UNIX_SOCKET_ADDRESS_ABSTRACT" value="3"/>
			<member name="G_UNIX_SOCKET_ADDRESS_ABSTRACT_PADDED" value="4"/>
		</enum>
		<enum name="GZlibCompressorFormat" type-name="GZlibCompressorFormat" get-type="g_zlib_compressor_format_get_type">
			<member name="G_ZLIB_COMPRESSOR_FORMAT_ZLIB" value="0"/>
			<member name="G_ZLIB_COMPRESSOR_FORMAT_GZIP" value="1"/>
			<member name="G_ZLIB_COMPRESSOR_FORMAT_RAW" value="2"/>
		</enum>
		<flags name="GAppInfoCreateFlags" type-name="GAppInfoCreateFlags" get-type="g_app_info_create_flags_get_type">
			<member name="G_APP_INFO_CREATE_NONE" value="0"/>
			<member name="G_APP_INFO_CREATE_NEEDS_TERMINAL" value="1"/>
			<member name="G_APP_INFO_CREATE_SUPPORTS_URIS" value="2"/>
			<member name="G_APP_INFO_CREATE_SUPPORTS_STARTUP_NOTIFICATION" value="4"/>
		</flags>
		<flags name="GAskPasswordFlags" type-name="GAskPasswordFlags" get-type="g_ask_password_flags_get_type">
			<member name="G_ASK_PASSWORD_NEED_PASSWORD" value="1"/>
			<member name="G_ASK_PASSWORD_NEED_USERNAME" value="2"/>
			<member name="G_ASK_PASSWORD_NEED_DOMAIN" value="4"/>
			<member name="G_ASK_PASSWORD_SAVING_SUPPORTED" value="8"/>
			<member name="G_ASK_PASSWORD_ANONYMOUS_SUPPORTED" value="16"/>
		</flags>
		<flags name="GBusNameOwnerFlags" type-name="GBusNameOwnerFlags" get-type="g_bus_name_owner_flags_get_type">
			<member name="G_BUS_NAME_OWNER_FLAGS_NONE" value="0"/>
			<member name="G_BUS_NAME_OWNER_FLAGS_ALLOW_REPLACEMENT" value="1"/>
			<member name="G_BUS_NAME_OWNER_FLAGS_REPLACE" value="2"/>
		</flags>
		<flags name="GBusNameWatcherFlags" type-name="GBusNameWatcherFlags" get-type="g_bus_name_watcher_flags_get_type">
			<member name="G_BUS_NAME_WATCHER_FLAGS_NONE" value="0"/>
			<member name="G_BUS_NAME_WATCHER_FLAGS_AUTO_START" value="1"/>
		</flags>
		<flags name="GConverterFlags" type-name="GConverterFlags" get-type="g_converter_flags_get_type">
			<member name="G_CONVERTER_NO_FLAGS" value="0"/>
			<member name="G_CONVERTER_INPUT_AT_END" value="1"/>
			<member name="G_CONVERTER_FLUSH" value="2"/>
		</flags>
		<flags name="GDBusCallFlags" type-name="GDBusCallFlags" get-type="g_dbus_call_flags_get_type">
			<member name="G_DBUS_CALL_FLAGS_NONE" value="0"/>
			<member name="G_DBUS_CALL_FLAGS_NO_AUTO_START" value="1"/>
		</flags>
		<flags name="GDBusCapabilityFlags" type-name="GDBusCapabilityFlags" get-type="g_dbus_capability_flags_get_type">
			<member name="G_DBUS_CAPABILITY_FLAGS_NONE" value="0"/>
			<member name="G_DBUS_CAPABILITY_FLAGS_UNIX_FD_PASSING" value="1"/>
		</flags>
		<flags name="GDBusConnectionFlags" type-name="GDBusConnectionFlags" get-type="g_dbus_connection_flags_get_type">
			<member name="G_DBUS_CONNECTION_FLAGS_NONE" value="0"/>
			<member name="G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT" value="1"/>
			<member name="G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER" value="2"/>
			<member name="G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS" value="4"/>
			<member name="G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION" value="8"/>
			<member name="G_DBUS_CONNECTION_FLAGS_DELAY_MESSAGE_PROCESSING" value="16"/>
		</flags>
		<flags name="GDBusMessageFlags" type-name="GDBusMessageFlags" get-type="g_dbus_message_flags_get_type">
			<member name="G_DBUS_MESSAGE_FLAGS_NONE" value="0"/>
			<member name="G_DBUS_MESSAGE_FLAGS_NO_REPLY_EXPECTED" value="1"/>
			<member name="G_DBUS_MESSAGE_FLAGS_NO_AUTO_START" value="2"/>
		</flags>
		<flags name="GDBusPropertyInfoFlags" type-name="GDBusPropertyInfoFlags" get-type="g_dbus_property_info_flags_get_type">
			<member name="G_DBUS_PROPERTY_INFO_FLAGS_NONE" value="0"/>
			<member name="G_DBUS_PROPERTY_INFO_FLAGS_READABLE" value="1"/>
			<member name="G_DBUS_PROPERTY_INFO_FLAGS_WRITABLE" value="2"/>
		</flags>
		<flags name="GDBusProxyFlags" type-name="GDBusProxyFlags" get-type="g_dbus_proxy_flags_get_type">
			<member name="G_DBUS_PROXY_FLAGS_NONE" value="0"/>
			<member name="G_DBUS_PROXY_FLAGS_DO_NOT_LOAD_PROPERTIES" value="1"/>
			<member name="G_DBUS_PROXY_FLAGS_DO_NOT_CONNECT_SIGNALS" value="2"/>
			<member name="G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START" value="4"/>
		</flags>
		<flags name="GDBusServerFlags" type-name="GDBusServerFlags" get-type="g_dbus_server_flags_get_type">
			<member name="G_DBUS_SERVER_FLAGS_NONE" value="0"/>
			<member name="G_DBUS_SERVER_FLAGS_RUN_IN_THREAD" value="1"/>
			<member name="G_DBUS_SERVER_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS" value="2"/>
		</flags>
		<flags name="GDBusSubtreeFlags" type-name="GDBusSubtreeFlags" get-type="g_dbus_subtree_flags_get_type">
			<member name="G_DBUS_SUBTREE_FLAGS_NONE" value="0"/>
			<member name="G_DBUS_SUBTREE_FLAGS_DISPATCH_TO_UNENUMERATED_NODES" value="1"/>
		</flags>
		<flags name="GFileAttributeInfoFlags" type-name="GFileAttributeInfoFlags" get-type="g_file_attribute_info_flags_get_type">
			<member name="G_FILE_ATTRIBUTE_INFO_NONE" value="0"/>
			<member name="G_FILE_ATTRIBUTE_INFO_COPY_WITH_FILE" value="1"/>
			<member name="G_FILE_ATTRIBUTE_INFO_COPY_WHEN_MOVED" value="2"/>
		</flags>
		<flags name="GFileCopyFlags" type-name="GFileCopyFlags" get-type="g_file_copy_flags_get_type">
			<member name="G_FILE_COPY_NONE" value="0"/>
			<member name="G_FILE_COPY_OVERWRITE" value="1"/>
			<member name="G_FILE_COPY_BACKUP" value="2"/>
			<member name="G_FILE_COPY_NOFOLLOW_SYMLINKS" value="4"/>
			<member name="G_FILE_COPY_ALL_METADATA" value="8"/>
			<member name="G_FILE_COPY_NO_FALLBACK_FOR_MOVE" value="16"/>
			<member name="G_FILE_COPY_TARGET_DEFAULT_PERMS" value="32"/>
		</flags>
		<flags name="GFileCreateFlags" type-name="GFileCreateFlags" get-type="g_file_create_flags_get_type">
			<member name="G_FILE_CREATE_NONE" value="0"/>
			<member name="G_FILE_CREATE_PRIVATE" value="1"/>
			<member name="G_FILE_CREATE_REPLACE_DESTINATION" value="2"/>
		</flags>
		<flags name="GFileMonitorFlags" type-name="GFileMonitorFlags" get-type="g_file_monitor_flags_get_type">
			<member name="G_FILE_MONITOR_NONE" value="0"/>
			<member name="G_FILE_MONITOR_WATCH_MOUNTS" value="1"/>
			<member name="G_FILE_MONITOR_SEND_MOVED" value="2"/>
		</flags>
		<flags name="GFileQueryInfoFlags" type-name="GFileQueryInfoFlags" get-type="g_file_query_info_flags_get_type">
			<member name="G_FILE_QUERY_INFO_NONE" value="0"/>
			<member name="G_FILE_QUERY_INFO_NOFOLLOW_SYMLINKS" value="1"/>
		</flags>
		<flags name="GMountUnmountFlags" type-name="GMountUnmountFlags" get-type="g_mount_unmount_flags_get_type">
			<member name="G_MOUNT_UNMOUNT_NONE" value="0"/>
			<member name="G_MOUNT_UNMOUNT_FORCE" value="1"/>
		</flags>
		<flags name="GOutputStreamSpliceFlags" type-name="GOutputStreamSpliceFlags" get-type="g_output_stream_splice_flags_get_type">
			<member name="G_OUTPUT_STREAM_SPLICE_NONE" value="0"/>
			<member name="G_OUTPUT_STREAM_SPLICE_CLOSE_SOURCE" value="1"/>
			<member name="G_OUTPUT_STREAM_SPLICE_CLOSE_TARGET" value="2"/>
		</flags>
		<flags name="GSettingsBindFlags" type-name="GSettingsBindFlags" get-type="g_settings_bind_flags_get_type">
			<member name="G_SETTINGS_BIND_DEFAULT" value="0"/>
			<member name="G_SETTINGS_BIND_GET" value="1"/>
			<member name="G_SETTINGS_BIND_SET" value="2"/>
			<member name="G_SETTINGS_BIND_NO_SENSITIVITY" value="4"/>
			<member name="G_SETTINGS_BIND_GET_NO_CHANGES" value="8"/>
		</flags>
		<object name="GAppLaunchContext" parent="GObject" type-name="GAppLaunchContext" get-type="g_app_launch_context_get_type">
			<method name="get_display" symbol="g_app_launch_context_get_display">
				<return-type type="char*"/>
				<parameters>
					<parameter name="context" type="GAppLaunchContext*"/>
					<parameter name="info" type="GAppInfo*"/>
					<parameter name="files" type="GList*"/>
				</parameters>
			</method>
			<method name="get_startup_notify_id" symbol="g_app_launch_context_get_startup_notify_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="context" type="GAppLaunchContext*"/>
					<parameter name="info" type="GAppInfo*"/>
					<parameter name="files" type="GList*"/>
				</parameters>
			</method>
			<method name="launch_failed" symbol="g_app_launch_context_launch_failed">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GAppLaunchContext*"/>
					<parameter name="startup_notify_id" type="char*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_app_launch_context_new">
				<return-type type="GAppLaunchContext*"/>
			</constructor>
			<vfunc name="get_display">
				<return-type type="char*"/>
				<parameters>
					<parameter name="context" type="GAppLaunchContext*"/>
					<parameter name="info" type="GAppInfo*"/>
					<parameter name="files" type="GList*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_startup_notify_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="context" type="GAppLaunchContext*"/>
					<parameter name="info" type="GAppInfo*"/>
					<parameter name="files" type="GList*"/>
				</parameters>
			</vfunc>
			<vfunc name="launch_failed">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GAppLaunchContext*"/>
					<parameter name="startup_notify_id" type="char*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GApplication" parent="GObject" type-name="GApplication" get-type="g_application_get_type">
			<implements>
				<interface name="GInitable"/>
			</implements>
			<method name="add_action" symbol="g_application_add_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_action_description" symbol="g_application_get_action_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_action_enabled" symbol="g_application_get_action_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="g_application_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
				</parameters>
			</method>
			<method name="get_instance" symbol="g_application_get_instance">
				<return-type type="GApplication*"/>
			</method>
			<method name="invoke_action" symbol="g_application_invoke_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="platform_data" type="GVariant*"/>
				</parameters>
			</method>
			<method name="is_remote" symbol="g_application_is_remote">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
				</parameters>
			</method>
			<method name="list_actions" symbol="g_application_list_actions">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_application_new">
				<return-type type="GApplication*"/>
				<parameters>
					<parameter name="appid" type="gchar*"/>
					<parameter name="argc" type="int"/>
					<parameter name="argv" type="char**"/>
				</parameters>
			</constructor>
			<method name="quit_with_data" symbol="g_application_quit_with_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
					<parameter name="platform_data" type="GVariant*"/>
				</parameters>
			</method>
			<method name="register" symbol="g_application_register">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
				</parameters>
			</method>
			<method name="remove_action" symbol="g_application_remove_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="run" symbol="g_application_run">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
				</parameters>
			</method>
			<method name="set_action_enabled" symbol="g_application_set_action_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="enabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="try_new" symbol="g_application_try_new">
				<return-type type="GApplication*"/>
				<parameters>
					<parameter name="appid" type="gchar*"/>
					<parameter name="argc" type="int"/>
					<parameter name="argv" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="unregistered_try_new" symbol="g_application_unregistered_try_new">
				<return-type type="GApplication*"/>
				<parameters>
					<parameter name="appid" type="gchar*"/>
					<parameter name="argc" type="int"/>
					<parameter name="argv" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="application-id" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="argv" type="GVariant" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="default-quit" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="is-remote" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="platform-data" type="GVariant" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="register" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="action-with-data" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
					<parameter name="action_name" type="char*"/>
					<parameter name="platform_data" type="GVariant"/>
				</parameters>
			</signal>
			<signal name="prepare-activation" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
					<parameter name="arguments" type="GVariant"/>
					<parameter name="platform_data" type="GVariant"/>
				</parameters>
			</signal>
			<signal name="quit-with-data" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
					<parameter name="platform_data" type="GVariant"/>
				</parameters>
			</signal>
			<vfunc name="run">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="GApplication*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GBufferedInputStream" parent="GFilterInputStream" type-name="GBufferedInputStream" get-type="g_buffered_input_stream_get_type">
			<method name="fill" symbol="g_buffered_input_stream_fill">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="count" type="gssize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="fill_async" symbol="g_buffered_input_stream_fill_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="count" type="gssize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="fill_finish" symbol="g_buffered_input_stream_fill_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_available" symbol="g_buffered_input_stream_get_available">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
				</parameters>
			</method>
			<method name="get_buffer_size" symbol="g_buffered_input_stream_get_buffer_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_buffered_input_stream_new">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GInputStream*"/>
				</parameters>
			</constructor>
			<constructor name="new_sized" symbol="g_buffered_input_stream_new_sized">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GInputStream*"/>
					<parameter name="size" type="gsize"/>
				</parameters>
			</constructor>
			<method name="peek" symbol="g_buffered_input_stream_peek">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="offset" type="gsize"/>
					<parameter name="count" type="gsize"/>
				</parameters>
			</method>
			<method name="peek_buffer" symbol="g_buffered_input_stream_peek_buffer">
				<return-type type="void*"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="count" type="gsize*"/>
				</parameters>
			</method>
			<method name="read_byte" symbol="g_buffered_input_stream_read_byte">
				<return-type type="int"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_buffer_size" symbol="g_buffered_input_stream_set_buffer_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="size" type="gsize"/>
				</parameters>
			</method>
			<property name="buffer-size" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<vfunc name="fill">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="count" type="gssize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="fill_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="count" type="gssize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="fill_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GBufferedOutputStream" parent="GFilterOutputStream" type-name="GBufferedOutputStream" get-type="g_buffered_output_stream_get_type">
			<method name="get_auto_grow" symbol="g_buffered_output_stream_get_auto_grow">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GBufferedOutputStream*"/>
				</parameters>
			</method>
			<method name="get_buffer_size" symbol="g_buffered_output_stream_get_buffer_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="stream" type="GBufferedOutputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_buffered_output_stream_new">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GOutputStream*"/>
				</parameters>
			</constructor>
			<constructor name="new_sized" symbol="g_buffered_output_stream_new_sized">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GOutputStream*"/>
					<parameter name="size" type="gsize"/>
				</parameters>
			</constructor>
			<method name="set_auto_grow" symbol="g_buffered_output_stream_set_auto_grow">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GBufferedOutputStream*"/>
					<parameter name="auto_grow" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_buffer_size" symbol="g_buffered_output_stream_set_buffer_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GBufferedOutputStream*"/>
					<parameter name="size" type="gsize"/>
				</parameters>
			</method>
			<property name="auto-grow" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="buffer-size" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="GCancellable" parent="GObject" type-name="GCancellable" get-type="g_cancellable_get_type">
			<method name="cancel" symbol="g_cancellable_cancel">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="connect" symbol="g_cancellable_connect">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GCallback"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="data_destroy_func" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="disconnect" symbol="g_cancellable_disconnect">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="handler_id" type="gulong"/>
				</parameters>
			</method>
			<method name="get_current" symbol="g_cancellable_get_current">
				<return-type type="GCancellable*"/>
			</method>
			<method name="get_fd" symbol="g_cancellable_get_fd">
				<return-type type="int"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="is_cancelled" symbol="g_cancellable_is_cancelled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="make_pollfd" symbol="g_cancellable_make_pollfd">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="pollfd" type="GPollFD*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_cancellable_new">
				<return-type type="GCancellable*"/>
			</constructor>
			<method name="pop_current" symbol="g_cancellable_pop_current">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="push_current" symbol="g_cancellable_push_current">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="release_fd" symbol="g_cancellable_release_fd">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="reset" symbol="g_cancellable_reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="set_error_if_cancelled" symbol="g_cancellable_set_error_if_cancelled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<signal name="cancelled" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</signal>
		</object>
		<object name="GCharsetConverter" parent="GObject" type-name="GCharsetConverter" get-type="g_charset_converter_get_type">
			<implements>
				<interface name="GConverter"/>
				<interface name="GInitable"/>
			</implements>
			<method name="get_num_fallbacks" symbol="g_charset_converter_get_num_fallbacks">
				<return-type type="guint"/>
				<parameters>
					<parameter name="converter" type="GCharsetConverter*"/>
				</parameters>
			</method>
			<method name="get_use_fallback" symbol="g_charset_converter_get_use_fallback">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="converter" type="GCharsetConverter*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_charset_converter_new">
				<return-type type="GCharsetConverter*"/>
				<parameters>
					<parameter name="to_charset" type="gchar*"/>
					<parameter name="from_charset" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="set_use_fallback" symbol="g_charset_converter_set_use_fallback">
				<return-type type="void"/>
				<parameters>
					<parameter name="converter" type="GCharsetConverter*"/>
					<parameter name="use_fallback" type="gboolean"/>
				</parameters>
			</method>
			<property name="from-charset" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="to-charset" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="use-fallback" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="GConverterInputStream" parent="GFilterInputStream" type-name="GConverterInputStream" get-type="g_converter_input_stream_get_type">
			<method name="get_converter" symbol="g_converter_input_stream_get_converter">
				<return-type type="GConverter*"/>
				<parameters>
					<parameter name="converter_stream" type="GConverterInputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_converter_input_stream_new">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GInputStream*"/>
					<parameter name="converter" type="GConverter*"/>
				</parameters>
			</constructor>
			<property name="converter" type="GConverter*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GConverterOutputStream" parent="GFilterOutputStream" type-name="GConverterOutputStream" get-type="g_converter_output_stream_get_type">
			<method name="get_converter" symbol="g_converter_output_stream_get_converter">
				<return-type type="GConverter*"/>
				<parameters>
					<parameter name="converter_stream" type="GConverterOutputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_converter_output_stream_new">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GOutputStream*"/>
					<parameter name="converter" type="GConverter*"/>
				</parameters>
			</constructor>
			<property name="converter" type="GConverter*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GCredentials" parent="GObject" type-name="GCredentials" get-type="g_credentials_get_type">
			<method name="get_native" symbol="g_credentials_get_native">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="credentials" type="GCredentials*"/>
				</parameters>
			</method>
			<method name="get_unix_user" symbol="g_credentials_get_unix_user">
				<return-type type="uid_t"/>
				<parameters>
					<parameter name="credentials" type="GCredentials*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="is_same_user" symbol="g_credentials_is_same_user">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="credentials" type="GCredentials*"/>
					<parameter name="other_credentials" type="GCredentials*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_credentials_new">
				<return-type type="GCredentials*"/>
			</constructor>
			<method name="set_native" symbol="g_credentials_set_native">
				<return-type type="void"/>
				<parameters>
					<parameter name="credentials" type="GCredentials*"/>
					<parameter name="native" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_unix_user" symbol="g_credentials_set_unix_user">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="credentials" type="GCredentials*"/>
					<parameter name="uid" type="uid_t"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="to_string" symbol="g_credentials_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="credentials" type="GCredentials*"/>
				</parameters>
			</method>
		</object>
		<object name="GDBusAuthObserver" parent="GObject" type-name="GDBusAuthObserver" get-type="g_dbus_auth_observer_get_type">
			<method name="authorize_authenticated_peer" symbol="g_dbus_auth_observer_authorize_authenticated_peer">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="observer" type="GDBusAuthObserver*"/>
					<parameter name="stream" type="GIOStream*"/>
					<parameter name="credentials" type="GCredentials*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_dbus_auth_observer_new">
				<return-type type="GDBusAuthObserver*"/>
			</constructor>
			<signal name="authorize-authenticated-peer" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GDBusAuthObserver*"/>
					<parameter name="p0" type="GIOStream*"/>
					<parameter name="p1" type="GCredentials*"/>
				</parameters>
			</signal>
		</object>
		<object name="GDBusConnection" parent="GObject" type-name="GDBusConnection" get-type="g_dbus_connection_get_type">
			<implements>
				<interface name="GInitable"/>
				<interface name="GAsyncInitable"/>
			</implements>
			<method name="add_filter" symbol="g_dbus_connection_add_filter">
				<return-type type="guint"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="filter_function" type="GDBusMessageFilterFunction"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="user_data_free_func" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="call" symbol="g_dbus_connection_call">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="bus_name" type="gchar*"/>
					<parameter name="object_path" type="gchar*"/>
					<parameter name="interface_name" type="gchar*"/>
					<parameter name="method_name" type="gchar*"/>
					<parameter name="parameters" type="GVariant*"/>
					<parameter name="reply_type" type="GVariantType*"/>
					<parameter name="flags" type="GDBusCallFlags"/>
					<parameter name="timeout_msec" type="gint"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="call_finish" symbol="g_dbus_connection_call_finish">
				<return-type type="GVariant*"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="call_sync" symbol="g_dbus_connection_call_sync">
				<return-type type="GVariant*"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="bus_name" type="gchar*"/>
					<parameter name="object_path" type="gchar*"/>
					<parameter name="interface_name" type="gchar*"/>
					<parameter name="method_name" type="gchar*"/>
					<parameter name="parameters" type="GVariant*"/>
					<parameter name="reply_type" type="GVariantType*"/>
					<parameter name="flags" type="GDBusCallFlags"/>
					<parameter name="timeout_msec" type="gint"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="close" symbol="g_dbus_connection_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
				</parameters>
			</method>
			<method name="emit_signal" symbol="g_dbus_connection_emit_signal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="destination_bus_name" type="gchar*"/>
					<parameter name="object_path" type="gchar*"/>
					<parameter name="interface_name" type="gchar*"/>
					<parameter name="signal_name" type="gchar*"/>
					<parameter name="parameters" type="GVariant*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="flush" symbol="g_dbus_connection_flush">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="flush_finish" symbol="g_dbus_connection_flush_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="flush_sync" symbol="g_dbus_connection_flush_sync">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_capabilities" symbol="g_dbus_connection_get_capabilities">
				<return-type type="GDBusCapabilityFlags"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
				</parameters>
			</method>
			<method name="get_exit_on_close" symbol="g_dbus_connection_get_exit_on_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
				</parameters>
			</method>
			<method name="get_guid" symbol="g_dbus_connection_get_guid">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
				</parameters>
			</method>
			<method name="get_peer_credentials" symbol="g_dbus_connection_get_peer_credentials">
				<return-type type="GCredentials*"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
				</parameters>
			</method>
			<method name="get_stream" symbol="g_dbus_connection_get_stream">
				<return-type type="GIOStream*"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
				</parameters>
			</method>
			<method name="get_unique_name" symbol="g_dbus_connection_get_unique_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
				</parameters>
			</method>
			<method name="is_closed" symbol="g_dbus_connection_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_dbus_connection_new">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
					<parameter name="guid" type="gchar*"/>
					<parameter name="flags" type="GDBusConnectionFlags"/>
					<parameter name="observer" type="GDBusAuthObserver*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</constructor>
			<constructor name="new_finish" symbol="g_dbus_connection_new_finish">
				<return-type type="GDBusConnection*"/>
				<parameters>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_for_address" symbol="g_dbus_connection_new_for_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="address" type="gchar*"/>
					<parameter name="flags" type="GDBusConnectionFlags"/>
					<parameter name="observer" type="GDBusAuthObserver*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</constructor>
			<constructor name="new_for_address_finish" symbol="g_dbus_connection_new_for_address_finish">
				<return-type type="GDBusConnection*"/>
				<parameters>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_for_address_sync" symbol="g_dbus_connection_new_for_address_sync">
				<return-type type="GDBusConnection*"/>
				<parameters>
					<parameter name="address" type="gchar*"/>
					<parameter name="flags" type="GDBusConnectionFlags"/>
					<parameter name="observer" type="GDBusAuthObserver*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_sync" symbol="g_dbus_connection_new_sync">
				<return-type type="GDBusConnection*"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
					<parameter name="guid" type="gchar*"/>
					<parameter name="flags" type="GDBusConnectionFlags"/>
					<parameter name="observer" type="GDBusAuthObserver*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="register_object" symbol="g_dbus_connection_register_object">
				<return-type type="guint"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="object_path" type="gchar*"/>
					<parameter name="interface_info" type="GDBusInterfaceInfo*"/>
					<parameter name="vtable" type="GDBusInterfaceVTable*"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="user_data_free_func" type="GDestroyNotify"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="register_subtree" symbol="g_dbus_connection_register_subtree">
				<return-type type="guint"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="object_path" type="gchar*"/>
					<parameter name="vtable" type="GDBusSubtreeVTable*"/>
					<parameter name="flags" type="GDBusSubtreeFlags"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="user_data_free_func" type="GDestroyNotify"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="remove_filter" symbol="g_dbus_connection_remove_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="filter_id" type="guint"/>
				</parameters>
			</method>
			<method name="send_message" symbol="g_dbus_connection_send_message">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="out_serial" type="guint32*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="send_message_with_reply" symbol="g_dbus_connection_send_message_with_reply">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="timeout_msec" type="gint"/>
					<parameter name="out_serial" type="guint32*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="send_message_with_reply_finish" symbol="g_dbus_connection_send_message_with_reply_finish">
				<return-type type="GDBusMessage*"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="send_message_with_reply_sync" symbol="g_dbus_connection_send_message_with_reply_sync">
				<return-type type="GDBusMessage*"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="timeout_msec" type="gint"/>
					<parameter name="out_serial" type="guint32*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_exit_on_close" symbol="g_dbus_connection_set_exit_on_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="exit_on_close" type="gboolean"/>
				</parameters>
			</method>
			<method name="signal_subscribe" symbol="g_dbus_connection_signal_subscribe">
				<return-type type="guint"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="sender" type="gchar*"/>
					<parameter name="interface_name" type="gchar*"/>
					<parameter name="member" type="gchar*"/>
					<parameter name="object_path" type="gchar*"/>
					<parameter name="arg0" type="gchar*"/>
					<parameter name="callback" type="GDBusSignalCallback"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="user_data_free_func" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="signal_unsubscribe" symbol="g_dbus_connection_signal_unsubscribe">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="subscription_id" type="guint"/>
				</parameters>
			</method>
			<method name="start_message_processing" symbol="g_dbus_connection_start_message_processing">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
				</parameters>
			</method>
			<method name="unregister_object" symbol="g_dbus_connection_unregister_object">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="registration_id" type="guint"/>
				</parameters>
			</method>
			<method name="unregister_subtree" symbol="g_dbus_connection_unregister_subtree">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="registration_id" type="guint"/>
				</parameters>
			</method>
			<property name="address" type="char*" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="authentication-observer" type="GDBusAuthObserver*" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="capabilities" type="GDBusCapabilityFlags" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="closed" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="exit-on-close" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="flags" type="GDBusConnectionFlags" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="guid" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="stream" type="GIOStream*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="unique-name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="closed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GDBusConnection*"/>
					<parameter name="p0" type="gboolean"/>
					<parameter name="p1" type="GError*"/>
				</parameters>
			</signal>
		</object>
		<object name="GDBusMessage" parent="GObject" type-name="GDBusMessage" get-type="g_dbus_message_get_type">
			<method name="bytes_needed" symbol="g_dbus_message_bytes_needed">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="blob" type="guchar*"/>
					<parameter name="blob_len" type="gsize"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_arg0" symbol="g_dbus_message_get_arg0">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_body" symbol="g_dbus_message_get_body">
				<return-type type="GVariant*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_destination" symbol="g_dbus_message_get_destination">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_error_name" symbol="g_dbus_message_get_error_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="g_dbus_message_get_flags">
				<return-type type="GDBusMessageFlags"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_header" symbol="g_dbus_message_get_header">
				<return-type type="GVariant*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="header_field" type="GDBusMessageHeaderField"/>
				</parameters>
			</method>
			<method name="get_header_fields" symbol="g_dbus_message_get_header_fields">
				<return-type type="guchar*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_interface" symbol="g_dbus_message_get_interface">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_member" symbol="g_dbus_message_get_member">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_message_type" symbol="g_dbus_message_get_message_type">
				<return-type type="GDBusMessageType"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_num_unix_fds" symbol="g_dbus_message_get_num_unix_fds">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_path" symbol="g_dbus_message_get_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_reply_serial" symbol="g_dbus_message_get_reply_serial">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_sender" symbol="g_dbus_message_get_sender">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_serial" symbol="g_dbus_message_get_serial">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_signature" symbol="g_dbus_message_get_signature">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<method name="get_unix_fd_list" symbol="g_dbus_message_get_unix_fd_list">
				<return-type type="GUnixFDList*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_dbus_message_new">
				<return-type type="GDBusMessage*"/>
			</constructor>
			<constructor name="new_from_blob" symbol="g_dbus_message_new_from_blob">
				<return-type type="GDBusMessage*"/>
				<parameters>
					<parameter name="blob" type="guchar*"/>
					<parameter name="blob_len" type="gsize"/>
					<parameter name="capabilities" type="GDBusCapabilityFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_method_call" symbol="g_dbus_message_new_method_call">
				<return-type type="GDBusMessage*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="path" type="gchar*"/>
					<parameter name="interface_" type="gchar*"/>
					<parameter name="method" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_method_error" symbol="g_dbus_message_new_method_error">
				<return-type type="GDBusMessage*"/>
				<parameters>
					<parameter name="method_call_message" type="GDBusMessage*"/>
					<parameter name="error_name" type="gchar*"/>
					<parameter name="error_message_format" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_method_error_literal" symbol="g_dbus_message_new_method_error_literal">
				<return-type type="GDBusMessage*"/>
				<parameters>
					<parameter name="method_call_message" type="GDBusMessage*"/>
					<parameter name="error_name" type="gchar*"/>
					<parameter name="error_message" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_method_error_valist" symbol="g_dbus_message_new_method_error_valist">
				<return-type type="GDBusMessage*"/>
				<parameters>
					<parameter name="method_call_message" type="GDBusMessage*"/>
					<parameter name="error_name" type="gchar*"/>
					<parameter name="error_message_format" type="gchar*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</constructor>
			<constructor name="new_method_reply" symbol="g_dbus_message_new_method_reply">
				<return-type type="GDBusMessage*"/>
				<parameters>
					<parameter name="method_call_message" type="GDBusMessage*"/>
				</parameters>
			</constructor>
			<constructor name="new_signal" symbol="g_dbus_message_new_signal">
				<return-type type="GDBusMessage*"/>
				<parameters>
					<parameter name="path" type="gchar*"/>
					<parameter name="interface_" type="gchar*"/>
					<parameter name="signal" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="print" symbol="g_dbus_message_print">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="indent" type="guint"/>
				</parameters>
			</method>
			<method name="set_body" symbol="g_dbus_message_set_body">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="body" type="GVariant*"/>
				</parameters>
			</method>
			<method name="set_destination" symbol="g_dbus_message_set_destination">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_error_name" symbol="g_dbus_message_set_error_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_flags" symbol="g_dbus_message_set_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="flags" type="GDBusMessageFlags"/>
				</parameters>
			</method>
			<method name="set_header" symbol="g_dbus_message_set_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="header_field" type="GDBusMessageHeaderField"/>
					<parameter name="value" type="GVariant*"/>
				</parameters>
			</method>
			<method name="set_interface" symbol="g_dbus_message_set_interface">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_member" symbol="g_dbus_message_set_member">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_message_type" symbol="g_dbus_message_set_message_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="type" type="GDBusMessageType"/>
				</parameters>
			</method>
			<method name="set_num_unix_fds" symbol="g_dbus_message_set_num_unix_fds">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="value" type="guint32"/>
				</parameters>
			</method>
			<method name="set_path" symbol="g_dbus_message_set_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_reply_serial" symbol="g_dbus_message_set_reply_serial">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="value" type="guint32"/>
				</parameters>
			</method>
			<method name="set_sender" symbol="g_dbus_message_set_sender">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_serial" symbol="g_dbus_message_set_serial">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="serial" type="guint32"/>
				</parameters>
			</method>
			<method name="set_signature" symbol="g_dbus_message_set_signature">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_unix_fd_list" symbol="g_dbus_message_set_unix_fd_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="fd_list" type="GUnixFDList*"/>
				</parameters>
			</method>
			<method name="to_blob" symbol="g_dbus_message_to_blob">
				<return-type type="guchar*"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="out_size" type="gsize*"/>
					<parameter name="capabilities" type="GDBusCapabilityFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="to_gerror" symbol="g_dbus_message_to_gerror">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</object>
		<object name="GDBusMethodInvocation" parent="GObject" type-name="GDBusMethodInvocation" get-type="g_dbus_method_invocation_get_type">
			<method name="get_connection" symbol="g_dbus_method_invocation_get_connection">
				<return-type type="GDBusConnection*"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
				</parameters>
			</method>
			<method name="get_interface_name" symbol="g_dbus_method_invocation_get_interface_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
				</parameters>
			</method>
			<method name="get_message" symbol="g_dbus_method_invocation_get_message">
				<return-type type="GDBusMessage*"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
				</parameters>
			</method>
			<method name="get_method_info" symbol="g_dbus_method_invocation_get_method_info">
				<return-type type="GDBusMethodInfo*"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
				</parameters>
			</method>
			<method name="get_method_name" symbol="g_dbus_method_invocation_get_method_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
				</parameters>
			</method>
			<method name="get_object_path" symbol="g_dbus_method_invocation_get_object_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
				</parameters>
			</method>
			<method name="get_parameters" symbol="g_dbus_method_invocation_get_parameters">
				<return-type type="GVariant*"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
				</parameters>
			</method>
			<method name="get_sender" symbol="g_dbus_method_invocation_get_sender">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
				</parameters>
			</method>
			<method name="get_user_data" symbol="g_dbus_method_invocation_get_user_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_dbus_method_invocation_new">
				<return-type type="GDBusMethodInvocation*"/>
				<parameters>
					<parameter name="sender" type="gchar*"/>
					<parameter name="object_path" type="gchar*"/>
					<parameter name="interface_name" type="gchar*"/>
					<parameter name="method_name" type="gchar*"/>
					<parameter name="method_info" type="GDBusMethodInfo*"/>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="message" type="GDBusMessage*"/>
					<parameter name="parameters" type="GVariant*"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</constructor>
			<method name="return_dbus_error" symbol="g_dbus_method_invocation_return_dbus_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
					<parameter name="error_name" type="gchar*"/>
					<parameter name="error_message" type="gchar*"/>
				</parameters>
			</method>
			<method name="return_error" symbol="g_dbus_method_invocation_return_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
					<parameter name="domain" type="GQuark"/>
					<parameter name="code" type="gint"/>
					<parameter name="format" type="gchar*"/>
				</parameters>
			</method>
			<method name="return_error_literal" symbol="g_dbus_method_invocation_return_error_literal">
				<return-type type="void"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
					<parameter name="domain" type="GQuark"/>
					<parameter name="code" type="gint"/>
					<parameter name="message" type="gchar*"/>
				</parameters>
			</method>
			<method name="return_error_valist" symbol="g_dbus_method_invocation_return_error_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
					<parameter name="domain" type="GQuark"/>
					<parameter name="code" type="gint"/>
					<parameter name="format" type="gchar*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</method>
			<method name="return_gerror" symbol="g_dbus_method_invocation_return_gerror">
				<return-type type="void"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</method>
			<method name="return_value" symbol="g_dbus_method_invocation_return_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="invocation" type="GDBusMethodInvocation*"/>
					<parameter name="parameters" type="GVariant*"/>
				</parameters>
			</method>
		</object>
		<object name="GDBusProxy" parent="GObject" type-name="GDBusProxy" get-type="g_dbus_proxy_get_type">
			<implements>
				<interface name="GInitable"/>
				<interface name="GAsyncInitable"/>
			</implements>
			<method name="call" symbol="g_dbus_proxy_call">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
					<parameter name="method_name" type="gchar*"/>
					<parameter name="parameters" type="GVariant*"/>
					<parameter name="flags" type="GDBusCallFlags"/>
					<parameter name="timeout_msec" type="gint"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="call_finish" symbol="g_dbus_proxy_call_finish">
				<return-type type="GVariant*"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="call_sync" symbol="g_dbus_proxy_call_sync">
				<return-type type="GVariant*"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
					<parameter name="method_name" type="gchar*"/>
					<parameter name="parameters" type="GVariant*"/>
					<parameter name="flags" type="GDBusCallFlags"/>
					<parameter name="timeout_msec" type="gint"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_cached_property" symbol="g_dbus_proxy_get_cached_property">
				<return-type type="GVariant*"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_cached_property_names" symbol="g_dbus_proxy_get_cached_property_names">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
				</parameters>
			</method>
			<method name="get_connection" symbol="g_dbus_proxy_get_connection">
				<return-type type="GDBusConnection*"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
				</parameters>
			</method>
			<method name="get_default_timeout" symbol="g_dbus_proxy_get_default_timeout">
				<return-type type="gint"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="g_dbus_proxy_get_flags">
				<return-type type="GDBusProxyFlags"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
				</parameters>
			</method>
			<method name="get_interface_info" symbol="g_dbus_proxy_get_interface_info">
				<return-type type="GDBusInterfaceInfo*"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
				</parameters>
			</method>
			<method name="get_interface_name" symbol="g_dbus_proxy_get_interface_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="g_dbus_proxy_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
				</parameters>
			</method>
			<method name="get_name_owner" symbol="g_dbus_proxy_get_name_owner">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
				</parameters>
			</method>
			<method name="get_object_path" symbol="g_dbus_proxy_get_object_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_dbus_proxy_new">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="flags" type="GDBusProxyFlags"/>
					<parameter name="info" type="GDBusInterfaceInfo*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="object_path" type="gchar*"/>
					<parameter name="interface_name" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</constructor>
			<constructor name="new_finish" symbol="g_dbus_proxy_new_finish">
				<return-type type="GDBusProxy*"/>
				<parameters>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_for_bus" symbol="g_dbus_proxy_new_for_bus">
				<return-type type="void"/>
				<parameters>
					<parameter name="bus_type" type="GBusType"/>
					<parameter name="flags" type="GDBusProxyFlags"/>
					<parameter name="info" type="GDBusInterfaceInfo*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="object_path" type="gchar*"/>
					<parameter name="interface_name" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</constructor>
			<constructor name="new_for_bus_finish" symbol="g_dbus_proxy_new_for_bus_finish">
				<return-type type="GDBusProxy*"/>
				<parameters>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_for_bus_sync" symbol="g_dbus_proxy_new_for_bus_sync">
				<return-type type="GDBusProxy*"/>
				<parameters>
					<parameter name="bus_type" type="GBusType"/>
					<parameter name="flags" type="GDBusProxyFlags"/>
					<parameter name="info" type="GDBusInterfaceInfo*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="object_path" type="gchar*"/>
					<parameter name="interface_name" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_sync" symbol="g_dbus_proxy_new_sync">
				<return-type type="GDBusProxy*"/>
				<parameters>
					<parameter name="connection" type="GDBusConnection*"/>
					<parameter name="flags" type="GDBusProxyFlags"/>
					<parameter name="info" type="GDBusInterfaceInfo*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="object_path" type="gchar*"/>
					<parameter name="interface_name" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="set_cached_property" symbol="g_dbus_proxy_set_cached_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value" type="GVariant*"/>
				</parameters>
			</method>
			<method name="set_default_timeout" symbol="g_dbus_proxy_set_default_timeout">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
					<parameter name="timeout_msec" type="gint"/>
				</parameters>
			</method>
			<method name="set_interface_info" symbol="g_dbus_proxy_set_interface_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
					<parameter name="info" type="GDBusInterfaceInfo*"/>
				</parameters>
			</method>
			<property name="g-bus-type" type="GBusType" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="g-connection" type="GDBusConnection*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="g-default-timeout" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="g-flags" type="GDBusProxyFlags" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="g-interface-info" type="GDBusInterfaceInfo*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="g-interface-name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="g-name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="g-name-owner" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="g-object-path" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="g-properties-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
					<parameter name="changed_properties" type="GVariant"/>
					<parameter name="invalidated_properties" type="GStrv*"/>
				</parameters>
			</signal>
			<signal name="g-signal" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GDBusProxy*"/>
					<parameter name="sender_name" type="char*"/>
					<parameter name="signal_name" type="char*"/>
					<parameter name="parameters" type="GVariant"/>
				</parameters>
			</signal>
		</object>
		<object name="GDBusServer" parent="GObject" type-name="GDBusServer" get-type="g_dbus_server_get_type">
			<implements>
				<interface name="GInitable"/>
			</implements>
			<method name="get_client_address" symbol="g_dbus_server_get_client_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="server" type="GDBusServer*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="g_dbus_server_get_flags">
				<return-type type="GDBusServerFlags"/>
				<parameters>
					<parameter name="server" type="GDBusServer*"/>
				</parameters>
			</method>
			<method name="get_guid" symbol="g_dbus_server_get_guid">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="server" type="GDBusServer*"/>
				</parameters>
			</method>
			<method name="is_active" symbol="g_dbus_server_is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="server" type="GDBusServer*"/>
				</parameters>
			</method>
			<constructor name="new_sync" symbol="g_dbus_server_new_sync">
				<return-type type="GDBusServer*"/>
				<parameters>
					<parameter name="address" type="gchar*"/>
					<parameter name="flags" type="GDBusServerFlags"/>
					<parameter name="guid" type="gchar*"/>
					<parameter name="observer" type="GDBusAuthObserver*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="start" symbol="g_dbus_server_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="GDBusServer*"/>
				</parameters>
			</method>
			<method name="stop" symbol="g_dbus_server_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="server" type="GDBusServer*"/>
				</parameters>
			</method>
			<property name="active" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="address" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="authentication-observer" type="GDBusAuthObserver*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="client-address" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="flags" type="GDBusServerFlags" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="guid" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="new-connection" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GDBusServer*"/>
					<parameter name="p0" type="GDBusConnection*"/>
				</parameters>
			</signal>
		</object>
		<object name="GDataInputStream" parent="GBufferedInputStream" type-name="GDataInputStream" get-type="g_data_input_stream_get_type">
			<method name="get_byte_order" symbol="g_data_input_stream_get_byte_order">
				<return-type type="GDataStreamByteOrder"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
				</parameters>
			</method>
			<method name="get_newline_type" symbol="g_data_input_stream_get_newline_type">
				<return-type type="GDataStreamNewlineType"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_data_input_stream_new">
				<return-type type="GDataInputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GInputStream*"/>
				</parameters>
			</constructor>
			<method name="read_byte" symbol="g_data_input_stream_read_byte">
				<return-type type="guchar"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_int16" symbol="g_data_input_stream_read_int16">
				<return-type type="gint16"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_int32" symbol="g_data_input_stream_read_int32">
				<return-type type="gint32"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_int64" symbol="g_data_input_stream_read_int64">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_line" symbol="g_data_input_stream_read_line">
				<return-type type="char*"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_line_async" symbol="g_data_input_stream_read_line_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="io_priority" type="gint"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="read_line_finish" symbol="g_data_input_stream_read_line_finish">
				<return-type type="char*"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_uint16" symbol="g_data_input_stream_read_uint16">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_uint32" symbol="g_data_input_stream_read_uint32">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_uint64" symbol="g_data_input_stream_read_uint64">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_until" symbol="g_data_input_stream_read_until">
				<return-type type="char*"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="stop_chars" type="gchar*"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_until_async" symbol="g_data_input_stream_read_until_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="stop_chars" type="gchar*"/>
					<parameter name="io_priority" type="gint"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="read_until_finish" symbol="g_data_input_stream_read_until_finish">
				<return-type type="char*"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_byte_order" symbol="g_data_input_stream_set_byte_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="order" type="GDataStreamByteOrder"/>
				</parameters>
			</method>
			<method name="set_newline_type" symbol="g_data_input_stream_set_newline_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GDataInputStream*"/>
					<parameter name="type" type="GDataStreamNewlineType"/>
				</parameters>
			</method>
			<property name="byte-order" type="GDataStreamByteOrder" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="newline-type" type="GDataStreamNewlineType" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataOutputStream" parent="GFilterOutputStream" type-name="GDataOutputStream" get-type="g_data_output_stream_get_type">
			<method name="get_byte_order" symbol="g_data_output_stream_get_byte_order">
				<return-type type="GDataStreamByteOrder"/>
				<parameters>
					<parameter name="stream" type="GDataOutputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_data_output_stream_new">
				<return-type type="GDataOutputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GOutputStream*"/>
				</parameters>
			</constructor>
			<method name="put_byte" symbol="g_data_output_stream_put_byte">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GDataOutputStream*"/>
					<parameter name="data" type="guchar"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_int16" symbol="g_data_output_stream_put_int16">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GDataOutputStream*"/>
					<parameter name="data" type="gint16"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_int32" symbol="g_data_output_stream_put_int32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GDataOutputStream*"/>
					<parameter name="data" type="gint32"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_int64" symbol="g_data_output_stream_put_int64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GDataOutputStream*"/>
					<parameter name="data" type="gint64"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_string" symbol="g_data_output_stream_put_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GDataOutputStream*"/>
					<parameter name="str" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_uint16" symbol="g_data_output_stream_put_uint16">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GDataOutputStream*"/>
					<parameter name="data" type="guint16"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_uint32" symbol="g_data_output_stream_put_uint32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GDataOutputStream*"/>
					<parameter name="data" type="guint32"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_uint64" symbol="g_data_output_stream_put_uint64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GDataOutputStream*"/>
					<parameter name="data" type="guint64"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_byte_order" symbol="g_data_output_stream_set_byte_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GDataOutputStream*"/>
					<parameter name="order" type="GDataStreamByteOrder"/>
				</parameters>
			</method>
			<property name="byte-order" type="GDataStreamByteOrder" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GEmblem" parent="GObject" type-name="GEmblem" get-type="g_emblem_get_type">
			<implements>
				<interface name="GIcon"/>
			</implements>
			<method name="get_icon" symbol="g_emblem_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="emblem" type="GEmblem*"/>
				</parameters>
			</method>
			<method name="get_origin" symbol="g_emblem_get_origin">
				<return-type type="GEmblemOrigin"/>
				<parameters>
					<parameter name="emblem" type="GEmblem*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_emblem_new">
				<return-type type="GEmblem*"/>
				<parameters>
					<parameter name="icon" type="GIcon*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_origin" symbol="g_emblem_new_with_origin">
				<return-type type="GEmblem*"/>
				<parameters>
					<parameter name="icon" type="GIcon*"/>
					<parameter name="origin" type="GEmblemOrigin"/>
				</parameters>
			</constructor>
			<property name="icon" type="GObject*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="origin" type="GEmblemOrigin" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GEmblemedIcon" parent="GObject" type-name="GEmblemedIcon" get-type="g_emblemed_icon_get_type">
			<implements>
				<interface name="GIcon"/>
			</implements>
			<method name="add_emblem" symbol="g_emblemed_icon_add_emblem">
				<return-type type="void"/>
				<parameters>
					<parameter name="emblemed" type="GEmblemedIcon*"/>
					<parameter name="emblem" type="GEmblem*"/>
				</parameters>
			</method>
			<method name="get_emblems" symbol="g_emblemed_icon_get_emblems">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="emblemed" type="GEmblemedIcon*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="g_emblemed_icon_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="emblemed" type="GEmblemedIcon*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_emblemed_icon_new">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="icon" type="GIcon*"/>
					<parameter name="emblem" type="GEmblem*"/>
				</parameters>
			</constructor>
		</object>
		<object name="GFileEnumerator" parent="GObject" type-name="GFileEnumerator" get-type="g_file_enumerator_get_type">
			<method name="close" symbol="g_file_enumerator_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="close_async" symbol="g_file_enumerator_close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="close_finish" symbol="g_file_enumerator_close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_container" symbol="g_file_enumerator_get_container">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
				</parameters>
			</method>
			<method name="has_pending" symbol="g_file_enumerator_has_pending">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
				</parameters>
			</method>
			<method name="is_closed" symbol="g_file_enumerator_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
				</parameters>
			</method>
			<method name="next_file" symbol="g_file_enumerator_next_file">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="next_files_async" symbol="g_file_enumerator_next_files_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="num_files" type="int"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="next_files_finish" symbol="g_file_enumerator_next_files_finish">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_pending" symbol="g_file_enumerator_set_pending">
				<return-type type="void"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="pending" type="gboolean"/>
				</parameters>
			</method>
			<property name="container" type="GFile*" readable="0" writable="1" construct="0" construct-only="1"/>
			<vfunc name="close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="close_fn">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="next_file">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="next_files_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="num_files" type="int"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="next_files_finish">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GFileIOStream" parent="GIOStream" type-name="GFileIOStream" get-type="g_file_io_stream_get_type">
			<implements>
				<interface name="GSeekable"/>
			</implements>
			<method name="get_etag" symbol="g_file_io_stream_get_etag">
				<return-type type="char*"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
				</parameters>
			</method>
			<method name="query_info" symbol="g_file_io_stream_query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_info_async" symbol="g_file_io_stream_query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_info_finish" symbol="g_file_io_stream_query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="can_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_etag">
				<return-type type="char*"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="type" type="GSeekType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="tell">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="truncate_fn">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileIOStream*"/>
					<parameter name="size" type="goffset"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GFileIcon" parent="GObject" type-name="GFileIcon" get-type="g_file_icon_get_type">
			<implements>
				<interface name="GIcon"/>
				<interface name="GLoadableIcon"/>
			</implements>
			<method name="get_file" symbol="g_file_icon_get_file">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="icon" type="GFileIcon*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_file_icon_new">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</constructor>
			<property name="file" type="GFile*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GFileInfo" parent="GObject" type-name="GFileInfo" get-type="g_file_info_get_type">
			<method name="clear_status" symbol="g_file_info_clear_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="copy_into" symbol="g_file_info_copy_into">
				<return-type type="void"/>
				<parameters>
					<parameter name="src_info" type="GFileInfo*"/>
					<parameter name="dest_info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="dup" symbol="g_file_info_dup">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="other" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_attribute_as_string" symbol="g_file_info_get_attribute_as_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_boolean" symbol="g_file_info_get_attribute_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_byte_string" symbol="g_file_info_get_attribute_byte_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_data" symbol="g_file_info_get_attribute_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="type" type="GFileAttributeType*"/>
					<parameter name="value_pp" type="gpointer*"/>
					<parameter name="status" type="GFileAttributeStatus*"/>
				</parameters>
			</method>
			<method name="get_attribute_int32" symbol="g_file_info_get_attribute_int32">
				<return-type type="gint32"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_int64" symbol="g_file_info_get_attribute_int64">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_object" symbol="g_file_info_get_attribute_object">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_status" symbol="g_file_info_get_attribute_status">
				<return-type type="GFileAttributeStatus"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_string" symbol="g_file_info_get_attribute_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_stringv" symbol="g_file_info_get_attribute_stringv">
				<return-type type="char**"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_type" symbol="g_file_info_get_attribute_type">
				<return-type type="GFileAttributeType"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_uint32" symbol="g_file_info_get_attribute_uint32">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_uint64" symbol="g_file_info_get_attribute_uint64">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_content_type" symbol="g_file_info_get_content_type">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_display_name" symbol="g_file_info_get_display_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_edit_name" symbol="g_file_info_get_edit_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_etag" symbol="g_file_info_get_etag">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_file_type" symbol="g_file_info_get_file_type">
				<return-type type="GFileType"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="g_file_info_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_is_backup" symbol="g_file_info_get_is_backup">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_is_hidden" symbol="g_file_info_get_is_hidden">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_is_symlink" symbol="g_file_info_get_is_symlink">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_modification_time" symbol="g_file_info_get_modification_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="result" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="g_file_info_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="g_file_info_get_size">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_sort_order" symbol="g_file_info_get_sort_order">
				<return-type type="gint32"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_symlink_target" symbol="g_file_info_get_symlink_target">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="has_attribute" symbol="g_file_info_has_attribute">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="has_namespace" symbol="g_file_info_has_namespace">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="name_space" type="char*"/>
				</parameters>
			</method>
			<method name="list_attributes" symbol="g_file_info_list_attributes">
				<return-type type="char**"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="name_space" type="char*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_file_info_new">
				<return-type type="GFileInfo*"/>
			</constructor>
			<method name="remove_attribute" symbol="g_file_info_remove_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="set_attribute" symbol="g_file_info_set_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="type" type="GFileAttributeType"/>
					<parameter name="value_p" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_attribute_boolean" symbol="g_file_info_set_attribute_boolean">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="attr_value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_attribute_byte_string" symbol="g_file_info_set_attribute_byte_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="attr_value" type="char*"/>
				</parameters>
			</method>
			<method name="set_attribute_int32" symbol="g_file_info_set_attribute_int32">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="attr_value" type="gint32"/>
				</parameters>
			</method>
			<method name="set_attribute_int64" symbol="g_file_info_set_attribute_int64">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="attr_value" type="gint64"/>
				</parameters>
			</method>
			<method name="set_attribute_mask" symbol="g_file_info_set_attribute_mask">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="mask" type="GFileAttributeMatcher*"/>
				</parameters>
			</method>
			<method name="set_attribute_object" symbol="g_file_info_set_attribute_object">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="attr_value" type="GObject*"/>
				</parameters>
			</method>
			<method name="set_attribute_status" symbol="g_file_info_set_attribute_status">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="status" type="GFileAttributeStatus"/>
				</parameters>
			</method>
			<method name="set_attribute_string" symbol="g_file_info_set_attribute_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="attr_value" type="char*"/>
				</parameters>
			</method>
			<method name="set_attribute_stringv" symbol="g_file_info_set_attribute_stringv">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="attr_value" type="char**"/>
				</parameters>
			</method>
			<method name="set_attribute_uint32" symbol="g_file_info_set_attribute_uint32">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="attr_value" type="guint32"/>
				</parameters>
			</method>
			<method name="set_attribute_uint64" symbol="g_file_info_set_attribute_uint64">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="attr_value" type="guint64"/>
				</parameters>
			</method>
			<method name="set_content_type" symbol="g_file_info_set_content_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="content_type" type="char*"/>
				</parameters>
			</method>
			<method name="set_display_name" symbol="g_file_info_set_display_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="display_name" type="char*"/>
				</parameters>
			</method>
			<method name="set_edit_name" symbol="g_file_info_set_edit_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="edit_name" type="char*"/>
				</parameters>
			</method>
			<method name="set_file_type" symbol="g_file_info_set_file_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="type" type="GFileType"/>
				</parameters>
			</method>
			<method name="set_icon" symbol="g_file_info_set_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="icon" type="GIcon*"/>
				</parameters>
			</method>
			<method name="set_is_hidden" symbol="g_file_info_set_is_hidden">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="is_hidden" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_is_symlink" symbol="g_file_info_set_is_symlink">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="is_symlink" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_modification_time" symbol="g_file_info_set_modification_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="mtime" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="g_file_info_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_size" symbol="g_file_info_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="size" type="goffset"/>
				</parameters>
			</method>
			<method name="set_sort_order" symbol="g_file_info_set_sort_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="sort_order" type="gint32"/>
				</parameters>
			</method>
			<method name="set_symlink_target" symbol="g_file_info_set_symlink_target">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="symlink_target" type="char*"/>
				</parameters>
			</method>
			<method name="unset_attribute_mask" symbol="g_file_info_unset_attribute_mask">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
		</object>
		<object name="GFileInputStream" parent="GInputStream" type-name="GFileInputStream" get-type="g_file_input_stream_get_type">
			<implements>
				<interface name="GSeekable"/>
			</implements>
			<method name="query_info" symbol="g_file_input_stream_query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_info_async" symbol="g_file_input_stream_query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_info_finish" symbol="g_file_input_stream_query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="can_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="type" type="GSeekType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="tell">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GFileMonitor" parent="GObject" type-name="GFileMonitor" get-type="g_file_monitor_get_type">
			<method name="cancel" symbol="g_file_monitor_cancel">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="monitor" type="GFileMonitor*"/>
				</parameters>
			</method>
			<method name="directory" symbol="g_file_monitor_directory">
				<return-type type="GFileMonitor*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileMonitorFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="emit_event" symbol="g_file_monitor_emit_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="GFileMonitor*"/>
					<parameter name="child" type="GFile*"/>
					<parameter name="other_file" type="GFile*"/>
					<parameter name="event_type" type="GFileMonitorEvent"/>
				</parameters>
			</method>
			<method name="file" symbol="g_file_monitor_file">
				<return-type type="GFileMonitor*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileMonitorFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="is_cancelled" symbol="g_file_monitor_is_cancelled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="monitor" type="GFileMonitor*"/>
				</parameters>
			</method>
			<method name="set_rate_limit" symbol="g_file_monitor_set_rate_limit">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="GFileMonitor*"/>
					<parameter name="limit_msecs" type="int"/>
				</parameters>
			</method>
			<property name="cancelled" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="rate-limit" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="GFileMonitor*"/>
					<parameter name="file" type="GFile*"/>
					<parameter name="other_file" type="GFile*"/>
					<parameter name="event_type" type="GFileMonitorEvent"/>
				</parameters>
			</signal>
			<vfunc name="cancel">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="monitor" type="GFileMonitor*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GFileOutputStream" parent="GOutputStream" type-name="GFileOutputStream" get-type="g_file_output_stream_get_type">
			<implements>
				<interface name="GSeekable"/>
			</implements>
			<method name="get_etag" symbol="g_file_output_stream_get_etag">
				<return-type type="char*"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</method>
			<method name="query_info" symbol="g_file_output_stream_query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_info_async" symbol="g_file_output_stream_query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_info_finish" symbol="g_file_output_stream_query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="can_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_etag">
				<return-type type="char*"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="type" type="GSeekType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="tell">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="truncate_fn">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="size" type="goffset"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GFilenameCompleter" parent="GObject" type-name="GFilenameCompleter" get-type="g_filename_completer_get_type">
			<method name="get_completion_suffix" symbol="g_filename_completer_get_completion_suffix">
				<return-type type="char*"/>
				<parameters>
					<parameter name="completer" type="GFilenameCompleter*"/>
					<parameter name="initial_text" type="char*"/>
				</parameters>
			</method>
			<method name="get_completions" symbol="g_filename_completer_get_completions">
				<return-type type="char**"/>
				<parameters>
					<parameter name="completer" type="GFilenameCompleter*"/>
					<parameter name="initial_text" type="char*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_filename_completer_new">
				<return-type type="GFilenameCompleter*"/>
			</constructor>
			<method name="set_dirs_only" symbol="g_filename_completer_set_dirs_only">
				<return-type type="void"/>
				<parameters>
					<parameter name="completer" type="GFilenameCompleter*"/>
					<parameter name="dirs_only" type="gboolean"/>
				</parameters>
			</method>
			<signal name="got-completion-data" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="filename_completer" type="GFilenameCompleter*"/>
				</parameters>
			</signal>
		</object>
		<object name="GFilterInputStream" parent="GInputStream" type-name="GFilterInputStream" get-type="g_filter_input_stream_get_type">
			<method name="get_base_stream" symbol="g_filter_input_stream_get_base_stream">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="stream" type="GFilterInputStream*"/>
				</parameters>
			</method>
			<method name="get_close_base_stream" symbol="g_filter_input_stream_get_close_base_stream">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFilterInputStream*"/>
				</parameters>
			</method>
			<method name="set_close_base_stream" symbol="g_filter_input_stream_set_close_base_stream">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GFilterInputStream*"/>
					<parameter name="close_base" type="gboolean"/>
				</parameters>
			</method>
			<property name="base-stream" type="GInputStream*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="close-base-stream" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<field name="base_stream" type="GInputStream*"/>
		</object>
		<object name="GFilterOutputStream" parent="GOutputStream" type-name="GFilterOutputStream" get-type="g_filter_output_stream_get_type">
			<method name="get_base_stream" symbol="g_filter_output_stream_get_base_stream">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="stream" type="GFilterOutputStream*"/>
				</parameters>
			</method>
			<method name="get_close_base_stream" symbol="g_filter_output_stream_get_close_base_stream">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFilterOutputStream*"/>
				</parameters>
			</method>
			<method name="set_close_base_stream" symbol="g_filter_output_stream_set_close_base_stream">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GFilterOutputStream*"/>
					<parameter name="close_base" type="gboolean"/>
				</parameters>
			</method>
			<property name="base-stream" type="GOutputStream*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="close-base-stream" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<field name="base_stream" type="GOutputStream*"/>
		</object>
		<object name="GIOModule" parent="GTypeModule" type-name="GIOModule" get-type="g_io_module_get_type">
			<implements>
				<interface name="GTypePlugin"/>
			</implements>
			<method name="load" symbol="g_io_module_load">
				<return-type type="void"/>
				<parameters>
					<parameter name="module" type="GIOModule*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_io_module_new">
				<return-type type="GIOModule*"/>
				<parameters>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="query" symbol="g_io_module_query">
				<return-type type="char**"/>
			</method>
			<method name="unload" symbol="g_io_module_unload">
				<return-type type="void"/>
				<parameters>
					<parameter name="module" type="GIOModule*"/>
				</parameters>
			</method>
		</object>
		<object name="GIOStream" parent="GObject" type-name="GIOStream" get-type="g_io_stream_get_type">
			<method name="clear_pending" symbol="g_io_stream_clear_pending">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
				</parameters>
			</method>
			<method name="close" symbol="g_io_stream_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="close_async" symbol="g_io_stream_close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="close_finish" symbol="g_io_stream_close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_input_stream" symbol="g_io_stream_get_input_stream">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
				</parameters>
			</method>
			<method name="get_output_stream" symbol="g_io_stream_get_output_stream">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
				</parameters>
			</method>
			<method name="has_pending" symbol="g_io_stream_has_pending">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
				</parameters>
			</method>
			<method name="is_closed" symbol="g_io_stream_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
				</parameters>
			</method>
			<method name="set_pending" symbol="g_io_stream_set_pending">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="closed" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="input-stream" type="GInputStream*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="output-stream" type="GOutputStream*" readable="1" writable="0" construct="0" construct-only="0"/>
			<vfunc name="close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="close_fn">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="get_input_stream">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_output_stream">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="stream" type="GIOStream*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GInetAddress" parent="GObject" type-name="GInetAddress" get-type="g_inet_address_get_type">
			<method name="get_family" symbol="g_inet_address_get_family">
				<return-type type="GSocketFamily"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<method name="get_is_any" symbol="g_inet_address_get_is_any">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<method name="get_is_link_local" symbol="g_inet_address_get_is_link_local">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<method name="get_is_loopback" symbol="g_inet_address_get_is_loopback">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<method name="get_is_mc_global" symbol="g_inet_address_get_is_mc_global">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<method name="get_is_mc_link_local" symbol="g_inet_address_get_is_mc_link_local">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<method name="get_is_mc_node_local" symbol="g_inet_address_get_is_mc_node_local">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<method name="get_is_mc_org_local" symbol="g_inet_address_get_is_mc_org_local">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<method name="get_is_mc_site_local" symbol="g_inet_address_get_is_mc_site_local">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<method name="get_is_multicast" symbol="g_inet_address_get_is_multicast">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<method name="get_is_site_local" symbol="g_inet_address_get_is_site_local">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<method name="get_native_size" symbol="g_inet_address_get_native_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<constructor name="new_any" symbol="g_inet_address_new_any">
				<return-type type="GInetAddress*"/>
				<parameters>
					<parameter name="family" type="GSocketFamily"/>
				</parameters>
			</constructor>
			<constructor name="new_from_bytes" symbol="g_inet_address_new_from_bytes">
				<return-type type="GInetAddress*"/>
				<parameters>
					<parameter name="bytes" type="guint8*"/>
					<parameter name="family" type="GSocketFamily"/>
				</parameters>
			</constructor>
			<constructor name="new_from_string" symbol="g_inet_address_new_from_string">
				<return-type type="GInetAddress*"/>
				<parameters>
					<parameter name="string" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_loopback" symbol="g_inet_address_new_loopback">
				<return-type type="GInetAddress*"/>
				<parameters>
					<parameter name="family" type="GSocketFamily"/>
				</parameters>
			</constructor>
			<method name="to_bytes" symbol="g_inet_address_to_bytes">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="g_inet_address_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</method>
			<property name="bytes" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="family" type="GSocketFamily" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="is-any" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-link-local" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-loopback" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-mc-global" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-mc-link-local" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-mc-node-local" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-mc-org-local" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-mc-site-local" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-multicast" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-site-local" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<vfunc name="to_bytes">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</vfunc>
			<vfunc name="to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GInetSocketAddress" parent="GSocketAddress" type-name="GInetSocketAddress" get-type="g_inet_socket_address_get_type">
			<implements>
				<interface name="GSocketConnectable"/>
			</implements>
			<method name="get_address" symbol="g_inet_socket_address_get_address">
				<return-type type="GInetAddress*"/>
				<parameters>
					<parameter name="address" type="GInetSocketAddress*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="g_inet_socket_address_get_port">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="address" type="GInetSocketAddress*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_inet_socket_address_new">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="address" type="GInetAddress*"/>
					<parameter name="port" type="guint16"/>
				</parameters>
			</constructor>
			<property name="address" type="GInetAddress*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="port" type="guint" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GInputStream" parent="GObject" type-name="GInputStream" get-type="g_input_stream_get_type">
			<method name="clear_pending" symbol="g_input_stream_clear_pending">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
				</parameters>
			</method>
			<method name="close" symbol="g_input_stream_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="close_async" symbol="g_input_stream_close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="close_finish" symbol="g_input_stream_close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="has_pending" symbol="g_input_stream_has_pending">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
				</parameters>
			</method>
			<method name="is_closed" symbol="g_input_stream_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
				</parameters>
			</method>
			<method name="read" symbol="g_input_stream_read">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_all" symbol="g_input_stream_read_all">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="bytes_read" type="gsize*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_async" symbol="g_input_stream_read_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="read_finish" symbol="g_input_stream_read_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_pending" symbol="g_input_stream_set_pending">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="skip" symbol="g_input_stream_skip">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="skip_async" symbol="g_input_stream_skip_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="skip_finish" symbol="g_input_stream_skip_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="close_fn">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="read_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="read_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="read_fn">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="skip">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="skip_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="skip_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GMemoryInputStream" parent="GInputStream" type-name="GMemoryInputStream" get-type="g_memory_input_stream_get_type">
			<implements>
				<interface name="GSeekable"/>
			</implements>
			<method name="add_data" symbol="g_memory_input_stream_add_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GMemoryInputStream*"/>
					<parameter name="data" type="void*"/>
					<parameter name="len" type="gssize"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_memory_input_stream_new">
				<return-type type="GInputStream*"/>
			</constructor>
			<constructor name="new_from_data" symbol="g_memory_input_stream_new_from_data">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="data" type="void*"/>
					<parameter name="len" type="gssize"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</constructor>
		</object>
		<object name="GMemoryOutputStream" parent="GOutputStream" type-name="GMemoryOutputStream" get-type="g_memory_output_stream_get_type">
			<implements>
				<interface name="GSeekable"/>
			</implements>
			<method name="get_data" symbol="g_memory_output_stream_get_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="ostream" type="GMemoryOutputStream*"/>
				</parameters>
			</method>
			<method name="get_data_size" symbol="g_memory_output_stream_get_data_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="ostream" type="GMemoryOutputStream*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="g_memory_output_stream_get_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="ostream" type="GMemoryOutputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_memory_output_stream_new">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="data" type="gpointer"/>
					<parameter name="size" type="gsize"/>
					<parameter name="realloc_function" type="GReallocFunc"/>
					<parameter name="destroy_function" type="GDestroyNotify"/>
				</parameters>
			</constructor>
			<property name="data" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="data-size" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="destroy-function" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="realloc-function" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="size" type="gulong" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GMountOperation" parent="GObject" type-name="GMountOperation" get-type="g_mount_operation_get_type">
			<method name="get_anonymous" symbol="g_mount_operation_get_anonymous">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</method>
			<method name="get_choice" symbol="g_mount_operation_get_choice">
				<return-type type="int"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</method>
			<method name="get_domain" symbol="g_mount_operation_get_domain">
				<return-type type="char*"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</method>
			<method name="get_password" symbol="g_mount_operation_get_password">
				<return-type type="char*"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</method>
			<method name="get_password_save" symbol="g_mount_operation_get_password_save">
				<return-type type="GPasswordSave"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</method>
			<method name="get_username" symbol="g_mount_operation_get_username">
				<return-type type="char*"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_mount_operation_new">
				<return-type type="GMountOperation*"/>
			</constructor>
			<method name="reply" symbol="g_mount_operation_reply">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="result" type="GMountOperationResult"/>
				</parameters>
			</method>
			<method name="set_anonymous" symbol="g_mount_operation_set_anonymous">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="anonymous" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_choice" symbol="g_mount_operation_set_choice">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="choice" type="int"/>
				</parameters>
			</method>
			<method name="set_domain" symbol="g_mount_operation_set_domain">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="domain" type="char*"/>
				</parameters>
			</method>
			<method name="set_password" symbol="g_mount_operation_set_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</method>
			<method name="set_password_save" symbol="g_mount_operation_set_password_save">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="save" type="GPasswordSave"/>
				</parameters>
			</method>
			<method name="set_username" symbol="g_mount_operation_set_username">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="username" type="char*"/>
				</parameters>
			</method>
			<property name="anonymous" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="choice" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="domain" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="password" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="password-save" type="GPasswordSave" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="username" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="aborted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</signal>
			<signal name="ask-password" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="message" type="char*"/>
					<parameter name="default_user" type="char*"/>
					<parameter name="default_domain" type="char*"/>
					<parameter name="flags" type="GAskPasswordFlags"/>
				</parameters>
			</signal>
			<signal name="ask-question" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="message" type="char*"/>
					<parameter name="choices" type="GStrv*"/>
				</parameters>
			</signal>
			<signal name="reply" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="result" type="GMountOperationResult"/>
				</parameters>
			</signal>
			<signal name="show-processes" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="message" type="char*"/>
					<parameter name="processes" type="GArray*"/>
					<parameter name="choices" type="GStrv*"/>
				</parameters>
			</signal>
		</object>
		<object name="GNativeVolumeMonitor" parent="GVolumeMonitor" type-name="GNativeVolumeMonitor" get-type="g_native_volume_monitor_get_type">
			<vfunc name="get_mount_for_mount_path">
				<return-type type="GMount*"/>
				<parameters>
					<parameter name="mount_path" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GNetworkAddress" parent="GObject" type-name="GNetworkAddress" get-type="g_network_address_get_type">
			<implements>
				<interface name="GSocketConnectable"/>
			</implements>
			<method name="get_hostname" symbol="g_network_address_get_hostname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="addr" type="GNetworkAddress*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="g_network_address_get_port">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="addr" type="GNetworkAddress*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_network_address_new">
				<return-type type="GSocketConnectable*"/>
				<parameters>
					<parameter name="hostname" type="gchar*"/>
					<parameter name="port" type="guint16"/>
				</parameters>
			</constructor>
			<method name="parse" symbol="g_network_address_parse">
				<return-type type="GSocketConnectable*"/>
				<parameters>
					<parameter name="host_and_port" type="gchar*"/>
					<parameter name="default_port" type="guint16"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="hostname" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="port" type="guint" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GNetworkService" parent="GObject" type-name="GNetworkService" get-type="g_network_service_get_type">
			<implements>
				<interface name="GSocketConnectable"/>
			</implements>
			<method name="get_domain" symbol="g_network_service_get_domain">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="srv" type="GNetworkService*"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="g_network_service_get_protocol">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="srv" type="GNetworkService*"/>
				</parameters>
			</method>
			<method name="get_service" symbol="g_network_service_get_service">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="srv" type="GNetworkService*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_network_service_new">
				<return-type type="GSocketConnectable*"/>
				<parameters>
					<parameter name="service" type="gchar*"/>
					<parameter name="protocol" type="gchar*"/>
					<parameter name="domain" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="domain" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="protocol" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="service" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GOutputStream" parent="GObject" type-name="GOutputStream" get-type="g_output_stream_get_type">
			<method name="clear_pending" symbol="g_output_stream_clear_pending">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
				</parameters>
			</method>
			<method name="close" symbol="g_output_stream_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="close_async" symbol="g_output_stream_close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="close_finish" symbol="g_output_stream_close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="flush" symbol="g_output_stream_flush">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="flush_async" symbol="g_output_stream_flush_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="flush_finish" symbol="g_output_stream_flush_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="has_pending" symbol="g_output_stream_has_pending">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
				</parameters>
			</method>
			<method name="is_closed" symbol="g_output_stream_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
				</parameters>
			</method>
			<method name="is_closing" symbol="g_output_stream_is_closing">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
				</parameters>
			</method>
			<method name="set_pending" symbol="g_output_stream_set_pending">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="splice" symbol="g_output_stream_splice">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="source" type="GInputStream*"/>
					<parameter name="flags" type="GOutputStreamSpliceFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="splice_async" symbol="g_output_stream_splice_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="source" type="GInputStream*"/>
					<parameter name="flags" type="GOutputStreamSpliceFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="splice_finish" symbol="g_output_stream_splice_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="write" symbol="g_output_stream_write">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="write_all" symbol="g_output_stream_write_all">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="bytes_written" type="gsize*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="write_async" symbol="g_output_stream_write_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="write_finish" symbol="g_output_stream_write_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="close_fn">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="flush">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="flush_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="flush_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="splice">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="source" type="GInputStream*"/>
					<parameter name="flags" type="GOutputStreamSpliceFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="splice_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="source" type="GInputStream*"/>
					<parameter name="flags" type="GOutputStreamSpliceFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="splice_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="write_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="write_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="write_fn">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GPermission" parent="GObject" type-name="GPermission" get-type="g_permission_get_type">
			<method name="acquire" symbol="g_permission_acquire">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="acquire_async" symbol="g_permission_acquire_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="acquire_finish" symbol="g_permission_acquire_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_allowed" symbol="g_permission_get_allowed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
				</parameters>
			</method>
			<method name="get_can_acquire" symbol="g_permission_get_can_acquire">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
				</parameters>
			</method>
			<method name="get_can_release" symbol="g_permission_get_can_release">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
				</parameters>
			</method>
			<method name="impl_update" symbol="g_permission_impl_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="allowed" type="gboolean"/>
					<parameter name="can_acquire" type="gboolean"/>
					<parameter name="can_release" type="gboolean"/>
				</parameters>
			</method>
			<method name="release" symbol="g_permission_release">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="release_async" symbol="g_permission_release_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="release_finish" symbol="g_permission_release_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="allowed" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="can-acquire" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="can-release" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<vfunc name="acquire">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="acquire_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="acquire_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="release">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="release_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="release_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="permission" type="GPermission*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GResolver" parent="GObject" type-name="GResolver" get-type="g_resolver_get_type">
			<method name="error_quark" symbol="g_resolver_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="free_addresses" symbol="g_resolver_free_addresses">
				<return-type type="void"/>
				<parameters>
					<parameter name="addresses" type="GList*"/>
				</parameters>
			</method>
			<method name="free_targets" symbol="g_resolver_free_targets">
				<return-type type="void"/>
				<parameters>
					<parameter name="targets" type="GList*"/>
				</parameters>
			</method>
			<method name="get_default" symbol="g_resolver_get_default">
				<return-type type="GResolver*"/>
			</method>
			<method name="lookup_by_address" symbol="g_resolver_lookup_by_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="address" type="GInetAddress*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="lookup_by_address_async" symbol="g_resolver_lookup_by_address_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="address" type="GInetAddress*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="lookup_by_address_finish" symbol="g_resolver_lookup_by_address_finish">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="lookup_by_name" symbol="g_resolver_lookup_by_name">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="hostname" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="lookup_by_name_async" symbol="g_resolver_lookup_by_name_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="hostname" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="lookup_by_name_finish" symbol="g_resolver_lookup_by_name_finish">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="lookup_service" symbol="g_resolver_lookup_service">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="service" type="gchar*"/>
					<parameter name="protocol" type="gchar*"/>
					<parameter name="domain" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="lookup_service_async" symbol="g_resolver_lookup_service_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="service" type="gchar*"/>
					<parameter name="protocol" type="gchar*"/>
					<parameter name="domain" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="lookup_service_finish" symbol="g_resolver_lookup_service_finish">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_default" symbol="g_resolver_set_default">
				<return-type type="void"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
				</parameters>
			</method>
			<signal name="reload" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
				</parameters>
			</signal>
			<vfunc name="lookup_by_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="address" type="GInetAddress*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="lookup_by_address_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="address" type="GInetAddress*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="lookup_by_address_finish">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="lookup_by_name">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="hostname" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="lookup_by_name_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="hostname" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="lookup_by_name_finish">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="lookup_service">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="rrname" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="lookup_service_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="rrname" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="lookup_service_finish">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="resolver" type="GResolver*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GSettings" parent="GObject" type-name="GSettings" get-type="g_settings_get_type">
			<method name="apply" symbol="g_settings_apply">
				<return-type type="void"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
				</parameters>
			</method>
			<method name="bind" symbol="g_settings_bind">
				<return-type type="void"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="object" type="gpointer"/>
					<parameter name="property" type="gchar*"/>
					<parameter name="flags" type="GSettingsBindFlags"/>
				</parameters>
			</method>
			<method name="bind_with_mapping" symbol="g_settings_bind_with_mapping">
				<return-type type="void"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="object" type="gpointer"/>
					<parameter name="property" type="gchar*"/>
					<parameter name="flags" type="GSettingsBindFlags"/>
					<parameter name="get_mapping" type="GSettingsBindGetMapping"/>
					<parameter name="set_mapping" type="GSettingsBindSetMapping"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="bind_writable" symbol="g_settings_bind_writable">
				<return-type type="void"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="object" type="gpointer"/>
					<parameter name="property" type="gchar*"/>
					<parameter name="inverted" type="gboolean"/>
				</parameters>
			</method>
			<method name="delay" symbol="g_settings_delay">
				<return-type type="void"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
				</parameters>
			</method>
			<method name="get" symbol="g_settings_get">
				<return-type type="void"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="format" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_boolean" symbol="g_settings_get_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_child" symbol="g_settings_get_child">
				<return-type type="GSettings*"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_double" symbol="g_settings_get_double">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_enum" symbol="g_settings_get_enum">
				<return-type type="gint"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="g_settings_get_flags">
				<return-type type="guint"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_has_unapplied" symbol="g_settings_get_has_unapplied">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
				</parameters>
			</method>
			<method name="get_int" symbol="g_settings_get_int">
				<return-type type="gint"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_mapped" symbol="g_settings_get_mapped">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="mapping" type="GSettingsGetMapping"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_string" symbol="g_settings_get_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_strv" symbol="g_settings_get_strv">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="g_settings_get_value">
				<return-type type="GVariant*"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="is_writable" symbol="g_settings_is_writable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="list_items" symbol="g_settings_list_items">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
				</parameters>
			</method>
			<method name="list_schemas" symbol="g_settings_list_schemas">
				<return-type type="gchar**"/>
			</method>
			<constructor name="new" symbol="g_settings_new">
				<return-type type="GSettings*"/>
				<parameters>
					<parameter name="schema" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_backend" symbol="g_settings_new_with_backend">
				<return-type type="GSettings*"/>
				<parameters>
					<parameter name="schema" type="gchar*"/>
					<parameter name="backend" type="GSettingsBackend*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_backend_and_path" symbol="g_settings_new_with_backend_and_path">
				<return-type type="GSettings*"/>
				<parameters>
					<parameter name="schema" type="gchar*"/>
					<parameter name="backend" type="GSettingsBackend*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_path" symbol="g_settings_new_with_path">
				<return-type type="GSettings*"/>
				<parameters>
					<parameter name="schema" type="gchar*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="revert" symbol="g_settings_revert">
				<return-type type="void"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
				</parameters>
			</method>
			<method name="set" symbol="g_settings_set">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="format" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_boolean" symbol="g_settings_set_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_double" symbol="g_settings_set_double">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_enum" symbol="g_settings_set_enum">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_flags" symbol="g_settings_set_flags">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="guint"/>
				</parameters>
			</method>
			<method name="set_int" symbol="g_settings_set_int">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_string" symbol="g_settings_set_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_strv" symbol="g_settings_set_strv">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="gchar**"/>
				</parameters>
			</method>
			<method name="set_value" symbol="g_settings_set_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="GVariant*"/>
				</parameters>
			</method>
			<method name="sync" symbol="g_settings_sync">
				<return-type type="void"/>
			</method>
			<method name="unbind" symbol="g_settings_unbind">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="gpointer"/>
					<parameter name="property" type="gchar*"/>
				</parameters>
			</method>
			<property name="backend" type="GSettingsBackend*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="has-unapplied" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="path" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="schema" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="change-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="keys" type="gpointer"/>
					<parameter name="n_keys" type="gint"/>
				</parameters>
			</signal>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="char*"/>
				</parameters>
			</signal>
			<signal name="writable-change-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="guint"/>
				</parameters>
			</signal>
			<signal name="writable-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="settings" type="GSettings*"/>
					<parameter name="key" type="char*"/>
				</parameters>
			</signal>
		</object>
		<object name="GSimpleAsyncResult" parent="GObject" type-name="GSimpleAsyncResult" get-type="g_simple_async_result_get_type">
			<implements>
				<interface name="GAsyncResult"/>
			</implements>
			<method name="complete" symbol="g_simple_async_result_complete">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
				</parameters>
			</method>
			<method name="complete_in_idle" symbol="g_simple_async_result_complete_in_idle">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
				</parameters>
			</method>
			<method name="get_op_res_gboolean" symbol="g_simple_async_result_get_op_res_gboolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
				</parameters>
			</method>
			<method name="get_op_res_gpointer" symbol="g_simple_async_result_get_op_res_gpointer">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
				</parameters>
			</method>
			<method name="get_op_res_gssize" symbol="g_simple_async_result_get_op_res_gssize">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
				</parameters>
			</method>
			<method name="get_source_tag" symbol="g_simple_async_result_get_source_tag">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
				</parameters>
			</method>
			<method name="is_valid" symbol="g_simple_async_result_is_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="source" type="GObject*"/>
					<parameter name="source_tag" type="gpointer"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_simple_async_result_new">
				<return-type type="GSimpleAsyncResult*"/>
				<parameters>
					<parameter name="source_object" type="GObject*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="source_tag" type="gpointer"/>
				</parameters>
			</constructor>
			<constructor name="new_error" symbol="g_simple_async_result_new_error">
				<return-type type="GSimpleAsyncResult*"/>
				<parameters>
					<parameter name="source_object" type="GObject*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="domain" type="GQuark"/>
					<parameter name="code" type="gint"/>
					<parameter name="format" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_error" symbol="g_simple_async_result_new_from_error">
				<return-type type="GSimpleAsyncResult*"/>
				<parameters>
					<parameter name="source_object" type="GObject*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</constructor>
			<method name="propagate_error" symbol="g_simple_async_result_propagate_error">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="dest" type="GError**"/>
				</parameters>
			</method>
			<method name="run_in_thread" symbol="g_simple_async_result_run_in_thread">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="func" type="GSimpleAsyncThreadFunc"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="set_error" symbol="g_simple_async_result_set_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="domain" type="GQuark"/>
					<parameter name="code" type="gint"/>
					<parameter name="format" type="char*"/>
				</parameters>
			</method>
			<method name="set_error_va" symbol="g_simple_async_result_set_error_va">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="domain" type="GQuark"/>
					<parameter name="code" type="gint"/>
					<parameter name="format" type="char*"/>
					<parameter name="args" type="va_list"/>
				</parameters>
			</method>
			<method name="set_from_error" symbol="g_simple_async_result_set_from_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</method>
			<method name="set_handle_cancellation" symbol="g_simple_async_result_set_handle_cancellation">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="handle_cancellation" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_op_res_gboolean" symbol="g_simple_async_result_set_op_res_gboolean">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="op_res" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_op_res_gpointer" symbol="g_simple_async_result_set_op_res_gpointer">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="op_res" type="gpointer"/>
					<parameter name="destroy_op_res" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_op_res_gssize" symbol="g_simple_async_result_set_op_res_gssize">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="op_res" type="gssize"/>
				</parameters>
			</method>
		</object>
		<object name="GSimplePermission" parent="GPermission" type-name="GSimplePermission" get-type="g_simple_permission_get_type">
			<constructor name="new" symbol="g_simple_permission_new">
				<return-type type="GPermission*"/>
				<parameters>
					<parameter name="allowed" type="gboolean"/>
				</parameters>
			</constructor>
		</object>
		<object name="GSocket" parent="GObject" type-name="GSocket" get-type="g_socket_get_type">
			<implements>
				<interface name="GInitable"/>
			</implements>
			<method name="accept" symbol="g_socket_accept">
				<return-type type="GSocket*"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="bind" symbol="g_socket_bind">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="address" type="GSocketAddress*"/>
					<parameter name="allow_reuse" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="check_connect_result" symbol="g_socket_check_connect_result">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="close" symbol="g_socket_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="condition_check" symbol="g_socket_condition_check">
				<return-type type="GIOCondition"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="condition" type="GIOCondition"/>
				</parameters>
			</method>
			<method name="condition_wait" symbol="g_socket_condition_wait">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="condition" type="GIOCondition"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="connect" symbol="g_socket_connect">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="address" type="GSocketAddress*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_source" symbol="g_socket_create_source">
				<return-type type="GSource*"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="condition" type="GIOCondition"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="get_blocking" symbol="g_socket_get_blocking">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
				</parameters>
			</method>
			<method name="get_family" symbol="g_socket_get_family">
				<return-type type="GSocketFamily"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
				</parameters>
			</method>
			<method name="get_fd" symbol="g_socket_get_fd">
				<return-type type="int"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
				</parameters>
			</method>
			<method name="get_keepalive" symbol="g_socket_get_keepalive">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
				</parameters>
			</method>
			<method name="get_listen_backlog" symbol="g_socket_get_listen_backlog">
				<return-type type="gint"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
				</parameters>
			</method>
			<method name="get_local_address" symbol="g_socket_get_local_address">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="g_socket_get_protocol">
				<return-type type="GSocketProtocol"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
				</parameters>
			</method>
			<method name="get_remote_address" symbol="g_socket_get_remote_address">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_socket_type" symbol="g_socket_get_socket_type">
				<return-type type="GSocketType"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
				</parameters>
			</method>
			<method name="get_timeout" symbol="g_socket_get_timeout">
				<return-type type="guint"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
				</parameters>
			</method>
			<method name="is_closed" symbol="g_socket_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
				</parameters>
			</method>
			<method name="is_connected" symbol="g_socket_is_connected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
				</parameters>
			</method>
			<method name="listen" symbol="g_socket_listen">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_socket_new">
				<return-type type="GSocket*"/>
				<parameters>
					<parameter name="family" type="GSocketFamily"/>
					<parameter name="type" type="GSocketType"/>
					<parameter name="protocol" type="GSocketProtocol"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_fd" symbol="g_socket_new_from_fd">
				<return-type type="GSocket*"/>
				<parameters>
					<parameter name="fd" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="receive" symbol="g_socket_receive">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="buffer" type="gchar*"/>
					<parameter name="size" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="receive_from" symbol="g_socket_receive_from">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="address" type="GSocketAddress**"/>
					<parameter name="buffer" type="gchar*"/>
					<parameter name="size" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="receive_message" symbol="g_socket_receive_message">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="address" type="GSocketAddress**"/>
					<parameter name="vectors" type="GInputVector*"/>
					<parameter name="num_vectors" type="gint"/>
					<parameter name="messages" type="GSocketControlMessage***"/>
					<parameter name="num_messages" type="gint*"/>
					<parameter name="flags" type="gint*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="send" symbol="g_socket_send">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="buffer" type="gchar*"/>
					<parameter name="size" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="send_message" symbol="g_socket_send_message">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="address" type="GSocketAddress*"/>
					<parameter name="vectors" type="GOutputVector*"/>
					<parameter name="num_vectors" type="gint"/>
					<parameter name="messages" type="GSocketControlMessage**"/>
					<parameter name="num_messages" type="gint"/>
					<parameter name="flags" type="gint"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="send_to" symbol="g_socket_send_to">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="address" type="GSocketAddress*"/>
					<parameter name="buffer" type="gchar*"/>
					<parameter name="size" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_blocking" symbol="g_socket_set_blocking">
				<return-type type="void"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="blocking" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_keepalive" symbol="g_socket_set_keepalive">
				<return-type type="void"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="keepalive" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_listen_backlog" symbol="g_socket_set_listen_backlog">
				<return-type type="void"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="backlog" type="gint"/>
				</parameters>
			</method>
			<method name="set_timeout" symbol="g_socket_set_timeout">
				<return-type type="void"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="timeout" type="guint"/>
				</parameters>
			</method>
			<method name="shutdown" symbol="g_socket_shutdown">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="shutdown_read" type="gboolean"/>
					<parameter name="shutdown_write" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="speaks_ipv4" symbol="g_socket_speaks_ipv4">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
				</parameters>
			</method>
			<property name="blocking" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="family" type="GSocketFamily" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="fd" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="keepalive" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="listen-backlog" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="local-address" type="GSocketAddress*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="protocol" type="GSocketProtocol" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="remote-address" type="GSocketAddress*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="timeout" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="GSocketType" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GSocketAddress" parent="GObject" type-name="GSocketAddress" get-type="g_socket_address_get_type">
			<implements>
				<interface name="GSocketConnectable"/>
			</implements>
			<method name="get_family" symbol="g_socket_address_get_family">
				<return-type type="GSocketFamily"/>
				<parameters>
					<parameter name="address" type="GSocketAddress*"/>
				</parameters>
			</method>
			<method name="get_native_size" symbol="g_socket_address_get_native_size">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="address" type="GSocketAddress*"/>
				</parameters>
			</method>
			<constructor name="new_from_native" symbol="g_socket_address_new_from_native">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="native" type="gpointer"/>
					<parameter name="len" type="gsize"/>
				</parameters>
			</constructor>
			<method name="to_native" symbol="g_socket_address_to_native">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GSocketAddress*"/>
					<parameter name="dest" type="gpointer"/>
					<parameter name="destlen" type="gsize"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="family" type="GSocketFamily" readable="1" writable="0" construct="0" construct-only="0"/>
			<vfunc name="get_family">
				<return-type type="GSocketFamily"/>
				<parameters>
					<parameter name="address" type="GSocketAddress*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_native_size">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="address" type="GSocketAddress*"/>
				</parameters>
			</vfunc>
			<vfunc name="to_native">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GSocketAddress*"/>
					<parameter name="dest" type="gpointer"/>
					<parameter name="destlen" type="gsize"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GSocketAddressEnumerator" parent="GObject" type-name="GSocketAddressEnumerator" get-type="g_socket_address_enumerator_get_type">
			<method name="next" symbol="g_socket_address_enumerator_next">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="enumerator" type="GSocketAddressEnumerator*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="next_async" symbol="g_socket_address_enumerator_next_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="enumerator" type="GSocketAddressEnumerator*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="next_finish" symbol="g_socket_address_enumerator_next_finish">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="enumerator" type="GSocketAddressEnumerator*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="next">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="enumerator" type="GSocketAddressEnumerator*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="next_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="enumerator" type="GSocketAddressEnumerator*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="next_finish">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="enumerator" type="GSocketAddressEnumerator*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GSocketClient" parent="GObject" type-name="GSocketClient" get-type="g_socket_client_get_type">
			<method name="connect" symbol="g_socket_client_connect">
				<return-type type="GSocketConnection*"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="connectable" type="GSocketConnectable*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="connect_async" symbol="g_socket_client_connect_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="connectable" type="GSocketConnectable*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="connect_finish" symbol="g_socket_client_connect_finish">
				<return-type type="GSocketConnection*"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="connect_to_host" symbol="g_socket_client_connect_to_host">
				<return-type type="GSocketConnection*"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="host_and_port" type="gchar*"/>
					<parameter name="default_port" type="guint16"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="connect_to_host_async" symbol="g_socket_client_connect_to_host_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="host_and_port" type="gchar*"/>
					<parameter name="default_port" type="guint16"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="connect_to_host_finish" symbol="g_socket_client_connect_to_host_finish">
				<return-type type="GSocketConnection*"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="connect_to_service" symbol="g_socket_client_connect_to_service">
				<return-type type="GSocketConnection*"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="domain" type="gchar*"/>
					<parameter name="service" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="connect_to_service_async" symbol="g_socket_client_connect_to_service_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="domain" type="gchar*"/>
					<parameter name="service" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="connect_to_service_finish" symbol="g_socket_client_connect_to_service_finish">
				<return-type type="GSocketConnection*"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_family" symbol="g_socket_client_get_family">
				<return-type type="GSocketFamily"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
				</parameters>
			</method>
			<method name="get_local_address" symbol="g_socket_client_get_local_address">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="g_socket_client_get_protocol">
				<return-type type="GSocketProtocol"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
				</parameters>
			</method>
			<method name="get_socket_type" symbol="g_socket_client_get_socket_type">
				<return-type type="GSocketType"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_socket_client_new">
				<return-type type="GSocketClient*"/>
			</constructor>
			<method name="set_family" symbol="g_socket_client_set_family">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="family" type="GSocketFamily"/>
				</parameters>
			</method>
			<method name="set_local_address" symbol="g_socket_client_set_local_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="address" type="GSocketAddress*"/>
				</parameters>
			</method>
			<method name="set_protocol" symbol="g_socket_client_set_protocol">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="protocol" type="GSocketProtocol"/>
				</parameters>
			</method>
			<method name="set_socket_type" symbol="g_socket_client_set_socket_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GSocketClient*"/>
					<parameter name="type" type="GSocketType"/>
				</parameters>
			</method>
			<property name="family" type="GSocketFamily" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="local-address" type="GSocketAddress*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="protocol" type="GSocketProtocol" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="type" type="GSocketType" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="GSocketConnection" parent="GIOStream" type-name="GSocketConnection" get-type="g_socket_connection_get_type">
			<method name="factory_create_connection" symbol="g_socket_connection_factory_create_connection">
				<return-type type="GSocketConnection*"/>
				<parameters>
					<parameter name="socket" type="GSocket*"/>
				</parameters>
			</method>
			<method name="factory_lookup_type" symbol="g_socket_connection_factory_lookup_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="family" type="GSocketFamily"/>
					<parameter name="type" type="GSocketType"/>
					<parameter name="protocol_id" type="gint"/>
				</parameters>
			</method>
			<method name="factory_register_type" symbol="g_socket_connection_factory_register_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="g_type" type="GType"/>
					<parameter name="family" type="GSocketFamily"/>
					<parameter name="type" type="GSocketType"/>
					<parameter name="protocol" type="gint"/>
				</parameters>
			</method>
			<method name="get_local_address" symbol="g_socket_connection_get_local_address">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="connection" type="GSocketConnection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_remote_address" symbol="g_socket_connection_get_remote_address">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="connection" type="GSocketConnection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_socket" symbol="g_socket_connection_get_socket">
				<return-type type="GSocket*"/>
				<parameters>
					<parameter name="connection" type="GSocketConnection*"/>
				</parameters>
			</method>
			<property name="socket" type="GSocket*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GSocketControlMessage" parent="GObject" type-name="GSocketControlMessage" get-type="g_socket_control_message_get_type">
			<method name="deserialize" symbol="g_socket_control_message_deserialize">
				<return-type type="GSocketControlMessage*"/>
				<parameters>
					<parameter name="level" type="int"/>
					<parameter name="type" type="int"/>
					<parameter name="size" type="gsize"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_level" symbol="g_socket_control_message_get_level">
				<return-type type="int"/>
				<parameters>
					<parameter name="message" type="GSocketControlMessage*"/>
				</parameters>
			</method>
			<method name="get_msg_type" symbol="g_socket_control_message_get_msg_type">
				<return-type type="int"/>
				<parameters>
					<parameter name="message" type="GSocketControlMessage*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="g_socket_control_message_get_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="message" type="GSocketControlMessage*"/>
				</parameters>
			</method>
			<method name="serialize" symbol="g_socket_control_message_serialize">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GSocketControlMessage*"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<vfunc name="deserialize">
				<return-type type="GSocketControlMessage*"/>
				<parameters>
					<parameter name="level" type="int"/>
					<parameter name="type" type="int"/>
					<parameter name="size" type="gsize"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="get_level">
				<return-type type="int"/>
				<parameters>
					<parameter name="message" type="GSocketControlMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="message" type="GSocketControlMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_type">
				<return-type type="int"/>
				<parameters>
					<parameter name="message" type="GSocketControlMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="serialize">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GSocketControlMessage*"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GSocketListener" parent="GObject" type-name="GSocketListener" get-type="g_socket_listener_get_type">
			<method name="accept" symbol="g_socket_listener_accept">
				<return-type type="GSocketConnection*"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
					<parameter name="source_object" type="GObject**"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="accept_async" symbol="g_socket_listener_accept_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="accept_finish" symbol="g_socket_listener_accept_finish">
				<return-type type="GSocketConnection*"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="source_object" type="GObject**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="accept_socket" symbol="g_socket_listener_accept_socket">
				<return-type type="GSocket*"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
					<parameter name="source_object" type="GObject**"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="accept_socket_async" symbol="g_socket_listener_accept_socket_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="accept_socket_finish" symbol="g_socket_listener_accept_socket_finish">
				<return-type type="GSocket*"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="source_object" type="GObject**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="add_address" symbol="g_socket_listener_add_address">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
					<parameter name="address" type="GSocketAddress*"/>
					<parameter name="type" type="GSocketType"/>
					<parameter name="protocol" type="GSocketProtocol"/>
					<parameter name="source_object" type="GObject*"/>
					<parameter name="effective_address" type="GSocketAddress**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="add_any_inet_port" symbol="g_socket_listener_add_any_inet_port">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
					<parameter name="source_object" type="GObject*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="add_inet_port" symbol="g_socket_listener_add_inet_port">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
					<parameter name="port" type="guint16"/>
					<parameter name="source_object" type="GObject*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="add_socket" symbol="g_socket_listener_add_socket">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
					<parameter name="socket" type="GSocket*"/>
					<parameter name="source_object" type="GObject*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="close" symbol="g_socket_listener_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_socket_listener_new">
				<return-type type="GSocketListener*"/>
			</constructor>
			<method name="set_backlog" symbol="g_socket_listener_set_backlog">
				<return-type type="void"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
					<parameter name="listen_backlog" type="int"/>
				</parameters>
			</method>
			<property name="listen-backlog" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<vfunc name="changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="listener" type="GSocketListener*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GSocketService" parent="GSocketListener" type-name="GSocketService" get-type="g_socket_service_get_type">
			<method name="is_active" symbol="g_socket_service_is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="service" type="GSocketService*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_socket_service_new">
				<return-type type="GSocketService*"/>
			</constructor>
			<method name="start" symbol="g_socket_service_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="GSocketService*"/>
				</parameters>
			</method>
			<method name="stop" symbol="g_socket_service_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="GSocketService*"/>
				</parameters>
			</method>
			<signal name="incoming" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="service" type="GSocketService*"/>
					<parameter name="connection" type="GSocketConnection*"/>
					<parameter name="source_object" type="GObject*"/>
				</parameters>
			</signal>
		</object>
		<object name="GTcpConnection" parent="GSocketConnection" type-name="GTcpConnection" get-type="g_tcp_connection_get_type">
			<method name="get_graceful_disconnect" symbol="g_tcp_connection_get_graceful_disconnect">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="GTcpConnection*"/>
				</parameters>
			</method>
			<method name="set_graceful_disconnect" symbol="g_tcp_connection_set_graceful_disconnect">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="GTcpConnection*"/>
					<parameter name="graceful_disconnect" type="gboolean"/>
				</parameters>
			</method>
			<property name="graceful-disconnect" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GThemedIcon" parent="GObject" type-name="GThemedIcon" get-type="g_themed_icon_get_type">
			<implements>
				<interface name="GIcon"/>
			</implements>
			<method name="append_name" symbol="g_themed_icon_append_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon" type="GThemedIcon*"/>
					<parameter name="iconname" type="char*"/>
				</parameters>
			</method>
			<method name="get_names" symbol="g_themed_icon_get_names">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="icon" type="GThemedIcon*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_themed_icon_new">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="iconname" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_names" symbol="g_themed_icon_new_from_names">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="iconnames" type="char**"/>
					<parameter name="len" type="int"/>
				</parameters>
			</constructor>
			<constructor name="new_with_default_fallbacks" symbol="g_themed_icon_new_with_default_fallbacks">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="iconname" type="char*"/>
				</parameters>
			</constructor>
			<method name="prepend_name" symbol="g_themed_icon_prepend_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon" type="GThemedIcon*"/>
					<parameter name="iconname" type="char*"/>
				</parameters>
			</method>
			<property name="name" type="char*" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="names" type="GStrv*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="use-default-fallbacks" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GThreadedSocketService" parent="GSocketService" type-name="GThreadedSocketService" get-type="g_threaded_socket_service_get_type">
			<constructor name="new" symbol="g_threaded_socket_service_new">
				<return-type type="GSocketService*"/>
				<parameters>
					<parameter name="max_threads" type="int"/>
				</parameters>
			</constructor>
			<property name="max-threads" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="run" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="service" type="GThreadedSocketService*"/>
					<parameter name="connection" type="GSocketConnection*"/>
					<parameter name="source_object" type="GObject*"/>
				</parameters>
			</signal>
		</object>
		<object name="GVfs" parent="GObject" type-name="GVfs" get-type="g_vfs_get_type">
			<method name="get_default" symbol="g_vfs_get_default">
				<return-type type="GVfs*"/>
			</method>
			<method name="get_file_for_path" symbol="g_vfs_get_file_for_path">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="get_file_for_uri" symbol="g_vfs_get_file_for_uri">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="uri" type="char*"/>
				</parameters>
			</method>
			<method name="get_local" symbol="g_vfs_get_local">
				<return-type type="GVfs*"/>
			</method>
			<method name="get_supported_uri_schemes" symbol="g_vfs_get_supported_uri_schemes">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
				</parameters>
			</method>
			<method name="is_active" symbol="g_vfs_is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
				</parameters>
			</method>
			<method name="parse_name" symbol="g_vfs_parse_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="parse_name" type="char*"/>
				</parameters>
			</method>
			<vfunc name="add_writable_namespaces">
				<return-type type="void"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="list" type="GFileAttributeInfoList*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_file_for_path">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_file_for_uri">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="uri" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_supported_uri_schemes">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
				</parameters>
			</vfunc>
			<vfunc name="local_file_add_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="filename" type="char*"/>
					<parameter name="device" type="guint64"/>
					<parameter name="attribute_matcher" type="GFileAttributeMatcher*"/>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="extra_data" type="gpointer*"/>
					<parameter name="free_extra_data" type="GDestroyNotify*"/>
				</parameters>
			</vfunc>
			<vfunc name="local_file_moved">
				<return-type type="void"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="source" type="char*"/>
					<parameter name="dest" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="local_file_removed">
				<return-type type="void"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="filename" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="local_file_set_attributes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="filename" type="char*"/>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="parse_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="parse_name" type="char*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GVolumeMonitor" parent="GObject" type-name="GVolumeMonitor" get-type="g_volume_monitor_get_type">
			<method name="adopt_orphan_mount" symbol="g_volume_monitor_adopt_orphan_mount">
				<return-type type="GVolume*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<method name="get" symbol="g_volume_monitor_get">
				<return-type type="GVolumeMonitor*"/>
			</method>
			<method name="get_connected_drives" symbol="g_volume_monitor_get_connected_drives">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
				</parameters>
			</method>
			<method name="get_mount_for_uuid" symbol="g_volume_monitor_get_mount_for_uuid">
				<return-type type="GMount*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="uuid" type="char*"/>
				</parameters>
			</method>
			<method name="get_mounts" symbol="g_volume_monitor_get_mounts">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
				</parameters>
			</method>
			<method name="get_volume_for_uuid" symbol="g_volume_monitor_get_volume_for_uuid">
				<return-type type="GVolume*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="uuid" type="char*"/>
				</parameters>
			</method>
			<method name="get_volumes" symbol="g_volume_monitor_get_volumes">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
				</parameters>
			</method>
			<signal name="drive-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</signal>
			<signal name="drive-connected" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</signal>
			<signal name="drive-disconnected" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</signal>
			<signal name="drive-eject-button" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</signal>
			<signal name="drive-stop-button" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</signal>
			<signal name="mount-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</signal>
			<signal name="mount-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</signal>
			<signal name="mount-pre-unmount" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</signal>
			<signal name="mount-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</signal>
			<signal name="volume-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</signal>
			<signal name="volume-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</signal>
			<signal name="volume-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</signal>
			<vfunc name="adopt_orphan_mount">
				<return-type type="GVolume*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_connected_drives">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_mount_for_uuid">
				<return-type type="GMount*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="uuid" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_mounts">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_volume_for_uuid">
				<return-type type="GVolume*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="uuid" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_volumes">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_supported">
				<return-type type="gboolean"/>
			</vfunc>
		</object>
		<object name="GZlibCompressor" parent="GObject" type-name="GZlibCompressor" get-type="g_zlib_compressor_get_type">
			<implements>
				<interface name="GConverter"/>
			</implements>
			<constructor name="new" symbol="g_zlib_compressor_new">
				<return-type type="GZlibCompressor*"/>
				<parameters>
					<parameter name="format" type="GZlibCompressorFormat"/>
					<parameter name="level" type="int"/>
				</parameters>
			</constructor>
			<property name="format" type="GZlibCompressorFormat" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="level" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GZlibDecompressor" parent="GObject" type-name="GZlibDecompressor" get-type="g_zlib_decompressor_get_type">
			<implements>
				<interface name="GConverter"/>
			</implements>
			<constructor name="new" symbol="g_zlib_decompressor_new">
				<return-type type="GZlibDecompressor*"/>
				<parameters>
					<parameter name="format" type="GZlibCompressorFormat"/>
				</parameters>
			</constructor>
			<property name="format" type="GZlibCompressorFormat" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<interface name="GAppInfo" type-name="GAppInfo" get-type="g_app_info_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="add_supports_type" symbol="g_app_info_add_supports_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="can_delete" symbol="g_app_info_can_delete">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="can_remove_supports_type" symbol="g_app_info_can_remove_supports_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="create_from_commandline" symbol="g_app_info_create_from_commandline">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="commandline" type="char*"/>
					<parameter name="application_name" type="char*"/>
					<parameter name="flags" type="GAppInfoCreateFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="delete" symbol="g_app_info_delete">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="dup" symbol="g_app_info_dup">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="equal" symbol="g_app_info_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo1" type="GAppInfo*"/>
					<parameter name="appinfo2" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="get_all" symbol="g_app_info_get_all">
				<return-type type="GList*"/>
			</method>
			<method name="get_all_for_type" symbol="g_app_info_get_all_for_type">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="content_type" type="char*"/>
				</parameters>
			</method>
			<method name="get_commandline" symbol="g_app_info_get_commandline">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="get_default_for_type" symbol="g_app_info_get_default_for_type">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="content_type" type="char*"/>
					<parameter name="must_support_uris" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_default_for_uri_scheme" symbol="g_app_info_get_default_for_uri_scheme">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="uri_scheme" type="char*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="g_app_info_get_description">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="get_display_name" symbol="g_app_info_get_display_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="get_executable" symbol="g_app_info_get_executable">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="g_app_info_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="g_app_info_get_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="g_app_info_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="launch" symbol="g_app_info_launch">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="files" type="GList*"/>
					<parameter name="launch_context" type="GAppLaunchContext*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="launch_default_for_uri" symbol="g_app_info_launch_default_for_uri">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="uri" type="char*"/>
					<parameter name="launch_context" type="GAppLaunchContext*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="launch_uris" symbol="g_app_info_launch_uris">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="uris" type="GList*"/>
					<parameter name="launch_context" type="GAppLaunchContext*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="remove_supports_type" symbol="g_app_info_remove_supports_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="reset_type_associations" symbol="g_app_info_reset_type_associations">
				<return-type type="void"/>
				<parameters>
					<parameter name="content_type" type="char*"/>
				</parameters>
			</method>
			<method name="set_as_default_for_extension" symbol="g_app_info_set_as_default_for_extension">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="extension" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_as_default_for_type" symbol="g_app_info_set_as_default_for_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="should_show" symbol="g_app_info_should_show">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="supports_files" symbol="g_app_info_supports_files">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="supports_uris" symbol="g_app_info_supports_uris">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<vfunc name="add_supports_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="can_delete">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_remove_supports_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="do_delete">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="dup">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo1" type="GAppInfo*"/>
					<parameter name="appinfo2" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_commandline">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_description">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_display_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_executable">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="launch">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="filenames" type="GList*"/>
					<parameter name="launch_context" type="GAppLaunchContext*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="launch_uris">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="uris" type="GList*"/>
					<parameter name="launch_context" type="GAppLaunchContext*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_supports_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_as_default_for_extension">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="extension" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_as_default_for_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="should_show">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="supports_files">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="supports_uris">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GAsyncInitable" type-name="GAsyncInitable" get-type="g_async_initable_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="init_async" symbol="g_async_initable_init_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="initable" type="GAsyncInitable*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="init_finish" symbol="g_async_initable_init_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="initable" type="GAsyncInitable*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="new_async" symbol="g_async_initable_new_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="object_type" type="GType"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="first_property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="new_finish" symbol="g_async_initable_new_finish">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="initable" type="GAsyncInitable*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="new_valist_async" symbol="g_async_initable_new_valist_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="object_type" type="GType"/>
					<parameter name="first_property_name" type="gchar*"/>
					<parameter name="var_args" type="va_list"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="newv_async" symbol="g_async_initable_newv_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="object_type" type="GType"/>
					<parameter name="n_parameters" type="guint"/>
					<parameter name="parameters" type="GParameter*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<vfunc name="init_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="initable" type="GAsyncInitable*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="init_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="initable" type="GAsyncInitable*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GAsyncResult" type-name="GAsyncResult" get-type="g_async_result_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="get_source_object" symbol="g_async_result_get_source_object">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="res" type="GAsyncResult*"/>
				</parameters>
			</method>
			<method name="get_user_data" symbol="g_async_result_get_user_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="res" type="GAsyncResult*"/>
				</parameters>
			</method>
			<vfunc name="get_source_object">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="async_result" type="GAsyncResult*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_user_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="async_result" type="GAsyncResult*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GConverter" type-name="GConverter" get-type="g_converter_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="convert" symbol="g_converter_convert">
				<return-type type="GConverterResult"/>
				<parameters>
					<parameter name="converter" type="GConverter*"/>
					<parameter name="inbuf" type="void*"/>
					<parameter name="inbuf_size" type="gsize"/>
					<parameter name="outbuf" type="void*"/>
					<parameter name="outbuf_size" type="gsize"/>
					<parameter name="flags" type="GConverterFlags"/>
					<parameter name="bytes_read" type="gsize*"/>
					<parameter name="bytes_written" type="gsize*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="reset" symbol="g_converter_reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="converter" type="GConverter*"/>
				</parameters>
			</method>
			<vfunc name="convert">
				<return-type type="GConverterResult"/>
				<parameters>
					<parameter name="converter" type="GConverter*"/>
					<parameter name="inbuf" type="void*"/>
					<parameter name="inbuf_size" type="gsize"/>
					<parameter name="outbuf" type="void*"/>
					<parameter name="outbuf_size" type="gsize"/>
					<parameter name="flags" type="GConverterFlags"/>
					<parameter name="bytes_read" type="gsize*"/>
					<parameter name="bytes_written" type="gsize*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="converter" type="GConverter*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GDrive" type-name="GDrive" get-type="g_drive_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="can_eject" symbol="g_drive_can_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="can_poll_for_media" symbol="g_drive_can_poll_for_media">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="can_start" symbol="g_drive_can_start">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="can_start_degraded" symbol="g_drive_can_start_degraded">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="can_stop" symbol="g_drive_can_stop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="eject" symbol="g_drive_eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="eject_finish" symbol="g_drive_eject_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="eject_with_operation" symbol="g_drive_eject_with_operation">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="eject_with_operation_finish" symbol="g_drive_eject_with_operation_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="enumerate_identifiers" symbol="g_drive_enumerate_identifiers">
				<return-type type="char**"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="g_drive_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="get_identifier" symbol="g_drive_get_identifier">
				<return-type type="char*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="kind" type="char*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="g_drive_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="get_start_stop_type" symbol="g_drive_get_start_stop_type">
				<return-type type="GDriveStartStopType"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="get_volumes" symbol="g_drive_get_volumes">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="has_media" symbol="g_drive_has_media">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="has_volumes" symbol="g_drive_has_volumes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="is_media_check_automatic" symbol="g_drive_is_media_check_automatic">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="is_media_removable" symbol="g_drive_is_media_removable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="poll_for_media" symbol="g_drive_poll_for_media">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="poll_for_media_finish" symbol="g_drive_poll_for_media_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="start" symbol="g_drive_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="flags" type="GDriveStartFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="start_finish" symbol="g_drive_start_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="stop" symbol="g_drive_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="stop_finish" symbol="g_drive_stop_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</signal>
			<signal name="disconnected" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</signal>
			<signal name="eject-button" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</signal>
			<signal name="stop-button" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</signal>
			<vfunc name="can_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_poll_for_media">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_start">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_start_degraded">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_stop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_with_operation">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_with_operation_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="enumerate_identifiers">
				<return-type type="char**"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_identifier">
				<return-type type="char*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="kind" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_start_stop_type">
				<return-type type="GDriveStartStopType"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_volumes">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="has_media">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="has_volumes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_media_check_automatic">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_media_removable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="poll_for_media">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="poll_for_media_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="start">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="flags" type="GDriveStartFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="start_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="stop_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GFile" type-name="GFile" get-type="g_file_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="append_to" symbol="g_file_append_to">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="append_to_async" symbol="g_file_append_to_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="append_to_finish" symbol="g_file_append_to_finish">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="copy" symbol="g_file_copy">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="source" type="GFile*"/>
					<parameter name="destination" type="GFile*"/>
					<parameter name="flags" type="GFileCopyFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GFileProgressCallback"/>
					<parameter name="progress_callback_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="copy_async" symbol="g_file_copy_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="source" type="GFile*"/>
					<parameter name="destination" type="GFile*"/>
					<parameter name="flags" type="GFileCopyFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GFileProgressCallback"/>
					<parameter name="progress_callback_data" type="gpointer"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="copy_attributes" symbol="g_file_copy_attributes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="source" type="GFile*"/>
					<parameter name="destination" type="GFile*"/>
					<parameter name="flags" type="GFileCopyFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="copy_finish" symbol="g_file_copy_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create" symbol="g_file_create">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_async" symbol="g_file_create_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="create_finish" symbol="g_file_create_finish">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_readwrite" symbol="g_file_create_readwrite">
				<return-type type="GFileIOStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_readwrite_async" symbol="g_file_create_readwrite_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="create_readwrite_finish" symbol="g_file_create_readwrite_finish">
				<return-type type="GFileIOStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="delete" symbol="g_file_delete">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="dup" symbol="g_file_dup">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="eject_mountable" symbol="g_file_eject_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="eject_mountable_finish" symbol="g_file_eject_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="eject_mountable_with_operation" symbol="g_file_eject_mountable_with_operation">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="eject_mountable_with_operation_finish" symbol="g_file_eject_mountable_with_operation_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="enumerate_children" symbol="g_file_enumerate_children">
				<return-type type="GFileEnumerator*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="enumerate_children_async" symbol="g_file_enumerate_children_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="enumerate_children_finish" symbol="g_file_enumerate_children_finish">
				<return-type type="GFileEnumerator*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="equal" symbol="g_file_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file1" type="GFile*"/>
					<parameter name="file2" type="GFile*"/>
				</parameters>
			</method>
			<method name="find_enclosing_mount" symbol="g_file_find_enclosing_mount">
				<return-type type="GMount*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="find_enclosing_mount_async" symbol="g_file_find_enclosing_mount_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="find_enclosing_mount_finish" symbol="g_file_find_enclosing_mount_finish">
				<return-type type="GMount*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_basename" symbol="g_file_get_basename">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="get_child" symbol="g_file_get_child">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_child_for_display_name" symbol="g_file_get_child_for_display_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="display_name" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="g_file_get_parent">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="get_parse_name" symbol="g_file_get_parse_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="get_path" symbol="g_file_get_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="get_relative_path" symbol="g_file_get_relative_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="parent" type="GFile*"/>
					<parameter name="descendant" type="GFile*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="g_file_get_uri">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="get_uri_scheme" symbol="g_file_get_uri_scheme">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="has_parent" symbol="g_file_has_parent">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="parent" type="GFile*"/>
				</parameters>
			</method>
			<method name="has_prefix" symbol="g_file_has_prefix">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="prefix" type="GFile*"/>
				</parameters>
			</method>
			<method name="has_uri_scheme" symbol="g_file_has_uri_scheme">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="uri_scheme" type="char*"/>
				</parameters>
			</method>
			<method name="hash" symbol="g_file_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="file" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="is_native" symbol="g_file_is_native">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="load_contents" symbol="g_file_load_contents">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="contents" type="char**"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="etag_out" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="load_contents_async" symbol="g_file_load_contents_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="load_contents_finish" symbol="g_file_load_contents_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="contents" type="char**"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="etag_out" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="load_partial_contents_async" symbol="g_file_load_partial_contents_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="read_more_callback" type="GFileReadMoreCallback"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="load_partial_contents_finish" symbol="g_file_load_partial_contents_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="contents" type="char**"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="etag_out" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="make_directory" symbol="g_file_make_directory">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="make_directory_with_parents" symbol="g_file_make_directory_with_parents">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="make_symbolic_link" symbol="g_file_make_symbolic_link">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="symlink_value" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="monitor" symbol="g_file_monitor">
				<return-type type="GFileMonitor*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileMonitorFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="mount_enclosing_volume" symbol="g_file_mount_enclosing_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="location" type="GFile*"/>
					<parameter name="flags" type="GMountMountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="mount_enclosing_volume_finish" symbol="g_file_mount_enclosing_volume_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="location" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="mount_mountable" symbol="g_file_mount_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GMountMountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="mount_mountable_finish" symbol="g_file_mount_mountable_finish">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="move" symbol="g_file_move">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="source" type="GFile*"/>
					<parameter name="destination" type="GFile*"/>
					<parameter name="flags" type="GFileCopyFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GFileProgressCallback"/>
					<parameter name="progress_callback_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="new_for_commandline_arg" symbol="g_file_new_for_commandline_arg">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="arg" type="char*"/>
				</parameters>
			</method>
			<method name="new_for_path" symbol="g_file_new_for_path">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="new_for_uri" symbol="g_file_new_for_uri">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="uri" type="char*"/>
				</parameters>
			</method>
			<method name="open_readwrite" symbol="g_file_open_readwrite">
				<return-type type="GFileIOStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="open_readwrite_async" symbol="g_file_open_readwrite_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="open_readwrite_finish" symbol="g_file_open_readwrite_finish">
				<return-type type="GFileIOStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="parse_name" symbol="g_file_parse_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="parse_name" type="char*"/>
				</parameters>
			</method>
			<method name="poll_mountable" symbol="g_file_poll_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="poll_mountable_finish" symbol="g_file_poll_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_default_handler" symbol="g_file_query_default_handler">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_exists" symbol="g_file_query_exists">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="query_file_type" symbol="g_file_query_file_type">
				<return-type type="GFileType"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="query_filesystem_info" symbol="g_file_query_filesystem_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_filesystem_info_async" symbol="g_file_query_filesystem_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_filesystem_info_finish" symbol="g_file_query_filesystem_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_info" symbol="g_file_query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_info_async" symbol="g_file_query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_info_finish" symbol="g_file_query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_settable_attributes" symbol="g_file_query_settable_attributes">
				<return-type type="GFileAttributeInfoList*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_writable_namespaces" symbol="g_file_query_writable_namespaces">
				<return-type type="GFileAttributeInfoList*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read" symbol="g_file_read">
				<return-type type="GFileInputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_async" symbol="g_file_read_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="read_finish" symbol="g_file_read_finish">
				<return-type type="GFileInputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="replace" symbol="g_file_replace">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="replace_async" symbol="g_file_replace_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="replace_contents" symbol="g_file_replace_contents">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="contents" type="char*"/>
					<parameter name="length" type="gsize"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="new_etag" type="char**"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="replace_contents_async" symbol="g_file_replace_contents_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="contents" type="char*"/>
					<parameter name="length" type="gsize"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="replace_contents_finish" symbol="g_file_replace_contents_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="new_etag" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="replace_finish" symbol="g_file_replace_finish">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="replace_readwrite" symbol="g_file_replace_readwrite">
				<return-type type="GFileIOStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="replace_readwrite_async" symbol="g_file_replace_readwrite_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="replace_readwrite_finish" symbol="g_file_replace_readwrite_finish">
				<return-type type="GFileIOStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="resolve_relative_path" symbol="g_file_resolve_relative_path">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="relative_path" type="char*"/>
				</parameters>
			</method>
			<method name="set_attribute" symbol="g_file_set_attribute">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="type" type="GFileAttributeType"/>
					<parameter name="value_p" type="gpointer"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_byte_string" symbol="g_file_set_attribute_byte_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_int32" symbol="g_file_set_attribute_int32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="gint32"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_int64" symbol="g_file_set_attribute_int64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="gint64"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_string" symbol="g_file_set_attribute_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_uint32" symbol="g_file_set_attribute_uint32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="guint32"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_uint64" symbol="g_file_set_attribute_uint64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="guint64"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attributes_async" symbol="g_file_set_attributes_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_attributes_finish" symbol="g_file_set_attributes_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="info" type="GFileInfo**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attributes_from_info" symbol="g_file_set_attributes_from_info">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_display_name" symbol="g_file_set_display_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="display_name" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_display_name_async" symbol="g_file_set_display_name_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="display_name" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_display_name_finish" symbol="g_file_set_display_name_finish">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="start_mountable" symbol="g_file_start_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GDriveStartFlags"/>
					<parameter name="start_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="start_mountable_finish" symbol="g_file_start_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="stop_mountable" symbol="g_file_stop_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="stop_mountable_finish" symbol="g_file_stop_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="supports_thread_contexts" symbol="g_file_supports_thread_contexts">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="trash" symbol="g_file_trash">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="unmount_mountable" symbol="g_file_unmount_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="unmount_mountable_finish" symbol="g_file_unmount_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="unmount_mountable_with_operation" symbol="g_file_unmount_mountable_with_operation">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="unmount_mountable_with_operation_finish" symbol="g_file_unmount_mountable_with_operation_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="append_to">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="append_to_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="append_to_finish">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="copy">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="source" type="GFile*"/>
					<parameter name="destination" type="GFile*"/>
					<parameter name="flags" type="GFileCopyFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GFileProgressCallback"/>
					<parameter name="progress_callback_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="copy_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="source" type="GFile*"/>
					<parameter name="destination" type="GFile*"/>
					<parameter name="flags" type="GFileCopyFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GFileProgressCallback"/>
					<parameter name="progress_callback_data" type="gpointer"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="copy_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="create">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="create_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="create_finish">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="create_readwrite">
				<return-type type="GFileIOStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="create_readwrite_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="create_readwrite_finish">
				<return-type type="GFileIOStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="delete_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="dup">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_mountable_with_operation">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_mountable_with_operation_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="enumerate_children">
				<return-type type="GFileEnumerator*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="enumerate_children_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="enumerate_children_finish">
				<return-type type="GFileEnumerator*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file1" type="GFile*"/>
					<parameter name="file2" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="find_enclosing_mount">
				<return-type type="GMount*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="find_enclosing_mount_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="find_enclosing_mount_finish">
				<return-type type="GMount*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="get_basename">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_child_for_display_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="display_name" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="get_parent">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_parse_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_relative_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="parent" type="GFile*"/>
					<parameter name="descendant" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_uri">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_uri_scheme">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="has_uri_scheme">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="uri_scheme" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_native">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="make_directory">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="make_symbolic_link">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="symlink_value" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="monitor_dir">
				<return-type type="GFileMonitor*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileMonitorFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="monitor_file">
				<return-type type="GFileMonitor*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileMonitorFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="mount_enclosing_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="location" type="GFile*"/>
					<parameter name="flags" type="GMountMountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="mount_enclosing_volume_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="location" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="mount_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GMountMountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="mount_mountable_finish">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="move">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="source" type="GFile*"/>
					<parameter name="destination" type="GFile*"/>
					<parameter name="flags" type="GFileCopyFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GFileProgressCallback"/>
					<parameter name="progress_callback_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="open_readwrite">
				<return-type type="GFileIOStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="open_readwrite_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="open_readwrite_finish">
				<return-type type="GFileIOStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="poll_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="poll_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="prefix_matches">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="prefix" type="GFile*"/>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="query_filesystem_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_filesystem_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="query_filesystem_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_settable_attributes">
				<return-type type="GFileAttributeInfoList*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_writable_namespaces">
				<return-type type="GFileAttributeInfoList*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="read_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="read_finish">
				<return-type type="GFileInputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="read_fn">
				<return-type type="GFileInputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="replace">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="replace_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="replace_finish">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="replace_readwrite">
				<return-type type="GFileIOStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="replace_readwrite_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="replace_readwrite_finish">
				<return-type type="GFileIOStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="resolve_relative_path">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="relative_path" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_attribute">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="type" type="GFileAttributeType"/>
					<parameter name="value_p" type="gpointer"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_attributes_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="set_attributes_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="info" type="GFileInfo**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_attributes_from_info">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_display_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="display_name" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_display_name_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="display_name" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="set_display_name_finish">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="start_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GDriveStartFlags"/>
					<parameter name="start_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="start_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="stop_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="stop_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="trash">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="unmount_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="unmount_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="unmount_mountable_with_operation">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="unmount_mountable_with_operation_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GIcon" type-name="GIcon" get-type="g_icon_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="equal" symbol="g_icon_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="icon1" type="GIcon*"/>
					<parameter name="icon2" type="GIcon*"/>
				</parameters>
			</method>
			<method name="hash" symbol="g_icon_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="icon" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="new_for_string" symbol="g_icon_new_for_string">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="str" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="to_string" symbol="g_icon_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="icon" type="GIcon*"/>
				</parameters>
			</method>
			<vfunc name="equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="icon1" type="GIcon*"/>
					<parameter name="icon2" type="GIcon*"/>
				</parameters>
			</vfunc>
			<vfunc name="from_tokens">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="tokens" type="gchar**"/>
					<parameter name="num_tokens" type="gint"/>
					<parameter name="version" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="icon" type="GIcon*"/>
				</parameters>
			</vfunc>
			<vfunc name="to_tokens">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="icon" type="GIcon*"/>
					<parameter name="tokens" type="GPtrArray*"/>
					<parameter name="out_version" type="gint*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GInitable" type-name="GInitable" get-type="g_initable_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="init" symbol="g_initable_init">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="initable" type="GInitable*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="new" symbol="g_initable_new">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="object_type" type="GType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
					<parameter name="first_property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="new_valist" symbol="g_initable_new_valist">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="object_type" type="GType"/>
					<parameter name="first_property_name" type="gchar*"/>
					<parameter name="var_args" type="va_list"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="newv" symbol="g_initable_newv">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="object_type" type="GType"/>
					<parameter name="n_parameters" type="guint"/>
					<parameter name="parameters" type="GParameter*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="init">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="initable" type="GInitable*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GLoadableIcon" type-name="GLoadableIcon" get-type="g_loadable_icon_get_type">
			<requires>
				<interface name="GIcon"/>
				<interface name="GObject"/>
			</requires>
			<method name="load" symbol="g_loadable_icon_load">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="icon" type="GLoadableIcon*"/>
					<parameter name="size" type="int"/>
					<parameter name="type" type="char**"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="load_async" symbol="g_loadable_icon_load_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon" type="GLoadableIcon*"/>
					<parameter name="size" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="load_finish" symbol="g_loadable_icon_load_finish">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="icon" type="GLoadableIcon*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="type" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="load">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="icon" type="GLoadableIcon*"/>
					<parameter name="size" type="int"/>
					<parameter name="type" type="char**"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="load_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon" type="GLoadableIcon*"/>
					<parameter name="size" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="load_finish">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="icon" type="GLoadableIcon*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="type" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GMount" type-name="GMount" get-type="g_mount_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="can_eject" symbol="g_mount_can_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<method name="can_unmount" symbol="g_mount_can_unmount">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<method name="eject" symbol="g_mount_eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="eject_finish" symbol="g_mount_eject_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="eject_with_operation" symbol="g_mount_eject_with_operation">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="eject_with_operation_finish" symbol="g_mount_eject_with_operation_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_default_location" symbol="g_mount_get_default_location">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<method name="get_drive" symbol="g_mount_get_drive">
				<return-type type="GDrive*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="g_mount_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="g_mount_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<method name="get_root" symbol="g_mount_get_root">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<method name="get_uuid" symbol="g_mount_get_uuid">
				<return-type type="char*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<method name="get_volume" symbol="g_mount_get_volume">
				<return-type type="GVolume*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<method name="guess_content_type" symbol="g_mount_guess_content_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="force_rescan" type="gboolean"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="guess_content_type_finish" symbol="g_mount_guess_content_type_finish">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="guess_content_type_sync" symbol="g_mount_guess_content_type_sync">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="force_rescan" type="gboolean"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="is_shadowed" symbol="g_mount_is_shadowed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<method name="remount" symbol="g_mount_remount">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="flags" type="GMountMountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="remount_finish" symbol="g_mount_remount_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="shadow" symbol="g_mount_shadow">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<method name="unmount" symbol="g_mount_unmount">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="unmount_finish" symbol="g_mount_unmount_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="unmount_with_operation" symbol="g_mount_unmount_with_operation">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="unmount_with_operation_finish" symbol="g_mount_unmount_with_operation_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="unshadow" symbol="g_mount_unshadow">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</signal>
			<signal name="pre-unmount" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</signal>
			<signal name="unmounted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</signal>
			<vfunc name="can_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_unmount">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</vfunc>
			<vfunc name="eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_with_operation">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_with_operation_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="get_default_location">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_drive">
				<return-type type="GDrive*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_root">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_uuid">
				<return-type type="char*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_volume">
				<return-type type="GVolume*"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
				</parameters>
			</vfunc>
			<vfunc name="guess_content_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="force_rescan" type="gboolean"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="guess_content_type_finish">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="guess_content_type_sync">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="force_rescan" type="gboolean"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="remount">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="flags" type="GMountMountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="remount_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="unmount">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="unmount_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="unmount_with_operation">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="unmount_with_operation_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount" type="GMount*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GSeekable" type-name="GSeekable" get-type="g_seekable_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="can_seek" symbol="g_seekable_can_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
				</parameters>
			</method>
			<method name="can_truncate" symbol="g_seekable_can_truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
				</parameters>
			</method>
			<method name="seek" symbol="g_seekable_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="type" type="GSeekType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="tell" symbol="g_seekable_tell">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
				</parameters>
			</method>
			<method name="truncate" symbol="g_seekable_truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="can_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
				</parameters>
			</vfunc>
			<vfunc name="seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="type" type="GSeekType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="tell">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
				</parameters>
			</vfunc>
			<vfunc name="truncate_fn">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GSocketConnectable" type-name="GSocketConnectable" get-type="g_socket_connectable_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="enumerate" symbol="g_socket_connectable_enumerate">
				<return-type type="GSocketAddressEnumerator*"/>
				<parameters>
					<parameter name="connectable" type="GSocketConnectable*"/>
				</parameters>
			</method>
			<vfunc name="enumerate">
				<return-type type="GSocketAddressEnumerator*"/>
				<parameters>
					<parameter name="connectable" type="GSocketConnectable*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GVolume" type-name="GVolume" get-type="g_volume_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="can_eject" symbol="g_volume_can_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="can_mount" symbol="g_volume_can_mount">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="eject" symbol="g_volume_eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="eject_finish" symbol="g_volume_eject_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="eject_with_operation" symbol="g_volume_eject_with_operation">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="eject_with_operation_finish" symbol="g_volume_eject_with_operation_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="enumerate_identifiers" symbol="g_volume_enumerate_identifiers">
				<return-type type="char**"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="get_activation_root" symbol="g_volume_get_activation_root">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="get_drive" symbol="g_volume_get_drive">
				<return-type type="GDrive*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="g_volume_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="get_identifier" symbol="g_volume_get_identifier">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="kind" type="char*"/>
				</parameters>
			</method>
			<method name="get_mount" symbol="g_volume_get_mount">
				<return-type type="GMount*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="g_volume_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="get_uuid" symbol="g_volume_get_uuid">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="mount" symbol="g_volume_mount">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="flags" type="GMountMountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="mount_finish" symbol="g_volume_mount_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="should_automount" symbol="g_volume_should_automount">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</signal>
			<signal name="removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</signal>
			<vfunc name="can_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_mount">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_with_operation">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="flags" type="GMountUnmountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_with_operation_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="enumerate_identifiers">
				<return-type type="char**"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_activation_root">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_drive">
				<return-type type="GDrive*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_identifier">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="kind" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_mount">
				<return-type type="GMount*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_uuid">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="mount_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="mount_fn">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="flags" type="GMountMountFlags"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="should_automount">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="G_FILE_ATTRIBUTE_ACCESS_CAN_DELETE" type="char*" value="access::can-delete"/>
		<constant name="G_FILE_ATTRIBUTE_ACCESS_CAN_EXECUTE" type="char*" value="access::can-execute"/>
		<constant name="G_FILE_ATTRIBUTE_ACCESS_CAN_READ" type="char*" value="access::can-read"/>
		<constant name="G_FILE_ATTRIBUTE_ACCESS_CAN_RENAME" type="char*" value="access::can-rename"/>
		<constant name="G_FILE_ATTRIBUTE_ACCESS_CAN_TRASH" type="char*" value="access::can-trash"/>
		<constant name="G_FILE_ATTRIBUTE_ACCESS_CAN_WRITE" type="char*" value="access::can-write"/>
		<constant name="G_FILE_ATTRIBUTE_DOS_IS_ARCHIVE" type="char*" value="dos::is-archive"/>
		<constant name="G_FILE_ATTRIBUTE_DOS_IS_SYSTEM" type="char*" value="dos::is-system"/>
		<constant name="G_FILE_ATTRIBUTE_ETAG_VALUE" type="char*" value="etag::value"/>
		<constant name="G_FILE_ATTRIBUTE_FILESYSTEM_FREE" type="char*" value="filesystem::free"/>
		<constant name="G_FILE_ATTRIBUTE_FILESYSTEM_READONLY" type="char*" value="filesystem::readonly"/>
		<constant name="G_FILE_ATTRIBUTE_FILESYSTEM_SIZE" type="char*" value="filesystem::size"/>
		<constant name="G_FILE_ATTRIBUTE_FILESYSTEM_TYPE" type="char*" value="filesystem::type"/>
		<constant name="G_FILE_ATTRIBUTE_FILESYSTEM_USE_PREVIEW" type="char*" value="filesystem::use-preview"/>
		<constant name="G_FILE_ATTRIBUTE_GVFS_BACKEND" type="char*" value="gvfs::backend"/>
		<constant name="G_FILE_ATTRIBUTE_ID_FILE" type="char*" value="id::file"/>
		<constant name="G_FILE_ATTRIBUTE_ID_FILESYSTEM" type="char*" value="id::filesystem"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_CAN_EJECT" type="char*" value="mountable::can-eject"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_CAN_MOUNT" type="char*" value="mountable::can-mount"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_CAN_POLL" type="char*" value="mountable::can-poll"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_CAN_START" type="char*" value="mountable::can-start"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_CAN_START_DEGRADED" type="char*" value="mountable::can-start-degraded"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_CAN_STOP" type="char*" value="mountable::can-stop"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_CAN_UNMOUNT" type="char*" value="mountable::can-unmount"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_HAL_UDI" type="char*" value="mountable::hal-udi"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_IS_MEDIA_CHECK_AUTOMATIC" type="char*" value="mountable::is-media-check-automatic"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_START_STOP_TYPE" type="char*" value="mountable::start-stop-type"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE" type="char*" value="mountable::unix-device"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE_FILE" type="char*" value="mountable::unix-device-file"/>
		<constant name="G_FILE_ATTRIBUTE_OWNER_GROUP" type="char*" value="owner::group"/>
		<constant name="G_FILE_ATTRIBUTE_OWNER_USER" type="char*" value="owner::user"/>
		<constant name="G_FILE_ATTRIBUTE_OWNER_USER_REAL" type="char*" value="owner::user-real"/>
		<constant name="G_FILE_ATTRIBUTE_PREVIEW_ICON" type="char*" value="preview::icon"/>
		<constant name="G_FILE_ATTRIBUTE_SELINUX_CONTEXT" type="char*" value="selinux::context"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_ALLOCATED_SIZE" type="char*" value="standard::allocated-size"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_CONTENT_TYPE" type="char*" value="standard::content-type"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_COPY_NAME" type="char*" value="standard::copy-name"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_DESCRIPTION" type="char*" value="standard::description"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME" type="char*" value="standard::display-name"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_EDIT_NAME" type="char*" value="standard::edit-name"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_FAST_CONTENT_TYPE" type="char*" value="standard::fast-content-type"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_ICON" type="char*" value="standard::icon"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_IS_BACKUP" type="char*" value="standard::is-backup"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_IS_HIDDEN" type="char*" value="standard::is-hidden"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_IS_SYMLINK" type="char*" value="standard::is-symlink"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_IS_VIRTUAL" type="char*" value="standard::is-virtual"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_NAME" type="char*" value="standard::name"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_SIZE" type="char*" value="standard::size"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_SORT_ORDER" type="char*" value="standard::sort-order"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_SYMLINK_TARGET" type="char*" value="standard::symlink-target"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_TARGET_URI" type="char*" value="standard::target-uri"/>
		<constant name="G_FILE_ATTRIBUTE_STANDARD_TYPE" type="char*" value="standard::type"/>
		<constant name="G_FILE_ATTRIBUTE_THUMBNAILING_FAILED" type="char*" value="thumbnail::failed"/>
		<constant name="G_FILE_ATTRIBUTE_THUMBNAIL_PATH" type="char*" value="thumbnail::path"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_ACCESS" type="char*" value="time::access"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_ACCESS_USEC" type="char*" value="time::access-usec"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_CHANGED" type="char*" value="time::changed"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_CHANGED_USEC" type="char*" value="time::changed-usec"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_CREATED" type="char*" value="time::created"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_CREATED_USEC" type="char*" value="time::created-usec"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_MODIFIED" type="char*" value="time::modified"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_MODIFIED_USEC" type="char*" value="time::modified-usec"/>
		<constant name="G_FILE_ATTRIBUTE_TRASH_DELETION_DATE" type="char*" value="trash::deletion-date"/>
		<constant name="G_FILE_ATTRIBUTE_TRASH_ITEM_COUNT" type="char*" value="trash::item-count"/>
		<constant name="G_FILE_ATTRIBUTE_TRASH_ORIG_PATH" type="char*" value="trash::orig-path"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_BLOCKS" type="char*" value="unix::blocks"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_BLOCK_SIZE" type="char*" value="unix::block-size"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_DEVICE" type="char*" value="unix::device"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_GID" type="char*" value="unix::gid"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_INODE" type="char*" value="unix::inode"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_IS_MOUNTPOINT" type="char*" value="unix::is-mountpoint"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_MODE" type="char*" value="unix::mode"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_NLINK" type="char*" value="unix::nlink"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_RDEV" type="char*" value="unix::rdev"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_UID" type="char*" value="unix::uid"/>
		<constant name="G_NATIVE_VOLUME_MONITOR_EXTENSION_POINT_NAME" type="char*" value="gio-native-volume-monitor"/>
		<constant name="G_VFS_EXTENSION_POINT_NAME" type="char*" value="gio-vfs"/>
		<constant name="G_VOLUME_IDENTIFIER_KIND_HAL_UDI" type="char*" value="hal-udi"/>
		<constant name="G_VOLUME_IDENTIFIER_KIND_LABEL" type="char*" value="label"/>
		<constant name="G_VOLUME_IDENTIFIER_KIND_NFS_MOUNT" type="char*" value="nfs-mount"/>
		<constant name="G_VOLUME_IDENTIFIER_KIND_UNIX_DEVICE" type="char*" value="unix-device"/>
		<constant name="G_VOLUME_IDENTIFIER_KIND_UUID" type="char*" value="uuid"/>
		<constant name="G_VOLUME_MONITOR_EXTENSION_POINT_NAME" type="char*" value="gio-volume-monitor"/>
	</namespace>
</api>
