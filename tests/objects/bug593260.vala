class Foo {
	public void do_foo<T> () {
		assert (this is Foo);
	}
}

void main() {
	var foo = new Foo ();
	foo.do_foo<int> ();
}
