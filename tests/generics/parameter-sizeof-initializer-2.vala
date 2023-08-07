class Foo<G> {
	public void foo (ulong size = sizeof (G)) {
		assert (size == sizeof (uchar));
		assert (typeof (G) == Type.UCHAR);
	}

	public void bar<T> (ulong size = sizeof (T)) {
		assert (size == sizeof (string));
		assert (typeof (T) == Type.STRING);
	}
}

void bar<K> (ulong size = sizeof (K)) {
	assert (size == sizeof (int));
	assert (typeof (K) == Type.INT);
}

void main () {
	{
		var foo = new Foo<uchar> ();
		foo.foo ();
		foo.bar (sizeof (string));
		foo.bar<string> ();
	}
	{
		bar (sizeof (int));
		bar<int> ();
	}
}
