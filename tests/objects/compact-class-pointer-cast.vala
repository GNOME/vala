[Compact]
class Foo {
	public int i;
}

void main () {
	{
		Foo foo = (Foo) Slice.alloc (sizeof (int));
		foo.i = 23;
		unowned Foo foo_r = foo;
		assert (foo_r.i == 23);
	}
	{
		Foo* foo_p = Slice.alloc (sizeof (int));
		foo_p->i = 42;
		Foo foo = (Foo) foo_p;
		unowned Foo foo_r = foo;
		assert (foo_r.i == 42);
	}
}
