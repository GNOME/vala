public class Module : GLib.TypeModule {
	int private_field = 42;
}

[ModuleInit]
public GLib.Type init_plugin (TypeModule? m) {
	return typeof (Module);
}

void main () {
// https://bugzilla.gnome.org/show_bug.cgi?id=684282
#if GLIB_2_56
	var o = GLib.Object.new (init_plugin (null));
	assert (o is TypeModule);
	assert (o is Module);
#endif
}
