[CCode (cheader_filename = "packages/atk/atk.h")]
namespace Atk {
	public class GObjectAccessible : Atk.Object {
		public static Atk.Object for_object (GLib.Object obj);
		public GLib.Object get_object ();
		public GLib.Type get_type ();
	}
	public class Hyperlink : GLib.Object, Atk.Action {
		public int get_end_index ();
		public int get_n_anchors ();
		public Atk.Object get_object (int i);
		public int get_start_index ();
		public GLib.Type get_type ();
		public string get_uri (int i);
		public bool is_inline ();
		public bool is_selected_link ();
		public bool is_valid ();
		[NoAccessorMethod ()]
		public weak bool selected_link { get; }
		[NoAccessorMethod ()]
		public weak int number_of_anchors { get; }
		public weak int end_index { get; }
		public weak int start_index { get; }
		public signal void link_activated ();
	}
	public class NoOpObject : Atk.Object, Atk.Component, Atk.Action, Atk.EditableText, Atk.Image, Atk.Selection, Atk.Table, Atk.Text, Atk.Hypertext, Atk.Value {
		public GLib.Type get_type ();
		public construct (GLib.Object obj);
	}
	public class NoOpObjectFactory : Atk.ObjectFactory {
		public GLib.Type get_type ();
		public construct ();
	}
	public class Object : GLib.Object {
		public bool add_relationship (Atk.RelationType relationship, Atk.Object target);
		public uint connect_property_change_handler (Atk.PropertyChangeHandler handler);
		public GLib.SList get_attributes ();
		public string get_description ();
		public int get_index_in_parent ();
		public Atk.Layer get_layer ();
		public int get_mdi_zorder ();
		public int get_n_accessible_children ();
		public string get_name ();
		public Atk.Object get_parent ();
		public Atk.Role get_role ();
		public GLib.Type get_type ();
		public void initialize (pointer data);
		public void notify_state_change (Atk.State state, bool value);
		public Atk.Object ref_accessible_child (int i);
		public Atk.RelationSet ref_relation_set ();
		public Atk.StateSet ref_state_set ();
		public void remove_property_change_handler (uint handler_id);
		public bool remove_relationship (Atk.RelationType relationship, Atk.Object target);
		public void set_description (string description);
		public void set_name (string name);
		public void set_parent (Atk.Object parent);
		public void set_role (Atk.Role role);
		[NoAccessorMethod ()]
		public weak string atk_object_name_property_name { get; set; }
		[NoAccessorMethod ()]
		public weak string atk_object_name_property_description { get; set; }
		[NoAccessorMethod ()]
		public weak Atk.Object atk_object_name_property_parent { get; set; }
		[NoAccessorMethod ()]
		public weak double atk_object_name_property_value { get; set; }
		[NoAccessorMethod ()]
		public weak int atk_object_name_property_role { get; set; }
		[NoAccessorMethod ()]
		public weak int atk_object_name_property_component_layer { get; }
		[NoAccessorMethod ()]
		public weak int atk_object_name_property_component_mdi_zorder { get; }
		[NoAccessorMethod ()]
		public weak string atk_object_name_property_table_caption { get; set; }
		[NoAccessorMethod ()]
		public weak Atk.Object atk_object_name_property_table_column_header { get; set; }
		[NoAccessorMethod ()]
		public weak string atk_object_name_property_table_column_description { get; set; }
		[NoAccessorMethod ()]
		public weak Atk.Object atk_object_name_property_table_row_header { get; set; }
		[NoAccessorMethod ()]
		public weak string atk_object_name_property_table_row_description { get; set; }
		[NoAccessorMethod ()]
		public weak Atk.Object atk_object_name_property_table_summary { get; set; }
		[NoAccessorMethod ()]
		public weak Atk.Object atk_object_name_property_table_caption_object { get; set; }
		[NoAccessorMethod ()]
		public weak int atk_object_name_property_hypertext_num_links { get; }
		public signal void children_changed (uint change_index, pointer changed_child);
		public signal void focus_event (bool focus_in);
		public signal void property_change (Atk.PropertyValues values);
		public signal void state_change (string name, bool state_set);
		public signal void visible_data_changed ();
		public signal void active_descendant_changed (pointer child);
	}
	public class ObjectFactory : GLib.Object {
		public Atk.Object create_accessible (GLib.Object obj);
		public GLib.Type get_accessible_type ();
		public GLib.Type get_type ();
		public void invalidate ();
	}
	public class Registry : GLib.Object {
		public Atk.ObjectFactory get_factory (GLib.Type type);
		public GLib.Type get_factory_type (GLib.Type type);
		public GLib.Type get_type ();
		public void set_factory_type (GLib.Type type, GLib.Type factory_type);
	}
	public class Relation : GLib.Object {
		public void add_target (Atk.Object target);
		public Atk.RelationType get_relation_type ();
		public GLib.PtrArray get_target ();
		public GLib.Type get_type ();
		public construct (Atk.Object targets, int n_targets, Atk.RelationType relationship);
		public static Atk.RelationType type_for_name (string name);
		public static string type_get_name (Atk.RelationType type);
		public static Atk.RelationType type_register (string name);
		[NoAccessorMethod ()]
		public weak Atk.RelationType relation_type { get; set; }
		[NoAccessorMethod ()]
		public weak GLib.ValueArray target { get; set; }
	}
	public class RelationSet : GLib.Object {
		public void add (Atk.Relation relation);
		public void add_relation_by_type (Atk.RelationType relationship, Atk.Object target);
		public bool contains (Atk.RelationType relationship);
		public int get_n_relations ();
		public Atk.Relation get_relation (int i);
		public Atk.Relation get_relation_by_type (Atk.RelationType relationship);
		public GLib.Type get_type ();
		public construct ();
		public void remove (Atk.Relation relation);
	}
	public class StateSet : GLib.Object {
		public bool add_state (Atk.StateType type);
		public void add_states (Atk.StateType types, int n_types);
		public Atk.StateSet and_sets (Atk.StateSet compare_set);
		public void clear_states ();
		public bool contains_state (Atk.StateType type);
		public bool contains_states (Atk.StateType types, int n_types);
		public GLib.Type get_type ();
		public bool is_empty ();
		public construct ();
		public Atk.StateSet or_sets (Atk.StateSet compare_set);
		public bool remove_state (Atk.StateType type);
		public Atk.StateSet xor_sets (Atk.StateSet compare_set);
	}
	public class Util : GLib.Object {
		public GLib.Type get_type ();
	}
	public interface Action {
		public bool do_action (int i);
		public string get_description (int i);
		public string get_keybinding (int i);
		public string get_localized_name (int i);
		public int get_n_actions ();
		public string get_name (int i);
		public GLib.Type get_type ();
		public bool set_description (int i, string desc);
	}
	public interface Component {
		public uint add_focus_handler (Atk.FocusHandler handler);
		public bool contains (int x, int y, Atk.CoordType coord_type);
		public double get_alpha ();
		public void get_extents (int x, int y, int width, int height, Atk.CoordType coord_type);
		public Atk.Layer get_layer ();
		public int get_mdi_zorder ();
		public void get_position (int x, int y, Atk.CoordType coord_type);
		public void get_size (int width, int height);
		public GLib.Type get_type ();
		public bool grab_focus ();
		public Atk.Object ref_accessible_at_point (int x, int y, Atk.CoordType coord_type);
		public void remove_focus_handler (uint handler_id);
		public bool set_extents (int x, int y, int width, int height, Atk.CoordType coord_type);
		public bool set_position (int x, int y, Atk.CoordType coord_type);
		public bool set_size (int width, int height);
	}
	public interface Document {
		public string get_attribute_value (string attribute_name);
		public GLib.SList get_attributes ();
		public pointer get_document ();
		public string get_document_type ();
		public string get_locale ();
		public GLib.Type get_type ();
		public bool set_attribute_value (string attribute_name, string attribute_value);
	}
	public interface EditableText {
		public void copy_text (int start_pos, int end_pos);
		public void cut_text (int start_pos, int end_pos);
		public void delete_text (int start_pos, int end_pos);
		public GLib.Type get_type ();
		public void insert_text (string string, int length, int position);
		public void paste_text (int position);
		public bool set_run_attributes (GLib.SList attrib_set, int start_offset, int end_offset);
		public void set_text_contents (string string);
	}
	public interface HyperlinkImpl {
		public Atk.Hyperlink get_hyperlink ();
		public GLib.Type get_type ();
	}
	public interface Hypertext {
		public Atk.Hyperlink get_link (int link_index);
		public int get_link_index (int char_index);
		public int get_n_links ();
		public GLib.Type get_type ();
	}
	public interface Image {
		public string get_image_description ();
		public string get_image_locale ();
		public void get_image_position (int x, int y, Atk.CoordType coord_type);
		public void get_image_size (int width, int height);
		public GLib.Type get_type ();
		public bool set_image_description (string description);
	}
	public interface Implementor {
		public GLib.Type get_type ();
		public Atk.Object ref_accessible ();
	}
	public interface Selection {
		public bool add_selection (int i);
		public bool clear_selection ();
		public int get_selection_count ();
		public GLib.Type get_type ();
		public bool is_child_selected (int i);
		public Atk.Object ref_selection (int i);
		public bool remove_selection (int i);
		public bool select_all_selection ();
	}
	public interface StreamableContent {
		public string get_mime_type (int i);
		public int get_n_mime_types ();
		public GLib.IOChannel get_stream (string mime_type);
		public GLib.Type get_type ();
		public string get_uri (string mime_type);
	}
	public interface Table {
		public bool add_column_selection (int column);
		public bool add_row_selection (int row);
		public Atk.Object get_caption ();
		public int get_column_at_index (int index_);
		public string get_column_description (int column);
		public int get_column_extent_at (int row, int column);
		public Atk.Object get_column_header (int column);
		public int get_index_at (int row, int column);
		public int get_n_columns ();
		public int get_n_rows ();
		public int get_row_at_index (int index_);
		public string get_row_description (int row);
		public int get_row_extent_at (int row, int column);
		public Atk.Object get_row_header (int row);
		public int get_selected_columns (int selected);
		public int get_selected_rows (int selected);
		public Atk.Object get_summary ();
		public GLib.Type get_type ();
		public bool is_column_selected (int column);
		public bool is_row_selected (int row);
		public bool is_selected (int row, int column);
		public Atk.Object ref_at (int row, int column);
		public bool remove_column_selection (int column);
		public bool remove_row_selection (int row);
		public void set_caption (Atk.Object caption);
		public void set_column_description (int column, string description);
		public void set_column_header (int column, Atk.Object header);
		public void set_row_description (int row, string description);
		public void set_row_header (int row, Atk.Object header);
		public void set_summary (Atk.Object accessible);
	}
	public interface Text {
		public bool add_selection (int start_offset, int end_offset);
		public static Atk.TextAttribute attribute_for_name (string name);
		public static string attribute_get_name (Atk.TextAttribute attr);
		public static string attribute_get_value (Atk.TextAttribute attr, int index_);
		public static Atk.TextAttribute attribute_register (string name);
		public static void free_ranges (Atk.TextRange ranges);
		public Atk.TextRange get_bounded_ranges (Atk.TextRectangle rect, Atk.CoordType coord_type, Atk.TextClipType x_clip_type, Atk.TextClipType y_clip_type);
		public int get_caret_offset ();
		public unichar get_character_at_offset (int offset);
		public int get_character_count ();
		public void get_character_extents (int offset, int x, int y, int width, int height, Atk.CoordType coords);
		public GLib.SList get_default_attributes ();
		public int get_n_selections ();
		public int get_offset_at_point (int x, int y, Atk.CoordType coords);
		public void get_range_extents (int start_offset, int end_offset, Atk.CoordType coord_type, Atk.TextRectangle rect);
		public GLib.SList get_run_attributes (int offset, int start_offset, int end_offset);
		public string get_selection (int selection_num, int start_offset, int end_offset);
		public string get_text (int start_offset, int end_offset);
		public string get_text_after_offset (int offset, Atk.TextBoundary boundary_type, int start_offset, int end_offset);
		public string get_text_at_offset (int offset, Atk.TextBoundary boundary_type, int start_offset, int end_offset);
		public string get_text_before_offset (int offset, Atk.TextBoundary boundary_type, int start_offset, int end_offset);
		public GLib.Type get_type ();
		public bool remove_selection (int selection_num);
		public bool set_caret_offset (int offset);
		public bool set_selection (int selection_num, int start_offset, int end_offset);
	}
	public interface Value {
		public void get_current_value (GLib.Value value);
		public void get_maximum_value (GLib.Value value);
		public void get_minimum_increment (GLib.Value value);
		public void get_minimum_value (GLib.Value value);
		public GLib.Type get_type ();
		public bool set_current_value (GLib.Value value);
	}
	[ReferenceType ()]
	public struct Attribute {
		public weak string name;
		public weak string value;
		public static void set_free (GLib.SList attrib_set);
	}
	[ReferenceType ()]
	public struct KeyEventStruct {
		public weak int type;
		public weak uint state;
		public weak uint keyval;
		public weak int length;
		public weak string string;
		public weak ushort keycode;
		public weak uint timestamp;
	}
	[ReferenceType ()]
	public struct PropertyValues {
		public weak string property_name;
		public weak GLib.Value old_value;
		public weak GLib.Value new_value;
	}
	public struct Rectangle {
		public GLib.Type get_type ();
	}
	[ReferenceType ()]
	public struct TextRange {
		public weak Atk.TextRectangle bounds;
		public weak int start_offset;
		public weak int end_offset;
		public weak string content;
	}
	[ReferenceType ()]
	public struct TextRectangle {
		public weak int x;
		public weak int y;
		public weak int width;
		public weak int height;
	}
	[ReferenceType ()]
	public struct Global {
		public static uint _add_focus_tracker (Atk.EventListener focus_tracker);
		public static uint _add_global_event_listener (GLib.SignalEmissionHook listener, string event_type);
		public static uint _add_key_event_listener (Atk.KeySnoopFunc listener, pointer data);
		public Atk.Registry _get_default_registry ();
		public Atk.Object _get_focus_object ();
		public Atk.Object _get_root ();
		public string _get_toolkit_name ();
		public string _get_toolkit_version ();
		public static void _remove_focus_tracker (uint tracker_id);
		public static void _remove_global_event_listener (uint listener_id);
		public static void _remove_key_event_listener (uint listener_id);
		public static Atk.Role _role_for_name (string name);
		public static string _role_get_localized_name (Atk.Role role);
		public static string _role_get_name (Atk.Role role);
		public static Atk.Role _role_register (string name);
	}
	[ReferenceType ()]
	public struct Focus {
		public static void tracker_init (Atk.EventListenerInit init);
		public static void tracker_notify (Atk.Object object);
	}
	[ReferenceType ()]
	public struct State {
		public static Atk.StateType type_for_name (string name);
		public static string type_get_name (Atk.StateType type);
		public static Atk.StateType type_register (string name);
	}
	[CCode (cprefix = "ATK_XY_")]
	public enum CoordType {
		SCREEN,
		WINDOW,
	}
	[CCode (cprefix = "ATK_HYPERLINK_IS_")]
	public enum HyperlinkStateFlags {
		INLINE,
	}
	[CCode (cprefix = "ATK_KEY_EVENT_")]
	public enum KeyEventType {
		PRESS,
		RELEASE,
		LAST_DEFINED,
	}
	[CCode (cprefix = "ATK_LAYER_")]
	public enum Layer {
		INVALID,
		BACKGROUND,
		CANVAS,
		WIDGET,
		MDI,
		POPUP,
		OVERLAY,
		WINDOW,
	}
	[CCode (cprefix = "ATK_RELATION_")]
	public enum RelationType {
		NULL,
		CONTROLLED_BY,
		CONTROLLER_FOR,
		LABEL_FOR,
		LABELLED_BY,
		MEMBER_OF,
		NODE_CHILD_OF,
		FLOWS_TO,
		FLOWS_FROM,
		SUBWINDOW_OF,
		EMBEDS,
		EMBEDDED_BY,
		POPUP_FOR,
		PARENT_WINDOW_OF,
		DESCRIBED_BY,
		DESCRIPTION_FOR,
		LAST_DEFINED,
	}
	[CCode (cprefix = "ATK_ROLE_")]
	public enum Role {
		INVALID,
		ACCEL_LABEL,
		ALERT,
		ANIMATION,
		ARROW,
		CALENDAR,
		CANVAS,
		CHECK_BOX,
		CHECK_MENU_ITEM,
		COLOR_CHOOSER,
		COLUMN_HEADER,
		COMBO_BOX,
		DATE_EDITOR,
		DESKTOP_ICON,
		DESKTOP_FRAME,
		DIAL,
		DIALOG,
		DIRECTORY_PANE,
		DRAWING_AREA,
		FILE_CHOOSER,
		FILLER,
		FONT_CHOOSER,
		FRAME,
		GLASS_PANE,
		HTML_CONTAINER,
		ICON,
		IMAGE,
		INTERNAL_FRAME,
		LABEL,
		LAYERED_PANE,
		LIST,
		LIST_ITEM,
		MENU,
		MENU_BAR,
		MENU_ITEM,
		OPTION_PANE,
		PAGE_TAB,
		PAGE_TAB_LIST,
		PANEL,
		PASSWORD_TEXT,
		POPUP_MENU,
		PROGRESS_BAR,
		PUSH_BUTTON,
		RADIO_BUTTON,
		RADIO_MENU_ITEM,
		ROOT_PANE,
		ROW_HEADER,
		SCROLL_BAR,
		SCROLL_PANE,
		SEPARATOR,
		SLIDER,
		SPLIT_PANE,
		SPIN_BUTTON,
		STATUSBAR,
		TABLE,
		TABLE_CELL,
		TABLE_COLUMN_HEADER,
		TABLE_ROW_HEADER,
		TEAR_OFF_MENU_ITEM,
		TERMINAL,
		TEXT,
		TOGGLE_BUTTON,
		TOOL_BAR,
		TOOL_TIP,
		TREE,
		TREE_TABLE,
		UNKNOWN,
		VIEWPORT,
		WINDOW,
		HEADER,
		FOOTER,
		PARAGRAPH,
		RULER,
		APPLICATION,
		AUTOCOMPLETE,
		EDITBAR,
		EMBEDDED,
		ENTRY,
		CHART,
		CAPTION,
		DOCUMENT_FRAME,
		HEADING,
		PAGE,
		SECTION,
		REDUNDANT_OBJECT,
		FORM,
		LINK,
		INPUT_METHOD_WINDOW,
		LAST_DEFINED,
	}
	[CCode (cprefix = "ATK_STATE_")]
	public enum StateType {
		INVALID,
		ACTIVE,
		ARMED,
		BUSY,
		CHECKED,
		DEFUNCT,
		EDITABLE,
		ENABLED,
		EXPANDABLE,
		EXPANDED,
		FOCUSABLE,
		FOCUSED,
		HORIZONTAL,
		ICONIFIED,
		MODAL,
		MULTI_LINE,
		MULTISELECTABLE,
		OPAQUE,
		PRESSED,
		RESIZABLE,
		SELECTABLE,
		SELECTED,
		SENSITIVE,
		SHOWING,
		SINGLE_LINE,
		STALE,
		TRANSIENT,
		VERTICAL,
		VISIBLE,
		MANAGES_DESCENDANTS,
		INDETERMINATE,
		TRUNCATED,
		REQUIRED,
		INVALID_ENTRY,
		SUPPORTS_AUTOCOMPLETION,
		SELECTABLE_TEXT,
		DEFAULT,
		ANIMATED,
		VISITED,
		LAST_DEFINED,
	}
	[CCode (cprefix = "ATK_TEXT_ATTR_")]
	public enum TextAttribute {
		INVALID,
		LEFT_MARGIN,
		RIGHT_MARGIN,
		INDENT,
		INVISIBLE,
		EDITABLE,
		PIXELS_ABOVE_LINES,
		PIXELS_BELOW_LINES,
		PIXELS_INSIDE_WRAP,
		BG_FULL_HEIGHT,
		RISE,
		UNDERLINE,
		STRIKETHROUGH,
		SIZE,
		SCALE,
		WEIGHT,
		LANGUAGE,
		FAMILY_NAME,
		BG_COLOR,
		FG_COLOR,
		BG_STIPPLE,
		FG_STIPPLE,
		WRAP_MODE,
		DIRECTION,
		JUSTIFICATION,
		STRETCH,
		VARIANT,
		STYLE,
		LAST_DEFINED,
	}
	[CCode (cprefix = "ATK_TEXT_BOUNDARY_")]
	public enum TextBoundary {
		CHAR,
		WORD_START,
		WORD_END,
		SENTENCE_START,
		SENTENCE_END,
		LINE_START,
		LINE_END,
	}
	[CCode (cprefix = "ATK_TEXT_CLIP_")]
	public enum TextClipType {
		NONE,
		MIN,
		MAX,
		BOTH,
	}
	public callback void EventListener (Atk.Object obj);
	public callback void EventListenerInit ();
	public callback void FocusHandler (Atk.Object arg1, bool arg2);
	public callback bool Function (pointer data);
	public callback int KeySnoopFunc (Atk.KeyEventStruct event, pointer func_data);
	public callback void PropertyChangeHandler (Atk.Object arg1, Atk.PropertyValues arg2);
}
