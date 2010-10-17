void main () {
	int[] foo = new int[42];
	int i = 1;
	foo[i = i - 1] = 23;
	assert (i == 0);
}
