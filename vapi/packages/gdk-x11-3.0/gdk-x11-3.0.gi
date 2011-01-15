<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gdk">
		<function name="x11_atom_to_xatom" symbol="gdk_x11_atom_to_xatom">
			<return-type type="Atom"/>
			<parameters>
				<parameter name="atom" type="GdkAtom"/>
			</parameters>
		</function>
		<function name="x11_atom_to_xatom_for_display" symbol="gdk_x11_atom_to_xatom_for_display">
			<return-type type="Atom"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="atom" type="GdkAtom"/>
			</parameters>
		</function>
		<function name="x11_free_compound_text" symbol="gdk_x11_free_compound_text">
			<return-type type="void"/>
			<parameters>
				<parameter name="ctext" type="guchar*"/>
			</parameters>
		</function>
		<function name="x11_free_text_list" symbol="gdk_x11_free_text_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="gchar**"/>
			</parameters>
		</function>
		<function name="x11_get_default_root_xwindow" symbol="gdk_x11_get_default_root_xwindow">
			<return-type type="Window"/>
		</function>
		<function name="x11_get_default_screen" symbol="gdk_x11_get_default_screen">
			<return-type type="gint"/>
		</function>
		<function name="x11_get_default_xdisplay" symbol="gdk_x11_get_default_xdisplay">
			<return-type type="Display*"/>
		</function>
		<function name="x11_get_server_time" symbol="gdk_x11_get_server_time">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
			</parameters>
		</function>
		<function name="x11_get_xatom_by_name" symbol="gdk_x11_get_xatom_by_name">
			<return-type type="Atom"/>
			<parameters>
				<parameter name="atom_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="x11_get_xatom_by_name_for_display" symbol="gdk_x11_get_xatom_by_name_for_display">
			<return-type type="Atom"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="atom_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="x11_get_xatom_name" symbol="gdk_x11_get_xatom_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="xatom" type="Atom"/>
			</parameters>
		</function>
		<function name="x11_get_xatom_name_for_display" symbol="gdk_x11_get_xatom_name_for_display">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="xatom" type="Atom"/>
			</parameters>
		</function>
		<function name="x11_grab_server" symbol="gdk_x11_grab_server">
			<return-type type="void"/>
		</function>
		<function name="x11_lookup_xdisplay" symbol="gdk_x11_lookup_xdisplay">
			<return-type type="GdkDisplay*"/>
			<parameters>
				<parameter name="xdisplay" type="Display*"/>
			</parameters>
		</function>
		<function name="x11_register_standard_event_type" symbol="gdk_x11_register_standard_event_type">
			<return-type type="void"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="event_base" type="gint"/>
				<parameter name="n_events" type="gint"/>
			</parameters>
		</function>
		<function name="x11_set_sm_client_id" symbol="gdk_x11_set_sm_client_id">
			<return-type type="void"/>
			<parameters>
				<parameter name="sm_client_id" type="gchar*"/>
			</parameters>
		</function>
		<function name="x11_ungrab_server" symbol="gdk_x11_ungrab_server">
			<return-type type="void"/>
		</function>
		<function name="x11_xatom_to_atom" symbol="gdk_x11_xatom_to_atom">
			<return-type type="GdkAtom"/>
			<parameters>
				<parameter name="xatom" type="Atom"/>
			</parameters>
		</function>
		<function name="x11_xatom_to_atom_for_display" symbol="gdk_x11_xatom_to_atom_for_display">
			<return-type type="GdkAtom"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="xatom" type="Atom"/>
			</parameters>
		</function>
		<struct name="GdkX11AppLaunchContextClass">
		</struct>
		<struct name="GdkX11CursorClass">
		</struct>
		<struct name="GdkX11DisplayClass">
		</struct>
		<struct name="GdkX11DisplayManagerClass">
		</struct>
		<struct name="GdkX11DragContextClass">
		</struct>
		<struct name="GdkX11KeymapClass">
		</struct>
		<struct name="GdkX11ScreenClass">
		</struct>
		<struct name="GdkX11VisualClass">
		</struct>
		<struct name="GdkX11WindowClass">
		</struct>
		<object name="GdkX11AppLaunchContext" parent="GdkAppLaunchContext" type-name="GdkX11AppLaunchContext" get-type="gdk_x11_app_launch_context_get_type">
		</object>
		<object name="GdkX11Cursor" parent="GdkCursor" type-name="GdkX11Cursor" get-type="gdk_x11_cursor_get_type">
			<method name="get_xcursor" symbol="gdk_x11_cursor_get_xcursor">
				<return-type type="Cursor"/>
				<parameters>
					<parameter name="cursor" type="GdkCursor*"/>
				</parameters>
			</method>
			<method name="get_xdisplay" symbol="gdk_x11_cursor_get_xdisplay">
				<return-type type="Display*"/>
				<parameters>
					<parameter name="cursor" type="GdkCursor*"/>
				</parameters>
			</method>
		</object>
		<object name="GdkX11Display" parent="GdkDisplay" type-name="GdkX11Display" get-type="gdk_x11_display_get_type">
			<implements>
				<interface name="GdkEventTranslator"/>
			</implements>
			<method name="broadcast_startup_message" symbol="gdk_x11_display_broadcast_startup_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="message_type" type="char*"/>
				</parameters>
			</method>
			<method name="error_trap_pop" symbol="gdk_x11_display_error_trap_pop">
				<return-type type="gint"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="error_trap_pop_ignored" symbol="gdk_x11_display_error_trap_pop_ignored">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="error_trap_push" symbol="gdk_x11_display_error_trap_push">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_startup_notification_id" symbol="gdk_x11_display_get_startup_notification_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_user_time" symbol="gdk_x11_display_get_user_time">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_xdisplay" symbol="gdk_x11_display_get_xdisplay">
				<return-type type="Display*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="grab" symbol="gdk_x11_display_grab">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="set_cursor_theme" symbol="gdk_x11_display_set_cursor_theme">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="theme" type="gchar*"/>
					<parameter name="size" type="gint"/>
				</parameters>
			</method>
			<method name="set_startup_notification_id" symbol="gdk_x11_display_set_startup_notification_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="startup_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="string_to_compound_text" symbol="gdk_x11_display_string_to_compound_text">
				<return-type type="gint"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="str" type="gchar*"/>
					<parameter name="encoding" type="GdkAtom*"/>
					<parameter name="format" type="gint*"/>
					<parameter name="ctext" type="guchar**"/>
					<parameter name="length" type="gint*"/>
				</parameters>
			</method>
			<method name="text_property_to_text_list" symbol="gdk_x11_display_text_property_to_text_list">
				<return-type type="gint"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="encoding" type="GdkAtom"/>
					<parameter name="format" type="gint"/>
					<parameter name="text" type="guchar*"/>
					<parameter name="length" type="gint"/>
					<parameter name="list" type="gchar***"/>
				</parameters>
			</method>
			<method name="ungrab" symbol="gdk_x11_display_ungrab">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="utf8_to_compound_text" symbol="gdk_x11_display_utf8_to_compound_text">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="str" type="gchar*"/>
					<parameter name="encoding" type="GdkAtom*"/>
					<parameter name="format" type="gint*"/>
					<parameter name="ctext" type="guchar**"/>
					<parameter name="length" type="gint*"/>
				</parameters>
			</method>
		</object>
		<object name="GdkX11DisplayManager" parent="GdkDisplayManager" type-name="GdkX11DisplayManager" get-type="gdk_x11_display_manager_get_type">
		</object>
		<object name="GdkX11DragContext" parent="GdkDragContext" type-name="GdkX11DragContext" get-type="gdk_x11_drag_context_get_type">
		</object>
		<object name="GdkX11Keymap" parent="GdkKeymap" type-name="GdkX11Keymap" get-type="gdk_x11_keymap_get_type">
		</object>
		<object name="GdkX11Screen" parent="GdkScreen" type-name="GdkX11Screen" get-type="gdk_x11_screen_get_type">
			<method name="get_monitor_output" symbol="gdk_x11_screen_get_monitor_output">
				<return-type type="XID"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="monitor_num" type="gint"/>
				</parameters>
			</method>
			<method name="get_screen_number" symbol="gdk_x11_screen_get_screen_number">
				<return-type type="int"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_window_manager_name" symbol="gdk_x11_screen_get_window_manager_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_xscreen" symbol="gdk_x11_screen_get_xscreen">
				<return-type type="Screen*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="lookup_visual" symbol="gdk_x11_screen_lookup_visual">
				<return-type type="GdkVisual*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="xvisualid" type="VisualID"/>
				</parameters>
			</method>
			<method name="supports_net_wm_hint" symbol="gdk_x11_screen_supports_net_wm_hint">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="property" type="GdkAtom"/>
				</parameters>
			</method>
			<signal name="window-manager-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkX11Screen*"/>
				</parameters>
			</signal>
		</object>
		<object name="GdkX11Visual" parent="GdkVisual" type-name="GdkX11Visual" get-type="gdk_x11_visual_get_type">
			<method name="get_xvisual" symbol="gdk_x11_visual_get_xvisual">
				<return-type type="Visual*"/>
				<parameters>
					<parameter name="visual" type="GdkVisual*"/>
				</parameters>
			</method>
		</object>
		<object name="GdkX11Window" parent="GdkWindow" type-name="GdkX11Window" get-type="gdk_x11_window_get_type">
			<method name="foreign_new_for_display" symbol="gdk_x11_window_foreign_new_for_display">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="window" type="Window"/>
				</parameters>
			</method>
			<method name="get_xid" symbol="gdk_x11_window_get_xid">
				<return-type type="Window"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="lookup_for_display" symbol="gdk_x11_window_lookup_for_display">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="window" type="Window"/>
				</parameters>
			</method>
			<method name="move_to_current_desktop" symbol="gdk_x11_window_move_to_current_desktop">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="set_user_time" symbol="gdk_x11_window_set_user_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="timestamp" type="guint32"/>
				</parameters>
			</method>
		</object>
	</namespace>
</api>
