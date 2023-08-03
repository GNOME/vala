[Compact]
class Foo {
	public int i;
}

[Compact]
class Bar : Foo {
}

[CCode (no_generic_args = true)]
class Baz<G> : Object where G : Foo {
	G g;

	public unowned G foo () {
		return g;
	}
}

void main () {
	var baz = new Baz<Bar> ();
	unowned Bar bar = baz.foo ();
}
