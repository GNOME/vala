<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Hildon">
		<function name="format_file_size_for_display" symbol="hildon_format_file_size_for_display">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="size" type="goffset"/>
			</parameters>
		</function>
		<function name="get_icon_pixel_size" symbol="hildon_get_icon_pixel_size">
			<return-type type="gint"/>
			<parameters>
				<parameter name="size" type="GtkIconSize"/>
			</parameters>
		</function>
		<function name="gtk_button_new" symbol="hildon_gtk_button_new">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="size" type="HildonSizeType"/>
			</parameters>
		</function>
		<function name="gtk_hscale_new" symbol="hildon_gtk_hscale_new">
			<return-type type="GtkWidget*"/>
		</function>
		<function name="gtk_icon_view_new" symbol="hildon_gtk_icon_view_new">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="mode" type="HildonUIMode"/>
			</parameters>
		</function>
		<function name="gtk_icon_view_new_with_model" symbol="hildon_gtk_icon_view_new_with_model">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="mode" type="HildonUIMode"/>
				<parameter name="model" type="GtkTreeModel*"/>
			</parameters>
		</function>
		<function name="gtk_icon_view_set_ui_mode" symbol="hildon_gtk_icon_view_set_ui_mode">
			<return-type type="void"/>
			<parameters>
				<parameter name="iconview" type="GtkIconView*"/>
				<parameter name="mode" type="HildonUIMode"/>
			</parameters>
		</function>
		<function name="gtk_init" symbol="hildon_gtk_init">
			<return-type type="void"/>
			<parameters>
				<parameter name="argc" type="int*"/>
				<parameter name="argv" type="char***"/>
			</parameters>
		</function>
		<function name="gtk_menu_new" symbol="hildon_gtk_menu_new">
			<return-type type="GtkWidget*"/>
		</function>
		<function name="gtk_radio_button_new" symbol="hildon_gtk_radio_button_new">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="size" type="HildonSizeType"/>
				<parameter name="group" type="GSList*"/>
			</parameters>
		</function>
		<function name="gtk_radio_button_new_from_widget" symbol="hildon_gtk_radio_button_new_from_widget">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="size" type="HildonSizeType"/>
				<parameter name="radio_group_member" type="GtkRadioButton*"/>
			</parameters>
		</function>
		<function name="gtk_toggle_button_new" symbol="hildon_gtk_toggle_button_new">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="size" type="HildonSizeType"/>
			</parameters>
		</function>
		<function name="gtk_tree_view_new" symbol="hildon_gtk_tree_view_new">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="mode" type="HildonUIMode"/>
			</parameters>
		</function>
		<function name="gtk_tree_view_new_with_model" symbol="hildon_gtk_tree_view_new_with_model">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="mode" type="HildonUIMode"/>
				<parameter name="model" type="GtkTreeModel*"/>
			</parameters>
		</function>
		<function name="gtk_tree_view_set_ui_mode" symbol="hildon_gtk_tree_view_set_ui_mode">
			<return-type type="void"/>
			<parameters>
				<parameter name="treeview" type="GtkTreeView*"/>
				<parameter name="mode" type="HildonUIMode"/>
			</parameters>
		</function>
		<function name="gtk_vscale_new" symbol="hildon_gtk_vscale_new">
			<return-type type="GtkWidget*"/>
		</function>
		<function name="gtk_window_set_do_not_disturb" symbol="hildon_gtk_window_set_do_not_disturb">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GtkWindow*"/>
				<parameter name="dndflag" type="gboolean"/>
			</parameters>
		</function>
		<function name="gtk_window_set_portrait_flags" symbol="hildon_gtk_window_set_portrait_flags">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GtkWindow*"/>
				<parameter name="portrait_flags" type="HildonPortraitFlags"/>
			</parameters>
		</function>
		<function name="gtk_window_set_progress_indicator" symbol="hildon_gtk_window_set_progress_indicator">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GtkWindow*"/>
				<parameter name="state" type="guint"/>
			</parameters>
		</function>
		<function name="gtk_window_take_screenshot" symbol="hildon_gtk_window_take_screenshot">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GtkWindow*"/>
				<parameter name="take" type="gboolean"/>
			</parameters>
		</function>
		<function name="helper_event_button_is_finger" symbol="hildon_helper_event_button_is_finger">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="event" type="GdkEventButton*"/>
			</parameters>
		</function>
		<function name="helper_set_insensitive_message" symbol="hildon_helper_set_insensitive_message">
			<return-type type="void"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="message" type="gchar*"/>
			</parameters>
		</function>
		<function name="helper_set_insensitive_messagef" symbol="hildon_helper_set_insensitive_messagef">
			<return-type type="void"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="format" type="gchar*"/>
			</parameters>
		</function>
		<function name="helper_set_logical_color" symbol="hildon_helper_set_logical_color">
			<return-type type="gulong"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="rcflags" type="GtkRcFlags"/>
				<parameter name="state" type="GtkStateType"/>
				<parameter name="logicalcolorname" type="gchar*"/>
			</parameters>
		</function>
		<function name="helper_set_logical_font" symbol="hildon_helper_set_logical_font">
			<return-type type="gulong"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="logicalfontname" type="gchar*"/>
			</parameters>
		</function>
		<function name="helper_set_thumb_scrollbar" symbol="hildon_helper_set_thumb_scrollbar">
			<return-type type="void"/>
			<parameters>
				<parameter name="win" type="GtkScrolledWindow*"/>
				<parameter name="thumb" type="gboolean"/>
			</parameters>
		</function>
		<function name="init" symbol="hildon_init">
			<return-type type="void"/>
		</function>
		<function name="pannable_get_child_widget_at" symbol="hildon_pannable_get_child_widget_at">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="area" type="HildonPannableArea*"/>
				<parameter name="x" type="gdouble"/>
				<parameter name="y" type="gdouble"/>
			</parameters>
		</function>
		<function name="play_system_sound" symbol="hildon_play_system_sound">
			<return-type type="void"/>
			<parameters>
				<parameter name="sample" type="gchar*"/>
			</parameters>
		</function>
		<callback name="HildonTouchSelectorPrintFunc">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="selector" type="HildonTouchSelector*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="HildonWizardDialogPageFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="notebook" type="GtkNotebook*"/>
				<parameter name="current_page" type="gint"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<enum name="HildonButtonArrangement" type-name="HildonButtonArrangement" get-type="hildon_button_arrangement_get_type">
			<member name="HILDON_BUTTON_ARRANGEMENT_HORIZONTAL" value="0"/>
			<member name="HILDON_BUTTON_ARRANGEMENT_VERTICAL" value="1"/>
		</enum>
		<enum name="HildonButtonStyle" type-name="HildonButtonStyle" get-type="hildon_button_style_get_type">
			<member name="HILDON_BUTTON_STYLE_NORMAL" value="0"/>
			<member name="HILDON_BUTTON_STYLE_PICKER" value="1"/>
		</enum>
		<enum name="HildonCaptionIconPosition" type-name="HildonCaptionIconPosition" get-type="hildon_caption_icon_position_get_type">
			<member name="HILDON_CAPTION_POSITION_LEFT" value="0"/>
			<member name="HILDON_CAPTION_POSITION_RIGHT" value="1"/>
		</enum>
		<enum name="HildonCaptionStatus" type-name="HildonCaptionStatus" get-type="hildon_caption_status_get_type">
			<member name="HILDON_CAPTION_OPTIONAL" value="0"/>
			<member name="HILDON_CAPTION_MANDATORY" value="1"/>
		</enum>
		<enum name="HildonDateTimeError" type-name="HildonDateTimeError" get-type="hildon_date_time_error_get_type">
			<member name="HILDON_DATE_TIME_ERROR_NO_ERROR" value="-1"/>
			<member name="HILDON_DATE_TIME_ERROR_MAX_HOURS" value="0"/>
			<member name="HILDON_DATE_TIME_ERROR_MAX_MINS" value="1"/>
			<member name="HILDON_DATE_TIME_ERROR_MAX_SECS" value="2"/>
			<member name="HILDON_DATE_TIME_ERROR_MAX_DAY" value="3"/>
			<member name="HILDON_DATE_TIME_ERROR_MAX_MONTH" value="4"/>
			<member name="HILDON_DATE_TIME_ERROR_MAX_YEAR" value="5"/>
			<member name="HILDON_DATE_TIME_ERROR_MIN_HOURS" value="6"/>
			<member name="HILDON_DATE_TIME_ERROR_MIN_MINS" value="7"/>
			<member name="HILDON_DATE_TIME_ERROR_MIN_SECS" value="8"/>
			<member name="HILDON_DATE_TIME_ERROR_MIN_DAY" value="9"/>
			<member name="HILDON_DATE_TIME_ERROR_MIN_MONTH" value="10"/>
			<member name="HILDON_DATE_TIME_ERROR_MIN_YEAR" value="11"/>
			<member name="HILDON_DATE_TIME_ERROR_EMPTY_HOURS" value="12"/>
			<member name="HILDON_DATE_TIME_ERROR_EMPTY_MINS" value="13"/>
			<member name="HILDON_DATE_TIME_ERROR_EMPTY_SECS" value="14"/>
			<member name="HILDON_DATE_TIME_ERROR_EMPTY_DAY" value="15"/>
			<member name="HILDON_DATE_TIME_ERROR_EMPTY_MONTH" value="16"/>
			<member name="HILDON_DATE_TIME_ERROR_EMPTY_YEAR" value="17"/>
			<member name="HILDON_DATE_TIME_ERROR_MIN_DURATION" value="18"/>
			<member name="HILDON_DATE_TIME_ERROR_MAX_DURATION" value="19"/>
			<member name="HILDON_DATE_TIME_ERROR_INVALID_CHAR" value="20"/>
			<member name="HILDON_DATE_TIME_ERROR_INVALID_DATE" value="21"/>
			<member name="HILDON_DATE_TIME_ERROR_INVALID_TIME" value="22"/>
		</enum>
		<enum name="HildonMovementDirection" type-name="HildonMovementDirection" get-type="hildon_movement_direction_get_type">
			<member name="HILDON_MOVEMENT_UP" value="0"/>
			<member name="HILDON_MOVEMENT_DOWN" value="1"/>
			<member name="HILDON_MOVEMENT_LEFT" value="2"/>
			<member name="HILDON_MOVEMENT_RIGHT" value="3"/>
		</enum>
		<enum name="HildonNoteType" type-name="HildonNoteType" get-type="hildon_note_type_get_type">
			<member name="HILDON_NOTE_TYPE_CONFIRMATION" value="0"/>
			<member name="HILDON_NOTE_TYPE_CONFIRMATION_BUTTON" value="1"/>
			<member name="HILDON_NOTE_TYPE_INFORMATION" value="2"/>
			<member name="HILDON_NOTE_TYPE_INFORMATION_THEME" value="3"/>
			<member name="HILDON_NOTE_TYPE_PROGRESSBAR" value="4"/>
		</enum>
		<enum name="HildonNumberEditorErrorType" type-name="HildonNumberEditorErrorType" get-type="hildon_number_editor_error_type_get_type">
			<member name="HILDON_NUMBER_EDITOR_ERROR_MAXIMUM_VALUE_EXCEED" value="0"/>
			<member name="HILDON_NUMBER_EDITOR_ERROR_MINIMUM_VALUE_EXCEED" value="1"/>
			<member name="HILDON_NUMBER_EDITOR_ERROR_ERRONEOUS_VALUE" value="2"/>
		</enum>
		<enum name="HildonPannableAreaMode" type-name="HildonPannableAreaMode" get-type="hildon_pannable_area_mode_get_type">
			<member name="HILDON_PANNABLE_AREA_MODE_PUSH" value="0"/>
			<member name="HILDON_PANNABLE_AREA_MODE_ACCEL" value="1"/>
			<member name="HILDON_PANNABLE_AREA_MODE_AUTO" value="2"/>
		</enum>
		<enum name="HildonSizeRequestPolicy" type-name="HildonSizeRequestPolicy" get-type="hildon_size_request_policy_get_type">
			<member name="HILDON_SIZE_REQUEST_MINIMUM" value="0"/>
			<member name="HILDON_SIZE_REQUEST_CHILDREN" value="1"/>
		</enum>
		<enum name="HildonTimeSelectorFormatPolicy" type-name="HildonTimeSelectorFormatPolicy" get-type="hildon_time_selector_format_policy_get_type">
			<member name="HILDON_TIME_SELECTOR_FORMAT_POLICY_AMPM" value="0"/>
			<member name="HILDON_TIME_SELECTOR_FORMAT_POLICY_24H" value="1"/>
			<member name="HILDON_TIME_SELECTOR_FORMAT_POLICY_AUTOMATIC" value="2"/>
		</enum>
		<enum name="HildonTouchSelectorSelectionMode" type-name="HildonTouchSelectorSelectionMode" get-type="hildon_touch_selector_selection_mode_get_type">
			<member name="HILDON_TOUCH_SELECTOR_SELECTION_MODE_SINGLE" value="0"/>
			<member name="HILDON_TOUCH_SELECTOR_SELECTION_MODE_MULTIPLE" value="1"/>
		</enum>
		<enum name="HildonWindowClipboardOperation" type-name="HildonWindowClipboardOperation" get-type="hildon_window_clipboard_operation_get_type">
			<member name="HILDON_WINDOW_CO_COPY" value="0"/>
			<member name="HILDON_WINDOW_CO_CUT" value="1"/>
			<member name="HILDON_WINDOW_CO_PASTE" value="2"/>
		</enum>
		<enum name="HildonWizardDialogResponse" type-name="HildonWizardDialogResponse" get-type="hildon_wizard_dialog_response_get_type">
			<member name="HILDON_WIZARD_DIALOG_CANCEL" value="-6"/>
			<member name="HILDON_WIZARD_DIALOG_PREVIOUS" value="0"/>
			<member name="HILDON_WIZARD_DIALOG_NEXT" value="1"/>
			<member name="HILDON_WIZARD_DIALOG_FINISH" value="2"/>
		</enum>
		<flags name="HildonCalendarDisplayOptions" type-name="HildonCalendarDisplayOptions" get-type="hildon_calendar_display_options_get_type">
			<member name="HILDON_CALENDAR_SHOW_HEADING" value="1"/>
			<member name="HILDON_CALENDAR_SHOW_DAY_NAMES" value="2"/>
			<member name="HILDON_CALENDAR_NO_MONTH_CHANGE" value="4"/>
			<member name="HILDON_CALENDAR_SHOW_WEEK_NUMBERS" value="8"/>
			<member name="HILDON_CALENDAR_WEEK_START_MONDAY" value="16"/>
		</flags>
		<flags name="HildonMovementMode" type-name="HildonMovementMode" get-type="hildon_movement_mode_get_type">
			<member name="HILDON_MOVEMENT_MODE_HORIZ" value="2"/>
			<member name="HILDON_MOVEMENT_MODE_VERT" value="4"/>
			<member name="HILDON_MOVEMENT_MODE_BOTH" value="6"/>
		</flags>
		<flags name="HildonPortraitFlags" type-name="HildonPortraitFlags" get-type="hildon_portrait_flags_get_type">
			<member name="HILDON_PORTRAIT_MODE_REQUEST" value="1"/>
			<member name="HILDON_PORTRAIT_MODE_SUPPORT" value="2"/>
		</flags>
		<object name="HildonAnimationActor" parent="GtkWindow" type-name="HildonAnimationActor" get-type="hildon_animation_actor_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="hildon_animation_actor_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="send_message" symbol="hildon_animation_actor_send_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="message_type" type="guint32"/>
					<parameter name="l0" type="guint32"/>
					<parameter name="l1" type="guint32"/>
					<parameter name="l2" type="guint32"/>
					<parameter name="l3" type="guint32"/>
					<parameter name="l4" type="guint32"/>
				</parameters>
			</method>
			<method name="set_anchor" symbol="hildon_animation_actor_set_anchor">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="set_anchor_from_gravity" symbol="hildon_animation_actor_set_anchor_from_gravity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="gravity" type="guint"/>
				</parameters>
			</method>
			<method name="set_depth" symbol="hildon_animation_actor_set_depth">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="depth" type="gint"/>
				</parameters>
			</method>
			<method name="set_opacity" symbol="hildon_animation_actor_set_opacity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="opacity" type="gint"/>
				</parameters>
			</method>
			<method name="set_parent" symbol="hildon_animation_actor_set_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="parent" type="GtkWindow*"/>
				</parameters>
			</method>
			<method name="set_position" symbol="hildon_animation_actor_set_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="set_position_full" symbol="hildon_animation_actor_set_position_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="depth" type="gint"/>
				</parameters>
			</method>
			<method name="set_rotation" symbol="hildon_animation_actor_set_rotation">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="axis" type="gint"/>
					<parameter name="degrees" type="double"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="z" type="gint"/>
				</parameters>
			</method>
			<method name="set_rotationx" symbol="hildon_animation_actor_set_rotationx">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="axis" type="gint"/>
					<parameter name="degrees" type="gint32"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="z" type="gint"/>
				</parameters>
			</method>
			<method name="set_scale" symbol="hildon_animation_actor_set_scale">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="x_scale" type="double"/>
					<parameter name="y_scale" type="double"/>
				</parameters>
			</method>
			<method name="set_scalex" symbol="hildon_animation_actor_set_scalex">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="x_scale" type="gint32"/>
					<parameter name="y_scale" type="gint32"/>
				</parameters>
			</method>
			<method name="set_show" symbol="hildon_animation_actor_set_show">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="show" type="gint"/>
				</parameters>
			</method>
			<method name="set_show_full" symbol="hildon_animation_actor_set_show_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonAnimationActor*"/>
					<parameter name="show" type="gint"/>
					<parameter name="opacity" type="gint"/>
				</parameters>
			</method>
		</object>
		<object name="HildonAppMenu" parent="GtkWindow" type-name="HildonAppMenu" get-type="hildon_app_menu_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="add_filter" symbol="hildon_app_menu_add_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu" type="HildonAppMenu*"/>
					<parameter name="filter" type="GtkButton*"/>
				</parameters>
			</method>
			<method name="append" symbol="hildon_app_menu_append">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu" type="HildonAppMenu*"/>
					<parameter name="item" type="GtkButton*"/>
				</parameters>
			</method>
			<method name="get_filters" symbol="hildon_app_menu_get_filters">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="menu" type="HildonAppMenu*"/>
				</parameters>
			</method>
			<method name="get_items" symbol="hildon_app_menu_get_items">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="menu" type="HildonAppMenu*"/>
				</parameters>
			</method>
			<method name="insert" symbol="hildon_app_menu_insert">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu" type="HildonAppMenu*"/>
					<parameter name="item" type="GtkButton*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_app_menu_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="popup" symbol="hildon_app_menu_popup">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu" type="HildonAppMenu*"/>
					<parameter name="parent_window" type="GtkWindow*"/>
				</parameters>
			</method>
			<method name="prepend" symbol="hildon_app_menu_prepend">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu" type="HildonAppMenu*"/>
					<parameter name="item" type="GtkButton*"/>
				</parameters>
			</method>
			<method name="reorder_child" symbol="hildon_app_menu_reorder_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu" type="HildonAppMenu*"/>
					<parameter name="item" type="GtkButton*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</method>
		</object>
		<object name="HildonBanner" parent="GtkWindow" type-name="HildonBanner" get-type="hildon_banner_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="set_fraction" symbol="hildon_banner_set_fraction">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonBanner*"/>
					<parameter name="fraction" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_icon" symbol="hildon_banner_set_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonBanner*"/>
					<parameter name="icon_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_icon_from_file" symbol="hildon_banner_set_icon_from_file">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonBanner*"/>
					<parameter name="icon_file" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_markup" symbol="hildon_banner_set_markup">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonBanner*"/>
					<parameter name="markup" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_text" symbol="hildon_banner_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonBanner*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_timeout" symbol="hildon_banner_set_timeout">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonBanner*"/>
					<parameter name="timeout" type="guint"/>
				</parameters>
			</method>
			<method name="show_animation" symbol="hildon_banner_show_animation">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="animation_name" type="gchar*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="show_information" symbol="hildon_banner_show_information">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="icon_name" type="gchar*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="show_information_override_dnd" symbol="hildon_banner_show_information_override_dnd">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="show_information_with_markup" symbol="hildon_banner_show_information_with_markup">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="icon_name" type="gchar*"/>
					<parameter name="markup" type="gchar*"/>
				</parameters>
			</method>
			<method name="show_informationf" symbol="hildon_banner_show_informationf">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="icon_name" type="gchar*"/>
					<parameter name="format" type="gchar*"/>
				</parameters>
			</method>
			<method name="show_progress" symbol="hildon_banner_show_progress">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="bar" type="GtkProgressBar*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<property name="is-timed" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="parent-window" type="GtkWindow*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="timeout" type="guint" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="HildonBreadCrumbTrail" parent="GtkContainer" type-name="HildonBreadCrumbTrail" get-type="hildon_bread_crumb_trail_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="clear" symbol="hildon_bread_crumb_trail_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="bct" type="HildonBreadCrumbTrail*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_bread_crumb_trail_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="pop" symbol="hildon_bread_crumb_trail_pop">
				<return-type type="void"/>
				<parameters>
					<parameter name="bct" type="HildonBreadCrumbTrail*"/>
				</parameters>
			</method>
			<method name="push" symbol="hildon_bread_crumb_trail_push">
				<return-type type="void"/>
				<parameters>
					<parameter name="bct" type="HildonBreadCrumbTrail*"/>
					<parameter name="item" type="HildonBreadCrumb*"/>
					<parameter name="id" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="push_icon" symbol="hildon_bread_crumb_trail_push_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="bct" type="HildonBreadCrumbTrail*"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="icon" type="GtkWidget*"/>
					<parameter name="id" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="push_text" symbol="hildon_bread_crumb_trail_push_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="bct" type="HildonBreadCrumbTrail*"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="id" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<signal name="crumb-clicked" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="bct" type="HildonBreadCrumbTrail*"/>
					<parameter name="id" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="move-parent" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="bct" type="HildonBreadCrumbTrail*"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonButton" parent="GtkButton" type-name="HildonButton" get-type="hildon_button_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="add_image_size_group" symbol="hildon_button_add_image_size_group">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="size_group" type="GtkSizeGroup*"/>
				</parameters>
			</method>
			<method name="add_size_groups" symbol="hildon_button_add_size_groups">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="title_size_group" type="GtkSizeGroup*"/>
					<parameter name="value_size_group" type="GtkSizeGroup*"/>
					<parameter name="image_size_group" type="GtkSizeGroup*"/>
				</parameters>
			</method>
			<method name="add_title_size_group" symbol="hildon_button_add_title_size_group">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="size_group" type="GtkSizeGroup*"/>
				</parameters>
			</method>
			<method name="add_value_size_group" symbol="hildon_button_add_value_size_group">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="size_group" type="GtkSizeGroup*"/>
				</parameters>
			</method>
			<method name="get_image" symbol="hildon_button_get_image">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
				</parameters>
			</method>
			<method name="get_style" symbol="hildon_button_get_style">
				<return-type type="HildonButtonStyle"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="hildon_button_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="hildon_button_get_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_button_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="size" type="HildonSizeType"/>
					<parameter name="arrangement" type="HildonButtonArrangement"/>
				</parameters>
			</constructor>
			<constructor name="new_with_text" symbol="hildon_button_new_with_text">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="size" type="HildonSizeType"/>
					<parameter name="arrangement" type="HildonButtonArrangement"/>
					<parameter name="title" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_alignment" symbol="hildon_button_set_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="xalign" type="gfloat"/>
					<parameter name="yalign" type="gfloat"/>
					<parameter name="xscale" type="gfloat"/>
					<parameter name="yscale" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_image" symbol="hildon_button_set_image">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="image" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="set_image_alignment" symbol="hildon_button_set_image_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="xalign" type="gfloat"/>
					<parameter name="yalign" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_image_position" symbol="hildon_button_set_image_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="position" type="GtkPositionType"/>
				</parameters>
			</method>
			<method name="set_style" symbol="hildon_button_set_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="style" type="HildonButtonStyle"/>
				</parameters>
			</method>
			<method name="set_text" symbol="hildon_button_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="title" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_title" symbol="hildon_button_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_title_alignment" symbol="hildon_button_set_title_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="xalign" type="gfloat"/>
					<parameter name="yalign" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_value" symbol="hildon_button_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_value_alignment" symbol="hildon_button_set_value_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonButton*"/>
					<parameter name="xalign" type="gfloat"/>
					<parameter name="yalign" type="gfloat"/>
				</parameters>
			</method>
			<property name="arrangement" type="HildonButtonArrangement" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="size" type="HildonSizeType" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="style" type="HildonButtonStyle" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonCalendar" parent="GtkWidget" type-name="HildonCalendar" get-type="hildon_calendar_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="clear_marks" symbol="hildon_calendar_clear_marks">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
				</parameters>
			</method>
			<method name="freeze" symbol="hildon_calendar_freeze">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
				</parameters>
			</method>
			<method name="get_date" symbol="hildon_calendar_get_date">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
					<parameter name="year" type="guint*"/>
					<parameter name="month" type="guint*"/>
					<parameter name="day" type="guint*"/>
				</parameters>
			</method>
			<method name="get_display_options" symbol="hildon_calendar_get_display_options">
				<return-type type="HildonCalendarDisplayOptions"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
				</parameters>
			</method>
			<method name="mark_day" symbol="hildon_calendar_mark_day">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
					<parameter name="day" type="guint"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_calendar_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="select_day" symbol="hildon_calendar_select_day">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
					<parameter name="day" type="guint"/>
				</parameters>
			</method>
			<method name="select_month" symbol="hildon_calendar_select_month">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
					<parameter name="month" type="guint"/>
					<parameter name="year" type="guint"/>
				</parameters>
			</method>
			<method name="set_display_options" symbol="hildon_calendar_set_display_options">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
					<parameter name="flags" type="HildonCalendarDisplayOptions"/>
				</parameters>
			</method>
			<method name="thaw" symbol="hildon_calendar_thaw">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
				</parameters>
			</method>
			<method name="unmark_day" symbol="hildon_calendar_unmark_day">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
					<parameter name="day" type="guint"/>
				</parameters>
			</method>
			<property name="day" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-year" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="min-year" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="month" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="no-month-change" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-day-names" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-heading" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-week-numbers" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="week-start" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="year" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="day-selected" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
				</parameters>
			</signal>
			<signal name="day-selected-double-click" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
				</parameters>
			</signal>
			<signal name="erroneous-date" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="HildonCalendar*"/>
				</parameters>
			</signal>
			<signal name="month-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
				</parameters>
			</signal>
			<signal name="next-month" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
				</parameters>
			</signal>
			<signal name="next-year" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
				</parameters>
			</signal>
			<signal name="prev-month" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
				</parameters>
			</signal>
			<signal name="prev-year" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="calendar" type="HildonCalendar*"/>
				</parameters>
			</signal>
			<signal name="selected-date" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="HildonCalendar*"/>
				</parameters>
			</signal>
			<field name="header_style" type="GtkStyle*"/>
			<field name="label_style" type="GtkStyle*"/>
			<field name="month" type="gint"/>
			<field name="year" type="gint"/>
			<field name="selected_day" type="gint"/>
			<field name="day_month" type="gint[][]"/>
			<field name="day" type="gint[][]"/>
			<field name="num_marked_dates" type="gint"/>
			<field name="marked_date" type="gint[]"/>
			<field name="display_flags" type="HildonCalendarDisplayOptions"/>
			<field name="marked_date_color" type="GdkColor[]"/>
			<field name="gc" type="GdkGC*"/>
			<field name="xor_gc" type="GdkGC*"/>
			<field name="focus_row" type="gint"/>
			<field name="focus_col" type="gint"/>
			<field name="highlight_row" type="gint"/>
			<field name="highlight_col" type="gint"/>
			<field name="grow_space" type="gchar[]"/>
		</object>
		<object name="HildonCalendarPopup" parent="GtkDialog" type-name="HildonCalendarPopup" get-type="hildon_calendar_popup_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_date" symbol="hildon_calendar_popup_get_date">
				<return-type type="void"/>
				<parameters>
					<parameter name="cal" type="HildonCalendarPopup*"/>
					<parameter name="year" type="guint*"/>
					<parameter name="month" type="guint*"/>
					<parameter name="day" type="guint*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_calendar_popup_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="year" type="guint"/>
					<parameter name="month" type="guint"/>
					<parameter name="day" type="guint"/>
				</parameters>
			</constructor>
			<method name="set_date" symbol="hildon_calendar_popup_set_date">
				<return-type type="void"/>
				<parameters>
					<parameter name="cal" type="HildonCalendarPopup*"/>
					<parameter name="year" type="guint"/>
					<parameter name="month" type="guint"/>
					<parameter name="day" type="guint"/>
				</parameters>
			</method>
			<property name="day" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-year" type="guint" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="min-year" type="guint" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="month" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="year" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonCaption" parent="GtkEventBox" type-name="HildonCaption" get-type="hildon_caption_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_child_expand" symbol="hildon_caption_get_child_expand">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
				</parameters>
			</method>
			<method name="get_icon_image" symbol="hildon_caption_get_icon_image">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
				</parameters>
			</method>
			<method name="get_icon_position" symbol="hildon_caption_get_icon_position">
				<return-type type="HildonCaptionIconPosition"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="hildon_caption_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
				</parameters>
			</method>
			<method name="get_label_alignment" symbol="hildon_caption_get_label_alignment">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
				</parameters>
			</method>
			<method name="get_separator" symbol="hildon_caption_get_separator">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
				</parameters>
			</method>
			<method name="get_size_group" symbol="hildon_caption_get_size_group">
				<return-type type="GtkSizeGroup*"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
				</parameters>
			</method>
			<method name="get_status" symbol="hildon_caption_get_status">
				<return-type type="HildonCaptionStatus"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
				</parameters>
			</method>
			<method name="is_mandatory" symbol="hildon_caption_is_mandatory">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_caption_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="group" type="GtkSizeGroup*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="control" type="GtkWidget*"/>
					<parameter name="icon" type="GtkWidget*"/>
					<parameter name="flag" type="HildonCaptionStatus"/>
				</parameters>
			</constructor>
			<method name="set_child_expand" symbol="hildon_caption_set_child_expand">
				<return-type type="void"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
					<parameter name="expand" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_icon_image" symbol="hildon_caption_set_icon_image">
				<return-type type="void"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
					<parameter name="icon" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="set_icon_position" symbol="hildon_caption_set_icon_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
					<parameter name="pos" type="HildonCaptionIconPosition"/>
				</parameters>
			</method>
			<method name="set_label" symbol="hildon_caption_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_label_alignment" symbol="hildon_caption_set_label_alignment">
				<return-type type="void"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
					<parameter name="alignment" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_label_markup" symbol="hildon_caption_set_label_markup">
				<return-type type="void"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
					<parameter name="markup" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_separator" symbol="hildon_caption_set_separator">
				<return-type type="void"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
					<parameter name="separator" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_size_group" symbol="hildon_caption_set_size_group">
				<return-type type="void"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
					<parameter name="new_group" type="GtkSizeGroup*"/>
				</parameters>
			</method>
			<method name="set_status" symbol="hildon_caption_set_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="caption" type="HildonCaption*"/>
					<parameter name="flag" type="HildonCaptionStatus"/>
				</parameters>
			</method>
			<property name="icon" type="GtkWidget*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="icon-position" type="HildonCaptionIconPosition" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="markup" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="separator" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="size-group" type="GtkSizeGroup*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="status" type="HildonCaptionStatus" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="activate" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="HildonCaption*"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonCheckButton" parent="GtkButton" type-name="HildonCheckButton" get-type="hildon_check_button_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_active" symbol="hildon_check_button_get_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="button" type="HildonCheckButton*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_check_button_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="size" type="HildonSizeType"/>
				</parameters>
			</constructor>
			<method name="set_active" symbol="hildon_check_button_set_active">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonCheckButton*"/>
					<parameter name="is_active" type="gboolean"/>
				</parameters>
			</method>
			<property name="size" type="HildonSizeType" readable="0" writable="1" construct="0" construct-only="0"/>
			<signal name="toggled" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonCheckButton*"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonCodeDialog" parent="GtkDialog" type-name="HildonCodeDialog" get-type="hildon_code_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="clear_code" symbol="hildon_code_dialog_clear_code">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonCodeDialog*"/>
				</parameters>
			</method>
			<method name="get_code" symbol="hildon_code_dialog_get_code">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="HildonCodeDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_code_dialog_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_help_text" symbol="hildon_code_dialog_set_help_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonCodeDialog*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_input_sensitive" symbol="hildon_code_dialog_set_input_sensitive">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonCodeDialog*"/>
					<parameter name="sensitive" type="gboolean"/>
				</parameters>
			</method>
			<signal name="input" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonCodeDialog*"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonColorButton" parent="GtkButton" type-name="HildonColorButton" get-type="hildon_color_button_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_color" symbol="hildon_color_button_get_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonColorButton*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="get_popup_shown" symbol="hildon_color_button_get_popup_shown">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="button" type="HildonColorButton*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_color_button_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_with_color" symbol="hildon_color_button_new_with_color">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</constructor>
			<method name="popdown" symbol="hildon_color_button_popdown">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonColorButton*"/>
				</parameters>
			</method>
			<method name="set_color" symbol="hildon_color_button_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonColorButton*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<property name="color" type="GdkColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="popup-shown" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="setup-dialog" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="HildonColorButton*"/>
					<parameter name="p0" type="HildonColorChooserDialog*"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonColorChooser" parent="GtkWidget" type-name="HildonColorChooser" get-type="hildon_color_chooser_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_color" symbol="hildon_color_chooser_get_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="chooser" type="HildonColorChooser*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_color_chooser_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_color" symbol="hildon_color_chooser_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="chooser" type="HildonColorChooser*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<property name="color" type="GdkColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="color-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="selection" type="HildonColorChooser*"/>
				</parameters>
			</signal>
			<vfunc name="set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="p1" type="HildonColorChooser*"/>
					<parameter name="p2" type="GdkColor*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="HildonColorChooserDialog" parent="GtkDialog" type-name="HildonColorChooserDialog" get-type="hildon_color_chooser_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_color" symbol="hildon_color_chooser_dialog_get_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonColorChooserDialog*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_color_chooser_dialog_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_color" symbol="hildon_color_chooser_dialog_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonColorChooserDialog*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
		</object>
		<object name="HildonControlbar" parent="GtkScale" type-name="HildonControlbar" get-type="hildon_controlbar_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_max" symbol="hildon_controlbar_get_max">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="HildonControlbar*"/>
				</parameters>
			</method>
			<method name="get_min" symbol="hildon_controlbar_get_min">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="HildonControlbar*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="hildon_controlbar_get_value">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="HildonControlbar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_controlbar_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_max" symbol="hildon_controlbar_set_max">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonControlbar*"/>
					<parameter name="max" type="gint"/>
				</parameters>
			</method>
			<method name="set_min" symbol="hildon_controlbar_set_min">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonControlbar*"/>
					<parameter name="min" type="gint"/>
				</parameters>
			</method>
			<method name="set_range" symbol="hildon_controlbar_set_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonControlbar*"/>
					<parameter name="min" type="gint"/>
					<parameter name="max" type="gint"/>
				</parameters>
			</method>
			<method name="set_value" symbol="hildon_controlbar_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonControlbar*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<property name="max" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="min" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="value" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="end-reached" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="controlbar" type="HildonControlbar*"/>
					<parameter name="end" type="gboolean"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonDateButton" parent="HildonPickerButton" type-name="HildonDateButton" get-type="hildon_date_button_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_date" symbol="hildon_date_button_get_date">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonDateButton*"/>
					<parameter name="year" type="guint*"/>
					<parameter name="month" type="guint*"/>
					<parameter name="day" type="guint*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_date_button_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="size" type="HildonSizeType"/>
					<parameter name="arrangement" type="HildonButtonArrangement"/>
				</parameters>
			</constructor>
			<constructor name="new_with_year_range" symbol="hildon_date_button_new_with_year_range">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="size" type="HildonSizeType"/>
					<parameter name="arrangement" type="HildonButtonArrangement"/>
					<parameter name="min_year" type="gint"/>
					<parameter name="max_year" type="gint"/>
				</parameters>
			</constructor>
			<method name="set_date" symbol="hildon_date_button_set_date">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonDateButton*"/>
					<parameter name="year" type="guint"/>
					<parameter name="month" type="guint"/>
					<parameter name="day" type="guint"/>
				</parameters>
			</method>
		</object>
		<object name="HildonDateEditor" parent="GtkContainer" type-name="HildonDateEditor" get-type="hildon_date_editor_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_date" symbol="hildon_date_editor_get_date">
				<return-type type="void"/>
				<parameters>
					<parameter name="date" type="HildonDateEditor*"/>
					<parameter name="year" type="guint*"/>
					<parameter name="month" type="guint*"/>
					<parameter name="day" type="guint*"/>
				</parameters>
			</method>
			<method name="get_day" symbol="hildon_date_editor_get_day">
				<return-type type="guint"/>
				<parameters>
					<parameter name="editor" type="HildonDateEditor*"/>
				</parameters>
			</method>
			<method name="get_month" symbol="hildon_date_editor_get_month">
				<return-type type="guint"/>
				<parameters>
					<parameter name="editor" type="HildonDateEditor*"/>
				</parameters>
			</method>
			<method name="get_year" symbol="hildon_date_editor_get_year">
				<return-type type="guint"/>
				<parameters>
					<parameter name="editor" type="HildonDateEditor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_date_editor_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_date" symbol="hildon_date_editor_set_date">
				<return-type type="void"/>
				<parameters>
					<parameter name="date" type="HildonDateEditor*"/>
					<parameter name="year" type="guint"/>
					<parameter name="month" type="guint"/>
					<parameter name="day" type="guint"/>
				</parameters>
			</method>
			<method name="set_day" symbol="hildon_date_editor_set_day">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="editor" type="HildonDateEditor*"/>
					<parameter name="day" type="guint"/>
				</parameters>
			</method>
			<method name="set_month" symbol="hildon_date_editor_set_month">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="editor" type="HildonDateEditor*"/>
					<parameter name="month" type="guint"/>
				</parameters>
			</method>
			<method name="set_year" symbol="hildon_date_editor_set_year">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="editor" type="HildonDateEditor*"/>
					<parameter name="year" type="guint"/>
				</parameters>
			</method>
			<property name="day" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-year" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="min-year" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="month" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="year" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="date-error" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="editor" type="HildonDateEditor*"/>
					<parameter name="type" type="HildonDateTimeError"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonDateSelector" parent="HildonTouchSelector" type-name="HildonDateSelector" get-type="hildon_date_selector_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_date" symbol="hildon_date_selector_get_date">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonDateSelector*"/>
					<parameter name="year" type="guint*"/>
					<parameter name="month" type="guint*"/>
					<parameter name="day" type="guint*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_date_selector_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_with_year_range" symbol="hildon_date_selector_new_with_year_range">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="min_year" type="gint"/>
					<parameter name="max_year" type="gint"/>
				</parameters>
			</constructor>
			<method name="select_current_date" symbol="hildon_date_selector_select_current_date">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selector" type="HildonDateSelector*"/>
					<parameter name="year" type="guint"/>
					<parameter name="month" type="guint"/>
					<parameter name="day" type="guint"/>
				</parameters>
			</method>
			<method name="select_day" symbol="hildon_date_selector_select_day">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonDateSelector*"/>
					<parameter name="day" type="guint"/>
				</parameters>
			</method>
			<method name="select_month" symbol="hildon_date_selector_select_month">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selector" type="HildonDateSelector*"/>
					<parameter name="month" type="guint"/>
					<parameter name="year" type="guint"/>
				</parameters>
			</method>
			<property name="max-year" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="min-year" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="HildonDialog" parent="GtkDialog" type-name="HildonDialog" get-type="hildon_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="add_button" symbol="hildon_dialog_add_button">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="dialog" type="HildonDialog*"/>
					<parameter name="button_text" type="gchar*"/>
					<parameter name="response_id" type="gint"/>
				</parameters>
			</method>
			<method name="add_buttons" symbol="hildon_dialog_add_buttons">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonDialog*"/>
					<parameter name="first_button_text" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_dialog_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_with_buttons" symbol="hildon_dialog_new_with_buttons">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="title" type="gchar*"/>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="flags" type="GtkDialogFlags"/>
					<parameter name="first_button_text" type="gchar*"/>
				</parameters>
			</constructor>
		</object>
		<object name="HildonEditToolbar" parent="GtkHBox" type-name="HildonEditToolbar" get-type="hildon_edit_toolbar_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="hildon_edit_toolbar_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_with_text" symbol="hildon_edit_toolbar_new_with_text">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="label" type="gchar*"/>
					<parameter name="button" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_button_label" symbol="hildon_edit_toolbar_set_button_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="toolbar" type="HildonEditToolbar*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_label" symbol="hildon_edit_toolbar_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="toolbar" type="HildonEditToolbar*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<signal name="arrow-clicked" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="HildonEditToolbar*"/>
				</parameters>
			</signal>
			<signal name="button-clicked" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="HildonEditToolbar*"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonEntry" parent="GtkEntry" type-name="HildonEntry" get-type="hildon_entry_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkEditable"/>
				<interface name="GtkCellEditable"/>
			</implements>
			<method name="get_text" symbol="hildon_entry_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="entry" type="HildonEntry*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_entry_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="size" type="HildonSizeType"/>
				</parameters>
			</constructor>
			<method name="set_placeholder" symbol="hildon_entry_set_placeholder">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="HildonEntry*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_text" symbol="hildon_entry_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="HildonEntry*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<property name="size" type="HildonSizeType" readable="0" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="HildonFindToolbar" parent="GtkToolbar" type-name="HildonFindToolbar" get-type="hildon_find_toolbar_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkToolShell"/>
			</implements>
			<method name="get_active" symbol="hildon_find_toolbar_get_active">
				<return-type type="gint"/>
				<parameters>
					<parameter name="toolbar" type="HildonFindToolbar*"/>
				</parameters>
			</method>
			<method name="get_active_iter" symbol="hildon_find_toolbar_get_active_iter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="toolbar" type="HildonFindToolbar*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<method name="get_last_index" symbol="hildon_find_toolbar_get_last_index">
				<return-type type="gint32"/>
				<parameters>
					<parameter name="toolbar" type="HildonFindToolbar*"/>
				</parameters>
			</method>
			<method name="highlight_entry" symbol="hildon_find_toolbar_highlight_entry">
				<return-type type="void"/>
				<parameters>
					<parameter name="ftb" type="HildonFindToolbar*"/>
					<parameter name="get_focus" type="gboolean"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_find_toolbar_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_model" symbol="hildon_find_toolbar_new_with_model">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="label" type="gchar*"/>
					<parameter name="model" type="GtkListStore*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</constructor>
			<method name="set_active" symbol="hildon_find_toolbar_set_active">
				<return-type type="void"/>
				<parameters>
					<parameter name="toolbar" type="HildonFindToolbar*"/>
					<parameter name="index" type="gint"/>
				</parameters>
			</method>
			<method name="set_active_iter" symbol="hildon_find_toolbar_set_active_iter">
				<return-type type="void"/>
				<parameters>
					<parameter name="toolbar" type="HildonFindToolbar*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<property name="column" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="history-limit" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="list" type="GtkListStore*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-characters" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="prefix" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="close" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="toolbar" type="HildonFindToolbar*"/>
				</parameters>
			</signal>
			<signal name="history-append" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="tooblar" type="HildonFindToolbar*"/>
				</parameters>
			</signal>
			<signal name="invalid-input" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="toolbar" type="HildonFindToolbar*"/>
				</parameters>
			</signal>
			<signal name="search" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="toolbar" type="HildonFindToolbar*"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonFontSelectionDialog" parent="GtkDialog" type-name="HildonFontSelectionDialog" get-type="hildon_font_selection_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_preview_text" symbol="hildon_font_selection_dialog_get_preview_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="fsd" type="HildonFontSelectionDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_font_selection_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_preview_text" symbol="hildon_font_selection_dialog_set_preview_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="fsd" type="HildonFontSelectionDialog*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<property name="bold" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="bold-set" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="color" type="GdkColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="color-set" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="family" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="family-set" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="font-scaling" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="italic" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="italic-set" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="position" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="position-set" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="preview-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="size" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="size-set" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="strikethrough" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="strikethrough-set" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="underline" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="underline-set" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="HildonGetPasswordDialog" parent="GtkDialog" type-name="HildonGetPasswordDialog" get-type="hildon_get_password_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_password" symbol="hildon_get_password_dialog_get_password">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="HildonGetPasswordDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_get_password_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="get_old" type="gboolean"/>
				</parameters>
			</constructor>
			<constructor name="new_with_default" symbol="hildon_get_password_dialog_new_with_default">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="password" type="gchar*"/>
					<parameter name="get_old" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_caption" symbol="hildon_get_password_dialog_set_caption">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonGetPasswordDialog*"/>
					<parameter name="new_caption" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_max_characters" symbol="hildon_get_password_dialog_set_max_characters">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonGetPasswordDialog*"/>
					<parameter name="max_characters" type="gint"/>
				</parameters>
			</method>
			<method name="set_message" symbol="hildon_get_password_dialog_set_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonGetPasswordDialog*"/>
					<parameter name="message" type="gchar*"/>
				</parameters>
			</method>
			<property name="caption-label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="get-old" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="max-characters" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="message" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="numbers-only" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="password" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonHVolumebar" parent="HildonVolumebar" type-name="HildonHVolumebar" get-type="hildon_hvolumebar_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="hildon_hvolumebar_new">
				<return-type type="GtkWidget*"/>
			</constructor>
		</object>
		<object name="HildonLoginDialog" parent="GtkDialog" type-name="HildonLoginDialog" get-type="hildon_login_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_password" symbol="hildon_login_dialog_get_password">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="HildonLoginDialog*"/>
				</parameters>
			</method>
			<method name="get_username" symbol="hildon_login_dialog_get_username">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="HildonLoginDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_login_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_default" symbol="hildon_login_dialog_new_with_default">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="password" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_message" symbol="hildon_login_dialog_set_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonLoginDialog*"/>
					<parameter name="msg" type="gchar*"/>
				</parameters>
			</method>
			<property name="message" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="password" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="username" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonNote" parent="GtkDialog" type-name="HildonNote" get-type="hildon_note_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new_cancel_with_progress_bar" symbol="hildon_note_new_cancel_with_progress_bar">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="description" type="gchar*"/>
					<parameter name="progressbar" type="GtkProgressBar*"/>
				</parameters>
			</constructor>
			<constructor name="new_confirmation" symbol="hildon_note_new_confirmation">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_confirmation_add_buttons" symbol="hildon_note_new_confirmation_add_buttons">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_confirmation_with_icon_name" symbol="hildon_note_new_confirmation_with_icon_name">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="description" type="gchar*"/>
					<parameter name="icon_name" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_information" symbol="hildon_note_new_information">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_information_with_icon_name" symbol="hildon_note_new_information_with_icon_name">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="description" type="gchar*"/>
					<parameter name="icon_name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_button_text" symbol="hildon_note_set_button_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="note" type="HildonNote*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_button_texts" symbol="hildon_note_set_button_texts">
				<return-type type="void"/>
				<parameters>
					<parameter name="note" type="HildonNote*"/>
					<parameter name="text_ok" type="gchar*"/>
					<parameter name="text_cancel" type="gchar*"/>
				</parameters>
			</method>
			<property name="description" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="icon" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="note-type" type="HildonNoteType" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="progressbar" type="GtkProgressBar*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="stock-icon" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonNumberEditor" parent="GtkContainer" type-name="HildonNumberEditor" get-type="hildon_number_editor_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_value" symbol="hildon_number_editor_get_value">
				<return-type type="gint"/>
				<parameters>
					<parameter name="editor" type="HildonNumberEditor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_number_editor_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="min" type="gint"/>
					<parameter name="max" type="gint"/>
				</parameters>
			</constructor>
			<method name="set_range" symbol="hildon_number_editor_set_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonNumberEditor*"/>
					<parameter name="min" type="gint"/>
					<parameter name="max" type="gint"/>
				</parameters>
			</method>
			<method name="set_value" symbol="hildon_number_editor_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonNumberEditor*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<property name="value" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="range-error" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="editor" type="HildonNumberEditor*"/>
					<parameter name="type" type="HildonNumberEditorErrorType"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonPannableArea" parent="GtkBin" type-name="HildonPannableArea" get-type="hildon_pannable_area_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="add_with_viewport" symbol="hildon_pannable_area_add_with_viewport">
				<return-type type="void"/>
				<parameters>
					<parameter name="area" type="HildonPannableArea*"/>
					<parameter name="child" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="get_hadjustment" symbol="hildon_pannable_area_get_hadjustment">
				<return-type type="GtkAdjustment*"/>
				<parameters>
					<parameter name="area" type="HildonPannableArea*"/>
				</parameters>
			</method>
			<method name="get_size_request_policy" symbol="hildon_pannable_area_get_size_request_policy">
				<return-type type="HildonSizeRequestPolicy"/>
				<parameters>
					<parameter name="area" type="HildonPannableArea*"/>
				</parameters>
			</method>
			<method name="get_vadjustment" symbol="hildon_pannable_area_get_vadjustment">
				<return-type type="GtkAdjustment*"/>
				<parameters>
					<parameter name="area" type="HildonPannableArea*"/>
				</parameters>
			</method>
			<method name="jump_to" symbol="hildon_pannable_area_jump_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="area" type="HildonPannableArea*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="jump_to_child" symbol="hildon_pannable_area_jump_to_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="area" type="HildonPannableArea*"/>
					<parameter name="child" type="GtkWidget*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_pannable_area_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_full" symbol="hildon_pannable_area_new_full">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="mode" type="gint"/>
					<parameter name="enabled" type="gboolean"/>
					<parameter name="vel_min" type="gdouble"/>
					<parameter name="vel_max" type="gdouble"/>
					<parameter name="decel" type="gdouble"/>
					<parameter name="sps" type="guint"/>
				</parameters>
			</constructor>
			<method name="scroll_to" symbol="hildon_pannable_area_scroll_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="area" type="HildonPannableArea*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
				</parameters>
			</method>
			<method name="scroll_to_child" symbol="hildon_pannable_area_scroll_to_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="area" type="HildonPannableArea*"/>
					<parameter name="child" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="set_size_request_policy" symbol="hildon_pannable_area_set_size_request_policy">
				<return-type type="void"/>
				<parameters>
					<parameter name="area" type="HildonPannableArea*"/>
					<parameter name="size_request_policy" type="HildonSizeRequestPolicy"/>
				</parameters>
			</method>
			<property name="bounce-steps" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="deceleration" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="direction-error-margin" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="drag-inertia" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enabled" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="force" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="hadjustment" type="GtkAdjustment*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="hovershoot-max" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="hscrollbar-policy" type="GtkPolicyType" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="initial-hint" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="low-friction-mode" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="mode" type="HildonPannableAreaMode" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="mov-mode" type="HildonMovementMode" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="panning-threshold" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="scroll-time" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="scrollbar-fade-delay" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="size-request-policy" type="HildonSizeRequestPolicy" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="sps" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="vadjustment" type="GtkAdjustment*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="velocity-fast-factor" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="velocity-max" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="velocity-min" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="velocity-overshooting-max" type="gdouble" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="vovershoot-max" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="vscrollbar-policy" type="GtkPolicyType" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="horizontal-movement" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="area" type="HildonPannableArea*"/>
					<parameter name="direction" type="gint"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
				</parameters>
			</signal>
			<signal name="panning-finished" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="HildonPannableArea*"/>
				</parameters>
			</signal>
			<signal name="panning-started" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="HildonPannableArea*"/>
				</parameters>
			</signal>
			<signal name="vertical-movement" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="area" type="HildonPannableArea*"/>
					<parameter name="direction" type="gint"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonPickerButton" parent="HildonButton" type-name="HildonPickerButton" get-type="hildon_picker_button_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_active" symbol="hildon_picker_button_get_active">
				<return-type type="gint"/>
				<parameters>
					<parameter name="button" type="HildonPickerButton*"/>
				</parameters>
			</method>
			<method name="get_done_button_text" symbol="hildon_picker_button_get_done_button_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="button" type="HildonPickerButton*"/>
				</parameters>
			</method>
			<method name="get_selector" symbol="hildon_picker_button_get_selector">
				<return-type type="HildonTouchSelector*"/>
				<parameters>
					<parameter name="button" type="HildonPickerButton*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_picker_button_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="size" type="HildonSizeType"/>
					<parameter name="arrangement" type="HildonButtonArrangement"/>
				</parameters>
			</constructor>
			<method name="set_active" symbol="hildon_picker_button_set_active">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonPickerButton*"/>
					<parameter name="index" type="gint"/>
				</parameters>
			</method>
			<method name="set_done_button_text" symbol="hildon_picker_button_set_done_button_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonPickerButton*"/>
					<parameter name="done_button_text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_selector" symbol="hildon_picker_button_set_selector">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonPickerButton*"/>
					<parameter name="selector" type="HildonTouchSelector*"/>
				</parameters>
			</method>
			<property name="done-button-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="touch-selector" type="HildonTouchSelector*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="value-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="HildonPickerButton*"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonPickerDialog" parent="HildonDialog" type-name="HildonPickerDialog" get-type="hildon_picker_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_done_label" symbol="hildon_picker_dialog_get_done_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="HildonPickerDialog*"/>
				</parameters>
			</method>
			<method name="get_selector" symbol="hildon_picker_dialog_get_selector">
				<return-type type="HildonTouchSelector*"/>
				<parameters>
					<parameter name="dialog" type="HildonPickerDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_picker_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
				</parameters>
			</constructor>
			<method name="set_done_label" symbol="hildon_picker_dialog_set_done_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonPickerDialog*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_selector" symbol="hildon_picker_dialog_set_selector">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dialog" type="HildonPickerDialog*"/>
					<parameter name="selector" type="HildonTouchSelector*"/>
				</parameters>
			</method>
			<property name="center-on-show" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="done-button-text" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<vfunc name="set_selector">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dialog" type="HildonPickerDialog*"/>
					<parameter name="selector" type="HildonTouchSelector*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="HildonProgram" parent="GObject" type-name="HildonProgram" get-type="hildon_program_get_type">
			<method name="add_window" symbol="hildon_program_add_window">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
					<parameter name="window" type="HildonWindow*"/>
				</parameters>
			</method>
			<method name="get_can_hibernate" symbol="hildon_program_get_can_hibernate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
				</parameters>
			</method>
			<method name="get_common_app_menu" symbol="hildon_program_get_common_app_menu">
				<return-type type="HildonAppMenu*"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
				</parameters>
			</method>
			<method name="get_common_menu" symbol="hildon_program_get_common_menu">
				<return-type type="GtkMenu*"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
				</parameters>
			</method>
			<method name="get_common_toolbar" symbol="hildon_program_get_common_toolbar">
				<return-type type="GtkToolbar*"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
				</parameters>
			</method>
			<method name="get_instance" symbol="hildon_program_get_instance">
				<return-type type="HildonProgram*"/>
			</method>
			<method name="get_is_topmost" symbol="hildon_program_get_is_topmost">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
				</parameters>
			</method>
			<method name="go_to_root_window" symbol="hildon_program_go_to_root_window">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
				</parameters>
			</method>
			<method name="peek_window_stack" symbol="hildon_program_peek_window_stack">
				<return-type type="HildonStackableWindow*"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
				</parameters>
			</method>
			<method name="pop_window_stack" symbol="hildon_program_pop_window_stack">
				<return-type type="HildonStackableWindow*"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
				</parameters>
			</method>
			<method name="remove_window" symbol="hildon_program_remove_window">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
					<parameter name="window" type="HildonWindow*"/>
				</parameters>
			</method>
			<method name="set_can_hibernate" symbol="hildon_program_set_can_hibernate">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
					<parameter name="can_hibernate" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_common_app_menu" symbol="hildon_program_set_common_app_menu">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
					<parameter name="menu" type="HildonAppMenu*"/>
				</parameters>
			</method>
			<method name="set_common_menu" symbol="hildon_program_set_common_menu">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
					<parameter name="menu" type="GtkMenu*"/>
				</parameters>
			</method>
			<method name="set_common_toolbar" symbol="hildon_program_set_common_toolbar">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonProgram*"/>
					<parameter name="toolbar" type="GtkToolbar*"/>
				</parameters>
			</method>
			<property name="can-hibernate" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-topmost" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="HildonRangeEditor" parent="GtkContainer" type-name="HildonRangeEditor" get-type="hildon_range_editor_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_higher" symbol="hildon_range_editor_get_higher">
				<return-type type="gint"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
				</parameters>
			</method>
			<method name="get_lower" symbol="hildon_range_editor_get_lower">
				<return-type type="gint"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
				</parameters>
			</method>
			<method name="get_max" symbol="hildon_range_editor_get_max">
				<return-type type="gint"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
				</parameters>
			</method>
			<method name="get_min" symbol="hildon_range_editor_get_min">
				<return-type type="gint"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
				</parameters>
			</method>
			<method name="get_range" symbol="hildon_range_editor_get_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
					<parameter name="start" type="gint*"/>
					<parameter name="end" type="gint*"/>
				</parameters>
			</method>
			<method name="get_separator" symbol="hildon_range_editor_get_separator">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_range_editor_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_with_separator" symbol="hildon_range_editor_new_with_separator">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="separator" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_higher" symbol="hildon_range_editor_set_higher">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_limits" symbol="hildon_range_editor_set_limits">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
					<parameter name="start" type="gint"/>
					<parameter name="end" type="gint"/>
				</parameters>
			</method>
			<method name="set_lower" symbol="hildon_range_editor_set_lower">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_max" symbol="hildon_range_editor_set_max">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_min" symbol="hildon_range_editor_set_min">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_range" symbol="hildon_range_editor_set_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
					<parameter name="start" type="gint"/>
					<parameter name="end" type="gint"/>
				</parameters>
			</method>
			<method name="set_separator" symbol="hildon_range_editor_set_separator">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonRangeEditor*"/>
					<parameter name="separator" type="gchar*"/>
				</parameters>
			</method>
			<property name="higher" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="lower" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="max" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="min" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="separator" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="HildonRemoteTexture" parent="GtkWindow" type-name="HildonRemoteTexture" get-type="hildon_remote_texture_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="hildon_remote_texture_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="send_message" symbol="hildon_remote_texture_send_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonRemoteTexture*"/>
					<parameter name="message_type" type="guint32"/>
					<parameter name="l0" type="guint32"/>
					<parameter name="l1" type="guint32"/>
					<parameter name="l2" type="guint32"/>
					<parameter name="l3" type="guint32"/>
					<parameter name="l4" type="guint32"/>
				</parameters>
			</method>
			<method name="set_image" symbol="hildon_remote_texture_set_image">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonRemoteTexture*"/>
					<parameter name="key" type="guint32"/>
					<parameter name="width" type="guint"/>
					<parameter name="height" type="guint"/>
					<parameter name="bpp" type="guint"/>
				</parameters>
			</method>
			<method name="set_offset" symbol="hildon_remote_texture_set_offset">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonRemoteTexture*"/>
					<parameter name="x" type="double"/>
					<parameter name="y" type="double"/>
				</parameters>
			</method>
			<method name="set_opacity" symbol="hildon_remote_texture_set_opacity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonRemoteTexture*"/>
					<parameter name="opacity" type="gint"/>
				</parameters>
			</method>
			<method name="set_parent" symbol="hildon_remote_texture_set_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonRemoteTexture*"/>
					<parameter name="parent" type="GtkWindow*"/>
				</parameters>
			</method>
			<method name="set_position" symbol="hildon_remote_texture_set_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonRemoteTexture*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<method name="set_scale" symbol="hildon_remote_texture_set_scale">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonRemoteTexture*"/>
					<parameter name="x_scale" type="double"/>
					<parameter name="y_scale" type="double"/>
				</parameters>
			</method>
			<method name="set_show" symbol="hildon_remote_texture_set_show">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonRemoteTexture*"/>
					<parameter name="show" type="gint"/>
				</parameters>
			</method>
			<method name="set_show_full" symbol="hildon_remote_texture_set_show_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonRemoteTexture*"/>
					<parameter name="show" type="gint"/>
					<parameter name="opacity" type="gint"/>
				</parameters>
			</method>
			<method name="update_area" symbol="hildon_remote_texture_update_area">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonRemoteTexture*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
		</object>
		<object name="HildonSeekbar" parent="GtkScale" type-name="HildonSeekbar" get-type="hildon_seekbar_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_fraction" symbol="hildon_seekbar_get_fraction">
				<return-type type="guint"/>
				<parameters>
					<parameter name="seekbar" type="HildonSeekbar*"/>
				</parameters>
			</method>
			<method name="get_position" symbol="hildon_seekbar_get_position">
				<return-type type="gint"/>
				<parameters>
					<parameter name="seekbar" type="HildonSeekbar*"/>
				</parameters>
			</method>
			<method name="get_total_time" symbol="hildon_seekbar_get_total_time">
				<return-type type="gint"/>
				<parameters>
					<parameter name="seekbar" type="HildonSeekbar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_seekbar_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_fraction" symbol="hildon_seekbar_set_fraction">
				<return-type type="void"/>
				<parameters>
					<parameter name="seekbar" type="HildonSeekbar*"/>
					<parameter name="fraction" type="guint"/>
				</parameters>
			</method>
			<method name="set_position" symbol="hildon_seekbar_set_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="seekbar" type="HildonSeekbar*"/>
					<parameter name="time" type="gint"/>
				</parameters>
			</method>
			<method name="set_total_time" symbol="hildon_seekbar_set_total_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="seekbar" type="HildonSeekbar*"/>
					<parameter name="time" type="gint"/>
				</parameters>
			</method>
			<property name="fraction" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="position" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="total-time" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonSetPasswordDialog" parent="GtkDialog" type-name="HildonSetPasswordDialog" get-type="hildon_set_password_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_password" symbol="hildon_set_password_dialog_get_password">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dialog" type="HildonSetPasswordDialog*"/>
				</parameters>
			</method>
			<method name="get_protected" symbol="hildon_set_password_dialog_get_protected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dialog" type="HildonSetPasswordDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_set_password_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="modify_protection" type="gboolean"/>
				</parameters>
			</constructor>
			<constructor name="new_with_default" symbol="hildon_set_password_dialog_new_with_default">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="password" type="gchar*"/>
					<parameter name="modify_protection" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_message" symbol="hildon_set_password_dialog_set_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonSetPasswordDialog*"/>
					<parameter name="message" type="gchar*"/>
				</parameters>
			</method>
			<property name="message" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="modify-protection" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="password" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonSortDialog" parent="GtkDialog" type-name="HildonSortDialog" get-type="hildon_sort_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="add_sort_key" symbol="hildon_sort_dialog_add_sort_key">
				<return-type type="gint"/>
				<parameters>
					<parameter name="dialog" type="HildonSortDialog*"/>
					<parameter name="sort_key" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_sort_key_reversed" symbol="hildon_sort_dialog_add_sort_key_reversed">
				<return-type type="gint"/>
				<parameters>
					<parameter name="dialog" type="HildonSortDialog*"/>
					<parameter name="sort_key" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_sort_key" symbol="hildon_sort_dialog_get_sort_key">
				<return-type type="gint"/>
				<parameters>
					<parameter name="dialog" type="HildonSortDialog*"/>
				</parameters>
			</method>
			<method name="get_sort_order" symbol="hildon_sort_dialog_get_sort_order">
				<return-type type="GtkSortType"/>
				<parameters>
					<parameter name="dialog" type="HildonSortDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_sort_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
				</parameters>
			</constructor>
			<method name="set_sort_key" symbol="hildon_sort_dialog_set_sort_key">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonSortDialog*"/>
					<parameter name="key" type="int"/>
				</parameters>
			</method>
			<method name="set_sort_order" symbol="hildon_sort_dialog_set_sort_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="HildonSortDialog*"/>
					<parameter name="order" type="GtkSortType"/>
				</parameters>
			</method>
			<property name="sort-key" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sort-order" type="GtkSortType" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonStackableWindow" parent="HildonWindow" type-name="HildonStackableWindow" get-type="hildon_stackable_window_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_stack" symbol="hildon_stackable_window_get_stack">
				<return-type type="HildonWindowStack*"/>
				<parameters>
					<parameter name="self" type="HildonStackableWindow*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_stackable_window_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_main_menu" symbol="hildon_stackable_window_set_main_menu">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonStackableWindow*"/>
					<parameter name="menu" type="HildonAppMenu*"/>
				</parameters>
			</method>
		</object>
		<object name="HildonTextView" parent="GtkTextView" type-name="HildonTextView" get-type="hildon_text_view_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_buffer" symbol="hildon_text_view_get_buffer">
				<return-type type="GtkTextBuffer*"/>
				<parameters>
					<parameter name="text_view" type="HildonTextView*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_text_view_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_buffer" symbol="hildon_text_view_set_buffer">
				<return-type type="void"/>
				<parameters>
					<parameter name="text_view" type="HildonTextView*"/>
					<parameter name="buffer" type="GtkTextBuffer*"/>
				</parameters>
			</method>
			<method name="set_placeholder" symbol="hildon_text_view_set_placeholder">
				<return-type type="void"/>
				<parameters>
					<parameter name="text_view" type="HildonTextView*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
		</object>
		<object name="HildonTimeButton" parent="HildonPickerButton" type-name="HildonTimeButton" get-type="hildon_time_button_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_time" symbol="hildon_time_button_get_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonTimeButton*"/>
					<parameter name="hours" type="guint*"/>
					<parameter name="minutes" type="guint*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_time_button_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="size" type="HildonSizeType"/>
					<parameter name="arrangement" type="HildonButtonArrangement"/>
				</parameters>
			</constructor>
			<constructor name="new_step" symbol="hildon_time_button_new_step">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="size" type="HildonSizeType"/>
					<parameter name="arrangement" type="HildonButtonArrangement"/>
					<parameter name="minutes_step" type="guint"/>
				</parameters>
			</constructor>
			<method name="set_time" symbol="hildon_time_button_set_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="button" type="HildonTimeButton*"/>
					<parameter name="hours" type="guint"/>
					<parameter name="minutes" type="guint"/>
				</parameters>
			</method>
		</object>
		<object name="HildonTimeEditor" parent="GtkContainer" type-name="HildonTimeEditor" get-type="hildon_time_editor_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_duration_max" symbol="hildon_time_editor_get_duration_max">
				<return-type type="guint"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
				</parameters>
			</method>
			<method name="get_duration_min" symbol="hildon_time_editor_get_duration_min">
				<return-type type="guint"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
				</parameters>
			</method>
			<method name="get_duration_mode" symbol="hildon_time_editor_get_duration_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
				</parameters>
			</method>
			<method name="get_duration_range" symbol="hildon_time_editor_get_duration_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
					<parameter name="min_seconds" type="guint*"/>
					<parameter name="max_seconds" type="guint*"/>
				</parameters>
			</method>
			<method name="get_show_hours" symbol="hildon_time_editor_get_show_hours">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
				</parameters>
			</method>
			<method name="get_show_seconds" symbol="hildon_time_editor_get_show_seconds">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
				</parameters>
			</method>
			<method name="get_ticks" symbol="hildon_time_editor_get_ticks">
				<return-type type="guint"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
				</parameters>
			</method>
			<method name="get_time" symbol="hildon_time_editor_get_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
					<parameter name="hours" type="guint*"/>
					<parameter name="minutes" type="guint*"/>
					<parameter name="seconds" type="guint*"/>
				</parameters>
			</method>
			<method name="get_time_separators" symbol="hildon_time_editor_get_time_separators">
				<return-type type="void"/>
				<parameters>
					<parameter name="hm_sep_label" type="GtkLabel*"/>
					<parameter name="ms_sep_label" type="GtkLabel*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_time_editor_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_duration_max" symbol="hildon_time_editor_set_duration_max">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
					<parameter name="duration_max" type="guint"/>
				</parameters>
			</method>
			<method name="set_duration_min" symbol="hildon_time_editor_set_duration_min">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
					<parameter name="duration_min" type="guint"/>
				</parameters>
			</method>
			<method name="set_duration_mode" symbol="hildon_time_editor_set_duration_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
					<parameter name="duration_mode" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_duration_range" symbol="hildon_time_editor_set_duration_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
					<parameter name="min_seconds" type="guint"/>
					<parameter name="max_seconds" type="guint"/>
				</parameters>
			</method>
			<method name="set_show_hours" symbol="hildon_time_editor_set_show_hours">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
					<parameter name="show_hours" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_show_seconds" symbol="hildon_time_editor_set_show_seconds">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
					<parameter name="show_seconds" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_ticks" symbol="hildon_time_editor_set_ticks">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
					<parameter name="ticks" type="guint"/>
				</parameters>
			</method>
			<method name="set_time" symbol="hildon_time_editor_set_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
					<parameter name="hours" type="guint"/>
					<parameter name="minutes" type="guint"/>
					<parameter name="seconds" type="guint"/>
				</parameters>
			</method>
			<property name="duration-max" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="duration-min" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="duration-mode" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-hours" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-seconds" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ticks" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="time-error" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="editor" type="HildonTimeEditor*"/>
					<parameter name="type" type="HildonDateTimeError"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonTimePicker" parent="GtkDialog" type-name="HildonTimePicker" get-type="hildon_time_picker_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_time" symbol="hildon_time_picker_get_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="picker" type="HildonTimePicker*"/>
					<parameter name="hours" type="guint*"/>
					<parameter name="minutes" type="guint*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_time_picker_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
				</parameters>
			</constructor>
			<method name="set_time" symbol="hildon_time_picker_set_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="picker" type="HildonTimePicker*"/>
					<parameter name="hours" type="guint"/>
					<parameter name="minutes" type="guint"/>
				</parameters>
			</method>
			<property name="minutes" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonTimeSelector" parent="HildonTouchSelector" type-name="HildonTimeSelector" get-type="hildon_time_selector_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_time" symbol="hildon_time_selector_get_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTimeSelector*"/>
					<parameter name="hours" type="guint*"/>
					<parameter name="minutes" type="guint*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_time_selector_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_step" symbol="hildon_time_selector_new_step">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="minutes_step" type="guint"/>
				</parameters>
			</constructor>
			<method name="set_time" symbol="hildon_time_selector_set_time">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selector" type="HildonTimeSelector*"/>
					<parameter name="hours" type="guint"/>
					<parameter name="minutes" type="guint"/>
				</parameters>
			</method>
			<property name="minutes-step" type="guint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="time-format-policy" type="HildonTimeSelectorFormatPolicy" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="HildonTouchSelector" parent="GtkVBox" type-name="HildonTouchSelector" get-type="hildon_touch_selector_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="append_column" symbol="hildon_touch_selector_append_column">
				<return-type type="HildonTouchSelectorColumn*"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="model" type="GtkTreeModel*"/>
					<parameter name="cell_renderer" type="GtkCellRenderer*"/>
				</parameters>
			</method>
			<method name="append_text" symbol="hildon_touch_selector_append_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="append_text_column" symbol="hildon_touch_selector_append_text_column">
				<return-type type="HildonTouchSelectorColumn*"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="model" type="GtkTreeModel*"/>
					<parameter name="center" type="gboolean"/>
				</parameters>
			</method>
			<method name="center_on_selected" symbol="hildon_touch_selector_center_on_selected">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
				</parameters>
			</method>
			<method name="get_active" symbol="hildon_touch_selector_get_active">
				<return-type type="gint"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="get_column" symbol="hildon_touch_selector_get_column">
				<return-type type="HildonTouchSelectorColumn*"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="get_column_selection_mode" symbol="hildon_touch_selector_get_column_selection_mode">
				<return-type type="HildonTouchSelectorSelectionMode"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
				</parameters>
			</method>
			<method name="get_current_text" symbol="hildon_touch_selector_get_current_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
				</parameters>
			</method>
			<method name="get_hildon_ui_mode" symbol="hildon_touch_selector_get_hildon_ui_mode">
				<return-type type="HildonUIMode"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
				</parameters>
			</method>
			<method name="get_last_activated_row" symbol="hildon_touch_selector_get_last_activated_row">
				<return-type type="GtkTreePath*"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="get_model" symbol="hildon_touch_selector_get_model">
				<return-type type="GtkTreeModel*"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="get_num_columns" symbol="hildon_touch_selector_get_num_columns">
				<return-type type="gint"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
				</parameters>
			</method>
			<method name="get_print_func" symbol="hildon_touch_selector_get_print_func">
				<return-type type="HildonTouchSelectorPrintFunc"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
				</parameters>
			</method>
			<method name="get_selected" symbol="hildon_touch_selector_get_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<method name="get_selected_rows" symbol="hildon_touch_selector_get_selected_rows">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="insert_text" symbol="hildon_touch_selector_insert_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="position" type="gint"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_touch_selector_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_text" symbol="hildon_touch_selector_new_text">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="optimal_size_request" symbol="hildon_touch_selector_optimal_size_request">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="requisition" type="GtkRequisition*"/>
				</parameters>
			</method>
			<method name="prepend_text" symbol="hildon_touch_selector_prepend_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove_column" symbol="hildon_touch_selector_remove_column">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="select_iter" symbol="hildon_touch_selector_select_iter">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
					<parameter name="iter" type="GtkTreeIter*"/>
					<parameter name="scroll_to" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_active" symbol="hildon_touch_selector_set_active">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
					<parameter name="index" type="gint"/>
				</parameters>
			</method>
			<method name="set_column_attributes" symbol="hildon_touch_selector_set_column_attributes">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="num_column" type="gint"/>
					<parameter name="cell_renderer" type="GtkCellRenderer*"/>
				</parameters>
			</method>
			<method name="set_column_selection_mode" symbol="hildon_touch_selector_set_column_selection_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="mode" type="HildonTouchSelectorSelectionMode"/>
				</parameters>
			</method>
			<method name="set_hildon_ui_mode" symbol="hildon_touch_selector_set_hildon_ui_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="mode" type="HildonUIMode"/>
				</parameters>
			</method>
			<method name="set_model" symbol="hildon_touch_selector_set_model">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
					<parameter name="model" type="GtkTreeModel*"/>
				</parameters>
			</method>
			<method name="set_print_func" symbol="hildon_touch_selector_set_print_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="func" type="HildonTouchSelectorPrintFunc"/>
				</parameters>
			</method>
			<method name="set_print_func_full" symbol="hildon_touch_selector_set_print_func_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="func" type="HildonTouchSelectorPrintFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="destroy_func" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="unselect_all" symbol="hildon_touch_selector_unselect_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="unselect_iter" symbol="hildon_touch_selector_unselect_iter">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<property name="has-multiple-selection" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="hildon-ui-mode" type="HildonUIMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="initial-scroll" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</signal>
			<signal name="columns-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="HildonTouchSelector*"/>
				</parameters>
			</signal>
			<vfunc name="set_model">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelector*"/>
					<parameter name="column" type="gint"/>
					<parameter name="model" type="GtkTreeModel*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="HildonTouchSelectorColumn" parent="GObject" type-name="HildonTouchSelectorColumn" get-type="hildon_touch_selector_column_get_type">
			<implements>
				<interface name="GtkCellLayout"/>
			</implements>
			<method name="get_text_column" symbol="hildon_touch_selector_column_get_text_column">
				<return-type type="gint"/>
				<parameters>
					<parameter name="column" type="HildonTouchSelectorColumn*"/>
				</parameters>
			</method>
			<method name="set_text_column" symbol="hildon_touch_selector_column_set_text_column">
				<return-type type="void"/>
				<parameters>
					<parameter name="column" type="HildonTouchSelectorColumn*"/>
					<parameter name="text_column" type="gint"/>
				</parameters>
			</method>
			<property name="text-column" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonTouchSelectorEntry" parent="HildonTouchSelector" type-name="HildonTouchSelectorEntry" get-type="hildon_touch_selector_entry_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_entry" symbol="hildon_touch_selector_entry_get_entry">
				<return-type type="HildonEntry*"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelectorEntry*"/>
				</parameters>
			</method>
			<method name="get_input_mode" symbol="hildon_touch_selector_entry_get_input_mode">
				<return-type type="HildonGtkInputMode"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelectorEntry*"/>
				</parameters>
			</method>
			<method name="get_text_column" symbol="hildon_touch_selector_entry_get_text_column">
				<return-type type="gint"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelectorEntry*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_touch_selector_entry_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_text" symbol="hildon_touch_selector_entry_new_text">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_input_mode" symbol="hildon_touch_selector_entry_set_input_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelectorEntry*"/>
					<parameter name="input_mode" type="HildonGtkInputMode"/>
				</parameters>
			</method>
			<method name="set_text_column" symbol="hildon_touch_selector_entry_set_text_column">
				<return-type type="void"/>
				<parameters>
					<parameter name="selector" type="HildonTouchSelectorEntry*"/>
					<parameter name="text_column" type="gint"/>
				</parameters>
			</method>
			<property name="text-column" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonVVolumebar" parent="HildonVolumebar" type-name="HildonVVolumebar" get-type="hildon_vvolumebar_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="hildon_vvolumebar_new">
				<return-type type="GtkWidget*"/>
			</constructor>
		</object>
		<object name="HildonVolumebar" parent="GtkContainer" type-name="HildonVolumebar" get-type="hildon_volumebar_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_adjustment" symbol="hildon_volumebar_get_adjustment">
				<return-type type="GtkAdjustment*"/>
				<parameters>
					<parameter name="self" type="HildonVolumebar*"/>
				</parameters>
			</method>
			<method name="get_level" symbol="hildon_volumebar_get_level">
				<return-type type="double"/>
				<parameters>
					<parameter name="self" type="HildonVolumebar*"/>
				</parameters>
			</method>
			<method name="get_mute" symbol="hildon_volumebar_get_mute">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonVolumebar*"/>
				</parameters>
			</method>
			<method name="set_level" symbol="hildon_volumebar_set_level">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonVolumebar*"/>
					<parameter name="level" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_mute" symbol="hildon_volumebar_set_mute">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonVolumebar*"/>
					<parameter name="mute" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_range_insensitive_message" symbol="hildon_volumebar_set_range_insensitive_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="HildonVolumebar*"/>
					<parameter name="message" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_range_insensitive_messagef" symbol="hildon_volumebar_set_range_insensitive_messagef">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="HildonVolumebar*"/>
					<parameter name="format" type="gchar*"/>
				</parameters>
			</method>
			<property name="has-mute" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="level" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="mute" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="level-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonVolumebar*"/>
				</parameters>
			</signal>
			<signal name="mute-toggled" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonVolumebar*"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonVolumebarRange" parent="GtkScale" type-name="HildonVolumebarRange" get-type="hildon_volumebar_range_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_level" symbol="hildon_volumebar_range_get_level">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="HildonVolumebarRange*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_volumebar_range_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="orientation" type="GtkOrientation"/>
				</parameters>
			</constructor>
			<method name="set_level" symbol="hildon_volumebar_range_set_level">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonVolumebarRange*"/>
					<parameter name="level" type="gdouble"/>
				</parameters>
			</method>
			<property name="level" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonWeekdayPicker" parent="GtkContainer" type-name="HildonWeekdayPicker" get-type="hildon_weekday_picker_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="isset_day" symbol="hildon_weekday_picker_isset_day">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="picker" type="HildonWeekdayPicker*"/>
					<parameter name="day" type="GDateWeekday"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_weekday_picker_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_all" symbol="hildon_weekday_picker_set_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="picker" type="HildonWeekdayPicker*"/>
				</parameters>
			</method>
			<method name="set_day" symbol="hildon_weekday_picker_set_day">
				<return-type type="void"/>
				<parameters>
					<parameter name="picker" type="HildonWeekdayPicker*"/>
					<parameter name="day" type="GDateWeekday"/>
				</parameters>
			</method>
			<method name="toggle_day" symbol="hildon_weekday_picker_toggle_day">
				<return-type type="void"/>
				<parameters>
					<parameter name="picker" type="HildonWeekdayPicker*"/>
					<parameter name="day" type="GDateWeekday"/>
				</parameters>
			</method>
			<method name="unset_all" symbol="hildon_weekday_picker_unset_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="picker" type="HildonWeekdayPicker*"/>
				</parameters>
			</method>
			<method name="unset_day" symbol="hildon_weekday_picker_unset_day">
				<return-type type="void"/>
				<parameters>
					<parameter name="picker" type="HildonWeekdayPicker*"/>
					<parameter name="day" type="GDateWeekday"/>
				</parameters>
			</method>
			<signal name="selection-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonWeekdayPicker*"/>
					<parameter name="p0" type="gint"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonWindow" parent="GtkWindow" type-name="HildonWindow" get-type="hildon_window_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="add_toolbar" symbol="hildon_window_add_toolbar">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
					<parameter name="toolbar" type="GtkToolbar*"/>
				</parameters>
			</method>
			<method name="add_with_scrollbar" symbol="hildon_window_add_with_scrollbar">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
					<parameter name="child" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="get_app_menu" symbol="hildon_window_get_app_menu">
				<return-type type="HildonAppMenu*"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
				</parameters>
			</method>
			<method name="get_is_topmost" symbol="hildon_window_get_is_topmost">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
				</parameters>
			</method>
			<method name="get_main_menu" symbol="hildon_window_get_main_menu">
				<return-type type="GtkMenu*"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
				</parameters>
			</method>
			<method name="get_markup" symbol="hildon_window_get_markup">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="window" type="HildonWindow*"/>
				</parameters>
			</method>
			<method name="get_menu" symbol="hildon_window_get_menu">
				<return-type type="GtkMenu*"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_window_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="remove_toolbar" symbol="hildon_window_remove_toolbar">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
					<parameter name="toolbar" type="GtkToolbar*"/>
				</parameters>
			</method>
			<method name="set_app_menu" symbol="hildon_window_set_app_menu">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
					<parameter name="menu" type="HildonAppMenu*"/>
				</parameters>
			</method>
			<method name="set_edit_toolbar" symbol="hildon_window_set_edit_toolbar">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
					<parameter name="toolbar" type="HildonEditToolbar*"/>
				</parameters>
			</method>
			<method name="set_main_menu" symbol="hildon_window_set_main_menu">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
					<parameter name="menu" type="GtkMenu*"/>
				</parameters>
			</method>
			<method name="set_markup" symbol="hildon_window_set_markup">
				<return-type type="void"/>
				<parameters>
					<parameter name="window" type="HildonWindow*"/>
					<parameter name="markup" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_menu" symbol="hildon_window_set_menu">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
					<parameter name="menu" type="GtkMenu*"/>
				</parameters>
			</method>
			<property name="is-topmost" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="markup" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="clipboard-operation" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="hwindow" type="HildonWindow*"/>
					<parameter name="operation" type="gint"/>
				</parameters>
			</signal>
			<vfunc name="toggle_menu">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
					<parameter name="button" type="guint"/>
					<parameter name="time" type="guint32"/>
				</parameters>
			</vfunc>
		</object>
		<object name="HildonWindowStack" parent="GObject" type-name="HildonWindowStack" get-type="hildon_window_stack_get_type">
			<method name="get_default" symbol="hildon_window_stack_get_default">
				<return-type type="HildonWindowStack*"/>
			</method>
			<method name="get_windows" symbol="hildon_window_stack_get_windows">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="stack" type="HildonWindowStack*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_window_stack_new">
				<return-type type="HildonWindowStack*"/>
			</constructor>
			<method name="peek" symbol="hildon_window_stack_peek">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="stack" type="HildonWindowStack*"/>
				</parameters>
			</method>
			<method name="pop" symbol="hildon_window_stack_pop">
				<return-type type="void"/>
				<parameters>
					<parameter name="stack" type="HildonWindowStack*"/>
					<parameter name="nwindows" type="gint"/>
					<parameter name="popped_windows" type="GList**"/>
				</parameters>
			</method>
			<method name="pop_1" symbol="hildon_window_stack_pop_1">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="stack" type="HildonWindowStack*"/>
				</parameters>
			</method>
			<method name="pop_and_push" symbol="hildon_window_stack_pop_and_push">
				<return-type type="void"/>
				<parameters>
					<parameter name="stack" type="HildonWindowStack*"/>
					<parameter name="nwindows" type="gint"/>
					<parameter name="popped_windows" type="GList**"/>
					<parameter name="win1" type="HildonStackableWindow*"/>
				</parameters>
			</method>
			<method name="pop_and_push_list" symbol="hildon_window_stack_pop_and_push_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="stack" type="HildonWindowStack*"/>
					<parameter name="nwindows" type="gint"/>
					<parameter name="popped_windows" type="GList**"/>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="push" symbol="hildon_window_stack_push">
				<return-type type="void"/>
				<parameters>
					<parameter name="stack" type="HildonWindowStack*"/>
					<parameter name="win1" type="HildonStackableWindow*"/>
				</parameters>
			</method>
			<method name="push_1" symbol="hildon_window_stack_push_1">
				<return-type type="void"/>
				<parameters>
					<parameter name="stack" type="HildonWindowStack*"/>
					<parameter name="win" type="HildonStackableWindow*"/>
				</parameters>
			</method>
			<method name="push_list" symbol="hildon_window_stack_push_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="stack" type="HildonWindowStack*"/>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="size" symbol="hildon_window_stack_size">
				<return-type type="gint"/>
				<parameters>
					<parameter name="stack" type="HildonWindowStack*"/>
				</parameters>
			</method>
			<property name="window-group" type="GtkWindowGroup*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="HildonWizardDialog" parent="GtkDialog" type-name="HildonWizardDialog" get-type="hildon_wizard_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="hildon_wizard_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="wizard_name" type="char*"/>
					<parameter name="notebook" type="GtkNotebook*"/>
				</parameters>
			</constructor>
			<method name="set_forward_page_func" symbol="hildon_wizard_dialog_set_forward_page_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="wizard_dialog" type="HildonWizardDialog*"/>
					<parameter name="page_func" type="HildonWizardDialogPageFunc"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<property name="autotitle" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="wizard-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="wizard-notebook" type="GtkNotebook*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<interface name="HildonBreadCrumb" type-name="HildonBreadCrumb" get-type="hildon_bread_crumb_get_type">
			<requires>
				<interface name="GtkWidget"/>
			</requires>
			<method name="activated" symbol="hildon_bread_crumb_activated">
				<return-type type="void"/>
				<parameters>
					<parameter name="bread_crumb" type="HildonBreadCrumb*"/>
				</parameters>
			</method>
			<method name="get_natural_size" symbol="hildon_bread_crumb_get_natural_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="bread_crumb" type="HildonBreadCrumb*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
				</parameters>
			</method>
			<signal name="crumb-activated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="bread_crumb" type="HildonBreadCrumb*"/>
				</parameters>
			</signal>
			<vfunc name="get_natural_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="bread_crumb" type="HildonBreadCrumb*"/>
					<parameter name="natural_width" type="gint*"/>
					<parameter name="natural_height" type="gint*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="HILDON_AA_CENTER_GRAVITY" type="int" value="9"/>
		<constant name="HILDON_AA_E_GRAVITY" type="int" value="3"/>
		<constant name="HILDON_AA_NE_GRAVITY" type="int" value="2"/>
		<constant name="HILDON_AA_NW_GRAVITY" type="int" value="8"/>
		<constant name="HILDON_AA_N_GRAVITY" type="int" value="1"/>
		<constant name="HILDON_AA_SE_GRAVITY" type="int" value="4"/>
		<constant name="HILDON_AA_SW_GRAVITY" type="int" value="6"/>
		<constant name="HILDON_AA_S_GRAVITY" type="int" value="5"/>
		<constant name="HILDON_AA_W_GRAVITY" type="int" value="7"/>
		<constant name="HILDON_AA_X_AXIS" type="int" value="0"/>
		<constant name="HILDON_AA_Y_AXIS" type="int" value="1"/>
		<constant name="HILDON_AA_Z_AXIS" type="int" value="2"/>
		<constant name="HILDON_MAJOR_VERSION" type="int" value="2"/>
		<constant name="HILDON_MARGIN_DEFAULT" type="int" value="8"/>
		<constant name="HILDON_MARGIN_DOUBLE" type="int" value="16"/>
		<constant name="HILDON_MARGIN_HALF" type="int" value="4"/>
		<constant name="HILDON_MARGIN_TRIPLE" type="int" value="24"/>
		<constant name="HILDON_MICRO_VERSION" type="int" value="86"/>
		<constant name="HILDON_MINOR_VERSION" type="int" value="1"/>
		<constant name="HILDON_WINDOW_LONG_PRESS_TIME" type="int" value="800"/>
		<constant name="HILDON_WINDOW_TITLEBAR_HEIGHT" type="int" value="56"/>
	</namespace>
</api>
