void test_value () {
	Value v1 = 1;
	assert (v1.get_int() == 1);

	string s = "hello";
	Value v2 = s;
	assert (v2.get_string () == s);

	unowned string s2 = "world";
	Value v3 = s2;
	assert (v3.get_string () == s2);
}

void test_value_array () {
	int[] iarray = {1,2,3,4,5};
	Value[] viarray = {1,2,3,4,5};
	assert (viarray.length == iarray.length);
	for (int i = 0; i < viarray.length; i++) {
		assert (viarray[i].get_int () == iarray[i]);
	}

	string[] sarray = { "hello", "vala", "world" };
	Value[] vsarray = { "hello", "vala", "world" };
	assert (vsarray.length == sarray.length);
	for (int i = 0; i < vsarray.length; i++) {
		assert (vsarray[i].get_string () == sarray[i]);
	}
}

void test_nullable_value () {
	Value? v1 = 1;
	assert (v1.get_int() == 1);

	string s = "hello";
	Value? v2 = s;
	assert (v2.get_string () == s);

	unowned string s2 = "world";
	Value? v3 = s2;
	assert (v3.get_string () == s2);
}

void test_nullable_value_array () {
	int[] iarray = {1,2,3,4,5};
	Value?[] viarray = {1,2,3,4,5};
	assert (viarray.length == iarray.length);
	for (int i = 0; i < viarray.length; i++) {
		assert (viarray[i].get_int () == iarray[i]);
	}

	string[] sarray = { "hello", "vala", "world" };
	Value?[] vsarray = { "hello", "vala", "world" };
	assert (vsarray.length == sarray.length);
	for (int i = 0; i < vsarray.length; i++) {
		assert (vsarray[i].get_string () == sarray[i]);
	}
}

class Bar {
	public int i;
}

interface Manam : Object {
}

class Foo : Object, Manam {
	public int i;
}

void test_gtype () {
	var o = new Bar ();
	o.i = 42;
	Value vo = o;
	Bar o2 = (Bar) vo;
	assert (o2.i == 42);
}

void test_gobject () {
	var o = new Foo ();
	o.i = 42;
	Value vo = o;
	Foo o2 = (Foo) vo;
	assert (o2.i == 42);
}

void test_ginterface () {
	Manam i = new Foo ();
	((Foo) i).i = 42;
	Value vi = i;
	Manam i2 = (Manam) vi;
	assert (((Foo) i2).i == 42);
}

void take_value (Value v) {
}

bool make_bool () {
	return true;
}

struct FooStruct {
    public int i;
}

void test_try_cast_value () {
	FooStruct s = { 42 };
	Value vs = s;

	FooStruct s2 = (FooStruct) vs;
	assert (s2.i == 42);

	string[] sarray = { "hello", "vala", "world" };
	Value va = sarray;

	string[] sarray2 = (string[]) va;
	assert (sarray2[1] == "vala");

	unowned string[] sarray3 = (string[]) va;
	assert (sarray3[2] == "world");
}

void main () {
	test_value ();
	test_value_array ();
	test_nullable_value ();
	test_nullable_value_array ();
	test_gtype ();
	test_gobject ();
	test_ginterface ();
	take_value (make_bool ());
	test_try_cast_value ();
}
