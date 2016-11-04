public struct Foo {
	public int i;
	public int j;
	public Foo.foo () {
		i = 1;
	}
}

public struct Bar : Foo {
	public Bar () {
		base.foo ();
		this.j = 1;
	}
}

void main () {
	var bar = Bar ();
	//FIXME assert (bar.i == 1);
	assert (bar.j == 1);
}
