class Foo : Object {
}

class Bar : Object {
	public Foo foo { get; set; }
	public Foo foo_owned { owned get; set; }
	public weak Foo foo_weak { get; set; }
	public weak Foo foo_weak_owned { owned get; set; }
}

class Manam {
	public Foo foo { get; set; }
	public Foo foo_owned { owned get; set; }
	public weak Foo foo_weak { get; set; }
	public weak Foo foo_weak_owned { owned get; set; }
}

void main () {
	var foo = new Foo ();
	assert (foo.ref_count == 1);

	//GObject class
	{
		var bar = new Bar ();
		bar.foo = foo;
		assert (foo.ref_count == 2);
		unowned Foo f = bar.foo;
		assert (foo.ref_count == 2);
	}
	assert (foo.ref_count == 1);
	{
		var bar = new Bar ();
		bar.foo_owned = foo;
		assert (foo.ref_count == 2);
		Foo f = bar.foo_owned;
		assert (foo.ref_count == 3);
	}
	assert (foo.ref_count == 1);
	{
		var bar = new Bar ();
		bar.foo_weak = foo;
		assert (foo.ref_count == 1);
		unowned Foo f_weak = bar.foo_weak;
		assert (foo.ref_count == 1);
	}
	assert (foo.ref_count == 1);
	{
		var bar = new Bar ();
		bar.foo_weak_owned = foo;
		assert (foo.ref_count == 1);
		Foo f_weak_owned = bar.foo_weak_owned;
		assert (foo.ref_count == 2);
	}
	assert (foo.ref_count == 1);

	//GType class
	{
		var manam = new Manam ();
		manam.foo = foo;
		assert (foo.ref_count == 2);
		unowned Foo f = manam.foo;
		assert (foo.ref_count == 2);
	}
	assert (foo.ref_count == 1);
	{
		var manam = new Manam ();
		manam.foo_owned = foo;
		assert (foo.ref_count == 2);
		Foo f = manam.foo_owned;
		assert (foo.ref_count == 3);
	}
	assert (foo.ref_count == 1);
	{
		var manam = new Manam ();
		manam.foo_weak = foo;
		assert (foo.ref_count == 1);
		unowned Foo f_weak = manam.foo_weak;
		assert (foo.ref_count == 1);
	}
	assert (foo.ref_count == 1);
	{
		var manam = new Manam ();
		manam.foo_weak_owned = foo;
		assert (foo.ref_count == 1);
		Foo f_weak_owned = manam.foo_weak_owned;
		assert (foo.ref_count == 2);
	}
	assert (foo.ref_count == 1);
}
