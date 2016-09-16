[Flags]
enum Foo {
	TEST = 1 << 0;
}

enum Bar {
	TEST = 1 << 0;
}

void main() {
	Foo.TEST.to_string ();
	Bar.TEST.to_string ();
}
