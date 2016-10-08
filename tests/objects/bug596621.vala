delegate void Func ();

class Foo : Object {
	[CCode (has_construct_function = false)]
	public Foo () {
	}
}

class Bar : Foo {
	public Bar () {
		Func baz;
	}
}

void main () {
}

