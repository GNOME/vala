struct Foo {
	int i;
}

void main () {
	Value v = Foo ();
	assert (v.type() == typeof (Foo));
}
