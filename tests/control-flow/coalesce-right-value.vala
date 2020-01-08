struct Foo {
	public int n;
}

void main () {
	{
		int? nn = null;
		int? n = nn ?? 42;
		assert (n == 42);
	}
	{
		Foo df = { 42 };
		Foo? nf = null;
		Foo f = nf ?? df;
		assert (f.n == 42);
	}
}
