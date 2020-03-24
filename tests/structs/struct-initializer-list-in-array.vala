struct Foo {
	public string s;
	public Bar b;
	public bool[] ba;
	public int i;
}

struct Bar {
	public string s;
	public int i;
}

void main () {
	Foo[] foos = {
		{ "foo", { "foo", 42 }, { true }, 23 },
		{ "bar", { "bar", 4711 }, { false }, 42 },
	};

	var f = foos[0];
	assert (f.i == 23 && f.s == "foo" && f.b.s == "foo" && f.ba[0]);

	f = foos[1];
	assert (f.i == 42 && f.s == "bar" && f.b.i == 4711 && !f.ba[0]);
}
