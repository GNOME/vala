void manam (string[] foo) {
	assert (foo.length == 2);
	assert (foo[0] == "bar");
	assert (foo[1] == "baz");
}

void minim (owned string[] foo) {
	assert (foo.length == 2);
	assert (foo[0] == "bar");
	assert (foo[1] == "baz");
}

void main () {
	string bar[4] = { "foo", "bar", "baz", "buzz" };
	{
		var foo = bar[1:3];
		assert (foo.length == 2);
		assert (foo[0] == "bar");
		assert (foo[1] == "baz");
	}
	{
		unowned var foo = bar[1:3];
		assert (foo.length == 2);
		assert (foo[0] == "bar");
		assert (foo[1] == "baz");
	}
	{
		int begin = 1;
		var foo = bar[begin:3];
		assert (foo.length == 2);
		assert (foo[0] == "bar");
		assert (foo[1] == "baz");
	}
	{
		string[] foo = bar[1:3];
		assert (foo.length == 2);
		assert (foo[0] == "bar");
		assert (foo[1] == "baz");
	}
	{
		unowned string[] foo = bar[1:3];
		assert (foo.length == 2);
		assert (foo[0] == "bar");
		assert (foo[1] == "baz");
	}
	{
		int end = 3;
		string[] foo = bar[1:end];
		assert (foo.length == 2);
		assert (foo[0] == "bar");
		assert (foo[1] == "baz");
	}
	{
		manam (bar[1:3]);
	}
	{
		int begin = 1;
		manam (bar[begin:3]);
	}
	{
		int end = 3;
		manam (bar[1:end]);
	}
	{
		minim (bar[1:3]);
	}
	{
		int begin = 1;
		minim (bar[begin:3]);
	}
	{
		int end = 3;
		minim (bar[1:end]);
	}
}
