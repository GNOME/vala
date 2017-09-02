void main () {
	int test[6] = { 23, 4711, 42 };
	assert (test[4] == 0);
	assert (test[5] == 0);
	int test2[6] = test;
	assert (test2[4] == 0);
	assert (test2[5] == 0);
}
