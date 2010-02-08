namespace Purple {
	[CCode (cheader_filename = "purple.h")]
	public static bool markup_find_tag (string needle, string haystack, out string start, out string end, out GLib.Datalist attributes);
}
