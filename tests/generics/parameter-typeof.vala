class Foo<T> {
	public void bar (Type t) {
		assert (t.is_a (typeof (T)));
	}
}

void main () {
	var foo = new Foo<string> ();
	foo.bar (typeof (string));
}
