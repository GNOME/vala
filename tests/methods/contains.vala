class Foo {
	public bool contains (int item) {
		return item == 42;
	}
}

void main () {
	var foo = new Foo ();
	assert (42 in foo);
}
