class Foo : Object {
	public int i = 1;

	public unowned Foo sideeffect () {
		--i;
		return this;
	}
	public string data;
}

void main () {
	var foo = new Foo ();
	foo.sideeffect ().data = "foo";
	assert (foo.data == "foo");
	assert (foo.i == 0);
}
