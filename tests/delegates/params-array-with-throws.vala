errordomain FooError {
	BAD,
	WORSE
}

[CCode (has_target = false)]
delegate void FooFunc (params string[] array) throws FooError;

void foo (params string[] array) throws FooError {
	assert (array.length == 3);
	assert (array[0] == "foo");
	assert (array[1] == "bar");
	assert (array[2] == "manam");
}

void bar (params string[] array) throws FooError {
	throw new FooError.BAD ("bad");
}

void main () {
	{
		FooFunc func = foo;
		func ("foo", "bar", "manam");
	}
	{
		FooFunc func = bar;
		try {
			func ("foo", "bar", "manam");
			assert_not_reached ();
		} catch (FooError.BAD e) {
		} catch {
			assert_not_reached ();
		}
	}
}
