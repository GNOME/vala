class Bar : Object {
	public Bar (Type type) {
		assert (type == typeof (string));
	}
}

class Foo<G> : Bar {
	public Foo () {
		base (typeof (G));
	}
}

void main () {
	var foo = new Foo<string> ();
}
