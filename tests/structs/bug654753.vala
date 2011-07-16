struct Foo {
	int baz;

	public void bar (Foo f) {
		baz = 10;
		f.baz = 20;
	}
}

void main() {
	Foo[] array = new Foo[2];
	array[0].bar (array[1]);
	assert (array[0].baz == 10);
	assert (array[1].baz == 0);
}
