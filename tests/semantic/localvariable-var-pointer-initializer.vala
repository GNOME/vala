struct Foo {
	public string s;
}

void main () {
	{
		Foo foo = { "foo" };
		var foo_p = &foo;
		assert (foo_p.s == "foo");
	}
}
