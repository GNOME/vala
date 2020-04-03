void main () {
	int? i = null;
	int[] a = { 0, 1, 2 };
	assert ((i in a) == false);

	i = 1;
	assert ((i in a) == true);

	i = 3;
	assert ((i in a) == false);
}
