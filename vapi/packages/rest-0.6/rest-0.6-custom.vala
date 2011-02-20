namespace Rest {
	[CCode (cheader_filename = "rest/rest-proxy.h")]
	public class Proxy {
		public Rest.ProxyCall new_call ();
	}

	[CCode (cname = "OAuthProxy", cheader_filename = "rest/oauth-proxy.h")]
	public class OAuthProxy {
	}
}

