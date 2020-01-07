[Compact]
class Foo {
	public int i;

	public Foo (int i) {
		this.i = i;
	}
}

Foo? get_foo (int? i) {
	return i != null ? new Foo (i) : null;
}

void main () {
	{
		Foo foo = get_foo (null) ?? get_foo (42);
		assert (foo.i == 42);
	}
	{
		Foo foo = get_foo (null) ?? (get_foo (null) ?? get_foo (42));
		assert (foo.i == 42);
	}
}
