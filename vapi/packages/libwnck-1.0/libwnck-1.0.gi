<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Wnck">
		<function name="create_window_action_menu" symbol="wnck_create_window_action_menu">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="window" type="WnckWindow*"/>
			</parameters>
		</function>
		<function name="gtk_window_set_dock_type" symbol="wnck_gtk_window_set_dock_type">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GtkWindow*"/>
			</parameters>
		</function>
		<function name="pid_read_resource_usage" symbol="wnck_pid_read_resource_usage">
			<return-type type="void"/>
			<parameters>
				<parameter name="gdk_display" type="GdkDisplay*"/>
				<parameter name="pid" type="gulong"/>
				<parameter name="usage" type="WnckResourceUsage*"/>
			</parameters>
		</function>
		<function name="set_client_type" symbol="wnck_set_client_type">
			<return-type type="void"/>
			<parameters>
				<parameter name="ewmh_sourceindication_client_type" type="WnckClientType"/>
			</parameters>
		</function>
		<function name="xid_read_resource_usage" symbol="wnck_xid_read_resource_usage">
			<return-type type="void"/>
			<parameters>
				<parameter name="gdk_display" type="GdkDisplay*"/>
				<parameter name="xid" type="gulong"/>
				<parameter name="usage" type="WnckResourceUsage*"/>
			</parameters>
		</function>
		<callback name="WnckLoadIconFunction">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="icon_name" type="char*"/>
				<parameter name="size" type="int"/>
				<parameter name="flags" type="unsigned"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</callback>
		<struct name="WnckResourceUsage">
			<field name="total_bytes_estimate" type="gulong"/>
			<field name="pixmap_bytes" type="gulong"/>
			<field name="n_pixmaps" type="unsigned"/>
			<field name="n_windows" type="unsigned"/>
			<field name="n_gcs" type="unsigned"/>
			<field name="n_pictures" type="unsigned"/>
			<field name="n_glyphsets" type="unsigned"/>
			<field name="n_fonts" type="unsigned"/>
			<field name="n_colormap_entries" type="unsigned"/>
			<field name="n_passive_grabs" type="unsigned"/>
			<field name="n_cursors" type="unsigned"/>
			<field name="n_other" type="unsigned"/>
			<field name="pad1" type="unsigned"/>
			<field name="pad2" type="unsigned"/>
			<field name="pad3" type="unsigned"/>
			<field name="pad4" type="unsigned"/>
			<field name="pad5" type="unsigned"/>
			<field name="pad6" type="unsigned"/>
			<field name="pad7" type="unsigned"/>
			<field name="pad8" type="unsigned"/>
			<field name="pad9" type="unsigned"/>
		</struct>
		<struct name="WnckWorkspaceLayout">
			<field name="rows" type="int"/>
			<field name="cols" type="int"/>
			<field name="grid" type="int*"/>
			<field name="grid_area" type="int"/>
			<field name="current_row" type="int"/>
			<field name="current_col" type="int"/>
		</struct>
		<enum name="WnckClientType" type-name="WnckClientType" get-type="wnck_client_type_get_type">
			<member name="WNCK_CLIENT_TYPE_APPLICATION" value="1"/>
			<member name="WNCK_CLIENT_TYPE_PAGER" value="2"/>
		</enum>
		<enum name="WnckMotionDirection" type-name="WnckMotionDirection" get-type="wnck_motion_direction_get_type">
			<member name="WNCK_MOTION_UP" value="-1"/>
			<member name="WNCK_MOTION_DOWN" value="-2"/>
			<member name="WNCK_MOTION_LEFT" value="-3"/>
			<member name="WNCK_MOTION_RIGHT" value="-4"/>
		</enum>
		<enum name="WnckPagerDisplayMode" type-name="WnckPagerDisplayMode" get-type="wnck_pager_display_mode_get_type">
			<member name="WNCK_PAGER_DISPLAY_NAME" value="0"/>
			<member name="WNCK_PAGER_DISPLAY_CONTENT" value="1"/>
		</enum>
		<enum name="WnckTasklistGroupingType" type-name="WnckTasklistGroupingType" get-type="wnck_tasklist_grouping_type_get_type">
			<member name="WNCK_TASKLIST_NEVER_GROUP" value="0"/>
			<member name="WNCK_TASKLIST_AUTO_GROUP" value="1"/>
			<member name="WNCK_TASKLIST_ALWAYS_GROUP" value="2"/>
		</enum>
		<enum name="WnckWindowGravity" type-name="WnckWindowGravity" get-type="wnck_window_gravity_get_type">
			<member name="WNCK_WINDOW_GRAVITY_CURRENT" value="0"/>
			<member name="WNCK_WINDOW_GRAVITY_NORTHWEST" value="1"/>
			<member name="WNCK_WINDOW_GRAVITY_NORTH" value="2"/>
			<member name="WNCK_WINDOW_GRAVITY_NORTHEAST" value="3"/>
			<member name="WNCK_WINDOW_GRAVITY_WEST" value="4"/>
			<member name="WNCK_WINDOW_GRAVITY_CENTER" value="5"/>
			<member name="WNCK_WINDOW_GRAVITY_EAST" value="6"/>
			<member name="WNCK_WINDOW_GRAVITY_SOUTHWEST" value="7"/>
			<member name="WNCK_WINDOW_GRAVITY_SOUTH" value="8"/>
			<member name="WNCK_WINDOW_GRAVITY_SOUTHEAST" value="9"/>
			<member name="WNCK_WINDOW_GRAVITY_STATIC" value="10"/>
		</enum>
		<enum name="WnckWindowType" type-name="WnckWindowType" get-type="wnck_window_type_get_type">
			<member name="WNCK_WINDOW_NORMAL" value="0"/>
			<member name="WNCK_WINDOW_DESKTOP" value="1"/>
			<member name="WNCK_WINDOW_DOCK" value="2"/>
			<member name="WNCK_WINDOW_DIALOG" value="3"/>
			<member name="WNCK_WINDOW_TOOLBAR" value="4"/>
			<member name="WNCK_WINDOW_MENU" value="5"/>
			<member name="WNCK_WINDOW_UTILITY" value="6"/>
			<member name="WNCK_WINDOW_SPLASHSCREEN" value="7"/>
		</enum>
		<flags name="WnckWindowActions" type-name="WnckWindowActions" get-type="wnck_window_actions_get_type">
			<member name="WNCK_WINDOW_ACTION_MOVE" value="1"/>
			<member name="WNCK_WINDOW_ACTION_RESIZE" value="2"/>
			<member name="WNCK_WINDOW_ACTION_SHADE" value="4"/>
			<member name="WNCK_WINDOW_ACTION_STICK" value="8"/>
			<member name="WNCK_WINDOW_ACTION_MAXIMIZE_HORIZONTALLY" value="16"/>
			<member name="WNCK_WINDOW_ACTION_MAXIMIZE_VERTICALLY" value="32"/>
			<member name="WNCK_WINDOW_ACTION_CHANGE_WORKSPACE" value="64"/>
			<member name="WNCK_WINDOW_ACTION_CLOSE" value="128"/>
			<member name="WNCK_WINDOW_ACTION_UNMAXIMIZE_HORIZONTALLY" value="256"/>
			<member name="WNCK_WINDOW_ACTION_UNMAXIMIZE_VERTICALLY" value="512"/>
			<member name="WNCK_WINDOW_ACTION_UNSHADE" value="1024"/>
			<member name="WNCK_WINDOW_ACTION_UNSTICK" value="2048"/>
			<member name="WNCK_WINDOW_ACTION_MINIMIZE" value="4096"/>
			<member name="WNCK_WINDOW_ACTION_UNMINIMIZE" value="8192"/>
			<member name="WNCK_WINDOW_ACTION_MAXIMIZE" value="16384"/>
			<member name="WNCK_WINDOW_ACTION_UNMAXIMIZE" value="32768"/>
			<member name="WNCK_WINDOW_ACTION_FULLSCREEN" value="65536"/>
			<member name="WNCK_WINDOW_ACTION_ABOVE" value="131072"/>
			<member name="WNCK_WINDOW_ACTION_BELOW" value="262144"/>
		</flags>
		<flags name="WnckWindowMoveResizeMask" type-name="WnckWindowMoveResizeMask" get-type="wnck_window_move_resize_mask_get_type">
			<member name="WNCK_WINDOW_CHANGE_X" value="1"/>
			<member name="WNCK_WINDOW_CHANGE_Y" value="2"/>
			<member name="WNCK_WINDOW_CHANGE_WIDTH" value="4"/>
			<member name="WNCK_WINDOW_CHANGE_HEIGHT" value="8"/>
		</flags>
		<flags name="WnckWindowState" type-name="WnckWindowState" get-type="wnck_window_state_get_type">
			<member name="WNCK_WINDOW_STATE_MINIMIZED" value="1"/>
			<member name="WNCK_WINDOW_STATE_MAXIMIZED_HORIZONTALLY" value="2"/>
			<member name="WNCK_WINDOW_STATE_MAXIMIZED_VERTICALLY" value="4"/>
			<member name="WNCK_WINDOW_STATE_SHADED" value="8"/>
			<member name="WNCK_WINDOW_STATE_SKIP_PAGER" value="16"/>
			<member name="WNCK_WINDOW_STATE_SKIP_TASKLIST" value="32"/>
			<member name="WNCK_WINDOW_STATE_STICKY" value="64"/>
			<member name="WNCK_WINDOW_STATE_HIDDEN" value="128"/>
			<member name="WNCK_WINDOW_STATE_FULLSCREEN" value="256"/>
			<member name="WNCK_WINDOW_STATE_DEMANDS_ATTENTION" value="512"/>
			<member name="WNCK_WINDOW_STATE_URGENT" value="1024"/>
			<member name="WNCK_WINDOW_STATE_ABOVE" value="2048"/>
			<member name="WNCK_WINDOW_STATE_BELOW" value="4096"/>
		</flags>
		<object name="WnckActionMenu" parent="GtkMenu" type-name="WnckActionMenu" get-type="wnck_action_menu_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="wnck_action_menu_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</constructor>
			<property name="window" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<vfunc name="pad1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad4">
				<return-type type="void"/>
			</vfunc>
		</object>
		<object name="WnckApplication" parent="GObject" type-name="WnckApplication" get-type="wnck_application_get_type">
			<method name="get" symbol="wnck_application_get">
				<return-type type="WnckApplication*"/>
				<parameters>
					<parameter name="xwindow" type="gulong"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="wnck_application_get_icon">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</method>
			<method name="get_icon_is_fallback" symbol="wnck_application_get_icon_is_fallback">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</method>
			<method name="get_icon_name" symbol="wnck_application_get_icon_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</method>
			<method name="get_mini_icon" symbol="wnck_application_get_mini_icon">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</method>
			<method name="get_n_windows" symbol="wnck_application_get_n_windows">
				<return-type type="int"/>
				<parameters>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="wnck_application_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</method>
			<method name="get_pid" symbol="wnck_application_get_pid">
				<return-type type="int"/>
				<parameters>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</method>
			<method name="get_startup_id" symbol="wnck_application_get_startup_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</method>
			<method name="get_windows" symbol="wnck_application_get_windows">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</method>
			<method name="get_xid" symbol="wnck_application_get_xid">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</method>
			<signal name="icon-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</signal>
			<signal name="name-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</signal>
			<vfunc name="pad1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad4">
				<return-type type="void"/>
			</vfunc>
		</object>
		<object name="WnckClassGroup" parent="GObject" type-name="WnckClassGroup" get-type="wnck_class_group_get_type">
			<method name="get" symbol="wnck_class_group_get">
				<return-type type="WnckClassGroup*"/>
				<parameters>
					<parameter name="res_class" type="char*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="wnck_class_group_get_icon">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="class_group" type="WnckClassGroup*"/>
				</parameters>
			</method>
			<method name="get_mini_icon" symbol="wnck_class_group_get_mini_icon">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="class_group" type="WnckClassGroup*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="wnck_class_group_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="class_group" type="WnckClassGroup*"/>
				</parameters>
			</method>
			<method name="get_res_class" symbol="wnck_class_group_get_res_class">
				<return-type type="char*"/>
				<parameters>
					<parameter name="class_group" type="WnckClassGroup*"/>
				</parameters>
			</method>
			<method name="get_windows" symbol="wnck_class_group_get_windows">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="class_group" type="WnckClassGroup*"/>
				</parameters>
			</method>
			<signal name="icon-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="WnckClassGroup*"/>
				</parameters>
			</signal>
			<signal name="name-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="WnckClassGroup*"/>
				</parameters>
			</signal>
			<vfunc name="pad1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad4">
				<return-type type="void"/>
			</vfunc>
		</object>
		<object name="WnckPager" parent="GtkWidget" type-name="WnckPager" get-type="wnck_pager_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="wnck_pager_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</constructor>
			<method name="set_display_mode" symbol="wnck_pager_set_display_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="pager" type="WnckPager*"/>
					<parameter name="mode" type="WnckPagerDisplayMode"/>
				</parameters>
			</method>
			<method name="set_n_rows" symbol="wnck_pager_set_n_rows">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pager" type="WnckPager*"/>
					<parameter name="n_rows" type="int"/>
				</parameters>
			</method>
			<method name="set_orientation" symbol="wnck_pager_set_orientation">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pager" type="WnckPager*"/>
					<parameter name="orientation" type="GtkOrientation"/>
				</parameters>
			</method>
			<method name="set_screen" symbol="wnck_pager_set_screen">
				<return-type type="void"/>
				<parameters>
					<parameter name="pager" type="WnckPager*"/>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="set_shadow_type" symbol="wnck_pager_set_shadow_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="pager" type="WnckPager*"/>
					<parameter name="shadow_type" type="GtkShadowType"/>
				</parameters>
			</method>
			<method name="set_show_all" symbol="wnck_pager_set_show_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="pager" type="WnckPager*"/>
					<parameter name="show_all_workspaces" type="gboolean"/>
				</parameters>
			</method>
			<vfunc name="pad1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad4">
				<return-type type="void"/>
			</vfunc>
		</object>
		<object name="WnckScreen" parent="GObject" type-name="WnckScreen" get-type="wnck_screen_get_type">
			<method name="calc_workspace_layout" symbol="wnck_screen_calc_workspace_layout">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="num_workspaces" type="int"/>
					<parameter name="space_index" type="int"/>
					<parameter name="layout" type="WnckWorkspaceLayout*"/>
				</parameters>
			</method>
			<method name="change_workspace_count" symbol="wnck_screen_change_workspace_count">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="count" type="int"/>
				</parameters>
			</method>
			<method name="force_update" symbol="wnck_screen_force_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="free_workspace_layout" symbol="wnck_screen_free_workspace_layout">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="WnckWorkspaceLayout*"/>
				</parameters>
			</method>
			<method name="get" symbol="wnck_screen_get">
				<return-type type="WnckScreen*"/>
				<parameters>
					<parameter name="index" type="int"/>
				</parameters>
			</method>
			<method name="get_active_window" symbol="wnck_screen_get_active_window">
				<return-type type="WnckWindow*"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="get_active_workspace" symbol="wnck_screen_get_active_workspace">
				<return-type type="WnckWorkspace*"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="get_background_pixmap" symbol="wnck_screen_get_background_pixmap">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="get_default" symbol="wnck_screen_get_default">
				<return-type type="WnckScreen*"/>
			</method>
			<method name="get_for_root" symbol="wnck_screen_get_for_root">
				<return-type type="WnckScreen*"/>
				<parameters>
					<parameter name="root_window_id" type="gulong"/>
				</parameters>
			</method>
			<method name="get_height" symbol="wnck_screen_get_height">
				<return-type type="int"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="get_number" symbol="wnck_screen_get_number">
				<return-type type="int"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="get_previously_active_window" symbol="wnck_screen_get_previously_active_window">
				<return-type type="WnckWindow*"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="get_showing_desktop" symbol="wnck_screen_get_showing_desktop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="wnck_screen_get_width">
				<return-type type="int"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="get_window_manager_name" symbol="wnck_screen_get_window_manager_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="get_windows" symbol="wnck_screen_get_windows">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="get_windows_stacked" symbol="wnck_screen_get_windows_stacked">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="get_workspace" symbol="wnck_screen_get_workspace">
				<return-type type="WnckWorkspace*"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="workspace" type="int"/>
				</parameters>
			</method>
			<method name="get_workspace_count" symbol="wnck_screen_get_workspace_count">
				<return-type type="int"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="get_workspace_index" symbol="wnck_screen_get_workspace_index">
				<return-type type="int"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="get_workspace_neighbor" symbol="wnck_screen_get_workspace_neighbor">
				<return-type type="WnckWorkspace*"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="space" type="WnckWorkspace*"/>
					<parameter name="direction" type="WnckMotionDirection"/>
				</parameters>
			</method>
			<method name="get_workspaces" symbol="wnck_screen_get_workspaces">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="move_viewport" symbol="wnck_screen_move_viewport">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
				</parameters>
			</method>
			<method name="net_wm_supports" symbol="wnck_screen_net_wm_supports">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="atom" type="char*"/>
				</parameters>
			</method>
			<method name="release_workspace_layout" symbol="wnck_screen_release_workspace_layout">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="current_token" type="int"/>
				</parameters>
			</method>
			<method name="toggle_showing_desktop" symbol="wnck_screen_toggle_showing_desktop">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="show" type="gboolean"/>
				</parameters>
			</method>
			<method name="try_set_workspace_layout" symbol="wnck_screen_try_set_workspace_layout">
				<return-type type="int"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="current_token" type="int"/>
					<parameter name="rows" type="int"/>
					<parameter name="columns" type="int"/>
				</parameters>
			</method>
			<signal name="active-window-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="previous_window" type="WnckWindow*"/>
				</parameters>
			</signal>
			<signal name="active-workspace-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="previous_workspace" type="WnckWorkspace*"/>
				</parameters>
			</signal>
			<signal name="application-closed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</signal>
			<signal name="application-opened" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="app" type="WnckApplication*"/>
				</parameters>
			</signal>
			<signal name="background-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</signal>
			<signal name="class-group-closed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="class_group" type="WnckClassGroup*"/>
				</parameters>
			</signal>
			<signal name="class-group-opened" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="class_group" type="WnckClassGroup*"/>
				</parameters>
			</signal>
			<signal name="showing-desktop-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</signal>
			<signal name="viewports-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</signal>
			<signal name="window-closed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</signal>
			<signal name="window-manager-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</signal>
			<signal name="window-opened" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</signal>
			<signal name="window-stacking-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</signal>
			<signal name="workspace-created" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</signal>
			<signal name="workspace-destroyed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</signal>
			<vfunc name="pad2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad4">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad5">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad6">
				<return-type type="void"/>
			</vfunc>
		</object>
		<object name="WnckSelector" parent="GtkMenuBar" type-name="WnckSelector" get-type="wnck_selector_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="wnck_selector_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<vfunc name="pad1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad4">
				<return-type type="void"/>
			</vfunc>
		</object>
		<object name="WnckTasklist" parent="GtkContainer" type-name="WnckTasklist" get-type="wnck_tasklist_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_minimum_height" symbol="wnck_tasklist_get_minimum_height">
				<return-type type="gint"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
				</parameters>
			</method>
			<method name="get_minimum_width" symbol="wnck_tasklist_get_minimum_width">
				<return-type type="gint"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
				</parameters>
			</method>
			<method name="get_size_hint_list" symbol="wnck_tasklist_get_size_hint_list">
				<return-type type="int*"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
					<parameter name="n_elements" type="int*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="wnck_tasklist_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</constructor>
			<method name="set_button_relief" symbol="wnck_tasklist_set_button_relief">
				<return-type type="void"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
					<parameter name="relief" type="GtkReliefStyle"/>
				</parameters>
			</method>
			<method name="set_grouping" symbol="wnck_tasklist_set_grouping">
				<return-type type="void"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
					<parameter name="grouping" type="WnckTasklistGroupingType"/>
				</parameters>
			</method>
			<method name="set_grouping_limit" symbol="wnck_tasklist_set_grouping_limit">
				<return-type type="void"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
					<parameter name="limit" type="gint"/>
				</parameters>
			</method>
			<method name="set_icon_loader" symbol="wnck_tasklist_set_icon_loader">
				<return-type type="void"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
					<parameter name="load_icon_func" type="WnckLoadIconFunction"/>
					<parameter name="data" type="void*"/>
					<parameter name="free_data_func" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_include_all_workspaces" symbol="wnck_tasklist_set_include_all_workspaces">
				<return-type type="void"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
					<parameter name="include_all_workspaces" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_minimum_height" symbol="wnck_tasklist_set_minimum_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
					<parameter name="size" type="gint"/>
				</parameters>
			</method>
			<method name="set_minimum_width" symbol="wnck_tasklist_set_minimum_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
					<parameter name="size" type="gint"/>
				</parameters>
			</method>
			<method name="set_orientation" symbol="wnck_tasklist_set_orientation">
				<return-type type="void"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
					<parameter name="orient" type="GtkOrientation"/>
				</parameters>
			</method>
			<method name="set_screen" symbol="wnck_tasklist_set_screen">
				<return-type type="void"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
					<parameter name="screen" type="WnckScreen*"/>
				</parameters>
			</method>
			<method name="set_switch_workspace_on_unminimize" symbol="wnck_tasklist_set_switch_workspace_on_unminimize">
				<return-type type="void"/>
				<parameters>
					<parameter name="tasklist" type="WnckTasklist*"/>
					<parameter name="switch_workspace_on_unminimize" type="gboolean"/>
				</parameters>
			</method>
			<vfunc name="pad1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad4">
				<return-type type="void"/>
			</vfunc>
		</object>
		<object name="WnckWindow" parent="GObject" type-name="WnckWindow" get-type="wnck_window_get_type">
			<method name="activate" symbol="wnck_window_activate">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="timestamp" type="guint32"/>
				</parameters>
			</method>
			<method name="activate_transient" symbol="wnck_window_activate_transient">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="timestamp" type="guint32"/>
				</parameters>
			</method>
			<method name="close" symbol="wnck_window_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="timestamp" type="guint32"/>
				</parameters>
			</method>
			<method name="get" symbol="wnck_window_get">
				<return-type type="WnckWindow*"/>
				<parameters>
					<parameter name="xwindow" type="gulong"/>
				</parameters>
			</method>
			<method name="get_actions" symbol="wnck_window_get_actions">
				<return-type type="WnckWindowActions"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_application" symbol="wnck_window_get_application">
				<return-type type="WnckApplication*"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_class_group" symbol="wnck_window_get_class_group">
				<return-type type="WnckClassGroup*"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_client_window_geometry" symbol="wnck_window_get_client_window_geometry">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="xp" type="int*"/>
					<parameter name="yp" type="int*"/>
					<parameter name="widthp" type="int*"/>
					<parameter name="heightp" type="int*"/>
				</parameters>
			</method>
			<method name="get_geometry" symbol="wnck_window_get_geometry">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="xp" type="int*"/>
					<parameter name="yp" type="int*"/>
					<parameter name="widthp" type="int*"/>
					<parameter name="heightp" type="int*"/>
				</parameters>
			</method>
			<method name="get_group_leader" symbol="wnck_window_get_group_leader">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="wnck_window_get_icon">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_icon_is_fallback" symbol="wnck_window_get_icon_is_fallback">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_icon_name" symbol="wnck_window_get_icon_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_mini_icon" symbol="wnck_window_get_mini_icon">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="wnck_window_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_pid" symbol="wnck_window_get_pid">
				<return-type type="int"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="wnck_window_get_screen">
				<return-type type="WnckScreen*"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_session_id" symbol="wnck_window_get_session_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_session_id_utf8" symbol="wnck_window_get_session_id_utf8">
				<return-type type="char*"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_sort_order" symbol="wnck_window_get_sort_order">
				<return-type type="gint"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="wnck_window_get_state">
				<return-type type="WnckWindowState"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_transient" symbol="wnck_window_get_transient">
				<return-type type="WnckWindow*"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_window_type" symbol="wnck_window_get_window_type">
				<return-type type="WnckWindowType"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_workspace" symbol="wnck_window_get_workspace">
				<return-type type="WnckWorkspace*"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="get_xid" symbol="wnck_window_get_xid">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="has_icon_name" symbol="wnck_window_has_icon_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="has_name" symbol="wnck_window_has_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_above" symbol="wnck_window_is_above">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_active" symbol="wnck_window_is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_below" symbol="wnck_window_is_below">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_fullscreen" symbol="wnck_window_is_fullscreen">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_in_viewport" symbol="wnck_window_is_in_viewport">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="workspace" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="is_maximized" symbol="wnck_window_is_maximized">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_maximized_horizontally" symbol="wnck_window_is_maximized_horizontally">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_maximized_vertically" symbol="wnck_window_is_maximized_vertically">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_minimized" symbol="wnck_window_is_minimized">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_most_recently_activated" symbol="wnck_window_is_most_recently_activated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_on_workspace" symbol="wnck_window_is_on_workspace">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="workspace" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="is_pinned" symbol="wnck_window_is_pinned">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_shaded" symbol="wnck_window_is_shaded">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_skip_pager" symbol="wnck_window_is_skip_pager">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_skip_tasklist" symbol="wnck_window_is_skip_tasklist">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_sticky" symbol="wnck_window_is_sticky">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="is_visible_on_workspace" symbol="wnck_window_is_visible_on_workspace">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="workspace" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="keyboard_move" symbol="wnck_window_keyboard_move">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="keyboard_size" symbol="wnck_window_keyboard_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="make_above" symbol="wnck_window_make_above">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="make_below" symbol="wnck_window_make_below">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="maximize" symbol="wnck_window_maximize">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="maximize_horizontally" symbol="wnck_window_maximize_horizontally">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="maximize_vertically" symbol="wnck_window_maximize_vertically">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="minimize" symbol="wnck_window_minimize">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="move_to_workspace" symbol="wnck_window_move_to_workspace">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="needs_attention" symbol="wnck_window_needs_attention">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="or_transient_needs_attention" symbol="wnck_window_or_transient_needs_attention">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="pin" symbol="wnck_window_pin">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="set_fullscreen" symbol="wnck_window_set_fullscreen">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="fullscreen" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_geometry" symbol="wnck_window_set_geometry">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="gravity" type="WnckWindowGravity"/>
					<parameter name="geometry_mask" type="WnckWindowMoveResizeMask"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</method>
			<method name="set_icon_geometry" symbol="wnck_window_set_icon_geometry">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</method>
			<method name="set_skip_pager" symbol="wnck_window_set_skip_pager">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="skip" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_skip_tasklist" symbol="wnck_window_set_skip_tasklist">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="skip" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_sort_order" symbol="wnck_window_set_sort_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="order" type="gint"/>
				</parameters>
			</method>
			<method name="set_window_type" symbol="wnck_window_set_window_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="wintype" type="WnckWindowType"/>
				</parameters>
			</method>
			<method name="shade" symbol="wnck_window_shade">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="stick" symbol="wnck_window_stick">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="transient_is_most_recently_activated" symbol="wnck_window_transient_is_most_recently_activated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="unmake_above" symbol="wnck_window_unmake_above">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="unmake_below" symbol="wnck_window_unmake_below">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="unmaximize" symbol="wnck_window_unmaximize">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="unmaximize_horizontally" symbol="wnck_window_unmaximize_horizontally">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="unmaximize_vertically" symbol="wnck_window_unmaximize_vertically">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="unminimize" symbol="wnck_window_unminimize">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="timestamp" type="guint32"/>
				</parameters>
			</method>
			<method name="unpin" symbol="wnck_window_unpin">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="unshade" symbol="wnck_window_unshade">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<method name="unstick" symbol="wnck_window_unstick">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</method>
			<signal name="actions-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="changed_mask" type="WnckWindowActions"/>
					<parameter name="new_actions" type="WnckWindowActions"/>
				</parameters>
			</signal>
			<signal name="geometry-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</signal>
			<signal name="icon-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</signal>
			<signal name="name-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</signal>
			<signal name="state-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
					<parameter name="changed_mask" type="WnckWindowState"/>
					<parameter name="new_state" type="WnckWindowState"/>
				</parameters>
			</signal>
			<signal name="workspace-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="WnckWindow*"/>
				</parameters>
			</signal>
			<vfunc name="pad1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad4">
				<return-type type="void"/>
			</vfunc>
		</object>
		<object name="WnckWorkspace" parent="GObject" type-name="WnckWorkspace" get-type="wnck_workspace_get_type">
			<method name="activate" symbol="wnck_workspace_activate">
				<return-type type="void"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
					<parameter name="timestamp" type="guint32"/>
				</parameters>
			</method>
			<method name="change_name" symbol="wnck_workspace_change_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="wnck_workspace_get_height">
				<return-type type="int"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="get_layout_column" symbol="wnck_workspace_get_layout_column">
				<return-type type="int"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="get_layout_row" symbol="wnck_workspace_get_layout_row">
				<return-type type="int"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="wnck_workspace_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="get_neighbor" symbol="wnck_workspace_get_neighbor">
				<return-type type="WnckWorkspace*"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
					<parameter name="direction" type="WnckMotionDirection"/>
				</parameters>
			</method>
			<method name="get_number" symbol="wnck_workspace_get_number">
				<return-type type="int"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="wnck_workspace_get_screen">
				<return-type type="WnckScreen*"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="get_viewport_x" symbol="wnck_workspace_get_viewport_x">
				<return-type type="int"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="get_viewport_y" symbol="wnck_workspace_get_viewport_y">
				<return-type type="int"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="wnck_workspace_get_width">
				<return-type type="int"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<method name="is_virtual" symbol="wnck_workspace_is_virtual">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</method>
			<signal name="name-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="space" type="WnckWorkspace*"/>
				</parameters>
			</signal>
			<vfunc name="pad1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="pad4">
				<return-type type="void"/>
			</vfunc>
		</object>
	</namespace>
</api>
