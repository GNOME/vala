void main () {
	int i = 0;

	do {
		i++;
	} while (i < 2);
	assert (i == 2);

	do {
		i = 42;
		break;
	} while (true);
	assert (i == 42);
}
