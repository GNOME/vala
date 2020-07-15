class Foo {
	public int i = 42;

	public Foo? foo () {
		return null;
	}

	public void faz () {
		assert_not_reached ();
	}
}

void bar (Foo? f) {
	{
		int? j = f?.i;
		assert (j == null);
	}
	{
		int k = 23;
		k = f?.i ?? 0;
		assert (k == 0);
	}
}

void baz (Foo? f) {
	{
		int i = f?.i;
		assert (i == 42);
	}
	{
		int? j = 23;
		j = f?.foo ()?.i;
		assert (j == null);
	}
	{
		int k = 23;
		k = f?.foo ()?.i ?? 0;
		assert (k == 0);
	}
}

void main () {
	{
		Foo? foo = null;
		foo?.faz ();
	}
	{
		bar (null);
		baz (new Foo ());
	}
}
