errordomain FooError {
	FAIL
}

class Manam : Object {
}

void foo (Manam i, out Manam o) throws FooError {
	o = i;
	throw new FooError.FAIL ("foo");
}

void bar (Manam i, out unowned Manam o) throws FooError {
	o = i;
	throw new FooError.FAIL ("bar");
}

void main () {
	{
		var manam = new Manam ();
		assert (manam.ref_count == 1);
		try {
			Manam minim;
			foo (manam, out minim);
		} catch (FooError e) {
		}
		assert (manam.ref_count == 1);
	}
	{
		var manam = new Manam ();
		assert (manam.ref_count == 1);
		try {
			unowned Manam minim;
			bar (manam, out minim);
		} catch (FooError e) {
		}
		assert (manam.ref_count == 1);
	}
}
