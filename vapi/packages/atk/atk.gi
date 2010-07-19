<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Atk">
		<function name="add_focus_tracker" symbol="atk_add_focus_tracker">
			<return-type type="guint"/>
			<parameters>
				<parameter name="focus_tracker" type="AtkEventListener"/>
			</parameters>
		</function>
		<function name="add_global_event_listener" symbol="atk_add_global_event_listener">
			<return-type type="guint"/>
			<parameters>
				<parameter name="listener" type="GSignalEmissionHook"/>
				<parameter name="event_type" type="gchar*"/>
			</parameters>
		</function>
		<function name="add_key_event_listener" symbol="atk_add_key_event_listener">
			<return-type type="guint"/>
			<parameters>
				<parameter name="listener" type="AtkKeySnoopFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="focus_tracker_init" symbol="atk_focus_tracker_init">
			<return-type type="void"/>
			<parameters>
				<parameter name="init" type="AtkEventListenerInit"/>
			</parameters>
		</function>
		<function name="focus_tracker_notify" symbol="atk_focus_tracker_notify">
			<return-type type="void"/>
			<parameters>
				<parameter name="object" type="AtkObject*"/>
			</parameters>
		</function>
		<function name="get_default_registry" symbol="atk_get_default_registry">
			<return-type type="AtkRegistry*"/>
		</function>
		<function name="get_focus_object" symbol="atk_get_focus_object">
			<return-type type="AtkObject*"/>
		</function>
		<function name="get_root" symbol="atk_get_root">
			<return-type type="AtkObject*"/>
		</function>
		<function name="get_toolkit_name" symbol="atk_get_toolkit_name">
			<return-type type="gchar*"/>
		</function>
		<function name="get_toolkit_version" symbol="atk_get_toolkit_version">
			<return-type type="gchar*"/>
		</function>
		<function name="get_version" symbol="atk_get_version">
			<return-type type="gchar*"/>
		</function>
		<function name="remove_focus_tracker" symbol="atk_remove_focus_tracker">
			<return-type type="void"/>
			<parameters>
				<parameter name="tracker_id" type="guint"/>
			</parameters>
		</function>
		<function name="remove_global_event_listener" symbol="atk_remove_global_event_listener">
			<return-type type="void"/>
			<parameters>
				<parameter name="listener_id" type="guint"/>
			</parameters>
		</function>
		<function name="remove_key_event_listener" symbol="atk_remove_key_event_listener">
			<return-type type="void"/>
			<parameters>
				<parameter name="listener_id" type="guint"/>
			</parameters>
		</function>
		<function name="role_for_name" symbol="atk_role_for_name">
			<return-type type="AtkRole"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="role_get_localized_name" symbol="atk_role_get_localized_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="role" type="AtkRole"/>
			</parameters>
		</function>
		<function name="role_get_name" symbol="atk_role_get_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="role" type="AtkRole"/>
			</parameters>
		</function>
		<function name="role_register" symbol="atk_role_register">
			<return-type type="AtkRole"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<callback name="AtkEventListener">
			<return-type type="void"/>
			<parameters>
				<parameter name="obj" type="AtkObject*"/>
			</parameters>
		</callback>
		<callback name="AtkEventListenerInit">
			<return-type type="void"/>
		</callback>
		<callback name="AtkFocusHandler">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="AtkObject*"/>
				<parameter name="p2" type="gboolean"/>
			</parameters>
		</callback>
		<callback name="AtkFunction">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="AtkKeySnoopFunc">
			<return-type type="gint"/>
			<parameters>
				<parameter name="event" type="AtkKeyEventStruct*"/>
				<parameter name="func_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="AtkPropertyChangeHandler">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="AtkObject*"/>
				<parameter name="p2" type="AtkPropertyValues*"/>
			</parameters>
		</callback>
		<struct name="AtkAttribute">
			<field name="name" type="gchar*"/>
			<field name="value" type="gchar*"/>
		</struct>
		<struct name="AtkAttributeSet">
			<method name="free" symbol="atk_attribute_set_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="attrib_set" type="AtkAttributeSet*"/>
				</parameters>
			</method>
		</struct>
		<struct name="AtkKeyEventStruct">
			<field name="type" type="gint"/>
			<field name="state" type="guint"/>
			<field name="keyval" type="guint"/>
			<field name="length" type="gint"/>
			<field name="string" type="gchar*"/>
			<field name="keycode" type="guint16"/>
			<field name="timestamp" type="guint32"/>
		</struct>
		<struct name="AtkPropertyValues">
			<field name="property_name" type="gchar*"/>
			<field name="old_value" type="GValue"/>
			<field name="new_value" type="GValue"/>
		</struct>
		<struct name="AtkState">
			<method name="type_for_name" symbol="atk_state_type_for_name">
				<return-type type="AtkStateType"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="type_get_name" symbol="atk_state_type_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="type" type="AtkStateType"/>
				</parameters>
			</method>
			<method name="type_register" symbol="atk_state_type_register">
				<return-type type="AtkStateType"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
		</struct>
		<struct name="AtkTextRange">
			<field name="bounds" type="AtkTextRectangle"/>
			<field name="start_offset" type="gint"/>
			<field name="end_offset" type="gint"/>
			<field name="content" type="gchar*"/>
		</struct>
		<struct name="AtkTextRectangle">
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
			<field name="width" type="gint"/>
			<field name="height" type="gint"/>
		</struct>
		<boxed name="AtkRectangle" type-name="AtkRectangle" get-type="atk_rectangle_get_type">
			<field name="x" type="gint"/>
			<field name="y" type="gint"/>
			<field name="width" type="gint"/>
			<field name="height" type="gint"/>
		</boxed>
		<enum name="AtkCoordType" type-name="AtkCoordType" get-type="atk_coord_type_get_type">
			<member name="ATK_XY_SCREEN" value="0"/>
			<member name="ATK_XY_WINDOW" value="1"/>
		</enum>
		<enum name="AtkKeyEventType" type-name="AtkKeyEventType" get-type="atk_key_event_type_get_type">
			<member name="ATK_KEY_EVENT_PRESS" value="0"/>
			<member name="ATK_KEY_EVENT_RELEASE" value="1"/>
			<member name="ATK_KEY_EVENT_LAST_DEFINED" value="2"/>
		</enum>
		<enum name="AtkLayer" type-name="AtkLayer" get-type="atk_layer_get_type">
			<member name="ATK_LAYER_INVALID" value="0"/>
			<member name="ATK_LAYER_BACKGROUND" value="1"/>
			<member name="ATK_LAYER_CANVAS" value="2"/>
			<member name="ATK_LAYER_WIDGET" value="3"/>
			<member name="ATK_LAYER_MDI" value="4"/>
			<member name="ATK_LAYER_POPUP" value="5"/>
			<member name="ATK_LAYER_OVERLAY" value="6"/>
			<member name="ATK_LAYER_WINDOW" value="7"/>
		</enum>
		<enum name="AtkRelationType" type-name="AtkRelationType" get-type="atk_relation_type_get_type">
			<member name="ATK_RELATION_NULL" value="0"/>
			<member name="ATK_RELATION_CONTROLLED_BY" value="1"/>
			<member name="ATK_RELATION_CONTROLLER_FOR" value="2"/>
			<member name="ATK_RELATION_LABEL_FOR" value="3"/>
			<member name="ATK_RELATION_LABELLED_BY" value="4"/>
			<member name="ATK_RELATION_MEMBER_OF" value="5"/>
			<member name="ATK_RELATION_NODE_CHILD_OF" value="6"/>
			<member name="ATK_RELATION_FLOWS_TO" value="7"/>
			<member name="ATK_RELATION_FLOWS_FROM" value="8"/>
			<member name="ATK_RELATION_SUBWINDOW_OF" value="9"/>
			<member name="ATK_RELATION_EMBEDS" value="10"/>
			<member name="ATK_RELATION_EMBEDDED_BY" value="11"/>
			<member name="ATK_RELATION_POPUP_FOR" value="12"/>
			<member name="ATK_RELATION_PARENT_WINDOW_OF" value="13"/>
			<member name="ATK_RELATION_DESCRIBED_BY" value="14"/>
			<member name="ATK_RELATION_DESCRIPTION_FOR" value="15"/>
			<member name="ATK_RELATION_NODE_PARENT_OF" value="16"/>
			<member name="ATK_RELATION_LAST_DEFINED" value="17"/>
		</enum>
		<enum name="AtkRole" type-name="AtkRole" get-type="atk_role_get_type">
			<member name="ATK_ROLE_INVALID" value="0"/>
			<member name="ATK_ROLE_ACCEL_LABEL" value="1"/>
			<member name="ATK_ROLE_ALERT" value="2"/>
			<member name="ATK_ROLE_ANIMATION" value="3"/>
			<member name="ATK_ROLE_ARROW" value="4"/>
			<member name="ATK_ROLE_CALENDAR" value="5"/>
			<member name="ATK_ROLE_CANVAS" value="6"/>
			<member name="ATK_ROLE_CHECK_BOX" value="7"/>
			<member name="ATK_ROLE_CHECK_MENU_ITEM" value="8"/>
			<member name="ATK_ROLE_COLOR_CHOOSER" value="9"/>
			<member name="ATK_ROLE_COLUMN_HEADER" value="10"/>
			<member name="ATK_ROLE_COMBO_BOX" value="11"/>
			<member name="ATK_ROLE_DATE_EDITOR" value="12"/>
			<member name="ATK_ROLE_DESKTOP_ICON" value="13"/>
			<member name="ATK_ROLE_DESKTOP_FRAME" value="14"/>
			<member name="ATK_ROLE_DIAL" value="15"/>
			<member name="ATK_ROLE_DIALOG" value="16"/>
			<member name="ATK_ROLE_DIRECTORY_PANE" value="17"/>
			<member name="ATK_ROLE_DRAWING_AREA" value="18"/>
			<member name="ATK_ROLE_FILE_CHOOSER" value="19"/>
			<member name="ATK_ROLE_FILLER" value="20"/>
			<member name="ATK_ROLE_FONT_CHOOSER" value="21"/>
			<member name="ATK_ROLE_FRAME" value="22"/>
			<member name="ATK_ROLE_GLASS_PANE" value="23"/>
			<member name="ATK_ROLE_HTML_CONTAINER" value="24"/>
			<member name="ATK_ROLE_ICON" value="25"/>
			<member name="ATK_ROLE_IMAGE" value="26"/>
			<member name="ATK_ROLE_INTERNAL_FRAME" value="27"/>
			<member name="ATK_ROLE_LABEL" value="28"/>
			<member name="ATK_ROLE_LAYERED_PANE" value="29"/>
			<member name="ATK_ROLE_LIST" value="30"/>
			<member name="ATK_ROLE_LIST_ITEM" value="31"/>
			<member name="ATK_ROLE_MENU" value="32"/>
			<member name="ATK_ROLE_MENU_BAR" value="33"/>
			<member name="ATK_ROLE_MENU_ITEM" value="34"/>
			<member name="ATK_ROLE_OPTION_PANE" value="35"/>
			<member name="ATK_ROLE_PAGE_TAB" value="36"/>
			<member name="ATK_ROLE_PAGE_TAB_LIST" value="37"/>
			<member name="ATK_ROLE_PANEL" value="38"/>
			<member name="ATK_ROLE_PASSWORD_TEXT" value="39"/>
			<member name="ATK_ROLE_POPUP_MENU" value="40"/>
			<member name="ATK_ROLE_PROGRESS_BAR" value="41"/>
			<member name="ATK_ROLE_PUSH_BUTTON" value="42"/>
			<member name="ATK_ROLE_RADIO_BUTTON" value="43"/>
			<member name="ATK_ROLE_RADIO_MENU_ITEM" value="44"/>
			<member name="ATK_ROLE_ROOT_PANE" value="45"/>
			<member name="ATK_ROLE_ROW_HEADER" value="46"/>
			<member name="ATK_ROLE_SCROLL_BAR" value="47"/>
			<member name="ATK_ROLE_SCROLL_PANE" value="48"/>
			<member name="ATK_ROLE_SEPARATOR" value="49"/>
			<member name="ATK_ROLE_SLIDER" value="50"/>
			<member name="ATK_ROLE_SPLIT_PANE" value="51"/>
			<member name="ATK_ROLE_SPIN_BUTTON" value="52"/>
			<member name="ATK_ROLE_STATUSBAR" value="53"/>
			<member name="ATK_ROLE_TABLE" value="54"/>
			<member name="ATK_ROLE_TABLE_CELL" value="55"/>
			<member name="ATK_ROLE_TABLE_COLUMN_HEADER" value="56"/>
			<member name="ATK_ROLE_TABLE_ROW_HEADER" value="57"/>
			<member name="ATK_ROLE_TEAR_OFF_MENU_ITEM" value="58"/>
			<member name="ATK_ROLE_TERMINAL" value="59"/>
			<member name="ATK_ROLE_TEXT" value="60"/>
			<member name="ATK_ROLE_TOGGLE_BUTTON" value="61"/>
			<member name="ATK_ROLE_TOOL_BAR" value="62"/>
			<member name="ATK_ROLE_TOOL_TIP" value="63"/>
			<member name="ATK_ROLE_TREE" value="64"/>
			<member name="ATK_ROLE_TREE_TABLE" value="65"/>
			<member name="ATK_ROLE_UNKNOWN" value="66"/>
			<member name="ATK_ROLE_VIEWPORT" value="67"/>
			<member name="ATK_ROLE_WINDOW" value="68"/>
			<member name="ATK_ROLE_HEADER" value="69"/>
			<member name="ATK_ROLE_FOOTER" value="70"/>
			<member name="ATK_ROLE_PARAGRAPH" value="71"/>
			<member name="ATK_ROLE_RULER" value="72"/>
			<member name="ATK_ROLE_APPLICATION" value="73"/>
			<member name="ATK_ROLE_AUTOCOMPLETE" value="74"/>
			<member name="ATK_ROLE_EDITBAR" value="75"/>
			<member name="ATK_ROLE_EMBEDDED" value="76"/>
			<member name="ATK_ROLE_ENTRY" value="77"/>
			<member name="ATK_ROLE_CHART" value="78"/>
			<member name="ATK_ROLE_CAPTION" value="79"/>
			<member name="ATK_ROLE_DOCUMENT_FRAME" value="80"/>
			<member name="ATK_ROLE_HEADING" value="81"/>
			<member name="ATK_ROLE_PAGE" value="82"/>
			<member name="ATK_ROLE_SECTION" value="83"/>
			<member name="ATK_ROLE_REDUNDANT_OBJECT" value="84"/>
			<member name="ATK_ROLE_FORM" value="85"/>
			<member name="ATK_ROLE_LINK" value="86"/>
			<member name="ATK_ROLE_INPUT_METHOD_WINDOW" value="87"/>
			<member name="ATK_ROLE_LAST_DEFINED" value="88"/>
		</enum>
		<enum name="AtkStateType" type-name="AtkStateType" get-type="atk_state_type_get_type">
			<member name="ATK_STATE_INVALID" value="0"/>
			<member name="ATK_STATE_ACTIVE" value="1"/>
			<member name="ATK_STATE_ARMED" value="2"/>
			<member name="ATK_STATE_BUSY" value="3"/>
			<member name="ATK_STATE_CHECKED" value="4"/>
			<member name="ATK_STATE_DEFUNCT" value="5"/>
			<member name="ATK_STATE_EDITABLE" value="6"/>
			<member name="ATK_STATE_ENABLED" value="7"/>
			<member name="ATK_STATE_EXPANDABLE" value="8"/>
			<member name="ATK_STATE_EXPANDED" value="9"/>
			<member name="ATK_STATE_FOCUSABLE" value="10"/>
			<member name="ATK_STATE_FOCUSED" value="11"/>
			<member name="ATK_STATE_HORIZONTAL" value="12"/>
			<member name="ATK_STATE_ICONIFIED" value="13"/>
			<member name="ATK_STATE_MODAL" value="14"/>
			<member name="ATK_STATE_MULTI_LINE" value="15"/>
			<member name="ATK_STATE_MULTISELECTABLE" value="16"/>
			<member name="ATK_STATE_OPAQUE" value="17"/>
			<member name="ATK_STATE_PRESSED" value="18"/>
			<member name="ATK_STATE_RESIZABLE" value="19"/>
			<member name="ATK_STATE_SELECTABLE" value="20"/>
			<member name="ATK_STATE_SELECTED" value="21"/>
			<member name="ATK_STATE_SENSITIVE" value="22"/>
			<member name="ATK_STATE_SHOWING" value="23"/>
			<member name="ATK_STATE_SINGLE_LINE" value="24"/>
			<member name="ATK_STATE_STALE" value="25"/>
			<member name="ATK_STATE_TRANSIENT" value="26"/>
			<member name="ATK_STATE_VERTICAL" value="27"/>
			<member name="ATK_STATE_VISIBLE" value="28"/>
			<member name="ATK_STATE_MANAGES_DESCENDANTS" value="29"/>
			<member name="ATK_STATE_INDETERMINATE" value="30"/>
			<member name="ATK_STATE_TRUNCATED" value="31"/>
			<member name="ATK_STATE_REQUIRED" value="32"/>
			<member name="ATK_STATE_INVALID_ENTRY" value="33"/>
			<member name="ATK_STATE_SUPPORTS_AUTOCOMPLETION" value="34"/>
			<member name="ATK_STATE_SELECTABLE_TEXT" value="35"/>
			<member name="ATK_STATE_DEFAULT" value="36"/>
			<member name="ATK_STATE_ANIMATED" value="37"/>
			<member name="ATK_STATE_VISITED" value="38"/>
			<member name="ATK_STATE_LAST_DEFINED" value="39"/>
		</enum>
		<enum name="AtkTextAttribute" type-name="AtkTextAttribute" get-type="atk_text_attribute_get_type">
			<member name="ATK_TEXT_ATTR_INVALID" value="0"/>
			<member name="ATK_TEXT_ATTR_LEFT_MARGIN" value="1"/>
			<member name="ATK_TEXT_ATTR_RIGHT_MARGIN" value="2"/>
			<member name="ATK_TEXT_ATTR_INDENT" value="3"/>
			<member name="ATK_TEXT_ATTR_INVISIBLE" value="4"/>
			<member name="ATK_TEXT_ATTR_EDITABLE" value="5"/>
			<member name="ATK_TEXT_ATTR_PIXELS_ABOVE_LINES" value="6"/>
			<member name="ATK_TEXT_ATTR_PIXELS_BELOW_LINES" value="7"/>
			<member name="ATK_TEXT_ATTR_PIXELS_INSIDE_WRAP" value="8"/>
			<member name="ATK_TEXT_ATTR_BG_FULL_HEIGHT" value="9"/>
			<member name="ATK_TEXT_ATTR_RISE" value="10"/>
			<member name="ATK_TEXT_ATTR_UNDERLINE" value="11"/>
			<member name="ATK_TEXT_ATTR_STRIKETHROUGH" value="12"/>
			<member name="ATK_TEXT_ATTR_SIZE" value="13"/>
			<member name="ATK_TEXT_ATTR_SCALE" value="14"/>
			<member name="ATK_TEXT_ATTR_WEIGHT" value="15"/>
			<member name="ATK_TEXT_ATTR_LANGUAGE" value="16"/>
			<member name="ATK_TEXT_ATTR_FAMILY_NAME" value="17"/>
			<member name="ATK_TEXT_ATTR_BG_COLOR" value="18"/>
			<member name="ATK_TEXT_ATTR_FG_COLOR" value="19"/>
			<member name="ATK_TEXT_ATTR_BG_STIPPLE" value="20"/>
			<member name="ATK_TEXT_ATTR_FG_STIPPLE" value="21"/>
			<member name="ATK_TEXT_ATTR_WRAP_MODE" value="22"/>
			<member name="ATK_TEXT_ATTR_DIRECTION" value="23"/>
			<member name="ATK_TEXT_ATTR_JUSTIFICATION" value="24"/>
			<member name="ATK_TEXT_ATTR_STRETCH" value="25"/>
			<member name="ATK_TEXT_ATTR_VARIANT" value="26"/>
			<member name="ATK_TEXT_ATTR_STYLE" value="27"/>
			<member name="ATK_TEXT_ATTR_LAST_DEFINED" value="28"/>
		</enum>
		<enum name="AtkTextBoundary" type-name="AtkTextBoundary" get-type="atk_text_boundary_get_type">
			<member name="ATK_TEXT_BOUNDARY_CHAR" value="0"/>
			<member name="ATK_TEXT_BOUNDARY_WORD_START" value="1"/>
			<member name="ATK_TEXT_BOUNDARY_WORD_END" value="2"/>
			<member name="ATK_TEXT_BOUNDARY_SENTENCE_START" value="3"/>
			<member name="ATK_TEXT_BOUNDARY_SENTENCE_END" value="4"/>
			<member name="ATK_TEXT_BOUNDARY_LINE_START" value="5"/>
			<member name="ATK_TEXT_BOUNDARY_LINE_END" value="6"/>
		</enum>
		<enum name="AtkTextClipType" type-name="AtkTextClipType" get-type="atk_text_clip_type_get_type">
			<member name="ATK_TEXT_CLIP_NONE" value="0"/>
			<member name="ATK_TEXT_CLIP_MIN" value="1"/>
			<member name="ATK_TEXT_CLIP_MAX" value="2"/>
			<member name="ATK_TEXT_CLIP_BOTH" value="3"/>
		</enum>
		<flags name="AtkHyperlinkStateFlags" type-name="AtkHyperlinkStateFlags" get-type="atk_hyperlink_state_flags_get_type">
			<member name="ATK_HYPERLINK_IS_INLINE" value="1"/>
		</flags>
		<object name="AtkGObjectAccessible" parent="AtkObject" type-name="AtkGObjectAccessible" get-type="atk_gobject_accessible_get_type">
			<method name="for_object" symbol="atk_gobject_accessible_for_object">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="obj" type="GObject*"/>
				</parameters>
			</method>
			<method name="get_object" symbol="atk_gobject_accessible_get_object">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="obj" type="AtkGObjectAccessible*"/>
				</parameters>
			</method>
		</object>
		<object name="AtkHyperlink" parent="GObject" type-name="AtkHyperlink" get-type="atk_hyperlink_get_type">
			<implements>
				<interface name="AtkAction"/>
			</implements>
			<method name="get_end_index" symbol="atk_hyperlink_get_end_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</method>
			<method name="get_n_anchors" symbol="atk_hyperlink_get_n_anchors">
				<return-type type="gint"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</method>
			<method name="get_object" symbol="atk_hyperlink_get_object">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="get_start_index" symbol="atk_hyperlink_get_start_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="atk_hyperlink_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="is_inline" symbol="atk_hyperlink_is_inline">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</method>
			<method name="is_selected_link" symbol="atk_hyperlink_is_selected_link">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</method>
			<method name="is_valid" symbol="atk_hyperlink_is_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</method>
			<property name="end-index" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="number-of-anchors" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="selected-link" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="start-index" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="link-activated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</signal>
			<vfunc name="get_end_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_anchors">
				<return-type type="gint"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_object">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_start_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="is_selected_link">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</vfunc>
			<vfunc name="link_state">
				<return-type type="guint"/>
				<parameters>
					<parameter name="link_" type="AtkHyperlink*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="AtkMisc" parent="GObject" type-name="AtkMisc" get-type="atk_misc_get_type">
			<method name="get_instance" symbol="atk_misc_get_instance">
				<return-type type="AtkMisc*"/>
			</method>
			<method name="threads_enter" symbol="atk_misc_threads_enter">
				<return-type type="void"/>
				<parameters>
					<parameter name="misc" type="AtkMisc*"/>
				</parameters>
			</method>
			<method name="threads_leave" symbol="atk_misc_threads_leave">
				<return-type type="void"/>
				<parameters>
					<parameter name="misc" type="AtkMisc*"/>
				</parameters>
			</method>
			<vfunc name="threads_enter">
				<return-type type="void"/>
				<parameters>
					<parameter name="misc" type="AtkMisc*"/>
				</parameters>
			</vfunc>
			<vfunc name="threads_leave">
				<return-type type="void"/>
				<parameters>
					<parameter name="misc" type="AtkMisc*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="AtkNoOpObject" parent="AtkObject" type-name="AtkNoOpObject" get-type="atk_no_op_object_get_type">
			<implements>
				<interface name="AtkComponent"/>
				<interface name="AtkAction"/>
				<interface name="AtkEditableText"/>
				<interface name="AtkImage"/>
				<interface name="AtkSelection"/>
				<interface name="AtkTable"/>
				<interface name="AtkText"/>
				<interface name="AtkHypertext"/>
				<interface name="AtkValue"/>
				<interface name="AtkDocument"/>
			</implements>
			<constructor name="new" symbol="atk_no_op_object_new">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="obj" type="GObject*"/>
				</parameters>
			</constructor>
		</object>
		<object name="AtkNoOpObjectFactory" parent="AtkObjectFactory" type-name="AtkNoOpObjectFactory" get-type="atk_no_op_object_factory_get_type">
			<constructor name="new" symbol="atk_no_op_object_factory_new">
				<return-type type="AtkObjectFactory*"/>
			</constructor>
		</object>
		<object name="AtkObject" parent="GObject" type-name="AtkObject" get-type="atk_object_get_type">
			<method name="add_relationship" symbol="atk_object_add_relationship">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="AtkObject*"/>
					<parameter name="relationship" type="AtkRelationType"/>
					<parameter name="target" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="connect_property_change_handler" symbol="atk_object_connect_property_change_handler">
				<return-type type="guint"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="handler" type="AtkPropertyChangeHandler*"/>
				</parameters>
			</method>
			<method name="get_attributes" symbol="atk_object_get_attributes">
				<return-type type="AtkAttributeSet*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="atk_object_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="get_index_in_parent" symbol="atk_object_get_index_in_parent">
				<return-type type="gint"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="get_layer" symbol="atk_object_get_layer">
				<return-type type="AtkLayer"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="get_mdi_zorder" symbol="atk_object_get_mdi_zorder">
				<return-type type="gint"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="get_n_accessible_children" symbol="atk_object_get_n_accessible_children">
				<return-type type="gint"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="atk_object_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="atk_object_get_parent">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="get_role" symbol="atk_object_get_role">
				<return-type type="AtkRole"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="initialize" symbol="atk_object_initialize">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="notify_state_change" symbol="atk_object_notify_state_change">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="state" type="AtkState"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="ref_accessible_child" symbol="atk_object_ref_accessible_child">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="ref_relation_set" symbol="atk_object_ref_relation_set">
				<return-type type="AtkRelationSet*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="ref_state_set" symbol="atk_object_ref_state_set">
				<return-type type="AtkStateSet*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="remove_property_change_handler" symbol="atk_object_remove_property_change_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="handler_id" type="guint"/>
				</parameters>
			</method>
			<method name="remove_relationship" symbol="atk_object_remove_relationship">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="AtkObject*"/>
					<parameter name="relationship" type="AtkRelationType"/>
					<parameter name="target" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="set_description" symbol="atk_object_set_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="atk_object_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_parent" symbol="atk_object_set_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="parent" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="set_role" symbol="atk_object_set_role">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="role" type="AtkRole"/>
				</parameters>
			</method>
			<property name="accessible-component-layer" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="accessible-component-mdi-zorder" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="accessible-description" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="accessible-hypertext-nlinks" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="accessible-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="accessible-parent" type="AtkObject*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="accessible-role" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="accessible-table-caption" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="accessible-table-caption-object" type="AtkObject*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="accessible-table-column-description" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="accessible-table-column-header" type="AtkObject*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="accessible-table-row-description" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="accessible-table-row-header" type="AtkObject*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="accessible-table-summary" type="AtkObject*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="accessible-value" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="active-descendant-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="child" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="children-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="change_index" type="guint"/>
					<parameter name="changed_child" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="focus-event" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="focus_in" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="property-change" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="values" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="state-change" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="name" type="char*"/>
					<parameter name="state_set" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="visible-data-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</signal>
			<vfunc name="connect_property_change_handler">
				<return-type type="guint"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="handler" type="AtkPropertyChangeHandler*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_attributes">
				<return-type type="AtkAttributeSet*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_index_in_parent">
				<return-type type="gint"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_layer">
				<return-type type="AtkLayer"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_mdi_zorder">
				<return-type type="gint"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_children">
				<return-type type="gint"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_parent">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_role">
				<return-type type="AtkRole"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="initialize">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="ref_child">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="ref_relation_set">
				<return-type type="AtkRelationSet*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="ref_state_set">
				<return-type type="AtkStateSet*"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_property_change_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="handler_id" type="guint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="parent" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_role">
				<return-type type="void"/>
				<parameters>
					<parameter name="accessible" type="AtkObject*"/>
					<parameter name="role" type="AtkRole"/>
				</parameters>
			</vfunc>
			<field name="description" type="gchar*"/>
			<field name="name" type="gchar*"/>
			<field name="accessible_parent" type="AtkObject*"/>
			<field name="role" type="AtkRole"/>
			<field name="relation_set" type="AtkRelationSet*"/>
			<field name="layer" type="AtkLayer"/>
		</object>
		<object name="AtkObjectFactory" parent="GObject" type-name="AtkObjectFactory" get-type="atk_object_factory_get_type">
			<method name="create_accessible" symbol="atk_object_factory_create_accessible">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="factory" type="AtkObjectFactory*"/>
					<parameter name="obj" type="GObject*"/>
				</parameters>
			</method>
			<method name="get_accessible_type" symbol="atk_object_factory_get_accessible_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="factory" type="AtkObjectFactory*"/>
				</parameters>
			</method>
			<method name="invalidate" symbol="atk_object_factory_invalidate">
				<return-type type="void"/>
				<parameters>
					<parameter name="factory" type="AtkObjectFactory*"/>
				</parameters>
			</method>
			<vfunc name="create_accessible">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="obj" type="GObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_accessible_type">
				<return-type type="GType"/>
			</vfunc>
			<vfunc name="invalidate">
				<return-type type="void"/>
				<parameters>
					<parameter name="factory" type="AtkObjectFactory*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="AtkPlug" parent="AtkObject" type-name="AtkPlug" get-type="atk_plug_get_type">
			<method name="get_id" symbol="atk_plug_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plug" type="AtkPlug*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="atk_plug_new">
				<return-type type="AtkObject*"/>
			</constructor>
			<vfunc name="get_object_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="obj" type="AtkPlug*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="AtkRegistry" parent="GObject" type-name="AtkRegistry" get-type="atk_registry_get_type">
			<method name="get_factory" symbol="atk_registry_get_factory">
				<return-type type="AtkObjectFactory*"/>
				<parameters>
					<parameter name="registry" type="AtkRegistry*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="get_factory_type" symbol="atk_registry_get_factory_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="registry" type="AtkRegistry*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="set_factory_type" symbol="atk_registry_set_factory_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="registry" type="AtkRegistry*"/>
					<parameter name="type" type="GType"/>
					<parameter name="factory_type" type="GType"/>
				</parameters>
			</method>
			<field name="factory_type_registry" type="GHashTable*"/>
			<field name="factory_singleton_cache" type="GHashTable*"/>
		</object>
		<object name="AtkRelation" parent="GObject" type-name="AtkRelation" get-type="atk_relation_get_type">
			<method name="add_target" symbol="atk_relation_add_target">
				<return-type type="void"/>
				<parameters>
					<parameter name="relation" type="AtkRelation*"/>
					<parameter name="target" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="atk_relation_get_relation_type">
				<return-type type="AtkRelationType"/>
				<parameters>
					<parameter name="relation" type="AtkRelation*"/>
				</parameters>
			</method>
			<method name="get_target" symbol="atk_relation_get_target">
				<return-type type="GPtrArray*"/>
				<parameters>
					<parameter name="relation" type="AtkRelation*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="atk_relation_new">
				<return-type type="AtkRelation*"/>
				<parameters>
					<parameter name="targets" type="AtkObject**"/>
					<parameter name="n_targets" type="gint"/>
					<parameter name="relationship" type="AtkRelationType"/>
				</parameters>
			</constructor>
			<method name="remove_target" symbol="atk_relation_remove_target">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="relation" type="AtkRelation*"/>
					<parameter name="target" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="type_for_name" symbol="atk_relation_type_for_name">
				<return-type type="AtkRelationType"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="type_get_name" symbol="atk_relation_type_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="type" type="AtkRelationType"/>
				</parameters>
			</method>
			<method name="type_register" symbol="atk_relation_type_register">
				<return-type type="AtkRelationType"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<property name="relation-type" type="AtkRelationType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="target" type="GValueArray*" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="target" type="GPtrArray*"/>
			<field name="relationship" type="AtkRelationType"/>
		</object>
		<object name="AtkRelationSet" parent="GObject" type-name="AtkRelationSet" get-type="atk_relation_set_get_type">
			<method name="add" symbol="atk_relation_set_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="AtkRelationSet*"/>
					<parameter name="relation" type="AtkRelation*"/>
				</parameters>
			</method>
			<method name="add_relation_by_type" symbol="atk_relation_set_add_relation_by_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="AtkRelationSet*"/>
					<parameter name="relationship" type="AtkRelationType"/>
					<parameter name="target" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="contains" symbol="atk_relation_set_contains">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="set" type="AtkRelationSet*"/>
					<parameter name="relationship" type="AtkRelationType"/>
				</parameters>
			</method>
			<method name="get_n_relations" symbol="atk_relation_set_get_n_relations">
				<return-type type="gint"/>
				<parameters>
					<parameter name="set" type="AtkRelationSet*"/>
				</parameters>
			</method>
			<method name="get_relation" symbol="atk_relation_set_get_relation">
				<return-type type="AtkRelation*"/>
				<parameters>
					<parameter name="set" type="AtkRelationSet*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="get_relation_by_type" symbol="atk_relation_set_get_relation_by_type">
				<return-type type="AtkRelation*"/>
				<parameters>
					<parameter name="set" type="AtkRelationSet*"/>
					<parameter name="relationship" type="AtkRelationType"/>
				</parameters>
			</method>
			<constructor name="new" symbol="atk_relation_set_new">
				<return-type type="AtkRelationSet*"/>
			</constructor>
			<method name="remove" symbol="atk_relation_set_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="AtkRelationSet*"/>
					<parameter name="relation" type="AtkRelation*"/>
				</parameters>
			</method>
			<field name="relations" type="GPtrArray*"/>
		</object>
		<object name="AtkSocket" parent="AtkObject" type-name="AtkSocket" get-type="atk_socket_get_type">
			<method name="embed" symbol="atk_socket_embed">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="AtkSocket*"/>
					<parameter name="plug_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="is_occupied" symbol="atk_socket_is_occupied">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="obj" type="AtkSocket*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="atk_socket_new">
				<return-type type="AtkObject*"/>
			</constructor>
			<vfunc name="embed">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="AtkSocket*"/>
					<parameter name="plug_id" type="gchar*"/>
				</parameters>
			</vfunc>
			<field name="embedded_plug_id" type="gchar*"/>
		</object>
		<object name="AtkStateSet" parent="GObject" type-name="AtkStateSet" get-type="atk_state_set_get_type">
			<method name="add_state" symbol="atk_state_set_add_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="set" type="AtkStateSet*"/>
					<parameter name="type" type="AtkStateType"/>
				</parameters>
			</method>
			<method name="add_states" symbol="atk_state_set_add_states">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="AtkStateSet*"/>
					<parameter name="types" type="AtkStateType*"/>
					<parameter name="n_types" type="gint"/>
				</parameters>
			</method>
			<method name="and_sets" symbol="atk_state_set_and_sets">
				<return-type type="AtkStateSet*"/>
				<parameters>
					<parameter name="set" type="AtkStateSet*"/>
					<parameter name="compare_set" type="AtkStateSet*"/>
				</parameters>
			</method>
			<method name="clear_states" symbol="atk_state_set_clear_states">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="AtkStateSet*"/>
				</parameters>
			</method>
			<method name="contains_state" symbol="atk_state_set_contains_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="set" type="AtkStateSet*"/>
					<parameter name="type" type="AtkStateType"/>
				</parameters>
			</method>
			<method name="contains_states" symbol="atk_state_set_contains_states">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="set" type="AtkStateSet*"/>
					<parameter name="types" type="AtkStateType*"/>
					<parameter name="n_types" type="gint"/>
				</parameters>
			</method>
			<method name="is_empty" symbol="atk_state_set_is_empty">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="set" type="AtkStateSet*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="atk_state_set_new">
				<return-type type="AtkStateSet*"/>
			</constructor>
			<method name="or_sets" symbol="atk_state_set_or_sets">
				<return-type type="AtkStateSet*"/>
				<parameters>
					<parameter name="set" type="AtkStateSet*"/>
					<parameter name="compare_set" type="AtkStateSet*"/>
				</parameters>
			</method>
			<method name="remove_state" symbol="atk_state_set_remove_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="set" type="AtkStateSet*"/>
					<parameter name="type" type="AtkStateType"/>
				</parameters>
			</method>
			<method name="xor_sets" symbol="atk_state_set_xor_sets">
				<return-type type="AtkStateSet*"/>
				<parameters>
					<parameter name="set" type="AtkStateSet*"/>
					<parameter name="compare_set" type="AtkStateSet*"/>
				</parameters>
			</method>
		</object>
		<object name="AtkUtil" parent="GObject" type-name="AtkUtil" get-type="atk_util_get_type">
			<vfunc name="add_global_event_listener">
				<return-type type="guint"/>
				<parameters>
					<parameter name="listener" type="GSignalEmissionHook"/>
					<parameter name="event_type" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="add_key_event_listener">
				<return-type type="guint"/>
				<parameters>
					<parameter name="listener" type="AtkKeySnoopFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="get_root">
				<return-type type="AtkObject*"/>
			</vfunc>
			<vfunc name="get_toolkit_name">
				<return-type type="gchar*"/>
			</vfunc>
			<vfunc name="get_toolkit_version">
				<return-type type="gchar*"/>
			</vfunc>
			<vfunc name="remove_global_event_listener">
				<return-type type="void"/>
				<parameters>
					<parameter name="listener_id" type="guint"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_key_event_listener">
				<return-type type="void"/>
				<parameters>
					<parameter name="listener_id" type="guint"/>
				</parameters>
			</vfunc>
		</object>
		<interface name="AtkAction" type-name="AtkAction" get-type="atk_action_get_type">
			<method name="do_action" symbol="atk_action_do_action">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="get_description" symbol="atk_action_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="get_keybinding" symbol="atk_action_get_keybinding">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="get_localized_name" symbol="atk_action_get_localized_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="get_n_actions" symbol="atk_action_get_n_actions">
				<return-type type="gint"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="atk_action_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="set_description" symbol="atk_action_set_description">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
					<parameter name="i" type="gint"/>
					<parameter name="desc" type="gchar*"/>
				</parameters>
			</method>
			<vfunc name="do_action">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_keybinding">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_localized_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_actions">
				<return-type type="gint"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_description">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="action" type="AtkAction*"/>
					<parameter name="i" type="gint"/>
					<parameter name="desc" type="gchar*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="AtkComponent" type-name="AtkComponent" get-type="atk_component_get_type">
			<method name="add_focus_handler" symbol="atk_component_add_focus_handler">
				<return-type type="guint"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="handler" type="AtkFocusHandler"/>
				</parameters>
			</method>
			<method name="contains" symbol="atk_component_contains">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</method>
			<method name="get_alpha" symbol="atk_component_get_alpha">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
				</parameters>
			</method>
			<method name="get_extents" symbol="atk_component_get_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</method>
			<method name="get_layer" symbol="atk_component_get_layer">
				<return-type type="AtkLayer"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
				</parameters>
			</method>
			<method name="get_mdi_zorder" symbol="atk_component_get_mdi_zorder">
				<return-type type="gint"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
				</parameters>
			</method>
			<method name="get_position" symbol="atk_component_get_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</method>
			<method name="get_size" symbol="atk_component_get_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
				</parameters>
			</method>
			<method name="grab_focus" symbol="atk_component_grab_focus">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
				</parameters>
			</method>
			<method name="ref_accessible_at_point" symbol="atk_component_ref_accessible_at_point">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</method>
			<method name="remove_focus_handler" symbol="atk_component_remove_focus_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="handler_id" type="guint"/>
				</parameters>
			</method>
			<method name="set_extents" symbol="atk_component_set_extents">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</method>
			<method name="set_position" symbol="atk_component_set_position">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</method>
			<method name="set_size" symbol="atk_component_set_size">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<signal name="bounds-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="bounds" type="AtkRectangle*"/>
				</parameters>
			</signal>
			<vfunc name="add_focus_handler">
				<return-type type="guint"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="handler" type="AtkFocusHandler"/>
				</parameters>
			</vfunc>
			<vfunc name="contains">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_alpha">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_layer">
				<return-type type="AtkLayer"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_mdi_zorder">
				<return-type type="gint"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="grab_focus">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
				</parameters>
			</vfunc>
			<vfunc name="ref_accessible_at_point">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_focus_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="handler_id" type="guint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_extents">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</vfunc>
			<vfunc name="set_position">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</vfunc>
			<vfunc name="set_size">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="component" type="AtkComponent*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="AtkDocument" type-name="AtkDocument" get-type="atk_document_get_type">
			<method name="get_attribute_value" symbol="atk_document_get_attribute_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="document" type="AtkDocument*"/>
					<parameter name="attribute_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_attributes" symbol="atk_document_get_attributes">
				<return-type type="AtkAttributeSet*"/>
				<parameters>
					<parameter name="document" type="AtkDocument*"/>
				</parameters>
			</method>
			<method name="get_document" symbol="atk_document_get_document">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="document" type="AtkDocument*"/>
				</parameters>
			</method>
			<method name="get_document_type" symbol="atk_document_get_document_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="document" type="AtkDocument*"/>
				</parameters>
			</method>
			<method name="get_locale" symbol="atk_document_get_locale">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="document" type="AtkDocument*"/>
				</parameters>
			</method>
			<method name="set_attribute_value" symbol="atk_document_set_attribute_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="document" type="AtkDocument*"/>
					<parameter name="attribute_name" type="gchar*"/>
					<parameter name="attribute_value" type="gchar*"/>
				</parameters>
			</method>
			<signal name="load-complete" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="AtkDocument*"/>
				</parameters>
			</signal>
			<signal name="load-stopped" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="AtkDocument*"/>
				</parameters>
			</signal>
			<signal name="reload" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="AtkDocument*"/>
				</parameters>
			</signal>
			<vfunc name="get_document">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="document" type="AtkDocument*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_document_attribute_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="document" type="AtkDocument*"/>
					<parameter name="attribute_name" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_document_attributes">
				<return-type type="AtkAttributeSet*"/>
				<parameters>
					<parameter name="document" type="AtkDocument*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_document_locale">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="document" type="AtkDocument*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_document_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="document" type="AtkDocument*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_document_attribute">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="document" type="AtkDocument*"/>
					<parameter name="attribute_name" type="gchar*"/>
					<parameter name="attribute_value" type="gchar*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="AtkEditableText" type-name="AtkEditableText" get-type="atk_editable_text_get_type">
			<method name="copy_text" symbol="atk_editable_text_copy_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="start_pos" type="gint"/>
					<parameter name="end_pos" type="gint"/>
				</parameters>
			</method>
			<method name="cut_text" symbol="atk_editable_text_cut_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="start_pos" type="gint"/>
					<parameter name="end_pos" type="gint"/>
				</parameters>
			</method>
			<method name="delete_text" symbol="atk_editable_text_delete_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="start_pos" type="gint"/>
					<parameter name="end_pos" type="gint"/>
				</parameters>
			</method>
			<method name="insert_text" symbol="atk_editable_text_insert_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="string" type="gchar*"/>
					<parameter name="length" type="gint"/>
					<parameter name="position" type="gint*"/>
				</parameters>
			</method>
			<method name="paste_text" symbol="atk_editable_text_paste_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</method>
			<method name="set_run_attributes" symbol="atk_editable_text_set_run_attributes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="attrib_set" type="AtkAttributeSet*"/>
					<parameter name="start_offset" type="gint"/>
					<parameter name="end_offset" type="gint"/>
				</parameters>
			</method>
			<method name="set_text_contents" symbol="atk_editable_text_set_text_contents">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="string" type="gchar*"/>
				</parameters>
			</method>
			<vfunc name="copy_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="start_pos" type="gint"/>
					<parameter name="end_pos" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="cut_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="start_pos" type="gint"/>
					<parameter name="end_pos" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="delete_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="start_pos" type="gint"/>
					<parameter name="end_pos" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="insert_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="string" type="gchar*"/>
					<parameter name="length" type="gint"/>
					<parameter name="position" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="paste_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_run_attributes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="attrib_set" type="AtkAttributeSet*"/>
					<parameter name="start_offset" type="gint"/>
					<parameter name="end_offset" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_text_contents">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkEditableText*"/>
					<parameter name="string" type="gchar*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="AtkHyperlinkImpl" type-name="AtkHyperlinkImpl" get-type="atk_hyperlink_impl_get_type">
			<method name="get_hyperlink" symbol="atk_hyperlink_impl_get_hyperlink">
				<return-type type="AtkHyperlink*"/>
				<parameters>
					<parameter name="obj" type="AtkHyperlinkImpl*"/>
				</parameters>
			</method>
			<vfunc name="get_hyperlink">
				<return-type type="AtkHyperlink*"/>
				<parameters>
					<parameter name="impl" type="AtkHyperlinkImpl*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="AtkHypertext" type-name="AtkHypertext" get-type="atk_hypertext_get_type">
			<method name="get_link" symbol="atk_hypertext_get_link">
				<return-type type="AtkHyperlink*"/>
				<parameters>
					<parameter name="hypertext" type="AtkHypertext*"/>
					<parameter name="link_index" type="gint"/>
				</parameters>
			</method>
			<method name="get_link_index" symbol="atk_hypertext_get_link_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="hypertext" type="AtkHypertext*"/>
					<parameter name="char_index" type="gint"/>
				</parameters>
			</method>
			<method name="get_n_links" symbol="atk_hypertext_get_n_links">
				<return-type type="gint"/>
				<parameters>
					<parameter name="hypertext" type="AtkHypertext*"/>
				</parameters>
			</method>
			<signal name="link-selected" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="hypertext" type="AtkHypertext*"/>
					<parameter name="link_index" type="gint"/>
				</parameters>
			</signal>
			<vfunc name="get_link">
				<return-type type="AtkHyperlink*"/>
				<parameters>
					<parameter name="hypertext" type="AtkHypertext*"/>
					<parameter name="link_index" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_link_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="hypertext" type="AtkHypertext*"/>
					<parameter name="char_index" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_links">
				<return-type type="gint"/>
				<parameters>
					<parameter name="hypertext" type="AtkHypertext*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="AtkImage" type-name="AtkImage" get-type="atk_image_get_type">
			<method name="get_image_description" symbol="atk_image_get_image_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="image" type="AtkImage*"/>
				</parameters>
			</method>
			<method name="get_image_locale" symbol="atk_image_get_image_locale">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="image" type="AtkImage*"/>
				</parameters>
			</method>
			<method name="get_image_position" symbol="atk_image_get_image_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="image" type="AtkImage*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</method>
			<method name="get_image_size" symbol="atk_image_get_image_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="image" type="AtkImage*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
				</parameters>
			</method>
			<method name="set_image_description" symbol="atk_image_set_image_description">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="image" type="AtkImage*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</method>
			<vfunc name="get_image_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="image" type="AtkImage*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_image_locale">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="image" type="AtkImage*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_image_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="image" type="AtkImage*"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="coord_type" type="AtkCoordType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_image_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="image" type="AtkImage*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_image_description">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="image" type="AtkImage*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="AtkImplementor" type-name="AtkImplementor" get-type="atk_implementor_get_type">
			<method name="ref_accessible" symbol="atk_implementor_ref_accessible">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="implementor" type="AtkImplementor*"/>
				</parameters>
			</method>
			<vfunc name="ref_accessible">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="implementor" type="AtkImplementor*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="AtkSelection" type-name="AtkSelection" get-type="atk_selection_get_type">
			<method name="add_selection" symbol="atk_selection_add_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="clear_selection" symbol="atk_selection_clear_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
				</parameters>
			</method>
			<method name="get_selection_count" symbol="atk_selection_get_selection_count">
				<return-type type="gint"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
				</parameters>
			</method>
			<method name="is_child_selected" symbol="atk_selection_is_child_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="ref_selection" symbol="atk_selection_ref_selection">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="remove_selection" symbol="atk_selection_remove_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="select_all_selection" symbol="atk_selection_select_all_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
				</parameters>
			</method>
			<signal name="selection-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
				</parameters>
			</signal>
			<vfunc name="add_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="clear_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_selection_count">
				<return-type type="gint"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_child_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="ref_selection">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="select_all_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="selection" type="AtkSelection*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="AtkStreamableContent" type-name="AtkStreamableContent" get-type="atk_streamable_content_get_type">
			<method name="get_mime_type" symbol="atk_streamable_content_get_mime_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="streamable" type="AtkStreamableContent*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="get_n_mime_types" symbol="atk_streamable_content_get_n_mime_types">
				<return-type type="gint"/>
				<parameters>
					<parameter name="streamable" type="AtkStreamableContent*"/>
				</parameters>
			</method>
			<method name="get_stream" symbol="atk_streamable_content_get_stream">
				<return-type type="GIOChannel*"/>
				<parameters>
					<parameter name="streamable" type="AtkStreamableContent*"/>
					<parameter name="mime_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="atk_streamable_content_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="streamable" type="AtkStreamableContent*"/>
					<parameter name="mime_type" type="gchar*"/>
				</parameters>
			</method>
			<vfunc name="get_mime_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="streamable" type="AtkStreamableContent*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_mime_types">
				<return-type type="gint"/>
				<parameters>
					<parameter name="streamable" type="AtkStreamableContent*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_stream">
				<return-type type="GIOChannel*"/>
				<parameters>
					<parameter name="streamable" type="AtkStreamableContent*"/>
					<parameter name="mime_type" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="streamable" type="AtkStreamableContent*"/>
					<parameter name="mime_type" type="gchar*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="AtkTable" type-name="AtkTable" get-type="atk_table_get_type">
			<method name="add_column_selection" symbol="atk_table_add_column_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="add_row_selection" symbol="atk_table_add_row_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</method>
			<method name="get_caption" symbol="atk_table_get_caption">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
				</parameters>
			</method>
			<method name="get_column_at_index" symbol="atk_table_get_column_at_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="index_" type="gint"/>
				</parameters>
			</method>
			<method name="get_column_description" symbol="atk_table_get_column_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="get_column_extent_at" symbol="atk_table_get_column_extent_at">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="get_column_header" symbol="atk_table_get_column_header">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="get_index_at" symbol="atk_table_get_index_at">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="get_n_columns" symbol="atk_table_get_n_columns">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
				</parameters>
			</method>
			<method name="get_n_rows" symbol="atk_table_get_n_rows">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
				</parameters>
			</method>
			<method name="get_row_at_index" symbol="atk_table_get_row_at_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="index_" type="gint"/>
				</parameters>
			</method>
			<method name="get_row_description" symbol="atk_table_get_row_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</method>
			<method name="get_row_extent_at" symbol="atk_table_get_row_extent_at">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="get_row_header" symbol="atk_table_get_row_header">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</method>
			<method name="get_selected_columns" symbol="atk_table_get_selected_columns">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="selected" type="gint**"/>
				</parameters>
			</method>
			<method name="get_selected_rows" symbol="atk_table_get_selected_rows">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="selected" type="gint**"/>
				</parameters>
			</method>
			<method name="get_summary" symbol="atk_table_get_summary">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
				</parameters>
			</method>
			<method name="is_column_selected" symbol="atk_table_is_column_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="is_row_selected" symbol="atk_table_is_row_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</method>
			<method name="is_selected" symbol="atk_table_is_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="ref_at" symbol="atk_table_ref_at">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="remove_column_selection" symbol="atk_table_remove_column_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</method>
			<method name="remove_row_selection" symbol="atk_table_remove_row_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</method>
			<method name="set_caption" symbol="atk_table_set_caption">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="caption" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="set_column_description" symbol="atk_table_set_column_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_column_header" symbol="atk_table_set_column_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
					<parameter name="header" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="set_row_description" symbol="atk_table_set_row_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_row_header" symbol="atk_table_set_row_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="header" type="AtkObject*"/>
				</parameters>
			</method>
			<method name="set_summary" symbol="atk_table_set_summary">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</method>
			<signal name="column-deleted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
					<parameter name="num_deleted" type="gint"/>
				</parameters>
			</signal>
			<signal name="column-inserted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
					<parameter name="num_inserted" type="gint"/>
				</parameters>
			</signal>
			<signal name="column-reordered" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
				</parameters>
			</signal>
			<signal name="model-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
				</parameters>
			</signal>
			<signal name="row-deleted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="num_deleted" type="gint"/>
				</parameters>
			</signal>
			<signal name="row-inserted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="num_inserted" type="gint"/>
				</parameters>
			</signal>
			<signal name="row-reordered" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
				</parameters>
			</signal>
			<vfunc name="add_column_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="add_row_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_caption">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_column_at_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="index_" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_column_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_column_extent_at">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_column_header">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_index_at">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_columns">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_rows">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_row_at_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="index_" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_row_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_row_extent_at">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_row_header">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_selected_columns">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="selected" type="gint**"/>
				</parameters>
			</vfunc>
			<vfunc name="get_selected_rows">
				<return-type type="gint"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="selected" type="gint**"/>
				</parameters>
			</vfunc>
			<vfunc name="get_summary">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_column_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="is_row_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="is_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="ref_at">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_column_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_row_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_caption">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="caption" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_column_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_column_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="column" type="gint"/>
					<parameter name="header" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_row_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_row_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="row" type="gint"/>
					<parameter name="header" type="AtkObject*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_summary">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="AtkTable*"/>
					<parameter name="accessible" type="AtkObject*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="AtkText" type-name="AtkText" get-type="atk_text_get_type">
			<method name="add_selection" symbol="atk_text_add_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="start_offset" type="gint"/>
					<parameter name="end_offset" type="gint"/>
				</parameters>
			</method>
			<method name="attribute_for_name" symbol="atk_text_attribute_for_name">
				<return-type type="AtkTextAttribute"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="attribute_get_name" symbol="atk_text_attribute_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="attr" type="AtkTextAttribute"/>
				</parameters>
			</method>
			<method name="attribute_get_value" symbol="atk_text_attribute_get_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="attr" type="AtkTextAttribute"/>
					<parameter name="index_" type="gint"/>
				</parameters>
			</method>
			<method name="attribute_register" symbol="atk_text_attribute_register">
				<return-type type="AtkTextAttribute"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="free_ranges" symbol="atk_text_free_ranges">
				<return-type type="void"/>
				<parameters>
					<parameter name="ranges" type="AtkTextRange**"/>
				</parameters>
			</method>
			<method name="get_bounded_ranges" symbol="atk_text_get_bounded_ranges">
				<return-type type="AtkTextRange**"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="rect" type="AtkTextRectangle*"/>
					<parameter name="coord_type" type="AtkCoordType"/>
					<parameter name="x_clip_type" type="AtkTextClipType"/>
					<parameter name="y_clip_type" type="AtkTextClipType"/>
				</parameters>
			</method>
			<method name="get_caret_offset" symbol="atk_text_get_caret_offset">
				<return-type type="gint"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
				</parameters>
			</method>
			<method name="get_character_at_offset" symbol="atk_text_get_character_at_offset">
				<return-type type="gunichar"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
				</parameters>
			</method>
			<method name="get_character_count" symbol="atk_text_get_character_count">
				<return-type type="gint"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
				</parameters>
			</method>
			<method name="get_character_extents" symbol="atk_text_get_character_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
					<parameter name="coords" type="AtkCoordType"/>
				</parameters>
			</method>
			<method name="get_default_attributes" symbol="atk_text_get_default_attributes">
				<return-type type="AtkAttributeSet*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
				</parameters>
			</method>
			<method name="get_n_selections" symbol="atk_text_get_n_selections">
				<return-type type="gint"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
				</parameters>
			</method>
			<method name="get_offset_at_point" symbol="atk_text_get_offset_at_point">
				<return-type type="gint"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="coords" type="AtkCoordType"/>
				</parameters>
			</method>
			<method name="get_range_extents" symbol="atk_text_get_range_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="start_offset" type="gint"/>
					<parameter name="end_offset" type="gint"/>
					<parameter name="coord_type" type="AtkCoordType"/>
					<parameter name="rect" type="AtkTextRectangle*"/>
				</parameters>
			</method>
			<method name="get_run_attributes" symbol="atk_text_get_run_attributes">
				<return-type type="AtkAttributeSet*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
					<parameter name="start_offset" type="gint*"/>
					<parameter name="end_offset" type="gint*"/>
				</parameters>
			</method>
			<method name="get_selection" symbol="atk_text_get_selection">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="selection_num" type="gint"/>
					<parameter name="start_offset" type="gint*"/>
					<parameter name="end_offset" type="gint*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="atk_text_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="start_offset" type="gint"/>
					<parameter name="end_offset" type="gint"/>
				</parameters>
			</method>
			<method name="get_text_after_offset" symbol="atk_text_get_text_after_offset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
					<parameter name="boundary_type" type="AtkTextBoundary"/>
					<parameter name="start_offset" type="gint*"/>
					<parameter name="end_offset" type="gint*"/>
				</parameters>
			</method>
			<method name="get_text_at_offset" symbol="atk_text_get_text_at_offset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
					<parameter name="boundary_type" type="AtkTextBoundary"/>
					<parameter name="start_offset" type="gint*"/>
					<parameter name="end_offset" type="gint*"/>
				</parameters>
			</method>
			<method name="get_text_before_offset" symbol="atk_text_get_text_before_offset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
					<parameter name="boundary_type" type="AtkTextBoundary"/>
					<parameter name="start_offset" type="gint*"/>
					<parameter name="end_offset" type="gint*"/>
				</parameters>
			</method>
			<method name="remove_selection" symbol="atk_text_remove_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="selection_num" type="gint"/>
				</parameters>
			</method>
			<method name="set_caret_offset" symbol="atk_text_set_caret_offset">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
				</parameters>
			</method>
			<method name="set_selection" symbol="atk_text_set_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="selection_num" type="gint"/>
					<parameter name="start_offset" type="gint"/>
					<parameter name="end_offset" type="gint"/>
				</parameters>
			</method>
			<signal name="text-attributes-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
				</parameters>
			</signal>
			<signal name="text-caret-moved" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="location" type="gint"/>
				</parameters>
			</signal>
			<signal name="text-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="position" type="gint"/>
					<parameter name="length" type="gint"/>
				</parameters>
			</signal>
			<signal name="text-selection-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
				</parameters>
			</signal>
			<vfunc name="add_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="start_offset" type="gint"/>
					<parameter name="end_offset" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_bounded_ranges">
				<return-type type="AtkTextRange**"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="rect" type="AtkTextRectangle*"/>
					<parameter name="coord_type" type="AtkCoordType"/>
					<parameter name="x_clip_type" type="AtkTextClipType"/>
					<parameter name="y_clip_type" type="AtkTextClipType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_caret_offset">
				<return-type type="gint"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_character_at_offset">
				<return-type type="gunichar"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_character_count">
				<return-type type="gint"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_character_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
					<parameter name="x" type="gint*"/>
					<parameter name="y" type="gint*"/>
					<parameter name="width" type="gint*"/>
					<parameter name="height" type="gint*"/>
					<parameter name="coords" type="AtkCoordType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_default_attributes">
				<return-type type="AtkAttributeSet*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_n_selections">
				<return-type type="gint"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_offset_at_point">
				<return-type type="gint"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="coords" type="AtkCoordType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_range_extents">
				<return-type type="void"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="start_offset" type="gint"/>
					<parameter name="end_offset" type="gint"/>
					<parameter name="coord_type" type="AtkCoordType"/>
					<parameter name="rect" type="AtkTextRectangle*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_run_attributes">
				<return-type type="AtkAttributeSet*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
					<parameter name="start_offset" type="gint*"/>
					<parameter name="end_offset" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_selection">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="selection_num" type="gint"/>
					<parameter name="start_offset" type="gint*"/>
					<parameter name="end_offset" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="start_offset" type="gint"/>
					<parameter name="end_offset" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="get_text_after_offset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
					<parameter name="boundary_type" type="AtkTextBoundary"/>
					<parameter name="start_offset" type="gint*"/>
					<parameter name="end_offset" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_text_at_offset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
					<parameter name="boundary_type" type="AtkTextBoundary"/>
					<parameter name="start_offset" type="gint*"/>
					<parameter name="end_offset" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_text_before_offset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
					<parameter name="boundary_type" type="AtkTextBoundary"/>
					<parameter name="start_offset" type="gint*"/>
					<parameter name="end_offset" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="selection_num" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_caret_offset">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="offset" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="text" type="AtkText*"/>
					<parameter name="selection_num" type="gint"/>
					<parameter name="start_offset" type="gint"/>
					<parameter name="end_offset" type="gint"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="AtkValue" type-name="AtkValue" get-type="atk_value_get_type">
			<method name="get_current_value" symbol="atk_value_get_current_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="AtkValue*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_maximum_value" symbol="atk_value_get_maximum_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="AtkValue*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_minimum_increment" symbol="atk_value_get_minimum_increment">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="AtkValue*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_minimum_value" symbol="atk_value_get_minimum_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="AtkValue*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_current_value" symbol="atk_value_set_current_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="obj" type="AtkValue*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<vfunc name="get_current_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="AtkValue*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_maximum_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="AtkValue*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_minimum_increment">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="AtkValue*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_minimum_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="AtkValue*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_current_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="obj" type="AtkValue*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</vfunc>
		</interface>
	</namespace>
</api>
