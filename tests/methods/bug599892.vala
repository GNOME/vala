class Foo {
	public static int bar { get; set; }

	public void do_foo () {
		int i = 42;
		bar = i;
		assert (bar == 42);
	}
}

void main () {
	var foo = new Foo ();
	foo.do_foo ();
}
