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

	public Bar[] bars (int n) {
		Bar[] a = new Bar[n];
		for (int i = 0; i < n; i++) {
			a[i] = new Bar () { k = i };
		}
		return a;
	}

	public int[] seq (int n) {
		int[] a = new int[n];
		for (int i = 0; i < n; i++) {
			a[i] = i;
		}
		return a;
	}
}

void bar (Foo? f) {
	{
		// null method call
		Bar? b = f?.bar ();
		assert (b == null);
	}
	{
		// null element access
		int[]? a = null;
		int? i = a?[3];
		assert (i == null);
	}
	{
		// null slice expression
		int[]? a = null;
		int[]? s = a?[1:3];
		assert (s == null);
	}
}

void baz (Foo? f) {
	{
		// non-null element access
		int[]? a = f.seq (10);
		int? i = a?[3];
		assert (i == 3);
	}
	{
		// non-null slice access
		int[]? a = f.seq (10);
		int[]? s = a?[1:3];
		assert (s[0] == 1);
	}
	{
		// ownership transfer through member access
		Bar? b = (owned) f?.b;
		assert (b.k == 17);
	}
	{
		// ownership transfer through method call
		Bar? b = f?.bar ();
		assert (b.k == 17);
	}
	{
		// ownership transfer through element access
		Bar[]? a = f?.bars (10);
		Bar? b = (owned) a?[3];
		assert (b.k == 3);
	}
	{
		// member access to non-nullable unowned value type
		int? j = f?.j;
		assert (j == 23);
	}
	{
		// method call returns non-nullable unowned value type
		int? i = f?.foo ();
		assert (i == 42);
	}
}

void main () {
	{
		bar (null);
		baz (new Foo ());
	}
	{
		// owned inner expression
		int? i = new Foo ()?.i;
		assert (i == 42);
	}
}
