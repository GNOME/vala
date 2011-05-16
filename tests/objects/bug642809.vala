interface Foo : Object {
	public virtual signal void virtual_signal () { }
}

class Bar : Object, Foo {
}

void main () {
	var bar = new Bar ();
	bar.virtual_signal ();
}
