class Foo : Object {
}

void test_array_with_class_move () {
	var foo = new Foo ();
	assert (foo.ref_count == 1);
	Foo[] a = { foo, foo, foo, foo, foo, foo, foo, foo, foo };
	assert (foo.ref_count == 10);

	a.move (0, 2, 3);
	//FIXME assert (foo.ref_count == 8);
}

void test_unowned_array_with_class_move () {
	var foo = new Foo ();
	assert (foo.ref_count == 1);
	(unowned Foo)[] a = { foo, foo, foo, foo, foo, foo, foo, foo, foo };
	assert (foo.ref_count == 1);

	a.move (0, 2, 3);
	assert (foo.ref_count == 1);
}

void main () {
	test_array_with_class_move ();
	test_unowned_array_with_class_move ();
}
