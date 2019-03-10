enum Foo {
	FOO
}

[Flags]
enum Bar {
	BAR
}

class Manam : Object {
	public signal void foo (Foo f, string s);
	public signal void bar (Bar b, string s);
}

void main () {
	var manam = new Manam ();
	manam.foo.connect (() => {});
	manam.foo (Foo.FOO, "foo");
	manam.bar.connect (() => {});
	manam.bar (Bar.BAR, "bar");
}
