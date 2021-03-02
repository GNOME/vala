errordomain FooError {
	BAD,
	WORSE
}

void foo (params string[] array) throws FooError {
	assert (array.length == 3);
	assert (array[0] == "foo");
	assert (array[1] == "bar");
	assert (array[2] == "manam");
}

void bar (params string[] array) throws FooError {
	throw new FooError.BAD ("bad");
}

class Foo {
	public void foo (params string[] array) throws FooError {
		assert (array.length == 3);
		assert (array[0] == "foo");
		assert (array[1] == "bar");
		assert (array[2] == "manam");
	}

	public void bar (params string[] array) throws FooError {
		throw new FooError.BAD ("bad");
	}
}

void main () {
	{
		foo ("foo", "bar", "manam");
	}
	{
		try {
			bar ("foo", "bar", "manam");
			assert_not_reached ();
		} catch (FooError.BAD e) {
		} catch {
			assert_not_reached ();
		}
	}
	{
		var foo = new Foo ();
		foo.foo ("foo", "bar", "manam");
	}
	{
		try {
			var foo = new Foo ();
			foo.bar ("foo", "bar", "manam");
			assert_not_reached ();
		} catch (FooError.BAD e) {
		} catch {
			assert_not_reached ();
		}
	}
}
