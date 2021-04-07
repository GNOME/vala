[Compact]
class Foo {
	public int i = 42;
	public int j = 23;

	public Foo () {
		assert (i == 42);
		j = 23;
	}

	public Foo.bar () {
		this ();
		assert (i == 42);
		assert (j == 23);
	}
}

void main () {
	{
		var foo = new Foo ();
		assert (foo.i == 42);
		assert (foo.j == 23);
	}
	{
		var foo = new Foo.bar ();
		assert (foo.i == 42);
		assert (foo.j == 23);
	}
}
