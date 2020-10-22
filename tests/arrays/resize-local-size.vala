void main() {
	int[] a = new int[10 * 1024 * 1024];

	a.resize (1);

	for (int i = 1; i < 10 * 1024 * 1024; i++) {
		a += 4711;
	}
}
