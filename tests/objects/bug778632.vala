class Foo : Object {
	public signal void bar (int[,,] a);

	public void bar_emit () {
		int[,,] a = {{{1, 2}, {3, 4}, {5, 6}}, {{7, 8}, {9, 10}, {11, 12}}};
		bar (a);
	}
}

void bar_callback (int[,,] a) {
	assert (a.length[0] == 2);
	assert (a.length[1] == 3);
	assert (a.length[2] == 2);
	assert (a[0,2,0] == 5);
	assert (a[1,2,1] == 12);
}

void main () {
	var foo = new Foo ();
	foo.bar.connect (bar_callback);
	foo.bar_emit ();
}
