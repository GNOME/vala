void main () {
	string[] a = { "foo", "bar", null, "baz" };

	a.length = 0;
	assert (string.joinv (":", a) == "");

	a.length = 1;
	assert (string.joinv (":", a) == "foo");

	a.length = 2;
	assert (string.joinv (":", a) == "foo:bar");

	a.length = 3;
	assert (string.joinv (":", a) == "foo:bar:");

	a.length = 4;
	assert (string.joinv (":", a) == "foo:bar::baz");

	a.length = -1;
	assert (string.joinv (":", a) == "foo:bar");

	assert (string.joinv (":", null) == "");
}
