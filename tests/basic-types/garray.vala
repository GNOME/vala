class Foo : Object {
}

void main () {
	var array = new GLib.Array<Foo> ();

	var foo = new Foo ();
	assert (foo.ref_count == 1);

	array.append_val (foo);
	assert (foo.ref_count == 2);
	array.remove_index (0);
	assert (foo.ref_count == 1);

	array.append_val (foo);
	assert (foo.ref_count == 2);
	array.remove_index_fast (0);
	assert (foo.ref_count == 1);

	array.append_val (foo);
	assert (foo.ref_count == 2);
	array.remove_range (0, 1);
	assert (foo.ref_count == 1);
}
