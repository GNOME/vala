class Bar<K,V> {
	public K k;
	public V v;
	public Bar (K k, V v) {
		this.k = k;
		this.v = v;
	}
}

class Foo<G> {
	public signal void bar (Bar<int,G> item);

	public void fire (Bar<int,G> item) {
		bar (item);
	}
}

bool fired;

void on_bar (Bar<int,string> item) {
	assert (item.k == 42);
	assert (item.v == "bar");
	fired = true;
}

void main () {
	Foo<string> foo = new Foo<string> ();
	foo.bar.connect (on_bar);
	var bar = new Bar<int,string> (42, "bar");
	foo.fire (bar);
	assert (fired);
}
