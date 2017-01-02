namespace Gtk {
	[CCode (cheader_filename = "gtk/gtkunixprint.h")]
	public abstract class PrintBackend : GLib.Object {
	}
	[CCode (cheader_filename = "gtk/gtkunixprint.h", instance_pos = 1.9)]
	public delegate void PrintJobCompleteFunc (Gtk.PrintJob print_job) throws GLib.Error;
}
