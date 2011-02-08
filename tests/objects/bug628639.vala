class Foo<G> {
	public signal void bar (G item);

	public void fire (G item) {
		bar (item);
	}
}

bool fired;

void on_bar (int item) {
	assert (item == 42);
	fired = true;
}

void main() {
	Foo<int> foo = new Foo<int> ();
	foo.bar.connect (on_bar);
	foo.fire (42);
	assert (fired);
}
