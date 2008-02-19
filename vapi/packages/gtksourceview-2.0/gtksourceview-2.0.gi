<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gtk">
		<function name="source_iter_backward_search" symbol="gtk_source_iter_backward_search">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="iter" type="GtkTextIter*"/>
				<parameter name="str" type="gchar*"/>
				<parameter name="flags" type="GtkSourceSearchFlags"/>
				<parameter name="match_start" type="GtkTextIter*"/>
				<parameter name="match_end" type="GtkTextIter*"/>
				<parameter name="limit" type="GtkTextIter*"/>
			</parameters>
		</function>
		<function name="source_iter_forward_search" symbol="gtk_source_iter_forward_search">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="iter" type="GtkTextIter*"/>
				<parameter name="str" type="gchar*"/>
				<parameter name="flags" type="GtkSourceSearchFlags"/>
				<parameter name="match_start" type="GtkTextIter*"/>
				<parameter name="match_end" type="GtkTextIter*"/>
				<parameter name="limit" type="GtkTextIter*"/>
			</parameters>
		</function>
		<enum name="GtkSourceSmartHomeEndType">
			<member name="GTK_SOURCE_SMART_HOME_END_DISABLED" value="0"/>
			<member name="GTK_SOURCE_SMART_HOME_END_BEFORE" value="1"/>
			<member name="GTK_SOURCE_SMART_HOME_END_AFTER" value="2"/>
			<member name="GTK_SOURCE_SMART_HOME_END_ALWAYS" value="3"/>
		</enum>
		<flags name="GtkSourceSearchFlags">
			<member name="GTK_SOURCE_SEARCH_VISIBLE_ONLY" value="1"/>
			<member name="GTK_SOURCE_SEARCH_TEXT_ONLY" value="2"/>
			<member name="GTK_SOURCE_SEARCH_CASE_INSENSITIVE" value="4"/>
		</flags>
		<object name="GtkSourceBuffer" parent="GtkTextBuffer" type-name="GtkSourceBuffer" get-type="gtk_source_buffer_get_type">
			<method name="backward_iter_to_source_mark" symbol="gtk_source_buffer_backward_iter_to_source_mark">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="iter" type="GtkTextIter*"/>
					<parameter name="category" type="gchar*"/>
				</parameters>
			</method>
			<method name="begin_not_undoable_action" symbol="gtk_source_buffer_begin_not_undoable_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</method>
			<method name="can_redo" symbol="gtk_source_buffer_can_redo">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</method>
			<method name="can_undo" symbol="gtk_source_buffer_can_undo">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</method>
			<method name="create_source_mark" symbol="gtk_source_buffer_create_source_mark">
				<return-type type="GtkSourceMark*"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="category" type="gchar*"/>
					<parameter name="where" type="GtkTextIter*"/>
				</parameters>
			</method>
			<method name="end_not_undoable_action" symbol="gtk_source_buffer_end_not_undoable_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</method>
			<method name="ensure_highlight" symbol="gtk_source_buffer_ensure_highlight">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="start" type="GtkTextIter*"/>
					<parameter name="end" type="GtkTextIter*"/>
				</parameters>
			</method>
			<method name="forward_iter_to_source_mark" symbol="gtk_source_buffer_forward_iter_to_source_mark">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="iter" type="GtkTextIter*"/>
					<parameter name="category" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_highlight_matching_brackets" symbol="gtk_source_buffer_get_highlight_matching_brackets">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</method>
			<method name="get_highlight_syntax" symbol="gtk_source_buffer_get_highlight_syntax">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</method>
			<method name="get_language" symbol="gtk_source_buffer_get_language">
				<return-type type="GtkSourceLanguage*"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</method>
			<method name="get_max_undo_levels" symbol="gtk_source_buffer_get_max_undo_levels">
				<return-type type="gint"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</method>
			<method name="get_source_marks_at_iter" symbol="gtk_source_buffer_get_source_marks_at_iter">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="iter" type="GtkTextIter*"/>
					<parameter name="category" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_source_marks_at_line" symbol="gtk_source_buffer_get_source_marks_at_line">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="line" type="gint"/>
					<parameter name="category" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_style_scheme" symbol="gtk_source_buffer_get_style_scheme">
				<return-type type="GtkSourceStyleScheme*"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_source_buffer_new">
				<return-type type="GtkSourceBuffer*"/>
				<parameters>
					<parameter name="table" type="GtkTextTagTable*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_language" symbol="gtk_source_buffer_new_with_language">
				<return-type type="GtkSourceBuffer*"/>
				<parameters>
					<parameter name="language" type="GtkSourceLanguage*"/>
				</parameters>
			</constructor>
			<method name="redo" symbol="gtk_source_buffer_redo">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</method>
			<method name="remove_source_marks" symbol="gtk_source_buffer_remove_source_marks">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="start" type="GtkTextIter*"/>
					<parameter name="end" type="GtkTextIter*"/>
					<parameter name="category" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_highlight_matching_brackets" symbol="gtk_source_buffer_set_highlight_matching_brackets">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="highlight" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_highlight_syntax" symbol="gtk_source_buffer_set_highlight_syntax">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="highlight" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_language" symbol="gtk_source_buffer_set_language">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="language" type="GtkSourceLanguage*"/>
				</parameters>
			</method>
			<method name="set_max_undo_levels" symbol="gtk_source_buffer_set_max_undo_levels">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="max_undo_levels" type="gint"/>
				</parameters>
			</method>
			<method name="set_style_scheme" symbol="gtk_source_buffer_set_style_scheme">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="scheme" type="GtkSourceStyleScheme*"/>
				</parameters>
			</method>
			<method name="undo" symbol="gtk_source_buffer_undo">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</method>
			<property name="can-redo" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="can-undo" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="highlight-matching-brackets" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="highlight-syntax" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="language" type="GtkSourceLanguage*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-undo-levels" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="style-scheme" type="GtkSourceStyleScheme*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="highlight-updated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GtkSourceBuffer*"/>
					<parameter name="p0" type="GtkTextIter*"/>
					<parameter name="p1" type="GtkTextIter*"/>
				</parameters>
			</signal>
			<signal name="source-mark-updated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GtkSourceBuffer*"/>
					<parameter name="p0" type="GtkTextMark*"/>
				</parameters>
			</signal>
		</object>
		<object name="GtkSourceLanguage" parent="GObject" type-name="GtkSourceLanguage" get-type="gtk_source_language_get_type">
			<method name="get_globs" symbol="gtk_source_language_get_globs">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="language" type="GtkSourceLanguage*"/>
				</parameters>
			</method>
			<method name="get_hidden" symbol="gtk_source_language_get_hidden">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="language" type="GtkSourceLanguage*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gtk_source_language_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="language" type="GtkSourceLanguage*"/>
				</parameters>
			</method>
			<method name="get_metadata" symbol="gtk_source_language_get_metadata">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="language" type="GtkSourceLanguage*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_mime_types" symbol="gtk_source_language_get_mime_types">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="language" type="GtkSourceLanguage*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gtk_source_language_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="language" type="GtkSourceLanguage*"/>
				</parameters>
			</method>
			<method name="get_section" symbol="gtk_source_language_get_section">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="language" type="GtkSourceLanguage*"/>
				</parameters>
			</method>
			<method name="get_style_ids" symbol="gtk_source_language_get_style_ids">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="language" type="GtkSourceLanguage*"/>
				</parameters>
			</method>
			<method name="get_style_name" symbol="gtk_source_language_get_style_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="language" type="GtkSourceLanguage*"/>
					<parameter name="style_id" type="char*"/>
				</parameters>
			</method>
			<property name="hidden" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="section" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GtkSourceLanguageManager" parent="GObject" type-name="GtkSourceLanguageManager" get-type="gtk_source_language_manager_get_type">
			<method name="get_default" symbol="gtk_source_language_manager_get_default">
				<return-type type="GtkSourceLanguageManager*"/>
			</method>
			<method name="get_language" symbol="gtk_source_language_manager_get_language">
				<return-type type="GtkSourceLanguage*"/>
				<parameters>
					<parameter name="lm" type="GtkSourceLanguageManager*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_language_ids" symbol="gtk_source_language_manager_get_language_ids">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="lm" type="GtkSourceLanguageManager*"/>
				</parameters>
			</method>
			<method name="get_search_path" symbol="gtk_source_language_manager_get_search_path">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="lm" type="GtkSourceLanguageManager*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_source_language_manager_new">
				<return-type type="GtkSourceLanguageManager*"/>
			</constructor>
			<method name="set_search_path" symbol="gtk_source_language_manager_set_search_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="lm" type="GtkSourceLanguageManager*"/>
					<parameter name="dirs" type="gchar**"/>
				</parameters>
			</method>
			<property name="language-ids" type="char*[]" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="search-path" type="char*[]" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GtkSourceMark" parent="GtkTextMark" type-name="GtkSourceMark" get-type="gtk_source_mark_get_type">
			<method name="get_category" symbol="gtk_source_mark_get_category">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="mark" type="GtkSourceMark*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_source_mark_new">
				<return-type type="GtkSourceMark*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="category" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="next" symbol="gtk_source_mark_next">
				<return-type type="GtkSourceMark*"/>
				<parameters>
					<parameter name="mark" type="GtkSourceMark*"/>
					<parameter name="category" type="gchar*"/>
				</parameters>
			</method>
			<method name="prev" symbol="gtk_source_mark_prev">
				<return-type type="GtkSourceMark*"/>
				<parameters>
					<parameter name="mark" type="GtkSourceMark*"/>
					<parameter name="category" type="gchar*"/>
				</parameters>
			</method>
			<property name="category" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GtkSourcePrintCompositor" parent="GObject" type-name="GtkSourcePrintCompositor" get-type="gtk_source_print_compositor_get_type">
			<method name="draw_page" symbol="gtk_source_print_compositor_draw_page">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="context" type="GtkPrintContext*"/>
					<parameter name="page_nr" type="gint"/>
				</parameters>
			</method>
			<method name="get_body_font_name" symbol="gtk_source_print_compositor_get_body_font_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<method name="get_bottom_margin" symbol="gtk_source_print_compositor_get_bottom_margin">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="unit" type="GtkUnit"/>
				</parameters>
			</method>
			<method name="get_buffer" symbol="gtk_source_print_compositor_get_buffer">
				<return-type type="GtkSourceBuffer*"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<method name="get_footer_font_name" symbol="gtk_source_print_compositor_get_footer_font_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<method name="get_header_font_name" symbol="gtk_source_print_compositor_get_header_font_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<method name="get_highlight_syntax" symbol="gtk_source_print_compositor_get_highlight_syntax">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<method name="get_left_margin" symbol="gtk_source_print_compositor_get_left_margin">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="unit" type="GtkUnit"/>
				</parameters>
			</method>
			<method name="get_line_numbers_font_name" symbol="gtk_source_print_compositor_get_line_numbers_font_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<method name="get_n_pages" symbol="gtk_source_print_compositor_get_n_pages">
				<return-type type="gint"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<method name="get_pagination_progress" symbol="gtk_source_print_compositor_get_pagination_progress">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<method name="get_print_footer" symbol="gtk_source_print_compositor_get_print_footer">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<method name="get_print_header" symbol="gtk_source_print_compositor_get_print_header">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<method name="get_print_line_numbers" symbol="gtk_source_print_compositor_get_print_line_numbers">
				<return-type type="guint"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<method name="get_right_margin" symbol="gtk_source_print_compositor_get_right_margin">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="unit" type="GtkUnit"/>
				</parameters>
			</method>
			<method name="get_tab_width" symbol="gtk_source_print_compositor_get_tab_width">
				<return-type type="guint"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<method name="get_top_margin" symbol="gtk_source_print_compositor_get_top_margin">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="unit" type="GtkUnit"/>
				</parameters>
			</method>
			<method name="get_wrap_mode" symbol="gtk_source_print_compositor_get_wrap_mode">
				<return-type type="GtkWrapMode"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_source_print_compositor_new">
				<return-type type="GtkSourcePrintCompositor*"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_view" symbol="gtk_source_print_compositor_new_from_view">
				<return-type type="GtkSourcePrintCompositor*"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</constructor>
			<method name="paginate" symbol="gtk_source_print_compositor_paginate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="context" type="GtkPrintContext*"/>
				</parameters>
			</method>
			<method name="set_body_font_name" symbol="gtk_source_print_compositor_set_body_font_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="font_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_bottom_margin" symbol="gtk_source_print_compositor_set_bottom_margin">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="margin" type="gdouble"/>
					<parameter name="unit" type="GtkUnit"/>
				</parameters>
			</method>
			<method name="set_footer_font_name" symbol="gtk_source_print_compositor_set_footer_font_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="font_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_footer_format" symbol="gtk_source_print_compositor_set_footer_format">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="separator" type="gboolean"/>
					<parameter name="left" type="gchar*"/>
					<parameter name="center" type="gchar*"/>
					<parameter name="right" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_header_font_name" symbol="gtk_source_print_compositor_set_header_font_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="font_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_header_format" symbol="gtk_source_print_compositor_set_header_format">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="separator" type="gboolean"/>
					<parameter name="left" type="gchar*"/>
					<parameter name="center" type="gchar*"/>
					<parameter name="right" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_highlight_syntax" symbol="gtk_source_print_compositor_set_highlight_syntax">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="highlight" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_left_margin" symbol="gtk_source_print_compositor_set_left_margin">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="margin" type="gdouble"/>
					<parameter name="unit" type="GtkUnit"/>
				</parameters>
			</method>
			<method name="set_line_numbers_font_name" symbol="gtk_source_print_compositor_set_line_numbers_font_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="font_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_print_footer" symbol="gtk_source_print_compositor_set_print_footer">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="print" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_print_header" symbol="gtk_source_print_compositor_set_print_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="print" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_print_line_numbers" symbol="gtk_source_print_compositor_set_print_line_numbers">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="interval" type="guint"/>
				</parameters>
			</method>
			<method name="set_right_margin" symbol="gtk_source_print_compositor_set_right_margin">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="margin" type="gdouble"/>
					<parameter name="unit" type="GtkUnit"/>
				</parameters>
			</method>
			<method name="set_tab_width" symbol="gtk_source_print_compositor_set_tab_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="width" type="guint"/>
				</parameters>
			</method>
			<method name="set_top_margin" symbol="gtk_source_print_compositor_set_top_margin">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="margin" type="gdouble"/>
					<parameter name="unit" type="GtkUnit"/>
				</parameters>
			</method>
			<method name="set_wrap_mode" symbol="gtk_source_print_compositor_set_wrap_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="compositor" type="GtkSourcePrintCompositor*"/>
					<parameter name="wrap_mode" type="GtkWrapMode"/>
				</parameters>
			</method>
			<property name="body-font-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="buffer" type="GtkSourceBuffer*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="footer-font-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="header-font-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="highlight-syntax" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line-numbers-font-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="n-pages" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="print-footer" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="print-header" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="print-line-numbers" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="tab-width" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="wrap-mode" type="GtkWrapMode" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GtkSourceStyle" parent="GObject" type-name="GtkSourceStyle" get-type="gtk_source_style_get_type">
			<method name="copy" symbol="gtk_source_style_copy">
				<return-type type="GtkSourceStyle*"/>
				<parameters>
					<parameter name="style" type="GtkSourceStyle*"/>
				</parameters>
			</method>
			<property name="background" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="background-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="bold" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="bold-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="foreground" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="foreground-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="italic" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="italic-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="line-background" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="line-background-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="strikethrough" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="strikethrough-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="underline" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="underline-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GtkSourceStyleScheme" parent="GObject" type-name="GtkSourceStyleScheme" get-type="gtk_source_style_scheme_get_type">
			<method name="get_authors" symbol="gtk_source_style_scheme_get_authors">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="scheme" type="GtkSourceStyleScheme*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="gtk_source_style_scheme_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="scheme" type="GtkSourceStyleScheme*"/>
				</parameters>
			</method>
			<method name="get_filename" symbol="gtk_source_style_scheme_get_filename">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="scheme" type="GtkSourceStyleScheme*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gtk_source_style_scheme_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="scheme" type="GtkSourceStyleScheme*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gtk_source_style_scheme_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="scheme" type="GtkSourceStyleScheme*"/>
				</parameters>
			</method>
			<method name="get_style" symbol="gtk_source_style_scheme_get_style">
				<return-type type="GtkSourceStyle*"/>
				<parameters>
					<parameter name="scheme" type="GtkSourceStyleScheme*"/>
					<parameter name="style_id" type="gchar*"/>
				</parameters>
			</method>
			<property name="description" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="filename" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="id" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GtkSourceStyleSchemeManager" parent="GObject" type-name="GtkSourceStyleSchemeManager" get-type="gtk_source_style_scheme_manager_get_type">
			<method name="append_search_path" symbol="gtk_source_style_scheme_manager_append_search_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceStyleSchemeManager*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="force_rescan" symbol="gtk_source_style_scheme_manager_force_rescan">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceStyleSchemeManager*"/>
				</parameters>
			</method>
			<method name="get_default" symbol="gtk_source_style_scheme_manager_get_default">
				<return-type type="GtkSourceStyleSchemeManager*"/>
			</method>
			<method name="get_scheme" symbol="gtk_source_style_scheme_manager_get_scheme">
				<return-type type="GtkSourceStyleScheme*"/>
				<parameters>
					<parameter name="manager" type="GtkSourceStyleSchemeManager*"/>
					<parameter name="scheme_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_scheme_ids" symbol="gtk_source_style_scheme_manager_get_scheme_ids">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="manager" type="GtkSourceStyleSchemeManager*"/>
				</parameters>
			</method>
			<method name="get_search_path" symbol="gtk_source_style_scheme_manager_get_search_path">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="manager" type="GtkSourceStyleSchemeManager*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_source_style_scheme_manager_new">
				<return-type type="GtkSourceStyleSchemeManager*"/>
			</constructor>
			<method name="prepend_search_path" symbol="gtk_source_style_scheme_manager_prepend_search_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceStyleSchemeManager*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_search_path" symbol="gtk_source_style_scheme_manager_set_search_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceStyleSchemeManager*"/>
					<parameter name="path" type="gchar**"/>
				</parameters>
			</method>
			<property name="scheme-ids" type="char*[]" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="search-path" type="char*[]" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GtkSourceView" parent="GtkTextView" type-name="GtkSourceView" get-type="gtk_source_view_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_auto_indent" symbol="gtk_source_view_get_auto_indent">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<method name="get_highlight_current_line" symbol="gtk_source_view_get_highlight_current_line">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<method name="get_indent_on_tab" symbol="gtk_source_view_get_indent_on_tab">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<method name="get_indent_width" symbol="gtk_source_view_get_indent_width">
				<return-type type="gint"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<method name="get_insert_spaces_instead_of_tabs" symbol="gtk_source_view_get_insert_spaces_instead_of_tabs">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<method name="get_mark_category_pixbuf" symbol="gtk_source_view_get_mark_category_pixbuf">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="category" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_mark_category_priority" symbol="gtk_source_view_get_mark_category_priority">
				<return-type type="gint"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="category" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_right_margin_position" symbol="gtk_source_view_get_right_margin_position">
				<return-type type="guint"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<method name="get_show_line_marks" symbol="gtk_source_view_get_show_line_marks">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<method name="get_show_line_numbers" symbol="gtk_source_view_get_show_line_numbers">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<method name="get_show_right_margin" symbol="gtk_source_view_get_show_right_margin">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<method name="get_smart_home_end" symbol="gtk_source_view_get_smart_home_end">
				<return-type type="GtkSourceSmartHomeEndType"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<method name="get_tab_width" symbol="gtk_source_view_get_tab_width">
				<return-type type="guint"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_source_view_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_with_buffer" symbol="gtk_source_view_new_with_buffer">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</constructor>
			<method name="set_auto_indent" symbol="gtk_source_view_set_auto_indent">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="enable" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_highlight_current_line" symbol="gtk_source_view_set_highlight_current_line">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="show" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_indent_on_tab" symbol="gtk_source_view_set_indent_on_tab">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="enable" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_indent_width" symbol="gtk_source_view_set_indent_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="width" type="gint"/>
				</parameters>
			</method>
			<method name="set_insert_spaces_instead_of_tabs" symbol="gtk_source_view_set_insert_spaces_instead_of_tabs">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="enable" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_mark_category_pixbuf" symbol="gtk_source_view_set_mark_category_pixbuf">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="category" type="gchar*"/>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="set_mark_category_priority" symbol="gtk_source_view_set_mark_category_priority">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="category" type="gchar*"/>
					<parameter name="priority" type="gint"/>
				</parameters>
			</method>
			<method name="set_right_margin_position" symbol="gtk_source_view_set_right_margin_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="pos" type="guint"/>
				</parameters>
			</method>
			<method name="set_show_line_marks" symbol="gtk_source_view_set_show_line_marks">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="show" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_show_line_numbers" symbol="gtk_source_view_set_show_line_numbers">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="show" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_show_right_margin" symbol="gtk_source_view_set_show_right_margin">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="show" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_smart_home_end" symbol="gtk_source_view_set_smart_home_end">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="smart_he" type="GtkSourceSmartHomeEndType"/>
				</parameters>
			</method>
			<method name="set_tab_width" symbol="gtk_source_view_set_tab_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="width" type="guint"/>
				</parameters>
			</method>
			<property name="auto-indent" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="highlight-current-line" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="indent-on-tab" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="indent-width" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="insert-spaces-instead-of-tabs" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="right-margin-position" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-line-marks" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-line-numbers" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-right-margin" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="smart-home-end" type="GtkSourceSmartHomeEndType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="tab-width" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="redo" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</signal>
			<signal name="undo" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</signal>
		</object>
	</namespace>
</api>
