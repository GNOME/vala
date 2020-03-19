[Compact (opaque = true)]
public class Foo {
	public int bar { get; set; }
}

void main () {
	var foo = new Foo ();
	foo.bar = 42;
	assert (foo.bar == 42);
}
