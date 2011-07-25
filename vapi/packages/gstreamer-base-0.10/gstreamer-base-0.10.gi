<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="type_find_helper" symbol="gst_type_find_helper">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="src" type="GstPad*"/>
				<parameter name="size" type="guint64"/>
			</parameters>
		</function>
		<function name="type_find_helper_for_buffer" symbol="gst_type_find_helper_for_buffer">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="obj" type="GstObject*"/>
				<parameter name="buf" type="GstBuffer*"/>
				<parameter name="prob" type="GstTypeFindProbability*"/>
			</parameters>
		</function>
		<function name="type_find_helper_for_extension" symbol="gst_type_find_helper_for_extension">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="obj" type="GstObject*"/>
				<parameter name="extension" type="gchar*"/>
			</parameters>
		</function>
		<function name="type_find_helper_get_range" symbol="gst_type_find_helper_get_range">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="obj" type="GstObject*"/>
				<parameter name="func" type="GstTypeFindHelperGetRangeFunction"/>
				<parameter name="size" type="guint64"/>
				<parameter name="prob" type="GstTypeFindProbability*"/>
			</parameters>
		</function>
		<function name="type_find_helper_get_range_ext" symbol="gst_type_find_helper_get_range_ext">
			<return-type type="GstCaps*"/>
			<parameters>
				<parameter name="obj" type="GstObject*"/>
				<parameter name="func" type="GstTypeFindHelperGetRangeFunction"/>
				<parameter name="size" type="guint64"/>
				<parameter name="extension" type="gchar*"/>
				<parameter name="prob" type="GstTypeFindProbability*"/>
			</parameters>
		</function>
		<callback name="GstCollectDataDestroyNotify">
			<return-type type="void"/>
			<parameters>
				<parameter name="data" type="GstCollectData*"/>
			</parameters>
		</callback>
		<callback name="GstCollectPadsClipFunction">
			<return-type type="GstBuffer*"/>
			<parameters>
				<parameter name="pads" type="GstCollectPads*"/>
				<parameter name="data" type="GstCollectData*"/>
				<parameter name="buffer" type="GstBuffer*"/>
				<parameter name="user_data" type="gpointer"/>
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
		<callback name="GstDataQueueEmptyCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="queue" type="GstDataQueue*"/>
				<parameter name="checkdata" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GstDataQueueFullCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="queue" type="GstDataQueue*"/>
				<parameter name="checkdata" type="gpointer"/>
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
		<struct name="GstBitReader">
			<method name="free" symbol="gst_bit_reader_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
				</parameters>
			</method>
			<method name="get_bits_uint16" symbol="gst_bit_reader_get_bits_uint16">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
					<parameter name="val" type="guint16*"/>
					<parameter name="nbits" type="guint"/>
				</parameters>
			</method>
			<method name="get_bits_uint32" symbol="gst_bit_reader_get_bits_uint32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
					<parameter name="val" type="guint32*"/>
					<parameter name="nbits" type="guint"/>
				</parameters>
			</method>
			<method name="get_bits_uint64" symbol="gst_bit_reader_get_bits_uint64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
					<parameter name="val" type="guint64*"/>
					<parameter name="nbits" type="guint"/>
				</parameters>
			</method>
			<method name="get_bits_uint8" symbol="gst_bit_reader_get_bits_uint8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
					<parameter name="val" type="guint8*"/>
					<parameter name="nbits" type="guint"/>
				</parameters>
			</method>
			<method name="get_pos" symbol="gst_bit_reader_get_pos">
				<return-type type="guint"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
				</parameters>
			</method>
			<method name="get_remaining" symbol="gst_bit_reader_get_remaining">
				<return-type type="guint"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gst_bit_reader_get_size">
				<return-type type="guint"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
				</parameters>
			</method>
			<method name="init" symbol="gst_bit_reader_init">
				<return-type type="void"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="init_from_buffer" symbol="gst_bit_reader_init_from_buffer">
				<return-type type="void"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_bit_reader_new">
				<return-type type="GstBitReader*"/>
				<parameters>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="new_from_buffer" symbol="gst_bit_reader_new_from_buffer">
				<return-type type="GstBitReader*"/>
				<parameters>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="peek_bits_uint16" symbol="gst_bit_reader_peek_bits_uint16">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
					<parameter name="val" type="guint16*"/>
					<parameter name="nbits" type="guint"/>
				</parameters>
			</method>
			<method name="peek_bits_uint32" symbol="gst_bit_reader_peek_bits_uint32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
					<parameter name="val" type="guint32*"/>
					<parameter name="nbits" type="guint"/>
				</parameters>
			</method>
			<method name="peek_bits_uint64" symbol="gst_bit_reader_peek_bits_uint64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
					<parameter name="val" type="guint64*"/>
					<parameter name="nbits" type="guint"/>
				</parameters>
			</method>
			<method name="peek_bits_uint8" symbol="gst_bit_reader_peek_bits_uint8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
					<parameter name="val" type="guint8*"/>
					<parameter name="nbits" type="guint"/>
				</parameters>
			</method>
			<method name="set_pos" symbol="gst_bit_reader_set_pos">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
					<parameter name="pos" type="guint"/>
				</parameters>
			</method>
			<method name="skip" symbol="gst_bit_reader_skip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
					<parameter name="nbits" type="guint"/>
				</parameters>
			</method>
			<method name="skip_to_byte" symbol="gst_bit_reader_skip_to_byte">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstBitReader*"/>
				</parameters>
			</method>
			<field name="data" type="guint8*"/>
			<field name="size" type="guint"/>
			<field name="byte" type="guint"/>
			<field name="bit" type="guint"/>
		</struct>
		<struct name="GstByteReader">
			<method name="dup_data" symbol="gst_byte_reader_dup_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="size" type="guint"/>
					<parameter name="val" type="guint8**"/>
				</parameters>
			</method>
			<method name="dup_string_utf16" symbol="gst_byte_reader_dup_string_utf16">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="str" type="guint16**"/>
				</parameters>
			</method>
			<method name="dup_string_utf32" symbol="gst_byte_reader_dup_string_utf32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="str" type="guint32**"/>
				</parameters>
			</method>
			<method name="dup_string_utf8" symbol="gst_byte_reader_dup_string_utf8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="str" type="gchar**"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_byte_reader_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
				</parameters>
			</method>
			<method name="get_data" symbol="gst_byte_reader_get_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="size" type="guint"/>
					<parameter name="val" type="guint8**"/>
				</parameters>
			</method>
			<method name="get_float32_be" symbol="gst_byte_reader_get_float32_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_float32_le" symbol="gst_byte_reader_get_float32_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_float64_be" symbol="gst_byte_reader_get_float64_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_float64_le" symbol="gst_byte_reader_get_float64_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_int16_be" symbol="gst_byte_reader_get_int16_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint16*"/>
				</parameters>
			</method>
			<method name="get_int16_le" symbol="gst_byte_reader_get_int16_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint16*"/>
				</parameters>
			</method>
			<method name="get_int24_be" symbol="gst_byte_reader_get_int24_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint32*"/>
				</parameters>
			</method>
			<method name="get_int24_le" symbol="gst_byte_reader_get_int24_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint32*"/>
				</parameters>
			</method>
			<method name="get_int32_be" symbol="gst_byte_reader_get_int32_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint32*"/>
				</parameters>
			</method>
			<method name="get_int32_le" symbol="gst_byte_reader_get_int32_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint32*"/>
				</parameters>
			</method>
			<method name="get_int64_be" symbol="gst_byte_reader_get_int64_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint64*"/>
				</parameters>
			</method>
			<method name="get_int64_le" symbol="gst_byte_reader_get_int64_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint64*"/>
				</parameters>
			</method>
			<method name="get_int8" symbol="gst_byte_reader_get_int8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint8*"/>
				</parameters>
			</method>
			<method name="get_pos" symbol="gst_byte_reader_get_pos">
				<return-type type="guint"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
				</parameters>
			</method>
			<method name="get_remaining" symbol="gst_byte_reader_get_remaining">
				<return-type type="guint"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gst_byte_reader_get_size">
				<return-type type="guint"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
				</parameters>
			</method>
			<method name="get_string_utf8" symbol="gst_byte_reader_get_string_utf8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="str" type="gchar**"/>
				</parameters>
			</method>
			<method name="get_uint16_be" symbol="gst_byte_reader_get_uint16_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint16*"/>
				</parameters>
			</method>
			<method name="get_uint16_le" symbol="gst_byte_reader_get_uint16_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint16*"/>
				</parameters>
			</method>
			<method name="get_uint24_be" symbol="gst_byte_reader_get_uint24_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint32*"/>
				</parameters>
			</method>
			<method name="get_uint24_le" symbol="gst_byte_reader_get_uint24_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint32*"/>
				</parameters>
			</method>
			<method name="get_uint32_be" symbol="gst_byte_reader_get_uint32_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint32*"/>
				</parameters>
			</method>
			<method name="get_uint32_le" symbol="gst_byte_reader_get_uint32_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint32*"/>
				</parameters>
			</method>
			<method name="get_uint64_be" symbol="gst_byte_reader_get_uint64_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint64*"/>
				</parameters>
			</method>
			<method name="get_uint64_le" symbol="gst_byte_reader_get_uint64_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint64*"/>
				</parameters>
			</method>
			<method name="get_uint8" symbol="gst_byte_reader_get_uint8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint8*"/>
				</parameters>
			</method>
			<method name="init" symbol="gst_byte_reader_init">
				<return-type type="void"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="init_from_buffer" symbol="gst_byte_reader_init_from_buffer">
				<return-type type="void"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="masked_scan_uint32" symbol="gst_byte_reader_masked_scan_uint32">
				<return-type type="guint"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="mask" type="guint32"/>
					<parameter name="pattern" type="guint32"/>
					<parameter name="offset" type="guint"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_byte_reader_new">
				<return-type type="GstByteReader*"/>
				<parameters>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="new_from_buffer" symbol="gst_byte_reader_new_from_buffer">
				<return-type type="GstByteReader*"/>
				<parameters>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</method>
			<method name="peek_data" symbol="gst_byte_reader_peek_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="size" type="guint"/>
					<parameter name="val" type="guint8**"/>
				</parameters>
			</method>
			<method name="peek_float32_be" symbol="gst_byte_reader_peek_float32_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gfloat*"/>
				</parameters>
			</method>
			<method name="peek_float32_le" symbol="gst_byte_reader_peek_float32_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gfloat*"/>
				</parameters>
			</method>
			<method name="peek_float64_be" symbol="gst_byte_reader_peek_float64_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gdouble*"/>
				</parameters>
			</method>
			<method name="peek_float64_le" symbol="gst_byte_reader_peek_float64_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gdouble*"/>
				</parameters>
			</method>
			<method name="peek_int16_be" symbol="gst_byte_reader_peek_int16_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint16*"/>
				</parameters>
			</method>
			<method name="peek_int16_le" symbol="gst_byte_reader_peek_int16_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint16*"/>
				</parameters>
			</method>
			<method name="peek_int24_be" symbol="gst_byte_reader_peek_int24_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint32*"/>
				</parameters>
			</method>
			<method name="peek_int24_le" symbol="gst_byte_reader_peek_int24_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint32*"/>
				</parameters>
			</method>
			<method name="peek_int32_be" symbol="gst_byte_reader_peek_int32_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint32*"/>
				</parameters>
			</method>
			<method name="peek_int32_le" symbol="gst_byte_reader_peek_int32_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint32*"/>
				</parameters>
			</method>
			<method name="peek_int64_be" symbol="gst_byte_reader_peek_int64_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint64*"/>
				</parameters>
			</method>
			<method name="peek_int64_le" symbol="gst_byte_reader_peek_int64_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint64*"/>
				</parameters>
			</method>
			<method name="peek_int8" symbol="gst_byte_reader_peek_int8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="gint8*"/>
				</parameters>
			</method>
			<method name="peek_string_utf8" symbol="gst_byte_reader_peek_string_utf8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="str" type="gchar**"/>
				</parameters>
			</method>
			<method name="peek_uint16_be" symbol="gst_byte_reader_peek_uint16_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint16*"/>
				</parameters>
			</method>
			<method name="peek_uint16_le" symbol="gst_byte_reader_peek_uint16_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint16*"/>
				</parameters>
			</method>
			<method name="peek_uint24_be" symbol="gst_byte_reader_peek_uint24_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint32*"/>
				</parameters>
			</method>
			<method name="peek_uint24_le" symbol="gst_byte_reader_peek_uint24_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint32*"/>
				</parameters>
			</method>
			<method name="peek_uint32_be" symbol="gst_byte_reader_peek_uint32_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint32*"/>
				</parameters>
			</method>
			<method name="peek_uint32_le" symbol="gst_byte_reader_peek_uint32_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint32*"/>
				</parameters>
			</method>
			<method name="peek_uint64_be" symbol="gst_byte_reader_peek_uint64_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint64*"/>
				</parameters>
			</method>
			<method name="peek_uint64_le" symbol="gst_byte_reader_peek_uint64_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint64*"/>
				</parameters>
			</method>
			<method name="peek_uint8" symbol="gst_byte_reader_peek_uint8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="val" type="guint8*"/>
				</parameters>
			</method>
			<method name="set_pos" symbol="gst_byte_reader_set_pos">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="pos" type="guint"/>
				</parameters>
			</method>
			<method name="skip" symbol="gst_byte_reader_skip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
					<parameter name="nbytes" type="guint"/>
				</parameters>
			</method>
			<method name="skip_string_utf16" symbol="gst_byte_reader_skip_string_utf16">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
				</parameters>
			</method>
			<method name="skip_string_utf32" symbol="gst_byte_reader_skip_string_utf32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
				</parameters>
			</method>
			<method name="skip_string_utf8" symbol="gst_byte_reader_skip_string_utf8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reader" type="GstByteReader*"/>
				</parameters>
			</method>
			<field name="data" type="guint8*"/>
			<field name="size" type="guint"/>
			<field name="byte" type="guint"/>
		</struct>
		<struct name="GstByteWriter">
			<method name="ensure_free_space" symbol="gst_byte_writer_ensure_free_space">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="fill" symbol="gst_byte_writer_fill">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="value" type="guint8"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="free" symbol="gst_byte_writer_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
				</parameters>
			</method>
			<method name="free_and_get_buffer" symbol="gst_byte_writer_free_and_get_buffer">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
				</parameters>
			</method>
			<method name="free_and_get_data" symbol="gst_byte_writer_free_and_get_data">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
				</parameters>
			</method>
			<method name="get_remaining" symbol="gst_byte_writer_get_remaining">
				<return-type type="guint"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
				</parameters>
			</method>
			<method name="init" symbol="gst_byte_writer_init">
				<return-type type="void"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
				</parameters>
			</method>
			<method name="init_with_buffer" symbol="gst_byte_writer_init_with_buffer">
				<return-type type="void"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="buffer" type="GstBuffer*"/>
					<parameter name="initialized" type="gboolean"/>
				</parameters>
			</method>
			<method name="init_with_data" symbol="gst_byte_writer_init_with_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
					<parameter name="initialized" type="gboolean"/>
				</parameters>
			</method>
			<method name="init_with_size" symbol="gst_byte_writer_init_with_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="size" type="guint"/>
					<parameter name="fixed" type="gboolean"/>
				</parameters>
			</method>
			<method name="new" symbol="gst_byte_writer_new">
				<return-type type="GstByteWriter*"/>
			</method>
			<method name="new_with_buffer" symbol="gst_byte_writer_new_with_buffer">
				<return-type type="GstByteWriter*"/>
				<parameters>
					<parameter name="buffer" type="GstBuffer*"/>
					<parameter name="initialized" type="gboolean"/>
				</parameters>
			</method>
			<method name="new_with_data" symbol="gst_byte_writer_new_with_data">
				<return-type type="GstByteWriter*"/>
				<parameters>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
					<parameter name="initialized" type="gboolean"/>
				</parameters>
			</method>
			<method name="new_with_size" symbol="gst_byte_writer_new_with_size">
				<return-type type="GstByteWriter*"/>
				<parameters>
					<parameter name="size" type="guint"/>
					<parameter name="fixed" type="gboolean"/>
				</parameters>
			</method>
			<method name="put_data" symbol="gst_byte_writer_put_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="put_float32_be" symbol="gst_byte_writer_put_float32_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gfloat"/>
				</parameters>
			</method>
			<method name="put_float32_le" symbol="gst_byte_writer_put_float32_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gfloat"/>
				</parameters>
			</method>
			<method name="put_float64_be" symbol="gst_byte_writer_put_float64_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gdouble"/>
				</parameters>
			</method>
			<method name="put_float64_le" symbol="gst_byte_writer_put_float64_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gdouble"/>
				</parameters>
			</method>
			<method name="put_int16_be" symbol="gst_byte_writer_put_int16_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gint16"/>
				</parameters>
			</method>
			<method name="put_int16_le" symbol="gst_byte_writer_put_int16_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gint16"/>
				</parameters>
			</method>
			<method name="put_int24_be" symbol="gst_byte_writer_put_int24_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gint32"/>
				</parameters>
			</method>
			<method name="put_int24_le" symbol="gst_byte_writer_put_int24_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gint32"/>
				</parameters>
			</method>
			<method name="put_int32_be" symbol="gst_byte_writer_put_int32_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gint32"/>
				</parameters>
			</method>
			<method name="put_int32_le" symbol="gst_byte_writer_put_int32_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gint32"/>
				</parameters>
			</method>
			<method name="put_int64_be" symbol="gst_byte_writer_put_int64_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gint64"/>
				</parameters>
			</method>
			<method name="put_int64_le" symbol="gst_byte_writer_put_int64_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gint64"/>
				</parameters>
			</method>
			<method name="put_int8" symbol="gst_byte_writer_put_int8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="gint8"/>
				</parameters>
			</method>
			<method name="put_string_utf16" symbol="gst_byte_writer_put_string_utf16">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="data" type="guint16*"/>
				</parameters>
			</method>
			<method name="put_string_utf32" symbol="gst_byte_writer_put_string_utf32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="data" type="guint32*"/>
				</parameters>
			</method>
			<method name="put_string_utf8" symbol="gst_byte_writer_put_string_utf8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="data" type="gchar*"/>
				</parameters>
			</method>
			<method name="put_uint16_be" symbol="gst_byte_writer_put_uint16_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="guint16"/>
				</parameters>
			</method>
			<method name="put_uint16_le" symbol="gst_byte_writer_put_uint16_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="guint16"/>
				</parameters>
			</method>
			<method name="put_uint24_be" symbol="gst_byte_writer_put_uint24_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="guint32"/>
				</parameters>
			</method>
			<method name="put_uint24_le" symbol="gst_byte_writer_put_uint24_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="guint32"/>
				</parameters>
			</method>
			<method name="put_uint32_be" symbol="gst_byte_writer_put_uint32_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="guint32"/>
				</parameters>
			</method>
			<method name="put_uint32_le" symbol="gst_byte_writer_put_uint32_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="guint32"/>
				</parameters>
			</method>
			<method name="put_uint64_be" symbol="gst_byte_writer_put_uint64_be">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="guint64"/>
				</parameters>
			</method>
			<method name="put_uint64_le" symbol="gst_byte_writer_put_uint64_le">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="guint64"/>
				</parameters>
			</method>
			<method name="put_uint8" symbol="gst_byte_writer_put_uint8">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
					<parameter name="val" type="guint8"/>
				</parameters>
			</method>
			<method name="reset" symbol="gst_byte_writer_reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
				</parameters>
			</method>
			<method name="reset_and_get_buffer" symbol="gst_byte_writer_reset_and_get_buffer">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
				</parameters>
			</method>
			<method name="reset_and_get_data" symbol="gst_byte_writer_reset_and_get_data">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="writer" type="GstByteWriter*"/>
				</parameters>
			</method>
			<field name="parent" type="GstByteReader"/>
			<field name="alloc_size" type="guint"/>
			<field name="fixed" type="gboolean"/>
			<field name="owned" type="gboolean"/>
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
		<boxed name="GstBaseParseFrame" type-name="GstBaseParseFrame" get-type="gst_base_parse_frame_get_type">
			<method name="free" symbol="gst_base_parse_frame_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="GstBaseParseFrame*"/>
				</parameters>
			</method>
			<method name="init" symbol="gst_base_parse_frame_init">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="GstBaseParseFrame*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gst_base_parse_frame_new">
				<return-type type="GstBaseParseFrame*"/>
				<parameters>
					<parameter name="buffer" type="GstBuffer*"/>
					<parameter name="flags" type="GstBaseParseFrameFlags"/>
					<parameter name="overhead" type="gint"/>
				</parameters>
			</constructor>
			<field name="buffer" type="GstBuffer*"/>
			<field name="flags" type="guint"/>
			<field name="overhead" type="gint"/>
			<field name="_gst_reserved_i" type="guint[]"/>
			<field name="_gst_reserved_p" type="gpointer[]"/>
			<field name="_private_flags" type="guint"/>
		</boxed>
		<enum name="GstBaseParseFrameFlags">
			<member name="GST_BASE_PARSE_FRAME_FLAG_NONE" value="0"/>
			<member name="GST_BASE_PARSE_FRAME_FLAG_NO_FRAME" value="1"/>
			<member name="GST_BASE_PARSE_FRAME_FLAG_CLIP" value="2"/>
		</enum>
		<enum name="GstBaseSrcFlags">
			<member name="GST_BASE_SRC_STARTED" value="1048576"/>
			<member name="GST_BASE_SRC_FLAG_LAST" value="4194304"/>
		</enum>
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
			<method name="masked_scan_uint32" symbol="gst_adapter_masked_scan_uint32">
				<return-type type="guint"/>
				<parameters>
					<parameter name="adapter" type="GstAdapter*"/>
					<parameter name="mask" type="guint32"/>
					<parameter name="pattern" type="guint32"/>
					<parameter name="offset" type="guint"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</method>
			<method name="masked_scan_uint32_peek" symbol="gst_adapter_masked_scan_uint32_peek">
				<return-type type="guint"/>
				<parameters>
					<parameter name="adapter" type="GstAdapter*"/>
					<parameter name="mask" type="guint32"/>
					<parameter name="pattern" type="guint32"/>
					<parameter name="offset" type="guint"/>
					<parameter name="size" type="guint"/>
					<parameter name="value" type="guint32*"/>
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
			<method name="prev_timestamp" symbol="gst_adapter_prev_timestamp">
				<return-type type="GstClockTime"/>
				<parameters>
					<parameter name="adapter" type="GstAdapter*"/>
					<parameter name="distance" type="guint64*"/>
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
			<method name="take_list" symbol="gst_adapter_take_list">
				<return-type type="GList*"/>
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
		<object name="GstBaseParse" parent="GstElement" type-name="GstBaseParse" get-type="gst_base_parse_get_type">
			<method name="add_index_entry" symbol="gst_base_parse_add_index_entry">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="offset" type="guint64"/>
					<parameter name="ts" type="GstClockTime"/>
					<parameter name="key" type="gboolean"/>
					<parameter name="force" type="gboolean"/>
				</parameters>
			</method>
			<method name="convert_default" symbol="gst_base_parse_convert_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="src_format" type="GstFormat"/>
					<parameter name="src_value" type="gint64"/>
					<parameter name="dest_format" type="GstFormat"/>
					<parameter name="dest_value" type="gint64*"/>
				</parameters>
			</method>
			<method name="push_frame" symbol="gst_base_parse_push_frame">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="frame" type="GstBaseParseFrame*"/>
				</parameters>
			</method>
			<method name="set_average_bitrate" symbol="gst_base_parse_set_average_bitrate">
				<return-type type="void"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="bitrate" type="guint"/>
				</parameters>
			</method>
			<method name="set_duration" symbol="gst_base_parse_set_duration">
				<return-type type="void"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="fmt" type="GstFormat"/>
					<parameter name="duration" type="gint64"/>
					<parameter name="interval" type="gint"/>
				</parameters>
			</method>
			<method name="set_frame_rate" symbol="gst_base_parse_set_frame_rate">
				<return-type type="void"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="fps_num" type="guint"/>
					<parameter name="fps_den" type="guint"/>
					<parameter name="lead_in" type="guint"/>
					<parameter name="lead_out" type="guint"/>
				</parameters>
			</method>
			<method name="set_has_timing_info" symbol="gst_base_parse_set_has_timing_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="has_timing" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_latency" symbol="gst_base_parse_set_latency">
				<return-type type="void"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="min_latency" type="GstClockTime"/>
					<parameter name="max_latency" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="set_min_frame_size" symbol="gst_base_parse_set_min_frame_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="min_size" type="guint"/>
				</parameters>
			</method>
			<method name="set_passthrough" symbol="gst_base_parse_set_passthrough">
				<return-type type="void"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="passthrough" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_syncable" symbol="gst_base_parse_set_syncable">
				<return-type type="void"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="syncable" type="gboolean"/>
				</parameters>
			</method>
			<vfunc name="check_valid_frame">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="frame" type="GstBaseParseFrame*"/>
					<parameter name="framesize" type="guint*"/>
					<parameter name="skipsize" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="convert">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="src_format" type="GstFormat"/>
					<parameter name="src_value" type="gint64"/>
					<parameter name="dest_format" type="GstFormat"/>
					<parameter name="dest_value" type="gint64*"/>
				</parameters>
			</vfunc>
			<vfunc name="event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</vfunc>
			<vfunc name="parse_frame">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="frame" type="GstBaseParseFrame*"/>
				</parameters>
			</vfunc>
			<vfunc name="pre_push_frame">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="frame" type="GstBaseParseFrame*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_sink_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</vfunc>
			<vfunc name="src_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</vfunc>
			<vfunc name="start">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
				</parameters>
			</vfunc>
			<vfunc name="stop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parse" type="GstBaseParse*"/>
				</parameters>
			</vfunc>
			<field name="sinkpad" type="GstPad*"/>
			<field name="srcpad" type="GstPad*"/>
			<field name="flags" type="guint"/>
			<field name="segment" type="GstSegment"/>
		</object>
		<object name="GstBaseSink" parent="GstElement" type-name="GstBaseSink" get-type="gst_base_sink_get_type">
			<method name="do_preroll" symbol="gst_base_sink_do_preroll">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="obj" type="GstMiniObject*"/>
				</parameters>
			</method>
			<method name="get_blocksize" symbol="gst_base_sink_get_blocksize">
				<return-type type="guint"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
				</parameters>
			</method>
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
			<method name="get_render_delay" symbol="gst_base_sink_get_render_delay">
				<return-type type="GstClockTime"/>
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
			<method name="get_throttle_time" symbol="gst_base_sink_get_throttle_time">
				<return-type type="guint64"/>
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
			<method name="is_last_buffer_enabled" symbol="gst_base_sink_is_last_buffer_enabled">
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
			<method name="set_blocksize" symbol="gst_base_sink_set_blocksize">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="blocksize" type="guint"/>
				</parameters>
			</method>
			<method name="set_last_buffer_enabled" symbol="gst_base_sink_set_last_buffer_enabled">
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
			<method name="set_render_delay" symbol="gst_base_sink_set_render_delay">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="delay" type="GstClockTime"/>
				</parameters>
			</method>
			<method name="set_sync" symbol="gst_base_sink_set_sync">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="sync" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_throttle_time" symbol="gst_base_sink_set_throttle_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="throttle" type="guint64"/>
				</parameters>
			</method>
			<method name="set_ts_offset" symbol="gst_base_sink_set_ts_offset">
				<return-type type="void"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="offset" type="GstClockTimeDiff"/>
				</parameters>
			</method>
			<method name="wait_clock" symbol="gst_base_sink_wait_clock">
				<return-type type="GstClockReturn"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="time" type="GstClockTime"/>
					<parameter name="jitter" type="GstClockTimeDiff*"/>
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
			<property name="blocksize" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="enable-last-buffer" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="last-buffer" type="GstBuffer" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="max-lateness" type="gint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="preroll-queue-len" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="qos" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="render-delay" type="guint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sync" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="throttle-time" type="guint64" readable="1" writable="1" construct="0" construct-only="0"/>
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
			<vfunc name="render_list">
				<return-type type="GstFlowReturn"/>
				<parameters>
					<parameter name="sink" type="GstBaseSink*"/>
					<parameter name="buffer_list" type="GstBufferList*"/>
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
			<method name="get_blocksize" symbol="gst_base_src_get_blocksize">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
				</parameters>
			</method>
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
			<constructor name="new_seamless_segment" symbol="gst_base_src_new_seamless_segment">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="start" type="gint64"/>
					<parameter name="stop" type="gint64"/>
					<parameter name="position" type="gint64"/>
				</parameters>
			</constructor>
			<method name="query_latency" symbol="gst_base_src_query_latency">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="live" type="gboolean*"/>
					<parameter name="min_latency" type="GstClockTime*"/>
					<parameter name="max_latency" type="GstClockTime*"/>
				</parameters>
			</method>
			<method name="set_blocksize" symbol="gst_base_src_set_blocksize">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="blocksize" type="gulong"/>
				</parameters>
			</method>
			<method name="set_do_timestamp" symbol="gst_base_src_set_do_timestamp">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="timestamp" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_dynamic_size" symbol="gst_base_src_set_dynamic_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GstBaseSrc*"/>
					<parameter name="dynamic" type="gboolean"/>
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
			<method name="reconfigure" symbol="gst_base_transform_reconfigure">
				<return-type type="void"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
				</parameters>
			</method>
			<method name="set_gap_aware" symbol="gst_base_transform_set_gap_aware">
				<return-type type="void"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="gap_aware" type="gboolean"/>
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
			<method name="suggest" symbol="gst_base_transform_suggest">
				<return-type type="void"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="caps" type="GstCaps*"/>
					<parameter name="size" type="guint"/>
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
			<vfunc name="accept_caps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="direction" type="GstPadDirection"/>
					<parameter name="caps" type="GstCaps*"/>
				</parameters>
			</vfunc>
			<vfunc name="before_transform">
				<return-type type="void"/>
				<parameters>
					<parameter name="trans" type="GstBaseTransform*"/>
					<parameter name="buffer" type="GstBuffer*"/>
				</parameters>
			</vfunc>
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
			<method name="read_buffer" symbol="gst_collect_pads_read_buffer">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="data" type="GstCollectData*"/>
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
			<method name="set_clip_function" symbol="gst_collect_pads_set_clip_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="clipfunc" type="GstCollectPadsClipFunction"/>
					<parameter name="user_data" type="gpointer"/>
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
			<method name="take_buffer" symbol="gst_collect_pads_take_buffer">
				<return-type type="GstBuffer*"/>
				<parameters>
					<parameter name="pads" type="GstCollectPads*"/>
					<parameter name="data" type="GstCollectData*"/>
					<parameter name="size" type="guint"/>
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
			<constructor name="new_full" symbol="gst_data_queue_new_full">
				<return-type type="GstDataQueue*"/>
				<parameters>
					<parameter name="checkfull" type="GstDataQueueCheckFullFunction"/>
					<parameter name="fullcallback" type="GstDataQueueFullCallback"/>
					<parameter name="emptycallback" type="GstDataQueueEmptyCallback"/>
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
			<field name="fullcallback" type="GstDataQueueFullCallback"/>
			<field name="emptycallback" type="GstDataQueueEmptyCallback"/>
			<field name="abidata" type="gpointer"/>
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
		<constant name="GST_BASE_PARSE_FLAG_DRAINING" type="int" value="2"/>
		<constant name="GST_BASE_PARSE_FLAG_LOST_SYNC" type="int" value="1"/>
		<constant name="GST_BASE_TRANSFORM_SINK_NAME" type="char*" value="sink"/>
		<constant name="GST_BASE_TRANSFORM_SRC_NAME" type="char*" value="src"/>
	</namespace>
</api>
