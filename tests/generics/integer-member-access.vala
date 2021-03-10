class Foo<K,V> {
	public K k;
	public V v;
}

void main () {
	var foo = new Foo<int,uint> ();
	foo.k = int.MIN;
	foo.v = uint.MAX;
	assert (foo.k == int.MIN);
	assert (foo.v == uint.MAX);

	var bar = new Foo<int,uint> ();
	bar.k = foo.k;
	bar.v = foo.v;
	assert (bar.k == int.MIN);
	assert (bar.v == uint.MAX);
}
