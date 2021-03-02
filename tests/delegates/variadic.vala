[CCode (has_target = false)]
delegate void FooFunc (string first, ...);

[CCode (has_target = false)]
delegate void BarFunc (string first, ...);

errordomain BazError {
	BAD,
	WORSE
}

[CCode (has_target = false)]
delegate void BazFunc (string first, ...) throws BazError;

void foo (string first, ...) {
	assert (first == "foo");
	va_list args = va_list ();
	int i = args.arg<int> ();
	assert (i == 42);
	string s = args.arg<string> ();
	assert (s == "bar");
}

void baz (string first, ...) throws BazError {
	assert (first == "baz");
	va_list args = va_list ();
	int i = args.arg<int> ();
	assert (i == 23);
	string s = args.arg<string> ();
	assert (s == "bar");
}

void baz_fail (string first, ...) throws BazError {
	throw new BazError.BAD ("bad");
}

void mamam (FooFunc func) {
	func ("foo", 42, "bar");
}

void main () {
	{
		FooFunc func = foo;
		func ("foo", 42, "bar");
	}
	{
		FooFunc func = foo;
		BarFunc f = func;
	}
	{
		FooFunc func = (FooFunc) foo;
		BarFunc f = (BarFunc) func;
	}
	{
		BazFunc func = baz;
		func ("baz", 23, "bar");
	}
	{
		BazFunc func = baz_fail;
		try {
			func ("baz", 23, "bar");
			assert_not_reached ();
		} catch (BazError.BAD e) {
		} catch {
			assert_not_reached ();
		}
	}
	{
		mamam (foo);
	}
	{
		mamam ((FooFunc) foo);
	}
}
