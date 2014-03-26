using GLib;

[Flags]
enum Foo {
	VAL1,
	VAL2,
	VAL3
}

void main () {
	Foo foo, bar, baz;

	foo = (Foo.VAL1 | Foo.VAL2 | Foo.VAL3);
	bar = (Foo.VAL1 | Foo.VAL2);
	baz = (bar | Foo.VAL3);

	assert (Foo.VAL1 == 1 << 0);
	assert (Foo.VAL2 == 1 << 1);
	assert (Foo.VAL3 == 1 << 2);

	assert (Foo.VAL1 in bar);
	assert ((Foo.VAL1 | Foo.VAL2) in bar);
	assert (!(Foo.VAL3 in bar));

	assert (Foo.VAL1 in baz);
	assert (Foo.VAL2 in baz);
	assert (Foo.VAL3 in baz);

	assert (bar in foo);
}

