class Foo : Object {
}

class Bar {
	public Foo a;
	public Foo b { get; set; }
	public Foo c;
}

void main () {
	var bar = new Bar () {
		a = b = c = new Foo ()
	};
	assert (bar.a != null);
	assert (bar.a == bar.b);
	assert (bar.a == bar.c);
	assert (bar.a.ref_count == 4);
}
