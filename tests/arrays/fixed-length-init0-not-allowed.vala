void main () {
	const int FOO = 4;

	char bar[FOO] = { 'f', 'o', 'o', '\0' };
	assert ((string) bar == "foo");

	char baz[FOO];
	baz[0] = 'f';
	baz[1] = 'o';
	baz[2] = 'o';
	baz[3] = '\0';
	assert ((string) baz == "foo");
}
