namespace Xkl {
	public class Engine : GLib.Object {
		// Prevent signal names from being converted to lower case.
		[CCode (cname = "X_config_changed")]
		public signal void X_config_changed ();
		[CCode (cname = "X_new_device")]
		public signal void X_new_device ();
		[CCode (cname = "X_state_changed")]
		public signal void X_state_changed (int type, int group, bool restore);
	}
}
