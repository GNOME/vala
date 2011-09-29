struct Foo {
	int[] bar;
}

void main () {
	var f = Foo ();
	f.bar.resize (10);
	assert (f.bar.length == 10);
}
