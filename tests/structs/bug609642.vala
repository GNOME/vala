public Value foo () {
	return "foo";
}

void main () {
	var bar = (string) foo ();
	assert (bar == "foo");
}
