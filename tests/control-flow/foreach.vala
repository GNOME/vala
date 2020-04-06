void test_owned (ValueArray array) {
	uint i = 0;

	foreach (Value item in array) {
		i++;
	}

	assert (i == 3);
}

void test_unowned (ValueArray array) {
	uint i = 0;

	foreach (unowned Value item in array) {
		i++;
	}

	assert (i == 3);
}

void test_foreach_gvaluearray () {
	Value value;
	ValueArray array = new ValueArray (3);

	value = 1;
	array.append (value);
	value = 2.0;
	array.append (value);
	value = "three";
	array.append (value);

	test_owned (array);
	test_unowned (array);
}

void test_foreach_multidim_array () {
	int[,] foo = { { 1, 2 }, { 3, 4 }, { 5, 6 } };
	string result = "";
	foreach (var i in foo) {
		result += i.to_string ();
	}
	assert (result == "123456");
}

const int[] FOO = { 1, 2, 3, 4, 5, 6 };
const int BAR[] = { 6, 5, 4, 3, 2, 1 };

void test_foreach_const_array () {
	string result = "";
	foreach (var i in FOO) {
		result += i.to_string ();
	}
	assert (result == "123456");

	string result2 = "";
	foreach (var i in BAR) {
		result2 += i.to_string ();
	}
	assert (result2 == "654321");
}

void test_foreach_slice_array () {
	int[] foo = { 1, 2, 3, 4, 5, 6 };
	string result = "";
	foreach (var i in foo[1:foo.length - 1]) {
		result += i.to_string ();
	}
	assert (result == "2345");
}

void main () {
	test_foreach_gvaluearray ();
	test_foreach_const_array ();
	test_foreach_multidim_array ();
	test_foreach_slice_array ();
}
