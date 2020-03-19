[Compact (opaque = true)]
public class Foo {
	private int i;
	internal int j;

	public Foo () {
		i = 42;
	}

	public int get_i () {
		return i;
	}
}

void main () {
	var foo = new Foo ();
	foo.j = 23;
	assert (foo.j == 23);
	assert (foo.get_i () == 42);
}
