<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Pango">
		<function name="attr_background_new" symbol="pango_attr_background_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="red" type="guint16"/>
				<parameter name="green" type="guint16"/>
				<parameter name="blue" type="guint16"/>
			</parameters>
		</function>
		<function name="attr_fallback_new" symbol="pango_attr_fallback_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="enable_fallback" type="gboolean"/>
			</parameters>
		</function>
		<function name="attr_family_new" symbol="pango_attr_family_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="family" type="char*"/>
			</parameters>
		</function>
		<function name="attr_foreground_new" symbol="pango_attr_foreground_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="red" type="guint16"/>
				<parameter name="green" type="guint16"/>
				<parameter name="blue" type="guint16"/>
			</parameters>
		</function>
		<function name="attr_gravity_hint_new" symbol="pango_attr_gravity_hint_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="hint" type="PangoGravityHint"/>
			</parameters>
		</function>
		<function name="attr_gravity_new" symbol="pango_attr_gravity_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="gravity" type="PangoGravity"/>
			</parameters>
		</function>
		<function name="attr_letter_spacing_new" symbol="pango_attr_letter_spacing_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="letter_spacing" type="int"/>
			</parameters>
		</function>
		<function name="attr_rise_new" symbol="pango_attr_rise_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="rise" type="int"/>
			</parameters>
		</function>
		<function name="attr_scale_new" symbol="pango_attr_scale_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="scale_factor" type="double"/>
			</parameters>
		</function>
		<function name="attr_stretch_new" symbol="pango_attr_stretch_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="stretch" type="PangoStretch"/>
			</parameters>
		</function>
		<function name="attr_strikethrough_color_new" symbol="pango_attr_strikethrough_color_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="red" type="guint16"/>
				<parameter name="green" type="guint16"/>
				<parameter name="blue" type="guint16"/>
			</parameters>
		</function>
		<function name="attr_strikethrough_new" symbol="pango_attr_strikethrough_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="strikethrough" type="gboolean"/>
			</parameters>
		</function>
		<function name="attr_style_new" symbol="pango_attr_style_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="style" type="PangoStyle"/>
			</parameters>
		</function>
		<function name="attr_type_get_name" symbol="pango_attr_type_get_name">
			<return-type type="char*"/>
			<parameters>
				<parameter name="type" type="PangoAttrType"/>
			</parameters>
		</function>
		<function name="attr_type_register" symbol="pango_attr_type_register">
			<return-type type="PangoAttrType"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="attr_underline_color_new" symbol="pango_attr_underline_color_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="red" type="guint16"/>
				<parameter name="green" type="guint16"/>
				<parameter name="blue" type="guint16"/>
			</parameters>
		</function>
		<function name="attr_underline_new" symbol="pango_attr_underline_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="underline" type="PangoUnderline"/>
			</parameters>
		</function>
		<function name="attr_variant_new" symbol="pango_attr_variant_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="variant" type="PangoVariant"/>
			</parameters>
		</function>
		<function name="attr_weight_new" symbol="pango_attr_weight_new">
			<return-type type="PangoAttribute*"/>
			<parameters>
				<parameter name="weight" type="PangoWeight"/>
			</parameters>
		</function>
		<function name="bidi_type_for_unichar" symbol="pango_bidi_type_for_unichar">
			<return-type type="PangoBidiType"/>
			<parameters>
				<parameter name="ch" type="gunichar"/>
			</parameters>
		</function>
		<function name="break" symbol="pango_break">
			<return-type type="void"/>
			<parameters>
				<parameter name="text" type="gchar*"/>
				<parameter name="length" type="int"/>
				<parameter name="analysis" type="PangoAnalysis*"/>
				<parameter name="attrs" type="PangoLogAttr*"/>
				<parameter name="attrs_len" type="int"/>
			</parameters>
		</function>
		<function name="extents_to_pixels" symbol="pango_extents_to_pixels">
			<return-type type="void"/>
			<parameters>
				<parameter name="inclusive" type="PangoRectangle*"/>
				<parameter name="nearest" type="PangoRectangle*"/>
			</parameters>
		</function>
		<function name="find_base_dir" symbol="pango_find_base_dir">
			<return-type type="PangoDirection"/>
			<parameters>
				<parameter name="text" type="gchar*"/>
				<parameter name="length" type="gint"/>
			</parameters>
		</function>
		<function name="find_paragraph_boundary" symbol="pango_find_paragraph_boundary">
			<return-type type="void"/>
			<parameters>
				<parameter name="text" type="gchar*"/>
				<parameter name="length" type="gint"/>
				<parameter name="paragraph_delimiter_index" type="gint*"/>
				<parameter name="next_paragraph_start" type="gint*"/>
			</parameters>
		</function>
		<function name="get_log_attrs" symbol="pango_get_log_attrs">
			<return-type type="void"/>
			<parameters>
				<parameter name="text" type="char*"/>
				<parameter name="length" type="int"/>
				<parameter name="level" type="int"/>
				<parameter name="language" type="PangoLanguage*"/>
				<parameter name="log_attrs" type="PangoLogAttr*"/>
				<parameter name="attrs_len" type="int"/>
			</parameters>
		</function>
		<function name="gravity_get_for_matrix" symbol="pango_gravity_get_for_matrix">
			<return-type type="PangoGravity"/>
			<parameters>
				<parameter name="matrix" type="PangoMatrix*"/>
			</parameters>
		</function>
		<function name="gravity_get_for_script" symbol="pango_gravity_get_for_script">
			<return-type type="PangoGravity"/>
			<parameters>
				<parameter name="script" type="PangoScript"/>
				<parameter name="base_gravity" type="PangoGravity"/>
				<parameter name="hint" type="PangoGravityHint"/>
			</parameters>
		</function>
		<function name="gravity_get_for_script_and_width" symbol="pango_gravity_get_for_script_and_width">
			<return-type type="PangoGravity"/>
			<parameters>
				<parameter name="script" type="PangoScript"/>
				<parameter name="wide" type="gboolean"/>
				<parameter name="base_gravity" type="PangoGravity"/>
				<parameter name="hint" type="PangoGravityHint"/>
			</parameters>
		</function>
		<function name="gravity_to_rotation" symbol="pango_gravity_to_rotation">
			<return-type type="double"/>
			<parameters>
				<parameter name="gravity" type="PangoGravity"/>
			</parameters>
		</function>
		<function name="is_zero_width" symbol="pango_is_zero_width">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="ch" type="gunichar"/>
			</parameters>
		</function>
		<function name="itemize" symbol="pango_itemize">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="context" type="PangoContext*"/>
				<parameter name="text" type="char*"/>
				<parameter name="start_index" type="int"/>
				<parameter name="length" type="int"/>
				<parameter name="attrs" type="PangoAttrList*"/>
				<parameter name="cached_iter" type="PangoAttrIterator*"/>
			</parameters>
		</function>
		<function name="itemize_with_base_dir" symbol="pango_itemize_with_base_dir">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="context" type="PangoContext*"/>
				<parameter name="base_dir" type="PangoDirection"/>
				<parameter name="text" type="char*"/>
				<parameter name="start_index" type="int"/>
				<parameter name="length" type="int"/>
				<parameter name="attrs" type="PangoAttrList*"/>
				<parameter name="cached_iter" type="PangoAttrIterator*"/>
			</parameters>
		</function>
		<function name="log2vis_get_embedding_levels" symbol="pango_log2vis_get_embedding_levels">
			<return-type type="guint8*"/>
			<parameters>
				<parameter name="text" type="gchar*"/>
				<parameter name="length" type="int"/>
				<parameter name="pbase_dir" type="PangoDirection*"/>
			</parameters>
		</function>
		<function name="parse_enum" symbol="pango_parse_enum">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="type" type="GType"/>
				<parameter name="str" type="char*"/>
				<parameter name="value" type="int*"/>
				<parameter name="warn" type="gboolean"/>
				<parameter name="possible_values" type="char**"/>
			</parameters>
		</function>
		<function name="parse_markup" symbol="pango_parse_markup">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="markup_text" type="char*"/>
				<parameter name="length" type="int"/>
				<parameter name="accel_marker" type="gunichar"/>
				<parameter name="attr_list" type="PangoAttrList**"/>
				<parameter name="text" type="char**"/>
				<parameter name="accel_char" type="gunichar*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="parse_stretch" symbol="pango_parse_stretch">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="stretch" type="PangoStretch*"/>
				<parameter name="warn" type="gboolean"/>
			</parameters>
		</function>
		<function name="parse_style" symbol="pango_parse_style">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="style" type="PangoStyle*"/>
				<parameter name="warn" type="gboolean"/>
			</parameters>
		</function>
		<function name="parse_variant" symbol="pango_parse_variant">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="variant" type="PangoVariant*"/>
				<parameter name="warn" type="gboolean"/>
			</parameters>
		</function>
		<function name="parse_weight" symbol="pango_parse_weight">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="weight" type="PangoWeight*"/>
				<parameter name="warn" type="gboolean"/>
			</parameters>
		</function>
		<function name="quantize_line_geometry" symbol="pango_quantize_line_geometry">
			<return-type type="void"/>
			<parameters>
				<parameter name="thickness" type="int*"/>
				<parameter name="position" type="int*"/>
			</parameters>
		</function>
		<function name="read_line" symbol="pango_read_line">
			<return-type type="gint"/>
			<parameters>
				<parameter name="stream" type="FILE*"/>
				<parameter name="str" type="GString*"/>
			</parameters>
		</function>
		<function name="reorder_items" symbol="pango_reorder_items">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="logical_items" type="GList*"/>
			</parameters>
		</function>
		<function name="scan_int" symbol="pango_scan_int">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pos" type="char**"/>
				<parameter name="out" type="int*"/>
			</parameters>
		</function>
		<function name="scan_string" symbol="pango_scan_string">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pos" type="char**"/>
				<parameter name="out" type="GString*"/>
			</parameters>
		</function>
		<function name="scan_word" symbol="pango_scan_word">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pos" type="char**"/>
				<parameter name="out" type="GString*"/>
			</parameters>
		</function>
		<function name="script_for_unichar" symbol="pango_script_for_unichar">
			<return-type type="PangoScript"/>
			<parameters>
				<parameter name="ch" type="gunichar"/>
			</parameters>
		</function>
		<function name="script_get_sample_language" symbol="pango_script_get_sample_language">
			<return-type type="PangoLanguage*"/>
			<parameters>
				<parameter name="script" type="PangoScript"/>
			</parameters>
		</function>
		<function name="shape" symbol="pango_shape">
			<return-type type="void"/>
			<parameters>
				<parameter name="text" type="gchar*"/>
				<parameter name="length" type="gint"/>
				<parameter name="analysis" type="PangoAnalysis*"/>
				<parameter name="glyphs" type="PangoGlyphString*"/>
			</parameters>
		</function>
		<function name="skip_space" symbol="pango_skip_space">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pos" type="char**"/>
			</parameters>
		</function>
		<function name="split_file_list" symbol="pango_split_file_list">
			<return-type type="char**"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="trim_string" symbol="pango_trim_string">
			<return-type type="char*"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="unichar_direction" symbol="pango_unichar_direction">
			<return-type type="PangoDirection"/>
			<parameters>
				<parameter name="ch" type="gunichar"/>
			</parameters>
		</function>
		<function name="units_from_double" symbol="pango_units_from_double">
			<return-type type="int"/>
			<parameters>
				<parameter name="d" type="double"/>
			</parameters>
		</function>
		<function name="units_to_double" symbol="pango_units_to_double">
			<return-type type="double"/>
			<parameters>
				<parameter name="i" type="int"/>
			</parameters>
		</function>
		<function name="version" symbol="pango_version">
			<return-type type="int"/>
		</function>
		<function name="version_check" symbol="pango_version_check">
			<return-type type="char*"/>
			<parameters>
				<parameter name="required_major" type="int"/>
				<parameter name="required_minor" type="int"/>
				<parameter name="required_micro" type="int"/>
			</parameters>
		</function>
		<function name="version_string" symbol="pango_version_string">
			<return-type type="char*"/>
		</function>
		<callback name="PangoAttrDataCopyFunc">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="data" type="gconstpointer"/>
			</parameters>
		</callback>
		<callback name="PangoAttrFilterFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="attribute" type="PangoAttribute*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="PangoFontsetForeachFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="fontset" type="PangoFontset*"/>
				<parameter name="font" type="PangoFont*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="PangoAnalysis">
			<field name="shape_engine" type="PangoEngineShape*"/>
			<field name="lang_engine" type="PangoEngineLang*"/>
			<field name="font" type="PangoFont*"/>
			<field name="level" type="guint8"/>
			<field name="gravity" type="guint8"/>
			<field name="flags" type="guint8"/>
			<field name="script" type="guint8"/>
			<field name="language" type="PangoLanguage*"/>
			<field name="extra_attrs" type="GSList*"/>
		</struct>
		<struct name="PangoAttrClass">
			<field name="type" type="PangoAttrType"/>
			<field name="copy" type="GCallback"/>
			<field name="destroy" type="GCallback"/>
			<field name="equal" type="GCallback"/>
		</struct>
		<struct name="PangoAttrColor">
			<field name="attr" type="PangoAttribute"/>
			<field name="color" type="PangoColor"/>
		</struct>
		<struct name="PangoAttrFloat">
			<field name="attr" type="PangoAttribute"/>
			<field name="value" type="double"/>
		</struct>
		<struct name="PangoAttrFontDesc">
			<method name="new" symbol="pango_attr_font_desc_new">
				<return-type type="PangoAttribute*"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<field name="attr" type="PangoAttribute"/>
			<field name="desc" type="PangoFontDescription*"/>
		</struct>
		<struct name="PangoAttrInt">
			<field name="attr" type="PangoAttribute"/>
			<field name="value" type="int"/>
		</struct>
		<struct name="PangoAttrIterator">
			<method name="copy" symbol="pango_attr_iterator_copy">
				<return-type type="PangoAttrIterator*"/>
				<parameters>
					<parameter name="iterator" type="PangoAttrIterator*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="pango_attr_iterator_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="iterator" type="PangoAttrIterator*"/>
				</parameters>
			</method>
			<method name="get" symbol="pango_attr_iterator_get">
				<return-type type="PangoAttribute*"/>
				<parameters>
					<parameter name="iterator" type="PangoAttrIterator*"/>
					<parameter name="type" type="PangoAttrType"/>
				</parameters>
			</method>
			<method name="get_attrs" symbol="pango_attr_iterator_get_attrs">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="iterator" type="PangoAttrIterator*"/>
				</parameters>
			</method>
			<method name="get_font" symbol="pango_attr_iterator_get_font">
				<return-type type="void"/>
				<parameters>
					<parameter name="iterator" type="PangoAttrIterator*"/>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="language" type="PangoLanguage**"/>
					<parameter name="extra_attrs" type="GSList**"/>
				</parameters>
			</method>
			<method name="next" symbol="pango_attr_iterator_next">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iterator" type="PangoAttrIterator*"/>
				</parameters>
			</method>
			<method name="range" symbol="pango_attr_iterator_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="iterator" type="PangoAttrIterator*"/>
					<parameter name="start" type="gint*"/>
					<parameter name="end" type="gint*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PangoAttrLanguage">
			<method name="new" symbol="pango_attr_language_new">
				<return-type type="PangoAttribute*"/>
				<parameters>
					<parameter name="language" type="PangoLanguage*"/>
				</parameters>
			</method>
			<field name="attr" type="PangoAttribute"/>
			<field name="value" type="PangoLanguage*"/>
		</struct>
		<struct name="PangoAttrShape">
			<method name="new" symbol="pango_attr_shape_new">
				<return-type type="PangoAttribute*"/>
				<parameters>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="new_with_data" symbol="pango_attr_shape_new_with_data">
				<return-type type="PangoAttribute*"/>
				<parameters>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="copy_func" type="PangoAttrDataCopyFunc"/>
					<parameter name="destroy_func" type="GDestroyNotify"/>
				</parameters>
			</method>
			<field name="attr" type="PangoAttribute"/>
			<field name="ink_rect" type="PangoRectangle"/>
			<field name="logical_rect" type="PangoRectangle"/>
			<field name="data" type="gpointer"/>
			<field name="copy_func" type="PangoAttrDataCopyFunc"/>
			<field name="destroy_func" type="GDestroyNotify"/>
		</struct>
		<struct name="PangoAttrSize">
			<method name="new" symbol="pango_attr_size_new">
				<return-type type="PangoAttribute*"/>
				<parameters>
					<parameter name="size" type="int"/>
				</parameters>
			</method>
			<method name="new_absolute" symbol="pango_attr_size_new_absolute">
				<return-type type="PangoAttribute*"/>
				<parameters>
					<parameter name="size" type="int"/>
				</parameters>
			</method>
			<field name="attr" type="PangoAttribute"/>
			<field name="size" type="int"/>
			<field name="absolute" type="guint"/>
		</struct>
		<struct name="PangoAttrString">
			<field name="attr" type="PangoAttribute"/>
			<field name="value" type="char*"/>
		</struct>
		<struct name="PangoAttribute">
			<method name="copy" symbol="pango_attribute_copy">
				<return-type type="PangoAttribute*"/>
				<parameters>
					<parameter name="attr" type="PangoAttribute*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="pango_attribute_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="PangoAttribute*"/>
				</parameters>
			</method>
			<method name="equal" symbol="pango_attribute_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="attr1" type="PangoAttribute*"/>
					<parameter name="attr2" type="PangoAttribute*"/>
				</parameters>
			</method>
			<method name="init" symbol="pango_attribute_init">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="PangoAttribute*"/>
					<parameter name="klass" type="PangoAttrClass*"/>
				</parameters>
			</method>
			<field name="klass" type="PangoAttrClass*"/>
			<field name="start_index" type="guint"/>
			<field name="end_index" type="guint"/>
		</struct>
		<struct name="PangoContextClass">
		</struct>
		<struct name="PangoCoverage">
			<method name="copy" symbol="pango_coverage_copy">
				<return-type type="PangoCoverage*"/>
				<parameters>
					<parameter name="coverage" type="PangoCoverage*"/>
				</parameters>
			</method>
			<method name="from_bytes" symbol="pango_coverage_from_bytes">
				<return-type type="PangoCoverage*"/>
				<parameters>
					<parameter name="bytes" type="guchar*"/>
					<parameter name="n_bytes" type="int"/>
				</parameters>
			</method>
			<method name="get" symbol="pango_coverage_get">
				<return-type type="PangoCoverageLevel"/>
				<parameters>
					<parameter name="coverage" type="PangoCoverage*"/>
					<parameter name="index_" type="int"/>
				</parameters>
			</method>
			<method name="max" symbol="pango_coverage_max">
				<return-type type="void"/>
				<parameters>
					<parameter name="coverage" type="PangoCoverage*"/>
					<parameter name="other" type="PangoCoverage*"/>
				</parameters>
			</method>
			<method name="new" symbol="pango_coverage_new">
				<return-type type="PangoCoverage*"/>
			</method>
			<method name="ref" symbol="pango_coverage_ref">
				<return-type type="PangoCoverage*"/>
				<parameters>
					<parameter name="coverage" type="PangoCoverage*"/>
				</parameters>
			</method>
			<method name="set" symbol="pango_coverage_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="coverage" type="PangoCoverage*"/>
					<parameter name="index_" type="int"/>
					<parameter name="level" type="PangoCoverageLevel"/>
				</parameters>
			</method>
			<method name="to_bytes" symbol="pango_coverage_to_bytes">
				<return-type type="void"/>
				<parameters>
					<parameter name="coverage" type="PangoCoverage*"/>
					<parameter name="bytes" type="guchar**"/>
					<parameter name="n_bytes" type="int*"/>
				</parameters>
			</method>
			<method name="unref" symbol="pango_coverage_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="coverage" type="PangoCoverage*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PangoEngineLang">
		</struct>
		<struct name="PangoEngineShape">
		</struct>
		<struct name="PangoGlyph">
		</struct>
		<struct name="PangoGlyphGeometry">
			<field name="width" type="PangoGlyphUnit"/>
			<field name="x_offset" type="PangoGlyphUnit"/>
			<field name="y_offset" type="PangoGlyphUnit"/>
		</struct>
		<struct name="PangoGlyphInfo">
			<field name="glyph" type="PangoGlyph"/>
			<field name="geometry" type="PangoGlyphGeometry"/>
			<field name="attr" type="PangoGlyphVisAttr"/>
		</struct>
		<struct name="PangoGlyphUnit">
		</struct>
		<struct name="PangoGlyphVisAttr">
			<field name="is_cluster_start" type="guint"/>
		</struct>
		<struct name="PangoLayoutClass">
		</struct>
		<struct name="PangoLayoutRun">
		</struct>
		<struct name="PangoLogAttr">
			<field name="is_line_break" type="guint"/>
			<field name="is_mandatory_break" type="guint"/>
			<field name="is_char_break" type="guint"/>
			<field name="is_white" type="guint"/>
			<field name="is_cursor_position" type="guint"/>
			<field name="is_word_start" type="guint"/>
			<field name="is_word_end" type="guint"/>
			<field name="is_sentence_boundary" type="guint"/>
			<field name="is_sentence_start" type="guint"/>
			<field name="is_sentence_end" type="guint"/>
			<field name="backspace_deletes_character" type="guint"/>
			<field name="is_expandable_space" type="guint"/>
			<field name="is_word_boundary" type="guint"/>
		</struct>
		<struct name="PangoRectangle">
			<field name="x" type="int"/>
			<field name="y" type="int"/>
			<field name="width" type="int"/>
			<field name="height" type="int"/>
		</struct>
		<struct name="PangoScriptIter">
			<method name="free" symbol="pango_script_iter_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PangoScriptIter*"/>
				</parameters>
			</method>
			<method name="get_range" symbol="pango_script_iter_get_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PangoScriptIter*"/>
					<parameter name="start" type="char**"/>
					<parameter name="end" type="char**"/>
					<parameter name="script" type="PangoScript*"/>
				</parameters>
			</method>
			<method name="new" symbol="pango_script_iter_new">
				<return-type type="PangoScriptIter*"/>
				<parameters>
					<parameter name="text" type="char*"/>
					<parameter name="length" type="int"/>
				</parameters>
			</method>
			<method name="next" symbol="pango_script_iter_next">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PangoScriptIter*"/>
				</parameters>
			</method>
		</struct>
		<boxed name="PangoAttrList" type-name="PangoAttrList" get-type="pango_attr_list_get_type">
			<method name="change" symbol="pango_attr_list_change">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PangoAttrList*"/>
					<parameter name="attr" type="PangoAttribute*"/>
				</parameters>
			</method>
			<method name="copy" symbol="pango_attr_list_copy">
				<return-type type="PangoAttrList*"/>
				<parameters>
					<parameter name="list" type="PangoAttrList*"/>
				</parameters>
			</method>
			<method name="filter" symbol="pango_attr_list_filter">
				<return-type type="PangoAttrList*"/>
				<parameters>
					<parameter name="list" type="PangoAttrList*"/>
					<parameter name="func" type="PangoAttrFilterFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_iterator" symbol="pango_attr_list_get_iterator">
				<return-type type="PangoAttrIterator*"/>
				<parameters>
					<parameter name="list" type="PangoAttrList*"/>
				</parameters>
			</method>
			<method name="insert" symbol="pango_attr_list_insert">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PangoAttrList*"/>
					<parameter name="attr" type="PangoAttribute*"/>
				</parameters>
			</method>
			<method name="insert_before" symbol="pango_attr_list_insert_before">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PangoAttrList*"/>
					<parameter name="attr" type="PangoAttribute*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="pango_attr_list_new">
				<return-type type="PangoAttrList*"/>
			</constructor>
			<method name="ref" symbol="pango_attr_list_ref">
				<return-type type="PangoAttrList*"/>
				<parameters>
					<parameter name="list" type="PangoAttrList*"/>
				</parameters>
			</method>
			<method name="splice" symbol="pango_attr_list_splice">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PangoAttrList*"/>
					<parameter name="other" type="PangoAttrList*"/>
					<parameter name="pos" type="gint"/>
					<parameter name="len" type="gint"/>
				</parameters>
			</method>
			<method name="unref" symbol="pango_attr_list_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PangoAttrList*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="PangoColor" type-name="PangoColor" get-type="pango_color_get_type">
			<method name="copy" symbol="pango_color_copy">
				<return-type type="PangoColor*"/>
				<parameters>
					<parameter name="src" type="PangoColor*"/>
				</parameters>
			</method>
			<method name="free" symbol="pango_color_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="PangoColor*"/>
				</parameters>
			</method>
			<method name="parse" symbol="pango_color_parse">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="color" type="PangoColor*"/>
					<parameter name="spec" type="char*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="pango_color_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="color" type="PangoColor*"/>
				</parameters>
			</method>
			<field name="red" type="guint16"/>
			<field name="green" type="guint16"/>
			<field name="blue" type="guint16"/>
		</boxed>
		<boxed name="PangoFontDescription" type-name="PangoFontDescription" get-type="pango_font_description_get_type">
			<method name="better_match" symbol="pango_font_description_better_match">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="old_match" type="PangoFontDescription*"/>
					<parameter name="new_match" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="copy" symbol="pango_font_description_copy">
				<return-type type="PangoFontDescription*"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="copy_static" symbol="pango_font_description_copy_static">
				<return-type type="PangoFontDescription*"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="equal" symbol="pango_font_description_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="desc1" type="PangoFontDescription*"/>
					<parameter name="desc2" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="free" symbol="pango_font_description_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="from_string" symbol="pango_font_description_from_string">
				<return-type type="PangoFontDescription*"/>
				<parameters>
					<parameter name="str" type="char*"/>
				</parameters>
			</method>
			<method name="get_family" symbol="pango_font_description_get_family">
				<return-type type="char*"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="get_gravity" symbol="pango_font_description_get_gravity">
				<return-type type="PangoGravity"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="get_set_fields" symbol="pango_font_description_get_set_fields">
				<return-type type="PangoFontMask"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="pango_font_description_get_size">
				<return-type type="gint"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="get_size_is_absolute" symbol="pango_font_description_get_size_is_absolute">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="get_stretch" symbol="pango_font_description_get_stretch">
				<return-type type="PangoStretch"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="get_style" symbol="pango_font_description_get_style">
				<return-type type="PangoStyle"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="get_variant" symbol="pango_font_description_get_variant">
				<return-type type="PangoVariant"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="get_weight" symbol="pango_font_description_get_weight">
				<return-type type="PangoWeight"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="hash" symbol="pango_font_description_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="merge" symbol="pango_font_description_merge">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="desc_to_merge" type="PangoFontDescription*"/>
					<parameter name="replace_existing" type="gboolean"/>
				</parameters>
			</method>
			<method name="merge_static" symbol="pango_font_description_merge_static">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="desc_to_merge" type="PangoFontDescription*"/>
					<parameter name="replace_existing" type="gboolean"/>
				</parameters>
			</method>
			<constructor name="new" symbol="pango_font_description_new">
				<return-type type="PangoFontDescription*"/>
			</constructor>
			<method name="set_absolute_size" symbol="pango_font_description_set_absolute_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="size" type="double"/>
				</parameters>
			</method>
			<method name="set_family" symbol="pango_font_description_set_family">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="family" type="char*"/>
				</parameters>
			</method>
			<method name="set_family_static" symbol="pango_font_description_set_family_static">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="family" type="char*"/>
				</parameters>
			</method>
			<method name="set_gravity" symbol="pango_font_description_set_gravity">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="gravity" type="PangoGravity"/>
				</parameters>
			</method>
			<method name="set_size" symbol="pango_font_description_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="size" type="gint"/>
				</parameters>
			</method>
			<method name="set_stretch" symbol="pango_font_description_set_stretch">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="stretch" type="PangoStretch"/>
				</parameters>
			</method>
			<method name="set_style" symbol="pango_font_description_set_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="style" type="PangoStyle"/>
				</parameters>
			</method>
			<method name="set_variant" symbol="pango_font_description_set_variant">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="variant" type="PangoVariant"/>
				</parameters>
			</method>
			<method name="set_weight" symbol="pango_font_description_set_weight">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="weight" type="PangoWeight"/>
				</parameters>
			</method>
			<method name="to_filename" symbol="pango_font_description_to_filename">
				<return-type type="char*"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="pango_font_description_to_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="unset_fields" symbol="pango_font_description_unset_fields">
				<return-type type="void"/>
				<parameters>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="to_unset" type="PangoFontMask"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="PangoFontMetrics" type-name="PangoFontMetrics" get-type="pango_font_metrics_get_type">
			<method name="get_approximate_char_width" symbol="pango_font_metrics_get_approximate_char_width">
				<return-type type="int"/>
				<parameters>
					<parameter name="metrics" type="PangoFontMetrics*"/>
				</parameters>
			</method>
			<method name="get_approximate_digit_width" symbol="pango_font_metrics_get_approximate_digit_width">
				<return-type type="int"/>
				<parameters>
					<parameter name="metrics" type="PangoFontMetrics*"/>
				</parameters>
			</method>
			<method name="get_ascent" symbol="pango_font_metrics_get_ascent">
				<return-type type="int"/>
				<parameters>
					<parameter name="metrics" type="PangoFontMetrics*"/>
				</parameters>
			</method>
			<method name="get_descent" symbol="pango_font_metrics_get_descent">
				<return-type type="int"/>
				<parameters>
					<parameter name="metrics" type="PangoFontMetrics*"/>
				</parameters>
			</method>
			<method name="get_strikethrough_position" symbol="pango_font_metrics_get_strikethrough_position">
				<return-type type="int"/>
				<parameters>
					<parameter name="metrics" type="PangoFontMetrics*"/>
				</parameters>
			</method>
			<method name="get_strikethrough_thickness" symbol="pango_font_metrics_get_strikethrough_thickness">
				<return-type type="int"/>
				<parameters>
					<parameter name="metrics" type="PangoFontMetrics*"/>
				</parameters>
			</method>
			<method name="get_underline_position" symbol="pango_font_metrics_get_underline_position">
				<return-type type="int"/>
				<parameters>
					<parameter name="metrics" type="PangoFontMetrics*"/>
				</parameters>
			</method>
			<method name="get_underline_thickness" symbol="pango_font_metrics_get_underline_thickness">
				<return-type type="int"/>
				<parameters>
					<parameter name="metrics" type="PangoFontMetrics*"/>
				</parameters>
			</method>
			<method name="ref" symbol="pango_font_metrics_ref">
				<return-type type="PangoFontMetrics*"/>
				<parameters>
					<parameter name="metrics" type="PangoFontMetrics*"/>
				</parameters>
			</method>
			<method name="unref" symbol="pango_font_metrics_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="metrics" type="PangoFontMetrics*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="PangoGlyphItem" type-name="PangoGlyphItem" get-type="pango_glyph_item_get_type">
			<method name="apply_attrs" symbol="pango_glyph_item_apply_attrs">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="glyph_item" type="PangoGlyphItem*"/>
					<parameter name="text" type="char*"/>
					<parameter name="list" type="PangoAttrList*"/>
				</parameters>
			</method>
			<method name="copy" symbol="pango_glyph_item_copy">
				<return-type type="PangoGlyphItem*"/>
				<parameters>
					<parameter name="orig" type="PangoGlyphItem*"/>
				</parameters>
			</method>
			<method name="free" symbol="pango_glyph_item_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="glyph_item" type="PangoGlyphItem*"/>
				</parameters>
			</method>
			<method name="get_logical_widths" symbol="pango_glyph_item_get_logical_widths">
				<return-type type="void"/>
				<parameters>
					<parameter name="glyph_item" type="PangoGlyphItem*"/>
					<parameter name="text" type="char*"/>
					<parameter name="logical_widths" type="int*"/>
				</parameters>
			</method>
			<method name="letter_space" symbol="pango_glyph_item_letter_space">
				<return-type type="void"/>
				<parameters>
					<parameter name="glyph_item" type="PangoGlyphItem*"/>
					<parameter name="text" type="char*"/>
					<parameter name="log_attrs" type="PangoLogAttr*"/>
					<parameter name="letter_spacing" type="int"/>
				</parameters>
			</method>
			<method name="split" symbol="pango_glyph_item_split">
				<return-type type="PangoGlyphItem*"/>
				<parameters>
					<parameter name="orig" type="PangoGlyphItem*"/>
					<parameter name="text" type="char*"/>
					<parameter name="split_index" type="int"/>
				</parameters>
			</method>
			<field name="item" type="PangoItem*"/>
			<field name="glyphs" type="PangoGlyphString*"/>
		</boxed>
		<boxed name="PangoGlyphItemIter" type-name="PangoGlyphItemIter" get-type="pango_glyph_item_iter_get_type">
			<method name="copy" symbol="pango_glyph_item_iter_copy">
				<return-type type="PangoGlyphItemIter*"/>
				<parameters>
					<parameter name="orig" type="PangoGlyphItemIter*"/>
				</parameters>
			</method>
			<method name="free" symbol="pango_glyph_item_iter_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PangoGlyphItemIter*"/>
				</parameters>
			</method>
			<method name="init_end" symbol="pango_glyph_item_iter_init_end">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PangoGlyphItemIter*"/>
					<parameter name="glyph_item" type="PangoGlyphItem*"/>
					<parameter name="text" type="char*"/>
				</parameters>
			</method>
			<method name="init_start" symbol="pango_glyph_item_iter_init_start">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PangoGlyphItemIter*"/>
					<parameter name="glyph_item" type="PangoGlyphItem*"/>
					<parameter name="text" type="char*"/>
				</parameters>
			</method>
			<method name="next_cluster" symbol="pango_glyph_item_iter_next_cluster">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PangoGlyphItemIter*"/>
				</parameters>
			</method>
			<method name="prev_cluster" symbol="pango_glyph_item_iter_prev_cluster">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PangoGlyphItemIter*"/>
				</parameters>
			</method>
			<field name="glyph_item" type="PangoGlyphItem*"/>
			<field name="text" type="gchar*"/>
			<field name="start_glyph" type="int"/>
			<field name="start_index" type="int"/>
			<field name="start_char" type="int"/>
			<field name="end_glyph" type="int"/>
			<field name="end_index" type="int"/>
			<field name="end_char" type="int"/>
		</boxed>
		<boxed name="PangoGlyphString" type-name="PangoGlyphString" get-type="pango_glyph_string_get_type">
			<method name="copy" symbol="pango_glyph_string_copy">
				<return-type type="PangoGlyphString*"/>
				<parameters>
					<parameter name="string" type="PangoGlyphString*"/>
				</parameters>
			</method>
			<method name="extents" symbol="pango_glyph_string_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="glyphs" type="PangoGlyphString*"/>
					<parameter name="font" type="PangoFont*"/>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="extents_range" symbol="pango_glyph_string_extents_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="glyphs" type="PangoGlyphString*"/>
					<parameter name="start" type="int"/>
					<parameter name="end" type="int"/>
					<parameter name="font" type="PangoFont*"/>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="free" symbol="pango_glyph_string_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="string" type="PangoGlyphString*"/>
				</parameters>
			</method>
			<method name="get_logical_widths" symbol="pango_glyph_string_get_logical_widths">
				<return-type type="void"/>
				<parameters>
					<parameter name="glyphs" type="PangoGlyphString*"/>
					<parameter name="text" type="char*"/>
					<parameter name="length" type="int"/>
					<parameter name="embedding_level" type="int"/>
					<parameter name="logical_widths" type="int*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="pango_glyph_string_get_width">
				<return-type type="int"/>
				<parameters>
					<parameter name="glyphs" type="PangoGlyphString*"/>
				</parameters>
			</method>
			<method name="index_to_x" symbol="pango_glyph_string_index_to_x">
				<return-type type="void"/>
				<parameters>
					<parameter name="glyphs" type="PangoGlyphString*"/>
					<parameter name="text" type="char*"/>
					<parameter name="length" type="int"/>
					<parameter name="analysis" type="PangoAnalysis*"/>
					<parameter name="index_" type="int"/>
					<parameter name="trailing" type="gboolean"/>
					<parameter name="x_pos" type="int*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="pango_glyph_string_new">
				<return-type type="PangoGlyphString*"/>
			</constructor>
			<method name="set_size" symbol="pango_glyph_string_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="string" type="PangoGlyphString*"/>
					<parameter name="new_len" type="gint"/>
				</parameters>
			</method>
			<method name="x_to_index" symbol="pango_glyph_string_x_to_index">
				<return-type type="void"/>
				<parameters>
					<parameter name="glyphs" type="PangoGlyphString*"/>
					<parameter name="text" type="char*"/>
					<parameter name="length" type="int"/>
					<parameter name="analysis" type="PangoAnalysis*"/>
					<parameter name="x_pos" type="int"/>
					<parameter name="index_" type="int*"/>
					<parameter name="trailing" type="int*"/>
				</parameters>
			</method>
			<field name="num_glyphs" type="gint"/>
			<field name="glyphs" type="PangoGlyphInfo*"/>
			<field name="log_clusters" type="gint*"/>
			<field name="space" type="gint"/>
		</boxed>
		<boxed name="PangoItem" type-name="PangoItem" get-type="pango_item_get_type">
			<method name="copy" symbol="pango_item_copy">
				<return-type type="PangoItem*"/>
				<parameters>
					<parameter name="item" type="PangoItem*"/>
				</parameters>
			</method>
			<method name="free" symbol="pango_item_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="PangoItem*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="pango_item_new">
				<return-type type="PangoItem*"/>
			</constructor>
			<method name="split" symbol="pango_item_split">
				<return-type type="PangoItem*"/>
				<parameters>
					<parameter name="orig" type="PangoItem*"/>
					<parameter name="split_index" type="int"/>
					<parameter name="split_offset" type="int"/>
				</parameters>
			</method>
			<field name="offset" type="gint"/>
			<field name="length" type="gint"/>
			<field name="num_chars" type="gint"/>
			<field name="analysis" type="PangoAnalysis"/>
		</boxed>
		<boxed name="PangoLanguage" type-name="PangoLanguage" get-type="pango_language_get_type">
			<method name="from_string" symbol="pango_language_from_string">
				<return-type type="PangoLanguage*"/>
				<parameters>
					<parameter name="language" type="char*"/>
				</parameters>
			</method>
			<method name="get_default" symbol="pango_language_get_default">
				<return-type type="PangoLanguage*"/>
			</method>
			<method name="get_sample_string" symbol="pango_language_get_sample_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="language" type="PangoLanguage*"/>
				</parameters>
			</method>
			<method name="get_scripts" symbol="pango_language_get_scripts">
				<return-type type="PangoScript*"/>
				<parameters>
					<parameter name="language" type="PangoLanguage*"/>
					<parameter name="num_scripts" type="int*"/>
				</parameters>
			</method>
			<method name="includes_script" symbol="pango_language_includes_script">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="language" type="PangoLanguage*"/>
					<parameter name="script" type="PangoScript"/>
				</parameters>
			</method>
			<method name="matches" symbol="pango_language_matches">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="language" type="PangoLanguage*"/>
					<parameter name="range_list" type="char*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="pango_language_to_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="language" type="PangoLanguage*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="PangoLayoutIter" type-name="PangoLayoutIter" get-type="pango_layout_iter_get_type">
			<method name="at_last_line" symbol="pango_layout_iter_at_last_line">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="copy" symbol="pango_layout_iter_copy">
				<return-type type="PangoLayoutIter*"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="free" symbol="pango_layout_iter_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="get_baseline" symbol="pango_layout_iter_get_baseline">
				<return-type type="int"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="get_char_extents" symbol="pango_layout_iter_get_char_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="get_cluster_extents" symbol="pango_layout_iter_get_cluster_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="get_index" symbol="pango_layout_iter_get_index">
				<return-type type="int"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="get_layout" symbol="pango_layout_iter_get_layout">
				<return-type type="PangoLayout*"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="get_layout_extents" symbol="pango_layout_iter_get_layout_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="get_line" symbol="pango_layout_iter_get_line">
				<return-type type="PangoLayoutLine*"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="get_line_extents" symbol="pango_layout_iter_get_line_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="get_line_readonly" symbol="pango_layout_iter_get_line_readonly">
				<return-type type="PangoLayoutLine*"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="get_line_yrange" symbol="pango_layout_iter_get_line_yrange">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
					<parameter name="y0_" type="int*"/>
					<parameter name="y1_" type="int*"/>
				</parameters>
			</method>
			<method name="get_run" symbol="pango_layout_iter_get_run">
				<return-type type="PangoLayoutRun*"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="get_run_extents" symbol="pango_layout_iter_get_run_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="get_run_readonly" symbol="pango_layout_iter_get_run_readonly">
				<return-type type="PangoLayoutRun*"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="next_char" symbol="pango_layout_iter_next_char">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="next_cluster" symbol="pango_layout_iter_next_cluster">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="next_line" symbol="pango_layout_iter_next_line">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
			<method name="next_run" symbol="pango_layout_iter_next_run">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PangoLayoutIter*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="PangoLayoutLine" type-name="PangoLayoutLine" get-type="pango_layout_line_get_type">
			<method name="get_extents" symbol="pango_layout_line_get_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="line" type="PangoLayoutLine*"/>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="get_pixel_extents" symbol="pango_layout_line_get_pixel_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout_line" type="PangoLayoutLine*"/>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="get_x_ranges" symbol="pango_layout_line_get_x_ranges">
				<return-type type="void"/>
				<parameters>
					<parameter name="line" type="PangoLayoutLine*"/>
					<parameter name="start_index" type="int"/>
					<parameter name="end_index" type="int"/>
					<parameter name="ranges" type="int**"/>
					<parameter name="n_ranges" type="int*"/>
				</parameters>
			</method>
			<method name="index_to_x" symbol="pango_layout_line_index_to_x">
				<return-type type="void"/>
				<parameters>
					<parameter name="line" type="PangoLayoutLine*"/>
					<parameter name="index_" type="int"/>
					<parameter name="trailing" type="gboolean"/>
					<parameter name="x_pos" type="int*"/>
				</parameters>
			</method>
			<method name="ref" symbol="pango_layout_line_ref">
				<return-type type="PangoLayoutLine*"/>
				<parameters>
					<parameter name="line" type="PangoLayoutLine*"/>
				</parameters>
			</method>
			<method name="unref" symbol="pango_layout_line_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="line" type="PangoLayoutLine*"/>
				</parameters>
			</method>
			<method name="x_to_index" symbol="pango_layout_line_x_to_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="line" type="PangoLayoutLine*"/>
					<parameter name="x_pos" type="int"/>
					<parameter name="index_" type="int*"/>
					<parameter name="trailing" type="int*"/>
				</parameters>
			</method>
			<field name="layout" type="PangoLayout*"/>
			<field name="start_index" type="gint"/>
			<field name="length" type="gint"/>
			<field name="runs" type="GSList*"/>
			<field name="is_paragraph_start" type="guint"/>
			<field name="resolved_dir" type="guint"/>
		</boxed>
		<boxed name="PangoMatrix" type-name="PangoMatrix" get-type="pango_matrix_get_type">
			<method name="concat" symbol="pango_matrix_concat">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="PangoMatrix*"/>
					<parameter name="new_matrix" type="PangoMatrix*"/>
				</parameters>
			</method>
			<method name="copy" symbol="pango_matrix_copy">
				<return-type type="PangoMatrix*"/>
				<parameters>
					<parameter name="matrix" type="PangoMatrix*"/>
				</parameters>
			</method>
			<method name="free" symbol="pango_matrix_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="PangoMatrix*"/>
				</parameters>
			</method>
			<method name="get_font_scale_factor" symbol="pango_matrix_get_font_scale_factor">
				<return-type type="double"/>
				<parameters>
					<parameter name="matrix" type="PangoMatrix*"/>
				</parameters>
			</method>
			<method name="rotate" symbol="pango_matrix_rotate">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="PangoMatrix*"/>
					<parameter name="degrees" type="double"/>
				</parameters>
			</method>
			<method name="scale" symbol="pango_matrix_scale">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="PangoMatrix*"/>
					<parameter name="scale_x" type="double"/>
					<parameter name="scale_y" type="double"/>
				</parameters>
			</method>
			<method name="transform_distance" symbol="pango_matrix_transform_distance">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="PangoMatrix*"/>
					<parameter name="dx" type="double*"/>
					<parameter name="dy" type="double*"/>
				</parameters>
			</method>
			<method name="transform_pixel_rectangle" symbol="pango_matrix_transform_pixel_rectangle">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="PangoMatrix*"/>
					<parameter name="rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="transform_point" symbol="pango_matrix_transform_point">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="PangoMatrix*"/>
					<parameter name="x" type="double*"/>
					<parameter name="y" type="double*"/>
				</parameters>
			</method>
			<method name="transform_rectangle" symbol="pango_matrix_transform_rectangle">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="PangoMatrix*"/>
					<parameter name="rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="translate" symbol="pango_matrix_translate">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="PangoMatrix*"/>
					<parameter name="tx" type="double"/>
					<parameter name="ty" type="double"/>
				</parameters>
			</method>
			<field name="xx" type="double"/>
			<field name="xy" type="double"/>
			<field name="yx" type="double"/>
			<field name="yy" type="double"/>
			<field name="x0" type="double"/>
			<field name="y0" type="double"/>
		</boxed>
		<boxed name="PangoTabArray" type-name="PangoTabArray" get-type="pango_tab_array_get_type">
			<method name="copy" symbol="pango_tab_array_copy">
				<return-type type="PangoTabArray*"/>
				<parameters>
					<parameter name="src" type="PangoTabArray*"/>
				</parameters>
			</method>
			<method name="free" symbol="pango_tab_array_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="tab_array" type="PangoTabArray*"/>
				</parameters>
			</method>
			<method name="get_positions_in_pixels" symbol="pango_tab_array_get_positions_in_pixels">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="tab_array" type="PangoTabArray*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="pango_tab_array_get_size">
				<return-type type="gint"/>
				<parameters>
					<parameter name="tab_array" type="PangoTabArray*"/>
				</parameters>
			</method>
			<method name="get_tab" symbol="pango_tab_array_get_tab">
				<return-type type="void"/>
				<parameters>
					<parameter name="tab_array" type="PangoTabArray*"/>
					<parameter name="tab_index" type="gint"/>
					<parameter name="alignment" type="PangoTabAlign*"/>
					<parameter name="location" type="gint*"/>
				</parameters>
			</method>
			<method name="get_tabs" symbol="pango_tab_array_get_tabs">
				<return-type type="void"/>
				<parameters>
					<parameter name="tab_array" type="PangoTabArray*"/>
					<parameter name="alignments" type="PangoTabAlign**"/>
					<parameter name="locations" type="gint**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="pango_tab_array_new">
				<return-type type="PangoTabArray*"/>
				<parameters>
					<parameter name="initial_size" type="gint"/>
					<parameter name="positions_in_pixels" type="gboolean"/>
				</parameters>
			</constructor>
			<constructor name="new_with_positions" symbol="pango_tab_array_new_with_positions">
				<return-type type="PangoTabArray*"/>
				<parameters>
					<parameter name="size" type="gint"/>
					<parameter name="positions_in_pixels" type="gboolean"/>
					<parameter name="first_alignment" type="PangoTabAlign"/>
					<parameter name="first_position" type="gint"/>
				</parameters>
			</constructor>
			<method name="resize" symbol="pango_tab_array_resize">
				<return-type type="void"/>
				<parameters>
					<parameter name="tab_array" type="PangoTabArray*"/>
					<parameter name="new_size" type="gint"/>
				</parameters>
			</method>
			<method name="set_tab" symbol="pango_tab_array_set_tab">
				<return-type type="void"/>
				<parameters>
					<parameter name="tab_array" type="PangoTabArray*"/>
					<parameter name="tab_index" type="gint"/>
					<parameter name="alignment" type="PangoTabAlign"/>
					<parameter name="location" type="gint"/>
				</parameters>
			</method>
		</boxed>
		<enum name="PangoAlignment" type-name="PangoAlignment" get-type="pango_alignment_get_type">
			<member name="PANGO_ALIGN_LEFT" value="0"/>
			<member name="PANGO_ALIGN_CENTER" value="1"/>
			<member name="PANGO_ALIGN_RIGHT" value="2"/>
		</enum>
		<enum name="PangoAttrType" type-name="PangoAttrType" get-type="pango_attr_type_get_type">
			<member name="PANGO_ATTR_INVALID" value="0"/>
			<member name="PANGO_ATTR_LANGUAGE" value="1"/>
			<member name="PANGO_ATTR_FAMILY" value="2"/>
			<member name="PANGO_ATTR_STYLE" value="3"/>
			<member name="PANGO_ATTR_WEIGHT" value="4"/>
			<member name="PANGO_ATTR_VARIANT" value="5"/>
			<member name="PANGO_ATTR_STRETCH" value="6"/>
			<member name="PANGO_ATTR_SIZE" value="7"/>
			<member name="PANGO_ATTR_FONT_DESC" value="8"/>
			<member name="PANGO_ATTR_FOREGROUND" value="9"/>
			<member name="PANGO_ATTR_BACKGROUND" value="10"/>
			<member name="PANGO_ATTR_UNDERLINE" value="11"/>
			<member name="PANGO_ATTR_STRIKETHROUGH" value="12"/>
			<member name="PANGO_ATTR_RISE" value="13"/>
			<member name="PANGO_ATTR_SHAPE" value="14"/>
			<member name="PANGO_ATTR_SCALE" value="15"/>
			<member name="PANGO_ATTR_FALLBACK" value="16"/>
			<member name="PANGO_ATTR_LETTER_SPACING" value="17"/>
			<member name="PANGO_ATTR_UNDERLINE_COLOR" value="18"/>
			<member name="PANGO_ATTR_STRIKETHROUGH_COLOR" value="19"/>
			<member name="PANGO_ATTR_ABSOLUTE_SIZE" value="20"/>
			<member name="PANGO_ATTR_GRAVITY" value="21"/>
			<member name="PANGO_ATTR_GRAVITY_HINT" value="22"/>
		</enum>
		<enum name="PangoBidiType" type-name="PangoBidiType" get-type="pango_bidi_type_get_type">
			<member name="PANGO_BIDI_TYPE_L" value="0"/>
			<member name="PANGO_BIDI_TYPE_LRE" value="1"/>
			<member name="PANGO_BIDI_TYPE_LRO" value="2"/>
			<member name="PANGO_BIDI_TYPE_R" value="3"/>
			<member name="PANGO_BIDI_TYPE_AL" value="4"/>
			<member name="PANGO_BIDI_TYPE_RLE" value="5"/>
			<member name="PANGO_BIDI_TYPE_RLO" value="6"/>
			<member name="PANGO_BIDI_TYPE_PDF" value="7"/>
			<member name="PANGO_BIDI_TYPE_EN" value="8"/>
			<member name="PANGO_BIDI_TYPE_ES" value="9"/>
			<member name="PANGO_BIDI_TYPE_ET" value="10"/>
			<member name="PANGO_BIDI_TYPE_AN" value="11"/>
			<member name="PANGO_BIDI_TYPE_CS" value="12"/>
			<member name="PANGO_BIDI_TYPE_NSM" value="13"/>
			<member name="PANGO_BIDI_TYPE_BN" value="14"/>
			<member name="PANGO_BIDI_TYPE_B" value="15"/>
			<member name="PANGO_BIDI_TYPE_S" value="16"/>
			<member name="PANGO_BIDI_TYPE_WS" value="17"/>
			<member name="PANGO_BIDI_TYPE_ON" value="18"/>
		</enum>
		<enum name="PangoCoverageLevel" type-name="PangoCoverageLevel" get-type="pango_coverage_level_get_type">
			<member name="PANGO_COVERAGE_NONE" value="0"/>
			<member name="PANGO_COVERAGE_FALLBACK" value="1"/>
			<member name="PANGO_COVERAGE_APPROXIMATE" value="2"/>
			<member name="PANGO_COVERAGE_EXACT" value="3"/>
		</enum>
		<enum name="PangoDirection" type-name="PangoDirection" get-type="pango_direction_get_type">
			<member name="PANGO_DIRECTION_LTR" value="0"/>
			<member name="PANGO_DIRECTION_RTL" value="1"/>
			<member name="PANGO_DIRECTION_TTB_LTR" value="2"/>
			<member name="PANGO_DIRECTION_TTB_RTL" value="3"/>
			<member name="PANGO_DIRECTION_WEAK_LTR" value="4"/>
			<member name="PANGO_DIRECTION_WEAK_RTL" value="5"/>
			<member name="PANGO_DIRECTION_NEUTRAL" value="6"/>
		</enum>
		<enum name="PangoEllipsizeMode" type-name="PangoEllipsizeMode" get-type="pango_ellipsize_mode_get_type">
			<member name="PANGO_ELLIPSIZE_NONE" value="0"/>
			<member name="PANGO_ELLIPSIZE_START" value="1"/>
			<member name="PANGO_ELLIPSIZE_MIDDLE" value="2"/>
			<member name="PANGO_ELLIPSIZE_END" value="3"/>
		</enum>
		<enum name="PangoGravity" type-name="PangoGravity" get-type="pango_gravity_get_type">
			<member name="PANGO_GRAVITY_SOUTH" value="0"/>
			<member name="PANGO_GRAVITY_EAST" value="1"/>
			<member name="PANGO_GRAVITY_NORTH" value="2"/>
			<member name="PANGO_GRAVITY_WEST" value="3"/>
			<member name="PANGO_GRAVITY_AUTO" value="4"/>
		</enum>
		<enum name="PangoGravityHint" type-name="PangoGravityHint" get-type="pango_gravity_hint_get_type">
			<member name="PANGO_GRAVITY_HINT_NATURAL" value="0"/>
			<member name="PANGO_GRAVITY_HINT_STRONG" value="1"/>
			<member name="PANGO_GRAVITY_HINT_LINE" value="2"/>
		</enum>
		<enum name="PangoRenderPart" type-name="PangoRenderPart" get-type="pango_render_part_get_type">
			<member name="PANGO_RENDER_PART_FOREGROUND" value="0"/>
			<member name="PANGO_RENDER_PART_BACKGROUND" value="1"/>
			<member name="PANGO_RENDER_PART_UNDERLINE" value="2"/>
			<member name="PANGO_RENDER_PART_STRIKETHROUGH" value="3"/>
		</enum>
		<enum name="PangoScript" type-name="PangoScript" get-type="pango_script_get_type">
			<member name="PANGO_SCRIPT_INVALID_CODE" value="-1"/>
			<member name="PANGO_SCRIPT_COMMON" value="0"/>
			<member name="PANGO_SCRIPT_INHERITED" value="1"/>
			<member name="PANGO_SCRIPT_ARABIC" value="2"/>
			<member name="PANGO_SCRIPT_ARMENIAN" value="3"/>
			<member name="PANGO_SCRIPT_BENGALI" value="4"/>
			<member name="PANGO_SCRIPT_BOPOMOFO" value="5"/>
			<member name="PANGO_SCRIPT_CHEROKEE" value="6"/>
			<member name="PANGO_SCRIPT_COPTIC" value="7"/>
			<member name="PANGO_SCRIPT_CYRILLIC" value="8"/>
			<member name="PANGO_SCRIPT_DESERET" value="9"/>
			<member name="PANGO_SCRIPT_DEVANAGARI" value="10"/>
			<member name="PANGO_SCRIPT_ETHIOPIC" value="11"/>
			<member name="PANGO_SCRIPT_GEORGIAN" value="12"/>
			<member name="PANGO_SCRIPT_GOTHIC" value="13"/>
			<member name="PANGO_SCRIPT_GREEK" value="14"/>
			<member name="PANGO_SCRIPT_GUJARATI" value="15"/>
			<member name="PANGO_SCRIPT_GURMUKHI" value="16"/>
			<member name="PANGO_SCRIPT_HAN" value="17"/>
			<member name="PANGO_SCRIPT_HANGUL" value="18"/>
			<member name="PANGO_SCRIPT_HEBREW" value="19"/>
			<member name="PANGO_SCRIPT_HIRAGANA" value="20"/>
			<member name="PANGO_SCRIPT_KANNADA" value="21"/>
			<member name="PANGO_SCRIPT_KATAKANA" value="22"/>
			<member name="PANGO_SCRIPT_KHMER" value="23"/>
			<member name="PANGO_SCRIPT_LAO" value="24"/>
			<member name="PANGO_SCRIPT_LATIN" value="25"/>
			<member name="PANGO_SCRIPT_MALAYALAM" value="26"/>
			<member name="PANGO_SCRIPT_MONGOLIAN" value="27"/>
			<member name="PANGO_SCRIPT_MYANMAR" value="28"/>
			<member name="PANGO_SCRIPT_OGHAM" value="29"/>
			<member name="PANGO_SCRIPT_OLD_ITALIC" value="30"/>
			<member name="PANGO_SCRIPT_ORIYA" value="31"/>
			<member name="PANGO_SCRIPT_RUNIC" value="32"/>
			<member name="PANGO_SCRIPT_SINHALA" value="33"/>
			<member name="PANGO_SCRIPT_SYRIAC" value="34"/>
			<member name="PANGO_SCRIPT_TAMIL" value="35"/>
			<member name="PANGO_SCRIPT_TELUGU" value="36"/>
			<member name="PANGO_SCRIPT_THAANA" value="37"/>
			<member name="PANGO_SCRIPT_THAI" value="38"/>
			<member name="PANGO_SCRIPT_TIBETAN" value="39"/>
			<member name="PANGO_SCRIPT_CANADIAN_ABORIGINAL" value="40"/>
			<member name="PANGO_SCRIPT_YI" value="41"/>
			<member name="PANGO_SCRIPT_TAGALOG" value="42"/>
			<member name="PANGO_SCRIPT_HANUNOO" value="43"/>
			<member name="PANGO_SCRIPT_BUHID" value="44"/>
			<member name="PANGO_SCRIPT_TAGBANWA" value="45"/>
			<member name="PANGO_SCRIPT_BRAILLE" value="46"/>
			<member name="PANGO_SCRIPT_CYPRIOT" value="47"/>
			<member name="PANGO_SCRIPT_LIMBU" value="48"/>
			<member name="PANGO_SCRIPT_OSMANYA" value="49"/>
			<member name="PANGO_SCRIPT_SHAVIAN" value="50"/>
			<member name="PANGO_SCRIPT_LINEAR_B" value="51"/>
			<member name="PANGO_SCRIPT_TAI_LE" value="52"/>
			<member name="PANGO_SCRIPT_UGARITIC" value="53"/>
			<member name="PANGO_SCRIPT_NEW_TAI_LUE" value="54"/>
			<member name="PANGO_SCRIPT_BUGINESE" value="55"/>
			<member name="PANGO_SCRIPT_GLAGOLITIC" value="56"/>
			<member name="PANGO_SCRIPT_TIFINAGH" value="57"/>
			<member name="PANGO_SCRIPT_SYLOTI_NAGRI" value="58"/>
			<member name="PANGO_SCRIPT_OLD_PERSIAN" value="59"/>
			<member name="PANGO_SCRIPT_KHAROSHTHI" value="60"/>
			<member name="PANGO_SCRIPT_UNKNOWN" value="61"/>
			<member name="PANGO_SCRIPT_BALINESE" value="62"/>
			<member name="PANGO_SCRIPT_CUNEIFORM" value="63"/>
			<member name="PANGO_SCRIPT_PHOENICIAN" value="64"/>
			<member name="PANGO_SCRIPT_PHAGS_PA" value="65"/>
			<member name="PANGO_SCRIPT_NKO" value="66"/>
			<member name="PANGO_SCRIPT_KAYAH_LI" value="67"/>
			<member name="PANGO_SCRIPT_LEPCHA" value="68"/>
			<member name="PANGO_SCRIPT_REJANG" value="69"/>
			<member name="PANGO_SCRIPT_SUNDANESE" value="70"/>
			<member name="PANGO_SCRIPT_SAURASHTRA" value="71"/>
			<member name="PANGO_SCRIPT_CHAM" value="72"/>
			<member name="PANGO_SCRIPT_OL_CHIKI" value="73"/>
			<member name="PANGO_SCRIPT_VAI" value="74"/>
			<member name="PANGO_SCRIPT_CARIAN" value="75"/>
			<member name="PANGO_SCRIPT_LYCIAN" value="76"/>
			<member name="PANGO_SCRIPT_LYDIAN" value="77"/>
		</enum>
		<enum name="PangoStretch" type-name="PangoStretch" get-type="pango_stretch_get_type">
			<member name="PANGO_STRETCH_ULTRA_CONDENSED" value="0"/>
			<member name="PANGO_STRETCH_EXTRA_CONDENSED" value="1"/>
			<member name="PANGO_STRETCH_CONDENSED" value="2"/>
			<member name="PANGO_STRETCH_SEMI_CONDENSED" value="3"/>
			<member name="PANGO_STRETCH_NORMAL" value="4"/>
			<member name="PANGO_STRETCH_SEMI_EXPANDED" value="5"/>
			<member name="PANGO_STRETCH_EXPANDED" value="6"/>
			<member name="PANGO_STRETCH_EXTRA_EXPANDED" value="7"/>
			<member name="PANGO_STRETCH_ULTRA_EXPANDED" value="8"/>
		</enum>
		<enum name="PangoStyle" type-name="PangoStyle" get-type="pango_style_get_type">
			<member name="PANGO_STYLE_NORMAL" value="0"/>
			<member name="PANGO_STYLE_OBLIQUE" value="1"/>
			<member name="PANGO_STYLE_ITALIC" value="2"/>
		</enum>
		<enum name="PangoTabAlign" type-name="PangoTabAlign" get-type="pango_tab_align_get_type">
			<member name="PANGO_TAB_LEFT" value="0"/>
		</enum>
		<enum name="PangoUnderline" type-name="PangoUnderline" get-type="pango_underline_get_type">
			<member name="PANGO_UNDERLINE_NONE" value="0"/>
			<member name="PANGO_UNDERLINE_SINGLE" value="1"/>
			<member name="PANGO_UNDERLINE_DOUBLE" value="2"/>
			<member name="PANGO_UNDERLINE_LOW" value="3"/>
			<member name="PANGO_UNDERLINE_ERROR" value="4"/>
		</enum>
		<enum name="PangoVariant" type-name="PangoVariant" get-type="pango_variant_get_type">
			<member name="PANGO_VARIANT_NORMAL" value="0"/>
			<member name="PANGO_VARIANT_SMALL_CAPS" value="1"/>
		</enum>
		<enum name="PangoWeight" type-name="PangoWeight" get-type="pango_weight_get_type">
			<member name="PANGO_WEIGHT_THIN" value="100"/>
			<member name="PANGO_WEIGHT_ULTRALIGHT" value="200"/>
			<member name="PANGO_WEIGHT_LIGHT" value="300"/>
			<member name="PANGO_WEIGHT_BOOK" value="380"/>
			<member name="PANGO_WEIGHT_NORMAL" value="400"/>
			<member name="PANGO_WEIGHT_MEDIUM" value="500"/>
			<member name="PANGO_WEIGHT_SEMIBOLD" value="600"/>
			<member name="PANGO_WEIGHT_BOLD" value="700"/>
			<member name="PANGO_WEIGHT_ULTRABOLD" value="800"/>
			<member name="PANGO_WEIGHT_HEAVY" value="900"/>
			<member name="PANGO_WEIGHT_ULTRAHEAVY" value="1000"/>
		</enum>
		<enum name="PangoWrapMode" type-name="PangoWrapMode" get-type="pango_wrap_mode_get_type">
			<member name="PANGO_WRAP_WORD" value="0"/>
			<member name="PANGO_WRAP_CHAR" value="1"/>
			<member name="PANGO_WRAP_WORD_CHAR" value="2"/>
		</enum>
		<flags name="PangoFontMask" type-name="PangoFontMask" get-type="pango_font_mask_get_type">
			<member name="PANGO_FONT_MASK_FAMILY" value="1"/>
			<member name="PANGO_FONT_MASK_STYLE" value="2"/>
			<member name="PANGO_FONT_MASK_VARIANT" value="4"/>
			<member name="PANGO_FONT_MASK_WEIGHT" value="8"/>
			<member name="PANGO_FONT_MASK_STRETCH" value="16"/>
			<member name="PANGO_FONT_MASK_SIZE" value="32"/>
			<member name="PANGO_FONT_MASK_GRAVITY" value="64"/>
		</flags>
		<object name="PangoContext" parent="GObject" type-name="PangoContext" get-type="pango_context_get_type">
			<method name="get_base_dir" symbol="pango_context_get_base_dir">
				<return-type type="PangoDirection"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
				</parameters>
			</method>
			<method name="get_base_gravity" symbol="pango_context_get_base_gravity">
				<return-type type="PangoGravity"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
				</parameters>
			</method>
			<method name="get_font_description" symbol="pango_context_get_font_description">
				<return-type type="PangoFontDescription*"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
				</parameters>
			</method>
			<method name="get_font_map" symbol="pango_context_get_font_map">
				<return-type type="PangoFontMap*"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
				</parameters>
			</method>
			<method name="get_gravity" symbol="pango_context_get_gravity">
				<return-type type="PangoGravity"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
				</parameters>
			</method>
			<method name="get_gravity_hint" symbol="pango_context_get_gravity_hint">
				<return-type type="PangoGravityHint"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
				</parameters>
			</method>
			<method name="get_language" symbol="pango_context_get_language">
				<return-type type="PangoLanguage*"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
				</parameters>
			</method>
			<method name="get_matrix" symbol="pango_context_get_matrix">
				<return-type type="PangoMatrix*"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
				</parameters>
			</method>
			<method name="get_metrics" symbol="pango_context_get_metrics">
				<return-type type="PangoFontMetrics*"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="language" type="PangoLanguage*"/>
				</parameters>
			</method>
			<method name="list_families" symbol="pango_context_list_families">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="families" type="PangoFontFamily***"/>
					<parameter name="n_families" type="int*"/>
				</parameters>
			</method>
			<method name="load_font" symbol="pango_context_load_font">
				<return-type type="PangoFont*"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="load_fontset" symbol="pango_context_load_fontset">
				<return-type type="PangoFontset*"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="language" type="PangoLanguage*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="pango_context_new">
				<return-type type="PangoContext*"/>
			</constructor>
			<method name="set_base_dir" symbol="pango_context_set_base_dir">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="direction" type="PangoDirection"/>
				</parameters>
			</method>
			<method name="set_base_gravity" symbol="pango_context_set_base_gravity">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="gravity" type="PangoGravity"/>
				</parameters>
			</method>
			<method name="set_font_description" symbol="pango_context_set_font_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="set_font_map" symbol="pango_context_set_font_map">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="font_map" type="PangoFontMap*"/>
				</parameters>
			</method>
			<method name="set_gravity_hint" symbol="pango_context_set_gravity_hint">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="hint" type="PangoGravityHint"/>
				</parameters>
			</method>
			<method name="set_language" symbol="pango_context_set_language">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="language" type="PangoLanguage*"/>
				</parameters>
			</method>
			<method name="set_matrix" symbol="pango_context_set_matrix">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="matrix" type="PangoMatrix*"/>
				</parameters>
			</method>
		</object>
		<object name="PangoFont" parent="GObject" type-name="PangoFont" get-type="pango_font_get_type">
			<method name="describe" symbol="pango_font_describe">
				<return-type type="PangoFontDescription*"/>
				<parameters>
					<parameter name="font" type="PangoFont*"/>
				</parameters>
			</method>
			<method name="describe_with_absolute_size" symbol="pango_font_describe_with_absolute_size">
				<return-type type="PangoFontDescription*"/>
				<parameters>
					<parameter name="font" type="PangoFont*"/>
				</parameters>
			</method>
			<method name="descriptions_free" symbol="pango_font_descriptions_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="descs" type="PangoFontDescription**"/>
					<parameter name="n_descs" type="int"/>
				</parameters>
			</method>
			<method name="find_shaper" symbol="pango_font_find_shaper">
				<return-type type="PangoEngineShape*"/>
				<parameters>
					<parameter name="font" type="PangoFont*"/>
					<parameter name="language" type="PangoLanguage*"/>
					<parameter name="ch" type="guint32"/>
				</parameters>
			</method>
			<method name="get_coverage" symbol="pango_font_get_coverage">
				<return-type type="PangoCoverage*"/>
				<parameters>
					<parameter name="font" type="PangoFont*"/>
					<parameter name="language" type="PangoLanguage*"/>
				</parameters>
			</method>
			<method name="get_font_map" symbol="pango_font_get_font_map">
				<return-type type="PangoFontMap*"/>
				<parameters>
					<parameter name="font" type="PangoFont*"/>
				</parameters>
			</method>
			<method name="get_glyph_extents" symbol="pango_font_get_glyph_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="font" type="PangoFont*"/>
					<parameter name="glyph" type="PangoGlyph"/>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="get_metrics" symbol="pango_font_get_metrics">
				<return-type type="PangoFontMetrics*"/>
				<parameters>
					<parameter name="font" type="PangoFont*"/>
					<parameter name="language" type="PangoLanguage*"/>
				</parameters>
			</method>
		</object>
		<object name="PangoFontFace" parent="GObject" type-name="PangoFontFace" get-type="pango_font_face_get_type">
			<method name="describe" symbol="pango_font_face_describe">
				<return-type type="PangoFontDescription*"/>
				<parameters>
					<parameter name="face" type="PangoFontFace*"/>
				</parameters>
			</method>
			<method name="get_face_name" symbol="pango_font_face_get_face_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="face" type="PangoFontFace*"/>
				</parameters>
			</method>
			<method name="is_synthesized" symbol="pango_font_face_is_synthesized">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="face" type="PangoFontFace*"/>
				</parameters>
			</method>
			<method name="list_sizes" symbol="pango_font_face_list_sizes">
				<return-type type="void"/>
				<parameters>
					<parameter name="face" type="PangoFontFace*"/>
					<parameter name="sizes" type="int**"/>
					<parameter name="n_sizes" type="int*"/>
				</parameters>
			</method>
		</object>
		<object name="PangoFontFamily" parent="GObject" type-name="PangoFontFamily" get-type="pango_font_family_get_type">
			<method name="get_name" symbol="pango_font_family_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="family" type="PangoFontFamily*"/>
				</parameters>
			</method>
			<method name="is_monospace" symbol="pango_font_family_is_monospace">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="family" type="PangoFontFamily*"/>
				</parameters>
			</method>
			<method name="list_faces" symbol="pango_font_family_list_faces">
				<return-type type="void"/>
				<parameters>
					<parameter name="family" type="PangoFontFamily*"/>
					<parameter name="faces" type="PangoFontFace***"/>
					<parameter name="n_faces" type="int*"/>
				</parameters>
			</method>
		</object>
		<object name="PangoFontMap" parent="GObject" type-name="PangoFontMap" get-type="pango_font_map_get_type">
			<method name="create_context" symbol="pango_font_map_create_context">
				<return-type type="PangoContext*"/>
				<parameters>
					<parameter name="fontmap" type="PangoFontMap*"/>
				</parameters>
			</method>
			<method name="list_families" symbol="pango_font_map_list_families">
				<return-type type="void"/>
				<parameters>
					<parameter name="fontmap" type="PangoFontMap*"/>
					<parameter name="families" type="PangoFontFamily***"/>
					<parameter name="n_families" type="int*"/>
				</parameters>
			</method>
			<method name="load_font" symbol="pango_font_map_load_font">
				<return-type type="PangoFont*"/>
				<parameters>
					<parameter name="fontmap" type="PangoFontMap*"/>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="load_fontset" symbol="pango_font_map_load_fontset">
				<return-type type="PangoFontset*"/>
				<parameters>
					<parameter name="fontmap" type="PangoFontMap*"/>
					<parameter name="context" type="PangoContext*"/>
					<parameter name="desc" type="PangoFontDescription*"/>
					<parameter name="language" type="PangoLanguage*"/>
				</parameters>
			</method>
		</object>
		<object name="PangoFontset" parent="GObject" type-name="PangoFontset" get-type="pango_fontset_get_type">
			<method name="foreach" symbol="pango_fontset_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="fontset" type="PangoFontset*"/>
					<parameter name="func" type="PangoFontsetForeachFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_font" symbol="pango_fontset_get_font">
				<return-type type="PangoFont*"/>
				<parameters>
					<parameter name="fontset" type="PangoFontset*"/>
					<parameter name="wc" type="guint"/>
				</parameters>
			</method>
			<method name="get_metrics" symbol="pango_fontset_get_metrics">
				<return-type type="PangoFontMetrics*"/>
				<parameters>
					<parameter name="fontset" type="PangoFontset*"/>
				</parameters>
			</method>
		</object>
		<object name="PangoLayout" parent="GObject" type-name="PangoLayout" get-type="pango_layout_get_type">
			<method name="context_changed" symbol="pango_layout_context_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="copy" symbol="pango_layout_copy">
				<return-type type="PangoLayout*"/>
				<parameters>
					<parameter name="src" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_alignment" symbol="pango_layout_get_alignment">
				<return-type type="PangoAlignment"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_attributes" symbol="pango_layout_get_attributes">
				<return-type type="PangoAttrList*"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_auto_dir" symbol="pango_layout_get_auto_dir">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_baseline" symbol="pango_layout_get_baseline">
				<return-type type="int"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_context" symbol="pango_layout_get_context">
				<return-type type="PangoContext*"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_cursor_pos" symbol="pango_layout_get_cursor_pos">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="index_" type="int"/>
					<parameter name="strong_pos" type="PangoRectangle*"/>
					<parameter name="weak_pos" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="get_ellipsize" symbol="pango_layout_get_ellipsize">
				<return-type type="PangoEllipsizeMode"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_extents" symbol="pango_layout_get_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="get_font_description" symbol="pango_layout_get_font_description">
				<return-type type="PangoFontDescription*"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="pango_layout_get_height">
				<return-type type="int"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_indent" symbol="pango_layout_get_indent">
				<return-type type="int"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_iter" symbol="pango_layout_get_iter">
				<return-type type="PangoLayoutIter*"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_justify" symbol="pango_layout_get_justify">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_line" symbol="pango_layout_get_line">
				<return-type type="PangoLayoutLine*"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="line" type="int"/>
				</parameters>
			</method>
			<method name="get_line_count" symbol="pango_layout_get_line_count">
				<return-type type="int"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_line_readonly" symbol="pango_layout_get_line_readonly">
				<return-type type="PangoLayoutLine*"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="line" type="int"/>
				</parameters>
			</method>
			<method name="get_lines" symbol="pango_layout_get_lines">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_lines_readonly" symbol="pango_layout_get_lines_readonly">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_log_attrs" symbol="pango_layout_get_log_attrs">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="attrs" type="PangoLogAttr**"/>
					<parameter name="n_attrs" type="gint*"/>
				</parameters>
			</method>
			<method name="get_pixel_extents" symbol="pango_layout_get_pixel_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="ink_rect" type="PangoRectangle*"/>
					<parameter name="logical_rect" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="get_pixel_size" symbol="pango_layout_get_pixel_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="width" type="int*"/>
					<parameter name="height" type="int*"/>
				</parameters>
			</method>
			<method name="get_single_paragraph_mode" symbol="pango_layout_get_single_paragraph_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="pango_layout_get_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="width" type="int*"/>
					<parameter name="height" type="int*"/>
				</parameters>
			</method>
			<method name="get_spacing" symbol="pango_layout_get_spacing">
				<return-type type="int"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_tabs" symbol="pango_layout_get_tabs">
				<return-type type="PangoTabArray*"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="pango_layout_get_text">
				<return-type type="char*"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_unknown_glyphs_count" symbol="pango_layout_get_unknown_glyphs_count">
				<return-type type="int"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="pango_layout_get_width">
				<return-type type="int"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="get_wrap" symbol="pango_layout_get_wrap">
				<return-type type="PangoWrapMode"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="index_to_line_x" symbol="pango_layout_index_to_line_x">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="index_" type="int"/>
					<parameter name="trailing" type="gboolean"/>
					<parameter name="line" type="int*"/>
					<parameter name="x_pos" type="int*"/>
				</parameters>
			</method>
			<method name="index_to_pos" symbol="pango_layout_index_to_pos">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="index_" type="int"/>
					<parameter name="pos" type="PangoRectangle*"/>
				</parameters>
			</method>
			<method name="is_ellipsized" symbol="pango_layout_is_ellipsized">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="is_wrapped" symbol="pango_layout_is_wrapped">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
				</parameters>
			</method>
			<method name="move_cursor_visually" symbol="pango_layout_move_cursor_visually">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="strong" type="gboolean"/>
					<parameter name="old_index" type="int"/>
					<parameter name="old_trailing" type="int"/>
					<parameter name="direction" type="int"/>
					<parameter name="new_index" type="int*"/>
					<parameter name="new_trailing" type="int*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="pango_layout_new">
				<return-type type="PangoLayout*"/>
				<parameters>
					<parameter name="context" type="PangoContext*"/>
				</parameters>
			</constructor>
			<method name="set_alignment" symbol="pango_layout_set_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="alignment" type="PangoAlignment"/>
				</parameters>
			</method>
			<method name="set_attributes" symbol="pango_layout_set_attributes">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="attrs" type="PangoAttrList*"/>
				</parameters>
			</method>
			<method name="set_auto_dir" symbol="pango_layout_set_auto_dir">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="auto_dir" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_ellipsize" symbol="pango_layout_set_ellipsize">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="ellipsize" type="PangoEllipsizeMode"/>
				</parameters>
			</method>
			<method name="set_font_description" symbol="pango_layout_set_font_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="set_height" symbol="pango_layout_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="height" type="int"/>
				</parameters>
			</method>
			<method name="set_indent" symbol="pango_layout_set_indent">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="indent" type="int"/>
				</parameters>
			</method>
			<method name="set_justify" symbol="pango_layout_set_justify">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="justify" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_markup" symbol="pango_layout_set_markup">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="markup" type="char*"/>
					<parameter name="length" type="int"/>
				</parameters>
			</method>
			<method name="set_markup_with_accel" symbol="pango_layout_set_markup_with_accel">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="markup" type="char*"/>
					<parameter name="length" type="int"/>
					<parameter name="accel_marker" type="gunichar"/>
					<parameter name="accel_char" type="gunichar*"/>
				</parameters>
			</method>
			<method name="set_single_paragraph_mode" symbol="pango_layout_set_single_paragraph_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="setting" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_spacing" symbol="pango_layout_set_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="spacing" type="int"/>
				</parameters>
			</method>
			<method name="set_tabs" symbol="pango_layout_set_tabs">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="tabs" type="PangoTabArray*"/>
				</parameters>
			</method>
			<method name="set_text" symbol="pango_layout_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="text" type="char*"/>
					<parameter name="length" type="int"/>
				</parameters>
			</method>
			<method name="set_width" symbol="pango_layout_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="width" type="int"/>
				</parameters>
			</method>
			<method name="set_wrap" symbol="pango_layout_set_wrap">
				<return-type type="void"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="wrap" type="PangoWrapMode"/>
				</parameters>
			</method>
			<method name="xy_to_index" symbol="pango_layout_xy_to_index">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
					<parameter name="index_" type="int*"/>
					<parameter name="trailing" type="int*"/>
				</parameters>
			</method>
		</object>
		<object name="PangoRenderer" parent="GObject" type-name="PangoRenderer" get-type="pango_renderer_get_type">
			<method name="activate" symbol="pango_renderer_activate">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
				</parameters>
			</method>
			<method name="deactivate" symbol="pango_renderer_deactivate">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
				</parameters>
			</method>
			<method name="draw_error_underline" symbol="pango_renderer_draw_error_underline">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</method>
			<method name="draw_glyph" symbol="pango_renderer_draw_glyph">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="font" type="PangoFont*"/>
					<parameter name="glyph" type="PangoGlyph"/>
					<parameter name="x" type="double"/>
					<parameter name="y" type="double"/>
				</parameters>
			</method>
			<method name="draw_glyph_item" symbol="pango_renderer_draw_glyph_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="text" type="char*"/>
					<parameter name="glyph_item" type="PangoGlyphItem*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
				</parameters>
			</method>
			<method name="draw_glyphs" symbol="pango_renderer_draw_glyphs">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="font" type="PangoFont*"/>
					<parameter name="glyphs" type="PangoGlyphString*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
				</parameters>
			</method>
			<method name="draw_layout" symbol="pango_renderer_draw_layout">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="layout" type="PangoLayout*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
				</parameters>
			</method>
			<method name="draw_layout_line" symbol="pango_renderer_draw_layout_line">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="line" type="PangoLayoutLine*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
				</parameters>
			</method>
			<method name="draw_rectangle" symbol="pango_renderer_draw_rectangle">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="part" type="PangoRenderPart"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</method>
			<method name="draw_trapezoid" symbol="pango_renderer_draw_trapezoid">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="part" type="PangoRenderPart"/>
					<parameter name="y1_" type="double"/>
					<parameter name="x11" type="double"/>
					<parameter name="x21" type="double"/>
					<parameter name="y2" type="double"/>
					<parameter name="x12" type="double"/>
					<parameter name="x22" type="double"/>
				</parameters>
			</method>
			<method name="get_color" symbol="pango_renderer_get_color">
				<return-type type="PangoColor*"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="part" type="PangoRenderPart"/>
				</parameters>
			</method>
			<method name="get_layout" symbol="pango_renderer_get_layout">
				<return-type type="PangoLayout*"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
				</parameters>
			</method>
			<method name="get_layout_line" symbol="pango_renderer_get_layout_line">
				<return-type type="PangoLayoutLine*"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
				</parameters>
			</method>
			<method name="get_matrix" symbol="pango_renderer_get_matrix">
				<return-type type="PangoMatrix*"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
				</parameters>
			</method>
			<method name="part_changed" symbol="pango_renderer_part_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="part" type="PangoRenderPart"/>
				</parameters>
			</method>
			<method name="set_color" symbol="pango_renderer_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="part" type="PangoRenderPart"/>
					<parameter name="color" type="PangoColor*"/>
				</parameters>
			</method>
			<method name="set_matrix" symbol="pango_renderer_set_matrix">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="matrix" type="PangoMatrix*"/>
				</parameters>
			</method>
			<vfunc name="begin">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_error_underline">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_glyph">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="font" type="PangoFont*"/>
					<parameter name="glyph" type="PangoGlyph"/>
					<parameter name="x" type="double"/>
					<parameter name="y" type="double"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_glyph_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="text" type="char*"/>
					<parameter name="glyph_item" type="PangoGlyphItem*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_glyphs">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="font" type="PangoFont*"/>
					<parameter name="glyphs" type="PangoGlyphString*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_rectangle">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="part" type="PangoRenderPart"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_shape">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="attr" type="PangoAttrShape*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
				</parameters>
			</vfunc>
			<vfunc name="draw_trapezoid">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="part" type="PangoRenderPart"/>
					<parameter name="y1_" type="double"/>
					<parameter name="x11" type="double"/>
					<parameter name="x21" type="double"/>
					<parameter name="y2" type="double"/>
					<parameter name="x12" type="double"/>
					<parameter name="x22" type="double"/>
				</parameters>
			</vfunc>
			<vfunc name="end">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
				</parameters>
			</vfunc>
			<vfunc name="part_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="part" type="PangoRenderPart"/>
				</parameters>
			</vfunc>
			<vfunc name="prepare_run">
				<return-type type="void"/>
				<parameters>
					<parameter name="renderer" type="PangoRenderer*"/>
					<parameter name="run" type="PangoLayoutRun*"/>
				</parameters>
			</vfunc>
			<field name="underline" type="PangoUnderline"/>
			<field name="strikethrough" type="gboolean"/>
			<field name="active_count" type="int"/>
			<field name="matrix" type="PangoMatrix*"/>
		</object>
		<constant name="PANGO_ANALYSIS_FLAG_CENTERED_BASELINE" type="int" value="1"/>
		<constant name="PANGO_ATTR_INDEX_FROM_TEXT_BEGINNING" type="int" value="0"/>
		<constant name="PANGO_ENGINE_TYPE_LANG" type="char*" value="PangoEngineLang"/>
		<constant name="PANGO_ENGINE_TYPE_SHAPE" type="char*" value="PangoEngineShape"/>
		<constant name="PANGO_RENDER_TYPE_NONE" type="char*" value="PangoRenderNone"/>
		<constant name="PANGO_SCALE" type="int" value="1024"/>
		<constant name="PANGO_UNKNOWN_GLYPH_HEIGHT" type="int" value="14"/>
		<constant name="PANGO_UNKNOWN_GLYPH_WIDTH" type="int" value="10"/>
		<constant name="PANGO_VERSION_MAJOR" type="int" value="1"/>
		<constant name="PANGO_VERSION_MICRO" type="int" value="1"/>
		<constant name="PANGO_VERSION_MINOR" type="int" value="28"/>
		<constant name="PANGO_VERSION_STRING" type="char*" value="1.28.1"/>
	</namespace>
</api>
