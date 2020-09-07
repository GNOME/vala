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

	int[]? c0 = a[0:0];
	assert (c0 == null);
	assert (c0.length == 0);

	// in expressions
	assert (23 in a);
	assert (!(-1 in a));

	// nullable elements
	int?[] d = new int?[2];
	d[0] = 10;
	d[1] = null;
	assert (d[0] == 10);
	assert (d[1] == null);

	// element assignment
	int[] e = { 13, 47 };
	e[0] = 96;
	assert (e[0] == 96);
	e[0] /= 24;
	assert (e[0] == 4);
	e[0] += 2;
	assert (e[0] == 6);
	e[0] *= 4;
	assert (e[0] == 24);
	e[0] -= 23;
	assert (e[0] == 1);
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

int[,,] nd_array_pass (int[,,] a, out int[,,] b) {
	assert (a.length[0] == 2);
	assert (a.length[1] == 2);
	assert (a.length[2] == 2);
	assert (a[1,1,0] == 7);

	b = a;
	return a;
}

void test_nd_array () {
	int[,,] a = {{{1, 2}, {3, 4}}, {{5, 6}, {7, 8}}};
	assert (a[1,0,1] == 6);

	int[,,] b, c;
	c = nd_array_pass (a, out b);
	assert (b.length[0] == 2);
	assert (b.length[1] == 2);
	assert (b.length[2] == 2);
	assert (b[0,1,0] == 3);
	assert (c.length[0] == 2);
	assert (c.length[1] == 2);
	assert (c.length[2] == 2);
	assert (c[0,1,1] == 4);

	string[,,] s = {{{"a", "b", "c"}, {"d", "e", "f"}}};
	assert (s[0,0,2] == "c");
}

[CCode (has_target = false)]
delegate int SimpleFunc ();
SimpleFunc[] simple_delegates;

int simple_func () {
	return 0;
}

void test_delegate_array () {
	SimpleFunc[] a = {};
	a = (owned) simple_delegates;
	a += (SimpleFunc) simple_func;
	assert (a.length == 1);
	assert (simple_func in a);
}

void test_void_array () {
	void*[] a = {};
	a += (void*) null;
	a += (void*) null;
	assert (a.length == 2);
	assert ((void*) null in a);
}

void test_explicit_copying () {
	int[] a0 = { 1, 2, 3};
	var a1 = a0.copy ();
	assert (a1.length == 3);
	assert (a0[1] == a1[1]);
}

void test_array_move () {
	int[] a = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
	assert (a[4] == 5);
	a.move (4, 0, 5);
	assert (a[4] == 9);
}

void test_array_resize () {
	int[] a = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
	assert (a[a.length - 1] == 9);
	a.resize (5);
	assert (a[a.length - 1] == 5);
}

struct Foo {
	unowned string array[2];
	int bar;
}

const Foo[] FOO_ARRAY_CONST = {
	{ { "foo", "bar" }, 42 },
};

struct Bar {
	public int bar;
}

struct Manam {
	Bar array[1024];
	Bar manam;
}

void test_struct_array () {
	assert (FOO_ARRAY_CONST[0].bar == 42);

	Bar b = { 4711 };
	var bar = new Bar[23];
	bar[7] = b;
	assert (b in bar);

	Manam? manam = {};
	Manam? manam_copy = manam;
}

void give_fixed_array (out int i[3]) {
	i = { 3, 4, 5 };
}

void take_fixed_array (int i[3]) {
	assert (i.length == 3);
	assert (i[1] == 2);
}

void change_fixed_array (ref int i[3]) {
	assert (i.length == 3);
	//FIXME assert (i[1] == 7);
	//FIXME i[1] = 9;
}

void test_fixed_array () {
	int i[3] = { 1, 2, 3 };
	assert (i.length == 3);
	take_fixed_array (i);

	int k[3] = { 6, 7, 8 };
	change_fixed_array (ref k);
	assert (k.length == 3);
	//FIXME assert (k[1] == 9);

	int j[3];
	give_fixed_array (out j);
	assert (j.length == 3);
	//FIXME assert (j[1] == 4);
}

void main () {
	test_integer_array ();
	test_string_array ();
	test_array_pass ();
	test_static_array ();
	test_reference_transfer ();
	test_length_assignment ();
	test_inline_array ();
	test_nd_array ();
	test_delegate_array ();
	test_void_array ();
	test_explicit_copying ();
	test_array_move ();
	test_array_resize ();
	test_struct_array ();
	test_fixed_array ();
}
