class Foo : Object {
	public string foo { get; private set; }

	protected Foo.pro () {
		foo = "foo.protected";
	}

	private Foo () {
		foo = "foo.private";
	}
}

class Bar : Foo {
	public Bar.pro () {
		base.pro ();
	}

	public Bar () {
		base ();
	}
}

class Manam : Bar {
	construct {
		bool b = true;
		if (b) {
			return;
		}
		assert_not_reached ();
	}
}

void main () {
	Bar bar;

	bar = new Bar ();
	assert (bar.foo == "foo.private");

	bar = new Bar.pro ();
	assert (bar.foo == "foo.protected");

	var manam = new Manam ();
	assert (manam.foo == "foo.private");
}
