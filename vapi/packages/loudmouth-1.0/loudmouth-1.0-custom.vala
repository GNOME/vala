namespace Lm {
	[Compact]
	[CCode (ref_function = "lm_connection_ref", unref_function = "lm_connection_unref", cheader_filename = "loudmouth/loudmouth.h")]
	public class Connection {
		public const int DEFAULT_PORT;
		public const int DEFAULT_PORT_SSL;
		public Connection (string server);
	}

}
