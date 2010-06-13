namespace Rest {
	[CCode (cheader_filename = "rest/rest-proxy.h")]
	public class Proxy : GLib.Object {
		public Rest.ProxyCall new_call ();
	}

	[CCode (cheader_filename = "rest/rest-proxy-call.h")]
	public class ProxyCall : GLib.Object {
	}
}

