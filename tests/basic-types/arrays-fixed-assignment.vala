string foo[3];

void main () {
	{
		foo = new string[3];
	}
	{
		foo = new string[3] { "foo", "bar", "baz" };
		assert (foo[1] == "bar");
	}
	{
		foo = { "foo", "bar", "baz" };
		assert (foo[1] == "bar");
	}

	{
		string bar[3] = new string[3];
	}
	{
		string bar[3] = new string[3] { "foo", "bar", "baz" };
		assert (bar[1] == "bar");
	}
	{
		string bar[3] = { "foo", "bar", "baz" };
		assert (bar[1] == "bar");
	}
}
