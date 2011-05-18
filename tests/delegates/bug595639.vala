delegate void Foo ();

void do_foo (owned Foo foo) {
	Foo bar = (owned) foo;
}

void main () {
}
