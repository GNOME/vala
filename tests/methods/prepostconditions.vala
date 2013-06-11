class Foo {
	public bool ensured = false;

	public void foo () ensures (ensured = true) {
	}
}

void main () {
	var foo = new Foo();
	foo.foo();
	assert(foo.ensured);
}