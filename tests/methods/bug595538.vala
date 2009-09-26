delegate void Foo ();

void do_foo (Foo foo) {
	foo ();
}

void main () {
	int i = 42;
	do_foo (() => {
		do_foo (() => {
			int j = i;
		});
	});
}

