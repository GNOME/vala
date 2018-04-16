public struct Foo {
	public int val { get; set; }

	public Foo () {
		val = 55;
	}
}

public class Bar : Object {
	private Foo _foo;

	public Foo foo {
		get { return _foo; }
		set { _foo = value; }
		default = Foo ();
	}
}

void main () {
	var bar = new Bar();
	assert (bar.foo.val == 55);
}
