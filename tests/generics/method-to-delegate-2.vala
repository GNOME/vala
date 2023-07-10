delegate void Func<G> (G g);

void foo (string s) {
	assert (s == "foo");
}

void call_foo (Func<string> f) {
	f ("foo");
}

void bar (int i) {
	assert (i == 42);
}

void call_bar (Func<int> f) {
	f (42);
}

void main () {
	call_foo (foo);

	call_bar (bar);
}
