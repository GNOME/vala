<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="buffer_straw_get_buffer" symbol="gst_buffer_straw_get_buffer">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="bin" type="GstElement*"/>
				<parameter name="pad" type="GstPad*"/>
			</parameters>
		</function>
		<function name="buffer_straw_start_pipeline" symbol="gst_buffer_straw_start_pipeline">
			<return-type type="void"/>
			<parameters>
				<parameter name="bin" type="GstElement*"/>
				<parameter name="pad" type="GstPad*"/>
			</parameters>
		</function>
		<function name="buffer_straw_stop_pipeline" symbol="gst_buffer_straw_stop_pipeline">
			<return-type type="void"/>
			<parameters>
				<parameter name="bin" type="GstElement*"/>
				<parameter name="pad" type="GstPad*"/>
			</parameters>
		</function>
		<function name="check_abi_list" symbol="gst_check_abi_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GstCheckABIStruct[]"/>
				<parameter name="have_abi_sizes" type="gboolean"/>
			</parameters>
		</function>
		<function name="check_caps_equal" symbol="gst_check_caps_equal">
			<return-type type="void"/>
			<parameters>
				<parameter name="caps1" type="GstCaps*"/>
				<parameter name="caps2" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="check_chain_func" symbol="gst_check_chain_func">
			<return-type type="GstFlowReturn"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="check_drop_buffers" symbol="gst_check_drop_buffers">
			<return-type type="void"/>
		</function>
		<function name="check_element_push_buffer" symbol="gst_check_element_push_buffer">
			<return-type type="void"/>
			<parameters>
				<parameter name="element_name" type="gchar*"/>
				<parameter name="buffer_in" type="GstBuffer*"/>
				<parameter name="buffer_out" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="check_element_push_buffer_list" symbol="gst_check_element_push_buffer_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="element_name" type="gchar*"/>
				<parameter name="buffer_in" type="GList*"/>
				<parameter name="buffer_out" type="GList*"/>
				<parameter name="last_flow_return" type="GstFlowReturn"/>
			</parameters>
		</function>
		<function name="check_init" symbol="gst_check_init">
			<return-type type="void"/>
			<parameters>
				<parameter name="argc" type="int*"/>
				<parameter name="argv" type="char**[]"/>
			</parameters>
		</function>
		<function name="check_message_error" symbol="gst_check_message_error">
			<return-type type="void"/>
			<parameters>
				<parameter name="message" type="GstMessage*"/>
				<parameter name="type" type="GstMessageType"/>
				<parameter name="domain" type="GQuark"/>
				<parameter name="code" type="gint"/>
			</parameters>
		</function>
		<function name="check_run_suite" symbol="gst_check_run_suite">
			<return-type type="gint"/>
			<parameters>
				<parameter name="suite" type="Suite*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="fname" type="gchar*"/>
			</parameters>
		</function>
		<function name="check_setup_element" symbol="gst_check_setup_element">
			<return-type type="GstElement*"/>
			<parameters>
				<parameter name="factory" type="gchar*"/>
			</parameters>
		</function>
		<function name="check_setup_sink_pad" symbol="gst_check_setup_sink_pad">
			<return-type type="GstPad*"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="template" type="GstStaticPadTemplate*"/>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="check_setup_sink_pad_by_name" symbol="gst_check_setup_sink_pad_by_name">
			<return-type type="GstPad*"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="template" type="GstStaticPadTemplate*"/>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="check_setup_src_pad" symbol="gst_check_setup_src_pad">
			<return-type type="GstPad*"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="template" type="GstStaticPadTemplate*"/>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="check_setup_src_pad_by_name" symbol="gst_check_setup_src_pad_by_name">
			<return-type type="GstPad*"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="template" type="GstStaticPadTemplate*"/>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="check_teardown_element" symbol="gst_check_teardown_element">
			<return-type type="void"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
			</parameters>
		</function>
		<function name="check_teardown_pad_by_name" symbol="gst_check_teardown_pad_by_name">
			<return-type type="void"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="check_teardown_sink_pad" symbol="gst_check_teardown_sink_pad">
			<return-type type="void"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
			</parameters>
		</function>
		<function name="check_teardown_src_pad" symbol="gst_check_teardown_src_pad">
			<return-type type="void"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
			</parameters>
		</function>
		<struct name="GstCheckABIStruct">
			<field name="name" type="char*"/>
			<field name="size" type="int"/>
			<field name="abi_size" type="int"/>
		</struct>
	</namespace>
</api>
