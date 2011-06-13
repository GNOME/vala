public struct Foo {
	public int bar;
	public Foo (int bar) {
		this.bar = bar;
	}
}

public Foo make_foo (int bar) {
	return Foo (bar);
}

void main () {
	var foo = Foo (10);
	assert (foo == make_foo (10));
}
