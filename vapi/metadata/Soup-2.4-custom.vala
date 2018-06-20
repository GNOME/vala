namespace Soup {
	[Compact]
	[CCode (copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "soup_buffer_get_type ()", cheader_filename = "libsoup/soup.h")]
	public class Buffer {
		[CCode (has_construct_function = false)]
		public Buffer.subbuffer (Soup.Buffer parent, size_t offset, size_t length);
	}

	[Version (deprecated_since = "vala-0.12", replacement = "XMLRPC.build_fault")]
	[PrintfFormat]
	public static unowned string xmlrpc_build_fault (int fault_code, string fault_format, ...);
	[Version (deprecated_since = "vala-0.12", replacement = "XMLRPC.build_method_call")]
	public static unowned string xmlrpc_build_method_call (string method_name, GLib.Value[] @params);
	[Version (deprecated_since = "vala-0.12", replacement = "XMLRPC.build_method_response")]
	public static unowned string xmlrpc_build_method_response (GLib.Value value);
	[Version (deprecated_since = "vala-0.12", replacement = "XMLRPC.error_quark")]
	public static GLib.Quark xmlrpc_error_quark ();
	[Version (deprecated_since = "vala-0.12", replacement = "XMLRPC.extract_method_call")]
	[CCode (sentinel = "G_TYPE_INVALID")]
	public static bool xmlrpc_extract_method_call (string method_call, int length, out unowned string method_name, ...);
	[Version (deprecated_since = "vala-0.12", replacement = "XMLRPC.extract_method_response")]
	[CCode (sentinel = "G_TYPE_INVALID")]
	public static bool xmlrpc_extract_method_response (string method_response, int length, ...) throws GLib.Error;
	[Version (deprecated_since = "vala-0.12", replacement = "XMLRPC.fault_quark")]
	public static GLib.Quark xmlrpc_fault_quark ();
	[Version (deprecated_since = "vala-0.12", replacement = "XMLRPC.parse_method_call")]
	public static bool xmlrpc_parse_method_call (string method_call, int length, out unowned string method_name, out unowned GLib.ValueArray @params);
	[Version (deprecated_since = "vala-0.12", replacement = "XMLRPC.parse_method_response")]
	public static bool xmlrpc_parse_method_response (string method_response, int length, GLib.Value value) throws GLib.Error;
	[Version (deprecated_since = "vala-0.12", replacement = "XMLRPC.request_new")]
	[CCode (sentinel = "G_TYPE_INVALID")]
	public static unowned Soup.Message xmlrpc_request_new (string uri, string method_name, ...);
	[Version (deprecated_since = "vala-0.12", replacement = "XMLRPC.set_fault")]
	[PrintfFormat]
	public static void xmlrpc_set_fault (Soup.Message msg, int fault_code, string fault_format, ...);
	[Version (deprecated_since = "vala-0.12", replacement = "XMLRPC.set_response")]
	[CCode (sentinel = "G_TYPE_INVALID")]
	public static void xmlrpc_set_response (Soup.Message msg, ...);

	[Version (deprecated_since = "vala-0.12", replacement = "Form.decode")]
	public static GLib.HashTable<string,string> form_decode (string encoded_form);
	[Version (deprecated_since = "vala-0.12", replacement = "Form.decode_multipart")]
	public static GLib.HashTable<string,string> form_decode_multipart (Soup.Message msg, string file_control_name, out string filename, out string content_type, out Soup.Buffer file);
	[Version (deprecated_since = "vala-0.12", replacement = "Form.encode")]
	public static string form_encode (...);
	[Version (deprecated_since = "vala-0.12", replacement = "Form.encode_datalist")]
	public static string form_encode_datalist (void* form_data_set);
	[Version (deprecated_since = "vala-0.12", replacement = "Form.encode_hash")]
	public static string form_encode_hash (GLib.HashTable<string,string> form_data_set);
	[Version (deprecated_since = "vala-0.12")]
	public static string form_encode_valist (string first_field, void* args);
	[Version (deprecated_since = "vala-0.12", replacement = "Form.request_new")]
	public static Soup.Message form_request_new (string method, string uri, ...);
	[Version (deprecated_since = "vala-0.12", replacement = "Form.request_new_from_datalist")]
	public static Soup.Message form_request_new_from_datalist (string method, string uri, void* form_data_set);
	[Version (deprecated_since = "vala-0.12", replacement = "Form.request_new_from_hash")]
	public static Soup.Message form_request_new_from_hash (string method, string uri, GLib.HashTable<string,string> form_data_set);
	[Version (deprecated_since = "vala-0.12", replacement = "Form.request_new_from_multipart")]
	public static Soup.Message form_request_new_from_multipart (string uri, Soup.Multipart multipart);
	[Version (deprecated_since = "vala-0.14", replacement = "SSLError.quark")]
	public static GLib.Quark ssl_error_quark ();

	[Version (deprecated_since = "vala-0.22", replacement = "Status.get_phrase")]
	public static unowned string status_get_phrase (uint status_code);
	[Version (deprecated_since = "vala-0.22", replacement = "Status.proxify")]
	public static uint status_proxify (uint status_code);
}
