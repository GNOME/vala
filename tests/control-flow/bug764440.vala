errordomain FooError {
	BAR;
}

unowned string get_bar () throws FooError {
	throw new FooError.BAR ("bar");
}

void main () {
	try {
		unowned string? foo = "foo";
		unowned string bar = foo ?? get_bar ();
	} catch {
		assert_not_reached ();
	}
}
