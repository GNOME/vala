class Bar : Object {
}

class Foo : Object {
	public string[] faz { get; owned set; }
	public Bar bar { get; owned set; }
}

void main() {
	string[] sa = { "foo", "bar" };
	var o = new Bar ();

	var foo = new Foo () {
		faz = sa,
		bar = o
	};

	assert (foo.faz[1] == "bar");
	assert (foo.bar.ref_count == 2);
	assert (sa[0] == "foo");
	assert (o.ref_count == 2);
}
