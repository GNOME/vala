void foo (ref string s) {
	assert (s == "foo");
	s = "bar";
}

void main () {
	string[] bar = { "manam", "foo" };
	foo (ref bar[1]);
	assert (bar[1] == "bar");
}
