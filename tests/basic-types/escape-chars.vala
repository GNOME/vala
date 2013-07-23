void test_x_escape_chars () {
	string s = "Copyright \xc2\xa9";

	assert (s == "Copyright ©");

	// The escape sequence \x has a variable length
	// with the lower boundary set to 1
	string s1 = "\x9q";
	assert (s1 == "\x09q");
}

void test_u_escape_chars () {
	string s = "Copyright \u00a9";

	assert (s == "Copyright ©");
}

void main () {
	// Test case for the bug report 704709
	test_x_escape_chars ();
	test_u_escape_chars ();
}
