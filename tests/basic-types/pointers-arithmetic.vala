void test_chars () {
	char* s = "foo";
	char* begin = s;
	char* end = begin + 2;

	assert (begin[0] == 'f');
	assert (end[0] == 'o');
}

void test_strings () {
	string s = "foo";
	string* begin = s;
	string* end = begin + s.length - 1;

	assert (((char*) begin)[0] == 'f');
	assert (((char*) end)[0] == 'o');
}

void main () {
	test_chars ();
	test_strings ();
}
