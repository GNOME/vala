namespace GtkClutter {
	public errordomain TextureError {
		[Deprecated (since = "vala-0.16", replacement = "INVALID_STOCK_ID")]
		[CCode (cname = "GTK_CLUTTER_TEXTURE_ERROR_INVALID_STOCK_ID")]
		ID
	}

	public const int CLUTTER_GTK_MAJOR_VERSION;
	public const int CLUTTER_GTK_MICRO_VERSION;
	public const int CLUTTER_GTK_MINOR_VERSION;
	public const int CLUTTER_GTK_VERSION_HEX;
	public const string CLUTTER_GTK_VERSION_S;
	public static bool check_version (uint major, uint minor, uint micro);
}