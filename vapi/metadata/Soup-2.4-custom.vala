namespace Soup {
	[CCode (type_id = "soup_auth_domain_basic_get_type ()", cheader_filename = "libsoup/soup.h")]
	public class AuthDomainBasic : Soup.AuthDomain {
		public static void set_auth_callback (Soup.AuthDomain domain, owned Soup.AuthDomainBasicAuthCallback callback);
	}

	[CCode (type_id = "soup_auth_domain_digest_get_type ()", cheader_filename = "libsoup/soup.h")]
	public class AuthDomainDigest : Soup.AuthDomain {
		public static void set_auth_callback (Soup.AuthDomain domain, owned Soup.AuthDomainDigestAuthCallback callback);
	}

	[Compact]
	[CCode (copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "soup_buffer_get_type ()", cheader_filename = "libsoup/soup.h")]
	public class Buffer {
		[CCode (has_construct_function = false)]
		public Buffer.subbuffer (Soup.Buffer parent, size_t offset, size_t length);
	}

	[Deprecated (replacement = "Soup.ProxyURIResolver")]
	[CCode (cheader_filename = "libsoup/soup.h", type_cname = "SoupProxyResolverInterface", type_id = "soup_proxy_resolver_get_type ()")]
	public interface ProxyResolver : Soup.SessionFeature, GLib.Object {
		public abstract void get_proxy_async (Soup.Message msg, GLib.MainContext async_context, GLib.Cancellable? cancellable, Soup.ProxyResolverCallback callaback);
		public abstract uint get_proxy_sync (Soup.Message msg, GLib.Cancellable? cancellable, out unowned Soup.Address addr);
	}

	public errordomain SSLError {
		HANDSHAKE_NEEDS_READ,
		HANDSHAKE_NEEDS_WRITE,
		CERTIFICATE,
		HANDSHAKE_FAILED;
		public static GLib.Quark quark ();
	}

	[Compact]
	[CCode (copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "soup_uri_get_type ()", cheader_filename = "libsoup/soup.h")]
	public class URI {
		[CCode (has_construct_function = false)]
		public URI.with_base (Soup.URI @base, string uri_string);
	}

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

	[Deprecated (since = "vala-0.12", replacement = "Form.decode")]
	public static GLib.HashTable<string,string> form_decode (string encoded_form);
	[Deprecated (since = "vala-0.12", replacement = "Form.decode_multipart")]
	public static GLib.HashTable<string,string> form_decode_multipart (Soup.Message msg, string file_control_name, out string filename, out string content_type, out Soup.Buffer file);
	[Deprecated (since = "vala-0.12", replacement = "Form.encode")]
	public static string form_encode (...);
	[Deprecated (since = "vala-0.12", replacement = "Form.encode_datalist")]
	public static string form_encode_datalist (void* form_data_set);
	[Deprecated (since = "vala-0.12", replacement = "Form.encode_hash")]
	public static string form_encode_hash (GLib.HashTable<string,string> form_data_set);
	[Deprecated (since = "vala-0.12")]
	public static string form_encode_valist (string first_field, void* args);
	[Deprecated (since = "vala-0.12", replacement = "Form.request_new")]
	public static Soup.Message form_request_new (string method, string uri, ...);
	[Deprecated (since = "vala-0.12", replacement = "Form.request_new_from_datalist")]
	public static Soup.Message form_request_new_from_datalist (string method, string uri, void* form_data_set);
	[Deprecated (since = "vala-0.12", replacement = "Form.request_new_from_hash")]
	public static Soup.Message form_request_new_from_hash (string method, string uri, GLib.HashTable<string,string> form_data_set);
	[Deprecated (since = "vala-0.12", replacement = "Form.request_new_from_multipart")]
	public static Soup.Message form_request_new_from_multipart (string uri, Soup.Multipart multipart);
	[Deprecated (since = "vala-0.14", replacement = "SSLError.quark")]
	public static GLib.Quark ssl_error_quark ();
	public delegate void ProxyResolverCallback (Soup.ProxyResolver p1, Soup.Message p2, uint p3, Soup.Address p4);
}
