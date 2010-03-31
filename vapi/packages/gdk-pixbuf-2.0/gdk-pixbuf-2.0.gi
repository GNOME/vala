<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gdk">
		<callback name="GdkPixbufDestroyNotify">
			<return-type type="void"/>
			<parameters>
				<parameter name="pixels" type="guchar*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GdkPixbufSaveFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buf" type="gchar*"/>
				<parameter name="count" type="gsize"/>
				<parameter name="error" type="GError**"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GdkPixbufFormat">
			<method name="get_description" symbol="gdk_pixbuf_format_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="format" type="GdkPixbufFormat*"/>
				</parameters>
			</method>
			<method name="get_extensions" symbol="gdk_pixbuf_format_get_extensions">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="format" type="GdkPixbufFormat*"/>
				</parameters>
			</method>
			<method name="get_license" symbol="gdk_pixbuf_format_get_license">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="format" type="GdkPixbufFormat*"/>
				</parameters>
			</method>
			<method name="get_mime_types" symbol="gdk_pixbuf_format_get_mime_types">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="format" type="GdkPixbufFormat*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdk_pixbuf_format_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="format" type="GdkPixbufFormat*"/>
				</parameters>
			</method>
			<method name="is_disabled" symbol="gdk_pixbuf_format_is_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="format" type="GdkPixbufFormat*"/>
				</parameters>
			</method>
			<method name="is_scalable" symbol="gdk_pixbuf_format_is_scalable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="format" type="GdkPixbufFormat*"/>
				</parameters>
			</method>
			<method name="is_writable" symbol="gdk_pixbuf_format_is_writable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="format" type="GdkPixbufFormat*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="gdk_pixbuf_format_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="format" type="GdkPixbufFormat*"/>
					<parameter name="disabled" type="gboolean"/>
				</parameters>
			</method>
		</struct>
		<struct name="GdkPixbufSimpleAnimClass">
		</struct>
		<struct name="GdkPixdata">
			<method name="deserialize" symbol="gdk_pixdata_deserialize">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pixdata" type="GdkPixdata*"/>
					<parameter name="stream_length" type="guint"/>
					<parameter name="stream" type="guint8*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="from_pixbuf" symbol="gdk_pixdata_from_pixbuf">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="pixdata" type="GdkPixdata*"/>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="use_rle" type="gboolean"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gdk_pixdata_serialize">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="pixdata" type="GdkPixdata*"/>
					<parameter name="stream_length_p" type="guint*"/>
				</parameters>
			</method>
			<method name="to_csource" symbol="gdk_pixdata_to_csource">
				<return-type type="GString*"/>
				<parameters>
					<parameter name="pixdata" type="GdkPixdata*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="dump_type" type="GdkPixdataDumpType"/>
				</parameters>
			</method>
			<field name="magic" type="guint32"/>
			<field name="length" type="gint32"/>
			<field name="pixdata_type" type="guint32"/>
			<field name="rowstride" type="guint32"/>
			<field name="width" type="guint32"/>
			<field name="height" type="guint32"/>
			<field name="pixel_data" type="guint8*"/>
		</struct>
		<enum name="GdkColorspace" type-name="GdkColorspace" get-type="gdk_colorspace_get_type">
			<member name="GDK_COLORSPACE_RGB" value="0"/>
		</enum>
		<enum name="GdkInterpType" type-name="GdkInterpType" get-type="gdk_interp_type_get_type">
			<member name="GDK_INTERP_NEAREST" value="0"/>
			<member name="GDK_INTERP_TILES" value="1"/>
			<member name="GDK_INTERP_BILINEAR" value="2"/>
			<member name="GDK_INTERP_HYPER" value="3"/>
		</enum>
		<enum name="GdkPixbufAlphaMode" type-name="GdkPixbufAlphaMode" get-type="gdk_pixbuf_alpha_mode_get_type">
			<member name="GDK_PIXBUF_ALPHA_BILEVEL" value="0"/>
			<member name="GDK_PIXBUF_ALPHA_FULL" value="1"/>
		</enum>
		<enum name="GdkPixbufError" type-name="GdkPixbufError" get-type="gdk_pixbuf_error_get_type">
			<member name="GDK_PIXBUF_ERROR_CORRUPT_IMAGE" value="0"/>
			<member name="GDK_PIXBUF_ERROR_INSUFFICIENT_MEMORY" value="1"/>
			<member name="GDK_PIXBUF_ERROR_BAD_OPTION" value="2"/>
			<member name="GDK_PIXBUF_ERROR_UNKNOWN_TYPE" value="3"/>
			<member name="GDK_PIXBUF_ERROR_UNSUPPORTED_OPERATION" value="4"/>
			<member name="GDK_PIXBUF_ERROR_FAILED" value="5"/>
		</enum>
		<enum name="GdkPixbufRotation" type-name="GdkPixbufRotation" get-type="gdk_pixbuf_rotation_get_type">
			<member name="GDK_PIXBUF_ROTATE_NONE" value="0"/>
			<member name="GDK_PIXBUF_ROTATE_COUNTERCLOCKWISE" value="90"/>
			<member name="GDK_PIXBUF_ROTATE_UPSIDEDOWN" value="180"/>
			<member name="GDK_PIXBUF_ROTATE_CLOCKWISE" value="270"/>
		</enum>
		<enum name="GdkPixdataDumpType">
			<member name="GDK_PIXDATA_DUMP_PIXDATA_STREAM" value="0"/>
			<member name="GDK_PIXDATA_DUMP_PIXDATA_STRUCT" value="1"/>
			<member name="GDK_PIXDATA_DUMP_MACROS" value="2"/>
			<member name="GDK_PIXDATA_DUMP_GTYPES" value="0"/>
			<member name="GDK_PIXDATA_DUMP_CTYPES" value="256"/>
			<member name="GDK_PIXDATA_DUMP_STATIC" value="512"/>
			<member name="GDK_PIXDATA_DUMP_CONST" value="1024"/>
			<member name="GDK_PIXDATA_DUMP_RLE_DECODER" value="65536"/>
		</enum>
		<enum name="GdkPixdataType">
			<member name="GDK_PIXDATA_COLOR_TYPE_RGB" value="1"/>
			<member name="GDK_PIXDATA_COLOR_TYPE_RGBA" value="2"/>
			<member name="GDK_PIXDATA_COLOR_TYPE_MASK" value="255"/>
			<member name="GDK_PIXDATA_SAMPLE_WIDTH_8" value="65536"/>
			<member name="GDK_PIXDATA_SAMPLE_WIDTH_MASK" value="983040"/>
			<member name="GDK_PIXDATA_ENCODING_RAW" value="16777216"/>
			<member name="GDK_PIXDATA_ENCODING_RLE" value="33554432"/>
			<member name="GDK_PIXDATA_ENCODING_MASK" value="251658240"/>
		</enum>
		<object name="GdkPixbuf" parent="GObject" type-name="GdkPixbuf" get-type="gdk_pixbuf_get_type">
			<method name="add_alpha" symbol="gdk_pixbuf_add_alpha">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="substitute_color" type="gboolean"/>
					<parameter name="r" type="guchar"/>
					<parameter name="g" type="guchar"/>
					<parameter name="b" type="guchar"/>
				</parameters>
			</method>
			<method name="apply_embedded_orientation" symbol="gdk_pixbuf_apply_embedded_orientation">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="src" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="composite" symbol="gdk_pixbuf_composite">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GdkPixbuf*"/>
					<parameter name="dest" type="GdkPixbuf*"/>
					<parameter name="dest_x" type="int"/>
					<parameter name="dest_y" type="int"/>
					<parameter name="dest_width" type="int"/>
					<parameter name="dest_height" type="int"/>
					<parameter name="offset_x" type="double"/>
					<parameter name="offset_y" type="double"/>
					<parameter name="scale_x" type="double"/>
					<parameter name="scale_y" type="double"/>
					<parameter name="interp_type" type="GdkInterpType"/>
					<parameter name="overall_alpha" type="int"/>
				</parameters>
			</method>
			<method name="composite_color" symbol="gdk_pixbuf_composite_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GdkPixbuf*"/>
					<parameter name="dest" type="GdkPixbuf*"/>
					<parameter name="dest_x" type="int"/>
					<parameter name="dest_y" type="int"/>
					<parameter name="dest_width" type="int"/>
					<parameter name="dest_height" type="int"/>
					<parameter name="offset_x" type="double"/>
					<parameter name="offset_y" type="double"/>
					<parameter name="scale_x" type="double"/>
					<parameter name="scale_y" type="double"/>
					<parameter name="interp_type" type="GdkInterpType"/>
					<parameter name="overall_alpha" type="int"/>
					<parameter name="check_x" type="int"/>
					<parameter name="check_y" type="int"/>
					<parameter name="check_size" type="int"/>
					<parameter name="color1" type="guint32"/>
					<parameter name="color2" type="guint32"/>
				</parameters>
			</method>
			<method name="composite_color_simple" symbol="gdk_pixbuf_composite_color_simple">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="src" type="GdkPixbuf*"/>
					<parameter name="dest_width" type="int"/>
					<parameter name="dest_height" type="int"/>
					<parameter name="interp_type" type="GdkInterpType"/>
					<parameter name="overall_alpha" type="int"/>
					<parameter name="check_size" type="int"/>
					<parameter name="color1" type="guint32"/>
					<parameter name="color2" type="guint32"/>
				</parameters>
			</method>
			<method name="copy" symbol="gdk_pixbuf_copy">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="copy_area" symbol="gdk_pixbuf_copy_area">
				<return-type type="void"/>
				<parameters>
					<parameter name="src_pixbuf" type="GdkPixbuf*"/>
					<parameter name="src_x" type="int"/>
					<parameter name="src_y" type="int"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
					<parameter name="dest_pixbuf" type="GdkPixbuf*"/>
					<parameter name="dest_x" type="int"/>
					<parameter name="dest_y" type="int"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gdk_pixbuf_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="fill" symbol="gdk_pixbuf_fill">
				<return-type type="void"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="pixel" type="guint32"/>
				</parameters>
			</method>
			<method name="flip" symbol="gdk_pixbuf_flip">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="src" type="GdkPixbuf*"/>
					<parameter name="horizontal" type="gboolean"/>
				</parameters>
			</method>
			<method name="from_pixdata" symbol="gdk_pixbuf_from_pixdata">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="pixdata" type="GdkPixdata*"/>
					<parameter name="copy_pixels" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_bits_per_sample" symbol="gdk_pixbuf_get_bits_per_sample">
				<return-type type="int"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="get_colorspace" symbol="gdk_pixbuf_get_colorspace">
				<return-type type="GdkColorspace"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="get_file_info" symbol="gdk_pixbuf_get_file_info">
				<return-type type="GdkPixbufFormat*"/>
				<parameters>
					<parameter name="filename" type="gchar*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
				</parameters>
			</method>
			<method name="get_formats" symbol="gdk_pixbuf_get_formats">
				<return-type type="GSList*"/>
			</method>
			<method name="get_has_alpha" symbol="gdk_pixbuf_get_has_alpha">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="gdk_pixbuf_get_height">
				<return-type type="int"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="get_n_channels" symbol="gdk_pixbuf_get_n_channels">
				<return-type type="int"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="get_option" symbol="gdk_pixbuf_get_option">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_pixels" symbol="gdk_pixbuf_get_pixels">
				<return-type type="guchar*"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="get_rowstride" symbol="gdk_pixbuf_get_rowstride">
				<return-type type="int"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="gdk_pixbuf_get_width">
				<return-type type="int"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdk_pixbuf_new">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="colorspace" type="GdkColorspace"/>
					<parameter name="has_alpha" type="gboolean"/>
					<parameter name="bits_per_sample" type="int"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</constructor>
			<constructor name="new_from_data" symbol="gdk_pixbuf_new_from_data">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="data" type="guchar*"/>
					<parameter name="colorspace" type="GdkColorspace"/>
					<parameter name="has_alpha" type="gboolean"/>
					<parameter name="bits_per_sample" type="int"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
					<parameter name="rowstride" type="int"/>
					<parameter name="destroy_fn" type="GdkPixbufDestroyNotify"/>
					<parameter name="destroy_fn_data" type="gpointer"/>
				</parameters>
			</constructor>
			<constructor name="new_from_file" symbol="gdk_pixbuf_new_from_file">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_file_at_scale" symbol="gdk_pixbuf_new_from_file_at_scale">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
					<parameter name="preserve_aspect_ratio" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_file_at_size" symbol="gdk_pixbuf_new_from_file_at_size">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_inline" symbol="gdk_pixbuf_new_from_inline">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="data_length" type="gint"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="copy_pixels" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_stream" symbol="gdk_pixbuf_new_from_stream">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_stream_at_scale" symbol="gdk_pixbuf_new_from_stream_at_scale">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="preserve_aspect_ratio" type="gboolean"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_xpm_data" symbol="gdk_pixbuf_new_from_xpm_data">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="data" type="char**"/>
				</parameters>
			</constructor>
			<constructor name="new_subpixbuf" symbol="gdk_pixbuf_new_subpixbuf">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="src_pixbuf" type="GdkPixbuf*"/>
					<parameter name="src_x" type="int"/>
					<parameter name="src_y" type="int"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</constructor>
			<method name="rotate_simple" symbol="gdk_pixbuf_rotate_simple">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="src" type="GdkPixbuf*"/>
					<parameter name="angle" type="GdkPixbufRotation"/>
				</parameters>
			</method>
			<method name="saturate_and_pixelate" symbol="gdk_pixbuf_saturate_and_pixelate">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GdkPixbuf*"/>
					<parameter name="dest" type="GdkPixbuf*"/>
					<parameter name="saturation" type="gfloat"/>
					<parameter name="pixelate" type="gboolean"/>
				</parameters>
			</method>
			<method name="save" symbol="gdk_pixbuf_save">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="filename" type="char*"/>
					<parameter name="type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="save_to_buffer" symbol="gdk_pixbuf_save_to_buffer">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="buffer" type="gchar**"/>
					<parameter name="buffer_size" type="gsize*"/>
					<parameter name="type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="save_to_bufferv" symbol="gdk_pixbuf_save_to_bufferv">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="buffer" type="gchar**"/>
					<parameter name="buffer_size" type="gsize*"/>
					<parameter name="type" type="char*"/>
					<parameter name="option_keys" type="char**"/>
					<parameter name="option_values" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="save_to_callback" symbol="gdk_pixbuf_save_to_callback">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="save_func" type="GdkPixbufSaveFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="save_to_callbackv" symbol="gdk_pixbuf_save_to_callbackv">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="save_func" type="GdkPixbufSaveFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="type" type="char*"/>
					<parameter name="option_keys" type="char**"/>
					<parameter name="option_values" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="save_to_stream" symbol="gdk_pixbuf_save_to_stream">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="type" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="savev" symbol="gdk_pixbuf_savev">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="filename" type="char*"/>
					<parameter name="type" type="char*"/>
					<parameter name="option_keys" type="char**"/>
					<parameter name="option_values" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="scale" symbol="gdk_pixbuf_scale">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GdkPixbuf*"/>
					<parameter name="dest" type="GdkPixbuf*"/>
					<parameter name="dest_x" type="int"/>
					<parameter name="dest_y" type="int"/>
					<parameter name="dest_width" type="int"/>
					<parameter name="dest_height" type="int"/>
					<parameter name="offset_x" type="double"/>
					<parameter name="offset_y" type="double"/>
					<parameter name="scale_x" type="double"/>
					<parameter name="scale_y" type="double"/>
					<parameter name="interp_type" type="GdkInterpType"/>
				</parameters>
			</method>
			<method name="scale_simple" symbol="gdk_pixbuf_scale_simple">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="src" type="GdkPixbuf*"/>
					<parameter name="dest_width" type="int"/>
					<parameter name="dest_height" type="int"/>
					<parameter name="interp_type" type="GdkInterpType"/>
				</parameters>
			</method>
			<property name="bits-per-sample" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="colorspace" type="GdkColorspace" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="has-alpha" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="height" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="n-channels" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="pixels" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="rowstride" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="width" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdkPixbufAnimation" parent="GObject" type-name="GdkPixbufAnimation" get-type="gdk_pixbuf_animation_get_type">
			<method name="get_height" symbol="gdk_pixbuf_animation_get_height">
				<return-type type="int"/>
				<parameters>
					<parameter name="animation" type="GdkPixbufAnimation*"/>
				</parameters>
			</method>
			<method name="get_iter" symbol="gdk_pixbuf_animation_get_iter">
				<return-type type="GdkPixbufAnimationIter*"/>
				<parameters>
					<parameter name="animation" type="GdkPixbufAnimation*"/>
					<parameter name="start_time" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_static_image" symbol="gdk_pixbuf_animation_get_static_image">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="animation" type="GdkPixbufAnimation*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="gdk_pixbuf_animation_get_width">
				<return-type type="int"/>
				<parameters>
					<parameter name="animation" type="GdkPixbufAnimation*"/>
				</parameters>
			</method>
			<method name="is_static_image" symbol="gdk_pixbuf_animation_is_static_image">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="animation" type="GdkPixbufAnimation*"/>
				</parameters>
			</method>
			<constructor name="new_from_file" symbol="gdk_pixbuf_animation_new_from_file">
				<return-type type="GdkPixbufAnimation*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
		</object>
		<object name="GdkPixbufAnimationIter" parent="GObject" type-name="GdkPixbufAnimationIter" get-type="gdk_pixbuf_animation_iter_get_type">
			<method name="advance" symbol="gdk_pixbuf_animation_iter_advance">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="GdkPixbufAnimationIter*"/>
					<parameter name="current_time" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_delay_time" symbol="gdk_pixbuf_animation_iter_get_delay_time">
				<return-type type="int"/>
				<parameters>
					<parameter name="iter" type="GdkPixbufAnimationIter*"/>
				</parameters>
			</method>
			<method name="get_pixbuf" symbol="gdk_pixbuf_animation_iter_get_pixbuf">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="iter" type="GdkPixbufAnimationIter*"/>
				</parameters>
			</method>
			<method name="on_currently_loading_frame" symbol="gdk_pixbuf_animation_iter_on_currently_loading_frame">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="GdkPixbufAnimationIter*"/>
				</parameters>
			</method>
		</object>
		<object name="GdkPixbufLoader" parent="GObject" type-name="GdkPixbufLoader" get-type="gdk_pixbuf_loader_get_type">
			<method name="close" symbol="gdk_pixbuf_loader_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="loader" type="GdkPixbufLoader*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_animation" symbol="gdk_pixbuf_loader_get_animation">
				<return-type type="GdkPixbufAnimation*"/>
				<parameters>
					<parameter name="loader" type="GdkPixbufLoader*"/>
				</parameters>
			</method>
			<method name="get_format" symbol="gdk_pixbuf_loader_get_format">
				<return-type type="GdkPixbufFormat*"/>
				<parameters>
					<parameter name="loader" type="GdkPixbufLoader*"/>
				</parameters>
			</method>
			<method name="get_pixbuf" symbol="gdk_pixbuf_loader_get_pixbuf">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="loader" type="GdkPixbufLoader*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdk_pixbuf_loader_new">
				<return-type type="GdkPixbufLoader*"/>
			</constructor>
			<constructor name="new_with_mime_type" symbol="gdk_pixbuf_loader_new_with_mime_type">
				<return-type type="GdkPixbufLoader*"/>
				<parameters>
					<parameter name="mime_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_with_type" symbol="gdk_pixbuf_loader_new_with_type">
				<return-type type="GdkPixbufLoader*"/>
				<parameters>
					<parameter name="image_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="set_size" symbol="gdk_pixbuf_loader_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="loader" type="GdkPixbufLoader*"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</method>
			<method name="write" symbol="gdk_pixbuf_loader_write">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="loader" type="GdkPixbufLoader*"/>
					<parameter name="buf" type="guchar*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<signal name="area-prepared" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="loader" type="GdkPixbufLoader*"/>
				</parameters>
			</signal>
			<signal name="area-updated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="loader" type="GdkPixbufLoader*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</signal>
			<signal name="closed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="loader" type="GdkPixbufLoader*"/>
				</parameters>
			</signal>
			<signal name="size-prepared" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="loader" type="GdkPixbufLoader*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</signal>
		</object>
		<object name="GdkPixbufSimpleAnim" parent="GdkPixbufAnimation" type-name="GdkPixbufSimpleAnim" get-type="gdk_pixbuf_simple_anim_get_type">
			<method name="add_frame" symbol="gdk_pixbuf_simple_anim_add_frame">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="GdkPixbufSimpleAnim*"/>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="get_loop" symbol="gdk_pixbuf_simple_anim_get_loop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="animation" type="GdkPixbufSimpleAnim*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdk_pixbuf_simple_anim_new">
				<return-type type="GdkPixbufSimpleAnim*"/>
				<parameters>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="rate" type="gfloat"/>
				</parameters>
			</constructor>
			<method name="set_loop" symbol="gdk_pixbuf_simple_anim_set_loop">
				<return-type type="void"/>
				<parameters>
					<parameter name="animation" type="GdkPixbufSimpleAnim*"/>
					<parameter name="loop" type="gboolean"/>
				</parameters>
			</method>
			<property name="loop" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GdkPixbufSimpleAnimIter" parent="GdkPixbufAnimationIter" type-name="GdkPixbufSimpleAnimIter" get-type="gdk_pixbuf_simple_anim_iter_get_type">
		</object>
		<constant name="GDK_PIXBUF_FEATURES_H" type="int" value="1"/>
		<constant name="GDK_PIXBUF_MAGIC_NUMBER" type="int" value="1197763408"/>
		<constant name="GDK_PIXBUF_MAJOR" type="int" value="2"/>
		<constant name="GDK_PIXBUF_MICRO" type="int" value="0"/>
		<constant name="GDK_PIXBUF_MINOR" type="int" value="20"/>
		<constant name="GDK_PIXBUF_VERSION" type="char*" value="2.20.0"/>
		<constant name="GDK_PIXDATA_HEADER_LENGTH" type="int" value="24"/>
	</namespace>
</api>
