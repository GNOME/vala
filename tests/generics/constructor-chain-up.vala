class Foo<G> : Object {
	public Foo () {
	}

	public Foo.bar () {
		this ();
	}
}

void main () {
	var foo = new Foo<string>.bar ();
}
