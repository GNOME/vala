public class Foo {
	public int i;
	public Foo () {
		i = 1;
	}
}

public class Bar : Foo {
	public int j;
	public Bar () {
		base ();
		this.j = 1;
	}
}

void main () {
	var bar = new Bar ();
	assert (bar.i == 1);
	assert (bar.j == 1);
}
