void foo ([CCode (array_length = false, array_null_terminated = true)] out string[] bar) {
	bar = { "foo", "bar", "manam", "!" };
}

void faz ([CCode (array_length = false, array_null_terminated = true)] out string[] bar) {
	foo (out bar);
}

void main () {
	{
		string[] bar;
		foo (out bar);
		assert (bar.length == 4);
		assert (bar[2] == "manam");
		assert (bar[4] == null);
	}
	{
		string[] bar;
		faz (out bar);
		assert (bar.length == 4);
		assert (bar[2] == "manam");
		assert (bar[4] == null);
	}
}
