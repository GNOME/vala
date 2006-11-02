[CCode (cheader_filename = "packages/atk/atk.h")]
namespace Atk {
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
	public class GObjectAccessible : Atk.Object {
		[NoArrayLength ()]
		[CCode (cname = "atk_gobject_accessible_for_object")]
		public static Atk.Object for_object (GLib.Object obj);
		[NoArrayLength ()]
		[CCode (cname = "atk_gobject_accessible_get_object")]
		public GLib.Object get_object ();
		[NoArrayLength ()]
		[CCode (cname = "atk_gobject_accessible_get_type")]
		public static GLib.Type get_type ();
	}
	public class Hyperlink : GLib.Object, Atk.Action {
		[NoArrayLength ()]
		[CCode (cname = "atk_hyperlink_get_end_index")]
		public virtual int get_end_index ();
		[NoArrayLength ()]
		[CCode (cname = "atk_hyperlink_get_n_anchors")]
		public virtual int get_n_anchors ();
		[NoArrayLength ()]
		[CCode (cname = "atk_hyperlink_get_object")]
		public virtual Atk.Object get_object (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_hyperlink_get_start_index")]
		public virtual int get_start_index ();
		[NoArrayLength ()]
		[CCode (cname = "atk_hyperlink_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_hyperlink_get_uri")]
		public virtual string get_uri (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_hyperlink_is_inline")]
		public bool is_inline ();
		[NoArrayLength ()]
		[CCode (cname = "atk_hyperlink_is_selected_link")]
		public virtual bool is_selected_link ();
		[NoArrayLength ()]
		[CCode (cname = "atk_hyperlink_is_valid")]
		public virtual bool is_valid ();
		[NoAccessorMethod ()]
		public weak bool selected_link { get; }
		[NoAccessorMethod ()]
		public weak int number_of_anchors { get; }
		public weak int end_index { get; }
		public weak int start_index { get; }
		public signal void link_activated ();
	}
	public class NoOpObject : Atk.Object, Atk.Component, Atk.Action, Atk.EditableText, Atk.Image, Atk.Selection, Atk.Table, Atk.Text, Atk.Hypertext, Atk.Value, Atk.Document {
		[NoArrayLength ()]
		[CCode (cname = "atk_no_op_object_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_no_op_object_new")]
		public construct (GLib.Object obj);
	}
	public class NoOpObjectFactory : Atk.ObjectFactory {
		[NoArrayLength ()]
		[CCode (cname = "atk_no_op_object_factory_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_no_op_object_factory_new")]
		public construct ();
	}
	public class Object : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "atk_object_add_relationship")]
		public bool add_relationship (Atk.RelationType relationship, Atk.Object target);
		[NoArrayLength ()]
		[CCode (cname = "atk_object_connect_property_change_handler")]
		public virtual uint connect_property_change_handler (Atk.PropertyChangeHandler handler);
		[NoArrayLength ()]
		[CCode (cname = "atk_object_get_attributes")]
		public virtual GLib.SList get_attributes ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_get_description")]
		public virtual string get_description ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_get_index_in_parent")]
		public virtual int get_index_in_parent ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_get_layer")]
		public virtual Atk.Layer get_layer ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_get_mdi_zorder")]
		public virtual int get_mdi_zorder ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_get_n_accessible_children")]
		public int get_n_accessible_children ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_get_name")]
		public virtual string get_name ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_get_parent")]
		public virtual Atk.Object get_parent ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_get_role")]
		public virtual Atk.Role get_role ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_initialize")]
		public virtual void initialize (pointer data);
		[NoArrayLength ()]
		[CCode (cname = "atk_object_notify_state_change")]
		public void notify_state_change (Atk.State state, bool value);
		[NoArrayLength ()]
		[CCode (cname = "atk_object_ref_accessible_child")]
		public Atk.Object ref_accessible_child (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_object_ref_relation_set")]
		public virtual Atk.RelationSet ref_relation_set ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_ref_state_set")]
		public virtual Atk.StateSet ref_state_set ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_remove_property_change_handler")]
		public virtual void remove_property_change_handler (uint handler_id);
		[NoArrayLength ()]
		[CCode (cname = "atk_object_remove_relationship")]
		public bool remove_relationship (Atk.RelationType relationship, Atk.Object target);
		[NoArrayLength ()]
		[CCode (cname = "atk_object_set_description")]
		public virtual void set_description (string description);
		[NoArrayLength ()]
		[CCode (cname = "atk_object_set_name")]
		public virtual void set_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "atk_object_set_parent")]
		public virtual void set_parent (Atk.Object parent);
		[NoArrayLength ()]
		[CCode (cname = "atk_object_set_role")]
		public virtual void set_role (Atk.Role role);
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
		[CCode (cname = "atk_object_factory_create_accessible")]
		public virtual Atk.Object create_accessible (GLib.Object obj);
		[NoArrayLength ()]
		[CCode (cname = "atk_object_factory_get_accessible_type")]
		public virtual GLib.Type get_accessible_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_factory_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_object_factory_invalidate")]
		public virtual void invalidate ();
	}
	public class Registry : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "atk_registry_get_factory")]
		public Atk.ObjectFactory get_factory (GLib.Type type);
		[NoArrayLength ()]
		[CCode (cname = "atk_registry_get_factory_type")]
		public GLib.Type get_factory_type (GLib.Type type);
		[NoArrayLength ()]
		[CCode (cname = "atk_registry_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_registry_set_factory_type")]
		public void set_factory_type (GLib.Type type, GLib.Type factory_type);
	}
	public class Relation : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_add_target")]
		public void add_target (Atk.Object target);
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_get_relation_type")]
		public Atk.RelationType get_relation_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_get_target")]
		public GLib.PtrArray get_target ();
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_new")]
		public construct (Atk.Object targets, int n_targets, Atk.RelationType relationship);
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_type_for_name")]
		public static Atk.RelationType type_for_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_type_get_name")]
		public static string type_get_name (Atk.RelationType type);
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_type_register")]
		public static Atk.RelationType type_register (string name);
		[NoAccessorMethod ()]
		public weak Atk.RelationType relation_type { get; set; }
		[NoAccessorMethod ()]
		public weak GLib.ValueArray target { get; set; }
	}
	public class RelationSet : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_set_add")]
		public void add (Atk.Relation relation);
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_set_add_relation_by_type")]
		public void add_relation_by_type (Atk.RelationType relationship, Atk.Object target);
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_set_contains")]
		public bool contains (Atk.RelationType relationship);
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_set_get_n_relations")]
		public int get_n_relations ();
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_set_get_relation")]
		public Atk.Relation get_relation (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_set_get_relation_by_type")]
		public Atk.Relation get_relation_by_type (Atk.RelationType relationship);
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_set_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_set_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "atk_relation_set_remove")]
		public void remove (Atk.Relation relation);
	}
	public class StateSet : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "atk_state_set_add_state")]
		public bool add_state (Atk.StateType type);
		[NoArrayLength ()]
		[CCode (cname = "atk_state_set_add_states")]
		public void add_states (Atk.StateType types, int n_types);
		[NoArrayLength ()]
		[CCode (cname = "atk_state_set_and_sets")]
		public Atk.StateSet and_sets (Atk.StateSet compare_set);
		[NoArrayLength ()]
		[CCode (cname = "atk_state_set_clear_states")]
		public void clear_states ();
		[NoArrayLength ()]
		[CCode (cname = "atk_state_set_contains_state")]
		public bool contains_state (Atk.StateType type);
		[NoArrayLength ()]
		[CCode (cname = "atk_state_set_contains_states")]
		public bool contains_states (Atk.StateType types, int n_types);
		[NoArrayLength ()]
		[CCode (cname = "atk_state_set_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_state_set_is_empty")]
		public bool is_empty ();
		[NoArrayLength ()]
		[CCode (cname = "atk_state_set_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "atk_state_set_or_sets")]
		public Atk.StateSet or_sets (Atk.StateSet compare_set);
		[NoArrayLength ()]
		[CCode (cname = "atk_state_set_remove_state")]
		public bool remove_state (Atk.StateType type);
		[NoArrayLength ()]
		[CCode (cname = "atk_state_set_xor_sets")]
		public Atk.StateSet xor_sets (Atk.StateSet compare_set);
	}
	public class Util : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "atk_util_get_type")]
		public static GLib.Type get_type ();
	}
	public interface Action {
		[NoArrayLength ()]
		[CCode (cname = "atk_action_do_action")]
		public virtual bool do_action (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_action_get_description")]
		public virtual string get_description (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_action_get_keybinding")]
		public virtual string get_keybinding (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_action_get_localized_name")]
		public virtual string get_localized_name (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_action_get_n_actions")]
		public virtual int get_n_actions ();
		[NoArrayLength ()]
		[CCode (cname = "atk_action_get_name")]
		public virtual string get_name (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_action_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_action_set_description")]
		public virtual bool set_description (int i, string desc);
	}
	public interface Component {
		[NoArrayLength ()]
		[CCode (cname = "atk_component_add_focus_handler")]
		public virtual uint add_focus_handler (Atk.FocusHandler handler);
		[NoArrayLength ()]
		[CCode (cname = "atk_component_contains")]
		public virtual bool contains (int x, int y, Atk.CoordType coord_type);
		[NoArrayLength ()]
		[CCode (cname = "atk_component_get_alpha")]
		public virtual double get_alpha ();
		[NoArrayLength ()]
		[CCode (cname = "atk_component_get_extents")]
		public virtual void get_extents (int x, int y, int width, int height, Atk.CoordType coord_type);
		[NoArrayLength ()]
		[CCode (cname = "atk_component_get_layer")]
		public virtual Atk.Layer get_layer ();
		[NoArrayLength ()]
		[CCode (cname = "atk_component_get_mdi_zorder")]
		public virtual int get_mdi_zorder ();
		[NoArrayLength ()]
		[CCode (cname = "atk_component_get_position")]
		public virtual void get_position (int x, int y, Atk.CoordType coord_type);
		[NoArrayLength ()]
		[CCode (cname = "atk_component_get_size")]
		public virtual void get_size (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "atk_component_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_component_grab_focus")]
		public virtual bool grab_focus ();
		[NoArrayLength ()]
		[CCode (cname = "atk_component_ref_accessible_at_point")]
		public virtual Atk.Object ref_accessible_at_point (int x, int y, Atk.CoordType coord_type);
		[NoArrayLength ()]
		[CCode (cname = "atk_component_remove_focus_handler")]
		public virtual void remove_focus_handler (uint handler_id);
		[NoArrayLength ()]
		[CCode (cname = "atk_component_set_extents")]
		public virtual bool set_extents (int x, int y, int width, int height, Atk.CoordType coord_type);
		[NoArrayLength ()]
		[CCode (cname = "atk_component_set_position")]
		public virtual bool set_position (int x, int y, Atk.CoordType coord_type);
		[NoArrayLength ()]
		[CCode (cname = "atk_component_set_size")]
		public virtual bool set_size (int width, int height);
		public signal void bounds_changed (Atk.Rectangle bounds);
	}
	public interface Document {
		[NoArrayLength ()]
		[CCode (cname = "atk_document_get_attribute_value")]
		public string get_attribute_value (string attribute_name);
		[NoArrayLength ()]
		[CCode (cname = "atk_document_get_attributes")]
		public GLib.SList get_attributes ();
		[NoArrayLength ()]
		[CCode (cname = "atk_document_get_document")]
		public virtual pointer get_document ();
		[NoArrayLength ()]
		[CCode (cname = "atk_document_get_document_type")]
		public virtual string get_document_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_document_get_locale")]
		public string get_locale ();
		[NoArrayLength ()]
		[CCode (cname = "atk_document_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_document_set_attribute_value")]
		public bool set_attribute_value (string attribute_name, string attribute_value);
		public signal void load_complete ();
		public signal void reload ();
		public signal void load_stopped ();
	}
	public interface EditableText {
		[NoArrayLength ()]
		[CCode (cname = "atk_editable_text_copy_text")]
		public virtual void copy_text (int start_pos, int end_pos);
		[NoArrayLength ()]
		[CCode (cname = "atk_editable_text_cut_text")]
		public virtual void cut_text (int start_pos, int end_pos);
		[NoArrayLength ()]
		[CCode (cname = "atk_editable_text_delete_text")]
		public virtual void delete_text (int start_pos, int end_pos);
		[NoArrayLength ()]
		[CCode (cname = "atk_editable_text_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_editable_text_insert_text")]
		public virtual void insert_text (string string, int length, int position);
		[NoArrayLength ()]
		[CCode (cname = "atk_editable_text_paste_text")]
		public virtual void paste_text (int position);
		[NoArrayLength ()]
		[CCode (cname = "atk_editable_text_set_run_attributes")]
		public virtual bool set_run_attributes (GLib.SList attrib_set, int start_offset, int end_offset);
		[NoArrayLength ()]
		[CCode (cname = "atk_editable_text_set_text_contents")]
		public virtual void set_text_contents (string string);
	}
	public interface HyperlinkImpl {
		[NoArrayLength ()]
		[CCode (cname = "atk_hyperlink_impl_get_hyperlink")]
		public virtual Atk.Hyperlink get_hyperlink ();
		[NoArrayLength ()]
		[CCode (cname = "atk_hyperlink_impl_get_type")]
		public static GLib.Type get_type ();
	}
	public interface Hypertext {
		[NoArrayLength ()]
		[CCode (cname = "atk_hypertext_get_link")]
		public virtual Atk.Hyperlink get_link (int link_index);
		[NoArrayLength ()]
		[CCode (cname = "atk_hypertext_get_link_index")]
		public virtual int get_link_index (int char_index);
		[NoArrayLength ()]
		[CCode (cname = "atk_hypertext_get_n_links")]
		public virtual int get_n_links ();
		[NoArrayLength ()]
		[CCode (cname = "atk_hypertext_get_type")]
		public static GLib.Type get_type ();
		public signal void link_selected (int link_index);
	}
	public interface Image {
		[NoArrayLength ()]
		[CCode (cname = "atk_image_get_image_description")]
		public virtual string get_image_description ();
		[NoArrayLength ()]
		[CCode (cname = "atk_image_get_image_locale")]
		public virtual string get_image_locale ();
		[NoArrayLength ()]
		[CCode (cname = "atk_image_get_image_position")]
		public virtual void get_image_position (int x, int y, Atk.CoordType coord_type);
		[NoArrayLength ()]
		[CCode (cname = "atk_image_get_image_size")]
		public virtual void get_image_size (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "atk_image_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_image_set_image_description")]
		public virtual bool set_image_description (string description);
	}
	public interface Implementor {
		[NoArrayLength ()]
		[CCode (cname = "atk_implementor_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_implementor_ref_accessible")]
		public virtual Atk.Object ref_accessible ();
	}
	public interface Selection {
		[NoArrayLength ()]
		[CCode (cname = "atk_selection_add_selection")]
		public virtual bool add_selection (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_selection_clear_selection")]
		public virtual bool clear_selection ();
		[NoArrayLength ()]
		[CCode (cname = "atk_selection_get_selection_count")]
		public virtual int get_selection_count ();
		[NoArrayLength ()]
		[CCode (cname = "atk_selection_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_selection_is_child_selected")]
		public virtual bool is_child_selected (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_selection_ref_selection")]
		public virtual Atk.Object ref_selection (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_selection_remove_selection")]
		public virtual bool remove_selection (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_selection_select_all_selection")]
		public virtual bool select_all_selection ();
		public signal void selection_changed ();
	}
	public interface StreamableContent {
		[NoArrayLength ()]
		[CCode (cname = "atk_streamable_content_get_mime_type")]
		public virtual string get_mime_type (int i);
		[NoArrayLength ()]
		[CCode (cname = "atk_streamable_content_get_n_mime_types")]
		public virtual int get_n_mime_types ();
		[NoArrayLength ()]
		[CCode (cname = "atk_streamable_content_get_stream")]
		public virtual GLib.IOChannel get_stream (string mime_type);
		[NoArrayLength ()]
		[CCode (cname = "atk_streamable_content_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_streamable_content_get_uri")]
		public virtual string get_uri (string mime_type);
	}
	public interface Table {
		[NoArrayLength ()]
		[CCode (cname = "atk_table_add_column_selection")]
		public virtual bool add_column_selection (int column);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_add_row_selection")]
		public virtual bool add_row_selection (int row);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_caption")]
		public virtual Atk.Object get_caption ();
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_column_at_index")]
		public virtual int get_column_at_index (int index_);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_column_description")]
		public virtual string get_column_description (int column);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_column_extent_at")]
		public virtual int get_column_extent_at (int row, int column);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_column_header")]
		public virtual Atk.Object get_column_header (int column);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_index_at")]
		public virtual int get_index_at (int row, int column);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_n_columns")]
		public virtual int get_n_columns ();
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_n_rows")]
		public virtual int get_n_rows ();
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_row_at_index")]
		public virtual int get_row_at_index (int index_);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_row_description")]
		public virtual string get_row_description (int row);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_row_extent_at")]
		public virtual int get_row_extent_at (int row, int column);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_row_header")]
		public virtual Atk.Object get_row_header (int row);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_selected_columns")]
		public virtual int get_selected_columns (int selected);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_selected_rows")]
		public virtual int get_selected_rows (int selected);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_summary")]
		public virtual Atk.Object get_summary ();
		[NoArrayLength ()]
		[CCode (cname = "atk_table_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_table_is_column_selected")]
		public virtual bool is_column_selected (int column);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_is_row_selected")]
		public virtual bool is_row_selected (int row);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_is_selected")]
		public virtual bool is_selected (int row, int column);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_ref_at")]
		public virtual Atk.Object ref_at (int row, int column);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_remove_column_selection")]
		public virtual bool remove_column_selection (int column);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_remove_row_selection")]
		public virtual bool remove_row_selection (int row);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_set_caption")]
		public virtual void set_caption (Atk.Object caption);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_set_column_description")]
		public virtual void set_column_description (int column, string description);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_set_column_header")]
		public virtual void set_column_header (int column, Atk.Object header);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_set_row_description")]
		public virtual void set_row_description (int row, string description);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_set_row_header")]
		public virtual void set_row_header (int row, Atk.Object header);
		[NoArrayLength ()]
		[CCode (cname = "atk_table_set_summary")]
		public virtual void set_summary (Atk.Object accessible);
		public signal void row_inserted (int row, int num_inserted);
		public signal void column_inserted (int column, int num_inserted);
		public signal void row_deleted (int row, int num_deleted);
		public signal void column_deleted (int column, int num_deleted);
		public signal void row_reordered ();
		public signal void column_reordered ();
		public signal void model_changed ();
	}
	public interface Text {
		[NoArrayLength ()]
		[CCode (cname = "atk_text_add_selection")]
		public virtual bool add_selection (int start_offset, int end_offset);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_attribute_for_name")]
		public static Atk.TextAttribute attribute_for_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_attribute_get_name")]
		public static string attribute_get_name (Atk.TextAttribute attr);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_attribute_get_value")]
		public static string attribute_get_value (Atk.TextAttribute attr, int index_);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_attribute_register")]
		public static Atk.TextAttribute attribute_register (string name);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_free_ranges")]
		public static void free_ranges (Atk.TextRange ranges);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_bounded_ranges")]
		public virtual Atk.TextRange get_bounded_ranges (Atk.TextRectangle rect, Atk.CoordType coord_type, Atk.TextClipType x_clip_type, Atk.TextClipType y_clip_type);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_caret_offset")]
		public virtual int get_caret_offset ();
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_character_at_offset")]
		public virtual unichar get_character_at_offset (int offset);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_character_count")]
		public virtual int get_character_count ();
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_character_extents")]
		public virtual void get_character_extents (int offset, int x, int y, int width, int height, Atk.CoordType coords);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_default_attributes")]
		public virtual GLib.SList get_default_attributes ();
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_n_selections")]
		public virtual int get_n_selections ();
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_offset_at_point")]
		public virtual int get_offset_at_point (int x, int y, Atk.CoordType coords);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_range_extents")]
		public virtual void get_range_extents (int start_offset, int end_offset, Atk.CoordType coord_type, Atk.TextRectangle rect);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_run_attributes")]
		public virtual GLib.SList get_run_attributes (int offset, int start_offset, int end_offset);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_selection")]
		public virtual string get_selection (int selection_num, int start_offset, int end_offset);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_text")]
		public virtual string get_text (int start_offset, int end_offset);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_text_after_offset")]
		public virtual string get_text_after_offset (int offset, Atk.TextBoundary boundary_type, int start_offset, int end_offset);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_text_at_offset")]
		public virtual string get_text_at_offset (int offset, Atk.TextBoundary boundary_type, int start_offset, int end_offset);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_text_before_offset")]
		public virtual string get_text_before_offset (int offset, Atk.TextBoundary boundary_type, int start_offset, int end_offset);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_text_remove_selection")]
		public virtual bool remove_selection (int selection_num);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_set_caret_offset")]
		public virtual bool set_caret_offset (int offset);
		[NoArrayLength ()]
		[CCode (cname = "atk_text_set_selection")]
		public virtual bool set_selection (int selection_num, int start_offset, int end_offset);
		public signal void text_changed (int position, int length);
		public signal void text_caret_moved (int location);
		public signal void text_selection_changed ();
		public signal void text_attributes_changed ();
	}
	public interface Value {
		[NoArrayLength ()]
		[CCode (cname = "atk_value_get_current_value")]
		public virtual void get_current_value (GLib.Value value);
		[NoArrayLength ()]
		[CCode (cname = "atk_value_get_maximum_value")]
		public virtual void get_maximum_value (GLib.Value value);
		[NoArrayLength ()]
		[CCode (cname = "atk_value_get_minimum_increment")]
		public virtual void get_minimum_increment (GLib.Value value);
		[NoArrayLength ()]
		[CCode (cname = "atk_value_get_minimum_value")]
		public virtual void get_minimum_value (GLib.Value value);
		[NoArrayLength ()]
		[CCode (cname = "atk_value_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "atk_value_set_current_value")]
		public virtual bool set_current_value (GLib.Value value);
	}
	[ReferenceType ()]
	public struct Attribute {
		public weak string name;
		public weak string value;
		[NoArrayLength ()]
		[CCode (cname = "atk_attribute_set_free")]
		public static void set_free (GLib.SList attrib_set);
	}
	[ReferenceType ()]
	public struct KeyEventStruct {
		public int type;
		public uint state;
		public uint keyval;
		public int length;
		public weak string string;
		public ushort keycode;
		public uint timestamp;
	}
	[ReferenceType ()]
	public struct PropertyValues {
		public weak string property_name;
		public weak GLib.Value old_value;
		public weak GLib.Value new_value;
	}
	public struct Rectangle {
		public int x;
		public int y;
		public int width;
		public int height;
		[NoArrayLength ()]
		[CCode (cname = "atk_rectangle_get_type")]
		public static GLib.Type get_type ();
	}
	[ReferenceType ()]
	public struct TextRange {
		public weak Atk.TextRectangle bounds;
		public int start_offset;
		public int end_offset;
		public weak string content;
	}
	[ReferenceType ()]
	public struct TextRectangle {
		public int x;
		public int y;
		public int width;
		public int height;
	}
	[ReferenceType ()]
	public struct Focus {
		[NoArrayLength ()]
		[CCode (cname = "atk_focus_tracker_init")]
		public static void tracker_init (Atk.EventListenerInit init);
		[NoArrayLength ()]
		[CCode (cname = "atk_focus_tracker_notify")]
		public static void tracker_notify (Atk.Object object);
	}
	[ReferenceType ()]
	public struct State {
		[NoArrayLength ()]
		[CCode (cname = "atk_state_type_for_name")]
		public static Atk.StateType type_for_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "atk_state_type_get_name")]
		public static string type_get_name (Atk.StateType type);
		[NoArrayLength ()]
		[CCode (cname = "atk_state_type_register")]
		public static Atk.StateType type_register (string name);
	}
	public callback void EventListener (Atk.Object obj);
	public callback void EventListenerInit ();
	public callback void FocusHandler (Atk.Object arg1, bool arg2);
	public callback bool Function (pointer data);
	public callback int KeySnoopFunc (Atk.KeyEventStruct event, pointer func_data);
	public callback void PropertyChangeHandler (Atk.Object arg1, Atk.PropertyValues arg2);
	[NoArrayLength ()]
	[CCode (cname = "atk_add_focus_tracker")]
	public static uint add_focus_tracker (Atk.EventListener focus_tracker);
	[NoArrayLength ()]
	[CCode (cname = "atk_add_global_event_listener")]
	public static uint add_global_event_listener (GLib.SignalEmissionHook listener, string event_type);
	[NoArrayLength ()]
	[CCode (cname = "atk_add_key_event_listener")]
	public static uint add_key_event_listener (Atk.KeySnoopFunc listener, pointer data);
	[NoArrayLength ()]
	[CCode (cname = "atk_get_default_registry")]
	public static Atk.Registry get_default_registry ();
	[NoArrayLength ()]
	[CCode (cname = "atk_get_focus_object")]
	public static Atk.Object get_focus_object ();
	[NoArrayLength ()]
	[CCode (cname = "atk_get_root")]
	public static Atk.Object get_root ();
	[NoArrayLength ()]
	[CCode (cname = "atk_get_toolkit_name")]
	public static string get_toolkit_name ();
	[NoArrayLength ()]
	[CCode (cname = "atk_get_toolkit_version")]
	public static string get_toolkit_version ();
	[NoArrayLength ()]
	[CCode (cname = "atk_remove_focus_tracker")]
	public static void remove_focus_tracker (uint tracker_id);
	[NoArrayLength ()]
	[CCode (cname = "atk_remove_global_event_listener")]
	public static void remove_global_event_listener (uint listener_id);
	[NoArrayLength ()]
	[CCode (cname = "atk_remove_key_event_listener")]
	public static void remove_key_event_listener (uint listener_id);
	[NoArrayLength ()]
	[CCode (cname = "atk_role_for_name")]
	public static Atk.Role role_for_name (string name);
	[NoArrayLength ()]
	[CCode (cname = "atk_role_get_localized_name")]
	public static string role_get_localized_name (Atk.Role role);
	[NoArrayLength ()]
	[CCode (cname = "atk_role_get_name")]
	public static string role_get_name (Atk.Role role);
	[NoArrayLength ()]
	[CCode (cname = "atk_role_register")]
	public static Atk.Role role_register (string name);
}
