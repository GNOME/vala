bool foo (out string? s) {
	s = "foo";
	return true;
}

int bar () {
	return 42;
}

void main () {
	{
		string? s;
		if (!foo (out s) || s == null) {
			assert_not_reached ();
		}
	}
	{
		int i;
		if ((i = bar ()) > 42 || i < 23) {
			assert_not_reached ();
		}
	}
	{
		int i;
		if ((i = bar ()) > 42 && i < 23) {
			assert_not_reached ();
		}
	}

	{
		string? s;
		while (!foo (out s) || s == null) {
			assert_not_reached ();
		}
	}
	{
		int i;
		while ((i = bar ()) > 42 || i < 23) {
			assert_not_reached ();
		}
	}
	{
		int i;
		while ((i = bar ()) > 42 && i < 23) {
			assert_not_reached ();
		}
	}

	{
		string? s;
		assert (!foo (out s) || s == null ? false : true);
	}
	{
		string? s;
		assert (!foo (out s) && s == null ? false : true);
	}
	{
		int i;
		assert ((i = bar ()) > 42 || i < 23 ? false : true);
	}
	{
		int i;
		assert ((i = bar ()) > 42 && i < 23 ? false : true);
	}
}
