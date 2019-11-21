errordomain FooError {
	FAIL
}

class Foo {
	[Print]
	public void foo (string s) {
		assert (this != null);
		assert (s == "4711Footrue");
	}
}

[Print]
void foo (string s) {
	assert (s == "232.7182footrue");
}

[Print]
void bar (string s) throws Error {
	assert (s == "423.1415barfalse");
	throw new FooError.FAIL ("bar");
}

void main () {
	{
		foo (23, 2.7182f, "foo", true);
	}

	bool reached = false;
	try {
		bar (42, 3.1415f, "bar", false);
	} catch (FooError.FAIL e) {
		reached = true;
	} catch {
		assert_not_reached ();
	}
	assert (reached);

	{
		var f = new Foo ();
		f.foo (4711, "Foo", true);
	}
}
