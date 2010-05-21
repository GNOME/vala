<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Mx">
		<function name="actor_box_clamp_to_pixels" symbol="mx_actor_box_clamp_to_pixels">
			<return-type type="void"/>
			<parameters>
				<parameter name="box" type="ClutterActorBox*"/>
			</parameters>
		</function>
		<function name="allocate_align_fill" symbol="mx_allocate_align_fill">
			<return-type type="void"/>
			<parameters>
				<parameter name="child" type="ClutterActor*"/>
				<parameter name="childbox" type="ClutterActorBox*"/>
				<parameter name="x_alignment" type="MxAlign"/>
				<parameter name="y_alignment" type="MxAlign"/>
				<parameter name="x_fill" type="gboolean"/>
				<parameter name="y_fill" type="gboolean"/>
			</parameters>
		</function>
		<function name="font_weight_set_from_string" symbol="mx_font_weight_set_from_string">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="set_locale" symbol="mx_set_locale">
			<return-type type="void"/>
		</function>
		<function name="utils_format_time" symbol="mx_utils_format_time">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="time_" type="GTimeVal*"/>
			</parameters>
		</function>
		<callback name="MxClipboardCallbackFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="clipboard" type="MxClipboard*"/>
				<parameter name="text" type="gchar*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<boxed name="MxBorderImage" type-name="MxBorderImage" get-type="mx_border_image_get_type">
			<method name="set_from_string" symbol="mx_border_image_set_from_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GValue*"/>
					<parameter name="str" type="gchar*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<field name="uri" type="gchar*"/>
			<field name="top" type="gint"/>
			<field name="right" type="gint"/>
			<field name="bottom" type="gint"/>
			<field name="left" type="gint"/>
		</boxed>
		<boxed name="MxPadding" type-name="MxPadding" get-type="mx_padding_get_type">
			<field name="top" type="gfloat"/>
			<field name="right" type="gfloat"/>
			<field name="bottom" type="gfloat"/>
			<field name="left" type="gfloat"/>
		</boxed>
		<enum name="MxAlign" type-name="MxAlign" get-type="mx_align_get_type">
			<member name="MX_ALIGN_START" value="0"/>
			<member name="MX_ALIGN_MIDDLE" value="1"/>
			<member name="MX_ALIGN_END" value="2"/>
		</enum>
		<enum name="MxDragAxis" type-name="MxDragAxis" get-type="mx_drag_axis_get_type">
			<member name="MX_DRAG_AXIS_NONE" value="0"/>
			<member name="MX_DRAG_AXIS_X" value="1"/>
			<member name="MX_DRAG_AXIS_Y" value="2"/>
		</enum>
		<enum name="MxFocusDirection" type-name="MxFocusDirection" get-type="mx_focus_direction_get_type">
			<member name="MX_FOCUS_DIRECTION_OUT" value="0"/>
			<member name="MX_FOCUS_DIRECTION_UP" value="1"/>
			<member name="MX_FOCUS_DIRECTION_DOWN" value="2"/>
			<member name="MX_FOCUS_DIRECTION_LEFT" value="3"/>
			<member name="MX_FOCUS_DIRECTION_RIGHT" value="4"/>
			<member name="MX_FOCUS_DIRECTION_NEXT" value="5"/>
			<member name="MX_FOCUS_DIRECTION_PREVIOUS" value="6"/>
		</enum>
		<enum name="MxFocusHint" type-name="MxFocusHint" get-type="mx_focus_hint_get_type">
			<member name="MX_FOCUS_HINT_FIRST" value="0"/>
			<member name="MX_FOCUS_HINT_LAST" value="1"/>
			<member name="MX_FOCUS_HINT_PRIOR" value="2"/>
		</enum>
		<enum name="MxFontWeight" type-name="MxFontWeight" get-type="mx_font_weight_get_type">
			<member name="MX_FONT_WEIGHT_NORMAL" value="0"/>
			<member name="MX_FONT_WEIGHT_BOLD" value="1"/>
			<member name="MX_FONT_WEIGHT_BOLDER" value="2"/>
			<member name="MX_FONT_WEIGHT_LIGHTER" value="3"/>
		</enum>
		<enum name="MxLongPressAction" type-name="MxLongPressAction" get-type="mx_long_press_action_get_type">
			<member name="MX_LONG_PRESS_QUERY" value="0"/>
			<member name="MX_LONG_PRESS_ACTION" value="1"/>
			<member name="MX_LONG_PRESS_CANCEL" value="2"/>
		</enum>
		<enum name="MxOrientation" type-name="MxOrientation" get-type="mx_orientation_get_type">
			<member name="MX_ORIENTATION_HORIZONTAL" value="0"/>
			<member name="MX_ORIENTATION_VERTICAL" value="1"/>
		</enum>
		<enum name="MxScrollPolicy" type-name="MxScrollPolicy" get-type="mx_scroll_policy_get_type">
			<member name="MX_SCROLL_POLICY_NONE" value="0"/>
			<member name="MX_SCROLL_POLICY_HORIZONTAL" value="1"/>
			<member name="MX_SCROLL_POLICY_VERTICAL" value="2"/>
			<member name="MX_SCROLL_POLICY_BOTH" value="3"/>
		</enum>
		<enum name="MxStyleError" type-name="MxStyleError" get-type="mx_style_error_get_type">
			<member name="MX_STYLE_ERROR_INVALID_FILE" value="0"/>
		</enum>
		<flags name="MxApplicationFlags" type-name="MxApplicationFlags" get-type="mx_application_flags_get_type">
			<member name="MX_APPLICATION_SINGLE_INSTANCE" value="1"/>
			<member name="MX_APPLICATION_KEEP_ALIVE" value="4"/>
		</flags>
		<flags name="MxStyleChangedFlags" type-name="MxStyleChangedFlags" get-type="mx_style_changed_flags_get_type">
			<member name="MX_STYLE_CHANGED_NONE" value="0"/>
			<member name="MX_STYLE_CHANGED_FORCE" value="1"/>
		</flags>
		<object name="MxAction" parent="GInitiallyUnowned" type-name="MxAction" get-type="mx_action_get_type">
			<method name="get_active" symbol="mx_action_get_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="action" type="MxAction*"/>
				</parameters>
			</method>
			<method name="get_display_name" symbol="mx_action_get_display_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="action" type="MxAction*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="mx_action_get_icon">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="action" type="MxAction*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="mx_action_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="action" type="MxAction*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_action_new">
				<return-type type="MxAction*"/>
			</constructor>
			<constructor name="new_full" symbol="mx_action_new_full">
				<return-type type="MxAction*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="display_name" type="gchar*"/>
					<parameter name="activated_cb" type="GCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</constructor>
			<method name="set_active" symbol="mx_action_set_active">
				<return-type type="void"/>
				<parameters>
					<parameter name="action" type="MxAction*"/>
					<parameter name="active" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_display_name" symbol="mx_action_set_display_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="action" type="MxAction*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_icon" symbol="mx_action_set_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="action" type="MxAction*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="mx_action_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="action" type="MxAction*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<property name="active" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="display-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="icon" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="activated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="action" type="MxAction*"/>
				</parameters>
			</signal>
		</object>
		<object name="MxAdjustment" parent="GObject" type-name="MxAdjustment" get-type="mx_adjustment_get_type">
			<method name="get_elastic" symbol="mx_adjustment_get_elastic">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
				</parameters>
			</method>
			<method name="get_lower" symbol="mx_adjustment_get_lower">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
				</parameters>
			</method>
			<method name="get_page_increment" symbol="mx_adjustment_get_page_increment">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
				</parameters>
			</method>
			<method name="get_page_size" symbol="mx_adjustment_get_page_size">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
				</parameters>
			</method>
			<method name="get_step_increment" symbol="mx_adjustment_get_step_increment">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
				</parameters>
			</method>
			<method name="get_upper" symbol="mx_adjustment_get_upper">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="mx_adjustment_get_value">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
				</parameters>
			</method>
			<method name="get_values" symbol="mx_adjustment_get_values">
				<return-type type="void"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
					<parameter name="value" type="gdouble*"/>
					<parameter name="lower" type="gdouble*"/>
					<parameter name="upper" type="gdouble*"/>
					<parameter name="step_increment" type="gdouble*"/>
					<parameter name="page_increment" type="gdouble*"/>
					<parameter name="page_size" type="gdouble*"/>
				</parameters>
			</method>
			<method name="interpolate" symbol="mx_adjustment_interpolate">
				<return-type type="void"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
					<parameter name="value" type="gdouble"/>
					<parameter name="duration" type="guint"/>
					<parameter name="mode" type="gulong"/>
				</parameters>
			</method>
			<method name="interpolate_relative" symbol="mx_adjustment_interpolate_relative">
				<return-type type="void"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
					<parameter name="offset" type="gdouble"/>
					<parameter name="duration" type="guint"/>
					<parameter name="mode" type="gulong"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_adjustment_new">
				<return-type type="MxAdjustment*"/>
			</constructor>
			<constructor name="new_with_values" symbol="mx_adjustment_new_with_values">
				<return-type type="MxAdjustment*"/>
				<parameters>
					<parameter name="value" type="gdouble"/>
					<parameter name="lower" type="gdouble"/>
					<parameter name="upper" type="gdouble"/>
					<parameter name="step_increment" type="gdouble"/>
					<parameter name="page_increment" type="gdouble"/>
					<parameter name="page_size" type="gdouble"/>
				</parameters>
			</constructor>
			<method name="set_elastic" symbol="mx_adjustment_set_elastic">
				<return-type type="void"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
					<parameter name="elastic" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_lower" symbol="mx_adjustment_set_lower">
				<return-type type="void"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
					<parameter name="lower" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_page_increment" symbol="mx_adjustment_set_page_increment">
				<return-type type="void"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
					<parameter name="increment" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_page_size" symbol="mx_adjustment_set_page_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
					<parameter name="page_size" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_step_increment" symbol="mx_adjustment_set_step_increment">
				<return-type type="void"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
					<parameter name="increment" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_upper" symbol="mx_adjustment_set_upper">
				<return-type type="void"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
					<parameter name="upper" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_value" symbol="mx_adjustment_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
					<parameter name="value" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_values" symbol="mx_adjustment_set_values">
				<return-type type="void"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
					<parameter name="value" type="gdouble"/>
					<parameter name="lower" type="gdouble"/>
					<parameter name="upper" type="gdouble"/>
					<parameter name="step_increment" type="gdouble"/>
					<parameter name="page_increment" type="gdouble"/>
					<parameter name="page_size" type="gdouble"/>
				</parameters>
			</method>
			<property name="elastic" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="lower" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="page-increment" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="page-size" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="step-increment" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="upper" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="value" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
				</parameters>
			</signal>
		</object>
		<object name="MxApplication" parent="GObject" type-name="MxApplication" get-type="mx_application_get_type">
			<method name="add_action" symbol="mx_application_add_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="MxApplication*"/>
					<parameter name="action" type="MxAction*"/>
				</parameters>
			</method>
			<method name="add_window" symbol="mx_application_add_window">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="MxApplication*"/>
					<parameter name="window" type="MxWindow*"/>
				</parameters>
			</method>
			<method name="create_window" symbol="mx_application_create_window">
				<return-type type="MxWindow*"/>
				<parameters>
					<parameter name="application" type="MxApplication*"/>
				</parameters>
			</method>
			<method name="get_actions" symbol="mx_application_get_actions">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="application" type="MxApplication*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="mx_application_get_flags">
				<return-type type="MxApplicationFlags"/>
				<parameters>
					<parameter name="application" type="MxApplication*"/>
				</parameters>
			</method>
			<method name="get_windows" symbol="mx_application_get_windows">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="application" type="MxApplication*"/>
				</parameters>
			</method>
			<method name="invoke_action" symbol="mx_application_invoke_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="MxApplication*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="is_running" symbol="mx_application_is_running">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="application" type="MxApplication*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_application_new">
				<return-type type="MxApplication*"/>
				<parameters>
					<parameter name="argc" type="gint*"/>
					<parameter name="argv" type="gchar***"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="flags" type="MxApplicationFlags"/>
				</parameters>
			</constructor>
			<method name="quit" symbol="mx_application_quit">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="MxApplication*"/>
				</parameters>
			</method>
			<method name="remove_action" symbol="mx_application_remove_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="MxApplication*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove_window" symbol="mx_application_remove_window">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="MxApplication*"/>
					<parameter name="window" type="MxWindow*"/>
				</parameters>
			</method>
			<method name="run" symbol="mx_application_run">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="MxApplication*"/>
				</parameters>
			</method>
			<property name="application-name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="flags" type="guint" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="actions-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="MxApplication*"/>
				</parameters>
			</signal>
			<vfunc name="create_window">
				<return-type type="MxWindow*"/>
				<parameters>
					<parameter name="app" type="MxApplication*"/>
				</parameters>
			</vfunc>
			<vfunc name="raise">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="MxApplication*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="MxBin" parent="MxWidget" type-name="MxBin" get-type="mx_bin_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="allocate_child" symbol="mx_bin_allocate_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="bin" type="MxBin*"/>
					<parameter name="box" type="ClutterActorBox*"/>
					<parameter name="flags" type="ClutterAllocationFlags"/>
				</parameters>
			</method>
			<method name="get_alignment" symbol="mx_bin_get_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="bin" type="MxBin*"/>
					<parameter name="x_align" type="MxAlign*"/>
					<parameter name="y_align" type="MxAlign*"/>
				</parameters>
			</method>
			<method name="get_child" symbol="mx_bin_get_child">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="bin" type="MxBin*"/>
				</parameters>
			</method>
			<method name="get_fill" symbol="mx_bin_get_fill">
				<return-type type="void"/>
				<parameters>
					<parameter name="bin" type="MxBin*"/>
					<parameter name="x_fill" type="gboolean*"/>
					<parameter name="y_fill" type="gboolean*"/>
				</parameters>
			</method>
			<method name="set_alignment" symbol="mx_bin_set_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="bin" type="MxBin*"/>
					<parameter name="x_align" type="MxAlign"/>
					<parameter name="y_align" type="MxAlign"/>
				</parameters>
			</method>
			<method name="set_child" symbol="mx_bin_set_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="bin" type="MxBin*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="set_fill" symbol="mx_bin_set_fill">
				<return-type type="void"/>
				<parameters>
					<parameter name="bin" type="MxBin*"/>
					<parameter name="x_fill" type="gboolean"/>
					<parameter name="y_fill" type="gboolean"/>
				</parameters>
			</method>
			<property name="child" type="ClutterActor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-align" type="MxAlign" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-fill" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-align" type="MxAlign" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-fill" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxBoxLayout" parent="MxWidget" type-name="MxBoxLayout" get-type="mx_box_layout_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxScrollable"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="add_actor" symbol="mx_box_layout_add_actor">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxBoxLayout*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</method>
			<method name="add_actor_with_properties" symbol="mx_box_layout_add_actor_with_properties">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxBoxLayout*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="position" type="gint"/>
					<parameter name="first_property" type="char*"/>
				</parameters>
			</method>
			<method name="get_enable_animations" symbol="mx_box_layout_get_enable_animations">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="box" type="MxBoxLayout*"/>
				</parameters>
			</method>
			<method name="get_orientation" symbol="mx_box_layout_get_orientation">
				<return-type type="MxOrientation"/>
				<parameters>
					<parameter name="box" type="MxBoxLayout*"/>
				</parameters>
			</method>
			<method name="get_spacing" symbol="mx_box_layout_get_spacing">
				<return-type type="guint"/>
				<parameters>
					<parameter name="box" type="MxBoxLayout*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_box_layout_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_enable_animations" symbol="mx_box_layout_set_enable_animations">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxBoxLayout*"/>
					<parameter name="enable_animations" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_orientation" symbol="mx_box_layout_set_orientation">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxBoxLayout*"/>
					<parameter name="orientation" type="MxOrientation"/>
				</parameters>
			</method>
			<method name="set_spacing" symbol="mx_box_layout_set_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxBoxLayout*"/>
					<parameter name="spacing" type="guint"/>
				</parameters>
			</method>
			<property name="enable-animations" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="orientation" type="MxOrientation" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="spacing" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxBoxLayoutChild" parent="ClutterChildMeta" type-name="MxBoxLayoutChild" get-type="mx_box_layout_child_get_type">
			<method name="get_expand" symbol="mx_box_layout_child_get_expand">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="box_layout" type="MxBoxLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_x_align" symbol="mx_box_layout_child_get_x_align">
				<return-type type="MxAlign"/>
				<parameters>
					<parameter name="box_layout" type="MxBoxLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_x_fill" symbol="mx_box_layout_child_get_x_fill">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="box_layout" type="MxBoxLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_y_align" symbol="mx_box_layout_child_get_y_align">
				<return-type type="MxAlign"/>
				<parameters>
					<parameter name="box_layout" type="MxBoxLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_y_fill" symbol="mx_box_layout_child_get_y_fill">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="box_layout" type="MxBoxLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="set_expand" symbol="mx_box_layout_child_set_expand">
				<return-type type="void"/>
				<parameters>
					<parameter name="box_layout" type="MxBoxLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="expand" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_x_align" symbol="mx_box_layout_child_set_x_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="box_layout" type="MxBoxLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="x_align" type="MxAlign"/>
				</parameters>
			</method>
			<method name="set_x_fill" symbol="mx_box_layout_child_set_x_fill">
				<return-type type="void"/>
				<parameters>
					<parameter name="box_layout" type="MxBoxLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="x_fill" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_y_align" symbol="mx_box_layout_child_set_y_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="box_layout" type="MxBoxLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="y_align" type="MxAlign"/>
				</parameters>
			</method>
			<method name="set_y_fill" symbol="mx_box_layout_child_set_y_fill">
				<return-type type="void"/>
				<parameters>
					<parameter name="box_layout" type="MxBoxLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="y_fill" type="gboolean"/>
				</parameters>
			</method>
			<property name="expand" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-align" type="MxAlign" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-fill" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-align" type="MxAlign" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-fill" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="expand" type="gboolean"/>
			<field name="x_fill" type="gboolean"/>
			<field name="y_fill" type="gboolean"/>
			<field name="x_align" type="MxAlign"/>
			<field name="y_align" type="MxAlign"/>
		</object>
		<object name="MxButton" parent="MxBin" type-name="MxButton" get-type="mx_button_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="get_is_toggle" symbol="mx_button_get_is_toggle">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="button" type="MxButton*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="mx_button_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="button" type="MxButton*"/>
				</parameters>
			</method>
			<method name="get_toggled" symbol="mx_button_get_toggled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="button" type="MxButton*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_button_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<constructor name="new_with_label" symbol="mx_button_new_with_label">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_is_toggle" symbol="mx_button_set_is_toggle">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="MxButton*"/>
					<parameter name="toggle" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_label" symbol="mx_button_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="MxButton*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_toggled" symbol="mx_button_set_toggled">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="MxButton*"/>
					<parameter name="toggled" type="gboolean"/>
				</parameters>
			</method>
			<property name="is-toggle" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="toggled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="clicked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="MxButton*"/>
				</parameters>
			</signal>
		</object>
		<object name="MxButtonGroup" parent="GInitiallyUnowned" type-name="MxButtonGroup" get-type="mx_button_group_get_type">
			<method name="add" symbol="mx_button_group_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="MxButtonGroup*"/>
					<parameter name="button" type="MxButton*"/>
				</parameters>
			</method>
			<method name="foreach" symbol="mx_button_group_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="MxButtonGroup*"/>
					<parameter name="callback" type="ClutterCallback"/>
					<parameter name="userdata" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_active_button" symbol="mx_button_group_get_active_button">
				<return-type type="MxButton*"/>
				<parameters>
					<parameter name="group" type="MxButtonGroup*"/>
				</parameters>
			</method>
			<method name="get_allow_no_active" symbol="mx_button_group_get_allow_no_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="group" type="MxButtonGroup*"/>
				</parameters>
			</method>
			<method name="get_buttons" symbol="mx_button_group_get_buttons">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="group" type="MxButtonGroup*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_button_group_new">
				<return-type type="MxButtonGroup*"/>
			</constructor>
			<method name="remove" symbol="mx_button_group_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="MxButtonGroup*"/>
					<parameter name="button" type="MxButton*"/>
				</parameters>
			</method>
			<method name="set_active_button" symbol="mx_button_group_set_active_button">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="MxButtonGroup*"/>
					<parameter name="button" type="MxButton*"/>
				</parameters>
			</method>
			<method name="set_allow_no_active" symbol="mx_button_group_set_allow_no_active">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="MxButtonGroup*"/>
					<parameter name="allow_no_active" type="gboolean"/>
				</parameters>
			</method>
			<property name="active-button" type="MxButton*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="allow-no-active" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxClipboard" parent="GObject" type-name="MxClipboard" get-type="mx_clipboard_get_type">
			<method name="get_default" symbol="mx_clipboard_get_default">
				<return-type type="MxClipboard*"/>
			</method>
			<method name="get_text" symbol="mx_clipboard_get_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="clipboard" type="MxClipboard*"/>
					<parameter name="callback" type="MxClipboardCallbackFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_text" symbol="mx_clipboard_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="clipboard" type="MxClipboard*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
		</object>
		<object name="MxComboBox" parent="MxWidget" type-name="MxComboBox" get-type="mx_combo_box_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="append_text" symbol="mx_combo_box_append_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxComboBox*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_active_icon_name" symbol="mx_combo_box_get_active_icon_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="box" type="MxComboBox*"/>
				</parameters>
			</method>
			<method name="get_active_text" symbol="mx_combo_box_get_active_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="box" type="MxComboBox*"/>
				</parameters>
			</method>
			<method name="get_index" symbol="mx_combo_box_get_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="box" type="MxComboBox*"/>
				</parameters>
			</method>
			<method name="insert_text" symbol="mx_combo_box_insert_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxComboBox*"/>
					<parameter name="position" type="gint"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="insert_text_with_icon" symbol="mx_combo_box_insert_text_with_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxComboBox*"/>
					<parameter name="position" type="gint"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="icon" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_combo_box_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="prepend_text" symbol="mx_combo_box_prepend_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxComboBox*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove_text" symbol="mx_combo_box_remove_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxComboBox*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</method>
			<method name="set_active_icon_name" symbol="mx_combo_box_set_active_icon_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxComboBox*"/>
					<parameter name="icon_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_active_text" symbol="mx_combo_box_set_active_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxComboBox*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_index" symbol="mx_combo_box_set_index">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="MxComboBox*"/>
					<parameter name="index" type="gint"/>
				</parameters>
			</method>
			<property name="active-icon-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="active-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="index" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxDeformBowTie" parent="MxDeformTexture" type-name="MxDeformBowTie" get-type="mx_deform_bow_tie_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<method name="get_flip_back" symbol="mx_deform_bow_tie_get_flip_back">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="bow_tie" type="MxDeformBowTie*"/>
				</parameters>
			</method>
			<method name="get_period" symbol="mx_deform_bow_tie_get_period">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="bow_tie" type="MxDeformBowTie*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_deform_bow_tie_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_flip_back" symbol="mx_deform_bow_tie_set_flip_back">
				<return-type type="void"/>
				<parameters>
					<parameter name="bow_tie" type="MxDeformBowTie*"/>
					<parameter name="flip_back" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_period" symbol="mx_deform_bow_tie_set_period">
				<return-type type="void"/>
				<parameters>
					<parameter name="bow_tie" type="MxDeformBowTie*"/>
					<parameter name="period" type="gdouble"/>
				</parameters>
			</method>
			<property name="flip-back" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="period" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxDeformPageTurn" parent="MxDeformTexture" type-name="MxDeformPageTurn" get-type="mx_deform_page_turn_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<method name="get_angle" symbol="mx_deform_page_turn_get_angle">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="page_turn" type="MxDeformPageTurn*"/>
				</parameters>
			</method>
			<method name="get_period" symbol="mx_deform_page_turn_get_period">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="page_turn" type="MxDeformPageTurn*"/>
				</parameters>
			</method>
			<method name="get_radius" symbol="mx_deform_page_turn_get_radius">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="page_turn" type="MxDeformPageTurn*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_deform_page_turn_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_angle" symbol="mx_deform_page_turn_set_angle">
				<return-type type="void"/>
				<parameters>
					<parameter name="page_turn" type="MxDeformPageTurn*"/>
					<parameter name="angle" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_period" symbol="mx_deform_page_turn_set_period">
				<return-type type="void"/>
				<parameters>
					<parameter name="page_turn" type="MxDeformPageTurn*"/>
					<parameter name="period" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_radius" symbol="mx_deform_page_turn_set_radius">
				<return-type type="void"/>
				<parameters>
					<parameter name="page_turn" type="MxDeformPageTurn*"/>
					<parameter name="radius" type="gdouble"/>
				</parameters>
			</method>
			<property name="angle" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="period" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="radius" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxDeformTexture" parent="MxWidget" type-name="MxDeformTexture" get-type="mx_deform_texture_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<method name="get_resolution" symbol="mx_deform_texture_get_resolution">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="MxDeformTexture*"/>
					<parameter name="tiles_x" type="gint*"/>
					<parameter name="tiles_y" type="gint*"/>
				</parameters>
			</method>
			<method name="get_textures" symbol="mx_deform_texture_get_textures">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="MxDeformTexture*"/>
					<parameter name="front" type="ClutterTexture**"/>
					<parameter name="back" type="ClutterTexture**"/>
				</parameters>
			</method>
			<method name="invalidate" symbol="mx_deform_texture_invalidate">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="MxDeformTexture*"/>
				</parameters>
			</method>
			<method name="set_resolution" symbol="mx_deform_texture_set_resolution">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="MxDeformTexture*"/>
					<parameter name="tiles_x" type="gint"/>
					<parameter name="tiles_y" type="gint"/>
				</parameters>
			</method>
			<method name="set_textures" symbol="mx_deform_texture_set_textures">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="MxDeformTexture*"/>
					<parameter name="front" type="ClutterTexture*"/>
					<parameter name="back" type="ClutterTexture*"/>
				</parameters>
			</method>
			<property name="back" type="ClutterTexture*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="front" type="ClutterTexture*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="tiles-x" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="tiles-y" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="deform">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="MxDeformTexture*"/>
					<parameter name="vertex" type="CoglTextureVertex*"/>
					<parameter name="width" type="gfloat"/>
					<parameter name="height" type="gfloat"/>
				</parameters>
			</vfunc>
		</object>
		<object name="MxDeformWaves" parent="MxDeformTexture" type-name="MxDeformWaves" get-type="mx_deform_waves_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<method name="get_amplitude" symbol="mx_deform_waves_get_amplitude">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="waves" type="MxDeformWaves*"/>
				</parameters>
			</method>
			<method name="get_angle" symbol="mx_deform_waves_get_angle">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="waves" type="MxDeformWaves*"/>
				</parameters>
			</method>
			<method name="get_period" symbol="mx_deform_waves_get_period">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="waves" type="MxDeformWaves*"/>
				</parameters>
			</method>
			<method name="get_radius" symbol="mx_deform_waves_get_radius">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="waves" type="MxDeformWaves*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_deform_waves_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_amplitude" symbol="mx_deform_waves_set_amplitude">
				<return-type type="void"/>
				<parameters>
					<parameter name="waves" type="MxDeformWaves*"/>
					<parameter name="amplitude" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_angle" symbol="mx_deform_waves_set_angle">
				<return-type type="void"/>
				<parameters>
					<parameter name="waves" type="MxDeformWaves*"/>
					<parameter name="angle" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_period" symbol="mx_deform_waves_set_period">
				<return-type type="void"/>
				<parameters>
					<parameter name="waves" type="MxDeformWaves*"/>
					<parameter name="period" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_radius" symbol="mx_deform_waves_set_radius">
				<return-type type="void"/>
				<parameters>
					<parameter name="waves" type="MxDeformWaves*"/>
					<parameter name="radius" type="gdouble"/>
				</parameters>
			</method>
			<property name="amplitude" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="angle" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="period" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="radius" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxEntry" parent="MxWidget" type-name="MxEntry" get-type="mx_entry_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="get_clutter_text" symbol="mx_entry_get_clutter_text">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="entry" type="MxEntry*"/>
				</parameters>
			</method>
			<method name="get_hint_text" symbol="mx_entry_get_hint_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="entry" type="MxEntry*"/>
				</parameters>
			</method>
			<method name="get_password_char" symbol="mx_entry_get_password_char">
				<return-type type="gunichar"/>
				<parameters>
					<parameter name="entry" type="MxEntry*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="mx_entry_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="entry" type="MxEntry*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_entry_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<constructor name="new_with_text" symbol="mx_entry_new_with_text">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_hint_text" symbol="mx_entry_set_hint_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="MxEntry*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_password_char" symbol="mx_entry_set_password_char">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="MxEntry*"/>
					<parameter name="password_char" type="gunichar"/>
				</parameters>
			</method>
			<method name="set_primary_icon_from_file" symbol="mx_entry_set_primary_icon_from_file">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="MxEntry*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_secondary_icon_from_file" symbol="mx_entry_set_secondary_icon_from_file">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="MxEntry*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_text" symbol="mx_entry_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="MxEntry*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<property name="clutter-text" type="ClutterText*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="hint-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="password-char" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="primary-icon-clicked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="MxEntry*"/>
				</parameters>
			</signal>
			<signal name="secondary-icon-clicked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="MxEntry*"/>
				</parameters>
			</signal>
		</object>
		<object name="MxExpander" parent="MxBin" type-name="MxExpander" get-type="mx_expander_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="get_expanded" symbol="mx_expander_get_expanded">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="expander" type="MxExpander*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_expander_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_expanded" symbol="mx_expander_set_expanded">
				<return-type type="void"/>
				<parameters>
					<parameter name="expander" type="MxExpander*"/>
					<parameter name="expanded" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_label" symbol="mx_expander_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="expander" type="MxExpander*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<property name="expanded" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="expand-complete" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="expander" type="MxExpander*"/>
				</parameters>
			</signal>
		</object>
		<object name="MxFloatingWidget" parent="MxWidget" type-name="MxFloatingWidget" get-type="mx_floating_widget_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<vfunc name="floating_paint">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<vfunc name="floating_pick">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="MxFocusManager" parent="GObject" type-name="MxFocusManager" get-type="mx_focus_manager_get_type">
			<method name="get_focused" symbol="mx_focus_manager_get_focused">
				<return-type type="MxFocusable*"/>
				<parameters>
					<parameter name="manager" type="MxFocusManager*"/>
				</parameters>
			</method>
			<method name="get_for_stage" symbol="mx_focus_manager_get_for_stage">
				<return-type type="MxFocusManager*"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="get_stage" symbol="mx_focus_manager_get_stage">
				<return-type type="ClutterStage*"/>
				<parameters>
					<parameter name="manager" type="MxFocusManager*"/>
				</parameters>
			</method>
			<method name="move_focus" symbol="mx_focus_manager_move_focus">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="MxFocusManager*"/>
					<parameter name="direction" type="MxFocusDirection"/>
				</parameters>
			</method>
			<method name="push_focus" symbol="mx_focus_manager_push_focus">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="MxFocusManager*"/>
					<parameter name="focusable" type="MxFocusable*"/>
				</parameters>
			</method>
			<property name="focused" type="ClutterActor*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="stage" type="ClutterStage*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="MxFrame" parent="MxBin" type-name="MxFrame" get-type="mx_frame_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxFocusable"/>
			</implements>
			<constructor name="new" symbol="mx_frame_new">
				<return-type type="ClutterActor*"/>
			</constructor>
		</object>
		<object name="MxGrid" parent="MxWidget" type-name="MxGrid" get-type="mx_grid_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxScrollable"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="get_child_x_align" symbol="mx_grid_get_child_x_align">
				<return-type type="MxAlign"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
				</parameters>
			</method>
			<method name="get_child_y_align" symbol="mx_grid_get_child_y_align">
				<return-type type="MxAlign"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
				</parameters>
			</method>
			<method name="get_column_spacing" symbol="mx_grid_get_column_spacing">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
				</parameters>
			</method>
			<method name="get_homogenous_columns" symbol="mx_grid_get_homogenous_columns">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
				</parameters>
			</method>
			<method name="get_homogenous_rows" symbol="mx_grid_get_homogenous_rows">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
				</parameters>
			</method>
			<method name="get_line_alignment" symbol="mx_grid_get_line_alignment">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
				</parameters>
			</method>
			<method name="get_max_stride" symbol="mx_grid_get_max_stride">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
				</parameters>
			</method>
			<method name="get_orientation" symbol="mx_grid_get_orientation">
				<return-type type="MxOrientation"/>
				<parameters>
					<parameter name="grid" type="MxGrid*"/>
				</parameters>
			</method>
			<method name="get_row_spacing" symbol="mx_grid_get_row_spacing">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_grid_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_child_x_align" symbol="mx_grid_set_child_x_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
					<parameter name="value" type="MxAlign"/>
				</parameters>
			</method>
			<method name="set_child_y_align" symbol="mx_grid_set_child_y_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
					<parameter name="value" type="MxAlign"/>
				</parameters>
			</method>
			<method name="set_column_spacing" symbol="mx_grid_set_column_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
					<parameter name="value" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_homogenous_columns" symbol="mx_grid_set_homogenous_columns">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_homogenous_rows" symbol="mx_grid_set_homogenous_rows">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_line_alignment" symbol="mx_grid_set_line_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
					<parameter name="value" type="MxAlign"/>
				</parameters>
			</method>
			<method name="set_max_stride" symbol="mx_grid_set_max_stride">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_orientation" symbol="mx_grid_set_orientation">
				<return-type type="void"/>
				<parameters>
					<parameter name="grid" type="MxGrid*"/>
					<parameter name="orientation" type="MxOrientation"/>
				</parameters>
			</method>
			<method name="set_row_spacing" symbol="mx_grid_set_row_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxGrid*"/>
					<parameter name="value" type="gfloat"/>
				</parameters>
			</method>
			<property name="child-x-align" type="MxAlign" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="child-y-align" type="MxAlign" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="column-spacing" type="gfloat" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="homogenous-columns" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="homogenous-rows" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="line-alignment" type="MxAlign" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="max-stride" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="orientation" type="MxOrientation" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="row-spacing" type="gfloat" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="MxIcon" parent="MxWidget" type-name="MxIcon" get-type="mx_icon_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<method name="get_icon_name" symbol="mx_icon_get_icon_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="icon" type="MxIcon*"/>
				</parameters>
			</method>
			<method name="get_icon_size" symbol="mx_icon_get_icon_size">
				<return-type type="gint"/>
				<parameters>
					<parameter name="icon" type="MxIcon*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_icon_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_icon_name" symbol="mx_icon_set_icon_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon" type="MxIcon*"/>
					<parameter name="icon_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_icon_size" symbol="mx_icon_set_icon_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon" type="MxIcon*"/>
					<parameter name="size" type="gint"/>
				</parameters>
			</method>
			<property name="icon-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="icon-size" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxIconTheme" parent="GObject" type-name="MxIconTheme" get-type="mx_icon_theme_get_type">
			<method name="get_default" symbol="mx_icon_theme_get_default">
				<return-type type="MxIconTheme*"/>
			</method>
			<method name="get_search_paths" symbol="mx_icon_theme_get_search_paths">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="theme" type="MxIconTheme*"/>
				</parameters>
			</method>
			<method name="get_theme_name" symbol="mx_icon_theme_get_theme_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="theme" type="MxIconTheme*"/>
				</parameters>
			</method>
			<method name="has_icon" symbol="mx_icon_theme_has_icon">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="theme" type="MxIconTheme*"/>
					<parameter name="icon_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="lookup" symbol="mx_icon_theme_lookup">
				<return-type type="CoglHandle"/>
				<parameters>
					<parameter name="theme" type="MxIconTheme*"/>
					<parameter name="icon_name" type="gchar*"/>
					<parameter name="size" type="gint"/>
				</parameters>
			</method>
			<method name="lookup_texture" symbol="mx_icon_theme_lookup_texture">
				<return-type type="ClutterTexture*"/>
				<parameters>
					<parameter name="theme" type="MxIconTheme*"/>
					<parameter name="icon_name" type="gchar*"/>
					<parameter name="size" type="gint"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_icon_theme_new">
				<return-type type="MxIconTheme*"/>
			</constructor>
			<method name="set_search_paths" symbol="mx_icon_theme_set_search_paths">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="MxIconTheme*"/>
					<parameter name="paths" type="GList*"/>
				</parameters>
			</method>
			<method name="set_theme_name" symbol="mx_icon_theme_set_theme_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="MxIconTheme*"/>
					<parameter name="theme_name" type="gchar*"/>
				</parameters>
			</method>
			<property name="theme-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxItemView" parent="MxGrid" type-name="MxItemView" get-type="mx_item_view_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxScrollable"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="add_attribute" symbol="mx_item_view_add_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="item_view" type="MxItemView*"/>
					<parameter name="attribute" type="gchar*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="freeze" symbol="mx_item_view_freeze">
				<return-type type="void"/>
				<parameters>
					<parameter name="item_view" type="MxItemView*"/>
				</parameters>
			</method>
			<method name="get_factory" symbol="mx_item_view_get_factory">
				<return-type type="MxItemFactory*"/>
				<parameters>
					<parameter name="item_view" type="MxItemView*"/>
				</parameters>
			</method>
			<method name="get_item_type" symbol="mx_item_view_get_item_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="item_view" type="MxItemView*"/>
				</parameters>
			</method>
			<method name="get_model" symbol="mx_item_view_get_model">
				<return-type type="ClutterModel*"/>
				<parameters>
					<parameter name="item_view" type="MxItemView*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_item_view_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_factory" symbol="mx_item_view_set_factory">
				<return-type type="void"/>
				<parameters>
					<parameter name="item_view" type="MxItemView*"/>
					<parameter name="factory" type="MxItemFactory*"/>
				</parameters>
			</method>
			<method name="set_item_type" symbol="mx_item_view_set_item_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="item_view" type="MxItemView*"/>
					<parameter name="item_type" type="GType"/>
				</parameters>
			</method>
			<method name="set_model" symbol="mx_item_view_set_model">
				<return-type type="void"/>
				<parameters>
					<parameter name="item_view" type="MxItemView*"/>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</method>
			<method name="thaw" symbol="mx_item_view_thaw">
				<return-type type="void"/>
				<parameters>
					<parameter name="item_view" type="MxItemView*"/>
				</parameters>
			</method>
			<property name="factory" type="GObject*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="item-type" type="GType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="model" type="ClutterModel*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxLabel" parent="MxWidget" type-name="MxLabel" get-type="mx_label_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<method name="get_clutter_text" symbol="mx_label_get_clutter_text">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="label" type="MxLabel*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="mx_label_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="label" type="MxLabel*"/>
				</parameters>
			</method>
			<method name="get_x_align" symbol="mx_label_get_x_align">
				<return-type type="MxAlign"/>
				<parameters>
					<parameter name="label" type="MxLabel*"/>
				</parameters>
			</method>
			<method name="get_y_align" symbol="mx_label_get_y_align">
				<return-type type="MxAlign"/>
				<parameters>
					<parameter name="label" type="MxLabel*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_label_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<constructor name="new_with_text" symbol="mx_label_new_with_text">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_text" symbol="mx_label_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="label" type="MxLabel*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_x_align" symbol="mx_label_set_x_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="label" type="MxLabel*"/>
					<parameter name="align" type="MxAlign"/>
				</parameters>
			</method>
			<method name="set_y_align" symbol="mx_label_set_y_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="label" type="MxLabel*"/>
					<parameter name="align" type="MxAlign"/>
				</parameters>
			</method>
			<property name="clutter-text" type="ClutterText*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-align" type="MxAlign" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-align" type="MxAlign" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxListView" parent="MxBoxLayout" type-name="MxListView" get-type="mx_list_view_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxScrollable"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="add_attribute" symbol="mx_list_view_add_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="list_view" type="MxListView*"/>
					<parameter name="attribute" type="gchar*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="freeze" symbol="mx_list_view_freeze">
				<return-type type="void"/>
				<parameters>
					<parameter name="list_view" type="MxListView*"/>
				</parameters>
			</method>
			<method name="get_factory" symbol="mx_list_view_get_factory">
				<return-type type="MxItemFactory*"/>
				<parameters>
					<parameter name="list_view" type="MxListView*"/>
				</parameters>
			</method>
			<method name="get_item_type" symbol="mx_list_view_get_item_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="list_view" type="MxListView*"/>
				</parameters>
			</method>
			<method name="get_model" symbol="mx_list_view_get_model">
				<return-type type="ClutterModel*"/>
				<parameters>
					<parameter name="list_view" type="MxListView*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_list_view_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_factory" symbol="mx_list_view_set_factory">
				<return-type type="void"/>
				<parameters>
					<parameter name="list_view" type="MxListView*"/>
					<parameter name="factory" type="MxItemFactory*"/>
				</parameters>
			</method>
			<method name="set_item_type" symbol="mx_list_view_set_item_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="list_view" type="MxListView*"/>
					<parameter name="item_type" type="GType"/>
				</parameters>
			</method>
			<method name="set_model" symbol="mx_list_view_set_model">
				<return-type type="void"/>
				<parameters>
					<parameter name="list_view" type="MxListView*"/>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</method>
			<method name="thaw" symbol="mx_list_view_thaw">
				<return-type type="void"/>
				<parameters>
					<parameter name="list_view" type="MxListView*"/>
				</parameters>
			</method>
			<property name="factory" type="GObject*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="item-type" type="GType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="model" type="ClutterModel*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxMenu" parent="MxFloatingWidget" type-name="MxMenu" get-type="mx_menu_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<method name="add_action" symbol="mx_menu_add_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu" type="MxMenu*"/>
					<parameter name="action" type="MxAction*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_menu_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="remove_action" symbol="mx_menu_remove_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu" type="MxMenu*"/>
					<parameter name="action" type="MxAction*"/>
				</parameters>
			</method>
			<method name="remove_all" symbol="mx_menu_remove_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu" type="MxMenu*"/>
				</parameters>
			</method>
			<method name="show_with_position" symbol="mx_menu_show_with_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu" type="MxMenu*"/>
					<parameter name="x" type="gfloat"/>
					<parameter name="y" type="gfloat"/>
				</parameters>
			</method>
			<signal name="action-activated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu" type="MxMenu*"/>
					<parameter name="action" type="MxAction*"/>
				</parameters>
			</signal>
		</object>
		<object name="MxNotebook" parent="MxWidget" type-name="MxNotebook" get-type="mx_notebook_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
			</implements>
			<method name="get_current_page" symbol="mx_notebook_get_current_page">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="notebook" type="MxNotebook*"/>
				</parameters>
			</method>
			<method name="get_enable_gestures" symbol="mx_notebook_get_enable_gestures">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="book" type="MxNotebook*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_notebook_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_current_page" symbol="mx_notebook_set_current_page">
				<return-type type="void"/>
				<parameters>
					<parameter name="notebook" type="MxNotebook*"/>
					<parameter name="page" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="set_enable_gestures" symbol="mx_notebook_set_enable_gestures">
				<return-type type="void"/>
				<parameters>
					<parameter name="book" type="MxNotebook*"/>
					<parameter name="enabled" type="gboolean"/>
				</parameters>
			</method>
			<property name="current-page" type="ClutterActor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="enable-gestures" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxOffscreen" parent="ClutterTexture" type-name="MxOffscreen" get-type="mx_offscreen_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="ClutterContainer"/>
			</implements>
			<method name="get_auto_update" symbol="mx_offscreen_get_auto_update">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="offscreen" type="MxOffscreen*"/>
				</parameters>
			</method>
			<method name="get_child" symbol="mx_offscreen_get_child">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="offscreen" type="MxOffscreen*"/>
				</parameters>
			</method>
			<method name="get_pick_child" symbol="mx_offscreen_get_pick_child">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="offscreen" type="MxOffscreen*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_offscreen_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_auto_update" symbol="mx_offscreen_set_auto_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="offscreen" type="MxOffscreen*"/>
					<parameter name="auto_update" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_child" symbol="mx_offscreen_set_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="offscreen" type="MxOffscreen*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="set_pick_child" symbol="mx_offscreen_set_pick_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="offscreen" type="MxOffscreen*"/>
					<parameter name="pick" type="gboolean"/>
				</parameters>
			</method>
			<method name="update" symbol="mx_offscreen_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="offscreen" type="MxOffscreen*"/>
				</parameters>
			</method>
			<property name="auto-update" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="child" type="ClutterActor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pick-child" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="paint_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxOffscreen*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="MxPathBar" parent="MxWidget" type-name="MxPathBar" get-type="mx_path_bar_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="clear" symbol="mx_path_bar_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
				</parameters>
			</method>
			<method name="get_clear_on_change" symbol="mx_path_bar_get_clear_on_change">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
				</parameters>
			</method>
			<method name="get_editable" symbol="mx_path_bar_get_editable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
				</parameters>
			</method>
			<method name="get_entry" symbol="mx_path_bar_get_entry">
				<return-type type="MxEntry*"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="mx_path_bar_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
					<parameter name="level" type="gint"/>
				</parameters>
			</method>
			<method name="get_level" symbol="mx_path_bar_get_level">
				<return-type type="gint"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="mx_path_bar_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_path_bar_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="pop" symbol="mx_path_bar_pop">
				<return-type type="gint"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
				</parameters>
			</method>
			<method name="push" symbol="mx_path_bar_push">
				<return-type type="gint"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_clear_on_change" symbol="mx_path_bar_set_clear_on_change">
				<return-type type="void"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
					<parameter name="clear_on_change" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_editable" symbol="mx_path_bar_set_editable">
				<return-type type="void"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
					<parameter name="editable" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_label" symbol="mx_path_bar_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
					<parameter name="level" type="gint"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_text" symbol="mx_path_bar_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="bar" type="MxPathBar*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<property name="clear-on-change" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="editable" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="entry" type="MxEntry*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="level" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="MxProgressBar" parent="MxWidget" type-name="MxProgressBar" get-type="mx_progress_bar_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<method name="get_progress" symbol="mx_progress_bar_get_progress">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="bar" type="MxProgressBar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_progress_bar_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_progress" symbol="mx_progress_bar_set_progress">
				<return-type type="void"/>
				<parameters>
					<parameter name="bar" type="MxProgressBar*"/>
					<parameter name="progress" type="gdouble"/>
				</parameters>
			</method>
			<property name="progress" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxScrollBar" parent="MxBin" type-name="MxScrollBar" get-type="mx_scroll_bar_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="get_adjustment" symbol="mx_scroll_bar_get_adjustment">
				<return-type type="MxAdjustment*"/>
				<parameters>
					<parameter name="bar" type="MxScrollBar*"/>
				</parameters>
			</method>
			<method name="get_orientation" symbol="mx_scroll_bar_get_orientation">
				<return-type type="MxOrientation"/>
				<parameters>
					<parameter name="bar" type="MxScrollBar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_scroll_bar_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<constructor name="new_with_adjustment" symbol="mx_scroll_bar_new_with_adjustment">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="adjustment" type="MxAdjustment*"/>
				</parameters>
			</constructor>
			<method name="set_adjustment" symbol="mx_scroll_bar_set_adjustment">
				<return-type type="void"/>
				<parameters>
					<parameter name="bar" type="MxScrollBar*"/>
					<parameter name="adjustment" type="MxAdjustment*"/>
				</parameters>
			</method>
			<method name="set_orientation" symbol="mx_scroll_bar_set_orientation">
				<return-type type="void"/>
				<parameters>
					<parameter name="bar" type="MxScrollBar*"/>
					<parameter name="orientation" type="MxOrientation"/>
				</parameters>
			</method>
			<property name="adjustment" type="MxAdjustment*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="orientation" type="MxOrientation" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="scroll-start" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="bar" type="MxScrollBar*"/>
				</parameters>
			</signal>
			<signal name="scroll-stop" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="bar" type="MxScrollBar*"/>
				</parameters>
			</signal>
		</object>
		<object name="MxScrollView" parent="MxBin" type-name="MxScrollView" get-type="mx_scroll_view_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="ensure_visible" symbol="mx_scroll_view_ensure_visible">
				<return-type type="void"/>
				<parameters>
					<parameter name="scroll" type="MxScrollView*"/>
					<parameter name="geometry" type="ClutterGeometry*"/>
				</parameters>
			</method>
			<method name="get_enable_gestures" symbol="mx_scroll_view_get_enable_gestures">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="scroll" type="MxScrollView*"/>
				</parameters>
			</method>
			<method name="get_enable_mouse_scrolling" symbol="mx_scroll_view_get_enable_mouse_scrolling">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="scroll" type="MxScrollView*"/>
				</parameters>
			</method>
			<method name="get_scroll_policy" symbol="mx_scroll_view_get_scroll_policy">
				<return-type type="MxScrollPolicy"/>
				<parameters>
					<parameter name="scroll" type="MxScrollView*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_scroll_view_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_enable_gestures" symbol="mx_scroll_view_set_enable_gestures">
				<return-type type="void"/>
				<parameters>
					<parameter name="scroll" type="MxScrollView*"/>
					<parameter name="enabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_enable_mouse_scrolling" symbol="mx_scroll_view_set_enable_mouse_scrolling">
				<return-type type="void"/>
				<parameters>
					<parameter name="scroll" type="MxScrollView*"/>
					<parameter name="enabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_scroll_policy" symbol="mx_scroll_view_set_scroll_policy">
				<return-type type="void"/>
				<parameters>
					<parameter name="scroll" type="MxScrollView*"/>
					<parameter name="policy" type="MxScrollPolicy"/>
				</parameters>
			</method>
			<property name="enable-gestures" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="enable-mouse-scrolling" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scroll-policy" type="MxScrollPolicy" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxSlider" parent="MxWidget" type-name="MxSlider" get-type="mx_slider_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<method name="get_value" symbol="mx_slider_get_value">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="bar" type="MxSlider*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_slider_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_value" symbol="mx_slider_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="bar" type="MxSlider*"/>
					<parameter name="value" type="gdouble"/>
				</parameters>
			</method>
			<property name="value" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxStyle" parent="GObject" type-name="MxStyle" get-type="mx_style_get_type">
			<method name="get" symbol="mx_style_get">
				<return-type type="void"/>
				<parameters>
					<parameter name="style" type="MxStyle*"/>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="first_property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_default" symbol="mx_style_get_default">
				<return-type type="MxStyle*"/>
			</method>
			<method name="get_property" symbol="mx_style_get_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="style" type="MxStyle*"/>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="pspec" type="GParamSpec*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_valist" symbol="mx_style_get_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="style" type="MxStyle*"/>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="first_property_name" type="gchar*"/>
					<parameter name="va_args" type="va_list"/>
				</parameters>
			</method>
			<method name="load_from_file" symbol="mx_style_load_from_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="style" type="MxStyle*"/>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_style_new">
				<return-type type="MxStyle*"/>
			</constructor>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="style" type="MxStyle*"/>
				</parameters>
			</signal>
		</object>
		<object name="MxTable" parent="MxWidget" type-name="MxTable" get-type="mx_table_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="add_actor" symbol="mx_table_add_actor">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="row" type="gint"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="add_actor_with_properties" symbol="mx_table_add_actor_with_properties">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="row" type="gint"/>
					<parameter name="column" type="gint"/>
					<parameter name="first_property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_column_count" symbol="mx_table_get_column_count">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
				</parameters>
			</method>
			<method name="get_column_spacing" symbol="mx_table_get_column_spacing">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
				</parameters>
			</method>
			<method name="get_row_count" symbol="mx_table_get_row_count">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
				</parameters>
			</method>
			<method name="get_row_spacing" symbol="mx_table_get_row_spacing">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_table_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_column_spacing" symbol="mx_table_set_column_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="spacing" type="gint"/>
				</parameters>
			</method>
			<method name="set_row_spacing" symbol="mx_table_set_row_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="spacing" type="gint"/>
				</parameters>
			</method>
			<property name="column-count" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="column-spacing" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="row-count" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="row-spacing" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxTableChild" parent="ClutterChildMeta" type-name="MxTableChild" get-type="mx_table_child_get_type">
			<method name="get_column" symbol="mx_table_child_get_column">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_column_span" symbol="mx_table_child_get_column_span">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_row" symbol="mx_table_child_get_row">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_row_span" symbol="mx_table_child_get_row_span">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_x_align" symbol="mx_table_child_get_x_align">
				<return-type type="MxAlign"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_x_expand" symbol="mx_table_child_get_x_expand">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_x_fill" symbol="mx_table_child_get_x_fill">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_y_align" symbol="mx_table_child_get_y_align">
				<return-type type="MxAlign"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_y_expand" symbol="mx_table_child_get_y_expand">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_y_fill" symbol="mx_table_child_get_y_fill">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="set_column" symbol="mx_table_child_set_column">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="col" type="gint"/>
				</parameters>
			</method>
			<method name="set_column_span" symbol="mx_table_child_set_column_span">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="span" type="gint"/>
				</parameters>
			</method>
			<method name="set_row" symbol="mx_table_child_set_row">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</method>
			<method name="set_row_span" symbol="mx_table_child_set_row_span">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="span" type="gint"/>
				</parameters>
			</method>
			<method name="set_x_align" symbol="mx_table_child_set_x_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="align" type="MxAlign"/>
				</parameters>
			</method>
			<method name="set_x_expand" symbol="mx_table_child_set_x_expand">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="expand" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_x_fill" symbol="mx_table_child_set_x_fill">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="fill" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_y_align" symbol="mx_table_child_set_y_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="align" type="MxAlign"/>
				</parameters>
			</method>
			<method name="set_y_expand" symbol="mx_table_child_set_y_expand">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="expand" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_y_fill" symbol="mx_table_child_set_y_fill">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="MxTable*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="fill" type="gboolean"/>
				</parameters>
			</method>
			<property name="column" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="column-span" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="row" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="row-span" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-align" type="MxAlign" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-expand" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-fill" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-align" type="MxAlign" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-expand" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-fill" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxTextureCache" parent="GObject" type-name="MxTextureCache" get-type="mx_texture_cache_get_type">
			<method name="get_actor" symbol="mx_texture_cache_get_actor">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="self" type="MxTextureCache*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_cogl_texture" symbol="mx_texture_cache_get_cogl_texture">
				<return-type type="CoglHandle"/>
				<parameters>
					<parameter name="self" type="MxTextureCache*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_default" symbol="mx_texture_cache_get_default">
				<return-type type="MxTextureCache*"/>
			</method>
			<method name="get_size" symbol="mx_texture_cache_get_size">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="MxTextureCache*"/>
				</parameters>
			</method>
			<method name="get_texture" symbol="mx_texture_cache_get_texture">
				<return-type type="ClutterTexture*"/>
				<parameters>
					<parameter name="self" type="MxTextureCache*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="load_cache" symbol="mx_texture_cache_load_cache">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxTextureCache*"/>
					<parameter name="filename" type="char*"/>
				</parameters>
			</method>
			<vfunc name="error_loading">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxTextureCache*"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</vfunc>
			<vfunc name="loaded">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxTextureCache*"/>
					<parameter name="path" type="gchar*"/>
					<parameter name="texture" type="ClutterTexture*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="MxTextureFrame" parent="ClutterActor" type-name="MxTextureFrame" get-type="mx_texture_frame_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="get_border_values" symbol="mx_texture_frame_get_border_values">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="MxTextureFrame*"/>
					<parameter name="top" type="gfloat*"/>
					<parameter name="right" type="gfloat*"/>
					<parameter name="bottom" type="gfloat*"/>
					<parameter name="left" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_parent_texture" symbol="mx_texture_frame_get_parent_texture">
				<return-type type="ClutterTexture*"/>
				<parameters>
					<parameter name="frame" type="MxTextureFrame*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_texture_frame_new">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="top" type="gfloat"/>
					<parameter name="right" type="gfloat"/>
					<parameter name="bottom" type="gfloat"/>
					<parameter name="left" type="gfloat"/>
				</parameters>
			</constructor>
			<method name="set_border_values" symbol="mx_texture_frame_set_border_values">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="MxTextureFrame*"/>
					<parameter name="top" type="gfloat"/>
					<parameter name="right" type="gfloat"/>
					<parameter name="bottom" type="gfloat"/>
					<parameter name="left" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_parent_texture" symbol="mx_texture_frame_set_parent_texture">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="MxTextureFrame*"/>
					<parameter name="texture" type="ClutterTexture*"/>
				</parameters>
			</method>
			<property name="bottom" type="gfloat" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="left" type="gfloat" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="parent-texture" type="ClutterTexture*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="right" type="gfloat" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="top" type="gfloat" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="MxToggle" parent="MxWidget" type-name="MxToggle" get-type="mx_toggle_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<method name="get_active" symbol="mx_toggle_get_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="toggle" type="MxToggle*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_toggle_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_active" symbol="mx_toggle_set_active">
				<return-type type="void"/>
				<parameters>
					<parameter name="toggle" type="MxToggle*"/>
					<parameter name="active" type="gboolean"/>
				</parameters>
			</method>
			<property name="active" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxToolbar" parent="MxBin" type-name="MxToolbar" get-type="mx_toolbar_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxFocusable"/>
			</implements>
			<method name="get_has_close_button" symbol="mx_toolbar_get_has_close_button">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="toolbar" type="MxToolbar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_toolbar_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_has_close_button" symbol="mx_toolbar_set_has_close_button">
				<return-type type="void"/>
				<parameters>
					<parameter name="toolbar" type="MxToolbar*"/>
					<parameter name="has_close_button" type="gboolean"/>
				</parameters>
			</method>
			<property name="has-close-button" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="close-button-clicked" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="toolbar" type="MxToolbar*"/>
				</parameters>
			</signal>
		</object>
		<object name="MxTooltip" parent="MxFloatingWidget" type-name="MxTooltip" get-type="mx_tooltip_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<method name="get_text" symbol="mx_tooltip_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="tooltip" type="MxTooltip*"/>
				</parameters>
			</method>
			<method name="get_tip_area" symbol="mx_tooltip_get_tip_area">
				<return-type type="ClutterGeometry*"/>
				<parameters>
					<parameter name="tooltip" type="MxTooltip*"/>
				</parameters>
			</method>
			<method name="hide" symbol="mx_tooltip_hide">
				<return-type type="void"/>
				<parameters>
					<parameter name="tooltip" type="MxTooltip*"/>
				</parameters>
			</method>
			<method name="set_text" symbol="mx_tooltip_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="tooltip" type="MxTooltip*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_tip_area" symbol="mx_tooltip_set_tip_area">
				<return-type type="void"/>
				<parameters>
					<parameter name="tooltip" type="MxTooltip*"/>
					<parameter name="area" type="ClutterGeometry*"/>
				</parameters>
			</method>
			<method name="show" symbol="mx_tooltip_show">
				<return-type type="void"/>
				<parameters>
					<parameter name="tooltip" type="MxTooltip*"/>
				</parameters>
			</method>
			<property name="text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="tip-area" type="ClutterGeometry*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxViewport" parent="MxBin" type-name="MxViewport" get-type="mx_viewport_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
				<interface name="ClutterContainer"/>
				<interface name="MxFocusable"/>
				<interface name="MxScrollable"/>
			</implements>
			<method name="get_origin" symbol="mx_viewport_get_origin">
				<return-type type="void"/>
				<parameters>
					<parameter name="viewport" type="MxViewport*"/>
					<parameter name="x" type="gfloat*"/>
					<parameter name="y" type="gfloat*"/>
					<parameter name="z" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_sync_adjustments" symbol="mx_viewport_get_sync_adjustments">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="viewport" type="MxViewport*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_viewport_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_origin" symbol="mx_viewport_set_origin">
				<return-type type="void"/>
				<parameters>
					<parameter name="viewport" type="MxViewport*"/>
					<parameter name="x" type="gfloat"/>
					<parameter name="y" type="gfloat"/>
					<parameter name="z" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_sync_adjustments" symbol="mx_viewport_set_sync_adjustments">
				<return-type type="void"/>
				<parameters>
					<parameter name="viewport" type="MxViewport*"/>
					<parameter name="sync" type="gboolean"/>
				</parameters>
			</method>
			<property name="sync-adjustments" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-origin" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-origin" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="z-origin" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="MxWidget" parent="ClutterActor" type-name="MxWidget" get-type="mx_widget_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="MxStylable"/>
			</implements>
			<method name="get_available_area" symbol="mx_widget_get_available_area">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
					<parameter name="allocation" type="ClutterActorBox*"/>
					<parameter name="area" type="ClutterActorBox*"/>
				</parameters>
			</method>
			<method name="get_background_image" symbol="mx_widget_get_background_image">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="actor" type="MxWidget*"/>
				</parameters>
			</method>
			<method name="get_border_image" symbol="mx_widget_get_border_image">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="actor" type="MxWidget*"/>
				</parameters>
			</method>
			<method name="get_disabled" symbol="mx_widget_get_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
				</parameters>
			</method>
			<method name="get_menu" symbol="mx_widget_get_menu">
				<return-type type="MxMenu*"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
				</parameters>
			</method>
			<method name="get_padding" symbol="mx_widget_get_padding">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
					<parameter name="padding" type="MxPadding*"/>
				</parameters>
			</method>
			<method name="get_tooltip_text" symbol="mx_widget_get_tooltip_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
				</parameters>
			</method>
			<method name="hide_tooltip" symbol="mx_widget_hide_tooltip">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
				</parameters>
			</method>
			<method name="long_press_cancel" symbol="mx_widget_long_press_cancel">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
				</parameters>
			</method>
			<method name="long_press_query" symbol="mx_widget_long_press_query">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
					<parameter name="event" type="ClutterButtonEvent*"/>
				</parameters>
			</method>
			<method name="paint_background" symbol="mx_widget_paint_background">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="mx_widget_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
					<parameter name="disabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_menu" symbol="mx_widget_set_menu">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
					<parameter name="menu" type="MxMenu*"/>
				</parameters>
			</method>
			<method name="set_tooltip_text" symbol="mx_widget_set_tooltip_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="show_tooltip" symbol="mx_widget_show_tooltip">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
				</parameters>
			</method>
			<property name="disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="menu" type="MxMenu*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="tooltip-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="long-press" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="widget" type="MxWidget*"/>
					<parameter name="action" type="gfloat"/>
					<parameter name="x" type="gfloat"/>
					<parameter name="y" type="MxLongPressAction"/>
				</parameters>
			</signal>
			<vfunc name="paint_background">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="MxWidget*"/>
					<parameter name="background" type="ClutterActor*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="MxWindow" parent="GObject" type-name="MxWindow" get-type="mx_window_get_type">
			<method name="get_child" symbol="mx_window_get_child">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
				</parameters>
			</method>
			<method name="get_clutter_stage" symbol="mx_window_get_clutter_stage">
				<return-type type="ClutterStage*"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
				</parameters>
			</method>
			<method name="get_for_stage" symbol="mx_window_get_for_stage">
				<return-type type="MxWindow*"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="get_has_toolbar" symbol="mx_window_get_has_toolbar">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
				</parameters>
			</method>
			<method name="get_icon_name" symbol="mx_window_get_icon_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
				</parameters>
			</method>
			<method name="get_small_screen" symbol="mx_window_get_small_screen">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
				</parameters>
			</method>
			<method name="get_toolbar" symbol="mx_window_get_toolbar">
				<return-type type="MxToolbar*"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
				</parameters>
			</method>
			<method name="get_window_position" symbol="mx_window_get_window_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="mx_window_new">
				<return-type type="MxWindow*"/>
			</constructor>
			<constructor name="new_with_clutter_stage" symbol="mx_window_new_with_clutter_stage">
				<return-type type="MxWindow*"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</constructor>
			<method name="set_child" symbol="mx_window_set_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="set_has_toolbar" symbol="mx_window_set_has_toolbar">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
					<parameter name="toolbar" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_icon_from_cogl_texture" symbol="mx_window_set_icon_from_cogl_texture">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
					<parameter name="texture" type="CoglHandle"/>
				</parameters>
			</method>
			<method name="set_icon_name" symbol="mx_window_set_icon_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
					<parameter name="icon_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_small_screen" symbol="mx_window_set_small_screen">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
					<parameter name="small_screen" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_window_position" symbol="mx_window_set_window_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<property name="child" type="ClutterActor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="clutter-stage" type="ClutterStage*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="has-toolbar" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="icon-cogl-texture" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="icon-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="small-screen" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="toolbar" type="MxToolbar*" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="destroy" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="MxWindow*"/>
				</parameters>
			</signal>
		</object>
		<interface name="MxDraggable" type-name="MxDraggable" get-type="mx_draggable_get_type">
			<requires>
				<interface name="ClutterActor"/>
			</requires>
			<method name="disable" symbol="mx_draggable_disable">
				<return-type type="void"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
				</parameters>
			</method>
			<method name="enable" symbol="mx_draggable_enable">
				<return-type type="void"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
				</parameters>
			</method>
			<method name="get_axis" symbol="mx_draggable_get_axis">
				<return-type type="MxDragAxis"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
				</parameters>
			</method>
			<method name="get_drag_actor" symbol="mx_draggable_get_drag_actor">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
				</parameters>
			</method>
			<method name="get_drag_threshold" symbol="mx_draggable_get_drag_threshold">
				<return-type type="guint"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
				</parameters>
			</method>
			<method name="is_enabled" symbol="mx_draggable_is_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
				</parameters>
			</method>
			<method name="set_axis" symbol="mx_draggable_set_axis">
				<return-type type="void"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
					<parameter name="axis" type="MxDragAxis"/>
				</parameters>
			</method>
			<method name="set_drag_actor" symbol="mx_draggable_set_drag_actor">
				<return-type type="void"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="set_drag_threshold" symbol="mx_draggable_set_drag_threshold">
				<return-type type="void"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
					<parameter name="threshold" type="guint"/>
				</parameters>
			</method>
			<property name="axis" type="MxDragAxis" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="drag-actor" type="ClutterActor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="drag-enabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="drag-threshold" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="drag-begin" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
					<parameter name="event_x" type="gfloat"/>
					<parameter name="event_y" type="gfloat"/>
					<parameter name="event_button" type="gint"/>
					<parameter name="modifiers" type="ClutterModifierType"/>
				</parameters>
			</signal>
			<signal name="drag-end" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
					<parameter name="event_x" type="gfloat"/>
					<parameter name="event_y" type="gfloat"/>
				</parameters>
			</signal>
			<signal name="drag-motion" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
					<parameter name="delta_x" type="gfloat"/>
					<parameter name="delta_y" type="gfloat"/>
				</parameters>
			</signal>
			<vfunc name="disable">
				<return-type type="void"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
				</parameters>
			</vfunc>
			<vfunc name="enable">
				<return-type type="void"/>
				<parameters>
					<parameter name="draggable" type="MxDraggable*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="MxDroppable" type-name="MxDroppable" get-type="mx_droppable_get_type">
			<requires>
				<interface name="ClutterActor"/>
			</requires>
			<method name="accept_drop" symbol="mx_droppable_accept_drop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="droppable" type="MxDroppable*"/>
					<parameter name="draggable" type="MxDraggable*"/>
				</parameters>
			</method>
			<method name="disable" symbol="mx_droppable_disable">
				<return-type type="void"/>
				<parameters>
					<parameter name="droppable" type="MxDroppable*"/>
				</parameters>
			</method>
			<method name="enable" symbol="mx_droppable_enable">
				<return-type type="void"/>
				<parameters>
					<parameter name="droppable" type="MxDroppable*"/>
				</parameters>
			</method>
			<method name="is_enabled" symbol="mx_droppable_is_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="droppable" type="MxDroppable*"/>
				</parameters>
			</method>
			<property name="drop-enabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="drop" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="droppable" type="MxDroppable*"/>
					<parameter name="draggable" type="ClutterActor*"/>
					<parameter name="event_x" type="gfloat"/>
					<parameter name="event_y" type="gfloat"/>
					<parameter name="button" type="gint"/>
					<parameter name="modifiers" type="ClutterModifierType"/>
				</parameters>
			</signal>
			<signal name="over-in" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="droppable" type="MxDroppable*"/>
					<parameter name="draggable" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="over-out" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="droppable" type="MxDroppable*"/>
					<parameter name="draggable" type="ClutterActor*"/>
				</parameters>
			</signal>
			<vfunc name="accept_drop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="droppable" type="MxDroppable*"/>
					<parameter name="draggable" type="MxDraggable*"/>
				</parameters>
			</vfunc>
			<vfunc name="disable">
				<return-type type="void"/>
				<parameters>
					<parameter name="droppable" type="MxDroppable*"/>
				</parameters>
			</vfunc>
			<vfunc name="enable">
				<return-type type="void"/>
				<parameters>
					<parameter name="droppable" type="MxDroppable*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="MxFocusable" type-name="MxFocusable" get-type="mx_focusable_get_type">
			<method name="accept_focus" symbol="mx_focusable_accept_focus">
				<return-type type="MxFocusable*"/>
				<parameters>
					<parameter name="focusable" type="MxFocusable*"/>
					<parameter name="hint" type="MxFocusHint"/>
				</parameters>
			</method>
			<method name="move_focus" symbol="mx_focusable_move_focus">
				<return-type type="MxFocusable*"/>
				<parameters>
					<parameter name="focusable" type="MxFocusable*"/>
					<parameter name="direction" type="MxFocusDirection"/>
					<parameter name="from" type="MxFocusable*"/>
				</parameters>
			</method>
			<vfunc name="accept_focus">
				<return-type type="MxFocusable*"/>
				<parameters>
					<parameter name="focusable" type="MxFocusable*"/>
					<parameter name="hint" type="MxFocusHint"/>
				</parameters>
			</vfunc>
			<vfunc name="move_focus">
				<return-type type="MxFocusable*"/>
				<parameters>
					<parameter name="focusable" type="MxFocusable*"/>
					<parameter name="direction" type="MxFocusDirection"/>
					<parameter name="from" type="MxFocusable*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="MxItemFactory" type-name="MxItemFactory" get-type="mx_item_factory_get_type">
			<method name="create" symbol="mx_item_factory_create">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="factory" type="MxItemFactory*"/>
				</parameters>
			</method>
			<vfunc name="create">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="factory" type="MxItemFactory*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="MxScrollable" type-name="MxScrollable" get-type="mx_scrollable_get_type">
			<method name="get_adjustments" symbol="mx_scrollable_get_adjustments">
				<return-type type="void"/>
				<parameters>
					<parameter name="scrollable" type="MxScrollable*"/>
					<parameter name="hadjustment" type="MxAdjustment**"/>
					<parameter name="vadjustment" type="MxAdjustment**"/>
				</parameters>
			</method>
			<method name="set_adjustments" symbol="mx_scrollable_set_adjustments">
				<return-type type="void"/>
				<parameters>
					<parameter name="scrollable" type="MxScrollable*"/>
					<parameter name="hadjustment" type="MxAdjustment*"/>
					<parameter name="vadjustment" type="MxAdjustment*"/>
				</parameters>
			</method>
			<vfunc name="get_adjustments">
				<return-type type="void"/>
				<parameters>
					<parameter name="scrollable" type="MxScrollable*"/>
					<parameter name="hadjustment" type="MxAdjustment**"/>
					<parameter name="vadjustment" type="MxAdjustment**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_adjustments">
				<return-type type="void"/>
				<parameters>
					<parameter name="scrollable" type="MxScrollable*"/>
					<parameter name="hadjustment" type="MxAdjustment*"/>
					<parameter name="vadjustment" type="MxAdjustment*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="MxStylable" type-name="MxStylable" get-type="mx_stylable_get_type">
			<method name="apply_clutter_text_attributes" symbol="mx_stylable_apply_clutter_text_attributes">
				<return-type type="void"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="text" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="connect_change_notifiers" symbol="mx_stylable_connect_change_notifiers">
				<return-type type="void"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
				</parameters>
			</method>
			<method name="find_property" symbol="mx_stylable_find_property">
				<return-type type="GParamSpec*"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get" symbol="mx_stylable_get">
				<return-type type="void"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="first_property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_default_value" symbol="mx_stylable_get_default_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value_out" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_property" symbol="mx_stylable_get_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_style" symbol="mx_stylable_get_style">
				<return-type type="MxStyle*"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
				</parameters>
			</method>
			<method name="get_style_class" symbol="mx_stylable_get_style_class">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
				</parameters>
			</method>
			<method name="get_style_pseudo_class" symbol="mx_stylable_get_style_pseudo_class">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
				</parameters>
			</method>
			<method name="iface_install_property" symbol="mx_stylable_iface_install_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="iface" type="MxStylableIface*"/>
					<parameter name="owner_type" type="GType"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</method>
			<method name="list_properties" symbol="mx_stylable_list_properties">
				<return-type type="GParamSpec**"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="n_props" type="guint*"/>
				</parameters>
			</method>
			<method name="set_style" symbol="mx_stylable_set_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="style" type="MxStyle*"/>
				</parameters>
			</method>
			<method name="set_style_class" symbol="mx_stylable_set_style_class">
				<return-type type="void"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="style_class" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_style_pseudo_class" symbol="mx_stylable_set_style_pseudo_class">
				<return-type type="void"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="pseudo_class" type="gchar*"/>
				</parameters>
			</method>
			<method name="style_changed" symbol="mx_stylable_style_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="flags" type="MxStyleChangedFlags"/>
				</parameters>
			</method>
			<signal name="style-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="flags" type="MxStyleChangedFlags"/>
				</parameters>
			</signal>
			<vfunc name="get_style">
				<return-type type="MxStyle*"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_style_class">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_style_pseudo_class">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="style" type="MxStyle*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_style_class">
				<return-type type="void"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="style_class" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_style_pseudo_class">
				<return-type type="void"/>
				<parameters>
					<parameter name="stylable" type="MxStylable*"/>
					<parameter name="style_class" type="gchar*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="MX_MAJOR_VERSION" type="int" value="1"/>
		<constant name="MX_MICRO_VERSION" type="int" value="0"/>
		<constant name="MX_MINOR_VERSION" type="int" value="0"/>
		<constant name="MX_VERSION_HEX" type="int" value="0"/>
		<constant name="MX_VERSION_S" type="char*" value="1.0.0"/>
	</namespace>
</api>
