<?xml version="1.0"?>
<api version="1.0">
	<namespace name="GLib">
		<function name="g_unix_is_mount_path_system_internal" symbol="g_unix_is_mount_path_system_internal">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="mount_path" type="char*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_at" symbol="g_unix_mount_at">
			<return-type type="GUnixMountEntry*"/>
			<parameters>
				<parameter name="mount_path" type="char*"/>
				<parameter name="time_read" type="guint64*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_compare" symbol="g_unix_mount_compare">
			<return-type type="gint"/>
			<parameters>
				<parameter name="mount1" type="GUnixMountEntry*"/>
				<parameter name="mount2" type="GUnixMountEntry*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_free" symbol="g_unix_mount_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="mount_entry" type="GUnixMountEntry*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_get_device_path" symbol="g_unix_mount_get_device_path">
			<return-type type="char*"/>
			<parameters>
				<parameter name="mount_entry" type="GUnixMountEntry*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_get_fs_type" symbol="g_unix_mount_get_fs_type">
			<return-type type="char*"/>
			<parameters>
				<parameter name="mount_entry" type="GUnixMountEntry*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_get_mount_path" symbol="g_unix_mount_get_mount_path">
			<return-type type="char*"/>
			<parameters>
				<parameter name="mount_entry" type="GUnixMountEntry*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_guess_can_eject" symbol="g_unix_mount_guess_can_eject">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="mount_entry" type="GUnixMountEntry*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_guess_icon" symbol="g_unix_mount_guess_icon">
			<return-type type="GIcon*"/>
			<parameters>
				<parameter name="mount_entry" type="GUnixMountEntry*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_guess_name" symbol="g_unix_mount_guess_name">
			<return-type type="char*"/>
			<parameters>
				<parameter name="mount_entry" type="GUnixMountEntry*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_guess_should_display" symbol="g_unix_mount_guess_should_display">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="mount_entry" type="GUnixMountEntry*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_is_readonly" symbol="g_unix_mount_is_readonly">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="mount_entry" type="GUnixMountEntry*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_is_system_internal" symbol="g_unix_mount_is_system_internal">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="mount_entry" type="GUnixMountEntry*"/>
			</parameters>
		</function>
		<function name="g_unix_mount_points_changed_since" symbol="g_unix_mount_points_changed_since">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="time" type="guint64"/>
			</parameters>
		</function>
		<function name="g_unix_mount_points_get" symbol="g_unix_mount_points_get">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="time_read" type="guint64*"/>
			</parameters>
		</function>
		<function name="g_unix_mounts_changed_since" symbol="g_unix_mounts_changed_since">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="time" type="guint64"/>
			</parameters>
		</function>
		<function name="g_unix_mounts_get" symbol="g_unix_mounts_get">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="time_read" type="guint64*"/>
			</parameters>
		</function>
		<callback name="GDesktopAppLaunchCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="appinfo" type="GDesktopAppInfo*"/>
				<parameter name="pid" type="GPid"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GUnixMountEntry">
		</struct>
		<struct name="GUnixMountMonitorClass">
		</struct>
		<struct name="GUnixMountPoint">
			<method name="compare" symbol="g_unix_mount_point_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="mount1" type="GUnixMountPoint*"/>
					<parameter name="mount2" type="GUnixMountPoint*"/>
				</parameters>
			</method>
			<method name="free" symbol="g_unix_mount_point_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount_point" type="GUnixMountPoint*"/>
				</parameters>
			</method>
			<method name="get_device_path" symbol="g_unix_mount_point_get_device_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="mount_point" type="GUnixMountPoint*"/>
				</parameters>
			</method>
			<method name="get_fs_type" symbol="g_unix_mount_point_get_fs_type">
				<return-type type="char*"/>
				<parameters>
					<parameter name="mount_point" type="GUnixMountPoint*"/>
				</parameters>
			</method>
			<method name="get_mount_path" symbol="g_unix_mount_point_get_mount_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="mount_point" type="GUnixMountPoint*"/>
				</parameters>
			</method>
			<method name="guess_can_eject" symbol="g_unix_mount_point_guess_can_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount_point" type="GUnixMountPoint*"/>
				</parameters>
			</method>
			<method name="guess_icon" symbol="g_unix_mount_point_guess_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="mount_point" type="GUnixMountPoint*"/>
				</parameters>
			</method>
			<method name="guess_name" symbol="g_unix_mount_point_guess_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="mount_point" type="GUnixMountPoint*"/>
				</parameters>
			</method>
			<method name="is_loopback" symbol="g_unix_mount_point_is_loopback">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount_point" type="GUnixMountPoint*"/>
				</parameters>
			</method>
			<method name="is_readonly" symbol="g_unix_mount_point_is_readonly">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount_point" type="GUnixMountPoint*"/>
				</parameters>
			</method>
			<method name="is_user_mountable" symbol="g_unix_mount_point_is_user_mountable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mount_point" type="GUnixMountPoint*"/>
				</parameters>
			</method>
		</struct>
		<object name="GDesktopAppInfo" parent="GObject" type-name="GDesktopAppInfo" get-type="g_desktop_app_info_get_type">
			<implements>
				<interface name="GAppInfo"/>
			</implements>
			<method name="get_categories" symbol="g_desktop_app_info_get_categories">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GDesktopAppInfo*"/>
				</parameters>
			</method>
			<method name="get_filename" symbol="g_desktop_app_info_get_filename">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GDesktopAppInfo*"/>
				</parameters>
			</method>
			<method name="get_generic_name" symbol="g_desktop_app_info_get_generic_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GDesktopAppInfo*"/>
				</parameters>
			</method>
			<method name="get_is_hidden" symbol="g_desktop_app_info_get_is_hidden">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GDesktopAppInfo*"/>
				</parameters>
			</method>
			<method name="get_nodisplay" symbol="g_desktop_app_info_get_nodisplay">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GDesktopAppInfo*"/>
				</parameters>
			</method>
			<method name="get_show_in" symbol="g_desktop_app_info_get_show_in">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GDesktopAppInfo*"/>
					<parameter name="desktop_env" type="gchar*"/>
				</parameters>
			</method>
			<method name="launch_uris_as_manager" symbol="g_desktop_app_info_launch_uris_as_manager">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GDesktopAppInfo*"/>
					<parameter name="uris" type="GList*"/>
					<parameter name="launch_context" type="GAppLaunchContext*"/>
					<parameter name="spawn_flags" type="GSpawnFlags"/>
					<parameter name="user_setup" type="GSpawnChildSetupFunc"/>
					<parameter name="user_setup_data" type="gpointer"/>
					<parameter name="pid_callback" type="GDesktopAppLaunchCallback"/>
					<parameter name="pid_callback_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_desktop_app_info_new">
				<return-type type="GDesktopAppInfo*"/>
				<parameters>
					<parameter name="desktop_id" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_filename" symbol="g_desktop_app_info_new_from_filename">
				<return-type type="GDesktopAppInfo*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_keyfile" symbol="g_desktop_app_info_new_from_keyfile">
				<return-type type="GDesktopAppInfo*"/>
				<parameters>
					<parameter name="key_file" type="GKeyFile*"/>
				</parameters>
			</constructor>
			<method name="set_desktop_env" symbol="g_desktop_app_info_set_desktop_env">
				<return-type type="void"/>
				<parameters>
					<parameter name="desktop_env" type="char*"/>
				</parameters>
			</method>
			<property name="filename" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GUnixConnection" parent="GSocketConnection" type-name="GUnixConnection" get-type="g_unix_connection_get_type">
			<method name="receive_credentials" symbol="g_unix_connection_receive_credentials">
				<return-type type="GCredentials*"/>
				<parameters>
					<parameter name="connection" type="GUnixConnection*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="receive_fd" symbol="g_unix_connection_receive_fd">
				<return-type type="gint"/>
				<parameters>
					<parameter name="connection" type="GUnixConnection*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="send_credentials" symbol="g_unix_connection_send_credentials">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="GUnixConnection*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="send_fd" symbol="g_unix_connection_send_fd">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="connection" type="GUnixConnection*"/>
					<parameter name="fd" type="gint"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</object>
		<object name="GUnixCredentialsMessage" parent="GSocketControlMessage" type-name="GUnixCredentialsMessage" get-type="g_unix_credentials_message_get_type">
			<method name="get_credentials" symbol="g_unix_credentials_message_get_credentials">
				<return-type type="GCredentials*"/>
				<parameters>
					<parameter name="message" type="GUnixCredentialsMessage*"/>
				</parameters>
			</method>
			<method name="is_supported" symbol="g_unix_credentials_message_is_supported">
				<return-type type="gboolean"/>
			</method>
			<constructor name="new" symbol="g_unix_credentials_message_new">
				<return-type type="GSocketControlMessage*"/>
			</constructor>
			<constructor name="new_with_credentials" symbol="g_unix_credentials_message_new_with_credentials">
				<return-type type="GSocketControlMessage*"/>
				<parameters>
					<parameter name="credentials" type="GCredentials*"/>
				</parameters>
			</constructor>
			<property name="credentials" type="GCredentials*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GUnixFDList" parent="GObject" type-name="GUnixFDList" get-type="g_unix_fd_list_get_type">
			<method name="append" symbol="g_unix_fd_list_append">
				<return-type type="gint"/>
				<parameters>
					<parameter name="list" type="GUnixFDList*"/>
					<parameter name="fd" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get" symbol="g_unix_fd_list_get">
				<return-type type="gint"/>
				<parameters>
					<parameter name="list" type="GUnixFDList*"/>
					<parameter name="index_" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_length" symbol="g_unix_fd_list_get_length">
				<return-type type="gint"/>
				<parameters>
					<parameter name="list" type="GUnixFDList*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_unix_fd_list_new">
				<return-type type="GUnixFDList*"/>
			</constructor>
			<constructor name="new_from_array" symbol="g_unix_fd_list_new_from_array">
				<return-type type="GUnixFDList*"/>
				<parameters>
					<parameter name="fds" type="gint*"/>
					<parameter name="n_fds" type="gint"/>
				</parameters>
			</constructor>
			<method name="peek_fds" symbol="g_unix_fd_list_peek_fds">
				<return-type type="gint*"/>
				<parameters>
					<parameter name="list" type="GUnixFDList*"/>
					<parameter name="length" type="gint*"/>
				</parameters>
			</method>
			<method name="steal_fds" symbol="g_unix_fd_list_steal_fds">
				<return-type type="gint*"/>
				<parameters>
					<parameter name="list" type="GUnixFDList*"/>
					<parameter name="length" type="gint*"/>
				</parameters>
			</method>
		</object>
		<object name="GUnixFDMessage" parent="GSocketControlMessage" type-name="GUnixFDMessage" get-type="g_unix_fd_message_get_type">
			<method name="append_fd" symbol="g_unix_fd_message_append_fd">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="message" type="GUnixFDMessage*"/>
					<parameter name="fd" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_fd_list" symbol="g_unix_fd_message_get_fd_list">
				<return-type type="GUnixFDList*"/>
				<parameters>
					<parameter name="message" type="GUnixFDMessage*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_unix_fd_message_new">
				<return-type type="GSocketControlMessage*"/>
			</constructor>
			<constructor name="new_with_fd_list" symbol="g_unix_fd_message_new_with_fd_list">
				<return-type type="GSocketControlMessage*"/>
				<parameters>
					<parameter name="fd_list" type="GUnixFDList*"/>
				</parameters>
			</constructor>
			<method name="steal_fds" symbol="g_unix_fd_message_steal_fds">
				<return-type type="gint*"/>
				<parameters>
					<parameter name="message" type="GUnixFDMessage*"/>
					<parameter name="length" type="gint*"/>
				</parameters>
			</method>
			<property name="fd-list" type="GUnixFDList*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GUnixInputStream" parent="GInputStream" type-name="GUnixInputStream" get-type="g_unix_input_stream_get_type">
			<implements>
				<interface name="GPollableInputStream"/>
			</implements>
			<method name="get_close_fd" symbol="g_unix_input_stream_get_close_fd">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GUnixInputStream*"/>
				</parameters>
			</method>
			<method name="get_fd" symbol="g_unix_input_stream_get_fd">
				<return-type type="gint"/>
				<parameters>
					<parameter name="stream" type="GUnixInputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_unix_input_stream_new">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="fd" type="gint"/>
					<parameter name="close_fd" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_close_fd" symbol="g_unix_input_stream_set_close_fd">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GUnixInputStream*"/>
					<parameter name="close_fd" type="gboolean"/>
				</parameters>
			</method>
			<property name="close-fd" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fd" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GUnixMountMonitor" parent="GObject" type-name="GUnixMountMonitor" get-type="g_unix_mount_monitor_get_type">
			<constructor name="new" symbol="g_unix_mount_monitor_new">
				<return-type type="GUnixMountMonitor*"/>
			</constructor>
			<method name="set_rate_limit" symbol="g_unix_mount_monitor_set_rate_limit">
				<return-type type="void"/>
				<parameters>
					<parameter name="mount_monitor" type="GUnixMountMonitor*"/>
					<parameter name="limit_msec" type="int"/>
				</parameters>
			</method>
			<signal name="mountpoints-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GUnixMountMonitor*"/>
				</parameters>
			</signal>
			<signal name="mounts-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GUnixMountMonitor*"/>
				</parameters>
			</signal>
		</object>
		<object name="GUnixOutputStream" parent="GOutputStream" type-name="GUnixOutputStream" get-type="g_unix_output_stream_get_type">
			<implements>
				<interface name="GPollableOutputStream"/>
			</implements>
			<method name="get_close_fd" symbol="g_unix_output_stream_get_close_fd">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GUnixOutputStream*"/>
				</parameters>
			</method>
			<method name="get_fd" symbol="g_unix_output_stream_get_fd">
				<return-type type="gint"/>
				<parameters>
					<parameter name="stream" type="GUnixOutputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_unix_output_stream_new">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="fd" type="gint"/>
					<parameter name="close_fd" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_close_fd" symbol="g_unix_output_stream_set_close_fd">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GUnixOutputStream*"/>
					<parameter name="close_fd" type="gboolean"/>
				</parameters>
			</method>
			<property name="close-fd" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fd" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GUnixSocketAddress" parent="GSocketAddress" type-name="GUnixSocketAddress" get-type="g_unix_socket_address_get_type">
			<implements>
				<interface name="GSocketConnectable"/>
			</implements>
			<method name="abstract_names_supported" symbol="g_unix_socket_address_abstract_names_supported">
				<return-type type="gboolean"/>
			</method>
			<method name="get_address_type" symbol="g_unix_socket_address_get_address_type">
				<return-type type="GUnixSocketAddressType"/>
				<parameters>
					<parameter name="address" type="GUnixSocketAddress*"/>
				</parameters>
			</method>
			<method name="get_is_abstract" symbol="g_unix_socket_address_get_is_abstract">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="address" type="GUnixSocketAddress*"/>
				</parameters>
			</method>
			<method name="get_path" symbol="g_unix_socket_address_get_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="address" type="GUnixSocketAddress*"/>
				</parameters>
			</method>
			<method name="get_path_len" symbol="g_unix_socket_address_get_path_len">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="address" type="GUnixSocketAddress*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_unix_socket_address_new">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_abstract" symbol="g_unix_socket_address_new_abstract">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="path" type="gchar*"/>
					<parameter name="path_len" type="gint"/>
				</parameters>
			</constructor>
			<constructor name="new_with_type" symbol="g_unix_socket_address_new_with_type">
				<return-type type="GSocketAddress*"/>
				<parameters>
					<parameter name="path" type="gchar*"/>
					<parameter name="path_len" type="gint"/>
					<parameter name="type" type="GUnixSocketAddressType"/>
				</parameters>
			</constructor>
			<property name="abstract" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="address-type" type="GUnixSocketAddressType" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="path" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="path-as-array" type="GByteArray*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<interface name="GDesktopAppInfoLookup" type-name="GDesktopAppInfoLookup" get-type="g_desktop_app_info_lookup_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="get_default_for_uri_scheme" symbol="g_desktop_app_info_lookup_get_default_for_uri_scheme">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="lookup" type="GDesktopAppInfoLookup*"/>
					<parameter name="uri_scheme" type="char*"/>
				</parameters>
			</method>
			<vfunc name="get_default_for_uri_scheme">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="lookup" type="GDesktopAppInfoLookup*"/>
					<parameter name="uri_scheme" type="char*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GFileDescriptorBased" type-name="GFileDescriptorBased" get-type="g_file_descriptor_based_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="get_fd" symbol="g_file_descriptor_based_get_fd">
				<return-type type="int"/>
				<parameters>
					<parameter name="fd_based" type="GFileDescriptorBased*"/>
				</parameters>
			</method>
			<vfunc name="get_fd">
				<return-type type="int"/>
				<parameters>
					<parameter name="fd_based" type="GFileDescriptorBased*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="G_DESKTOP_APP_INFO_LOOKUP_EXTENSION_POINT_NAME" type="char*" value="gio-desktop-app-info-lookup"/>
	</namespace>
</api>
