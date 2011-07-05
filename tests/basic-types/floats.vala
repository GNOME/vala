void test_double () {
	// declaration and initialization
	double d = 42d;
	assert (d == 42d);

	// assignment
	d = 23d;
	assert (d == 23d);

	// access
	double e = d;
	assert (e == 23d);

	// +
	d = 42d + 23d;
	assert (d == 65d);

	// -
	d = 42d - 23d;
	assert (d == 19d);

	// *
	d = 42d * 23d;
	assert (d == 966d);

	// /
	d = 42d / 23d;
	assert (d > 1.8);
	assert (d < 1.9);

	// equality and relational
	d = 42d;
	assert (d == 42d);
	assert (d != 50d);
	assert (d < 42.5);
	assert (!(d < 41.5));
	assert (d <= 42d);
	assert (!(d <= 41.5));
	assert (d >= 42d);
	assert (!(d >= 42.5));
	assert (d > 41.5);
	assert (!(d > 42.5));

	// to_string
	string s = d.to_string ();
	assert (s == "42");

	// ensure that MIN and MAX are valid values
	d = double.MIN;
	assert (d == double.MIN);
	assert (d < double.MAX);
	d = double.MAX;
	assert (d == double.MAX);
	assert (d > double.MIN);

	// nullable
	double? d2 = 10;
	assert (d2 == 10);
}

void main () {
	test_double ();
}
