[GtkTemplate (ui = "/org/example/gtktemplate.ui")]
public class GtkTemplateTest : Gtk.ApplicationWindow {
	[GtkChild]
	public Gtk.Button button0 { get; }

	[GtkChild (internal = true)]
	public Gtk.Button button1;

	public bool boolean0 { get; set; }

	[GtkCallback]
	void on_clicked_cb (Gtk.Button button) {
	}

	[GtkCallback (name = "on_activate_cb")]
	void on_something_cb (Gtk.Button button) {
	}

	[GtkCallback]
	string on_enabled_cb (string s, int i, bool val) {
		return "%s:%i".printf (s, i);
	}
}
