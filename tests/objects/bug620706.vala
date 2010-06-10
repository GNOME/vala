class Foo : Object {
	public Value val { get; set; }
}

struct Bar {
	int dummy;
}

void main () {
	var f = new Foo ();
	var b = Bar ();
	f.val = b;
}
