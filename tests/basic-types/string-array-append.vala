void main () {
	string[] foo = { "foo", "bar", "foo bar" };

	foo[0] += "abc";
	foo[1] += 123.to_string ();
	foo[2] += " abc" + 123.to_string ();

	assert (foo[0] == "fooabc");
	assert (foo[1] == "bar123");
	assert (foo[2] == "foo bar abc123");
}

