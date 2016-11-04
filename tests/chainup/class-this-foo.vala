public class Foo {
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
	var foo = new Foo ();
	assert (foo.i == 1);
	assert (foo.j == 1);
}
