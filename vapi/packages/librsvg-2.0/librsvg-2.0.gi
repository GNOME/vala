<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Rsvg">
		<function name="error_quark" symbol="rsvg_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="init" symbol="rsvg_init">
			<return-type type="void"/>
		</function>
		<function name="librsvg_postinit" symbol="librsvg_postinit">
			<return-type type="void"/>
			<parameters>
				<parameter name="app" type="void*"/>
				<parameter name="modinfo" type="void*"/>
			</parameters>
		</function>
		<function name="librsvg_preinit" symbol="librsvg_preinit">
			<return-type type="void"/>
			<parameters>
				<parameter name="app" type="void*"/>
				<parameter name="modinfo" type="void*"/>
			</parameters>
		</function>
		<function name="pixbuf_from_file" symbol="rsvg_pixbuf_from_file">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="file_name" type="gchar*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="pixbuf_from_file_at_max_size" symbol="rsvg_pixbuf_from_file_at_max_size">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="file_name" type="gchar*"/>
				<parameter name="max_width" type="gint"/>
				<parameter name="max_height" type="gint"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="pixbuf_from_file_at_size" symbol="rsvg_pixbuf_from_file_at_size">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="file_name" type="gchar*"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="pixbuf_from_file_at_zoom" symbol="rsvg_pixbuf_from_file_at_zoom">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="file_name" type="gchar*"/>
				<parameter name="x_zoom" type="double"/>
				<parameter name="y_zoom" type="double"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="pixbuf_from_file_at_zoom_with_max" symbol="rsvg_pixbuf_from_file_at_zoom_with_max">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="file_name" type="gchar*"/>
				<parameter name="x_zoom" type="double"/>
				<parameter name="y_zoom" type="double"/>
				<parameter name="max_width" type="gint"/>
				<parameter name="max_height" type="gint"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="set_default_dpi" symbol="rsvg_set_default_dpi">
			<return-type type="void"/>
			<parameters>
				<parameter name="dpi" type="double"/>
			</parameters>
		</function>
		<function name="set_default_dpi_x_y" symbol="rsvg_set_default_dpi_x_y">
			<return-type type="void"/>
			<parameters>
				<parameter name="dpi_x" type="double"/>
				<parameter name="dpi_y" type="double"/>
			</parameters>
		</function>
		<function name="term" symbol="rsvg_term">
			<return-type type="void"/>
		</function>
		<callback name="RsvgSizeFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="width" type="gint*"/>
				<parameter name="height" type="gint*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="RsvgDimensionData">
			<field name="width" type="int"/>
			<field name="height" type="int"/>
			<field name="em" type="gdouble"/>
			<field name="ex" type="gdouble"/>
		</struct>
		<struct name="RsvgPositionData">
			<field name="x" type="int"/>
			<field name="y" type="int"/>
		</struct>
		<enum name="RsvgError" type-name="RsvgError" get-type="rsvg_error_get_type">
			<member name="RSVG_ERROR_FAILED" value="0"/>
		</enum>
		<object name="RsvgHandle" parent="GObject" type-name="RsvgHandle" get-type="rsvg_handle_get_type">
			<method name="close" symbol="rsvg_handle_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="free" symbol="rsvg_handle_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
				</parameters>
			</method>
			<method name="get_base_uri" symbol="rsvg_handle_get_base_uri">
				<return-type type="char*"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
				</parameters>
			</method>
			<method name="get_desc" symbol="rsvg_handle_get_desc">
				<return-type type="char*"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
				</parameters>
			</method>
			<method name="get_dimensions" symbol="rsvg_handle_get_dimensions">
				<return-type type="void"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="dimension_data" type="RsvgDimensionData*"/>
				</parameters>
			</method>
			<method name="get_dimensions_sub" symbol="rsvg_handle_get_dimensions_sub">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="dimension_data" type="RsvgDimensionData*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_metadata" symbol="rsvg_handle_get_metadata">
				<return-type type="char*"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
				</parameters>
			</method>
			<method name="get_pixbuf" symbol="rsvg_handle_get_pixbuf">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
				</parameters>
			</method>
			<method name="get_pixbuf_sub" symbol="rsvg_handle_get_pixbuf_sub">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_position_sub" symbol="rsvg_handle_get_position_sub">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="position_data" type="RsvgPositionData*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="rsvg_handle_get_title">
				<return-type type="char*"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
				</parameters>
			</method>
			<method name="has_sub" symbol="rsvg_handle_has_sub">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="rsvg_handle_new">
				<return-type type="RsvgHandle*"/>
			</constructor>
			<constructor name="new_from_data" symbol="rsvg_handle_new_from_data">
				<return-type type="RsvgHandle*"/>
				<parameters>
					<parameter name="data" type="guint8*"/>
					<parameter name="data_len" type="gsize"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_file" symbol="rsvg_handle_new_from_file">
				<return-type type="RsvgHandle*"/>
				<parameters>
					<parameter name="file_name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="render_cairo" symbol="rsvg_handle_render_cairo">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="cr" type="cairo_t*"/>
				</parameters>
			</method>
			<method name="render_cairo_sub" symbol="rsvg_handle_render_cairo_sub">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="cr" type="cairo_t*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="set_base_uri" symbol="rsvg_handle_set_base_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="base_uri" type="char*"/>
				</parameters>
			</method>
			<method name="set_dpi" symbol="rsvg_handle_set_dpi">
				<return-type type="void"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="dpi" type="double"/>
				</parameters>
			</method>
			<method name="set_dpi_x_y" symbol="rsvg_handle_set_dpi_x_y">
				<return-type type="void"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="dpi_x" type="double"/>
					<parameter name="dpi_y" type="double"/>
				</parameters>
			</method>
			<method name="set_size_callback" symbol="rsvg_handle_set_size_callback">
				<return-type type="void"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="size_func" type="RsvgSizeFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="user_data_destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="write" symbol="rsvg_handle_write">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="handle" type="RsvgHandle*"/>
					<parameter name="buf" type="guchar*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="base-uri" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="desc" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="dpi-x" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="dpi-y" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="em" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="ex" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="height" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="metadata" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="width" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<constant name="LIBRSVG_FEATURES_H" type="int" value="1"/>
		<constant name="LIBRSVG_HAVE_CSS" type="int" value="1"/>
		<constant name="LIBRSVG_HAVE_SVGZ" type="int" value="1"/>
		<constant name="LIBRSVG_MAJOR_VERSION" type="int" value="2"/>
		<constant name="LIBRSVG_MICRO_VERSION" type="int" value="0"/>
		<constant name="LIBRSVG_MINOR_VERSION" type="int" value="26"/>
		<constant name="LIBRSVG_VERSION" type="char*" value=""/>
	</namespace>
</api>
