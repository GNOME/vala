public delegate string Deleg ();

Deleg foo (owned string bar) {
	return () => { return bar; };
}

void main () {
	assert (foo ("foo")() == "foo");
}
