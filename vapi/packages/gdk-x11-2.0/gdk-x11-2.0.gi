<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gdk">
		<function name="gdkx_visual_get" symbol="gdkx_visual_get">
			<return-type type="GdkVisual*"/>
			<parameters>
				<parameter name="xvisualid" type="VisualID"/>
			</parameters>
		</function>
		<function name="net_wm_supports" symbol="gdk_net_wm_supports">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="property" type="GdkAtom"/>
			</parameters>
		</function>
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
		<function name="x11_colormap_foreign_new" symbol="gdk_x11_colormap_foreign_new">
			<return-type type="GdkColormap*"/>
			<parameters>
				<parameter name="visual" type="GdkVisual*"/>
				<parameter name="xcolormap" type="Colormap"/>
			</parameters>
		</function>
		<function name="x11_colormap_get_xcolormap" symbol="gdk_x11_colormap_get_xcolormap">
			<return-type type="Colormap"/>
			<parameters>
				<parameter name="colormap" type="GdkColormap*"/>
			</parameters>
		</function>
		<function name="x11_colormap_get_xdisplay" symbol="gdk_x11_colormap_get_xdisplay">
			<return-type type="Display*"/>
			<parameters>
				<parameter name="colormap" type="GdkColormap*"/>
			</parameters>
		</function>
		<function name="x11_cursor_get_xcursor" symbol="gdk_x11_cursor_get_xcursor">
			<return-type type="Cursor"/>
			<parameters>
				<parameter name="cursor" type="GdkCursor*"/>
			</parameters>
		</function>
		<function name="x11_cursor_get_xdisplay" symbol="gdk_x11_cursor_get_xdisplay">
			<return-type type="Display*"/>
			<parameters>
				<parameter name="cursor" type="GdkCursor*"/>
			</parameters>
		</function>
		<function name="x11_display_broadcast_startup_message" symbol="gdk_x11_display_broadcast_startup_message">
			<return-type type="void"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="message_type" type="char*"/>
			</parameters>
		</function>
		<function name="x11_display_get_startup_notification_id" symbol="gdk_x11_display_get_startup_notification_id">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
			</parameters>
		</function>
		<function name="x11_display_get_user_time" symbol="gdk_x11_display_get_user_time">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
			</parameters>
		</function>
		<function name="x11_display_get_xdisplay" symbol="gdk_x11_display_get_xdisplay">
			<return-type type="Display*"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
			</parameters>
		</function>
		<function name="x11_display_grab" symbol="gdk_x11_display_grab">
			<return-type type="void"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
			</parameters>
		</function>
		<function name="x11_display_set_cursor_theme" symbol="gdk_x11_display_set_cursor_theme">
			<return-type type="void"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="theme" type="gchar*"/>
				<parameter name="size" type="gint"/>
			</parameters>
		</function>
		<function name="x11_display_ungrab" symbol="gdk_x11_display_ungrab">
			<return-type type="void"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
			</parameters>
		</function>
		<function name="x11_drawable_get_xdisplay" symbol="gdk_x11_drawable_get_xdisplay">
			<return-type type="Display*"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
			</parameters>
		</function>
		<function name="x11_drawable_get_xid" symbol="gdk_x11_drawable_get_xid">
			<return-type type="XID"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
			</parameters>
		</function>
		<function name="x11_gc_get_xdisplay" symbol="gdk_x11_gc_get_xdisplay">
			<return-type type="Display*"/>
			<parameters>
				<parameter name="gc" type="GdkGC*"/>
			</parameters>
		</function>
		<function name="x11_gc_get_xgc" symbol="gdk_x11_gc_get_xgc">
			<return-type type="GC"/>
			<parameters>
				<parameter name="gc" type="GdkGC*"/>
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
		<function name="x11_image_get_xdisplay" symbol="gdk_x11_image_get_xdisplay">
			<return-type type="Display*"/>
			<parameters>
				<parameter name="image" type="GdkImage*"/>
			</parameters>
		</function>
		<function name="x11_image_get_ximage" symbol="gdk_x11_image_get_ximage">
			<return-type type="XImage*"/>
			<parameters>
				<parameter name="image" type="GdkImage*"/>
			</parameters>
		</function>
		<function name="x11_lookup_xdisplay" symbol="gdk_x11_lookup_xdisplay">
			<return-type type="GdkDisplay*"/>
			<parameters>
				<parameter name="xdisplay" type="Display*"/>
			</parameters>
		</function>
		<function name="x11_pixmap_get_drawable_impl" symbol="gdk_x11_pixmap_get_drawable_impl">
			<return-type type="GdkDrawable*"/>
			<parameters>
				<parameter name="pixmap" type="GdkPixmap*"/>
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
		<function name="x11_screen_get_monitor_output" symbol="gdk_x11_screen_get_monitor_output">
			<return-type type="XID"/>
			<parameters>
				<parameter name="screen" type="GdkScreen*"/>
				<parameter name="monitor_num" type="gint"/>
			</parameters>
		</function>
		<function name="x11_screen_get_screen_number" symbol="gdk_x11_screen_get_screen_number">
			<return-type type="int"/>
			<parameters>
				<parameter name="screen" type="GdkScreen*"/>
			</parameters>
		</function>
		<function name="x11_screen_get_window_manager_name" symbol="gdk_x11_screen_get_window_manager_name">
			<return-type type="char*"/>
			<parameters>
				<parameter name="screen" type="GdkScreen*"/>
			</parameters>
		</function>
		<function name="x11_screen_get_xscreen" symbol="gdk_x11_screen_get_xscreen">
			<return-type type="Screen*"/>
			<parameters>
				<parameter name="screen" type="GdkScreen*"/>
			</parameters>
		</function>
		<function name="x11_screen_lookup_visual" symbol="gdk_x11_screen_lookup_visual">
			<return-type type="GdkVisual*"/>
			<parameters>
				<parameter name="screen" type="GdkScreen*"/>
				<parameter name="xvisualid" type="VisualID"/>
			</parameters>
		</function>
		<function name="x11_screen_supports_net_wm_hint" symbol="gdk_x11_screen_supports_net_wm_hint">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="screen" type="GdkScreen*"/>
				<parameter name="property" type="GdkAtom"/>
			</parameters>
		</function>
		<function name="x11_ungrab_server" symbol="gdk_x11_ungrab_server">
			<return-type type="void"/>
		</function>
		<function name="x11_visual_get_xvisual" symbol="gdk_x11_visual_get_xvisual">
			<return-type type="Visual*"/>
			<parameters>
				<parameter name="visual" type="GdkVisual*"/>
			</parameters>
		</function>
		<function name="x11_window_get_drawable_impl" symbol="gdk_x11_window_get_drawable_impl">
			<return-type type="GdkDrawable*"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
			</parameters>
		</function>
		<function name="x11_window_move_to_current_desktop" symbol="gdk_x11_window_move_to_current_desktop">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
			</parameters>
		</function>
		<function name="x11_window_set_user_time" symbol="gdk_x11_window_set_user_time">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="timestamp" type="guint32"/>
			</parameters>
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
		<function name="xid_table_lookup" symbol="gdk_xid_table_lookup">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="xid" type="XID"/>
			</parameters>
		</function>
		<function name="xid_table_lookup_for_display" symbol="gdk_xid_table_lookup_for_display">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="xid" type="XID"/>
			</parameters>
		</function>
	</namespace>
</api>
