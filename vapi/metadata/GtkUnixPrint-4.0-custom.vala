namespace Gtk {
	[CCode (cheader_filename = "gtk/gtkunixprint.h")]
	public class Printer : GLib.Object {
		[CCode (cname = "gtk_printer_accepts_pdf")]
		public bool get_accepts_pdf ();
		[CCode (cname = "gtk_printer_accepts_ps")]
		public bool get_accepts_ps ();
		[CCode (cname = "gtk_printer_is_virtual")]
		public bool get_is_virtual ();
		public Gtk.PrintBackend backend { get; construct; }
	}
	[CCode (cheader_filename = "gtk/gtkunixprint.h")]
	public abstract class PrintBackend : GLib.Object {
	}
	[CCode (cheader_filename = "gtk/gtkunixprint.h", instance_pos = 1.9)]
	public delegate void PrintJobCompleteFunc (Gtk.PrintJob print_job) throws GLib.Error;
}
