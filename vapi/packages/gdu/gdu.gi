<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gdu">
		<function name="error_quark" symbol="gdu_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="get_job_description" symbol="gdu_get_job_description">
			<return-type type="char*"/>
			<parameters>
				<parameter name="job_id" type="char*"/>
			</parameters>
		</function>
		<function name="linux_md_get_raid_level_description" symbol="gdu_linux_md_get_raid_level_description">
			<return-type type="char*"/>
			<parameters>
				<parameter name="linux_md_raid_level" type="gchar*"/>
			</parameters>
		</function>
		<function name="linux_md_get_raid_level_for_display" symbol="gdu_linux_md_get_raid_level_for_display">
			<return-type type="char*"/>
			<parameters>
				<parameter name="linux_md_raid_level" type="gchar*"/>
				<parameter name="long_string" type="gboolean"/>
			</parameters>
		</function>
		<function name="util_ata_smart_status_to_desc" symbol="gdu_util_ata_smart_status_to_desc">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="status" type="gchar*"/>
				<parameter name="out_highlight" type="gboolean*"/>
				<parameter name="out_action_text" type="gchar**"/>
				<parameter name="out_icon" type="GIcon**"/>
			</parameters>
		</function>
		<function name="util_delete_secret" symbol="gdu_util_delete_secret">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
			</parameters>
		</function>
		<function name="util_fstype_get_description" symbol="gdu_util_fstype_get_description">
			<return-type type="char*"/>
			<parameters>
				<parameter name="fstype" type="char*"/>
			</parameters>
		</function>
		<function name="util_get_connection_for_display" symbol="gdu_util_get_connection_for_display">
			<return-type type="char*"/>
			<parameters>
				<parameter name="connection_interface" type="char*"/>
				<parameter name="connection_speed" type="guint64"/>
			</parameters>
		</function>
		<function name="util_get_default_part_type_for_scheme_and_fstype" symbol="gdu_util_get_default_part_type_for_scheme_and_fstype">
			<return-type type="char*"/>
			<parameters>
				<parameter name="scheme" type="char*"/>
				<parameter name="fstype" type="char*"/>
				<parameter name="size" type="guint64"/>
			</parameters>
		</function>
		<function name="util_get_desc_for_part_type" symbol="gdu_util_get_desc_for_part_type">
			<return-type type="char*"/>
			<parameters>
				<parameter name="part_scheme" type="char*"/>
				<parameter name="part_type" type="char*"/>
			</parameters>
		</function>
		<function name="util_get_emblemed_icon" symbol="gdu_util_get_emblemed_icon">
			<return-type type="GIcon*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
				<parameter name="emblem_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="util_get_fstype_for_display" symbol="gdu_util_get_fstype_for_display">
			<return-type type="char*"/>
			<parameters>
				<parameter name="fstype" type="char*"/>
				<parameter name="fsversion" type="char*"/>
				<parameter name="long_string" type="gboolean"/>
			</parameters>
		</function>
		<function name="util_get_secret" symbol="gdu_util_get_secret">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
			</parameters>
		</function>
		<function name="util_get_size_for_display" symbol="gdu_util_get_size_for_display">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="size" type="guint64"/>
				<parameter name="use_pow2" type="gboolean"/>
				<parameter name="long_string" type="gboolean"/>
			</parameters>
		</function>
		<function name="util_get_speed_for_display" symbol="gdu_util_get_speed_for_display">
			<return-type type="char*"/>
			<parameters>
				<parameter name="size" type="guint64"/>
			</parameters>
		</function>
		<function name="util_have_secret" symbol="gdu_util_have_secret">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
			</parameters>
		</function>
		<function name="util_part_table_type_get_description" symbol="gdu_util_part_table_type_get_description">
			<return-type type="char*"/>
			<parameters>
				<parameter name="part_type" type="char*"/>
			</parameters>
		</function>
		<function name="util_part_type_foreach" symbol="gdu_util_part_type_foreach">
			<return-type type="void"/>
			<parameters>
				<parameter name="callback" type="GduUtilPartTypeForeachFunc"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="util_save_secret" symbol="gdu_util_save_secret">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="secret" type="char*"/>
				<parameter name="save_in_keyring_session" type="gboolean"/>
			</parameters>
		</function>
		<callback name="GduDeviceCancelJobCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceDriveAtaSmartInitiateSelftestCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceDriveAtaSmartRefreshDataCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceDriveBenchmarkCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="read_transfer_rate_results" type="GPtrArray*"/>
				<parameter name="write_transfer_rate_results" type="GPtrArray*"/>
				<parameter name="access_time_results" type="GPtrArray*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceDriveDetachCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceDriveEjectCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceDrivePollMediaCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceFilesystemCheckCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="is_clean" type="gboolean"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceFilesystemCreateCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceFilesystemListOpenFilesCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="processes" type="GList*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceFilesystemMountCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="mount_point" type="char*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceFilesystemSetLabelCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceFilesystemUnmountCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceLinuxLvm2LVStopCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceLinuxMdAddSpareCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceLinuxMdCheckCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="num_errors" type="guint"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceLinuxMdExpandCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceLinuxMdRemoveComponentCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceLinuxMdStopCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceLuksChangePassphraseCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceLuksLockCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDeviceLuksUnlockCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="object_path_of_cleartext_device" type="char*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDevicePartitionCreateCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="created_device_object_path" type="char*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDevicePartitionDeleteCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDevicePartitionModifyCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDevicePartitionTableCreateCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="device" type="GduDevice*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDriveActivateFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="drive" type="GduDrive*"/>
				<parameter name="assembled_drive_object_path" type="char*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduDriveDeactivateFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="drive" type="GduDrive*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduPoolLinuxLvm2LVCreateCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="create_logical_volume_object_path" type="char*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduPoolLinuxLvm2LVRemoveCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduPoolLinuxLvm2LVSetNameCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduPoolLinuxLvm2LVStartCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduPoolLinuxLvm2VGAddPVCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduPoolLinuxLvm2VGRemovePVCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduPoolLinuxLvm2VGSetNameCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduPoolLinuxLvm2VGStartCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduPoolLinuxLvm2VGStopCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduPoolLinuxMdCreateCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="array_object_path" type="char*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduPoolLinuxMdStartCompletedFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="assembled_array_object_path" type="char*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GduUtilPartTypeForeachFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="scheme" type="char*"/>
				<parameter name="type" type="char*"/>
				<parameter name="name" type="char*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<enum name="GduCreateVolumeFlags">
			<member name="GDU_CREATE_VOLUME_FLAGS_NONE" value="0"/>
			<member name="GDU_CREATE_VOLUME_FLAGS_LINUX_MD" value="1"/>
			<member name="GDU_CREATE_VOLUME_FLAGS_LINUX_LVM2" value="2"/>
		</enum>
		<enum name="GduError">
			<member name="GDU_ERROR_FAILED" value="0"/>
			<member name="GDU_ERROR_BUSY" value="1"/>
			<member name="GDU_ERROR_CANCELLED" value="2"/>
			<member name="GDU_ERROR_INHIBITED" value="3"/>
			<member name="GDU_ERROR_INVALID_OPTION" value="4"/>
			<member name="GDU_ERROR_NOT_SUPPORTED" value="5"/>
			<member name="GDU_ERROR_ATA_SMART_WOULD_WAKEUP" value="6"/>
			<member name="GDU_ERROR_PERMISSION_DENIED" value="7"/>
			<member name="GDU_ERROR_FILESYSTEM_DRIVER_MISSING" value="8"/>
			<member name="GDU_ERROR_FILESYSTEM_TOOLS_MISSING" value="9"/>
		</enum>
		<enum name="GduHubUsage">
			<member name="GDU_HUB_USAGE_ADAPTER" value="0"/>
			<member name="GDU_HUB_USAGE_EXPANDER" value="1"/>
			<member name="GDU_HUB_USAGE_MULTI_DISK_DEVICES" value="2"/>
			<member name="GDU_HUB_USAGE_MULTI_PATH_DEVICES" value="3"/>
		</enum>
		<enum name="GduLinuxLvm2VolumeGroupState">
			<member name="GDU_LINUX_LVM2_VOLUME_GROUP_STATE_NOT_RUNNING" value="0"/>
			<member name="GDU_LINUX_LVM2_VOLUME_GROUP_STATE_PARTIALLY_RUNNING" value="1"/>
			<member name="GDU_LINUX_LVM2_VOLUME_GROUP_STATE_RUNNING" value="2"/>
		</enum>
		<enum name="GduLinuxMdDriveSlaveFlags">
			<member name="GDU_LINUX_MD_DRIVE_SLAVE_FLAGS_NONE" value="0"/>
			<member name="GDU_LINUX_MD_DRIVE_SLAVE_FLAGS_NOT_ATTACHED" value="1"/>
			<member name="GDU_LINUX_MD_DRIVE_SLAVE_FLAGS_FAULTY" value="2"/>
			<member name="GDU_LINUX_MD_DRIVE_SLAVE_FLAGS_IN_SYNC" value="4"/>
			<member name="GDU_LINUX_MD_DRIVE_SLAVE_FLAGS_WRITEMOSTLY" value="8"/>
			<member name="GDU_LINUX_MD_DRIVE_SLAVE_FLAGS_BLOCKED" value="16"/>
			<member name="GDU_LINUX_MD_DRIVE_SLAVE_FLAGS_SPARE" value="32"/>
		</enum>
		<enum name="GduVolumeFlags">
			<member name="GDU_VOLUME_FLAGS_NONE" value="0"/>
			<member name="GDU_VOLUME_FLAGS_PARTITION" value="1"/>
			<member name="GDU_VOLUME_FLAGS_PARTITION_MBR_LOGICAL" value="2"/>
			<member name="GDU_VOLUME_FLAGS_PARTITION_MBR_EXTENDED" value="4"/>
		</enum>
		<object name="GduAdapter" parent="GObject" type-name="GduAdapter" get-type="gdu_adapter_get_type">
			<method name="get_driver" symbol="gdu_adapter_get_driver">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</method>
			<method name="get_fabric" symbol="gdu_adapter_get_fabric">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</method>
			<method name="get_model" symbol="gdu_adapter_get_model">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</method>
			<method name="get_native_path" symbol="gdu_adapter_get_native_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</method>
			<method name="get_num_ports" symbol="gdu_adapter_get_num_ports">
				<return-type type="guint"/>
				<parameters>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</method>
			<method name="get_object_path" symbol="gdu_adapter_get_object_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</method>
			<method name="get_pool" symbol="gdu_adapter_get_pool">
				<return-type type="GduPool*"/>
				<parameters>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</method>
			<method name="get_vendor" symbol="gdu_adapter_get_vendor">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</signal>
			<signal name="removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</signal>
		</object>
		<object name="GduDevice" parent="GObject" type-name="GduDevice" get-type="gdu_device_get_type">
			<method name="drive_ata_smart_get_blob" symbol="gdu_device_drive_ata_smart_get_blob">
				<return-type type="gconstpointer"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="out_size" type="gsize*"/>
				</parameters>
			</method>
			<method name="drive_ata_smart_get_is_available" symbol="gdu_device_drive_ata_smart_get_is_available">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_ata_smart_get_status" symbol="gdu_device_drive_ata_smart_get_status">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_ata_smart_get_time_collected" symbol="gdu_device_drive_ata_smart_get_time_collected">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_ata_smart_refresh_data" symbol="gdu_device_drive_ata_smart_refresh_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="callback" type="GduDeviceDriveAtaSmartRefreshDataCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="drive_get_adapter" symbol="gdu_device_drive_get_adapter">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_can_detach" symbol="gdu_device_drive_get_can_detach">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_can_spindown" symbol="gdu_device_drive_get_can_spindown">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_connection_interface" symbol="gdu_device_drive_get_connection_interface">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_connection_speed" symbol="gdu_device_drive_get_connection_speed">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_is_media_ejectable" symbol="gdu_device_drive_get_is_media_ejectable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_is_rotational" symbol="gdu_device_drive_get_is_rotational">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_media" symbol="gdu_device_drive_get_media">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_media_compatibility" symbol="gdu_device_drive_get_media_compatibility">
				<return-type type="char**"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_model" symbol="gdu_device_drive_get_model">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_ports" symbol="gdu_device_drive_get_ports">
				<return-type type="char**"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_requires_eject" symbol="gdu_device_drive_get_requires_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_revision" symbol="gdu_device_drive_get_revision">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_rotation_rate" symbol="gdu_device_drive_get_rotation_rate">
				<return-type type="guint"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_serial" symbol="gdu_device_drive_get_serial">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_similar_devices" symbol="gdu_device_drive_get_similar_devices">
				<return-type type="char**"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_vendor" symbol="gdu_device_drive_get_vendor">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_write_cache" symbol="gdu_device_drive_get_write_cache">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="drive_get_wwn" symbol="gdu_device_drive_get_wwn">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="filesystem_list_open_files" symbol="gdu_device_filesystem_list_open_files">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="callback" type="GduDeviceFilesystemListOpenFilesCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="filesystem_list_open_files_sync" symbol="gdu_device_filesystem_list_open_files_sync">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="find_parent" symbol="gdu_device_find_parent">
				<return-type type="GduDevice*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_block_size" symbol="gdu_device_get_block_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_detection_time" symbol="gdu_device_get_detection_time">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_dev" symbol="gdu_device_get_dev">
				<return-type type="dev_t"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_device_file" symbol="gdu_device_get_device_file">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_device_file_presentation" symbol="gdu_device_get_device_file_presentation">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_media_detection_time" symbol="gdu_device_get_media_detection_time">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_mount_path" symbol="gdu_device_get_mount_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_mount_paths" symbol="gdu_device_get_mount_paths">
				<return-type type="char**"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_mounted_by_uid" symbol="gdu_device_get_mounted_by_uid">
				<return-type type="uid_t"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_object_path" symbol="gdu_device_get_object_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_pool" symbol="gdu_device_get_pool">
				<return-type type="GduPool*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_presentation_hide" symbol="gdu_device_get_presentation_hide">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_presentation_icon_name" symbol="gdu_device_get_presentation_icon_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_presentation_name" symbol="gdu_device_get_presentation_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_presentation_nopolicy" symbol="gdu_device_get_presentation_nopolicy">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gdu_device_get_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="id_get_label" symbol="gdu_device_id_get_label">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="id_get_type" symbol="gdu_device_id_get_type">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="id_get_usage" symbol="gdu_device_id_get_usage">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="id_get_uuid" symbol="gdu_device_id_get_uuid">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="id_get_version" symbol="gdu_device_id_get_version">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_drive" symbol="gdu_device_is_drive">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_linux_dmmp" symbol="gdu_device_is_linux_dmmp">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_linux_dmmp_component" symbol="gdu_device_is_linux_dmmp_component">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_linux_loop" symbol="gdu_device_is_linux_loop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_linux_lvm2_lv" symbol="gdu_device_is_linux_lvm2_lv">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_linux_lvm2_pv" symbol="gdu_device_is_linux_lvm2_pv">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_linux_md" symbol="gdu_device_is_linux_md">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_linux_md_component" symbol="gdu_device_is_linux_md_component">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_luks" symbol="gdu_device_is_luks">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_luks_cleartext" symbol="gdu_device_is_luks_cleartext">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_media_available" symbol="gdu_device_is_media_available">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_media_change_detected" symbol="gdu_device_is_media_change_detected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_media_change_detection_inhibitable" symbol="gdu_device_is_media_change_detection_inhibitable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_media_change_detection_inhibited" symbol="gdu_device_is_media_change_detection_inhibited">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_media_change_detection_polling" symbol="gdu_device_is_media_change_detection_polling">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_mounted" symbol="gdu_device_is_mounted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_optical_disc" symbol="gdu_device_is_optical_disc">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_partition" symbol="gdu_device_is_partition">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_partition_table" symbol="gdu_device_is_partition_table">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_read_only" symbol="gdu_device_is_read_only">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_removable" symbol="gdu_device_is_removable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="is_system_internal" symbol="gdu_device_is_system_internal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="job_get_id" symbol="gdu_device_job_get_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="job_get_initiated_by_uid" symbol="gdu_device_job_get_initiated_by_uid">
				<return-type type="uid_t"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="job_get_percentage" symbol="gdu_device_job_get_percentage">
				<return-type type="double"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="job_in_progress" symbol="gdu_device_job_in_progress">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="job_is_cancellable" symbol="gdu_device_job_is_cancellable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_dmmp_component_get_holder" symbol="gdu_device_linux_dmmp_component_get_holder">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_dmmp_get_name" symbol="gdu_device_linux_dmmp_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_dmmp_get_parameters" symbol="gdu_device_linux_dmmp_get_parameters">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_dmmp_get_slaves" symbol="gdu_device_linux_dmmp_get_slaves">
				<return-type type="char**"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_loop_get_filename" symbol="gdu_device_linux_loop_get_filename">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_lv_get_group_name" symbol="gdu_device_linux_lvm2_lv_get_group_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_lv_get_group_uuid" symbol="gdu_device_linux_lvm2_lv_get_group_uuid">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_lv_get_name" symbol="gdu_device_linux_lvm2_lv_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_lv_get_uuid" symbol="gdu_device_linux_lvm2_lv_get_uuid">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_pv_get_group_extent_size" symbol="gdu_device_linux_lvm2_pv_get_group_extent_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_pv_get_group_logical_volumes" symbol="gdu_device_linux_lvm2_pv_get_group_logical_volumes">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_pv_get_group_name" symbol="gdu_device_linux_lvm2_pv_get_group_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_pv_get_group_physical_volumes" symbol="gdu_device_linux_lvm2_pv_get_group_physical_volumes">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_pv_get_group_sequence_number" symbol="gdu_device_linux_lvm2_pv_get_group_sequence_number">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_pv_get_group_size" symbol="gdu_device_linux_lvm2_pv_get_group_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_pv_get_group_unallocated_size" symbol="gdu_device_linux_lvm2_pv_get_group_unallocated_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_pv_get_group_uuid" symbol="gdu_device_linux_lvm2_pv_get_group_uuid">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_pv_get_num_metadata_areas" symbol="gdu_device_linux_lvm2_pv_get_num_metadata_areas">
				<return-type type="guint"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_lvm2_pv_get_uuid" symbol="gdu_device_linux_lvm2_pv_get_uuid">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_component_get_holder" symbol="gdu_device_linux_md_component_get_holder">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_component_get_home_host" symbol="gdu_device_linux_md_component_get_home_host">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_component_get_level" symbol="gdu_device_linux_md_component_get_level">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_component_get_name" symbol="gdu_device_linux_md_component_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_component_get_num_raid_devices" symbol="gdu_device_linux_md_component_get_num_raid_devices">
				<return-type type="int"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_component_get_position" symbol="gdu_device_linux_md_component_get_position">
				<return-type type="int"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_component_get_state" symbol="gdu_device_linux_md_component_get_state">
				<return-type type="char**"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_component_get_uuid" symbol="gdu_device_linux_md_component_get_uuid">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_component_get_version" symbol="gdu_device_linux_md_component_get_version">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_get_home_host" symbol="gdu_device_linux_md_get_home_host">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_get_level" symbol="gdu_device_linux_md_get_level">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_get_name" symbol="gdu_device_linux_md_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_get_num_raid_devices" symbol="gdu_device_linux_md_get_num_raid_devices">
				<return-type type="int"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_get_slaves" symbol="gdu_device_linux_md_get_slaves">
				<return-type type="char**"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_get_state" symbol="gdu_device_linux_md_get_state">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_get_sync_action" symbol="gdu_device_linux_md_get_sync_action">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_get_sync_percentage" symbol="gdu_device_linux_md_get_sync_percentage">
				<return-type type="double"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_get_sync_speed" symbol="gdu_device_linux_md_get_sync_speed">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_get_uuid" symbol="gdu_device_linux_md_get_uuid">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_get_version" symbol="gdu_device_linux_md_get_version">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="linux_md_is_degraded" symbol="gdu_device_linux_md_is_degraded">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="luks_cleartext_get_slave" symbol="gdu_device_luks_cleartext_get_slave">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="luks_cleartext_unlocked_by_uid" symbol="gdu_device_luks_cleartext_unlocked_by_uid">
				<return-type type="uid_t"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="luks_get_holder" symbol="gdu_device_luks_get_holder">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="op_cancel_job" symbol="gdu_device_op_cancel_job">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="callback" type="GduDeviceCancelJobCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_drive_ata_smart_initiate_selftest" symbol="gdu_device_op_drive_ata_smart_initiate_selftest">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="test" type="char*"/>
					<parameter name="callback" type="GduDeviceDriveAtaSmartInitiateSelftestCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_drive_benchmark" symbol="gdu_device_op_drive_benchmark">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="do_write_benchmark" type="gboolean"/>
					<parameter name="options" type="gchar**"/>
					<parameter name="callback" type="GduDeviceDriveBenchmarkCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_drive_detach" symbol="gdu_device_op_drive_detach">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="callback" type="GduDeviceDriveDetachCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_drive_eject" symbol="gdu_device_op_drive_eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="callback" type="GduDeviceDriveEjectCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_drive_poll_media" symbol="gdu_device_op_drive_poll_media">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="callback" type="GduDeviceDrivePollMediaCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_filesystem_check" symbol="gdu_device_op_filesystem_check">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="callback" type="GduDeviceFilesystemCheckCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_filesystem_create" symbol="gdu_device_op_filesystem_create">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="fstype" type="char*"/>
					<parameter name="fslabel" type="char*"/>
					<parameter name="encrypt_passphrase" type="char*"/>
					<parameter name="fs_take_ownership" type="gboolean"/>
					<parameter name="callback" type="GduDeviceFilesystemCreateCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_filesystem_mount" symbol="gdu_device_op_filesystem_mount">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="options" type="gchar**"/>
					<parameter name="callback" type="GduDeviceFilesystemMountCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_filesystem_set_label" symbol="gdu_device_op_filesystem_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="new_label" type="char*"/>
					<parameter name="callback" type="GduDeviceFilesystemSetLabelCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_filesystem_unmount" symbol="gdu_device_op_filesystem_unmount">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="callback" type="GduDeviceFilesystemUnmountCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_lvm2_lv_stop" symbol="gdu_device_op_linux_lvm2_lv_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="callback" type="GduDeviceLinuxLvm2LVStopCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_md_add_spare" symbol="gdu_device_op_linux_md_add_spare">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="component_objpath" type="char*"/>
					<parameter name="callback" type="GduDeviceLinuxMdAddSpareCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_md_check" symbol="gdu_device_op_linux_md_check">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="options" type="gchar**"/>
					<parameter name="callback" type="GduDeviceLinuxMdCheckCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_md_expand" symbol="gdu_device_op_linux_md_expand">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="component_objpaths" type="GPtrArray*"/>
					<parameter name="callback" type="GduDeviceLinuxMdExpandCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_md_remove_component" symbol="gdu_device_op_linux_md_remove_component">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="component_objpath" type="char*"/>
					<parameter name="callback" type="GduDeviceLinuxMdRemoveComponentCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_md_stop" symbol="gdu_device_op_linux_md_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="callback" type="GduDeviceLinuxMdStopCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_luks_change_passphrase" symbol="gdu_device_op_luks_change_passphrase">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="old_secret" type="char*"/>
					<parameter name="new_secret" type="char*"/>
					<parameter name="callback" type="GduDeviceLuksChangePassphraseCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_luks_lock" symbol="gdu_device_op_luks_lock">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="callback" type="GduDeviceLuksLockCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_luks_unlock" symbol="gdu_device_op_luks_unlock">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="secret" type="char*"/>
					<parameter name="callback" type="GduDeviceLuksUnlockCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_partition_create" symbol="gdu_device_op_partition_create">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="offset" type="guint64"/>
					<parameter name="size" type="guint64"/>
					<parameter name="type" type="char*"/>
					<parameter name="label" type="char*"/>
					<parameter name="flags" type="char**"/>
					<parameter name="fstype" type="char*"/>
					<parameter name="fslabel" type="char*"/>
					<parameter name="encrypt_passphrase" type="char*"/>
					<parameter name="fs_take_ownership" type="gboolean"/>
					<parameter name="callback" type="GduDevicePartitionCreateCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_partition_delete" symbol="gdu_device_op_partition_delete">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="callback" type="GduDevicePartitionDeleteCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_partition_modify" symbol="gdu_device_op_partition_modify">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="type" type="char*"/>
					<parameter name="label" type="char*"/>
					<parameter name="flags" type="char**"/>
					<parameter name="callback" type="GduDevicePartitionModifyCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_partition_table_create" symbol="gdu_device_op_partition_table_create">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="scheme" type="char*"/>
					<parameter name="callback" type="GduDevicePartitionTableCreateCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="optical_disc_get_is_appendable" symbol="gdu_device_optical_disc_get_is_appendable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="optical_disc_get_is_blank" symbol="gdu_device_optical_disc_get_is_blank">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="optical_disc_get_is_closed" symbol="gdu_device_optical_disc_get_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="optical_disc_get_num_audio_tracks" symbol="gdu_device_optical_disc_get_num_audio_tracks">
				<return-type type="guint"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="optical_disc_get_num_sessions" symbol="gdu_device_optical_disc_get_num_sessions">
				<return-type type="guint"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="optical_disc_get_num_tracks" symbol="gdu_device_optical_disc_get_num_tracks">
				<return-type type="guint"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="partition_get_alignment_offset" symbol="gdu_device_partition_get_alignment_offset">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="partition_get_flags" symbol="gdu_device_partition_get_flags">
				<return-type type="char**"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="partition_get_label" symbol="gdu_device_partition_get_label">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="partition_get_number" symbol="gdu_device_partition_get_number">
				<return-type type="int"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="partition_get_offset" symbol="gdu_device_partition_get_offset">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="partition_get_scheme" symbol="gdu_device_partition_get_scheme">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="partition_get_size" symbol="gdu_device_partition_get_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="partition_get_slave" symbol="gdu_device_partition_get_slave">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="partition_get_type" symbol="gdu_device_partition_get_type">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="partition_get_uuid" symbol="gdu_device_partition_get_uuid">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="partition_table_get_count" symbol="gdu_device_partition_table_get_count">
				<return-type type="int"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="partition_table_get_scheme" symbol="gdu_device_partition_table_get_scheme">
				<return-type type="char*"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="should_ignore" symbol="gdu_device_should_ignore">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</signal>
			<signal name="job-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</signal>
			<signal name="removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</signal>
		</object>
		<object name="GduDrive" parent="GObject" type-name="GduDrive" get-type="gdu_drive_get_type">
			<implements>
				<interface name="GduPresentable"/>
			</implements>
			<method name="activate" symbol="gdu_drive_activate">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="callback" type="GduDriveActivateFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="can_activate" symbol="gdu_drive_can_activate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="out_degraded" type="gboolean*"/>
				</parameters>
			</method>
			<method name="can_create_volume" symbol="gdu_drive_can_create_volume">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="out_is_uninitialized" type="gboolean*"/>
					<parameter name="out_largest_contiguous_free_segment" type="guint64*"/>
					<parameter name="out_total_free" type="guint64*"/>
					<parameter name="out_presentable" type="GduPresentable**"/>
				</parameters>
			</method>
			<method name="can_deactivate" symbol="gdu_drive_can_deactivate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
				</parameters>
			</method>
			<method name="count_mbr_partitions" symbol="gdu_drive_count_mbr_partitions">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="out_num_primary_partitions" type="guint*"/>
					<parameter name="out_has_extended_partition" type="gboolean*"/>
				</parameters>
			</method>
			<method name="create_volume" symbol="gdu_drive_create_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="size" type="guint64"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="flags" type="GduCreateVolumeFlags"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="create_volume_finish" symbol="gdu_drive_create_volume_finish">
				<return-type type="GduVolume*"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="deactivate" symbol="gdu_drive_deactivate">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="callback" type="GduDriveDeactivateFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_volumes" symbol="gdu_drive_get_volumes">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
				</parameters>
			</method>
			<method name="is_activatable" symbol="gdu_drive_is_activatable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
				</parameters>
			</method>
			<method name="is_active" symbol="gdu_drive_is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
				</parameters>
			</method>
			<vfunc name="activate">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="callback" type="GduDriveActivateFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="can_activate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="out_degraded" type="gboolean*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_create_volume">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="out_is_uninitialized" type="gboolean*"/>
					<parameter name="out_largest_contiguous_free_segment" type="guint64*"/>
					<parameter name="out_total_free" type="guint64*"/>
					<parameter name="out_presentable" type="GduPresentable**"/>
				</parameters>
			</vfunc>
			<vfunc name="can_deactivate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="create_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="size" type="guint64"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="flags" type="GduCreateVolumeFlags"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="create_volume_finish">
				<return-type type="GduVolume*"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="deactivate">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
					<parameter name="callback" type="GduDriveDeactivateFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="is_activatable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GduExpander" parent="GObject" type-name="GduExpander" get-type="gdu_expander_get_type">
			<method name="get_adapter" symbol="gdu_expander_get_adapter">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</method>
			<method name="get_model" symbol="gdu_expander_get_model">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</method>
			<method name="get_native_path" symbol="gdu_expander_get_native_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</method>
			<method name="get_num_ports" symbol="gdu_expander_get_num_ports">
				<return-type type="guint"/>
				<parameters>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</method>
			<method name="get_object_path" symbol="gdu_expander_get_object_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</method>
			<method name="get_pool" symbol="gdu_expander_get_pool">
				<return-type type="GduPool*"/>
				<parameters>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</method>
			<method name="get_revision" symbol="gdu_expander_get_revision">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</method>
			<method name="get_upstream_ports" symbol="gdu_expander_get_upstream_ports">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</method>
			<method name="get_vendor" symbol="gdu_expander_get_vendor">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</signal>
			<signal name="removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</signal>
		</object>
		<object name="GduHub" parent="GObject" type-name="GduHub" get-type="gdu_hub_get_type">
			<implements>
				<interface name="GduPresentable"/>
			</implements>
			<method name="get_adapter" symbol="gdu_hub_get_adapter">
				<return-type type="GduAdapter*"/>
				<parameters>
					<parameter name="hub" type="GduHub*"/>
				</parameters>
			</method>
			<method name="get_expander" symbol="gdu_hub_get_expander">
				<return-type type="GduExpander*"/>
				<parameters>
					<parameter name="hub" type="GduHub*"/>
				</parameters>
			</method>
			<method name="get_usage" symbol="gdu_hub_get_usage">
				<return-type type="GduHubUsage"/>
				<parameters>
					<parameter name="hub" type="GduHub*"/>
				</parameters>
			</method>
		</object>
		<object name="GduKnownFilesystem" parent="GObject" type-name="GduKnownFilesystem" get-type="gdu_known_filesystem_get_type">
			<method name="get_can_create" symbol="gdu_known_filesystem_get_can_create">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_can_mount" symbol="gdu_known_filesystem_get_can_mount">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gdu_known_filesystem_get_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_max_label_len" symbol="gdu_known_filesystem_get_max_label_len">
				<return-type type="guint"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdu_known_filesystem_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_supports_fsck" symbol="gdu_known_filesystem_get_supports_fsck">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_supports_label_rename" symbol="gdu_known_filesystem_get_supports_label_rename">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_supports_online_fsck" symbol="gdu_known_filesystem_get_supports_online_fsck">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_supports_online_label_rename" symbol="gdu_known_filesystem_get_supports_online_label_rename">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_supports_online_resize_enlarge" symbol="gdu_known_filesystem_get_supports_online_resize_enlarge">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_supports_online_resize_shrink" symbol="gdu_known_filesystem_get_supports_online_resize_shrink">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_supports_resize_enlarge" symbol="gdu_known_filesystem_get_supports_resize_enlarge">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_supports_resize_shrink" symbol="gdu_known_filesystem_get_supports_resize_shrink">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
			<method name="get_supports_unix_owners" symbol="gdu_known_filesystem_get_supports_unix_owners">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="known_filesystem" type="GduKnownFilesystem*"/>
				</parameters>
			</method>
		</object>
		<object name="GduLinuxLvm2Volume" parent="GduVolume" type-name="GduLinuxLvm2Volume" get-type="gdu_linux_lvm2_volume_get_type">
			<implements>
				<interface name="GduPresentable"/>
			</implements>
			<method name="get_group_uuid" symbol="gdu_linux_lvm2_volume_get_group_uuid">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="volume" type="GduLinuxLvm2Volume*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdu_linux_lvm2_volume_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="volume" type="GduLinuxLvm2Volume*"/>
				</parameters>
			</method>
			<method name="get_uuid" symbol="gdu_linux_lvm2_volume_get_uuid">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="volume" type="GduLinuxLvm2Volume*"/>
				</parameters>
			</method>
		</object>
		<object name="GduLinuxLvm2VolumeGroup" parent="GduDrive" type-name="GduLinuxLvm2VolumeGroup" get-type="gdu_linux_lvm2_volume_group_get_type">
			<implements>
				<interface name="GduPresentable"/>
			</implements>
			<method name="get_compute_new_lv_name" symbol="gdu_linux_lvm2_volume_group_get_compute_new_lv_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="vg" type="GduLinuxLvm2VolumeGroup*"/>
				</parameters>
			</method>
			<method name="get_lv_info" symbol="gdu_linux_lvm2_volume_group_get_lv_info">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="vg" type="GduLinuxLvm2VolumeGroup*"/>
					<parameter name="lv_uuid" type="gchar*"/>
					<parameter name="out_position" type="guint*"/>
					<parameter name="out_name" type="gchar**"/>
					<parameter name="out_size" type="guint64*"/>
				</parameters>
			</method>
			<method name="get_num_lvs" symbol="gdu_linux_lvm2_volume_group_get_num_lvs">
				<return-type type="guint"/>
				<parameters>
					<parameter name="vg" type="GduLinuxLvm2VolumeGroup*"/>
				</parameters>
			</method>
			<method name="get_pv_device" symbol="gdu_linux_lvm2_volume_group_get_pv_device">
				<return-type type="GduDevice*"/>
				<parameters>
					<parameter name="vg" type="GduLinuxLvm2VolumeGroup*"/>
				</parameters>
			</method>
			<method name="get_pv_info" symbol="gdu_linux_lvm2_volume_group_get_pv_info">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="vg" type="GduLinuxLvm2VolumeGroup*"/>
					<parameter name="pv_uuid" type="gchar*"/>
					<parameter name="out_position" type="guint*"/>
					<parameter name="out_size" type="guint64*"/>
					<parameter name="out_allocated_size" type="guint64*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="gdu_linux_lvm2_volume_group_get_state">
				<return-type type="GduLinuxLvm2VolumeGroupState"/>
				<parameters>
					<parameter name="vg" type="GduLinuxLvm2VolumeGroup*"/>
				</parameters>
			</method>
			<method name="get_uuid" symbol="gdu_linux_lvm2_volume_group_get_uuid">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="vg" type="GduLinuxLvm2VolumeGroup*"/>
				</parameters>
			</method>
		</object>
		<object name="GduLinuxLvm2VolumeHole" parent="GduVolumeHole" type-name="GduLinuxLvm2VolumeHole" get-type="gdu_linux_lvm2_volume_hole_get_type">
			<implements>
				<interface name="GduPresentable"/>
			</implements>
		</object>
		<object name="GduLinuxMdDrive" parent="GduDrive" type-name="GduLinuxMdDrive" get-type="gdu_linux_md_drive_get_type">
			<implements>
				<interface name="GduPresentable"/>
			</implements>
			<method name="get_slave_flags" symbol="gdu_linux_md_drive_get_slave_flags">
				<return-type type="GduLinuxMdDriveSlaveFlags"/>
				<parameters>
					<parameter name="drive" type="GduLinuxMdDrive*"/>
					<parameter name="slave" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_slave_state_markup" symbol="gdu_linux_md_drive_get_slave_state_markup">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="drive" type="GduLinuxMdDrive*"/>
					<parameter name="slave" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_slaves" symbol="gdu_linux_md_drive_get_slaves">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="drive" type="GduLinuxMdDrive*"/>
				</parameters>
			</method>
			<method name="get_uuid" symbol="gdu_linux_md_drive_get_uuid">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="drive" type="GduLinuxMdDrive*"/>
				</parameters>
			</method>
			<method name="has_slave" symbol="gdu_linux_md_drive_has_slave">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GduLinuxMdDrive*"/>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
		</object>
		<object name="GduMachine" parent="GObject" type-name="GduMachine" get-type="gdu_machine_get_type">
			<implements>
				<interface name="GduPresentable"/>
			</implements>
		</object>
		<object name="GduPool" parent="GObject" type-name="GduPool" get-type="gdu_pool_get_type">
			<method name="get_adapter_by_object_path" symbol="gdu_pool_get_adapter_by_object_path">
				<return-type type="GduAdapter*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="object_path" type="char*"/>
				</parameters>
			</method>
			<method name="get_adapters" symbol="gdu_pool_get_adapters">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</method>
			<method name="get_by_device_file" symbol="gdu_pool_get_by_device_file">
				<return-type type="GduDevice*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="device_file" type="char*"/>
				</parameters>
			</method>
			<method name="get_by_object_path" symbol="gdu_pool_get_by_object_path">
				<return-type type="GduDevice*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="object_path" type="char*"/>
				</parameters>
			</method>
			<method name="get_daemon_version" symbol="gdu_pool_get_daemon_version">
				<return-type type="char*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</method>
			<method name="get_devices" symbol="gdu_pool_get_devices">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</method>
			<method name="get_drive_by_device" symbol="gdu_pool_get_drive_by_device">
				<return-type type="GduPresentable*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="get_enclosed_presentables" symbol="gdu_pool_get_enclosed_presentables">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_expander_by_object_path" symbol="gdu_pool_get_expander_by_object_path">
				<return-type type="GduExpander*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="object_path" type="char*"/>
				</parameters>
			</method>
			<method name="get_expanders" symbol="gdu_pool_get_expanders">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</method>
			<method name="get_hub_by_object_path" symbol="gdu_pool_get_hub_by_object_path">
				<return-type type="GduPresentable*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="object_path" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_known_filesystem_by_id" symbol="gdu_pool_get_known_filesystem_by_id">
				<return-type type="GduKnownFilesystem*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_known_filesystems" symbol="gdu_pool_get_known_filesystems">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</method>
			<method name="get_linux_md_drive_by_uuid" symbol="gdu_pool_get_linux_md_drive_by_uuid">
				<return-type type="GduLinuxMdDrive*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="uuid" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_port_by_object_path" symbol="gdu_pool_get_port_by_object_path">
				<return-type type="GduPort*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="object_path" type="char*"/>
				</parameters>
			</method>
			<method name="get_ports" symbol="gdu_pool_get_ports">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</method>
			<method name="get_presentable_by_id" symbol="gdu_pool_get_presentable_by_id">
				<return-type type="GduPresentable*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_presentables" symbol="gdu_pool_get_presentables">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</method>
			<method name="get_ssh_address" symbol="gdu_pool_get_ssh_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</method>
			<method name="get_ssh_user_name" symbol="gdu_pool_get_ssh_user_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</method>
			<method name="get_volume_by_device" symbol="gdu_pool_get_volume_by_device">
				<return-type type="GduPresentable*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</method>
			<method name="has_presentable" symbol="gdu_pool_has_presentable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="is_daemon_inhibited" symbol="gdu_pool_is_daemon_inhibited">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_pool_new">
				<return-type type="GduPool*"/>
			</constructor>
			<constructor name="new_for_address" symbol="gdu_pool_new_for_address">
				<return-type type="GduPool*"/>
				<parameters>
					<parameter name="ssh_user_name" type="gchar*"/>
					<parameter name="ssh_address" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="op_linux_lvm2_lv_create" symbol="gdu_pool_op_linux_lvm2_lv_create">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="group_uuid" type="gchar*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="size" type="guint64"/>
					<parameter name="num_stripes" type="guint"/>
					<parameter name="stripe_size" type="guint64"/>
					<parameter name="num_mirrors" type="guint"/>
					<parameter name="fstype" type="char*"/>
					<parameter name="fslabel" type="char*"/>
					<parameter name="encrypt_passphrase" type="char*"/>
					<parameter name="fs_take_ownership" type="gboolean"/>
					<parameter name="callback" type="GduPoolLinuxLvm2LVCreateCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_lvm2_lv_remove" symbol="gdu_pool_op_linux_lvm2_lv_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="group_uuid" type="gchar*"/>
					<parameter name="uuid" type="gchar*"/>
					<parameter name="callback" type="GduPoolLinuxLvm2LVRemoveCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_lvm2_lv_set_name" symbol="gdu_pool_op_linux_lvm2_lv_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="group_uuid" type="gchar*"/>
					<parameter name="uuid" type="gchar*"/>
					<parameter name="new_name" type="gchar*"/>
					<parameter name="callback" type="GduPoolLinuxLvm2LVSetNameCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_lvm2_lv_start" symbol="gdu_pool_op_linux_lvm2_lv_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="group_uuid" type="gchar*"/>
					<parameter name="uuid" type="gchar*"/>
					<parameter name="callback" type="GduPoolLinuxLvm2VGStartCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_lvm2_vg_add_pv" symbol="gdu_pool_op_linux_lvm2_vg_add_pv">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="uuid" type="gchar*"/>
					<parameter name="physical_volume_object_path" type="gchar*"/>
					<parameter name="callback" type="GduPoolLinuxLvm2VGAddPVCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_lvm2_vg_remove_pv" symbol="gdu_pool_op_linux_lvm2_vg_remove_pv">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="vg_uuid" type="gchar*"/>
					<parameter name="pv_uuid" type="gchar*"/>
					<parameter name="callback" type="GduPoolLinuxLvm2VGRemovePVCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_lvm2_vg_set_name" symbol="gdu_pool_op_linux_lvm2_vg_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="uuid" type="gchar*"/>
					<parameter name="new_name" type="gchar*"/>
					<parameter name="callback" type="GduPoolLinuxLvm2VGSetNameCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_lvm2_vg_start" symbol="gdu_pool_op_linux_lvm2_vg_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="uuid" type="gchar*"/>
					<parameter name="callback" type="GduPoolLinuxLvm2VGStartCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_lvm2_vg_stop" symbol="gdu_pool_op_linux_lvm2_vg_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="uuid" type="gchar*"/>
					<parameter name="callback" type="GduPoolLinuxLvm2VGStopCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_md_create" symbol="gdu_pool_op_linux_md_create">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="component_objpaths" type="GPtrArray*"/>
					<parameter name="level" type="gchar*"/>
					<parameter name="stripe_size" type="guint64"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="callback" type="GduPoolLinuxMdCreateCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="op_linux_md_start" symbol="gdu_pool_op_linux_md_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="component_objpaths" type="GPtrArray*"/>
					<parameter name="callback" type="GduPoolLinuxMdStartCompletedFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="supports_luks_devices" symbol="gdu_pool_supports_luks_devices">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</method>
			<signal name="adapter-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</signal>
			<signal name="adapter-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</signal>
			<signal name="adapter-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="adapter" type="GduAdapter*"/>
				</parameters>
			</signal>
			<signal name="device-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</signal>
			<signal name="device-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</signal>
			<signal name="device-job-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</signal>
			<signal name="device-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</signal>
			<signal name="disconnected" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</signal>
			<signal name="expander-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</signal>
			<signal name="expander-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</signal>
			<signal name="expander-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="expander" type="GduExpander*"/>
				</parameters>
			</signal>
			<signal name="port-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="port" type="GduPort*"/>
				</parameters>
			</signal>
			<signal name="port-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="port" type="GduPort*"/>
				</parameters>
			</signal>
			<signal name="port-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="port" type="GduPort*"/>
				</parameters>
			</signal>
			<signal name="presentable-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</signal>
			<signal name="presentable-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</signal>
			<signal name="presentable-job-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</signal>
			<signal name="presentable-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</signal>
		</object>
		<object name="GduPort" parent="GObject" type-name="GduPort" get-type="gdu_port_get_type">
			<method name="get_adapter" symbol="gdu_port_get_adapter">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="port" type="GduPort*"/>
				</parameters>
			</method>
			<method name="get_connector_type" symbol="gdu_port_get_connector_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="port" type="GduPort*"/>
				</parameters>
			</method>
			<method name="get_native_path" symbol="gdu_port_get_native_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="port" type="GduPort*"/>
				</parameters>
			</method>
			<method name="get_number" symbol="gdu_port_get_number">
				<return-type type="gint"/>
				<parameters>
					<parameter name="port" type="GduPort*"/>
				</parameters>
			</method>
			<method name="get_object_path" symbol="gdu_port_get_object_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="port" type="GduPort*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="gdu_port_get_parent">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="port" type="GduPort*"/>
				</parameters>
			</method>
			<method name="get_pool" symbol="gdu_port_get_pool">
				<return-type type="GduPool*"/>
				<parameters>
					<parameter name="port" type="GduPort*"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="port" type="GduPort*"/>
				</parameters>
			</signal>
			<signal name="removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="port" type="GduPort*"/>
				</parameters>
			</signal>
		</object>
		<object name="GduProcess" parent="GObject" type-name="GduProcess" get-type="gdu_process_get_type">
			<method name="get_app_info" symbol="gdu_process_get_app_info">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="process" type="GduProcess*"/>
				</parameters>
			</method>
			<method name="get_command_line" symbol="gdu_process_get_command_line">
				<return-type type="char*"/>
				<parameters>
					<parameter name="process" type="GduProcess*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gdu_process_get_id">
				<return-type type="pid_t"/>
				<parameters>
					<parameter name="process" type="GduProcess*"/>
				</parameters>
			</method>
			<method name="get_owner" symbol="gdu_process_get_owner">
				<return-type type="uid_t"/>
				<parameters>
					<parameter name="process" type="GduProcess*"/>
				</parameters>
			</method>
		</object>
		<object name="GduVolume" parent="GObject" type-name="GduVolume" get-type="gdu_volume_get_type">
			<implements>
				<interface name="GduPresentable"/>
			</implements>
			<method name="get_drive" symbol="gdu_volume_get_drive">
				<return-type type="GduDrive*"/>
				<parameters>
					<parameter name="volume" type="GduVolume*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="gdu_volume_get_flags">
				<return-type type="GduVolumeFlags"/>
				<parameters>
					<parameter name="volume" type="GduVolume*"/>
				</parameters>
			</method>
			<method name="is_allocated" symbol="gdu_volume_is_allocated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GduVolume*"/>
				</parameters>
			</method>
			<method name="is_recognized" symbol="gdu_volume_is_recognized">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GduVolume*"/>
				</parameters>
			</method>
			<vfunc name="get_flags">
				<return-type type="GduVolumeFlags"/>
				<parameters>
					<parameter name="volume" type="GduVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_allocated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GduVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_recognized">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GduVolume*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GduVolumeHole" parent="GObject" type-name="GduVolumeHole" get-type="gdu_volume_hole_get_type">
			<implements>
				<interface name="GduPresentable"/>
			</implements>
		</object>
		<interface name="GduPresentable" type-name="GduPresentable" get-type="gdu_presentable_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="compare" symbol="gdu_presentable_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GduPresentable*"/>
					<parameter name="b" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="encloses" symbol="gdu_presentable_encloses">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="a" type="GduPresentable*"/>
					<parameter name="b" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="equals" symbol="gdu_presentable_equals">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="a" type="GduPresentable*"/>
					<parameter name="b" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="gdu_presentable_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_device" symbol="gdu_presentable_get_device">
				<return-type type="GduDevice*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_enclosed" symbol="gdu_presentable_get_enclosed">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_enclosing_presentable" symbol="gdu_presentable_get_enclosing_presentable">
				<return-type type="GduPresentable*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gdu_presentable_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gdu_presentable_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdu_presentable_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_offset" symbol="gdu_presentable_get_offset">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_pool" symbol="gdu_presentable_get_pool">
				<return-type type="GduPool*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gdu_presentable_get_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_toplevel" symbol="gdu_presentable_get_toplevel">
				<return-type type="GduPresentable*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="get_vpd_name" symbol="gdu_presentable_get_vpd_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="hash" symbol="gdu_presentable_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="is_allocated" symbol="gdu_presentable_is_allocated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<method name="is_recognized" symbol="gdu_presentable_is_recognized">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</signal>
			<signal name="job-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</signal>
			<signal name="removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</signal>
			<vfunc name="get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_device">
				<return-type type="GduDevice*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_enclosing_presentable">
				<return-type type="GduPresentable*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_offset">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_pool">
				<return-type type="GduPool*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_vpd_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_allocated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_recognized">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</vfunc>
		</interface>
	</namespace>
</api>
