[CCode (no_generic_args = true)]
class Foo<G> : Object where G : Object {
	public G bar { get; set; }

	public G get_b () {
		return this.bar;
	}

	public void set_b (G b) {
		this.bar = b;
	}
}

class Baz : Object {
}

void main () {
	var f = new Foo<Baz> ();
	f.set_b (new Baz());
	Baz b = f.get_b ();
}
