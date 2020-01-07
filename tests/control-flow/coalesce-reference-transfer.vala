[Compact]
class Foo {
	public int n;

	public Foo (int n) {
		this.n = n;
	}
}

Foo? get_some_foo (int? n) {
	return n != null ? new Foo (n) : null;
}

void test_direct () {
	Foo f = get_some_foo (null) ?? get_some_foo (42);
	assert (f.n == 42);
}

void test_transitive () {
	Foo f = get_some_foo (null) ?? (get_some_foo (null) ?? get_some_foo (42));
	assert (f.n == 42);
}

void main () {
	test_direct ();
	test_transitive ();
}
