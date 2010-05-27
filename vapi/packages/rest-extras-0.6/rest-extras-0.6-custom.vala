namespace Rest {
	[CCode (cname="FacebookProxy", cheader_filename = "rest-extras/facebook-proxy.h")]
	public class FacebookProxy : Rest.Proxy {
	}
	[CCode (cname="FacebookProxyCall", cheader_filename = "rest-extras/facebook-proxy-call.h")]
	public class FacebookProxyCall : Rest.ProxyCall {
	}
	[CCode (cname="FlickrProxy", cheader_filename = "rest-extras/flickr-proxy.h")]
	public class FlickrProxy : Rest.Proxy {
	}
	[CCode (cname="FlickrProxyCall", cheader_filename = "rest-extras/flickr-proxy-call.h")]
	public class FlickrProxyCall : Rest.ProxyCall {
	}
}
