struct Foo {
	public unowned string s;
	public int i;
}

const Foo[] FOOS = { { "foo", 23 }, {} };
const Foo[] BARS = { { "bar", 42 }, null };

void main () {
	Foo[] foos = { { "foo", 23 }, {} };
	Foo[] bars = { { "bar", 42 }, null };
}
