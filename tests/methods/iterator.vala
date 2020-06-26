class Foo {
}

class FooIterator {
	bool called = false;

	public bool next () {
		return !called;
	}

	public Foo @get () {
		assert (!called);
		called = true;
		return foo_instance;
	}
}

class FooCollection {
	public FooIterator iterator () {
		return new FooIterator ();
	}
}

class FooIterator2 {
	bool called = false;

	public Foo? next_value () {
		if (called)
			return null;
		called = true;
		return foo_instance;
	}
}

class FooCollection2 {
	public FooIterator2 iterator () {
		return new FooIterator2 ();
	}
}

class FooCollection3 {
	public int size { get { return 1; } }

	public Foo @get (int index) {
		assert (index == 0);
		return foo_instance;
	}
}

class FooEntry4<K,V> {
	public K key { get; private set; }
	public V value { get; private set; }

	public FooEntry4 (K _key, V _value) {
		key = _key;
		value = _value;
	}
}

class FooIterator4<G> {
	bool called = false;

	public bool next () {
		return !called;
	}

	public G @get () {
		assert (!called);
		called = true;
		return new FooEntry4<string,Foo> ("foo", foo_instance);
	}
}

class FooCollection4<K,V> {
	public int size { get { return 1; } }

	public V @get (K key) {
		assert (key == "foo");
		return foo_instance;
	}

	public FooIterator4<FooEntry4<K,V>> iterator () {
		return new FooIterator4<FooEntry4<K,V>> ();
	}
}

Foo foo_instance;

void main () {
	foo_instance = new Foo ();

	// Uses next() and get()
	var collection = new FooCollection ();
	foreach (var foo in collection) {
		assert (foo == foo_instance);
	}

	// Uses next_value()
	var collection2 = new FooCollection2 ();
	foreach (var foo2 in collection2) {
		assert (foo2 == foo_instance);
	}

	// Uses size and get()
	var collection3 = new FooCollection3 ();
	foreach (var foo3 in collection3) {
		assert (foo3 == foo_instance);
	}

	// Uses iterator() and get()
	var collection4 = new FooCollection4<string,Foo> ();
	foreach (var fooentry4 in collection4) {
		assert (fooentry4.key == "foo");
		assert (fooentry4.value == foo_instance);
	}
	assert (collection4["foo"] == foo_instance);

	// GLib.List
	var list = new List<Foo> ();
	list.append (foo_instance);
	foreach (var e in list) {
		assert (e == foo_instance);
	}

	// GLib.SList
	var slist = new SList<Foo> ();
	slist.append (foo_instance);
	foreach (var e in slist) {
		assert (e == foo_instance);
	}
}
