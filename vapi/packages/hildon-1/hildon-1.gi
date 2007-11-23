<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Hildon">
		<function name="get_icon_pixel_size" symbol="hildon_get_icon_pixel_size">
			<return-type type="gint"/>
			<parameters>
				<parameter name="size" type="GtkIconSize"/>
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
		<function name="play_system_sound" symbol="hildon_play_system_sound">
			<return-type type="void"/>
			<parameters>
				<parameter name="sample" type="gchar*"/>
			</parameters>
		</function>
		<enum name="HildonCaptionIconPosition">
			<member name="HILDON_CAPTION_POSITION_LEFT" value="0"/>
			<member name="HILDON_CAPTION_POSITION_RIGHT" value="1"/>
		</enum>
		<enum name="HildonCaptionStatus">
			<member name="HILDON_CAPTION_OPTIONAL" value="0"/>
			<member name="HILDON_CAPTION_MANDATORY" value="1"/>
		</enum>
		<enum name="HildonDateTimeError">
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
		<enum name="HildonNoteType">
			<member name="HILDON_NOTE_TYPE_CONFIRMATION" value="0"/>
			<member name="HILDON_NOTE_TYPE_CONFIRMATION_BUTTON" value="1"/>
			<member name="HILDON_NOTE_TYPE_INFORMATION" value="2"/>
			<member name="HILDON_NOTE_TYPE_INFORMATION_THEME" value="3"/>
			<member name="HILDON_NOTE_TYPE_PROGRESSBAR" value="4"/>
		</enum>
		<enum name="HildonNumberEditorErrorType">
			<member name="HILDON_NUMBER_EDITOR_ERROR_MAXIMUM_VALUE_EXCEED" value="0"/>
			<member name="HILDON_NUMBER_EDITOR_ERROR_MINIMUM_VALUE_EXCEED" value="1"/>
			<member name="HILDON_NUMBER_EDITOR_ERROR_ERRONEOUS_VALUE" value="2"/>
		</enum>
		<enum name="HildonWindowClipboardOperation">
			<member name="HILDON_WINDOW_CO_COPY" value="0"/>
			<member name="HILDON_WINDOW_CO_CUT" value="1"/>
			<member name="HILDON_WINDOW_CO_PASTE" value="2"/>
		</enum>
		<enum name="HildonWizardDialogResponse">
			<member name="HILDON_WIZARD_DIALOG_CANCEL" value="-6"/>
			<member name="HILDON_WIZARD_DIALOG_PREVIOUS" value="0"/>
			<member name="HILDON_WIZARD_DIALOG_NEXT" value="1"/>
			<member name="HILDON_WIZARD_DIALOG_FINISH" value="2"/>
		</enum>
		<flags name="HildonCalendarDisplayOptions">
			<member name="HILDON_CALENDAR_SHOW_HEADING" value="1"/>
			<member name="HILDON_CALENDAR_SHOW_DAY_NAMES" value="2"/>
			<member name="HILDON_CALENDAR_NO_MONTH_CHANGE" value="4"/>
			<member name="HILDON_CALENDAR_SHOW_WEEK_NUMBERS" value="8"/>
			<member name="HILDON_CALENDAR_WEEK_START_MONDAY" value="16"/>
		</flags>
		<object name="HildonBanner" parent="GtkWindow" type-name="HildonBanner" get-type="hildon_banner_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
					<parameter name="notify" type="GDestroyNotify"/>
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
					<parameter name="notify" type="GDestroyNotify"/>
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
		<object name="HildonCalendar" parent="GtkWidget" type-name="HildonCalendar" get-type="hildon_calendar_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
		<object name="HildonCodeDialog" parent="GtkDialog" type-name="HildonCodeDialog" get-type="hildon_code_dialog_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
		</object>
		<object name="HildonColorChooser" parent="GtkWidget" type-name="HildonColorChooser" get-type="hildon_color_chooser_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
		<object name="HildonDateEditor" parent="GtkContainer" type-name="HildonDateEditor" get-type="hildon_date_editor_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
		<object name="HildonFindToolbar" parent="GtkToolbar" type-name="HildonFindToolbar" get-type="hildon_find_toolbar_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
			</implements>
			<constructor name="new" symbol="hildon_hvolumebar_new">
				<return-type type="GtkWidget*"/>
			</constructor>
		</object>
		<object name="HildonLoginDialog" parent="GtkDialog" type-name="HildonLoginDialog" get-type="hildon_login_dialog_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
		<object name="HildonSeekbar" parent="GtkScale" type-name="HildonSeekbar" get-type="hildon_seekbar_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
		<object name="HildonTimeEditor" parent="GtkContainer" type-name="HildonTimeEditor" get-type="hildon_time_editor_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
		<object name="HildonVVolumebar" parent="HildonVolumebar" type-name="HildonVVolumebar" get-type="hildon_vvolumebar_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
			</implements>
			<constructor name="new" symbol="hildon_vvolumebar_new">
				<return-type type="GtkWidget*"/>
			</constructor>
		</object>
		<object name="HildonVolumebar" parent="GtkContainer" type-name="HildonVolumebar" get-type="hildon_volumebar_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
			<property name="can-focus" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
			<method name="get_is_topmost" symbol="hildon_window_get_is_topmost">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
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
			<method name="set_menu" symbol="hildon_window_set_menu">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonWindow*"/>
					<parameter name="menu" type="GtkMenu*"/>
				</parameters>
			</method>
			<property name="is-topmost" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="clipboard-operation" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="hwindow" type="HildonWindow*"/>
					<parameter name="operation" type="gint"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonWizardDialog" parent="GtkDialog" type-name="HildonWizardDialog" get-type="hildon_wizard_dialog_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
			</implements>
			<constructor name="new" symbol="hildon_wizard_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="wizard_name" type="char*"/>
					<parameter name="notebook" type="GtkNotebook*"/>
				</parameters>
			</constructor>
			<property name="autotitle" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="wizard-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="wizard-notebook" type="GtkNotebook*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<interface name="HildonBreadCrumb" type-name="HildonBreadCrumb" get-type="hildon_bread_crumb_get_type">
			<requires>
				<interface name="GInitiallyUnowned"/>
				<interface name="GtkObject"/>
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
		<constant name="HILDON_MAJOR_VERSION" type="int" value="1"/>
		<constant name="HILDON_MARGIN_DEFAULT" type="int" value="6"/>
		<constant name="HILDON_MARGIN_DOUBLE" type="int" value="12"/>
		<constant name="HILDON_MARGIN_HALF" type="int" value="3"/>
		<constant name="HILDON_MARGIN_TRIPLE" type="int" value="18"/>
		<constant name="HILDON_MICRO_VERSION" type="int" value="0"/>
		<constant name="HILDON_MINOR_VERSION" type="int" value="99"/>
		<constant name="HILDON_WINDOW_LONG_PRESS_TIME" type="int" value="800"/>
	</namespace>
</api>
