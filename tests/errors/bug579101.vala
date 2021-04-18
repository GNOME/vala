errordomain FooError {
	FAIL
}

void do_foo (out int i) {
	i = 0;
	try {
		return;
	} finally {
		i = 42;
	}

	assert_not_reached ();
}

string do_bar (out int i) {
	string s = "bar";
	try {
		if (s == "bar") {
			return s;
		}
	} finally {
		i = 23;
	}

	assert_not_reached ();
}

string do_manam (out int i) {
	string s = "manam";
	try {
		throw new FooError.FAIL ("manam");
	} catch {
		if (s == "manam") {
			return s;
		}
	} finally {
		i = 4711;
	}

	assert_not_reached ();
}

void main () {
	{
		int i;
		do_foo (out i);
		assert (i == 42);
	}
	{
		int i;
		string s = do_bar (out i);
		assert (i == 23);
		assert (s == "bar");
	}
	{
		int i;
		string s = do_manam (out i);
		assert (i == 4711);
		assert (s == "manam");
	}
}
