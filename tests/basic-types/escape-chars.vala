void test_x_escape_chars () {
	string s = "Copyright \xc2\xa9";

	assert (s == "Copyright ©");
}

void test_u_escape_chars () {
	string s = "Copyright \u00a9";

	assert (s == "Copyright ©");
}

void main () {
	// Test case for bug report 704709
	test_x_escape_chars ();
	test_u_escape_chars ();
}
