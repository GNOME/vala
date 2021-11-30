void main () {
	int?[] foo = { 23, 42, 4711 };

	foo[0] += 1;
	foo[1] *= 3;
	foo[2] -= 2;

	assert (foo[0] == 24);
	assert (foo[1] == 126);
	assert (foo[2] == 4709);
}
