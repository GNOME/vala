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

	[Version (replacement = "Soup.ProxyURIResolver")]
	[CCode (cheader_filename = "libsoup/soup.h", type_cname = "SoupProxyResolverInterface", type_id = "soup_proxy_resolver_get_type ()")]
	public interface ProxyResolver : Soup.SessionFeature, GLib.Object {
		public abstract void get_proxy_async (Soup.Message msg, GLib.MainContext async_context, GLib.Cancellable? cancellable, Soup.ProxyResolverCallback callback);
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
	[Version (deprecated_since = "vala-0.22", replacement = "Status")]
	[CCode (cheader_filename = "libsoup/soup.h", cprefix = "SOUP_STATUS_", type_id = "soup_known_status_code_get_type ()")]
	public enum KnownStatusCode {
		NONE,
		CANCELLED,
		CANT_RESOLVE,
		CANT_RESOLVE_PROXY,
		CANT_CONNECT,
		CANT_CONNECT_PROXY,
		SSL_FAILED,
		IO_ERROR,
		MALFORMED,
		TRY_AGAIN,
		TOO_MANY_REDIRECTS,
		TLS_FAILED,
		CONTINUE,
		SWITCHING_PROTOCOLS,
		PROCESSING,
		OK,
		CREATED,
		ACCEPTED,
		NON_AUTHORITATIVE,
		NO_CONTENT,
		RESET_CONTENT,
		PARTIAL_CONTENT,
		MULTI_STATUS,
		MULTIPLE_CHOICES,
		MOVED_PERMANENTLY,
		FOUND,
		MOVED_TEMPORARILY,
		SEE_OTHER,
		NOT_MODIFIED,
		USE_PROXY,
		NOT_APPEARING_IN_THIS_PROTOCOL,
		TEMPORARY_REDIRECT,
		BAD_REQUEST,
		UNAUTHORIZED,
		PAYMENT_REQUIRED,
		FORBIDDEN,
		NOT_FOUND,
		METHOD_NOT_ALLOWED,
		NOT_ACCEPTABLE,
		PROXY_AUTHENTICATION_REQUIRED,
		PROXY_UNAUTHORIZED,
		REQUEST_TIMEOUT,
		CONFLICT,
		GONE,
		LENGTH_REQUIRED,
		PRECONDITION_FAILED,
		REQUEST_ENTITY_TOO_LARGE,
		REQUEST_URI_TOO_LONG,
		UNSUPPORTED_MEDIA_TYPE,
		REQUESTED_RANGE_NOT_SATISFIABLE,
		INVALID_RANGE,
		EXPECTATION_FAILED,
		UNPROCESSABLE_ENTITY,
		LOCKED,
		FAILED_DEPENDENCY,
		INTERNAL_SERVER_ERROR,
		NOT_IMPLEMENTED,
		BAD_GATEWAY,
		SERVICE_UNAVAILABLE,
		GATEWAY_TIMEOUT,
		HTTP_VERSION_NOT_SUPPORTED,
		INSUFFICIENT_STORAGE,
		NOT_EXTENDED
	}

	public delegate void ProxyResolverCallback (Soup.ProxyResolver p1, Soup.Message p2, uint p3, Soup.Address p4);
}
