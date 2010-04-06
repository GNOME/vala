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
		<callback name="GtkSourceGutterDataFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="gutter" type="GtkSourceGutter*"/>
				<parameter name="cell" type="GtkCellRenderer*"/>
				<parameter name="line_number" type="gint"/>
				<parameter name="current_line" type="gboolean"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GtkSourceGutterSizeFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="gutter" type="GtkSourceGutter*"/>
				<parameter name="cell" type="GtkCellRenderer*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GtkSourceViewMarkTooltipFunc">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="mark" type="GtkSourceMark*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<enum name="GtkSourceCompletionError" type-name="GtkSourceCompletionError" get-type="gtk_source_completion_error_get_type">
			<member name="GTK_SOURCE_COMPLETION_ERROR_ALREADY_BOUND" value="0"/>
			<member name="GTK_SOURCE_COMPLETION_ERROR_NOT_BOUND" value="1"/>
		</enum>
		<enum name="GtkSourceSmartHomeEndType" type-name="GtkSourceSmartHomeEndType" get-type="gtk_source_smart_home_end_type_get_type">
			<member name="GTK_SOURCE_SMART_HOME_END_DISABLED" value="0"/>
			<member name="GTK_SOURCE_SMART_HOME_END_BEFORE" value="1"/>
			<member name="GTK_SOURCE_SMART_HOME_END_AFTER" value="2"/>
			<member name="GTK_SOURCE_SMART_HOME_END_ALWAYS" value="3"/>
		</enum>
		<enum name="GtkSourceViewGutterPosition" type-name="GtkSourceViewGutterPosition" get-type="gtk_source_view_gutter_position_get_type">
			<member name="GTK_SOURCE_VIEW_GUTTER_POSITION_LINES" value="-30"/>
			<member name="GTK_SOURCE_VIEW_GUTTER_POSITION_MARKS" value="-20"/>
		</enum>
		<flags name="GtkSourceCompletionActivation" type-name="GtkSourceCompletionActivation" get-type="gtk_source_completion_activation_get_type">
			<member name="GTK_SOURCE_COMPLETION_ACTIVATION_NONE" value="0"/>
			<member name="GTK_SOURCE_COMPLETION_ACTIVATION_INTERACTIVE" value="1"/>
			<member name="GTK_SOURCE_COMPLETION_ACTIVATION_USER_REQUESTED" value="2"/>
		</flags>
		<flags name="GtkSourceDrawSpacesFlags" type-name="GtkSourceDrawSpacesFlags" get-type="gtk_source_draw_spaces_flags_get_type">
			<member name="GTK_SOURCE_DRAW_SPACES_SPACE" value="1"/>
			<member name="GTK_SOURCE_DRAW_SPACES_TAB" value="2"/>
			<member name="GTK_SOURCE_DRAW_SPACES_NEWLINE" value="4"/>
			<member name="GTK_SOURCE_DRAW_SPACES_NBSP" value="8"/>
			<member name="GTK_SOURCE_DRAW_SPACES_LEADING" value="16"/>
			<member name="GTK_SOURCE_DRAW_SPACES_TEXT" value="32"/>
			<member name="GTK_SOURCE_DRAW_SPACES_TRAILING" value="64"/>
			<member name="GTK_SOURCE_DRAW_SPACES_ALL" value="127"/>
		</flags>
		<flags name="GtkSourceSearchFlags" type-name="GtkSourceSearchFlags" get-type="gtk_source_search_flags_get_type">
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
			<method name="get_context_classes_at_iter" symbol="gtk_source_buffer_get_context_classes_at_iter">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="iter" type="GtkTextIter*"/>
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
			<method name="get_undo_manager" symbol="gtk_source_buffer_get_undo_manager">
				<return-type type="GtkSourceUndoManager*"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</method>
			<method name="iter_backward_to_context_class_toggle" symbol="gtk_source_buffer_iter_backward_to_context_class_toggle">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="iter" type="GtkTextIter*"/>
					<parameter name="context_class" type="gchar*"/>
				</parameters>
			</method>
			<method name="iter_forward_to_context_class_toggle" symbol="gtk_source_buffer_iter_forward_to_context_class_toggle">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="iter" type="GtkTextIter*"/>
					<parameter name="context_class" type="gchar*"/>
				</parameters>
			</method>
			<method name="iter_has_context_class" symbol="gtk_source_buffer_iter_has_context_class">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="iter" type="GtkTextIter*"/>
					<parameter name="context_class" type="gchar*"/>
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
			<method name="set_undo_manager" symbol="gtk_source_buffer_set_undo_manager">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
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
			<property name="undo-manager" type="GtkSourceUndoManager*" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="highlight-updated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GtkSourceBuffer*"/>
					<parameter name="p0" type="GtkTextIter*"/>
					<parameter name="p1" type="GtkTextIter*"/>
				</parameters>
			</signal>
			<signal name="redo" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</signal>
			<signal name="source-mark-updated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GtkSourceBuffer*"/>
					<parameter name="p0" type="GtkTextMark*"/>
				</parameters>
			</signal>
			<signal name="undo" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="GtkSourceBuffer*"/>
				</parameters>
			</signal>
		</object>
		<object name="GtkSourceCompletion" parent="GtkObject" type-name="GtkSourceCompletion" get-type="gtk_source_completion_get_type">
			<method name="add_provider" symbol="gtk_source_completion_add_provider">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="block_interactive" symbol="gtk_source_completion_block_interactive">
				<return-type type="void"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
				</parameters>
			</method>
			<method name="create_context" symbol="gtk_source_completion_create_context">
				<return-type type="GtkSourceCompletionContext*"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
					<parameter name="position" type="GtkTextIter*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gtk_source_completion_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_info_window" symbol="gtk_source_completion_get_info_window">
				<return-type type="GtkSourceCompletionInfo*"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
				</parameters>
			</method>
			<method name="get_providers" symbol="gtk_source_completion_get_providers">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
				</parameters>
			</method>
			<method name="get_view" symbol="gtk_source_completion_get_view">
				<return-type type="struct _GtkSourceView*"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
				</parameters>
			</method>
			<method name="hide" symbol="gtk_source_completion_hide">
				<return-type type="void"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
				</parameters>
			</method>
			<method name="move_window" symbol="gtk_source_completion_move_window">
				<return-type type="void"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
					<parameter name="iter" type="GtkTextIter*"/>
				</parameters>
			</method>
			<method name="remove_provider" symbol="gtk_source_completion_remove_provider">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="show" symbol="gtk_source_completion_show">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
					<parameter name="providers" type="GList*"/>
					<parameter name="context" type="GtkSourceCompletionContext*"/>
				</parameters>
			</method>
			<method name="unblock_interactive" symbol="gtk_source_completion_unblock_interactive">
				<return-type type="void"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
				</parameters>
			</method>
			<property name="accelerators" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="auto-complete-delay" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="proposal-page-size" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="provider-page-size" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="remember-info-visibility" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="select-on-show" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="show-headers" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="show-icons" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="view" type="GtkSourceView*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="activate-proposal" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
				</parameters>
			</signal>
			<signal name="hide" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
				</parameters>
			</signal>
			<signal name="move-cursor" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
					<parameter name="step" type="GtkScrollStep"/>
					<parameter name="num" type="gint"/>
				</parameters>
			</signal>
			<signal name="move-page" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
					<parameter name="step" type="GtkScrollStep"/>
					<parameter name="num" type="gint"/>
				</parameters>
			</signal>
			<signal name="populate-context" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
					<parameter name="context" type="GtkSourceCompletionContext*"/>
				</parameters>
			</signal>
			<signal name="show" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
				</parameters>
			</signal>
			<vfunc name="proposal_activated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="completion" type="GtkSourceCompletion*"/>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GtkSourceCompletionContext" parent="GInitiallyUnowned" type-name="GtkSourceCompletionContext" get-type="gtk_source_completion_context_get_type">
			<method name="add_proposals" symbol="gtk_source_completion_context_add_proposals">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GtkSourceCompletionContext*"/>
					<parameter name="provider" type="struct _GtkSourceCompletionProvider*"/>
					<parameter name="proposals" type="GList*"/>
					<parameter name="finished" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_activation" symbol="gtk_source_completion_context_get_activation">
				<return-type type="GtkSourceCompletionActivation"/>
				<parameters>
					<parameter name="context" type="GtkSourceCompletionContext*"/>
				</parameters>
			</method>
			<method name="get_iter" symbol="gtk_source_completion_context_get_iter">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GtkSourceCompletionContext*"/>
					<parameter name="iter" type="GtkTextIter*"/>
				</parameters>
			</method>
			<property name="activation" type="GtkSourceCompletionActivation" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="completion" type="GtkSourceCompletion*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="iter" type="GtkTextIter*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="cancelled" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="GtkSourceCompletionContext*"/>
				</parameters>
			</signal>
		</object>
		<object name="GtkSourceCompletionInfo" parent="GtkWindow" type-name="GtkSourceCompletionInfo" get-type="gtk_source_completion_info_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_widget" symbol="gtk_source_completion_info_get_widget">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="info" type="GtkSourceCompletionInfo*"/>
				</parameters>
			</method>
			<method name="move_to_iter" symbol="gtk_source_completion_info_move_to_iter">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GtkSourceCompletionInfo*"/>
					<parameter name="view" type="GtkTextView*"/>
					<parameter name="iter" type="GtkTextIter*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_source_completion_info_new">
				<return-type type="GtkSourceCompletionInfo*"/>
			</constructor>
			<method name="process_resize" symbol="gtk_source_completion_info_process_resize">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GtkSourceCompletionInfo*"/>
				</parameters>
			</method>
			<method name="set_sizing" symbol="gtk_source_completion_info_set_sizing">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GtkSourceCompletionInfo*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="shrink_width" type="gboolean"/>
					<parameter name="shrink_height" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_widget" symbol="gtk_source_completion_info_set_widget">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GtkSourceCompletionInfo*"/>
					<parameter name="widget" type="GtkWidget*"/>
				</parameters>
			</method>
			<property name="max-height" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="max-width" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="shrink-height" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="shrink-width" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="before-show" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GtkSourceCompletionInfo*"/>
				</parameters>
			</signal>
		</object>
		<object name="GtkSourceCompletionItem" parent="GObject" type-name="GtkSourceCompletionItem" get-type="gtk_source_completion_item_get_type">
			<implements>
				<interface name="GtkSourceCompletionProposal"/>
			</implements>
			<constructor name="new" symbol="gtk_source_completion_item_new">
				<return-type type="GtkSourceCompletionItem*"/>
				<parameters>
					<parameter name="label" type="gchar*"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="icon" type="GdkPixbuf*"/>
					<parameter name="info" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_stock" symbol="gtk_source_completion_item_new_from_stock">
				<return-type type="GtkSourceCompletionItem*"/>
				<parameters>
					<parameter name="label" type="gchar*"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="stock" type="gchar*"/>
					<parameter name="info" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_markup" symbol="gtk_source_completion_item_new_with_markup">
				<return-type type="GtkSourceCompletionItem*"/>
				<parameters>
					<parameter name="markup" type="gchar*"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="icon" type="GdkPixbuf*"/>
					<parameter name="info" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="icon" type="GdkPixbuf*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="info" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="markup" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GtkSourceCompletionWords" parent="GObject" type-name="GtkSourceCompletionWords" get-type="gtk_source_completion_words_get_type">
			<implements>
				<interface name="GtkSourceCompletionProvider"/>
			</implements>
			<constructor name="new" symbol="gtk_source_completion_words_new">
				<return-type type="GtkSourceCompletionWords*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="icon" type="GdkPixbuf*"/>
				</parameters>
			</constructor>
			<method name="register" symbol="gtk_source_completion_words_register">
				<return-type type="void"/>
				<parameters>
					<parameter name="words" type="GtkSourceCompletionWords*"/>
					<parameter name="buffer" type="GtkTextBuffer*"/>
				</parameters>
			</method>
			<method name="unregister" symbol="gtk_source_completion_words_unregister">
				<return-type type="void"/>
				<parameters>
					<parameter name="words" type="GtkSourceCompletionWords*"/>
					<parameter name="buffer" type="GtkTextBuffer*"/>
				</parameters>
			</method>
			<property name="icon" type="GdkPixbuf*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="interactive-delay" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="minimum-word-size" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="priority" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="proposals-batch-size" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="scan-batch-size" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="GtkSourceGutter" parent="GObject" type-name="GtkSourceGutter" get-type="gtk_source_gutter_get_type">
			<method name="get_window" symbol="gtk_source_gutter_get_window">
				<return-type type="GdkWindow*"/>
				<parameters>
					<parameter name="gutter" type="GtkSourceGutter*"/>
				</parameters>
			</method>
			<method name="insert" symbol="gtk_source_gutter_insert">
				<return-type type="void"/>
				<parameters>
					<parameter name="gutter" type="GtkSourceGutter*"/>
					<parameter name="renderer" type="GtkCellRenderer*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</method>
			<method name="queue_draw" symbol="gtk_source_gutter_queue_draw">
				<return-type type="void"/>
				<parameters>
					<parameter name="gutter" type="GtkSourceGutter*"/>
				</parameters>
			</method>
			<method name="remove" symbol="gtk_source_gutter_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="gutter" type="GtkSourceGutter*"/>
					<parameter name="renderer" type="GtkCellRenderer*"/>
				</parameters>
			</method>
			<method name="reorder" symbol="gtk_source_gutter_reorder">
				<return-type type="void"/>
				<parameters>
					<parameter name="gutter" type="GtkSourceGutter*"/>
					<parameter name="renderer" type="GtkCellRenderer*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</method>
			<method name="set_cell_data_func" symbol="gtk_source_gutter_set_cell_data_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="gutter" type="GtkSourceGutter*"/>
					<parameter name="renderer" type="GtkCellRenderer*"/>
					<parameter name="func" type="GtkSourceGutterDataFunc"/>
					<parameter name="func_data" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_cell_size_func" symbol="gtk_source_gutter_set_cell_size_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="gutter" type="GtkSourceGutter*"/>
					<parameter name="renderer" type="GtkCellRenderer*"/>
					<parameter name="func" type="GtkSourceGutterSizeFunc"/>
					<parameter name="func_data" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<property name="view" type="GtkSourceView*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="window-type" type="GtkTextWindowType" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="cell-activated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="gutter" type="GtkSourceGutter*"/>
					<parameter name="renderer" type="GtkCellRenderer*"/>
					<parameter name="iter" type="GtkTextIter*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="query-tooltip" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="gutter" type="GtkSourceGutter*"/>
					<parameter name="renderer" type="GtkCellRenderer*"/>
					<parameter name="iter" type="GtkTextIter*"/>
					<parameter name="tooltip" type="GtkTooltip*"/>
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
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="language" type="GtkSourceLanguage*"/>
					<parameter name="style_id" type="gchar*"/>
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
			<method name="guess_language" symbol="gtk_source_language_manager_guess_language">
				<return-type type="GtkSourceLanguage*"/>
				<parameters>
					<parameter name="lm" type="GtkSourceLanguageManager*"/>
					<parameter name="filename" type="gchar*"/>
					<parameter name="content_type" type="gchar*"/>
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
			<property name="language-ids" type="GStrv*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="search-path" type="GStrv*" readable="1" writable="1" construct="0" construct-only="0"/>
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
			<property name="scheme-ids" type="GStrv*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="search-path" type="GStrv*" readable="1" writable="1" construct="0" construct-only="0"/>
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
			<method name="get_completion" symbol="gtk_source_view_get_completion">
				<return-type type="GtkSourceCompletion*"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<method name="get_draw_spaces" symbol="gtk_source_view_get_draw_spaces">
				<return-type type="GtkSourceDrawSpacesFlags"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</method>
			<method name="get_gutter" symbol="gtk_source_view_get_gutter">
				<return-type type="GtkSourceGutter*"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="window_type" type="GtkTextWindowType"/>
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
			<method name="get_mark_category_background" symbol="gtk_source_view_get_mark_category_background">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="category" type="gchar*"/>
					<parameter name="dest" type="GdkColor*"/>
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
			<method name="set_draw_spaces" symbol="gtk_source_view_set_draw_spaces">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="flags" type="GtkSourceDrawSpacesFlags"/>
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
			<method name="set_mark_category_background" symbol="gtk_source_view_set_mark_category_background">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="category" type="gchar*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_mark_category_icon_from_icon_name" symbol="gtk_source_view_set_mark_category_icon_from_icon_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="category" type="gchar*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_mark_category_icon_from_pixbuf" symbol="gtk_source_view_set_mark_category_icon_from_pixbuf">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="category" type="gchar*"/>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="set_mark_category_icon_from_stock" symbol="gtk_source_view_set_mark_category_icon_from_stock">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="category" type="gchar*"/>
					<parameter name="stock_id" type="gchar*"/>
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
			<method name="set_mark_category_tooltip_func" symbol="gtk_source_view_set_mark_category_tooltip_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="category" type="gchar*"/>
					<parameter name="func" type="GtkSourceViewMarkTooltipFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="user_data_notify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_mark_category_tooltip_markup_func" symbol="gtk_source_view_set_mark_category_tooltip_markup_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="category" type="gchar*"/>
					<parameter name="markup_func" type="GtkSourceViewMarkTooltipFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="user_data_notify" type="GDestroyNotify"/>
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
			<property name="completion" type="GtkSourceCompletion*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="draw-spaces" type="GtkSourceDrawSpacesFlags" readable="1" writable="1" construct="0" construct-only="0"/>
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
			<signal name="line-mark-activated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="iter" type="GtkTextIter*"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="move-lines" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
					<parameter name="copy" type="gboolean"/>
					<parameter name="step" type="gint"/>
				</parameters>
			</signal>
			<signal name="redo" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="view" type="GtkSourceView*"/>
				</parameters>
			</signal>
			<signal name="show-completion" when="LAST">
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
		<interface name="GtkSourceCompletionProposal" type-name="GtkSourceCompletionProposal" get-type="gtk_source_completion_proposal_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="changed" symbol="gtk_source_completion_proposal_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</method>
			<method name="equal" symbol="gtk_source_completion_proposal_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
					<parameter name="other" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gtk_source_completion_proposal_get_icon">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</method>
			<method name="get_info" symbol="gtk_source_completion_proposal_get_info">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="gtk_source_completion_proposal_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</method>
			<method name="get_markup" symbol="gtk_source_completion_proposal_get_markup">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="gtk_source_completion_proposal_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</method>
			<method name="hash" symbol="gtk_source_completion_proposal_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</signal>
			<vfunc name="equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
					<parameter name="other" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_icon">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_info">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_markup">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</vfunc>
			<vfunc name="hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GtkSourceCompletionProvider" type-name="GtkSourceCompletionProvider" get-type="gtk_source_completion_provider_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="activate_proposal" symbol="gtk_source_completion_provider_activate_proposal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
					<parameter name="iter" type="GtkTextIter*"/>
				</parameters>
			</method>
			<method name="get_activation" symbol="gtk_source_completion_provider_get_activation">
				<return-type type="GtkSourceCompletionActivation"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gtk_source_completion_provider_get_icon">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
				</parameters>
			</method>
			<method name="get_info_widget" symbol="gtk_source_completion_provider_get_info_widget">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</method>
			<method name="get_interactive_delay" symbol="gtk_source_completion_provider_get_interactive_delay">
				<return-type type="gint"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gtk_source_completion_provider_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
				</parameters>
			</method>
			<method name="get_priority" symbol="gtk_source_completion_provider_get_priority">
				<return-type type="gint"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
				</parameters>
			</method>
			<method name="get_start_iter" symbol="gtk_source_completion_provider_get_start_iter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="context" type="GtkSourceCompletionContext*"/>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
					<parameter name="iter" type="GtkTextIter*"/>
				</parameters>
			</method>
			<method name="match" symbol="gtk_source_completion_provider_match">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="context" type="GtkSourceCompletionContext*"/>
				</parameters>
			</method>
			<method name="populate" symbol="gtk_source_completion_provider_populate">
				<return-type type="void"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="context" type="GtkSourceCompletionContext*"/>
				</parameters>
			</method>
			<method name="update_info" symbol="gtk_source_completion_provider_update_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
					<parameter name="info" type="GtkSourceCompletionInfo*"/>
				</parameters>
			</method>
			<vfunc name="activate_proposal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
					<parameter name="iter" type="GtkTextIter*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_activation">
				<return-type type="GtkSourceCompletionActivation"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_icon">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_info_widget">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_interactive_delay">
				<return-type type="gint"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_priority">
				<return-type type="gint"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_start_iter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="context" type="GtkSourceCompletionContext*"/>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
					<parameter name="iter" type="GtkTextIter*"/>
				</parameters>
			</vfunc>
			<vfunc name="match">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="context" type="GtkSourceCompletionContext*"/>
				</parameters>
			</vfunc>
			<vfunc name="populate">
				<return-type type="void"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="context" type="GtkSourceCompletionContext*"/>
				</parameters>
			</vfunc>
			<vfunc name="update_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="provider" type="GtkSourceCompletionProvider*"/>
					<parameter name="proposal" type="GtkSourceCompletionProposal*"/>
					<parameter name="info" type="GtkSourceCompletionInfo*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GtkSourceUndoManager" type-name="GtkSourceUndoManager" get-type="gtk_source_undo_manager_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="begin_not_undoable_action" symbol="gtk_source_undo_manager_begin_not_undoable_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</method>
			<method name="can_redo" symbol="gtk_source_undo_manager_can_redo">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</method>
			<method name="can_redo_changed" symbol="gtk_source_undo_manager_can_redo_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</method>
			<method name="can_undo" symbol="gtk_source_undo_manager_can_undo">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</method>
			<method name="can_undo_changed" symbol="gtk_source_undo_manager_can_undo_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</method>
			<method name="end_not_undoable_action" symbol="gtk_source_undo_manager_end_not_undoable_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</method>
			<method name="redo" symbol="gtk_source_undo_manager_redo">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</method>
			<method name="undo" symbol="gtk_source_undo_manager_undo">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</method>
			<signal name="can-redo-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</signal>
			<signal name="can-undo-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</signal>
			<vfunc name="begin_not_undoable_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_redo">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_undo">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</vfunc>
			<vfunc name="end_not_undoable_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</vfunc>
			<vfunc name="redo">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</vfunc>
			<vfunc name="undo">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GtkSourceUndoManager*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="GTK_SOURCE_COMPLETION_CAPABILITY_AUTOMATIC" type="char*" value="standard::automatic"/>
		<constant name="GTK_SOURCE_COMPLETION_CAPABILITY_INTERACTIVE" type="char*" value="standard::interactive"/>
	</namespace>
</api>
