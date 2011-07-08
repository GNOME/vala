class Foo {
	public async void bar<G> (G arg, Type t) {
		assert (typeof (G) == t);
	}
}

void main () {
	var foo = new Foo ();
	foo.bar<string> ("foo", typeof (string));
}
