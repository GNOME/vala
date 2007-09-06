[CCode (cprefix = "G")]
namespace GNet {
	public class NetTOS  {}
	public class InetAddrGetNameAsyncID {}
	public class InetAddrNewAsyncID {}
	public class InetAddrNewListAsyncID {}
	public class TcpSocketConnectAsyncID {}
	public class TcpSocketNewAsyncID {}

	/* Deprecated glib API */
	public enum IOError {
  		NONE,
  		AGAIN,
	        INVAL,
	        UNKNOWN
	}
}
