void bar () throws Error {
}

class Foo : Object {
	public Foo () throws Error {
		bar ();
	}

	construct {
		bar ();
	}

	class construct {
		bar ();
	}

	static construct {
		bar ();
	}
}

void main () {
	var foo = new Foo ();
}
