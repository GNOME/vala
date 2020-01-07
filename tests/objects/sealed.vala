sealed class Foo : GLib.Object {
	public void do_action () {
		stdout.printf (" 2");
	}
}

void main () {
	var foo = new Foo ();
}
