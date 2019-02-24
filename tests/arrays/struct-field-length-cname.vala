struct Bar {
	[CCode (array_length_cname = "foo_len")]
	public int[] foo;

	// would cause a symbol clash
	public int foo_length1;
}

void main () {
	Bar bar = {{ 23, 42 }, -1};
	assert (bar.foo.length == 2);
}
