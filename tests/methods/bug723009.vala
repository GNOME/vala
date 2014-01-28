public string foo () throws Error {
	return "foo";
}

void main () {
	Value bar;
	bar = foo ();
	assert ((string) bar == "foo");
}