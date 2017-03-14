delegate void FooFunc ();

class Foo {
	FooFunc f;

	public Foo (owned FooFunc d) {
		f = (owned) d;
		assert (d == null);
	}
}

void main () {
	var foo = new Foo (() => {});
}
