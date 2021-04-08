[Compact]
class Foo {
	public string s = "foo";
	public int i = 42;
	public int j;

	public Foo () {
		assert (s == "foo");
		assert (i == 42);
		j = 23;
	}

	public Foo.bar () {
		this ();
		assert (s == "foo");
		assert (i == 42);
		assert (j == 23);
	}
}

void main () {
	{
		var foo = new Foo ();
		assert (foo.s == "foo");
		assert (foo.i == 42);
		assert (foo.j == 23);
	}
	{
		var foo = new Foo.bar ();
		assert (foo.s == "foo");
		assert (foo.i == 42);
		assert (foo.j == 23);
	}
}
