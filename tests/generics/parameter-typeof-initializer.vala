class Foo<G> {
	public void foo (Type g = typeof (G)) {
		assert (g == typeof (string));
	}

	public void bar<T> (Type t = typeof (T)) {
		assert (t == typeof (Type));
	}
}

void bar<K> (Type k = typeof (K)) {
	assert (k == typeof (Foo));
}

void main () {
	{
		var foo = new Foo<string> ();
		foo.foo ();
		foo.bar (typeof (Type));
		foo.bar<Type> ();
	}
	{
		bar (typeof (Foo));
		bar<Foo> ();
	}
}
