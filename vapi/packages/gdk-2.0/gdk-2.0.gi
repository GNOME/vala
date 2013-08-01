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
				<parameter name="drawable" type="GdkDrawable*"/>
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
				<parameter name="region" type="GdkRegion*"/>
			</parameters>
		</function>
		<function name="cairo_reset_clip" symbol="gdk_cairo_reset_clip">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="drawable" type="GdkDrawable*"/>
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
		<function name="cairo_set_source_pixmap" symbol="gdk_cairo_set_source_pixmap">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="pixmap" type="GdkPixmap*"/>
				<parameter name="pixmap_x" type="double"/>
				<parameter name="pixmap_y" type="double"/>
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
		<function name="char_height" symbol="gdk_char_height">
			<return-type type="gint"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="character" type="gchar"/>
			</parameters>
		</function>
		<function name="char_measure" symbol="gdk_char_measure">
			<return-type type="gint"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="character" type="gchar"/>
			</parameters>
		</function>
		<function name="char_width" symbol="gdk_char_width">
			<return-type type="gint"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="character" type="gchar"/>
			</parameters>
		</function>
		<function name="char_width_wc" symbol="gdk_char_width_wc">
			<return-type type="gint"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="character" type="GdkWChar"/>
			</parameters>
		</function>
		<function name="colors_alloc" symbol="gdk_colors_alloc">
			<return-type type="gint"/>
			<parameters>
				<parameter name="colormap" type="GdkColormap*"/>
				<parameter name="contiguous" type="gboolean"/>
				<parameter name="planes" type="gulong*"/>
				<parameter name="nplanes" type="gint"/>
				<parameter name="pixels" type="gulong*"/>
				<parameter name="npixels" type="gint"/>
			</parameters>
		</function>
		<function name="colors_free" symbol="gdk_colors_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="colormap" type="GdkColormap*"/>
				<parameter name="pixels" type="gulong*"/>
				<parameter name="npixels" type="gint"/>
				<parameter name="planes" type="gulong"/>
			</parameters>
		</function>
		<function name="colors_store" symbol="gdk_colors_store">
			<return-type type="void"/>
			<parameters>
				<parameter name="colormap" type="GdkColormap*"/>
				<parameter name="colors" type="GdkColor*"/>
				<parameter name="ncolors" type="gint"/>
			</parameters>
		</function>
		<function name="devices_list" symbol="gdk_devices_list">
			<return-type type="GList*"/>
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
		<function name="drag_find_window" symbol="gdk_drag_find_window">
			<return-type type="void"/>
			<parameters>
				<parameter name="context" type="GdkDragContext*"/>
				<parameter name="drag_window" type="GdkWindow*"/>
				<parameter name="x_root" type="gint"/>
				<parameter name="y_root" type="gint"/>
				<parameter name="dest_window" type="GdkWindow**"/>
				<parameter name="protocol" type="GdkDragProtocol*"/>
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
		<function name="drag_get_protocol" symbol="gdk_drag_get_protocol">
			<return-type type="GdkNativeWindow"/>
			<parameters>
				<parameter name="xid" type="GdkNativeWindow"/>
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
		<function name="draw_arc" symbol="gdk_draw_arc">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="filled" type="gboolean"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
				<parameter name="angle1" type="gint"/>
				<parameter name="angle2" type="gint"/>
			</parameters>
		</function>
		<function name="draw_drawable" symbol="gdk_draw_drawable">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="src" type="GdkDrawable*"/>
				<parameter name="xsrc" type="gint"/>
				<parameter name="ysrc" type="gint"/>
				<parameter name="xdest" type="gint"/>
				<parameter name="ydest" type="gint"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
			</parameters>
		</function>
		<function name="draw_glyphs" symbol="gdk_draw_glyphs">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="font" type="PangoFont*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="glyphs" type="PangoGlyphString*"/>
			</parameters>
		</function>
		<function name="draw_glyphs_transformed" symbol="gdk_draw_glyphs_transformed">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="matrix" type="PangoMatrix*"/>
				<parameter name="font" type="PangoFont*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="glyphs" type="PangoGlyphString*"/>
			</parameters>
		</function>
		<function name="draw_gray_image" symbol="gdk_draw_gray_image">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
				<parameter name="dith" type="GdkRgbDither"/>
				<parameter name="buf" type="guchar*"/>
				<parameter name="rowstride" type="gint"/>
			</parameters>
		</function>
		<function name="draw_image" symbol="gdk_draw_image">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="image" type="GdkImage*"/>
				<parameter name="xsrc" type="gint"/>
				<parameter name="ysrc" type="gint"/>
				<parameter name="xdest" type="gint"/>
				<parameter name="ydest" type="gint"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
			</parameters>
		</function>
		<function name="draw_indexed_image" symbol="gdk_draw_indexed_image">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
				<parameter name="dith" type="GdkRgbDither"/>
				<parameter name="buf" type="guchar*"/>
				<parameter name="rowstride" type="gint"/>
				<parameter name="cmap" type="GdkRgbCmap*"/>
			</parameters>
		</function>
		<function name="draw_layout" symbol="gdk_draw_layout">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="layout" type="PangoLayout*"/>
			</parameters>
		</function>
		<function name="draw_layout_line" symbol="gdk_draw_layout_line">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="line" type="PangoLayoutLine*"/>
			</parameters>
		</function>
		<function name="draw_layout_line_with_colors" symbol="gdk_draw_layout_line_with_colors">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="line" type="PangoLayoutLine*"/>
				<parameter name="foreground" type="GdkColor*"/>
				<parameter name="background" type="GdkColor*"/>
			</parameters>
		</function>
		<function name="draw_layout_with_colors" symbol="gdk_draw_layout_with_colors">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="layout" type="PangoLayout*"/>
				<parameter name="foreground" type="GdkColor*"/>
				<parameter name="background" type="GdkColor*"/>
			</parameters>
		</function>
		<function name="draw_line" symbol="gdk_draw_line">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x1_" type="gint"/>
				<parameter name="y1_" type="gint"/>
				<parameter name="x2_" type="gint"/>
				<parameter name="y2_" type="gint"/>
			</parameters>
		</function>
		<function name="draw_lines" symbol="gdk_draw_lines">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="points" type="GdkPoint*"/>
				<parameter name="n_points" type="gint"/>
			</parameters>
		</function>
		<function name="draw_pixbuf" symbol="gdk_draw_pixbuf">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
				<parameter name="src_x" type="gint"/>
				<parameter name="src_y" type="gint"/>
				<parameter name="dest_x" type="gint"/>
				<parameter name="dest_y" type="gint"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
				<parameter name="dither" type="GdkRgbDither"/>
				<parameter name="x_dither" type="gint"/>
				<parameter name="y_dither" type="gint"/>
			</parameters>
		</function>
		<function name="draw_point" symbol="gdk_draw_point">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
			</parameters>
		</function>
		<function name="draw_points" symbol="gdk_draw_points">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="points" type="GdkPoint*"/>
				<parameter name="n_points" type="gint"/>
			</parameters>
		</function>
		<function name="draw_polygon" symbol="gdk_draw_polygon">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="filled" type="gboolean"/>
				<parameter name="points" type="GdkPoint*"/>
				<parameter name="n_points" type="gint"/>
			</parameters>
		</function>
		<function name="draw_rectangle" symbol="gdk_draw_rectangle">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="filled" type="gboolean"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
			</parameters>
		</function>
		<function name="draw_rgb_32_image" symbol="gdk_draw_rgb_32_image">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
				<parameter name="dith" type="GdkRgbDither"/>
				<parameter name="buf" type="guchar*"/>
				<parameter name="rowstride" type="gint"/>
			</parameters>
		</function>
		<function name="draw_rgb_32_image_dithalign" symbol="gdk_draw_rgb_32_image_dithalign">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
				<parameter name="dith" type="GdkRgbDither"/>
				<parameter name="buf" type="guchar*"/>
				<parameter name="rowstride" type="gint"/>
				<parameter name="xdith" type="gint"/>
				<parameter name="ydith" type="gint"/>
			</parameters>
		</function>
		<function name="draw_rgb_image" symbol="gdk_draw_rgb_image">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
				<parameter name="dith" type="GdkRgbDither"/>
				<parameter name="rgb_buf" type="guchar*"/>
				<parameter name="rowstride" type="gint"/>
			</parameters>
		</function>
		<function name="draw_rgb_image_dithalign" symbol="gdk_draw_rgb_image_dithalign">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
				<parameter name="dith" type="GdkRgbDither"/>
				<parameter name="rgb_buf" type="guchar*"/>
				<parameter name="rowstride" type="gint"/>
				<parameter name="xdith" type="gint"/>
				<parameter name="ydith" type="gint"/>
			</parameters>
		</function>
		<function name="draw_segments" symbol="gdk_draw_segments">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="segs" type="GdkSegment*"/>
				<parameter name="n_segs" type="gint"/>
			</parameters>
		</function>
		<function name="draw_string" symbol="gdk_draw_string">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="draw_text" symbol="gdk_draw_text">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="text" type="gchar*"/>
				<parameter name="text_length" type="gint"/>
			</parameters>
		</function>
		<function name="draw_text_wc" symbol="gdk_draw_text_wc">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="x" type="gint"/>
				<parameter name="y" type="gint"/>
				<parameter name="text" type="GdkWChar*"/>
				<parameter name="text_length" type="gint"/>
			</parameters>
		</function>
		<function name="draw_trapezoids" symbol="gdk_draw_trapezoids">
			<return-type type="void"/>
			<parameters>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="trapezoids" type="GdkTrapezoid*"/>
				<parameter name="n_trapezoids" type="gint"/>
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
				<parameter name="ok" type="gboolean"/>
				<parameter name="time_" type="guint32"/>
			</parameters>
		</function>
		<function name="error_trap_pop" symbol="gdk_error_trap_pop">
			<return-type type="gint"/>
		</function>
		<function name="error_trap_push" symbol="gdk_error_trap_push">
			<return-type type="void"/>
		</function>
		<function name="events_pending" symbol="gdk_events_pending">
			<return-type type="gboolean"/>
		</function>
		<function name="exit" symbol="gdk_exit">
			<return-type type="void"/>
			<parameters>
				<parameter name="error_code" type="gint"/>
			</parameters>
		</function>
		<function name="flush" symbol="gdk_flush">
			<return-type type="void"/>
		</function>
		<function name="fontset_load" symbol="gdk_fontset_load">
			<return-type type="GdkFont*"/>
			<parameters>
				<parameter name="fontset_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="fontset_load_for_display" symbol="gdk_fontset_load_for_display">
			<return-type type="GdkFont*"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="fontset_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="free_compound_text" symbol="gdk_free_compound_text">
			<return-type type="void"/>
			<parameters>
				<parameter name="ctext" type="guchar*"/>
			</parameters>
		</function>
		<function name="free_text_list" symbol="gdk_free_text_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="gchar**"/>
			</parameters>
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
			<return-type type="char*"/>
		</function>
		<function name="get_show_events" symbol="gdk_get_show_events">
			<return-type type="gboolean"/>
		</function>
		<function name="get_use_xshm" symbol="gdk_get_use_xshm">
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
		<function name="input_add" symbol="gdk_input_add">
			<return-type type="gint"/>
			<parameters>
				<parameter name="source" type="gint"/>
				<parameter name="condition" type="GdkInputCondition"/>
				<parameter name="function" type="GdkInputFunction"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="input_add_full" symbol="gdk_input_add_full">
			<return-type type="gint"/>
			<parameters>
				<parameter name="source" type="gint"/>
				<parameter name="condition" type="GdkInputCondition"/>
				<parameter name="function" type="GdkInputFunction"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="input_remove" symbol="gdk_input_remove">
			<return-type type="void"/>
			<parameters>
				<parameter name="tag" type="gint"/>
			</parameters>
		</function>
		<function name="input_set_extension_events" symbol="gdk_input_set_extension_events">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="mask" type="gint"/>
				<parameter name="mode" type="GdkExtensionMode"/>
			</parameters>
		</function>
		<function name="keyboard_grab" symbol="gdk_keyboard_grab">
			<return-type type="GdkGrabStatus"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="owner_events" type="gboolean"/>
				<parameter name="time_" type="guint32"/>
			</parameters>
		</function>
		<function name="keyboard_ungrab" symbol="gdk_keyboard_ungrab">
			<return-type type="void"/>
			<parameters>
				<parameter name="time_" type="guint32"/>
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
		<function name="mbstowcs" symbol="gdk_mbstowcs">
			<return-type type="gint"/>
			<parameters>
				<parameter name="dest" type="GdkWChar*"/>
				<parameter name="src" type="gchar*"/>
				<parameter name="dest_max" type="gint"/>
			</parameters>
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
		<function name="offscreen_window_get_pixmap" symbol="gdk_offscreen_window_get_pixmap">
			<return-type type="GdkPixmap*"/>
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
		<function name="pango_context_set_colormap" symbol="gdk_pango_context_set_colormap">
			<return-type type="void"/>
			<parameters>
				<parameter name="context" type="PangoContext*"/>
				<parameter name="colormap" type="GdkColormap*"/>
			</parameters>
		</function>
		<function name="pango_layout_get_clip_region" symbol="gdk_pango_layout_get_clip_region">
			<return-type type="GdkRegion*"/>
			<parameters>
				<parameter name="layout" type="PangoLayout*"/>
				<parameter name="x_origin" type="gint"/>
				<parameter name="y_origin" type="gint"/>
				<parameter name="index_ranges" type="gint*"/>
				<parameter name="n_ranges" type="gint"/>
			</parameters>
		</function>
		<function name="pango_layout_line_get_clip_region" symbol="gdk_pango_layout_line_get_clip_region">
			<return-type type="GdkRegion*"/>
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
		<function name="pixbuf_get_from_drawable" symbol="gdk_pixbuf_get_from_drawable">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="dest" type="GdkPixbuf*"/>
				<parameter name="src" type="GdkDrawable*"/>
				<parameter name="cmap" type="GdkColormap*"/>
				<parameter name="src_x" type="int"/>
				<parameter name="src_y" type="int"/>
				<parameter name="dest_x" type="int"/>
				<parameter name="dest_y" type="int"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
			</parameters>
		</function>
		<function name="pixbuf_get_from_image" symbol="gdk_pixbuf_get_from_image">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="dest" type="GdkPixbuf*"/>
				<parameter name="src" type="GdkImage*"/>
				<parameter name="cmap" type="GdkColormap*"/>
				<parameter name="src_x" type="int"/>
				<parameter name="src_y" type="int"/>
				<parameter name="dest_x" type="int"/>
				<parameter name="dest_y" type="int"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
			</parameters>
		</function>
		<function name="pixbuf_render_pixmap_and_mask" symbol="gdk_pixbuf_render_pixmap_and_mask">
			<return-type type="void"/>
			<parameters>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
				<parameter name="pixmap_return" type="GdkPixmap**"/>
				<parameter name="mask_return" type="GdkBitmap**"/>
				<parameter name="alpha_threshold" type="int"/>
			</parameters>
		</function>
		<function name="pixbuf_render_pixmap_and_mask_for_colormap" symbol="gdk_pixbuf_render_pixmap_and_mask_for_colormap">
			<return-type type="void"/>
			<parameters>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
				<parameter name="colormap" type="GdkColormap*"/>
				<parameter name="pixmap_return" type="GdkPixmap**"/>
				<parameter name="mask_return" type="GdkBitmap**"/>
				<parameter name="alpha_threshold" type="int"/>
			</parameters>
		</function>
		<function name="pixbuf_render_threshold_alpha" symbol="gdk_pixbuf_render_threshold_alpha">
			<return-type type="void"/>
			<parameters>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
				<parameter name="bitmap" type="GdkBitmap*"/>
				<parameter name="src_x" type="int"/>
				<parameter name="src_y" type="int"/>
				<parameter name="dest_x" type="int"/>
				<parameter name="dest_y" type="int"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
				<parameter name="alpha_threshold" type="int"/>
			</parameters>
		</function>
		<function name="pixbuf_render_to_drawable" symbol="gdk_pixbuf_render_to_drawable">
			<return-type type="void"/>
			<parameters>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="src_x" type="int"/>
				<parameter name="src_y" type="int"/>
				<parameter name="dest_x" type="int"/>
				<parameter name="dest_y" type="int"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
				<parameter name="dither" type="GdkRgbDither"/>
				<parameter name="x_dither" type="int"/>
				<parameter name="y_dither" type="int"/>
			</parameters>
		</function>
		<function name="pixbuf_render_to_drawable_alpha" symbol="gdk_pixbuf_render_to_drawable_alpha">
			<return-type type="void"/>
			<parameters>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
				<parameter name="drawable" type="GdkDrawable*"/>
				<parameter name="src_x" type="int"/>
				<parameter name="src_y" type="int"/>
				<parameter name="dest_x" type="int"/>
				<parameter name="dest_y" type="int"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
				<parameter name="alpha_mode" type="GdkPixbufAlphaMode"/>
				<parameter name="alpha_threshold" type="int"/>
				<parameter name="dither" type="GdkRgbDither"/>
				<parameter name="x_dither" type="int"/>
				<parameter name="y_dither" type="int"/>
			</parameters>
		</function>
		<function name="pointer_grab" symbol="gdk_pointer_grab">
			<return-type type="GdkGrabStatus"/>
			<parameters>
				<parameter name="window" type="GdkWindow*"/>
				<parameter name="owner_events" type="gboolean"/>
				<parameter name="event_mask" type="GdkEventMask"/>
				<parameter name="confine_to" type="GdkWindow*"/>
				<parameter name="cursor" type="GdkCursor*"/>
				<parameter name="time_" type="guint32"/>
			</parameters>
		</function>
		<function name="pointer_grab_info_libgtk_only" symbol="gdk_pointer_grab_info_libgtk_only">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="grab_window" type="GdkWindow**"/>
				<parameter name="owner_events" type="gboolean*"/>
			</parameters>
		</function>
		<function name="pointer_is_grabbed" symbol="gdk_pointer_is_grabbed">
			<return-type type="gboolean"/>
		</function>
		<function name="pointer_ungrab" symbol="gdk_pointer_ungrab">
			<return-type type="void"/>
			<parameters>
				<parameter name="time_" type="guint32"/>
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
		<function name="rgb_colormap_ditherable" symbol="gdk_rgb_colormap_ditherable">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="cmap" type="GdkColormap*"/>
			</parameters>
		</function>
		<function name="rgb_ditherable" symbol="gdk_rgb_ditherable">
			<return-type type="gboolean"/>
		</function>
		<function name="rgb_find_color" symbol="gdk_rgb_find_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="colormap" type="GdkColormap*"/>
				<parameter name="color" type="GdkColor*"/>
			</parameters>
		</function>
		<function name="rgb_gc_set_background" symbol="gdk_rgb_gc_set_background">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="rgb" type="guint32"/>
			</parameters>
		</function>
		<function name="rgb_gc_set_foreground" symbol="gdk_rgb_gc_set_foreground">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="GdkGC*"/>
				<parameter name="rgb" type="guint32"/>
			</parameters>
		</function>
		<function name="rgb_get_colormap" symbol="gdk_rgb_get_colormap">
			<return-type type="GdkColormap*"/>
		</function>
		<function name="rgb_get_visual" symbol="gdk_rgb_get_visual">
			<return-type type="GdkVisual*"/>
		</function>
		<function name="rgb_init" symbol="gdk_rgb_init">
			<return-type type="void"/>
		</function>
		<function name="rgb_set_install" symbol="gdk_rgb_set_install">
			<return-type type="void"/>
			<parameters>
				<parameter name="install" type="gboolean"/>
			</parameters>
		</function>
		<function name="rgb_set_min_colors" symbol="gdk_rgb_set_min_colors">
			<return-type type="void"/>
			<parameters>
				<parameter name="min_colors" type="gint"/>
			</parameters>
		</function>
		<function name="rgb_set_verbose" symbol="gdk_rgb_set_verbose">
			<return-type type="void"/>
			<parameters>
				<parameter name="verbose" type="gboolean"/>
			</parameters>
		</function>
		<function name="rgb_xpixel_from_rgb" symbol="gdk_rgb_xpixel_from_rgb">
			<return-type type="gulong"/>
			<parameters>
				<parameter name="rgb" type="guint32"/>
			</parameters>
		</function>
		<function name="set_double_click_time" symbol="gdk_set_double_click_time">
			<return-type type="void"/>
			<parameters>
				<parameter name="msec" type="guint"/>
			</parameters>
		</function>
		<function name="set_locale" symbol="gdk_set_locale">
			<return-type type="gchar*"/>
		</function>
		<function name="set_pointer_hooks" symbol="gdk_set_pointer_hooks">
			<return-type type="GdkPointerHooks*"/>
			<parameters>
				<parameter name="new_hooks" type="GdkPointerHooks*"/>
			</parameters>
		</function>
		<function name="set_program_class" symbol="gdk_set_program_class">
			<return-type type="void"/>
			<parameters>
				<parameter name="program_class" type="char*"/>
			</parameters>
		</function>
		<function name="set_show_events" symbol="gdk_set_show_events">
			<return-type type="void"/>
			<parameters>
				<parameter name="show_events" type="gboolean"/>
			</parameters>
		</function>
		<function name="set_sm_client_id" symbol="gdk_set_sm_client_id">
			<return-type type="void"/>
			<parameters>
				<parameter name="sm_client_id" type="gchar*"/>
			</parameters>
		</function>
		<function name="set_use_xshm" symbol="gdk_set_use_xshm">
			<return-type type="void"/>
			<parameters>
				<parameter name="use_xshm" type="gboolean"/>
			</parameters>
		</function>
		<function name="setting_get" symbol="gdk_setting_get">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="spawn_command_line_on_screen" symbol="gdk_spawn_command_line_on_screen">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="screen" type="GdkScreen*"/>
				<parameter name="command_line" type="gchar*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="spawn_on_screen" symbol="gdk_spawn_on_screen">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="screen" type="GdkScreen*"/>
				<parameter name="working_directory" type="gchar*"/>
				<parameter name="argv" type="gchar**"/>
				<parameter name="envp" type="gchar**"/>
				<parameter name="flags" type="GSpawnFlags"/>
				<parameter name="child_setup" type="GSpawnChildSetupFunc"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="child_pid" type="gint*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="spawn_on_screen_with_pipes" symbol="gdk_spawn_on_screen_with_pipes">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="screen" type="GdkScreen*"/>
				<parameter name="working_directory" type="gchar*"/>
				<parameter name="argv" type="gchar**"/>
				<parameter name="envp" type="gchar**"/>
				<parameter name="flags" type="GSpawnFlags"/>
				<parameter name="child_setup" type="GSpawnChildSetupFunc"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="child_pid" type="gint*"/>
				<parameter name="standard_input" type="gint*"/>
				<parameter name="standard_output" type="gint*"/>
				<parameter name="standard_error" type="gint*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="string_extents" symbol="gdk_string_extents">
			<return-type type="void"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="string" type="gchar*"/>
				<parameter name="lbearing" type="gint*"/>
				<parameter name="rbearing" type="gint*"/>
				<parameter name="width" type="gint*"/>
				<parameter name="ascent" type="gint*"/>
				<parameter name="descent" type="gint*"/>
			</parameters>
		</function>
		<function name="string_height" symbol="gdk_string_height">
			<return-type type="gint"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="string_measure" symbol="gdk_string_measure">
			<return-type type="gint"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="string_to_compound_text" symbol="gdk_string_to_compound_text">
			<return-type type="gint"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
				<parameter name="encoding" type="GdkAtom*"/>
				<parameter name="format" type="gint*"/>
				<parameter name="ctext" type="guchar**"/>
				<parameter name="length" type="gint*"/>
			</parameters>
		</function>
		<function name="string_to_compound_text_for_display" symbol="gdk_string_to_compound_text_for_display">
			<return-type type="gint"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="str" type="gchar*"/>
				<parameter name="encoding" type="GdkAtom*"/>
				<parameter name="format" type="gint*"/>
				<parameter name="ctext" type="guchar**"/>
				<parameter name="length" type="gint*"/>
			</parameters>
		</function>
		<function name="string_width" symbol="gdk_string_width">
			<return-type type="gint"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="string" type="gchar*"/>
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
		<function name="text_extents" symbol="gdk_text_extents">
			<return-type type="void"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="text" type="gchar*"/>
				<parameter name="text_length" type="gint"/>
				<parameter name="lbearing" type="gint*"/>
				<parameter name="rbearing" type="gint*"/>
				<parameter name="width" type="gint*"/>
				<parameter name="ascent" type="gint*"/>
				<parameter name="descent" type="gint*"/>
			</parameters>
		</function>
		<function name="text_extents_wc" symbol="gdk_text_extents_wc">
			<return-type type="void"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="text" type="GdkWChar*"/>
				<parameter name="text_length" type="gint"/>
				<parameter name="lbearing" type="gint*"/>
				<parameter name="rbearing" type="gint*"/>
				<parameter name="width" type="gint*"/>
				<parameter name="ascent" type="gint*"/>
				<parameter name="descent" type="gint*"/>
			</parameters>
		</function>
		<function name="text_height" symbol="gdk_text_height">
			<return-type type="gint"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="text" type="gchar*"/>
				<parameter name="text_length" type="gint"/>
			</parameters>
		</function>
		<function name="text_measure" symbol="gdk_text_measure">
			<return-type type="gint"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="text" type="gchar*"/>
				<parameter name="text_length" type="gint"/>
			</parameters>
		</function>
		<function name="text_property_to_text_list" symbol="gdk_text_property_to_text_list">
			<return-type type="gint"/>
			<parameters>
				<parameter name="encoding" type="GdkAtom"/>
				<parameter name="format" type="gint"/>
				<parameter name="text" type="guchar*"/>
				<parameter name="length" type="gint"/>
				<parameter name="list" type="gchar***"/>
			</parameters>
		</function>
		<function name="text_property_to_text_list_for_display" symbol="gdk_text_property_to_text_list_for_display">
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
		<function name="text_property_to_utf8_list" symbol="gdk_text_property_to_utf8_list">
			<return-type type="gint"/>
			<parameters>
				<parameter name="encoding" type="GdkAtom"/>
				<parameter name="format" type="gint"/>
				<parameter name="text" type="guchar*"/>
				<parameter name="length" type="gint"/>
				<parameter name="list" type="gchar***"/>
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
		<function name="text_width" symbol="gdk_text_width">
			<return-type type="gint"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="text" type="gchar*"/>
				<parameter name="text_length" type="gint"/>
			</parameters>
		</function>
		<function name="text_width_wc" symbol="gdk_text_width_wc">
			<return-type type="gint"/>
			<parameters>
				<parameter name="font" type="GdkFont*"/>
				<parameter name="text" type="GdkWChar*"/>
				<parameter name="text_length" type="gint"/>
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
		<function name="utf8_to_compound_text" symbol="gdk_utf8_to_compound_text">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
				<parameter name="encoding" type="GdkAtom*"/>
				<parameter name="format" type="gint*"/>
				<parameter name="ctext" type="guchar**"/>
				<parameter name="length" type="gint*"/>
			</parameters>
		</function>
		<function name="utf8_to_compound_text_for_display" symbol="gdk_utf8_to_compound_text_for_display">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="display" type="GdkDisplay*"/>
				<parameter name="str" type="gchar*"/>
				<parameter name="encoding" type="GdkAtom*"/>
				<parameter name="format" type="gint*"/>
				<parameter name="ctext" type="guchar**"/>
				<parameter name="length" type="gint*"/>
			</parameters>
		</function>
		<function name="utf8_to_string_target" symbol="gdk_utf8_to_string_target">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="wcstombs" symbol="gdk_wcstombs">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="src" type="GdkWChar*"/>
			</parameters>
		</function>
		<callback name="GdkDestroyNotify">
			<return-type type="void"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
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
		<callback name="GdkInputFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
				<parameter name="source" type="gint"/>
				<parameter name="condition" type="GdkInputCondition"/>
			</parameters>
		</callback>
		<callback name="GdkSpanFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="span" type="GdkSpan*"/>
				<parameter name="data" type="gpointer"/>
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
		<struct name="GdkBitmap">
			<method name="create_from_data" symbol="gdk_bitmap_create_from_data">
				<return-type type="GdkBitmap*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<field name="parent_instance" type="GObject"/>
		</struct>
		<struct name="GdkDeviceAxis">
			<field name="use" type="GdkAxisUse"/>
			<field name="min" type="gdouble"/>
			<field name="max" type="gdouble"/>
		</struct>
		<struct name="GdkDeviceClass">
		</struct>
		<struct name="GdkDeviceKey">
			<field name="keyval" type="guint"/>
			<field name="modifiers" type="GdkModifierType"/>
		</struct>
		<struct name="GdkDisplayPointerHooks">
			<field name="get_pointer" type="GCallback"/>
			<field name="window_get_pointer" type="GCallback"/>
			<field name="window_at_pointer" type="GCallback"/>
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
			<field name="region" type="GdkRegion*"/>
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
		<struct name="GdkEventNoExpose">
			<field name="type" type="GdkEventType"/>
			<field name="window" type="GdkWindow*"/>
			<field name="send_event" type="gint8"/>
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
		<struct name="GdkGCValues">
			<field name="foreground" type="GdkColor"/>
			<field name="background" type="GdkColor"/>
			<field name="font" type="GdkFont*"/>
			<field name="function" type="GdkFunction"/>
			<field name="fill" type="GdkFill"/>
			<field name="tile" type="GdkPixmap*"/>
			<field name="stipple" type="GdkPixmap*"/>
			<field name="clip_mask" type="GdkPixmap*"/>
			<field name="subwindow_mode" type="GdkSubwindowMode"/>
			<field name="ts_x_origin" type="gint"/>
			<field name="ts_y_origin" type="gint"/>
			<field name="clip_x_origin" type="gint"/>
			<field name="clip_y_origin" type="gint"/>
			<field name="graphics_exposures" type="gint"/>
			<field name="line_width" type="gint"/>
			<field name="line_style" type="GdkLineStyle"/>
			<field name="cap_style" type="GdkCapStyle"/>
			<field name="join_style" type="GdkJoinStyle"/>
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
		<struct name="GdkKeyboardGrabInfo">
			<method name="libgtk_only" symbol="gdk_keyboard_grab_info_libgtk_only">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="grab_window" type="GdkWindow**"/>
					<parameter name="owner_events" type="gboolean*"/>
				</parameters>
			</method>
			<field name="window" type="GdkWindow*"/>
			<field name="native_window" type="GdkWindow*"/>
			<field name="serial" type="gulong"/>
			<field name="owner_events" type="gboolean"/>
			<field name="time" type="guint32"/>
		</struct>
		<struct name="GdkKeymapKey">
			<field name="keycode" type="guint"/>
			<field name="group" type="gint"/>
			<field name="level" type="gint"/>
		</struct>
		<struct name="GdkNativeWindow">
		</struct>
		<struct name="GdkPangoAttrEmbossColor">
			<method name="new" symbol="gdk_pango_attr_emboss_color_new">
				<return-type type="PangoAttribute*"/>
				<parameters>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<field name="attr" type="PangoAttribute"/>
			<field name="color" type="PangoColor"/>
		</struct>
		<struct name="GdkPangoAttrEmbossed">
			<method name="new" symbol="gdk_pango_attr_embossed_new">
				<return-type type="PangoAttribute*"/>
				<parameters>
					<parameter name="embossed" type="gboolean"/>
				</parameters>
			</method>
			<field name="attr" type="PangoAttribute"/>
			<field name="embossed" type="gboolean"/>
		</struct>
		<struct name="GdkPangoAttrStipple">
			<method name="new" symbol="gdk_pango_attr_stipple_new">
				<return-type type="PangoAttribute*"/>
				<parameters>
					<parameter name="stipple" type="GdkBitmap*"/>
				</parameters>
			</method>
			<field name="attr" type="PangoAttribute"/>
			<field name="stipple" type="GdkBitmap*"/>
		</struct>
		<struct name="GdkPixmapObject">
			<field name="parent_instance" type="GdkDrawable"/>
			<field name="impl" type="GdkDrawable*"/>
			<field name="depth" type="gint"/>
		</struct>
		<struct name="GdkPixmapObjectClass">
			<field name="parent_class" type="GdkDrawableClass"/>
		</struct>
		<struct name="GdkPoint">
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
		</struct>
		<struct name="GdkPointerHooks">
			<field name="get_pointer" type="GCallback"/>
			<field name="window_at_pointer" type="GCallback"/>
		</struct>
		<struct name="GdkPointerWindowInfo">
			<field name="toplevel_under_pointer" type="GdkWindow*"/>
			<field name="window_under_pointer" type="GdkWindow*"/>
			<field name="toplevel_x" type="gdouble"/>
			<field name="toplevel_y" type="gdouble"/>
			<field name="state" type="guint32"/>
			<field name="button" type="guint32"/>
			<field name="motion_hint_serial" type="gulong"/>
		</struct>
		<struct name="GdkRegion">
			<method name="copy" symbol="gdk_region_copy">
				<return-type type="GdkRegion*"/>
				<parameters>
					<parameter name="region" type="GdkRegion*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="gdk_region_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="region" type="GdkRegion*"/>
				</parameters>
			</method>
			<method name="empty" symbol="gdk_region_empty">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="region" type="GdkRegion*"/>
				</parameters>
			</method>
			<method name="equal" symbol="gdk_region_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="region1" type="GdkRegion*"/>
					<parameter name="region2" type="GdkRegion*"/>
				</parameters>
			</method>
			<method name="get_clipbox" symbol="gdk_region_get_clipbox">
				<return-type type="void"/>
				<parameters>
					<parameter name="region" type="GdkRegion*"/>
					<parameter name="rectangle" type="GdkRectangle*"/>
				</parameters>
			</method>
			<method name="get_rectangles" symbol="gdk_region_get_rectangles">
				<return-type type="void"/>
				<parameters>
					<parameter name="region" type="GdkRegion*"/>
					<parameter name="rectangles" type="GdkRectangle**"/>
					<parameter name="n_rectangles" type="gint*"/>
				</parameters>
			</method>
			<method name="intersect" symbol="gdk_region_intersect">
				<return-type type="void"/>
				<parameters>
					<parameter name="source1" type="GdkRegion*"/>
					<parameter name="source2" type="GdkRegion*"/>
				</parameters>
			</method>
			<method name="new" symbol="gdk_region_new">
				<return-type type="GdkRegion*"/>
			</method>
			<method name="offset" symbol="gdk_region_offset">
				<return-type type="void"/>
				<parameters>
					<parameter name="region" type="GdkRegion*"/>
					<parameter name="dx" type="gint"/>
					<parameter name="dy" type="gint"/>
				</parameters>
			</method>
			<method name="point_in" symbol="gdk_region_point_in">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="region" type="GdkRegion*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
				</parameters>
			</method>
			<method name="polygon" symbol="gdk_region_polygon">
				<return-type type="GdkRegion*"/>
				<parameters>
					<parameter name="points" type="GdkPoint*"/>
					<parameter name="n_points" type="gint"/>
					<parameter name="fill_rule" type="GdkFillRule"/>
				</parameters>
			</method>
			<method name="rect_equal" symbol="gdk_region_rect_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="region" type="GdkRegion*"/>
					<parameter name="rectangle" type="GdkRectangle*"/>
				</parameters>
			</method>
			<method name="rect_in" symbol="gdk_region_rect_in">
				<return-type type="GdkOverlapType"/>
				<parameters>
					<parameter name="region" type="GdkRegion*"/>
					<parameter name="rectangle" type="GdkRectangle*"/>
				</parameters>
			</method>
			<method name="rectangle" symbol="gdk_region_rectangle">
				<return-type type="GdkRegion*"/>
				<parameters>
					<parameter name="rectangle" type="GdkRectangle*"/>
				</parameters>
			</method>
			<method name="shrink" symbol="gdk_region_shrink">
				<return-type type="void"/>
				<parameters>
					<parameter name="region" type="GdkRegion*"/>
					<parameter name="dx" type="gint"/>
					<parameter name="dy" type="gint"/>
				</parameters>
			</method>
			<method name="spans_intersect_foreach" symbol="gdk_region_spans_intersect_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="region" type="GdkRegion*"/>
					<parameter name="spans" type="GdkSpan*"/>
					<parameter name="n_spans" type="int"/>
					<parameter name="sorted" type="gboolean"/>
					<parameter name="function" type="GdkSpanFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="subtract" symbol="gdk_region_subtract">
				<return-type type="void"/>
				<parameters>
					<parameter name="source1" type="GdkRegion*"/>
					<parameter name="source2" type="GdkRegion*"/>
				</parameters>
			</method>
			<method name="union" symbol="gdk_region_union">
				<return-type type="void"/>
				<parameters>
					<parameter name="source1" type="GdkRegion*"/>
					<parameter name="source2" type="GdkRegion*"/>
				</parameters>
			</method>
			<method name="union_with_rect" symbol="gdk_region_union_with_rect">
				<return-type type="void"/>
				<parameters>
					<parameter name="region" type="GdkRegion*"/>
					<parameter name="rect" type="GdkRectangle*"/>
				</parameters>
			</method>
			<method name="xor" symbol="gdk_region_xor">
				<return-type type="void"/>
				<parameters>
					<parameter name="source1" type="GdkRegion*"/>
					<parameter name="source2" type="GdkRegion*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GdkRgbCmap">
			<method name="free" symbol="gdk_rgb_cmap_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="cmap" type="GdkRgbCmap*"/>
				</parameters>
			</method>
			<method name="new" symbol="gdk_rgb_cmap_new">
				<return-type type="GdkRgbCmap*"/>
				<parameters>
					<parameter name="colors" type="guint32*"/>
					<parameter name="n_colors" type="gint"/>
				</parameters>
			</method>
			<field name="colors" type="guint32[]"/>
			<field name="n_colors" type="gint"/>
			<field name="info_list" type="GSList*"/>
		</struct>
		<struct name="GdkSegment">
			<field name="x1" type="gint"/>
			<field name="y1" type="gint"/>
			<field name="x2" type="gint"/>
			<field name="y2" type="gint"/>
		</struct>
		<struct name="GdkSelection">
			<method name="convert" symbol="gdk_selection_convert">
				<return-type type="void"/>
				<parameters>
					<parameter name="requestor" type="GdkWindow*"/>
					<parameter name="selection" type="GdkAtom"/>
					<parameter name="target" type="GdkAtom"/>
					<parameter name="time_" type="guint32"/>
				</parameters>
			</method>
			<method name="owner_get" symbol="gdk_selection_owner_get">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="selection" type="GdkAtom"/>
				</parameters>
			</method>
			<method name="owner_get_for_display" symbol="gdk_selection_owner_get_for_display">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="selection" type="GdkAtom"/>
				</parameters>
			</method>
			<method name="owner_set" symbol="gdk_selection_owner_set">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="owner" type="GdkWindow*"/>
					<parameter name="selection" type="GdkAtom"/>
					<parameter name="time_" type="guint32"/>
					<parameter name="send_event" type="gboolean"/>
				</parameters>
			</method>
			<method name="owner_set_for_display" symbol="gdk_selection_owner_set_for_display">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="owner" type="GdkWindow*"/>
					<parameter name="selection" type="GdkAtom"/>
					<parameter name="time_" type="guint32"/>
					<parameter name="send_event" type="gboolean"/>
				</parameters>
			</method>
			<method name="property_get" symbol="gdk_selection_property_get">
				<return-type type="gint"/>
				<parameters>
					<parameter name="requestor" type="GdkWindow*"/>
					<parameter name="data" type="guchar**"/>
					<parameter name="prop_type" type="GdkAtom*"/>
					<parameter name="prop_format" type="gint*"/>
				</parameters>
			</method>
			<method name="send_notify" symbol="gdk_selection_send_notify">
				<return-type type="void"/>
				<parameters>
					<parameter name="requestor" type="GdkNativeWindow"/>
					<parameter name="selection" type="GdkAtom"/>
					<parameter name="target" type="GdkAtom"/>
					<parameter name="property" type="GdkAtom"/>
					<parameter name="time_" type="guint32"/>
				</parameters>
			</method>
			<method name="send_notify_for_display" symbol="gdk_selection_send_notify_for_display">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="requestor" type="GdkNativeWindow"/>
					<parameter name="selection" type="GdkAtom"/>
					<parameter name="target" type="GdkAtom"/>
					<parameter name="property" type="GdkAtom"/>
					<parameter name="time_" type="guint32"/>
				</parameters>
			</method>
		</struct>
		<struct name="GdkSelectionType">
		</struct>
		<struct name="GdkSpan">
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
			<field name="width" type="gint"/>
		</struct>
		<struct name="GdkTarget">
		</struct>
		<struct name="GdkTimeCoord">
			<field name="time" type="guint32"/>
			<field name="axes" type="gdouble[]"/>
		</struct>
		<struct name="GdkTrapezoid">
			<field name="y1" type="double"/>
			<field name="x11" type="double"/>
			<field name="x21" type="double"/>
			<field name="y2" type="double"/>
			<field name="x12" type="double"/>
			<field name="x22" type="double"/>
		</struct>
		<struct name="GdkVisualClass">
		</struct>
		<struct name="GdkWChar">
		</struct>
		<struct name="GdkWindowAttr">
			<field name="title" type="gchar*"/>
			<field name="event_mask" type="gint"/>
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
			<field name="width" type="gint"/>
			<field name="height" type="gint"/>
			<field name="wclass" type="GdkWindowClass"/>
			<field name="visual" type="GdkVisual*"/>
			<field name="colormap" type="GdkColormap*"/>
			<field name="window_type" type="GdkWindowType"/>
			<field name="cursor" type="GdkCursor*"/>
			<field name="wmclass_name" type="gchar*"/>
			<field name="wmclass_class" type="gchar*"/>
			<field name="override_redirect" type="gboolean"/>
			<field name="type_hint" type="GdkWindowTypeHint"/>
		</struct>
		<struct name="GdkWindowObject">
		</struct>
		<struct name="GdkWindowObjectClass">
			<field name="parent_class" type="GdkDrawableClass"/>
		</struct>
		<struct name="GdkWindowRedirect">
			<method name="to_drawable" symbol="gdk_window_redirect_to_drawable">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="src_x" type="gint"/>
					<parameter name="src_y" type="gint"/>
					<parameter name="dest_x" type="gint"/>
					<parameter name="dest_y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
		</struct>
		<struct name="GdkXEvent">
		</struct>
		<boxed name="GdkColor" type-name="GdkColor" get-type="gdk_color_get_type">
			<method name="alloc" symbol="gdk_color_alloc">
				<return-type type="gint"/>
				<parameters>
					<parameter name="colormap" type="GdkColormap*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="black" symbol="gdk_color_black">
				<return-type type="gint"/>
				<parameters>
					<parameter name="colormap" type="GdkColormap*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="change" symbol="gdk_color_change">
				<return-type type="gint"/>
				<parameters>
					<parameter name="colormap" type="GdkColormap*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
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
			<method name="white" symbol="gdk_color_white">
				<return-type type="gint"/>
				<parameters>
					<parameter name="colormap" type="GdkColormap*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<field name="pixel" type="guint32"/>
			<field name="red" type="guint16"/>
			<field name="green" type="guint16"/>
			<field name="blue" type="guint16"/>
		</boxed>
		<boxed name="GdkCursor" type-name="GdkCursor" get-type="gdk_cursor_get_type">
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
			<constructor name="new_from_pixmap" symbol="gdk_cursor_new_from_pixmap">
				<return-type type="GdkCursor*"/>
				<parameters>
					<parameter name="source" type="GdkPixmap*"/>
					<parameter name="mask" type="GdkPixmap*"/>
					<parameter name="fg" type="GdkColor*"/>
					<parameter name="bg" type="GdkColor*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</constructor>
			<method name="ref" symbol="gdk_cursor_ref">
				<return-type type="GdkCursor*"/>
				<parameters>
					<parameter name="cursor" type="GdkCursor*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gdk_cursor_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="cursor" type="GdkCursor*"/>
				</parameters>
			</method>
			<field name="type" type="GdkCursorType"/>
			<field name="ref_count" type="guint"/>
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
			<method name="get_graphics_expose" symbol="gdk_event_get_graphics_expose">
				<return-type type="GdkEvent*"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
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
			<method name="set_screen" symbol="gdk_event_set_screen">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdkEvent*"/>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<field name="type" type="GdkEventType"/>
			<field name="any" type="GdkEventAny"/>
			<field name="expose" type="GdkEventExpose"/>
			<field name="no_expose" type="GdkEventNoExpose"/>
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
		<boxed name="GdkFont" type-name="GdkFont" get-type="gdk_font_get_type">
			<method name="equal" symbol="gdk_font_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="fonta" type="GdkFont*"/>
					<parameter name="fontb" type="GdkFont*"/>
				</parameters>
			</method>
			<method name="from_description" symbol="gdk_font_from_description">
				<return-type type="GdkFont*"/>
				<parameters>
					<parameter name="font_desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="from_description_for_display" symbol="gdk_font_from_description_for_display">
				<return-type type="GdkFont*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="font_desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="get_display" symbol="gdk_font_get_display">
				<return-type type="GdkDisplay*"/>
				<parameters>
					<parameter name="font" type="GdkFont*"/>
				</parameters>
			</method>
			<method name="id" symbol="gdk_font_id">
				<return-type type="gint"/>
				<parameters>
					<parameter name="font" type="GdkFont*"/>
				</parameters>
			</method>
			<method name="load" symbol="gdk_font_load">
				<return-type type="GdkFont*"/>
				<parameters>
					<parameter name="font_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="load_for_display" symbol="gdk_font_load_for_display">
				<return-type type="GdkFont*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="font_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="ref" symbol="gdk_font_ref">
				<return-type type="GdkFont*"/>
				<parameters>
					<parameter name="font" type="GdkFont*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gdk_font_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="font" type="GdkFont*"/>
				</parameters>
			</method>
			<field name="type" type="GdkFontType"/>
			<field name="ascent" type="gint"/>
			<field name="descent" type="gint"/>
		</boxed>
		<boxed name="GdkRectangle" type-name="GdkRectangle" get-type="gdk_rectangle_get_type">
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
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
			<field name="width" type="gint"/>
			<field name="height" type="gint"/>
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
		<enum name="GdkCapStyle" type-name="GdkCapStyle" get-type="gdk_cap_style_get_type">
			<member name="GDK_CAP_NOT_LAST" value="0"/>
			<member name="GDK_CAP_BUTT" value="1"/>
			<member name="GDK_CAP_ROUND" value="2"/>
			<member name="GDK_CAP_PROJECTING" value="3"/>
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
			<member name="GDK_NO_EXPOSE" value="30"/>
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
		<enum name="GdkFill" type-name="GdkFill" get-type="gdk_fill_get_type">
			<member name="GDK_SOLID" value="0"/>
			<member name="GDK_TILED" value="1"/>
			<member name="GDK_STIPPLED" value="2"/>
			<member name="GDK_OPAQUE_STIPPLED" value="3"/>
		</enum>
		<enum name="GdkFillRule" type-name="GdkFillRule" get-type="gdk_fill_rule_get_type">
			<member name="GDK_EVEN_ODD_RULE" value="0"/>
			<member name="GDK_WINDING_RULE" value="1"/>
		</enum>
		<enum name="GdkFilterReturn" type-name="GdkFilterReturn" get-type="gdk_filter_return_get_type">
			<member name="GDK_FILTER_CONTINUE" value="0"/>
			<member name="GDK_FILTER_TRANSLATE" value="1"/>
			<member name="GDK_FILTER_REMOVE" value="2"/>
		</enum>
		<enum name="GdkFontType" type-name="GdkFontType" get-type="gdk_font_type_get_type">
			<member name="GDK_FONT_FONT" value="0"/>
			<member name="GDK_FONT_FONTSET" value="1"/>
		</enum>
		<enum name="GdkFunction" type-name="GdkFunction" get-type="gdk_function_get_type">
			<member name="GDK_COPY" value="0"/>
			<member name="GDK_INVERT" value="1"/>
			<member name="GDK_XOR" value="2"/>
			<member name="GDK_CLEAR" value="3"/>
			<member name="GDK_AND" value="4"/>
			<member name="GDK_AND_REVERSE" value="5"/>
			<member name="GDK_AND_INVERT" value="6"/>
			<member name="GDK_NOOP" value="7"/>
			<member name="GDK_OR" value="8"/>
			<member name="GDK_EQUIV" value="9"/>
			<member name="GDK_OR_REVERSE" value="10"/>
			<member name="GDK_COPY_INVERT" value="11"/>
			<member name="GDK_OR_INVERT" value="12"/>
			<member name="GDK_NAND" value="13"/>
			<member name="GDK_NOR" value="14"/>
			<member name="GDK_SET" value="15"/>
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
		<enum name="GdkImageType" type-name="GdkImageType" get-type="gdk_image_type_get_type">
			<member name="GDK_IMAGE_NORMAL" value="0"/>
			<member name="GDK_IMAGE_SHARED" value="1"/>
			<member name="GDK_IMAGE_FASTEST" value="2"/>
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
		</enum>
		<enum name="GdkJoinStyle" type-name="GdkJoinStyle" get-type="gdk_join_style_get_type">
			<member name="GDK_JOIN_MITER" value="0"/>
			<member name="GDK_JOIN_ROUND" value="1"/>
			<member name="GDK_JOIN_BEVEL" value="2"/>
		</enum>
		<enum name="GdkLineStyle" type-name="GdkLineStyle" get-type="gdk_line_style_get_type">
			<member name="GDK_LINE_SOLID" value="0"/>
			<member name="GDK_LINE_ON_OFF_DASH" value="1"/>
			<member name="GDK_LINE_DOUBLE_DASH" value="2"/>
		</enum>
		<enum name="GdkNotifyType" type-name="GdkNotifyType" get-type="gdk_notify_type_get_type">
			<member name="GDK_NOTIFY_ANCESTOR" value="0"/>
			<member name="GDK_NOTIFY_VIRTUAL" value="1"/>
			<member name="GDK_NOTIFY_INFERIOR" value="2"/>
			<member name="GDK_NOTIFY_NONLINEAR" value="3"/>
			<member name="GDK_NOTIFY_NONLINEAR_VIRTUAL" value="4"/>
			<member name="GDK_NOTIFY_UNKNOWN" value="5"/>
		</enum>
		<enum name="GdkOverlapType" type-name="GdkOverlapType" get-type="gdk_overlap_type_get_type">
			<member name="GDK_OVERLAP_RECTANGLE_IN" value="0"/>
			<member name="GDK_OVERLAP_RECTANGLE_OUT" value="1"/>
			<member name="GDK_OVERLAP_RECTANGLE_PART" value="2"/>
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
		<enum name="GdkRgbDither" type-name="GdkRgbDither" get-type="gdk_rgb_dither_get_type">
			<member name="GDK_RGB_DITHER_NONE" value="0"/>
			<member name="GDK_RGB_DITHER_NORMAL" value="1"/>
			<member name="GDK_RGB_DITHER_MAX" value="2"/>
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
		<enum name="GdkSubwindowMode" type-name="GdkSubwindowMode" get-type="gdk_subwindow_mode_get_type">
			<member name="GDK_CLIP_BY_CHILDREN" value="0"/>
			<member name="GDK_INCLUDE_INFERIORS" value="1"/>
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
		<enum name="GdkWindowClass" type-name="GdkWindowClass" get-type="gdk_window_class_get_type">
			<member name="GDK_INPUT_OUTPUT" value="0"/>
			<member name="GDK_INPUT_ONLY" value="1"/>
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
			<member name="GDK_WINDOW_DIALOG" value="3"/>
			<member name="GDK_WINDOW_TEMP" value="4"/>
			<member name="GDK_WINDOW_FOREIGN" value="5"/>
			<member name="GDK_WINDOW_OFFSCREEN" value="6"/>
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
		<flags name="GdkGCValuesMask" type-name="GdkGCValuesMask" get-type="gdk_gc_values_mask_get_type">
			<member name="GDK_GC_FOREGROUND" value="1"/>
			<member name="GDK_GC_BACKGROUND" value="2"/>
			<member name="GDK_GC_FONT" value="4"/>
			<member name="GDK_GC_FUNCTION" value="8"/>
			<member name="GDK_GC_FILL" value="16"/>
			<member name="GDK_GC_TILE" value="32"/>
			<member name="GDK_GC_STIPPLE" value="64"/>
			<member name="GDK_GC_CLIP_MASK" value="128"/>
			<member name="GDK_GC_SUBWINDOW" value="256"/>
			<member name="GDK_GC_TS_X_ORIGIN" value="512"/>
			<member name="GDK_GC_TS_Y_ORIGIN" value="1024"/>
			<member name="GDK_GC_CLIP_X_ORIGIN" value="2048"/>
			<member name="GDK_GC_CLIP_Y_ORIGIN" value="4096"/>
			<member name="GDK_GC_EXPOSURES" value="8192"/>
			<member name="GDK_GC_LINE_WIDTH" value="16384"/>
			<member name="GDK_GC_LINE_STYLE" value="32768"/>
			<member name="GDK_GC_CAP_STYLE" value="65536"/>
			<member name="GDK_GC_JOIN_STYLE" value="131072"/>
		</flags>
		<flags name="GdkInputCondition" type-name="GdkInputCondition" get-type="gdk_input_condition_get_type">
			<member name="GDK_INPUT_READ" value="1"/>
			<member name="GDK_INPUT_WRITE" value="2"/>
			<member name="GDK_INPUT_EXCEPTION" value="4"/>
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
			<member name="GDK_WA_COLORMAP" value="32"/>
			<member name="GDK_WA_VISUAL" value="64"/>
			<member name="GDK_WA_WMCLASS" value="128"/>
			<member name="GDK_WA_NOREDIR" value="256"/>
			<member name="GDK_WA_TYPE_HINT" value="512"/>
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
			<constructor name="new" symbol="gdk_app_launch_context_new">
				<return-type type="GdkAppLaunchContext*"/>
			</constructor>
			<method name="set_desktop" symbol="gdk_app_launch_context_set_desktop">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GdkAppLaunchContext*"/>
					<parameter name="desktop" type="gint"/>
				</parameters>
			</method>
			<method name="set_display" symbol="gdk_app_launch_context_set_display">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GdkAppLaunchContext*"/>
					<parameter name="display" type="GdkDisplay*"/>
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
		</object>
		<object name="GdkColormap" parent="GObject" type-name="GdkColormap" get-type="gdk_colormap_get_type">
			<method name="alloc_color" symbol="gdk_colormap_alloc_color">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="colormap" type="GdkColormap*"/>
					<parameter name="color" type="GdkColor*"/>
					<parameter name="writeable" type="gboolean"/>
					<parameter name="best_match" type="gboolean"/>
				</parameters>
			</method>
			<method name="alloc_colors" symbol="gdk_colormap_alloc_colors">
				<return-type type="gint"/>
				<parameters>
					<parameter name="colormap" type="GdkColormap*"/>
					<parameter name="colors" type="GdkColor*"/>
					<parameter name="n_colors" type="gint"/>
					<parameter name="writeable" type="gboolean"/>
					<parameter name="best_match" type="gboolean"/>
					<parameter name="success" type="gboolean*"/>
				</parameters>
			</method>
			<method name="change" symbol="gdk_colormap_change">
				<return-type type="void"/>
				<parameters>
					<parameter name="colormap" type="GdkColormap*"/>
					<parameter name="ncolors" type="gint"/>
				</parameters>
			</method>
			<method name="free_colors" symbol="gdk_colormap_free_colors">
				<return-type type="void"/>
				<parameters>
					<parameter name="colormap" type="GdkColormap*"/>
					<parameter name="colors" type="GdkColor*"/>
					<parameter name="n_colors" type="gint"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="gdk_colormap_get_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="cmap" type="GdkColormap*"/>
				</parameters>
			</method>
			<method name="get_system" symbol="gdk_colormap_get_system">
				<return-type type="GdkColormap*"/>
			</method>
			<method name="get_system_size" symbol="gdk_colormap_get_system_size">
				<return-type type="gint"/>
			</method>
			<method name="get_visual" symbol="gdk_colormap_get_visual">
				<return-type type="GdkVisual*"/>
				<parameters>
					<parameter name="colormap" type="GdkColormap*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdk_colormap_new">
				<return-type type="GdkColormap*"/>
				<parameters>
					<parameter name="visual" type="GdkVisual*"/>
					<parameter name="allocate" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="query_color" symbol="gdk_colormap_query_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="colormap" type="GdkColormap*"/>
					<parameter name="pixel" type="gulong"/>
					<parameter name="result" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="ref" symbol="gdk_colormap_ref">
				<return-type type="GdkColormap*"/>
				<parameters>
					<parameter name="cmap" type="GdkColormap*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gdk_colormap_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="cmap" type="GdkColormap*"/>
				</parameters>
			</method>
			<field name="size" type="gint"/>
			<field name="colors" type="GdkColor*"/>
			<field name="visual" type="GdkVisual*"/>
			<field name="windowing_data" type="gpointer"/>
		</object>
		<object name="GdkDevice" parent="GObject" type-name="GdkDevice" get-type="gdk_device_get_type">
			<method name="free_history" symbol="gdk_device_free_history">
				<return-type type="void"/>
				<parameters>
					<parameter name="events" type="GdkTimeCoord**"/>
					<parameter name="n_events" type="gint"/>
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
					<parameter name="index" type="guint"/>
				</parameters>
			</method>
			<method name="get_core_pointer" symbol="gdk_device_get_core_pointer">
				<return-type type="GdkDevice*"/>
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
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="index" type="guint"/>
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
			<method name="set_source" symbol="gdk_device_set_source">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="GdkDevice*"/>
					<parameter name="source" type="GdkInputSource"/>
				</parameters>
			</method>
			<field name="name" type="gchar*"/>
			<field name="source" type="GdkInputSource"/>
			<field name="mode" type="GdkInputMode"/>
			<field name="has_cursor" type="gboolean"/>
			<field name="num_axes" type="gint"/>
			<field name="axes" type="GdkDeviceAxis*"/>
			<field name="num_keys" type="gint"/>
			<field name="keys" type="GdkDeviceKey*"/>
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
			<method name="flush" symbol="gdk_display_flush">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="get_core_pointer" symbol="gdk_display_get_core_pointer">
				<return-type type="GdkDevice*"/>
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
			<method name="get_pointer" symbol="gdk_display_get_pointer">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="screen" type="GdkScreen**"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="mask" type="GdkModifierType*"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="gdk_display_get_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="screen_num" type="gint"/>
				</parameters>
			</method>
			<method name="get_window_at_pointer" symbol="gdk_display_get_window_at_pointer">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="win_x" type="gint*"/>
					<parameter name="win_y" type="gint*"/>
				</parameters>
			</method>
			<method name="is_closed" symbol="gdk_display_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="keyboard_ungrab" symbol="gdk_display_keyboard_ungrab">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="time_" type="guint32"/>
				</parameters>
			</method>
			<method name="list_devices" symbol="gdk_display_list_devices">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
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
			<method name="pointer_is_grabbed" symbol="gdk_display_pointer_is_grabbed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<method name="pointer_ungrab" symbol="gdk_display_pointer_ungrab">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="time_" type="guint32"/>
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
			<method name="set_pointer_hooks" symbol="gdk_display_set_pointer_hooks">
				<return-type type="GdkDisplayPointerHooks*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="new_hooks" type="GdkDisplayPointerHooks*"/>
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
			<method name="warp_pointer" symbol="gdk_display_warp_pointer">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<signal name="closed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="is_error" type="gboolean"/>
				</parameters>
			</signal>
			<vfunc name="get_default_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_display_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_screens">
				<return-type type="gint"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="screen_num" type="gint"/>
				</parameters>
			</vfunc>
			<field name="queued_events" type="GList*"/>
			<field name="queued_tail" type="GList*"/>
			<field name="button_click_time" type="guint32[]"/>
			<field name="button_window" type="GdkWindow*[]"/>
			<field name="button_number" type="gint[]"/>
			<field name="double_click_time" type="guint"/>
			<field name="core_pointer" type="GdkDevice*"/>
			<field name="pointer_hooks" type="GdkDisplayPointerHooks*"/>
			<field name="closed" type="guint"/>
			<field name="ignore_core_events" type="guint"/>
			<field name="double_click_distance" type="guint"/>
			<field name="button_x" type="gint[]"/>
			<field name="button_y" type="gint[]"/>
			<field name="pointer_grabs" type="GList*"/>
			<field name="keyboard_grab" type="GdkKeyboardGrabInfo"/>
			<field name="pointer_info" type="GdkPointerWindowInfo"/>
			<field name="last_event_time" type="guint32"/>
		</object>
		<object name="GdkDisplayManager" parent="GObject" type-name="GdkDisplayManager" get-type="gdk_display_manager_get_type">
			<method name="get" symbol="gdk_display_manager_get">
				<return-type type="GdkDisplayManager*"/>
			</method>
			<method name="get_default_display" symbol="gdk_display_manager_get_default_display">
				<return-type type="GdkDisplay*"/>
				<parameters>
					<parameter name="display_manager" type="GdkDisplayManager*"/>
				</parameters>
			</method>
			<method name="list_displays" symbol="gdk_display_manager_list_displays">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="display_manager" type="GdkDisplayManager*"/>
				</parameters>
			</method>
			<method name="set_default_display" symbol="gdk_display_manager_set_default_display">
				<return-type type="void"/>
				<parameters>
					<parameter name="display_manager" type="GdkDisplayManager*"/>
					<parameter name="display" type="GdkDisplay*"/>
				</parameters>
			</method>
			<property name="default-display" type="GdkDisplay*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="display-opened" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="display_manager" type="GdkDisplayManager*"/>
					<parameter name="display" type="GdkDisplay*"/>
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
			<constructor name="new" symbol="gdk_drag_context_new">
				<return-type type="GdkDragContext*"/>
			</constructor>
			<method name="ref" symbol="gdk_drag_context_ref">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GdkDragContext*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gdk_drag_context_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GdkDragContext*"/>
				</parameters>
			</method>
			<field name="protocol" type="GdkDragProtocol"/>
			<field name="is_source" type="gboolean"/>
			<field name="source_window" type="GdkWindow*"/>
			<field name="dest_window" type="GdkWindow*"/>
			<field name="targets" type="GList*"/>
			<field name="actions" type="GdkDragAction"/>
			<field name="suggested_action" type="GdkDragAction"/>
			<field name="action" type="GdkDragAction"/>
			<field name="start_time" type="guint32"/>
			<field name="windowing_data" type="gpointer"/>
		</object>
		<object name="GdkDrawable" parent="GObject" type-name="GdkDrawable" get-type="gdk_drawable_get_type">
			<method name="copy_to_image" symbol="gdk_drawable_copy_to_image">
				<return-type type="GdkImage*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="image" type="GdkImage*"/>
					<parameter name="src_x" type="gint"/>
					<parameter name="src_y" type="gint"/>
					<parameter name="dest_x" type="gint"/>
					<parameter name="dest_y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<method name="get_clip_region" symbol="gdk_drawable_get_clip_region">
				<return-type type="GdkRegion*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</method>
			<method name="get_colormap" symbol="gdk_drawable_get_colormap">
				<return-type type="GdkColormap*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</method>
			<method name="get_data" symbol="gdk_drawable_get_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_depth" symbol="gdk_drawable_get_depth">
				<return-type type="gint"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</method>
			<method name="get_display" symbol="gdk_drawable_get_display">
				<return-type type="GdkDisplay*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</method>
			<method name="get_image" symbol="gdk_drawable_get_image">
				<return-type type="GdkImage*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="gdk_drawable_get_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gdk_drawable_get_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
				</parameters>
			</method>
			<method name="get_visible_region" symbol="gdk_drawable_get_visible_region">
				<return-type type="GdkRegion*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</method>
			<method name="get_visual" symbol="gdk_drawable_get_visual">
				<return-type type="GdkVisual*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</method>
			<method name="ref" symbol="gdk_drawable_ref">
				<return-type type="GdkDrawable*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</method>
			<method name="set_colormap" symbol="gdk_drawable_set_colormap">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="colormap" type="GdkColormap*"/>
				</parameters>
			</method>
			<method name="set_data" symbol="gdk_drawable_set_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="destroy_func" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="unref" symbol="gdk_drawable_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</method>
			<vfunc name="create_cairo_surface">
				<return-type type="cairo_surface_t*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</vfunc>
			<vfunc name="create_gc">
				<return-type type="GdkGC*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="values" type="GdkGCValues*"/>
					<parameter name="mask" type="GdkGCValuesMask"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_arc">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="filled" type="gboolean"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="angle1" type="gint"/>
					<parameter name="angle2" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_drawable">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="src" type="GdkDrawable*"/>
					<parameter name="xsrc" type="gint"/>
					<parameter name="ysrc" type="gint"/>
					<parameter name="xdest" type="gint"/>
					<parameter name="ydest" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_drawable_with_src">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="src" type="GdkDrawable*"/>
					<parameter name="xsrc" type="gint"/>
					<parameter name="ysrc" type="gint"/>
					<parameter name="xdest" type="gint"/>
					<parameter name="ydest" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="original_src" type="GdkDrawable*"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_glyphs">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="font" type="PangoFont*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="glyphs" type="PangoGlyphString*"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_glyphs_transformed">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="matrix" type="PangoMatrix*"/>
					<parameter name="font" type="PangoFont*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="glyphs" type="PangoGlyphString*"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_image">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="image" type="GdkImage*"/>
					<parameter name="xsrc" type="gint"/>
					<parameter name="ysrc" type="gint"/>
					<parameter name="xdest" type="gint"/>
					<parameter name="ydest" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_lines">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="points" type="GdkPoint*"/>
					<parameter name="npoints" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_pixbuf">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="src_x" type="gint"/>
					<parameter name="src_y" type="gint"/>
					<parameter name="dest_x" type="gint"/>
					<parameter name="dest_y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="dither" type="GdkRgbDither"/>
					<parameter name="x_dither" type="gint"/>
					<parameter name="y_dither" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_points">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="points" type="GdkPoint*"/>
					<parameter name="npoints" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_polygon">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="filled" type="gboolean"/>
					<parameter name="points" type="GdkPoint*"/>
					<parameter name="npoints" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_rectangle">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="filled" type="gboolean"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_segments">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="segs" type="GdkSegment*"/>
					<parameter name="nsegs" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="font" type="GdkFont*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="text_length" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_text_wc">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="font" type="GdkFont*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="text" type="GdkWChar*"/>
					<parameter name="text_length" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_trapezoids">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="trapezoids" type="GdkTrapezoid*"/>
					<parameter name="n_trapezoids" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_clip_region">
				<return-type type="GdkRegion*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_colormap">
				<return-type type="GdkColormap*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_composite_drawable">
				<return-type type="GdkDrawable*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="composite_x_offset" type="gint*"/>
					<parameter name="composite_y_offset" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_depth">
				<return-type type="gint"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_image">
				<return-type type="GdkImage*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_source_drawable">
				<return-type type="GdkDrawable*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_visible_region">
				<return-type type="GdkRegion*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_visual">
				<return-type type="GdkVisual*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</vfunc>
			<vfunc name="ref_cairo_surface">
				<return-type type="cairo_surface_t*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_cairo_clip">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="cr" type="cairo_t*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_colormap">
				<return-type type="void"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="cmap" type="GdkColormap*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GdkGC" parent="GObject" type-name="GdkGC" get-type="gdk_gc_get_type">
			<method name="copy" symbol="gdk_gc_copy">
				<return-type type="void"/>
				<parameters>
					<parameter name="dst_gc" type="GdkGC*"/>
					<parameter name="src_gc" type="GdkGC*"/>
				</parameters>
			</method>
			<method name="get_colormap" symbol="gdk_gc_get_colormap">
				<return-type type="GdkColormap*"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="gdk_gc_get_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
				</parameters>
			</method>
			<method name="get_values" symbol="gdk_gc_get_values">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="values" type="GdkGCValues*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdk_gc_new">
				<return-type type="GdkGC*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_values" symbol="gdk_gc_new_with_values">
				<return-type type="GdkGC*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="values" type="GdkGCValues*"/>
					<parameter name="values_mask" type="GdkGCValuesMask"/>
				</parameters>
			</constructor>
			<method name="offset" symbol="gdk_gc_offset">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="x_offset" type="gint"/>
					<parameter name="y_offset" type="gint"/>
				</parameters>
			</method>
			<method name="ref" symbol="gdk_gc_ref">
				<return-type type="GdkGC*"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
				</parameters>
			</method>
			<method name="set_background" symbol="gdk_gc_set_background">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_clip_mask" symbol="gdk_gc_set_clip_mask">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="mask" type="GdkBitmap*"/>
				</parameters>
			</method>
			<method name="set_clip_origin" symbol="gdk_gc_set_clip_origin">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="set_clip_rectangle" symbol="gdk_gc_set_clip_rectangle">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="rectangle" type="GdkRectangle*"/>
				</parameters>
			</method>
			<method name="set_clip_region" symbol="gdk_gc_set_clip_region">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="region" type="GdkRegion*"/>
				</parameters>
			</method>
			<method name="set_colormap" symbol="gdk_gc_set_colormap">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="colormap" type="GdkColormap*"/>
				</parameters>
			</method>
			<method name="set_dashes" symbol="gdk_gc_set_dashes">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="dash_offset" type="gint"/>
					<parameter name="dash_list" type="gint8[]"/>
					<parameter name="n" type="gint"/>
				</parameters>
			</method>
			<method name="set_exposures" symbol="gdk_gc_set_exposures">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="exposures" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_fill" symbol="gdk_gc_set_fill">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="fill" type="GdkFill"/>
				</parameters>
			</method>
			<method name="set_font" symbol="gdk_gc_set_font">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="font" type="GdkFont*"/>
				</parameters>
			</method>
			<method name="set_foreground" symbol="gdk_gc_set_foreground">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_function" symbol="gdk_gc_set_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="function" type="GdkFunction"/>
				</parameters>
			</method>
			<method name="set_line_attributes" symbol="gdk_gc_set_line_attributes">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="line_width" type="gint"/>
					<parameter name="line_style" type="GdkLineStyle"/>
					<parameter name="cap_style" type="GdkCapStyle"/>
					<parameter name="join_style" type="GdkJoinStyle"/>
				</parameters>
			</method>
			<method name="set_rgb_bg_color" symbol="gdk_gc_set_rgb_bg_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_rgb_fg_color" symbol="gdk_gc_set_rgb_fg_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_stipple" symbol="gdk_gc_set_stipple">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="stipple" type="GdkPixmap*"/>
				</parameters>
			</method>
			<method name="set_subwindow" symbol="gdk_gc_set_subwindow">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="mode" type="GdkSubwindowMode"/>
				</parameters>
			</method>
			<method name="set_tile" symbol="gdk_gc_set_tile">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="tile" type="GdkPixmap*"/>
				</parameters>
			</method>
			<method name="set_ts_origin" symbol="gdk_gc_set_ts_origin">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="set_values" symbol="gdk_gc_set_values">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="values" type="GdkGCValues*"/>
					<parameter name="values_mask" type="GdkGCValuesMask"/>
				</parameters>
			</method>
			<method name="unref" symbol="gdk_gc_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
				</parameters>
			</method>
			<vfunc name="get_values">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="values" type="GdkGCValues*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_dashes">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="dash_offset" type="gint"/>
					<parameter name="dash_list" type="gint8[]"/>
					<parameter name="n" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_values">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="GdkGC*"/>
					<parameter name="values" type="GdkGCValues*"/>
					<parameter name="mask" type="GdkGCValuesMask"/>
				</parameters>
			</vfunc>
			<field name="clip_x_origin" type="gint"/>
			<field name="clip_y_origin" type="gint"/>
			<field name="ts_x_origin" type="gint"/>
			<field name="ts_y_origin" type="gint"/>
			<field name="colormap" type="GdkColormap*"/>
		</object>
		<object name="GdkImage" parent="GObject" type-name="GdkImage" get-type="gdk_image_get_type">
			<method name="get" symbol="gdk_image_get">
				<return-type type="GdkImage*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<method name="get_bits_per_pixel" symbol="gdk_image_get_bits_per_pixel">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<method name="get_byte_order" symbol="gdk_image_get_byte_order">
				<return-type type="GdkByteOrder"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<method name="get_bytes_per_line" symbol="gdk_image_get_bytes_per_line">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<method name="get_bytes_per_pixel" symbol="gdk_image_get_bytes_per_pixel">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<method name="get_colormap" symbol="gdk_image_get_colormap">
				<return-type type="GdkColormap*"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<method name="get_depth" symbol="gdk_image_get_depth">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="gdk_image_get_height">
				<return-type type="gint"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<method name="get_image_type" symbol="gdk_image_get_image_type">
				<return-type type="GdkImageType"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<method name="get_pixel" symbol="gdk_image_get_pixel">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="get_pixels" symbol="gdk_image_get_pixels">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<method name="get_visual" symbol="gdk_image_get_visual">
				<return-type type="GdkVisual*"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="gdk_image_get_width">
				<return-type type="gint"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdk_image_new">
				<return-type type="GdkImage*"/>
				<parameters>
					<parameter name="type" type="GdkImageType"/>
					<parameter name="visual" type="GdkVisual*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</constructor>
			<method name="put_pixel" symbol="gdk_image_put_pixel">
				<return-type type="void"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="pixel" type="guint32"/>
				</parameters>
			</method>
			<method name="ref" symbol="gdk_image_ref">
				<return-type type="GdkImage*"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<method name="set_colormap" symbol="gdk_image_set_colormap">
				<return-type type="void"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
					<parameter name="colormap" type="GdkColormap*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gdk_image_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="image" type="GdkImage*"/>
				</parameters>
			</method>
			<field name="type" type="GdkImageType"/>
			<field name="visual" type="GdkVisual*"/>
			<field name="byte_order" type="GdkByteOrder"/>
			<field name="width" type="gint"/>
			<field name="height" type="gint"/>
			<field name="depth" type="guint16"/>
			<field name="bpp" type="guint16"/>
			<field name="bpl" type="guint16"/>
			<field name="bits_per_pixel" type="guint16"/>
			<field name="mem" type="gpointer"/>
			<field name="colormap" type="GdkColormap*"/>
			<field name="windowing_data" type="gpointer"/>
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
					<parameter name="keymap" type="GdkKeymap*"/>
				</parameters>
			</signal>
			<signal name="keys-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="keymap" type="GdkKeymap*"/>
				</parameters>
			</signal>
			<signal name="state-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="keymap" type="GdkKeymap*"/>
				</parameters>
			</signal>
			<field name="display" type="GdkDisplay*"/>
		</object>
		<object name="GdkPangoRenderer" parent="PangoRenderer" type-name="GdkPangoRenderer" get-type="gdk_pango_renderer_get_type">
			<method name="get_default" symbol="gdk_pango_renderer_get_default">
				<return-type type="PangoRenderer*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdk_pango_renderer_new">
				<return-type type="PangoRenderer*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</constructor>
			<method name="set_drawable" symbol="gdk_pango_renderer_set_drawable">
				<return-type type="void"/>
				<parameters>
					<parameter name="gdk_renderer" type="GdkPangoRenderer*"/>
					<parameter name="drawable" type="GdkDrawable*"/>
				</parameters>
			</method>
			<method name="set_gc" symbol="gdk_pango_renderer_set_gc">
				<return-type type="void"/>
				<parameters>
					<parameter name="gdk_renderer" type="GdkPangoRenderer*"/>
					<parameter name="gc" type="GdkGC*"/>
				</parameters>
			</method>
			<method name="set_override_color" symbol="gdk_pango_renderer_set_override_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="gdk_renderer" type="GdkPangoRenderer*"/>
					<parameter name="part" type="PangoRenderPart"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_stipple" symbol="gdk_pango_renderer_set_stipple">
				<return-type type="void"/>
				<parameters>
					<parameter name="gdk_renderer" type="GdkPangoRenderer*"/>
					<parameter name="part" type="PangoRenderPart"/>
					<parameter name="stipple" type="GdkBitmap*"/>
				</parameters>
			</method>
			<property name="screen" type="GdkScreen*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdkPixmap" parent="GdkDrawable" type-name="GdkPixmap" get-type="gdk_pixmap_get_type">
			<method name="colormap_create_from_xpm" symbol="gdk_pixmap_colormap_create_from_xpm">
				<return-type type="GdkPixmap*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="colormap" type="GdkColormap*"/>
					<parameter name="mask" type="GdkBitmap**"/>
					<parameter name="transparent_color" type="GdkColor*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="colormap_create_from_xpm_d" symbol="gdk_pixmap_colormap_create_from_xpm_d">
				<return-type type="GdkPixmap*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="colormap" type="GdkColormap*"/>
					<parameter name="mask" type="GdkBitmap**"/>
					<parameter name="transparent_color" type="GdkColor*"/>
					<parameter name="data" type="gchar**"/>
				</parameters>
			</method>
			<method name="create_from_data" symbol="gdk_pixmap_create_from_data">
				<return-type type="GdkPixmap*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="depth" type="gint"/>
					<parameter name="fg" type="GdkColor*"/>
					<parameter name="bg" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="create_from_xpm" symbol="gdk_pixmap_create_from_xpm">
				<return-type type="GdkPixmap*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="mask" type="GdkBitmap**"/>
					<parameter name="transparent_color" type="GdkColor*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="create_from_xpm_d" symbol="gdk_pixmap_create_from_xpm_d">
				<return-type type="GdkPixmap*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="mask" type="GdkBitmap**"/>
					<parameter name="transparent_color" type="GdkColor*"/>
					<parameter name="data" type="gchar**"/>
				</parameters>
			</method>
			<method name="foreign_new" symbol="gdk_pixmap_foreign_new">
				<return-type type="GdkPixmap*"/>
				<parameters>
					<parameter name="anid" type="GdkNativeWindow"/>
				</parameters>
			</method>
			<method name="foreign_new_for_display" symbol="gdk_pixmap_foreign_new_for_display">
				<return-type type="GdkPixmap*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="anid" type="GdkNativeWindow"/>
				</parameters>
			</method>
			<method name="foreign_new_for_screen" symbol="gdk_pixmap_foreign_new_for_screen">
				<return-type type="GdkPixmap*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="anid" type="GdkNativeWindow"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="depth" type="gint"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gdk_pixmap_get_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="pixmap" type="GdkPixmap*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
				</parameters>
			</method>
			<method name="lookup" symbol="gdk_pixmap_lookup">
				<return-type type="GdkPixmap*"/>
				<parameters>
					<parameter name="anid" type="GdkNativeWindow"/>
				</parameters>
			</method>
			<method name="lookup_for_display" symbol="gdk_pixmap_lookup_for_display">
				<return-type type="GdkPixmap*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="anid" type="GdkNativeWindow"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdk_pixmap_new">
				<return-type type="GdkPixmap*"/>
				<parameters>
					<parameter name="drawable" type="GdkDrawable*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="depth" type="gint"/>
				</parameters>
			</constructor>
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
			<method name="get_default_colormap" symbol="gdk_screen_get_default_colormap">
				<return-type type="GdkColormap*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
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
			<method name="get_rgb_colormap" symbol="gdk_screen_get_rgb_colormap">
				<return-type type="GdkColormap*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_rgb_visual" symbol="gdk_screen_get_rgb_visual">
				<return-type type="GdkVisual*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="get_rgba_colormap" symbol="gdk_screen_get_rgba_colormap">
				<return-type type="GdkColormap*"/>
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
			<method name="get_system_colormap" symbol="gdk_screen_get_system_colormap">
				<return-type type="GdkColormap*"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
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
			<method name="set_default_colormap" symbol="gdk_screen_set_default_colormap">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="colormap" type="GdkColormap*"/>
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
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</signal>
			<signal name="monitors-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</signal>
			<signal name="size-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</signal>
			<field name="closed" type="guint"/>
			<field name="normal_gcs" type="GdkGC*[]"/>
			<field name="exposure_gcs" type="GdkGC*[]"/>
			<field name="subwindow_gcs" type="GdkGC*[]"/>
			<field name="font_options" type="cairo_font_options_t*"/>
			<field name="resolution" type="double"/>
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
			<field name="type" type="GdkVisualType"/>
			<field name="depth" type="gint"/>
			<field name="byte_order" type="GdkByteOrder"/>
			<field name="colormap_size" type="gint"/>
			<field name="bits_per_rgb" type="gint"/>
			<field name="red_mask" type="guint32"/>
			<field name="red_shift" type="gint"/>
			<field name="red_prec" type="gint"/>
			<field name="green_mask" type="guint32"/>
			<field name="green_shift" type="gint"/>
			<field name="green_prec" type="gint"/>
			<field name="blue_mask" type="guint32"/>
			<field name="blue_shift" type="gint"/>
			<field name="blue_prec" type="gint"/>
		</object>
		<object name="GdkWindow" parent="GdkDrawable" type-name="GdkWindow" get-type="gdk_window_object_get_type">
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
					<parameter name="region" type="GdkRegion*"/>
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
			<method name="clear" symbol="gdk_window_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="clear_area" symbol="gdk_window_clear_area">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<method name="clear_area_e" symbol="gdk_window_clear_area_e">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
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
			<method name="foreign_new" symbol="gdk_window_foreign_new">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="anid" type="GdkNativeWindow"/>
				</parameters>
			</method>
			<method name="foreign_new_for_display" symbol="gdk_window_foreign_new_for_display">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="anid" type="GdkNativeWindow"/>
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
			<method name="get_deskrelative_origin" symbol="gdk_window_get_deskrelative_origin">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
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
					<parameter name="depth" type="gint*"/>
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
			<method name="get_internal_paint_info" symbol="gdk_window_get_internal_paint_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="real_drawable" type="GdkDrawable**"/>
					<parameter name="x_offset" type="gint*"/>
					<parameter name="y_offset" type="gint*"/>
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
			<method name="get_state" symbol="gdk_window_get_state">
				<return-type type="GdkWindowState"/>
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
			<method name="get_toplevels" symbol="gdk_window_get_toplevels">
				<return-type type="GList*"/>
			</method>
			<method name="get_type_hint" symbol="gdk_window_get_type_hint">
				<return-type type="GdkWindowTypeHint"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
				</parameters>
			</method>
			<method name="get_update_area" symbol="gdk_window_get_update_area">
				<return-type type="GdkRegion*"/>
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
			<method name="input_shape_combine_mask" symbol="gdk_window_input_shape_combine_mask">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="mask" type="GdkBitmap*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="input_shape_combine_region" symbol="gdk_window_input_shape_combine_region">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="shape_region" type="GdkRegion*"/>
					<parameter name="offset_x" type="gint"/>
					<parameter name="offset_y" type="gint"/>
				</parameters>
			</method>
			<method name="invalidate_maybe_recurse" symbol="gdk_window_invalidate_maybe_recurse">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="region" type="GdkRegion*"/>
					<parameter name="child_func" type="GCallback"/>
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
					<parameter name="region" type="GdkRegion*"/>
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
			<method name="lookup" symbol="gdk_window_lookup">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="anid" type="GdkNativeWindow"/>
				</parameters>
			</method>
			<method name="lookup_for_display" symbol="gdk_window_lookup_for_display">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="display" type="GdkDisplay*"/>
					<parameter name="anid" type="GdkNativeWindow"/>
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
					<parameter name="region" type="GdkRegion*"/>
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
			<method name="remove_redirection" symbol="gdk_window_remove_redirection">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
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
			<method name="set_back_pixmap" symbol="gdk_window_set_back_pixmap">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="pixmap" type="GdkPixmap*"/>
					<parameter name="parent_relative" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_background" symbol="gdk_window_set_background">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="color" type="GdkColor*"/>
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
			<method name="set_hints" symbol="gdk_window_set_hints">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="min_width" type="gint"/>
					<parameter name="min_height" type="gint"/>
					<parameter name="max_width" type="gint"/>
					<parameter name="max_height" type="gint"/>
					<parameter name="flags" type="gint"/>
				</parameters>
			</method>
			<method name="set_icon" symbol="gdk_window_set_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="icon_window" type="GdkWindow*"/>
					<parameter name="pixmap" type="GdkPixmap*"/>
					<parameter name="mask" type="GdkBitmap*"/>
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
			<method name="shape_combine_mask" symbol="gdk_window_shape_combine_mask">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="mask" type="GdkBitmap*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="shape_combine_region" symbol="gdk_window_shape_combine_region">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="GdkWindow*"/>
					<parameter name="shape_region" type="GdkRegion*"/>
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
			<signal name="from-embedder" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkWindow*"/>
					<parameter name="p0" type="gdouble"/>
					<parameter name="p1" type="gdouble"/>
					<parameter name="p2" type="gpointer"/>
					<parameter name="p3" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="pick-embedded-child" when="LAST">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="object" type="GdkWindow*"/>
					<parameter name="p0" type="gdouble"/>
					<parameter name="p1" type="gdouble"/>
				</parameters>
			</signal>
			<signal name="to-embedder" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdkWindow*"/>
					<parameter name="p0" type="gdouble"/>
					<parameter name="p1" type="gdouble"/>
					<parameter name="p2" type="gpointer"/>
					<parameter name="p3" type="gpointer"/>
				</parameters>
			</signal>
		</object>
		<constant name="GDK_CURRENT_TIME" type="int" value="0"/>
		<constant name="GDK_KEY_0" type="int" value="48"/>
		<constant name="GDK_KEY_1" type="int" value="49"/>
		<constant name="GDK_KEY_2" type="int" value="50"/>
		<constant name="GDK_KEY_3" type="int" value="51"/>
		<constant name="GDK_KEY_3270_AltCursor" type="int" value="64784"/>
		<constant name="GDK_KEY_3270_Attn" type="int" value="64782"/>
		<constant name="GDK_KEY_3270_BackTab" type="int" value="64773"/>
		<constant name="GDK_KEY_3270_ChangeScreen" type="int" value="64793"/>
		<constant name="GDK_KEY_3270_Copy" type="int" value="64789"/>
		<constant name="GDK_KEY_3270_CursorBlink" type="int" value="64783"/>
		<constant name="GDK_KEY_3270_CursorSelect" type="int" value="64796"/>
		<constant name="GDK_KEY_3270_DeleteWord" type="int" value="64794"/>
		<constant name="GDK_KEY_3270_Duplicate" type="int" value="64769"/>
		<constant name="GDK_KEY_3270_Enter" type="int" value="64798"/>
		<constant name="GDK_KEY_3270_EraseEOF" type="int" value="64774"/>
		<constant name="GDK_KEY_3270_EraseInput" type="int" value="64775"/>
		<constant name="GDK_KEY_3270_ExSelect" type="int" value="64795"/>
		<constant name="GDK_KEY_3270_FieldMark" type="int" value="64770"/>
		<constant name="GDK_KEY_3270_Ident" type="int" value="64787"/>
		<constant name="GDK_KEY_3270_Jump" type="int" value="64786"/>
		<constant name="GDK_KEY_3270_KeyClick" type="int" value="64785"/>
		<constant name="GDK_KEY_3270_Left2" type="int" value="64772"/>
		<constant name="GDK_KEY_3270_PA1" type="int" value="64778"/>
		<constant name="GDK_KEY_3270_PA2" type="int" value="64779"/>
		<constant name="GDK_KEY_3270_PA3" type="int" value="64780"/>
		<constant name="GDK_KEY_3270_Play" type="int" value="64790"/>
		<constant name="GDK_KEY_3270_PrintScreen" type="int" value="64797"/>
		<constant name="GDK_KEY_3270_Quit" type="int" value="64777"/>
		<constant name="GDK_KEY_3270_Record" type="int" value="64792"/>
		<constant name="GDK_KEY_3270_Reset" type="int" value="64776"/>
		<constant name="GDK_KEY_3270_Right2" type="int" value="64771"/>
		<constant name="GDK_KEY_3270_Rule" type="int" value="64788"/>
		<constant name="GDK_KEY_3270_Setup" type="int" value="64791"/>
		<constant name="GDK_KEY_3270_Test" type="int" value="64781"/>
		<constant name="GDK_KEY_4" type="int" value="52"/>
		<constant name="GDK_KEY_5" type="int" value="53"/>
		<constant name="GDK_KEY_6" type="int" value="54"/>
		<constant name="GDK_KEY_7" type="int" value="55"/>
		<constant name="GDK_KEY_8" type="int" value="56"/>
		<constant name="GDK_KEY_9" type="int" value="57"/>
		<constant name="GDK_KEY_A" type="int" value="65"/>
		<constant name="GDK_KEY_AE" type="int" value="198"/>
		<constant name="GDK_KEY_Aacute" type="int" value="193"/>
		<constant name="GDK_KEY_Abelowdot" type="int" value="16785056"/>
		<constant name="GDK_KEY_Abreve" type="int" value="451"/>
		<constant name="GDK_KEY_Abreveacute" type="int" value="16785070"/>
		<constant name="GDK_KEY_Abrevebelowdot" type="int" value="16785078"/>
		<constant name="GDK_KEY_Abrevegrave" type="int" value="16785072"/>
		<constant name="GDK_KEY_Abrevehook" type="int" value="16785074"/>
		<constant name="GDK_KEY_Abrevetilde" type="int" value="16785076"/>
		<constant name="GDK_KEY_AccessX_Enable" type="int" value="65136"/>
		<constant name="GDK_KEY_AccessX_Feedback_Enable" type="int" value="65137"/>
		<constant name="GDK_KEY_Acircumflex" type="int" value="194"/>
		<constant name="GDK_KEY_Acircumflexacute" type="int" value="16785060"/>
		<constant name="GDK_KEY_Acircumflexbelowdot" type="int" value="16785068"/>
		<constant name="GDK_KEY_Acircumflexgrave" type="int" value="16785062"/>
		<constant name="GDK_KEY_Acircumflexhook" type="int" value="16785064"/>
		<constant name="GDK_KEY_Acircumflextilde" type="int" value="16785066"/>
		<constant name="GDK_KEY_AddFavorite" type="int" value="269025081"/>
		<constant name="GDK_KEY_Adiaeresis" type="int" value="196"/>
		<constant name="GDK_KEY_Agrave" type="int" value="192"/>
		<constant name="GDK_KEY_Ahook" type="int" value="16785058"/>
		<constant name="GDK_KEY_Alt_L" type="int" value="65513"/>
		<constant name="GDK_KEY_Alt_R" type="int" value="65514"/>
		<constant name="GDK_KEY_Amacron" type="int" value="960"/>
		<constant name="GDK_KEY_Aogonek" type="int" value="417"/>
		<constant name="GDK_KEY_ApplicationLeft" type="int" value="269025104"/>
		<constant name="GDK_KEY_ApplicationRight" type="int" value="269025105"/>
		<constant name="GDK_KEY_Arabic_0" type="int" value="16778848"/>
		<constant name="GDK_KEY_Arabic_1" type="int" value="16778849"/>
		<constant name="GDK_KEY_Arabic_2" type="int" value="16778850"/>
		<constant name="GDK_KEY_Arabic_3" type="int" value="16778851"/>
		<constant name="GDK_KEY_Arabic_4" type="int" value="16778852"/>
		<constant name="GDK_KEY_Arabic_5" type="int" value="16778853"/>
		<constant name="GDK_KEY_Arabic_6" type="int" value="16778854"/>
		<constant name="GDK_KEY_Arabic_7" type="int" value="16778855"/>
		<constant name="GDK_KEY_Arabic_8" type="int" value="16778856"/>
		<constant name="GDK_KEY_Arabic_9" type="int" value="16778857"/>
		<constant name="GDK_KEY_Arabic_ain" type="int" value="1497"/>
		<constant name="GDK_KEY_Arabic_alef" type="int" value="1479"/>
		<constant name="GDK_KEY_Arabic_alefmaksura" type="int" value="1513"/>
		<constant name="GDK_KEY_Arabic_beh" type="int" value="1480"/>
		<constant name="GDK_KEY_Arabic_comma" type="int" value="1452"/>
		<constant name="GDK_KEY_Arabic_dad" type="int" value="1494"/>
		<constant name="GDK_KEY_Arabic_dal" type="int" value="1487"/>
		<constant name="GDK_KEY_Arabic_damma" type="int" value="1519"/>
		<constant name="GDK_KEY_Arabic_dammatan" type="int" value="1516"/>
		<constant name="GDK_KEY_Arabic_ddal" type="int" value="16778888"/>
		<constant name="GDK_KEY_Arabic_farsi_yeh" type="int" value="16778956"/>
		<constant name="GDK_KEY_Arabic_fatha" type="int" value="1518"/>
		<constant name="GDK_KEY_Arabic_fathatan" type="int" value="1515"/>
		<constant name="GDK_KEY_Arabic_feh" type="int" value="1505"/>
		<constant name="GDK_KEY_Arabic_fullstop" type="int" value="16778964"/>
		<constant name="GDK_KEY_Arabic_gaf" type="int" value="16778927"/>
		<constant name="GDK_KEY_Arabic_ghain" type="int" value="1498"/>
		<constant name="GDK_KEY_Arabic_ha" type="int" value="1511"/>
		<constant name="GDK_KEY_Arabic_hah" type="int" value="1485"/>
		<constant name="GDK_KEY_Arabic_hamza" type="int" value="1473"/>
		<constant name="GDK_KEY_Arabic_hamza_above" type="int" value="16778836"/>
		<constant name="GDK_KEY_Arabic_hamza_below" type="int" value="16778837"/>
		<constant name="GDK_KEY_Arabic_hamzaonalef" type="int" value="1475"/>
		<constant name="GDK_KEY_Arabic_hamzaonwaw" type="int" value="1476"/>
		<constant name="GDK_KEY_Arabic_hamzaonyeh" type="int" value="1478"/>
		<constant name="GDK_KEY_Arabic_hamzaunderalef" type="int" value="1477"/>
		<constant name="GDK_KEY_Arabic_heh" type="int" value="1511"/>
		<constant name="GDK_KEY_Arabic_heh_doachashmee" type="int" value="16778942"/>
		<constant name="GDK_KEY_Arabic_heh_goal" type="int" value="16778945"/>
		<constant name="GDK_KEY_Arabic_jeem" type="int" value="1484"/>
		<constant name="GDK_KEY_Arabic_jeh" type="int" value="16778904"/>
		<constant name="GDK_KEY_Arabic_kaf" type="int" value="1507"/>
		<constant name="GDK_KEY_Arabic_kasra" type="int" value="1520"/>
		<constant name="GDK_KEY_Arabic_kasratan" type="int" value="1517"/>
		<constant name="GDK_KEY_Arabic_keheh" type="int" value="16778921"/>
		<constant name="GDK_KEY_Arabic_khah" type="int" value="1486"/>
		<constant name="GDK_KEY_Arabic_lam" type="int" value="1508"/>
		<constant name="GDK_KEY_Arabic_madda_above" type="int" value="16778835"/>
		<constant name="GDK_KEY_Arabic_maddaonalef" type="int" value="1474"/>
		<constant name="GDK_KEY_Arabic_meem" type="int" value="1509"/>
		<constant name="GDK_KEY_Arabic_noon" type="int" value="1510"/>
		<constant name="GDK_KEY_Arabic_noon_ghunna" type="int" value="16778938"/>
		<constant name="GDK_KEY_Arabic_peh" type="int" value="16778878"/>
		<constant name="GDK_KEY_Arabic_percent" type="int" value="16778858"/>
		<constant name="GDK_KEY_Arabic_qaf" type="int" value="1506"/>
		<constant name="GDK_KEY_Arabic_question_mark" type="int" value="1471"/>
		<constant name="GDK_KEY_Arabic_ra" type="int" value="1489"/>
		<constant name="GDK_KEY_Arabic_rreh" type="int" value="16778897"/>
		<constant name="GDK_KEY_Arabic_sad" type="int" value="1493"/>
		<constant name="GDK_KEY_Arabic_seen" type="int" value="1491"/>
		<constant name="GDK_KEY_Arabic_semicolon" type="int" value="1467"/>
		<constant name="GDK_KEY_Arabic_shadda" type="int" value="1521"/>
		<constant name="GDK_KEY_Arabic_sheen" type="int" value="1492"/>
		<constant name="GDK_KEY_Arabic_sukun" type="int" value="1522"/>
		<constant name="GDK_KEY_Arabic_superscript_alef" type="int" value="16778864"/>
		<constant name="GDK_KEY_Arabic_switch" type="int" value="65406"/>
		<constant name="GDK_KEY_Arabic_tah" type="int" value="1495"/>
		<constant name="GDK_KEY_Arabic_tatweel" type="int" value="1504"/>
		<constant name="GDK_KEY_Arabic_tcheh" type="int" value="16778886"/>
		<constant name="GDK_KEY_Arabic_teh" type="int" value="1482"/>
		<constant name="GDK_KEY_Arabic_tehmarbuta" type="int" value="1481"/>
		<constant name="GDK_KEY_Arabic_thal" type="int" value="1488"/>
		<constant name="GDK_KEY_Arabic_theh" type="int" value="1483"/>
		<constant name="GDK_KEY_Arabic_tteh" type="int" value="16778873"/>
		<constant name="GDK_KEY_Arabic_veh" type="int" value="16778916"/>
		<constant name="GDK_KEY_Arabic_waw" type="int" value="1512"/>
		<constant name="GDK_KEY_Arabic_yeh" type="int" value="1514"/>
		<constant name="GDK_KEY_Arabic_yeh_baree" type="int" value="16778962"/>
		<constant name="GDK_KEY_Arabic_zah" type="int" value="1496"/>
		<constant name="GDK_KEY_Arabic_zain" type="int" value="1490"/>
		<constant name="GDK_KEY_Aring" type="int" value="197"/>
		<constant name="GDK_KEY_Armenian_AT" type="int" value="16778552"/>
		<constant name="GDK_KEY_Armenian_AYB" type="int" value="16778545"/>
		<constant name="GDK_KEY_Armenian_BEN" type="int" value="16778546"/>
		<constant name="GDK_KEY_Armenian_CHA" type="int" value="16778569"/>
		<constant name="GDK_KEY_Armenian_DA" type="int" value="16778548"/>
		<constant name="GDK_KEY_Armenian_DZA" type="int" value="16778561"/>
		<constant name="GDK_KEY_Armenian_E" type="int" value="16778551"/>
		<constant name="GDK_KEY_Armenian_FE" type="int" value="16778582"/>
		<constant name="GDK_KEY_Armenian_GHAT" type="int" value="16778562"/>
		<constant name="GDK_KEY_Armenian_GIM" type="int" value="16778547"/>
		<constant name="GDK_KEY_Armenian_HI" type="int" value="16778565"/>
		<constant name="GDK_KEY_Armenian_HO" type="int" value="16778560"/>
		<constant name="GDK_KEY_Armenian_INI" type="int" value="16778555"/>
		<constant name="GDK_KEY_Armenian_JE" type="int" value="16778571"/>
		<constant name="GDK_KEY_Armenian_KE" type="int" value="16778580"/>
		<constant name="GDK_KEY_Armenian_KEN" type="int" value="16778559"/>
		<constant name="GDK_KEY_Armenian_KHE" type="int" value="16778557"/>
		<constant name="GDK_KEY_Armenian_LYUN" type="int" value="16778556"/>
		<constant name="GDK_KEY_Armenian_MEN" type="int" value="16778564"/>
		<constant name="GDK_KEY_Armenian_NU" type="int" value="16778566"/>
		<constant name="GDK_KEY_Armenian_O" type="int" value="16778581"/>
		<constant name="GDK_KEY_Armenian_PE" type="int" value="16778570"/>
		<constant name="GDK_KEY_Armenian_PYUR" type="int" value="16778579"/>
		<constant name="GDK_KEY_Armenian_RA" type="int" value="16778572"/>
		<constant name="GDK_KEY_Armenian_RE" type="int" value="16778576"/>
		<constant name="GDK_KEY_Armenian_SE" type="int" value="16778573"/>
		<constant name="GDK_KEY_Armenian_SHA" type="int" value="16778567"/>
		<constant name="GDK_KEY_Armenian_TCHE" type="int" value="16778563"/>
		<constant name="GDK_KEY_Armenian_TO" type="int" value="16778553"/>
		<constant name="GDK_KEY_Armenian_TSA" type="int" value="16778558"/>
		<constant name="GDK_KEY_Armenian_TSO" type="int" value="16778577"/>
		<constant name="GDK_KEY_Armenian_TYUN" type="int" value="16778575"/>
		<constant name="GDK_KEY_Armenian_VEV" type="int" value="16778574"/>
		<constant name="GDK_KEY_Armenian_VO" type="int" value="16778568"/>
		<constant name="GDK_KEY_Armenian_VYUN" type="int" value="16778578"/>
		<constant name="GDK_KEY_Armenian_YECH" type="int" value="16778549"/>
		<constant name="GDK_KEY_Armenian_ZA" type="int" value="16778550"/>
		<constant name="GDK_KEY_Armenian_ZHE" type="int" value="16778554"/>
		<constant name="GDK_KEY_Armenian_accent" type="int" value="16778587"/>
		<constant name="GDK_KEY_Armenian_amanak" type="int" value="16778588"/>
		<constant name="GDK_KEY_Armenian_apostrophe" type="int" value="16778586"/>
		<constant name="GDK_KEY_Armenian_at" type="int" value="16778600"/>
		<constant name="GDK_KEY_Armenian_ayb" type="int" value="16778593"/>
		<constant name="GDK_KEY_Armenian_ben" type="int" value="16778594"/>
		<constant name="GDK_KEY_Armenian_but" type="int" value="16778589"/>
		<constant name="GDK_KEY_Armenian_cha" type="int" value="16778617"/>
		<constant name="GDK_KEY_Armenian_da" type="int" value="16778596"/>
		<constant name="GDK_KEY_Armenian_dza" type="int" value="16778609"/>
		<constant name="GDK_KEY_Armenian_e" type="int" value="16778599"/>
		<constant name="GDK_KEY_Armenian_exclam" type="int" value="16778588"/>
		<constant name="GDK_KEY_Armenian_fe" type="int" value="16778630"/>
		<constant name="GDK_KEY_Armenian_full_stop" type="int" value="16778633"/>
		<constant name="GDK_KEY_Armenian_ghat" type="int" value="16778610"/>
		<constant name="GDK_KEY_Armenian_gim" type="int" value="16778595"/>
		<constant name="GDK_KEY_Armenian_hi" type="int" value="16778613"/>
		<constant name="GDK_KEY_Armenian_ho" type="int" value="16778608"/>
		<constant name="GDK_KEY_Armenian_hyphen" type="int" value="16778634"/>
		<constant name="GDK_KEY_Armenian_ini" type="int" value="16778603"/>
		<constant name="GDK_KEY_Armenian_je" type="int" value="16778619"/>
		<constant name="GDK_KEY_Armenian_ke" type="int" value="16778628"/>
		<constant name="GDK_KEY_Armenian_ken" type="int" value="16778607"/>
		<constant name="GDK_KEY_Armenian_khe" type="int" value="16778605"/>
		<constant name="GDK_KEY_Armenian_ligature_ew" type="int" value="16778631"/>
		<constant name="GDK_KEY_Armenian_lyun" type="int" value="16778604"/>
		<constant name="GDK_KEY_Armenian_men" type="int" value="16778612"/>
		<constant name="GDK_KEY_Armenian_nu" type="int" value="16778614"/>
		<constant name="GDK_KEY_Armenian_o" type="int" value="16778629"/>
		<constant name="GDK_KEY_Armenian_paruyk" type="int" value="16778590"/>
		<constant name="GDK_KEY_Armenian_pe" type="int" value="16778618"/>
		<constant name="GDK_KEY_Armenian_pyur" type="int" value="16778627"/>
		<constant name="GDK_KEY_Armenian_question" type="int" value="16778590"/>
		<constant name="GDK_KEY_Armenian_ra" type="int" value="16778620"/>
		<constant name="GDK_KEY_Armenian_re" type="int" value="16778624"/>
		<constant name="GDK_KEY_Armenian_se" type="int" value="16778621"/>
		<constant name="GDK_KEY_Armenian_separation_mark" type="int" value="16778589"/>
		<constant name="GDK_KEY_Armenian_sha" type="int" value="16778615"/>
		<constant name="GDK_KEY_Armenian_shesht" type="int" value="16778587"/>
		<constant name="GDK_KEY_Armenian_tche" type="int" value="16778611"/>
		<constant name="GDK_KEY_Armenian_to" type="int" value="16778601"/>
		<constant name="GDK_KEY_Armenian_tsa" type="int" value="16778606"/>
		<constant name="GDK_KEY_Armenian_tso" type="int" value="16778625"/>
		<constant name="GDK_KEY_Armenian_tyun" type="int" value="16778623"/>
		<constant name="GDK_KEY_Armenian_verjaket" type="int" value="16778633"/>
		<constant name="GDK_KEY_Armenian_vev" type="int" value="16778622"/>
		<constant name="GDK_KEY_Armenian_vo" type="int" value="16778616"/>
		<constant name="GDK_KEY_Armenian_vyun" type="int" value="16778626"/>
		<constant name="GDK_KEY_Armenian_yech" type="int" value="16778597"/>
		<constant name="GDK_KEY_Armenian_yentamna" type="int" value="16778634"/>
		<constant name="GDK_KEY_Armenian_za" type="int" value="16778598"/>
		<constant name="GDK_KEY_Armenian_zhe" type="int" value="16778602"/>
		<constant name="GDK_KEY_Atilde" type="int" value="195"/>
		<constant name="GDK_KEY_AudibleBell_Enable" type="int" value="65146"/>
		<constant name="GDK_KEY_AudioCycleTrack" type="int" value="269025179"/>
		<constant name="GDK_KEY_AudioForward" type="int" value="269025175"/>
		<constant name="GDK_KEY_AudioLowerVolume" type="int" value="269025041"/>
		<constant name="GDK_KEY_AudioMedia" type="int" value="269025074"/>
		<constant name="GDK_KEY_AudioMute" type="int" value="269025042"/>
		<constant name="GDK_KEY_AudioNext" type="int" value="269025047"/>
		<constant name="GDK_KEY_AudioPause" type="int" value="269025073"/>
		<constant name="GDK_KEY_AudioPlay" type="int" value="269025044"/>
		<constant name="GDK_KEY_AudioPrev" type="int" value="269025046"/>
		<constant name="GDK_KEY_AudioRaiseVolume" type="int" value="269025043"/>
		<constant name="GDK_KEY_AudioRandomPlay" type="int" value="269025177"/>
		<constant name="GDK_KEY_AudioRecord" type="int" value="269025052"/>
		<constant name="GDK_KEY_AudioRepeat" type="int" value="269025176"/>
		<constant name="GDK_KEY_AudioRewind" type="int" value="269025086"/>
		<constant name="GDK_KEY_AudioStop" type="int" value="269025045"/>
		<constant name="GDK_KEY_Away" type="int" value="269025165"/>
		<constant name="GDK_KEY_B" type="int" value="66"/>
		<constant name="GDK_KEY_Babovedot" type="int" value="16784898"/>
		<constant name="GDK_KEY_Back" type="int" value="269025062"/>
		<constant name="GDK_KEY_BackForward" type="int" value="269025087"/>
		<constant name="GDK_KEY_BackSpace" type="int" value="65288"/>
		<constant name="GDK_KEY_Battery" type="int" value="269025171"/>
		<constant name="GDK_KEY_Begin" type="int" value="65368"/>
		<constant name="GDK_KEY_Blue" type="int" value="269025190"/>
		<constant name="GDK_KEY_Bluetooth" type="int" value="269025172"/>
		<constant name="GDK_KEY_Book" type="int" value="269025106"/>
		<constant name="GDK_KEY_BounceKeys_Enable" type="int" value="65140"/>
		<constant name="GDK_KEY_Break" type="int" value="65387"/>
		<constant name="GDK_KEY_BrightnessAdjust" type="int" value="269025083"/>
		<constant name="GDK_KEY_Byelorussian_SHORTU" type="int" value="1726"/>
		<constant name="GDK_KEY_Byelorussian_shortu" type="int" value="1710"/>
		<constant name="GDK_KEY_C" type="int" value="67"/>
		<constant name="GDK_KEY_CD" type="int" value="269025107"/>
		<constant name="GDK_KEY_Cabovedot" type="int" value="709"/>
		<constant name="GDK_KEY_Cacute" type="int" value="454"/>
		<constant name="GDK_KEY_Calculator" type="int" value="269025053"/>
		<constant name="GDK_KEY_Calendar" type="int" value="269025056"/>
		<constant name="GDK_KEY_Cancel" type="int" value="65385"/>
		<constant name="GDK_KEY_Caps_Lock" type="int" value="65509"/>
		<constant name="GDK_KEY_Ccaron" type="int" value="456"/>
		<constant name="GDK_KEY_Ccedilla" type="int" value="199"/>
		<constant name="GDK_KEY_Ccircumflex" type="int" value="710"/>
		<constant name="GDK_KEY_Clear" type="int" value="65291"/>
		<constant name="GDK_KEY_ClearGrab" type="int" value="269024801"/>
		<constant name="GDK_KEY_Close" type="int" value="269025110"/>
		<constant name="GDK_KEY_Codeinput" type="int" value="65335"/>
		<constant name="GDK_KEY_ColonSign" type="int" value="16785569"/>
		<constant name="GDK_KEY_Community" type="int" value="269025085"/>
		<constant name="GDK_KEY_ContrastAdjust" type="int" value="269025058"/>
		<constant name="GDK_KEY_Control_L" type="int" value="65507"/>
		<constant name="GDK_KEY_Control_R" type="int" value="65508"/>
		<constant name="GDK_KEY_Copy" type="int" value="269025111"/>
		<constant name="GDK_KEY_CruzeiroSign" type="int" value="16785570"/>
		<constant name="GDK_KEY_Cut" type="int" value="269025112"/>
		<constant name="GDK_KEY_CycleAngle" type="int" value="269025180"/>
		<constant name="GDK_KEY_Cyrillic_A" type="int" value="1761"/>
		<constant name="GDK_KEY_Cyrillic_BE" type="int" value="1762"/>
		<constant name="GDK_KEY_Cyrillic_CHE" type="int" value="1790"/>
		<constant name="GDK_KEY_Cyrillic_CHE_descender" type="int" value="16778422"/>
		<constant name="GDK_KEY_Cyrillic_CHE_vertstroke" type="int" value="16778424"/>
		<constant name="GDK_KEY_Cyrillic_DE" type="int" value="1764"/>
		<constant name="GDK_KEY_Cyrillic_DZHE" type="int" value="1727"/>
		<constant name="GDK_KEY_Cyrillic_E" type="int" value="1788"/>
		<constant name="GDK_KEY_Cyrillic_EF" type="int" value="1766"/>
		<constant name="GDK_KEY_Cyrillic_EL" type="int" value="1772"/>
		<constant name="GDK_KEY_Cyrillic_EM" type="int" value="1773"/>
		<constant name="GDK_KEY_Cyrillic_EN" type="int" value="1774"/>
		<constant name="GDK_KEY_Cyrillic_EN_descender" type="int" value="16778402"/>
		<constant name="GDK_KEY_Cyrillic_ER" type="int" value="1778"/>
		<constant name="GDK_KEY_Cyrillic_ES" type="int" value="1779"/>
		<constant name="GDK_KEY_Cyrillic_GHE" type="int" value="1767"/>
		<constant name="GDK_KEY_Cyrillic_GHE_bar" type="int" value="16778386"/>
		<constant name="GDK_KEY_Cyrillic_HA" type="int" value="1768"/>
		<constant name="GDK_KEY_Cyrillic_HARDSIGN" type="int" value="1791"/>
		<constant name="GDK_KEY_Cyrillic_HA_descender" type="int" value="16778418"/>
		<constant name="GDK_KEY_Cyrillic_I" type="int" value="1769"/>
		<constant name="GDK_KEY_Cyrillic_IE" type="int" value="1765"/>
		<constant name="GDK_KEY_Cyrillic_IO" type="int" value="1715"/>
		<constant name="GDK_KEY_Cyrillic_I_macron" type="int" value="16778466"/>
		<constant name="GDK_KEY_Cyrillic_JE" type="int" value="1720"/>
		<constant name="GDK_KEY_Cyrillic_KA" type="int" value="1771"/>
		<constant name="GDK_KEY_Cyrillic_KA_descender" type="int" value="16778394"/>
		<constant name="GDK_KEY_Cyrillic_KA_vertstroke" type="int" value="16778396"/>
		<constant name="GDK_KEY_Cyrillic_LJE" type="int" value="1721"/>
		<constant name="GDK_KEY_Cyrillic_NJE" type="int" value="1722"/>
		<constant name="GDK_KEY_Cyrillic_O" type="int" value="1775"/>
		<constant name="GDK_KEY_Cyrillic_O_bar" type="int" value="16778472"/>
		<constant name="GDK_KEY_Cyrillic_PE" type="int" value="1776"/>
		<constant name="GDK_KEY_Cyrillic_SCHWA" type="int" value="16778456"/>
		<constant name="GDK_KEY_Cyrillic_SHA" type="int" value="1787"/>
		<constant name="GDK_KEY_Cyrillic_SHCHA" type="int" value="1789"/>
		<constant name="GDK_KEY_Cyrillic_SHHA" type="int" value="16778426"/>
		<constant name="GDK_KEY_Cyrillic_SHORTI" type="int" value="1770"/>
		<constant name="GDK_KEY_Cyrillic_SOFTSIGN" type="int" value="1784"/>
		<constant name="GDK_KEY_Cyrillic_TE" type="int" value="1780"/>
		<constant name="GDK_KEY_Cyrillic_TSE" type="int" value="1763"/>
		<constant name="GDK_KEY_Cyrillic_U" type="int" value="1781"/>
		<constant name="GDK_KEY_Cyrillic_U_macron" type="int" value="16778478"/>
		<constant name="GDK_KEY_Cyrillic_U_straight" type="int" value="16778414"/>
		<constant name="GDK_KEY_Cyrillic_U_straight_bar" type="int" value="16778416"/>
		<constant name="GDK_KEY_Cyrillic_VE" type="int" value="1783"/>
		<constant name="GDK_KEY_Cyrillic_YA" type="int" value="1777"/>
		<constant name="GDK_KEY_Cyrillic_YERU" type="int" value="1785"/>
		<constant name="GDK_KEY_Cyrillic_YU" type="int" value="1760"/>
		<constant name="GDK_KEY_Cyrillic_ZE" type="int" value="1786"/>
		<constant name="GDK_KEY_Cyrillic_ZHE" type="int" value="1782"/>
		<constant name="GDK_KEY_Cyrillic_ZHE_descender" type="int" value="16778390"/>
		<constant name="GDK_KEY_Cyrillic_a" type="int" value="1729"/>
		<constant name="GDK_KEY_Cyrillic_be" type="int" value="1730"/>
		<constant name="GDK_KEY_Cyrillic_che" type="int" value="1758"/>
		<constant name="GDK_KEY_Cyrillic_che_descender" type="int" value="16778423"/>
		<constant name="GDK_KEY_Cyrillic_che_vertstroke" type="int" value="16778425"/>
		<constant name="GDK_KEY_Cyrillic_de" type="int" value="1732"/>
		<constant name="GDK_KEY_Cyrillic_dzhe" type="int" value="1711"/>
		<constant name="GDK_KEY_Cyrillic_e" type="int" value="1756"/>
		<constant name="GDK_KEY_Cyrillic_ef" type="int" value="1734"/>
		<constant name="GDK_KEY_Cyrillic_el" type="int" value="1740"/>
		<constant name="GDK_KEY_Cyrillic_em" type="int" value="1741"/>
		<constant name="GDK_KEY_Cyrillic_en" type="int" value="1742"/>
		<constant name="GDK_KEY_Cyrillic_en_descender" type="int" value="16778403"/>
		<constant name="GDK_KEY_Cyrillic_er" type="int" value="1746"/>
		<constant name="GDK_KEY_Cyrillic_es" type="int" value="1747"/>
		<constant name="GDK_KEY_Cyrillic_ghe" type="int" value="1735"/>
		<constant name="GDK_KEY_Cyrillic_ghe_bar" type="int" value="16778387"/>
		<constant name="GDK_KEY_Cyrillic_ha" type="int" value="1736"/>
		<constant name="GDK_KEY_Cyrillic_ha_descender" type="int" value="16778419"/>
		<constant name="GDK_KEY_Cyrillic_hardsign" type="int" value="1759"/>
		<constant name="GDK_KEY_Cyrillic_i" type="int" value="1737"/>
		<constant name="GDK_KEY_Cyrillic_i_macron" type="int" value="16778467"/>
		<constant name="GDK_KEY_Cyrillic_ie" type="int" value="1733"/>
		<constant name="GDK_KEY_Cyrillic_io" type="int" value="1699"/>
		<constant name="GDK_KEY_Cyrillic_je" type="int" value="1704"/>
		<constant name="GDK_KEY_Cyrillic_ka" type="int" value="1739"/>
		<constant name="GDK_KEY_Cyrillic_ka_descender" type="int" value="16778395"/>
		<constant name="GDK_KEY_Cyrillic_ka_vertstroke" type="int" value="16778397"/>
		<constant name="GDK_KEY_Cyrillic_lje" type="int" value="1705"/>
		<constant name="GDK_KEY_Cyrillic_nje" type="int" value="1706"/>
		<constant name="GDK_KEY_Cyrillic_o" type="int" value="1743"/>
		<constant name="GDK_KEY_Cyrillic_o_bar" type="int" value="16778473"/>
		<constant name="GDK_KEY_Cyrillic_pe" type="int" value="1744"/>
		<constant name="GDK_KEY_Cyrillic_schwa" type="int" value="16778457"/>
		<constant name="GDK_KEY_Cyrillic_sha" type="int" value="1755"/>
		<constant name="GDK_KEY_Cyrillic_shcha" type="int" value="1757"/>
		<constant name="GDK_KEY_Cyrillic_shha" type="int" value="16778427"/>
		<constant name="GDK_KEY_Cyrillic_shorti" type="int" value="1738"/>
		<constant name="GDK_KEY_Cyrillic_softsign" type="int" value="1752"/>
		<constant name="GDK_KEY_Cyrillic_te" type="int" value="1748"/>
		<constant name="GDK_KEY_Cyrillic_tse" type="int" value="1731"/>
		<constant name="GDK_KEY_Cyrillic_u" type="int" value="1749"/>
		<constant name="GDK_KEY_Cyrillic_u_macron" type="int" value="16778479"/>
		<constant name="GDK_KEY_Cyrillic_u_straight" type="int" value="16778415"/>
		<constant name="GDK_KEY_Cyrillic_u_straight_bar" type="int" value="16778417"/>
		<constant name="GDK_KEY_Cyrillic_ve" type="int" value="1751"/>
		<constant name="GDK_KEY_Cyrillic_ya" type="int" value="1745"/>
		<constant name="GDK_KEY_Cyrillic_yeru" type="int" value="1753"/>
		<constant name="GDK_KEY_Cyrillic_yu" type="int" value="1728"/>
		<constant name="GDK_KEY_Cyrillic_ze" type="int" value="1754"/>
		<constant name="GDK_KEY_Cyrillic_zhe" type="int" value="1750"/>
		<constant name="GDK_KEY_Cyrillic_zhe_descender" type="int" value="16778391"/>
		<constant name="GDK_KEY_D" type="int" value="68"/>
		<constant name="GDK_KEY_DOS" type="int" value="269025114"/>
		<constant name="GDK_KEY_Dabovedot" type="int" value="16784906"/>
		<constant name="GDK_KEY_Dcaron" type="int" value="463"/>
		<constant name="GDK_KEY_Delete" type="int" value="65535"/>
		<constant name="GDK_KEY_Display" type="int" value="269025113"/>
		<constant name="GDK_KEY_Documents" type="int" value="269025115"/>
		<constant name="GDK_KEY_DongSign" type="int" value="16785579"/>
		<constant name="GDK_KEY_Down" type="int" value="65364"/>
		<constant name="GDK_KEY_Dstroke" type="int" value="464"/>
		<constant name="GDK_KEY_E" type="int" value="69"/>
		<constant name="GDK_KEY_ENG" type="int" value="957"/>
		<constant name="GDK_KEY_ETH" type="int" value="208"/>
		<constant name="GDK_KEY_Eabovedot" type="int" value="972"/>
		<constant name="GDK_KEY_Eacute" type="int" value="201"/>
		<constant name="GDK_KEY_Ebelowdot" type="int" value="16785080"/>
		<constant name="GDK_KEY_Ecaron" type="int" value="460"/>
		<constant name="GDK_KEY_Ecircumflex" type="int" value="202"/>
		<constant name="GDK_KEY_Ecircumflexacute" type="int" value="16785086"/>
		<constant name="GDK_KEY_Ecircumflexbelowdot" type="int" value="16785094"/>
		<constant name="GDK_KEY_Ecircumflexgrave" type="int" value="16785088"/>
		<constant name="GDK_KEY_Ecircumflexhook" type="int" value="16785090"/>
		<constant name="GDK_KEY_Ecircumflextilde" type="int" value="16785092"/>
		<constant name="GDK_KEY_EcuSign" type="int" value="16785568"/>
		<constant name="GDK_KEY_Ediaeresis" type="int" value="203"/>
		<constant name="GDK_KEY_Egrave" type="int" value="200"/>
		<constant name="GDK_KEY_Ehook" type="int" value="16785082"/>
		<constant name="GDK_KEY_Eisu_Shift" type="int" value="65327"/>
		<constant name="GDK_KEY_Eisu_toggle" type="int" value="65328"/>
		<constant name="GDK_KEY_Eject" type="int" value="269025068"/>
		<constant name="GDK_KEY_Emacron" type="int" value="938"/>
		<constant name="GDK_KEY_End" type="int" value="65367"/>
		<constant name="GDK_KEY_Eogonek" type="int" value="458"/>
		<constant name="GDK_KEY_Escape" type="int" value="65307"/>
		<constant name="GDK_KEY_Eth" type="int" value="208"/>
		<constant name="GDK_KEY_Etilde" type="int" value="16785084"/>
		<constant name="GDK_KEY_EuroSign" type="int" value="8364"/>
		<constant name="GDK_KEY_Excel" type="int" value="269025116"/>
		<constant name="GDK_KEY_Execute" type="int" value="65378"/>
		<constant name="GDK_KEY_Explorer" type="int" value="269025117"/>
		<constant name="GDK_KEY_F" type="int" value="70"/>
		<constant name="GDK_KEY_F1" type="int" value="65470"/>
		<constant name="GDK_KEY_F10" type="int" value="65479"/>
		<constant name="GDK_KEY_F11" type="int" value="65480"/>
		<constant name="GDK_KEY_F12" type="int" value="65481"/>
		<constant name="GDK_KEY_F13" type="int" value="65482"/>
		<constant name="GDK_KEY_F14" type="int" value="65483"/>
		<constant name="GDK_KEY_F15" type="int" value="65484"/>
		<constant name="GDK_KEY_F16" type="int" value="65485"/>
		<constant name="GDK_KEY_F17" type="int" value="65486"/>
		<constant name="GDK_KEY_F18" type="int" value="65487"/>
		<constant name="GDK_KEY_F19" type="int" value="65488"/>
		<constant name="GDK_KEY_F2" type="int" value="65471"/>
		<constant name="GDK_KEY_F20" type="int" value="65489"/>
		<constant name="GDK_KEY_F21" type="int" value="65490"/>
		<constant name="GDK_KEY_F22" type="int" value="65491"/>
		<constant name="GDK_KEY_F23" type="int" value="65492"/>
		<constant name="GDK_KEY_F24" type="int" value="65493"/>
		<constant name="GDK_KEY_F25" type="int" value="65494"/>
		<constant name="GDK_KEY_F26" type="int" value="65495"/>
		<constant name="GDK_KEY_F27" type="int" value="65496"/>
		<constant name="GDK_KEY_F28" type="int" value="65497"/>
		<constant name="GDK_KEY_F29" type="int" value="65498"/>
		<constant name="GDK_KEY_F3" type="int" value="65472"/>
		<constant name="GDK_KEY_F30" type="int" value="65499"/>
		<constant name="GDK_KEY_F31" type="int" value="65500"/>
		<constant name="GDK_KEY_F32" type="int" value="65501"/>
		<constant name="GDK_KEY_F33" type="int" value="65502"/>
		<constant name="GDK_KEY_F34" type="int" value="65503"/>
		<constant name="GDK_KEY_F35" type="int" value="65504"/>
		<constant name="GDK_KEY_F4" type="int" value="65473"/>
		<constant name="GDK_KEY_F5" type="int" value="65474"/>
		<constant name="GDK_KEY_F6" type="int" value="65475"/>
		<constant name="GDK_KEY_F7" type="int" value="65476"/>
		<constant name="GDK_KEY_F8" type="int" value="65477"/>
		<constant name="GDK_KEY_F9" type="int" value="65478"/>
		<constant name="GDK_KEY_FFrancSign" type="int" value="16785571"/>
		<constant name="GDK_KEY_Fabovedot" type="int" value="16784926"/>
		<constant name="GDK_KEY_Farsi_0" type="int" value="16778992"/>
		<constant name="GDK_KEY_Farsi_1" type="int" value="16778993"/>
		<constant name="GDK_KEY_Farsi_2" type="int" value="16778994"/>
		<constant name="GDK_KEY_Farsi_3" type="int" value="16778995"/>
		<constant name="GDK_KEY_Farsi_4" type="int" value="16778996"/>
		<constant name="GDK_KEY_Farsi_5" type="int" value="16778997"/>
		<constant name="GDK_KEY_Farsi_6" type="int" value="16778998"/>
		<constant name="GDK_KEY_Farsi_7" type="int" value="16778999"/>
		<constant name="GDK_KEY_Farsi_8" type="int" value="16779000"/>
		<constant name="GDK_KEY_Farsi_9" type="int" value="16779001"/>
		<constant name="GDK_KEY_Farsi_yeh" type="int" value="16778956"/>
		<constant name="GDK_KEY_Favorites" type="int" value="269025072"/>
		<constant name="GDK_KEY_Finance" type="int" value="269025084"/>
		<constant name="GDK_KEY_Find" type="int" value="65384"/>
		<constant name="GDK_KEY_First_Virtual_Screen" type="int" value="65232"/>
		<constant name="GDK_KEY_Forward" type="int" value="269025063"/>
		<constant name="GDK_KEY_FrameBack" type="int" value="269025181"/>
		<constant name="GDK_KEY_FrameForward" type="int" value="269025182"/>
		<constant name="GDK_KEY_G" type="int" value="71"/>
		<constant name="GDK_KEY_Gabovedot" type="int" value="725"/>
		<constant name="GDK_KEY_Game" type="int" value="269025118"/>
		<constant name="GDK_KEY_Gbreve" type="int" value="683"/>
		<constant name="GDK_KEY_Gcaron" type="int" value="16777702"/>
		<constant name="GDK_KEY_Gcedilla" type="int" value="939"/>
		<constant name="GDK_KEY_Gcircumflex" type="int" value="728"/>
		<constant name="GDK_KEY_Georgian_an" type="int" value="16781520"/>
		<constant name="GDK_KEY_Georgian_ban" type="int" value="16781521"/>
		<constant name="GDK_KEY_Georgian_can" type="int" value="16781546"/>
		<constant name="GDK_KEY_Georgian_char" type="int" value="16781549"/>
		<constant name="GDK_KEY_Georgian_chin" type="int" value="16781545"/>
		<constant name="GDK_KEY_Georgian_cil" type="int" value="16781548"/>
		<constant name="GDK_KEY_Georgian_don" type="int" value="16781523"/>
		<constant name="GDK_KEY_Georgian_en" type="int" value="16781524"/>
		<constant name="GDK_KEY_Georgian_fi" type="int" value="16781558"/>
		<constant name="GDK_KEY_Georgian_gan" type="int" value="16781522"/>
		<constant name="GDK_KEY_Georgian_ghan" type="int" value="16781542"/>
		<constant name="GDK_KEY_Georgian_hae" type="int" value="16781552"/>
		<constant name="GDK_KEY_Georgian_har" type="int" value="16781556"/>
		<constant name="GDK_KEY_Georgian_he" type="int" value="16781553"/>
		<constant name="GDK_KEY_Georgian_hie" type="int" value="16781554"/>
		<constant name="GDK_KEY_Georgian_hoe" type="int" value="16781557"/>
		<constant name="GDK_KEY_Georgian_in" type="int" value="16781528"/>
		<constant name="GDK_KEY_Georgian_jhan" type="int" value="16781551"/>
		<constant name="GDK_KEY_Georgian_jil" type="int" value="16781547"/>
		<constant name="GDK_KEY_Georgian_kan" type="int" value="16781529"/>
		<constant name="GDK_KEY_Georgian_khar" type="int" value="16781541"/>
		<constant name="GDK_KEY_Georgian_las" type="int" value="16781530"/>
		<constant name="GDK_KEY_Georgian_man" type="int" value="16781531"/>
		<constant name="GDK_KEY_Georgian_nar" type="int" value="16781532"/>
		<constant name="GDK_KEY_Georgian_on" type="int" value="16781533"/>
		<constant name="GDK_KEY_Georgian_par" type="int" value="16781534"/>
		<constant name="GDK_KEY_Georgian_phar" type="int" value="16781540"/>
		<constant name="GDK_KEY_Georgian_qar" type="int" value="16781543"/>
		<constant name="GDK_KEY_Georgian_rae" type="int" value="16781536"/>
		<constant name="GDK_KEY_Georgian_san" type="int" value="16781537"/>
		<constant name="GDK_KEY_Georgian_shin" type="int" value="16781544"/>
		<constant name="GDK_KEY_Georgian_tan" type="int" value="16781527"/>
		<constant name="GDK_KEY_Georgian_tar" type="int" value="16781538"/>
		<constant name="GDK_KEY_Georgian_un" type="int" value="16781539"/>
		<constant name="GDK_KEY_Georgian_vin" type="int" value="16781525"/>
		<constant name="GDK_KEY_Georgian_we" type="int" value="16781555"/>
		<constant name="GDK_KEY_Georgian_xan" type="int" value="16781550"/>
		<constant name="GDK_KEY_Georgian_zen" type="int" value="16781526"/>
		<constant name="GDK_KEY_Georgian_zhar" type="int" value="16781535"/>
		<constant name="GDK_KEY_Go" type="int" value="269025119"/>
		<constant name="GDK_KEY_Greek_ALPHA" type="int" value="1985"/>
		<constant name="GDK_KEY_Greek_ALPHAaccent" type="int" value="1953"/>
		<constant name="GDK_KEY_Greek_BETA" type="int" value="1986"/>
		<constant name="GDK_KEY_Greek_CHI" type="int" value="2007"/>
		<constant name="GDK_KEY_Greek_DELTA" type="int" value="1988"/>
		<constant name="GDK_KEY_Greek_EPSILON" type="int" value="1989"/>
		<constant name="GDK_KEY_Greek_EPSILONaccent" type="int" value="1954"/>
		<constant name="GDK_KEY_Greek_ETA" type="int" value="1991"/>
		<constant name="GDK_KEY_Greek_ETAaccent" type="int" value="1955"/>
		<constant name="GDK_KEY_Greek_GAMMA" type="int" value="1987"/>
		<constant name="GDK_KEY_Greek_IOTA" type="int" value="1993"/>
		<constant name="GDK_KEY_Greek_IOTAaccent" type="int" value="1956"/>
		<constant name="GDK_KEY_Greek_IOTAdiaeresis" type="int" value="1957"/>
		<constant name="GDK_KEY_Greek_IOTAdieresis" type="int" value="1957"/>
		<constant name="GDK_KEY_Greek_KAPPA" type="int" value="1994"/>
		<constant name="GDK_KEY_Greek_LAMBDA" type="int" value="1995"/>
		<constant name="GDK_KEY_Greek_LAMDA" type="int" value="1995"/>
		<constant name="GDK_KEY_Greek_MU" type="int" value="1996"/>
		<constant name="GDK_KEY_Greek_NU" type="int" value="1997"/>
		<constant name="GDK_KEY_Greek_OMEGA" type="int" value="2009"/>
		<constant name="GDK_KEY_Greek_OMEGAaccent" type="int" value="1963"/>
		<constant name="GDK_KEY_Greek_OMICRON" type="int" value="1999"/>
		<constant name="GDK_KEY_Greek_OMICRONaccent" type="int" value="1959"/>
		<constant name="GDK_KEY_Greek_PHI" type="int" value="2006"/>
		<constant name="GDK_KEY_Greek_PI" type="int" value="2000"/>
		<constant name="GDK_KEY_Greek_PSI" type="int" value="2008"/>
		<constant name="GDK_KEY_Greek_RHO" type="int" value="2001"/>
		<constant name="GDK_KEY_Greek_SIGMA" type="int" value="2002"/>
		<constant name="GDK_KEY_Greek_TAU" type="int" value="2004"/>
		<constant name="GDK_KEY_Greek_THETA" type="int" value="1992"/>
		<constant name="GDK_KEY_Greek_UPSILON" type="int" value="2005"/>
		<constant name="GDK_KEY_Greek_UPSILONaccent" type="int" value="1960"/>
		<constant name="GDK_KEY_Greek_UPSILONdieresis" type="int" value="1961"/>
		<constant name="GDK_KEY_Greek_XI" type="int" value="1998"/>
		<constant name="GDK_KEY_Greek_ZETA" type="int" value="1990"/>
		<constant name="GDK_KEY_Greek_accentdieresis" type="int" value="1966"/>
		<constant name="GDK_KEY_Greek_alpha" type="int" value="2017"/>
		<constant name="GDK_KEY_Greek_alphaaccent" type="int" value="1969"/>
		<constant name="GDK_KEY_Greek_beta" type="int" value="2018"/>
		<constant name="GDK_KEY_Greek_chi" type="int" value="2039"/>
		<constant name="GDK_KEY_Greek_delta" type="int" value="2020"/>
		<constant name="GDK_KEY_Greek_epsilon" type="int" value="2021"/>
		<constant name="GDK_KEY_Greek_epsilonaccent" type="int" value="1970"/>
		<constant name="GDK_KEY_Greek_eta" type="int" value="2023"/>
		<constant name="GDK_KEY_Greek_etaaccent" type="int" value="1971"/>
		<constant name="GDK_KEY_Greek_finalsmallsigma" type="int" value="2035"/>
		<constant name="GDK_KEY_Greek_gamma" type="int" value="2019"/>
		<constant name="GDK_KEY_Greek_horizbar" type="int" value="1967"/>
		<constant name="GDK_KEY_Greek_iota" type="int" value="2025"/>
		<constant name="GDK_KEY_Greek_iotaaccent" type="int" value="1972"/>
		<constant name="GDK_KEY_Greek_iotaaccentdieresis" type="int" value="1974"/>
		<constant name="GDK_KEY_Greek_iotadieresis" type="int" value="1973"/>
		<constant name="GDK_KEY_Greek_kappa" type="int" value="2026"/>
		<constant name="GDK_KEY_Greek_lambda" type="int" value="2027"/>
		<constant name="GDK_KEY_Greek_lamda" type="int" value="2027"/>
		<constant name="GDK_KEY_Greek_mu" type="int" value="2028"/>
		<constant name="GDK_KEY_Greek_nu" type="int" value="2029"/>
		<constant name="GDK_KEY_Greek_omega" type="int" value="2041"/>
		<constant name="GDK_KEY_Greek_omegaaccent" type="int" value="1979"/>
		<constant name="GDK_KEY_Greek_omicron" type="int" value="2031"/>
		<constant name="GDK_KEY_Greek_omicronaccent" type="int" value="1975"/>
		<constant name="GDK_KEY_Greek_phi" type="int" value="2038"/>
		<constant name="GDK_KEY_Greek_pi" type="int" value="2032"/>
		<constant name="GDK_KEY_Greek_psi" type="int" value="2040"/>
		<constant name="GDK_KEY_Greek_rho" type="int" value="2033"/>
		<constant name="GDK_KEY_Greek_sigma" type="int" value="2034"/>
		<constant name="GDK_KEY_Greek_switch" type="int" value="65406"/>
		<constant name="GDK_KEY_Greek_tau" type="int" value="2036"/>
		<constant name="GDK_KEY_Greek_theta" type="int" value="2024"/>
		<constant name="GDK_KEY_Greek_upsilon" type="int" value="2037"/>
		<constant name="GDK_KEY_Greek_upsilonaccent" type="int" value="1976"/>
		<constant name="GDK_KEY_Greek_upsilonaccentdieresis" type="int" value="1978"/>
		<constant name="GDK_KEY_Greek_upsilondieresis" type="int" value="1977"/>
		<constant name="GDK_KEY_Greek_xi" type="int" value="2030"/>
		<constant name="GDK_KEY_Greek_zeta" type="int" value="2022"/>
		<constant name="GDK_KEY_Green" type="int" value="269025188"/>
		<constant name="GDK_KEY_H" type="int" value="72"/>
		<constant name="GDK_KEY_Hangul" type="int" value="65329"/>
		<constant name="GDK_KEY_Hangul_A" type="int" value="3775"/>
		<constant name="GDK_KEY_Hangul_AE" type="int" value="3776"/>
		<constant name="GDK_KEY_Hangul_AraeA" type="int" value="3830"/>
		<constant name="GDK_KEY_Hangul_AraeAE" type="int" value="3831"/>
		<constant name="GDK_KEY_Hangul_Banja" type="int" value="65337"/>
		<constant name="GDK_KEY_Hangul_Cieuc" type="int" value="3770"/>
		<constant name="GDK_KEY_Hangul_Codeinput" type="int" value="65335"/>
		<constant name="GDK_KEY_Hangul_Dikeud" type="int" value="3751"/>
		<constant name="GDK_KEY_Hangul_E" type="int" value="3780"/>
		<constant name="GDK_KEY_Hangul_EO" type="int" value="3779"/>
		<constant name="GDK_KEY_Hangul_EU" type="int" value="3793"/>
		<constant name="GDK_KEY_Hangul_End" type="int" value="65331"/>
		<constant name="GDK_KEY_Hangul_Hanja" type="int" value="65332"/>
		<constant name="GDK_KEY_Hangul_Hieuh" type="int" value="3774"/>
		<constant name="GDK_KEY_Hangul_I" type="int" value="3795"/>
		<constant name="GDK_KEY_Hangul_Ieung" type="int" value="3767"/>
		<constant name="GDK_KEY_Hangul_J_Cieuc" type="int" value="3818"/>
		<constant name="GDK_KEY_Hangul_J_Dikeud" type="int" value="3802"/>
		<constant name="GDK_KEY_Hangul_J_Hieuh" type="int" value="3822"/>
		<constant name="GDK_KEY_Hangul_J_Ieung" type="int" value="3816"/>
		<constant name="GDK_KEY_Hangul_J_Jieuj" type="int" value="3817"/>
		<constant name="GDK_KEY_Hangul_J_Khieuq" type="int" value="3819"/>
		<constant name="GDK_KEY_Hangul_J_Kiyeog" type="int" value="3796"/>
		<constant name="GDK_KEY_Hangul_J_KiyeogSios" type="int" value="3798"/>
		<constant name="GDK_KEY_Hangul_J_KkogjiDalrinIeung" type="int" value="3833"/>
		<constant name="GDK_KEY_Hangul_J_Mieum" type="int" value="3811"/>
		<constant name="GDK_KEY_Hangul_J_Nieun" type="int" value="3799"/>
		<constant name="GDK_KEY_Hangul_J_NieunHieuh" type="int" value="3801"/>
		<constant name="GDK_KEY_Hangul_J_NieunJieuj" type="int" value="3800"/>
		<constant name="GDK_KEY_Hangul_J_PanSios" type="int" value="3832"/>
		<constant name="GDK_KEY_Hangul_J_Phieuf" type="int" value="3821"/>
		<constant name="GDK_KEY_Hangul_J_Pieub" type="int" value="3812"/>
		<constant name="GDK_KEY_Hangul_J_PieubSios" type="int" value="3813"/>
		<constant name="GDK_KEY_Hangul_J_Rieul" type="int" value="3803"/>
		<constant name="GDK_KEY_Hangul_J_RieulHieuh" type="int" value="3810"/>
		<constant name="GDK_KEY_Hangul_J_RieulKiyeog" type="int" value="3804"/>
		<constant name="GDK_KEY_Hangul_J_RieulMieum" type="int" value="3805"/>
		<constant name="GDK_KEY_Hangul_J_RieulPhieuf" type="int" value="3809"/>
		<constant name="GDK_KEY_Hangul_J_RieulPieub" type="int" value="3806"/>
		<constant name="GDK_KEY_Hangul_J_RieulSios" type="int" value="3807"/>
		<constant name="GDK_KEY_Hangul_J_RieulTieut" type="int" value="3808"/>
		<constant name="GDK_KEY_Hangul_J_Sios" type="int" value="3814"/>
		<constant name="GDK_KEY_Hangul_J_SsangKiyeog" type="int" value="3797"/>
		<constant name="GDK_KEY_Hangul_J_SsangSios" type="int" value="3815"/>
		<constant name="GDK_KEY_Hangul_J_Tieut" type="int" value="3820"/>
		<constant name="GDK_KEY_Hangul_J_YeorinHieuh" type="int" value="3834"/>
		<constant name="GDK_KEY_Hangul_Jamo" type="int" value="65333"/>
		<constant name="GDK_KEY_Hangul_Jeonja" type="int" value="65336"/>
		<constant name="GDK_KEY_Hangul_Jieuj" type="int" value="3768"/>
		<constant name="GDK_KEY_Hangul_Khieuq" type="int" value="3771"/>
		<constant name="GDK_KEY_Hangul_Kiyeog" type="int" value="3745"/>
		<constant name="GDK_KEY_Hangul_KiyeogSios" type="int" value="3747"/>
		<constant name="GDK_KEY_Hangul_KkogjiDalrinIeung" type="int" value="3827"/>
		<constant name="GDK_KEY_Hangul_Mieum" type="int" value="3761"/>
		<constant name="GDK_KEY_Hangul_MultipleCandidate" type="int" value="65341"/>
		<constant name="GDK_KEY_Hangul_Nieun" type="int" value="3748"/>
		<constant name="GDK_KEY_Hangul_NieunHieuh" type="int" value="3750"/>
		<constant name="GDK_KEY_Hangul_NieunJieuj" type="int" value="3749"/>
		<constant name="GDK_KEY_Hangul_O" type="int" value="3783"/>
		<constant name="GDK_KEY_Hangul_OE" type="int" value="3786"/>
		<constant name="GDK_KEY_Hangul_PanSios" type="int" value="3826"/>
		<constant name="GDK_KEY_Hangul_Phieuf" type="int" value="3773"/>
		<constant name="GDK_KEY_Hangul_Pieub" type="int" value="3762"/>
		<constant name="GDK_KEY_Hangul_PieubSios" type="int" value="3764"/>
		<constant name="GDK_KEY_Hangul_PostHanja" type="int" value="65339"/>
		<constant name="GDK_KEY_Hangul_PreHanja" type="int" value="65338"/>
		<constant name="GDK_KEY_Hangul_PreviousCandidate" type="int" value="65342"/>
		<constant name="GDK_KEY_Hangul_Rieul" type="int" value="3753"/>
		<constant name="GDK_KEY_Hangul_RieulHieuh" type="int" value="3760"/>
		<constant name="GDK_KEY_Hangul_RieulKiyeog" type="int" value="3754"/>
		<constant name="GDK_KEY_Hangul_RieulMieum" type="int" value="3755"/>
		<constant name="GDK_KEY_Hangul_RieulPhieuf" type="int" value="3759"/>
		<constant name="GDK_KEY_Hangul_RieulPieub" type="int" value="3756"/>
		<constant name="GDK_KEY_Hangul_RieulSios" type="int" value="3757"/>
		<constant name="GDK_KEY_Hangul_RieulTieut" type="int" value="3758"/>
		<constant name="GDK_KEY_Hangul_RieulYeorinHieuh" type="int" value="3823"/>
		<constant name="GDK_KEY_Hangul_Romaja" type="int" value="65334"/>
		<constant name="GDK_KEY_Hangul_SingleCandidate" type="int" value="65340"/>
		<constant name="GDK_KEY_Hangul_Sios" type="int" value="3765"/>
		<constant name="GDK_KEY_Hangul_Special" type="int" value="65343"/>
		<constant name="GDK_KEY_Hangul_SsangDikeud" type="int" value="3752"/>
		<constant name="GDK_KEY_Hangul_SsangJieuj" type="int" value="3769"/>
		<constant name="GDK_KEY_Hangul_SsangKiyeog" type="int" value="3746"/>
		<constant name="GDK_KEY_Hangul_SsangPieub" type="int" value="3763"/>
		<constant name="GDK_KEY_Hangul_SsangSios" type="int" value="3766"/>
		<constant name="GDK_KEY_Hangul_Start" type="int" value="65330"/>
		<constant name="GDK_KEY_Hangul_SunkyeongeumMieum" type="int" value="3824"/>
		<constant name="GDK_KEY_Hangul_SunkyeongeumPhieuf" type="int" value="3828"/>
		<constant name="GDK_KEY_Hangul_SunkyeongeumPieub" type="int" value="3825"/>
		<constant name="GDK_KEY_Hangul_Tieut" type="int" value="3772"/>
		<constant name="GDK_KEY_Hangul_U" type="int" value="3788"/>
		<constant name="GDK_KEY_Hangul_WA" type="int" value="3784"/>
		<constant name="GDK_KEY_Hangul_WAE" type="int" value="3785"/>
		<constant name="GDK_KEY_Hangul_WE" type="int" value="3790"/>
		<constant name="GDK_KEY_Hangul_WEO" type="int" value="3789"/>
		<constant name="GDK_KEY_Hangul_WI" type="int" value="3791"/>
		<constant name="GDK_KEY_Hangul_YA" type="int" value="3777"/>
		<constant name="GDK_KEY_Hangul_YAE" type="int" value="3778"/>
		<constant name="GDK_KEY_Hangul_YE" type="int" value="3782"/>
		<constant name="GDK_KEY_Hangul_YEO" type="int" value="3781"/>
		<constant name="GDK_KEY_Hangul_YI" type="int" value="3794"/>
		<constant name="GDK_KEY_Hangul_YO" type="int" value="3787"/>
		<constant name="GDK_KEY_Hangul_YU" type="int" value="3792"/>
		<constant name="GDK_KEY_Hangul_YeorinHieuh" type="int" value="3829"/>
		<constant name="GDK_KEY_Hangul_switch" type="int" value="65406"/>
		<constant name="GDK_KEY_Hankaku" type="int" value="65321"/>
		<constant name="GDK_KEY_Hcircumflex" type="int" value="678"/>
		<constant name="GDK_KEY_Hebrew_switch" type="int" value="65406"/>
		<constant name="GDK_KEY_Help" type="int" value="65386"/>
		<constant name="GDK_KEY_Henkan" type="int" value="65315"/>
		<constant name="GDK_KEY_Henkan_Mode" type="int" value="65315"/>
		<constant name="GDK_KEY_Hibernate" type="int" value="269025192"/>
		<constant name="GDK_KEY_Hiragana" type="int" value="65317"/>
		<constant name="GDK_KEY_Hiragana_Katakana" type="int" value="65319"/>
		<constant name="GDK_KEY_History" type="int" value="269025079"/>
		<constant name="GDK_KEY_Home" type="int" value="65360"/>
		<constant name="GDK_KEY_HomePage" type="int" value="269025048"/>
		<constant name="GDK_KEY_HotLinks" type="int" value="269025082"/>
		<constant name="GDK_KEY_Hstroke" type="int" value="673"/>
		<constant name="GDK_KEY_Hyper_L" type="int" value="65517"/>
		<constant name="GDK_KEY_Hyper_R" type="int" value="65518"/>
		<constant name="GDK_KEY_I" type="int" value="73"/>
		<constant name="GDK_KEY_ISO_Center_Object" type="int" value="65075"/>
		<constant name="GDK_KEY_ISO_Continuous_Underline" type="int" value="65072"/>
		<constant name="GDK_KEY_ISO_Discontinuous_Underline" type="int" value="65073"/>
		<constant name="GDK_KEY_ISO_Emphasize" type="int" value="65074"/>
		<constant name="GDK_KEY_ISO_Enter" type="int" value="65076"/>
		<constant name="GDK_KEY_ISO_Fast_Cursor_Down" type="int" value="65071"/>
		<constant name="GDK_KEY_ISO_Fast_Cursor_Left" type="int" value="65068"/>
		<constant name="GDK_KEY_ISO_Fast_Cursor_Right" type="int" value="65069"/>
		<constant name="GDK_KEY_ISO_Fast_Cursor_Up" type="int" value="65070"/>
		<constant name="GDK_KEY_ISO_First_Group" type="int" value="65036"/>
		<constant name="GDK_KEY_ISO_First_Group_Lock" type="int" value="65037"/>
		<constant name="GDK_KEY_ISO_Group_Latch" type="int" value="65030"/>
		<constant name="GDK_KEY_ISO_Group_Lock" type="int" value="65031"/>
		<constant name="GDK_KEY_ISO_Group_Shift" type="int" value="65406"/>
		<constant name="GDK_KEY_ISO_Last_Group" type="int" value="65038"/>
		<constant name="GDK_KEY_ISO_Last_Group_Lock" type="int" value="65039"/>
		<constant name="GDK_KEY_ISO_Left_Tab" type="int" value="65056"/>
		<constant name="GDK_KEY_ISO_Level2_Latch" type="int" value="65026"/>
		<constant name="GDK_KEY_ISO_Level3_Latch" type="int" value="65028"/>
		<constant name="GDK_KEY_ISO_Level3_Lock" type="int" value="65029"/>
		<constant name="GDK_KEY_ISO_Level3_Shift" type="int" value="65027"/>
		<constant name="GDK_KEY_ISO_Level5_Latch" type="int" value="65042"/>
		<constant name="GDK_KEY_ISO_Level5_Lock" type="int" value="65043"/>
		<constant name="GDK_KEY_ISO_Level5_Shift" type="int" value="65041"/>
		<constant name="GDK_KEY_ISO_Lock" type="int" value="65025"/>
		<constant name="GDK_KEY_ISO_Move_Line_Down" type="int" value="65058"/>
		<constant name="GDK_KEY_ISO_Move_Line_Up" type="int" value="65057"/>
		<constant name="GDK_KEY_ISO_Next_Group" type="int" value="65032"/>
		<constant name="GDK_KEY_ISO_Next_Group_Lock" type="int" value="65033"/>
		<constant name="GDK_KEY_ISO_Partial_Line_Down" type="int" value="65060"/>
		<constant name="GDK_KEY_ISO_Partial_Line_Up" type="int" value="65059"/>
		<constant name="GDK_KEY_ISO_Partial_Space_Left" type="int" value="65061"/>
		<constant name="GDK_KEY_ISO_Partial_Space_Right" type="int" value="65062"/>
		<constant name="GDK_KEY_ISO_Prev_Group" type="int" value="65034"/>
		<constant name="GDK_KEY_ISO_Prev_Group_Lock" type="int" value="65035"/>
		<constant name="GDK_KEY_ISO_Release_Both_Margins" type="int" value="65067"/>
		<constant name="GDK_KEY_ISO_Release_Margin_Left" type="int" value="65065"/>
		<constant name="GDK_KEY_ISO_Release_Margin_Right" type="int" value="65066"/>
		<constant name="GDK_KEY_ISO_Set_Margin_Left" type="int" value="65063"/>
		<constant name="GDK_KEY_ISO_Set_Margin_Right" type="int" value="65064"/>
		<constant name="GDK_KEY_Iabovedot" type="int" value="681"/>
		<constant name="GDK_KEY_Iacute" type="int" value="205"/>
		<constant name="GDK_KEY_Ibelowdot" type="int" value="16785098"/>
		<constant name="GDK_KEY_Ibreve" type="int" value="16777516"/>
		<constant name="GDK_KEY_Icircumflex" type="int" value="206"/>
		<constant name="GDK_KEY_Idiaeresis" type="int" value="207"/>
		<constant name="GDK_KEY_Igrave" type="int" value="204"/>
		<constant name="GDK_KEY_Ihook" type="int" value="16785096"/>
		<constant name="GDK_KEY_Imacron" type="int" value="975"/>
		<constant name="GDK_KEY_Insert" type="int" value="65379"/>
		<constant name="GDK_KEY_Iogonek" type="int" value="967"/>
		<constant name="GDK_KEY_Itilde" type="int" value="933"/>
		<constant name="GDK_KEY_J" type="int" value="74"/>
		<constant name="GDK_KEY_Jcircumflex" type="int" value="684"/>
		<constant name="GDK_KEY_K" type="int" value="75"/>
		<constant name="GDK_KEY_KP_0" type="int" value="65456"/>
		<constant name="GDK_KEY_KP_1" type="int" value="65457"/>
		<constant name="GDK_KEY_KP_2" type="int" value="65458"/>
		<constant name="GDK_KEY_KP_3" type="int" value="65459"/>
		<constant name="GDK_KEY_KP_4" type="int" value="65460"/>
		<constant name="GDK_KEY_KP_5" type="int" value="65461"/>
		<constant name="GDK_KEY_KP_6" type="int" value="65462"/>
		<constant name="GDK_KEY_KP_7" type="int" value="65463"/>
		<constant name="GDK_KEY_KP_8" type="int" value="65464"/>
		<constant name="GDK_KEY_KP_9" type="int" value="65465"/>
		<constant name="GDK_KEY_KP_Add" type="int" value="65451"/>
		<constant name="GDK_KEY_KP_Begin" type="int" value="65437"/>
		<constant name="GDK_KEY_KP_Decimal" type="int" value="65454"/>
		<constant name="GDK_KEY_KP_Delete" type="int" value="65439"/>
		<constant name="GDK_KEY_KP_Divide" type="int" value="65455"/>
		<constant name="GDK_KEY_KP_Down" type="int" value="65433"/>
		<constant name="GDK_KEY_KP_End" type="int" value="65436"/>
		<constant name="GDK_KEY_KP_Enter" type="int" value="65421"/>
		<constant name="GDK_KEY_KP_Equal" type="int" value="65469"/>
		<constant name="GDK_KEY_KP_F1" type="int" value="65425"/>
		<constant name="GDK_KEY_KP_F2" type="int" value="65426"/>
		<constant name="GDK_KEY_KP_F3" type="int" value="65427"/>
		<constant name="GDK_KEY_KP_F4" type="int" value="65428"/>
		<constant name="GDK_KEY_KP_Home" type="int" value="65429"/>
		<constant name="GDK_KEY_KP_Insert" type="int" value="65438"/>
		<constant name="GDK_KEY_KP_Left" type="int" value="65430"/>
		<constant name="GDK_KEY_KP_Multiply" type="int" value="65450"/>
		<constant name="GDK_KEY_KP_Next" type="int" value="65435"/>
		<constant name="GDK_KEY_KP_Page_Down" type="int" value="65435"/>
		<constant name="GDK_KEY_KP_Page_Up" type="int" value="65434"/>
		<constant name="GDK_KEY_KP_Prior" type="int" value="65434"/>
		<constant name="GDK_KEY_KP_Right" type="int" value="65432"/>
		<constant name="GDK_KEY_KP_Separator" type="int" value="65452"/>
		<constant name="GDK_KEY_KP_Space" type="int" value="65408"/>
		<constant name="GDK_KEY_KP_Subtract" type="int" value="65453"/>
		<constant name="GDK_KEY_KP_Tab" type="int" value="65417"/>
		<constant name="GDK_KEY_KP_Up" type="int" value="65431"/>
		<constant name="GDK_KEY_Kana_Lock" type="int" value="65325"/>
		<constant name="GDK_KEY_Kana_Shift" type="int" value="65326"/>
		<constant name="GDK_KEY_Kanji" type="int" value="65313"/>
		<constant name="GDK_KEY_Kanji_Bangou" type="int" value="65335"/>
		<constant name="GDK_KEY_Katakana" type="int" value="65318"/>
		<constant name="GDK_KEY_KbdBrightnessDown" type="int" value="269025030"/>
		<constant name="GDK_KEY_KbdBrightnessUp" type="int" value="269025029"/>
		<constant name="GDK_KEY_KbdLightOnOff" type="int" value="269025028"/>
		<constant name="GDK_KEY_Kcedilla" type="int" value="979"/>
		<constant name="GDK_KEY_Korean_Won" type="int" value="3839"/>
		<constant name="GDK_KEY_L" type="int" value="76"/>
		<constant name="GDK_KEY_L1" type="int" value="65480"/>
		<constant name="GDK_KEY_L10" type="int" value="65489"/>
		<constant name="GDK_KEY_L2" type="int" value="65481"/>
		<constant name="GDK_KEY_L3" type="int" value="65482"/>
		<constant name="GDK_KEY_L4" type="int" value="65483"/>
		<constant name="GDK_KEY_L5" type="int" value="65484"/>
		<constant name="GDK_KEY_L6" type="int" value="65485"/>
		<constant name="GDK_KEY_L7" type="int" value="65486"/>
		<constant name="GDK_KEY_L8" type="int" value="65487"/>
		<constant name="GDK_KEY_L9" type="int" value="65488"/>
		<constant name="GDK_KEY_Lacute" type="int" value="453"/>
		<constant name="GDK_KEY_Last_Virtual_Screen" type="int" value="65236"/>
		<constant name="GDK_KEY_Launch0" type="int" value="269025088"/>
		<constant name="GDK_KEY_Launch1" type="int" value="269025089"/>
		<constant name="GDK_KEY_Launch2" type="int" value="269025090"/>
		<constant name="GDK_KEY_Launch3" type="int" value="269025091"/>
		<constant name="GDK_KEY_Launch4" type="int" value="269025092"/>
		<constant name="GDK_KEY_Launch5" type="int" value="269025093"/>
		<constant name="GDK_KEY_Launch6" type="int" value="269025094"/>
		<constant name="GDK_KEY_Launch7" type="int" value="269025095"/>
		<constant name="GDK_KEY_Launch8" type="int" value="269025096"/>
		<constant name="GDK_KEY_Launch9" type="int" value="269025097"/>
		<constant name="GDK_KEY_LaunchA" type="int" value="269025098"/>
		<constant name="GDK_KEY_LaunchB" type="int" value="269025099"/>
		<constant name="GDK_KEY_LaunchC" type="int" value="269025100"/>
		<constant name="GDK_KEY_LaunchD" type="int" value="269025101"/>
		<constant name="GDK_KEY_LaunchE" type="int" value="269025102"/>
		<constant name="GDK_KEY_LaunchF" type="int" value="269025103"/>
		<constant name="GDK_KEY_Lbelowdot" type="int" value="16784950"/>
		<constant name="GDK_KEY_Lcaron" type="int" value="421"/>
		<constant name="GDK_KEY_Lcedilla" type="int" value="934"/>
		<constant name="GDK_KEY_Left" type="int" value="65361"/>
		<constant name="GDK_KEY_LightBulb" type="int" value="269025077"/>
		<constant name="GDK_KEY_Linefeed" type="int" value="65290"/>
		<constant name="GDK_KEY_LiraSign" type="int" value="16785572"/>
		<constant name="GDK_KEY_LogOff" type="int" value="269025121"/>
		<constant name="GDK_KEY_Lstroke" type="int" value="419"/>
		<constant name="GDK_KEY_M" type="int" value="77"/>
		<constant name="GDK_KEY_Mabovedot" type="int" value="16784960"/>
		<constant name="GDK_KEY_Macedonia_DSE" type="int" value="1717"/>
		<constant name="GDK_KEY_Macedonia_GJE" type="int" value="1714"/>
		<constant name="GDK_KEY_Macedonia_KJE" type="int" value="1724"/>
		<constant name="GDK_KEY_Macedonia_dse" type="int" value="1701"/>
		<constant name="GDK_KEY_Macedonia_gje" type="int" value="1698"/>
		<constant name="GDK_KEY_Macedonia_kje" type="int" value="1708"/>
		<constant name="GDK_KEY_Mae_Koho" type="int" value="65342"/>
		<constant name="GDK_KEY_Mail" type="int" value="269025049"/>
		<constant name="GDK_KEY_MailForward" type="int" value="269025168"/>
		<constant name="GDK_KEY_Market" type="int" value="269025122"/>
		<constant name="GDK_KEY_Massyo" type="int" value="65324"/>
		<constant name="GDK_KEY_Meeting" type="int" value="269025123"/>
		<constant name="GDK_KEY_Memo" type="int" value="269025054"/>
		<constant name="GDK_KEY_Menu" type="int" value="65383"/>
		<constant name="GDK_KEY_MenuKB" type="int" value="269025125"/>
		<constant name="GDK_KEY_MenuPB" type="int" value="269025126"/>
		<constant name="GDK_KEY_Messenger" type="int" value="269025166"/>
		<constant name="GDK_KEY_Meta_L" type="int" value="65511"/>
		<constant name="GDK_KEY_Meta_R" type="int" value="65512"/>
		<constant name="GDK_KEY_MillSign" type="int" value="16785573"/>
		<constant name="GDK_KEY_ModeLock" type="int" value="269025025"/>
		<constant name="GDK_KEY_Mode_switch" type="int" value="65406"/>
		<constant name="GDK_KEY_MonBrightnessDown" type="int" value="269025027"/>
		<constant name="GDK_KEY_MonBrightnessUp" type="int" value="269025026"/>
		<constant name="GDK_KEY_MouseKeys_Accel_Enable" type="int" value="65143"/>
		<constant name="GDK_KEY_MouseKeys_Enable" type="int" value="65142"/>
		<constant name="GDK_KEY_Muhenkan" type="int" value="65314"/>
		<constant name="GDK_KEY_Multi_key" type="int" value="65312"/>
		<constant name="GDK_KEY_MultipleCandidate" type="int" value="65341"/>
		<constant name="GDK_KEY_Music" type="int" value="269025170"/>
		<constant name="GDK_KEY_MyComputer" type="int" value="269025075"/>
		<constant name="GDK_KEY_MySites" type="int" value="269025127"/>
		<constant name="GDK_KEY_N" type="int" value="78"/>
		<constant name="GDK_KEY_Nacute" type="int" value="465"/>
		<constant name="GDK_KEY_NairaSign" type="int" value="16785574"/>
		<constant name="GDK_KEY_Ncaron" type="int" value="466"/>
		<constant name="GDK_KEY_Ncedilla" type="int" value="977"/>
		<constant name="GDK_KEY_New" type="int" value="269025128"/>
		<constant name="GDK_KEY_NewSheqelSign" type="int" value="16785578"/>
		<constant name="GDK_KEY_News" type="int" value="269025129"/>
		<constant name="GDK_KEY_Next" type="int" value="65366"/>
		<constant name="GDK_KEY_Next_VMode" type="int" value="269024802"/>
		<constant name="GDK_KEY_Next_Virtual_Screen" type="int" value="65234"/>
		<constant name="GDK_KEY_Ntilde" type="int" value="209"/>
		<constant name="GDK_KEY_Num_Lock" type="int" value="65407"/>
		<constant name="GDK_KEY_O" type="int" value="79"/>
		<constant name="GDK_KEY_OE" type="int" value="5052"/>
		<constant name="GDK_KEY_Oacute" type="int" value="211"/>
		<constant name="GDK_KEY_Obarred" type="int" value="16777631"/>
		<constant name="GDK_KEY_Obelowdot" type="int" value="16785100"/>
		<constant name="GDK_KEY_Ocaron" type="int" value="16777681"/>
		<constant name="GDK_KEY_Ocircumflex" type="int" value="212"/>
		<constant name="GDK_KEY_Ocircumflexacute" type="int" value="16785104"/>
		<constant name="GDK_KEY_Ocircumflexbelowdot" type="int" value="16785112"/>
		<constant name="GDK_KEY_Ocircumflexgrave" type="int" value="16785106"/>
		<constant name="GDK_KEY_Ocircumflexhook" type="int" value="16785108"/>
		<constant name="GDK_KEY_Ocircumflextilde" type="int" value="16785110"/>
		<constant name="GDK_KEY_Odiaeresis" type="int" value="214"/>
		<constant name="GDK_KEY_Odoubleacute" type="int" value="469"/>
		<constant name="GDK_KEY_OfficeHome" type="int" value="269025130"/>
		<constant name="GDK_KEY_Ograve" type="int" value="210"/>
		<constant name="GDK_KEY_Ohook" type="int" value="16785102"/>
		<constant name="GDK_KEY_Ohorn" type="int" value="16777632"/>
		<constant name="GDK_KEY_Ohornacute" type="int" value="16785114"/>
		<constant name="GDK_KEY_Ohornbelowdot" type="int" value="16785122"/>
		<constant name="GDK_KEY_Ohorngrave" type="int" value="16785116"/>
		<constant name="GDK_KEY_Ohornhook" type="int" value="16785118"/>
		<constant name="GDK_KEY_Ohorntilde" type="int" value="16785120"/>
		<constant name="GDK_KEY_Omacron" type="int" value="978"/>
		<constant name="GDK_KEY_Ooblique" type="int" value="216"/>
		<constant name="GDK_KEY_Open" type="int" value="269025131"/>
		<constant name="GDK_KEY_OpenURL" type="int" value="269025080"/>
		<constant name="GDK_KEY_Option" type="int" value="269025132"/>
		<constant name="GDK_KEY_Oslash" type="int" value="216"/>
		<constant name="GDK_KEY_Otilde" type="int" value="213"/>
		<constant name="GDK_KEY_Overlay1_Enable" type="int" value="65144"/>
		<constant name="GDK_KEY_Overlay2_Enable" type="int" value="65145"/>
		<constant name="GDK_KEY_P" type="int" value="80"/>
		<constant name="GDK_KEY_Pabovedot" type="int" value="16784982"/>
		<constant name="GDK_KEY_Page_Down" type="int" value="65366"/>
		<constant name="GDK_KEY_Page_Up" type="int" value="65365"/>
		<constant name="GDK_KEY_Paste" type="int" value="269025133"/>
		<constant name="GDK_KEY_Pause" type="int" value="65299"/>
		<constant name="GDK_KEY_PesetaSign" type="int" value="16785575"/>
		<constant name="GDK_KEY_Phone" type="int" value="269025134"/>
		<constant name="GDK_KEY_Pictures" type="int" value="269025169"/>
		<constant name="GDK_KEY_Pointer_Accelerate" type="int" value="65274"/>
		<constant name="GDK_KEY_Pointer_Button1" type="int" value="65257"/>
		<constant name="GDK_KEY_Pointer_Button2" type="int" value="65258"/>
		<constant name="GDK_KEY_Pointer_Button3" type="int" value="65259"/>
		<constant name="GDK_KEY_Pointer_Button4" type="int" value="65260"/>
		<constant name="GDK_KEY_Pointer_Button5" type="int" value="65261"/>
		<constant name="GDK_KEY_Pointer_Button_Dflt" type="int" value="65256"/>
		<constant name="GDK_KEY_Pointer_DblClick1" type="int" value="65263"/>
		<constant name="GDK_KEY_Pointer_DblClick2" type="int" value="65264"/>
		<constant name="GDK_KEY_Pointer_DblClick3" type="int" value="65265"/>
		<constant name="GDK_KEY_Pointer_DblClick4" type="int" value="65266"/>
		<constant name="GDK_KEY_Pointer_DblClick5" type="int" value="65267"/>
		<constant name="GDK_KEY_Pointer_DblClick_Dflt" type="int" value="65262"/>
		<constant name="GDK_KEY_Pointer_DfltBtnNext" type="int" value="65275"/>
		<constant name="GDK_KEY_Pointer_DfltBtnPrev" type="int" value="65276"/>
		<constant name="GDK_KEY_Pointer_Down" type="int" value="65251"/>
		<constant name="GDK_KEY_Pointer_DownLeft" type="int" value="65254"/>
		<constant name="GDK_KEY_Pointer_DownRight" type="int" value="65255"/>
		<constant name="GDK_KEY_Pointer_Drag1" type="int" value="65269"/>
		<constant name="GDK_KEY_Pointer_Drag2" type="int" value="65270"/>
		<constant name="GDK_KEY_Pointer_Drag3" type="int" value="65271"/>
		<constant name="GDK_KEY_Pointer_Drag4" type="int" value="65272"/>
		<constant name="GDK_KEY_Pointer_Drag5" type="int" value="65277"/>
		<constant name="GDK_KEY_Pointer_Drag_Dflt" type="int" value="65268"/>
		<constant name="GDK_KEY_Pointer_EnableKeys" type="int" value="65273"/>
		<constant name="GDK_KEY_Pointer_Left" type="int" value="65248"/>
		<constant name="GDK_KEY_Pointer_Right" type="int" value="65249"/>
		<constant name="GDK_KEY_Pointer_Up" type="int" value="65250"/>
		<constant name="GDK_KEY_Pointer_UpLeft" type="int" value="65252"/>
		<constant name="GDK_KEY_Pointer_UpRight" type="int" value="65253"/>
		<constant name="GDK_KEY_PowerDown" type="int" value="269025057"/>
		<constant name="GDK_KEY_PowerOff" type="int" value="269025066"/>
		<constant name="GDK_KEY_Prev_VMode" type="int" value="269024803"/>
		<constant name="GDK_KEY_Prev_Virtual_Screen" type="int" value="65233"/>
		<constant name="GDK_KEY_PreviousCandidate" type="int" value="65342"/>
		<constant name="GDK_KEY_Print" type="int" value="65377"/>
		<constant name="GDK_KEY_Prior" type="int" value="65365"/>
		<constant name="GDK_KEY_Q" type="int" value="81"/>
		<constant name="GDK_KEY_R" type="int" value="82"/>
		<constant name="GDK_KEY_R1" type="int" value="65490"/>
		<constant name="GDK_KEY_R10" type="int" value="65499"/>
		<constant name="GDK_KEY_R11" type="int" value="65500"/>
		<constant name="GDK_KEY_R12" type="int" value="65501"/>
		<constant name="GDK_KEY_R13" type="int" value="65502"/>
		<constant name="GDK_KEY_R14" type="int" value="65503"/>
		<constant name="GDK_KEY_R15" type="int" value="65504"/>
		<constant name="GDK_KEY_R2" type="int" value="65491"/>
		<constant name="GDK_KEY_R3" type="int" value="65492"/>
		<constant name="GDK_KEY_R4" type="int" value="65493"/>
		<constant name="GDK_KEY_R5" type="int" value="65494"/>
		<constant name="GDK_KEY_R6" type="int" value="65495"/>
		<constant name="GDK_KEY_R7" type="int" value="65496"/>
		<constant name="GDK_KEY_R8" type="int" value="65497"/>
		<constant name="GDK_KEY_R9" type="int" value="65498"/>
		<constant name="GDK_KEY_Racute" type="int" value="448"/>
		<constant name="GDK_KEY_Rcaron" type="int" value="472"/>
		<constant name="GDK_KEY_Rcedilla" type="int" value="931"/>
		<constant name="GDK_KEY_Red" type="int" value="269025187"/>
		<constant name="GDK_KEY_Redo" type="int" value="65382"/>
		<constant name="GDK_KEY_Refresh" type="int" value="269025065"/>
		<constant name="GDK_KEY_Reload" type="int" value="269025139"/>
		<constant name="GDK_KEY_RepeatKeys_Enable" type="int" value="65138"/>
		<constant name="GDK_KEY_Reply" type="int" value="269025138"/>
		<constant name="GDK_KEY_Return" type="int" value="65293"/>
		<constant name="GDK_KEY_Right" type="int" value="65363"/>
		<constant name="GDK_KEY_RockerDown" type="int" value="269025060"/>
		<constant name="GDK_KEY_RockerEnter" type="int" value="269025061"/>
		<constant name="GDK_KEY_RockerUp" type="int" value="269025059"/>
		<constant name="GDK_KEY_Romaji" type="int" value="65316"/>
		<constant name="GDK_KEY_RotateWindows" type="int" value="269025140"/>
		<constant name="GDK_KEY_RotationKB" type="int" value="269025142"/>
		<constant name="GDK_KEY_RotationPB" type="int" value="269025141"/>
		<constant name="GDK_KEY_RupeeSign" type="int" value="16785576"/>
		<constant name="GDK_KEY_S" type="int" value="83"/>
		<constant name="GDK_KEY_SCHWA" type="int" value="16777615"/>
		<constant name="GDK_KEY_Sabovedot" type="int" value="16784992"/>
		<constant name="GDK_KEY_Sacute" type="int" value="422"/>
		<constant name="GDK_KEY_Save" type="int" value="269025143"/>
		<constant name="GDK_KEY_Scaron" type="int" value="425"/>
		<constant name="GDK_KEY_Scedilla" type="int" value="426"/>
		<constant name="GDK_KEY_Scircumflex" type="int" value="734"/>
		<constant name="GDK_KEY_ScreenSaver" type="int" value="269025069"/>
		<constant name="GDK_KEY_ScrollClick" type="int" value="269025146"/>
		<constant name="GDK_KEY_ScrollDown" type="int" value="269025145"/>
		<constant name="GDK_KEY_ScrollUp" type="int" value="269025144"/>
		<constant name="GDK_KEY_Scroll_Lock" type="int" value="65300"/>
		<constant name="GDK_KEY_Search" type="int" value="269025051"/>
		<constant name="GDK_KEY_Select" type="int" value="65376"/>
		<constant name="GDK_KEY_SelectButton" type="int" value="269025184"/>
		<constant name="GDK_KEY_Send" type="int" value="269025147"/>
		<constant name="GDK_KEY_Serbian_DJE" type="int" value="1713"/>
		<constant name="GDK_KEY_Serbian_DZE" type="int" value="1727"/>
		<constant name="GDK_KEY_Serbian_JE" type="int" value="1720"/>
		<constant name="GDK_KEY_Serbian_LJE" type="int" value="1721"/>
		<constant name="GDK_KEY_Serbian_NJE" type="int" value="1722"/>
		<constant name="GDK_KEY_Serbian_TSHE" type="int" value="1723"/>
		<constant name="GDK_KEY_Serbian_dje" type="int" value="1697"/>
		<constant name="GDK_KEY_Serbian_dze" type="int" value="1711"/>
		<constant name="GDK_KEY_Serbian_je" type="int" value="1704"/>
		<constant name="GDK_KEY_Serbian_lje" type="int" value="1705"/>
		<constant name="GDK_KEY_Serbian_nje" type="int" value="1706"/>
		<constant name="GDK_KEY_Serbian_tshe" type="int" value="1707"/>
		<constant name="GDK_KEY_Shift_L" type="int" value="65505"/>
		<constant name="GDK_KEY_Shift_Lock" type="int" value="65510"/>
		<constant name="GDK_KEY_Shift_R" type="int" value="65506"/>
		<constant name="GDK_KEY_Shop" type="int" value="269025078"/>
		<constant name="GDK_KEY_SingleCandidate" type="int" value="65340"/>
		<constant name="GDK_KEY_Sleep" type="int" value="269025071"/>
		<constant name="GDK_KEY_SlowKeys_Enable" type="int" value="65139"/>
		<constant name="GDK_KEY_Spell" type="int" value="269025148"/>
		<constant name="GDK_KEY_SplitScreen" type="int" value="269025149"/>
		<constant name="GDK_KEY_Standby" type="int" value="269025040"/>
		<constant name="GDK_KEY_Start" type="int" value="269025050"/>
		<constant name="GDK_KEY_StickyKeys_Enable" type="int" value="65141"/>
		<constant name="GDK_KEY_Stop" type="int" value="269025064"/>
		<constant name="GDK_KEY_Subtitle" type="int" value="269025178"/>
		<constant name="GDK_KEY_Super_L" type="int" value="65515"/>
		<constant name="GDK_KEY_Super_R" type="int" value="65516"/>
		<constant name="GDK_KEY_Support" type="int" value="269025150"/>
		<constant name="GDK_KEY_Suspend" type="int" value="269025191"/>
		<constant name="GDK_KEY_Switch_VT_1" type="int" value="269024769"/>
		<constant name="GDK_KEY_Switch_VT_10" type="int" value="269024778"/>
		<constant name="GDK_KEY_Switch_VT_11" type="int" value="269024779"/>
		<constant name="GDK_KEY_Switch_VT_12" type="int" value="269024780"/>
		<constant name="GDK_KEY_Switch_VT_2" type="int" value="269024770"/>
		<constant name="GDK_KEY_Switch_VT_3" type="int" value="269024771"/>
		<constant name="GDK_KEY_Switch_VT_4" type="int" value="269024772"/>
		<constant name="GDK_KEY_Switch_VT_5" type="int" value="269024773"/>
		<constant name="GDK_KEY_Switch_VT_6" type="int" value="269024774"/>
		<constant name="GDK_KEY_Switch_VT_7" type="int" value="269024775"/>
		<constant name="GDK_KEY_Switch_VT_8" type="int" value="269024776"/>
		<constant name="GDK_KEY_Switch_VT_9" type="int" value="269024777"/>
		<constant name="GDK_KEY_Sys_Req" type="int" value="65301"/>
		<constant name="GDK_KEY_T" type="int" value="84"/>
		<constant name="GDK_KEY_THORN" type="int" value="222"/>
		<constant name="GDK_KEY_Tab" type="int" value="65289"/>
		<constant name="GDK_KEY_Tabovedot" type="int" value="16785002"/>
		<constant name="GDK_KEY_TaskPane" type="int" value="269025151"/>
		<constant name="GDK_KEY_Tcaron" type="int" value="427"/>
		<constant name="GDK_KEY_Tcedilla" type="int" value="478"/>
		<constant name="GDK_KEY_Terminal" type="int" value="269025152"/>
		<constant name="GDK_KEY_Terminate_Server" type="int" value="65237"/>
		<constant name="GDK_KEY_Thai_baht" type="int" value="3551"/>
		<constant name="GDK_KEY_Thai_bobaimai" type="int" value="3514"/>
		<constant name="GDK_KEY_Thai_chochan" type="int" value="3496"/>
		<constant name="GDK_KEY_Thai_chochang" type="int" value="3498"/>
		<constant name="GDK_KEY_Thai_choching" type="int" value="3497"/>
		<constant name="GDK_KEY_Thai_chochoe" type="int" value="3500"/>
		<constant name="GDK_KEY_Thai_dochada" type="int" value="3502"/>
		<constant name="GDK_KEY_Thai_dodek" type="int" value="3508"/>
		<constant name="GDK_KEY_Thai_fofa" type="int" value="3517"/>
		<constant name="GDK_KEY_Thai_fofan" type="int" value="3519"/>
		<constant name="GDK_KEY_Thai_hohip" type="int" value="3531"/>
		<constant name="GDK_KEY_Thai_honokhuk" type="int" value="3534"/>
		<constant name="GDK_KEY_Thai_khokhai" type="int" value="3490"/>
		<constant name="GDK_KEY_Thai_khokhon" type="int" value="3493"/>
		<constant name="GDK_KEY_Thai_khokhuat" type="int" value="3491"/>
		<constant name="GDK_KEY_Thai_khokhwai" type="int" value="3492"/>
		<constant name="GDK_KEY_Thai_khorakhang" type="int" value="3494"/>
		<constant name="GDK_KEY_Thai_kokai" type="int" value="3489"/>
		<constant name="GDK_KEY_Thai_lakkhangyao" type="int" value="3557"/>
		<constant name="GDK_KEY_Thai_lekchet" type="int" value="3575"/>
		<constant name="GDK_KEY_Thai_lekha" type="int" value="3573"/>
		<constant name="GDK_KEY_Thai_lekhok" type="int" value="3574"/>
		<constant name="GDK_KEY_Thai_lekkao" type="int" value="3577"/>
		<constant name="GDK_KEY_Thai_leknung" type="int" value="3569"/>
		<constant name="GDK_KEY_Thai_lekpaet" type="int" value="3576"/>
		<constant name="GDK_KEY_Thai_leksam" type="int" value="3571"/>
		<constant name="GDK_KEY_Thai_leksi" type="int" value="3572"/>
		<constant name="GDK_KEY_Thai_leksong" type="int" value="3570"/>
		<constant name="GDK_KEY_Thai_leksun" type="int" value="3568"/>
		<constant name="GDK_KEY_Thai_lochula" type="int" value="3532"/>
		<constant name="GDK_KEY_Thai_loling" type="int" value="3525"/>
		<constant name="GDK_KEY_Thai_lu" type="int" value="3526"/>
		<constant name="GDK_KEY_Thai_maichattawa" type="int" value="3563"/>
		<constant name="GDK_KEY_Thai_maiek" type="int" value="3560"/>
		<constant name="GDK_KEY_Thai_maihanakat" type="int" value="3537"/>
		<constant name="GDK_KEY_Thai_maihanakat_maitho" type="int" value="3550"/>
		<constant name="GDK_KEY_Thai_maitaikhu" type="int" value="3559"/>
		<constant name="GDK_KEY_Thai_maitho" type="int" value="3561"/>
		<constant name="GDK_KEY_Thai_maitri" type="int" value="3562"/>
		<constant name="GDK_KEY_Thai_maiyamok" type="int" value="3558"/>
		<constant name="GDK_KEY_Thai_moma" type="int" value="3521"/>
		<constant name="GDK_KEY_Thai_ngongu" type="int" value="3495"/>
		<constant name="GDK_KEY_Thai_nikhahit" type="int" value="3565"/>
		<constant name="GDK_KEY_Thai_nonen" type="int" value="3507"/>
		<constant name="GDK_KEY_Thai_nonu" type="int" value="3513"/>
		<constant name="GDK_KEY_Thai_oang" type="int" value="3533"/>
		<constant name="GDK_KEY_Thai_paiyannoi" type="int" value="3535"/>
		<constant name="GDK_KEY_Thai_phinthu" type="int" value="3546"/>
		<constant name="GDK_KEY_Thai_phophan" type="int" value="3518"/>
		<constant name="GDK_KEY_Thai_phophung" type="int" value="3516"/>
		<constant name="GDK_KEY_Thai_phosamphao" type="int" value="3520"/>
		<constant name="GDK_KEY_Thai_popla" type="int" value="3515"/>
		<constant name="GDK_KEY_Thai_rorua" type="int" value="3523"/>
		<constant name="GDK_KEY_Thai_ru" type="int" value="3524"/>
		<constant name="GDK_KEY_Thai_saraa" type="int" value="3536"/>
		<constant name="GDK_KEY_Thai_saraaa" type="int" value="3538"/>
		<constant name="GDK_KEY_Thai_saraae" type="int" value="3553"/>
		<constant name="GDK_KEY_Thai_saraaimaimalai" type="int" value="3556"/>
		<constant name="GDK_KEY_Thai_saraaimaimuan" type="int" value="3555"/>
		<constant name="GDK_KEY_Thai_saraam" type="int" value="3539"/>
		<constant name="GDK_KEY_Thai_sarae" type="int" value="3552"/>
		<constant name="GDK_KEY_Thai_sarai" type="int" value="3540"/>
		<constant name="GDK_KEY_Thai_saraii" type="int" value="3541"/>
		<constant name="GDK_KEY_Thai_sarao" type="int" value="3554"/>
		<constant name="GDK_KEY_Thai_sarau" type="int" value="3544"/>
		<constant name="GDK_KEY_Thai_saraue" type="int" value="3542"/>
		<constant name="GDK_KEY_Thai_sarauee" type="int" value="3543"/>
		<constant name="GDK_KEY_Thai_sarauu" type="int" value="3545"/>
		<constant name="GDK_KEY_Thai_sorusi" type="int" value="3529"/>
		<constant name="GDK_KEY_Thai_sosala" type="int" value="3528"/>
		<constant name="GDK_KEY_Thai_soso" type="int" value="3499"/>
		<constant name="GDK_KEY_Thai_sosua" type="int" value="3530"/>
		<constant name="GDK_KEY_Thai_thanthakhat" type="int" value="3564"/>
		<constant name="GDK_KEY_Thai_thonangmontho" type="int" value="3505"/>
		<constant name="GDK_KEY_Thai_thophuthao" type="int" value="3506"/>
		<constant name="GDK_KEY_Thai_thothahan" type="int" value="3511"/>
		<constant name="GDK_KEY_Thai_thothan" type="int" value="3504"/>
		<constant name="GDK_KEY_Thai_thothong" type="int" value="3512"/>
		<constant name="GDK_KEY_Thai_thothung" type="int" value="3510"/>
		<constant name="GDK_KEY_Thai_topatak" type="int" value="3503"/>
		<constant name="GDK_KEY_Thai_totao" type="int" value="3509"/>
		<constant name="GDK_KEY_Thai_wowaen" type="int" value="3527"/>
		<constant name="GDK_KEY_Thai_yoyak" type="int" value="3522"/>
		<constant name="GDK_KEY_Thai_yoying" type="int" value="3501"/>
		<constant name="GDK_KEY_Thorn" type="int" value="222"/>
		<constant name="GDK_KEY_Time" type="int" value="269025183"/>
		<constant name="GDK_KEY_ToDoList" type="int" value="269025055"/>
		<constant name="GDK_KEY_Tools" type="int" value="269025153"/>
		<constant name="GDK_KEY_TopMenu" type="int" value="269025186"/>
		<constant name="GDK_KEY_TouchpadToggle" type="int" value="269025193"/>
		<constant name="GDK_KEY_Touroku" type="int" value="65323"/>
		<constant name="GDK_KEY_Travel" type="int" value="269025154"/>
		<constant name="GDK_KEY_Tslash" type="int" value="940"/>
		<constant name="GDK_KEY_U" type="int" value="85"/>
		<constant name="GDK_KEY_UWB" type="int" value="269025174"/>
		<constant name="GDK_KEY_Uacute" type="int" value="218"/>
		<constant name="GDK_KEY_Ubelowdot" type="int" value="16785124"/>
		<constant name="GDK_KEY_Ubreve" type="int" value="733"/>
		<constant name="GDK_KEY_Ucircumflex" type="int" value="219"/>
		<constant name="GDK_KEY_Udiaeresis" type="int" value="220"/>
		<constant name="GDK_KEY_Udoubleacute" type="int" value="475"/>
		<constant name="GDK_KEY_Ugrave" type="int" value="217"/>
		<constant name="GDK_KEY_Uhook" type="int" value="16785126"/>
		<constant name="GDK_KEY_Uhorn" type="int" value="16777647"/>
		<constant name="GDK_KEY_Uhornacute" type="int" value="16785128"/>
		<constant name="GDK_KEY_Uhornbelowdot" type="int" value="16785136"/>
		<constant name="GDK_KEY_Uhorngrave" type="int" value="16785130"/>
		<constant name="GDK_KEY_Uhornhook" type="int" value="16785132"/>
		<constant name="GDK_KEY_Uhorntilde" type="int" value="16785134"/>
		<constant name="GDK_KEY_Ukrainian_GHE_WITH_UPTURN" type="int" value="1725"/>
		<constant name="GDK_KEY_Ukrainian_I" type="int" value="1718"/>
		<constant name="GDK_KEY_Ukrainian_IE" type="int" value="1716"/>
		<constant name="GDK_KEY_Ukrainian_YI" type="int" value="1719"/>
		<constant name="GDK_KEY_Ukrainian_ghe_with_upturn" type="int" value="1709"/>
		<constant name="GDK_KEY_Ukrainian_i" type="int" value="1702"/>
		<constant name="GDK_KEY_Ukrainian_ie" type="int" value="1700"/>
		<constant name="GDK_KEY_Ukrainian_yi" type="int" value="1703"/>
		<constant name="GDK_KEY_Ukranian_I" type="int" value="1718"/>
		<constant name="GDK_KEY_Ukranian_JE" type="int" value="1716"/>
		<constant name="GDK_KEY_Ukranian_YI" type="int" value="1719"/>
		<constant name="GDK_KEY_Ukranian_i" type="int" value="1702"/>
		<constant name="GDK_KEY_Ukranian_je" type="int" value="1700"/>
		<constant name="GDK_KEY_Ukranian_yi" type="int" value="1703"/>
		<constant name="GDK_KEY_Umacron" type="int" value="990"/>
		<constant name="GDK_KEY_Undo" type="int" value="65381"/>
		<constant name="GDK_KEY_Ungrab" type="int" value="269024800"/>
		<constant name="GDK_KEY_Uogonek" type="int" value="985"/>
		<constant name="GDK_KEY_Up" type="int" value="65362"/>
		<constant name="GDK_KEY_Uring" type="int" value="473"/>
		<constant name="GDK_KEY_User1KB" type="int" value="269025157"/>
		<constant name="GDK_KEY_User2KB" type="int" value="269025158"/>
		<constant name="GDK_KEY_UserPB" type="int" value="269025156"/>
		<constant name="GDK_KEY_Utilde" type="int" value="989"/>
		<constant name="GDK_KEY_V" type="int" value="86"/>
		<constant name="GDK_KEY_VendorHome" type="int" value="269025076"/>
		<constant name="GDK_KEY_Video" type="int" value="269025159"/>
		<constant name="GDK_KEY_View" type="int" value="269025185"/>
		<constant name="GDK_KEY_VoidSymbol" type="int" value="16777215"/>
		<constant name="GDK_KEY_W" type="int" value="87"/>
		<constant name="GDK_KEY_WLAN" type="int" value="269025173"/>
		<constant name="GDK_KEY_WWW" type="int" value="269025070"/>
		<constant name="GDK_KEY_Wacute" type="int" value="16785026"/>
		<constant name="GDK_KEY_WakeUp" type="int" value="269025067"/>
		<constant name="GDK_KEY_Wcircumflex" type="int" value="16777588"/>
		<constant name="GDK_KEY_Wdiaeresis" type="int" value="16785028"/>
		<constant name="GDK_KEY_WebCam" type="int" value="269025167"/>
		<constant name="GDK_KEY_Wgrave" type="int" value="16785024"/>
		<constant name="GDK_KEY_WheelButton" type="int" value="269025160"/>
		<constant name="GDK_KEY_WindowClear" type="int" value="269025109"/>
		<constant name="GDK_KEY_WonSign" type="int" value="16785577"/>
		<constant name="GDK_KEY_Word" type="int" value="269025161"/>
		<constant name="GDK_KEY_X" type="int" value="88"/>
		<constant name="GDK_KEY_Xabovedot" type="int" value="16785034"/>
		<constant name="GDK_KEY_Xfer" type="int" value="269025162"/>
		<constant name="GDK_KEY_Y" type="int" value="89"/>
		<constant name="GDK_KEY_Yacute" type="int" value="221"/>
		<constant name="GDK_KEY_Ybelowdot" type="int" value="16785140"/>
		<constant name="GDK_KEY_Ycircumflex" type="int" value="16777590"/>
		<constant name="GDK_KEY_Ydiaeresis" type="int" value="5054"/>
		<constant name="GDK_KEY_Yellow" type="int" value="269025189"/>
		<constant name="GDK_KEY_Ygrave" type="int" value="16785138"/>
		<constant name="GDK_KEY_Yhook" type="int" value="16785142"/>
		<constant name="GDK_KEY_Ytilde" type="int" value="16785144"/>
		<constant name="GDK_KEY_Z" type="int" value="90"/>
		<constant name="GDK_KEY_Zabovedot" type="int" value="431"/>
		<constant name="GDK_KEY_Zacute" type="int" value="428"/>
		<constant name="GDK_KEY_Zcaron" type="int" value="430"/>
		<constant name="GDK_KEY_Zen_Koho" type="int" value="65341"/>
		<constant name="GDK_KEY_Zenkaku" type="int" value="65320"/>
		<constant name="GDK_KEY_Zenkaku_Hankaku" type="int" value="65322"/>
		<constant name="GDK_KEY_ZoomIn" type="int" value="269025163"/>
		<constant name="GDK_KEY_ZoomOut" type="int" value="269025164"/>
		<constant name="GDK_KEY_Zstroke" type="int" value="16777653"/>
		<constant name="GDK_KEY_a" type="int" value="97"/>
		<constant name="GDK_KEY_aacute" type="int" value="225"/>
		<constant name="GDK_KEY_abelowdot" type="int" value="16785057"/>
		<constant name="GDK_KEY_abovedot" type="int" value="511"/>
		<constant name="GDK_KEY_abreve" type="int" value="483"/>
		<constant name="GDK_KEY_abreveacute" type="int" value="16785071"/>
		<constant name="GDK_KEY_abrevebelowdot" type="int" value="16785079"/>
		<constant name="GDK_KEY_abrevegrave" type="int" value="16785073"/>
		<constant name="GDK_KEY_abrevehook" type="int" value="16785075"/>
		<constant name="GDK_KEY_abrevetilde" type="int" value="16785077"/>
		<constant name="GDK_KEY_acircumflex" type="int" value="226"/>
		<constant name="GDK_KEY_acircumflexacute" type="int" value="16785061"/>
		<constant name="GDK_KEY_acircumflexbelowdot" type="int" value="16785069"/>
		<constant name="GDK_KEY_acircumflexgrave" type="int" value="16785063"/>
		<constant name="GDK_KEY_acircumflexhook" type="int" value="16785065"/>
		<constant name="GDK_KEY_acircumflextilde" type="int" value="16785067"/>
		<constant name="GDK_KEY_acute" type="int" value="180"/>
		<constant name="GDK_KEY_adiaeresis" type="int" value="228"/>
		<constant name="GDK_KEY_ae" type="int" value="230"/>
		<constant name="GDK_KEY_agrave" type="int" value="224"/>
		<constant name="GDK_KEY_ahook" type="int" value="16785059"/>
		<constant name="GDK_KEY_amacron" type="int" value="992"/>
		<constant name="GDK_KEY_ampersand" type="int" value="38"/>
		<constant name="GDK_KEY_aogonek" type="int" value="433"/>
		<constant name="GDK_KEY_apostrophe" type="int" value="39"/>
		<constant name="GDK_KEY_approxeq" type="int" value="16785992"/>
		<constant name="GDK_KEY_approximate" type="int" value="2248"/>
		<constant name="GDK_KEY_aring" type="int" value="229"/>
		<constant name="GDK_KEY_asciicircum" type="int" value="94"/>
		<constant name="GDK_KEY_asciitilde" type="int" value="126"/>
		<constant name="GDK_KEY_asterisk" type="int" value="42"/>
		<constant name="GDK_KEY_at" type="int" value="64"/>
		<constant name="GDK_KEY_atilde" type="int" value="227"/>
		<constant name="GDK_KEY_b" type="int" value="98"/>
		<constant name="GDK_KEY_babovedot" type="int" value="16784899"/>
		<constant name="GDK_KEY_backslash" type="int" value="92"/>
		<constant name="GDK_KEY_ballotcross" type="int" value="2804"/>
		<constant name="GDK_KEY_bar" type="int" value="124"/>
		<constant name="GDK_KEY_because" type="int" value="16785973"/>
		<constant name="GDK_KEY_blank" type="int" value="2527"/>
		<constant name="GDK_KEY_botintegral" type="int" value="2213"/>
		<constant name="GDK_KEY_botleftparens" type="int" value="2220"/>
		<constant name="GDK_KEY_botleftsqbracket" type="int" value="2216"/>
		<constant name="GDK_KEY_botleftsummation" type="int" value="2226"/>
		<constant name="GDK_KEY_botrightparens" type="int" value="2222"/>
		<constant name="GDK_KEY_botrightsqbracket" type="int" value="2218"/>
		<constant name="GDK_KEY_botrightsummation" type="int" value="2230"/>
		<constant name="GDK_KEY_bott" type="int" value="2550"/>
		<constant name="GDK_KEY_botvertsummationconnector" type="int" value="2228"/>
		<constant name="GDK_KEY_braceleft" type="int" value="123"/>
		<constant name="GDK_KEY_braceright" type="int" value="125"/>
		<constant name="GDK_KEY_bracketleft" type="int" value="91"/>
		<constant name="GDK_KEY_bracketright" type="int" value="93"/>
		<constant name="GDK_KEY_braille_blank" type="int" value="16787456"/>
		<constant name="GDK_KEY_braille_dot_1" type="int" value="65521"/>
		<constant name="GDK_KEY_braille_dot_10" type="int" value="65530"/>
		<constant name="GDK_KEY_braille_dot_2" type="int" value="65522"/>
		<constant name="GDK_KEY_braille_dot_3" type="int" value="65523"/>
		<constant name="GDK_KEY_braille_dot_4" type="int" value="65524"/>
		<constant name="GDK_KEY_braille_dot_5" type="int" value="65525"/>
		<constant name="GDK_KEY_braille_dot_6" type="int" value="65526"/>
		<constant name="GDK_KEY_braille_dot_7" type="int" value="65527"/>
		<constant name="GDK_KEY_braille_dot_8" type="int" value="65528"/>
		<constant name="GDK_KEY_braille_dot_9" type="int" value="65529"/>
		<constant name="GDK_KEY_braille_dots_1" type="int" value="16787457"/>
		<constant name="GDK_KEY_braille_dots_12" type="int" value="16787459"/>
		<constant name="GDK_KEY_braille_dots_123" type="int" value="16787463"/>
		<constant name="GDK_KEY_braille_dots_1234" type="int" value="16787471"/>
		<constant name="GDK_KEY_braille_dots_12345" type="int" value="16787487"/>
		<constant name="GDK_KEY_braille_dots_123456" type="int" value="16787519"/>
		<constant name="GDK_KEY_braille_dots_1234567" type="int" value="16787583"/>
		<constant name="GDK_KEY_braille_dots_12345678" type="int" value="16787711"/>
		<constant name="GDK_KEY_braille_dots_1234568" type="int" value="16787647"/>
		<constant name="GDK_KEY_braille_dots_123457" type="int" value="16787551"/>
		<constant name="GDK_KEY_braille_dots_1234578" type="int" value="16787679"/>
		<constant name="GDK_KEY_braille_dots_123458" type="int" value="16787615"/>
		<constant name="GDK_KEY_braille_dots_12346" type="int" value="16787503"/>
		<constant name="GDK_KEY_braille_dots_123467" type="int" value="16787567"/>
		<constant name="GDK_KEY_braille_dots_1234678" type="int" value="16787695"/>
		<constant name="GDK_KEY_braille_dots_123468" type="int" value="16787631"/>
		<constant name="GDK_KEY_braille_dots_12347" type="int" value="16787535"/>
		<constant name="GDK_KEY_braille_dots_123478" type="int" value="16787663"/>
		<constant name="GDK_KEY_braille_dots_12348" type="int" value="16787599"/>
		<constant name="GDK_KEY_braille_dots_1235" type="int" value="16787479"/>
		<constant name="GDK_KEY_braille_dots_12356" type="int" value="16787511"/>
		<constant name="GDK_KEY_braille_dots_123567" type="int" value="16787575"/>
		<constant name="GDK_KEY_braille_dots_1235678" type="int" value="16787703"/>
		<constant name="GDK_KEY_braille_dots_123568" type="int" value="16787639"/>
		<constant name="GDK_KEY_braille_dots_12357" type="int" value="16787543"/>
		<constant name="GDK_KEY_braille_dots_123578" type="int" value="16787671"/>
		<constant name="GDK_KEY_braille_dots_12358" type="int" value="16787607"/>
		<constant name="GDK_KEY_braille_dots_1236" type="int" value="16787495"/>
		<constant name="GDK_KEY_braille_dots_12367" type="int" value="16787559"/>
		<constant name="GDK_KEY_braille_dots_123678" type="int" value="16787687"/>
		<constant name="GDK_KEY_braille_dots_12368" type="int" value="16787623"/>
		<constant name="GDK_KEY_braille_dots_1237" type="int" value="16787527"/>
		<constant name="GDK_KEY_braille_dots_12378" type="int" value="16787655"/>
		<constant name="GDK_KEY_braille_dots_1238" type="int" value="16787591"/>
		<constant name="GDK_KEY_braille_dots_124" type="int" value="16787467"/>
		<constant name="GDK_KEY_braille_dots_1245" type="int" value="16787483"/>
		<constant name="GDK_KEY_braille_dots_12456" type="int" value="16787515"/>
		<constant name="GDK_KEY_braille_dots_124567" type="int" value="16787579"/>
		<constant name="GDK_KEY_braille_dots_1245678" type="int" value="16787707"/>
		<constant name="GDK_KEY_braille_dots_124568" type="int" value="16787643"/>
		<constant name="GDK_KEY_braille_dots_12457" type="int" value="16787547"/>
		<constant name="GDK_KEY_braille_dots_124578" type="int" value="16787675"/>
		<constant name="GDK_KEY_braille_dots_12458" type="int" value="16787611"/>
		<constant name="GDK_KEY_braille_dots_1246" type="int" value="16787499"/>
		<constant name="GDK_KEY_braille_dots_12467" type="int" value="16787563"/>
		<constant name="GDK_KEY_braille_dots_124678" type="int" value="16787691"/>
		<constant name="GDK_KEY_braille_dots_12468" type="int" value="16787627"/>
		<constant name="GDK_KEY_braille_dots_1247" type="int" value="16787531"/>
		<constant name="GDK_KEY_braille_dots_12478" type="int" value="16787659"/>
		<constant name="GDK_KEY_braille_dots_1248" type="int" value="16787595"/>
		<constant name="GDK_KEY_braille_dots_125" type="int" value="16787475"/>
		<constant name="GDK_KEY_braille_dots_1256" type="int" value="16787507"/>
		<constant name="GDK_KEY_braille_dots_12567" type="int" value="16787571"/>
		<constant name="GDK_KEY_braille_dots_125678" type="int" value="16787699"/>
		<constant name="GDK_KEY_braille_dots_12568" type="int" value="16787635"/>
		<constant name="GDK_KEY_braille_dots_1257" type="int" value="16787539"/>
		<constant name="GDK_KEY_braille_dots_12578" type="int" value="16787667"/>
		<constant name="GDK_KEY_braille_dots_1258" type="int" value="16787603"/>
		<constant name="GDK_KEY_braille_dots_126" type="int" value="16787491"/>
		<constant name="GDK_KEY_braille_dots_1267" type="int" value="16787555"/>
		<constant name="GDK_KEY_braille_dots_12678" type="int" value="16787683"/>
		<constant name="GDK_KEY_braille_dots_1268" type="int" value="16787619"/>
		<constant name="GDK_KEY_braille_dots_127" type="int" value="16787523"/>
		<constant name="GDK_KEY_braille_dots_1278" type="int" value="16787651"/>
		<constant name="GDK_KEY_braille_dots_128" type="int" value="16787587"/>
		<constant name="GDK_KEY_braille_dots_13" type="int" value="16787461"/>
		<constant name="GDK_KEY_braille_dots_134" type="int" value="16787469"/>
		<constant name="GDK_KEY_braille_dots_1345" type="int" value="16787485"/>
		<constant name="GDK_KEY_braille_dots_13456" type="int" value="16787517"/>
		<constant name="GDK_KEY_braille_dots_134567" type="int" value="16787581"/>
		<constant name="GDK_KEY_braille_dots_1345678" type="int" value="16787709"/>
		<constant name="GDK_KEY_braille_dots_134568" type="int" value="16787645"/>
		<constant name="GDK_KEY_braille_dots_13457" type="int" value="16787549"/>
		<constant name="GDK_KEY_braille_dots_134578" type="int" value="16787677"/>
		<constant name="GDK_KEY_braille_dots_13458" type="int" value="16787613"/>
		<constant name="GDK_KEY_braille_dots_1346" type="int" value="16787501"/>
		<constant name="GDK_KEY_braille_dots_13467" type="int" value="16787565"/>
		<constant name="GDK_KEY_braille_dots_134678" type="int" value="16787693"/>
		<constant name="GDK_KEY_braille_dots_13468" type="int" value="16787629"/>
		<constant name="GDK_KEY_braille_dots_1347" type="int" value="16787533"/>
		<constant name="GDK_KEY_braille_dots_13478" type="int" value="16787661"/>
		<constant name="GDK_KEY_braille_dots_1348" type="int" value="16787597"/>
		<constant name="GDK_KEY_braille_dots_135" type="int" value="16787477"/>
		<constant name="GDK_KEY_braille_dots_1356" type="int" value="16787509"/>
		<constant name="GDK_KEY_braille_dots_13567" type="int" value="16787573"/>
		<constant name="GDK_KEY_braille_dots_135678" type="int" value="16787701"/>
		<constant name="GDK_KEY_braille_dots_13568" type="int" value="16787637"/>
		<constant name="GDK_KEY_braille_dots_1357" type="int" value="16787541"/>
		<constant name="GDK_KEY_braille_dots_13578" type="int" value="16787669"/>
		<constant name="GDK_KEY_braille_dots_1358" type="int" value="16787605"/>
		<constant name="GDK_KEY_braille_dots_136" type="int" value="16787493"/>
		<constant name="GDK_KEY_braille_dots_1367" type="int" value="16787557"/>
		<constant name="GDK_KEY_braille_dots_13678" type="int" value="16787685"/>
		<constant name="GDK_KEY_braille_dots_1368" type="int" value="16787621"/>
		<constant name="GDK_KEY_braille_dots_137" type="int" value="16787525"/>
		<constant name="GDK_KEY_braille_dots_1378" type="int" value="16787653"/>
		<constant name="GDK_KEY_braille_dots_138" type="int" value="16787589"/>
		<constant name="GDK_KEY_braille_dots_14" type="int" value="16787465"/>
		<constant name="GDK_KEY_braille_dots_145" type="int" value="16787481"/>
		<constant name="GDK_KEY_braille_dots_1456" type="int" value="16787513"/>
		<constant name="GDK_KEY_braille_dots_14567" type="int" value="16787577"/>
		<constant name="GDK_KEY_braille_dots_145678" type="int" value="16787705"/>
		<constant name="GDK_KEY_braille_dots_14568" type="int" value="16787641"/>
		<constant name="GDK_KEY_braille_dots_1457" type="int" value="16787545"/>
		<constant name="GDK_KEY_braille_dots_14578" type="int" value="16787673"/>
		<constant name="GDK_KEY_braille_dots_1458" type="int" value="16787609"/>
		<constant name="GDK_KEY_braille_dots_146" type="int" value="16787497"/>
		<constant name="GDK_KEY_braille_dots_1467" type="int" value="16787561"/>
		<constant name="GDK_KEY_braille_dots_14678" type="int" value="16787689"/>
		<constant name="GDK_KEY_braille_dots_1468" type="int" value="16787625"/>
		<constant name="GDK_KEY_braille_dots_147" type="int" value="16787529"/>
		<constant name="GDK_KEY_braille_dots_1478" type="int" value="16787657"/>
		<constant name="GDK_KEY_braille_dots_148" type="int" value="16787593"/>
		<constant name="GDK_KEY_braille_dots_15" type="int" value="16787473"/>
		<constant name="GDK_KEY_braille_dots_156" type="int" value="16787505"/>
		<constant name="GDK_KEY_braille_dots_1567" type="int" value="16787569"/>
		<constant name="GDK_KEY_braille_dots_15678" type="int" value="16787697"/>
		<constant name="GDK_KEY_braille_dots_1568" type="int" value="16787633"/>
		<constant name="GDK_KEY_braille_dots_157" type="int" value="16787537"/>
		<constant name="GDK_KEY_braille_dots_1578" type="int" value="16787665"/>
		<constant name="GDK_KEY_braille_dots_158" type="int" value="16787601"/>
		<constant name="GDK_KEY_braille_dots_16" type="int" value="16787489"/>
		<constant name="GDK_KEY_braille_dots_167" type="int" value="16787553"/>
		<constant name="GDK_KEY_braille_dots_1678" type="int" value="16787681"/>
		<constant name="GDK_KEY_braille_dots_168" type="int" value="16787617"/>
		<constant name="GDK_KEY_braille_dots_17" type="int" value="16787521"/>
		<constant name="GDK_KEY_braille_dots_178" type="int" value="16787649"/>
		<constant name="GDK_KEY_braille_dots_18" type="int" value="16787585"/>
		<constant name="GDK_KEY_braille_dots_2" type="int" value="16787458"/>
		<constant name="GDK_KEY_braille_dots_23" type="int" value="16787462"/>
		<constant name="GDK_KEY_braille_dots_234" type="int" value="16787470"/>
		<constant name="GDK_KEY_braille_dots_2345" type="int" value="16787486"/>
		<constant name="GDK_KEY_braille_dots_23456" type="int" value="16787518"/>
		<constant name="GDK_KEY_braille_dots_234567" type="int" value="16787582"/>
		<constant name="GDK_KEY_braille_dots_2345678" type="int" value="16787710"/>
		<constant name="GDK_KEY_braille_dots_234568" type="int" value="16787646"/>
		<constant name="GDK_KEY_braille_dots_23457" type="int" value="16787550"/>
		<constant name="GDK_KEY_braille_dots_234578" type="int" value="16787678"/>
		<constant name="GDK_KEY_braille_dots_23458" type="int" value="16787614"/>
		<constant name="GDK_KEY_braille_dots_2346" type="int" value="16787502"/>
		<constant name="GDK_KEY_braille_dots_23467" type="int" value="16787566"/>
		<constant name="GDK_KEY_braille_dots_234678" type="int" value="16787694"/>
		<constant name="GDK_KEY_braille_dots_23468" type="int" value="16787630"/>
		<constant name="GDK_KEY_braille_dots_2347" type="int" value="16787534"/>
		<constant name="GDK_KEY_braille_dots_23478" type="int" value="16787662"/>
		<constant name="GDK_KEY_braille_dots_2348" type="int" value="16787598"/>
		<constant name="GDK_KEY_braille_dots_235" type="int" value="16787478"/>
		<constant name="GDK_KEY_braille_dots_2356" type="int" value="16787510"/>
		<constant name="GDK_KEY_braille_dots_23567" type="int" value="16787574"/>
		<constant name="GDK_KEY_braille_dots_235678" type="int" value="16787702"/>
		<constant name="GDK_KEY_braille_dots_23568" type="int" value="16787638"/>
		<constant name="GDK_KEY_braille_dots_2357" type="int" value="16787542"/>
		<constant name="GDK_KEY_braille_dots_23578" type="int" value="16787670"/>
		<constant name="GDK_KEY_braille_dots_2358" type="int" value="16787606"/>
		<constant name="GDK_KEY_braille_dots_236" type="int" value="16787494"/>
		<constant name="GDK_KEY_braille_dots_2367" type="int" value="16787558"/>
		<constant name="GDK_KEY_braille_dots_23678" type="int" value="16787686"/>
		<constant name="GDK_KEY_braille_dots_2368" type="int" value="16787622"/>
		<constant name="GDK_KEY_braille_dots_237" type="int" value="16787526"/>
		<constant name="GDK_KEY_braille_dots_2378" type="int" value="16787654"/>
		<constant name="GDK_KEY_braille_dots_238" type="int" value="16787590"/>
		<constant name="GDK_KEY_braille_dots_24" type="int" value="16787466"/>
		<constant name="GDK_KEY_braille_dots_245" type="int" value="16787482"/>
		<constant name="GDK_KEY_braille_dots_2456" type="int" value="16787514"/>
		<constant name="GDK_KEY_braille_dots_24567" type="int" value="16787578"/>
		<constant name="GDK_KEY_braille_dots_245678" type="int" value="16787706"/>
		<constant name="GDK_KEY_braille_dots_24568" type="int" value="16787642"/>
		<constant name="GDK_KEY_braille_dots_2457" type="int" value="16787546"/>
		<constant name="GDK_KEY_braille_dots_24578" type="int" value="16787674"/>
		<constant name="GDK_KEY_braille_dots_2458" type="int" value="16787610"/>
		<constant name="GDK_KEY_braille_dots_246" type="int" value="16787498"/>
		<constant name="GDK_KEY_braille_dots_2467" type="int" value="16787562"/>
		<constant name="GDK_KEY_braille_dots_24678" type="int" value="16787690"/>
		<constant name="GDK_KEY_braille_dots_2468" type="int" value="16787626"/>
		<constant name="GDK_KEY_braille_dots_247" type="int" value="16787530"/>
		<constant name="GDK_KEY_braille_dots_2478" type="int" value="16787658"/>
		<constant name="GDK_KEY_braille_dots_248" type="int" value="16787594"/>
		<constant name="GDK_KEY_braille_dots_25" type="int" value="16787474"/>
		<constant name="GDK_KEY_braille_dots_256" type="int" value="16787506"/>
		<constant name="GDK_KEY_braille_dots_2567" type="int" value="16787570"/>
		<constant name="GDK_KEY_braille_dots_25678" type="int" value="16787698"/>
		<constant name="GDK_KEY_braille_dots_2568" type="int" value="16787634"/>
		<constant name="GDK_KEY_braille_dots_257" type="int" value="16787538"/>
		<constant name="GDK_KEY_braille_dots_2578" type="int" value="16787666"/>
		<constant name="GDK_KEY_braille_dots_258" type="int" value="16787602"/>
		<constant name="GDK_KEY_braille_dots_26" type="int" value="16787490"/>
		<constant name="GDK_KEY_braille_dots_267" type="int" value="16787554"/>
		<constant name="GDK_KEY_braille_dots_2678" type="int" value="16787682"/>
		<constant name="GDK_KEY_braille_dots_268" type="int" value="16787618"/>
		<constant name="GDK_KEY_braille_dots_27" type="int" value="16787522"/>
		<constant name="GDK_KEY_braille_dots_278" type="int" value="16787650"/>
		<constant name="GDK_KEY_braille_dots_28" type="int" value="16787586"/>
		<constant name="GDK_KEY_braille_dots_3" type="int" value="16787460"/>
		<constant name="GDK_KEY_braille_dots_34" type="int" value="16787468"/>
		<constant name="GDK_KEY_braille_dots_345" type="int" value="16787484"/>
		<constant name="GDK_KEY_braille_dots_3456" type="int" value="16787516"/>
		<constant name="GDK_KEY_braille_dots_34567" type="int" value="16787580"/>
		<constant name="GDK_KEY_braille_dots_345678" type="int" value="16787708"/>
		<constant name="GDK_KEY_braille_dots_34568" type="int" value="16787644"/>
		<constant name="GDK_KEY_braille_dots_3457" type="int" value="16787548"/>
		<constant name="GDK_KEY_braille_dots_34578" type="int" value="16787676"/>
		<constant name="GDK_KEY_braille_dots_3458" type="int" value="16787612"/>
		<constant name="GDK_KEY_braille_dots_346" type="int" value="16787500"/>
		<constant name="GDK_KEY_braille_dots_3467" type="int" value="16787564"/>
		<constant name="GDK_KEY_braille_dots_34678" type="int" value="16787692"/>
		<constant name="GDK_KEY_braille_dots_3468" type="int" value="16787628"/>
		<constant name="GDK_KEY_braille_dots_347" type="int" value="16787532"/>
		<constant name="GDK_KEY_braille_dots_3478" type="int" value="16787660"/>
		<constant name="GDK_KEY_braille_dots_348" type="int" value="16787596"/>
		<constant name="GDK_KEY_braille_dots_35" type="int" value="16787476"/>
		<constant name="GDK_KEY_braille_dots_356" type="int" value="16787508"/>
		<constant name="GDK_KEY_braille_dots_3567" type="int" value="16787572"/>
		<constant name="GDK_KEY_braille_dots_35678" type="int" value="16787700"/>
		<constant name="GDK_KEY_braille_dots_3568" type="int" value="16787636"/>
		<constant name="GDK_KEY_braille_dots_357" type="int" value="16787540"/>
		<constant name="GDK_KEY_braille_dots_3578" type="int" value="16787668"/>
		<constant name="GDK_KEY_braille_dots_358" type="int" value="16787604"/>
		<constant name="GDK_KEY_braille_dots_36" type="int" value="16787492"/>
		<constant name="GDK_KEY_braille_dots_367" type="int" value="16787556"/>
		<constant name="GDK_KEY_braille_dots_3678" type="int" value="16787684"/>
		<constant name="GDK_KEY_braille_dots_368" type="int" value="16787620"/>
		<constant name="GDK_KEY_braille_dots_37" type="int" value="16787524"/>
		<constant name="GDK_KEY_braille_dots_378" type="int" value="16787652"/>
		<constant name="GDK_KEY_braille_dots_38" type="int" value="16787588"/>
		<constant name="GDK_KEY_braille_dots_4" type="int" value="16787464"/>
		<constant name="GDK_KEY_braille_dots_45" type="int" value="16787480"/>
		<constant name="GDK_KEY_braille_dots_456" type="int" value="16787512"/>
		<constant name="GDK_KEY_braille_dots_4567" type="int" value="16787576"/>
		<constant name="GDK_KEY_braille_dots_45678" type="int" value="16787704"/>
		<constant name="GDK_KEY_braille_dots_4568" type="int" value="16787640"/>
		<constant name="GDK_KEY_braille_dots_457" type="int" value="16787544"/>
		<constant name="GDK_KEY_braille_dots_4578" type="int" value="16787672"/>
		<constant name="GDK_KEY_braille_dots_458" type="int" value="16787608"/>
		<constant name="GDK_KEY_braille_dots_46" type="int" value="16787496"/>
		<constant name="GDK_KEY_braille_dots_467" type="int" value="16787560"/>
		<constant name="GDK_KEY_braille_dots_4678" type="int" value="16787688"/>
		<constant name="GDK_KEY_braille_dots_468" type="int" value="16787624"/>
		<constant name="GDK_KEY_braille_dots_47" type="int" value="16787528"/>
		<constant name="GDK_KEY_braille_dots_478" type="int" value="16787656"/>
		<constant name="GDK_KEY_braille_dots_48" type="int" value="16787592"/>
		<constant name="GDK_KEY_braille_dots_5" type="int" value="16787472"/>
		<constant name="GDK_KEY_braille_dots_56" type="int" value="16787504"/>
		<constant name="GDK_KEY_braille_dots_567" type="int" value="16787568"/>
		<constant name="GDK_KEY_braille_dots_5678" type="int" value="16787696"/>
		<constant name="GDK_KEY_braille_dots_568" type="int" value="16787632"/>
		<constant name="GDK_KEY_braille_dots_57" type="int" value="16787536"/>
		<constant name="GDK_KEY_braille_dots_578" type="int" value="16787664"/>
		<constant name="GDK_KEY_braille_dots_58" type="int" value="16787600"/>
		<constant name="GDK_KEY_braille_dots_6" type="int" value="16787488"/>
		<constant name="GDK_KEY_braille_dots_67" type="int" value="16787552"/>
		<constant name="GDK_KEY_braille_dots_678" type="int" value="16787680"/>
		<constant name="GDK_KEY_braille_dots_68" type="int" value="16787616"/>
		<constant name="GDK_KEY_braille_dots_7" type="int" value="16787520"/>
		<constant name="GDK_KEY_braille_dots_78" type="int" value="16787648"/>
		<constant name="GDK_KEY_braille_dots_8" type="int" value="16787584"/>
		<constant name="GDK_KEY_breve" type="int" value="418"/>
		<constant name="GDK_KEY_brokenbar" type="int" value="166"/>
		<constant name="GDK_KEY_c" type="int" value="99"/>
		<constant name="GDK_KEY_cabovedot" type="int" value="741"/>
		<constant name="GDK_KEY_cacute" type="int" value="486"/>
		<constant name="GDK_KEY_careof" type="int" value="2744"/>
		<constant name="GDK_KEY_caret" type="int" value="2812"/>
		<constant name="GDK_KEY_caron" type="int" value="439"/>
		<constant name="GDK_KEY_ccaron" type="int" value="488"/>
		<constant name="GDK_KEY_ccedilla" type="int" value="231"/>
		<constant name="GDK_KEY_ccircumflex" type="int" value="742"/>
		<constant name="GDK_KEY_cedilla" type="int" value="184"/>
		<constant name="GDK_KEY_cent" type="int" value="162"/>
		<constant name="GDK_KEY_checkerboard" type="int" value="2529"/>
		<constant name="GDK_KEY_checkmark" type="int" value="2803"/>
		<constant name="GDK_KEY_circle" type="int" value="3023"/>
		<constant name="GDK_KEY_club" type="int" value="2796"/>
		<constant name="GDK_KEY_colon" type="int" value="58"/>
		<constant name="GDK_KEY_comma" type="int" value="44"/>
		<constant name="GDK_KEY_containsas" type="int" value="16785931"/>
		<constant name="GDK_KEY_copyright" type="int" value="169"/>
		<constant name="GDK_KEY_cr" type="int" value="2532"/>
		<constant name="GDK_KEY_crossinglines" type="int" value="2542"/>
		<constant name="GDK_KEY_cuberoot" type="int" value="16785947"/>
		<constant name="GDK_KEY_currency" type="int" value="164"/>
		<constant name="GDK_KEY_cursor" type="int" value="2815"/>
		<constant name="GDK_KEY_d" type="int" value="100"/>
		<constant name="GDK_KEY_dabovedot" type="int" value="16784907"/>
		<constant name="GDK_KEY_dagger" type="int" value="2801"/>
		<constant name="GDK_KEY_dcaron" type="int" value="495"/>
		<constant name="GDK_KEY_dead_A" type="int" value="65153"/>
		<constant name="GDK_KEY_dead_E" type="int" value="65155"/>
		<constant name="GDK_KEY_dead_I" type="int" value="65157"/>
		<constant name="GDK_KEY_dead_O" type="int" value="65159"/>
		<constant name="GDK_KEY_dead_U" type="int" value="65161"/>
		<constant name="GDK_KEY_dead_a" type="int" value="65152"/>
		<constant name="GDK_KEY_dead_abovecomma" type="int" value="65124"/>
		<constant name="GDK_KEY_dead_abovedot" type="int" value="65110"/>
		<constant name="GDK_KEY_dead_abovereversedcomma" type="int" value="65125"/>
		<constant name="GDK_KEY_dead_abovering" type="int" value="65112"/>
		<constant name="GDK_KEY_dead_acute" type="int" value="65105"/>
		<constant name="GDK_KEY_dead_belowbreve" type="int" value="65131"/>
		<constant name="GDK_KEY_dead_belowcircumflex" type="int" value="65129"/>
		<constant name="GDK_KEY_dead_belowcomma" type="int" value="65134"/>
		<constant name="GDK_KEY_dead_belowdiaeresis" type="int" value="65132"/>
		<constant name="GDK_KEY_dead_belowdot" type="int" value="65120"/>
		<constant name="GDK_KEY_dead_belowmacron" type="int" value="65128"/>
		<constant name="GDK_KEY_dead_belowring" type="int" value="65127"/>
		<constant name="GDK_KEY_dead_belowtilde" type="int" value="65130"/>
		<constant name="GDK_KEY_dead_breve" type="int" value="65109"/>
		<constant name="GDK_KEY_dead_capital_schwa" type="int" value="65163"/>
		<constant name="GDK_KEY_dead_caron" type="int" value="65114"/>
		<constant name="GDK_KEY_dead_cedilla" type="int" value="65115"/>
		<constant name="GDK_KEY_dead_circumflex" type="int" value="65106"/>
		<constant name="GDK_KEY_dead_currency" type="int" value="65135"/>
		<constant name="GDK_KEY_dead_dasia" type="int" value="65125"/>
		<constant name="GDK_KEY_dead_diaeresis" type="int" value="65111"/>
		<constant name="GDK_KEY_dead_doubleacute" type="int" value="65113"/>
		<constant name="GDK_KEY_dead_doublegrave" type="int" value="65126"/>
		<constant name="GDK_KEY_dead_e" type="int" value="65154"/>
		<constant name="GDK_KEY_dead_grave" type="int" value="65104"/>
		<constant name="GDK_KEY_dead_hook" type="int" value="65121"/>
		<constant name="GDK_KEY_dead_horn" type="int" value="65122"/>
		<constant name="GDK_KEY_dead_i" type="int" value="65156"/>
		<constant name="GDK_KEY_dead_invertedbreve" type="int" value="65133"/>
		<constant name="GDK_KEY_dead_iota" type="int" value="65117"/>
		<constant name="GDK_KEY_dead_macron" type="int" value="65108"/>
		<constant name="GDK_KEY_dead_o" type="int" value="65158"/>
		<constant name="GDK_KEY_dead_ogonek" type="int" value="65116"/>
		<constant name="GDK_KEY_dead_perispomeni" type="int" value="65107"/>
		<constant name="GDK_KEY_dead_psili" type="int" value="65124"/>
		<constant name="GDK_KEY_dead_semivoiced_sound" type="int" value="65119"/>
		<constant name="GDK_KEY_dead_small_schwa" type="int" value="65162"/>
		<constant name="GDK_KEY_dead_stroke" type="int" value="65123"/>
		<constant name="GDK_KEY_dead_tilde" type="int" value="65107"/>
		<constant name="GDK_KEY_dead_u" type="int" value="65160"/>
		<constant name="GDK_KEY_dead_voiced_sound" type="int" value="65118"/>
		<constant name="GDK_KEY_decimalpoint" type="int" value="2749"/>
		<constant name="GDK_KEY_degree" type="int" value="176"/>
		<constant name="GDK_KEY_diaeresis" type="int" value="168"/>
		<constant name="GDK_KEY_diamond" type="int" value="2797"/>
		<constant name="GDK_KEY_digitspace" type="int" value="2725"/>
		<constant name="GDK_KEY_dintegral" type="int" value="16785964"/>
		<constant name="GDK_KEY_division" type="int" value="247"/>
		<constant name="GDK_KEY_dollar" type="int" value="36"/>
		<constant name="GDK_KEY_doubbaselinedot" type="int" value="2735"/>
		<constant name="GDK_KEY_doubleacute" type="int" value="445"/>
		<constant name="GDK_KEY_doubledagger" type="int" value="2802"/>
		<constant name="GDK_KEY_doublelowquotemark" type="int" value="2814"/>
		<constant name="GDK_KEY_downarrow" type="int" value="2302"/>
		<constant name="GDK_KEY_downcaret" type="int" value="2984"/>
		<constant name="GDK_KEY_downshoe" type="int" value="3030"/>
		<constant name="GDK_KEY_downstile" type="int" value="3012"/>
		<constant name="GDK_KEY_downtack" type="int" value="3010"/>
		<constant name="GDK_KEY_dstroke" type="int" value="496"/>
		<constant name="GDK_KEY_e" type="int" value="101"/>
		<constant name="GDK_KEY_eabovedot" type="int" value="1004"/>
		<constant name="GDK_KEY_eacute" type="int" value="233"/>
		<constant name="GDK_KEY_ebelowdot" type="int" value="16785081"/>
		<constant name="GDK_KEY_ecaron" type="int" value="492"/>
		<constant name="GDK_KEY_ecircumflex" type="int" value="234"/>
		<constant name="GDK_KEY_ecircumflexacute" type="int" value="16785087"/>
		<constant name="GDK_KEY_ecircumflexbelowdot" type="int" value="16785095"/>
		<constant name="GDK_KEY_ecircumflexgrave" type="int" value="16785089"/>
		<constant name="GDK_KEY_ecircumflexhook" type="int" value="16785091"/>
		<constant name="GDK_KEY_ecircumflextilde" type="int" value="16785093"/>
		<constant name="GDK_KEY_ediaeresis" type="int" value="235"/>
		<constant name="GDK_KEY_egrave" type="int" value="232"/>
		<constant name="GDK_KEY_ehook" type="int" value="16785083"/>
		<constant name="GDK_KEY_eightsubscript" type="int" value="16785544"/>
		<constant name="GDK_KEY_eightsuperior" type="int" value="16785528"/>
		<constant name="GDK_KEY_elementof" type="int" value="16785928"/>
		<constant name="GDK_KEY_ellipsis" type="int" value="2734"/>
		<constant name="GDK_KEY_em3space" type="int" value="2723"/>
		<constant name="GDK_KEY_em4space" type="int" value="2724"/>
		<constant name="GDK_KEY_emacron" type="int" value="954"/>
		<constant name="GDK_KEY_emdash" type="int" value="2729"/>
		<constant name="GDK_KEY_emfilledcircle" type="int" value="2782"/>
		<constant name="GDK_KEY_emfilledrect" type="int" value="2783"/>
		<constant name="GDK_KEY_emopencircle" type="int" value="2766"/>
		<constant name="GDK_KEY_emopenrectangle" type="int" value="2767"/>
		<constant name="GDK_KEY_emptyset" type="int" value="16785925"/>
		<constant name="GDK_KEY_emspace" type="int" value="2721"/>
		<constant name="GDK_KEY_endash" type="int" value="2730"/>
		<constant name="GDK_KEY_enfilledcircbullet" type="int" value="2790"/>
		<constant name="GDK_KEY_enfilledsqbullet" type="int" value="2791"/>
		<constant name="GDK_KEY_eng" type="int" value="959"/>
		<constant name="GDK_KEY_enopencircbullet" type="int" value="2784"/>
		<constant name="GDK_KEY_enopensquarebullet" type="int" value="2785"/>
		<constant name="GDK_KEY_enspace" type="int" value="2722"/>
		<constant name="GDK_KEY_eogonek" type="int" value="490"/>
		<constant name="GDK_KEY_equal" type="int" value="61"/>
		<constant name="GDK_KEY_eth" type="int" value="240"/>
		<constant name="GDK_KEY_etilde" type="int" value="16785085"/>
		<constant name="GDK_KEY_exclam" type="int" value="33"/>
		<constant name="GDK_KEY_exclamdown" type="int" value="161"/>
		<constant name="GDK_KEY_f" type="int" value="102"/>
		<constant name="GDK_KEY_fabovedot" type="int" value="16784927"/>
		<constant name="GDK_KEY_femalesymbol" type="int" value="2808"/>
		<constant name="GDK_KEY_ff" type="int" value="2531"/>
		<constant name="GDK_KEY_figdash" type="int" value="2747"/>
		<constant name="GDK_KEY_filledlefttribullet" type="int" value="2780"/>
		<constant name="GDK_KEY_filledrectbullet" type="int" value="2779"/>
		<constant name="GDK_KEY_filledrighttribullet" type="int" value="2781"/>
		<constant name="GDK_KEY_filledtribulletdown" type="int" value="2793"/>
		<constant name="GDK_KEY_filledtribulletup" type="int" value="2792"/>
		<constant name="GDK_KEY_fiveeighths" type="int" value="2757"/>
		<constant name="GDK_KEY_fivesixths" type="int" value="2743"/>
		<constant name="GDK_KEY_fivesubscript" type="int" value="16785541"/>
		<constant name="GDK_KEY_fivesuperior" type="int" value="16785525"/>
		<constant name="GDK_KEY_fourfifths" type="int" value="2741"/>
		<constant name="GDK_KEY_foursubscript" type="int" value="16785540"/>
		<constant name="GDK_KEY_foursuperior" type="int" value="16785524"/>
		<constant name="GDK_KEY_fourthroot" type="int" value="16785948"/>
		<constant name="GDK_KEY_function" type="int" value="2294"/>
		<constant name="GDK_KEY_g" type="int" value="103"/>
		<constant name="GDK_KEY_gabovedot" type="int" value="757"/>
		<constant name="GDK_KEY_gbreve" type="int" value="699"/>
		<constant name="GDK_KEY_gcaron" type="int" value="16777703"/>
		<constant name="GDK_KEY_gcedilla" type="int" value="955"/>
		<constant name="GDK_KEY_gcircumflex" type="int" value="760"/>
		<constant name="GDK_KEY_grave" type="int" value="96"/>
		<constant name="GDK_KEY_greater" type="int" value="62"/>
		<constant name="GDK_KEY_greaterthanequal" type="int" value="2238"/>
		<constant name="GDK_KEY_guillemotleft" type="int" value="171"/>
		<constant name="GDK_KEY_guillemotright" type="int" value="187"/>
		<constant name="GDK_KEY_h" type="int" value="104"/>
		<constant name="GDK_KEY_hairspace" type="int" value="2728"/>
		<constant name="GDK_KEY_hcircumflex" type="int" value="694"/>
		<constant name="GDK_KEY_heart" type="int" value="2798"/>
		<constant name="GDK_KEY_hebrew_aleph" type="int" value="3296"/>
		<constant name="GDK_KEY_hebrew_ayin" type="int" value="3314"/>
		<constant name="GDK_KEY_hebrew_bet" type="int" value="3297"/>
		<constant name="GDK_KEY_hebrew_beth" type="int" value="3297"/>
		<constant name="GDK_KEY_hebrew_chet" type="int" value="3303"/>
		<constant name="GDK_KEY_hebrew_dalet" type="int" value="3299"/>
		<constant name="GDK_KEY_hebrew_daleth" type="int" value="3299"/>
		<constant name="GDK_KEY_hebrew_doublelowline" type="int" value="3295"/>
		<constant name="GDK_KEY_hebrew_finalkaph" type="int" value="3306"/>
		<constant name="GDK_KEY_hebrew_finalmem" type="int" value="3309"/>
		<constant name="GDK_KEY_hebrew_finalnun" type="int" value="3311"/>
		<constant name="GDK_KEY_hebrew_finalpe" type="int" value="3315"/>
		<constant name="GDK_KEY_hebrew_finalzade" type="int" value="3317"/>
		<constant name="GDK_KEY_hebrew_finalzadi" type="int" value="3317"/>
		<constant name="GDK_KEY_hebrew_gimel" type="int" value="3298"/>
		<constant name="GDK_KEY_hebrew_gimmel" type="int" value="3298"/>
		<constant name="GDK_KEY_hebrew_he" type="int" value="3300"/>
		<constant name="GDK_KEY_hebrew_het" type="int" value="3303"/>
		<constant name="GDK_KEY_hebrew_kaph" type="int" value="3307"/>
		<constant name="GDK_KEY_hebrew_kuf" type="int" value="3319"/>
		<constant name="GDK_KEY_hebrew_lamed" type="int" value="3308"/>
		<constant name="GDK_KEY_hebrew_mem" type="int" value="3310"/>
		<constant name="GDK_KEY_hebrew_nun" type="int" value="3312"/>
		<constant name="GDK_KEY_hebrew_pe" type="int" value="3316"/>
		<constant name="GDK_KEY_hebrew_qoph" type="int" value="3319"/>
		<constant name="GDK_KEY_hebrew_resh" type="int" value="3320"/>
		<constant name="GDK_KEY_hebrew_samech" type="int" value="3313"/>
		<constant name="GDK_KEY_hebrew_samekh" type="int" value="3313"/>
		<constant name="GDK_KEY_hebrew_shin" type="int" value="3321"/>
		<constant name="GDK_KEY_hebrew_taf" type="int" value="3322"/>
		<constant name="GDK_KEY_hebrew_taw" type="int" value="3322"/>
		<constant name="GDK_KEY_hebrew_tet" type="int" value="3304"/>
		<constant name="GDK_KEY_hebrew_teth" type="int" value="3304"/>
		<constant name="GDK_KEY_hebrew_waw" type="int" value="3301"/>
		<constant name="GDK_KEY_hebrew_yod" type="int" value="3305"/>
		<constant name="GDK_KEY_hebrew_zade" type="int" value="3318"/>
		<constant name="GDK_KEY_hebrew_zadi" type="int" value="3318"/>
		<constant name="GDK_KEY_hebrew_zain" type="int" value="3302"/>
		<constant name="GDK_KEY_hebrew_zayin" type="int" value="3302"/>
		<constant name="GDK_KEY_hexagram" type="int" value="2778"/>
		<constant name="GDK_KEY_horizconnector" type="int" value="2211"/>
		<constant name="GDK_KEY_horizlinescan1" type="int" value="2543"/>
		<constant name="GDK_KEY_horizlinescan3" type="int" value="2544"/>
		<constant name="GDK_KEY_horizlinescan5" type="int" value="2545"/>
		<constant name="GDK_KEY_horizlinescan7" type="int" value="2546"/>
		<constant name="GDK_KEY_horizlinescan9" type="int" value="2547"/>
		<constant name="GDK_KEY_hstroke" type="int" value="689"/>
		<constant name="GDK_KEY_ht" type="int" value="2530"/>
		<constant name="GDK_KEY_hyphen" type="int" value="173"/>
		<constant name="GDK_KEY_i" type="int" value="105"/>
		<constant name="GDK_KEY_iTouch" type="int" value="269025120"/>
		<constant name="GDK_KEY_iacute" type="int" value="237"/>
		<constant name="GDK_KEY_ibelowdot" type="int" value="16785099"/>
		<constant name="GDK_KEY_ibreve" type="int" value="16777517"/>
		<constant name="GDK_KEY_icircumflex" type="int" value="238"/>
		<constant name="GDK_KEY_identical" type="int" value="2255"/>
		<constant name="GDK_KEY_idiaeresis" type="int" value="239"/>
		<constant name="GDK_KEY_idotless" type="int" value="697"/>
		<constant name="GDK_KEY_ifonlyif" type="int" value="2253"/>
		<constant name="GDK_KEY_igrave" type="int" value="236"/>
		<constant name="GDK_KEY_ihook" type="int" value="16785097"/>
		<constant name="GDK_KEY_imacron" type="int" value="1007"/>
		<constant name="GDK_KEY_implies" type="int" value="2254"/>
		<constant name="GDK_KEY_includedin" type="int" value="2266"/>
		<constant name="GDK_KEY_includes" type="int" value="2267"/>
		<constant name="GDK_KEY_infinity" type="int" value="2242"/>
		<constant name="GDK_KEY_integral" type="int" value="2239"/>
		<constant name="GDK_KEY_intersection" type="int" value="2268"/>
		<constant name="GDK_KEY_iogonek" type="int" value="999"/>
		<constant name="GDK_KEY_itilde" type="int" value="949"/>
		<constant name="GDK_KEY_j" type="int" value="106"/>
		<constant name="GDK_KEY_jcircumflex" type="int" value="700"/>
		<constant name="GDK_KEY_jot" type="int" value="3018"/>
		<constant name="GDK_KEY_k" type="int" value="107"/>
		<constant name="GDK_KEY_kana_A" type="int" value="1201"/>
		<constant name="GDK_KEY_kana_CHI" type="int" value="1217"/>
		<constant name="GDK_KEY_kana_E" type="int" value="1204"/>
		<constant name="GDK_KEY_kana_FU" type="int" value="1228"/>
		<constant name="GDK_KEY_kana_HA" type="int" value="1226"/>
		<constant name="GDK_KEY_kana_HE" type="int" value="1229"/>
		<constant name="GDK_KEY_kana_HI" type="int" value="1227"/>
		<constant name="GDK_KEY_kana_HO" type="int" value="1230"/>
		<constant name="GDK_KEY_kana_HU" type="int" value="1228"/>
		<constant name="GDK_KEY_kana_I" type="int" value="1202"/>
		<constant name="GDK_KEY_kana_KA" type="int" value="1206"/>
		<constant name="GDK_KEY_kana_KE" type="int" value="1209"/>
		<constant name="GDK_KEY_kana_KI" type="int" value="1207"/>
		<constant name="GDK_KEY_kana_KO" type="int" value="1210"/>
		<constant name="GDK_KEY_kana_KU" type="int" value="1208"/>
		<constant name="GDK_KEY_kana_MA" type="int" value="1231"/>
		<constant name="GDK_KEY_kana_ME" type="int" value="1234"/>
		<constant name="GDK_KEY_kana_MI" type="int" value="1232"/>
		<constant name="GDK_KEY_kana_MO" type="int" value="1235"/>
		<constant name="GDK_KEY_kana_MU" type="int" value="1233"/>
		<constant name="GDK_KEY_kana_N" type="int" value="1245"/>
		<constant name="GDK_KEY_kana_NA" type="int" value="1221"/>
		<constant name="GDK_KEY_kana_NE" type="int" value="1224"/>
		<constant name="GDK_KEY_kana_NI" type="int" value="1222"/>
		<constant name="GDK_KEY_kana_NO" type="int" value="1225"/>
		<constant name="GDK_KEY_kana_NU" type="int" value="1223"/>
		<constant name="GDK_KEY_kana_O" type="int" value="1205"/>
		<constant name="GDK_KEY_kana_RA" type="int" value="1239"/>
		<constant name="GDK_KEY_kana_RE" type="int" value="1242"/>
		<constant name="GDK_KEY_kana_RI" type="int" value="1240"/>
		<constant name="GDK_KEY_kana_RO" type="int" value="1243"/>
		<constant name="GDK_KEY_kana_RU" type="int" value="1241"/>
		<constant name="GDK_KEY_kana_SA" type="int" value="1211"/>
		<constant name="GDK_KEY_kana_SE" type="int" value="1214"/>
		<constant name="GDK_KEY_kana_SHI" type="int" value="1212"/>
		<constant name="GDK_KEY_kana_SO" type="int" value="1215"/>
		<constant name="GDK_KEY_kana_SU" type="int" value="1213"/>
		<constant name="GDK_KEY_kana_TA" type="int" value="1216"/>
		<constant name="GDK_KEY_kana_TE" type="int" value="1219"/>
		<constant name="GDK_KEY_kana_TI" type="int" value="1217"/>
		<constant name="GDK_KEY_kana_TO" type="int" value="1220"/>
		<constant name="GDK_KEY_kana_TSU" type="int" value="1218"/>
		<constant name="GDK_KEY_kana_TU" type="int" value="1218"/>
		<constant name="GDK_KEY_kana_U" type="int" value="1203"/>
		<constant name="GDK_KEY_kana_WA" type="int" value="1244"/>
		<constant name="GDK_KEY_kana_WO" type="int" value="1190"/>
		<constant name="GDK_KEY_kana_YA" type="int" value="1236"/>
		<constant name="GDK_KEY_kana_YO" type="int" value="1238"/>
		<constant name="GDK_KEY_kana_YU" type="int" value="1237"/>
		<constant name="GDK_KEY_kana_a" type="int" value="1191"/>
		<constant name="GDK_KEY_kana_closingbracket" type="int" value="1187"/>
		<constant name="GDK_KEY_kana_comma" type="int" value="1188"/>
		<constant name="GDK_KEY_kana_conjunctive" type="int" value="1189"/>
		<constant name="GDK_KEY_kana_e" type="int" value="1194"/>
		<constant name="GDK_KEY_kana_fullstop" type="int" value="1185"/>
		<constant name="GDK_KEY_kana_i" type="int" value="1192"/>
		<constant name="GDK_KEY_kana_middledot" type="int" value="1189"/>
		<constant name="GDK_KEY_kana_o" type="int" value="1195"/>
		<constant name="GDK_KEY_kana_openingbracket" type="int" value="1186"/>
		<constant name="GDK_KEY_kana_switch" type="int" value="65406"/>
		<constant name="GDK_KEY_kana_tsu" type="int" value="1199"/>
		<constant name="GDK_KEY_kana_tu" type="int" value="1199"/>
		<constant name="GDK_KEY_kana_u" type="int" value="1193"/>
		<constant name="GDK_KEY_kana_ya" type="int" value="1196"/>
		<constant name="GDK_KEY_kana_yo" type="int" value="1198"/>
		<constant name="GDK_KEY_kana_yu" type="int" value="1197"/>
		<constant name="GDK_KEY_kappa" type="int" value="930"/>
		<constant name="GDK_KEY_kcedilla" type="int" value="1011"/>
		<constant name="GDK_KEY_kra" type="int" value="930"/>
		<constant name="GDK_KEY_l" type="int" value="108"/>
		<constant name="GDK_KEY_lacute" type="int" value="485"/>
		<constant name="GDK_KEY_latincross" type="int" value="2777"/>
		<constant name="GDK_KEY_lbelowdot" type="int" value="16784951"/>
		<constant name="GDK_KEY_lcaron" type="int" value="437"/>
		<constant name="GDK_KEY_lcedilla" type="int" value="950"/>
		<constant name="GDK_KEY_leftanglebracket" type="int" value="2748"/>
		<constant name="GDK_KEY_leftarrow" type="int" value="2299"/>
		<constant name="GDK_KEY_leftcaret" type="int" value="2979"/>
		<constant name="GDK_KEY_leftdoublequotemark" type="int" value="2770"/>
		<constant name="GDK_KEY_leftmiddlecurlybrace" type="int" value="2223"/>
		<constant name="GDK_KEY_leftopentriangle" type="int" value="2764"/>
		<constant name="GDK_KEY_leftpointer" type="int" value="2794"/>
		<constant name="GDK_KEY_leftradical" type="int" value="2209"/>
		<constant name="GDK_KEY_leftshoe" type="int" value="3034"/>
		<constant name="GDK_KEY_leftsinglequotemark" type="int" value="2768"/>
		<constant name="GDK_KEY_leftt" type="int" value="2548"/>
		<constant name="GDK_KEY_lefttack" type="int" value="3036"/>
		<constant name="GDK_KEY_less" type="int" value="60"/>
		<constant name="GDK_KEY_lessthanequal" type="int" value="2236"/>
		<constant name="GDK_KEY_lf" type="int" value="2533"/>
		<constant name="GDK_KEY_logicaland" type="int" value="2270"/>
		<constant name="GDK_KEY_logicalor" type="int" value="2271"/>
		<constant name="GDK_KEY_lowleftcorner" type="int" value="2541"/>
		<constant name="GDK_KEY_lowrightcorner" type="int" value="2538"/>
		<constant name="GDK_KEY_lstroke" type="int" value="435"/>
		<constant name="GDK_KEY_m" type="int" value="109"/>
		<constant name="GDK_KEY_mabovedot" type="int" value="16784961"/>
		<constant name="GDK_KEY_macron" type="int" value="175"/>
		<constant name="GDK_KEY_malesymbol" type="int" value="2807"/>
		<constant name="GDK_KEY_maltesecross" type="int" value="2800"/>
		<constant name="GDK_KEY_marker" type="int" value="2751"/>
		<constant name="GDK_KEY_masculine" type="int" value="186"/>
		<constant name="GDK_KEY_minus" type="int" value="45"/>
		<constant name="GDK_KEY_minutes" type="int" value="2774"/>
		<constant name="GDK_KEY_mu" type="int" value="181"/>
		<constant name="GDK_KEY_multiply" type="int" value="215"/>
		<constant name="GDK_KEY_musicalflat" type="int" value="2806"/>
		<constant name="GDK_KEY_musicalsharp" type="int" value="2805"/>
		<constant name="GDK_KEY_n" type="int" value="110"/>
		<constant name="GDK_KEY_nabla" type="int" value="2245"/>
		<constant name="GDK_KEY_nacute" type="int" value="497"/>
		<constant name="GDK_KEY_ncaron" type="int" value="498"/>
		<constant name="GDK_KEY_ncedilla" type="int" value="1009"/>
		<constant name="GDK_KEY_ninesubscript" type="int" value="16785545"/>
		<constant name="GDK_KEY_ninesuperior" type="int" value="16785529"/>
		<constant name="GDK_KEY_nl" type="int" value="2536"/>
		<constant name="GDK_KEY_nobreakspace" type="int" value="160"/>
		<constant name="GDK_KEY_notapproxeq" type="int" value="16785991"/>
		<constant name="GDK_KEY_notelementof" type="int" value="16785929"/>
		<constant name="GDK_KEY_notequal" type="int" value="2237"/>
		<constant name="GDK_KEY_notidentical" type="int" value="16786018"/>
		<constant name="GDK_KEY_notsign" type="int" value="172"/>
		<constant name="GDK_KEY_ntilde" type="int" value="241"/>
		<constant name="GDK_KEY_numbersign" type="int" value="35"/>
		<constant name="GDK_KEY_numerosign" type="int" value="1712"/>
		<constant name="GDK_KEY_o" type="int" value="111"/>
		<constant name="GDK_KEY_oacute" type="int" value="243"/>
		<constant name="GDK_KEY_obarred" type="int" value="16777845"/>
		<constant name="GDK_KEY_obelowdot" type="int" value="16785101"/>
		<constant name="GDK_KEY_ocaron" type="int" value="16777682"/>
		<constant name="GDK_KEY_ocircumflex" type="int" value="244"/>
		<constant name="GDK_KEY_ocircumflexacute" type="int" value="16785105"/>
		<constant name="GDK_KEY_ocircumflexbelowdot" type="int" value="16785113"/>
		<constant name="GDK_KEY_ocircumflexgrave" type="int" value="16785107"/>
		<constant name="GDK_KEY_ocircumflexhook" type="int" value="16785109"/>
		<constant name="GDK_KEY_ocircumflextilde" type="int" value="16785111"/>
		<constant name="GDK_KEY_odiaeresis" type="int" value="246"/>
		<constant name="GDK_KEY_odoubleacute" type="int" value="501"/>
		<constant name="GDK_KEY_oe" type="int" value="5053"/>
		<constant name="GDK_KEY_ogonek" type="int" value="434"/>
		<constant name="GDK_KEY_ograve" type="int" value="242"/>
		<constant name="GDK_KEY_ohook" type="int" value="16785103"/>
		<constant name="GDK_KEY_ohorn" type="int" value="16777633"/>
		<constant name="GDK_KEY_ohornacute" type="int" value="16785115"/>
		<constant name="GDK_KEY_ohornbelowdot" type="int" value="16785123"/>
		<constant name="GDK_KEY_ohorngrave" type="int" value="16785117"/>
		<constant name="GDK_KEY_ohornhook" type="int" value="16785119"/>
		<constant name="GDK_KEY_ohorntilde" type="int" value="16785121"/>
		<constant name="GDK_KEY_omacron" type="int" value="1010"/>
		<constant name="GDK_KEY_oneeighth" type="int" value="2755"/>
		<constant name="GDK_KEY_onefifth" type="int" value="2738"/>
		<constant name="GDK_KEY_onehalf" type="int" value="189"/>
		<constant name="GDK_KEY_onequarter" type="int" value="188"/>
		<constant name="GDK_KEY_onesixth" type="int" value="2742"/>
		<constant name="GDK_KEY_onesubscript" type="int" value="16785537"/>
		<constant name="GDK_KEY_onesuperior" type="int" value="185"/>
		<constant name="GDK_KEY_onethird" type="int" value="2736"/>
		<constant name="GDK_KEY_ooblique" type="int" value="248"/>
		<constant name="GDK_KEY_openrectbullet" type="int" value="2786"/>
		<constant name="GDK_KEY_openstar" type="int" value="2789"/>
		<constant name="GDK_KEY_opentribulletdown" type="int" value="2788"/>
		<constant name="GDK_KEY_opentribulletup" type="int" value="2787"/>
		<constant name="GDK_KEY_ordfeminine" type="int" value="170"/>
		<constant name="GDK_KEY_oslash" type="int" value="248"/>
		<constant name="GDK_KEY_otilde" type="int" value="245"/>
		<constant name="GDK_KEY_overbar" type="int" value="3008"/>
		<constant name="GDK_KEY_overline" type="int" value="1150"/>
		<constant name="GDK_KEY_p" type="int" value="112"/>
		<constant name="GDK_KEY_pabovedot" type="int" value="16784983"/>
		<constant name="GDK_KEY_paragraph" type="int" value="182"/>
		<constant name="GDK_KEY_parenleft" type="int" value="40"/>
		<constant name="GDK_KEY_parenright" type="int" value="41"/>
		<constant name="GDK_KEY_partdifferential" type="int" value="16785922"/>
		<constant name="GDK_KEY_partialderivative" type="int" value="2287"/>
		<constant name="GDK_KEY_percent" type="int" value="37"/>
		<constant name="GDK_KEY_period" type="int" value="46"/>
		<constant name="GDK_KEY_periodcentered" type="int" value="183"/>
		<constant name="GDK_KEY_phonographcopyright" type="int" value="2811"/>
		<constant name="GDK_KEY_plus" type="int" value="43"/>
		<constant name="GDK_KEY_plusminus" type="int" value="177"/>
		<constant name="GDK_KEY_prescription" type="int" value="2772"/>
		<constant name="GDK_KEY_prolongedsound" type="int" value="1200"/>
		<constant name="GDK_KEY_punctspace" type="int" value="2726"/>
		<constant name="GDK_KEY_q" type="int" value="113"/>
		<constant name="GDK_KEY_quad" type="int" value="3020"/>
		<constant name="GDK_KEY_question" type="int" value="63"/>
		<constant name="GDK_KEY_questiondown" type="int" value="191"/>
		<constant name="GDK_KEY_quotedbl" type="int" value="34"/>
		<constant name="GDK_KEY_quoteleft" type="int" value="96"/>
		<constant name="GDK_KEY_quoteright" type="int" value="39"/>
		<constant name="GDK_KEY_r" type="int" value="114"/>
		<constant name="GDK_KEY_racute" type="int" value="480"/>
		<constant name="GDK_KEY_radical" type="int" value="2262"/>
		<constant name="GDK_KEY_rcaron" type="int" value="504"/>
		<constant name="GDK_KEY_rcedilla" type="int" value="947"/>
		<constant name="GDK_KEY_registered" type="int" value="174"/>
		<constant name="GDK_KEY_rightanglebracket" type="int" value="2750"/>
		<constant name="GDK_KEY_rightarrow" type="int" value="2301"/>
		<constant name="GDK_KEY_rightcaret" type="int" value="2982"/>
		<constant name="GDK_KEY_rightdoublequotemark" type="int" value="2771"/>
		<constant name="GDK_KEY_rightmiddlecurlybrace" type="int" value="2224"/>
		<constant name="GDK_KEY_rightmiddlesummation" type="int" value="2231"/>
		<constant name="GDK_KEY_rightopentriangle" type="int" value="2765"/>
		<constant name="GDK_KEY_rightpointer" type="int" value="2795"/>
		<constant name="GDK_KEY_rightshoe" type="int" value="3032"/>
		<constant name="GDK_KEY_rightsinglequotemark" type="int" value="2769"/>
		<constant name="GDK_KEY_rightt" type="int" value="2549"/>
		<constant name="GDK_KEY_righttack" type="int" value="3068"/>
		<constant name="GDK_KEY_s" type="int" value="115"/>
		<constant name="GDK_KEY_sabovedot" type="int" value="16784993"/>
		<constant name="GDK_KEY_sacute" type="int" value="438"/>
		<constant name="GDK_KEY_scaron" type="int" value="441"/>
		<constant name="GDK_KEY_scedilla" type="int" value="442"/>
		<constant name="GDK_KEY_schwa" type="int" value="16777817"/>
		<constant name="GDK_KEY_scircumflex" type="int" value="766"/>
		<constant name="GDK_KEY_script_switch" type="int" value="65406"/>
		<constant name="GDK_KEY_seconds" type="int" value="2775"/>
		<constant name="GDK_KEY_section" type="int" value="167"/>
		<constant name="GDK_KEY_semicolon" type="int" value="59"/>
		<constant name="GDK_KEY_semivoicedsound" type="int" value="1247"/>
		<constant name="GDK_KEY_seveneighths" type="int" value="2758"/>
		<constant name="GDK_KEY_sevensubscript" type="int" value="16785543"/>
		<constant name="GDK_KEY_sevensuperior" type="int" value="16785527"/>
		<constant name="GDK_KEY_signaturemark" type="int" value="2762"/>
		<constant name="GDK_KEY_signifblank" type="int" value="2732"/>
		<constant name="GDK_KEY_similarequal" type="int" value="2249"/>
		<constant name="GDK_KEY_singlelowquotemark" type="int" value="2813"/>
		<constant name="GDK_KEY_sixsubscript" type="int" value="16785542"/>
		<constant name="GDK_KEY_sixsuperior" type="int" value="16785526"/>
		<constant name="GDK_KEY_slash" type="int" value="47"/>
		<constant name="GDK_KEY_soliddiamond" type="int" value="2528"/>
		<constant name="GDK_KEY_space" type="int" value="32"/>
		<constant name="GDK_KEY_squareroot" type="int" value="16785946"/>
		<constant name="GDK_KEY_ssharp" type="int" value="223"/>
		<constant name="GDK_KEY_sterling" type="int" value="163"/>
		<constant name="GDK_KEY_stricteq" type="int" value="16786019"/>
		<constant name="GDK_KEY_t" type="int" value="116"/>
		<constant name="GDK_KEY_tabovedot" type="int" value="16785003"/>
		<constant name="GDK_KEY_tcaron" type="int" value="443"/>
		<constant name="GDK_KEY_tcedilla" type="int" value="510"/>
		<constant name="GDK_KEY_telephone" type="int" value="2809"/>
		<constant name="GDK_KEY_telephonerecorder" type="int" value="2810"/>
		<constant name="GDK_KEY_therefore" type="int" value="2240"/>
		<constant name="GDK_KEY_thinspace" type="int" value="2727"/>
		<constant name="GDK_KEY_thorn" type="int" value="254"/>
		<constant name="GDK_KEY_threeeighths" type="int" value="2756"/>
		<constant name="GDK_KEY_threefifths" type="int" value="2740"/>
		<constant name="GDK_KEY_threequarters" type="int" value="190"/>
		<constant name="GDK_KEY_threesubscript" type="int" value="16785539"/>
		<constant name="GDK_KEY_threesuperior" type="int" value="179"/>
		<constant name="GDK_KEY_tintegral" type="int" value="16785965"/>
		<constant name="GDK_KEY_topintegral" type="int" value="2212"/>
		<constant name="GDK_KEY_topleftparens" type="int" value="2219"/>
		<constant name="GDK_KEY_topleftradical" type="int" value="2210"/>
		<constant name="GDK_KEY_topleftsqbracket" type="int" value="2215"/>
		<constant name="GDK_KEY_topleftsummation" type="int" value="2225"/>
		<constant name="GDK_KEY_toprightparens" type="int" value="2221"/>
		<constant name="GDK_KEY_toprightsqbracket" type="int" value="2217"/>
		<constant name="GDK_KEY_toprightsummation" type="int" value="2229"/>
		<constant name="GDK_KEY_topt" type="int" value="2551"/>
		<constant name="GDK_KEY_topvertsummationconnector" type="int" value="2227"/>
		<constant name="GDK_KEY_trademark" type="int" value="2761"/>
		<constant name="GDK_KEY_trademarkincircle" type="int" value="2763"/>
		<constant name="GDK_KEY_tslash" type="int" value="956"/>
		<constant name="GDK_KEY_twofifths" type="int" value="2739"/>
		<constant name="GDK_KEY_twosubscript" type="int" value="16785538"/>
		<constant name="GDK_KEY_twosuperior" type="int" value="178"/>
		<constant name="GDK_KEY_twothirds" type="int" value="2737"/>
		<constant name="GDK_KEY_u" type="int" value="117"/>
		<constant name="GDK_KEY_uacute" type="int" value="250"/>
		<constant name="GDK_KEY_ubelowdot" type="int" value="16785125"/>
		<constant name="GDK_KEY_ubreve" type="int" value="765"/>
		<constant name="GDK_KEY_ucircumflex" type="int" value="251"/>
		<constant name="GDK_KEY_udiaeresis" type="int" value="252"/>
		<constant name="GDK_KEY_udoubleacute" type="int" value="507"/>
		<constant name="GDK_KEY_ugrave" type="int" value="249"/>
		<constant name="GDK_KEY_uhook" type="int" value="16785127"/>
		<constant name="GDK_KEY_uhorn" type="int" value="16777648"/>
		<constant name="GDK_KEY_uhornacute" type="int" value="16785129"/>
		<constant name="GDK_KEY_uhornbelowdot" type="int" value="16785137"/>
		<constant name="GDK_KEY_uhorngrave" type="int" value="16785131"/>
		<constant name="GDK_KEY_uhornhook" type="int" value="16785133"/>
		<constant name="GDK_KEY_uhorntilde" type="int" value="16785135"/>
		<constant name="GDK_KEY_umacron" type="int" value="1022"/>
		<constant name="GDK_KEY_underbar" type="int" value="3014"/>
		<constant name="GDK_KEY_underscore" type="int" value="95"/>
		<constant name="GDK_KEY_union" type="int" value="2269"/>
		<constant name="GDK_KEY_uogonek" type="int" value="1017"/>
		<constant name="GDK_KEY_uparrow" type="int" value="2300"/>
		<constant name="GDK_KEY_upcaret" type="int" value="2985"/>
		<constant name="GDK_KEY_upleftcorner" type="int" value="2540"/>
		<constant name="GDK_KEY_uprightcorner" type="int" value="2539"/>
		<constant name="GDK_KEY_upshoe" type="int" value="3011"/>
		<constant name="GDK_KEY_upstile" type="int" value="3027"/>
		<constant name="GDK_KEY_uptack" type="int" value="3022"/>
		<constant name="GDK_KEY_uring" type="int" value="505"/>
		<constant name="GDK_KEY_utilde" type="int" value="1021"/>
		<constant name="GDK_KEY_v" type="int" value="118"/>
		<constant name="GDK_KEY_variation" type="int" value="2241"/>
		<constant name="GDK_KEY_vertbar" type="int" value="2552"/>
		<constant name="GDK_KEY_vertconnector" type="int" value="2214"/>
		<constant name="GDK_KEY_voicedsound" type="int" value="1246"/>
		<constant name="GDK_KEY_vt" type="int" value="2537"/>
		<constant name="GDK_KEY_w" type="int" value="119"/>
		<constant name="GDK_KEY_wacute" type="int" value="16785027"/>
		<constant name="GDK_KEY_wcircumflex" type="int" value="16777589"/>
		<constant name="GDK_KEY_wdiaeresis" type="int" value="16785029"/>
		<constant name="GDK_KEY_wgrave" type="int" value="16785025"/>
		<constant name="GDK_KEY_x" type="int" value="120"/>
		<constant name="GDK_KEY_xabovedot" type="int" value="16785035"/>
		<constant name="GDK_KEY_y" type="int" value="121"/>
		<constant name="GDK_KEY_yacute" type="int" value="253"/>
		<constant name="GDK_KEY_ybelowdot" type="int" value="16785141"/>
		<constant name="GDK_KEY_ycircumflex" type="int" value="16777591"/>
		<constant name="GDK_KEY_ydiaeresis" type="int" value="255"/>
		<constant name="GDK_KEY_yen" type="int" value="165"/>
		<constant name="GDK_KEY_ygrave" type="int" value="16785139"/>
		<constant name="GDK_KEY_yhook" type="int" value="16785143"/>
		<constant name="GDK_KEY_ytilde" type="int" value="16785145"/>
		<constant name="GDK_KEY_z" type="int" value="122"/>
		<constant name="GDK_KEY_zabovedot" type="int" value="447"/>
		<constant name="GDK_KEY_zacute" type="int" value="444"/>
		<constant name="GDK_KEY_zcaron" type="int" value="446"/>
		<constant name="GDK_KEY_zerosubscript" type="int" value="16785536"/>
		<constant name="GDK_KEY_zerosuperior" type="int" value="16785520"/>
		<constant name="GDK_KEY_zstroke" type="int" value="16777654"/>
		<constant name="GDK_MAX_TIMECOORD_AXES" type="int" value="128"/>
		<constant name="GDK_PARENT_RELATIVE" type="int" value="1"/>
		<constant name="GDK_PRIORITY_REDRAW" type="int" value="20"/>
	</namespace>
</api>
