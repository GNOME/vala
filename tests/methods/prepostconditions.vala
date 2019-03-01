class Foo {
	public bool ensured = false;
	public bool required = false;

	public Foo () requires (required = true) {
	}

	public void foo () ensures (ensured = true) {
	}

	public string bar () ensures (result.length >= 3) {
		return "bar";
	}

	public void foo_pre (int i) requires (i > 23) {
		assert (i == 42);
	}

	public int bar_pre (int i) requires (i > 42) {
		assert (i == 4711);
		return i;
	}
}

void main () {
	var foo = new Foo();
	assert(foo.required);
	foo.foo();
	assert(foo.ensured);
	assert(foo.bar () == "bar");
	foo.foo_pre (42);
	assert(foo.bar_pre (4711) == 4711);
}
