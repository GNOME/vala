class Foo {
	public bool ensured = false;
	public bool required = false;

	public Foo () requires (required = true) {
	}

	public Foo.post () ensures (ensured = true) {
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

	public int faz (int i) ensures (result > 23) {
		switch (i) {
		case 42:
			return i;
		default:
			assert_not_reached ();
		}
	}

	public int faz_pre (int i) requires (i > 23) {
		switch (i) {
		case 4711:
			return i;
		default:
			assert_not_reached ();
		}
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
	assert (foo.faz (42) == 42);
	assert (foo.faz_pre (4711) == 4711);

	var foo2 = new Foo.post ();
	assert (foo2.ensured);
}
