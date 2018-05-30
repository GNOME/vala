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

	public delegate void ProxyResolverCallback (Soup.ProxyResolver p1, Soup.Message p2, uint p3, Soup.Address p4);
}
