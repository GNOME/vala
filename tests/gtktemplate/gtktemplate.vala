[GtkTemplate (ui = "/org/example/gtktemplate.ui")]
public class GtkTemplate : Gtk.ApplicationWindow {
	[GtkChild]
	public Gtk.Button button0 { get; set; }

	[GtkChild (internal = true)]
	public Gtk.Button button1;

	[GtkCallback]
	void on_clicked_cb (Gtk.Button button) {
	}

	[GtkCallback (name = "on_activate_cb")]
	void on_something_cb (Gtk.Button button) {
	}
}
