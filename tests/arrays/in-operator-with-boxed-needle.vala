void main () {
	int[] foo = { 0, 23, 42 };

	int? i = null;
	assert (!(i in foo));

	i = 23;
	assert (i in foo);

	i = 4711;
	assert (!(i in foo));
}
