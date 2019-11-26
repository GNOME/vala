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

	public virtual int manam (int i) ensures (result > 23) {
		switch (i) {
		case 67:
			return i;
		default:
			assert_not_reached ();
		}
	}

	public virtual int manam_pre (int i) requires (i > 23) {
		switch (i) {
		case 231:
			return i;
		default:
			assert_not_reached ();
		}
	}
}

struct Bar {
	public bool ensured;
	public bool required;

	public Bar () requires (required = true) {
	}

	public Bar.post () ensures (ensured = true) {
	}

	public void bar () ensures (ensured = true) {
	}

	public string foo () ensures (result.length >= 3) {
		return "foo";
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
	assert (foo.manam (67) == 67);
	assert (foo.manam_pre (231) == 231);

	var foo2 = new Foo.post ();
	assert (foo2.ensured);

	var bar = new Bar ();
	assert (bar.required);
	bar.bar ();
	assert (bar.ensured);
	assert (bar.foo () == "foo");

	var bar2 = new Bar.post ();
	assert (bar2.ensured);
}
