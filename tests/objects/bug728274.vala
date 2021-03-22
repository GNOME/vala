class Foo {
}

[Compact]
class FooCompact {
	public int i;
}

class FooObject : Object {
}

struct Bar {
	public int i;
}

enum Manam {
	NONE;
}

errordomain FooError {
	FAIL;
}

void main () {
	assert (sizeof (Foo) >= sizeof (GLib.TypeInstance) + sizeof (int) + sizeof (void*));
	assert (sizeof (FooCompact) == sizeof (int));
	assert (sizeof (FooObject) == sizeof (GLib.Object) + sizeof (void*));

	assert (sizeof (Bar) == sizeof (int));
	assert (sizeof (Manam) == sizeof (uint));

	assert (sizeof (FooError) == sizeof (GLib.Quark) + sizeof (int) + sizeof (void*));

	assert (sizeof (Foo*) == sizeof (void*));
	assert (sizeof (int?) == sizeof (void*));
}
