<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="rtcp_buffer_add_packet" symbol="gst_rtcp_buffer_add_packet">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="type" type="GstRTCPType"/>
				<parameter name="packet" type="GstRTCPPacket*"/>
			</parameters>
		</function>
		<function name="rtcp_buffer_end" symbol="gst_rtcp_buffer_end">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtcp_buffer_get_first_packet" symbol="gst_rtcp_buffer_get_first_packet">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="packet" type="GstRTCPPacket*"/>
			</parameters>
		</function>
		<function name="rtcp_buffer_get_packet_count" symbol="gst_rtcp_buffer_get_packet_count">
			<return-type type="guint"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtcp_buffer_new" symbol="gst_rtcp_buffer_new">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="mtu" type="guint"/>
			</parameters>
		</function>
		<function name="rtcp_buffer_new_copy_data" symbol="gst_rtcp_buffer_new_copy_data">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="rtcp_buffer_new_take_data" symbol="gst_rtcp_buffer_new_take_data">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="rtcp_buffer_validate" symbol="gst_rtcp_buffer_validate">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtcp_buffer_validate_data" symbol="gst_rtcp_buffer_validate_data">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="data" type="guint8*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="rtcp_ntp_to_unix" symbol="gst_rtcp_ntp_to_unix">
			<return-type type="guint64"/>
			<parameters>
				<parameter name="ntptime" type="guint64"/>
			</parameters>
		</function>
		<function name="rtcp_sdes_name_to_type" symbol="gst_rtcp_sdes_name_to_type">
			<return-type type="GstRTCPSDESType"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="rtcp_sdes_type_to_name" symbol="gst_rtcp_sdes_type_to_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="type" type="GstRTCPSDESType"/>
			</parameters>
		</function>
		<function name="rtcp_unix_to_ntp" symbol="gst_rtcp_unix_to_ntp">
			<return-type type="guint64"/>
			<parameters>
				<parameter name="unixtime" type="guint64"/>
			</parameters>
		</function>
		<function name="rtp_buffer_add_extension_onebyte_header" symbol="gst_rtp_buffer_add_extension_onebyte_header">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="id" type="guint8"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="size" type="guint"/>
			</parameters>
		</function>
		<function name="rtp_buffer_add_extension_twobytes_header" symbol="gst_rtp_buffer_add_extension_twobytes_header">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="appbits" type="guint8"/>
				<parameter name="id" type="guint8"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="size" type="guint"/>
			</parameters>
		</function>
		<function name="rtp_buffer_allocate_data" symbol="gst_rtp_buffer_allocate_data">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="payload_len" type="guint"/>
				<parameter name="pad_len" type="guint8"/>
				<parameter name="csrc_count" type="guint8"/>
			</parameters>
		</function>
		<function name="rtp_buffer_calc_header_len" symbol="gst_rtp_buffer_calc_header_len">
			<return-type type="guint"/>
			<parameters>
				<parameter name="csrc_count" type="guint8"/>
			</parameters>
		</function>
		<function name="rtp_buffer_calc_packet_len" symbol="gst_rtp_buffer_calc_packet_len">
			<return-type type="guint"/>
			<parameters>
				<parameter name="payload_len" type="guint"/>
				<parameter name="pad_len" type="guint8"/>
				<parameter name="csrc_count" type="guint8"/>
			</parameters>
		</function>
		<function name="rtp_buffer_calc_payload_len" symbol="gst_rtp_buffer_calc_payload_len">
			<return-type type="guint"/>
			<parameters>
				<parameter name="packet_len" type="guint"/>
				<parameter name="pad_len" type="guint8"/>
				<parameter name="csrc_count" type="guint8"/>
			</parameters>
		</function>
		<function name="rtp_buffer_compare_seqnum" symbol="gst_rtp_buffer_compare_seqnum">
			<return-type type="gint"/>
			<parameters>
				<parameter name="seqnum1" type="guint16"/>
				<parameter name="seqnum2" type="guint16"/>
			</parameters>
		</function>
		<function name="rtp_buffer_default_clock_rate" symbol="gst_rtp_buffer_default_clock_rate">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="payload_type" type="guint8"/>
			</parameters>
		</function>
		<function name="rtp_buffer_ext_timestamp" symbol="gst_rtp_buffer_ext_timestamp">
			<return-type type="guint64"/>
			<parameters>
				<parameter name="exttimestamp" type="guint64*"/>
				<parameter name="timestamp" type="guint32"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_csrc" symbol="gst_rtp_buffer_get_csrc">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="idx" type="guint8"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_csrc_count" symbol="gst_rtp_buffer_get_csrc_count">
			<return-type type="guint8"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_extension" symbol="gst_rtp_buffer_get_extension">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_extension_data" symbol="gst_rtp_buffer_get_extension_data">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="bits" type="guint16*"/>
				<parameter name="data" type="gpointer*"/>
				<parameter name="wordlen" type="guint*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_extension_onebyte_header" symbol="gst_rtp_buffer_get_extension_onebyte_header">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="id" type="guint8"/>
				<parameter name="nth" type="guint"/>
				<parameter name="data" type="gpointer*"/>
				<parameter name="size" type="guint*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_extension_twobytes_header" symbol="gst_rtp_buffer_get_extension_twobytes_header">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="appbits" type="guint8*"/>
				<parameter name="id" type="guint8"/>
				<parameter name="nth" type="guint"/>
				<parameter name="data" type="gpointer*"/>
				<parameter name="size" type="guint*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_header_len" symbol="gst_rtp_buffer_get_header_len">
			<return-type type="guint"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_marker" symbol="gst_rtp_buffer_get_marker">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_packet_len" symbol="gst_rtp_buffer_get_packet_len">
			<return-type type="guint"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_padding" symbol="gst_rtp_buffer_get_padding">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_payload" symbol="gst_rtp_buffer_get_payload">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_payload_buffer" symbol="gst_rtp_buffer_get_payload_buffer">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_payload_len" symbol="gst_rtp_buffer_get_payload_len">
			<return-type type="guint"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_payload_subbuffer" symbol="gst_rtp_buffer_get_payload_subbuffer">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="offset" type="guint"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_payload_type" symbol="gst_rtp_buffer_get_payload_type">
			<return-type type="guint8"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_seq" symbol="gst_rtp_buffer_get_seq">
			<return-type type="guint16"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_ssrc" symbol="gst_rtp_buffer_get_ssrc">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_timestamp" symbol="gst_rtp_buffer_get_timestamp">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_get_version" symbol="gst_rtp_buffer_get_version">
			<return-type type="guint8"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_add_extension_onebyte_header" symbol="gst_rtp_buffer_list_add_extension_onebyte_header">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="it" type="GstBufferListIterator*"/>
				<parameter name="id" type="guint8"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="size" type="guint"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_add_extension_twobytes_header" symbol="gst_rtp_buffer_list_add_extension_twobytes_header">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="it" type="GstBufferListIterator*"/>
				<parameter name="appbits" type="guint8"/>
				<parameter name="id" type="guint8"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="size" type="guint"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_from_buffer" symbol="gst_rtp_buffer_list_from_buffer">
			<return-type type="GstBufferList*"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_get_extension_onebyte_header" symbol="gst_rtp_buffer_list_get_extension_onebyte_header">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="bufferlist" type="GstBufferList*"/>
				<parameter name="group_idx" type="guint"/>
				<parameter name="id" type="guint8"/>
				<parameter name="nth" type="guint"/>
				<parameter name="data" type="gpointer*"/>
				<parameter name="size" type="guint*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_get_extension_twobytes_header" symbol="gst_rtp_buffer_list_get_extension_twobytes_header">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="bufferlist" type="GstBufferList*"/>
				<parameter name="group_idx" type="guint"/>
				<parameter name="appbits" type="guint8*"/>
				<parameter name="id" type="guint8"/>
				<parameter name="nth" type="guint"/>
				<parameter name="data" type="gpointer*"/>
				<parameter name="size" type="guint*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_get_payload_len" symbol="gst_rtp_buffer_list_get_payload_len">
			<return-type type="guint"/>
			<parameters>
				<parameter name="list" type="GstBufferList*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_get_payload_type" symbol="gst_rtp_buffer_list_get_payload_type">
			<return-type type="guint8"/>
			<parameters>
				<parameter name="list" type="GstBufferList*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_get_seq" symbol="gst_rtp_buffer_list_get_seq">
			<return-type type="guint16"/>
			<parameters>
				<parameter name="list" type="GstBufferList*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_get_ssrc" symbol="gst_rtp_buffer_list_get_ssrc">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="list" type="GstBufferList*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_get_timestamp" symbol="gst_rtp_buffer_list_get_timestamp">
			<return-type type="guint32"/>
			<parameters>
				<parameter name="list" type="GstBufferList*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_set_payload_type" symbol="gst_rtp_buffer_list_set_payload_type">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GstBufferList*"/>
				<parameter name="payload_type" type="guint8"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_set_seq" symbol="gst_rtp_buffer_list_set_seq">
			<return-type type="guint16"/>
			<parameters>
				<parameter name="list" type="GstBufferList*"/>
				<parameter name="seq" type="guint16"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_set_ssrc" symbol="gst_rtp_buffer_list_set_ssrc">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GstBufferList*"/>
				<parameter name="ssrc" type="guint32"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_set_timestamp" symbol="gst_rtp_buffer_list_set_timestamp">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GstBufferList*"/>
				<parameter name="timestamp" type="guint32"/>
			</parameters>
		</function>
		<function name="rtp_buffer_list_validate" symbol="gst_rtp_buffer_list_validate">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="list" type="GstBufferList*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_new_allocate" symbol="gst_rtp_buffer_new_allocate">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="payload_len" type="guint"/>
				<parameter name="pad_len" type="guint8"/>
				<parameter name="csrc_count" type="guint8"/>
			</parameters>
		</function>
		<function name="rtp_buffer_new_allocate_len" symbol="gst_rtp_buffer_new_allocate_len">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="packet_len" type="guint"/>
				<parameter name="pad_len" type="guint8"/>
				<parameter name="csrc_count" type="guint8"/>
			</parameters>
		</function>
		<function name="rtp_buffer_new_copy_data" symbol="gst_rtp_buffer_new_copy_data">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="rtp_buffer_new_take_data" symbol="gst_rtp_buffer_new_take_data">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="rtp_buffer_pad_to" symbol="gst_rtp_buffer_pad_to">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="rtp_buffer_set_csrc" symbol="gst_rtp_buffer_set_csrc">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="idx" type="guint8"/>
				<parameter name="csrc" type="guint32"/>
			</parameters>
		</function>
		<function name="rtp_buffer_set_extension" symbol="gst_rtp_buffer_set_extension">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="extension" type="gboolean"/>
			</parameters>
		</function>
		<function name="rtp_buffer_set_extension_data" symbol="gst_rtp_buffer_set_extension_data">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="bits" type="guint16"/>
				<parameter name="length" type="guint16"/>
			</parameters>
		</function>
		<function name="rtp_buffer_set_marker" symbol="gst_rtp_buffer_set_marker">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="marker" type="gboolean"/>
			</parameters>
		</function>
		<function name="rtp_buffer_set_packet_len" symbol="gst_rtp_buffer_set_packet_len">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="rtp_buffer_set_padding" symbol="gst_rtp_buffer_set_padding">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="padding" type="gboolean"/>
			</parameters>
		</function>
		<function name="rtp_buffer_set_payload_type" symbol="gst_rtp_buffer_set_payload_type">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="payload_type" type="guint8"/>
			</parameters>
		</function>
		<function name="rtp_buffer_set_seq" symbol="gst_rtp_buffer_set_seq">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="seq" type="guint16"/>
			</parameters>
		</function>
		<function name="rtp_buffer_set_ssrc" symbol="gst_rtp_buffer_set_ssrc">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="ssrc" type="guint32"/>
			</parameters>
		</function>
		<function name="rtp_buffer_set_timestamp" symbol="gst_rtp_buffer_set_timestamp">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="timestamp" type="guint32"/>
			</parameters>
		</function>
		<function name="rtp_buffer_set_version" symbol="gst_rtp_buffer_set_version">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="version" type="guint8"/>
			</parameters>
		</function>
		<function name="rtp_buffer_validate" symbol="gst_rtp_buffer_validate">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buffer" type="GstBuffer*"/>
			</parameters>
		</function>
		<function name="rtp_buffer_validate_data" symbol="gst_rtp_buffer_validate_data">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="data" type="guint8*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<struct name="GstRTCPPacket">
			<method name="add_rb" symbol="gst_rtcp_packet_add_rb">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="ssrc" type="guint32"/>
					<parameter name="fractionlost" type="guint8"/>
					<parameter name="packetslost" type="gint32"/>
					<parameter name="exthighestseq" type="guint32"/>
					<parameter name="jitter" type="guint32"/>
					<parameter name="lsr" type="guint32"/>
					<parameter name="dlsr" type="guint32"/>
				</parameters>
			</method>
			<method name="bye_add_ssrc" symbol="gst_rtcp_packet_bye_add_ssrc">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="ssrc" type="guint32"/>
				</parameters>
			</method>
			<method name="bye_add_ssrcs" symbol="gst_rtcp_packet_bye_add_ssrcs">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="ssrc" type="guint32*"/>
					<parameter name="len" type="guint"/>
				</parameters>
			</method>
			<method name="bye_get_nth_ssrc" symbol="gst_rtcp_packet_bye_get_nth_ssrc">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="nth" type="guint"/>
				</parameters>
			</method>
			<method name="bye_get_reason" symbol="gst_rtcp_packet_bye_get_reason">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="bye_get_reason_len" symbol="gst_rtcp_packet_bye_get_reason_len">
				<return-type type="guint8"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="bye_get_ssrc_count" symbol="gst_rtcp_packet_bye_get_ssrc_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="bye_set_reason" symbol="gst_rtcp_packet_bye_set_reason">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="reason" type="gchar*"/>
				</parameters>
			</method>
			<method name="fb_get_fci" symbol="gst_rtcp_packet_fb_get_fci">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="fb_get_fci_length" symbol="gst_rtcp_packet_fb_get_fci_length">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="fb_get_media_ssrc" symbol="gst_rtcp_packet_fb_get_media_ssrc">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="fb_get_sender_ssrc" symbol="gst_rtcp_packet_fb_get_sender_ssrc">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="fb_get_type" symbol="gst_rtcp_packet_fb_get_type">
				<return-type type="GstRTCPFBType"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="fb_set_fci_length" symbol="gst_rtcp_packet_fb_set_fci_length">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="wordlen" type="guint16"/>
				</parameters>
			</method>
			<method name="fb_set_media_ssrc" symbol="gst_rtcp_packet_fb_set_media_ssrc">
				<return-type type="void"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="ssrc" type="guint32"/>
				</parameters>
			</method>
			<method name="fb_set_sender_ssrc" symbol="gst_rtcp_packet_fb_set_sender_ssrc">
				<return-type type="void"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="ssrc" type="guint32"/>
				</parameters>
			</method>
			<method name="fb_set_type" symbol="gst_rtcp_packet_fb_set_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="type" type="GstRTCPFBType"/>
				</parameters>
			</method>
			<method name="get_count" symbol="gst_rtcp_packet_get_count">
				<return-type type="guint8"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="gst_rtcp_packet_get_length">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="get_padding" symbol="gst_rtcp_packet_get_padding">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="get_rb" symbol="gst_rtcp_packet_get_rb">
				<return-type type="void"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="nth" type="guint"/>
					<parameter name="ssrc" type="guint32*"/>
					<parameter name="fractionlost" type="guint8*"/>
					<parameter name="packetslost" type="gint32*"/>
					<parameter name="exthighestseq" type="guint32*"/>
					<parameter name="jitter" type="guint32*"/>
					<parameter name="lsr" type="guint32*"/>
					<parameter name="dlsr" type="guint32*"/>
				</parameters>
			</method>
			<method name="get_rb_count" symbol="gst_rtcp_packet_get_rb_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="move_to_next" symbol="gst_rtcp_packet_move_to_next">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="remove" symbol="gst_rtcp_packet_remove">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="rr_get_ssrc" symbol="gst_rtcp_packet_rr_get_ssrc">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="rr_set_ssrc" symbol="gst_rtcp_packet_rr_set_ssrc">
				<return-type type="void"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="ssrc" type="guint32"/>
				</parameters>
			</method>
			<method name="sdes_add_entry" symbol="gst_rtcp_packet_sdes_add_entry">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="type" type="GstRTCPSDESType"/>
					<parameter name="len" type="guint8"/>
					<parameter name="data" type="guint8*"/>
				</parameters>
			</method>
			<method name="sdes_add_item" symbol="gst_rtcp_packet_sdes_add_item">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="ssrc" type="guint32"/>
				</parameters>
			</method>
			<method name="sdes_copy_entry" symbol="gst_rtcp_packet_sdes_copy_entry">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="type" type="GstRTCPSDESType*"/>
					<parameter name="len" type="guint8*"/>
					<parameter name="data" type="guint8**"/>
				</parameters>
			</method>
			<method name="sdes_first_entry" symbol="gst_rtcp_packet_sdes_first_entry">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="sdes_first_item" symbol="gst_rtcp_packet_sdes_first_item">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="sdes_get_entry" symbol="gst_rtcp_packet_sdes_get_entry">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="type" type="GstRTCPSDESType*"/>
					<parameter name="len" type="guint8*"/>
					<parameter name="data" type="guint8**"/>
				</parameters>
			</method>
			<method name="sdes_get_item_count" symbol="gst_rtcp_packet_sdes_get_item_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="sdes_get_ssrc" symbol="gst_rtcp_packet_sdes_get_ssrc">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="sdes_next_entry" symbol="gst_rtcp_packet_sdes_next_entry">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="sdes_next_item" symbol="gst_rtcp_packet_sdes_next_item">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
				</parameters>
			</method>
			<method name="set_rb" symbol="gst_rtcp_packet_set_rb">
				<return-type type="void"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="nth" type="guint"/>
					<parameter name="ssrc" type="guint32"/>
					<parameter name="fractionlost" type="guint8"/>
					<parameter name="packetslost" type="gint32"/>
					<parameter name="exthighestseq" type="guint32"/>
					<parameter name="jitter" type="guint32"/>
					<parameter name="lsr" type="guint32"/>
					<parameter name="dlsr" type="guint32"/>
				</parameters>
			</method>
			<method name="sr_get_sender_info" symbol="gst_rtcp_packet_sr_get_sender_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="ssrc" type="guint32*"/>
					<parameter name="ntptime" type="guint64*"/>
					<parameter name="rtptime" type="guint32*"/>
					<parameter name="packet_count" type="guint32*"/>
					<parameter name="octet_count" type="guint32*"/>
				</parameters>
			</method>
			<method name="sr_set_sender_info" symbol="gst_rtcp_packet_sr_set_sender_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="packet" type="GstRTCPPacket*"/>
					<parameter name="ssrc" type="guint32"/>
					<parameter name="ntptime" type="guint64"/>
					<parameter name="rtptime" type="guint32"/>
					<parameter name="packet_count" type="guint32"/>
					<parameter name="octet_count" type="guint32"/>
				</parameters>
			</method>
			<field name="buffer" type="GstBuffer*"/>
			<field name="offset" type="guint"/>
			<field name="padding" type="gboolean"/>
			<field name="count" type="guint8"/>
			<field name="type" type="GstRTCPType"/>
			<field name="length" type="guint16"/>
			<field name="item_offset" type="guint"/>
			<field name="item_count" type="guint"/>
			<field name="entry_offset" type="guint"/>
		</struct>
		<struct name="GstRTPPayloadInfo">
			<method name="for_name" symbol="gst_rtp_payload_info_for_name">
				<return-type type="GstRTPPayloadInfo*"/>
				<parameters>
					<parameter name="media" type="gchar*"/>
					<parameter name="encoding_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="for_pt" symbol="gst_rtp_payload_info_for_pt">
				<return-type type="GstRTPPayloadInfo*"/>
				<parameters>
					<parameter name="payload_type" type="guint8"/>
				</parameters>
			</method>
			<field name="payload_type" type="guint8"/>
			<field name="media" type="gchar*"/>
			<field name="encoding_name" type="gchar*"/>
			<field name="clock_rate" type="guint"/>
			<field name="encoding_parameters" type="gchar*"/>
			<field name="bitrate" type="guint"/>
		</struct>
		<enum name="GstRTCPFBType">
			<member name="GST_RTCP_FB_TYPE_INVALID" value="0"/>
			<member name="GST_RTCP_RTPFB_TYPE_NACK" value="1"/>
			<member name="GST_RTCP_PSFB_TYPE_PLI" value="1"/>
			<member name="GST_RTCP_PSFB_TYPE_SLI" value="2"/>
			<member name="GST_RTCP_PSFB_TYPE_RPSI" value="3"/>
			<member name="GST_RTCP_PSFB_TYPE_AFB" value="15"/>
		</enum>
		<enum name="GstRTCPSDESType">
			<member name="GST_RTCP_SDES_INVALID" value="-1"/>
			<member name="GST_RTCP_SDES_END" value="0"/>
			<member name="GST_RTCP_SDES_CNAME" value="1"/>
			<member name="GST_RTCP_SDES_NAME" value="2"/>
			<member name="GST_RTCP_SDES_EMAIL" value="3"/>
			<member name="GST_RTCP_SDES_PHONE" value="4"/>
			<member name="GST_RTCP_SDES_LOC" value="5"/>
			<member name="GST_RTCP_SDES_TOOL" value="6"/>
			<member name="GST_RTCP_SDES_NOTE" value="7"/>
			<member name="GST_RTCP_SDES_PRIV" value="8"/>
		</enum>
		<enum name="GstRTCPType">
			<member name="GST_RTCP_TYPE_INVALID" value="0"/>
			<member name="GST_RTCP_TYPE_SR" value="200"/>
			<member name="GST_RTCP_TYPE_RR" value="201"/>
			<member name="GST_RTCP_TYPE_SDES" value="202"/>
			<member name="GST_RTCP_TYPE_BYE" value="203"/>
			<member name="GST_RTCP_TYPE_APP" value="204"/>
			<member name="GST_RTCP_TYPE_RTPFB" value="205"/>
			<member name="GST_RTCP_TYPE_PSFB" value="206"/>
		</enum>
		<enum name="GstRTPPayload">
			<member name="GST_RTP_PAYLOAD_PCMU" value="0"/>
			<member name="GST_RTP_PAYLOAD_1016" value="1"/>
			<member name="GST_RTP_PAYLOAD_G721" value="2"/>
			<member name="GST_RTP_PAYLOAD_GSM" value="3"/>
			<member name="GST_RTP_PAYLOAD_G723" value="4"/>
			<member name="GST_RTP_PAYLOAD_DVI4_8000" value="5"/>
			<member name="GST_RTP_PAYLOAD_DVI4_16000" value="6"/>
			<member name="GST_RTP_PAYLOAD_LPC" value="7"/>
			<member name="GST_RTP_PAYLOAD_PCMA" value="8"/>
			<member name="GST_RTP_PAYLOAD_G722" value="9"/>
			<member name="GST_RTP_PAYLOAD_L16_STEREO" value="10"/>
			<member name="GST_RTP_PAYLOAD_L16_MONO" value="11"/>
			<member name="GST_RTP_PAYLOAD_QCELP" value="12"/>
			<member name="GST_RTP_PAYLOAD_CN" value="13"/>
			<member name="GST_RTP_PAYLOAD_MPA" value="14"/>
			<member name="GST_RTP_PAYLOAD_G728" value="15"/>
			<member name="GST_RTP_PAYLOAD_DVI4_11025" value="16"/>
			<member name="GST_RTP_PAYLOAD_DVI4_22050" value="17"/>
			<member name="GST_RTP_PAYLOAD_G729" value="18"/>
			<member name="GST_RTP_PAYLOAD_CELLB" value="25"/>
			<member name="GST_RTP_PAYLOAD_JPEG" value="26"/>
			<member name="GST_RTP_PAYLOAD_NV" value="28"/>
			<member name="GST_RTP_PAYLOAD_H261" value="31"/>
			<member name="GST_RTP_PAYLOAD_MPV" value="32"/>
			<member name="GST_RTP_PAYLOAD_MP2T" value="33"/>
			<member name="GST_RTP_PAYLOAD_H263" value="34"/>
		</enum>
		<object name="GstBaseRTPAudioPayload" parent="GstBaseRTPPayload" type-name="GstBaseRTPAudioPayload" get-type="gst_base_rtp_audio_payload_get_type">
			<method name="flush" symbol="gst_base_rtp_audio_payload_flush">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="baseaudiopayload" type="GstBaseRTPAudioPayload*"/>
					<parameter name="payload_len" type="guint"/>
					<parameter name="timestamp" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="get_adapter" symbol="gst_base_rtp_audio_payload_get_adapter">
				<return-type type="GstAdapter*"/>
				<parameters>
					<parameter name="basertpaudiopayload" type="GstBaseRTPAudioPayload*"/>
				</parameters>
			</method>
			<method name="push" symbol="gst_base_rtp_audio_payload_push">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="baseaudiopayload" type="GstBaseRTPAudioPayload*"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="payload_len" type="guint"/>
					<parameter name="timestamp" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="set_frame_based" symbol="gst_base_rtp_audio_payload_set_frame_based">
				<return-type type="void"/>
				<parameters>
					<parameter name="basertpaudiopayload" type="GstBaseRTPAudioPayload*"/>
				</parameters>
			</method>
			<method name="set_frame_options" symbol="gst_base_rtp_audio_payload_set_frame_options">
				<return-type type="void"/>
				<parameters>
					<parameter name="basertpaudiopayload" type="GstBaseRTPAudioPayload*"/>
					<parameter name="frame_duration" type="gint"/>
					<parameter name="frame_size" type="gint"/>
				</parameters>
			</method>
			<method name="set_sample_based" symbol="gst_base_rtp_audio_payload_set_sample_based">
				<return-type type="void"/>
				<parameters>
					<parameter name="basertpaudiopayload" type="GstBaseRTPAudioPayload*"/>
				</parameters>
			</method>
			<method name="set_sample_options" symbol="gst_base_rtp_audio_payload_set_sample_options">
				<return-type type="void"/>
				<parameters>
					<parameter name="basertpaudiopayload" type="GstBaseRTPAudioPayload*"/>
					<parameter name="sample_size" type="gint"/>
				</parameters>
			</method>
			<method name="set_samplebits_options" symbol="gst_base_rtp_audio_payload_set_samplebits_options">
				<return-type type="void"/>
				<parameters>
					<parameter name="basertpaudiopayload" type="GstBaseRTPAudioPayload*"/>
					<parameter name="sample_size" type="gint"/>
				</parameters>
			</method>
			<property name="buffer-list" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="base_ts" type="GstClockTime"/>
			<field name="frame_size" type="gint"/>
			<field name="frame_duration" type="gint"/>
			<field name="sample_size" type="gint"/>
		</object>
		<object name="GstBaseRTPDepayload" parent="GstElement" type-name="GstBaseRTPDepayload" get-type="gst_base_rtp_depayload_get_type">
			<method name="push" symbol="gst_base_rtp_depayload_push">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="filter" type="GstBaseRTPDepayload*"/>
					<parameter name="out_buf" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="push_list" symbol="gst_base_rtp_depayload_push_list">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="filter" type="GstBaseRTPDepayload*"/>
					<parameter name="out_list" type="GstBufferList*"/>
				</parameters>
			</method>
			<method name="push_ts" symbol="gst_base_rtp_depayload_push_ts">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="filter" type="GstBaseRTPDepayload*"/>
					<parameter name="timestamp" type="guint32"/>
					<parameter name="out_buf" type="GstBuffer*"/>
				</parameters>
			</method>
			<property name="queue-delay" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="add_to_queue">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="filter" type="GstBaseRTPDepayload*"/>
					<parameter name="in" type="GstBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="handle_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="filter" type="GstBaseRTPDepayload*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</vfunc>
			<vfunc name="packet_lost">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="filter" type="GstBaseRTPDepayload*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</vfunc>
			<vfunc name="process">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="base" type="GstBaseRTPDepayload*"/>
					<parameter name="in" type="GstBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="filter" type="GstBaseRTPDepayload*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_gst_timestamp">
				<return-type type="void"/>
				<parameters>
					<parameter name="filter" type="GstBaseRTPDepayload*"/>
					<parameter name="timestamp" type="guint32"/>
					<parameter name="buf" type="GstBuffer*"/>
				</parameters>
			</vfunc>
			<field name="sinkpad" type="GstPad*"/>
			<field name="srcpad" type="GstPad*"/>
			<field name="queuelock" type="GStaticRecMutex"/>
			<field name="thread_running" type="gboolean"/>
			<field name="thread" type="GThread*"/>
			<field name="clock_rate" type="guint"/>
			<field name="queue_delay" type="guint"/>
			<field name="queue" type="GQueue*"/>
			<field name="segment" type="GstSegment"/>
			<field name="need_newsegment" type="gboolean"/>
		</object>
		<object name="GstBaseRTPPayload" parent="GstElement" type-name="GstBaseRTPPayload" get-type="gst_basertppayload_get_type">
			<method name="is_filled" symbol="gst_basertppayload_is_filled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="payload" type="GstBaseRTPPayload*"/>
					<parameter name="size" type="guint"/>
					<parameter name="duration" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="push" symbol="gst_basertppayload_push">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="payload" type="GstBaseRTPPayload*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="push_list" symbol="gst_basertppayload_push_list">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="payload" type="GstBaseRTPPayload*"/>
					<parameter name="list" type="GstBufferList*"/>
				</parameters>
			</method>
			<method name="set_options" symbol="gst_basertppayload_set_options">
				<return-type type="void"/>
				<parameters>
					<parameter name="payload" type="GstBaseRTPPayload*"/>
					<parameter name="media" type="gchar*"/>
					<parameter name="dynamic" type="gboolean"/>
					<parameter name="encoding_name" type="gchar*"/>
					<parameter name="clock_rate" type="guint32"/>
				</parameters>
			</method>
			<method name="set_outcaps" symbol="gst_basertppayload_set_outcaps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="payload" type="GstBaseRTPPayload*"/>
					<parameter name="fieldname" type="gchar*"/>
				</parameters>
			</method>
			<property name="max-ptime" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="min-ptime" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="mtu" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="perfect-rtptime" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pt" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ptime-multiple" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="seqnum" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="seqnum-offset" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ssrc" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="timestamp" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="timestamp-offset" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="get_caps">
				<return-type type="GstCaps*"/>
				<parameters>
					<parameter name="payload" type="GstBaseRTPPayload*"/>
					<parameter name="pad" type="GstPad*"/>
				</parameters>
			</vfunc>
			<vfunc name="handle_buffer">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="payload" type="GstBaseRTPPayload*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</vfunc>
			<vfunc name="handle_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pad" type="GstPad*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="payload" type="GstBaseRTPPayload*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</vfunc>
			<field name="sinkpad" type="GstPad*"/>
			<field name="srcpad" type="GstPad*"/>
			<field name="seq_rand" type="GRand*"/>
			<field name="ssrc_rand" type="GRand*"/>
			<field name="ts_rand" type="GRand*"/>
			<field name="ts_base" type="guint32"/>
			<field name="seqnum_base" type="guint16"/>
			<field name="media" type="gchar*"/>
			<field name="encoding_name" type="gchar*"/>
			<field name="dynamic" type="gboolean"/>
			<field name="clock_rate" type="guint32"/>
			<field name="ts_offset" type="gint32"/>
			<field name="timestamp" type="guint32"/>
			<field name="seqnum_offset" type="gint16"/>
			<field name="seqnum" type="guint16"/>
			<field name="max_ptime" type="gint64"/>
			<field name="pt" type="guint"/>
			<field name="ssrc" type="guint"/>
			<field name="current_ssrc" type="guint"/>
			<field name="mtu" type="guint"/>
			<field name="segment" type="GstSegment"/>
			<field name="min_ptime" type="guint64"/>
			<field name="abidata" type="gpointer"/>
		</object>
		<constant name="GST_RTCP_MAX_BYE_SSRC_COUNT" type="int" value="31"/>
		<constant name="GST_RTCP_MAX_RB_COUNT" type="int" value="31"/>
		<constant name="GST_RTCP_MAX_SDES" type="int" value="255"/>
		<constant name="GST_RTCP_MAX_SDES_ITEM_COUNT" type="int" value="31"/>
		<constant name="GST_RTCP_VALID_MASK" type="int" value="57598"/>
		<constant name="GST_RTCP_VALID_VALUE" type="int" value="0"/>
		<constant name="GST_RTCP_VERSION" type="int" value="2"/>
		<constant name="GST_RTP_PAYLOAD_1016_STRING" type="char*" value="1"/>
		<constant name="GST_RTP_PAYLOAD_CELLB_STRING" type="char*" value="25"/>
		<constant name="GST_RTP_PAYLOAD_CN_STRING" type="char*" value="13"/>
		<constant name="GST_RTP_PAYLOAD_DVI4_11025_STRING" type="char*" value="16"/>
		<constant name="GST_RTP_PAYLOAD_DVI4_16000_STRING" type="char*" value="6"/>
		<constant name="GST_RTP_PAYLOAD_DVI4_22050_STRING" type="char*" value="17"/>
		<constant name="GST_RTP_PAYLOAD_DVI4_8000_STRING" type="char*" value="5"/>
		<constant name="GST_RTP_PAYLOAD_DYNAMIC_STRING" type="char*" value="[96, 127]"/>
		<constant name="GST_RTP_PAYLOAD_G721_STRING" type="char*" value="2"/>
		<constant name="GST_RTP_PAYLOAD_G722_STRING" type="char*" value="9"/>
		<constant name="GST_RTP_PAYLOAD_G723_53" type="int" value="17"/>
		<constant name="GST_RTP_PAYLOAD_G723_53_STRING" type="char*" value="17"/>
		<constant name="GST_RTP_PAYLOAD_G723_63" type="int" value="16"/>
		<constant name="GST_RTP_PAYLOAD_G723_63_STRING" type="char*" value="16"/>
		<constant name="GST_RTP_PAYLOAD_G723_STRING" type="char*" value="4"/>
		<constant name="GST_RTP_PAYLOAD_G728_STRING" type="char*" value="15"/>
		<constant name="GST_RTP_PAYLOAD_G729_STRING" type="char*" value="18"/>
		<constant name="GST_RTP_PAYLOAD_GSM_STRING" type="char*" value="3"/>
		<constant name="GST_RTP_PAYLOAD_H261_STRING" type="char*" value="31"/>
		<constant name="GST_RTP_PAYLOAD_H263_STRING" type="char*" value="34"/>
		<constant name="GST_RTP_PAYLOAD_JPEG_STRING" type="char*" value="26"/>
		<constant name="GST_RTP_PAYLOAD_L16_MONO_STRING" type="char*" value="11"/>
		<constant name="GST_RTP_PAYLOAD_L16_STEREO_STRING" type="char*" value="10"/>
		<constant name="GST_RTP_PAYLOAD_LPC_STRING" type="char*" value="7"/>
		<constant name="GST_RTP_PAYLOAD_MP2T_STRING" type="char*" value="33"/>
		<constant name="GST_RTP_PAYLOAD_MPA_STRING" type="char*" value="14"/>
		<constant name="GST_RTP_PAYLOAD_MPV_STRING" type="char*" value="32"/>
		<constant name="GST_RTP_PAYLOAD_NV_STRING" type="char*" value="28"/>
		<constant name="GST_RTP_PAYLOAD_PCMA_STRING" type="char*" value="8"/>
		<constant name="GST_RTP_PAYLOAD_PCMU_STRING" type="char*" value="0"/>
		<constant name="GST_RTP_PAYLOAD_QCELP_STRING" type="char*" value="12"/>
		<constant name="GST_RTP_PAYLOAD_TS41" type="int" value="19"/>
		<constant name="GST_RTP_PAYLOAD_TS41_STRING" type="char*" value="19"/>
		<constant name="GST_RTP_PAYLOAD_TS48" type="int" value="18"/>
		<constant name="GST_RTP_PAYLOAD_TS48_STRING" type="char*" value="18"/>
		<constant name="GST_RTP_VERSION" type="int" value="2"/>
	</namespace>
</api>
