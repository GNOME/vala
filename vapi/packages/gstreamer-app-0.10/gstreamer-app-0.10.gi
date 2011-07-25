<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<callback name="GstAppBufferFinalizeFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="priv" type="void*"/>
			</parameters>
		</callback>
		<struct name="GstAppBuffer">
			<method name="new" symbol="gst_app_buffer_new">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="data" type="void*"/>
					<parameter name="length" type="int"/>
					<parameter name="finalize" type="GstAppBufferFinalizeFunc"/>
					<parameter name="priv" type="void*"/>
				</parameters>
			</method>
			<field name="buffer" type="GstBuffer"/>
			<field name="finalize" type="GstAppBufferFinalizeFunc"/>
			<field name="priv" type="void*"/>
		</struct>
		<struct name="GstAppBufferClass">
			<field name="buffer_class" type="GstBufferClass"/>
		</struct>
		<struct name="GstAppSinkCallbacks">
			<field name="eos" type="GCallback"/>
			<field name="new_preroll" type="GCallback"/>
			<field name="new_buffer" type="GCallback"/>
			<field name="new_buffer_list" type="GCallback"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<struct name="GstAppSrcCallbacks">
			<field name="need_data" type="GCallback"/>
			<field name="enough_data" type="GCallback"/>
			<field name="seek_data" type="GCallback"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<enum name="GstAppStreamType" type-name="GstAppStreamType" get-type="gst_app_stream_type_get_type">
			<member name="GST_APP_STREAM_TYPE_STREAM" value="0"/>
			<member name="GST_APP_STREAM_TYPE_SEEKABLE" value="1"/>
			<member name="GST_APP_STREAM_TYPE_RANDOM_ACCESS" value="2"/>
		</enum>
		<object name="GstAppSink" parent="GstBaseSink" type-name="GstAppSink" get-type="gst_app_sink_get_type">
			<implements>
				<interface name="GstURIHandler"/>
			</implements>
			<method name="get_caps" symbol="gst_app_sink_get_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
				</parameters>
			</method>
			<method name="get_drop" symbol="gst_app_sink_get_drop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
				</parameters>
			</method>
			<method name="get_emit_signals" symbol="gst_app_sink_get_emit_signals">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
				</parameters>
			</method>
			<method name="get_max_buffers" symbol="gst_app_sink_get_max_buffers">
				<return-type type="guint"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
				</parameters>
			</method>
			<method name="is_eos" symbol="gst_app_sink_is_eos">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
				</parameters>
			</method>
			<method name="pull_buffer" symbol="gst_app_sink_pull_buffer">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
				</parameters>
			</method>
			<method name="pull_buffer_list" symbol="gst_app_sink_pull_buffer_list">
				<return-type type="GstBufferList*"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
				</parameters>
			</method>
			<method name="pull_preroll" symbol="gst_app_sink_pull_preroll">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
				</parameters>
			</method>
			<method name="set_callbacks" symbol="gst_app_sink_set_callbacks">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
					<parameter name="callbacks" type="GstAppSinkCallbacks*"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_caps" symbol="gst_app_sink_set_caps">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="set_drop" symbol="gst_app_sink_set_drop">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
					<parameter name="drop" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_emit_signals" symbol="gst_app_sink_set_emit_signals">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
					<parameter name="emit" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_max_buffers" symbol="gst_app_sink_set_max_buffers">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsink" type="GstAppSink*"/>
					<parameter name="max" type="guint"/>
				</parameters>
			</method>
			<property name="caps" type="GstCaps*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="drop" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="emit-signals" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="eos" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="max-buffers" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="eos" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstAppSink*"/>
				</parameters>
			</signal>
			<signal name="new-buffer" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstAppSink*"/>
				</parameters>
			</signal>
			<signal name="new-buffer-list" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstAppSink*"/>
				</parameters>
			</signal>
			<signal name="new-preroll" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstAppSink*"/>
				</parameters>
			</signal>
			<signal name="pull-buffer" when="LAST">
				<return-type type="GstBuffer"/>
				<parameters>
					<parameter name="sink" type="GstAppSink*"/>
				</parameters>
			</signal>
			<signal name="pull-buffer-list" when="LAST">
				<return-type type="GstBufferList"/>
				<parameters>
					<parameter name="sink" type="GstAppSink*"/>
				</parameters>
			</signal>
			<signal name="pull-preroll" when="LAST">
				<return-type type="GstBuffer"/>
				<parameters>
					<parameter name="sink" type="GstAppSink*"/>
				</parameters>
			</signal>
		</object>
		<object name="GstAppSrc" parent="GstBaseSrc" type-name="GstAppSrc" get-type="gst_app_src_get_type">
			<implements>
				<interface name="GstURIHandler"/>
			</implements>
			<method name="end_of_stream" symbol="gst_app_src_end_of_stream">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
				</parameters>
			</method>
			<method name="get_caps" symbol="gst_app_src_get_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
				</parameters>
			</method>
			<method name="get_emit_signals" symbol="gst_app_src_get_emit_signals">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
				</parameters>
			</method>
			<method name="get_latency" symbol="gst_app_src_get_latency">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
					<parameter name="min" type="guint64*"/>
					<parameter name="max" type="guint64*"/>
				</parameters>
			</method>
			<method name="get_max_bytes" symbol="gst_app_src_get_max_bytes">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gst_app_src_get_size">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
				</parameters>
			</method>
			<method name="get_stream_type" symbol="gst_app_src_get_stream_type">
				<return-type type="GstAppStreamType"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
				</parameters>
			</method>
			<method name="push_buffer" symbol="gst_app_src_push_buffer">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="set_callbacks" symbol="gst_app_src_set_callbacks">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
					<parameter name="callbacks" type="GstAppSrcCallbacks*"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_caps" symbol="gst_app_src_set_caps">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</method>
			<method name="set_emit_signals" symbol="gst_app_src_set_emit_signals">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
					<parameter name="emit" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_latency" symbol="gst_app_src_set_latency">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
					<parameter name="min" type="guint64"/>
					<parameter name="max" type="guint64"/>
				</parameters>
			</method>
			<method name="set_max_bytes" symbol="gst_app_src_set_max_bytes">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
					<parameter name="max" type="guint64"/>
				</parameters>
			</method>
			<method name="set_size" symbol="gst_app_src_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
					<parameter name="size" type="gint64"/>
				</parameters>
			</method>
			<method name="set_stream_type" symbol="gst_app_src_set_stream_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="appsrc" type="GstAppSrc*"/>
					<parameter name="type" type="GstAppStreamType"/>
				</parameters>
			</method>
			<property name="block" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="caps" type="GstCaps*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="emit-signals" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="format" type="GstFormat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-live" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-bytes" type="guint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-latency" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="min-latency" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="min-percent" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="size" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="stream-type" type="GstAppStreamType" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="end-of-stream" when="LAST">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="src" type="GstAppSrc*"/>
				</parameters>
			</signal>
			<signal name="enough-data" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstAppSrc*"/>
				</parameters>
			</signal>
			<signal name="need-data" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstAppSrc*"/>
					<parameter name="length" type="guint"/>
				</parameters>
			</signal>
			<signal name="push-buffer" when="LAST">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="src" type="GstAppSrc*"/>
					<parameter name="buffer" type="GstBuffer"/>
				</parameters>
			</signal>
			<signal name="seek-data" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstAppSrc*"/>
					<parameter name="offset" type="guint64"/>
				</parameters>
			</signal>
		</object>
	</namespace>
</api>
