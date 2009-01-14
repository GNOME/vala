/* json-glib-1.0.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "Json", lower_case_cprefix = "json_")]
namespace Json {
	[Compact]
	[CCode (ref_function = "json_array_ref", unref_function = "json_array_unref", cheader_filename = "json-glib/json-glib.h")]
	public class Array {
		public void add_element (owned Json.Node node);
		public unowned Json.Node get_element (uint index_);
		public GLib.List<weak Json.Node> get_elements ();
		public uint get_length ();
		[CCode (has_construct_function = false)]
		public Array ();
		public void remove_element (uint index_);
		public static unowned Json.Array sized_new (uint n_elements);
	}
	[CCode (cheader_filename = "json-glib/json-glib.h")]
	public class Generator : GLib.Object {
		[CCode (has_construct_function = false)]
		public Generator ();
		public void set_root (Json.Node node);
		public string to_data (out size_t length);
		public bool to_file (string filename) throws GLib.Error;
		[NoAccessorMethod]
		public uint indent { get; set; }
		[NoAccessorMethod]
		public bool pretty { get; set; }
		[NoAccessorMethod]
		public Json.Node root { owned get; set; }
	}
	[Compact]
	[CCode (copy_function = "json_node_copy", cheader_filename = "json-glib/json-glib.h")]
	public class Node {
		public void* data;
		public weak Json.Node parent;
		public Json.NodeType type;
		public Json.Node copy ();
		public Json.Array dup_array ();
		public Json.Object dup_object ();
		public string dup_string ();
		public unowned Json.Array get_array ();
		public bool get_boolean ();
		public double get_double ();
		public int get_int ();
		public unowned Json.Object get_object ();
		public unowned Json.Node get_parent ();
		public unowned string get_string ();
		public void get_value (GLib.Value value);
		public GLib.Type get_value_type ();
		[CCode (has_construct_function = false)]
		public Node (Json.NodeType type);
		public void set_array (Json.Array array);
		public void set_boolean (bool value);
		public void set_double (double value);
		public void set_int (int value);
		public void set_object (Json.Object object);
		public void set_string (string value);
		public void set_value (GLib.Value value);
		public void take_array (owned Json.Array array);
		public void take_object (owned Json.Object object);
		public unowned string type_name ();
	}
	[Compact]
	[CCode (ref_function = "json_object_ref", unref_function = "json_object_unref", cheader_filename = "json-glib/json-glib.h")]
	public class Object {
		public void add_member (string member_name, owned Json.Node node);
		public unowned Json.Node get_member (string member_name);
		public GLib.List<weak string> get_members ();
		public uint get_size ();
		public GLib.List<weak Json.Node> get_values ();
		public bool has_member (string member_name);
		[CCode (has_construct_function = false)]
		public Object ();
		public void remove_member (string member_name);
	}
	[CCode (cheader_filename = "json-glib/json-glib.h")]
	public class Parser : GLib.Object {
		public static GLib.Quark error_quark ();
		public uint get_current_line ();
		public uint get_current_pos ();
		public unowned Json.Node get_root ();
		public bool has_assignment (out unowned string variable_name);
		public bool load_from_data (string data, size_t length) throws GLib.Error;
		public bool load_from_file (string filename) throws GLib.Error;
		[CCode (has_construct_function = false)]
		public Parser ();
		public virtual signal void array_element (Json.Array array, int index_);
		public virtual signal void array_end (Json.Array array);
		public virtual signal void array_start ();
		public virtual signal void error (void* error);
		public virtual signal void object_end (Json.Object object);
		public virtual signal void object_member (Json.Object object, string member_name);
		public virtual signal void object_start ();
		public virtual signal void parse_end ();
		public virtual signal void parse_start ();
	}
	[CCode (cheader_filename = "json-glib/json-glib.h")]
	public interface Serializable {
		public abstract bool deserialize_property (string property_name, GLib.Value value, GLib.ParamSpec pspec, Json.Node property_node);
		public abstract Json.Node serialize_property (string property_name, GLib.Value value, GLib.ParamSpec pspec);
	}
	[CCode (cprefix = "JSON_NODE_", has_type_id = "0", cheader_filename = "json-glib/json-glib.h")]
	public enum NodeType {
		OBJECT,
		ARRAY,
		VALUE,
		NULL
	}
	[CCode (cprefix = "JSON_PARSER_ERROR_", has_type_id = "0", cheader_filename = "json-glib/json-glib.h")]
	public enum ParserError {
		PARSE,
		UNKNOWN
	}
	[CCode (cprefix = "JSON_TOKEN_", has_type_id = "0", cheader_filename = "json-glib/json-glib.h")]
	public enum TokenType {
		INVALID,
		TRUE,
		FALSE,
		NULL,
		VAR,
		LAST
	}
	[CCode (cheader_filename = "json-glib/json-glib.h")]
	public const int MAJOR_VERSION;
	[CCode (cheader_filename = "json-glib/json-glib.h")]
	public const int MICRO_VERSION;
	[CCode (cheader_filename = "json-glib/json-glib.h")]
	public const int MINOR_VERSION;
	[CCode (cheader_filename = "json-glib/json-glib.h")]
	public const int VERSION_HEX;
	[CCode (cheader_filename = "json-glib/json-glib.h")]
	public const string VERSION_S;
	[CCode (cheader_filename = "json-glib/json-glib.h")]
	public static GLib.Object construct_gobject (GLib.Type gtype, string data, size_t length) throws GLib.Error;
	[CCode (cheader_filename = "json-glib/json-glib.h")]
	public static string serialize_gobject (GLib.Object gobject, out size_t length);
}
