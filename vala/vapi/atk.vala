[CCode (cheader_filename = "packages/atk/atk.h")]
namespace Atk {
	public class GObjectAccessible : Atk.Object {
		[NoArrayLength ()]
		public static Atk.Object for_object (GLib.Object obj);
		[NoArrayLength ()]
		public GLib.Object get_object ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
	}
	public class Hyperlink : GLib.Object, Atk.Action {
		[NoArrayLength ()]
		public int get_end_index ();
		[NoArrayLength ()]
		public int get_n_anchors ();
		[NoArrayLength ()]
		public Atk.Object get_object (int i);
		[NoArrayLength ()]
		public int get_start_index ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public string get_uri (int i);
		[NoArrayLength ()]
		public bool is_inline ();
		[NoArrayLength ()]
		public bool is_selected_link ();
		[NoArrayLength ()]
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
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (GLib.Object obj);
	}
	public class NoOpObjectFactory : Atk.ObjectFactory {
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class Object : GLib.Object {
		[NoArrayLength ()]
		public bool add_relationship (Atk.RelationType relationship, Atk.Object target);
		[NoArrayLength ()]
		public uint connect_property_change_handler (Atk.PropertyChangeHandler handler);
		[NoArrayLength ()]
		public GLib.SList get_attributes ();
		[NoArrayLength ()]
		public string get_description ();
		[NoArrayLength ()]
		public int get_index_in_parent ();
		[NoArrayLength ()]
		public Atk.Layer get_layer ();
		[NoArrayLength ()]
		public int get_mdi_zorder ();
		[NoArrayLength ()]
		public int get_n_accessible_children ();
		[NoArrayLength ()]
		public string get_name ();
		[NoArrayLength ()]
		public Atk.Object get_parent ();
		[NoArrayLength ()]
		public Atk.Role get_role ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public void initialize (pointer data);
		[NoArrayLength ()]
		public void notify_state_change (Atk.State state, bool value);
		[NoArrayLength ()]
		public Atk.Object ref_accessible_child (int i);
		[NoArrayLength ()]
		public Atk.RelationSet ref_relation_set ();
		[NoArrayLength ()]
		public Atk.StateSet ref_state_set ();
		[NoArrayLength ()]
		public void remove_property_change_handler (uint handler_id);
		[NoArrayLength ()]
		public bool remove_relationship (Atk.RelationType relationship, Atk.Object target);
		[NoArrayLength ()]
		public void set_description (string description);
		[NoArrayLength ()]
		public void set_name (string name);
		[NoArrayLength ()]
		public void set_parent (Atk.Object parent);
		[NoArrayLength ()]
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
		[NoArrayLength ()]
		public Atk.Object create_accessible (GLib.Object obj);
		[NoArrayLength ()]
		public GLib.Type get_accessible_type ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public void invalidate ();
	}
	public class Registry : GLib.Object {
		[NoArrayLength ()]
		public Atk.ObjectFactory get_factory (GLib.Type type);
		[NoArrayLength ()]
		public GLib.Type get_factory_type (GLib.Type type);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public void set_factory_type (GLib.Type type, GLib.Type factory_type);
	}
	public class Relation : GLib.Object {
		[NoArrayLength ()]
		public void add_target (Atk.Object target);
		[NoArrayLength ()]
		public Atk.RelationType get_relation_type ();
		[NoArrayLength ()]
		public GLib.PtrArray get_target ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Atk.Object targets, int n_targets, Atk.RelationType relationship);
		[NoArrayLength ()]
		public static Atk.RelationType type_for_name (string name);
		[NoArrayLength ()]
		public static string type_get_name (Atk.RelationType type);
		[NoArrayLength ()]
		public static Atk.RelationType type_register (string name);
		[NoAccessorMethod ()]
		public weak Atk.RelationType relation_type { get; set; }
		[NoAccessorMethod ()]
		public weak GLib.ValueArray target { get; set; }
	}
	public class RelationSet : GLib.Object {
		[NoArrayLength ()]
		public void add (Atk.Relation relation);
		[NoArrayLength ()]
		public void add_relation_by_type (Atk.RelationType relationship, Atk.Object target);
		[NoArrayLength ()]
		public bool contains (Atk.RelationType relationship);
		[NoArrayLength ()]
		public int get_n_relations ();
		[NoArrayLength ()]
		public Atk.Relation get_relation (int i);
		[NoArrayLength ()]
		public Atk.Relation get_relation_by_type (Atk.RelationType relationship);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void remove (Atk.Relation relation);
	}
	public class StateSet : GLib.Object {
		[NoArrayLength ()]
		public bool add_state (Atk.StateType type);
		[NoArrayLength ()]
		public void add_states (Atk.StateType types, int n_types);
		[NoArrayLength ()]
		public Atk.StateSet and_sets (Atk.StateSet compare_set);
		[NoArrayLength ()]
		public void clear_states ();
		[NoArrayLength ()]
		public bool contains_state (Atk.StateType type);
		[NoArrayLength ()]
		public bool contains_states (Atk.StateType types, int n_types);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool is_empty ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public Atk.StateSet or_sets (Atk.StateSet compare_set);
		[NoArrayLength ()]
		public bool remove_state (Atk.StateType type);
		[NoArrayLength ()]
		public Atk.StateSet xor_sets (Atk.StateSet compare_set);
	}
	public class Util : GLib.Object {
		[NoArrayLength ()]
		public GLib.Type get_type ();
	}
	public interface Action {
		[NoArrayLength ()]
		public bool do_action (int i);
		[NoArrayLength ()]
		public string get_description (int i);
		[NoArrayLength ()]
		public string get_keybinding (int i);
		[NoArrayLength ()]
		public string get_localized_name (int i);
		[NoArrayLength ()]
		public int get_n_actions ();
		[NoArrayLength ()]
		public string get_name (int i);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool set_description (int i, string desc);
	}
	public interface Component {
		[NoArrayLength ()]
		public uint add_focus_handler (Atk.FocusHandler handler);
		[NoArrayLength ()]
		public bool contains (int x, int y, Atk.CoordType coord_type);
		[NoArrayLength ()]
		public double get_alpha ();
		[NoArrayLength ()]
		public void get_extents (int x, int y, int width, int height, Atk.CoordType coord_type);
		[NoArrayLength ()]
		public Atk.Layer get_layer ();
		[NoArrayLength ()]
		public int get_mdi_zorder ();
		[NoArrayLength ()]
		public void get_position (int x, int y, Atk.CoordType coord_type);
		[NoArrayLength ()]
		public void get_size (int width, int height);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool grab_focus ();
		[NoArrayLength ()]
		public Atk.Object ref_accessible_at_point (int x, int y, Atk.CoordType coord_type);
		[NoArrayLength ()]
		public void remove_focus_handler (uint handler_id);
		[NoArrayLength ()]
		public bool set_extents (int x, int y, int width, int height, Atk.CoordType coord_type);
		[NoArrayLength ()]
		public bool set_position (int x, int y, Atk.CoordType coord_type);
		[NoArrayLength ()]
		public bool set_size (int width, int height);
	}
	public interface Document {
		[NoArrayLength ()]
		public string get_attribute_value (string attribute_name);
		[NoArrayLength ()]
		public GLib.SList get_attributes ();
		[NoArrayLength ()]
		public pointer get_document ();
		[NoArrayLength ()]
		public string get_document_type ();
		[NoArrayLength ()]
		public string get_locale ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool set_attribute_value (string attribute_name, string attribute_value);
	}
	public interface EditableText {
		[NoArrayLength ()]
		public void copy_text (int start_pos, int end_pos);
		[NoArrayLength ()]
		public void cut_text (int start_pos, int end_pos);
		[NoArrayLength ()]
		public void delete_text (int start_pos, int end_pos);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public void insert_text (string string, int length, int position);
		[NoArrayLength ()]
		public void paste_text (int position);
		[NoArrayLength ()]
		public bool set_run_attributes (GLib.SList attrib_set, int start_offset, int end_offset);
		[NoArrayLength ()]
		public void set_text_contents (string string);
	}
	public interface HyperlinkImpl {
		[NoArrayLength ()]
		public Atk.Hyperlink get_hyperlink ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
	}
	public interface Hypertext {
		[NoArrayLength ()]
		public Atk.Hyperlink get_link (int link_index);
		[NoArrayLength ()]
		public int get_link_index (int char_index);
		[NoArrayLength ()]
		public int get_n_links ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
	}
	public interface Image {
		[NoArrayLength ()]
		public string get_image_description ();
		[NoArrayLength ()]
		public string get_image_locale ();
		[NoArrayLength ()]
		public void get_image_position (int x, int y, Atk.CoordType coord_type);
		[NoArrayLength ()]
		public void get_image_size (int width, int height);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool set_image_description (string description);
	}
	public interface Implementor {
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public Atk.Object ref_accessible ();
	}
	public interface Selection {
		[NoArrayLength ()]
		public bool add_selection (int i);
		[NoArrayLength ()]
		public bool clear_selection ();
		[NoArrayLength ()]
		public int get_selection_count ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool is_child_selected (int i);
		[NoArrayLength ()]
		public Atk.Object ref_selection (int i);
		[NoArrayLength ()]
		public bool remove_selection (int i);
		[NoArrayLength ()]
		public bool select_all_selection ();
	}
	public interface StreamableContent {
		[NoArrayLength ()]
		public string get_mime_type (int i);
		[NoArrayLength ()]
		public int get_n_mime_types ();
		[NoArrayLength ()]
		public GLib.IOChannel get_stream (string mime_type);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public string get_uri (string mime_type);
	}
	public interface Table {
		[NoArrayLength ()]
		public bool add_column_selection (int column);
		[NoArrayLength ()]
		public bool add_row_selection (int row);
		[NoArrayLength ()]
		public Atk.Object get_caption ();
		[NoArrayLength ()]
		public int get_column_at_index (int index_);
		[NoArrayLength ()]
		public string get_column_description (int column);
		[NoArrayLength ()]
		public int get_column_extent_at (int row, int column);
		[NoArrayLength ()]
		public Atk.Object get_column_header (int column);
		[NoArrayLength ()]
		public int get_index_at (int row, int column);
		[NoArrayLength ()]
		public int get_n_columns ();
		[NoArrayLength ()]
		public int get_n_rows ();
		[NoArrayLength ()]
		public int get_row_at_index (int index_);
		[NoArrayLength ()]
		public string get_row_description (int row);
		[NoArrayLength ()]
		public int get_row_extent_at (int row, int column);
		[NoArrayLength ()]
		public Atk.Object get_row_header (int row);
		[NoArrayLength ()]
		public int get_selected_columns (int selected);
		[NoArrayLength ()]
		public int get_selected_rows (int selected);
		[NoArrayLength ()]
		public Atk.Object get_summary ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool is_column_selected (int column);
		[NoArrayLength ()]
		public bool is_row_selected (int row);
		[NoArrayLength ()]
		public bool is_selected (int row, int column);
		[NoArrayLength ()]
		public Atk.Object ref_at (int row, int column);
		[NoArrayLength ()]
		public bool remove_column_selection (int column);
		[NoArrayLength ()]
		public bool remove_row_selection (int row);
		[NoArrayLength ()]
		public void set_caption (Atk.Object caption);
		[NoArrayLength ()]
		public void set_column_description (int column, string description);
		[NoArrayLength ()]
		public void set_column_header (int column, Atk.Object header);
		[NoArrayLength ()]
		public void set_row_description (int row, string description);
		[NoArrayLength ()]
		public void set_row_header (int row, Atk.Object header);
		[NoArrayLength ()]
		public void set_summary (Atk.Object accessible);
	}
	public interface Text {
		[NoArrayLength ()]
		public bool add_selection (int start_offset, int end_offset);
		[NoArrayLength ()]
		public static Atk.TextAttribute attribute_for_name (string name);
		[NoArrayLength ()]
		public static string attribute_get_name (Atk.TextAttribute attr);
		[NoArrayLength ()]
		public static string attribute_get_value (Atk.TextAttribute attr, int index_);
		[NoArrayLength ()]
		public static Atk.TextAttribute attribute_register (string name);
		[NoArrayLength ()]
		public static void free_ranges (Atk.TextRange ranges);
		[NoArrayLength ()]
		public Atk.TextRange get_bounded_ranges (Atk.TextRectangle rect, Atk.CoordType coord_type, Atk.TextClipType x_clip_type, Atk.TextClipType y_clip_type);
		[NoArrayLength ()]
		public int get_caret_offset ();
		[NoArrayLength ()]
		public unichar get_character_at_offset (int offset);
		[NoArrayLength ()]
		public int get_character_count ();
		[NoArrayLength ()]
		public void get_character_extents (int offset, int x, int y, int width, int height, Atk.CoordType coords);
		[NoArrayLength ()]
		public GLib.SList get_default_attributes ();
		[NoArrayLength ()]
		public int get_n_selections ();
		[NoArrayLength ()]
		public int get_offset_at_point (int x, int y, Atk.CoordType coords);
		[NoArrayLength ()]
		public void get_range_extents (int start_offset, int end_offset, Atk.CoordType coord_type, Atk.TextRectangle rect);
		[NoArrayLength ()]
		public GLib.SList get_run_attributes (int offset, int start_offset, int end_offset);
		[NoArrayLength ()]
		public string get_selection (int selection_num, int start_offset, int end_offset);
		[NoArrayLength ()]
		public string get_text (int start_offset, int end_offset);
		[NoArrayLength ()]
		public string get_text_after_offset (int offset, Atk.TextBoundary boundary_type, int start_offset, int end_offset);
		[NoArrayLength ()]
		public string get_text_at_offset (int offset, Atk.TextBoundary boundary_type, int start_offset, int end_offset);
		[NoArrayLength ()]
		public string get_text_before_offset (int offset, Atk.TextBoundary boundary_type, int start_offset, int end_offset);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool remove_selection (int selection_num);
		[NoArrayLength ()]
		public bool set_caret_offset (int offset);
		[NoArrayLength ()]
		public bool set_selection (int selection_num, int start_offset, int end_offset);
	}
	public interface Value {
		[NoArrayLength ()]
		public void get_current_value (GLib.Value value);
		[NoArrayLength ()]
		public void get_maximum_value (GLib.Value value);
		[NoArrayLength ()]
		public void get_minimum_increment (GLib.Value value);
		[NoArrayLength ()]
		public void get_minimum_value (GLib.Value value);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool set_current_value (GLib.Value value);
	}
	[ReferenceType ()]
	public struct Attribute {
		public weak string name;
		public weak string value;
		[NoArrayLength ()]
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
		[NoArrayLength ()]
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
		[NoArrayLength ()]
		public static uint _add_focus_tracker (Atk.EventListener focus_tracker);
		[NoArrayLength ()]
		public static uint _add_global_event_listener (GLib.SignalEmissionHook listener, string event_type);
		[NoArrayLength ()]
		public static uint _add_key_event_listener (Atk.KeySnoopFunc listener, pointer data);
		[NoArrayLength ()]
		public Atk.Registry _get_default_registry ();
		[NoArrayLength ()]
		public Atk.Object _get_focus_object ();
		[NoArrayLength ()]
		public Atk.Object _get_root ();
		[NoArrayLength ()]
		public string _get_toolkit_name ();
		[NoArrayLength ()]
		public string _get_toolkit_version ();
		[NoArrayLength ()]
		public static void _remove_focus_tracker (uint tracker_id);
		[NoArrayLength ()]
		public static void _remove_global_event_listener (uint listener_id);
		[NoArrayLength ()]
		public static void _remove_key_event_listener (uint listener_id);
		[NoArrayLength ()]
		public static Atk.Role _role_for_name (string name);
		[NoArrayLength ()]
		public static string _role_get_localized_name (Atk.Role role);
		[NoArrayLength ()]
		public static string _role_get_name (Atk.Role role);
		[NoArrayLength ()]
		public static Atk.Role _role_register (string name);
	}
	[ReferenceType ()]
	public struct Focus {
		[NoArrayLength ()]
		public static void tracker_init (Atk.EventListenerInit init);
		[NoArrayLength ()]
		public static void tracker_notify (Atk.Object object);
	}
	[ReferenceType ()]
	public struct State {
		[NoArrayLength ()]
		public static Atk.StateType type_for_name (string name);
		[NoArrayLength ()]
		public static string type_get_name (Atk.StateType type);
		[NoArrayLength ()]
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
