unowned string foo[2] = { "foo", "bar" };
int bar[3] = { 23, 42, 4711 };

void main () {
	assert (foo[0] == "foo");
	assert (foo.length == 2);
	assert (bar[1] == 42);
	assert (bar.length == 3);
}
