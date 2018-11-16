class Foo : Object {
}

struct MyStruct {
	string content;
	Foo object;
}

void test_garray () {
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

void test_garray_delete () {
	var array = new GLib.Array<Foo> ();
	var foo = new Foo ();
	array.append_val (foo);
	array = null;
	assert (foo.ref_count == 1);
}

void test_simpletype_garray () {
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

GLib.Array<MyStruct?> create_struct_garray () {
	var my_struct = MyStruct ();
	my_struct.content = "this is a test";
	my_struct.object = new Foo ();
	var array = new GLib.Array<MyStruct?> ();
	array.append_val (my_struct);
	return array;
}

void test_struct_garray () {
	var array = create_struct_garray ();
	assert (array.length == 1);
	assert (array.index (0).content == "this is a test");
	assert (array.index (0).object.ref_count == 1);
	Foo f = array.index (0).object;
	assert (f.ref_count == 2);
	array = null;
	assert (f.ref_count == 1);
}

void main () {
	test_garray ();
	test_simpletype_garray ();
	test_struct_garray ();
	test_garray_delete ();
}
