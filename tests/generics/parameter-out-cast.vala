void manam<T> (T foo, out T bar) {
	bar = foo;
}

void main () {
	{
		bool bar;
		manam<bool> (true, out bar);
		assert (bar == true);
	}
	{
		uint32 bar;
		manam<uint32> (23U, out bar);
		assert (bar == 23U);
	}
	{
		string bar;
		manam<string> ("bar", out bar);
		assert (bar == "bar");
	}
}
