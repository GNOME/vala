[CCode (has_type_id = false)]
struct Foo {
	public int i;
}

void main () {
	{
		Foo? foo = (Foo?) GLib.malloc (sizeof (int));
		foo.i = 23;
		unowned Foo? foo_r = foo;
		assert (foo_r.i == 23);
	}
	{
		Foo* foo_p = GLib.malloc (sizeof (int));
		foo_p->i = 42;
		Foo? foo = (Foo?) foo_p;
		unowned Foo? foo_r = foo;
		assert (foo_r.i == 42);
	}
}
