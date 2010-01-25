<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Goo">
		<struct name="GooCanvasEllipseData">
			<field name="center_x" type="gdouble"/>
			<field name="center_y" type="gdouble"/>
			<field name="radius_x" type="gdouble"/>
			<field name="radius_y" type="gdouble"/>
		</struct>
		<struct name="GooCanvasGridData">
			<field name="x" type="gdouble"/>
			<field name="y" type="gdouble"/>
			<field name="width" type="gdouble"/>
			<field name="height" type="gdouble"/>
			<field name="x_step" type="gdouble"/>
			<field name="y_step" type="gdouble"/>
			<field name="x_offset" type="gdouble"/>
			<field name="y_offset" type="gdouble"/>
			<field name="horz_grid_line_width" type="gdouble"/>
			<field name="vert_grid_line_width" type="gdouble"/>
			<field name="horz_grid_line_pattern" type="cairo_pattern_t*"/>
			<field name="vert_grid_line_pattern" type="cairo_pattern_t*"/>
			<field name="border_width" type="gdouble"/>
			<field name="border_pattern" type="cairo_pattern_t*"/>
			<field name="show_horz_grid_lines" type="guint"/>
			<field name="show_vert_grid_lines" type="guint"/>
			<field name="vert_grid_lines_on_top" type="guint"/>
		</struct>
		<struct name="GooCanvasImageData">
			<field name="pattern" type="cairo_pattern_t*"/>
			<field name="x" type="gdouble"/>
			<field name="y" type="gdouble"/>
			<field name="width" type="gdouble"/>
			<field name="height" type="gdouble"/>
		</struct>
		<struct name="GooCanvasItemSimpleData">
			<field name="style" type="GooCanvasStyle*"/>
			<field name="transform" type="cairo_matrix_t*"/>
			<field name="clip_path_commands" type="GArray*"/>
			<field name="tooltip" type="gchar*"/>
			<field name="visibility_threshold" type="gdouble"/>
			<field name="visibility" type="guint"/>
			<field name="pointer_events" type="guint"/>
			<field name="can_focus" type="guint"/>
			<field name="own_style" type="guint"/>
			<field name="clip_fill_rule" type="guint"/>
			<field name="is_static" type="guint"/>
			<field name="cache_setting" type="guint"/>
			<field name="has_tooltip" type="guint"/>
		</struct>
		<struct name="GooCanvasPathData">
			<field name="path_commands" type="GArray*"/>
		</struct>
		<struct name="GooCanvasPolylineArrowData">
			<field name="arrow_width" type="gdouble"/>
			<field name="arrow_length" type="gdouble"/>
			<field name="arrow_tip_length" type="gdouble"/>
			<field name="line_start" type="gdouble[]"/>
			<field name="line_end" type="gdouble[]"/>
			<field name="start_arrow_coords" type="gdouble[]"/>
			<field name="end_arrow_coords" type="gdouble[]"/>
		</struct>
		<struct name="GooCanvasPolylineData">
			<field name="coords" type="gdouble*"/>
			<field name="arrow_data" type="GooCanvasPolylineArrowData*"/>
			<field name="num_points" type="guint"/>
			<field name="close_path" type="guint"/>
			<field name="start_arrow" type="guint"/>
			<field name="end_arrow" type="guint"/>
			<field name="reconfigure_arrows" type="guint"/>
		</struct>
		<struct name="GooCanvasRectData">
			<field name="x" type="gdouble"/>
			<field name="y" type="gdouble"/>
			<field name="width" type="gdouble"/>
			<field name="height" type="gdouble"/>
			<field name="radius_x" type="gdouble"/>
			<field name="radius_y" type="gdouble"/>
		</struct>
		<struct name="GooCanvasStyleProperty">
			<field name="id" type="GQuark"/>
			<field name="value" type="GValue"/>
		</struct>
		<struct name="GooCanvasTableData">
			<field name="width" type="gdouble"/>
			<field name="height" type="gdouble"/>
			<field name="dimensions" type="GooCanvasTableDimension[]"/>
			<field name="border_width" type="gdouble"/>
			<field name="children" type="GArray*"/>
			<field name="layout_data" type="GooCanvasTableLayoutData*"/>
		</struct>
		<struct name="GooCanvasTableDimension">
			<field name="size" type="gint"/>
			<field name="default_spacing" type="gdouble"/>
			<field name="spacings" type="gdouble*"/>
			<field name="homogeneous" type="guint"/>
		</struct>
		<struct name="GooCanvasTableLayoutData">
		</struct>
		<struct name="GooCanvasTextData">
			<field name="text" type="gchar*"/>
			<field name="x" type="gdouble"/>
			<field name="y" type="gdouble"/>
			<field name="width" type="gdouble"/>
			<field name="use_markup" type="guint"/>
			<field name="anchor" type="guint"/>
			<field name="alignment" type="guint"/>
			<field name="ellipsize" type="guint"/>
			<field name="wrap" type="guint"/>
		</struct>
		<boxed name="GooCairoMatrix" type-name="GooCairoMatrix" get-type="goo_cairo_matrix_get_type">
			<method name="copy" symbol="goo_cairo_matrix_copy">
				<return-type type="cairo_matrix_t*"/>
				<parameters>
					<parameter name="matrix" type="cairo_matrix_t*"/>
				</parameters>
			</method>
			<method name="free" symbol="goo_cairo_matrix_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="cairo_matrix_t*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="GooCairoPattern" type-name="GooCairoPattern" get-type="goo_cairo_pattern_get_type">
		</boxed>
		<boxed name="GooCanvasBounds" type-name="GooCanvasBounds" get-type="goo_canvas_bounds_get_type">
			<field name="x1" type="gdouble"/>
			<field name="y1" type="gdouble"/>
			<field name="x2" type="gdouble"/>
			<field name="y2" type="gdouble"/>
		</boxed>
		<boxed name="GooCanvasLineDash" type-name="GooCanvasLineDash" get-type="goo_canvas_line_dash_get_type">
			<constructor name="new" symbol="goo_canvas_line_dash_new">
				<return-type type="GooCanvasLineDash*"/>
				<parameters>
					<parameter name="num_dashes" type="gint"/>
				</parameters>
			</constructor>
			<constructor name="newv" symbol="goo_canvas_line_dash_newv">
				<return-type type="GooCanvasLineDash*"/>
				<parameters>
					<parameter name="num_dashes" type="gint"/>
					<parameter name="dashes" type="double*"/>
				</parameters>
			</constructor>
			<method name="ref" symbol="goo_canvas_line_dash_ref">
				<return-type type="GooCanvasLineDash*"/>
				<parameters>
					<parameter name="dash" type="GooCanvasLineDash*"/>
				</parameters>
			</method>
			<method name="unref" symbol="goo_canvas_line_dash_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="dash" type="GooCanvasLineDash*"/>
				</parameters>
			</method>
			<field name="ref_count" type="int"/>
			<field name="num_dashes" type="int"/>
			<field name="dashes" type="double*"/>
			<field name="dash_offset" type="double"/>
		</boxed>
		<boxed name="GooCanvasPoints" type-name="GooCanvasPoints" get-type="goo_canvas_points_get_type">
			<constructor name="new" symbol="goo_canvas_points_new">
				<return-type type="GooCanvasPoints*"/>
				<parameters>
					<parameter name="num_points" type="int"/>
				</parameters>
			</constructor>
			<method name="ref" symbol="goo_canvas_points_ref">
				<return-type type="GooCanvasPoints*"/>
				<parameters>
					<parameter name="points" type="GooCanvasPoints*"/>
				</parameters>
			</method>
			<method name="unref" symbol="goo_canvas_points_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="points" type="GooCanvasPoints*"/>
				</parameters>
			</method>
			<field name="coords" type="double*"/>
			<field name="num_points" type="int"/>
			<field name="ref_count" type="int"/>
		</boxed>
		<enum name="GooCairoAntialias" type-name="GooCairoAntialias" get-type="goo_cairo_antialias_get_type">
			<member name="CAIRO_ANTIALIAS_DEFAULT" value="0"/>
			<member name="CAIRO_ANTIALIAS_NONE" value="1"/>
			<member name="CAIRO_ANTIALIAS_GRAY" value="2"/>
			<member name="CAIRO_ANTIALIAS_SUBPIXEL" value="3"/>
		</enum>
		<enum name="GooCairoFillRule" type-name="GooCairoFillRule" get-type="goo_cairo_fill_rule_get_type">
			<member name="CAIRO_FILL_RULE_WINDING" value="0"/>
			<member name="CAIRO_FILL_RULE_EVEN_ODD" value="1"/>
		</enum>
		<enum name="GooCairoHintMetrics" type-name="GooCairoHintMetrics" get-type="goo_cairo_hint_metrics_get_type">
			<member name="CAIRO_HINT_METRICS_DEFAULT" value="0"/>
			<member name="CAIRO_HINT_METRICS_OFF" value="1"/>
			<member name="CAIRO_HINT_METRICS_ON" value="2"/>
		</enum>
		<enum name="GooCairoLineCap" type-name="GooCairoLineCap" get-type="goo_cairo_line_cap_get_type">
			<member name="CAIRO_LINE_CAP_BUTT" value="0"/>
			<member name="CAIRO_LINE_CAP_ROUND" value="1"/>
			<member name="CAIRO_LINE_CAP_SQUARE" value="2"/>
		</enum>
		<enum name="GooCairoLineJoin" type-name="GooCairoLineJoin" get-type="goo_cairo_line_join_get_type">
			<member name="CAIRO_LINE_JOIN_MITER" value="0"/>
			<member name="CAIRO_LINE_JOIN_ROUND" value="1"/>
			<member name="CAIRO_LINE_JOIN_BEVEL" value="2"/>
		</enum>
		<enum name="GooCairoOperator" type-name="GooCairoOperator" get-type="goo_cairo_operator_get_type">
			<member name="CAIRO_OPERATOR_CLEAR" value="0"/>
			<member name="CAIRO_OPERATOR_SOURCE" value="1"/>
			<member name="CAIRO_OPERATOR_OVER" value="2"/>
			<member name="CAIRO_OPERATOR_IN" value="3"/>
			<member name="CAIRO_OPERATOR_OUT" value="4"/>
			<member name="CAIRO_OPERATOR_ATOP" value="5"/>
			<member name="CAIRO_OPERATOR_DEST" value="6"/>
			<member name="CAIRO_OPERATOR_DEST_OVER" value="7"/>
			<member name="CAIRO_OPERATOR_DEST_IN" value="8"/>
			<member name="CAIRO_OPERATOR_DEST_OUT" value="9"/>
			<member name="CAIRO_OPERATOR_DEST_ATOP" value="10"/>
			<member name="CAIRO_OPERATOR_XOR" value="11"/>
			<member name="CAIRO_OPERATOR_ADD" value="12"/>
			<member name="CAIRO_OPERATOR_SATURATE" value="13"/>
		</enum>
		<enum name="GooCanvasAnimateType" type-name="GooCanvasAnimateType" get-type="goo_canvas_animate_type_get_type">
			<member name="GOO_CANVAS_ANIMATE_FREEZE" value="0"/>
			<member name="GOO_CANVAS_ANIMATE_RESET" value="1"/>
			<member name="GOO_CANVAS_ANIMATE_RESTART" value="2"/>
			<member name="GOO_CANVAS_ANIMATE_BOUNCE" value="3"/>
		</enum>
		<enum name="GooCanvasItemVisibility" type-name="GooCanvasItemVisibility" get-type="goo_canvas_item_visibility_get_type">
			<member name="GOO_CANVAS_ITEM_HIDDEN" value="0"/>
			<member name="GOO_CANVAS_ITEM_INVISIBLE" value="1"/>
			<member name="GOO_CANVAS_ITEM_VISIBLE" value="2"/>
			<member name="GOO_CANVAS_ITEM_VISIBLE_ABOVE_THRESHOLD" value="3"/>
		</enum>
		<enum name="GooCanvasPathCommandType" type-name="GooCanvasPathCommandType" get-type="goo_canvas_path_command_type_get_type">
			<member name="GOO_CANVAS_PATH_MOVE_TO" value="0"/>
			<member name="GOO_CANVAS_PATH_CLOSE_PATH" value="1"/>
			<member name="GOO_CANVAS_PATH_LINE_TO" value="2"/>
			<member name="GOO_CANVAS_PATH_HORIZONTAL_LINE_TO" value="3"/>
			<member name="GOO_CANVAS_PATH_VERTICAL_LINE_TO" value="4"/>
			<member name="GOO_CANVAS_PATH_CURVE_TO" value="5"/>
			<member name="GOO_CANVAS_PATH_SMOOTH_CURVE_TO" value="6"/>
			<member name="GOO_CANVAS_PATH_QUADRATIC_CURVE_TO" value="7"/>
			<member name="GOO_CANVAS_PATH_SMOOTH_QUADRATIC_CURVE_TO" value="8"/>
			<member name="GOO_CANVAS_PATH_ELLIPTICAL_ARC" value="9"/>
		</enum>
		<flags name="GooCanvasPointerEvents" type-name="GooCanvasPointerEvents" get-type="goo_canvas_pointer_events_get_type">
			<member name="GOO_CANVAS_EVENTS_VISIBLE_MASK" value="1"/>
			<member name="GOO_CANVAS_EVENTS_PAINTED_MASK" value="2"/>
			<member name="GOO_CANVAS_EVENTS_FILL_MASK" value="4"/>
			<member name="GOO_CANVAS_EVENTS_STROKE_MASK" value="8"/>
			<member name="GOO_CANVAS_EVENTS_NONE" value="0"/>
			<member name="GOO_CANVAS_EVENTS_VISIBLE_PAINTED" value="15"/>
			<member name="GOO_CANVAS_EVENTS_VISIBLE_FILL" value="5"/>
			<member name="GOO_CANVAS_EVENTS_VISIBLE_STROKE" value="9"/>
			<member name="GOO_CANVAS_EVENTS_VISIBLE" value="13"/>
			<member name="GOO_CANVAS_EVENTS_PAINTED" value="14"/>
			<member name="GOO_CANVAS_EVENTS_FILL" value="4"/>
			<member name="GOO_CANVAS_EVENTS_STROKE" value="8"/>
			<member name="GOO_CANVAS_EVENTS_ALL" value="12"/>
		</flags>
		<object name="GooCanvas" parent="GtkContainer" type-name="GooCanvas" get-type="goo_canvas_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="convert_bounds_to_item_space" symbol="goo_canvas_convert_bounds_to_item_space">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
				</parameters>
			</method>
			<method name="convert_from_item_space" symbol="goo_canvas_convert_from_item_space">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="x" type="gdouble*"/>
					<parameter name="y" type="gdouble*"/>
				</parameters>
			</method>
			<method name="convert_from_pixels" symbol="goo_canvas_convert_from_pixels">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="x" type="gdouble*"/>
					<parameter name="y" type="gdouble*"/>
				</parameters>
			</method>
			<method name="convert_to_item_space" symbol="goo_canvas_convert_to_item_space">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="x" type="gdouble*"/>
					<parameter name="y" type="gdouble*"/>
				</parameters>
			</method>
			<method name="convert_to_pixels" symbol="goo_canvas_convert_to_pixels">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="x" type="gdouble*"/>
					<parameter name="y" type="gdouble*"/>
				</parameters>
			</method>
			<method name="create_cairo_context" symbol="goo_canvas_create_cairo_context">
				<return-type type="cairo_t*"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
				</parameters>
			</method>
			<method name="create_item" symbol="goo_canvas_create_item">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="create_path" symbol="goo_canvas_create_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="commands" type="GArray*"/>
					<parameter name="cr" type="cairo_t*"/>
				</parameters>
			</method>
			<method name="get_bounds" symbol="goo_canvas_get_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="left" type="gdouble*"/>
					<parameter name="top" type="gdouble*"/>
					<parameter name="right" type="gdouble*"/>
					<parameter name="bottom" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_default_line_width" symbol="goo_canvas_get_default_line_width">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
				</parameters>
			</method>
			<method name="get_item" symbol="goo_canvas_get_item">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="get_item_at" symbol="goo_canvas_get_item_at">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="is_pointer_event" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_items_at" symbol="goo_canvas_get_items_at">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="is_pointer_event" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_items_in_area" symbol="goo_canvas_get_items_in_area">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="area" type="GooCanvasBounds*"/>
					<parameter name="inside_area" type="gboolean"/>
					<parameter name="allow_overlaps" type="gboolean"/>
					<parameter name="include_containers" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_root_item" symbol="goo_canvas_get_root_item">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
				</parameters>
			</method>
			<method name="get_root_item_model" symbol="goo_canvas_get_root_item_model">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
				</parameters>
			</method>
			<method name="get_scale" symbol="goo_canvas_get_scale">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
				</parameters>
			</method>
			<method name="get_static_root_item" symbol="goo_canvas_get_static_root_item">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
				</parameters>
			</method>
			<method name="get_static_root_item_model" symbol="goo_canvas_get_static_root_item_model">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
				</parameters>
			</method>
			<method name="grab_focus" symbol="goo_canvas_grab_focus">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="keyboard_grab" symbol="goo_canvas_keyboard_grab">
				<return-type type="GdkGrabStatus"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="owner_events" type="gboolean"/>
					<parameter name="time" type="guint32"/>
				</parameters>
			</method>
			<method name="keyboard_ungrab" symbol="goo_canvas_keyboard_ungrab">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="time" type="guint32"/>
				</parameters>
			</method>
			<method name="marshal_BOOLEAN__BOXED" symbol="goo_canvas_marshal_BOOLEAN__BOXED">
				<return-type type="void"/>
				<parameters>
					<parameter name="closure" type="GClosure*"/>
					<parameter name="return_value" type="GValue*"/>
					<parameter name="n_param_values" type="guint"/>
					<parameter name="param_values" type="GValue*"/>
					<parameter name="invocation_hint" type="gpointer"/>
					<parameter name="marshal_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="marshal_BOOLEAN__DOUBLE_DOUBLE_BOOLEAN_OBJECT" symbol="goo_canvas_marshal_BOOLEAN__DOUBLE_DOUBLE_BOOLEAN_OBJECT">
				<return-type type="void"/>
				<parameters>
					<parameter name="closure" type="GClosure*"/>
					<parameter name="return_value" type="GValue*"/>
					<parameter name="n_param_values" type="guint"/>
					<parameter name="param_values" type="GValue*"/>
					<parameter name="invocation_hint" type="gpointer"/>
					<parameter name="marshal_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="marshal_BOOLEAN__OBJECT_BOXED" symbol="goo_canvas_marshal_BOOLEAN__OBJECT_BOXED">
				<return-type type="void"/>
				<parameters>
					<parameter name="closure" type="GClosure*"/>
					<parameter name="return_value" type="GValue*"/>
					<parameter name="n_param_values" type="guint"/>
					<parameter name="param_values" type="GValue*"/>
					<parameter name="invocation_hint" type="gpointer"/>
					<parameter name="marshal_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="marshal_VOID__INT_INT" symbol="goo_canvas_marshal_VOID__INT_INT">
				<return-type type="void"/>
				<parameters>
					<parameter name="closure" type="GClosure*"/>
					<parameter name="return_value" type="GValue*"/>
					<parameter name="n_param_values" type="guint"/>
					<parameter name="param_values" type="GValue*"/>
					<parameter name="invocation_hint" type="gpointer"/>
					<parameter name="marshal_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="marshal_VOID__OBJECT_OBJECT" symbol="goo_canvas_marshal_VOID__OBJECT_OBJECT">
				<return-type type="void"/>
				<parameters>
					<parameter name="closure" type="GClosure*"/>
					<parameter name="return_value" type="GValue*"/>
					<parameter name="n_param_values" type="guint"/>
					<parameter name="param_values" type="GValue*"/>
					<parameter name="invocation_hint" type="gpointer"/>
					<parameter name="marshal_data" type="gpointer"/>
				</parameters>
			</method>
			<constructor name="new" symbol="goo_canvas_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="parse_path_data" symbol="goo_canvas_parse_path_data">
				<return-type type="GArray*"/>
				<parameters>
					<parameter name="path_data" type="gchar*"/>
				</parameters>
			</method>
			<method name="pointer_grab" symbol="goo_canvas_pointer_grab">
				<return-type type="GdkGrabStatus"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="event_mask" type="GdkEventMask"/>
					<parameter name="cursor" type="GdkCursor*"/>
					<parameter name="time" type="guint32"/>
				</parameters>
			</method>
			<method name="pointer_ungrab" symbol="goo_canvas_pointer_ungrab">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="time" type="guint32"/>
				</parameters>
			</method>
			<method name="register_widget_item" symbol="goo_canvas_register_widget_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="witem" type="GooCanvasWidget*"/>
				</parameters>
			</method>
			<method name="render" symbol="goo_canvas_render">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
					<parameter name="scale" type="gdouble"/>
				</parameters>
			</method>
			<method name="request_item_redraw" symbol="goo_canvas_request_item_redraw">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
					<parameter name="is_static" type="gboolean"/>
				</parameters>
			</method>
			<method name="request_redraw" symbol="goo_canvas_request_redraw">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
				</parameters>
			</method>
			<method name="request_update" symbol="goo_canvas_request_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
				</parameters>
			</method>
			<method name="scroll_to" symbol="goo_canvas_scroll_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="left" type="gdouble"/>
					<parameter name="top" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_bounds" symbol="goo_canvas_set_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="left" type="gdouble"/>
					<parameter name="top" type="gdouble"/>
					<parameter name="right" type="gdouble"/>
					<parameter name="bottom" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_root_item" symbol="goo_canvas_set_root_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="set_root_item_model" symbol="goo_canvas_set_root_item_model">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="set_scale" symbol="goo_canvas_set_scale">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="scale" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_static_root_item" symbol="goo_canvas_set_static_root_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="set_static_root_item_model" symbol="goo_canvas_set_static_root_item_model">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="unregister_item" symbol="goo_canvas_unregister_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="unregister_widget_item" symbol="goo_canvas_unregister_widget_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="witem" type="GooCanvasWidget*"/>
				</parameters>
			</method>
			<method name="update" symbol="goo_canvas_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
				</parameters>
			</method>
			<property name="anchor" type="GtkAnchorType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="automatic-bounds" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="background-color" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="background-color-rgb" type="guint" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="bounds-from-origin" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="bounds-padding" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="clear-background" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="integer-layout" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="redraw-when-scrolled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="resolution-x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="resolution-y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scale" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scale-x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scale-y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="units" type="GtkUnit" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x1" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x2" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y1" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y2" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="item-created" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</signal>
			<signal name="set-scroll-adjustments" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="hadjustment" type="GtkAdjustment*"/>
					<parameter name="vadjustment" type="GtkAdjustment*"/>
				</parameters>
			</signal>
			<vfunc name="create_item">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="canvas" type="GooCanvas*"/>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</vfunc>
			<field name="root_item_model" type="GooCanvasItemModel*"/>
			<field name="root_item" type="GooCanvasItem*"/>
			<field name="bounds" type="GooCanvasBounds"/>
			<field name="scale_x" type="gdouble"/>
			<field name="scale_y" type="gdouble"/>
			<field name="scale" type="gdouble"/>
			<field name="anchor" type="GtkAnchorType"/>
			<field name="idle_id" type="guint"/>
			<field name="need_update" type="guint"/>
			<field name="need_entire_subtree_update" type="guint"/>
			<field name="integer_layout" type="guint"/>
			<field name="automatic_bounds" type="guint"/>
			<field name="bounds_from_origin" type="guint"/>
			<field name="clear_background" type="guint"/>
			<field name="redraw_when_scrolled" type="guint"/>
			<field name="bounds_padding" type="gdouble"/>
			<field name="pointer_item" type="GooCanvasItem*"/>
			<field name="pointer_grab_item" type="GooCanvasItem*"/>
			<field name="pointer_grab_initial_item" type="GooCanvasItem*"/>
			<field name="pointer_grab_button" type="guint"/>
			<field name="focused_item" type="GooCanvasItem*"/>
			<field name="keyboard_grab_item" type="GooCanvasItem*"/>
			<field name="crossing_event" type="GdkEventCrossing"/>
			<field name="canvas_window" type="GdkWindow*"/>
			<field name="canvas_x_offset" type="gint"/>
			<field name="canvas_y_offset" type="gint"/>
			<field name="hadjustment" type="GtkAdjustment*"/>
			<field name="vadjustment" type="GtkAdjustment*"/>
			<field name="freeze_count" type="gint"/>
			<field name="tmp_window" type="GdkWindow*"/>
			<field name="model_to_item" type="GHashTable*"/>
			<field name="units" type="GtkUnit"/>
			<field name="resolution_x" type="gdouble"/>
			<field name="resolution_y" type="gdouble"/>
			<field name="device_to_pixels_x" type="gdouble"/>
			<field name="device_to_pixels_y" type="gdouble"/>
			<field name="widget_items" type="GList*"/>
		</object>
		<object name="GooCanvasEllipse" parent="GooCanvasItemSimple" type-name="GooCanvasEllipse" get-type="goo_canvas_ellipse_get_type">
			<implements>
				<interface name="GooCanvasItem"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_ellipse_new">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItem*"/>
					<parameter name="center_x" type="gdouble"/>
					<parameter name="center_y" type="gdouble"/>
					<parameter name="radius_x" type="gdouble"/>
					<parameter name="radius_y" type="gdouble"/>
				</parameters>
			</constructor>
			<property name="center-x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="center-y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="radius-x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="radius-y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="ellipse_data" type="GooCanvasEllipseData*"/>
		</object>
		<object name="GooCanvasEllipseModel" parent="GooCanvasItemModelSimple" type-name="GooCanvasEllipseModel" get-type="goo_canvas_ellipse_model_get_type">
			<implements>
				<interface name="GooCanvasItemModel"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_ellipse_model_new">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItemModel*"/>
					<parameter name="center_x" type="gdouble"/>
					<parameter name="center_y" type="gdouble"/>
					<parameter name="radius_x" type="gdouble"/>
					<parameter name="radius_y" type="gdouble"/>
				</parameters>
			</constructor>
			<property name="center-x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="center-y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="radius-x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="radius-y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="ellipse_data" type="GooCanvasEllipseData"/>
		</object>
		<object name="GooCanvasGrid" parent="GooCanvasItemSimple" type-name="GooCanvasGrid" get-type="goo_canvas_grid_get_type">
			<implements>
				<interface name="GooCanvasItem"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_grid_new">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItem*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="width" type="gdouble"/>
					<parameter name="height" type="gdouble"/>
					<parameter name="x_step" type="gdouble"/>
					<parameter name="y_step" type="gdouble"/>
					<parameter name="x_offset" type="gdouble"/>
					<parameter name="y_offset" type="gdouble"/>
				</parameters>
			</constructor>
			<property name="border-color" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="border-color-rgba" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="border-pattern" type="GooCairoPattern*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="border-pixbuf" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="border-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="horz-grid-line-color" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="horz-grid-line-color-rgba" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="horz-grid-line-pattern" type="GooCairoPattern*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="horz-grid-line-pixbuf" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="horz-grid-line-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-horz-grid-lines" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-vert-grid-lines" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-line-color" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-line-color-rgba" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-line-pattern" type="GooCairoPattern*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-line-pixbuf" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-line-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-lines-on-top" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-offset" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-step" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-offset" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-step" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="grid_data" type="GooCanvasGridData*"/>
		</object>
		<object name="GooCanvasGridModel" parent="GooCanvasItemModelSimple" type-name="GooCanvasGridModel" get-type="goo_canvas_grid_model_get_type">
			<implements>
				<interface name="GooCanvasItemModel"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_grid_model_new">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItemModel*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="width" type="gdouble"/>
					<parameter name="height" type="gdouble"/>
					<parameter name="x_step" type="gdouble"/>
					<parameter name="y_step" type="gdouble"/>
					<parameter name="x_offset" type="gdouble"/>
					<parameter name="y_offset" type="gdouble"/>
				</parameters>
			</constructor>
			<property name="border-color" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="border-color-rgba" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="border-pattern" type="GooCairoPattern*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="border-pixbuf" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="border-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="horz-grid-line-color" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="horz-grid-line-color-rgba" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="horz-grid-line-pattern" type="GooCairoPattern*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="horz-grid-line-pixbuf" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="horz-grid-line-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-horz-grid-lines" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-vert-grid-lines" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-line-color" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-line-color-rgba" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-line-pattern" type="GooCairoPattern*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-line-pixbuf" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-line-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-lines-on-top" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-offset" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-step" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-offset" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-step" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="grid_data" type="GooCanvasGridData"/>
		</object>
		<object name="GooCanvasGroup" parent="GooCanvasItemSimple" type-name="GooCanvasGroup" get-type="goo_canvas_group_get_type">
			<implements>
				<interface name="GooCanvasItem"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_group_new">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItem*"/>
				</parameters>
			</constructor>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="items" type="GPtrArray*"/>
		</object>
		<object name="GooCanvasGroupModel" parent="GooCanvasItemModelSimple" type-name="GooCanvasGroupModel" get-type="goo_canvas_group_model_get_type">
			<implements>
				<interface name="GooCanvasItemModel"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_group_model_new">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItemModel*"/>
				</parameters>
			</constructor>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="children" type="GPtrArray*"/>
		</object>
		<object name="GooCanvasImage" parent="GooCanvasItemSimple" type-name="GooCanvasImage" get-type="goo_canvas_image_get_type">
			<implements>
				<interface name="GooCanvasItem"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_image_new">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItem*"/>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
				</parameters>
			</constructor>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pattern" type="GooCairoPattern*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pixbuf" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="scale-to-fit" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="image_data" type="GooCanvasImageData*"/>
		</object>
		<object name="GooCanvasImageModel" parent="GooCanvasItemModelSimple" type-name="GooCanvasImageModel" get-type="goo_canvas_image_model_get_type">
			<implements>
				<interface name="GooCanvasItemModel"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_image_model_new">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItemModel*"/>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
				</parameters>
			</constructor>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pattern" type="GooCairoPattern*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pixbuf" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="scale-to-fit" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="image_data" type="GooCanvasImageData"/>
		</object>
		<object name="GooCanvasItemModelSimple" parent="GObject" type-name="GooCanvasItemModelSimple" get-type="goo_canvas_item_model_simple_get_type">
			<implements>
				<interface name="GooCanvasItemModel"/>
			</implements>
			<property name="antialias" type="GooCairoAntialias" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="clip-fill-rule" type="GooCairoFillRule" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="clip-path" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="fill-color" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="fill-color-rgba" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fill-pattern" type="GooCairoPattern*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fill-pixbuf" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="fill-rule" type="GooCairoFillRule" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="font" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="font-desc" type="PangoFontDescription*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="hint-metrics" type="GooCairoHintMetrics" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-cap" type="GooCairoLineCap" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-dash" type="GooCanvasLineDash*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-join" type="GooCairoLineJoin" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-join-miter-limit" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="operator" type="GooCairoOperator" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="stroke-color" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="stroke-color-rgba" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="stroke-pattern" type="GooCairoPattern*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="stroke-pixbuf" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<field name="parent" type="GooCanvasItemModel*"/>
			<field name="simple_data" type="GooCanvasItemSimpleData"/>
			<field name="title" type="gchar*"/>
			<field name="description" type="gchar*"/>
		</object>
		<object name="GooCanvasItemSimple" parent="GObject" type-name="GooCanvasItemSimple" get-type="goo_canvas_item_simple_get_type">
			<implements>
				<interface name="GooCanvasItem"/>
			</implements>
			<method name="changed" symbol="goo_canvas_item_simple_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItemSimple*"/>
					<parameter name="recompute_bounds" type="gboolean"/>
				</parameters>
			</method>
			<method name="check_in_path" symbol="goo_canvas_item_simple_check_in_path">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItemSimple*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="pointer_events" type="GooCanvasPointerEvents"/>
				</parameters>
			</method>
			<method name="check_style" symbol="goo_canvas_item_simple_check_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItemSimple*"/>
				</parameters>
			</method>
			<method name="get_line_width" symbol="goo_canvas_item_simple_get_line_width">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="item" type="GooCanvasItemSimple*"/>
				</parameters>
			</method>
			<method name="get_path_bounds" symbol="goo_canvas_item_simple_get_path_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItemSimple*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
				</parameters>
			</method>
			<method name="paint_path" symbol="goo_canvas_item_simple_paint_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItemSimple*"/>
					<parameter name="cr" type="cairo_t*"/>
				</parameters>
			</method>
			<method name="set_model" symbol="goo_canvas_item_simple_set_model">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItemSimple*"/>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="user_bounds_to_device" symbol="goo_canvas_item_simple_user_bounds_to_device">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItemSimple*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
				</parameters>
			</method>
			<method name="user_bounds_to_parent" symbol="goo_canvas_item_simple_user_bounds_to_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItemSimple*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
				</parameters>
			</method>
			<property name="antialias" type="GooCairoAntialias" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="clip-fill-rule" type="GooCairoFillRule" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="clip-path" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="fill-color" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="fill-color-rgba" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fill-pattern" type="GooCairoPattern*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fill-pixbuf" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="fill-rule" type="GooCairoFillRule" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="font" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="font-desc" type="PangoFontDescription*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="hint-metrics" type="GooCairoHintMetrics" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-cap" type="GooCairoLineCap" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-dash" type="GooCanvasLineDash*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-join" type="GooCairoLineJoin" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-join-miter-limit" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="operator" type="GooCairoOperator" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="stroke-color" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="stroke-color-rgba" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="stroke-pattern" type="GooCairoPattern*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="stroke-pixbuf" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<vfunc name="simple_create_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GooCanvasItemSimple*"/>
					<parameter name="cr" type="cairo_t*"/>
				</parameters>
			</vfunc>
			<vfunc name="simple_is_item_at">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="simple" type="GooCanvasItemSimple*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="is_pointer_event" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="simple_paint">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GooCanvasItemSimple*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
				</parameters>
			</vfunc>
			<vfunc name="simple_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GooCanvasItemSimple*"/>
					<parameter name="cr" type="cairo_t*"/>
				</parameters>
			</vfunc>
			<field name="canvas" type="GooCanvas*"/>
			<field name="parent" type="GooCanvasItem*"/>
			<field name="model" type="GooCanvasItemModelSimple*"/>
			<field name="simple_data" type="GooCanvasItemSimpleData*"/>
			<field name="bounds" type="GooCanvasBounds"/>
			<field name="need_update" type="guint"/>
			<field name="need_entire_subtree_update" type="guint"/>
		</object>
		<object name="GooCanvasPath" parent="GooCanvasItemSimple" type-name="GooCanvasPath" get-type="goo_canvas_path_get_type">
			<implements>
				<interface name="GooCanvasItem"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_path_new">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItem*"/>
					<parameter name="path_data" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="data" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="path_data" type="GooCanvasPathData*"/>
		</object>
		<object name="GooCanvasPathModel" parent="GooCanvasItemModelSimple" type-name="GooCanvasPathModel" get-type="goo_canvas_path_model_get_type">
			<implements>
				<interface name="GooCanvasItemModel"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_path_model_new">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItemModel*"/>
					<parameter name="path_data" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="data" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="path_data" type="GooCanvasPathData"/>
		</object>
		<object name="GooCanvasPolyline" parent="GooCanvasItemSimple" type-name="GooCanvasPolyline" get-type="goo_canvas_polyline_get_type">
			<implements>
				<interface name="GooCanvasItem"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_polyline_new">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItem*"/>
					<parameter name="close_path" type="gboolean"/>
					<parameter name="num_points" type="gint"/>
				</parameters>
			</constructor>
			<constructor name="new_line" symbol="goo_canvas_polyline_new_line">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItem*"/>
					<parameter name="x1" type="gdouble"/>
					<parameter name="y1" type="gdouble"/>
					<parameter name="x2" type="gdouble"/>
					<parameter name="y2" type="gdouble"/>
				</parameters>
			</constructor>
			<property name="arrow-length" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="arrow-tip-length" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="arrow-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="close-path" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="end-arrow" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="points" type="GooCanvasPoints*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="start-arrow" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="polyline_data" type="GooCanvasPolylineData*"/>
		</object>
		<object name="GooCanvasPolylineModel" parent="GooCanvasItemModelSimple" type-name="GooCanvasPolylineModel" get-type="goo_canvas_polyline_model_get_type">
			<implements>
				<interface name="GooCanvasItemModel"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_polyline_model_new">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItemModel*"/>
					<parameter name="close_path" type="gboolean"/>
					<parameter name="num_points" type="gint"/>
				</parameters>
			</constructor>
			<constructor name="new_line" symbol="goo_canvas_polyline_model_new_line">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItemModel*"/>
					<parameter name="x1" type="gdouble"/>
					<parameter name="y1" type="gdouble"/>
					<parameter name="x2" type="gdouble"/>
					<parameter name="y2" type="gdouble"/>
				</parameters>
			</constructor>
			<property name="arrow-length" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="arrow-tip-length" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="arrow-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="close-path" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="end-arrow" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="points" type="GooCanvasPoints*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="start-arrow" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="polyline_data" type="GooCanvasPolylineData"/>
		</object>
		<object name="GooCanvasRect" parent="GooCanvasItemSimple" type-name="GooCanvasRect" get-type="goo_canvas_rect_get_type">
			<implements>
				<interface name="GooCanvasItem"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_rect_new">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItem*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="width" type="gdouble"/>
					<parameter name="height" type="gdouble"/>
				</parameters>
			</constructor>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="radius-x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="radius-y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="rect_data" type="GooCanvasRectData*"/>
		</object>
		<object name="GooCanvasRectModel" parent="GooCanvasItemModelSimple" type-name="GooCanvasRectModel" get-type="goo_canvas_rect_model_get_type">
			<implements>
				<interface name="GooCanvasItemModel"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_rect_model_new">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItemModel*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="width" type="gdouble"/>
					<parameter name="height" type="gdouble"/>
				</parameters>
			</constructor>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="radius-x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="radius-y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="rect_data" type="GooCanvasRectData"/>
		</object>
		<object name="GooCanvasStyle" parent="GObject" type-name="GooCanvasStyle" get-type="goo_canvas_style_get_type">
			<method name="copy" symbol="goo_canvas_style_copy">
				<return-type type="GooCanvasStyle*"/>
				<parameters>
					<parameter name="style" type="GooCanvasStyle*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="goo_canvas_style_get_parent">
				<return-type type="GooCanvasStyle*"/>
				<parameters>
					<parameter name="style" type="GooCanvasStyle*"/>
				</parameters>
			</method>
			<method name="get_property" symbol="goo_canvas_style_get_property">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="style" type="GooCanvasStyle*"/>
					<parameter name="property_id" type="GQuark"/>
				</parameters>
			</method>
			<constructor name="new" symbol="goo_canvas_style_new">
				<return-type type="GooCanvasStyle*"/>
			</constructor>
			<method name="set_fill_options" symbol="goo_canvas_style_set_fill_options">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="style" type="GooCanvasStyle*"/>
					<parameter name="cr" type="cairo_t*"/>
				</parameters>
			</method>
			<method name="set_parent" symbol="goo_canvas_style_set_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="style" type="GooCanvasStyle*"/>
					<parameter name="parent" type="GooCanvasStyle*"/>
				</parameters>
			</method>
			<method name="set_property" symbol="goo_canvas_style_set_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="style" type="GooCanvasStyle*"/>
					<parameter name="property_id" type="GQuark"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_stroke_options" symbol="goo_canvas_style_set_stroke_options">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="style" type="GooCanvasStyle*"/>
					<parameter name="cr" type="cairo_t*"/>
				</parameters>
			</method>
			<field name="parent" type="GooCanvasStyle*"/>
			<field name="properties" type="GArray*"/>
		</object>
		<object name="GooCanvasTable" parent="GooCanvasGroup" type-name="GooCanvasTable" get-type="goo_canvas_table_get_type">
			<implements>
				<interface name="GooCanvasItem"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_table_new">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItem*"/>
				</parameters>
			</constructor>
			<property name="column-spacing" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="homogeneous-columns" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="homogeneous-rows" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="horz-grid-line-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="row-spacing" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-line-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-border-spacing" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-border-spacing" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="table_data" type="GooCanvasTableData*"/>
		</object>
		<object name="GooCanvasTableModel" parent="GooCanvasGroupModel" type-name="GooCanvasTableModel" get-type="goo_canvas_table_model_get_type">
			<implements>
				<interface name="GooCanvasItemModel"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_table_model_new">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItemModel*"/>
				</parameters>
			</constructor>
			<property name="column-spacing" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="homogeneous-columns" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="homogeneous-rows" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="horz-grid-line-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="row-spacing" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vert-grid-line-width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-border-spacing" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-border-spacing" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="table_data" type="GooCanvasTableData"/>
		</object>
		<object name="GooCanvasText" parent="GooCanvasItemSimple" type-name="GooCanvasText" get-type="goo_canvas_text_get_type">
			<implements>
				<interface name="GooCanvasItem"/>
			</implements>
			<method name="get_natural_extents" symbol="goo_canvas_text_get_natural_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="GooCanvasText*"/>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="goo_canvas_text_new">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItem*"/>
					<parameter name="string" type="char*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="width" type="gdouble"/>
					<parameter name="anchor" type="GtkAnchorType"/>
				</parameters>
			</constructor>
			<property name="alignment" type="PangoAlignment" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="anchor" type="GtkAnchorType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ellipsize" type="PangoEllipsizeMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-markup" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="wrap" type="PangoWrapMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="text_data" type="GooCanvasTextData*"/>
			<field name="layout_width" type="gdouble"/>
		</object>
		<object name="GooCanvasTextModel" parent="GooCanvasItemModelSimple" type-name="GooCanvasTextModel" get-type="goo_canvas_text_model_get_type">
			<implements>
				<interface name="GooCanvasItemModel"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_text_model_new">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItemModel*"/>
					<parameter name="string" type="char*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="width" type="gdouble"/>
					<parameter name="anchor" type="GtkAnchorType"/>
				</parameters>
			</constructor>
			<property name="alignment" type="PangoAlignment" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="anchor" type="GtkAnchorType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ellipsize" type="PangoEllipsizeMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-markup" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="wrap" type="PangoWrapMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="text_data" type="GooCanvasTextData"/>
		</object>
		<object name="GooCanvasWidget" parent="GooCanvasItemSimple" type-name="GooCanvasWidget" get-type="goo_canvas_widget_get_type">
			<implements>
				<interface name="GooCanvasItem"/>
			</implements>
			<constructor name="new" symbol="goo_canvas_widget_new">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="parent" type="GooCanvasItem*"/>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="width" type="gdouble"/>
					<parameter name="height" type="gdouble"/>
				</parameters>
			</constructor>
			<property name="anchor" type="GtkAnchorType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="widget" type="GtkWidget*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="widget" type="GtkWidget*"/>
			<field name="x" type="gdouble"/>
			<field name="y" type="gdouble"/>
			<field name="width" type="gdouble"/>
			<field name="height" type="gdouble"/>
			<field name="anchor" type="GtkAnchorType"/>
		</object>
		<interface name="GooCanvasItem" type-name="GooCanvasItem" get-type="goo_canvas_item_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="add_child" symbol="goo_canvas_item_add_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</method>
			<method name="allocate_area" symbol="goo_canvas_item_allocate_area">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="requested_area" type="GooCanvasBounds*"/>
					<parameter name="allocated_area" type="GooCanvasBounds*"/>
					<parameter name="x_offset" type="gdouble"/>
					<parameter name="y_offset" type="gdouble"/>
				</parameters>
			</method>
			<method name="animate" symbol="goo_canvas_item_animate">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="scale" type="gdouble"/>
					<parameter name="degrees" type="gdouble"/>
					<parameter name="absolute" type="gboolean"/>
					<parameter name="duration" type="gint"/>
					<parameter name="step_time" type="gint"/>
					<parameter name="type" type="GooCanvasAnimateType"/>
				</parameters>
			</method>
			<method name="class_find_child_property" symbol="goo_canvas_item_class_find_child_property">
				<return-type type="GParamSpec*"/>
				<parameters>
					<parameter name="iclass" type="GObjectClass*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="class_install_child_property" symbol="goo_canvas_item_class_install_child_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="iclass" type="GObjectClass*"/>
					<parameter name="property_id" type="guint"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</method>
			<method name="class_list_child_properties" symbol="goo_canvas_item_class_list_child_properties">
				<return-type type="GParamSpec**"/>
				<parameters>
					<parameter name="iclass" type="GObjectClass*"/>
					<parameter name="n_properties" type="guint*"/>
				</parameters>
			</method>
			<method name="ensure_updated" symbol="goo_canvas_item_ensure_updated">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="find_child" symbol="goo_canvas_item_find_child">
				<return-type type="gint"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="get_bounds" symbol="goo_canvas_item_get_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
				</parameters>
			</method>
			<method name="get_canvas" symbol="goo_canvas_item_get_canvas">
				<return-type type="GooCanvas*"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="get_child" symbol="goo_canvas_item_get_child">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child_num" type="gint"/>
				</parameters>
			</method>
			<method name="get_child_properties" symbol="goo_canvas_item_get_child_properties">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="get_child_properties_valist" symbol="goo_canvas_item_get_child_properties_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</method>
			<method name="get_child_property" symbol="goo_canvas_item_get_child_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_is_static" symbol="goo_canvas_item_get_is_static">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="get_items_at" symbol="goo_canvas_item_get_items_at">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="is_pointer_event" type="gboolean"/>
					<parameter name="parent_is_visible" type="gboolean"/>
					<parameter name="found_items" type="GList*"/>
				</parameters>
			</method>
			<method name="get_model" symbol="goo_canvas_item_get_model">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="get_n_children" symbol="goo_canvas_item_get_n_children">
				<return-type type="gint"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="goo_canvas_item_get_parent">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="get_requested_area" symbol="goo_canvas_item_get_requested_area">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="requested_area" type="GooCanvasBounds*"/>
				</parameters>
			</method>
			<method name="get_requested_height" symbol="goo_canvas_item_get_requested_height">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="width" type="gdouble"/>
				</parameters>
			</method>
			<method name="get_simple_transform" symbol="goo_canvas_item_get_simple_transform">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="x" type="gdouble*"/>
					<parameter name="y" type="gdouble*"/>
					<parameter name="scale" type="gdouble*"/>
					<parameter name="rotation" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_style" symbol="goo_canvas_item_get_style">
				<return-type type="GooCanvasStyle*"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="get_transform" symbol="goo_canvas_item_get_transform">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="transform" type="cairo_matrix_t*"/>
				</parameters>
			</method>
			<method name="get_transform_for_child" symbol="goo_canvas_item_get_transform_for_child">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
					<parameter name="transform" type="cairo_matrix_t*"/>
				</parameters>
			</method>
			<method name="is_container" symbol="goo_canvas_item_is_container">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="is_visible" symbol="goo_canvas_item_is_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="lower" symbol="goo_canvas_item_lower">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="below" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="move_child" symbol="goo_canvas_item_move_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="old_position" type="gint"/>
					<parameter name="new_position" type="gint"/>
				</parameters>
			</method>
			<method name="paint" symbol="goo_canvas_item_paint">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
					<parameter name="scale" type="gdouble"/>
				</parameters>
			</method>
			<method name="raise" symbol="goo_canvas_item_raise">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="above" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="remove" symbol="goo_canvas_item_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="remove_child" symbol="goo_canvas_item_remove_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child_num" type="gint"/>
				</parameters>
			</method>
			<method name="request_update" symbol="goo_canvas_item_request_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="rotate" symbol="goo_canvas_item_rotate">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="degrees" type="gdouble"/>
					<parameter name="cx" type="gdouble"/>
					<parameter name="cy" type="gdouble"/>
				</parameters>
			</method>
			<method name="scale" symbol="goo_canvas_item_scale">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="sx" type="gdouble"/>
					<parameter name="sy" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_canvas" symbol="goo_canvas_item_set_canvas">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="canvas" type="GooCanvas*"/>
				</parameters>
			</method>
			<method name="set_child_properties" symbol="goo_canvas_item_set_child_properties">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="set_child_properties_valist" symbol="goo_canvas_item_set_child_properties_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</method>
			<method name="set_child_property" symbol="goo_canvas_item_set_child_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_is_static" symbol="goo_canvas_item_set_is_static">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="is_static" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_model" symbol="goo_canvas_item_set_model">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="set_parent" symbol="goo_canvas_item_set_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="parent" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="set_simple_transform" symbol="goo_canvas_item_set_simple_transform">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="scale" type="gdouble"/>
					<parameter name="rotation" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_style" symbol="goo_canvas_item_set_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="style" type="GooCanvasStyle*"/>
				</parameters>
			</method>
			<method name="set_transform" symbol="goo_canvas_item_set_transform">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="transform" type="cairo_matrix_t*"/>
				</parameters>
			</method>
			<method name="skew_x" symbol="goo_canvas_item_skew_x">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="degrees" type="gdouble"/>
					<parameter name="cx" type="gdouble"/>
					<parameter name="cy" type="gdouble"/>
				</parameters>
			</method>
			<method name="skew_y" symbol="goo_canvas_item_skew_y">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="degrees" type="gdouble"/>
					<parameter name="cx" type="gdouble"/>
					<parameter name="cy" type="gdouble"/>
				</parameters>
			</method>
			<method name="stop_animation" symbol="goo_canvas_item_stop_animation">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</method>
			<method name="translate" symbol="goo_canvas_item_translate">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="tx" type="gdouble"/>
					<parameter name="ty" type="gdouble"/>
				</parameters>
			</method>
			<method name="update" symbol="goo_canvas_item_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="entire_tree" type="gboolean"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
				</parameters>
			</method>
			<property name="can-focus" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="description" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="parent" type="GooCanvasItem*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pointer-events" type="GooCanvasPointerEvents" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="tooltip" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="transform" type="GooCairoMatrix*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="visibility" type="GooCanvasItemVisibility" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="visibility-threshold" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="animation-finished" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="stopped" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="button-press-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="target" type="GooCanvasItem*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="button-release-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="target" type="GooCanvasItem*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="child-notify" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</signal>
			<signal name="enter-notify-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="target" type="GooCanvasItem*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="focus-in-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="target" type="GooCanvasItem*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="focus-out-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="target" type="GooCanvasItem*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="grab-broken-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="target" type="GooCanvasItem*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="key-press-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="target" type="GooCanvasItem*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="key-release-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="target" type="GooCanvasItem*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="leave-notify-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="target" type="GooCanvasItem*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="motion-notify-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="target" type="GooCanvasItem*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="query-tooltip" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="keyboard_tooltip" type="gboolean"/>
					<parameter name="tooltip" type="GtkTooltip*"/>
				</parameters>
			</signal>
			<signal name="scroll-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="target" type="GooCanvasItem*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<vfunc name="add_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="allocate_area">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="requested_area" type="GooCanvasBounds*"/>
					<parameter name="allocated_area" type="GooCanvasBounds*"/>
					<parameter name="x_offset" type="gdouble"/>
					<parameter name="y_offset" type="gdouble"/>
				</parameters>
			</vfunc>
			<vfunc name="get_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_canvas">
				<return-type type="GooCanvas*"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_child">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child_num" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_child_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
					<parameter name="property_id" type="guint"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_is_static">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_items_at">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="is_pointer_event" type="gboolean"/>
					<parameter name="parent_is_visible" type="gboolean"/>
					<parameter name="found_items" type="GList*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_model">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_children">
				<return-type type="gint"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_parent">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_requested_area">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="requested_area" type="GooCanvasBounds*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_requested_height">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="width" type="gdouble"/>
				</parameters>
			</vfunc>
			<vfunc name="get_style">
				<return-type type="GooCanvasStyle*"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_transform">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="transform" type="cairo_matrix_t*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_transform_for_child">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
					<parameter name="transform" type="cairo_matrix_t*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</vfunc>
			<vfunc name="move_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="old_position" type="gint"/>
					<parameter name="new_position" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="paint">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
					<parameter name="scale" type="gdouble"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child_num" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="request_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_canvas">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="canvas" type="GooCanvas*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_child_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="child" type="GooCanvasItem*"/>
					<parameter name="property_id" type="guint"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_is_static">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="is_static" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="set_model">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="parent" type="GooCanvasItem*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="style" type="GooCanvasStyle*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_transform">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="transform" type="cairo_matrix_t*"/>
				</parameters>
			</vfunc>
			<vfunc name="update">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItem*"/>
					<parameter name="entire_tree" type="gboolean"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="bounds" type="GooCanvasBounds*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GooCanvasItemModel" type-name="GooCanvasItemModel" get-type="goo_canvas_item_model_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="add_child" symbol="goo_canvas_item_model_add_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child" type="GooCanvasItemModel*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</method>
			<method name="animate" symbol="goo_canvas_item_model_animate">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="scale" type="gdouble"/>
					<parameter name="degrees" type="gdouble"/>
					<parameter name="absolute" type="gboolean"/>
					<parameter name="duration" type="gint"/>
					<parameter name="step_time" type="gint"/>
					<parameter name="type" type="GooCanvasAnimateType"/>
				</parameters>
			</method>
			<method name="class_find_child_property" symbol="goo_canvas_item_model_class_find_child_property">
				<return-type type="GParamSpec*"/>
				<parameters>
					<parameter name="mclass" type="GObjectClass*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="class_install_child_property" symbol="goo_canvas_item_model_class_install_child_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="mclass" type="GObjectClass*"/>
					<parameter name="property_id" type="guint"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</method>
			<method name="class_list_child_properties" symbol="goo_canvas_item_model_class_list_child_properties">
				<return-type type="GParamSpec**"/>
				<parameters>
					<parameter name="mclass" type="GObjectClass*"/>
					<parameter name="n_properties" type="guint*"/>
				</parameters>
			</method>
			<method name="find_child" symbol="goo_canvas_item_model_find_child">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="get_child" symbol="goo_canvas_item_model_get_child">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child_num" type="gint"/>
				</parameters>
			</method>
			<method name="get_child_properties" symbol="goo_canvas_item_model_get_child_properties">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="get_child_properties_valist" symbol="goo_canvas_item_model_get_child_properties_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child" type="GooCanvasItemModel*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</method>
			<method name="get_child_property" symbol="goo_canvas_item_model_get_child_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child" type="GooCanvasItemModel*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_n_children" symbol="goo_canvas_item_model_get_n_children">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="goo_canvas_item_model_get_parent">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="get_simple_transform" symbol="goo_canvas_item_model_get_simple_transform">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="x" type="gdouble*"/>
					<parameter name="y" type="gdouble*"/>
					<parameter name="scale" type="gdouble*"/>
					<parameter name="rotation" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_style" symbol="goo_canvas_item_model_get_style">
				<return-type type="GooCanvasStyle*"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="get_transform" symbol="goo_canvas_item_model_get_transform">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="transform" type="cairo_matrix_t*"/>
				</parameters>
			</method>
			<method name="is_container" symbol="goo_canvas_item_model_is_container">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="lower" symbol="goo_canvas_item_model_lower">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="below" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="move_child" symbol="goo_canvas_item_model_move_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="old_position" type="gint"/>
					<parameter name="new_position" type="gint"/>
				</parameters>
			</method>
			<method name="raise" symbol="goo_canvas_item_model_raise">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="above" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="remove" symbol="goo_canvas_item_model_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="remove_child" symbol="goo_canvas_item_model_remove_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child_num" type="gint"/>
				</parameters>
			</method>
			<method name="rotate" symbol="goo_canvas_item_model_rotate">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="degrees" type="gdouble"/>
					<parameter name="cx" type="gdouble"/>
					<parameter name="cy" type="gdouble"/>
				</parameters>
			</method>
			<method name="scale" symbol="goo_canvas_item_model_scale">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="sx" type="gdouble"/>
					<parameter name="sy" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_child_properties" symbol="goo_canvas_item_model_set_child_properties">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="set_child_properties_valist" symbol="goo_canvas_item_model_set_child_properties_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child" type="GooCanvasItemModel*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</method>
			<method name="set_child_property" symbol="goo_canvas_item_model_set_child_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child" type="GooCanvasItemModel*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_parent" symbol="goo_canvas_item_model_set_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="parent" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="set_simple_transform" symbol="goo_canvas_item_model_set_simple_transform">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
					<parameter name="scale" type="gdouble"/>
					<parameter name="rotation" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_style" symbol="goo_canvas_item_model_set_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="style" type="GooCanvasStyle*"/>
				</parameters>
			</method>
			<method name="set_transform" symbol="goo_canvas_item_model_set_transform">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="transform" type="cairo_matrix_t*"/>
				</parameters>
			</method>
			<method name="skew_x" symbol="goo_canvas_item_model_skew_x">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="degrees" type="gdouble"/>
					<parameter name="cx" type="gdouble"/>
					<parameter name="cy" type="gdouble"/>
				</parameters>
			</method>
			<method name="skew_y" symbol="goo_canvas_item_model_skew_y">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="degrees" type="gdouble"/>
					<parameter name="cx" type="gdouble"/>
					<parameter name="cy" type="gdouble"/>
				</parameters>
			</method>
			<method name="stop_animation" symbol="goo_canvas_item_model_stop_animation">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</method>
			<method name="translate" symbol="goo_canvas_item_model_translate">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="tx" type="gdouble"/>
					<parameter name="ty" type="gdouble"/>
				</parameters>
			</method>
			<property name="can-focus" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="description" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="parent" type="GooCanvasItemModel*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pointer-events" type="GooCanvasPointerEvents" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="tooltip" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="transform" type="GooCairoMatrix*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="visibility" type="GooCanvasItemVisibility" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="visibility-threshold" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="animation-finished" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="stopped" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="recompute_bounds" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="child-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child_num" type="gint"/>
				</parameters>
			</signal>
			<signal name="child-moved" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="old_child_num" type="gint"/>
					<parameter name="new_child_num" type="gint"/>
				</parameters>
			</signal>
			<signal name="child-notify" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</signal>
			<signal name="child-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child_num" type="gint"/>
				</parameters>
			</signal>
			<vfunc name="add_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child" type="GooCanvasItemModel*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="create_item">
				<return-type type="GooCanvasItem*"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="canvas" type="GooCanvas*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_child">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child_num" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_child_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child" type="GooCanvasItemModel*"/>
					<parameter name="property_id" type="guint"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_children">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_parent">
				<return-type type="GooCanvasItemModel*"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_style">
				<return-type type="GooCanvasStyle*"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_transform">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="transform" type="cairo_matrix_t*"/>
				</parameters>
			</vfunc>
			<vfunc name="move_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="old_position" type="gint"/>
					<parameter name="new_position" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="child_num" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_child_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GooCanvasItemModel*"/>
					<parameter name="child" type="GooCanvasItemModel*"/>
					<parameter name="property_id" type="guint"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="parent" type="GooCanvasItemModel*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="style" type="GooCanvasStyle*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_transform">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GooCanvasItemModel*"/>
					<parameter name="transform" type="cairo_matrix_t*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="NUM_ARROW_POINTS" type="int" value="5"/>
		<union name="GooCanvasPathCommand">
			<field name="simple" type="gpointer"/>
			<field name="curve" type="gpointer"/>
			<field name="arc" type="gpointer"/>
		</union>
	</namespace>
</api>
