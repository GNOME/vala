void main () {
	int i = 0;

	while (true) {
		if (i == 0) {
			i = 42;
			continue;
		}
		break;
	}
	assert (i == 42);
}
