public errordomain Foo {
	BAR
}

class ClsA : Object {
	public ClsA () throws Error {
		throw new Foo.BAR ("Test");
	}
}

class ClsB: ClsA {
	public ClsB () throws Error {
		base ();

		assert_not_reached ();
	}
}

void main () {
	try {
		new ClsB ();
	} catch (Error e) {
		debug ("Propagated error");
	}
}
