errordomain FooError {
	BAD;
}

struct Bar {
	public int i;
}

class Foo : GLib.Object {
	signal void foo (void* p, Bar bar);
	signal void bar (void* p, Error e);
	signal void baz (void* p, FooError e);

	public Foo () {
		bar.connect (callback);
		bar (null, new FooError.BAD ("bad"));

		baz.connect (callback2);
		baz (null, new FooError.BAD ("bad"));
	}

	void callback (void* p, Error e) {
		assert (p == null);
		assert (e.code == FooError.BAD);
	}

	void callback2 (void* p, FooError e) {
		assert (p == null);
		assert (e.code == FooError.BAD);
	}
}

void main() {
	var foo = new Foo ();
}
