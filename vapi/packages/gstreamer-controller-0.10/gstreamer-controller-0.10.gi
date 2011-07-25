<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="object_control_properties" symbol="gst_object_control_properties">
			<return-type type="GstController*"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
			</parameters>
		</function>
		<function name="object_get_control_rate" symbol="gst_object_get_control_rate">
			<return-type type="GstClockTime"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
			</parameters>
		</function>
		<function name="object_get_control_source" symbol="gst_object_get_control_source">
			<return-type type="GstControlSource*"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
				<parameter name="property_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="object_get_controller" symbol="gst_object_get_controller">
			<return-type type="GstController*"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
			</parameters>
		</function>
		<function name="object_get_value_array" symbol="gst_object_get_value_array">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
				<parameter name="timestamp" type="GstClockTime"/>
				<parameter name="value_array" type="GstValueArray*"/>
			</parameters>
		</function>
		<function name="object_get_value_arrays" symbol="gst_object_get_value_arrays">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
				<parameter name="timestamp" type="GstClockTime"/>
				<parameter name="value_arrays" type="GSList*"/>
			</parameters>
		</function>
		<function name="object_set_control_rate" symbol="gst_object_set_control_rate">
			<return-type type="void"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
				<parameter name="control_rate" type="GstClockTime"/>
			</parameters>
		</function>
		<function name="object_set_control_source" symbol="gst_object_set_control_source">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
				<parameter name="property_name" type="gchar*"/>
				<parameter name="csource" type="GstControlSource*"/>
			</parameters>
		</function>
		<function name="object_set_controller" symbol="gst_object_set_controller">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
				<parameter name="controller" type="GstController*"/>
			</parameters>
		</function>
		<function name="object_suggest_next_sync" symbol="gst_object_suggest_next_sync">
			<return-type type="GstClockTime"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
			</parameters>
		</function>
		<function name="object_sync_values" symbol="gst_object_sync_values">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
				<parameter name="timestamp" type="GstClockTime"/>
			</parameters>
		</function>
		<function name="object_uncontrol_properties" symbol="gst_object_uncontrol_properties">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
			</parameters>
		</function>
		<callback name="GstControlSourceBind">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="self" type="GstControlSource*"/>
				<parameter name="pspec" type="GParamSpec*"/>
			</parameters>
		</callback>
		<callback name="GstControlSourceGetValue">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="self" type="GstControlSource*"/>
				<parameter name="timestamp" type="GstClockTime"/>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</callback>
		<callback name="GstControlSourceGetValueArray">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="self" type="GstControlSource*"/>
				<parameter name="timestamp" type="GstClockTime"/>
				<parameter name="value_array" type="GstValueArray*"/>
			</parameters>
		</callback>
		<struct name="GstTimedValue">
			<field name="timestamp" type="GstClockTime"/>
			<field name="value" type="GValue"/>
		</struct>
		<struct name="GstValueArray">
			<field name="property_name" type="gchar*"/>
			<field name="nbsamples" type="gint"/>
			<field name="sample_interval" type="GstClockTime"/>
			<field name="values" type="gpointer*"/>
		</struct>
		<enum name="GstInterpolateMode">
			<member name="GST_INTERPOLATE_NONE" value="0"/>
			<member name="GST_INTERPOLATE_TRIGGER" value="1"/>
			<member name="GST_INTERPOLATE_LINEAR" value="2"/>
			<member name="GST_INTERPOLATE_QUADRATIC" value="3"/>
			<member name="GST_INTERPOLATE_CUBIC" value="4"/>
			<member name="GST_INTERPOLATE_USER" value="5"/>
		</enum>
		<enum name="GstLFOWaveform" type-name="GstLFOWaveform" get-type="gst_lfo_waveform_get_type">
			<member name="GST_LFO_WAVEFORM_SINE" value="0"/>
			<member name="GST_LFO_WAVEFORM_SQUARE" value="1"/>
			<member name="GST_LFO_WAVEFORM_SAW" value="2"/>
			<member name="GST_LFO_WAVEFORM_REVERSE_SAW" value="3"/>
			<member name="GST_LFO_WAVEFORM_TRIANGLE" value="4"/>
		</enum>
		<object name="GstControlSource" parent="GObject" type-name="GstControlSource" get-type="gst_control_source_get_type">
			<method name="bind" symbol="gst_control_source_bind">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstControlSource*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="gst_control_source_get_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstControlSource*"/>
					<parameter name="timestamp" type="GstClockTime"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_value_array" symbol="gst_control_source_get_value_array">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstControlSource*"/>
					<parameter name="timestamp" type="GstClockTime"/>
					<parameter name="value_array" type="GstValueArray*"/>
				</parameters>
			</method>
			<field name="get_value" type="GstControlSourceGetValue"/>
			<field name="get_value_array" type="GstControlSourceGetValueArray"/>
			<field name="bound" type="gboolean"/>
		</object>
		<object name="GstController" parent="GObject" type-name="GstController" get-type="gst_controller_get_type">
			<method name="get" symbol="gst_controller_get">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="timestamp" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="get_all" symbol="gst_controller_get_all">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_control_source" symbol="gst_controller_get_control_source">
				<return-type type="GstControlSource*"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_value_array" symbol="gst_controller_get_value_array">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="timestamp" type="GstClockTime"/>
					<parameter name="value_array" type="GstValueArray*"/>
				</parameters>
			</method>
			<method name="get_value_arrays" symbol="gst_controller_get_value_arrays">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="timestamp" type="GstClockTime"/>
					<parameter name="value_arrays" type="GSList*"/>
				</parameters>
			</method>
			<method name="init" symbol="gst_controller_init">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="argc" type="int*"/>
					<parameter name="argv" type="char***"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_controller_new">
				<return-type type="GstController*"/>
				<parameters>
					<parameter name="object" type="GObject*"/>
				</parameters>
			</constructor>
			<constructor name="new_list" symbol="gst_controller_new_list">
				<return-type type="GstController*"/>
				<parameters>
					<parameter name="object" type="GObject*"/>
					<parameter name="list" type="GList*"/>
				</parameters>
			</constructor>
			<constructor name="new_valist" symbol="gst_controller_new_valist">
				<return-type type="GstController*"/>
				<parameters>
					<parameter name="object" type="GObject*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</constructor>
			<method name="remove_properties" symbol="gst_controller_remove_properties">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
				</parameters>
			</method>
			<method name="remove_properties_list" symbol="gst_controller_remove_properties_list">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="remove_properties_valist" symbol="gst_controller_remove_properties_valist">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="var_args" type="va_list"/>
				</parameters>
			</method>
			<method name="set" symbol="gst_controller_set">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="timestamp" type="GstClockTime"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_control_source" symbol="gst_controller_set_control_source">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="csource" type="GstControlSource*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="gst_controller_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="disabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_from_list" symbol="gst_controller_set_from_list">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="timedvalues" type="GSList*"/>
				</parameters>
			</method>
			<method name="set_interpolation_mode" symbol="gst_controller_set_interpolation_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="mode" type="GstInterpolateMode"/>
				</parameters>
			</method>
			<method name="set_property_disabled" symbol="gst_controller_set_property_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="disabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="suggest_next_sync" symbol="gst_controller_suggest_next_sync">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
				</parameters>
			</method>
			<method name="sync_values" symbol="gst_controller_sync_values">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="timestamp" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="unset" symbol="gst_controller_unset">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="timestamp" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="unset_all" symbol="gst_controller_unset_all">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstController*"/>
					<parameter name="property_name" type="gchar*"/>
				</parameters>
			</method>
			<property name="control-rate" type="guint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="properties" type="GList*"/>
			<field name="lock" type="GMutex*"/>
			<field name="object" type="GObject*"/>
		</object>
		<object name="GstInterpolationControlSource" parent="GstControlSource" type-name="GstInterpolationControlSource" get-type="gst_interpolation_control_source_get_type">
			<method name="get_all" symbol="gst_interpolation_control_source_get_all">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GstInterpolationControlSource*"/>
				</parameters>
			</method>
			<method name="get_count" symbol="gst_interpolation_control_source_get_count">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="GstInterpolationControlSource*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_interpolation_control_source_new">
				<return-type type="GstInterpolationControlSource*"/>
			</constructor>
			<method name="set" symbol="gst_interpolation_control_source_set">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstInterpolationControlSource*"/>
					<parameter name="timestamp" type="GstClockTime"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_from_list" symbol="gst_interpolation_control_source_set_from_list">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstInterpolationControlSource*"/>
					<parameter name="timedvalues" type="GSList*"/>
				</parameters>
			</method>
			<method name="set_interpolation_mode" symbol="gst_interpolation_control_source_set_interpolation_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstInterpolationControlSource*"/>
					<parameter name="mode" type="GstInterpolateMode"/>
				</parameters>
			</method>
			<method name="unset" symbol="gst_interpolation_control_source_unset">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GstInterpolationControlSource*"/>
					<parameter name="timestamp" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="unset_all" symbol="gst_interpolation_control_source_unset_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GstInterpolationControlSource*"/>
				</parameters>
			</method>
			<field name="lock" type="GMutex*"/>
		</object>
		<object name="GstLFOControlSource" parent="GstControlSource" type-name="GstLFOControlSource" get-type="gst_lfo_control_source_get_type">
			<constructor name="new" symbol="gst_lfo_control_source_new">
				<return-type type="GstLFOControlSource*"/>
			</constructor>
			<property name="amplitude" type="GValue*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="frequency" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="offset" type="GValue*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="timeshift" type="guint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="waveform" type="GstLFOWaveform" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="lock" type="GMutex*"/>
		</object>
	</namespace>
</api>
