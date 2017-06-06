public class Foo : Object {
	[CCode (cname = "baz")]
	public signal void foo ();
	[CCode (cname = "baz-bar")]
	public signal void foo_bar ();
	[CCode (cname = "baz-virt")]
	public virtual signal void foo_virt () {
		callback ();
	}
}

int baz = 0;

void callback () {
	baz++;
}

void main () {
	var foo = new Foo ();
	foo.foo.connect (callback);
	foo.foo_bar.connect (callback);

	foo.foo ();
	assert (baz == 1);
	foo.foo_bar ();
	assert (baz == 2);
	foo.foo_virt ();
	assert (baz == 3);

	Signal.emit_by_name (foo, "baz");
	assert (baz == 4);
	Signal.emit_by_name (foo, "baz-bar");
	assert (baz == 5);
	Signal.emit_by_name (foo, "baz-virt");
	assert (baz == 6);
}
