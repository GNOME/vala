<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gdk">
		<function name="add_client_message_filter" symbol="gdk_add_client_message_filter">
			<return-type type="void"/>
			<parameters>
				<parameter name="message_type" type="GdkAtom"/>
				<parameter name="func" type="GdkFilterFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="add_option_entries_libgtk_only" symbol="gdk_add_option_entries_libgtk_only">
			<return-type type="void"/>
			<parameters>
				<parameter name="group" type="GOptionGroup*"/>
			</parameters>
		</function>
		<function name="beep" symbol="gdk_beep">
			<return-type type="void"/>
		</function>
		<function name="cairo_create" symbol="gdk_cairo_create">
			<return-type type="cairo_t*"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
			</parameters>
		</function>
		<function name="cairo_get_clip_rectangle" symbol="gdk_cairo_get_clip_rectangle">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="rect" type="GdkRectangle*"/>
			</parameters>
		</function>
		<function name="cairo_rectangle" symbol="gdk_cairo_rectangle">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="rectangle" type="GdkRectangle*"/>
			</parameters>
		</function>
		<function name="cairo_region" symbol="gdk_cairo_region">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="region" type="cairo_region_t*"/>
			</parameters>
		</function>
		<function name="cairo_region_create_from_surface" symbol="gdk_cairo_region_create_from_surface">
			<return-type type="cairo_region_t*"/>
			<parameters>
				<parameter name="surface" type="cairo_surface_t*"/>
			</parameters>
		</function>
		<function name="cairo_set_source_color" symbol="gdk_cairo_set_source_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="color" type="GdkColor*"/>
			</parameters>
		</function>
		<function name="cairo_set_source_pixbuf" symbol="gdk_cairo_set_source_pixbuf">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
				<parameter name="pixbuf_x" type="double"/>
				<parameter name="pixbuf_y" type="double"/>
			</parameters>
		</function>
		<function name="cairo_set_source_rgba" symbol="gdk_cairo_set_source_rgba">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="rgba" type="GdkRGBA*"/>
			</parameters>
		</function>
		<function name="cairo_set_source_window" symbol="gdk_cairo_set_source_window">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="x" type="double"/>
				<parameter name="y" type="double"/>
			</parameters>
		</function>
		<function name="disable_multidevice" symbol="gdk_disable_multidevice">
			<return-type type="void"/>
		</function>
		<function name="drag_abort" symbol="gdk_drag_abort">
			<return-type type="void"/>
			<parameters>
				<parameter name="context" type="GdkDragContext*"/>
				<parameter name="time_" type="guint32"/>
			</parameters>
		</function>
		<function name="drag_begin" symbol="gdk_drag_begin">
			<return-type type="GdkDragContext*"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="targets" type="GList*"/>
			</parameters>
		</function>
		<function name="drag_begin_for_device" symbol="gdk_drag_begin_for_device">
			<return-type type="GdkDragContext*"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="device" type="GdkDevice*"/>
				<parameter name="targets" type="GList*"/>
			</parameters>
		</function>
		<function name="drag_drop" symbol="gdk_drag_drop">
			<return-type type="void"/>
			<parameters>
				<parameter name="context" type="GdkDragContext*"/>
				<parameter name="time_" type="guint32"/>
			</parameters>
		</function>
		<function name="drag_drop_succeeded" symbol="gdk_drag_drop_succeeded">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="context" type="GdkDragContext*"/>
			</parameters>
		</function>
		<function name="drag_find_window_for_screen" symbol="gdk_drag_find_window_for_screen">
			<return-type type="void"/>
			<parameters>
				<parameter name="context" type="GdkDragContext*"/>
				<parameter name="drag_window" type="GdkWindow*"/>
				<parameter name="screen" type="GdkScreen*"/>
				<parameter name="x_root" type="gint"/>
				<parameter name="y_root" type="gint"/>
				<parameter name="dest_window" type="GdkWindow**"/>
				<parameter name="protocol" type="GdkDragProtocol*"/>
			</parameters>
		</function>
		<function name="drag_get_protocol_for_display" symbol="gdk_drag_get_protocol_for_display">
			<return-type type="GdkNativeWindow"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="xid" type="GdkNativeWindow"/>
				<parameter name="protocol" type="GdkDragProtocol*"/>
			</parameters>
		</function>
		<function name="drag_get_selection" symbol="gdk_drag_get_selection">
			<return-type type="GdkAtom"/>
			<parameters>
				<parameter name="context" type="GdkDragContext*"/>
			</parameters>
		</function>
		<function name="drag_motion" symbol="gdk_drag_motion">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="context" type="GdkDragContext*"/>
				<parameter name="dest_window" type="GdkWindow*"/>
				<parameter name="protocol" type="GdkDragProtocol"/>
				<parameter name="x_root" type="gint"/>
				<parameter name="y_root" type="gint"/>
				<parameter name="suggested_action" type="GdkDragAction"/>
				<parameter name="possible_actions" type="GdkDragAction"/>
				<parameter name="time_" type="guint32"/>
			</parameters>
		</function>
		<function name="drag_status" symbol="gdk_drag_status">
			<return-type type="void"/>
			<parameters>
				<parameter name="context" type="GdkDragContext*"/>
				<parameter name="action" type="GdkDragAction"/>
				<parameter name="time_" type="guint32"/>
			</parameters>
		</function>
		<function name="drop_finish" symbol="gdk_drop_finish">
			<return-type type="void"/>
			<parameters>
				<parameter name="context" type="GdkDragContext*"/>
				<parameter name="success" type="gboolean"/>
				<parameter name="time_" type="guint32"/>
			</parameters>
		</function>
		<function name="drop_reply" symbol="gdk_drop_reply">
			<return-type type="void"/>
			<parameters>
				<parameter name="context" type="GdkDragContext*"/>
				<parameter name="accepted" type="gboolean"/>
				<parameter name="time_" type="guint32"/>
			</parameters>
		</function>
		<function name="error_trap_pop" symbol="gdk_error_trap_pop">
			<return-type type="gint"/>
		</function>
		<function name="error_trap_pop_ignored" symbol="gdk_error_trap_pop_ignored">
			<return-type type="void"/>
		</function>
		<function name="error_trap_push" symbol="gdk_error_trap_push">
			<return-type type="void"/>
		</function>
		<function name="events_get_angle" symbol="gdk_events_get_angle">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="event1" type="GdkEvent*"/>
				<parameter name="event2" type="GdkEvent*"/>
				<parameter name="angle" type="gdouble*"/>
			</parameters>
		</function>
		<function name="events_get_center" symbol="gdk_events_get_center">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="event1" type="GdkEvent*"/>
				<parameter name="event2" type="GdkEvent*"/>
				<parameter name="x" type="gdouble*"/>
				<parameter name="y" type="gdouble*"/>
			</parameters>
		</function>
		<function name="events_get_distance" symbol="gdk_events_get_distance">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="event1" type="GdkEvent*"/>
				<parameter name="event2" type="GdkEvent*"/>
				<parameter name="distance" type="gdouble*"/>
			</parameters>
		</function>
		<function name="events_pending" symbol="gdk_events_pending">
			<return-type type="gboolean"/>
		</function>
		<function name="flush" symbol="gdk_flush">
			<return-type type="void"/>
		</function>
		<function name="get_default_root_window" symbol="gdk_get_default_root_window">
			<return-type type="GdkWindow*"/>
		</function>
		<function name="get_display" symbol="gdk_get_display">
			<return-type type="gchar*"/>
		</function>
		<function name="get_display_arg_name" symbol="gdk_get_display_arg_name">
			<return-type type="gchar*"/>
		</function>
		<function name="get_program_class" symbol="gdk_get_program_class">
			<return-type type="gchar*"/>
		</function>
		<function name="get_show_events" symbol="gdk_get_show_events">
			<return-type type="gboolean"/>
		</function>
		<function name="init" symbol="gdk_init">
			<return-type type="void"/>
			<parameters>
				<parameter name="argc" type="gint*"/>
				<parameter name="argv" type="gchar***"/>
			</parameters>
		</function>
		<function name="init_check" symbol="gdk_init_check">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="argc" type="gint*"/>
				<parameter name="argv" type="gchar***"/>
			</parameters>
		</function>
		<function name="keyval_convert_case" symbol="gdk_keyval_convert_case">
			<return-type type="void"/>
			<parameters>
				<parameter name="symbol" type="guint"/>
				<parameter name="lower" type="guint*"/>
				<parameter name="upper" type="guint*"/>
			</parameters>
		</function>
		<function name="keyval_from_name" symbol="gdk_keyval_from_name">
			<return-type type="guint"/>
			<parameters>
				<parameter name="keyval_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="keyval_is_lower" symbol="gdk_keyval_is_lower">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="keyval" type="guint"/>
			</parameters>
		</function>
		<function name="keyval_is_upper" symbol="gdk_keyval_is_upper">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="keyval" type="guint"/>
			</parameters>
		</function>
		<function name="keyval_name" symbol="gdk_keyval_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="keyval" type="guint"/>
			</parameters>
		</function>
		<function name="keyval_to_lower" symbol="gdk_keyval_to_lower">
			<return-type type="guint"/>
			<parameters>
				<parameter name="keyval" type="guint"/>
			</parameters>
		</function>
		<function name="keyval_to_unicode" symbol="gdk_keyval_to_unicode">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="keyval" type="guint"/>
			</parameters>
		</function>
		<function name="keyval_to_upper" symbol="gdk_keyval_to_upper">
			<return-type type="guint"/>
			<parameters>
				<parameter name="keyval" type="guint"/>
			</parameters>
		</function>
		<function name="list_visuals" symbol="gdk_list_visuals">
			<return-type type="GList*"/>
		</function>
		<function name="notify_startup_complete" symbol="gdk_notify_startup_complete">
			<return-type type="void"/>
		</function>
		<function name="notify_startup_complete_with_id" symbol="gdk_notify_startup_complete_with_id">
			<return-type type="void"/>
			<parameters>
				<parameter name="startup_id" type="gchar*"/>
			</parameters>
		</function>
		<function name="offscreen_window_get_embedder" symbol="gdk_offscreen_window_get_embedder">
			<return-type type="GdkWindow*"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
			</parameters>
		</function>
		<function name="offscreen_window_get_surface" symbol="gdk_offscreen_window_get_surface">
			<return-type type="cairo_surface_t*"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
			</parameters>
		</function>
		<function name="offscreen_window_set_embedder" symbol="gdk_offscreen_window_set_embedder">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="embedder" type="GdkWindow*"/>
			</parameters>
		</function>
		<function name="pango_context_get" symbol="gdk_pango_context_get">
			<return-type type="PangoContext*"/>
		</function>
		<function name="pango_context_get_for_screen" symbol="gdk_pango_context_get_for_screen">
			<return-type type="PangoContext*"/>
			<parameters>
				<parameter name="screen" type="GdkScreen*"/>
			</parameters>
		</function>
		<function name="pango_layout_get_clip_region" symbol="gdk_pango_layout_get_clip_region">
			<return-type type="cairo_region_t*"/>
			<parameters>
				<parameter name="layout" type="PangoLayout*"/>
				<parameter name="x_origin" type="gint"/>
				<parameter name="y_origin" type="gint"/>
				<parameter name="index_ranges" type="gint*"/>
				<parameter name="n_ranges" type="gint"/>
			</parameters>
		</function>
		<function name="pango_layout_line_get_clip_region" symbol="gdk_pango_layout_line_get_clip_region">
			<return-type type="cairo_region_t*"/>
			<parameters>
				<parameter name="line" type="PangoLayoutLine*"/>
				<parameter name="x_origin" type="gint"/>
				<parameter name="y_origin" type="gint"/>
				<parameter name="index_ranges" type="gint*"/>
				<parameter name="n_ranges" type="gint"/>
			</parameters>
		</function>
		<function name="parse_args" symbol="gdk_parse_args">
			<return-type type="void"/>
			<parameters>
				<parameter name="argc" type="gint*"/>
				<parameter name="argv" type="gchar***"/>
			</parameters>
		</function>
		<function name="pixbuf_get_from_surface" symbol="gdk_pixbuf_get_from_surface">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="surface" type="cairo_surface_t*"/>
				<parameter name="src_x" type="int"/>
				<parameter name="src_y" type="int"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
			</parameters>
		</function>
		<function name="pixbuf_get_from_window" symbol="gdk_pixbuf_get_from_window">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="src_x" type="int"/>
				<parameter name="src_y" type="int"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
			</parameters>
		</function>
		<function name="pre_parse_libgtk_only" symbol="gdk_pre_parse_libgtk_only">
			<return-type type="void"/>
		</function>
		<function name="property_change" symbol="gdk_property_change">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="property" type="GdkAtom"/>
				<parameter name="type" type="GdkAtom"/>
				<parameter name="format" type="gint"/>
				<parameter name="mode" type="GdkPropMode"/>
				<parameter name="data" type="guchar*"/>
				<parameter name="nelements" type="gint"/>
			</parameters>
		</function>
		<function name="property_delete" symbol="gdk_property_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="property" type="GdkAtom"/>
			</parameters>
		</function>
		<function name="property_get" symbol="gdk_property_get">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="property" type="GdkAtom"/>
				<parameter name="type" type="GdkAtom"/>
				<parameter name="offset" type="gulong"/>
				<parameter name="length" type="gulong"/>
				<parameter name="pdelete" type="gint"/>
				<parameter name="actual_property_type" type="GdkAtom*"/>
				<parameter name="actual_format" type="gint*"/>
				<parameter name="actual_length" type="gint*"/>
				<parameter name="data" type="guchar**"/>
			</parameters>
		</function>
		<function name="query_depths" symbol="gdk_query_depths">
			<return-type type="void"/>
			<parameters>
				<parameter name="depths" type="gint**"/>
				<parameter name="count" type="gint*"/>
			</parameters>
		</function>
		<function name="query_visual_types" symbol="gdk_query_visual_types">
			<return-type type="void"/>
			<parameters>
				<parameter name="visual_types" type="GdkVisualType**"/>
				<parameter name="count" type="gint*"/>
			</parameters>
		</function>
		<function name="selection_convert" symbol="gdk_selection_convert">
			<return-type type="void"/>
			<parameters>
				<parameter name="requestor" type="GdkWindow*"/>
				<parameter name="selection" type="GdkAtom"/>
				<parameter name="target" type="GdkAtom"/>
				<parameter name="time_" type="guint32"/>
			</parameters>
		</function>
		<function name="selection_owner_get" symbol="gdk_selection_owner_get">
			<return-type type="GdkWindow*"/>
			<parameters>
				<parameter name="selection" type="GdkAtom"/>
			</parameters>
		</function>
		<function name="selection_owner_get_for_display" symbol="gdk_selection_owner_get_for_display">
			<return-type type="GdkWindow*"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="selection" type="GdkAtom"/>
			</parameters>
		</function>
		<function name="selection_owner_set" symbol="gdk_selection_owner_set">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="owner" type="GdkWindow*"/>
				<parameter name="selection" type="GdkAtom"/>
				<parameter name="time_" type="guint32"/>
				<parameter name="send_event" type="gboolean"/>
			</parameters>
		</function>
		<function name="selection_owner_set_for_display" symbol="gdk_selection_owner_set_for_display">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="owner" type="GdkWindow*"/>
				<parameter name="selection" type="GdkAtom"/>
				<parameter name="time_" type="guint32"/>
				<parameter name="send_event" type="gboolean"/>
			</parameters>
		</function>
		<function name="selection_property_get" symbol="gdk_selection_property_get">
			<return-type type="gint"/>
			<parameters>
				<parameter name="requestor" type="GdkWindow*"/>
				<parameter name="data" type="guchar**"/>
				<parameter name="prop_type" type="GdkAtom*"/>
				<parameter name="prop_format" type="gint*"/>
			</parameters>
		</function>
		<function name="selection_send_notify" symbol="gdk_selection_send_notify">
			<return-type type="void"/>
			<parameters>
				<parameter name="requestor" type="GdkNativeWindow"/>
				<parameter name="selection" type="GdkAtom"/>
				<parameter name="target" type="GdkAtom"/>
				<parameter name="property" type="GdkAtom"/>
				<parameter name="time_" type="guint32"/>
			</parameters>
		</function>
		<function name="selection_send_notify_for_display" symbol="gdk_selection_send_notify_for_display">
			<return-type type="void"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="requestor" type="GdkNativeWindow"/>
				<parameter name="selection" type="GdkAtom"/>
				<parameter name="target" type="GdkAtom"/>
				<parameter name="property" type="GdkAtom"/>
				<parameter name="time_" type="guint32"/>
			</parameters>
		</function>
		<function name="set_double_click_time" symbol="gdk_set_double_click_time">
			<return-type type="void"/>
			<parameters>
				<parameter name="msec" type="guint"/>
			</parameters>
		</function>
		<function name="set_program_class" symbol="gdk_set_program_class">
			<return-type type="void"/>
			<parameters>
				<parameter name="program_class" type="gchar*"/>
			</parameters>
		</function>
		<function name="set_show_events" symbol="gdk_set_show_events">
			<return-type type="void"/>
			<parameters>
				<parameter name="show_events" type="gboolean"/>
			</parameters>
		</function>
		<function name="setting_get" symbol="gdk_setting_get">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="test_render_sync" symbol="gdk_test_render_sync">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
			</parameters>
		</function>
		<function name="test_simulate_button" symbol="gdk_test_simulate_button">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="button" type="guint"/>
				<parameter name="modifiers" type="GdkModifierType"/>
				<parameter name="button_pressrelease" type="GdkEventType"/>
			</parameters>
		</function>
		<function name="test_simulate_key" symbol="gdk_test_simulate_key">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="keyval" type="guint"/>
				<parameter name="modifiers" type="GdkModifierType"/>
				<parameter name="key_pressrelease" type="GdkEventType"/>
			</parameters>
		</function>
		<function name="text_property_to_utf8_list_for_display" symbol="gdk_text_property_to_utf8_list_for_display">
			<return-type type="gint"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="encoding" type="GdkAtom"/>
				<parameter name="format" type="gint"/>
				<parameter name="text" type="guchar*"/>
				<parameter name="length" type="gint"/>
				<parameter name="list" type="gchar***"/>
			</parameters>
		</function>
		<function name="threads_add_idle" symbol="gdk_threads_add_idle">
			<return-type type="guint"/>
			<parameters>
				<parameter name="function" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="threads_add_idle_full" symbol="gdk_threads_add_idle_full">
			<return-type type="guint"/>
			<parameters>
				<parameter name="priority" type="gint"/>
				<parameter name="function" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="threads_add_timeout" symbol="gdk_threads_add_timeout">
			<return-type type="guint"/>
			<parameters>
				<parameter name="interval" type="guint"/>
				<parameter name="function" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="threads_add_timeout_full" symbol="gdk_threads_add_timeout_full">
			<return-type type="guint"/>
			<parameters>
				<parameter name="priority" type="gint"/>
				<parameter name="interval" type="guint"/>
				<parameter name="function" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="threads_add_timeout_seconds" symbol="gdk_threads_add_timeout_seconds">
			<return-type type="guint"/>
			<parameters>
				<parameter name="interval" type="guint"/>
				<parameter name="function" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="threads_add_timeout_seconds_full" symbol="gdk_threads_add_timeout_seconds_full">
			<return-type type="guint"/>
			<parameters>
				<parameter name="priority" type="gint"/>
				<parameter name="interval" type="guint"/>
				<parameter name="function" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="threads_enter" symbol="gdk_threads_enter">
			<return-type type="void"/>
		</function>
		<function name="threads_init" symbol="gdk_threads_init">
			<return-type type="void"/>
		</function>
		<function name="threads_leave" symbol="gdk_threads_leave">
			<return-type type="void"/>
		</function>
		<function name="threads_set_lock_functions" symbol="gdk_threads_set_lock_functions">
			<return-type type="void"/>
			<parameters>
				<parameter name="enter_fn" type="GCallback"/>
				<parameter name="leave_fn" type="GCallback"/>
			</parameters>
		</function>
		<function name="unicode_to_keyval" symbol="gdk_unicode_to_keyval">
			<return-type type="guint"/>
			<parameters>
				<parameter name="wc" type="guint32"/>
			</parameters>
		</function>
		<function name="utf8_to_string_target" symbol="gdk_utf8_to_string_target">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<callback name="GdkEventFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="event" type="GdkEvent*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GdkFilterFunc">
			<return-type type="GdkFilterReturn"/>
			<parameters>
				<parameter name="xevent" type="GdkXEvent*"/>
				<parameter name="event" type="GdkEvent*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GdkWindowChildFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GdkAtom">
			<method name="intern" symbol="gdk_atom_intern">
				<return-type type="GdkAtom"/>
				<parameters>
					<parameter name="atom_name" type="gchar*"/>
					<parameter name="only_if_exists" type="gboolean"/>
				</parameters>
			</method>
			<method name="intern_static_string" symbol="gdk_atom_intern_static_string">
				<return-type type="GdkAtom"/>
				<parameters>
					<parameter name="atom_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="name" symbol="gdk_atom_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="atom" type="GdkAtom"/>
				</parameters>
			</method>
		</struct>
		<struct name="GdkEventAny">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
		</struct>
		<struct name="GdkEventButton">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="time" type="guint32"/>
			<field name="x" type="gdouble"/>
			<field name="y" type="gdouble"/>
			<field name="axes" type="gdouble*"/>
			<field name="state" type="guint"/>
			<field name="button" type="guint"/>
			<field name="device" type="GdkDevice*"/>
			<field name="x_root" type="gdouble"/>
			<field name="y_root" type="gdouble"/>
		</struct>
		<struct name="GdkEventClient">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="message_type" type="GdkAtom"/>
			<field name="data_format" type="gushort"/>
			<field name="data" type="gpointer"/>
		</struct>
		<struct name="GdkEventConfigure">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
			<field name="width" type="gint"/>
			<field name="height" type="gint"/>
		</struct>
		<struct name="GdkEventCrossing">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="subwindow" type="GdkWindow*"/>
			<field name="time" type="guint32"/>
			<field name="x" type="gdouble"/>
			<field name="y" type="gdouble"/>
			<field name="x_root" type="gdouble"/>
			<field name="y_root" type="gdouble"/>
			<field name="mode" type="GdkCrossingMode"/>
			<field name="detail" type="GdkNotifyType"/>
			<field name="focus" type="gboolean"/>
			<field name="state" type="guint"/>
		</struct>
		<struct name="GdkEventDND">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="context" type="GdkDragContext*"/>
			<field name="time" type="guint32"/>
			<field name="x_root" type="gshort"/>
			<field name="y_root" type="gshort"/>
		</struct>
		<struct name="GdkEventExpose">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="area" type="GdkRectangle"/>
			<field name="region" type="cairo_region_t*"/>
			<field name="count" type="gint"/>
		</struct>
		<struct name="GdkEventFocus">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="in" type="gint16"/>
		</struct>
		<struct name="GdkEventGrabBroken">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="keyboard" type="gboolean"/>
			<field name="implicit" type="gboolean"/>
			<field name="grab_window" type="GdkWindow*"/>
		</struct>
		<struct name="GdkEventKey">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="time" type="guint32"/>
			<field name="state" type="guint"/>
			<field name="keyval" type="guint"/>
			<field name="length" type="gint"/>
			<field name="string" type="gchar*"/>
			<field name="hardware_keycode" type="guint16"/>
			<field name="group" type="guint8"/>
			<field name="is_modifier" type="guint"/>
		</struct>
		<struct name="GdkEventMotion">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="time" type="guint32"/>
			<field name="x" type="gdouble"/>
			<field name="y" type="gdouble"/>
			<field name="axes" type="gdouble*"/>
			<field name="state" type="guint"/>
			<field name="is_hint" type="gint16"/>
			<field name="device" type="GdkDevice*"/>
			<field name="x_root" type="gdouble"/>
			<field name="y_root" type="gdouble"/>
		</struct>
		<struct name="GdkEventOwnerChange">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="owner" type="GdkNativeWindow"/>
			<field name="reason" type="GdkOwnerChange"/>
			<field name="selection" type="GdkAtom"/>
			<field name="time" type="guint32"/>
			<field name="selection_time" type="guint32"/>
		</struct>
		<struct name="GdkEventProperty">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="atom" type="GdkAtom"/>
			<field name="time" type="guint32"/>
			<field name="state" type="guint"/>
		</struct>
		<struct name="GdkEventProximity">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="time" type="guint32"/>
			<field name="device" type="GdkDevice*"/>
		</struct>
		<struct name="GdkEventScroll">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="time" type="guint32"/>
			<field name="x" type="gdouble"/>
			<field name="y" type="gdouble"/>
			<field name="state" type="guint"/>
			<field name="direction" type="GdkScrollDirection"/>
			<field name="device" type="GdkDevice*"/>
			<field name="x_root" type="gdouble"/>
			<field name="y_root" type="gdouble"/>
		</struct>
		<struct name="GdkEventSelection">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="selection" type="GdkAtom"/>
			<field name="target" type="GdkAtom"/>
			<field name="property" type="GdkAtom"/>
			<field name="time" type="guint32"/>
			<field name="requestor" type="GdkNativeWindow"/>
		</struct>
		<struct name="GdkEventSetting">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="action" type="GdkSettingAction"/>
			<field name="name" type="char*"/>
		</struct>
		<struct name="GdkEventVisibility">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="state" type="GdkVisibilityState"/>
		</struct>
		<struct name="GdkEventWindowState">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
			<field name="changed_mask" type="GdkWindowState"/>
			<field name="new_window_state" type="GdkWindowState"/>
		</struct>
		<struct name="GdkGeometry">
			<field name="min_width" type="gint"/>
			<field name="min_height" type="gint"/>
			<field name="max_width" type="gint"/>
			<field name="max_height" type="gint"/>
			<field name="base_width" type="gint"/>
			<field name="base_height" type="gint"/>
			<field name="width_inc" type="gint"/>
			<field name="height_inc" type="gint"/>
			<field name="min_aspect" type="gdouble"/>
			<field name="max_aspect" type="gdouble"/>
			<field name="win_gravity" type="GdkGravity"/>
		</struct>
		<struct name="GdkKeymapKey">
			<field name="keycode" type="guint"/>
			<field name="group" type="gint"/>
			<field name="level" type="gint"/>
		</struct>
		<struct name="GdkNativeWindow">
		</struct>
		<struct name="GdkPoint">
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
		</struct>
		<struct name="GdkRectangle">
			<method name="intersect" symbol="gdk_rectangle_intersect">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src1" type="GdkRectangle*"/>
					<parameter name="src2" type="GdkRectangle*"/>
					<parameter name="dest" type="GdkRectangle*"/>
				</parameters>
			</method>
			<method name="union" symbol="gdk_rectangle_union">
				<return-type type="void"/>
				<parameters>
					<parameter name="src1" type="GdkRectangle*"/>
					<parameter name="src2" type="GdkRectangle*"/>
					<parameter name="dest" type="GdkRectangle*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GdkTimeCoord">
			<field name="time" type="guint32"/>
			<field name="axes" type="gdouble[]"/>
		</struct>
		<struct name="GdkWindowAttr">
			<field name="title" type="gchar*"/>
			<field name="event_mask" type="gint"/>
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
			<field name="width" type="gint"/>
			<field name="height" type="gint"/>
			<field name="wclass" type="GdkWindowWindowClass"/>
			<field name="visual" type="GdkVisual*"/>
			<field name="window_type" type="GdkWindowType"/>
			<field name="cursor" type="GdkCursor*"/>
			<field name="wmclass_name" type="gchar*"/>
			<field name="wmclass_class" type="gchar*"/>
			<field name="override_redirect" type="gboolean"/>
			<field name="type_hint" type="GdkWindowTypeHint"/>
		</struct>
		<struct name="GdkWindowRedirect">
		</struct>
		<struct name="GdkXEvent">
		</struct>
		<boxed name="GdkColor" type-name="GdkColor" get-type="gdk_color_get_type">
			<method name="copy" symbol="gdk_color_copy">
				<return-type type="GdkColor*"/>
				<parameters>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="equal" symbol="gdk_color_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="colora" type="GdkColor*"/>
					<parameter name="colorb" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdk_color_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="hash" symbol="gdk_color_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="colora" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="parse" symbol="gdk_color_parse">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="spec" type="gchar*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="gdk_color_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<field name="pixel" type="guint32"/>
			<field name="red" type="guint16"/>
			<field name="green" type="guint16"/>
			<field name="blue" type="guint16"/>
		</boxed>
		<boxed name="GdkEvent" type-name="GdkEvent" get-type="gdk_event_get_type">
			<method name="copy" symbol="gdk_event_copy">
				<return-type type="GdkEvent*"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdk_event_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</method>
			<method name="get" symbol="gdk_event_get">
				<return-type type="GdkEvent*"/>
			</method>
			<method name="get_axis" symbol="gdk_event_get_axis">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
					<parameter name="axis_use" type="GdkAxisUse"/>
					<parameter name="value" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_coords" symbol="gdk_event_get_coords">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
					<parameter name="x_win" type="gdouble*"/>
					<parameter name="y_win" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_device" symbol="gdk_event_get_device">
				<return-type type="GdkDevice*"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</method>
			<method name="get_root_coords" symbol="gdk_event_get_root_coords">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
					<parameter name="x_root" type="gdouble*"/>
					<parameter name="y_root" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="gdk_event_get_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</method>
			<method name="get_source_device" symbol="gdk_event_get_source_device">
				<return-type type="GdkDevice*"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="gdk_event_get_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
					<parameter name="state" type="GdkModifierType*"/>
				</parameters>
			</method>
			<method name="get_time" symbol="gdk_event_get_time">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</method>
			<method name="handler_set" symbol="gdk_event_handler_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="func" type="GdkEventFunc"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdk_event_new">
				<return-type type="GdkEvent*"/>
				<parameters>
					<parameter name="type" type="GdkEventType"/>
				</parameters>
			</constructor>
			<method name="peek" symbol="gdk_event_peek">
				<return-type type="GdkEvent*"/>
			</method>
			<method name="put" symbol="gdk_event_put">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</method>
			<method name="request_motions" symbol="gdk_event_request_motions">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdkEventMotion*"/>
				</parameters>
			</method>
			<method name="send_client_message" symbol="gdk_event_send_client_message">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
					<parameter name="winid" type="GdkNativeWindow"/>
				</parameters>
			</method>
			<method name="send_client_message_for_display" symbol="gdk_event_send_client_message_for_display">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="event" type="GdkEvent*"/>
					<parameter name="winid" type="GdkNativeWindow"/>
				</parameters>
			</method>
			<method name="send_clientmessage_toall" symbol="gdk_event_send_clientmessage_toall">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</method>
			<method name="set_device" symbol="gdk_event_set_device">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="set_screen" symbol="gdk_event_set_screen">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="set_source_device" symbol="gdk_event_set_source_device">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<field name="type" type="GdkEventType"/>
			<field name="any" type="GdkEventAny"/>
			<field name="expose" type="GdkEventExpose"/>
			<field name="visibility" type="GdkEventVisibility"/>
			<field name="motion" type="GdkEventMotion"/>
			<field name="button" type="GdkEventButton"/>
			<field name="scroll" type="GdkEventScroll"/>
			<field name="key" type="GdkEventKey"/>
			<field name="crossing" type="GdkEventCrossing"/>
			<field name="focus_change" type="GdkEventFocus"/>
			<field name="configure" type="GdkEventConfigure"/>
			<field name="property" type="GdkEventProperty"/>
			<field name="selection" type="GdkEventSelection"/>
			<field name="owner_change" type="GdkEventOwnerChange"/>
			<field name="proximity" type="GdkEventProximity"/>
			<field name="client" type="GdkEventClient"/>
			<field name="dnd" type="GdkEventDND"/>
			<field name="window_state" type="GdkEventWindowState"/>
			<field name="setting" type="GdkEventSetting"/>
			<field name="grab_broken" type="GdkEventGrabBroken"/>
		</boxed>
		<boxed name="GdkRGBA" type-name="GdkRGBA" get-type="gdk_rgba_get_type">
			<method name="copy" symbol="gdk_rgba_copy">
				<return-type type="GdkRGBA*"/>
				<parameters>
					<parameter name="rgba" type="GdkRGBA*"/>
				</parameters>
			</method>
			<method name="equal" symbol="gdk_rgba_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="p1" type="gconstpointer"/>
					<parameter name="p2" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gdk_rgba_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="rgba" type="GdkRGBA*"/>
				</parameters>
			</method>
			<method name="hash" symbol="gdk_rgba_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="p" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="parse" symbol="gdk_rgba_parse">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="rgba" type="GdkRGBA*"/>
					<parameter name="spec" type="gchar*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="gdk_rgba_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="rgba" type="GdkRGBA*"/>
				</parameters>
			</method>
			<field name="red" type="gdouble"/>
			<field name="green" type="gdouble"/>
			<field name="blue" type="gdouble"/>
			<field name="alpha" type="gdouble"/>
		</boxed>
		<boxed name="GdkRectangle" type-name="GdkRectangle" get-type="gdk_rectangle_get_type">
		</boxed>
		<enum name="GdkAxisUse" type-name="GdkAxisUse" get-type="gdk_axis_use_get_type">
			<member name="GDK_AXIS_IGNORE" value="0"/>
			<member name="GDK_AXIS_X" value="1"/>
			<member name="GDK_AXIS_Y" value="2"/>
			<member name="GDK_AXIS_PRESSURE" value="3"/>
			<member name="GDK_AXIS_XTILT" value="4"/>
			<member name="GDK_AXIS_YTILT" value="5"/>
			<member name="GDK_AXIS_WHEEL" value="6"/>
			<member name="GDK_AXIS_LAST" value="7"/>
		</enum>
		<enum name="GdkByteOrder" type-name="GdkByteOrder" get-type="gdk_byte_order_get_type">
			<member name="GDK_LSB_FIRST" value="0"/>
			<member name="GDK_MSB_FIRST" value="1"/>
		</enum>
		<enum name="GdkCrossingMode" type-name="GdkCrossingMode" get-type="gdk_crossing_mode_get_type">
			<member name="GDK_CROSSING_NORMAL" value="0"/>
			<member name="GDK_CROSSING_GRAB" value="1"/>
			<member name="GDK_CROSSING_UNGRAB" value="2"/>
			<member name="GDK_CROSSING_GTK_GRAB" value="3"/>
			<member name="GDK_CROSSING_GTK_UNGRAB" value="4"/>
			<member name="GDK_CROSSING_STATE_CHANGED" value="5"/>
		</enum>
		<enum name="GdkCursorType" type-name="GdkCursorType" get-type="gdk_cursor_type_get_type">
			<member name="GDK_X_CURSOR" value="0"/>
			<member name="GDK_ARROW" value="2"/>
			<member name="GDK_BASED_ARROW_DOWN" value="4"/>
			<member name="GDK_BASED_ARROW_UP" value="6"/>
			<member name="GDK_BOAT" value="8"/>
			<member name="GDK_BOGOSITY" value="10"/>
			<member name="GDK_BOTTOM_LEFT_CORNER" value="12"/>
			<member name="GDK_BOTTOM_RIGHT_CORNER" value="14"/>
			<member name="GDK_BOTTOM_SIDE" value="16"/>
			<member name="GDK_BOTTOM_TEE" value="18"/>
			<member name="GDK_BOX_SPIRAL" value="20"/>
			<member name="GDK_CENTER_PTR" value="22"/>
			<member name="GDK_CIRCLE" value="24"/>
			<member name="GDK_CLOCK" value="26"/>
			<member name="GDK_COFFEE_MUG" value="28"/>
			<member name="GDK_CROSS" value="30"/>
			<member name="GDK_CROSS_REVERSE" value="32"/>
			<member name="GDK_CROSSHAIR" value="34"/>
			<member name="GDK_DIAMOND_CROSS" value="36"/>
			<member name="GDK_DOT" value="38"/>
			<member name="GDK_DOTBOX" value="40"/>
			<member name="GDK_DOUBLE_ARROW" value="42"/>
			<member name="GDK_DRAFT_LARGE" value="44"/>
			<member name="GDK_DRAFT_SMALL" value="46"/>
			<member name="GDK_DRAPED_BOX" value="48"/>
			<member name="GDK_EXCHANGE" value="50"/>
			<member name="GDK_FLEUR" value="52"/>
			<member name="GDK_GOBBLER" value="54"/>
			<member name="GDK_GUMBY" value="56"/>
			<member name="GDK_HAND1" value="58"/>
			<member name="GDK_HAND2" value="60"/>
			<member name="GDK_HEART" value="62"/>
			<member name="GDK_ICON" value="64"/>
			<member name="GDK_IRON_CROSS" value="66"/>
			<member name="GDK_LEFT_PTR" value="68"/>
			<member name="GDK_LEFT_SIDE" value="70"/>
			<member name="GDK_LEFT_TEE" value="72"/>
			<member name="GDK_LEFTBUTTON" value="74"/>
			<member name="GDK_LL_ANGLE" value="76"/>
			<member name="GDK_LR_ANGLE" value="78"/>
			<member name="GDK_MAN" value="80"/>
			<member name="GDK_MIDDLEBUTTON" value="82"/>
			<member name="GDK_MOUSE" value="84"/>
			<member name="GDK_PENCIL" value="86"/>
			<member name="GDK_PIRATE" value="88"/>
			<member name="GDK_PLUS" value="90"/>
			<member name="GDK_QUESTION_ARROW" value="92"/>
			<member name="GDK_RIGHT_PTR" value="94"/>
			<member name="GDK_RIGHT_SIDE" value="96"/>
			<member name="GDK_RIGHT_TEE" value="98"/>
			<member name="GDK_RIGHTBUTTON" value="100"/>
			<member name="GDK_RTL_LOGO" value="102"/>
			<member name="GDK_SAILBOAT" value="104"/>
			<member name="GDK_SB_DOWN_ARROW" value="106"/>
			<member name="GDK_SB_H_DOUBLE_ARROW" value="108"/>
			<member name="GDK_SB_LEFT_ARROW" value="110"/>
			<member name="GDK_SB_RIGHT_ARROW" value="112"/>
			<member name="GDK_SB_UP_ARROW" value="114"/>
			<member name="GDK_SB_V_DOUBLE_ARROW" value="116"/>
			<member name="GDK_SHUTTLE" value="118"/>
			<member name="GDK_SIZING" value="120"/>
			<member name="GDK_SPIDER" value="122"/>
			<member name="GDK_SPRAYCAN" value="124"/>
			<member name="GDK_STAR" value="126"/>
			<member name="GDK_TARGET" value="128"/>
			<member name="GDK_TCROSS" value="130"/>
			<member name="GDK_TOP_LEFT_ARROW" value="132"/>
			<member name="GDK_TOP_LEFT_CORNER" value="134"/>
			<member name="GDK_TOP_RIGHT_CORNER" value="136"/>
			<member name="GDK_TOP_SIDE" value="138"/>
			<member name="GDK_TOP_TEE" value="140"/>
			<member name="GDK_TREK" value="142"/>
			<member name="GDK_UL_ANGLE" value="144"/>
			<member name="GDK_UMBRELLA" value="146"/>
			<member name="GDK_UR_ANGLE" value="148"/>
			<member name="GDK_WATCH" value="150"/>
			<member name="GDK_XTERM" value="152"/>
			<member name="GDK_LAST_CURSOR" value="153"/>
			<member name="GDK_BLANK_CURSOR" value="-2"/>
			<member name="GDK_CURSOR_IS_PIXMAP" value="-1"/>
		</enum>
		<enum name="GdkDeviceType" type-name="GdkDeviceType" get-type="gdk_device_type_get_type">
			<member name="GDK_DEVICE_TYPE_MASTER" value="0"/>
			<member name="GDK_DEVICE_TYPE_SLAVE" value="1"/>
			<member name="GDK_DEVICE_TYPE_FLOATING" value="2"/>
		</enum>
		<enum name="GdkDragProtocol" type-name="GdkDragProtocol" get-type="gdk_drag_protocol_get_type">
			<member name="GDK_DRAG_PROTO_MOTIF" value="0"/>
			<member name="GDK_DRAG_PROTO_XDND" value="1"/>
			<member name="GDK_DRAG_PROTO_ROOTWIN" value="2"/>
			<member name="GDK_DRAG_PROTO_NONE" value="3"/>
			<member name="GDK_DRAG_PROTO_WIN32_DROPFILES" value="4"/>
			<member name="GDK_DRAG_PROTO_OLE2" value="5"/>
			<member name="GDK_DRAG_PROTO_LOCAL" value="6"/>
		</enum>
		<enum name="GdkEventType" type-name="GdkEventType" get-type="gdk_event_type_get_type">
			<member name="GDK_NOTHING" value="-1"/>
			<member name="GDK_DELETE" value="0"/>
			<member name="GDK_DESTROY" value="1"/>
			<member name="GDK_EXPOSE" value="2"/>
			<member name="GDK_MOTION_NOTIFY" value="3"/>
			<member name="GDK_BUTTON_PRESS" value="4"/>
			<member name="GDK_2BUTTON_PRESS" value="5"/>
			<member name="GDK_3BUTTON_PRESS" value="6"/>
			<member name="GDK_BUTTON_RELEASE" value="7"/>
			<member name="GDK_KEY_PRESS" value="8"/>
			<member name="GDK_KEY_RELEASE" value="9"/>
			<member name="GDK_ENTER_NOTIFY" value="10"/>
			<member name="GDK_LEAVE_NOTIFY" value="11"/>
			<member name="GDK_FOCUS_CHANGE" value="12"/>
			<member name="GDK_CONFIGURE" value="13"/>
			<member name="GDK_MAP" value="14"/>
			<member name="GDK_UNMAP" value="15"/>
			<member name="GDK_PROPERTY_NOTIFY" value="16"/>
			<member name="GDK_SELECTION_CLEAR" value="17"/>
			<member name="GDK_SELECTION_REQUEST" value="18"/>
			<member name="GDK_SELECTION_NOTIFY" value="19"/>
			<member name="GDK_PROXIMITY_IN" value="20"/>
			<member name="GDK_PROXIMITY_OUT" value="21"/>
			<member name="GDK_DRAG_ENTER" value="22"/>
			<member name="GDK_DRAG_LEAVE" value="23"/>
			<member name="GDK_DRAG_MOTION" value="24"/>
			<member name="GDK_DRAG_STATUS" value="25"/>
			<member name="GDK_DROP_START" value="26"/>
			<member name="GDK_DROP_FINISHED" value="27"/>
			<member name="GDK_CLIENT_EVENT" value="28"/>
			<member name="GDK_VISIBILITY_NOTIFY" value="29"/>
			<member name="GDK_SCROLL" value="31"/>
			<member name="GDK_WINDOW_STATE" value="32"/>
			<member name="GDK_SETTING" value="33"/>
			<member name="GDK_OWNER_CHANGE" value="34"/>
			<member name="GDK_GRAB_BROKEN" value="35"/>
			<member name="GDK_DAMAGE" value="36"/>
			<member name="GDK_EVENT_LAST" value="37"/>
		</enum>
		<enum name="GdkExtensionMode" type-name="GdkExtensionMode" get-type="gdk_extension_mode_get_type">
			<member name="GDK_EXTENSION_EVENTS_NONE" value="0"/>
			<member name="GDK_EXTENSION_EVENTS_ALL" value="1"/>
			<member name="GDK_EXTENSION_EVENTS_CURSOR" value="2"/>
		</enum>
		<enum name="GdkFilterReturn" type-name="GdkFilterReturn" get-type="gdk_filter_return_get_type">
			<member name="GDK_FILTER_CONTINUE" value="0"/>
			<member name="GDK_FILTER_TRANSLATE" value="1"/>
			<member name="GDK_FILTER_REMOVE" value="2"/>
		</enum>
		<enum name="GdkGrabOwnership" type-name="GdkGrabOwnership" get-type="gdk_grab_ownership_get_type">
			<member name="GDK_OWNERSHIP_NONE" value="0"/>
			<member name="GDK_OWNERSHIP_WINDOW" value="1"/>
			<member name="GDK_OWNERSHIP_APPLICATION" value="2"/>
		</enum>
		<enum name="GdkGrabStatus" type-name="GdkGrabStatus" get-type="gdk_grab_status_get_type">
			<member name="GDK_GRAB_SUCCESS" value="0"/>
			<member name="GDK_GRAB_ALREADY_GRABBED" value="1"/>
			<member name="GDK_GRAB_INVALID_TIME" value="2"/>
			<member name="GDK_GRAB_NOT_VIEWABLE" value="3"/>
			<member name="GDK_GRAB_FROZEN" value="4"/>
		</enum>
		<enum name="GdkGravity" type-name="GdkGravity" get-type="gdk_gravity_get_type">
			<member name="GDK_GRAVITY_NORTH_WEST" value="1"/>
			<member name="GDK_GRAVITY_NORTH" value="2"/>
			<member name="GDK_GRAVITY_NORTH_EAST" value="3"/>
			<member name="GDK_GRAVITY_WEST" value="4"/>
			<member name="GDK_GRAVITY_CENTER" value="5"/>
			<member name="GDK_GRAVITY_EAST" value="6"/>
			<member name="GDK_GRAVITY_SOUTH_WEST" value="7"/>
			<member name="GDK_GRAVITY_SOUTH" value="8"/>
			<member name="GDK_GRAVITY_SOUTH_EAST" value="9"/>
			<member name="GDK_GRAVITY_STATIC" value="10"/>
		</enum>
		<enum name="GdkInputMode" type-name="GdkInputMode" get-type="gdk_input_mode_get_type">
			<member name="GDK_MODE_DISABLED" value="0"/>
			<member name="GDK_MODE_SCREEN" value="1"/>
			<member name="GDK_MODE_WINDOW" value="2"/>
		</enum>
		<enum name="GdkInputSource" type-name="GdkInputSource" get-type="gdk_input_source_get_type">
			<member name="GDK_SOURCE_MOUSE" value="0"/>
			<member name="GDK_SOURCE_PEN" value="1"/>
			<member name="GDK_SOURCE_ERASER" value="2"/>
			<member name="GDK_SOURCE_CURSOR" value="3"/>
			<member name="GDK_SOURCE_KEYBOARD" value="4"/>
		</enum>
		<enum name="GdkNotifyType" type-name="GdkNotifyType" get-type="gdk_notify_type_get_type">
			<member name="GDK_NOTIFY_ANCESTOR" value="0"/>
			<member name="GDK_NOTIFY_VIRTUAL" value="1"/>
			<member name="GDK_NOTIFY_INFERIOR" value="2"/>
			<member name="GDK_NOTIFY_NONLINEAR" value="3"/>
			<member name="GDK_NOTIFY_NONLINEAR_VIRTUAL" value="4"/>
			<member name="GDK_NOTIFY_UNKNOWN" value="5"/>
		</enum>
		<enum name="GdkOwnerChange" type-name="GdkOwnerChange" get-type="gdk_owner_change_get_type">
			<member name="GDK_OWNER_CHANGE_NEW_OWNER" value="0"/>
			<member name="GDK_OWNER_CHANGE_DESTROY" value="1"/>
			<member name="GDK_OWNER_CHANGE_CLOSE" value="2"/>
		</enum>
		<enum name="GdkPropMode" type-name="GdkPropMode" get-type="gdk_prop_mode_get_type">
			<member name="GDK_PROP_MODE_REPLACE" value="0"/>
			<member name="GDK_PROP_MODE_PREPEND" value="1"/>
			<member name="GDK_PROP_MODE_APPEND" value="2"/>
		</enum>
		<enum name="GdkPropertyState" type-name="GdkPropertyState" get-type="gdk_property_state_get_type">
			<member name="GDK_PROPERTY_NEW_VALUE" value="0"/>
			<member name="GDK_PROPERTY_DELETE" value="1"/>
		</enum>
		<enum name="GdkScrollDirection" type-name="GdkScrollDirection" get-type="gdk_scroll_direction_get_type">
			<member name="GDK_SCROLL_UP" value="0"/>
			<member name="GDK_SCROLL_DOWN" value="1"/>
			<member name="GDK_SCROLL_LEFT" value="2"/>
			<member name="GDK_SCROLL_RIGHT" value="3"/>
		</enum>
		<enum name="GdkSettingAction" type-name="GdkSettingAction" get-type="gdk_setting_action_get_type">
			<member name="GDK_SETTING_ACTION_NEW" value="0"/>
			<member name="GDK_SETTING_ACTION_CHANGED" value="1"/>
			<member name="GDK_SETTING_ACTION_DELETED" value="2"/>
		</enum>
		<enum name="GdkStatus" type-name="GdkStatus" get-type="gdk_status_get_type">
			<member name="GDK_OK" value="0"/>
			<member name="GDK_ERROR" value="-1"/>
			<member name="GDK_ERROR_PARAM" value="-2"/>
			<member name="GDK_ERROR_FILE" value="-3"/>
			<member name="GDK_ERROR_MEM" value="-4"/>
		</enum>
		<enum name="GdkVisibilityState" type-name="GdkVisibilityState" get-type="gdk_visibility_state_get_type">
			<member name="GDK_VISIBILITY_UNOBSCURED" value="0"/>
			<member name="GDK_VISIBILITY_PARTIAL" value="1"/>
			<member name="GDK_VISIBILITY_FULLY_OBSCURED" value="2"/>
		</enum>
		<enum name="GdkVisualType" type-name="GdkVisualType" get-type="gdk_visual_type_get_type">
			<member name="GDK_VISUAL_STATIC_GRAY" value="0"/>
			<member name="GDK_VISUAL_GRAYSCALE" value="1"/>
			<member name="GDK_VISUAL_STATIC_COLOR" value="2"/>
			<member name="GDK_VISUAL_PSEUDO_COLOR" value="3"/>
			<member name="GDK_VISUAL_TRUE_COLOR" value="4"/>
			<member name="GDK_VISUAL_DIRECT_COLOR" value="5"/>
		</enum>
		<enum name="GdkWindowEdge" type-name="GdkWindowEdge" get-type="gdk_window_edge_get_type">
			<member name="GDK_WINDOW_EDGE_NORTH_WEST" value="0"/>
			<member name="GDK_WINDOW_EDGE_NORTH" value="1"/>
			<member name="GDK_WINDOW_EDGE_NORTH_EAST" value="2"/>
			<member name="GDK_WINDOW_EDGE_WEST" value="3"/>
			<member name="GDK_WINDOW_EDGE_EAST" value="4"/>
			<member name="GDK_WINDOW_EDGE_SOUTH_WEST" value="5"/>
			<member name="GDK_WINDOW_EDGE_SOUTH" value="6"/>
			<member name="GDK_WINDOW_EDGE_SOUTH_EAST" value="7"/>
		</enum>
		<enum name="GdkWindowType" type-name="GdkWindowType" get-type="gdk_window_type_get_type">
			<member name="GDK_WINDOW_ROOT" value="0"/>
			<member name="GDK_WINDOW_TOPLEVEL" value="1"/>
			<member name="GDK_WINDOW_CHILD" value="2"/>
			<member name="GDK_WINDOW_TEMP" value="3"/>
			<member name="GDK_WINDOW_FOREIGN" value="4"/>
			<member name="GDK_WINDOW_OFFSCREEN" value="5"/>
		</enum>
		<enum name="GdkWindowTypeHint" type-name="GdkWindowTypeHint" get-type="gdk_window_type_hint_get_type">
			<member name="GDK_WINDOW_TYPE_HINT_NORMAL" value="0"/>
			<member name="GDK_WINDOW_TYPE_HINT_DIALOG" value="1"/>
			<member name="GDK_WINDOW_TYPE_HINT_MENU" value="2"/>
			<member name="GDK_WINDOW_TYPE_HINT_TOOLBAR" value="3"/>
			<member name="GDK_WINDOW_TYPE_HINT_SPLASHSCREEN" value="4"/>
			<member name="GDK_WINDOW_TYPE_HINT_UTILITY" value="5"/>
			<member name="GDK_WINDOW_TYPE_HINT_DOCK" value="6"/>
			<member name="GDK_WINDOW_TYPE_HINT_DESKTOP" value="7"/>
			<member name="GDK_WINDOW_TYPE_HINT_DROPDOWN_MENU" value="8"/>
			<member name="GDK_WINDOW_TYPE_HINT_POPUP_MENU" value="9"/>
			<member name="GDK_WINDOW_TYPE_HINT_TOOLTIP" value="10"/>
			<member name="GDK_WINDOW_TYPE_HINT_NOTIFICATION" value="11"/>
			<member name="GDK_WINDOW_TYPE_HINT_COMBO" value="12"/>
			<member name="GDK_WINDOW_TYPE_HINT_DND" value="13"/>
		</enum>
		<enum name="GdkWindowWindowClass" type-name="GdkWindowWindowClass" get-type="gdk_window_window_class_get_type">
			<member name="GDK_INPUT_OUTPUT" value="0"/>
			<member name="GDK_INPUT_ONLY" value="1"/>
		</enum>
		<flags name="GdkDragAction" type-name="GdkDragAction" get-type="gdk_drag_action_get_type">
			<member name="GDK_ACTION_DEFAULT" value="1"/>
			<member name="GDK_ACTION_COPY" value="2"/>
			<member name="GDK_ACTION_MOVE" value="4"/>
			<member name="GDK_ACTION_LINK" value="8"/>
			<member name="GDK_ACTION_PRIVATE" value="16"/>
			<member name="GDK_ACTION_ASK" value="32"/>
		</flags>
		<flags name="GdkEventMask" type-name="GdkEventMask" get-type="gdk_event_mask_get_type">
			<member name="GDK_EXPOSURE_MASK" value="2"/>
			<member name="GDK_POINTER_MOTION_MASK" value="4"/>
			<member name="GDK_POINTER_MOTION_HINT_MASK" value="8"/>
			<member name="GDK_BUTTON_MOTION_MASK" value="16"/>
			<member name="GDK_BUTTON1_MOTION_MASK" value="32"/>
			<member name="GDK_BUTTON2_MOTION_MASK" value="64"/>
			<member name="GDK_BUTTON3_MOTION_MASK" value="128"/>
			<member name="GDK_BUTTON_PRESS_MASK" value="256"/>
			<member name="GDK_BUTTON_RELEASE_MASK" value="512"/>
			<member name="GDK_KEY_PRESS_MASK" value="1024"/>
			<member name="GDK_KEY_RELEASE_MASK" value="2048"/>
			<member name="GDK_ENTER_NOTIFY_MASK" value="4096"/>
			<member name="GDK_LEAVE_NOTIFY_MASK" value="8192"/>
			<member name="GDK_FOCUS_CHANGE_MASK" value="16384"/>
			<member name="GDK_STRUCTURE_MASK" value="32768"/>
			<member name="GDK_PROPERTY_CHANGE_MASK" value="65536"/>
			<member name="GDK_VISIBILITY_NOTIFY_MASK" value="131072"/>
			<member name="GDK_PROXIMITY_IN_MASK" value="262144"/>
			<member name="GDK_PROXIMITY_OUT_MASK" value="524288"/>
			<member name="GDK_SUBSTRUCTURE_MASK" value="1048576"/>
			<member name="GDK_SCROLL_MASK" value="2097152"/>
			<member name="GDK_ALL_EVENTS_MASK" value="4194302"/>
		</flags>
		<flags name="GdkModifierType" type-name="GdkModifierType" get-type="gdk_modifier_type_get_type">
			<member name="GDK_SHIFT_MASK" value="1"/>
			<member name="GDK_LOCK_MASK" value="2"/>
			<member name="GDK_CONTROL_MASK" value="4"/>
			<member name="GDK_MOD1_MASK" value="8"/>
			<member name="GDK_MOD2_MASK" value="16"/>
			<member name="GDK_MOD3_MASK" value="32"/>
			<member name="GDK_MOD4_MASK" value="64"/>
			<member name="GDK_MOD5_MASK" value="128"/>
			<member name="GDK_BUTTON1_MASK" value="256"/>
			<member name="GDK_BUTTON2_MASK" value="512"/>
			<member name="GDK_BUTTON3_MASK" value="1024"/>
			<member name="GDK_BUTTON4_MASK" value="2048"/>
			<member name="GDK_BUTTON5_MASK" value="4096"/>
			<member name="GDK_SUPER_MASK" value="67108864"/>
			<member name="GDK_HYPER_MASK" value="134217728"/>
			<member name="GDK_META_MASK" value="268435456"/>
			<member name="GDK_RELEASE_MASK" value="1073741824"/>
			<member name="GDK_MODIFIER_MASK" value="1543512063"/>
		</flags>
		<flags name="GdkWMDecoration" type-name="GdkWMDecoration" get-type="gdk_wm_decoration_get_type">
			<member name="GDK_DECOR_ALL" value="1"/>
			<member name="GDK_DECOR_BORDER" value="2"/>
			<member name="GDK_DECOR_RESIZEH" value="4"/>
			<member name="GDK_DECOR_TITLE" value="8"/>
			<member name="GDK_DECOR_MENU" value="16"/>
			<member name="GDK_DECOR_MINIMIZE" value="32"/>
			<member name="GDK_DECOR_MAXIMIZE" value="64"/>
		</flags>
		<flags name="GdkWMFunction" type-name="GdkWMFunction" get-type="gdk_wm_function_get_type">
			<member name="GDK_FUNC_ALL" value="1"/>
			<member name="GDK_FUNC_RESIZE" value="2"/>
			<member name="GDK_FUNC_MOVE" value="4"/>
			<member name="GDK_FUNC_MINIMIZE" value="8"/>
			<member name="GDK_FUNC_MAXIMIZE" value="16"/>
			<member name="GDK_FUNC_CLOSE" value="32"/>
		</flags>
		<flags name="GdkWindowAttributesType" type-name="GdkWindowAttributesType" get-type="gdk_window_attributes_type_get_type">
			<member name="GDK_WA_TITLE" value="2"/>
			<member name="GDK_WA_X" value="4"/>
			<member name="GDK_WA_Y" value="8"/>
			<member name="GDK_WA_CURSOR" value="16"/>
			<member name="GDK_WA_VISUAL" value="32"/>
			<member name="GDK_WA_WMCLASS" value="64"/>
			<member name="GDK_WA_NOREDIR" value="128"/>
			<member name="GDK_WA_TYPE_HINT" value="256"/>
		</flags>
		<flags name="GdkWindowHints" type-name="GdkWindowHints" get-type="gdk_window_hints_get_type">
			<member name="GDK_HINT_POS" value="1"/>
			<member name="GDK_HINT_MIN_SIZE" value="2"/>
			<member name="GDK_HINT_MAX_SIZE" value="4"/>
			<member name="GDK_HINT_BASE_SIZE" value="8"/>
			<member name="GDK_HINT_ASPECT" value="16"/>
			<member name="GDK_HINT_RESIZE_INC" value="32"/>
			<member name="GDK_HINT_WIN_GRAVITY" value="64"/>
			<member name="GDK_HINT_USER_POS" value="128"/>
			<member name="GDK_HINT_USER_SIZE" value="256"/>
		</flags>
		<flags name="GdkWindowState" type-name="GdkWindowState" get-type="gdk_window_state_get_type">
			<member name="GDK_WINDOW_STATE_WITHDRAWN" value="1"/>
			<member name="GDK_WINDOW_STATE_ICONIFIED" value="2"/>
			<member name="GDK_WINDOW_STATE_MAXIMIZED" value="4"/>
			<member name="GDK_WINDOW_STATE_STICKY" value="8"/>
			<member name="GDK_WINDOW_STATE_FULLSCREEN" value="16"/>
			<member name="GDK_WINDOW_STATE_ABOVE" value="32"/>
			<member name="GDK_WINDOW_STATE_BELOW" value="64"/>
		</flags>
		<object name="GdkAppLaunchContext" parent="GAppLaunchContext" type-name="GdkAppLaunchContext" get-type="gdk_app_launch_context_get_type">
			<method name="set_desktop" symbol="gdk_app_launch_context_set_desktop">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GdkAppLaunchContext*"/>
					<parameter name="desktop" type="gint"/>
				</parameters>
			</method>
			<method name="set_icon" symbol="gdk_app_launch_context_set_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GdkAppLaunchContext*"/>
					<parameter name="icon" type="GIcon*"/>
				</parameters>
			</method>
			<method name="set_icon_name" symbol="gdk_app_launch_context_set_icon_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GdkAppLaunchContext*"/>
					<parameter name="icon_name" type="char*"/>
				</parameters>
			</method>
			<method name="set_screen" symbol="gdk_app_launch_context_set_screen">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GdkAppLaunchContext*"/>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="set_timestamp" symbol="gdk_app_launch_context_set_timestamp">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GdkAppLaunchContext*"/>
					<parameter name="timestamp" type="guint32"/>
				</parameters>
			</method>
			<property name="display" type="GdkDisplay*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdkCursor" parent="GObject" type-name="GdkCursor" get-type="gdk_cursor_get_type">
			<method name="get_cursor_type" symbol="gdk_cursor_get_cursor_type">
				<return-type type="GdkCursorType"/>
				<parameters>
					<parameter name="cursor" type="GdkCursor*"/>
				</parameters>
			</method>
			<method name="get_display" symbol="gdk_cursor_get_display">
				<return-type type="GdkDisplay*"/>
				<parameters>
					<parameter name="cursor" type="GdkCursor*"/>
				</parameters>
			</method>
			<method name="get_image" symbol="gdk_cursor_get_image">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="cursor" type="GdkCursor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdk_cursor_new">
				<return-type type="GdkCursor*"/>
				<parameters>
					<parameter name="cursor_type" type="GdkCursorType"/>
				</parameters>
			</constructor>
			<constructor name="new_for_display" symbol="gdk_cursor_new_for_display">
				<return-type type="GdkCursor*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="cursor_type" type="GdkCursorType"/>
				</parameters>
			</constructor>
			<constructor name="new_from_name" symbol="gdk_cursor_new_from_name">
				<return-type type="GdkCursor*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_pixbuf" symbol="gdk_cursor_new_from_pixbuf">
				<return-type type="GdkCursor*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</constructor>
			<property name="cursor-type" type="GdkCursorType" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="display" type="GdkDisplay*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdkDevice" parent="GObject" type-name="GdkDevice" get-type="gdk_device_get_type">
			<method name="free_history" symbol="gdk_device_free_history">
				<return-type type="void"/>
				<parameters>
					<parameter name="events" type="GdkTimeCoord**"/>
					<parameter name="n_events" type="gint"/>
				</parameters>
			</method>
			<method name="get_associated_device" symbol="gdk_device_get_associated_device">
				<return-type type="GdkDevice*"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="get_axis" symbol="gdk_device_get_axis">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="axes" type="gdouble*"/>
					<parameter name="use" type="GdkAxisUse"/>
					<parameter name="value" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_axis_use" symbol="gdk_device_get_axis_use">
				<return-type type="GdkAxisUse"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="index_" type="guint"/>
				</parameters>
			</method>
			<method name="get_axis_value" symbol="gdk_device_get_axis_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="axes" type="gdouble*"/>
					<parameter name="axis_label" type="GdkAtom"/>
					<parameter name="value" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_device_type" symbol="gdk_device_get_device_type">
				<return-type type="GdkDeviceType"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="get_display" symbol="gdk_device_get_display">
				<return-type type="GdkDisplay*"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="get_has_cursor" symbol="gdk_device_get_has_cursor">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="get_history" symbol="gdk_device_get_history">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="start" type="guint32"/>
					<parameter name="stop" type="guint32"/>
					<parameter name="events" type="GdkTimeCoord***"/>
					<parameter name="n_events" type="gint*"/>
				</parameters>
			</method>
			<method name="get_key" symbol="gdk_device_get_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="index_" type="guint"/>
					<parameter name="keyval" type="guint*"/>
					<parameter name="modifiers" type="GdkModifierType*"/>
				</parameters>
			</method>
			<method name="get_mode" symbol="gdk_device_get_mode">
				<return-type type="GdkInputMode"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="get_n_axes" symbol="gdk_device_get_n_axes">
				<return-type type="gint"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="get_n_keys" symbol="gdk_device_get_n_keys">
				<return-type type="gint"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdk_device_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="get_position" symbol="gdk_device_get_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="screen" type="GdkScreen**"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
				</parameters>
			</method>
			<method name="get_source" symbol="gdk_device_get_source">
				<return-type type="GdkInputSource"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="gdk_device_get_state">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="axes" type="gdouble*"/>
					<parameter name="mask" type="GdkModifierType*"/>
				</parameters>
			</method>
			<method name="get_window_at_position" symbol="gdk_device_get_window_at_position">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="win_x" type="gint*"/>
					<parameter name="win_y" type="gint*"/>
				</parameters>
			</method>
			<method name="grab" symbol="gdk_device_grab">
				<return-type type="GdkGrabStatus"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="grab_ownership" type="GdkGrabOwnership"/>
					<parameter name="owner_events" type="gboolean"/>
					<parameter name="event_mask" type="GdkEventMask"/>
					<parameter name="cursor" type="GdkCursor*"/>
					<parameter name="time_" type="guint32"/>
				</parameters>
			</method>
			<method name="grab_info_libgtk_only" symbol="gdk_device_grab_info_libgtk_only">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="grab_window" type="GdkWindow**"/>
					<parameter name="owner_events" type="gboolean*"/>
				</parameters>
			</method>
			<method name="list_axes" symbol="gdk_device_list_axes">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="list_slave_devices" symbol="gdk_device_list_slave_devices">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="set_axis_use" symbol="gdk_device_set_axis_use">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="index_" type="guint"/>
					<parameter name="use" type="GdkAxisUse"/>
				</parameters>
			</method>
			<method name="set_key" symbol="gdk_device_set_key">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="index_" type="guint"/>
					<parameter name="keyval" type="guint"/>
					<parameter name="modifiers" type="GdkModifierType"/>
				</parameters>
			</method>
			<method name="set_mode" symbol="gdk_device_set_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="mode" type="GdkInputMode"/>
				</parameters>
			</method>
			<method name="ungrab" symbol="gdk_device_ungrab">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="time_" type="guint32"/>
				</parameters>
			</method>
			<method name="warp" symbol="gdk_device_warp">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<property name="associated-device" type="GdkDevice*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="device-manager" type="GdkDeviceManager*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="display" type="GdkDisplay*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="has-cursor" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="input-mode" type="GdkInputMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="input-source" type="GdkInputSource" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="n-axes" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="type" type="GdkDeviceType" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkDevice*"/>
				</parameters>
			</signal>
		</object>
		<object name="GdkDeviceManager" parent="GObject" type-name="GdkDeviceManager" get-type="gdk_device_manager_get_type">
			<method name="get_client_pointer" symbol="gdk_device_manager_get_client_pointer">
				<return-type type="GdkDevice*"/>
				<parameters>
					<parameter name="device_manager" type="GdkDeviceManager*"/>
				</parameters>
			</method>
			<method name="get_display" symbol="gdk_device_manager_get_display">
				<return-type type="GdkDisplay*"/>
				<parameters>
					<parameter name="device_manager" type="GdkDeviceManager*"/>
				</parameters>
			</method>
			<method name="list_devices" symbol="gdk_device_manager_list_devices">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="device_manager" type="GdkDeviceManager*"/>
					<parameter name="type" type="GdkDeviceType"/>
				</parameters>
			</method>
			<property name="display" type="GdkDisplay*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="device-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkDeviceManager*"/>
					<parameter name="p0" type="GdkDevice*"/>
				</parameters>
			</signal>
			<signal name="device-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkDeviceManager*"/>
					<parameter name="p0" type="GdkDevice*"/>
				</parameters>
			</signal>
			<signal name="device-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkDeviceManager*"/>
					<parameter name="p0" type="GdkDevice*"/>
				</parameters>
			</signal>
		</object>
		<object name="GdkDisplay" parent="GObject" type-name="GdkDisplay" get-type="gdk_display_get_type">
			<method name="add_client_message_filter" symbol="gdk_display_add_client_message_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="message_type" type="GdkAtom"/>
					<parameter name="func" type="GdkFilterFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="beep" symbol="gdk_display_beep">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="close" symbol="gdk_display_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="device_is_grabbed" symbol="gdk_display_device_is_grabbed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="flush" symbol="gdk_display_flush">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_app_launch_context" symbol="gdk_display_get_app_launch_context">
				<return-type type="GdkAppLaunchContext*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_default" symbol="gdk_display_get_default">
				<return-type type="GdkDisplay*"/>
			</method>
			<method name="get_default_cursor_size" symbol="gdk_display_get_default_cursor_size">
				<return-type type="guint"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_default_group" symbol="gdk_display_get_default_group">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_default_screen" symbol="gdk_display_get_default_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_device_manager" symbol="gdk_display_get_device_manager">
				<return-type type="GdkDeviceManager*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_event" symbol="gdk_display_get_event">
				<return-type type="GdkEvent*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_maximal_cursor_size" symbol="gdk_display_get_maximal_cursor_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="width" type="guint*"/>
					<parameter name="height" type="guint*"/>
				</parameters>
			</method>
			<method name="get_n_screens" symbol="gdk_display_get_n_screens">
				<return-type type="gint"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdk_display_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="gdk_display_get_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="screen_num" type="gint"/>
				</parameters>
			</method>
			<method name="has_pending" symbol="gdk_display_has_pending">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="is_closed" symbol="gdk_display_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="notify_startup_complete" symbol="gdk_display_notify_startup_complete">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="startup_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="open" symbol="gdk_display_open">
				<return-type type="GdkDisplay*"/>
				<parameters>
					<parameter name="display_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="open_default_libgtk_only" symbol="gdk_display_open_default_libgtk_only">
				<return-type type="GdkDisplay*"/>
			</method>
			<method name="peek_event" symbol="gdk_display_peek_event">
				<return-type type="GdkEvent*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="put_event" symbol="gdk_display_put_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</method>
			<method name="request_selection_notification" symbol="gdk_display_request_selection_notification">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="selection" type="GdkAtom"/>
				</parameters>
			</method>
			<method name="set_double_click_distance" symbol="gdk_display_set_double_click_distance">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="distance" type="guint"/>
				</parameters>
			</method>
			<method name="set_double_click_time" symbol="gdk_display_set_double_click_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="msec" type="guint"/>
				</parameters>
			</method>
			<method name="store_clipboard" symbol="gdk_display_store_clipboard">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="clipboard_window" type="GdkWindow*"/>
					<parameter name="time_" type="guint32"/>
					<parameter name="targets" type="GdkAtom*"/>
					<parameter name="n_targets" type="gint"/>
				</parameters>
			</method>
			<method name="supports_clipboard_persistence" symbol="gdk_display_supports_clipboard_persistence">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="supports_composite" symbol="gdk_display_supports_composite">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="supports_cursor_alpha" symbol="gdk_display_supports_cursor_alpha">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="supports_cursor_color" symbol="gdk_display_supports_cursor_color">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="supports_input_shapes" symbol="gdk_display_supports_input_shapes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="supports_selection_notification" symbol="gdk_display_supports_selection_notification">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="supports_shapes" symbol="gdk_display_supports_shapes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="sync" symbol="gdk_display_sync">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<signal name="closed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkDisplay*"/>
					<parameter name="p0" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="opened" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkDisplay*"/>
				</parameters>
			</signal>
		</object>
		<object name="GdkDisplayManager" parent="GObject" type-name="GdkDisplayManager" get-type="gdk_display_manager_get_type">
			<method name="get" symbol="gdk_display_manager_get">
				<return-type type="GdkDisplayManager*"/>
			</method>
			<method name="get_default_display" symbol="gdk_display_manager_get_default_display">
				<return-type type="GdkDisplay*"/>
				<parameters>
					<parameter name="manager" type="GdkDisplayManager*"/>
				</parameters>
			</method>
			<method name="list_displays" symbol="gdk_display_manager_list_displays">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="manager" type="GdkDisplayManager*"/>
				</parameters>
			</method>
			<method name="open_display" symbol="gdk_display_manager_open_display">
				<return-type type="GdkDisplay*"/>
				<parameters>
					<parameter name="manager" type="GdkDisplayManager*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_default_display" symbol="gdk_display_manager_set_default_display">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GdkDisplayManager*"/>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<property name="default-display" type="GdkDisplay*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="display-opened" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkDisplayManager*"/>
					<parameter name="p0" type="GdkDisplay*"/>
				</parameters>
			</signal>
		</object>
		<object name="GdkDragContext" parent="GObject" type-name="GdkDragContext" get-type="gdk_drag_context_get_type">
			<method name="get_actions" symbol="gdk_drag_context_get_actions">
				<return-type type="GdkDragAction"/>
				<parameters>
					<parameter name="context" type="GdkDragContext*"/>
				</parameters>
			</method>
			<method name="get_dest_window" symbol="gdk_drag_context_get_dest_window">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="context" type="GdkDragContext*"/>
				</parameters>
			</method>
			<method name="get_device" symbol="gdk_drag_context_get_device">
				<return-type type="GdkDevice*"/>
				<parameters>
					<parameter name="context" type="GdkDragContext*"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="gdk_drag_context_get_protocol">
				<return-type type="GdkDragProtocol"/>
				<parameters>
					<parameter name="context" type="GdkDragContext*"/>
				</parameters>
			</method>
			<method name="get_selected_action" symbol="gdk_drag_context_get_selected_action">
				<return-type type="GdkDragAction"/>
				<parameters>
					<parameter name="context" type="GdkDragContext*"/>
				</parameters>
			</method>
			<method name="get_source_window" symbol="gdk_drag_context_get_source_window">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="context" type="GdkDragContext*"/>
				</parameters>
			</method>
			<method name="get_suggested_action" symbol="gdk_drag_context_get_suggested_action">
				<return-type type="GdkDragAction"/>
				<parameters>
					<parameter name="context" type="GdkDragContext*"/>
				</parameters>
			</method>
			<method name="list_targets" symbol="gdk_drag_context_list_targets">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="context" type="GdkDragContext*"/>
				</parameters>
			</method>
			<method name="set_device" symbol="gdk_drag_context_set_device">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GdkDragContext*"/>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
		</object>
		<object name="GdkKeymap" parent="GObject" type-name="GdkKeymap" get-type="gdk_keymap_get_type">
			<method name="add_virtual_modifiers" symbol="gdk_keymap_add_virtual_modifiers">
				<return-type type="void"/>
				<parameters>
					<parameter name="keymap" type="GdkKeymap*"/>
					<parameter name="state" type="GdkModifierType*"/>
				</parameters>
			</method>
			<method name="get_caps_lock_state" symbol="gdk_keymap_get_caps_lock_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="keymap" type="GdkKeymap*"/>
				</parameters>
			</method>
			<method name="get_default" symbol="gdk_keymap_get_default">
				<return-type type="GdkKeymap*"/>
			</method>
			<method name="get_direction" symbol="gdk_keymap_get_direction">
				<return-type type="PangoDirection"/>
				<parameters>
					<parameter name="keymap" type="GdkKeymap*"/>
				</parameters>
			</method>
			<method name="get_entries_for_keycode" symbol="gdk_keymap_get_entries_for_keycode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="keymap" type="GdkKeymap*"/>
					<parameter name="hardware_keycode" type="guint"/>
					<parameter name="keys" type="GdkKeymapKey**"/>
					<parameter name="keyvals" type="guint**"/>
					<parameter name="n_entries" type="gint*"/>
				</parameters>
			</method>
			<method name="get_entries_for_keyval" symbol="gdk_keymap_get_entries_for_keyval">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="keymap" type="GdkKeymap*"/>
					<parameter name="keyval" type="guint"/>
					<parameter name="keys" type="GdkKeymapKey**"/>
					<parameter name="n_keys" type="gint*"/>
				</parameters>
			</method>
			<method name="get_for_display" symbol="gdk_keymap_get_for_display">
				<return-type type="GdkKeymap*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_num_lock_state" symbol="gdk_keymap_get_num_lock_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="keymap" type="GdkKeymap*"/>
				</parameters>
			</method>
			<method name="have_bidi_layouts" symbol="gdk_keymap_have_bidi_layouts">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="keymap" type="GdkKeymap*"/>
				</parameters>
			</method>
			<method name="lookup_key" symbol="gdk_keymap_lookup_key">
				<return-type type="guint"/>
				<parameters>
					<parameter name="keymap" type="GdkKeymap*"/>
					<parameter name="key" type="GdkKeymapKey*"/>
				</parameters>
			</method>
			<method name="map_virtual_modifiers" symbol="gdk_keymap_map_virtual_modifiers">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="keymap" type="GdkKeymap*"/>
					<parameter name="state" type="GdkModifierType*"/>
				</parameters>
			</method>
			<method name="translate_keyboard_state" symbol="gdk_keymap_translate_keyboard_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="keymap" type="GdkKeymap*"/>
					<parameter name="hardware_keycode" type="guint"/>
					<parameter name="state" type="GdkModifierType"/>
					<parameter name="group" type="gint"/>
					<parameter name="keyval" type="guint*"/>
					<parameter name="effective_group" type="gint*"/>
					<parameter name="level" type="gint*"/>
					<parameter name="consumed_modifiers" type="GdkModifierType*"/>
				</parameters>
			</method>
			<signal name="direction-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkKeymap*"/>
				</parameters>
			</signal>
			<signal name="keys-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkKeymap*"/>
				</parameters>
			</signal>
			<signal name="state-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkKeymap*"/>
				</parameters>
			</signal>
		</object>
		<object name="GdkScreen" parent="GObject" type-name="GdkScreen" get-type="gdk_screen_get_type">
			<method name="broadcast_client_message" symbol="gdk_screen_broadcast_client_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</method>
			<method name="get_active_window" symbol="gdk_screen_get_active_window">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_default" symbol="gdk_screen_get_default">
				<return-type type="GdkScreen*"/>
			</method>
			<method name="get_display" symbol="gdk_screen_get_display">
				<return-type type="GdkDisplay*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_font_options" symbol="gdk_screen_get_font_options">
				<return-type type="cairo_font_options_t*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="gdk_screen_get_height">
				<return-type type="gint"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_height_mm" symbol="gdk_screen_get_height_mm">
				<return-type type="gint"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_monitor_at_point" symbol="gdk_screen_get_monitor_at_point">
				<return-type type="gint"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="get_monitor_at_window" symbol="gdk_screen_get_monitor_at_window">
				<return-type type="gint"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_monitor_geometry" symbol="gdk_screen_get_monitor_geometry">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="monitor_num" type="gint"/>
					<parameter name="dest" type="GdkRectangle*"/>
				</parameters>
			</method>
			<method name="get_monitor_height_mm" symbol="gdk_screen_get_monitor_height_mm">
				<return-type type="gint"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="monitor_num" type="gint"/>
				</parameters>
			</method>
			<method name="get_monitor_plug_name" symbol="gdk_screen_get_monitor_plug_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="monitor_num" type="gint"/>
				</parameters>
			</method>
			<method name="get_monitor_width_mm" symbol="gdk_screen_get_monitor_width_mm">
				<return-type type="gint"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="monitor_num" type="gint"/>
				</parameters>
			</method>
			<method name="get_n_monitors" symbol="gdk_screen_get_n_monitors">
				<return-type type="gint"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_number" symbol="gdk_screen_get_number">
				<return-type type="gint"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_primary_monitor" symbol="gdk_screen_get_primary_monitor">
				<return-type type="gint"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_resolution" symbol="gdk_screen_get_resolution">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_rgba_visual" symbol="gdk_screen_get_rgba_visual">
				<return-type type="GdkVisual*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_root_window" symbol="gdk_screen_get_root_window">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_setting" symbol="gdk_screen_get_setting">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_system_visual" symbol="gdk_screen_get_system_visual">
				<return-type type="GdkVisual*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_toplevel_windows" symbol="gdk_screen_get_toplevel_windows">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="gdk_screen_get_width">
				<return-type type="gint"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_width_mm" symbol="gdk_screen_get_width_mm">
				<return-type type="gint"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_window_stack" symbol="gdk_screen_get_window_stack">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="height" symbol="gdk_screen_height">
				<return-type type="gint"/>
			</method>
			<method name="height_mm" symbol="gdk_screen_height_mm">
				<return-type type="gint"/>
			</method>
			<method name="is_composited" symbol="gdk_screen_is_composited">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="list_visuals" symbol="gdk_screen_list_visuals">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="make_display_name" symbol="gdk_screen_make_display_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="set_font_options" symbol="gdk_screen_set_font_options">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="options" type="cairo_font_options_t*"/>
				</parameters>
			</method>
			<method name="set_resolution" symbol="gdk_screen_set_resolution">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="dpi" type="gdouble"/>
				</parameters>
			</method>
			<method name="width" symbol="gdk_screen_width">
				<return-type type="gint"/>
			</method>
			<method name="width_mm" symbol="gdk_screen_width_mm">
				<return-type type="gint"/>
			</method>
			<property name="font-options" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="resolution" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="composited-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkScreen*"/>
				</parameters>
			</signal>
			<signal name="monitors-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkScreen*"/>
				</parameters>
			</signal>
			<signal name="size-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkScreen*"/>
				</parameters>
			</signal>
		</object>
		<object name="GdkVisual" parent="GObject" type-name="GdkVisual" get-type="gdk_visual_get_type">
			<method name="get_best" symbol="gdk_visual_get_best">
				<return-type type="GdkVisual*"/>
			</method>
			<method name="get_best_depth" symbol="gdk_visual_get_best_depth">
				<return-type type="gint"/>
			</method>
			<method name="get_best_type" symbol="gdk_visual_get_best_type">
				<return-type type="GdkVisualType"/>
			</method>
			<method name="get_best_with_both" symbol="gdk_visual_get_best_with_both">
				<return-type type="GdkVisual*"/>
				<parameters>
					<parameter name="depth" type="gint"/>
					<parameter name="visual_type" type="GdkVisualType"/>
				</parameters>
			</method>
			<method name="get_best_with_depth" symbol="gdk_visual_get_best_with_depth">
				<return-type type="GdkVisual*"/>
				<parameters>
					<parameter name="depth" type="gint"/>
				</parameters>
			</method>
			<method name="get_best_with_type" symbol="gdk_visual_get_best_with_type">
				<return-type type="GdkVisual*"/>
				<parameters>
					<parameter name="visual_type" type="GdkVisualType"/>
				</parameters>
			</method>
			<method name="get_bits_per_rgb" symbol="gdk_visual_get_bits_per_rgb">
				<return-type type="gint"/>
				<parameters>
					<parameter name="visual" type="GdkVisual*"/>
				</parameters>
			</method>
			<method name="get_blue_pixel_details" symbol="gdk_visual_get_blue_pixel_details">
				<return-type type="void"/>
				<parameters>
					<parameter name="visual" type="GdkVisual*"/>
					<parameter name="mask" type="guint32*"/>
					<parameter name="shift" type="gint*"/>
					<parameter name="precision" type="gint*"/>
				</parameters>
			</method>
			<method name="get_byte_order" symbol="gdk_visual_get_byte_order">
				<return-type type="GdkByteOrder"/>
				<parameters>
					<parameter name="visual" type="GdkVisual*"/>
				</parameters>
			</method>
			<method name="get_colormap_size" symbol="gdk_visual_get_colormap_size">
				<return-type type="gint"/>
				<parameters>
					<parameter name="visual" type="GdkVisual*"/>
				</parameters>
			</method>
			<method name="get_depth" symbol="gdk_visual_get_depth">
				<return-type type="gint"/>
				<parameters>
					<parameter name="visual" type="GdkVisual*"/>
				</parameters>
			</method>
			<method name="get_green_pixel_details" symbol="gdk_visual_get_green_pixel_details">
				<return-type type="void"/>
				<parameters>
					<parameter name="visual" type="GdkVisual*"/>
					<parameter name="mask" type="guint32*"/>
					<parameter name="shift" type="gint*"/>
					<parameter name="precision" type="gint*"/>
				</parameters>
			</method>
			<method name="get_red_pixel_details" symbol="gdk_visual_get_red_pixel_details">
				<return-type type="void"/>
				<parameters>
					<parameter name="visual" type="GdkVisual*"/>
					<parameter name="mask" type="guint32*"/>
					<parameter name="shift" type="gint*"/>
					<parameter name="precision" type="gint*"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="gdk_visual_get_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="visual" type="GdkVisual*"/>
				</parameters>
			</method>
			<method name="get_system" symbol="gdk_visual_get_system">
				<return-type type="GdkVisual*"/>
			</method>
			<method name="get_visual_type" symbol="gdk_visual_get_visual_type">
				<return-type type="GdkVisualType"/>
				<parameters>
					<parameter name="visual" type="GdkVisual*"/>
				</parameters>
			</method>
		</object>
		<object name="GdkWindow" parent="GObject" type-name="GdkWindow" get-type="gdk_window_get_type">
			<method name="add_filter" symbol="gdk_window_add_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="function" type="GdkFilterFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="at_pointer" symbol="gdk_window_at_pointer">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="win_x" type="gint*"/>
					<parameter name="win_y" type="gint*"/>
				</parameters>
			</method>
			<method name="beep" symbol="gdk_window_beep">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="begin_move_drag" symbol="gdk_window_begin_move_drag">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="button" type="gint"/>
					<parameter name="root_x" type="gint"/>
					<parameter name="root_y" type="gint"/>
					<parameter name="timestamp" type="guint32"/>
				</parameters>
			</method>
			<method name="begin_paint_rect" symbol="gdk_window_begin_paint_rect">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="rectangle" type="GdkRectangle*"/>
				</parameters>
			</method>
			<method name="begin_paint_region" symbol="gdk_window_begin_paint_region">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="region" type="cairo_region_t*"/>
				</parameters>
			</method>
			<method name="begin_resize_drag" symbol="gdk_window_begin_resize_drag">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="edge" type="GdkWindowEdge"/>
					<parameter name="button" type="gint"/>
					<parameter name="root_x" type="gint"/>
					<parameter name="root_y" type="gint"/>
					<parameter name="timestamp" type="guint32"/>
				</parameters>
			</method>
			<method name="configure_finished" symbol="gdk_window_configure_finished">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="constrain_size" symbol="gdk_window_constrain_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="geometry" type="GdkGeometry*"/>
					<parameter name="flags" type="guint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="new_width" type="gint*"/>
					<parameter name="new_height" type="gint*"/>
				</parameters>
			</method>
			<method name="coords_from_parent" symbol="gdk_window_coords_from_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="parent_x" type="gdouble"/>
					<parameter name="parent_y" type="gdouble"/>
					<parameter name="x" type="gdouble*"/>
					<parameter name="y" type="gdouble*"/>
				</parameters>
			</method>
			<method name="coords_to_parent" symbol="gdk_window_coords_to_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="parent_x" type="gdouble*"/>
					<parameter name="parent_y" type="gdouble*"/>
				</parameters>
			</method>
			<method name="create_similar_surface" symbol="gdk_window_create_similar_surface">
				<return-type type="cairo_surface_t*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="content" type="cairo_content_t"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</method>
			<method name="deiconify" symbol="gdk_window_deiconify">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="gdk_window_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="enable_synchronized_configure" symbol="gdk_window_enable_synchronized_configure">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="end_paint" symbol="gdk_window_end_paint">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="ensure_native" symbol="gdk_window_ensure_native">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="flush" symbol="gdk_window_flush">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="focus" symbol="gdk_window_focus">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="timestamp" type="guint32"/>
				</parameters>
			</method>
			<method name="freeze_toplevel_updates_libgtk_only" symbol="gdk_window_freeze_toplevel_updates_libgtk_only">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="freeze_updates" symbol="gdk_window_freeze_updates">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="fullscreen" symbol="gdk_window_fullscreen">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="geometry_changed" symbol="gdk_window_geometry_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_accept_focus" symbol="gdk_window_get_accept_focus">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_background_pattern" symbol="gdk_window_get_background_pattern">
				<return-type type="cairo_pattern_t*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_children" symbol="gdk_window_get_children">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_clip_region" symbol="gdk_window_get_clip_region">
				<return-type type="cairo_region_t*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_composited" symbol="gdk_window_get_composited">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_cursor" symbol="gdk_window_get_cursor">
				<return-type type="GdkCursor*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_decorations" symbol="gdk_window_get_decorations">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="decorations" type="GdkWMDecoration*"/>
				</parameters>
			</method>
			<method name="get_device_cursor" symbol="gdk_window_get_device_cursor">
				<return-type type="GdkCursor*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="get_device_events" symbol="gdk_window_get_device_events">
				<return-type type="GdkEventMask"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="device" type="GdkDevice*"/>
				</parameters>
			</method>
			<method name="get_device_position" symbol="gdk_window_get_device_position">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="mask" type="GdkModifierType*"/>
				</parameters>
			</method>
			<method name="get_display" symbol="gdk_window_get_display">
				<return-type type="GdkDisplay*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_effective_parent" symbol="gdk_window_get_effective_parent">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_effective_toplevel" symbol="gdk_window_get_effective_toplevel">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_events" symbol="gdk_window_get_events">
				<return-type type="GdkEventMask"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_focus_on_map" symbol="gdk_window_get_focus_on_map">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_frame_extents" symbol="gdk_window_get_frame_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="rect" type="GdkRectangle*"/>
				</parameters>
			</method>
			<method name="get_geometry" symbol="gdk_window_get_geometry">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
				</parameters>
			</method>
			<method name="get_group" symbol="gdk_window_get_group">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="gdk_window_get_height">
				<return-type type="int"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_modal_hint" symbol="gdk_window_get_modal_hint">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_origin" symbol="gdk_window_get_origin">
				<return-type type="gint"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="gdk_window_get_parent">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_pointer" symbol="gdk_window_get_pointer">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="mask" type="GdkModifierType*"/>
				</parameters>
			</method>
			<method name="get_position" symbol="gdk_window_get_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
				</parameters>
			</method>
			<method name="get_root_coords" symbol="gdk_window_get_root_coords">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="root_x" type="gint*"/>
					<parameter name="root_y" type="gint*"/>
				</parameters>
			</method>
			<method name="get_root_origin" symbol="gdk_window_get_root_origin">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="gdk_window_get_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_source_events" symbol="gdk_window_get_source_events">
				<return-type type="GdkEventMask"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="source" type="GdkInputSource"/>
				</parameters>
			</method>
			<method name="get_state" symbol="gdk_window_get_state">
				<return-type type="GdkWindowState"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_support_multidevice" symbol="gdk_window_get_support_multidevice">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_toplevel" symbol="gdk_window_get_toplevel">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_type_hint" symbol="gdk_window_get_type_hint">
				<return-type type="GdkWindowTypeHint"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_update_area" symbol="gdk_window_get_update_area">
				<return-type type="cairo_region_t*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_user_data" symbol="gdk_window_get_user_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="data" type="gpointer*"/>
				</parameters>
			</method>
			<method name="get_visible_region" symbol="gdk_window_get_visible_region">
				<return-type type="cairo_region_t*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_visual" symbol="gdk_window_get_visual">
				<return-type type="GdkVisual*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="gdk_window_get_width">
				<return-type type="int"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_window_type" symbol="gdk_window_get_window_type">
				<return-type type="GdkWindowType"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="has_native" symbol="gdk_window_has_native">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="hide" symbol="gdk_window_hide">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="iconify" symbol="gdk_window_iconify">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="input_shape_combine_region" symbol="gdk_window_input_shape_combine_region">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="shape_region" type="cairo_region_t*"/>
					<parameter name="offset_x" type="gint"/>
					<parameter name="offset_y" type="gint"/>
				</parameters>
			</method>
			<method name="invalidate_maybe_recurse" symbol="gdk_window_invalidate_maybe_recurse">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="region" type="cairo_region_t*"/>
					<parameter name="child_func" type="GdkWindowChildFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="invalidate_rect" symbol="gdk_window_invalidate_rect">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="rect" type="GdkRectangle*"/>
					<parameter name="invalidate_children" type="gboolean"/>
				</parameters>
			</method>
			<method name="invalidate_region" symbol="gdk_window_invalidate_region">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="region" type="cairo_region_t*"/>
					<parameter name="invalidate_children" type="gboolean"/>
				</parameters>
			</method>
			<method name="is_destroyed" symbol="gdk_window_is_destroyed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="is_input_only" symbol="gdk_window_is_input_only">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="is_shaped" symbol="gdk_window_is_shaped">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="is_viewable" symbol="gdk_window_is_viewable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="is_visible" symbol="gdk_window_is_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="lower" symbol="gdk_window_lower">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="maximize" symbol="gdk_window_maximize">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="merge_child_input_shapes" symbol="gdk_window_merge_child_input_shapes">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="merge_child_shapes" symbol="gdk_window_merge_child_shapes">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="move" symbol="gdk_window_move">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="move_region" symbol="gdk_window_move_region">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="region" type="cairo_region_t*"/>
					<parameter name="dx" type="gint"/>
					<parameter name="dy" type="gint"/>
				</parameters>
			</method>
			<method name="move_resize" symbol="gdk_window_move_resize">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdk_window_new">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="parent" type="GdkWindow*"/>
					<parameter name="attributes" type="GdkWindowAttr*"/>
					<parameter name="attributes_mask" type="gint"/>
				</parameters>
			</constructor>
			<method name="peek_children" symbol="gdk_window_peek_children">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="process_all_updates" symbol="gdk_window_process_all_updates">
				<return-type type="void"/>
			</method>
			<method name="process_updates" symbol="gdk_window_process_updates">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="update_children" type="gboolean"/>
				</parameters>
			</method>
			<method name="raise" symbol="gdk_window_raise">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="register_dnd" symbol="gdk_window_register_dnd">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="remove_filter" symbol="gdk_window_remove_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="function" type="GdkFilterFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="reparent" symbol="gdk_window_reparent">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="new_parent" type="GdkWindow*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="resize" symbol="gdk_window_resize">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<method name="restack" symbol="gdk_window_restack">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="sibling" type="GdkWindow*"/>
					<parameter name="above" type="gboolean"/>
				</parameters>
			</method>
			<method name="scroll" symbol="gdk_window_scroll">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="dx" type="gint"/>
					<parameter name="dy" type="gint"/>
				</parameters>
			</method>
			<method name="set_accept_focus" symbol="gdk_window_set_accept_focus">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="accept_focus" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_background" symbol="gdk_window_set_background">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_background_pattern" symbol="gdk_window_set_background_pattern">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="pattern" type="cairo_pattern_t*"/>
				</parameters>
			</method>
			<method name="set_background_rgba" symbol="gdk_window_set_background_rgba">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="rgba" type="GdkRGBA*"/>
				</parameters>
			</method>
			<method name="set_child_input_shapes" symbol="gdk_window_set_child_input_shapes">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="set_child_shapes" symbol="gdk_window_set_child_shapes">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="set_composited" symbol="gdk_window_set_composited">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="composited" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_cursor" symbol="gdk_window_set_cursor">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="cursor" type="GdkCursor*"/>
				</parameters>
			</method>
			<method name="set_debug_updates" symbol="gdk_window_set_debug_updates">
				<return-type type="void"/>
				<parameters>
					<parameter name="setting" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_decorations" symbol="gdk_window_set_decorations">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="decorations" type="GdkWMDecoration"/>
				</parameters>
			</method>
			<method name="set_device_cursor" symbol="gdk_window_set_device_cursor">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="cursor" type="GdkCursor*"/>
				</parameters>
			</method>
			<method name="set_device_events" symbol="gdk_window_set_device_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="event_mask" type="GdkEventMask"/>
				</parameters>
			</method>
			<method name="set_events" symbol="gdk_window_set_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="event_mask" type="GdkEventMask"/>
				</parameters>
			</method>
			<method name="set_focus_on_map" symbol="gdk_window_set_focus_on_map">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="focus_on_map" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_functions" symbol="gdk_window_set_functions">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="functions" type="GdkWMFunction"/>
				</parameters>
			</method>
			<method name="set_geometry_hints" symbol="gdk_window_set_geometry_hints">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="geometry" type="GdkGeometry*"/>
					<parameter name="geom_mask" type="GdkWindowHints"/>
				</parameters>
			</method>
			<method name="set_group" symbol="gdk_window_set_group">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="leader" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="set_icon_list" symbol="gdk_window_set_icon_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="pixbufs" type="GList*"/>
				</parameters>
			</method>
			<method name="set_icon_name" symbol="gdk_window_set_icon_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_keep_above" symbol="gdk_window_set_keep_above">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="setting" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_keep_below" symbol="gdk_window_set_keep_below">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="setting" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_modal_hint" symbol="gdk_window_set_modal_hint">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="modal" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_opacity" symbol="gdk_window_set_opacity">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="opacity" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_override_redirect" symbol="gdk_window_set_override_redirect">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="override_redirect" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_role" symbol="gdk_window_set_role">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="role" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_skip_pager_hint" symbol="gdk_window_set_skip_pager_hint">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="skips_pager" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_skip_taskbar_hint" symbol="gdk_window_set_skip_taskbar_hint">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="skips_taskbar" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_source_events" symbol="gdk_window_set_source_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="source" type="GdkInputSource"/>
					<parameter name="event_mask" type="GdkEventMask"/>
				</parameters>
			</method>
			<method name="set_startup_id" symbol="gdk_window_set_startup_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="startup_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_static_gravities" symbol="gdk_window_set_static_gravities">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="use_static" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_support_multidevice" symbol="gdk_window_set_support_multidevice">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="support_multidevice" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_title" symbol="gdk_window_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_transient_for" symbol="gdk_window_set_transient_for">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="parent" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="set_type_hint" symbol="gdk_window_set_type_hint">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="hint" type="GdkWindowTypeHint"/>
				</parameters>
			</method>
			<method name="set_urgency_hint" symbol="gdk_window_set_urgency_hint">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="urgent" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_user_data" symbol="gdk_window_set_user_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="shape_combine_region" symbol="gdk_window_shape_combine_region">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="shape_region" type="cairo_region_t*"/>
					<parameter name="offset_x" type="gint"/>
					<parameter name="offset_y" type="gint"/>
				</parameters>
			</method>
			<method name="show" symbol="gdk_window_show">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="show_unraised" symbol="gdk_window_show_unraised">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="stick" symbol="gdk_window_stick">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="thaw_toplevel_updates_libgtk_only" symbol="gdk_window_thaw_toplevel_updates_libgtk_only">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="thaw_updates" symbol="gdk_window_thaw_updates">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="unfullscreen" symbol="gdk_window_unfullscreen">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="unmaximize" symbol="gdk_window_unmaximize">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="unstick" symbol="gdk_window_unstick">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="withdraw" symbol="gdk_window_withdraw">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<property name="cursor" type="GdkCursor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="create-surface" when="LAST">
				<return-type type="CairoSurface*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</signal>
			<signal name="from-embedder" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="embedder_x" type="gdouble"/>
					<parameter name="embedder_y" type="gdouble"/>
					<parameter name="offscreen_x" type="gpointer"/>
					<parameter name="offscreen_y" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="pick-embedded-child" when="LAST">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
				</parameters>
			</signal>
			<signal name="to-embedder" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="offscreen_x" type="gdouble"/>
					<parameter name="offscreen_y" type="gdouble"/>
					<parameter name="embedder_x" type="gpointer"/>
					<parameter name="embedder_y" type="gpointer"/>
				</parameters>
			</signal>
		</object>
		<constant name="GDK_CURRENT_TIME" type="int" value="0"/>
		<constant name="GDK_MAX_TIMECOORD_AXES" type="int" value="128"/>
		<constant name="GDK_PARENT_RELATIVE" type="int" value="1"/>
		<constant name="GDK_PRIORITY_REDRAW" type="int" value="20"/>
	</namespace>
</api>
