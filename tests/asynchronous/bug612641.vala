delegate void FooFunc ();

class Foo {
	async FooFunc foo () {
		return () => {};
	}
}

void main () {
}
