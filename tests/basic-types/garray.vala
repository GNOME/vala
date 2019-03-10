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

GLib.Array<FooStruct?> create_struct_garray () {
	FooStruct foo = { "foo", new Foo () };
	var array = new GLib.Array<FooStruct?> ();
	array.append_val (foo);
	return array;
}

void test_struct_garray () {
	var array = create_struct_garray ();
	assert (array.length == 1);
	assert (array.index (0).content == "foo");
	assert (array.index (0).object.ref_count == 1);
	Foo f = array.index (0).object;
	assert (f.ref_count == 2);
	array = null;
	assert (f.ref_count == 1);
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

// GArray uses the values directly so they don't have to fit in a pointer...
void test_int64_garray () {
	var array = new GLib.Array<int64> ();
	// g_array_append_val() is a macro which uses a reference to the value parameter and thus can't use constants.
	// FIXME: allow appending constants in Vala
	int64 val = 1;
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

// ...so you can put weirdest things in it...
void test_double_garray () {
	var array = new GLib.Array<double> ();
	// g_array_append_val() is a macro which uses a reference to the value parameter and thus can't use constants.
	// FIXME: allow appending constants in Vala
	double val = 1.0;
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

// ...even nonfundamental types
GLib.Array<FooStruct> create_struct_raw_garray () {
	FooStruct foo = { "foo", new Foo () };
	var array = new GLib.Array<FooStruct> ();
	array.append_val (foo);
	return array;
}

void test_struct_raw_garray () {
	var array = create_struct_raw_garray ();
	assert (array.length == 1);
	assert (array.index (0).content == "foo");
	assert (array.index (0).object.ref_count == 1);
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

void main () {
	test_garray ();
	test_struct_garray ();
	test_int_garray ();
	test_int64_garray ();
	test_double_garray ();
	// FIXME: Nontrivial destructors of raw structures seem not to work
	//test_struct_raw_garray ();
	test_object_garray ();
}
