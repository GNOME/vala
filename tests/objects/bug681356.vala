public class Foo : GLib.Object {
	[HasEmitter]
	public signal int bar (int i);
}

void main () {
	var f = new Foo ();

	f.bar.connect (i => i + 12);

	var res = f.bar (30);
	assert (res == 42);
}
