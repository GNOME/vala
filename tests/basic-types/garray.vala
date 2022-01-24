class Foo : Object {
}

struct FooStruct {
	string content;
	Foo object;
}

void test_garray () {
	var array = new GLib.Array<Foo> ();

	var foo = new Foo ();
	assert (foo.ref_count == 1);

	array.append_val (foo);
	assert (foo.ref_count == 2);
	assert (array.index (0) == foo);
	array.remove_index (0);
	assert (foo.ref_count == 1);

	array.append_val (foo);
	assert (foo.ref_count == 2);
	assert (array.index (0) == foo);
	array.remove_index_fast (0);
	assert (foo.ref_count == 1);

	array.append_val (foo);
	array.append_val (foo);
	assert (foo.ref_count == 3);
	assert (array.index (0) == foo);
	assert (array.index (1) == foo);
	array.remove_range (0, 2);
	assert (foo.ref_count == 1);
}

void test_garray_foreach () {
	var array = new GLib.Array<Foo> ();

	var foo1 = new Foo ();
	var foo2 = new Foo ();
	var foo3 = new Foo ();

	array.append_val (foo1);
	assert (foo1.ref_count == 2);
	array.append_val (foo2);
	assert (foo2.ref_count == 2);
	array.append_val (foo3);
	assert (foo3.ref_count == 2);
	assert (array.length == 3);

	int loop_size = 0;
	foreach (weak Foo element in array) {
		loop_size++;
		assert (element.ref_count == 2);
		switch (loop_size) {
			case 1: assert (element == foo1); break;
			case 2: assert (element == foo2); break;
			case 3: assert (element == foo3); break;
		}
	}
	assert (loop_size == 3);

	loop_size = 0;
	foreach (Foo element in array) {
		loop_size++;
		assert (element.ref_count == 3);
		switch (loop_size) {
			case 1: assert (element == foo1); break;
			case 2: assert (element == foo2); break;
			case 3: assert (element == foo3); break;
		}
	}
	assert (loop_size == 3);
	assert (foo1.ref_count == 2);
	assert (foo2.ref_count == 2);
	assert (foo3.ref_count == 2);
}

void test_int_garray () {
	var array = new GLib.Array<int> ();
	// g_array_append_val() is a macro which uses a reference to the value parameter and thus can't use constants.
	// FIXME: allow appending constants in Vala
	int val = 1;
	array.prepend_val (val);
	val++;
	array.append_val (val);
	val++;
	array.insert_val (2, val);
	assert (array.index (0) == 1);
	assert (array.index (1) == 2);
	assert (array.index (2) == 3);
	assert (array.length == 3);
}

GLib.Array<FooStruct?> create_struct_garray () {
	var array = new GLib.Array<FooStruct?> ();
	FooStruct foo1 = { "foo", new Foo () };
	array.append_val (foo1);
	FooStruct foo2 = { "bar", new Foo () };
	array.append_val (foo2);
	return array;
}

void test_struct_garray () {
	var array = create_struct_garray ();
	assert (array.length == 2);
	assert (array.index (0).content == "foo");
	assert (array.index (0).object.ref_count == 1);
	assert (array.index (1).content == "bar");
	assert (array.index (1).object.ref_count == 1);
	Foo f = array.index (0).object;
	assert (f.ref_count == 2);
	array = null;
	assert (f.ref_count == 1);
}

void test_object_garray () {
	var foo = new Foo ();
	{
		var array = new GLib.Array<Foo> ();
		array.append_val (foo);
		assert (foo.ref_count == 2);
		array = null;
	}
	assert (foo.ref_count == 1);
	{
		var array = new GLib.Array<unowned Foo> ();
		array.append_val (foo);
		assert (foo.ref_count == 1);
		array = null;
	}
	assert (foo.ref_count == 1);
}

unowned Array<Value> check_gvalue_garray (Array<Value> vals) {
	assert (vals.index (0) == "foo");
	assert (vals.index (1) == 42);
	assert (vals.index (2) == 3.1415);
	return vals;
}

void test_gvalue_garray () {
	{
		var foo = new Array<Value> ();
		foo.append_val ("foo");
		foo.append_val (42);
		foo.append_val (3.1415);
		check_gvalue_garray (foo);
	}
	{
		Array<Value> foo = new Array<Value> ();
		foo.append_val ("foo");
		foo.append_val (42);
		foo.append_val (3.1415);
		check_gvalue_garray (foo);
	}
}

void main () {
	test_garray ();
	test_garray_foreach ();
	test_int_garray ();
	test_struct_garray ();
	test_object_garray ();
	test_gvalue_garray ();
}
