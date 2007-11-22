<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="atomic_int_set" symbol="gst_atomic_int_set">
			<return-type type="void"/>
			<parameters>
				<parameter name="atomic_int" type="gint*"/>
				<parameter name="value" type="gint"/>
			</parameters>
		</function>
		<function name="class_signal_connect" symbol="gst_class_signal_connect">
			<return-type type="guint"/>
			<parameters>
				<parameter name="klass" type="GstObjectClass*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="func" type="gpointer"/>
				<parameter name="func_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="class_signal_emit_by_name" symbol="gst_class_signal_emit_by_name">
			<return-type type="void"/>
			<parameters>
				<parameter name="object" type="GstObject*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="self" type="xmlNodePtr"/>
			</parameters>
		</function>
		<function name="core_error_quark" symbol="gst_core_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="debug_add_log_function" symbol="gst_debug_add_log_function">
			<return-type type="void"/>
			<parameters>
				<parameter name="func" type="GstLogFunction"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="debug_construct_term_color" symbol="gst_debug_construct_term_color">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="colorinfo" type="guint"/>
			</parameters>
		</function>
		<function name="debug_get_all_categories" symbol="gst_debug_get_all_categories">
			<return-type type="GSList*"/>
		</function>
		<function name="debug_get_default_threshold" symbol="gst_debug_get_default_threshold">
			<return-type type="GstDebugLevel"/>
		</function>
		<function name="debug_is_active" symbol="gst_debug_is_active">
			<return-type type="gboolean"/>
		</function>
		<function name="debug_is_colored" symbol="gst_debug_is_colored">
			<return-type type="gboolean"/>
		</function>
		<function name="debug_level_get_name" symbol="gst_debug_level_get_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="level" type="GstDebugLevel"/>
			</parameters>
		</function>
		<function name="debug_log" symbol="gst_debug_log">
			<return-type type="void"/>
			<parameters>
				<parameter name="category" type="GstDebugCategory*"/>
				<parameter name="level" type="GstDebugLevel"/>
				<parameter name="file" type="gchar*"/>
				<parameter name="function" type="gchar*"/>
				<parameter name="line" type="gint"/>
				<parameter name="object" type="GObject*"/>
				<parameter name="format" type="gchar*"/>
			</parameters>
		</function>
		<function name="debug_log_default" symbol="gst_debug_log_default">
			<return-type type="void"/>
			<parameters>
				<parameter name="category" type="GstDebugCategory*"/>
				<parameter name="level" type="GstDebugLevel"/>
				<parameter name="file" type="gchar*"/>
				<parameter name="function" type="gchar*"/>
				<parameter name="line" type="gint"/>
				<parameter name="object" type="GObject*"/>
				<parameter name="message" type="GstDebugMessage*"/>
				<parameter name="unused" type="gpointer"/>
			</parameters>
		</function>
		<function name="debug_log_valist" symbol="gst_debug_log_valist">
			<return-type type="void"/>
			<parameters>
				<parameter name="category" type="GstDebugCategory*"/>
				<parameter name="level" type="GstDebugLevel"/>
				<parameter name="file" type="gchar*"/>
				<parameter name="function" type="gchar*"/>
				<parameter name="line" type="gint"/>
				<parameter name="object" type="GObject*"/>
				<parameter name="format" type="gchar*"/>
				<parameter name="args" type="va_list"/>
			</parameters>
		</function>
		<function name="debug_print_stack_trace" symbol="gst_debug_print_stack_trace">
			<return-type type="void"/>
		</function>
		<function name="debug_remove_log_function" symbol="gst_debug_remove_log_function">
			<return-type type="guint"/>
			<parameters>
				<parameter name="func" type="GstLogFunction"/>
			</parameters>
		</function>
		<function name="debug_remove_log_function_by_data" symbol="gst_debug_remove_log_function_by_data">
			<return-type type="guint"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="debug_set_active" symbol="gst_debug_set_active">
			<return-type type="void"/>
			<parameters>
				<parameter name="active" type="gboolean"/>
			</parameters>
		</function>
		<function name="debug_set_colored" symbol="gst_debug_set_colored">
			<return-type type="void"/>
			<parameters>
				<parameter name="colored" type="gboolean"/>
			</parameters>
		</function>
		<function name="debug_set_default_threshold" symbol="gst_debug_set_default_threshold">
			<return-type type="void"/>
			<parameters>
				<parameter name="level" type="GstDebugLevel"/>
			</parameters>
		</function>
		<function name="debug_set_threshold_for_name" symbol="gst_debug_set_threshold_for_name">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
				<parameter name="level" type="GstDebugLevel"/>
			</parameters>
		</function>
		<function name="debug_unset_threshold_for_name" symbol="gst_debug_unset_threshold_for_name">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="default_registry_check_feature_version" symbol="gst_default_registry_check_feature_version">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="feature_name" type="gchar*"/>
				<parameter name="min_major" type="guint"/>
				<parameter name="min_minor" type="guint"/>
				<parameter name="min_micro" type="guint"/>
			</parameters>
		</function>
		<function name="deinit" symbol="gst_deinit">
			<return-type type="void"/>
		</function>
		<function name="double_range_get_type" symbol="gst_double_range_get_type">
			<return-type type="GType"/>
		</function>
		<function name="error_get_message" symbol="gst_error_get_message">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="domain" type="GQuark"/>
				<parameter name="code" type="gint"/>
			</parameters>
		</function>
		<function name="filter_run" symbol="gst_filter_run">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="list" type="GList*"/>
				<parameter name="func" type="GstFilterFunc"/>
				<parameter name="first" type="gboolean"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="flow_get_name" symbol="gst_flow_get_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="ret" type="GstFlowReturn"/>
			</parameters>
		</function>
		<function name="flow_to_quark" symbol="gst_flow_to_quark">
			<return-type type="GQuark"/>
			<parameters>
				<parameter name="ret" type="GstFlowReturn"/>
			</parameters>
		</function>
		<function name="format_get_by_nick" symbol="gst_format_get_by_nick">
			<return-type type="GstFormat"/>
			<parameters>
				<parameter name="nick" type="gchar*"/>
			</parameters>
		</function>
		<function name="format_get_details" symbol="gst_format_get_details">
			<return-type type="GstFormatDefinition*"/>
			<parameters>
				<parameter name="format" type="GstFormat"/>
			</parameters>
		</function>
		<function name="format_get_name" symbol="gst_format_get_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="format" type="GstFormat"/>
			</parameters>
		</function>
		<function name="format_iterate_definitions" symbol="gst_format_iterate_definitions">
			<return-type type="GstIterator*"/>
		</function>
		<function name="format_register" symbol="gst_format_register">
			<return-type type="GstFormat"/>
			<parameters>
				<parameter name="nick" type="gchar*"/>
				<parameter name="description" type="gchar*"/>
			</parameters>
		</function>
		<function name="format_to_quark" symbol="gst_format_to_quark">
			<return-type type="GQuark"/>
			<parameters>
				<parameter name="format" type="GstFormat"/>
			</parameters>
		</function>
		<function name="formats_contains" symbol="gst_formats_contains">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="formats" type="GstFormat*"/>
				<parameter name="format" type="GstFormat"/>
			</parameters>
		</function>
		<function name="fourcc_get_type" symbol="gst_fourcc_get_type">
			<return-type type="GType"/>
		</function>
		<function name="fraction_get_type" symbol="gst_fraction_get_type">
			<return-type type="GType"/>
		</function>
		<function name="fraction_range_get_type" symbol="gst_fraction_range_get_type">
			<return-type type="GType"/>
		</function>
		<function name="init" symbol="gst_init">
			<return-type type="void"/>
			<parameters>
				<parameter name="argc" type="int*"/>
				<parameter name="argv" type="char**[]"/>
			</parameters>
		</function>
		<function name="init_check" symbol="gst_init_check">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="argc" type="int*"/>
				<parameter name="argv" type="char**[]"/>
				<parameter name="err" type="GError**"/>
			</parameters>
		</function>
		<function name="init_get_option_group" symbol="gst_init_get_option_group">
			<return-type type="GOptionGroup*"/>
		</function>
		<function name="int_range_get_type" symbol="gst_int_range_get_type">
			<return-type type="GType"/>
		</function>
		<function name="is_tag_list" symbol="gst_is_tag_list">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="p" type="gconstpointer"/>
			</parameters>
		</function>
		<function name="library_error_quark" symbol="gst_library_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="marshal_BOOLEAN__POINTER" symbol="gst_marshal_BOOLEAN__POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_BOOLEAN__VOID" symbol="gst_marshal_BOOLEAN__VOID">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_BOXED__BOXED" symbol="gst_marshal_BOXED__BOXED">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_POINTER__POINTER" symbol="gst_marshal_POINTER__POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_VOID__BOXED_OBJECT" symbol="gst_marshal_VOID__BOXED_OBJECT">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_VOID__INT64" symbol="gst_marshal_VOID__INT64">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_VOID__INT_INT" symbol="gst_marshal_VOID__INT_INT">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_VOID__OBJECT_BOXED" symbol="gst_marshal_VOID__OBJECT_BOXED">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_VOID__OBJECT_BOXED_STRING" symbol="gst_marshal_VOID__OBJECT_BOXED_STRING">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_VOID__OBJECT_OBJECT" symbol="gst_marshal_VOID__OBJECT_OBJECT">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_VOID__OBJECT_OBJECT_STRING" symbol="gst_marshal_VOID__OBJECT_OBJECT_STRING">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_VOID__OBJECT_PARAM" symbol="gst_marshal_VOID__OBJECT_PARAM">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_VOID__OBJECT_POINTER" symbol="gst_marshal_VOID__OBJECT_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_VOID__OBJECT_STRING" symbol="gst_marshal_VOID__OBJECT_STRING">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_OBJECT" symbol="gst_marshal_VOID__POINTER_OBJECT">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="marshal_VOID__UINT_BOXED" symbol="gst_marshal_VOID__UINT_BOXED">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="param_spec_fraction" symbol="gst_param_spec_fraction">
			<return-type type="GParamSpec*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
				<parameter name="nick" type="gchar*"/>
				<parameter name="blurb" type="gchar*"/>
				<parameter name="min_num" type="gint"/>
				<parameter name="min_denom" type="gint"/>
				<parameter name="max_num" type="gint"/>
				<parameter name="max_denom" type="gint"/>
				<parameter name="default_num" type="gint"/>
				<parameter name="default_denom" type="gint"/>
				<parameter name="flags" type="GParamFlags"/>
			</parameters>
		</function>
		<function name="param_spec_mini_object" symbol="gst_param_spec_mini_object">
			<return-type type="GParamSpec*"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="nick" type="char*"/>
				<parameter name="blurb" type="char*"/>
				<parameter name="object_type" type="GType"/>
				<parameter name="flags" type="GParamFlags"/>
			</parameters>
		</function>
		<function name="parse_bin_from_description" symbol="gst_parse_bin_from_description">
			<return-type type="GstElement*"/>
			<parameters>
				<parameter name="bin_description" type="gchar*"/>
				<parameter name="ghost_unconnected_pads" type="gboolean"/>
				<parameter name="err" type="GError**"/>
			</parameters>
		</function>
		<function name="parse_error_quark" symbol="gst_parse_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="parse_launch" symbol="gst_parse_launch">
			<return-type type="GstElement*"/>
			<parameters>
				<parameter name="pipeline_description" type="gchar*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="parse_launchv" symbol="gst_parse_launchv">
			<return-type type="GstElement*"/>
			<parameters>
				<parameter name="argv" type="gchar**"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="print_element_args" symbol="gst_print_element_args">
			<return-type type="void"/>
			<parameters>
				<parameter name="buf" type="GString*"/>
				<parameter name="indent" type="gint"/>
				<parameter name="element" type="GstElement*"/>
			</parameters>
		</function>
		<function name="print_pad_caps" symbol="gst_print_pad_caps">
			<return-type type="void"/>
			<parameters>
				<parameter name="buf" type="GString*"/>
				<parameter name="indent" type="gint"/>
				<parameter name="pad" type="GstPad*"/>
			</parameters>
		</function>
		<function name="resource_error_quark" symbol="gst_resource_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="segtrap_is_enabled" symbol="gst_segtrap_is_enabled">
			<return-type type="gboolean"/>
		</function>
		<function name="segtrap_set_enabled" symbol="gst_segtrap_set_enabled">
			<return-type type="void"/>
			<parameters>
				<parameter name="enabled" type="gboolean"/>
			</parameters>
		</function>
		<function name="stream_error_quark" symbol="gst_stream_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="tag_exists" symbol="gst_tag_exists">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="tag" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_get_description" symbol="gst_tag_get_description">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="tag" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_get_flag" symbol="gst_tag_get_flag">
			<return-type type="GstTagFlag"/>
			<parameters>
				<parameter name="tag" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_get_nick" symbol="gst_tag_get_nick">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="tag" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_get_type" symbol="gst_tag_get_type">
			<return-type type="GType"/>
			<parameters>
				<parameter name="tag" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_is_fixed" symbol="gst_tag_is_fixed">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="tag" type="gchar*"/>
			</parameters>
		</function>
		<function name="tag_merge_strings_with_comma" symbol="gst_tag_merge_strings_with_comma">
			<return-type type="void"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="src" type="GValue*"/>
			</parameters>
		</function>
		<function name="tag_merge_use_first" symbol="gst_tag_merge_use_first">
			<return-type type="void"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="src" type="GValue*"/>
			</parameters>
		</function>
		<function name="tag_register" symbol="gst_tag_register">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
				<parameter name="flag" type="GstTagFlag"/>
				<parameter name="type" type="GType"/>
				<parameter name="nick" type="gchar*"/>
				<parameter name="blurb" type="gchar*"/>
				<parameter name="func" type="GstTagMergeFunc"/>
			</parameters>
		</function>
		<function name="type_register_static_full" symbol="gst_type_register_static_full">
			<return-type type="GType"/>
			<parameters>
				<parameter name="parent_type" type="GType"/>
				<parameter name="type_name" type="gchar*"/>
				<parameter name="class_size" type="guint"/>
				<parameter name="base_init" type="GBaseInitFunc"/>
				<parameter name="base_finalize" type="GBaseFinalizeFunc"/>
				<parameter name="class_init" type="GClassInitFunc"/>
				<parameter name="class_finalize" type="GClassFinalizeFunc"/>
				<parameter name="class_data" type="gconstpointer"/>
				<parameter name="instance_size" type="guint"/>
				<parameter name="n_preallocs" type="guint16"/>
				<parameter name="instance_init" type="GInstanceInitFunc"/>
				<parameter name="value_table" type="GTypeValueTable*"/>
				<parameter name="flags" type="GTypeFlags"/>
			</parameters>
		</function>
		<function name="update_registry" symbol="gst_update_registry">
			<return-type type="gboolean"/>
		</function>
		<function name="uri_construct" symbol="gst_uri_construct">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="protocol" type="gchar*"/>
				<parameter name="location" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_get_location" symbol="gst_uri_get_location">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="uri" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_get_protocol" symbol="gst_uri_get_protocol">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="uri" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_has_protocol" symbol="gst_uri_has_protocol">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="uri" type="gchar*"/>
				<parameter name="protocol" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_is_valid" symbol="gst_uri_is_valid">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="uri" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_protocol_is_supported" symbol="gst_uri_protocol_is_supported">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="type" type="GstURIType"/>
				<parameter name="protocol" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_protocol_is_valid" symbol="gst_uri_protocol_is_valid">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="protocol" type="gchar*"/>
			</parameters>
		</function>
		<function name="util_dump_mem" symbol="gst_util_dump_mem">
			<return-type type="void"/>
			<parameters>
				<parameter name="mem" type="guchar*"/>
				<parameter name="size" type="guint"/>
			</parameters>
		</function>
		<function name="util_gdouble_to_guint64" symbol="gst_util_gdouble_to_guint64">
			<return-type type="guint64"/>
			<parameters>
				<parameter name="value" type="gdouble"/>
			</parameters>
		</function>
		<function name="util_guint64_to_gdouble" symbol="gst_util_guint64_to_gdouble">
			<return-type type="gdouble"/>
			<parameters>
				<parameter name="value" type="guint64"/>
			</parameters>
		</function>
		<function name="util_set_object_arg" symbol="gst_util_set_object_arg">
			<return-type type="void"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="value" type="gchar*"/>
			</parameters>
		</function>
		<function name="util_set_value_from_string" symbol="gst_util_set_value_from_string">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="value_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="util_uint64_scale" symbol="gst_util_uint64_scale">
			<return-type type="guint64"/>
			<parameters>
				<parameter name="val" type="guint64"/>
				<parameter name="num" type="guint64"/>
				<parameter name="denom" type="guint64"/>
			</parameters>
		</function>
		<function name="util_uint64_scale_int" symbol="gst_util_uint64_scale_int">
			<return-type type="guint64"/>
			<parameters>
				<parameter name="val" type="guint64"/>
				<parameter name="num" type="gint"/>
				<parameter name="denom" type="gint"/>
			</parameters>
		</function>
		<function name="value_array_append_value" symbol="gst_value_array_append_value">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="append_value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_array_get_size" symbol="gst_value_array_get_size">
			<return-type type="guint"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_array_get_type" symbol="gst_value_array_get_type">
			<return-type type="GType"/>
		</function>
		<function name="value_array_get_value" symbol="gst_value_array_get_value">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="index" type="guint"/>
			</parameters>
		</function>
		<function name="value_array_prepend_value" symbol="gst_value_array_prepend_value">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="prepend_value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_can_compare" symbol="gst_value_can_compare">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="value1" type="GValue*"/>
				<parameter name="value2" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_can_intersect" symbol="gst_value_can_intersect">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="value1" type="GValue*"/>
				<parameter name="value2" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_can_subtract" symbol="gst_value_can_subtract">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="minuend" type="GValue*"/>
				<parameter name="subtrahend" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_can_union" symbol="gst_value_can_union">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="value1" type="GValue*"/>
				<parameter name="value2" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_compare" symbol="gst_value_compare">
			<return-type type="gint"/>
			<parameters>
				<parameter name="value1" type="GValue*"/>
				<parameter name="value2" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_deserialize" symbol="gst_value_deserialize">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="src" type="gchar*"/>
			</parameters>
		</function>
		<function name="value_fraction_multiply" symbol="gst_value_fraction_multiply">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="product" type="GValue*"/>
				<parameter name="factor1" type="GValue*"/>
				<parameter name="factor2" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_fraction_subtract" symbol="gst_value_fraction_subtract">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="minuend" type="GValue*"/>
				<parameter name="subtrahend" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_caps" symbol="gst_value_get_caps">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_date" symbol="gst_value_get_date">
			<return-type type="GDate*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_double_range_max" symbol="gst_value_get_double_range_max">
			<return-type type="gdouble"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_double_range_min" symbol="gst_value_get_double_range_min">
			<return-type type="gdouble"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_fourcc" symbol="gst_value_get_fourcc">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_fraction_denominator" symbol="gst_value_get_fraction_denominator">
			<return-type type="gint"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_fraction_numerator" symbol="gst_value_get_fraction_numerator">
			<return-type type="gint"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_fraction_range_max" symbol="gst_value_get_fraction_range_max">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_fraction_range_min" symbol="gst_value_get_fraction_range_min">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_int_range_max" symbol="gst_value_get_int_range_max">
			<return-type type="gint"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_int_range_min" symbol="gst_value_get_int_range_min">
			<return-type type="gint"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_mini_object" symbol="gst_value_get_mini_object">
			<return-type type="GstMiniObject*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_structure" symbol="gst_value_get_structure">
			<return-type type="GstStructure*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_init_and_copy" symbol="gst_value_init_and_copy">
			<return-type type="void"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="src" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_intersect" symbol="gst_value_intersect">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="value1" type="GValue*"/>
				<parameter name="value2" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_is_fixed" symbol="gst_value_is_fixed">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_list_append_value" symbol="gst_value_list_append_value">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="append_value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_list_concat" symbol="gst_value_list_concat">
			<return-type type="void"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="value1" type="GValue*"/>
				<parameter name="value2" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_list_get_size" symbol="gst_value_list_get_size">
			<return-type type="guint"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_list_get_type" symbol="gst_value_list_get_type">
			<return-type type="GType"/>
		</function>
		<function name="value_list_get_value" symbol="gst_value_list_get_value">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="index" type="guint"/>
			</parameters>
		</function>
		<function name="value_list_prepend_value" symbol="gst_value_list_prepend_value">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="prepend_value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_register" symbol="gst_value_register">
			<return-type type="void"/>
			<parameters>
				<parameter name="table" type="GstValueTable*"/>
			</parameters>
		</function>
		<function name="value_register_intersect_func" symbol="gst_value_register_intersect_func">
			<return-type type="void"/>
			<parameters>
				<parameter name="type1" type="GType"/>
				<parameter name="type2" type="GType"/>
				<parameter name="func" type="GstValueIntersectFunc"/>
			</parameters>
		</function>
		<function name="value_register_subtract_func" symbol="gst_value_register_subtract_func">
			<return-type type="void"/>
			<parameters>
				<parameter name="minuend_type" type="GType"/>
				<parameter name="subtrahend_type" type="GType"/>
				<parameter name="func" type="GstValueSubtractFunc"/>
			</parameters>
		</function>
		<function name="value_register_union_func" symbol="gst_value_register_union_func">
			<return-type type="void"/>
			<parameters>
				<parameter name="type1" type="GType"/>
				<parameter name="type2" type="GType"/>
				<parameter name="func" type="GstValueUnionFunc"/>
			</parameters>
		</function>
		<function name="value_serialize" symbol="gst_value_serialize">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_set_caps" symbol="gst_value_set_caps">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="value_set_date" symbol="gst_value_set_date">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="date" type="GDate*"/>
			</parameters>
		</function>
		<function name="value_set_double_range" symbol="gst_value_set_double_range">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="start" type="gdouble"/>
				<parameter name="end" type="gdouble"/>
			</parameters>
		</function>
		<function name="value_set_fourcc" symbol="gst_value_set_fourcc">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="fourcc" type="guint32"/>
			</parameters>
		</function>
		<function name="value_set_fraction" symbol="gst_value_set_fraction">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="numerator" type="gint"/>
				<parameter name="denominator" type="gint"/>
			</parameters>
		</function>
		<function name="value_set_fraction_range" symbol="gst_value_set_fraction_range">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="start" type="GValue*"/>
				<parameter name="end" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_set_fraction_range_full" symbol="gst_value_set_fraction_range_full">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="numerator_start" type="gint"/>
				<parameter name="denominator_start" type="gint"/>
				<parameter name="numerator_end" type="gint"/>
				<parameter name="denominator_end" type="gint"/>
			</parameters>
		</function>
		<function name="value_set_int_range" symbol="gst_value_set_int_range">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="start" type="gint"/>
				<parameter name="end" type="gint"/>
			</parameters>
		</function>
		<function name="value_set_mini_object" symbol="gst_value_set_mini_object">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="mini_object" type="GstMiniObject*"/>
			</parameters>
		</function>
		<function name="value_set_structure" symbol="gst_value_set_structure">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="structure" type="GstStructure*"/>
			</parameters>
		</function>
		<function name="value_subtract" symbol="gst_value_subtract">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="minuend" type="GValue*"/>
				<parameter name="subtrahend" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_take_mini_object" symbol="gst_value_take_mini_object">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="mini_object" type="GstMiniObject*"/>
			</parameters>
		</function>
		<function name="value_union" symbol="gst_value_union">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="value1" type="GValue*"/>
				<parameter name="value2" type="GValue*"/>
			</parameters>
		</function>
		<function name="version" symbol="gst_version">
			<return-type type="void"/>
			<parameters>
				<parameter name="major" type="guint*"/>
				<parameter name="minor" type="guint*"/>
				<parameter name="micro" type="guint*"/>
				<parameter name="nano" type="guint*"/>
			</parameters>
		</function>
		<function name="version_string" symbol="gst_version_string">
			<return-type type="gchar*"/>
		</function>
		<callback name="GstBusFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="bus" type="GstBus*"/>
				<parameter name="message" type="GstMessage*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstBusSyncHandler">
			<return-type type="GstBusSyncReply"/>
			<parameters>
				<parameter name="bus" type="GstBus*"/>
				<parameter name="message" type="GstMessage*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstClockCallback">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="clock" type="GstClock*"/>
				<parameter name="time" type="GstClockTime"/>
				<parameter name="id" type="GstClockID"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstCollectDataDestroyNotify">
			<return-type type="void"/>
			<parameters>
				<parameter name="data" type="GstCollectData*"/>
			</parameters>
		</callback>
		<callback name="GstCollectPadsFunction">
			<return-type type="GstFlowReturn"/>
			<parameters>
				<parameter name="pads" type="GstCollectPads*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstDataQueueCheckFullFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="queue" type="GstDataQueue*"/>
				<parameter name="visible" type="guint"/>
				<parameter name="bytes" type="guint"/>
				<parameter name="time" type="guint64"/>
				<parameter name="checkdata" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstDebugFuncPtr">
			<return-type type="void"/>
		</callback>
		<callback name="GstFilterFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="obj" type="gpointer"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstIndexFilter">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="index" type="GstIndex*"/>
				<parameter name="entry" type="GstIndexEntry*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstIndexResolver">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="index" type="GstIndex*"/>
				<parameter name="writer" type="GstObject*"/>
				<parameter name="writer_string" type="gchar**"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstIteratorDisposeFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="owner" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstIteratorFoldFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="item" type="gpointer"/>
				<parameter name="ret" type="GValue*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstIteratorFreeFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="it" type="GstIterator*"/>
			</parameters>
		</callback>
		<callback name="GstIteratorItemFunction">
			<return-type type="GstIteratorItem"/>
			<parameters>
				<parameter name="it" type="GstIterator*"/>
				<parameter name="item" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstIteratorNextFunction">
			<return-type type="GstIteratorResult"/>
			<parameters>
				<parameter name="it" type="GstIterator*"/>
				<parameter name="result" type="gpointer*"/>
			</parameters>
		</callback>
		<callback name="GstIteratorResyncFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="it" type="GstIterator*"/>
			</parameters>
		</callback>
		<callback name="GstLogFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="category" type="GstDebugCategory*"/>
				<parameter name="level" type="GstDebugLevel"/>
				<parameter name="file" type="gchar*"/>
				<parameter name="function" type="gchar*"/>
				<parameter name="line" type="gint"/>
				<parameter name="object" type="GObject*"/>
				<parameter name="message" type="GstDebugMessage*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstMiniObjectCopyFunction">
			<return-type type="GstMiniObject*"/>
			<parameters>
				<parameter name="obj" type="GstMiniObject*"/>
			</parameters>
		</callback>
		<callback name="GstMiniObjectFinalizeFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="obj" type="GstMiniObject*"/>
			</parameters>
		</callback>
		<callback name="GstPadAcceptCapsFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</callback>
		<callback name="GstPadActivateFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
			</parameters>
		</callback>
		<callback name="GstPadActivateModeFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="active" type="gboolean"/>
			</parameters>
		</callback>
		<callback name="GstPadBlockCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="blocked" type="gboolean"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstPadBufferAllocFunction">
			<return-type type="GstFlowReturn"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="offset" type="guint64"/>
				<parameter name="size" type="guint"/>
				<parameter name="caps" type="GstCaps*"/>
				<parameter name="buf" type="GstBuffer**"/>
			</parameters>
		</callback>
		<callback name="GstPadChainFunction">
			<return-type type="GstFlowReturn"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</callback>
		<callback name="GstPadCheckGetRangeFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
			</parameters>
		</callback>
		<callback name="GstPadDispatcherFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstPadEventFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="event" type="GstEvent*"/>
			</parameters>
		</callback>
		<callback name="GstPadFixateCapsFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</callback>
		<callback name="GstPadGetCapsFunction">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
			</parameters>
		</callback>
		<callback name="GstPadGetRangeFunction">
			<return-type type="GstFlowReturn"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="offset" type="guint64"/>
				<parameter name="length" type="guint"/>
				<parameter name="buffer" type="GstBuffer**"/>
			</parameters>
		</callback>
		<callback name="GstPadIntLinkFunction">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
			</parameters>
		</callback>
		<callback name="GstPadLinkFunction">
			<return-type type="GstPadLinkReturn"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="peer" type="GstPad*"/>
			</parameters>
		</callback>
		<callback name="GstPadQueryFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="query" type="GstQuery*"/>
			</parameters>
		</callback>
		<callback name="GstPadQueryTypeFunction">
			<return-type type="GstQueryType*"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
			</parameters>
		</callback>
		<callback name="GstPadSetCapsFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</callback>
		<callback name="GstPadUnlinkFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
			</parameters>
		</callback>
		<callback name="GstPluginFeatureFilter">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="feature" type="GstPluginFeature*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstPluginFilter">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="plugin" type="GstPlugin*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstPluginInitFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="plugin" type="GstPlugin*"/>
			</parameters>
		</callback>
		<callback name="GstStructureForeachFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="field_id" type="GQuark"/>
				<parameter name="value" type="GValue*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstStructureMapFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="field_id" type="GQuark"/>
				<parameter name="value" type="GValue*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstTagForeachFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GstTagList*"/>
				<parameter name="tag" type="gchar*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstTagMergeFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="src" type="GValue*"/>
			</parameters>
		</callback>
		<callback name="GstTaskFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="data" type="void*"/>
			</parameters>
		</callback>
		<callback name="GstTypeFindFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="find" type="GstTypeFind*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstTypeFindHelperGetRangeFunction">
			<return-type type="GstFlowReturn"/>
			<parameters>
				<parameter name="obj" type="GstObject*"/>
				<parameter name="offset" type="guint64"/>
				<parameter name="length" type="guint"/>
				<parameter name="buffer" type="GstBuffer**"/>
			</parameters>
		</callback>
		<callback name="GstValueCompareFunc">
			<return-type type="gint"/>
			<parameters>
				<parameter name="value1" type="GValue*"/>
				<parameter name="value2" type="GValue*"/>
			</parameters>
		</callback>
		<callback name="GstValueDeserializeFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="s" type="gchar*"/>
			</parameters>
		</callback>
		<callback name="GstValueIntersectFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="value1" type="GValue*"/>
				<parameter name="value2" type="GValue*"/>
			</parameters>
		</callback>
		<callback name="GstValueSerializeFunc">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="value1" type="GValue*"/>
			</parameters>
		</callback>
		<callback name="GstValueSubtractFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="minuend" type="GValue*"/>
				<parameter name="subtrahend" type="GValue*"/>
			</parameters>
		</callback>
		<callback name="GstValueUnionFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="dest" type="GValue*"/>
				<parameter name="value1" type="GValue*"/>
				<parameter name="value2" type="GValue*"/>
			</parameters>
		</callback>
		<struct name="GstAllocTrace">
			<method name="available" symbol="gst_alloc_trace_available">
				<return-type type="gboolean"/>
			</method>
			<method name="get" symbol="gst_alloc_trace_get">
				<return-type type="GstAllocTrace*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="list" symbol="gst_alloc_trace_list">
				<return-type type="GList*"/>
			</method>
			<method name="live_all" symbol="gst_alloc_trace_live_all">
				<return-type type="int"/>
			</method>
			<method name="print" symbol="gst_alloc_trace_print">
				<return-type type="void"/>
				<parameters>
					<parameter name="trace" type="GstAllocTrace*"/>
				</parameters>
			</method>
			<method name="print_all" symbol="gst_alloc_trace_print_all">
				<return-type type="void"/>
			</method>
			<method name="print_live" symbol="gst_alloc_trace_print_live">
				<return-type type="void"/>
			</method>
			<method name="set_flags" symbol="gst_alloc_trace_set_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="trace" type="GstAllocTrace*"/>
					<parameter name="flags" type="GstAllocTraceFlags"/>
				</parameters>
			</method>
			<method name="set_flags_all" symbol="gst_alloc_trace_set_flags_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="flags" type="GstAllocTraceFlags"/>
				</parameters>
			</method>
			<field name="name" type="gchar*"/>
			<field name="flags" type="gint"/>
			<field name="live" type="gint"/>
			<field name="mem_live" type="GSList*"/>
		</struct>
		<struct name="GstBuffer">
			<method name="copy_metadata" symbol="gst_buffer_copy_metadata">
				<return-type type="void"/>
				<parameters>
					<parameter name="dest" type="GstBuffer*"/>
					<parameter name="src" type="GstBuffer*"/>
					<parameter name="flags" type="GstBufferCopyFlags"/>
				</parameters>
			</method>
			<method name="create_sub" symbol="gst_buffer_create_sub">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="parent" type="GstBuffer*"/>
					<parameter name="offset" type="guint"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="get_caps" symbol="gst_buffer_get_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="is_metadata_writable" symbol="gst_buffer_is_metadata_writable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="is_span_fast" symbol="gst_buffer_is_span_fast">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf1" type="GstBuffer*"/>
					<parameter name="buf2" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="join" symbol="gst_buffer_join">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="buf1" type="GstBuffer*"/>
					<parameter name="buf2" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="make_metadata_writable" symbol="gst_buffer_make_metadata_writable">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="buf" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="merge" symbol="gst_buffer_merge">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="buf1" type="GstBuffer*"/>
					<parameter name="buf2" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_buffer_new">
				<return-type type="GstBuffer*"/>
			</method>
			<method name="new_and_alloc" symbol="gst_buffer_new_and_alloc">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="set_caps" symbol="gst_buffer_set_caps">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GstBuffer*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="span" symbol="gst_buffer_span">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="buf1" type="GstBuffer*"/>
					<parameter name="offset" type="guint32"/>
					<parameter name="buf2" type="GstBuffer*"/>
					<parameter name="len" type="guint32"/>
				</parameters>
			</method>
			<method name="stamp" symbol="gst_buffer_stamp">
				<return-type type="void"/>
				<parameters>
					<parameter name="dest" type="GstBuffer*"/>
					<parameter name="src" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="try_new_and_alloc" symbol="gst_buffer_try_new_and_alloc">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<field name="mini_object" type="GstMiniObject"/>
			<field name="data" type="guint8*"/>
			<field name="size" type="guint"/>
			<field name="timestamp" type="GstClockTime"/>
			<field name="duration" type="GstClockTime"/>
			<field name="caps" type="GstCaps*"/>
			<field name="offset" type="guint64"/>
			<field name="offset_end" type="guint64"/>
			<field name="malloc_data" type="guint8*"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstBufferClass">
			<field name="mini_object_class" type="GstMiniObjectClass"/>
		</struct>
		<struct name="GstClockEntry">
			<field name="refcount" type="gint"/>
			<field name="clock" type="GstClock*"/>
			<field name="type" type="GstClockEntryType"/>
			<field name="time" type="GstClockTime"/>
			<field name="interval" type="GstClockTime"/>
			<field name="status" type="GstClockReturn"/>
			<field name="func" type="GstClockCallback"/>
			<field name="user_data" type="gpointer"/>
		</struct>
		<struct name="GstClockID">
			<method name="compare_func" symbol="gst_clock_id_compare_func">
				<return-type type="gint"/>
				<parameters>
					<parameter name="id1" type="gconstpointer"/>
					<parameter name="id2" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="get_time" symbol="gst_clock_id_get_time">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="id" type="GstClockID"/>
				</parameters>
			</method>
			<method name="ref" symbol="gst_clock_id_ref">
				<return-type type="GstClockID"/>
				<parameters>
					<parameter name="id" type="GstClockID"/>
				</parameters>
			</method>
			<method name="unref" symbol="gst_clock_id_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="id" type="GstClockID"/>
				</parameters>
			</method>
			<method name="unschedule" symbol="gst_clock_id_unschedule">
				<return-type type="void"/>
				<parameters>
					<parameter name="id" type="GstClockID"/>
				</parameters>
			</method>
			<method name="wait" symbol="gst_clock_id_wait">
				<return-type type="GstClockReturn"/>
				<parameters>
					<parameter name="id" type="GstClockID"/>
					<parameter name="jitter" type="GstClockTimeDiff*"/>
				</parameters>
			</method>
			<method name="wait_async" symbol="gst_clock_id_wait_async">
				<return-type type="GstClockReturn"/>
				<parameters>
					<parameter name="id" type="GstClockID"/>
					<parameter name="func" type="GstClockCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstClockTime">
		</struct>
		<struct name="GstClockTimeDiff">
		</struct>
		<struct name="GstCollectData">
			<field name="collect" type="GstCollectPads*"/>
			<field name="pad" type="GstPad*"/>
			<field name="buffer" type="GstBuffer*"/>
			<field name="pos" type="guint"/>
			<field name="segment" type="GstSegment"/>
			<field name="abidata" type="gpointer"/>
		</struct>
		<struct name="GstDataQueueItem">
			<field name="object" type="GstMiniObject*"/>
			<field name="size" type="guint"/>
			<field name="duration" type="guint64"/>
			<field name="visible" type="gboolean"/>
			<field name="destroy" type="GDestroyNotify"/>
		</struct>
		<struct name="GstDataQueueSize">
			<field name="visible" type="guint"/>
			<field name="bytes" type="guint"/>
			<field name="time" type="guint64"/>
		</struct>
		<struct name="GstDebugCategory">
			<method name="free" symbol="gst_debug_category_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="category" type="GstDebugCategory*"/>
				</parameters>
			</method>
			<method name="get_color" symbol="gst_debug_category_get_color">
				<return-type type="guint"/>
				<parameters>
					<parameter name="category" type="GstDebugCategory*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="gst_debug_category_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="category" type="GstDebugCategory*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gst_debug_category_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="category" type="GstDebugCategory*"/>
				</parameters>
			</method>
			<method name="get_threshold" symbol="gst_debug_category_get_threshold">
				<return-type type="GstDebugLevel"/>
				<parameters>
					<parameter name="category" type="GstDebugCategory*"/>
				</parameters>
			</method>
			<method name="reset_threshold" symbol="gst_debug_category_reset_threshold">
				<return-type type="void"/>
				<parameters>
					<parameter name="category" type="GstDebugCategory*"/>
				</parameters>
			</method>
			<method name="set_threshold" symbol="gst_debug_category_set_threshold">
				<return-type type="void"/>
				<parameters>
					<parameter name="category" type="GstDebugCategory*"/>
					<parameter name="level" type="GstDebugLevel"/>
				</parameters>
			</method>
			<field name="threshold" type="gint"/>
			<field name="color" type="guint"/>
			<field name="name" type="gchar*"/>
			<field name="description" type="gchar*"/>
		</struct>
		<struct name="GstDebugMessage">
			<method name="get" symbol="gst_debug_message_get">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message" type="GstDebugMessage*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstElementDetails">
			<field name="longname" type="gchar*"/>
			<field name="klass" type="gchar*"/>
			<field name="description" type="gchar*"/>
			<field name="author" type="gchar*"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstEvent">
			<method name="get_structure" symbol="gst_event_get_structure">
				<return-type type="GstStructure*"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</method>
			<method name="new_buffer_size" symbol="gst_event_new_buffer_size">
				<return-type type="GstEvent*"/>
				<parameters>
					<parameter name="format" type="GstFormat"/>
					<parameter name="minsize" type="gint64"/>
					<parameter name="maxsize" type="gint64"/>
					<parameter name="async" type="gboolean"/>
				</parameters>
			</method>
			<method name="new_custom" symbol="gst_event_new_custom">
				<return-type type="GstEvent*"/>
				<parameters>
					<parameter name="type" type="GstEventType"/>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="new_eos" symbol="gst_event_new_eos">
				<return-type type="GstEvent*"/>
			</method>
			<method name="new_flush_start" symbol="gst_event_new_flush_start">
				<return-type type="GstEvent*"/>
			</method>
			<method name="new_flush_stop" symbol="gst_event_new_flush_stop">
				<return-type type="GstEvent*"/>
			</method>
			<method name="new_latency" symbol="gst_event_new_latency">
				<return-type type="GstEvent*"/>
				<parameters>
					<parameter name="latency" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="new_navigation" symbol="gst_event_new_navigation">
				<return-type type="GstEvent*"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="new_new_segment" symbol="gst_event_new_new_segment">
				<return-type type="GstEvent*"/>
				<parameters>
					<parameter name="update" type="gboolean"/>
					<parameter name="rate" type="gdouble"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="start" type="gint64"/>
					<parameter name="stop" type="gint64"/>
					<parameter name="position" type="gint64"/>
				</parameters>
			</method>
			<method name="new_new_segment_full" symbol="gst_event_new_new_segment_full">
				<return-type type="GstEvent*"/>
				<parameters>
					<parameter name="update" type="gboolean"/>
					<parameter name="rate" type="gdouble"/>
					<parameter name="applied_rate" type="gdouble"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="start" type="gint64"/>
					<parameter name="stop" type="gint64"/>
					<parameter name="position" type="gint64"/>
				</parameters>
			</method>
			<method name="new_qos" symbol="gst_event_new_qos">
				<return-type type="GstEvent*"/>
				<parameters>
					<parameter name="proportion" type="gdouble"/>
					<parameter name="diff" type="GstClockTimeDiff"/>
					<parameter name="timestamp" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="new_seek" symbol="gst_event_new_seek">
				<return-type type="GstEvent*"/>
				<parameters>
					<parameter name="rate" type="gdouble"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="flags" type="GstSeekFlags"/>
					<parameter name="start_type" type="GstSeekType"/>
					<parameter name="start" type="gint64"/>
					<parameter name="stop_type" type="GstSeekType"/>
					<parameter name="stop" type="gint64"/>
				</parameters>
			</method>
			<method name="new_tag" symbol="gst_event_new_tag">
				<return-type type="GstEvent*"/>
				<parameters>
					<parameter name="taglist" type="GstTagList*"/>
				</parameters>
			</method>
			<method name="parse_buffer_size" symbol="gst_event_parse_buffer_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="minsize" type="gint64*"/>
					<parameter name="maxsize" type="gint64*"/>
					<parameter name="async" type="gboolean*"/>
				</parameters>
			</method>
			<method name="parse_latency" symbol="gst_event_parse_latency">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
					<parameter name="latency" type="GstClockTime*"/>
				</parameters>
			</method>
			<method name="parse_new_segment" symbol="gst_event_parse_new_segment">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
					<parameter name="update" type="gboolean*"/>
					<parameter name="rate" type="gdouble*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="start" type="gint64*"/>
					<parameter name="stop" type="gint64*"/>
					<parameter name="position" type="gint64*"/>
				</parameters>
			</method>
			<method name="parse_new_segment_full" symbol="gst_event_parse_new_segment_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
					<parameter name="update" type="gboolean*"/>
					<parameter name="rate" type="gdouble*"/>
					<parameter name="applied_rate" type="gdouble*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="start" type="gint64*"/>
					<parameter name="stop" type="gint64*"/>
					<parameter name="position" type="gint64*"/>
				</parameters>
			</method>
			<method name="parse_qos" symbol="gst_event_parse_qos">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
					<parameter name="proportion" type="gdouble*"/>
					<parameter name="diff" type="GstClockTimeDiff*"/>
					<parameter name="timestamp" type="GstClockTime*"/>
				</parameters>
			</method>
			<method name="parse_seek" symbol="gst_event_parse_seek">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
					<parameter name="rate" type="gdouble*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="flags" type="GstSeekFlags*"/>
					<parameter name="start_type" type="GstSeekType*"/>
					<parameter name="start" type="gint64*"/>
					<parameter name="stop_type" type="GstSeekType*"/>
					<parameter name="stop" type="gint64*"/>
				</parameters>
			</method>
			<method name="parse_tag" symbol="gst_event_parse_tag">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
					<parameter name="taglist" type="GstTagList**"/>
				</parameters>
			</method>
			<method name="type_get_flags" symbol="gst_event_type_get_flags">
				<return-type type="GstEventTypeFlags"/>
				<parameters>
					<parameter name="type" type="GstEventType"/>
				</parameters>
			</method>
			<method name="type_get_name" symbol="gst_event_type_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="type" type="GstEventType"/>
				</parameters>
			</method>
			<method name="type_to_quark" symbol="gst_event_type_to_quark">
				<return-type type="GQuark"/>
				<parameters>
					<parameter name="type" type="GstEventType"/>
				</parameters>
			</method>
			<field name="mini_object" type="GstMiniObject"/>
			<field name="type" type="GstEventType"/>
			<field name="timestamp" type="guint64"/>
			<field name="src" type="GstObject*"/>
			<field name="structure" type="GstStructure*"/>
			<field name="_gst_reserved" type="gpointer"/>
		</struct>
		<struct name="GstEventClass">
			<field name="mini_object_class" type="GstMiniObjectClass"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstFormatDefinition">
			<field name="value" type="GstFormat"/>
			<field name="nick" type="gchar*"/>
			<field name="description" type="gchar*"/>
			<field name="quark" type="GQuark"/>
		</struct>
		<struct name="GstIndexAssociation">
			<field name="format" type="GstFormat"/>
			<field name="value" type="gint64"/>
		</struct>
		<struct name="GstIndexGroup">
			<field name="groupnum" type="gint"/>
			<field name="entries" type="GList*"/>
			<field name="certainty" type="GstIndexCertainty"/>
			<field name="peergroup" type="gint"/>
		</struct>
		<struct name="GstIterator">
			<method name="filter" symbol="gst_iterator_filter">
				<return-type type="GstIterator*"/>
				<parameters>
					<parameter name="it" type="GstIterator*"/>
					<parameter name="func" type="GCompareFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="find_custom" symbol="gst_iterator_find_custom">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="it" type="GstIterator*"/>
					<parameter name="func" type="GCompareFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="fold" symbol="gst_iterator_fold">
				<return-type type="GstIteratorResult"/>
				<parameters>
					<parameter name="it" type="GstIterator*"/>
					<parameter name="func" type="GstIteratorFoldFunction"/>
					<parameter name="ret" type="GValue*"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="foreach" symbol="gst_iterator_foreach">
				<return-type type="GstIteratorResult"/>
				<parameters>
					<parameter name="it" type="GstIterator*"/>
					<parameter name="func" type="GFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_iterator_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="it" type="GstIterator*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_iterator_new">
				<return-type type="GstIterator*"/>
				<parameters>
					<parameter name="size" type="guint"/>
					<parameter name="type" type="GType"/>
					<parameter name="lock" type="GMutex*"/>
					<parameter name="master_cookie" type="guint32*"/>
					<parameter name="next" type="GstIteratorNextFunction"/>
					<parameter name="item" type="GstIteratorItemFunction"/>
					<parameter name="resync" type="GstIteratorResyncFunction"/>
					<parameter name="free" type="GstIteratorFreeFunction"/>
				</parameters>
			</method>
			<method name="new_list" symbol="gst_iterator_new_list">
				<return-type type="GstIterator*"/>
				<parameters>
					<parameter name="type" type="GType"/>
					<parameter name="lock" type="GMutex*"/>
					<parameter name="master_cookie" type="guint32*"/>
					<parameter name="list" type="GList**"/>
					<parameter name="owner" type="gpointer"/>
					<parameter name="item" type="GstIteratorItemFunction"/>
					<parameter name="free" type="GstIteratorDisposeFunction"/>
				</parameters>
			</method>
			<method name="next" symbol="gst_iterator_next">
				<return-type type="GstIteratorResult"/>
				<parameters>
					<parameter name="it" type="GstIterator*"/>
					<parameter name="elem" type="gpointer*"/>
				</parameters>
			</method>
			<method name="push" symbol="gst_iterator_push">
				<return-type type="void"/>
				<parameters>
					<parameter name="it" type="GstIterator*"/>
					<parameter name="other" type="GstIterator*"/>
				</parameters>
			</method>
			<method name="resync" symbol="gst_iterator_resync">
				<return-type type="void"/>
				<parameters>
					<parameter name="it" type="GstIterator*"/>
				</parameters>
			</method>
			<field name="next" type="GstIteratorNextFunction"/>
			<field name="item" type="GstIteratorItemFunction"/>
			<field name="resync" type="GstIteratorResyncFunction"/>
			<field name="free" type="GstIteratorFreeFunction"/>
			<field name="pushed" type="GstIterator*"/>
			<field name="type" type="GType"/>
			<field name="lock" type="GMutex*"/>
			<field name="cookie" type="guint32"/>
			<field name="master_cookie" type="guint32*"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstMessage">
			<method name="get_structure" symbol="gst_message_get_structure">
				<return-type type="GstStructure*"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
				</parameters>
			</method>
			<method name="new_application" symbol="gst_message_new_application">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="new_async_done" symbol="gst_message_new_async_done">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
				</parameters>
			</method>
			<method name="new_async_start" symbol="gst_message_new_async_start">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="new_base_time" type="gboolean"/>
				</parameters>
			</method>
			<method name="new_buffering" symbol="gst_message_new_buffering">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="percent" type="gint"/>
				</parameters>
			</method>
			<method name="new_clock_lost" symbol="gst_message_new_clock_lost">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</method>
			<method name="new_clock_provide" symbol="gst_message_new_clock_provide">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="ready" type="gboolean"/>
				</parameters>
			</method>
			<method name="new_custom" symbol="gst_message_new_custom">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="type" type="GstMessageType"/>
					<parameter name="src" type="GstObject*"/>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="new_duration" symbol="gst_message_new_duration">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="duration" type="gint64"/>
				</parameters>
			</method>
			<method name="new_element" symbol="gst_message_new_element">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="new_eos" symbol="gst_message_new_eos">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
				</parameters>
			</method>
			<method name="new_error" symbol="gst_message_new_error">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="error" type="GError*"/>
					<parameter name="debug" type="gchar*"/>
				</parameters>
			</method>
			<method name="new_info" symbol="gst_message_new_info">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="error" type="GError*"/>
					<parameter name="debug" type="gchar*"/>
				</parameters>
			</method>
			<method name="new_latency" symbol="gst_message_new_latency">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
				</parameters>
			</method>
			<method name="new_new_clock" symbol="gst_message_new_new_clock">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</method>
			<method name="new_segment_done" symbol="gst_message_new_segment_done">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="position" type="gint64"/>
				</parameters>
			</method>
			<method name="new_segment_start" symbol="gst_message_new_segment_start">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="position" type="gint64"/>
				</parameters>
			</method>
			<method name="new_state_changed" symbol="gst_message_new_state_changed">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="oldstate" type="GstState"/>
					<parameter name="newstate" type="GstState"/>
					<parameter name="pending" type="GstState"/>
				</parameters>
			</method>
			<method name="new_state_dirty" symbol="gst_message_new_state_dirty">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
				</parameters>
			</method>
			<method name="new_tag" symbol="gst_message_new_tag">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="tag_list" type="GstTagList*"/>
				</parameters>
			</method>
			<method name="new_warning" symbol="gst_message_new_warning">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="error" type="GError*"/>
					<parameter name="debug" type="gchar*"/>
				</parameters>
			</method>
			<method name="parse_async_start" symbol="gst_message_parse_async_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="new_base_time" type="gboolean*"/>
				</parameters>
			</method>
			<method name="parse_buffering" symbol="gst_message_parse_buffering">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="percent" type="gint*"/>
				</parameters>
			</method>
			<method name="parse_clock_lost" symbol="gst_message_parse_clock_lost">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="clock" type="GstClock**"/>
				</parameters>
			</method>
			<method name="parse_clock_provide" symbol="gst_message_parse_clock_provide">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="clock" type="GstClock**"/>
					<parameter name="ready" type="gboolean*"/>
				</parameters>
			</method>
			<method name="parse_duration" symbol="gst_message_parse_duration">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="duration" type="gint64*"/>
				</parameters>
			</method>
			<method name="parse_error" symbol="gst_message_parse_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="gerror" type="GError**"/>
					<parameter name="debug" type="gchar**"/>
				</parameters>
			</method>
			<method name="parse_info" symbol="gst_message_parse_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="gerror" type="GError**"/>
					<parameter name="debug" type="gchar**"/>
				</parameters>
			</method>
			<method name="parse_new_clock" symbol="gst_message_parse_new_clock">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="clock" type="GstClock**"/>
				</parameters>
			</method>
			<method name="parse_segment_done" symbol="gst_message_parse_segment_done">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="position" type="gint64*"/>
				</parameters>
			</method>
			<method name="parse_segment_start" symbol="gst_message_parse_segment_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="position" type="gint64*"/>
				</parameters>
			</method>
			<method name="parse_state_changed" symbol="gst_message_parse_state_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="oldstate" type="GstState*"/>
					<parameter name="newstate" type="GstState*"/>
					<parameter name="pending" type="GstState*"/>
				</parameters>
			</method>
			<method name="parse_tag" symbol="gst_message_parse_tag">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="tag_list" type="GstTagList**"/>
				</parameters>
			</method>
			<method name="parse_warning" symbol="gst_message_parse_warning">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="gerror" type="GError**"/>
					<parameter name="debug" type="gchar**"/>
				</parameters>
			</method>
			<method name="type_get_name" symbol="gst_message_type_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="type" type="GstMessageType"/>
				</parameters>
			</method>
			<method name="type_to_quark" symbol="gst_message_type_to_quark">
				<return-type type="GQuark"/>
				<parameters>
					<parameter name="type" type="GstMessageType"/>
				</parameters>
			</method>
			<field name="mini_object" type="GstMiniObject"/>
			<field name="lock" type="GMutex*"/>
			<field name="cond" type="GCond*"/>
			<field name="type" type="GstMessageType"/>
			<field name="timestamp" type="guint64"/>
			<field name="src" type="GstObject*"/>
			<field name="structure" type="GstStructure*"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstMessageClass">
			<field name="mini_object_class" type="GstMiniObjectClass"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstMiniObject">
			<method name="copy" symbol="gst_mini_object_copy">
				<return-type type="GstMiniObject*"/>
				<parameters>
					<parameter name="mini_object" type="GstMiniObject*"/>
				</parameters>
			</method>
			<method name="is_writable" symbol="gst_mini_object_is_writable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mini_object" type="GstMiniObject*"/>
				</parameters>
			</method>
			<method name="make_writable" symbol="gst_mini_object_make_writable">
				<return-type type="GstMiniObject*"/>
				<parameters>
					<parameter name="mini_object" type="GstMiniObject*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_mini_object_new">
				<return-type type="GstMiniObject*"/>
				<parameters>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="ref" symbol="gst_mini_object_ref">
				<return-type type="GstMiniObject*"/>
				<parameters>
					<parameter name="mini_object" type="GstMiniObject*"/>
				</parameters>
			</method>
			<method name="replace" symbol="gst_mini_object_replace">
				<return-type type="void"/>
				<parameters>
					<parameter name="olddata" type="GstMiniObject**"/>
					<parameter name="newdata" type="GstMiniObject*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gst_mini_object_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="mini_object" type="GstMiniObject*"/>
				</parameters>
			</method>
			<field name="instance" type="GTypeInstance"/>
			<field name="refcount" type="gint"/>
			<field name="flags" type="guint"/>
			<field name="_gst_reserved" type="gpointer"/>
		</struct>
		<struct name="GstMiniObjectClass">
			<field name="type_class" type="GTypeClass"/>
			<field name="copy" type="GstMiniObjectCopyFunction"/>
			<field name="finalize" type="GstMiniObjectFinalizeFunction"/>
			<field name="_gst_reserved" type="gpointer"/>
		</struct>
		<struct name="GstParamSpecFraction">
			<field name="parent_instance" type="GParamSpec"/>
			<field name="min_num" type="gint"/>
			<field name="min_den" type="gint"/>
			<field name="max_num" type="gint"/>
			<field name="max_den" type="gint"/>
			<field name="def_num" type="gint"/>
			<field name="def_den" type="gint"/>
		</struct>
		<struct name="GstPluginDesc">
			<field name="major_version" type="gint"/>
			<field name="minor_version" type="gint"/>
			<field name="name" type="gchar*"/>
			<field name="description" type="gchar*"/>
			<field name="plugin_init" type="GstPluginInitFunc"/>
			<field name="version" type="gchar*"/>
			<field name="license" type="gchar*"/>
			<field name="source" type="gchar*"/>
			<field name="package" type="gchar*"/>
			<field name="origin" type="gchar*"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstQuery">
			<method name="get_structure" symbol="gst_query_get_structure">
				<return-type type="GstStructure*"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
				</parameters>
			</method>
			<method name="new_application" symbol="gst_query_new_application">
				<return-type type="GstQuery*"/>
				<parameters>
					<parameter name="type" type="GstQueryType"/>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="new_convert" symbol="gst_query_new_convert">
				<return-type type="GstQuery*"/>
				<parameters>
					<parameter name="src_format" type="GstFormat"/>
					<parameter name="value" type="gint64"/>
					<parameter name="dest_format" type="GstFormat"/>
				</parameters>
			</method>
			<method name="new_duration" symbol="gst_query_new_duration">
				<return-type type="GstQuery*"/>
				<parameters>
					<parameter name="format" type="GstFormat"/>
				</parameters>
			</method>
			<method name="new_formats" symbol="gst_query_new_formats">
				<return-type type="GstQuery*"/>
			</method>
			<method name="new_latency" symbol="gst_query_new_latency">
				<return-type type="GstQuery*"/>
			</method>
			<method name="new_position" symbol="gst_query_new_position">
				<return-type type="GstQuery*"/>
				<parameters>
					<parameter name="format" type="GstFormat"/>
				</parameters>
			</method>
			<method name="new_seeking" symbol="gst_query_new_seeking">
				<return-type type="GstQuery*"/>
				<parameters>
					<parameter name="format" type="GstFormat"/>
				</parameters>
			</method>
			<method name="new_segment" symbol="gst_query_new_segment">
				<return-type type="GstQuery*"/>
				<parameters>
					<parameter name="format" type="GstFormat"/>
				</parameters>
			</method>
			<method name="parse_convert" symbol="gst_query_parse_convert">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="src_format" type="GstFormat*"/>
					<parameter name="src_value" type="gint64*"/>
					<parameter name="dest_format" type="GstFormat*"/>
					<parameter name="dest_value" type="gint64*"/>
				</parameters>
			</method>
			<method name="parse_duration" symbol="gst_query_parse_duration">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="duration" type="gint64*"/>
				</parameters>
			</method>
			<method name="parse_formats_length" symbol="gst_query_parse_formats_length">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="n_formats" type="guint*"/>
				</parameters>
			</method>
			<method name="parse_formats_nth" symbol="gst_query_parse_formats_nth">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="nth" type="guint"/>
					<parameter name="format" type="GstFormat*"/>
				</parameters>
			</method>
			<method name="parse_latency" symbol="gst_query_parse_latency">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="live" type="gboolean*"/>
					<parameter name="min_latency" type="GstClockTime*"/>
					<parameter name="max_latency" type="GstClockTime*"/>
				</parameters>
			</method>
			<method name="parse_position" symbol="gst_query_parse_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="cur" type="gint64*"/>
				</parameters>
			</method>
			<method name="parse_seeking" symbol="gst_query_parse_seeking">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="seekable" type="gboolean*"/>
					<parameter name="segment_start" type="gint64*"/>
					<parameter name="segment_end" type="gint64*"/>
				</parameters>
			</method>
			<method name="parse_segment" symbol="gst_query_parse_segment">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="rate" type="gdouble*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="start_value" type="gint64*"/>
					<parameter name="stop_value" type="gint64*"/>
				</parameters>
			</method>
			<method name="set_convert" symbol="gst_query_set_convert">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="src_format" type="GstFormat"/>
					<parameter name="src_value" type="gint64"/>
					<parameter name="dest_format" type="GstFormat"/>
					<parameter name="dest_value" type="gint64"/>
				</parameters>
			</method>
			<method name="set_duration" symbol="gst_query_set_duration">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="duration" type="gint64"/>
				</parameters>
			</method>
			<method name="set_formats" symbol="gst_query_set_formats">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="n_formats" type="gint"/>
				</parameters>
			</method>
			<method name="set_formatsv" symbol="gst_query_set_formatsv">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="n_formats" type="gint"/>
					<parameter name="formats" type="GstFormat*"/>
				</parameters>
			</method>
			<method name="set_latency" symbol="gst_query_set_latency">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="live" type="gboolean"/>
					<parameter name="min_latency" type="GstClockTime"/>
					<parameter name="max_latency" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="set_position" symbol="gst_query_set_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="cur" type="gint64"/>
				</parameters>
			</method>
			<method name="set_seeking" symbol="gst_query_set_seeking">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="seekable" type="gboolean"/>
					<parameter name="segment_start" type="gint64"/>
					<parameter name="segment_end" type="gint64"/>
				</parameters>
			</method>
			<method name="set_segment" symbol="gst_query_set_segment">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="rate" type="gdouble"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="start_value" type="gint64"/>
					<parameter name="stop_value" type="gint64"/>
				</parameters>
			</method>
			<method name="type_get_by_nick" symbol="gst_query_type_get_by_nick">
				<return-type type="GstQueryType"/>
				<parameters>
					<parameter name="nick" type="gchar*"/>
				</parameters>
			</method>
			<method name="type_get_details" symbol="gst_query_type_get_details">
				<return-type type="GstQueryTypeDefinition*"/>
				<parameters>
					<parameter name="type" type="GstQueryType"/>
				</parameters>
			</method>
			<method name="type_get_name" symbol="gst_query_type_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="query" type="GstQueryType"/>
				</parameters>
			</method>
			<method name="type_iterate_definitions" symbol="gst_query_type_iterate_definitions">
				<return-type type="GstIterator*"/>
			</method>
			<method name="type_register" symbol="gst_query_type_register">
				<return-type type="GstQueryType"/>
				<parameters>
					<parameter name="nick" type="gchar*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</method>
			<method name="type_to_quark" symbol="gst_query_type_to_quark">
				<return-type type="GQuark"/>
				<parameters>
					<parameter name="query" type="GstQueryType"/>
				</parameters>
			</method>
			<method name="types_contains" symbol="gst_query_types_contains">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="types" type="GstQueryType*"/>
					<parameter name="type" type="GstQueryType"/>
				</parameters>
			</method>
			<field name="mini_object" type="GstMiniObject"/>
			<field name="type" type="GstQueryType"/>
			<field name="structure" type="GstStructure*"/>
			<field name="_gst_reserved" type="gpointer"/>
		</struct>
		<struct name="GstQueryClass">
			<field name="mini_object_class" type="GstMiniObjectClass"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstQueryTypeDefinition">
			<field name="value" type="GstQueryType"/>
			<field name="nick" type="gchar*"/>
			<field name="description" type="gchar*"/>
			<field name="quark" type="GQuark"/>
		</struct>
		<struct name="GstStaticCaps">
			<method name="get" symbol="gst_static_caps_get">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="static_caps" type="GstStaticCaps*"/>
				</parameters>
			</method>
			<field name="caps" type="GstCaps"/>
			<field name="string" type="char*"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstStaticPadTemplate">
			<method name="get" symbol="gst_static_pad_template_get">
				<return-type type="GstPadTemplate*"/>
				<parameters>
					<parameter name="pad_template" type="GstStaticPadTemplate*"/>
				</parameters>
			</method>
			<method name="get_caps" symbol="gst_static_pad_template_get_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="templ" type="GstStaticPadTemplate*"/>
				</parameters>
			</method>
			<field name="name_template" type="gchar*"/>
			<field name="direction" type="GstPadDirection"/>
			<field name="presence" type="GstPadPresence"/>
			<field name="static_caps" type="GstStaticCaps"/>
		</struct>
		<struct name="GstTagList">
			<method name="add" symbol="gst_tag_list_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="mode" type="GstTagMergeMode"/>
					<parameter name="tag" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_valist" symbol="gst_tag_list_add_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="mode" type="GstTagMergeMode"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</method>
			<method name="add_valist_values" symbol="gst_tag_list_add_valist_values">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="mode" type="GstTagMergeMode"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</method>
			<method name="add_values" symbol="gst_tag_list_add_values">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="mode" type="GstTagMergeMode"/>
					<parameter name="tag" type="gchar*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gst_tag_list_copy">
				<return-type type="GstTagList*"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
				</parameters>
			</method>
			<method name="copy_value" symbol="gst_tag_list_copy_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dest" type="GValue*"/>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
				</parameters>
			</method>
			<method name="foreach" symbol="gst_tag_list_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="func" type="GstTagForeachFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_tag_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
				</parameters>
			</method>
			<method name="get_boolean" symbol="gst_tag_list_get_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="gboolean*"/>
				</parameters>
			</method>
			<method name="get_boolean_index" symbol="gst_tag_list_get_boolean_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="gboolean*"/>
				</parameters>
			</method>
			<method name="get_char" symbol="gst_tag_list_get_char">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_char_index" symbol="gst_tag_list_get_char_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_date" symbol="gst_tag_list_get_date">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="GDate**"/>
				</parameters>
			</method>
			<method name="get_date_index" symbol="gst_tag_list_get_date_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="GDate**"/>
				</parameters>
			</method>
			<method name="get_double" symbol="gst_tag_list_get_double">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_double_index" symbol="gst_tag_list_get_double_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_float" symbol="gst_tag_list_get_float">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_float_index" symbol="gst_tag_list_get_float_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_int" symbol="gst_tag_list_get_int">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="gint*"/>
				</parameters>
			</method>
			<method name="get_int64" symbol="gst_tag_list_get_int64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="gint64*"/>
				</parameters>
			</method>
			<method name="get_int64_index" symbol="gst_tag_list_get_int64_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="gint64*"/>
				</parameters>
			</method>
			<method name="get_int_index" symbol="gst_tag_list_get_int_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="gint*"/>
				</parameters>
			</method>
			<method name="get_long" symbol="gst_tag_list_get_long">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="glong*"/>
				</parameters>
			</method>
			<method name="get_long_index" symbol="gst_tag_list_get_long_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="glong*"/>
				</parameters>
			</method>
			<method name="get_pointer" symbol="gst_tag_list_get_pointer">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="gpointer*"/>
				</parameters>
			</method>
			<method name="get_pointer_index" symbol="gst_tag_list_get_pointer_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="gpointer*"/>
				</parameters>
			</method>
			<method name="get_string" symbol="gst_tag_list_get_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="gchar**"/>
				</parameters>
			</method>
			<method name="get_string_index" symbol="gst_tag_list_get_string_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="gchar**"/>
				</parameters>
			</method>
			<method name="get_tag_size" symbol="gst_tag_list_get_tag_size">
				<return-type type="guint"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_uchar" symbol="gst_tag_list_get_uchar">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="guchar*"/>
				</parameters>
			</method>
			<method name="get_uchar_index" symbol="gst_tag_list_get_uchar_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="guchar*"/>
				</parameters>
			</method>
			<method name="get_uint" symbol="gst_tag_list_get_uint">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="guint*"/>
				</parameters>
			</method>
			<method name="get_uint64" symbol="gst_tag_list_get_uint64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="guint64*"/>
				</parameters>
			</method>
			<method name="get_uint64_index" symbol="gst_tag_list_get_uint64_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="guint64*"/>
				</parameters>
			</method>
			<method name="get_uint_index" symbol="gst_tag_list_get_uint_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="guint*"/>
				</parameters>
			</method>
			<method name="get_ulong" symbol="gst_tag_list_get_ulong">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="value" type="gulong*"/>
				</parameters>
			</method>
			<method name="get_ulong_index" symbol="gst_tag_list_get_ulong_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
					<parameter name="value" type="gulong*"/>
				</parameters>
			</method>
			<method name="get_value_index" symbol="gst_tag_list_get_value_index">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
					<parameter name="index" type="guint"/>
				</parameters>
			</method>
			<method name="insert" symbol="gst_tag_list_insert">
				<return-type type="void"/>
				<parameters>
					<parameter name="into" type="GstTagList*"/>
					<parameter name="from" type="GstTagList*"/>
					<parameter name="mode" type="GstTagMergeMode"/>
				</parameters>
			</method>
			<method name="is_empty" symbol="gst_tag_list_is_empty">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
				</parameters>
			</method>
			<method name="merge" symbol="gst_tag_list_merge">
				<return-type type="GstTagList*"/>
				<parameters>
					<parameter name="list1" type="GstTagList*"/>
					<parameter name="list2" type="GstTagList*"/>
					<parameter name="mode" type="GstTagMergeMode"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_tag_list_new">
				<return-type type="GstTagList*"/>
			</method>
			<method name="remove_tag" symbol="gst_tag_list_remove_tag">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GstTagList*"/>
					<parameter name="tag" type="gchar*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstTrace">
			<method name="destroy" symbol="gst_trace_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="trace" type="GstTrace*"/>
				</parameters>
			</method>
			<method name="flush" symbol="gst_trace_flush">
				<return-type type="void"/>
				<parameters>
					<parameter name="trace" type="GstTrace*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_trace_new">
				<return-type type="GstTrace*"/>
				<parameters>
					<parameter name="filename" type="gchar*"/>
					<parameter name="size" type="gint"/>
				</parameters>
			</method>
			<method name="read_tsc" symbol="gst_trace_read_tsc">
				<return-type type="void"/>
				<parameters>
					<parameter name="dst" type="gint64*"/>
				</parameters>
			</method>
			<method name="set_default" symbol="gst_trace_set_default">
				<return-type type="void"/>
				<parameters>
					<parameter name="trace" type="GstTrace*"/>
				</parameters>
			</method>
			<method name="text_flush" symbol="gst_trace_text_flush">
				<return-type type="void"/>
				<parameters>
					<parameter name="trace" type="GstTrace*"/>
				</parameters>
			</method>
			<field name="filename" type="gchar*"/>
			<field name="fd" type="int"/>
			<field name="buf" type="GstTraceEntry*"/>
			<field name="bufsize" type="gint"/>
			<field name="bufoffset" type="gint"/>
		</struct>
		<struct name="GstTraceEntry">
			<field name="timestamp" type="gint64"/>
			<field name="sequence" type="guint32"/>
			<field name="data" type="guint32"/>
			<field name="message" type="gchar[]"/>
		</struct>
		<struct name="GstTypeFind">
			<method name="get_length" symbol="gst_type_find_get_length">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="find" type="GstTypeFind*"/>
				</parameters>
			</method>
			<method name="helper" symbol="gst_type_find_helper">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="src" type="GstPad*"/>
					<parameter name="size" type="guint64"/>
				</parameters>
			</method>
			<method name="helper_for_buffer" symbol="gst_type_find_helper_for_buffer">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="obj" type="GstObject*"/>
					<parameter name="buf" type="GstBuffer*"/>
					<parameter name="prob" type="GstTypeFindProbability*"/>
				</parameters>
			</method>
			<method name="helper_get_range" symbol="gst_type_find_helper_get_range">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="obj" type="GstObject*"/>
					<parameter name="func" type="GstTypeFindHelperGetRangeFunction"/>
					<parameter name="size" type="guint64"/>
					<parameter name="prob" type="GstTypeFindProbability*"/>
				</parameters>
			</method>
			<method name="peek" symbol="gst_type_find_peek">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="find" type="GstTypeFind*"/>
					<parameter name="offset" type="gint64"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="register" symbol="gst_type_find_register">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="rank" type="guint"/>
					<parameter name="func" type="GstTypeFindFunction"/>
					<parameter name="extensions" type="gchar**"/>
					<parameter name="possible_caps" type="GstCaps*"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="data_notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="suggest" symbol="gst_type_find_suggest">
				<return-type type="void"/>
				<parameters>
					<parameter name="find" type="GstTypeFind*"/>
					<parameter name="probability" type="guint"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<field name="peek" type="GCallback"/>
			<field name="suggest" type="GCallback"/>
			<field name="data" type="gpointer"/>
			<field name="get_length" type="GCallback"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstTypeNameData">
			<field name="name" type="gchar*"/>
			<field name="type" type="GType"/>
		</struct>
		<struct name="GstValueTable">
			<field name="type" type="GType"/>
			<field name="compare" type="GstValueCompareFunc"/>
			<field name="serialize" type="GstValueSerializeFunc"/>
			<field name="deserialize" type="GstValueDeserializeFunc"/>
			<field name="_gst_reserved" type="void*[]"/>
		</struct>
		<boxed name="GstCaps" type-name="GstCaps" get-type="gst_caps_get_type">
			<method name="append" symbol="gst_caps_append">
				<return-type type="void"/>
				<parameters>
					<parameter name="caps1" type="GstCaps*"/>
					<parameter name="caps2" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="append_structure" symbol="gst_caps_append_structure">
				<return-type type="void"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gst_caps_copy">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="copy_nth" symbol="gst_caps_copy_nth">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="nth" type="guint"/>
				</parameters>
			</method>
			<method name="do_simplify" symbol="gst_caps_do_simplify">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="from_string" symbol="gst_caps_from_string">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="string" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gst_caps_get_size">
				<return-type type="guint"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="get_structure" symbol="gst_caps_get_structure">
				<return-type type="GstStructure*"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="index" type="guint"/>
				</parameters>
			</method>
			<method name="intersect" symbol="gst_caps_intersect">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="caps1" type="GstCaps*"/>
					<parameter name="caps2" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="is_always_compatible" symbol="gst_caps_is_always_compatible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="caps1" type="GstCaps*"/>
					<parameter name="caps2" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="is_any" symbol="gst_caps_is_any">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="is_empty" symbol="gst_caps_is_empty">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="is_equal" symbol="gst_caps_is_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="caps1" type="GstCaps*"/>
					<parameter name="caps2" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="is_equal_fixed" symbol="gst_caps_is_equal_fixed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="caps1" type="GstCaps*"/>
					<parameter name="caps2" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="is_fixed" symbol="gst_caps_is_fixed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="is_subset" symbol="gst_caps_is_subset">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="subset" type="GstCaps*"/>
					<parameter name="superset" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="load_thyself" symbol="gst_caps_load_thyself">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="parent" type="xmlNodePtr"/>
				</parameters>
			</method>
			<method name="make_writable" symbol="gst_caps_make_writable">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="merge" symbol="gst_caps_merge">
				<return-type type="void"/>
				<parameters>
					<parameter name="caps1" type="GstCaps*"/>
					<parameter name="caps2" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="merge_structure" symbol="gst_caps_merge_structure">
				<return-type type="void"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<constructor name="new_any" symbol="gst_caps_new_any">
				<return-type type="GstCaps*"/>
			</constructor>
			<constructor name="new_empty" symbol="gst_caps_new_empty">
				<return-type type="GstCaps*"/>
			</constructor>
			<constructor name="new_full" symbol="gst_caps_new_full">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="struct1" type="GstStructure*"/>
				</parameters>
			</constructor>
			<constructor name="new_full_valist" symbol="gst_caps_new_full_valist">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</constructor>
			<constructor name="new_simple" symbol="gst_caps_new_simple">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="media_type" type="char*"/>
					<parameter name="fieldname" type="char*"/>
				</parameters>
			</constructor>
			<method name="normalize" symbol="gst_caps_normalize">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="ref" symbol="gst_caps_ref">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="remove_structure" symbol="gst_caps_remove_structure">
				<return-type type="void"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="idx" type="guint"/>
				</parameters>
			</method>
			<method name="replace" symbol="gst_caps_replace">
				<return-type type="void"/>
				<parameters>
					<parameter name="caps" type="GstCaps**"/>
					<parameter name="newcaps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="save_thyself" symbol="gst_caps_save_thyself">
				<return-type type="xmlNodePtr"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="parent" type="xmlNodePtr"/>
				</parameters>
			</method>
			<method name="set_simple" symbol="gst_caps_set_simple">
				<return-type type="void"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="field" type="char*"/>
				</parameters>
			</method>
			<method name="set_simple_valist" symbol="gst_caps_set_simple_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="field" type="char*"/>
					<parameter name="varargs" type="va_list"/>
				</parameters>
			</method>
			<method name="subtract" symbol="gst_caps_subtract">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="minuend" type="GstCaps*"/>
					<parameter name="subtrahend" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="gst_caps_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="truncate" symbol="gst_caps_truncate">
				<return-type type="void"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="union" symbol="gst_caps_union">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="caps1" type="GstCaps*"/>
					<parameter name="caps2" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gst_caps_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<field name="type" type="GType"/>
			<field name="refcount" type="gint"/>
			<field name="flags" type="GstCapsFlags"/>
			<field name="structs" type="GPtrArray*"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</boxed>
		<boxed name="GstDate" type-name="GstDate" get-type="gst_date_get_type">
		</boxed>
		<boxed name="GstGError" type-name="GstGError" get-type="gst_g_error_get_type">
		</boxed>
		<boxed name="GstIndexEntry" type-name="GstIndexEntry" get-type="gst_index_entry_get_type">
			<method name="assoc_map" symbol="gst_index_entry_assoc_map">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="GstIndexEntry*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="value" type="gint64*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gst_index_entry_copy">
				<return-type type="GstIndexEntry*"/>
				<parameters>
					<parameter name="entry" type="GstIndexEntry*"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_index_entry_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GstIndexEntry*"/>
				</parameters>
			</method>
			<field name="type" type="GstIndexEntryType"/>
			<field name="id" type="gint"/>
			<field name="data" type="gpointer"/>
		</boxed>
		<boxed name="GstSegment" type-name="GstSegment" get-type="gst_segment_get_type">
			<method name="clip" symbol="gst_segment_clip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="segment" type="GstSegment*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="start" type="gint64"/>
					<parameter name="stop" type="gint64"/>
					<parameter name="clip_start" type="gint64*"/>
					<parameter name="clip_stop" type="gint64*"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_segment_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="segment" type="GstSegment*"/>
				</parameters>
			</method>
			<method name="init" symbol="gst_segment_init">
				<return-type type="void"/>
				<parameters>
					<parameter name="segment" type="GstSegment*"/>
					<parameter name="format" type="GstFormat"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_segment_new">
				<return-type type="GstSegment*"/>
			</constructor>
			<method name="set_duration" symbol="gst_segment_set_duration">
				<return-type type="void"/>
				<parameters>
					<parameter name="segment" type="GstSegment*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="duration" type="gint64"/>
				</parameters>
			</method>
			<method name="set_last_stop" symbol="gst_segment_set_last_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="segment" type="GstSegment*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="position" type="gint64"/>
				</parameters>
			</method>
			<method name="set_newsegment" symbol="gst_segment_set_newsegment">
				<return-type type="void"/>
				<parameters>
					<parameter name="segment" type="GstSegment*"/>
					<parameter name="update" type="gboolean"/>
					<parameter name="rate" type="gdouble"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="start" type="gint64"/>
					<parameter name="stop" type="gint64"/>
					<parameter name="time" type="gint64"/>
				</parameters>
			</method>
			<method name="set_newsegment_full" symbol="gst_segment_set_newsegment_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="segment" type="GstSegment*"/>
					<parameter name="update" type="gboolean"/>
					<parameter name="rate" type="gdouble"/>
					<parameter name="applied_rate" type="gdouble"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="start" type="gint64"/>
					<parameter name="stop" type="gint64"/>
					<parameter name="time" type="gint64"/>
				</parameters>
			</method>
			<method name="set_seek" symbol="gst_segment_set_seek">
				<return-type type="void"/>
				<parameters>
					<parameter name="segment" type="GstSegment*"/>
					<parameter name="rate" type="gdouble"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="flags" type="GstSeekFlags"/>
					<parameter name="start_type" type="GstSeekType"/>
					<parameter name="start" type="gint64"/>
					<parameter name="stop_type" type="GstSeekType"/>
					<parameter name="stop" type="gint64"/>
					<parameter name="update" type="gboolean*"/>
				</parameters>
			</method>
			<method name="to_running_time" symbol="gst_segment_to_running_time">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="segment" type="GstSegment*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="position" type="gint64"/>
				</parameters>
			</method>
			<method name="to_stream_time" symbol="gst_segment_to_stream_time">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="segment" type="GstSegment*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="position" type="gint64"/>
				</parameters>
			</method>
			<field name="rate" type="gdouble"/>
			<field name="abs_rate" type="gdouble"/>
			<field name="format" type="GstFormat"/>
			<field name="flags" type="GstSeekFlags"/>
			<field name="start" type="gint64"/>
			<field name="stop" type="gint64"/>
			<field name="time" type="gint64"/>
			<field name="accum" type="gint64"/>
			<field name="last_stop" type="gint64"/>
			<field name="duration" type="gint64"/>
			<field name="applied_rate" type="gdouble"/>
			<field name="_gst_reserved" type="guint8[]"/>
		</boxed>
		<boxed name="GstStructure" type-name="GstStructure" get-type="gst_structure_get_type">
			<method name="copy" symbol="gst_structure_copy">
				<return-type type="GstStructure*"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="empty_new" symbol="gst_structure_empty_new">
				<return-type type="GstStructure*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="fixate_field_boolean" symbol="gst_structure_fixate_field_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="field_name" type="char*"/>
					<parameter name="target" type="gboolean"/>
				</parameters>
			</method>
			<method name="fixate_field_nearest_double" symbol="gst_structure_fixate_field_nearest_double">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="field_name" type="char*"/>
					<parameter name="target" type="double"/>
				</parameters>
			</method>
			<method name="fixate_field_nearest_fraction" symbol="gst_structure_fixate_field_nearest_fraction">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="field_name" type="char*"/>
					<parameter name="target_numerator" type="gint"/>
					<parameter name="target_denominator" type="gint"/>
				</parameters>
			</method>
			<method name="fixate_field_nearest_int" symbol="gst_structure_fixate_field_nearest_int">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="field_name" type="char*"/>
					<parameter name="target" type="int"/>
				</parameters>
			</method>
			<method name="foreach" symbol="gst_structure_foreach">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="func" type="GstStructureForeachFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_structure_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="from_string" symbol="gst_structure_from_string">
				<return-type type="GstStructure*"/>
				<parameters>
					<parameter name="string" type="gchar*"/>
					<parameter name="end" type="gchar**"/>
				</parameters>
			</method>
			<method name="get_boolean" symbol="gst_structure_get_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="value" type="gboolean*"/>
				</parameters>
			</method>
			<method name="get_clock_time" symbol="gst_structure_get_clock_time">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="value" type="GstClockTime*"/>
				</parameters>
			</method>
			<method name="get_date" symbol="gst_structure_get_date">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="value" type="GDate**"/>
				</parameters>
			</method>
			<method name="get_double" symbol="gst_structure_get_double">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="value" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_enum" symbol="gst_structure_get_enum">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="enumtype" type="GType"/>
					<parameter name="value" type="gint*"/>
				</parameters>
			</method>
			<method name="get_field_type" symbol="gst_structure_get_field_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_fourcc" symbol="gst_structure_get_fourcc">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="value" type="guint32*"/>
				</parameters>
			</method>
			<method name="get_fraction" symbol="gst_structure_get_fraction">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="value_numerator" type="gint*"/>
					<parameter name="value_denominator" type="gint*"/>
				</parameters>
			</method>
			<method name="get_int" symbol="gst_structure_get_int">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="value" type="gint*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gst_structure_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="get_name_id" symbol="gst_structure_get_name_id">
				<return-type type="GQuark"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="get_string" symbol="gst_structure_get_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_uint" symbol="gst_structure_get_uint">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="value" type="guint*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="gst_structure_get_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
				</parameters>
			</method>
			<method name="has_field" symbol="gst_structure_has_field">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
				</parameters>
			</method>
			<method name="has_field_typed" symbol="gst_structure_has_field_typed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="has_name" symbol="gst_structure_has_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="id_empty_new" symbol="gst_structure_id_empty_new">
				<return-type type="GstStructure*"/>
				<parameters>
					<parameter name="quark" type="GQuark"/>
				</parameters>
			</method>
			<method name="id_get_value" symbol="gst_structure_id_get_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="field" type="GQuark"/>
				</parameters>
			</method>
			<method name="id_set" symbol="gst_structure_id_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="GQuark"/>
				</parameters>
			</method>
			<method name="id_set_valist" symbol="gst_structure_id_set_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="GQuark"/>
					<parameter name="varargs" type="va_list"/>
				</parameters>
			</method>
			<method name="id_set_value" symbol="gst_structure_id_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="field" type="GQuark"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="map_in_place" symbol="gst_structure_map_in_place">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="func" type="GstStructureMapFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="n_fields" symbol="gst_structure_n_fields">
				<return-type type="gint"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_structure_new">
				<return-type type="GstStructure*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="firstfield" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_valist" symbol="gst_structure_new_valist">
				<return-type type="GstStructure*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="firstfield" type="gchar*"/>
					<parameter name="varargs" type="va_list"/>
				</parameters>
			</constructor>
			<method name="nth_field_name" symbol="gst_structure_nth_field_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="index" type="guint"/>
				</parameters>
			</method>
			<method name="remove_all_fields" symbol="gst_structure_remove_all_fields">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="remove_field" symbol="gst_structure_remove_field">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove_fields" symbol="gst_structure_remove_fields">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove_fields_valist" symbol="gst_structure_remove_fields_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="varargs" type="va_list"/>
				</parameters>
			</method>
			<method name="set" symbol="gst_structure_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="gst_structure_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_parent_refcount" symbol="gst_structure_set_parent_refcount">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="refcount" type="gint*"/>
				</parameters>
			</method>
			<method name="set_valist" symbol="gst_structure_set_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="varargs" type="va_list"/>
				</parameters>
			</method>
			<method name="set_value" symbol="gst_structure_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
					<parameter name="fieldname" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="gst_structure_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<field name="type" type="GType"/>
			<field name="name" type="GQuark"/>
			<field name="parent_refcount" type="gint*"/>
			<field name="fields" type="GArray*"/>
			<field name="_gst_reserved" type="gpointer"/>
		</boxed>
		<boxed name="GstTagList" type-name="GstTagList" get-type="gst_tag_list_get_type">
		</boxed>
		<enum name="GstActivateMode">
			<member name="GST_ACTIVATE_NONE" value="0"/>
			<member name="GST_ACTIVATE_PUSH" value="1"/>
			<member name="GST_ACTIVATE_PULL" value="2"/>
		</enum>
		<enum name="GstBaseSrcFlags">
			<member name="GST_BASE_SRC_STARTED" value="1048576"/>
			<member name="GST_BASE_SRC_FLAG_LAST" value="4194304"/>
		</enum>
		<enum name="GstBusSyncReply">
			<member name="GST_BUS_DROP" value="0"/>
			<member name="GST_BUS_PASS" value="1"/>
			<member name="GST_BUS_ASYNC" value="2"/>
		</enum>
		<enum name="GstClockEntryType">
			<member name="GST_CLOCK_ENTRY_SINGLE" value="0"/>
			<member name="GST_CLOCK_ENTRY_PERIODIC" value="1"/>
		</enum>
		<enum name="GstClockReturn">
			<member name="GST_CLOCK_OK" value="0"/>
			<member name="GST_CLOCK_EARLY" value="1"/>
			<member name="GST_CLOCK_UNSCHEDULED" value="2"/>
			<member name="GST_CLOCK_BUSY" value="3"/>
			<member name="GST_CLOCK_BADTIME" value="4"/>
			<member name="GST_CLOCK_ERROR" value="5"/>
			<member name="GST_CLOCK_UNSUPPORTED" value="6"/>
		</enum>
		<enum name="GstCoreError">
			<member name="GST_CORE_ERROR_FAILED" value="1"/>
			<member name="GST_CORE_ERROR_TOO_LAZY" value="2"/>
			<member name="GST_CORE_ERROR_NOT_IMPLEMENTED" value="3"/>
			<member name="GST_CORE_ERROR_STATE_CHANGE" value="4"/>
			<member name="GST_CORE_ERROR_PAD" value="5"/>
			<member name="GST_CORE_ERROR_THREAD" value="6"/>
			<member name="GST_CORE_ERROR_NEGOTIATION" value="7"/>
			<member name="GST_CORE_ERROR_EVENT" value="8"/>
			<member name="GST_CORE_ERROR_SEEK" value="9"/>
			<member name="GST_CORE_ERROR_CAPS" value="10"/>
			<member name="GST_CORE_ERROR_TAG" value="11"/>
			<member name="GST_CORE_ERROR_MISSING_PLUGIN" value="12"/>
			<member name="GST_CORE_ERROR_CLOCK" value="13"/>
			<member name="GST_CORE_ERROR_DISABLED" value="14"/>
			<member name="GST_CORE_ERROR_NUM_ERRORS" value="15"/>
		</enum>
		<enum name="GstDebugColorFlags">
			<member name="GST_DEBUG_FG_BLACK" value="0"/>
			<member name="GST_DEBUG_FG_RED" value="1"/>
			<member name="GST_DEBUG_FG_GREEN" value="2"/>
			<member name="GST_DEBUG_FG_YELLOW" value="3"/>
			<member name="GST_DEBUG_FG_BLUE" value="4"/>
			<member name="GST_DEBUG_FG_MAGENTA" value="5"/>
			<member name="GST_DEBUG_FG_CYAN" value="6"/>
			<member name="GST_DEBUG_FG_WHITE" value="7"/>
			<member name="GST_DEBUG_BG_BLACK" value="0"/>
			<member name="GST_DEBUG_BG_RED" value="16"/>
			<member name="GST_DEBUG_BG_GREEN" value="32"/>
			<member name="GST_DEBUG_BG_YELLOW" value="48"/>
			<member name="GST_DEBUG_BG_BLUE" value="64"/>
			<member name="GST_DEBUG_BG_MAGENTA" value="80"/>
			<member name="GST_DEBUG_BG_CYAN" value="96"/>
			<member name="GST_DEBUG_BG_WHITE" value="112"/>
			<member name="GST_DEBUG_BOLD" value="256"/>
			<member name="GST_DEBUG_UNDERLINE" value="512"/>
		</enum>
		<enum name="GstDebugLevel">
			<member name="GST_LEVEL_NONE" value="0"/>
			<member name="GST_LEVEL_ERROR" value="1"/>
			<member name="GST_LEVEL_WARNING" value="2"/>
			<member name="GST_LEVEL_INFO" value="3"/>
			<member name="GST_LEVEL_DEBUG" value="4"/>
			<member name="GST_LEVEL_LOG" value="5"/>
			<member name="GST_LEVEL_COUNT" value="6"/>
		</enum>
		<enum name="GstEventType">
			<member name="GST_EVENT_UNKNOWN" value="0"/>
			<member name="GST_EVENT_FLUSH_START" value="19"/>
			<member name="GST_EVENT_FLUSH_STOP" value="39"/>
			<member name="GST_EVENT_EOS" value="86"/>
			<member name="GST_EVENT_NEWSEGMENT" value="102"/>
			<member name="GST_EVENT_TAG" value="118"/>
			<member name="GST_EVENT_BUFFERSIZE" value="134"/>
			<member name="GST_EVENT_QOS" value="241"/>
			<member name="GST_EVENT_SEEK" value="257"/>
			<member name="GST_EVENT_NAVIGATION" value="273"/>
			<member name="GST_EVENT_LATENCY" value="289"/>
			<member name="GST_EVENT_CUSTOM_UPSTREAM" value="513"/>
			<member name="GST_EVENT_CUSTOM_DOWNSTREAM" value="518"/>
			<member name="GST_EVENT_CUSTOM_DOWNSTREAM_OOB" value="514"/>
			<member name="GST_EVENT_CUSTOM_BOTH" value="519"/>
			<member name="GST_EVENT_CUSTOM_BOTH_OOB" value="515"/>
		</enum>
		<enum name="GstFlowReturn">
			<member name="GST_FLOW_CUSTOM_SUCCESS" value="100"/>
			<member name="GST_FLOW_RESEND" value="1"/>
			<member name="GST_FLOW_OK" value="0"/>
			<member name="GST_FLOW_NOT_LINKED" value="-1"/>
			<member name="GST_FLOW_WRONG_STATE" value="-2"/>
			<member name="GST_FLOW_UNEXPECTED" value="-3"/>
			<member name="GST_FLOW_NOT_NEGOTIATED" value="-4"/>
			<member name="GST_FLOW_ERROR" value="-5"/>
			<member name="GST_FLOW_NOT_SUPPORTED" value="-6"/>
			<member name="GST_FLOW_CUSTOM_ERROR" value="-100"/>
		</enum>
		<enum name="GstFormat">
			<member name="GST_FORMAT_UNDEFINED" value="0"/>
			<member name="GST_FORMAT_DEFAULT" value="1"/>
			<member name="GST_FORMAT_BYTES" value="2"/>
			<member name="GST_FORMAT_TIME" value="3"/>
			<member name="GST_FORMAT_BUFFERS" value="4"/>
			<member name="GST_FORMAT_PERCENT" value="5"/>
		</enum>
		<enum name="GstIndexCertainty">
			<member name="GST_INDEX_UNKNOWN" value="0"/>
			<member name="GST_INDEX_CERTAIN" value="1"/>
			<member name="GST_INDEX_FUZZY" value="2"/>
		</enum>
		<enum name="GstIndexEntryType">
			<member name="GST_INDEX_ENTRY_ID" value="0"/>
			<member name="GST_INDEX_ENTRY_ASSOCIATION" value="1"/>
			<member name="GST_INDEX_ENTRY_OBJECT" value="2"/>
			<member name="GST_INDEX_ENTRY_FORMAT" value="3"/>
		</enum>
		<enum name="GstIndexLookupMethod">
			<member name="GST_INDEX_LOOKUP_EXACT" value="0"/>
			<member name="GST_INDEX_LOOKUP_BEFORE" value="1"/>
			<member name="GST_INDEX_LOOKUP_AFTER" value="2"/>
		</enum>
		<enum name="GstIndexResolverMethod">
			<member name="GST_INDEX_RESOLVER_CUSTOM" value="0"/>
			<member name="GST_INDEX_RESOLVER_GTYPE" value="1"/>
			<member name="GST_INDEX_RESOLVER_PATH" value="2"/>
		</enum>
		<enum name="GstIteratorItem">
			<member name="GST_ITERATOR_ITEM_SKIP" value="0"/>
			<member name="GST_ITERATOR_ITEM_PASS" value="1"/>
			<member name="GST_ITERATOR_ITEM_END" value="2"/>
		</enum>
		<enum name="GstIteratorResult">
			<member name="GST_ITERATOR_DONE" value="0"/>
			<member name="GST_ITERATOR_OK" value="1"/>
			<member name="GST_ITERATOR_RESYNC" value="2"/>
			<member name="GST_ITERATOR_ERROR" value="3"/>
		</enum>
		<enum name="GstLibraryError">
			<member name="GST_LIBRARY_ERROR_FAILED" value="1"/>
			<member name="GST_LIBRARY_ERROR_TOO_LAZY" value="2"/>
			<member name="GST_LIBRARY_ERROR_INIT" value="3"/>
			<member name="GST_LIBRARY_ERROR_SHUTDOWN" value="4"/>
			<member name="GST_LIBRARY_ERROR_SETTINGS" value="5"/>
			<member name="GST_LIBRARY_ERROR_ENCODE" value="6"/>
			<member name="GST_LIBRARY_ERROR_NUM_ERRORS" value="7"/>
		</enum>
		<enum name="GstPadDirection">
			<member name="GST_PAD_UNKNOWN" value="0"/>
			<member name="GST_PAD_SRC" value="1"/>
			<member name="GST_PAD_SINK" value="2"/>
		</enum>
		<enum name="GstPadLinkReturn">
			<member name="GST_PAD_LINK_OK" value="0"/>
			<member name="GST_PAD_LINK_WRONG_HIERARCHY" value="-1"/>
			<member name="GST_PAD_LINK_WAS_LINKED" value="-2"/>
			<member name="GST_PAD_LINK_WRONG_DIRECTION" value="-3"/>
			<member name="GST_PAD_LINK_NOFORMAT" value="-4"/>
			<member name="GST_PAD_LINK_NOSCHED" value="-5"/>
			<member name="GST_PAD_LINK_REFUSED" value="-6"/>
		</enum>
		<enum name="GstPadPresence">
			<member name="GST_PAD_ALWAYS" value="0"/>
			<member name="GST_PAD_SOMETIMES" value="1"/>
			<member name="GST_PAD_REQUEST" value="2"/>
		</enum>
		<enum name="GstParseError">
			<member name="GST_PARSE_ERROR_SYNTAX" value="0"/>
			<member name="GST_PARSE_ERROR_NO_SUCH_ELEMENT" value="1"/>
			<member name="GST_PARSE_ERROR_NO_SUCH_PROPERTY" value="2"/>
			<member name="GST_PARSE_ERROR_LINK" value="3"/>
			<member name="GST_PARSE_ERROR_COULD_NOT_SET_PROPERTY" value="4"/>
			<member name="GST_PARSE_ERROR_EMPTY_BIN" value="5"/>
			<member name="GST_PARSE_ERROR_EMPTY" value="6"/>
		</enum>
		<enum name="GstPluginError">
			<member name="GST_PLUGIN_ERROR_MODULE" value="0"/>
			<member name="GST_PLUGIN_ERROR_DEPENDENCIES" value="1"/>
			<member name="GST_PLUGIN_ERROR_NAME_MISMATCH" value="2"/>
		</enum>
		<enum name="GstQueryType">
			<member name="GST_QUERY_NONE" value="0"/>
			<member name="GST_QUERY_POSITION" value="1"/>
			<member name="GST_QUERY_DURATION" value="2"/>
			<member name="GST_QUERY_LATENCY" value="3"/>
			<member name="GST_QUERY_JITTER" value="4"/>
			<member name="GST_QUERY_RATE" value="5"/>
			<member name="GST_QUERY_SEEKING" value="6"/>
			<member name="GST_QUERY_SEGMENT" value="7"/>
			<member name="GST_QUERY_CONVERT" value="8"/>
			<member name="GST_QUERY_FORMATS" value="9"/>
		</enum>
		<enum name="GstRank">
			<member name="GST_RANK_NONE" value="0"/>
			<member name="GST_RANK_MARGINAL" value="64"/>
			<member name="GST_RANK_SECONDARY" value="128"/>
			<member name="GST_RANK_PRIMARY" value="256"/>
		</enum>
		<enum name="GstResourceError">
			<member name="GST_RESOURCE_ERROR_FAILED" value="1"/>
			<member name="GST_RESOURCE_ERROR_TOO_LAZY" value="2"/>
			<member name="GST_RESOURCE_ERROR_NOT_FOUND" value="3"/>
			<member name="GST_RESOURCE_ERROR_BUSY" value="4"/>
			<member name="GST_RESOURCE_ERROR_OPEN_READ" value="5"/>
			<member name="GST_RESOURCE_ERROR_OPEN_WRITE" value="6"/>
			<member name="GST_RESOURCE_ERROR_OPEN_READ_WRITE" value="7"/>
			<member name="GST_RESOURCE_ERROR_CLOSE" value="8"/>
			<member name="GST_RESOURCE_ERROR_READ" value="9"/>
			<member name="GST_RESOURCE_ERROR_WRITE" value="10"/>
			<member name="GST_RESOURCE_ERROR_SEEK" value="11"/>
			<member name="GST_RESOURCE_ERROR_SYNC" value="12"/>
			<member name="GST_RESOURCE_ERROR_SETTINGS" value="13"/>
			<member name="GST_RESOURCE_ERROR_NO_SPACE_LEFT" value="14"/>
			<member name="GST_RESOURCE_ERROR_NUM_ERRORS" value="15"/>
		</enum>
		<enum name="GstSeekType">
			<member name="GST_SEEK_TYPE_NONE" value="0"/>
			<member name="GST_SEEK_TYPE_CUR" value="1"/>
			<member name="GST_SEEK_TYPE_SET" value="2"/>
			<member name="GST_SEEK_TYPE_END" value="3"/>
		</enum>
		<enum name="GstState">
			<member name="GST_STATE_VOID_PENDING" value="0"/>
			<member name="GST_STATE_NULL" value="1"/>
			<member name="GST_STATE_READY" value="2"/>
			<member name="GST_STATE_PAUSED" value="3"/>
			<member name="GST_STATE_PLAYING" value="4"/>
		</enum>
		<enum name="GstStateChange">
			<member name="GST_STATE_CHANGE_NULL_TO_READY" value="10"/>
			<member name="GST_STATE_CHANGE_READY_TO_PAUSED" value="19"/>
			<member name="GST_STATE_CHANGE_PAUSED_TO_PLAYING" value="28"/>
			<member name="GST_STATE_CHANGE_PLAYING_TO_PAUSED" value="35"/>
			<member name="GST_STATE_CHANGE_PAUSED_TO_READY" value="26"/>
			<member name="GST_STATE_CHANGE_READY_TO_NULL" value="17"/>
		</enum>
		<enum name="GstStateChangeReturn">
			<member name="GST_STATE_CHANGE_FAILURE" value="0"/>
			<member name="GST_STATE_CHANGE_SUCCESS" value="1"/>
			<member name="GST_STATE_CHANGE_ASYNC" value="2"/>
			<member name="GST_STATE_CHANGE_NO_PREROLL" value="3"/>
		</enum>
		<enum name="GstStreamError">
			<member name="GST_STREAM_ERROR_FAILED" value="1"/>
			<member name="GST_STREAM_ERROR_TOO_LAZY" value="2"/>
			<member name="GST_STREAM_ERROR_NOT_IMPLEMENTED" value="3"/>
			<member name="GST_STREAM_ERROR_TYPE_NOT_FOUND" value="4"/>
			<member name="GST_STREAM_ERROR_WRONG_TYPE" value="5"/>
			<member name="GST_STREAM_ERROR_CODEC_NOT_FOUND" value="6"/>
			<member name="GST_STREAM_ERROR_DECODE" value="7"/>
			<member name="GST_STREAM_ERROR_ENCODE" value="8"/>
			<member name="GST_STREAM_ERROR_DEMUX" value="9"/>
			<member name="GST_STREAM_ERROR_MUX" value="10"/>
			<member name="GST_STREAM_ERROR_FORMAT" value="11"/>
			<member name="GST_STREAM_ERROR_NUM_ERRORS" value="12"/>
		</enum>
		<enum name="GstTagFlag">
			<member name="GST_TAG_FLAG_UNDEFINED" value="0"/>
			<member name="GST_TAG_FLAG_META" value="1"/>
			<member name="GST_TAG_FLAG_ENCODED" value="2"/>
			<member name="GST_TAG_FLAG_DECODED" value="3"/>
			<member name="GST_TAG_FLAG_COUNT" value="4"/>
		</enum>
		<enum name="GstTagMergeMode">
			<member name="GST_TAG_MERGE_UNDEFINED" value="0"/>
			<member name="GST_TAG_MERGE_REPLACE_ALL" value="1"/>
			<member name="GST_TAG_MERGE_REPLACE" value="2"/>
			<member name="GST_TAG_MERGE_APPEND" value="3"/>
			<member name="GST_TAG_MERGE_PREPEND" value="4"/>
			<member name="GST_TAG_MERGE_KEEP" value="5"/>
			<member name="GST_TAG_MERGE_KEEP_ALL" value="6"/>
			<member name="GST_TAG_MERGE_COUNT" value="7"/>
		</enum>
		<enum name="GstTaskState">
			<member name="GST_TASK_STARTED" value="0"/>
			<member name="GST_TASK_STOPPED" value="1"/>
			<member name="GST_TASK_PAUSED" value="2"/>
		</enum>
		<enum name="GstTypeFindProbability">
			<member name="GST_TYPE_FIND_MINIMUM" value="1"/>
			<member name="GST_TYPE_FIND_POSSIBLE" value="50"/>
			<member name="GST_TYPE_FIND_LIKELY" value="80"/>
			<member name="GST_TYPE_FIND_NEARLY_CERTAIN" value="99"/>
			<member name="GST_TYPE_FIND_MAXIMUM" value="100"/>
		</enum>
		<enum name="GstURIType">
			<member name="GST_URI_UNKNOWN" value="0"/>
			<member name="GST_URI_SINK" value="1"/>
			<member name="GST_URI_SRC" value="2"/>
		</enum>
		<flags name="GstAllocTraceFlags">
			<member name="GST_ALLOC_TRACE_LIVE" value="1"/>
			<member name="GST_ALLOC_TRACE_MEM_LIVE" value="2"/>
		</flags>
		<flags name="GstAssocFlags">
			<member name="GST_ASSOCIATION_FLAG_NONE" value="0"/>
			<member name="GST_ASSOCIATION_FLAG_KEY_UNIT" value="1"/>
			<member name="GST_ASSOCIATION_FLAG_DELTA_UNIT" value="2"/>
			<member name="GST_ASSOCIATION_FLAG_LAST" value="256"/>
		</flags>
		<flags name="GstBinFlags">
			<member name="GST_BIN_FLAG_LAST" value="33554432"/>
		</flags>
		<flags name="GstBufferCopyFlags">
			<member name="GST_BUFFER_COPY_FLAGS" value="1"/>
			<member name="GST_BUFFER_COPY_TIMESTAMPS" value="2"/>
			<member name="GST_BUFFER_COPY_CAPS" value="4"/>
		</flags>
		<flags name="GstBufferFlag">
			<member name="GST_BUFFER_FLAG_READONLY" value="1"/>
			<member name="GST_BUFFER_FLAG_PREROLL" value="16"/>
			<member name="GST_BUFFER_FLAG_DISCONT" value="32"/>
			<member name="GST_BUFFER_FLAG_IN_CAPS" value="64"/>
			<member name="GST_BUFFER_FLAG_GAP" value="128"/>
			<member name="GST_BUFFER_FLAG_DELTA_UNIT" value="256"/>
			<member name="GST_BUFFER_FLAG_LAST" value="4096"/>
		</flags>
		<flags name="GstBusFlags">
			<member name="GST_BUS_FLUSHING" value="16"/>
			<member name="GST_BUS_FLAG_LAST" value="32"/>
		</flags>
		<flags name="GstCapsFlags">
			<member name="GST_CAPS_FLAGS_ANY" value="1"/>
		</flags>
		<flags name="GstClockFlags">
			<member name="GST_CLOCK_FLAG_CAN_DO_SINGLE_SYNC" value="16"/>
			<member name="GST_CLOCK_FLAG_CAN_DO_SINGLE_ASYNC" value="32"/>
			<member name="GST_CLOCK_FLAG_CAN_DO_PERIODIC_SYNC" value="64"/>
			<member name="GST_CLOCK_FLAG_CAN_DO_PERIODIC_ASYNC" value="128"/>
			<member name="GST_CLOCK_FLAG_CAN_SET_RESOLUTION" value="256"/>
			<member name="GST_CLOCK_FLAG_CAN_SET_MASTER" value="512"/>
			<member name="GST_CLOCK_FLAG_LAST" value="4096"/>
		</flags>
		<flags name="GstDebugGraphDetails">
			<member name="GST_DEBUG_GRAPH_SHOW_MEDIA_TYPE" value="1"/>
			<member name="GST_DEBUG_GRAPH_SHOW_CAPS_DETAILS" value="2"/>
			<member name="GST_DEBUG_GRAPH_SHOW_NON_DEFAULT_PARAMS" value="4"/>
			<member name="GST_DEBUG_GRAPH_SHOW_STATES" value="8"/>
			<member name="GST_DEBUG_GRAPH_SHOW_ALL" value="15"/>
		</flags>
		<flags name="GstElementFlags">
			<member name="GST_ELEMENT_LOCKED_STATE" value="16"/>
			<member name="GST_ELEMENT_IS_SINK" value="32"/>
			<member name="GST_ELEMENT_UNPARENTING" value="64"/>
			<member name="GST_ELEMENT_FLAG_LAST" value="1048576"/>
		</flags>
		<flags name="GstEventTypeFlags">
			<member name="GST_EVENT_TYPE_UPSTREAM" value="1"/>
			<member name="GST_EVENT_TYPE_DOWNSTREAM" value="2"/>
			<member name="GST_EVENT_TYPE_SERIALIZED" value="4"/>
		</flags>
		<flags name="GstIndexFlags">
			<member name="GST_INDEX_WRITABLE" value="16"/>
			<member name="GST_INDEX_READABLE" value="32"/>
			<member name="GST_INDEX_FLAG_LAST" value="4096"/>
		</flags>
		<flags name="GstMessageType">
			<member name="GST_MESSAGE_UNKNOWN" value="0"/>
			<member name="GST_MESSAGE_EOS" value="1"/>
			<member name="GST_MESSAGE_ERROR" value="2"/>
			<member name="GST_MESSAGE_WARNING" value="4"/>
			<member name="GST_MESSAGE_INFO" value="8"/>
			<member name="GST_MESSAGE_TAG" value="16"/>
			<member name="GST_MESSAGE_BUFFERING" value="32"/>
			<member name="GST_MESSAGE_STATE_CHANGED" value="64"/>
			<member name="GST_MESSAGE_STATE_DIRTY" value="128"/>
			<member name="GST_MESSAGE_STEP_DONE" value="256"/>
			<member name="GST_MESSAGE_CLOCK_PROVIDE" value="512"/>
			<member name="GST_MESSAGE_CLOCK_LOST" value="1024"/>
			<member name="GST_MESSAGE_NEW_CLOCK" value="2048"/>
			<member name="GST_MESSAGE_STRUCTURE_CHANGE" value="4096"/>
			<member name="GST_MESSAGE_STREAM_STATUS" value="8192"/>
			<member name="GST_MESSAGE_APPLICATION" value="16384"/>
			<member name="GST_MESSAGE_ELEMENT" value="32768"/>
			<member name="GST_MESSAGE_SEGMENT_START" value="65536"/>
			<member name="GST_MESSAGE_SEGMENT_DONE" value="131072"/>
			<member name="GST_MESSAGE_DURATION" value="262144"/>
			<member name="GST_MESSAGE_LATENCY" value="524288"/>
			<member name="GST_MESSAGE_ASYNC_START" value="1048576"/>
			<member name="GST_MESSAGE_ASYNC_DONE" value="2097152"/>
			<member name="GST_MESSAGE_ANY" value="-1"/>
		</flags>
		<flags name="GstMiniObjectFlags">
			<member name="GST_MINI_OBJECT_FLAG_READONLY" value="1"/>
			<member name="GST_MINI_OBJECT_FLAG_LAST" value="16"/>
		</flags>
		<flags name="GstObjectFlags">
			<member name="GST_OBJECT_DISPOSING" value="1"/>
			<member name="GST_OBJECT_FLOATING" value="2"/>
			<member name="GST_OBJECT_FLAG_LAST" value="16"/>
		</flags>
		<flags name="GstPadFlags">
			<member name="GST_PAD_BLOCKED" value="16"/>
			<member name="GST_PAD_FLUSHING" value="32"/>
			<member name="GST_PAD_IN_GETCAPS" value="64"/>
			<member name="GST_PAD_IN_SETCAPS" value="128"/>
			<member name="GST_PAD_BLOCKING" value="256"/>
			<member name="GST_PAD_FLAG_LAST" value="4096"/>
		</flags>
		<flags name="GstPadTemplateFlags">
			<member name="GST_PAD_TEMPLATE_FIXED" value="16"/>
			<member name="GST_PAD_TEMPLATE_FLAG_LAST" value="256"/>
		</flags>
		<flags name="GstPipelineFlags">
			<member name="GST_PIPELINE_FLAG_FIXED_CLOCK" value="33554432"/>
			<member name="GST_PIPELINE_FLAG_LAST" value="536870912"/>
		</flags>
		<flags name="GstPluginFlags">
			<member name="GST_PLUGIN_FLAG_CACHED" value="1"/>
		</flags>
		<flags name="GstSeekFlags">
			<member name="GST_SEEK_FLAG_NONE" value="0"/>
			<member name="GST_SEEK_FLAG_FLUSH" value="1"/>
			<member name="GST_SEEK_FLAG_ACCURATE" value="2"/>
			<member name="GST_SEEK_FLAG_KEY_UNIT" value="4"/>
			<member name="GST_SEEK_FLAG_SEGMENT" value="8"/>
		</flags>
		<object name="GstAdapter" parent="GObject" type-name="GstAdapter" get-type="gst_adapter_get_type">
			<method name="available" symbol="gst_adapter_available">
				<return-type type="guint"/>
				<parameters>
					<parameter name="adapter" type="GstAdapter*"/>
				</parameters>
			</method>
			<method name="available_fast" symbol="gst_adapter_available_fast">
				<return-type type="guint"/>
				<parameters>
					<parameter name="adapter" type="GstAdapter*"/>
				</parameters>
			</method>
			<method name="clear" symbol="gst_adapter_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="adapter" type="GstAdapter*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gst_adapter_copy">
				<return-type type="void"/>
				<parameters>
					<parameter name="adapter" type="GstAdapter*"/>
					<parameter name="dest" type="guint8*"/>
					<parameter name="offset" type="guint"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="flush" symbol="gst_adapter_flush">
				<return-type type="void"/>
				<parameters>
					<parameter name="adapter" type="GstAdapter*"/>
					<parameter name="flush" type="guint"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_adapter_new">
				<return-type type="GstAdapter*"/>
			</constructor>
			<method name="peek" symbol="gst_adapter_peek">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="adapter" type="GstAdapter*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="push" symbol="gst_adapter_push">
				<return-type type="void"/>
				<parameters>
					<parameter name="adapter" type="GstAdapter*"/>
					<parameter name="buf" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="take" symbol="gst_adapter_take">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="adapter" type="GstAdapter*"/>
					<parameter name="nbytes" type="guint"/>
				</parameters>
			</method>
			<method name="take_buffer" symbol="gst_adapter_take_buffer">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="adapter" type="GstAdapter*"/>
					<parameter name="nbytes" type="guint"/>
				</parameters>
			</method>
			<field name="buflist" type="GSList*"/>
			<field name="size" type="guint"/>
			<field name="skip" type="guint"/>
			<field name="assembled_data" type="guint8*"/>
			<field name="assembled_size" type="guint"/>
			<field name="assembled_len" type="guint"/>
			<field name="buflist_end" type="GSList*"/>
		</object>
		<object name="GstBaseSink" parent="GstElement" type-name="GstBaseSink" get-type="gst_base_sink_get_type">
			<method name="get_last_buffer" symbol="gst_base_sink_get_last_buffer">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</method>
			<method name="get_latency" symbol="gst_base_sink_get_latency">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</method>
			<method name="get_max_lateness" symbol="gst_base_sink_get_max_lateness">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</method>
			<method name="get_sync" symbol="gst_base_sink_get_sync">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</method>
			<method name="get_ts_offset" symbol="gst_base_sink_get_ts_offset">
				<return-type type="GstClockTimeDiff"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</method>
			<method name="is_async_enabled" symbol="gst_base_sink_is_async_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</method>
			<method name="is_qos_enabled" symbol="gst_base_sink_is_qos_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</method>
			<method name="query_latency" symbol="gst_base_sink_query_latency">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="live" type="gboolean*"/>
					<parameter name="upstream_live" type="gboolean*"/>
					<parameter name="min_latency" type="GstClockTime*"/>
					<parameter name="max_latency" type="GstClockTime*"/>
				</parameters>
			</method>
			<method name="set_async_enabled" symbol="gst_base_sink_set_async_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="enabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_max_lateness" symbol="gst_base_sink_set_max_lateness">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="max_lateness" type="gint64"/>
				</parameters>
			</method>
			<method name="set_qos_enabled" symbol="gst_base_sink_set_qos_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="enabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_sync" symbol="gst_base_sink_set_sync">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="sync" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_ts_offset" symbol="gst_base_sink_set_ts_offset">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="offset" type="GstClockTimeDiff"/>
				</parameters>
			</method>
			<method name="wait_eos" symbol="gst_base_sink_wait_eos">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="time" type="GstClockTime"/>
					<parameter name="jitter" type="GstClockTimeDiff*"/>
				</parameters>
			</method>
			<method name="wait_preroll" symbol="gst_base_sink_wait_preroll">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</method>
			<property name="async" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="last-buffer" type="GstBuffer" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="max-lateness" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="preroll-queue-len" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="qos" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sync" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ts-offset" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="activate_pull">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="active" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="async_play">
				<return-type type="GstStateChangeReturn"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</vfunc>
			<vfunc name="buffer_alloc">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="offset" type="guint64"/>
					<parameter name="size" type="guint"/>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="buf" type="GstBuffer**"/>
				</parameters>
			</vfunc>
			<vfunc name="event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</vfunc>
			<vfunc name="fixate">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_times">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="buffer" type="GstBuffer*"/>
					<parameter name="start" type="GstClockTime*"/>
					<parameter name="end" type="GstClockTime*"/>
				</parameters>
			</vfunc>
			<vfunc name="preroll">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="render">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</vfunc>
			<vfunc name="start">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</vfunc>
			<vfunc name="stop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</vfunc>
			<vfunc name="unlock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</vfunc>
			<vfunc name="unlock_stop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</vfunc>
			<field name="sinkpad" type="GstPad*"/>
			<field name="pad_mode" type="GstActivateMode"/>
			<field name="offset" type="guint64"/>
			<field name="can_activate_pull" type="gboolean"/>
			<field name="can_activate_push" type="gboolean"/>
			<field name="preroll_queue" type="GQueue*"/>
			<field name="preroll_queue_max_len" type="gint"/>
			<field name="preroll_queued" type="gint"/>
			<field name="buffers_queued" type="gint"/>
			<field name="events_queued" type="gint"/>
			<field name="eos" type="gboolean"/>
			<field name="eos_queued" type="gboolean"/>
			<field name="need_preroll" type="gboolean"/>
			<field name="have_preroll" type="gboolean"/>
			<field name="playing_async" type="gboolean"/>
			<field name="have_newsegment" type="gboolean"/>
			<field name="segment" type="GstSegment"/>
			<field name="clock_id" type="GstClockID"/>
			<field name="end_time" type="GstClockTime"/>
			<field name="sync" type="gboolean"/>
			<field name="flushing" type="gboolean"/>
			<field name="abidata" type="gpointer"/>
		</object>
		<object name="GstBaseSrc" parent="GstElement" type-name="GstBaseSrc" get-type="gst_base_src_get_type">
			<method name="get_do_timestamp" symbol="gst_base_src_get_do_timestamp">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</method>
			<method name="is_live" symbol="gst_base_src_is_live">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</method>
			<method name="query_latency" symbol="gst_base_src_query_latency">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="live" type="gboolean*"/>
					<parameter name="min_latency" type="GstClockTime*"/>
					<parameter name="max_latency" type="GstClockTime*"/>
				</parameters>
			</method>
			<method name="set_do_timestamp" symbol="gst_base_src_set_do_timestamp">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="live" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_format" symbol="gst_base_src_set_format">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="format" type="GstFormat"/>
				</parameters>
			</method>
			<method name="set_live" symbol="gst_base_src_set_live">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="live" type="gboolean"/>
				</parameters>
			</method>
			<method name="wait_playing" symbol="gst_base_src_wait_playing">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</method>
			<property name="blocksize" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="do-timestamp" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="num-buffers" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="typefind" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="check_get_range">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="create">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="offset" type="guint64"/>
					<parameter name="size" type="guint"/>
					<parameter name="buf" type="GstBuffer**"/>
				</parameters>
			</vfunc>
			<vfunc name="do_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="segment" type="GstSegment*"/>
				</parameters>
			</vfunc>
			<vfunc name="event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</vfunc>
			<vfunc name="fixate">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_size">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="size" type="guint64*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_times">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="buffer" type="GstBuffer*"/>
					<parameter name="start" type="GstClockTime*"/>
					<parameter name="end" type="GstClockTime*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_seekable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="negotiate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="newsegment">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="prepare_seek_segment">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="seek" type="GstEvent*"/>
					<parameter name="segment" type="GstSegment*"/>
				</parameters>
			</vfunc>
			<vfunc name="query">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="query" type="GstQuery*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</vfunc>
			<vfunc name="start">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="stop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="unlock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="unlock_stop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</vfunc>
			<field name="srcpad" type="GstPad*"/>
			<field name="live_lock" type="GMutex*"/>
			<field name="live_cond" type="GCond*"/>
			<field name="is_live" type="gboolean"/>
			<field name="live_running" type="gboolean"/>
			<field name="blocksize" type="gint"/>
			<field name="can_activate_push" type="gboolean"/>
			<field name="pad_mode" type="GstActivateMode"/>
			<field name="seekable" type="gboolean"/>
			<field name="random_access" type="gboolean"/>
			<field name="clock_id" type="GstClockID"/>
			<field name="end_time" type="GstClockTime"/>
			<field name="segment" type="GstSegment"/>
			<field name="need_newsegment" type="gboolean"/>
			<field name="offset" type="guint64"/>
			<field name="size" type="guint64"/>
			<field name="num_buffers" type="gint"/>
			<field name="num_buffers_left" type="gint"/>
			<field name="data" type="gpointer"/>
		</object>
		<object name="GstBaseTransform" parent="GstElement" type-name="GstBaseTransform" get-type="gst_base_transform_get_type">
			<method name="is_in_place" symbol="gst_base_transform_is_in_place">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
				</parameters>
			</method>
			<method name="is_passthrough" symbol="gst_base_transform_is_passthrough">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
				</parameters>
			</method>
			<method name="is_qos_enabled" symbol="gst_base_transform_is_qos_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
				</parameters>
			</method>
			<method name="set_in_place" symbol="gst_base_transform_set_in_place">
				<return-type type="void"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="in_place" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_passthrough" symbol="gst_base_transform_set_passthrough">
				<return-type type="void"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="passthrough" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_qos_enabled" symbol="gst_base_transform_set_qos_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="enabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="update_qos" symbol="gst_base_transform_update_qos">
				<return-type type="void"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="proportion" type="gdouble"/>
					<parameter name="diff" type="GstClockTimeDiff"/>
					<parameter name="timestamp" type="GstClockTime"/>
				</parameters>
			</method>
			<property name="qos" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</vfunc>
			<vfunc name="fixate_caps">
				<return-type type="void"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="direction" type="GstPadDirection"/>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="othercaps" type="GstCaps*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_unit_size">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="size" type="guint*"/>
				</parameters>
			</vfunc>
			<vfunc name="prepare_output_buffer">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="input" type="GstBuffer*"/>
					<parameter name="size" type="gint"/>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="buf" type="GstBuffer**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="incaps" type="GstCaps*"/>
					<parameter name="outcaps" type="GstCaps*"/>
				</parameters>
			</vfunc>
			<vfunc name="src_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</vfunc>
			<vfunc name="start">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
				</parameters>
			</vfunc>
			<vfunc name="stop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
				</parameters>
			</vfunc>
			<vfunc name="transform">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="inbuf" type="GstBuffer*"/>
					<parameter name="outbuf" type="GstBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="transform_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="direction" type="GstPadDirection"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</vfunc>
			<vfunc name="transform_ip">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="buf" type="GstBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="transform_size">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="direction" type="GstPadDirection"/>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="size" type="guint"/>
					<parameter name="othercaps" type="GstCaps*"/>
					<parameter name="othersize" type="guint*"/>
				</parameters>
			</vfunc>
			<field name="sinkpad" type="GstPad*"/>
			<field name="srcpad" type="GstPad*"/>
			<field name="passthrough" type="gboolean"/>
			<field name="always_in_place" type="gboolean"/>
			<field name="cache_caps1" type="GstCaps*"/>
			<field name="cache_caps1_size" type="guint"/>
			<field name="cache_caps2" type="GstCaps*"/>
			<field name="cache_caps2_size" type="guint"/>
			<field name="have_same_caps" type="gboolean"/>
			<field name="delay_configure" type="gboolean"/>
			<field name="pending_configure" type="gboolean"/>
			<field name="negotiated" type="gboolean"/>
			<field name="have_newsegment" type="gboolean"/>
			<field name="segment" type="GstSegment"/>
			<field name="transform_lock" type="GMutex*"/>
		</object>
		<object name="GstBin" parent="GstElement" type-name="GstBin" get-type="gst_bin_get_type">
			<implements>
				<interface name="GstChildProxy"/>
			</implements>
			<method name="add" symbol="gst_bin_add">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="add_many" symbol="gst_bin_add_many">
				<return-type type="void"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="element_1" type="GstElement*"/>
				</parameters>
			</method>
			<method name="find_unconnected_pad" symbol="gst_bin_find_unconnected_pad">
				<return-type type="GstPad*"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="direction" type="GstPadDirection"/>
				</parameters>
			</method>
			<method name="get_by_interface" symbol="gst_bin_get_by_interface">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="iface" type="GType"/>
				</parameters>
			</method>
			<method name="get_by_name" symbol="gst_bin_get_by_name">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_by_name_recurse_up" symbol="gst_bin_get_by_name_recurse_up">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="iterate_all_by_interface" symbol="gst_bin_iterate_all_by_interface">
				<return-type type="GstIterator*"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="iface" type="GType"/>
				</parameters>
			</method>
			<method name="iterate_elements" symbol="gst_bin_iterate_elements">
				<return-type type="GstIterator*"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
				</parameters>
			</method>
			<method name="iterate_recurse" symbol="gst_bin_iterate_recurse">
				<return-type type="GstIterator*"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
				</parameters>
			</method>
			<method name="iterate_sinks" symbol="gst_bin_iterate_sinks">
				<return-type type="GstIterator*"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
				</parameters>
			</method>
			<method name="iterate_sorted" symbol="gst_bin_iterate_sorted">
				<return-type type="GstIterator*"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
				</parameters>
			</method>
			<method name="iterate_sources" symbol="gst_bin_iterate_sources">
				<return-type type="GstIterator*"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_bin_new">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="remove" symbol="gst_bin_remove">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="remove_many" symbol="gst_bin_remove_many">
				<return-type type="void"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="element_1" type="GstElement*"/>
				</parameters>
			</method>
			<property name="async-handling" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="element-added" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="child" type="GstElement*"/>
				</parameters>
			</signal>
			<signal name="element-removed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="child" type="GstElement*"/>
				</parameters>
			</signal>
			<vfunc name="add_element">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</vfunc>
			<vfunc name="handle_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="message" type="GstMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_element">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="bin" type="GstBin*"/>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</vfunc>
			<field name="numchildren" type="gint"/>
			<field name="children" type="GList*"/>
			<field name="children_cookie" type="guint32"/>
			<field name="child_bus" type="GstBus*"/>
			<field name="messages" type="GList*"/>
			<field name="polling" type="gboolean"/>
			<field name="state_dirty" type="gboolean"/>
			<field name="clock_dirty" type="gboolean"/>
			<field name="provided_clock" type="GstClock*"/>
			<field name="clock_provider" type="GstElement*"/>
		</object>
		<object name="GstBus" parent="GstObject" type-name="GstBus" get-type="gst_bus_get_type">
			<method name="add_signal_watch" symbol="gst_bus_add_signal_watch">
				<return-type type="void"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
				</parameters>
			</method>
			<method name="add_signal_watch_full" symbol="gst_bus_add_signal_watch_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="priority" type="gint"/>
				</parameters>
			</method>
			<method name="add_watch" symbol="gst_bus_add_watch">
				<return-type type="guint"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="func" type="GstBusFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="add_watch_full" symbol="gst_bus_add_watch_full">
				<return-type type="guint"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="priority" type="gint"/>
					<parameter name="func" type="GstBusFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="async_signal_func" symbol="gst_bus_async_signal_func">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="create_watch" symbol="gst_bus_create_watch">
				<return-type type="GSource*"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
				</parameters>
			</method>
			<method name="disable_sync_message_emission" symbol="gst_bus_disable_sync_message_emission">
				<return-type type="void"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
				</parameters>
			</method>
			<method name="enable_sync_message_emission" symbol="gst_bus_enable_sync_message_emission">
				<return-type type="void"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
				</parameters>
			</method>
			<method name="have_pending" symbol="gst_bus_have_pending">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_bus_new">
				<return-type type="GstBus*"/>
			</constructor>
			<method name="peek" symbol="gst_bus_peek">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
				</parameters>
			</method>
			<method name="poll" symbol="gst_bus_poll">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="events" type="GstMessageType"/>
					<parameter name="timeout" type="GstClockTimeDiff"/>
				</parameters>
			</method>
			<method name="pop" symbol="gst_bus_pop">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
				</parameters>
			</method>
			<method name="pop_filtered" symbol="gst_bus_pop_filtered">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="types" type="GstMessageType"/>
				</parameters>
			</method>
			<method name="post" symbol="gst_bus_post">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="message" type="GstMessage*"/>
				</parameters>
			</method>
			<method name="remove_signal_watch" symbol="gst_bus_remove_signal_watch">
				<return-type type="void"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
				</parameters>
			</method>
			<method name="set_flushing" symbol="gst_bus_set_flushing">
				<return-type type="void"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="flushing" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_sync_handler" symbol="gst_bus_set_sync_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="func" type="GstBusSyncHandler"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="sync_signal_handler" symbol="gst_bus_sync_signal_handler">
				<return-type type="GstBusSyncReply"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="timed_pop" symbol="gst_bus_timed_pop">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="timeout" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="timed_pop_filtered" symbol="gst_bus_timed_pop_filtered">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="timeout" type="GstClockTime"/>
					<parameter name="types" type="GstMessageType"/>
				</parameters>
			</method>
			<signal name="message" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="message" type="GstMessage"/>
				</parameters>
			</signal>
			<signal name="sync-message" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="bus" type="GstBus*"/>
					<parameter name="message" type="GstMessage"/>
				</parameters>
			</signal>
			<field name="queue" type="GQueue*"/>
			<field name="queue_lock" type="GMutex*"/>
			<field name="sync_handler" type="GstBusSyncHandler"/>
			<field name="sync_handler_data" type="gpointer"/>
			<field name="signal_watch_id" type="guint"/>
			<field name="num_signal_watchers" type="guint"/>
		</object>
		<object name="GstClock" parent="GstObject" type-name="GstClock" get-type="gst_clock_get_type">
			<method name="add_observation" symbol="gst_clock_add_observation">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="slave" type="GstClockTime"/>
					<parameter name="master" type="GstClockTime"/>
					<parameter name="r_squared" type="gdouble*"/>
				</parameters>
			</method>
			<method name="adjust_unlocked" symbol="gst_clock_adjust_unlocked">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="internal" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="get_calibration" symbol="gst_clock_get_calibration">
				<return-type type="void"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="internal" type="GstClockTime*"/>
					<parameter name="external" type="GstClockTime*"/>
					<parameter name="rate_num" type="GstClockTime*"/>
					<parameter name="rate_denom" type="GstClockTime*"/>
				</parameters>
			</method>
			<method name="get_internal_time" symbol="gst_clock_get_internal_time">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</method>
			<method name="get_master" symbol="gst_clock_get_master">
				<return-type type="GstClock*"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</method>
			<method name="get_resolution" symbol="gst_clock_get_resolution">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</method>
			<method name="get_time" symbol="gst_clock_get_time">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</method>
			<constructor name="new_periodic_id" symbol="gst_clock_new_periodic_id">
				<return-type type="GstClockID"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="start_time" type="GstClockTime"/>
					<parameter name="interval" type="GstClockTime"/>
				</parameters>
			</constructor>
			<constructor name="new_single_shot_id" symbol="gst_clock_new_single_shot_id">
				<return-type type="GstClockID"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="time" type="GstClockTime"/>
				</parameters>
			</constructor>
			<method name="set_calibration" symbol="gst_clock_set_calibration">
				<return-type type="void"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="internal" type="GstClockTime"/>
					<parameter name="external" type="GstClockTime"/>
					<parameter name="rate_num" type="GstClockTime"/>
					<parameter name="rate_denom" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="set_master" symbol="gst_clock_set_master">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="master" type="GstClock*"/>
				</parameters>
			</method>
			<method name="set_resolution" symbol="gst_clock_set_resolution">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="resolution" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="unadjust_unlocked" symbol="gst_clock_unadjust_unlocked">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="external" type="GstClockTime"/>
				</parameters>
			</method>
			<property name="stats" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="timeout" type="guint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="window-size" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="window-threshold" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="change_resolution">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="old_resolution" type="GstClockTime"/>
					<parameter name="new_resolution" type="GstClockTime"/>
				</parameters>
			</vfunc>
			<vfunc name="get_internal_time">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_resolution">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</vfunc>
			<vfunc name="unschedule">
				<return-type type="void"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="entry" type="GstClockEntry*"/>
				</parameters>
			</vfunc>
			<vfunc name="wait">
				<return-type type="GstClockReturn"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="entry" type="GstClockEntry*"/>
				</parameters>
			</vfunc>
			<vfunc name="wait_async">
				<return-type type="GstClockReturn"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="entry" type="GstClockEntry*"/>
				</parameters>
			</vfunc>
			<vfunc name="wait_jitter">
				<return-type type="GstClockReturn"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="entry" type="GstClockEntry*"/>
					<parameter name="jitter" type="GstClockTimeDiff*"/>
				</parameters>
			</vfunc>
			<field name="slave_lock" type="GMutex*"/>
			<field name="internal_calibration" type="GstClockTime"/>
			<field name="external_calibration" type="GstClockTime"/>
			<field name="rate_numerator" type="GstClockTime"/>
			<field name="rate_denominator" type="GstClockTime"/>
			<field name="last_time" type="GstClockTime"/>
			<field name="entries" type="GList*"/>
			<field name="entries_changed" type="GCond*"/>
			<field name="resolution" type="GstClockTime"/>
			<field name="stats" type="gboolean"/>
			<field name="master" type="GstClock*"/>
			<field name="filling" type="gboolean"/>
			<field name="window_size" type="gint"/>
			<field name="window_threshold" type="gint"/>
			<field name="time_index" type="gint"/>
			<field name="timeout" type="GstClockTime"/>
			<field name="times" type="GstClockTime*"/>
			<field name="clockid" type="GstClockID"/>
		</object>
		<object name="GstCollectPads" parent="GstObject" type-name="GstCollectPads" get-type="gst_collect_pads_get_type">
			<method name="add_pad" symbol="gst_collect_pads_add_pad">
				<return-type type="GstCollectData*"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="add_pad_full" symbol="gst_collect_pads_add_pad_full">
				<return-type type="GstCollectData*"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="size" type="guint"/>
					<parameter name="destroy_notify" type="GstCollectDataDestroyNotify"/>
				</parameters>
			</method>
			<method name="available" symbol="gst_collect_pads_available">
				<return-type type="guint"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
				</parameters>
			</method>
			<method name="collect" symbol="gst_collect_pads_collect">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
				</parameters>
			</method>
			<method name="collect_range" symbol="gst_collect_pads_collect_range">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="offset" type="guint64"/>
					<parameter name="length" type="guint"/>
				</parameters>
			</method>
			<method name="flush" symbol="gst_collect_pads_flush">
				<return-type type="guint"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="data" type="GstCollectData*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="is_active" symbol="gst_collect_pads_is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_collect_pads_new">
				<return-type type="GstCollectPads*"/>
			</constructor>
			<method name="peek" symbol="gst_collect_pads_peek">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="data" type="GstCollectData*"/>
				</parameters>
			</method>
			<method name="pop" symbol="gst_collect_pads_pop">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="data" type="GstCollectData*"/>
				</parameters>
			</method>
			<method name="read" symbol="gst_collect_pads_read">
				<return-type type="guint"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="data" type="GstCollectData*"/>
					<parameter name="bytes" type="guint8**"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="remove_pad" symbol="gst_collect_pads_remove_pad">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="set_flushing" symbol="gst_collect_pads_set_flushing">
				<return-type type="void"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="flushing" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_function" symbol="gst_collect_pads_set_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="func" type="GstCollectPadsFunction"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="start" symbol="gst_collect_pads_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
				</parameters>
			</method>
			<method name="stop" symbol="gst_collect_pads_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
				</parameters>
			</method>
			<field name="data" type="GSList*"/>
			<field name="cookie" type="guint32"/>
			<field name="cond" type="GCond*"/>
			<field name="func" type="GstCollectPadsFunction"/>
			<field name="user_data" type="gpointer"/>
			<field name="numpads" type="guint"/>
			<field name="queuedpads" type="guint"/>
			<field name="eospads" type="guint"/>
			<field name="started" type="gboolean"/>
			<field name="abidata" type="gpointer"/>
		</object>
		<object name="GstDataQueue" parent="GObject" type-name="GstDataQueue" get-type="gst_data_queue_get_type">
			<method name="drop_head" symbol="gst_data_queue_drop_head">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="queue" type="GstDataQueue*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="flush" symbol="gst_data_queue_flush">
				<return-type type="void"/>
				<parameters>
					<parameter name="queue" type="GstDataQueue*"/>
				</parameters>
			</method>
			<method name="get_level" symbol="gst_data_queue_get_level">
				<return-type type="void"/>
				<parameters>
					<parameter name="queue" type="GstDataQueue*"/>
					<parameter name="level" type="GstDataQueueSize*"/>
				</parameters>
			</method>
			<method name="is_empty" symbol="gst_data_queue_is_empty">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="queue" type="GstDataQueue*"/>
				</parameters>
			</method>
			<method name="is_full" symbol="gst_data_queue_is_full">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="queue" type="GstDataQueue*"/>
				</parameters>
			</method>
			<method name="limits_changed" symbol="gst_data_queue_limits_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="queue" type="GstDataQueue*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_data_queue_new">
				<return-type type="GstDataQueue*"/>
				<parameters>
					<parameter name="checkfull" type="GstDataQueueCheckFullFunction"/>
					<parameter name="checkdata" type="gpointer"/>
				</parameters>
			</constructor>
			<method name="pop" symbol="gst_data_queue_pop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="queue" type="GstDataQueue*"/>
					<parameter name="item" type="GstDataQueueItem**"/>
				</parameters>
			</method>
			<method name="push" symbol="gst_data_queue_push">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="queue" type="GstDataQueue*"/>
					<parameter name="item" type="GstDataQueueItem*"/>
				</parameters>
			</method>
			<method name="set_flushing" symbol="gst_data_queue_set_flushing">
				<return-type type="void"/>
				<parameters>
					<parameter name="queue" type="GstDataQueue*"/>
					<parameter name="flushing" type="gboolean"/>
				</parameters>
			</method>
			<property name="current-level-bytes" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="current-level-time" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="current-level-visible" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="empty" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="queue" type="GstDataQueue*"/>
				</parameters>
			</signal>
			<signal name="full" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="queue" type="GstDataQueue*"/>
				</parameters>
			</signal>
			<field name="queue" type="GQueue*"/>
			<field name="cur_level" type="GstDataQueueSize"/>
			<field name="checkfull" type="GstDataQueueCheckFullFunction"/>
			<field name="checkdata" type="gpointer*"/>
			<field name="qlock" type="GMutex*"/>
			<field name="item_add" type="GCond*"/>
			<field name="item_del" type="GCond*"/>
			<field name="flushing" type="gboolean"/>
		</object>
		<object name="GstElement" parent="GstObject" type-name="GstElement" get-type="gst_element_get_type">
			<method name="abort_state" symbol="gst_element_abort_state">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="add_pad" symbol="gst_element_add_pad">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="change_state" symbol="gst_element_change_state">
				<return-type type="GstStateChangeReturn"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="transition" type="GstStateChange"/>
				</parameters>
			</method>
			<method name="class_add_pad_template" symbol="gst_element_class_add_pad_template">
				<return-type type="void"/>
				<parameters>
					<parameter name="klass" type="GstElementClass*"/>
					<parameter name="templ" type="GstPadTemplate*"/>
				</parameters>
			</method>
			<method name="class_get_pad_template" symbol="gst_element_class_get_pad_template">
				<return-type type="GstPadTemplate*"/>
				<parameters>
					<parameter name="element_class" type="GstElementClass*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="class_get_pad_template_list" symbol="gst_element_class_get_pad_template_list">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="element_class" type="GstElementClass*"/>
				</parameters>
			</method>
			<method name="class_install_std_props" symbol="gst_element_class_install_std_props">
				<return-type type="void"/>
				<parameters>
					<parameter name="klass" type="GstElementClass*"/>
					<parameter name="first_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="class_set_details" symbol="gst_element_class_set_details">
				<return-type type="void"/>
				<parameters>
					<parameter name="klass" type="GstElementClass*"/>
					<parameter name="details" type="GstElementDetails*"/>
				</parameters>
			</method>
			<method name="class_set_details_simple" symbol="gst_element_class_set_details_simple">
				<return-type type="void"/>
				<parameters>
					<parameter name="klass" type="GstElementClass*"/>
					<parameter name="longname" type="gchar*"/>
					<parameter name="classification" type="gchar*"/>
					<parameter name="description" type="gchar*"/>
					<parameter name="author" type="gchar*"/>
				</parameters>
			</method>
			<method name="continue_state" symbol="gst_element_continue_state">
				<return-type type="GstStateChangeReturn"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="ret" type="GstStateChangeReturn"/>
				</parameters>
			</method>
			<method name="create_all_pads" symbol="gst_element_create_all_pads">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="found_tags" symbol="gst_element_found_tags">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="list" type="GstTagList*"/>
				</parameters>
			</method>
			<method name="found_tags_for_pad" symbol="gst_element_found_tags_for_pad">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="list" type="GstTagList*"/>
				</parameters>
			</method>
			<method name="get_base_time" symbol="gst_element_get_base_time">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="get_bus" symbol="gst_element_get_bus">
				<return-type type="GstBus*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="get_clock" symbol="gst_element_get_clock">
				<return-type type="GstClock*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="get_compatible_pad" symbol="gst_element_get_compatible_pad">
				<return-type type="GstPad*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="get_compatible_pad_template" symbol="gst_element_get_compatible_pad_template">
				<return-type type="GstPadTemplate*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="compattempl" type="GstPadTemplate*"/>
				</parameters>
			</method>
			<method name="get_factory" symbol="gst_element_get_factory">
				<return-type type="GstElementFactory*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="get_index" symbol="gst_element_get_index">
				<return-type type="GstIndex*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="get_pad" symbol="gst_element_get_pad">
				<return-type type="GstPad*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_query_types" symbol="gst_element_get_query_types">
				<return-type type="GstQueryType*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="get_request_pad" symbol="gst_element_get_request_pad">
				<return-type type="GstPad*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="gst_element_get_state">
				<return-type type="GstStateChangeReturn"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="state" type="GstState*"/>
					<parameter name="pending" type="GstState*"/>
					<parameter name="timeout" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="get_static_pad" symbol="gst_element_get_static_pad">
				<return-type type="GstPad*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="implements_interface" symbol="gst_element_implements_interface">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="iface_type" type="GType"/>
				</parameters>
			</method>
			<method name="is_indexable" symbol="gst_element_is_indexable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="is_locked_state" symbol="gst_element_is_locked_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="iterate_pads" symbol="gst_element_iterate_pads">
				<return-type type="GstIterator*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="iterate_sink_pads" symbol="gst_element_iterate_sink_pads">
				<return-type type="GstIterator*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="iterate_src_pads" symbol="gst_element_iterate_src_pads">
				<return-type type="GstIterator*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="link" symbol="gst_element_link">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstElement*"/>
					<parameter name="dest" type="GstElement*"/>
				</parameters>
			</method>
			<method name="link_filtered" symbol="gst_element_link_filtered">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstElement*"/>
					<parameter name="dest" type="GstElement*"/>
					<parameter name="filter" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="link_many" symbol="gst_element_link_many">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element_1" type="GstElement*"/>
					<parameter name="element_2" type="GstElement*"/>
				</parameters>
			</method>
			<method name="link_pads" symbol="gst_element_link_pads">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstElement*"/>
					<parameter name="srcpadname" type="gchar*"/>
					<parameter name="dest" type="GstElement*"/>
					<parameter name="destpadname" type="gchar*"/>
				</parameters>
			</method>
			<method name="link_pads_filtered" symbol="gst_element_link_pads_filtered">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstElement*"/>
					<parameter name="srcpadname" type="gchar*"/>
					<parameter name="dest" type="GstElement*"/>
					<parameter name="destpadname" type="gchar*"/>
					<parameter name="filter" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="lost_state" symbol="gst_element_lost_state">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="make_from_uri" symbol="gst_element_make_from_uri">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="type" type="GstURIType"/>
					<parameter name="uri" type="gchar*"/>
					<parameter name="elementname" type="gchar*"/>
				</parameters>
			</method>
			<method name="message_full" symbol="gst_element_message_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="type" type="GstMessageType"/>
					<parameter name="domain" type="GQuark"/>
					<parameter name="code" type="gint"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="debug" type="gchar*"/>
					<parameter name="file" type="gchar*"/>
					<parameter name="function" type="gchar*"/>
					<parameter name="line" type="gint"/>
				</parameters>
			</method>
			<method name="no_more_pads" symbol="gst_element_no_more_pads">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="post_message" symbol="gst_element_post_message">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="message" type="GstMessage*"/>
				</parameters>
			</method>
			<method name="provide_clock" symbol="gst_element_provide_clock">
				<return-type type="GstClock*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="provides_clock" symbol="gst_element_provides_clock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="query" symbol="gst_element_query">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="query" type="GstQuery*"/>
				</parameters>
			</method>
			<method name="query_convert" symbol="gst_element_query_convert">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="src_format" type="GstFormat"/>
					<parameter name="src_val" type="gint64"/>
					<parameter name="dest_format" type="GstFormat*"/>
					<parameter name="dest_val" type="gint64*"/>
				</parameters>
			</method>
			<method name="query_duration" symbol="gst_element_query_duration">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="duration" type="gint64*"/>
				</parameters>
			</method>
			<method name="query_position" symbol="gst_element_query_position">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="cur" type="gint64*"/>
				</parameters>
			</method>
			<method name="register" symbol="gst_element_register">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="rank" type="guint"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="release_request_pad" symbol="gst_element_release_request_pad">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="remove_pad" symbol="gst_element_remove_pad">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="requires_clock" symbol="gst_element_requires_clock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="seek" symbol="gst_element_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="rate" type="gdouble"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="flags" type="GstSeekFlags"/>
					<parameter name="cur_type" type="GstSeekType"/>
					<parameter name="cur" type="gint64"/>
					<parameter name="stop_type" type="GstSeekType"/>
					<parameter name="stop" type="gint64"/>
				</parameters>
			</method>
			<method name="seek_simple" symbol="gst_element_seek_simple">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="seek_flags" type="GstSeekFlags"/>
					<parameter name="seek_pos" type="gint64"/>
				</parameters>
			</method>
			<method name="send_event" symbol="gst_element_send_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</method>
			<method name="set_base_time" symbol="gst_element_set_base_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="time" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="set_bus" symbol="gst_element_set_bus">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="bus" type="GstBus*"/>
				</parameters>
			</method>
			<method name="set_clock" symbol="gst_element_set_clock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</method>
			<method name="set_index" symbol="gst_element_set_index">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="index" type="GstIndex*"/>
				</parameters>
			</method>
			<method name="set_locked_state" symbol="gst_element_set_locked_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="locked_state" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_state" symbol="gst_element_set_state">
				<return-type type="GstStateChangeReturn"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="state" type="GstState"/>
				</parameters>
			</method>
			<method name="state_change_return_get_name" symbol="gst_element_state_change_return_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="state_ret" type="GstStateChangeReturn"/>
				</parameters>
			</method>
			<method name="state_get_name" symbol="gst_element_state_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="state" type="GstState"/>
				</parameters>
			</method>
			<method name="sync_state_with_parent" symbol="gst_element_sync_state_with_parent">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="unlink" symbol="gst_element_unlink">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstElement*"/>
					<parameter name="dest" type="GstElement*"/>
				</parameters>
			</method>
			<method name="unlink_many" symbol="gst_element_unlink_many">
				<return-type type="void"/>
				<parameters>
					<parameter name="element_1" type="GstElement*"/>
					<parameter name="element_2" type="GstElement*"/>
				</parameters>
			</method>
			<method name="unlink_pads" symbol="gst_element_unlink_pads">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstElement*"/>
					<parameter name="srcpadname" type="gchar*"/>
					<parameter name="dest" type="GstElement*"/>
					<parameter name="destpadname" type="gchar*"/>
				</parameters>
			</method>
			<signal name="no-more-pads" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</signal>
			<signal name="pad-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</signal>
			<signal name="pad-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</signal>
			<vfunc name="change_state">
				<return-type type="GstStateChangeReturn"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="transition" type="GstStateChange"/>
				</parameters>
			</vfunc>
			<vfunc name="get_index">
				<return-type type="GstIndex*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_query_types">
				<return-type type="GstQueryType*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_state">
				<return-type type="GstStateChangeReturn"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="state" type="GstState*"/>
					<parameter name="pending" type="GstState*"/>
					<parameter name="timeout" type="GstClockTime"/>
				</parameters>
			</vfunc>
			<vfunc name="provide_clock">
				<return-type type="GstClock*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</vfunc>
			<vfunc name="query">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="query" type="GstQuery*"/>
				</parameters>
			</vfunc>
			<vfunc name="release_pad">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</vfunc>
			<vfunc name="request_new_pad">
				<return-type type="GstPad*"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="templ" type="GstPadTemplate*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="send_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_bus">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="bus" type="GstBus*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_clock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_index">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="index" type="GstIndex*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_state">
				<return-type type="GstStateChangeReturn"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="state" type="GstState"/>
				</parameters>
			</vfunc>
			<field name="state_lock" type="GStaticRecMutex*"/>
			<field name="state_cond" type="GCond*"/>
			<field name="state_cookie" type="guint32"/>
			<field name="current_state" type="GstState"/>
			<field name="next_state" type="GstState"/>
			<field name="pending_state" type="GstState"/>
			<field name="last_return" type="GstStateChangeReturn"/>
			<field name="bus" type="GstBus*"/>
			<field name="clock" type="GstClock*"/>
			<field name="base_time" type="GstClockTimeDiff"/>
			<field name="numpads" type="guint16"/>
			<field name="pads" type="GList*"/>
			<field name="numsrcpads" type="guint16"/>
			<field name="srcpads" type="GList*"/>
			<field name="numsinkpads" type="guint16"/>
			<field name="sinkpads" type="GList*"/>
			<field name="pads_cookie" type="guint32"/>
			<field name="abidata" type="gpointer"/>
		</object>
		<object name="GstElementFactory" parent="GstPluginFeature" type-name="GstElementFactory" get-type="gst_element_factory_get_type">
			<method name="can_sink_caps" symbol="gst_element_factory_can_sink_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="can_src_caps" symbol="gst_element_factory_can_src_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="create" symbol="gst_element_factory_create">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="find" symbol="gst_element_factory_find">
				<return-type type="GstElementFactory*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_author" symbol="gst_element_factory_get_author">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="gst_element_factory_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
				</parameters>
			</method>
			<method name="get_element_type" symbol="gst_element_factory_get_element_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
				</parameters>
			</method>
			<method name="get_klass" symbol="gst_element_factory_get_klass">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
				</parameters>
			</method>
			<method name="get_longname" symbol="gst_element_factory_get_longname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
				</parameters>
			</method>
			<method name="get_num_pad_templates" symbol="gst_element_factory_get_num_pad_templates">
				<return-type type="guint"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
				</parameters>
			</method>
			<method name="get_static_pad_templates" symbol="gst_element_factory_get_static_pad_templates">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
				</parameters>
			</method>
			<method name="get_uri_protocols" symbol="gst_element_factory_get_uri_protocols">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
				</parameters>
			</method>
			<method name="get_uri_type" symbol="gst_element_factory_get_uri_type">
				<return-type type="gint"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
				</parameters>
			</method>
			<method name="has_interface" symbol="gst_element_factory_has_interface">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="factory" type="GstElementFactory*"/>
					<parameter name="interfacename" type="gchar*"/>
				</parameters>
			</method>
			<method name="make" symbol="gst_element_factory_make">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="factoryname" type="gchar*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<field name="type" type="GType"/>
			<field name="details" type="GstElementDetails"/>
			<field name="staticpadtemplates" type="GList*"/>
			<field name="numpadtemplates" type="guint"/>
			<field name="uri_type" type="guint"/>
			<field name="uri_protocols" type="gchar**"/>
			<field name="interfaces" type="GList*"/>
		</object>
		<object name="GstIndex" parent="GstObject" type-name="GstIndex" get-type="gst_index_get_type">
			<method name="add_association" symbol="gst_index_add_association">
				<return-type type="GstIndexEntry*"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="id" type="gint"/>
					<parameter name="flags" type="GstAssocFlags"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="value" type="gint64"/>
				</parameters>
			</method>
			<method name="add_associationv" symbol="gst_index_add_associationv">
				<return-type type="GstIndexEntry*"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="id" type="gint"/>
					<parameter name="flags" type="GstAssocFlags"/>
					<parameter name="n" type="gint"/>
					<parameter name="list" type="GstIndexAssociation*"/>
				</parameters>
			</method>
			<method name="add_format" symbol="gst_index_add_format">
				<return-type type="GstIndexEntry*"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="id" type="gint"/>
					<parameter name="format" type="GstFormat"/>
				</parameters>
			</method>
			<method name="add_id" symbol="gst_index_add_id">
				<return-type type="GstIndexEntry*"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="id" type="gint"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_object" symbol="gst_index_add_object">
				<return-type type="GstIndexEntry*"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="id" type="gint"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="type" type="GType"/>
					<parameter name="object" type="gpointer"/>
				</parameters>
			</method>
			<method name="commit" symbol="gst_index_commit">
				<return-type type="void"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="id" type="gint"/>
				</parameters>
			</method>
			<method name="get_assoc_entry" symbol="gst_index_get_assoc_entry">
				<return-type type="GstIndexEntry*"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="id" type="gint"/>
					<parameter name="method" type="GstIndexLookupMethod"/>
					<parameter name="flags" type="GstAssocFlags"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="value" type="gint64"/>
				</parameters>
			</method>
			<method name="get_assoc_entry_full" symbol="gst_index_get_assoc_entry_full">
				<return-type type="GstIndexEntry*"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="id" type="gint"/>
					<parameter name="method" type="GstIndexLookupMethod"/>
					<parameter name="flags" type="GstAssocFlags"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="value" type="gint64"/>
					<parameter name="func" type="GCompareDataFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_certainty" symbol="gst_index_get_certainty">
				<return-type type="GstIndexCertainty"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
				</parameters>
			</method>
			<method name="get_group" symbol="gst_index_get_group">
				<return-type type="gint"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
				</parameters>
			</method>
			<method name="get_writer_id" symbol="gst_index_get_writer_id">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="writer" type="GstObject*"/>
					<parameter name="id" type="gint*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_index_new">
				<return-type type="GstIndex*"/>
			</constructor>
			<constructor name="new_group" symbol="gst_index_new_group">
				<return-type type="gint"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
				</parameters>
			</constructor>
			<method name="set_certainty" symbol="gst_index_set_certainty">
				<return-type type="void"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="certainty" type="GstIndexCertainty"/>
				</parameters>
			</method>
			<method name="set_filter" symbol="gst_index_set_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="filter" type="GstIndexFilter"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_filter_full" symbol="gst_index_set_filter_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="filter" type="GstIndexFilter"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="user_data_destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_group" symbol="gst_index_set_group">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="groupnum" type="gint"/>
				</parameters>
			</method>
			<method name="set_resolver" symbol="gst_index_set_resolver">
				<return-type type="void"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="resolver" type="GstIndexResolver"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<property name="resolver" type="GstIndexResolver" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="entry-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="entry" type="GstIndexEntry*"/>
				</parameters>
			</signal>
			<vfunc name="add_entry">
				<return-type type="void"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="entry" type="GstIndexEntry*"/>
				</parameters>
			</vfunc>
			<vfunc name="commit">
				<return-type type="void"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="id" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_assoc_entry">
				<return-type type="GstIndexEntry*"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="id" type="gint"/>
					<parameter name="method" type="GstIndexLookupMethod"/>
					<parameter name="flags" type="GstAssocFlags"/>
					<parameter name="format" type="GstFormat"/>
					<parameter name="value" type="gint64"/>
					<parameter name="func" type="GCompareDataFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="get_writer_id">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="index" type="GstIndex*"/>
					<parameter name="writer_id" type="gint*"/>
					<parameter name="writer_string" type="gchar*"/>
				</parameters>
			</vfunc>
			<field name="groups" type="GList*"/>
			<field name="curgroup" type="GstIndexGroup*"/>
			<field name="maxgroup" type="gint"/>
			<field name="method" type="GstIndexResolverMethod"/>
			<field name="resolver" type="GstIndexResolver"/>
			<field name="resolver_user_data" type="gpointer"/>
			<field name="filter" type="GstIndexFilter"/>
			<field name="filter_user_data" type="gpointer"/>
			<field name="filter_user_data_destroy" type="GDestroyNotify"/>
			<field name="writers" type="GHashTable*"/>
			<field name="last_id" type="gint"/>
		</object>
		<object name="GstIndexFactory" parent="GstPluginFeature" type-name="GstIndexFactory" get-type="gst_index_factory_get_type">
			<method name="create" symbol="gst_index_factory_create">
				<return-type type="GstIndex*"/>
				<parameters>
					<parameter name="factory" type="GstIndexFactory*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="gst_index_factory_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="factory" type="GstIndexFactory*"/>
				</parameters>
			</method>
			<method name="find" symbol="gst_index_factory_find">
				<return-type type="GstIndexFactory*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="make" symbol="gst_index_factory_make">
				<return-type type="GstIndex*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_index_factory_new">
				<return-type type="GstIndexFactory*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="longdesc" type="gchar*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</constructor>
			<field name="longdesc" type="gchar*"/>
			<field name="type" type="GType"/>
		</object>
		<object name="GstObject" parent="GObject" type-name="GstObject" get-type="gst_object_get_type">
			<method name="check_uniqueness" symbol="gst_object_check_uniqueness">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="GList*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="default_deep_notify" symbol="gst_object_default_deep_notify">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GObject*"/>
					<parameter name="orig" type="GstObject*"/>
					<parameter name="pspec" type="GParamSpec*"/>
					<parameter name="excluded_props" type="gchar**"/>
				</parameters>
			</method>
			<method name="default_error" symbol="gst_object_default_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="source" type="GstObject*"/>
					<parameter name="error" type="GError*"/>
					<parameter name="debug" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gst_object_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
				</parameters>
			</method>
			<method name="get_name_prefix" symbol="gst_object_get_name_prefix">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="gst_object_get_parent">
				<return-type type="GstObject*"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
				</parameters>
			</method>
			<method name="get_path_string" symbol="gst_object_get_path_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
				</parameters>
			</method>
			<method name="has_ancestor" symbol="gst_object_has_ancestor">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="ancestor" type="GstObject*"/>
				</parameters>
			</method>
			<method name="ref" symbol="gst_object_ref">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="object" type="gpointer"/>
				</parameters>
			</method>
			<method name="replace" symbol="gst_object_replace">
				<return-type type="void"/>
				<parameters>
					<parameter name="oldobj" type="GstObject**"/>
					<parameter name="newobj" type="GstObject*"/>
				</parameters>
			</method>
			<method name="restore_thyself" symbol="gst_object_restore_thyself">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="self" type="xmlNodePtr"/>
				</parameters>
			</method>
			<method name="save_thyself" symbol="gst_object_save_thyself">
				<return-type type="xmlNodePtr"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="parent" type="xmlNodePtr"/>
				</parameters>
			</method>
			<method name="set_name" symbol="gst_object_set_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name_prefix" symbol="gst_object_set_name_prefix">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="name_prefix" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_parent" symbol="gst_object_set_parent">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="parent" type="GstObject*"/>
				</parameters>
			</method>
			<method name="sink" symbol="gst_object_sink">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="gpointer"/>
				</parameters>
			</method>
			<method name="unparent" symbol="gst_object_unparent">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gst_object_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="gpointer"/>
				</parameters>
			</method>
			<property name="name" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="deep-notify" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="orig" type="GstObject*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</signal>
			<signal name="object-saved" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="parent" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="parent-set" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="parent" type="GstObject*"/>
				</parameters>
			</signal>
			<signal name="parent-unset" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="parent" type="GstObject*"/>
				</parameters>
			</signal>
			<vfunc name="restore_thyself">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="self" type="xmlNodePtr"/>
				</parameters>
			</vfunc>
			<vfunc name="save_thyself">
				<return-type type="xmlNodePtr"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="parent" type="xmlNodePtr"/>
				</parameters>
			</vfunc>
			<field name="refcount" type="gint"/>
			<field name="lock" type="GMutex*"/>
			<field name="name" type="gchar*"/>
			<field name="name_prefix" type="gchar*"/>
			<field name="parent" type="GstObject*"/>
			<field name="flags" type="guint32"/>
		</object>
		<object name="GstPad" parent="GstObject" type-name="GstPad" get-type="gst_pad_get_type">
			<method name="accept_caps" symbol="gst_pad_accept_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="activate_pull" symbol="gst_pad_activate_pull">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="active" type="gboolean"/>
				</parameters>
			</method>
			<method name="activate_push" symbol="gst_pad_activate_push">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="active" type="gboolean"/>
				</parameters>
			</method>
			<method name="add_buffer_probe" symbol="gst_pad_add_buffer_probe">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="handler" type="GCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="add_data_probe" symbol="gst_pad_add_data_probe">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="handler" type="GCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="add_event_probe" symbol="gst_pad_add_event_probe">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="handler" type="GCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="alloc_buffer" symbol="gst_pad_alloc_buffer">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="offset" type="guint64"/>
					<parameter name="size" type="gint"/>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="buf" type="GstBuffer**"/>
				</parameters>
			</method>
			<method name="alloc_buffer_and_set_caps" symbol="gst_pad_alloc_buffer_and_set_caps">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="offset" type="guint64"/>
					<parameter name="size" type="gint"/>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="buf" type="GstBuffer**"/>
				</parameters>
			</method>
			<method name="can_link" symbol="gst_pad_can_link">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="srcpad" type="GstPad*"/>
					<parameter name="sinkpad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="chain" symbol="gst_pad_chain">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="check_pull_range" symbol="gst_pad_check_pull_range">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="dispatcher" symbol="gst_pad_dispatcher">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="dispatch" type="GstPadDispatcherFunction"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="event_default" symbol="gst_pad_event_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</method>
			<method name="fixate_caps" symbol="gst_pad_fixate_caps">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="get_allowed_caps" symbol="gst_pad_get_allowed_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_caps" symbol="gst_pad_get_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_direction" symbol="gst_pad_get_direction">
				<return-type type="GstPadDirection"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_element_private" symbol="gst_pad_get_element_private">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_fixed_caps_func" symbol="gst_pad_get_fixed_caps_func">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_internal_links" symbol="gst_pad_get_internal_links">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_internal_links_default" symbol="gst_pad_get_internal_links_default">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_negotiated_caps" symbol="gst_pad_get_negotiated_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_pad_template" symbol="gst_pad_get_pad_template">
				<return-type type="GstPadTemplate*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_pad_template_caps" symbol="gst_pad_get_pad_template_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_parent_element" symbol="gst_pad_get_parent_element">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_peer" symbol="gst_pad_get_peer">
				<return-type type="GstPad*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_query_types" symbol="gst_pad_get_query_types">
				<return-type type="GstQueryType*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_query_types_default" symbol="gst_pad_get_query_types_default">
				<return-type type="GstQueryType*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="get_range" symbol="gst_pad_get_range">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="offset" type="guint64"/>
					<parameter name="size" type="guint"/>
					<parameter name="buffer" type="GstBuffer**"/>
				</parameters>
			</method>
			<method name="is_active" symbol="gst_pad_is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="is_blocked" symbol="gst_pad_is_blocked">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="is_blocking" symbol="gst_pad_is_blocking">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="is_linked" symbol="gst_pad_is_linked">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="link" symbol="gst_pad_link">
				<return-type type="GstPadLinkReturn"/>
				<parameters>
					<parameter name="srcpad" type="GstPad*"/>
					<parameter name="sinkpad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="load_and_link" symbol="gst_pad_load_and_link">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="xmlNodePtr"/>
					<parameter name="parent" type="GstObject*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_pad_new">
				<return-type type="GstPad*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="direction" type="GstPadDirection"/>
				</parameters>
			</constructor>
			<constructor name="new_from_static_template" symbol="gst_pad_new_from_static_template">
				<return-type type="GstPad*"/>
				<parameters>
					<parameter name="templ" type="GstStaticPadTemplate*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_template" symbol="gst_pad_new_from_template">
				<return-type type="GstPad*"/>
				<parameters>
					<parameter name="templ" type="GstPadTemplate*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="pause_task" symbol="gst_pad_pause_task">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="peer_accept_caps" symbol="gst_pad_peer_accept_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="peer_get_caps" symbol="gst_pad_peer_get_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="peer_query" symbol="gst_pad_peer_query">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="query" type="GstQuery*"/>
				</parameters>
			</method>
			<method name="proxy_getcaps" symbol="gst_pad_proxy_getcaps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="proxy_setcaps" symbol="gst_pad_proxy_setcaps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="pull_range" symbol="gst_pad_pull_range">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="offset" type="guint64"/>
					<parameter name="size" type="guint"/>
					<parameter name="buffer" type="GstBuffer**"/>
				</parameters>
			</method>
			<method name="push" symbol="gst_pad_push">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="push_event" symbol="gst_pad_push_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</method>
			<method name="query" symbol="gst_pad_query">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="query" type="GstQuery*"/>
				</parameters>
			</method>
			<method name="query_convert" symbol="gst_pad_query_convert">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="src_format" type="GstFormat"/>
					<parameter name="src_val" type="gint64"/>
					<parameter name="dest_format" type="GstFormat*"/>
					<parameter name="dest_val" type="gint64*"/>
				</parameters>
			</method>
			<method name="query_default" symbol="gst_pad_query_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="query" type="GstQuery*"/>
				</parameters>
			</method>
			<method name="query_duration" symbol="gst_pad_query_duration">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="duration" type="gint64*"/>
				</parameters>
			</method>
			<method name="query_peer_convert" symbol="gst_pad_query_peer_convert">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="src_format" type="GstFormat"/>
					<parameter name="src_val" type="gint64"/>
					<parameter name="dest_format" type="GstFormat*"/>
					<parameter name="dest_val" type="gint64*"/>
				</parameters>
			</method>
			<method name="query_peer_duration" symbol="gst_pad_query_peer_duration">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="duration" type="gint64*"/>
				</parameters>
			</method>
			<method name="query_peer_position" symbol="gst_pad_query_peer_position">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="cur" type="gint64*"/>
				</parameters>
			</method>
			<method name="query_position" symbol="gst_pad_query_position">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="format" type="GstFormat*"/>
					<parameter name="cur" type="gint64*"/>
				</parameters>
			</method>
			<method name="remove_buffer_probe" symbol="gst_pad_remove_buffer_probe">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="handler_id" type="guint"/>
				</parameters>
			</method>
			<method name="remove_data_probe" symbol="gst_pad_remove_data_probe">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="handler_id" type="guint"/>
				</parameters>
			</method>
			<method name="remove_event_probe" symbol="gst_pad_remove_event_probe">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="handler_id" type="guint"/>
				</parameters>
			</method>
			<method name="send_event" symbol="gst_pad_send_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</method>
			<method name="set_acceptcaps_function" symbol="gst_pad_set_acceptcaps_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="acceptcaps" type="GstPadAcceptCapsFunction"/>
				</parameters>
			</method>
			<method name="set_activate_function" symbol="gst_pad_set_activate_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="activate" type="GstPadActivateFunction"/>
				</parameters>
			</method>
			<method name="set_activatepull_function" symbol="gst_pad_set_activatepull_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="activatepull" type="GstPadActivateModeFunction"/>
				</parameters>
			</method>
			<method name="set_activatepush_function" symbol="gst_pad_set_activatepush_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="activatepush" type="GstPadActivateModeFunction"/>
				</parameters>
			</method>
			<method name="set_active" symbol="gst_pad_set_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="active" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_blocked" symbol="gst_pad_set_blocked">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="blocked" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_blocked_async" symbol="gst_pad_set_blocked_async">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="blocked" type="gboolean"/>
					<parameter name="callback" type="GstPadBlockCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_bufferalloc_function" symbol="gst_pad_set_bufferalloc_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="bufalloc" type="GstPadBufferAllocFunction"/>
				</parameters>
			</method>
			<method name="set_caps" symbol="gst_pad_set_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="set_chain_function" symbol="gst_pad_set_chain_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="chain" type="GstPadChainFunction"/>
				</parameters>
			</method>
			<method name="set_checkgetrange_function" symbol="gst_pad_set_checkgetrange_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="check" type="GstPadCheckGetRangeFunction"/>
				</parameters>
			</method>
			<method name="set_element_private" symbol="gst_pad_set_element_private">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="priv" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_event_function" symbol="gst_pad_set_event_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="event" type="GstPadEventFunction"/>
				</parameters>
			</method>
			<method name="set_fixatecaps_function" symbol="gst_pad_set_fixatecaps_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="fixatecaps" type="GstPadFixateCapsFunction"/>
				</parameters>
			</method>
			<method name="set_getcaps_function" symbol="gst_pad_set_getcaps_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="getcaps" type="GstPadGetCapsFunction"/>
				</parameters>
			</method>
			<method name="set_getrange_function" symbol="gst_pad_set_getrange_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="get" type="GstPadGetRangeFunction"/>
				</parameters>
			</method>
			<method name="set_internal_link_function" symbol="gst_pad_set_internal_link_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="intlink" type="GstPadIntLinkFunction"/>
				</parameters>
			</method>
			<method name="set_link_function" symbol="gst_pad_set_link_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="link" type="GstPadLinkFunction"/>
				</parameters>
			</method>
			<method name="set_query_function" symbol="gst_pad_set_query_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="query" type="GstPadQueryFunction"/>
				</parameters>
			</method>
			<method name="set_query_type_function" symbol="gst_pad_set_query_type_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="type_func" type="GstPadQueryTypeFunction"/>
				</parameters>
			</method>
			<method name="set_setcaps_function" symbol="gst_pad_set_setcaps_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="setcaps" type="GstPadSetCapsFunction"/>
				</parameters>
			</method>
			<method name="set_unlink_function" symbol="gst_pad_set_unlink_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="unlink" type="GstPadUnlinkFunction"/>
				</parameters>
			</method>
			<method name="start_task" symbol="gst_pad_start_task">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="func" type="GstTaskFunction"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="stop_task" symbol="gst_pad_stop_task">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="unlink" symbol="gst_pad_unlink">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="srcpad" type="GstPad*"/>
					<parameter name="sinkpad" type="GstPad*"/>
				</parameters>
			</method>
			<method name="use_fixed_caps" symbol="gst_pad_use_fixed_caps">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<property name="caps" type="GstCaps*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="direction" type="GstPadDirection" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="template" type="GstPadTemplate*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="have-data" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="data" type="GstMiniObject"/>
				</parameters>
			</signal>
			<signal name="linked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="peer" type="GstPad*"/>
				</parameters>
			</signal>
			<signal name="request-link" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</signal>
			<signal name="unlinked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="peer" type="GstPad*"/>
				</parameters>
			</signal>
			<field name="element_private" type="gpointer"/>
			<field name="padtemplate" type="GstPadTemplate*"/>
			<field name="direction" type="GstPadDirection"/>
			<field name="stream_rec_lock" type="GStaticRecMutex*"/>
			<field name="task" type="GstTask*"/>
			<field name="preroll_lock" type="GMutex*"/>
			<field name="preroll_cond" type="GCond*"/>
			<field name="block_cond" type="GCond*"/>
			<field name="block_callback" type="GstPadBlockCallback"/>
			<field name="block_data" type="gpointer"/>
			<field name="caps" type="GstCaps*"/>
			<field name="getcapsfunc" type="GstPadGetCapsFunction"/>
			<field name="setcapsfunc" type="GstPadSetCapsFunction"/>
			<field name="acceptcapsfunc" type="GstPadAcceptCapsFunction"/>
			<field name="fixatecapsfunc" type="GstPadFixateCapsFunction"/>
			<field name="activatefunc" type="GstPadActivateFunction"/>
			<field name="activatepushfunc" type="GstPadActivateModeFunction"/>
			<field name="activatepullfunc" type="GstPadActivateModeFunction"/>
			<field name="linkfunc" type="GstPadLinkFunction"/>
			<field name="unlinkfunc" type="GstPadUnlinkFunction"/>
			<field name="peer" type="GstPad*"/>
			<field name="sched_private" type="gpointer"/>
			<field name="chainfunc" type="GstPadChainFunction"/>
			<field name="checkgetrangefunc" type="GstPadCheckGetRangeFunction"/>
			<field name="getrangefunc" type="GstPadGetRangeFunction"/>
			<field name="eventfunc" type="GstPadEventFunction"/>
			<field name="mode" type="GstActivateMode"/>
			<field name="querytypefunc" type="GstPadQueryTypeFunction"/>
			<field name="queryfunc" type="GstPadQueryFunction"/>
			<field name="intlinkfunc" type="GstPadIntLinkFunction"/>
			<field name="bufferallocfunc" type="GstPadBufferAllocFunction"/>
			<field name="do_buffer_signals" type="gint"/>
			<field name="do_event_signals" type="gint"/>
		</object>
		<object name="GstPadTemplate" parent="GstObject" type-name="GstPadTemplate" get-type="gst_pad_template_get_type">
			<method name="get_caps" symbol="gst_pad_template_get_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="templ" type="GstPadTemplate*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_pad_template_new">
				<return-type type="GstPadTemplate*"/>
				<parameters>
					<parameter name="name_template" type="gchar*"/>
					<parameter name="direction" type="GstPadDirection"/>
					<parameter name="presence" type="GstPadPresence"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</constructor>
			<method name="pad_created" symbol="gst_pad_template_pad_created">
				<return-type type="void"/>
				<parameters>
					<parameter name="templ" type="GstPadTemplate*"/>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</method>
			<signal name="pad-created" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="templ" type="GstPadTemplate*"/>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</signal>
			<field name="name_template" type="gchar*"/>
			<field name="direction" type="GstPadDirection"/>
			<field name="presence" type="GstPadPresence"/>
			<field name="caps" type="GstCaps*"/>
		</object>
		<object name="GstPipeline" parent="GstBin" type-name="GstPipeline" get-type="gst_pipeline_get_type">
			<implements>
				<interface name="GstChildProxy"/>
			</implements>
			<method name="auto_clock" symbol="gst_pipeline_auto_clock">
				<return-type type="void"/>
				<parameters>
					<parameter name="pipeline" type="GstPipeline*"/>
				</parameters>
			</method>
			<method name="get_auto_flush_bus" symbol="gst_pipeline_get_auto_flush_bus">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pipeline" type="GstPipeline*"/>
				</parameters>
			</method>
			<method name="get_bus" symbol="gst_pipeline_get_bus">
				<return-type type="GstBus*"/>
				<parameters>
					<parameter name="pipeline" type="GstPipeline*"/>
				</parameters>
			</method>
			<method name="get_clock" symbol="gst_pipeline_get_clock">
				<return-type type="GstClock*"/>
				<parameters>
					<parameter name="pipeline" type="GstPipeline*"/>
				</parameters>
			</method>
			<method name="get_delay" symbol="gst_pipeline_get_delay">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="pipeline" type="GstPipeline*"/>
				</parameters>
			</method>
			<method name="get_last_stream_time" symbol="gst_pipeline_get_last_stream_time">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="pipeline" type="GstPipeline*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_pipeline_new">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_auto_flush_bus" symbol="gst_pipeline_set_auto_flush_bus">
				<return-type type="void"/>
				<parameters>
					<parameter name="pipeline" type="GstPipeline*"/>
					<parameter name="auto_flush" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_clock" symbol="gst_pipeline_set_clock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pipeline" type="GstPipeline*"/>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</method>
			<method name="set_delay" symbol="gst_pipeline_set_delay">
				<return-type type="void"/>
				<parameters>
					<parameter name="pipeline" type="GstPipeline*"/>
					<parameter name="delay" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="set_new_stream_time" symbol="gst_pipeline_set_new_stream_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="pipeline" type="GstPipeline*"/>
					<parameter name="time" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="use_clock" symbol="gst_pipeline_use_clock">
				<return-type type="void"/>
				<parameters>
					<parameter name="pipeline" type="GstPipeline*"/>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</method>
			<property name="auto-flush-bus" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="delay" type="guint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="fixed_clock" type="GstClock*"/>
			<field name="stream_time" type="GstClockTime"/>
			<field name="delay" type="GstClockTime"/>
		</object>
		<object name="GstPlugin" parent="GstObject" type-name="GstPlugin" get-type="gst_plugin_get_type">
			<method name="error_quark" symbol="gst_plugin_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_description" symbol="gst_plugin_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="get_filename" symbol="gst_plugin_get_filename">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="get_license" symbol="gst_plugin_get_license">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="get_module" symbol="gst_plugin_get_module">
				<return-type type="GModule*"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gst_plugin_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="get_origin" symbol="gst_plugin_get_origin">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="get_package" symbol="gst_plugin_get_package">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="get_source" symbol="gst_plugin_get_source">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="get_version" symbol="gst_plugin_get_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="is_loaded" symbol="gst_plugin_is_loaded">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="list_free" symbol="gst_plugin_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="load" symbol="gst_plugin_load">
				<return-type type="GstPlugin*"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="load_by_name" symbol="gst_plugin_load_by_name">
				<return-type type="GstPlugin*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="load_file" symbol="gst_plugin_load_file">
				<return-type type="GstPlugin*"/>
				<parameters>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="name_filter" symbol="gst_plugin_name_filter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="GstPlugin*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<field name="desc" type="GstPluginDesc"/>
			<field name="orig_desc" type="GstPluginDesc*"/>
			<field name="flags" type="unsigned"/>
			<field name="filename" type="gchar*"/>
			<field name="basename" type="gchar*"/>
			<field name="module" type="GModule*"/>
			<field name="file_size" type="off_t"/>
			<field name="file_mtime" type="time_t"/>
			<field name="registered" type="gboolean"/>
		</object>
		<object name="GstPluginFeature" parent="GstObject" type-name="GstPluginFeature" get-type="gst_plugin_feature_get_type">
			<method name="check_version" symbol="gst_plugin_feature_check_version">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="feature" type="GstPluginFeature*"/>
					<parameter name="min_major" type="guint"/>
					<parameter name="min_minor" type="guint"/>
					<parameter name="min_micro" type="guint"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gst_plugin_feature_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="feature" type="GstPluginFeature*"/>
				</parameters>
			</method>
			<method name="get_rank" symbol="gst_plugin_feature_get_rank">
				<return-type type="guint"/>
				<parameters>
					<parameter name="feature" type="GstPluginFeature*"/>
				</parameters>
			</method>
			<method name="list_free" symbol="gst_plugin_feature_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="load" symbol="gst_plugin_feature_load">
				<return-type type="GstPluginFeature*"/>
				<parameters>
					<parameter name="feature" type="GstPluginFeature*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="gst_plugin_feature_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="feature" type="GstPluginFeature*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_rank" symbol="gst_plugin_feature_set_rank">
				<return-type type="void"/>
				<parameters>
					<parameter name="feature" type="GstPluginFeature*"/>
					<parameter name="rank" type="guint"/>
				</parameters>
			</method>
			<method name="type_name_filter" symbol="gst_plugin_feature_type_name_filter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="feature" type="GstPluginFeature*"/>
					<parameter name="data" type="GstTypeNameData*"/>
				</parameters>
			</method>
			<field name="loaded" type="gboolean"/>
			<field name="name" type="gchar*"/>
			<field name="rank" type="guint"/>
			<field name="plugin_name" type="gchar*"/>
		</object>
		<object name="GstPushSrc" parent="GstBaseSrc" type-name="GstPushSrc" get-type="gst_push_src_get_type">
			<vfunc name="create">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="src" type="GstPushSrc*"/>
					<parameter name="buf" type="GstBuffer**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GstRegistry" parent="GstObject" type-name="GstRegistry" get-type="gst_registry_get_type">
			<method name="add_feature" symbol="gst_registry_add_feature">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="feature" type="GstPluginFeature*"/>
				</parameters>
			</method>
			<method name="add_path" symbol="gst_registry_add_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_plugin" symbol="gst_registry_add_plugin">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="feature_filter" symbol="gst_registry_feature_filter">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="filter" type="GstPluginFeatureFilter"/>
					<parameter name="first" type="gboolean"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="find_feature" symbol="gst_registry_find_feature">
				<return-type type="GstPluginFeature*"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="find_plugin" symbol="gst_registry_find_plugin">
				<return-type type="GstPlugin*"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="fork_is_enabled" symbol="gst_registry_fork_is_enabled">
				<return-type type="gboolean"/>
			</method>
			<method name="fork_set_enabled" symbol="gst_registry_fork_set_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="enabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_default" symbol="gst_registry_get_default">
				<return-type type="GstRegistry*"/>
			</method>
			<method name="get_feature_list" symbol="gst_registry_get_feature_list">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="get_feature_list_by_plugin" symbol="gst_registry_get_feature_list_by_plugin">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_path_list" symbol="gst_registry_get_path_list">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
				</parameters>
			</method>
			<method name="get_plugin_list" symbol="gst_registry_get_plugin_list">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
				</parameters>
			</method>
			<method name="lookup" symbol="gst_registry_lookup">
				<return-type type="GstPlugin*"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="filename" type="char*"/>
				</parameters>
			</method>
			<method name="lookup_feature" symbol="gst_registry_lookup_feature">
				<return-type type="GstPluginFeature*"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="plugin_filter" symbol="gst_registry_plugin_filter">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="filter" type="GstPluginFilter"/>
					<parameter name="first" type="gboolean"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="remove_feature" symbol="gst_registry_remove_feature">
				<return-type type="void"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="feature" type="GstPluginFeature*"/>
				</parameters>
			</method>
			<method name="remove_plugin" symbol="gst_registry_remove_plugin">
				<return-type type="void"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="plugin" type="GstPlugin*"/>
				</parameters>
			</method>
			<method name="scan_path" symbol="gst_registry_scan_path">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="xml_read_cache" symbol="gst_registry_xml_read_cache">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="location" type="char*"/>
				</parameters>
			</method>
			<method name="xml_write_cache" symbol="gst_registry_xml_write_cache">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="location" type="char*"/>
				</parameters>
			</method>
			<signal name="feature-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="feature" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="plugin-added" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="registry" type="GstRegistry*"/>
					<parameter name="plugin" type="gpointer"/>
				</parameters>
			</signal>
			<field name="plugins" type="GList*"/>
			<field name="features" type="GList*"/>
			<field name="paths" type="GList*"/>
			<field name="cache_file" type="int"/>
			<field name="feature_hash" type="GHashTable*"/>
		</object>
		<object name="GstSystemClock" parent="GstClock" type-name="GstSystemClock" get-type="gst_system_clock_get_type">
			<method name="obtain" symbol="gst_system_clock_obtain">
				<return-type type="GstClock*"/>
			</method>
			<field name="thread" type="GThread*"/>
			<field name="stopping" type="gboolean"/>
		</object>
		<object name="GstTask" parent="GstObject" type-name="GstTask" get-type="gst_task_get_type">
			<method name="cleanup_all" symbol="gst_task_cleanup_all">
				<return-type type="void"/>
			</method>
			<method name="create" symbol="gst_task_create">
				<return-type type="GstTask*"/>
				<parameters>
					<parameter name="func" type="GstTaskFunction"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_state" symbol="gst_task_get_state">
				<return-type type="GstTaskState"/>
				<parameters>
					<parameter name="task" type="GstTask*"/>
				</parameters>
			</method>
			<method name="join" symbol="gst_task_join">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="task" type="GstTask*"/>
				</parameters>
			</method>
			<method name="pause" symbol="gst_task_pause">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="task" type="GstTask*"/>
				</parameters>
			</method>
			<method name="set_lock" symbol="gst_task_set_lock">
				<return-type type="void"/>
				<parameters>
					<parameter name="task" type="GstTask*"/>
					<parameter name="mutex" type="GStaticRecMutex*"/>
				</parameters>
			</method>
			<method name="start" symbol="gst_task_start">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="task" type="GstTask*"/>
				</parameters>
			</method>
			<method name="stop" symbol="gst_task_stop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="task" type="GstTask*"/>
				</parameters>
			</method>
			<field name="state" type="GstTaskState"/>
			<field name="cond" type="GCond*"/>
			<field name="lock" type="GStaticRecMutex*"/>
			<field name="func" type="GstTaskFunction"/>
			<field name="data" type="gpointer"/>
			<field name="running" type="gboolean"/>
			<field name="abidata" type="gpointer"/>
		</object>
		<object name="GstTypeFindFactory" parent="GstPluginFeature" type-name="GstTypeFindFactory" get-type="gst_type_find_factory_get_type">
			<method name="call_function" symbol="gst_type_find_factory_call_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="factory" type="GstTypeFindFactory*"/>
					<parameter name="find" type="GstTypeFind*"/>
				</parameters>
			</method>
			<method name="get_caps" symbol="gst_type_find_factory_get_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="factory" type="GstTypeFindFactory*"/>
				</parameters>
			</method>
			<method name="get_extensions" symbol="gst_type_find_factory_get_extensions">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="factory" type="GstTypeFindFactory*"/>
				</parameters>
			</method>
			<method name="get_list" symbol="gst_type_find_factory_get_list">
				<return-type type="GList*"/>
			</method>
			<field name="function" type="GstTypeFindFunction"/>
			<field name="extensions" type="gchar**"/>
			<field name="caps" type="GstCaps*"/>
			<field name="user_data" type="gpointer"/>
			<field name="user_data_notify" type="GDestroyNotify"/>
		</object>
		<object name="GstXML" parent="GstObject" type-name="GstXML" get-type="gst_xml_get_type">
			<method name="get_element" symbol="gst_xml_get_element">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="xml" type="GstXML*"/>
					<parameter name="name" type="guchar*"/>
				</parameters>
			</method>
			<method name="get_topelements" symbol="gst_xml_get_topelements">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="xml" type="GstXML*"/>
				</parameters>
			</method>
			<method name="make_element" symbol="gst_xml_make_element">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="cur" type="xmlNodePtr"/>
					<parameter name="parent" type="GstObject*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_xml_new">
				<return-type type="GstXML*"/>
			</constructor>
			<method name="parse_doc" symbol="gst_xml_parse_doc">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="xml" type="GstXML*"/>
					<parameter name="doc" type="xmlDocPtr"/>
					<parameter name="root" type="guchar*"/>
				</parameters>
			</method>
			<method name="parse_file" symbol="gst_xml_parse_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="xml" type="GstXML*"/>
					<parameter name="fname" type="guchar*"/>
					<parameter name="root" type="guchar*"/>
				</parameters>
			</method>
			<method name="parse_memory" symbol="gst_xml_parse_memory">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="xml" type="GstXML*"/>
					<parameter name="buffer" type="guchar*"/>
					<parameter name="size" type="guint"/>
					<parameter name="root" type="gchar*"/>
				</parameters>
			</method>
			<method name="write" symbol="gst_xml_write">
				<return-type type="xmlDocPtr"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
				</parameters>
			</method>
			<method name="write_file" symbol="gst_xml_write_file">
				<return-type type="gint"/>
				<parameters>
					<parameter name="element" type="GstElement*"/>
					<parameter name="out" type="FILE*"/>
				</parameters>
			</method>
			<signal name="object-loaded" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="xml" type="GstXML*"/>
					<parameter name="object" type="GstObject*"/>
					<parameter name="self" type="gpointer"/>
				</parameters>
			</signal>
			<vfunc name="object_saved">
				<return-type type="void"/>
				<parameters>
					<parameter name="xml" type="GstXML*"/>
					<parameter name="object" type="GstObject*"/>
					<parameter name="self" type="xmlNodePtr"/>
				</parameters>
			</vfunc>
			<field name="topelements" type="GList*"/>
			<field name="ns" type="xmlNsPtr"/>
		</object>
		<interface name="GstChildProxy" type-name="GstChildProxy" get-type="gst_child_proxy_get_type">
			<requires>
				<interface name="GstObject"/>
			</requires>
			<method name="child_added" symbol="gst_child_proxy_child_added">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="child" type="GstObject*"/>
				</parameters>
			</method>
			<method name="child_removed" symbol="gst_child_proxy_child_removed">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="child" type="GstObject*"/>
				</parameters>
			</method>
			<method name="get" symbol="gst_child_proxy_get">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="first_property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_child_by_index" symbol="gst_child_proxy_get_child_by_index">
				<return-type type="GstObject*"/>
				<parameters>
					<parameter name="parent" type="GstChildProxy*"/>
					<parameter name="index" type="guint"/>
				</parameters>
			</method>
			<method name="get_child_by_name" symbol="gst_child_proxy_get_child_by_name">
				<return-type type="GstObject*"/>
				<parameters>
					<parameter name="parent" type="GstChildProxy*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_children_count" symbol="gst_child_proxy_get_children_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="parent" type="GstChildProxy*"/>
				</parameters>
			</method>
			<method name="get_property" symbol="gst_child_proxy_get_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_valist" symbol="gst_child_proxy_get_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="first_property_name" type="gchar*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</method>
			<method name="lookup" symbol="gst_child_proxy_lookup">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="target" type="GstObject**"/>
					<parameter name="pspec" type="GParamSpec**"/>
				</parameters>
			</method>
			<method name="set" symbol="gst_child_proxy_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="first_property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_property" symbol="gst_child_proxy_set_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_valist" symbol="gst_child_proxy_set_valist">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GstObject*"/>
					<parameter name="first_property_name" type="gchar*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</method>
			<signal name="child-added" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="parent" type="GstChildProxy*"/>
					<parameter name="child" type="GObject*"/>
				</parameters>
			</signal>
			<signal name="child-removed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="parent" type="GstChildProxy*"/>
					<parameter name="child" type="GObject*"/>
				</parameters>
			</signal>
			<vfunc name="get_child_by_index">
				<return-type type="GstObject*"/>
				<parameters>
					<parameter name="parent" type="GstChildProxy*"/>
					<parameter name="index" type="guint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_children_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="parent" type="GstChildProxy*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GstImplementsInterface" type-name="GstImplementsInterface" get-type="gst_implements_interface_get_type">
			<requires>
				<interface name="GstElement"/>
			</requires>
			<method name="cast" symbol="gst_implements_interface_cast">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="from" type="gpointer"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="check" symbol="gst_implements_interface_check">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="from" type="gpointer"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<vfunc name="supported">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iface" type="GstImplementsInterface*"/>
					<parameter name="iface_type" type="GType"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GstURIHandler" type-name="GstURIHandler" get-type="gst_uri_handler_get_type">
			<method name="get_protocols" symbol="gst_uri_handler_get_protocols">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="handler" type="GstURIHandler*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="gst_uri_handler_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="handler" type="GstURIHandler*"/>
				</parameters>
			</method>
			<method name="get_uri_type" symbol="gst_uri_handler_get_uri_type">
				<return-type type="guint"/>
				<parameters>
					<parameter name="handler" type="GstURIHandler*"/>
				</parameters>
			</method>
			<method name="new_uri" symbol="gst_uri_handler_new_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="handler" type="GstURIHandler*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_uri" symbol="gst_uri_handler_set_uri">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="handler" type="GstURIHandler*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<signal name="new-uri" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="handler" type="GstURIHandler*"/>
					<parameter name="uri" type="char*"/>
				</parameters>
			</signal>
			<vfunc name="get_protocols">
				<return-type type="gchar**"/>
			</vfunc>
			<vfunc name="get_protocols_full">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="type" type="GType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_type">
				<return-type type="GstURIType"/>
			</vfunc>
			<vfunc name="get_type_full">
				<return-type type="GstURIType"/>
				<parameters>
					<parameter name="type" type="GType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="handler" type="GstURIHandler*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_uri">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="handler" type="GstURIHandler*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="GST_BASE_TRANSFORM_SINK_NAME" type="char*" value="sink"/>
		<constant name="GST_BASE_TRANSFORM_SRC_NAME" type="char*" value="src"/>
		<constant name="GST_BUFFER_COPY_ALL" type="int" value="0"/>
		<constant name="GST_BUFFER_OFFSET_NONE" type="int" value="-1"/>
		<constant name="GST_BUFFER_TRACE_NAME" type="char*" value="GstBuffer"/>
		<constant name="GST_CLOCK_ENTRY_TRACE_NAME" type="char*" value="GstClockEntry"/>
		<constant name="GST_CLOCK_TIME_NONE" type="int" value="-1"/>
		<constant name="GST_DEBUG_BG_MASK" type="int" value="240"/>
		<constant name="GST_DEBUG_FG_MASK" type="int" value="15"/>
		<constant name="GST_DEBUG_FORMAT_MASK" type="int" value="65280"/>
		<constant name="GST_EVENT_TRACE_NAME" type="char*" value="GstEvent"/>
		<constant name="GST_EVENT_TYPE_BOTH" type="int" value="0"/>
		<constant name="GST_EVENT_TYPE_SHIFT" type="int" value="4"/>
		<constant name="GST_FOURCC_FORMAT" type="char*" value="c 3	"/>
		<constant name="GST_INDEX_ID_INVALID" type="int" value="-1"/>
		<constant name="GST_LICENSE_UNKNOWN" type="char*" value="unknown"/>
		<constant name="GST_MESSAGE_TRACE_NAME" type="char*" value="GstMessage"/>
		<constant name="GST_MSECOND" type="int" value="0"/>
		<constant name="GST_NSECOND" type="int" value="0"/>
		<constant name="GST_SECOND" type="int" value="0"/>
		<constant name="GST_TAG_ALBUM" type="char*" value="album"/>
		<constant name="GST_TAG_ALBUM_GAIN" type="char*" value="replaygain-album-gain"/>
		<constant name="GST_TAG_ALBUM_PEAK" type="char*" value="replaygain-album-peak"/>
		<constant name="GST_TAG_ALBUM_SORTNAME" type="char*" value="album-sortname"/>
		<constant name="GST_TAG_ALBUM_VOLUME_COUNT" type="char*" value="album-disc-count"/>
		<constant name="GST_TAG_ALBUM_VOLUME_NUMBER" type="char*" value="album-disc-number"/>
		<constant name="GST_TAG_ARTIST" type="char*" value="artist"/>
		<constant name="GST_TAG_ARTIST_SORTNAME" type="char*" value="musicbrainz-sortname"/>
		<constant name="GST_TAG_AUDIO_CODEC" type="char*" value="audio-codec"/>
		<constant name="GST_TAG_BEATS_PER_MINUTE" type="char*" value="beats-per-minute"/>
		<constant name="GST_TAG_BITRATE" type="char*" value="bitrate"/>
		<constant name="GST_TAG_CODEC" type="char*" value="codec"/>
		<constant name="GST_TAG_COMMENT" type="char*" value="comment"/>
		<constant name="GST_TAG_COMPOSER" type="char*" value="composer"/>
		<constant name="GST_TAG_CONTACT" type="char*" value="contact"/>
		<constant name="GST_TAG_COPYRIGHT" type="char*" value="copyright"/>
		<constant name="GST_TAG_COPYRIGHT_URI" type="char*" value="copyright-uri"/>
		<constant name="GST_TAG_DATE" type="char*" value="date"/>
		<constant name="GST_TAG_DESCRIPTION" type="char*" value="description"/>
		<constant name="GST_TAG_DURATION" type="char*" value="duration"/>
		<constant name="GST_TAG_ENCODER" type="char*" value="encoder"/>
		<constant name="GST_TAG_ENCODER_VERSION" type="char*" value="encoder-version"/>
		<constant name="GST_TAG_EXTENDED_COMMENT" type="char*" value="extended-comment"/>
		<constant name="GST_TAG_GENRE" type="char*" value="genre"/>
		<constant name="GST_TAG_IMAGE" type="char*" value="image"/>
		<constant name="GST_TAG_ISRC" type="char*" value="isrc"/>
		<constant name="GST_TAG_LANGUAGE_CODE" type="char*" value="language-code"/>
		<constant name="GST_TAG_LICENSE" type="char*" value="license"/>
		<constant name="GST_TAG_LICENSE_URI" type="char*" value="license-uri"/>
		<constant name="GST_TAG_LOCATION" type="char*" value="location"/>
		<constant name="GST_TAG_MAXIMUM_BITRATE" type="char*" value="maximum-bitrate"/>
		<constant name="GST_TAG_MINIMUM_BITRATE" type="char*" value="minimum-bitrate"/>
		<constant name="GST_TAG_NOMINAL_BITRATE" type="char*" value="nominal-bitrate"/>
		<constant name="GST_TAG_ORGANIZATION" type="char*" value="organization"/>
		<constant name="GST_TAG_PERFORMER" type="char*" value="performer"/>
		<constant name="GST_TAG_PREVIEW_IMAGE" type="char*" value="preview-image"/>
		<constant name="GST_TAG_REFERENCE_LEVEL" type="char*" value="replaygain-reference-level"/>
		<constant name="GST_TAG_SERIAL" type="char*" value="serial"/>
		<constant name="GST_TAG_TITLE" type="char*" value="title"/>
		<constant name="GST_TAG_TITLE_SORTNAME" type="char*" value="title-sortname"/>
		<constant name="GST_TAG_TRACK_COUNT" type="char*" value="track-count"/>
		<constant name="GST_TAG_TRACK_GAIN" type="char*" value="replaygain-track-gain"/>
		<constant name="GST_TAG_TRACK_NUMBER" type="char*" value="track-number"/>
		<constant name="GST_TAG_TRACK_PEAK" type="char*" value="replaygain-track-peak"/>
		<constant name="GST_TAG_VERSION" type="char*" value="version"/>
		<constant name="GST_TAG_VIDEO_CODEC" type="char*" value="video-codec"/>
		<constant name="GST_TIME_FORMAT" type="char*" value="u:2430982432:51.000000009"/>
		<constant name="GST_USECOND" type="int" value="0"/>
		<constant name="GST_VALUE_EQUAL" type="int" value="0"/>
		<constant name="GST_VALUE_GREATER_THAN" type="int" value="1"/>
		<constant name="GST_VALUE_LESS_THAN" type="int" value="-1"/>
		<constant name="GST_VALUE_UNORDERED" type="int" value="2"/>
		<constant name="GST_VERSION_MAJOR" type="int" value="0"/>
		<constant name="GST_VERSION_MICRO" type="int" value="15"/>
		<constant name="GST_VERSION_MINOR" type="int" value="10"/>
		<constant name="GST_VERSION_NANO" type="int" value="0"/>
	</namespace>
</api>
