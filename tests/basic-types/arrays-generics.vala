class Baz : Object {
	public Baz () {
	}

	Baz get_object ()
	{
		return new Baz ();
	}

	public Baz[] create_array () {
		var a = get_array<Baz> ();
		a += (Baz) get_object ();
		assert (a.length == 2);
		assert (!(get_object () in a));
		return a;
	}

	public V[] create_array2<V> () {
		var a = get_array2<V> ();
		a += (V) get_object ();
		assert (a.length == 3);
		assert (!(get_object () in a));
		return a;
	}

	T[] get_array<T> () {
		T[] a = {};
		a += (T) get_object ();
		return a;
	}

	G[] get_array2<G> () {
		G[] a = {};
		a += (G) get_object ();
		a += (G) get_object ();
		return a;
	}
}

void test_generics_array () {
	var g = new Baz ();
	var a = g.create_array ();
	assert (a.length == 2);
	var b = g.create_array2<Baz> ();
	assert (b.length == 3);
}

void main () {
	test_generics_array ();
}
