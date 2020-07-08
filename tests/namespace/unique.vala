namespace GLib {
	public class ValaFoo {
	}

	public int vala_foo () {
		return 42;
	}
}

[CCode (cname = "g_vala_foo", cheader_filename = "glib.h")]
extern int vala_foo ();

void main () {
	assert (vala_foo () == 42);
	assert (typeof (ValaFoo).name () == "GValaFoo");
}
