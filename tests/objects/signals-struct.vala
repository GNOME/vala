struct Foo {
	public string s;
	public int i;
}

struct Faz : Foo {
}

[CCode (has_type_id = false)]
struct Baz {
	public int i;
	public string s;
}

class Bar : Object {
	public signal void on_foo (Foo foo);
	public signal void on_faz (Faz faz);
	public signal void on_baz (Baz baz);
}

void main () {
	var bar = new Bar ();
	bar.on_foo.connect ((f) => {
		assert (f.s == "foo");
		assert (f.i == 23);
	});
	bar.on_foo ({ "foo", 23 });
	bar.on_faz.connect ((f) => {
		assert (f.s == "faz");
		assert (f.i == 42);
	});
	bar.on_faz ({ "faz", 42 });
	bar.on_baz.connect ((b) => {
		assert (b.i == 4711);
		assert (b.s == "baz");
	});
	bar.on_baz ({ 4711, "baz" });
}
