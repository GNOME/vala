namespace Rest {
	[CCode (cheader_filename = "rest/rest-proxy.h")]
	public class Proxy : GLib.Object {
		public Rest.ProxyCall new_call ();
	}
}

