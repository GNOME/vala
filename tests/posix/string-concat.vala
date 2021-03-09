unowned string get_foo () {
	return "foo";
}

void main () {
	string s = get_foo () + "bar" + "!";
	assert (s == "foobar!");
}
