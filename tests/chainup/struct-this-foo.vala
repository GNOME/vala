public struct Foo {
	public int i;
	public int j;
	public Foo () {
		this.foo ();
		j = 1;
	}
	public Foo.foo () {
		i = 1;
	}
}

void main () {
	var foo = Foo ();
	//FIXME assert (foo.i == 1);
	assert (foo.j == 1);
}
