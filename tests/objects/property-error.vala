errordomain FooError {
	BAD;
}

class Bar {
	public Error bar { get; set; }
	public FooError foo { get; set; }
}

class Foo : Object {
	public Error bar { get; set; }
	public FooError foo { get; set; }
	public FooError manam { owned get; set; }
}

void main () {
	{
		var bar = new Bar ();
		bar.foo = new FooError.BAD ("OOPS");
		assert (bar.foo.code == FooError.BAD);
		bar.bar = new FooError.BAD ("OOPS");
		assert (bar.bar.code == FooError.BAD);
	}
	{
		var foo = new Foo ();
		foo.foo = new FooError.BAD ("OOPS");
		assert (foo.foo.code == FooError.BAD);
		foo.bar = new FooError.BAD ("OOPS");
		assert (foo.bar.code == FooError.BAD);
		foo.manam = new FooError.BAD ("OOPS");
		assert (foo.manam.code == FooError.BAD);
	}
}
