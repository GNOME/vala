void test_int () {
	// declaration and initialization
	int i = 42;
	assert (i == 42);

	// assignment
	i = 23;
	assert (i == 23);

	// access
	int j = i;
	assert (j == 23);

	// +
	i = 42 + 23;
	assert (i == 65);

	// -
	i = 42 - 23;
	assert (i == 19);

	// *
	i = 42 * 23;
	assert (i == 966);

	// /
	i = 42 / 23;
	assert (i == 1);

	// %
	i = 42 % 23;
	assert (i == 19);

	// <<
	i = 42 << 3;
	assert (i == 336);

	// >>
	i = 42 >> 3;
	assert (i == 5);

	// &
	i = 42 & 23;
	assert (i == 2);

	// |
	i = 42 | 23;
	assert (i == 63);

	// ^
	i = 42 ^ 23;
	assert (i == 61);

	// equality and relational
	i = 42;
	assert (i == 42);
	assert (i != 50);
	assert (i < 50);
	assert (!(i < 40));
	assert (i <= 42);
	assert (!(i <= 41));
	assert (i >= 42);
	assert (!(i >= 43));
	assert (i > 40);
	assert (!(i > 50));

	// to_string
	string s = i.to_string ();
	assert (s == "42");

	// ensure that MIN and MAX are valid values
	i = int.MIN;
	assert (i == int.MIN);
	assert (i < int.MAX);
	i = int.MAX;
	assert (i == int.MAX);
	assert (i > int.MIN);
}

void main () {
	test_int ();
}
