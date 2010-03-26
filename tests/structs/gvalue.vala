void test_value () {
	Value v1 = 1;
	assert (v1.get_int() == 1);

	string s = "hello";
	Value v2 = s;
	assert (v2.get_string () == s);
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

void take_value (Value v) {
}

bool make_bool () {
	return true;
}

void main () {
	test_value ();
	test_value_array ();
	test_nullable_value ();
	test_nullable_value_array ();
	take_value (make_bool ());
}
