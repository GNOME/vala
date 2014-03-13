[CCode (array_length = false, array_null_terminated = true)]
int[] foo;

[CCode (array_length = false)]
int[] bar;

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

	// nullable elements
	int?[] d = new int?[2];
	d[0] = 10;
	d[1] = null;
	assert (d[0] == 10);
	assert (d[1] == null);
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

const int FOO = 2;
void test_static_array () {
	int a[2];
	assert (a.length == 2);
	a[1] = 23;
	assert (a[1] == 23);
	a = { 23, 34 };
	assert (a[0] == 23 && a[1] == 34);

	int b[FOO * 1 << 3];
	assert (b.length == FOO * 1 << 3);
}

void test_reference_transfer () {
	var baz = (owned) foo;
	baz = (owned) bar;

	var data = new string[]{"foo"};
	var data2 = (owned) data;
	assert (data.length == 0);
}

void test_length_assignment () {
	var a = new int[10];
	var b = new int[20,30];
	a.length = 8;
	b.length[0] = 5;
	assert (a.length == 8);
	assert (b.length[0] == 5);
}

void test_inline_array () {
	const int a[] = { 1, 2, 3 };
	assert (1 in a);
}

void main () {
	test_integer_array ();
	test_string_array ();
	test_array_pass ();
	test_static_array ();
	test_reference_transfer ();
	test_length_assignment ();
	test_inline_array ();
}
