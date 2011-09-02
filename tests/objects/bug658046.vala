struct Foo {
	int i;
}

class Bar {
	public Foo prop { get; protected set; }

	public void baz () {
		prop.i = 10;
	}
}

void main () {
	var bar = new Bar ();
	bar.baz ();
	assert (bar.prop.i == 10);
}
