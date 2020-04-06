class Baz {
}

class Bar : Baz {
}

class Foo {
	public Baz baz { get; set; }
}

void main() {
	var foo = new Foo () {
		baz = new Bar ()
	};
}
