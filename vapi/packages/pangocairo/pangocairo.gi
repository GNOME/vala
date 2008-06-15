<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Pango">
		<function name="cairo_context_get_font_options" symbol="pango_cairo_context_get_font_options">
			<return-type type="cairo_font_options_t*"/>
			<parameters>
				<parameter name="context" type="PangoContext*"/>
			</parameters>
		</function>
		<function name="cairo_context_get_resolution" symbol="pango_cairo_context_get_resolution">
			<return-type type="double"/>
			<parameters>
				<parameter name="context" type="PangoContext*"/>
			</parameters>
		</function>
		<function name="cairo_context_get_shape_renderer" symbol="pango_cairo_context_get_shape_renderer">
			<return-type type="PangoCairoShapeRendererFunc"/>
			<parameters>
				<parameter name="context" type="PangoContext*"/>
				<parameter name="data" type="gpointer*"/>
			</parameters>
		</function>
		<function name="cairo_context_set_font_options" symbol="pango_cairo_context_set_font_options">
			<return-type type="void"/>
			<parameters>
				<parameter name="context" type="PangoContext*"/>
				<parameter name="options" type="cairo_font_options_t*"/>
			</parameters>
		</function>
		<function name="cairo_context_set_resolution" symbol="pango_cairo_context_set_resolution">
			<return-type type="void"/>
			<parameters>
				<parameter name="context" type="PangoContext*"/>
				<parameter name="dpi" type="double"/>
			</parameters>
		</function>
		<function name="cairo_context_set_shape_renderer" symbol="pango_cairo_context_set_shape_renderer">
			<return-type type="void"/>
			<parameters>
				<parameter name="context" type="PangoContext*"/>
				<parameter name="func" type="PangoCairoShapeRendererFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="dnotify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="cairo_create_context" symbol="pango_cairo_create_context">
			<return-type type="PangoContext*"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
			</parameters>
		</function>
		<function name="cairo_create_layout" symbol="pango_cairo_create_layout">
			<return-type type="PangoLayout*"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
			</parameters>
		</function>
		<function name="cairo_error_underline_path" symbol="pango_cairo_error_underline_path">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="x" type="double"/>
				<parameter name="y" type="double"/>
				<parameter name="width" type="double"/>
				<parameter name="height" type="double"/>
			</parameters>
		</function>
		<function name="cairo_glyph_string_path" symbol="pango_cairo_glyph_string_path">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="font" type="PangoFont*"/>
				<parameter name="glyphs" type="PangoGlyphString*"/>
			</parameters>
		</function>
		<function name="cairo_layout_line_path" symbol="pango_cairo_layout_line_path">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="line" type="PangoLayoutLine*"/>
			</parameters>
		</function>
		<function name="cairo_layout_path" symbol="pango_cairo_layout_path">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="layout" type="PangoLayout*"/>
			</parameters>
		</function>
		<function name="cairo_show_error_underline" symbol="pango_cairo_show_error_underline">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="x" type="double"/>
				<parameter name="y" type="double"/>
				<parameter name="width" type="double"/>
				<parameter name="height" type="double"/>
			</parameters>
		</function>
		<function name="cairo_show_glyph_string" symbol="pango_cairo_show_glyph_string">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="font" type="PangoFont*"/>
				<parameter name="glyphs" type="PangoGlyphString*"/>
			</parameters>
		</function>
		<function name="cairo_show_layout" symbol="pango_cairo_show_layout">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="layout" type="PangoLayout*"/>
			</parameters>
		</function>
		<function name="cairo_show_layout_line" symbol="pango_cairo_show_layout_line">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="line" type="PangoLayoutLine*"/>
			</parameters>
		</function>
		<function name="cairo_update_context" symbol="pango_cairo_update_context">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="context" type="PangoContext*"/>
			</parameters>
		</function>
		<function name="cairo_update_layout" symbol="pango_cairo_update_layout">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="layout" type="PangoLayout*"/>
			</parameters>
		</function>
		<callback name="PangoCairoShapeRendererFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="cr" type="cairo_t*"/>
				<parameter name="attr" type="PangoAttrShape*"/>
				<parameter name="do_path" type="gboolean"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<interface name="PangoCairoFont" type-name="PangoCairoFont" get-type="pango_cairo_font_get_type">
			<requires>
				<interface name="PangoFont"/>
			</requires>
			<method name="get_scaled_font" symbol="pango_cairo_font_get_scaled_font">
				<return-type type="cairo_scaled_font_t*"/>
				<parameters>
					<parameter name="font" type="PangoCairoFont*"/>
				</parameters>
			</method>
		</interface>
		<interface name="PangoCairoFontMap" type-name="PangoCairoFontMap" get-type="pango_cairo_font_map_get_type">
			<requires>
				<interface name="PangoFontMap"/>
			</requires>
			<method name="create_context" symbol="pango_cairo_font_map_create_context">
				<return-type type="PangoContext*"/>
				<parameters>
					<parameter name="fontmap" type="PangoCairoFontMap*"/>
				</parameters>
			</method>
			<method name="get_default" symbol="pango_cairo_font_map_get_default">
				<return-type type="PangoFontMap*"/>
			</method>
			<method name="get_font_type" symbol="pango_cairo_font_map_get_font_type">
				<return-type type="cairo_font_type_t"/>
				<parameters>
					<parameter name="fontmap" type="PangoCairoFontMap*"/>
				</parameters>
			</method>
			<method name="get_resolution" symbol="pango_cairo_font_map_get_resolution">
				<return-type type="double"/>
				<parameters>
					<parameter name="fontmap" type="PangoCairoFontMap*"/>
				</parameters>
			</method>
			<method name="new" symbol="pango_cairo_font_map_new">
				<return-type type="PangoFontMap*"/>
			</method>
			<method name="new_for_font_type" symbol="pango_cairo_font_map_new_for_font_type">
				<return-type type="PangoFontMap*"/>
				<parameters>
					<parameter name="fonttype" type="cairo_font_type_t"/>
				</parameters>
			</method>
			<method name="set_default" symbol="pango_cairo_font_map_set_default">
				<return-type type="void"/>
				<parameters>
					<parameter name="fontmap" type="PangoCairoFontMap*"/>
				</parameters>
			</method>
			<method name="set_resolution" symbol="pango_cairo_font_map_set_resolution">
				<return-type type="void"/>
				<parameters>
					<parameter name="fontmap" type="PangoCairoFontMap*"/>
					<parameter name="dpi" type="double"/>
				</parameters>
			</method>
		</interface>
	</namespace>
</api>
