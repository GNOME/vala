void main () {
	string[] foos = { "foo", "bar" };
	{
		unowned string?[] bars = foos;
	}
	{
		unowned string?[]? bars = foos;
	}
}
