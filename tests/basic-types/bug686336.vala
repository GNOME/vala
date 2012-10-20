class Foo {
	static int[] static_bar = { 1, 2, 3 };
	static int[] static_baz = create_array ();

	int[] bar = { 1, 2, 3 };
	int[] baz = create_array ();

	static int[] create_array () {
		return { 1, 2, 3 };
	}

	public void test () {
		assert (static_bar.length == 3);
		assert (static_baz.length == 3);

		assert (bar.length == 3);
		assert (baz.length == 3);
	}
}

void main () {
	var foo = new Foo ();
	foo.test ();
}

