<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gdl">
		<struct name="GdlDockRequest">
			<field name="applicant" type="GdlDockObject*"/>
			<field name="target" type="GdlDockObject*"/>
			<field name="position" type="GdlDockPlacement"/>
			<field name="rect" type="GdkRectangle"/>
			<field name="extra" type="GValue"/>
		</struct>
		<struct name="GdlPixmap">
			<field name="path" type="char*"/>
			<field name="fname" type="char*"/>
			<field name="pixbuf" type="char*"/>
		</struct>
		<enum name="GdlDockBarStyle" type-name="GdlDockBarStyle" get-type="gdl_dock_bar_style_get_type">
			<member name="GDL_DOCK_BAR_ICONS" value="0"/>
			<member name="GDL_DOCK_BAR_TEXT" value="1"/>
			<member name="GDL_DOCK_BAR_BOTH" value="2"/>
			<member name="GDL_DOCK_BAR_AUTO" value="3"/>
		</enum>
		<enum name="GdlDockPlacement" type-name="GdlDockPlacement" get-type="gdl_dock_placement_get_type">
			<member name="GDL_DOCK_NONE" value="0"/>
			<member name="GDL_DOCK_TOP" value="1"/>
			<member name="GDL_DOCK_BOTTOM" value="2"/>
			<member name="GDL_DOCK_RIGHT" value="3"/>
			<member name="GDL_DOCK_LEFT" value="4"/>
			<member name="GDL_DOCK_CENTER" value="5"/>
			<member name="GDL_DOCK_FLOATING" value="6"/>
		</enum>
		<enum name="GdlSwitcherStyle" type-name="GdlSwitcherStyle" get-type="gdl_switcher_style_get_type">
			<member name="GDL_SWITCHER_STYLE_TEXT" value="0"/>
			<member name="GDL_SWITCHER_STYLE_ICON" value="1"/>
			<member name="GDL_SWITCHER_STYLE_BOTH" value="2"/>
			<member name="GDL_SWITCHER_STYLE_TOOLBAR" value="3"/>
			<member name="GDL_SWITCHER_STYLE_TABS" value="4"/>
			<member name="GDL_SWITCHER_STYLE_NONE" value="5"/>
		</enum>
		<flags name="GdlDockItemBehavior" type-name="GdlDockItemBehavior" get-type="gdl_dock_item_behavior_get_type">
			<member name="GDL_DOCK_ITEM_BEH_NORMAL" value="0"/>
			<member name="GDL_DOCK_ITEM_BEH_NEVER_FLOATING" value="1"/>
			<member name="GDL_DOCK_ITEM_BEH_NEVER_VERTICAL" value="2"/>
			<member name="GDL_DOCK_ITEM_BEH_NEVER_HORIZONTAL" value="4"/>
			<member name="GDL_DOCK_ITEM_BEH_LOCKED" value="8"/>
			<member name="GDL_DOCK_ITEM_BEH_CANT_DOCK_TOP" value="16"/>
			<member name="GDL_DOCK_ITEM_BEH_CANT_DOCK_BOTTOM" value="32"/>
			<member name="GDL_DOCK_ITEM_BEH_CANT_DOCK_LEFT" value="64"/>
			<member name="GDL_DOCK_ITEM_BEH_CANT_DOCK_RIGHT" value="128"/>
			<member name="GDL_DOCK_ITEM_BEH_CANT_DOCK_CENTER" value="256"/>
			<member name="GDL_DOCK_ITEM_BEH_CANT_CLOSE" value="512"/>
			<member name="GDL_DOCK_ITEM_BEH_CANT_ICONIFY" value="1024"/>
			<member name="GDL_DOCK_ITEM_BEH_NO_GRIP" value="2048"/>
		</flags>
		<flags name="GdlDockItemFlags" type-name="GdlDockItemFlags" get-type="gdl_dock_item_flags_get_type">
			<member name="GDL_DOCK_IN_DRAG" value="256"/>
			<member name="GDL_DOCK_IN_PREDRAG" value="512"/>
			<member name="GDL_DOCK_ICONIFIED" value="1024"/>
			<member name="GDL_DOCK_USER_ACTION" value="2048"/>
		</flags>
		<flags name="GdlDockObjectFlags" type-name="GdlDockObjectFlags" get-type="gdl_dock_object_flags_get_type">
			<member name="GDL_DOCK_AUTOMATIC" value="1"/>
			<member name="GDL_DOCK_ATTACHED" value="2"/>
			<member name="GDL_DOCK_IN_REFLOW" value="4"/>
			<member name="GDL_DOCK_IN_DETACH" value="8"/>
		</flags>
		<flags name="GdlDockParamFlags" type-name="GdlDockParamFlags" get-type="gdl_dock_param_flags_get_type">
			<member name="GDL_DOCK_PARAM_EXPORT" value="256"/>
			<member name="GDL_DOCK_PARAM_AFTER" value="512"/>
		</flags>
		<object name="GdlDock" parent="GdlDockObject" type-name="GdlDock" get-type="gdl_dock_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="add_floating_item" symbol="gdl_dock_add_floating_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="dock" type="GdlDock*"/>
					<parameter name="item" type="GdlDockItem*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<method name="add_item" symbol="gdl_dock_add_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="dock" type="GdlDock*"/>
					<parameter name="item" type="GdlDockItem*"/>
					<parameter name="place" type="GdlDockPlacement"/>
				</parameters>
			</method>
			<method name="get_item_by_name" symbol="gdl_dock_get_item_by_name">
				<return-type type="GdlDockItem*"/>
				<parameters>
					<parameter name="dock" type="GdlDock*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_named_items" symbol="gdl_dock_get_named_items">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="dock" type="GdlDock*"/>
				</parameters>
			</method>
			<method name="get_placeholder_by_name" symbol="gdl_dock_get_placeholder_by_name">
				<return-type type="GdlDockPlaceholder*"/>
				<parameters>
					<parameter name="dock" type="GdlDock*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdl_dock_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_from" symbol="gdl_dock_new_from">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="original" type="GdlDock*"/>
					<parameter name="floating" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="param_get_type" symbol="gdl_dock_param_get_type">
				<return-type type="GType"/>
			</method>
			<method name="xor_rect" symbol="gdl_dock_xor_rect">
				<return-type type="void"/>
				<parameters>
					<parameter name="dock" type="GdlDock*"/>
					<parameter name="rect" type="GdkRectangle*"/>
				</parameters>
			</method>
			<property name="default-title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="floating" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="floatx" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="floaty" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="height" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="width" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="layout-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="dock" type="GdlDock*"/>
				</parameters>
			</signal>
			<field name="root" type="GdlDockObject*"/>
		</object>
		<object name="GdlDockBar" parent="GtkBox" type-name="GdlDockBar" get-type="gdl_dock_bar_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkOrientable"/>
			</implements>
			<method name="get_orientation" symbol="gdl_dock_bar_get_orientation">
				<return-type type="GtkOrientation"/>
				<parameters>
					<parameter name="dockbar" type="GdlDockBar*"/>
				</parameters>
			</method>
			<method name="get_style" symbol="gdl_dock_bar_get_style">
				<return-type type="GdlDockBarStyle"/>
				<parameters>
					<parameter name="dockbar" type="GdlDockBar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdl_dock_bar_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="dock" type="GdlDock*"/>
				</parameters>
			</constructor>
			<method name="set_orientation" symbol="gdl_dock_bar_set_orientation">
				<return-type type="void"/>
				<parameters>
					<parameter name="dockbar" type="GdlDockBar*"/>
					<parameter name="orientation" type="GtkOrientation"/>
				</parameters>
			</method>
			<method name="set_style" symbol="gdl_dock_bar_set_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="dockbar" type="GdlDockBar*"/>
					<parameter name="style" type="GdlDockBarStyle"/>
				</parameters>
			</method>
			<property name="dockbar-style" type="GdlDockBarStyle" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="master" type="GdlDockMaster*" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="dock" type="GdlDock*"/>
		</object>
		<object name="GdlDockItem" parent="GdlDockObject" type-name="GdlDockItem" get-type="gdl_dock_item_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="bind" symbol="gdl_dock_item_bind">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
					<parameter name="dock" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="dock_to" symbol="gdl_dock_item_dock_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
					<parameter name="target" type="GdlDockItem*"/>
					<parameter name="position" type="GdlDockPlacement"/>
					<parameter name="docking_param" type="gint"/>
				</parameters>
			</method>
			<method name="get_grip" symbol="gdl_dock_item_get_grip">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</method>
			<method name="get_tablabel" symbol="gdl_dock_item_get_tablabel">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</method>
			<method name="hide_grip" symbol="gdl_dock_item_hide_grip">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</method>
			<method name="hide_item" symbol="gdl_dock_item_hide_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</method>
			<method name="iconify_item" symbol="gdl_dock_item_iconify_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</method>
			<method name="lock" symbol="gdl_dock_item_lock">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdl_dock_item_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="long_name" type="gchar*"/>
					<parameter name="behavior" type="GdlDockItemBehavior"/>
				</parameters>
			</constructor>
			<constructor name="new_with_stock" symbol="gdl_dock_item_new_with_stock">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="long_name" type="gchar*"/>
					<parameter name="stock_id" type="gchar*"/>
					<parameter name="behavior" type="GdlDockItemBehavior"/>
				</parameters>
			</constructor>
			<method name="notify_selected" symbol="gdl_dock_item_notify_selected">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</method>
			<method name="preferred_size" symbol="gdl_dock_item_preferred_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
					<parameter name="req" type="GtkRequisition*"/>
				</parameters>
			</method>
			<method name="set_default_position" symbol="gdl_dock_item_set_default_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
					<parameter name="reference" type="GdlDockObject*"/>
				</parameters>
			</method>
			<method name="set_orientation" symbol="gdl_dock_item_set_orientation">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
					<parameter name="orientation" type="GtkOrientation"/>
				</parameters>
			</method>
			<method name="set_tablabel" symbol="gdl_dock_item_set_tablabel">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
					<parameter name="tablabel" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="show_grip" symbol="gdl_dock_item_show_grip">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</method>
			<method name="show_item" symbol="gdl_dock_item_show_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</method>
			<method name="unbind" symbol="gdl_dock_item_unbind">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</method>
			<method name="unlock" symbol="gdl_dock_item_unlock">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</method>
			<property name="behavior" type="GdlDockItemBehavior" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="locked" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="orientation" type="GtkOrientation" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="preferred-height" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="preferred-width" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="resize" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="dock-drag-begin" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</signal>
			<signal name="dock-drag-end" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
					<parameter name="cancelled" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="dock-drag-motion" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</signal>
			<signal name="selected" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockItem*"/>
				</parameters>
			</signal>
			<vfunc name="set_orientation">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
					<parameter name="orientation" type="GtkOrientation"/>
				</parameters>
			</vfunc>
			<field name="child" type="GtkWidget*"/>
			<field name="behavior" type="GdlDockItemBehavior"/>
			<field name="orientation" type="GtkOrientation"/>
			<field name="resize" type="guint"/>
			<field name="dragoff_x" type="gint"/>
			<field name="dragoff_y" type="gint"/>
		</object>
		<object name="GdlDockItemGrip" parent="GtkContainer" type-name="GdlDockItemGrip" get-type="gdl_dock_item_grip_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="hide_handle" symbol="gdl_dock_item_grip_hide_handle">
				<return-type type="void"/>
				<parameters>
					<parameter name="grip" type="GdlDockItemGrip*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdl_dock_item_grip_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="item" type="GdlDockItem*"/>
				</parameters>
			</constructor>
			<method name="set_label" symbol="gdl_dock_item_grip_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="grip" type="GdlDockItemGrip*"/>
					<parameter name="label" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="show_handle" symbol="gdl_dock_item_grip_show_handle">
				<return-type type="void"/>
				<parameters>
					<parameter name="grip" type="GdlDockItemGrip*"/>
				</parameters>
			</method>
			<property name="item" type="GdlDockItem*" readable="0" writable="1" construct="0" construct-only="1"/>
			<field name="item" type="GdlDockItem*"/>
			<field name="title_window" type="GdkWindow*"/>
		</object>
		<object name="GdlDockLayout" parent="GObject" type-name="GdlDockLayout" get-type="gdl_dock_layout_get_type">
			<method name="attach" symbol="gdl_dock_layout_attach">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="GdlDockLayout*"/>
					<parameter name="master" type="GdlDockMaster*"/>
				</parameters>
			</method>
			<method name="delete_layout" symbol="gdl_dock_layout_delete_layout">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="GdlDockLayout*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_items_ui" symbol="gdl_dock_layout_get_items_ui">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="layout" type="GdlDockLayout*"/>
				</parameters>
			</method>
			<method name="get_layouts" symbol="gdl_dock_layout_get_layouts">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="layout" type="GdlDockLayout*"/>
					<parameter name="include_default" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_layouts_ui" symbol="gdl_dock_layout_get_layouts_ui">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="layout" type="GdlDockLayout*"/>
				</parameters>
			</method>
			<method name="get_ui" symbol="gdl_dock_layout_get_ui">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="layout" type="GdlDockLayout*"/>
				</parameters>
			</method>
			<method name="is_dirty" symbol="gdl_dock_layout_is_dirty">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="GdlDockLayout*"/>
				</parameters>
			</method>
			<method name="load_from_file" symbol="gdl_dock_layout_load_from_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="GdlDockLayout*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="load_layout" symbol="gdl_dock_layout_load_layout">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="GdlDockLayout*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdl_dock_layout_new">
				<return-type type="GdlDockLayout*"/>
				<parameters>
					<parameter name="dock" type="GdlDock*"/>
				</parameters>
			</constructor>
			<method name="run_manager" symbol="gdl_dock_layout_run_manager">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="GdlDockLayout*"/>
				</parameters>
			</method>
			<method name="save_layout" symbol="gdl_dock_layout_save_layout">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="GdlDockLayout*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="save_to_file" symbol="gdl_dock_layout_save_to_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="GdlDockLayout*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<property name="dirty" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="master" type="GdlDockMaster*" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="dirty" type="gboolean"/>
			<field name="master" type="GdlDockMaster*"/>
		</object>
		<object name="GdlDockMaster" parent="GObject" type-name="GdlDockMaster" get-type="gdl_dock_master_get_type">
			<method name="add" symbol="gdl_dock_master_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="master" type="GdlDockMaster*"/>
					<parameter name="object" type="GdlDockObject*"/>
				</parameters>
			</method>
			<method name="foreach" symbol="gdl_dock_master_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="master" type="GdlDockMaster*"/>
					<parameter name="function" type="GFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="foreach_toplevel" symbol="gdl_dock_master_foreach_toplevel">
				<return-type type="void"/>
				<parameters>
					<parameter name="master" type="GdlDockMaster*"/>
					<parameter name="include_controller" type="gboolean"/>
					<parameter name="function" type="GFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_controller" symbol="gdl_dock_master_get_controller">
				<return-type type="GdlDockObject*"/>
				<parameters>
					<parameter name="master" type="GdlDockMaster*"/>
				</parameters>
			</method>
			<method name="get_object" symbol="gdl_dock_master_get_object">
				<return-type type="GdlDockObject*"/>
				<parameters>
					<parameter name="master" type="GdlDockMaster*"/>
					<parameter name="nick_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove" symbol="gdl_dock_master_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="master" type="GdlDockMaster*"/>
					<parameter name="object" type="GdlDockObject*"/>
				</parameters>
			</method>
			<method name="set_controller" symbol="gdl_dock_master_set_controller">
				<return-type type="void"/>
				<parameters>
					<parameter name="master" type="GdlDockMaster*"/>
					<parameter name="new_controller" type="GdlDockObject*"/>
				</parameters>
			</method>
			<property name="default-title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="locked" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="switcher-style" type="GdlSwitcherStyle" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="layout-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="master" type="GdlDockMaster*"/>
				</parameters>
			</signal>
			<field name="dock_objects" type="GHashTable*"/>
			<field name="toplevel_docks" type="GList*"/>
			<field name="controller" type="GdlDockObject*"/>
			<field name="dock_number" type="gint"/>
		</object>
		<object name="GdlDockObject" parent="GtkContainer" type-name="GdlDockObject" get-type="gdl_dock_object_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="bind" symbol="gdl_dock_object_bind">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="master" type="GObject*"/>
				</parameters>
			</method>
			<method name="child_placement" symbol="gdl_dock_object_child_placement">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="child" type="GdlDockObject*"/>
					<parameter name="placement" type="GdlDockPlacement*"/>
				</parameters>
			</method>
			<method name="detach" symbol="gdl_dock_object_detach">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="recursive" type="gboolean"/>
				</parameters>
			</method>
			<method name="dock" symbol="gdl_dock_object_dock">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="requestor" type="GdlDockObject*"/>
					<parameter name="position" type="GdlDockPlacement"/>
					<parameter name="other_data" type="GValue*"/>
				</parameters>
			</method>
			<method name="dock_request" symbol="gdl_dock_object_dock_request">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="request" type="GdlDockRequest*"/>
				</parameters>
			</method>
			<method name="freeze" symbol="gdl_dock_object_freeze">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
				</parameters>
			</method>
			<method name="get_parent_object" symbol="gdl_dock_object_get_parent_object">
				<return-type type="GdlDockObject*"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
				</parameters>
			</method>
			<method name="get_toplevel" symbol="gdl_dock_object_get_toplevel">
				<return-type type="GdlDock*"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
				</parameters>
			</method>
			<method name="is_bound" symbol="gdl_dock_object_is_bound">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
				</parameters>
			</method>
			<method name="is_compound" symbol="gdl_dock_object_is_compound">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
				</parameters>
			</method>
			<method name="nick_from_type" symbol="gdl_dock_object_nick_from_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="present" symbol="gdl_dock_object_present">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="child" type="GdlDockObject*"/>
				</parameters>
			</method>
			<method name="reduce" symbol="gdl_dock_object_reduce">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
				</parameters>
			</method>
			<method name="reorder" symbol="gdl_dock_object_reorder">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="child" type="GdlDockObject*"/>
					<parameter name="new_position" type="GdlDockPlacement"/>
					<parameter name="other_data" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_type_for_nick" symbol="gdl_dock_object_set_type_for_nick">
				<return-type type="GType"/>
				<parameters>
					<parameter name="nick" type="gchar*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="thaw" symbol="gdl_dock_object_thaw">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
				</parameters>
			</method>
			<method name="type_from_nick" symbol="gdl_dock_object_type_from_nick">
				<return-type type="GType"/>
				<parameters>
					<parameter name="nick" type="gchar*"/>
				</parameters>
			</method>
			<method name="unbind" symbol="gdl_dock_object_unbind">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
				</parameters>
			</method>
			<property name="long-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="master" type="GdlDockMaster*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="stock-id" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="detach" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="recursive" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="dock" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="requestor" type="GdlDockObject*"/>
					<parameter name="position" type="GdlDockPlacement"/>
					<parameter name="other_data" type="GValue*"/>
				</parameters>
			</signal>
			<vfunc name="child_placement">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="child" type="GdlDockObject*"/>
					<parameter name="placement" type="GdlDockPlacement*"/>
				</parameters>
			</vfunc>
			<vfunc name="dock_request">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="request" type="GdlDockRequest*"/>
				</parameters>
			</vfunc>
			<vfunc name="present">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="child" type="GdlDockObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="reduce">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="reorder">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="child" type="GdlDockObject*"/>
					<parameter name="new_position" type="GdlDockPlacement"/>
					<parameter name="other_data" type="GValue*"/>
				</parameters>
			</vfunc>
			<field name="flags" type="GdlDockObjectFlags"/>
			<field name="freeze_count" type="gint"/>
			<field name="master" type="GObject*"/>
			<field name="name" type="gchar*"/>
			<field name="long_name" type="gchar*"/>
			<field name="stock_id" type="gchar*"/>
			<field name="reduce_pending" type="gboolean"/>
		</object>
		<object name="GdlDockPlaceholder" parent="GdlDockObject" type-name="GdlDockPlaceholder" get-type="gdl_dock_placeholder_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="attach" symbol="gdl_dock_placeholder_attach">
				<return-type type="void"/>
				<parameters>
					<parameter name="ph" type="GdlDockPlaceholder*"/>
					<parameter name="object" type="GdlDockObject*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdl_dock_placeholder_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="object" type="GdlDockObject*"/>
					<parameter name="position" type="GdlDockPlacement"/>
					<parameter name="sticky" type="gboolean"/>
				</parameters>
			</constructor>
			<property name="floating" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="floatx" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="floaty" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="height" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="host" type="GdlDockObject*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="next-placement" type="GdlDockPlacement" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sticky" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="width" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<constant name="GDL_DOCK_MASTER_PROPERTY" type="char*" value="master"/>
		<constant name="GDL_DOCK_NAME_PROPERTY" type="char*" value="name"/>
		<constant name="GDL_DOCK_OBJECT_FLAGS_SHIFT" type="int" value="8"/>
	</namespace>
</api>
