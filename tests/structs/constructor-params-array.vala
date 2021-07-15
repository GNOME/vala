struct Foo {
	public string[] sa;

	public Foo (params string[] strv) {
		assert (strv.length == 3);
		assert (strv[0] == "foo");
		assert (strv[1] == "bar");
		assert (strv[2] == "manam");
		sa = strv;
	}
}

void main () {
	var foo = Foo ("foo", "bar", "manam");
	assert (foo.sa[1] == "bar");
}
