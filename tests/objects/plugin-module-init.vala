public class Module : GLib.TypeModule {
	int private_field = 42;
}

[ModuleInit]
public GLib.Type init_plugin (TypeModule? m) {
	return typeof (Module);
}

void main () {
	var o = GLib.Object.new (init_plugin (null));
	assert (o is TypeModule);
	assert (o is Module);
}
