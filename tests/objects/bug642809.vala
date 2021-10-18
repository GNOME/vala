interface Foo : Object {
	public virtual signal void virtual_signal () { }
}

class Bar : Object, Foo {
}

class Manam : Object, Foo {
	public override void virtual_signal () { }
}

void main () {
	var bar = new Bar ();
	bar.virtual_signal ();
	var manam = new Manam ();
	manam.virtual_signal ();
}
