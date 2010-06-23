struct Foo {
	int i;
}

delegate void TestDelegate ();

void do_foo (TestDelegate d) {
}

void do_foo_lambda (Foo foo, Value value) {
	do_foo (() => { foo.i = 1; value = (int) 2; });
}

void main () {
}
