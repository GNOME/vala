void main () {
	string[] FOO = { "foo", null };
	int[] BAR = { 42, 4711 };

	unowned string? s, n;
	(s, n) = FOO;
	assert (s == "foo");
	assert (n == null);

	int i, j;
	(i, j) = BAR;
	assert (i == 42);
	assert (j == 4711);

	var (test, test2) = new int[] { 23, 51 };
	assert (test == 23);
	assert (test2 == 51);
}
