<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="audio_buffer_clip" symbol="gst_audio_buffer_clip">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="segment" type="GstSegment*"/>
				<parameter name="rate" type="gint"/>
				<parameter name="frame_size" type="gint"/>
			</parameters>
		</function>
		<function name="audio_check_channel_positions" symbol="gst_audio_check_channel_positions">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pos" type="GstAudioChannelPosition*"/>
				<parameter name="channels" type="guint"/>
			</parameters>
		</function>
		<function name="audio_default_registry_mixer_filter" symbol="gst_audio_default_registry_mixer_filter">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="filter_func" type="GstAudioMixerFilterFunc"/>
				<parameter name="first" type="gboolean"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="audio_duration_from_pad_buffer" symbol="gst_audio_duration_from_pad_buffer">
			<return-type type="GstClockTime"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="buf" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="audio_fixate_channel_positions" symbol="gst_audio_fixate_channel_positions">
			<return-type type="GstAudioChannelPosition*"/>
			<parameters>
				<parameter name="str" type="GstStructure*"/>
			</parameters>
		</function>
		<function name="audio_frame_byte_size" symbol="gst_audio_frame_byte_size">
			<return-type type="int"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
			</parameters>
		</function>
		<function name="audio_frame_length" symbol="gst_audio_frame_length">
			<return-type type="long"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="buf" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="audio_get_channel_positions" symbol="gst_audio_get_channel_positions">
			<return-type type="GstAudioChannelPosition*"/>
			<parameters>
				<parameter name="str" type="GstStructure*"/>
			</parameters>
		</function>
		<function name="audio_iec61937_frame_size" symbol="gst_audio_iec61937_frame_size">
			<return-type type="guint"/>
			<parameters>
				<parameter name="spec" type="GstRingBufferSpec*"/>
			</parameters>
		</function>
		<function name="audio_iec61937_payload" symbol="gst_audio_iec61937_payload">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="src" type="guint8*"/>
				<parameter name="src_n" type="guint"/>
				<parameter name="dst" type="guint8*"/>
				<parameter name="dst_n" type="guint"/>
				<parameter name="spec" type="GstRingBufferSpec*"/>
			</parameters>
		</function>
		<function name="audio_is_buffer_framed" symbol="gst_audio_is_buffer_framed">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="buf" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="audio_set_caps_channel_positions_list" symbol="gst_audio_set_caps_channel_positions_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="caps" type="GstCaps*"/>
				<parameter name="pos" type="GstAudioChannelPosition*"/>
				<parameter name="num_positions" type="gint"/>
			</parameters>
		</function>
		<function name="audio_set_channel_positions" symbol="gst_audio_set_channel_positions">
			<return-type type="void"/>
			<parameters>
				<parameter name="str" type="GstStructure*"/>
				<parameter name="pos" type="GstAudioChannelPosition*"/>
			</parameters>
		</function>
		<function name="audio_set_structure_channel_positions_list" symbol="gst_audio_set_structure_channel_positions_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="str" type="GstStructure*"/>
				<parameter name="pos" type="GstAudioChannelPosition*"/>
				<parameter name="num_positions" type="gint"/>
			</parameters>
		</function>
		<function name="audio_structure_set_int" symbol="gst_audio_structure_set_int">
			<return-type type="void"/>
			<parameters>
				<parameter name="structure" type="GstStructure*"/>
				<parameter name="flag" type="GstAudioFieldFlag"/>
			</parameters>
		</function>
		<callback name="GstAudioClockGetTimeFunc">
			<return-type type="GstClockTime"/>
			<parameters>
				<parameter name="clock" type="GstClock*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstAudioMixerFilterFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="mixer" type="GstMixer*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstRingBufferCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="rbuf" type="GstRingBuffer*"/>
				<parameter name="data" type="guint8*"/>
				<parameter name="len" type="guint"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GstRingBufferSpec">
			<field name="caps" type="GstCaps*"/>
			<field name="type" type="GstBufferFormatType"/>
			<field name="format" type="GstBufferFormat"/>
			<field name="sign" type="gboolean"/>
			<field name="bigend" type="gboolean"/>
			<field name="width" type="gint"/>
			<field name="depth" type="gint"/>
			<field name="rate" type="gint"/>
			<field name="channels" type="gint"/>
			<field name="latency_time" type="guint64"/>
			<field name="buffer_time" type="guint64"/>
			<field name="segsize" type="gint"/>
			<field name="segtotal" type="gint"/>
			<field name="bytes_per_sample" type="gint"/>
			<field name="silence_sample" type="guint8[]"/>
			<field name="seglatency" type="gint"/>
			<field name="_gst_reserved" type="guint8[]"/>
		</struct>
		<enum name="GstAudioChannelPosition" type-name="GstAudioChannelPosition" get-type="gst_audio_channel_position_get_type">
			<member name="GST_AUDIO_CHANNEL_POSITION_INVALID" value="-1"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_FRONT_MONO" value="0"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_FRONT_LEFT" value="1"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_FRONT_RIGHT" value="2"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_REAR_CENTER" value="3"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_REAR_LEFT" value="4"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_REAR_RIGHT" value="5"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_LFE" value="6"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_FRONT_CENTER" value="7"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_FRONT_LEFT_OF_CENTER" value="8"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_FRONT_RIGHT_OF_CENTER" value="9"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_SIDE_LEFT" value="10"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_SIDE_RIGHT" value="11"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_NONE" value="12"/>
			<member name="GST_AUDIO_CHANNEL_POSITION_NUM" value="13"/>
		</enum>
		<enum name="GstAudioFieldFlag">
			<member name="GST_AUDIO_FIELD_RATE" value="1"/>
			<member name="GST_AUDIO_FIELD_CHANNELS" value="2"/>
			<member name="GST_AUDIO_FIELD_ENDIANNESS" value="4"/>
			<member name="GST_AUDIO_FIELD_WIDTH" value="8"/>
			<member name="GST_AUDIO_FIELD_DEPTH" value="16"/>
			<member name="GST_AUDIO_FIELD_SIGNED" value="32"/>
		</enum>
		<enum name="GstBaseAudioSinkSlaveMethod" type-name="GstBaseAudioSinkSlaveMethod" get-type="gst_base_audio_sink_slave_method_get_type">
			<member name="GST_BASE_AUDIO_SINK_SLAVE_RESAMPLE" value="0"/>
			<member name="GST_BASE_AUDIO_SINK_SLAVE_SKEW" value="1"/>
			<member name="GST_BASE_AUDIO_SINK_SLAVE_NONE" value="2"/>
		</enum>
		<enum name="GstBaseAudioSrcSlaveMethod" type-name="GstBaseAudioSrcSlaveMethod" get-type="gst_base_audio_src_slave_method_get_type">
			<member name="GST_BASE_AUDIO_SRC_SLAVE_RESAMPLE" value="0"/>
			<member name="GST_BASE_AUDIO_SRC_SLAVE_RETIMESTAMP" value="1"/>
			<member name="GST_BASE_AUDIO_SRC_SLAVE_SKEW" value="2"/>
			<member name="GST_BASE_AUDIO_SRC_SLAVE_NONE" value="3"/>
		</enum>
		<enum name="GstBufferFormat" type-name="GstBufferFormat" get-type="gst_buffer_format_get_type">
			<member name="GST_UNKNOWN" value="0"/>
			<member name="GST_S8" value="1"/>
			<member name="GST_U8" value="2"/>
			<member name="GST_S16_LE" value="3"/>
			<member name="GST_S16_BE" value="4"/>
			<member name="GST_U16_LE" value="5"/>
			<member name="GST_U16_BE" value="6"/>
			<member name="GST_S24_LE" value="7"/>
			<member name="GST_S24_BE" value="8"/>
			<member name="GST_U24_LE" value="9"/>
			<member name="GST_U24_BE" value="10"/>
			<member name="GST_S32_LE" value="11"/>
			<member name="GST_S32_BE" value="12"/>
			<member name="GST_U32_LE" value="13"/>
			<member name="GST_U32_BE" value="14"/>
			<member name="GST_S24_3LE" value="15"/>
			<member name="GST_S24_3BE" value="16"/>
			<member name="GST_U24_3LE" value="17"/>
			<member name="GST_U24_3BE" value="18"/>
			<member name="GST_S20_3LE" value="19"/>
			<member name="GST_S20_3BE" value="20"/>
			<member name="GST_U20_3LE" value="21"/>
			<member name="GST_U20_3BE" value="22"/>
			<member name="GST_S18_3LE" value="23"/>
			<member name="GST_S18_3BE" value="24"/>
			<member name="GST_U18_3LE" value="25"/>
			<member name="GST_U18_3BE" value="26"/>
			<member name="GST_FLOAT32_LE" value="27"/>
			<member name="GST_FLOAT32_BE" value="28"/>
			<member name="GST_FLOAT64_LE" value="29"/>
			<member name="GST_FLOAT64_BE" value="30"/>
			<member name="GST_MU_LAW" value="31"/>
			<member name="GST_A_LAW" value="32"/>
			<member name="GST_IMA_ADPCM" value="33"/>
			<member name="GST_MPEG" value="34"/>
			<member name="GST_GSM" value="35"/>
			<member name="GST_IEC958" value="36"/>
			<member name="GST_AC3" value="37"/>
			<member name="GST_EAC3" value="38"/>
			<member name="GST_DTS" value="39"/>
			<member name="GST_MPEG2_AAC" value="40"/>
			<member name="GST_MPEG4_AAC" value="41"/>
		</enum>
		<enum name="GstBufferFormatType" type-name="GstBufferFormatType" get-type="gst_buffer_format_type_get_type">
			<member name="GST_BUFTYPE_LINEAR" value="0"/>
			<member name="GST_BUFTYPE_FLOAT" value="1"/>
			<member name="GST_BUFTYPE_MU_LAW" value="2"/>
			<member name="GST_BUFTYPE_A_LAW" value="3"/>
			<member name="GST_BUFTYPE_IMA_ADPCM" value="4"/>
			<member name="GST_BUFTYPE_MPEG" value="5"/>
			<member name="GST_BUFTYPE_GSM" value="6"/>
			<member name="GST_BUFTYPE_IEC958" value="7"/>
			<member name="GST_BUFTYPE_AC3" value="8"/>
			<member name="GST_BUFTYPE_EAC3" value="9"/>
			<member name="GST_BUFTYPE_DTS" value="10"/>
			<member name="GST_BUFTYPE_MPEG2_AAC" value="11"/>
			<member name="GST_BUFTYPE_MPEG4_AAC" value="12"/>
		</enum>
		<enum name="GstRingBufferSegState" type-name="GstRingBufferSegState" get-type="gst_ring_buffer_seg_state_get_type">
			<member name="GST_SEGSTATE_INVALID" value="0"/>
			<member name="GST_SEGSTATE_EMPTY" value="1"/>
			<member name="GST_SEGSTATE_FILLED" value="2"/>
			<member name="GST_SEGSTATE_PARTIAL" value="3"/>
		</enum>
		<enum name="GstRingBufferState" type-name="GstRingBufferState" get-type="gst_ring_buffer_state_get_type">
			<member name="GST_RING_BUFFER_STATE_STOPPED" value="0"/>
			<member name="GST_RING_BUFFER_STATE_PAUSED" value="1"/>
			<member name="GST_RING_BUFFER_STATE_STARTED" value="2"/>
		</enum>
		<object name="GstAudioClock" parent="GstSystemClock" type-name="GstAudioClock" get-type="gst_audio_clock_get_type">
			<method name="adjust" symbol="gst_audio_clock_adjust">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
					<parameter name="time" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="get_time" symbol="gst_audio_clock_get_time">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</method>
			<method name="invalidate" symbol="gst_audio_clock_invalidate">
				<return-type type="void"/>
				<parameters>
					<parameter name="clock" type="GstClock*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_audio_clock_new">
				<return-type type="GstClock*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="func" type="GstAudioClockGetTimeFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</constructor>
			<constructor name="new_full" symbol="gst_audio_clock_new_full">
				<return-type type="GstClock*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="func" type="GstAudioClockGetTimeFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="destroy_notify" type="GDestroyNotify"/>
				</parameters>
			</constructor>
			<method name="reset" symbol="gst_audio_clock_reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="clock" type="GstAudioClock*"/>
					<parameter name="time" type="GstClockTime"/>
				</parameters>
			</method>
			<field name="func" type="GstAudioClockGetTimeFunc"/>
			<field name="user_data" type="gpointer"/>
			<field name="last_time" type="GstClockTime"/>
			<field name="abidata" type="gpointer"/>
		</object>
		<object name="GstAudioFilter" parent="GstBaseTransform" type-name="GstAudioFilter" get-type="gst_audio_filter_get_type">
			<method name="class_add_pad_templates" symbol="gst_audio_filter_class_add_pad_templates">
				<return-type type="void"/>
				<parameters>
					<parameter name="klass" type="GstAudioFilterClass*"/>
					<parameter name="allowed_caps" type="GstCaps*"/>
				</parameters>
			</method>
			<vfunc name="setup">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="filter" type="GstAudioFilter*"/>
					<parameter name="format" type="GstRingBufferSpec*"/>
				</parameters>
			</vfunc>
			<field name="format" type="GstRingBufferSpec"/>
		</object>
		<object name="GstAudioSink" parent="GstBaseAudioSink" type-name="GstAudioSink" get-type="gst_audio_sink_get_type">
			<vfunc name="close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstAudioSink*"/>
				</parameters>
			</vfunc>
			<vfunc name="delay">
				<return-type type="guint"/>
				<parameters>
					<parameter name="sink" type="GstAudioSink*"/>
				</parameters>
			</vfunc>
			<vfunc name="open">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstAudioSink*"/>
				</parameters>
			</vfunc>
			<vfunc name="prepare">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstAudioSink*"/>
					<parameter name="spec" type="GstRingBufferSpec*"/>
				</parameters>
			</vfunc>
			<vfunc name="reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstAudioSink*"/>
				</parameters>
			</vfunc>
			<vfunc name="unprepare">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstAudioSink*"/>
				</parameters>
			</vfunc>
			<vfunc name="write">
				<return-type type="guint"/>
				<parameters>
					<parameter name="sink" type="GstAudioSink*"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="length" type="guint"/>
				</parameters>
			</vfunc>
			<field name="thread" type="GThread*"/>
		</object>
		<object name="GstAudioSrc" parent="GstBaseAudioSrc" type-name="GstAudioSrc" get-type="gst_audio_src_get_type">
			<vfunc name="close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstAudioSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="delay">
				<return-type type="guint"/>
				<parameters>
					<parameter name="src" type="GstAudioSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="open">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstAudioSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="prepare">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstAudioSrc*"/>
					<parameter name="spec" type="GstRingBufferSpec*"/>
				</parameters>
			</vfunc>
			<vfunc name="read">
				<return-type type="guint"/>
				<parameters>
					<parameter name="src" type="GstAudioSrc*"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="length" type="guint"/>
				</parameters>
			</vfunc>
			<vfunc name="reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstAudioSrc*"/>
				</parameters>
			</vfunc>
			<vfunc name="unprepare">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstAudioSrc*"/>
				</parameters>
			</vfunc>
			<field name="thread" type="GThread*"/>
		</object>
		<object name="GstBaseAudioSink" parent="GstBaseSink" type-name="GstBaseAudioSink" get-type="gst_base_audio_sink_get_type">
			<method name="create_ringbuffer" symbol="gst_base_audio_sink_create_ringbuffer">
				<return-type type="GstRingBuffer*"/>
				<parameters>
					<parameter name="sink" type="GstBaseAudioSink*"/>
				</parameters>
			</method>
			<method name="get_drift_tolerance" symbol="gst_base_audio_sink_get_drift_tolerance">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="sink" type="GstBaseAudioSink*"/>
				</parameters>
			</method>
			<method name="get_provide_clock" symbol="gst_base_audio_sink_get_provide_clock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="sink" type="GstBaseAudioSink*"/>
				</parameters>
			</method>
			<method name="get_slave_method" symbol="gst_base_audio_sink_get_slave_method">
				<return-type type="GstBaseAudioSinkSlaveMethod"/>
				<parameters>
					<parameter name="sink" type="GstBaseAudioSink*"/>
				</parameters>
			</method>
			<method name="set_drift_tolerance" symbol="gst_base_audio_sink_set_drift_tolerance">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseAudioSink*"/>
					<parameter name="drift_tolerance" type="gint64"/>
				</parameters>
			</method>
			<method name="set_provide_clock" symbol="gst_base_audio_sink_set_provide_clock">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseAudioSink*"/>
					<parameter name="provide" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_slave_method" symbol="gst_base_audio_sink_set_slave_method">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseAudioSink*"/>
					<parameter name="method" type="GstBaseAudioSinkSlaveMethod"/>
				</parameters>
			</method>
			<property name="buffer-time" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="can-activate-pull" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="drift-tolerance" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="latency-time" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="provide-clock" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="slave-method" type="GstBaseAudioSinkSlaveMethod" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="create_ringbuffer">
				<return-type type="GstRingBuffer*"/>
				<parameters>
					<parameter name="sink" type="GstBaseAudioSink*"/>
				</parameters>
			</vfunc>
			<vfunc name="payload">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="sink" type="GstBaseAudioSink*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</vfunc>
			<field name="ringbuffer" type="GstRingBuffer*"/>
			<field name="buffer_time" type="guint64"/>
			<field name="latency_time" type="guint64"/>
			<field name="next_sample" type="guint64"/>
			<field name="provide_clock" type="gboolean"/>
			<field name="provided_clock" type="GstClock*"/>
			<field name="abidata" type="gpointer"/>
		</object>
		<object name="GstBaseAudioSrc" parent="GstPushSrc" type-name="GstBaseAudioSrc" get-type="gst_base_audio_src_get_type">
			<method name="create_ringbuffer" symbol="gst_base_audio_src_create_ringbuffer">
				<return-type type="GstRingBuffer*"/>
				<parameters>
					<parameter name="src" type="GstBaseAudioSrc*"/>
				</parameters>
			</method>
			<method name="get_provide_clock" symbol="gst_base_audio_src_get_provide_clock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseAudioSrc*"/>
				</parameters>
			</method>
			<method name="get_slave_method" symbol="gst_base_audio_src_get_slave_method">
				<return-type type="GstBaseAudioSrcSlaveMethod"/>
				<parameters>
					<parameter name="src" type="GstBaseAudioSrc*"/>
				</parameters>
			</method>
			<method name="set_provide_clock" symbol="gst_base_audio_src_set_provide_clock">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstBaseAudioSrc*"/>
					<parameter name="provide" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_slave_method" symbol="gst_base_audio_src_set_slave_method">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstBaseAudioSrc*"/>
					<parameter name="method" type="GstBaseAudioSrcSlaveMethod"/>
				</parameters>
			</method>
			<property name="actual-buffer-time" type="gint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="actual-latency-time" type="gint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="buffer-time" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="latency-time" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="provide-clock" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="slave-method" type="GstBaseAudioSrcSlaveMethod" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="create_ringbuffer">
				<return-type type="GstRingBuffer*"/>
				<parameters>
					<parameter name="src" type="GstBaseAudioSrc*"/>
				</parameters>
			</vfunc>
			<field name="ringbuffer" type="GstRingBuffer*"/>
			<field name="buffer_time" type="GstClockTime"/>
			<field name="latency_time" type="GstClockTime"/>
			<field name="next_sample" type="guint64"/>
			<field name="clock" type="GstClock*"/>
		</object>
		<object name="GstRingBuffer" parent="GstObject" type-name="GstRingBuffer" get-type="gst_ring_buffer_get_type">
			<method name="acquire" symbol="gst_ring_buffer_acquire">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="spec" type="GstRingBufferSpec*"/>
				</parameters>
			</method>
			<method name="activate" symbol="gst_ring_buffer_activate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="active" type="gboolean"/>
				</parameters>
			</method>
			<method name="advance" symbol="gst_ring_buffer_advance">
				<return-type type="void"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="advance" type="guint"/>
				</parameters>
			</method>
			<method name="clear" symbol="gst_ring_buffer_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="segment" type="gint"/>
				</parameters>
			</method>
			<method name="clear_all" symbol="gst_ring_buffer_clear_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</method>
			<method name="close_device" symbol="gst_ring_buffer_close_device">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</method>
			<method name="commit" symbol="gst_ring_buffer_commit">
				<return-type type="guint"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="sample" type="guint64"/>
					<parameter name="data" type="guchar*"/>
					<parameter name="len" type="guint"/>
				</parameters>
			</method>
			<method name="commit_full" symbol="gst_ring_buffer_commit_full">
				<return-type type="guint"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="sample" type="guint64*"/>
					<parameter name="data" type="guchar*"/>
					<parameter name="in_samples" type="gint"/>
					<parameter name="out_samples" type="gint"/>
					<parameter name="accum" type="gint*"/>
				</parameters>
			</method>
			<method name="convert" symbol="gst_ring_buffer_convert">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="src_fmt" type="GstFormat"/>
					<parameter name="src_val" type="gint64"/>
					<parameter name="dest_fmt" type="GstFormat"/>
					<parameter name="dest_val" type="gint64*"/>
				</parameters>
			</method>
			<method name="debug_spec_buff" symbol="gst_ring_buffer_debug_spec_buff">
				<return-type type="void"/>
				<parameters>
					<parameter name="spec" type="GstRingBufferSpec*"/>
				</parameters>
			</method>
			<method name="debug_spec_caps" symbol="gst_ring_buffer_debug_spec_caps">
				<return-type type="void"/>
				<parameters>
					<parameter name="spec" type="GstRingBufferSpec*"/>
				</parameters>
			</method>
			<method name="delay" symbol="gst_ring_buffer_delay">
				<return-type type="guint"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</method>
			<method name="device_is_open" symbol="gst_ring_buffer_device_is_open">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</method>
			<method name="is_acquired" symbol="gst_ring_buffer_is_acquired">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</method>
			<method name="is_active" symbol="gst_ring_buffer_is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</method>
			<method name="may_start" symbol="gst_ring_buffer_may_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="allowed" type="gboolean"/>
				</parameters>
			</method>
			<method name="open_device" symbol="gst_ring_buffer_open_device">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</method>
			<method name="parse_caps" symbol="gst_ring_buffer_parse_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="spec" type="GstRingBufferSpec*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="pause" symbol="gst_ring_buffer_pause">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</method>
			<method name="prepare_read" symbol="gst_ring_buffer_prepare_read">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="segment" type="gint*"/>
					<parameter name="readptr" type="guint8**"/>
					<parameter name="len" type="gint*"/>
				</parameters>
			</method>
			<method name="read" symbol="gst_ring_buffer_read">
				<return-type type="guint"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="sample" type="guint64"/>
					<parameter name="data" type="guchar*"/>
					<parameter name="len" type="guint"/>
				</parameters>
			</method>
			<method name="release" symbol="gst_ring_buffer_release">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</method>
			<method name="samples_done" symbol="gst_ring_buffer_samples_done">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</method>
			<method name="set_callback" symbol="gst_ring_buffer_set_callback">
				<return-type type="void"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="cb" type="GstRingBufferCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_flushing" symbol="gst_ring_buffer_set_flushing">
				<return-type type="void"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="flushing" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_sample" symbol="gst_ring_buffer_set_sample">
				<return-type type="void"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="sample" type="guint64"/>
				</parameters>
			</method>
			<method name="start" symbol="gst_ring_buffer_start">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</method>
			<method name="stop" symbol="gst_ring_buffer_stop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</method>
			<vfunc name="acquire">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="spec" type="GstRingBufferSpec*"/>
				</parameters>
			</vfunc>
			<vfunc name="activate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="active" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="clear_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="close_device">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="commit">
				<return-type type="guint"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
					<parameter name="sample" type="guint64*"/>
					<parameter name="data" type="guchar*"/>
					<parameter name="in_samples" type="gint"/>
					<parameter name="out_samples" type="gint"/>
					<parameter name="accum" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="delay">
				<return-type type="guint"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="open_device">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="pause">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="release">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="resume">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="start">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="stop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="GstRingBuffer*"/>
				</parameters>
			</vfunc>
			<field name="cond" type="GCond*"/>
			<field name="open" type="gboolean"/>
			<field name="acquired" type="gboolean"/>
			<field name="data" type="GstBuffer*"/>
			<field name="spec" type="GstRingBufferSpec"/>
			<field name="segstate" type="GstRingBufferSegState*"/>
			<field name="samples_per_seg" type="gint"/>
			<field name="empty_seg" type="guint8*"/>
			<field name="state" type="gint"/>
			<field name="segdone" type="gint"/>
			<field name="segbase" type="gint"/>
			<field name="waiting" type="gint"/>
			<field name="callback" type="GstRingBufferCallback"/>
			<field name="cb_data" type="gpointer"/>
			<field name="abidata" type="gpointer"/>
		</object>
		<constant name="GST_AUDIO_DEF_RATE" type="int" value="44100"/>
		<constant name="GST_AUDIO_FLOAT_PAD_TEMPLATE_CAPS" type="char*" value="audio/x-raw-float, rate = (int) [ 1, MAX ], channels = (int) [ 1, MAX ], endianness = (int) { LITTLE_ENDIAN , BIG_ENDIAN }, width = (int) { 32, 64 }"/>
		<constant name="GST_AUDIO_FLOAT_STANDARD_PAD_TEMPLATE_CAPS" type="char*" value="audio/x-raw-float, width = (int) 32, rate = (int) [ 1, MAX ], channels = (int) 1, endianness = (int) BYTE_ORDER"/>
		<constant name="GST_AUDIO_INT_PAD_TEMPLATE_CAPS" type="char*" value="audio/x-raw-int, rate = (int) [ 1, MAX ], channels = (int) [ 1, MAX ], endianness = (int) { LITTLE_ENDIAN, BIG_ENDIAN }, width = (int) { 8, 16, 24, 32 }, depth = (int) [ 1, 32 ], signed = (boolean) { true, false }"/>
		<constant name="GST_AUDIO_INT_STANDARD_PAD_TEMPLATE_CAPS" type="char*" value="audio/x-raw-int, rate = (int) [ 1, MAX ], channels = (int) 2, endianness = (int) BYTE_ORDER, width = (int) 16, depth = (int) 16, signed = (boolean) true"/>
	</namespace>
</api>
