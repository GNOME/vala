[Compact]
class Bar {
	public int k = 17;
}

class Foo {
	public int i = 42;

	public int j { get ; set ; default = 23; }

	public Bar b = new Bar ();

	public unowned int foo () {
		return i;
	}

	public Bar bar () {
		return new Bar ();
	}

	public int baz (int i) {
		return i;
	}
}

void main () {
	{
		// owned inner expression
		int? i = new Foo ()?.i;
		assert (i == 42);
	}
	{
		// ownership transfer through member access
		Foo? f = new Foo ();
		Bar? b = (owned) f?.b;
		assert (b.k == 17);
	}
	{
		// ownership transfer through method call
		Foo? f = new Foo ();
		Bar? b = f?.bar ();
		assert (b.k == 17);
	}
	{
		// member access to non-nullable unowned value type
		Foo? f = new Foo ();
		int? j = f?.j;
		assert (j == 23);
	}
	{
		// method call returning non-nullable unowned value type
		Foo? f = new Foo ();
		int? i = f?.foo ();
		assert (i == 42);
	}
	{
		// method arguments must be passed along
		Foo? f = new Foo ();
		int? i = f?.baz (17);
		assert (i == 17);
	}
}
