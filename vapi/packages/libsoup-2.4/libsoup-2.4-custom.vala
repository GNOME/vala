namespace Soup {
	[Deprecated (since = "vala-0.12", replacement = "XMLRPC.build_fault")]
	[PrintfFormat]
	public static unowned string xmlrpc_build_fault (int fault_code, string fault_format, ...);
	[Deprecated (since = "vala-0.12", replacement = "XMLRPC.build_method_call")]
	public static unowned string xmlrpc_build_method_call (string method_name, GLib.Value[] @params);
	[Deprecated (since = "vala-0.12", replacement = "XMLRPC.build_method_response")]
	public static unowned string xmlrpc_build_method_response (GLib.Value value);
	[Deprecated (since = "vala-0.12", replacement = "XMLRPC.error_quark")]
	public static GLib.Quark xmlrpc_error_quark ();
	[Deprecated (since = "vala-0.12", replacement = "XMLRPC.extract_method_call")]
	[CCode (sentinel = "G_TYPE_INVALID")]
	public static bool xmlrpc_extract_method_call (string method_call, int length, out unowned string method_name, ...);
	[Deprecated (since = "vala-0.12", replacement = "XMLRPC.extract_method_response")]
	[CCode (sentinel = "G_TYPE_INVALID")]
	public static bool xmlrpc_extract_method_response (string method_response, int length, ...) throws GLib.Error;
	[Deprecated (since = "vala-0.12", replacement = "XMLRPC.fault_quark")]
	public static GLib.Quark xmlrpc_fault_quark ();
	[Deprecated (since = "vala-0.12", replacement = "XMLRPC.parse_method_call")]
	public static bool xmlrpc_parse_method_call (string method_call, int length, out unowned string method_name, out unowned GLib.ValueArray @params);
	[Deprecated (since = "vala-0.12", replacement = "XMLRPC.parse_method_response")]
	public static bool xmlrpc_parse_method_response (string method_response, int length, GLib.Value value) throws GLib.Error;
	[Deprecated (since = "vala-0.12", replacement = "XMLRPC.request_new")]
	[CCode (sentinel = "G_TYPE_INVALID")]
	public static unowned Soup.Message xmlrpc_request_new (string uri, string method_name, ...);
	[Deprecated (since = "vala-0.12", replacement = "XMLRPC.set_fault")]
	[PrintfFormat]
	public static void xmlrpc_set_fault (Soup.Message msg, int fault_code, string fault_format, ...);
	[Deprecated (since = "vala-0.12", replacement = "XMLRPC.set_response")]
	[CCode (sentinel = "G_TYPE_INVALID")]
	public static void xmlrpc_set_response (Soup.Message msg, ...);
}