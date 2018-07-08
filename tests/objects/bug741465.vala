[Compact]
abstract class AbstractFoo {
	public int field = 23;
	public abstract int prop { get; set; }
	public abstract unowned string foo ();
}

[Compact]
class Foo : AbstractFoo {
	public override int prop {
		get { return field + 1; }
		set { field = value - 1; }
	}

	public Foo () {
		assert (field == 23);
		field = 37;
		assert (prop == 38);
	}

	public override unowned string foo () {
		return "Foo";
	}
}

[Compact]
class Bar : Foo {
	public override int prop {
		get { return field * 2; }
		set { field = value / 2; }
	}

	public Bar () {
		assert (field == 37);
		field = 42;
		assert (prop == 84);
	}

	public override unowned string foo () {
		return "Bar";
	}
}

[Compact]
class Manam {
	public int field = 23;

	public virtual int prop {
		get { return field + 1; }
		set { field = value - 1; }
	}

	public virtual unowned string foo () {
		return "Manam";
	}

	[NoWrapper]
	public virtual int foo_plain () {
		return 13;
	}
}

[Compact]
class Baz : Manam {
	public override unowned string foo () {
		return "Baz";
	}

	public override int foo_plain () {
		return 23;
	}
}

void main () {
	var foo = new Foo ();
	assert (foo.foo () == "Foo");
	assert (foo.prop == 38);
	foo.prop = 4711;
	assert (foo.field == 4710);

	var bar = new Bar ();
	assert (bar.foo () == "Bar");
	assert (bar.prop == 84);
	bar.prop = 32;
	assert (bar.field == 16);

	var manam = new Manam ();
	assert (manam.foo () == "Manam");
	assert (manam.prop == 24);
	assert (manam.foo_plain () == 13);

	var baz = new Baz ();
	assert (baz.foo () == "Baz");
	baz.prop = 42;
	assert (baz.prop == 42);
	assert (baz.foo_plain () == 23);
}
