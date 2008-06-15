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
			<method name="get_is_hidden" symbol="g_desktop_app_info_get_is_hidden">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GDesktopAppInfo*"/>
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
			<method name="set_desktop_env" symbol="g_desktop_app_info_set_desktop_env">
				<return-type type="void"/>
				<parameters>
					<parameter name="desktop_env" type="char*"/>
				</parameters>
			</method>
		</object>
		<object name="GUnixInputStream" parent="GInputStream" type-name="GUnixInputStream" get-type="g_unix_input_stream_get_type">
			<constructor name="new" symbol="g_unix_input_stream_new">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="fd" type="int"/>
					<parameter name="close_fd_at_close" type="gboolean"/>
				</parameters>
			</constructor>
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
			<constructor name="new" symbol="g_unix_output_stream_new">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="fd" type="int"/>
					<parameter name="close_fd_at_close" type="gboolean"/>
				</parameters>
			</constructor>
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
		<constant name="G_DESKTOP_APP_INFO_LOOKUP_EXTENSION_POINT_NAME" type="char*" value="gio-desktop-app-info-lookup"/>
	</namespace>
</api>
