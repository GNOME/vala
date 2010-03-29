<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Clutter">
		<function name="base_init" symbol="clutter_base_init">
			<return-type type="void"/>
		</function>
		<function name="cairo_set_source_color" symbol="clutter_cairo_set_source_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="color" type="ClutterColor*"/>
			</parameters>
		</function>
		<function name="check_version" symbol="clutter_check_version">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="major" type="guint"/>
				<parameter name="minor" type="guint"/>
				<parameter name="micro" type="guint"/>
			</parameters>
		</function>
		<function name="clear_glyph_cache" symbol="clutter_clear_glyph_cache">
			<return-type type="void"/>
		</function>
		<function name="do_event" symbol="clutter_do_event">
			<return-type type="void"/>
			<parameters>
				<parameter name="event" type="ClutterEvent*"/>
			</parameters>
		</function>
		<function name="events_pending" symbol="clutter_events_pending">
			<return-type type="gboolean"/>
		</function>
		<function name="feature_available" symbol="clutter_feature_available">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="feature" type="ClutterFeatureFlags"/>
			</parameters>
		</function>
		<function name="feature_get_all" symbol="clutter_feature_get_all">
			<return-type type="ClutterFeatureFlags"/>
		</function>
		<function name="frame_source_add" symbol="clutter_frame_source_add">
			<return-type type="guint"/>
			<parameters>
				<parameter name="fps" type="guint"/>
				<parameter name="func" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="frame_source_add_full" symbol="clutter_frame_source_add_full">
			<return-type type="guint"/>
			<parameters>
				<parameter name="priority" type="gint"/>
				<parameter name="fps" type="guint"/>
				<parameter name="func" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="get_actor_by_gid" symbol="clutter_get_actor_by_gid">
			<return-type type="ClutterActor*"/>
			<parameters>
				<parameter name="id" type="guint32"/>
			</parameters>
		</function>
		<function name="get_current_event" symbol="clutter_get_current_event">
			<return-type type="ClutterEvent*"/>
		</function>
		<function name="get_current_event_time" symbol="clutter_get_current_event_time">
			<return-type type="guint32"/>
		</function>
		<function name="get_debug_enabled" symbol="clutter_get_debug_enabled">
			<return-type type="gboolean"/>
		</function>
		<function name="get_default_backend" symbol="clutter_get_default_backend">
			<return-type type="ClutterBackend*"/>
		</function>
		<function name="get_default_frame_rate" symbol="clutter_get_default_frame_rate">
			<return-type type="guint"/>
		</function>
		<function name="get_default_text_direction" symbol="clutter_get_default_text_direction">
			<return-type type="ClutterTextDirection"/>
		</function>
		<function name="get_font_flags" symbol="clutter_get_font_flags">
			<return-type type="ClutterFontFlags"/>
		</function>
		<function name="get_font_map" symbol="clutter_get_font_map">
			<return-type type="PangoFontMap*"/>
		</function>
		<function name="get_input_device_for_id" symbol="clutter_get_input_device_for_id">
			<return-type type="ClutterInputDevice*"/>
			<parameters>
				<parameter name="id" type="gint"/>
			</parameters>
		</function>
		<function name="get_keyboard_grab" symbol="clutter_get_keyboard_grab">
			<return-type type="ClutterActor*"/>
		</function>
		<function name="get_motion_events_enabled" symbol="clutter_get_motion_events_enabled">
			<return-type type="gboolean"/>
		</function>
		<function name="get_option_group" symbol="clutter_get_option_group">
			<return-type type="GOptionGroup*"/>
		</function>
		<function name="get_option_group_without_init" symbol="clutter_get_option_group_without_init">
			<return-type type="GOptionGroup*"/>
		</function>
		<function name="get_pointer_grab" symbol="clutter_get_pointer_grab">
			<return-type type="ClutterActor*"/>
		</function>
		<function name="get_script_id" symbol="clutter_get_script_id">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="gobject" type="GObject*"/>
			</parameters>
		</function>
		<function name="get_show_fps" symbol="clutter_get_show_fps">
			<return-type type="gboolean"/>
		</function>
		<function name="get_timestamp" symbol="clutter_get_timestamp">
			<return-type type="gulong"/>
		</function>
		<function name="grab_keyboard" symbol="clutter_grab_keyboard">
			<return-type type="void"/>
			<parameters>
				<parameter name="actor" type="ClutterActor*"/>
			</parameters>
		</function>
		<function name="grab_pointer" symbol="clutter_grab_pointer">
			<return-type type="void"/>
			<parameters>
				<parameter name="actor" type="ClutterActor*"/>
			</parameters>
		</function>
		<function name="grab_pointer_for_device" symbol="clutter_grab_pointer_for_device">
			<return-type type="void"/>
			<parameters>
				<parameter name="actor" type="ClutterActor*"/>
				<parameter name="id" type="gint"/>
			</parameters>
		</function>
		<function name="init" symbol="clutter_init">
			<return-type type="ClutterInitError"/>
			<parameters>
				<parameter name="argc" type="int*"/>
				<parameter name="argv" type="char***"/>
			</parameters>
		</function>
		<function name="init_error_quark" symbol="clutter_init_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="init_with_args" symbol="clutter_init_with_args">
			<return-type type="ClutterInitError"/>
			<parameters>
				<parameter name="argc" type="int*"/>
				<parameter name="argv" type="char***"/>
				<parameter name="parameter_string" type="char*"/>
				<parameter name="entries" type="GOptionEntry*"/>
				<parameter name="translation_domain" type="char*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="keysym_to_unicode" symbol="clutter_keysym_to_unicode">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="keyval" type="guint"/>
			</parameters>
		</function>
		<function name="main" symbol="clutter_main">
			<return-type type="void"/>
		</function>
		<function name="main_level" symbol="clutter_main_level">
			<return-type type="gint"/>
		</function>
		<function name="main_quit" symbol="clutter_main_quit">
			<return-type type="void"/>
		</function>
		<function name="param_color_get_type" symbol="clutter_param_color_get_type">
			<return-type type="GType"/>
		</function>
		<function name="param_fixed_get_type" symbol="clutter_param_fixed_get_type">
			<return-type type="GType"/>
		</function>
		<function name="param_spec_color" symbol="clutter_param_spec_color">
			<return-type type="GParamSpec*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
				<parameter name="nick" type="gchar*"/>
				<parameter name="blurb" type="gchar*"/>
				<parameter name="default_value" type="ClutterColor*"/>
				<parameter name="flags" type="GParamFlags"/>
			</parameters>
		</function>
		<function name="param_spec_fixed" symbol="clutter_param_spec_fixed">
			<return-type type="GParamSpec*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
				<parameter name="nick" type="gchar*"/>
				<parameter name="blurb" type="gchar*"/>
				<parameter name="minimum" type="CoglFixed"/>
				<parameter name="maximum" type="CoglFixed"/>
				<parameter name="default_value" type="CoglFixed"/>
				<parameter name="flags" type="GParamFlags"/>
			</parameters>
		</function>
		<function name="param_spec_units" symbol="clutter_param_spec_units">
			<return-type type="GParamSpec*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
				<parameter name="nick" type="gchar*"/>
				<parameter name="blurb" type="gchar*"/>
				<parameter name="default_type" type="ClutterUnitType"/>
				<parameter name="minimum" type="gfloat"/>
				<parameter name="maximum" type="gfloat"/>
				<parameter name="default_value" type="gfloat"/>
				<parameter name="flags" type="GParamFlags"/>
			</parameters>
		</function>
		<function name="param_units_get_type" symbol="clutter_param_units_get_type">
			<return-type type="GType"/>
		</function>
		<function name="redraw" symbol="clutter_redraw">
			<return-type type="void"/>
			<parameters>
				<parameter name="stage" type="ClutterStage*"/>
			</parameters>
		</function>
		<function name="set_default_frame_rate" symbol="clutter_set_default_frame_rate">
			<return-type type="void"/>
			<parameters>
				<parameter name="frames_per_sec" type="guint"/>
			</parameters>
		</function>
		<function name="set_font_flags" symbol="clutter_set_font_flags">
			<return-type type="void"/>
			<parameters>
				<parameter name="flags" type="ClutterFontFlags"/>
			</parameters>
		</function>
		<function name="set_motion_events_enabled" symbol="clutter_set_motion_events_enabled">
			<return-type type="void"/>
			<parameters>
				<parameter name="enable" type="gboolean"/>
			</parameters>
		</function>
		<function name="threads_add_frame_source" symbol="clutter_threads_add_frame_source">
			<return-type type="guint"/>
			<parameters>
				<parameter name="fps" type="guint"/>
				<parameter name="func" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="threads_add_frame_source_full" symbol="clutter_threads_add_frame_source_full">
			<return-type type="guint"/>
			<parameters>
				<parameter name="priority" type="gint"/>
				<parameter name="fps" type="guint"/>
				<parameter name="func" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="threads_add_idle" symbol="clutter_threads_add_idle">
			<return-type type="guint"/>
			<parameters>
				<parameter name="func" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="threads_add_idle_full" symbol="clutter_threads_add_idle_full">
			<return-type type="guint"/>
			<parameters>
				<parameter name="priority" type="gint"/>
				<parameter name="func" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="threads_add_repaint_func" symbol="clutter_threads_add_repaint_func">
			<return-type type="guint"/>
			<parameters>
				<parameter name="func" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="threads_add_timeout" symbol="clutter_threads_add_timeout">
			<return-type type="guint"/>
			<parameters>
				<parameter name="interval" type="guint"/>
				<parameter name="func" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="threads_add_timeout_full" symbol="clutter_threads_add_timeout_full">
			<return-type type="guint"/>
			<parameters>
				<parameter name="priority" type="gint"/>
				<parameter name="interval" type="guint"/>
				<parameter name="func" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="threads_enter" symbol="clutter_threads_enter">
			<return-type type="void"/>
		</function>
		<function name="threads_init" symbol="clutter_threads_init">
			<return-type type="void"/>
		</function>
		<function name="threads_leave" symbol="clutter_threads_leave">
			<return-type type="void"/>
		</function>
		<function name="threads_remove_repaint_func" symbol="clutter_threads_remove_repaint_func">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_id" type="guint"/>
			</parameters>
		</function>
		<function name="threads_set_lock_functions" symbol="clutter_threads_set_lock_functions">
			<return-type type="void"/>
			<parameters>
				<parameter name="enter_fn" type="GCallback"/>
				<parameter name="leave_fn" type="GCallback"/>
			</parameters>
		</function>
		<function name="ungrab_keyboard" symbol="clutter_ungrab_keyboard">
			<return-type type="void"/>
		</function>
		<function name="ungrab_pointer" symbol="clutter_ungrab_pointer">
			<return-type type="void"/>
		</function>
		<function name="ungrab_pointer_for_device" symbol="clutter_ungrab_pointer_for_device">
			<return-type type="void"/>
			<parameters>
				<parameter name="id" type="gint"/>
			</parameters>
		</function>
		<function name="value_get_color" symbol="clutter_value_get_color">
			<return-type type="ClutterColor*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_fixed" symbol="clutter_value_get_fixed">
			<return-type type="CoglFixed"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_shader_float" symbol="clutter_value_get_shader_float">
			<return-type type="gfloat*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="length" type="gsize*"/>
			</parameters>
		</function>
		<function name="value_get_shader_int" symbol="clutter_value_get_shader_int">
			<return-type type="gint*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="length" type="gsize*"/>
			</parameters>
		</function>
		<function name="value_get_shader_matrix" symbol="clutter_value_get_shader_matrix">
			<return-type type="gfloat*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="length" type="gsize*"/>
			</parameters>
		</function>
		<function name="value_get_units" symbol="clutter_value_get_units">
			<return-type type="ClutterUnits*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_set_color" symbol="clutter_value_set_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="color" type="ClutterColor*"/>
			</parameters>
		</function>
		<function name="value_set_fixed" symbol="clutter_value_set_fixed">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="fixed_" type="CoglFixed"/>
			</parameters>
		</function>
		<function name="value_set_shader_float" symbol="clutter_value_set_shader_float">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="size" type="gint"/>
				<parameter name="floats" type="gfloat*"/>
			</parameters>
		</function>
		<function name="value_set_shader_int" symbol="clutter_value_set_shader_int">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="size" type="gint"/>
				<parameter name="ints" type="gint*"/>
			</parameters>
		</function>
		<function name="value_set_shader_matrix" symbol="clutter_value_set_shader_matrix">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="size" type="gint"/>
				<parameter name="matrix" type="gfloat*"/>
			</parameters>
		</function>
		<function name="value_set_units" symbol="clutter_value_set_units">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="units" type="ClutterUnits*"/>
			</parameters>
		</function>
		<callback name="ClutterAlphaFunc">
			<return-type type="gdouble"/>
			<parameters>
				<parameter name="alpha" type="ClutterAlpha*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="ClutterBehaviourForeachFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="behaviour" type="ClutterBehaviour*"/>
				<parameter name="actor" type="ClutterActor*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="ClutterBindingActionFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="gobject" type="GObject*"/>
				<parameter name="action_name" type="gchar*"/>
				<parameter name="key_val" type="guint"/>
				<parameter name="modifiers" type="ClutterModifierType"/>
			</parameters>
		</callback>
		<callback name="ClutterCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="actor" type="ClutterActor*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="ClutterModelFilterFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="model" type="ClutterModel*"/>
				<parameter name="iter" type="ClutterModelIter*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="ClutterModelForeachFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="model" type="ClutterModel*"/>
				<parameter name="iter" type="ClutterModelIter*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="ClutterModelSortFunc">
			<return-type type="gint"/>
			<parameters>
				<parameter name="model" type="ClutterModel*"/>
				<parameter name="a" type="GValue*"/>
				<parameter name="b" type="GValue*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="ClutterPathCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="node" type="ClutterPathNode*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="ClutterProgressFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="a" type="GValue*"/>
				<parameter name="b" type="GValue*"/>
				<parameter name="progress" type="gdouble"/>
				<parameter name="retval" type="GValue*"/>
			</parameters>
		</callback>
		<callback name="ClutterScriptConnectFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="script" type="ClutterScript*"/>
				<parameter name="object" type="GObject*"/>
				<parameter name="signal_name" type="gchar*"/>
				<parameter name="handler_name" type="gchar*"/>
				<parameter name="connect_object" type="GObject*"/>
				<parameter name="flags" type="GConnectFlags"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="ClutterAnyEvent">
			<field name="type" type="ClutterEventType"/>
			<field name="time" type="guint32"/>
			<field name="flags" type="ClutterEventFlags"/>
			<field name="stage" type="ClutterStage*"/>
			<field name="source" type="ClutterActor*"/>
		</struct>
		<struct name="ClutterButtonEvent">
			<field name="type" type="ClutterEventType"/>
			<field name="time" type="guint32"/>
			<field name="flags" type="ClutterEventFlags"/>
			<field name="stage" type="ClutterStage*"/>
			<field name="source" type="ClutterActor*"/>
			<field name="x" type="gfloat"/>
			<field name="y" type="gfloat"/>
			<field name="modifier_state" type="ClutterModifierType"/>
			<field name="button" type="guint32"/>
			<field name="click_count" type="guint"/>
			<field name="axes" type="gdouble*"/>
			<field name="device" type="ClutterInputDevice*"/>
		</struct>
		<struct name="ClutterCrossingEvent">
			<field name="type" type="ClutterEventType"/>
			<field name="time" type="guint32"/>
			<field name="flags" type="ClutterEventFlags"/>
			<field name="stage" type="ClutterStage*"/>
			<field name="source" type="ClutterActor*"/>
			<field name="x" type="gfloat"/>
			<field name="y" type="gfloat"/>
			<field name="device" type="ClutterInputDevice*"/>
			<field name="related" type="ClutterActor*"/>
		</struct>
		<struct name="ClutterKeyEvent">
			<field name="type" type="ClutterEventType"/>
			<field name="time" type="guint32"/>
			<field name="flags" type="ClutterEventFlags"/>
			<field name="stage" type="ClutterStage*"/>
			<field name="source" type="ClutterActor*"/>
			<field name="modifier_state" type="ClutterModifierType"/>
			<field name="keyval" type="guint"/>
			<field name="hardware_keycode" type="guint16"/>
			<field name="unicode_value" type="gunichar"/>
			<field name="device" type="ClutterInputDevice*"/>
		</struct>
		<struct name="ClutterMotionEvent">
			<field name="type" type="ClutterEventType"/>
			<field name="time" type="guint32"/>
			<field name="flags" type="ClutterEventFlags"/>
			<field name="stage" type="ClutterStage*"/>
			<field name="source" type="ClutterActor*"/>
			<field name="x" type="gfloat"/>
			<field name="y" type="gfloat"/>
			<field name="modifier_state" type="ClutterModifierType"/>
			<field name="axes" type="gdouble*"/>
			<field name="device" type="ClutterInputDevice*"/>
		</struct>
		<struct name="ClutterParamSpecColor">
			<field name="parent_instance" type="GParamSpec"/>
			<field name="default_value" type="ClutterColor*"/>
		</struct>
		<struct name="ClutterParamSpecFixed">
			<field name="parent_instance" type="GParamSpec"/>
			<field name="minimum" type="CoglFixed"/>
			<field name="maximum" type="CoglFixed"/>
			<field name="default_value" type="CoglFixed"/>
		</struct>
		<struct name="ClutterParamSpecUnits">
			<field name="parent_instance" type="GParamSpec"/>
			<field name="default_type" type="ClutterUnitType"/>
			<field name="default_value" type="gfloat"/>
			<field name="minimum" type="gfloat"/>
			<field name="maximum" type="gfloat"/>
		</struct>
		<struct name="ClutterScrollEvent">
			<field name="type" type="ClutterEventType"/>
			<field name="time" type="guint32"/>
			<field name="flags" type="ClutterEventFlags"/>
			<field name="stage" type="ClutterStage*"/>
			<field name="source" type="ClutterActor*"/>
			<field name="x" type="gfloat"/>
			<field name="y" type="gfloat"/>
			<field name="direction" type="ClutterScrollDirection"/>
			<field name="modifier_state" type="ClutterModifierType"/>
			<field name="axes" type="gdouble*"/>
			<field name="device" type="ClutterInputDevice*"/>
		</struct>
		<struct name="ClutterShaderFloat">
		</struct>
		<struct name="ClutterShaderInt">
		</struct>
		<struct name="ClutterShaderMatrix">
		</struct>
		<struct name="ClutterStageStateEvent">
			<field name="type" type="ClutterEventType"/>
			<field name="time" type="guint32"/>
			<field name="flags" type="ClutterEventFlags"/>
			<field name="stage" type="ClutterStage*"/>
			<field name="source" type="ClutterActor*"/>
			<field name="changed_mask" type="ClutterStageState"/>
			<field name="new_state" type="ClutterStageState"/>
		</struct>
		<struct name="ClutterTimeoutPool">
			<method name="add" symbol="clutter_timeout_pool_add">
				<return-type type="guint"/>
				<parameters>
					<parameter name="pool" type="ClutterTimeoutPool*"/>
					<parameter name="fps" type="guint"/>
					<parameter name="func" type="GSourceFunc"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="new" symbol="clutter_timeout_pool_new">
				<return-type type="ClutterTimeoutPool*"/>
				<parameters>
					<parameter name="priority" type="gint"/>
				</parameters>
			</method>
			<method name="remove" symbol="clutter_timeout_pool_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="ClutterTimeoutPool*"/>
					<parameter name="id" type="guint"/>
				</parameters>
			</method>
		</struct>
		<boxed name="ClutterActorBox" type-name="ClutterActorBox" get-type="clutter_actor_box_get_type">
			<method name="clamp_to_pixel" symbol="clutter_actor_box_clamp_to_pixel">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterActorBox*"/>
				</parameters>
			</method>
			<method name="contains" symbol="clutter_actor_box_contains">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="box" type="ClutterActorBox*"/>
					<parameter name="x" type="gfloat"/>
					<parameter name="y" type="gfloat"/>
				</parameters>
			</method>
			<method name="copy" symbol="clutter_actor_box_copy">
				<return-type type="ClutterActorBox*"/>
				<parameters>
					<parameter name="box" type="ClutterActorBox*"/>
				</parameters>
			</method>
			<method name="equal" symbol="clutter_actor_box_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="box_a" type="ClutterActorBox*"/>
					<parameter name="box_b" type="ClutterActorBox*"/>
				</parameters>
			</method>
			<method name="free" symbol="clutter_actor_box_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterActorBox*"/>
				</parameters>
			</method>
			<method name="from_vertices" symbol="clutter_actor_box_from_vertices">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterActorBox*"/>
					<parameter name="verts" type="ClutterVertex[]"/>
				</parameters>
			</method>
			<method name="get_area" symbol="clutter_actor_box_get_area">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="box" type="ClutterActorBox*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="clutter_actor_box_get_height">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="box" type="ClutterActorBox*"/>
				</parameters>
			</method>
			<method name="get_origin" symbol="clutter_actor_box_get_origin">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterActorBox*"/>
					<parameter name="x" type="gfloat*"/>
					<parameter name="y" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="clutter_actor_box_get_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterActorBox*"/>
					<parameter name="width" type="gfloat*"/>
					<parameter name="height" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="clutter_actor_box_get_width">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="box" type="ClutterActorBox*"/>
				</parameters>
			</method>
			<method name="get_x" symbol="clutter_actor_box_get_x">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="box" type="ClutterActorBox*"/>
				</parameters>
			</method>
			<method name="get_y" symbol="clutter_actor_box_get_y">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="box" type="ClutterActorBox*"/>
				</parameters>
			</method>
			<method name="interpolate" symbol="clutter_actor_box_interpolate">
				<return-type type="void"/>
				<parameters>
					<parameter name="initial" type="ClutterActorBox*"/>
					<parameter name="final" type="ClutterActorBox*"/>
					<parameter name="progress" type="gdouble"/>
					<parameter name="result" type="ClutterActorBox*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_actor_box_new">
				<return-type type="ClutterActorBox*"/>
				<parameters>
					<parameter name="x_1" type="gfloat"/>
					<parameter name="y_1" type="gfloat"/>
					<parameter name="x_2" type="gfloat"/>
					<parameter name="y_2" type="gfloat"/>
				</parameters>
			</constructor>
			<field name="x1" type="gfloat"/>
			<field name="y1" type="gfloat"/>
			<field name="x2" type="gfloat"/>
			<field name="y2" type="gfloat"/>
		</boxed>
		<boxed name="ClutterAnimatorKey" type-name="ClutterAnimatorKey" get-type="clutter_animator_key_get_type">
			<method name="get_mode" symbol="clutter_animator_key_get_mode">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="key" type="ClutterAnimatorKey*"/>
				</parameters>
			</method>
			<method name="get_object" symbol="clutter_animator_key_get_object">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="key" type="ClutterAnimatorKey*"/>
				</parameters>
			</method>
			<method name="get_progress" symbol="clutter_animator_key_get_progress">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="key" type="ClutterAnimatorKey*"/>
				</parameters>
			</method>
			<method name="get_property_name" symbol="clutter_animator_key_get_property_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="key" type="ClutterAnimatorKey*"/>
				</parameters>
			</method>
			<method name="get_property_type" symbol="clutter_animator_key_get_property_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="key" type="ClutterAnimatorKey*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="clutter_animator_key_get_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="key" type="ClutterAnimatorKey*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="ClutterColor" type-name="ClutterColor" get-type="clutter_color_get_type">
			<method name="add" symbol="clutter_color_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="a" type="ClutterColor*"/>
					<parameter name="b" type="ClutterColor*"/>
					<parameter name="result" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="copy" symbol="clutter_color_copy">
				<return-type type="ClutterColor*"/>
				<parameters>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="darken" symbol="clutter_color_darken">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="ClutterColor*"/>
					<parameter name="result" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="equal" symbol="clutter_color_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="v1" type="gconstpointer"/>
					<parameter name="v2" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="clutter_color_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="from_hls" symbol="clutter_color_from_hls">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="ClutterColor*"/>
					<parameter name="hue" type="gfloat"/>
					<parameter name="luminance" type="gfloat"/>
					<parameter name="saturation" type="gfloat"/>
				</parameters>
			</method>
			<method name="from_pixel" symbol="clutter_color_from_pixel">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="ClutterColor*"/>
					<parameter name="pixel" type="guint32"/>
				</parameters>
			</method>
			<method name="from_string" symbol="clutter_color_from_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="color" type="ClutterColor*"/>
					<parameter name="str" type="gchar*"/>
				</parameters>
			</method>
			<method name="hash" symbol="clutter_color_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="v" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="lighten" symbol="clutter_color_lighten">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="ClutterColor*"/>
					<parameter name="result" type="ClutterColor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_color_new">
				<return-type type="ClutterColor*"/>
				<parameters>
					<parameter name="red" type="guint8"/>
					<parameter name="green" type="guint8"/>
					<parameter name="blue" type="guint8"/>
					<parameter name="alpha" type="guint8"/>
				</parameters>
			</constructor>
			<method name="shade" symbol="clutter_color_shade">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="ClutterColor*"/>
					<parameter name="factor" type="gdouble"/>
					<parameter name="result" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="subtract" symbol="clutter_color_subtract">
				<return-type type="void"/>
				<parameters>
					<parameter name="a" type="ClutterColor*"/>
					<parameter name="b" type="ClutterColor*"/>
					<parameter name="result" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="to_hls" symbol="clutter_color_to_hls">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="ClutterColor*"/>
					<parameter name="hue" type="gfloat*"/>
					<parameter name="luminance" type="gfloat*"/>
					<parameter name="saturation" type="gfloat*"/>
				</parameters>
			</method>
			<method name="to_pixel" symbol="clutter_color_to_pixel">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="clutter_color_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<field name="red" type="guint8"/>
			<field name="green" type="guint8"/>
			<field name="blue" type="guint8"/>
			<field name="alpha" type="guint8"/>
		</boxed>
		<boxed name="ClutterEvent" type-name="ClutterEvent" get-type="clutter_event_get_type">
			<method name="copy" symbol="clutter_event_copy">
				<return-type type="ClutterEvent*"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="free" symbol="clutter_event_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get" symbol="clutter_event_get">
				<return-type type="ClutterEvent*"/>
			</method>
			<method name="get_button" symbol="clutter_event_get_button">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_click_count" symbol="clutter_event_get_click_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_coords" symbol="clutter_event_get_coords">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
					<parameter name="x" type="gfloat*"/>
					<parameter name="y" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_device" symbol="clutter_event_get_device">
				<return-type type="ClutterInputDevice*"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_device_id" symbol="clutter_event_get_device_id">
				<return-type type="gint"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_device_type" symbol="clutter_event_get_device_type">
				<return-type type="ClutterInputDeviceType"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="clutter_event_get_flags">
				<return-type type="ClutterEventFlags"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_key_code" symbol="clutter_event_get_key_code">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_key_symbol" symbol="clutter_event_get_key_symbol">
				<return-type type="guint"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_key_unicode" symbol="clutter_event_get_key_unicode">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_related" symbol="clutter_event_get_related">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_scroll_direction" symbol="clutter_event_get_scroll_direction">
				<return-type type="ClutterScrollDirection"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_source" symbol="clutter_event_get_source">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_stage" symbol="clutter_event_get_stage">
				<return-type type="ClutterStage*"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="clutter_event_get_state">
				<return-type type="ClutterModifierType"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_time" symbol="clutter_event_get_time">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_event_new">
				<return-type type="ClutterEvent*"/>
				<parameters>
					<parameter name="type" type="ClutterEventType"/>
				</parameters>
			</constructor>
			<method name="peek" symbol="clutter_event_peek">
				<return-type type="ClutterEvent*"/>
			</method>
			<method name="put" symbol="clutter_event_put">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="type" symbol="clutter_event_type">
				<return-type type="ClutterEventType"/>
				<parameters>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<field name="type" type="ClutterEventType"/>
			<field name="any" type="ClutterAnyEvent"/>
			<field name="button" type="ClutterButtonEvent"/>
			<field name="key" type="ClutterKeyEvent"/>
			<field name="motion" type="ClutterMotionEvent"/>
			<field name="scroll" type="ClutterScrollEvent"/>
			<field name="stage_state" type="ClutterStageStateEvent"/>
			<field name="crossing" type="ClutterCrossingEvent"/>
		</boxed>
		<boxed name="ClutterFog" type-name="ClutterFog" get-type="clutter_fog_get_type">
			<field name="z_near" type="gfloat"/>
			<field name="z_far" type="gfloat"/>
		</boxed>
		<boxed name="ClutterGeometry" type-name="ClutterGeometry" get-type="clutter_geometry_get_type">
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
			<field name="width" type="guint"/>
			<field name="height" type="guint"/>
		</boxed>
		<boxed name="ClutterKnot" type-name="ClutterKnot" get-type="clutter_knot_get_type">
			<method name="copy" symbol="clutter_knot_copy">
				<return-type type="ClutterKnot*"/>
				<parameters>
					<parameter name="knot" type="ClutterKnot*"/>
				</parameters>
			</method>
			<method name="equal" symbol="clutter_knot_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="knot_a" type="ClutterKnot*"/>
					<parameter name="knot_b" type="ClutterKnot*"/>
				</parameters>
			</method>
			<method name="free" symbol="clutter_knot_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="knot" type="ClutterKnot*"/>
				</parameters>
			</method>
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
		</boxed>
		<boxed name="ClutterPathNode" type-name="ClutterPathNode" get-type="clutter_path_node_get_type">
			<method name="copy" symbol="clutter_path_node_copy">
				<return-type type="ClutterPathNode*"/>
				<parameters>
					<parameter name="node" type="ClutterPathNode*"/>
				</parameters>
			</method>
			<method name="equal" symbol="clutter_path_node_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="node_a" type="ClutterPathNode*"/>
					<parameter name="node_b" type="ClutterPathNode*"/>
				</parameters>
			</method>
			<method name="free" symbol="clutter_path_node_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="ClutterPathNode*"/>
				</parameters>
			</method>
			<field name="type" type="ClutterPathNodeType"/>
			<field name="points" type="ClutterKnot[]"/>
		</boxed>
		<boxed name="ClutterPerspective" type-name="ClutterPerspective" get-type="clutter_perspective_get_type">
			<field name="fovy" type="gfloat"/>
			<field name="aspect" type="gfloat"/>
			<field name="z_near" type="gfloat"/>
			<field name="z_far" type="gfloat"/>
		</boxed>
		<boxed name="ClutterUnits" type-name="ClutterUnits" get-type="clutter_units_get_type">
			<method name="copy" symbol="clutter_units_copy">
				<return-type type="ClutterUnits*"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
				</parameters>
			</method>
			<method name="free" symbol="clutter_units_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
				</parameters>
			</method>
			<method name="from_cm" symbol="clutter_units_from_cm">
				<return-type type="void"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
					<parameter name="cm" type="gfloat"/>
				</parameters>
			</method>
			<method name="from_em" symbol="clutter_units_from_em">
				<return-type type="void"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
					<parameter name="em" type="gfloat"/>
				</parameters>
			</method>
			<method name="from_em_for_font" symbol="clutter_units_from_em_for_font">
				<return-type type="void"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
					<parameter name="font_name" type="gchar*"/>
					<parameter name="em" type="gfloat"/>
				</parameters>
			</method>
			<method name="from_mm" symbol="clutter_units_from_mm">
				<return-type type="void"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
					<parameter name="mm" type="gfloat"/>
				</parameters>
			</method>
			<method name="from_pixels" symbol="clutter_units_from_pixels">
				<return-type type="void"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
					<parameter name="px" type="gint"/>
				</parameters>
			</method>
			<method name="from_pt" symbol="clutter_units_from_pt">
				<return-type type="void"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
					<parameter name="pt" type="gfloat"/>
				</parameters>
			</method>
			<method name="from_string" symbol="clutter_units_from_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
					<parameter name="str" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_unit_type" symbol="clutter_units_get_unit_type">
				<return-type type="ClutterUnitType"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
				</parameters>
			</method>
			<method name="get_unit_value" symbol="clutter_units_get_unit_value">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
				</parameters>
			</method>
			<method name="to_pixels" symbol="clutter_units_to_pixels">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="clutter_units_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="units" type="ClutterUnits*"/>
				</parameters>
			</method>
			<field name="unit_type" type="ClutterUnitType"/>
			<field name="value" type="gfloat"/>
			<field name="pixels" type="gfloat"/>
			<field name="pixels_set" type="guint"/>
			<field name="serial" type="gint32"/>
			<field name="__padding_1" type="gint32"/>
			<field name="__padding_2" type="gint64"/>
		</boxed>
		<boxed name="ClutterVertex" type-name="ClutterVertex" get-type="clutter_vertex_get_type">
			<method name="copy" symbol="clutter_vertex_copy">
				<return-type type="ClutterVertex*"/>
				<parameters>
					<parameter name="vertex" type="ClutterVertex*"/>
				</parameters>
			</method>
			<method name="equal" symbol="clutter_vertex_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="vertex_a" type="ClutterVertex*"/>
					<parameter name="vertex_b" type="ClutterVertex*"/>
				</parameters>
			</method>
			<method name="free" symbol="clutter_vertex_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="vertex" type="ClutterVertex*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_vertex_new">
				<return-type type="ClutterVertex*"/>
				<parameters>
					<parameter name="x" type="gfloat"/>
					<parameter name="y" type="gfloat"/>
					<parameter name="z" type="gfloat"/>
				</parameters>
			</constructor>
			<field name="x" type="gfloat"/>
			<field name="y" type="gfloat"/>
			<field name="z" type="gfloat"/>
		</boxed>
		<enum name="ClutterAnimationMode" type-name="ClutterAnimationMode" get-type="clutter_animation_mode_get_type">
			<member name="CLUTTER_CUSTOM_MODE" value="0"/>
			<member name="CLUTTER_LINEAR" value="1"/>
			<member name="CLUTTER_EASE_IN_QUAD" value="2"/>
			<member name="CLUTTER_EASE_OUT_QUAD" value="3"/>
			<member name="CLUTTER_EASE_IN_OUT_QUAD" value="4"/>
			<member name="CLUTTER_EASE_IN_CUBIC" value="5"/>
			<member name="CLUTTER_EASE_OUT_CUBIC" value="6"/>
			<member name="CLUTTER_EASE_IN_OUT_CUBIC" value="7"/>
			<member name="CLUTTER_EASE_IN_QUART" value="8"/>
			<member name="CLUTTER_EASE_OUT_QUART" value="9"/>
			<member name="CLUTTER_EASE_IN_OUT_QUART" value="10"/>
			<member name="CLUTTER_EASE_IN_QUINT" value="11"/>
			<member name="CLUTTER_EASE_OUT_QUINT" value="12"/>
			<member name="CLUTTER_EASE_IN_OUT_QUINT" value="13"/>
			<member name="CLUTTER_EASE_IN_SINE" value="14"/>
			<member name="CLUTTER_EASE_OUT_SINE" value="15"/>
			<member name="CLUTTER_EASE_IN_OUT_SINE" value="16"/>
			<member name="CLUTTER_EASE_IN_EXPO" value="17"/>
			<member name="CLUTTER_EASE_OUT_EXPO" value="18"/>
			<member name="CLUTTER_EASE_IN_OUT_EXPO" value="19"/>
			<member name="CLUTTER_EASE_IN_CIRC" value="20"/>
			<member name="CLUTTER_EASE_OUT_CIRC" value="21"/>
			<member name="CLUTTER_EASE_IN_OUT_CIRC" value="22"/>
			<member name="CLUTTER_EASE_IN_ELASTIC" value="23"/>
			<member name="CLUTTER_EASE_OUT_ELASTIC" value="24"/>
			<member name="CLUTTER_EASE_IN_OUT_ELASTIC" value="25"/>
			<member name="CLUTTER_EASE_IN_BACK" value="26"/>
			<member name="CLUTTER_EASE_OUT_BACK" value="27"/>
			<member name="CLUTTER_EASE_IN_OUT_BACK" value="28"/>
			<member name="CLUTTER_EASE_IN_BOUNCE" value="29"/>
			<member name="CLUTTER_EASE_OUT_BOUNCE" value="30"/>
			<member name="CLUTTER_EASE_IN_OUT_BOUNCE" value="31"/>
			<member name="CLUTTER_ANIMATION_LAST" value="32"/>
		</enum>
		<enum name="ClutterBinAlignment" type-name="ClutterBinAlignment" get-type="clutter_bin_alignment_get_type">
			<member name="CLUTTER_BIN_ALIGNMENT_FIXED" value="0"/>
			<member name="CLUTTER_BIN_ALIGNMENT_FILL" value="1"/>
			<member name="CLUTTER_BIN_ALIGNMENT_START" value="2"/>
			<member name="CLUTTER_BIN_ALIGNMENT_END" value="3"/>
			<member name="CLUTTER_BIN_ALIGNMENT_CENTER" value="4"/>
		</enum>
		<enum name="ClutterBoxAlignment" type-name="ClutterBoxAlignment" get-type="clutter_box_alignment_get_type">
			<member name="CLUTTER_BOX_ALIGNMENT_START" value="0"/>
			<member name="CLUTTER_BOX_ALIGNMENT_END" value="1"/>
			<member name="CLUTTER_BOX_ALIGNMENT_CENTER" value="2"/>
		</enum>
		<enum name="ClutterEventType" type-name="ClutterEventType" get-type="clutter_event_type_get_type">
			<member name="CLUTTER_NOTHING" value="0"/>
			<member name="CLUTTER_KEY_PRESS" value="1"/>
			<member name="CLUTTER_KEY_RELEASE" value="2"/>
			<member name="CLUTTER_MOTION" value="3"/>
			<member name="CLUTTER_ENTER" value="4"/>
			<member name="CLUTTER_LEAVE" value="5"/>
			<member name="CLUTTER_BUTTON_PRESS" value="6"/>
			<member name="CLUTTER_BUTTON_RELEASE" value="7"/>
			<member name="CLUTTER_SCROLL" value="8"/>
			<member name="CLUTTER_STAGE_STATE" value="9"/>
			<member name="CLUTTER_DESTROY_NOTIFY" value="10"/>
			<member name="CLUTTER_CLIENT_MESSAGE" value="11"/>
			<member name="CLUTTER_DELETE" value="12"/>
		</enum>
		<enum name="ClutterFlowOrientation" type-name="ClutterFlowOrientation" get-type="clutter_flow_orientation_get_type">
			<member name="CLUTTER_FLOW_HORIZONTAL" value="0"/>
			<member name="CLUTTER_FLOW_VERTICAL" value="1"/>
		</enum>
		<enum name="ClutterGravity" type-name="ClutterGravity" get-type="clutter_gravity_get_type">
			<member name="CLUTTER_GRAVITY_NONE" value="0"/>
			<member name="CLUTTER_GRAVITY_NORTH" value="1"/>
			<member name="CLUTTER_GRAVITY_NORTH_EAST" value="2"/>
			<member name="CLUTTER_GRAVITY_EAST" value="3"/>
			<member name="CLUTTER_GRAVITY_SOUTH_EAST" value="4"/>
			<member name="CLUTTER_GRAVITY_SOUTH" value="5"/>
			<member name="CLUTTER_GRAVITY_SOUTH_WEST" value="6"/>
			<member name="CLUTTER_GRAVITY_WEST" value="7"/>
			<member name="CLUTTER_GRAVITY_NORTH_WEST" value="8"/>
			<member name="CLUTTER_GRAVITY_CENTER" value="9"/>
		</enum>
		<enum name="ClutterInitError" type-name="ClutterInitError" get-type="clutter_init_error_get_type">
			<member name="CLUTTER_INIT_SUCCESS" value="1"/>
			<member name="CLUTTER_INIT_ERROR_UNKNOWN" value="0"/>
			<member name="CLUTTER_INIT_ERROR_THREADS" value="-1"/>
			<member name="CLUTTER_INIT_ERROR_BACKEND" value="-2"/>
			<member name="CLUTTER_INIT_ERROR_INTERNAL" value="-3"/>
		</enum>
		<enum name="ClutterInputDeviceType" type-name="ClutterInputDeviceType" get-type="clutter_input_device_type_get_type">
			<member name="CLUTTER_POINTER_DEVICE" value="0"/>
			<member name="CLUTTER_KEYBOARD_DEVICE" value="1"/>
			<member name="CLUTTER_EXTENSION_DEVICE" value="2"/>
			<member name="CLUTTER_N_DEVICE_TYPES" value="3"/>
		</enum>
		<enum name="ClutterInterpolation" type-name="ClutterInterpolation" get-type="clutter_interpolation_get_type">
			<member name="CLUTTER_INTERPOLATION_LINEAR" value="0"/>
			<member name="CLUTTER_INTERPOLATION_CUBIC" value="1"/>
		</enum>
		<enum name="ClutterPathNodeType" type-name="ClutterPathNodeType" get-type="clutter_path_node_type_get_type">
			<member name="CLUTTER_PATH_MOVE_TO" value="0"/>
			<member name="CLUTTER_PATH_LINE_TO" value="1"/>
			<member name="CLUTTER_PATH_CURVE_TO" value="2"/>
			<member name="CLUTTER_PATH_CLOSE" value="3"/>
			<member name="CLUTTER_PATH_REL_MOVE_TO" value="32"/>
			<member name="CLUTTER_PATH_REL_LINE_TO" value="33"/>
			<member name="CLUTTER_PATH_REL_CURVE_TO" value="34"/>
		</enum>
		<enum name="ClutterPickMode" type-name="ClutterPickMode" get-type="clutter_pick_mode_get_type">
			<member name="CLUTTER_PICK_NONE" value="0"/>
			<member name="CLUTTER_PICK_REACTIVE" value="1"/>
			<member name="CLUTTER_PICK_ALL" value="2"/>
		</enum>
		<enum name="ClutterRequestMode" type-name="ClutterRequestMode" get-type="clutter_request_mode_get_type">
			<member name="CLUTTER_REQUEST_HEIGHT_FOR_WIDTH" value="0"/>
			<member name="CLUTTER_REQUEST_WIDTH_FOR_HEIGHT" value="1"/>
		</enum>
		<enum name="ClutterRotateAxis" type-name="ClutterRotateAxis" get-type="clutter_rotate_axis_get_type">
			<member name="CLUTTER_X_AXIS" value="0"/>
			<member name="CLUTTER_Y_AXIS" value="1"/>
			<member name="CLUTTER_Z_AXIS" value="2"/>
		</enum>
		<enum name="ClutterRotateDirection" type-name="ClutterRotateDirection" get-type="clutter_rotate_direction_get_type">
			<member name="CLUTTER_ROTATE_CW" value="0"/>
			<member name="CLUTTER_ROTATE_CCW" value="1"/>
		</enum>
		<enum name="ClutterScriptError" type-name="ClutterScriptError" get-type="clutter_script_error_get_type">
			<member name="CLUTTER_SCRIPT_ERROR_INVALID_TYPE_FUNCTION" value="0"/>
			<member name="CLUTTER_SCRIPT_ERROR_INVALID_PROPERTY" value="1"/>
			<member name="CLUTTER_SCRIPT_ERROR_INVALID_VALUE" value="2"/>
		</enum>
		<enum name="ClutterScrollDirection" type-name="ClutterScrollDirection" get-type="clutter_scroll_direction_get_type">
			<member name="CLUTTER_SCROLL_UP" value="0"/>
			<member name="CLUTTER_SCROLL_DOWN" value="1"/>
			<member name="CLUTTER_SCROLL_LEFT" value="2"/>
			<member name="CLUTTER_SCROLL_RIGHT" value="3"/>
		</enum>
		<enum name="ClutterShaderError" type-name="ClutterShaderError" get-type="clutter_shader_error_get_type">
			<member name="CLUTTER_SHADER_ERROR_NO_ASM" value="0"/>
			<member name="CLUTTER_SHADER_ERROR_NO_GLSL" value="1"/>
			<member name="CLUTTER_SHADER_ERROR_COMPILE" value="2"/>
		</enum>
		<enum name="ClutterTextDirection" type-name="ClutterTextDirection" get-type="clutter_text_direction_get_type">
			<member name="CLUTTER_TEXT_DIRECTION_DEFAULT" value="0"/>
			<member name="CLUTTER_TEXT_DIRECTION_LTR" value="1"/>
			<member name="CLUTTER_TEXT_DIRECTION_RTL" value="2"/>
		</enum>
		<enum name="ClutterTextureError" type-name="ClutterTextureError" get-type="clutter_texture_error_get_type">
			<member name="CLUTTER_TEXTURE_ERROR_OUT_OF_MEMORY" value="0"/>
			<member name="CLUTTER_TEXTURE_ERROR_NO_YUV" value="1"/>
			<member name="CLUTTER_TEXTURE_ERROR_BAD_FORMAT" value="2"/>
		</enum>
		<enum name="ClutterTextureQuality" type-name="ClutterTextureQuality" get-type="clutter_texture_quality_get_type">
			<member name="CLUTTER_TEXTURE_QUALITY_LOW" value="0"/>
			<member name="CLUTTER_TEXTURE_QUALITY_MEDIUM" value="1"/>
			<member name="CLUTTER_TEXTURE_QUALITY_HIGH" value="2"/>
		</enum>
		<enum name="ClutterTimelineDirection" type-name="ClutterTimelineDirection" get-type="clutter_timeline_direction_get_type">
			<member name="CLUTTER_TIMELINE_FORWARD" value="0"/>
			<member name="CLUTTER_TIMELINE_BACKWARD" value="1"/>
		</enum>
		<enum name="ClutterUnitType" type-name="ClutterUnitType" get-type="clutter_unit_type_get_type">
			<member name="CLUTTER_UNIT_PIXEL" value="0"/>
			<member name="CLUTTER_UNIT_EM" value="1"/>
			<member name="CLUTTER_UNIT_MM" value="2"/>
			<member name="CLUTTER_UNIT_POINT" value="3"/>
			<member name="CLUTTER_UNIT_CM" value="4"/>
		</enum>
		<enum name="ClutterX11FilterReturn" type-name="ClutterX11FilterReturn" get-type="clutter_x11_filter_return_get_type">
			<member name="CLUTTER_X11_FILTER_CONTINUE" value="0"/>
			<member name="CLUTTER_X11_FILTER_TRANSLATE" value="1"/>
			<member name="CLUTTER_X11_FILTER_REMOVE" value="2"/>
		</enum>
		<enum name="ClutterX11XInputEventTypes" type-name="ClutterX11XInputEventTypes" get-type="clutter_x11_xinput_event_types_get_type">
			<member name="CLUTTER_X11_XINPUT_KEY_PRESS_EVENT" value="0"/>
			<member name="CLUTTER_X11_XINPUT_KEY_RELEASE_EVENT" value="1"/>
			<member name="CLUTTER_X11_XINPUT_BUTTON_PRESS_EVENT" value="2"/>
			<member name="CLUTTER_X11_XINPUT_BUTTON_RELEASE_EVENT" value="3"/>
			<member name="CLUTTER_X11_XINPUT_MOTION_NOTIFY_EVENT" value="4"/>
			<member name="CLUTTER_X11_XINPUT_LAST_EVENT" value="5"/>
		</enum>
		<flags name="ClutterActorFlags" type-name="ClutterActorFlags" get-type="clutter_actor_flags_get_type">
			<member name="CLUTTER_ACTOR_MAPPED" value="2"/>
			<member name="CLUTTER_ACTOR_REALIZED" value="4"/>
			<member name="CLUTTER_ACTOR_REACTIVE" value="8"/>
			<member name="CLUTTER_ACTOR_VISIBLE" value="16"/>
			<member name="CLUTTER_ACTOR_NO_LAYOUT" value="32"/>
		</flags>
		<flags name="ClutterAllocationFlags" type-name="ClutterAllocationFlags" get-type="clutter_allocation_flags_get_type">
			<member name="CLUTTER_ALLOCATION_NONE" value="0"/>
			<member name="CLUTTER_ABSOLUTE_ORIGIN_CHANGED" value="2"/>
		</flags>
		<flags name="ClutterEventFlags" type-name="ClutterEventFlags" get-type="clutter_event_flags_get_type">
			<member name="CLUTTER_EVENT_NONE" value="0"/>
			<member name="CLUTTER_EVENT_FLAG_SYNTHETIC" value="1"/>
		</flags>
		<flags name="ClutterFeatureFlags" type-name="ClutterFeatureFlags" get-type="clutter_feature_flags_get_type">
			<member name="CLUTTER_FEATURE_TEXTURE_NPOT" value="4"/>
			<member name="CLUTTER_FEATURE_SYNC_TO_VBLANK" value="8"/>
			<member name="CLUTTER_FEATURE_TEXTURE_YUV" value="16"/>
			<member name="CLUTTER_FEATURE_TEXTURE_READ_PIXELS" value="32"/>
			<member name="CLUTTER_FEATURE_STAGE_STATIC" value="64"/>
			<member name="CLUTTER_FEATURE_STAGE_USER_RESIZE" value="128"/>
			<member name="CLUTTER_FEATURE_STAGE_CURSOR" value="256"/>
			<member name="CLUTTER_FEATURE_SHADERS_GLSL" value="512"/>
			<member name="CLUTTER_FEATURE_OFFSCREEN" value="1024"/>
			<member name="CLUTTER_FEATURE_STAGE_MULTIPLE" value="2048"/>
			<member name="CLUTTER_FEATURE_SWAP_EVENTS" value="4096"/>
		</flags>
		<flags name="ClutterFontFlags" type-name="ClutterFontFlags" get-type="clutter_font_flags_get_type">
			<member name="CLUTTER_FONT_MIPMAPPING" value="1"/>
			<member name="CLUTTER_FONT_HINTING" value="2"/>
		</flags>
		<flags name="ClutterModifierType" type-name="ClutterModifierType" get-type="clutter_modifier_type_get_type">
			<member name="CLUTTER_SHIFT_MASK" value="1"/>
			<member name="CLUTTER_LOCK_MASK" value="2"/>
			<member name="CLUTTER_CONTROL_MASK" value="4"/>
			<member name="CLUTTER_MOD1_MASK" value="8"/>
			<member name="CLUTTER_MOD2_MASK" value="16"/>
			<member name="CLUTTER_MOD3_MASK" value="32"/>
			<member name="CLUTTER_MOD4_MASK" value="64"/>
			<member name="CLUTTER_MOD5_MASK" value="128"/>
			<member name="CLUTTER_BUTTON1_MASK" value="256"/>
			<member name="CLUTTER_BUTTON2_MASK" value="512"/>
			<member name="CLUTTER_BUTTON3_MASK" value="1024"/>
			<member name="CLUTTER_BUTTON4_MASK" value="2048"/>
			<member name="CLUTTER_BUTTON5_MASK" value="4096"/>
			<member name="CLUTTER_SUPER_MASK" value="67108864"/>
			<member name="CLUTTER_HYPER_MASK" value="134217728"/>
			<member name="CLUTTER_META_MASK" value="268435456"/>
			<member name="CLUTTER_RELEASE_MASK" value="1073741824"/>
			<member name="CLUTTER_MODIFIER_MASK" value="1543512063"/>
		</flags>
		<flags name="ClutterRedrawFlags" type-name="ClutterRedrawFlags" get-type="clutter_redraw_flags_get_type">
			<member name="CLUTTER_REDRAW_CLIPPED_TO_BOX" value="0"/>
			<member name="CLUTTER_REDRAW_CLIPPED_TO_ALLOCATION" value="2"/>
		</flags>
		<flags name="ClutterStageState" type-name="ClutterStageState" get-type="clutter_stage_state_get_type">
			<member name="CLUTTER_STAGE_STATE_FULLSCREEN" value="2"/>
			<member name="CLUTTER_STAGE_STATE_OFFSCREEN" value="4"/>
			<member name="CLUTTER_STAGE_STATE_ACTIVATED" value="8"/>
		</flags>
		<flags name="ClutterTextureFlags" type-name="ClutterTextureFlags" get-type="clutter_texture_flags_get_type">
			<member name="CLUTTER_TEXTURE_NONE" value="0"/>
			<member name="CLUTTER_TEXTURE_RGB_FLAG_BGR" value="2"/>
			<member name="CLUTTER_TEXTURE_RGB_FLAG_PREMULT" value="4"/>
			<member name="CLUTTER_TEXTURE_YUV_FLAG_YUV2" value="8"/>
		</flags>
		<object name="ClutterActor" parent="GInitiallyUnowned" type-name="ClutterActor" get-type="clutter_actor_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="allocate" symbol="clutter_actor_allocate">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="box" type="ClutterActorBox*"/>
					<parameter name="flags" type="ClutterAllocationFlags"/>
				</parameters>
			</method>
			<method name="allocate_available_size" symbol="clutter_actor_allocate_available_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="x" type="gfloat"/>
					<parameter name="y" type="gfloat"/>
					<parameter name="available_width" type="gfloat"/>
					<parameter name="available_height" type="gfloat"/>
					<parameter name="flags" type="ClutterAllocationFlags"/>
				</parameters>
			</method>
			<method name="allocate_preferred_size" symbol="clutter_actor_allocate_preferred_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="flags" type="ClutterAllocationFlags"/>
				</parameters>
			</method>
			<method name="animate" symbol="clutter_actor_animate">
				<return-type type="ClutterAnimation*"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="mode" type="gulong"/>
					<parameter name="duration" type="guint"/>
					<parameter name="first_property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="animate_with_alpha" symbol="clutter_actor_animate_with_alpha">
				<return-type type="ClutterAnimation*"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="first_property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="animate_with_alphav" symbol="clutter_actor_animate_with_alphav">
				<return-type type="ClutterAnimation*"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="n_properties" type="gint"/>
					<parameter name="properties" type="gchar*[]"/>
					<parameter name="values" type="GValue*"/>
				</parameters>
			</method>
			<method name="animate_with_timeline" symbol="clutter_actor_animate_with_timeline">
				<return-type type="ClutterAnimation*"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="mode" type="gulong"/>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="first_property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="animate_with_timelinev" symbol="clutter_actor_animate_with_timelinev">
				<return-type type="ClutterAnimation*"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="mode" type="gulong"/>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="n_properties" type="gint"/>
					<parameter name="properties" type="gchar*[]"/>
					<parameter name="values" type="GValue*"/>
				</parameters>
			</method>
			<method name="animatev" symbol="clutter_actor_animatev">
				<return-type type="ClutterAnimation*"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="mode" type="gulong"/>
					<parameter name="duration" type="guint"/>
					<parameter name="n_properties" type="gint"/>
					<parameter name="properties" type="gchar*[]"/>
					<parameter name="values" type="GValue*"/>
				</parameters>
			</method>
			<method name="apply_relative_transform_to_point" symbol="clutter_actor_apply_relative_transform_to_point">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="ancestor" type="ClutterActor*"/>
					<parameter name="point" type="ClutterVertex*"/>
					<parameter name="vertex" type="ClutterVertex*"/>
				</parameters>
			</method>
			<method name="apply_transform_to_point" symbol="clutter_actor_apply_transform_to_point">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="point" type="ClutterVertex*"/>
					<parameter name="vertex" type="ClutterVertex*"/>
				</parameters>
			</method>
			<method name="create_pango_context" symbol="clutter_actor_create_pango_context">
				<return-type type="PangoContext*"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="create_pango_layout" symbol="clutter_actor_create_pango_layout">
				<return-type type="PangoLayout*"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="clutter_actor_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="event" symbol="clutter_actor_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="event" type="ClutterEvent*"/>
					<parameter name="capture" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_abs_allocation_vertices" symbol="clutter_actor_get_abs_allocation_vertices">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="verts" type="ClutterVertex[]"/>
				</parameters>
			</method>
			<method name="get_allocation_box" symbol="clutter_actor_get_allocation_box">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="box" type="ClutterActorBox*"/>
				</parameters>
			</method>
			<method name="get_allocation_geometry" symbol="clutter_actor_get_allocation_geometry">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="geom" type="ClutterGeometry*"/>
				</parameters>
			</method>
			<method name="get_allocation_vertices" symbol="clutter_actor_get_allocation_vertices">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="ancestor" type="ClutterActor*"/>
					<parameter name="verts" type="ClutterVertex[]"/>
				</parameters>
			</method>
			<method name="get_anchor_point" symbol="clutter_actor_get_anchor_point">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="anchor_x" type="gfloat*"/>
					<parameter name="anchor_y" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_anchor_point_gravity" symbol="clutter_actor_get_anchor_point_gravity">
				<return-type type="ClutterGravity"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_animation" symbol="clutter_actor_get_animation">
				<return-type type="ClutterAnimation*"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_clip" symbol="clutter_actor_get_clip">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="xoff" type="gfloat*"/>
					<parameter name="yoff" type="gfloat*"/>
					<parameter name="width" type="gfloat*"/>
					<parameter name="height" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_depth" symbol="clutter_actor_get_depth">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_fixed_position_set" symbol="clutter_actor_get_fixed_position_set">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="clutter_actor_get_flags">
				<return-type type="ClutterActorFlags"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_geometry" symbol="clutter_actor_get_geometry">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="geometry" type="ClutterGeometry*"/>
				</parameters>
			</method>
			<method name="get_gid" symbol="clutter_actor_get_gid">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="clutter_actor_get_height">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="clutter_actor_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_opacity" symbol="clutter_actor_get_opacity">
				<return-type type="guint8"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_paint_opacity" symbol="clutter_actor_get_paint_opacity">
				<return-type type="guint8"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_paint_visibility" symbol="clutter_actor_get_paint_visibility">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_pango_context" symbol="clutter_actor_get_pango_context">
				<return-type type="PangoContext*"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="clutter_actor_get_parent">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_position" symbol="clutter_actor_get_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="x" type="gfloat*"/>
					<parameter name="y" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_preferred_height" symbol="clutter_actor_get_preferred_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="for_width" type="gfloat"/>
					<parameter name="min_height_p" type="gfloat*"/>
					<parameter name="natural_height_p" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_preferred_size" symbol="clutter_actor_get_preferred_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="min_width_p" type="gfloat*"/>
					<parameter name="min_height_p" type="gfloat*"/>
					<parameter name="natural_width_p" type="gfloat*"/>
					<parameter name="natural_height_p" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_preferred_width" symbol="clutter_actor_get_preferred_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="for_height" type="gfloat"/>
					<parameter name="min_width_p" type="gfloat*"/>
					<parameter name="natural_width_p" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_reactive" symbol="clutter_actor_get_reactive">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_request_mode" symbol="clutter_actor_get_request_mode">
				<return-type type="ClutterRequestMode"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_rotation" symbol="clutter_actor_get_rotation">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="axis" type="ClutterRotateAxis"/>
					<parameter name="x" type="gfloat*"/>
					<parameter name="y" type="gfloat*"/>
					<parameter name="z" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_scale" symbol="clutter_actor_get_scale">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="scale_x" type="gdouble*"/>
					<parameter name="scale_y" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_scale_center" symbol="clutter_actor_get_scale_center">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="center_x" type="gfloat*"/>
					<parameter name="center_y" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_scale_gravity" symbol="clutter_actor_get_scale_gravity">
				<return-type type="ClutterGravity"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_shader" symbol="clutter_actor_get_shader">
				<return-type type="ClutterShader*"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="clutter_actor_get_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="width" type="gfloat*"/>
					<parameter name="height" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_stage" symbol="clutter_actor_get_stage">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_text_direction" symbol="clutter_actor_get_text_direction">
				<return-type type="ClutterTextDirection"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_transformation_matrix" symbol="clutter_actor_get_transformation_matrix">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="matrix" type="CoglMatrix*"/>
				</parameters>
			</method>
			<method name="get_transformed_position" symbol="clutter_actor_get_transformed_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="x" type="gfloat*"/>
					<parameter name="y" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_transformed_size" symbol="clutter_actor_get_transformed_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="width" type="gfloat*"/>
					<parameter name="height" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="clutter_actor_get_width">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_x" symbol="clutter_actor_get_x">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_y" symbol="clutter_actor_get_y">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_z_rotation_gravity" symbol="clutter_actor_get_z_rotation_gravity">
				<return-type type="ClutterGravity"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="grab_key_focus" symbol="clutter_actor_grab_key_focus">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="has_clip" symbol="clutter_actor_has_clip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="has_pointer" symbol="clutter_actor_has_pointer">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="hide" symbol="clutter_actor_hide">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="hide_all" symbol="clutter_actor_hide_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="is_in_clone_paint" symbol="clutter_actor_is_in_clone_paint">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="is_rotated" symbol="clutter_actor_is_rotated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="is_scaled" symbol="clutter_actor_is_scaled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="lower" symbol="clutter_actor_lower">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="above" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="lower_bottom" symbol="clutter_actor_lower_bottom">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="map" symbol="clutter_actor_map">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="move_anchor_point" symbol="clutter_actor_move_anchor_point">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="anchor_x" type="gfloat"/>
					<parameter name="anchor_y" type="gfloat"/>
				</parameters>
			</method>
			<method name="move_anchor_point_from_gravity" symbol="clutter_actor_move_anchor_point_from_gravity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="gravity" type="ClutterGravity"/>
				</parameters>
			</method>
			<method name="move_by" symbol="clutter_actor_move_by">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="dx" type="gfloat"/>
					<parameter name="dy" type="gfloat"/>
				</parameters>
			</method>
			<method name="paint" symbol="clutter_actor_paint">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="pop_internal" symbol="clutter_actor_pop_internal">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="push_internal" symbol="clutter_actor_push_internal">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="queue_redraw" symbol="clutter_actor_queue_redraw">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="queue_relayout" symbol="clutter_actor_queue_relayout">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="raise" symbol="clutter_actor_raise">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="below" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="raise_top" symbol="clutter_actor_raise_top">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="realize" symbol="clutter_actor_realize">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="remove_clip" symbol="clutter_actor_remove_clip">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="reparent" symbol="clutter_actor_reparent">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="new_parent" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="set_anchor_point" symbol="clutter_actor_set_anchor_point">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="anchor_x" type="gfloat"/>
					<parameter name="anchor_y" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_anchor_point_from_gravity" symbol="clutter_actor_set_anchor_point_from_gravity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="gravity" type="ClutterGravity"/>
				</parameters>
			</method>
			<method name="set_clip" symbol="clutter_actor_set_clip">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="xoff" type="gfloat"/>
					<parameter name="yoff" type="gfloat"/>
					<parameter name="width" type="gfloat"/>
					<parameter name="height" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_depth" symbol="clutter_actor_set_depth">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="depth" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_fixed_position_set" symbol="clutter_actor_set_fixed_position_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="is_set" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_flags" symbol="clutter_actor_set_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="flags" type="ClutterActorFlags"/>
				</parameters>
			</method>
			<method name="set_geometry" symbol="clutter_actor_set_geometry">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="geometry" type="ClutterGeometry*"/>
				</parameters>
			</method>
			<method name="set_height" symbol="clutter_actor_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="height" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_name" symbol="clutter_actor_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_opacity" symbol="clutter_actor_set_opacity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="opacity" type="guint8"/>
				</parameters>
			</method>
			<method name="set_parent" symbol="clutter_actor_set_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="parent" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="set_position" symbol="clutter_actor_set_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="x" type="gfloat"/>
					<parameter name="y" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_reactive" symbol="clutter_actor_set_reactive">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="reactive" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_request_mode" symbol="clutter_actor_set_request_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="mode" type="ClutterRequestMode"/>
				</parameters>
			</method>
			<method name="set_rotation" symbol="clutter_actor_set_rotation">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="axis" type="ClutterRotateAxis"/>
					<parameter name="angle" type="gdouble"/>
					<parameter name="x" type="gfloat"/>
					<parameter name="y" type="gfloat"/>
					<parameter name="z" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_scale" symbol="clutter_actor_set_scale">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="scale_x" type="gdouble"/>
					<parameter name="scale_y" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_scale_full" symbol="clutter_actor_set_scale_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="scale_x" type="gdouble"/>
					<parameter name="scale_y" type="gdouble"/>
					<parameter name="center_x" type="gfloat"/>
					<parameter name="center_y" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_scale_with_gravity" symbol="clutter_actor_set_scale_with_gravity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="scale_x" type="gdouble"/>
					<parameter name="scale_y" type="gdouble"/>
					<parameter name="gravity" type="ClutterGravity"/>
				</parameters>
			</method>
			<method name="set_shader" symbol="clutter_actor_set_shader">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="shader" type="ClutterShader*"/>
				</parameters>
			</method>
			<method name="set_shader_param" symbol="clutter_actor_set_shader_param">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="param" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_shader_param_float" symbol="clutter_actor_set_shader_param_float">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="param" type="gchar*"/>
					<parameter name="value" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_shader_param_int" symbol="clutter_actor_set_shader_param_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="param" type="gchar*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_size" symbol="clutter_actor_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="width" type="gfloat"/>
					<parameter name="height" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_text_direction" symbol="clutter_actor_set_text_direction">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="text_dir" type="ClutterTextDirection"/>
				</parameters>
			</method>
			<method name="set_width" symbol="clutter_actor_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="width" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_x" symbol="clutter_actor_set_x">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="x" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_y" symbol="clutter_actor_set_y">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="y" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_z_rotation_from_gravity" symbol="clutter_actor_set_z_rotation_from_gravity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="angle" type="gdouble"/>
					<parameter name="gravity" type="ClutterGravity"/>
				</parameters>
			</method>
			<method name="should_pick_paint" symbol="clutter_actor_should_pick_paint">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="show" symbol="clutter_actor_show">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="show_all" symbol="clutter_actor_show_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="transform_stage_point" symbol="clutter_actor_transform_stage_point">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="x" type="gfloat"/>
					<parameter name="y" type="gfloat"/>
					<parameter name="x_out" type="gfloat*"/>
					<parameter name="y_out" type="gfloat*"/>
				</parameters>
			</method>
			<method name="unmap" symbol="clutter_actor_unmap">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="unparent" symbol="clutter_actor_unparent">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="unrealize" symbol="clutter_actor_unrealize">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="unset_flags" symbol="clutter_actor_unset_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterActor*"/>
					<parameter name="flags" type="ClutterActorFlags"/>
				</parameters>
			</method>
			<property name="allocation" type="ClutterActorBox*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="anchor-gravity" type="ClutterGravity" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="anchor-x" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="anchor-y" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="clip" type="ClutterGeometry*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="clip-to-allocation" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="depth" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fixed-position-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fixed-x" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fixed-y" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="has-clip" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="has-pointer" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="height" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="mapped" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="min-height" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="min-height-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="min-width" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="min-width-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="natural-height" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="natural-height-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="natural-width" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="natural-width-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="opacity" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="reactive" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="realized" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="request-mode" type="ClutterRequestMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rotation-angle-x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rotation-angle-y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rotation-angle-z" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rotation-center-x" type="ClutterVertex*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rotation-center-y" type="ClutterVertex*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rotation-center-z" type="ClutterVertex*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rotation-center-z-gravity" type="ClutterGravity" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scale-center-x" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scale-center-y" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scale-gravity" type="ClutterGravity" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scale-x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scale-y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-on-set-parent" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text-direction" type="ClutterTextDirection" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="visible" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="allocation-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="ClutterActor*"/>
					<parameter name="p0" type="ClutterActorBox*"/>
					<parameter name="p1" type="ClutterAllocationFlags"/>
				</parameters>
			</signal>
			<signal name="button-press-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</signal>
			<signal name="button-release-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</signal>
			<signal name="captured-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</signal>
			<signal name="destroy" when="CLEANUP">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="enter-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</signal>
			<signal name="event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</signal>
			<signal name="hide" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="key-focus-in" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="key-focus-out" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="key-press-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</signal>
			<signal name="key-release-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</signal>
			<signal name="leave-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</signal>
			<signal name="motion-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</signal>
			<signal name="paint" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="parent-set" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="old_parent" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="pick" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</signal>
			<signal name="queue-redraw" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="leaf_that_queued" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="queue-relayout" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="realize" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="scroll-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</signal>
			<signal name="show" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="unrealize" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<vfunc name="allocate">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="box" type="ClutterActorBox*"/>
					<parameter name="flags" type="ClutterAllocationFlags"/>
				</parameters>
			</vfunc>
			<vfunc name="apply_transform">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="matrix" type="CoglMatrix*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_preferred_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="for_width" type="gfloat"/>
					<parameter name="min_height_p" type="gfloat*"/>
					<parameter name="natural_height_p" type="gfloat*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_preferred_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="for_height" type="gfloat"/>
					<parameter name="min_width_p" type="gfloat*"/>
					<parameter name="natural_width_p" type="gfloat*"/>
				</parameters>
			</vfunc>
			<vfunc name="hide_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<vfunc name="map">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<vfunc name="show_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<vfunc name="unmap">
				<return-type type="void"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<field name="flags" type="guint32"/>
		</object>
		<object name="ClutterAlpha" parent="GInitiallyUnowned" type-name="ClutterAlpha" get-type="clutter_alpha_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="get_alpha" symbol="clutter_alpha_get_alpha">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
				</parameters>
			</method>
			<method name="get_mode" symbol="clutter_alpha_get_mode">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
				</parameters>
			</method>
			<method name="get_timeline" symbol="clutter_alpha_get_timeline">
				<return-type type="ClutterTimeline*"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_alpha_new">
				<return-type type="ClutterAlpha*"/>
			</constructor>
			<constructor name="new_full" symbol="clutter_alpha_new_full">
				<return-type type="ClutterAlpha*"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="mode" type="gulong"/>
				</parameters>
			</constructor>
			<constructor name="new_with_func" symbol="clutter_alpha_new_with_func">
				<return-type type="ClutterAlpha*"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="func" type="ClutterAlphaFunc"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</constructor>
			<method name="register_closure" symbol="clutter_alpha_register_closure">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="closure" type="GClosure*"/>
				</parameters>
			</method>
			<method name="register_func" symbol="clutter_alpha_register_func">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="func" type="ClutterAlphaFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_closure" symbol="clutter_alpha_set_closure">
				<return-type type="void"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="closure" type="GClosure*"/>
				</parameters>
			</method>
			<method name="set_func" symbol="clutter_alpha_set_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="func" type="ClutterAlphaFunc"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_mode" symbol="clutter_alpha_set_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="mode" type="gulong"/>
				</parameters>
			</method>
			<method name="set_timeline" symbol="clutter_alpha_set_timeline">
				<return-type type="void"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<property name="alpha" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="mode" type="gulong" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="timeline" type="ClutterTimeline*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterAnimation" parent="GObject" type-name="ClutterAnimation" get-type="clutter_animation_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="bind" symbol="clutter_animation_bind">
				<return-type type="ClutterAnimation*"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="final" type="GValue*"/>
				</parameters>
			</method>
			<method name="bind_interval" symbol="clutter_animation_bind_interval">
				<return-type type="ClutterAnimation*"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="interval" type="ClutterInterval*"/>
				</parameters>
			</method>
			<method name="completed" symbol="clutter_animation_completed">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
				</parameters>
			</method>
			<method name="get_alpha" symbol="clutter_animation_get_alpha">
				<return-type type="ClutterAlpha*"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
				</parameters>
			</method>
			<method name="get_duration" symbol="clutter_animation_get_duration">
				<return-type type="guint"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
				</parameters>
			</method>
			<method name="get_interval" symbol="clutter_animation_get_interval">
				<return-type type="ClutterInterval*"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_loop" symbol="clutter_animation_get_loop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
				</parameters>
			</method>
			<method name="get_mode" symbol="clutter_animation_get_mode">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
				</parameters>
			</method>
			<method name="get_object" symbol="clutter_animation_get_object">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
				</parameters>
			</method>
			<method name="get_timeline" symbol="clutter_animation_get_timeline">
				<return-type type="ClutterTimeline*"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
				</parameters>
			</method>
			<method name="has_property" symbol="clutter_animation_has_property">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_animation_new">
				<return-type type="ClutterAnimation*"/>
			</constructor>
			<method name="set_alpha" symbol="clutter_animation_set_alpha">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="alpha" type="ClutterAlpha*"/>
				</parameters>
			</method>
			<method name="set_duration" symbol="clutter_animation_set_duration">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="msecs" type="gint"/>
				</parameters>
			</method>
			<method name="set_loop" symbol="clutter_animation_set_loop">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="loop" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_mode" symbol="clutter_animation_set_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="mode" type="gulong"/>
				</parameters>
			</method>
			<method name="set_object" symbol="clutter_animation_set_object">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="object" type="GObject*"/>
				</parameters>
			</method>
			<method name="set_timeline" symbol="clutter_animation_set_timeline">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="unbind_property" symbol="clutter_animation_unbind_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="update" symbol="clutter_animation_update">
				<return-type type="ClutterAnimation*"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="final" type="GValue*"/>
				</parameters>
			</method>
			<method name="update_interval" symbol="clutter_animation_update_interval">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="interval" type="ClutterInterval*"/>
				</parameters>
			</method>
			<property name="alpha" type="ClutterAlpha*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="duration" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="loop" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="mode" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="object" type="GObject*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="timeline" type="ClutterTimeline*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="completed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
				</parameters>
			</signal>
			<signal name="started" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="ClutterAnimation*"/>
				</parameters>
			</signal>
		</object>
		<object name="ClutterAnimator" parent="GObject" type-name="ClutterAnimator" get-type="clutter_animator_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="compute_value" symbol="clutter_animator_compute_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
					<parameter name="object" type="GObject*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="progress" type="gdouble"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_duration" symbol="clutter_animator_get_duration">
				<return-type type="guint"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
				</parameters>
			</method>
			<method name="get_keys" symbol="clutter_animator_get_keys">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
					<parameter name="object" type="GObject*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="progress" type="gdouble"/>
				</parameters>
			</method>
			<method name="get_timeline" symbol="clutter_animator_get_timeline">
				<return-type type="ClutterTimeline*"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_animator_new">
				<return-type type="ClutterAnimator*"/>
			</constructor>
			<method name="property_get_ease_in" symbol="clutter_animator_property_get_ease_in">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
					<parameter name="object" type="GObject*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="property_get_interpolation" symbol="clutter_animator_property_get_interpolation">
				<return-type type="ClutterInterpolation"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
					<parameter name="object" type="GObject*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="property_set_ease_in" symbol="clutter_animator_property_set_ease_in">
				<return-type type="void"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
					<parameter name="object" type="GObject*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="ease_in" type="gboolean"/>
				</parameters>
			</method>
			<method name="property_set_interpolation" symbol="clutter_animator_property_set_interpolation">
				<return-type type="void"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
					<parameter name="object" type="GObject*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="interpolation" type="ClutterInterpolation"/>
				</parameters>
			</method>
			<method name="remove_key" symbol="clutter_animator_remove_key">
				<return-type type="void"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
					<parameter name="object" type="GObject*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="progress" type="gdouble"/>
				</parameters>
			</method>
			<method name="set" symbol="clutter_animator_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
					<parameter name="first_object" type="gpointer"/>
					<parameter name="first_property_name" type="gchar*"/>
					<parameter name="first_mode" type="guint"/>
					<parameter name="first_progress" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_duration" symbol="clutter_animator_set_duration">
				<return-type type="void"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
					<parameter name="duration" type="guint"/>
				</parameters>
			</method>
			<method name="set_key" symbol="clutter_animator_set_key">
				<return-type type="ClutterAnimator*"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
					<parameter name="object" type="GObject*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="mode" type="guint"/>
					<parameter name="progress" type="gdouble"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_timeline" symbol="clutter_animator_set_timeline">
				<return-type type="void"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="start" symbol="clutter_animator_start">
				<return-type type="ClutterTimeline*"/>
				<parameters>
					<parameter name="animator" type="ClutterAnimator*"/>
				</parameters>
			</method>
			<property name="duration" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="timeline" type="ClutterTimeline*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterBackend" parent="GObject" type-name="ClutterBackend" get-type="clutter_backend_get_type">
			<method name="get_double_click_distance" symbol="clutter_backend_get_double_click_distance">
				<return-type type="guint"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
				</parameters>
			</method>
			<method name="get_double_click_time" symbol="clutter_backend_get_double_click_time">
				<return-type type="guint"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
				</parameters>
			</method>
			<method name="get_font_name" symbol="clutter_backend_get_font_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
				</parameters>
			</method>
			<method name="get_font_options" symbol="clutter_backend_get_font_options">
				<return-type type="cairo_font_options_t*"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
				</parameters>
			</method>
			<method name="get_resolution" symbol="clutter_backend_get_resolution">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
				</parameters>
			</method>
			<method name="set_double_click_distance" symbol="clutter_backend_set_double_click_distance">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
					<parameter name="distance" type="guint"/>
				</parameters>
			</method>
			<method name="set_double_click_time" symbol="clutter_backend_set_double_click_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
					<parameter name="msec" type="guint"/>
				</parameters>
			</method>
			<method name="set_font_name" symbol="clutter_backend_set_font_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
					<parameter name="font_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_font_options" symbol="clutter_backend_set_font_options">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
					<parameter name="options" type="cairo_font_options_t*"/>
				</parameters>
			</method>
			<method name="set_resolution" symbol="clutter_backend_set_resolution">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
					<parameter name="dpi" type="gdouble"/>
				</parameters>
			</method>
			<signal name="font-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
				</parameters>
			</signal>
			<signal name="resolution-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
				</parameters>
			</signal>
			<vfunc name="add_options">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
					<parameter name="group" type="GOptionGroup*"/>
				</parameters>
			</vfunc>
			<vfunc name="create_context">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="create_stage">
				<return-type type="ClutterStageWindow*"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
					<parameter name="wrapper" type="ClutterStage*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="ensure_context">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_device_manager">
				<return-type type="ClutterDeviceManager*"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_features">
				<return-type type="ClutterFeatureFlags"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
				</parameters>
			</vfunc>
			<vfunc name="init_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
				</parameters>
			</vfunc>
			<vfunc name="init_features">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
				</parameters>
			</vfunc>
			<vfunc name="post_parse">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="pre_parse">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="redraw">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="ClutterBackend*"/>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="ClutterBehaviour" parent="GObject" type-name="ClutterBehaviour" get-type="clutter_behaviour_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="actors_foreach" symbol="clutter_behaviour_actors_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
					<parameter name="func" type="ClutterBehaviourForeachFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="apply" symbol="clutter_behaviour_apply">
				<return-type type="void"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_actors" symbol="clutter_behaviour_get_actors">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
				</parameters>
			</method>
			<method name="get_alpha" symbol="clutter_behaviour_get_alpha">
				<return-type type="ClutterAlpha*"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
				</parameters>
			</method>
			<method name="get_n_actors" symbol="clutter_behaviour_get_n_actors">
				<return-type type="gint"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
				</parameters>
			</method>
			<method name="get_nth_actor" symbol="clutter_behaviour_get_nth_actor">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
					<parameter name="index_" type="gint"/>
				</parameters>
			</method>
			<method name="is_applied" symbol="clutter_behaviour_is_applied">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="remove" symbol="clutter_behaviour_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="remove_all" symbol="clutter_behaviour_remove_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
				</parameters>
			</method>
			<method name="set_alpha" symbol="clutter_behaviour_set_alpha">
				<return-type type="void"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
					<parameter name="alpha" type="ClutterAlpha*"/>
				</parameters>
			</method>
			<property name="alpha" type="ClutterAlpha*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="applied" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="removed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<vfunc name="alpha_notify">
				<return-type type="void"/>
				<parameters>
					<parameter name="behave" type="ClutterBehaviour*"/>
					<parameter name="alpha_value" type="gdouble"/>
				</parameters>
			</vfunc>
		</object>
		<object name="ClutterBehaviourDepth" parent="ClutterBehaviour" type-name="ClutterBehaviourDepth" get-type="clutter_behaviour_depth_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="get_bounds" symbol="clutter_behaviour_depth_get_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="behaviour" type="ClutterBehaviourDepth*"/>
					<parameter name="depth_start" type="gint*"/>
					<parameter name="depth_end" type="gint*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_behaviour_depth_new">
				<return-type type="ClutterBehaviour*"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="depth_start" type="gint"/>
					<parameter name="depth_end" type="gint"/>
				</parameters>
			</constructor>
			<method name="set_bounds" symbol="clutter_behaviour_depth_set_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="behaviour" type="ClutterBehaviourDepth*"/>
					<parameter name="depth_start" type="gint"/>
					<parameter name="depth_end" type="gint"/>
				</parameters>
			</method>
			<property name="depth-end" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="depth-start" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterBehaviourEllipse" parent="ClutterBehaviour" type-name="ClutterBehaviourEllipse" get-type="clutter_behaviour_ellipse_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="get_angle_end" symbol="clutter_behaviour_ellipse_get_angle_end">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
				</parameters>
			</method>
			<method name="get_angle_start" symbol="clutter_behaviour_ellipse_get_angle_start">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
				</parameters>
			</method>
			<method name="get_angle_tilt" symbol="clutter_behaviour_ellipse_get_angle_tilt">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
					<parameter name="axis" type="ClutterRotateAxis"/>
				</parameters>
			</method>
			<method name="get_center" symbol="clutter_behaviour_ellipse_get_center">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
				</parameters>
			</method>
			<method name="get_direction" symbol="clutter_behaviour_ellipse_get_direction">
				<return-type type="ClutterRotateDirection"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="clutter_behaviour_ellipse_get_height">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
				</parameters>
			</method>
			<method name="get_tilt" symbol="clutter_behaviour_ellipse_get_tilt">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
					<parameter name="angle_tilt_x" type="gdouble*"/>
					<parameter name="angle_tilt_y" type="gdouble*"/>
					<parameter name="angle_tilt_z" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="clutter_behaviour_ellipse_get_width">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_behaviour_ellipse_new">
				<return-type type="ClutterBehaviour*"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="direction" type="ClutterRotateDirection"/>
					<parameter name="start" type="gdouble"/>
					<parameter name="end" type="gdouble"/>
				</parameters>
			</constructor>
			<method name="set_angle_end" symbol="clutter_behaviour_ellipse_set_angle_end">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
					<parameter name="angle_end" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_angle_start" symbol="clutter_behaviour_ellipse_set_angle_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
					<parameter name="angle_start" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_angle_tilt" symbol="clutter_behaviour_ellipse_set_angle_tilt">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
					<parameter name="axis" type="ClutterRotateAxis"/>
					<parameter name="angle_tilt" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_center" symbol="clutter_behaviour_ellipse_set_center">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="set_direction" symbol="clutter_behaviour_ellipse_set_direction">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
					<parameter name="direction" type="ClutterRotateDirection"/>
				</parameters>
			</method>
			<method name="set_height" symbol="clutter_behaviour_ellipse_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<method name="set_tilt" symbol="clutter_behaviour_ellipse_set_tilt">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
					<parameter name="angle_tilt_x" type="gdouble"/>
					<parameter name="angle_tilt_y" type="gdouble"/>
					<parameter name="angle_tilt_z" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_width" symbol="clutter_behaviour_ellipse_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBehaviourEllipse*"/>
					<parameter name="width" type="gint"/>
				</parameters>
			</method>
			<property name="angle-end" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="angle-start" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="angle-tilt-x" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="angle-tilt-y" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="angle-tilt-z" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="center" type="ClutterKnot*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="direction" type="ClutterRotateDirection" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterBehaviourOpacity" parent="ClutterBehaviour" type-name="ClutterBehaviourOpacity" get-type="clutter_behaviour_opacity_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="get_bounds" symbol="clutter_behaviour_opacity_get_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="behaviour" type="ClutterBehaviourOpacity*"/>
					<parameter name="opacity_start" type="guint8*"/>
					<parameter name="opacity_end" type="guint8*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_behaviour_opacity_new">
				<return-type type="ClutterBehaviour*"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="opacity_start" type="guint8"/>
					<parameter name="opacity_end" type="guint8"/>
				</parameters>
			</constructor>
			<method name="set_bounds" symbol="clutter_behaviour_opacity_set_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="behaviour" type="ClutterBehaviourOpacity*"/>
					<parameter name="opacity_start" type="guint8"/>
					<parameter name="opacity_end" type="guint8"/>
				</parameters>
			</method>
			<property name="opacity-end" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="opacity-start" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterBehaviourPath" parent="ClutterBehaviour" type-name="ClutterBehaviourPath" get-type="clutter_behaviour_path_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="get_path" symbol="clutter_behaviour_path_get_path">
				<return-type type="ClutterPath*"/>
				<parameters>
					<parameter name="pathb" type="ClutterBehaviourPath*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_behaviour_path_new">
				<return-type type="ClutterBehaviour*"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="path" type="ClutterPath*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_description" symbol="clutter_behaviour_path_new_with_description">
				<return-type type="ClutterBehaviour*"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="desc" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_knots" symbol="clutter_behaviour_path_new_with_knots">
				<return-type type="ClutterBehaviour*"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="knots" type="ClutterKnot*"/>
					<parameter name="n_knots" type="guint"/>
				</parameters>
			</constructor>
			<method name="set_path" symbol="clutter_behaviour_path_set_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="pathb" type="ClutterBehaviourPath*"/>
					<parameter name="path" type="ClutterPath*"/>
				</parameters>
			</method>
			<property name="path" type="ClutterPath*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="knot-reached" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pathb" type="ClutterBehaviourPath*"/>
					<parameter name="knot_num" type="guint"/>
				</parameters>
			</signal>
		</object>
		<object name="ClutterBehaviourRotate" parent="ClutterBehaviour" type-name="ClutterBehaviourRotate" get-type="clutter_behaviour_rotate_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="get_axis" symbol="clutter_behaviour_rotate_get_axis">
				<return-type type="ClutterRotateAxis"/>
				<parameters>
					<parameter name="rotate" type="ClutterBehaviourRotate*"/>
				</parameters>
			</method>
			<method name="get_bounds" symbol="clutter_behaviour_rotate_get_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="rotate" type="ClutterBehaviourRotate*"/>
					<parameter name="angle_start" type="gdouble*"/>
					<parameter name="angle_end" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_center" symbol="clutter_behaviour_rotate_get_center">
				<return-type type="void"/>
				<parameters>
					<parameter name="rotate" type="ClutterBehaviourRotate*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="z" type="gint*"/>
				</parameters>
			</method>
			<method name="get_direction" symbol="clutter_behaviour_rotate_get_direction">
				<return-type type="ClutterRotateDirection"/>
				<parameters>
					<parameter name="rotate" type="ClutterBehaviourRotate*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_behaviour_rotate_new">
				<return-type type="ClutterBehaviour*"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="axis" type="ClutterRotateAxis"/>
					<parameter name="direction" type="ClutterRotateDirection"/>
					<parameter name="angle_start" type="gdouble"/>
					<parameter name="angle_end" type="gdouble"/>
				</parameters>
			</constructor>
			<method name="set_axis" symbol="clutter_behaviour_rotate_set_axis">
				<return-type type="void"/>
				<parameters>
					<parameter name="rotate" type="ClutterBehaviourRotate*"/>
					<parameter name="axis" type="ClutterRotateAxis"/>
				</parameters>
			</method>
			<method name="set_bounds" symbol="clutter_behaviour_rotate_set_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="rotate" type="ClutterBehaviourRotate*"/>
					<parameter name="angle_start" type="gdouble"/>
					<parameter name="angle_end" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_center" symbol="clutter_behaviour_rotate_set_center">
				<return-type type="void"/>
				<parameters>
					<parameter name="rotate" type="ClutterBehaviourRotate*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="z" type="gint"/>
				</parameters>
			</method>
			<method name="set_direction" symbol="clutter_behaviour_rotate_set_direction">
				<return-type type="void"/>
				<parameters>
					<parameter name="rotate" type="ClutterBehaviourRotate*"/>
					<parameter name="direction" type="ClutterRotateDirection"/>
				</parameters>
			</method>
			<property name="angle-end" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="angle-start" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="axis" type="ClutterRotateAxis" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="center-x" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="center-y" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="center-z" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="direction" type="ClutterRotateDirection" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterBehaviourScale" parent="ClutterBehaviour" type-name="ClutterBehaviourScale" get-type="clutter_behaviour_scale_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="get_bounds" symbol="clutter_behaviour_scale_get_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="scale" type="ClutterBehaviourScale*"/>
					<parameter name="x_scale_start" type="gdouble*"/>
					<parameter name="y_scale_start" type="gdouble*"/>
					<parameter name="x_scale_end" type="gdouble*"/>
					<parameter name="y_scale_end" type="gdouble*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_behaviour_scale_new">
				<return-type type="ClutterBehaviour*"/>
				<parameters>
					<parameter name="alpha" type="ClutterAlpha*"/>
					<parameter name="x_scale_start" type="gdouble"/>
					<parameter name="y_scale_start" type="gdouble"/>
					<parameter name="x_scale_end" type="gdouble"/>
					<parameter name="y_scale_end" type="gdouble"/>
				</parameters>
			</constructor>
			<method name="set_bounds" symbol="clutter_behaviour_scale_set_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="scale" type="ClutterBehaviourScale*"/>
					<parameter name="x_scale_start" type="gdouble"/>
					<parameter name="y_scale_start" type="gdouble"/>
					<parameter name="x_scale_end" type="gdouble"/>
					<parameter name="y_scale_end" type="gdouble"/>
				</parameters>
			</method>
			<property name="x-scale-end" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x-scale-start" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-scale-end" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-scale-start" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterBinLayout" parent="ClutterLayoutManager" type-name="ClutterBinLayout" get-type="clutter_bin_layout_get_type">
			<method name="add" symbol="clutter_bin_layout_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBinLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="x_align" type="ClutterBinAlignment"/>
					<parameter name="y_align" type="ClutterBinAlignment"/>
				</parameters>
			</method>
			<method name="get_alignment" symbol="clutter_bin_layout_get_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBinLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="x_align" type="ClutterBinAlignment*"/>
					<parameter name="y_align" type="ClutterBinAlignment*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_bin_layout_new">
				<return-type type="ClutterLayoutManager*"/>
				<parameters>
					<parameter name="x_align" type="ClutterBinAlignment"/>
					<parameter name="y_align" type="ClutterBinAlignment"/>
				</parameters>
			</constructor>
			<method name="set_alignment" symbol="clutter_bin_layout_set_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterBinLayout*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="x_align" type="ClutterBinAlignment"/>
					<parameter name="y_align" type="ClutterBinAlignment"/>
				</parameters>
			</method>
			<property name="x-align" type="ClutterBinAlignment" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y-align" type="ClutterBinAlignment" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterBindingPool" parent="GObject" type-name="ClutterBindingPool" get-type="clutter_binding_pool_get_type">
			<method name="activate" symbol="clutter_binding_pool_activate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pool" type="ClutterBindingPool*"/>
					<parameter name="key_val" type="guint"/>
					<parameter name="modifiers" type="ClutterModifierType"/>
					<parameter name="gobject" type="GObject*"/>
				</parameters>
			</method>
			<method name="block_action" symbol="clutter_binding_pool_block_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="ClutterBindingPool*"/>
					<parameter name="action_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="find" symbol="clutter_binding_pool_find">
				<return-type type="ClutterBindingPool*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="find_action" symbol="clutter_binding_pool_find_action">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="pool" type="ClutterBindingPool*"/>
					<parameter name="key_val" type="guint"/>
					<parameter name="modifiers" type="ClutterModifierType"/>
				</parameters>
			</method>
			<method name="get_for_class" symbol="clutter_binding_pool_get_for_class">
				<return-type type="ClutterBindingPool*"/>
				<parameters>
					<parameter name="klass" type="gpointer"/>
				</parameters>
			</method>
			<method name="install_action" symbol="clutter_binding_pool_install_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="ClutterBindingPool*"/>
					<parameter name="action_name" type="gchar*"/>
					<parameter name="key_val" type="guint"/>
					<parameter name="modifiers" type="ClutterModifierType"/>
					<parameter name="callback" type="GCallback"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="install_closure" symbol="clutter_binding_pool_install_closure">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="ClutterBindingPool*"/>
					<parameter name="action_name" type="gchar*"/>
					<parameter name="key_val" type="guint"/>
					<parameter name="modifiers" type="ClutterModifierType"/>
					<parameter name="closure" type="GClosure*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_binding_pool_new">
				<return-type type="ClutterBindingPool*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="override_action" symbol="clutter_binding_pool_override_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="ClutterBindingPool*"/>
					<parameter name="key_val" type="guint"/>
					<parameter name="modifiers" type="ClutterModifierType"/>
					<parameter name="callback" type="GCallback"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="override_closure" symbol="clutter_binding_pool_override_closure">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="ClutterBindingPool*"/>
					<parameter name="key_val" type="guint"/>
					<parameter name="modifiers" type="ClutterModifierType"/>
					<parameter name="closure" type="GClosure*"/>
				</parameters>
			</method>
			<method name="remove_action" symbol="clutter_binding_pool_remove_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="ClutterBindingPool*"/>
					<parameter name="key_val" type="guint"/>
					<parameter name="modifiers" type="ClutterModifierType"/>
				</parameters>
			</method>
			<method name="unblock_action" symbol="clutter_binding_pool_unblock_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="pool" type="ClutterBindingPool*"/>
					<parameter name="action_name" type="gchar*"/>
				</parameters>
			</method>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="ClutterBox" parent="ClutterActor" type-name="ClutterBox" get-type="clutter_box_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="ClutterContainer"/>
			</implements>
			<method name="get_color" symbol="clutter_box_get_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterBox*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="get_layout_manager" symbol="clutter_box_get_layout_manager">
				<return-type type="ClutterLayoutManager*"/>
				<parameters>
					<parameter name="box" type="ClutterBox*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_box_new">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
				</parameters>
			</constructor>
			<method name="pack" symbol="clutter_box_pack">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterBox*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="first_property" type="gchar*"/>
				</parameters>
			</method>
			<method name="pack_after" symbol="clutter_box_pack_after">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterBox*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="sibling" type="ClutterActor*"/>
					<parameter name="first_property" type="gchar*"/>
				</parameters>
			</method>
			<method name="pack_at" symbol="clutter_box_pack_at">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterBox*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="position" type="gint"/>
					<parameter name="first_property" type="gchar*"/>
				</parameters>
			</method>
			<method name="pack_before" symbol="clutter_box_pack_before">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterBox*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="sibling" type="ClutterActor*"/>
					<parameter name="first_property" type="gchar*"/>
				</parameters>
			</method>
			<method name="packv" symbol="clutter_box_packv">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterBox*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="n_properties" type="guint"/>
					<parameter name="properties" type="gchar*[]"/>
					<parameter name="values" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_color" symbol="clutter_box_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterBox*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="set_layout_manager" symbol="clutter_box_set_layout_manager">
				<return-type type="void"/>
				<parameters>
					<parameter name="box" type="ClutterBox*"/>
					<parameter name="manager" type="ClutterLayoutManager*"/>
				</parameters>
			</method>
			<property name="color" type="ClutterColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="color-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="layout-manager" type="ClutterLayoutManager*" readable="1" writable="1" construct="1" construct-only="0"/>
			<vfunc name="clutter_padding_1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="clutter_padding_2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="clutter_padding_3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="clutter_padding_4">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="clutter_padding_5">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="clutter_padding_6">
				<return-type type="void"/>
			</vfunc>
		</object>
		<object name="ClutterBoxLayout" parent="ClutterLayoutManager" type-name="ClutterBoxLayout" get-type="clutter_box_layout_get_type">
			<method name="get_alignment" symbol="clutter_box_layout_get_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="x_align" type="ClutterBoxAlignment*"/>
					<parameter name="y_align" type="ClutterBoxAlignment*"/>
				</parameters>
			</method>
			<method name="get_easing_duration" symbol="clutter_box_layout_get_easing_duration">
				<return-type type="guint"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
				</parameters>
			</method>
			<method name="get_easing_mode" symbol="clutter_box_layout_get_easing_mode">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
				</parameters>
			</method>
			<method name="get_expand" symbol="clutter_box_layout_get_expand">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_fill" symbol="clutter_box_layout_get_fill">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="x_fill" type="gboolean*"/>
					<parameter name="y_fill" type="gboolean*"/>
				</parameters>
			</method>
			<method name="get_pack_start" symbol="clutter_box_layout_get_pack_start">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
				</parameters>
			</method>
			<method name="get_spacing" symbol="clutter_box_layout_get_spacing">
				<return-type type="guint"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
				</parameters>
			</method>
			<method name="get_use_animations" symbol="clutter_box_layout_get_use_animations">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
				</parameters>
			</method>
			<method name="get_vertical" symbol="clutter_box_layout_get_vertical">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_box_layout_new">
				<return-type type="ClutterLayoutManager*"/>
			</constructor>
			<method name="pack" symbol="clutter_box_layout_pack">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="expand" type="gboolean"/>
					<parameter name="x_fill" type="gboolean"/>
					<parameter name="y_fill" type="gboolean"/>
					<parameter name="x_align" type="ClutterBoxAlignment"/>
					<parameter name="y_align" type="ClutterBoxAlignment"/>
				</parameters>
			</method>
			<method name="set_alignment" symbol="clutter_box_layout_set_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="x_align" type="ClutterBoxAlignment"/>
					<parameter name="y_align" type="ClutterBoxAlignment"/>
				</parameters>
			</method>
			<method name="set_easing_duration" symbol="clutter_box_layout_set_easing_duration">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="msecs" type="guint"/>
				</parameters>
			</method>
			<method name="set_easing_mode" symbol="clutter_box_layout_set_easing_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="mode" type="gulong"/>
				</parameters>
			</method>
			<method name="set_expand" symbol="clutter_box_layout_set_expand">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="expand" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_fill" symbol="clutter_box_layout_set_fill">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="x_fill" type="gboolean"/>
					<parameter name="y_fill" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_pack_start" symbol="clutter_box_layout_set_pack_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="pack_start" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_spacing" symbol="clutter_box_layout_set_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="spacing" type="guint"/>
				</parameters>
			</method>
			<method name="set_use_animations" symbol="clutter_box_layout_set_use_animations">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="animate" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_vertical" symbol="clutter_box_layout_set_vertical">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterBoxLayout*"/>
					<parameter name="vertical" type="gboolean"/>
				</parameters>
			</method>
			<property name="easing-duration" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="easing-mode" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pack-start" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="spacing" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-animations" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vertical" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterCairoTexture" parent="ClutterTexture" type-name="ClutterCairoTexture" get-type="clutter_cairo_texture_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="clear" symbol="clutter_cairo_texture_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterCairoTexture*"/>
				</parameters>
			</method>
			<method name="create" symbol="clutter_cairo_texture_create">
				<return-type type="cairo_t*"/>
				<parameters>
					<parameter name="self" type="ClutterCairoTexture*"/>
				</parameters>
			</method>
			<method name="create_region" symbol="clutter_cairo_texture_create_region">
				<return-type type="cairo_t*"/>
				<parameters>
					<parameter name="self" type="ClutterCairoTexture*"/>
					<parameter name="x_offset" type="gint"/>
					<parameter name="y_offset" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<method name="get_surface_size" symbol="clutter_cairo_texture_get_surface_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterCairoTexture*"/>
					<parameter name="width" type="guint*"/>
					<parameter name="height" type="guint*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_cairo_texture_new">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="width" type="guint"/>
					<parameter name="height" type="guint"/>
				</parameters>
			</constructor>
			<method name="set_surface_size" symbol="clutter_cairo_texture_set_surface_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterCairoTexture*"/>
					<parameter name="width" type="guint"/>
					<parameter name="height" type="guint"/>
				</parameters>
			</method>
			<property name="surface-height" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="surface-width" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterChildMeta" parent="GObject" type-name="ClutterChildMeta" get-type="clutter_child_meta_get_type">
			<method name="get_actor" symbol="clutter_child_meta_get_actor">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="data" type="ClutterChildMeta*"/>
				</parameters>
			</method>
			<method name="get_container" symbol="clutter_child_meta_get_container">
				<return-type type="ClutterContainer*"/>
				<parameters>
					<parameter name="data" type="ClutterChildMeta*"/>
				</parameters>
			</method>
			<property name="actor" type="ClutterActor*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="container" type="ClutterContainer*" readable="1" writable="1" construct="0" construct-only="1"/>
			<field name="container" type="ClutterContainer*"/>
			<field name="actor" type="ClutterActor*"/>
		</object>
		<object name="ClutterClone" parent="ClutterActor" type-name="ClutterClone" get-type="clutter_clone_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="get_source" symbol="clutter_clone_get_source">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="clone" type="ClutterClone*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_clone_new">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="source" type="ClutterActor*"/>
				</parameters>
			</constructor>
			<method name="set_source" symbol="clutter_clone_set_source">
				<return-type type="void"/>
				<parameters>
					<parameter name="clone" type="ClutterClone*"/>
					<parameter name="source" type="ClutterActor*"/>
				</parameters>
			</method>
			<property name="source" type="ClutterActor*" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="ClutterDeviceManager" parent="GObject" type-name="ClutterDeviceManager" get-type="clutter_device_manager_get_type">
			<method name="get_core_device" symbol="clutter_device_manager_get_core_device">
				<return-type type="ClutterInputDevice*"/>
				<parameters>
					<parameter name="device_manager" type="ClutterDeviceManager*"/>
					<parameter name="device_type" type="ClutterInputDeviceType"/>
				</parameters>
			</method>
			<method name="get_default" symbol="clutter_device_manager_get_default">
				<return-type type="ClutterDeviceManager*"/>
			</method>
			<method name="get_device" symbol="clutter_device_manager_get_device">
				<return-type type="ClutterInputDevice*"/>
				<parameters>
					<parameter name="device_manager" type="ClutterDeviceManager*"/>
					<parameter name="device_id" type="gint"/>
				</parameters>
			</method>
			<method name="list_devices" symbol="clutter_device_manager_list_devices">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="device_manager" type="ClutterDeviceManager*"/>
				</parameters>
			</method>
			<method name="peek_devices" symbol="clutter_device_manager_peek_devices">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="device_manager" type="ClutterDeviceManager*"/>
				</parameters>
			</method>
			<property name="backend" type="ClutterBackend*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="device-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="ClutterDeviceManager*"/>
					<parameter name="p0" type="ClutterInputDevice*"/>
				</parameters>
			</signal>
			<signal name="device-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="ClutterDeviceManager*"/>
					<parameter name="p0" type="ClutterInputDevice*"/>
				</parameters>
			</signal>
			<vfunc name="add_device">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterDeviceManager*"/>
					<parameter name="device" type="ClutterInputDevice*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_core_device">
				<return-type type="ClutterInputDevice*"/>
				<parameters>
					<parameter name="manager" type="ClutterDeviceManager*"/>
					<parameter name="type" type="ClutterInputDeviceType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_device">
				<return-type type="ClutterInputDevice*"/>
				<parameters>
					<parameter name="manager" type="ClutterDeviceManager*"/>
					<parameter name="id" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_devices">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="manager" type="ClutterDeviceManager*"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_device">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterDeviceManager*"/>
					<parameter name="device" type="ClutterInputDevice*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="ClutterFixedLayout" parent="ClutterLayoutManager" type-name="ClutterFixedLayout" get-type="clutter_fixed_layout_get_type">
			<constructor name="new" symbol="clutter_fixed_layout_new">
				<return-type type="ClutterLayoutManager*"/>
			</constructor>
		</object>
		<object name="ClutterFlowLayout" parent="ClutterLayoutManager" type-name="ClutterFlowLayout" get-type="clutter_flow_layout_get_type">
			<method name="get_column_spacing" symbol="clutter_flow_layout_get_column_spacing">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="layout" type="ClutterFlowLayout*"/>
				</parameters>
			</method>
			<method name="get_column_width" symbol="clutter_flow_layout_get_column_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterFlowLayout*"/>
					<parameter name="min_width" type="gfloat*"/>
					<parameter name="max_width" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_homogeneous" symbol="clutter_flow_layout_get_homogeneous">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="ClutterFlowLayout*"/>
				</parameters>
			</method>
			<method name="get_orientation" symbol="clutter_flow_layout_get_orientation">
				<return-type type="ClutterFlowOrientation"/>
				<parameters>
					<parameter name="layout" type="ClutterFlowLayout*"/>
				</parameters>
			</method>
			<method name="get_row_height" symbol="clutter_flow_layout_get_row_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterFlowLayout*"/>
					<parameter name="min_height" type="gfloat*"/>
					<parameter name="max_height" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_row_spacing" symbol="clutter_flow_layout_get_row_spacing">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="layout" type="ClutterFlowLayout*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_flow_layout_new">
				<return-type type="ClutterLayoutManager*"/>
				<parameters>
					<parameter name="orientation" type="ClutterFlowOrientation"/>
				</parameters>
			</constructor>
			<method name="set_column_spacing" symbol="clutter_flow_layout_set_column_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterFlowLayout*"/>
					<parameter name="spacing" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_column_width" symbol="clutter_flow_layout_set_column_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterFlowLayout*"/>
					<parameter name="min_width" type="gfloat"/>
					<parameter name="max_width" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_homogeneous" symbol="clutter_flow_layout_set_homogeneous">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterFlowLayout*"/>
					<parameter name="homogeneous" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_orientation" symbol="clutter_flow_layout_set_orientation">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterFlowLayout*"/>
					<parameter name="orientation" type="ClutterFlowOrientation"/>
				</parameters>
			</method>
			<method name="set_row_height" symbol="clutter_flow_layout_set_row_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterFlowLayout*"/>
					<parameter name="min_height" type="gfloat"/>
					<parameter name="max_height" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_row_spacing" symbol="clutter_flow_layout_set_row_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="ClutterFlowLayout*"/>
					<parameter name="spacing" type="gfloat"/>
				</parameters>
			</method>
			<property name="column-spacing" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="homogeneous" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-column-width" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-row-height" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="min-column-width" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="min-row-height" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="orientation" type="ClutterFlowOrientation" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="row-spacing" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterGroup" parent="ClutterActor" type-name="ClutterGroup" get-type="clutter_group_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="ClutterContainer"/>
			</implements>
			<method name="get_n_children" symbol="clutter_group_get_n_children">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="ClutterGroup*"/>
				</parameters>
			</method>
			<method name="get_nth_child" symbol="clutter_group_get_nth_child">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="self" type="ClutterGroup*"/>
					<parameter name="index_" type="gint"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_group_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="remove_all" symbol="clutter_group_remove_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="ClutterGroup*"/>
				</parameters>
			</method>
		</object>
		<object name="ClutterInputDevice" parent="GObject" type-name="ClutterInputDevice" get-type="clutter_input_device_get_type">
			<method name="get_device_coords" symbol="clutter_input_device_get_device_coords">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="ClutterInputDevice*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
				</parameters>
			</method>
			<method name="get_device_id" symbol="clutter_input_device_get_device_id">
				<return-type type="gint"/>
				<parameters>
					<parameter name="device" type="ClutterInputDevice*"/>
				</parameters>
			</method>
			<method name="get_device_name" symbol="clutter_input_device_get_device_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="device" type="ClutterInputDevice*"/>
				</parameters>
			</method>
			<method name="get_device_type" symbol="clutter_input_device_get_device_type">
				<return-type type="ClutterInputDeviceType"/>
				<parameters>
					<parameter name="device" type="ClutterInputDevice*"/>
				</parameters>
			</method>
			<method name="get_pointer_actor" symbol="clutter_input_device_get_pointer_actor">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="device" type="ClutterInputDevice*"/>
				</parameters>
			</method>
			<method name="get_pointer_stage" symbol="clutter_input_device_get_pointer_stage">
				<return-type type="ClutterStage*"/>
				<parameters>
					<parameter name="device" type="ClutterInputDevice*"/>
				</parameters>
			</method>
			<method name="update_from_event" symbol="clutter_input_device_update_from_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="device" type="ClutterInputDevice*"/>
					<parameter name="event" type="ClutterEvent*"/>
					<parameter name="update_stage" type="gboolean"/>
				</parameters>
			</method>
			<property name="device-type" type="ClutterInputDeviceType" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="id" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="ClutterInterval" parent="GInitiallyUnowned" type-name="ClutterInterval" get-type="clutter_interval_get_type">
			<method name="clone" symbol="clutter_interval_clone">
				<return-type type="ClutterInterval*"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
				</parameters>
			</method>
			<method name="compute_value" symbol="clutter_interval_compute_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
					<parameter name="factor" type="gdouble"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_final_value" symbol="clutter_interval_get_final_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_initial_value" symbol="clutter_interval_get_initial_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_interval" symbol="clutter_interval_get_interval">
				<return-type type="void"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
				</parameters>
			</method>
			<method name="get_value_type" symbol="clutter_interval_get_value_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_interval_new">
				<return-type type="ClutterInterval*"/>
				<parameters>
					<parameter name="gtype" type="GType"/>
				</parameters>
			</constructor>
			<constructor name="new_with_values" symbol="clutter_interval_new_with_values">
				<return-type type="ClutterInterval*"/>
				<parameters>
					<parameter name="gtype" type="GType"/>
					<parameter name="initial" type="GValue*"/>
					<parameter name="final" type="GValue*"/>
				</parameters>
			</constructor>
			<method name="peek_final_value" symbol="clutter_interval_peek_final_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
				</parameters>
			</method>
			<method name="peek_initial_value" symbol="clutter_interval_peek_initial_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
				</parameters>
			</method>
			<method name="register_progress_func" symbol="clutter_interval_register_progress_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="value_type" type="GType"/>
					<parameter name="func" type="ClutterProgressFunc"/>
				</parameters>
			</method>
			<method name="set_final_value" symbol="clutter_interval_set_final_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_initial_value" symbol="clutter_interval_set_initial_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_interval" symbol="clutter_interval_set_interval">
				<return-type type="void"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
				</parameters>
			</method>
			<method name="validate" symbol="clutter_interval_validate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</method>
			<property name="value-type" type="GType" readable="1" writable="1" construct="0" construct-only="1"/>
			<vfunc name="compute_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
					<parameter name="factor" type="gdouble"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</vfunc>
			<vfunc name="validate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="interval" type="ClutterInterval*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="ClutterLayoutManager" parent="GInitiallyUnowned" type-name="ClutterLayoutManager" get-type="clutter_layout_manager_get_type">
			<method name="allocate" symbol="clutter_layout_manager_allocate">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="allocation" type="ClutterActorBox*"/>
					<parameter name="flags" type="ClutterAllocationFlags"/>
				</parameters>
			</method>
			<method name="begin_animation" symbol="clutter_layout_manager_begin_animation">
				<return-type type="ClutterAlpha*"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="duration" type="guint"/>
					<parameter name="mode" type="gulong"/>
				</parameters>
			</method>
			<method name="child_get" symbol="clutter_layout_manager_child_get">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="first_property" type="gchar*"/>
				</parameters>
			</method>
			<method name="child_get_property" symbol="clutter_layout_manager_child_get_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="child_set" symbol="clutter_layout_manager_child_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="first_property" type="gchar*"/>
				</parameters>
			</method>
			<method name="child_set_property" symbol="clutter_layout_manager_child_set_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="end_animation" symbol="clutter_layout_manager_end_animation">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
				</parameters>
			</method>
			<method name="find_child_property" symbol="clutter_layout_manager_find_child_property">
				<return-type type="GParamSpec*"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_animation_progress" symbol="clutter_layout_manager_get_animation_progress">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
				</parameters>
			</method>
			<method name="get_child_meta" symbol="clutter_layout_manager_get_child_meta">
				<return-type type="ClutterLayoutMeta*"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_preferred_height" symbol="clutter_layout_manager_get_preferred_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="for_width" type="gfloat"/>
					<parameter name="min_height_p" type="gfloat*"/>
					<parameter name="nat_height_p" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_preferred_width" symbol="clutter_layout_manager_get_preferred_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="for_height" type="gfloat"/>
					<parameter name="min_width_p" type="gfloat*"/>
					<parameter name="nat_width_p" type="gfloat*"/>
				</parameters>
			</method>
			<method name="layout_changed" symbol="clutter_layout_manager_layout_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
				</parameters>
			</method>
			<method name="list_child_properties" symbol="clutter_layout_manager_list_child_properties">
				<return-type type="GParamSpec**"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="n_pspecs" type="guint*"/>
				</parameters>
			</method>
			<method name="set_container" symbol="clutter_layout_manager_set_container">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
				</parameters>
			</method>
			<signal name="layout-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
				</parameters>
			</signal>
			<vfunc name="allocate">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="allocation" type="ClutterActorBox*"/>
					<parameter name="flags" type="ClutterAllocationFlags"/>
				</parameters>
			</vfunc>
			<vfunc name="begin_animation">
				<return-type type="ClutterAlpha*"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="duration" type="guint"/>
					<parameter name="mode" type="gulong"/>
				</parameters>
			</vfunc>
			<vfunc name="create_child_meta">
				<return-type type="ClutterLayoutMeta*"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<vfunc name="end_animation">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_animation_progress">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_child_meta_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_preferred_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="for_width" type="gfloat"/>
					<parameter name="minimum_height_p" type="gfloat*"/>
					<parameter name="natural_height_p" type="gfloat*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_preferred_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="for_height" type="gfloat"/>
					<parameter name="minimum_width_p" type="gfloat*"/>
					<parameter name="natural_width_p" type="gfloat*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_container">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="ClutterLayoutManager*"/>
					<parameter name="container" type="ClutterContainer*"/>
				</parameters>
			</vfunc>
			<field name="dummy" type="gpointer"/>
		</object>
		<object name="ClutterLayoutMeta" parent="ClutterChildMeta" type-name="ClutterLayoutMeta" get-type="clutter_layout_meta_get_type">
			<method name="get_manager" symbol="clutter_layout_meta_get_manager">
				<return-type type="ClutterLayoutManager*"/>
				<parameters>
					<parameter name="data" type="ClutterLayoutMeta*"/>
				</parameters>
			</method>
			<property name="manager" type="ClutterLayoutManager*" readable="1" writable="1" construct="0" construct-only="1"/>
			<field name="manager" type="ClutterLayoutManager*"/>
			<field name="dummy0" type="gint32"/>
			<field name="dummy1" type="gpointer"/>
		</object>
		<object name="ClutterListModel" parent="ClutterModel" type-name="ClutterListModel" get-type="clutter_list_model_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<constructor name="new" symbol="clutter_list_model_new">
				<return-type type="ClutterModel*"/>
				<parameters>
					<parameter name="n_columns" type="guint"/>
				</parameters>
			</constructor>
			<constructor name="newv" symbol="clutter_list_model_newv">
				<return-type type="ClutterModel*"/>
				<parameters>
					<parameter name="n_columns" type="guint"/>
					<parameter name="types" type="GType*"/>
					<parameter name="names" type="gchar*[]"/>
				</parameters>
			</constructor>
		</object>
		<object name="ClutterModel" parent="GObject" type-name="ClutterModel" get-type="clutter_model_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="append" symbol="clutter_model_append">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</method>
			<method name="appendv" symbol="clutter_model_appendv">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="n_columns" type="guint"/>
					<parameter name="columns" type="guint*"/>
					<parameter name="values" type="GValue*"/>
				</parameters>
			</method>
			<method name="filter_iter" symbol="clutter_model_filter_iter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</method>
			<method name="filter_row" symbol="clutter_model_filter_row">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="row" type="guint"/>
				</parameters>
			</method>
			<method name="foreach" symbol="clutter_model_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="func" type="ClutterModelForeachFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_column_name" symbol="clutter_model_get_column_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="column" type="guint"/>
				</parameters>
			</method>
			<method name="get_column_type" symbol="clutter_model_get_column_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="column" type="guint"/>
				</parameters>
			</method>
			<method name="get_filter_set" symbol="clutter_model_get_filter_set">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</method>
			<method name="get_first_iter" symbol="clutter_model_get_first_iter">
				<return-type type="ClutterModelIter*"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</method>
			<method name="get_iter_at_row" symbol="clutter_model_get_iter_at_row">
				<return-type type="ClutterModelIter*"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="row" type="guint"/>
				</parameters>
			</method>
			<method name="get_last_iter" symbol="clutter_model_get_last_iter">
				<return-type type="ClutterModelIter*"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</method>
			<method name="get_n_columns" symbol="clutter_model_get_n_columns">
				<return-type type="guint"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</method>
			<method name="get_n_rows" symbol="clutter_model_get_n_rows">
				<return-type type="guint"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</method>
			<method name="get_sorting_column" symbol="clutter_model_get_sorting_column">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</method>
			<method name="insert" symbol="clutter_model_insert">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="row" type="guint"/>
				</parameters>
			</method>
			<method name="insert_value" symbol="clutter_model_insert_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="row" type="guint"/>
					<parameter name="column" type="guint"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="insertv" symbol="clutter_model_insertv">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="row" type="guint"/>
					<parameter name="n_columns" type="guint"/>
					<parameter name="columns" type="guint*"/>
					<parameter name="values" type="GValue*"/>
				</parameters>
			</method>
			<method name="prepend" symbol="clutter_model_prepend">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</method>
			<method name="prependv" symbol="clutter_model_prependv">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="n_columns" type="guint"/>
					<parameter name="columns" type="guint*"/>
					<parameter name="values" type="GValue*"/>
				</parameters>
			</method>
			<method name="remove" symbol="clutter_model_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="row" type="guint"/>
				</parameters>
			</method>
			<method name="resort" symbol="clutter_model_resort">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</method>
			<method name="set_filter" symbol="clutter_model_set_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="func" type="ClutterModelFilterFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_names" symbol="clutter_model_set_names">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="n_columns" type="guint"/>
					<parameter name="names" type="gchar*[]"/>
				</parameters>
			</method>
			<method name="set_sort" symbol="clutter_model_set_sort">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="column" type="guint"/>
					<parameter name="func" type="ClutterModelSortFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_sorting_column" symbol="clutter_model_set_sorting_column">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="set_types" symbol="clutter_model_set_types">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="n_columns" type="guint"/>
					<parameter name="types" type="GType*"/>
				</parameters>
			</method>
			<property name="filter-set" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="filter-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</signal>
			<signal name="row-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</signal>
			<signal name="row-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</signal>
			<signal name="row-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</signal>
			<signal name="sort-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</signal>
			<vfunc name="get_column_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="column" type="guint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_column_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="column" type="guint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_iter_at_row">
				<return-type type="ClutterModelIter*"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="row" type="guint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_columns">
				<return-type type="guint"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_rows">
				<return-type type="guint"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
				</parameters>
			</vfunc>
			<vfunc name="insert_row">
				<return-type type="ClutterModelIter*"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="index_" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_row">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="row" type="guint"/>
				</parameters>
			</vfunc>
			<vfunc name="resort">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="ClutterModel*"/>
					<parameter name="func" type="ClutterModelSortFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</vfunc>
		</object>
		<object name="ClutterModelIter" parent="GObject" type-name="ClutterModelIter" get-type="clutter_model_iter_get_type">
			<method name="copy" symbol="clutter_model_iter_copy">
				<return-type type="ClutterModelIter*"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</method>
			<method name="get" symbol="clutter_model_iter_get">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</method>
			<method name="get_model" symbol="clutter_model_iter_get_model">
				<return-type type="ClutterModel*"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</method>
			<method name="get_row" symbol="clutter_model_iter_get_row">
				<return-type type="guint"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</method>
			<method name="get_valist" symbol="clutter_model_iter_get_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
					<parameter name="args" type="va_list"/>
				</parameters>
			</method>
			<method name="get_value" symbol="clutter_model_iter_get_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
					<parameter name="column" type="guint"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="is_first" symbol="clutter_model_iter_is_first">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</method>
			<method name="is_last" symbol="clutter_model_iter_is_last">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</method>
			<method name="next" symbol="clutter_model_iter_next">
				<return-type type="ClutterModelIter*"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</method>
			<method name="prev" symbol="clutter_model_iter_prev">
				<return-type type="ClutterModelIter*"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</method>
			<method name="set" symbol="clutter_model_iter_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</method>
			<method name="set_valist" symbol="clutter_model_iter_set_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
					<parameter name="args" type="va_list"/>
				</parameters>
			</method>
			<method name="set_value" symbol="clutter_model_iter_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
					<parameter name="column" type="guint"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<property name="model" type="ClutterModel*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="row" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="copy">
				<return-type type="ClutterModelIter*"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_model">
				<return-type type="ClutterModel*"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_row">
				<return-type type="guint"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
					<parameter name="column" type="guint"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_first">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_last">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</vfunc>
			<vfunc name="next">
				<return-type type="ClutterModelIter*"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</vfunc>
			<vfunc name="prev">
				<return-type type="ClutterModelIter*"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="ClutterModelIter*"/>
					<parameter name="column" type="guint"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="ClutterPath" parent="GInitiallyUnowned" type-name="ClutterPath" get-type="clutter_path_get_type">
			<method name="add_cairo_path" symbol="clutter_path_add_cairo_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="cpath" type="cairo_path_t*"/>
				</parameters>
			</method>
			<method name="add_close" symbol="clutter_path_add_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
				</parameters>
			</method>
			<method name="add_curve_to" symbol="clutter_path_add_curve_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="x_1" type="gint"/>
					<parameter name="y_1" type="gint"/>
					<parameter name="x_2" type="gint"/>
					<parameter name="y_2" type="gint"/>
					<parameter name="x_3" type="gint"/>
					<parameter name="y_3" type="gint"/>
				</parameters>
			</method>
			<method name="add_line_to" symbol="clutter_path_add_line_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="add_move_to" symbol="clutter_path_add_move_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="add_node" symbol="clutter_path_add_node">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="node" type="ClutterPathNode*"/>
				</parameters>
			</method>
			<method name="add_rel_curve_to" symbol="clutter_path_add_rel_curve_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="x_1" type="gint"/>
					<parameter name="y_1" type="gint"/>
					<parameter name="x_2" type="gint"/>
					<parameter name="y_2" type="gint"/>
					<parameter name="x_3" type="gint"/>
					<parameter name="y_3" type="gint"/>
				</parameters>
			</method>
			<method name="add_rel_line_to" symbol="clutter_path_add_rel_line_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="add_rel_move_to" symbol="clutter_path_add_rel_move_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="add_string" symbol="clutter_path_add_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="str" type="gchar*"/>
				</parameters>
			</method>
			<method name="clear" symbol="clutter_path_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
				</parameters>
			</method>
			<method name="foreach" symbol="clutter_path_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="callback" type="ClutterPathCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_description" symbol="clutter_path_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="clutter_path_get_length">
				<return-type type="guint"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
				</parameters>
			</method>
			<method name="get_n_nodes" symbol="clutter_path_get_n_nodes">
				<return-type type="guint"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
				</parameters>
			</method>
			<method name="get_node" symbol="clutter_path_get_node">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="index_" type="guint"/>
					<parameter name="node" type="ClutterPathNode*"/>
				</parameters>
			</method>
			<method name="get_nodes" symbol="clutter_path_get_nodes">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
				</parameters>
			</method>
			<method name="get_position" symbol="clutter_path_get_position">
				<return-type type="guint"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="progress" type="gdouble"/>
					<parameter name="position" type="ClutterKnot*"/>
				</parameters>
			</method>
			<method name="insert_node" symbol="clutter_path_insert_node">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="index_" type="gint"/>
					<parameter name="node" type="ClutterPathNode*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_path_new">
				<return-type type="ClutterPath*"/>
			</constructor>
			<constructor name="new_with_description" symbol="clutter_path_new_with_description">
				<return-type type="ClutterPath*"/>
				<parameters>
					<parameter name="desc" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="remove_node" symbol="clutter_path_remove_node">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="index_" type="guint"/>
				</parameters>
			</method>
			<method name="replace_node" symbol="clutter_path_replace_node">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="index_" type="guint"/>
					<parameter name="node" type="ClutterPathNode*"/>
				</parameters>
			</method>
			<method name="set_description" symbol="clutter_path_set_description">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="str" type="gchar*"/>
				</parameters>
			</method>
			<method name="to_cairo_path" symbol="clutter_path_to_cairo_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="ClutterPath*"/>
					<parameter name="cr" type="cairo_t*"/>
				</parameters>
			</method>
			<property name="description" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="length" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterRectangle" parent="ClutterActor" type-name="ClutterRectangle" get-type="clutter_rectangle_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="get_border_color" symbol="clutter_rectangle_get_border_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="rectangle" type="ClutterRectangle*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="get_border_width" symbol="clutter_rectangle_get_border_width">
				<return-type type="guint"/>
				<parameters>
					<parameter name="rectangle" type="ClutterRectangle*"/>
				</parameters>
			</method>
			<method name="get_color" symbol="clutter_rectangle_get_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="rectangle" type="ClutterRectangle*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_rectangle_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<constructor name="new_with_color" symbol="clutter_rectangle_new_with_color">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</constructor>
			<method name="set_border_color" symbol="clutter_rectangle_set_border_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="rectangle" type="ClutterRectangle*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="set_border_width" symbol="clutter_rectangle_set_border_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="rectangle" type="ClutterRectangle*"/>
					<parameter name="width" type="guint"/>
				</parameters>
			</method>
			<method name="set_color" symbol="clutter_rectangle_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="rectangle" type="ClutterRectangle*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<property name="border-color" type="ClutterColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="border-width" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="color" type="ClutterColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="has-border" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterScore" parent="GObject" type-name="ClutterScore" get-type="clutter_score_get_type">
			<method name="append" symbol="clutter_score_append">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
					<parameter name="parent" type="ClutterTimeline*"/>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="append_at_marker" symbol="clutter_score_append_at_marker">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
					<parameter name="parent" type="ClutterTimeline*"/>
					<parameter name="marker_name" type="gchar*"/>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="get_loop" symbol="clutter_score_get_loop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
				</parameters>
			</method>
			<method name="get_timeline" symbol="clutter_score_get_timeline">
				<return-type type="ClutterTimeline*"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
					<parameter name="id" type="gulong"/>
				</parameters>
			</method>
			<method name="is_playing" symbol="clutter_score_is_playing">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
				</parameters>
			</method>
			<method name="list_timelines" symbol="clutter_score_list_timelines">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_score_new">
				<return-type type="ClutterScore*"/>
			</constructor>
			<method name="pause" symbol="clutter_score_pause">
				<return-type type="void"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
				</parameters>
			</method>
			<method name="remove" symbol="clutter_score_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
					<parameter name="id" type="gulong"/>
				</parameters>
			</method>
			<method name="remove_all" symbol="clutter_score_remove_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
				</parameters>
			</method>
			<method name="rewind" symbol="clutter_score_rewind">
				<return-type type="void"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
				</parameters>
			</method>
			<method name="set_loop" symbol="clutter_score_set_loop">
				<return-type type="void"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
					<parameter name="loop" type="gboolean"/>
				</parameters>
			</method>
			<method name="start" symbol="clutter_score_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
				</parameters>
			</method>
			<method name="stop" symbol="clutter_score_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
				</parameters>
			</method>
			<property name="loop" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="completed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
				</parameters>
			</signal>
			<signal name="paused" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
				</parameters>
			</signal>
			<signal name="started" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
				</parameters>
			</signal>
			<signal name="timeline-completed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</signal>
			<signal name="timeline-started" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="score" type="ClutterScore*"/>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</signal>
		</object>
		<object name="ClutterScript" parent="GObject" type-name="ClutterScript" get-type="clutter_script_get_type">
			<method name="add_search_paths" symbol="clutter_script_add_search_paths">
				<return-type type="void"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="paths" type="gchar*[]"/>
					<parameter name="n_paths" type="gsize"/>
				</parameters>
			</method>
			<method name="connect_signals" symbol="clutter_script_connect_signals">
				<return-type type="void"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="connect_signals_full" symbol="clutter_script_connect_signals_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="func" type="ClutterScriptConnectFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="ensure_objects" symbol="clutter_script_ensure_objects">
				<return-type type="void"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="clutter_script_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_object" symbol="clutter_script_get_object">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_objects" symbol="clutter_script_get_objects">
				<return-type type="gint"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="first_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_type_from_name" symbol="clutter_script_get_type_from_name">
				<return-type type="GType"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="type_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="list_objects" symbol="clutter_script_list_objects">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
				</parameters>
			</method>
			<method name="load_from_data" symbol="clutter_script_load_from_data">
				<return-type type="guint"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="length" type="gssize"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="load_from_file" symbol="clutter_script_load_from_file">
				<return-type type="guint"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="lookup_filename" symbol="clutter_script_lookup_filename">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_script_new">
				<return-type type="ClutterScript*"/>
			</constructor>
			<method name="unmerge_objects" symbol="clutter_script_unmerge_objects">
				<return-type type="void"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="merge_id" type="guint"/>
				</parameters>
			</method>
			<property name="filename" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="filename-set" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<vfunc name="get_type_from_name">
				<return-type type="GType"/>
				<parameters>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="type_name" type="gchar*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="ClutterShader" parent="GObject" type-name="ClutterShader" get-type="clutter_shader_get_type">
			<method name="compile" symbol="clutter_shader_compile">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="clutter_shader_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_cogl_fragment_shader" symbol="clutter_shader_get_cogl_fragment_shader">
				<return-type type="CoglHandle"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
				</parameters>
			</method>
			<method name="get_cogl_program" symbol="clutter_shader_get_cogl_program">
				<return-type type="CoglHandle"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
				</parameters>
			</method>
			<method name="get_cogl_vertex_shader" symbol="clutter_shader_get_cogl_vertex_shader">
				<return-type type="CoglHandle"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
				</parameters>
			</method>
			<method name="get_fragment_source" symbol="clutter_shader_get_fragment_source">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
				</parameters>
			</method>
			<method name="get_is_enabled" symbol="clutter_shader_get_is_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
				</parameters>
			</method>
			<method name="get_vertex_source" symbol="clutter_shader_get_vertex_source">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
				</parameters>
			</method>
			<method name="is_compiled" symbol="clutter_shader_is_compiled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_shader_new">
				<return-type type="ClutterShader*"/>
			</constructor>
			<method name="release" symbol="clutter_shader_release">
				<return-type type="void"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
				</parameters>
			</method>
			<method name="set_fragment_source" symbol="clutter_shader_set_fragment_source">
				<return-type type="void"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="length" type="gssize"/>
				</parameters>
			</method>
			<method name="set_is_enabled" symbol="clutter_shader_set_is_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
					<parameter name="enabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_uniform" symbol="clutter_shader_set_uniform">
				<return-type type="void"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_vertex_source" symbol="clutter_shader_set_vertex_source">
				<return-type type="void"/>
				<parameters>
					<parameter name="shader" type="ClutterShader*"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="length" type="gssize"/>
				</parameters>
			</method>
			<property name="compiled" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="enabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fragment-source" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vertex-source" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="ClutterStage" parent="ClutterGroup" type-name="ClutterStage" get-type="clutter_stage_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="ClutterContainer"/>
			</implements>
			<method name="ensure_current" symbol="clutter_stage_ensure_current">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="ensure_redraw" symbol="clutter_stage_ensure_redraw">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="ensure_viewport" symbol="clutter_stage_ensure_viewport">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="event" symbol="clutter_stage_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</method>
			<method name="get_actor_at_pos" symbol="clutter_stage_get_actor_at_pos">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="pick_mode" type="ClutterPickMode"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="get_color" symbol="clutter_stage_get_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="get_default" symbol="clutter_stage_get_default">
				<return-type type="ClutterActor*"/>
			</method>
			<method name="get_fog" symbol="clutter_stage_get_fog">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="fog" type="ClutterFog*"/>
				</parameters>
			</method>
			<method name="get_fullscreen" symbol="clutter_stage_get_fullscreen">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="get_key_focus" symbol="clutter_stage_get_key_focus">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="get_minimum_size" symbol="clutter_stage_get_minimum_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="width" type="guint*"/>
					<parameter name="height" type="guint*"/>
				</parameters>
			</method>
			<method name="get_perspective" symbol="clutter_stage_get_perspective">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="perspective" type="ClutterPerspective*"/>
				</parameters>
			</method>
			<method name="get_throttle_motion_events" symbol="clutter_stage_get_throttle_motion_events">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="clutter_stage_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="get_use_alpha" symbol="clutter_stage_get_use_alpha">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="get_use_fog" symbol="clutter_stage_get_use_fog">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="get_user_resizable" symbol="clutter_stage_get_user_resizable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="hide_cursor" symbol="clutter_stage_hide_cursor">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="is_default" symbol="clutter_stage_is_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_stage_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="queue_redraw" symbol="clutter_stage_queue_redraw">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<method name="read_pixels" symbol="clutter_stage_read_pixels">
				<return-type type="guchar*"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<method name="set_color" symbol="clutter_stage_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="set_fog" symbol="clutter_stage_set_fog">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="fog" type="ClutterFog*"/>
				</parameters>
			</method>
			<method name="set_fullscreen" symbol="clutter_stage_set_fullscreen">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="fullscreen" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_key_focus" symbol="clutter_stage_set_key_focus">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="set_minimum_size" symbol="clutter_stage_set_minimum_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="width" type="guint"/>
					<parameter name="height" type="guint"/>
				</parameters>
			</method>
			<method name="set_perspective" symbol="clutter_stage_set_perspective">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="perspective" type="ClutterPerspective*"/>
				</parameters>
			</method>
			<method name="set_throttle_motion_events" symbol="clutter_stage_set_throttle_motion_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="throttle" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_title" symbol="clutter_stage_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_use_alpha" symbol="clutter_stage_set_use_alpha">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="use_alpha" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_use_fog" symbol="clutter_stage_set_use_fog">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="fog" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_user_resizable" symbol="clutter_stage_set_user_resizable">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="resizable" type="gboolean"/>
				</parameters>
			</method>
			<method name="show_cursor" symbol="clutter_stage_show_cursor">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</method>
			<property name="color" type="ClutterColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="cursor-visible" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fog" type="ClutterFog*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="fullscreen-set" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="key-focus" type="ClutterActor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="offscreen" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="perspective" type="ClutterPerspective*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-alpha" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-fog" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="user-resizable" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="activate" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</signal>
			<signal name="deactivate" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</signal>
			<signal name="delete-event" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
					<parameter name="event" type="ClutterEvent*"/>
				</parameters>
			</signal>
			<signal name="fullscreen" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</signal>
			<signal name="unfullscreen" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</signal>
		</object>
		<object name="ClutterStageManager" parent="GObject" type-name="ClutterStageManager" get-type="clutter_stage_manager_get_type">
			<method name="get_default" symbol="clutter_stage_manager_get_default">
				<return-type type="ClutterStageManager*"/>
			</method>
			<method name="get_default_stage" symbol="clutter_stage_manager_get_default_stage">
				<return-type type="ClutterStage*"/>
				<parameters>
					<parameter name="stage_manager" type="ClutterStageManager*"/>
				</parameters>
			</method>
			<method name="list_stages" symbol="clutter_stage_manager_list_stages">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="stage_manager" type="ClutterStageManager*"/>
				</parameters>
			</method>
			<method name="peek_stages" symbol="clutter_stage_manager_peek_stages">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="stage_manager" type="ClutterStageManager*"/>
				</parameters>
			</method>
			<property name="default-stage" type="ClutterStage*" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="stage-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage_manager" type="ClutterStageManager*"/>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</signal>
			<signal name="stage-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage_manager" type="ClutterStageManager*"/>
					<parameter name="stage" type="ClutterStage*"/>
				</parameters>
			</signal>
		</object>
		<object name="ClutterText" parent="ClutterActor" type-name="ClutterText" get-type="clutter_text_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="activate" symbol="clutter_text_activate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="delete_chars" symbol="clutter_text_delete_chars">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="n_chars" type="guint"/>
				</parameters>
			</method>
			<method name="delete_selection" symbol="clutter_text_delete_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="delete_text" symbol="clutter_text_delete_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="start_pos" type="gssize"/>
					<parameter name="end_pos" type="gssize"/>
				</parameters>
			</method>
			<method name="get_activatable" symbol="clutter_text_get_activatable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_attributes" symbol="clutter_text_get_attributes">
				<return-type type="PangoAttrList*"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_chars" symbol="clutter_text_get_chars">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="start_pos" type="gssize"/>
					<parameter name="end_pos" type="gssize"/>
				</parameters>
			</method>
			<method name="get_color" symbol="clutter_text_get_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="get_cursor_color" symbol="clutter_text_get_cursor_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="get_cursor_position" symbol="clutter_text_get_cursor_position">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_cursor_size" symbol="clutter_text_get_cursor_size">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_cursor_visible" symbol="clutter_text_get_cursor_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_editable" symbol="clutter_text_get_editable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_ellipsize" symbol="clutter_text_get_ellipsize">
				<return-type type="PangoEllipsizeMode"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_font_description" symbol="clutter_text_get_font_description">
				<return-type type="PangoFontDescription*"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_font_name" symbol="clutter_text_get_font_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_justify" symbol="clutter_text_get_justify">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_layout" symbol="clutter_text_get_layout">
				<return-type type="PangoLayout*"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_line_alignment" symbol="clutter_text_get_line_alignment">
				<return-type type="PangoAlignment"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_line_wrap" symbol="clutter_text_get_line_wrap">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_line_wrap_mode" symbol="clutter_text_get_line_wrap_mode">
				<return-type type="PangoWrapMode"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_max_length" symbol="clutter_text_get_max_length">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_password_char" symbol="clutter_text_get_password_char">
				<return-type type="gunichar"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_selectable" symbol="clutter_text_get_selectable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_selection" symbol="clutter_text_get_selection">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_selection_bound" symbol="clutter_text_get_selection_bound">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_selection_color" symbol="clutter_text_get_selection_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="get_single_line_mode" symbol="clutter_text_get_single_line_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="clutter_text_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="get_use_markup" symbol="clutter_text_get_use_markup">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</method>
			<method name="insert_text" symbol="clutter_text_insert_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="position" type="gssize"/>
				</parameters>
			</method>
			<method name="insert_unichar" symbol="clutter_text_insert_unichar">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="wc" type="gunichar"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_text_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<constructor name="new_full" symbol="clutter_text_new_full">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="font_name" type="gchar*"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_text" symbol="clutter_text_new_with_text">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="font_name" type="gchar*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="position_to_coords" symbol="clutter_text_position_to_coords">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="position" type="gint"/>
					<parameter name="x" type="gfloat*"/>
					<parameter name="y" type="gfloat*"/>
					<parameter name="line_height" type="gfloat*"/>
				</parameters>
			</method>
			<method name="set_activatable" symbol="clutter_text_set_activatable">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="activatable" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_attributes" symbol="clutter_text_set_attributes">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="attrs" type="PangoAttrList*"/>
				</parameters>
			</method>
			<method name="set_color" symbol="clutter_text_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="set_cursor_color" symbol="clutter_text_set_cursor_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="set_cursor_position" symbol="clutter_text_set_cursor_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</method>
			<method name="set_cursor_size" symbol="clutter_text_set_cursor_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="size" type="gint"/>
				</parameters>
			</method>
			<method name="set_cursor_visible" symbol="clutter_text_set_cursor_visible">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="cursor_visible" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_editable" symbol="clutter_text_set_editable">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="editable" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_ellipsize" symbol="clutter_text_set_ellipsize">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="mode" type="PangoEllipsizeMode"/>
				</parameters>
			</method>
			<method name="set_font_description" symbol="clutter_text_set_font_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="font_desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="set_font_name" symbol="clutter_text_set_font_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="font_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_justify" symbol="clutter_text_set_justify">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="justify" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_line_alignment" symbol="clutter_text_set_line_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="alignment" type="PangoAlignment"/>
				</parameters>
			</method>
			<method name="set_line_wrap" symbol="clutter_text_set_line_wrap">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="line_wrap" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_line_wrap_mode" symbol="clutter_text_set_line_wrap_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="wrap_mode" type="PangoWrapMode"/>
				</parameters>
			</method>
			<method name="set_markup" symbol="clutter_text_set_markup">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="markup" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_max_length" symbol="clutter_text_set_max_length">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="max" type="gint"/>
				</parameters>
			</method>
			<method name="set_password_char" symbol="clutter_text_set_password_char">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="wc" type="gunichar"/>
				</parameters>
			</method>
			<method name="set_preedit_string" symbol="clutter_text_set_preedit_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="preedit_str" type="gchar*"/>
					<parameter name="preedit_attrs" type="PangoAttrList*"/>
					<parameter name="cursor_pos" type="guint"/>
				</parameters>
			</method>
			<method name="set_selectable" symbol="clutter_text_set_selectable">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="selectable" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_selection" symbol="clutter_text_set_selection">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="start_pos" type="gssize"/>
					<parameter name="end_pos" type="gssize"/>
				</parameters>
			</method>
			<method name="set_selection_bound" symbol="clutter_text_set_selection_bound">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="selection_bound" type="gint"/>
				</parameters>
			</method>
			<method name="set_selection_color" symbol="clutter_text_set_selection_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="color" type="ClutterColor*"/>
				</parameters>
			</method>
			<method name="set_single_line_mode" symbol="clutter_text_set_single_line_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="single_line" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_text" symbol="clutter_text_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_use_markup" symbol="clutter_text_set_use_markup">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="setting" type="gboolean"/>
				</parameters>
			</method>
			<property name="activatable" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="attributes" type="PangoAttrList*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="color" type="ClutterColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="cursor-color" type="ClutterColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="cursor-color-set" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="cursor-size" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="cursor-visible" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="editable" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ellipsize" type="PangoEllipsizeMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="font-description" type="PangoFontDescription*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="font-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="justify" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-alignment" type="PangoAlignment" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-wrap" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-wrap-mode" type="PangoWrapMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-length" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="password-char" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="position" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="selectable" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="selection-bound" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="selection-color" type="ClutterColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="selection-color-set" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="single-line-mode" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-markup" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="activate" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</signal>
			<signal name="cursor-event" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
					<parameter name="geometry" type="ClutterGeometry*"/>
				</parameters>
			</signal>
			<signal name="delete-text" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="ClutterText*"/>
					<parameter name="p0" type="gint"/>
					<parameter name="p1" type="gint"/>
				</parameters>
			</signal>
			<signal name="insert-text" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="ClutterText*"/>
					<parameter name="p0" type="char*"/>
					<parameter name="p1" type="gint"/>
					<parameter name="p2" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="text-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="ClutterText*"/>
				</parameters>
			</signal>
		</object>
		<object name="ClutterTexture" parent="ClutterActor" type-name="ClutterTexture" get-type="clutter_texture_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="error_quark" symbol="clutter_texture_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_base_size" symbol="clutter_texture_get_base_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
				</parameters>
			</method>
			<method name="get_cogl_material" symbol="clutter_texture_get_cogl_material">
				<return-type type="CoglHandle"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
				</parameters>
			</method>
			<method name="get_cogl_texture" symbol="clutter_texture_get_cogl_texture">
				<return-type type="CoglHandle"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
				</parameters>
			</method>
			<method name="get_filter_quality" symbol="clutter_texture_get_filter_quality">
				<return-type type="ClutterTextureQuality"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
				</parameters>
			</method>
			<method name="get_keep_aspect_ratio" symbol="clutter_texture_get_keep_aspect_ratio">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
				</parameters>
			</method>
			<method name="get_load_async" symbol="clutter_texture_get_load_async">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
				</parameters>
			</method>
			<method name="get_load_data_async" symbol="clutter_texture_get_load_data_async">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
				</parameters>
			</method>
			<method name="get_max_tile_waste" symbol="clutter_texture_get_max_tile_waste">
				<return-type type="gint"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
				</parameters>
			</method>
			<method name="get_pixel_format" symbol="clutter_texture_get_pixel_format">
				<return-type type="CoglPixelFormat"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
				</parameters>
			</method>
			<method name="get_repeat" symbol="clutter_texture_get_repeat">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="repeat_x" type="gboolean*"/>
					<parameter name="repeat_y" type="gboolean*"/>
				</parameters>
			</method>
			<method name="get_sync_size" symbol="clutter_texture_get_sync_size">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_texture_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<constructor name="new_from_actor" symbol="clutter_texture_new_from_actor">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_file" symbol="clutter_texture_new_from_file">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="set_area_from_rgb_data" symbol="clutter_texture_set_area_from_rgb_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="data" type="guchar*"/>
					<parameter name="has_alpha" type="gboolean"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="rowstride" type="gint"/>
					<parameter name="bpp" type="gint"/>
					<parameter name="flags" type="ClutterTextureFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_cogl_material" symbol="clutter_texture_set_cogl_material">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="cogl_material" type="CoglHandle"/>
				</parameters>
			</method>
			<method name="set_cogl_texture" symbol="clutter_texture_set_cogl_texture">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="cogl_tex" type="CoglHandle"/>
				</parameters>
			</method>
			<method name="set_filter_quality" symbol="clutter_texture_set_filter_quality">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="filter_quality" type="ClutterTextureQuality"/>
				</parameters>
			</method>
			<method name="set_from_file" symbol="clutter_texture_set_from_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_from_rgb_data" symbol="clutter_texture_set_from_rgb_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="data" type="guchar*"/>
					<parameter name="has_alpha" type="gboolean"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="rowstride" type="gint"/>
					<parameter name="bpp" type="gint"/>
					<parameter name="flags" type="ClutterTextureFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_from_yuv_data" symbol="clutter_texture_set_from_yuv_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="data" type="guchar*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="flags" type="ClutterTextureFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_keep_aspect_ratio" symbol="clutter_texture_set_keep_aspect_ratio">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="keep_aspect" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_load_async" symbol="clutter_texture_set_load_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="load_async" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_load_data_async" symbol="clutter_texture_set_load_data_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="load_async" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_repeat" symbol="clutter_texture_set_repeat">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="repeat_x" type="gboolean"/>
					<parameter name="repeat_y" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_sync_size" symbol="clutter_texture_set_sync_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="sync_size" type="gboolean"/>
				</parameters>
			</method>
			<property name="cogl-material" type="CoglHandle*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="cogl-texture" type="CoglHandle*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="disable-slicing" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="filename" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="filter-quality" type="ClutterTextureQuality" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="keep-aspect-ratio" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="load-async" type="gboolean" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="load-data-async" type="gboolean" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="pixel-format" type="CoglPixelFormat" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="repeat-x" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="repeat-y" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sync-size" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="tile-waste" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="load-finished" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="error" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="pixbuf-change" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
				</parameters>
			</signal>
			<signal name="size-change" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="texture" type="ClutterTexture*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</signal>
		</object>
		<object name="ClutterTimeline" parent="GObject" type-name="ClutterTimeline" get-type="clutter_timeline_get_type">
			<method name="add_marker_at_time" symbol="clutter_timeline_add_marker_at_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="marker_name" type="gchar*"/>
					<parameter name="msecs" type="guint"/>
				</parameters>
			</method>
			<method name="advance" symbol="clutter_timeline_advance">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="msecs" type="guint"/>
				</parameters>
			</method>
			<method name="advance_to_marker" symbol="clutter_timeline_advance_to_marker">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="marker_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="clone" symbol="clutter_timeline_clone">
				<return-type type="ClutterTimeline*"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="do_tick" symbol="clutter_timeline_do_tick">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="tick_time" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_delay" symbol="clutter_timeline_get_delay">
				<return-type type="guint"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="get_delta" symbol="clutter_timeline_get_delta">
				<return-type type="guint"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="get_direction" symbol="clutter_timeline_get_direction">
				<return-type type="ClutterTimelineDirection"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="get_duration" symbol="clutter_timeline_get_duration">
				<return-type type="guint"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="get_elapsed_time" symbol="clutter_timeline_get_elapsed_time">
				<return-type type="guint"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="get_loop" symbol="clutter_timeline_get_loop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="get_progress" symbol="clutter_timeline_get_progress">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="has_marker" symbol="clutter_timeline_has_marker">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="marker_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="is_playing" symbol="clutter_timeline_is_playing">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="list_markers" symbol="clutter_timeline_list_markers">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="msecs" type="gint"/>
					<parameter name="n_markers" type="gsize*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="clutter_timeline_new">
				<return-type type="ClutterTimeline*"/>
				<parameters>
					<parameter name="msecs" type="guint"/>
				</parameters>
			</constructor>
			<method name="pause" symbol="clutter_timeline_pause">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="remove_marker" symbol="clutter_timeline_remove_marker">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="marker_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="rewind" symbol="clutter_timeline_rewind">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="set_delay" symbol="clutter_timeline_set_delay">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="msecs" type="guint"/>
				</parameters>
			</method>
			<method name="set_direction" symbol="clutter_timeline_set_direction">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="direction" type="ClutterTimelineDirection"/>
				</parameters>
			</method>
			<method name="set_duration" symbol="clutter_timeline_set_duration">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="msecs" type="guint"/>
				</parameters>
			</method>
			<method name="set_loop" symbol="clutter_timeline_set_loop">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="loop" type="gboolean"/>
				</parameters>
			</method>
			<method name="skip" symbol="clutter_timeline_skip">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="msecs" type="guint"/>
				</parameters>
			</method>
			<method name="start" symbol="clutter_timeline_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<method name="stop" symbol="clutter_timeline_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</method>
			<property name="delay" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="direction" type="ClutterTimelineDirection" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="duration" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="loop" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="completed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</signal>
			<signal name="marker-reached" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="marker_name" type="char*"/>
					<parameter name="frame_num" type="gint"/>
				</parameters>
			</signal>
			<signal name="new-frame" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
					<parameter name="frame_num" type="gint"/>
				</parameters>
			</signal>
			<signal name="paused" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</signal>
			<signal name="started" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="timeline" type="ClutterTimeline*"/>
				</parameters>
			</signal>
		</object>
		<interface name="ClutterAnimatable" type-name="ClutterAnimatable" get-type="clutter_animatable_get_type">
			<method name="animate_property" symbol="clutter_animatable_animate_property">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="animatable" type="ClutterAnimatable*"/>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="initial_value" type="GValue*"/>
					<parameter name="final_value" type="GValue*"/>
					<parameter name="progress" type="gdouble"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<vfunc name="animate_property">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="animatable" type="ClutterAnimatable*"/>
					<parameter name="animation" type="ClutterAnimation*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="initial_value" type="GValue*"/>
					<parameter name="final_value" type="GValue*"/>
					<parameter name="progress" type="gdouble"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="ClutterContainer" type-name="ClutterContainer" get-type="clutter_container_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="add" symbol="clutter_container_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="first_actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="add_actor" symbol="clutter_container_add_actor">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="add_valist" symbol="clutter_container_add_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="first_actor" type="ClutterActor*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</method>
			<method name="child_get" symbol="clutter_container_child_get">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="first_prop" type="gchar*"/>
				</parameters>
			</method>
			<method name="child_get_property" symbol="clutter_container_child_get_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="property" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="child_set" symbol="clutter_container_child_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="first_prop" type="gchar*"/>
				</parameters>
			</method>
			<method name="child_set_property" symbol="clutter_container_child_set_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="child" type="ClutterActor*"/>
					<parameter name="property" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="class_find_child_property" symbol="clutter_container_class_find_child_property">
				<return-type type="GParamSpec*"/>
				<parameters>
					<parameter name="klass" type="GObjectClass*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="class_list_child_properties" symbol="clutter_container_class_list_child_properties">
				<return-type type="GParamSpec**"/>
				<parameters>
					<parameter name="klass" type="GObjectClass*"/>
					<parameter name="n_properties" type="guint*"/>
				</parameters>
			</method>
			<method name="create_child_meta" symbol="clutter_container_create_child_meta">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="destroy_child_meta" symbol="clutter_container_destroy_child_meta">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="find_child_by_name" symbol="clutter_container_find_child_by_name">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="child_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="foreach" symbol="clutter_container_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="callback" type="ClutterCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="foreach_with_internals" symbol="clutter_container_foreach_with_internals">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="callback" type="ClutterCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_child_meta" symbol="clutter_container_get_child_meta">
				<return-type type="ClutterChildMeta*"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="get_children" symbol="clutter_container_get_children">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
				</parameters>
			</method>
			<method name="lower_child" symbol="clutter_container_lower_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="sibling" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="raise_child" symbol="clutter_container_raise_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="sibling" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="remove" symbol="clutter_container_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="first_actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="remove_actor" symbol="clutter_container_remove_actor">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</method>
			<method name="remove_valist" symbol="clutter_container_remove_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="first_actor" type="ClutterActor*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</method>
			<method name="sort_depth_order" symbol="clutter_container_sort_depth_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
				</parameters>
			</method>
			<signal name="actor-added" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="actor-removed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</signal>
			<signal name="child-notify" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</signal>
			<vfunc name="add">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<vfunc name="create_child_meta">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<vfunc name="destroy_child_meta">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<vfunc name="foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="callback" type="ClutterCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="foreach_with_internals">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="callback" type="ClutterCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="get_child_meta">
				<return-type type="ClutterChildMeta*"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<vfunc name="lower">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="sibling" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<vfunc name="raise">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
					<parameter name="sibling" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<vfunc name="remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
					<parameter name="actor" type="ClutterActor*"/>
				</parameters>
			</vfunc>
			<vfunc name="sort_depth_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="container" type="ClutterContainer*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="ClutterMedia" type-name="ClutterMedia" get-type="clutter_media_get_type">
			<method name="get_audio_volume" symbol="clutter_media_get_audio_volume">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
				</parameters>
			</method>
			<method name="get_buffer_fill" symbol="clutter_media_get_buffer_fill">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
				</parameters>
			</method>
			<method name="get_can_seek" symbol="clutter_media_get_can_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
				</parameters>
			</method>
			<method name="get_duration" symbol="clutter_media_get_duration">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
				</parameters>
			</method>
			<method name="get_playing" symbol="clutter_media_get_playing">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
				</parameters>
			</method>
			<method name="get_progress" symbol="clutter_media_get_progress">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
				</parameters>
			</method>
			<method name="get_subtitle_font_name" symbol="clutter_media_get_subtitle_font_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
				</parameters>
			</method>
			<method name="get_subtitle_uri" symbol="clutter_media_get_subtitle_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="clutter_media_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
				</parameters>
			</method>
			<method name="set_audio_volume" symbol="clutter_media_set_audio_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
					<parameter name="volume" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_filename" symbol="clutter_media_set_filename">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_playing" symbol="clutter_media_set_playing">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
					<parameter name="playing" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_progress" symbol="clutter_media_set_progress">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
					<parameter name="progress" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_subtitle_font_name" symbol="clutter_media_set_subtitle_font_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
					<parameter name="font_name" type="char*"/>
				</parameters>
			</method>
			<method name="set_subtitle_uri" symbol="clutter_media_set_subtitle_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_uri" symbol="clutter_media_set_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<signal name="eos" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
				</parameters>
			</signal>
			<signal name="error" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="ClutterMedia*"/>
					<parameter name="error" type="gpointer"/>
				</parameters>
			</signal>
		</interface>
		<interface name="ClutterScriptable" type-name="ClutterScriptable" get-type="clutter_scriptable_get_type">
			<method name="get_id" symbol="clutter_scriptable_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="scriptable" type="ClutterScriptable*"/>
				</parameters>
			</method>
			<method name="parse_custom_node" symbol="clutter_scriptable_parse_custom_node">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="scriptable" type="ClutterScriptable*"/>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="set_custom_property" symbol="clutter_scriptable_set_custom_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="scriptable" type="ClutterScriptable*"/>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_id" symbol="clutter_scriptable_set_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="scriptable" type="ClutterScriptable*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<vfunc name="get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="scriptable" type="ClutterScriptable*"/>
				</parameters>
			</vfunc>
			<vfunc name="parse_custom_node">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="scriptable" type="ClutterScriptable*"/>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_custom_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="scriptable" type="ClutterScriptable*"/>
					<parameter name="script" type="ClutterScript*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="scriptable" type="ClutterScriptable*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="ClutterStageWindow" type-name="ClutterStageWindow" get-type="clutter_stage_window_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<vfunc name="add_redraw_clip">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
					<parameter name="stage_rectangle" type="ClutterGeometry*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_geometry">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
					<parameter name="geometry" type="ClutterGeometry*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_pending_swaps">
				<return-type type="int"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_wrapper">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
				</parameters>
			</vfunc>
			<vfunc name="has_redraw_clips">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
				</parameters>
			</vfunc>
			<vfunc name="hide">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
				</parameters>
			</vfunc>
			<vfunc name="ignoring_redraw_clips">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
				</parameters>
			</vfunc>
			<vfunc name="realize">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
				</parameters>
			</vfunc>
			<vfunc name="resize">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_cursor_visible">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
					<parameter name="cursor_visible" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="set_fullscreen">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
					<parameter name="is_fullscreen" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_user_resizable">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
					<parameter name="is_resizable" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="show">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
					<parameter name="do_raise" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="unrealize">
				<return-type type="void"/>
				<parameters>
					<parameter name="stage_window" type="ClutterStageWindow*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="CLUTTER_COGL" type="char*" value="gl"/>
		<constant name="CLUTTER_CURRENT_TIME" type="int" value="0"/>
		<constant name="CLUTTER_FLAVOUR" type="char*" value="glx"/>
		<constant name="CLUTTER_MAJOR_VERSION" type="int" value="1"/>
		<constant name="CLUTTER_MICRO_VERSION" type="int" value="4"/>
		<constant name="CLUTTER_MINOR_VERSION" type="int" value="2"/>
		<constant name="CLUTTER_PATH_RELATIVE" type="int" value="32"/>
		<constant name="CLUTTER_PRIORITY_REDRAW" type="int" value="50"/>
		<constant name="CLUTTER_VERSION_HEX" type="int" value="0"/>
		<constant name="CLUTTER_VERSION_S" type="char*" value="1.2.4"/>
	</namespace>
</api>
