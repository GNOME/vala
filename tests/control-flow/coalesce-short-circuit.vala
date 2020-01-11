string get_foo () {
	assert_not_reached ();
}

void main () {
	{
		string foo = "foo" ?? get_foo ();
		assert (foo == "foo");
	}
	{
		string foo = "foo" ?? get_foo () ?? get_foo ();
		assert (foo == "foo");
	}
}
