void foo ([CCode (array_length = false, array_null_terminated = true)] ref string[] bar) {
	bar = { "foo", "bar", "manam", "!" };
}

void faz ([CCode (array_length = false, array_null_terminated = true)] ref string[] bar) {
	foo (ref bar);
}

void main () {
	{
		string[] bar = { "bar" };
		foo (ref bar);
		assert (bar.length == 4);
		assert (bar[2] == "manam");
		assert (bar[4] == null);
	}
	{
		string[] bar = { "bar" };
		faz (ref bar);
		assert (bar.length == 4);
		assert (bar[2] == "manam");
		assert (bar[4] == null);
	}
}
