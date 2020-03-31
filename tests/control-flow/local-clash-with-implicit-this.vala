class Foo {
	int clash = 19;

	public Foo () {
		int clash = clash + 23;
		assert (clash == 42);
	}
}

void main () {
	new Foo ();
}
