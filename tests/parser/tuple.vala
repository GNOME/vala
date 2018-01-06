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
}
