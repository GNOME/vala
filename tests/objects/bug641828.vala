public interface Bar : GLib.Object {
	public signal int bar (int i);
}

public class Foo : GLib.Object, Bar {
}

void main () {
	var f = new Foo ();

	f.bar.connect (i => i + 12);

	var res = f.bar (30);
	assert (res == 42);
}
