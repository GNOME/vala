class Foo {
	public bool bar;

	public Foo (bool b) {
		bar = b;
	}
}

void main () {
	{
		Foo? foo = null;
		if (foo?.bar ?? true) {
		} else {
			assert_not_reached ();
		}
	}
	{
		Foo? foo = null;
		if (foo?.bar ?? false) {
			assert_not_reached ();
		} else {
		}
	}
	{
		Foo? foo = new Foo (true);
		if (foo?.bar ?? false) {
		} else {
			assert_not_reached ();
		}
	}
	{
		Foo? foo = new Foo (false);
		if (foo?.bar ?? true) {
			assert_not_reached ();
		} else {
		}
	}
}
