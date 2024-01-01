namespace GLib {
	[Compact]
	[CCode (free_function = "g_module_close")]
	public class Module {
		[Version (deprecated = true, deprecated_since = "2.76")]
		public const string SUFFIX;
	}

	public enum ModuleFlags {
		[CCode (cname = "G_MODULE_BIND_LAZY")]
		[Version (deprecated = true, replacement = "LAZY", deprecated_since = "vala-0.46")]
		BIND_LAZY,
		[CCode (cname = "G_MODULE_BIND_LOCAL")]
		[Version (deprecated = true, replacement = "LOCAL", deprecated_since = "vala-0.46")]
		BIND_LOCAL,
		[CCode (cname = "G_MODULE_BIND_MASK")]
		[Version (deprecated = true, replacement = "MASK", deprecated_since = "vala-0.46")]
		BIND_MASK,
	}
}
