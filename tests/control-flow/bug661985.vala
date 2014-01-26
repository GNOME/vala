void main () {
	string foo = "foo";
	void* foop = foo;
	unowned string bar = foo ?? "bar";
	void* barp = bar;
	assert (foop == barp);
}
