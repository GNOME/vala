<?xml version="1.0"?>
<api version="1.0">
	<namespace name="GUdev">
		<struct name="GUdevDeviceNumber">
		</struct>
		<enum name="GUdevDeviceType" type-name="GUdevDeviceType" get-type="g_udev_device_type_get_type">
			<member name="G_UDEV_DEVICE_TYPE_NONE" value="0"/>
			<member name="G_UDEV_DEVICE_TYPE_BLOCK" value="98"/>
			<member name="G_UDEV_DEVICE_TYPE_CHAR" value="99"/>
		</enum>
		<object name="GUdevClient" parent="GObject" type-name="GUdevClient" get-type="g_udev_client_get_type">
			<constructor name="new" symbol="g_udev_client_new">
				<return-type type="GUdevClient*"/>
				<parameters>
					<parameter name="subsystems" type="gchar**"/>
				</parameters>
			</constructor>
			<method name="query_by_device_file" symbol="g_udev_client_query_by_device_file">
				<return-type type="GUdevDevice*"/>
				<parameters>
					<parameter name="client" type="GUdevClient*"/>
					<parameter name="device_file" type="gchar*"/>
				</parameters>
			</method>
			<method name="query_by_device_number" symbol="g_udev_client_query_by_device_number">
				<return-type type="GUdevDevice*"/>
				<parameters>
					<parameter name="client" type="GUdevClient*"/>
					<parameter name="type" type="GUdevDeviceType"/>
					<parameter name="number" type="GUdevDeviceNumber"/>
				</parameters>
			</method>
			<method name="query_by_subsystem" symbol="g_udev_client_query_by_subsystem">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="client" type="GUdevClient*"/>
					<parameter name="subsystem" type="gchar*"/>
				</parameters>
			</method>
			<method name="query_by_subsystem_and_name" symbol="g_udev_client_query_by_subsystem_and_name">
				<return-type type="GUdevDevice*"/>
				<parameters>
					<parameter name="client" type="GUdevClient*"/>
					<parameter name="subsystem" type="gchar*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="query_by_sysfs_path" symbol="g_udev_client_query_by_sysfs_path">
				<return-type type="GUdevDevice*"/>
				<parameters>
					<parameter name="client" type="GUdevClient*"/>
					<parameter name="sysfs_path" type="gchar*"/>
				</parameters>
			</method>
			<property name="subsystems" type="GStrv*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="uevent" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GUdevClient*"/>
					<parameter name="action" type="char*"/>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</signal>
			<vfunc name="reserved1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved4">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved5">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved6">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved7">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved8">
				<return-type type="void"/>
			</vfunc>
		</object>
		<object name="GUdevDevice" parent="GObject" type-name="GUdevDevice" get-type="g_udev_device_get_type">
			<method name="get_action" symbol="g_udev_device_get_action">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_device_file" symbol="g_udev_device_get_device_file">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_device_file_symlinks" symbol="g_udev_device_get_device_file_symlinks">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_device_number" symbol="g_udev_device_get_device_number">
				<return-type type="GUdevDeviceNumber"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_device_type" symbol="g_udev_device_get_device_type">
				<return-type type="GUdevDeviceType"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_devtype" symbol="g_udev_device_get_devtype">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_driver" symbol="g_udev_device_get_driver">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="g_udev_device_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_number" symbol="g_udev_device_get_number">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="g_udev_device_get_parent">
				<return-type type="GUdevDevice*"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_parent_with_subsystem" symbol="g_udev_device_get_parent_with_subsystem">
				<return-type type="GUdevDevice*"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="subsystem" type="gchar*"/>
					<parameter name="devtype" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_property" symbol="g_udev_device_get_property">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_property_as_boolean" symbol="g_udev_device_get_property_as_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_property_as_double" symbol="g_udev_device_get_property_as_double">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_property_as_int" symbol="g_udev_device_get_property_as_int">
				<return-type type="gint"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_property_as_strv" symbol="g_udev_device_get_property_as_strv">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_property_as_uint64" symbol="g_udev_device_get_property_as_uint64">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_property_keys" symbol="g_udev_device_get_property_keys">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_seqnum" symbol="g_udev_device_get_seqnum">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_subsystem" symbol="g_udev_device_get_subsystem">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="get_sysfs_attr" symbol="g_udev_device_get_sysfs_attr">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_sysfs_attr_as_boolean" symbol="g_udev_device_get_sysfs_attr_as_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_sysfs_attr_as_double" symbol="g_udev_device_get_sysfs_attr_as_double">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_sysfs_attr_as_int" symbol="g_udev_device_get_sysfs_attr_as_int">
				<return-type type="gint"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_sysfs_attr_as_strv" symbol="g_udev_device_get_sysfs_attr_as_strv">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_sysfs_attr_as_uint64" symbol="g_udev_device_get_sysfs_attr_as_uint64">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_sysfs_path" symbol="g_udev_device_get_sysfs_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
				</parameters>
			</method>
			<method name="has_property" symbol="g_udev_device_has_property">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GUdevDevice*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<vfunc name="reserved1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved4">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved5">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved6">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved7">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved8">
				<return-type type="void"/>
			</vfunc>
		</object>
	</namespace>
</api>
