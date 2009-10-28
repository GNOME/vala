struct Foo {
	int bar;
}

delegate Foo Func ();

Foo do_foo () {
	return Foo ();
}

void main () {
	Func func = do_foo;
	func ();
}
