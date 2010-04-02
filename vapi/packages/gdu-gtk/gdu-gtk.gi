<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gdu">
		<function name="util_delete_confirmation_dialog" symbol="gdu_util_delete_confirmation_dialog">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="parent_window" type="GtkWidget*"/>
				<parameter name="title" type="char*"/>
				<parameter name="primary_text" type="char*"/>
				<parameter name="secondary_text" type="char*"/>
				<parameter name="affirmative_action_button_mnemonic" type="char*"/>
			</parameters>
		</function>
		<function name="util_dialog_ask_for_new_secret" symbol="gdu_util_dialog_ask_for_new_secret">
			<return-type type="char*"/>
			<parameters>
				<parameter name="parent_window" type="GtkWidget*"/>
				<parameter name="save_in_keyring" type="gboolean*"/>
				<parameter name="save_in_keyring_session" type="gboolean*"/>
			</parameters>
		</function>
		<function name="util_dialog_ask_for_secret" symbol="gdu_util_dialog_ask_for_secret">
			<return-type type="char*"/>
			<parameters>
				<parameter name="parent_window" type="GtkWidget*"/>
				<parameter name="presentable" type="GduPresentable*"/>
				<parameter name="bypass_keyring" type="gboolean"/>
				<parameter name="indicate_wrong_passphrase" type="gboolean"/>
				<parameter name="asked_user" type="gboolean*"/>
			</parameters>
		</function>
		<function name="util_dialog_change_secret" symbol="gdu_util_dialog_change_secret">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="parent_window" type="GtkWidget*"/>
				<parameter name="presentable" type="GduPresentable*"/>
				<parameter name="old_secret" type="char**"/>
				<parameter name="new_secret" type="char**"/>
				<parameter name="save_in_keyring" type="gboolean*"/>
				<parameter name="save_in_keyring_session" type="gboolean*"/>
				<parameter name="bypass_keyring" type="gboolean"/>
				<parameter name="indicate_wrong_passphrase" type="gboolean"/>
			</parameters>
		</function>
		<function name="util_dialog_show_filesystem_busy" symbol="gdu_util_dialog_show_filesystem_busy">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="parent_window" type="GtkWidget*"/>
				<parameter name="presentable" type="GduPresentable*"/>
			</parameters>
		</function>
		<function name="util_fstype_combo_box_create" symbol="gdu_util_fstype_combo_box_create">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="include_extended_partitions_for_scheme" type="char*"/>
			</parameters>
		</function>
		<function name="util_fstype_combo_box_get_selected" symbol="gdu_util_fstype_combo_box_get_selected">
			<return-type type="char*"/>
			<parameters>
				<parameter name="combo_box" type="GtkWidget*"/>
			</parameters>
		</function>
		<function name="util_fstype_combo_box_rebuild" symbol="gdu_util_fstype_combo_box_rebuild">
			<return-type type="void"/>
			<parameters>
				<parameter name="combo_box" type="GtkWidget*"/>
				<parameter name="pool" type="GduPool*"/>
				<parameter name="include_extended_partitions_for_scheme" type="char*"/>
			</parameters>
		</function>
		<function name="util_fstype_combo_box_select" symbol="gdu_util_fstype_combo_box_select">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="combo_box" type="GtkWidget*"/>
				<parameter name="fstype" type="char*"/>
			</parameters>
		</function>
		<function name="util_fstype_combo_box_set_desc_label" symbol="gdu_util_fstype_combo_box_set_desc_label">
			<return-type type="void"/>
			<parameters>
				<parameter name="combo_box" type="GtkWidget*"/>
				<parameter name="desc_label" type="GtkWidget*"/>
			</parameters>
		</function>
		<function name="util_get_mix_color" symbol="gdu_util_get_mix_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="state" type="GtkStateType"/>
				<parameter name="color_buf" type="gchar*"/>
				<parameter name="color_buf_size" type="gsize"/>
			</parameters>
		</function>
		<function name="util_get_pixbuf_for_presentable" symbol="gdu_util_get_pixbuf_for_presentable">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="presentable" type="GduPresentable*"/>
				<parameter name="size" type="GtkIconSize"/>
			</parameters>
		</function>
		<function name="util_get_pixbuf_for_presentable_at_pixel_size" symbol="gdu_util_get_pixbuf_for_presentable_at_pixel_size">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="presentable" type="GduPresentable*"/>
				<parameter name="pixel_size" type="gint"/>
			</parameters>
		</function>
		<function name="util_part_table_type_combo_box_create" symbol="gdu_util_part_table_type_combo_box_create">
			<return-type type="GtkWidget*"/>
		</function>
		<function name="util_part_table_type_combo_box_get_selected" symbol="gdu_util_part_table_type_combo_box_get_selected">
			<return-type type="char*"/>
			<parameters>
				<parameter name="combo_box" type="GtkWidget*"/>
			</parameters>
		</function>
		<function name="util_part_table_type_combo_box_select" symbol="gdu_util_part_table_type_combo_box_select">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="combo_box" type="GtkWidget*"/>
				<parameter name="part_table_type" type="char*"/>
			</parameters>
		</function>
		<function name="util_part_table_type_combo_box_set_desc_label" symbol="gdu_util_part_table_type_combo_box_set_desc_label">
			<return-type type="void"/>
			<parameters>
				<parameter name="combo_box" type="GtkWidget*"/>
				<parameter name="desc_label" type="GtkWidget*"/>
			</parameters>
		</function>
		<function name="util_part_type_combo_box_create" symbol="gdu_util_part_type_combo_box_create">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="part_scheme" type="char*"/>
			</parameters>
		</function>
		<function name="util_part_type_combo_box_get_selected" symbol="gdu_util_part_type_combo_box_get_selected">
			<return-type type="char*"/>
			<parameters>
				<parameter name="combo_box" type="GtkWidget*"/>
			</parameters>
		</function>
		<function name="util_part_type_combo_box_rebuild" symbol="gdu_util_part_type_combo_box_rebuild">
			<return-type type="void"/>
			<parameters>
				<parameter name="combo_box" type="GtkWidget*"/>
				<parameter name="part_scheme" type="char*"/>
			</parameters>
		</function>
		<function name="util_part_type_combo_box_select" symbol="gdu_util_part_type_combo_box_select">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="combo_box" type="GtkWidget*"/>
				<parameter name="part_type" type="char*"/>
			</parameters>
		</function>
		<struct name="GduColor">
		</struct>
		<struct name="GduCurve">
		</struct>
		<struct name="GduGraph">
		</struct>
		<struct name="GduSample">
		</struct>
		<enum name="GduPoolTreeModelColumn" type-name="GduPoolTreeModelColumn" get-type="gdu_pool_tree_model_column_get_type">
			<member name="GDU_POOL_TREE_MODEL_COLUMN_ICON" value="0"/>
			<member name="GDU_POOL_TREE_MODEL_COLUMN_NAME" value="1"/>
			<member name="GDU_POOL_TREE_MODEL_COLUMN_VPD_NAME" value="2"/>
			<member name="GDU_POOL_TREE_MODEL_COLUMN_DESCRIPTION" value="3"/>
			<member name="GDU_POOL_TREE_MODEL_COLUMN_PRESENTABLE" value="4"/>
			<member name="GDU_POOL_TREE_MODEL_COLUMN_VISIBLE" value="5"/>
			<member name="GDU_POOL_TREE_MODEL_COLUMN_TOGGLED" value="6"/>
			<member name="GDU_POOL_TREE_MODEL_COLUMN_CAN_BE_TOGGLED" value="7"/>
		</enum>
		<flags name="GduAddComponentLinuxMdFlags" type-name="GduAddComponentLinuxMdFlags" get-type="gdu_add_component_linux_md_flags_get_type">
			<member name="GDU_ADD_COMPONENT_LINUX_MD_FLAGS_NONE" value="0"/>
			<member name="GDU_ADD_COMPONENT_LINUX_MD_FLAGS_SPARE" value="1"/>
			<member name="GDU_ADD_COMPONENT_LINUX_MD_FLAGS_EXPANSION" value="2"/>
		</flags>
		<flags name="GduDiskSelectionWidgetFlags" type-name="GduDiskSelectionWidgetFlags" get-type="gdu_disk_selection_widget_flags_get_type">
			<member name="GDU_DISK_SELECTION_WIDGET_FLAGS_NONE" value="0"/>
			<member name="GDU_DISK_SELECTION_WIDGET_FLAGS_ALLOW_MULTIPLE" value="1"/>
			<member name="GDU_DISK_SELECTION_WIDGET_FLAGS_ALLOW_DISKS_WITH_INSUFFICIENT_SPACE" value="2"/>
		</flags>
		<flags name="GduFormatDialogFlags" type-name="GduFormatDialogFlags" get-type="gdu_format_dialog_flags_get_type">
			<member name="GDU_FORMAT_DIALOG_FLAGS_NONE" value="0"/>
			<member name="GDU_FORMAT_DIALOG_FLAGS_SIMPLE" value="1"/>
			<member name="GDU_FORMAT_DIALOG_FLAGS_DISK_UTILITY_BUTTON" value="2"/>
			<member name="GDU_FORMAT_DIALOG_FLAGS_ALLOW_MSDOS_EXTENDED" value="4"/>
		</flags>
		<flags name="GduPoolTreeModelFlags" type-name="GduPoolTreeModelFlags" get-type="gdu_pool_tree_model_flags_get_type">
			<member name="GDU_POOL_TREE_MODEL_FLAGS_NONE" value="0"/>
			<member name="GDU_POOL_TREE_MODEL_FLAGS_NO_VOLUMES" value="1"/>
			<member name="GDU_POOL_TREE_MODEL_FLAGS_NO_UNALLOCATABLE_DRIVES" value="4"/>
		</flags>
		<flags name="GduPoolTreeViewFlags" type-name="GduPoolTreeViewFlags" get-type="gdu_pool_tree_view_flags_get_type">
			<member name="GDU_POOL_TREE_VIEW_FLAGS_NONE" value="0"/>
			<member name="GDU_POOL_TREE_VIEW_FLAGS_SHOW_TOGGLE" value="1"/>
		</flags>
		<object name="GduAddComponentLinuxMdDialog" parent="GduDialog" type-name="GduAddComponentLinuxMdDialog" get-type="gdu_add_component_linux_md_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_drives" symbol="gdu_add_component_linux_md_dialog_get_drives">
				<return-type type="GPtrArray*"/>
				<parameters>
					<parameter name="dialog" type="GduAddComponentLinuxMdDialog*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gdu_add_component_linux_md_dialog_get_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="dialog" type="GduAddComponentLinuxMdDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_add_component_linux_md_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="flags" type="GduAddComponentLinuxMdFlags"/>
					<parameter name="linux_md_drive" type="GduLinuxMdDrive*"/>
				</parameters>
			</constructor>
			<property name="drives" type="GPtrArray*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="flags" type="GduAddComponentLinuxMdFlags" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="size" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GduAddPvLinuxLvm2Dialog" parent="GduDialog" type-name="GduAddPvLinuxLvm2Dialog" get-type="gdu_add_pv_linux_lvm2_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_drive" symbol="gdu_add_pv_linux_lvm2_dialog_get_drive">
				<return-type type="GduDrive*"/>
				<parameters>
					<parameter name="dialog" type="GduAddPvLinuxLvm2Dialog*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gdu_add_pv_linux_lvm2_dialog_get_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="dialog" type="GduAddPvLinuxLvm2Dialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_add_pv_linux_lvm2_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="vg" type="GduLinuxLvm2VolumeGroup*"/>
				</parameters>
			</constructor>
			<property name="drive" type="GduDrive*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="size" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GduAtaSmartDialog" parent="GduDialog" type-name="GduAtaSmartDialog" get-type="gdu_ata_smart_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="gdu_ata_smart_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="drive" type="GduDrive*"/>
				</parameters>
			</constructor>
		</object>
		<object name="GduButtonElement" parent="GObject" type-name="GduButtonElement" get-type="gdu_button_element_get_type">
			<method name="get_icon_name" symbol="gdu_button_element_get_icon_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="element" type="GduButtonElement*"/>
				</parameters>
			</method>
			<method name="get_primary_text" symbol="gdu_button_element_get_primary_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="element" type="GduButtonElement*"/>
				</parameters>
			</method>
			<method name="get_secondary_text" symbol="gdu_button_element_get_secondary_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="element" type="GduButtonElement*"/>
				</parameters>
			</method>
			<method name="get_visible" symbol="gdu_button_element_get_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GduButtonElement*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_button_element_new">
				<return-type type="GduButtonElement*"/>
				<parameters>
					<parameter name="icon_name" type="gchar*"/>
					<parameter name="primary_text" type="gchar*"/>
					<parameter name="secondary_text" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_icon_name" symbol="gdu_button_element_set_icon_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduButtonElement*"/>
					<parameter name="icon_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_primary_text" symbol="gdu_button_element_set_primary_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduButtonElement*"/>
					<parameter name="primary_text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_secondary_text" symbol="gdu_button_element_set_secondary_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduButtonElement*"/>
					<parameter name="primary_text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_visible" symbol="gdu_button_element_set_visible">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduButtonElement*"/>
					<parameter name="visible" type="gboolean"/>
				</parameters>
			</method>
			<property name="icon-name" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="primary-text" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="secondary-text" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="visible" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduButtonElement*"/>
				</parameters>
			</signal>
			<signal name="clicked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduButtonElement*"/>
				</parameters>
			</signal>
		</object>
		<object name="GduButtonTable" parent="GtkHBox" type-name="GduButtonTable" get-type="gdu_button_table_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkOrientable"/>
			</implements>
			<method name="get_elements" symbol="gdu_button_table_get_elements">
				<return-type type="GPtrArray*"/>
				<parameters>
					<parameter name="table" type="GduButtonTable*"/>
				</parameters>
			</method>
			<method name="get_num_columns" symbol="gdu_button_table_get_num_columns">
				<return-type type="guint"/>
				<parameters>
					<parameter name="table" type="GduButtonTable*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_button_table_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="num_columns" type="guint"/>
					<parameter name="elements" type="GPtrArray*"/>
				</parameters>
			</constructor>
			<method name="set_elements" symbol="gdu_button_table_set_elements">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="GduButtonTable*"/>
					<parameter name="elements" type="GPtrArray*"/>
				</parameters>
			</method>
			<method name="set_num_columns" symbol="gdu_button_table_set_num_columns">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="GduButtonTable*"/>
					<parameter name="num_columns" type="guint"/>
				</parameters>
			</method>
			<property name="elements" type="GPtrArray*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="num-columns" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="GduConfirmationDialog" parent="GduDialog" type-name="GduConfirmationDialog" get-type="gdu_confirmation_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="gdu_confirmation_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="presentable" type="GduPresentable*"/>
					<parameter name="message" type="gchar*"/>
					<parameter name="button_text" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_for_drive" symbol="gdu_confirmation_dialog_new_for_drive">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="message" type="gchar*"/>
					<parameter name="button_text" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_for_volume" symbol="gdu_confirmation_dialog_new_for_volume">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="message" type="gchar*"/>
					<parameter name="button_text" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="button-text" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="message" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GduConnectToServerDialog" parent="GtkDialog" type-name="GduConnectToServerDialog" get-type="gdu_connect_to_server_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_address" symbol="gdu_connect_to_server_dialog_get_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="GduConnectToServerDialog*"/>
				</parameters>
			</method>
			<method name="get_user_name" symbol="gdu_connect_to_server_dialog_get_user_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="GduConnectToServerDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_connect_to_server_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
				</parameters>
			</constructor>
			<property name="address" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="user-name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GduCreateLinuxLvm2VolumeDialog" parent="GduFormatDialog" type-name="GduCreateLinuxLvm2VolumeDialog" get-type="gdu_create_linux_lvm2_volume_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_max_size" symbol="gdu_create_linux_lvm2_volume_dialog_get_max_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="dialog" type="GduCreateLinuxLvm2VolumeDialog*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gdu_create_linux_lvm2_volume_dialog_get_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="dialog" type="GduCreateLinuxLvm2VolumeDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_create_linux_lvm2_volume_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="presentable" type="GduPresentable*"/>
					<parameter name="max_size" type="guint64"/>
					<parameter name="flags" type="GduFormatDialogFlags"/>
				</parameters>
			</constructor>
			<property name="max-size" type="guint64" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="size" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GduCreateLinuxMdDialog" parent="GtkDialog" type-name="GduCreateLinuxMdDialog" get-type="gdu_create_linux_md_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_component_size" symbol="gdu_create_linux_md_dialog_get_component_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="dialog" type="GduCreateLinuxMdDialog*"/>
				</parameters>
			</method>
			<method name="get_drives" symbol="gdu_create_linux_md_dialog_get_drives">
				<return-type type="GPtrArray*"/>
				<parameters>
					<parameter name="dialog" type="GduCreateLinuxMdDialog*"/>
				</parameters>
			</method>
			<method name="get_level" symbol="gdu_create_linux_md_dialog_get_level">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="GduCreateLinuxMdDialog*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdu_create_linux_md_dialog_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="GduCreateLinuxMdDialog*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gdu_create_linux_md_dialog_get_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="dialog" type="GduCreateLinuxMdDialog*"/>
				</parameters>
			</method>
			<method name="get_stripe_size" symbol="gdu_create_linux_md_dialog_get_stripe_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="dialog" type="GduCreateLinuxMdDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_create_linux_md_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="pool" type="GduPool*"/>
				</parameters>
			</constructor>
			<property name="component-size" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="drives" type="GPtrArray*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="level" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="pool" type="GduPool*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="size" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="stripe-size" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GduCreatePartitionDialog" parent="GduFormatDialog" type-name="GduCreatePartitionDialog" get-type="gdu_create_partition_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_max_size" symbol="gdu_create_partition_dialog_get_max_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="dialog" type="GduCreatePartitionDialog*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gdu_create_partition_dialog_get_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="dialog" type="GduCreatePartitionDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_create_partition_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="presentable" type="GduPresentable*"/>
					<parameter name="max_size" type="guint64"/>
					<parameter name="flags" type="GduFormatDialogFlags"/>
				</parameters>
			</constructor>
			<constructor name="new_for_drive" symbol="gdu_create_partition_dialog_new_for_drive">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="max_size" type="guint64"/>
					<parameter name="flags" type="GduFormatDialogFlags"/>
				</parameters>
			</constructor>
			<property name="max-size" type="guint64" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="size" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GduDetailsElement" parent="GObject" type-name="GduDetailsElement" get-type="gdu_details_element_get_type">
			<method name="get_action_text" symbol="gdu_details_element_get_action_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
				</parameters>
			</method>
			<method name="get_action_tooltip" symbol="gdu_details_element_get_action_tooltip">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
				</parameters>
			</method>
			<method name="get_action_uri" symbol="gdu_details_element_get_action_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
				</parameters>
			</method>
			<method name="get_heading" symbol="gdu_details_element_get_heading">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gdu_details_element_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
				</parameters>
			</method>
			<method name="get_is_spinning" symbol="gdu_details_element_get_is_spinning">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
				</parameters>
			</method>
			<method name="get_progress" symbol="gdu_details_element_get_progress">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="gdu_details_element_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
				</parameters>
			</method>
			<method name="get_time" symbol="gdu_details_element_get_time">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
				</parameters>
			</method>
			<method name="get_tooltip" symbol="gdu_details_element_get_tooltip">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
				</parameters>
			</method>
			<method name="get_widget" symbol="gdu_details_element_get_widget">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_details_element_new">
				<return-type type="GduDetailsElement*"/>
				<parameters>
					<parameter name="heading" type="gchar*"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="tooltip" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_action_text" symbol="gdu_details_element_set_action_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
					<parameter name="action_text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_action_tooltip" symbol="gdu_details_element_set_action_tooltip">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
					<parameter name="action_tooltip" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_action_uri" symbol="gdu_details_element_set_action_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
					<parameter name="action_uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_heading" symbol="gdu_details_element_set_heading">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
					<parameter name="heading" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_icon" symbol="gdu_details_element_set_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
					<parameter name="icon" type="GIcon*"/>
				</parameters>
			</method>
			<method name="set_is_spinning" symbol="gdu_details_element_set_is_spinning">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
					<parameter name="is_spinning" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_progress" symbol="gdu_details_element_set_progress">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
					<parameter name="progress" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_text" symbol="gdu_details_element_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_time" symbol="gdu_details_element_set_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
					<parameter name="time" type="guint64"/>
				</parameters>
			</method>
			<method name="set_tooltip" symbol="gdu_details_element_set_tooltip">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
					<parameter name="tooltip" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_widget" symbol="gdu_details_element_set_widget">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
					<parameter name="widget" type="GtkWidget*"/>
				</parameters>
			</method>
			<property name="action-text" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="action-tooltip" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="action-uri" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="heading" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="icon" type="GIcon*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="is-spinning" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="progress" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="time" type="guint64" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="tooltip" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="widget" type="GtkWidget*" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="activated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
					<parameter name="uri" type="char*"/>
				</parameters>
			</signal>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GduDetailsElement*"/>
				</parameters>
			</signal>
		</object>
		<object name="GduDetailsTable" parent="GtkHBox" type-name="GduDetailsTable" get-type="gdu_details_table_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkOrientable"/>
			</implements>
			<method name="get_elements" symbol="gdu_details_table_get_elements">
				<return-type type="GPtrArray*"/>
				<parameters>
					<parameter name="table" type="GduDetailsTable*"/>
				</parameters>
			</method>
			<method name="get_num_columns" symbol="gdu_details_table_get_num_columns">
				<return-type type="guint"/>
				<parameters>
					<parameter name="table" type="GduDetailsTable*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_details_table_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="num_columns" type="guint"/>
					<parameter name="elements" type="GPtrArray*"/>
				</parameters>
			</constructor>
			<method name="set_elements" symbol="gdu_details_table_set_elements">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="GduDetailsTable*"/>
					<parameter name="elements" type="GPtrArray*"/>
				</parameters>
			</method>
			<method name="set_num_columns" symbol="gdu_details_table_set_num_columns">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="GduDetailsTable*"/>
					<parameter name="num_columns" type="guint"/>
				</parameters>
			</method>
			<property name="elements" type="GPtrArray*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="num-columns" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="GduDialog" parent="GtkDialog" type-name="GduDialog" get-type="gdu_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_device" symbol="gdu_dialog_get_device">
				<return-type type="GduDevice*"/>
				<parameters>
					<parameter name="dialog" type="GduDialog*"/>
				</parameters>
			</method>
			<method name="get_pool" symbol="gdu_dialog_get_pool">
				<return-type type="GduPool*"/>
				<parameters>
					<parameter name="dialog" type="GduDialog*"/>
				</parameters>
			</method>
			<method name="get_presentable" symbol="gdu_dialog_get_presentable">
				<return-type type="GduPresentable*"/>
				<parameters>
					<parameter name="dialog" type="GduDialog*"/>
				</parameters>
			</method>
			<property name="drive-device" type="GduDevice*" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="presentable" type="GduPresentable*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="volume-device" type="GduDevice*" readable="0" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GduDiskSelectionWidget" parent="GtkVBox" type-name="GduDiskSelectionWidget" get-type="gdu_disk_selection_widget_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkOrientable"/>
			</implements>
			<method name="get_component_size" symbol="gdu_disk_selection_widget_get_component_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="widget" type="GduDiskSelectionWidget*"/>
				</parameters>
			</method>
			<method name="get_largest_segment_for_all" symbol="gdu_disk_selection_widget_get_largest_segment_for_all">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="widget" type="GduDiskSelectionWidget*"/>
				</parameters>
			</method>
			<method name="get_largest_segment_for_selected" symbol="gdu_disk_selection_widget_get_largest_segment_for_selected">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="widget" type="GduDiskSelectionWidget*"/>
				</parameters>
			</method>
			<method name="get_num_available_disks" symbol="gdu_disk_selection_widget_get_num_available_disks">
				<return-type type="guint"/>
				<parameters>
					<parameter name="widget" type="GduDiskSelectionWidget*"/>
				</parameters>
			</method>
			<method name="get_selected_drives" symbol="gdu_disk_selection_widget_get_selected_drives">
				<return-type type="GPtrArray*"/>
				<parameters>
					<parameter name="widget" type="GduDiskSelectionWidget*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_disk_selection_widget_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="pool" type="GduPool*"/>
					<parameter name="flags" type="GduDiskSelectionWidgetFlags"/>
				</parameters>
			</constructor>
			<method name="set_component_size" symbol="gdu_disk_selection_widget_set_component_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="GduDiskSelectionWidget*"/>
					<parameter name="component_size" type="guint64"/>
				</parameters>
			</method>
			<property name="component-size" type="guint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="flags" type="GduDiskSelectionWidgetFlags" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="largest-segment-for-all" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="largest-segment-for-selected" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="num-available-disks" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="pool" type="GduPool*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="selected-drives" type="GPtrArray*" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="GduDiskSelectionWidget*"/>
				</parameters>
			</signal>
			<signal name="is-drive-ignored" when="LAST">
				<return-type type="char*"/>
				<parameters>
					<parameter name="widget" type="GduDiskSelectionWidget*"/>
					<parameter name="drive" type="GduDrive*"/>
				</parameters>
			</signal>
		</object>
		<object name="GduDriveBenchmarkDialog" parent="GduDialog" type-name="GduDriveBenchmarkDialog" get-type="gdu_drive_benchmark_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="gdu_drive_benchmark_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="drive" type="GduDrive*"/>
				</parameters>
			</constructor>
		</object>
		<object name="GduEditLinuxLvm2Dialog" parent="GduDialog" type-name="GduEditLinuxLvm2Dialog" get-type="gdu_edit_linux_lvm2_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="gdu_edit_linux_lvm2_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="vg" type="GduLinuxLvm2VolumeGroup*"/>
				</parameters>
			</constructor>
			<signal name="new-button-clicked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GduEditLinuxLvm2Dialog*"/>
				</parameters>
			</signal>
			<signal name="remove-button-clicked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GduEditLinuxLvm2Dialog*"/>
					<parameter name="pv_uuid" type="char*"/>
				</parameters>
			</signal>
		</object>
		<object name="GduEditLinuxMdDialog" parent="GduDialog" type-name="GduEditLinuxMdDialog" get-type="gdu_edit_linux_md_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="gdu_edit_linux_md_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="linux_md_drive" type="GduLinuxMdDrive*"/>
				</parameters>
			</constructor>
			<signal name="add-spare-button-clicked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GduEditLinuxMdDialog*"/>
				</parameters>
			</signal>
			<signal name="attach-button-clicked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GduEditLinuxMdDialog*"/>
					<parameter name="slave" type="GduDevice*"/>
				</parameters>
			</signal>
			<signal name="expand-button-clicked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GduEditLinuxMdDialog*"/>
				</parameters>
			</signal>
			<signal name="remove-button-clicked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GduEditLinuxMdDialog*"/>
					<parameter name="slave" type="GduDevice*"/>
				</parameters>
			</signal>
		</object>
		<object name="GduEditNameDialog" parent="GduDialog" type-name="GduEditNameDialog" get-type="gdu_edit_name_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_name" symbol="gdu_edit_name_dialog_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="GduEditNameDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_edit_name_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="presentable" type="GduPresentable*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="name_max_bytes" type="guint"/>
					<parameter name="message" type="gchar*"/>
					<parameter name="entry_mnemonic" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_name" symbol="gdu_edit_name_dialog_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GduEditNameDialog*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<property name="entry-mnemonic" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="message" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name-max-bytes" type="guint" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GduEditPartitionDialog" parent="GduDialog" type-name="GduEditPartitionDialog" get-type="gdu_edit_partition_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_partition_flags" symbol="gdu_edit_partition_dialog_get_partition_flags">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="dialog" type="GduEditPartitionDialog*"/>
				</parameters>
			</method>
			<method name="get_partition_label" symbol="gdu_edit_partition_dialog_get_partition_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="GduEditPartitionDialog*"/>
				</parameters>
			</method>
			<method name="get_partition_type" symbol="gdu_edit_partition_dialog_get_partition_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="GduEditPartitionDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_edit_partition_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="volume" type="GduPresentable*"/>
				</parameters>
			</constructor>
			<property name="partition-flags" type="GStrv*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="partition-label" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="partition-type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GduErrorDialog" parent="GduDialog" type-name="GduErrorDialog" get-type="gdu_error_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="gdu_error_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="presentable" type="GduPresentable*"/>
					<parameter name="message" type="gchar*"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</constructor>
			<constructor name="new_for_drive" symbol="gdu_error_dialog_new_for_drive">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="message" type="gchar*"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</constructor>
			<constructor name="new_for_volume" symbol="gdu_error_dialog_new_for_volume">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="message" type="gchar*"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</constructor>
			<property name="error" type="GduGError*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="message" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GduFormatDialog" parent="GduDialog" type-name="GduFormatDialog" get-type="gdu_format_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_encrypt" symbol="gdu_format_dialog_get_encrypt">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dialog" type="GduFormatDialog*"/>
				</parameters>
			</method>
			<method name="get_fs_label" symbol="gdu_format_dialog_get_fs_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="GduFormatDialog*"/>
				</parameters>
			</method>
			<method name="get_fs_options" symbol="gdu_format_dialog_get_fs_options">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="dialog" type="GduFormatDialog*"/>
				</parameters>
			</method>
			<method name="get_fs_type" symbol="gdu_format_dialog_get_fs_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="GduFormatDialog*"/>
				</parameters>
			</method>
			<method name="get_table" symbol="gdu_format_dialog_get_table">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="dialog" type="GduFormatDialog*"/>
				</parameters>
			</method>
			<method name="get_take_ownership" symbol="gdu_format_dialog_get_take_ownership">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dialog" type="GduFormatDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_format_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="presentable" type="GduPresentable*"/>
					<parameter name="flags" type="GduFormatDialogFlags"/>
				</parameters>
			</constructor>
			<constructor name="new_for_drive" symbol="gdu_format_dialog_new_for_drive">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="flags" type="GduFormatDialogFlags"/>
				</parameters>
			</constructor>
			<constructor name="new_for_volume" symbol="gdu_format_dialog_new_for_volume">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="device" type="GduDevice*"/>
					<parameter name="flags" type="GduFormatDialogFlags"/>
				</parameters>
			</constructor>
			<property name="affirmative-button-mnemonic" type="char*" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="encrypt" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="flags" type="GduFormatDialogFlags" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="fs-label" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="fs-options" type="GStrv*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="fs-type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="take-ownership" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GduPartitionDialog" parent="GduDialog" type-name="GduPartitionDialog" get-type="gdu_partition_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_scheme" symbol="gdu_partition_dialog_get_scheme">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="GduPartitionDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_partition_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</constructor>
			<constructor name="new_for_drive" symbol="gdu_partition_dialog_new_for_drive">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="device" type="GduDevice*"/>
				</parameters>
			</constructor>
			<property name="scheme" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GduPoolTreeModel" parent="GtkTreeStore" type-name="GduPoolTreeModel" get-type="gdu_pool_tree_model_get_type">
			<implements>
				<interface name="GtkTreeModel"/>
				<interface name="GtkTreeDragSource"/>
				<interface name="GtkTreeDragDest"/>
				<interface name="GtkTreeSortable"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_iter_for_presentable" symbol="gdu_pool_tree_model_get_iter_for_presentable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GduPoolTreeModel*"/>
					<parameter name="presentable" type="GduPresentable*"/>
					<parameter name="out_iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_pool_tree_model_new">
				<return-type type="GduPoolTreeModel*"/>
				<parameters>
					<parameter name="pools" type="GPtrArray*"/>
					<parameter name="root" type="GduPresentable*"/>
					<parameter name="flags" type="GduPoolTreeModelFlags"/>
				</parameters>
			</constructor>
			<method name="set_pools" symbol="gdu_pool_tree_model_set_pools">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GduPoolTreeModel*"/>
					<parameter name="pools" type="GPtrArray*"/>
				</parameters>
			</method>
			<property name="flags" type="GduPoolTreeModelFlags" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="pools" type="GPtrArray*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="root" type="GduPresentable*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GduPoolTreeView" parent="GtkTreeView" type-name="GduPoolTreeView" get-type="gdu_pool_tree_view_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_selected_presentable" symbol="gdu_pool_tree_view_get_selected_presentable">
				<return-type type="GduPresentable*"/>
				<parameters>
					<parameter name="view" type="GduPoolTreeView*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_pool_tree_view_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="model" type="GduPoolTreeModel*"/>
					<parameter name="flags" type="GduPoolTreeViewFlags"/>
				</parameters>
			</constructor>
			<method name="select_first_presentable" symbol="gdu_pool_tree_view_select_first_presentable">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GduPoolTreeView*"/>
				</parameters>
			</method>
			<method name="select_presentable" symbol="gdu_pool_tree_view_select_presentable">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GduPoolTreeView*"/>
					<parameter name="presentable" type="GduPresentable*"/>
				</parameters>
			</method>
			<property name="flags" type="GduPoolTreeViewFlags" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="pool-tree-model" type="GduPoolTreeModel*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GduSizeWidget" parent="GtkHBox" type-name="GduSizeWidget" get-type="gdu_size_widget_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkOrientable"/>
			</implements>
			<method name="get_max_size" symbol="gdu_size_widget_get_max_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="widget" type="GduSizeWidget*"/>
				</parameters>
			</method>
			<method name="get_min_size" symbol="gdu_size_widget_get_min_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="widget" type="GduSizeWidget*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gdu_size_widget_get_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="widget" type="GduSizeWidget*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_size_widget_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="size" type="guint64"/>
					<parameter name="min_size" type="guint64"/>
					<parameter name="max_size" type="guint64"/>
				</parameters>
			</constructor>
			<method name="set_max_size" symbol="gdu_size_widget_set_max_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="GduSizeWidget*"/>
					<parameter name="max_size" type="guint64"/>
				</parameters>
			</method>
			<method name="set_min_size" symbol="gdu_size_widget_set_min_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="GduSizeWidget*"/>
					<parameter name="min_size" type="guint64"/>
				</parameters>
			</method>
			<method name="set_size" symbol="gdu_size_widget_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="GduSizeWidget*"/>
					<parameter name="size" type="guint64"/>
				</parameters>
			</method>
			<property name="max-size" type="guint64" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="min-size" type="guint64" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="size" type="guint64" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="GduSizeWidget*"/>
				</parameters>
			</signal>
		</object>
		<object name="GduSpinner" parent="GtkDrawingArea" type-name="GduSpinner" get-type="gdu_spinner_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="gdu_spinner_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="start" symbol="gdu_spinner_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="spinner" type="GduSpinner*"/>
				</parameters>
			</method>
			<method name="stop" symbol="gdu_spinner_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="spinner" type="GduSpinner*"/>
				</parameters>
			</method>
			<property name="color" type="char*" readable="0" writable="1" construct="1" construct-only="0"/>
			<property name="lines" type="guint" readable="0" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GduTimeLabel" parent="GtkLabel" type-name="GduTimeLabel" get-type="gdu_time_label_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="gdu_time_label_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="time" type="GTimeVal*"/>
				</parameters>
			</constructor>
			<method name="set_time" symbol="gdu_time_label_set_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="time_label" type="GduTimeLabel*"/>
					<parameter name="time" type="GTimeVal*"/>
				</parameters>
			</method>
			<property name="time" type="GduTimeLabelBoxedGTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GduVolumeGrid" parent="GtkDrawingArea" type-name="GduVolumeGrid" get-type="gdu_volume_grid_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_selected" symbol="gdu_volume_grid_get_selected">
				<return-type type="GduPresentable*"/>
				<parameters>
					<parameter name="grid" type="GduVolumeGrid*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdu_volume_grid_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="drive" type="GduDrive*"/>
				</parameters>
			</constructor>
			<method name="select" symbol="gdu_volume_grid_select">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="grid" type="GduVolumeGrid*"/>
					<parameter name="volume" type="GduPresentable*"/>
				</parameters>
			</method>
			<property name="drive" type="GduDrive*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="grid" type="GduVolumeGrid*"/>
				</parameters>
			</signal>
		</object>
	</namespace>
</api>
