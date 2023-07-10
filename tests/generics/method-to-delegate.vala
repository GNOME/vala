delegate void Func<G> (G g);

void foo (string s) {
	assert (s == "foo");
}

void bar (int i) {
	assert (i == 42);
}

void main () {
	Func f = foo;
	f ("foo");

	Func<int> b;
	b = bar;
	b (42);
}
