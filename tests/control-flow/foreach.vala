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

void main () {
	test_foreach_gvaluearray ();
}
