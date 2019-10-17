interface IFoo {
	public abstract string foo { get; set; }
}

class Bar : IFoo {
	public string foo { get; set; }
}

class Foo : Bar {
	public string bar (string s) {
		base.foo = s;
		return base.foo;
	}
}

void main () {
	var foo = new Foo ();
	assert (foo is IFoo);
	assert (foo.bar ("foo") == "foo");
}
