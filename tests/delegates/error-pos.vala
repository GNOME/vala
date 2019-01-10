errordomain FooError {
	BAR;
}

[CCode (error_pos = 1.8, instance_pos = 1.9)]
delegate string FooFunc (int i) throws FooError;

class Bar {
	[CCode (error_pos = 0.8)]
	public string foo (int i) throws FooError {
		assert (this is Bar);
		return "%i".printf (i);
	}

	[CCode (error_pos = 0.8)]
	public string faz (int i) throws FooError {
		assert (this is Bar);
		throw new FooError.BAR ("%i".printf (i));
	}
}

void foo (FooFunc f) {
	try {
		assert (f (23) == "23");
	} catch {
		assert_not_reached ();
	}
}

void main () {
	try {
		var bar = new Bar ();
		assert (bar.foo (42) == "42");
		foo (bar.foo);
	} catch {
		assert_not_reached ();
	}

	try {
		var bar = new Bar ();
		bar.faz (42);
	} catch (FooError.BAR e) {
		assert (e.message == "42");
	} catch {
		assert_not_reached ();
	}
}
