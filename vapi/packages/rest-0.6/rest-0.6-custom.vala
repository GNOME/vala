namespace Rest {
	[CCode (cheader_filename = "rest/rest-proxy.h")]
	public class Proxy : GLib.Object {
		public Rest.ProxyCall new_call ();
	}

	[CCode (cheader_filename = "rest/rest-proxy-call.h")]
	public class ProxyCall : GLib.Object {
	}

	[CCode (cheader_filename = "rest/rest-xml-parser.h")]
	public class XmlParser : GLib.Object {
	}

	[CCode (cheader_filename = "rest/oauth-proxy.h")]
		public class OAuthProxy : Rest.Proxy {
		}
}

