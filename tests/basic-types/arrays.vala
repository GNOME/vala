void test_integer_array () {
	// declaration and initialization
	int[] a = { 42 };
	assert (a.length == 1);
	assert (a[0] == 42);

	// assignment
	a = { 42, 23 };
	assert (a.length == 2);
	assert (a[0] == 42);
	assert (a[1] == 23);

	// access
	int[] b = a;
	assert (b.length == 2);
	assert (b[0] == 42);
	assert (b[1] == 23);

	// +
	a += 11;
	assert (a.length == 3);
	assert (a[0] == 42);
	assert (a[1] == 23);
	assert (a[2] == 11);
	assert (b.length == 2);
	assert (b[0] == 42);
	assert (b[1] == 23);

	// slices
	int[] c = a[1:3];
	assert (c.length == 2);
	assert (c[0] == 23);
	assert (c[1] == 11);

	// in expressions
	assert (23 in a);
	assert (!(-1 in a));
}

void test_string_array () {
	// declaration and initialization
	string[] a = { "hello" };
	assert (a.length == 1);
	assert (a[0] == "hello");

	// assignment
	a = { "hello", "world" };
	assert (a.length == 2);
	assert (a[0] == "hello");
	assert (a[1] == "world");

	// access
	string[] b = a;
	assert (b.length == 2);
	assert (b[0] == "hello");
	assert (b[1] == "world");
}

int[] pass_helper (int[] a, out int[] b) {
	b = a;
	return { 42, 23 };
}

void test_array_pass () {
	int[] a, b;
	a = pass_helper ({ 42 }, out b);
	assert (a.length == 2);
	assert (a[0] == 42);
	assert (a[1] == 23);
	assert (b.length == 1);
	assert (b[0] == 42);
}

void main () {
	test_integer_array ();
	test_string_array ();
	test_array_pass ();
}

