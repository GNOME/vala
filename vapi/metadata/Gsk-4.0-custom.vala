namespace Gsk {
	[CCode (cheader_filename = "gsk/gsk.h", error_pos = 2.8, instance_pos = 2.9)]
	public delegate void ParseErrorFunc (Gsk.ParseLocation start, Gsk.ParseLocation end) throws GLib.Error;
}
