struct Foo {
	int i;
}

void test (int n, ...) {
}

void main () {
	Foo foo;
	test (0, out foo);
}
