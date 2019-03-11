[Compact]
class Foo<G> {
	public Foo (ulong real_foo, ulong foo = sizeof (G)) {
		assert (foo == real_foo);
	}

	public void bar (ulong real_foo, ulong foo = sizeof (G)) {
		assert (foo == real_foo);
	}
}

void main () {
	{
		var garray = new GLib.Array<uint32> ();
	}
	{
		var foo = new Foo<uint32> (sizeof (uint32));
		foo.bar (4);
	}
	{
		var foo = new Foo<int16> (sizeof (int16));
		foo.bar (2);
	}
	{
		var foo = new Foo<uint8> (sizeof (uint8));
		foo.bar (1);
	}
}
