class Foo : Object {
	[CCode (cname = "manam")]
	public Foo? bar { owned get; set; }
}

void main () {
	var foo = new Foo ();
	assert (foo.ref_count == 1);

	dynamic Foo dfoo = foo;
	assert (foo.ref_count == 2);

	assert (dfoo.manam == null);
	assert (foo.ref_count == 2);

	dfoo.manam = foo;
	assert (foo.ref_count == 3);

	foo = dfoo.manam;
	assert (foo.ref_count == 3);

	dfoo = null;
	foo.bar = null;
	assert (foo.ref_count == 1);
}
