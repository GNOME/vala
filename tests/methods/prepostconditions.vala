class Foo {
	public bool ensured = false;

	public void foo () ensures (ensured = true) {
	}

	public string bar () ensures (result.length >= 3) {
		return "bar";
	}
}

void main () {
	var foo = new Foo();
	foo.foo();
	assert(foo.ensured);
	assert(foo.bar () == "bar");
}
