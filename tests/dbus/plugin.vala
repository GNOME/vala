[ModuleInit]
public GLib.Type init_plugin (TypeModule? m) {
	return typeof (Foo);
}

[DBus (name = "org.example.Test")]
public interface Foo : GLib.TypeModule {
	public void do_foo (Variant value) {
	}
}

void main () {
// https://bugzilla.gnome.org/show_bug.cgi?id=684282
#if GLIB_2_56
	var o = GLib.Object.new (init_plugin (null));
	assert (o is TypeModule);
	assert (o is Foo);
#endif
}
