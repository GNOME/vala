class Bar {
	[CCode (array_length_cname = "foo_len")]
	public int[] foo;

	// would cause a symbol clash
	public int foo_length1;
}

void main () {
	var bar = new Bar ();
	bar.foo = { 23, 42 };
	assert (bar.foo.length == 2);
}
