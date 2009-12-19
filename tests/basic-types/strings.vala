void test_string () {
	// declaration and initialization
	string s = "hello";
	assert (s == "hello");

	// assignment
	s = "world";
	assert (s == "world");

	// access
	string t = s;
	assert (t == "world");

	// +
	s = "hello" + "world";
	assert (s == "helloworld");

	// equality and relational
	s = "hello";
	assert (s == "hello");
	assert (s != "world");
	assert (s < "i");
	assert (!(s < "g"));
	assert (s <= "hello");
	assert (!(s <= "g"));
	assert (s >= "hello");
	assert (!(s >= "i"));
	assert (s > "g");
	assert (!(s > "i"));

	// slices
	t = s[2:4];
	assert (t.length == 2);
	assert (t[0] == 'l');
	assert (t[1] == 'l');
}

void main () {
	test_string ();
}
