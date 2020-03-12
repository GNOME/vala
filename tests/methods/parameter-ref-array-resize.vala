void foo (ref int[] a) {
	a = new int[1];
}

void main() {
	int[] a = new int[10 * 1024 * 1024];
	foo (ref a);
	for (int i = 1; i < 10 * 1024 * 1024; i++) {
		a += 4711;
	}
}
