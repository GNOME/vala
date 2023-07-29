
void main () {
	var b = new Baz<Bar> ();
	unowned Bar z = b.test ();
}

[Compact]
class Foo {
	public int l;
}

[Compact]
class Bar : Foo {
	public void t () {
	}
}

[CCode (no_generic_args=true)]
class Baz<J> : Object where J : Foo {
	J x;

	public unowned J test () {
		return this.x;
	}
}
