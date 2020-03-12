[CCode (has_type_id = false)]
struct Bar {
	public int i;
}

class Foo : Object {
	public Bar bar { get; set; }
}

void main () {
	var foo = new Foo ();
	foo.bar = { 23 };
	assert (foo.bar.i == 23);
}
