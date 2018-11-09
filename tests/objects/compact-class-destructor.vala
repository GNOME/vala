[Compact]
class Foo {
	[DestroysInstance]
	public int destroy () {
		//FIXME No free possible due to broken sizeof(Foo)
		// https://gitlab.gnome.org/GNOME/vala/issues/442
		Slice.free (sizeof (int), this);
		return 42;
	}
}

void main () {
	var foo = new Foo ();
	var res = foo.destroy ();
	assert (foo == null);
	assert (res == 42);
}
