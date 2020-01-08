
class Foo {
	public int i;

	public Foo (int i) {
		this.i = i;
	}

	public Foo? foo (int? i) {
		return i != null ? new Foo (i) : null;
	}

	public Bar? bar (int? i) {
		return i != null ? new Bar (i) : null;
	}

	public void faz () {
		assert_not_reached ();
	}

	public int[] seq (int n) {
		int[] arr = new int[n];
		for (int i = 0; i < n; i++) {
			arr[i] = i;
		}
		return arr;
	}
}

[Compact]
class Bar {
	public int i;

	public Bar (int i) {
		this.i = i;
	}
}

void bar (Foo? f) {
	{
		int? j = f?.i;
		assert (j == null);
	}
	{
		int k = 23;
		int d = 0;
		k = f?.i ?? d;
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
		j = f?.foo (null)?.i;
		assert (j == null);
	}
	{
		int k = 23;
		int d = 0;
		k = f?.foo (null)?.i ?? d;
		assert (k == 0);
	}
	{
		Bar? b = f?.bar (23);
		assert (b.i == 23);
	}
	{
		int? i = f.seq (10)?[3];
		assert (i == 3);
	}
}

void main () {
	{
		Foo? foo = null;
		foo?.faz ();
	}
	{
		bar (null);
		baz (new Foo (42));
	}
}
