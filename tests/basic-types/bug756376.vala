namespace Foo {
	const int BAR = 5;
}

void bar (int[] a) {
}

void main () {
	int arr[Foo.BAR];

	bar (arr);
}
