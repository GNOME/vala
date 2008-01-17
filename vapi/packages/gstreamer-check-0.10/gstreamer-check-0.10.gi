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
		<function name="check_chain_func" symbol="gst_check_chain_func">
			<return-type type="GstFlowReturn"/>
			<parameters>
				<parameter name="pad" type="GstPad*"/>
				<parameter name="buffer" type="GstBuffer*"/>
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
		<function name="check_setup_src_pad" symbol="gst_check_setup_src_pad">
			<return-type type="GstPad*"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
				<parameter name="template" type="GstStaticPadTemplate*"/>
				<parameter name="caps" type="GstCaps*"/>
			</parameters>
		</function>
		<function name="check_teardown_element" symbol="gst_check_teardown_element">
			<return-type type="void"/>
			<parameters>
				<parameter name="element" type="GstElement*"/>
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
