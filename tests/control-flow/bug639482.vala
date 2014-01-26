public string test() throws Error {
	return "foo";
}

void main () {
	string empty = null;
	assert ((false ? "A" : (empty ?? "B")) == "B");

	string foo = "bar" ?? test ();
	assert (foo == "bar");

	foo = empty ?? test ();
	assert (foo == "foo");
}
