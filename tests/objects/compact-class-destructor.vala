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

void bar () throws Error {
}

Foo get_foo () {
	return new Foo ();
}

class Bar {
	Foo faz;

	public void instance_simple () {
		var foo = new Foo ();
		var res = foo.destroy ();

		assert (foo == null);
		assert (res == 42);
	}

	public void instance_field () {
		bar ();

		faz = new Foo ();
		var res = faz.destroy ();

		assert (faz == null);
		assert (res == 42);
	}
}

Foo faz;

void field () {
	bar ();

	faz = new Foo ();
	var res = faz.destroy ();

	assert (faz == null);
	assert (res == 42);
}

void local () {
	bar ();

	var foo = new Foo ();
	var res = foo.destroy ();

	assert (foo == null);
	assert (res == 42);
}

void parameter (owned Foo foo) {
	bar ();

	var res = foo.destroy ();

	assert (foo == null);
	assert (res == 42);
}

void simple () {
	var foo = new Foo ();
	var res = foo.destroy ();

	assert (foo == null);
	assert (res == 42);
}

void returned () {
	bar ();

	var res = get_foo ().destroy ();

	assert (res == 42);
}

void main () {
	simple ();
	field ();
	local ();
	parameter (new Foo ());
	returned ();

	var bar = new Bar ();
	bar.instance_simple ();
	bar.instance_field ();
}
