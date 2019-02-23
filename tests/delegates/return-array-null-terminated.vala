[CCode (has_target = false, array_length = false, array_null_terminated = true)]
delegate string[] FooFunc ();

[CCode (array_length = false, array_null_terminated = true)]
string[] foo () {
	return {"foo", "bar"};
}

void main () {
	FooFunc f = foo;

	{
		var s = f ();
		assert (s.length == 2);
		assert (s[1] == "bar");
	}
}
