delegate void Foo ();

async void do_foo (owned Foo f) {
	f ();
}

void main () {
}
