[CCode (array_length_cname = "foo_len")]
public int[] foo;

// would cause a symbol clash
int foo_length1;

void main () {
	foo = { 23, 42 };
	assert (foo.length == 2);
}
