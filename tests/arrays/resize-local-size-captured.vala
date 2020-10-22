delegate void FooFunc ();

void main () {
	int[] a = new int[10 * 1024 * 1024];

	FooFunc func = () => {
		a.resize (1);
	};
	func ();

	for (int i = 1; i < 10 * 1024 * 1024; i++) {
		a += 4711;
	}
}
