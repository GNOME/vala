struct Foo {
	public string s;
}

struct Bar : Foo {
}

void main () {
	{
		Bar bar = { "bar" };
		Foo foo = bar;

		assert (bar.s == "bar");
		assert (bar.s == foo.s);

		void* s1 = foo.s;
		void* s2 = bar.s;
		assert (s1 != s2);
	}
	{
		Foo foo = { "foo" };
		Bar bar = foo;

		assert (foo.s == "foo");
		assert (foo.s == bar.s);

		void* s1 = foo.s;
		void* s2 = bar.s;
		assert (s1 != s2);
	}
}
