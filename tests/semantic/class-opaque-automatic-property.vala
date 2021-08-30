[Compact (opaque = true)]
public class Foo {
	public int bar { get; set; }

	public void manam () {
		bar = 23;
		assert (bar == 23);
	}
}

void main () {
	var foo = new Foo ();
	foo.manam ();
	foo.bar = 42;
	assert (foo.bar == 42);
}
