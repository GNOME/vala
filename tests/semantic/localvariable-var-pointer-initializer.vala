struct Foo {
	public string s;
}

void main () {
	{
		Foo foo = { "foo" };
		var foo_p = &foo;
		assert (foo_p.s == "foo");
	}
	{
		Foo bar = { "bar" };
		unowned var bar_p = &bar;
		assert (bar_p.s == "bar");
	}
}
