[CCode (cprefix = "Soup", lower_case_cprefix = "soup_")]
namespace Soup {
	[CCode (cprefix = "SOUP_ADDRESS_FAMILY_", cheader_filename = "libsoup/soup.h")]
	public enum AddressFamily {
		IPV4,
		IPV6,
	}
	[CCode (cprefix = "SOUP_AUTH_TYPE_", cheader_filename = "libsoup/soup.h")]
	public enum AuthType {
		BASIC,
		DIGEST,
	}
	[CCode (cprefix = "SOUP_ALGORITHM_", cheader_filename = "libsoup/soup.h")]
	public enum DigestAlgorithm {
		MD5,
		MD5_SESS,
	}
	[CCode (cprefix = "SOUP_HANDLER_", cheader_filename = "libsoup/soup.h")]
	public enum HandlerPhase {
		POST_REQUEST,
		PRE_BODY,
		BODY_CHUNK,
		POST_BODY,
	}
	[CCode (cprefix = "SOUP_HTTP_", cheader_filename = "libsoup/soup.h")]
	public enum HttpVersion {
		1_0,
		1_1,
	}
	[CCode (cprefix = "SOUP_STATUS_", cheader_filename = "libsoup/soup.h")]
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
		NOT_EXTENDED,
	}
	[CCode (cprefix = "SOUP_MESSAGE_", cheader_filename = "libsoup/soup.h")]
	public enum MessageFlags {
		NO_REDIRECT,
		OVERWRITE_CHUNKS,
		EXPECT_CONTINUE,
	}
	[CCode (cprefix = "SOUP_MESSAGE_STATUS_", cheader_filename = "libsoup/soup.h")]
	public enum MessageStatus {
		IDLE,
		QUEUED,
		CONNECTING,
		RUNNING,
		FINISHED,
	}
	[CCode (cprefix = "SOUP_METHOD_ID_", cheader_filename = "libsoup/soup.h")]
	public enum MethodId {
		UNKNOWN,
		POST,
		GET,
		HEAD,
		OPTIONS,
		PUT,
		MOVE,
		COPY,
		DELETE,
		TRACE,
		CONNECT,
		MKCOL,
		PROPPATCH,
		PROPFIND,
		PATCH,
		LOCK,
		UNLOCK,
	}
	[CCode (cprefix = "SOUP_BUFFER_", cheader_filename = "libsoup/soup.h")]
	public enum Ownership {
		SYSTEM_OWNED,
		USER_OWNED,
		STATIC,
	}
	[CCode (cprefix = "SOUP_SSL_TYPE_", cheader_filename = "libsoup/soup.h")]
	public enum SSLType {
		CLIENT,
		SERVER,
	}
	[CCode (cprefix = "SOUP_SSL_ERROR_", cheader_filename = "libsoup/soup.h")]
	public enum SocketError {
		HANDSHAKE_NEEDS_READ,
		HANDSHAKE_NEEDS_WRITE,
		CERTIFICATE,
	}
	[CCode (cprefix = "SOUP_SOCKET_", cheader_filename = "libsoup/soup.h")]
	public enum SocketIOStatus {
		OK,
		WOULD_BLOCK,
		EOF,
		ERROR,
	}
	[CCode (cprefix = "SOUP_STATUS_CLASS_", cheader_filename = "libsoup/soup.h")]
	public enum StatusClass {
		TRANSPORT_ERROR,
		INFORMATIONAL,
		SUCCESS,
		REDIRECT,
		CLIENT_ERROR,
		SERVER_ERROR,
	}
	[CCode (cprefix = "SOUP_TRANSFER_", cheader_filename = "libsoup/soup.h")]
	public enum TransferEncoding {
		UNKNOWN,
		CHUNKED,
		CONTENT_LENGTH,
		BYTERANGES,
		NONE,
		EOF,
	}
	[CCode (cprefix = "SOUP_XMLRPC_VALUE_TYPE_", cheader_filename = "libsoup/soup.h")]
	public enum XmlrpcValueType {
		BAD,
		INT,
		BOOLEAN,
		STRING,
		DOUBLE,
		DATETIME,
		BASE64,
		STRUCT,
		ARRAY,
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public class Address : GLib.Object {
		public weak string get_name ();
		public weak string get_physical ();
		public uint get_port ();
		public static GLib.Type get_type ();
		public Address (string name, uint port);
		public Address.any (Soup.AddressFamily family, uint port);
		public void resolve_async (Soup.AddressCallback callback, pointer user_data);
		public void resolve_async_full (GLib.MainContext async_context, Soup.AddressCallback callback, pointer user_data);
		public uint resolve_sync ();
		public signal void dns_result (uint status);
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public class Auth : GLib.Object {
		public void authenticate (string username, string password);
		public static GLib.Type basic_get_type ();
		public void free_protection_space (GLib.SList space);
		public weak string get_authorization (Soup.Message msg);
		public weak GLib.SList get_protection_space (Soup.Uri source_uri);
		public weak string get_realm ();
		public weak string get_scheme_name ();
		public static GLib.Type get_type ();
		public virtual bool is_authenticated ();
		public Auth.from_header_list (GLib.SList vals);
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public class AuthDigest : Soup.Auth {
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public class Connection : GLib.Object {
		public void authenticate (Soup.Message msg, string auth_type, string auth_realm, out string username, out string password);
		public void connect_async (Soup.ConnectionCallback callback, pointer user_data);
		public uint connect_sync ();
		public void disconnect ();
		public static GLib.Type get_type ();
		public bool is_in_use ();
		public ulong last_used ();
		public Connection (string propname1);
		public void reauthenticate (Soup.Message msg, string auth_type, string auth_realm, out string username, out string password);
		public void release ();
		public void reserve ();
		public virtual void send_request (Soup.Message req);
		[NoAccessorMethod]
		public weak pointer origin_uri { get; construct; }
		[NoAccessorMethod]
		public weak pointer proxy_uri { get; construct; }
		[NoAccessorMethod]
		public weak pointer ssl_creds { get; construct; }
		[NoAccessorMethod]
		public weak pointer message_filter { get; set; }
		[NoAccessorMethod]
		public weak pointer async_context { get; construct; }
		[NoAccessorMethod]
		public weak uint timeout { get; set; }
		public signal void connect_result (uint arg2);
		public signal void disconnected ();
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public class ConnectionNTLM : Soup.Connection {
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public class Message : GLib.Object {
		public weak string method;
		public uint status_code;
		public weak string reason_phrase;
		public weak Soup.DataBuffer request;
		public weak GLib.HashTable request_headers;
		public weak Soup.DataBuffer response;
		public weak GLib.HashTable response_headers;
		public Soup.MessageStatus status;
		public void add_chunk (Soup.Ownership owner, string body, uint length);
		public void add_final_chunk ();
		public void add_handler (Soup.HandlerPhase phase, Soup.MessageCallbackFn handler_cb, pointer user_data);
		public static void add_header (GLib.HashTable hash, string name, string value);
		public void add_header_handler (string header, Soup.HandlerPhase phase, Soup.MessageCallbackFn handler_cb, pointer user_data);
		public void add_status_class_handler (pointer status_class, Soup.HandlerPhase phase, Soup.MessageCallbackFn handler_cb, pointer user_data);
		public void add_status_code_handler (uint status_code, Soup.HandlerPhase phase, Soup.MessageCallbackFn handler_cb, pointer user_data);
		public static void clear_headers (GLib.HashTable hash);
		public uint get_flags ();
		public static weak string get_header (GLib.HashTable hash, string name);
		public static weak GLib.SList get_header_list (GLib.HashTable hash, string name);
		public Soup.HttpVersion get_http_version ();
		public Soup.TransferEncoding get_request_encoding (uint content_length);
		public Soup.TransferEncoding get_response_encoding (uint content_length);
		public static GLib.Type get_type ();
		public weak Soup.Uri get_uri ();
		public bool io_in_progress ();
		public void io_pause ();
		public void io_stop ();
		public void io_unpause ();
		public bool is_keepalive ();
		public Message (string method, string uri_string);
		public Message.from_uri (string method, Soup.Uri uri);
		public weak Soup.DataBuffer pop_chunk ();
		public void read_request (Soup.Socket sock);
		public void remove_handler (Soup.HandlerPhase phase, Soup.MessageCallbackFn handler_cb, pointer user_data);
		public static void remove_header (GLib.HashTable hash, string name);
		public void send_request (Soup.Socket sock, bool is_via_proxy);
		public void set_flags (uint flags);
		public void set_http_version (Soup.HttpVersion version);
		public void set_request (string content_type, Soup.Ownership req_owner, string req_body, ulong req_length);
		public void set_response (string content_type, Soup.Ownership resp_owner, string resp_body, ulong resp_length);
		public void set_status (uint status_code);
		public void set_status_full (uint status_code, string reason_phrase);
		public void set_uri (Soup.Uri uri);
		[HasEmitter]
		public signal void wrote_informational ();
		[HasEmitter]
		public signal void wrote_headers ();
		[HasEmitter]
		public signal void wrote_chunk ();
		[HasEmitter]
		public signal void wrote_body ();
		[HasEmitter]
		public signal void got_informational ();
		[HasEmitter]
		public signal void got_headers ();
		[HasEmitter]
		public signal void got_chunk ();
		[HasEmitter]
		public signal void got_body ();
		[HasEmitter]
		public signal void restarted ();
		[HasEmitter]
		public signal void finished ();
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public class Server : GLib.Object {
		public void add_handler (string path, Soup.ServerAuthContext auth_ctx, Soup.ServerCallbackFn callback, Soup.ServerUnregisterFn unreg, pointer data);
		public static bool auth_check_passwd (Soup.ServerAuth auth, string passwd);
		public static void auth_free (Soup.ServerAuth auth);
		public static weak string auth_get_user (Soup.ServerAuth auth);
		public static weak Soup.ServerAuth auth_new (Soup.ServerAuthContext auth_ctx, GLib.SList auth_hdrs, Soup.Message msg);
		public weak Soup.ServerHandler get_handler (string path);
		public weak Soup.Socket get_listener ();
		public uint get_port ();
		public GLib.Quark get_protocol ();
		public static GLib.Type get_type ();
		public weak GLib.SList list_handlers ();
		public Server (string optname1, ...);
		public void quit ();
		public void remove_handler (string path);
		public void run ();
		public void run_async ();
		[NoAccessorMethod]
		public weak uint port { get; construct; }
		[NoAccessorMethod]
		public weak Soup.Address @interface { get; construct; }
		[NoAccessorMethod]
		public weak string ssl_cert_file { get; construct; }
		[NoAccessorMethod]
		public weak string ssl_key_file { get; construct; }
		[NoAccessorMethod]
		public weak pointer async_context { get; construct; }
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public class ServerMessage : Soup.Message {
		public void finish ();
		public Soup.TransferEncoding get_encoding ();
		public weak Soup.Server get_server ();
		public static GLib.Type get_type ();
		public bool is_finished ();
		public bool is_started ();
		public ServerMessage (Soup.Server server);
		public void set_encoding (Soup.TransferEncoding encoding);
		public void start ();
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public class Session : GLib.Object {
		public void abort ();
		public void add_filter (Soup.MessageFilter filter);
		public virtual void cancel_message (Soup.Message msg);
		public weak Soup.Connection get_connection (Soup.Message msg, bool try_pruning, bool is_new);
		public static GLib.Type get_type ();
		public void queue_message (Soup.Message msg, Soup.MessageCallbackFn callback, pointer user_data);
		public void remove_filter (Soup.MessageFilter filter);
		public virtual void requeue_message (Soup.Message msg);
		public virtual uint send_message (Soup.Message msg);
		public bool try_prune_connection ();
		[NoAccessorMethod]
		public weak pointer proxy_uri { get; set; }
		[NoAccessorMethod]
		public weak int max_conns { get; set; }
		[NoAccessorMethod]
		public weak int max_conns_per_host { get; set; }
		[NoAccessorMethod]
		public weak bool use_ntlm { get; set; }
		[NoAccessorMethod]
		public weak string ssl_ca_file { get; set; }
		[NoAccessorMethod]
		public weak pointer async_context { get; construct; }
		[NoAccessorMethod]
		public weak uint timeout { get; set; }
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public class SessionAsync : Soup.Session {
		public static GLib.Type get_type ();
		public SessionAsync ();
		public SessionAsync.with_options (string optname1);
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public class SessionSync : Soup.Session {
		public static GLib.Type get_type ();
		public SessionSync ();
		public SessionSync.with_options (string optname1);
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public class Socket : GLib.Object {
		public static weak Soup.Socket client_new_async (string hostname, uint port, pointer ssl_creds, Soup.SocketCallback callback, pointer user_data);
		public static weak Soup.Socket client_new_sync (string hostname, uint port, pointer ssl_creds, uint status_ret);
		public uint connect (Soup.Address remote_addr);
		public void disconnect ();
		public weak Soup.Address get_local_address ();
		public weak Soup.Address get_remote_address ();
		public static GLib.Type get_type ();
		public bool is_connected ();
		public bool listen (Soup.Address local_addr);
		public Socket (string optname1);
		public Soup.SocketIOStatus read (pointer buffer, ulong len, ulong nread);
		public Soup.SocketIOStatus read_until (pointer buffer, ulong len, pointer boundary, ulong boundary_len, ulong nread, bool got_boundary);
		public static weak Soup.Socket server_new (Soup.Address local_addr, pointer ssl_creds, Soup.SocketListenerCallback callback, pointer user_data);
		public bool start_proxy_ssl (string ssl_host);
		public bool start_ssl ();
		public Soup.SocketIOStatus write (pointer buffer, ulong len, ulong nwrote);
		[NoAccessorMethod]
		public weak bool non_blocking { get; set; }
		[NoAccessorMethod]
		public weak bool nodelay { get; set; }
		[NoAccessorMethod]
		public weak bool reuseaddr { get; set; }
		[NoAccessorMethod]
		public weak bool cloexec { get; set; }
		[NoAccessorMethod]
		public weak bool is_server { get; }
		[NoAccessorMethod]
		public weak pointer ssl_creds { get; set; }
		[NoAccessorMethod]
		public weak pointer async_context { get; construct; }
		[NoAccessorMethod]
		public weak uint timeout { get; set; }
		public signal void connect_result (uint arg2);
		public signal void readable ();
		public signal void writable ();
		public signal void disconnected ();
		public signal void new_connection (Soup.Socket arg2);
	}
	[CCode (cheader_filename = "libsoup/soup.h")]
	public interface MessageFilter {
		public static GLib.Type get_type ();
		public abstract void setup_message (Soup.Message msg);
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct ServerAuth {
		public ServerAuth (Soup.ServerAuthContext auth_ctx, GLib.SList auth_hdrs, Soup.Message msg);
		public weak string get_user ();
		public bool check_passwd (string passwd);
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct AuthBasicClass {
		public pointer parent_class;
	}
	[ReferenceType (free_function = "soup_dns_lookup_free")]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct DNSLookup {
		public void cancel ();
		public weak string get_hostname ();
		public static weak Soup.DNSLookup name (string name);
		public bool resolve ();
		public void resolve_async (GLib.MainContext async_context, Soup.DNSCallback callback, pointer user_data);
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct DataBuffer {
		public Soup.Ownership owner;
		public weak string body;
		public uint length;
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct MD5Context {
		public uint buf;
		public uint bits;
		public uchar @in;
		public bool doByteReverse;
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct MessageQueue {
		public void append (Soup.Message msg);
		public void destroy ();
		public weak Soup.Message first (Soup.MessageQueueIter iter);
		public void free_iter (Soup.MessageQueueIter iter);
		public MessageQueue ();
		public weak Soup.Message next (Soup.MessageQueueIter iter);
		public weak Soup.Message remove (Soup.MessageQueueIter iter);
		public void remove_message (Soup.Message msg);
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct MessageQueueIter {
		public weak GLib.List cur;
		public weak GLib.List next;
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct ServerAuthBasic {
		public Soup.AuthType type;
		public weak string user;
		public weak string passwd;
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct ServerAuthContext {
		public uint types;
		public Soup.ServerAuthCallbackFn callback;
		public pointer user_data;
		public uint allow_algorithms;
		public bool force_integrity;
		public void challenge (Soup.Message msg, string header_name);
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct ServerAuthDigest {
		public Soup.AuthType type;
		public Soup.DigestAlgorithm algorithm;
		public bool integrity;
		public weak string realm;
		public weak string user;
		public weak string nonce;
		public int nonce_count;
		public weak string cnonce;
		public weak string digest_uri;
		public weak string digest_response;
		public weak string request_method;
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct ServerContext {
		public weak Soup.Message msg;
		public weak string path;
		public Soup.MethodId method_id;
		public weak Soup.ServerAuth auth;
		public weak Soup.Server server;
		public weak Soup.ServerHandler handler;
		public weak Soup.Socket sock;
		public weak Soup.Address get_client_address ();
		public weak string get_client_host ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct ServerHandler {
		public weak string path;
		public weak Soup.ServerAuthContext auth_ctx;
		public Soup.ServerCallbackFn callback;
		public Soup.ServerUnregisterFn unregister;
		public pointer user_data;
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct Uri {
		public GLib.Quark protocol;
		public weak string user;
		public weak string passwd;
		public weak string host;
		public uint port;
		public weak string path;
		public weak string query;
		public weak string fragment;
		public bool broken_encoding;
		public weak Soup.Uri copy ();
		public weak Soup.Uri copy_root ();
		public static void decode (string part);
		public static weak string encode (string part, string escape_extra);
		public bool equal (Soup.Uri uri2);
		public Uri (string uri_string);
		public Uri.with_base (string uri_string);
		public weak string to_string (bool just_path);
		public bool uses_default_port ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct Date {
		public static weak string generate (ulong when);
		public static ulong iso8601_parse (string timestamp);
		public static ulong parse (string timestamp);
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct Dns {
		public static void init ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct Header {
		public static weak string param_copy_token (GLib.HashTable tokens, string t);
		public static weak string param_decode_token (out string @in);
		public static void param_destroy_hash (GLib.HashTable table);
		public static weak GLib.HashTable param_parse_list (string header);
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct Headers {
		public static bool parse_request (string str, int len, GLib.HashTable dest, out string req_method, out string req_path, Soup.HttpVersion ver);
		public static bool parse_response (string str, int len, GLib.HashTable dest, Soup.HttpVersion ver, uint status_code, out string reason_phrase);
		public static bool parse_status_line (string status_line, Soup.HttpVersion ver, uint status_code, out string reason_phrase);
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct Ssl {
		public static GLib.Quark error_quark ();
		public static void free_client_credentials (pointer creds);
		public static void free_server_credentials (pointer creds);
		public static pointer get_client_credentials (string ca_file);
		public static pointer get_server_credentials (string cert_file, string key_file);
		public static weak GLib.IOChannel wrap_iochannel (GLib.IOChannel sock, Soup.SSLType type, string remote_host, pointer credentials);
	}
	[ReferenceType]
	[CCode (cheader_filename = "libsoup/soup.h")]
	public struct Str {
		public static bool case_equal (pointer v1, pointer v2);
		public static uint case_hash (pointer key);
	}
	public static delegate void AddressCallback (Soup.Address addr, uint status, pointer data);
	public static delegate void ConnectionCallback (Soup.Connection conn, uint status, pointer data);
	public static delegate void DNSCallback (Soup.DNSLookup lookup, bool success, pointer user_data);
	public static delegate void MessageCallbackFn (Soup.Message req, pointer user_data);
	public static delegate bool ServerAuthCallbackFn (Soup.ServerAuthContext auth_ctx, Soup.ServerAuth auth, Soup.Message msg, pointer data);
	public static delegate void ServerCallbackFn (Soup.ServerContext context, Soup.Message msg, pointer user_data);
	public static delegate void ServerUnregisterFn (Soup.Server server, Soup.ServerHandler handler, pointer user_data);
	public static delegate void SocketCallback (Soup.Socket sock, uint status, pointer user_data);
	public static delegate void SocketListenerCallback (Soup.Socket listener, Soup.Socket sock, pointer user_data);
	public static weak GLib.Source add_idle (GLib.MainContext async_context, GLib.SourceFunc function, pointer data);
	public static weak GLib.Source add_timeout (GLib.MainContext async_context, uint interval, GLib.SourceFunc function, pointer data);
	public static Soup.MethodId method_get_id (string method);
	public static uint signal_connect_once (pointer instance, string detailed_signal, GLib.Callback c_handler, pointer data);
	public static weak string status_get_phrase (uint status_code);
}
